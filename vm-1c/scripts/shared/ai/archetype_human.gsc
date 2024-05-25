#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/archetype_human_interface;
#using scripts/shared/ai/archetype_human_locomotion;
#using scripts/shared/ai/archetype_human_cover;
#using scripts/shared/ai/archetype_human_exposed;
#using scripts/shared/ai/archetype_notetracks;
#using scripts/shared/ai/archetype_human_blackboard;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_cover_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/ai_blackboard;
#using scripts/shared/util_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;

#namespace archetype_human;

// Namespace archetype_human
// Params 0, eflags: 0x2
// Checksum 0xe4a9e2c8, Offset: 0x6c8
// Size: 0xbc
function autoexec init() {
    spawner::add_archetype_spawn_function("human", &archetypehumanblackboardinit);
    spawner::add_archetype_spawn_function("human", &archetypehumaninit);
    humaninterface::registerhumaninterfaceattributes();
    clientfield::register("actor", "facial_dial", 1, 1, "int");
    /#
        level.__ai_forcegibs = getdvarint("_human_locomotion_variation");
    #/
}

// Namespace archetype_human
// Params 0, eflags: 0x5 linked
// Checksum 0x80472732, Offset: 0x790
// Size: 0x124
function private archetypehumaninit() {
    entity = self;
    aiutility::addaioverridedamagecallback(entity, &damageoverride);
    aiutility::addaioverridekilledcallback(entity, &humangibkilledoverride);
    locomotiontypes = array("alt1", "alt2", "alt3", "alt4");
    altindex = entity getentitynumber() % locomotiontypes.size;
    blackboard::setblackboardattribute(entity, "_human_locomotion_variation", locomotiontypes[altindex]);
    if (isdefined(entity.hero) && entity.hero) {
        blackboard::setblackboardattribute(entity, "_human_locomotion_variation", "alt1");
    }
}

// Namespace archetype_human
// Params 0, eflags: 0x5 linked
// Checksum 0xb6638b53, Offset: 0x8c0
// Size: 0x12c
function private archetypehumanblackboardinit() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self aiutility::function_89e1fc16();
    self blackboard::function_31efa8fd();
    self.___archetypeonanimscriptedcallback = &archetypehumanonanimscriptedcallback;
    self.___archetypeonbehavecallback = &archetypehumanonbehavecallback;
    /#
        self finalizetrackedblackboardattributes();
    #/
    self thread gameskill::function_bc280431(self);
    if (self.accuratefire) {
        self thread aiutility::preshootlaserandglinton(self);
        self thread aiutility::postshootlaserandglintoff(self);
    }
    destructserverutils::togglespawngibs(self, 1);
    gibserverutils::togglespawngibs(self, 1);
}

// Namespace archetype_human
// Params 1, eflags: 0x5 linked
// Checksum 0x48a413f9, Offset: 0x9f8
// Size: 0xdc
function private archetypehumanonbehavecallback(entity) {
    if (aiutility::function_f09741fa(entity)) {
        blackboard::setblackboardattribute(entity, "_previous_cover_mode", "cover_alert");
        blackboard::setblackboardattribute(entity, "_cover_mode", "cover_mode_none");
    }
    grenadethrowinfo = spawnstruct();
    grenadethrowinfo.grenadethrower = entity;
    blackboard::addblackboardevent("human_grenade_throw", grenadethrowinfo, randomintrange(3000, 4000));
}

// Namespace archetype_human
// Params 1, eflags: 0x5 linked
// Checksum 0x7c317abd, Offset: 0xae0
// Size: 0x84
function private archetypehumanonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypehumanblackboardinit();
    vignettemode = ai::getaiattribute(entity, "vignette_mode");
    humansoldierserverutils::vignettemodecallback(entity, "vignette_mode", vignettemode, vignettemode);
}

// Namespace archetype_human
// Params 8, eflags: 0x5 linked
// Checksum 0xcb3b9b1b, Offset: 0xb70
// Size: 0x310
function private humangibkilledoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
    entity = self;
    if (math::cointoss()) {
        return damage;
    }
    attackerdistance = 0;
    if (isdefined(attacker)) {
        attackerdistance = distancesquared(attacker.origin, entity.origin);
    }
    isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
    forcegibbing = 0;
    if (isdefined(weapon.weapclass) && weapon.weapclass == "turret") {
        forcegibbing = 1;
        if (isdefined(inflictor)) {
            isdirectexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
            iscloseexplosive = distancesquared(inflictor.origin, entity.origin) <= 60 * 60;
            if (isdirectexplosive && iscloseexplosive) {
                gibserverutils::annihilate(entity);
            }
        }
    }
    if (weapon.dogibbing && (isdefined(level.__ai_forcegibs) && (forcegibbing || isexplosive || level.__ai_forcegibs) || attackerdistance <= weapon.maxgibdistance * weapon.maxgibdistance)) {
        gibserverutils::togglespawngibs(entity, 1);
        destructserverutils::togglespawngibs(entity, 1);
        trygibbinglimb(entity, damage, hitloc, isexplosive || forcegibbing);
        trygibbinglegs(entity, damage, hitloc, isexplosive);
    }
    return damage;
}

// Namespace archetype_human
// Params 4, eflags: 0x4
// Checksum 0x8bbf3326, Offset: 0xe88
// Size: 0x9c
function private trygibbinghead(entity, damage, hitloc, isexplosive) {
    if (isexplosive) {
        gibserverutils::gibhead(entity);
        return;
    }
    if (isinarray(array("head", "neck", "helmet"), hitloc)) {
        gibserverutils::gibhead(entity);
    }
}

// Namespace archetype_human
// Params 4, eflags: 0x5 linked
// Checksum 0x47a97bbe, Offset: 0xf30
// Size: 0x1cc
function private trygibbinglimb(entity, damage, hitloc, isexplosive) {
    if (isexplosive) {
        randomchance = randomfloatrange(0, 1);
        if (randomchance < 0.5) {
            gibserverutils::gibrightarm(entity);
        } else {
            gibserverutils::gibleftarm(entity);
        }
        return;
    }
    if (isinarray(array("left_hand", "left_arm_lower", "left_arm_upper"), hitloc)) {
        gibserverutils::gibleftarm(entity);
        return;
    }
    if (isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc)) {
        gibserverutils::gibrightarm(entity);
        return;
    }
    if (isinarray(array("torso_upper"), hitloc) && math::cointoss()) {
        if (math::cointoss()) {
            gibserverutils::gibleftarm(entity);
            return;
        }
        gibserverutils::gibrightarm(entity);
    }
}

// Namespace archetype_human
// Params 5, eflags: 0x5 linked
// Checksum 0x6553b96b, Offset: 0x1108
// Size: 0x1fc
function private trygibbinglegs(entity, damage, hitloc, isexplosive, attacker) {
    if (isexplosive) {
        randomchance = randomfloatrange(0, 1);
        if (randomchance < 0.33) {
            gibserverutils::gibrightleg(entity);
        } else if (randomchance < 0.66) {
            gibserverutils::gibleftleg(entity);
        } else {
            gibserverutils::giblegs(entity);
        }
        return;
    }
    if (isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), hitloc)) {
        gibserverutils::gibleftleg(entity);
        return;
    }
    if (isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), hitloc)) {
        gibserverutils::gibrightleg(entity);
        return;
    }
    if (isinarray(array("torso_lower"), hitloc) && math::cointoss()) {
        if (math::cointoss()) {
            gibserverutils::gibleftleg(entity);
            return;
        }
        gibserverutils::gibrightleg(entity);
    }
}

// Namespace archetype_human
// Params 12, eflags: 0x1 linked
// Checksum 0xf06bd2c0, Offset: 0x1310
// Size: 0x1bc
function damageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    entity = self;
    entity destructserverutils::handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
    if (isdefined(eattacker) && !isplayer(eattacker) && !isvehicle(eattacker)) {
        dist = distancesquared(entity.origin, eattacker.origin);
        if (dist < 65536) {
            idamage = int(idamage * 10);
        } else {
            idamage = int(idamage * 1.5);
        }
    }
    if (sweapon.name == "incendiary_grenade") {
        idamage = entity.health;
    }
    return idamage;
}

#namespace humansoldierserverutils;

// Namespace humansoldierserverutils
// Params 4, eflags: 0x1 linked
// Checksum 0x1d67b7a6, Offset: 0x14d8
// Size: 0xa4
function cqbattributecallback(entity, attribute, oldvalue, value) {
    if (value) {
        entity asmchangeanimmappingtable(2);
        return;
    }
    if (entity ai::get_behavior_attribute("useAnimationOverride")) {
        entity asmchangeanimmappingtable(1);
        return;
    }
    entity asmchangeanimmappingtable(0);
}

// Namespace humansoldierserverutils
// Params 4, eflags: 0x1 linked
// Checksum 0x811187b7, Offset: 0x1588
// Size: 0x38
function forcetacticalwalkcallback(entity, attribute, oldvalue, value) {
    entity.ignorerunandgundist = value;
}

// Namespace humansoldierserverutils
// Params 4, eflags: 0x1 linked
// Checksum 0xcff08835, Offset: 0x15c8
// Size: 0x6e
function movemodeattributecallback(entity, attribute, oldvalue, value) {
    entity.ignorepathenemyfightdist = 0;
    switch (value) {
    case 41:
        break;
    case 42:
        entity.ignorepathenemyfightdist = 1;
        break;
    }
}

// Namespace humansoldierserverutils
// Params 4, eflags: 0x1 linked
// Checksum 0x95a7339e, Offset: 0x1640
// Size: 0x64
function useanimationoverridecallback(entity, attribute, oldvalue, value) {
    if (value) {
        entity asmchangeanimmappingtable(1);
        return;
    }
    entity asmchangeanimmappingtable(0);
}

// Namespace humansoldierserverutils
// Params 4, eflags: 0x1 linked
// Checksum 0x8306d905, Offset: 0x16b0
// Size: 0x1f2
function vignettemodecallback(entity, attribute, oldvalue, value) {
    switch (value) {
    case 49:
        entity.pushable = 1;
        entity function_1762804b(0);
        entity pushplayer(0);
        entity setavoidancemask("avoid all");
        entity setsteeringmode("normal steering");
        break;
    case 50:
        entity.pushable = 0;
        entity function_1762804b(0);
        entity pushplayer(1);
        entity setavoidancemask("avoid ai");
        entity setsteeringmode("vignette steering");
        break;
    case 48:
        entity.pushable = 0;
        entity function_1762804b(1);
        entity pushplayer(1);
        entity setavoidancemask("avoid none");
        entity setsteeringmode("vignette steering");
        break;
    default:
        break;
    }
}

