#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_city_fx;
#using scripts/mp/mp_city_sound;
#using scripts/mp/vehicles/_quadtank;
#using scripts/mp/vehicles/_siegebot;
#using scripts/mp/vehicles/_siegebot_theia;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace mp_city;

// Namespace mp_city
// Params 0, eflags: 0x0
// Checksum 0x5fdd6490, Offset: 0x2b8
// Size: 0xf4
function main() {
    clientfield::register("scriptmover", "ring_state", 15000, 2, "int", &function_d9f6a33c, 0, 0);
    mp_city_fx::main();
    mp_city_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_city";
    level scene::play("p7_fxanim_gp_light_emergency_military_01_bundle");
}

// Namespace mp_city
// Params 2, eflags: 0x0
// Checksum 0x15592b49, Offset: 0x3b8
// Size: 0x9e
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

// Namespace mp_city
// Params 2, eflags: 0x0
// Checksum 0xe085db92, Offset: 0x460
// Size: 0x9e
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

// Namespace mp_city
// Params 7, eflags: 0x0
// Checksum 0x74f865b2, Offset: 0x508
// Size: 0x10e
function function_d9f6a33c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_c8ef6ef0");
    if (!isdefined(self.var_a9e64a4e)) {
        self.var_a9e64a4e = 0;
    }
    switch (newval) {
    case 0:
        self function_e5636218(localclientnum);
        break;
    case 1:
        self function_857cbaeb(localclientnum);
        break;
    case 2:
        self function_b620184c(localclientnum);
        break;
    case 3:
        self thread function_1afd2fff(localclientnum);
        break;
    }
}

// Namespace mp_city
// Params 6, eflags: 0x0
// Checksum 0xb72a3c6a, Offset: 0x620
// Size: 0x1f4
function function_4b249f9b(localclientnum, time, var_728dd484, var_b9359340, var_1cf558a0, var_ecf795c3) {
    self endon(#"hash_c8ef6ef0");
    self endon(#"entityshutdown");
    starttime = getservertime(localclientnum);
    currtime = starttime;
    function_211e661e(localclientnum, time, var_ecf795c3, 0);
    while (true) {
        amount = (currtime - starttime) % time;
        percent = float(amount) / time;
        up = int((currtime - starttime) / time) % 2;
        if (up) {
            percent = 1 - percent;
        }
        if (var_1cf558a0 == 1) {
            percent *= percent;
        }
        self.var_a9e64a4e = lerpfloat(var_728dd484, var_b9359340, percent);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, pow(self.var_a9e64a4e, 4), 0, 0);
        wait 0.016;
        currtime = getservertime(localclientnum);
    }
}

// Namespace mp_city
// Params 7, eflags: 0x0
// Checksum 0x9782e78e, Offset: 0x820
// Size: 0x29c
function function_6c36a9a7(localclientnum, time, var_728dd484, var_b9359340, var_1cf558a0, var_ecf795c3, total_time) {
    self endon(#"hash_c8ef6ef0");
    self endon(#"entityshutdown");
    starttime = getservertime(localclientnum);
    currtime = starttime;
    function_211e661e(localclientnum, time, var_ecf795c3, 0);
    direction = 0;
    startintensity = var_728dd484;
    finalintensity = var_b9359340;
    while (true) {
        var_36eba823 = (currtime - starttime) / total_time;
        var_36eba823 *= var_36eba823;
        var_36eba823 = 1 - var_36eba823;
        if (var_36eba823 < 0) {
            var_36eba823 = 0;
        }
        amount = (currtime - starttime) % time;
        percent = float(amount) / time;
        up = int((currtime - starttime) / time) % 2;
        if (direction != up) {
            startintensity = finalintensity;
            finalintensity = randomfloatrange(0, 1 * var_36eba823);
        }
        if (var_1cf558a0 == 1) {
            percent *= percent;
        }
        self.var_a9e64a4e = lerpfloat(startintensity, finalintensity, percent);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, pow(self.var_a9e64a4e, 4), 0, 0);
        wait 0.016;
        currtime = getservertime(localclientnum);
    }
}

// Namespace mp_city
// Params 4, eflags: 0x0
// Checksum 0xba125b49, Offset: 0xac8
// Size: 0x192
function function_211e661e(localclientnum, time, var_ecf795c3, var_1cf558a0) {
    self endon(#"entityshutdown");
    starttime = getservertime(localclientnum);
    currtime = starttime;
    startintensity = self.var_a9e64a4e;
    while (self.var_a9e64a4e != var_ecf795c3) {
        percent = float(currtime - starttime) / time;
        if (percent > 1) {
            percent = 1;
        }
        if (var_1cf558a0 == 1) {
            percent *= percent;
        }
        self.var_a9e64a4e = lerpfloat(startintensity, var_ecf795c3, percent);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, pow(self.var_a9e64a4e, 4), 0, 0);
        wait 0.016;
        currtime = getservertime(localclientnum);
    }
    wait 0.016;
    self notify(#"hash_3adb36eb");
}

// Namespace mp_city
// Params 1, eflags: 0x0
// Checksum 0x24c83e22, Offset: 0xc68
// Size: 0xbc
function function_1afd2fff(localclientnum) {
    self endon(#"entityshutdown");
    self thread function_211e661e(localclientnum, 90, self.var_a9e64a4e / 2, 1);
    self waittill(#"hash_3adb36eb");
    self thread function_211e661e(localclientnum, 4000, 0, 1);
    self waittill(#"hash_3adb36eb");
    self thread function_4b249f9b(localclientnum, 2000, 0.15, 0.25, 1, 0.15);
}

// Namespace mp_city
// Params 1, eflags: 0x0
// Checksum 0x53ddfc63, Offset: 0xd30
// Size: 0x2c
function function_e5636218(localclientnum) {
    self thread function_211e661e(localclientnum, 2000, 1, 0);
}

// Namespace mp_city
// Params 1, eflags: 0x0
// Checksum 0x18d75edf, Offset: 0xd68
// Size: 0x44
function function_857cbaeb(localclientnum) {
    self thread function_4b249f9b(localclientnum, 2000, 0.25, 0.5, 0, 0.25);
}

// Namespace mp_city
// Params 1, eflags: 0x0
// Checksum 0x5d4ba8c5, Offset: 0xdb8
// Size: 0x3c
function function_b620184c(localclientnum) {
    self thread function_6c36a9a7(localclientnum, 90, 0, 1, 1, 0, 4200);
}

