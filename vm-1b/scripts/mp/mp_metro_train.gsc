#using scripts/codescripts/struct;
#using scripts/mp/_events;
#using scripts/mp/_util;
#using scripts/mp/gametypes/ctf;
#using scripts/mp/killstreaks/_supplydrop;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace mp_metro_train;

// Namespace mp_metro_train
// Params 0, eflags: 0x0
// Checksum 0x8b7f616e, Offset: 0x738
// Size: 0x492
function init() {
    level.var_a3275b98 = [];
    level.var_86638a28 = [];
    start1 = getvehiclenode("train_start_1", "targetname");
    start2 = getvehiclenode("train_start_2", "targetname");
    var_702434a5 = [];
    var_9626af0e = [];
    var_db3e7a5c = [];
    var_4d45e997 = [];
    function_c5b797fc(var_702434a5, var_db3e7a5c, start1, "train1");
    function_c5b797fc(var_9626af0e, var_4d45e997, start2, "train2");
    var_c7297b2b = getentarray("metro_doors_inside_left", "targetname");
    var_fe680264 = getentarray("metro_doors_outside_left", "targetname");
    var_c3f0dd82 = getentarray("metro_doors_end_left", "targetname");
    var_1ec2db3f = struct::get_array("metro_train_track_vox_left");
    var_7ce6af9e = getentarray("metro_doors_inside_right", "targetname");
    var_5159825b = getentarray("metro_doors_outside_right", "targetname");
    var_e1604af1 = getentarray("metro_doors_end_right", "targetname");
    var_f66166da = struct::get_array("metro_train_track_vox_right");
    var_d1439c1d = getent("train_killtrigger_left", "targetname");
    var_7d375500 = getent("train_killtrigger_right", "targetname");
    var_fe600fa3 = getent("train_killtrigger_left_end", "targetname");
    var_fe18c116 = getent("train_killtrigger_right_end", "targetname");
    var_e91b1c22 = getentarray("mp_metro_platform_edge_left", "targetname");
    var_c318a1b9 = getentarray("mp_metro_platform_edge_right", "targetname");
    level._effect["fx_light_red_train_track_warning"] = "light/fx_light_red_train_track_warning";
    level._effect["fx_water_train_mist_kick_up_metro"] = "water/fx_water_train_mist_kick_up_metro";
    waittillframeend();
    if (level.timelimit) {
        seconds = level.timelimit * 60;
        events::add_timed_event(int(seconds * 0.25), "train_start_1");
        events::add_timed_event(int(seconds * 0.75), "train_start_2");
    } else if (level.scorelimit) {
        events::add_score_event(int(level.scorelimit * 0.25), "train_start_1");
        events::add_score_event(int(level.scorelimit * 0.75), "train_start_2");
    }
    wait 1;
    if (level.gametype == "escort") {
        return;
    }
    level thread function_91ce410(var_702434a5, var_db3e7a5c, "train_start_1", start1, var_c7297b2b, var_fe680264, var_c3f0dd82, var_e91b1c22, var_7d375500, var_fe18c116, var_f66166da, "right");
    level thread function_91ce410(var_9626af0e, var_4d45e997, "train_start_2", start2, var_7ce6af9e, var_5159825b, var_e1604af1, var_c318a1b9, var_d1439c1d, var_fe600fa3, var_1ec2db3f, "left");
}

// Namespace mp_metro_train
// Params 2, eflags: 0x0
// Checksum 0x8abbde74, Offset: 0xbd8
// Size: 0x62
function function_c19bbc3e(gate, var_8d1e404b) {
    gate setmovingplatformenabled(1);
    gate.var_8d1e404b = var_8d1e404b;
    gate.var_8d1e404b enablelinkto();
    gate.var_8d1e404b linkto(gate);
}

// Namespace mp_metro_train
// Params 4, eflags: 0x0
// Checksum 0x5e5dfb57, Offset: 0xc48
// Size: 0x1c9
function function_c5b797fc(&cars, &var_c4643bb7, start, name) {
    cars[0] = spawnvehicle("train_test_mp", (0, -2000, -200), (0, 0, 0), name);
    cars[0] setteam("neutral");
    cars[0] ghost();
    cars[0].ismagicbullet = 1;
    var_9807fb5d = getdvarint("train_length", 10);
    for (i = 1; i < var_9807fb5d; i++) {
        if (i == var_9807fb5d - 1) {
            cars[i] = spawn("script_model", (0, -2000, -200));
            cars[i] setmodel("p7_zur_metro_train_cab_module");
            cars[i].var_48adb15 = 1;
        } else {
            cars[i] = spawn("script_model", (0, -2000, -200));
            cars[i] setmodel("p7_zur_metro_train_car_module");
        }
        cars[i] ghost();
        var_c4643bb7[i] = spawn("script_model", (0, -2000, -200));
        var_c4643bb7[i] setmodel("p7_zur_metro_train_divider");
        var_c4643bb7[i] ghost();
    }
}

// Namespace mp_metro_train
// Params 1, eflags: 0x0
// Checksum 0x1ffeb74d, Offset: 0xe20
// Size: 0x1a
function function_656e58c3(time) {
    wait time;
    self show();
}

// Namespace mp_metro_train
// Params 5, eflags: 0x0
// Checksum 0x7f1769a1, Offset: 0xe48
// Size: 0x123
function function_1b3e50b5(var_50a9e5d9, waittime, rotatetime, var_b646c3f4, var_8efac8e4) {
    skip = var_8efac8e4;
    foreach (var_4a3ded66 in var_50a9e5d9) {
        if (!skip) {
            var_4a3ded66 rotateto(var_4a3ded66.originalangles + var_b646c3f4, rotatetime);
            wait waittime;
        }
        skip = !skip;
    }
    foreach (var_4a3ded66 in var_50a9e5d9) {
        if (!skip) {
            var_4a3ded66 rotateto(var_4a3ded66.originalangles + var_b646c3f4, rotatetime);
            wait waittime;
        }
        skip = !skip;
    }
}

// Namespace mp_metro_train
// Params 12, eflags: 0x0
// Checksum 0xc0edcbc8, Offset: 0xf78
// Size: 0x8fd
function function_91ce410(cars, var_c4643bb7, var_c7166e37, start, var_c3f523d4, var_35fc930f, var_9071646e, var_fbb2796a, var_4eb99366, var_5f47c084, var_c4ecec2, var_4b395157) {
    level endon(#"game_ended");
    foreach (gate in var_c3f523d4) {
        gate.originalangles = gate.angles;
    }
    foreach (gate in var_35fc930f) {
        gate.originalangles = gate.angles;
    }
    foreach (gate in var_9071646e) {
        gate.originalangles = gate.angles;
    }
    foreach (barrier in var_fbb2796a) {
        barrier.originalorigin = barrier.origin;
    }
    var_ddb7f7d7 = (0, 90, 0);
    if (var_4b395157 == "left") {
        var_ddb7f7d7 *= -1;
    }
    for (;;) {
        level waittill(var_c7166e37);
        foreach (speaker in var_c4ecec2) {
            playsoundatposition("vox_metr_metro_approaching", speaker.origin);
        }
        metro_vox_wait_time = getdvarfloat("metro_vox_wait_time", 4);
        wait metro_vox_wait_time;
        gate_move_time = getdvarfloat("gate_move_time", 2);
        gate_end_move_time = getdvarfloat("gate_end_move_time", 1);
        var_b909fdbf = getdvarfloat("gate_wait_time", 0.3);
        var_c3f523d4[0] playloopsound("amb_train_alarm");
        var_35fc930f[0] playloopsound("amb_train_alarm");
        barrier_move_time = getdvarfloat("barrier_move_time", 2);
        barrier_move_height = getdvarfloat("barrier_move_height", 30);
        foreach (barrier in var_fbb2796a) {
            barrier moveto(barrier.origin + (0, 0, barrier_move_height), barrier_move_time);
            barrier playsound("evt_wall_up");
        }
        gate_wait_train_time = getdvarfloat("gate_wait_train_time", 5);
        wait gate_wait_train_time;
        cars[0] attachpath(start);
        cars[0] startpath();
        cars[0] function_656e58c3(0.1);
        cars[0] thread function_b08d0f63(var_4b395157);
        cars[0] playloopsound("amb_train_by");
        var_9807fb5d = getdvarint("train_length", 10);
        for (i = 1; i < var_9807fb5d; i++) {
            wait 0.3;
            var_c4643bb7[i] thread function_881473ff(var_4b395157);
            var_c4643bb7[i] thread function_ac1ac4d2();
            wait 0.3;
            cars[i] thread function_881473ff(var_4b395157);
            cars[i] thread function_ac1ac4d2();
            cars[i] playloopsound("amb_train_by");
        }
        foreach (speaker in var_c4ecec2) {
            playsoundatposition("vox_metr_metro_gap", speaker.origin);
        }
        level thread function_1b3e50b5(var_9071646e, 1, gate_end_move_time, var_ddb7f7d7 * -1, 0);
        var_9071646e[0] playsound("evt_gate_open");
        var_5f47c084 function_a202446a(0, 0, gate_end_move_time);
        level thread function_1b3e50b5(var_c3f523d4, var_b909fdbf, gate_move_time, var_ddb7f7d7, 0);
        var_c3f523d4[0] playsound("evt_gate_open");
        level thread function_1b3e50b5(var_35fc930f, var_b909fdbf, gate_move_time, var_ddb7f7d7, 1);
        var_35fc930f[0] playsound("evt_gate_open");
        var_4eb99366 function_a202446a(1, 0, gate_move_time);
        wait getdvarfloat("gate_wait_close_door_end", 8);
        level thread function_1b3e50b5(var_9071646e, 1, gate_move_time, (0, 0, 0), 0);
        var_9071646e[0] playsound("evt_gate_close");
        var_5f47c084 function_a202446a(0, 0, gate_move_time);
        wait getdvarfloat("gate_wait_close_doors", 4);
        level thread function_1b3e50b5(var_c3f523d4, var_b909fdbf, gate_move_time, (0, 0, 0), 0);
        var_c3f523d4[0] playsound("evt_gate_close");
        level thread function_1b3e50b5(var_35fc930f, var_b909fdbf, gate_move_time, (0, 0, 0), 1);
        var_35fc930f[0] playsound("evt_gate_close");
        var_4eb99366 function_a202446a(0, 0, gate_move_time);
        var_4eb99366 function_a202446a(1, gate_move_time, 0.25);
        foreach (barrier in var_fbb2796a) {
            barrier moveto(barrier.originalorigin, barrier_move_time);
            barrier playsound("evt_wall_down");
        }
        var_c3f523d4[0] stoploopsound(2);
        var_35fc930f[0] stoploopsound(2);
        cars[0] waittill(#"reached_end_node");
        cars[0] stoploopsound(2);
        for (i = 1; i < var_9807fb5d; i++) {
            cars[i] ghost();
            cars[i] notify(#"hash_cc35a648");
            var_c4643bb7[i] ghost();
            var_c4643bb7[i] notify(#"hash_cc35a648");
            cars[i] stoploopsound(2);
        }
        cars[0] notify(#"hash_cc35a648");
        cars[0] ghost();
    }
}

// Namespace mp_metro_train
// Params 1, eflags: 0x0
// Checksum 0xbf48b89a, Offset: 0x1880
// Size: 0x215
function function_b08d0f63(tracknum) {
    self endon(#"reached_end_node");
    level.var_a3275b98[tracknum] = [];
    level.var_86638a28[tracknum] = [];
    if (tracknum == "left") {
        var_d5a44988 = getdvarint("train_position_start_water_left", -51);
        var_b8428bfa = getdvarint("train_dust_kickup_1_left", -106);
        var_92401191 = getdvarint("train_dust_kickup_2_left", -82);
        var_6c3d9728 = getdvarint("train_dust_kickup_3_left", -56);
    } else {
        var_d5a44988 = getdvarint("train_position_start_water_right", -51);
        var_b8428bfa = getdvarint("train_dust_kickup_1_right", -106);
        var_92401191 = getdvarint("train_dust_kickup_1_right", -82);
        var_6c3d9728 = getdvarint("train_dust_kickup_1_right", -56);
    }
    for (;;) {
        level.var_a3275b98[tracknum][level.var_a3275b98[tracknum].size] = self.origin;
        level.var_86638a28[tracknum][level.var_86638a28[tracknum].size] = self.angles;
        if (level.var_86638a28[tracknum].size == var_d5a44988) {
            playfxontag(level._effect["fx_water_train_mist_kick_up_metro"], self, "tag_origin");
        } else if (level.var_86638a28[tracknum].size == var_b8428bfa) {
            level thread function_d196b0a5(1, tracknum);
        } else if (level.var_86638a28[tracknum].size == var_92401191) {
            level thread function_d196b0a5(2, tracknum);
        } else if (level.var_86638a28[tracknum].size == var_6c3d9728) {
            level thread function_d196b0a5(3, tracknum);
        }
        wait 0.05;
    }
}

// Namespace mp_metro_train
// Params 2, eflags: 0x0
// Checksum 0xd9707d31, Offset: 0x1aa0
// Size: 0x5a
function function_d196b0a5(index, var_4b395157) {
    explodername = "Train_dust_kickup_" + index + "_" + var_4b395157;
    exploder::exploder(explodername);
    wait 5.5;
    exploder::stop_exploder(explodername);
}

// Namespace mp_metro_train
// Params 1, eflags: 0x0
// Checksum 0xbbc1585d, Offset: 0x1b08
// Size: 0x131
function function_881473ff(tracknum) {
    self endon(#"hash_cc35a648");
    if (tracknum == "left") {
        var_d5a44988 = getdvarint("train_position_start_water_left", -51);
    } else {
        var_d5a44988 = getdvarint("train_position_start_water_right", -51);
    }
    for (i = 0; i < level.var_a3275b98[tracknum].size; i++) {
        if (i == var_d5a44988) {
            playfxontag(level._effect["fx_water_train_mist_kick_up_metro"], self, "tag_origin");
        }
        self.origin = level.var_a3275b98[tracknum][i];
        self.angles = level.var_86638a28[tracknum][i];
        if (isdefined(self.var_48adb15) && self.var_48adb15 == 1) {
            self.angles = self.angles + (0, 180, 0);
        }
        wait 0.05;
        if (i == 4) {
            self show();
        }
    }
}

// Namespace mp_metro_train
// Params 0, eflags: 0x0
// Checksum 0x498075ca, Offset: 0x1c48
// Size: 0x85
function function_ac1ac4d2() {
    self endon(#"hash_9d4a1ae0");
    self endon(#"hash_cc35a648");
    self endon(#"delete");
    self endon(#"death");
    self.disablefinalkillcam = 1;
    for (;;) {
        self waittill(#"touch", entity);
        if (isplayer(entity)) {
            entity dodamage(entity.health * 2, self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
        }
    }
}

// Namespace mp_metro_train
// Params 0, eflags: 0x0
// Checksum 0xd577c3ac, Offset: 0x1cd8
// Size: 0x10c
function function_2d719a60() {
    var_38eefca7 = getent("MP_Metro_clock_1", "targetname");
    var_c6e78d6c = getent("MP_Metro_clock_2", "targetname");
    if (!isdefined(var_38eefca7) || !isdefined(var_c6e78d6c)) {
        return false;
    }
    level.var_70ab9de1 = util::spawn_model("tag_origin", var_38eefca7.origin, var_38eefca7.angles);
    level.var_70ab9de1 clientfield::set("mp_metro_train_timer", 1);
    level.var_96ae184a = util::spawn_model("tag_origin", var_c6e78d6c.origin, var_c6e78d6c.angles);
    level.var_96ae184a clientfield::set("mp_metro_train_timer", 1);
    return true;
}

// Namespace mp_metro_train
// Params 3, eflags: 0x0
// Checksum 0x4f95b366, Offset: 0x1df0
// Size: 0x4e5
function function_a202446a(var_6b9180f5, waittime, var_24d445fd) {
    self endon(#"hash_e0b163fa");
    self.disablefinalkillcam = 1;
    door = self;
    var_cd78fc15 = 0;
    if (waittime > 0) {
        wait waittime;
    }
    var_791e12da = 0;
    while (var_24d445fd > var_791e12da) {
        wait 0.2;
        var_791e12da += 0.2;
        entities = getdamageableentarray(self.origin, -56);
        foreach (entity in entities) {
            if (!entity istouching(self)) {
                continue;
            }
            if (!isalive(entity)) {
                continue;
            }
            if (isdefined(entity.targetname)) {
                if (entity.targetname == "talon") {
                    entity notify(#"death");
                    continue;
                }
            }
            if (isdefined(entity.helitype) && entity.helitype == "qrdrone") {
                watcher = entity.owner weaponobjects::getweaponobjectwatcher("qrdrone");
                watcher thread weaponobjects::waitanddetonate(entity, 0, undefined);
                continue;
            }
            if (entity.classname == "grenade") {
                if (!isdefined(entity.name)) {
                    continue;
                }
                if (!isdefined(entity.owner)) {
                    continue;
                }
                if (entity.name == "proximity_grenade_mp") {
                    watcher = entity.owner weaponobjects::getwatcherforweapon(entity.name);
                    watcher thread weaponobjects::waitanddetonate(entity, 0, undefined, "script_mover_mp");
                    continue;
                }
                if (!entity.isequipment) {
                    continue;
                }
                watcher = entity.owner weaponobjects::getwatcherforweapon(entity.name);
                if (!isdefined(watcher)) {
                    continue;
                }
                watcher thread weaponobjects::waitanddetonate(entity, 0, undefined, "script_mover_mp");
                continue;
            }
            if (entity.classname == "auto_turret") {
                if (!isdefined(entity.damagedtodeath) || !entity.damagedtodeath) {
                    entity util::domaxdamage(self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
                }
                continue;
            }
            if (!isdefined(entity.team) || isvehicle(entity) && entity.team != "neutral") {
                entity kill();
                continue;
            }
            if (var_6b9180f5 == 0 && isplayer(entity)) {
                continue;
            }
            entity dodamage(entity.health * 2, self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
            if (isplayer(entity)) {
                var_cd78fc15 = gettime() + 1000;
            }
        }
        self function_efb0f9a4();
        if (gettime() > var_cd78fc15) {
            self function_dde749cf();
        }
        if (level.gametype == "ctf") {
            foreach (flag in level.flags) {
                if (flag.visuals[0] istouching(self)) {
                    flag ctf::returnflag();
                }
            }
            continue;
        }
        if (level.gametype == "sd" && !level.multibomb) {
            if (level.sdbomb.visuals[0] istouching(self)) {
                level.sdbomb gameobjects::return_home();
            }
        }
    }
}

// Namespace mp_metro_train
// Params 0, eflags: 0x0
// Checksum 0x504a5433, Offset: 0x22e0
// Size: 0x113
function function_efb0f9a4() {
    crates = getentarray("care_package", "script_noteworthy");
    foreach (crate in crates) {
        if (distancesquared(crate.origin, self.origin) < 40000) {
            if (crate istouching(self)) {
                playfx(level._supply_drop_explosion_fx, crate.origin);
                playsoundatposition("wpn_grenade_explode", crate.origin);
                wait 0.1;
                crate supplydrop::cratedelete();
            }
        }
    }
}

// Namespace mp_metro_train
// Params 0, eflags: 0x0
// Checksum 0xe503d15d, Offset: 0x2400
// Size: 0x79
function function_dde749cf() {
    corpses = getcorpsearray();
    for (i = 0; i < corpses.size; i++) {
        if (distancesquared(corpses[i].origin, self.origin) < 40000) {
            corpses[i] delete();
        }
    }
}

// Namespace mp_metro_train
// Params 2, eflags: 0x0
// Checksum 0x4c6d9d9a, Offset: 0x2488
// Size: 0xa6
function function_b02c2d9b(org, array) {
    dist = 9999999;
    distsq = dist * dist;
    if (array.size < 1) {
        return;
    }
    index = undefined;
    for (i = 0; i < array.size; i++) {
        newdistsq = distancesquared(array[i].origin, org);
        if (newdistsq >= distsq) {
            continue;
        }
        distsq = newdistsq;
        index = i;
    }
    return array[index];
}

