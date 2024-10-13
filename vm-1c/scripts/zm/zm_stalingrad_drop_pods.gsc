#using scripts/zm/zm_stalingrad_vo;
#using scripts/zm/zm_stalingrad_util;
#using scripts/zm/zm_stalingrad_pap_quest;
#using scripts/zm/zm_stalingrad_ee_main;
#using scripts/shared/ai/zombie_utility;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_attackables;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_2e6e7fce;

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x1e8abc74, Offset: 0xf48
// Size: 0x724
function function_2bb254bb() {
    level flag::init("spawn_ee_harassers");
    level flag::init("advance_drop_pod_round");
    level.var_583e4a97 = spawnstruct();
    level.var_583e4a97.var_5d8406ed = [];
    level.var_583e4a97.var_f2d794f3 = [];
    level.var_583e4a97.var_a622ee25 = 0;
    level.var_583e4a97.var_a43689b5 = 0;
    level thread function_6b964717();
    var_8f0097a0 = struct::get_array("drop_pod", "targetname");
    foreach (s_location in var_8f0097a0) {
        str_location = s_location.script_string + "" + s_location.script_int;
        level.var_583e4a97.var_5d8406ed[str_location] = s_location;
        s_location.b_available = 0;
    }
    level thread function_6905fcad("department_store_upper_open", "department_store");
    level thread function_6905fcad("activate_red_brick", "red");
    level thread function_6905fcad("activate_yellow", "yellow");
    level thread function_6905fcad("activate_judicial", "judicial");
    level thread function_6905fcad("factory_open", "factory");
    level thread function_6905fcad("library_open", "library");
    level thread function_6905fcad("activate_bunker", "alley");
    var_aa0a923d = getentarray("drop_pod_score_volume", "targetname");
    foreach (volume in var_aa0a923d) {
        str_location = volume.script_string;
        level.var_583e4a97.var_5d8406ed[str_location].var_ab891f49 = volume;
    }
    var_c746b61a = struct::get_array("drop_pod_attackable", "targetname");
    foreach (var_6829d61c in var_c746b61a) {
        str_location = var_6829d61c.script_string;
        level.var_583e4a97.var_5d8406ed[str_location].var_b454101b = var_6829d61c;
    }
    level.var_583e4a97.var_365bcb3c = 0;
    flag::wait_till("start_zombie_round_logic");
    foreach (var_3d8a9064 in level.var_583e4a97.var_5d8406ed) {
        var_3d8a9064 thread function_d4c6ea10();
    }
    var_b8fe8638 = struct::get_array("drop_pod_radio", "targetname");
    foreach (s_radio in var_b8fe8638) {
        s_radio.b_used = 0;
        s_radio zm_unitrigger::create_unitrigger(%ZM_STALINGRAD_DROP_POD_ACTIVATE, undefined, &function_f7b738bf);
        s_radio thread function_5f435187();
    }
    var_45b3db60 = getent("drop_pod_terminal_library", "targetname");
    var_45b3db60 thread function_ee55d7d6();
    var_23f1153b = getent("drop_pod_terminal_factory", "targetname");
    var_23f1153b thread function_ee55d7d6();
    var_4ebf9e26 = getent("drop_pod_terminal_judicial", "targetname");
    var_4ebf9e26 thread function_ee55d7d6();
    level flag::set("drop_pod_init_done");
    level flag::set("spawn_ee_harassers");
}

// Namespace namespace_2e6e7fce
// Params 1, eflags: 0x1 linked
// Checksum 0xbe8e6e86, Offset: 0x1678
// Size: 0x286
function function_f7b738bf(e_player) {
    if (e_player zm_utility::in_revive_trigger()) {
        self sethintstring(%);
        return false;
    }
    if (e_player.is_drinking > 0) {
        self sethintstring(%);
        return false;
    }
    if (!level flag::get("power_on")) {
        self sethintstring(%ZM_STALINGRAD_POWER_REQUIRED);
        return false;
    } else if (level flag::get("special_round") || level flag::get("ee_round")) {
        self sethintstring(%ZM_STALINGRAD_CONSOLE_DISABLED);
        return false;
    } else if (level flag::get("drop_pod_spawned")) {
        self sethintstring(%ZM_STALINGRAD_DROP_POD_ACTIVE);
        return false;
    } else if (!isdefined(level.var_583e4a97.var_caa5bc3e)) {
        self sethintstring(%ZM_STALINGRAD_DROP_POD_CYLINDER_REQUIRED);
        return true;
    } else if (isdefined(level.var_583e4a97.var_caa5bc3e) && self.stub.related_parent.script_parameters != level.var_583e4a97.var_caa5bc3e) {
        self sethintstring(%ZM_STALINGRAD_DROP_POD_INCORRECT_CYLINDER);
        return true;
    } else if (self.stub.related_parent.script_parameters == level.var_583e4a97.var_caa5bc3e) {
        self sethintstring(%ZM_STALINGRAD_DROP_POD_ACTIVATE);
        return true;
    }
    self sethintstring("");
    return false;
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x35a0e648, Offset: 0x1908
// Size: 0x128
function function_5f435187() {
    while (true) {
        e_who = self waittill(#"trigger_activated");
        if (level flag::get("special_round") || level flag::get("ee_round")) {
            continue;
        } else if (!isdefined(level.var_583e4a97.var_caa5bc3e)) {
            level thread zm_stalingrad_vo::function_eaf2cef3();
            continue;
        } else if (isdefined(level.var_583e4a97.var_caa5bc3e) && self.script_parameters != level.var_583e4a97.var_caa5bc3e) {
            level thread zm_stalingrad_vo::function_c0135bef();
            continue;
        }
        e_who clientfield::increment_to_player("interact_rumble");
        self thread function_8aebb789();
    }
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xe48fdf91, Offset: 0x1a38
// Size: 0x1f8
function function_8aebb789() {
    level.var_583e4a97.s_radio = self;
    mdl_console = getent(self.target, "targetname");
    mdl_console thread function_f5212f09();
    level thread zm_stalingrad_pap::function_809fbbff(self.script_string);
    level flag::set("drop_pod_active");
    level flag::clear("ambient_mortar_fire_on");
    foreach (player in level.activeplayers) {
        player clientfield::set_player_uimodel("zmInventory.piece_cylinder", 0);
    }
    switch (level.var_583e4a97.var_caa5bc3e) {
    case "code_cylinder_blue":
        level.var_583e4a97.var_4bf647dc = "yellow";
        break;
    case "code_cylinder_yellow":
        level.var_583e4a97.var_4bf647dc = "red";
        break;
    case "code_cylinder_red":
        level.var_583e4a97.var_4bf647dc = "blue";
        break;
    }
    level.var_583e4a97.var_caa5bc3e = undefined;
    level.var_583e4a97.var_a622ee25 = 0;
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xd2b98f13, Offset: 0x1c38
// Size: 0x44
function function_ee55d7d6() {
    self hidepart("tag_code_cylinder");
    self hidepart("tag_screen_main_green");
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x9093d37d, Offset: 0x1c88
// Size: 0xd4
function function_f5212f09() {
    self showpart("tag_code_cylinder");
    self playsoundontag("zmb_stalingrad_pod_cylinder_insert", "tag_code_cylinder");
    self hidepart("tag_screen_main_green");
    self showpart("tag_screen_main_red");
    wait 3;
    self hidepart("tag_code_cylinder");
    self playsoundontag("zmb_stalingrad_pod_cylinder_explo", "tag_code_cylinder");
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x93911d66, Offset: 0x1d68
// Size: 0x1c
function function_d4c6ea10() {
    self.n_current_progress = 0;
    self.var_d2e1ce53 = 0;
}

// Namespace namespace_2e6e7fce
// Params 2, eflags: 0x1 linked
// Checksum 0xd64212b6, Offset: 0x1d90
// Size: 0x34
function function_6905fcad(waittill_flag, str_zone) {
    level waittill(waittill_flag);
    level function_830313d1(str_zone);
}

// Namespace namespace_2e6e7fce
// Params 1, eflags: 0x1 linked
// Checksum 0x857a642f, Offset: 0x1dd0
// Size: 0x22a
function function_830313d1(str_zone) {
    switch (str_zone) {
    case "department_store":
        level.var_583e4a97.var_5d8406ed["department_store1"].b_available = 1;
        break;
    case "alley":
        level.var_583e4a97.var_5d8406ed["alley1"].b_available = 1;
        break;
    case "red":
        level.var_583e4a97.var_5d8406ed["red1"].b_available = 1;
        break;
    case "yellow":
        level.var_583e4a97.var_5d8406ed["yellow1"].b_available = 1;
        break;
    case "judicial":
        level.var_583e4a97.var_5d8406ed["judicial1"].b_available = 1;
        level.var_583e4a97.var_5d8406ed["judicial2"].b_available = 1;
        level.var_583e4a97.var_5d8406ed["judicial3"].b_available = 1;
        break;
    case "library":
        level.var_583e4a97.var_5d8406ed["library1"].b_available = 1;
        level.var_583e4a97.var_5d8406ed["library2"].b_available = 1;
        break;
    case "factory":
        level.var_583e4a97.var_5d8406ed["factory1"].b_available = 1;
        level.var_583e4a97.var_5d8406ed["factory2"].b_available = 1;
        break;
    }
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x742f9fd, Offset: 0x2008
// Size: 0x26c
function function_6b964717() {
    level flag::init("between_rounds");
    level flag::wait_till("power_on");
    level thread function_855f59cb();
    level.var_583e4a97.var_cac771d3 = 0;
    level.var_583e4a97.var_a622ee25 = 0;
    level.var_583e4a97.var_4bf647dc = "blue";
    level.var_583e4a97.var_a43689b5 = 10;
    zm_powerups::register_powerup("code_cylinder_red", &function_86d9efb0);
    zm_powerups::register_powerup("code_cylinder_yellow", &function_86d9efb0);
    zm_powerups::register_powerup("code_cylinder_blue", &function_86d9efb0);
    zm_powerups::add_zombie_powerup("code_cylinder_red", "p7_zm_sta_code_cylinder_red", %ZM_STALINGRAD_CODE_CYLINER_HINT, undefined, 0, 0, 0);
    zm_powerups::add_zombie_powerup("code_cylinder_yellow", "p7_zm_sta_code_cylinder_yellow", %ZM_STALINGRAD_CODE_CYLINER_HINT, undefined, 0, 0, 0);
    zm_powerups::add_zombie_powerup("code_cylinder_blue", "p7_zm_sta_code_cylinder", %ZM_STALINGRAD_CODE_CYLINER_HINT, undefined, 0, 0, 0);
    zm_powerups::powerup_remove_from_regular_drops("code_cylinder_red");
    zm_powerups::powerup_remove_from_regular_drops("code_cylinder_yellow");
    zm_powerups::powerup_remove_from_regular_drops("code_cylinder_blue");
    zm_powerups::powerup_set_statless_powerup("code_cylinder_red");
    zm_powerups::powerup_set_statless_powerup("code_cylinder_yellow");
    zm_powerups::powerup_set_statless_powerup("code_cylinder_blue");
    zm_spawner::register_zombie_death_event_callback(&function_1389d425);
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xb0a87090, Offset: 0x2280
// Size: 0x9c
function function_855f59cb() {
    level endon(#"end_game");
    while (true) {
        level waittill(#"end_of_round");
        level flag::set("between_rounds");
        level thread function_a3d6f85c();
        level waittill(#"start_of_round");
        level flag::clear("between_rounds");
        level.var_583e4a97.var_cac771d3 = 0;
    }
}

// Namespace namespace_2e6e7fce
// Params 1, eflags: 0x1 linked
// Checksum 0x32e815e4, Offset: 0x2328
// Size: 0x1f2
function function_86d9efb0(e_player) {
    level.var_583e4a97.var_caa5bc3e = self.powerup_name;
    foreach (player in level.activeplayers) {
        switch (self.powerup_name) {
        case "code_cylinder_red":
            var_130c4ab2 = 1;
            var_5f982950 = "drop_pod_terminal_factory";
            break;
        case "code_cylinder_blue":
            var_130c4ab2 = 2;
            var_5f982950 = "drop_pod_terminal_judicial";
            break;
        case "code_cylinder_yellow":
            var_130c4ab2 = 3;
            var_5f982950 = "drop_pod_terminal_library";
            break;
        }
        player clientfield::set_player_uimodel("zmInventory.piece_cylinder", var_130c4ab2);
        player thread zm_craftables::function_97be99b3("zmInventory.piece_cylinder", "zmInventory.widget_cylinder", 0);
        mdl_console = getent(var_5f982950, "targetname");
        mdl_console showpart("tag_screen_main_green");
        mdl_console hidepart("tag_screen_main_red");
        player function_8df46779(1, self.powerup_name);
    }
}

// Namespace namespace_2e6e7fce
// Params 1, eflags: 0x1 linked
// Checksum 0x683de903, Offset: 0x2528
// Size: 0xa4
function function_1389d425(e_attacker) {
    if (isdefined(self.no_powerups) && (isdefined(self.var_4d11bb60) && self.var_4d11bb60 || isdefined(level.var_583e4a97.var_caa5bc3e) || level flag::get("drop_pod_spawned") || level flag::get("drop_pod_active") || self.no_powerups)) {
        return 0;
    }
    self thread function_aa168b7a();
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x3f521d02, Offset: 0x25d8
// Size: 0x184
function function_aa168b7a() {
    var_f31bd832 = level.powerup_drop_count;
    var_f1c825f6 = self.origin;
    var_988bbfc2 = isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area;
    wait 0.5;
    if (var_f31bd832 != level.powerup_drop_count || level.var_583e4a97.var_a622ee25) {
        return 0;
    }
    n_rate = level.var_583e4a97.var_a43689b5;
    n_roll = randomint(100);
    if (n_roll <= n_rate && var_988bbfc2) {
        var_10fdad27 = function_a9d4f2ec();
        s_powerup = zm_powerups::specific_powerup_drop("code_cylinder_" + var_10fdad27, var_f1c825f6);
        level.var_583e4a97.var_a622ee25 = 1;
        level.var_583e4a97.var_a43689b5 = 10;
        s_powerup thread function_9411a0ff();
        return;
    }
    level.var_583e4a97.var_a43689b5 += 2;
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xf4f885d9, Offset: 0x2768
// Size: 0xa0
function function_a9d4f2ec() {
    if (level flag::get("dragonride_crafted")) {
        var_446e72fb = randomint(2);
        switch (var_446e72fb) {
        case 1:
            return "blue";
        case 2:
            return "yellow";
        case 0:
            return "red";
        }
        return;
    }
    return level.var_583e4a97.var_4bf647dc;
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x56818ed7, Offset: 0x2810
// Size: 0x50
function function_9411a0ff() {
    self util::waittill_any("powerup_timedout", "death", "powerup_grabbed", "powerup_reset");
    level.var_583e4a97.var_a622ee25 = 0;
}

// Namespace namespace_2e6e7fce
// Params 1, eflags: 0x1 linked
// Checksum 0x9f67bfa8, Offset: 0x2868
// Size: 0x804
function function_d1a91c4f(var_e7a36389) {
    var_b0a4c740 = 50;
    a_players = getplayers();
    if (a_players.size == 1) {
        var_b0a4c740 = 65;
    }
    level.var_8cc024f2.var_b454101b.health = var_b0a4c740 * 45;
    level.var_8cc024f2.n_health_max = level.var_8cc024f2.var_b454101b.health;
    str_location = var_e7a36389.script_string + "" + var_e7a36389.script_int;
    if (isdefined(level.var_8cc024f2.var_c5718719) && level.var_8cc024f2.var_c5718719) {
        level.var_3947d49c = 25 + 5 * zm_utility::get_number_of_valid_players();
        /#
            if (isdefined(level.var_f9c3fe97) && level.var_f9c3fe97) {
                level.var_3947d49c = 1;
            }
        #/
    } else {
        level.var_3947d49c = 15;
    }
    level.var_583e4a97.var_f76fd560 = 1;
    var_a57aee42 = var_e7a36389.origin + (0, 0, 3000);
    var_d60b6fd1 = var_e7a36389.angles + (270, 0, 0);
    level.var_8cc024f2.mdl_pod = spawn("script_model", var_a57aee42);
    mdl_pod = level.var_8cc024f2.mdl_pod;
    mdl_pod setmodel("p7_fxanim_zm_stal_pack_a_punch_pod_mod");
    mdl_pod useanimtree(#generic);
    mdl_pod.angles = var_e7a36389.angles;
    foreach (e_player in level.activeplayers) {
        e_player function_7400750d();
    }
    callback::on_connect(&function_7400750d);
    level clientfield::set("drop_pod_streaming", 1);
    level.var_8cc024f2.var_b454101b thread function_e677d12();
    level scene::play("drop_pod_landing_" + str_location, "targetname", mdl_pod);
    mdl_pod setmodel("p7_fxanim_zm_stal_pack_a_punch_base_mod");
    mdl_pod disconnectpaths();
    mdl_pod clientfield::set("drop_pod_hp_light", 1);
    level.var_8cc024f2.var_2d41c802 = spawn("script_model", var_e7a36389.origin);
    var_2d41c802 = level.var_8cc024f2.var_2d41c802;
    var_2d41c802 setmodel("p7_fxanim_zm_stal_pack_a_punch_umbrella_mod");
    var_2d41c802 thread scene::play("p7_fxanim_zm_stal_pack_a_punch_dp_spin_loop_bundle", var_2d41c802);
    foreach (player in level.activeplayers) {
        player playrumbleonentity("zm_stalingrad_drop_pod_landing");
    }
    level.var_8cc024f2 scene::play("p7_fxanim_zm_stal_pack_a_punch_dp_meter_10_bundle", mdl_pod);
    level fx::play("drop_pod_marker", level.var_8cc024f2.origin, var_d60b6fd1, "drop_pod_boom");
    n_obj_id = gameobjects::get_next_obj_id();
    objective_add(n_obj_id, "current", level.var_8cc024f2.mdl_pod, istring("zm_dlc3_objective"));
    objective_setvisibletoall(n_obj_id);
    var_e7a36389 thread function_943a35e3();
    level.var_8cc024f2.var_b454101b zm_attackables::activate();
    attackable = level.var_8cc024f2.var_b454101b;
    if (!(isdefined(level.var_c3de02e0) && level.var_c3de02e0)) {
        if (isdefined(attackable.script_string) && attackable.script_string == "yellow1") {
            var_c7e29595 = (742, 2900, -96);
            foreach (slot in attackable.slot) {
                var_1dd2d452 = distance2dsquared(slot.origin, var_c7e29595);
                if (var_1dd2d452 < 64) {
                    slot.origin = (739, 2888, -92);
                    level.var_c3de02e0 = 1;
                }
            }
        }
    }
    level flag::set("ambient_mortar_fire_on");
    level flag::set("drop_pod_spawned");
    level thread function_306f40e1(str_location);
    level thread function_ba5071c4();
    zm_spawner::register_zombie_death_event_callback(&function_737e2ef4);
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xc4c00a38, Offset: 0x3078
// Size: 0x54
function function_7400750d() {
    if (isdefined(level.var_8cc024f2) && isdefined(level.var_8cc024f2.mdl_pod)) {
        level.var_8cc024f2.mdl_pod clientfield::set("drop_pod_active", 1);
    }
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x33950fde, Offset: 0x30d8
// Size: 0x76
function function_943a35e3() {
    self fx::play("drop_pod_smoke", self.origin + (0, 0, 24), self.angles + (0, 180, 0), "drop_pod_smoke_kill");
    level waittill(#"hash_5ddea7af");
    self notify(#"drop_pod_smoke_kill");
}

// Namespace namespace_2e6e7fce
// Params 1, eflags: 0x1 linked
// Checksum 0x78648993, Offset: 0x3158
// Size: 0x326
function function_5cf8b853(str_location) {
    var_8da17f38 = 0;
    if (isdefined(level.var_8cc024f2.var_c5718719) && level.var_8cc024f2.var_c5718719) {
        switch (str_location) {
        case "ee_factory1":
        case "ee_factory2":
            var_8da17f38 = 15;
            break;
        case "ee_library1":
        case "ee_library2":
            var_8da17f38 = 20;
            break;
        case "ee_command1":
        case "ee_command2":
            var_8da17f38 = 2;
            break;
        }
    } else {
        var_a2a7678a = level.var_583e4a97.s_radio.script_string;
        switch (var_a2a7678a) {
        case "judicial":
            if (str_location == "factory1" || str_location == "library1" || str_location == "alley1") {
                var_8da17f38 = 5;
            } else if (str_location == "factory2" || str_location == "library2" || str_location == "department_store1") {
                var_8da17f38 = 8;
            } else if (str_location == "fountain1") {
                var_8da17f38 = 10;
            }
            break;
        case "factory":
            if (str_location == "judicial1" || str_location == "judicial2" || str_location == "alley1" || str_location == "yellow1") {
                var_8da17f38 = 5;
            } else if (str_location == "judicial3" || str_location == "department_store1" || str_location == "library1") {
                var_8da17f38 = 8;
            } else if (str_location == "fountain1" || str_location == "library2") {
                var_8da17f38 = 10;
            }
            break;
        case "library":
            if (str_location == "judicial1" || str_location == "judicial2" || str_location == "alley1" || str_location == "red1") {
                var_8da17f38 = 5;
            } else if (str_location == "judicial3" || str_location == "department_store1" || str_location == "factory1") {
                var_8da17f38 = 8;
            } else if (str_location == "fountain1" || str_location == "factory2") {
                var_8da17f38 = 10;
            }
            break;
        }
    }
    return var_8da17f38;
}

// Namespace namespace_2e6e7fce
// Params 1, eflags: 0x1 linked
// Checksum 0xa151ce3f, Offset: 0x3488
// Size: 0x2d0
function function_306f40e1(str_location) {
    level endon(#"hash_94bb84a1");
    if (isdefined(level.var_8cc024f2.var_c5718719) && level.var_8cc024f2.var_c5718719) {
        var_a42f2fa9 = 2 + 4 * zm_utility::get_number_of_valid_players();
    } else {
        var_a42f2fa9 = 3 + 1 * zm_utility::get_number_of_valid_players();
    }
    var_14799ce0 = array::random(level.zombie_spawners);
    a_s_spawners = struct::get_array("drop_pod_harraser_" + str_location, "targetname");
    if (isdefined(level.var_8cc024f2.var_c5718719) && (isdefined(level.var_583e4a97.s_radio) || level.var_8cc024f2.var_c5718719)) {
        var_8da17f38 = function_5cf8b853(str_location);
        wait var_8da17f38;
    }
    level.var_8cc024f2.var_17167d70 = zombie_utility::get_current_zombie_count() + level.zombie_total + level.zombie_respawns;
    while (true) {
        if (level.var_8cc024f2.var_d2e1ce53 < var_a42f2fa9) {
            if (isdefined(level.var_8cc024f2.var_c5718719) && level.var_8cc024f2.var_c5718719) {
                level flag::wait_till("spawn_ee_harassers");
            } else {
                level flag::wait_till("spawn_zombies");
            }
            s_spawn = array::random(a_s_spawners);
            ai = zombie_utility::spawn_zombie(var_14799ce0, "drop_pod_harraser", s_spawn);
            if (isdefined(ai)) {
                level.zombie_total--;
                if (level.zombie_respawns > 0) {
                    level.zombie_respawns--;
                }
                level.var_8cc024f2.var_d2e1ce53++;
                ai thread function_51837de8();
            }
        }
        wait 0.3;
    }
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x8c35013b, Offset: 0x3760
// Size: 0xf4
function function_51837de8() {
    level endon(#"hash_94bb84a1");
    self.var_a779ca57 = 1;
    self setphysparams(15, 0, 72);
    if (isdefined(level.var_8cc024f2.var_c5718719) && level.var_8cc024f2.var_c5718719) {
        self.b_ignore_cleanup = 1;
        self.var_9d6ece1a = 1;
    }
    util::wait_network_frame();
    if (self.zombie_move_speed === "walk" || self.zombie_move_speed === "run") {
        self zombie_utility::set_zombie_run_cycle("sprint");
    }
    self.nocrawler = 1;
    self thread function_bb390883();
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xec8ac1c5, Offset: 0x3860
// Size: 0x74
function function_bb390883() {
    level endon(#"hash_94bb84a1");
    self waittill(#"death");
    if (level flag::get("between_rounds")) {
        level.var_583e4a97.var_cac771d3++;
    }
    level.var_8cc024f2.var_d2e1ce53 -= 1;
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xf210cb6e, Offset: 0x38e0
// Size: 0x48
function function_a3d6f85c() {
    level waittill(#"zombie_total_set");
    if (level.var_583e4a97.var_cac771d3 > 0) {
        level.zombie_total -= level.var_583e4a97.var_cac771d3;
    }
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xeaef4f7f, Offset: 0x3930
// Size: 0x4e0
function function_e677d12() {
    level endon(#"hash_94bb84a1");
    mdl_pod = level.var_8cc024f2.mdl_pod;
    mdl_pod thread function_cdc52f02();
    mdl_pod.var_94093c25 = 0;
    mdl_pod.var_16f934b6 = 0;
    mdl_pod.var_2b44423b = "green";
    var_3d2bc4d9 = 0.66;
    var_1ee0bdfc = 0.33;
    mdl_pod showpart("tag_health_green");
    mdl_pod hidepart("tag_health_yellow");
    mdl_pod hidepart("tag_health_red");
    var_603f1f19 = 1;
    while (true) {
        self waittill(#"attackable_damaged");
        if (var_603f1f19) {
            var_603f1f19 = 0;
            if (!mdl_pod zm_stalingrad_util::function_1af75b1b(600)) {
                level thread zm_stalingrad_vo::function_90ce0342();
            }
        }
        mdl_pod playsound("zmb_pod_zombie_melee_hit");
        n_health_percent = self.health / level.var_8cc024f2.n_health_max;
        if (n_health_percent >= var_3d2bc4d9) {
            mdl_pod showpart("tag_health_green");
            mdl_pod hidepart("tag_health_yellow");
            mdl_pod hidepart("tag_health_red");
        } else if (n_health_percent < var_3d2bc4d9 && n_health_percent >= var_1ee0bdfc) {
            if (mdl_pod.var_2b44423b != "yellow") {
                mdl_pod.var_2b44423b = "yellow";
                mdl_pod clientfield::set("drop_pod_hp_light", 2);
            }
            mdl_pod hidepart("tag_health_green");
            mdl_pod showpart("tag_health_yellow");
            mdl_pod hidepart("tag_health_red");
            mdl_pod.var_2d5af28c = 1;
            if (!(isdefined(mdl_pod.var_94093c25) && mdl_pod.var_94093c25)) {
                mdl_pod playsound("zmb_pod_alarm_health_change");
                mdl_pod.var_94093c25 = 1;
            }
        } else if (n_health_percent < var_1ee0bdfc) {
            if (mdl_pod.var_2b44423b != "red") {
                mdl_pod.var_2b44423b = "red";
                mdl_pod clientfield::set("drop_pod_hp_light", 3);
            }
            mdl_pod hidepart("tag_health_green");
            mdl_pod hidepart("tag_health_yellow");
            mdl_pod showpart("tag_health_red");
            mdl_pod notify(#"hash_3ae8114");
            mdl_pod.var_2d5af28c = 1;
            if (!(isdefined(mdl_pod.var_16f934b6) && mdl_pod.var_16f934b6)) {
                mdl_pod playsound("zmb_pod_alarm_health_critical");
                mdl_pod.var_16f934b6 = 1;
            }
        }
        if (self.health <= 0) {
            mdl_pod notify(#"hash_b9ff0fe2");
            var_51d4ce0d = 1;
            level thread function_94bb84a1(level.var_8cc024f2, var_51d4ce0d);
        }
    }
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xdb0f0223, Offset: 0x3e18
// Size: 0x1cc
function function_cdc52f02() {
    level endon(#"hash_94bb84a1");
    self waittill(#"hash_3ae8114");
    var_b454101b = level.var_8cc024f2.var_b454101b;
    var_e975a0cb = 0;
    self thread function_1ce76e16();
    while (true) {
        n_health_percent = var_b454101b.health / level.var_8cc024f2.n_health_max;
        if (n_health_percent > 0.15) {
            wait 0.5;
            continue;
        }
        if (var_e975a0cb) {
            self hidepart("tag_health_green");
            self hidepart("tag_health_yellow");
            self showpart("tag_health_red");
            var_e975a0cb = 0;
        } else {
            self hidepart("tag_health_green");
            self hidepart("tag_health_yellow");
            self hidepart("tag_health_red");
            var_e975a0cb = 1;
        }
        if (n_health_percent < 0.06) {
            wait 0.1;
            continue;
        }
        if (n_health_percent < 0.1) {
            wait 0.25;
            continue;
        }
        wait 0.5;
    }
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xa5cd5f9a, Offset: 0x3ff0
// Size: 0x3e
function function_1ce76e16() {
    level endon(#"hash_94bb84a1");
    while (isdefined(self)) {
        self playsound("zmb_pod_alarm_health_repeating");
        wait 1;
    }
}

// Namespace namespace_2e6e7fce
// Params 2, eflags: 0x1 linked
// Checksum 0x7c2e79ad, Offset: 0x4038
// Size: 0x76c
function function_94bb84a1(var_e7a36389, var_51d4ce0d) {
    level notify(#"hash_94bb84a1");
    level flag::clear("drop_pod_active");
    level flag::clear("advance_drop_pod_round");
    zm_spawner::deregister_zombie_death_event_callback(&function_737e2ef4);
    level.var_8cc024f2.var_b454101b zm_attackables::deactivate();
    if (!var_51d4ce0d) {
        /#
            iprintlnbold("<dev string:x28>");
            if (level.var_583e4a97.var_365bcb3c >= 3 && !level flag::get("<dev string:x3b>")) {
                iprintlnbold("<dev string:x4e>");
            }
        #/
        mdl_pod = level.var_8cc024f2.mdl_pod;
        var_2d41c802 = level.var_8cc024f2.var_2d41c802;
        var_2d41c802 scene::play("p7_fxanim_zm_stal_pack_a_punch_dp_spin_end_bundle", var_2d41c802);
        var_e7a36389 thread function_78a4f940();
        mdl_pod stoprumble("zm_stalingrad_drop_pod_ambient");
        wait 2;
        mdl_pod thread scene::play("p7_fxanim_zm_stal_pack_a_punch_dp_hatch_bundle", mdl_pod);
        if (isdefined(var_e7a36389.var_c5718719) && var_e7a36389.var_c5718719) {
            var_fb6d6762 = var_e7a36389.origin + (0, 0, 32);
            level thread zm_stalingrad_ee_main::function_7e6865e3(var_fb6d6762);
        } else {
            if (level.var_583e4a97.var_365bcb3c < 3) {
                str_part = zm_stalingrad_pap::function_d32eac7f();
                mdl_part = level zm_craftables::function_1f5d26ed("dragonride", str_part);
                mdl_part.origin = var_e7a36389.origin + (0, 0, 32);
                mdl_part setvisibletoall();
                mdl_part thread fx::play("drop_pod_reward_glow", mdl_part.origin, undefined, "dragonride" + "_" + str_part + "_found", 1);
                mdl_part thread zm_stalingrad_util::function_3fbe7d5f();
                level.var_583e4a97.var_19c5f310 = mdl_part;
            } else {
                str_powerup = zm_powerups::get_regular_random_powerup_name();
                e_powerup = zm_powerups::specific_powerup_drop(str_powerup, mdl_pod.origin - (0, 0, 8));
                e_powerup setscale(0.5);
                e_powerup thread function_8f66c62a();
            }
            foreach (player in level.activeplayers) {
                player zm_score::add_to_player_score(500, 1);
                if (!(isdefined(mdl_pod.var_2d5af28c) && mdl_pod.var_2d5af28c)) {
                    player notify(#"hash_2d087eca");
                }
            }
            level thread zm_stalingrad_vo::function_73928e79(var_e7a36389.origin);
            level function_503cfe0f(var_e7a36389);
        }
    } else {
        level thread zm_stalingrad_vo::function_2b34512a(level.var_8cc024f2.mdl_pod.origin);
        if (isdefined(var_e7a36389.var_c5718719) && var_e7a36389.var_c5718719) {
            var_e7a36389 thread function_78a4f940();
            level notify(#"ee_defend_failed");
        } else {
            var_e7a36389 thread function_4843856e();
        }
    }
    var_1787c657 = spawn("trigger_radius", level.var_8cc024f2.origin, 0, 115, 115);
    var_1787c657 function_3653ea22(var_51d4ce0d, var_e7a36389);
    level.var_7d59e517 = level.var_8cc024f2;
    level.var_8cc024f2.n_current_progress = 0;
    level.var_8cc024f2.var_d2e1ce53 = 0;
    level.var_583e4a97.var_caa5bc3e = undefined;
    level.var_583e4a97.var_a622ee25 = 0;
    level notify(#"drop_pod_boom");
    level.var_8cc024f2.mdl_pod notify(#"hash_6ece33ec");
    level.var_8cc024f2.mdl_pod connectpaths();
    level.var_8cc024f2.mdl_pod delete();
    level.var_8cc024f2.var_2d41c802 delete();
    level notify("pod_" + var_e7a36389.script_string + var_e7a36389.script_int + "_lower");
    util::wait_network_frame();
    level.var_8cc024f2 = undefined;
    level notify(#"hash_5ddea7af");
    level clientfield::set("drop_pod_streaming", 0);
    level flag::clear("drop_pod_spawned");
}

// Namespace namespace_2e6e7fce
// Params 2, eflags: 0x1 linked
// Checksum 0x3733d93, Offset: 0x47b0
// Size: 0x3cc
function function_3653ea22(var_51d4ce0d, var_e7a36389) {
    if (!var_51d4ce0d) {
        if (isdefined(var_e7a36389.var_c5718719) && var_e7a36389.var_c5718719) {
            str_result = level util::waittill_any_return("ee_defend_failed", "ee_cargo_retrieved");
            if (str_result == "ee_cargo_retrieved") {
                wait 1.5;
            }
        } else {
            level waittill(#"hash_8d3f0071");
            wait 3;
            if (isdefined(level.var_583e4a97.var_19c5f310)) {
                level.var_583e4a97.var_19c5f310.origin = (0, 0, -273);
                level.var_583e4a97.var_19c5f310 = undefined;
            }
        }
    }
    a_e_zombies = self array::get_touching(getaiteamarray("axis"));
    a_e_players = self array::get_touching(level.activeplayers);
    var_e7a36389 thread fx::play("drop_pod_go_boom", var_e7a36389.origin);
    playrumbleonposition("zm_stalingrad_drop_pod_explosion", var_e7a36389.origin);
    playsoundatposition("zmb_pod_explode", var_e7a36389.origin);
    for (i = 0; i < a_e_zombies.size; i++) {
        if (isdefined(a_e_zombies[i])) {
            a_e_zombies[i] dodamage(a_e_zombies[i].health, self.origin);
            if (i < 3) {
                n_random_x = randomfloatrange(-3, 3);
                n_random_y = randomfloatrange(-3, 3);
                a_e_zombies[i] startragdoll(1);
                a_e_zombies[i] launchragdoll(300 * vectornormalize(a_e_zombies[i].origin - var_e7a36389.origin + (n_random_x, n_random_y, 30)), "torso_lower");
            }
        }
    }
    foreach (e_target in a_e_players) {
        if (isdefined(e_target)) {
            e_target dodamage(15, self.origin);
        }
    }
    self delete();
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x60cf9054, Offset: 0x4b88
// Size: 0x22
function function_8f66c62a() {
    while (isdefined(self)) {
        wait 1;
    }
    level notify(#"hash_8d3f0071");
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x153f0dde, Offset: 0x4bb8
// Size: 0x3ec
function function_78a4f940() {
    var_5f1a4e03 = "countermeasures_spawns";
    level thread zm_stalingrad_util::function_3804dbf1(1, var_5f1a4e03);
    level flag::clear("spawn_ee_harassers");
    wait 0.5;
    var_1f6e1fda = getaiteamarray("axis");
    var_31c9e19 = level.players[0].team;
    foreach (zombie in var_1f6e1fda) {
        if (isdefined(zombie.marked_for_death) && zombie.marked_for_death) {
            continue;
        }
        zombie.marked_for_death = 1;
        zombie clientfield::increment("zm_nuked");
        if (!(isdefined(zombie.exclude_cleanup_adding_to_total) && zombie.exclude_cleanup_adding_to_total)) {
            level.zombie_total++;
            if (zombie.health < zombie.maxhealth) {
                if (!isdefined(level.var_5a487977[zombie.archetype])) {
                    level.var_5a487977[zombie.archetype] = [];
                }
                if (!isdefined(level.var_5a487977[zombie.archetype])) {
                    level.var_5a487977[zombie.archetype] = [];
                } else if (!isarray(level.var_5a487977[zombie.archetype])) {
                    level.var_5a487977[zombie.archetype] = array(level.var_5a487977[zombie.archetype]);
                }
                level.var_5a487977[zombie.archetype][level.var_5a487977[zombie.archetype].size] = zombie.health;
            }
        }
    }
    foreach (zombie in var_1f6e1fda) {
        wait randomfloatrange(0.1, 0.3);
        if (!isdefined(zombie)) {
            break;
        }
        zombie zombie_utility::reset_attack_spot();
        zombie.var_4d11bb60 = 1;
        zombie kill();
    }
    level thread zm_stalingrad_util::function_3804dbf1(0, var_5f1a4e03);
    level flag::set("spawn_ee_harassers");
}

// Namespace namespace_2e6e7fce
// Params 1, eflags: 0x1 linked
// Checksum 0xfeb9c708, Offset: 0x4fb0
// Size: 0xdc
function function_503cfe0f(var_e7a36389) {
    str_location = var_e7a36389.script_string + "" + var_e7a36389.script_int;
    if (str_location == "judicial1" || str_location == "judicial2") {
        level.var_583e4a97.var_5d8406ed["judicial1"].b_available = 0;
        level.var_583e4a97.var_5d8406ed["judicial2"].b_available = 0;
        return;
    }
    level.var_583e4a97.var_5d8406ed[str_location].b_available = 0;
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x4b9bd386, Offset: 0x5098
// Size: 0x78
function function_4843856e() {
    str_location = self.script_string + "" + self.script_int;
    level.var_583e4a97.var_5d8406ed[str_location].b_available = 0;
    wait 120;
    level.var_583e4a97.var_5d8406ed[str_location].b_available = 1;
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0x94abb760, Offset: 0x5118
// Size: 0x190
function function_ba5071c4() {
    level endon(#"hash_94bb84a1");
    while (true) {
        var_9b6a75aa = 1;
        foreach (e_player in level.players) {
            if (!zm_utility::is_player_valid(e_player, 0, 1)) {
                continue;
            }
            if (isdefined(e_player.zone_name)) {
                if (e_player.zone_name != "pavlovs_A_zone" && e_player.zone_name != "pavlovs_B_zone" && e_player.zone_name != "pavlovs_C_zone") {
                    var_9b6a75aa = 0;
                    break;
                }
                continue;
            }
            if (!array::contains(level.var_163a43e4, e_player)) {
                var_9b6a75aa = 0;
                break;
            }
        }
        if (var_9b6a75aa) {
            level thread function_94bb84a1(level.var_8cc024f2, 1);
            return;
        }
        wait 1;
    }
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xd0d1ce43, Offset: 0x52b0
// Size: 0x1e4
function function_737e2ef4() {
    if (isdefined(self.var_4d11bb60) && self.var_4d11bb60 || self.archetype === "sentinel_drone") {
        return;
    }
    var_71588c92 = level.var_8cc024f2.var_17167d70;
    if (isdefined(var_71588c92)) {
        level.var_8cc024f2.var_17167d70--;
        if (level.var_8cc024f2.var_17167d70 == 0) {
            level flag::set("advance_drop_pod_round");
        }
    }
    var_f64bb476 = level.var_8cc024f2.mdl_pod;
    e_goal = level.var_8cc024f2.var_ab891f49;
    if (self istouching(e_goal)) {
        self clientfield::increment("drop_pod_score_beam_fx", 1);
        level.var_8cc024f2.n_current_progress++;
        level function_53482422();
        println("<dev string:x6c>" + level.var_8cc024f2.n_current_progress + "<dev string:x7a>" + level.var_3947d49c);
        if (level.var_8cc024f2.n_current_progress >= level.var_3947d49c && level.var_583e4a97.var_f76fd560) {
            level.var_583e4a97.var_f76fd560 = 0;
            var_5af77991 = 0;
            level thread function_94bb84a1(level.var_8cc024f2, var_5af77991);
        }
    }
}

// Namespace namespace_2e6e7fce
// Params 0, eflags: 0x1 linked
// Checksum 0xa987da08, Offset: 0x54a0
// Size: 0xd4
function function_53482422() {
    level endon(#"hash_94bb84a1");
    mdl_pod = level.var_8cc024f2.mdl_pod;
    var_1e808310 = level.var_8cc024f2.n_current_progress / level.var_3947d49c;
    n_score = int(var_1e808310 * 100);
    var_545b3160 = zm_utility::round_up_to_ten(n_score);
    if (var_545b3160 <= 100) {
        level.var_8cc024f2 scene::play("p7_fxanim_zm_stal_pack_a_punch_dp_meter_" + var_545b3160 + "_bundle", mdl_pod);
    }
}

// Namespace namespace_2e6e7fce
// Params 1, eflags: 0x0
// Checksum 0xd34d22c5, Offset: 0x5580
// Size: 0xde
function function_a0a37968(var_db0ac3dc) {
    var_8aa74c19 = [];
    foreach (s_location in level.var_583e4a97.var_5d8406ed) {
        if (s_location.script_string != var_db0ac3dc && s_location.b_available == 1) {
            array::add(var_8aa74c19, s_location);
        }
    }
    return var_8aa74c19;
}

// Namespace namespace_2e6e7fce
// Params 2, eflags: 0x1 linked
// Checksum 0xa52acbe7, Offset: 0x5668
// Size: 0x270
function function_8df46779(var_304415d7, var_57a3fb53) {
    self endon(#"disconnect");
    if (!isdefined(self.var_9e067339)) {
        self.var_9e067339 = newclienthudelem(self);
        self.var_9e067339.location = 0;
        self.var_9e067339.alignx = "center";
        self.var_9e067339.aligny = "bottom";
        self.var_9e067339.x = 0;
        self.var_9e067339.y = 80;
        self.var_9e067339.foreground = 1;
        self.var_9e067339.fontscale = 1.5;
        self.var_9e067339.horzalign = "center";
        self.var_9e067339.vertalign = "center_safearea";
        self.var_9e067339.sort = 20;
        self.var_9e067339.og_scale = 1;
        self.var_9e067339.color = (1, 1, 1);
        self.var_9e067339.alpha = 0;
    }
    switch (var_57a3fb53) {
    case "code_cylinder_red":
        self.var_9e067339 settext(%ZM_STALINGRAD_DROP_POD_CYLINDER_ACQUIRED_RED);
        break;
    case "code_cylinder_yellow":
        self.var_9e067339 settext(%ZM_STALINGRAD_DROP_POD_CYLINDER_ACQUIRED_YELLOW);
        break;
    case "code_cylinder_blue":
        self.var_9e067339 settext(%ZM_STALINGRAD_DROP_POD_CYLINDER_ACQUIRED_BLUE);
        break;
    default:
        self.var_9e067339 settext("");
        break;
    }
    self.var_9e067339.alpha = 1;
    self.var_9e067339 fadeovertime(5);
    self.var_9e067339.alpha = 0;
}

