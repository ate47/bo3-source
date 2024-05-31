#using scripts/zm/_util;
#using scripts/zm/gametypes/_spawnlogic;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace spawning;

// Namespace spawning
// Params 0, eflags: 0x0
// namespace_52deffe2<file_0>::function_8c87d8eb
// Checksum 0x26a7cb93, Offset: 0x3f0
// Size: 0x1ec
function __init__() {
    level init_spawn_system();
    level.recently_deceased = [];
    foreach (team in level.teams) {
        level.recently_deceased[team] = util::spawn_array_struct();
    }
    callback::on_connecting(&on_player_connecting);
    level.spawnprotectiontime = getgametypesetting("spawnprotectiontime");
    level.spawnprotectiontimems = int((isdefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000);
    /#
        setdvar("create_grenade_influencers", "create_grenade_influencers");
        setdvar("create_grenade_influencers", "create_grenade_influencers");
        setdvar("create_grenade_influencers", "create_grenade_influencers");
        setdvar("create_grenade_influencers", "create_grenade_influencers");
        level.test_spawn_point_index = 0;
        setdvar("create_grenade_influencers", "create_grenade_influencers");
    #/
}

// Namespace spawning
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_620c7d91
// Checksum 0x9b22c85f, Offset: 0x5e8
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
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_888cb133
// Checksum 0x5d0eb288, Offset: 0x7a8
// Size: 0x7c
function on_player_connecting() {
    level endon(#"game_ended");
    self setentertime(gettime());
    callback::on_spawned(&on_player_spawned);
    callback::on_joined_team(&on_joined_team);
    self thread ongrenadethrow();
}

// Namespace spawning
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_aebcf025
// Checksum 0x7132a790, Offset: 0x830
// Size: 0x60
function on_player_spawned() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    for (;;) {
        self waittill(#"spawned_player");
        self enable_player_influencers(1);
        self thread ondeath();
    }
}

// Namespace spawning
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_f87d22c8
// Checksum 0xa7eb5a19, Offset: 0x898
// Size: 0x6c
function ondeath() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self waittill(#"death");
    self enable_player_influencers(0);
    level create_friendly_influencer("friend_dead", self.origin, self.team);
}

// Namespace spawning
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_f6076bfe
// Checksum 0x4cf10d65, Offset: 0x910
// Size: 0x2c
function on_joined_team() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self player_influencers_set_team();
}

// Namespace spawning
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_dab1f598
// Checksum 0x4c5ad434, Offset: 0x948
// Size: 0x80
function ongrenadethrow() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        grenade, weapon = self waittill(#"grenade_fire");
        level thread create_grenade_influencers(self.pers["team"], weapon, grenade);
        wait(0.05);
    }
}

// Namespace spawning
// Params 1, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_3e135528
// Checksum 0x3463ac60, Offset: 0x9d0
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
// Params 1, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_ca533271
// Checksum 0xa05b3c3e, Offset: 0xa30
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
// Params 3, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_fa67201d
// Checksum 0x865213ff, Offset: 0xa90
// Size: 0x68
function create_influencer(name, origin, team_mask) {
    self.influencers[name] = addinfluencer(name, origin, team_mask);
    self thread watch_remove_influencer();
    return self.influencers[name];
}

// Namespace spawning
// Params 3, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_b943e01d
// Checksum 0x275fdd8f, Offset: 0xb00
// Size: 0x78
function create_friendly_influencer(name, origin, team) {
    team_mask = self get_friendly_team_mask(team);
    self.influencersfriendly[name] = create_influencer(name, origin, team_mask);
    return self.influencersfriendly[name];
}

// Namespace spawning
// Params 3, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_eddb7236
// Checksum 0x89f20ae3, Offset: 0xb80
// Size: 0x78
function create_enemy_influencer(name, origin, team) {
    team_mask = self get_enemy_team_mask(team);
    self.influencersenemy[name] = create_influencer(name, origin, team_mask);
    return self.influencersenemy[name];
}

// Namespace spawning
// Params 2, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_4e9efa49
// Checksum 0x8c8245f8, Offset: 0xc00
// Size: 0x50
function create_entity_influencer(name, team_mask) {
    self.influencers[name] = addentityinfluencer(name, self, team_mask);
    return self.influencers[name];
}

// Namespace spawning
// Params 1, eflags: 0x0
// namespace_52deffe2<file_0>::function_febc81f1
// Checksum 0x1436a7ce, Offset: 0xc58
// Size: 0x4a
function create_entity_friendly_influencer(name) {
    team_mask = self get_friendly_team_mask();
    return self create_entity_masked_friendly_influencer(name, team_mask);
}

// Namespace spawning
// Params 1, eflags: 0x0
// namespace_52deffe2<file_0>::function_f93165aa
// Checksum 0x205ed741, Offset: 0xcb0
// Size: 0x4a
function create_entity_enemy_influencer(name) {
    team_mask = self get_enemy_team_mask();
    return self create_entity_masked_enemy_influencer(name, team_mask);
}

// Namespace spawning
// Params 2, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_f6de1bb7
// Checksum 0x8376247b, Offset: 0xd08
// Size: 0x50
function create_entity_masked_friendly_influencer(name, team_mask) {
    self.influencersfriendly[name] = self create_entity_influencer(name, team_mask);
    return self.influencersfriendly[name];
}

// Namespace spawning
// Params 2, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_63c74f54
// Checksum 0xc0152f10, Offset: 0xd60
// Size: 0x50
function create_entity_masked_enemy_influencer(name, team_mask) {
    self.influencersenemy[name] = self create_entity_influencer(name, team_mask);
    return self.influencersenemy[name];
}

// Namespace spawning
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_918f66b2
// Checksum 0x67eb6933, Offset: 0xdb8
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
// namespace_52deffe2<file_0>::function_614b1f50
// Checksum 0xa8693910, Offset: 0xff0
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
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_69a99c0d
// Checksum 0xef7624d3, Offset: 0x10c0
// Size: 0xb4
function watch_remove_influencer() {
    self endon(#"death");
    self notify(#"watch_remove_influencer");
    self endon(#"watch_remove_influencer");
    index = self waittill(#"influencer_removed");
    arrayremovevalue(self.influencers, index);
    arrayremovevalue(self.influencersfriendly, index);
    arrayremovevalue(self.influencersenemy, index);
    self thread watch_remove_influencer();
}

// Namespace spawning
// Params 1, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_c47d28b5
// Checksum 0x13865551, Offset: 0x1180
// Size: 0x9a
function enable_influencers(enabled) {
    foreach (influencer in self.influencers) {
        enableinfluencer(influencer, enabled);
    }
}

// Namespace spawning
// Params 1, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_8dcfabdd
// Checksum 0xbd42f983, Offset: 0x1228
// Size: 0x44
function enable_player_influencers(enabled) {
    if (!isdefined(self.influencers)) {
        self create_player_influencers();
    }
    self enable_influencers(enabled);
}

// Namespace spawning
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_8b8b26c2
// Checksum 0xfd2b9c69, Offset: 0x1278
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
// Params 3, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_4ef230d3
// Checksum 0x8be8a0b0, Offset: 0x1450
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
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_1fd0742f
// Checksum 0x8dff2eb, Offset: 0x1570
// Size: 0x86
function create_map_placed_influencers() {
    staticinfluencerents = getentarray("mp_uspawn_influencer", "classname");
    for (i = 0; i < staticinfluencerents.size; i++) {
        staticinfluencerent = staticinfluencerents[i];
        create_map_placed_influencer(staticinfluencerent);
    }
}

// Namespace spawning
// Params 1, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_f6b6842c
// Checksum 0x1df0b7, Offset: 0x1600
// Size: 0xb0
function create_map_placed_influencer(influencer_entity) {
    influencer_id = -1;
    if (isdefined(influencer_entity.script_noteworty)) {
        team_mask = util::getteammask(influencer_entity.script_team);
        level create_enemy_influencer(influencer_entity.script_noteworty, influencer_entity.origin, team_mask);
    } else {
        assertmsg("create_grenade_influencers");
    }
    return influencer_id;
}

// Namespace spawning
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_ca8dbdcd
// Checksum 0xdd5d62c1, Offset: 0x16b8
// Size: 0x1ec
function updateallspawnpoints() {
    foreach (team in level.teams) {
        gatherspawnpoints(team);
    }
    spawnlogic::clearspawnpoints();
    if (level.teambased) {
        foreach (team in level.teams) {
            spawnlogic::addspawnpoints(team, level.unified_spawn_points[team].a);
        }
    } else {
        foreach (team in level.teams) {
            spawnlogic::addspawnpoints("free", level.unified_spawn_points[team].a);
        }
    }
    remove_unused_spawn_entities();
}

// Namespace spawning
// Params 1, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_a326dcf3
// Checksum 0x53c3d24f, Offset: 0x18b0
// Size: 0x144
function onspawnplayer_unified(predictedspawn) {
    if (!isdefined(predictedspawn)) {
        predictedspawn = 0;
    }
    /#
        if (getdvarint("create_grenade_influencers") != 0) {
            spawn_point = get_debug_spawnpoint(self);
            self spawn(spawn_point.origin, spawn_point.angles);
            return;
        }
    #/
    use_new_spawn_system = 0;
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
    [[ level.onspawnplayer ]](predictedspawn);
    if (!predictedspawn) {
        self.uspawn_already_spawned = 1;
    }
}

// Namespace spawning
// Params 2, eflags: 0x0
// namespace_52deffe2<file_0>::function_fe9b0dce
// Checksum 0x82c1bc6e, Offset: 0x1a00
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
// Params 1, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_a13eb9b
// Checksum 0x4d4178f9, Offset: 0x1b50
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
// Params 4, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_73abee32
// Checksum 0x57d47b9d, Offset: 0x1dd8
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
// Params 1, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_e45ccc70
// Checksum 0xdf2d315, Offset: 0x1ec8
// Size: 0xc2
function gatherspawnpoints(player_team) {
    if (!isdefined(level.unified_spawn_points)) {
        level.unified_spawn_points = [];
    } else if (isdefined(level.unified_spawn_points[player_team])) {
        return level.unified_spawn_points[player_team];
    }
    spawn_entities_s = util::spawn_array_struct();
    spawn_entities_s.a = spawnlogic::getteamspawnpoints(player_team);
    if (!isdefined(spawn_entities_s.a)) {
        spawn_entities_s.a = [];
    }
    level.unified_spawn_points[player_team] = spawn_entities_s;
    return spawn_entities_s;
}

// Namespace spawning
// Params 0, eflags: 0x0
// namespace_52deffe2<file_0>::function_d8e23996
// Checksum 0xf710a2c9, Offset: 0x1f98
// Size: 0x16
function is_hardcore() {
    return isdefined(level.hardcoremode) && level.hardcoremode;
}

// Namespace spawning
// Params 2, eflags: 0x0
// namespace_52deffe2<file_0>::function_f705b237
// Checksum 0x7ed98ddc, Offset: 0x1fb8
// Size: 0x72
function teams_have_enmity(team1, team2) {
    if (!isdefined(team1) || !isdefined(team2) || level.gametype == "dm") {
        return true;
    }
    return team1 != "neutral" && team2 != "neutral" && team1 != team2;
}

// Namespace spawning
// Params 0, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_1dff77d0
// Checksum 0x2c185004, Offset: 0x2038
// Size: 0x22e
function remove_unused_spawn_entities() {
    spawn_entity_types = [];
    spawn_entity_types[spawn_entity_types.size] = "mp_dm_spawn";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis";
    spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_attacker";
    spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_defender";
    spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn";
    for (i = 0; i < spawn_entity_types.size; i++) {
        if (spawn_point_class_name_being_used(spawn_entity_types[i])) {
            continue;
        }
        spawnpoints = spawnlogic::getspawnpointarray(spawn_entity_types[i]);
        delete_all_spawns(spawnpoints);
    }
}

// Namespace spawning
// Params 1, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_d8628a3b
// Checksum 0xcde1d01d, Offset: 0x2270
// Size: 0x56
function delete_all_spawns(spawnpoints) {
    for (i = 0; i < spawnpoints.size; i++) {
        spawnpoints[i] delete();
    }
}

// Namespace spawning
// Params 1, eflags: 0x1 linked
// namespace_52deffe2<file_0>::function_79666696
// Checksum 0xc47e94b0, Offset: 0x22d0
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
// namespace_52deffe2<file_0>::function_75cd83b3
// Checksum 0x6f654d0a, Offset: 0x2340
// Size: 0xa4
function codecallback_updatespawnpoints() {
    foreach (team in level.teams) {
        spawnlogic::rebuildspawnpoints(team);
    }
    level.unified_spawn_points = undefined;
    updateallspawnpoints();
}

// Namespace spawning
// Params 2, eflags: 0x0
// namespace_52deffe2<file_0>::function_f6e89231
// Checksum 0xa0a91454, Offset: 0x23f0
// Size: 0xcc
function initialspawnprotection(specialtyname, spawnmonitorspeed) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(level.spawnprotectiontime) || level.spawnprotectiontime == 0) {
        return;
    }
    if (specialtyname == "specialty_nottargetedbyairsupport") {
        self.specialty_nottargetedbyairsupport = 1;
        wait(level.spawnprotectiontime);
        self.specialty_nottargetedbyairsupport = undefined;
        return;
    }
    if (!self hasperk(specialtyname)) {
        self setperk(specialtyname);
        wait(level.spawnprotectiontime);
        self unsetperk(specialtyname);
    }
}

