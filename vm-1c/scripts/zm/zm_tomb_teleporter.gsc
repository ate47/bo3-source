#using scripts/zm/_zm_utility;
#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/_zm_score;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_97bec092;

// Namespace namespace_97bec092
// Params 0, eflags: 0x1 linked
// Checksum 0xd465d605, Offset: 0x760
// Size: 0x4ec
function teleporter_init() {
    clientfield::register("scriptmover", "teleporter_fx", 21000, 1, "int");
    clientfield::register("allplayers", "teleport_arrival_departure_fx", 21000, 1, "counter");
    clientfield::register("vehicle", "teleport_arrival_departure_fx", 21000, 1, "counter");
    visionset_mgr::register_info("overlay", "zm_factory_teleport", 21000, 61, 1, 1);
    level.teleport = [];
    level.var_2503cccc = 0;
    level.n_countdown = 0;
    level.var_b01bd818 = 0;
    level.var_7f034e97 = 0;
    level.var_cf42e0a0 = -1;
    level.var_46eb4efb = 0;
    level.var_3722c981 = [];
    var_30e67710 = getentarray("teleport_model", "targetname");
    foreach (e_model in var_30e67710) {
        e_model useanimtree(#generic);
        level.var_3722c981[e_model.script_int] = e_model;
        e_model setignorepauseworld(1);
    }
    array::thread_all(var_30e67710, &function_c5b0a85b);
    var_f39893fc = getentarray("portal_exit_frame", "script_noteworthy");
    level.var_a550d08b = [];
    foreach (var_f0488808 in var_f39893fc) {
        var_f0488808 useanimtree(#generic);
        var_f0488808 ghost();
        level.var_a550d08b[var_f0488808.script_int] = var_f0488808;
        var_f0488808 thread scene::play("p7_fxanim_zm_ori_portal_collapse_bundle", var_f0488808);
    }
    level.var_2cc80bb6 = [];
    var_69f3f6dc = struct::get_array("portal_exit", "script_noteworthy");
    foreach (s_portal in var_69f3f6dc) {
        level.var_2cc80bb6[s_portal.script_int] = s_portal;
    }
    level.var_abfc3ffd = [];
    a_trigs = struct::get_array("chamber_exit_trigger", "script_noteworthy");
    foreach (s_trig in a_trigs) {
        level.var_abfc3ffd[s_trig.script_int] = s_trig;
    }
    function_6a1abb61();
}

// Namespace namespace_97bec092
// Params 0, eflags: 0x1 linked
// Checksum 0x7b094424, Offset: 0xc58
// Size: 0x54
function main() {
    var_b360941e = struct::get_array("trigger_teleport_pad", "targetname");
    array::thread_all(var_b360941e, &function_5d4ce9fb);
}

// Namespace namespace_97bec092
// Params 0, eflags: 0x1 linked
// Checksum 0xdbc81494, Offset: 0xcb8
// Size: 0x1c0
function function_c5b0a85b() {
    max_dist_sq = 640000;
    level.var_e71cefc = 0;
    level flag::wait_till("samantha_intro_done");
    while (!level.var_e71cefc) {
        a_players = getplayers();
        foreach (e_player in a_players) {
            dist_sq = distance2dsquared(self.origin, e_player.origin);
            height_diff = abs(self.origin[2] - e_player.origin[2]);
            if (dist_sq < max_dist_sq && height_diff < -106 && !(isdefined(e_player.isspeaking) && e_player.isspeaking)) {
                level thread function_d65163bc(e_player);
                return;
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_97bec092
// Params 1, eflags: 0x1 linked
// Checksum 0x9255ff40, Offset: 0xe80
// Size: 0xf4
function function_d65163bc(e_player) {
    if (level.var_e71cefc) {
        return;
    }
    level.var_e71cefc = 1;
    level flag::wait_till_clear("story_vo_playing");
    level flag::set("story_vo_playing");
    namespace_ad52727b::function_eee384d4(1);
    namespace_ad52727b::function_10d15bb5("vox_sam_enter_chamber_1_0", e_player, 1);
    namespace_ad52727b::function_10d15bb5("vox_sam_enter_chamber_2_0", e_player);
    namespace_ad52727b::function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_97bec092
// Params 1, eflags: 0x1 linked
// Checksum 0x9569b4a7, Offset: 0xf80
// Size: 0x618
function function_db713e86(var_abb52853) {
    s_portal = level.var_2cc80bb6[var_abb52853];
    var_ff43cb27 = level.var_abfc3ffd[var_abb52853];
    var_ddcb6651 = level.var_a550d08b[var_abb52853];
    var_ddcb6651 show();
    var_96c4396 = var_ddcb6651.targetname + "_building";
    level flag::init(var_96c4396);
    var_ff43cb27.trigger_stub = namespace_d7c0ce12::function_52854313(var_ff43cb27.origin, 50, 1);
    var_ff43cb27.trigger_stub namespace_d7c0ce12::function_d73e42e0(%ZM_TOMB_TELE);
    s_portal.target = var_ff43cb27.target;
    s_portal.origin = var_ddcb6651 gettagorigin("fx_portal_jnt");
    s_portal.angles = var_ddcb6651 gettagangles("fx_portal_jnt");
    str_fx = namespace_d7c0ce12::function_61fce955(var_abb52853);
    var_727974e8 = getanimlength(generic%p7_fxanim_zm_ori_portal_collapse_anim);
    open_time = getanimlength(generic%p7_fxanim_zm_ori_portal_open_anim);
    var_ff7119bc = undefined;
    switch (s_portal.targetname) {
    case 30:
        var_ff7119bc = "p7_fxanim_zm_ori_portal_open_fire_bundle";
        break;
    case 28:
        var_ff7119bc = "p7_fxanim_zm_ori_portal_open_air_bundle";
        break;
    case 31:
        var_ff7119bc = "p7_fxanim_zm_ori_portal_open_ice_bundle";
        break;
    case 29:
        var_ff7119bc = "p7_fxanim_zm_ori_portal_open_elec_bundle";
        break;
    default:
        break;
    }
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        e_player = var_ff43cb27.trigger_stub waittill(#"trigger");
        if (!zombie_utility::is_player_valid(e_player)) {
            continue;
        }
        if (e_player.score < level.var_b01bd818) {
            continue;
        }
        var_ff43cb27.trigger_stub namespace_d7c0ce12::function_d73e42e0("");
        if (level.var_b01bd818 > 0) {
            e_player zm_score::minus_to_player_score(level.var_b01bd818);
        }
        var_ddcb6651 playloopsound("zmb_teleporter_loop_pre", 1);
        var_ddcb6651 thread scene::play(var_ff7119bc, var_ddcb6651);
        level flag::set(var_96c4396);
        var_ddcb6651 thread namespace_d7c0ce12::function_8b1b140c(var_96c4396);
        wait(open_time);
        var_ddcb6651 thread scene::play("p7_fxanim_zm_ori_portal_open_1frame_bundle", var_ddcb6651);
        util::wait_network_frame();
        level flag::clear(var_96c4396);
        e_fx = spawn("script_model", s_portal.origin);
        e_fx.angles = s_portal.angles + (0, 180, 0);
        e_fx setmodel("tag_origin");
        e_fx clientfield::set("element_glow_fx", var_abb52853 + 4);
        namespace_d7c0ce12::rumble_nearby_players(e_fx.origin, 1000, 2);
        var_ddcb6651 playloopsound("zmb_teleporter_loop_post", 1);
        s_portal thread function_7a009c17();
        wait(20);
        var_ddcb6651 thread scene::play("p7_fxanim_zm_ori_portal_collapse_bundle", var_ddcb6651);
        var_ddcb6651 stoploopsound(0.5);
        var_ddcb6651 playsound("zmb_teleporter_anim_collapse_pew");
        s_portal notify(#"hash_1ba8d029");
        e_fx clientfield::set("element_glow_fx", 0);
        wait(var_727974e8);
        e_fx delete();
        var_ff43cb27.trigger_stub namespace_d7c0ce12::function_d73e42e0(%ZM_TOMB_TELE);
    }
}

// Namespace namespace_97bec092
// Params 0, eflags: 0x1 linked
// Checksum 0x4daca049, Offset: 0x15a0
// Size: 0x620
function function_5d4ce9fb() {
    self endon(#"death");
    fx_glow = namespace_d7c0ce12::function_61fce955(self.script_int);
    e_model = level.var_3722c981[self.script_int];
    self.origin = e_model gettagorigin("fx_portal_jnt");
    self.angles = e_model gettagangles("fx_portal_jnt");
    self.angles = (self.angles[0], self.angles[1] + -76, self.angles[2]);
    self.trigger_stub = namespace_d7c0ce12::function_52854313(self.origin - (0, 0, 30), 50);
    level flag::init("enable_teleporter_" + self.script_int);
    var_96c4396 = "teleporter_building_" + self.script_int;
    level flag::init(var_96c4396);
    var_727974e8 = getanimlength(generic%p7_fxanim_zm_ori_portal_collapse_anim);
    open_time = getanimlength(generic%p7_fxanim_zm_ori_portal_open_anim);
    level flag::wait_till("start_zombie_round_logic");
    e_model thread scene::play("p7_fxanim_zm_ori_portal_collapse_bundle", e_model);
    wait(var_727974e8);
    while (true) {
        level flag::wait_till("enable_teleporter_" + self.script_int);
        level flag::set(var_96c4396);
        var_babde23d = undefined;
        var_ff7119bc = undefined;
        switch (self.target) {
        case 49:
            var_babde23d = "lgtexp_fireCave_fade";
            var_ff7119bc = "p7_fxanim_zm_ori_portal_open_fire_bundle";
            break;
        case 47:
            var_babde23d = "lgtexp_airCave_fade";
            var_ff7119bc = "p7_fxanim_zm_ori_portal_open_air_bundle";
            break;
        case 50:
            var_babde23d = "lgtexp_iceCave_fade";
            var_ff7119bc = "p7_fxanim_zm_ori_portal_open_ice_bundle";
            break;
        case 48:
            var_babde23d = "lgtexp_elecCave_fade";
            var_ff7119bc = "p7_fxanim_zm_ori_portal_open_elec_bundle";
            break;
        default:
            break;
        }
        e_model thread namespace_d7c0ce12::function_8b1b140c(var_96c4396);
        if (isdefined(var_ff7119bc)) {
            e_model thread scene::play(var_ff7119bc, e_model);
        }
        e_model playloopsound("zmb_teleporter_loop_pre", 1);
        wait(open_time);
        e_model thread scene::play("p7_fxanim_zm_ori_portal_open_1frame_bundle", e_model);
        util::wait_network_frame();
        e_fx = spawn("script_model", self.origin);
        e_fx.angles = self.angles;
        e_fx setmodel("tag_origin");
        e_fx clientfield::set("element_glow_fx", self.script_int + 4);
        namespace_d7c0ce12::rumble_nearby_players(e_fx.origin, 1000, 2);
        e_model playloopsound("zmb_teleporter_loop_post", 1);
        if (isdefined(var_babde23d)) {
            exploder::exploder(var_babde23d);
        }
        if (!(isdefined(self.var_79b8da23) && self.var_79b8da23)) {
            self.var_79b8da23 = 1;
            level thread function_db713e86(self.script_int);
        }
        self thread function_5f30f5fb();
        level flag::clear(var_96c4396);
        level flag::wait_till_clear("enable_teleporter_" + self.script_int);
        level notify("disable_teleporter_" + self.script_int);
        e_fx clientfield::set("element_glow_fx", 0);
        e_model stoploopsound(0.5);
        e_model playsound("zmb_teleporter_anim_collapse_pew");
        e_model thread scene::play("p7_fxanim_zm_ori_portal_collapse_bundle", e_model);
        if (isdefined(var_babde23d)) {
            exploder::kill_exploder(var_babde23d);
        }
        wait(var_727974e8);
        e_fx delete();
    }
}

// Namespace namespace_97bec092
// Params 1, eflags: 0x1 linked
// Checksum 0xbead5eb0, Offset: 0x1bc8
// Size: 0x1f8
function function_7a009c17(radius) {
    if (!isdefined(radius)) {
        radius = 120;
    }
    self endon(#"hash_1ba8d029");
    radius_sq = radius * radius;
    while (true) {
        a_players = getplayers();
        foreach (e_player in a_players) {
            dist_sq = distancesquared(e_player.origin, self.origin);
            if (dist_sq < radius_sq && e_player getstance() != "prone" && !(isdefined(e_player.teleporting) && e_player.teleporting)) {
                playfx(level._effect["teleport_3p"], self.origin, (1, 0, 0), (0, 0, 1));
                playsoundatposition("zmb_teleporter_tele_3d", self.origin);
                level thread function_67bfec1a(self.target, e_player, 5);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_97bec092
// Params 0, eflags: 0x1 linked
// Checksum 0x246970ba, Offset: 0x1dc8
// Size: 0x148
function function_5f30f5fb() {
    self endon(#"death");
    level endon("disable_teleporter_" + self.script_int);
    var_4b827d1d = level.var_3722c981[self.script_int];
    while (true) {
        e_player = self.trigger_stub waittill(#"trigger");
        if (e_player getstance() != "prone" && !(isdefined(e_player.teleporting) && e_player.teleporting)) {
            playfx(level._effect["teleport_3p"], self.origin, (1, 0, 0), (0, 0, 1));
            playsoundatposition("zmb_teleporter_tele_3d", self.origin);
            level notify(#"hash_62857917", e_player, self.script_int);
            level thread function_67bfec1a(self.target, e_player);
        }
    }
}

// Namespace namespace_97bec092
// Params 1, eflags: 0x1 linked
// Checksum 0xff792546, Offset: 0x1f18
// Size: 0x2c
function function_b67726d8(n_index) {
    level flag::set("enable_teleporter_" + n_index);
}

// Namespace namespace_97bec092
// Params 1, eflags: 0x1 linked
// Checksum 0x7247448c, Offset: 0x1f50
// Size: 0x2c
function function_2e709a83(n_index) {
    level flag::clear("enable_teleporter_" + n_index);
}

// Namespace namespace_97bec092
// Params 0, eflags: 0x1 linked
// Checksum 0x3dac4bb3, Offset: 0x1f88
// Size: 0x5c
function function_691aa432() {
    self.e_fx clientfield::set("teleporter_fx", 1);
    self waittill(#"hash_97e83cbe");
    self.e_fx clientfield::set("teleporter_fx", 0);
}

// Namespace namespace_97bec092
// Params 0, eflags: 0x1 linked
// Checksum 0x21494f7e, Offset: 0x1ff0
// Size: 0x17e
function function_6a1abb61() {
    var_3af84491 = struct::get_array("teleport_room", "script_noteworthy");
    foreach (s_teleport in var_3af84491) {
        var_c5f81ff5 = s_teleport.origin + (0, 0, 64) + anglestoforward(s_teleport.angles) * 120;
        s_teleport.e_fx = spawn("script_model", var_c5f81ff5);
        s_teleport.e_fx setmodel("tag_origin");
        s_teleport.e_fx.angles = s_teleport.angles + (0, 180, 0);
    }
}

// Namespace namespace_97bec092
// Params 4, eflags: 0x1 linked
// Checksum 0x3e21fba1, Offset: 0x2178
// Size: 0x6ec
function function_67bfec1a(var_395ce040, player, var_20fd5da9, show_fx) {
    if (!isdefined(var_20fd5da9)) {
        var_20fd5da9 = 2;
    }
    if (!isdefined(show_fx)) {
        show_fx = 1;
    }
    player.teleporting = 1;
    player clientfield::increment("teleport_arrival_departure_fx");
    if (show_fx) {
        player thread hud::fade_to_black_for_x_sec(0, 0.3, 0, 0.5, "white");
        util::wait_network_frame();
    }
    n_pos = player.characterindex;
    prone_offset = (0, 0, 49);
    crouch_offset = (0, 0, 20);
    var_7cac5f2f = (0, 0, 0);
    var_594457ea = struct::get("teleport_room_" + n_pos, "targetname");
    player disableoffhandweapons();
    player disableweapons();
    player freezecontrols(1);
    util::wait_network_frame();
    var_64103691 = struct::get_array(var_395ce040, "targetname");
    n_total_time = var_20fd5da9 + 4;
    player zm_utility::create_streamer_hint(struct::get_array(var_395ce040, "targetname")[0].origin, struct::get_array(var_395ce040, "targetname")[0].angles, 1, n_total_time);
    if (player getstance() == "prone") {
        desired_origin = var_594457ea.origin + prone_offset;
    } else if (player getstance() == "crouch") {
        desired_origin = var_594457ea.origin + crouch_offset;
    } else {
        desired_origin = var_594457ea.origin + var_7cac5f2f;
    }
    player.teleport_origin = spawn("script_model", player.origin);
    player.teleport_origin setmodel("tag_origin");
    player.teleport_origin.angles = player.angles;
    player playerlinktoabsolute(player.teleport_origin, "tag_origin");
    player.teleport_origin.origin = desired_origin;
    player.teleport_origin.angles = var_594457ea.angles;
    if (show_fx) {
        player playsoundtoplayer("zmb_teleporter_plr_start", player);
    }
    util::wait_network_frame();
    player.teleport_origin.angles = var_594457ea.angles;
    if (show_fx) {
        var_594457ea thread function_691aa432();
        visionset_mgr::activate("overlay", "zm_factory_teleport", player);
    }
    var_c5af343b = 0.5;
    wait(var_20fd5da9 - var_c5af343b);
    if (show_fx) {
        player thread hud::fade_to_black_for_x_sec(0, var_c5af343b + 0.3, 0, 0.5, "white");
        util::wait_network_frame();
    }
    var_594457ea notify(#"hash_97e83cbe");
    a_pos = struct::get_array(var_395ce040, "targetname");
    s_pos = function_a2355239(player, a_pos);
    player unlink();
    if (isdefined(player.teleport_origin)) {
        player.teleport_origin delete();
        player.teleport_origin = undefined;
    }
    player setorigin(s_pos.origin);
    player setplayerangles(s_pos.angles);
    player enableweapons();
    player enableoffhandweapons();
    player freezecontrols(0);
    visionset_mgr::deactivate("overlay", "zm_factory_teleport", player);
    if (show_fx) {
        player playsoundtoplayer("zmb_teleporter_plr_end", player);
    }
    player.teleporting = 0;
    player clientfield::increment("teleport_arrival_departure_fx");
    player notify(#"hash_327f029");
}

// Namespace namespace_97bec092
// Params 2, eflags: 0x1 linked
// Checksum 0xbc98ac65, Offset: 0x2870
// Size: 0xf2
function function_c2a1c70a(s_pos, n_radius) {
    n_radius_sq = n_radius * n_radius;
    a_players = getplayers();
    foreach (e_player in a_players) {
        if (distance2dsquared(s_pos.origin, e_player.origin) < n_radius_sq) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_97bec092
// Params 2, eflags: 0x1 linked
// Checksum 0x36c867a9, Offset: 0x2970
// Size: 0xf0
function function_a2355239(player, a_structs) {
    var_5529cca0 = 64;
    while (true) {
        a_players = getplayers();
        foreach (s_pos in a_structs) {
            if (function_c2a1c70a(s_pos, var_5529cca0)) {
                return s_pos;
            }
        }
        wait(0.05);
    }
}

