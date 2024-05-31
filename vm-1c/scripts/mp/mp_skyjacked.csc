#using scripts/mp/mp_skyjacked_sound;
#using scripts/mp/mp_skyjacked_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_b31ea552;

// Namespace namespace_b31ea552
// Params 0, eflags: 0x1 linked
// namespace_b31ea552<file_0>::function_d290ebfa
// Checksum 0xc648ff57, Offset: 0x240
// Size: 0x8c
function main() {
    namespace_816c28f7::main();
    namespace_5596a11e::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_skyjacked";
}

// Namespace namespace_b31ea552
// Params 2, eflags: 0x1 linked
// namespace_b31ea552<file_0>::function_b6d6bffc
// Checksum 0xf6275f68, Offset: 0x2d8
// Size: 0xc2
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case 6:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case 7:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r90";
        } else {
            return "ui/fx_dom_marker_team_r90";
        }
        break;
    case 8:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    }
}

// Namespace namespace_b31ea552
// Params 2, eflags: 0x1 linked
// namespace_b31ea552<file_0>::function_628641cd
// Checksum 0xc678162d, Offset: 0x3a8
// Size: 0xc2
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case 6:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case 7:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r90";
        } else {
            return "ui/fx_dom_cap_indicator_team_r90";
        }
        break;
    case 8:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    }
}

