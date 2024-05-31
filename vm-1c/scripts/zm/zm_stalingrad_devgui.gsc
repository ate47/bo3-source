#using scripts/zm/zm_stalingrad_util;
#using scripts/zm/zm_stalingrad_pap_quest;
#using scripts/zm/zm_stalingrad_finger_trap;
#using scripts/zm/zm_stalingrad_ee_main;
#using scripts/zm/zm_stalingrad_drop_pods;
#using scripts/zm/zm_stalingrad_dragon_strike;
#using scripts/zm/zm_stalingrad_dragon;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weap_dragon_strike;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_placeable_mine;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_ai_raps;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_bde177cb;

/#

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa3b3488f, Offset: 0x338
    // Size: 0x434
    function function_91912a79() {
        zm_devgui::add_custom_devgui_callback(&function_17d8768b);
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        if (getdvarint("<unknown string>") > 0) {
            level thread function_867cb8b1();
        }
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb8c147ca, Offset: 0x778
    // Size: 0x18c
    function function_867cb8b1() {
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
    }

    // Namespace namespace_bde177cb
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe0e6b68, Offset: 0x910
    // Size: 0x7ae
    function function_17d8768b(cmd) {
        switch (cmd) {
        case 8:
            level thread function_2b22d1f9();
            return 1;
        case 8:
            level thread function_a7e8b47b();
            return 1;
        case 8:
            level thread function_31f1d173(0);
            return 1;
        case 8:
            level thread function_31f1d173(1);
            return 1;
        case 8:
            level thread function_31f1d173(2);
            return 1;
        case 8:
            level thread function_31f1d173(3);
            return 1;
        case 8:
            level thread function_cc40b263();
            return 1;
        case 8:
        case 8:
        case 8:
        case 8:
        case 8:
        case 8:
        case 8:
        case 8:
        case 8:
        case 8:
        case 8:
        case 8:
            level.var_8cc024f2 = level.var_583e4a97.var_5d8406ed[cmd];
            level thread namespace_2e6e7fce::function_d1a91c4f(level.var_8cc024f2);
            return 1;
        case 8:
            level thread namespace_e81d2518::function_16734812();
            return 1;
        case 8:
            level thread namespace_e81d2518::function_e7982921();
            return 1;
        case 8:
            level thread namespace_e81d2518::function_cfe0d523();
            return 1;
        case 8:
            level thread namespace_e81d2518::function_5f0cb06e();
            return 1;
        case 8:
            level thread namespace_e81d2518::function_84bd37c8();
            return 1;
        case 8:
            level thread namespace_e81d2518::function_8bf8d33b();
            return 1;
        case 8:
            level thread namespace_e81d2518::function_7977857();
            return 1;
        case 8:
            level thread namespace_e81d2518::function_b8de630a();
            return 1;
        case 8:
            level thread namespace_e81d2518::function_941c2339();
            return 1;
        case 8:
            level thread namespace_e81d2518::function_ef4a09c3();
            return 1;
        case 8:
            level thread namespace_e81d2518::function_c09859f();
            return 1;
        case 8:
            level thread namespace_e81d2518::function_372d0868();
            break;
        case 8:
            level thread namespace_e81d2518::function_21b70393();
            break;
        case 8:
            level thread namespace_e81d2518::function_482eea0f(1);
            break;
        case 8:
            level thread namespace_e81d2518::function_482eea0f(2);
            break;
        case 8:
            level thread namespace_e81d2518::function_482eea0f(3);
            break;
        case 8:
            level thread namespace_e81d2518::function_482eea0f(4);
            break;
        case 8:
            level notify(#"hash_2b2c1420");
            break;
        case 8:
            level thread function_4b210fe6();
            return 1;
        case 8:
            level thread function_4b210fe6("<unknown string>");
            return 1;
        case 8:
            level thread function_4b210fe6("<unknown string>");
            return 1;
        case 8:
            level thread function_4b210fe6("<unknown string>");
            return 1;
        case 8:
            level thread function_a5a0adb4();
            return 1;
        case 8:
            level thread function_bf490b3c();
            return 1;
        case 8:
            level thread function_1b0d61c5();
            return 1;
        case 8:
            level thread function_fd68eee0();
            return 1;
        case 8:
            level thread namespace_b205ff9c::function_ddb9991b();
            return 1;
        case 8:
            level thread namespace_b205ff9c::function_fc99caf5();
            return 1;
        case 8:
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            util::wait_network_frame();
            level notify(#"hash_68bf9f79");
            util::wait_network_frame();
            level notify(#"hash_b227a45b");
            util::wait_network_frame();
            level notify(#"hash_9b46a273");
            return 1;
        case 8:
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            return 1;
        case 8:
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            return 1;
        case 8:
            level flag::set("<unknown string>");
            level flag::set("<unknown string>");
            level notify(#"hash_b7bed0ed");
            return 1;
        case 8:
            function_c072d3dc();
            return 1;
        case 8:
            function_4be43f4d();
            return 1;
        case 8:
            function_354ff582();
            return 1;
        case 8:
            function_f0aaa402();
            return 1;
        case 8:
            function_b221d46();
            return 1;
        default:
            return 0;
        }
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x39a2b7b6, Offset: 0x10c8
    // Size: 0x13c
    function function_2b22d1f9() {
        level flag::set("<unknown string>");
        var_b80ee5b5 = struct::get_array("<unknown string>", "<unknown string>");
        var_9544a498 = 0;
        foreach (player in level.activeplayers) {
            player setorigin(var_b80ee5b5[var_9544a498].origin);
            player setplayerangles(var_b80ee5b5[var_9544a498].angles);
        }
        level flag::set("<unknown string>");
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcf7324ab, Offset: 0x1210
    // Size: 0x44
    function function_cc40b263() {
        if (isdefined(level.var_8cc024f2)) {
            iprintlnbold("<unknown string>");
            return 0;
        }
        level namespace_b57650e4::function_809fbbff();
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x794c1ee5, Offset: 0x1260
    // Size: 0x7da
    function function_a7e8b47b() {
        var_1a0a3da9 = getentarray("<unknown string>", "<unknown string>");
        var_ff1b68c0 = getent("<unknown string>", "<unknown string>");
        var_4562cbcf = getentarray("<unknown string>", "<unknown string>");
        var_50e0150f = getentarray("<unknown string>", "<unknown string>");
        var_b9e116c5 = getentarray("<unknown string>", "<unknown string>");
        var_6f3f4356 = getnodearray("<unknown string>", "<unknown string>");
        if (level.var_de98e3ce.var_1467b926) {
            level.var_de98e3ce.var_1467b926 = 0;
            foreach (e_collision in var_4562cbcf) {
                e_collision movez(600, 0.1);
                e_collision disconnectpaths();
            }
            foreach (e_gate in var_50e0150f) {
                e_gate movez(600, 0.25);
            }
            foreach (e_door in var_1a0a3da9) {
                e_door movex(114, 1);
                e_door disconnectpaths();
            }
            foreach (e_hatch in var_b9e116c5) {
                e_hatch rotateroll(-90, 1);
            }
            foreach (var_b0a376a4 in var_6f3f4356) {
                unlinktraversal(var_b0a376a4);
            }
            var_ff1b68c0 movey(-84, 1);
            level thread scene::play("<unknown string>");
        } else {
            level.var_de98e3ce.var_1467b926 = 1;
            foreach (e_collision in var_4562cbcf) {
                e_collision connectpaths();
                e_collision movez(-600, 0.1);
            }
            foreach (e_gate in var_50e0150f) {
                e_gate movez(-600, 0.25);
            }
            foreach (e_door in var_1a0a3da9) {
                e_door movex(-114, 1);
                e_door connectpaths();
            }
            foreach (e_hatch in var_b9e116c5) {
                e_hatch rotateroll(90, 1);
            }
            foreach (var_b0a376a4 in var_6f3f4356) {
                linktraversal(var_b0a376a4);
            }
            var_ff1b68c0 movey(84, 1);
            var_21ce8765 = getent("<unknown string>", "<unknown string>");
            var_21ce8765 thread scene::play("<unknown string>");
        }
        return 1;
    }

    // Namespace namespace_bde177cb
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc241e14c, Offset: 0x1a48
    // Size: 0x234
    function function_31f1d173(var_41ef115f) {
        level notify(#"hash_31f1d173");
        wait(1);
        switch (var_41ef115f) {
        case 0:
            var_e0320b0b = 1;
            var_6e2a9bd0 = 2;
            var_40c04fc3 = 1;
            break;
        case 1:
            var_e0320b0b = 0;
            var_6e2a9bd0 = 2;
            var_40c04fc3 = 2;
            break;
        case 2:
            var_e0320b0b = 0;
            var_6e2a9bd0 = 1;
            var_40c04fc3 = 3;
            break;
        case 3:
            var_e0320b0b = 0;
            var_6e2a9bd0 = 1;
            var_942d1639 = 2;
            var_40c04fc3 = 4;
            break;
        }
        level thread namespace_b57650e4::function_187a933f(var_e0320b0b);
        level thread namespace_b57650e4::function_187a933f(var_6e2a9bd0);
        if (isdefined(var_942d1639)) {
            level thread namespace_b57650e4::function_187a933f(var_942d1639);
        }
        exploder::exploder("<unknown string>");
        exploder::exploder("<unknown string>" + var_40c04fc3);
        level util::waittill_any_timeout(20, "<unknown string>");
        level thread namespace_b57650e4::function_a71517e1(var_e0320b0b);
        level thread namespace_b57650e4::function_a71517e1(var_6e2a9bd0);
        if (isdefined(var_942d1639)) {
            level thread namespace_b57650e4::function_a71517e1(var_942d1639);
        }
        exploder::kill_exploder("<unknown string>" + var_40c04fc3);
        exploder::kill_exploder("<unknown string>");
    }

    // Namespace namespace_bde177cb
    // Params 1, eflags: 0x1 linked
    // Checksum 0xba4a5a60, Offset: 0x1c88
    // Size: 0x144
    function function_4b210fe6(var_b87a2184) {
        namespace_e81d2518::function_30560c4b();
        namespace_e81d2518::function_cf119cfd();
        level flag::set("<unknown string>");
        level namespace_48c05c81::function_3804dbf1();
        namespace_48c05c81::function_adf4d1d0();
        if (isdefined(level.var_ef9c43d7)) {
            if (isdefined(level.var_ef9c43d7.var_fa4643fb)) {
                level.var_ef9c43d7.var_fa4643fb delete();
            }
            level.var_ef9c43d7 delete();
            level.var_ef9c43d7 = undefined;
        }
        level zm_zonemgr::enable_zone("<unknown string>");
        if (isdefined(var_b87a2184)) {
            level flag::init("<unknown string>");
            level flag::init(var_b87a2184, 1);
        }
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x63b0c4f2, Offset: 0x1dd8
    // Size: 0x5c
    function function_a5a0adb4() {
        if (level flag::get("<unknown string>")) {
            level namespace_5ace0f0e::function_ad853d21(6);
            return;
        }
        iprintlnbold("<unknown string>");
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1ef3fc2c, Offset: 0x1e40
    // Size: 0xe8
    function function_bf490b3c() {
        level endon(#"_zombie_game_over");
        level flag::wait_till("<unknown string>");
        while (!isdefined(level.var_cf6e9729)) {
            wait(0.05);
        }
        level.var_cf6e9729.var_65850094[1] = 1;
        level.var_cf6e9729.var_65850094[2] = 1;
        level.var_cf6e9729.var_65850094[3] = 1;
        level.var_cf6e9729.var_65850094[4] = 1;
        level.var_cf6e9729.var_65850094[5] = 1;
        level.var_cf6e9729.var_dad3d9bd = 9999999;
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf200cbc8, Offset: 0x1f30
    // Size: 0xaa
    function function_1b0d61c5() {
        level flag::clear("<unknown string>");
        foreach (e_player in level.players) {
            e_player namespace_19e79ea1::function_8258d71c();
        }
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3cbde1e7, Offset: 0x1fe8
    // Size: 0xaa
    function function_fd68eee0() {
        level flag::set("<unknown string>");
        foreach (e_player in level.players) {
            e_player namespace_19e79ea1::function_8258d71c();
        }
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xce313653, Offset: 0x20a0
    // Size: 0x2c
    function function_c072d3dc() {
        luinotifyevent(%"<unknown string>", 1, 1);
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9f30d1cd, Offset: 0x20d8
    // Size: 0x24
    function function_4be43f4d() {
        luinotifyevent(%"<unknown string>", 1, 0);
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xacb0a3f5, Offset: 0x2108
    // Size: 0x7c
    function function_354ff582() {
        level clientfield::set("<unknown string>", int((level.time - level.n_gameplay_start_time + 500) / 1000));
        level clientfield::set("<unknown string>", level.round_number);
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcbaafd63, Offset: 0x2190
    // Size: 0x54
    function function_f0aaa402() {
        level clientfield::set("<unknown string>", int((level.time - level.n_gameplay_start_time + 500) / 1000));
    }

    // Namespace namespace_bde177cb
    // Params 0, eflags: 0x1 linked
    // Checksum 0x27e7b5a8, Offset: 0x21f0
    // Size: 0x54
    function function_b221d46() {
        level clientfield::set("<unknown string>", int((level.time - level.n_gameplay_start_time + 500) / 1000));
    }

#/
