#using scripts/zm/zm_moon_sq;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_92f319c2;

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0x81e3cc71, Offset: 0x4f8
// Size: 0x558
function function_358664bb() {
    /#
        level endon(#"hash_11cd8084");
        level endon(#"hash_20778669");
        if (!isdefined(level.var_f4f9b4b2)) {
            level.var_f4f9b4b2 = 1;
            level.var_1d3f9fdf = newdebughudelem();
            level.var_1d3f9fdf.location = 0;
            level.var_1d3f9fdf.alignx = "scr_debug_ss";
            level.var_1d3f9fdf.aligny = "scr_debug_ss";
            level.var_1d3f9fdf.foreground = 1;
            level.var_1d3f9fdf.fontscale = 1.3;
            level.var_1d3f9fdf.sort = 20;
            level.var_1d3f9fdf.x = 10;
            level.var_1d3f9fdf.y = -16;
            level.var_1d3f9fdf.og_scale = 1;
            level.var_1d3f9fdf.color = (255, 255, 255);
            level.var_1d3f9fdf.alpha = 1;
            level.var_ac554d7 = newdebughudelem();
            level.var_ac554d7.location = 0;
            level.var_ac554d7.alignx = "scr_debug_ss";
            level.var_ac554d7.aligny = "scr_debug_ss";
            level.var_ac554d7.foreground = 1;
            level.var_ac554d7.fontscale = 1.3;
            level.var_ac554d7.sort = 20;
            level.var_ac554d7.x = 0;
            level.var_ac554d7.y = -16;
            level.var_ac554d7.og_scale = 1;
            level.var_ac554d7.color = (255, 255, 255);
            level.var_ac554d7.alpha = 1;
            level.var_ac554d7 settext("scr_debug_ss");
            level.var_92bff4b = newdebughudelem();
            level.var_92bff4b.location = 0;
            level.var_92bff4b.alignx = "scr_debug_ss";
            level.var_92bff4b.aligny = "scr_debug_ss";
            level.var_92bff4b.foreground = 1;
            level.var_92bff4b.fontscale = 1.3;
            level.var_92bff4b.sort = 20;
            level.var_92bff4b.x = 10;
            level.var_92bff4b.y = 270;
            level.var_92bff4b.og_scale = 1;
            level.var_92bff4b.color = (255, 255, 255);
            level.var_92bff4b.alpha = 1;
            level.var_5dca570b = newdebughudelem();
            level.var_5dca570b.location = 0;
            level.var_5dca570b.alignx = "scr_debug_ss";
            level.var_5dca570b.aligny = "scr_debug_ss";
            level.var_5dca570b.foreground = 1;
            level.var_5dca570b.fontscale = 1.3;
            level.var_5dca570b.sort = 20;
            level.var_5dca570b.x = 0;
            level.var_5dca570b.y = 270;
            level.var_5dca570b.og_scale = 1;
            level.var_5dca570b.color = (255, 255, 255);
            level.var_5dca570b.alpha = 1;
            level.var_5dca570b settext("scr_debug_ss");
        }
        while (true) {
            if (isdefined(level.var_58f48a6c)) {
                str = "scr_debug_ss";
                for (i = 0; i < level.var_58f48a6c.size; i++) {
                    str += level.var_58f48a6c[i];
                }
                level.var_92bff4b settext(str);
            } else {
                level.var_92bff4b settext("scr_debug_ss");
            }
            wait(0.1);
        }
    #/
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0xfb5fa100, Offset: 0xa58
// Size: 0x148
function function_923ff8b() {
    level flag::init("displays_active");
    level flag::init("wait_for_hack");
    namespace_6e97c459::function_5a90ed82("sq", "ss1", &function_8377a7d8, &function_7747c56, &function_15345222);
    buttons = getentarray("sq_ss_button", "targetname");
    for (i = 0; i < buttons.size; i++) {
        ent = getent(buttons[i].target, "targetname");
        buttons[i].var_a8168eb3 = ent;
    }
    level.var_db4f7a28 = buttons;
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0xa272f70f, Offset: 0xba8
// Size: 0x54
function init_2() {
    namespace_6e97c459::function_5a90ed82("sq", "ss2", &function_f57f1713, &function_7747c56, &function_ef31d7b9);
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0xef332a35, Offset: 0xc08
// Size: 0x30
function function_8377a7d8() {
    level flag::clear("wait_for_hack");
    level.var_acd4746d = 1;
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0x7822343, Offset: 0xc40
// Size: 0x10
function function_f57f1713() {
    level.var_acd4746d = 2;
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x0
// Checksum 0x1434f9e3, Offset: 0xc58
// Size: 0x2c
function function_e504fded(hacker) {
    level flag::clear("wait_for_hack");
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0x96c969d, Offset: 0xc90
// Size: 0x10c
function function_7747c56() {
    buttons = level.var_db4f7a28;
    array::thread_all(buttons, &function_1c03ffec);
    if (isdefined(level.var_7a69970d)) {
        for (i = 0; i < level.var_7a69970d.size; i++) {
            namespace_6d813654::function_fcbe2f17(level.var_7a69970d[i]);
        }
    }
    level thread function_358664bb();
    if (level.var_acd4746d == 1) {
        function_bc15f24f();
    } else {
        function_d3d8b154();
    }
    namespace_6e97c459::function_2f3ced1f("sq", "ss" + level.var_acd4746d);
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0xec3fe8a, Offset: 0xda8
// Size: 0x1c
function function_bc15f24f() {
    function_f5a030d4(6, 1);
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0x95617ab, Offset: 0xdd0
// Size: 0x9e
function function_d3d8b154() {
    level.var_1b1cbb0d = 0;
    function_f5a030d4(6, 3);
    wait(2);
    level notify(#"hash_a94f7e83");
    function_f5a030d4(7, 4);
    wait(2);
    level notify(#"hash_a94f7e83");
    function_f5a030d4(8, 5);
    wait(2);
    level notify(#"hash_a94f7e83");
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0xa83b18e, Offset: 0xe78
// Size: 0x214
function function_6a352b8(var_885f0359) {
    seq = [];
    for (i = 0; i < var_885f0359; i++) {
        seq[seq.size] = randomintrange(0, 4);
    }
    last = -1;
    var_57800922 = 0;
    for (i = 0; i < var_885f0359; i++) {
        if (seq[i] == last) {
            var_57800922++;
            if (var_57800922 >= 2) {
                while (seq[i] == last) {
                    seq[i] = randomintrange(0, 4);
                }
                var_57800922 = 0;
                last = seq[i];
            }
            continue;
        }
        last = seq[i];
        var_57800922 = 0;
    }
    /#
        if (isdefined(level.var_1d3f9fdf)) {
            str = "scr_debug_ss";
            for (i = 0; i < seq.size; i++) {
                str += seq[i];
            }
            level.var_1d3f9fdf settext(str);
        }
    #/
    if (1 == getdvarint("scr_debug_ss")) {
        for (i = 0; i < seq.size; i++) {
            seq[i] = 0;
        }
    }
    return seq;
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0xb561c824, Offset: 0x1098
// Size: 0x9e
function function_e5254825() {
    /#
        if (isdefined(level.var_1d3f9fdf)) {
            level.var_1d3f9fdf destroy();
            level.var_1d3f9fdf = undefined;
            level.var_ac554d7 destroy();
            level.var_ac554d7 = undefined;
            level.var_92bff4b destroy();
            level.var_92bff4b = undefined;
            level.var_5dca570b destroy();
            level.var_5dca570b = undefined;
            level.var_f4f9b4b2 = undefined;
        }
    #/
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0x4897c184, Offset: 0x1140
// Size: 0x64
function function_15345222(success) {
    function_e5254825();
    level flag::set("ss1");
    array::thread_all(level.var_db4f7a28, &function_6a4e9b52);
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0x35538cd9, Offset: 0x11b0
// Size: 0x1c
function function_ef31d7b9(success) {
    function_e5254825();
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0x2fb6565a, Offset: 0x11d8
// Size: 0x24
function function_6a4e9b52() {
    self endon(#"hash_de531358");
    self thread function_1c03ffec(1);
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x0
// Checksum 0x73135c14, Offset: 0x1208
// Size: 0x80
function function_b56e4c71() {
    level endon(#"hash_de531358");
    level endon(#"hash_11cd8084");
    level endon(#"hash_20778669");
    while (true) {
        /#
            print3d(self.origin + (0, 0, 12), self.script_int, (0, 255, 0), 1);
        #/
        wait(0.1);
    }
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0x125ac8b, Offset: 0x1290
// Size: 0x35c
function function_49acf21c() {
    level flag::set("displays_active");
    buttons = level.var_db4f7a28;
    for (i = 0; i < buttons.size; i++) {
        ent = buttons[i].var_a8168eb3;
        ent setmodel("p7_zm_moo_computer_rocket_launch");
    }
    for (i = 0; i < buttons.size; i++) {
        button = undefined;
        for (j = 0; j < buttons.size; j++) {
            if (buttons[j].script_int == i) {
                button = buttons[j];
            }
        }
        if (isdefined(button)) {
            ent = button.var_a8168eb3;
            model = function_84cb185b(button.script_int);
            ent setmodel(model);
            ent playsound(function_bc9231aa(button.script_int));
            wait(0.6);
            ent setmodel("p7_zm_moo_computer_rocket_launch");
        }
    }
    level thread function_4a167f8(level.var_acd4746d);
    for (i = buttons.size - 1; i >= 0; i--) {
        button = undefined;
        for (j = 0; j < buttons.size; j++) {
            if (buttons[j].script_int == i) {
                button = buttons[j];
            }
        }
        if (isdefined(button)) {
            ent = button.var_a8168eb3;
            model = function_84cb185b(button.script_int);
            ent setmodel(model);
            ent playsound(function_bc9231aa(button.script_int));
            wait(0.6);
            ent setmodel("p7_zm_moo_computer_rocket_launch");
        }
    }
    wait(0.5);
    level flag::clear("displays_active");
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0x9842501f, Offset: 0x15f8
// Size: 0x190
function function_1c03ffec(dud) {
    level endon(#"hash_11cd8084");
    level endon(#"hash_20778669");
    if (!isdefined(dud)) {
        self notify(#"hash_de531358");
    }
    pos = self.origin;
    pressed = self.origin - anglestoright(self.angles) * 0.25;
    var_d5c17613 = self.var_a8168eb3;
    while (true) {
        self waittill(#"trigger");
        if (!level flag::get("displays_active")) {
            if (!isdefined(dud)) {
                if (isdefined(level.var_58f48a6c)) {
                    level.var_58f48a6c[level.var_58f48a6c.size] = self.script_int;
                }
            }
            model = function_84cb185b(self.script_int);
            var_d5c17613 playsound(function_bc9231aa(self.script_int));
            var_d5c17613 setmodel(model);
        }
        wait(0.3);
        var_d5c17613 setmodel("p7_zm_moo_computer_rocket_launch");
    }
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0xa6bf3dcd, Offset: 0x1790
// Size: 0x96
function function_84cb185b(num) {
    model = "p7_zm_moo_computer_rocket_launch";
    switch (num) {
    case 0:
        model = "p7_zm_moo_computer_rocket_launch_red";
        break;
    case 1:
        model = "p7_zm_moo_computer_rocket_launch_green";
        break;
    case 2:
        model = "p7_zm_moo_computer_rocket_launch_blue";
        break;
    case 3:
        model = "p7_zm_moo_computer_rocket_launch_yellow";
        break;
    }
    return model;
}

// Namespace namespace_92f319c2
// Params 2, eflags: 0x1 linked
// Checksum 0x30da104d, Offset: 0x1830
// Size: 0x12c
function function_f5a030d4(var_885f0359, var_3c4b0c82) {
    seq = function_6a352b8(var_885f0359);
    level.var_58f48a6c = [];
    level.var_6b872973 = 0;
    for (fails = 0; !level.var_6b872973; fails = 0) {
        wait(0.5);
        self thread function_34ed5b74(seq, var_885f0359, var_3c4b0c82);
        self util::waittill_either("ss_won", "ss_failed");
        if (level.var_6b872973) {
            function_bb7aaf31(seq);
            continue;
        }
        function_4ec45174();
        fails++;
        if (fails == 4) {
            seq = function_6a352b8(var_885f0359);
        }
    }
}

// Namespace namespace_92f319c2
// Params 3, eflags: 0x1 linked
// Checksum 0x5bdaaeee, Offset: 0x1968
// Size: 0x102
function function_34ed5b74(seq, var_885f0359, var_3c4b0c82) {
    self endon(#"hash_93649aa2");
    self endon(#"hash_ca557ffd");
    function_49acf21c();
    pos = var_3c4b0c82;
    buttons = level.var_db4f7a28;
    for (i = pos; i <= var_885f0359; i++) {
        level.var_58f48a6c = [];
        function_d484a0b5(buttons, seq, i);
        wait(1);
        function_f1aaf3a(seq, i);
        wait(1);
    }
    level.var_6b872973 = 1;
    self notify(#"hash_93649aa2");
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0xe3680651, Offset: 0x1a78
// Size: 0x46
function function_2cfabd29(len) {
    self endon(#"hash_92685f60");
    self endon(#"hash_ca557ffd");
    self endon(#"hash_93649aa2");
    wait(len * 4);
    self notify(#"hash_ca557ffd");
}

// Namespace namespace_92f319c2
// Params 2, eflags: 0x1 linked
// Checksum 0xd9e1ce6c, Offset: 0x1ac8
// Size: 0x10e
function function_f1aaf3a(sequence, len) {
    self thread function_2cfabd29(len);
    while (level.var_58f48a6c.size < len) {
        for (i = 0; i < level.var_58f48a6c.size; i++) {
            if (level.var_58f48a6c[i] != sequence[i]) {
                self notify(#"hash_ca557ffd");
            }
        }
        wait(0.05);
    }
    for (i = 0; i < level.var_58f48a6c.size; i++) {
        if (level.var_58f48a6c[i] != sequence[i]) {
            self notify(#"hash_ca557ffd");
        }
    }
    level.var_58f48a6c = [];
    self notify(#"hash_92685f60");
}

// Namespace namespace_92f319c2
// Params 0, eflags: 0x1 linked
// Checksum 0x2087a31d, Offset: 0x1be0
// Size: 0x234
function function_4ec45174() {
    level flag::set("displays_active");
    buttons = level.var_db4f7a28;
    level thread function_3dab436(level.var_acd4746d);
    var_f5231b74 = 0;
    while (!var_f5231b74) {
        var_f5231b74 = 1;
        for (i = 0; i < buttons.size; i++) {
            ent = buttons[i].var_a8168eb3;
            if (ent.model != "p7_zm_moo_computer_rocket_launch") {
                var_f5231b74 = 0;
                break;
            }
        }
        wait(0.1);
    }
    level thread sound::play_in_space("evt_ss_wrong", (-1006.3, 294.2, -93.7));
    for (i = 0; i < 5; i++) {
        for (j = 0; j < buttons.size; j++) {
            ent = buttons[j].var_a8168eb3;
            ent setmodel("p7_zm_moo_computer_rocket_launch_red");
        }
        wait(0.2);
        for (j = 0; j < buttons.size; j++) {
            ent = buttons[j].var_a8168eb3;
            ent setmodel("p7_zm_moo_computer_rocket_launch");
        }
        wait(0.05);
    }
    level flag::clear("displays_active");
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0x9267e87a, Offset: 0x1e20
// Size: 0x86
function function_ef1f65ec(seq) {
    for (i = 0; i < seq.size; i++) {
        level thread sound::play_in_space(function_bc9231aa(seq[i]), (-1006.3, 294.2, -93.7));
        wait(0.2);
    }
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0x8df2e6be, Offset: 0x1eb0
// Size: 0x224
function function_bb7aaf31(seq) {
    level flag::set("displays_active");
    buttons = level.var_db4f7a28;
    level thread function_ca3d5a09(level.var_acd4746d);
    var_f5231b74 = 0;
    while (!var_f5231b74) {
        var_f5231b74 = 1;
        for (i = 0; i < buttons.size; i++) {
            ent = buttons[i].var_a8168eb3;
            if (ent.model != "p7_zm_moo_computer_rocket_launch") {
                var_f5231b74 = 0;
                break;
            }
        }
        wait(0.1);
    }
    level thread function_ef1f65ec(seq);
    for (i = 0; i < 5; i++) {
        for (j = 0; j < buttons.size; j++) {
            ent = buttons[j].var_a8168eb3;
            ent setmodel("p7_zm_moo_computer_rocket_launch_green");
        }
        wait(0.2);
        for (j = 0; j < buttons.size; j++) {
            ent = buttons[j].var_a8168eb3;
            ent setmodel("p7_zm_moo_computer_rocket_launch");
        }
        wait(0.05);
    }
    level flag::clear("displays_active");
}

// Namespace namespace_92f319c2
// Params 3, eflags: 0x1 linked
// Checksum 0xc48a72f5, Offset: 0x20e0
// Size: 0x21c
function function_d484a0b5(buttons, seq, index) {
    level flag::set("displays_active");
    for (i = 0; i < index; i++) {
        print_duration = 1;
        var_3d449fd = 0.4;
        if (i < index - 1) {
            print_duration /= 2;
            var_3d449fd /= 2;
        }
        for (j = 0; j < buttons.size; j++) {
            ent = buttons[j].var_a8168eb3;
            model = function_84cb185b(seq[i]);
            level thread sound::play_in_space(function_bc9231aa(seq[i]), (-1006.3, 294.2, -93.7));
            ent setmodel(model);
        }
        wait(print_duration);
        for (j = 0; j < buttons.size; j++) {
            ent = buttons[j].var_a8168eb3;
            ent setmodel("p7_zm_moo_computer_rocket_launch");
        }
        wait(var_3d449fd);
    }
    level flag::clear("displays_active");
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0x8a5a5a66, Offset: 0x2308
// Size: 0x5e
function function_bc9231aa(index) {
    switch (index) {
    case 0:
        return "evt_ss_e";
    case 1:
        return "evt_ss_d";
    case 2:
        return "evt_ss_c";
    case 3:
        return "evt_ss_lo_g";
    }
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0xe3adb3b6, Offset: 0x2370
// Size: 0x104
function function_4a167f8(stage) {
    var_843607b8 = level.var_db4f7a28[1].var_a8168eb3;
    if (stage == 1) {
        player = function_70005ff1(var_843607b8);
        if (isdefined(player)) {
            var_843607b8 playsoundwithnotify("vox_mcomp_quest_step1_0", "mcomp_done0");
            var_843607b8 waittill(#"hash_7b31fea6");
            if (isdefined(player)) {
                player thread zm_audio::create_and_play_dialog("eggs", "quest1", 0);
            }
        }
        return;
    }
    if (level.var_1b1cbb0d == 0) {
        var_843607b8 playsoundwithnotify("vox_mcomp_quest_step7_0", "mcomp_done1");
    }
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0x4b6f772b, Offset: 0x2480
// Size: 0x1ae
function function_3dab436(stage) {
    var_843607b8 = level.var_db4f7a28[1].var_a8168eb3;
    if (stage == 1) {
        player = function_70005ff1(var_843607b8);
        if (isdefined(player)) {
            var_843607b8 playsoundwithnotify("vox_mcomp_quest_step1_1", "mcomp_done2");
            var_843607b8 waittill(#"hash_2f2d09d4");
            if (isdefined(player)) {
                player thread zm_audio::create_and_play_dialog("eggs", "quest1", 1);
            }
        }
        return;
    }
    player = function_70005ff1(var_843607b8);
    if (isdefined(player)) {
        switch (level.var_1b1cbb0d) {
        case 0:
            player thread zm_audio::create_and_play_dialog("eggs", "quest1", 1);
            break;
        case 1:
            player thread zm_audio::create_and_play_dialog("eggs", "quest7", 1);
            break;
        case 2:
            player thread zm_audio::create_and_play_dialog("eggs", "quest7", 3);
            break;
        }
    }
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0xe8b3a417, Offset: 0x2638
// Size: 0x1d6
function function_ca3d5a09(stage) {
    var_843607b8 = level.var_db4f7a28[1].var_a8168eb3;
    if (stage == 1) {
        player = function_70005ff1(var_843607b8);
        if (isdefined(player)) {
            var_843607b8 playsoundwithnotify("vox_mcomp_quest_step1_2", "mcomp_done3");
            var_843607b8 waittill(#"hash_552f843d");
            if (isdefined(player)) {
                player thread zm_audio::create_and_play_dialog("eggs", "quest1", 2);
            }
        }
        return;
    }
    switch (level.var_1b1cbb0d) {
    case 0:
        var_843607b8 playsoundwithnotify("vox_mcomp_quest_step7_2", "mcomp_done4");
        level.var_1b1cbb0d++;
        break;
    case 1:
        var_843607b8 playsoundwithnotify("vox_mcomp_hack_success", "mcomp_done5");
        level.var_1b1cbb0d++;
        break;
    case 2:
        var_843607b8 playsoundwithnotify("vox_mcomp_quest_step7_4", "mcomp_done6");
        var_843607b8 waittill(#"hash_97232030");
        if (!level flag::get("be2")) {
            var_843607b8 playsoundwithnotify("vox_xcomp_quest_step7_5", "xcomp_done7");
        }
        break;
    }
}

// Namespace namespace_92f319c2
// Params 1, eflags: 0x1 linked
// Checksum 0x2f4139b1, Offset: 0x2818
// Size: 0x9c
function function_70005ff1(org) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (distancesquared(org.origin, players[i].origin) <= 5625) {
            return players[i];
        }
    }
    return undefined;
}

