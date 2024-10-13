#using scripts/zm/zm_cosmodrome_eggs;
#using scripts/zm/zm_cosmodrome_amb;
#using scripts/zm/zm_cosmodrome;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_cosmodrome_eggs;

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x7e63e63f, Offset: 0xa30
// Size: 0x4bc
function init() {
    level flag::init("target_teleported");
    level flag::init("rerouted_power");
    level flag::init("switches_synced");
    level flag::init("pressure_sustained");
    level flag::init("passkey_confirmed");
    level flag::init("weapons_combined");
    level.var_1999d459 = [];
    level.var_46651379["a"] = getent("letter_a", "targetname");
    level.var_46651379["e"] = getent("letter_e", "targetname");
    level.var_46651379["h"] = getent("letter_h", "targetname");
    level.var_46651379["i"] = getent("letter_i", "targetname");
    level.var_46651379["l"] = getent("letter_l", "targetname");
    level.var_46651379["m"] = getent("letter_m", "targetname");
    level.var_46651379["n"] = getent("letter_n", "targetname");
    level.var_46651379["r"] = getent("letter_r", "targetname");
    level.var_46651379["s"] = getent("letter_s", "targetname");
    level.var_46651379["t"] = getent("letter_t", "targetname");
    level.var_46651379["u"] = getent("letter_u", "targetname");
    level.var_46651379["y"] = getent("letter_y", "targetname");
    keys = getarraykeys(level.var_46651379);
    for (i = 0; i < keys.size; i++) {
        level.var_46651379[keys[i]] ghost();
    }
    monitor = getent("casimir_monitor", "targetname");
    monitor setmodel("p7_zm_asc_monitor_screen_off");
    function_2f116aad();
    function_6b4d4b8a();
    function_55c69e42();
    function_38cded10();
    function_18c28e7b();
    function_6f6480bb();
    level notify(#"hash_e09c6a09");
    monitor = getent("casimir_monitor", "targetname");
    monitor setmodel("p7_zm_asc_monitor_screen_off");
    monitor stoploopsound(0.1);
    monitor playsound("zmb_ee_monitor_off");
}

// Namespace zm_cosmodrome_eggs
// Params 3, eflags: 0x0
// Checksum 0xda9bc137, Offset: 0xef8
// Size: 0x72
function function_bf374409(alias, sound_ent, text) {
    if (alias == undefined) {
        /#
            iprintlnbold(text);
        #/
        return;
    }
    sound_ent playsoundwithnotify(alias, "sounddone");
    sound_ent waittill(#"sounddone");
}

// Namespace zm_cosmodrome_eggs
// Params 1, eflags: 0x1 linked
// Checksum 0x76077cd9, Offset: 0xf78
// Size: 0x10e
function function_55403b86(num) {
    spot = struct::get("casimir_light_" + num, "targetname");
    if (isdefined(spot)) {
        light = spawn("script_model", spot.origin);
        light setmodel("tag_origin");
        light.angles = spot.angles;
        fx = playfxontag(level._effect["fx_light_ee_progress"], light, "tag_origin");
        level.var_1999d459[level.var_1999d459.size] = light;
    }
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x20c0495, Offset: 0x1090
// Size: 0x2ac
function function_2f116aad() {
    teleport_target_start = struct::get("teleport_target_start", "targetname");
    teleport_target_spark = struct::get("teleport_target_spark", "targetname");
    var_1dc1d30a = teleport_target_spark.angles;
    level.var_50560fe8 = spawn("script_model", teleport_target_start.origin);
    level.var_50560fe8 setmodel("p7_zm_asc_transformer_electrical");
    level.var_50560fe8.angles = teleport_target_start.angles;
    teleport_target_spark = spawn("script_model", teleport_target_spark.origin);
    teleport_target_spark setmodel("tag_origin");
    teleport_target_spark.angles = var_1dc1d30a;
    playfxontag(level._effect["generator_ee_sparks"], teleport_target_spark, "tag_origin");
    level.var_9c483a19 = spawn("trigger_radius", teleport_target_start.origin + (0, 0, -70), 0, 125, 100);
    /#
        if (!isdefined(level.var_74eed1d3) || !level.var_74eed1d3) {
            level.var_50560fe8 thread zm_cosmodrome::function_620401c0(level.var_50560fe8.origin, "<dev string:x28>", "<dev string:x3d>", 2);
        }
    #/
    level.var_5fc80ad9 = &function_1e3d1509;
    level waittill(#"hash_2a49912");
    teleport_target_spark delete();
    level flag::wait_till("target_teleported");
    level.var_5fc80ad9 = undefined;
    level thread function_321f0d6f("vox_ann_egg1_success", "vox_gersh_egg1", 1);
}

// Namespace zm_cosmodrome_eggs
// Params 3, eflags: 0x1 linked
// Checksum 0x348c9816, Offset: 0x1348
// Size: 0x8c
function function_1e3d1509(grenade, model, info) {
    if (isdefined(level.var_9c483a19) && grenade istouching(level.var_9c483a19)) {
        model clientfield::set("toggle_black_hole_deployed", 1);
        level thread function_50560fe8(grenade, model);
        return true;
    }
    return false;
}

// Namespace zm_cosmodrome_eggs
// Params 2, eflags: 0x1 linked
// Checksum 0xaead40ea, Offset: 0x13e0
// Size: 0x244
function function_50560fe8(grenade, model) {
    level.var_9c483a19 delete();
    level.var_9c483a19 = undefined;
    wait 1;
    level notify(#"hash_2a49912");
    time = 3;
    level.var_50560fe8 moveto(grenade.origin + (0, 0, 50), time, time - 0.05);
    wait time;
    teleport_target_end = struct::get("teleport_target_end", "targetname");
    level.var_50560fe8 ghost();
    playsoundatposition("zmb_gersh_teleporter_out", grenade.origin + (0, 0, 50));
    wait 0.5;
    level.var_50560fe8.angles = teleport_target_end.angles;
    level.var_50560fe8 moveto(teleport_target_end.origin, 0.05);
    wait 0.5;
    level.var_50560fe8 show();
    playfxontag(level._effect["black_hole_bomb_event_horizon"], level.var_50560fe8, "tag_origin");
    level.var_50560fe8 playsound("zmb_gersh_teleporter_go");
    wait 2;
    model delete();
    level flag::set("target_teleported");
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x89c2963c, Offset: 0x1630
// Size: 0x21c
function function_6b4d4b8a() {
    monitor = getent("casimir_monitor", "targetname");
    location = struct::get("casimir_monitor_struct", "targetname");
    monitor playsound("zmb_ee_monitor_on");
    monitor playloopsound("zmb_ee_monitor_whitenoise", 1);
    monitor setmodel("p7_zm_asc_monitor_screen_on");
    trig = spawn("trigger_radius", location.origin, 0, 32, 60);
    /#
        if (!isdefined(level.var_4058a336) || !level.var_4058a336) {
            trig thread zm_cosmodrome::function_620401c0(monitor.origin, "<dev string:x46>", "<dev string:x55>");
        }
    #/
    trig function_78f34b16(monitor);
    trig delete();
    level flag::set("rerouted_power");
    monitor setmodel("p7_zm_asc_monitor_screen_logo");
    monitor playloopsound("zmb_ee_monitor_active", 1);
    level thread function_321f0d6f("vox_ann_egg2_success", "vox_gersh_egg2", 2);
    level thread function_55403b86(1);
}

// Namespace zm_cosmodrome_eggs
// Params 1, eflags: 0x1 linked
// Checksum 0x12a32001, Offset: 0x1858
// Size: 0xe0
function function_78f34b16(monitor) {
    /#
        if (isdefined(level.var_4058a336) && level.var_4058a336) {
            return;
        }
    #/
    while (true) {
        who = self waittill(#"trigger");
        while (isplayer(who) && who istouching(self)) {
            if (who usebuttonpressed()) {
                level flag::set("rerouted_power");
                monitor playsound("zmb_ee_monitor_button");
                return;
            }
            wait 0.05;
        }
    }
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x1d34ef7c, Offset: 0x1940
// Size: 0x8c
function function_55c69e42() {
    switches = struct::get_array("sync_switch_start", "targetname");
    self function_27c6e567(switches);
    level thread function_321f0d6f("vox_ann_egg3_success", "vox_gersh_egg3", 3);
    level thread function_55403b86(2);
}

// Namespace zm_cosmodrome_eggs
// Params 1, eflags: 0x1 linked
// Checksum 0x2be59079, Offset: 0x19d8
// Size: 0xc8
function function_27c6e567(switches) {
    /#
        if (isdefined(level.var_dc7eef87) && level.var_dc7eef87) {
            return;
        }
    #/
    while (!level flag::get("switches_synced")) {
        level flag::wait_till("monkey_round");
        array::thread_all(switches, &function_2fee275);
        self thread function_c1215448();
        level util::waittill_either("between_round_over", "switches_synced");
    }
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x32c79b62, Offset: 0x1aa8
// Size: 0x26c
function function_2fee275() {
    button = spawn("script_model", self.origin);
    button setmodel("p7_zm_asc_switch_electric_05");
    button.angles = self.angles + (0, 90, 0);
    offset = anglestoforward(self.angles) * 8;
    time = 1;
    button moveto(button.origin + offset, 1);
    wait 1;
    if (level flag::get("monkey_round")) {
        trig = spawn("trigger_radius", button.origin, 0, 32, 72);
        /#
            if (!isdefined(level.var_dc7eef87) || !level.var_dc7eef87) {
                trig thread zm_cosmodrome::function_620401c0(button.origin, "<dev string:x5d>", "<dev string:x6d>");
            }
        #/
        trig thread function_91a40788(self, button);
        level util::waittill_either("between_round_over", "switches_synced");
        /#
            if (!isdefined(level.var_dc7eef87) || !level.var_dc7eef87) {
                trig zm_cosmodrome::function_bb831d("<dev string:x6d>");
            }
        #/
        trig delete();
    }
    button moveto(self.origin, time);
    wait time;
    button delete();
}

// Namespace zm_cosmodrome_eggs
// Params 2, eflags: 0x1 linked
// Checksum 0xac8a09a5, Offset: 0x1d20
// Size: 0x134
function function_91a40788(ss, button) {
    level endon(#"between_round_over");
    level endon(#"switches_synced");
    ss.pressed = 0;
    while (true) {
        who = self waittill(#"trigger");
        while (isplayer(who) && who istouching(self)) {
            if (who usebuttonpressed()) {
                level notify(#"hash_7dad0c40");
                button playsound("zmb_ee_syncbutton_button");
                ss.pressed = 1;
                /#
                    iprintlnbold("<dev string:x7c>");
                #/
                while (who usebuttonpressed()) {
                    wait 0.05;
                }
            }
            wait 0.05;
        }
    }
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x1dbd00f8, Offset: 0x1e60
// Size: 0x266
function function_c1215448() {
    level endon(#"between_round_over");
    pressed = 0;
    switches = struct::get_array("sync_switch_start", "targetname");
    while (true) {
        level waittill(#"hash_7dad0c40");
        timeout = gettime() + 500;
        /#
            if (isdefined(level.var_ee92e6f7) && level.var_ee92e6f7) {
                timeout += 100000;
            }
        #/
        while (gettime() < timeout) {
            pressed = 0;
            for (i = 0; i < switches.size; i++) {
                if (isdefined(switches[i].pressed) && switches[i].pressed) {
                    pressed++;
                }
            }
            if (pressed == 4) {
                level flag::set("switches_synced");
                level notify(#"switches_synced");
                for (i = 0; i < switches.size; i++) {
                    playsoundatposition("zmb_ee_syncbutton_success", switches[i].origin);
                }
                return;
            }
            wait 0.05;
        }
        switch (pressed) {
        case 1:
        case 2:
        case 3:
            for (i = 0; i < switches.size; i++) {
                playsoundatposition("zmb_ee_syncbutton_deny", switches[i].origin);
            }
            break;
        }
        for (i = 0; i < switches.size; i++) {
            switches[i].pressed = 0;
        }
    }
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x9326816a, Offset: 0x20d0
// Size: 0x11c
function function_38cded10() {
    area = struct::get("pressure_pad", "targetname");
    trig = spawn("trigger_radius", area.origin, 0, 300, 100);
    n_timer = 120;
    /#
        if (isdefined(level.var_4a2af85f) && level.var_4a2af85f) {
            n_timer = 30;
        }
    #/
    trig function_40a71984(n_timer);
    trig delete();
    level thread function_321f0d6f("vox_ann_egg4_success", "vox_gersh_egg4", 4);
    level thread function_55403b86(3);
}

// Namespace zm_cosmodrome_eggs
// Params 1, eflags: 0x1 linked
// Checksum 0x89f6bb6d, Offset: 0x21f8
// Size: 0x5ea
function function_40a71984(time) {
    var_18687de = struct::get("pressure_timer", "targetname");
    clock = spawn("script_model", var_18687de.origin);
    clock setmodel("p7_zm_tra_wall_clock");
    clock.angles = var_18687de.angles;
    var_b07ae42e = struct::get("clock_timer_hand", "targetname");
    var_4e945c7c = (0, 90, 0);
    var_43e449d4 = util::spawn_model("p7_zm_kin_clock_second_hand", var_b07ae42e.origin, var_4e945c7c);
    /#
        if (!isdefined(level.var_c28796c3) || !level.var_c28796c3) {
            self thread zm_cosmodrome::function_620401c0(self.origin, "<dev string:x8b>", "<dev string:x93>");
        } else if (isdefined(level.var_c28796c3) && level.var_c28796c3) {
            self thread function_1129ebfe();
        }
    #/
    step = 1;
    while (!level flag::get("pressure_sustained")) {
        self waittill(#"trigger");
        stop_timer = 0;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (!players[i] istouching(self)) {
                wait step;
                stop_timer = 1;
                /#
                    if (isdefined(level.var_c28796c3) && level.var_c28796c3) {
                        stop_timer = 0;
                    }
                #/
            }
        }
        if (stop_timer) {
            continue;
        }
        self playsound("zmb_ee_pressure_plate_down");
        time_remaining = time;
        var_43e449d4 rotatepitch(-360, time);
        /#
            if (isdefined(level.var_c28796c3) && level.var_c28796c3) {
                time_remaining = 0;
            }
        #/
        while (time_remaining) {
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                if (!players[i] istouching(self)) {
                    wait step;
                    time_remaining = time;
                    stop_timer = 1;
                    self playsound("zmb_ee_pressure_plate_up");
                    var_43e449d4 rotateto(var_4e945c7c, 0.5);
                    var_43e449d4 playsound("zmb_ee_pressure_deny");
                    wait 0.5;
                    break;
                }
            }
            if (stop_timer) {
                break;
            }
            wait step;
            time_remaining -= step;
            var_43e449d4 playsound("zmb_ee_pressure_timer");
        }
        if (time_remaining <= 0) {
            level flag::set("pressure_sustained");
            players = getplayers();
            var_99867264 = undefined;
            if (isdefined(players[0].fx)) {
                var_99867264 = players[0].fx;
            }
            var_43e449d4 playsound("zmb_perks_packa_ready");
            players[0].fx = level.zombie_powerups["nuke"].fx;
            level thread zm_powerup_nuke::nuke_powerup(players[0], players[0].team);
            clock stoploopsound(1);
            wait 1;
            if (isdefined(var_99867264)) {
                players[0].fx = var_99867264;
            } else {
                players[0].fx = undefined;
            }
            /#
                if (!isdefined(level.var_c28796c3) || !level.var_c28796c3) {
                    self zm_cosmodrome::function_bb831d("<dev string:x93>");
                }
            #/
            clock delete();
            var_43e449d4 delete();
            return;
        }
    }
}

/#

    // Namespace zm_cosmodrome_eggs
    // Params 0, eflags: 0x1 linked
    // Checksum 0x235e7242, Offset: 0x27f0
    // Size: 0x1a
    function function_1129ebfe() {
        wait 1;
        self notify(#"trigger");
    }

#/

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x2f453967, Offset: 0x2818
// Size: 0x344
function function_18c28e7b() {
    level flag::init("letter_acquired");
    level.var_8093285f = [];
    level.var_8093285f["lander_station1"]["lander_station3"] = "s";
    level.var_8093285f["lander_station1"]["lander_station4"] = "r";
    level.var_8093285f["lander_station1"]["lander_station5"] = "e";
    level.var_8093285f["lander_station3"]["lander_station1"] = "y";
    level.var_8093285f["lander_station3"]["lander_station4"] = "a";
    level.var_8093285f["lander_station3"]["lander_station5"] = "i";
    level.var_8093285f["lander_station4"]["lander_station1"] = "m";
    level.var_8093285f["lander_station4"]["lander_station3"] = "h";
    level.var_8093285f["lander_station4"]["lander_station5"] = "u";
    level.var_8093285f["lander_station5"]["lander_station1"] = "t";
    level.var_8093285f["lander_station5"]["lander_station3"] = "n";
    level.var_8093285f["lander_station5"]["lander_station4"] = "l";
    level.var_ce30083b = array("l", "u", "n", "a");
    level.var_4a825f7 = 0;
    level.var_b505a146 = array("h", "i", "t", "s", "a", "m");
    level.var_66e412e8 = 0;
    level.var_8f0326dd = array("h", "y", "e", "n", "a");
    level.var_fd63aa69 = 0;
    level thread function_adcb2f80();
    level flag::wait_till("passkey_confirmed");
    level thread function_321f0d6f("vox_ann_egg5_success", "vox_gersh_egg5", 5);
    level thread function_55403b86(4);
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x64ae7abf, Offset: 0x2b68
// Size: 0x358
function function_adcb2f80() {
    lander = getent("lander", "targetname");
    /#
        if (isdefined(level.var_c0e05145) && level.var_c0e05145) {
            return;
        }
        lander thread function_33078896();
    #/
    while (!level flag::get("passkey_confirmed")) {
        level waittill(#"hash_8f27dcf0");
        if (lander.called) {
            start = lander.var_bad629ca;
            dest = lander.station;
            letter = level.var_8093285f[start][dest];
            model = level.var_46651379[letter];
            model show();
            model playsound("zmb_spawn_powerup");
            model thread function_ac792024();
            model playloopsound("zmb_spawn_powerup_loop", 0.5);
            trig = spawn("trigger_radius", model.origin, 0, -56, -106);
            /#
                trig function_362373ab(model);
            #/
            trig thread function_172345ea(letter, model);
            level flag::wait_till("lander_grounded");
            if (!level flag::get("letter_acquired")) {
                function_874d06b6();
                /#
                    lander thread function_33078896();
                    trig thread zm_cosmodrome::function_bb831d("<dev string:xa1>");
                #/
            } else {
                level flag::clear("letter_acquired");
            }
            trig delete();
            model ghost();
            model stoploopsound(0.5);
            continue;
        }
        function_874d06b6();
        /#
            lander thread function_33078896();
            trig thread zm_cosmodrome::function_bb831d("<dev string:xa1>");
        #/
    }
}

/#

    // Namespace zm_cosmodrome_eggs
    // Params 1, eflags: 0x1 linked
    // Checksum 0x45ae0f1e, Offset: 0x2ec8
    // Size: 0x144
    function function_362373ab(model) {
        if (level flag::get("<dev string:xaf>")) {
            v_player_angles = getplayers()[0] getplayerangles();
            v_player_origin = getplayers()[0] getorigin();
            var_ab7c1d7f = v_player_origin + anglestoforward(v_player_angles) * -128;
            model.origin = level.var_40705128.origin + (0, 0, 32);
            self.origin = model.origin;
        }
        self thread zm_cosmodrome::function_620401c0(model.origin, "<dev string:xb9>", "<dev string:xa1>", 3);
    }

#/

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x47496ed, Offset: 0x3018
// Size: 0x38
function function_874d06b6() {
    /#
        level notify(#"hash_eeefde1f");
    #/
    level.var_4a825f7 = 0;
    level.var_66e412e8 = 0;
    level.var_fd63aa69 = 0;
}

/#

    // Namespace zm_cosmodrome_eggs
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbe135435, Offset: 0x3058
    // Size: 0x126
    function function_33078896() {
        if (!isdefined(level.var_c0e05145) || !level.var_c0e05145) {
            level endon(#"hash_eeefde1f");
            var_1fc8b439 = array("<dev string:xc6>", "<dev string:xd6>", "<dev string:xc6>", "<dev string:xe6>", "<dev string:xd6>");
            for (i = 0; i < var_1fc8b439.size; i++) {
                level.var_40705128 = struct::get(var_1fc8b439[i], "<dev string:xf6>");
                level.var_40705128 thread zm_cosmodrome::function_620401c0(level.var_40705128.origin, "<dev string:x101>", "<dev string:x10d>", 3);
                self function_e07806c9(level.var_40705128);
            }
        }
    }

    // Namespace zm_cosmodrome_eggs
    // Params 1, eflags: 0x1 linked
    // Checksum 0x272545f8, Offset: 0x3188
    // Size: 0x54
    function function_e07806c9(var_43240065) {
        while (self.station != var_43240065.targetname) {
            wait 0.25;
        }
        var_43240065 notify(#"hash_9465652d");
        util::wait_network_frame();
    }

#/

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0xfa0519e2, Offset: 0x31e8
// Size: 0x46
function function_ac792024() {
    level endon(#"lander_grounded");
    level endon(#"letter_acquired");
    while (true) {
        self rotateyaw(90, 5);
        wait 5;
    }
}

// Namespace zm_cosmodrome_eggs
// Params 2, eflags: 0x1 linked
// Checksum 0xf16bdc23, Offset: 0x3238
// Size: 0x1ec
function function_172345ea(letter, model) {
    level endon(#"lander_grounded");
    e_player = self waittill(#"trigger");
    level flag::set("letter_acquired");
    playsoundatposition("zmb_powerup_grabbed", model.origin);
    model ghost();
    /#
        self zm_cosmodrome::function_bb831d("<dev string:xa1>");
    #/
    if (letter == level.var_ce30083b[level.var_4a825f7]) {
        level.var_4a825f7++;
        if (level.var_4a825f7 == level.var_ce30083b.size) {
            level flag::set("passkey_confirmed");
        }
    } else {
        level.var_4a825f7 = 0;
    }
    if (letter == level.var_b505a146[level.var_66e412e8]) {
        level.var_66e412e8++;
        if (level.var_66e412e8 == level.var_b505a146.size) {
            e_player playsoundtoplayer("evt_letter_pickup_secret_1", e_player);
        }
    } else {
        level.var_66e412e8 = 0;
    }
    if (letter == level.var_8f0326dd[level.var_fd63aa69]) {
        level.var_fd63aa69++;
        if (level.var_fd63aa69 == level.var_8f0326dd.size) {
            e_player playsoundtoplayer("evt_letter_pickup_secret_2", e_player);
        }
        return;
    }
    level.var_fd63aa69 = 0;
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0xc96906ac, Offset: 0x3430
// Size: 0x1ee
function function_6f6480bb() {
    level flag::init("thundergun_hit");
    weapon_combo_spot = struct::get("weapon_combo_spot", "targetname");
    var_e35067d3 = spawn("script_model", weapon_combo_spot.origin);
    var_e35067d3 setmodel("tag_origin");
    fx = playfxontag(level._effect["gersh_spark"], var_e35067d3, "tag_origin");
    level.var_81ac6ac4 = spawn("trigger_radius", weapon_combo_spot.origin, 0, 50, 72);
    level.var_5fc80ad9 = &function_184744ba;
    /#
        var_e35067d3 thread function_a0ad103c(weapon_combo_spot);
    #/
    level flag::wait_till("weapons_combined");
    level.var_81ac6ac4 delete();
    level.var_5fc80ad9 = undefined;
    var_e35067d3 delete();
    for (i = 0; i < level.var_1999d459.size; i++) {
        level.var_1999d459[i] delete();
    }
}

/#

    // Namespace zm_cosmodrome_eggs
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd69d8fd4, Offset: 0x3628
    // Size: 0x6c
    function function_a0ad103c(weapon_combo_spot) {
        if (isdefined(level.var_55336afe) && level.var_55336afe) {
            self thread function_510c4845();
            wait 1;
            self notify(#"death");
            return;
        }
        weapon_combo_spot thread function_8172c64e();
    }

    // Namespace zm_cosmodrome_eggs
    // Params 0, eflags: 0x1 linked
    // Checksum 0x25741739, Offset: 0x36a0
    // Size: 0x7c
    function function_8172c64e() {
        self thread zm_cosmodrome::function_620401c0(self.origin, "<dev string:x124>", "<dev string:x124>");
        level flag::wait_till("<dev string:x124>");
        self thread zm_cosmodrome::function_bb831d("<dev string:x124>");
    }

#/

// Namespace zm_cosmodrome_eggs
// Params 3, eflags: 0x1 linked
// Checksum 0xf39a4078, Offset: 0x3728
// Size: 0x5e
function function_184744ba(grenade, model, info) {
    if (isdefined(level.var_81ac6ac4) && grenade istouching(level.var_81ac6ac4)) {
        grenade function_510c4845();
    }
    return false;
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x286b70fe, Offset: 0x3790
// Size: 0x54
function function_510c4845() {
    trig = spawn("trigger_damage", self.origin, 0, 15, 72);
    self thread function_61f25aa1(trig);
}

// Namespace zm_cosmodrome_eggs
// Params 1, eflags: 0x1 linked
// Checksum 0xf5ad32c6, Offset: 0x37f0
// Size: 0x28a
function function_61f25aa1(trig) {
    self endon(#"death");
    self thread function_cc6ea79(trig);
    weapon_combo_spot = struct::get("weapon_combo_spot", "targetname");
    var_68345fe = 0;
    var_83e9f930 = 0;
    /#
        if (isdefined(level.var_55336afe) && level.var_55336afe) {
            var_68345fe = 1;
            var_83e9f930 = 1;
        }
    #/
    players = getplayers();
    array::thread_all(players, &function_6d87905c, self, trig, weapon_combo_spot);
    while (true) {
        amount, inflictor, direction, point, type, tagname, modelname, partname, weapon = trig waittill(#"damage");
        if (isdefined(inflictor)) {
            if (weapon.name == "ray_gun_upgraded" || type == "MOD_PROJECTILE" && weapon.name == "raygun_mark2_upgraded") {
                var_68345fe = 1;
            } else if (weapon.name == "nesting_dolls" || weapon.name == "nesting_dolls_single") {
                var_83e9f930 = 1;
            }
            if (var_68345fe && var_83e9f930 && level flag::get("thundergun_hit")) {
                level flag::set("weapons_combined");
                level thread soul_release(self, trig.origin);
                return;
            }
        }
    }
}

// Namespace zm_cosmodrome_eggs
// Params 3, eflags: 0x1 linked
// Checksum 0xb534131b, Offset: 0x3a88
// Size: 0x1b8
function function_6d87905c(model, trig, weapon_combo_spot) {
    /#
        if (isdefined(level.var_55336afe) && level.var_55336afe) {
            util::wait_network_frame();
            self function_30d8de55(trig);
            return;
        }
    #/
    model endon(#"death");
    while (true) {
        self waittill(#"weapon_fired");
        w_player_weapon = self getcurrentweapon();
        if (w_player_weapon.name == "thundergun_upgraded") {
            if (distancesquared(self.origin, weapon_combo_spot.origin) < 90000) {
                var_a9399ec7 = vectornormalize(weapon_combo_spot.origin - self getweaponmuzzlepoint());
                var_8e3e37c9 = self getweaponforwarddir();
                angle_diff = acos(vectordot(var_a9399ec7, var_8e3e37c9));
                if (angle_diff <= 20) {
                    self function_30d8de55(trig);
                }
            }
        }
    }
}

// Namespace zm_cosmodrome_eggs
// Params 1, eflags: 0x1 linked
// Checksum 0xed7cdc56, Offset: 0x3c48
// Size: 0x5c
function function_30d8de55(trig) {
    level flag::set("thundergun_hit");
    radiusdamage(trig.origin, 5, 1, 1, self);
}

// Namespace zm_cosmodrome_eggs
// Params 1, eflags: 0x1 linked
// Checksum 0x9a59aa6e, Offset: 0x3cb0
// Size: 0xfc
function function_cc6ea79(trig) {
    self waittill(#"death");
    trig delete();
    if (level flag::get("thundergun_hit") && !level flag::get("weapons_combined")) {
        level thread function_321f0d6f("vox_ann_egg6p1_success", "vox_gersh_egg6_fail2", 7);
    } else if (!level flag::get("weapons_combined")) {
        level thread function_321f0d6f(undefined, "vox_gersh_egg6_fail1", 6);
    }
    level flag::clear("thundergun_hit");
}

// Namespace zm_cosmodrome_eggs
// Params 2, eflags: 0x1 linked
// Checksum 0xca277015, Offset: 0x3db8
// Size: 0x17c
function soul_release(model, origin) {
    soul = spawn("script_model", origin);
    soul setmodel("tag_origin");
    soul playloopsound("zmb_egg_soul");
    fx = playfxontag(level._effect["gersh_spark"], soul, "tag_origin");
    time = 20;
    model waittill(#"death");
    level thread function_321f0d6f("vox_ann_egg6_success", "vox_gersh_egg6_success", 9);
    level thread function_944c8cd2();
    soul movez(2500, time, time - 1);
    wait time;
    soul delete();
    wait 2;
    level thread function_28a46c0d();
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0xeebafa53, Offset: 0x3f40
// Size: 0x6e
function function_944c8cd2() {
    wait 12.5;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread function_467428d0();
    }
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x10d4e2a3, Offset: 0x3fb8
// Size: 0xb4
function function_467428d0() {
    while (self usebuttonpressed() && (!zombie_utility::is_player_valid(self) || self zm_utility::in_revive_trigger())) {
        wait 1;
    }
    if (!self bgb::is_enabled("zm_bgb_disorderly_combat")) {
        level thread zm_powerup_weapon_minigun::minigun_weapon_powerup(self, 90);
    }
    self zm_utility::function_82a5cc4();
}

// Namespace zm_cosmodrome_eggs
// Params 3, eflags: 0x1 linked
// Checksum 0xb7648028, Offset: 0x4078
// Size: 0x1bc
function function_321f0d6f(var_d6e54e9f, var_1bb1a809, var_2c0c1edc) {
    if (isdefined(var_d6e54e9f)) {
        level zm_cosmodrome_amb::function_3cf7b8c9(var_d6e54e9f);
    }
    if (isdefined(var_2c0c1edc) && !isdefined(level.var_92ed253c)) {
        players = getplayers();
        rand = randomintrange(0, players.size);
        players[rand] playsoundwithnotify("vox_plr_" + players[rand].characterindex + "_level_start_" + randomintrange(0, 4), "level_start_vox_done");
        players[rand] waittill(#"level_start_vox_done");
        level.var_92ed253c = 1;
    }
    if (isdefined(var_1bb1a809)) {
        level zm_cosmodrome_amb::function_524d0ceb(var_1bb1a809);
    }
    if (isdefined(var_2c0c1edc)) {
        players = getplayers();
        rand = randomintrange(0, players.size);
        players[rand] zm_audio::create_and_play_dialog("eggs", "gersh_response", var_2c0c1edc);
    }
}

// Namespace zm_cosmodrome_eggs
// Params 0, eflags: 0x1 linked
// Checksum 0x2f0a3798, Offset: 0x4240
// Size: 0xb4
function function_28a46c0d() {
    playsoundatposition("zmb_samantha_earthquake", (0, 0, 0));
    playsoundatposition("zmb_samantha_whispers", (0, 0, 0));
    wait 6;
    level clientfield::set("COSMO_EGG_SAM_ANGRY", 1);
    playsoundatposition("zmb_samantha_scream", (0, 0, 0));
    wait 6;
    level clientfield::set("COSMO_EGG_SAM_ANGRY", 0);
}

