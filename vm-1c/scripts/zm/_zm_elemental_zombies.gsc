#using scripts/zm/_zm_devgui;
#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/animation_shared;
#using scripts/shared/_burnplayer;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai_shared;

#namespace namespace_57695b4d;

// Namespace namespace_57695b4d
// Params 0, eflags: 0x2
// namespace_57695b4d<file_0>::function_2dc19561
// Checksum 0x1a2c8a6, Offset: 0x5b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_elemental_zombie", &__init__, undefined, undefined);
}

// Namespace namespace_57695b4d
// Params 0, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_8c87d8eb
// Checksum 0xcf092cc1, Offset: 0x5f0
// Size: 0x44
function __init__() {
    register_clientfields();
    /#
        execdevgui("napalm_damaged_fx");
        thread function_f6901b6a();
    #/
}

// Namespace namespace_57695b4d
// Params 0, eflags: 0x5 linked
// namespace_57695b4d<file_0>::function_4ece4a2f
// Checksum 0x7253fbc5, Offset: 0x640
// Size: 0x124
function private register_clientfields() {
    clientfield::register("actor", "sparky_zombie_spark_fx", 1, 1, "int");
    clientfield::register("actor", "sparky_zombie_death_fx", 1, 1, "int");
    clientfield::register("actor", "napalm_zombie_death_fx", 1, 1, "int");
    clientfield::register("actor", "sparky_damaged_fx", 1, 1, "counter");
    clientfield::register("actor", "napalm_damaged_fx", 1, 1, "counter");
    clientfield::register("actor", "napalm_sfx", 11000, 1, "int");
}

// Namespace namespace_57695b4d
// Params 0, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_1b1bb1b
// Checksum 0xf0110717, Offset: 0x770
// Size: 0x264
function function_1b1bb1b() {
    ai_zombie = self;
    if (!isalive(ai_zombie)) {
        return;
    }
    var_199ecc3a = function_4aeed0a5("sparky");
    if (!isdefined(level.var_1ae26ca5) || var_199ecc3a < level.var_1ae26ca5) {
        if (!isdefined(ai_zombie.var_6c653628) || ai_zombie.var_6c653628 == 0) {
            ai_zombie.var_6c653628 = 1;
            ai_zombie.var_9a02a614 = "sparky";
            ai_zombie clientfield::set("sparky_zombie_spark_fx", 1);
            ai_zombie.health = int(ai_zombie.health * 1.5);
            ai_zombie thread function_d9226011();
            ai_zombie thread function_2987b6dc();
            if (ai_zombie.iscrawler === 1) {
                var_f4a5c99 = array("ai_zm_dlc1_zombie_crawl_turn_sparky_a", "ai_zm_dlc1_zombie_crawl_turn_sparky_b", "ai_zm_dlc1_zombie_crawl_turn_sparky_c", "ai_zm_dlc1_zombie_crawl_turn_sparky_d", "ai_zm_dlc1_zombie_crawl_turn_sparky_e");
            } else {
                var_f4a5c99 = array("ai_zm_dlc1_zombie_turn_sparky_a", "ai_zm_dlc1_zombie_turn_sparky_b", "ai_zm_dlc1_zombie_turn_sparky_c", "ai_zm_dlc1_zombie_turn_sparky_d", "ai_zm_dlc1_zombie_turn_sparky_e");
            }
            if (isdefined(ai_zombie) && !isdefined(ai_zombie.traversestartnode) && !(isdefined(self.var_bb98125f) && self.var_bb98125f)) {
                ai_zombie animation::play(array::random(var_f4a5c99), ai_zombie, undefined, 1, 0.2, 0.2);
            }
        }
    }
}

// Namespace namespace_57695b4d
// Params 0, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_f4defbc2
// Checksum 0x9d8b369a, Offset: 0x9e0
// Size: 0x174
function function_f4defbc2() {
    if (isdefined(self)) {
        ai_zombie = self;
        var_ac4641b = function_4aeed0a5("napalm");
        if (!isdefined(level.var_bd64e31e) || var_ac4641b < level.var_bd64e31e) {
            if (!isdefined(ai_zombie.var_6c653628) || ai_zombie.var_6c653628 == 0) {
                ai_zombie.var_6c653628 = 1;
                ai_zombie.var_9a02a614 = "napalm";
                ai_zombie clientfield::set("arch_actor_fire_fx", 1);
                ai_zombie clientfield::set("napalm_sfx", 1);
                ai_zombie.health = int(ai_zombie.health * 0.75);
                ai_zombie thread function_e94aef80();
                ai_zombie thread function_d070bfba();
                ai_zombie zombie_utility::set_zombie_run_cycle("sprint");
            }
        }
    }
}

// Namespace namespace_57695b4d
// Params 0, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_2987b6dc
// Checksum 0xd74a2c3f, Offset: 0xb60
// Size: 0x78
function function_2987b6dc() {
    self endon(#"entityshutdown");
    self endon(#"death");
    while (true) {
        self waittill(#"damage");
        if (randomint(100) < 50) {
            self clientfield::increment("sparky_damaged_fx");
        }
        wait(0.05);
    }
}

// Namespace namespace_57695b4d
// Params 0, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_d070bfba
// Checksum 0x8e85bd04, Offset: 0xbe0
// Size: 0x78
function function_d070bfba() {
    self endon(#"entityshutdown");
    self endon(#"death");
    while (true) {
        self waittill(#"damage");
        if (randomint(100) < 50) {
            self clientfield::increment("napalm_damaged_fx");
        }
        wait(0.05);
    }
}

// Namespace namespace_57695b4d
// Params 0, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_d9226011
// Checksum 0x4f30462b, Offset: 0xc60
// Size: 0xec
function function_d9226011() {
    ai_zombie = self;
    attacker = ai_zombie waittill(#"death");
    if (!isdefined(ai_zombie) || ai_zombie.nuked === 1) {
        return;
    }
    ai_zombie clientfield::set("sparky_zombie_death_fx", 1);
    ai_zombie zombie_utility::gib_random_parts();
    gibserverutils::annihilate(ai_zombie);
    radiusdamage(ai_zombie.origin + (0, 0, 35), -128, 70, 30, self, "MOD_EXPLOSIVE");
}

// Namespace namespace_57695b4d
// Params 0, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_e94aef80
// Checksum 0x3b319540, Offset: 0xd58
// Size: 0x13c
function function_e94aef80() {
    ai_zombie = self;
    attacker = ai_zombie waittill(#"death");
    if (!isdefined(ai_zombie) || ai_zombie.nuked === 1) {
        return;
    }
    ai_zombie clientfield::set("napalm_zombie_death_fx", 1);
    ai_zombie zombie_utility::gib_random_parts();
    gibserverutils::annihilate(ai_zombie);
    if (isdefined(ai_zombie.var_36b5dab) && (isdefined(level.var_36b5dab) && level.var_36b5dab || ai_zombie.var_36b5dab)) {
        ai_zombie.custom_player_shellshock = &function_e6cd7e78;
    }
    radiusdamage(ai_zombie.origin + (0, 0, 35), -128, 70, 30, self, "MOD_EXPLOSIVE");
}

// Namespace namespace_57695b4d
// Params 5, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_e6cd7e78
// Checksum 0x4b4a28fc, Offset: 0xea0
// Size: 0x74
function function_e6cd7e78(damage, attacker, direction_vec, point, mod) {
    if (getdvarstring("blurpain") == "on") {
        self shellshock("pain_zm", 0.5);
    }
}

// Namespace namespace_57695b4d
// Params 0, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_d41418b8
// Checksum 0x72bb41c7, Offset: 0xf20
// Size: 0x64
function function_d41418b8() {
    a_zombies = getaiarchetypearray("zombie");
    var_abbab1d4 = array::filter(a_zombies, 0, &function_b804eb62);
    return var_abbab1d4;
}

// Namespace namespace_57695b4d
// Params 1, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_c50e890f
// Checksum 0xdc4c9f9a, Offset: 0xf90
// Size: 0x6c
function function_c50e890f(type) {
    a_zombies = getaiarchetypearray("zombie");
    var_abbab1d4 = array::filter(a_zombies, 0, &function_361f6caa, type);
    return var_abbab1d4;
}

// Namespace namespace_57695b4d
// Params 1, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_4aeed0a5
// Checksum 0x96918936, Offset: 0x1008
// Size: 0x36
function function_4aeed0a5(type) {
    a_zombies = function_c50e890f(type);
    return a_zombies.size;
}

// Namespace namespace_57695b4d
// Params 2, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_361f6caa
// Checksum 0x2f762ef0, Offset: 0x1048
// Size: 0x28
function function_361f6caa(ai_zombie, type) {
    return ai_zombie.var_9a02a614 === type;
}

// Namespace namespace_57695b4d
// Params 1, eflags: 0x1 linked
// namespace_57695b4d<file_0>::function_b804eb62
// Checksum 0x735f2321, Offset: 0x1078
// Size: 0x20
function function_b804eb62(ai_zombie) {
    return ai_zombie.var_6c653628 !== 1;
}

/#

    // Namespace namespace_57695b4d
    // Params 0, eflags: 0x1 linked
    // namespace_57695b4d<file_0>::function_f6901b6a
    // Checksum 0xba93fa13, Offset: 0x10a0
    // Size: 0x44
    function function_f6901b6a() {
        level flagsys::wait_till("napalm_damaged_fx");
        zm_devgui::add_custom_devgui_callback(&function_2d0e7f4);
    }

    // Namespace namespace_57695b4d
    // Params 1, eflags: 0x1 linked
    // namespace_57695b4d<file_0>::function_2d0e7f4
    // Checksum 0x45688692, Offset: 0x10f0
    // Size: 0x28e
    function function_2d0e7f4(cmd) {
        switch (cmd) {
        case 8:
            a_zombies = function_d41418b8();
            if (a_zombies.size > 0) {
                a_zombies = arraysortclosest(a_zombies, level.players[0].origin);
                a_zombies[0] function_1b1bb1b();
            }
            break;
        case 8:
            a_zombies = function_d41418b8();
            if (a_zombies.size > 0) {
                a_zombies = arraysortclosest(a_zombies, level.players[0].origin);
                a_zombies[0] function_f4defbc2();
            }
            break;
        case 8:
            a_zombies = function_d41418b8();
            if (a_zombies.size > 0) {
                foreach (zombie in a_zombies) {
                    zombie function_1b1bb1b();
                }
            }
            break;
        case 8:
            a_zombies = function_d41418b8();
            if (a_zombies.size > 0) {
                foreach (zombie in a_zombies) {
                    zombie function_f4defbc2();
                }
            }
            break;
        }
    }

#/
