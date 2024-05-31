#using scripts/mp/mp_rise_fx;
#using scripts/mp/mp_rise_amb;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_bf9a7466;

// Namespace namespace_bf9a7466
// Params 0, eflags: 0x1 linked
// namespace_bf9a7466<file_0>::function_d290ebfa
// Checksum 0xcc0faa90, Offset: 0x198
// Size: 0xac
function main() {
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    namespace_45ed63a3::main();
    thread namespace_b81d7907::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_rise";
    println("ui/fx_dom_cap_indicator_team_r120");
}

// Namespace namespace_bf9a7466
// Params 2, eflags: 0x1 linked
// namespace_bf9a7466<file_0>::function_b6d6bffc
// Checksum 0x9440d7b7, Offset: 0x250
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

// Namespace namespace_bf9a7466
// Params 2, eflags: 0x1 linked
// namespace_bf9a7466<file_0>::function_628641cd
// Checksum 0x156b62ac, Offset: 0x320
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

