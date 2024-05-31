#using scripts/mp/mp_shrine_sound;
#using scripts/mp/mp_shrine_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_b709af10;

// Namespace namespace_b709af10
// Params 0, eflags: 0x1 linked
// namespace_b709af10<file_0>::function_d290ebfa
// Checksum 0xc804a76e, Offset: 0x1b8
// Size: 0x8c
function main() {
    namespace_77772e61::main();
    namespace_704c92f4::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_shrine";
}

// Namespace namespace_b709af10
// Params 2, eflags: 0x1 linked
// namespace_b709af10<file_0>::function_b6d6bffc
// Checksum 0xef875f19, Offset: 0x250
// Size: 0x9e
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

// Namespace namespace_b709af10
// Params 2, eflags: 0x1 linked
// namespace_b709af10<file_0>::function_628641cd
// Checksum 0xd8591991, Offset: 0x2f8
// Size: 0x9e
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

