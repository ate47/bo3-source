#using scripts/mp/mp_redwood_sound;
#using scripts/mp/mp_redwood_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_da1f6db5;

// Namespace namespace_da1f6db5
// Params 0, eflags: 0x1 linked
// namespace_da1f6db5<file_0>::function_d290ebfa
// Checksum 0x33a541c7, Offset: 0x1e0
// Size: 0xcc
function main() {
    namespace_ed44fd32::main();
    namespace_a11fdab5::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_redwood";
}

// Namespace namespace_da1f6db5
// Params 2, eflags: 0x1 linked
// namespace_da1f6db5<file_0>::function_b6d6bffc
// Checksum 0xff4a8645, Offset: 0x2b8
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

// Namespace namespace_da1f6db5
// Params 2, eflags: 0x1 linked
// namespace_da1f6db5<file_0>::function_628641cd
// Checksum 0x490b20f8, Offset: 0x360
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

