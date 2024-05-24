#using scripts/mp/mp_stronghold_sound;
#using scripts/mp/mp_stronghold_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_stronghold;

// Namespace mp_stronghold
// Params 0, eflags: 0x1 linked
// Checksum 0x64c7b03c, Offset: 0x1c8
// Size: 0x8c
function main() {
    namespace_eade3e58::main();
    namespace_5f813f0f::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_stronghold";
}

// Namespace mp_stronghold
// Params 2, eflags: 0x1 linked
// Checksum 0xfcec84a3, Offset: 0x260
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

// Namespace mp_stronghold
// Params 2, eflags: 0x1 linked
// Checksum 0x143a4e82, Offset: 0x308
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

