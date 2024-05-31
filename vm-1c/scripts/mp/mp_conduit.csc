#using scripts/mp/mp_conduit_sound;
#using scripts/mp/mp_conduit_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_e67b01cd;

// Namespace namespace_e67b01cd
// Params 0, eflags: 0x1 linked
// namespace_e67b01cd<file_0>::function_d290ebfa
// Checksum 0xbc51c125, Offset: 0x1b8
// Size: 0x8c
function main() {
    namespace_ce5ca93a::main();
    namespace_ca681cbd::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    load::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_conduit";
}

// Namespace namespace_e67b01cd
// Params 2, eflags: 0x1 linked
// namespace_e67b01cd<file_0>::function_b6d6bffc
// Checksum 0xc391018e, Offset: 0x250
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

// Namespace namespace_e67b01cd
// Params 2, eflags: 0x1 linked
// namespace_e67b01cd<file_0>::function_628641cd
// Checksum 0x730de9cf, Offset: 0x2f8
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

