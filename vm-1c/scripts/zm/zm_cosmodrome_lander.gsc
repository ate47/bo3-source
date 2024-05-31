#using scripts/zm/zm_cosmodrome_eggs;
#using scripts/zm/zm_cosmodrome_amb;
#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_9d4ce396;

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_c35e6aab
// Checksum 0xc3aaa2f3, Offset: 0xa38
// Size: 0x4fc
function init() {
    level flag::init("lander_power");
    level flag::init("lander_connected");
    level flag::init("lander_grounded");
    level flag::init("lander_takeoff");
    level flag::init("lander_landing");
    level flag::init("lander_cooldown");
    level flag::init("lander_inuse");
    level.var_b10eb05f = 0;
    level.var_fb331fc7 = 0;
    level.var_d7241b58 = 0;
    lander = getent("lander", "targetname");
    lander.console = getent("lander_console", "targetname");
    lander.console linkto(lander);
    lander.var_58e61531 = getent("zipline_door_n", "script_noteworthy");
    lander.var_db1f86cb = getent("zipline_door_s", "script_noteworthy");
    lander setforcenocull();
    lander.var_58e61531 setforcenocull();
    lander.var_db1f86cb setforcenocull();
    lander.station = "lander_station5";
    lander.state = "idle";
    lander.called = 0;
    lander.anchor = spawn("script_origin", lander.origin);
    lander.anchor.angles = lander.angles;
    lander linkto(lander.anchor);
    lander function_ca951cd(undefined, 1);
    lander.var_58e61531 function_ca951cd(undefined, 1);
    lander.var_db1f86cb function_ca951cd(undefined, 1);
    lander.zone = [];
    lander.zone["lander_station1"] = "base_entry_zone";
    lander.zone["lander_station3"] = "north_catwalk_zone3";
    lander.zone["lander_station4"] = "storage_lander_zone";
    lander.zone["lander_station5"] = "centrifuge_zone";
    lander.var_57ec6f7e = 3;
    init_call_boxes();
    level thread function_15b83963();
    level flag::wait_till("start_zombie_round_logic");
    callback::on_connect(&function_7a1aff0c);
    function_95a64d83();
    level notify(#"hash_8f27dcf0");
    wait(0.1);
    level flag::wait_till("power_on");
    enable_callboxes();
    function_e8434a58();
    level thread function_9be6c7d0();
    level thread function_71f10e60();
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_7a1aff0c
// Checksum 0x21100c3d, Offset: 0xf40
// Size: 0x30
function function_7a1aff0c() {
    if (level flag::get("lander_intro_done")) {
        self.lander = 0;
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_95a64d83
// Checksum 0xe3cff25e, Offset: 0xf78
// Size: 0x64
function function_95a64d83() {
    level clientfield::set("COSMO_LANDER_BASE_ENTRY_BAY", 1);
    level clientfield::set("COSMO_LANDER_CATWALK_BAY", 1);
    level clientfield::set("COSMO_LANDER_STORAGE_BAY", 1);
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_15b83963
// Checksum 0x106bd433, Offset: 0xfe8
// Size: 0xa6
function function_15b83963() {
    var_e55bef66 = getentarray("lander_poi", "targetname");
    for (i = 0; i < var_e55bef66.size; i++) {
        var_e55bef66[i] zm_utility::create_zombie_point_of_interest(undefined, 30, 0, 0);
        var_e55bef66[i] thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, 45);
    }
}

// Namespace namespace_9d4ce396
// Params 1, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_c1f96b46
// Checksum 0xb0380fd, Offset: 0x1098
// Size: 0x104
function function_c1f96b46(station) {
    if (!isdefined(station)) {
        return;
    }
    var_8ec169f9 = undefined;
    var_e55bef66 = getentarray("lander_poi", "targetname");
    for (i = 0; i < var_e55bef66.size; i++) {
        if (var_e55bef66[i].script_string == station) {
            var_8ec169f9 = var_e55bef66[i];
        }
    }
    var_8ec169f9 zm_utility::activate_zombie_point_of_interest();
    level flag::wait_till("lander_grounded");
    var_8ec169f9 zm_utility::deactivate_zombie_point_of_interest();
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x0
// namespace_9d4ce396<file_0>::function_9857df93
// Checksum 0xbb854883, Offset: 0x11a8
// Size: 0x24
function function_9857df93() {
    self setmodel("p_zom_lunar_control_scrn_on");
}

// Namespace namespace_9d4ce396
// Params 2, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_ca951cd
// Checksum 0xaefad0b3, Offset: 0x11d8
// Size: 0x136
function function_ca951cd(piece, var_a453023b) {
    pieces = getentarray(self.target, "targetname");
    for (i = 0; i < pieces.size; i++) {
        if (isdefined(pieces[i].script_noteworthy) && pieces[i].script_noteworthy == "zip_buy") {
            pieces[i] enablelinkto();
        }
        if (isdefined(piece)) {
            pieces[i] linkto(piece);
        } else {
            pieces[i] linkto(self);
        }
        if (isdefined(var_a453023b) && var_a453023b) {
            pieces[i] setforcenocull();
        }
    }
}

// Namespace namespace_9d4ce396
// Params 1, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_e11b107
// Checksum 0xaa458abc, Offset: 0x1318
// Size: 0xac
function function_e11b107(time) {
    open_pos = struct::get(self.target, "targetname");
    start_pos = struct::get(open_pos.target, "targetname");
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "shaft_cap") {
        return;
    }
    level flag::wait_till("lander_grounded");
}

// Namespace namespace_9d4ce396
// Params 1, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_e71897c5
// Checksum 0x818a7461, Offset: 0x13d0
// Size: 0x68
function function_e71897c5(time) {
    open_pos = struct::get(self.target, "targetname");
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "shaft_cap") {
        level waittill(#"hash_8f27dcf0");
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_e8434a58
// Checksum 0xe667acb7, Offset: 0x1440
// Size: 0xdc
function function_e8434a58() {
    lander = getent("lander", "targetname");
    var_14fa26a9 = getent("zipline_door_n_pos", "script_noteworthy");
    var_204f913 = getent("zipline_door_s_pos", "script_noteworthy");
    lander.var_58e61531 thread move_gate(var_14fa26a9, 1);
    lander.var_db1f86cb thread move_gate(var_204f913, 1);
}

// Namespace namespace_9d4ce396
// Params 1, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_f2e995a2
// Checksum 0xd4f7c597, Offset: 0x1528
// Size: 0x11c
function function_f2e995a2(time) {
    lander = getent("lander", "targetname");
    var_14fa26a9 = getent("zipline_door_n_pos", "script_noteworthy");
    var_204f913 = getent("zipline_door_s_pos", "script_noteworthy");
    center_pos = getent("zipline_center", "script_noteworthy");
    lander.var_58e61531 thread move_gate(var_14fa26a9, 0, time);
    lander.var_db1f86cb thread move_gate(var_204f913, 0, time);
}

// Namespace namespace_9d4ce396
// Params 3, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_c992c744
// Checksum 0xd77989ed, Offset: 0x1650
// Size: 0x23c
function move_gate(pos, lower, time) {
    if (!isdefined(time)) {
        time = 1;
    }
    lander = getent("lander", "targetname");
    self unlink();
    if (lower) {
        self notsolid();
        if (self.classname == "script_brushmodel") {
            self moveto(pos.origin + (0, 0, -132), time);
        } else {
            self playsound("zmb_lander_gate");
            self moveto(pos.origin + (0, 0, -44), time);
        }
        self waittill(#"movedone");
        if (self.classname == "script_brushmodel") {
            self notsolid();
        }
    } else {
        if (self.classname == "script_brushmodel") {
        } else {
            self playsound("zmb_lander_gate");
        }
        self notsolid();
        self moveto(pos.origin, time);
        self waittill(#"movedone");
        if (self.classname == "script_brushmodel") {
            self solid();
        }
    }
    self linkto(lander.anchor);
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_141a32c6
// Checksum 0x5a0dd003, Offset: 0x1898
// Size: 0x44
function init_buy() {
    trigger = getent("zip_buy", "script_noteworthy");
    trigger thread function_9bb302f();
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_f053c0d8
// Checksum 0xb6d8348, Offset: 0x18e8
// Size: 0xa6
function init_call_boxes() {
    level flag::wait_till("zones_initialized");
    trigger = getentarray("zip_call_box", "targetname");
    for (i = 0; i < trigger.size; i++) {
        trigger[i] thread call_box_think();
        self.destination = "lander_station5";
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_12ae669a
// Checksum 0x4e4a52c, Offset: 0x1998
// Size: 0x338
function call_box_think() {
    level endon(#"fake_death");
    lander = getent("lander", "targetname");
    self sethintstring(%ZOMBIE_NEED_POWER);
    self setcursorhint("HINT_NOICON");
    level flag::wait_till("power_on");
    self.var_4dd152d7 = 0;
    if (lander.station != self.script_noteworthy) {
        self sethintstring(%ZM_COSMODROME_LANDER_CALL);
    } else {
        self sethintstring(%ZM_COSMODROME_LANDER_AT_STATION);
        self setcursorhint("HINT_NOICON");
    }
    while (true) {
        who = undefined;
        who = self waittill(#"trigger");
        if (who laststand::player_is_in_laststand()) {
            continue;
        }
        if (level flag::get("lander_cooldown") || level flag::get("lander_inuse")) {
            continue;
        }
        if (!self.var_4dd152d7) {
            self.var_4dd152d7 = 1;
        }
        if (lander.station != self.script_noteworthy) {
            call_destination = self.script_noteworthy;
            lander.called = 1;
            level.var_fb331fc7 = 1;
            self playsound("zmb_push_button");
            self playsound("vox_ann_lander_current_0");
            switch (call_destination) {
            case 13:
                level clientfield::set("COSMO_LANDER_DEST", 4);
                break;
            case 17:
                level clientfield::set("COSMO_LANDER_DEST", 3);
                break;
            case 19:
                level clientfield::set("COSMO_LANDER_DEST", 2);
                break;
            case 21:
                level clientfield::set("COSMO_LANDER_DEST", 1);
                break;
            }
            self thread function_f0c6d0e1(call_destination);
        }
        wait(0.05);
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_9bb302f
// Checksum 0xdb5bffd8, Offset: 0x1cd8
// Size: 0x77c
function function_9bb302f() {
    level endon(#"fake_death");
    self sethintstring(%ZOMBIE_NEED_POWER);
    level flag::wait_till("power_on");
    lander = getent("lander", "targetname");
    panel = getent("rocket_launch_panel", "targetname");
    self sethintstring(%ZM_COSMODROME_LANDER_NO_CONNECTIONS);
    level clientfield::set("COSMO_LANDER_STATUS_LIGHTS", 1);
    level clientfield::set("COSMO_LANDER_STATION", 4);
    while (!lander.called) {
        wait(1);
    }
    level.var_b10eb05f = 1;
    level flag::set("lander_connected");
    self sethintstring(%ZM_COSMODROME_LANDER, -6);
    node = getnode("goto_centrifuge", "targetname");
    while (true) {
        who = undefined;
        who = self waittill(#"trigger");
        if (level flag::get("lander_cooldown") || level flag::get("lander_inuse")) {
            zm_utility::play_sound_at_pos("no_purchase", self.origin);
            continue;
        }
        if (who laststand::player_is_in_laststand()) {
            zm_utility::play_sound_at_pos("no_purchase", self.origin);
            continue;
        }
        var_da395a8a = getent(lander.station + "_riders", "targetname");
        touching = 0;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (var_da395a8a istouching(players[i])) {
                touching = 1;
            }
        }
        if (!touching) {
            continue;
        }
        if (zombie_utility::is_player_valid(who) && who zm_score::can_player_purchase(level.var_be7278ad)) {
            who zm_score::minus_to_player_score(level.var_be7278ad);
            zm_utility::play_sound_at_pos("purchase", self.origin);
            self playsound("zmb_push_button");
            self playsound("vox_ann_lander_current_0");
            level.var_fb331fc7 = 1;
            lander.called = 0;
            if (lander.station != "lander_station5") {
                lander thread function_bd6e70fe();
            }
            call_box = getent(lander.station, "script_noteworthy");
            if (lander.station == "lander_station5") {
                dest = [];
                azkeys = getarraykeys(lander.zone);
                for (i = 0; i < azkeys.size; i++) {
                    if (azkeys[i] == lander.station) {
                        continue;
                    }
                    zone = level.zones[lander.zone[azkeys[i]]];
                    if (isdefined(zone) && zone.is_enabled) {
                        dest[dest.size] = azkeys[i];
                    }
                }
                dest = array::randomize(dest);
                call_box.destination = dest[0];
            } else {
                call_box.destination = "lander_station5";
            }
            lander.driver = who;
            if (isplayer(who)) {
            }
            lander playsound("zmb_lander_start");
            lander playloopsound("zmb_lander_exhaust_loop", 1);
            switch (call_box.destination) {
            case 13:
                level clientfield::set("COSMO_LANDER_DEST", 4);
                break;
            case 17:
                level clientfield::set("COSMO_LANDER_DEST", 3);
                break;
            case 19:
                level clientfield::set("COSMO_LANDER_DEST", 2);
                break;
            case 21:
                level clientfield::set("COSMO_LANDER_DEST", 1);
                break;
            }
            self function_f0c6d0e1(call_box.destination);
        } else {
            zm_utility::play_sound_at_pos("no_purchase", self.origin);
            who zm_audio::create_and_play_dialog("general", "no_money", 0);
            continue;
        }
        wait(0.05);
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_bd6e70fe
// Checksum 0x8c9f29c4, Offset: 0x2460
// Size: 0x11c
function function_bd6e70fe() {
    var_60c1e5f7 = "";
    var_49df99ed = "";
    switch (self.station) {
    case 17:
        var_60c1e5f7 = "lander_a_used";
        var_49df99ed = "COSMO_LAUNCH_PANEL_BASEENTRY_STATUS";
        break;
    case 19:
        var_60c1e5f7 = "lander_b_used";
        var_49df99ed = "COSMO_LAUNCH_PANEL_CATWALK_STATUS";
        break;
    case 21:
        var_60c1e5f7 = "lander_c_used";
        var_49df99ed = "COSMO_LAUNCH_PANEL_STORAGE_STATUS";
        break;
    }
    level notify(#"hash_7b168fce");
    level flag::set(var_60c1e5f7);
    wait(2);
    level flag::wait_till("lander_grounded");
    self clientfield::set(var_49df99ed, 1);
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_34b2435a
// Checksum 0xe60414, Offset: 0x2588
// Size: 0x16e
function enable_callboxes() {
    call_boxes = getentarray("zip_call_box", "targetname");
    lander = getent("lander", "targetname");
    for (j = 0; j < call_boxes.size; j++) {
        if (call_boxes[j].script_noteworthy != lander.station) {
            call_boxes[j] triggerenable(1);
            call_boxes[j] sethintstring(%ZM_COSMODROME_LANDER_CALL);
            continue;
        }
        call_boxes[j] triggerenable(1);
        call_boxes[j] sethintstring("");
        call_boxes[j] setcursorhint("HINT_NOICON");
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_21a92c45
// Checksum 0x4b25c1d0, Offset: 0x2700
// Size: 0x444
function function_21a92c45() {
    level.var_110c2916 = 1;
    level thread function_5f3adfa1();
    lander = getent("lander", "targetname");
    var_14fa26a9 = getent("zipline_door_n_pos", "script_noteworthy");
    var_204f913 = getent("zipline_door_s_pos", "script_noteworthy");
    lander.og_angles = lander.angles;
    var_14fa26a9.og_angles = var_14fa26a9.angles;
    var_204f913.og_angles = var_204f913.angles;
    thread function_f2e995a2(0.05);
    level flag::wait_till("initial_players_connected");
    while (!aretexturesloaded()) {
        wait(0.05);
    }
    wait(3.5);
    lander = getent("lander", "targetname");
    lander function_a81835b4();
    lander playloopsound("zmb_lander_exhaust_loop");
    lander.sound_ent = spawn("script_origin", lander.origin);
    lander.sound_ent linkto(lander);
    lander.sound_ent playsound("zmb_lander_launch");
    lander.sound_ent playloopsound("zmb_lander_flying_low_loop");
    var_b5cc0771 = struct::get("lander_station5", "targetname");
    var_20089fb6 = var_b5cc0771.origin;
    wait(1.5);
    level thread function_5dd9df7d();
    lander.anchor moveto(var_20089fb6, 8, 0.1, 7.9);
    level notify(#"hash_8f27dcf0");
    util::delay(6, undefined, &flag::set, "lander_intro_done");
    lander.anchor waittill(#"movedone");
    level.var_110c2916 = 0;
    level flag::set("lander_grounded");
    level thread namespace_9dd378ec::function_3cf7b8c9("vox_ann_startup");
    lander.sound_ent stoploopsound(3);
    lander stoploopsound(3);
    playsoundatposition("zmb_lander_land", lander.sound_ent.origin);
    function_e8434a58();
    unlock_players();
    level thread function_63c29eed();
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_5f3adfa1
// Checksum 0xe67263ca, Offset: 0x2b50
// Size: 0x84
function function_5f3adfa1() {
    trigger = getent("zip_buy", "script_noteworthy");
    trigger setcursorhint("HINT_NOICON");
    level flag::wait_till("lander_grounded");
    wait(15);
    init_buy();
}

// Namespace namespace_9d4ce396
// Params 1, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_f0c6d0e1
// Checksum 0x488991a6, Offset: 0x2be0
// Size: 0x754
function function_f0c6d0e1(dest) {
    level flag::clear("lander_grounded");
    level flag::set("lander_takeoff");
    lander = getent("lander", "targetname");
    level clientfield::set("COSMO_LANDER_STATUS_LIGHTS", 1);
    lander thread function_cb5ad6bb(dest);
    level notify(#"hash_bfb727ec", lander.riders, self);
    lander.var_bad629ca = lander.station;
    depart = getent(lander.station, "script_noteworthy");
    if (depart.target == "catwalk_zip_door") {
        level clientfield::set("COSMO_LANDER_CATWALK_BAY", 3);
    } else if (depart.target == "base_entry_zip_door") {
        level clientfield::set("COSMO_LANDER_BASE_ENTRY_BAY", 3);
    } else if (depart.target == "centrifuge_zip_door") {
        level clientfield::set("COSMO_LANDER_CENTRIFUGE_BAY", 3);
    } else if (depart.target == "storage_zip_door") {
        level clientfield::set("COSMO_LANDER_STORAGE_BAY", 3);
    }
    var_35a58eea = getentarray(depart.target, "targetname");
    for (i = 0; i < var_35a58eea.size; i++) {
        var_35a58eea[i] thread function_e71897c5();
    }
    function_f2e995a2();
    station = struct::get(lander.station, "targetname");
    var_264552c2 = struct::get(station.target, "targetname");
    level flag::clear("spawn_zombies");
    level thread function_5dd9df7d();
    wait(1);
    if (lander.called == 1) {
        lander.station = self.script_noteworthy;
    } else {
        lander.station = dest;
    }
    arrive = getent(lander.station, "script_noteworthy");
    if (isdefined(arrive.target)) {
        if (arrive.target == "catwalk_zip_door") {
            level clientfield::set("COSMO_LANDER_CATWALK_BAY", 2);
            depart thread function_5f5d494f();
        } else if (arrive.target == "base_entry_zip_door") {
            level clientfield::set("COSMO_LANDER_BASE_ENTRY_BAY", 2);
            depart thread function_5f5d494f();
        } else if (arrive.target == "centrifuge_zip_door") {
            level clientfield::set("COSMO_LANDER_CENTRIFUGE_BAY", 2);
            depart thread function_5f5d494f();
        } else if (arrive.target == "storage_zip_door") {
            level clientfield::set("COSMO_LANDER_STORAGE_BAY", 2);
            depart thread function_5f5d494f();
        }
    }
    lander.sound_ent playsound("zmb_lander_launch");
    lander.sound_ent playloopsound("zmb_lander_flying_low_loop");
    lander.anchor moveto(var_264552c2.origin, 3, 2, 1);
    lander.anchor thread function_6fbfb6ae();
    level notify(#"hash_8f27dcf0");
    level flag::clear("lander_takeoff");
    wait(3.1);
    lander clientfield::set("COSMO_LANDER_MOVE_FX", 1);
    lander.anchor function_fa20b471();
    if (isdefined(var_264552c2.target)) {
        var_5e3b4cf0 = struct::get(var_264552c2.target, "targetname");
        lander.anchor moveto(var_5e3b4cf0.origin, 2);
        lander.anchor waittill(#"movedone");
    }
    call_box = getent(lander.station, "script_noteworthy");
    call_box playsound("vox_ann_lander_current_1");
    lander clientfield::set("COSMO_LANDER_MOVE_FX", 0);
    function_c68c0d82();
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_5f5d494f
// Checksum 0xc6a57975, Offset: 0x3340
// Size: 0x104
function function_5f5d494f() {
    level flag::wait_till("lander_inuse");
    if (self.target == "catwalk_zip_door") {
        level clientfield::set("COSMO_LANDER_CATWALK_BAY", 1);
        return;
    }
    if (self.target == "base_entry_zip_door") {
        level clientfield::set("COSMO_LANDER_BASE_ENTRY_BAY", 1);
        return;
    }
    if (self.target == "centrifuge_zip_door") {
        level clientfield::set("COSMO_LANDER_CENTRIFUGE_BAY", 1);
        return;
    }
    if (self.target == "storage_zip_door") {
        level clientfield::set("COSMO_LANDER_STORAGE_BAY", 1);
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_fa20b471
// Checksum 0xfd8af888, Offset: 0x3450
// Size: 0x10c
function function_fa20b471() {
    num = self.angles[0] + randomintrange(-3, 3);
    var_8f759cfc = self.angles[1] + randomintrange(-3, 3);
    self rotateto((num, var_8f759cfc, randomfloatrange(0, 5)), 0.5);
    self moveto((self.origin[0], self.origin[1], self.origin[2] + 20), 0.5, 0.1);
    wait(0.5);
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_59e7837d
// Checksum 0x72609dd6, Offset: 0x3568
// Size: 0x308
function function_59e7837d() {
    players = getplayers();
    lander = getent("lander", "targetname");
    var_da395a8a = getent(lander.station + "_riders", "targetname");
    crumb = struct::get(var_da395a8a.target, "targetname");
    for (i = 0; i < players.size; i++) {
        if (var_da395a8a istouching(players[i])) {
            players[i] setorigin(crumb.origin + (randomintrange(-20, 20), randomintrange(-20, 20), 0));
            players[i] dodamage(players[i].health + 10000, players[i].origin);
        }
    }
    zombies = getaispeciesarray("axis");
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i])) {
            if (var_da395a8a istouching(zombies[i])) {
                level.zombie_total++;
                playsoundatposition("nuked", zombies[i].origin);
                playfx(level._effect["zomb_gib"], zombies[i].origin);
                if (isdefined(zombies[i].var_4bd2ae84)) {
                    zombies[i] [[ zombies[i].var_4bd2ae84 ]]();
                }
                zombies[i] delete();
            }
        }
    }
    wait(0.5);
}

// Namespace namespace_9d4ce396
// Params 1, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_cb5ad6bb
// Checksum 0x41d67280, Offset: 0x3878
// Size: 0x620
function function_cb5ad6bb(destination) {
    lander = getent("lander", "targetname");
    lander.riders = 0;
    spots = getentarray("zipline_spots", "script_noteworthy");
    taken = [];
    var_ab805164 = getent("zipline_door_n", "script_noteworthy");
    var_1d87c09f = getent("zipline_door_s", "script_noteworthy");
    base = getent("lander_base", "script_noteworthy");
    var_fa9e273e = [];
    var_da395a8a = getent(lander.station + "_riders", "targetname");
    crumb = struct::get(var_da395a8a.target, "targetname");
    lander thread function_dbbe88ad(undefined, 80, 1, var_da395a8a);
    lander thread function_8d996522(81, -6);
    players = getplayers();
    var_6c4c1630 = getent("zip_buy", "script_noteworthy");
    x = 0;
    while (!level flag::get("lander_grounded")) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (!var_da395a8a istouching(players[i]) && !players[i] istouching(var_ab805164) && !players[i] istouching(var_1d87c09f) && !players[i] istouching(base) && x < 8) {
                continue;
            }
            if (!players[i] istouching(var_6c4c1630)) {
                continue;
            }
            if (isdefined(players[i].lander) && players[i].lander) {
                continue;
            }
            max_dist = 10000;
            var_3fa6c0a7 = -1;
            for (j = 0; j < 4; j++) {
                if (isdefined(taken[j]) && taken[j] == 1) {
                    continue;
                }
                dist = distance2d(players[i].origin, spots[j].origin);
                if (dist < max_dist) {
                    max_dist = dist;
                    var_3fa6c0a7 = j;
                }
            }
            taken[var_3fa6c0a7] = 1;
            if (players[i] laststand::player_is_in_laststand()) {
                players[i] thread function_e323fa97();
            }
            players[i] playerlinktodelta(spots[var_3fa6c0a7], undefined, 1, -76, -76, -76, -76, 1);
            players[i] enableinvulnerability();
            players[i] thread zm::function_9ca63ef4(crumb.origin);
            players[i].lander = 1;
            players[i].var_ef97b179 = spots[var_3fa6c0a7];
            players[i] clientfield::set("COSMO_PLAYER_LANDER_FOG", 1);
            lander.riders++;
        }
        wait(0.25);
        x++;
        if (x == 4) {
            if (lander.riders == players.size) {
                level thread function_c1f96b46(destination);
            }
        }
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_e323fa97
// Checksum 0x238e2495, Offset: 0x3ea0
// Size: 0xe4
function function_e323fa97() {
    self endon(#"bled_out");
    self.on_lander_last_stand = 1;
    self allowcrouch(0);
    self allowstand(0);
    self.lander = 1;
    while (self.lander === 1 && self laststand::player_is_in_laststand()) {
        wait(0.05);
    }
    self.on_lander_last_stand = undefined;
    self allowcrouch(1);
    self allowstand(1);
    self setstance("stand");
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_a81835b4
// Checksum 0xd7a73ab1, Offset: 0x3f90
// Size: 0x236
function function_a81835b4() {
    lander = getent("lander", "targetname");
    lander.riders = 0;
    spots = getentarray("zipline_spots", "script_noteworthy");
    players = getplayers();
    taken = [];
    var_da395a8a = getent("lander_in_sky_riders", "targetname");
    crumb = struct::get(var_da395a8a.target, "targetname");
    for (i = 0; i < players.size; i++) {
        var_3fa6c0a7 = -1;
        for (j = 0; j < 4; j++) {
            if (isdefined(taken[j]) && taken[j] == 1) {
                continue;
            }
            var_3fa6c0a7 = j;
        }
        taken[var_3fa6c0a7] = 1;
        players[i] playerlinkto(spots[var_3fa6c0a7], undefined, 0, -76, -76, -76, -76, 1);
        players[i] enableinvulnerability();
        players[i].lander = 1;
        lander.riders++;
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_6f381e3e
// Checksum 0x51c79b78, Offset: 0x41d0
// Size: 0x1d2
function unlock_players() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] unlink();
        players[i] disableinvulnerability();
        players[i].on_lander_last_stand = undefined;
        /#
            if (getdvarint("lander") >= 1 && getdvarint("lander") <= 3) {
                players[i] enableinvulnerability();
            }
        #/
        players[i] thread zm::function_9ca63ef4(players[i].origin);
        players[i].lander = 0;
    }
    lander = getent("lander", "targetname");
    if (isdefined(lander.driver) && lander.driver zombie_utility::is_zombie()) {
        lander.driver unlink();
        lander.driver = undefined;
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_c68c0d82
// Checksum 0x637c4718, Offset: 0x43b0
// Size: 0x9cc
function function_c68c0d82() {
    level endon(#"intermission");
    lander = getent("lander", "targetname");
    final_dest = struct::get(lander.station, "targetname");
    arrive = getent(lander.station, "script_noteworthy");
    if (isdefined(final_dest.target)) {
        var_ae271447 = struct::get(final_dest.target, "targetname");
        if (isdefined(var_ae271447.target)) {
            lander.anchor thread function_9aed2b6c(lander, final_dest);
            var_5e3b4cf0 = struct::get(var_ae271447.target, "targetname");
            lander.anchor moveto(var_5e3b4cf0.origin, 5, 1);
            lander.anchor waittill(#"movedone");
            function_31b150fd(lander.anchor.origin, -106);
            lander.anchor moveto(var_ae271447.origin, 2, 0, 2);
            lander.anchor waittill(#"movedone");
        } else {
            lander.anchor thread function_9aed2b6c(lander, final_dest);
            lander.anchor moveto(var_ae271447.origin, 7, 1, 2.75);
            lander.anchor waittill(#"movedone");
        }
    }
    function_31b150fd(lander.anchor.origin, -106);
    level flag::wait_till("lander_landing");
    movetime = 5;
    acceltime = 0.1;
    deceltime = 4.9;
    var_5021702 = "";
    if (isdefined(arrive.target)) {
        if (arrive.target == "catwalk_zip_door") {
            level clientfield::set("COSMO_LANDER_CATWALK_BAY", 3);
            var_5021702 = "lgt_exp_padup_catwalk";
        } else if (arrive.target == "base_entry_zip_door") {
            movetime = 6;
            acceltime = 0.1;
            deceltime = 5.9;
            level clientfield::set("COSMO_LANDER_BASE_ENTRY_BAY", 3);
            var_5021702 = "lgt_exp_padup_base_entry";
        } else if (arrive.target == "centrifuge_zip_door") {
            movetime = 7;
            acceltime = 0.1;
            deceltime = 6.9;
            level clientfield::set("COSMO_LANDER_CENTRIFUGE_BAY", 3);
            var_5021702 = "lgt_exp_padup_centrifuge";
        } else if (arrive.target == "storage_zip_door") {
            movetime = 6;
            acceltime = 0.1;
            deceltime = 5.9;
            level clientfield::set("COSMO_LANDER_STORAGE_BAY", 3);
            var_5021702 = "lgt_exp_padup_storage";
        }
    }
    if (var_5021702 != "") {
        exploder::exploder(var_5021702);
    }
    var_90ddb17 = getentarray(arrive.target, "targetname");
    for (i = 0; i < var_90ddb17.size; i++) {
        var_90ddb17[i] thread function_e11b107(1);
    }
    lander.anchor moveto(final_dest.origin, movetime, acceltime, deceltime);
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i].lander) {
            players[i] clientfield::set("COSMO_PLAYER_LANDER_FOG", 0);
        }
    }
    lander.anchor thread function_4c38d0bd(movetime);
    level thread function_59e7837d();
    lander.anchor waittill(#"movedone");
    lander.sound_ent stoploopsound(1);
    lander stoploopsound(3);
    playsoundatposition("zmb_lander_land", lander.origin);
    function_d0c617aa();
    level flag::set("lander_grounded");
    level flag::clear("lander_landing");
    level flag::set("spawn_zombies");
    function_e8434a58();
    unlock_players();
    level.var_fb331fc7 = 0;
    lander.called = 0;
    if (isdefined(arrive.target)) {
        switch (arrive.target) {
        case 72:
            level clientfield::set("COSMO_LANDER_STATION", 2);
            level clientfield::set("COSMO_LANDER_CATWALK_BAY", 0);
            break;
        case 73:
            level clientfield::set("COSMO_LANDER_STATION", 3);
            level clientfield::set("COSMO_LANDER_BASE_ENTRY_BAY", 0);
            break;
        case 74:
            level clientfield::set("COSMO_LANDER_STATION", 4);
            level clientfield::set("COSMO_LANDER_CENTRIFUGE_BAY", 0);
            break;
        case 76:
            level clientfield::set("COSMO_LANDER_STATION", 1);
            level clientfield::set("COSMO_LANDER_STORAGE_BAY", 0);
            break;
        }
    }
    if (level flag::get("lander_a_used") && level flag::get("lander_b_used") && level flag::get("lander_c_used") && !level flag::get("launch_activated")) {
        level flag::set("launch_activated");
    }
    if (var_5021702 != "") {
        wait(1);
        exploder::kill_exploder(var_5021702);
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_5dd9df7d
// Checksum 0x75d067e9, Offset: 0x4d88
// Size: 0x10c
function function_5dd9df7d() {
    var_756db0f9 = getent("lander_base", "script_noteworthy");
    var_756db0f9 clientfield::set("COSMO_LANDER_ENGINE_FX", 1);
    var_756db0f9 clientfield::set("COSMO_LANDER_RUMBLE_AND_QUAKE", 1);
    level flag::wait_till("lander_grounded");
    var_756db0f9 clientfield::set("COSMO_LANDER_RUMBLE_AND_QUAKE", 0);
    wait(2.5);
    playfx(level._effect["lunar_lander_dust"], var_756db0f9.origin);
    var_756db0f9 clientfield::set("COSMO_LANDER_ENGINE_FX", 0);
}

// Namespace namespace_9d4ce396
// Params 4, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_dbbe88ad
// Checksum 0x4ab8f159, Offset: 0x4ea0
// Size: 0x12c
function function_dbbe88ad(var_728eaa61, range, delay, trig) {
    if (isdefined(delay)) {
        wait(delay);
    }
    zombies = getaispeciesarray("axis");
    spot = self.origin;
    zombies = util::get_array_of_closest(self.origin, zombies, undefined, var_728eaa61, range);
    for (i = 0; i < zombies.size; i++) {
        if (!zombies[i] istouching(trig)) {
            continue;
        }
        zombies[i] thread function_634cc874();
    }
    wait(0.5);
    function_31b150fd(spot, -6);
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_634cc874
// Checksum 0x2b146bc3, Offset: 0x4fd8
// Size: 0xb4
function function_634cc874() {
    self endon(#"death");
    wait(randomfloatrange(0.2, 0.3));
    level.zombie_total++;
    playsoundatposition("nuked", self.origin);
    playfx(level._effect["zomb_gib"], self.origin);
    if (isdefined(self.var_4bd2ae84)) {
        self [[ self.var_4bd2ae84 ]]();
    }
    self delete();
}

// Namespace namespace_9d4ce396
// Params 2, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_8d996522
// Checksum 0x24c74af2, Offset: 0x5098
// Size: 0xde
function function_8d996522(var_f2af12bd, max_range) {
    zombies = getaispeciesarray("axis");
    for (i = 0; i < zombies.size; i++) {
        dist = distancesquared(zombies[i].origin, self.origin);
        if (dist >= var_f2af12bd * var_f2af12bd && dist <= max_range * max_range) {
            zombies[i] thread zombie_knockdown();
        }
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_6db68516
// Checksum 0xb3380a79, Offset: 0x5180
// Size: 0x8c
function zombie_knockdown() {
    self endon(#"death");
    wait(randomfloatrange(0.2, 0.3));
    self.var_1474da36 = 1;
    if (isdefined(self.thundergun_knockdown_func)) {
        self [[ self.thundergun_knockdown_func ]](self, 0);
    }
    self.thundergun_handle_pain_notetracks = &zm_weap_thundergun::handle_thundergun_pain_notetracks;
    self dodamage(1, self.origin);
}

// Namespace namespace_9d4ce396
// Params 2, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_31b150fd
// Checksum 0x8459ba80, Offset: 0x5218
// Size: 0xb6
function function_31b150fd(spot, range) {
    corpses = getcorpsearray();
    if (isdefined(corpses)) {
        for (i = 0; i < corpses.size; i++) {
            if (distancesquared(spot, corpses[i].origin) <= range * range) {
                corpses[i] thread function_7c569fb4();
            }
        }
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_7c569fb4
// Checksum 0xefdf9c8f, Offset: 0x52d8
// Size: 0x74
function function_7c569fb4() {
    wait(randomfloatrange(0.05, 0.25));
    if (!isdefined(self)) {
        return;
    }
    playfx(level._effect["zomb_gib"], self.origin);
    self delete();
}

// Namespace namespace_9d4ce396
// Params 2, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_9aed2b6c
// Checksum 0x118c00ce, Offset: 0x5358
// Size: 0x3fe
function function_9aed2b6c(lander, final_dest) {
    self thread function_c914fbad();
    self endon(#"movedone");
    self endon(#"hash_fdd25b82");
    first_time = 1;
    var_16d20f68 = 0.75;
    while (true) {
        if (first_time) {
            var_16d20f68 = 1.75;
        }
        if (lander.var_bad629ca == "lander_station5" && final_dest.targetname == "lander_station1") {
            self rotateto((randomfloatrange(345, 355), 0, randomfloatrange(0, 5)), var_16d20f68);
        } else if (lander.var_bad629ca == "lander_station1" && final_dest.targetname == "lander_station5") {
            self rotateto((randomfloatrange(370, 380), 0, randomfloatrange(-5, 0)), var_16d20f68);
        } else if (lander.var_bad629ca == "lander_station5" && final_dest.targetname == "lander_station4") {
            self rotateto((randomfloatrange(370, 380), 0, randomfloatrange(-5, 0)), var_16d20f68);
        } else if (lander.var_bad629ca == "lander_station4" && final_dest.targetname == "lander_station5") {
            self rotateto((randomfloatrange(345, 355), 0, randomfloatrange(0, 5)), var_16d20f68);
        } else if (lander.var_bad629ca == "lander_station5" && final_dest.targetname == "lander_station3") {
            self rotateto((randomfloatrange(5, 10), 0, randomfloatrange(-15, -10)), var_16d20f68);
        } else if (lander.var_bad629ca == "lander_station3" && final_dest.targetname == "lander_station5") {
            self rotateto((randomfloatrange(-10, -5), 0, randomfloatrange(10, 15)), var_16d20f68);
        } else {
            self rotateto((randomfloatrange(-5, 5), 0, randomfloatrange(-5, 5)), var_16d20f68);
        }
        wait(var_16d20f68);
        if (first_time) {
            first_time = 0;
        }
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_6fbfb6ae
// Checksum 0x2510ace8, Offset: 0x5760
// Size: 0x70
function function_6fbfb6ae() {
    level endon(#"hash_8f27dcf0");
    while (true) {
        self rotateto((randomfloatrange(-10, 10), 0, randomfloatrange(-10, 10)), 0.5);
        wait(0.5);
    }
}

// Namespace namespace_9d4ce396
// Params 1, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_4c38d0bd
// Checksum 0x7fb51ad2, Offset: 0x57d8
// Size: 0xcc
function function_4c38d0bd(movetime) {
    time = movetime - 1;
    timer = gettime() + time * 1000;
    while (gettime() < timer) {
        self rotateto((randomfloatrange(-5, 5), 0, randomfloatrange(-5, 5)), 0.75);
        wait(0.75);
    }
    self rotateto((0, 0, 0), 0.75);
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_c914fbad
// Checksum 0xbb66eddb, Offset: 0x58b0
// Size: 0xc4
function function_c914fbad() {
    wait(3);
    self notify(#"hash_fdd25b82");
    self.old_angles = self.angles;
    self rotateto((self.angles[0] * -1, self.angles[1] * -1, self.angles[2] * -1), 2.75);
    wait(3);
    self rotateto(self.old_angles, 2);
    level flag::set("lander_landing");
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_9be6c7d0
// Checksum 0x8fd287b1, Offset: 0x5980
// Size: 0x698
function function_9be6c7d0() {
    var_96eed5ac = getent("zip_buy", "script_noteworthy");
    var_af727de5 = getentarray("zip_call_box", "targetname");
    lander = getent("lander", "targetname");
    while (true) {
        riders, trig = level waittill(#"hash_bfb727ec");
        level flag::set("lander_inuse");
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            var_96eed5ac setinvisibletoplayer(players[i], 1);
        }
        for (i = 0; i < var_af727de5.size; i++) {
            if (var_af727de5[i] == trig) {
                var_af727de5[i] sethintstring(%ZM_COSMODROME_LANDER_ON_WAY);
                var_af727de5[i] setcursorhint("HINT_NOICON");
                continue;
            }
            var_af727de5[i] sethintstring(%ZM_COSMODROME_LANDER_IN_USE);
            var_af727de5[i] setcursorhint("HINT_NOICON");
        }
        while (level.var_fb331fc7) {
            wait(0.1);
        }
        level flag::clear("lander_inuse");
        level flag::set("lander_cooldown");
        cooldown = 3;
        str = %ZM_COSMODROME_LANDER_COOLDOWN;
        if (riders != 0) {
            cooldown = 30;
            str = %ZM_COSMODROME_LANDER_REFUEL;
            for (i = 0; i < var_af727de5.size; i++) {
                var_af727de5[i] playsound("vox_ann_lander_cooldown");
            }
            lander playsound("zmb_lander_pump_start");
            lander playloopsound("zmb_lander_pump_loop", 1);
        }
        var_96eed5ac sethintstring(str);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            var_96eed5ac setinvisibletoplayer(players[i], 0);
        }
        for (i = 0; i < var_af727de5.size; i++) {
            if (var_af727de5[i].script_noteworthy != lander.station) {
                var_af727de5[i] sethintstring(str);
                continue;
            }
            var_af727de5[i] sethintstring(%ZM_COSMODROME_LANDER_AT_STATION);
            var_af727de5[i] setcursorhint("HINT_NOICON");
        }
        if (!isdefined(level.var_a1879e28) || level.var_a1879e28) {
            wait(cooldown);
        } else {
            wait(1);
        }
        lander stoploopsound(1.5);
        lander playsound("zmb_lander_pump_end");
        if (cooldown == 30) {
            for (i = 0; i < var_af727de5.size; i++) {
                var_af727de5[i] playsound("vox_ann_lander_ready");
            }
        }
        level clientfield::set("COSMO_LANDER_STATUS_LIGHTS", 2);
        var_96eed5ac sethintstring(%ZM_COSMODROME_LANDER, -6);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            var_96eed5ac setinvisibletoplayer(players[i], 0);
        }
        for (i = 0; i < var_af727de5.size; i++) {
            if (var_af727de5[i].script_noteworthy != lander.station) {
                var_af727de5[i] sethintstring(%ZM_COSMODROME_LANDER_CALL);
                continue;
            }
            var_af727de5[i] sethintstring(%ZM_COSMODROME_LANDER_AT_STATION);
            var_af727de5[i] setcursorhint("HINT_NOICON");
        }
        level flag::clear("lander_cooldown");
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_71f10e60
// Checksum 0x54871d5, Offset: 0x6020
// Size: 0xbc
function function_71f10e60() {
    while (true) {
        level flag::wait_till("lander_grounded");
        if (level flag::get("lander_a_used") && level flag::get("lander_b_used") && level flag::get("lander_c_used")) {
            level thread namespace_9dd378ec::function_3cf7b8c9("vox_ann_landers_used");
            return;
        }
        wait(0.05);
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_63c29eed
// Checksum 0x72f10bd4, Offset: 0x60e8
// Size: 0x2c
function function_63c29eed() {
    wait(10);
    level thread namespace_f23e8c1a::function_321f0d6f(undefined, "vox_gersh_egg_start", 0);
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_d0c617aa
// Checksum 0x78712dfd, Offset: 0x6120
// Size: 0x14e
function function_d0c617aa() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (!(isdefined(players[i].lander) && players[i].lander) && !(isdefined(players[i].on_lander_last_stand) && players[i].on_lander_last_stand)) {
            continue;
        }
        if (!players[i] function_e61901a6()) {
            if (isdefined(players[i].var_ef97b179)) {
                players[i] setorigin(players[i].var_ef97b179.origin);
                players[i] playsound("zmb_laugh_child");
            }
        }
    }
}

// Namespace namespace_9d4ce396
// Params 0, eflags: 0x1 linked
// namespace_9d4ce396<file_0>::function_e61901a6
// Checksum 0x5db606b8, Offset: 0x6278
// Size: 0x13c
function function_e61901a6() {
    lander = getent("lander", "targetname");
    var_da395a8a = getent(lander.station + "_riders", "targetname");
    var_6c4c1630 = getent("zip_buy", "script_noteworthy");
    base = getent("lander_base", "script_noteworthy");
    if (var_da395a8a istouching(self) || self istouching(var_6c4c1630) || distance(self.origin, base.origin) < -56) {
        return true;
    }
    return false;
}

