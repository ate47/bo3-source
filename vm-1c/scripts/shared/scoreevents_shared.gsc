#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/callbacks_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace scoreevents;

// Namespace scoreevents
// Params 4, eflags: 0x0
// Checksum 0x96ec284d, Offset: 0x2b0
// Size: 0x3c8
function processscoreevent(event, player, victim, weapon) {
    pixbeginevent("processScoreEvent");
    scoregiven = 0;
    if (!isplayer(player)) {
        assertmsg("<dev string:x28>" + event);
        return scoregiven;
    }
    if (getdvarint("teamOpsEnabled") == 1) {
        if (isdefined(level.var_2dfc4869)) {
            level [[ level.var_2dfc4869 ]](event, player);
        }
    }
    if (isdefined(level.challengesoneventreceived)) {
        player thread [[ level.challengesoneventreceived ]](event);
    }
    if (!sessionmodeiszombiesgame() || isregisteredevent(event) && level.onlinegame) {
        var_33da1df7 = 0;
        if (!isdefined(weapon) || !killstreaks::is_killstreak_weapon(weapon)) {
            var_33da1df7 = 1;
        } else {
            var_33da1df7 = function_f8c7e604(event);
        }
        if (var_33da1df7) {
            if (isdefined(level.scoreongiveplayerscore)) {
                scoregiven = [[ level.scoreongiveplayerscore ]](event, player, victim, undefined, weapon);
                isscoreevent = scoregiven > 0;
                if (isscoreevent) {
                    var_ce8a30c7 = function_9b69b9d6(event);
                    player ability_power::power_gain_event_score(victim, scoregiven, weapon, var_ce8a30c7);
                }
            }
        }
    }
    if (shouldaddrankxp(player) && getdvarint("teamOpsEnabled") == 0) {
        pickedup = 0;
        if (isdefined(weapon) && isdefined(player.pickedupweapons) && isdefined(player.pickedupweapons[weapon])) {
            pickedup = 1;
        }
        if (sessionmodeiscampaigngame()) {
            xp_difficulty_multiplier = player gameskill::function_684ec97e();
        } else {
            xp_difficulty_multiplier = 1;
        }
        player addrankxp(event, weapon, player.class_num, pickedup, isscoreevent, xp_difficulty_multiplier);
    }
    pixendevent();
    if (sessionmodeiscampaigngame() && isdefined(xp_difficulty_multiplier)) {
        if (isdefined(victim) && isdefined(victim.team)) {
            if (victim.team == "axis" || victim.team == "team3") {
                scoregiven *= xp_difficulty_multiplier;
            }
        }
    }
    return scoregiven;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0x81884cba, Offset: 0x680
// Size: 0xa4
function shouldaddrankxp(player) {
    if (sessionmodeiscampaignzombiesgame()) {
        return false;
    }
    if (level.gametype == "fr") {
        return false;
    }
    if (!isdefined(level.rankcap) || level.rankcap == 0) {
        return true;
    }
    if (player.pers["plevel"] > 0 || player.pers["rank"] > level.rankcap) {
        return false;
    }
    return true;
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0xe2352c0a, Offset: 0x730
// Size: 0x64
function uninterruptedobitfeedkills(attacker, weapon) {
    self endon(#"disconnect");
    wait 0.1;
    util::waittillslowprocessallowed();
    wait 0.1;
    processscoreevent("uninterrupted_obit_feed_kills", attacker, self, weapon);
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0x2ba82723, Offset: 0x7a0
// Size: 0x2c
function isregisteredevent(type) {
    if (isdefined(level.scoreinfo[type])) {
        return 1;
    }
    return 0;
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0x2107d27e, Offset: 0x7d8
// Size: 0x3c
function decrementlastobituaryplayercountafterfade() {
    level endon(#"reset_obituary_count");
    wait 5;
    level.lastobituaryplayercount--;
    assert(level.lastobituaryplayercount >= 0);
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0x95f44f5, Offset: 0x820
// Size: 0x4c
function getscoreeventtablename() {
    if (sessionmodeiscampaigngame()) {
        return "gamedata/tables/cp/scoreInfo.csv";
    }
    if (sessionmodeiszombiesgame()) {
        return "gamedata/tables/zm/scoreInfo.csv";
    }
    return "gamedata/tables/mp/scoreInfo.csv";
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0xe86d5f70, Offset: 0x878
// Size: 0x98
function getscoreeventtableid() {
    scoreinfotableloaded = 0;
    scoreinfotableid = tablelookupfindcoreasset(getscoreeventtablename());
    if (isdefined(scoreinfotableid)) {
        scoreinfotableloaded = 1;
    }
    assert(scoreinfotableloaded, "<dev string:x58>" + getscoreeventtablename());
    return scoreinfotableid;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0xb9267f2c, Offset: 0x918
// Size: 0x6a
function function_575986e3(gametype) {
    var_52343cb6 = function_7d1547d7(gametype);
    assert(var_52343cb6 >= 0);
    if (var_52343cb6 >= 0) {
        var_52343cb6 += 0;
    }
    return var_52343cb6;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0xd5027df8, Offset: 0x990
// Size: 0x6c
function function_6dd97e6b(gametype) {
    var_52343cb6 = function_7d1547d7(gametype);
    assert(var_52343cb6 >= 0);
    if (var_52343cb6 >= 0) {
        var_52343cb6 += 1;
    }
    return var_52343cb6;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0xb0dffb9e, Offset: 0xa08
// Size: 0x138
function function_7d1547d7(gametype) {
    var_410de38c = 0;
    if (!isdefined(level.var_76febf72)) {
        level.var_76febf72 = getscoreeventtableid();
    }
    assert(isdefined(level.var_76febf72));
    if (!isdefined(level.var_76febf72)) {
        return -1;
    }
    for (var_75c035a0 = 14; ; var_75c035a0 += 2) {
        var_b932b005 = tablelookupcolumnforrow(level.var_76febf72, 0, var_75c035a0);
        if (var_b932b005 == "") {
            var_75c035a0 = 14;
            break;
        }
        if (var_b932b005 == level.gametype + " score") {
            var_410de38c = 1;
            break;
        }
    }
    assert(var_410de38c, "<dev string:x7a>" + gametype);
    return var_75c035a0;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0xbc263923, Offset: 0xb48
// Size: 0x7a
function function_f8c7e604(type) {
    if (getdvarint("teamOpsEnabled") == 1) {
        return 0;
    }
    if (isdefined(level.scoreinfo[type]["allowKillstreakWeapons"]) && level.scoreinfo[type]["allowKillstreakWeapons"] == 1) {
        return 1;
    }
    return 0;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0x14c99e5b, Offset: 0xbd0
// Size: 0x54
function function_9b69b9d6(event) {
    if (!isdefined(level.scoreinfo[event]["allow_hero"]) || level.scoreinfo[event]["allow_hero"] != 1) {
        return true;
    }
    return false;
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0x389972ed, Offset: 0xc30
// Size: 0x1ec
function givecratecapturemedal(crate, capturer) {
    if (isdefined(crate) && isdefined(capturer) && isdefined(crate.owner) && isplayer(crate.owner)) {
        if (level.teambased) {
            if (capturer.team != crate.owner.team) {
                crate.owner playlocalsound("mpl_crate_enemy_steals");
                if (!isdefined(crate.hacker)) {
                    processscoreevent("capture_enemy_crate", capturer);
                }
            } else if (isdefined(crate.owner) && capturer != crate.owner) {
                crate.owner playlocalsound("mpl_crate_friendly_steals");
                if (!isdefined(crate.hacker)) {
                    level.globalsharepackages++;
                    processscoreevent("share_care_package", crate.owner);
                }
            }
            return;
        }
        if (capturer != crate.owner) {
            crate.owner playlocalsound("mpl_crate_enemy_steals");
            if (!isdefined(crate.hacker)) {
                processscoreevent("capture_enemy_crate", capturer);
            }
        }
    }
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0x7417fa2f, Offset: 0xe28
// Size: 0x3a
function register_hero_ability_kill_event(event_func) {
    if (!isdefined(level.hero_ability_kill_events)) {
        level.hero_ability_kill_events = [];
    }
    level.hero_ability_kill_events[level.hero_ability_kill_events.size] = event_func;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0x8fbb5a80, Offset: 0xe70
// Size: 0x3a
function register_hero_ability_multikill_event(event_func) {
    if (!isdefined(level.hero_ability_multikill_events)) {
        level.hero_ability_multikill_events = [];
    }
    level.hero_ability_multikill_events[level.hero_ability_multikill_events.size] = event_func;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0x76e4f673, Offset: 0xeb8
// Size: 0x3a
function register_hero_weapon_multikill_event(event_func) {
    if (!isdefined(level.hero_weapon_multikill_events)) {
        level.hero_weapon_multikill_events = [];
    }
    level.hero_weapon_multikill_events[level.hero_weapon_multikill_events.size] = event_func;
}

// Namespace scoreevents
// Params 1, eflags: 0x0
// Checksum 0x90f82b17, Offset: 0xf00
// Size: 0x3a
function register_thief_shutdown_enemy_event(event_func) {
    if (!isdefined(level.thief_shutdown_enemy_events)) {
        level.thief_shutdown_enemy_events = [];
    }
    level.thief_shutdown_enemy_events[level.thief_shutdown_enemy_events.size] = event_func;
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0x33bad423, Offset: 0xf48
// Size: 0xb4
function hero_ability_kill_event(ability, victim_ability) {
    if (!isdefined(level.hero_ability_kill_events)) {
        return;
    }
    foreach (event_func in level.hero_ability_kill_events) {
        if (isdefined(event_func)) {
            self [[ event_func ]](ability, victim_ability);
        }
    }
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0xd58684a, Offset: 0x1008
// Size: 0xb4
function hero_ability_multikill_event(killcount, ability) {
    if (!isdefined(level.hero_ability_multikill_events)) {
        return;
    }
    foreach (event_func in level.hero_ability_multikill_events) {
        if (isdefined(event_func)) {
            self [[ event_func ]](killcount, ability);
        }
    }
}

// Namespace scoreevents
// Params 2, eflags: 0x0
// Checksum 0x52be2291, Offset: 0x10c8
// Size: 0xb4
function hero_weapon_multikill_event(killcount, weapon) {
    if (!isdefined(level.hero_weapon_multikill_events)) {
        return;
    }
    foreach (event_func in level.hero_weapon_multikill_events) {
        if (isdefined(event_func)) {
            self [[ event_func ]](killcount, weapon);
        }
    }
}

// Namespace scoreevents
// Params 0, eflags: 0x0
// Checksum 0x34ff785a, Offset: 0x1188
// Size: 0x9c
function thief_shutdown_enemy_event() {
    if (!isdefined(level.thief_shutdown_enemy_event)) {
        return;
    }
    foreach (event_func in level.thief_shutdown_enemy_event) {
        if (isdefined(event_func)) {
            self [[ event_func ]]();
        }
    }
}

