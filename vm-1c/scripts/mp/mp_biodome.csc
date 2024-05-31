#using scripts/mp/mp_biodome_sound;
#using scripts/mp/mp_biodome_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_86fa17e8;

// Namespace namespace_86fa17e8
// Params 0, eflags: 0x1 linked
// namespace_86fa17e8<file_0>::function_d290ebfa
// Checksum 0x359dfe23, Offset: 0x258
// Size: 0xcc
function main() {
    namespace_d22f7529::main();
    namespace_8911e65c::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_biodome";
}

// Namespace namespace_86fa17e8
// Params 2, eflags: 0x1 linked
// namespace_86fa17e8<file_0>::function_b6d6bffc
// Checksum 0x296b2810, Offset: 0x330
// Size: 0xc2
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case 8:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case 9:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r90";
        } else {
            return "ui/fx_dom_marker_team_r90";
        }
        break;
    case 10:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r90";
        } else {
            return "ui/fx_dom_marker_team_r90";
        }
        break;
    }
}

// Namespace namespace_86fa17e8
// Params 2, eflags: 0x1 linked
// namespace_86fa17e8<file_0>::function_628641cd
// Checksum 0x8b2c7295, Offset: 0x400
// Size: 0xc2
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case 8:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case 9:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r90";
        } else {
            return "ui/fx_dom_cap_indicator_team_r90";
        }
        break;
    case 10:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r90";
        } else {
            return "ui/fx_dom_cap_indicator_team_r90";
        }
        break;
    }
}

