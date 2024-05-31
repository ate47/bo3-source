#using scripts/shared/_burnplayer;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_a31481e3;

// Namespace namespace_a31481e3
// Params 0, eflags: 0x2
// namespace_a31481e3<file_0>::function_2dc19561
// Checksum 0x9867c537, Offset: 0x390
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_heat_wave", &__init__, undefined, undefined);
}

// Namespace namespace_a31481e3
// Params 0, eflags: 0x1 linked
// namespace_a31481e3<file_0>::function_8c87d8eb
// Checksum 0x16276cba, Offset: 0x3d0
// Size: 0x164
function __init__() {
    clientfield::register("scriptmover", "heatwave_fx", 1, 1, "int", &function_35b42cb4, 0, 0);
    clientfield::register("allplayers", "heatwave_victim", 1, 1, "int", &function_318dd491, 0, 0);
    clientfield::register("toplayer", "heatwave_activate", 1, 1, "int", &function_4bf284ca, 0, 0);
    level.var_ca9e7366 = getdvarint("scr_debug_heat_wave_traces", 0);
    visionset_mgr::register_visionset_info("heatwave", 1, 16, undefined, "heatwave");
    visionset_mgr::register_visionset_info("charred", 1, 16, undefined, "charred");
    /#
        level thread updatedvars();
    #/
}

/#

    // Namespace namespace_a31481e3
    // Params 0, eflags: 0x1 linked
    // namespace_a31481e3<file_0>::function_22cd788
    // Checksum 0x58568507, Offset: 0x540
    // Size: 0x48
    function updatedvars() {
        while (true) {
            level.var_ca9e7366 = getdvarint("scr_debug_heat_wave_traces", level.var_ca9e7366);
            wait(1);
        }
    }

#/

// Namespace namespace_a31481e3
// Params 7, eflags: 0x1 linked
// namespace_a31481e3<file_0>::function_4bf284ca
// Checksum 0x96781e0c, Offset: 0x590
// Size: 0x64
function function_4bf284ca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_heat_pulse");
    }
}

// Namespace namespace_a31481e3
// Params 7, eflags: 0x1 linked
// namespace_a31481e3<file_0>::function_318dd491
// Checksum 0x1e653eca, Offset: 0x600
// Size: 0xa4
function function_318dd491(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self endon(#"entityshutdown");
        self util::waittill_dobj(localclientnum);
        self playrumbleonentity(localclientnum, "heat_wave_damage");
        playtagfxset(localclientnum, "ability_hero_heat_wave_player_impact", self);
    }
}

// Namespace namespace_a31481e3
// Params 7, eflags: 0x1 linked
// namespace_a31481e3<file_0>::function_35b42cb4
// Checksum 0xba2be5e3, Offset: 0x6b0
// Size: 0x84
function function_35b42cb4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_45bc6290(localclientnum);
    if (newval) {
        self.var_c9a5771e = [];
        self thread aoe_fx(localclientnum);
    }
}

// Namespace namespace_a31481e3
// Params 1, eflags: 0x1 linked
// namespace_a31481e3<file_0>::function_45bc6290
// Checksum 0x5aa95cc7, Offset: 0x740
// Size: 0xaa
function function_45bc6290(localclientnum) {
    if (!isdefined(self.var_c9a5771e)) {
        return;
    }
    foreach (fx in self.var_c9a5771e) {
        stopfx(localclientnum, fx);
    }
}

// Namespace namespace_a31481e3
// Params 1, eflags: 0x1 linked
// namespace_a31481e3<file_0>::function_a85dedff
// Checksum 0x2dcc08a7, Offset: 0x7f8
// Size: 0x356
function aoe_fx(localclientnum) {
    self endon(#"entityshutdown");
    center = self.origin + (0, 0, 30);
    startpitch = -90;
    yaw_count = [];
    yaw_count[0] = 1;
    yaw_count[1] = 4;
    yaw_count[2] = 6;
    yaw_count[3] = 8;
    yaw_count[4] = 6;
    yaw_count[5] = 4;
    yaw_count[6] = 1;
    pitch_vals = [];
    pitch_vals[0] = 90;
    pitch_vals[3] = 0;
    pitch_vals[6] = -90;
    trace = bullettrace(center, center + (0, 0, -1) * 400, 0, self);
    if (trace["fraction"] < 1) {
        pitch_vals[1] = 90 - atan(-106 / trace["fraction"] * 400);
        pitch_vals[2] = 90 - atan(300 / trace["fraction"] * 400);
    } else {
        pitch_vals[1] = 60;
        pitch_vals[2] = 30;
    }
    trace = bullettrace(center, center + (0, 0, 1) * 400, 0, self);
    if (trace["fraction"] < 1) {
        pitch_vals[5] = -90 + atan(-106 / trace["fraction"] * 400);
        pitch_vals[4] = -90 + atan(300 / trace["fraction"] * 400);
    } else {
        pitch_vals[5] = -60;
        pitch_vals[4] = -30;
    }
    currentpitch = startpitch;
    for (yaw_level = 0; yaw_level < yaw_count.size; yaw_level++) {
        currentpitch = pitch_vals[yaw_level];
        function_89e1d77b(localclientnum, center, yaw_count[yaw_level], currentpitch);
    }
}

// Namespace namespace_a31481e3
// Params 4, eflags: 0x1 linked
// namespace_a31481e3<file_0>::function_89e1d77b
// Checksum 0x2e0b8f5a, Offset: 0xb58
// Size: 0x4c6
function function_89e1d77b(localclientnum, center, yaw_count, pitch) {
    currentyaw = randomint(360);
    for (fxcount = 0; fxcount < yaw_count; fxcount++) {
        randomoffsetpitch = randomint(5) - 2.5;
        randomoffsetyaw = randomint(30) - 15;
        angles = (pitch + randomoffsetpitch, currentyaw + randomoffsetyaw, 0);
        tracedir = anglestoforward(angles);
        currentyaw += 360 / yaw_count;
        fx_position = center + tracedir * 400;
        trace = bullettrace(center, fx_position, 0, self);
        sphere_size = 5;
        angles = (0, randomint(360), 0);
        forward = anglestoforward(angles);
        if (trace["fraction"] < 1) {
            fx_position = center + tracedir * 400 * trace["fraction"];
            /#
                if (level.var_ca9e7366) {
                    sphere(fx_position, sphere_size, (1, 0, 1), 1, 1, 8, 300);
                    sphere(trace["scr_debug_heat_wave_traces"], sphere_size, (1, 1, 0), 1, 1, 8, 300);
                }
            #/
            normal = trace["normal"];
            if (lengthsquared(normal) == 0) {
                normal = -1 * tracedir;
            }
            right = (normal[2] * -1, normal[1] * -1, normal[0]);
            if (lengthsquared(vectorcross(forward, normal)) == 0) {
                forward = vectorcross(right, forward);
            }
            self.var_c9a5771e[self.var_c9a5771e.size] = playfx(localclientnum, "player/fx_plyr_heat_wave_distortion_volume", trace["position"], normal, forward);
        } else {
            /#
                if (level.var_ca9e7366) {
                    line(fx_position + (0, 0, 50), fx_position - (0, 0, 50), (1, 0, 0), 1, 0, 300);
                    sphere(fx_position, sphere_size, (1, 0, 1), 1, 1, 8, 300);
                }
            #/
            if (lengthsquared(vectorcross(forward, tracedir * -1)) == 0) {
                forward = vectorcross(right, forward);
            }
            self.var_c9a5771e[self.var_c9a5771e.size] = playfx(localclientnum, "player/fx_plyr_heat_wave_distortion_volume_air", fx_position, tracedir * -1, forward);
        }
        if (fxcount % 2) {
            wait(0.016);
        }
    }
}

