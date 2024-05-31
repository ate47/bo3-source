#using scripts/zm/_zm_altbody_beast;
#using scripts/shared/ai/zombie_death;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_b361ecc3;

// Namespace namespace_b361ecc3
// Method(s) 25 Total 25
class class_b43ec356 {

    // Namespace namespace_b43ec356
    // Params 2, eflags: 0x1 linked
    // Checksum 0x59bb32f7, Offset: 0x1a08
    // Size: 0x80
    function function_b77dd968(player, n_index) {
        self.var_116811f0 = 0;
        function_2f4a90b6(n_index);
        self.var_75a61704[self.var_d270ab05] = n_index;
        self.var_d270ab05++;
        if (self.var_d270ab05 == 3) {
            function_869ec8c8();
        }
        self.var_116811f0 = 1;
    }

    // Namespace namespace_b43ec356
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe6de8cde, Offset: 0x19f0
    // Size: 0xa
    function function_384b2fb3() {
        return self.var_116811f0;
    }

    // Namespace namespace_b43ec356
    // Params 2, eflags: 0x1 linked
    // Checksum 0xad544e1c, Offset: 0x1930
    // Size: 0xb4
    function function_e174bab4(var_63f5ae73, n_index) {
        while (true) {
            player = self waittill(#"trigger");
            if (var_63f5ae73.var_71f130fa <= 0) {
                continue;
            }
            if (player zm_utility::in_revive_trigger()) {
                continue;
            }
            if (!(isdefined([[ var_63f5ae73 ]]->function_384b2fb3()) && [[ var_63f5ae73 ]]->function_384b2fb3())) {
                continue;
            }
            [[ var_63f5ae73 ]]->function_b77dd968(player, n_index);
        }
    }

    // Namespace namespace_b43ec356
    // Params 1, eflags: 0x1 linked
    // Checksum 0xeaa53e1a, Offset: 0x1570
    // Size: 0x3b8
    function function_d081c849(player) {
        self endon(#"kill_trigger");
        player endon(#"hash_3f7b661c");
        str_hint = %;
        var_b7b6d234 = %;
        var_3d791fac = [[ self.stub.var_7aae7803 ]]->function_113a1256();
        while (true) {
            n_state = [[ self.stub.var_7aae7803 ]]->function_384b2fb3();
            switch (n_state) {
            case 2:
                str_hint = %ZM_ZOD_KEYCODE_TRYING;
                break;
            case 3:
                str_hint = %ZM_ZOD_KEYCODE_SUCCESS;
                break;
            case 4:
                str_hint = %ZM_ZOD_KEYCODE_FAIL;
                break;
            case 0:
                str_hint = %ZM_ZOD_KEYCODE_UNAVAILABLE;
                break;
            case 1:
                player.var_dd607d96 = undefined;
                var_184ab935 = 0.996;
                var_b9f3ddcc = player getplayercamerapos();
                var_bff77cb5 = anglestoforward(player getplayerangles());
                foreach (var_dcf46be5 in var_3d791fac) {
                    v_tag_origin = var_dcf46be5.v_origin;
                    var_455cd818 = vectornormalize(v_tag_origin - var_b9f3ddcc);
                    n_dot = vectordot(var_455cd818, var_bff77cb5);
                    if (n_dot > var_184ab935) {
                        var_184ab935 = n_dot;
                        player.var_dd607d96 = var_dcf46be5.n_index;
                    }
                }
                if (!isdefined(player.var_dd607d96)) {
                    str_hint = %;
                } else if (player.var_dd607d96 < 3) {
                    str_hint = %ZM_ZOD_KEYCODE_INCREMENT_NUMBER;
                } else {
                    str_hint = %ZM_ZOD_KEYCODE_ACTIVATE;
                }
                break;
            }
            if (var_b7b6d234 != str_hint) {
                var_b7b6d234 = str_hint;
                self.stub.hint_string = str_hint;
                if (str_hint === %ZM_ZOD_KEYCODE_INCREMENT_NUMBER) {
                    self sethintstring(self.stub.hint_string, player.var_dd607d96 + 1);
                } else {
                    self sethintstring(self.stub.hint_string);
                }
            }
            wait(0.1);
        }
    }

    // Namespace namespace_b43ec356
    // Params 1, eflags: 0x1 linked
    // Checksum 0xcf010192, Offset: 0x14e8
    // Size: 0x7a
    function function_7a9d4a27(player) {
        b_is_invis = !(isdefined(player.beastmode) && player.beastmode);
        self setinvisibletoplayer(player, b_is_invis);
        self thread function_d081c849(player);
        return !b_is_invis;
    }

    // Namespace namespace_b43ec356
    // Params 3, eflags: 0x1 linked
    // Checksum 0x78e69d39, Offset: 0x1288
    // Size: 0x252
    function function_71154a2(var_1030677c, n_code_index, var_d7d7b586) {
        var_c929283d = struct::get(var_1030677c.target, "targetname");
        var_43544e59 = var_c929283d.origin;
        while (true) {
            player = var_1030677c waittill(#"trigger");
            while (player istouching(var_1030677c)) {
                var_b9f3ddcc = player getplayercamerapos();
                var_bff77cb5 = anglestoforward(player getplayerangles());
                var_744d3805 = vectornormalize(var_43544e59 - var_b9f3ddcc);
                n_dot = vectordot(var_744d3805, var_bff77cb5);
                if (n_dot > 0.9) {
                    n_number = function_1efeef1f(n_code_index, var_d7d7b586);
                    player.var_ab153665 = player hud::createprimaryprogressbartext();
                    player.var_ab153665 settext("You sense the number " + n_number);
                    player.var_ab153665 hud::showelem();
                }
                wait(0.05);
                if (isdefined(player.var_ab153665)) {
                    player.var_ab153665 hud::destroyelem();
                    player.var_ab153665 = undefined;
                }
            }
        }
    }

    // Namespace namespace_b43ec356
    // Params 0, eflags: 0x1 linked
    // Checksum 0x41bf41ed, Offset: 0x10c8
    // Size: 0x1b4
    function function_974a40ff() {
        width = -128;
        height = -128;
        length = -128;
        var_67e0afb7.unitrigger_stub = spawnstruct();
        var_67e0afb7.unitrigger_stub.origin = var_67e0afb7.origin;
        var_67e0afb7.unitrigger_stub.angles = var_67e0afb7.angles;
        var_67e0afb7.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
        var_67e0afb7.unitrigger_stub.cursor_hint = "HINT_NOICON";
        var_67e0afb7.unitrigger_stub.script_width = width;
        var_67e0afb7.unitrigger_stub.script_height = height;
        var_67e0afb7.unitrigger_stub.script_length = length;
        var_67e0afb7.unitrigger_stub.require_look_at = 0;
        var_67e0afb7.unitrigger_stub.var_7aae7803 = self;
        var_67e0afb7.unitrigger_stub.prompt_and_visibility_func = &function_7a9d4a27;
        zm_unitrigger::register_static_unitrigger(var_67e0afb7.unitrigger_stub, &function_e174bab4);
    }

    // Namespace namespace_b43ec356
    // Params 1, eflags: 0x1 linked
    // Checksum 0xffa6dece, Offset: 0x1060
    // Size: 0x60
    function function_a90f2e5c(a_code) {
        for (i = 0; i < a_code.size; i++) {
            if (!isinarray(self.var_75a61704, a_code[i])) {
                return false;
            }
        }
        return true;
    }

    // Namespace namespace_b43ec356
    // Params 0, eflags: 0x1 linked
    // Checksum 0x72a1e1c9, Offset: 0xee8
    // Size: 0x16c
    function function_869ec8c8() {
        self.var_71f130fa -= 1;
        for (i = 0; i < self.var_d5f15351.size; i++) {
            if (function_a90f2e5c(self.var_d5f15351[i])) {
                playsoundatposition("zmb_zod_sword_symbol_right", (2624, -5104, -312));
                self.var_116811f0 = 3;
                function_5b0296e8(1);
                [[ self.var_2c51c4a[i] ]]();
                return;
            }
        }
        self.var_116811f0 = 4;
        self.var_d270ab05 = 0;
        playsoundatposition("zmb_zod_sword_symbol_wrong", (2624, -5104, -312));
        if (self.var_71f130fa > 0) {
            function_5b0296e8(1);
            wait(3);
            function_5b0296e8(0);
            self.var_116811f0 = 1;
            return;
        }
        function_5b0296e8(1);
    }

    // Namespace namespace_b43ec356
    // Params 1, eflags: 0x1 linked
    // Checksum 0x24bdb145, Offset: 0xdc0
    // Size: 0x11e
    function function_65cfd36f(n_index) {
        if (!isdefined(n_index)) {
            n_index = 0;
        }
        a_code = self.var_d5f15351[n_index];
        for (i = 0; i < 3; i++) {
            var_c53d0ab2 = self.var_c256f3a5[n_index][i];
            for (j = 0; j < 10; j++) {
                var_c53d0ab2 hidepart("J_" + j);
                var_c53d0ab2 hidepart("p7_zm_zod_keepers_code_0" + j);
            }
            var_c53d0ab2 showpart("p7_zm_zod_keepers_code_0" + a_code[i]);
        }
    }

    // Namespace namespace_b43ec356
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf72c379e, Offset: 0xd50
    // Size: 0x64
    function function_13c28fed(n_index, b_is_visible) {
        if (b_is_visible) {
            self.var_5475b2f6[n_index] show();
            return;
        }
        self.var_5475b2f6[n_index] hide();
    }

    // Namespace namespace_b43ec356
    // Params 2, eflags: 0x1 linked
    // Checksum 0x29f759f6, Offset: 0xc78
    // Size: 0xcc
    function function_d48f6252(n_index, n_value) {
        var_22f3c343 = self.var_5475b2f6[n_index];
        for (i = 0; i < 10; i++) {
            var_22f3c343 hidepart("J_" + i);
            var_22f3c343 hidepart("j_keeper_" + i);
        }
        var_22f3c343 showpart("j_keeper_" + n_value);
    }

    // Namespace namespace_b43ec356
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc4d70e94, Offset: 0xc10
    // Size: 0x5c
    function function_36c50de5() {
        while (true) {
            level waittill(#"start_of_round");
            if (0 >= self.var_71f130fa) {
                function_5b0296e8(0);
                self.var_116811f0 = 1;
            }
            self.var_71f130fa = self.var_36948aba;
        }
    }

    // Namespace namespace_b43ec356
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6217fb4c, Offset: 0xb68
    // Size: 0x9e
    function function_4e399c97() {
        for (i = 0; i < self.var_5475b2f6.size; i++) {
            self.var_5475b2f6[i] thread namespace_215602b6::function_c5c7aef3(self.var_4d6497d9[i]);
            self.var_4d6497d9[i] thread function_e174bab4(self, i);
            function_d48f6252(i, i);
        }
    }

    // Namespace namespace_b43ec356
    // Params 1, eflags: 0x1 linked
    // Checksum 0x271b5dc, Offset: 0xb30
    // Size: 0x2c
    function function_2f4a90b6(n_index) {
        self.var_5475b2f6[n_index] ghost();
    }

    // Namespace namespace_b43ec356
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2aaefd80, Offset: 0xa48
    // Size: 0xda
    function function_5b0296e8(b_hide) {
        if (!isdefined(b_hide)) {
            b_hide = 1;
        }
        foreach (var_22f3c343 in self.var_5475b2f6) {
            if (b_hide) {
                var_22f3c343 ghost();
                continue;
            }
            var_22f3c343 show();
            namespace_215602b6::function_41cc3fc8();
        }
    }

    // Namespace namespace_b43ec356
    // Params 2, eflags: 0x1 linked
    // Checksum 0x60982e6d, Offset: 0x9c0
    // Size: 0x7c
    function function_110d42fa(var_f90df519, n_index) {
        if (!isdefined(n_index)) {
            n_index = 0;
        }
        if (!isdefined(self.var_c256f3a5)) {
            self.var_c256f3a5 = array(undefined);
        }
        self.var_c256f3a5[n_index] = var_f90df519;
        self thread function_65cfd36f(n_index);
    }

    // Namespace namespace_b43ec356
    // Params 2, eflags: 0x1 linked
    // Checksum 0x81d19590, Offset: 0x9a0
    // Size: 0x14
    function function_cc777878(a_code, var_52d9b7b7) {
        
    }

    // Namespace namespace_b43ec356
    // Params 0, eflags: 0x1 linked
    // Checksum 0x521180f3, Offset: 0x880
    // Size: 0x118
    function function_6bbb4752() {
        a_n_numbers = array(0, 1, 2, 3, 4, 5, 6, 7, 8);
        a_code = [];
        for (i = 0; i < 3; i++) {
            a_n_numbers = array::randomize(a_n_numbers);
            n_number = array::pop_front(a_n_numbers);
            if (!isdefined(a_code)) {
                a_code = [];
            } else if (!isarray(a_code)) {
                a_code = array(a_code);
            }
            a_code[a_code.size] = n_number;
        }
        return a_code;
    }

    // Namespace namespace_b43ec356
    // Params 0, eflags: 0x1 linked
    // Checksum 0xea4c9267, Offset: 0x868
    // Size: 0xa
    function function_113a1256() {
        return self.var_a2ddee88;
    }

    // Namespace namespace_b43ec356
    // Params 2, eflags: 0x1 linked
    // Checksum 0x54ec2ca, Offset: 0x838
    // Size: 0x26
    function function_1efeef1f(n_code_index, var_def860b4) {
        return self.var_d5f15351[n_code_index][var_def860b4];
    }

    // Namespace namespace_b43ec356
    // Params 1, eflags: 0x1 linked
    // Checksum 0x81da9e91, Offset: 0x7f0
    // Size: 0x3e
    function function_c69f5b9d(n_code_index) {
        if (!isdefined(n_code_index)) {
            n_code_index = 0;
        }
        a_code = self.var_d5f15351[n_code_index];
        return a_code;
    }

    // Namespace namespace_b43ec356
    // Params 4, eflags: 0x1 linked
    // Checksum 0x6a80b72f, Offset: 0x6c0
    // Size: 0x124
    function init(var_2516d492, var_bf684c45, var_4582f16d, func_activate) {
        self.var_5475b2f6 = var_2516d492;
        self.var_4d6497d9 = var_bf684c45;
        self.var_1d4fdfa6 = var_4582f16d;
        self.var_75a61704 = array(0, 0, 0);
        self.var_d270ab05 = 0;
        self.var_d5f15351 = array(function_6bbb4752());
        self.var_2c51c4a = array(func_activate);
        self.var_36948aba = 1;
        self.var_71f130fa = self.var_36948aba;
        self thread function_4e399c97();
        self thread function_36c50de5();
        self.var_7a01aaae = 0;
        self.var_116811f0 = 1;
    }

}

// Namespace namespace_b361ecc3
// Params 0, eflags: 0x2
// Checksum 0xf5ac61d0, Offset: 0x438
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_beastcode", &__init__, undefined, undefined);
}

// Namespace namespace_b361ecc3
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x478
// Size: 0x4
function __init__() {
    
}

// Namespace namespace_b361ecc3
// Params 0, eflags: 0x1 linked
// Checksum 0xf86350c0, Offset: 0x488
// Size: 0x200
function init() {
    var_2516d492 = [];
    var_f90df519 = [];
    var_bf684c45 = [];
    for (i = 0; i < 3; i++) {
        var_c53d0ab2 = getent("keeper_sword_locker_clue_" + i, "targetname");
        var_f90df519[var_f90df519.size] = var_c53d0ab2;
    }
    for (i = 0; i < 10; i++) {
        var_fce4f486 = getent("keeper_sword_locker_number_" + i, "targetname");
        var_2516d492[var_2516d492.size] = var_fce4f486;
        var_d729a52a = getent("keeper_sword_locker_trigger_" + i, "targetname");
        var_bf684c45[var_bf684c45.size] = var_d729a52a;
    }
    var_4582f16d = getentarray("keeper_sword_locker_clue_lookat", "targetname");
    level.var_ca7eab3b = new class_b43ec356();
    [[ level.var_ca7eab3b ]]->init(var_2516d492, var_bf684c45, var_4582f16d, &function_146f6916);
    a_code = [[ level.var_ca7eab3b ]]->function_c69f5b9d();
    [[ level.var_ca7eab3b ]]->function_110d42fa(var_f90df519);
}

// Namespace namespace_b361ecc3
// Params 0, eflags: 0x1 linked
// Checksum 0xa3b990ef, Offset: 0x690
// Size: 0x24
function function_146f6916() {
    level flag::set("keeper_sword_locker");
}

