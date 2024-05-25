#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_blockers;
#using scripts/zm/zm_genesis_pap_quest;
#using scripts/zm/zm_genesis_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/vehicle_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#namespace namespace_57c513b2;

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0xd27640a5, Offset: 0x550
// Size: 0x7c
function main() {
    level flag::init("apothicon_near_trap");
    level flag::init("apothicon_trapped");
    level flag::init("pap_room_open");
    level thread function_e30ec73e();
}

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0x49463e, Offset: 0x5d8
// Size: 0xbc
function function_6dd507bc() {
    self endon(#"death");
    level endon(#"hash_b14df48f");
    while (true) {
        if (isdefined(level.hostmigrationtimer) && level.hostmigrationtimer) {
            util::wait_network_frame();
            continue;
        }
        self function_3dd4e95e("zm_genesis_apothicon_rumble");
        wait(0.1);
        while (level flag::get("apothicon_near_trap")) {
            util::wait_network_frame();
        }
    }
}

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0x28b39e5d, Offset: 0x6a0
// Size: 0xb0
function function_16364bba() {
    for (i = 0; i < 5; i++) {
        self waittill(#"hash_b58a19d3");
        self function_3dd4e95e("zm_genesis_apothicon_roar");
    }
    self waittill(#"hash_c091a029");
    while (!level flag::get("pap_room_open")) {
        self function_3dd4e95e("zm_genesis_apothicon_rumble");
        wait(0.1);
    }
}

// Namespace namespace_57c513b2
// Params 1, eflags: 0x1 linked
// Checksum 0xa89a3415, Offset: 0x758
// Size: 0x10a
function function_3dd4e95e(str_rumble) {
    self endon(#"death");
    level endon(#"hash_b14df48f");
    var_41666ff0 = 5000 * 5000;
    foreach (e_player in level.activeplayers) {
        n_dist = distancesquared(e_player.origin, self.origin);
        if (n_dist < var_41666ff0) {
            self playrumbleonentity(str_rumble);
        }
    }
}

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0x306ae56a, Offset: 0x870
// Size: 0xec
function function_e30ec73e() {
    s_start = struct::get("apothicon_intro_bundle");
    scene::add_scene_func("cin_genesis_apothicon_papintro", &function_860971ff, "play");
    scene::add_scene_func("cin_genesis_apothicon_papintro", &function_a2294b99, "done");
    level thread scene::init("cin_genesis_apothicon_papintro");
    level waittill(#"start_zombie_round_logic");
    level thread function_4fa16b52();
    wait(3);
    level thread scene::play("cin_genesis_apothicon_papintro");
}

// Namespace namespace_57c513b2
// Params 1, eflags: 0x1 linked
// Checksum 0x35cd083c, Offset: 0x968
// Size: 0x3c
function function_860971ff(a_ents) {
    level.var_e7e8e5d6 = a_ents["zm_apothicon_god"];
    level.var_e7e8e5d6 thread function_6dd507bc();
}

// Namespace namespace_57c513b2
// Params 1, eflags: 0x1 linked
// Checksum 0xcc3ddaba, Offset: 0x9b0
// Size: 0x2c
function function_a2294b99(a_ents) {
    a_ents["zm_apothicon_god"] thread function_65305393();
}

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0x9d72e5e1, Offset: 0x9e8
// Size: 0x124
function function_4fa16b52() {
    var_446599c2 = struct::get("apothicon_trap_trig", "targetname");
    var_e80ed647 = struct::get("apothicon_trap_door", "targetname");
    if (isdefined(var_446599c2.script_flag) && !isdefined(level.flag[var_446599c2.script_flag])) {
        level flag::init(var_446599c2.script_flag);
    }
    var_446599c2 thread function_d5419c08();
    var_cf61f0f8 = var_e80ed647 zm_unitrigger::create_unitrigger(%ZM_GENESIS_APOTHICON_DOOR, -128, &function_d9879865, undefined, "unitrigger_radius");
    var_cf61f0f8 thread function_16d77af();
}

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0xfaa8d5d, Offset: 0xb18
// Size: 0x21a
function function_d5419c08() {
    s_unitrigger = self zm_unitrigger::function_828cd696(%ZM_GENESIS_APOTHICON_TRAP_READY, undefined, &function_f94d9124);
    s_unitrigger.inactive_reassess_time = 0.1;
    a_e_parts = getentarray(self.target, "targetname");
    foreach (e_part in a_e_parts) {
        if (e_part.script_noteworthy === "clip") {
            s_unitrigger.e_clip = e_part;
            continue;
        }
        s_unitrigger.e_door = e_part;
    }
    self thread function_a15e0860(s_unitrigger);
    while (true) {
        e_player = self waittill(#"trigger_activated");
        if (!level flag::get("apothicon_near_trap")) {
            continue;
        }
        playsoundatposition("zmb_deathray_activate_console", self.origin);
        exploder::exploder("fxexp_361");
        level function_73f1531();
        e_player notify(#"hash_7cbc9d72");
        if (isdefined(self.script_flag)) {
            level flag::set(self.script_flag);
        }
        return;
    }
}

// Namespace namespace_57c513b2
// Params 1, eflags: 0x1 linked
// Checksum 0x71c7cc51, Offset: 0xd40
// Size: 0x64
function function_a15e0860(s_unitrigger) {
    level flag::wait_till(self.script_flag);
    s_unitrigger.e_clip delete();
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

// Namespace namespace_57c513b2
// Params 1, eflags: 0x1 linked
// Checksum 0x8a6aa93, Offset: 0xdb0
// Size: 0x90
function function_f94d9124(e_player) {
    if (level flag::get("apothicon_trapped") || !level flag::get("apothicon_near_trap")) {
        self sethintstring(%);
        return false;
    }
    self sethintstring(%ZM_GENESIS_APOTHICON_TRAP_READY);
    return true;
}

// Namespace namespace_57c513b2
// Params 1, eflags: 0x1 linked
// Checksum 0x2d596ddd, Offset: 0xe48
// Size: 0x70
function function_d9879865(e_player) {
    if (level flag::get("apothicon_trapped")) {
        self sethintstring(%);
        return false;
    }
    self sethintstring(%ZM_GENESIS_APOTHICON_DOOR);
    return true;
}

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0x147f592d, Offset: 0xec0
// Size: 0x3c
function function_16d77af() {
    level flag::wait_till("apothicon_trapped");
    zm_unitrigger::unregister_unitrigger(self);
}

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0xc232f695, Offset: 0xf08
// Size: 0x6c
function function_65305393() {
    self thread function_3187e8a6();
    function_d6eeedf0(0);
    level flag::wait_till("all_power_on");
    self thread function_b89b1260();
}

// Namespace namespace_57c513b2
// Params 1, eflags: 0x1 linked
// Checksum 0x9b67bf19, Offset: 0xf80
// Size: 0xc4
function function_d6eeedf0(n_state) {
    var_329d83b2 = getent("tesla_trap_console", "targetname");
    if (n_state == 0) {
        var_329d83b2 showpart("j_flash_off");
        var_329d83b2 hidepart("j_flash_on");
        return;
    }
    var_329d83b2 showpart("j_flash_off");
    var_329d83b2 hidepart("j_flash_on");
}

// Namespace namespace_57c513b2
// Params 1, eflags: 0x1 linked
// Checksum 0x64c2feff, Offset: 0x1050
// Size: 0xc6
function function_81a3e18f(b_on) {
    for (i = 1; i <= 4; i++) {
        if (b_on) {
            self showpart("j_flash_0" + i);
            self hidepart("j_green_0" + i);
            continue;
        }
        self hidepart("j_flash_0" + i);
        self showpart("j_green_0" + i);
    }
}

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0x12a52b91, Offset: 0x1120
// Size: 0x1fc
function function_78f98ad9() {
    var_329d83b2 = getent("tesla_trap_console", "targetname");
    var_329d83b2 function_81a3e18f(1);
    var_329d83b2 function_d6eeedf0(1);
    var_329d83b2 playsound("zmb_deathray_console_ready");
    while (level flag::get("apothicon_near_trap")) {
        for (i = 1; i < 5; i++) {
            hidemiscmodels("apothicon_trap_power_on" + i);
            showmiscmodels("apothicon_trap_power_off" + i);
        }
        wait(0.2);
        for (i = 1; i < 5; i++) {
            hidemiscmodels("apothicon_trap_power_off" + i);
            showmiscmodels("apothicon_trap_power_on" + i);
        }
        wait(0.2);
        if (level flag::get("apothicon_trapped")) {
            break;
        }
    }
    var_329d83b2 function_d6eeedf0(0);
    var_329d83b2 function_81a3e18f(0);
    var_329d83b2 playsound("zmb_deathray_console_unavailable");
}

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0x901d033e, Offset: 0x1328
// Size: 0x18a
function function_b89b1260() {
    level endon(#"hash_b89b1260");
    level endon(#"hash_b14df48f");
    var_217ba6c8 = struct::get("apothicon_approach_tesla", "targetname");
    var_329d83b2 = getent("tesla_trap_console", "targetname");
    while (true) {
        level waittill(#"hash_864571db");
        playsoundatposition("evt_apothicon_alarm", (714, 303, 91));
        level flag::set("apothicon_near_trap");
        level thread function_78f98ad9();
        /#
        #/
        level waittill(#"hash_53fb6fd3");
        level flag::clear("apothicon_near_trap");
        for (i = 1; i < 5; i++) {
            hidemiscmodels("apothicon_trap_power_off" + i);
            showmiscmodels("apothicon_trap_power_on" + i);
        }
    }
}

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0x96138b2a, Offset: 0x14c0
// Size: 0x58
function function_3187e8a6() {
    level endon(#"hash_b14df48f");
    while (true) {
        level scene::play("cin_genesis_apothicon_flightpath", self);
        level function_1ff56fb0("cin_genesis_apothicon_flightpath");
    }
}

// Namespace namespace_57c513b2
// Params 0, eflags: 0x1 linked
// Checksum 0xe147cb38, Offset: 0x1520
// Size: 0x13c
function function_73f1531() {
    level flag::set("apothicon_trapped");
    for (i = 1; i < 5; i++) {
        hidemiscmodels("apothicon_trap_power_off" + i);
        showmiscmodels("apothicon_trap_power_on" + i);
    }
    level notify(#"hash_b89b1260");
    level.var_e7e8e5d6 thread function_3dd4e95e("zm_genesis_apothicon_roar");
    level waittill(#"hash_18a15850");
    level.var_e7e8e5d6 thread function_16364bba();
    level scene::play("cin_genesis_apothicon_electrocution_trap", level.var_e7e8e5d6);
    level flag::set("pap_room_open");
    namespace_3ddd867f::function_8d5c3682();
}

// Namespace namespace_57c513b2
// Params 1, eflags: 0x1 linked
// Checksum 0x60042743, Offset: 0x1668
// Size: 0x54
function function_1ff56fb0(str_scene) {
    s_scene = struct::get(str_scene, "scriptbundlename");
    if (isdefined(s_scene)) {
        s_scene.scene_played = 0;
    }
}

