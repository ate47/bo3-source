#using scripts/mp/mp_chinatown_sound;
#using scripts/mp/mp_chinatown_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_3411baba;

// Namespace namespace_3411baba
// Params 0, eflags: 0x1 linked
// namespace_3411baba<file_0>::function_d290ebfa
// Checksum 0xe7ce9c23, Offset: 0x1e8
// Size: 0xb4
function main() {
    namespace_fc074aef::main();
    namespace_92e32ef6::main();
    level.disablefxaniminsplitscreencount = 3;
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_chinatown";
    level.var_283122e6 = &function_ea38265c;
}

// Namespace namespace_3411baba
// Params 1, eflags: 0x1 linked
// namespace_3411baba<file_0>::function_ea38265c
// Checksum 0xfe5ba942, Offset: 0x2a8
// Size: 0x7e
function function_ea38265c(scriptbundlename) {
    if (isdefined(level.localplayers) && level.localplayers.size < 2) {
        return false;
    }
    if (issubstr(scriptbundlename, "p7_fxanim_gp_shutter")) {
        return true;
    }
    if (issubstr(scriptbundlename, "p7_fxanim_gp_trash")) {
        return true;
    }
    return false;
}

// Namespace namespace_3411baba
// Params 2, eflags: 0x1 linked
// namespace_3411baba<file_0>::function_b6d6bffc
// Checksum 0xc644d124, Offset: 0x330
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

// Namespace namespace_3411baba
// Params 2, eflags: 0x1 linked
// namespace_3411baba<file_0>::function_628641cd
// Checksum 0xa1f19b6a, Offset: 0x400
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

