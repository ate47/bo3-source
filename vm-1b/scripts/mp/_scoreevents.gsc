#using scripts/codescripts/struct;
#using scripts/mp/_challenges;
#using scripts/mp/_teamops;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapon_utils;

#namespace scoreevents;

// Namespace scoreevents
// Params 0, eflags: 0x2
// Checksum 0x23a3eb68, Offset: 0x12d8
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("scoreevents", &__init__, undefined, undefined);
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0xc05a0be3, Offset: 0x1310
// Size: 0x22
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0xe8ab6451, Offset: 0x1340
// Size: 0x4a
function init() {
    level.scoreeventcallbacks = [];
    level.scoreeventgameendcallback = &ongameend;
    registerscoreeventcallback("playerKilled", &scoreeventplayerkill);
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0xba7882e3, Offset: 0x1398
// Size: 0x49
function scoreeventtablelookupint(index, scoreeventcolumn) {
    return int(tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn));
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0xbfa074ac, Offset: 0x13f0
// Size: 0x39
function scoreeventtablelookup(index, scoreeventcolumn) {
    return tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn);
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0xa27999e4, Offset: 0x1438
// Size: 0x44
function registerscoreeventcallback(callback, func) {
    if (!isdefined(level.scoreeventcallbacks[callback])) {
        level.scoreeventcallbacks[callback] = [];
    }
    level.scoreeventcallbacks[callback][level.scoreeventcallbacks[callback].size] = func;
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0x4e8ced15, Offset: 0x1488
// Size: 0x1a4a
function scoreeventplayerkill(data, time) {
    victim = data.victim;
    attacker = data.attacker;
    time = data.time;
    level.numkills++;
    attacker.lastkilledplayer = victim;
    wasdefusing = data.wasdefusing;
    wasplanting = data.wasplanting;
    victimwasonground = data.victimonground;
    attackerwasonground = data.attackeronground;
    meansofdeath = data.smeansofdeath;
    attackertraversing = data.attackertraversing;
    var_e4763e35 = data.var_e4763e35;
    var_3828b415 = data.var_3828b415;
    attackersliding = data.attackersliding;
    var_f67ec791 = data.var_f67ec791;
    var_b9995fb9 = data.var_b9995fb9;
    attackerspeedburst = data.attackerspeedburst;
    victimspeedburst = data.victimspeedburst;
    victimcombatefficieny = data.victimcombatefficieny;
    var_dc7e5b14 = data.var_dc7e5b14;
    var_8eff9c3 = data.var_8eff9c3;
    victimspeedburstlastontime = data.victimspeedburstlastontime;
    victimcombatefficiencylastontime = data.victimcombatefficiencylastontime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    attackervisionpulseactivatetime = data.attackervisionpulseactivatetime;
    victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
    attackervisionpulsearray = data.attackervisionpulsearray;
    victimvisionpulsearray = data.victimvisionpulsearray;
    attackervisionpulseoriginarray = data.attackervisionpulseoriginarray;
    victimvisionpulseoriginarray = data.victimvisionpulseoriginarray;
    attackervisionpulseorigin = data.attackervisionpulseorigin;
    victimvisionpulseorigin = data.victimvisionpulseorigin;
    attackerwasflashed = data.attackerwasflashed;
    attackerwasconcussed = data.attackerwasconcussed;
    victimwasunderwater = data.wasunderwater;
    victimheroabilityactive = data.victimheroabilityactive;
    victimheroability = data.victimheroability;
    attackerheroabilityactive = data.attackerheroabilityactive;
    attackerheroability = data.attackerheroability;
    victimelectrifiedby = data.victimelectrifiedby;
    victimwasinslamstate = data.victimwasinslamstate;
    victimbedout = data.bledout;
    victimwaslungingwitharmblades = data.victimwaslungingwitharmblades;
    if (victimbedout == 1) {
        return;
    }
    exlosivedamage = 0;
    attackershotvictim = meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
    weapon = level.weaponnone;
    inflictor = data.einflictor;
    isgrenade = 0;
    if (isdefined(data.weapon)) {
        weapon = data.weapon;
        weaponclass = util::getweaponclass(data.weapon);
        isgrenade = weapon.isgrenadeweapon;
        killstreak = killstreaks::get_from_weapon(data.weapon);
    }
    victim.anglesondeath = victim getplayerangles();
    if (meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_EXPLOSIVE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH") {
        if (weapon == level.weaponnone && isdefined(data.victim.explosiveinfo["weapon"])) {
            weapon = data.victim.explosiveinfo["weapon"];
        }
        exlosivedamage = 1;
    }
    if (!isdefined(killstreak)) {
        if (level.teambased) {
            attacker.lastkilltime = time;
            if (isdefined(victim.lastkilltime) && victim.lastkilltime > time - 3000) {
                if (isdefined(victim.lastkilledplayer) && victim.lastkilledplayer util::isenemyplayer(attacker) == 0 && attacker != victim.lastkilledplayer) {
                    processscoreevent("kill_enemy_who_killed_teammate", attacker, victim, weapon);
                    victim recordkillmodifier("avenger");
                }
            }
            if (isdefined(victim.damagedplayers)) {
                keys = getarraykeys(victim.damagedplayers);
                for (i = 0; i < keys.size; i++) {
                    key = keys[i];
                    if (key == attacker.clientid) {
                        continue;
                    }
                    if (!isdefined(victim.damagedplayers[key].entity)) {
                        continue;
                    }
                    if (attacker util::isenemyplayer(victim.damagedplayers[key].entity)) {
                        continue;
                    }
                    if (time - victim.damagedplayers[key].time < 1000) {
                        processscoreevent("kill_enemy_injuring_teammate", attacker, victim, weapon);
                        if (isdefined(victim.damagedplayers[key].entity)) {
                            victim.damagedplayers[key].entity.lastrescuedby = attacker;
                            victim.damagedplayers[key].entity.lastrescuedtime = time;
                        }
                        victim recordkillmodifier("defender");
                    }
                }
            }
        }
        if (isgrenade == 0) {
            if (var_b9995fb9 == 1) {
                if (var_3828b415 == 1) {
                    processscoreevent("kill_enemy_while_both_in_air", attacker, victim, weapon);
                }
                processscoreevent("kill_enemy_that_is_in_air", attacker, victim, weapon);
            }
            if (var_3828b415 == 1) {
                processscoreevent("kill_enemy_while_in_air", attacker, victim, weapon);
            }
            if (var_f67ec791 == 1) {
                processscoreevent("kill_enemy_that_is_wallrunning", attacker, victim, weapon);
            }
            if (var_e4763e35 == 1) {
                processscoreevent("kill_enemy_while_wallrunning", attacker, victim, weapon);
            }
            if (attackersliding == 1) {
                processscoreevent("kill_enemy_while_sliding", attacker, victim, weapon);
            }
            if (attackertraversing == 1) {
                processscoreevent("traversal_kill", attacker, victim, weapon);
            }
            if (attackerwasflashed) {
                processscoreevent("kill_enemy_while_flashbanged", attacker, victim, weapon);
            }
            if (attackerwasconcussed) {
                processscoreevent("kill_enemy_while_stunned", attacker, victim, weapon);
            }
        }
        if (attackerspeedburst == 1) {
            processscoreevent("speed_burst_kill", attacker, victim, weapon);
            attacker specialistmedalachievement();
        }
        if (victimspeedburstlastontime > time - 50) {
            processscoreevent("kill_enemy_who_is_speedbursting", attacker, victim, weapon);
        }
        if (victimcombatefficiencylastontime > time - 50) {
            processscoreevent("kill_enemy_who_is_using_focus", attacker, victim, weapon);
        }
        if (var_dc7e5b14 != 0 && var_dc7e5b14 > time - 3000) {
            processscoreevent("flashback_kill", attacker, victim, weapon);
            attacker specialistmedalachievement();
        }
        if (var_8eff9c3 != 0 && var_8eff9c3 > time - 3000) {
            processscoreevent("kill_enemy_who_has_flashbacked", attacker, victim, weapon);
        }
        if (victimwasinslamstate) {
            processscoreevent("end_enemy_gravity_spike_attack", attacker, victim, weapon);
        }
        if (isdefined(victim.explosiveinfo["throwbackKill"]) && victim.explosiveinfo["throwbackKill"] == 1) {
            processscoreevent("kill_enemy_grenade_throwback", attacker, victim, weapon);
        }
        if (challenges::ishighestscoringplayer(victim)) {
            processscoreevent("kill_enemy_who_has_high_score", attacker, victim, weapon);
        }
        if (victimwasunderwater && exlosivedamage) {
            processscoreevent("kill_underwater_enemy_explosive", attacker, victim, weapon);
        }
        if (isdefined(victimelectrifiedby) && victimelectrifiedby != attacker) {
            processscoreevent("electrified", victimelectrifiedby, victim, weapon);
        }
        if (victimvisionpulseactivatetime != 0 && victimvisionpulseactivatetime > time - 6000) {
            gadgetweapon = getweapon("gadget_vision_pulse");
            for (i = 0; i < victimvisionpulsearray.size; i++) {
                player = victimvisionpulsearray[i];
                if (player == attacker) {
                    gadget = getweapon("gadget_vision_pulse");
                    if (victimvisionpulseactivatetime + 300 > time - gadgetweapon.gadget_pulse_duration) {
                        distancetopulse = distance(victimvisionpulseoriginarray[i], victimvisionpulseorigin);
                        ratio = distancetopulse / gadgetweapon.gadget_pulse_max_range;
                        timing = ratio * gadgetweapon.gadget_pulse_duration;
                        if (victimvisionpulseactivatetime + 300 > time - timing) {
                            break;
                        }
                    }
                    processscoreevent("kill_enemy_that_pulsed_you", attacker, victim, weapon);
                    break;
                }
            }
        }
        if (attackervisionpulseactivatetime != 0 && attackervisionpulseactivatetime > time - 6000) {
            gadgetweapon = getweapon("gadget_vision_pulse");
            for (i = 0; i < attackervisionpulsearray.size; i++) {
                player = attackervisionpulsearray[i];
                if (player == victim) {
                    gadget = getweapon("gadget_vision_pulse");
                    if (attackervisionpulseactivatetime > time - gadgetweapon.gadget_pulse_duration) {
                        distancetopulse = distance(attackervisionpulseoriginarray[i], attackervisionpulseorigin);
                        ratio = distancetopulse / gadgetweapon.gadget_pulse_max_range;
                        timing = ratio * gadgetweapon.gadget_pulse_duration;
                        if (attackervisionpulseactivatetime > time - timing) {
                            break;
                        }
                    }
                    processscoreevent("vision_pulse_kill", attacker, victim, weapon);
                    attacker specialistmedalachievement();
                    break;
                }
            }
        }
        if (victimheroabilityactive && isdefined(victimheroability)) {
            switch (victimheroability.name) {
            case "gadget_armor":
                processscoreevent("kill_enemy_who_has_powerarmor", attacker, victim, weapon);
                break;
            case "gadget_resurrect":
                processscoreevent("kill_enemy_that_used_resurrect", attacker, victim, weapon);
                break;
            case "gadget_camo":
                processscoreevent("kill_enemy_that_is_using_optic_camo", attacker, victim, weapon);
                break;
            case "gadget_clone":
                processscoreevent("end_enemy_psychosis", attacker, victim, weapon);
                break;
            }
        }
        if (attackerheroabilityactive && isdefined(attackerheroability)) {
            switch (attackerheroability.name) {
            case "gadget_armor":
                processscoreevent("power_armor_kill", attacker, victim, weapon);
                attacker specialistmedalachievement();
                break;
            case "gadget_resurrect":
                processscoreevent("resurrect_kill", attacker, victim, weapon);
                attacker specialistmedalachievement();
                break;
            case "gadget_camo":
                processscoreevent("optic_camo_kill", attacker, victim, weapon);
                attacker specialistmedalachievement();
                break;
            case "gadget_clone":
                processscoreevent("kill_enemy_while_using_psychosis", attacker, victim, weapon);
                attacker specialistmedalachievement();
                break;
            }
        }
        if (victimwaslungingwitharmblades) {
            processscoreevent("killed_armblades_enemy", attacker, victim, weapon);
        }
        if (isdefined(data.victimweapon)) {
            function_2a6156(attacker, victim, weapon, data.victimweapon);
            if (data.victimweapon.name == "minigun") {
                processscoreevent("killed_death_machine_enemy", attacker, victim, weapon);
            } else if (data.victimweapon.name == "m32") {
                processscoreevent("killed_multiple_grenade_launcher_enemy", attacker, victim, weapon);
            }
            if (data.victimweapon.inventorytype == "hero") {
                if (weapon.inventorytype == "hero") {
                    attacker addplayerstat("kill_specialist_with_specialist", 1);
                }
                processscoreevent("end_enemy_specialist_weapon", attacker, victim, weapon);
            }
        }
        if (weapon.rootweapon.name == "frag_grenade") {
            attacker function_22ab88ed(victim, weapon, weaponclass, killstreak);
        }
        attacker thread updatemultikills(weapon, weaponclass, killstreak, victim);
        if (level.numkills == 1) {
            victim recordkillmodifier("firstblood");
            processscoreevent("first_kill", attacker, victim, weapon);
        } else {
            if (isdefined(attacker.lastkilledby)) {
                if (attacker.lastkilledby == victim) {
                    level.globalpaybacks++;
                    processscoreevent("revenge_kill", attacker, victim, weapon);
                    attacker addweaponstat(weapon, "revenge_kill", 1);
                    victim recordkillmodifier("revenge");
                    attacker.lastkilledby = undefined;
                }
            }
            if (victim killstreaks::is_an_a_killstreak()) {
                level.globalbuzzkills++;
                processscoreevent("stop_enemy_killstreak", attacker, victim, weapon);
                victim recordkillmodifier("buzzkill");
            }
            if (isdefined(victim.lastmansd) && victim.lastmansd == 1) {
                processscoreevent("final_kill_elimination", attacker, victim, weapon);
                if (isdefined(attacker.lastmansd) && attacker.lastmansd == 1) {
                    processscoreevent("elimination_and_last_player_alive", attacker, victim, weapon);
                }
            }
        }
        if (is_weapon_valid(meansofdeath, weapon, weaponclass, killstreak)) {
            if (isdefined(victim.vattackerorigin)) {
                attackerorigin = victim.vattackerorigin;
            } else {
                attackerorigin = attacker.origin;
            }
            disttovictim = distancesquared(victim.origin, attackerorigin);
            weap_min_dmg_range = get_distance_for_weapon(weapon, weaponclass);
            if (disttovictim > weap_min_dmg_range) {
                attacker challenges::longdistancekill();
                if (weapon.rootweapon.name == "hatchet") {
                    attacker challenges::longdistancehatchetkill();
                }
                processscoreevent("longshot_kill", attacker, victim, weapon);
                attacker addweaponstat(weapon, "longshot_kill", 1);
                attacker.pers["longshots"]++;
                attacker.longshots = attacker.pers["longshots"];
                victim recordkillmodifier("longshot");
            }
            killdistance = distance(victim.origin, attackerorigin);
            attacker.pers["kill_distances"] = attacker.pers["kill_distances"] + killdistance;
            attacker.pers["num_kill_distance_entries"]++;
        }
        if (isalive(attacker)) {
            if (attacker.health < attacker.maxhealth * 0.35) {
                attacker.lastkillwheninjured = time;
                processscoreevent("kill_enemy_when_injured", attacker, victim, weapon);
                attacker addweaponstat(weapon, "kill_enemy_when_injured", 1);
                if (attacker hasperk("specialty_bulletflinch")) {
                    attacker addplayerstat("perk_bulletflinch_kills", 1);
                }
            }
        } else if (isdefined(attacker.deathtime) && attacker.deathtime + 800 < time && !attacker isinvehicle()) {
            level.globalafterlifes++;
            processscoreevent("kill_enemy_after_death", attacker, victim, weapon);
            victim recordkillmodifier("posthumous");
        }
        if (attacker.cur_death_streak >= 3) {
            level.globalcomebacks++;
            processscoreevent("comeback_from_deathstreak", attacker, victim, weapon);
            victim recordkillmodifier("comeback");
        }
        if (isdefined(victim.beingmicrowavedby) && weapon.name != "microwave_turret") {
            if (victim.beingmicrowavedby != attacker && attacker util::isenemyplayer(victim.beingmicrowavedby) == 0) {
                scoregiven = processscoreevent("microwave_turret_assist", victim.beingmicrowavedby, victim, weapon);
                if (isdefined(scoregiven) && isdefined(victim.beingmicrowavedby)) {
                    victim.beingmicrowavedby challenges::earnedmicrowaveassistscore(scoregiven);
                }
            } else {
                attacker challenges::killwhiledamagingwithhpm();
            }
        }
        if (weapon_utils::ismeleemod(meansofdeath) && !weapon.isriotshield) {
            attacker.pers["stabs"]++;
            attacker.stabs = attacker.pers["stabs"];
            if (meansofdeath == "MOD_MELEE_WEAPON_BUTT" && weapon.name != "ball") {
                processscoreevent("kill_enemy_with_gunbutt", attacker, victim, weapon);
            } else if (weapon_utils::ispunch(weapon)) {
                processscoreevent("kill_enemy_with_fists", attacker, victim, weapon);
            } else if (weapon_utils::isknife(weapon)) {
                vangles = victim.anglesondeath[1];
                pangles = attacker.anglesonkill[1];
                anglediff = angleclamp180(vangles - pangles);
                if (anglediff > -30 && anglediff < 70) {
                    level.globalbackstabs++;
                    processscoreevent("backstabber_kill", attacker, victim, weapon);
                    attacker addweaponstat(weapon, "backstabber_kill", 1);
                    attacker.pers["backstabs"]++;
                    attacker.backstabs = attacker.pers["backstabs"];
                }
            }
        } else {
            if (isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
                if (attackershotvictim) {
                    attacker thread updateoneshotmultikills(victim, weapon, victim.firsttimedamaged);
                    attacker addweaponstat(weapon, "kill_enemy_one_bullet", 1);
                }
            }
            if (isdefined(attacker.tookweaponfrom[weapon]) && isdefined(attacker.tookweaponfrom[weapon].previousowner)) {
                pickedupweapon = attacker.tookweaponfrom[weapon];
                if (pickedupweapon.previousowner == victim) {
                    processscoreevent("kill_enemy_with_their_weapon", attacker, victim, weapon);
                    attacker addweaponstat(weapon, "kill_enemy_with_their_weapon", 1);
                    if (isdefined(pickedupweapon.weapon) && isdefined(pickedupweapon.smeansofdeath)) {
                        if (pickedupweapon.weapon == level.weaponbasemeleeheld && weapon_utils::ismeleemod(pickedupweapon.smeansofdeath)) {
                            attacker addweaponstat(level.weaponbasemeleeheld, "kill_enemy_with_their_weapon", 1);
                        }
                    }
                }
            }
        }
        if (wasdefusing) {
            processscoreevent("killed_bomb_defuser", attacker, victim, weapon);
        } else if (wasplanting) {
            processscoreevent("killed_bomb_planter", attacker, victim, weapon);
        }
        function_3ae86df1(attacker, victim, weapon);
    }
    specificweaponkill(attacker, victim, weapon, killstreak);
    if (weapon.name == "helicopter_gunner_turret_secondary" || isdefined(level.vtol) && isdefined(level.vtol.owner) && weapon.name == "helicopter_gunner_turret_tertiary") {
        processscoreevent("mothership_assist_kill", level.vtol.owner, victim, weapon);
    }
    switch (weapon.rootweapon.name) {
    case "hatchet":
        attacker.pers["tomahawks"]++;
        attacker.tomahawks = attacker.pers["tomahawks"];
        processscoreevent("hatchet_kill", attacker, victim, weapon);
        if (isdefined(data.victim.explosiveinfo["projectile_bounced"]) && data.victim.explosiveinfo["projectile_bounced"] == 1) {
            level.globalbankshots++;
            processscoreevent("bounce_hatchet_kill", attacker, victim, weapon);
        }
        break;
    case "inventory_supplydrop":
    case "inventory_supplydrop_marker":
    case "supplydrop":
    case "supplydrop_marker":
        if (meansofdeath == "MOD_HIT_BY_OBJECT" || meansofdeath == "MOD_CRUSH") {
            processscoreevent("kill_enemy_with_care_package_crush", attacker, victim, weapon);
        } else {
            processscoreevent("kill_enemy_with_hacked_care_package", attacker, victim, weapon);
        }
        break;
    }
    if (isdefined(killstreak)) {
        victim recordkillmodifier("killstreak");
    }
    attacker.cur_death_streak = 0;
    attacker disabledeathstreak();
}

// Namespace scoreevents
// Params 3, eflags: 0x0
// Checksum 0xecbe30f6, Offset: 0x2ee0
// Size: 0x142
function function_3ae86df1(attacker, victim, weapon) {
    if (!isdefined(weapon)) {
        return;
    }
    switch (weapon.name) {
    case "hero_minigun":
        event = "minigun_kill";
        break;
    case "hero_flamethrower":
        event = "flamethrower_kill";
        break;
    case "hero_lightninggun":
    case "hero_lightninggun_arc":
        event = "lightninggun_kill";
        break;
    case "hero_chemicalgelgun":
    case "hero_firefly_swarm":
        event = "gelgun_kill";
        break;
    case "hero_pineapplegun":
        event = "pineapple_kill";
        break;
    case "hero_armblade":
        event = "armblades_kill";
        break;
    case "hero_bowlauncher":
    case "hero_bowlauncher2":
    case "hero_bowlauncher3":
    case "hero_bowlauncher4":
        event = "bowlauncher_kill";
        break;
    case "hero_gravityspikes":
        event = "gravityspikes_kill";
        break;
    case "hero_annihilator":
        event = "annihilator_kill";
        break;
    default:
        return;
    }
    processscoreevent(event, attacker, victim, weapon);
}

// Namespace scoreevents
// Params 4, eflags: 0x0
// Checksum 0x71b0e6d6, Offset: 0x3030
// Size: 0x12a
function function_2a6156(attacker, victim, weapon, victim_weapon) {
    if (!isdefined(victim_weapon)) {
        return;
    }
    switch (victim_weapon.name) {
    case "hero_minigun":
        event = "killed_minigun_enemy";
        break;
    case "hero_flamethrower":
        event = "killed_flamethrower_enemy";
        break;
    case "hero_lightninggun":
    case "hero_lightninggun_arc":
        event = "killed_lightninggun_enemy";
        break;
    case "hero_chemicalgelgun":
        event = "killed_gelgun_enemy";
        break;
    case "hero_pineapplegun":
        event = "killed_pineapple_enemy";
        break;
    case "hero_bowlauncher":
    case "hero_bowlauncher2":
    case "hero_bowlauncher3":
    case "hero_bowlauncher4":
        event = "killed_bowlauncher_enemy";
        break;
    case "hero_gravityspikes":
        event = "killed_gravityspikes_enemy";
        break;
    case "hero_annihilator":
        event = "killed_annihilator_enemy";
        break;
    default:
        return;
    }
    processscoreevent(event, attacker, victim, weapon);
}

// Namespace scoreevents
// Params 4, eflags: 0x0
// Checksum 0xd534e5bc, Offset: 0x3168
// Size: 0x212
function specificweaponkill(attacker, victim, weapon, killstreak) {
    switchweapon = weapon.name;
    if (isdefined(killstreak)) {
        switchweapon = killstreak;
    }
    switch (switchweapon) {
    case "inventory_remote_missile":
    case "remote_missile":
        event = "remote_missile_kill";
        break;
    case "autoturret":
    case "inventory_autoturret":
        event = "sentry_gun_kill";
        break;
    case "inventory_planemortar":
    case "planemortar":
        event = "plane_mortar_kill";
        break;
    case "ai_tank_drop":
    case "inventory_ai_tank_drop":
        event = "aitank_kill";
        break;
    case "inventory_microwave_turret":
    case "inventory_microwaveturret":
    case "microwave_turret":
    case "microwaveturret":
        event = "microwave_turret_kill";
        break;
    case "inventory_raps":
    case "raps":
        event = "raps_kill";
        break;
    case "inventory_sentinel":
    case "sentinel":
        event = "sentinel_kill";
        break;
    case "combat_robot":
    case "inventory_combat_robot":
        event = "combat_robot_kill";
        break;
    case "inventory_rcbomb":
    case "rcbomb":
        event = "hover_rcxd_kill";
        break;
    case "helicopter_gunner":
    case "helicopter_gunner_assistant":
    case "inventory_helicopter_gunner":
    case "inventory_helicopter_gunner_assistant":
        event = "vtol_mothership_kill";
        break;
    case "helicopter_comlink":
    case "inventory_helicopter_comlink":
        event = "helicopter_comlink_kill";
        break;
    case "drone_strike":
    case "inventory_drone_strike":
        event = "drone_strike_kill";
        break;
    case "dart":
    case "dart_turret":
    case "inventory_dart":
        event = "dart_kill";
        break;
    default:
        return;
    }
    processscoreevent(event, attacker, victim, weapon);
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0x3b589eac, Offset: 0x3388
// Size: 0x92
function multikill(killcount, weapon) {
    assert(killcount > 1);
    self challenges::multikill(killcount, weapon);
    if (killcount > 8) {
        processscoreevent("multikill_more_than_8", self, undefined, weapon);
    } else {
        processscoreevent("multikill_" + killcount, self, undefined, weapon);
    }
    self recordmultikill(killcount);
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0x803ba958, Offset: 0x3428
// Size: 0x72
function multiheroabilitykill(killcount, weapon) {
    self addweaponstat(weapon, "heroability_doublekill", int(killcount / 2));
    self addweaponstat(weapon, "heroability_triplekill", int(killcount / 3));
}

// Namespace scoreevents
// Params 4, eflags: 0x0
// Checksum 0xee70ff9, Offset: 0x34a8
// Size: 0xc4
function is_weapon_valid(meansofdeath, weapon, weaponclass, killstreak) {
    valid_weapon = 0;
    if (isdefined(killstreak)) {
        valid_weapon = 0;
    } else if (get_distance_for_weapon(weapon, weaponclass) == 0) {
        valid_weapon = 0;
    } else if (meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET") {
        valid_weapon = 1;
    } else if (meansofdeath == "MOD_HEAD_SHOT") {
        valid_weapon = 1;
    } else if (weapon.rootweapon.name == "hatchet" && meansofdeath == "MOD_IMPACT") {
        valid_weapon = 1;
    }
    return valid_weapon;
}

// Namespace scoreevents
// Params 4, eflags: 0x0
// Checksum 0x47968109, Offset: 0x3578
// Size: 0xda
function function_22ab88ed(victim, weapon, weaponclass, killstreak) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"hash_22ab88ed");
    self endon(#"hash_22ab88ed");
    if (!isdefined(self.var_1b55e77a) || self.var_253ec259 != victim.explosiveinfo["damageid"]) {
        self.var_1b55e77a = 0;
    }
    self.var_253ec259 = victim.explosiveinfo["damageid"];
    self.var_1b55e77a++;
    self waittilltimeoutordeath(0.05);
    if (self.var_1b55e77a >= 2) {
        processscoreevent("frag_multikill", self, victim, weapon);
    }
    self.var_1b55e77a = 0;
}

// Namespace scoreevents
// Params 4, eflags: 0x0
// Checksum 0x2f4e62d5, Offset: 0x3660
// Size: 0x7fa
function updatemultikills(weapon, weaponclass, killstreak, victim) {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"updaterecentkills");
    self endon(#"updaterecentkills");
    baseweapon = getweapon(getreffromitemindex(getbaseweaponitemindex(weapon)));
    if (!isdefined(self.recentkillcount)) {
        self.recentkillcount = 0;
    }
    if (!isdefined(self.recentkillcountweapon) || self.recentkillcountweapon != baseweapon) {
        self.recentkillcountsameweapon = 0;
        self.recentkillcountweapon = baseweapon;
    }
    if (!isdefined(killstreak)) {
        self.recentkillcountsameweapon++;
        self.recentkillcount++;
    }
    if (!isdefined(self.recent_lmg_smg_killcount)) {
        self.recent_lmg_smg_killcount = 0;
    }
    if (!isdefined(self.recentremotemissilekillcount)) {
        self.recentremotemissilekillcount = 0;
    }
    if (!isdefined(self.var_5a43c920)) {
        self.var_5a43c920 = 0;
    }
    if (!isdefined(self.recentrcbombkillcount)) {
        self.recentrcbombkillcount = 0;
    }
    if (!isdefined(self.var_4de151b5)) {
        self.var_4de151b5 = 0;
    }
    if (!isdefined(self.recentmglkillcount)) {
        self.recentmglkillcount = 0;
    }
    if (!isdefined(self.recentanihilatorcount)) {
        self.recentanihilatorcount = 0;
    }
    if (!isdefined(self.recentminiguncount)) {
        self.recentminiguncount = 0;
    }
    if (!isdefined(self.recentbowlaunchercount)) {
        self.recentbowlaunchercount = 0;
    }
    if (!isdefined(self.recentlightningguncount)) {
        self.recentlightningguncount = 0;
    }
    if (!isdefined(self.var_a0ea7e5c)) {
        self.var_a0ea7e5c = 0;
    }
    if (!isdefined(self.recentheroabilitykillcount)) {
        self.recentheroabilitykillcount = 0;
    }
    if (!isdefined(self.recentc4killcount)) {
        self.recentc4killcount = 0;
    }
    if (!isdefined(self.recentpineappleguncount)) {
        self.recentpineappleguncount = 0;
    }
    if (!isdefined(self.recentgelguncount)) {
        self.recentgelguncount = 0;
    }
    if (!isdefined(self.recentarmbladecount)) {
        self.recentarmbladecount = 0;
    }
    if (isdefined(weaponclass)) {
        if (weaponclass == "weapon_lmg" || weaponclass == "weapon_smg") {
            if (self playerads() < 1) {
                self.recent_lmg_smg_killcount++;
            }
        }
    }
    if (weapon.name == "satchel_charge") {
        self.recentc4killcount++;
    }
    if (isdefined(weapon.isheroweapon) && weapon.isheroweapon == 1) {
        switch (weapon.name) {
        case "hero_annihilator":
            self.recentanihilatorcount++;
            break;
        case "hero_minigun":
            self.recentminiguncount++;
            break;
        case "hero_bowlauncher":
        case "hero_bowlauncher2":
        case "hero_bowlauncher3":
        case "hero_bowlauncher4":
            self.recentbowlaunchercount++;
            break;
        case "hero_gravityspikes":
            self.var_a0ea7e5c++;
            break;
        case "hero_lightninggun":
        case "hero_lightninggun_arc":
            self.recentlightningguncount++;
            break;
        case "hero_pineapple_grenade":
        case "hero_pineapplegun":
            self.recentpineappleguncount++;
            break;
        case "hero_chemicalgun":
        case "hero_firefly_swarm":
            self.recentgelguncount++;
            break;
        case "hero_armblade":
            self.recentarmbladecount++;
            break;
        }
    }
    if (isdefined(self.heroability) && isdefined(victim)) {
        if (victim ability_player::gadget_checkheroabilitykill(self)) {
            if (isdefined(self.recentheroabilitykillweapon) && self.recentheroabilitykillweapon != self.heroability) {
                self.recentheroabilitykillcount = 0;
            }
            self.recentheroabilitykillweapon = self.heroability;
            self.recentheroabilitykillcount++;
        }
    }
    if (isdefined(killstreak)) {
        switch (killstreak) {
        case "remote_missile":
            self.recentremotemissilekillcount++;
            break;
        case "rcbomb":
            self.recentrcbombkillcount++;
            break;
        case "inventory_m32":
        case "m32":
            self.recentmglkillcount++;
            break;
        }
    }
    if (self.recentkillcountsameweapon == 2) {
        self addweaponstat(weapon, "multikill_2", 1);
    } else if (self.recentkillcountsameweapon == 3) {
        self addweaponstat(weapon, "multikill_3", 1);
    }
    self waittilltimeoutordeath(4);
    if (self.recent_lmg_smg_killcount >= 3) {
        self challenges::multi_lmg_smg_kill();
    }
    if (self.recentrcbombkillcount >= 2) {
        self challenges::multi_rcbomb_kill();
    }
    if (self.recentmglkillcount >= 3) {
        self challenges::multi_mgl_kill();
    }
    if (self.recentremotemissilekillcount >= 3) {
        self challenges::multi_remotemissile_kill();
    }
    if (self.recentanihilatorcount >= 3) {
        processscoreevent("annihilator_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentminiguncount >= 3) {
        processscoreevent("minigun_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentbowlaunchercount >= 3) {
        processscoreevent("bowlauncher_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.var_a0ea7e5c >= 3) {
        processscoreevent("gravityspikes_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentlightningguncount >= 3) {
        processscoreevent("lightninggun_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentc4killcount >= 2) {
        processscoreevent("c4_multikill", self, undefined, weapon);
    }
    if (self.recentpineappleguncount >= 3) {
        processscoreevent("pineapple_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentgelguncount >= 3) {
        processscoreevent("gelgun_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentarmbladecount >= 3) {
        processscoreevent("armblades_multikill", self, undefined, weapon);
        self multikillmedalachievement();
    }
    if (self.recentkillcount > 1) {
        self multikill(self.recentkillcount, weapon);
    }
    if (self.recentheroabilitykillcount > 1) {
        self multiheroabilitykill(self.recentheroabilitykillcount, self.recentheroabilitykillweapon);
    }
    self.recentkillcount = 0;
    self.recentkillcountsameweapon = 0;
    self.recentkillcountweapon = undefined;
    self.recent_lmg_smg_killcount = 0;
    self.recentremotemissilekillcount = 0;
    self.var_5a43c920 = 0;
    self.recentrcbombkillcount = 0;
    self.recentmglkillcount = 0;
    self.recentanihilatorcount = 0;
    self.recentminiguncount = 0;
    self.recentbowlaunchercount = 0;
    self.var_a0ea7e5c = 0;
    self.recentlightningguncount = 0;
    self.recentpineappleguncount = 0;
    self.recentgelguncount = 0;
    self.recentarmbladecount = 0;
    self.recentheroabilitykillcount = 0;
    self.recentc4killcount = 0;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0xe5171545, Offset: 0x3e68
// Size: 0x16
function waittilltimeoutordeath(timeout) {
    self endon(#"death");
    wait timeout;
}

// Namespace scoreevents
// Params 3, eflags: 0x0
// Checksum 0xda9e075e, Offset: 0x3e88
// Size: 0xba
function updateoneshotmultikills(victim, weapon, firsttimedamaged) {
    self endon(#"death");
    self endon(#"disconnect");
    self notify("updateoneshotmultikills" + firsttimedamaged);
    self endon("updateoneshotmultikills" + firsttimedamaged);
    if (!isdefined(self.oneshotmultikills)) {
        self.oneshotmultikills = 0;
    }
    self.oneshotmultikills++;
    wait 1;
    if (self.oneshotmultikills > 1) {
        processscoreevent("kill_enemies_one_bullet", self, victim, weapon);
    } else {
        processscoreevent("kill_enemy_one_bullet", self, victim, weapon);
    }
    self.oneshotmultikills = 0;
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0x4e11eef0, Offset: 0x3f50
// Size: 0x11b
function get_distance_for_weapon(weapon, weaponclass) {
    distance = 0;
    if (!isdefined(weaponclass)) {
        return 0;
    }
    switch (weaponclass) {
    case "weapon_smg":
        distance = 1562500;
        break;
    case "weapon_assault":
        distance = 2250000;
        break;
    case "weapon_lmg":
        distance = 2250000;
        break;
    case "weapon_sniper":
        distance = 3062500;
        break;
    case "weapon_pistol":
        distance = 490000;
        break;
    case "weapon_cqb":
        distance = 422500;
        break;
    case "weapon_special":
        if (weapon == level.weaponballisticknife) {
            distance = 2250000;
        }
        break;
    case "weapon_grenade":
        if (weapon.rootweapon.name == "hatchet") {
            distance = 6250000;
        }
        break;
    default:
        distance = 0;
        break;
    }
    return distance;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0x39758e5d, Offset: 0x4078
// Size: 0x11a
function ongameend(data) {
    player = data.player;
    winner = data.winner;
    if (isdefined(winner)) {
        if (level.teambased) {
            if (winner != "tie" && player.team == winner) {
                processscoreevent("won_match", player);
                return;
            }
        } else {
            placement = level.placement["all"];
            topthreeplayers = min(3, placement.size);
            for (index = 0; index < topthreeplayers; index++) {
                if (level.placement["all"][index] == player) {
                    processscoreevent("won_match", player);
                    return;
                }
            }
        }
    }
    processscoreevent("completed_match", player);
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0xc13aca23, Offset: 0x41a0
// Size: 0x72
function specialistmedalachievement() {
    if (level.rankedmatch) {
        if (!isdefined(self.pers["multikillMedalAchievementCount"])) {
            self.pers["multikillMedalAchievementCount"] = 0;
        }
        self.pers["multikillMedalAchievementCount"]++;
        if (self.pers["multikillMedalAchievementCount"] >= 5) {
            self giveachievement("MP_SPECIALIST_MEDALS");
        }
    }
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0x6defcdcf, Offset: 0x4220
// Size: 0x22
function multikillmedalachievement() {
    if (level.rankedmatch) {
        self giveachievement("MP_MULTI_KILL_MEDALS");
    }
}

