#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_pers_upgrades_system;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_perk_quick_revive;

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x2
// Checksum 0x1e116145, Offset: 0x490
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_quick_revive", &__init__, undefined, undefined);
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x1 linked
// Checksum 0x16f0358b, Offset: 0x4d0
// Size: 0x2c
function __init__() {
    enable_quick_revive_perk_for_level();
    level.var_3dbc348c = &function_faffdf64;
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x1 linked
// Checksum 0x133eeaa5, Offset: 0x508
// Size: 0x184
function enable_quick_revive_perk_for_level() {
    zm_perks::register_perk_basic_info("specialty_quickrevive", "revive", &function_72474405, %ZOMBIE_PERK_QUICKREVIVE, getweapon("zombie_perk_bottle_revive"));
    zm_perks::register_perk_precache_func("specialty_quickrevive", &quick_revive_precache);
    zm_perks::register_perk_clientfields("specialty_quickrevive", &quick_revive_register_clientfield, &quick_revive_set_clientfield);
    zm_perks::register_perk_machine("specialty_quickrevive", &quick_revive_perk_machine_setup);
    zm_perks::register_perk_threads("specialty_quickrevive", &give_quick_revive_perk, &take_quick_revive_perk);
    zm_perks::register_perk_host_migration_params("specialty_quickrevive", "vending_revive", "revive_light");
    zm_perks::register_perk_machine_power_override("specialty_quickrevive", &turn_revive_on);
    level flag::init("solo_revive");
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x1 linked
// Checksum 0x6586f077, Offset: 0x698
// Size: 0xe0
function quick_revive_precache() {
    if (isdefined(level.var_a7e576e6)) {
        [[ level.var_a7e576e6 ]]();
        return;
    }
    level._effect["revive_light"] = "zombie/fx_perk_quick_revive_zmb";
    level.machine_assets["specialty_quickrevive"] = spawnstruct();
    level.machine_assets["specialty_quickrevive"].weapon = getweapon("zombie_perk_bottle_revive");
    level.machine_assets["specialty_quickrevive"].off_model = "p7_zm_vending_revive";
    level.machine_assets["specialty_quickrevive"].on_model = "p7_zm_vending_revive";
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x1 linked
// Checksum 0x3c04f5ef, Offset: 0x780
// Size: 0x34
function quick_revive_register_clientfield() {
    clientfield::register("clientuimodel", "hudItems.perks.quick_revive", 1, 2, "int");
}

// Namespace zm_perk_quick_revive
// Params 1, eflags: 0x1 linked
// Checksum 0x48400063, Offset: 0x7c0
// Size: 0x2c
function quick_revive_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.quick_revive", state);
}

// Namespace zm_perk_quick_revive
// Params 4, eflags: 0x1 linked
// Checksum 0x3e456eb2, Offset: 0x7f8
// Size: 0xbc
function quick_revive_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_revive_jingle";
    use_trigger.script_string = "revive_perk";
    use_trigger.script_label = "mus_perks_revive_sting";
    use_trigger.target = "vending_revive";
    perk_machine.script_string = "revive_perk";
    perk_machine.targetname = "vending_revive";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "revive_perk";
    }
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x1 linked
// Checksum 0x8646f89d, Offset: 0x8c0
// Size: 0x38
function function_72474405() {
    var_b93a49d8 = zm_perks::function_23ee6fc();
    if (var_b93a49d8) {
        return 500;
    }
    return 1500;
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x1 linked
// Checksum 0x3ff297db, Offset: 0x900
// Size: 0x74a
function turn_revive_on() {
    level endon(#"stop_quickrevive_logic");
    level flag::wait_till("start_zombie_round_logic");
    var_2d92a626 = 0;
    if (zm_perks::function_23ee6fc()) {
        var_2d92a626 = 1;
    }
    if (var_2d92a626 && !(isdefined(level.var_f1557a11) && level.var_f1557a11)) {
        level.var_f1557a11 = 1;
    }
    while (true) {
        machine = getentarray("vending_revive", "targetname");
        machine_triggers = getentarray("vending_revive", "target");
        for (i = 0; i < machine.size; i++) {
            if (level flag::exists("solo_game") && level flag::exists("solo_revive") && level flag::get("solo_game") && level flag::get("solo_revive")) {
                machine[i] ghost();
                machine[i] notsolid();
            }
            machine[i] setmodel(level.machine_assets["specialty_quickrevive"].off_model);
            if (isdefined(level.quick_revive_final_pos)) {
                level.quick_revive_default_origin = level.quick_revive_final_pos;
            }
            if (!isdefined(level.quick_revive_default_origin)) {
                level.quick_revive_default_origin = machine[i].origin;
                level.quick_revive_default_angles = machine[i].angles;
            }
            level.quick_revive_machine = machine[i];
        }
        array::thread_all(machine_triggers, &zm_perks::set_power_on, 0);
        if (isdefined(level.var_44ebf6d) && level.var_44ebf6d) {
            level waittill(#"revive_on");
        } else if (!var_2d92a626) {
            level waittill(#"revive_on");
        }
        for (i = 0; i < machine.size; i++) {
            if (isdefined(machine[i].classname) && machine[i].classname == "script_model") {
                if (isdefined(machine[i].script_noteworthy) && machine[i].script_noteworthy == "clip") {
                    machine_clip = machine[i];
                    continue;
                }
                machine[i] setmodel(level.machine_assets["specialty_quickrevive"].on_model);
                machine[i] playsound("zmb_perks_power_on");
                machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
                machine_model = machine[i];
                machine[i] thread zm_perks::perk_fx("revive_light");
                exploder::exploder("quick_revive_lgts");
                machine[i] notify(#"stop_loopsound");
                machine[i] thread zm_perks::play_loop_on_machine();
                if (isdefined(machine_triggers[i])) {
                    machine_clip = machine_triggers[i].clip;
                }
                if (isdefined(machine_triggers[i])) {
                    blocker_model = machine_triggers[i].blocker_model;
                }
            }
        }
        util::wait_network_frame();
        if (var_2d92a626 && isdefined(machine_model) && !(isdefined(machine_model.ishidden) && machine_model.ishidden)) {
            machine_model thread function_934dbe0d(machine_clip, blocker_model);
        }
        array::thread_all(machine_triggers, &zm_perks::set_power_on, 1);
        if (isdefined(level.machine_assets["specialty_quickrevive"].power_on_callback)) {
            array::thread_all(machine, level.machine_assets["specialty_quickrevive"].power_on_callback);
        }
        level notify(#"specialty_quickrevive_power_on");
        if (isdefined(machine_model)) {
            machine_model.ishidden = 0;
        }
        notify_str = level util::waittill_any_return("revive_off", "revive_hide", "stop_quickrevive_logic");
        should_hide = 0;
        if (notify_str == "revive_hide") {
            should_hide = 1;
        }
        if (isdefined(level.machine_assets["specialty_quickrevive"].power_off_callback)) {
            array::thread_all(machine, level.machine_assets["specialty_quickrevive"].power_off_callback);
        }
        for (i = 0; i < machine.size; i++) {
            if (isdefined(machine[i].classname) && machine[i].classname == "script_model") {
                machine[i] zm_perks::turn_perk_off(should_hide);
            }
        }
    }
}

// Namespace zm_perk_quick_revive
// Params 2, eflags: 0x1 linked
// Checksum 0x3fe3ad35, Offset: 0x1058
// Size: 0x664
function function_ba808584(machine_clip, var_2d92a626) {
    if (isdefined(level.var_d627adfb) && !(isdefined(level.var_d627adfb) && level.var_d627adfb)) {
        return;
    }
    wait 0.1;
    var_fb07f42a = 0;
    if (isdefined(var_2d92a626) && var_2d92a626) {
        var_fb07f42a = 1;
        var_30a4c6db = 1;
        players = getplayers();
        foreach (player in players) {
            if (isdefined(player.lives) && player.lives > 0 && var_fb07f42a) {
                var_30a4c6db = 0;
                continue;
            }
            if (isdefined(player.lives) && player.lives < 1) {
                var_30a4c6db = 1;
            }
        }
        if (var_30a4c6db) {
            zm_perks::perk_pause("specialty_quickrevive");
        } else {
            zm_perks::perk_unpause("specialty_quickrevive");
        }
        if (isdefined(level.var_f1557a11) && level.var_f1557a11 && level flag::get("solo_revive")) {
            function_ff716478(machine_clip);
            return;
        }
        update_quickrevive_power_state(1);
        unhide_quickrevive();
        restart_quickrevive();
        level notify(#"revive_off");
        wait 0.1;
        level notify(#"stop_quickrevive_logic");
    } else {
        if (!(isdefined(level.var_54b80118) && level.var_54b80118)) {
            unhide_quickrevive();
            level notify(#"revive_off");
            wait 0.1;
        }
        level notify(#"revive_hide");
        level notify(#"stop_quickrevive_logic");
        restart_quickrevive();
        triggers = getentarray("zombie_vending", "targetname");
        foreach (trigger in triggers) {
            if (!isdefined(trigger.script_noteworthy)) {
                continue;
            }
            if (trigger.script_noteworthy == "specialty_quickrevive") {
                if (isdefined(trigger.script_int)) {
                    if (level flag::get("power_on" + trigger.script_int)) {
                        var_fb07f42a = 1;
                    }
                    continue;
                }
                if (level flag::get("power_on")) {
                    var_fb07f42a = 1;
                }
            }
        }
        update_quickrevive_power_state(var_fb07f42a);
    }
    level thread turn_revive_on();
    if (var_fb07f42a) {
        zm_perks::perk_unpause("specialty_quickrevive");
        level notify(#"revive_on");
        wait 0.1;
        level notify(#"specialty_quickrevive_power_on");
    } else {
        zm_perks::perk_pause("specialty_quickrevive");
    }
    if (!(isdefined(var_2d92a626) && var_2d92a626)) {
        return;
    }
    var_30a4c6db = 1;
    players = getplayers();
    foreach (player in players) {
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        if (player hasperk("specialty_quickrevive")) {
            if (!isdefined(player.lives)) {
                player.lives = 0;
            }
            if (!isdefined(level.solo_lives_given)) {
                level.solo_lives_given = 0;
            }
            level.solo_lives_given++;
            player.lives++;
            if (isdefined(player.lives) && player.lives > 0 && var_fb07f42a) {
                var_30a4c6db = 0;
                continue;
            }
            var_30a4c6db = 1;
        }
    }
    if (var_30a4c6db) {
        zm_perks::perk_pause("specialty_quickrevive");
        return;
    }
    zm_perks::perk_unpause("specialty_quickrevive");
}

// Namespace zm_perk_quick_revive
// Params 1, eflags: 0x1 linked
// Checksum 0x54963e60, Offset: 0x16c8
// Size: 0x9c
function function_26c49866(var_2d92a626) {
    if (!isdefined(var_2d92a626)) {
        var_2d92a626 = 0;
    }
    clip = undefined;
    if (isdefined(level.quick_revive_machine_clip)) {
        clip = level.quick_revive_machine_clip;
    }
    level._custom_perks["specialty_quickrevive"].cost = function_72474405();
    level.quick_revive_machine thread function_ba808584(clip, var_2d92a626);
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x1 linked
// Checksum 0x3d572ec1, Offset: 0x1770
// Size: 0x17c
function function_faffdf64() {
    level notify(#"hash_1d63cfa4");
    level endon(#"hash_1d63cfa4");
    var_2d92a626 = 0;
    var_c7a4c008 = 0;
    wait 0.05;
    players = getplayers();
    if (isdefined(level.var_1bc2b35c) && (players.size == 1 || level.var_1bc2b35c)) {
        var_2d92a626 = 1;
        if (!level flag::get("solo_game")) {
            var_c7a4c008 = 1;
        }
        level flag::set("solo_game");
    } else {
        if (level flag::get("solo_game")) {
            var_c7a4c008 = 1;
        }
        level flag::clear("solo_game");
    }
    level.var_809c5639 = var_2d92a626;
    level.revive_machine_is_solo = var_2d92a626;
    zm::function_dd15fb4e(var_2d92a626);
    if (var_c7a4c008 && isdefined(level.quick_revive_machine)) {
        function_26c49866(var_2d92a626);
    }
}

// Namespace zm_perk_quick_revive
// Params 2, eflags: 0x1 linked
// Checksum 0x61a2b1a8, Offset: 0x18f8
// Size: 0x38a
function function_934dbe0d(machine_clip, blocker_model) {
    if (level flag::exists("solo_revive") && level flag::get("solo_revive") && !level flag::get("solo_game")) {
        return;
    }
    if (isdefined(machine_clip)) {
        level.quick_revive_machine_clip = machine_clip;
    }
    level notify(#"hash_934dbe0d");
    level endon(#"hash_934dbe0d");
    self endon(#"death");
    level flag::wait_till("solo_revive");
    if (isdefined(level.var_2b07e0c2)) {
        level thread [[ level.var_2b07e0c2 ]]();
    }
    wait 2;
    self playsound("zmb_box_move");
    playsoundatposition("zmb_whoosh", self.origin);
    if (isdefined(self._linked_ent)) {
        self unlink();
    }
    self moveto(self.origin + (0, 0, 40), 3);
    if (isdefined(level.var_aa9be895)) {
        [[ level.var_aa9be895 ]](self);
    } else {
        direction = self.origin;
        direction = (direction[1], direction[0], 0);
        if (direction[0] > 0 && (direction[1] < 0 || direction[1] > 0)) {
            direction = (direction[0], direction[1] * -1, 0);
        } else if (direction[0] < 0) {
            direction = (direction[0] * -1, direction[1], 0);
        }
        self vibrate(direction, 10, 0.5, 5);
    }
    self waittill(#"movedone");
    playfx(level._effect["poltergeist"], self.origin);
    playsoundatposition("zmb_box_poof", self.origin);
    if (isdefined(self.fx)) {
        self.fx unlink();
        self.fx delete();
    }
    if (isdefined(machine_clip)) {
        machine_clip hide();
        machine_clip connectpaths();
    }
    if (isdefined(blocker_model)) {
        blocker_model show();
    }
    level notify(#"revive_hide");
}

// Namespace zm_perk_quick_revive
// Params 1, eflags: 0x1 linked
// Checksum 0xf0a8ff9d, Offset: 0x1c90
// Size: 0x4ea
function function_ff716478(machine_clip) {
    if (isdefined(level.var_f1557a11) && level.var_f1557a11 && level flag::get("solo_revive") && isdefined(level.quick_revive_machine)) {
        triggers = getentarray("zombie_vending", "targetname");
        foreach (trigger in triggers) {
            if (!isdefined(trigger.script_noteworthy)) {
                continue;
            }
            if (trigger.script_noteworthy == "specialty_quickrevive") {
                trigger triggerenable(0);
            }
        }
        foreach (item in level.powered_items) {
            if (isdefined(item.target) && isdefined(item.target.script_noteworthy) && item.target.script_noteworthy == "specialty_quickrevive") {
                item.power = 1;
                item.self_powered = 1;
            }
        }
        if (isdefined(level.quick_revive_machine.original_pos)) {
            level.quick_revive_default_origin = level.quick_revive_machine.original_pos;
            level.quick_revive_default_angles = level.quick_revive_machine.original_angles;
        }
        var_73d83e35 = level.quick_revive_default_origin;
        if (isdefined(level.quick_revive_linked_ent)) {
            var_73d83e35 = level.quick_revive_linked_ent.origin;
            if (isdefined(level.quick_revive_linked_ent_offset)) {
                var_73d83e35 += level.quick_revive_linked_ent_offset;
            }
            level.quick_revive_machine unlink();
        }
        level.quick_revive_machine moveto(var_73d83e35 + (0, 0, 40), 3);
        direction = level.quick_revive_machine.origin;
        direction = (direction[1], direction[0], 0);
        if (direction[0] > 0 && (direction[1] < 0 || direction[1] > 0)) {
            direction = (direction[0], direction[1] * -1, 0);
        } else if (direction[0] < 0) {
            direction = (direction[0] * -1, direction[1], 0);
        }
        level.quick_revive_machine vibrate(direction, 10, 0.5, 4);
        level.quick_revive_machine waittill(#"movedone");
        level.quick_revive_machine hide();
        level.quick_revive_machine.ishidden = 1;
        if (isdefined(level.quick_revive_machine_clip)) {
            level.quick_revive_machine_clip hide();
            level.quick_revive_machine_clip connectpaths();
        }
        playfx(level._effect["poltergeist"], level.quick_revive_machine.origin);
        if (isdefined(level.quick_revive_trigger) && isdefined(level.quick_revive_trigger.blocker_model)) {
            level.quick_revive_trigger.blocker_model show();
        }
        level notify(#"revive_hide");
    }
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x1 linked
// Checksum 0xf68599e6, Offset: 0x2188
// Size: 0x418
function unhide_quickrevive() {
    while (zm_perks::players_are_in_perk_area(level.quick_revive_machine)) {
        wait 0.1;
    }
    if (isdefined(level.quick_revive_machine_clip)) {
        level.quick_revive_machine_clip show();
        level.quick_revive_machine_clip disconnectpaths();
    }
    if (isdefined(level.quick_revive_final_pos)) {
        level.quick_revive_machine.origin = level.quick_revive_final_pos;
    }
    playfx(level._effect["poltergeist"], level.quick_revive_machine.origin);
    if (isdefined(level.quick_revive_trigger) && isdefined(level.quick_revive_trigger.blocker_model)) {
        level.quick_revive_trigger.blocker_model hide();
    }
    level.quick_revive_machine show();
    level.quick_revive_machine solid();
    if (isdefined(level.quick_revive_machine.original_pos)) {
        level.quick_revive_default_origin = level.quick_revive_machine.original_pos;
        level.quick_revive_default_angles = level.quick_revive_machine.original_angles;
    }
    direction = level.quick_revive_machine.origin;
    direction = (direction[1], direction[0], 0);
    if (direction[0] > 0 && (direction[1] < 0 || direction[1] > 0)) {
        direction = (direction[0], direction[1] * -1, 0);
    } else if (direction[0] < 0) {
        direction = (direction[0] * -1, direction[1], 0);
    }
    org = level.quick_revive_default_origin;
    if (isdefined(level.quick_revive_linked_ent)) {
        org = level.quick_revive_linked_ent.origin;
        if (isdefined(level.quick_revive_linked_ent_offset)) {
            org += level.quick_revive_linked_ent_offset;
        }
    }
    if (!(isdefined(level.quick_revive_linked_ent_moves) && level.quick_revive_linked_ent_moves) && level.quick_revive_machine.origin != org) {
        level.quick_revive_machine moveto(org, 3);
        level.quick_revive_machine vibrate(direction, 10, 0.5, 2.9);
        level.quick_revive_machine waittill(#"movedone");
        level.quick_revive_machine.angles = level.quick_revive_default_angles;
    } else {
        if (isdefined(level.quick_revive_linked_ent)) {
            org = level.quick_revive_linked_ent.origin;
            if (isdefined(level.quick_revive_linked_ent_offset)) {
                org += level.quick_revive_linked_ent_offset;
            }
            level.quick_revive_machine.origin = org;
        }
        level.quick_revive_machine vibrate((0, -100, 0), 0.3, 0.4, 3);
    }
    if (isdefined(level.quick_revive_linked_ent)) {
        level.quick_revive_machine linkto(level.quick_revive_linked_ent);
    }
    level.quick_revive_machine.ishidden = 0;
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x1 linked
// Checksum 0x8d9d3190, Offset: 0x25a8
// Size: 0x112
function restart_quickrevive() {
    triggers = getentarray("zombie_vending", "targetname");
    foreach (trigger in triggers) {
        if (!isdefined(trigger.script_noteworthy)) {
            continue;
        }
        if (trigger.script_noteworthy == "specialty_quickrevive") {
            trigger notify(#"stop_quickrevive_logic");
            trigger thread zm_perks::vending_trigger_think();
            trigger triggerenable(1);
        }
    }
}

// Namespace zm_perk_quick_revive
// Params 1, eflags: 0x1 linked
// Checksum 0x41721125, Offset: 0x26c8
// Size: 0x1c2
function update_quickrevive_power_state(poweron) {
    foreach (item in level.powered_items) {
        if (isdefined(item.target) && isdefined(item.target.script_noteworthy) && item.target.script_noteworthy == "specialty_quickrevive") {
            if (item.power && !poweron) {
                if (!isdefined(item.powered_count)) {
                    item.powered_count = 0;
                } else if (item.powered_count > 0) {
                    item.powered_count--;
                }
            } else if (!item.power && poweron) {
                if (!isdefined(item.powered_count)) {
                    item.powered_count = 0;
                }
                item.powered_count++;
            }
            if (!isdefined(item.depowered_count)) {
                item.depowered_count = 0;
            }
            item.power = poweron;
        }
    }
}

// Namespace zm_perk_quick_revive
// Params 1, eflags: 0x1 linked
// Checksum 0x382b9450, Offset: 0x2898
// Size: 0xca
function function_c092d2cc(var_ec84fec3) {
    self endon(#"death");
    j_mag_pouch1 = getentarray(var_ec84fec3, "script_noteworthy");
    foreach (var_f1e9b08 in j_mag_pouch1) {
        self thread function_5522faa5(var_f1e9b08);
    }
}

// Namespace zm_perk_quick_revive
// Params 1, eflags: 0x1 linked
// Checksum 0x9bcdb899, Offset: 0x2970
// Size: 0xc4
function function_5522faa5(var_f1e9b08) {
    self endon(#"death");
    var_f1e9b08 setinvisibletoplayer(self);
    if (level.solo_lives_given >= 3) {
        var_f1e9b08 triggerenable(0);
        exploder::stop_exploder("quick_revive_lgts");
        if (isdefined(level.var_d1834ad6)) {
            var_f1e9b08 [[ level.var_d1834ad6 ]]();
        }
        return;
    }
    while (self.lives > 0) {
        wait 0.1;
    }
    var_f1e9b08 setvisibletoplayer(self);
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x1 linked
// Checksum 0xb9da72b1, Offset: 0x2a40
// Size: 0xac
function give_quick_revive_perk() {
    if (zm_perks::function_23ee6fc()) {
        self.lives = 1;
        if (!isdefined(level.solo_lives_given)) {
            level.solo_lives_given = 0;
        }
        if (isdefined(level.solo_game_free_player_quickrevive)) {
            level.solo_game_free_player_quickrevive = undefined;
        } else {
            level.solo_lives_given++;
        }
        if (level.solo_lives_given >= 3) {
            level flag::set("solo_revive");
        }
        self thread function_c092d2cc("specialty_quickrevive");
    }
}

// Namespace zm_perk_quick_revive
// Params 3, eflags: 0x1 linked
// Checksum 0xe7d08e2b, Offset: 0x2af8
// Size: 0x1c
function take_quick_revive_perk(b_pause, str_perk, str_result) {
    
}

