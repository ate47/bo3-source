#using scripts/mp/mp_spire_fx;
#using scripts/mp/mp_spire_amb;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_5a98f96a;

// Namespace namespace_5a98f96a
// Params 0, eflags: 0x1 linked
// namespace_5a98f96a<file_0>::function_d290ebfa
// Checksum 0xd0fdf145, Offset: 0x228
// Size: 0x104
function main() {
    clientfield::register("world", "mpSpireExteriorBillboard", 1, 2, "int", &function_8f3f2fb0, 1, 1);
    level.disablefxaniminsplitscreencount = 3;
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    namespace_d4c614ff::main();
    thread namespace_69104eab::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_spire";
    println("b");
}

// Namespace namespace_5a98f96a
// Params 7, eflags: 0x1 linked
// namespace_5a98f96a<file_0>::function_8f3f2fb0
// Checksum 0x6adad077, Offset: 0x338
// Size: 0x3c
function function_8f3f2fb0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace namespace_5a98f96a
// Params 2, eflags: 0x1 linked
// namespace_5a98f96a<file_0>::function_b6d6bffc
// Checksum 0x38b39fc1, Offset: 0x380
// Size: 0xc2
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case 7:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case 8:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case 9:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    }
}

// Namespace namespace_5a98f96a
// Params 2, eflags: 0x1 linked
// namespace_5a98f96a<file_0>::function_628641cd
// Checksum 0x75e2bb46, Offset: 0x450
// Size: 0xc2
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case 7:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case 8:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case 9:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    }
}

