#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/mp_rise_amb;
#using scripts/mp/mp_rise_fx;
#using scripts/shared/util_shared;

#namespace mp_rise;

// Namespace mp_rise
// Params 0, eflags: 0x0
// Checksum 0x232600b5, Offset: 0x198
// Size: 0x9a
function main() {
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    mp_rise_fx::main();
    thread mp_rise_amb::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_rise";
    println("<dev string:x28>");
}

// Namespace mp_rise
// Params 2, eflags: 0x0
// Checksum 0x7d91782f, Offset: 0x240
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

// Namespace mp_rise
// Params 2, eflags: 0x0
// Checksum 0xe7cb512d, Offset: 0x300
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

