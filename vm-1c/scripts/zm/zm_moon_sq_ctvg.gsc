#using scripts/zm/zm_moon_sq;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/_zm_weap_quantum_bomb;
#using scripts/zm/_zm_weap_black_hole_bomb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_e4006eec;

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_c35e6aab
// Checksum 0xf1fd9ef6, Offset: 0x808
// Size: 0x13c
function init() {
    level flag::init("w_placed");
    level flag::init("vg_placed");
    level flag::init("cvg_picked_up");
    namespace_6e97c459::function_5a90ed82("ctvg", "build", &function_eb976c5c, &function_ac2ddec3, &function_bc1d5285);
    namespace_6e97c459::function_9a85e396("ctvg", "build", "sq_cassimir_plates", &function_5334a352);
    namespace_6e97c459::function_5a90ed82("ctvg", "charge", &function_fca67dd6, &function_64424705, &function_7632825f);
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_5334a352
// Checksum 0x7c37c02a, Offset: 0x950
// Size: 0x142
function function_5334a352() {
    level waittill(#"hash_d40fd4e5");
    for (target = self.target; isdefined(target); target = struct.target) {
        struct = struct::get(target, "targetname");
        time = struct.script_float;
        if (!isdefined(time)) {
            time = 1;
        }
        self moveto(struct.origin, time, time / 10);
        self rotateto(struct.angles, time, time / 10);
        self waittill(#"movedone");
        playsoundatposition("evt_clank", self.origin);
    }
    level notify(#"hash_953bba08");
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_eb976c5c
// Checksum 0x99ec1590, Offset: 0xaa0
// Size: 0x4
function function_eb976c5c() {
    
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_29557a7a
// Checksum 0xe48973f3, Offset: 0xab0
// Size: 0x47c
function plates() {
    plates = getentarray("sq_cassimir_plates", "targetname");
    trig = getent("sq_cassimir_trigger", "targetname");
    while (true) {
        amount, attacker, direction, point, var_e5f012d6, modelname, tagname = trig waittill(#"damage");
        if (var_e5f012d6 == "MOD_PROJECTILE" || var_e5f012d6 == "MOD_PROJECTILE_SPLASH" || var_e5f012d6 == "MOD_EXPLOSIVE" || var_e5f012d6 == "MOD_EXPLOSIVE_SPLASH" || var_e5f012d6 == "MOD_GRENADE" || isplayer(attacker) && var_e5f012d6 == "MOD_GRENADE_SPLASH") {
            attacker thread zm_audio::create_and_play_dialog("eggs", "quest5", randomintrange(0, 2));
            break;
        }
    }
    trig delete();
    level notify(#"hash_d40fd4e5");
    level waittill(#"hash_953bba08");
    level.var_9c483a19 = spawn("trigger_radius", plates[0].origin + (0, 0, -70), 0, 125, 100);
    level.var_5fc80ad9 = &function_1e3d1509;
    level waittill(#"hash_4b348707");
    level.var_5fc80ad9 = undefined;
    level waittill(#"restart_round");
    var_cefa6d0 = struct::get_array("sq_ctvg_tp2", "targetname");
    for (i = 0; i < plates.size; i++) {
        plates[i] dontinterpolate();
        plates[i].origin = var_cefa6d0[i].origin;
        plates[i].angles = var_cefa6d0[i].angles;
    }
    namespace_ddd35ff::function_f2df781b("ctvg", &function_7d7eb085, 100, &function_cec4ac19);
    level.var_8d1b3ec7 = var_cefa6d0[0].origin;
    level waittill(#"hash_cec4ac19");
    namespace_ddd35ff::function_f94f76f0("ctvg");
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest5", randomintrange(4, 6));
    for (i = 0; i < plates.size; i++) {
        plates[i] ghost();
    }
    level clientfield::set("charge_vril_init", 1);
    level flag::set("c_built");
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_1b4c1687
// Checksum 0x3915d1c0, Offset: 0xf38
// Size: 0x22
function function_1b4c1687() {
    if (isdefined(self.var_de56b798) && self.var_de56b798) {
        return true;
    }
    return false;
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_de427e40
// Checksum 0xb38c976c, Offset: 0xf68
// Size: 0x3c
function function_de427e40() {
    level endon(#"hash_afd47c8");
    self waittill(#"disconnect");
    level notify(#"hash_6c9b8daa");
    level thread wire();
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_33457226
// Checksum 0xfba95ada, Offset: 0xfb0
// Size: 0x324
function wire() {
    level endon(#"hash_6c9b8daa");
    wires = struct::get_array("sq_wire_pos", "targetname");
    wires = array::randomize(wires);
    var_c8f3c1b2 = wires[0];
    wire = spawn("script_model", var_c8f3c1b2.origin);
    if (isdefined(var_c8f3c1b2.angles)) {
        wire.angles = var_c8f3c1b2.angles;
    }
    wire setmodel("p7_zm_moo_computer_rocket_launch_wire");
    wire thread namespace_6e97c459::function_dd92f786("pickedup_wire");
    who = wire waittill(#"hash_a3fc97ea");
    who thread function_de427e40();
    who thread zm_audio::create_and_play_dialog("eggs", "quest5", 7);
    who playsound("evt_grab_wire");
    who.var_de56b798 = 1;
    wire delete();
    who namespace_6e97c459::function_f72f765e("sq", "wire");
    level flag::wait_till("c_built");
    var_c8f3c1b2 = struct::get("sq_wire_final", "targetname");
    var_c8f3c1b2 thread namespace_6e97c459::function_dd92f786("placed_wire", &function_1b4c1687);
    who = var_c8f3c1b2 waittill(#"hash_d8ce7632");
    who thread zm_audio::create_and_play_dialog("eggs", "quest5", 8);
    who playsound("evt_casimir_charge");
    who playsound("evt_sq_rbs_light_on");
    who.var_de56b798 = undefined;
    who namespace_6e97c459::function_9f2411a3("sq", "wire");
    level clientfield::set("sq_wire_init", 1);
    level flag::set("w_placed");
}

// Namespace namespace_e4006eec
// Params 1, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_7d7eb085
// Checksum 0xfd192772, Offset: 0x12e0
// Size: 0xc
function function_7d7eb085(position) {
    
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_ff3a71a9
// Checksum 0x6cc98ecf, Offset: 0x12f8
// Size: 0x46
function function_ff3a71a9() {
    num = self.characterindex;
    if (isdefined(self.var_62030aa3)) {
        num = self.var_62030aa3;
    }
    return num == 2 && level.var_538f4c7e;
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_bd8910dc
// Checksum 0x8a461e48, Offset: 0x1348
// Size: 0x1bc
function vg() {
    level flag::wait_till("w_placed");
    level flag::wait_till("power_on");
    var_c5c31abc = struct::get("sq_charge_vg_pos", "targetname");
    var_c5c31abc thread namespace_6e97c459::function_dd92f786("vg_placed", &function_ff3a71a9);
    who = var_c5c31abc waittill(#"hash_ce3bcf64");
    who thread zm_audio::create_and_play_dialog("eggs", "quest5", 9);
    level.var_504ced38 = spawn("script_origin", var_c5c31abc.origin);
    level.var_504ced38 playsound("evt_vril_connect");
    level.var_504ced38 playloopsound("evt_vril_loop_lvl1", 1);
    who namespace_6e97c459::function_9f2411a3("sq", "generator");
    level clientfield::set("vril_generator", 1);
    level flag::set("vg_placed");
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_ac2ddec3
// Checksum 0x94153a0d, Offset: 0x1510
// Size: 0xcc
function function_ac2ddec3() {
    level thread plates();
    level thread wire();
    level thread vg();
    level flag::wait_till("c_built");
    level flag::wait_till("w_placed");
    level flag::wait_till("vg_placed");
    namespace_6e97c459::function_2f3ced1f("ctvg", "build");
}

// Namespace namespace_e4006eec
// Params 1, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_cec4ac19
// Checksum 0x33f77c24, Offset: 0x15e8
// Size: 0x44
function function_cec4ac19(position) {
    if (distancesquared(level.var_8d1b3ec7, position) < 16384) {
        level notify(#"hash_cec4ac19");
    }
    return false;
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_881f018a
// Checksum 0xa7d75624, Offset: 0x1638
// Size: 0x24
function function_881f018a() {
    wait(4.5);
    self delete();
}

// Namespace namespace_e4006eec
// Params 3, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_1e3d1509
// Checksum 0xa5459fab, Offset: 0x1668
// Size: 0x124
function function_1e3d1509(grenade, model, info) {
    if (isdefined(level.var_9c483a19) && grenade istouching(level.var_9c483a19)) {
        plates = getentarray("sq_cassimir_plates", "targetname");
        spot = spawn("script_model", plates[0].origin);
        spot setmodel("tag_origin");
        spot clientfield::set("toggle_black_hole_deployed", 1);
        spot thread function_881f018a();
        level thread function_50560fe8(grenade, plates);
        return true;
    }
    return false;
}

// Namespace namespace_e4006eec
// Params 2, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_50560fe8
// Checksum 0xe53b8111, Offset: 0x1798
// Size: 0x302
function function_50560fe8(grenade, models) {
    level.var_9c483a19 delete();
    level.var_9c483a19 = undefined;
    wait(1);
    time = 3;
    for (i = 0; i < models.size; i++) {
        models[i] moveto(grenade.origin + (0, 0, 50), time, time - 0.05);
    }
    wait(time);
    var_306ceb83 = struct::get_array("sq_ctvg_tp", "targetname");
    for (i = 0; i < models.size; i++) {
        models[i] ghost();
    }
    playsoundatposition("zmb_gersh_teleporter_out", grenade.origin + (0, 0, 50));
    wait(0.5);
    for (i = 0; i < models.size; i++) {
        models[i] dontinterpolate();
        models[i].angles = var_306ceb83[i].angles;
        models[i].origin = var_306ceb83[i].origin;
        models[i] stoploopsound(1);
    }
    wait(0.5);
    for (i = 0; i < models.size; i++) {
        models[i] show();
    }
    playfxontag(level._effect["black_hole_bomb_event_horizon"], models[0], "tag_origin");
    models[0] playsound("zmb_gersh_teleporter_go");
    models[0] playsound("evt_clank");
    wait(2);
    level notify(#"hash_4b348707");
}

// Namespace namespace_e4006eec
// Params 1, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_bc1d5285
// Checksum 0xdb931b30, Offset: 0x1aa8
// Size: 0xc
function function_bc1d5285(success) {
    
}

// Namespace namespace_e4006eec
// Params 2, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_5d33213d
// Checksum 0xb8a7b953, Offset: 0x1ac0
// Size: 0x106
function function_5d33213d(var_68f8b13b, lines) {
    stage = spawnstruct();
    stage.var_68f8b13b = var_68f8b13b;
    stage.lines = [];
    for (i = 0; i < lines.size; i += 2) {
        l = spawnstruct();
        l.who = lines[i];
        l.var_5413557f = lines[i + 1];
        stage.lines[stage.lines.size] = l;
    }
    return stage;
}

// Namespace namespace_e4006eec
// Params 1, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_9d0876d0
// Checksum 0xaa32d195, Offset: 0x1bd0
// Size: 0x2d8
function function_9d0876d0(lines) {
    level.var_c502e691 = 1;
    for (i = 0; i < lines.size; i++) {
        l = lines[i];
        sound_ent = undefined;
        switch (l.who) {
        case 49:
            players = getplayers();
            for (j = 0; j < players.size; j++) {
                ent_num = players[j].characterindex;
                if (isdefined(players[j].var_62030aa3)) {
                    ent_num = players[j].var_62030aa3;
                }
                if (ent_num == 2) {
                    sound_ent = players[j];
                    break;
                }
            }
            break;
        case 47:
        case 48:
            sound_ent = level.var_7d620166;
            break;
        }
        if (l.var_5413557f == "vox_mcomp_quest_step5_15" || l.var_5413557f == "vox_mcomp_quest_step5_26") {
            level.var_ceddf497 setmodel("p7_zm_moo_computer_rocket_launch_green");
        } else if (l.var_5413557f == "vox_xcomp_quest_step5_16") {
            level.var_ceddf497 setmodel("p7_zm_moo_computer_rocket_launch_red");
        }
        if (zombie_utility::is_player_valid(sound_ent) && sound_ent zm_equipment::is_active(level.var_f486078e)) {
            sound_ent playsoundwithnotify(l.var_5413557f + "_f", "line_spoken");
        } else {
            sound_ent playsoundwithnotify(l.var_5413557f, "line_spoken");
        }
        sound_ent waittill(#"hash_7d032c08");
    }
    level.var_7d620166 stoploopsound();
    level.var_c502e691 = 0;
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_fca67dd6
// Checksum 0xb5211ea, Offset: 0x1eb0
// Size: 0x274
function function_fca67dd6() {
    level.var_9ed8b2a2 = array(function_5d33213d(1, array("rictofen", "vox_plr_2_quest_step5_12")), function_5d33213d(15, array("computer", "vox_mcomp_quest_step5_13", "rictofen", "vox_plr_2_quest_step5_14")), function_5d33213d(15, array("computer", "vox_mcomp_quest_step5_15", "maxis", "vox_xcomp_quest_step5_16", "rictofen", "vox_plr_2_quest_step5_17")), function_5d33213d(10, array("maxis", "vox_xcomp_quest_step5_18", "rictofen", "vox_plr_2_quest_step5_19")), function_5d33213d(15, array("maxis", "vox_xcomp_quest_step5_20", "rictofen", "vox_plr_2_quest_step5_21", "maxis", "vox_xcomp_quest_step5_22", "rictofen", "vox_plr_2_quest_step5_23")), function_5d33213d(10, array("maxis", "vox_xcomp_quest_step5_24", "rictofen", "vox_plr_2_quest_step5_25", "computer", "vox_mcomp_quest_step5_26")));
    var_36e9b7f6 = struct::get("sq_charge_terminal", "targetname");
    level.var_7d620166 = spawn("script_origin", var_36e9b7f6.origin);
    level.var_ceddf497 = getent("sq_ctvg_terminal", "targetname");
    level.var_ceddf497 setmodel("p7_zm_moo_computer_rocket_launch_red");
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_284c2a92
// Checksum 0x47d56e36, Offset: 0x2130
// Size: 0x46
function function_284c2a92() {
    ent_num = self.characterindex;
    if (isdefined(self.var_62030aa3)) {
        ent_num = self.var_62030aa3;
    }
    if (ent_num == 2) {
        return true;
    }
    return false;
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_db6b2891
// Checksum 0x58d35888, Offset: 0x2180
// Size: 0x46
function function_db6b2891() {
    ent_num = self.characterindex;
    if (isdefined(self.var_62030aa3)) {
        ent_num = self.var_62030aa3;
    }
    if (ent_num != 2) {
        return true;
    }
    return false;
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_2b678427
// Checksum 0xac2f44e3, Offset: 0x21d0
// Size: 0xe0
function function_2b678427() {
    level endon(#"hash_43131ac4");
    level.var_7d620166 playloopsound("evt_typing_loop");
    var_9bbdb00 = 1;
    level.var_5fb8b89f = gettime();
    while (true) {
        if (var_9bbdb00) {
            if (gettime() - level.var_5fb8b89f > -6) {
                var_9bbdb00 = 0;
                level.var_7d620166 stoploopsound();
            }
        } else if (gettime() - level.var_5fb8b89f < 100) {
            var_9bbdb00 = 1;
            level.var_7d620166 playloopsound("evt_typing_loop");
        }
        wait(0.1);
    }
}

// Namespace namespace_e4006eec
// Params 1, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_21f3fc41
// Checksum 0xe28381ad, Offset: 0x22b8
// Size: 0x1ae
function function_21f3fc41(target) {
    var_70bd959a = 0;
    players = getplayers();
    richtofen = undefined;
    level thread function_2b678427();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        ent_num = player.characterindex;
        if (isdefined(player.var_62030aa3)) {
            ent_num = player.var_62030aa3;
        }
        if (ent_num == 2) {
            richtofen = players[i];
            break;
        }
    }
    while (var_70bd959a < target) {
        level.var_7d620166 thread namespace_6e97c459::function_dd92f786("press", &function_284c2a92);
        level.var_7d620166 waittill(#"press");
        var_70bd959a++;
        level.var_5fb8b89f = gettime();
        while (isdefined(richtofen) && richtofen usebuttonpressed()) {
            wait(0.05);
        }
    }
    level notify(#"hash_43131ac4");
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_5323337c
// Checksum 0x1d1f68b3, Offset: 0x2470
// Size: 0xa8
function function_5323337c() {
    level endon(#"hash_15cfc4a");
    while (true) {
        if (isdefined(level.var_7d620166)) {
            level.var_7d620166 thread namespace_6e97c459::function_dd92f786("wrong_press", &function_db6b2891);
            who = level.var_7d620166 waittill(#"hash_bb4f8e64");
            who thread zm_audio::create_and_play_dialog("eggs", "quest5", 11);
        }
        wait(1);
    }
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_1c037010
// Checksum 0xe50bd4e1, Offset: 0x2520
// Size: 0x88
function function_1c037010() {
    level endon(#"collected");
    while (true) {
        self thread namespace_6e97c459::function_dd92f786("wrong_collector", &function_db6b2891);
        who = self waittill(#"hash_1c037010");
        who thread zm_audio::create_and_play_dialog("eggs", "quest5", 27);
        wait(1);
    }
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_64424705
// Checksum 0x5455527a, Offset: 0x25b0
// Size: 0x2ac
function function_64424705() {
    stage_index = 0;
    level thread function_5323337c();
    level thread function_8a147c83();
    while (stage_index < level.var_9ed8b2a2.size) {
        stage = level.var_9ed8b2a2[stage_index];
        function_21f3fc41(stage.var_68f8b13b);
        function_9d0876d0(stage.lines);
        stage_index++;
    }
    level clientfield::set("vril_generator", 2);
    level.var_504ced38 playsound("evt_extra_charge");
    level.var_504ced38 playloopsound("evt_vril_loop_lvl2", 1);
    level thread function_ca2f9f22();
    vg = struct::get("sq_charge_vg_pos", "targetname");
    level notify(#"hash_15cfc4a");
    vg thread function_1c037010();
    vg thread namespace_6e97c459::function_dd92f786("collect", &function_284c2a92);
    who = vg waittill(#"collect");
    who thread zm_audio::create_and_play_dialog("eggs", "quest5", 27);
    who playsound("evt_vril_remove");
    level.var_504ced38 delete();
    level.var_504ced38 = undefined;
    level clientfield::set("vril_generator", 3);
    who namespace_6e97c459::function_f72f765e("sq", "cgenerator");
    level notify(#"collected");
    namespace_6e97c459::function_2f3ced1f("ctvg", "charge");
}

// Namespace namespace_e4006eec
// Params 1, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_7632825f
// Checksum 0x16d3d161, Offset: 0x2868
// Size: 0x4c
function function_7632825f(success) {
    level.var_7d620166 delete();
    level.var_7d620166 = undefined;
    level flag::set("vg_charged");
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_8a147c83
// Checksum 0xa368ab25, Offset: 0x28c0
// Size: 0x62
function function_8a147c83() {
    level endon(#"hash_ca2f9f22");
    while (true) {
        while (level.zones["bridge_zone"].is_occupied) {
            level.var_c502e691 = 1;
            wait(1);
        }
        level.var_c502e691 = 0;
        wait(1);
    }
}

// Namespace namespace_e4006eec
// Params 0, eflags: 0x1 linked
// namespace_e4006eec<file_0>::function_ca2f9f22
// Checksum 0xa56c55a7, Offset: 0x2930
// Size: 0x24
function function_ca2f9f22() {
    level notify(#"hash_ca2f9f22");
    wait(1);
    level.var_c502e691 = 0;
}

