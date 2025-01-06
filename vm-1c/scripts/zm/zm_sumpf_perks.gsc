#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_utility;

#namespace zm_sumpf_perks;

// Namespace zm_sumpf_perks
// Params 0, eflags: 0x0
// Checksum 0x7203552e, Offset: 0x408
// Size: 0x432
function function_980b3cd5() {
    level.var_54b80118 = 1;
    vending_machines = [];
    vending_machines = function_1b58b796("zombie_vending");
    var_96c661c6 = [];
    var_96c661c6[0] = getent("random_vending_start_location_0", "script_noteworthy");
    var_96c661c6[1] = getent("random_vending_start_location_1", "script_noteworthy");
    var_96c661c6[2] = getent("random_vending_start_location_2", "script_noteworthy");
    var_96c661c6[3] = getent("random_vending_start_location_3", "script_noteworthy");
    level.var_96c661c6 = [];
    level.var_96c661c6[level.var_96c661c6.size] = var_96c661c6[0].origin;
    level.var_96c661c6[level.var_96c661c6.size] = var_96c661c6[1].origin;
    level.var_96c661c6[level.var_96c661c6.size] = var_96c661c6[2].origin;
    level.var_96c661c6[level.var_96c661c6.size] = var_96c661c6[3].origin;
    var_96c661c6 = array::randomize(var_96c661c6);
    var_96c661c6[4] = getent("random_vending_start_location_4", "script_noteworthy");
    level.var_96c661c6[level.var_96c661c6.size] = var_96c661c6[4].origin;
    for (i = 0; i < vending_machines.size; i++) {
        if (vending_machines[i].script_noteworthy == "specialty_quickrevive") {
            var_ebbb6440 = vending_machines[i];
            vending_machines[i] = vending_machines[4];
            vending_machines[4] = var_ebbb6440;
        }
    }
    for (i = 0; i < vending_machines.size; i++) {
        origin = var_96c661c6[i].origin;
        angles = var_96c661c6[i].angles;
        machine = vending_machines[i] function_cd5bc54f(var_96c661c6[i]);
        if (vending_machines[i].script_noteworthy != "specialty_quickrevive") {
            vending_machines[i] triggerenable(0);
        }
        var_96c661c6[i].origin = origin;
        var_96c661c6[i].angles = angles;
        machine.origin = origin;
        machine.angles = angles;
        if (machine.script_string != "revive_perk") {
            machine ghost();
            vending_machines[i] thread function_bede3562(machine);
        }
    }
    level.var_c9b03c1a = &function_25413096;
    level notify(#"hash_57a00baa");
}

// Namespace zm_sumpf_perks
// Params 1, eflags: 0x0
// Checksum 0x458911a6, Offset: 0x848
// Size: 0xe8
function function_bede3562(e_machine) {
    str_on = self.script_noteworthy + "_power_on";
    level waittill(str_on);
    e_machine.b_keep_when_turned_off = 1;
    wait 10;
    e_machine zm_perks::perk_fx(undefined, 1);
    level waittill(self.script_noteworthy + "_unhide");
    str_fx_name = level._custom_perks[self.script_noteworthy].machine_light_effect;
    e_machine zm_perks::perk_fx(str_fx_name);
    e_machine.s_fxloc.angles = e_machine.angles;
}

// Namespace zm_sumpf_perks
// Params 1, eflags: 0x0
// Checksum 0x6625fd84, Offset: 0x938
// Size: 0x15e
function function_1b58b796(str_trigger) {
    vending_machines = [];
    var_560b7d8d = getentarray(str_trigger, "targetname");
    for (i = 0; i < var_560b7d8d.size; i++) {
        if (isdefined(var_560b7d8d[i].script_noteworthy)) {
            if (!isdefined(vending_machines)) {
                vending_machines = [];
            } else if (!isarray(vending_machines)) {
                vending_machines = array(vending_machines);
            }
            vending_machines[vending_machines.size] = var_560b7d8d[i];
            if (var_560b7d8d[i].script_noteworthy != "specialty_quickrevive") {
                var_560b7d8d[i].var_6ecf729b = 1;
                var_560b7d8d[i] thread function_17db950e();
            }
            continue;
        }
        var_560b7d8d[i].var_6ecf729b = 0;
    }
    return vending_machines;
}

// Namespace zm_sumpf_perks
// Params 0, eflags: 0x0
// Checksum 0xdc574001, Offset: 0xaa0
// Size: 0x24
function function_17db950e() {
    level waittill(self.script_noteworthy + "_unhide");
    self.var_6ecf729b = 0;
}

// Namespace zm_sumpf_perks
// Params 0, eflags: 0x0
// Checksum 0x8a82878b, Offset: 0xad0
// Size: 0x110
function function_25413096() {
    perksacola = self.script_sound;
    if (!self.var_6ecf729b) {
        playsoundatposition("evt_electrical_surge", self.origin);
        if (!isdefined(self.var_7054d602)) {
            self.var_7054d602 = 0;
        }
        if (isdefined(perksacola)) {
            if (self.var_7054d602 == 0 && level.var_5738e0e5 == 0) {
                self.var_7054d602 = 1;
                self playsoundontag(perksacola, "tag_origin", "sound_done");
                if (issubstr(perksacola, "sting")) {
                    wait 10;
                } else if (isdefined(self.var_e1405ef7)) {
                    wait 60;
                } else {
                    wait 30;
                }
                self.var_7054d602 = 0;
            }
        }
    }
}

// Namespace zm_sumpf_perks
// Params 0, eflags: 0x0
// Checksum 0x6f127c37, Offset: 0xbe8
// Size: 0x54
function function_6ce17236() {
    level flag::wait_till("solo_revive");
    self unlink();
    self triggerenable(0);
}

// Namespace zm_sumpf_perks
// Params 1, eflags: 0x0
// Checksum 0xa563579, Offset: 0xc48
// Size: 0x178
function function_cd5bc54f(start_location) {
    machine = undefined;
    machine_clip = undefined;
    machine_array = getentarray(self.target, "targetname");
    for (i = 0; i < machine_array.size; i++) {
        if (isdefined(machine_array[i].script_noteworthy) && machine_array[i].script_noteworthy == "clip") {
            machine_clip = machine_array[i];
            continue;
        }
        machine = machine_array[i];
    }
    if (!isdefined(machine)) {
        return;
    }
    if (isdefined(machine_clip)) {
        machine_clip linkto(machine);
    }
    start_location.origin = machine.origin;
    start_location.angles = machine.angles;
    self enablelinkto();
    self linkto(start_location);
    return machine;
}

// Namespace zm_sumpf_perks
// Params 3, eflags: 0x0
// Checksum 0xfccb99c8, Offset: 0xdc8
// Size: 0x18c
function function_e91f62f2(machine, origin, entity) {
    level notify(#"hash_e60e72d2");
    switch (machine) {
    case "p7_zm_vending_jugg":
        var_da5a8677 = "mus_perks_jugganog_sting";
        level notify(#"hash_5203f90d");
        break;
    case "p7_zm_vending_doubletap2":
        var_da5a8677 = "mus_perks_doubletap_sting";
        level notify(#"hash_b5265d08");
        break;
    case "p7_zm_vending_revive":
        var_da5a8677 = "mus_perks_quickrevive_sting";
        level notify(#"hash_57a00baa");
        level.var_54b80118 = 0;
        break;
    case "p7_zm_vending_sleight":
        var_da5a8677 = "mus_perks_speed_sting";
        level notify(#"hash_5331339b");
        break;
    case "p7_zm_vending_three_gun":
        var_da5a8677 = "mus_perks_mulekick_sting";
        level notify(#"hash_d2e0b345");
        break;
    }
    if (isdefined(var_da5a8677)) {
        e_trigger = getent(var_da5a8677, "script_label");
        e_trigger triggerenable(1);
    }
    level notify(#"revive_on");
    function_d3ab4c59(machine, origin);
}

// Namespace zm_sumpf_perks
// Params 2, eflags: 0x0
// Checksum 0x8ffdec1f, Offset: 0xf60
// Size: 0x1b6
function function_d3ab4c59(machine, origin) {
    players = getplayers();
    players = array::get_all_closest(origin, players, undefined, undefined, 512);
    player = undefined;
    for (i = 0; i < players.size; i++) {
        if (sighttracepassed(players[i] geteye(), origin, 0, undefined)) {
            player = players[i];
        }
    }
    if (!isdefined(player)) {
        return;
    }
    switch (machine) {
    case "p7_zm_vending_jugg":
        player thread zm_audio::create_and_play_dialog("level", "jugga");
        break;
    case "p7_zm_vending_doubletap2":
        player thread zm_audio::create_and_play_dialog("level", "doubletap");
        break;
    case "p7_zm_vending_revive":
        player thread zm_audio::create_and_play_dialog("level", "revive");
        break;
    case "p7_zm_vending_sleight":
        player thread zm_audio::create_and_play_dialog("level", "speed");
        break;
    }
}

// Namespace zm_sumpf_perks
// Params 1, eflags: 0x0
// Checksum 0xfb4c0729, Offset: 0x1120
// Size: 0xa34
function function_5c025696(index) {
    var_3be8a3b8 = getentarray("zombie_vending", "targetname");
    machines = [];
    for (j = 0; j < var_3be8a3b8.size; j++) {
        machine_array = getentarray(var_3be8a3b8[j].target, "targetname");
        for (i = 0; i < machine_array.size; i++) {
            if (isdefined(machine_array[i].script_noteworthy) && machine_array[i].script_noteworthy == "clip") {
                continue;
            }
            machines[j] = machine_array[i];
        }
    }
    for (j = 0; j < machines.size; j++) {
        if (machines[j].origin == level.var_96c661c6[index]) {
            break;
        }
    }
    if (isdefined(level.var_8b391b0b)) {
        if (level.var_8b391b0b) {
            if (machines[j].model != "p7_zm_vending_jugg" || machines[j].model != "p7_zm_vending_sleight") {
                for (i = 0; i < machines.size; i++) {
                    if (machines[i].model == "p7_zm_vending_jugg" || i != j && machines[i].model == "p7_zm_vending_sleight") {
                        break;
                    }
                }
                var_96c661c6 = [];
                var_96c661c6[0] = getent("random_vending_start_location_0", "script_noteworthy");
                var_96c661c6[1] = getent("random_vending_start_location_1", "script_noteworthy");
                var_96c661c6[2] = getent("random_vending_start_location_2", "script_noteworthy");
                var_96c661c6[3] = getent("random_vending_start_location_3", "script_noteworthy");
                var_96c661c6[4] = getent("random_vending_start_location_4", "script_noteworthy");
                target_index = undefined;
                var_6d187124 = undefined;
                for (x = 0; x < var_96c661c6.size; x++) {
                    if (var_96c661c6[x].origin == level.var_96c661c6[index]) {
                        target_index = x;
                    }
                    if (var_96c661c6[x].origin == machines[i].origin) {
                        var_6d187124 = x;
                    }
                }
                var_392343bc = machines[j].origin;
                var_6db062 = machines[j].angles;
                machines[j].origin = machines[i].origin;
                machines[j].angles = machines[i].angles;
                var_96c661c6[target_index].origin = var_96c661c6[var_6d187124].origin;
                var_96c661c6[target_index].angles = var_96c661c6[var_6d187124].angles;
                machines[i].origin = var_392343bc;
                machines[i].angles = var_6db062;
                var_96c661c6[var_6d187124].origin = var_392343bc;
                var_96c661c6[var_6d187124].angles = var_6db062;
                j = i;
            }
            level.var_8b391b0b = 0;
        }
    }
    playsoundatposition("zmb_rando_start", machines[j].origin);
    origin = machines[j].origin;
    if (level.var_7c827139.size > 1) {
        playfxontag(level._effect["zombie_perk_start"], machines[j], "tag_origin");
        playsoundatposition("zmb_rando_perk", machines[j].origin);
    } else {
        playfxontag(level._effect["zombie_perk_4th"], machines[j], "tag_origin");
        playsoundatposition("zmb_rando_perk", machines[j].origin);
    }
    var_442e5cb3 = machines[j].model;
    machines[j] setmodel(var_442e5cb3);
    machines[j] show();
    var_429f733c = 40;
    level thread zm_utility::play_sound_2d("zmb_perk_lottery");
    machines[j] moveto(origin + (0, 0, var_429f733c), 5, 3, 0.5);
    tag_fx = spawn("script_model", machines[j].origin);
    tag_fx setmodel("tag_origin");
    tag_fx.angles = machines[j].angles;
    tag_fx linkto(machines[j]);
    playfxontag(level._effect["zombie_perk_smoke_anim"], tag_fx, "tag_origin");
    modelindex = 0;
    machines[j] vibrate(machines[j].angles, 2, 1, 4);
    for (i = 0; i < 30; i++) {
        wait 0.15;
        if (level.var_7c827139.size > 1) {
            while (!isdefined(level.var_7c827139[modelindex])) {
                modelindex++;
                if (modelindex == 4) {
                    modelindex = 0;
                }
            }
            modelname = level.var_7c827139[modelindex];
            machines[j] setmodel(modelname);
            modelindex++;
            if (modelindex == 4) {
                modelindex = 0;
            }
        }
    }
    modelname = var_442e5cb3;
    machines[j] setmodel(modelname);
    machines[j] moveto(origin, 0.3, 0.3, 0);
    wait 0.2;
    playfxontag(level._effect["zombie_perk_end"], machines[j], "tag_origin");
    playsoundatposition("zmb_drop_perk_machine", machines[j].origin);
    wait 0.05;
    playfxontag(level._effect["zombie_perk_flash"], machines[j], "tag_origin");
    function_e91f62f2(var_442e5cb3, origin, machines[j]);
}

