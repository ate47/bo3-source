#using scripts/cp/cp_mi_cairo_ramses_patch_c;
#using scripts/shared/vehicles/_quadtank;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_sound;
#using scripts/cp/cp_mi_cairo_ramses_fx;
#using scripts/cp/_util;
#using scripts/cp/_load;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_cairo_ramses;

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x1 linked
// Checksum 0x12d92210, Offset: 0x528
// Size: 0xec
function main() {
    util::function_57b966c8(&function_71f88fc, 3);
    init_clientfields();
    cp_mi_cairo_ramses_fx::main();
    cp_mi_cairo_ramses_sound::main();
    callback::on_localclient_connect(&on_player_spawned);
    load::main();
    util::waitforclient(0);
    level.var_7ab81734 = findstaticmodelindexarray("station_shells");
    level thread function_9e41eeb7();
    cp_mi_cairo_ramses_patch_c::function_7403e82b();
}

// Namespace cp_mi_cairo_ramses
// Params 1, eflags: 0x1 linked
// Checksum 0x4fc4135f, Offset: 0x620
// Size: 0x44
function on_player_spawned(localclientnum) {
    player = getlocalplayer(localclientnum);
    filter::init_filter_ev_interference(player);
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x1 linked
// Checksum 0x9c35b0c6, Offset: 0x670
// Size: 0x28c
function init_clientfields() {
    clientfield::register("world", "hide_station_miscmodels", 1, 1, "int", &function_21e48ac1, 0, 0);
    clientfield::register("world", "turn_on_rotating_fxanim_fans", 1, 1, "int", &turn_on_rotating_fxanim_fans, 0, 0);
    clientfield::register("world", "turn_on_rotating_fxanim_lights", 1, 1, "int", &turn_on_rotating_fxanim_lights, 0, 0);
    clientfield::register("world", "delete_fxanim_fans", 1, 1, "int", &delete_fxanim_fans, 0, 0);
    clientfield::register("toplayer", "nasser_interview_extra_cam", 1, 1, "int", &interview_extra_cam, 0, 0);
    clientfield::register("world", "ramses_station_lamps", 1, 1, "int", &ramses_station_lamps, 0, 0);
    clientfield::register("toplayer", "rap_blood_on_player", 1, 1, "counter", &function_4fc2bc7e, 0, 0);
    clientfield::register("world", "staging_area_intro", 1, 1, "int", &staging_area_intro, 0, 0);
    clientfield::register("toplayer", "filter_ev_interference_toggle", 1, 1, "int", &filter_ev_interference_toggle, 0, 0);
}

// Namespace cp_mi_cairo_ramses
// Params 1, eflags: 0x1 linked
// Checksum 0x3c23dff, Offset: 0x908
// Size: 0xb2
function function_71f88fc(n_zone) {
    switch (n_zone) {
    case 1:
        break;
    case 2:
        forcestreamxmodel("c_ega_soldier_3_pincushion_fb");
        break;
    case 3:
        forcestreambundle("p_ramses_lift_wing_blockage");
        loadsiegeanim("p7_fxanim_cp_ramses_medical_tarp_cover_s3_sanim");
        loadsiegeanim("p7_fxanim_gp_drone_hunter_swarm_large_sanim");
        break;
    default:
        break;
    }
}

// Namespace cp_mi_cairo_ramses
// Params 7, eflags: 0x1 linked
// Checksum 0xb562177e, Offset: 0x9c8
// Size: 0x74
function turn_on_rotating_fxanim_fans(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!scene::is_playing("p7_fxanim_gp_fan_digital_small_bundle")) {
        level thread scene::play("p7_fxanim_gp_fan_digital_small_bundle");
    }
}

// Namespace cp_mi_cairo_ramses
// Params 7, eflags: 0x1 linked
// Checksum 0x552bd05, Offset: 0xa48
// Size: 0x74
function turn_on_rotating_fxanim_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!scene::is_playing("p7_fxanim_gp_light_emergency_military_01_bundle")) {
        level thread scene::play("p7_fxanim_gp_light_emergency_military_01_bundle");
    }
}

// Namespace cp_mi_cairo_ramses
// Params 7, eflags: 0x1 linked
// Checksum 0x35ce2382, Offset: 0xac8
// Size: 0x74
function delete_fxanim_fans(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (scene::is_active("p7_fxanim_gp_fan_digital_small_bundle")) {
        level thread scene::stop("p7_fxanim_gp_fan_digital_small_bundle", 1);
    }
}

// Namespace cp_mi_cairo_ramses
// Params 7, eflags: 0x1 linked
// Checksum 0xd3e6fbe6, Offset: 0xb48
// Size: 0x84
function staging_area_intro(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level scene::init("p7_fxanim_cp_ramses_tarp_gust_01_bundle");
        return;
    }
    level thread scene::play("p7_fxanim_cp_ramses_tarp_gust_01_bundle");
}

// Namespace cp_mi_cairo_ramses
// Params 7, eflags: 0x1 linked
// Checksum 0xc9952f07, Offset: 0xbd8
// Size: 0x6c
function ramses_station_lamps(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self scene::play("ramses_station_lamps", "targetname");
    }
}

// Namespace cp_mi_cairo_ramses
// Params 7, eflags: 0x0
// Checksum 0xeef1c964, Offset: 0xc50
// Size: 0x11c
function function_f139780f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        s_org = struct::get("train_extra_cam", "targetname");
        self.var_78be5d02 = spawn(localclientnum, s_org.origin, "script_origin");
        self.var_78be5d02.angles = s_org.angles;
        self.var_78be5d02 linkto(self);
        level.var_5bcfe40a = self.var_78be5d02;
        return;
    }
    if (isdefined(self.var_78be5d02)) {
        self.var_78be5d02 delete();
    }
}

// Namespace cp_mi_cairo_ramses
// Params 7, eflags: 0x0
// Checksum 0xc5578cac, Offset: 0xd78
// Size: 0xf4
function function_25e7d865(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        assert(isdefined(level.var_5bcfe40a), "<dev string:x28>");
        level.var_5bcfe40a setextracam(0);
        setdvar("r_extracam_custom_aspectratio", 0.769);
        return;
    }
    setdvar("r_extracam_custom_aspectratio", -1);
    if (isdefined(level.var_5bcfe40a)) {
        level.var_5bcfe40a delete();
    }
}

// Namespace cp_mi_cairo_ramses
// Params 7, eflags: 0x1 linked
// Checksum 0x24fafc41, Offset: 0xe78
// Size: 0xcc
function interview_extra_cam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_7b2c375d = getent(localclientnum, "interview_extra_cam", "targetname");
    if (newval == 1) {
        if (isdefined(var_7b2c375d)) {
            var_7b2c375d setextracam(0);
        }
        return;
    }
    if (isdefined(var_7b2c375d)) {
        var_7b2c375d clearextracam();
    }
}

// Namespace cp_mi_cairo_ramses
// Params 7, eflags: 0x1 linked
// Checksum 0xd8044e97, Offset: 0xf50
// Size: 0x9c
function function_4fc2bc7e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setsoundcontext("foley", "normal");
    if (newval == 1) {
        if (!util::is_gib_restricted_build()) {
            self thread postfx::playpostfxbundle("pstfx_blood_spatter");
        }
    }
}

// Namespace cp_mi_cairo_ramses
// Params 7, eflags: 0x1 linked
// Checksum 0xb796ad87, Offset: 0xff8
// Size: 0x1b6
function function_21e48ac1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    assert(isdefined(level.var_7ab81734), "<dev string:x48>");
    if (newval == 1) {
        foreach (i, model in level.var_7ab81734) {
            hidestaticmodel(model);
            if (i % 25 == 0) {
                wait 0.016;
            }
        }
        return;
    }
    foreach (i, model in level.var_7ab81734) {
        unhidestaticmodel(model);
        if (i % 10 == 0) {
            wait 0.016;
        }
    }
}

// Namespace cp_mi_cairo_ramses
// Params 7, eflags: 0x1 linked
// Checksum 0x971040e9, Offset: 0x11b8
// Size: 0x8c
function filter_ev_interference_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        filter::disable_filter_ev_interference(self, 0);
        return;
    }
    filter::enable_filter_ev_interference(self, 0);
    filter::set_filter_ev_interference_amount(self, 0, 1);
}

// Namespace cp_mi_cairo_ramses
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1250
// Size: 0x4
function function_9e41eeb7() {
    
}

