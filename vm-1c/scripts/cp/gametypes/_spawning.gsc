#using scripts/cp/_callbacks;
#using scripts/cp/_laststand;
#using scripts/cp/_tacticalinsertion;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_tacticalinsertion;

#namespace spawning;

// Namespace spawning
// Params 0, eflags: 0x2
// Checksum 0x540fc76f, Offset: 0x3d0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("spawning", &__init__, undefined, undefined);
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xb3039495, Offset: 0x410
// Size: 0x1ec
function __init__() {
    level init_spawn_system();
    level.recently_deceased = [];
    foreach (team in level.teams) {
        level.recently_deceased[team] = util::spawn_array_struct();
    }
    callback::on_connecting(&onplayerconnect);
    level.spawnprotectiontime = getgametypesetting("spawnprotectiontime");
    level.spawnprotectiontimems = int((isdefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000);
    /#
        setdvar("<dev string:x28>", "<dev string:x3f>");
        setdvar("<dev string:x40>", "<dev string:x5c>");
        setdvar("<dev string:x5e>", "<dev string:x7c>");
        setdvar("<dev string:x7e>", "<dev string:x7c>");
        level.test_spawn_point_index = 0;
        setdvar("<dev string:x98>", "<dev string:x5c>");
    #/
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x9a62a900, Offset: 0x608
// Size: 0x1b2
function init_spawn_system() {
    level.spawnsystem = spawnstruct();
    spawnsystem = level.spawnsystem;
    if (!isdefined(spawnsystem.unifiedsideswitching)) {
        spawnsystem.unifiedsideswitching = 1;
    }
    spawnsystem.objective_facing_bonus = 0;
    spawnsystem.ispawn_teammask = [];
    spawnsystem.ispawn_teammask_free = 1;
    spawnsystem.ispawn_teammask["free"] = spawnsystem.ispawn_teammask_free;
    all = spawnsystem.ispawn_teammask_free;
    count = 1;
    foreach (team in level.teams) {
        spawnsystem.ispawn_teammask[team] = 1 << count;
        all |= spawnsystem.ispawn_teammask[team];
        count++;
    }
    spawnsystem.ispawn_teammask["all"] = all;
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x8581fb98, Offset: 0x7c8
// Size: 0x6c
function onplayerconnect() {
    level endon(#"game_ended");
    self setentertime(gettime());
    self thread onplayerspawned();
    self thread onteamchange();
    self thread ongrenadethrow();
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x74004cda, Offset: 0x840
// Size: 0x110
function onplayerspawned() {
    self endon(#"disconnect");
    self endon(#"killspawnmonitor");
    level endon(#"game_ended");
    self flag::init("player_has_red_flashing_overlay");
    self flag::init("player_is_invulnerable");
    for (;;) {
        self waittill(#"spawned_player");
        if (isdefined(self.pers["hasRadar"]) && self.pers["hasRadar"]) {
            self.hasspyplane = 1;
        }
        self enable_player_influencers(1);
        self thread gameskill::playerhealthregen();
        self thread ondeath();
        self laststand::revive_hud_create();
    }
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xcb9a2035, Offset: 0x958
// Size: 0x7c
function ondeath() {
    self endon(#"disconnect");
    self endon(#"killspawnmonitor");
    level endon(#"game_ended");
    self waittill(#"death");
    self enable_player_influencers(0);
    level create_friendly_influencer("friend_dead", self.origin, self.team);
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x532d9359, Offset: 0x9e0
// Size: 0x60
function onteamchange() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self endon(#"hash_7b1c9d84");
    while (true) {
        self waittill(#"joined_team");
        self player_influencers_set_team();
        wait 0.05;
    }
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xb030b128, Offset: 0xa48
// Size: 0x90
function ongrenadethrow() {
    self endon(#"disconnect");
    self endon(#"hash_e9460c7d");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"grenade_fire", grenade, weapon);
        level thread create_grenade_influencers(self.pers["team"], weapon, grenade);
        wait 0.05;
    }
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x440ca423, Offset: 0xae0
// Size: 0x54
function get_friendly_team_mask(team) {
    if (level.teambased) {
        team_mask = util::getteammask(team);
    } else {
        team_mask = level.spawnsystem.ispawn_teammask_free;
    }
    return team_mask;
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0xa92e677c, Offset: 0xb40
// Size: 0x54
function get_enemy_team_mask(team) {
    if (level.teambased) {
        team_mask = util::getotherteamsmask(team);
    } else {
        team_mask = level.spawnsystem.ispawn_teammask_free;
    }
    return team_mask;
}

// Namespace spawning
// Params 3, eflags: 0x0
// Checksum 0x859f2fac, Offset: 0xba0
// Size: 0x68
function create_influencer(name, origin, team_mask) {
    self.influencers[name] = addinfluencer(name, origin, team_mask);
    self thread watch_remove_influencer();
    return self.influencers[name];
}

// Namespace spawning
// Params 3, eflags: 0x0
// Checksum 0x369de698, Offset: 0xc10
// Size: 0x78
function create_friendly_influencer(name, origin, team) {
    team_mask = self get_friendly_team_mask(team);
    self.influencersfriendly[name] = create_influencer(name, origin, team_mask);
    return self.influencersfriendly[name];
}

// Namespace spawning
// Params 3, eflags: 0x0
// Checksum 0xce625553, Offset: 0xc90
// Size: 0x78
function create_enemy_influencer(name, origin, team) {
    team_mask = self get_enemy_team_mask(team);
    self.influencersenemy[name] = create_influencer(name, origin, team_mask);
    return self.influencersenemy[name];
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0x4142a6b8, Offset: 0xd10
// Size: 0x60
function create_entity_influencer(name, team_mask) {
    self.influencers[name] = addentityinfluencer(name, self, team_mask);
    self thread watch_remove_influencer();
    return self.influencers[name];
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0xacfb3db, Offset: 0xd78
// Size: 0x4a
function create_entity_friendly_influencer(name) {
    team_mask = self get_friendly_team_mask();
    return self create_entity_masked_friendly_influencer(name, team_mask);
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0x87f6f8fd, Offset: 0xdd0
// Size: 0x52
function create_entity_enemy_influencer(name, team) {
    team_mask = self get_enemy_team_mask(team);
    return self create_entity_masked_enemy_influencer(name, team_mask);
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0xbd462a64, Offset: 0xe30
// Size: 0x50
function create_entity_masked_friendly_influencer(name, team_mask) {
    self.influencersfriendly[name] = self create_entity_influencer(name, team_mask);
    return self.influencersfriendly[name];
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0x5f67b743, Offset: 0xe88
// Size: 0x50
function create_entity_masked_enemy_influencer(name, team_mask) {
    self.influencersenemy[name] = self create_entity_influencer(name, team_mask);
    return self.influencersenemy[name];
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x4b5b2f5c, Offset: 0xee0
// Size: 0x22c
function create_player_influencers() {
    assert(!isdefined(self.influencers));
    assert(!isdefined(self.influencers));
    if (!level.teambased) {
        team_mask = level.spawnsystem.ispawn_teammask_free;
        other_team_mask = level.spawnsystem.ispawn_teammask_free;
        weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
    } else if (isdefined(self.pers["team"])) {
        team = self.pers["team"];
        team_mask = util::getteammask(team);
        enemy_teams_mask = util::getotherteamsmask(team);
    } else {
        team_mask = 0;
        enemy_teams_mask = 0;
    }
    angles = self.angles;
    origin = self.origin;
    up = (0, 0, 1);
    forward = (1, 0, 0);
    self.influencers = [];
    self.friendlyinfluencers = [];
    self.enemyinfluencers = [];
    self create_entity_masked_enemy_influencer("enemy", enemy_teams_mask);
    if (level.teambased) {
        self create_entity_masked_friendly_influencer("friend", team_mask);
    }
    if (!isdefined(self.pers["team"]) || self.pers["team"] == "spectator") {
        self enable_influencers(0);
    }
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x7abef93a, Offset: 0x1118
// Size: 0xc4
function remove_influencers() {
    foreach (influencer in self.influencers) {
        removeinfluencer(influencer);
    }
    self.influencers = [];
    if (isdefined(self.influencersfriendly)) {
        self.influencersfriendly = [];
    }
    if (isdefined(self.influencersenemy)) {
        self.influencersenemy = [];
    }
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x20e411c5, Offset: 0x11e8
// Size: 0xc4
function watch_remove_influencer() {
    self endon(#"death");
    self notify(#"watch_remove_influencer");
    self endon(#"watch_remove_influencer");
    self waittill(#"influencer_removed", index);
    arrayremovevalue(self.influencers, index);
    if (isdefined(self.influencersfriendly)) {
        arrayremovevalue(self.influencersfriendly, index);
    }
    if (isdefined(self.influencersenemy)) {
        arrayremovevalue(self.influencersenemy, index);
    }
    self thread watch_remove_influencer();
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x569707bd, Offset: 0x12b8
// Size: 0x9a
function enable_influencers(enabled) {
    foreach (influencer in self.influencers) {
        enableinfluencer(influencer, enabled);
    }
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0xe7718de5, Offset: 0x1360
// Size: 0x44
function enable_player_influencers(enabled) {
    if (!isdefined(self.influencers)) {
        self create_player_influencers();
    }
    self enable_influencers(enabled);
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x2c59cbaf, Offset: 0x13b0
// Size: 0x1ca
function player_influencers_set_team() {
    if (!level.teambased) {
        team_mask = level.spawnsystem.ispawn_teammask_free;
        enemy_teams_mask = level.spawnsystem.ispawn_teammask_free;
    } else {
        team = self.pers["team"];
        team_mask = util::getteammask(team);
        enemy_teams_mask = util::getotherteamsmask(team);
    }
    if (isdefined(self.influencersfriendly)) {
        foreach (influencer in self.influencersfriendly) {
            setinfluencerteammask(influencer, team_mask);
        }
    }
    if (isdefined(self.influencersenemy)) {
        foreach (influencer in self.influencersenemy) {
            setinfluencerteammask(influencer, enemy_teams_mask);
        }
    }
}

// Namespace spawning
// Params 3, eflags: 0x0
// Checksum 0xe7627e1e, Offset: 0x1588
// Size: 0x114
function create_grenade_influencers(parent_team, weapon, grenade) {
    pixbeginevent("create_grenade_influencers");
    spawn_influencer = weapon.spawninfluencer;
    if (isdefined(grenade.origin) && spawn_influencer != "") {
        if (!level.teambased) {
            weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
        } else {
            weapon_team_mask = util::getotherteamsmask(parent_team);
            if (level.friendlyfire) {
                weapon_team_mask |= util::getteammask(parent_team);
            }
        }
        grenade create_entity_masked_enemy_influencer(spawn_influencer, weapon_team_mask);
    }
    pixendevent();
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x977be2da, Offset: 0x16a8
// Size: 0x86
function create_map_placed_influencers() {
    staticinfluencerents = getentarray("mp_uspawn_influencer", "classname");
    for (i = 0; i < staticinfluencerents.size; i++) {
        staticinfluencerent = staticinfluencerents[i];
        create_map_placed_influencer(staticinfluencerent);
    }
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x26a664dc, Offset: 0x1738
// Size: 0xb0
function create_map_placed_influencer(influencer_entity) {
    influencer_id = -1;
    if (isdefined(influencer_entity.script_noteworty)) {
        team_mask = util::getteammask(influencer_entity.script_team);
        level create_enemy_influencer(influencer_entity.script_noteworty, influencer_entity.origin, team_mask);
    } else {
        assertmsg("<dev string:xb4>");
    }
    return influencer_id;
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xb6f71348, Offset: 0x17f0
// Size: 0x2fa
function updateallspawnpoints() {
    foreach (team in level.teams) {
        function_db51ac16(team);
    }
    foreach (team in level.teams) {
        if (level.unified_spawn_points[team].a.size > -2) {
            level.unified_spawn_points[team].b = array::function_4097a53e(array::randomize(level.unified_spawn_points[team].a), -2);
            continue;
        }
        level.unified_spawn_points[team].b = level.unified_spawn_points[team].a;
    }
    clearspawnpoints();
    if (level.teambased) {
        foreach (team in level.teams) {
            addspawnpoints(team, level.unified_spawn_points[team].b);
        }
        return;
    }
    foreach (team in level.teams) {
        addspawnpoints("free", level.unified_spawn_points[team].b);
    }
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x3668ebcc, Offset: 0x1af8
// Size: 0x338
function onspawnplayer_unified(predictedspawn) {
    if (!isdefined(predictedspawn)) {
        predictedspawn = 0;
    }
    /#
        if (getdvarint("<dev string:x7e>") != 0) {
            spawn_point = get_debug_spawnpoint(self);
            self spawn(spawn_point.origin, spawn_point.angles);
            return;
        }
    #/
    use_new_spawn_system = 1;
    initial_spawn = 1;
    if (isdefined(self.uspawn_already_spawned)) {
        initial_spawn = !self.uspawn_already_spawned;
    }
    if (level.usestartspawns) {
        use_new_spawn_system = 0;
    }
    if (level.gametype == "sd") {
        use_new_spawn_system = 0;
    }
    util::set_dvar_if_unset("scr_spawn_force_unified", "0");
    spawnoverride = self tacticalinsertion::overridespawn(predictedspawn);
    if (use_new_spawn_system || getdvarint("scr_spawn_force_unified") != 0) {
        if (!spawnoverride) {
            spawn_point = getspawnpoint(self, predictedspawn);
            if (isdefined(spawn_point)) {
                origin = spawn_point["origin"];
                angles = spawn_point["angles"];
                if (predictedspawn) {
                    self predictspawnpoint(origin, angles);
                } else {
                    level create_enemy_influencer("enemy_spawn", origin, self.pers["team"]);
                    self spawn(origin, angles);
                }
            } else {
                println("<dev string:xfe>");
                callback::abort_level();
            }
        } else if (predictedspawn && isdefined(self.tacticalinsertion)) {
            self predictspawnpoint(self.tacticalinsertion.origin, self.tacticalinsertion.angles);
        }
        if (!predictedspawn) {
            self.lastspawntime = gettime();
            self enable_player_influencers(1);
        }
    } else if (!spawnoverride) {
        [[ level.onspawnplayer ]](predictedspawn);
    }
    if (!predictedspawn) {
        self.uspawn_already_spawned = 1;
    }
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0xd9df1758, Offset: 0x1e40
// Size: 0x148
function getspawnpoint(player_entity, predictedspawn) {
    if (!isdefined(predictedspawn)) {
        predictedspawn = 0;
    }
    if (level.teambased) {
        point_team = player_entity.pers["team"];
        influencer_team = player_entity.pers["team"];
    } else {
        point_team = "free";
        influencer_team = "free";
    }
    if (level.teambased && isdefined(game["switchedsides"]) && game["switchedsides"] && level.spawnsystem.unifiedsideswitching) {
        point_team = util::getotherteam(point_team);
    }
    best_spawn = get_best_spawnpoint(point_team, influencer_team, player_entity, predictedspawn);
    if (!predictedspawn) {
        player_entity.last_spawn_origin = best_spawn["origin"];
    }
    return best_spawn;
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x3954692e, Offset: 0x1f90
// Size: 0x27a
function get_debug_spawnpoint(player) {
    if (level.teambased) {
        team = player.pers["team"];
    } else {
        team = "free";
    }
    index = level.test_spawn_point_index;
    level.test_spawn_point_index++;
    if (team == "free") {
        spawn_counts = 0;
        foreach (team in level.teams) {
            spawn_counts += level.unified_spawn_points[team].a.size;
        }
        if (level.test_spawn_point_index >= spawn_counts) {
            level.test_spawn_point_index = 0;
        }
        count = 0;
        foreach (team in level.teams) {
            size = level.unified_spawn_points[team].a.size;
            if (level.test_spawn_point_index < count + size) {
                return level.unified_spawn_points[team].a[level.test_spawn_point_index - count];
            }
            count += size;
        }
        return;
    }
    if (level.test_spawn_point_index >= level.unified_spawn_points[team].a.size) {
        level.test_spawn_point_index = 0;
    }
    return level.unified_spawn_points[team].a[level.test_spawn_point_index];
}

// Namespace spawning
// Params 4, eflags: 0x0
// Checksum 0xc03231c1, Offset: 0x2218
// Size: 0xe8
function get_best_spawnpoint(point_team, influencer_team, player, predictedspawn) {
    if (level.teambased) {
        vis_team_mask = util::getotherteamsmask(player.pers["team"]);
    } else {
        vis_team_mask = level.spawnsystem.ispawn_teammask_free;
    }
    spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn);
    if (!predictedspawn) {
        bbprint("mpspawnpointsused", "reason %s x %d y %d z %d", "point used", spawn_point["origin"]);
    }
    return spawn_point;
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x4a8e881a, Offset: 0x2308
// Size: 0xc2
function function_db51ac16(player_team) {
    if (!isdefined(level.unified_spawn_points)) {
        level.unified_spawn_points = [];
    } else if (isdefined(level.unified_spawn_points[player_team])) {
        return level.unified_spawn_points[player_team];
    }
    spawn_entities_s = util::spawn_array_struct();
    spawn_entities_s.a = spawnlogic::function_7f4a71b0(player_team);
    if (!isdefined(spawn_entities_s.a)) {
        spawn_entities_s.a = [];
    }
    level.unified_spawn_points[player_team] = spawn_entities_s;
    return spawn_entities_s;
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x2b1ca5f9, Offset: 0x23d8
// Size: 0x16
function is_hardcore() {
    return isdefined(level.hardcoremode) && level.hardcoremode;
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0x3e96c146, Offset: 0x23f8
// Size: 0x72
function teams_have_enmity(team1, team2) {
    if (!isdefined(team1) || !isdefined(team2) || level.gametype == "dm") {
        return true;
    }
    return team1 != "neutral" && team2 != "neutral" && team1 != team2;
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0xfac80733, Offset: 0x2478
// Size: 0x56
function delete_all_spawns(spawnpoints) {
    for (i = 0; i < spawnpoints.size; i++) {
        spawnpoints[i] delete();
    }
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x2d1fb159, Offset: 0x24d8
// Size: 0x68
function spawn_point_class_name_being_used(name) {
    if (!isdefined(level.spawn_point_class_names)) {
        return false;
    }
    for (i = 0; i < level.spawn_point_class_names.size; i++) {
        if (level.spawn_point_class_names[i] == name) {
            return true;
        }
    }
    return false;
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xd0d50385, Offset: 0x2548
// Size: 0xa4
function codecallback_updatespawnpoints() {
    foreach (team in level.teams) {
        spawnlogic::rebuild_spawn_points(team);
    }
    level.unified_spawn_points = undefined;
    updateallspawnpoints();
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0xffecc0db, Offset: 0x25f8
// Size: 0x158
function getteamstartspawnname(team, spawnpointnamebase) {
    spawn_point_team_name = team;
    if (!level.multiteam && game["switchedsides"]) {
        spawn_point_team_name = util::getotherteam(team);
    }
    if (level.multiteam) {
        if (team == "axis") {
            spawn_point_team_name = "team1";
        } else if (team == "allies") {
            spawn_point_team_name = "team2";
        }
        if (!util::isoneround()) {
            number = int(getsubstr(spawn_point_team_name, 4, 5)) - 1;
            number = (number + game["roundsplayed"]) % level.teams.size + 1;
            spawn_point_team_name = "team" + number;
        }
    }
    return spawnpointnamebase + "_" + spawn_point_team_name + "_start";
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x9df47e96, Offset: 0x2758
// Size: 0x2a
function gettdmstartspawnname(team) {
    return getteamstartspawnname(team, "mp_tdm_spawn");
}

