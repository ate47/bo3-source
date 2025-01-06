#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_wager;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/weapons/_weapon_utils;

#namespace sas;

// Namespace sas
// Params 0, eflags: 0x0
// Checksum 0xd872c292, Offset: 0x418
// Size: 0x28d
function main() {
    globallogic::init();
    level.weapon_sas_primary_weapon = getweapon("ar_accurate");
    level.weapon_sas_secondary_weapon = level.weaponballisticknife;
    level.weapon_sas_primary_grenade_weapon = getweapon("hatchet");
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 5000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    level.onstartgametype = &onstartgametype;
    level.onplayerdamage = &onplayerdamage;
    level.onplayerkilled = &onplayerkilled;
    level.var_8619115e = &function_8619115e;
    level.pointsperprimarykill = getgametypesetting("pointsPerPrimaryKill");
    level.pointspersecondarykill = getgametypesetting("pointsPerSecondaryKill");
    level.pointsperprimarygrenadekill = getgametypesetting("pointsPerPrimaryGrenadeKill");
    level.pointspermeleekill = getgametypesetting("pointsPerMeleeKill");
    level.setbacks = getgametypesetting("setbacks");
    switch (getgametypesetting("gunSelection")) {
    case 0:
        level.setbackweapon = undefined;
        break;
    case 1:
        level.setbackweapon = level.weapon_sas_primary_grenade_weapon;
        break;
    case 2:
        level.setbackweapon = level.weapon_sas_primary_weapon;
        break;
    case 3:
        level.setbackweapon = level.weapon_sas_secondary_weapon;
        break;
    default:
        assert(1, "<dev string:x28>");
        break;
    }
    InvalidOpCode(0xc8, "dialog", "gametype", "sns_start");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace sas
// Params 0, eflags: 0x0
// Checksum 0x3279cf47, Offset: 0x758
// Size: 0x16c
function givecustomloadout() {
    self notify(#"hash_8fb75c18");
    defaultweapon = level.weapon_sas_primary_weapon;
    self wager::function_937040bd(1, 1, defaultweapon);
    self giveweapon(defaultweapon);
    self setweaponammoclip(defaultweapon, 3);
    self setweaponammostock(defaultweapon, 3);
    secondaryweapon = level.weapon_sas_secondary_weapon;
    self giveweapon(secondaryweapon);
    self setweaponammostock(secondaryweapon, 2);
    offhandprimary = level.weapon_sas_primary_grenade_weapon;
    self setoffhandprimaryclass(offhandprimary);
    self giveweapon(offhandprimary);
    self setweaponammoclip(offhandprimary, 1);
    self setweaponammostock(offhandprimary, 1);
    self giveweapon(level.weaponbasemelee);
    self switchtoweapon(defaultweapon);
    self setspawnweapon(defaultweapon);
    self.killswithsecondary = 0;
    self.killswithprimary = 0;
    self.killswithbothawarded = 0;
    return defaultweapon;
}

// Namespace sas
// Params 10, eflags: 0x0
// Checksum 0xfcd59908, Offset: 0x8d0
// Size: 0xe0
function onplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (weapon == level.weapon_sas_primary_weapon && smeansofdeath == "MOD_IMPACT") {
        if (isdefined(eattacker) && isplayer(eattacker)) {
            if (!isdefined(eattacker.pers["sticks"])) {
                eattacker.pers["sticks"] = 1;
            } else {
                eattacker.pers["sticks"]++;
            }
            eattacker.sticks = eattacker.pers["sticks"];
        }
    }
    return idamage;
}

// Namespace sas
// Params 9, eflags: 0x0
// Checksum 0xc170b3dc, Offset: 0x9b8
// Size: 0x2fa
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(attacker) && isplayer(attacker) && attacker != self) {
        if (weapon_utils::ismeleemod(smeansofdeath)) {
            attacker globallogic_score::givepointstowin(level.pointspermeleekill);
        } else if (weapon == level.weapon_sas_primary_weapon) {
            attacker.killswithprimary++;
            if (attacker.killswithbothawarded == 0 && attacker.killswithsecondary > 0) {
                attacker.killswithbothawarded = 1;
            }
            attacker globallogic_score::givepointstowin(level.pointsperprimarykill);
        } else if (weapon == level.weapon_sas_primary_grenade_weapon) {
            attacker globallogic_score::givepointstowin(level.pointsperprimarygrenadekill);
        } else {
            if (weapon == level.weapon_sas_secondary_weapon) {
                attacker.killswithsecondary++;
                if (attacker.killswithbothawarded == 0 && attacker.killswithprimary > 0) {
                    attacker.killswithbothawarded = 1;
                }
            }
            attacker globallogic_score::givepointstowin(level.pointspersecondarykill);
        }
        if (isdefined(level.setbackweapon) && weapon == level.setbackweapon) {
            self.pers["humiliated"]++;
            self.humiliated = self.pers["humiliated"];
            if (level.setbacks == 0) {
                self globallogic_score::setpointstowin(0);
            } else {
                self globallogic_score::givepointstowin(level.setbacks * -1);
            }
            InvalidOpCode(0x54, "dialog", "wm_humiliation");
            // Unknown operator (0x54, t7_1b, PC)
        }
        return;
    }
    self.pers["humiliated"]++;
    self.humiliated = self.pers["humiliated"];
    if (level.setbacks == 0) {
        self globallogic_score::setpointstowin(0);
    } else {
        self globallogic_score::givepointstowin(level.setbacks * -1);
    }
    self thread wager::function_972d1b69(%MP_HUMILIATED, 0, %MP_BANKRUPTED, "wm_humiliated");
    InvalidOpCode(0x54, "dialog", "wm_humiliated");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sas
// Params 0, eflags: 0x0
// Checksum 0xd3602d55, Offset: 0xcc0
// Size: 0x2a9
function onstartgametype() {
    setdvar("scr_xpscale", 0);
    setclientnamemode("auto_change");
    util::setobjectivetext("allies", %OBJECTIVES_SAS);
    util::setobjectivetext("axis", %OBJECTIVES_SAS);
    if (level.splitscreen) {
        util::setobjectivescoretext("allies", %OBJECTIVES_SAS);
        util::setobjectivescoretext("axis", %OBJECTIVES_SAS);
    } else {
        util::setobjectivescoretext("allies", %OBJECTIVES_SAS_SCORE);
        util::setobjectivescoretext("axis", %OBJECTIVES_SAS_SCORE);
    }
    util::setobjectivehinttext("allies", %OBJECTIVES_SAS_HINT);
    util::setobjectivehinttext("axis", %OBJECTIVES_SAS_HINT);
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    newspawns = getentarray("mp_wager_spawn", "classname");
    if (newspawns.size > 0) {
        spawnlogic::add_spawn_points("allies", "mp_wager_spawn");
        spawnlogic::add_spawn_points("axis", "mp_wager_spawn");
    } else {
        spawnlogic::add_spawn_points("allies", "mp_dm_spawn");
        spawnlogic::add_spawn_points("axis", "mp_dm_spawn");
    }
    spawning::updateallspawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.usestartspawns = 0;
    level.displayroundendtext = 0;
    InvalidOpCode(0x54, "roundsplayed");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace sas
// Params 0, eflags: 0x0
// Checksum 0x3c358d31, Offset: 0xfb8
// Size: 0xda
function function_8619115e() {
    tomahawks = self globallogic_score::getpersstat("tomahawks");
    if (!isdefined(tomahawks)) {
        tomahawks = 0;
    }
    self persistence::function_2eb5e93("wagerAwards", tomahawks, 0);
    sticks = self globallogic_score::getpersstat("sticks");
    if (!isdefined(sticks)) {
        sticks = 0;
    }
    self persistence::function_2eb5e93("wagerAwards", sticks, 1);
    bestkillstreak = self globallogic_score::getpersstat("best_kill_streak");
    if (!isdefined(bestkillstreak)) {
        bestkillstreak = 0;
    }
    self persistence::function_2eb5e93("wagerAwards", bestkillstreak, 2);
}

