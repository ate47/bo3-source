#using scripts/mp/mp_waterpark_sound;
#using scripts/mp/mp_waterpark_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_89648a;

// Namespace namespace_89648a
// Params 0, eflags: 0x1 linked
// Checksum 0x19b11562, Offset: 0x1e0
// Size: 0xcc
function main() {
    namespace_3844b55f::main();
    namespace_2a685566::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_splash";
}

// Namespace namespace_89648a
// Params 2, eflags: 0x1 linked
// Checksum 0x3c41ae85, Offset: 0x2b8
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

// Namespace namespace_89648a
// Params 2, eflags: 0x1 linked
// Checksum 0x73390a8d, Offset: 0x388
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

