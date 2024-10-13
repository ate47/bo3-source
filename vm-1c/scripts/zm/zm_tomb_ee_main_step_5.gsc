#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_powerup_zombie_blood;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_ee_main_step_5;

// Namespace zm_tomb_ee_main_step_5
// Params 0, eflags: 0x1 linked
// Checksum 0x7394ab09, Offset: 0x470
// Size: 0x54
function init() {
    namespace_6e97c459::function_5a90ed82("little_girl_lost", "step_5", &init_stage, &function_7747c56, &function_cc3f3f6a);
}

// Namespace zm_tomb_ee_main_step_5
// Params 0, eflags: 0x1 linked
// Checksum 0x119a68a1, Offset: 0x4d0
// Size: 0x34
function init_stage() {
    level.var_ca733eed = "step_5";
    level.callbackvehicledamage = &function_a43eafbe;
    level.zombie_ai_limit--;
}

// Namespace zm_tomb_ee_main_step_5
// Params 0, eflags: 0x1 linked
// Checksum 0xb43ebf60, Offset: 0x510
// Size: 0x94
function function_7747c56() {
    /#
        iprintln(level.var_ca733eed + "<dev string:x28>");
    #/
    level thread function_4100e141();
    level flag::wait_till("ee_maxis_drone_retrieved");
    util::wait_network_frame();
    namespace_6e97c459::function_2f3ced1f("little_girl_lost", level.var_ca733eed);
}

// Namespace zm_tomb_ee_main_step_5
// Params 1, eflags: 0x1 linked
// Checksum 0xae415ba0, Offset: 0x5b0
// Size: 0x22
function function_cc3f3f6a(success) {
    level.zombie_ai_limit++;
    level notify(#"hash_8b0d379e");
}

// Namespace zm_tomb_ee_main_step_5
// Params 0, eflags: 0x1 linked
// Checksum 0xbe347344, Offset: 0x5e0
// Size: 0x514
function function_4100e141() {
    var_62bb4e65 = struct::get("air_crystal_biplane_pos", "targetname");
    var_843c3629 = spawnvehicle("biplane_zm", (0, 0, 0), (0, 0, 0), "zombie_blood_biplane");
    var_843c3629 flag::init("biplane_down");
    var_843c3629 zm_powerup_zombie_blood::make_zombie_blood_entity();
    var_843c3629 playloopsound("zmb_zombieblood_3rd_plane_loop", 1);
    var_843c3629.health = 10000;
    var_843c3629 setcandamage(1);
    var_843c3629 setforcenocull();
    var_843c3629 attachpath(getvehiclenode("biplane_start", "targetname"));
    var_843c3629 setspeed(75, 15, 5);
    var_843c3629 startpath();
    var_843c3629 clientfield::set("ee_plane_fx", 1);
    var_843c3629 flag::wait_till("biplane_down");
    var_843c3629 playsound("wpn_rocket_explode");
    var_8ec5296f = getentarray("zombie_spawner_dig", "script_noteworthy")[0];
    var_239be310 = zombie_utility::spawn_zombie(var_8ec5296f, "zombie_blood_pilot");
    var_239be310 util::magic_bullet_shield();
    var_239be310.ignore_enemy_count = 1;
    var_239be310 zm_powerup_zombie_blood::make_zombie_blood_entity();
    var_239be310 forceteleport(var_843c3629.origin, var_843c3629.angles);
    var_239be310.sndname = "capzomb";
    var_239be310.ignore_nuke = 1;
    var_239be310.var_5b62506e = 1;
    var_239be310.ignore_cleanup_mgr = 1;
    playfx(level._effect["biplane_explode"], var_843c3629.origin);
    var_843c3629 delete();
    var_1c47027c = struct::get_array("pilot_goal", "script_noteworthy");
    var_1c47027c = util::get_array_of_closest(var_239be310.origin, var_1c47027c);
    linker = spawn("script_model", var_239be310.origin);
    linker setmodel("tag_origin");
    var_239be310 linkto(linker);
    linker moveto(var_1c47027c[0].origin, 3);
    linker waittill(#"movedone");
    linker delete();
    var_239be310 util::stop_magic_bullet_shield();
    level thread function_dd080460(var_239be310);
    var_239be310.ignoreall = 1;
    var_239be310.zombie_move_speed = "sprint";
    var_239be310 zombie_utility::set_zombie_run_cycle("sprint");
    var_239be310.zombie_think_done = 1;
    var_239be310 thread function_1ec0c311(var_1c47027c[0]);
    var_239be310 waittill(#"death");
    level thread function_6337b233(var_239be310.origin, var_239be310.angles);
}

// Namespace zm_tomb_ee_main_step_5
// Params 1, eflags: 0x1 linked
// Checksum 0xd6241b94, Offset: 0xb00
// Size: 0xbc
function function_dd080460(var_239be310) {
    sndent = spawn("script_origin", var_239be310.origin);
    sndent playloopsound("zmb_zombieblood_3rd_loop_other");
    while (isdefined(var_239be310) && isalive(var_239be310)) {
        sndent.origin = var_239be310.origin;
        wait 0.3;
    }
    sndent delete();
}

// Namespace zm_tomb_ee_main_step_5
// Params 1, eflags: 0x1 linked
// Checksum 0x77b8383, Offset: 0xbc8
// Size: 0x9c
function function_1ec0c311(s_start) {
    self endon(#"death");
    for (s_goal = s_start; isalive(self); s_goal = struct::get(s_goal.target, "targetname")) {
        self setgoalpos(s_goal.origin);
        self waittill(#"goal");
    }
}

// Namespace zm_tomb_ee_main_step_5
// Params 15, eflags: 0x1 linked
// Checksum 0x6a7b560e, Offset: 0xc70
// Size: 0x104
function function_a43eafbe(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, var_740c2c73, v_point, v_dir, str_hit_loc, v_origin, psoffsettime, var_3bc96147, var_269779a, var_829b9480, v_normal) {
    if (self.vehicletype == "biplane_zm" && !self flag::get("biplane_down")) {
        if (isplayer(e_attacker) && e_attacker.zombie_vars["zombie_powerup_zombie_blood_on"]) {
            self flag::set("biplane_down");
        }
        return 0;
    }
    return n_damage;
}

// Namespace zm_tomb_ee_main_step_5
// Params 2, eflags: 0x1 linked
// Checksum 0x7cf6eca9, Offset: 0xd80
// Size: 0x19c
function function_6337b233(v_origin, v_angles) {
    var_3f93b408 = spawn("script_model", v_origin + (0, 0, 30));
    var_3f93b408.angles = v_angles;
    var_3f93b408 setmodel("veh_t7_dlc_zm_quadrotor");
    var_3f93b408.targetname = "quadrotor_pickup";
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = v_origin;
    unitrigger_stub.radius = 36;
    unitrigger_stub.height = 256;
    unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    unitrigger_stub.hint_string = %ZM_TOMB_DIHS;
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.require_look_at = 1;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_a01accf2);
    level flag::wait_till("ee_maxis_drone_retrieved");
    zm_unitrigger::unregister_unitrigger(unitrigger_stub);
}

// Namespace zm_tomb_ee_main_step_5
// Params 0, eflags: 0x1 linked
// Checksum 0x4af01401, Offset: 0xf28
// Size: 0xd0
function function_a01accf2() {
    self endon(#"kill_trigger");
    var_3f93b408 = getent("quadrotor_pickup", "targetname");
    while (true) {
        player = self waittill(#"trigger");
        player playsound("vox_maxi_drone_upgraded_0");
        level flag::clear("ee_quadrotor_disabled");
        level flag::set("ee_maxis_drone_retrieved");
        var_3f93b408 delete();
    }
}

