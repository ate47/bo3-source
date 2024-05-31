#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_light_zombie;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_shadow_zombie;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_ai_margwa_no_idgun;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_behavior;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/margwa;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace namespace_3de4ab6f;

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x2
// Checksum 0x239f4434, Offset: 0xf10
// Size: 0x1ec
function autoexec init() {
    function_afef488b();
    spawner::add_archetype_spawn_function("margwa", &function_e1859566);
    clientfield::register("actor", "margwa_elemental_type", 15000, 3, "int");
    clientfield::register("actor", "margwa_defense_actor_appear_disappear_fx", 15000, 1, "int");
    clientfield::register("scriptmover", "play_margwa_fire_attack_fx", 15000, 1, "counter");
    clientfield::register("scriptmover", "margwa_defense_hovering_fx", 15000, 3, "int");
    clientfield::register("actor", "shadow_margwa_attack_portal_fx", 15000, 1, "int");
    clientfield::register("actor", "margwa_shock_fx", 15000, 1, "int");
    var_91a17b7d = getentarray("zombie_wasp_elite_spawner", "script_noteworthy");
    if (isdefined(var_91a17b7d) && var_91a17b7d.size > 0) {
        level.var_39c0c115 = var_91a17b7d[0];
    }
    zm::register_actor_damage_callback(&function_5ff4198);
    /#
        level thread function_15492d9b();
    #/
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0xc384f8db, Offset: 0x1108
// Size: 0x7d4
function private function_afef488b() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaFireAttackService", &brrebirth_triggerrespawnoverlay);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaFireDefendService", &function_c8dea044);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaElectricGroundAttackService", &function_744188c1);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaElectricShootAttackService", &function_7652cccb);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaElectricDefendService", &function_39eece3f);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaLightAttackService", &function_655b9672);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaLightDefendService", &function_64e5bb2);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShadowAttackService", &function_43079630);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShadowDefendService", &function_50654c28);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldFireAttack", &function_78f83c26);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldFireDefendOut", &function_782e86fb);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldFireDefendIn", &function_836eeae4);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldElectricGroundAttack", &function_eb0118e7);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldElectricShootAttack", &function_2672a46d);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldElectricDefendOut", &function_efc320f8);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldElectricDefendIn", &function_bcd55721);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldLightAttack", &function_fd4fb480);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldLightDefendOut", &function_5bfc92ed);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldLightDefendIn", &function_412d8b9a);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldShadowAttack", &function_dfedf376);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldShadowAttackLoop", &function_a5dc38a7);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldShadowAttackOut", &function_f2802e4b);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldShadowDefendOut", &function_87dfc76b);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldShadowDefendIn", &function_6af3c534);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaFireAttack", &function_face7ad8);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaFireAttackTerminate", &function_68e3291c);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaFireDefendOut", &function_99ba2c25);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaFireDefendOutTerminate", &function_6a7ddf05);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaFireDefendIn", &function_75f40972);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaFireDefendInTerminate", &function_cd27e3fa);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaElectricGroundAttack", &function_b473ad25);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaElectricShootAttack", &function_6619b5ab);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaElectricDefendOut", &function_8382b576);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaElectricDefendOutTerminate", &function_3c8bea36);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaElectricDefendIn", &function_11d72a03);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaLightAttack", &function_226a6f4a);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaLightDefendOut", &function_9c7737ef);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaLightDefendOutTerminate", &function_5d88ac4b);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaLightDefendIn", &function_c2614d30);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShadowAttack", &function_9a9f35ac);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShadowAttackLoop", &function_ae1bcedd);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShadowAttackLoopTerminate", &function_58c0f99d);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShadowAttackOutTerminate", &function_d89cf919);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShadowDefendOut", &function_d765e859);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShadowDefendOutTerminate", &function_4600a191);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShadowDefendIn", &function_d258371e);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaIsElectric", &function_3cfb8731);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaIsFire", &function_6bbd2a18);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaIsLight", &function_7db0458);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaIsShadow", &function_b9fad980);
}

// Namespace namespace_3de4ab6f
// Params 4, eflags: 0x1 linked
// Checksum 0xe5a2522b, Offset: 0x18e8
// Size: 0x5a4
function function_eb5051f4(spawner, targetname, var_f9ebd43e, s_location) {
    if (isdefined(spawner)) {
        level.var_2c028bba = undefined;
        level.var_72374095 = undefined;
        level.var_c9a18bd = undefined;
        level.var_4182a531 = undefined;
        level.var_7ff16e00 = undefined;
        level.var_b9c5d5f0 = undefined;
        switch (var_f9ebd43e) {
        case 75:
            level.var_2c028bba = "c_zom_dlc4_margwa_chunks_le_fire";
            level.var_72374095 = "c_zom_dlc4_margwa_chunks_mid_fire";
            level.var_c9a18bd = "c_zom_dlc4_margwa_chunks_ri_fire";
            level.var_4182a531 = "c_zom_dlc4_margwa_gore_le_fire";
            level.var_7ff16e00 = "c_zom_dlc4_margwa_gore_mid_fire";
            level.var_b9c5d5f0 = "c_zom_dlc4_margwa_gore_ri_fire";
            break;
        case 76:
            level.var_2c028bba = "c_zom_dlc4_margwa_chunks_le_shadow";
            level.var_72374095 = "c_zom_dlc4_margwa_chunks_mid_shadow";
            level.var_c9a18bd = "c_zom_dlc4_margwa_chunks_ri_shadow";
            level.var_4182a531 = "c_zom_dlc4_margwa_gore_le_shadow";
            level.var_7ff16e00 = "c_zom_dlc4_margwa_gore_mid_shadow";
            level.var_b9c5d5f0 = "c_zom_dlc4_margwa_gore_ri_shadow";
            break;
        }
        spawner.script_forcespawn = 1;
        ai = zombie_utility::spawn_zombie(spawner, targetname, s_location);
        level.var_2c028bba = undefined;
        level.var_72374095 = undefined;
        level.var_c9a18bd = undefined;
        level.var_4182a531 = undefined;
        level.var_7ff16e00 = undefined;
        level.var_b9c5d5f0 = undefined;
        if (isdefined(level.var_fd47363)) {
            level.var_2c028bba = level.var_fd47363["head_le"];
            level.var_72374095 = level.var_fd47363["head_mid"];
            level.var_c9a18bd = level.var_fd47363["head_ri"];
            level.var_4182a531 = level.var_fd47363["gore_le"];
            level.var_7ff16e00 = level.var_fd47363["gore_mid"];
            level.var_b9c5d5f0 = level.var_fd47363["gore_ri"];
        }
        ai disableaimassist();
        ai.actor_damage_func = &namespace_c96301ee::function_b59ae4e9;
        ai.candamage = 0;
        ai.targetname = targetname;
        ai.holdfire = 1;
        ai function_c0ff1e9(var_f9ebd43e);
        switch (var_f9ebd43e) {
        case 75:
            ai clientfield::set("margwa_elemental_type", 1);
            break;
        case 83:
            ai clientfield::set("margwa_elemental_type", 2);
            break;
        case 84:
            ai clientfield::set("margwa_elemental_type", 3);
            break;
        case 76:
            ai clientfield::set("margwa_elemental_type", 4);
            break;
        }
        ai.n_start_health = self.health;
        ai.team = level.zombie_team;
        ai.var_894f701d = 1;
        ai.var_c8806297 = &namespace_ca5ef87d::function_7292417a;
        ai.thundergun_knockdown_func = &namespace_ca5ef87d::function_94fd1710;
        ai.var_23340a5d = &namespace_ca5ef87d::function_7292417a;
        ai.var_e1dbd63 = &namespace_ca5ef87d::function_94fd1710;
        e_player = zm_utility::get_closest_player(s_location.origin);
        v_dir = e_player.origin - s_location.origin;
        v_dir = vectornormalize(v_dir);
        v_angles = vectortoangles(v_dir);
        ai forceteleport(s_location.origin, v_angles);
        ai function_551e32b4();
        ai thread function_8d578a58();
        ai.var_833cfbae = 1;
        /#
            ai.ignore_devgui_death = 1;
            ai thread namespace_ca5ef87d::function_618bf323();
        #/
        ai thread function_3d56f587();
        level thread zm_spawner::zombie_death_event(ai);
        return ai;
    }
    return undefined;
}

// Namespace namespace_3de4ab6f
// Params 2, eflags: 0x1 linked
// Checksum 0x686be795, Offset: 0x1e98
// Size: 0xdc
function function_75b161ab(spawner, s_location) {
    if (!isdefined(spawner)) {
        var_fda751f9 = getspawnerarray("zombie_margwa_fire_spawner", "script_noteworthy");
        if (var_fda751f9.size <= 0) {
            /#
                iprintln("margwa_defense_hovering_fx");
            #/
            return;
        }
        spawner = var_fda751f9[0];
    }
    var_6e24f5bc = "margwa_fire";
    var_f9ebd43e = "fire";
    ai = function_eb5051f4(spawner, var_6e24f5bc, var_f9ebd43e, s_location);
    return ai;
}

// Namespace namespace_3de4ab6f
// Params 2, eflags: 0x1 linked
// Checksum 0x6d6c5c25, Offset: 0x1f80
// Size: 0xdc
function function_26efbc37(spawner, s_location) {
    if (!isdefined(spawner)) {
        var_5e8312fd = getspawnerarray("zombie_margwa_shadow_spawner", "script_noteworthy");
        if (var_5e8312fd.size <= 0) {
            /#
                iprintln("margwa_defense_hovering_fx");
            #/
            return;
        }
        spawner = var_5e8312fd[0];
    }
    var_6e24f5bc = "margwa_shadow";
    var_f9ebd43e = "shadow";
    ai = function_eb5051f4(spawner, var_6e24f5bc, var_f9ebd43e, s_location);
    return ai;
}

// Namespace namespace_3de4ab6f
// Params 2, eflags: 0x1 linked
// Checksum 0x59ee3040, Offset: 0x2068
// Size: 0xdc
function function_12301fd1(spawner, s_location) {
    if (!isdefined(spawner)) {
        var_1977e3bb = getspawnerarray("zombie_margwa_light_spawner", "script_noteworthy");
        if (var_1977e3bb.size <= 0) {
            /#
                iprintln("margwa_defense_hovering_fx");
            #/
            return;
        }
        spawner = var_1977e3bb[0];
    }
    var_6e24f5bc = "margwa_light";
    var_f9ebd43e = "light";
    ai = function_eb5051f4(spawner, var_6e24f5bc, var_f9ebd43e, s_location);
    return ai;
}

// Namespace namespace_3de4ab6f
// Params 2, eflags: 0x1 linked
// Checksum 0x288e01dc, Offset: 0x2150
// Size: 0xdc
function function_5b1c9e5c(spawner, s_location) {
    if (!isdefined(spawner)) {
        var_9ceb03c8 = getspawnerarray("zombie_margwa_electricity_spawner", "script_noteworthy");
        if (var_9ceb03c8.size <= 0) {
            /#
                iprintln("margwa_defense_hovering_fx");
            #/
            return;
        }
        spawner = var_9ceb03c8[0];
    }
    var_6e24f5bc = "margwa_electric";
    var_f9ebd43e = "electric";
    ai = function_eb5051f4(spawner, var_6e24f5bc, var_f9ebd43e, s_location);
    return ai;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0xcb3f4518, Offset: 0x2238
// Size: 0x6c
function private function_3d56f587() {
    util::wait_network_frame();
    self clientfield::increment("margwa_fx_spawn");
    wait(3);
    self function_26c35525();
    self.candamage = 1;
    self.var_c7ae07c2 = 1;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0xba1e138, Offset: 0x22b0
// Size: 0x6c
function private function_551e32b4() {
    self.isfrozen = 1;
    self.dontshow = 1;
    self ghost();
    self notsolid();
    self pathmode("dont move");
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x69ec2a22, Offset: 0x2328
// Size: 0x5c
function private function_26c35525() {
    self.isfrozen = 0;
    self show();
    self solid();
    self pathmode("move allowed");
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x415bc5c, Offset: 0x2390
// Size: 0x1f0
function private function_8d578a58() {
    attacker, mod, weapon = self waittill(#"death");
    foreach (player in level.players) {
        if (player.am_i_valid && !(isdefined(level.var_1f6ca9c8) && level.var_1f6ca9c8) && !(isdefined(self.var_2d5d7413) && self.var_2d5d7413)) {
            scoreevents::processscoreevent("kill_margwa", player, undefined, undefined);
        }
    }
    level notify(#"hash_1a2d33d7");
    if (isdefined(function_6bbd2a18(self)) && function_6bbd2a18(self)) {
        function_396590c8(self.origin, -128);
    }
    if (isdefined(function_b9fad980(self)) && function_b9fad980(self)) {
        self clientfield::set("shadow_margwa_attack_portal_fx", 0);
        function_3572faf3(self.origin, -128);
    }
    if (isdefined(level.var_7cef68dc)) {
        [[ level.var_7cef68dc ]]();
    }
}

// Namespace namespace_3de4ab6f
// Params 2, eflags: 0x5 linked
// Checksum 0x9456c9dc, Offset: 0x2588
// Size: 0xba
function private function_396590c8(pos, range) {
    a_zombies = function_181f65f7(pos, range);
    foreach (zombie in a_zombies) {
        zombie namespace_57695b4d::function_f4defbc2();
    }
}

// Namespace namespace_3de4ab6f
// Params 2, eflags: 0x5 linked
// Checksum 0xffe117eb, Offset: 0x2650
// Size: 0xba
function private function_3572faf3(pos, range) {
    a_zombies = function_181f65f7(pos, range);
    foreach (zombie in a_zombies) {
        zombie namespace_df1a4a92::function_1b2b62b();
    }
}

// Namespace namespace_3de4ab6f
// Params 2, eflags: 0x1 linked
// Checksum 0xc47819d6, Offset: 0x2718
// Size: 0x64
function function_181f65f7(pos, range) {
    var_7843fa64 = namespace_57695b4d::function_d41418b8();
    a_zombies = array::get_all_closest(pos, var_7843fa64, undefined, undefined, range);
    return a_zombies;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x4be2606c, Offset: 0x2788
// Size: 0x18
function private function_c0ff1e9(var_f9ebd43e) {
    self.var_f9ebd43e = var_f9ebd43e;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x1 linked
// Checksum 0x87e28d9e, Offset: 0x27a8
// Size: 0x4c
function function_6bbd2a18(entity) {
    if (isdefined(entity) && isdefined(entity.var_f9ebd43e) && entity.var_f9ebd43e == "fire") {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x1 linked
// Checksum 0xe2c42de2, Offset: 0x2800
// Size: 0x4c
function function_3cfb8731(entity) {
    if (isdefined(entity) && isdefined(entity.var_f9ebd43e) && entity.var_f9ebd43e == "electric") {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x1 linked
// Checksum 0xa9555c11, Offset: 0x2858
// Size: 0x4c
function function_7db0458(entity) {
    if (isdefined(entity) && isdefined(entity.var_f9ebd43e) && entity.var_f9ebd43e == "light") {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x1 linked
// Checksum 0xa7ba49ac, Offset: 0x28b0
// Size: 0x4c
function function_b9fad980(entity) {
    if (isdefined(entity) && isdefined(entity.var_f9ebd43e) && entity.var_f9ebd43e == "shadow") {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x5575b49a, Offset: 0x2908
// Size: 0xf4
function private function_e1859566() {
    self.zombie_lift_override = &function_2ab5f647;
    self function_68ff73f4();
    self function_1d2f460c();
    self function_3c6c3309();
    self function_36cf9d7();
    self function_4e78142b();
    self function_1da8deb6();
    self function_6ae4a816();
    self function_e268d040();
    self function_246f9ba8();
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x2833c6ec, Offset: 0x2a08
// Size: 0x14
function private function_68ff73f4() {
    self.var_16ee8ac0 = gettime() + 20000;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x1c8e06bf, Offset: 0x2a28
// Size: 0x14
function private function_1d2f460c() {
    self.var_5ef5dff8 = gettime() + 20000;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0xe283071a, Offset: 0x2a48
// Size: 0x14
function private function_3c6c3309() {
    self.var_57ad950f = gettime() + 6000;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x1cb86747, Offset: 0x2a68
// Size: 0x14
function private function_36cf9d7() {
    self.var_a5ab6e8d = gettime() + 6000;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x4f0b84b8, Offset: 0x2a88
// Size: 0x14
function private function_4e78142b() {
    self.var_7294169 = gettime() + 7500;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x82fb34ab, Offset: 0x2aa8
// Size: 0x14
function private function_1da8deb6() {
    self.var_44d78ba2 = gettime() + 3000;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x42e92201, Offset: 0x2ac8
// Size: 0x14
function private function_6ae4a816() {
    self.var_c0e54902 = gettime() + 20000;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x4006f3e5, Offset: 0x2ae8
// Size: 0x14
function private function_e268d040() {
    self.var_70f89c94 = gettime() + 20000;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x997b96c7, Offset: 0x2b08
// Size: 0x14
function private function_246f9ba8() {
    self.var_3a9ed1bc = gettime() + 20000;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x3a09c0e3, Offset: 0x2b28
// Size: 0x1c4
function private function_4f4a272(var_10946bf5) {
    origin = self.origin;
    if (isdefined(var_10946bf5)) {
        var_f32a3315 = anglestoright(self.angles);
        origin += var_f32a3315 * var_10946bf5;
    }
    facing_vec = anglestoforward(self.angles);
    enemy_vec = self.favoriteenemy.origin - origin;
    var_ef095088 = (enemy_vec[0], enemy_vec[1], 0);
    var_331bc04c = (facing_vec[0], facing_vec[1], 0);
    var_ef095088 = vectornormalize(var_ef095088);
    var_331bc04c = vectornormalize(var_331bc04c);
    enemy_dot = vectordot(var_331bc04c, var_ef095088);
    if (enemy_dot < 0.5) {
        return false;
    }
    var_c15c560e = vectortoangles(enemy_vec);
    if (abs(angleclamp180(var_c15c560e[0])) > 60) {
        return false;
    }
    return true;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x86adcbbe, Offset: 0x2cf8
// Size: 0x1cc
function private brrebirth_triggerrespawnoverlay(entity) {
    if (!function_6bbd2a18(entity)) {
        return false;
    }
    if (isdefined(entity.var_322364e8) && entity.var_322364e8) {
        entity.var_4ad63d98 = 1;
        return true;
    }
    time = gettime();
    entity.var_4ad63d98 = 0;
    if (time < entity.var_16ee8ac0) {
        return false;
    }
    if (isdefined(entity.var_b696faa3) && entity.var_b696faa3) {
        return false;
    }
    if (isdefined(entity.var_dd350502) && entity.var_dd350502) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (!entity function_4f4a272()) {
        return false;
    }
    if (!entity cansee(entity.favoriteenemy)) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 62500 || dist_sq > 1440000) {
        return false;
    }
    entity.var_4ad63d98 = 1;
    return true;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xe4f36f1, Offset: 0x2ed0
// Size: 0xc4
function private function_c8dea044(entity) {
    if (!function_6bbd2a18(entity)) {
        return false;
    }
    if (entity.var_a0c7c5f > 2) {
        return false;
    }
    if (isdefined(entity.favoriteenemy.is_flung) && isdefined(entity.favoriteenemy) && entity.favoriteenemy.is_flung) {
        return false;
    }
    if (gettime() > entity.var_5ef5dff8) {
        entity.var_501a54e5 = 1;
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x9f822dc5, Offset: 0x2fa0
// Size: 0x13c
function private function_744188c1(entity) {
    entity.var_6d87f4e5 = 0;
    if (!function_3cfb8731(entity)) {
        return false;
    }
    if (gettime() > entity.var_57ad950f) {
        entity.var_6d87f4e5 = 1;
        return true;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (!entity function_4f4a272()) {
        return false;
    }
    if (!entity cansee(entity.favoriteenemy)) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 62500 || dist_sq > 1440000) {
        return false;
    }
    entity.var_6d87f4e5 = 1;
    return true;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x327b26b4, Offset: 0x30e8
// Size: 0x13c
function private function_7652cccb(entity) {
    if (!function_3cfb8731(entity)) {
        return false;
    }
    entity.var_c521ba6b = 0;
    if (gettime() > entity.var_a5ab6e8d) {
        entity.var_c521ba6b = 1;
        return true;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (!entity function_4f4a272()) {
        return false;
    }
    if (!entity cansee(entity.favoriteenemy)) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 62500 || dist_sq > 1440000) {
        return false;
    }
    entity.var_c521ba6b = 1;
    return true;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x6ac7fcad, Offset: 0x3230
// Size: 0xcc
function private function_39eece3f(entity) {
    entity.var_a48cbe36 = 0;
    if (!function_3cfb8731(entity)) {
        return false;
    }
    if (gettime() < entity.var_7294169) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 129600 || dist_sq > 921600) {
        return false;
    }
    entity.var_a48cbe36 = 1;
    return true;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xa34dc19c, Offset: 0x3308
// Size: 0x124
function private function_655b9672(entity) {
    if (!function_7db0458(entity)) {
        return false;
    }
    entity.var_d3c45f0a = 0;
    if (gettime() > entity.var_44d78ba2) {
        entity.var_d3c45f0a = 1;
        return true;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (!entity cansee(entity.favoriteenemy)) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 62500 || dist_sq > 1440000) {
        return false;
    }
    entity.var_d3c45f0a = 1;
    return true;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x9431c421, Offset: 0x3438
// Size: 0x5c
function private function_64e5bb2(entity) {
    if (!function_7db0458(entity)) {
        return false;
    }
    if (gettime() > entity.var_c0e54902) {
        entity.var_623927af = 1;
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xfb2ea923, Offset: 0x34a0
// Size: 0x1bc
function private function_43079630(entity) {
    if (!function_b9fad980(entity)) {
        return false;
    }
    if (isdefined(entity.var_3c58b79c) && entity.var_3c58b79c) {
        entity.var_321306c = 1;
        return true;
    }
    entity.var_321306c = 0;
    if (isdefined(entity.var_187c138e) && entity.var_187c138e) {
        return false;
    }
    if (isdefined(entity.isteleporting) && entity.isteleporting) {
        return false;
    }
    if (gettime() < entity.var_70f89c94) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (!entity cansee(entity.favoriteenemy)) {
        return false;
    }
    if (!entity function_4f4a272()) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 16384 || dist_sq > 589824) {
        return false;
    }
    entity.var_321306c = 1;
    return true;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x7cef405a, Offset: 0x3668
// Size: 0xec
function private function_50654c28(entity) {
    if (!function_b9fad980(entity)) {
        return false;
    }
    if (entity.var_a0c7c5f > 2) {
        return false;
    }
    if (isdefined(entity.favoriteenemy.is_flung) && isdefined(entity.favoriteenemy) && entity.favoriteenemy.is_flung) {
        return false;
    }
    if (isdefined(entity.var_187c138e) && entity.var_187c138e) {
        return false;
    }
    if (gettime() > entity.var_3a9ed1bc) {
        entity.var_e9353b19 = 1;
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xa45d381, Offset: 0x3760
// Size: 0x3a
function private function_78f83c26(entity) {
    if (isdefined(entity.var_4ad63d98) && entity.var_4ad63d98) {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xf02a7a1f, Offset: 0x37a8
// Size: 0xe
function private function_782e86fb(entity) {
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x4a5fd7a4, Offset: 0x37c0
// Size: 0xe
function private function_836eeae4(entity) {
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x1ffef45d, Offset: 0x37d8
// Size: 0x3a
function private function_eb0118e7(entity) {
    if (isdefined(entity.var_6d87f4e5) && entity.var_6d87f4e5) {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x6ab69eba, Offset: 0x3820
// Size: 0x3a
function private function_2672a46d(entity) {
    if (isdefined(entity.var_c521ba6b) && entity.var_c521ba6b) {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x4c8af006, Offset: 0x3868
// Size: 0x3a
function private function_efc320f8(entity) {
    if (isdefined(entity.var_a48cbe36) && entity.var_a48cbe36) {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xd61b7678, Offset: 0x38b0
// Size: 0x3a
function private function_bcd55721(entity) {
    if (isdefined(entity.var_523cacc3) && entity.var_523cacc3) {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xf1e8efd1, Offset: 0x38f8
// Size: 0x3a
function private function_fd4fb480(entity) {
    if (isdefined(entity.var_d3c45f0a) && entity.var_d3c45f0a) {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x263e2098, Offset: 0x3940
// Size: 0x3a
function private function_5bfc92ed(entity) {
    if (isdefined(entity.var_623927af) && entity.var_623927af) {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xb25c1ec8, Offset: 0x3988
// Size: 0x3a
function private function_412d8b9a(entity) {
    if (isdefined(entity.var_5df615f0) && entity.var_5df615f0) {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x953d740d, Offset: 0x39d0
// Size: 0x3a
function private function_dfedf376(entity) {
    if (isdefined(entity.var_321306c) && entity.var_321306c) {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x76e3b814, Offset: 0x3a18
// Size: 0x3c
function private function_a5dc38a7(entity) {
    if (isdefined(entity.var_1ab20b9b)) {
        if (gettime() > entity.var_1ab20b9b) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x37ab98f2, Offset: 0x3a60
// Size: 0x3a
function private function_f2802e4b(entity) {
    if (isdefined(entity.var_6a2ba141) && entity.var_6a2ba141) {
        return true;
    }
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x194a66b0, Offset: 0x3aa8
// Size: 0xe
function private function_87dfc76b(entity) {
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x46656606, Offset: 0x3ac0
// Size: 0xe
function private function_6af3c534(entity) {
    return false;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xa34f06a9, Offset: 0x3ad8
// Size: 0x3c
function private function_face7ad8(entity) {
    entity endon(#"death");
    entity.var_322364e8 = 0;
    entity thread function_90ec324d();
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x4e84d36e, Offset: 0x3b20
// Size: 0x73c
function private function_90ec324d() {
    self.var_dd350502 = 1;
    foreach (head in self.head) {
        if (!(isdefined(head.candamage) && head.candamage)) {
            head.var_13ac78ab = 0;
            head.candamage = 1;
            continue;
        }
        head.var_13ac78ab = 1;
    }
    self waittill(#"hash_b55b6f2b");
    foreach (head in self.head) {
        if (!(isdefined(head.var_13ac78ab) && head.var_13ac78ab)) {
            head.candamage = 0;
        }
    }
    if (isdefined(self.favoriteenemy)) {
        var_70b6278d = self.favoriteenemy.origin - self.origin;
        var_68149ff9 = vectornormalize(var_70b6278d);
        target_entity = self.favoriteenemy;
    } else {
        var_68149ff9 = anglestoforward(self.angles);
    }
    var_1642db30 = var_68149ff9;
    var_74475c34 = int(13.3333);
    position = self.origin;
    var_898f5d33 = spawn("script_model", position);
    var_898f5d33 setmodel("tag_origin");
    level thread function_396590c8(position, 48);
    var_36984e86 = 13.5;
    var_de9583ed = cos(var_36984e86);
    for (i = 0; i <= var_74475c34; i++) {
        self function_68ff73f4();
        position += (0, 0, 32);
        if (isdefined(target_entity)) {
            var_f9beb155 = target_entity.origin;
            vector_to_target = var_f9beb155 - position;
            normal_vector = vectornormalize(vector_to_target);
            var_bfec607e = vectornormalize((normal_vector[0], normal_vector[1], 0));
            var_ee111afc = vectornormalize((var_1642db30[0], var_1642db30[1], 0));
            dot = vectordot(var_bfec607e, var_ee111afc);
            if (dot >= 1) {
                dot = 1;
            } else if (dot <= -1) {
                dot = -1;
            }
            if (dot < var_de9583ed) {
                new_vector = normal_vector - var_1642db30;
                angle_between_vectors = acos(dot);
                if (!isdefined(angle_between_vectors)) {
                    angle_between_vectors = -76;
                }
                if (angle_between_vectors == 0) {
                    angle_between_vectors = 0.0001;
                }
                var_8c49ee9f = 13.5;
                ratio = var_8c49ee9f / angle_between_vectors;
                if (ratio > 1) {
                    ratio = 1;
                }
                new_vector *= ratio;
                new_vector += var_1642db30;
                normal_vector = vectornormalize(new_vector);
            } else {
                normal_vector = var_1642db30;
            }
        }
        if (!isdefined(normal_vector)) {
            normal_vector = var_1642db30;
        }
        var_98258f16 = normal_vector * 48;
        var_1642db30 = normal_vector;
        target_pos = position + var_98258f16;
        if (bullettracepassed(position, target_pos, 0, self)) {
            trace = bullettrace(target_pos, target_pos - (0, 0, 64), 0, self);
            if (!isdefined(trace["position"])) {
                continue;
            }
            position = trace["position"];
            var_898f5d33 moveto(position, 0.15);
            var_898f5d33 waittill(#"movedone");
            var_898f5d33 clientfield::increment("play_margwa_fire_attack_fx");
            var_898f5d33 thread function_396590c8(position, 48);
            self thread function_308ca6aa(position, 48, 30, "MOD_BURNED");
            if (isdefined(target_entity) && distancesquared(target_entity.origin, position) <= 2304) {
                break;
            }
            continue;
        }
        break;
    }
    self.var_dd350502 = 0;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x1a14047a, Offset: 0x4268
// Size: 0x24
function private function_68e3291c(entity) {
    entity function_68ff73f4();
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x2923655f, Offset: 0x4298
// Size: 0x5c
function private function_99ba2c25(entity) {
    entity function_1d2f460c();
    entity.isteleporting = 1;
    entity.var_501a54e5 = 0;
    entity.var_b696faa3 = 1;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x335124d7, Offset: 0x4300
// Size: 0x7c
function private function_6a7ddf05(entity) {
    entity clientfield::set("margwa_defense_actor_appear_disappear_fx", 1);
    entity ghost();
    entity pathmode("dont move");
    entity thread function_ced695a8();
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x77950973, Offset: 0x4388
// Size: 0x118
function private function_ced695a8() {
    self.waiting = 1;
    var_c37d9885 = (0, 0, 64);
    self function_258d1434(var_c37d9885, -16, 480);
    if (isdefined(self.var_937645c5)) {
        self.var_937645c5 clientfield::set("margwa_defense_hovering_fx", 1);
    }
    if (isdefined(self.var_b978c02e)) {
        self.var_b978c02e clientfield::set("margwa_defense_hovering_fx", 1);
    }
    if (isdefined(self.var_df7b3a97)) {
        self.var_df7b3a97 clientfield::set("margwa_defense_hovering_fx", 1);
    }
    self forceteleport(self.var_58b84a32);
    wait(1);
    self.waiting = 0;
    self.var_847ae832 = 1;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x3bd0d351, Offset: 0x44a8
// Size: 0x4a
function private function_794b06f(point) {
    return zm_utility::check_point_in_playable_area(point.origin) && zm_utility::check_point_in_enabled_zone(point.origin);
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xf9b9401d, Offset: 0x4500
// Size: 0x174
function private function_75f40972(entity) {
    entity show();
    entity pathmode("move allowed");
    entity.isteleporting = 0;
    entity.var_847ae832 = 0;
    if (isdefined(self.var_937645c5)) {
        self.var_937645c5 clientfield::set("margwa_defense_hovering_fx", 0);
    }
    if (isdefined(self.var_b978c02e)) {
        self.var_b978c02e clientfield::set("margwa_defense_hovering_fx", 0);
    }
    if (isdefined(self.var_df7b3a97)) {
        self.var_df7b3a97 clientfield::set("margwa_defense_hovering_fx", 0);
    }
    wait(0.05);
    if (isdefined(self.var_937645c5)) {
        self.var_937645c5 delete();
    }
    if (isdefined(self.var_b978c02e)) {
        self.var_b978c02e delete();
    }
    if (isdefined(self.var_df7b3a97)) {
        self.var_df7b3a97 delete();
    }
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xa1a7d95e, Offset: 0x4680
// Size: 0x1c
function private function_cd27e3fa(entity) {
    entity.var_b696faa3 = 0;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xe976d017, Offset: 0x46a8
// Size: 0x24
function private function_b473ad25(entity) {
    entity function_3c6c3309();
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x5bd5aa7c, Offset: 0x46d8
// Size: 0x24
function private function_6619b5ab(entity) {
    entity function_36cf9d7();
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x2fd18b79, Offset: 0x4708
// Size: 0x48
function private function_8382b576(entity) {
    entity function_4e78142b();
    entity.isteleporting = 1;
    entity.var_a48cbe36 = 0;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xd1af826e, Offset: 0x4758
// Size: 0x104
function private function_3c8bea36(entity) {
    if (isdefined(entity.var_58ce2260)) {
        entity.var_58ce2260.origin = entity gettagorigin("j_spine_1");
        entity.var_58ce2260 clientfield::set("margwa_fx_travel", 1);
    }
    entity ghost();
    entity pathmode("dont move");
    if (isdefined(entity.var_58ce2260)) {
        entity linkto(entity.var_58ce2260);
    }
    entity thread function_aa4e7619();
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x1b34324c, Offset: 0x4868
// Size: 0x3d8
function private function_aa4e7619() {
    self.waiting = 1;
    goal_pos = self.enemy.origin;
    if (isdefined(self.enemy.last_valid_position)) {
        goal_pos = self.enemy.last_valid_position;
    }
    path = self calcapproximatepathtoposition(goal_pos, 0);
    var_2fd16fa4 = randomintrange(96, -64);
    var_3ecad6a7 = 0;
    var_61186753 = [];
    var_f2593821 = 0;
    for (index = 1; index < path.size; index++) {
        var_cabd9641 = distance(path[index - 1], path[index]);
        if (var_3ecad6a7 + var_cabd9641 > var_2fd16fa4) {
            var_bee1a4a2 = var_2fd16fa4 - var_3ecad6a7;
            var_5a78f4fc = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * var_bee1a4a2;
            var_48f8d555 = positionquery_source_navigation(var_5a78f4fc, 64, -128, 36, 16, self, 16);
            if (var_48f8d555.data.size > 0) {
                point = var_48f8d555.data[randomint(var_48f8d555.data.size)];
                var_61186753[var_f2593821] = point.origin;
                var_f2593821++;
                if (var_f2593821 == 3) {
                    break;
                }
            }
        }
    }
    foreach (point in var_61186753) {
        var_bd23de7b = point + (0, 0, 60);
        dist = distance(self.var_58ce2260.origin, var_bd23de7b);
        time = dist / 1200;
        if (time < 0.1) {
            time = 0.1;
        }
        if (isdefined(self.var_58ce2260)) {
            self.var_58ce2260 moveto(var_bd23de7b, time);
            self.var_58ce2260 util::waittill_any_timeout(time, "movedone");
        }
    }
    self.var_16410986 = point;
    self.waiting = 0;
    self.var_523cacc3 = 1;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x4418c469, Offset: 0x4c48
// Size: 0xdc
function private function_11d72a03(entity) {
    entity unlink();
    if (isdefined(entity.var_16410986)) {
        entity forceteleport(entity.var_16410986);
    }
    entity show();
    entity pathmode("move allowed");
    entity.isteleporting = 0;
    entity.var_523cacc3 = 0;
    entity.var_58ce2260 clientfield::set("margwa_fx_travel", 0);
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x5c82b033, Offset: 0x4d30
// Size: 0x44
function private function_226a6f4a(entity) {
    entity function_1da8deb6();
    /#
        printtoprightln("margwa_defense_hovering_fx");
    #/
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xdca1b69b, Offset: 0x4d80
// Size: 0x64
function private function_9c7737ef(entity) {
    entity function_6ae4a816();
    entity.isteleporting = 1;
    entity.var_623927af = 0;
    /#
        printtoprightln("margwa_defense_hovering_fx");
    #/
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x52b9f81e, Offset: 0x4df0
// Size: 0x5c
function private function_5d88ac4b(entity) {
    entity ghost();
    entity pathmode("dont move");
    entity thread function_f10db74e();
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x53c85fba, Offset: 0x4e58
// Size: 0xcc
function private function_f10db74e() {
    self.waiting = 1;
    queryresult = positionquery_source_navigation(self.origin, 120, 360, -128, 32, self);
    var_6ab55afd = array::randomize(queryresult.data);
    self.var_58b84a32 = var_6ab55afd[0].origin;
    self forceteleport(self.var_58b84a32);
    wait(0.5);
    self.waiting = 0;
    self.var_5df615f0 = 1;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xc6501ae6, Offset: 0x4f30
// Size: 0x64
function private function_c2614d30(entity) {
    entity show();
    entity pathmode("move allowed");
    entity.isteleporting = 0;
    entity.var_5df615f0 = 0;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xea5ffc8a, Offset: 0x4fa0
// Size: 0x244
function private function_9a9f35ac(entity) {
    entity endon(#"death");
    var_3e944f2d = 0;
    entity.var_3c58b79c = 0;
    entity.var_187c138e = 1;
    entity.var_1ab20b9b = undefined;
    var_5ba5953 = anglestoforward(entity.angles);
    var_bc39bd09 = entity.origin + (0, 0, 72) + var_5ba5953 * 96;
    var_1be3af57 = entity.angles;
    entity waittill(#"hash_64a0057e");
    entity clientfield::set("shadow_margwa_attack_portal_fx", 1);
    wait(0.5);
    target = undefined;
    if (isdefined(entity.favoriteenemy)) {
        position = var_bc39bd09 + var_5ba5953 * 96;
        target = spawn("script_model", position);
        target setmodel("tag_origin");
        target.var_8002cc8a = entity.favoriteenemy;
        target.owner = entity;
        target thread function_9a821f95();
    }
    while (var_3e944f2d < 4) {
        entity function_8969ba81(var_bc39bd09, var_1be3af57, target);
        var_3e944f2d += 1;
        wait(0.25);
    }
    entity clientfield::set("shadow_margwa_attack_portal_fx", 0);
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xd13490b0, Offset: 0x51f0
// Size: 0x28
function private function_ae1bcedd(entity) {
    entity.var_1ab20b9b = gettime() + 1000;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x4851c739, Offset: 0x5220
// Size: 0x20
function private function_58c0f99d(entity) {
    entity.var_6a2ba141 = 1;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x1f78de31, Offset: 0x5248
// Size: 0x48
function private function_d89cf919(entity) {
    entity.var_187c138e = 0;
    entity.var_6a2ba141 = 0;
    entity.var_70f89c94 = gettime() + 100000;
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0x9cd9f674, Offset: 0x5298
// Size: 0x35c
function private function_9a821f95() {
    self.owner util::waittill_any("shadow_margwa_skull_launched", "death");
    self.owner.var_ed0c0558 = array::remove_undefined(self.owner.var_ed0c0558, 0);
    margwa = self.owner;
    while (isdefined(self) && isdefined(self.var_8002cc8a) && isalive(self.var_8002cc8a) && isdefined(self.owner) && isdefined(self.owner.var_ed0c0558) && self.owner.var_ed0c0558.size > 0) {
        eye_position = self.var_8002cc8a gettagorigin("tag_eye");
        self.owner.var_ed0c0558 = array::remove_undefined(self.owner.var_ed0c0558, 0);
        if (distancesquared(self.origin, eye_position) <= 10000) {
            if (!(isdefined(self.var_d7c0356e) && self.var_d7c0356e)) {
                self.origin = eye_position;
                self linkto(self.var_8002cc8a, "tag_eye");
                self.var_d7c0356e = 1;
            }
        } else {
            var_2dca088d = eye_position - self.origin;
            var_6c4cc94d = vectornormalize(var_2dca088d);
            var_4037a81b = var_6c4cc94d * 50;
            var_5ae4b928 = self.origin + var_4037a81b;
            var_81e4178f = eye_position[2] - self.origin[2];
            bullet_trace = bullettrace(var_5ae4b928 + (0, 0, var_81e4178f), var_5ae4b928 - (0, 0, var_81e4178f), 0, self.var_8002cc8a);
            if (isdefined(bullet_trace["position"])) {
                var_5ae4b928 = bullet_trace["position"] + (0, 0, var_81e4178f);
            }
            self moveto(var_5ae4b928, 0.2);
        }
        wait(0.2);
    }
    margwa function_e268d040();
    if (isdefined(self)) {
        if (isdefined(self.var_d7c0356e) && self.var_d7c0356e) {
            self unlink();
        }
        self delete();
    }
}

// Namespace namespace_3de4ab6f
// Params 3, eflags: 0x5 linked
// Checksum 0x80539e3b, Offset: 0x5600
// Size: 0x260
function private function_8969ba81(var_bc39bd09, var_1be3af57, target) {
    if (!isdefined(target)) {
        target = undefined;
    }
    entity = self;
    weapon = getweapon("launcher_shadow_margwa");
    if (!isdefined(entity.var_ed0c0558)) {
        entity.var_ed0c0558 = [];
    }
    vector = anglestoforward(var_1be3af57);
    vector *= -6;
    vector += (0, 0, 250);
    var_c4d58545 = randomint(100) - 50;
    var_36db14ca = randomint(100) - 50;
    var_71c4e537 = randomint(50) - 25;
    var_4126099a = vector + (var_c4d58545, var_36db14ca, var_71c4e537);
    if (!isdefined(target)) {
        skull = entity magicmissile(weapon, var_bc39bd09, var_4126099a);
        skull thread function_16cddcb6();
        entity.var_ed0c0558[entity.var_ed0c0558.size] = skull;
        entity notify(#"hash_891e6dc2");
        return;
    }
    skull = entity magicmissile(weapon, var_bc39bd09, var_4126099a, target);
    skull thread function_16cddcb6();
    entity.var_ed0c0558[entity.var_ed0c0558.size] = skull;
    entity notify(#"hash_891e6dc2");
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x1 linked
// Checksum 0x51b07486, Offset: 0x5868
// Size: 0xc8
function function_16cddcb6() {
    self.takedamage = 1;
    var_b5f846f3 = 0;
    var_b52ddb1c = 100;
    if (isdefined(level.var_928e29b4)) {
        var_b52ddb1c = level.var_928e29b4;
    }
    while (isdefined(self)) {
        n_damage, e_attacker = self waittill(#"damage");
        if (isplayer(e_attacker)) {
            var_b5f846f3 += n_damage;
            if (var_b5f846f3 >= var_b52ddb1c) {
                self detonate();
            }
        }
    }
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xcfb2f5b5, Offset: 0x5938
// Size: 0x48
function private function_d765e859(entity) {
    entity function_246f9ba8();
    entity.isteleporting = 1;
    entity.var_e9353b19 = 0;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0x5c258477, Offset: 0x5988
// Size: 0x5c
function private function_4600a191(entity) {
    entity ghost();
    entity pathmode("dont move");
    entity thread function_2f67316c();
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0xe329bc10, Offset: 0x59f0
// Size: 0x118
function private function_2f67316c() {
    self.waiting = 1;
    var_c37d9885 = (0, 0, 64);
    self function_258d1434(var_c37d9885, -16, 480);
    if (isdefined(self.var_937645c5)) {
        self.var_937645c5 clientfield::set("margwa_defense_hovering_fx", 4);
    }
    if (isdefined(self.var_b978c02e)) {
        self.var_b978c02e clientfield::set("margwa_defense_hovering_fx", 4);
    }
    if (isdefined(self.var_df7b3a97)) {
        self.var_df7b3a97 clientfield::set("margwa_defense_hovering_fx", 4);
    }
    self forceteleport(self.var_58b84a32);
    wait(1);
    self.waiting = 0;
    self.var_5760b1de = 1;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x5 linked
// Checksum 0xa11fcfd, Offset: 0x5b10
// Size: 0x7c
function private function_d258371e(entity) {
    entity show();
    entity pathmode("move allowed");
    entity.isteleporting = 0;
    entity.var_5760b1de = 0;
    entity thread function_34067c01();
}

// Namespace namespace_3de4ab6f
// Params 0, eflags: 0x5 linked
// Checksum 0xc9183a96, Offset: 0x5b98
// Size: 0x114
function private function_34067c01() {
    if (isdefined(self.var_937645c5)) {
        self.var_937645c5 clientfield::set("margwa_defense_hovering_fx", 0);
    }
    if (isdefined(self.var_b978c02e)) {
        self.var_b978c02e clientfield::set("margwa_defense_hovering_fx", 0);
    }
    if (isdefined(self.var_df7b3a97)) {
        self.var_df7b3a97 clientfield::set("margwa_defense_hovering_fx", 0);
    }
    wait(0.05);
    if (isdefined(self.var_937645c5)) {
        self.var_937645c5 delete();
    }
    if (isdefined(self.var_b978c02e)) {
        self.var_b978c02e delete();
    }
    if (isdefined(self.var_df7b3a97)) {
        self.var_df7b3a97 delete();
    }
}

// Namespace namespace_3de4ab6f
// Params 4, eflags: 0x5 linked
// Checksum 0x8f2688ca, Offset: 0x5cb8
// Size: 0x15a
function private function_308ca6aa(position, range, damage, damage_mod) {
    margwa = self;
    players = getplayers();
    var_fb942e9f = range * range;
    foreach (player in players) {
        if (player laststand::player_is_in_laststand()) {
            continue;
        }
        dist_sq = distancesquared(position, player.origin);
        if (dist_sq <= var_fb942e9f) {
            player dodamage(damage, position, margwa, undefined, undefined, damage_mod);
        }
    }
}

// Namespace namespace_3de4ab6f
// Params 12, eflags: 0x1 linked
// Checksum 0xc2eafe17, Offset: 0x5e20
// Size: 0x10c
function function_5ff4198(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (isdefined(weapon) && weapon == getweapon("launcher_shadow_margwa")) {
        if (self == attacker || isdefined(attacker) && self.team == attacker.team) {
            if (self.archetype === "zombie" && namespace_57695b4d::function_b804eb62(self)) {
                self namespace_df1a4a92::function_1b2b62b();
            }
            return 0;
        }
    }
    return -1;
}

// Namespace namespace_3de4ab6f
// Params 3, eflags: 0x1 linked
// Checksum 0x6f96c3fc, Offset: 0x5f38
// Size: 0x338
function function_258d1434(var_c37d9885, var_6cd7eac7, var_19d406c9) {
    var_58b84a32 = self.origin;
    if (isdefined(self.favoriteenemy)) {
        var_58b84a32 = self.favoriteenemy.origin;
    }
    queryresult = positionquery_source_navigation(var_58b84a32, var_6cd7eac7, var_19d406c9, 256, 96, self);
    var_6ab55afd = array::randomize(queryresult.data);
    var_6ab55afd = array::filter(var_6ab55afd, 0, &function_794b06f);
    if (var_6ab55afd.size > 0) {
        self.var_58b84a32 = var_6ab55afd[0].origin;
        self.var_937645c5 = spawn("script_model", self.var_58b84a32 + var_c37d9885);
        self.var_937645c5 setmodel("tag_origin");
        var_d1122efb = 1;
        if (isdefined(var_6ab55afd[1])) {
            self.var_b978c02e = spawn("script_model", var_6ab55afd[1].origin + var_c37d9885);
            self.var_b978c02e setmodel("tag_origin");
            var_d1122efb += 1;
            if (isdefined(var_6ab55afd[2])) {
                self.var_df7b3a97 = spawn("script_model", var_6ab55afd[2].origin + var_c37d9885);
                self.var_df7b3a97 setmodel("tag_origin");
                var_d1122efb += 1;
            }
        }
    } else {
        self.var_58b84a32 = self.origin;
        self.var_937645c5 = spawn("script_model", self.var_58b84a32 + var_c37d9885);
        self.var_937645c5 setmodel("tag_origin");
        var_d1122efb = 1;
    }
    var_ce0ccfb0 = randomint(var_d1122efb);
    if (var_ce0ccfb0 === 1) {
        self.var_58b84a32 = var_6ab55afd[1].origin;
    }
    if (var_ce0ccfb0 === 2) {
        self.var_58b84a32 = var_6ab55afd[2].origin;
    }
}

// Namespace namespace_3de4ab6f
// Params 6, eflags: 0x1 linked
// Checksum 0xaae5b5fc, Offset: 0x6278
// Size: 0x2fe
function function_2ab5f647(e_player, v_attack_source, n_push_away, n_lift_height, v_lift_offset, n_lift_speed) {
    self endon(#"death");
    if (isdefined(self.in_gravity_trap) && self.in_gravity_trap && e_player.var_887585ba === 3) {
        if (isdefined(self.var_1f5fe943) && self.var_1f5fe943) {
            return;
        }
        self.var_bcecff1d = 1;
        self.var_1f5fe943 = 1;
        self dodamage(10, self.origin);
        self.var_3abf1eec = self.origin;
        scene = "cin_zm_dlc4_margwa_dth_deathray_01";
        if (self.var_f9ebd43e === "fire") {
            scene = "cin_zm_dlc4_margwa_fire_dth_deathray_01";
        }
        if (self.var_f9ebd43e === "shadow") {
            scene = "cin_zm_dlc4_margwa_shadow_dth_deathray_01";
        }
        self thread scene::play(scene, self);
        self clientfield::set("sparky_beam_fx", 1);
        self clientfield::set("margwa_shock_fx", 1);
        self playsound("zmb_talon_electrocute");
        n_start_time = gettime();
        for (n_total_time = 0; 10 > n_total_time && e_player.var_887585ba === 3; n_total_time = (gettime() - n_start_time) / 1000) {
            util::wait_network_frame();
        }
        self scene::stop(scene);
        self thread function_3f3b0b14(self);
        self clientfield::set("sparky_beam_fx", 0);
        self clientfield::set("margwa_shock_fx", 0);
        self.var_bcecff1d = undefined;
        while (e_player.var_887585ba === 3) {
            util::wait_network_frame();
        }
        self.var_1f5fe943 = undefined;
        self.in_gravity_trap = undefined;
        return;
    }
    if (!(isdefined(self.var_9e59b56e) && self.var_9e59b56e)) {
        self.var_9e59b56e = 1;
    }
    self.in_gravity_trap = undefined;
}

// Namespace namespace_3de4ab6f
// Params 1, eflags: 0x1 linked
// Checksum 0x6d37df90, Offset: 0x6580
// Size: 0x204
function function_3f3b0b14(margwa) {
    margwa endon(#"death");
    if (isdefined(margwa)) {
        self.var_3abf1eec = self.origin;
        scene = "cin_zm_dlc4_margwa_dth_deathray_02";
        if (self.var_f9ebd43e === "fire") {
            scene = "cin_zm_dlc4_margwa_fire_dth_deathray_02";
        }
        if (self.var_f9ebd43e === "shadow") {
            scene = "cin_zm_dlc4_margwa_shadow_dth_deathray_02";
        }
        margwa scene::play(scene, margwa);
    }
    if (isdefined(margwa) && isalive(margwa) && isdefined(margwa.var_3abf1eec)) {
        var_c430eda8 = margwa gettagorigin("tag_eye");
        /#
            recordline(margwa.origin, var_c430eda8, (0, 255, 0), "margwa_defense_hovering_fx", margwa);
        #/
        trace = bullettrace(var_c430eda8, margwa.origin, 0, margwa);
        if (trace["position"] !== margwa.origin) {
            point = getclosestpointonnavmesh(trace["position"], 64, 30);
            if (!isdefined(point)) {
                point = margwa.var_3abf1eec;
            }
            margwa forceteleport(point);
        }
    }
}

/#

    // Namespace namespace_3de4ab6f
    // Params 0, eflags: 0x1 linked
    // Checksum 0x214498e1, Offset: 0x6790
    // Size: 0x248
    function function_15492d9b() {
        wait(0.05);
        level waittill(#"start_zombie_round_logic");
        wait(0.05);
        str_cmd = "margwa_defense_hovering_fx";
        adddebugcommand(str_cmd);
        str_cmd = "margwa_defense_hovering_fx";
        adddebugcommand(str_cmd);
        str_cmd = "margwa_defense_hovering_fx";
        adddebugcommand(str_cmd);
        str_cmd = "margwa_defense_hovering_fx";
        adddebugcommand(str_cmd);
        while (true) {
            string = getdvarstring("margwa_defense_hovering_fx");
            if (string === "margwa_defense_hovering_fx") {
                level thread function_a06aa49e();
                setdvar("margwa_defense_hovering_fx", "margwa_defense_hovering_fx");
            }
            string = getdvarstring("margwa_defense_hovering_fx");
            if (string === "margwa_defense_hovering_fx") {
                level thread function_50a5b7b6();
                setdvar("margwa_defense_hovering_fx", "margwa_defense_hovering_fx");
            }
            string = getdvarstring("margwa_defense_hovering_fx");
            if (string === "margwa_defense_hovering_fx") {
                level thread function_d11bf3e();
                setdvar("margwa_defense_hovering_fx", "margwa_defense_hovering_fx");
            }
            string = getdvarstring("margwa_defense_hovering_fx");
            if (string === "margwa_defense_hovering_fx") {
                level thread function_156bbea2();
                setdvar("margwa_defense_hovering_fx", "margwa_defense_hovering_fx");
            }
            wait(0.05);
        }
    }

    // Namespace namespace_3de4ab6f
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf27bb573, Offset: 0x69e0
    // Size: 0x174
    function function_a06aa49e() {
        players = getplayers();
        var_fda751f9 = getspawnerarray("margwa_defense_hovering_fx", "margwa_defense_hovering_fx");
        if (var_fda751f9.size <= 0) {
            iprintln("margwa_defense_hovering_fx");
            return;
        }
        var_ec316ddb = var_fda751f9[0];
        queryresult = positionquery_source_navigation(players[0].origin, -128, 256, -128, 20);
        spot = spawnstruct();
        spot.origin = players[0].origin;
        if (isdefined(queryresult) && queryresult.data.size > 0) {
            spot.origin = queryresult.data[0].origin;
        }
        level function_75b161ab(var_ec316ddb, spot);
    }

    // Namespace namespace_3de4ab6f
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5c5ecdb7, Offset: 0x6b60
    // Size: 0x174
    function function_156bbea2() {
        players = getplayers();
        var_5e8312fd = getspawnerarray("margwa_defense_hovering_fx", "margwa_defense_hovering_fx");
        if (var_5e8312fd.size <= 0) {
            iprintln("margwa_defense_hovering_fx");
            return;
        }
        var_ec316ddb = var_5e8312fd[0];
        queryresult = positionquery_source_navigation(players[0].origin, -128, 256, -128, 20);
        spot = spawnstruct();
        spot.origin = players[0].origin;
        if (isdefined(queryresult) && queryresult.data.size > 0) {
            spot.origin = queryresult.data[0].origin;
        }
        level function_26efbc37(var_ec316ddb, spot);
    }

    // Namespace namespace_3de4ab6f
    // Params 0, eflags: 0x0
    // Checksum 0xfa103a34, Offset: 0x6ce0
    // Size: 0x174
    function function_f6720b6e() {
        players = getplayers();
        var_1977e3bb = getspawnerarray("margwa_defense_hovering_fx", "margwa_defense_hovering_fx");
        if (var_1977e3bb.size <= 0) {
            iprintln("margwa_defense_hovering_fx");
            return;
        }
        var_ec316ddb = var_1977e3bb[0];
        queryresult = positionquery_source_navigation(players[0].origin, -128, 256, -128, 20);
        spot = spawnstruct();
        spot.origin = players[0].origin;
        if (isdefined(queryresult) && queryresult.data.size > 0) {
            spot.origin = queryresult.data[0].origin;
        }
        level function_12301fd1(var_ec316ddb, spot);
    }

    // Namespace namespace_3de4ab6f
    // Params 0, eflags: 0x0
    // Checksum 0x9683e9a3, Offset: 0x6e60
    // Size: 0x174
    function function_812b0245() {
        players = getplayers();
        var_9ceb03c8 = getspawnerarray("margwa_defense_hovering_fx", "margwa_defense_hovering_fx");
        if (var_9ceb03c8.size <= 0) {
            iprintln("margwa_defense_hovering_fx");
            return;
        }
        var_ec316ddb = var_9ceb03c8[0];
        queryresult = positionquery_source_navigation(players[0].origin, -128, 256, -128, 20);
        spot = spawnstruct();
        spot.origin = players[0].origin;
        if (isdefined(queryresult) && queryresult.data.size > 0) {
            spot.origin = queryresult.data[0].origin;
        }
        level function_5b1c9e5c(var_ec316ddb, spot);
    }

    // Namespace namespace_3de4ab6f
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb1f9038a, Offset: 0x6fe0
    // Size: 0xb2
    function function_50a5b7b6() {
        var_9ca661a2 = getaiarchetypearray("margwa_defense_hovering_fx");
        foreach (margwa in var_9ca661a2) {
            margwa kill();
        }
    }

    // Namespace namespace_3de4ab6f
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc53687f9, Offset: 0x70a0
    // Size: 0xea
    function function_d11bf3e() {
        var_9ca661a2 = getaiarchetypearray("margwa_defense_hovering_fx");
        foreach (margwa in var_9ca661a2) {
            if (!isdefined(margwa.var_9e2d6dc4)) {
                margwa.var_9e2d6dc4 = 1;
                continue;
            }
            margwa.var_9e2d6dc4 = !margwa.var_9e2d6dc4;
        }
    }

#/
