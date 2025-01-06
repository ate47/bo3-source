#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace namespace_fba031c8;

// Namespace namespace_fba031c8
// Params 0, eflags: 0x0
// Checksum 0xbd82c152, Offset: 0x5c0
// Size: 0x192
function init() {
    level.doa.var_2b941d3f = array(getweapon("zombietron_deathmachine"), getweapon("zombietron_deathmachine_1"), getweapon("zombietron_deathmachine_2"), getweapon("zombietron_shotgun"), getweapon("zombietron_shotgun_1"), getweapon("zombietron_shotgun_2"), getweapon("zombietron_rpg_1"), getweapon("zombietron_rpg_2"), getweapon("zombietron_nightfury"));
    level.doa.var_1a7175b1 = array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTIVLE_SPLASH", "MOD_EXPLOSIVE");
    level.doa.hitlocs = array("left_hand", "left_arm_lower", "left_arm_upper", "right_hand", "right_arm_lower", "right_arm_upper");
}

// Namespace namespace_fba031c8
// Params 2, eflags: 0x0
// Checksum 0xd240e64a, Offset: 0x760
// Size: 0xda
function function_ddf685e8(launchvector, attacker) {
    if (!isdefined(self)) {
        return;
    }
    if (!isactor(self)) {
        return;
    }
    if (isdefined(self.boss) && self.boss) {
        return;
    }
    gibserverutils::giblegs(self);
    self.becomecrawler = 1;
    self clientfield::set("zombie_saw_explosion", 1);
    assert(!(isdefined(self.boss) && self.boss));
    self startragdoll();
    self setplayercollision(0);
    if (isdefined(launchvector)) {
        self launchragdoll(launchvector);
    }
}

// Namespace namespace_fba031c8
// Params 0, eflags: 0x0
// Checksum 0x364ce90b, Offset: 0x848
// Size: 0x12
function function_7b3e39cb() {
    gibserverutils::annihilate(self);
}

// Namespace namespace_fba031c8
// Params 1, eflags: 0x0
// Checksum 0x381b46b, Offset: 0x868
// Size: 0xb2
function function_45dffa6b(launchvector) {
    if (!isdefined(self)) {
        return;
    }
    if (!isactor(self)) {
        return;
    }
    assert(!(isdefined(self.boss) && self.boss));
    self clientfield::set("zombie_gut_explosion", 1);
    self startragdoll();
    self setplayercollision(0);
    if (isdefined(launchvector)) {
        self launchragdoll(launchvector);
        self thread namespace_1a381543::function_90118d8c("zmb_ragdoll_launched");
    }
}

// Namespace namespace_fba031c8
// Params 0, eflags: 0x0
// Checksum 0xa0f1cd18, Offset: 0x928
// Size: 0x7a
function function_deb7df37() {
    self endon(#"death");
    if (self.animname == "quad_zombie") {
        return;
    }
    if (randomint(100) < 50) {
        wait randomfloatrange(0.53, 1);
        gibserverutils::gibhead(self);
        return;
    }
    self thread namespace_eaa992c::function_285a2999("tesla_shock_eyes");
}

// Namespace namespace_fba031c8
// Params 4, eflags: 0x0
// Checksum 0x89f18662, Offset: 0x9b0
// Size: 0x122
function trygibbinghead(entity, damage, hitloc, isexplosive) {
    if (!gibserverutils::isgibbed(entity, 8)) {
        return;
    }
    if (isexplosive && randomfloatrange(0, 1) <= 0.5) {
        gibserverutils::gibhead(entity);
        return;
    }
    if (isinarray(array("head", "neck", "helmet"), hitloc) && randomfloatrange(0, 1) <= 1) {
        gibserverutils::gibhead(entity);
        return;
    }
    if (entity.health - damage <= 0 && randomfloatrange(0, 1) <= 0.25) {
        gibserverutils::gibhead(entity);
    }
}

// Namespace namespace_fba031c8
// Params 4, eflags: 0x0
// Checksum 0xd2522e58, Offset: 0xae0
// Size: 0x29a
function trygibbinglimb(entity, damage, hitloc, isexplosive) {
    if (!isdefined(isexplosive)) {
        isexplosive = 0;
    }
    if (!isdefined(hitloc)) {
        hitloc = level.doa.hitlocs[randomint(level.doa.hitlocs.size)];
    }
    if (isexplosive && randomfloatrange(0, 1) <= 0.35) {
        if (entity.health - damage <= 0 && entity.allowdeath && math::cointoss()) {
            if (!gibserverutils::isgibbed(entity, 16)) {
                gibserverutils::gibrightarm(entity);
            }
        } else if (!gibserverutils::isgibbed(entity, 32)) {
            gibserverutils::gibleftarm(entity);
        }
        return;
    }
    if (isinarray(array("left_hand", "left_arm_lower", "left_arm_upper"), hitloc)) {
        if (!gibserverutils::isgibbed(entity, 32)) {
            gibserverutils::gibleftarm(entity);
        }
        return;
    }
    if (entity.health - damage <= 0 && entity.allowdeath && isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc)) {
        gibserverutils::gibrightarm(entity);
        return;
    }
    if (entity.health - damage <= 0 && entity.allowdeath && randomfloatrange(0, 1) <= 0.45) {
        if (math::cointoss()) {
            if (!gibserverutils::isgibbed(entity, 32)) {
                gibserverutils::gibleftarm(entity);
            }
            return;
        }
        if (!gibserverutils::isgibbed(entity, 16)) {
            gibserverutils::gibrightarm(entity);
        }
    }
}

// Namespace namespace_fba031c8
// Params 5, eflags: 0x0
// Checksum 0x41ff2ea1, Offset: 0xd88
// Size: 0x39a
function trygibbinglegs(entity, damage, hitloc, isexplosive, attacker) {
    if (!isdefined(isexplosive)) {
        isexplosive = 0;
    }
    if (!isdefined(attacker)) {
        attacker = entity;
    }
    if (!isdefined(hitloc)) {
        hitloc = level.doa.hitlocs[randomint(level.doa.hitlocs.size)];
    }
    cangiblegs = entity.health - damage <= 0 && entity.allowdeath;
    cangiblegs = (entity.health - damage) / entity.maxhealth <= 0.25 && distancesquared(entity.origin, attacker.origin) <= 600 * 600 && (cangiblegs || entity.allowdeath);
    if (entity.health - damage <= 0 && entity.allowdeath && isexplosive && randomfloatrange(0, 1) <= 0.5) {
        if (!gibserverutils::isgibbed(entity, 384)) {
            gibserverutils::giblegs(entity);
        }
        assert(!(isdefined(entity.boss) && entity.boss));
        entity startragdoll();
        return;
    }
    if (cangiblegs && isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), hitloc) && randomfloatrange(0, 1) <= 1) {
        if (entity.health - damage > 0) {
            entity.becomecrawler = 1;
        }
        if (!gibserverutils::isgibbed(entity, 256)) {
            gibserverutils::gibleftleg(entity);
        }
        return;
    }
    if (cangiblegs && isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), hitloc) && randomfloatrange(0, 1) <= 1) {
        if (entity.health - damage > 0) {
            entity.becomecrawler = 1;
        }
        if (!gibserverutils::isgibbed(entity, -128)) {
            gibserverutils::gibrightleg(entity);
        }
        return;
    }
    if (entity.health - damage <= 0 && entity.allowdeath && randomfloatrange(0, 1) <= 0.25) {
        if (math::cointoss()) {
            if (!gibserverutils::isgibbed(entity, 256)) {
                gibserverutils::gibleftleg(entity);
            }
            return;
        }
        if (!gibserverutils::isgibbed(entity, -128)) {
            gibserverutils::gibrightleg(entity);
        }
    }
}

// Namespace namespace_fba031c8
// Params 6, eflags: 0x0
// Checksum 0x83943904, Offset: 0x1130
// Size: 0x192
function function_15a268a6(attacker, damage, meansofdeath, weapon, hitloc, vdir) {
    if (!isactor(self)) {
        return;
    }
    if (self.archetype != "zombie") {
        return;
    }
    if (meansofdeath == "MOD_BURNED") {
        return;
    }
    self endon(#"death");
    isexplosive = isinarray(level.doa.var_1a7175b1, meansofdeath);
    trygibbinglimb(self, damage, hitloc, isexplosive);
    trygibbinglegs(self, damage, hitloc, isexplosive, attacker);
    if (damage > self.health && gettime() > self.birthtime) {
        if (isinarray(level.doa.var_2b941d3f, weapon)) {
            self clientfield::increment("zombie_chunk");
        }
        if (weapon == level.doa.var_ccb54987 || weapon == level.doa.var_69899304) {
            trygibbinghead(self, damage, hitloc, isexplosive);
            self clientfield::set("zombie_rhino_explosion", 1);
        }
        if (weapon.doannihilate) {
            self function_7b3e39cb();
        }
    }
}

