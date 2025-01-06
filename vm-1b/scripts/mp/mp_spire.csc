#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/mp_spire_amb;
#using scripts/mp/mp_spire_fx;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/util_shared;

#namespace mp_spire;

// Namespace mp_spire
// Params 0, eflags: 0x0
// Checksum 0x51c53c8a, Offset: 0x228
// Size: 0xda
function main() {
    clientfield::register("world", "mpSpireExteriorBillboard", 1, 2, "int", &function_8f3f2fb0, 1, 1);
    level.disablefxaniminsplitscreencount = 3;
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    mp_spire_fx::main();
    thread mp_spire_amb::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_spire";
    println("<dev string:x28>");
}

// Namespace mp_spire
// Params 7, eflags: 0x0
// Checksum 0x95fb01a2, Offset: 0x310
// Size: 0x3a
function function_8f3f2fb0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace mp_spire
// Params 2, eflags: 0x0
// Checksum 0xdf4ccc10, Offset: 0x358
// Size: 0xb1
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case "a":
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case "b":
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case "c":
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    }
}

// Namespace mp_spire
// Params 2, eflags: 0x0
// Checksum 0xedeac8a1, Offset: 0x418
// Size: 0xb1
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case "a":
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case "b":
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case "c":
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    }
}

