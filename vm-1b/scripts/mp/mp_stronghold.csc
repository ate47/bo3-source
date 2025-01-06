#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_stronghold_fx;
#using scripts/mp/mp_stronghold_sound;
#using scripts/shared/util_shared;

#namespace mp_stronghold;

// Namespace mp_stronghold
// Params 0, eflags: 0x0
// Checksum 0x97c26fb1, Offset: 0x1c8
// Size: 0x82
function main() {
    mp_stronghold_fx::main();
    mp_stronghold_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_stronghold";
}

// Namespace mp_stronghold
// Params 2, eflags: 0x0
// Checksum 0x2626df30, Offset: 0x258
// Size: 0x91
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case "a":
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case "b":
        break;
    case "c":
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    }
}

// Namespace mp_stronghold
// Params 2, eflags: 0x0
// Checksum 0xa84009c1, Offset: 0x2f8
// Size: 0x91
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case "a":
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case "b":
        break;
    case "c":
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    }
}

