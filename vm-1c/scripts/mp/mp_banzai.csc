#using scripts/mp/mp_banzai_sound;
#using scripts/mp/mp_banzai_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_2c022880;

// Namespace namespace_2c022880
// Params 0, eflags: 0x1 linked
// namespace_2c022880<file_0>::function_d290ebfa
// Checksum 0xb8c163cc, Offset: 0x1d8
// Size: 0xcc
function main() {
    namespace_3212dfb1::main();
    namespace_20455184::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    load::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_banzai";
}

// Namespace namespace_2c022880
// Params 2, eflags: 0x1 linked
// namespace_2c022880<file_0>::function_b6d6bffc
// Checksum 0xfcab8cc6, Offset: 0x2b0
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
    }
}

// Namespace namespace_2c022880
// Params 2, eflags: 0x1 linked
// namespace_2c022880<file_0>::function_628641cd
// Checksum 0x605972ed, Offset: 0x380
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
    }
}

