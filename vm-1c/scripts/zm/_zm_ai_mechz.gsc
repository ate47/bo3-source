#using scripts/codescripts/struct;
#using scripts/shared/_burnplayer;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/mechz;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace zm_ai_mechz;

// Namespace zm_ai_mechz
// Params 0, eflags: 0x2
// Checksum 0xd378e478, Offset: 0x6b0
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_ai_mechz", &__init__, &__main__, undefined);
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x0
// Checksum 0xbf891ccd, Offset: 0x6f8
// Size: 0x2bc
function __init__() {
    function_f20c04a4();
    level.var_f1419b9d = 1200;
    level.var_53cc405d = level.var_f1419b9d;
    level.var_fa14536d = 1500;
    level.var_df387ccd = level.var_fa14536d;
    level.var_f12b2aa3 = 500;
    level.var_79d56f1b = level.var_f12b2aa3;
    level.var_e12ec39f = 500;
    level.var_c31f5c1f = level.var_e12ec39f;
    level.var_3f1bf221 = -6;
    level.var_2cbc5b59 = level.var_3f1bf221;
    level.var_a1748a68 = 100;
    level.var_1a5bb9d8 = 100;
    level.var_a1943286 = 15;
    level.var_9684c99e = 15;
    level.var_158234c = 10;
    level.var_65863f29 = 0;
    level.var_6c15f1bc = getentarray("zombie_mechz_spawner", "script_noteworthy");
    level.var_20d6379d = struct::get_array("mechz_location", "script_noteworthy");
    spawner::add_archetype_spawn_function("mechz", &function_3d5df242);
    zm::register_player_damage_callback(&function_ed70c868);
    level.var_749152c4 = &function_1add8026;
    level thread aat::register_immunity("zm_aat_blast_furnace", "mechz", 0, 1, 1);
    level thread aat::register_immunity("zm_aat_dead_wire", "mechz", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_fire_works", "mechz", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_thunder_wall", "mechz", 0, 1, 1);
    level thread aat::register_immunity("zm_aat_turned", "mechz", 1, 1, 1);
    /#
        execdevgui("<dev string:x28>");
        thread function_fbad70fd();
    #/
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x4
// Checksum 0xb9c57b89, Offset: 0x9c0
// Size: 0x68
function private __main__() {
    if (!isdefined(level.var_98b48f9c)) {
        level.var_98b48f9c = 80;
    }
    visionset_mgr::register_info("overlay", "mechz_player_burn", 5000, level.var_98b48f9c, 15, 1, &visionset_mgr::duration_lerp_thread_per_player, 0);
    level.var_e7b9aac8 = 1;
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x4
// Checksum 0xe808b314, Offset: 0xa30
// Size: 0x2c
function private function_f20c04a4() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMechzTargetService", &function_c28caf48);
}

// Namespace zm_ai_mechz
// Params 1, eflags: 0x4
// Checksum 0xa1dbafd, Offset: 0xa68
// Size: 0x2a0
function private function_c28caf48(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    if (isdefined(entity.var_24971ab5)) {
        return 0;
    }
    player = zm_utility::get_closest_valid_player(self.origin, self.ignore_player);
    entity.favoriteenemy = player;
    if (!isdefined(player) || player isnotarget()) {
        if (isdefined(entity.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return;
            }
            entity.ignore_player = [];
        }
        /#
            if (isdefined(level.var_da353fa7) && level.var_da353fa7) {
                entity setgoal(entity.origin);
                return 0;
            }
        #/
        if (isdefined(level.no_target_override)) {
            [[ level.no_target_override ]](entity);
        } else {
            entity setgoal(entity.origin);
        }
        return 0;
    }
    if (isdefined(level.enemy_location_override_func)) {
        var_d1bd0948 = [[ level.enemy_location_override_func ]](entity, player);
        if (isdefined(var_d1bd0948)) {
            entity setgoal(var_d1bd0948);
            return 1;
        }
    }
    playerpos = player.origin;
    if (isdefined(player.last_valid_position)) {
        playerpos = player.last_valid_position;
    }
    targetpos = getclosestpointonnavmesh(playerpos, 64, 30);
    if (isdefined(targetpos)) {
        entity setgoal(targetpos);
        return 1;
    }
    entity setgoal(entity.origin);
    return 0;
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x0
// Checksum 0x518888f5, Offset: 0xd10
// Size: 0x54
function function_48cabef5() {
    if (isdefined(self.customtraverseendnode) && isdefined(self.customtraversestartnode)) {
        return (self.customtraverseendnode.script_noteworthy === "custom_traversal" && self.customtraversestartnode.script_noteworthy === "custom_traversal");
    }
    return false;
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x4
// Checksum 0x6c26f914, Offset: 0xd70
// Size: 0xe4
function private function_3d5df242() {
    self.b_ignore_cleanup = 1;
    self.is_mechz = 1;
    self.n_start_health = self.health;
    self.team = level.zombie_team;
    self.zombie_lift_override = &function_817c85eb;
    self.var_c8806297 = &function_9bac2f00;
    self.thundergun_knockdown_func = &function_19b9b682;
    self.var_23340a5d = &function_9bac2f00;
    self.var_e1dbd63 = &function_19b9b682;
    self.var_48cabef5 = &function_48cabef5;
    level thread zm_spawner::zombie_death_event(self);
}

// Namespace zm_ai_mechz
// Params 10, eflags: 0x4
// Checksum 0x574cf82a, Offset: 0xe60
// Size: 0x92
function private function_ed70c868(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(eattacker) && eattacker.archetype === "mechz" && smeansofdeath === "MOD_MELEE") {
        return -106;
    }
    return -1;
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x0
// Checksum 0xf0fda4fa, Offset: 0xf00
// Size: 0x32
function function_58655f2a() {
    if (!(isdefined(self.stun) && self.stun) && self.var_e12b0a6c < gettime()) {
        return true;
    }
    return false;
}

// Namespace zm_ai_mechz
// Params 2, eflags: 0x0
// Checksum 0xaeaf1a5f, Offset: 0xf40
// Size: 0x68
function function_9bac2f00(e_player, gib) {
    self endon(#"death");
    self function_b8e0ce15(e_player);
    if (!(isdefined(self.stun) && self.stun) && self.var_e12b0a6c < gettime()) {
        self.stun = 1;
    }
}

// Namespace zm_ai_mechz
// Params 2, eflags: 0x0
// Checksum 0xc3560c9d, Offset: 0xfb0
// Size: 0x68
function function_19b9b682(e_player, gib) {
    self endon(#"death");
    self function_b8e0ce15(e_player);
    if (!(isdefined(self.stun) && self.stun) && self.var_e12b0a6c < gettime()) {
        self.stun = 1;
    }
}

// Namespace zm_ai_mechz
// Params 1, eflags: 0x0
// Checksum 0xe943a1dd, Offset: 0x1020
// Size: 0xcc
function function_b8e0ce15(e_player) {
    var_3bb42832 = level.var_53cc405d;
    if (isdefined(level.var_f4dc2834)) {
        var_3bb42832 = math::clamp(var_3bb42832, 0, level.var_f4dc2834);
    }
    n_damage = var_3bb42832 * 0.25 / 0.2;
    self dodamage(n_damage, self getcentroid(), e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, getweapon("thundergun"));
}

// Namespace zm_ai_mechz
// Params 2, eflags: 0x0
// Checksum 0xaf38ff31, Offset: 0x10f8
// Size: 0x510
function function_53c37648(s_location, flyin) {
    if (!isdefined(flyin)) {
        flyin = 0;
    }
    if (isdefined(level.var_6c15f1bc[0])) {
        if (isdefined(level.var_7f2a926d)) {
            [[ level.var_7f2a926d ]]();
        }
        level.var_6c15f1bc[0].script_forcespawn = 1;
        ai = zombie_utility::spawn_zombie(level.var_6c15f1bc[0], "mechz", s_location);
        if (isdefined(ai)) {
            ai disableaimassist();
            ai thread function_ef1ba7e5();
            ai thread function_949a3fdf();
            /#
                ai thread function_75a79bb5();
            #/
            ai.actor_damage_func = &namespace_e907cf54::function_2670d89e;
            ai.var_fc8ce4cb = &function_b03abc02;
            ai.var_6f76d887 = &function_55483494;
            ai.health = level.var_53cc405d;
            ai.var_b087942f = level.var_df387ccd;
            ai.var_a59d71f5 = level.var_79d56f1b;
            ai.var_88b6008d = level.var_c31f5c1f;
            ai.var_ec94e7b9 = level.var_2cbc5b59;
            ai.var_bf2b21ce = level.var_2cbc5b59;
            ai.var_51a5fb0a = level.var_2cbc5b59;
            ai.var_88897a65 = level.var_2cbc5b59;
            ai.heroweapon_kill_power = 10;
            e_player = zm_utility::get_closest_player(s_location.origin);
            v_dir = e_player.origin - s_location.origin;
            v_dir = vectornormalize(v_dir);
            v_angles = vectortoangles(v_dir);
            var_89f898ad = zm_utility::flat_angle(v_angles);
            s_spawn_location = s_location;
            queryresult = positionquery_source_navigation(s_spawn_location.origin, 0, 32, 20, 4);
            if (queryresult.data.size) {
                var_80f08819 = array::random(queryresult.data).origin;
            }
            if (!isdefined(var_80f08819)) {
                trace = bullettrace(s_spawn_location.origin, s_spawn_location.origin + (0, 0, -256), 0, s_location);
                var_80f08819 = trace["position"];
            }
            var_1750e965 = var_80f08819;
            if (isdefined(level.var_e1e49cc1)) {
                ai thread [[ level.var_e1e49cc1 ]]();
            }
            ai forceteleport(var_1750e965, var_89f898ad);
            if (flyin === 1) {
                ai thread function_d07fd448();
                ai thread scene::play("cin_zm_castle_mechz_entrance", ai);
                ai thread function_c441eaba(var_1750e965);
                ai thread function_bbdc1f34(var_1750e965);
            } else {
                if (isdefined(level.var_7d2a391d)) {
                    ai thread [[ level.var_7d2a391d ]]();
                }
                ai.var_a1c73f09 = 1;
            }
            ai thread function_bb048b27();
            ai.var_833cfbae = 1;
            /#
                ai.ignore_devgui_death = 1;
            #/
            return ai;
        }
    }
    return undefined;
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x0
// Checksum 0x792c0f16, Offset: 0x1610
// Size: 0x64
function function_d07fd448() {
    self endon(#"death");
    self.var_a1c73f09 = 0;
    self.var_a5db58c6 = 1;
    self util::waittill_any("mechz_flyin_done", "scene_done");
    self.var_a1c73f09 = 1;
    self.var_a5db58c6 = 0;
}

// Namespace zm_ai_mechz
// Params 1, eflags: 0x0
// Checksum 0xef2326b6, Offset: 0x1680
// Size: 0x34c
function function_c441eaba(landing_pos) {
    self endon(#"death");
    var_b54110bd = 2304;
    var_f0dad551 = 9216;
    var_44615973 = 2250000;
    self waittill(#"hash_f93797a6");
    a_zombies = getaiarchetypearray("zombie");
    foreach (e_zombie in a_zombies) {
        dist_sq = distancesquared(e_zombie.origin, landing_pos);
        if (dist_sq <= var_b54110bd) {
            e_zombie kill();
        }
    }
    a_players = getplayers();
    foreach (player in a_players) {
        dist_sq = distancesquared(player.origin, landing_pos);
        if (dist_sq <= var_b54110bd) {
            player dodamage(100, landing_pos, self, self);
        }
        scale = (var_44615973 - dist_sq) / var_44615973;
        if (scale <= 0 || scale >= 1) {
            return;
        }
        var_b8c8da0d = scale * 0.15;
        earthquake(var_b8c8da0d, 0.1, landing_pos, 1500);
        if (scale >= 0.66) {
            player playrumbleonentity("shotgun_fire");
            continue;
        }
        if (scale >= 0.33) {
            player playrumbleonentity("damage_heavy");
            continue;
        }
        player playrumbleonentity("reload_small");
    }
    if (isdefined(self.var_1411e129)) {
        self.var_1411e129 delete();
    }
}

// Namespace zm_ai_mechz
// Params 1, eflags: 0x0
// Checksum 0xfe5d4750, Offset: 0x19d8
// Size: 0x280
function function_bbdc1f34(landing_pos) {
    self endon(#"death");
    self endon(#"hash_f93797a6");
    self waittill(#"hash_3d18ed4f");
    var_f0dad551 = 9216;
    while (true) {
        a_players = getplayers();
        foreach (player in a_players) {
            dist_sq = distancesquared(player.origin, landing_pos);
            if (dist_sq <= var_f0dad551) {
                if (!(isdefined(player.is_burning) && player.is_burning) && zombie_utility::is_player_valid(player, 0)) {
                    player function_3389e2f3(self);
                }
            }
        }
        a_zombies = zm_elemental_zombie::function_d41418b8();
        foreach (e_zombie in a_zombies) {
            dist_sq = distancesquared(e_zombie.origin, landing_pos);
            if (dist_sq <= var_f0dad551 && self.var_e05d0be2 !== 1) {
                self function_3efae612(e_zombie);
                e_zombie zm_elemental_zombie::function_f4defbc2();
            }
        }
        wait 0.1;
    }
}

// Namespace zm_ai_mechz
// Params 1, eflags: 0x0
// Checksum 0x2d8082b7, Offset: 0x1c60
// Size: 0xe0
function function_3389e2f3(mechz) {
    if (!(isdefined(self.is_burning) && self.is_burning) && zombie_utility::is_player_valid(self, 1)) {
        self.is_burning = 1;
        if (!self hasperk("specialty_armorvest")) {
            self burnplayer::setplayerburning(1.5, 0.5, 30, mechz, undefined);
        } else {
            self burnplayer::setplayerburning(1.5, 0.5, 20, mechz, undefined);
        }
        wait 1.5;
        self.is_burning = 0;
    }
}

// Namespace zm_ai_mechz
// Params 6, eflags: 0x0
// Checksum 0xe3945188, Offset: 0x1d48
// Size: 0x2c8
function function_817c85eb(e_player, v_attack_source, n_push_away, n_lift_height, v_lift_offset, n_lift_speed) {
    self endon(#"death");
    if (isdefined(self.in_gravity_trap) && self.in_gravity_trap && e_player.var_887585ba === 3) {
        if (isdefined(self.var_1f5fe943) && self.var_1f5fe943) {
            return;
        }
        self.var_bcecff1d = 1;
        self.var_1f5fe943 = 1;
        self dodamage(10, self.origin);
        self.var_ab0efcf6 = self.origin;
        self thread scene::play("cin_zm_dlc1_mechz_dth_deathray_01", self);
        self clientfield::set("sparky_beam_fx", 1);
        self clientfield::set("death_ray_shock_fx", 1);
        self playsound("zmb_talon_electrocute");
        n_start_time = gettime();
        for (n_total_time = 0; 10 > n_total_time && e_player.var_887585ba === 3; n_total_time = (gettime() - n_start_time) / 1000) {
            util::wait_network_frame();
        }
        self scene::stop("cin_zm_dlc1_mechz_dth_deathray_01");
        self thread function_bb84a54(self);
        self clientfield::set("sparky_beam_fx", 0);
        self clientfield::set("death_ray_shock_fx", 0);
        self.var_bcecff1d = undefined;
        while (e_player.var_887585ba === 3) {
            util::wait_network_frame();
        }
        self.var_1f5fe943 = undefined;
        self.in_gravity_trap = undefined;
        return;
    }
    self dodamage(10, self.origin);
    if (!(isdefined(self.stun) && self.stun)) {
        self.stun = 1;
    }
}

// Namespace zm_ai_mechz
// Params 1, eflags: 0x0
// Checksum 0xba95e5f0, Offset: 0x2018
// Size: 0x1a4
function function_bb84a54(mechz) {
    mechz endon(#"death");
    if (isdefined(mechz)) {
        mechz scene::play("cin_zm_dlc1_mechz_dth_deathray_02", mechz);
    }
    if (isdefined(mechz) && isalive(mechz) && isdefined(mechz.var_ab0efcf6)) {
        var_c430eda8 = mechz gettagorigin("tag_eye");
        /#
            recordline(mechz.origin, var_c430eda8, (0, 255, 0), "<dev string:x45>", mechz);
        #/
        trace = bullettrace(var_c430eda8, mechz.origin, 0, mechz);
        if (trace["position"] !== mechz.origin) {
            point = getclosestpointonnavmesh(trace["position"], 64, 30);
            if (!isdefined(point)) {
                point = mechz.var_ab0efcf6;
            }
            mechz forceteleport(point);
        }
    }
}

// Namespace zm_ai_mechz
// Params 1, eflags: 0x0
// Checksum 0xe573a4a3, Offset: 0x21c8
// Size: 0x102
function function_1add8026(mechz) {
    var_ec9023a6 = mechz.var_ec9023a6;
    a_zombies = zm_elemental_zombie::function_d41418b8();
    foreach (zombie in a_zombies) {
        if (zombie istouching(var_ec9023a6) && zombie.var_e05d0be2 !== 1) {
            zombie zm_elemental_zombie::function_f4defbc2();
        }
    }
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x0
// Checksum 0x46c91e89, Offset: 0x22d8
// Size: 0xa0
function function_ef1ba7e5() {
    self waittill(#"death");
    if (isplayer(self.attacker)) {
        event = "death_mechz";
        if (!(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
            self.attacker zm_score::player_add_points(event, 1500);
        }
        if (isdefined(level.hero_power_update)) {
            [[ level.hero_power_update ]](self.attacker, self);
        }
    }
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x0
// Checksum 0xbe00fcc7, Offset: 0x2380
// Size: 0x172
function function_949a3fdf() {
    self waittill(#"hash_46c1e51d");
    v_origin = self.origin;
    a_ai = getaispeciesarray(level.zombie_team);
    a_ai_kill_zombies = arraysortclosest(a_ai, v_origin, 18, 0, -56);
    foreach (ai_enemy in a_ai_kill_zombies) {
        if (isdefined(ai_enemy)) {
            if (ai_enemy.archetype === "mechz") {
                ai_enemy dodamage(level.var_53cc405d * 0.25, v_origin);
            } else {
                ai_enemy dodamage(ai_enemy.health + 100, v_origin);
            }
        }
        wait 0.05;
    }
}

// Namespace zm_ai_mechz
// Params 12, eflags: 0x0
// Checksum 0x98528f4a, Offset: 0x2500
// Size: 0x10c
function function_b03abc02(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isdefined(attacker) && isplayer(attacker)) {
        if (zm_spawner::player_using_hi_score_weapon(attacker)) {
            damage_type = "damage";
        } else {
            damage_type = "damage_light";
        }
        if (!(isdefined(self.no_damage_points) && self.no_damage_points)) {
            attacker zm_score::player_add_points(damage_type, mod, hitloc, self.isdog, self.team, weapon);
        }
    }
}

// Namespace zm_ai_mechz
// Params 1, eflags: 0x0
// Checksum 0x9a9a3379, Offset: 0x2618
// Size: 0x2a4
function function_3efae612(zombie) {
    zombie.knockdown = 1;
    zombie.knockdown_type = "knockdown_shoved";
    var_82b4832b = self.origin - zombie.origin;
    var_cd6dddb4 = vectornormalize((var_82b4832b[0], var_82b4832b[1], 0));
    zombie_forward = anglestoforward(zombie.angles);
    zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
    zombie_right = anglestoright(zombie.angles);
    zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
    dot = vectordot(var_cd6dddb4, zombie_forward_2d);
    if (dot >= 0.5) {
        zombie.knockdown_direction = "front";
        zombie.getup_direction = "getup_back";
        return;
    }
    if (dot < 0.5 && dot > -0.5) {
        dot = vectordot(var_cd6dddb4, zombie_right_2d);
        if (dot > 0) {
            zombie.knockdown_direction = "right";
            if (math::cointoss()) {
                zombie.getup_direction = "getup_back";
            } else {
                zombie.getup_direction = "getup_belly";
            }
        } else {
            zombie.knockdown_direction = "left";
            zombie.getup_direction = "getup_belly";
        }
        return;
    }
    zombie.knockdown_direction = "back";
    zombie.getup_direction = "getup_belly";
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x0
// Checksum 0xb02e189, Offset: 0x28c8
// Size: 0x10a
function function_55483494() {
    a_zombies = getaiarchetypearray("zombie");
    foreach (zombie in a_zombies) {
        dist_sq = distancesquared(self.origin, zombie.origin);
        if (zombie function_10d36217(self) && dist_sq <= 12544) {
            self function_3efae612(zombie);
        }
    }
}

// Namespace zm_ai_mechz
// Params 1, eflags: 0x0
// Checksum 0x22178440, Offset: 0x29e0
// Size: 0x184
function function_10d36217(mechz) {
    origin = self.origin;
    facing_vec = anglestoforward(mechz.angles);
    enemy_vec = origin - mechz.origin;
    var_ef095088 = (enemy_vec[0], enemy_vec[1], 0);
    var_331bc04c = (facing_vec[0], facing_vec[1], 0);
    var_ef095088 = vectornormalize(var_ef095088);
    var_331bc04c = vectornormalize(var_331bc04c);
    enemy_dot = vectordot(var_331bc04c, var_ef095088);
    if (enemy_dot < 0.7) {
        return false;
    }
    var_c15c560e = vectortoangles(enemy_vec);
    if (abs(angleclamp180(var_c15c560e[0])) > 45) {
        return false;
    }
    return true;
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x0
// Checksum 0xacd20183, Offset: 0x2b70
// Size: 0x58
function function_bb048b27() {
    self endon(#"death");
    while (true) {
        wait randomintrange(9, 14);
        self playsound("zmb_ai_mechz_vox_ambient");
    }
}

// Namespace zm_ai_mechz
// Params 0, eflags: 0x0
// Checksum 0x30cb72ac, Offset: 0x2bd0
// Size: 0x98
function function_75a79bb5() {
    self endon(#"death");
    /#
        while (true) {
            if (isdefined(level.var_70068a8) && level.var_70068a8) {
                if (self.health > 0) {
                    print3d(self.origin + (0, 0, 72), self.health, (0, 0.8, 0.6), 3);
                }
            }
            wait 0.05;
        }
    #/
}

/#

    // Namespace zm_ai_mechz
    // Params 0, eflags: 0x4
    // Checksum 0x262e6075, Offset: 0x2c70
    // Size: 0x44
    function private function_fbad70fd() {
        level flagsys::wait_till("<dev string:x4c>");
        zm_devgui::add_custom_devgui_callback(&function_94a24a91);
    }

    // Namespace zm_ai_mechz
    // Params 1, eflags: 0x4
    // Checksum 0x4f4e362b, Offset: 0x2cc0
    // Size: 0x40e
    function private function_94a24a91(cmd) {
        players = getplayers();
        var_6aad1b23 = getentarray("<dev string:x65>", "<dev string:x6b>");
        mechz = arraygetclosest(getplayers()[0].origin, var_6aad1b23);
        switch (cmd) {
        case "<dev string:x76>":
            queryresult = positionquery_source_navigation(players[0].origin, -128, 256, -128, 20);
            spot = spawnstruct();
            spot.origin = players[0].origin;
            if (isdefined(queryresult) && queryresult.data.size > 0) {
                spot.origin = queryresult.data[0].origin;
            }
            mechz = function_53c37648(spot);
            break;
        case "<dev string:x82>":
            if (!isdefined(level.zm_loc_types["<dev string:x94>"]) || level.zm_loc_types["<dev string:x94>"].size == 0) {
                iprintln("<dev string:xa3>");
            }
            spot = arraygetclosest(getplayers()[0].origin, level.zm_loc_types["<dev string:x94>"]);
            if (isdefined(spot)) {
                mechz = function_53c37648(spot, 1);
            } else {
                iprintln("<dev string:xa3>");
            }
            break;
        case "<dev string:xe3>":
            if (isdefined(mechz)) {
                mechz kill();
            }
            break;
        case "<dev string:xee>":
            if (isdefined(mechz)) {
                if (isdefined(mechz.var_c45cab8d)) {
                    mechz.var_c45cab8d = !mechz.var_c45cab8d;
                } else {
                    mechz.var_c45cab8d = 1;
                }
            }
            break;
        case "<dev string:xfc>":
            if (isdefined(mechz)) {
                if (isdefined(mechz.var_8d96ebb6)) {
                    mechz.var_8d96ebb6 = !mechz.var_8d96ebb6;
                } else {
                    mechz.var_8d96ebb6 = 1;
                }
            }
            break;
        case "<dev string:x108>":
            if (isdefined(mechz)) {
                mechz.berserk = 1;
            }
            break;
        case "<dev string:x116>":
            if (!(isdefined(level.var_70068a8) && level.var_70068a8)) {
                level.var_70068a8 = 1;
            } else {
                level.var_70068a8 = 0;
            }
            break;
        case "<dev string:x12f>":
            if (!(isdefined(level.var_da353fa7) && level.var_da353fa7)) {
                level.var_da353fa7 = 1;
            } else {
                level.var_da353fa7 = 0;
            }
            break;
        }
    }

#/
