#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_magicbox;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;

#namespace tomb_magicbox;

// Namespace tomb_magicbox
// Params 0, eflags: 0x2
// Checksum 0xc6da96e3, Offset: 0x248
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("tomb_magicbox", &__init__, undefined, undefined);
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xaefcf4f1, Offset: 0x288
// Size: 0x1a4
function __init__() {
    clientfield::register("zbarrier", "magicbox_initial_fx", 21000, 1, "int");
    clientfield::register("zbarrier", "magicbox_amb_fx", 21000, 2, "int");
    clientfield::register("zbarrier", "magicbox_open_fx", 21000, 1, "int");
    clientfield::register("zbarrier", "magicbox_leaving_fx", 21000, 1, "int");
    level.chest_joker_custom_movement = &custom_joker_movement;
    level.custom_magic_box_timer_til_despawn = &custom_magic_box_timer_til_despawn;
    level.custom_magic_box_do_weapon_rise = &custom_magic_box_do_weapon_rise;
    level.var_c6955e8b = &function_c6955e8b;
    level.custom_magicbox_float_height = 50;
    level.var_1bda053 = &function_61903aae;
    level.custom_treasure_chest_glowfx = &function_e4e60ea;
    level.magic_box_zbarrier_state_func = &set_magic_box_zbarrier_state;
    level thread function_40fd7924();
    level thread function_178f38e8();
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x438
// Size: 0x4
function function_61903aae() {
    
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x448
// Size: 0x4
function function_e4e60ea() {
    
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xc3ebab52, Offset: 0x458
// Size: 0x1de
function custom_joker_movement() {
    v_origin = self.weapon_model.origin - (0, 0, 5);
    self.weapon_model delete();
    var_2dfb577c = util::spawn_model(level.chest_joker_model, v_origin, self.angles);
    var_2dfb577c playsound("zmb_hellbox_bear");
    wait 0.5;
    level notify(#"weapon_fly_away_start");
    wait 1;
    var_2dfb577c rotateyaw(3000, 4, 4);
    wait 3;
    v_angles = anglestoforward(self.angles - (0, 90, 0));
    var_2dfb577c moveto(var_2dfb577c.origin + 20 * v_angles, 0.5, 0.5);
    var_2dfb577c waittill(#"movedone");
    var_2dfb577c moveto(var_2dfb577c.origin + -100 * v_angles, 0.5, 0.5);
    var_2dfb577c waittill(#"movedone");
    var_2dfb577c delete();
    self notify(#"box_moving");
    level notify(#"weapon_fly_away_end");
}

// Namespace tomb_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x64ba8f14, Offset: 0x640
// Size: 0xcc
function custom_magic_box_timer_til_despawn(magic_box) {
    self endon(#"kill_weapon_movement");
    putbacktime = 12;
    v_float = anglestoforward(magic_box.angles - (0, 90, 0)) * 40;
    self moveto(self.origin - v_float * 0.25, putbacktime, putbacktime * 0.5);
    wait putbacktime;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x5f337fce, Offset: 0x718
// Size: 0xc
function function_c6955e8b() {
    wait 0.5;
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xff0846be, Offset: 0x730
// Size: 0xea
function function_40fd7924() {
    while (!isdefined(level.chests)) {
        wait 0.5;
    }
    while (!isdefined(level.chests[level.chests.size - 1].zbarrier)) {
        wait 0.5;
    }
    foreach (chest in level.chests) {
        chest.zbarrier clientfield::set("magicbox_initial_fx", 1);
    }
}

// Namespace tomb_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x8deb4968, Offset: 0x828
// Size: 0x2be
function set_magic_box_zbarrier_state(state) {
    for (i = 0; i < self getnumzbarrierpieces(); i++) {
        self hidezbarrierpiece(i);
    }
    self notify(#"zbarrier_state_change");
    switch (state) {
    case "away":
        self showzbarrierpiece(0);
        self.state = "away";
        self.owner.is_locked = 0;
        break;
    case "arriving":
        self showzbarrierpiece(1);
        self thread function_4831fb0d();
        self.state = "arriving";
        break;
    case "initial":
        self showzbarrierpiece(1);
        self thread function_fea04511();
        thread zm_unitrigger::register_static_unitrigger(self.owner.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
        self.state = "close";
        break;
    case "open":
        self showzbarrierpiece(2);
        self thread function_63e09f12();
        self.state = "open";
        break;
    case "close":
        self showzbarrierpiece(2);
        self thread function_fe30a0c8();
        self.state = "close";
        break;
    case "leaving":
        self showzbarrierpiece(1);
        self thread function_fd5f77b3();
        self.state = "leaving";
        self.owner.is_locked = 0;
        break;
    default:
        if (isdefined(level.custom_magicbox_state_handler)) {
            self [[ level.custom_magicbox_state_handler ]](state);
        }
        break;
    }
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x7e4f1856, Offset: 0xaf0
// Size: 0x4c
function function_fea04511() {
    self setzbarrierpiecestate(1, "open");
    wait 1;
    self clientfield::set("magicbox_amb_fx", 1);
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x3f37cb33, Offset: 0xb48
// Size: 0x12c
function function_4831fb0d() {
    self clientfield::set("magicbox_leaving_fx", 0);
    self setzbarrierpiecestate(1, "opening");
    while (self getzbarrierpiecestate(1) == "opening") {
        wait 0.05;
    }
    self notify(#"arrived");
    self.state = "close";
    var_117caa1a = level.zone_capture.zones[self.var_bb399418];
    if (isdefined(var_117caa1a)) {
        if (!var_117caa1a flag::get("player_controlled")) {
            self clientfield::set("magicbox_amb_fx", 1);
            return;
        }
        self clientfield::set("magicbox_amb_fx", 2);
    }
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x64f0eda5, Offset: 0xc80
// Size: 0x188
function function_fd5f77b3() {
    self notify(#"hash_9244a021");
    self clientfield::set("magicbox_leaving_fx", 1);
    self clientfield::set("magicbox_open_fx", 0);
    self setzbarrierpiecestate(1, "closing");
    self playsound("zmb_hellbox_rise");
    while (self getzbarrierpiecestate(1) == "closing") {
        wait 0.1;
    }
    self notify(#"left");
    var_117caa1a = level.zone_capture.zones[self.var_bb399418];
    if (isdefined(var_117caa1a)) {
        if (var_117caa1a flag::get("player_controlled")) {
            self clientfield::set("magicbox_amb_fx", 3);
        } else {
            self clientfield::set("magicbox_amb_fx", 0);
        }
    }
    if (isdefined(level.var_99a26965) && !level.var_99a26965) {
        level.var_99a26965 = 1;
    }
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xf61d9dc9, Offset: 0xe10
// Size: 0xb4
function function_63e09f12() {
    self clientfield::set("magicbox_open_fx", 1);
    self setzbarrierpiecestate(2, "opening");
    self playsound("zmb_hellbox_open");
    while (self getzbarrierpiecestate(2) == "opening") {
        wait 0.1;
    }
    self notify(#"opened");
    self thread function_e0c48214();
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x4fa48284, Offset: 0xed0
// Size: 0x98
function function_e0c48214() {
    self endon(#"hash_9244a021");
    self hidezbarrierpiece(2);
    self showzbarrierpiece(5);
    while (true) {
        self setzbarrierpiecestate(5, "opening");
        while (self getzbarrierpiecestate(5) != "open") {
            wait 0.05;
        }
    }
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x4e92e672, Offset: 0xf70
// Size: 0xe2
function function_fe30a0c8() {
    self notify(#"hash_9244a021");
    self hidezbarrierpiece(5);
    self showzbarrierpiece(2);
    self setzbarrierpiecestate(2, "closing");
    self playsound("zmb_hellbox_close");
    self clientfield::set("magicbox_open_fx", 0);
    while (self getzbarrierpiecestate(2) == "closing") {
        wait 0.1;
    }
    self notify(#"closed");
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xdd61bd07, Offset: 0x1060
// Size: 0x16c
function custom_magic_box_do_weapon_rise() {
    self endon(#"box_hacked_respin");
    wait 0.5;
    self setzbarrierpiecestate(3, "closed");
    self setzbarrierpiecestate(4, "closed");
    util::wait_network_frame();
    self zbarrierpieceuseboxriselogic(3);
    self zbarrierpieceuseboxriselogic(4);
    self showzbarrierpiece(3);
    self showzbarrierpiece(4);
    self setzbarrierpiecestate(3, "opening");
    self setzbarrierpiecestate(4, "opening");
    while (self getzbarrierpiecestate(3) != "open") {
        wait 0.5;
    }
    self hidezbarrierpiece(3);
    self hidezbarrierpiece(4);
}

// Namespace tomb_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0xfbf850b3, Offset: 0x11d8
// Size: 0x15a
function function_178f38e8() {
    while (true) {
        level waittill(#"fire_sale_off");
        for (i = 0; i < level.chests.size; i++) {
            if (level.chest_index != i && isdefined(level.chests[i].was_temp)) {
                if (isdefined(level.chests[i].zbarrier.var_bb399418) && level.zone_capture.zones[level.chests[i].zbarrier.var_bb399418] flag::get("player_controlled")) {
                    level.chests[i].zbarrier clientfield::set("magicbox_amb_fx", 3);
                    continue;
                }
                level.chests[i].zbarrier clientfield::set("magicbox_amb_fx", 0);
            }
        }
    }
}

