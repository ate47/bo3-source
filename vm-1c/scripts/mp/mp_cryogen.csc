#using scripts/mp/mp_cryogen_sound;
#using scripts/mp/mp_cryogen_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_9de125a0;

// Namespace namespace_9de125a0
// Params 0, eflags: 0x1 linked
// Checksum 0x3a3b4b09, Offset: 0x1b8
// Size: 0x8c
function main() {
    namespace_5633db91::main();
    namespace_779c23e4::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_cryogen";
}

// Namespace namespace_9de125a0
// Params 2, eflags: 0x1 linked
// Checksum 0xc9ae124d, Offset: 0x250
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

// Namespace namespace_9de125a0
// Params 2, eflags: 0x1 linked
// Checksum 0x17db40ef, Offset: 0x320
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

