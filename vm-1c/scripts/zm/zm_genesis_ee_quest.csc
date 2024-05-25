#using scripts/zm/zm_genesis_teleporter;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/zm/_filter;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_fdab22a5;

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x2
// Checksum 0x560dfaf5, Offset: 0x450
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_genesis_ee_quest", &__init__, undefined, undefined);
}

// Namespace namespace_fdab22a5
// Params 0, eflags: 0x1 linked
// Checksum 0x669fdcbe, Offset: 0x490
// Size: 0x2e6
function __init__() {
    clientfield::register("world", "ee_quest_state", 15000, getminbitcountfornum(13), "int", &function_e70dbcc6, 0, 0);
    clientfield::register("scriptmover", "ghost_entity", 15000, 1, "int", &function_2b5ef9a6, 0, 0);
    clientfield::register("scriptmover", "electric_charge", 15000, 1, "int", &function_ede1c539, 0, 0);
    clientfield::register("scriptmover", "grand_tour_found_toy_fx", 15000, 1, "int", &function_52d5d371, 0, 0);
    clientfield::register("scriptmover", "sophia_transition_fx", 15000, 1, "int", &function_54a08d82, 0, 0);
    clientfield::register("allplayers", "sophia_follow", 15000, 3, "int", &function_272c5fb, 0, 0);
    clientfield::register("scriptmover", "sophia_eye_on", 15000, 1, "int", &function_e30ebff1, 0, 0);
    clientfield::register("allplayers", "sophia_delete_local", 15000, 1, "int", &function_180d1d09, 0, 0);
    clientfield::register("world", "GenesisEndGameEEScreen", 15000, 1, "int", &function_351e217c, 0, 0);
    duplicate_render::set_dr_filter_framebuffer("zod_ghost", 90, "zod_ghost", undefined, 0, "mc/hud_zod_ghost", 0);
    level._effect["electric_charge"] = "electric/fx_elec_arc_med_loop_hacktower";
}

// Namespace namespace_fdab22a5
// Params 7, eflags: 0x1 linked
// Checksum 0x79e851a6, Offset: 0x780
// Size: 0xa6
function function_e70dbcc6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level notify(#"hash_e70dbcc6");
    level endon(#"hash_e70dbcc6");
    switch (newval) {
    case 7:
        break;
    case 8:
        break;
    case 9:
        break;
    case 10:
        break;
    case 12:
        break;
    }
}

// Namespace namespace_fdab22a5
// Params 7, eflags: 0x1 linked
// Checksum 0xb7a52eba, Offset: 0x830
// Size: 0x74
function function_2b5ef9a6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self duplicate_render::set_dr_flag("zod_ghost", newval);
    self duplicate_render::update_dr_filters(localclientnum);
}

// Namespace namespace_fdab22a5
// Params 7, eflags: 0x1 linked
// Checksum 0x9d1043a, Offset: 0x8b0
// Size: 0xb4
function function_ede1c539(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_ebad8041)) {
        deletefx(localclientnum, self.var_ebad8041, 0);
        self.var_ebad8041 = undefined;
    }
    if (newval == 1) {
        self.var_ebad8041 = playfxontag(localclientnum, level._effect["electric_charge"], self, "tag_origin");
    }
}

// Namespace namespace_fdab22a5
// Params 7, eflags: 0x1 linked
// Checksum 0x8c699c1f, Offset: 0x970
// Size: 0xd6
function function_52d5d371(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["ee_toy_found"], self.origin);
        self.var_22c9fb1a = playfxontag(localclientnum, level._effect["shadow_rq_chomper_light"], self, "tag_origin");
        return;
    }
    deletefx(localclientnum, self.var_22c9fb1a, 0);
    self.var_22c9fb1a = undefined;
}

// Namespace namespace_fdab22a5
// Params 7, eflags: 0x1 linked
// Checksum 0x137c0fa, Offset: 0xa50
// Size: 0xb6
function function_54a08d82(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.n_fx = playfxontag(localclientnum, level._effect["sophia_transition"], self, "tag_origin");
        return;
    }
    if (isdefined(self.n_fx)) {
        deletefx(localclientnum, self.n_fx, 0);
        self.n_fx = undefined;
    }
}

// Namespace namespace_fdab22a5
// Params 7, eflags: 0x1 linked
// Checksum 0x5589e835, Offset: 0xb10
// Size: 0x1a4
function function_272c5fb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level endon(#"hash_249c0595");
    var_1c7b6837 = getent(localclientnum, "sophia_eye", "targetname");
    if (!isdefined(var_1c7b6837)) {
        var_af8a18df = struct::get("ee_beam_sophia", "targetname");
        var_1c7b6837 = util::spawn_model(localclientnum, "p7_zm_gen_dark_arena_sphere", var_af8a18df.origin, var_af8a18df.angles);
        var_1c7b6837.targetname = "sophia_eye";
        var_1c7b6837 mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0);
    }
    level notify(#"hash_deeb3634");
    wait(0.5);
    if (!isdefined(var_1c7b6837)) {
        return;
    }
    if (newval == 0) {
        var_1c7b6837 rotateto((0, 0, 0), 0.5);
        return;
    }
    level.var_9a736d20 = 1;
    var_1c7b6837 thread function_36666e11(self);
}

// Namespace namespace_fdab22a5
// Params 7, eflags: 0x1 linked
// Checksum 0xd3126c43, Offset: 0xcc0
// Size: 0x64
function function_e30ebff1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 0, 0);
}

// Namespace namespace_fdab22a5
// Params 1, eflags: 0x1 linked
// Checksum 0xe66d3847, Offset: 0xd30
// Size: 0xf0
function function_36666e11(e_player) {
    level endon(#"demo_jump");
    level endon(#"hash_deeb3634");
    e_player endon(#"death");
    self endon(#"entityshutdown");
    while (isdefined(e_player)) {
        var_c746e6bf = e_player gettagorigin("j_head");
        var_933e0d32 = vectortoangles(var_c746e6bf - self.origin);
        var_933e0d32 = (var_933e0d32[0], var_933e0d32[1], var_933e0d32[2]);
        self rotateto(var_933e0d32, 0.1);
        wait(0.1);
    }
}

// Namespace namespace_fdab22a5
// Params 7, eflags: 0x1 linked
// Checksum 0x56574bf4, Offset: 0xe28
// Size: 0xb4
function function_180d1d09(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_1c7b6837 = getent(localclientnum, "sophia_eye", "targetname");
    if (isdefined(var_1c7b6837)) {
        var_1c7b6837 rotateto((0, 0, 0), 0.2);
        var_1c7b6837 delete();
    }
}

// Namespace namespace_fdab22a5
// Params 7, eflags: 0x1 linked
// Checksum 0x85835e3f, Offset: 0xee8
// Size: 0x84
function function_351e217c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "GenesisEndGameEE"), 1);
}

