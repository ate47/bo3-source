#using scripts/mp/_util;
#using scripts/mp/gametypes/_dogtags;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/shared/abilities/gadgets/_gadget_resurrect;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_tacticalinsertion;

#namespace spawning;

// Namespace spawning
// Params 0, eflags: 0x2
// Checksum 0x514dec2d, Offset: 0x6d8
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("spawning", &__init__, undefined, undefined);
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x1705143a, Offset: 0x710
// Size: 0x192
function __init__() {
    level init_spawn_system();
    level.influencers = [];
    level.recently_deceased = [];
    foreach (team in level.teams) {
        level.recently_deceased[team] = util::spawn_array_struct();
    }
    callback::on_connecting(&onplayerconnect);
    level.spawnprotectiontime = getgametypesetting("spawnprotectiontime");
    level.spawntraptriggertime = getgametypesetting("spawntraptriggertime");
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
// Checksum 0x63200796, Offset: 0x8b0
// Size: 0x137
function init_spawn_system() {
    level.spawnsystem = spawnstruct();
    spawnsystem = level.spawnsystem;
    if (!isdefined(spawnsystem.var_23df778)) {
        spawnsystem.var_23df778 = 1;
    }
    spawnsystem.objective_facing_bonus = 0;
    spawnsystem.ispawn_teammask = [];
    spawnsystem.ispawn_teammask_free = 1;
    spawnsystem.ispawn_teammask["free"] = spawnsystem.ispawn_teammask_free;
    all = spawnsystem.ispawn_teammask_free;
    count = 1;
    var_ce76cd54 = level.teams;
    var_f93fbae = firstarray(var_ce76cd54);
    if (isdefined(var_f93fbae)) {
        team = var_ce76cd54[var_f93fbae];
        var_6a26edc9 = nextarray(var_ce76cd54, var_f93fbae);
        InvalidOpCode(0xc1, count, 1);
        // Unknown operator (0xc1, t7_1b, PC)
    }
    spawnsystem.ispawn_teammask["all"] = all;
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xf4fc4fbc, Offset: 0x9f0
// Size: 0x4a
function onplayerconnect() {
    level endon(#"game_ended");
    self setentertime(gettime());
    self thread onplayerspawned();
    self thread onteamchange();
    self thread ongrenadethrow();
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xc9b3c0ba, Offset: 0xa48
// Size: 0x8d
function onplayerspawned() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    for (;;) {
        self waittill(#"spawned_player");
        self airsupport::clearmonitoredspeed();
        self thread initialspawnprotection();
        if (isdefined(self.pers["hasRadar"]) && self.pers["hasRadar"]) {
            self.hasspyplane = 1;
        }
        self enable_player_influencers(1);
        self thread ondeath();
    }
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xfc6f0332, Offset: 0xae0
// Size: 0x52
function ondeath() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self waittill(#"death");
    self enable_player_influencers(0);
    level create_friendly_influencer("friend_dead", self.origin, self.team);
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x31a6e38c, Offset: 0xb40
// Size: 0x3d
function onteamchange() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"joined_team");
        self player_influencers_set_team();
        wait 0.05;
    }
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xa0003eb1, Offset: 0xb88
// Size: 0x65
function ongrenadethrow() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"grenade_fire", grenade, weapon);
        level thread create_grenade_influencers(self.pers["team"], weapon, grenade);
        wait 0.05;
    }
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x75ece386, Offset: 0xbf8
// Size: 0x4a
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
// Checksum 0x7df1f47d, Offset: 0xc50
// Size: 0x4a
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
// Checksum 0x456ce148, Offset: 0xca8
// Size: 0x52
function create_influencer(name, origin, team_mask) {
    self.influencers[name] = addinfluencer(name, origin, team_mask);
    self thread watch_remove_influencer();
    return self.influencers[name];
}

// Namespace spawning
// Params 3, eflags: 0x0
// Checksum 0xc157e4d9, Offset: 0xd08
// Size: 0x5e
function create_friendly_influencer(name, origin, team) {
    team_mask = self get_friendly_team_mask(team);
    self.influencersfriendly[name] = create_influencer(name, origin, team_mask);
    return self.influencersfriendly[name];
}

// Namespace spawning
// Params 3, eflags: 0x0
// Checksum 0x5a2114ec, Offset: 0xd70
// Size: 0x5e
function create_enemy_influencer(name, origin, team) {
    team_mask = self get_enemy_team_mask(team);
    self.influencersenemy[name] = create_influencer(name, origin, team_mask);
    return self.influencersenemy[name];
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0x6d47d517, Offset: 0xdd8
// Size: 0x4a
function create_entity_influencer(name, team_mask) {
    self.influencers[name] = addentityinfluencer(name, self, team_mask);
    self thread watch_remove_influencer();
    return self.influencers[name];
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0x59b84955, Offset: 0xe30
// Size: 0x41
function create_entity_friendly_influencer(name, team) {
    team_mask = self get_friendly_team_mask(team);
    return self create_entity_masked_friendly_influencer(name, team_mask);
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0x8959d8b5, Offset: 0xe80
// Size: 0x41
function create_entity_enemy_influencer(name, team) {
    team_mask = self get_enemy_team_mask(team);
    return self create_entity_masked_enemy_influencer(name, team_mask);
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0x7eda1f84, Offset: 0xed0
// Size: 0x3e
function create_entity_masked_friendly_influencer(name, team_mask) {
    self.influencersfriendly[name] = self create_entity_influencer(name, team_mask);
    return self.influencersfriendly[name];
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0xef6573f5, Offset: 0xf18
// Size: 0x3e
function create_entity_masked_enemy_influencer(name, team_mask) {
    self.influencersenemy[name] = self create_entity_influencer(name, team_mask);
    return self.influencersenemy[name];
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x4b8ad72, Offset: 0xf60
// Size: 0x19a
function create_player_influencers() {
    assert(!isdefined(self.influencers));
    assert(!isdefined(self.influencers));
    if (!level.teambased) {
        team_mask = level.spawnsystem.ispawn_teammask_free;
        enemy_teams_mask = level.spawnsystem.ispawn_teammask_free;
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
// Params 1, eflags: 0x0
// Checksum 0x721d0c1b, Offset: 0x1108
// Size: 0x5a
function create_player_spawn_influencers(spawn_origin) {
    level create_enemy_influencer("enemy_spawn", spawn_origin, self.pers["team"]);
    level create_friendly_influencer("friendly_spawn", spawn_origin, self.pers["team"]);
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0xdeb1043c, Offset: 0x1170
// Size: 0xcb
function remove_influencer(to_be_removed) {
    foreach (influencer in self.influencers) {
        if (influencer == to_be_removed) {
            removeinfluencer(influencer);
            arrayremovevalue(self.influencers, influencer);
            if (isdefined(self.influencersfriendly)) {
                arrayremovevalue(self.influencersfriendly, influencer);
            }
            if (isdefined(self.influencersenemy)) {
                arrayremovevalue(self.influencersenemy, influencer);
            }
            return;
        }
    }
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x5106605b, Offset: 0x1248
// Size: 0xa2
function remove_influencers() {
    if (isdefined(self.influencers)) {
        foreach (influencer in self.influencers) {
            removeinfluencer(influencer);
        }
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
// Checksum 0x29fa16d9, Offset: 0x12f8
// Size: 0x9a
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
// Checksum 0x2d46a58c, Offset: 0x13a0
// Size: 0x6b
function enable_influencers(enabled) {
    foreach (influencer in self.influencers) {
        enableinfluencer(influencer, enabled);
    }
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x5e8e6a25, Offset: 0x1418
// Size: 0x32
function enable_player_influencers(enabled) {
    if (!isdefined(self.influencers)) {
        self create_player_influencers();
    }
    self enable_influencers(enabled);
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x32396c82, Offset: 0x1458
// Size: 0x15b
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
// Checksum 0xc6ec00ea, Offset: 0x15c0
// Size: 0xe2
function create_grenade_influencers(parent_team, weapon, grenade) {
    pixbeginevent("create_grenade_influencers");
    spawn_influencer = weapon.spawninfluencer;
    if (isdefined(grenade.origin) && spawn_influencer != "") {
        if (!level.teambased) {
            weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
        } else {
            weapon_team_mask = util::getotherteamsmask(parent_team);
            if (level.friendlyfire) {
                InvalidOpCode(0xb9, util::getteammask(parent_team), weapon_team_mask);
                // Unknown operator (0xb9, t7_1b, PC)
            }
        }
        grenade create_entity_masked_enemy_influencer(spawn_influencer, weapon_team_mask);
    }
    pixendevent();
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x3243cc1, Offset: 0x16b0
// Size: 0x69
function create_map_placed_influencers() {
    staticinfluencerents = getentarray("mp_uspawn_influencer", "classname");
    for (i = 0; i < staticinfluencerents.size; i++) {
        staticinfluencerent = staticinfluencerents[i];
        create_map_placed_influencer(staticinfluencerent);
    }
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x5d8cd0cf, Offset: 0x1728
// Size: 0x94
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
// Checksum 0xd27da173, Offset: 0x17c8
// Size: 0x1c2
function updateallspawnpoints() {
    foreach (team in level.teams) {
        gatherspawnpoints(team);
    }
    clearspawnpoints(0);
    if (level.teambased) {
        foreach (team in level.teams) {
            addspawnpoints(team, level.var_b1370bf0[team], 0);
            enablespawnpointlist(0, util::getteammask(team));
        }
    } else {
        foreach (team in level.teams) {
            addspawnpoints("free", level.var_b1370bf0[team], 0);
            enablespawnpointlist(0, util::getteammask(team));
        }
    }
    level.var_127254b8 = level.spawnmins;
    level.var_1a043076 = level.spawnmaxs;
    remove_unused_spawn_entities();
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xd9906af2, Offset: 0x1998
// Size: 0x10b
function update_fallback_spawnpoints() {
    clearspawnpoints(1);
    if (!isdefined(level.player_fallback_points)) {
        return;
    }
    if (level.teambased) {
        foreach (team in level.teams) {
            addspawnpoints(team, level.player_fallback_points[team], 1);
        }
        return;
    }
    foreach (team in level.teams) {
        addspawnpoints("free", level.player_fallback_points[team], 1);
    }
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0x6f790989, Offset: 0x1ab0
// Size: 0x142
function add_fallback_spawnpoints(team, point_class) {
    if (!isdefined(level.player_fallback_points)) {
        level.player_fallback_points = [];
        foreach (level_team in level.teams) {
            level.player_fallback_points[level_team] = [];
        }
    }
    spawnlogic::add_spawn_point_classname(point_class);
    spawnpoints = spawnlogic::get_spawnpoint_array(point_class);
    if (isdefined(level.allowedgameobjects) && level.convert_spawns_to_structs) {
        for (i = spawnpoints.size - 1; i >= 0; i--) {
            if (!gameobjects::entity_is_allowed(spawnpoints[i], level.allowedgameobjects)) {
                spawnpoints[i] = undefined;
            }
        }
        arrayremovevalue(spawnpoints, undefined);
    }
    level.player_fallback_points[team] = spawnpoints;
    disablespawnpointlist(1, util::getteammask(team));
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x41adbe1, Offset: 0x1c00
// Size: 0x67
function is_spawn_trapped(team) {
    /#
        level.spawntraptriggertime = getgametypesetting("<dev string:xfe>");
    #/
    if (isdefined(level.alivetimesaverage[team]) && level.alivetimesaverage[team] != 0 && level.alivetimesaverage[team] < level.spawntraptriggertime * 1000) {
        return true;
    }
    return false;
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x85a2bab, Offset: 0x1c70
// Size: 0xae
function use_start_spawns() {
    if (level.alwaysusestartspawns) {
        return true;
    }
    if (!level.usestartspawns) {
        return false;
    }
    if (level.teambased) {
        spawnteam = self.pers["team"];
        if (level.aliveplayers[spawnteam].size + level.spawningplayers[self.team].size > level.spawn_start[spawnteam].size) {
            level.usestartspawns = 0;
            return false;
        }
    } else if (level.aliveplayers["free"].size + level.spawningplayers["free"].size > level.spawn_start.size) {
        level.usestartspawns = 0;
        return false;
    }
    return true;
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x630e460e, Offset: 0x1d28
// Size: 0x342
function onspawnplayer(predictedspawn) {
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
    spawnoverride = self tacticalinsertion::overridespawn(predictedspawn);
    spawnresurrect = self resurrect::overridespawn(predictedspawn);
    /#
        if (isdefined(self.devguilockspawn) && self.devguilockspawn) {
            spawnresurrect = 1;
        }
    #/
    spawn_origin = undefined;
    spawn_angles = undefined;
    if (spawnresurrect) {
        spawn_origin = self.resurrect_origin;
        spawn_angles = self.resurrect_angles;
    } else if (spawnoverride) {
        if (predictedspawn && isdefined(self.tacticalinsertion)) {
            self predictspawnpoint(self.tacticalinsertion.origin, self.tacticalinsertion.angles);
        }
        return;
    } else if (self use_start_spawns()) {
        if (level.teambased) {
            spawnteam = self.pers["team"];
            InvalidOpCode(0x54, "switchedsides");
            // Unknown operator (0x54, t7_1b, PC)
        }
        spawnpoint = spawnlogic::get_spawnpoint_random(level.spawn_start);
        if (isdefined(spawnpoint)) {
            spawn_origin = spawnpoint.origin;
            spawn_angles = spawnpoint.angles;
        }
    } else {
        spawn_point = getspawnpoint(self, predictedspawn);
        if (isdefined(spawn_point)) {
            spawn_origin = spawn_point["origin"];
            spawn_angles = spawn_point["angles"];
        }
    }
    if (!isdefined(spawn_origin)) {
        println("<dev string:x113>");
        callback::abort_level();
    }
    if (predictedspawn) {
        self predictspawnpoint(spawn_origin, spawn_angles);
    } else {
        if (level.teambased) {
            level.spawningplayers[self.team][level.spawningplayers[self.team].size] = self;
        } else {
            level.spawningplayers["free"][level.spawningplayers["free"].size] = self;
        }
        self spawn(spawn_origin, spawn_angles);
        self.lastspawntime = gettime();
        self enable_player_influencers(1);
        if (!spawnresurrect && !spawnoverride) {
            self create_player_spawn_influencers(spawn_origin);
        }
    }
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        dogtags::on_spawn_player();
    }
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0xa97f63fa, Offset: 0x2078
// Size: 0x160
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
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
LOC_00000093:
    InvalidOpCode(0x54, "switchedsides");
LOC_00000093:
    // Unknown operator (0x54, t7_1b, PC)
LOC_0000009e:
    if (level.teambased && level.teambased && level.teambased && level.teambased && level.spawnsystem.var_23df778) {
        point_team = util::getotherteam(point_team);
    }
    if (is_spawn_trapped(point_team)) {
        enablespawnpointlist(1, util::getteammask(point_team));
    } else {
        disablespawnpointlist(1, util::getteammask(point_team));
    }
    best_spawn = get_best_spawnpoint(point_team, influencer_team, player_entity, predictedspawn);
    if (!predictedspawn) {
        player_entity.last_spawn_origin = best_spawn["origin"];
    }
    return best_spawn;
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0xc97320ab, Offset: 0x21e0
// Size: 0x1a4
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
            spawn_counts += level.var_b1370bf0[team].size;
        }
        if (level.test_spawn_point_index >= spawn_counts) {
            level.test_spawn_point_index = 0;
        }
        count = 0;
        foreach (team in level.teams) {
            size = level.var_b1370bf0[team].size;
            if (level.test_spawn_point_index < count + size) {
                return level.var_b1370bf0[team][level.test_spawn_point_index - count];
            }
            count += size;
        }
        return;
    }
    if (level.test_spawn_point_index >= level.var_b1370bf0[team].size) {
        level.test_spawn_point_index = 0;
    }
    return level.var_b1370bf0[team][level.test_spawn_point_index];
}

// Namespace spawning
// Params 4, eflags: 0x0
// Checksum 0x171b6075, Offset: 0x2390
// Size: 0xc4
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
// Checksum 0x92c901fd, Offset: 0x2460
// Size: 0x63
function gatherspawnpoints(player_team) {
    if (!isdefined(level.var_b1370bf0)) {
        level.var_b1370bf0 = [];
    } else if (isdefined(level.var_b1370bf0[player_team])) {
        return;
    }
    var_bf06e8a4 = spawnlogic::function_7f4a71b0(player_team);
    if (!isdefined(var_bf06e8a4)) {
        var_bf06e8a4 = [];
    }
    level.var_b1370bf0[player_team] = var_bf06e8a4;
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x3e3731f2, Offset: 0x24d0
// Size: 0x15
function is_hardcore() {
    return isdefined(level.hardcoremode) && level.hardcoremode;
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0x77c7a842, Offset: 0x24f0
// Size: 0x56
function teams_have_enmity(team1, team2) {
    if (!isdefined(team1) || !isdefined(team2) || level.gametype == "dm") {
        return true;
    }
    return team1 != "neutral" && team2 != "neutral" && team1 != team2;
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xfa46ad68, Offset: 0x2550
// Size: 0x229
function remove_unused_spawn_entities() {
    if (level.convert_spawns_to_structs) {
        return;
    }
    spawn_entity_types = [];
    spawn_entity_types[spawn_entity_types.size] = "mp_dm_spawn";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team1_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team2_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team3_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team4_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team5_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team6_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies";
    spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_flag_a";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_flag_b";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_flag_c";
    spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies";
    spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis";
    spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_attacker";
    spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_defender";
    spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_attacker_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_defender_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_attackerOT_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_defenderOT_start";
    spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_attacker";
    spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_defender";
    spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_defender_a";
    spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_defender_b";
    spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_attacker_remove_a";
    spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_attacker_remove_b";
    for (i = 0; i < spawn_entity_types.size; i++) {
        if (spawn_point_class_name_being_used(spawn_entity_types[i])) {
            continue;
        }
        spawnpoints = spawnlogic::get_spawnpoint_array(spawn_entity_types[i]);
        delete_all_spawns(spawnpoints);
    }
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x41f0a35b, Offset: 0x2788
// Size: 0x39
function delete_all_spawns(spawnpoints) {
    for (i = 0; i < spawnpoints.size; i++) {
        spawnpoints[i] delete();
    }
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0xd8a0eaed, Offset: 0x27d0
// Size: 0x50
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
// Checksum 0xd4ba1ef0, Offset: 0x2828
// Size: 0x7a
function codecallback_updatespawnpoints() {
    foreach (team in level.teams) {
        spawnlogic::rebuild_spawn_points(team);
    }
    level.var_b1370bf0 = undefined;
    updateallspawnpoints();
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xf1805a61, Offset: 0x28b0
// Size: 0xa2
function initialspawnprotection() {
    self endon(#"death");
    self endon(#"disconnect");
    self thread airsupport::monitorspeed(level.spawnprotectiontime);
    if (!isdefined(level.spawnprotectiontime) || level.spawnprotectiontime == 0) {
        return;
    }
    self.specialty_nottargetedbyairsupport = 1;
    self clientfield::set("killstreak_spawn_protection", 1);
    self.ignoreme = 1;
    wait level.spawnprotectiontime;
    self clientfield::set("killstreak_spawn_protection", 0);
    self.specialty_nottargetedbyairsupport = undefined;
    self.ignoreme = 0;
}

// Namespace spawning
// Params 2, eflags: 0x0
// Checksum 0x350a619, Offset: 0x2960
// Size: 0x10e
function getteamstartspawnname(team, spawnpointnamebase) {
    spawn_point_team_name = team;
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
LOC_0000003a:
    if (!level.multiteam && !level.multiteam) {
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
            InvalidOpCode(0x54, "roundsplayed", number);
            // Unknown operator (0x54, t7_1b, PC)
        }
    }
    return spawnpointnamebase + "_" + spawn_point_team_name + "_start";
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0xda5011bf, Offset: 0x2a78
// Size: 0x21
function gettdmstartspawnname(team) {
    return getteamstartspawnname(team, "mp_tdm_spawn");
}

