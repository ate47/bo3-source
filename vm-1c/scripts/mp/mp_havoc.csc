#using scripts/mp/mp_havoc_sound;
#using scripts/mp/mp_havoc_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_7deb8b28;

// Namespace namespace_7deb8b28
// Params 0, eflags: 0x1 linked
// Checksum 0xaee7ccc6, Offset: 0x1d8
// Size: 0xcc
function main() {
    namespace_923df269::main();
    namespace_5261409c::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_havoc";
}

// Namespace namespace_7deb8b28
// Params 2, eflags: 0x1 linked
// Checksum 0x73d45f78, Offset: 0x2b0
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

// Namespace namespace_7deb8b28
// Params 2, eflags: 0x1 linked
// Checksum 0xa6735b8f, Offset: 0x358
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

