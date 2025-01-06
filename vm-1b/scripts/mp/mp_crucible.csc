#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_crucible_fx;
#using scripts/mp/mp_crucible_sound;
#using scripts/shared/util_shared;

#namespace mp_crucible;

// Namespace mp_crucible
// Params 0, eflags: 0x0
// Checksum 0xbd37fe9c, Offset: 0x1c0
// Size: 0x82
function main() {
    mp_crucible_fx::main();
    mp_crucible_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_crucible";
}

// Namespace mp_crucible
// Params 2, eflags: 0x0
// Checksum 0x29226d09, Offset: 0x250
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

// Namespace mp_crucible
// Params 2, eflags: 0x0
// Checksum 0xc38fd86b, Offset: 0x310
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

