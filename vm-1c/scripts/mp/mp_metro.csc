#using scripts/mp/mp_metro_sound;
#using scripts/mp/mp_metro_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_27da2c28;

// Namespace namespace_27da2c28
// Params 0, eflags: 0x1 linked
// Checksum 0xee30ca84, Offset: 0x278
// Size: 0x114
function main() {
    namespace_dbba1d69::main();
    namespace_4dd2d99c::main();
    clientfield::register("scriptmover", "mp_metro_train_timer", 1, 1, "int", &function_272a236, 1, 0);
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_metro";
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
}

// Namespace namespace_27da2c28
// Params 1, eflags: 0x1 linked
// Checksum 0xfdbfc8bb, Offset: 0x398
// Size: 0x448
function function_610d5819(localclientnum) {
    self endon(#"entityshutdown");
    angles = (self.angles[0], self.angles[1] * -1, 0);
    var_29f291aa = self.origin + (cos(self.angles[1]) * 37, sin(self.angles[1]) * 37, 0);
    var_b9aef0d0 = util::spawn_model(localclientnum, "p7_3d_txt_antiqua_bold_00_brushed_aluminum", var_29f291aa, angles);
    var_c65b8fec = self.origin + (cos(self.angles[1]) * 37 * 2, sin(self.angles[1]) * 37 * 2, 0);
    var_6bed63d2 = util::spawn_model(localclientnum, "p7_3d_txt_antiqua_bold_00_brushed_aluminum", var_c65b8fec, angles);
    var_bf41c693 = self.origin - (cos(self.angles[1]) * 37, sin(self.angles[1]) * 37, 0);
    var_55c7a409 = util::spawn_model(localclientnum, "p7_3d_txt_antiqua_bold_00_brushed_aluminum", var_bf41c693, angles);
    var_f088cae4 = self.origin - (cos(self.angles[1]) * 37 * 2, sin(self.angles[1]) * 37 * 2, 0);
    var_38f78f6a = util::spawn_model(localclientnum, "p7_3d_txt_antiqua_bold_00_brushed_aluminum", var_f088cae4, angles);
    currentnumber = 1;
    var_9a505860 = 0;
    for (;;) {
        currentnumber++;
        if (currentnumber > 9) {
            currentnumber = 0;
        }
        var_8a0c8642 = int(ceil(self.angles[2]));
        if (var_8a0c8642 < 0) {
            var_8a0c8642 += 360;
        }
        if (var_8a0c8642 < 0 || var_8a0c8642 > 360) {
            var_8a0c8642 = 0;
        }
        var_38f78f6a setmodel("p7_3d_txt_antiqua_bold_0" + var_8a0c8642 % 10 + "_brushed_aluminum");
        var_55c7a409 setmodel("p7_3d_txt_antiqua_bold_0" + int(var_8a0c8642 % 60 / 10) + "_brushed_aluminum");
        var_b9aef0d0 setmodel("p7_3d_txt_antiqua_bold_0" + int(var_8a0c8642 / 60) + "_brushed_aluminum");
        wait(0.05);
    }
}

// Namespace namespace_27da2c28
// Params 7, eflags: 0x1 linked
// Checksum 0x6323aed2, Offset: 0x7e8
// Size: 0x6c
function function_272a236(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    if (newval == 1) {
        self thread function_610d5819(localclientnum);
    }
}

// Namespace namespace_27da2c28
// Params 2, eflags: 0x1 linked
// Checksum 0x146d954, Offset: 0x860
// Size: 0xc2
function dom_flag_base_fx_override(flag, team) {
    switch (flag.name) {
    case 12:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case 13:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    case 14:
        if (team == "neutral") {
            return "ui/fx_dom_marker_neutral_r120";
        } else {
            return "ui/fx_dom_marker_team_r120";
        }
        break;
    }
}

// Namespace namespace_27da2c28
// Params 2, eflags: 0x1 linked
// Checksum 0xff48e7b, Offset: 0x930
// Size: 0xc2
function dom_flag_cap_fx_override(flag, team) {
    switch (flag.name) {
    case 12:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case 13:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    case 14:
        if (team == "neutral") {
            return "ui/fx_dom_cap_indicator_neutral_r120";
        } else {
            return "ui/fx_dom_cap_indicator_team_r120";
        }
        break;
    }
}

