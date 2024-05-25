#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;

#namespace namespace_88f87109;

// Namespace namespace_88f87109
// Params 0, eflags: 0x2
// Checksum 0x8ff137dd, Offset: 0x8f8
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_ai_napalm", &__init__, &__main__, undefined);
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0xa7308638, Offset: 0x940
// Size: 0x24
function __init__() {
    init_clientfields();
    registerbehaviorscriptfunctions();
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x1627b888, Offset: 0x970
// Size: 0x22c
function __main__() {
    function_3d223bfa();
    level.var_f9bce152 = 1;
    level.var_1c3286bb = 1;
    level.var_7c1c71fd = 2;
    level.var_8142be55 = 5;
    level.var_bc016baa = level.var_8142be55 + randomintrange(0, level.var_7c1c71fd + 1);
    level.var_7db4d141 = -6;
    level.var_431cf17b = 90;
    level.var_987c224a = 90;
    level.var_90d883b = 150;
    level.var_18d2e248 = 400;
    level.var_912e725c = 250;
    level.var_2ac38bea = 50;
    level.var_f94fef01 = 4;
    level.var_57ecc1a3 = 0;
    level.var_4e4c9791 = [];
    level.var_2af0c209 = getentarray("napalm_zombie_spawner", "script_noteworthy");
    level flag::init("zombie_napalm_force_spawn");
    array::thread_all(level.var_2af0c209, &spawner::add_spawn_function, &function_d4f3a23b);
    array::thread_all(level.var_2af0c209, &spawner::add_spawn_function, &zombie_utility::round_spawn_failsafe);
    function_cc531c14();
    zm_spawner::register_zombie_damage_callback(&function_f9326691);
    level thread function_7cce5d95();
    /#
        println("napalm_spawn" + level.var_bc016baa);
    #/
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0xafabcf7b, Offset: 0xba8
// Size: 0x7c
function registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("napalmExplodeInitialize", &function_57d83ba3);
    behaviortreenetworkutility::registerbehaviortreescriptapi("napalmExplodeTerminate", &function_6e3311ba);
    behaviortreenetworkutility::registerbehaviortreescriptapi("napalmCanExplode", &function_2f8b3dd3);
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x81a19d12, Offset: 0xc30
// Size: 0xa
function function_6c57f6af() {
    return level.var_2af0c209;
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x36dbdd3e, Offset: 0xc48
// Size: 0x14
function function_3cde9794() {
    return level.zm_loc_types["napalm_location"];
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0xf1a597e3, Offset: 0xc68
// Size: 0x12c
function function_b765d5ff() {
    forcespawn = level flag::get("zombie_napalm_force_spawn");
    if (!isdefined(level.var_f9bce152) || level.var_f9bce152 == 0 || level.var_2af0c209.size == 0 || level.zm_loc_types["napalm_location"].size == 0) {
        return false;
    }
    if (isdefined(level.var_543dd399) && level.var_543dd399 > 0) {
        return false;
    }
    /#
        if (getdvarint("napalm_spawn") != 0) {
            return true;
        }
    #/
    if (level.var_57ecc1a3 >= level.round_number) {
        return false;
    }
    if (forcespawn) {
        return true;
    }
    if (level.var_bc016baa > level.round_number) {
        return false;
    }
    if (level.zombie_total == 0) {
        return false;
    }
    return level.zombie_total < level.var_b5bd3144;
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0xcdd92b83, Offset: 0xda0
// Size: 0x108
function function_7cce5d95() {
    level waittill(#"start_of_round");
    while (true) {
        if (function_b765d5ff()) {
            var_1c80cf96 = function_6c57f6af();
            location_list = function_3cde9794();
            spawner = array::random(var_1c80cf96);
            location = array::random(location_list);
            ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, location);
            if (isdefined(ai)) {
                ai.spawn_point_override = location;
            }
        }
        wait(3);
    }
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0xc8ccaf8a, Offset: 0xeb0
// Size: 0xdc
function function_8f86441a() {
    self endon(#"death");
    spot = self.spawn_point_override;
    self.spawn_point = spot;
    if (isdefined(spot.target)) {
        self.target = spot.target;
    }
    if (isdefined(spot.zone_name)) {
        self.zone_name = spot.zone_name;
    }
    if (isdefined(spot.script_parameters)) {
        self.script_parameters = spot.script_parameters;
    }
    self thread zm_spawner::do_zombie_rise(spot);
    thread function_df01587c();
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x337c0ca3, Offset: 0xf98
// Size: 0x6c
function function_df01587c() {
    wait(2);
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("general", "napalm_spawn");
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x5eb49ddd, Offset: 0x1010
// Size: 0x13c
function function_cc531c14() {
    level.var_508bafce["napalm_zombie"] = [];
    level.var_508bafce["napalm_zombie"]["ambient"] = "napalm_ambient";
    level.var_508bafce["napalm_zombie"]["sprint"] = "napalm_ambient";
    level.var_508bafce["napalm_zombie"]["attack"] = "napalm_attack";
    level.var_508bafce["napalm_zombie"]["teardown"] = "napalm_attack";
    level.var_508bafce["napalm_zombie"]["taunt"] = "napalm_ambient";
    level.var_508bafce["napalm_zombie"]["behind"] = "napalm_ambient";
    level.var_508bafce["napalm_zombie"]["death"] = "napalm_explode";
    level.var_508bafce["napalm_zombie"]["crawler"] = "napalm_ambient";
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x0
// Checksum 0x8c421f49, Offset: 0x1158
// Size: 0x70
function function_4f171186(zone) {
    for (i = 0; i < zone.volumes.size; i++) {
        if (self istouching(zone.volumes[i])) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x21e0b5c, Offset: 0x11d0
// Size: 0x136
function function_3d223bfa() {
    level._effect["napalm_fire_forearm"] = "dlc5/temple/fx_ztem_napalm_zombie_forearm";
    level._effect["napalm_fire_torso"] = "dlc5/temple/fx_ztem_napalm_zombie_torso";
    level._effect["napalm_fire_ground"] = "dlc5/temple/fx_ztem_napalm_zombie_ground2";
    level._effect["napalm_explosion"] = "dlc5/temple/fx_ztem_napalm_zombie_exp";
    level._effect["napalm_fire_trigger"] = "dlc5/temple/fx_ztem_napalm_zombie_end2";
    level._effect["napalm_spawn"] = "dlc5/temple/fx_ztem_napalm_zombie_spawn7";
    level._effect["napalm_distortion"] = "dlc5/temple/fx_ztem_napalm_zombie_heat";
    level._effect["napalm_fire_forearm_end"] = "dlc5/temple/fx_ztem_napalm_zombie_torso_end";
    level._effect["napalm_fire_torso_end"] = "dlc5/temple/fx_ztem_napalm_zombie_forearm_end";
    level._effect["napalm_steam"] = "dlc5/temple/fx_ztem_zombie_torso_steam_runner";
    level._effect["napalm_feet_steam"] = "dlc5/temple/fx_ztem_zombie_torso_steam_runner";
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// Checksum 0x8e9c65eb, Offset: 0x1310
// Size: 0x2b4
function function_d4f3a23b(var_86a233b2) {
    self.custom_location = &function_8f86441a;
    zm_spawner::zombie_spawn_init(var_86a233b2);
    /#
        println("napalm_spawn");
        setdvar("napalm_spawn", 0);
    #/
    level.var_57ecc1a3 = level.round_number;
    self.animname = "napalm_zombie";
    self thread function_21e7ad0c();
    self.var_9d14450b = 0;
    self.maxhealth *= getplayers().size * level.var_f94fef01;
    self.health = self.maxhealth;
    self.no_gib = 1;
    self.var_9da96e67 = 1;
    self.no_damage_points = 1;
    self.var_41234a0f = 0;
    self.ignore_enemy_count = 1;
    self.deathfunction = &function_e94aef80;
    self.var_33e307a5 = &function_f7185ce8;
    self.nuke_damage_func = &function_1feb51eb;
    self.instakill_func = undefined;
    self.var_399caee8 = &function_599d1f9;
    self.var_c1d20f2f = &function_bbad02fc;
    self.var_92ce1c50 = &function_b385a7c4;
    self.custom_damage_func = &function_f5c6bf60;
    self.var_1b022f6c = &function_5364f2e8;
    self.var_9c07a8f = gettime() + 2000;
    self thread function_d608f9e8();
    self thread function_dda5f921();
    self thread function_be2d1dbb();
    self.zombie_move_speed = "walk";
    self.zombie_arms_position = "up";
    self.variant_type = randomint(3);
    self playsound("evt_napalm_zombie_spawn");
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x9df19e78, Offset: 0x15d0
// Size: 0x5c
function function_21e7ad0c() {
    self clientfield::set("isnapalm", 1);
    self waittill(#"death");
    self clientfield::set("isnapalm", 0);
    function_5b729ab1();
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1638
// Size: 0x4
function function_1feb51eb() {
    
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1648
// Size: 0x4
function function_49b55df8() {
    
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// Checksum 0xae1b7e2f, Offset: 0x1658
// Size: 0x4c
function function_f5c6bf60(player) {
    damage = self.meleedamage;
    if (isdefined(self.var_8bb963d6)) {
        damage = int(self.var_8bb963d6);
    }
    return damage;
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x0
// Checksum 0x3134ea64, Offset: 0x16b0
// Size: 0x1e6
function function_d7b6f45e() {
    fx = [];
    fx["J_Elbow_LE"] = "napalm_fire_forearm_end";
    fx["J_Elbow_RI"] = "napalm_fire_forearm_end";
    fx["J_Clavicle_RI"] = "napalm_fire_forearm_end";
    fx["J_Clavicle_LE"] = "napalm_fire_forearm_end";
    fx["J_SpineLower"] = "napalm_fire_torso_end";
    offsets["J_SpineLower"] = (0, 10, 0);
    watch = [];
    keys = getarraykeys(fx);
    for (i = 0; i < keys.size; i++) {
        var_80afd72e = keys[i];
        fxname = fx[var_80afd72e];
        offset = offsets[var_80afd72e];
        var_8d78a1c5 = self function_ca29873(var_80afd72e, fxname, offset);
        watch[i] = var_8d78a1c5;
    }
    self waittill(#"stop_fx");
    if (!isdefined(self)) {
        return;
    }
    for (i = 0; i < watch.size; i++) {
        watch[i] delete();
    }
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0xe07f6530, Offset: 0x18a0
// Size: 0x54
function function_d608f9e8() {
    self waittill(#"death");
    self notify(#"stop_fx");
    if (level flag::get("world_is_paused")) {
        self setignorepauseworld(1);
    }
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x5 linked
// Checksum 0xc45317e8, Offset: 0x1900
// Size: 0x312
function private function_2f8b3dd3(entity) {
    if (entity.animname !== "napalm_zombie") {
        return false;
    }
    if (level.var_431cf17b <= 0) {
        return false;
    }
    var_3a8650c7 = level.var_431cf17b * level.var_431cf17b;
    var_a5ef7d65 = level.var_18d2e248;
    var_89d10b4d = var_a5ef7d65 * var_a5ef7d65;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!zombie_utility::is_player_valid(player)) {
            continue;
        }
        if (distance2dsquared(player.origin, entity.origin) < var_89d10b4d) {
            if (!isdefined(player.var_9a54b373) || player.var_9a54b373 <= gettime() - 0.1) {
                player clientfield::set_to_player("napalm_pstfx_burn", 1);
                player playloopsound("chr_burning_loop", 1);
                player.var_9a54b373 = gettime() + 10000;
            }
        } else {
            if (isdefined(player.var_9a54b373) && player.var_9a54b373 > gettime()) {
                player function_ccb31370();
            }
            continue;
        }
        if (!isdefined(entity.favoriteenemy) || !isplayer(entity.favoriteenemy)) {
            continue;
        }
        if (isdefined(entity.in_the_ground) && entity.in_the_ground) {
            continue;
        }
        if (entity.var_9c07a8f > gettime()) {
            continue;
        }
        if (abs(player.origin[2] - entity.origin[2]) > 50) {
            continue;
        }
        if (distance2dsquared(player.origin, entity.origin) > var_3a8650c7) {
            continue;
        }
        return true;
    }
    return false;
}

// Namespace namespace_88f87109
// Params 2, eflags: 0x5 linked
// Checksum 0x65a80b3d, Offset: 0x1c20
// Size: 0x94
function private function_57d83ba3(entity, asmstatename) {
    if (level flag::get("world_is_paused")) {
        entity setignorepauseworld(1);
    }
    entity clientfield::set("napalmexplode", 1);
    entity playsound("evt_napalm_zombie_charge");
}

// Namespace namespace_88f87109
// Params 2, eflags: 0x5 linked
// Checksum 0x994bba71, Offset: 0x1cc0
// Size: 0x6c
function private function_6e3311ba(entity, asmstatename) {
    function_5b729ab1();
    entity.var_4b9b9c47 = 1;
    entity dodamage(entity.health + 666, entity.origin);
}

// Namespace namespace_88f87109
// Params 8, eflags: 0x1 linked
// Checksum 0x853f0eff, Offset: 0x1d38
// Size: 0x36a
function function_e94aef80(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    var_59349626 = array::get_all_closest(self.origin, getaispeciesarray("axis", "all"), undefined, undefined, level.var_7db4d141);
    dogs = array::get_all_closest(self.origin, getaispeciesarray("allies", "zombie_dog"), undefined, undefined, level.var_7db4d141);
    zombies = arraycombine(var_59349626, dogs, 0, 0);
    if (isdefined(level._effect["napalm_explosion"])) {
        playfxontag(level._effect["napalm_explosion"], self, "J_SpineLower");
    }
    self playsound("evt_napalm_zombie_explo");
    if (isdefined(self.attacker) && isplayer(self.attacker)) {
        self.attacker thread zm_audio::create_and_play_dialog("kill", "napalm");
    }
    level notify(#"hash_1a72a54d", self.var_41234a0f);
    self thread function_ed8847e4();
    if (!self function_4d3efce9(1)) {
        level thread function_daf2d7cc(self, 80, 20, 0);
    }
    self thread function_5bb7b4c9(zombies);
    function_5b729ab1();
    self function_1f9a4246();
    if (isdefined(self.attacker) && isplayer(self.attacker) && !(isdefined(self.var_4b9b9c47) && self.var_4b9b9c47) && !(isdefined(self.var_42a5fd49) && self.var_42a5fd49)) {
        players = level.players;
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (zombie_utility::is_player_valid(player)) {
                player zm_score::player_add_points("thundergun_fling", 300, (0, 0, 0), 0);
            }
        }
    }
    return self zm_spawner::zombie_death_animscript();
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x6bbb7a0a, Offset: 0x20b0
// Size: 0x64
function function_ed8847e4() {
    self endon(#"death");
    self setplayercollision(0);
    self thread zombie_utility::zombie_eye_glow_stop();
    util::wait_network_frame();
    self hide();
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// Checksum 0x24248c19, Offset: 0x2120
// Size: 0x28e
function function_5bb7b4c9(zombies) {
    eyeorigin = self geteye();
    if (!isdefined(zombies)) {
        return;
    }
    damageorigin = self.origin;
    var_cab94331 = self function_4d3efce9();
    for (i = 0; i < zombies.size; i++) {
        if (!isdefined(zombies[i])) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
            continue;
        }
        test_origin = zombies[i] geteye();
        if (!bullettracepassed(eyeorigin, test_origin, 0, undefined)) {
            continue;
        }
        if (zombies[i].animname == "napalm_zombie") {
            continue;
        }
        if (!var_cab94331) {
            zombies[i] thread zombie_death::flame_death_fx();
        }
        refs = [];
        refs[refs.size] = "guts";
        refs[refs.size] = "right_arm";
        refs[refs.size] = "left_arm";
        refs[refs.size] = "right_leg";
        refs[refs.size] = "left_leg";
        refs[refs.size] = "no_legs";
        refs[refs.size] = "head";
        if (refs.size) {
            zombies[i].a.gib_ref = array::random(refs);
        }
        zombies[i] dodamage(zombies[i].health + 666, damageorigin);
        util::wait_network_frame();
    }
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x2e8a8fe6, Offset: 0x23b8
// Size: 0x51a
function function_1f9a4246() {
    eyeorigin = self geteye();
    var_96a4164b = self.origin + (0, 0, 8);
    midorigin = (var_96a4164b[0], var_96a4164b[1], (var_96a4164b[2] + eyeorigin[2]) / 2);
    var_6e70af43 = 0;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (!zombie_utility::is_player_valid(players[i])) {
            continue;
        }
        test_origin = players[i] geteye();
        damageradius = level.var_18d2e248;
        if (isdefined(self.var_2ef06f9b) && self.var_2ef06f9b) {
            damageradius = level.var_912e725c;
        }
        if (distancesquared(eyeorigin, test_origin) > damageradius * damageradius) {
            continue;
        }
        var_aa2a6499 = players[i].origin + (0, 0, 8);
        var_db6ebc8d = (var_aa2a6499[0], var_aa2a6499[1], (var_aa2a6499[2] + test_origin[2]) / 2);
        if (!bullettracepassed(eyeorigin, test_origin, 0, undefined)) {
            if (!bullettracepassed(midorigin, var_db6ebc8d, 0, undefined)) {
                if (!bullettracepassed(var_96a4164b, var_aa2a6499, 0, undefined)) {
                    continue;
                }
            }
        }
        var_6e70af43 = 1;
        if (isdefined(level._effect["player_fire_death_napalm"])) {
            playfxontag(level._effect["player_fire_death_napalm"], players[i], "J_SpineLower");
        }
        dist = distance(eyeorigin, test_origin);
        var_e5480b31 = 100;
        var_4d433f7f = -6;
        var_85a789c4 = 1.5;
        var_18bc0b3e = 3;
        damage = level.var_2ac38bea;
        shellshocktime = var_18bc0b3e;
        if (dist < level.var_987c224a) {
            damage = var_4d433f7f;
        } else if (dist < level.var_90d883b) {
            damage = var_e5480b31;
        } else {
            scale = (level.var_18d2e248 - dist) / (level.var_18d2e248 - level.var_90d883b);
            shellshocktime = scale * (var_18bc0b3e - var_85a789c4) + var_85a789c4;
            damage = scale * (var_e5480b31 - level.var_2ac38bea) + level.var_2ac38bea;
        }
        if (isdefined(self.var_42a5fd49) && self.var_42a5fd49) {
            damage *= 0.25;
            shellshocktime *= 0.25;
        }
        if (isdefined(self.var_2ef06f9b) && self.var_2ef06f9b) {
            damage *= 0.25;
            shellshocktime *= 0.25;
        }
        self.var_8bb963d6 = damage;
        players[i] dodamage(damage, self.origin, self);
        players[i] shellshock("explosion", shellshocktime);
        players[i] thread zm_audio::create_and_play_dialog("kill", "napalm");
    }
    if (!var_6e70af43) {
        level notify(#"hash_8a1fe43");
    }
}

// Namespace namespace_88f87109
// Params 4, eflags: 0x1 linked
// Checksum 0xf99d30ad, Offset: 0x28e0
// Size: 0x28c
function function_daf2d7cc(ai, radius, time, var_d5514a) {
    var_37000f64 = ai.animname == "napalm_zombie";
    if (!var_37000f64) {
        radius /= 2;
    }
    spawnflags = 1;
    trigger = spawn("trigger_radius", ai.origin, spawnflags, radius, 70);
    sound_ent = undefined;
    if (!isdefined(trigger)) {
        return;
    }
    if (var_37000f64) {
        if (var_d5514a) {
            trigger.var_7c722deb = 10;
        } else {
            trigger.var_7c722deb = 40;
        }
        trigger.var_3a9ecef6 = "burned";
        if (!var_d5514a && isdefined(level._effect["napalm_fire_trigger"])) {
            sound_ent = spawn("script_origin", ai.origin);
            sound_ent playloopsound("evt_napalm_fire", 1);
            playfx(level._effect["napalm_fire_trigger"], ai.origin);
        }
    } else {
        trigger.var_7c722deb = 10;
        trigger.var_3a9ecef6 = "triggerhurt";
        if (var_d5514a) {
            ai thread zombie_death::flame_death_fx();
        }
    }
    trigger thread function_f38df394();
    wait(time);
    trigger notify(#"hash_2a702971");
    trigger delete();
    if (isdefined(sound_ent)) {
        sound_ent stoploopsound(1);
        wait(1);
        sound_ent delete();
    }
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0xe959757b, Offset: 0x2b78
// Size: 0x140
function function_f38df394() {
    self endon(#"hash_2a702971");
    while (true) {
        guy = self waittill(#"trigger");
        if (isplayer(guy)) {
            if (zombie_utility::is_player_valid(guy)) {
                debounce = 500;
                if (!isdefined(guy.var_457020be)) {
                    guy.var_457020be = -1 * debounce;
                }
                if (guy.var_457020be + debounce < gettime()) {
                    guy dodamage(self.var_7c722deb, guy.origin, undefined, undefined, self.var_3a9ecef6);
                    guy.var_457020be = gettime();
                }
            }
            continue;
        }
        if (guy.animname != "napalm_zombie") {
            guy thread function_3d43bbbb(self.var_3a9ecef6);
        }
    }
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// Checksum 0x484bf1bd, Offset: 0x2cc0
// Size: 0x11c
function function_3d43bbbb(damagetype) {
    self endon(#"death");
    if (isdefined(self.marked_for_death)) {
        return;
    }
    self.marked_for_death = 1;
    if (self.animname == "monkey_zombie") {
    } else {
        if (!isdefined(level.burning_zombies)) {
            level.burning_zombies = [];
        }
        if (level.burning_zombies.size < 6) {
            level.burning_zombies[level.burning_zombies.size] = self;
            self thread zombie_flame_watch();
            self playsound("evt_zombie_ignite");
            self thread zombie_death::flame_death_fx();
            wait(randomfloat(1.25));
        }
    }
    self dodamage(self.health + 666, self.origin, undefined, undefined, damagetype);
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x37b30d6c, Offset: 0x2de8
// Size: 0x8c
function zombie_flame_watch() {
    if (isdefined(level.mutators) && level.mutators["mutator_noTraps"]) {
        return;
    }
    self waittill(#"death");
    if (isdefined(self)) {
        self stoploopsound();
        arrayremovevalue(level.burning_zombies, self);
        return;
    }
    array::remove_undefined(level.burning_zombies);
}

// Namespace namespace_88f87109
// Params 2, eflags: 0x0
// Checksum 0xdbc1d952, Offset: 0x2e80
// Size: 0x11c
function array_remove(array, object) {
    if (!isdefined(array) && !isdefined(object)) {
        return;
    }
    new_array = [];
    foreach (item in array) {
        if (item != object) {
            if (!isdefined(new_array)) {
                new_array = [];
            } else if (!isarray(new_array)) {
                new_array = array(new_array);
            }
            new_array[new_array.size] = item;
        }
    }
    return new_array;
}

// Namespace namespace_88f87109
// Params 3, eflags: 0x1 linked
// Checksum 0x143b6f64, Offset: 0x2fa8
// Size: 0x110
function function_ca29873(var_80afd72e, fxname, offset) {
    origin = self gettagorigin(var_80afd72e);
    var_8d78a1c5 = spawn("script_model", origin);
    var_8d78a1c5 setmodel("tag_origin");
    var_8d78a1c5.angles = self gettagangles(var_80afd72e);
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    var_8d78a1c5 linkto(self, var_80afd72e, offset);
    playfxontag(level._effect[fxname], var_8d78a1c5, "tag_origin");
    return var_8d78a1c5;
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x30c0
// Size: 0x4
function function_599d1f9() {
    
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x30d0
// Size: 0x4
function function_bbad02fc() {
    
}

// Namespace namespace_88f87109
// Params 13, eflags: 0x1 linked
// Checksum 0x6d4173ff, Offset: 0x30e0
// Size: 0x88
function function_f9326691(str_mod, var_5afff096, var_7c5a4ee4, e_player, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (self.classname == "actor_spawner_zm_temple_napalm") {
        return true;
    }
    return false;
}

// Namespace namespace_88f87109
// Params 11, eflags: 0x1 linked
// Checksum 0xc6adeea3, Offset: 0x3170
// Size: 0xfa
function function_f7185ce8(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
    if (level.zombie_vars["zombie_insta_kill"]) {
        damage *= 2;
    }
    if (isdefined(self.var_2ef06f9b) && self.var_2ef06f9b) {
        damage *= 5;
    } else if (self function_4d3efce9()) {
        damage *= 2;
    }
    switch (weapon) {
    case 85:
        damage = 0;
        break;
    }
    return damage;
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0xa533374, Offset: 0x3278
// Size: 0xf4
function function_be2d1dbb() {
    if (!isdefined(level.var_543dd399)) {
        level.var_543dd399 = 0;
    }
    level.var_543dd399++;
    level.var_4e4c9791[level.var_4e4c9791.size] = self;
    self waittill(#"death");
    level.var_543dd399--;
    arrayremovevalue(level.var_4e4c9791, self, 0);
    if (isdefined(self.var_42a5fd49) && self.var_42a5fd49) {
        level.var_bc016baa = level.round_number + 1;
    } else {
        level.var_bc016baa = level.round_number + randomintrange(level.var_1c3286bb, level.var_7c1c71fd + 1);
    }
    /#
        println("napalm_spawn" + level.var_bc016baa);
    #/
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0xf6b61c0e, Offset: 0x3378
// Size: 0x86
function function_5b729ab1() {
    players = getplayers();
    for (j = 0; j < players.size; j++) {
        var_f2d05aa4 = players[j];
        if (!isdefined(var_f2d05aa4)) {
            continue;
        }
        var_f2d05aa4 function_ccb31370();
    }
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x1e096059, Offset: 0x3408
// Size: 0x48
function function_ccb31370() {
    self clientfield::set_to_player("napalm_pstfx_burn", 0);
    self stoploopsound(2);
    self.var_9a54b373 = gettime();
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x682a88f5, Offset: 0x3458
// Size: 0xc4
function init_clientfields() {
    clientfield::register("actor", "napalmwet", 21000, 1, "int");
    clientfield::register("actor", "napalmexplode", 21000, 1, "int");
    clientfield::register("actor", "isnapalm", 21000, 1, "int");
    clientfield::register("toplayer", "napalm_pstfx_burn", 21000, 1, "int");
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// Checksum 0xbda720e0, Offset: 0x3528
// Size: 0x2c
function function_b385a7c4(trigger) {
    self endon(#"death");
    self thread function_4484161d(4);
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// Checksum 0x6ab671e7, Offset: 0x3560
// Size: 0xb8
function function_4484161d(time) {
    self endon(#"death");
    var_4a738130 = time * 1000;
    self.var_dc0e4dc9 = gettime() + var_4a738130;
    if (isdefined(self.var_2ef06f9b) && self.var_2ef06f9b) {
        return;
    }
    self.var_2ef06f9b = 1;
    self thread function_c0554f0f();
    while (self.var_dc0e4dc9 > gettime()) {
        wait(0.1);
    }
    self thread function_41d418e2();
    self.var_2ef06f9b = 0;
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0xfd512e4f, Offset: 0x3620
// Size: 0x4e
function function_dda5f921() {
    self endon(#"death");
    while (true) {
        if (isdefined(self.sliding) && self.sliding) {
            self thread function_4484161d(4);
        }
        wait(1);
    }
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0xed7171bc, Offset: 0x3678
// Size: 0x24
function function_c0554f0f() {
    self clientfield::set("napalmwet", 1);
}

// Namespace namespace_88f87109
// Params 0, eflags: 0x1 linked
// Checksum 0x7af64c26, Offset: 0x36a8
// Size: 0x24
function function_41d418e2() {
    self clientfield::set("napalmwet", 0);
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// Checksum 0xdd0bddd5, Offset: 0x36d8
// Size: 0xba
function function_4d3efce9(var_1af4d9fe) {
    dotrace = !isdefined(self.var_fab72ea1);
    dotrace = dotrace || self.var_fab72ea1 < gettime();
    dotrace = isdefined(var_1af4d9fe) && (dotrace || var_1af4d9fe);
    if (dotrace) {
        self.var_fab72ea1 = gettime() + 500;
        waterheight = getwaterheight(self.origin);
        self.var_da586a5 = waterheight > self.origin[2];
    }
    return self.var_da586a5;
}

// Namespace namespace_88f87109
// Params 1, eflags: 0x1 linked
// Checksum 0xec576843, Offset: 0x37a0
// Size: 0x10
function function_5364f2e8(var_7e84184) {
    return true;
}

