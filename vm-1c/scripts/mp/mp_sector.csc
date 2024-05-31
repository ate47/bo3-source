#using scripts/mp/mp_sector_sound;
#using scripts/mp/mp_sector_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_sector;

// Namespace mp_sector
// Params 0, eflags: 0x1 linked
// Checksum 0x48d2dfe5, Offset: 0x260
// Size: 0x2ac
function main() {
    hour_hand = getentarray(0, "hour_hand", "targetname");
    minute_hand = getentarray(0, "minute_hand", "targetname");
    second_hand = getentarray(0, "second_hand", "targetname");
    foreach (hand in hour_hand) {
        hand.targetname = "second_hand";
    }
    foreach (hand in minute_hand) {
        hand.targetname = "hour_hand";
    }
    foreach (hand in second_hand) {
        hand.targetname = "minute_hand";
    }
    namespace_94bbd14::main();
    namespace_a5c10e4b::main();
    level.disablefxaniminsplitscreencount = 3;
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_sector";
}

// Namespace mp_sector
// Params 2, eflags: 0x1 linked
// Checksum 0x278af17b, Offset: 0x518
// Size: 0x9e
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case 10:
        break;
    case 11:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r90";
        } else {
            return "ui/fx_dom_marker_team_r90";
        }
        break;
    case 12:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    }
}

// Namespace mp_sector
// Params 2, eflags: 0x1 linked
// Checksum 0x1dbb70c9, Offset: 0x5c0
// Size: 0x9e
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case 10:
        break;
    case 11:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r90";
        } else {
            return "ui/fx_dom_cap_indicator_team_r90";
        }
        break;
    case 12:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    }
}

