#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_craftables;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_powerup_zombie_blood;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_c75c206a;

// Namespace namespace_c75c206a
// Params 0, eflags: 0x1 linked
// Checksum 0xfca571da, Offset: 0x408
// Size: 0x54
function init() {
    namespace_6e97c459::function_5a90ed82("little_girl_lost", "step_2", &init_stage, &function_7747c56, &function_cc3f3f6a);
}

// Namespace namespace_c75c206a
// Params 0, eflags: 0x1 linked
// Checksum 0x536546da, Offset: 0x468
// Size: 0xfa
function init_stage() {
    level.var_ca733eed = "step_2";
    a_structs = struct::get_array("robot_head_staff", "targetname");
    foreach (unitrigger_stub in a_structs) {
        level thread function_db8d80b0(unitrigger_stub);
        util::wait_network_frame();
        util::wait_network_frame();
        util::wait_network_frame();
    }
}

// Namespace namespace_c75c206a
// Params 0, eflags: 0x1 linked
// Checksum 0x57fad352, Offset: 0x570
// Size: 0xac
function function_7747c56() {
    /#
        iprintln(level.var_ca733eed + "unitrigger_radius_use");
    #/
    level flag::wait_till("ee_all_staffs_placed");
    playsoundatposition("zmb_squest_robot_alarm_blast", (-14, -1, 871));
    wait(3);
    util::wait_network_frame();
    namespace_6e97c459::function_2f3ced1f("little_girl_lost", level.var_ca733eed);
}

// Namespace namespace_c75c206a
// Params 1, eflags: 0x1 linked
// Checksum 0xcb690c82, Offset: 0x628
// Size: 0x1a2
function function_cc3f3f6a(success) {
    a_structs = struct::get_array("robot_head_staff", "targetname");
    foreach (struct in a_structs) {
        struct thread function_fa6a0ef1();
        util::wait_network_frame();
        util::wait_network_frame();
        util::wait_network_frame();
    }
    foreach (var_5ec0aa73 in level.var_b0d8f1fe) {
        var_59fc9a02 = namespace_f7a613cf::function_9b485a9(var_5ec0aa73.w_weapon, 0);
        var_59fc9a02.var_260a328b = undefined;
    }
    level notify(#"hash_4c5352e3");
}

// Namespace namespace_c75c206a
// Params 0, eflags: 0x1 linked
// Checksum 0x809eb3bb, Offset: 0x7d8
// Size: 0x16c
function function_fa6a0ef1() {
    playfx(level._effect["teleport_1p"], self.var_80ee51c0.origin);
    playsoundatposition("zmb_footprintbox_disappear", self.var_80ee51c0.origin);
    wait(3);
    if (isdefined(self.var_80ee51c0.var_6226d45)) {
        self.var_80ee51c0.var_6226d45 unlink();
        self.var_80ee51c0.var_6226d45.origin = self.var_80ee51c0.var_8ebd504;
        self.var_80ee51c0.var_6226d45.angles = self.var_80ee51c0.var_80c6672a;
        self.var_80ee51c0.var_f953bb9d.var_260a328b = undefined;
    }
    self.var_8c08a132 delete();
    self.var_80ee51c0 delete();
    self.var_c8d49df delete();
    zm_unitrigger::unregister_unitrigger(self);
}

// Namespace namespace_c75c206a
// Params 1, eflags: 0x1 linked
// Checksum 0xfb7ba83d, Offset: 0x950
// Size: 0x414
function function_db8d80b0(unitrigger_stub) {
    playfx(level._effect["teleport_1p"], unitrigger_stub.origin);
    playsoundatposition("zmb_footprintbox_disappear", unitrigger_stub.origin);
    wait(3);
    unitrigger_stub.radius = 50;
    unitrigger_stub.height = 256;
    unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.require_look_at = 1;
    var_c8d49df = spawn("script_model", unitrigger_stub.origin);
    var_c8d49df setmodel("drone_collision");
    unitrigger_stub.var_c8d49df = var_c8d49df;
    util::wait_network_frame();
    var_80ee51c0 = spawn("script_model", unitrigger_stub.origin);
    var_80ee51c0.angles = unitrigger_stub.angles;
    var_80ee51c0 setmodel("p7_zm_ori_staff_holder");
    unitrigger_stub.var_80ee51c0 = var_80ee51c0;
    util::wait_network_frame();
    var_8c08a132 = spawn("script_model", unitrigger_stub.origin);
    var_8c08a132 setmodel("p7_zm_ori_runes");
    var_8c08a132 linkto(unitrigger_stub.var_80ee51c0, "tag_origin", (0, 15, 40));
    var_8c08a132 hidepart("j_fire");
    var_8c08a132 hidepart("j_ice");
    var_8c08a132 hidepart("j_lightning");
    var_8c08a132 hidepart("j_wind");
    switch (unitrigger_stub.script_noteworthy) {
    case 20:
        var_8c08a132 showpart("j_fire");
        break;
    case 22:
        var_8c08a132 showpart("j_ice");
        break;
    case 21:
        var_8c08a132 showpart("j_lightning");
        break;
    case 19:
        var_8c08a132 showpart("j_wind");
        break;
    }
    var_8c08a132 zm_powerup_zombie_blood::make_zombie_blood_entity();
    unitrigger_stub.var_8c08a132 = var_8c08a132;
    unitrigger_stub.origin += (0, 0, 30);
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_62339bcc);
}

// Namespace namespace_c75c206a
// Params 0, eflags: 0x1 linked
// Checksum 0xa962f0fb, Offset: 0xd70
// Size: 0x178
function function_62339bcc() {
    self endon(#"kill_trigger");
    var_94300349 = "staff_" + self.script_noteworthy;
    var_5ec0aa73 = level.var_b0d8f1fe[var_94300349].w_weapon;
    var_59fc9a02 = namespace_f7a613cf::function_9b485a9(var_5ec0aa73, 0);
    while (true) {
        player = self waittill(#"trigger");
        if (player hasweapon(var_59fc9a02.w_weapon)) {
            var_59fc9a02.var_260a328b = 1;
            player takeweapon(var_59fc9a02.w_weapon);
            namespace_f7a613cf::function_abd72df3(var_59fc9a02.w_weapon);
            level.var_5ec263fe++;
            if (level.var_5ec263fe == 4) {
                level flag::set("ee_all_staffs_placed");
            }
            var_5ec0aa73 thread function_b56abf9d(self.stub.var_80ee51c0);
        }
    }
}

// Namespace namespace_c75c206a
// Params 1, eflags: 0x1 linked
// Checksum 0x7fed698d, Offset: 0xef0
// Size: 0x114
function function_b56abf9d(var_80ee51c0) {
    var_6226d45 = getent("craftable_" + self.name + "_zm", "targetname");
    var_80ee51c0.var_f953bb9d = self;
    var_80ee51c0.var_6226d45 = var_6226d45;
    var_80ee51c0.var_80c6672a = var_6226d45.angles;
    var_80ee51c0.var_8ebd504 = var_6226d45.origin;
    var_6226d45 linkto(var_80ee51c0, "tag_origin", (0, 9, 30), (0, 0, 0));
    var_6226d45 show();
    var_80ee51c0 playsound("zmb_squest_robot_place_staff");
}

