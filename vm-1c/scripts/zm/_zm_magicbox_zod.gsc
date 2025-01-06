#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;

#namespace namespace_cfbe948b;

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0xaab992c7, Offset: 0x388
// Size: 0x1e4
function init() {
    registerclientfield("zbarrier", "magicbox_initial_fx", 1, 1, "int");
    registerclientfield("zbarrier", "magicbox_amb_sound", 1, 1, "int");
    registerclientfield("zbarrier", "magicbox_open_fx", 1, 2, "int");
    level._effect["box_light_marker"] = "zombie/fx_weapon_box_marker_zod_zmb";
    level._effect["box_light_flare"] = "zombie/fx_weapon_box_marker_fl_zod_zmb";
    level._effect["poltergeist"] = "tools/fx_null";
    level.chest_joker_model = "p7_zm_zod_magic_box_tentacle_teddy";
    level.chest_joker_custom_movement = &custom_joker_movement;
    level.custom_magic_box_timer_til_despawn = &custom_magic_box_timer_til_despawn;
    level.custom_magic_box_do_weapon_rise = &custom_magic_box_do_weapon_rise;
    level.var_c6955e8b = &function_c6955e8b;
    level.custom_pandora_show_func = &custom_pandora_show_func;
    level.custom_treasure_chest_glowfx = &function_1bda053;
    level.custom_firesale_box_leave = 1;
    level.custom_magicbox_float_height = 40;
    level.magic_box_zbarrier_state_func = &set_magic_box_zbarrier_state;
    level thread function_178f38e8();
    level thread function_cb604665();
}

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x8bcaf695, Offset: 0x578
// Size: 0x21e
function custom_joker_movement() {
    v_origin = self.weapon_model.origin - (0, 0, 5);
    self.weapon_model delete();
    var_2dfb577c = spawn("script_model", v_origin);
    var_2dfb577c setmodel(level.chest_joker_model);
    var_2dfb577c.angles = self.angles + (0, 180, 0);
    var_2dfb577c playsound("zmb_hellbox_bear");
    wait 0.5;
    level notify(#"weapon_fly_away_start");
    wait 1;
    var_2dfb577c rotateyaw(3000, 4.5, 4.5);
    wait 3;
    v_angles = anglestoforward(self.angles - (90, 90, 0));
    var_2dfb577c moveto(var_2dfb577c.origin + 35 * v_angles, 1.5, 1);
    var_2dfb577c waittill(#"movedone");
    var_2dfb577c moveto(var_2dfb577c.origin + -100 * v_angles, 0.5, 0.5);
    var_2dfb577c waittill(#"movedone");
    var_2dfb577c delete();
    self notify(#"box_moving");
    level notify(#"weapon_fly_away_end");
}

// Namespace namespace_cfbe948b
// Params 1, eflags: 0x0
// Checksum 0xf04ad887, Offset: 0x7a0
// Size: 0xb4
function custom_magic_box_timer_til_despawn(magic_box) {
    self endon(#"kill_weapon_movement");
    putbacktime = 12;
    v_float = anglestoup(self.angles) * level.custom_magicbox_float_height;
    self moveto(self.origin - v_float * 0.4, putbacktime, putbacktime * 0.5);
    wait putbacktime;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x860
// Size: 0x4
function function_1bda053() {
    
}

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0xdefabcee, Offset: 0x870
// Size: 0xd4
function custom_pandora_fx_func() {
    self endon(#"death");
    self.pandora_light = util::spawn_model("tag_origin", self.zbarrier.origin, (-90, 0, -90));
    if (!(isdefined(level._box_initialized) && level._box_initialized)) {
        level flag::wait_till("start_zombie_round_logic");
        level._box_initialized = 1;
    }
    wait 1;
    if (isdefined(self.pandora_light)) {
        playfxontag(level._effect["box_light_marker"], self.pandora_light, "tag_origin");
    }
}

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x28a88f8d, Offset: 0x950
// Size: 0x7c
function custom_pandora_show_func() {
    if (!isdefined(self.pandora_light)) {
        if (!isdefined(level.pandora_fx_func)) {
            level.pandora_fx_func = &custom_pandora_fx_func;
        }
        self thread [[ level.pandora_fx_func ]]();
    }
    playfx(level._effect["box_light_flare"], self.pandora_light.origin);
}

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0xae86640a, Offset: 0x9d8
// Size: 0xc
function function_c6955e8b() {
    wait 0.5;
}

// Namespace namespace_cfbe948b
// Params 1, eflags: 0x0
// Checksum 0xdea8fc07, Offset: 0x9f0
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
        self thread zm_unitrigger::register_static_unitrigger(self.owner.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think);
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

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x8a3bd00b, Offset: 0xcb8
// Size: 0xa4
function function_fea04511() {
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("zones_initialized");
    self setzbarrierpiecestate(1, "open");
    self clientfield::set("magicbox_amb_sound", 1);
    self clientfield::set("magicbox_open_fx", 3);
}

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x54c4425f, Offset: 0xd68
// Size: 0x94
function function_4831fb0d() {
    self setzbarrierpiecestate(1, "opening");
    while (self getzbarrierpiecestate(1) == "opening") {
        wait 0.05;
    }
    self notify(#"arrived");
    self.state = "close";
    self clientfield::set("magicbox_amb_sound", 1);
}

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x9be0226, Offset: 0xe08
// Size: 0x108
function function_fd5f77b3() {
    self clientfield::set("magicbox_open_fx", 0);
    self setzbarrierpiecestate(1, "closing");
    self playsound("zmb_hellbox_rise");
    while (self getzbarrierpiecestate(1) == "closing") {
        wait 0.1;
    }
    self notify(#"left");
    self clientfield::set("magicbox_open_fx", 2);
    self clientfield::set("magicbox_amb_sound", 0);
    if (!(isdefined(level.var_99a26965) && level.var_99a26965)) {
        level.var_99a26965 = 1;
    }
}

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x8b755a64, Offset: 0xf18
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

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x12ff0c22, Offset: 0xfd8
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

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x487be1e4, Offset: 0x1078
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

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x987f720, Offset: 0x1168
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

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x9fca92f8, Offset: 0x12e0
// Size: 0x18a
function function_178f38e8() {
    while (true) {
        var_7c8b59c1 = level util::waittill_any_return("fire_sale_off", "fire_sale_on");
        for (i = 0; i < level.chests.size; i++) {
            if (level.chest_index != i && isdefined(level.chests[i].was_temp)) {
                if (var_7c8b59c1 == "fire_sale_on") {
                    level.chests[i].zbarrier clientfield::set("magicbox_amb_sound", 1);
                    level.chests[i].zbarrier clientfield::set("magicbox_open_fx", 3);
                    continue;
                }
                level.chests[i].zbarrier clientfield::set("magicbox_amb_sound", 0);
                level.chests[i].zbarrier clientfield::set("magicbox_open_fx", 2);
            }
        }
    }
}

// Namespace namespace_cfbe948b
// Params 0, eflags: 0x0
// Checksum 0x925f6a23, Offset: 0x1478
// Size: 0x14e
function function_cb604665() {
    level endon(#"end_game");
    level notify(#"mb_hostmigration");
    level endon(#"mb_hostmigration");
    while (true) {
        level waittill(#"host_migration_end");
        if (!isdefined(level.chests)) {
            continue;
        }
        foreach (chest in level.chests) {
            if (!(isdefined(chest.hidden) && chest.hidden)) {
                if (isdefined(chest) && isdefined(chest.pandora_light)) {
                    playfxontag(level._effect["box_light_marker"], chest.pandora_light, "tag_origin");
                }
            }
            util::wait_network_frame();
        }
    }
}

