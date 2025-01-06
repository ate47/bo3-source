#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/util_shared;
#using scripts/zm/zm_temple;
#using scripts/zm/zm_temple_elevators;

#namespace zm_temple_pack_a_punch;

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x744bf300, Offset: 0x4a0
// Size: 0x16c
function init_pack_a_punch() {
    level flag::init("pap_round");
    level flag::init("pap_active");
    level flag::init("pap_open");
    level flag::init("pap_enabled");
    level.var_21952a4a = 30;
    level.var_dc3777db = getentarray("pack_a_punch_timer", "targetname");
    level.var_baa501c2 = -80;
    util::registerclientsys("pap_indicator_spinners");
    level.var_7ec580f7 = 60;
    /#
        if (getdvarint("<dev string:x28>")) {
            level.var_7ec580f7 = 20;
        }
    #/
    function_10e95862();
    function_caea2097();
    function_f34f1d1();
    function_d72e5036();
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xf5b5ebc1, Offset: 0x618
// Size: 0x554
function function_10e95862() {
    level thread function_7b8d91ed();
    var_45648617 = getent("pap_stairs_mesh", "targetname");
    var_45648617 delete();
    level.pap_stairs = [];
    for (i = 0; i < 4; i++) {
        var_84b63cdc = getent("pap_stairs" + i + 1, "targetname");
        if (!isdefined(var_84b63cdc.script_vector)) {
            var_84b63cdc.script_vector = (0, 0, 72);
        }
        var_84b63cdc.movetime = 3;
        var_84b63cdc.movedist = var_84b63cdc.script_vector;
        if (i == 3) {
            var_84b63cdc.down_origin = var_84b63cdc.origin;
            var_84b63cdc.up_origin = var_84b63cdc.down_origin + var_84b63cdc.movedist;
        } else {
            var_84b63cdc.up_origin = var_84b63cdc.origin;
            var_84b63cdc.down_origin = var_84b63cdc.up_origin - var_84b63cdc.movedist;
            var_84b63cdc.origin = var_84b63cdc.down_origin;
        }
        var_84b63cdc.state = "down";
        level.pap_stairs[i] = var_84b63cdc;
    }
    level.pap_stairs_clip = getent("pap_stairs_clip", "targetname");
    if (isdefined(level.pap_stairs_clip)) {
        level.pap_stairs_clip.var_bcd82f32 = 72;
    }
    level.pap_playerclip = getentarray("pap_playerclip", "targetname");
    for (i = 0; i < level.pap_playerclip.size; i++) {
        level.pap_playerclip[i].var_b81038e3 = level.pap_playerclip[i].origin;
    }
    level.pap_ramp = getent("pap_ramp", "targetname");
    level.brush_pap_traversal = getent("brush_pap_traversal", "targetname");
    if (isdefined(level.brush_pap_traversal)) {
        level.brush_pap_traversal solid();
        level.brush_pap_traversal disconnectpaths();
        a_nodes = getnodearray("node_pap_jump_bottom", "targetname");
        foreach (node in a_nodes) {
            linktraversal(node);
        }
    }
    level.brush_pap_side_l = getent("brush_pap_side_l", "targetname");
    if (isdefined(level.brush_pap_side_l)) {
        level.brush_pap_side_l function_5e3bbe0e();
    }
    level.brush_pap_side_r = getent("brush_pap_side_r", "targetname");
    if (isdefined(level.brush_pap_side_r)) {
        level.brush_pap_side_r function_5e3bbe0e();
    }
    brush_pap_pathing_ramp_r = getent("brush_pap_pathing_ramp_r", "targetname");
    if (isdefined(brush_pap_pathing_ramp_r)) {
        brush_pap_pathing_ramp_r delete();
    }
    brush_pap_pathing_ramp_l = getent("brush_pap_pathing_ramp_l", "targetname");
    if (isdefined(brush_pap_pathing_ramp_l)) {
        brush_pap_pathing_ramp_l delete();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x409afe65, Offset: 0xb78
// Size: 0x1d4
function function_edc5a52f() {
    wait 0.1;
    self setcontents(0);
    self startragdoll();
    self.base setcandamage(1);
    self.base.health = 1;
    self.base waittill(#"damage");
    mover = getent(self.base.target, "targetname");
    var_13cf2da2 = isdefined(self.base.script_string) && self.base.script_string == "geyser";
    self.base delete();
    self.base = undefined;
    wait 0.5;
    if (var_13cf2da2) {
        level thread function_fed373b1(mover.origin);
    }
    mover movez(-14, 1, 0.2, 0);
    mover waittill(#"movedone");
    level.var_ffeafb88 -= 1;
    if (level.var_ffeafb88 <= 0) {
        level flag::set("pap_enabled");
    }
}

// Namespace zm_temple_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0xcf66f97c, Offset: 0xd58
// Size: 0x74
function function_fed373b1(origin) {
    fxobj = spawnfx(level._effect["geyser_active"], origin);
    triggerfx(fxobj);
    wait 3;
    fxobj delete();
}

// Namespace zm_temple_pack_a_punch
// Params 2, eflags: 0x0
// Checksum 0xc92c8a02, Offset: 0xdd8
// Size: 0x6c
function power(base, exp) {
    assert(exp >= 0);
    if (exp == 0) {
        return 1;
    }
    return base * power(base, exp - 1);
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x7b8de192, Offset: 0xe50
// Size: 0x3f8
function function_7b8d91ed() {
    spots = getentarray("hanging_base", "targetname");
    for (i = 0; i < spots.size; i++) {
        spots[i] delete();
    }
    level flag::wait_till("power_on");
    triggers = [];
    for (i = 0; i < 4; i++) {
        triggers[i] = getent("pap_blocker_trigger" + i + 1, "targetname");
    }
    function_ade37183(triggers);
    array::thread_all(triggers, &function_87897a6e);
    wait 1;
    var_c21143fd = -1;
    var_94dcb64e = -1;
    while (true) {
        players = getplayers();
        var_5869d5c7 = players.size;
        /#
            if (getdvarint("<dev string:x40>") == 2) {
                var_5869d5c7 = 1;
            }
        #/
        var_f0faec36 = 0;
        var_ee840995 = 0;
        for (i = 0; i < triggers.size; i++) {
            if (triggers[i].plate.active) {
                var_f0faec36++;
            }
            if (triggers[i].plate.active || triggers[i].requiredplayers - 1 >= var_5869d5c7) {
                var_ee840995 += power(2, triggers[i].requiredplayers - 1);
            }
        }
        if (var_c21143fd != var_f0faec36 || var_ee840995 != var_94dcb64e) {
            var_c21143fd = var_f0faec36;
            var_94dcb64e = var_ee840995;
            function_4fb3fde4(var_f0faec36, var_ee840995);
        }
        function_ef683e1c(triggers);
        if (var_f0faec36 >= var_5869d5c7) {
            for (i = 0; i < triggers.size; i++) {
                triggers[i] notify(#"pap_active");
                triggers[i].plate function_1e1dd74f();
            }
            function_328dc42a();
            function_ade37183(triggers);
            array::thread_all(triggers, &function_87897a6e);
            function_4fb3fde4(4, 15);
            wait 1;
        }
        util::wait_network_frame();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0x8a49ee3d, Offset: 0x1250
// Size: 0x9a
function function_ade37183(triggers) {
    var_2dc80428 = array(1, 2, 3, 4);
    var_2dc80428 = array::randomize(var_2dc80428);
    for (i = 0; i < triggers.size; i++) {
        triggers[i].requiredplayers = var_2dc80428[i];
    }
}

// Namespace zm_temple_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0xe7b4f7ad, Offset: 0x12f8
// Size: 0x106
function function_ef683e1c(triggers) {
    var_f6bada3 = 0;
    for (i = 0; i < triggers.size; i++) {
        if (isdefined(triggers[i].touched) && triggers[i].touched) {
            var_f6bada3++;
        }
    }
    for (i = 0; i < var_f6bada3; i++) {
        level.pap_stairs[i] function_1667efe();
    }
    for (i = var_f6bada3; i < level.pap_stairs.size; i++) {
        level.pap_stairs[i] function_81c694b1();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x43be0f43, Offset: 0x1408
// Size: 0x3c
function function_907c2f2c() {
    numplayers = getplayers().size;
    if (numplayers >= self.requiredplayers) {
        return true;
    }
    return false;
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x74e8c822, Offset: 0x1450
// Size: 0x2f4
function function_87897a6e() {
    self endon(#"pap_active");
    plate = getent(self.target, "targetname");
    self.plate = plate;
    plate.movetime = 2;
    plate.movedist = (0, 0, 10);
    plate.down_origin = plate.origin;
    plate.up_origin = plate.origin + plate.movedist;
    plate.origin = plate.down_origin;
    plate.state = "down";
    movespeed = 10;
    while (true) {
        while (!self function_907c2f2c()) {
            plate.active = 0;
            self.touched = 0;
            plate thread function_1e1dd74f();
            wait 0.1;
        }
        plate.active = 0;
        self.touched = 0;
        plate function_ba049ca0();
        plate waittill(#"hash_b6bb8241");
        while (self function_907c2f2c()) {
            players = getplayers();
            touching = 0;
            if (!self function_907c2f2c()) {
                break;
            }
            for (i = 0; i < players.size && !touching; i++) {
                if (players[i].sessionstate != "spectator") {
                    touching = players[i] istouching(self);
                }
            }
            self.touched = touching;
            if (touching) {
                plate function_1e1dd74f();
            } else {
                plate function_ba049ca0();
            }
            plate.active = plate.state == "down";
            wait 0.1;
        }
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xccdce5fb, Offset: 0x1750
// Size: 0x3c
function function_e8408225() {
    self function_7db62cab();
    self playloopsound("zmb_staircase_loop");
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x4b3cd9b4, Offset: 0x1798
// Size: 0x1c
function function_7db62cab() {
    self stoploopsound();
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xe12f5a74, Offset: 0x17c0
// Size: 0x24
function function_2f05fda() {
    self playsound("zmb_staircase_lock");
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xe18ab681, Offset: 0x17f0
// Size: 0x3c
function function_6905d9af() {
    self function_1d972325();
    self playloopsound("zmb_pressure_plate_loop");
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x270677c3, Offset: 0x1838
// Size: 0x1c
function function_1d972325() {
    self stoploopsound();
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x8dd455ab, Offset: 0x1860
// Size: 0x24
function function_e9bfe310() {
    self playsound("zmb_pressure_plate_lock");
}

// Namespace zm_temple_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0x7b463015, Offset: 0x1890
// Size: 0x42
function function_8111fadb(state) {
    if (state == "up") {
        return self.up_origin;
    } else if (state == "down") {
        return self.down_origin;
    }
    return undefined;
}

// Namespace zm_temple_pack_a_punch
// Params 3, eflags: 0x0
// Checksum 0x34ed23bb, Offset: 0x18e0
// Size: 0x14a
function function_80f65f2d(state, var_693a19ef, var_b433957c) {
    self endon(#"move");
    goalorigin = self function_8111fadb(state);
    movetime = self.movetime;
    timescale = abs(self.origin[2] - goalorigin[2]) / self.movedist[2];
    movetime *= timescale;
    self.state = "moving_" + state;
    if (movetime > 0) {
        if (isdefined(var_693a19ef)) {
            self thread [[ var_693a19ef ]]();
        }
        self moveto(goalorigin, movetime);
        self waittill(#"movedone");
        if (isdefined(var_b433957c)) {
            self thread [[ var_b433957c ]]();
        }
    }
    self.state = state;
    self notify(#"hash_b6bb8241");
}

// Namespace zm_temple_pack_a_punch
// Params 3, eflags: 0x0
// Checksum 0x7abd5f42, Offset: 0x1a38
// Size: 0x74
function function_2e46ac53(state, var_693a19ef, var_b433957c) {
    if (self.state == state || self.state == "moving_" + state) {
        return;
    }
    self notify(#"move");
    self thread function_80f65f2d(state, var_693a19ef, var_b433957c);
}

// Namespace zm_temple_pack_a_punch
// Params 2, eflags: 0x0
// Checksum 0xc3246341, Offset: 0x1ab8
// Size: 0x3c
function function_5a597a6a(var_693a19ef, var_b433957c) {
    self thread function_2e46ac53("down", var_693a19ef, var_b433957c);
}

// Namespace zm_temple_pack_a_punch
// Params 2, eflags: 0x0
// Checksum 0x3cc92fde, Offset: 0x1b00
// Size: 0x3c
function function_69b857a1(var_693a19ef, var_b433957c) {
    self thread function_2e46ac53("up", var_693a19ef, var_b433957c);
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xf1170644, Offset: 0x1b48
// Size: 0x54
function function_ba049ca0() {
    var_693a19ef = &function_80bf3fc3;
    var_b433957c = &function_30493584;
    self thread function_69b857a1(var_693a19ef, var_b433957c);
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x3b854b52, Offset: 0x1ba8
// Size: 0x54
function function_1e1dd74f() {
    var_693a19ef = &function_80bf3fc3;
    var_b433957c = &function_30493584;
    self thread function_5a597a6a(var_693a19ef, var_b433957c);
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xd842f6e, Offset: 0x1c08
// Size: 0x1c
function function_80bf3fc3() {
    self function_6905d9af();
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x37ca33e, Offset: 0x1c30
// Size: 0x34
function function_30493584() {
    self function_1d972325();
    self function_e9bfe310();
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x5eff0ba2, Offset: 0x1c70
// Size: 0x4e
function function_e5f52317() {
    for (i = 0; i < level.pap_stairs.size; i++) {
        level.pap_stairs[i] thread function_81c694b1();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x1c590d5, Offset: 0x1cc8
// Size: 0x4e
function function_aa9a7f48() {
    for (i = 0; i < level.pap_stairs.size; i++) {
        level.pap_stairs[i] thread function_1667efe();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xe13d06e6, Offset: 0x1d20
// Size: 0x54
function function_1667efe() {
    var_693a19ef = &function_cc4d8661;
    var_b433957c = &function_96c6fb2;
    self function_69b857a1(var_693a19ef, var_b433957c);
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x3811c7d9, Offset: 0x1d80
// Size: 0x54
function function_81c694b1() {
    var_693a19ef = &function_cc4d8661;
    var_b433957c = &function_96c6fb2;
    self function_5a597a6a(var_693a19ef, var_b433957c);
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xcf2baa59, Offset: 0x1de0
// Size: 0x1c
function function_cc4d8661() {
    self function_e8408225();
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x872bcf5f, Offset: 0x1e08
// Size: 0x34
function function_96c6fb2() {
    self function_7db62cab();
    self function_2f05fda();
}

// Namespace zm_temple_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0x4a62a31c, Offset: 0x1e48
// Size: 0x82
function function_654eecd4(state) {
    for (i = 0; i < level.pap_stairs.size; i++) {
        var_84b63cdc = level.pap_stairs[i];
        while (true) {
            if (var_84b63cdc.state == state) {
                break;
            }
            wait 0.1;
        }
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xabbf9d59, Offset: 0x1ed8
// Size: 0x15c
function function_e863f374() {
    function_654eecd4("up");
    if (isdefined(level.brush_pap_traversal)) {
        a_nodes = getnodearray("node_pap_jump_bottom", "targetname");
        foreach (node in a_nodes) {
            unlinktraversal(node);
        }
        level.brush_pap_traversal notsolid();
        level.brush_pap_traversal connectpaths();
    }
    if (isdefined(level.brush_pap_side_l)) {
        level.brush_pap_side_l function_ce7aeb18();
    }
    if (isdefined(level.brush_pap_side_r)) {
        level.brush_pap_side_r function_ce7aeb18();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x78f25bb9, Offset: 0x2040
// Size: 0x15c
function function_9eee1f8b() {
    function_654eecd4("down");
    if (isdefined(level.brush_pap_traversal)) {
        a_nodes = getnodearray("node_pap_jump_bottom", "targetname");
        foreach (node in a_nodes) {
            linktraversal(node);
        }
        level.brush_pap_traversal solid();
        level.brush_pap_traversal disconnectpaths();
    }
    if (isdefined(level.brush_pap_side_l)) {
        level.brush_pap_side_l function_5e3bbe0e();
    }
    if (isdefined(level.brush_pap_side_r)) {
        level.brush_pap_side_r function_5e3bbe0e();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x55a6832, Offset: 0x21a8
// Size: 0x1d4
function function_328dc42a() {
    player_blocker = getent("pap_stairs_player_clip", "targetname");
    level flag::set("pap_active");
    level thread function_cc18e1b9();
    if (isdefined(level.pap_stairs_clip)) {
        level.pap_stairs_clip movez(level.pap_stairs_clip.var_bcd82f32, 2, 0.5, 0.5);
    }
    function_aa9a7f48();
    function_e863f374();
    if (isdefined(player_blocker)) {
        player_blocker notsolid();
    }
    level function_5b2895bc();
    level thread function_fe154bfd();
    level waittill(#"hash_d4e1b9c");
    level flag::clear("pap_active");
    if (isdefined(level.pap_stairs_clip)) {
        level.pap_stairs_clip movez(-1 * level.pap_stairs_clip.var_bcd82f32, 2, 0.5, 0.5);
    }
    level thread function_3817481a();
    function_e5f52317();
    function_9eee1f8b();
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x6b6746c9, Offset: 0x2388
// Size: 0x116
function function_cc18e1b9() {
    corpse_trig = getent("pap_target_finder", "targetname");
    var_5419da20 = getent("pap_target_finder2", "targetname");
    corpses = getcorpsearray();
    if (isdefined(corpses)) {
        for (i = 0; i < corpses.size; i++) {
            if (corpses[i] istouching(corpse_trig) || corpses[i] istouching(var_5419da20)) {
                corpses[i] thread function_75ec8039();
            }
        }
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x71c79a4b, Offset: 0x24a8
// Size: 0x4c
function function_75ec8039() {
    playfx(level._effect["corpse_gib"], self.origin);
    self delete();
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x4963679b, Offset: 0x2500
// Size: 0x1a4
function function_3817481a() {
    if (isdefined(level.pap_ramp)) {
        level thread function_c55e1ae3();
        if (!isdefined(level.pap_ramp.original_origin)) {
            level.pap_ramp.original_origin = level.pap_ramp.origin;
        }
        level.pap_ramp rotateroll(45, 0.5);
        wait 1;
        level.pap_ramp rotateroll(45, 0.5);
        level.pap_ramp moveto(struct::get("pap_ramp_push1", "targetname").origin, 1);
        level.pap_ramp waittill(#"movedone");
        level.pap_ramp moveto(struct::get("pap_ramp_push2", "targetname").origin, 2);
        level.pap_ramp waittill(#"movedone");
        level.pap_ramp.origin = level.pap_ramp.original_origin;
        level.pap_ramp rotateroll(-90, 0.5);
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xe6adfe1c, Offset: 0x26b0
// Size: 0x17c
function function_c55e1ae3() {
    volume = getent("pap_target_finder", "targetname");
    while (true) {
        touching = 0;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i] istouching(volume) || players[i] istouching(level.var_fbf5fa31)) {
                touching = 1;
            }
        }
        if (!touching) {
            break;
        }
        wait 0.05;
    }
    player_clip = getent("pap_stairs_player_clip", "targetname");
    if (isdefined(player_clip)) {
        player_clip solid();
    }
    if (isdefined(level.var_fbf5fa31)) {
        level.var_fbf5fa31 delete();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x168eb14b, Offset: 0x2838
// Size: 0xe4
function function_fe154bfd() {
    level endon(#"fake_death");
    array::thread_all(level.var_1310959d, &function_6d09330c);
    array::thread_all(level.var_1310959d, &function_3f840cb7);
    level thread function_9d3a4338(level.var_7ec580f7);
    var_6c26bc7d = 0.5;
    wait level.var_7ec580f7 - var_6c26bc7d;
    level function_8aa0c09e();
    level thread function_5f2b4242();
    wait var_6c26bc7d;
    function_64e243ed();
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xceed6217, Offset: 0x2928
// Size: 0x1a
function function_5f2b4242() {
    wait 5.5;
    level notify(#"hash_68be96a1");
}

// Namespace zm_temple_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0xf59486b9, Offset: 0x2950
// Size: 0x34
function function_9d3a4338(var_9938b710) {
    wait var_9938b710 - 5;
    exploder::exploder("fxexp_60");
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x3cd98c0c, Offset: 0x2990
// Size: 0xb4
function function_3f840cb7() {
    var_397fe29 = 8.5;
    self playsound("evt_pap_timer_start");
    self playloopsound("evt_pap_timer_loop");
    wait level.var_7ec580f7 - var_397fe29;
    self playsound("evt_pap_timer_countdown");
    wait var_397fe29;
    self stoploopsound();
    self playsound("evt_pap_timer_stop");
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x94aced7f, Offset: 0x2a50
// Size: 0x30e
function function_64e243ed() {
    level notify(#"hash_24bc567a");
    level endon(#"fake_death");
    function_f238dbc0();
    level.var_7cebb55a = 400;
    level.var_96ba9d8b = 0;
    level.var_ffa1361 = 1;
    volume = getent("pap_target_finder", "targetname");
    level.var_fbf5fa31 = spawn("trigger_radius", (-8, 560, 288), 0, 768, 256);
    players = getplayers();
    var_dc5b5c85 = [];
    for (i = 0; i < players.size; i++) {
        touching = players[i] istouching(volume) || players[i] istouching(level.var_fbf5fa31);
        if (touching) {
            var_dc5b5c85[var_dc5b5c85.size] = players[i];
            players[i] thread function_f084c06a(volume);
        }
    }
    var_882ca56b = getent("pap_target_finder2", "targetname");
    var_39c0a711 = [];
    zombies = getaispeciesarray("axis", "all");
    for (i = 0; i < zombies.size; i++) {
        if (zombies[i] istouching(volume) || zombies[i] istouching(var_882ca56b)) {
            var_39c0a711[var_39c0a711.size] = zombies[i];
        }
    }
    if (var_39c0a711.size > 0) {
        level thread function_c20e97e0(var_39c0a711);
    }
    level notify(#"hash_d4e1b9c");
    while (level.var_96ba9d8b > 0) {
        util::wait_network_frame();
    }
    level notify(#"hash_f6b6a2ca");
}

// Namespace zm_temple_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0x612b2908, Offset: 0x2d68
// Size: 0x100
function function_f084c06a(volume) {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"hash_68be96a1");
    var_e8cb2080 = (0, 408, 304);
    max_dist = 400;
    time = 1.5;
    dist = distance(self.origin, var_e8cb2080);
    var_eb1c7620 = dist / max_dist;
    time *= var_eb1c7620;
    wait time;
    while (true) {
        if (!self istouching(volume)) {
            break;
        }
        util::wait_network_frame();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x1e20c649, Offset: 0x2e70
// Size: 0x64
function function_f238dbc0() {
    var_af8bc0ae = struct::get("pap_water", "targetname");
    if (isdefined(var_af8bc0ae)) {
        level thread sound::play_in_space("evt_pap_water", var_af8bc0ae.origin);
    }
}

// Namespace zm_temple_pack_a_punch
// Params 2, eflags: 0x0
// Checksum 0xf9695ad4, Offset: 0x2ee0
// Size: 0x92
function function_aa8c37e7(p1, p2) {
    dist1 = distancesquared(p1.origin, level.var_c6c0d2d9.origin);
    dist2 = distancesquared(p2.origin, level.var_c6c0d2d9.origin);
    return dist1 > dist2;
}

// Namespace zm_temple_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0x5aa7e5c7, Offset: 0x2f80
// Size: 0x4b4
function function_5ad6dea0(index) {
    self enableinvulnerability();
    self allowprone(0);
    self allowcrouch(0);
    self playrumblelooponentity("tank_rumble");
    self thread function_c838c205(3);
    mover = spawn("script_origin", self.origin);
    self playerlinkto(mover);
    pc = level.pap_playerclip[index];
    pc.origin = self.origin;
    pc linkto(self);
    level.var_96ba9d8b++;
    self.var_87dbf206 = 1;
    var_c64eda0e = 1;
    var_7cebb55a = level.var_7cebb55a - 30 * index;
    wait index * 0.1;
    for (nexttarget = self function_c6a563a(); isdefined(nexttarget); nexttarget = nexttarget.next) {
        movetarget = (self.origin[0], nexttarget.origin[1], nexttarget.origin[2]);
        if (!isdefined(nexttarget.next)) {
            movetarget = (movetarget[0], self.origin[1] + (movetarget[1] - self.origin[1]) * level.var_ffa1361, movetarget[2]);
            level.var_ffa1361 -= 0.25;
            if (level.var_ffa1361 <= 0) {
                level.var_ffa1361 = 0.1;
            }
        }
        dist = abs(nexttarget.origin[1] - self.origin[1]);
        time = dist / var_7cebb55a;
        accel = 0;
        decel = 0;
        if (var_c64eda0e) {
            var_c64eda0e = 0;
            accel = min(0.2, time);
        }
        if (!isdefined(nexttarget.target)) {
            accel = 0;
            decel = time;
            time += 0.5;
        }
        mover moveto(movetarget, time, accel, decel);
        waittime = max(time, 0);
        wait waittime;
    }
    mover delete();
    self stoprumble("tank_rumble");
    self notify(#"hash_90e7aca6");
    pc unlink();
    pc.origin = pc.var_b81038e3;
    self allowprone(1);
    self allowcrouch(1);
    self.var_87dbf206 = 0;
    self disableinvulnerability();
    level.var_96ba9d8b--;
}

// Namespace zm_temple_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0xf5d1b2ed, Offset: 0x3440
// Size: 0xa0
function function_c838c205(activetime) {
    self endon(#"hash_90e7aca6");
    while (true) {
        earthquake(randomfloatrange(0.2, 0.4), randomfloatrange(1, 2), self.origin, 100, self);
        wait randomfloatrange(0.1, 0.3);
    }
}

// Namespace zm_temple_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0x61286185, Offset: 0x34e8
// Size: 0x86
function function_c20e97e0(var_39c0a711) {
    for (i = 0; i < var_39c0a711.size; i++) {
        if (isdefined(var_39c0a711[i]) && isalive(var_39c0a711[i])) {
            var_39c0a711[i] thread function_f844e501();
        }
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xe517c5c4, Offset: 0x3578
// Size: 0x1bc
function function_f844e501() {
    self endon(#"death");
    var_e8cb2080 = (0, 408, 304);
    max_dist = 400;
    time = 1.5;
    dist = distance(self.origin, var_e8cb2080);
    var_eb1c7620 = dist / max_dist;
    time *= var_eb1c7620;
    wait time;
    self startragdoll();
    nexttarget = self function_c6a563a();
    launchdir = nexttarget.origin - self.origin;
    launchdir = (0, launchdir[1], launchdir[2]);
    launchdir = vectornormalize(launchdir);
    self launchragdoll(launchdir * 50);
    util::wait_network_frame();
    self.no_gib = 1;
    level.zombie_total++;
    self dodamage(self.health + 666, self.origin);
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xe8ff3350, Offset: 0x3740
// Size: 0x64
function function_c6a563a() {
    for (current_node = level.var_c6c0d2d9; true; current_node = current_node.next) {
        if (self.origin[1] >= current_node.origin[1]) {
            break;
        }
    }
    return current_node;
}

// Namespace zm_temple_pack_a_punch
// Params 2, eflags: 0x0
// Checksum 0x72717874, Offset: 0x37b0
// Size: 0x4c
function function_4fb3fde4(num, state) {
    level.var_ede10a11 = num;
    level.var_5186807e = state;
    clientfield::set("papspinners", state);
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x9e96b542, Offset: 0x3808
// Size: 0x2d8
function function_caea2097() {
    level.var_1310959d = getentarray("pap_timer", "targetname");
    for (i = 0; i < level.var_1310959d.size; i++) {
        timer = level.var_1310959d[i];
        timer.path = [];
        for (targetname = timer.target; isdefined(targetname); targetname = s.target) {
            s = struct::get(targetname, "targetname");
            if (!isdefined(s)) {
                break;
            }
            timer.path[timer.path.size] = s;
        }
        timer.origin = timer.path[0].origin;
        pathlength = 0;
        for (p = 1; p < timer.path.size; p++) {
            length = distance(timer.path[p - 1].origin, timer.path[p].origin);
            timer.path[p].pathlength = length;
            pathlength += length;
        }
        timer.pathlength = pathlength;
        for (p = timer.path.size - 2; p >= 0; p--) {
            length = distance(timer.path[p + 1].origin, timer.path[p].origin);
            timer.path[p].var_998beae6 = length;
        }
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x2946edf8, Offset: 0x3ae8
// Size: 0xbc
function function_6d09330c() {
    var_1b49bf75 = self.angles[1] != 0;
    speed = self.pathlength / level.var_7ec580f7;
    self function_b998b47e(speed, var_1b49bf75);
    returntime = 4;
    speed = self.pathlength / returntime;
    self function_2375ce01(speed, var_1b49bf75);
    self.origin = self.path[0].origin;
}

// Namespace zm_temple_pack_a_punch
// Params 2, eflags: 0x0
// Checksum 0xce2a2992, Offset: 0x3bb0
// Size: 0x17a
function function_b998b47e(speed, var_1b49bf75) {
    for (i = 1; i < self.path.size; i++) {
        length = self.path[i].pathlength;
        time = length / speed;
        acceltime = 0;
        deceltime = 0;
        if (i == 1) {
            acceltime = 0.2;
        } else if (i == self.path.size - 1) {
            deceltime = 0.2;
        }
        self moveto(self.path[i].origin, time, acceltime, deceltime);
        var_dcdcba75 = speed * -4;
        if (var_1b49bf75) {
            var_dcdcba75 *= -1;
        }
        self rotatevelocity((0, 0, var_dcdcba75), time);
        self waittill(#"movedone");
    }
}

// Namespace zm_temple_pack_a_punch
// Params 2, eflags: 0x0
// Checksum 0x3a675b4, Offset: 0x3d38
// Size: 0x1b6
function function_2375ce01(speed, var_1b49bf75) {
    for (i = self.path.size - 2; i >= 0; i--) {
        length = self.path[i].var_998beae6;
        time = length / speed;
        acceltime = 0;
        deceltime = 0;
        if (i == self.path.size - 2) {
            acceltime = 0.2;
        } else if (i == 0) {
            deceltime = 0.5;
        }
        self moveto(self.path[i].origin, time, acceltime, deceltime);
        var_dcdcba75 = speed * 4;
        if (var_1b49bf75) {
            var_dcdcba75 *= -1;
        }
        self rotatevelocity((0, 0, var_dcdcba75), time);
        self waittill(#"movedone");
        self playsound("evt_pap_timer_stop");
        self playsound("evt_pap_timer_start");
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x799f76f2, Offset: 0x3ef8
// Size: 0xb2
function function_f34f1d1() {
    level.var_c6c0d2d9 = struct::get("pap_flush_path", "targetname");
    for (current_node = level.var_c6c0d2d9; true; current_node = next_node) {
        if (!isdefined(current_node.target)) {
            break;
        }
        next_node = struct::get(current_node.target, "targetname");
        current_node.next = next_node;
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x3fb8
// Size: 0x4
function function_d72e5036() {
    
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x8124e1c7, Offset: 0x3fc8
// Size: 0x1c
function function_8aa0c09e() {
    exploder::exploder("fxexp_61");
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x6d52a295, Offset: 0x3ff0
// Size: 0x1c
function function_5b2895bc() {
    exploder::stop_exploder("fxexp_61");
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x580c02a3, Offset: 0x4018
// Size: 0x4c
function function_5e3bbe0e() {
    self solid();
    self disconnectpaths();
    self notsolid();
}

// Namespace zm_temple_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xd5a62504, Offset: 0x4070
// Size: 0x4c
function function_ce7aeb18() {
    self solid();
    self connectpaths();
    self notsolid();
}

