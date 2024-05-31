#using scripts/zm/_zm_ai_thrasher;
#using scripts/zm/_zm_ai_spiders;
#using scripts/zm/zm_island_ww_quest;
#using scripts/zm/zm_island_vo;
#using scripts/zm/zm_island_util;
#using scripts/zm/zm_island_perks;
#using scripts/zm/zm_island_planting;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_util;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_f3e3de78;

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xca14dbac, Offset: 0xb58
// Size: 0x11c
function main() {
    wait(0.05);
    level thread function_d17ab8c6();
    level thread function_fbe51672();
    level thread function_d806d0f9();
    level thread function_46ffc7b4();
    level thread function_801ffa37();
    level thread function_ae1e48b4();
    callback::on_spawned(&function_45585311);
    level thread function_662fba30();
    level thread function_c5751341();
    /#
        level thread function_83ead54e();
    #/
    /#
        level thread function_5b3bc8();
    #/
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x87912dd7, Offset: 0xc80
// Size: 0x180
function function_d17ab8c6() {
    level endon(#"hash_b4db6fbb");
    level flag::init("power_on" + 3);
    level thread function_9e6292be();
    level thread function_bbe228f8();
    level scene::init("p7_fxanim_zm_island_bunker_door_main_bundle");
    while (true) {
        level util::waittill_any("power_on" + 1, "power_on" + 2);
        if (flag::get("power_on" + 1) && flag::get("power_on" + 2)) {
            level zm_power::turn_power_on_and_open_doors(3);
            level thread namespace_f333593c::function_3bf2d62a("both_power_on", 1, 1, 1);
            level util::delay_notify(0.25, "override_bunker_door_string");
            continue;
        }
        level zm_power::turn_power_off_and_close_doors(3);
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xc4557f53, Offset: 0xe08
// Size: 0x90
function function_bbe228f8() {
    level endon(#"hash_b4db6fbb");
    zm_utility::add_zombie_hint("bunker_door_text", %ZM_ISLAND_BUNKER_DOOR_OPEN);
    var_25d5f24c = getent("door_bunker_main", "target");
    while (true) {
        level waittill(#"hash_c532b07e");
        var_25d5f24c zm_utility::set_hint_string(var_25d5f24c, "bunker_door_text");
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x9fbb17e1, Offset: 0xea0
// Size: 0x34
function function_9e6292be() {
    level flag::wait_till("connect_bunker_exterior_to_bunker_interior");
    function_5144d0ee();
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xd54c5dc3, Offset: 0xee0
// Size: 0x274
function function_fbe51672() {
    level flag::init("power_on" + 4);
    var_2a07ad9e = getent("bunker_cypher_screen", "targetname");
    var_2a07ad9e hide();
    var_3968d838 = getent("bunker_cypher_screen_4codes", "targetname");
    var_3968d838 hide();
    level flag::wait_till("power_on" + 4);
    foreach (var_ac878678 in level.var_769c0729) {
        var_ac878678 hide();
    }
    playsoundatposition("zmb_island_main_power_on", (0, 0, 0));
    level clientfield::set("power_switch_" + 1 + "_fx", 0);
    level clientfield::set("power_switch_" + 2 + "_fx", 0);
    exploder::exploder("ex_power_bdoor_left");
    exploder::exploder("ex_power_bdoor_right");
    function_2b5b24e9();
    level flag::set("power_on");
    exploder::exploder("fxexp_200");
    exploder::exploder("global_power");
    var_2a07ad9e show();
    var_3968d838 show();
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xe60549ff, Offset: 0x1160
// Size: 0x1d8
function function_d806d0f9() {
    var_84f67a50 = [];
    var_84f67a50[0] = "power_on" + 1;
    var_84f67a50[1] = "power_on";
    while (true) {
        level flag::wait_till_any(var_84f67a50);
        exploder::exploder("temporary_power_jungle_lab");
        exploder::exploder("fxexp_211");
        exploder::exploder("ex_prop_switch");
        level.var_1dbad94a = 1;
        namespace_eaae7728::function_23d17338(level.var_1dbad94a);
        level thread namespace_f333593c::function_3bf2d62a("local_power_on", 1, 0, 0);
        if (level flag::get("power_on")) {
            break;
        }
        level flag::wait_till_clear("power_on" + 1);
        if (level flag::get("power_on")) {
            break;
        }
        exploder::stop_exploder("temporary_power_jungle_lab");
        exploder::stop_exploder("fxexp_211");
        exploder::stop_exploder("ex_prop_switch");
        level.var_1dbad94a = 0;
        namespace_eaae7728::function_23d17338(level.var_1dbad94a);
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xb08e3a53, Offset: 0x1340
// Size: 0x1a8
function function_46ffc7b4() {
    var_84f67a50 = [];
    var_84f67a50[0] = "power_on" + 2;
    var_84f67a50[1] = "power_on";
    while (true) {
        level flag::wait_till_any(var_84f67a50);
        exploder::exploder("temporary_power_swamp_lab");
        exploder::exploder("fxexp_210");
        level.var_2e16e689 = 1;
        namespace_eaae7728::function_1dc42fdf(level.var_2e16e689);
        level thread namespace_f333593c::function_3bf2d62a("local_power_on", 0, 0, 1);
        if (level flag::get("power_on")) {
            break;
        }
        level flag::wait_till_clear("power_on" + 2);
        if (level flag::get("power_on")) {
            break;
        }
        exploder::stop_exploder("temporary_power_swamp_lab");
        exploder::stop_exploder("fxexp_210");
        level.var_2e16e689 = 0;
        namespace_eaae7728::function_1dc42fdf(level.var_2e16e689);
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xef5ff361, Offset: 0x14f0
// Size: 0x254
function function_801ffa37() {
    var_ac878678 = getent("use_elec_switch_deferred", "targetname");
    var_ac878678 sethintstring(%ZM_ISLAND_PENSTOCK_DEBRIS);
    var_ac878678 setvisibletoall();
    var_ac878678 setcursorhint("HINT_NOICON");
    level flag::init(var_ac878678.script_string);
    level clientfield::set("penstock_fx_anim", 1);
    function_e9f46546();
    exploder::exploder("fxexp_303");
    println("connect_bunker_exterior_to_bunker_interior");
    level flag::set(var_ac878678.script_string);
    level flag::wait_till("defend_over");
    var_ac878678 thread zm_power::electric_switch();
    exploder::exploder("lgt_penstock");
    level clientfield::set("penstock_fx_anim", 0);
    user = var_ac878678 waittill(#"trigger");
    level thread scene::play("p7_fxanim_zm_power_switch_bundle");
    user zm_audio::create_and_play_dialog("general", "power_on");
    level thread namespace_f333593c::function_3bf2d62a("main_power_on", 1, 1, 1);
    exploder::exploder("ex_prop_switch");
    exploder::exploder("ex_fan_switch");
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xe0e3b1aa, Offset: 0x1750
// Size: 0x1e4
function function_e9f46546() {
    while (!isdefined(level.var_d3b40681)) {
        wait(1);
    }
    var_e08b3d94 = getent("penstock_web_trigger", "targetname");
    var_e08b3d94 namespace_27f8b154::function_7428955c();
    if (!isdefined(level.var_d3b40681)) {
        level.var_d3b40681 = [];
    } else if (!isarray(level.var_d3b40681)) {
        level.var_d3b40681 = array(level.var_d3b40681);
    }
    level.var_d3b40681[level.var_d3b40681.size] = var_e08b3d94;
    var_e08b3d94 namespace_27f8b154::function_f375c6d9(1, 1);
    var_e08b3d94.var_e084d7bd = 1;
    var_e08b3d94 waittill(#"hash_bbf62f57");
    level util::clientnotify("snd_valve");
    level thread namespace_f333593c::function_3bf2d62a("unblock_penstock", 0, 1, 0);
    var_e08b3d94 namespace_27f8b154::function_f375c6d9(0);
    arrayremovevalue(level.var_d3b40681, var_e08b3d94);
    var_e08b3d94.var_1e831600 util::delay(5, undefined, &delete);
    var_e08b3d94 util::delay(6, undefined, &delete);
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xdd6ddff0, Offset: 0x1940
// Size: 0x6c
function function_ae1e48b4() {
    level.var_769c0729 = getentarray("temporary_power_switch", "script_string");
    level clientfield::set("power_switch_1_fx", 1);
    level clientfield::set("power_switch_2_fx", 1);
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x8cb221a5, Offset: 0x19b8
// Size: 0x876
function function_156f973e() {
    if (!isdefined(self)) {
        return;
    }
    if (self.script_string === "temporary_power_switch") {
        self sethintstring(%ZM_ISLAND_POWER_SWITCH_NEEEDS_WATER);
    }
    if (isdefined(self.target)) {
        ent_parts = getentarray(self.target, "targetname");
        struct_parts = struct::get_array(self.target, "targetname");
        foreach (ent in ent_parts) {
            if (isdefined(ent.script_noteworthy) && ent.script_noteworthy == "elec_switch") {
                master_switch = ent;
                master_switch notsolid();
            }
        }
        foreach (struct in struct_parts) {
            if (struct.script_noteworthy === "elec_switch_fx") {
                fx_pos = struct;
            }
        }
    }
    if (isdefined(self.script_int)) {
        if (self.script_int == 1) {
            var_b46e7d63 = struct::get("jungle_lab_power_plant", "targetname");
            var_b46e7d63.str_exploder = "fxexp_213";
            var_b46e7d63 scene::init();
        } else if (self.script_int == 2) {
            var_b46e7d63 = struct::get("swamp_lab_power_plant", "targetname");
            var_b46e7d63.str_exploder = "fxexp_212";
            var_b46e7d63 scene::init();
        }
    }
    while (isdefined(self)) {
        self setvisibletoall();
        self setcursorhint("HINT_NOICON");
        user = self waittill(#"trigger");
        if (isdefined(user.var_6fd3d65c) && user.var_6fd3d65c && user.var_bb2fd41c === 3) {
            user thread function_a84a1aec(undefined, 1);
        } else {
            continue;
        }
        user thread namespace_f333593c::function_c8bcaf11();
        var_b46e7d63 thread scene::play("p7_fxanim_zm_island_power_plant_on_bundle", var_b46e7d63.var_8c4b44d4);
        self thread function_e2e52f31();
        self setinvisibletoall();
        if (isdefined(master_switch)) {
            master_switch rotateroll(-90, 0.3);
            master_switch playsound("zmb_switch_flip");
        }
        power_zone = undefined;
        if (isdefined(self.script_int)) {
            power_zone = self.script_int;
        }
        var_b46e7d63 waittill(#"hash_26b8743e");
        level zm_power::turn_power_on_and_open_doors(power_zone);
        if (!isdefined(self.script_noteworthy) || self.script_noteworthy != "allow_power_off") {
            self delete();
            return;
        }
        if (isdefined(level.var_7b5a9e65) && level.var_7b5a9e65 > 0) {
            level clientfield::set("power_switch_" + self.script_int + "_fx", 0);
            if (self.script_int == 1) {
                exploder::exploder("ex_power_bdoor_left");
                self thread function_7963db9c((-5, 1869, -219));
            } else if (self.script_int == 2) {
                exploder::exploder("ex_power_bdoor_right");
                self thread function_7963db9c((331, 1859, -235));
            }
            self setinvisibletoall();
            if (level.activeplayers.size <= 1) {
                wait(level.var_7b5a9e65 * 2);
            } else {
                wait(level.var_7b5a9e65);
            }
            if (level flag::get("power_on")) {
                self delete();
                return;
            } else {
                level notify(#"hash_94e4da4f");
            }
            self playsound("zmb_temp_power_alert");
            level clientfield::set("power_switch_" + self.script_int + "_fx", 1);
            var_b46e7d63.var_5260546a clientfield::set("power_plant_glow", 0);
            var_b46e7d63 thread scene::play("p7_fxanim_zm_island_power_plant_off_bundle", var_b46e7d63.var_969af1da);
            if (self.script_int == 1) {
                exploder::exploder_stop("ex_power_bdoor_left");
                level thread namespace_f333593c::function_3bf2d62a("local_power_off", 1, 0, 0);
            } else if (self.script_int == 2) {
                exploder::exploder_stop("ex_power_bdoor_right");
                level thread namespace_f333593c::function_3bf2d62a("local_power_off", 0, 0, 1);
            }
        } else {
            self sethintstring(%ZOMBIE_ELECTRIC_SWITCH_OFF);
            self setvisibletoall();
            user = self waittill(#"trigger");
            self setinvisibletoall();
        }
        if (isdefined(master_switch)) {
            master_switch rotateroll(90, 0.3);
        }
        if (isdefined(master_switch)) {
            master_switch waittill(#"rotatedone");
        }
        level zm_power::turn_power_off_and_close_doors(power_zone);
        self notify(#"hash_42c31433");
    }
}

// Namespace namespace_f3e3de78
// Params 1, eflags: 0x1 linked
// Checksum 0xd6629b7d, Offset: 0x2238
// Size: 0x40
function function_f0a1682d(a_ents) {
    self.var_969af1da = a_ents["power_plant_dials"];
    self.var_5260546a = a_ents["power_plant"];
    self.var_8c4b44d4 = a_ents;
}

// Namespace namespace_f3e3de78
// Params 1, eflags: 0x1 linked
// Checksum 0x327ec5f5, Offset: 0x2280
// Size: 0xa4
function function_c1edfb09(a_ents) {
    a_ents["power_plant_water"] waittill(#"hash_2acd8021");
    exploder::exploder(self.str_exploder);
    self thread function_b3c3fdca();
    a_ents["power_plant"] clientfield::set("power_plant_glow", 1);
    wait(4);
    exploder::exploder_stop(self.str_exploder);
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x52b58850, Offset: 0x2330
// Size: 0x1a
function function_b3c3fdca() {
    wait(2);
    self notify(#"hash_26b8743e");
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xfaefe4cc, Offset: 0x2358
// Size: 0xbc
function function_e2e52f31() {
    var_e2e52f31 = spawn("script_origin", self.origin);
    var_e2e52f31 playloopsound("zmb_temp_power_loop", 1.5);
    self waittill(#"hash_42c31433");
    self playsoundwithnotify("zmb_temp_power_off", "sounddone");
    var_e2e52f31 stoploopsound(2);
    self waittill(#"sounddone");
    var_e2e52f31 delete();
}

// Namespace namespace_f3e3de78
// Params 1, eflags: 0x1 linked
// Checksum 0xd662bdef, Offset: 0x2420
// Size: 0xf4
function function_7963db9c(var_fb491867) {
    var_6575d157 = spawn("script_origin", var_fb491867);
    var_6575d157 playloopsound("amb_mini_generator", 1.5);
    var_6575d157 playsound("amb_gen_start");
    self waittill(#"hash_42c31433");
    var_6575d157 stoploopsound(2);
    var_6575d157 playsoundwithnotify("amb_gen_stop", "snd_done");
    var_6575d157 waittill(#"hash_f7dd334d");
    var_6575d157 delete();
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xee3cbb7c, Offset: 0x2520
// Size: 0x202
function function_53f26a4c() {
    if (!isdefined(self.var_bb2fd41c)) {
        return;
    }
    if (self.var_bb2fd41c === 3) {
        foreach (var_5972e249 in level.var_769c0729) {
            if (isdefined(var_5972e249)) {
                var_5972e249 sethintstringforplayer(self, %ZOMBIE_ELECTRIC_SWITCH);
            }
        }
        return;
    }
    if (self.var_bb2fd41c > 0) {
        foreach (var_5972e249 in level.var_769c0729) {
            if (isdefined(var_5972e249)) {
                var_5972e249 sethintstringforplayer(self, %ZM_ISLAND_POWER_SWITCH_NEEEDS_MORE_WATER);
            }
        }
        return;
    }
    foreach (var_5972e249 in level.var_769c0729) {
        if (isdefined(var_5972e249)) {
            var_5972e249 sethintstringforplayer(self, %ZM_ISLAND_POWER_SWITCH_NEEEDS_WATER);
        }
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x743936c2, Offset: 0x2730
// Size: 0xb4
function function_2b5b24e9() {
    var_849a6e56 = struct::get("swamp_lab_power_plant", "targetname");
    if (!var_849a6e56 scene::is_active()) {
        var_849a6e56 thread scene::play();
    }
    var_474567d = struct::get("jungle_lab_power_plant", "targetname");
    if (!var_474567d scene::is_active()) {
        var_474567d thread scene::play();
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xfb412d54, Offset: 0x27f0
// Size: 0x184
function function_5144d0ee() {
    var_e43d9cdb = struct::get_array("bunker_door_open_spawners", "targetname");
    var_e43d9cdb = array::randomize(var_e43d9cdb);
    var_7809d454 = [];
    for (i = 0; i < var_e43d9cdb.size; i++) {
        while (getfreeactorcount() < 1) {
            wait(0.05);
        }
        s_loc = var_e43d9cdb[i];
        ai_zombie = zombie_utility::spawn_zombie(level.zombie_spawners[0], "bunker_entrance_zombie", s_loc);
        if (!isdefined(var_7809d454)) {
            var_7809d454 = [];
        } else if (!isarray(var_7809d454)) {
            var_7809d454 = array(var_7809d454);
        }
        var_7809d454[var_7809d454.size] = ai_zombie;
        wait(0.25);
    }
    level thread function_5c09306d(var_7809d454);
    function_3d11144a();
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x6c07e849, Offset: 0x2980
// Size: 0x1b4
function function_3d11144a() {
    level thread util::delayed_notify("spawn_bunker_thrasher", 2.5);
    var_1e9b1719 = getent("fxanim_bunker_door_main", "targetname");
    var_c0abb8f1 = getent("bunker_door_clip_left", "targetname");
    var_c0abb8f1 linkto(var_1e9b1719, "door_lft_jnt");
    level thread namespace_f333593c::function_3bf2d62a("bunker_open", 1, 1, 1);
    var_83cb019c = getent("bunker_door_clip_right", "targetname");
    var_83cb019c linkto(var_1e9b1719, "door_rt_jnt");
    e_closest_player = arraygetclosest(var_c0abb8f1.origin, level.activeplayers);
    e_closest_player notify(#"hash_ebf01fa");
    level scene::play("p7_fxanim_zm_island_bunker_door_main_bundle");
    var_c0abb8f1 delete();
    var_83cb019c delete();
}

// Namespace namespace_f3e3de78
// Params 1, eflags: 0x1 linked
// Checksum 0xf2939284, Offset: 0x2b40
// Size: 0x144
function function_5c09306d(a_ai_zombies) {
    foreach (ai_zombie in a_ai_zombies) {
        ai_zombie.var_cbbe29a9 = 1;
    }
    if (level flag::get("power_on" + 4)) {
        return;
    }
    level waittill(#"hash_5ed58d2");
    var_4703465a = struct::get("spore_bunker_guarantee_convert", "targetname");
    var_75e02ae0 = arraygetclosest(var_4703465a.origin, a_ai_zombies);
    var_75e02ae0.var_cbbe29a9 = 0;
    namespace_756d2c3d::function_8b323113(var_75e02ae0, 0, 0);
}

/#

    // Namespace namespace_f3e3de78
    // Params 0, eflags: 0x1 linked
    // Checksum 0x38b98168, Offset: 0x2c90
    // Size: 0x9c
    function function_83ead54e() {
        level waittill(#"open_sesame");
        level.var_1dbad94a = 1;
        namespace_eaae7728::function_23d17338(level.var_1dbad94a);
        level.var_2e16e689 = 1;
        namespace_eaae7728::function_1dc42fdf(level.var_2e16e689);
        level thread function_21e3b61f();
        level flag::set("connect_bunker_exterior_to_bunker_interior" + 4);
    }

    // Namespace namespace_f3e3de78
    // Params 0, eflags: 0x1 linked
    // Checksum 0xace18fe, Offset: 0x2d38
    // Size: 0x9c
    function function_21e3b61f() {
        level clientfield::set("connect_bunker_exterior_to_bunker_interior", 1);
        wait(3);
        level clientfield::set("connect_bunker_exterior_to_bunker_interior", 2);
        wait(3);
        level clientfield::set("connect_bunker_exterior_to_bunker_interior", 3);
        level flag::set("connect_bunker_exterior_to_bunker_interior");
    }

#/

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x4ae211b2, Offset: 0x2de0
// Size: 0xc4
function function_45585311() {
    if (isdefined(self.var_6fd3d65c) && self.var_6fd3d65c) {
        self clientfield::set_to_player("bucket_held", 1);
        if (!(isdefined(self.var_b6a244f9) && self.var_b6a244f9)) {
            self.var_bb2fd41c = 0;
            self.var_c6cad973 = 0;
        } else {
            self clientfield::set_to_player("bucket_held", 2);
        }
        self function_ef097ea(self.var_c6cad973, self.var_bb2fd41c, self function_89538fbb(), 0);
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x16f29a43, Offset: 0x2eb0
// Size: 0x156
function function_662fba30() {
    level flag::init("any_player_has_bucket");
    var_c66f413a = struct::get_array("water_bucket_location", "targetname");
    for (i = 1; i < 5; i++) {
        var_e4660bfb = [];
        foreach (var_991ffe1 in var_c66f413a) {
            if (var_991ffe1.script_int === i) {
                var_e4660bfb[var_e4660bfb.size] = var_991ffe1;
            }
        }
        var_623d6569 = array::random(var_e4660bfb);
        var_623d6569 thread function_75656c0a();
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x5 linked
// Checksum 0x1d584149, Offset: 0x3010
// Size: 0x2f8
function private function_75656c0a() {
    while (true) {
        self.model = util::spawn_model("p7_zm_isl_bucket_115", self.origin, self.angles);
        self.trigger = namespace_8aed53c9::function_d095318(self.origin, 50, 1, &function_16434440);
        self.model clientfield::set("bucket_fx", 1);
        while (!isdefined(self.trigger)) {
            wait(0.05);
        }
        while (true) {
            e_who = self.trigger waittill(#"trigger");
            if (e_who clientfield::get_to_player("bucket_held")) {
                continue;
            }
            e_who thread zm_audio::create_and_play_dialog("bucket", "pickup");
            e_who clientfield::set_to_player("bucket_held", 1);
            e_who.var_6fd3d65c = 1;
            e_who playsound("zmb_bucket_pickup");
            if (self.script_int === 1) {
                e_who.var_bb2fd41c = 1;
                e_who.var_c6cad973 = randomintrange(1, 4);
                println("connect_bunker_exterior_to_bunker_interior" + e_who.var_c6cad973);
            } else {
                e_who.var_bb2fd41c = 0;
                e_who.var_c6cad973 = 0;
            }
            e_who thread function_ef097ea(e_who.var_c6cad973, e_who.var_bb2fd41c, e_who function_89538fbb(), 1);
            self.model clientfield::set("bucket_fx", 0);
            self.model delete();
            zm_unitrigger::unregister_unitrigger(self.trigger);
            self.trigger = undefined;
            level flag::set("any_player_has_bucket");
            break;
        }
        e_who util::waittill_any("clone_plant_bucket_lost", "disconnect");
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x41edfb9d, Offset: 0x3310
// Size: 0x7c
function function_4b057b64() {
    self endon(#"disconnect");
    self clientfield::set_to_player("bucket_held", 0);
    self.var_6fd3d65c = 0;
    self.var_bb2fd41c = 0;
    self.var_c6cad973 = 0;
    self function_ef097ea(self.var_c6cad973, self.var_bb2fd41c, 0, 0);
}

// Namespace namespace_f3e3de78
// Params 1, eflags: 0x5 linked
// Checksum 0x344bb8a9, Offset: 0x3398
// Size: 0x44
function private function_16434440(e_player) {
    if (e_player clientfield::get_to_player("bucket_held")) {
        return %;
    }
    return %ZM_ISLAND_PICKUP_BUCKET;
}

// Namespace namespace_f3e3de78
// Params 2, eflags: 0x1 linked
// Checksum 0x248a1021, Offset: 0x33e8
// Size: 0x17c
function function_a84a1aec(var_c6cad973, var_350cfc56) {
    if (!self clientfield::get_to_player("bucket_held")) {
        return;
    }
    if (isdefined(var_c6cad973)) {
        self.var_bb2fd41c = 3;
        self playsound("zmb_bucket_water_pickup");
        self.var_c6cad973 = var_c6cad973;
        self thread function_ef097ea(self.var_c6cad973, self.var_bb2fd41c, self function_89538fbb(), 1);
        return;
    }
    if (isdefined(var_350cfc56) && var_350cfc56) {
        self.var_bb2fd41c -= 3;
    } else {
        self.var_bb2fd41c -= 1;
    }
    if (isdefined(self.var_b6a244f9) && self.var_b6a244f9) {
        self.var_bb2fd41c = 3;
    }
    if (self.var_bb2fd41c <= 0) {
        self.var_bb2fd41c = 0;
        self.var_c6cad973 = 0;
    }
    self thread function_ef097ea(self.var_c6cad973, self.var_bb2fd41c, self function_89538fbb(), 1);
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x4c5ffcaf, Offset: 0x3570
// Size: 0x74
function function_89538fbb() {
    if (isdefined(self.var_b6a244f9) && isdefined(self.var_6fd3d65c) && self.var_6fd3d65c && self.var_b6a244f9) {
        return 2;
    } else if (isdefined(self.var_6fd3d65c) && self.var_6fd3d65c && !(isdefined(self.var_b6a244f9) && self.var_b6a244f9)) {
        return 1;
    }
    return 0;
}

// Namespace namespace_f3e3de78
// Params 4, eflags: 0x1 linked
// Checksum 0x430a761a, Offset: 0x35f0
// Size: 0xc4
function function_ef097ea(var_c6cad973, var_44bdb80e, var_3f242b55, var_b89973c8) {
    if (!isdefined(var_c6cad973)) {
        var_c6cad973 = 0;
    }
    if (!isdefined(var_44bdb80e)) {
        var_44bdb80e = 0;
    }
    if (!isdefined(var_3f242b55)) {
        var_3f242b55 = 0;
    }
    if (!isdefined(var_b89973c8)) {
        var_b89973c8 = 0;
    }
    self thread function_3945e60c(var_c6cad973, var_44bdb80e, var_3f242b55, var_b89973c8);
    self thread function_16ae5bf5();
    self thread function_53f26a4c();
}

// Namespace namespace_f3e3de78
// Params 4, eflags: 0x1 linked
// Checksum 0xad6e75b, Offset: 0x36c0
// Size: 0xdc
function function_3945e60c(var_c6cad973, var_44bdb80e, var_3f242b55, var_b89973c8) {
    self clientfield::set_to_player("bucket_held", var_3f242b55);
    self clientfield::set_to_player("bucket_bucket_type", var_3f242b55);
    if (var_c6cad973 > 0) {
        self clientfield::set_to_player("bucket_bucket_water_type", var_c6cad973 - 1);
    }
    self clientfield::set_to_player("bucket_bucket_water_level", var_44bdb80e);
    if (var_b89973c8) {
        self thread namespace_f37770c8::function_97be99b3(undefined, "zmInventory.widget_bucket_parts", 0);
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x7ddb49c1, Offset: 0x37a8
// Size: 0xf4
function function_d570abb() {
    if (!self clientfield::get_to_player("bucket_held")) {
        self clientfield::set_to_player("bucket_held", 1);
        self.var_6fd3d65c = 1;
    }
    if (isdefined(self.var_b6a244f9) && self.var_b6a244f9) {
        self clientfield::set_to_player("bucket_held", 2);
        self.var_bb2fd41c = 3;
        self.var_c6cad973 = 1;
    } else {
        self.var_bb2fd41c = 0;
        self.var_c6cad973 = 0;
    }
    self thread function_ef097ea(self.var_c6cad973, self.var_bb2fd41c, self function_89538fbb(), 1);
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x39e31acb, Offset: 0x38a8
// Size: 0xf4
function function_c5751341() {
    level.var_4a0060c0 = getentarray("water_source", "targetname");
    foreach (var_7e208829 in level.var_4a0060c0) {
        var_7e208829 thread function_3e519f17();
    }
    var_72b16720 = getent("water_source_ee", "targetname");
    var_72b16720 thread function_d99ed9ac();
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x74a23e18, Offset: 0x39a8
// Size: 0x118
function function_3e519f17() {
    self setinvisibletoall();
    self sethintstring(%ZM_ISLAND_FILL_BUCKET);
    self setcursorhint("HINT_NOICON");
    while (true) {
        e_who = self waittill(#"trigger");
        if (!e_who clientfield::get_to_player("bucket_held")) {
            continue;
        }
        e_who thread function_a84a1aec(self.script_int);
        e_who notify(#"hash_f1549b2e");
        /#
            if (isdefined(e_who.playernum)) {
                println("connect_bunker_exterior_to_bunker_interior" + e_who.playernum + "connect_bunker_exterior_to_bunker_interior");
            }
        #/
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xac039a8b, Offset: 0x3ac8
// Size: 0x180
function function_d99ed9ac() {
    self sethintstring(%);
    while (true) {
        e_who = self waittill(#"touch");
        if (isvehicle(e_who)) {
            e_player = e_who.e_parent;
        } else {
            continue;
        }
        if (!e_player clientfield::get_to_player("bucket_held")) {
            continue;
        }
        if (e_player util::use_button_held()) {
            continue;
        }
        if (e_player usebuttonpressed()) {
            e_player.var_7621b9dd = gettime();
            if (isdefined(e_player.var_57db2550) && e_player.var_7621b9dd - e_player.var_57db2550 > -6) {
                e_player thread function_a84a1aec(self.script_int);
                println("connect_bunker_exterior_to_bunker_interior" + e_player.playernum + "connect_bunker_exterior_to_bunker_interior");
            }
        }
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0x9fc03c8f, Offset: 0x3c50
// Size: 0x94
function function_a7a30925() {
    self endon(#"death");
    self endon(#"hash_c40cfd1a");
    var_72b16720 = getent("water_source_ee", "targetname");
    while (true) {
        self util::waittill_use_button_pressed();
        if (!self istouching(var_72b16720)) {
            self.var_57db2550 = gettime();
        }
        wait(0.05);
    }
}

// Namespace namespace_f3e3de78
// Params 0, eflags: 0x1 linked
// Checksum 0xeffee67, Offset: 0x3cf0
// Size: 0x182
function function_16ae5bf5() {
    if (!self clientfield::get_to_player("bucket_held")) {
        foreach (var_7e208829 in level.var_4a0060c0) {
            var_7e208829 setinvisibletoplayer(self);
        }
        return;
    }
    foreach (var_7e208829 in level.var_4a0060c0) {
        if (self.var_bb2fd41c == 3 && self.var_c6cad973 == var_7e208829.script_int) {
            var_7e208829 setinvisibletoplayer(self);
            continue;
        }
        var_7e208829 setvisibletoplayer(self);
    }
}

/#

    // Namespace namespace_f3e3de78
    // Params 0, eflags: 0x1 linked
    // Checksum 0x12899b10, Offset: 0x3e80
    // Size: 0xd4
    function function_5b3bc8() {
        zm_devgui::add_custom_devgui_callback(&function_d8d81d72);
        adddebugcommand("connect_bunker_exterior_to_bunker_interior");
        adddebugcommand("connect_bunker_exterior_to_bunker_interior");
        adddebugcommand("connect_bunker_exterior_to_bunker_interior");
        adddebugcommand("connect_bunker_exterior_to_bunker_interior");
        adddebugcommand("connect_bunker_exterior_to_bunker_interior");
        adddebugcommand("connect_bunker_exterior_to_bunker_interior");
        adddebugcommand("connect_bunker_exterior_to_bunker_interior");
    }

    // Namespace namespace_f3e3de78
    // Params 1, eflags: 0x1 linked
    // Checksum 0x84c71926, Offset: 0x3f60
    // Size: 0x456
    function function_d8d81d72(cmd) {
        switch (cmd) {
        case 8:
            foreach (player in level.players) {
                if (player clientfield::get_to_player("connect_bunker_exterior_to_bunker_interior")) {
                    continue;
                }
                player clientfield::set_to_player("connect_bunker_exterior_to_bunker_interior", 1);
                player.var_6fd3d65c = 1;
                player.var_bb2fd41c = 0;
                player.var_c6cad973 = 0;
                player thread function_ef097ea(player.var_c6cad973, player.var_bb2fd41c, player function_89538fbb(), 1);
            }
            return 1;
        case 8:
            foreach (player in level.players) {
                player thread function_a84a1aec(1);
            }
            return 1;
        case 8:
            foreach (player in level.players) {
                player thread function_a84a1aec(2);
            }
            return 1;
        case 8:
            foreach (player in level.players) {
                player thread function_a84a1aec(3);
            }
            return 1;
        case 8:
            foreach (player in level.players) {
                player thread function_a84a1aec(4);
            }
            return 1;
        case 8:
            foreach (player in level.players) {
                player thread function_a84a1aec(undefined, 1);
            }
            return 1;
        case 8:
            level thread function_1b3134ae();
            return 1;
        }
        return 0;
    }

    // Namespace namespace_f3e3de78
    // Params 0, eflags: 0x1 linked
    // Checksum 0x429c8349, Offset: 0x43c0
    // Size: 0xd2
    function function_1b3134ae() {
        var_5646068 = struct::get_array("connect_bunker_exterior_to_bunker_interior", "connect_bunker_exterior_to_bunker_interior");
        foreach (var_991ffe1 in var_5646068) {
            if (isdefined(var_991ffe1.trigger)) {
                continue;
            }
            var_991ffe1 thread function_75656c0a();
        }
    }

#/
