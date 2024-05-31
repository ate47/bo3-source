#using scripts/zm/zm_moon_sq;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_488f6343;

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_923ff8b
// Checksum 0x337d1609, Offset: 0x538
// Size: 0x84
function function_923ff8b() {
    level.var_69d1c4b0 = [];
    zm_spawner::add_custom_zombie_spawn_logic(&function_2caefec8);
    namespace_6e97c459::function_5a90ed82("tanks", "ctt1", &function_8377a7d8, &function_7747c56, &function_15345222);
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_8377a7d8
// Checksum 0xcd29e1b, Offset: 0x5c8
// Size: 0x94
function function_8377a7d8() {
    level.var_69d1c4b0 = [];
    level.var_ca733eed = "ctt1";
    level.var_5eca9ae1 = "sam_switch_thrown";
    level.var_74081e99 = "first_tanks_charged";
    function_65fcb129("sq_first_tank");
    level clientfield::increment("charge_tank_1");
    level thread function_796f42e0();
}

// Namespace namespace_488f6343
// Params 1, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_15345222
// Checksum 0x8a1bfb0f, Offset: 0x668
// Size: 0x1c
function function_15345222(success) {
    function_265e0d0b();
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_971c9050
// Checksum 0x9612a6aa, Offset: 0x690
// Size: 0x54
function init_2() {
    namespace_6e97c459::function_5a90ed82("tanks", "ctt2", &function_f57f1713, &function_7747c56, &function_ef31d7b9);
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_f57f1713
// Checksum 0x93c696dc, Offset: 0x6f0
// Size: 0x40
function function_f57f1713() {
    level.var_69d1c4b0 = [];
    level.var_ca733eed = "ctt2";
    level.var_5eca9ae1 = "cvg_placed";
    level.var_74081e99 = "second_tanks_charged";
}

// Namespace namespace_488f6343
// Params 1, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_ef31d7b9
// Checksum 0xb398749c, Offset: 0x738
// Size: 0x3c
function function_ef31d7b9(success) {
    level flag::set("second_tanks_charged");
    function_265e0d0b();
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_7747c56
// Checksum 0x4815d848, Offset: 0x780
// Size: 0x4d4
function function_7747c56() {
    if (level.var_ca733eed == "ctt2") {
        s = struct::get("sq_vg_final", "targetname");
        var_128f6054 = 0;
        while (!var_128f6054) {
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                ent_num = players[i].characterindex;
                if (isdefined(players[i].var_62030aa3)) {
                    ent_num = players[i].var_62030aa3;
                }
                if (ent_num == 2) {
                    d = distancesquared(players[i].origin, s.origin);
                    if (d < 57600) {
                        var_128f6054 = 1;
                        players[i] playsound("vox_plr_2_quest_step6_0");
                        break;
                    }
                }
            }
            wait(0.1);
        }
        function_65fcb129("sq_first_tank", "sq_second_tank");
        level clientfield::increment("charge_tank_2");
        level thread function_b68e5e2b();
        level thread function_8794fd9c();
    }
    while (true) {
        if (function_aed6f3bc()) {
            sound::play_in_space("zmb_squest_all_souls_full", (0, 0, 0));
            level notify(#"hash_bc3741ea");
            break;
        }
        wait(0.1);
    }
    level clientfield::increment("charge_tank_cleanup");
    level flag::set(level.var_74081e99);
    level flag::wait_till(level.var_5eca9ae1);
    function_d94290b3();
    for (i = 0; i < level.var_69d1c4b0.size; i++) {
        tank = level.var_69d1c4b0[i];
        tank.var_2b6ee6a7 moveto(tank.var_2b6ee6a7.origin + (0, 0, 12), 2);
        tank.tank moveto(tank.tank.origin - (0, 0, 57.156), 2);
        tank.tank playsound("evt_tube_move_down");
        tank.tank util::delay(2, undefined, &exploder::stop_exploder, "canister_light_0" + tank.tank.script_int);
        tank.tank thread function_46fcff2f(2);
        tank triggerenable(0);
    }
    wait(2);
    if (level.var_ca733eed == "ctt2") {
        level flag::set("second_tanks_drained");
    } else {
        level flag::set("first_tanks_drained");
    }
    namespace_6e97c459::function_2f3ced1f("tanks", level.var_ca733eed);
}

// Namespace namespace_488f6343
// Params 1, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_46fcff2f
// Checksum 0xb96228c4, Offset: 0xc60
// Size: 0x2c
function function_46fcff2f(time) {
    wait(time);
    self playsound("evt_tube_stop");
}

// Namespace namespace_488f6343
// Params 2, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_874c53f0
// Checksum 0xc58b1661, Offset: 0xc98
// Size: 0x5c
function function_874c53f0(percent, l) {
    s = spawnstruct();
    s.percent = percent;
    s.line = l;
    return s;
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_b0ec8df8
// Checksum 0x45160e2c, Offset: 0xd00
// Size: 0xa2
function function_b0ec8df8() {
    var_da4ff2db = 0;
    fill = 0;
    for (i = 0; i < level.var_69d1c4b0.size; i++) {
        var_da4ff2db += level.var_69d1c4b0[i].var_da4ff2db;
        fill += level.var_69d1c4b0[i].fill;
    }
    return fill / var_da4ff2db;
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_8794fd9c
// Checksum 0xfa4524af, Offset: 0xdb0
// Size: 0x242
function function_8794fd9c() {
    level endon(#"hash_f5399d8d");
    stages = array(function_874c53f0(0.1, "vox_plr_4_quest_step6_1"), function_874c53f0(0.2, "vox_plr_4_quest_step6_1a"), function_874c53f0(0.3, "vox_plr_4_quest_step6_2"), function_874c53f0(0.4, "vox_plr_4_quest_step6_2a"), function_874c53f0(0.5, "vox_plr_4_quest_step6_3"), function_874c53f0(0.6, "vox_plr_4_quest_step6_3a"), function_874c53f0(0.7, "vox_plr_4_quest_step6_4"), function_874c53f0(0.9, "vox_plr_4_quest_step6_5"));
    index = 0;
    targ = struct::get("sq_sam", "targetname");
    targ = struct::get(targ.target, "targetname");
    while (index < stages.size) {
        stage = stages[index];
        while (function_b0ec8df8() < stage.percent) {
            wait(0.1);
        }
        level.var_c502e691 = 1;
        level thread function_af89fedf(stage.line, targ.origin, index);
        level.var_c502e691 = 0;
        index++;
    }
}

// Namespace namespace_488f6343
// Params 3, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_af89fedf
// Checksum 0x1a262e13, Offset: 0x1000
// Size: 0xdc
function function_af89fedf(var_799328be, origin, index) {
    level clientfield::set("sam_vo_rumble", 1);
    snd_ent = spawn("script_origin", origin);
    snd_ent playsoundwithnotify(var_799328be, index + "_snddone");
    snd_ent waittill(index + "_snddone");
    level clientfield::set("sam_vo_rumble", 0);
    snd_ent delete();
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_d94290b3
// Checksum 0xa83ba7d4, Offset: 0x10e8
// Size: 0x124
function function_d94290b3() {
    for (i = 0; i < level.var_69d1c4b0.size; i++) {
        tank = level.var_69d1c4b0[i];
        tank.var_7bbe1878 moveto(tank.var_7bbe1878.origin - (0, 0, 65), 1.5, 0.1, 0.1);
        tank.tank stoploopsound(1);
        tank.tank playsound("evt_souls_flush");
        tank.var_7bbe1878 thread function_9d7d01a9();
        tank.fill = 0;
    }
    wait(2);
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_9d7d01a9
// Checksum 0xeb9abc9c, Offset: 0x1218
// Size: 0x1c
function function_9d7d01a9() {
    wait(2);
    self ghost();
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_aed6f3bc
// Checksum 0x526f6bf4, Offset: 0x1240
// Size: 0x86
function function_aed6f3bc() {
    if (level.var_69d1c4b0.size == 0) {
        return false;
    }
    for (i = 0; i < level.var_69d1c4b0.size; i++) {
        tank = level.var_69d1c4b0[i];
        if (tank.fill < tank.var_da4ff2db) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_265e0d0b
// Checksum 0xe384c598, Offset: 0x12d0
// Size: 0x10e
function function_265e0d0b() {
    level clientfield::increment("charge_tank_cleanup");
    tanks = getentarray("ctt_tank", "script_noteworthy");
    for (i = 0; i < tanks.size; i++) {
        tank = tanks[i];
        tank.var_2b6ee6a7 delete();
        tank.var_2b6ee6a7 = undefined;
        tank.tank = undefined;
        tank.var_7bbe1878 delete();
        tank.var_7bbe1878 = undefined;
        tank delete();
    }
}

// Namespace namespace_488f6343
// Params 1, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_fd646a11
// Checksum 0x5917ef7c, Offset: 0x13e8
// Size: 0x2c
function movetopos(pos) {
    self moveto(pos, 1);
}

// Namespace namespace_488f6343
// Params 2, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_65fcb129
// Checksum 0x7654cbf2, Offset: 0x1420
// Size: 0x500
function function_65fcb129(var_53b9caad, var_945129e6) {
    tanks = struct::get_array(var_53b9caad, "targetname");
    if (isdefined(var_945129e6)) {
        tanks = arraycombine(tanks, struct::get_array(var_945129e6, "targetname"), 0, 0);
    }
    for (i = 0; i < tanks.size; i++) {
        tank = tanks[i];
        radius = 32;
        if (isdefined(tank.radius)) {
            radius = tank.radius;
        }
        height = 72;
        if (isdefined(tank.height)) {
            height = tank.height;
        }
        var_b6403db8 = spawn("trigger_radius", tank.origin, 1, radius, height);
        var_b6403db8.script_noteworthy = "ctt_tank";
        var_447eb749 = struct::get(tank.target, "targetname");
        var_7f5ebaa9 = spawn("script_model", var_447eb749.origin + (0, 0, 18));
        var_7f5ebaa9.angles = var_447eb749.angles;
        var_7f5ebaa9 setmodel(var_447eb749.model);
        var_7f5ebaa9 thread movetopos(var_447eb749.origin);
        var_b6403db8.var_2b6ee6a7 = var_7f5ebaa9;
        var_f36fe0e3 = getent(var_447eb749.target, "targetname");
        var_f36fe0e3 thread movetopos(var_f36fe0e3.origin + (0, 0, 57.156));
        var_f36fe0e3 playsound("evt_tube_move_up");
        var_f36fe0e3 util::delay(2, undefined, &exploder::exploder, "canister_light_0" + var_f36fe0e3.script_int);
        var_f36fe0e3 thread function_46fcff2f(1);
        var_b6403db8.tank = var_f36fe0e3;
        var_b6403db8.fill = 0;
        scalar = 1;
        scalar += (getplayers().size - 1) * 0.33;
        var_b6403db8.var_da4ff2db = int(25 * scalar);
        var_da4ff2db = struct::get(var_f36fe0e3.target, "targetname");
        var_b6403db8.tank.var_3d190eab = (var_da4ff2db.origin[2] - var_f36fe0e3.origin[2] + 53) / var_b6403db8.var_da4ff2db;
        var_501cf209 = util::spawn_model(var_da4ff2db.model, var_b6403db8.tank.origin + (0, 0, 2));
        var_501cf209 ghost();
        var_b6403db8.var_7bbe1878 = var_501cf209;
        level.var_69d1c4b0[level.var_69d1c4b0.size] = var_b6403db8;
    }
}

// Namespace namespace_488f6343
// Params 2, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_2d2eebf7
// Checksum 0x352f58a, Offset: 0x1928
// Size: 0x18c
function function_2d2eebf7(actor, tank) {
    if (tank.fill >= tank.var_da4ff2db) {
        return;
    }
    actor clientfield::set("ctt", 1);
    wait(0.5);
    if (tank.fill <= 0) {
        level notify(#"hash_14b1245e");
    }
    if (isdefined(tank) && tank.fill < tank.var_da4ff2db) {
        tank.fill++;
        tank.var_7bbe1878.origin += (0, 0, tank.tank.var_3d190eab);
        tank.var_7bbe1878 show();
    }
    if (tank.fill >= tank.var_da4ff2db) {
        tank.tank playsound("zmb_squest_tank_full");
        tank.tank playloopsound("zmb_squest_tank_full_lp", 1);
    }
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_2caefec8
// Checksum 0x8bf8c164, Offset: 0x1ac0
// Size: 0xd0
function function_2caefec8() {
    attacker = self waittill(#"death");
    if (!isplayer(attacker)) {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    for (i = 0; i < level.var_69d1c4b0.size; i++) {
        if (isdefined(level.var_69d1c4b0[i])) {
            if (self istouching(level.var_69d1c4b0[i])) {
                level thread function_2d2eebf7(self, level.var_69d1c4b0[i]);
                return;
            }
        }
    }
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_796f42e0
// Checksum 0xf4ecf994, Offset: 0x1b98
// Size: 0x64
function function_796f42e0() {
    level thread function_f4efa5b3();
    level thread function_35450c6d();
    level thread function_a9d09b39();
    level thread function_823abaaa();
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_f4efa5b3
// Checksum 0x24e56f2b, Offset: 0x1c08
// Size: 0xa8
function function_f4efa5b3() {
    level waittill(#"hash_14b1245e");
    for (i = 0; i < level.var_69d1c4b0.size; i++) {
        player = zm_utility::get_closest_player(level.var_69d1c4b0[i].origin);
        if (isdefined(player)) {
            player thread zm_audio::create_and_play_dialog("eggs", "quest4", 0);
            return;
        }
    }
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_823abaaa
// Checksum 0x93a9a390, Offset: 0x1cb8
// Size: 0x94
function function_823abaaa() {
    while (function_b0ec8df8() < 0.5) {
        wait(0.5);
    }
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest4", 1);
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_35450c6d
// Checksum 0x7fc3fa28, Offset: 0x1d58
// Size: 0x7c
function function_35450c6d() {
    level waittill(#"hash_bc3741ea");
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest4", 2);
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_a9d09b39
// Checksum 0x22067188, Offset: 0x1de0
// Size: 0xb8
function function_a9d09b39() {
    while (!level flag::get("sam_switch_thrown")) {
        while (level.zones["generator_zone"].is_occupied) {
            level.var_c502e691 = 1;
            if (level flag::get("sam_switch_thrown")) {
                break;
            }
            wait(1);
        }
        level.var_c502e691 = 0;
        wait(1);
    }
    level.var_c502e691 = 1;
    wait(10);
    level.var_c502e691 = 0;
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_b68e5e2b
// Checksum 0x56845241, Offset: 0x1ea0
// Size: 0x1c
function function_b68e5e2b() {
    level thread function_60d65999();
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x0
// namespace_488f6343<file_0>::function_38a0bbf4
// Checksum 0x42d16c78, Offset: 0x1ec8
// Size: 0x7c
function function_38a0bbf4() {
    level waittill(#"hash_bc3741ea");
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest6", 6);
}

// Namespace namespace_488f6343
// Params 0, eflags: 0x1 linked
// namespace_488f6343<file_0>::function_60d65999
// Checksum 0x5c7db4f0, Offset: 0x1f50
// Size: 0xb8
function function_60d65999() {
    while (!level flag::get("cvg_placed")) {
        while (level.zones["generator_zone"].is_occupied) {
            level.var_c502e691 = 1;
            if (level flag::get("cvg_placed")) {
                break;
            }
            wait(1);
        }
        level.var_c502e691 = 0;
        wait(1);
    }
    level.var_c502e691 = 1;
    wait(10);
    level.var_c502e691 = 0;
}

