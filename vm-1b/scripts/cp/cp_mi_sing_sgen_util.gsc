#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/doors_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace namespace_cba4cc55;

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x3a2cbde1, Offset: 0x3e0
// Size: 0x9a
function function_588a8011() {
    self endon(#"death");
    assert(isdefined(self.target), "<dev string:x28>" + self.origin + "<dev string:x3d>");
    var_598dabc3 = getentarray(self.target, "targetname");
    self waittill(#"trigger");
    self util::script_wait();
    array::thread_all(var_598dabc3, &function_2c2e94d1);
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x13cf44dc, Offset: 0x488
// Size: 0x1a5
function function_2c2e94d1() {
    self util::script_wait();
    time = 0.5;
    if (isdefined(self.script_float)) {
        time = self.script_float;
    }
    if (!isdefined(self.script_string)) {
        self.script_string = "move";
    }
    switch (self.script_string) {
    case "rotate":
        if (isdefined(self.script_angles)) {
            self rotateto(self.script_angles, time, 0, 0);
        } else if (isdefined(self.script_int)) {
            self rotateyaw(self.script_int, time, 0, 0);
        }
        break;
    case "move":
    default:
        self setmovingplatformenabled(1);
        if (isdefined(self.script_vector)) {
            vector = self.script_vector;
            if (time >= 0.5) {
                self moveto(self.origin + self.script_vector, time, time * 0.25, time * 0.25);
            } else {
                self moveto(self.origin + self.script_vector, time);
            }
        } else if (isdefined(self.script_int)) {
            self movez(self.script_int, time, 0, 0);
        }
        wait time;
        self setmovingplatformenabled(0);
        break;
    }
}

// Namespace namespace_cba4cc55
// Params 1, eflags: 0x0
// Checksum 0x837d3bb5, Offset: 0x638
// Size: 0x11f
function function_f20239(n_range) {
    if (!isdefined(n_range)) {
        n_range = 256;
    }
    self endon(#"death");
    self endon(#"stop_head_track_player");
    var_175d1224 = self.angles;
    var_f1b873af = (270, 90, -76);
    while (isdefined(self)) {
        e_player = arraygetclosest(self.origin, level.players, n_range);
        if (!isdefined(e_player)) {
            if (self.angles != var_175d1224) {
                self rotateto(var_175d1224, 1);
            }
            wait 1;
            continue;
        }
        v_to_player = vectortoangles(e_player.origin - self.origin);
        v_face_angles = (0, v_to_player[1], 0) + var_f1b873af;
        self rotateto(v_face_angles, 0.5);
        self waittill(#"rotatedone");
    }
}

// Namespace namespace_cba4cc55
// Params 1, eflags: 0x0
// Checksum 0x80c6775, Offset: 0x760
// Size: 0xc5
function function_359855(n_range) {
    if (!isdefined(n_range)) {
        n_range = 512;
    }
    self endon(#"death");
    self endon(#"stop_head_track_player");
    while (true) {
        e_player = arraygetclosest(self.origin, level.players, n_range);
        if (!isdefined(e_player)) {
            if (isdefined(self.var_960fdad0)) {
                self.var_960fdad0 = undefined;
                self lookatentity();
            }
        } else if (!isdefined(self.var_960fdad0) || self.var_960fdad0 != e_player) {
            self.var_960fdad0 = e_player;
            self lookatentity(self.var_960fdad0);
        }
        wait 1;
    }
}

// Namespace namespace_cba4cc55
// Params 4, eflags: 0x0
// Checksum 0x53001ffd, Offset: 0x830
// Size: 0x53
function function_2065b4e9(func1, param1, func2, param2) {
    if (isdefined(param1)) {
        [[ func1 ]](param1);
    } else {
        [[ func1 ]]();
    }
    if (isdefined(param2)) {
        [[ func2 ]](param2);
        return;
    }
    [[ func2 ]]();
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x7c280b69, Offset: 0x890
// Size: 0x99
function function_8b31a9a3() {
    self notify(#"hash_f42cafec");
    self endon(#"hash_f42cafec");
    while (true) {
        var_b6b9582d = getcorpsearray();
        foreach (corpse in var_b6b9582d) {
            if (isdefined(corpse)) {
                corpse delete();
            }
        }
        wait 10;
    }
}

// Namespace namespace_cba4cc55
// Params 2, eflags: 0x0
// Checksum 0x87179437, Offset: 0x938
// Size: 0x141
function function_36a6e271(should_delete, a_ai) {
    if (!isdefined(a_ai)) {
        a_ai = [];
    }
    while (true) {
        var_790129b = 0;
        var_6c4dd462 = 0;
        foreach (player in level.players) {
            if (player istouching(self)) {
                var_790129b++;
            }
        }
        foreach (ai in a_ai) {
            if (ai istouching(self)) {
                var_6c4dd462++;
            }
        }
        if (var_790129b == level.players.size && var_6c4dd462 == a_ai.size) {
            if (isdefined(should_delete) && should_delete) {
                self util::self_delete();
            }
            break;
        }
        wait 0.1;
    }
}

/#

    // Namespace namespace_cba4cc55
    // Params 4, eflags: 0x0
    // Checksum 0x86b5e85d, Offset: 0xa88
    // Size: 0x6d
    function function_272df3bd(org, text, color, str_notify) {
        if (isdefined(str_notify)) {
            self endon(str_notify);
        }
        while (true) {
            if (isdefined(self) && isdefined(self.origin)) {
                org = self.origin;
            }
            print3d(org, text, color);
            wait 0.05;
        }
    }

#/

// Namespace namespace_cba4cc55
// Params 1, eflags: 0x0
// Checksum 0xb6ee9b5c, Offset: 0xb00
// Size: 0x122
function function_c22db411(n_level) {
    switch (n_level) {
    case 1:
        self ai::set_behavior_attribute("rogue_control", "forced_level_1");
        break;
    case 2:
        self ai::set_behavior_attribute("rogue_control", "forced_level_2");
        break;
    case 3:
        self ai::set_behavior_attribute("rogue_control", "forced_level_3");
        break;
    }
    n_rand = randomint(5);
    if (n_rand == 0) {
        self ai::set_behavior_attribute("rogue_control_speed", "walk");
        return;
    }
    if (n_rand == 1) {
        self ai::set_behavior_attribute("rogue_control_speed", "run");
        return;
    }
    self ai::set_behavior_attribute("rogue_control_speed", "sprint");
}

// Namespace namespace_cba4cc55
// Params 3, eflags: 0x0
// Checksum 0xda0df0fa, Offset: 0xc30
// Size: 0x8a
function function_d2036e84(var_ecc142a5, var_6203c1b5, var_bf402dd4) {
    if (!isdefined(var_bf402dd4)) {
        var_bf402dd4 = 1;
    }
    s_scene = struct::get(var_ecc142a5);
    s_scene thread scene::play(level.var_2fd26037);
    level.var_2fd26037 waittill(#"goal");
    level flag::wait_till(var_6203c1b5);
    s_scene scene::stop();
}

// Namespace namespace_cba4cc55
// Params 2, eflags: 0x0
// Checksum 0x98791910, Offset: 0xcc8
// Size: 0xef
function set_door_state(str_name, str_state) {
    var_ae75b4be = struct::get_array(str_name, "targetname");
    if (isdefined(var_ae75b4be) && var_ae75b4be.size > 0) {
        foreach (s_door in var_ae75b4be) {
            if (str_state === "open") {
                [[ s_door.c_door ]]->unlock();
                [[ s_door.c_door ]]->open();
                continue;
            }
            [[ s_door.c_door ]]->close();
            [[ s_door.c_door ]]->lock();
        }
    }
}

// Namespace namespace_cba4cc55
// Params 2, eflags: 0x0
// Checksum 0xa3ec0ff7, Offset: 0xdc0
// Size: 0xb2
function function_c2ee574f(var_ff608bc9, n_time) {
    self playsound("evt_door_close_start");
    self playloopsound("evt_door_close_loop", 0.5);
    self moveto(self.origin + var_ff608bc9, n_time, n_time * 0.1, n_time * 0.25);
    self waittill(#"movedone");
    self playsound("evt_door_close_stop");
    self stoploopsound(0.4);
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x893949f8, Offset: 0xe80
// Size: 0x42
function function_aef08215() {
    level endon(#"hash_c9e53487");
    self waittill(#"trigger", e_player);
    level function_40077528(0.2, 2, self.origin, 5000);
}

// Namespace namespace_cba4cc55
// Params 7, eflags: 0x0
// Checksum 0x28e044a2, Offset: 0xed0
// Size: 0x28a
function function_40077528(n_mag, n_duration, v_org, n_range, var_77e1f19f, var_cab96061, str_rumble) {
    if (!isdefined(n_range)) {
        n_range = 5000;
    }
    if (!isdefined(var_77e1f19f)) {
        var_77e1f19f = 1;
    }
    if (!isdefined(var_cab96061)) {
        var_cab96061 = var_77e1f19f + 2;
    }
    if (!isdefined(str_rumble)) {
        str_rumble = "cp_sgen_flood_earthquake_rumble";
    }
    e_player = array::random(level.players);
    v_pos = math::random_vector(1700);
    playrumbleonposition(str_rumble, e_player.origin + v_pos);
    earthquake(n_mag, n_duration, v_org, n_range);
    if (n_mag >= 3) {
        foreach (player in level.players) {
            player notify(#"new_quake");
            visionset_mgr::activate("overlay", "earthquake_blur", player, 0.25);
            player util::delay(n_duration + 3, "new_quake", &visionset_mgr::deactivate, "overlay", "earthquake_blur", player);
            player shellshock("tankblast_mp", randomfloatrange(var_77e1f19f, var_cab96061));
        }
    }
    v_angles = (randomint(360), randomint(360), randomint(360));
    v_forward = anglestoforward(v_angles);
    n_range = randomfloatrange(500, 1000);
    v_location = e_player.origin + v_forward * n_range;
    playsoundatposition("evt_base_explo_deep", v_location);
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x2dc966b7, Offset: 0x1168
// Size: 0x77
function function_d455824c() {
    v_origin = (0, 0, 0);
    foreach (player in level.players) {
        v_origin += player.origin;
    }
    return v_origin / level.players.size;
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0xdaaaa381, Offset: 0x11e8
// Size: 0x52
function function_a527e6f9() {
    self.script_accuracy = 0.2;
    self.health = 100;
    self.skipdeath = 1;
    self asmsetanimationrate(0.7);
    self clientfield::set("robot_bubbles", 1);
}

// Namespace namespace_cba4cc55
// Params 2, eflags: 0x0
// Checksum 0x1993f76b, Offset: 0x1248
// Size: 0x9f
function function_6d1a2a8d(str_name, var_1ba2b2a5) {
    a_s_spawnpoints = struct::get_array("cp_coop_spawn", "targetname");
    foreach (s_spawnpoint in a_s_spawnpoints) {
        if (s_spawnpoint.script_objective === str_name) {
            s_spawnpoint.script_objective = var_1ba2b2a5;
        }
    }
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0xb6d290fc, Offset: 0x12f0
// Size: 0x56
function function_ceda7454() {
    if (isai(self)) {
        self forceteleport(self.origin + level.var_c490ab3b, self.angles);
        return;
    }
    self.origin = self.origin + level.var_c490ab3b;
}

// Namespace namespace_cba4cc55
// Params 1, eflags: 0x0
// Checksum 0x5063c048, Offset: 0x1350
// Size: 0x32
function function_9cb9697d(str_scene) {
    if (scene::is_active(str_scene)) {
        scene::stop(str_scene);
    }
}

// Namespace namespace_cba4cc55
// Params 5, eflags: 0x0
// Checksum 0xe1eec72, Offset: 0x1390
// Size: 0xf2
function function_169ff177(var_bb9e181, var_6d8cce82, var_3d420807, var_66ae145d, var_3e87e125) {
    if (!isdefined(var_bb9e181)) {
        var_bb9e181 = 0;
    }
    self.var_216251ed = spawn("script_model", self.origin);
    self.var_216251ed.angles = self.angles;
    self.var_216251ed setmodel("tag_origin");
    self allowsprint(0);
    if (var_bb9e181) {
        self playerlinktodelta(self.var_216251ed, "tag_origin", 1, var_6d8cce82, var_3d420807, var_66ae145d, var_3e87e125, 1);
        return;
    }
    self playerlinktoabsolute(self.var_216251ed, "tag_origin");
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x74932f0a, Offset: 0x1490
// Size: 0x32
function function_72f4d03c() {
    if (isdefined(self.var_216251ed)) {
        self.var_216251ed delete();
        self allowsprint(1);
    }
}

// Namespace namespace_cba4cc55
// Params 1, eflags: 0x0
// Checksum 0x29069273, Offset: 0x14d0
// Size: 0x2f
function round_up_to_ten(n_value) {
    n_new_value = n_value - n_value % 10;
    if (n_new_value < n_value) {
        n_new_value += 10;
    }
    return n_new_value;
}

// Namespace namespace_cba4cc55
// Params 4, eflags: 0x0
// Checksum 0x49705dd, Offset: 0x1508
// Size: 0xad
function function_7073af93(str_anim, str_notetrack, func_callback, is_loop) {
    if (self != level) {
        self endon(#"death");
    }
    level flagsys::wait_till(str_anim + "_playing");
    do {
        str_notify = self util::waittill_any_return(str_notetrack, str_anim + "_playing");
        if (str_notify == str_notetrack) {
            self thread [[ func_callback ]]();
        }
    } while (isdefined(is_loop) && is_loop && level flagsys::get(str_anim + "_playing"));
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x14a10b4e, Offset: 0x15c0
// Size: 0x3a
function fade_in() {
    array::thread_all(level.players, &util::function_c04ace5b, 0, 0.5);
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x10b73fe3, Offset: 0x1608
// Size: 0x3a
function fade_out() {
    array::thread_all(level.players, &util::function_c04ace5b, 1, 0.5);
}

// Namespace namespace_cba4cc55
// Params 2, eflags: 0x0
// Checksum 0x572ec029, Offset: 0x1650
// Size: 0x32
function function_cb1e4146(str_scene, str_teleport_name) {
    level waittill(str_scene + "_done");
    util::function_93831e79(str_teleport_name);
}

// Namespace namespace_cba4cc55
// Params 2, eflags: 0x0
// Checksum 0x8fcf9681, Offset: 0x1690
// Size: 0x7b
function function_411dc61b(n_base, var_df47d27) {
    n_num = n_base - var_df47d27;
    foreach (e_player in level.players) {
        n_num += var_df47d27;
    }
    return n_num;
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x8d8d0e96, Offset: 0x1718
// Size: 0x2a
function function_705fac33() {
    level.var_d7c2e2b0 = level.var_2b829c4e;
    level.var_2b829c4e = &wait_to_spawn;
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0xb5cab24, Offset: 0x1750
// Size: 0x33
function function_45953c88() {
    assert(isdefined(level.var_d7c2e2b0));
    level.var_2b829c4e = level.var_d7c2e2b0;
    level notify(#"hotjoin_enabled");
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x9d756022, Offset: 0x1790
// Size: 0x24
function wait_to_spawn() {
    level util::waittill_either("objective_changed", "hotjoin_enabled");
    return true;
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x85d16c18, Offset: 0x17c0
// Size: 0x83
function function_3d026c12() {
    foreach (e_player in level.players) {
        e_player freezecontrols(0);
        e_player util::show_hud(1);
        e_player enableweapons();
    }
}

// Namespace namespace_cba4cc55
// Params 0, eflags: 0x0
// Checksum 0x6d8c140b, Offset: 0x1850
// Size: 0x9b
function refill_ammo() {
    a_w_weapons = self getweaponslist();
    foreach (w_weapon in a_w_weapons) {
        self givemaxammo(w_weapon);
        self setweaponammoclip(w_weapon, w_weapon.clipsize);
    }
}

// Namespace namespace_cba4cc55
// Params 2, eflags: 0x0
// Checksum 0xbf3bde83, Offset: 0x18f8
// Size: 0x19a
function function_c8849158(n_dist, n_delay) {
    self endon(#"death");
    var_2540d664 = 0;
    if (self flagsys::get("scriptedanim")) {
        self flagsys::wait_till_clear("scriptedanim");
    }
    if (isdefined(n_delay)) {
        wait n_delay;
    }
    while (!var_2540d664) {
        wait 1;
        foreach (player in level.players) {
            if (isvehicle(self)) {
                var_911c6902 = self function_4246bc05(player);
            } else if (isactor(self)) {
                var_911c6902 = self cansee(player);
            } else {
                assertmsg("<dev string:x5c>");
                return;
            }
            if (!var_911c6902 && distance(self.origin, player.origin) > n_dist && player util::is_player_looking_at(self.origin, undefined, 0) == 0) {
                var_2540d664 = 1;
            }
        }
    }
    self delete();
}

