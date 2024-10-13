#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_ee_main_step_3;

// Namespace zm_tomb_ee_main_step_3
// Params 0, eflags: 0x1 linked
// Checksum 0x7d98c26f, Offset: 0x470
// Size: 0x54
function init() {
    namespace_6e97c459::function_5a90ed82("little_girl_lost", "step_3", &init_stage, &function_7747c56, &function_cc3f3f6a);
}

// Namespace zm_tomb_ee_main_step_3
// Params 0, eflags: 0x1 linked
// Checksum 0xb44b34fb, Offset: 0x4d0
// Size: 0x3c
function init_stage() {
    level.var_ca733eed = "step_3";
    level.var_db78371d = &function_c4a4017;
    function_eec583a7();
}

// Namespace zm_tomb_ee_main_step_3
// Params 0, eflags: 0x1 linked
// Checksum 0x2a196402, Offset: 0x518
// Size: 0x94
function function_7747c56() {
    /#
        iprintln(level.var_ca733eed + "<dev string:x28>");
    #/
    level thread function_55c8dc94();
    level flag::wait_till("ee_mech_zombie_hole_opened");
    util::wait_network_frame();
    namespace_6e97c459::function_2f3ced1f("little_girl_lost", level.var_ca733eed);
}

// Namespace zm_tomb_ee_main_step_3
// Params 1, eflags: 0x1 linked
// Checksum 0x6ce2d383, Offset: 0x5b8
// Size: 0x136
function function_cc3f3f6a(success) {
    level.var_db78371d = undefined;
    level notify(#"hash_76ed4ebc");
    level flag::set("fire_link_enabled");
    var_fc05a0cc = getentarray("fire_link_button", "targetname");
    array::delete_all(var_fc05a0cc);
    a_structs = struct::get_array("fire_link", "targetname");
    foreach (unitrigger_stub in a_structs) {
        zm_unitrigger::unregister_unitrigger(unitrigger_stub);
    }
    level notify(#"hash_7bcf8600");
}

// Namespace zm_tomb_ee_main_step_3
// Params 0, eflags: 0x1 linked
// Checksum 0xa159047, Offset: 0x6f8
// Size: 0x1aa
function function_eec583a7() {
    a_structs = struct::get_array("fire_link", "targetname");
    foreach (unitrigger_stub in a_structs) {
        unitrigger_stub.radius = 36;
        unitrigger_stub.height = 256;
        unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
        unitrigger_stub.cursor_hint = "HINT_NOICON";
        unitrigger_stub.require_look_at = 1;
        m_model = spawn("script_model", unitrigger_stub.origin);
        m_model setmodel("p7_zm_ori_button_alarm");
        m_model.angles = unitrigger_stub.angles;
        m_model.targetname = "fire_link_button";
        m_model thread function_faf4afaa(unitrigger_stub);
        util::wait_network_frame();
    }
}

// Namespace zm_tomb_ee_main_step_3
// Params 1, eflags: 0x1 linked
// Checksum 0x69d0d61e, Offset: 0x8b0
// Size: 0xa4
function function_faf4afaa(unitrigger_stub) {
    self endon(#"death");
    self playsoundwithnotify("vox_maxi_robot_sync_0", "sync_done");
    self waittill(#"sync_done");
    wait 0.5;
    self playsoundwithnotify("vox_maxi_robot_await_0", "ready_to_use");
    self waittill(#"ready_to_use");
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_696cf5b4);
}

// Namespace zm_tomb_ee_main_step_3
// Params 0, eflags: 0x1 linked
// Checksum 0x6d684f4, Offset: 0x960
// Size: 0x1ba
function function_55c8dc94() {
    var_54571dd0 = getent("fire_link_damage", "targetname");
    while (!level flag::get("ee_mech_zombie_hole_opened")) {
        damage, attacker, direction, point, type, tagname, modelname, partname, weapon = var_54571dd0 waittill(#"damage");
        if (isdefined(weapon) && weapon.name == "beacon" && level flag::get("fire_link_enabled")) {
            playsoundatposition("zmb_squest_robot_floor_collapse", var_54571dd0.origin);
            wait 3;
            var_7bf7eda5 = getent("easter_mechzombie_spawn", "targetname");
            var_7bf7eda5 delete();
            level flag::set("ee_mech_zombie_hole_opened");
            var_54571dd0 delete();
            return;
        }
    }
}

// Namespace zm_tomb_ee_main_step_3
// Params 1, eflags: 0x1 linked
// Checksum 0xd0fa915e, Offset: 0xb28
// Size: 0x60
function function_c4a4017(valid) {
    var_54571dd0 = getent("fire_link_damage", "targetname");
    if (self istouching(var_54571dd0)) {
        return 1;
    }
    return valid;
}

// Namespace zm_tomb_ee_main_step_3
// Params 0, eflags: 0x1 linked
// Checksum 0x4564865b, Offset: 0xb90
// Size: 0x176
function function_696cf5b4() {
    self endon(#"kill_trigger");
    while (true) {
        player = self waittill(#"trigger");
        self playsound("zmb_squest_robot_button");
        if (level flag::get("three_robot_round")) {
            level thread function_76ed4ebc(self);
            self playsound("zmb_squest_robot_button_activate");
            self playloopsound("zmb_squest_robot_button_timer", 0.5);
            level flag::wait_till_clear("fire_link_enabled");
            self stoploopsound(0.5);
            self playsound("zmb_squest_robot_button_deactivate");
            continue;
        }
        self playsound("vox_maxi_robot_abort_0");
        self playsound("zmb_squest_robot_button_deactivate");
        wait 3;
    }
}

// Namespace zm_tomb_ee_main_step_3
// Params 1, eflags: 0x1 linked
// Checksum 0xd24681a6, Offset: 0xd10
// Size: 0xbc
function function_76ed4ebc(var_56d910c6) {
    level notify(#"hash_76ed4ebc");
    level endon(#"hash_76ed4ebc");
    level flag::set("fire_link_enabled");
    if (isdefined(var_56d910c6)) {
        var_56d910c6 playsound("vox_maxi_robot_activated_0");
    }
    wait 35;
    if (isdefined(var_56d910c6)) {
        var_56d910c6 playsound("vox_maxi_robot_deactivated_0");
    }
    level flag::clear("fire_link_enabled");
}

