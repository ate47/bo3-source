#using scripts/zm/zm_castle_zones;
#using scripts/zm/zm_castle_vo;
#using scripts/zm/_zm_weap_gravityspikes;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_dddf9a25;

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_cdc13aec
// Checksum 0x99ec1590, Offset: 0x910
// Size: 0x4
function function_cdc13aec() {
    
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_3ebec56b
// Checksum 0x3eb2ba9b, Offset: 0x920
// Size: 0x364
function function_3ebec56b() {
    level.var_29ae0891 = 0;
    var_2a7833c8 = getnumexpectedplayers() == 1;
    var_9967ff1 = "gravityspike";
    var_2f18d6d0 = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "part_body", 32, 64, 0, undefined, &function_c1e52ea6, undefined, undefined, undefined, undefined, undefined, "gravityspike" + "_" + "part_body", 1, undefined, undefined, "", 0);
    var_3b105a = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "part_guards", 32, 64, 0, undefined, &function_c1e52ea6, undefined, undefined, undefined, undefined, undefined, "gravityspike" + "_" + "part_guards", 1, undefined, undefined, "", 0);
    var_2e6bf9ce = namespace_f37770c8::function_5cf75ff1(var_9967ff1, "part_handle", 32, 64, 0, undefined, &function_c1e52ea6, undefined, undefined, undefined, undefined, undefined, "gravityspike" + "_" + "part_handle", 1, undefined, undefined, "", 0);
    var_2f18d6d0.var_e3aacab3 = &function_68b89800;
    var_3b105a.var_e3aacab3 = &function_e8931ee2;
    var_2e6bf9ce.var_e3aacab3 = &function_436d6e8e;
    var_2f18d6d0.var_dcc30f2f = undefined;
    var_3b105a.var_dcc30f2f = undefined;
    var_2e6bf9ce.var_dcc30f2f = undefined;
    var_b85003d9 = spawnstruct();
    var_b85003d9.name = var_9967ff1;
    var_b85003d9 namespace_f37770c8::function_b0deb4e6(var_2f18d6d0);
    var_b85003d9 namespace_f37770c8::function_b0deb4e6(var_3b105a);
    var_b85003d9 namespace_f37770c8::function_b0deb4e6(var_2e6bf9ce);
    var_b85003d9.var_41f0f8cd = &function_d8efa7d6;
    namespace_f37770c8::function_ac4e44a7(var_b85003d9);
    level flag::init(var_9967ff1 + "_" + "part_body" + "_found");
    level flag::init(var_9967ff1 + "_" + "part_guards" + "_found");
    level flag::init(var_9967ff1 + "_" + "part_handle" + "_found");
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_95743e9f
// Checksum 0xe80df356, Offset: 0xc90
// Size: 0xa6
function function_95743e9f() {
    register_clientfields();
    namespace_f37770c8::function_8421d708("gravityspike", %ZM_CASTLE_GRAVITYSPIKE_CRAFT, "", %ZM_CASTLE_GRAVITYSPIKE_PICKUP, &function_61ac1c22, 1);
    namespace_f37770c8::function_c86d092("gravityspike", "", (0, -90, 0), (0, 0, 0));
    level._effect["craftable_powerup_grabbed"] = "dlc1/castle/fx_talon_spike_grab_castle";
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_4ece4a2f
// Checksum 0x8f5bdeb9, Offset: 0xd40
// Size: 0x20c
function register_clientfields() {
    var_a0199abd = 1;
    registerclientfield("world", "gravityspike" + "_" + "part_body", 1, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "gravityspike" + "_" + "part_guards", 1, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "gravityspike" + "_" + "part_handle", 1, var_a0199abd, "int", undefined, 0);
    clientfield::register("scriptmover", "craftable_powerup_fx", 1, 1, "int");
    clientfield::register("scriptmover", "craftable_teleport_fx", 1, 1, "int");
    clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_PART_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_CRAFTED", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_gravityspike_parts", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.player_crafted_gravityspikes", 1, 1, "int");
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_68b89800
// Checksum 0x9210a937, Offset: 0xf58
// Size: 0x24
function function_68b89800(var_da5b715d) {
    self thread function_38b275a8(var_da5b715d);
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_38b275a8
// Checksum 0xba97c018, Offset: 0xf88
// Size: 0x90
function function_38b275a8(var_d97c08b2) {
    self endon(#"hash_92009fcb");
    self function_9980920d(var_d97c08b2);
    while (true) {
        v_pos = level waittill(#"hash_b650259c");
        self function_2742ffd4(var_d97c08b2, 0, v_pos);
        self waittill(#"hash_750017bb");
        self namespace_f37770c8::function_97b60807();
    }
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_436d6e8e
// Checksum 0x9fe4ff1e, Offset: 0x1020
// Size: 0x24
function function_436d6e8e(var_da5b715d) {
    self thread function_1e020746(var_da5b715d);
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_1e020746
// Checksum 0x6212b0ab, Offset: 0x1050
// Size: 0xe8
function function_1e020746(var_d97c08b2) {
    self endon(#"hash_92009fcb");
    self function_9980920d(var_d97c08b2);
    while (true) {
        level flag::wait_till("tesla_coil_on");
        level flag::wait_till_clear("tesla_coil_on");
        self function_2742ffd4(var_d97c08b2, 1, undefined, 115);
        array::thread_all(level.activeplayers, &function_31bdb575, self);
        self waittill(#"hash_750017bb");
        self namespace_f37770c8::function_97b60807();
    }
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_31bdb575
// Checksum 0x41e5fa84, Offset: 0x1140
// Size: 0xe0
function function_31bdb575(var_6aeefdcb) {
    var_6aeefdcb endon(#"hash_92009fcb");
    var_6aeefdcb endon(#"hash_750017bb");
    n_distance_sq = 16384;
    while (isdefined(self) && isdefined(var_6aeefdcb.model)) {
        var_317739a1 = distancesquared(self.origin, var_6aeefdcb.model.origin);
        if (var_317739a1 <= n_distance_sq) {
            var_6aeefdcb.unitrigger notify(#"trigger", self);
            self thread namespace_f37770c8::function_d1aff147(var_6aeefdcb);
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_e8931ee2
// Checksum 0x3a577600, Offset: 0x1228
// Size: 0xe4
function function_e8931ee2(var_da5b715d) {
    var_309c2973 = getent("spike_quest_console_switch", "targetname");
    var_309c2973.unitrigger = var_309c2973 function_ab1218c8();
    var_85a409cc = getent("spike_quest_wall_switch", "targetname");
    var_85a409cc.unitrigger = var_85a409cc function_af32bcac();
    self thread function_bf54e556(var_da5b715d, var_85a409cc);
    self thread function_cecf7412(var_da5b715d, var_309c2973);
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_af32bcac
// Checksum 0x12c2ea7c, Offset: 0x1318
// Size: 0xe8
function function_af32bcac() {
    level flag::init("rocket_pad_trigger_available");
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = self.origin;
    unitrigger_stub.angles = self.angles;
    unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.radius = 64;
    unitrigger_stub.prompt_and_visibility_func = &function_daa4f9c9;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_7d712d6a);
    return unitrigger_stub;
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_daa4f9c9
// Checksum 0x99bbced0, Offset: 0x1408
// Size: 0x90
function function_daa4f9c9(player) {
    if (level flag::get("rocket_pad_trigger_available") && !(isdefined(level.var_ddbeeb3f) && level.var_ddbeeb3f)) {
        self sethintstring(%ZM_CASTLE_GRAVITYSPIKE_A10_SWITCH);
        return 1;
    }
    self sethintstring("");
    return 0;
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_7d712d6a
// Checksum 0x41263e8c, Offset: 0x14a0
// Size: 0xd4
function function_7d712d6a() {
    self endon(#"kill_trigger");
    self.stub thread zm_unitrigger::run_visibility_function_for_all_triggers();
    while (!level flag::get("gravityspike_part_guards_found")) {
        e_who = self waittill(#"trigger");
        self.stub notify(#"trigger", e_who);
        level notify(#"hash_c48be23f");
        level thread function_f387f091();
        level flag::wait_till_clear("rocket_firing");
    }
    zm_unitrigger::unregister_unitrigger(self);
}

// Namespace namespace_dddf9a25
// Params 2, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_bf54e556
// Checksum 0xd949a479, Offset: 0x1580
// Size: 0x260
function function_bf54e556(var_d97c08b2, var_85a409cc) {
    var_85a409cc playsound("evt_tram_lever");
    exploder::exploder("lgt_gs_console_red_0");
    var_d5793a57 = getent("spike_quest_wall_door", "targetname");
    while (!level flag::get("gravityspike_part_guards_found")) {
        level flag::wait_till("rocket_firing");
        wait(6);
        level flag::set("rocket_pad_trigger_available");
        exploder::exploder("lgt_gs_console_grn_0");
        exploder::stop_exploder("lgt_gs_console_red_0");
        var_85a409cc rotateroll(-120, 0.5);
        var_d5793a57 rotateyaw(-120, 0.25);
        var_85a409cc playsound("evt_tram_lever");
        level util::waittill_either("a10_wall_switch_activated", "open_a10_doors");
        level flag::clear("rocket_pad_trigger_available");
        exploder::exploder("lgt_gs_console_red_0");
        exploder::stop_exploder("lgt_gs_console_grn_0");
        var_85a409cc rotateroll(120, 0.5);
        var_85a409cc playsound("evt_tram_lever");
        level flag::wait_till_clear("rocket_firing");
        var_d5793a57 rotateyaw(120, 0.25);
    }
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_ab1218c8
// Checksum 0x8c89f27a, Offset: 0x17e8
// Size: 0xc8
function function_ab1218c8() {
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = self.origin;
    unitrigger_stub.angles = self.angles;
    unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.radius = 64;
    unitrigger_stub.prompt_and_visibility_func = &function_26a928fd;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_ef8e1546);
    return unitrigger_stub;
}

// Namespace namespace_dddf9a25
// Params 2, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_cecf7412
// Checksum 0x1ca688c2, Offset: 0x18b8
// Size: 0x442
function function_cecf7412(var_d97c08b2, var_309c2973) {
    self function_9980920d(var_d97c08b2);
    var_586d1d4f = getent("spike_quest_console", "targetname");
    var_586d1d4f clientfield::set("death_ray_status_light", 2);
    var_309c2973 rotateroll(-120, 0.5);
    var_309c2973 playsound("evt_tram_lever");
    exploder::exploder("lgt_gs_console_red_1");
    exploder::exploder("lgt_gs_console_red_2");
    exploder::exploder("lgt_gs_console_red_3");
    while (!level flag::get("gravityspike_part_guards_found")) {
        level waittill(#"hash_c48be23f");
        exploder::stop_exploder("lgt_gs_console_red_1");
        level function_ff4c7ead("lgt_gs_console_grn_1");
        var_586d1d4f playsound("zmb_console_light");
        exploder::stop_exploder("lgt_gs_console_red_2");
        level function_ff4c7ead("lgt_gs_console_grn_2");
        var_586d1d4f playsound("zmb_console_light");
        exploder::stop_exploder("lgt_gs_console_red_3");
        level function_ff4c7ead("lgt_gs_console_grn_3");
        var_586d1d4f playsound("zmb_console_light_completed");
        level.var_d73f1734 = 1;
        var_586d1d4f clientfield::set("death_ray_status_light", 1);
        var_309c2973 rotateroll(120, 0.5);
        var_309c2973 playsound("evt_tram_lever");
        level util::waittill_any_timeout(4, "a10_switch_activated");
        var_586d1d4f playsound("zmb_console_light_reset");
        level.var_d73f1734 = undefined;
        var_586d1d4f clientfield::set("death_ray_status_light", 2);
        var_309c2973 rotateroll(-120, 0.5);
        var_309c2973 playsound("evt_tram_lever");
        exploder::exploder("lgt_gs_console_red_1");
        exploder::exploder("lgt_gs_console_red_2");
        exploder::exploder("lgt_gs_console_red_3");
        exploder::stop_exploder("lgt_gs_console_grn_1");
        exploder::stop_exploder("lgt_gs_console_grn_2");
        exploder::stop_exploder("lgt_gs_console_grn_3");
        if (isdefined(level.var_ddbeeb3f) && level.var_ddbeeb3f) {
            self function_2742ffd4(var_d97c08b2, 1);
        }
        level flag::wait_till_clear("rocket_firing");
        level.var_ddbeeb3f = undefined;
    }
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_ff4c7ead
// Checksum 0x7a814aeb, Offset: 0x1d08
// Size: 0xac
function function_ff4c7ead(str_exploder) {
    n_start_time = gettime();
    for (n_total_time = 0; n_total_time < 11; n_total_time = (gettime() - n_start_time) / 1000) {
        exploder::exploder(str_exploder);
        wait(0.2);
        exploder::stop_exploder(str_exploder);
        wait(0.2);
    }
    exploder::exploder(str_exploder);
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_26a928fd
// Checksum 0x562fe7d3, Offset: 0x1dc0
// Size: 0x80
function function_26a928fd(player) {
    if (isdefined(level.var_d73f1734) && !(isdefined(level.var_ddbeeb3f) && level.var_ddbeeb3f) && level.var_d73f1734) {
        self sethintstring(%ZM_CASTLE_GRAVITYSPIKE_A10_CONSOLE);
        return 1;
    }
    self sethintstring("");
    return 0;
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_ef8e1546
// Checksum 0x5de309a8, Offset: 0x1e48
// Size: 0xcc
function function_ef8e1546() {
    self endon(#"kill_trigger");
    self.stub thread zm_unitrigger::run_visibility_function_for_all_triggers();
    while (!level flag::get("gravityspike_part_guards_found")) {
        e_who = self waittill(#"trigger");
        self.stub notify(#"trigger", e_who);
        level notify(#"hash_37faed4c");
        level.var_ddbeeb3f = 1;
        level flag::wait_till_clear("rocket_firing");
    }
    zm_unitrigger::unregister_unitrigger(self);
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_f387f091
// Checksum 0x89dc090e, Offset: 0x1f20
// Size: 0x26e
function function_f387f091() {
    level endon(#"hash_37faed4c");
    level endon(#"hash_c3c346b0");
    while (true) {
        var_17167d70 = zombie_utility::get_current_zombie_count();
        var_bf9f0aee = 0;
        a_zombies = getaiteamarray(level.zombie_team);
        foreach (e_zombie in a_zombies) {
            if (e_zombie.targetname == "a10_zombie") {
                var_bf9f0aee++;
            }
        }
        var_f61ca199 = var_17167d70 + var_bf9f0aee;
        if (var_f61ca199 < level.zombie_vars["zombie_max_ai"] && var_bf9f0aee <= 10) {
            s_spawn_pos = function_1b872af("zone_v10_pad");
            if (isdefined(s_spawn_pos)) {
                ai_zombie = zombie_utility::spawn_zombie(level.zombie_spawners[0], "a10_zombie", s_spawn_pos);
                if (isdefined(ai_zombie)) {
                    ai_zombie.no_powerups = 1;
                    ai_zombie.no_damage_points = 1;
                    ai_zombie.deathpoints_already_given = 1;
                    ai_zombie.ignore_enemy_count = 1;
                    ai_zombie.exclude_cleanup_adding_to_total = 1;
                    playfx(level._effect["lightning_dog_spawn"], ai_zombie.origin);
                    ai_zombie thread function_f6e272db();
                }
            }
        }
        wait(3);
    }
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_f6e272db
// Checksum 0xa32ec07e, Offset: 0x2198
// Size: 0x84
function function_f6e272db() {
    wait(0.05);
    var_8643fc8a = randomint(100);
    if (var_8643fc8a <= 25) {
        return;
    }
    if (math::cointoss()) {
        self thread namespace_57695b4d::function_1b1bb1b();
        return;
    }
    self thread namespace_57695b4d::function_f4defbc2();
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_1b872af
// Checksum 0x505cf62f, Offset: 0x2228
// Size: 0x134
function function_1b872af(str_zone) {
    var_b11bb32e = getentarray(str_zone, "targetname");
    a_s_pos = [];
    a_s_spots = struct::get_array(var_b11bb32e[0].target, "targetname");
    for (i = 0; i < a_s_spots.size; i++) {
        if (a_s_spots[i].script_noteworthy === "spawn_location" || a_s_spots[i].script_noteworthy === "riser_location") {
            array::add(a_s_pos, a_s_spots[i], 0);
        }
    }
    if (a_s_pos.size > 0) {
        return array::random(a_s_pos);
    }
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_9980920d
// Checksum 0x2229df92, Offset: 0x2368
// Size: 0x120
function function_9980920d(var_d97c08b2) {
    self.var_da5b715d = var_d97c08b2;
    self.radius = var_d97c08b2.radius;
    self.height = var_d97c08b2.height;
    self.var_dba2448c = var_d97c08b2.var_dba2448c;
    self.piecename = var_d97c08b2.piecename;
    self.modelname = var_d97c08b2.modelname;
    self.var_9b0dedbc = var_d97c08b2.var_9b0dedbc;
    self.tag_name = var_d97c08b2.tag_name;
    self.drop_offset = var_d97c08b2.drop_offset;
    self.var_dcc30f2f = var_d97c08b2.var_dcc30f2f;
    self.var_6dd4b013 = var_d97c08b2.var_6dd4b013;
    self.var_fbfd6aca = var_d97c08b2.var_fbfd6aca;
}

// Namespace namespace_dddf9a25
// Params 4, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_2742ffd4
// Checksum 0xc1a43787, Offset: 0x2490
// Size: 0x24c
function function_2742ffd4(var_d97c08b2, b_teleported, v_position, var_dc35eb29) {
    if (self.spawns.size < 1) {
        return;
    }
    if (!isdefined(self.var_b7b5e000)) {
        self.var_b7b5e000 = 0;
    }
    spawndef = self.spawns[self.var_b7b5e000];
    if (!isdefined(v_position)) {
        v_position = spawndef.origin;
    }
    self.unitrigger = namespace_f37770c8::function_de125e20("trigger_radius", v_position + (0, 0, 32), spawndef.angles, 0, self.radius, self.height, var_d97c08b2.hint_string, 0, spawndef.script_string);
    self.unitrigger.piece = self;
    self.start_origin = v_position;
    self.start_angles = spawndef.angles;
    self.model = spawn("script_model", self.start_origin + (0, 0, 32));
    if (isdefined(self.start_angles)) {
        self.model.angles = self.start_angles;
    }
    self.model setmodel(self.modelname);
    if (isdefined(var_d97c08b2.onspawn)) {
        self [[ var_d97c08b2.onspawn ]]();
    }
    self.model ghostindemo();
    self.model.var_9b0dedbc = self.var_9b0dedbc;
    self.unitrigger.var_9351fe46 = self.model;
    self thread function_1f778391(b_teleported, var_dc35eb29);
}

// Namespace namespace_dddf9a25
// Params 2, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_1f778391
// Checksum 0x6558de9c, Offset: 0x26e8
// Size: 0xfc
function function_1f778391(b_teleported, var_dc35eb29) {
    self endon(#"hash_750017bb");
    self thread function_e5b369e4(b_teleported);
    self thread function_650a28f4(var_dc35eb29);
    e_who = self.unitrigger waittill(#"trigger");
    self notify(#"hash_92009fcb");
    if (isdefined(self)) {
        zm_unitrigger::unregister_unitrigger(self.unitrigger);
        self.unitrigger = undefined;
    }
    if (isdefined(self.model)) {
        playfx(level._effect["craftable_powerup_grabbed"], self.model.origin);
        self.model delete();
    }
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_e5b369e4
// Checksum 0x77bccdb3, Offset: 0x27f0
// Size: 0x1c8
function function_e5b369e4(b_teleported) {
    self endon(#"hash_92009fcb");
    self endon(#"hash_750017bb");
    self.model clientfield::set("craftable_powerup_fx", 1);
    if (isdefined(b_teleported) && b_teleported) {
        self.model clientfield::set("craftable_teleport_fx", 1);
    }
    while (isdefined(self.model)) {
        waittime = randomfloatrange(2.5, 5);
        yaw = randomint(360);
        if (yaw > 300) {
            yaw = 300;
        } else if (yaw < 60) {
            yaw = 60;
        }
        yaw = self.model.angles[1] + yaw;
        new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
        self.model rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        wait(randomfloat(waittime - 0.1));
    }
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_650a28f4
// Checksum 0xa8d9b681, Offset: 0x29c0
// Size: 0x1a4
function function_650a28f4(var_dc35eb29) {
    self endon(#"hash_92009fcb");
    self.model zm_powerups::powerup_show(1);
    if (!isdefined(var_dc35eb29)) {
        wait(15);
    } else {
        wait(var_dc35eb29);
    }
    for (i = 0; i < 40; i++) {
        if (i % 2) {
            self.model zm_powerups::powerup_show(0);
        } else {
            self.model zm_powerups::powerup_show(1);
        }
        if (i < 15) {
            wait(0.5);
            continue;
        }
        if (i < 25) {
            wait(0.25);
            continue;
        }
        wait(0.1);
    }
    self notify(#"hash_750017bb");
    if (isdefined(self.unitrigger)) {
        zm_unitrigger::unregister_unitrigger(self.unitrigger);
        self.unitrigger = undefined;
    }
    if (isdefined(self.model)) {
        playfx(level._effect["craftable_powerup_grabbed"], self.model.origin);
        self.model delete();
    }
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x0
// namespace_dddf9a25<file_0>::function_31edd14b
// Checksum 0xa5754885, Offset: 0x2b70
// Size: 0x16
function function_31edd14b(player) {
    self.var_77a0498d = undefined;
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x0
// namespace_dddf9a25<file_0>::function_66a9cb86
// Checksum 0xfda2da59, Offset: 0x2b90
// Size: 0x38
function function_66a9cb86(player) {
    player thread function_9708cb71(self.piecename);
    self.var_77a0498d = player;
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x0
// namespace_dddf9a25<file_0>::function_5b51de08
// Checksum 0x860b0a7c, Offset: 0x2bd0
// Size: 0xce
function function_5b51de08() {
    if (!level flag::get(self.var_dba2448c + "_" + self.piecename + "_found")) {
        var_8362e2f4 = undefined;
        switch (self.piecename) {
        case 3:
        case 4:
        case 5:
            break;
        default:
            break;
        }
        level flag::set(self.var_dba2448c + "_" + self.piecename + "_found");
        if (isdefined(var_8362e2f4)) {
        }
    }
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_9708cb71
// Checksum 0xa9c7ed20, Offset: 0x2ca8
// Size: 0x8c
function function_9708cb71(piecename) {
    var_983a0e9b = "zmb_zod_craftable_pickup";
    switch (piecename) {
    case 3:
    case 4:
    case 5:
        var_983a0e9b = "zmb_zod_idgunpiece_pickup";
        break;
    default:
        var_983a0e9b = "zmb_zod_craftable_pickup";
        break;
    }
    self playsound(var_983a0e9b);
}

// Namespace namespace_dddf9a25
// Params 2, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_69e0fb83
// Checksum 0x269d0d42, Offset: 0x2d40
// Size: 0x54
function function_69e0fb83(var_55ce4248, n_duration) {
    self clientfield::set_to_player(var_55ce4248, 1);
    wait(n_duration);
    self clientfield::set_to_player(var_55ce4248, 0);
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_c1e52ea6
// Checksum 0x6ccd0c9a, Offset: 0x2da0
// Size: 0x14a
function function_c1e52ea6(player) {
    level flag::set(self.var_dba2448c + "_" + self.piecename + "_found");
    player thread function_9708cb71(self.piecename);
    player thread namespace_97ddfc0d::function_43b44df3();
    level notify(#"hash_28a4818d");
    foreach (e_player in level.players) {
        e_player thread function_c1727537("zmInventory.player_crafted_gravityspikes", "zmInventory.widget_gravityspike_parts", 0);
        e_player thread function_69e0fb83("ZMUI_GRAVITYSPIKE_PART_PICKUP", 3.5);
    }
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_61ac1c22
// Checksum 0xd4ae5b7, Offset: 0x2ef8
// Size: 0x126
function function_61ac1c22(player) {
    level notify(#"hash_28a4818d");
    foreach (e_player in level.players) {
        if (zm_utility::is_player_valid(e_player)) {
            e_player thread function_c1727537("zmInventory.player_crafted_gravityspikes", "zmInventory.widget_gravityspike_parts", 1);
            e_player thread function_69e0fb83("ZMUI_GRAVITYSPIKE_CRAFTED", 3.5);
        }
    }
    self function_98c7dfa5(self.origin, self.angles);
    level notify(#"hash_71de5140");
    return true;
}

// Namespace namespace_dddf9a25
// Params 3, eflags: 0x5 linked
// namespace_dddf9a25<file_0>::function_c1727537
// Checksum 0x5685ae0a, Offset: 0x3028
// Size: 0xd4
function private function_c1727537(var_8ea57eb1, var_86a3391a, var_3fad0660) {
    self endon(#"disconnect");
    if (var_3fad0660) {
        if (isdefined(var_8ea57eb1)) {
            self thread clientfield::set_player_uimodel(var_8ea57eb1, 1);
        }
        var_83c971ff = 3.5;
    } else {
        var_83c971ff = 3.5;
    }
    self thread clientfield::set_player_uimodel(var_86a3391a, 1);
    level util::function_183e3618(var_83c971ff, "widget_ui_override", self, "disconnect");
    self thread clientfield::set_player_uimodel(var_86a3391a, 0);
}

// Namespace namespace_dddf9a25
// Params 2, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_98c7dfa5
// Checksum 0xa2f5334c, Offset: 0x3108
// Size: 0x1d4
function function_98c7dfa5(v_origin, v_angles) {
    width = -128;
    height = -128;
    length = -128;
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = v_origin;
    unitrigger_stub.angles = v_angles;
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.script_width = width;
    unitrigger_stub.script_height = height;
    unitrigger_stub.script_length = length;
    unitrigger_stub.require_look_at = 1;
    s_align = struct::get(self.target, "targetname");
    unitrigger_stub.var_c06b40f5 = util::spawn_model("wpn_zmb_dlc1_talon_spikes_world", s_align.origin + (0, 0, 25), s_align.angles + (0, -90, 0));
    unitrigger_stub.prompt_and_visibility_func = &function_4ae7dabf;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_f2c00181);
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_4ae7dabf
// Checksum 0x7002dc1c, Offset: 0x32e8
// Size: 0x90
function function_4ae7dabf(player) {
    var_87f03818 = getweapon("hero_gravityspikes_melee");
    if (player.var_887585ba == 0) {
        self sethintstring(%ZM_CASTLE_GRAVITYSPIKE_PICKUP);
        return 1;
    }
    self sethintstring(%ZM_CASTLE_GRAVITYSPIKE_ALREADY_HAVE);
    return 0;
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_f2c00181
// Checksum 0x15f2706c, Offset: 0x3380
// Size: 0xa4
function function_f2c00181() {
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        level thread function_adbf2990(self.stub, player);
        break;
    }
}

// Namespace namespace_dddf9a25
// Params 2, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_adbf2990
// Checksum 0xb537c34, Offset: 0x3430
// Size: 0x114
function function_adbf2990(var_91089b66, player) {
    if (player.var_887585ba == 0) {
        var_87f03818 = getweapon("hero_gravityspikes_melee");
        player zm_weapons::weapon_give(var_87f03818, 0, 1);
        player thread zm_equipment::show_hint_text(%ZM_CASTLE_GRAVITYSPIKE_USE_HINT, 3);
        player thread namespace_97ddfc0d::function_4e11dfdc();
        player gadgetpowerset(player gadgetgetslot(var_87f03818), 100);
        player zm_weap_gravityspikes::update_gravityspikes_state(2);
        player playrumbleonentity("zm_castle_interact_rumble");
    }
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_f89bb811
// Checksum 0xd036b04d, Offset: 0x3550
// Size: 0x3c
function function_f89bb811() {
    level.var_f72b0650 = 0;
    while (true) {
        util::wait_network_frame();
        level.var_f72b0650 = 0;
    }
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_e1832857
// Checksum 0x28a8a558, Offset: 0x3598
// Size: 0x58
function function_e1832857() {
    if (!isdefined(level.var_f72b0650)) {
        level thread function_f89bb811();
    }
    while (level.var_f72b0650 >= 2) {
        util::wait_network_frame();
    }
    level.var_f72b0650++;
}

// Namespace namespace_dddf9a25
// Params 0, eflags: 0x1 linked
// namespace_dddf9a25<file_0>::function_d8efa7d6
// Checksum 0xd6136950, Offset: 0x35f8
// Size: 0x4c
function function_d8efa7d6() {
    function_e1832857();
    namespace_f37770c8::function_4f91b11d("gravityspike_zm_craftable_trigger", "gravityspike", "hero_gravityspikes_melee", "", 1, 0);
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x0
// namespace_dddf9a25<file_0>::function_23472c70
// Checksum 0x30e66338, Offset: 0x3650
// Size: 0xc
function function_23472c70(var_2be8aff) {
    
}

// Namespace namespace_dddf9a25
// Params 1, eflags: 0x0
// namespace_dddf9a25<file_0>::function_b0c6c75a
// Checksum 0xe2d3965d, Offset: 0x3668
// Size: 0xc
function function_b0c6c75a(var_2be8aff) {
    
}

