#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_vo;

#namespace zm_tomb_ee_main_step_8;

// Namespace zm_tomb_ee_main_step_8
// Params 0, eflags: 0x0
// Checksum 0x3987fab8, Offset: 0x3a0
// Size: 0x54
function init() {
    namespace_6e97c459::function_5a90ed82("little_girl_lost", "step_8", &init_stage, &function_7747c56, &function_cc3f3f6a);
}

// Namespace zm_tomb_ee_main_step_8
// Params 0, eflags: 0x0
// Checksum 0x31a9bf4d, Offset: 0x400
// Size: 0x2c
function init_stage() {
    level.var_ca733eed = "step_8";
    level.var_789c3e33 = &function_8d684a30;
}

// Namespace zm_tomb_ee_main_step_8
// Params 0, eflags: 0x0
// Checksum 0xe5f8cb43, Offset: 0x438
// Size: 0x44c
function function_7747c56() {
    /#
        iprintln(level.var_ca733eed + "<dev string:x28>");
    #/
    level notify(#"hash_1fd5ee2f");
    foreach (player in getplayers()) {
        if (player zm_tomb_chamber::function_cd5b3a70()) {
            player thread hud::fade_to_black_for_x_sec(0, 1, 0.5, 0.5, "white");
        }
    }
    wait 0.5;
    level clientfield::set("ee_sam_portal", 2);
    exploder::exploder("fxexp_500");
    level notify(#"hash_9e19b240");
    var_373dc638 = getentarray("chamber_wall", "script_noteworthy");
    foreach (var_ec523dd5 in var_373dc638) {
        var_ec523dd5 thread zm_tomb_chamber::function_6780a3d7();
        var_ec523dd5 hide();
    }
    level flag::wait_till("ee_quadrotor_disabled");
    wait 1;
    level thread zm_tomb_ee_main::function_13f8b19b("vox_sam_all_staff_freedom_0");
    s_pos = struct::get("player_portal_final", "targetname");
    t_portal = zm_tomb_utility::function_52854313(s_pos.origin, 100, 1);
    t_portal.require_look_at = 1;
    t_portal.hint_string = %ZM_TOMB_TELE;
    t_portal thread function_2a230352();
    level.var_d53c56c8 = spawn("script_model", s_pos.origin + (0, 0, -300));
    level.var_d53c56c8.angles = (0, 90, 0);
    level.var_d53c56c8 setmodel("tag_origin");
    playfxontag(level._effect["ee_beam"], level.var_d53c56c8, "tag_origin");
    level.var_d53c56c8 playsound("zmb_squest_crystal_sky_pillar_start");
    level.var_d53c56c8 playloopsound("zmb_squest_crystal_sky_pillar_loop");
    level flag::wait_till("ee_samantha_released");
    t_portal zm_tomb_utility::function_bd611266();
    util::wait_network_frame();
    namespace_6e97c459::function_2f3ced1f("little_girl_lost", level.var_ca733eed);
}

// Namespace zm_tomb_ee_main_step_8
// Params 1, eflags: 0x0
// Checksum 0xa50215da, Offset: 0x890
// Size: 0x1a
function function_cc3f3f6a(success) {
    level notify(#"hash_738ebd3d");
}

// Namespace zm_tomb_ee_main_step_8
// Params 0, eflags: 0x0
// Checksum 0xf24f90e7, Offset: 0x8b8
// Size: 0x48
function function_2a230352() {
    while (true) {
        self waittill(#"trigger", player);
        level flag::set("ee_samantha_released");
    }
}

// Namespace zm_tomb_ee_main_step_8
// Params 0, eflags: 0x0
// Checksum 0x751e5bf5, Offset: 0x908
// Size: 0x206
function function_8d684a30() {
    s_goal = struct::get("maxis_portal_path", "targetname");
    if (distance2dsquared(self.origin, s_goal.origin) < 250000) {
        self setvehgoalpos(s_goal.origin, 1, 2);
        self util::waittill_any("near_goal", "force_goal", "reached_end_node");
        zm_tomb_vo::function_7dc74a72("vox_maxi_drone_upgraded_1", self);
        wait 1;
        level thread zm_tomb_vo::function_7dc74a72("vox_maxi_drone_upgraded_2", self);
        s_goal = struct::get(s_goal.target, "targetname");
        self setvehgoalpos(s_goal.origin, 1, 0);
        self util::waittill_any("near_goal", "force_goal", "reached_end_node");
        self playsound("zmb_qrdrone_leave");
        level flag::set("ee_quadrotor_disabled");
        self dodamage(-56, self.origin);
        self delete();
        level.var_461e417 = undefined;
    }
}

