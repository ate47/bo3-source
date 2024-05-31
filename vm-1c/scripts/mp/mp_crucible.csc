#using scripts/mp/mp_crucible_sound;
#using scripts/mp/mp_crucible_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_dae40e52;

// Namespace namespace_dae40e52
// Params 0, eflags: 0x1 linked
// namespace_dae40e52<file_0>::function_d290ebfa
// Checksum 0x495ce208, Offset: 0x1c0
// Size: 0x8c
function main() {
    namespace_86acebf7::main();
    namespace_59e8c21e::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_crucible";
}

// Namespace namespace_dae40e52
// Params 2, eflags: 0x1 linked
// namespace_dae40e52<file_0>::function_b6d6bffc
// Checksum 0xbced7c0c, Offset: 0x258
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

// Namespace namespace_dae40e52
// Params 2, eflags: 0x1 linked
// namespace_dae40e52<file_0>::function_628641cd
// Checksum 0x3dadfdab, Offset: 0x328
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

