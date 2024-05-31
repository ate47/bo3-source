#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_debug;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/compass;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_391e4301;

// Namespace namespace_391e4301
// Params 0, eflags: 0x2
// namespace_391e4301<file_0>::function_2dc19561
// Checksum 0xed9a1d98, Offset: 0xb70
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("ramses_util", &__init__, undefined, undefined);
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_8c87d8eb
// Checksum 0xec03d904, Offset: 0xbb0
// Size: 0x94
function __init__() {
    clientfield::register("toplayer", "ramses_sun_color", 1, 1, "int");
    clientfield::register("toplayer", "dni_eye", 1, 1, "int");
    clientfield::register("scriptmover", "hide_graphic_content", 1, 1, "counter");
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_cec9e261
// Checksum 0xd95b3ac0, Offset: 0xc50
// Size: 0x1a
function is_demo() {
    return getdvarint("is_demo_build", 0);
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_22e1a261
// Checksum 0x37c0993c, Offset: 0xc78
// Size: 0x84
function function_22e1a261() {
    exploder::exploder("transition");
    level function_c20af84a();
    getent("lgt_shadow_block_trans", "targetname") show();
    level clientfield::set("alley_fog_banks", 1);
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_8a9650aa
// Checksum 0xc40079dc, Offset: 0xd08
// Size: 0xf2
function function_8a9650aa() {
    foreach (player in level.players) {
        if (player isinvehicle()) {
            vh_occupied = player getvehicleoccupied();
            n_seat = vh_occupied getoccupantseat(player);
            vh_occupied usevehicle(player, n_seat);
        }
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_c3080ff8
// Checksum 0x6041f593, Offset: 0xe08
// Size: 0xea
function function_c3080ff8(b_enable) {
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    if (!isarray(self)) {
        a_e_players = array(self);
    } else {
        a_e_players = self;
    }
    foreach (e_player in a_e_players) {
        e_player util::function_16c71b8(b_enable);
    }
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_1903e7dc
// Checksum 0xce77b58d, Offset: 0xf00
// Size: 0xbc
function function_1903e7dc() {
    hidemiscmodels("arena_billboard_static2");
    hidemiscmodels("arena_billboard_02_static2");
    hidemiscmodels("cinema_collapse_static2");
    hidemiscmodels("quadtank_statue_static2");
    hidemiscmodels("rocket_static2");
    hidemiscmodels("glass_building_static2");
    hidemiscmodels("wall_collapse_static2");
    function_2f9e262a();
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_2f9e262a
// Checksum 0x34222945, Offset: 0xfc8
// Size: 0x314
function function_2f9e262a() {
    scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_bundle", &function_1c347e72, "init", "arena_billboard_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_bundle", &function_a72c2dda, "done", "arena_billboard_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_02_bundle", &function_1c347e72, "init", "arena_billboard_02_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_arena_billboard_02_bundle", &function_a72c2dda, "done", "arena_billboard_02_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_cinema_collapse_bundle", &function_1c347e72, "init", "cinema_collapse_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_cinema_collapse_bundle", &function_a72c2dda, "done", "cinema_collapse_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_statue_bundle", &function_1c347e72, "init", "quadtank_statue_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_statue_bundle", &function_a72c2dda, "done", "quadtank_statue_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle", &function_1c347e72, "init", "rocket_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle", &function_a72c2dda, "done", "rocket_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle", &function_1c347e72, "init", "glass_building_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle", &function_a72c2dda, "done", "glass_building_static2");
    scene::add_scene_func("p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &function_1c347e72, "init", "wall_collapse_static1");
    scene::add_scene_func("p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &function_a72c2dda, "done", "wall_collapse_static2");
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_1c347e72
// Checksum 0xeaf84da5, Offset: 0x12e8
// Size: 0x2c
function function_1c347e72(a_ents, str_targetname) {
    hidemiscmodels(str_targetname);
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_a72c2dda
// Checksum 0x81d0b3a2, Offset: 0x1320
// Size: 0xd2
function function_a72c2dda(a_ents, str_targetname) {
    showmiscmodels(str_targetname);
    foreach (ent in a_ents) {
        if (isdefined(ent) && !issentient(ent)) {
            ent delete();
        }
    }
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_a0a9f927
// Checksum 0x25af9c5a, Offset: 0x1400
// Size: 0xfa
function function_a0a9f927() {
    var_3ecc15f7 = getentarray("recovery_fan", "targetname");
    foreach (mdl_fan in var_3ecc15f7) {
        mdl_fan thread function_a4998afa(2);
        mdl_fan thread function_f81a38c8();
        wait(randomfloatrange(0.5, 1.5));
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_a4998afa
// Checksum 0xe60a0cfd, Offset: 0x1508
// Size: 0x54
function function_a4998afa(var_5dbde88f) {
    self endon(#"hash_fb28e86c");
    while (true) {
        self rotateyaw(-76, var_5dbde88f / 2);
        wait(var_5dbde88f / 2);
    }
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_f81a38c8
// Checksum 0x7dfc973e, Offset: 0x1568
// Size: 0x9c
function function_f81a38c8() {
    t_damage = getent(self.target, "targetname");
    t_damage waittill(#"trigger");
    self notify(#"hash_fb28e86c");
    self waittill(#"rotatedone");
    self rotateto(self.angles + (0, 15, 0), 1.25, 0.05, 0.75);
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_e7ebe596
// Checksum 0xd326292f, Offset: 0x1610
// Size: 0x20
function function_e7ebe596(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// namespace_391e4301<file_0>::function_9f4f118
// Checksum 0x1325d10e, Offset: 0x1638
// Size: 0x4c
function function_9f4f118(str_value, str_key) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    level thread function_db4d0261(str_value, str_key);
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_db4d0261
// Checksum 0x45f00088, Offset: 0x1690
// Size: 0xea
function function_db4d0261(str_value, str_key) {
    a_ents = getentarray(str_value, str_key);
    foreach (i, ent in a_ents) {
        if (i % 3) {
            wait(0.05);
        }
        if (isdefined(ent)) {
            ent delete();
        }
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_d4a0bb54
// Checksum 0x29e25696, Offset: 0x1788
// Size: 0x38c
function function_d4a0bb54(var_5d2441df) {
    if (!isdefined(var_5d2441df)) {
        var_5d2441df = 0;
    }
    level.var_5e3ce707 = [];
    var_6ff300d5 = getentarray("dead_turrets_non_controllable", "targetname");
    if (var_5d2441df) {
        foreach (var_f074d981 in var_6ff300d5) {
            var_70345f7f = spawn("script_model", var_f074d981.origin);
            var_70345f7f.angles = var_f074d981.angles;
            var_70345f7f setmodel("veh_t7_turret_dead_system_ramses");
        }
    } else {
        foreach (var_f074d981 in var_6ff300d5) {
            var_880708d8 = spawner::simple_spawn_single(var_f074d981);
            level.var_5e3ce707[level.var_5e3ce707.size] = var_880708d8;
            var_880708d8.takedamage = 0;
        }
    }
    level.var_48964153 = [];
    var_99d3b4e1 = getentarray("dead_turrets", "script_noteworthy");
    foreach (var_f074d981 in var_99d3b4e1) {
        var_880708d8 = spawner::simple_spawn_single(var_f074d981);
        level.var_48964153[level.var_48964153.size] = var_880708d8;
        var_880708d8.var_21ca2076 = 0;
        var_880708d8.takedamage = 0;
        if (isdefined(var_f074d981.script_int)) {
            assert(isdefined(var_880708d8.script_int), "is_demo_build");
            var_880708d8.script_int = var_f074d981.script_int;
        }
    }
    level.var_9657b09b = arraycombine(level.var_48964153, level.var_5e3ce707, 1, 0);
    level flag::set("dead_turrets_initialized");
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_37357151
// Checksum 0xc1a3a6e3, Offset: 0x1b20
// Size: 0xc2
function function_37357151() {
    level notify(#"hash_24a38c8f");
    if (isdefined(level.var_9657b09b)) {
        foreach (e_turret in level.var_9657b09b) {
            e_turret delete();
        }
    }
    level.var_5e3ce707 = undefined;
    level.var_48964153 = undefined;
    level.var_9657b09b = undefined;
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_6b4b5556
// Checksum 0x7dc2a132, Offset: 0x1bf0
// Size: 0x12a
function hide_ents(var_46b6a64a) {
    if (!isdefined(var_46b6a64a)) {
        var_46b6a64a = 0;
    }
    foreach (e in self) {
        e hide();
    }
    if (var_46b6a64a) {
        foreach (e in self) {
            e connectpaths();
            wait(0.05);
        }
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_64a470cf
// Checksum 0x575335da, Offset: 0x1d28
// Size: 0x222
function show_ents(var_29cfceb6) {
    if (!isdefined(var_29cfceb6)) {
        var_29cfceb6 = 0;
    }
    foreach (e in self) {
        e show();
    }
    if (var_29cfceb6) {
        foreach (e in self) {
            if (e.targetname !== "path_neutral") {
                if (isdefined(e.script_noteworthy) && e.script_noteworthy == "connect_paths") {
                    e connectpaths();
                } else if (e.model == "p7_cai_stacking_cargo_crate" || e.classname === "script_model" && (e.classname === "script_brushmodel" && e.script_noteworthy !== "do_not_disconnect" || e.model == "veh_t7_mil_vtol_dropship_troopcarrier")) {
                    e disconnectpaths();
                }
            }
            wait(0.05);
        }
    }
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_c3458a6
// Checksum 0x390580a9, Offset: 0x1f58
// Size: 0x132
function function_c3458a6() {
    n_count = 0;
    foreach (struct in self) {
        if (isdefined(struct.model)) {
            var_4f9043bf = spawn("script_model", struct.origin);
            var_4f9043bf.angles = struct.angles;
            var_4f9043bf setmodel(struct.model);
            n_count++;
            if (n_count % 10 == 0) {
                util::wait_network_frame();
            }
        }
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_41f6f501
// Checksum 0xb7c915d2, Offset: 0x2098
// Size: 0x15a
function function_41f6f501(b_moving) {
    if (isarray(self)) {
        var_709349fa = self;
    } else {
        var_709349fa = array(self);
    }
    foreach (e in var_709349fa) {
        e notsolid();
    }
    if (isdefined(b_moving)) {
        foreach (e in var_709349fa) {
            e setmovingplatformenabled(b_moving);
        }
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_da54f24b
// Checksum 0xc3990c74, Offset: 0x2200
// Size: 0x15a
function make_solid(b_moving) {
    if (isarray(self)) {
        var_709349fa = self;
    } else {
        var_709349fa = array(self);
    }
    foreach (e in var_709349fa) {
        e solid();
    }
    if (isdefined(b_moving)) {
        foreach (e in var_709349fa) {
            e setmovingplatformenabled(b_moving);
        }
    }
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// namespace_391e4301<file_0>::function_4615ba30
// Checksum 0xc73e9390, Offset: 0x2368
// Size: 0x278
function set_visible(var_32c6c398, b_visible) {
    if (!isdefined(b_visible)) {
        b_visible = 1;
    }
    var_f7480a72 = getentarray(var_32c6c398, "targetname");
    a_e_players = self;
    if (!isarray(self)) {
        a_e_players = array(self);
    }
    if (b_visible) {
        foreach (e_player in a_e_players) {
            foreach (var_f89a5212 in var_f7480a72) {
                var_f89a5212 setvisibletoplayer(e_player);
            }
        }
        return;
    }
    foreach (e_player in a_e_players) {
        foreach (var_f89a5212 in var_f7480a72) {
            var_f89a5212 setinvisibletoplayer(e_player);
        }
    }
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// namespace_391e4301<file_0>::function_ad67ec60
// Checksum 0xff793a60, Offset: 0x25e8
// Size: 0x1ca
function function_ad67ec60(var_e59ce4f8, var_c487ec13) {
    if (!isdefined(var_e59ce4f8)) {
        var_e59ce4f8 = 1;
    }
    if (!isdefined(var_c487ec13)) {
        var_c487ec13 = 1;
    }
    if (flagsys::get("mobile_armory_in_use")) {
        return;
    }
    a_e_players = self;
    if (!isarray(a_e_players)) {
        a_e_players = array(a_e_players);
    }
    var_1b7b3a6 = getweapon("spike_launcher");
    foreach (e_player in a_e_players) {
        e_player giveweapon(var_1b7b3a6);
        e_player setweaponammoclip(var_1b7b3a6, var_1b7b3a6.clipsize);
        e_player givemaxammo(var_1b7b3a6);
        if (var_e59ce4f8) {
            e_player switchtoweapon(var_1b7b3a6);
        }
        if (var_c487ec13) {
            e_player thread function_fc0b27df(var_1b7b3a6);
        }
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_fc0b27df
// Checksum 0xbec7a644, Offset: 0x27c0
// Size: 0x94
function function_fc0b27df(var_1b7b3a6) {
    self endon(#"death");
    w_current = self getcurrentweapon();
    while (!self flag::get("spike_launcher_tutorial_complete")) {
        if (w_current == var_1b7b3a6) {
            self function_bd4d52fa(var_1b7b3a6);
            continue;
        }
        w_current = self waittill(#"weapon_change_complete");
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_bd4d52fa
// Checksum 0x6832dfee, Offset: 0x2860
// Size: 0x9c
function function_bd4d52fa(var_1b7b3a6) {
    self endon(#"death");
    self endon(#"detonate");
    self endon(#"hash_f4dfb01b");
    w_current = self waittill(#"weapon_fired");
    if (w_current == var_1b7b3a6) {
        wait(2);
        self thread function_c2712461();
        self util::waittill_any("detonate", "last_stand_detonate");
    }
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_c2712461
// Checksum 0xdc5e12c0, Offset: 0x2908
// Size: 0x106
function function_c2712461() {
    self endon(#"death");
    self notify(#"hash_c2712461");
    self endon(#"hash_c2712461");
    if (isdefined(self.var_f30613a1)) {
        self util::hide_hint_text();
        wait(0.05);
    }
    var_1b7b3a6 = getweapon("spike_launcher");
    self util::show_hint_text(%CP_MI_CAIRO_RAMSES_SPIKE_LAUNCHER_DETONATE, 1, "spike_launcher_tutorial_complete", 20);
    self.var_99c7680e = 1;
    self util::waittill_any_timeout(20, "detonate", "last_stand_detonate");
    self flag::set("spike_launcher_tutorial_complete");
    self.var_f30613a1 = undefined;
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_780e57a1
// Checksum 0xdedc8bc0, Offset: 0x2a18
// Size: 0x100
function function_780e57a1() {
    level endon(#"hash_adc3dca5");
    self endon(#"detonate");
    self endon(#"hash_f4dfb01b");
    self endon(#"death");
    w_current = self getcurrentweapon();
    var_1b7b3a6 = getweapon("spike_launcher");
    while (!self flag::get("spike_launcher_tutorial_complete")) {
        w_current = self waittill(#"weapon_change_complete");
        if (w_current != var_1b7b3a6) {
            self util::hide_hint_text();
            continue;
        }
        self util::show_hint_text(%CP_MI_CAIRO_RAMSES_SPIKE_LAUNCHER_DETONATE, 1, "spike_launcher_tutorial_complete", 20);
    }
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_25439df2
// Checksum 0x97a22154, Offset: 0x2b20
// Size: 0x11a
function function_25439df2() {
    a_e_players = self;
    if (!isarray(a_e_players)) {
        a_e_players = array(a_e_players);
    }
    var_1b7b3a6 = getweapon("spike_launcher");
    foreach (e_player in a_e_players) {
        if (e_player hasweapon(var_1b7b3a6)) {
            e_player takeweapon(var_1b7b3a6);
        }
    }
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_486f25d
// Checksum 0x85205fba, Offset: 0x2c48
// Size: 0x11c
function function_486f25d(var_86b557eb, var_745f5923, var_637003f5) {
    var_a0117743 = isdefined(var_86b557eb) || isdefined(var_745f5923) || isdefined(var_637003f5);
    assert(isdefined(var_a0117743) && var_a0117743, "is_demo_build" + self.targetname + "is_demo_build" + self.origin);
    if (isdefined(var_86b557eb)) {
        self.count = function_411dc61b(self.count, var_86b557eb);
    }
    if (isdefined(var_745f5923)) {
        self.var_e290d32d = function_411dc61b(self.var_e290d32d, var_745f5923);
    }
    if (isdefined(var_637003f5)) {
        self.var_5fa59123 = function_411dc61b(self.var_5fa59123, var_637003f5);
    }
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_411dc61b
// Checksum 0x65b98840, Offset: 0x2d70
// Size: 0xb0
function function_411dc61b(n_base, var_df47d27) {
    n_num = n_base - var_df47d27;
    foreach (e_player in level.players) {
        n_num += var_df47d27;
    }
    return n_num;
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_d4b64a0d
// Checksum 0xe0adfa5e, Offset: 0x2e28
// Size: 0x48
function function_d4b64a0d() {
    e_player = self[0];
    if (self.size > 1) {
        e_player = self[randomint(self.size)];
    }
    return e_player;
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_44514fc0
// Checksum 0xd562cf5a, Offset: 0x2e78
// Size: 0xc8
function function_44514fc0() {
    var_a84756db = [];
    for (i = 0; i < level.players.size; i++) {
        if (!level.players[i] laststand::player_is_in_laststand()) {
            if (!isdefined(var_a84756db)) {
                var_a84756db = [];
            } else if (!isarray(var_a84756db)) {
                var_a84756db = array(var_a84756db);
            }
            var_a84756db[var_a84756db.size] = level.players[i];
        }
    }
    return var_a84756db;
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// namespace_391e4301<file_0>::function_beaafab6
// Checksum 0x5c4a090f, Offset: 0x2f48
// Size: 0xd0
function kill_players(str_notify) {
    level endon(str_notify);
    while (true) {
        var_efb53e77 = self waittill(#"trigger");
        for (i = 0; i < level.players.size; i++) {
            if (var_efb53e77 == level.players[i] && !var_efb53e77 laststand::player_is_in_laststand()) {
                var_efb53e77 dodamage(var_efb53e77.health + 100, var_efb53e77.origin);
            }
        }
        wait(1);
    }
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_16ccc3fd
// Checksum 0x97e25242, Offset: 0x3020
// Size: 0x90
function function_16ccc3fd() {
    while (true) {
        var_cb8bd87d = 0;
        for (i = 0; i < level.players.size; i++) {
            if (level.players[i] util::is_looking_at(self)) {
                var_cb8bd87d++;
            }
        }
        if (var_cb8bd87d == 0) {
            return;
        }
        wait(0.25);
    }
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// namespace_391e4301<file_0>::function_7129cde6
// Checksum 0x6193b31b, Offset: 0x30b8
// Size: 0x114
function function_7129cde6(str_endon, n_radius) {
    if (!isdefined(n_radius)) {
        n_radius = 256;
    }
    self endon(#"death");
    if (isdefined(str_endon)) {
        level endon(str_endon);
    }
    self.goalradius = n_radius;
    while (true) {
        var_a84756db = function_44514fc0();
        var_821b0ced = var_a84756db function_d4b64a0d();
        while (isdefined(var_821b0ced) && !var_821b0ced laststand::player_is_in_laststand()) {
            self setgoal(var_821b0ced getorigin());
            wait(randomfloatrange(2, 4));
        }
        wait(0.15);
    }
}

// Namespace namespace_391e4301
// Params 6, eflags: 0x0
// namespace_391e4301<file_0>::function_a700a8ea
// Checksum 0x66f80af5, Offset: 0x31d8
// Size: 0x280
function function_a700a8ea(var_a9ea049a, str_key, var_c3e600e3, var_c4a1b346, str_endon, var_53af6159) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    level endon(str_endon);
    var_f2475306 = [];
    a_spawners = getentarray(var_a9ea049a, str_key);
    if (!isdefined(var_c3e600e3)) {
        var_c3e600e3 = a_spawners.size;
    }
    var_c4a1b346 thread function_1321e32f(str_endon);
    while (true) {
        a_spawners = array::randomize(a_spawners);
        for (i = 0; i < var_c3e600e3; i++) {
            var_e578579f = a_spawners[i] spawner::spawn();
            wait(0.05);
            if (isalive(var_e578579f)) {
                if (isai(var_e578579f)) {
                    if (!isdefined(var_f2475306)) {
                        var_f2475306 = [];
                    } else if (!isarray(var_f2475306)) {
                        var_f2475306 = array(var_f2475306);
                    }
                    var_f2475306[var_f2475306.size] = var_e578579f;
                    var_e578579f ai::set_ignoreall(1);
                    var_e578579f.goalradius = 8;
                    continue;
                }
                if (isvehicle(var_e578579f)) {
                    nd_spline = getvehiclenode(var_e578579f.target, "targetname");
                    var_e578579f thread vehicle::get_on_and_go_path(nd_spline);
                }
            }
        }
        array::wait_till(var_f2475306, "death", var_53af6159);
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_1321e32f
// Checksum 0xe60676, Offset: 0x3460
// Size: 0xc8
function function_1321e32f(str_endon) {
    level endon(str_endon);
    while (true) {
        var_e578579f = self waittill(#"trigger");
        if (isdefined(var_e578579f)) {
            if (isai(var_e578579f)) {
                var_e578579f delete();
                continue;
            }
            var_e578579f.delete_on_death = 1;
            var_e578579f notify(#"death");
            if (!isalive(var_e578579f)) {
                var_e578579f delete();
            }
        }
    }
}

// Namespace namespace_391e4301
// Params 10, eflags: 0x0
// namespace_391e4301<file_0>::function_e7fdcb95
// Checksum 0x1d8f9ab, Offset: 0x3530
// Size: 0x1f4
function function_e7fdcb95(var_2c34daa1, var_6fc1c7c6, var_f67c8a8e, var_bf7b0d42, var_7b2612a, var_a20f0ddd, var_71637749, var_4cfaa23a, var_381b2f34, var_42e6f5b4) {
    if (!isdefined(var_bf7b0d42)) {
        var_bf7b0d42 = 0;
    }
    if (!isdefined(var_7b2612a)) {
        var_7b2612a = 0;
    }
    if (!isdefined(var_71637749)) {
        var_71637749 = 0;
    }
    v_start = struct::get(var_2c34daa1 + "_start").origin;
    v_end = struct::get(var_2c34daa1 + "_end").origin;
    var_a3decff = new robotphalanx();
    [[ var_a3decff ]]->initialize(var_6fc1c7c6, v_start, v_end, var_f67c8a8e, var_42e6f5b4);
    if (isdefined(var_a20f0ddd)) {
        level waittill(var_a20f0ddd);
    }
    wait(var_7b2612a);
    if (var_bf7b0d42 && var_a3decff.scattered_ == 0) {
        var_a3decff robotphalanx::scatterphalanx();
    }
    if (var_71637749) {
        while (isdefined(var_a3decff) && var_a3decff.scattered_ == 0) {
            wait(0.25);
        }
        function_e0927f44(var_4cfaa23a, var_381b2f34, function_411dc61b(3, 1));
    }
}

// Namespace namespace_391e4301
// Params 4, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_e0927f44
// Checksum 0x372b5fd1, Offset: 0x3730
// Size: 0x146
function function_e0927f44(str_key, str_value, n_max, n_min) {
    if (!isdefined(str_value)) {
        str_value = "targetname";
    }
    var_64e85e6d = getentarray(str_key, str_value);
    var_64e85e6d = array::randomize(var_64e85e6d);
    var_a3784f7a = var_64e85e6d.size;
    if (isdefined(n_max)) {
        var_a3784f7a = n_max;
    }
    if (isdefined(n_min)) {
        var_a3784f7a = randomintrange(n_min, var_a3784f7a + 1);
    }
    for (i = 0; i < var_a3784f7a; i++) {
        if (isalive(var_64e85e6d[i])) {
            var_64e85e6d[i] ai::set_behavior_attribute("move_mode", "rusher");
        }
    }
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// namespace_391e4301<file_0>::function_cf956358
// Checksum 0xfa6ac15c, Offset: 0x3880
// Size: 0x3a
function function_cf956358(str_flag, func) {
    self flag::wait_till(str_flag);
    self thread [[ func ]]();
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_5ad47384
// Checksum 0x4bc423ec, Offset: 0x38c8
// Size: 0x16a
function function_5ad47384() {
    var_ea644274 = getaiteamarray("allies");
    foreach (ai in var_ea644274) {
        if (!isinarray(level.heroes, ai)) {
            ai delete();
        }
    }
    a_enemy = getaiteamarray("axis");
    foreach (ai in a_enemy) {
        ai delete();
    }
}

// Namespace namespace_391e4301
// Params 6, eflags: 0x0
// namespace_391e4301<file_0>::function_b0369bfa
// Checksum 0x5855606d, Offset: 0x3a40
// Size: 0x10c
function function_b0369bfa(str_flag, str_scene, n_delay, n_wait, var_e21d36a, str_endon) {
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    if (!isdefined(n_wait)) {
        n_wait = 0;
    }
    if (isdefined(str_endon)) {
        level endon(str_endon);
    }
    level flag::wait_till(str_flag);
    wait(n_delay);
    level thread scene::play(str_scene, "targetname");
    if (n_wait > 0 || isdefined(var_e21d36a)) {
        if (isdefined(var_e21d36a)) {
            level flag::wait_till(var_e21d36a);
        }
        wait(n_wait);
        level scene::stop(str_scene, "targetname", 1);
    }
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x0
// namespace_391e4301<file_0>::function_d0d2f172
// Checksum 0x38455e69, Offset: 0x3b58
// Size: 0x84
function function_d0d2f172(str_scene, str_notify) {
    assert(isdefined(str_scene), "is_demo_build");
    assert(isdefined(str_notify), "is_demo_build");
    self waittill(str_notify);
    self scene::play(str_scene);
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// namespace_391e4301<file_0>::function_4a1e5496
// Checksum 0xbe44bcf0, Offset: 0x3be8
// Size: 0xbc
function function_4a1e5496(anim_name, str_scene, str_notetrack) {
    var_c8722225 = getnotetracktimes(anim_name, str_notetrack);
    assert(var_c8722225.size, "is_demo_build" + str_scene + "is_demo_build" + str_notetrack + "is_demo_build");
    n_time = var_c8722225[0];
    self thread scene::skipto_end(str_scene, undefined, undefined, n_time);
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_3bc57aa8
// Checksum 0xc186bcbb, Offset: 0x3cb0
// Size: 0xa4
function function_3bc57aa8(a_ents, b_enable) {
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    if (isdefined(level.var_9db406db)) {
        level.var_9db406db sethighdetail(b_enable);
    }
    if (isdefined(level.var_2fd26037)) {
        level.var_2fd26037 sethighdetail(b_enable);
    }
    if (isdefined(level.var_7a9855f3)) {
        level.var_7a9855f3 sethighdetail(b_enable);
    }
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// namespace_391e4301<file_0>::function_3f4f84e
// Checksum 0xfffe3d26, Offset: 0x3d60
// Size: 0xfa
function function_3f4f84e(str_key, str_val, b_enable) {
    if (!isdefined(str_val)) {
        str_val = "targetname";
    }
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    a_nodes = getnodearray(str_key, str_val);
    foreach (var_22752fde in a_nodes) {
        setenablenode(var_22752fde, b_enable);
    }
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// namespace_391e4301<file_0>::function_8bf0b925
// Checksum 0xfd193792, Offset: 0x3e68
// Size: 0x162
function function_8bf0b925(str_key, str_val, b_link) {
    if (!isdefined(b_link)) {
        b_link = 1;
    }
    var_541a5daf = getnodearray(str_key, str_val);
    if (b_link) {
        foreach (nd in var_541a5daf) {
            linktraversal(nd);
        }
        return;
    }
    foreach (nd in var_541a5daf) {
        unlinktraversal(nd);
    }
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// namespace_391e4301<file_0>::function_508a129e
// Checksum 0x6a422d75, Offset: 0x3fd8
// Size: 0x17c
function function_508a129e(str_notify, n_time, var_45778f27) {
    if (!isdefined(var_45778f27)) {
        var_45778f27 = 1;
    }
    self notify(#"hash_5a334c0f");
    self endon(#"death");
    self endon(#"hash_5a334c0f");
    level flag::wait_till("intro_igc_done");
    var_1b7b3a6 = getweapon("spike_launcher");
    while (self getcurrentweapon() == var_1b7b3a6) {
        wait(0.2);
    }
    self util::show_hint_text(%COOP_EQUIP_SPIKE_LAUNCHER, 0, str_notify, n_time);
    while (var_45778f27 == 0) {
        self util::waittill_any("wp_01_destroyed", "weapon_change_complete");
        if (self getcurrentweapon() == var_1b7b3a6 || level flag::get("wp_01_destroyed")) {
            self notify(str_notify);
            var_45778f27 = 1;
            continue;
        }
        wait(0.1);
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_4edf60f2
// Checksum 0xa4c1dde2, Offset: 0x4160
// Size: 0xb4
function has_weapon(var_205ff529) {
    a_w_weapons = self getweaponslist();
    foreach (w in a_w_weapons) {
        if (w == var_205ff529) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// namespace_391e4301<file_0>::function_8806ea73
// Checksum 0x39028cc9, Offset: 0x4220
// Size: 0x3c
function function_8806ea73(str_weapon) {
    return self getcurrentweapon() == getweapon(str_weapon);
}

/#

    // Namespace namespace_391e4301
    // Params 1, eflags: 0x0
    // namespace_391e4301<file_0>::function_2de69092
    // Checksum 0xf276bc02, Offset: 0x4268
    // Size: 0x90
    function function_2de69092(e) {
        self endon(#"death");
        e endon(#"death");
        while (true) {
            line(e.origin, self.origin, (1, 0, 0), 0.1);
            debug::drawarrow(self.origin, self.angles);
            wait(0.05);
        }
    }

    // Namespace namespace_391e4301
    // Params 3, eflags: 0x0
    // namespace_391e4301<file_0>::function_fd1e50c8
    // Checksum 0xcfe4cf02, Offset: 0x4300
    // Size: 0xf0
    function function_fd1e50c8(target, n_timer, var_5b3dd4e) {
        self endon(#"death");
        target endon(#"death");
        n_timer = gettime() + n_timer * 1000;
        while (gettime() < n_timer) {
            var_fc5c855b = self.origin;
            if (isdefined(var_5b3dd4e)) {
                var_fc5c855b = self gettagorigin(var_5b3dd4e);
            }
            line(var_fc5c855b, target.origin, (1, 0, 0), 0.1);
            debug::drawarrow(target.origin, target.angles);
            wait(0.05);
        }
    }

    // Namespace namespace_391e4301
    // Params 1, eflags: 0x0
    // namespace_391e4301<file_0>::function_8a8944d6
    // Checksum 0x9c0f5e65, Offset: 0x43f8
    // Size: 0xd8
    function function_8a8944d6(var_133e9095) {
        while (isdefined(var_133e9095) && isdefined(self)) {
            line(var_133e9095.origin, self.origin, (1, 0, 0), 0.1);
            debug::debug_sphere(var_133e9095.origin, 16, (1, 0, 0), 0.5, 1);
            debug::drawarrow(self.origin, self.angles);
            debug::drawarrow(var_133e9095.origin, var_133e9095.angles);
            wait(0.05);
        }
    }

#/

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_a0731cf9
// Checksum 0xf46e46c0, Offset: 0x44d8
// Size: 0x54
function function_a0731cf9() {
    exploder::exploder("exploder_flak_arena_defend");
    level flag::wait_till("flak_arena_defend_stop");
    exploder::exploder_stop("exploder_flak_arena_defend");
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_1b048d07
// Checksum 0xfd1e5a03, Offset: 0x4538
// Size: 0x54
function function_1b048d07() {
    exploder::exploder("exploder_flak_alley");
    level flag::wait_till("flak_alley_stop");
    exploder::exploder_stop("exploder_flak_alley");
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_e950228a
// Checksum 0x60e4e3bc, Offset: 0x4598
// Size: 0x64
function function_e950228a(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (b_on) {
        exploder::exploder("fx_exploder_station_ambient_pre_collapse");
        return;
    }
    exploder::exploder_stop("fx_exploder_station_ambient_pre_collapse");
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_39044e10
// Checksum 0xf6b63c8c, Offset: 0x4608
// Size: 0x5c
function function_39044e10() {
    exploder::exploder("fx_exploder_turn_off_collapse");
    level flag::wait_till("sinkhole_charges_detonated");
    wait(1.5);
    exploder::exploder_stop("fx_exploder_turn_off_collapse");
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_ff06e7ac
// Checksum 0xd217b054, Offset: 0x4670
// Size: 0x96
function function_ff06e7ac() {
    util::wait_network_frame();
    if (isdefined(level.var_dd326dcd)) {
        switch (level.var_dd326dcd) {
        case 1:
            self function_9c087de1();
            break;
        case 2:
            self function_c20af84a();
            break;
        case 3:
            self function_75734d29();
            break;
        }
    }
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_9c087de1
// Checksum 0xec0eed03, Offset: 0x4710
// Size: 0x3c
function function_9c087de1() {
    level.var_dd326dcd = 1;
    self util::set_lighting_state(0);
    self function_8264a5e8(1);
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_c20af84a
// Checksum 0xf36b53ef, Offset: 0x4758
// Size: 0x44
function function_c20af84a() {
    level.var_dd326dcd = 2;
    self util::set_lighting_state(2);
    self function_8264a5e8(0);
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_75734d29
// Checksum 0xbd67918e, Offset: 0x47a8
// Size: 0x44
function function_75734d29() {
    level.var_dd326dcd = 3;
    self util::set_lighting_state(3);
    self function_8264a5e8(0);
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_8264a5e8
// Checksum 0xce5bb1d7, Offset: 0x47f8
// Size: 0xfc
function function_8264a5e8(n_value) {
    if (self == level) {
        foreach (player in level.players) {
            player function_8264a5e8(n_value);
        }
        return;
    }
    if (isplayer(self)) {
        self clientfield::set_to_player("ramses_sun_color", n_value);
        return;
    }
    assertmsg("is_demo_build");
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x0
// namespace_391e4301<file_0>::function_7df1bd5b
// Checksum 0x8e4a6203, Offset: 0x4900
// Size: 0x152
function function_7df1bd5b(var_b22a2ac4, var_cc890dd4, var_db395c04) {
    assert(isdefined(var_b22a2ac4), "is_demo_build");
    assert(isdefined(var_cc890dd4), "is_demo_build");
    assert(isdefined(var_db395c04), "is_demo_build");
    level endon(var_cc890dd4);
    var_c8d90fa3 = getent(var_b22a2ac4, "targetname");
    assert(isdefined(var_c8d90fa3), "is_demo_build" + var_b22a2ac4 + "is_demo_build");
    while (true) {
        e_player = var_c8d90fa3 waittill(#"trigger");
        if (isdefined(e_player) && isplayer(e_player)) {
            e_player [[ var_db395c04 ]]();
        }
    }
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_eabc6e2f
// Checksum 0x43220242, Offset: 0x4a60
// Size: 0x13a
function function_eabc6e2f() {
    level clientfield::set("turn_on_rotating_fxanim_lights", 1);
    exploder::exploder("lgt_emergency");
    var_239ba8ce = getentarray("lgt_tent_probe", "script_noteworthy");
    foreach (ent in var_239ba8ce) {
        if (ent.classname == "reflection_probe") {
            ent.origin -= (0, 0, 5000);
            continue;
        }
        ent delete();
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_b0ef4ae7
// Checksum 0x53747206, Offset: 0x4ba8
// Size: 0x264
function function_b0ef4ae7(s_obj) {
    self endon(#"death");
    waittillframeend();
    w_hero = getweapon("lmg_light");
    var_c0cba69a = spawn("trigger_radius", self.origin + (0, 0, 24), 0, s_obj.radius, -128);
    var_c0cba69a.targetname = "turret_pickup_trig";
    var_c0cba69a.script_objective = "vtol_ride";
    var_c0cba69a triggerignoreteam();
    self thread function_a68414be(var_c0cba69a, w_hero);
    while (true) {
        e_player = var_c0cba69a waittill(#"trigger");
        if (isalive(e_player)) {
            if (e_player function_60a57ce() && !e_player has_weapon(w_hero)) {
                var_73a38d53 = self getseatoccupant(0);
                if (isdefined(var_73a38d53)) {
                    if (var_73a38d53 == e_player) {
                        self usevehicle(e_player, 0);
                    } else {
                        continue;
                    }
                }
                e_player giveweapon(w_hero);
                e_player switchtoweapon(w_hero);
                level notify(#"hash_7f9d4af6");
                break;
            }
        }
    }
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
    var_c0cba69a delete();
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_a68414be
// Checksum 0x83820ee8, Offset: 0x4e18
// Size: 0x178
function function_a68414be(var_c0cba69a, w_hero) {
    var_c0cba69a endon(#"death");
    while (true) {
        e_player = var_c0cba69a waittill(#"trigger");
        if (!isalive(self)) {
            return;
        }
        var_73a38d53 = self getseatoccupant(0);
        if (isdefined(var_73a38d53) && var_73a38d53 != e_player) {
            continue;
        }
        if (isalive(e_player) && !e_player has_weapon(w_hero)) {
            hint = e_player openluimenu("TurretTakeTutorial");
            while (isdefined(self) && !e_player laststand::player_is_in_laststand() && !e_player function_60a57ce() && e_player istouching(var_c0cba69a)) {
                wait(0.05);
            }
            e_player closeluimenu(hint);
        }
    }
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_60a57ce
// Checksum 0x4dd89839, Offset: 0x4f98
// Size: 0x1a
function function_60a57ce() {
    return self meleebuttonpressed();
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_4e430da2
// Checksum 0x53b5fc46, Offset: 0x4fc0
// Size: 0x1a
function function_4e430da2() {
    return self usebuttonpressed();
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_10c41a9d
// Checksum 0xd60e5180, Offset: 0x4fe8
// Size: 0x5c
function function_10c41a9d() {
    w_hero = getweapon("lmg_light");
    if (self hasweapon(w_hero)) {
        self takeweapon(w_hero);
    }
}

// Namespace namespace_391e4301
// Params 3, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_258b9bad
// Checksum 0x77652d9b, Offset: 0x5050
// Size: 0xce
function function_258b9bad(var_fcc15a0, var_1086d941, var_ed2ece1e) {
    self endon(#"death");
    self.var_69dd5d62 = 1;
    util::magic_bullet_shield(self);
    if (var_1086d941) {
        self thread function_968476a4(var_fcc15a0, var_ed2ece1e);
    }
    util::waittill_any_ents(level, var_fcc15a0, self, var_fcc15a0, self, "ram_kill_mb", self, "ccom_locked_on", self, "cybercom_action");
    util::stop_magic_bullet_shield(self);
    self.var_69dd5d62 = undefined;
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_968476a4
// Checksum 0xe434eb02, Offset: 0x5128
// Size: 0xac
function function_968476a4(var_fcc15a0, var_ed2ece1e) {
    self endon(#"hash_9b484394");
    self endon(var_fcc15a0);
    level endon(var_fcc15a0);
    while (true) {
        amount, attacker = self waittill(#"damage");
        if (isplayer(attacker)) {
            if (isdefined(var_ed2ece1e)) {
                level notify(var_ed2ece1e);
                wait(0.05);
                level notify(var_fcc15a0);
            }
            self notify(var_fcc15a0);
        }
    }
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_f08afb37
// Checksum 0xe23c262, Offset: 0x51e0
// Size: 0xda
function function_f08afb37(b_on, var_eebad467) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (!isdefined(var_eebad467)) {
        var_eebad467 = 0.1;
    }
    self endon(#"death");
    if (isalive(self) && issentient(self)) {
        if (b_on) {
            self.attackeraccuracy = var_eebad467;
            self.overrideactordamage = &function_74e97bfe;
            self notify(#"hash_4ef4ba2d");
            return;
        }
        self.attackeraccuracy = var_eebad467;
        self.overrideactordamage = undefined;
        self notify(#"hash_cb188399");
    }
}

// Namespace namespace_391e4301
// Params 12, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_74e97bfe
// Checksum 0x65252b9b, Offset: 0x52c8
// Size: 0x10e
function function_74e97bfe(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, var_269779a, psoffsettime, var_fe8d5ebb) {
    if (isplayer(e_attacker)) {
        function_f08afb37(0);
        return n_damage;
    }
    if (str_means_of_death == "MOD_EXPLOSIVE" || str_means_of_death == "MOD_GRENADE" || str_means_of_death == "MOD_MELEE" || str_means_of_death == "MOD_MELEE_WEAPON_BUTT") {
        return n_damage;
    }
    n_damage = 1;
    self.health += 1;
    return n_damage;
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_8afb19cc
// Checksum 0xafdc88e1, Offset: 0x53e0
// Size: 0x54
function function_8afb19cc(var_786e88b6, var_f10f51ff) {
    level thread function_19e59ba2(var_786e88b6, var_f10f51ff);
    level thread function_fa89cc92(var_786e88b6, var_f10f51ff);
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_19e59ba2
// Checksum 0xe59e34b0, Offset: 0x5440
// Size: 0x132
function function_19e59ba2(var_786e88b6, var_f10f51ff) {
    do {
        wait(0.5);
        var_46c58ac8 = spawn_manager::function_423eae50(var_f10f51ff);
    } while (var_46c58ac8.size > 0 || spawn_manager::is_enabled(var_f10f51ff));
    var_18c1d967 = spawn_manager::function_423eae50(var_786e88b6);
    foreach (var_6104a93b in var_18c1d967) {
        var_6104a93b cleargoalvolume();
        var_6104a93b ai::set_behavior_attribute("move_mode", "rusher");
    }
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_fa89cc92
// Checksum 0x962d8e82, Offset: 0x5580
// Size: 0x10a
function function_fa89cc92(var_786e88b6, var_f10f51ff) {
    do {
        wait(0.5);
        var_18c1d967 = spawn_manager::function_423eae50(var_786e88b6);
    } while (var_18c1d967.size > 0 || spawn_manager::is_enabled(var_786e88b6));
    var_46c58ac8 = spawn_manager::function_423eae50(var_f10f51ff);
    foreach (var_fbc8888 in var_46c58ac8) {
        var_fbc8888.goalradius = 1024;
    }
}

// Namespace namespace_391e4301
// Params 7, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_24b86d60
// Checksum 0x89516abb, Offset: 0x5698
// Size: 0x9dc
function function_24b86d60(var_74b98fad, str_endon, n_dist_min, n_dist_max, var_cf8b7bc3, var_5276bdcd, var_d04843e1) {
    if (!isdefined(var_cf8b7bc3)) {
        var_cf8b7bc3 = 0;
    }
    if (!isdefined(var_5276bdcd)) {
        var_5276bdcd = 1;
    }
    if (!isdefined(var_d04843e1)) {
        var_d04843e1 = 20;
    }
    assert(isplayer(self), "is_demo_build");
    assert(isdefined(var_74b98fad), "is_demo_build");
    assert(isdefined(n_dist_min), "is_demo_build");
    assert(isdefined(n_dist_max), "is_demo_build");
    self endon(str_endon);
    self endon(#"death");
    self endon(#"disconnect");
    self thread function_1fc93399(str_endon);
    if (!isarray(var_74b98fad)) {
        var_2328c0bb = array(var_74b98fad);
    } else {
        var_2328c0bb = var_74b98fad;
    }
    var_6987b601 = function_36bdd3e9(var_2328c0bb);
    n_prev_speed = 1;
    var_187c2c0a = 1;
    n_height_diff = 0;
    var_6996430b = math::linear_map(var_d04843e1, 0, -66, 0, 1);
    var_c0a77ece = distance2d(self.origin, function_36bdd3e9(var_2328c0bb));
    var_42d1f660 = 1;
    var_d1c1929b = 0;
    var_3e7026da = 0;
    var_b054adb3 = 0;
    var_857f3b54 = 0;
    var_36d81334 = 0;
    if (isdefined(self.var_1e462286)) {
        var_42d1f660 = 0;
        n_prev_speed = self.var_1e462286;
        self setmovespeedscale(self.var_1e462286);
    }
    if (isdefined(self.var_622d06be)) {
        n_height_diff = self.var_622d06be;
    }
    while (true) {
        var_856fe6c6 = function_36bdd3e9(var_2328c0bb);
        var_e730dd94 = distance(var_6987b601, var_856fe6c6);
        var_6987b601 = var_856fe6c6;
        var_8b261109 = var_e730dd94 * 20;
        if (var_2328c0bb.size > 1) {
            var_8aab3fca = arraycopy(var_2328c0bb);
            arrayremoveindex(var_8aab3fca, 0, 0);
            var_5db32273 = var_2328c0bb[0].origin - function_36bdd3e9(var_8aab3fca);
        } else {
            var_5db32273 = anglestoforward((0, var_2328c0bb[0].angles[1], 0));
        }
        v_player_forward = anglestoforward(self.angles);
        var_b054adb3 = var_3e7026da;
        var_3e7026da = 0;
        foreach (entity in var_2328c0bb) {
            var_e71cd44d = distance2d(self.origin, entity.origin);
            var_671d9784 = vectordot(vectornormalize(var_5db32273), vectornormalize(self.origin - entity.origin));
            if (var_e71cd44d <= 24 && var_671d9784 <= -0.25) {
                var_3e7026da = 1;
                continue;
            }
            if (var_e71cd44d <= 32 && var_671d9784 <= -0.5) {
                var_3e7026da = 1;
                continue;
            }
            if (var_e71cd44d <= 40 && var_671d9784 <= -0.75) {
                var_3e7026da = 1;
            }
        }
        if (n_prev_speed <= var_6996430b && !var_3e7026da) {
            var_857f3b54++;
            if (var_857f3b54 > 10) {
                var_36d81334 = 1;
            }
        } else {
            var_857f3b54 = 0;
        }
        var_8c034a31 = distance2d(self.origin, var_856fe6c6);
        if (!var_36d81334 && abs(var_8c034a31 - var_c0a77ece) < 12 && !(var_3e7026da || var_b054adb3)) {
            wait(0.05);
            continue;
        }
        var_c0a77ece = var_8c034a31;
        var_16d9beb6 = vectordot(vectornormalize(var_5db32273), self.origin - var_2328c0bb[0].origin);
        if (var_16d9beb6 <= 0) {
            var_d3fe8f49 = math::linear_map(var_8b261109, var_d04843e1, -66, 0, 1);
            n_height_diff = abs(var_856fe6c6[2] - self.origin[2]);
            self.var_622d06be = n_height_diff;
            if (var_8c034a31 > n_dist_max || n_height_diff > -96) {
                var_187c2c0a = 1;
            } else if (var_8c034a31 <= n_dist_min) {
                var_187c2c0a = var_d3fe8f49;
            } else {
                var_38d4ae07 = math::linear_map(var_8c034a31, n_dist_min, n_dist_max, 0.5, 1);
                var_187c2c0a = var_38d4ae07;
            }
            if (var_187c2c0a < var_6996430b) {
                var_187c2c0a = var_6996430b;
            }
            if (var_3e7026da) {
                var_d1c1929b++;
                var_187c2c0a = var_6996430b - 0.05 * var_d1c1929b;
                if (var_187c2c0a < 0.05) {
                    var_187c2c0a = 0.05;
                }
            } else if (var_d1c1929b > 0) {
                var_d1c1929b = 0;
            }
        } else if (n_height_diff <= -96) {
            var_187c2c0a = var_6996430b;
        }
        if (!var_42d1f660) {
            if (abs(var_187c2c0a - n_prev_speed) < 0.1) {
                var_187c2c0a = n_prev_speed;
            } else if (n_prev_speed > var_187c2c0a + 0.1) {
                var_187c2c0a = n_prev_speed - 0.1;
            } else if (n_prev_speed < var_187c2c0a - 0.1 && n_height_diff <= 100) {
                var_187c2c0a = n_prev_speed + 0.1;
            }
        }
        var_36d81334 = 0;
        var_42d1f660 = 0;
        n_prev_speed = var_187c2c0a;
        self setmovespeedscale(var_187c2c0a);
        self.var_1e462286 = var_187c2c0a;
        wait(0.05);
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_36bdd3e9
// Checksum 0x966b2d30, Offset: 0x6080
// Size: 0xb0
function function_36bdd3e9(a_ents) {
    var_4ce0e4b7 = (0, 0, 0);
    foreach (ent in a_ents) {
        var_4ce0e4b7 += ent.origin;
    }
    return var_4ce0e4b7 / a_ents.size;
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_1fc93399
// Checksum 0xb48b0500, Offset: 0x6138
// Size: 0x78
function function_1fc93399(str_endon) {
    b_reset = level waittill(str_endon);
    if (!isdefined(b_reset)) {
        b_reset = 1;
    }
    if (isdefined(b_reset) && b_reset) {
        self setmovespeedscale(1);
        self.var_1e462286 = 1;
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_47e62fcf
// Checksum 0x129ca8ae, Offset: 0x61b8
// Size: 0x124
function function_47e62fcf(a_ents) {
    n_hint_time = 5;
    foreach (ent in a_ents) {
        if (isdefined(ent.model)) {
            streamermodelhint(ent.model, n_hint_time);
        }
    }
    if (isdefined(self.scenes[0]._s.nextscenebundle)) {
        scene::add_scene_func(self.scenes[0]._s.nextscenebundle, &function_47e62fcf, "play");
    }
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x0
// namespace_391e4301<file_0>::function_a9b807cc
// Checksum 0xd5b98472, Offset: 0x62e8
// Size: 0x3c
function function_a9b807cc(n_hint_time) {
    if (!isdefined(n_hint_time)) {
        n_hint_time = 5;
    }
    streamermodelhint("c_hro_player_male_egypt_viewbody", n_hint_time);
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_ac2b4535
// Checksum 0xd5983588, Offset: 0x6330
// Size: 0xac
function function_ac2b4535(str_scene, str_teleport_name) {
    assert(isdefined(str_scene), "is_demo_build");
    assert(isdefined(str_teleport_name), "is_demo_build");
    scene::add_scene_func(str_scene, &function_96861272, "players_done");
    level thread function_cb1e4146(str_scene, str_teleport_name);
}

// Namespace namespace_391e4301
// Params 1, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_96861272
// Checksum 0x7fb7914d, Offset: 0x63e8
// Size: 0x78
function function_96861272(a_ents) {
    if (isdefined(self.scenes[0]) && isdefined(self.scenes[0]._str_notify_name)) {
        level notify(self.scenes[0]._str_notify_name + "_level_done");
        return;
    }
    level notify(self.scriptbundlename + "_level_done");
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_cb1e4146
// Checksum 0x44823b0c, Offset: 0x6468
// Size: 0x152
function function_cb1e4146(str_scene, str_teleport_name) {
    level waittill(str_scene + "_level_done");
    foreach (player in level.players) {
        player ghost();
    }
    util::function_93831e79(str_teleport_name);
    wait(0.5);
    foreach (player in level.players) {
        player show();
    }
}

// Namespace namespace_391e4301
// Params 2, eflags: 0x1 linked
// namespace_391e4301<file_0>::function_7255e66
// Checksum 0x6c62373e, Offset: 0x65c8
// Size: 0x1a2
function function_7255e66(b_enable, var_ca894d1c) {
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    var_335c4513 = getentarray("mobile_armory", "script_noteworthy");
    foreach (var_a9960583 in var_335c4513) {
        if (var_a9960583.script_string === var_ca894d1c || isdefined(var_a9960583.gameobject) && !isdefined(var_ca894d1c)) {
            if (!b_enable) {
                var_a9960583 oed::disable_thermal();
                var_a9960583 oed::function_14ec2d71();
                var_a9960583.gameobject gameobjects::disable_object();
                continue;
            }
            var_a9960583.gameobject gameobjects::enable_object();
            var_a9960583 oed::enable_thermal();
            var_a9960583 oed::function_e228c18a();
        }
    }
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_f2f98cfc
// Checksum 0x525fc699, Offset: 0x6778
// Size: 0x7c
function function_f2f98cfc() {
    var_3354e659 = getent("hotel_gate", "targetname");
    var_3354e659 ghost();
    var_3354e659 notsolid();
    umbragate_set("hotel", 1);
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_1aeb2873
// Checksum 0xd032cb28, Offset: 0x6800
// Size: 0x54
function function_1aeb2873() {
    getent("defend_street_gate", "targetname") delete();
    umbragate_set("defend_street", 1);
}

// Namespace namespace_391e4301
// Params 0, eflags: 0x0
// namespace_391e4301<file_0>::function_fb967724
// Checksum 0xb9ac6dbb, Offset: 0x6860
// Size: 0x4c
function function_fb967724() {
    getent("hotel_gate", "targetname") show();
    umbragate_set("hotel", 0);
}

