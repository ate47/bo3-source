#using scripts/shared/lui_shared;
#using scripts/shared/_weapon_customization_icon;
#using scripts/shared/_character_customization;
#using scripts/shared/ai/archetype_damage_effects;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/zombie;
#using scripts/codescripts/struct;
#using scripts/core/_multi_extracam;
#using scripts/mp/_devgui;
#using scripts/shared/scene_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/util_shared;
#using scripts/shared/player_shared;
#using scripts/shared/music_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/end_game_taunts;
#using scripts/shared/custom_class;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;

// Can't decompile export namespace_df7b1a9b::function_7b0193a1

#namespace frontend;

// Namespace frontend
// Method(s) 9 Total 9
class class_513a44f6 {

    // Namespace namespace_513a44f6
    // Params 3, eflags: 0x5 linked
    // Checksum 0x2a8b145a, Offset: 0xd2f8
    // Size: 0xc2
    function function_376191fe(localclientnum, str_fx, str_tag) {
        fx_id = playfxontag(localclientnum, str_fx, self.var_fb7ce594[2], str_tag);
        if (!isdefined(self.var_bbdd2958)) {
            self.var_bbdd2958 = [];
        } else if (!isarray(self.var_bbdd2958)) {
            self.var_bbdd2958 = array(self.var_bbdd2958);
        }
        self.var_bbdd2958[self.var_bbdd2958.size] = fx_id;
    }

    // Namespace namespace_513a44f6
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8fa88e4f, Offset: 0xd0e0
    // Size: 0x20e
    function function_8ab5d4f1(localclientnum, b_on) {
        if (b_on) {
            fx_id = playfxontag(localclientnum, level._effect["megachew_vat_light_lg"], self.var_fb7ce594[2], "tag_button3_light1");
            if (!isdefined(self.var_a261993f)) {
                self.var_a261993f = [];
            } else if (!isarray(self.var_a261993f)) {
                self.var_a261993f = array(self.var_a261993f);
            }
            self.var_a261993f[self.var_a261993f.size] = fx_id;
            fx_id = playfxontag(localclientnum, level._effect["megachew_vat_light_lg"], self.var_fb7ce594[2], "tag_button3_light2");
            if (!isdefined(self.var_a261993f)) {
                self.var_a261993f = [];
            } else if (!isarray(self.var_a261993f)) {
                self.var_a261993f = array(self.var_a261993f);
            }
            self.var_a261993f[self.var_a261993f.size] = fx_id;
            return;
        }
        foreach (fx_id in self.var_a261993f) {
            stopfx(localclientnum, fx_id);
        }
        self.var_a261993f = [];
        return;
    }

    // Namespace namespace_513a44f6
    // Params 2, eflags: 0x1 linked
    // Checksum 0x32cc9e74, Offset: 0xcfc0
    // Size: 0x116
    function function_c379aa(localclientnum, b_on) {
        if (!b_on) {
            function_8ab5d4f1(localclientnum, 0);
            exploder::stop_exploder("zm_gumball_" + self.var_2da25cd0 + "cent");
            return;
        }
        for (i = 1; i <= 3; i++) {
            if (i == self.var_2da25cd0) {
                exploder::exploder("zm_gumball_" + i + "cent");
                function_8ab5d4f1(localclientnum, 1);
                continue;
            }
            exploder::stop_exploder("zm_gumball_" + i + "cent");
        }
    }

    // Namespace namespace_513a44f6
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc871d58, Offset: 0xcec8
    // Size: 0xee
    function function_bc49558a(localclientnum) {
        for (i = 0; i < 3; i++) {
            var_c2d73a21 = self.var_fb7ce594[i];
            if (i === self.var_2da25cd0 - 1) {
                var_c2d73a21 hidepart(localclientnum, "tag_filament_off");
                var_c2d73a21 showpart(localclientnum, "tag_filament_on");
                continue;
            }
            var_c2d73a21 hidepart(localclientnum, "tag_filament_on");
            var_c2d73a21 showpart(localclientnum, "tag_filament_off");
        }
    }

    // Namespace namespace_513a44f6
    // Params 2, eflags: 0x1 linked
    // Checksum 0x17fbd45a, Offset: 0xce20
    // Size: 0x9c
    function press_button(localclientnum, var_4d37bbe9) {
        var_c2d73a21 = self.var_fb7ce594[var_4d37bbe9 - 1];
        var_c2d73a21 util::waittill_dobj(localclientnum);
        var_c2d73a21 clearanim("p7_fxanim_zm_bgb_button_push_anim", 0);
        var_c2d73a21 animation::play("p7_fxanim_zm_bgb_button_push_anim", undefined, undefined, 1);
    }

    // Namespace namespace_513a44f6
    // Params 2, eflags: 0x1 linked
    // Checksum 0xaf793f60, Offset: 0xcdd8
    // Size: 0x3c
    function function_2b1651c(localclientnum, var_4d37bbe9) {
        self.var_2da25cd0 = var_4d37bbe9 + 1;
        function_bc49558a(localclientnum);
    }

    // Namespace namespace_513a44f6
    // Params 1, eflags: 0x1 linked
    // Checksum 0x327ebe93, Offset: 0xcc80
    // Size: 0x14c
    function init(localclientnum) {
        self.var_fb7ce594 = [];
        self.var_bbdd2958 = [];
        self.var_a261993f = [];
        for (i = 1; i <= 3; i++) {
            var_c2d73a21 = getent(localclientnum, "bgb_button_0" + i, "targetname");
            if (!var_c2d73a21 hasanimtree()) {
                var_c2d73a21 useanimtree(#generic);
            }
            if (!isdefined(self.var_fb7ce594)) {
                self.var_fb7ce594 = [];
            } else if (!isarray(self.var_fb7ce594)) {
                self.var_fb7ce594 = array(self.var_fb7ce594);
            }
            self.var_fb7ce594[self.var_fb7ce594.size] = var_c2d73a21;
        }
        function_2b1651c(localclientnum, 1);
    }

}

// Namespace frontend
// Method(s) 36 Total 36
class class_df7b1a9b {

    // Namespace namespace_df7b1a9b
    // Params 0, eflags: 0x1 linked
    // Checksum 0x65b8514d, Offset: 0x99e8
    // Size: 0xf6
    function function_cad50ca5() {
        self.var_f554edc7 = 0;
        self.var_426dfc6f = 0;
        var_31ed4895 = 0;
        for (i = 0; i < 3; i++) {
            if (self.var_70090deb < i + 1 && !self.var_f554edc7) {
                break;
            }
            if ("POWER_BOOST" == self.var_c81cd753[i]) {
                self.var_f554edc7 = 1;
                var_31ed4895 += 1;
            }
            if ("DOUBLE_UP" == self.var_c81cd753[i]) {
                self.var_426dfc6f += 1;
                var_31ed4895 += 1;
            }
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 3, eflags: 0x1 linked
    // Checksum 0x2e55eb3b, Offset: 0x96f0
    // Size: 0x2ec
    function function_4a017b6b(localclientnum, var_22f33582, var_dda27c05) {
        level flag::clear("megachew_factory_result_" + var_22f33582 + "_anim_done");
        var_9791d8f2 = "p7_fxanim_zm_bgb_tube_ball_" + var_22f33582 + "_drop_anim";
        var_528cf711 = "p7_fxanim_zm_bgb_tube_ball_" + var_22f33582 + "_idle_anim";
        var_5bf69b77 = "p7_fxanim_zm_bgb_tube_ball_" + var_22f33582 + "_flush_anim";
        var_e9950fa3 = "p7_fxanim_zm_bgb_tube_front_drop_anim";
        var_b5ba2990 = "p7_fxanim_zm_bgb_tube_front_flush_anim";
        self.var_1e7662f3 util::waittill_dobj(localclientnum);
        self.var_1e7662f3 clearanim(var_e9950fa3, 0);
        self.var_1e7662f3 clearanim(var_b5ba2990, 0);
        mdl_ball = self.var_83352c11[var_22f33582];
        mdl_ball util::waittill_dobj(localclientnum);
        mdl_ball clearanim(var_9791d8f2, 0);
        mdl_ball clearanim(var_528cf711, 0);
        mdl_ball clearanim(var_5bf69b77, 0);
        switch (var_dda27c05) {
        case 0:
            self.var_1e7662f3 thread animation::play(var_e9950fa3, undefined, undefined, 1);
            mdl_ball animation::play(var_9791d8f2, undefined, undefined, 1);
            break;
        case 1:
            mdl_ball animation::play(var_528cf711, undefined, undefined, 1);
            break;
        case 2:
            self.var_1e7662f3 thread animation::play(var_b5ba2990, undefined, undefined, 1);
            mdl_ball animation::play(var_5bf69b77, undefined, undefined, 1);
            break;
        }
        level flag::set("megachew_factory_result_" + var_22f33582 + "_anim_done");
    }

    // Namespace namespace_df7b1a9b
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3c41a873, Offset: 0x9668
    // Size: 0x7c
    function function_ef1ebe78(localclientnum, var_dda27c05) {
        for (i = 0; i < 6; i++) {
            self thread function_4a017b6b(localclientnum, i, var_dda27c05);
        }
        level flag::wait_till_all(self.var_641411e7);
    }

    // Namespace namespace_df7b1a9b
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2d0fa8a, Offset: 0x94d8
    // Size: 0x184
    function function_16b474d(localclientnum, var_88e3572d) {
        level flag::clear("megachew_factory_door_" + var_88e3572d + "_anim_done");
        mdl_door = self.var_dfffc7fc[var_88e3572d - 1];
        mdl_door util::waittill_dobj(localclientnum);
        if (self.var_a118dc0a) {
            exploder::exploder("zm_gumball_inside_" + var_88e3572d);
            mdl_door clearanim("p7_fxanim_zm_bgb_door_close_anim", 0);
            mdl_door animation::play("p7_fxanim_zm_bgb_door_open_anim", undefined, undefined, 1);
        } else {
            exploder::stop_exploder("zm_gumball_inside_" + var_88e3572d);
            mdl_door clearanim("p7_fxanim_zm_bgb_door_open_anim", 0);
            mdl_door animation::play("p7_fxanim_zm_bgb_door_close_anim", undefined, undefined, 1);
        }
        level flag::set("megachew_factory_door_" + var_88e3572d + "_anim_done");
    }

    // Namespace namespace_df7b1a9b
    // Params 2, eflags: 0x1 linked
    // Checksum 0x6545928b, Offset: 0x9418
    // Size: 0xb2
    function function_28c320ea(localclientnum, b_open) {
        if (self.var_a118dc0a === b_open) {
            return;
        }
        self.var_a118dc0a = b_open;
        for (i = 1; i <= 3; i++) {
            self thread function_16b474d(localclientnum, i);
        }
        level flag::wait_till_all(self.var_e522183c);
        if (!self.var_a118dc0a) {
            level notify(#"hash_7e96273a");
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 3, eflags: 0x1 linked
    // Checksum 0x450bb8d4, Offset: 0x9338
    // Size: 0xd6
    function function_c8a456c2(localclientnum, var_65daa900, var_28303bfd) {
        switch (var_28303bfd) {
        case 0:
            exploder::stop_exploder("zm_gumball_sign_m_" + var_65daa900);
            exploder::stop_exploder("zm_gumball_sign_b_" + var_65daa900);
            break;
        case 1:
            exploder::exploder("zm_gumball_sign_m_" + var_65daa900);
            break;
        case 2:
            exploder::exploder("zm_gumball_sign_b_" + var_65daa900);
            break;
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 3, eflags: 0x1 linked
    // Checksum 0x9db0d006, Offset: 0x8df8
    // Size: 0x536
    function function_afb1aa26(localclientnum, var_84faa044, var_dda27c05) {
        var_50a3a8f7 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_idle_anim";
        if (function_8dd5b778(var_84faa044 - 1)) {
            var_be4e383 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_active_powered_anim";
            var_b2e31b1e = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_end_powered_anim";
            var_baade4f6 = "p7_fxanim_zm_bgb_body_active_powered_anim";
            var_60c12291 = "p7_fxanim_zm_bgb_body_end_powered_anim";
        } else {
            var_be4e383 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_active_unpowered_anim";
            var_b2e31b1e = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_end_unpowered_anim";
            var_baade4f6 = "p7_fxanim_zm_bgb_body_active_unpowered_anim";
            var_60c12291 = "p7_fxanim_zm_bgb_body_end_unpowered_anim";
        }
        var_623cf36 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_turn_anim";
        var_2e757f3 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_turn_select_anim";
        var_c80f5bb9 = "p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_turn_reverse_anim";
        var_263dadfc = self.var_c12784e3[var_84faa044 - 1];
        mdl_body = self.var_8be59e45[var_84faa044 - 1];
        var_263dadfc util::waittill_dobj(localclientnum);
        var_263dadfc clearanim(var_50a3a8f7, 0);
        var_263dadfc clearanim("p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_active_powered_anim", 0);
        var_263dadfc clearanim("p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_active_unpowered_anim", 0);
        var_263dadfc clearanim("p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_end_powered_anim", 0);
        var_263dadfc clearanim("p7_fxanim_zm_bgb_dome_0" + var_84faa044 + "_end_unpowered_anim", 0);
        var_263dadfc clearanim(var_623cf36, 0);
        var_263dadfc clearanim(var_2e757f3, 0);
        var_263dadfc clearanim(var_c80f5bb9, 0);
        var_ca5e193e = 0.1;
        var_f6c62f08 = 1 + (var_84faa044 - 1) * var_ca5e193e;
        switch (var_dda27c05) {
        case 0:
            var_263dadfc animation::play(var_50a3a8f7, undefined, undefined, 1);
            break;
        case 1:
            mdl_body thread animation::play(var_baade4f6, undefined, undefined, var_f6c62f08);
            var_263dadfc animation::play(var_be4e383, undefined, undefined, var_f6c62f08);
            break;
        case 2:
            mdl_body thread animation::play(var_60c12291, undefined, undefined, 1);
            var_263dadfc animation::play(var_b2e31b1e, undefined, undefined, 1);
            break;
        case 3:
            var_263dadfc animation::play(var_623cf36, undefined, undefined, 1);
            break;
        case 4:
            exploder::exploder("zm_gumball_pipe_" + var_84faa044);
            var_263dadfc animation::play(var_2e757f3, undefined, undefined, 1);
            exploder::stop_exploder("zm_gumball_pipe_" + var_84faa044);
            break;
        case 5:
            var_263dadfc animation::play(var_c80f5bb9, undefined, undefined, 1);
            level notify(#"hash_b1090686");
            break;
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa73e5586, Offset: 0x8c20
    // Size: 0x5e
    function function_31044f9a(localclientnum, var_65daa900) {
        for (var_22f33582 = 0; var_22f33582 < 4; var_22f33582++) {
            self thread function_7b0193a1(localclientnum, var_65daa900, var_22f33582);
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0xdec6d0ea, Offset: 0x8bc8
    // Size: 0x4e
    function function_fdee7b95(localclientnum) {
        for (var_65daa900 = 0; var_65daa900 < 3; var_65daa900++) {
            self thread function_31044f9a(localclientnum, var_65daa900);
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 3, eflags: 0x1 linked
    // Checksum 0x1d2d4be6, Offset: 0x8b48
    // Size: 0x74
    function function_6311c6fb(localclientnum, var_c268ab, var_dda27c05) {
        var_467a5275 = function_8dd5b778(var_c268ab - 1);
        [[ self.var_bcc64605[var_c268ab - 1] ]]->function_ff34eb22(localclientnum, var_dda27c05, var_467a5275);
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9617a011, Offset: 0x89d0
    // Size: 0x170
    function function_a81cf932(localclientnum) {
        for (i = 0; i < 3; i++) {
            if (!function_8dd5b778(i)) {
                continue;
            }
            if (self.var_c81cd753[i] === "POWER_BOOST") {
                thread [[ self.var_bcc64605[i] ]]->function_441bde3c(localclientnum, level._effect["ui/fx_megachew_ball_power_boost"], "tag_ball_0", 0.5);
                continue;
            }
            if (self.var_c81cd753[i] === "DOUBLE_UP") {
                thread [[ self.var_bcc64605[i] ]]->function_441bde3c(localclientnum, level._effect["ui/fx_megachew_ball_double"], "tag_ball_0", 0.5);
                continue;
            }
            if (self.var_c81cd753[i] === "FREE_VIAL") {
                thread [[ self.var_bcc64605[i] ]]->function_441bde3c(localclientnum, level._effect["ui/fx_megachew_ball_divinium"], "tag_ball_0", 0.5);
            }
        }
        wait(0.5);
    }

    // Namespace namespace_df7b1a9b
    // Params 2, eflags: 0x1 linked
    // Checksum 0xeb941250, Offset: 0x88f0
    // Size: 0xd4
    function function_5bb9a8c3(var_65daa900, var_a5de80dd) {
        switch (var_a5de80dd) {
        case 242:
            var_a58a7b24 = "zm_gumball_purple_machine_";
            break;
        case 243:
            var_a58a7b24 = "zm_gumball_orange_machine_";
            break;
        case 240:
            var_a58a7b24 = "zm_gumball_blue_machine_";
            break;
        case 244:
            var_a58a7b24 = "zm_gumball_green_machine_";
            break;
        }
        exploder::exploder(var_a58a7b24 + var_65daa900);
        level waittill(#"hash_7e96273a");
        exploder::stop_exploder(var_a58a7b24 + var_65daa900);
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5210cd90, Offset: 0x8560
    // Size: 0x386
    function function_6484d763(localclientnum) {
        for (i = 0; i < 3; i++) {
            var_62ad21f3 = function_670a0ffe(i);
            if (var_62ad21f3) {
                if (self.var_c81cd753[i] === "FREE_VIAL") {
                    self thread function_5bb9a8c3(i + 1, "round");
                    thread [[ self.var_bcc64605[i] ]]->function_441bde3c(localclientnum, level._effect["ui/fx_megachew_ball_power_boost"], "tag_ball_0", 1);
                } else {
                    var_a5de80dd = tablelookup("gamedata/stats/zm/zm_statstable.csv", 4, self.var_c81cd753[i], 20);
                    self thread function_5bb9a8c3(i + 1, var_a5de80dd);
                    switch (var_a5de80dd) {
                    case 242:
                        thread [[ self.var_bcc64605[i] ]]->function_441bde3c(localclientnum, level._effect["megachew_gumball_poof_purple"]);
                        break;
                    case 243:
                        thread [[ self.var_bcc64605[i] ]]->function_441bde3c(localclientnum, level._effect["megachew_gumball_poof_orange"]);
                        break;
                    case 240:
                        thread [[ self.var_bcc64605[i] ]]->function_441bde3c(localclientnum, level._effect["megachew_gumball_poof_blue"]);
                        break;
                    case 244:
                        thread [[ self.var_bcc64605[i] ]]->function_441bde3c(localclientnum, level._effect["megachew_gumball_poof_green"]);
                        break;
                    }
                }
                [[ self.var_bcc64605[i] ]]->function_ecd47aa9();
                continue;
            }
            if (function_8dd5b778(i)) {
                if (self.var_c81cd753[i] === "POWER_BOOST") {
                    self thread function_5bb9a8c3(i + 1, "round");
                    thread [[ self.var_bcc64605[i] ]]->function_441bde3c(localclientnum, level._effect["ui/fx_megachew_ball_divinium"], "tag_ball_0", 1);
                } else if (self.var_c81cd753[i] === "DOUBLE_UP") {
                    self thread function_5bb9a8c3(i + 1, "round");
                    thread [[ self.var_bcc64605[i] ]]->function_441bde3c(localclientnum, level._effect["ui/fx_megachew_ball_double"], "tag_ball_0", 1);
                }
                [[ self.var_bcc64605[i] ]]->function_ecd47aa9();
            }
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 4, eflags: 0x1 linked
    // Checksum 0x8ad2a53e, Offset: 0x84b0
    // Size: 0xa4
    function function_c7a5623d(mdl_model, var_3dbb27c6, var_43899630, var_8930339) {
        mdl_model clearanim(var_3dbb27c6, 0.1);
        mdl_model animation::play(var_43899630, undefined, undefined, 1, 0.1);
        mdl_model thread animation::play(var_8930339, undefined, undefined, 1, 0.1);
    }

    // Namespace namespace_df7b1a9b
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa24ca18f, Offset: 0x80e8
    // Size: 0x3ba
    function function_391d29bf(localclientnum, var_48d243ae) {
        switch (var_48d243ae) {
        case 0:
            var_d9508af5 = "p7_fxanim_zm_bgb_gears_idle_anim";
            var_98e65d7c = "p7_fxanim_zm_bgb_gear_01_idle_anim";
            var_df72b01b = "p7_fxanim_zm_bgb_gears_end_anim";
            var_6a05bb84 = "p7_fxanim_zm_bgb_gear_01_end_anim";
            break;
        case 1:
            var_d9508af5 = "p7_fxanim_zm_bgb_gears_active_anim";
            var_98e65d7c = "p7_fxanim_zm_bgb_gear_01_active_anim";
            var_df72b01b = "p7_fxanim_zm_bgb_gears_idle_anim";
            var_6a05bb84 = "p7_fxanim_zm_bgb_gear_01_idle_anim";
            break;
        case 2:
            var_d9508af5 = "p7_fxanim_zm_bgb_gears_end_anim";
            var_98e65d7c = "p7_fxanim_zm_bgb_gear_01_end_anim";
            var_df72b01b = "p7_fxanim_zm_bgb_gears_active_anim";
            var_6a05bb84 = "p7_fxanim_zm_bgb_gear_01_active_anim";
            break;
        }
        if (var_48d243ae === 2) {
            foreach (var_f13fd0e7 in self.var_668bac73) {
                self thread function_c7a5623d(var_f13fd0e7, var_df72b01b, "p7_fxanim_zm_bgb_gears_end_anim", "p7_fxanim_zm_bgb_gears_idle_anim");
            }
            foreach (var_98d6609c in self.var_664075b8) {
                self thread function_c7a5623d(var_98d6609c, var_df72b01b, "p7_fxanim_zm_bgb_gear_01_end_anim", "p7_fxanim_zm_bgb_gear_01_idle_anim");
            }
            return;
        }
        foreach (var_f13fd0e7 in self.var_668bac73) {
            var_f13fd0e7 clearanim(var_df72b01b, 0.1);
            var_f13fd0e7 thread animation::play(var_d9508af5, undefined, undefined, 1, 0.1);
        }
        foreach (var_98d6609c in self.var_664075b8) {
            var_98d6609c clearanim(var_6a05bb84, 0.1);
            var_98d6609c thread animation::play(var_98e65d7c, undefined, undefined, 1, 0.1);
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa3470965, Offset: 0x7860
    // Size: 0x87e
    function function_9111df18(localclientnum, var_dda27c05) {
        switch (var_dda27c05) {
        case 0:
            self.var_f554edc7 = 0;
            function_abb52ef2(localclientnum);
            self thread function_391d29bf(localclientnum, 0);
            function_28c320ea(localclientnum, 0);
            for (i = 1; i <= 3; i++) {
                [[ self.var_f8fc4d19[i - 1] ]]->function_62f4b701(localclientnum, 0, 0);
                [[ self.var_65cfffed[i - 1] ]]->function_f9042a9d(0);
            }
            for (i = 1; i <= 3; i++) {
                self thread function_6311c6fb(localclientnum, i, 0);
            }
            break;
        case 1:
            self thread function_fdee7b95(localclientnum);
            for (i = 0; i < 3; i++) {
                var_467a5275 = function_8dd5b778(i);
                [[ self.var_f8fc4d19[i] ]]->function_62f4b701(localclientnum, 1, var_467a5275);
                [[ self.var_65cfffed[i] ]]->function_f9042a9d(var_467a5275);
            }
            self thread function_391d29bf(localclientnum, 1);
            wait(0.2);
            for (i = 1; i <= 3; i++) {
                self thread function_afb1aa26(localclientnum, i, var_dda27c05);
            }
            for (i = 1; i <= 3; i++) {
                self thread function_6311c6fb(localclientnum, i, var_dda27c05);
            }
            wait(0.2);
            function_28c320ea(localclientnum, 1);
            break;
        case 2:
            level flag::set("megachew_carousel_show_result");
            for (i = 1; i <= 3; i++) {
                self thread function_afb1aa26(localclientnum, i, 2);
                self thread function_6311c6fb(localclientnum, i, var_dda27c05);
                if (function_670a0ffe(i - 1)) {
                    thread [[ self.var_f8fc4d19[i - 1] ]]->function_9a4e22cc(localclientnum);
                }
            }
            self thread function_391d29bf(localclientnum, 2);
            wait(0.25);
            for (i = 0; i < 3; i++) {
                [[ self.var_f8fc4d19[i] ]]->function_d9405817(localclientnum, 0);
                [[ self.var_65cfffed[i] ]]->function_f9042a9d(0);
            }
            wait(0.25);
            function_a81cf932(localclientnum);
            if (self.var_f554edc7) {
                wait(0.125);
                for (i = 0; i < 3; i++) {
                    [[ self.var_f8fc4d19[i] ]]->function_62f4b701(localclientnum, 0, 1);
                    [[ self.var_65cfffed[i] ]]->function_f9042a9d(1);
                }
            }
            for (i = 1; i <= 3; i++) {
                [[ self.var_f8fc4d19[i - 1] ]]->function_75246ac0(localclientnum, 0);
            }
            for (i = 1; i <= 3; i++) {
                if (function_670a0ffe(i - 1)) {
                    [[ self.var_65cfffed[i - 1] ]]->function_35919adb(0);
                    self thread function_afb1aa26(localclientnum, i, 3);
                }
            }
            wait(0.5);
            self thread function_6484d763(localclientnum);
            wait(0.25);
            function_28c320ea(localclientnum, 0);
            wait(0.5);
            for (i = 1; i <= 3; i++) {
                if (function_670a0ffe(i - 1)) {
                    self thread function_afb1aa26(localclientnum, i, 4);
                }
            }
            wait(0.25 * pow(2, self.var_426dfc6f));
            for (i = 1; i <= 3; i++) {
                if (function_670a0ffe(i - 1)) {
                    self thread function_afb1aa26(localclientnum, i, 5);
                }
            }
            for (i = 1; i <= 3; i++) {
                if (function_670a0ffe(i - 1)) {
                    [[ self.var_65cfffed[i - 1] ]]->function_35919adb(1);
                }
            }
            for (i = 0; i < 3; i++) {
                [[ self.var_f8fc4d19[i] ]]->function_205cc563(localclientnum, 0);
            }
            for (i = 0; i < 3; i++) {
                [[ self.var_bcc64605[i] ]]->function_ecd47aa9();
            }
            break;
        case 3:
            level notify(#"hash_7e96273a");
            self thread function_391d29bf(localclientnum, 2);
            function_28c320ea(localclientnum, 0);
            for (i = 1; i <= 3; i++) {
                self thread function_6311c6fb(localclientnum, i, var_dda27c05);
                self thread function_afb1aa26(localclientnum, i, 2);
            }
            for (i = 0; i < 3; i++) {
                [[ self.var_bcc64605[i] ]]->function_ecd47aa9();
            }
            break;
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 4, eflags: 0x1 linked
    // Checksum 0xcdb28aa6, Offset: 0x7750
    // Size: 0x108
    function function_98591098(mdl_base, var_68ee4eae, str_tag, str_notify) {
        if (!isdefined(mdl_base.var_9dd0a3f1)) {
            mdl_base.var_9dd0a3f1 = [];
        }
        if (isdefined(mdl_base.var_9dd0a3f1[str_tag])) {
            mdl_base detach(mdl_base.var_9dd0a3f1[str_tag], str_tag);
        }
        mdl_base attach(var_68ee4eae, str_tag);
        mdl_base.var_9dd0a3f1[str_tag] = var_68ee4eae;
        level waittill(str_notify);
        mdl_base detach(var_68ee4eae, str_tag);
        mdl_base.var_9dd0a3f1[str_tag] = undefined;
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5313ad3, Offset: 0x7540
    // Size: 0x204
    function function_eaf86658(localclientnum) {
        self.var_43191281 = 0;
        for (var_65daa900 = 1; var_65daa900 <= 3; var_65daa900++) {
            str_model = function_d15f1610(var_65daa900 - 1, 0);
            if (self.var_c81cd753[var_65daa900 - 1] === "POWER_BOOST") {
                continue;
            }
            if (self.var_c81cd753[var_65daa900 - 1] === "DOUBLE_UP") {
                continue;
            }
            if (var_65daa900 <= self.var_70090deb || self.var_f554edc7) {
                var_985bc9c2 = int(pow(2, self.var_426dfc6f));
                for (i = 0; i < var_985bc9c2; i++) {
                    str_notify = "megachew_factory_cycle_complete";
                    mdl_ball = self.var_83352c11[self.var_43191281];
                    var_263dadfc = self.var_c12784e3[var_65daa900 - 1];
                    self thread function_98591098(mdl_ball, str_model, "tag_ball_" + self.var_43191281, str_notify);
                    self thread function_98591098(var_263dadfc, str_model, "tag_ball_" + i, str_notify);
                    self.var_43191281 += 1;
                }
            }
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6bbe4440, Offset: 0x7528
    // Size: 0xc
    function function_aa29ec18(var_65daa900) {
        
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5a507618, Offset: 0x74d0
    // Size: 0x4a
    function function_8dd5b778(var_65daa900) {
        if (!isdefined(self.var_70090deb)) {
            return false;
        }
        if (isdefined(self.var_f554edc7) && (var_65daa900 < self.var_70090deb || self.var_f554edc7)) {
            return true;
        }
        return false;
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2b4221e5, Offset: 0x7480
    // Size: 0x48
    function function_8092a3a4(var_65daa900) {
        if (self.var_c81cd753[var_65daa900] === "POWER_BOOST") {
            return false;
        }
        if (self.var_c81cd753[var_65daa900] === "DOUBLE_UP") {
            return false;
        }
        return true;
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0x90a24367, Offset: 0x7430
    // Size: 0x46
    function function_670a0ffe(var_65daa900) {
        if (function_8092a3a4(var_65daa900) && function_8dd5b778(var_65daa900)) {
            return true;
        }
        return false;
    }

    // Namespace namespace_df7b1a9b
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa2688eb5, Offset: 0x7320
    // Size: 0x102
    function function_5c92770() {
        n_roll = randomint(100);
        if (n_roll < 85) {
            var_123b4aed = tablelookup("gamedata/stats/zm/zm_statstable.csv", 0, function_d11da34a(), 4);
            var_881e36c1 = "p7_" + var_123b4aed + "_ui_large";
        } else if (n_roll < 90) {
            var_881e36c1 = "p7_zm_bgb_wildcard_vial" + "_large";
        } else if (n_roll < 95) {
            var_881e36c1 = "p7_zm_bgb_wildcard_2x" + "_large";
        } else {
            var_881e36c1 = "p7_zm_bgb_wildcard_boost" + "_large";
        }
        return var_881e36c1;
    }

    // Namespace namespace_df7b1a9b
    // Params 0, eflags: 0x1 linked
    // Checksum 0xae75a60a, Offset: 0x72c8
    // Size: 0x4a
    function function_d11da34a() {
        var_2b620d78 = -40;
        var_a808bd2c = -23;
        return randomintrange(var_2b620d78, var_a808bd2c + 1);
    }

    // Namespace namespace_df7b1a9b
    // Params 2, eflags: 0x1 linked
    // Checksum 0x88d09c64, Offset: 0x7188
    // Size: 0x132
    function function_d15f1610(var_65daa900, var_332d5ba9) {
        switch (self.var_c81cd753[var_65daa900]) {
        case 212:
            var_881e36c1 = "p7_zm_bgb_wildcard_boost" + "_large";
            break;
        case 214:
            var_881e36c1 = "p7_zm_bgb_wildcard_2x" + "_large";
            break;
        case 216:
            if (var_332d5ba9) {
                var_881e36c1 = "p7_zm_bgb_wildcard_vial" + "_large";
            } else {
                var_881e36c1 = "p7_zm_bgb_wildcard_vial" + "_small";
            }
            break;
        default:
            if (var_332d5ba9) {
                var_881e36c1 = "p7_" + self.var_c81cd753[var_65daa900] + "_ui_large";
            } else {
                var_881e36c1 = "p7_" + self.var_c81cd753[var_65daa900] + "_ui_small";
            }
            break;
        }
        return var_881e36c1;
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8a9995a4, Offset: 0x7100
    // Size: 0x7e
    function function_abb52ef2(localclientnum) {
        for (i = 0; i < 3; i++) {
            setuimodelvalue(self.var_c629c716[i], "");
            function_c8a456c2(localclientnum, i + 1, 0);
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0x4f661fc9, Offset: 0x70b0
    // Size: 0x48
    function function_8464153(localclientnum) {
        while (true) {
            playrumbleonposition(localclientnum, "damage_light", (-3243, 2521, 101));
            wait(0.1);
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0x70923e08, Offset: 0x6e88
    // Size: 0x21a
    function function_212ad581(localclientnum) {
        level notify(#"hash_7e96273a");
        [[ self.var_df0660b0 ]]->function_c8f331c(localclientnum, 0);
        function_1fdaf4e2(localclientnum, 1);
        function_9111df18(localclientnum, 0);
        [[ self.var_8c57c6d3 ]]->function_8ab5d4f1(localclientnum, 0);
        for (var_4d37bbe9 = 1; var_4d37bbe9 <= 3; var_4d37bbe9++) {
            exploder::stop_exploder("zm_gumball_" + var_4d37bbe9);
        }
        level notify(#"hash_82273030");
        level flag::clear("megachew_sequence_active");
        for (i = 1; i <= 3; i++) {
            mdl_body = self.var_8be59e45[i - 1];
            mdl_body clearanim("p7_fxanim_zm_bgb_body_active_powered_anim", 0);
            mdl_body clearanim("p7_fxanim_zm_bgb_body_end_powered_anim", 0);
            mdl_body clearanim("p7_fxanim_zm_bgb_body_active_unpowered_anim", 0);
            mdl_body clearanim("p7_fxanim_zm_bgb_body_end_unpowered_anim", 0);
            if (isdefined(self.var_70090deb)) {
                self thread function_afb1aa26(localclientnum, i, 0);
            }
        }
        for (i = 0; i < 3; i++) {
            [[ self.var_bcc64605[i] ]]->function_ecd47aa9();
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 2, eflags: 0x1 linked
    // Checksum 0x43c27268, Offset: 0x6980
    // Size: 0x4fc
    function activate(localclientnum, var_4d37bbe9) {
        level flag::set("megachew_sequence_active");
        self.var_70090deb = var_4d37bbe9;
        self.var_c81cd753 = array(undefined, undefined, undefined);
        level flag::clear("megachew_carousel_show_result");
        thread [[ self.var_df0660b0 ]]->function_c8f331c(localclientnum, 1);
        exploder::exploder("zm_gumball_" + var_4d37bbe9);
        thread [[ self.var_8c57c6d3 ]]->press_button(localclientnum, var_4d37bbe9);
        wait(0.1);
        function_9111df18(localclientnum, 1);
        [[ self.var_8c57c6d3 ]]->function_c379aa(localclientnum, 1);
        success, var_a7cdb06b, var_81cb3602, var_5bc8bb99 = level waittill(#"hash_b521c328");
        self.var_c81cd753[0] = var_a7cdb06b;
        self.var_c81cd753[1] = var_81cb3602;
        self.var_c81cd753[2] = var_5bc8bb99;
        if (!success || "" == var_a7cdb06b || "" == var_81cb3602 || "" == var_5bc8bb99) {
            function_9111df18(localclientnum, 3);
            [[ self.var_df0660b0 ]]->function_c8f331c(localclientnum, 0);
            [[ self.var_df0660b0 ]]->function_aa6d32cd(localclientnum);
        } else {
            function_cad50ca5();
            for (i = 0; i < 3; i++) {
                if (self.var_c81cd753[i] === "POWER_BOOST") {
                    str_item_name = "ZMUI_MEGACHEW_POWER_BOOST";
                } else if (self.var_c81cd753[i] === "DOUBLE_UP") {
                    str_item_name = "ZMUI_MEGACHEW_DOUBLER";
                } else if (self.var_c81cd753[i] === "FREE_VIAL") {
                    str_item_name = "ZMUI_MEGACHEW_VIAL";
                } else {
                    str_item_name = tablelookup("gamedata/stats/zm/zm_statstable.csv", 4, self.var_c81cd753[i], 3);
                    str_item_name += "_FACTORY_CAPS";
                }
                if (function_8dd5b778(i)) {
                    function_c8a456c2(localclientnum, i + 1, 2);
                } else {
                    function_c8a456c2(localclientnum, i + 1, 1);
                }
                setuimodelvalue(self.var_c629c716[i], str_item_name);
            }
            function_eaf86658(localclientnum);
            [[ self.var_df0660b0 ]]->function_c8f331c(localclientnum, 0);
            [[ self.var_df0660b0 ]]->function_aa6d32cd(localclientnum);
            function_9111df18(localclientnum, 2);
            wait(0.125);
            exploder::exploder("zm_gumball_pipe");
            for (i = 0; i < 3; i++) {
                function_ef1ebe78(localclientnum, i);
            }
            exploder::stop_exploder("zm_gumball_pipe");
        }
        function_9111df18(localclientnum, 0);
        [[ self.var_8c57c6d3 ]]->function_c379aa(localclientnum, 0);
        exploder::stop_exploder("zm_gumball_" + var_4d37bbe9);
        level notify(#"hash_82273030");
        level flag::clear("megachew_sequence_active");
    }

    // Namespace namespace_df7b1a9b
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7e096d6f, Offset: 0x6910
    // Size: 0x64
    function function_2b1651c(localclientnum, var_4d37bbe9) {
        [[ self.var_8c57c6d3 ]]->function_2b1651c(localclientnum, var_4d37bbe9);
        setuimodelvalue(self.var_ffb3dc8a, "ZMUI_MEGACHEW_" + var_4d37bbe9 + 1 + "_TOKEN");
    }

    // Namespace namespace_df7b1a9b
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa42532da, Offset: 0x68a0
    // Size: 0x64
    function function_1fdaf4e2(localclientnum, var_d9cd47bf) {
        if (!isdefined(var_d9cd47bf)) {
            var_d9cd47bf = 0;
        }
        [[ self.var_df0660b0 ]]->function_ce2f631(localclientnum, self.var_c10b8ff3);
        if (var_d9cd47bf) {
            [[ self.var_df0660b0 ]]->function_aa6d32cd(localclientnum);
        }
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa15fefd4, Offset: 0x6880
    // Size: 0x18
    function function_f02acef4(var_971a0262) {
        self.var_c10b8ff3 = var_971a0262;
    }

    // Namespace namespace_df7b1a9b
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe335d596, Offset: 0x5a70
    // Size: 0xe04
    function init(localclientnum) {
        self.var_e522183c = [];
        self.var_641411e7 = [];
        self.var_c12784e3 = [];
        self.var_8be59e45 = [];
        self.var_dfffc7fc = [];
        var_a156e3de = [];
        self.var_83352c11 = [];
        self.var_ffb3dc8a = createuimodel(getglobaluimodel(), "MegaChewLabelInstructions");
        self.var_c629c716 = [];
        self.var_c629c716[0] = createuimodel(getglobaluimodel(), "MegaChewLabelLeft");
        self.var_c629c716[1] = createuimodel(getglobaluimodel(), "MegaChewLabelMiddle");
        self.var_c629c716[2] = createuimodel(getglobaluimodel(), "MegaChewLabelRight");
        function_abb52ef2(localclientnum);
        self.var_668bac73 = getentarray(localclientnum, "ambient_gearbox", "targetname");
        foreach (var_f13fd0e7 in self.var_668bac73) {
            var_f13fd0e7 useanimtree(#generic);
        }
        self.var_664075b8 = getentarray(localclientnum, "ambient_gear", "targetname");
        foreach (var_98d6609c in self.var_664075b8) {
            var_98d6609c useanimtree(#generic);
        }
        self.var_1e7662f3 = getent(localclientnum, "tube_front", "targetname");
        self.var_1e7662f3 useanimtree(#generic);
        level._effect["megachew_gumball_poof_out"] = "ui/fx_megachew_ball_poof_01";
        level._effect["megachew_gumball_poof_blue"] = "ui/fx_megachew_ball_poof_blue";
        level._effect["megachew_gumball_poof_green"] = "ui/fx_megachew_ball_poof_green";
        level._effect["megachew_gumball_poof_orange"] = "ui/fx_megachew_ball_poof_orange";
        level._effect["megachew_gumball_poof_purple"] = "ui/fx_megachew_ball_poof_purple";
        level._effect["megachew_gumball_power_boost"] = "ui/fx_megachew_ball_power_boost";
        level._effect["megachew_vat_electrode_lg"] = "ui/fx_megachew_vat_electrode_lg_loop";
        level._effect["megachew_vat_electrode_sm"] = "ui/fx_megachew_vat_electrode_sm_loop";
        level._effect["megachew_vat_light_lg"] = "ui/fx_megachew_vat_light_lg_loop";
        level._effect["megachew_vat_light_sm"] = "ui/fx_megachew_vat_light_sm_loop";
        level._effect["megachew_vat_whistle"] = "ui/fx_megachew_vat_whistle_loop";
        level._effect["megachew_vat_electrode_center_lg"] = "ui/fx_megachew_vat_electrode_center_lg_loop";
        level._effect["megachew_vat_electrode_center_sm"] = "ui/fx_megachew_vat_electrode_center_sm_loop";
        level._effect["megachew_vat_electrode_surge_lg"] = "ui/fx_megachew_vat_electrode_surge_lg";
        level._effect["megachew_vat_electrode_surge_sm"] = "ui/fx_megachew_vat_electrode_surge_sm";
        level._effect["megachew_vat_whistle_sm"] = "ui/fx_megachew_vat_whistle_sm_loop";
        level._effect["ui/fx_megachew_ball_divinium"] = "ui/fx_megachew_ball_divinium";
        level._effect["ui/fx_megachew_ball_double"] = "ui/fx_megachew_ball_double";
        level._effect["ui/fx_megachew_ball_power_boost"] = "ui/fx_megachew_ball_power_boost";
        level._effect["ui/fx_megachew_ball_divinium"] = "ui/fx_megachew_ball_divinium";
        level._effect["ui/fx_megachew_ball_double"] = "ui/fx_megachew_ball_double";
        level._effect["ui/fx_megachew_ball_power_boost"] = "ui/fx_megachew_ball_power_boost";
        level flag::init("megachew_sequence_active");
        if (!isdefined(self.var_bcc64605)) {
            self.var_bcc64605 = [];
            for (i = 0; i < 3; i++) {
                if (!isdefined(self.var_bcc64605[i])) {
                    self.var_bcc64605[i] = new class_7c51d14d();
                    [[ self.var_bcc64605[i] ]]->init(localclientnum, i + 1);
                }
            }
        }
        if (!isdefined(self.var_f8fc4d19)) {
            self.var_f8fc4d19 = [];
            for (i = 0; i < 3; i++) {
                if (!isdefined(self.var_f8fc4d19[i])) {
                    self.var_f8fc4d19[i] = new class_67b49468();
                    [[ self.var_f8fc4d19[i] ]]->init(localclientnum, i + 1);
                }
            }
        }
        if (!isdefined(self.var_65cfffed)) {
            self.var_65cfffed = [];
            for (i = 0; i < 3; i++) {
                if (!isdefined(self.var_65cfffed[i])) {
                    self.var_65cfffed[i] = new class_2a92124e();
                    [[ self.var_65cfffed[i] ]]->init(localclientnum, i + 1);
                }
            }
        }
        if (!isdefined(self.var_8c57c6d3)) {
            self.var_8c57c6d3 = new class_513a44f6();
            [[ self.var_8c57c6d3 ]]->init(localclientnum);
        }
        var_605e5ed8 = getuimodel(getglobaluimodel(), "MegaChewFactoryVialDisplay");
        self.var_c10b8ff3 = getuimodelvalue(var_605e5ed8);
        if (self.var_c10b8ff3 > 999) {
            self.var_c10b8ff3 = 999;
        }
        if (!isdefined(self.var_df0660b0)) {
            self.var_df0660b0 = new class_cc6fa95d();
            [[ self.var_df0660b0 ]]->init(localclientnum, self.var_c10b8ff3);
        }
        for (i = 1; i <= 3; i++) {
            var_d4d80499 = "megachew_factory_door_" + i + "_anim_done";
            if (!isdefined(self.var_e522183c)) {
                self.var_e522183c = [];
            } else if (!isarray(self.var_e522183c)) {
                self.var_e522183c = array(self.var_e522183c);
            }
            self.var_e522183c[self.var_e522183c.size] = var_d4d80499;
            level flag::init(var_d4d80499);
            var_263dadfc = getent(localclientnum, "bgb_0" + i + "_dome", "targetname");
            if (!var_263dadfc hasanimtree()) {
                var_263dadfc useanimtree(#generic);
            }
            if (!isdefined(self.var_c12784e3)) {
                self.var_c12784e3 = [];
            } else if (!isarray(self.var_c12784e3)) {
                self.var_c12784e3 = array(self.var_c12784e3);
            }
            self.var_c12784e3[self.var_c12784e3.size] = var_263dadfc;
            mdl_body = getent(localclientnum, "bgb_0" + i + "_body", "targetname");
            if (!mdl_body hasanimtree()) {
                mdl_body useanimtree(#generic);
            }
            if (!isdefined(self.var_8be59e45)) {
                self.var_8be59e45 = [];
            } else if (!isarray(self.var_8be59e45)) {
                self.var_8be59e45 = array(self.var_8be59e45);
            }
            self.var_8be59e45[self.var_8be59e45.size] = mdl_body;
            mdl_door = getent(localclientnum, "main_doors_0" + i, "targetname");
            if (!mdl_door hasanimtree()) {
                mdl_door useanimtree(#generic);
            }
            if (!isdefined(self.var_dfffc7fc)) {
                self.var_dfffc7fc = [];
            } else if (!isarray(self.var_dfffc7fc)) {
                self.var_dfffc7fc = array(self.var_dfffc7fc);
            }
            self.var_dfffc7fc[self.var_dfffc7fc.size] = mdl_door;
        }
        for (i = 0; i < 6; i++) {
            var_134fb6ff = "tube_ball_" + i;
            mdl_ball = getent(localclientnum, var_134fb6ff, "targetname");
            mdl_ball hidepart(localclientnum, "tag_ball_" + i);
            if (!mdl_ball hasanimtree()) {
                mdl_ball useanimtree(#generic);
            }
            if (!isdefined(self.var_83352c11)) {
                self.var_83352c11 = [];
            } else if (!isarray(self.var_83352c11)) {
                self.var_83352c11 = array(self.var_83352c11);
            }
            self.var_83352c11[self.var_83352c11.size] = mdl_ball;
            var_fd4ab0c8 = "megachew_factory_result_" + i + "_anim_done";
            if (!isdefined(self.var_641411e7)) {
                self.var_641411e7 = [];
            } else if (!isarray(self.var_641411e7)) {
                self.var_641411e7 = array(self.var_641411e7);
            }
            self.var_641411e7[self.var_641411e7.size] = var_fd4ab0c8;
            level flag::init(var_fd4ab0c8);
        }
        level flag::init("megachew_carousel_show_result");
        self thread function_9111df18(localclientnum, 0);
        function_2b1651c(localclientnum, 0);
    }

}

// Namespace frontend
// Method(s) 11 Total 11
class class_67b49468 {

    // Namespace namespace_67b49468
    // Params 4, eflags: 0x5 linked
    // Checksum 0xd705a08d, Offset: 0xb850
    // Size: 0x94
    function function_c857e43f(localclientnum, str_fx, str_tag, var_40276d2a) {
        if (!isdefined(var_40276d2a)) {
            var_40276d2a = 2;
        }
        fx_id = playfxontag(localclientnum, str_fx, self.var_1b7928a0, str_tag);
        wait(var_40276d2a);
        stopfx(localclientnum, fx_id);
    }

    // Namespace namespace_67b49468
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc444a32f, Offset: 0xb650
    // Size: 0x1f6
    function function_9a4e22cc(localclientnum) {
        switch (self.var_ac86d96c) {
        case 1:
            break;
        case 2:
            self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_sm"], "tag_dome2_elect_01");
            self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_sm"], "tag_dome2_elect_02");
            self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_center_sm"], "tag_dome2_elect_cnt_01");
            break;
        case 3:
            self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_sm"], "tag_dome3_elect_01");
            self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_sm"], "tag_dome3_elect_02");
            self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_center_sm"], "tag_dome3_elect_cnt_01");
            self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_center_lg"], "tag_dome3_elect_cnt_02");
            self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_lg"], "tag_dome3_elect_03");
            self thread function_c857e43f(localclientnum, level._effect["megachew_vat_electrode_surge_lg"], "tag_dome3_elect_04");
            break;
        }
    }

    // Namespace namespace_67b49468
    // Params 4, eflags: 0x5 linked
    // Checksum 0x827522e1, Offset: 0xb470
    // Size: 0x1d6
    function function_376191fe(localclientnum, str_fx, str_tag, var_bda11dad) {
        fx_id = playfxontag(localclientnum, str_fx, self.var_1b7928a0, str_tag);
        switch (var_bda11dad) {
        case 2:
            if (!isdefined(self.var_3093c559)) {
                self.var_3093c559 = [];
            } else if (!isarray(self.var_3093c559)) {
                self.var_3093c559 = array(self.var_3093c559);
            }
            self.var_3093c559[self.var_3093c559.size] = fx_id;
            break;
        case 1:
            if (!isdefined(self.var_bbdd2958)) {
                self.var_bbdd2958 = [];
            } else if (!isarray(self.var_bbdd2958)) {
                self.var_bbdd2958 = array(self.var_bbdd2958);
            }
            self.var_bbdd2958[self.var_bbdd2958.size] = fx_id;
            break;
        case 3:
            if (!isdefined(self.var_ae72b394)) {
                self.var_ae72b394 = [];
            } else if (!isarray(self.var_ae72b394)) {
                self.var_ae72b394 = array(self.var_ae72b394);
            }
            self.var_ae72b394[self.var_ae72b394.size] = fx_id;
            break;
        }
    }

    // Namespace namespace_67b49468
    // Params 2, eflags: 0x1 linked
    // Checksum 0xd2d251fb, Offset: 0xb300
    // Size: 0x164
    function function_d9405817(localclientnum, var_844b5d83) {
        if (var_844b5d83 == 0) {
            foreach (fx_id in self.var_ae72b394) {
                stopfx(localclientnum, fx_id);
            }
            self.var_ae72b394 = [];
            return;
        }
        if (var_844b5d83 == 1) {
            function_376191fe(localclientnum, level._effect["megachew_vat_whistle_sm"], "tag_dome" + self.var_ac86d96c + "_whistle", 3);
            return;
        }
        if (var_844b5d83 == 2) {
            function_376191fe(localclientnum, level._effect["megachew_vat_whistle"], "tag_dome" + self.var_ac86d96c + "_whistle", 3);
        }
    }

    // Namespace namespace_67b49468
    // Params 2, eflags: 0x1 linked
    // Checksum 0x19e4eb38, Offset: 0xae58
    // Size: 0x49e
    function function_205cc563(localclientnum, b_on) {
        if (!b_on) {
            foreach (fx_id in self.var_bbdd2958) {
                stopfx(localclientnum, fx_id);
            }
            self.var_bbdd2958 = [];
            return;
        }
        switch (self.var_ac86d96c) {
        case 1:
            function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome1_light_01", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome1_light_02", 1);
            break;
        case 2:
            function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome2_light_01", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome2_light_02", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome2_light_03", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome2_light_04", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome2_light_06", 1);
        case 3:
            function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome3_light_01", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_lg"], "tag_dome3_light_02", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_03", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_04", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_05", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_06", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_07", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_10", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_11", 1);
            function_376191fe(localclientnum, level._effect["megachew_vat_light_sm"], "tag_dome3_light_12", 1);
            break;
        }
    }

    // Namespace namespace_67b49468
    // Params 2, eflags: 0x1 linked
    // Checksum 0xc097f528, Offset: 0xab70
    // Size: 0x2de
    function function_75246ac0(localclientnum, b_on) {
        if (!b_on) {
            foreach (fx_id in self.var_3093c559) {
                stopfx(localclientnum, fx_id);
            }
            self.var_3093c559 = [];
            return;
        }
        switch (self.var_ac86d96c) {
        case 1:
            break;
        case 2:
            function_376191fe(localclientnum, level._effect["megachew_vat_electrode_sm"], "tag_dome2_elect_01", 2);
            function_376191fe(localclientnum, level._effect["megachew_vat_electrode_sm"], "tag_dome2_elect_02", 2);
            function_376191fe(localclientnum, level._effect["megachew_vat_electrode_center_sm"], "tag_dome2_elect_cnt_01", 2);
            break;
        case 3:
            function_376191fe(localclientnum, level._effect["megachew_vat_electrode_sm"], "tag_dome3_elect_01", 2);
            function_376191fe(localclientnum, level._effect["megachew_vat_electrode_sm"], "tag_dome3_elect_02", 2);
            function_376191fe(localclientnum, level._effect["megachew_vat_electrode_center_sm"], "tag_dome3_elect_cnt_01", 2);
            function_376191fe(localclientnum, level._effect["megachew_vat_electrode_lg"], "tag_dome3_elect_03", 2);
            function_376191fe(localclientnum, level._effect["megachew_vat_electrode_lg"], "tag_dome3_elect_04", 2);
            function_376191fe(localclientnum, level._effect["megachew_vat_electrode_center_lg"], "tag_dome3_elect_cnt_02", 2);
            break;
        }
    }

    // Namespace namespace_67b49468
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb9eb8be1, Offset: 0xaaa0
    // Size: 0xc4
    function function_de87be81(localclientnum) {
        if (self.var_27ae53c5) {
            if (self.var_8d8be3f9) {
                function_d9405817(localclientnum, 2);
            } else {
                function_d9405817(localclientnum, 1);
            }
        } else {
            function_d9405817(localclientnum, 0);
        }
        wait(0.1);
        function_75246ac0(localclientnum, self.var_8d8be3f9);
        function_205cc563(localclientnum, self.var_8d8be3f9);
    }

    // Namespace namespace_67b49468
    // Params 3, eflags: 0x1 linked
    // Checksum 0xa0caf16e, Offset: 0xaa28
    // Size: 0x6c
    function function_62f4b701(localclientnum, var_3eb4c129, var_901e562d) {
        if (var_3eb4c129 != self.var_27ae53c5) {
            self.var_27ae53c5 = var_3eb4c129;
        }
        if (var_901e562d != self.var_8d8be3f9) {
            self.var_8d8be3f9 = var_901e562d;
        }
        function_de87be81(localclientnum);
    }

    // Namespace namespace_67b49468
    // Params 2, eflags: 0x1 linked
    // Checksum 0xdefbd11e, Offset: 0xa980
    // Size: 0x9c
    function init(localclientnum, var_65daa900) {
        self.var_3093c559 = [];
        self.var_bbdd2958 = [];
        self.var_ae72b394 = [];
        self.var_ac86d96c = var_65daa900;
        self.var_1b7928a0 = getent(localclientnum, "bgb_0" + var_65daa900 + "_dome", "targetname");
        self.var_27ae53c5 = 0;
        self.var_8d8be3f9 = 0;
    }

}

// Namespace frontend
// Method(s) 9 Total 9
class class_cc6fa95d {

    // Namespace namespace_cc6fa95d
    // Params 2, eflags: 0x1 linked
    // Checksum 0x1c4ef3f, Offset: 0xa6f0
    // Size: 0x86
    function function_bbf6a142(localclientnum, var_75e21c4d) {
        mdl_number = self.var_2692452d[var_75e21c4d - 1];
        for (i = 0; i < 10; i++) {
            mdl_number hidepart(localclientnum, "tag_number_" + i);
        }
    }

    // Namespace namespace_cc6fa95d
    // Params 3, eflags: 0x1 linked
    // Checksum 0x817af470, Offset: 0xa618
    // Size: 0xce
    function function_8bbe8655(localclientnum, var_75e21c4d, n_digit) {
        mdl_number = self.var_2692452d[var_75e21c4d - 1];
        for (i = 0; i < 10; i++) {
            if (i === n_digit) {
                mdl_number showpart(localclientnum, "tag_number_" + i);
                continue;
            }
            mdl_number hidepart(localclientnum, "tag_number_" + i);
        }
    }

    // Namespace namespace_cc6fa95d
    // Params 2, eflags: 0x5 linked
    // Checksum 0xcbc36598, Offset: 0xa530
    // Size: 0xe0
    function function_a77a3e55(var_75e21c4d, n_count) {
        var_7b513c34 = int(pow(10, var_75e21c4d));
        var_ed58ab6f = int(pow(10, var_75e21c4d - 1));
        var_70ae6ae6 = n_count % var_7b513c34;
        if (var_75e21c4d > 1) {
            var_70ae6ae6 -= n_count % var_ed58ab6f;
            var_70ae6ae6 /= var_ed58ab6f;
        }
        return var_70ae6ae6;
    }

    // Namespace namespace_cc6fa95d
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5b56225f, Offset: 0xa4a8
    // Size: 0x7e
    function function_aa6d32cd(localclientnum) {
        for (i = 1; i <= 3; i++) {
            n_digit = function_a77a3e55(i, self.var_39ebc94d);
            function_8bbe8655(localclientnum, i, n_digit);
        }
    }

    // Namespace namespace_cc6fa95d
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa11cf0d9, Offset: 0xa3f0
    // Size: 0xb0
    function function_c8f331c(localclientnum, b_on) {
        self notify(#"hash_1dd7e0f3");
        self endon(#"hash_1dd7e0f3");
        if (b_on) {
            while (true) {
                for (i = 1; i <= 3; i++) {
                    self thread function_bbf6a142(localclientnum, i);
                }
                wait(0.2);
                function_aa6d32cd(localclientnum);
                wait(0.2);
            }
        }
    }

    // Namespace namespace_cc6fa95d
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7908ff1a, Offset: 0xa3c8
    // Size: 0x20
    function function_ce2f631(localclientnum, n_count) {
        self.var_39ebc94d = n_count;
    }

    // Namespace namespace_cc6fa95d
    // Params 2, eflags: 0x1 linked
    // Checksum 0x57ad98aa, Offset: 0xa1f8
    // Size: 0x1c4
    function init(localclientnum, var_d5fe27d7) {
        self.var_be6614cf = getent(localclientnum, "vial_counter", "targetname");
        self.var_2692452d = [];
        self.var_39ebc94d = var_d5fe27d7;
        for (i = 0; i < 3; i++) {
            v_origin = self.var_be6614cf gettagorigin("tag_numbers_position_" + i);
            v_angles = self.var_be6614cf gettagangles("tag_numbers_position_" + i);
            mdl_number = spawn(localclientnum, v_origin, "script_model");
            mdl_number setmodel("p7_zm_bgb_nixie_number_on");
            mdl_number.angles = v_angles;
            if (!isdefined(self.var_2692452d)) {
                self.var_2692452d = [];
            } else if (!isarray(self.var_2692452d)) {
                self.var_2692452d = array(self.var_2692452d);
            }
            self.var_2692452d[self.var_2692452d.size] = mdl_number;
        }
        function_aa6d32cd(localclientnum);
    }

}

// Namespace frontend
// Method(s) 9 Total 9
class class_7c51d14d {

    // Namespace namespace_7c51d14d
    // Params 4, eflags: 0x1 linked
    // Checksum 0x9bcc782b, Offset: 0xbee8
    // Size: 0xb4
    function function_441bde3c(localclientnum, fx_id, str_tag, var_9e6999a1) {
        if (!isdefined(str_tag)) {
            str_tag = "tag_ball_0";
        }
        self.var_165c359f util::waittill_dobj(localclientnum);
        fx_id = playfxontag(localclientnum, fx_id, self.var_165c359f, str_tag);
        if (isdefined(var_9e6999a1)) {
            wait(var_9e6999a1);
            stopfx(localclientnum, fx_id);
        }
    }

    // Namespace namespace_7c51d14d
    // Params 1, eflags: 0x5 linked
    // Checksum 0x4ca323bd, Offset: 0xbe48
    // Size: 0x98
    function function_5cfdd76b(var_9bcca82d) {
        if (!isdefined(self.var_526762bf[var_9bcca82d])) {
            return;
        }
        str_model = self.var_526762bf[var_9bcca82d];
        if (self.var_165c359f isattached(str_model, "tag_ball_" + var_9bcca82d)) {
            self.var_165c359f detach(str_model, "tag_ball_" + var_9bcca82d);
        }
        self.var_526762bf[var_9bcca82d] = undefined;
    }

    // Namespace namespace_7c51d14d
    // Params 2, eflags: 0x5 linked
    // Checksum 0x21186df, Offset: 0xbdf0
    // Size: 0x4e
    function function_37558b34(var_9bcca82d, str_model) {
        self.var_165c359f attach(str_model, "tag_ball_" + var_9bcca82d);
        self.var_526762bf[var_9bcca82d] = str_model;
    }

    // Namespace namespace_7c51d14d
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb7c06e11, Offset: 0xbda0
    // Size: 0x44
    function function_1adedb74(var_9bcca82d, str_model) {
        function_5cfdd76b(var_9bcca82d);
        function_37558b34(var_9bcca82d, str_model);
    }

    // Namespace namespace_7c51d14d
    // Params 0, eflags: 0x1 linked
    // Checksum 0x246e66dc, Offset: 0xbd50
    // Size: 0x46
    function function_ecd47aa9() {
        for (i = 0; i < 4; i++) {
            function_5cfdd76b(i);
        }
    }

    // Namespace namespace_7c51d14d
    // Params 3, eflags: 0x1 linked
    // Checksum 0x55abbced, Offset: 0xbc00
    // Size: 0x144
    function function_ff34eb22(localclientnum, var_dda27c05, var_467a5275) {
        if (var_467a5275) {
            var_1ecf2c7b = "p7_fxanim_zm_bgb_carousel_active_powered_anim";
            var_4196b15c = "p7_fxanim_zm_bgb_carousel_end_powered_anim";
        } else {
            var_1ecf2c7b = "p7_fxanim_zm_bgb_carousel_active_unpowered_anim";
            var_4196b15c = "p7_fxanim_zm_bgb_carousel_end_unpowered_anim";
        }
        self.var_165c359f util::waittill_dobj(localclientnum);
        if (isdefined(self.m_str_anim)) {
            self.var_165c359f clearanim(self.m_str_anim, 0);
        }
        switch (var_dda27c05) {
        case 0:
            return;
        case 1:
            self.m_str_anim = var_1ecf2c7b;
            break;
        case 2:
            self.m_str_anim = var_4196b15c;
            break;
        case 3:
            self.m_str_anim = var_4196b15c;
            break;
        }
        self.var_165c359f animation::play(self.m_str_anim, undefined, undefined, 1);
    }

    // Namespace namespace_7c51d14d
    // Params 2, eflags: 0x1 linked
    // Checksum 0x4cf779b6, Offset: 0xbb50
    // Size: 0xa4
    function init(localclientnum, var_c268ab) {
        if (!isdefined(self.var_165c359f)) {
            self.var_165c359f = getent(localclientnum, "gumball_carousel_0" + var_c268ab, "targetname");
        }
        if (!self.var_165c359f hasanimtree()) {
            self.var_165c359f useanimtree(#generic);
        }
        if (!isdefined(self.var_526762bf)) {
            self.var_526762bf = [];
        }
    }

}

// Namespace frontend
// Method(s) 5 Total 5
class class_2a92124e {

    // Namespace namespace_2a92124e
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd1ba7b23, Offset: 0xca80
    // Size: 0xb2
    function function_35919adb(b_on) {
        foreach (var_c59494bb in self.var_6247d870) {
            if (b_on) {
                var_c59494bb show();
                continue;
            }
            var_c59494bb hide();
        }
    }

    // Namespace namespace_2a92124e
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf8aa3ff2, Offset: 0xc878
    // Size: 0x1fe
    function function_f9042a9d(b_on) {
        for (i = 0; i < self.var_903eb306.size; i++) {
            var_c59494bb = self.var_903eb306[i];
            if (b_on) {
                var_c59494bb clearanim("p7_fxanim_zm_bgb_dial_sml_idle_anim", 0);
                var_c59494bb thread animation::play("p7_fxanim_zm_bgb_dial_sml_active_anim", undefined, undefined, 1 + i * 0.05);
                continue;
            }
            var_c59494bb clearanim("p7_fxanim_zm_bgb_dial_sml_active_anim", 0);
            var_c59494bb thread animation::play("p7_fxanim_zm_bgb_dial_sml_idle_anim", undefined, undefined, 1 + i * 0.05);
        }
        for (i = 0; i < self.var_ea9963fa.size; i++) {
            var_c59494bb = self.var_ea9963fa[i];
            if (b_on) {
                var_c59494bb clearanim("p7_fxanim_zm_bgb_dial_lrg_idle_anim", 0);
                var_c59494bb thread animation::play("p7_fxanim_zm_bgb_dial_lrg_active_anim", undefined, undefined, 1 + i * 0.05);
                continue;
            }
            var_c59494bb clearanim("p7_fxanim_zm_bgb_dial_lrg_active_anim", 0);
            var_c59494bb thread animation::play("p7_fxanim_zm_bgb_dial_lrg_idle_anim", undefined, undefined, 1 + i * 0.05);
        }
    }

    // Namespace namespace_2a92124e
    // Params 2, eflags: 0x1 linked
    // Checksum 0x14adbe43, Offset: 0xc1a8
    // Size: 0x6c4
    function init(localclientnum, var_65daa900) {
        self.var_ea9963fa = [];
        self.var_903eb306 = [];
        self.var_6247d870 = [];
        var_263dadfc = getent(localclientnum, "bgb_0" + var_65daa900 + "_dome", "targetname");
        mdl_body = getent(localclientnum, "bgb_0" + var_65daa900 + "_body", "targetname");
        for (i = 1; i <= 2; i++) {
            str_tagname = "tag_body_dial_0" + i + "_link";
            v_origin = mdl_body gettagorigin(str_tagname);
            var_c59494bb = spawn(localclientnum, v_origin, "script_model");
            var_c59494bb.angles = mdl_body gettagangles(str_tagname);
            var_c59494bb setmodel("p7_fxanim_zm_bgb_machine_dial_lrg_mod");
            var_c59494bb useanimtree(#generic);
            if (!isdefined(self.var_ea9963fa)) {
                self.var_ea9963fa = [];
            } else if (!isarray(self.var_ea9963fa)) {
                self.var_ea9963fa = array(self.var_ea9963fa);
            }
            self.var_ea9963fa[self.var_ea9963fa.size] = var_c59494bb;
        }
        if (var_65daa900 === 2) {
            str_tagname = "tag_dome2_dial_sml_01_link";
            v_origin = var_263dadfc gettagorigin(str_tagname);
            var_c59494bb = spawn(localclientnum, v_origin, "script_model");
            var_c59494bb setmodel("p7_fxanim_zm_bgb_machine_dial_sml_mod");
            var_c59494bb useanimtree(#generic);
            var_c59494bb.angles = var_263dadfc gettagangles(str_tagname);
            if (!isdefined(self.var_903eb306)) {
                self.var_903eb306 = [];
            } else if (!isarray(self.var_903eb306)) {
                self.var_903eb306 = array(self.var_903eb306);
            }
            self.var_903eb306[self.var_903eb306.size] = var_c59494bb;
            if (!isdefined(self.var_6247d870)) {
                self.var_6247d870 = [];
            } else if (!isarray(self.var_6247d870)) {
                self.var_6247d870 = array(self.var_6247d870);
            }
            self.var_6247d870[self.var_6247d870.size] = var_c59494bb;
            return;
        }
        if (var_65daa900 === 3) {
            str_tagname = "tag_dome3_dial_lrg_01_link";
            v_origin = var_263dadfc gettagorigin(str_tagname);
            var_c59494bb = spawn(localclientnum, v_origin, "script_model");
            var_c59494bb setmodel("p7_fxanim_zm_bgb_machine_dial_lrg_mod");
            var_c59494bb useanimtree(#generic);
            var_c59494bb.angles = var_263dadfc gettagangles(str_tagname);
            if (!isdefined(self.var_ea9963fa)) {
                self.var_ea9963fa = [];
            } else if (!isarray(self.var_ea9963fa)) {
                self.var_ea9963fa = array(self.var_ea9963fa);
            }
            self.var_ea9963fa[self.var_ea9963fa.size] = var_c59494bb;
            for (i = 1; i <= 4; i++) {
                str_tagname = "tag_dome3_dial_sml_0" + i + "_link";
                v_origin = var_263dadfc gettagorigin(str_tagname);
                var_c59494bb = spawn(localclientnum, v_origin, "script_model");
                var_c59494bb setmodel("p7_fxanim_zm_bgb_machine_dial_sml_mod");
                var_c59494bb useanimtree(#generic);
                var_c59494bb.angles = var_263dadfc gettagangles(str_tagname);
                if (!isdefined(self.var_903eb306)) {
                    self.var_903eb306 = [];
                } else if (!isarray(self.var_903eb306)) {
                    self.var_903eb306 = array(self.var_903eb306);
                }
                self.var_903eb306[self.var_903eb306.size] = var_c59494bb;
                if (i <= 2) {
                    if (!isdefined(self.var_6247d870)) {
                        self.var_6247d870 = [];
                    } else if (!isarray(self.var_6247d870)) {
                        self.var_6247d870 = array(self.var_6247d870);
                    }
                    self.var_6247d870[self.var_6247d870.size] = var_c59494bb;
                }
            }
        }
    }

}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0xd739b58b, Offset: 0x21e8
// Size: 0x314
function main() {
    level.callbackentityspawned = &entityspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.var_8b2854b2 = 0;
    if (!isdefined(level.var_f22d5918)) {
        level.var_f22d5918 = "mobile";
    }
    level.orbis = getdvarstring("orbisGame") == "true";
    level.durango = getdvarstring("durangoGame") == "true";
    clientfield::register("world", "first_time_flow", 1, getminbitcountfornum(1), "int", &function_1a350cd6, 0, 1);
    clientfield::register("world", "cp_bunk_anim_type", 1, getminbitcountfornum(1), "int", &function_3dcac2e2, 0, 1);
    customclass::init();
    level.var_90b3cbac = 0;
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int", &zombie_eyes_clientfield_cb, 0, 1);
    clientfield::register("scriptmover", "dni_eyes", 1000, 1, "int", &function_bcf3361d, 0, 0);
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange_frontend";
    level._effect["bgb_machine_available"] = "zombie/fx_bgb_machine_available_zmb";
    level._effect["doa_frontend_cigar_lit"] = "fire/fx_cigar_getting_lit";
    level._effect["doa_frontend_cigar_puff"] = "fire/fx_cigar_getting_lit_puff";
    level._effect["doa_frontend_cigar_ash"] = "fire/fx_cigar_ash_emit";
    level._effect["doa_frontend_cigar_ambient"] = "fire/fx_cigar_lit_ambient";
    level._effect["doa_frontend_cigar_exhale"] = "smoke/fx_smk_cigar_exhale";
    level._effect["frontend_special_day"] = "zombie/fx_val_motes_100x100";
    level thread blackscreen_watcher();
    setstreamerrequest(1, "core_frontend");
}

// Namespace frontend
// Params 7, eflags: 0x1 linked
// Checksum 0x19f30812, Offset: 0x2508
// Size: 0x3c
function function_1a350cd6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace frontend
// Params 7, eflags: 0x1 linked
// Checksum 0x6b523bb5, Offset: 0x2550
// Size: 0x3c
function function_3dcac2e2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0x22a39ee, Offset: 0x2598
// Size: 0x127c
function setupclientmenus(localclientnum) {
    lui::initmenudata(localclientnum);
    lui::createcustomcameramenu("Main", localclientnum, &lobby_main, 1);
    lui::createcameramenu("Inspection", localclientnum, "spawn_char_lobbyslide", "cac_main_lobby_camera_01", "cam1", undefined, &start_character_rotating_any, &end_character_rotating_any);
    lui::linktocustomcharacter("Inspection", localclientnum, "inspection_character");
    var_ddbfd9e3 = lui::getcharacterdataformenu("Inspection", localclientnum);
    var_ddbfd9e3.var_418b6e8a = 1;
    lui::createcameramenu("CPConfirmSelection", localclientnum, "spawn_char_custom", "c_fe_confirm_selection_cam", "cam1", undefined, &open_choose_head_menu, &close_choose_head_menu);
    lui::addmenuexploders("CPConfirmSelection", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("CPConfirmSelection", localclientnum, "character_customization");
    lui::createcustomcameramenu("PersonalizeCharacter", localclientnum, &personalize_characters_watch, 0, &start_character_rotating, &end_character_rotating);
    lui::addmenuexploders("PersonalizeCharacter", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("PersonalizeCharacter", localclientnum, "character_customization");
    lui::createcustomcameramenu("ChooseTaunts", localclientnum, &choose_taunts_camera_watch, 0);
    lui::addmenuexploders("ChooseTaunts", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("ChooseTaunts", localclientnum, "character_customization");
    lui::createcameramenu("OutfitsMainMenu", localclientnum, "spawn_char_custom", "ui_cam_character_customization", "cam_preview");
    lui::addmenuexploders("OutfitsMainMenu", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("OutfitsMainMenu", localclientnum, "character_customization");
    lui::createcameramenu("ChooseOutfit", localclientnum, "spawn_char_custom", "ui_cam_character_customization", "cam_preview", undefined, &start_character_rotating, &end_character_rotating);
    lui::addmenuexploders("ChooseOutfit", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("ChooseOutfit", localclientnum, "character_customization");
    lui::createcameramenu("ChooseHead", localclientnum, "spawn_char_custom", "ui_cam_character_customization", "cam_helmet", undefined, &open_choose_head_menu, &close_choose_head_menu);
    lui::addmenuexploders("ChooseHead", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("ChooseHead", localclientnum, "character_customization");
    lui::createcameramenu("ChoosePersonalizationCharacter", localclientnum, "room2_frontend_camera", "ui_cam_char_selection_background", "cam1", undefined, &function_8d1a05f8, &function_ef0109fe);
    lui::createcustomextracamxcamdata("ChoosePersonalizationCharacter", localclientnum, 1, &function_b9b7c881);
    lui::linktocustomcharacter("ChoosePersonalizationCharacter", localclientnum, "character_customization");
    lui::createcameramenu("ChooseCharacterLoadout", localclientnum, "room2_frontend_camera", "ui_cam_char_selection_background", "cam1", undefined, &function_8d1a05f8, &function_ef0109fe);
    lui::linktocustomcharacter("ChooseCharacterLoadout", localclientnum, "character_customization");
    lui::createcameramenu("ChooseGender", localclientnum, "room2_frontend_camera", "ui_cam_char_selection_background", "cam1");
    lui::addmenuexploders("ChooseGender", localclientnum, array("char_customization", "char_custom_bg"));
    lui::linktocustomcharacter("ChooseGender", localclientnum, "character_customization");
    lui::createcameramenu("chooseClass", localclientnum, "spawn_char_cac_choose", "ui_cam_cac_specialist", "cam_specialist", undefined, &open_choose_class, &close_choose_class);
    lui::addmenuexploders("chooseClass", localclientnum, array("char_customization", "lights_paintshop", "weapon_kick", "char_custom_bg"));
    lui::linktocustomcharacter("chooseClass", localclientnum, "character_customization");
    lui::createcustomcameramenu("Paintshop", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("Paintshop", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("Gunsmith", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("Gunsmith", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("Community", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("Community", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_Paintjobs", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_Paintjobs", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_Variants", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_Variants", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_Emblems", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_Emblems", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MyShowcase_CategorySelector", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MyShowcase_CategorySelector", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("GroupHeadquarters", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("GroupHeadquarters", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("MediaManager", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("MediaManager", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcameramenu("WeaponBuildKits", localclientnum, "zm_weapon_position", "ui_cam_cac_specialist", "cam_specialist", undefined, &function_5f5f7f43, &function_baec4b95);
    lui::addmenuexploders("WeaponBuildKits", localclientnum, array("zm_weapon_kick", "zm_weapon_room"));
    lui::createcameramenu("CombatRecordWeaponsZM", localclientnum, "zm_weapon_position", "ui_cam_cac_specialist", "cam_specialist", undefined, &function_5f5f7f43, &function_baec4b95);
    lui::addmenuexploders("CombatRecordWeaponsZM", localclientnum, array("zm_weapon_kick", "zm_weapon_room"));
    lui::createcameramenu("BubblegumBuffs", localclientnum, "zm_loadout_position", "c_fe_zm_megachew_vign_camera_2", "c_fe_zm_megachew_vign_camera_2", undefined, &function_5f5f7f43, &function_baec4b95);
    lui::addmenuexploders("BubblegumBuffs", localclientnum, array("zm_gum_kick", "zm_gum_room", "zm_gumball_room_2"));
    playfx(localclientnum, level._effect["bgb_machine_available"], (-2542, 3996, 62) + (64, -1168, 0), anglestoforward((0, 330, 0)), anglestoup((0, 330, 0)));
    lui::createcameramenu("BubblegumPacks", localclientnum, "zm_loadout_position_shift", "c_fe_zm_megachew_vign_camera_2", "c_fe_zm_megachew_vign_camera_2");
    lui::addmenuexploders("BubblegumPacks", localclientnum, array("zm_gum_kick", "zm_gum_room", "zm_gumball_room_2"));
    lui::createcustomcameramenu("BubblegumPackEdit", localclientnum, undefined, undefined, &function_d4153501, &function_6069e673);
    lui::addmenuexploders("BubblegumPackEdit", localclientnum, array("zm_weapon_kick", "zm_weapon_room", "zm_gumball_room_3"));
    lui::createcustomcameramenu("BubblegumBuffSelect", localclientnum, undefined, undefined, &function_d4153501, &function_6069e673);
    lui::addmenuexploders("BubblegumBuffSelect", localclientnum, array("zm_weapon_kick", "zm_weapon_room", "zm_gumball_room_3"));
    lui::createcustomcameramenu("CombatRecordBubblegumBuffs", localclientnum, undefined, undefined, &function_d4153501, &function_6069e673);
    lui::addmenuexploders("CombatRecordBubblegumBuffs", localclientnum, array("zm_weapon_kick", "zm_weapon_room", "zm_gumball_room_3"));
    lui::createcameramenu("MegaChewFactory", localclientnum, "zm_gum_position", "c_fe_zm_megachew_vign_camera", "default", undefined, &function_ff3c2c64, &function_de453b82);
    lui::addmenuexploders("MegaChewFactory", localclientnum, array("zm_gum_kick", "zm_gum_room"));
    lui::createcustomcameramenu("Pregame_Main", localclientnum, &lobby_main, 1);
    lui::createcameramenu("BlackMarket", localclientnum, "mp_frontend_blackmarket", "ui_cam_frontend_blackmarket", "cam_mpmain", undefined, &function_2c510839, &function_68a00f67);
    lui::createcustomcameramenu("CombatRecordWeapons", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("CombatRecordWeapons", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("CombatRecordEquipment", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("CombatRecordEquipment", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("CombatRecordCybercore", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("CombatRecordCybercore", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcustomcameramenu("CombatRecordCollectibles", localclientnum, undefined, 0, undefined, undefined);
    lui::addmenuexploders("CombatRecordCollectibles", localclientnum, array("char_customization", "char_custom_bg"));
    lui::createcameramenu("CombatRecordSpecialists", localclientnum, "spawn_char_cac_choose", "ui_cam_cac_specialist", "cam_specialist", undefined, &open_choose_class, &close_choose_class);
    lui::addmenuexploders("CombatRecordSpecialists", localclientnum, array("char_customization", "lights_paintshop", "weapon_kick", "char_custom_bg"));
    lui::linktocustomcharacter("CombatRecordSpecialists", localclientnum, "character_customization");
}

// Namespace frontend
// Params 7, eflags: 0x1 linked
// Checksum 0x24c5041a, Offset: 0x3820
// Size: 0x154
function zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    if (newval) {
        self createzombieeyes(localclientnum);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_on_luminance(), self get_eyeball_color());
    } else {
        self deletezombieeyes(localclientnum);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_off_luminance(), self get_eyeball_color());
    }
    if (isdefined(level.var_3ae99156)) {
        self [[ level.var_3ae99156 ]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    }
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0x2bc97a79, Offset: 0x3980
// Size: 0x1c
function get_eyeball_on_luminance() {
    if (isdefined(level.eyeball_on_luminance_override)) {
        return level.eyeball_on_luminance_override;
    }
    return 1;
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0x40e8b53, Offset: 0x39a8
// Size: 0x1a
function get_eyeball_off_luminance() {
    if (isdefined(level.eyeball_off_luminance_override)) {
        return level.eyeball_off_luminance_override;
    }
    return 0;
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0xd46c8ce0, Offset: 0x39d0
// Size: 0x48
function get_eyeball_color() {
    val = 0;
    if (isdefined(level.zombie_eyeball_color_override)) {
        val = level.zombie_eyeball_color_override;
    }
    if (isdefined(self.zombie_eyeball_color_override)) {
        val = self.zombie_eyeball_color_override;
    }
    return val;
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0x9b2d9986, Offset: 0x3a20
// Size: 0x24
function createzombieeyes(localclientnum) {
    self thread createzombieeyesinternal(localclientnum);
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0x94b0992b, Offset: 0x3a50
// Size: 0x60
function deletezombieeyes(localclientnum) {
    if (isdefined(self._eyearray)) {
        if (isdefined(self._eyearray[localclientnum])) {
            deletefx(localclientnum, self._eyearray[localclientnum], 1);
            self._eyearray[localclientnum] = undefined;
        }
    }
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0x2cc84229, Offset: 0x3ab8
// Size: 0x102
function createzombieeyesinternal(localclientnum) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self._eyearray)) {
        self._eyearray = [];
    }
    if (!isdefined(self._eyearray[localclientnum])) {
        linktag = "j_eyeball_le";
        effect = level._effect["eye_glow"];
        if (isdefined(level._override_eye_fx)) {
            effect = level._override_eye_fx;
        }
        if (isdefined(self._eyeglow_fx_override)) {
            effect = self._eyeglow_fx_override;
        }
        if (isdefined(self._eyeglow_tag_override)) {
            linktag = self._eyeglow_tag_override;
        }
        self._eyearray[localclientnum] = playfxontag(localclientnum, effect, self, linktag);
    }
}

// Namespace frontend
// Params 7, eflags: 0x1 linked
// Checksum 0x42851bed, Offset: 0x3bc8
// Size: 0x7c
function function_bcf3361d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, newval, 0, 0);
}

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0xedf1d3d6, Offset: 0x3c50
// Size: 0x140
function blackscreen_watcher() {
    blackscreenuimodel = createuimodel(getglobaluimodel(), "hideWorldForStreamer");
    setuimodelvalue(blackscreenuimodel, 1);
    while (true) {
        var_ddbfd9e3 = level waittill(#"streamer_change");
        setuimodelvalue(blackscreenuimodel, 1);
        wait(0.1);
        while (true) {
            charready = 1;
            if (isdefined(var_ddbfd9e3)) {
                charready = character_customization::function_ddd0628f(var_ddbfd9e3);
            }
            sceneready = getstreamerrequestprogress(0) >= 100;
            if (charready && sceneready) {
                break;
            }
            wait(0.1);
        }
        setuimodelvalue(blackscreenuimodel, 0);
    }
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x72781e51, Offset: 0x3d98
// Size: 0x5e
function streamer_change(hint, var_ddbfd9e3) {
    if (isdefined(hint)) {
        setstreamerrequest(0, hint);
    } else {
        clearstreamerrequest(0);
    }
    level notify(#"streamer_change", var_ddbfd9e3);
}

// Namespace frontend
// Params 3, eflags: 0x1 linked
// Checksum 0x8e560517, Offset: 0x3e00
// Size: 0x124
function function_19f2b8a3(localclientnum, var_ddbfd9e3, changed) {
    fields = getcharacterfields(var_ddbfd9e3.characterindex, 1);
    if (isdefined(fields) && isdefined(fields.var_d0ff12a0) && isdefined(fields.var_4998666a)) {
        if (isdefined(fields.var_92636759)) {
            streamer_change(fields.var_92636759, var_ddbfd9e3);
        }
        position = struct::get(fields.var_d0ff12a0);
        playmaincamxcam(localclientnum, fields.var_4998666a, 0, "", "", position.origin, position.angles);
    }
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0x1f5f2bdd, Offset: 0x3f30
// Size: 0x78
function handle_inspect_player(localclientnum) {
    level endon(#"disconnect");
    while (true) {
        xuid = level waittill(#"inspect_player");
        /#
            assert(isdefined(xuid));
        #/
        level thread update_inspection_character(localclientnum, xuid);
    }
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x3bc5a391, Offset: 0x3fb0
// Size: 0x4d4
function update_inspection_character(localclientnum, xuid) {
    level endon(#"disconnect");
    level endon(#"inspect_player");
    customization = getcharactercustomizationforxuid(localclientnum, xuid);
    while (!isdefined(customization)) {
        customization = getcharactercustomizationforxuid(localclientnum, xuid);
        wait(1);
    }
    fields = getcharacterfields(customization.charactertype, customization.charactermode);
    params = spawnstruct();
    if (!isdefined(fields)) {
        fields = spawnstruct();
    }
    params.anim_name = "pb_cac_main_lobby_idle";
    s_scene = struct::get_script_bundle("scene", "sb_frontend_inspection");
    s_align = struct::get(s_scene.aligntarget, "targetname");
    s_params = spawnstruct();
    s_params.scene = s_scene.name;
    var_ddbfd9e3 = lui::getcharacterdataformenu("Inspection", localclientnum);
    if (sessionmodeiscampaigngame()) {
        highestmapreached = getdstat(localclientnum, "highestMapReached");
        var_ddbfd9e3.var_28223325 = (!isdefined(highestmapreached) || highestmapreached == 0) && getdvarstring("mapname") == "core_frontend";
    }
    character_customization::set_character(var_ddbfd9e3, customization.charactertype);
    character_customization::set_character_mode(var_ddbfd9e3, customization.charactermode);
    character_customization::function_56dceb6(var_ddbfd9e3, customization.charactermode, customization.charactertype, customization.body.selectedindex, customization.body.colors);
    character_customization::function_5b80fae8(var_ddbfd9e3, customization.charactermode, customization.head);
    character_customization::function_5fa9d769(var_ddbfd9e3, customization.charactermode, customization.charactertype, customization.helmet.selectedindex, customization.helmet.colors);
    character_customization::function_f374c6fc(var_ddbfd9e3, customization.charactermode, localclientnum, xuid, customization.charactertype, customization.showcaseweapon.weaponname, customization.showcaseweapon.attachmentinfo, customization.showcaseweapon.weaponrenderoptions, 1, 0);
    if (isdefined(var_ddbfd9e3.anim_name)) {
        var_70df0eb8 = struct::get_script_bundle("scene", s_scene.name);
        if (var_70df0eb8.objects.size > 0) {
            var_70df0eb8.objects[0].mainanim = var_ddbfd9e3.anim_name;
        }
    }
    character_customization::update(localclientnum, var_ddbfd9e3, params);
    if (isdefined(var_ddbfd9e3.charactermodel)) {
        var_ddbfd9e3.charactermodel sethighdetail(1, 1);
    }
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0xb3eadc6b, Offset: 0x4490
// Size: 0xc
function entityspawned(localclientnum) {
    
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0xd891a47a, Offset: 0x44a8
// Size: 0x2c8
function localclientconnect(localclientnum) {
    /#
        println("zombie_has_eyes" + localclientnum);
    #/
    setupclientmenus(localclientnum);
    if (isdefined(level.charactercustomizationsetup)) {
        [[ level.charactercustomizationsetup ]](localclientnum);
    }
    if (isdefined(level.weaponcustomizationiconsetup)) {
        [[ level.weaponcustomizationiconsetup ]](localclientnum);
    }
    level.var_5b12555e = character_customization::function_b79cb078(getent(localclientnum, "customization", "targetname"), localclientnum);
    var_a33f21a6 = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0));
    var_a33f21a6.targetname = "cp_lobby_player_model";
    level.var_74625f60 = character_customization::function_b79cb078(var_a33f21a6, localclientnum);
    character_customization::function_ea9faed5(localclientnum, level.var_74625f60, 0);
    var_a33f21a6 = util::spawn_model(localclientnum, "tag_origin", (0, 0, 0));
    var_a33f21a6.targetname = "zm_lobby_player_model";
    level.var_647ea5fa = character_customization::function_b79cb078(var_a33f21a6, localclientnum);
    callback::callback(#"hash_da8d7d74", localclientnum);
    customclass::localclientconnect(localclientnum);
    level thread handle_inspect_player(localclientnum);
    customclass::hide_paintshop_bg(localclientnum);
    globalmodel = getglobaluimodel();
    roommodel = createuimodel(globalmodel, "lobbyRoot.room");
    room = getuimodelvalue(roommodel);
    postfx::setfrontendstreamingoverlay(localclientnum, "frontend", 1);
    level.frontendclientconnected = 1;
    level notify("menu_change" + localclientnum, "Main", "opened", room);
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x4778
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x4788
// Size: 0x4
function onstartgametype() {
    
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x2d0bc83d, Offset: 0x4798
// Size: 0x4c
function open_choose_class(localclientnum, menu_data) {
    level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "choose_class_closed" + localclientnum);
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x808cafe9, Offset: 0x47f0
// Size: 0x58
function close_choose_class(localclientnum, menu_data) {
    enablefrontendlockedweaponoverlay(localclientnum, 0);
    enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
    level notify("choose_class_closed" + localclientnum);
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0xfdbff992, Offset: 0x4850
// Size: 0x34
function function_d4153501(localclientnum, menu_data) {
    level.weapon_position = struct::get("zm_loadout_gumball");
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0xc4f33b46, Offset: 0x4890
// Size: 0x34
function function_6069e673(localclientnum, menu_data) {
    level.weapon_position = struct::get("paintshop_weapon_position");
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0xd5c9b0cd, Offset: 0x48d0
// Size: 0xbc
function function_5f5f7f43(localclientnum, menu_data) {
    level.var_6eb4dd6e = getdvarint("r_maxSpotShadowUpdates");
    setdvar("r_maxSpotShadowUpdates", 24);
    level.weapon_position = struct::get(menu_data.target_name);
    playradiantexploder(localclientnum, "zm_gum_room");
    playradiantexploder(localclientnum, "zm_gum_kick");
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0xe54ffaec, Offset: 0x4998
// Size: 0xc4
function function_baec4b95(localclientnum, menu_data) {
    level.weapon_position = struct::get("paintshop_weapon_position");
    killradiantexploder(localclientnum, "zm_gum_room");
    killradiantexploder(localclientnum, "zm_gum_kick");
    setdvar("r_maxSpotShadowUpdates", level.var_6eb4dd6e);
    enablefrontendlockedweaponoverlay(localclientnum, 0);
    enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0xe1167765, Offset: 0x4a68
// Size: 0x114
function function_ff3c2c64(localclientnum, menu_data) {
    level.var_6eb4dd6e = getdvarint("r_maxSpotShadowUpdates");
    setdvar("r_maxSpotShadowUpdates", 24);
    level.weapon_position = struct::get(menu_data.target_name);
    playradiantexploder(localclientnum, "zm_gum_room");
    playradiantexploder(localclientnum, "zm_gum_kick");
    if (!isdefined(level.var_b15bae32)) {
        level.var_b15bae32 = new class_df7b1a9b();
        [[ level.var_b15bae32 ]]->init(localclientnum);
    }
    level thread function_8732c6a1(localclientnum, menu_data);
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0xcf5b18d4, Offset: 0x4b88
// Size: 0xc4
function function_de453b82(localclientnum, menu_data) {
    level.weapon_position = struct::get("paintshop_weapon_position");
    killradiantexploder(localclientnum, "zm_gum_room");
    killradiantexploder(localclientnum, "zm_gum_kick");
    setdvar("r_maxSpotShadowUpdates", level.var_6eb4dd6e);
    enablefrontendlockedweaponoverlay(localclientnum, 0);
    enablefrontendtokenlockedweaponoverlay(localclientnum, 0);
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x81a80b0d, Offset: 0x4c58
// Size: 0x26c
function function_da5b7e64(localclientnum, type) {
    level endon(#"hash_cefa858a");
    level endon(#"hash_b26afc1b");
    level endon(#"disconnect");
    level endon(#"blackmarket_closed");
    var_c596068f = 0.5;
    var_e6a2a338 = 0.01;
    if (level.var_d4e5097e != "") {
        exploder::stop_exploder(level.var_d4e5097e);
    }
    wait(var_e6a2a338);
    var_ba01c642 = 0;
    if (type == "common") {
        var_ba01c642 = 0;
        level.var_d4e5097e = "exploder_blackmarket_crate_common";
    } else if (type == "rare") {
        var_ba01c642 = 1;
        level.var_d4e5097e = "exploder_blackmarket_crate_rare";
    } else if (type == "legendary") {
        var_ba01c642 = 2;
        level.var_d4e5097e = "exploder_blackmarket_crate_legendary";
    } else if (type == "epic") {
        var_ba01c642 = 3;
        level.var_d4e5097e = "exploder_blackmarket_crate_epic";
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, var_ba01c642, 0);
    wait(var_c596068f - var_e6a2a338);
    if (type != "common") {
        playsound(localclientnum, "uin_bm_chest_open_sparks");
    }
    exploder::exploder(level.var_d4e5097e);
    self clearanim("o_loot_crate_idle", 0);
    self animation::play("o_loot_crate_open", undefined, undefined, 1, 0, 0, 0, 0);
    self animation::play("o_loot_crate_idle", undefined, undefined, 1, 0, 0, 0, 0);
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0xe7d8d5fe, Offset: 0x4ed0
// Size: 0x35a
function function_b26afc1b(localclientnum) {
    level notify(#"hash_b26afc1b");
    level endon(#"hash_b26afc1b");
    level endon(#"disconnect");
    level endon(#"blackmarket_closed");
    camera_ent = struct::get("mp_frontend_blackmarket");
    crate = getent(localclientnum, "mp_frontend_blackmarket_crate", "targetname");
    crate useanimtree(#generic);
    crate clearanim("o_loot_crate_idle", 0);
    crate mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
    if (level.var_d4e5097e != "") {
        exploder::stop_exploder(level.var_d4e5097e);
        level.var_d4e5097e = "";
    }
    while (true) {
        param1, param2 = level waittill(#"blackmarket");
        if (param1 == "crate_camera") {
            playmaincamxcam(localclientnum, "ui_cam_frontend_crate_in", 0, "cam_crate_in", "", camera_ent.origin, camera_ent.angles);
            crate thread function_da5b7e64(localclientnum, param2);
            continue;
        }
        if (param1 == "normal_camera") {
            level notify(#"hash_cefa858a");
            crate clearanim("o_loot_crate_idle", 0);
            crate mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
            if (level.var_d4e5097e != "") {
                exploder::stop_exploder(level.var_d4e5097e);
                level.var_d4e5097e = "";
            }
            playmaincamxcam(localclientnum, "ui_cam_frontend_blackmarket", 0, "cam_mpmain", "", camera_ent.origin, camera_ent.angles);
            continue;
        }
        if (param1 == "cycle_start") {
            level.var_ad2380a3 = crate playloopsound("uin_bm_cycle_loop");
            continue;
        }
        if (param1 == "cycle_stop" && isdefined(level.var_ad2380a3)) {
            crate stoploopsound(level.var_ad2380a3);
            level.var_ad2380a3 = undefined;
        }
    }
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x313e76f3, Offset: 0x5238
// Size: 0x11c
function function_2c510839(localclientnum, menu_data) {
    level.var_d4e5097e = "";
    streamer_change("core_frontend_blackmarket");
    if (ispc()) {
        level.r_volumetric_lighting_lights_skip_samples = getdvarint("r_volumetric_lighting_lights_skip_samples");
        level.r_volumetric_lighting_max_spot_samples = getdvarint("r_volumetric_lighting_max_spot_samples");
    }
    setdvar("r_volumetric_lighting_upsample_depth_threshold", 0.001);
    setdvar("r_volumetric_lighting_blur_depth_threshold", 1300);
    setdvar("r_volumetric_lighting_lights_skip_samples", 0);
    setdvar("r_volumetric_lighting_max_spot_samples", 40);
    level thread function_b26afc1b(localclientnum);
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x6edad874, Offset: 0x5360
// Size: 0x152
function function_68a00f67(localclientnum, menu_data) {
    setdvar("r_volumetric_lighting_upsample_depth_threshold", 0.01);
    setdvar("r_volumetric_lighting_blur_depth_threshold", 2000);
    setdvar("r_volumetric_lighting_lights_skip_samples", 1);
    setdvar("r_volumetric_lighting_max_spot_samples", 8);
    if (ispc()) {
        setdvar("r_volumetric_lighting_lights_skip_samples", level.r_volumetric_lighting_lights_skip_samples);
        setdvar("r_volumetric_lighting_max_spot_samples", level.r_volumetric_lighting_max_spot_samples);
    }
    if (isdefined(level.var_ad2380a3)) {
        crate = getent(localclientnum, "mp_frontend_blackmarket_crate", "targetname");
        crate stoploopsound(level.var_ad2380a3);
        level.var_ad2380a3 = undefined;
    }
    level notify(#"blackmarket_closed");
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0xfa90cc73, Offset: 0x54c0
// Size: 0x64
function function_b254ba02(localclientnum) {
    var_e8a29b7c = getuimodel(getuimodelforcontroller(localclientnum), "MegaChewFactory.disableInput");
    setuimodelvalue(var_e8a29b7c, 1);
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0xb35da9e3, Offset: 0x5530
// Size: 0x84
function function_8519a971(localclientnum) {
    level util::waittill_any_timeout(17, "megachew_factory_cycle_complete");
    var_e8a29b7c = getuimodel(getuimodelforcontroller(localclientnum), "MegaChewFactory.disableInput");
    setuimodelvalue(var_e8a29b7c, 0);
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0x9ed363ca, Offset: 0x55c0
// Size: 0x54
function function_8ce9d0c5(localclientnum) {
    level endon(#"hash_8732c6a1");
    level endon(#"disconnect");
    while (true) {
        level waittill(#"hash_c03a3ea9");
        [[ level.var_b15bae32 ]]->function_212ad581(localclientnum);
    }
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0xbb9e08d3, Offset: 0x5620
// Size: 0x124
function function_797567e3(localclientnum) {
    level endon(#"hash_8732c6a1");
    level endon(#"disconnect");
    level endon(#"hash_34999717");
    var_243f60a3 = getuimodelvalue(createuimodel(getglobaluimodel(), "MegaChewFactoryVialDisplay"));
    if (isdefined(var_243f60a3)) {
        [[ level.var_b15bae32 ]]->function_f02acef4(var_243f60a3);
        [[ level.var_b15bae32 ]]->function_1fdaf4e2(localclientnum, 1);
    }
    while (true) {
        var_971a0262 = level waittill(#"hash_94d147b7");
        if (var_971a0262 > 999) {
            var_971a0262 = 999;
        }
        [[ level.var_b15bae32 ]]->function_f02acef4(var_971a0262);
        [[ level.var_b15bae32 ]]->function_1fdaf4e2(localclientnum, 1);
    }
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x44504c94, Offset: 0x5750
// Size: 0x136
function function_d80389b0(controllerindex, var_971a0262) {
    controllermodel = getuimodelforcontroller(controllerindex);
    var_58f9fad7 = getuimodel(controllermodel, "MegaChewFactory");
    var_d45729a4 = createuimodel(var_58f9fad7, "queryLoot");
    var_1cb585b9 = createuimodel(var_58f9fad7, "lootQueryResult");
    setuimodelvalue(var_1cb585b9, 0);
    setuimodelvalue(var_d45729a4, var_971a0262);
    level util::waittill_any_timeout(5, "loot_query_result_ready");
    result = getuimodelvalue(var_1cb585b9);
    return isdefined(result) && result;
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x14766b, Offset: 0x5890
// Size: 0x1d6
function function_8732c6a1(localclientnum, menu_data) {
    level notify(#"hash_8732c6a1");
    level endon(#"hash_8732c6a1");
    level endon(#"disconnect");
    level endon(#"hash_34999717");
    [[ level.var_b15bae32 ]]->function_9111df18(localclientnum, 0);
    level thread function_797567e3(localclientnum);
    level thread function_8ce9d0c5(localclientnum);
    while (true) {
        event, index, controllerindex = level waittill(#"hash_7f3572a1");
        switch (event) {
        case 154:
            [[ level.var_b15bae32 ]]->function_2b1651c(localclientnum, index);
            break;
        case 156:
            /#
                iprintlnbold("zombie_has_eyes" + index);
                println("zombie_has_eyes" + index);
            #/
            break;
        case 155:
            if (!function_d80389b0(controllerindex, index)) {
                break;
            }
            function_b254ba02(controllerindex);
            thread function_8519a971(controllerindex);
            [[ level.var_b15bae32 ]]->activate(localclientnum, index);
            break;
        }
    }
}

#namespace namespace_df7b1a9b;

#namespace frontend;

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0x63affc39, Offset: 0xd5c8
// Size: 0x6c
function open_character_menu(localclientnum, menu_data) {
    character_ent = getent(localclientnum, menu_data.target_name, "targetname");
    if (isdefined(character_ent)) {
        character_ent show();
    }
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xab4f9133, Offset: 0xd640
// Size: 0x6c
function close_character_menu(localclientnum, menu_data) {
    character_ent = getent(localclientnum, menu_data.target_name, "targetname");
    if (isdefined(character_ent)) {
        character_ent hide();
    }
}

// Namespace frontend
// Params 3, eflags: 0x1 linked
// Checksum 0x51242bee, Offset: 0xd6b8
// Size: 0x182
function function_b9b7c881(localclientnum, menu_name, extracam_data) {
    level endon(menu_name + "_closed");
    while (true) {
        params = spawnstruct();
        character_customization::function_fd188096(localclientnum, level.liveccdata[localclientnum], params);
        if (isdefined(params.align_struct)) {
            camera_ent = multi_extracam::extracam_init_item(localclientnum, params.align_struct, extracam_data.extracam_index);
            if (isdefined(camera_ent) && isdefined(params.xcam)) {
                if (isdefined(params.xcamframe)) {
                    camera_ent playextracamxcam(params.xcam, 0, params.subxcam, params.xcamframe);
                } else {
                    camera_ent playextracamxcam(params.xcam, 0, params.subxcam);
                }
            }
        }
        level waittill("frozenMomentChanged" + localclientnum);
    }
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x8813172f, Offset: 0xd848
// Size: 0x54
function function_8d1a05f8(localclientnum, menu_data) {
    menu_data.custom_character.charactermode = 1;
    character_customization::function_b0a8e76d(localclientnum, menu_data.custom_character, 1);
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x7b799334, Offset: 0xd8a8
// Size: 0x3c
function function_ef0109fe(localclientnum, menu_data) {
    character_customization::function_b0a8e76d(localclientnum, menu_data.custom_character, 0);
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x2f557b9e, Offset: 0xd8f0
// Size: 0x66
function start_character_rotating_any(localclientnum, menu_data) {
    maxlocalclient = getmaxlocalclients();
    while (localclientnum < maxlocalclient) {
        start_character_rotating(localclientnum, menu_data);
        localclientnum++;
    }
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x1fb08e79, Offset: 0xd960
// Size: 0x66
function end_character_rotating_any(localclientnum, menu_data) {
    maxlocalclient = getmaxlocalclients();
    while (localclientnum < maxlocalclient) {
        end_character_rotating(localclientnum, menu_data);
        localclientnum++;
    }
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x544babcf, Offset: 0xd9d0
// Size: 0x4c
function start_character_rotating(localclientnum, menu_data) {
    level thread character_customization::rotation_thread_spawner(localclientnum, menu_data.custom_character, "end_character_rotating" + localclientnum);
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x524d3e7c, Offset: 0xda28
// Size: 0x28
function end_character_rotating(localclientnum, menu_data) {
    level notify("end_character_rotating" + localclientnum);
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0x5e3dc3b6, Offset: 0xda58
// Size: 0x3c
function function_2aeaebe3(localclientnum, menu_data) {
    character_customization::function_474a5989(localclientnum, menu_data.custom_character, "spawn_char_lobbyslide");
}

// Namespace frontend
// Params 2, eflags: 0x0
// Checksum 0xf02c30ff, Offset: 0xdaa0
// Size: 0x3c
function function_4a0bdf8e(localclientnum, menu_data) {
    character_customization::function_474a5989(localclientnum, menu_data.custom_character, undefined);
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x4f965c33, Offset: 0xdae8
// Size: 0x4a
function open_choose_head_menu(localclientnum, menu_data) {
    character_customization::function_ea9faed5(localclientnum, menu_data.custom_character, 0);
    level notify(#"begin_personalizing_hero");
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0xda209402, Offset: 0xdb40
// Size: 0x4a
function close_choose_head_menu(localclientnum, menu_data) {
    character_customization::function_ea9faed5(localclientnum, menu_data.custom_character, 1);
    level notify(#"done_personalizing_hero");
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x5b7e11b, Offset: 0xdb98
// Size: 0x1da
function personalize_characters_watch(localclientnum, menu_name) {
    level endon(#"disconnect");
    level endon(menu_name + "_closed");
    s_cam = struct::get("personalizeHero_camera", "targetname");
    /#
        assert(isdefined(s_cam));
    #/
    for (animtime = 0; true; animtime = 300) {
        pose = level waittill("camera_change" + localclientnum);
        if (pose === "exploring") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", animtime, "cam_preview", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (pose === "inspecting_helmet") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", animtime, "cam_helmet", "", s_cam.origin, s_cam.angles);
            continue;
        }
        if (pose === "inspecting_body") {
            playmaincamxcam(localclientnum, "ui_cam_character_customization", animtime, "cam_select", "", s_cam.origin, s_cam.angles);
        }
    }
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0xcf67ad87, Offset: 0xdd80
// Size: 0x258
function choose_taunts_camera_watch(localclientnum, menu_name) {
    s_cam = struct::get("personalizeHero_camera", "targetname");
    /#
        assert(isdefined(s_cam));
    #/
    playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_topscorers", "", s_cam.origin, s_cam.angles);
    var_ddbfd9e3 = lui::getcharacterdataformenu(menu_name, localclientnum);
    var_ddbfd9e3.charactermodel.var_e10c584d = 1;
    var_ddbfd9e3.charactermodel.angles = (0, 112, 0);
    namespace_3cadf69b::function_6eace780();
    level waittill(menu_name + "_closed");
    namespace_3cadf69b::function_be586671();
    namespace_3cadf69b::function_6a310293(undefined);
    params = spawnstruct();
    params.anim_name = "pb_cac_main_lobby_idle";
    params.sessionmode = 1;
    character_customization::function_d79d6d7(localclientnum, var_ddbfd9e3, var_ddbfd9e3.characterindex, params);
    playmaincamxcam(localclientnum, "ui_cam_character_customization", 300, "cam_preview", "", s_cam.origin, s_cam.angles);
    var_ddbfd9e3.charactermodel.angles = var_ddbfd9e3.angles;
    wait(0.3);
    var_ddbfd9e3.charactermodel.var_e10c584d = 0;
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0xa6f7b984, Offset: 0xdfe0
// Size: 0xbb2
function function_fb006449(localclientnum) {
    level endon(#"hash_22b30258");
    while (true) {
        var_ab91e00d = getdvarstring("ui_mapname");
        if (util::is_safehouse(var_ab91e00d)) {
            var_74cfff2 = var_ab91e00d;
        } else {
            var_74cfff2 = util::function_3eb32a89(var_ab91e00d);
        }
        var_74cfff2 = getsubstr(var_74cfff2, "cp_sh_".size);
        /#
            printtoprightln("zombie_has_eyes" + var_ab91e00d, (1, 1, 1));
            var_d14d3a96 = getdvarstring("zombie_has_eyes", "zombie_has_eyes");
            if (var_d14d3a96 != "zombie_has_eyes") {
                var_74cfff2 = var_d14d3a96;
            }
        #/
        level.var_8ab87915 = [];
        if (!isdefined(level.var_8ab87915)) {
            level.var_8ab87915 = [];
        } else if (!isarray(level.var_8ab87915)) {
            level.var_8ab87915 = array(level.var_8ab87915);
        }
        level.var_8ab87915[level.var_8ab87915.size] = "cp_cac_cp_lobby_idle_" + var_74cfff2;
        if (!isdefined(level.var_8ab87915)) {
            level.var_8ab87915 = [];
        } else if (!isarray(level.var_8ab87915)) {
            level.var_8ab87915 = array(level.var_8ab87915);
        }
        level.var_8ab87915[level.var_8ab87915.size] = "cin_fe_cp_bunk_vign_smoke_read_" + var_74cfff2;
        if (!isdefined(level.var_8ab87915)) {
            level.var_8ab87915 = [];
        } else if (!isarray(level.var_8ab87915)) {
            level.var_8ab87915 = array(level.var_8ab87915);
        }
        level.var_8ab87915[level.var_8ab87915.size] = "cin_fe_cp_desk_vign_work_" + var_74cfff2;
        if (!isdefined(level.var_8ab87915)) {
            level.var_8ab87915 = [];
        } else if (!isarray(level.var_8ab87915)) {
            level.var_8ab87915 = array(level.var_8ab87915);
        }
        level.var_8ab87915[level.var_8ab87915.size] = "cin_fe_cp_desk_vign_type_" + var_74cfff2;
        if (isdefined(level.var_67da5b39)) {
            for (i = 0; i < level.var_67da5b39.size; i++) {
                killradiantexploder(0, level.var_67da5b39[i]);
            }
        }
        level.var_67da5b39 = [];
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "cp_frontend_idle";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "cp_frontend_read";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "cp_frontend_work";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "cp_frontend_type";
        level.var_3bb399f9 = [];
        if (!isdefined(level.var_3bb399f9)) {
            level.var_3bb399f9 = [];
        } else if (!isarray(level.var_3bb399f9)) {
            level.var_3bb399f9 = array(level.var_3bb399f9);
        }
        level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_idle";
        if (!isdefined(level.var_3bb399f9)) {
            level.var_3bb399f9 = [];
        } else if (!isarray(level.var_3bb399f9)) {
            level.var_3bb399f9 = array(level.var_3bb399f9);
        }
        level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_read";
        if (!isdefined(level.var_3bb399f9)) {
            level.var_3bb399f9 = [];
        } else if (!isarray(level.var_3bb399f9)) {
            level.var_3bb399f9 = array(level.var_3bb399f9);
        }
        level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_work";
        if (!isdefined(level.var_3bb399f9)) {
            level.var_3bb399f9 = [];
        } else if (!isarray(level.var_3bb399f9)) {
            level.var_3bb399f9 = array(level.var_3bb399f9);
        }
        level.var_3bb399f9[level.var_3bb399f9.size] = "cp_frontend_type";
        if (!isdefined(level.var_f31ebae4)) {
            if (level clientfield::get("first_time_flow")) {
                level.var_f31ebae4 = 0;
                /#
                    printtoprightln("zombie_has_eyes", (1, 1, 1));
                #/
            } else if (level clientfield::get("cp_bunk_anim_type") == 0) {
                level.var_f31ebae4 = randomintrange(0, 2);
                /#
                    printtoprightln("zombie_has_eyes", (1, 1, 1));
                #/
            } else if (level clientfield::get("cp_bunk_anim_type") == 1) {
                level.var_f31ebae4 = randomintrange(2, 4);
                /#
                    printtoprightln("zombie_has_eyes", (1, 1, 1));
                #/
            }
        }
        /#
            if (getdvarint("zombie_has_eyes", 0)) {
                if (!isdefined(level.var_b126daa5)) {
                    level.var_b126daa5 = level.var_f31ebae4;
                }
                level.var_b126daa5++;
                if (level.var_b126daa5 == level.var_8ab87915.size) {
                    level.var_b126daa5 = 0;
                }
                level.var_f31ebae4 = level.var_b126daa5;
            }
        #/
        s_scene = struct::get_script_bundle("scene", level.var_8ab87915[level.var_f31ebae4]);
        var_2af702f6 = getherogender(getequippedheroindex(localclientnum, 2), "cp");
        if (var_2af702f6 === "female" && isdefined(s_scene.femalebundle)) {
            s_scene = struct::get_script_bundle("scene", s_scene.femalebundle);
        }
        /#
            printtoprightln(s_scene.name, (1, 1, 1));
        #/
        s_align = struct::get(s_scene.aligntarget, "targetname");
        playmaincamxcam(localclientnum, s_scene.cameraswitcher, 0, "", "", s_align.origin, s_align.angles);
        for (i = 0; i < level.var_8ab87915.size; i++) {
            if (i == level.var_f31ebae4) {
                playradiantexploder(0, level.var_67da5b39[i]);
                continue;
            }
            killradiantexploder(0, level.var_67da5b39[i]);
        }
        s_params = spawnstruct();
        s_params.scene = s_scene.name;
        s_params.sessionmode = 2;
        character_customization::function_d79d6d7(localclientnum, level.var_74625f60, undefined, s_params);
        streamer_change(level.var_3bb399f9[level.var_f31ebae4], level.var_74625f60);
        setpbgactivebank(localclientnum, 1);
        /#
            if (getdvarint("zombie_has_eyes", 0)) {
                level.var_f31ebae4 = undefined;
            }
        #/
        do {
            wait(0.016);
            var_9cd812ba = getdvarstring("ui_mapname");
        } while (var_9cd812ba == var_ab91e00d);
    }
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0xec7a07dd, Offset: 0xeba0
// Size: 0xc5e
function function_e5f8ef8c(localclientnum) {
    var_74cfff2 = level.var_f22d5918;
    /#
        var_d14d3a96 = getdvarstring("zombie_has_eyes", "zombie_has_eyes");
        if (var_d14d3a96 != "zombie_has_eyes") {
            var_74cfff2 = var_d14d3a96;
        }
    #/
    level.var_8ab87915 = [];
    level.var_784ba6c9 = "zm_cp_" + var_74cfff2 + "_lobby_idle";
    if (!isdefined(level.var_8ab87915)) {
        level.var_8ab87915 = [];
    } else if (!isarray(level.var_8ab87915)) {
        level.var_8ab87915 = array(level.var_8ab87915);
    }
    level.var_8ab87915[level.var_8ab87915.size] = level.var_784ba6c9;
    if (isdefined(level.var_67da5b39)) {
        for (i = 0; i < level.var_67da5b39.size; i++) {
            killradiantexploder(0, level.var_67da5b39[i]);
        }
    }
    level.var_67da5b39 = [];
    if (var_74cfff2 == "cairo") {
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_cairo";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_cairo";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_cairo";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_cairo";
    } else if (var_74cfff2 == "mobile") {
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_mobile";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_mobile";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_mobile";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_mobile";
    } else {
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_singapore";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_singapore";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_singapore";
        if (!isdefined(level.var_67da5b39)) {
            level.var_67da5b39 = [];
        } else if (!isarray(level.var_67da5b39)) {
            level.var_67da5b39 = array(level.var_67da5b39);
        }
        level.var_67da5b39[level.var_67da5b39.size] = "fx_frontend_zombie_fog_singapore";
    }
    level.var_3bb399f9 = [];
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cpzm_frontend";
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cpzm_frontend";
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cpzm_frontend";
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cpzm_frontend";
    level.var_f31ebae4 = 0;
    setpbgactivebank(localclientnum, 2);
    s_scene = struct::get_script_bundle("scene", level.var_8ab87915[level.var_f31ebae4]);
    var_2af702f6 = getherogender(getequippedheroindex(localclientnum, 2), "cp");
    if (var_2af702f6 === "female" && isdefined(s_scene.femalebundle)) {
        s_scene = struct::get_script_bundle("scene", s_scene.femalebundle);
    }
    /#
        printtoprightln(s_scene.name, (1, 1, 1));
    #/
    s_align = struct::get(s_scene.aligntarget, "targetname");
    playmaincamxcam(localclientnum, s_scene.cameraswitcher, 0, "", "", s_align.origin, s_align.angles);
    for (i = 0; i < level.var_8ab87915.size; i++) {
        if (i == level.var_f31ebae4) {
            if (getdvarint("tu6_ffotd_zombieSpecialDayEffectsClient")) {
                switch (level.var_67da5b39[i]) {
                case 355:
                case 359:
                    position = (-1269, 1178, 562);
                    break;
                case 356:
                    position = (-1273, 1180, 320);
                    break;
                case 354:
                    position = (-1256, 1235, 61);
                    break;
                }
                level.var_b413970c = playfx(localclientnum, level._effect["frontend_special_day"], position);
            }
            playradiantexploder(0, level.var_67da5b39[i]);
            continue;
        }
        killradiantexploder(0, level.var_67da5b39[i]);
    }
    s_params = spawnstruct();
    s_params.scene = s_scene.name;
    s_params.sessionmode = 2;
    female = 1;
    function_d8c96cea(localclientnum, level.var_74625f60, female, s_params);
    streamer_change(level.var_3bb399f9[level.var_f31ebae4], level.var_74625f60);
    /#
        if (getdvarint("zombie_has_eyes", 0)) {
            level.var_f31ebae4 = undefined;
        }
    #/
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x7f37e4f6, Offset: 0xf808
// Size: 0x60
function function_aa8ceee2(localclientnum, var_572d7e99) {
    if (self != var_572d7e99) {
        return;
    }
    var_572d7e99.var_5294c549 = playfxontag(localclientnum, level._effect["doa_frontend_cigar_lit"], self, "tag_fx_smoke");
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x1304aa, Offset: 0xf870
// Size: 0x60
function function_72dc7256(localclientnum, var_572d7e99) {
    if (self != var_572d7e99) {
        return;
    }
    var_572d7e99.var_5a27d7b4 = playfxontag(localclientnum, level._effect["doa_frontend_cigar_puff"], self, "tag_fx_smoke");
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x8f73dc49, Offset: 0xf8d8
// Size: 0x60
function function_e770c390(localclientnum, var_572d7e99) {
    if (self != var_572d7e99) {
        return;
    }
    var_572d7e99.var_3873103e = playfxontag(localclientnum, level._effect["doa_frontend_cigar_ash"], self, "tag_fx_smoke");
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0xc5a2765d, Offset: 0xf940
// Size: 0x54
function function_9278b992(localclientnum, var_d2b2f423) {
    if (self != var_d2b2f423) {
        return;
    }
    playfxontag(localclientnum, level._effect["doa_frontend_cigar_exhale"], self, "tag_inhand");
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0x23f3067c, Offset: 0xf9a0
// Size: 0x1c4
function function_2c99c36f(a_ents, localclientnum) {
    level._animnotetrackhandlers["inhale"] = undefined;
    level._animnotetrackhandlers["puff"] = undefined;
    level._animnotetrackhandlers["flick"] = undefined;
    level._animnotetrackhandlers["exhale"] = undefined;
    var_572d7e99 = a_ents["cigar"];
    if (isdefined(var_572d7e99.var_7ccd283a)) {
        stopfx(localclientnum, var_572d7e99.var_7ccd283a);
    }
    var_572d7e99.var_7ccd283a = playfxontag(localclientnum, level._effect["doa_frontend_cigar_ambient"], var_572d7e99, "tag_fx_smoke");
    animation::add_global_notetrack_handler("inhale", &function_aa8ceee2, localclientnum, var_572d7e99);
    animation::add_global_notetrack_handler("puff", &function_72dc7256, localclientnum, var_572d7e99);
    animation::add_global_notetrack_handler("flick", &function_e770c390, localclientnum, var_572d7e99);
    var_d2b2f423 = a_ents["zombie"];
    animation::add_global_notetrack_handler("exhale", &function_9278b992, localclientnum, var_d2b2f423);
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0x2382a458, Offset: 0xfb70
// Size: 0x764
function function_c3c57a58(localclientnum) {
    var_74cfff2 = "mobile";
    level.var_8ab87915 = [];
    level.var_784ba6c9 = "zm_doa_" + var_74cfff2 + "_lobby_idle";
    if (!isdefined(level.var_8ab87915)) {
        level.var_8ab87915 = [];
    } else if (!isarray(level.var_8ab87915)) {
        level.var_8ab87915 = array(level.var_8ab87915);
    }
    level.var_8ab87915[level.var_8ab87915.size] = level.var_784ba6c9;
    if (isdefined(level.var_67da5b39)) {
        for (i = 0; i < level.var_67da5b39.size; i++) {
            killradiantexploder(0, level.var_67da5b39[i]);
        }
    }
    level.var_67da5b39 = [];
    if (!isdefined(level.var_67da5b39)) {
        level.var_67da5b39 = [];
    } else if (!isarray(level.var_67da5b39)) {
        level.var_67da5b39 = array(level.var_67da5b39);
    }
    level.var_67da5b39[level.var_67da5b39.size] = "zm_bonus_idle";
    level.var_3bb399f9 = [];
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cpzm_frontend";
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cpzm_frontend";
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cpzm_frontend";
    if (!isdefined(level.var_3bb399f9)) {
        level.var_3bb399f9 = [];
    } else if (!isarray(level.var_3bb399f9)) {
        level.var_3bb399f9 = array(level.var_3bb399f9);
    }
    level.var_3bb399f9[level.var_3bb399f9.size] = "cpzm_frontend";
    level.var_f31ebae4 = 0;
    setpbgactivebank(localclientnum, 2);
    s_scene = struct::get_script_bundle("scene", level.var_8ab87915[level.var_f31ebae4]);
    var_2af702f6 = getherogender(getequippedheroindex(localclientnum, 2), "cp");
    if (var_2af702f6 === "female" && isdefined(s_scene.femalebundle)) {
        s_scene = struct::get_script_bundle("scene", s_scene.femalebundle);
    }
    /#
        printtoprightln(s_scene.name, (1, 1, 1));
    #/
    s_align = struct::get(s_scene.aligntarget, "targetname");
    playmaincamxcam(localclientnum, s_scene.cameraswitcher, 0, "", "", s_align.origin, s_align.angles);
    for (i = 0; i < level.var_8ab87915.size; i++) {
        if (i == level.var_f31ebae4) {
            if (getdvarint("tu6_ffotd_zombieSpecialDayEffectsClient")) {
                switch (level.var_67da5b39[i]) {
                case 355:
                case 359:
                    position = (-1269, 1178, 562);
                    break;
                case 356:
                    position = (-1273, 1180, 320);
                    break;
                case 354:
                    position = (-1256, 1235, 61);
                    break;
                }
                level.var_b413970c = playfx(localclientnum, level._effect["frontend_special_day"], position);
            }
            playradiantexploder(0, level.var_67da5b39[i]);
            continue;
        }
        killradiantexploder(0, level.var_67da5b39[i]);
    }
    scene::add_scene_func(s_scene.name, &function_2c99c36f, "play", localclientnum);
    s_params = spawnstruct();
    s_params.scene = s_scene.name;
    s_params.sessionmode = 2;
    female = 1;
    function_d8c96cea(localclientnum, level.var_74625f60, female, s_params);
    streamer_change(level.var_3bb399f9[level.var_f31ebae4], level.var_74625f60);
    /#
        if (getdvarint("zombie_has_eyes", 0)) {
            level.var_f31ebae4 = undefined;
        }
    #/
    level.var_74625f60.charactermodel hide();
}

// Namespace frontend
// Params 4, eflags: 0x1 linked
// Checksum 0x15416774, Offset: 0x102e0
// Size: 0x20a
function function_d8c96cea(localclientnum, var_ddbfd9e3, characterindex, params) {
    /#
        assert(isdefined(var_ddbfd9e3));
    #/
    defaultindex = undefined;
    if (isdefined(params.isdefaulthero) && params.isdefaulthero) {
        defaultindex = 0;
    }
    character_customization::set_character(var_ddbfd9e3, characterindex);
    charactermode = params.sessionmode;
    character_customization::set_character_mode(var_ddbfd9e3, charactermode);
    body = 1;
    bodycolors = character_customization::function_a4a750bd(localclientnum, charactermode, characterindex, body, params.extracam_data);
    character_customization::function_56dceb6(var_ddbfd9e3, charactermode, characterindex, body, bodycolors);
    head = 14;
    character_customization::function_5b80fae8(var_ddbfd9e3, charactermode, head);
    helmet = 0;
    helmetcolors = character_customization::function_227c64d8(localclientnum, charactermode, var_ddbfd9e3.characterindex, helmet, params.extracam_data);
    character_customization::function_5fa9d769(var_ddbfd9e3, charactermode, characterindex, helmet, helmetcolors);
    return character_customization::update(localclientnum, var_ddbfd9e3, params);
}

// Namespace frontend
// Params 1, eflags: 0x1 linked
// Checksum 0x3e45522a, Offset: 0x104f8
// Size: 0x138
function function_8c70104b(localclientnum) {
    /#
        var_1fdfc146 = 8;
        if (getdvarint("zombie_has_eyes", 0)) {
            if (!isdefined(level.var_e50218e7) || level.var_e50218e7 > var_1fdfc146) {
                level.var_e50218e7 = 0;
            }
        }
    #/
    s_scene = struct::get_script_bundle("scene", "cin_fe_zm_forest_vign_sitting");
    s_params = spawnstruct();
    s_params.scene = s_scene.name;
    s_params.sessionmode = 0;
    character_customization::function_d79d6d7(localclientnum, level.var_647ea5fa, level.var_e50218e7, s_params);
    /#
        if (getdvarint("zombie_has_eyes", 0)) {
            level.var_e50218e7++;
        }
    #/
}

// Namespace frontend
// Params 2, eflags: 0x1 linked
// Checksum 0xbc5ab80b, Offset: 0x10638
// Size: 0x4f4
function function_1ca6d8df(localclientnum, state) {
    character_index = getequippedheroindex(localclientnum, 1);
    fields = getcharacterfields(character_index, 1);
    params = spawnstruct();
    if (!isdefined(fields)) {
        fields = spawnstruct();
    }
    if (isdefined(fields.var_d0ff12a0)) {
        params.align_struct = struct::get(fields.var_d0ff12a0);
    }
    params.weapon_left = fields.var_5309507b;
    params.weapon_right = fields.var_69b4cf02;
    var_1500d96e = 1 == getequippedloadoutitemforhero(localclientnum, character_index);
    if (var_1500d96e) {
        params.anim_intro_name = fields.var_54945d04;
        params.anim_name = fields.var_37917886;
        params.weapon_left_anim_intro = fields.var_3ec4722b;
        params.weapon_left_anim = fields.var_beddabc7;
        params.weapon_right_anim_intro = fields.var_d1a6c0ee;
        params.weapon_right_anim = fields.var_a2b0a508;
        if (isdefined(fields.var_f986b726) && fields.var_f986b726) {
            params.weapon = getweaponforcharacter(character_index, 1);
        }
    } else {
        params.anim_intro_name = fields.var_1f879308;
        params.anim_name = fields.var_d11b865a;
        params.weapon_left_anim_intro = fields.var_8ce91957;
        params.weapon_left_anim = fields.var_623e2733;
        params.weapon_right_anim_intro = fields.var_1ac723ea;
        params.weapon_right_anim = fields.var_9ebfda14;
        params.weapon = getweaponforcharacter(character_index, 1);
    }
    params.sessionmode = 1;
    changed = character_customization::function_d79d6d7(localclientnum, level.var_5b12555e, character_index, params);
    if (isdefined(level.var_5b12555e.charactermodel)) {
        level.var_5b12555e.charactermodel sethighdetail(1, 1);
        if (isdefined(params.weapon)) {
            level.var_5b12555e.charactermodel useweaponhidetags(params.weapon);
        } else {
            wait(0.016);
            level.var_5b12555e.charactermodel showallparts(localclientnum);
        }
        if (isdefined(level.var_5b12555e.var_48576bc9)) {
            stopsound(level.var_5b12555e.var_48576bc9);
            level.var_5b12555e.var_48576bc9 = undefined;
        }
        if (isdefined(level.var_5b12555e.playsound)) {
            level.var_5b12555e.var_48576bc9 = level.var_5b12555e.charactermodel playsound(undefined, level.var_5b12555e.playsound);
            level.var_5b12555e.playsound = undefined;
        }
    }
    function_19f2b8a3(localclientnum, level.var_5b12555e, changed);
    /#
        update_mp_lobby_room_devgui(localclientnum, state);
    #/
}

// Namespace frontend
// Params 3, eflags: 0x1 linked
// Checksum 0xcac2cc63, Offset: 0x10b38
// Size: 0x59a
function lobby_main(localclientnum, menu_name, state) {
    level notify(#"hash_22b30258");
    setpbgactivebank(localclientnum, 1);
    if (isdefined(state) && !strstartswith(state, "cpzm") && !strstartswith(state, "doa")) {
        if (isdefined(level.var_b413970c)) {
            killfx(localclientnum, level.var_b413970c);
        }
    }
    if (!isdefined(state) || state == "room2") {
        streamer_change();
        camera_ent = struct::get("mainmenu_frontend_camera");
        if (isdefined(camera_ent)) {
            playmaincamxcam(localclientnum, "startmenu_camera_01", 0, "cam1", "", camera_ent.origin, camera_ent.angles);
        }
        /#
            update_room2_devgui(localclientnum);
        #/
    } else if (state == "room1") {
        streamer_change("core_frontend_sitting_bull");
        camera_ent = struct::get("room1_frontend_camera");
        setallcontrollerslightbarcolor((1, 0.4, 0));
        level thread pulse_controller_color();
        if (isdefined(camera_ent)) {
            playmaincamxcam(localclientnum, "startmenu_camera_01", 0, "cam1", "", camera_ent.origin, camera_ent.angles);
        }
    } else if (state == "mp_theater") {
        streamer_change("frontend_theater");
        camera_ent = struct::get("frontend_theater");
        if (isdefined(camera_ent)) {
            playmaincamxcam(localclientnum, "ui_cam_frontend_theater", 0, "cam1", "", camera_ent.origin, camera_ent.angles);
        }
    } else if (state == "mp_freerun") {
        streamer_change("frontend_freerun");
        camera_ent = struct::get("frontend_freerun");
        if (isdefined(camera_ent)) {
            playmaincamxcam(localclientnum, "ui_cam_frontend_freerun", 0, "cam1", "", camera_ent.origin, camera_ent.angles);
        }
    } else if (strstartswith(state, "doa")) {
        function_c3c57a58(localclientnum);
    } else if (strstartswith(state, "cpzm")) {
        function_e5f8ef8c(localclientnum);
    } else if (strstartswith(state, "cp")) {
        function_fb006449(localclientnum);
    } else if (strstartswith(state, "mp")) {
        function_1ca6d8df(localclientnum, state);
    } else if (strstartswith(state, "zm")) {
        streamer_change("core_frontend_zm_lobby");
        camera_ent = struct::get("zm_frontend_camera");
        if (isdefined(camera_ent)) {
            playmaincamxcam(localclientnum, "zm_lobby_cam", 0, "default", "", camera_ent.origin, camera_ent.angles);
        }
        function_8c70104b(localclientnum);
    } else {
        streamer_change();
    }
    if (!isdefined(state) || state != "room1") {
        setallcontrollerslightbarcolor();
        level notify(#"end_controller_pulse");
    }
}

/#

    // Namespace frontend
    // Params 1, eflags: 0x1 linked
    // Checksum 0x4cb300cc, Offset: 0x110e0
    // Size: 0x2c
    function update_room2_devgui(localclientnum) {
        level thread mp_devgui::remove_mp_contracts_devgui(localclientnum);
    }

    // Namespace frontend
    // Params 2, eflags: 0x1 linked
    // Checksum 0x1a887a93, Offset: 0x11118
    // Size: 0x74
    function update_mp_lobby_room_devgui(localclientnum, state) {
        if (state == "zombie_has_eyes" || state == "zombie_has_eyes") {
            level thread mp_devgui::create_mp_contracts_devgui(localclientnum);
            return;
        }
        level mp_devgui::remove_mp_contracts_devgui(localclientnum);
    }

#/

// Namespace frontend
// Params 0, eflags: 0x1 linked
// Checksum 0xc5b34f65, Offset: 0x11198
// Size: 0xc4
function pulse_controller_color() {
    level endon(#"end_controller_pulse");
    delta_t = -0.01;
    t = 1;
    while (true) {
        setallcontrollerslightbarcolor((1 * t, 0.2 * t, 0));
        t += delta_t;
        if (t < 0.2 || t > 0.99) {
            delta_t *= -1;
        }
        wait(0.016);
    }
}

