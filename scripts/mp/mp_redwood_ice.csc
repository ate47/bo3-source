#using scripts/mp/mp_redwood_ice_sound;
#using scripts/mp/mp_redwood_ice_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_10585b2d;

// Namespace namespace_10585b2d
// Params 0, eflags: 0x1 linked
// Checksum 0xb3ae5a4d, Offset: 0x1e8
// Size: 0xcc
function main() {
    namespace_9e3f655a::main();
    namespace_457acb5d::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_redwood";
}

// Namespace namespace_10585b2d
// Params 2, eflags: 0x1 linked
// Checksum 0xe5734b58, Offset: 0x2c0
// Size: 0x9e
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

// Namespace namespace_10585b2d
// Params 2, eflags: 0x1 linked
// Checksum 0x925cf255, Offset: 0x368
// Size: 0x9e
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

