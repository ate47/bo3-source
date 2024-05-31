#using scripts/zm/zm_zod_vo;
#using scripts/zm/zm_zod_util;
#using scripts/zm/zm_zod_sword_quest;
#using scripts/zm/zm_zod_shadowman;
#using scripts/zm/zm_zod_quest_vo;
#using scripts/zm/zm_zod_quest;
#using scripts/zm/zm_zod_pods;
#using scripts/zm/zm_zod_margwa;
#using scripts/zm/zm_zod_defend_areas;
#using scripts/zm/zm_zod_craftables;
#using scripts/zm/zm_zod;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_altbody_beast;
#using scripts/zm/_zm_altbody;
#using scripts/zm/_zm_ai_wasp;
#using scripts/zm/_zm_ai_raps;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/margwa;
#using scripts/shared/ai_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/music_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_ba13c715;

// Namespace namespace_ba13c715
// Params 0, eflags: 0x2
// namespace_ba13c715<file_0>::function_2dc19561
// Checksum 0x13ef71a3, Offset: 0x11c0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_ee", &__init__, undefined, undefined);
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_8c87d8eb
// Checksum 0x167f4971, Offset: 0x1200
// Size: 0x7d4
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    n_bits = getminbitcountfornum(5);
    clientfield::register("world", "ee_quest_state", 1, n_bits, "int");
    n_bits = getminbitcountfornum(6);
    clientfield::register("world", "ee_totem_state", 1, n_bits, "int");
    n_bits = getminbitcountfornum(10);
    clientfield::register("world", "ee_keeper_boxer_state", 1, n_bits, "int");
    clientfield::register("world", "ee_keeper_detective_state", 1, n_bits, "int");
    clientfield::register("world", "ee_keeper_femme_state", 1, n_bits, "int");
    clientfield::register("world", "ee_keeper_magician_state", 1, n_bits, "int");
    clientfield::register("world", "ee_shadowman_battle_active", 1, 1, "int");
    clientfield::register("scriptmover", "near_apothigod_active", 1, 1, "int");
    clientfield::register("scriptmover", "far_apothigod_active", 1, 1, "int");
    clientfield::register("scriptmover", "near_apothigod_roar", 1, 1, "counter");
    clientfield::register("scriptmover", "far_apothigod_roar", 1, 1, "counter");
    clientfield::register("scriptmover", "apothigod_death", 1, 1, "counter");
    n_bits = getminbitcountfornum(5);
    clientfield::register("world", "ee_superworm_state", 1, n_bits, "int");
    n_bits = getminbitcountfornum(3);
    clientfield::register("world", "ee_keeper_beam_state", 1, n_bits, "int");
    clientfield::register("world", "ee_final_boss_shields", 1, 1, "int");
    clientfield::register("toplayer", "ee_final_boss_attack_tell", 1, 1, "int");
    clientfield::register("scriptmover", "ee_rail_electricity_state", 1, 1, "int");
    clientfield::register("world", "sndEndIGC", 1, 1, "int");
    var_9eb45ed3 = array("boxer", "detective", "femme", "magician");
    level flag::init("ee_begin");
    level flag::init("ee_book");
    foreach (var_d7e2a718 in var_9eb45ed3) {
        level flag::init("ee_keeper_" + var_d7e2a718 + "_resurrected");
        level flag::init("ee_keeper_" + var_d7e2a718 + "_armed");
    }
    level flag::init("ee_boss_started");
    level flag::init("ee_boss_defeated");
    level flag::init("ee_boss_vulnerable");
    for (i = 1; i < 4; i++) {
        level flag::init("ee_district_rail_electrified_" + i);
    }
    for (i = 0; i < 3; i++) {
        level flag::init("ee_final_boss_keeper_electricity_" + i);
    }
    level flag::init("ee_superworm_present");
    level flag::init("ee_final_boss_beam_active");
    level flag::init("ee_final_boss_defeated");
    level flag::init("ee_final_boss_midattack");
    level flag::init("ee_final_boss_staggered");
    level flag::init("ee_complete");
    level flag::init("ee_ending_flash");
    level flag::init("ee_ending_fade");
    level flag::init("totem_placed");
    level._effect["ee_quest_book_mist"] = "zombie/fx_ee_book_mist_zod_zmb";
    level._effect["ee_quest_keeper_shocked"] = "zombie/fx_tesla_shock_zmb";
    /#
        level thread function_80d91769();
    #/
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_fb4f96b5
// Checksum 0x99ec1590, Offset: 0x19e0
// Size: 0x4
function on_player_connect() {
    
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_aebcf025
// Checksum 0x99ec1590, Offset: 0x19f0
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_7a1d4697
// Checksum 0x534cdbb2, Offset: 0x1a00
// Size: 0x3c
function function_7a1d4697() {
    self notify(#"hash_7a1d4697");
    self endon(#"hash_7a1d4697");
    /#
        iprintlnbold("ee_keeper_magician_state");
    #/
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_189ed812
// Checksum 0x1f05752c, Offset: 0x1a48
// Size: 0x23e
function function_189ed812() {
    callback::on_connect(&function_7a1d4697);
    function_1b6ee215();
    level flag::wait_till("ritual_pap_complete");
    function_8a05e65();
    level flag::wait_till("ee_begin");
    function_b82bf71d();
    function_2e77f7bf();
    function_db49b939();
    players = level.players;
    if (isdefined(level.var_421ff75e) && (players.size === 4 || level.var_421ff75e)) {
        level clientfield::set("ee_quest_state", 3);
        for (i = 1; i < 5; i++) {
            var_d7e2a718 = function_d93f551b(i);
            var_91341fca = "ee_keeper_" + var_d7e2a718 + "_state";
            level clientfield::set(var_91341fca, 8);
            wait(0.1);
        }
        function_db8d1f6e();
        function_6f8c2ea3();
    } else {
        level clientfield::set("ee_quest_state", 2);
    }
    players = level.activeplayers;
    for (i = 0; i < players.size; i++) {
        players[i] namespace_aa27450a::function_8ae67230(2, 1);
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_1b6ee215
// Checksum 0xd04177b5, Offset: 0x1c90
// Size: 0x84
function function_1b6ee215() {
    e_book = getent("ee_book", "targetname");
    e_book ghost();
    function_c3466d96(0);
    level.var_b94f6d7a = struct::get_array("ee_totem_leyline", "targetname");
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_c3466d96
// Checksum 0xfb539b84, Offset: 0x1d20
// Size: 0x22c
function function_c3466d96(b_on) {
    if (!isdefined(level.var_76c101df)) {
        level.var_76c101df = [];
    }
    if (b_on) {
        for (i = 0; i < 3; i++) {
            str_targetname = "ee_apothigod_keeper_clip_" + i;
            var_4fafa709 = struct::get(str_targetname, "targetname");
            mdl_clip = spawn("script_model", var_4fafa709.origin);
            mdl_clip setmodel("collision_clip_zod_keeper_32x32x128");
            mdl_clip.origin = var_4fafa709.origin + (0, 0, 48);
            mdl_clip.angles = var_4fafa709.angles;
            if (!isdefined(level.var_76c101df)) {
                level.var_76c101df = [];
            } else if (!isarray(level.var_76c101df)) {
                level.var_76c101df = array(level.var_76c101df);
            }
            level.var_76c101df[level.var_76c101df.size] = mdl_clip;
        }
        return;
    }
    foreach (mdl_clip in level.var_76c101df) {
        mdl_clip delete();
    }
    level.var_76c101df = [];
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_8a05e65
// Checksum 0x92e24728, Offset: 0x1f58
// Size: 0xd4
function function_8a05e65() {
    var_ad91cbf7 = 0;
    while (!var_ad91cbf7) {
        if (isdefined(level.var_421ff75e) && level.var_421ff75e) {
            return;
        }
        var_ad91cbf7 = 1;
        players = level.activeplayers;
        for (i = 0; i < players.size; i++) {
            if (players[i] namespace_aa27450a::function_962dc2e9(2) === 0) {
                var_ad91cbf7 = 0;
            }
        }
        wait(1);
    }
    level flag::set("ee_begin");
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_b82bf71d
// Checksum 0x9e42863b, Offset: 0x2038
// Size: 0x164
function function_b82bf71d() {
    e_book = getent("ee_book", "targetname");
    var_f9efb018 = spawn("script_model", e_book.origin);
    var_f9efb018 setmodel("tag_origin");
    var_f9efb018.origin = e_book.origin;
    var_f9efb018.angles = e_book.angles;
    var_61835890 = playfxontag(level._effect["ee_quest_book_mist"], var_f9efb018, "tag_origin");
    wait(1.5);
    e_book show();
    wait(1.5);
    var_f9efb018 delete();
    level thread function_e6341733(e_book);
    level flag::wait_till("ee_book");
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_2e77f7bf
// Checksum 0x3b738507, Offset: 0x21a8
// Size: 0x124
function function_2e77f7bf() {
    level.var_f47099f2 = 0;
    level.var_e59fb2 = function_e4f61654();
    var_6aaeecbc = [];
    for (i = 1; i <= 4; i++) {
        level thread function_9190a90e(i);
        var_d7e2a718 = function_d93f551b(i);
        if (!isdefined(var_6aaeecbc)) {
            var_6aaeecbc = [];
        } else if (!isarray(var_6aaeecbc)) {
            var_6aaeecbc = array(var_6aaeecbc);
        }
        var_6aaeecbc[var_6aaeecbc.size] = "ee_keeper_" + var_d7e2a718 + "_resurrected";
    }
    level flag::wait_till_all(var_6aaeecbc);
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_db49b939
// Checksum 0xcdf65718, Offset: 0x22d8
// Size: 0x374
function function_db49b939() {
    level clientfield::set("ee_quest_state", 1);
    var_9eb45ed3 = array("boxer", "detective", "femme", "magician");
    var_62e5c0fb = [];
    for (i = 0; i < 4; i++) {
        var_d7e2a718 = var_9eb45ed3[i];
        if (!isdefined(var_62e5c0fb)) {
            var_62e5c0fb = [];
        } else if (!isarray(var_62e5c0fb)) {
            var_62e5c0fb = array(var_62e5c0fb);
        }
        var_62e5c0fb[var_62e5c0fb.size] = "ee_keeper_" + var_d7e2a718 + "_armed";
        function_676d671(i + 1);
    }
    function_1e8f02dd();
    function_f0c43ca0();
    if (level flag::get("ee_boss_defeated")) {
        return;
    }
    function_5db6ba34();
    level thread function_7f4562e9();
    level flag::set("ee_boss_started");
    namespace_1f61c67f::function_ee08dafb("pap", 1);
    var_a21704fb = [];
    var_a21704fb[0] = spawnstruct();
    var_a21704fb[0].func = &namespace_331b1e91::function_b4b792ef;
    var_a21704fb[0].probability = 1;
    var_a21704fb[0].var_572b6f62 = randomfloatrange(6, 12);
    level.var_dbc3a0ef = level thread namespace_331b1e91::function_f3805c8a("ee_shadowman_8", undefined, var_a21704fb, 6, 12);
    level.var_dbc3a0ef.var_93dad597 clientfield::set("boss_shield_fx", 1);
    level.var_dbc3a0ef.var_93dad597 playsound("zmb_zod_shadfight_shield_up_short");
    level thread function_4bcb6826();
    level thread function_e49d016d();
    level flag::wait_till("ee_boss_defeated");
    namespace_1f61c67f::function_ee08dafb("pap", 0);
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_7f4562e9
// Checksum 0x3d23d7ec, Offset: 0x2658
// Size: 0x78
function function_7f4562e9() {
    level endon(#"end_game");
    level.musicsystemoverride = 1;
    music::setmusicstate("zod_ee_shadfight");
    level flag::wait_till("ee_boss_defeated");
    music::setmusicstate("none");
    level.musicsystemoverride = 0;
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_f0c43ca0
// Checksum 0x320c7c1b, Offset: 0x26d8
// Size: 0x21c
function function_f0c43ca0() {
    while (true) {
        var_c96f65f1 = 1;
        players = level.activeplayers;
        foreach (player in players) {
            e_volume = getent("defend_area_volume_pap", "targetname");
            if (!player istouching(e_volume)) {
                var_c96f65f1 = 0;
            }
            var_96ebfa18 = player namespace_aa27450a::function_962dc2e9(2);
            if (var_96ebfa18) {
                var_c96f65f1 = 0;
            }
            if (level flag::get("ee_boss_defeated")) {
                return;
            }
        }
        if (var_c96f65f1) {
            for (i = 1; i < 5; i++) {
                var_d7e2a718 = function_d93f551b(i);
                var_91341fca = "ee_keeper_" + var_d7e2a718 + "_state";
                level clientfield::set(var_91341fca, 4);
                level flag::set("ee_keeper_" + var_d7e2a718 + "_armed");
                wait(0.1);
            }
            return;
        }
        wait(0.1);
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_db8d1f6e
// Checksum 0xccf12d37, Offset: 0x2900
// Size: 0x288
function function_db8d1f6e() {
    var_e0e332eb = getent("mdl_god_far", "targetname");
    var_bd7c800e = getent("mdl_god_near", "targetname");
    var_e0e332eb clientfield::set("far_apothigod_active", 0);
    var_bd7c800e clientfield::set("near_apothigod_active", 1);
    var_e0e332eb hide();
    var_bd7c800e show();
    function_c3466d96(1);
    wait(15);
    level clientfield::set("ee_superworm_state", 3);
    level thread function_43750b40();
    level.var_1f6ca9c8 = 1;
    level.var_1a1d4400 = 1;
    level.var_a6e16eb2 = 4;
    level thread namespace_331b1e91::function_6ceb834f();
    level thread function_13d06927();
    namespace_215602b6::function_fd8fb00d(1);
    level clientfield::set("bm_superbeast", 1);
    namespace_81256d2f::function_be2abe();
    level thread function_4778e04();
    level thread function_821065e6();
    level thread function_729859d0();
    level thread function_2c9861b9();
    level thread function_533399b1();
    level flag::wait_till("ee_final_boss_defeated");
    function_c3466d96(0);
    cleanup_ai();
    level.var_1f6ca9c8 = 0;
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_43750b40
// Checksum 0xee2c7c7f, Offset: 0x2b90
// Size: 0x94
function function_43750b40() {
    level endon(#"end_game");
    level.musicsystemoverride = 1;
    music::setmusicstate("zod_ee_apothifight");
    level flag::wait_till("ee_final_boss_defeated");
    music::setmusicstate("none");
    level.musicsystemoverride = 0;
    level zm_audio::sndmusicsystem_playstate("zod_endigc_lullaby");
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_13d06927
// Checksum 0x92d098a4, Offset: 0x2c30
// Size: 0x74
function function_13d06927() {
    level.disable_nuke_delay_spawning = 1;
    level notify(#"disable_nuke_delay_spawning");
    level flag::clear("spawn_zombies");
    function_5db6ba34();
    level thread function_3fe90552();
    function_986f2374();
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_4778e04
// Checksum 0xfec0a48f, Offset: 0x2cb0
// Size: 0xf2
function function_4778e04() {
    while (level flag::get("ee_final_boss_defeated") === 0) {
        flag::wait_till_clear("ee_final_boss_staggered");
        playsoundatposition("zmb_zod_apothigod_vox_warn_attack", (0, 0, 0));
        var_bd7c800e = getent("mdl_god_near", "targetname");
        var_bd7c800e clientfield::increment("near_apothigod_roar");
        function_224a2f3e();
        var_88a57214 = randomfloatrange(30, 45);
        wait(var_88a57214);
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_224a2f3e
// Checksum 0x83c29ae4, Offset: 0x2db0
// Size: 0x2d4
function function_224a2f3e() {
    level endon(#"hash_f9b93501");
    if (level flag::get("ee_final_boss_beam_active")) {
        return;
    }
    if (level flag::get("ee_final_boss_midattack")) {
        return;
    }
    level flag::set("ee_final_boss_midattack");
    level clientfield::set("ee_final_boss_shields", 1);
    foreach (player in level.activeplayers) {
        if (isdefined(zm_utility::is_player_valid(player, 0, 0)) && zm_utility::is_player_valid(player, 0, 0)) {
            level thread function_5334c072(player);
        }
    }
    wait(15);
    level notify(#"hash_b1c56287");
    level clientfield::set("ee_final_boss_shields", 0);
    foreach (player in level.activeplayers) {
        if (isdefined(player.var_884d1375) && isdefined(zm_utility::is_player_valid(player)) && zm_utility::is_player_valid(player) && player.var_884d1375) {
            player thread namespace_8e578893::function_6edf48d5(6);
            player dodamage(player.health * 666, player.origin);
            player clientfield::set_to_player("ee_final_boss_attack_tell", 0);
        }
    }
    level flag::clear("ee_final_boss_midattack");
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_5334c072
// Checksum 0xc3f6b274, Offset: 0x3090
// Size: 0x1d8
function function_5334c072(player) {
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"bled_out");
    level endon(#"hash_f9b93501");
    player.var_884d1375 = 1;
    player clientfield::set_to_player("ee_final_boss_attack_tell", 1);
    var_dcd4f61a = struct::get_array("final_boss_safepoint", "targetname");
    while (true) {
        player.var_884d1375 = 1;
        foreach (var_495730fe in var_dcd4f61a) {
            v_player_origin = player getorigin();
            var_e468ad3 = var_495730fe.origin;
            if (isdefined(v_player_origin)) {
                var_30c97f9b = distancesquared(var_e468ad3, v_player_origin);
                if (var_30c97f9b <= 9216) {
                    function_a8621648(player, 1);
                    return;
                }
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_a8621648
// Checksum 0x3abcf0dc, Offset: 0x3270
// Size: 0xbc
function function_a8621648(player, var_67e5f9c0) {
    if (!isdefined(var_67e5f9c0)) {
        var_67e5f9c0 = 1;
    }
    player.var_884d1375 = 0;
    player namespace_8e578893::function_6edf48d5(0);
    player clientfield::set_to_player("ee_final_boss_attack_tell", 0);
    if (var_67e5f9c0) {
        level thread lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_3fe90552
// Checksum 0x3e012a5f, Offset: 0x3338
// Size: 0x1c
function function_3fe90552() {
    level thread function_9b59ab6();
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_9b59ab6
// Checksum 0x9681ae8d, Offset: 0x3360
// Size: 0xc0
function function_9b59ab6() {
    level endon(#"hash_53e673b7");
    while (true) {
        while (!function_c7c3f7b5(level.var_a6e16eb2)) {
            wait(1);
        }
        var_225347e1 = namespace_d17e1da0::function_8bcb72e9(0);
        if (isdefined(var_225347e1)) {
            var_225347e1.no_powerups = 1;
            var_225347e1 clientfield::set("supermargwa", 1);
            level thread function_91b5dbe8(var_225347e1);
        }
        wait(9);
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x0
// namespace_ba13c715<file_0>::function_91c4dc69
// Checksum 0xdf78df64, Offset: 0x3428
// Size: 0x340
function function_91c4dc69() {
    level endon(#"hash_53e673b7");
    zombie_utility::ai_calculate_health(level.round_number);
    wait(3);
    while (true) {
        for (var_565450eb = zombie_utility::get_current_zombie_count(); var_565450eb >= 10 || var_565450eb >= level.players.size * 5; var_565450eb = zombie_utility::get_current_zombie_count()) {
            wait(randomfloatrange(2, 4));
        }
        while (zombie_utility::get_current_actor_count() >= level.zombie_actor_limit) {
            zombie_utility::clear_all_corpses();
            wait(0.1);
        }
        zm::run_custom_ai_spawn_checks();
        if (isdefined(level.zombie_spawners)) {
            if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
                if (isdefined(level.zombie_spawn[level.spawner_int].size) && isdefined(level.spawner_int) && level.zombie_spawn[level.spawner_int].size) {
                    spawner = array::random(level.zombie_spawn[level.spawner_int]);
                } else {
                    spawner = array::random(level.zombie_spawners);
                }
            } else {
                spawner = array::random(level.zombie_spawners);
            }
            ai = zombie_utility::spawn_zombie(spawner, spawner.targetname);
        }
        if (isdefined(ai)) {
            ai.no_powerups = 1;
            ai.deathpoints_already_given = 1;
            ai.var_8ac75273 = 1;
            ai.exclude_cleanup_adding_to_total = 1;
            if (ai.zombie_move_speed === "walk") {
                ai zombie_utility::set_zombie_run_cycle("run");
            }
            find_flesh_struct_string = "find_flesh";
            ai notify(#"zombie_custom_think_done", find_flesh_struct_string);
            ai ai::set_behavior_attribute("can_juke", 0);
            if (level.zombie_respawns > 0 && level.zombie_vars["zombie_spawn_delay"] > 1) {
                wait(1);
            } else {
                wait(level.zombie_vars["zombie_spawn_delay"]);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_91b5dbe8
// Checksum 0x182e61d3, Offset: 0x3770
// Size: 0x6c
function function_91b5dbe8(var_225347e1) {
    level endon(#"hash_53e673b7");
    var_225347e1 waittill(#"death");
    v_origin = var_225347e1.origin;
    namespace_215602b6::function_f6014f2c(v_origin, 3);
    function_224a2f3e();
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_986f2374
// Checksum 0x7df950eb, Offset: 0x37e8
// Size: 0x11c
function function_986f2374() {
    switch (level.var_1a1d4400) {
    case 0:
        var_87154e15 = 0;
        level.var_a6e16eb2 = 0;
        break;
    case 1:
        var_87154e15 = 1;
        level.var_a6e16eb2 = 4;
        break;
    case 2:
        var_87154e15 = 0.75;
        level.var_a6e16eb2 = 4;
        break;
    case 3:
        var_87154e15 = 0.5;
        level.var_a6e16eb2 = 4;
        break;
    }
    var_c9a88def = struct::get_array("cursetrap_point", "targetname");
    var_96b4af2e = int(var_c9a88def.size * var_87154e15);
    level thread namespace_331b1e91::function_f38a6a2a(var_96b4af2e);
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_821065e6
// Checksum 0xef2326c9, Offset: 0x3910
// Size: 0x46
function function_821065e6() {
    for (i = 1; i < 4; i++) {
        level thread function_3bd22f9e(i);
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_3bd22f9e
// Checksum 0xafede7bf, Offset: 0x3960
// Size: 0x128
function function_3bd22f9e(var_9a8bfa33) {
    level endon(#"hash_53e673b7");
    level endon(#"hash_f9b93501");
    var_5dab4912 = "ee_district_rail_electrified_" + var_9a8bfa33;
    var_9440a97c = getent(var_5dab4912, "targetname");
    var_a5fd6c97 = getent(var_9440a97c.target, "targetname");
    var_a5fd6c97 thread namespace_215602b6::function_c5c7aef3(var_9440a97c);
    level flag::clear(var_5dab4912);
    var_a5fd6c97 clientfield::set("ee_rail_electricity_state", 0);
    while (true) {
        e_triggerer = var_9440a97c waittill(#"trigger");
        function_d3b3eb03(var_9a8bfa33);
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_d3b3eb03
// Checksum 0x8f37320, Offset: 0x3a90
// Size: 0x12c
function function_d3b3eb03(var_9a8bfa33) {
    var_5dab4912 = "ee_district_rail_electrified_" + var_9a8bfa33;
    var_9440a97c = getent(var_5dab4912, "targetname");
    var_a5fd6c97 = getent(var_9440a97c.target, "targetname");
    level flag::set(var_5dab4912);
    var_a5fd6c97 clientfield::set("ee_rail_electricity_state", 1);
    function_61d12305(var_9a8bfa33, 1);
    wait(30);
    function_61d12305(var_9a8bfa33, 0);
    var_a5fd6c97 clientfield::set("ee_rail_electricity_state", 0);
    level flag::clear(var_5dab4912);
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_61d12305
// Checksum 0x8f99b0c, Offset: 0x3bc8
// Size: 0x94
function function_61d12305(var_9a8bfa33, b_on) {
    function_93ea4183(var_9a8bfa33, b_on);
    str_scenename = function_2589b4ad(var_9a8bfa33);
    if (b_on) {
        level thread scene::play(str_scenename);
        return;
    }
    level thread scene::stop(str_scenename);
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_2589b4ad
// Checksum 0x12487ce5, Offset: 0x3c68
// Size: 0x4e
function function_2589b4ad(var_9a8bfa33) {
    switch (var_9a8bfa33) {
    case 1:
        return "p7_fxanim_zm_zod_train_rail_spark_canal_bundle";
    case 2:
        return "p7_fxanim_zm_zod_train_rail_spark_waterfront_bundle";
    case 3:
        return "p7_fxanim_zm_zod_train_rail_spark_footlight_bundle";
    }
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_93ea4183
// Checksum 0xeb26015, Offset: 0x3cc0
// Size: 0xa4
function function_93ea4183(var_9a8bfa33, b_on) {
    if (b_on) {
        showmiscmodels("train_rail_glow_" + var_9a8bfa33);
        hidemiscmodels("train_rail_wet_" + var_9a8bfa33);
        return;
    }
    showmiscmodels("train_rail_wet_" + var_9a8bfa33);
    hidemiscmodels("train_rail_glow_" + var_9a8bfa33);
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_378c2b96
// Checksum 0x3c74b126, Offset: 0x3d70
// Size: 0x76
function function_378c2b96() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        e_player = players[i];
        e_player zm::spectator_respawn_player();
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_729859d0
// Checksum 0xd48ea130, Offset: 0x3df0
// Size: 0x188
function function_729859d0() {
    level endon(#"hash_53e673b7");
    level flag::set("ee_superworm_present");
    while (true) {
        level.var_292a0ac9 flag::wait_till("moving");
        function_f09f9721();
        level thread function_378c2b96();
        if (level flag::get("ee_final_boss_beam_active") === 0) {
            level thread function_c898ab1();
            var_7f207012 = [[ level.var_292a0ac9 ]]->function_be4c98a3();
            foreach (var_813273c3 in var_7f207012) {
                var_813273c3 thread namespace_8e578893::function_6edf48d5(6, 1);
            }
        }
        level.var_292a0ac9 flag::wait_till_clear("moving");
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_2c9861b9
// Checksum 0x9ba2f9c3, Offset: 0x3f80
// Size: 0x46
function function_2c9861b9() {
    for (i = 0; i < 3; i++) {
        level thread function_f30f87e4(i);
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_f30f87e4
// Checksum 0x9b7d470a, Offset: 0x3fd0
// Size: 0x1e8
function function_f30f87e4(n_index) {
    level notify("ee_final_boss_keeper_electricity_watcher_" + n_index);
    level endon("ee_final_boss_keeper_electricity_watcher_" + n_index);
    level endon(#"hash_53e673b7");
    var_da3dbbdf = level.var_76c101df[n_index];
    var_da3dbbdf endon(#"delete");
    var_da3dbbdf solid();
    var_da3dbbdf setcandamage(1);
    var_da3dbbdf.health = 1000000;
    while (true) {
        amount, attacker, direction, point, mod, tagname, modelname, partname, weapon = var_da3dbbdf waittill(#"damage");
        var_da3dbbdf.health = 1000000;
        if (namespace_215602b6::function_4c03fac9(weapon) && isdefined(attacker) && amount > 0) {
            if (isdefined(attacker)) {
                attacker notify(#"hash_e22dab6d");
            }
            level thread function_6774c6fd(var_da3dbbdf);
            level flag::set("ee_final_boss_keeper_electricity_" + n_index);
            wait(5);
            level flag::clear("ee_final_boss_keeper_electricity_" + n_index);
        }
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_6774c6fd
// Checksum 0xbd0bc072, Offset: 0x41c0
// Size: 0x12c
function function_6774c6fd(var_da3dbbdf) {
    fx_ent = spawn("script_model", var_da3dbbdf.origin);
    fx_ent setmodel("tag_origin");
    fx_ent.angles = var_da3dbbdf.angles;
    playfxontag(level._effect["ee_quest_keeper_shocked"], fx_ent, "tag_origin");
    fx_ent playsound("zmb_zod_keeper_charge_up");
    fx_ent playloopsound("zmb_zod_keeper_charge_lp", 1);
    wait(5);
    fx_ent playsound("zmb_zod_keeper_charge_down");
    fx_ent delete();
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_c898ab1
// Checksum 0x4e36f343, Offset: 0x42f8
// Size: 0x13c
function function_c898ab1(var_a5322c01) {
    level notify(#"hash_c898ab1");
    level endon(#"hash_c898ab1");
    level clientfield::set("ee_superworm_state", 2);
    var_a9f994a9 = struct::get("ee_apothigod_gateworm_junction", "targetname");
    earthquake(0.25, 0.3, var_a9f994a9.origin, -106);
    level flag::clear("ee_superworm_present");
    wait(10);
    while (level flag::get("ee_final_boss_staggered")) {
        wait(0.1);
    }
    level clientfield::set("ee_superworm_state", 3);
    level flag::set("ee_superworm_present");
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_f09f9721
// Checksum 0x12318414, Offset: 0x4440
// Size: 0x124
function function_f09f9721() {
    level endon(#"hash_c898ab1");
    var_4843dc70 = [[ level.var_292a0ac9 ]]->function_8cf8e3a5();
    var_a9f994a9 = struct::get("ee_apothigod_gateworm_junction", "targetname");
    var_c7d3f5b3 = [[ level.var_292a0ac9 ]]->function_ae26c4a8();
    switch (var_c7d3f5b3) {
    case 94:
        dist2 = 262144;
        break;
    case 95:
        dist2 = 262144;
        break;
    case 93:
        dist2 = 262144;
        break;
    }
    while (true) {
        if (distance2dsquared(var_4843dc70.origin, var_a9f994a9.origin) <= dist2) {
            return;
        }
        wait(0.1);
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_c5f8b004
// Checksum 0xa6c0a53a, Offset: 0x4570
// Size: 0x8e
function function_c5f8b004(var_67e5f9c0) {
    if (!isdefined(var_67e5f9c0)) {
        var_67e5f9c0 = 1;
    }
    players = level.activeplayers;
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i])) {
            function_a8621648(players[i], var_67e5f9c0);
        }
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_533399b1
// Checksum 0x7110bc46, Offset: 0x4608
// Size: 0x378
function function_533399b1() {
    while (level flag::get("ee_final_boss_defeated") === 0) {
        var_b4813f3d = array("ee_district_rail_electrified_1", "ee_district_rail_electrified_2", "ee_district_rail_electrified_3", "ee_final_boss_keeper_electricity_0", "ee_final_boss_keeper_electricity_1", "ee_final_boss_keeper_electricity_2");
        level flag::wait_till_all(var_b4813f3d);
        function_61d12305(4, 1);
        level flag::set("ee_final_boss_beam_active");
        if (level flag::get("ee_superworm_present")) {
            level clientfield::set("ee_keeper_beam_state", 1);
            level clientfield::set("ee_superworm_state", 4);
        } else {
            level flag::set("ee_final_boss_staggered");
            function_c5f8b004(1);
            level clientfield::set("rain_state", 1);
            level thread function_19076f5e();
            cleanup_ai();
            level notify(#"hash_c0150ce6");
            level clientfield::set("ee_keeper_beam_state", 2);
            level.var_1a1d4400--;
        }
        if (level.var_1a1d4400 === 0) {
            level flag::set("ee_final_boss_defeated");
        } else {
            players = level.activeplayers;
            foreach (player in players) {
                player thread function_d26c80f1();
            }
            wait(9);
            level clientfield::set("ee_keeper_beam_state", 0);
            level flag::clear("ee_final_boss_beam_active");
            function_986f2374();
            level thread function_821065e6();
        }
        function_61d12305(4, 0);
        level clientfield::set("rain_state", 0);
        level flag::clear("ee_final_boss_staggered");
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_19076f5e
// Checksum 0xe4226b95, Offset: 0x4988
// Size: 0xa4
function function_19076f5e() {
    if (level.var_1a1d4400 == 3) {
        alias = "zmb_zod_beam_fire_success_1";
    } else if (level.var_1a1d4400 == 2) {
        alias = "zmb_zod_beam_fire_success_2";
    } else if (level.var_1a1d4400 == 1) {
        alias = "zmb_zod_beam_fire_success_3";
        level clientfield::set("sndEndIGC", 1);
    }
    playsoundatposition(alias, (0, 0, 0));
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_d26c80f1
// Checksum 0x16c6edfc, Offset: 0x4a38
// Size: 0x94
function function_d26c80f1() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"bled_out");
    self namespace_8e578893::function_6edf48d5(5);
    earthquake(0.333, 7, self.origin, 1000);
    wait(7);
    if (!isdefined(self)) {
        return;
    }
    self namespace_8e578893::function_6edf48d5(6);
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x0
// namespace_ba13c715<file_0>::function_3f5c6609
// Checksum 0x62ba4c26, Offset: 0x4ad8
// Size: 0xb2
function function_3f5c6609() {
    while (true) {
        players = level.activeplayers;
        foreach (player in players) {
            if (player.origin.z > 0) {
                return;
            }
        }
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_6f8c2ea3
// Checksum 0x446cd05, Offset: 0x4b98
// Size: 0x438
function function_6f8c2ea3() {
    scene::init("cin_zod_vign_summoning_key");
    level clientfield::set("ee_quest_state", 4);
    namespace_b8707f8e::function_218256bd(1);
    scene::add_scene_func("cin_zod_vign_summoning_key", &function_e186ed49);
    level thread namespace_331b1e91::function_f38a6a2a(0);
    level notify(#"hash_223edfde");
    function_c5f8b004(0);
    level clientfield::set("ee_final_boss_shields", 0);
    level notify(#"hash_c898ab1");
    level clientfield::set("ee_superworm_state", 0);
    level flag::clear("spawn_zombies");
    function_5db6ba34();
    cleanup_ai(1);
    wait(5);
    foreach (player in level.activeplayers) {
        player namespace_215602b6::function_bd84f46(1);
        player.play_scene_transition_effect = 1;
    }
    wait(2);
    var_bd7c800e = getent("mdl_god_near", "targetname");
    var_bd7c800e clientfield::increment("apothigod_death");
    level clientfield::set("portal_state_ending", 1);
    scene::play("cin_zod_vign_summoning_key");
    level clientfield::set("portal_state_ending", 0);
    level clientfield::set("sndEndIGC", 0);
    function_5091df99();
    level clientfield::set("bm_superbeast", 0);
    level clientfield::set("ee_keeper_beam_state", 0);
    level flag::clear("ee_final_boss_beam_active");
    namespace_215602b6::function_fd8fb00d(0);
    wait(15);
    foreach (player in level.players) {
        player zm_stats::increment_challenge_stat("DARKOPS_ZOD_EE");
        player zm_stats::increment_challenge_stat("DARKOPS_ZOD_SUPER_EE");
    }
    namespace_b8707f8e::function_218256bd(0);
    level flag::set("spawn_zombies");
    level.disable_nuke_delay_spawning = 0;
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_e186ed49
// Checksum 0xcf85fdb3, Offset: 0x4fd8
// Size: 0x1ac
function function_e186ed49(a_ents) {
    a_ents["archon"] waittill(#"start_fade");
    level thread lui::screen_flash(1, 1.5, 0.5, 1, "white");
    playsoundatposition("zmb_zod_endigc_whitescreen", (0, 0, 0));
    wait(1);
    for (i = 1; i < 5; i++) {
        var_d7e2a718 = function_d93f551b(i);
        var_91341fca = "ee_keeper_" + var_d7e2a718 + "_state";
        level clientfield::set(var_91341fca, 0);
    }
    level clientfield::set("ee_keeper_beam_state", 0);
    a_ents["archon"] waittill(#"start_fade");
    level thread lui::screen_flash(0.5, 1, 0.5, 1, "black");
    level flag::set("ee_complete");
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_5091df99
// Checksum 0xe5959e1d, Offset: 0x5190
// Size: 0x106
function function_5091df99() {
    if (level.players.size <= 1) {
        return;
    }
    a_spots = [];
    for (i = 0; i < level.players.size; i++) {
        a_spots[i] = struct::get("ending_igc_exit_" + i);
        level.players[i] setorigin(a_spots[i].origin);
        if (isdefined(a_spots[i].angles)) {
            level.players[i] setplayerangles(a_spots[i].angles);
        }
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_e6341733
// Checksum 0x46eec941, Offset: 0x52a0
// Size: 0x19c
function function_e6341733(s_loc) {
    width = -128;
    height = -128;
    length = -128;
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = width;
    s_loc.unitrigger_stub.script_height = height;
    s_loc.unitrigger_stub.script_length = length;
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_19cf5463;
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_e30b3505);
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_19cf5463
// Checksum 0x360ec0fd, Offset: 0x5448
// Size: 0x7a
function function_19cf5463(player) {
    b_is_invis = isdefined(player.beastmode) && player.beastmode || level flag::get("ee_book");
    self setinvisibletoplayer(player, b_is_invis);
    return !b_is_invis;
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_e30b3505
// Checksum 0xcdbb1b49, Offset: 0x54d0
// Size: 0xa4
function function_e30b3505() {
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
        level thread function_bddd53dc(self.stub, player);
        break;
    }
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_bddd53dc
// Checksum 0xe32550c2, Offset: 0x5580
// Size: 0x1e4
function function_bddd53dc(var_91089b66, player) {
    /#
        iprintlnbold("ee_keeper_magician_state");
    #/
    e_book = getent("ee_book", "targetname");
    e_book moveto(e_book.origin + (0, 0, 48), 3, 1, 1);
    wait(3);
    playfxontag(level._effect["ee_quest_book_mist"], e_book, "tag_origin");
    e_book playsound("zmb_ee_main_book_aflame");
    e_book playloopsound("zmb_ee_main_book_aflame_lp", 1);
    level flag::set("ee_book");
    level clientfield::set("ee_keeper_boxer_state", 1);
    level clientfield::set("ee_keeper_detective_state", 1);
    level clientfield::set("ee_keeper_femme_state", 1);
    level clientfield::set("ee_keeper_magician_state", 1);
    level thread function_f75d6374();
    var_91089b66 zm_unitrigger::run_visibility_function_for_all_triggers();
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_f75d6374
// Checksum 0xb230d123, Offset: 0x5770
// Size: 0x2ae
function function_f75d6374() {
    var_f59a8cd1 = getent("ee_totem_hanging", "targetname");
    s_loc = struct::get("ee_totem_landed_position", "targetname");
    var_f59a8cd1 moveto(s_loc.origin, 3, 1, 1);
    wait(3);
    level clientfield::set("ee_totem_state", 1);
    var_f59a8cd1 clientfield::set("totem_state_fx", 1);
    width = -128;
    height = -128;
    length = -128;
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = width;
    s_loc.unitrigger_stub.script_height = height;
    s_loc.unitrigger_stub.script_length = length;
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_6bd33d28;
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_f3d23e2c);
    if (!isdefined(level.var_f86952c7)) {
        level.var_f86952c7 = [];
    }
    level.var_f86952c7["totem_landed"] = s_loc.unitrigger_stub;
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_6bd33d28
// Checksum 0xb9bbb86b, Offset: 0x5a28
// Size: 0x132
function function_6bd33d28(player) {
    var_14123bd0 = self.stub.origin;
    var_a18af120 = 0;
    var_39ec9ec2 = level clientfield::get("ee_quest_state");
    if (var_39ec9ec2 == 0) {
        var_a18af120 = 1;
    }
    var_ec277adf = 0;
    var_fa9b3019 = level clientfield::get("ee_totem_state");
    if (var_fa9b3019 == 1) {
        var_ec277adf = 1;
    }
    b_is_invis = isdefined(player.beastmode) && player.beastmode || !var_a18af120 || !var_ec277adf;
    self setinvisibletoplayer(player, b_is_invis);
    return !b_is_invis;
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_f3d23e2c
// Checksum 0x8bd99bb2, Offset: 0x5b68
// Size: 0xcc
function function_f3d23e2c() {
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
        level function_e525a12(0);
        level function_ce4db8c8(player);
        self.stub zm_unitrigger::run_visibility_function_for_all_triggers();
        break;
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_e525a12
// Checksum 0x868f5f4f, Offset: 0x5c40
// Size: 0xac
function function_e525a12(b_show) {
    var_f59a8cd1 = getent("ee_totem_hanging", "targetname");
    if (b_show) {
        var_f59a8cd1 show();
        var_f59a8cd1 clientfield::set("totem_state_fx", 1);
        return;
    }
    var_f59a8cd1 ghost();
    var_f59a8cd1 clientfield::set("totem_state_fx", 0);
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_9190a90e
// Checksum 0xcd5b89e9, Offset: 0x5cf8
// Size: 0x208
function function_9190a90e(n_char_index) {
    var_d7e2a718 = function_d93f551b(n_char_index);
    var_d72a94c2 = "keeper_resurrection_" + var_d7e2a718;
    var_e6e52f57 = getent(var_d72a94c2, "targetname");
    while (true) {
        player = var_e6e52f57 waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        if (isdefined(player.beastmode) && player.beastmode) {
            continue;
        }
        var_39ec9ec2 = level clientfield::get("ee_quest_state");
        var_a18af120 = var_39ec9ec2 == 0;
        if (!var_a18af120) {
            continue;
        }
        if (!isdefined(player.var_11104075)) {
            continue;
        }
        var_fa9b3019 = level clientfield::get("ee_totem_state");
        var_27b0f0e4 = level clientfield::get("ee_keeper_" + var_d7e2a718 + "_state");
        if (var_27b0f0e4 == 1 && var_fa9b3019 == 3) {
            function_b54f7960(player, n_char_index);
        }
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_d93f551b
// Checksum 0xc8a99c95, Offset: 0x5f08
// Size: 0x5e
function function_d93f551b(n_char_index) {
    switch (n_char_index) {
    case 1:
        return "boxer";
    case 2:
        return "detective";
    case 3:
        return "femme";
    case 4:
        return "magician";
    }
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_b54f7960
// Checksum 0x66cc7fc4, Offset: 0x5f70
// Size: 0x244
function function_b54f7960(player, n_char_index) {
    players = level.activeplayers;
    foreach (player in players) {
        if (isdefined(player.var_11104075)) {
            player.var_11104075 delete();
        }
    }
    var_d7e2a718 = function_d93f551b(n_char_index);
    level clientfield::set("ee_keeper_" + var_d7e2a718 + "_state", 2);
    player playsound("zmb_zod_totem_place");
    wait(5);
    level function_8f4b6b20(n_char_index);
    foreach (var_b9caebb1 in level.var_dc1b8d40) {
        arrayremovevalue(level.var_b94f6d7a, var_b9caebb1);
    }
    wait(5);
    s_loc = struct::get("defend_area_" + var_d7e2a718);
    level thread zm_powerups::specific_powerup_drop("full_ammo", s_loc.origin);
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x0
// namespace_ba13c715<file_0>::function_6032557b
// Checksum 0xbb25db10, Offset: 0x61c0
// Size: 0xbc
function function_6032557b(player, var_91089b66) {
    if (isdefined(var_91089b66.mdl_totem)) {
        var_91089b66.mdl_totem clientfield::set("totem_damage_fx", 0);
        var_91089b66.mdl_totem delete();
    }
    level flag::clear("totem_placed");
    level notify(#"hash_26f14b55");
    level.var_6e3c8a77 = undefined;
    level thread function_ce4db8c8(player);
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_6f0edfa1
// Checksum 0x8010185b, Offset: 0x6288
// Size: 0x15c
function function_6f0edfa1() {
    players = level.activeplayers;
    foreach (player in players) {
        if (isdefined(player.var_11104075)) {
            player.var_11104075 delete();
        }
    }
    function_fe26340b();
    level flag::clear("totem_placed");
    level clientfield::set("ee_totem_state", 0);
    level.var_f47099f2 = 0;
    level thread namespace_331b1e91::function_f38a6a2a(0);
    level thread cleanup_ai(0, 1);
    level thread namespace_331b1e91::function_e48af0db();
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_3089f820
// Checksum 0x12a3f8f, Offset: 0x63f0
// Size: 0x1ac
function function_3089f820(var_ee1ff130) {
    if (level flag::get("totem_placed") === 0) {
        return;
    }
    level notify(#"hash_511572b6");
    level.var_dc1b8d40 = [];
    level function_6f0edfa1();
    if (isdefined(var_ee1ff130)) {
        str_name = function_d93f551b(var_ee1ff130);
        level clientfield::set("ee_keeper_" + str_name + "_state", 1);
    }
    players = level.activeplayers;
    foreach (player in players) {
        if (isdefined(player.var_11104075)) {
            player.var_11104075 delete();
        }
    }
    level function_e525a12(1);
    level clientfield::set("ee_totem_state", 1);
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_5d546ced
// Checksum 0xb2f72bb8, Offset: 0x65a8
// Size: 0xcc
function function_5d546ced(var_ee1ff130) {
    level notify(#"hash_511572b6");
    level.var_dc1b8d40 = [];
    level function_6f0edfa1();
    if (isdefined(var_ee1ff130)) {
        str_name = function_d93f551b(var_ee1ff130);
        level clientfield::set("ee_keeper_" + str_name + "_state", 1);
    }
    level function_e525a12(1);
    level clientfield::set("ee_totem_state", 1);
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_8f4b6b20
// Checksum 0x6cab457f, Offset: 0x6680
// Size: 0x17c
function function_8f4b6b20(var_ee1ff130, var_dcdf1cd5) {
    if (!isdefined(var_dcdf1cd5)) {
        var_dcdf1cd5 = 0;
    }
    level function_6f0edfa1();
    level notify(#"hash_8a22b2ff");
    var_d7e2a718 = function_d93f551b(var_ee1ff130);
    level clientfield::set("ee_keeper_" + var_d7e2a718 + "_state", 3);
    level flag::set("ee_keeper_" + var_d7e2a718 + "_resurrected");
    if (var_dcdf1cd5) {
        level function_e525a12(0);
        level clientfield::set("ee_totem_state", 0);
        return;
    }
    wait(5);
    namespace_d17e1da0::function_8bcb72e9(1);
    if (function_832f1b2a() < 4) {
        level thread function_e6dd2eaf();
        return;
    }
    level.var_f47099f2 = 0;
    level.var_e59fb2 = function_e4f61654();
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_e6dd2eaf
// Checksum 0xbf54b527, Offset: 0x6808
// Size: 0x4c
function function_e6dd2eaf() {
    level waittill(#"start_of_round");
    level function_e525a12(1);
    level clientfield::set("ee_totem_state", 1);
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_676d671
// Checksum 0xd7c1891, Offset: 0x6860
// Size: 0x272
function function_676d671(n_char_index) {
    width = -128;
    height = -128;
    length = -128;
    var_d7e2a718 = function_d93f551b(n_char_index);
    s_loc = struct::get("ee_keeper_8_" + n_char_index - 1, "targetname");
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = width;
    s_loc.unitrigger_stub.script_height = height;
    s_loc.unitrigger_stub.script_length = length;
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.n_char_index = n_char_index;
    s_loc.unitrigger_stub.var_d7e2a718 = var_d7e2a718;
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_9207a201;
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_5eae8cbb);
    if (!isdefined(level.var_f86952c7)) {
        level.var_f86952c7 = [];
    }
    level.var_f86952c7["boss_1_" + var_d7e2a718] = s_loc.unitrigger_stub;
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_9207a201
// Checksum 0xefbbaeeb, Offset: 0x6ae0
// Size: 0x1c2
function function_9207a201(player) {
    var_91341fca = "ee_keeper_" + self.stub.var_d7e2a718 + "_state";
    var_fe2fb4b9 = level clientfield::get(var_91341fca);
    var_a18af120 = 0;
    var_39ec9ec2 = level clientfield::get("ee_quest_state");
    if (var_39ec9ec2 == 1) {
        var_a18af120 = 1;
    }
    var_96ebfa18 = player namespace_aa27450a::function_962dc2e9(2);
    var_c7fc450f = 0;
    if (var_fe2fb4b9 === 3 && var_96ebfa18) {
        var_c7fc450f = 1;
    } else if (var_fe2fb4b9 === 6) {
        var_c7fc450f = 1;
    }
    var_a315b31f = level clientfield::get("bm_superbeast");
    b_is_invis = isdefined(player.beastmode) && player.beastmode && !var_a315b31f || !var_a18af120 || !var_c7fc450f;
    self setinvisibletoplayer(player, b_is_invis);
    return !b_is_invis;
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_5eae8cbb
// Checksum 0x27558ac1, Offset: 0x6cb0
// Size: 0x1ec
function function_5eae8cbb() {
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
        var_27b0f0e4 = level clientfield::get("ee_keeper_" + self.stub.var_d7e2a718 + "_state");
        if (var_27b0f0e4 === 3) {
            player namespace_aa27450a::function_c6e90f6e();
            level clientfield::set("ee_keeper_" + self.stub.var_d7e2a718 + "_state", 4);
            level flag::set("ee_keeper_" + self.stub.var_d7e2a718 + "_armed");
        } else if (var_27b0f0e4 === 6) {
            level clientfield::set("ee_keeper_" + self.stub.var_d7e2a718 + "_state", 4);
            level flag::set("ee_keeper_" + self.stub.var_d7e2a718 + "_armed");
        }
        self.stub zm_unitrigger::run_visibility_function_for_all_triggers();
        break;
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_4bcb6826
// Checksum 0xef06b011, Offset: 0x6ea8
// Size: 0x4c8
function function_4bcb6826() {
    level endon(#"hash_fbc505ba");
    var_9eb45ed3 = array("boxer", "detective", "femme", "magician");
    level.var_df5409ea = 9;
    while (true) {
        var_a74ccb30 = 1;
        foreach (var_d7e2a718 in var_9eb45ed3) {
            var_587a4446 = level clientfield::get("ee_keeper_" + var_d7e2a718 + "_state");
            if (var_587a4446 !== 4) {
                var_a74ccb30 = 0;
            }
        }
        if (!var_a74ccb30) {
            wait(0.1);
            continue;
        }
        wait(3);
        foreach (var_d7e2a718 in var_9eb45ed3) {
            level clientfield::set("ee_keeper_" + var_d7e2a718 + "_state", 5);
        }
        level.var_dbc3a0ef.var_93dad597 playsound("zmb_zod_shadfight_shield_down");
        wait(3);
        level.var_dbc3a0ef.var_93dad597 clientfield::set("boss_shield_fx", 0);
        level flag::set("ee_boss_vulnerable");
        var_e6fb7eb3 = randomintrange(0, 4);
        function_e59c5246(var_e6fb7eb3);
        level thread function_c188d0b0();
        wait(level.var_df5409ea);
        level flag::clear("ee_boss_vulnerable");
        level.var_dbc3a0ef.var_93dad597 clientfield::set("boss_shield_fx", 1);
        level notify(#"hash_b6c7fd80");
        level.var_dbc3a0ef.n_script_int = 0;
        a_s_spawnpoints = struct::get_array("ee_shadowman_8", "targetname");
        a_s_spawnpoints = array::filter(a_s_spawnpoints, 0, &namespace_331b1e91::function_726d4cc4, 0);
        level.var_dbc3a0ef.s_spawnpoint = a_s_spawnpoints[0];
        namespace_331b1e91::function_284b1884(level.var_dbc3a0ef, level.var_dbc3a0ef.s_spawnpoint, 0.1);
        level.var_dbc3a0ef namespace_331b1e91::function_a3821eb5(0.1, 4);
        foreach (var_d7e2a718 in var_9eb45ed3) {
            level clientfield::set("ee_keeper_" + var_d7e2a718 + "_state", 6);
        }
        level.var_df5409ea += 2;
        level.var_dbc3a0ef thread namespace_331b1e91::function_b6c7fd80();
        namespace_d17e1da0::function_8bcb72e9(1);
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_c188d0b0
// Checksum 0xdb778096, Offset: 0x7378
// Size: 0x54
function function_c188d0b0() {
    wait(level.var_df5409ea - 3);
    if (isdefined(level.var_dbc3a0ef.var_93dad597)) {
        level.var_dbc3a0ef.var_93dad597 playsound("zmb_zod_shadfight_shield_up");
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_e59c5246
// Checksum 0x683eea57, Offset: 0x73d8
// Size: 0x64
function function_e59c5246(var_e6fb7eb3) {
    var_10bc5bc2 = struct::get("ee_shadowman_boss_maxammo_" + var_e6fb7eb3);
    level thread zm_powerups::specific_powerup_drop("full_ammo", var_10bc5bc2.origin);
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_e49d016d
// Checksum 0x2adac387, Offset: 0x7448
// Size: 0x64
function function_e49d016d() {
    level endon(#"hash_fbc505ba");
    level flag::wait_till("ee_boss_vulnerable");
    level flag::wait_till_clear("ee_boss_vulnerable");
    level thread function_877ea350();
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_1e8f02dd
// Checksum 0xf0b75fa7, Offset: 0x74b8
// Size: 0x216
function function_1e8f02dd() {
    width = -128;
    height = -128;
    length = -128;
    s_loc = struct::get("defend_area_pap", "targetname");
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = width;
    s_loc.unitrigger_stub.script_height = height;
    s_loc.unitrigger_stub.script_length = length;
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.hint_string = %;
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_a683d8ab;
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_96ac6f7d);
    if (!isdefined(level.var_f86952c7)) {
        level.var_f86952c7 = [];
    }
    level.var_f86952c7["boss_1_victory"] = s_loc.unitrigger_stub;
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_a683d8ab
// Checksum 0x2974351d, Offset: 0x76d8
// Size: 0x102
function function_a683d8ab(player) {
    var_772700c5 = 0;
    if (isdefined(level.var_dbc3a0ef) && level.var_dbc3a0ef.n_script_int === 8) {
        var_772700c5 = 1;
    }
    var_a18af120 = 0;
    var_39ec9ec2 = level clientfield::get("ee_quest_state");
    if (var_39ec9ec2 == 1) {
        var_a18af120 = 1;
    }
    b_is_invis = isdefined(player.beastmode) && player.beastmode || !var_a18af120 || !var_772700c5;
    self setinvisibletoplayer(player, b_is_invis);
    return !b_is_invis;
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_96ac6f7d
// Checksum 0x18a930b0, Offset: 0x77e8
// Size: 0xac
function function_96ac6f7d() {
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
        function_3fc4aca5();
        self.stub zm_unitrigger::run_visibility_function_for_all_triggers();
        break;
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_3fc4aca5
// Checksum 0xd8fcea62, Offset: 0x78a0
// Size: 0x1c2
function function_3fc4aca5() {
    level flag::set("ee_boss_defeated");
    level notify(#"hash_a881e3fa");
    if (isdefined(level.var_dbc3a0ef) && isdefined(level.var_dbc3a0ef.var_93dad597)) {
        level.var_dbc3a0ef.var_93dad597 delete();
    }
    level thread cleanup_ai(1);
    var_9eb45ed3 = array("boxer", "detective", "femme", "magician");
    foreach (var_d7e2a718 in var_9eb45ed3) {
        if (isdefined(level.var_f86952c7["boss_1_" + var_d7e2a718])) {
            zm_unitrigger::unregister_unitrigger(level.var_f86952c7["boss_1_" + var_d7e2a718]);
        }
        var_91341fca = "ee_keeper_" + var_d7e2a718 + "_state";
        level clientfield::set(var_91341fca, 7);
        wait(0.1);
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_ce4db8c8
// Checksum 0xbe9adf92, Offset: 0x7a70
// Size: 0x204
function function_ce4db8c8(player) {
    level clientfield::set("ee_totem_state", 2);
    player playsound("zmb_zod_totem_pickup");
    level.var_f47099f2 = 0;
    if (!isdefined(level.var_86557cb0)) {
        level.var_86557cb0 = 0;
    }
    player.var_11104075 = spawn("script_model", player.origin);
    player.var_11104075 setmodel("t7_zm_zod_keepers_totem");
    player.var_11104075 linkto(player, "tag_stowed_back", (0, 12, -32));
    player.var_11104075 clientfield::set("totem_state_fx", 1);
    foreach (var_b9caebb1 in level.var_b94f6d7a) {
        level thread function_fe31ce39(var_b9caebb1);
    }
    level thread namespace_331b1e91::function_6ceb834f();
    level thread function_57b64f04(player);
    level thread function_4cc29f4f(player);
    level thread function_904cb175();
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_57b64f04
// Checksum 0x391a0e80, Offset: 0x7c80
// Size: 0xe8
function function_57b64f04(player) {
    player playsound("evt_nuke_flash");
    level.disable_nuke_delay_spawning = 1;
    level notify(#"disable_nuke_delay_spawning");
    level flag::clear("spawn_zombies");
    function_5db6ba34(1, 1);
    level thread function_83bdd16b();
    level util::waittill_any("ee_keeper_resurrected", "ee_keeper_resurrection_failed");
    level flag::set("spawn_zombies");
    level.disable_nuke_delay_spawning = 0;
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_4cc29f4f
// Checksum 0xd952d41f, Offset: 0x7d70
// Size: 0xc4
function function_4cc29f4f(player) {
    level notify(#"hash_4cc29f4f");
    level endon(#"hash_4cc29f4f");
    level endon(#"hash_8a22b2ff");
    level endon(#"hash_511572b6");
    player endon(#"hash_f764159c");
    player util::waittill_any("death", "disconnect", "player_downed");
    if (isdefined(player.var_11104075)) {
        player.var_11104075 delete();
    }
    level thread function_5d546ced();
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_fe26340b
// Checksum 0xcaefb0bc, Offset: 0x7e40
// Size: 0xfa
function function_fe26340b() {
    foreach (var_b9caebb1 in level.var_b94f6d7a) {
        if (!isdefined(var_b9caebb1) || !isdefined(var_b9caebb1.unitrigger_stub) || !isdefined(var_b9caebb1.unitrigger_stub.mdl_totem)) {
            continue;
        }
        var_b9caebb1.unitrigger_stub.mdl_totem delete();
        zm_unitrigger::unregister_unitrigger(var_b9caebb1.unitrigger_stub);
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_6b57b2d3
// Checksum 0x95675d2b, Offset: 0x7f48
// Size: 0xa2
function function_6b57b2d3() {
    foreach (player in level.activeplayers) {
        if (isdefined(player.var_11104075)) {
            return player;
        }
    }
    return array::random(level.activeplayers);
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_596e7950
// Checksum 0x860e6c36, Offset: 0x7ff8
// Size: 0x84
function function_596e7950(goal) {
    self endon(#"death");
    self waittill(#"visible");
    self vehicle_ai::set_state("scripted");
    self setvehgoalpos(goal, 0, 1);
    self thread namespace_331b1e91::function_75c9aad2(goal, 64, 1);
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_fe31ce39
// Checksum 0xd5603865, Offset: 0x8088
// Size: 0x2a4
function function_fe31ce39(var_1652ac62) {
    width = -128;
    height = -128;
    length = -128;
    var_1652ac62.unitrigger_stub = spawnstruct();
    var_1652ac62.unitrigger_stub.origin = var_1652ac62.origin;
    var_1652ac62.unitrigger_stub.angles = var_1652ac62.angles;
    var_1652ac62.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    var_1652ac62.unitrigger_stub.cursor_hint = "HINT_NOICON";
    var_1652ac62.unitrigger_stub.script_width = width;
    var_1652ac62.unitrigger_stub.script_height = height;
    var_1652ac62.unitrigger_stub.script_length = length;
    var_1652ac62.unitrigger_stub.script_noteworthy = var_1652ac62.script_noteworthy;
    var_1652ac62.unitrigger_stub.require_look_at = 0;
    var_1652ac62.unitrigger_stub.var_1652ac62 = var_1652ac62;
    var_1652ac62.unitrigger_stub.mdl_totem = spawn("script_model", var_1652ac62.origin);
    var_1652ac62.unitrigger_stub.mdl_totem setmodel("t7_zm_zod_keepers_totem");
    var_1652ac62.unitrigger_stub.mdl_totem hidepart("j_totem");
    var_1652ac62.unitrigger_stub.mdl_totem clientfield::set("totem_state_fx", 2);
    var_1652ac62.unitrigger_stub.prompt_and_visibility_func = &function_51ca11ba;
    zm_unitrigger::register_static_unitrigger(var_1652ac62.unitrigger_stub, &function_943c90e6);
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_51ca11ba
// Checksum 0xb903fea, Offset: 0x8338
// Size: 0xf0
function function_51ca11ba(player) {
    var_10cc4e3e = 0;
    if (!(isdefined(self.stub.b_completed) && self.stub.b_completed) && level flag::get("totem_placed")) {
        var_10cc4e3e = 1;
    }
    b_is_invis = isdefined(self.stub.b_taken) && (isdefined(player.beastmode) && player.beastmode || var_10cc4e3e || self.stub.b_taken);
    self setinvisibletoplayer(player, b_is_invis);
    return true;
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_943c90e6
// Checksum 0x33e27d33, Offset: 0x8430
// Size: 0xa4
function function_943c90e6() {
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
        level thread function_f016ad0d(self.stub, player);
        break;
    }
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_f016ad0d
// Checksum 0x7f0ca5f7, Offset: 0x84e0
// Size: 0x664
function function_f016ad0d(var_91089b66, player) {
    level endon(#"hash_511572b6");
    if (isdefined(var_91089b66.b_completed) && var_91089b66.b_completed) {
        if (!level flag::get("totem_placed")) {
            return;
        }
        var_91089b66.mdl_totem clientfield::set("totem_state_fx", 0);
        level flag::clear("totem_placed");
        level notify(#"hash_26f14b55");
        player playsound("zmb_zod_totem_pickup");
        player.var_11104075 = spawn("script_model", player.origin);
        player.var_11104075 setmodel("t7_zm_zod_keepers_totem");
        player.var_11104075 linkto(player, "tag_stowed_back", (0, 12, -32));
        player.var_11104075 clientfield::set("totem_state_fx", 1);
        var_91089b66.mdl_totem clientfield::set("totem_damage_fx", 0);
        var_91089b66.mdl_totem delete();
        v_origin = level.var_6e3c8a77.origin + (0, 0, 30);
        if (level.var_f47099f2 == 1 || level.var_86557cb0 < 3) {
            level thread zm_powerups::specific_powerup_drop("full_ammo", v_origin);
            level.var_86557cb0++;
        }
        level.var_6e3c8a77 = undefined;
        if (!isdefined(level.var_dc1b8d40)) {
            level.var_dc1b8d40 = [];
        }
        if (!isdefined(level.var_dc1b8d40)) {
            level.var_dc1b8d40 = [];
        } else if (!isarray(level.var_dc1b8d40)) {
            level.var_dc1b8d40 = array(level.var_dc1b8d40);
        }
        level.var_dc1b8d40[level.var_dc1b8d40.size] = var_91089b66.var_1652ac62;
        level thread function_4cc29f4f(player);
        namespace_331b1e91::function_e48af0db();
        var_c9a88def = struct::get_array("cursetrap_point", "targetname");
        var_96b4af2e = int(var_c9a88def.size * level.var_f47099f2 / 2);
        level thread namespace_331b1e91::function_f38a6a2a(var_96b4af2e);
        var_91089b66.b_taken = 1;
        level.var_f47099f2++;
        if (function_224eb2ac()) {
            level clientfield::set("ee_totem_state", 3);
            function_fe26340b();
        }
        return;
    }
    if (!isdefined(player.var_11104075)) {
        return;
    }
    level flag::set("totem_placed");
    level.var_6e3c8a77 = var_91089b66.var_1652ac62;
    player playsound("zmb_zod_totem_place");
    player.var_11104075 delete();
    var_91089b66.mdl_totem showpart("j_totem");
    var_91089b66.mdl_totem setcandamage(1);
    var_91089b66.mdl_totem clientfield::set("totem_state_fx", 3);
    var_a21704fb = [];
    var_a21704fb[0] = spawnstruct();
    var_a21704fb[0].func = &namespace_331b1e91::function_4a41b207;
    var_a21704fb[0].probability = 0.5;
    var_a21704fb[0].var_572b6f62 = 3;
    str_targetname = "ee_shadowman_totem";
    str_script_noteworthy = var_91089b66.script_noteworthy;
    level thread namespace_331b1e91::function_f3805c8a(str_targetname, str_script_noteworthy, var_a21704fb, 2, 4);
    var_91089b66.mdl_totem thread function_353871a(undefined, player);
    var_91089b66.mdl_totem thread function_ac3c8848();
    function_7a40f43c();
    wait(30);
    var_91089b66.mdl_totem clientfield::set("totem_state_fx", 4);
    var_91089b66.b_completed = 1;
    var_91089b66 zm_unitrigger::run_visibility_function_for_all_triggers();
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_e4f61654
// Checksum 0x3aa52c6e, Offset: 0x8b50
// Size: 0x7a
function function_e4f61654() {
    var_fb88b1ef = function_832f1b2a();
    if (var_fb88b1ef == 0) {
        return 2;
    }
    if (var_fb88b1ef == 1) {
        return 2;
    }
    if (var_fb88b1ef == 2) {
        return 2;
    }
    if (var_fb88b1ef == 3) {
        return 2;
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_832f1b2a
// Checksum 0x62bdbd65, Offset: 0x8bd8
// Size: 0x106
function function_832f1b2a() {
    var_fb88b1ef = 0;
    var_9eb45ed3 = array("boxer", "detective", "femme", "magician");
    foreach (var_d7e2a718 in var_9eb45ed3) {
        if (clientfield::get("ee_keeper_" + var_d7e2a718 + "_state") >= 3) {
            var_fb88b1ef += 1;
        }
    }
    return var_fb88b1ef;
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_224eb2ac
// Checksum 0x664a770b, Offset: 0x8ce8
// Size: 0x20
function function_224eb2ac() {
    if (level.var_f47099f2 == level.var_e59fb2) {
        return true;
    }
    return false;
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_353871a
// Checksum 0x20e48992, Offset: 0x8d10
// Size: 0x2c2
function function_353871a(var_ee1ff130, owner) {
    level endon(#"hash_511572b6");
    level endon(#"hash_26f14b55");
    self.health = 1000000;
    self.team = "allies";
    self setteam(self.team);
    self.owner = owner;
    self setowner(owner);
    var_9124cf71 = 0;
    var_a62764b3 = 2400 + -1600 * (level.activeplayers.size - 1) / 3;
    while (true) {
        amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon = self waittill(#"damage");
        self.health = 1000000;
        if (isdefined(level.var_ad555b99) && level.var_ad555b99) {
            return;
        }
        if (type === "MOD_CRUSH") {
            return;
        }
        if (isdefined(zm::is_idgun_damage(weapon)) && zm::is_idgun_damage(weapon)) {
        } else if (!isdefined(attacker.archetype)) {
            return;
        } else if (attacker.archetype !== "margwa" && attacker.archetype !== "zombie" && !isvehicle(attacker)) {
            return;
        }
        var_9124cf71 += amount;
        if (var_9124cf71 >= var_a62764b3) {
            self playsound("zmb_zod_totem_breakapart");
            self clientfield::set("totem_state_fx", 5);
            if (isdefined(var_ee1ff130)) {
                level thread function_3089f820(var_ee1ff130);
                return;
            }
            level thread function_3089f820();
            return;
        }
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_ac3c8848
// Checksum 0x31b98242, Offset: 0x8fe0
// Size: 0xea
function function_ac3c8848(var_ee1ff130) {
    level endon(#"hash_511572b6");
    level endon(#"hash_26f14b55");
    var_cabf2f4c = 0;
    var_3efd73a6 = 5;
    while (true) {
        level waittill(#"hash_d103204");
        var_cabf2f4c++;
        if (var_cabf2f4c >= var_3efd73a6) {
            self playsound("zmb_zod_totem_breakapart");
            self clientfield::set("totem_state_fx", 5);
            if (isdefined(var_ee1ff130)) {
                level thread function_3089f820(var_ee1ff130);
                return;
            }
            level thread function_3089f820();
            return;
        }
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_877ea350
// Checksum 0x20dbd72c, Offset: 0x90d8
// Size: 0x360
function function_877ea350() {
    level endon(#"hash_8a22b2ff");
    level endon(#"hash_511572b6");
    level endon(#"hash_fbc505ba");
    zombie_utility::ai_calculate_health(level.round_number);
    while (true) {
        for (var_565450eb = zombie_utility::get_current_zombie_count(); var_565450eb >= 10 || var_565450eb >= level.players.size * 5; var_565450eb = zombie_utility::get_current_zombie_count()) {
            wait(randomfloatrange(2, 4));
        }
        while (zombie_utility::get_current_actor_count() >= level.zombie_actor_limit) {
            zombie_utility::clear_all_corpses();
            wait(0.1);
        }
        zm::run_custom_ai_spawn_checks();
        if (isdefined(level.zombie_spawners)) {
            if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
                if (isdefined(level.zombie_spawn[level.spawner_int].size) && isdefined(level.spawner_int) && level.zombie_spawn[level.spawner_int].size) {
                    spawner = array::random(level.zombie_spawn[level.spawner_int]);
                } else {
                    spawner = array::random(level.zombie_spawners);
                }
            } else {
                spawner = array::random(level.zombie_spawners);
            }
            ai = zombie_utility::spawn_zombie(spawner, spawner.targetname);
        }
        if (isdefined(ai)) {
            ai.no_powerups = 1;
            ai.deathpoints_already_given = 1;
            ai.var_8ac75273 = 1;
            ai.exclude_cleanup_adding_to_total = 1;
            ai.targetname = "ee_zombie";
            if (ai.zombie_move_speed === "walk") {
                ai zombie_utility::set_zombie_run_cycle("run");
            }
            find_flesh_struct_string = "find_flesh";
            ai notify(#"zombie_custom_think_done", find_flesh_struct_string);
            ai ai::set_behavior_attribute("can_juke", 0);
            if (level.zombie_respawns > 0 && level.zombie_vars["zombie_spawn_delay"] > 1) {
                wait(1);
            } else {
                wait(level.zombie_vars["zombie_spawn_delay"]);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x0
// namespace_ba13c715<file_0>::function_737ebab
// Checksum 0x1230c14a, Offset: 0x9440
// Size: 0x638
function function_737ebab() {
    level endon(#"hash_8a22b2ff");
    level endon(#"hash_511572b6");
    level endon(#"hash_fbc505ba");
    level.var_11b54123 = getplayers();
    for (i = 0; i < level.var_11b54123.size; i++) {
        level.var_11b54123[i].hunted_by = 0;
    }
    namespace_b1ca30af::function_343220d8();
    var_f747e67a = 0;
    level clientfield::set("toggle_on_parasite_fog", 1);
    wait(3);
    while (true) {
        var_420916f7 = 0;
        while (!var_420916f7) {
            for (var_f747e67a = namespace_b1ca30af::function_acc1c531(); var_f747e67a >= 8 || var_f747e67a >= level.players.size * 4; var_f747e67a = namespace_b1ca30af::function_acc1c531()) {
                wait(randomfloatrange(2, 4));
            }
            spawn_point = undefined;
            while (!isdefined(spawn_point)) {
                var_78436f04 = array::random(level.activeplayers);
                if (isdefined(level.var_52f3c7b5)) {
                    spawn_point = [[ level.var_52f3c7b5 ]](var_78436f04);
                } else {
                    spawn_point = namespace_b1ca30af::function_e76b0f73(var_78436f04);
                }
                if (!isdefined(spawn_point)) {
                    wait(randomfloatrange(0.666667, 1.33333));
                }
            }
            var_6a724b3a = spawn_point.origin;
            v_ground = bullettrace(spawn_point.origin + (0, 0, 60), spawn_point.origin + (0, 0, 60) + (0, 0, -100000), 0, undefined)["position"];
            if (distancesquared(v_ground, spawn_point.origin) < 60 * 60) {
                var_6a724b3a = v_ground + (0, 0, 60);
            }
            queryresult = positionquery_source_navigation(var_6a724b3a, 0, 80, 80, 15, "navvolume_small");
            a_points = array::randomize(queryresult.data);
            var_8d090f42 = [];
            var_4eb24b0 = 0;
            foreach (point in a_points) {
                if (bullettracepassed(point.origin, spawn_point.origin, 0, var_78436f04)) {
                    if (!isdefined(var_8d090f42)) {
                        var_8d090f42 = [];
                    } else if (!isarray(var_8d090f42)) {
                        var_8d090f42 = array(var_8d090f42);
                    }
                    var_8d090f42[var_8d090f42.size] = point.origin;
                    var_4eb24b0++;
                    if (var_4eb24b0 >= 1) {
                        break;
                    }
                }
            }
            if (var_8d090f42.size >= 1) {
                n_spawn = 0;
                while (n_spawn < 1 && level.zombie_total > 0) {
                    for (i = var_8d090f42.size - 1; i >= 0; i--) {
                        v_origin = var_8d090f42[i];
                        level.var_c03323ec[0].origin = v_origin;
                        ai = zombie_utility::spawn_zombie(level.var_c03323ec[0]);
                        if (isdefined(ai)) {
                            ai.favoriteenemy = var_78436f04;
                            level thread namespace_b1ca30af::function_198fe8b9(ai, v_origin);
                            arrayremoveindex(var_8d090f42, i);
                            n_spawn++;
                            wait(randomfloatrange(0.0666667, 0.133333));
                            break;
                        }
                        wait(randomfloatrange(0.0666667, 0.133333));
                    }
                }
                var_420916f7 = 1;
            }
            util::wait_network_frame();
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_83bdd16b
// Checksum 0x6646da8c, Offset: 0x9a80
// Size: 0x310
function function_83bdd16b() {
    level endon(#"hash_8a22b2ff");
    level endon(#"hash_511572b6");
    level endon(#"hash_fbc505ba");
    level.var_bb7a82fa = getplayers();
    for (i = 0; i < level.var_bb7a82fa.size; i++) {
        level.var_bb7a82fa[i].hunted_by = 0;
    }
    namespace_5ace0f0e::function_2a8df909();
    var_e3b7af42 = 0;
    level clientfield::set("toggle_on_parasite_fog", 1);
    wait(3);
    while (true) {
        for (var_e3b7af42 = namespace_5ace0f0e::function_30f083dc(); var_e3b7af42 >= 13 || var_e3b7af42 >= level.players.size * 4; var_e3b7af42 = namespace_5ace0f0e::function_30f083dc()) {
            wait(randomfloatrange(2, 4));
        }
        spawn_point = undefined;
        var_78436f04 = function_6b57b2d3();
        if (isdefined(level.var_51593182)) {
            spawn_point = [[ level.var_51593182 ]](var_78436f04);
        } else {
            spawn_point = namespace_5ace0f0e::function_608b77a3(var_78436f04);
        }
        if (!isdefined(spawn_point)) {
            wait(randomfloatrange(0.666667, 1.33333));
            continue;
        }
        ai = zombie_utility::spawn_zombie(level.var_b15f9e1f[0]);
        if (isdefined(ai)) {
            var_8388cfbb = undefined;
            ai.deathpoints_already_given = 1;
            ai.favoriteenemy = var_78436f04;
            spawn_point thread namespace_5ace0f0e::function_5a37de3a(ai, spawn_point);
            if (level flag::get("totem_placed")) {
                var_8388cfbb = level.var_6e3c8a77.origin;
                var_8388cfbb += (0, 0, 32);
            }
            if (isdefined(var_8388cfbb)) {
                ai thread function_596e7950(var_8388cfbb);
            }
            namespace_5ace0f0e::function_725c1111();
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_7a40f43c
// Checksum 0xbffa9ba4, Offset: 0x9d98
// Size: 0x15a
function function_7a40f43c() {
    var_e159ea26 = getentarray("zombie_raps", "targetname");
    foreach (var_b847ad06 in var_e159ea26) {
        if (isdefined(var_b847ad06) && isalive(var_b847ad06)) {
            var_8388cfbb = level.var_6e3c8a77.origin;
            var_8388cfbb += (0, 0, 32);
            var_b847ad06 vehicle_ai::set_state("scripted");
            var_b847ad06 setvehgoalpos(var_8388cfbb, 0, 1);
            var_b847ad06 thread namespace_331b1e91::function_75c9aad2(var_8388cfbb, 64, 1);
        }
    }
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_ca7fecc0
// Checksum 0xcde1dcf7, Offset: 0x9f00
// Size: 0x37a
function cleanup_ai(var_1a60ad71, var_75541524) {
    if (!isdefined(var_1a60ad71)) {
        var_1a60ad71 = 0;
    }
    if (!isdefined(var_75541524)) {
        var_75541524 = 0;
    }
    if (var_1a60ad71) {
        level thread lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
    }
    var_da5df44a = array("ee_zombie", "zombie_wasp", "zombie_raps");
    if (!(isdefined(var_75541524) && var_75541524)) {
        if (!isdefined(var_da5df44a)) {
            var_da5df44a = [];
        } else if (!isarray(var_da5df44a)) {
            var_da5df44a = array(var_da5df44a);
        }
        var_da5df44a[var_da5df44a.size] = "margwa";
    }
    foreach (var_493961de in var_da5df44a) {
        a_ai = getentarray(var_493961de, "targetname");
        if (!isdefined(a_ai)) {
            continue;
        }
        foreach (ai in a_ai) {
            if (isdefined(ai) && isalive(ai)) {
                ai kill();
            }
            wait(0.1);
        }
    }
    a_ai_zombies = getaiteamarray(level.zombie_team);
    if (!isdefined(a_ai_zombies)) {
        return;
    }
    foreach (ai in a_ai_zombies) {
        if (isdefined(ai) && isalive(ai)) {
            if (isdefined(var_75541524) && var_75541524 && ai.archetype == "margwa") {
                continue;
            }
            ai kill();
        }
        wait(0.1);
    }
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_5db6ba34
// Checksum 0x1fe57a2c, Offset: 0xa288
// Size: 0x43a
function function_5db6ba34(var_1a60ad71, var_75541524) {
    if (!isdefined(var_1a60ad71)) {
        var_1a60ad71 = 1;
    }
    if (!isdefined(var_75541524)) {
        var_75541524 = 0;
    }
    if (var_1a60ad71) {
        level thread lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
    }
    wait(0.5);
    a_ai_zombies = getaiteamarray(level.zombie_team);
    var_6b1085eb = [];
    foreach (ai_zombie in a_ai_zombies) {
        ai_zombie.no_powerups = 1;
        ai_zombie.deathpoints_already_given = 1;
        if (isdefined(var_75541524) && var_75541524 && ai_zombie.archetype == "margwa") {
            continue;
        }
        if (isdefined(ai_zombie.ignore_nuke) && ai_zombie.ignore_nuke) {
            continue;
        }
        if (isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death) {
            continue;
        }
        if (isdefined(ai_zombie.nuke_damage_func)) {
            ai_zombie thread [[ ai_zombie.nuke_damage_func ]]();
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(ai_zombie)) {
            continue;
        }
        ai_zombie.marked_for_death = 1;
        ai_zombie.nuked = 1;
        var_6b1085eb[var_6b1085eb.size] = ai_zombie;
    }
    foreach (i, var_f92b3d80 in var_6b1085eb) {
        wait(randomfloatrange(0.1, 0.2));
        if (!isdefined(var_f92b3d80)) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(var_f92b3d80)) {
            continue;
        }
        if (i < 5 && !(isdefined(var_f92b3d80.isdog) && var_f92b3d80.isdog)) {
            var_f92b3d80 thread zombie_death::flame_death_fx();
        }
        if (!(isdefined(var_f92b3d80.isdog) && var_f92b3d80.isdog)) {
            if (!(isdefined(var_f92b3d80.no_gib) && var_f92b3d80.no_gib)) {
                var_f92b3d80 zombie_utility::zombie_head_gib();
            }
        }
        var_f92b3d80 dodamage(var_f92b3d80.health, var_f92b3d80.origin);
        if (!level flag::get("special_round")) {
            if (var_f92b3d80.archetype == "margwa") {
                level.var_e0191376++;
                continue;
            }
            level.zombie_total++;
        }
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_904cb175
// Checksum 0xd4509d2d, Offset: 0xa6d0
// Size: 0xd2
function function_904cb175(var_e6fb7eb3) {
    players = level.activeplayers;
    foreach (player in players) {
        if (isdefined(var_e6fb7eb3)) {
            level thread function_22d6774c(player, var_e6fb7eb3);
            continue;
        }
        level thread function_22d6774c(player);
    }
}

// Namespace namespace_ba13c715
// Params 2, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_22d6774c
// Checksum 0x6292821e, Offset: 0xa7b0
// Size: 0x8c
function function_22d6774c(player, var_e6fb7eb3) {
    level endon(#"hash_8a22b2ff");
    level endon(#"hash_511572b6");
    player util::waittill_any("death", "bled_out", "disconnect");
    if (isdefined(var_e6fb7eb3)) {
        level thread function_3089f820(var_e6fb7eb3);
        return;
    }
    level thread function_3089f820();
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_c7c3f7b5
// Checksum 0xc13e0d54, Offset: 0xa848
// Size: 0xd2
function function_c7c3f7b5(var_495327e) {
    if (level flag::get("ee_final_boss_staggered")) {
        return false;
    }
    if (!isdefined(var_495327e)) {
        var_495327e = 3;
    }
    var_3026634e = level.var_6e63e659 >= var_495327e;
    var_f52ee0b1 = zombie_utility::get_current_zombie_count() >= level.zombie_ai_limit;
    var_73d2bce8 = level.zm_loc_types["margwa_location"].size < 1;
    if (var_3026634e || var_f52ee0b1 || var_73d2bce8) {
        return false;
    }
    return true;
}

// Namespace namespace_ba13c715
// Params 12, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_37dc5568
// Checksum 0x7f637026, Offset: 0xa928
// Size: 0x346
function function_37dc5568(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    var_40fbf63a = 0;
    var_a315b31f = level clientfield::get("bm_superbeast");
    if (isdefined(attacker) && var_a315b31f) {
        var_b5497362 = [];
        foreach (head in self.head) {
            if (head namespace_c96301ee::function_d7d05b41()) {
                var_b5497362[var_b5497362.size] = head;
            }
        }
        if (var_b5497362.size > 0) {
            max = 100000;
            var_817400d4 = undefined;
            foreach (head in var_b5497362) {
                distsq = distancesquared(point, self gettagorigin(head.tag));
                if (distsq < max) {
                    max = distsq;
                    var_817400d4 = head;
                }
            }
            if (isdefined(var_817400d4)) {
                if (max < 576) {
                    var_817400d4.health -= damage;
                    var_40fbf63a = 1;
                    self clientfield::increment(var_817400d4.var_92dc0464);
                    attacker namespace_c96301ee::show_hit_marker();
                    if (var_817400d4.health <= 0) {
                        if (self namespace_c96301ee::function_a614f89c(var_817400d4.model, attacker)) {
                            return self.health;
                        }
                    }
                }
            }
        }
        return;
    }
    if (isdefined(self.var_c874832e) && self.var_c874832e) {
        return 0;
    }
}

/#

    // Namespace namespace_ba13c715
    // Params 0, eflags: 0x1 linked
    // namespace_ba13c715<file_0>::function_80d91769
    // Checksum 0x743b4699, Offset: 0xac78
    // Size: 0x664
    function function_80d91769() {
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_b44200f1);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_7a0bffae);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_54098545);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_d2f61efa);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_bdd0041e);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_932267b5);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_3089f820);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_fdcb978b);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 2, &function_fdcb978b);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 3, &function_fdcb978b);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_892e1f69);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_656b9ef0);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_690f9751);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_7787c089);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 2, &function_7787c089);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 3, &function_7787c089);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_1c4c22d9);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 2, &function_1c4c22d9);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 3, &function_1c4c22d9);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 4, &function_1c4c22d9);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 5, &function_1c4c22d9);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 6, &function_1c4c22d9);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 7, &function_1c4c22d9);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 8, &function_1c4c22d9);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 1, &function_2a306df);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 2, &function_2a306df);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 3, &function_2a306df);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 4, &function_2a306df);
        level thread namespace_8e578893::function_72260d3a("ee_keeper_magician_state", "ee_keeper_magician_state", 5, &function_2a306df);
    }

#/

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_690f9751
// Checksum 0xdd79a11c, Offset: 0xb2e8
// Size: 0x18
function function_690f9751(n_val) {
    level.var_421ff75e = 1;
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_656b9ef0
// Checksum 0xdeb0f9a1, Offset: 0xb308
// Size: 0x18
function function_656b9ef0(n_val) {
    level.var_ad555b99 = 1;
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_bdd0041e
// Checksum 0x646870f, Offset: 0xb328
// Size: 0x2c
function function_bdd0041e(n_val) {
    level flag::set("ee_complete");
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_7787c089
// Checksum 0xc118355a, Offset: 0xb360
// Size: 0x1ee
function function_7787c089(n_val) {
    var_e0e332eb = getent("mdl_god_far", "targetname");
    var_bd7c800e = getent("mdl_god_near", "targetname");
    switch (n_val) {
    case 1:
        var_e0e332eb clientfield::set("far_apothigod_active", 0);
        var_bd7c800e clientfield::set("near_apothigod_active", 0);
        var_e0e332eb hide();
        var_bd7c800e hide();
        break;
    case 2:
        var_e0e332eb clientfield::set("far_apothigod_active", 1);
        var_bd7c800e clientfield::set("near_apothigod_active", 0);
        var_e0e332eb show();
        var_bd7c800e hide();
        break;
    case 3:
        var_e0e332eb clientfield::set("far_apothigod_active", 0);
        var_bd7c800e clientfield::set("near_apothigod_active", 1);
        var_e0e332eb hide();
        var_bd7c800e show();
        break;
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_2a306df
// Checksum 0x6b8169b3, Offset: 0xb558
// Size: 0x19a
function function_2a306df(n_val) {
    switch (n_val) {
    case 1:
        for (i = 1; i < 5; i++) {
            var_d7e2a718 = function_d93f551b(i);
            var_91341fca = "ee_keeper_" + var_d7e2a718 + "_state";
            level clientfield::set(var_91341fca, 4);
        }
        break;
    case 2:
        function_c07e1993();
        for (i = 1; i < 5; i++) {
            var_d7e2a718 = function_d93f551b(i);
            var_91341fca = "ee_keeper_" + var_d7e2a718 + "_state";
            level clientfield::set(var_91341fca, 5);
        }
        wait(3);
        level.shadowman.var_93dad597 clientfield::set("boss_shield_fx", 0);
        break;
    case 3:
        break;
    case 4:
        break;
    case 5:
        break;
    }
}

// Namespace namespace_ba13c715
// Params 0, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_c07e1993
// Checksum 0x675ff0b0, Offset: 0xb700
// Size: 0x19c
function function_c07e1993() {
    if (!isdefined(level.shadowman)) {
        level.shadowman = spawnstruct();
    }
    level.shadowman.s_spawnpoint = struct::get("ee_shadowman_8", "targetname");
    var_2e456dd1 = level.shadowman.s_spawnpoint.origin;
    var_7e1ba25f = level.shadowman.s_spawnpoint.angles;
    level.shadowman.var_93dad597 = spawn("script_model", var_2e456dd1);
    level.shadowman.var_93dad597.angles = var_7e1ba25f;
    level.shadowman.var_93dad597 setmodel("c_zom_zod_shadowman_tentacles_fb");
    level.shadowman.var_93dad597 useanimtree(#generic);
    level.shadowman.var_93dad597 clientfield::set("shadowman_fx", 1);
    level.shadowman.var_93dad597 playsound("zmb_shadowman_tele_in");
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_1c4c22d9
// Checksum 0xf93cffbf, Offset: 0xb8a8
// Size: 0x15e
function function_1c4c22d9(n_val) {
    switch (n_val) {
    case 1:
        function_61d12305(1, 1);
        break;
    case 2:
        function_61d12305(1, 0);
        break;
    case 3:
        function_61d12305(2, 1);
        break;
    case 4:
        function_61d12305(2, 0);
        break;
    case 5:
        function_61d12305(3, 1);
        break;
    case 6:
        function_61d12305(3, 0);
        break;
    case 7:
        function_61d12305(4, 1);
        break;
    case 8:
        function_61d12305(4, 0);
        break;
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_fdcb978b
// Checksum 0x1d544836, Offset: 0xba10
// Size: 0x24
function function_fdcb978b(n_val) {
    level thread function_d3b3eb03(n_val);
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_892e1f69
// Checksum 0xa9f7504, Offset: 0xba40
// Size: 0x24
function function_892e1f69(n_val) {
    level thread function_c898ab1(n_val);
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_b44200f1
// Checksum 0xda146504, Offset: 0xba70
// Size: 0x54
function function_b44200f1(n_val) {
    namespace_215602b6::function_de43aaee("super_sesame");
    namespace_1f61c67f::function_c0a29676();
    level flag::set("ee_begin");
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_7a0bffae
// Checksum 0x8ff34c62, Offset: 0xbad0
// Size: 0xf6
function function_7a0bffae(n_val) {
    function_b44200f1();
    level flag::set("ee_book");
    for (i = 1; i < 5; i++) {
        var_d7e2a718 = function_d93f551b(i);
        var_27b0f0e4 = level clientfield::get("ee_keeper_" + var_d7e2a718 + "_state");
        if (var_27b0f0e4 == 3) {
            continue;
        }
        level function_8f4b6b20(i, 1);
        wait(1);
    }
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_54098545
// Checksum 0xbf7638bf, Offset: 0xbbd0
// Size: 0x11c
function function_54098545(n_val) {
    level.var_421ff75e = 1;
    function_b44200f1();
    level flag::set("ee_book");
    for (i = 1; i < 5; i++) {
        var_d7e2a718 = function_d93f551b(i);
        var_27b0f0e4 = level clientfield::get("ee_keeper_" + var_d7e2a718 + "_state");
        if (var_27b0f0e4 == 3) {
            continue;
        }
        level function_8f4b6b20(i, 1);
        wait(1);
    }
    wait(5);
    function_3fc4aca5();
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_d2f61efa
// Checksum 0x8242dd2c, Offset: 0xbcf8
// Size: 0x6c
function function_d2f61efa(n_val) {
    function_b44200f1();
    level flag::set("ee_book");
    function_3fc4aca5();
    level flag::set("ee_final_boss_defeated");
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x1 linked
// namespace_ba13c715<file_0>::function_932267b5
// Checksum 0x8ee220fa, Offset: 0xbd70
// Size: 0x1c
function function_932267b5(n_val) {
    function_6f8c2ea3();
}

// Namespace namespace_ba13c715
// Params 1, eflags: 0x0
// namespace_ba13c715<file_0>::function_c1cc37db
// Checksum 0x696866e4, Offset: 0xbd98
// Size: 0x116
function function_c1cc37db(n_val) {
    if (n_val < 5) {
        level function_8f4b6b20();
        return;
    }
    if (n_val == 5) {
        level function_8f4b6b20();
        return;
    }
    if (n_val == 6) {
        for (i = 1; i < 5; i++) {
            var_d7e2a718 = function_d93f551b(i);
            var_27b0f0e4 = level clientfield::get("ee_keeper_" + var_d7e2a718 + "_state");
            if (var_27b0f0e4 == 3) {
                continue;
            }
            level function_8f4b6b20();
            wait(1);
        }
    }
}

