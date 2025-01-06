#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_sector_fx;
#using scripts/mp/mp_sector_sound;
#using scripts/shared/util_shared;

#namespace mp_sector;

// Namespace mp_sector
// Params 0, eflags: 0x0
// Checksum 0x2c83cb0e, Offset: 0x230
// Size: 0x8a
function main() {
    mp_sector_fx::main();
    mp_sector_sound::main();
    level.disablefxaniminsplitscreencount = 3;
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_sector";
}

// Namespace mp_sector
// Params 2, eflags: 0x0
// Checksum 0x9a852f2b, Offset: 0x2c8
// Size: 0x91
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case "a":
        break;
    case "b":
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r90";
        } else {
            return "ui/fx_dom_marker_team_r90";
        }
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

// Namespace mp_sector
// Params 2, eflags: 0x0
// Checksum 0xb626d3d5, Offset: 0x368
// Size: 0x91
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case "a":
        break;
    case "b":
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r90";
        } else {
            return "ui/fx_dom_cap_indicator_team_r90";
        }
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

