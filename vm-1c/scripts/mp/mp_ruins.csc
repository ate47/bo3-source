#using scripts/mp/mp_ruins_sound;
#using scripts/mp/mp_ruins_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_ee9254d2;

// Namespace namespace_ee9254d2
// Params 0, eflags: 0x1 linked
// Checksum 0xaabf7215, Offset: 0x1b0
// Size: 0x8c
function main() {
    namespace_7d071377::main();
    namespace_cf0d49e::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_ruins";
}

// Namespace namespace_ee9254d2
// Params 2, eflags: 0x1 linked
// Checksum 0xe41f347b, Offset: 0x248
// Size: 0xc2
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case 4:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case 5:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case 6:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    }
}

// Namespace namespace_ee9254d2
// Params 2, eflags: 0x1 linked
// Checksum 0x994436d4, Offset: 0x318
// Size: 0xc2
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case 4:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case 5:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case 6:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    }
}

