#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_kung_fu_fx;
#using scripts/mp/mp_kung_fu_sound;
#using scripts/shared/util_shared;

#namespace mp_kung_fu;

// Namespace mp_kung_fu
// Params 0, eflags: 0x0
// Checksum 0x607112db, Offset: 0x1b8
// Size: 0x8c
function main() {
    mp_kung_fu_fx::main();
    mp_kung_fu_sound::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    load::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_kung_fu";
}

// Namespace mp_kung_fu
// Params 2, eflags: 0x0
// Checksum 0x52680ab3, Offset: 0x250
// Size: 0xc2
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

// Namespace mp_kung_fu
// Params 2, eflags: 0x0
// Checksum 0xe9a3086f, Offset: 0x320
// Size: 0xc2
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

