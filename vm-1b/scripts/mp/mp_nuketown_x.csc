#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_nuketown_x_fx;
#using scripts/mp/mp_nuketown_x_sound;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;

#namespace mp_nuketown_x;

// Namespace mp_nuketown_x
// Params 0, eflags: 0x0
// Checksum 0x53658201, Offset: 0x250
// Size: 0x12a
function main() {
    clientfield::register("scriptmover", "nuketown_population_ones", 1, 4, "int", &function_a3fc1001, 0, 0);
    clientfield::register("scriptmover", "nuketown_population_tens", 1, 4, "int", &function_a3fc1001, 0, 0);
    clientfield::register("world", "nuketown_endgame", 1, 1, "int", &function_db2629eb, 0, 0);
    mp_nuketown_x_fx::main();
    mp_nuketown_x_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_nuketown";
}

// Namespace mp_nuketown_x
// Params 7, eflags: 0x0
// Checksum 0x8ce1c6c2, Offset: 0x388
// Size: 0x92
function function_db2629eb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    /#
        if (newval) {
            setdvar("<dev string:x28>", 0);
            setdvar("<dev string:x3c>", 10.64);
            return;
        }
        setdvar("<dev string:x28>", 1);
    #/
}

// Namespace mp_nuketown_x
// Params 7, eflags: 0x0
// Checksum 0x4002fa18, Offset: 0x428
// Size: 0x5a
function function_a3fc1001(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self mapshaderconstant(localclientnum, 0, "scriptVector0", newval, 0, 0, 0);
}

// Namespace mp_nuketown_x
// Params 2, eflags: 0x0
// Checksum 0x85b98f5c, Offset: 0x490
// Size: 0xb1
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
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
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

// Namespace mp_nuketown_x
// Params 2, eflags: 0x0
// Checksum 0x596e15e8, Offset: 0x550
// Size: 0xb1
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
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
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

