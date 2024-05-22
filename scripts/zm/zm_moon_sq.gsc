#using scripts/zm/zm_moon_sq_ctvg;
#using scripts/zm/zm_moon_sq_ctt;
#using scripts/zm/zm_moon_sq_sc;
#using scripts/zm/zm_moon_sq_osc;
#using scripts/zm/zm_moon_sq_ss;
#using scripts/zm/zm_moon_sq_datalogs;
#using scripts/zm/zm_moon_sq_be;
#using scripts/zm/zm_moon_sq;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/_zm_weap_microwavegun;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_fa702a65;

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x10bf1914, Offset: 0x928
// Size: 0x36c
function init() {
    var_c415d225 = getentarray("sq_ss_button", "targetname");
    for (i = 0; i < var_c415d225.size; i++) {
        var_c415d225[i] usetriggerrequirelookat();
        var_c415d225[i] sethintstring("");
        var_c415d225[i] setcursorhint("HINT_NOICON");
    }
    level flag::init("first_tanks_charged");
    level flag::init("second_tanks_charged");
    level flag::init("first_tanks_drained");
    level flag::init("second_tanks_drained");
    level flag::init("c_built");
    level flag::init("vg_charged");
    level flag::init("switch_done");
    level flag::init("be2");
    level flag::init("ss1");
    level flag::init("soul_swap_done");
    namespace_6e97c459::function_f59cfc65("sq", &function_bb41e83b, &function_9b08126d, &function_e4eeb8b4, &function_c1d310ea, &function_182a03f);
    namespace_92f319c2::function_923ff8b();
    namespace_92f319c2::init_2();
    namespace_ecead789::init();
    namespace_32cb7332::init();
    namespace_32cb7332::init_2();
    namespace_6e97c459::function_f59cfc65("tanks", undefined, undefined, undefined, undefined, undefined);
    namespace_488f6343::function_923ff8b();
    namespace_488f6343::init_2();
    namespace_6e97c459::function_f59cfc65("ctvg", undefined, undefined, undefined, undefined, undefined);
    namespace_e4006eec::init();
    namespace_6e97c459::function_f59cfc65("be", undefined, undefined, undefined, undefined, undefined);
    namespace_ecd10753::init();
    function_2f7d3521();
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x53be1393, Offset: 0xca0
// Size: 0x32c
function init_clientfields() {
    namespace_6e97c459::function_225a92d6("vril", 21000);
    namespace_6e97c459::function_225a92d6("anti115", 21000);
    namespace_6e97c459::function_225a92d6("generator", 21000);
    namespace_6e97c459::function_225a92d6("cgenerator", 21000);
    namespace_6e97c459::function_225a92d6("wire", 21000);
    namespace_6e97c459::function_225a92d6("datalog", 21000);
    clientfield::register("world", "raise_rockets", 21000, 1, "counter");
    clientfield::register("world", "rocket_launch", 21000, 1, "counter");
    clientfield::register("world", "rocket_explode", 21000, 1, "counter");
    clientfield::register("world", "charge_tank_1", 21000, 1, "counter");
    clientfield::register("world", "charge_tank_2", 21000, 1, "counter");
    clientfield::register("world", "charge_tank_cleanup", 21000, 1, "counter");
    clientfield::register("world", "sam_vo_rumble", 21000, 1, "int");
    clientfield::register("world", "charge_vril_init", 21000, 1, "int");
    clientfield::register("world", "sq_wire_init", 21000, 1, "int");
    clientfield::register("world", "sam_init", 21000, 1, "int");
    n_bits = getminbitcountfornum(4);
    clientfield::register("world", "vril_generator", 21000, n_bits, "int");
    clientfield::register("world", "sam_end_rumble", 21000, 1, "int");
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x605cb2cd, Offset: 0xfd8
// Size: 0x54
function reward() {
    level notify(#"hash_68a9f436");
    players = getplayers();
    array::thread_all(players, &give_perk_reward);
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x4aad2947, Offset: 0x1038
// Size: 0x106
function function_1ec8e68b() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"spawned_player");
        waittillframeend();
        foreach (perk in level.var_93582a5d) {
            if (!self hasperk(perk)) {
                if (zm_perks::function_23ee6fc() && perk == "specialty_quickrevive") {
                    continue;
                }
                self zm_perks::give_perk(perk);
            }
        }
    }
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x50a625b5, Offset: 0x1148
// Size: 0x15c
function give_perk_reward() {
    if (isdefined(self.var_7fceabe1)) {
        return;
    }
    if (!isdefined(level.var_93582a5d)) {
        level.var_93582a5d = [];
        machines = getentarray("zombie_vending", "targetname");
        for (i = 0; i < machines.size; i++) {
            level.var_93582a5d[level.var_93582a5d.size] = machines[i].script_noteworthy;
        }
    }
    for (i = 0; i < level.var_93582a5d.size; i++) {
        if (!self hasperk(level.var_93582a5d[i])) {
            self playsound("evt_sq_bag_gain_perks");
            self zm_perks::give_perk(level.var_93582a5d[i]);
            wait(0.25);
        }
    }
    self.var_7fceabe1 = 1;
    self thread function_1ec8e68b();
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0xdc773eea, Offset: 0x12b0
// Size: 0x4c
function function_5c3d70d5() {
    init();
    level flag::wait_till("start_zombie_round_logic");
    namespace_6e97c459::function_d9be8a5b("sq");
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0xf8c8ce2b, Offset: 0x1308
// Size: 0x27c
function function_bb41e83b() {
    players = getplayers();
    level.var_538f4c7e = 0;
    level.var_83d456e9 = -32;
    for (i = 0; i < players.size; i++) {
        entnum = players[i].characterindex;
        /#
            println("zombie_vending" + entnum);
        #/
        if (isdefined(players[i].var_62030aa3)) {
            entnum = players[i].var_62030aa3;
        }
        if (entnum == 2) {
            var_3baf1bf = 1;
            if (var_3baf1bf) {
                players[i] namespace_6e97c459::function_f72f765e("sq", "generator", 0);
                level.var_538f4c7e = 1;
                continue;
            }
            if (level.onlinegame) {
                if (zm::is_sidequest_previously_completed("EOA")) {
                    players[i] namespace_6e97c459::function_f72f765e("sq", "generator", 0);
                    level.var_538f4c7e = 1;
                    break;
                }
                players[i] namespace_6e97c459::function_f72f765e("sq", "vril", 0);
                break;
            }
        }
    }
    level thread tanks();
    level thread function_6d02ff64();
    level thread be();
    level thread namespace_80d0b0a9::init();
    if (1 == getdvarint("scr_debug_launch")) {
        level thread function_1975569c();
    }
    level thread function_2c5c5990();
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0xfd417ab, Offset: 0x1590
// Size: 0x74
function function_1975569c() {
    level flag::wait_till("power_on");
    wait(5);
    level notify(#"hash_a94f7e83");
    wait(2);
    level notify(#"hash_a94f7e83");
    wait(2);
    level notify(#"hash_a94f7e83");
    level thread function_8fec7f40();
}

// Namespace namespace_fa702a65
// Params 1, eflags: 0x0
// Checksum 0x559900b8, Offset: 0x1610
// Size: 0x15e
function function_2c5c5990(player_num) {
    rockets = getentarray("moon_rockets", "script_noteworthy");
    array::thread_all(rockets, &function_5bc2e0bd);
    for (i = 3; i > 0; i--) {
        level waittill(#"hash_a94f7e83");
        level clientfield::increment("raise_rockets");
        rockets[i - 1] playsound("evt_rocket_move_up");
        str_scene = "p7_fxanim_zmhd_moon_rocket_launch_0" + i + "_bundle";
        level thread scene::init(str_scene);
    }
    level waittill(#"hash_a94f7e83");
    for (i = 0; i < 3; i++) {
        rockets[i] thread launch();
    }
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x3e5123e9, Offset: 0x1778
// Size: 0x90
function function_5bc2e0bd() {
    level endon(#"intermission");
    self endon(#"death");
    while (true) {
        level flag::wait_till("enter_nml");
        self ghost();
        level flag::wait_till_clear("enter_nml");
        self show();
    }
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x230ce589, Offset: 0x1810
// Size: 0x13c
function launch() {
    level clientfield::increment("rocket_launch");
    wait(randomfloatrange(0.1, 1));
    self playsound("evt_rocket_launch");
    if (!isdefined(level.var_cde53b4c)) {
        level.var_cde53b4c = 0;
    }
    level.var_cde53b4c++;
    /#
        println("end_is_near" + level.var_cde53b4c + "evt_earth_explode");
    #/
    str_scene = "p7_fxanim_zmhd_moon_rocket_launch_0" + level.var_cde53b4c + "_bundle";
    level thread zm_audio::sndmusicsystem_playstate("end_is_near");
    level scene::play(str_scene);
    /#
        println("end_is_near" + level.var_cde53b4c + "stage_two");
    #/
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x10d24ccb, Offset: 0x1958
// Size: 0x19c
function function_9b08126d() {
    level thread function_2fec0f10();
    level flag::wait_till("power_on");
    namespace_6e97c459::function_c09cb660("sq", "ss1");
    level flag::wait_till("ss1");
    namespace_6e97c459::function_c09cb660("sq", "osc");
    level waittill(#"hash_5ae84f7a");
    level flag::wait_till("complete_be_1");
    wait(4);
    namespace_6e97c459::function_c09cb660("sq", "sc");
    level waittill(#"hash_796fb863");
    level flag::wait_till("vg_charged");
    namespace_6e97c459::function_c09cb660("sq", "sc2");
    level waittill(#"hash_2d6bfa19");
    wait(5);
    level thread function_bbfba519();
    level waittill(#"hash_20778669");
    level flag::wait_till("be2");
    level thread function_8fec7f40();
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x1b80b39a, Offset: 0x1b00
// Size: 0x22e
function function_8fec7f40() {
    foreach (e_player in level.players) {
        if (e_player bgb::is_active("zm_bgb_killing_time")) {
            e_player bgb::take();
        }
    }
    level.var_d8417111 = 1;
    zm_utility::play_sound_2d("vox_xcomp_quest_step8_4");
    wait(10);
    level notify(#"hash_a94f7e83");
    wait(30);
    zm_utility::play_sound_2d("vox_xcomp_quest_step8_5");
    wait(30);
    zm_utility::play_sound_2d("evt_earth_explode");
    level clientfield::increment("rocket_explode");
    util::wait_network_frame();
    util::wait_network_frame();
    exploder::exploder("fxexp_2012");
    wait(2);
    level clientfield::increment("show_destroyed_earth");
    level.var_abc92c08 = 1;
    level notify(#"hash_8afea16");
    zm_utility::play_sound_2d("vox_xcomp_quest_laugh");
    level thread function_3175af58();
    reward();
    level util::set_lighting_state(1);
    level function_7aca917c();
    level.var_d8417111 = undefined;
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x2e590baf, Offset: 0x1d38
// Size: 0x84
function function_7aca917c() {
    if (isdefined(level.var_1b3f87f7)) {
        level.var_1b3f87f7 delete();
    }
    level.var_1b3f87f7 = createstreamerhint(level.activeplayers[0].origin, 1, 0);
    level.var_1b3f87f7 setlightingonly(1);
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x5a747106, Offset: 0x1dc8
// Size: 0x240
function function_3175af58() {
    level.var_c502e691 = 1;
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest8", 7);
    wait(12);
    player = function_9641563a(0);
    if (isdefined(player)) {
        player thread zm_audio::create_and_play_dialog("eggs", "quest8", 9);
        wait(5);
    }
    player = function_9641563a(1);
    if (isdefined(player)) {
        player thread zm_audio::create_and_play_dialog("eggs", "quest8", 9);
        wait(5);
    }
    player = function_9641563a(2);
    if (isdefined(player)) {
        player thread zm_audio::create_and_play_dialog("eggs", "quest8", 9);
        wait(5);
    }
    player = function_9641563a(3);
    if (isdefined(player)) {
        player thread zm_audio::create_and_play_dialog("eggs", "quest8", 9);
        wait(5);
    }
    player = function_9641563a(3);
    if (isdefined(player)) {
        player thread zm_audio::create_and_play_dialog("eggs", "quest8", 10);
    }
    level.var_c502e691 = 0;
}

// Namespace namespace_fa702a65
// Params 1, eflags: 0x0
// Checksum 0xca50e0bf, Offset: 0x2010
// Size: 0xbe
function function_9641563a(num) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        ent_num = players[i].characterindex;
        if (isdefined(players[i].var_62030aa3)) {
            ent_num = players[i].var_62030aa3;
        }
        if (ent_num == num) {
            return players[i];
        }
    }
    return undefined;
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x9fa88fd7, Offset: 0x20d8
// Size: 0xf4
function function_bbfba519() {
    s = struct::get("sq_vg_final", "targetname");
    level.var_c502e691 = 1;
    sound::play_in_space("vox_plr_2_quest_step6_9", s.origin);
    wait(2.3);
    sound::play_in_space("vox_plr_2_quest_step6_11", s.origin);
    wait(10.5);
    sound::play_in_space("vox_xcomp_quest_step6_14", s.origin);
    level.var_c502e691 = 0;
    namespace_6e97c459::function_c09cb660("sq", "ss2");
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0xfe6442f1, Offset: 0x21d8
// Size: 0x5c
function be() {
    namespace_6e97c459::function_c09cb660("be", "stage_one");
    level waittill(#"hash_2d6bfa19");
    wait(2);
    namespace_6e97c459::function_c09cb660("be", "stage_two");
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x45156d15, Offset: 0x2240
// Size: 0x94
function tanks() {
    level flag::wait_till("complete_be_1");
    wait(4);
    namespace_6e97c459::function_c09cb660("tanks", "ctt1");
    level waittill(#"hash_796fb863");
    level flag::wait_till("vg_charged");
    namespace_6e97c459::function_c09cb660("tanks", "ctt2");
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0xfe5b2d22, Offset: 0x22e0
// Size: 0x5c
function function_6d02ff64() {
    namespace_6e97c459::function_c09cb660("ctvg", "build");
    level waittill(#"hash_84039f35");
    wait(5);
    namespace_6e97c459::function_c09cb660("ctvg", "charge");
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0xcad7aad, Offset: 0x2348
// Size: 0x90
function function_ed9fb3c7() {
    level endon(#"hash_1ac5373b");
    while (true) {
        if (getdvarstring("cheat_sq") != "") {
            if (isdefined(level.var_e68ff12d)) {
                setdvar("cheat_sq", "");
                namespace_6e97c459::function_2f3ced1f("sq", level.var_e68ff12d);
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0xdc8f24ee, Offset: 0x23e0
// Size: 0x28
function function_c1d310ea() {
    /#
        level thread function_ed9fb3c7();
    #/
    level.var_17714997 = 1;
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x33fd8d1, Offset: 0x2410
// Size: 0x10
function function_182a03f() {
    level.var_17714997 = 0;
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0xa4d77552, Offset: 0x2428
// Size: 0x1c
function function_e4eeb8b4() {
    level thread function_37426445();
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x2450
// Size: 0x4
function function_37426445() {
    
}

// Namespace namespace_fa702a65
// Params 1, eflags: 0x0
// Checksum 0x4768315c, Offset: 0x2460
// Size: 0xaa
function function_4d5984a3(player_number) {
    if (!isdefined(player_number)) {
        player_number = 0;
    }
    var_baf6cfd7 = "a";
    switch (player_number) {
    case 0:
        var_baf6cfd7 = "a";
        break;
    case 1:
        var_baf6cfd7 = "b";
        break;
    case 2:
        var_baf6cfd7 = "c";
        break;
    case 3:
        var_baf6cfd7 = "d";
        break;
    }
    return var_baf6cfd7;
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0xffc80510, Offset: 0x2518
// Size: 0x100
function function_2fec0f10() {
    var_d3906307 = 0;
    while (true) {
        if (level flag::get("enter_nml") && !var_d3906307) {
            if (isdefined(level.var_abc92c08) && (!isdefined(level.var_abc92c08) || level.var_abc92c08)) {
                level clientfield::increment("hide_earth");
            }
            var_d3906307 = 1;
        } else if (!level flag::get("enter_nml") && var_d3906307) {
            if (!isdefined(level.var_abc92c08)) {
                level clientfield::increment("show_earth");
            }
            var_d3906307 = 0;
        }
        wait(0.1);
    }
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x8bcc1f, Offset: 0x2620
// Size: 0x23c
function function_2f7d3521() {
    zm_spawner::add_custom_zombie_spawn_logic(&function_69090b83);
    level flag::init("sd_active");
    level flag::wait_till("start_zombie_round_logic");
    level.var_c920d4c5 = struct::get("sd_bowl", "targetname");
    a_start = struct::get_array("sd_start", "script_noteworthy");
    foreach (s_start in a_start) {
        var_12a1091 = util::spawn_model(s_start.model, s_start.origin, s_start.angles);
        var_12a1091.targetname = s_start.targetname;
        var_12a1091 setscale(s_start.script_float);
        var_2ad32714 = spawn("trigger_damage", var_12a1091.origin, 0, 15, 15);
        namespace_1a0051d2::function_d4224082(var_2ad32714);
        var_12a1091 thread function_7e76fe45(var_2ad32714);
        level flag::init(var_12a1091.targetname);
    }
    level thread function_4ee03f50();
}

// Namespace namespace_fa702a65
// Params 1, eflags: 0x0
// Checksum 0x868774fc, Offset: 0x2868
// Size: 0x128
function function_7e76fe45(var_2ad32714) {
    self endon(#"death");
    while (true) {
        var_2ad32714 waittill(#"hash_d26ed760");
        level flag::set(self.targetname);
        var_6be16785 = struct::get(self.targetname + "_final", "targetname");
        var_aee26521 = util::spawn_model(self.model, var_6be16785.origin, var_6be16785.angles);
        var_aee26521 setscale(var_6be16785.script_float);
        wait(0.05);
        var_2ad32714 delete();
        self delete();
    }
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x9bc57cf0, Offset: 0x2998
// Size: 0x1d4
function function_4ee03f50() {
    a_start = struct::get_array("sd_start", "script_noteworthy");
    a_flags = [];
    foreach (s_start in a_start) {
        if (!isdefined(a_flags)) {
            a_flags = [];
        } else if (!isarray(a_flags)) {
            a_flags = array(a_flags);
        }
        a_flags[a_flags.size] = s_start.targetname;
    }
    if (!a_flags.size) {
        return;
    }
    level flag::wait_till_all(a_flags);
    var_8c15cb32 = struct::get("sd_bowl", "targetname");
    var_8c15cb32.radius = 65;
    var_8c15cb32.height = 72;
    var_8c15cb32.script_float = 7;
    var_8c15cb32.var_2cb6d1fc = %ZM_MOON_HACK_SILENT;
    namespace_6d813654::function_66764564(var_8c15cb32, &function_9391498d);
}

// Namespace namespace_fa702a65
// Params 1, eflags: 0x0
// Checksum 0x89d73f02, Offset: 0x2b78
// Size: 0x74
function function_9391498d(hacker) {
    namespace_6d813654::function_fcbe2f17(self);
    level flag::set("sd_active");
    level thread function_948d4e7d();
    level thread function_66951281();
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0xdb040487, Offset: 0x2bf8
// Size: 0x1da
function function_948d4e7d() {
    level flag::init("sd_large_complete");
    var_9f30ae72 = struct::get("sd_big_soul", "targetname");
    var_51aa97ed = util::spawn_model(var_9f30ae72.model, var_9f30ae72.origin, var_9f30ae72.angles);
    var_51aa97ed setscale(var_9f30ae72.script_float);
    var_c1b1cd1c = 2.3 / 30;
    var_fa77a9e7 = 0;
    while (true) {
        level waittill(#"hash_9b391ed5");
        if (var_fa77a9e7 < 30) {
            var_fa77a9e7++;
            var_51aa97ed.origin += (0, 0, var_c1b1cd1c);
            continue;
        }
        level flag::set("sd_large_complete");
        function_cff1fcfb();
        var_51aa97ed moveto(var_9f30ae72.origin, 1.5, 0.1, 0.1);
        var_51aa97ed waittill(#"movedone");
        var_51aa97ed delete();
        return;
    }
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x7b0c0f2a, Offset: 0x2de0
// Size: 0x1da
function function_66951281() {
    level flag::init("sd_small_complete");
    var_e7c6777b = struct::get("sd_small_soul", "targetname");
    var_51aa97ed = util::spawn_model(var_e7c6777b.model, var_e7c6777b.origin, var_e7c6777b.angles);
    var_51aa97ed setscale(var_e7c6777b.script_float);
    var_c1b1cd1c = 2 / 15;
    var_fa77a9e7 = 0;
    while (true) {
        level waittill(#"hash_d7362b52");
        if (var_fa77a9e7 < 15) {
            var_fa77a9e7++;
            var_51aa97ed.origin += (0, 0, var_c1b1cd1c);
            continue;
        }
        level flag::set("sd_small_complete");
        function_cff1fcfb();
        var_51aa97ed moveto(var_e7c6777b.origin, 1.5, 0.1, 0.1);
        var_51aa97ed waittill(#"movedone");
        var_51aa97ed delete();
        return;
    }
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x54542821, Offset: 0x2fc8
// Size: 0x14c
function function_69090b83() {
    attacker = self waittill(#"death");
    if (!isplayer(attacker)) {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    if (level flag::get("sd_active")) {
        v_end_pos = level.var_c920d4c5.origin;
        n_dist = distance(v_end_pos, self.origin);
        if (self.archetype === "zombie_quad") {
            if (level flag::get("sd_small_complete")) {
                return;
            }
            level notify(#"hash_d7362b52");
        } else {
            if (level flag::get("sd_large_complete")) {
                return;
            }
            level notify(#"hash_9b391ed5");
        }
        if (n_dist <= 256) {
            self clientfield::set("sd", 1);
        }
    }
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x2cdf0102, Offset: 0x3120
// Size: 0x9c
function function_cff1fcfb() {
    if (level flag::get("sd_large_complete") && level flag::get("sd_small_complete")) {
        level flag::clear("sd_active");
        level thread function_93878170();
        playsoundatposition("zmb_k9_ee_bling", (0, 0, 0));
    }
}

// Namespace namespace_fa702a65
// Params 0, eflags: 0x0
// Checksum 0x5455d1f8, Offset: 0x31c8
// Size: 0x138
function function_93878170() {
    var_653beee4 = array("p7_fxanim_zmhd_moon_spacedog_path1_sec1_bundle", "p7_fxanim_zmhd_moon_spacedog_path1_sec2_bundle", "p7_fxanim_zmhd_moon_spacedog_path2_bundle");
    var_efac5d38 = array("p7_fxanim_zmhd_moon_spacedog_path1_sec2_bundle", "p7_fxanim_zmhd_moon_spacedog_path2_bundle");
    wait(1);
    while (true) {
        if (level flag::get("start_hangar_digger") || level flag::get("start_teleporter_digger")) {
            str_scene = array::random(var_efac5d38);
        } else {
            str_scene = array::random(var_653beee4);
        }
        scene::play(str_scene);
        wait(randomfloatrange(600, 900));
    }
}

