#using scripts/codescripts/struct;
#using scripts/mp/_helicopter_sounds;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#using_animtree("mp_vehicles");

#namespace helicopter;

// Namespace helicopter
// Params 0, eflags: 0x2
// Checksum 0xdf59a6d5, Offset: 0x830
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("helicopter", &__init__, undefined, undefined);
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0xebb51446, Offset: 0x868
// Size: 0x60a
function __init__() {
    level.chopper_fx["damage"]["light_smoke"] = "killstreaks/fx_heli_smk_trail_engine_33";
    level.chopper_fx["damage"]["heavy_smoke"] = "killstreaks/fx_heli_smk_trail_engine_66";
    level._effect["qrdrone_prop"] = "killstreaks/fx_drgnfire_rotor_wash_runner";
    level._effect["heli_guard_light"]["friendly"] = "killstreaks/fx_sc_lights_grn";
    level._effect["heli_guard_light"]["enemy"] = "killstreaks/fx_sc_lights_red";
    level._effect["heli_comlink_light"]["common"] = "killstreaks/fx_drone_hunter_lights";
    level._effect["heli_gunner_light"]["friendly"] = "killstreaks/fx_vtol_lights_grn";
    level._effect["heli_gunner_light"]["enemy"] = "killstreaks/fx_vtol_lights_red";
    level._effect["heli_gunner"]["vtol_fx"] = "killstreaks/fx_vtol_thruster";
    level._effect["heli_gunner"]["vtol_fx_ft"] = "killstreaks/fx_vtol_thruster";
    clientfield::register("helicopter", "heli_warn_targeted", 1, 1, "int", &warnmissilelocking, 0, 0);
    clientfield::register("helicopter", "heli_warn_locked", 1, 1, "int", &warnmissilelocked, 0, 0);
    clientfield::register("helicopter", "heli_warn_fired", 1, 1, "int", &warnmissilefired, 0, 0);
    clientfield::register("helicopter", "supplydrop_care_package_state", 1, 1, "int", &supplydrop_care_package_state, 0, 0);
    clientfield::register("helicopter", "supplydrop_ai_tank_state", 1, 1, "int", &supplydrop_ai_tank_state, 0, 0);
    clientfield::register("helicopter", "heli_comlink_bootup_anim", 1, 1, "int", &heli_comlink_bootup_anim, 0, 0);
    clientfield::register("vehicle", "heli_warn_targeted", 1, 1, "int", &warnmissilelocking, 0, 0);
    clientfield::register("vehicle", "heli_warn_locked", 1, 1, "int", &warnmissilelocked, 0, 0);
    clientfield::register("vehicle", "heli_warn_fired", 1, 1, "int", &warnmissilefired, 0, 0);
    clientfield::register("vehicle", "supplydrop_care_package_state", 1, 1, "int", &supplydrop_care_package_state, 0, 0);
    clientfield::register("vehicle", "supplydrop_ai_tank_state", 1, 1, "int", &supplydrop_ai_tank_state, 0, 0);
    clientfield::register("vehicle", "heli_comlink_bootup_anim", 1, 1, "int", &heli_comlink_bootup_anim, 0, 0);
    duplicate_render::set_dr_filter_framebuffer("active_camo_scorestreak", 90, "active_camo_on", "", 0, "mc/hud_outline_predator_camo_active_enemy_scorestreak", 0);
    duplicate_render::set_dr_filter_framebuffer("active_camo_flicker_scorestreak", 80, "active_camo_flicker", "", 0, "mc/hud_outline_predator_camo_disruption_enemy_scorestreak", 0);
    duplicate_render::set_dr_filter_framebuffer_duplicate("active_camo_reveal_scorestreak_dr", 90, "active_camo_reveal", "hide_model", 1, "mc/hud_outline_predator_camo_active_enemy_scorestreak", 0);
    duplicate_render::set_dr_filter_framebuffer("active_camo_reveal_scorestreak", 80, "active_camo_reveal,hide_model", "", 0, "mc/hud_outline_predator_scorestreak", 0);
    clientfield::register("helicopter", "active_camo", 1, 3, "int", &active_camo_changed, 0, 0);
    clientfield::register("vehicle", "active_camo", 1, 3, "int", &active_camo_changed, 0, 0);
    clientfield::register("toplayer", "marker_state", 1, 2, "int", &marker_state_changed, 0, 0);
    clientfield::register("scriptmover", "supplydrop_thrusters_state", 1, 1, "int", &setsupplydropthrustersstate, 0, 0);
    clientfield::register("scriptmover", "aitank_thrusters_state", 1, 1, "int", &setaitankhrustersstate, 0, 0);
    clientfield::register("vehicle", "mothership", 1, 1, "int", &function_5a98ea62, 0, 0);
    callback::on_spawned(&on_player_spawned);
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xc5963308, Offset: 0xe80
// Size: 0x85
function on_player_spawned(localclientnum) {
    player = self;
    player waittill(#"entityshutdown");
    player.markerfx = undefined;
    if (isdefined(player.markerobj)) {
        player.markerobj delete();
    }
    if (isdefined(player.markerfxhandle)) {
        killfx(localclientnum, player.markerfxhandle);
        player.markerfxhandle = undefined;
    }
}

// Namespace helicopter
// Params 0, eflags: 0x0
// Checksum 0x3a1135cd, Offset: 0xf10
// Size: 0x2a
function setupanimtree() {
    if (self hasanimtree() == 0) {
        self useanimtree(#mp_vehicles);
    }
}

// Namespace helicopter
// Params 7, eflags: 0x0
// Checksum 0xec55ed1, Offset: 0xf48
// Size: 0x10a
function active_camo_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        self thread heli_comlink_lights_on_after_wait(localclientnum, 0.7);
    } else {
        self heli_comlink_lights_off(localclientnum);
    }
    flags_changed = self duplicate_render::set_dr_flag("active_camo_flicker", newval == 2);
    flags_changed = self duplicate_render::set_dr_flag("active_camo_on", 0) || flags_changed;
    flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 1) || flags_changed;
    if (flags_changed) {
        self duplicate_render::update_dr_filters(localclientnum);
    }
    self notify(#"endtest");
    self thread doreveal(localclientnum, newval != 0);
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x497c2e4c, Offset: 0x1060
// Size: 0x1f2
function doreveal(local_client_num, direction) {
    self notify(#"endtest");
    self endon(#"endtest");
    self endon(#"entityshutdown");
    if (direction) {
        self duplicate_render::update_dr_flag(local_client_num, "hide_model", 0);
        startval = 0;
        endval = 1;
    } else {
        self duplicate_render::update_dr_flag(local_client_num, "hide_model", 1);
        startval = 1;
        endval = 0;
    }
    priorvalue = startval;
    while (startval >= 0 && startval <= 1) {
        self mapshaderconstant(local_client_num, 0, "scriptVector0", startval, 0, 0, 0);
        if (direction) {
            startval += 0.032;
            if (priorvalue < 0.5 && startval >= 0.5) {
                self duplicate_render::set_dr_flag("hide_model", 1);
                self duplicate_render::change_dr_flags(local_client_num);
            }
        } else {
            startval -= 0.032;
            if (priorvalue > 0.5 && startval <= 0.5) {
                self duplicate_render::set_dr_flag("hide_model", 0);
                self duplicate_render::change_dr_flags(local_client_num);
            }
        }
        priorvalue = startval;
        wait 0.016;
    }
    self mapshaderconstant(local_client_num, 0, "scriptVector0", endval, 0, 0, 0);
    flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 0);
    flags_changed = self duplicate_render::set_dr_flag("active_camo_on", direction) || flags_changed;
    if (flags_changed) {
        self duplicate_render::update_dr_filters(local_client_num);
    }
}

// Namespace helicopter
// Params 7, eflags: 0x0
// Checksum 0x76f7b3a9, Offset: 0x1260
// Size: 0x92
function heli_comlink_bootup_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self endon(#"death");
    self setupanimtree();
    self setanim(mp_vehicles%veh_anim_future_heli_gearup_bay_open, 1, 0, 1);
}

// Namespace helicopter
// Params 7, eflags: 0x0
// Checksum 0x687bedce, Offset: 0x1300
// Size: 0xd2
function supplydrop_care_package_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self endon(#"death");
    self setupanimtree();
    if (newval == 1) {
        self setanim(mp_vehicles%o_drone_supply_care_idle, 1, 0, 1);
        return;
    }
    self setanim(mp_vehicles%o_drone_supply_care_drop, 1, 0, 0.3);
}

// Namespace helicopter
// Params 7, eflags: 0x0
// Checksum 0x5683cb5e, Offset: 0x13e0
// Size: 0xd2
function supplydrop_ai_tank_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self endon(#"death");
    self setupanimtree();
    if (newval == 1) {
        self setanim(mp_vehicles%o_drone_supply_agr_idle, 1, 0, 1);
        return;
    }
    self setanim(mp_vehicles%o_drone_supply_agr_drop, 1, 0, 0.3);
}

// Namespace helicopter
// Params 7, eflags: 0x0
// Checksum 0x70eeb3dd, Offset: 0x14c0
// Size: 0x6a
function warnmissilelocking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !self islocalclientdriver(localclientnum)) {
        return;
    }
    helicopter_sounds::play_targeted_sound(newval);
}

// Namespace helicopter
// Params 7, eflags: 0x0
// Checksum 0x269bc0d, Offset: 0x1538
// Size: 0x6a
function warnmissilelocked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !self islocalclientdriver(localclientnum)) {
        return;
    }
    helicopter_sounds::play_locked_sound(newval);
}

// Namespace helicopter
// Params 7, eflags: 0x0
// Checksum 0x15b8fc2d, Offset: 0x15b0
// Size: 0x6a
function warnmissilefired(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !self islocalclientdriver(localclientnum)) {
        return;
    }
    helicopter_sounds::play_fired_sound(newval);
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x2783be0a, Offset: 0x1628
// Size: 0xf9
function heli_deletefx(localclientnum) {
    if (isdefined(self.exhaustleftfxhandle)) {
        deletefx(localclientnum, self.exhaustleftfxhandle);
        self.exhaustleftfxhandle = undefined;
    }
    if (isdefined(self.exhaustrightfxhandlee)) {
        deletefx(localclientnum, self.exhaustrightfxhandle);
        self.exhaustrightfxhandle = undefined;
    }
    if (isdefined(self.lightfxid)) {
        deletefx(localclientnum, self.lightfxid);
        self.lightfxid = undefined;
    }
    if (isdefined(self.propfxid)) {
        deletefx(localclientnum, self.propfxid);
        self.propfxid = undefined;
    }
    if (isdefined(self.vtolleftfxid)) {
        deletefx(localclientnum, self.vtolleftfxid);
        self.vtolleftfxid = undefined;
    }
    if (isdefined(self.vtolrightfxid)) {
        deletefx(localclientnum, self.vtolrightfxid);
        self.vtolrightfxid = undefined;
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xe5912610, Offset: 0x1730
// Size: 0x2e2
function startfx(localclientnum) {
    self endon(#"entityshutdown");
    if (isdefined(self.vehicletype)) {
        if (self.vehicletype == "remote_mortar_vehicle_mp") {
            return;
        }
        if (self.vehicletype == "vehicle_straferun_mp") {
            return;
        }
    }
    if (isdefined(self.exhaustfxname) && self.exhaustfxname != "") {
        self.exhaustfx = self.exhaustfxname;
    }
    if (isdefined(self.exhaustfx)) {
        self.exhaustleftfxhandle = playfxontag(localclientnum, self.exhaustfx, self, "tag_engine_left");
        if (!(isdefined(self.oneexhaust) && self.oneexhaust)) {
            self.exhaustrightfxhandle = playfxontag(localclientnum, self.exhaustfx, self, "tag_engine_right");
        }
    } else {
        println("<dev string:x28>");
    }
    if (isdefined(self.vehicletype)) {
        light_fx = undefined;
        prop_fx = undefined;
        switch (self.vehicletype) {
        case "heli_ai_mp":
            light_fx = "heli_comlink_light";
            break;
        case "heli_player_gunner_mp":
            self.vtolleftfxid = playfxontag(localclientnum, level._effect["heli_gunner"]["vtol_fx"], self, "tag_engine_left");
            self.vtolrightfxid = playfxontag(localclientnum, level._effect["heli_gunner"]["vtol_fx_ft"], self, "tag_engine_right");
            light_fx = "heli_gunner_light";
            break;
        case "heli_guard_mp":
            light_fx = "heli_guard_light";
            break;
        case "qrdrone_mp":
            prop_fx = "qrdrone_prop";
            break;
        }
        if (isdefined(light_fx)) {
            if (self util::function_f36b8920(localclientnum)) {
                self.lightfxid = playfxontag(localclientnum, level._effect[light_fx]["friendly"], self, "tag_origin");
            } else {
                self.lightfxid = playfxontag(localclientnum, level._effect[light_fx]["enemy"], self, "tag_origin");
            }
        }
        if (isdefined(prop_fx) && !self islocalclientdriver(localclientnum)) {
            self.propfxid = playfxontag(localclientnum, level._effect[prop_fx], self, "tag_origin");
        }
    }
    self function_91f14f33(localclientnum);
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x5a4a7ab, Offset: 0x1a20
// Size: 0xaf
function startfx_loop(localclientnum) {
    self endon(#"entityshutdown");
    self thread helicopter_sounds::aircraft_dustkick(localclientnum);
    startfx(localclientnum);
    servertime = getservertime(0);
    lastservertime = servertime;
    while (isdefined(self)) {
        if (servertime < lastservertime) {
            heli_deletefx(localclientnum);
            startfx(localclientnum);
        }
        wait 0.05;
        lastservertime = servertime;
        servertime = getservertime(0);
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x2fab9059, Offset: 0x1ad8
// Size: 0x155
function function_91f14f33(localclientnum) {
    self endon(#"entityshutdown");
    var_2f9cc55d = self gethelidamagestate();
    fx = undefined;
    for (;;) {
        if (var_2f9cc55d != self gethelidamagestate()) {
            if (self gethelidamagestate() == 2) {
                if (isdefined(fx)) {
                    stopfx(localclientnum, fx);
                }
                fx = trail_fx(localclientnum, level.chopper_fx["damage"]["light_smoke"], "tag_engine_left");
            } else if (self gethelidamagestate() == 1) {
                if (isdefined(fx)) {
                    stopfx(localclientnum, fx);
                }
                fx = trail_fx(localclientnum, level.chopper_fx["damage"]["heavy_smoke"], "tag_engine_left");
            } else {
                if (isdefined(fx)) {
                    stopfx(localclientnum, fx);
                }
                self notify(#"hash_f6285749");
            }
            var_2f9cc55d = self gethelidamagestate();
        }
        wait 0.25;
    }
}

// Namespace helicopter
// Params 3, eflags: 0x0
// Checksum 0x971eb04f, Offset: 0x1c38
// Size: 0x3e
function trail_fx(localclientnum, trail_fx, trail_tag) {
    id = playfxontag(localclientnum, trail_fx, self, trail_tag);
    return id;
}

// Namespace helicopter
// Params 2, eflags: 0x0
// Checksum 0x3e5e5001, Offset: 0x1c80
// Size: 0x3a
function heli_comlink_lights_on_after_wait(localclientnum, wait_time) {
    self endon(#"entityshutdown");
    self endon(#"heli_comlink_lights_off");
    wait wait_time;
    self heli_comlink_lights_on(localclientnum);
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xa94a70be, Offset: 0x1cc8
// Size: 0x159
function heli_comlink_lights_on(localclientnum) {
    if (!isdefined(self.light_fx_handles_heli_comlink)) {
        self.light_fx_handles_heli_comlink = [];
    }
    self.light_fx_handles_heli_comlink[0] = playfxontag(localclientnum, level._effect["heli_comlink_light"]["common"], self, "tag_fx_light_left");
    self.light_fx_handles_heli_comlink[1] = playfxontag(localclientnum, level._effect["heli_comlink_light"]["common"], self, "tag_fx_light_right");
    self.light_fx_handles_heli_comlink[2] = playfxontag(localclientnum, level._effect["heli_comlink_light"]["common"], self, "tag_fx_tail");
    self.light_fx_handles_heli_comlink[3] = playfxontag(localclientnum, level._effect["heli_comlink_light"]["common"], self, "tag_fx_scanner");
    if (isdefined(self.team)) {
        for (i = 0; i < self.light_fx_handles_heli_comlink.size; i++) {
            setfxteam(localclientnum, self.light_fx_handles_heli_comlink[i], self.owner.team);
        }
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xe7500b63, Offset: 0x1e30
// Size: 0x71
function heli_comlink_lights_off(localclientnum) {
    self notify(#"heli_comlink_lights_off");
    if (isdefined(self.light_fx_handles_heli_comlink)) {
        for (i = 0; i < self.light_fx_handles_heli_comlink.size; i++) {
            if (isdefined(self.light_fx_handles_heli_comlink[i])) {
                deletefx(localclientnum, self.light_fx_handles_heli_comlink[i]);
            }
        }
        self.light_fx_handles_heli_comlink = undefined;
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0x1cbc1a65, Offset: 0x1eb0
// Size: 0xf9
function updatemarkerthread(localclientnum) {
    self endon(#"entityshutdown");
    player = self;
    killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
    while (isdefined(player.markerobj)) {
        viewangles = getlocalclientangles(localclientnum);
        forwardvector = vectorscale(anglestoforward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
        results = bullettrace(player geteye(), player geteye() + forwardvector, 0, player);
        player.markerobj.origin = results["position"];
        wait 0.016;
    }
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xdf4f2b52, Offset: 0x1fb8
// Size: 0xdd
function stopcrateeffects(localclientnum) {
    crate = self;
    if (isdefined(crate.thrusterfxhandle0)) {
        stopfx(localclientnum, crate.thrusterfxhandle0);
    }
    if (isdefined(crate.thrusterfxhandle1)) {
        stopfx(localclientnum, crate.thrusterfxhandle1);
    }
    if (isdefined(crate.thrusterfxhandle2)) {
        stopfx(localclientnum, crate.thrusterfxhandle2);
    }
    if (isdefined(crate.thrusterfxhandle3)) {
        stopfx(localclientnum, crate.thrusterfxhandle3);
    }
    crate.thrusterfxhandle0 = undefined;
    crate.thrusterfxhandle1 = undefined;
    crate.thrusterfxhandle2 = undefined;
    crate.thrusterfxhandle3 = undefined;
}

// Namespace helicopter
// Params 1, eflags: 0x0
// Checksum 0xfd9ac5da, Offset: 0x20a0
// Size: 0x42
function cleanupthrustersthread(localclientnum) {
    crate = self;
    crate notify(#"cleanupthrustersthread_singleton");
    crate endon(#"cleanupthrustersthread_singleton");
    crate waittill(#"entityshutdown");
    crate stopcrateeffects(localclientnum);
}

// Namespace helicopter
// Params 7, eflags: 0x0
// Checksum 0xf415c721, Offset: 0x20f0
// Size: 0x162
function setsupplydropthrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    crate = self;
    params = struct::get_script_bundle("killstreak", "killstreak_supply_drop");
    if (newval != oldval && isdefined(params.ksthrusterfx)) {
        if (newval == 1) {
            crate stopcrateeffects(localclientnum);
            crate.thrusterfxhandle0 = playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
            crate.thrusterfxhandle1 = playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
            crate.thrusterfxhandle2 = playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
            crate.thrusterfxhandle3 = playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
            crate thread cleanupthrustersthread(localclientnum);
            return;
        }
        crate stopcrateeffects(localclientnum);
    }
}

// Namespace helicopter
// Params 7, eflags: 0x0
// Checksum 0x304d803d, Offset: 0x2260
// Size: 0x3a
function function_5a98ea62(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace helicopter
// Params 7, eflags: 0x0
// Checksum 0x58df2cb0, Offset: 0x22a8
// Size: 0x162
function setaitankhrustersstate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    crate = self;
    params = struct::get_script_bundle("killstreak", "killstreak_ai_tank_drop");
    if (newval != oldval && isdefined(params.ksthrusterfx)) {
        if (newval == 1) {
            crate stopcrateeffects(localclientnum);
            crate.thrusterfxhandle0 = playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_01");
            crate.thrusterfxhandle1 = playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_02");
            crate.thrusterfxhandle2 = playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_03");
            crate.thrusterfxhandle3 = playfxontag(localclientnum, params.ksthrusterfx, crate, "tag_thruster_fx_04");
            crate thread cleanupthrustersthread(localclientnum);
            return;
        }
        crate stopcrateeffects(localclientnum);
    }
}

// Namespace helicopter
// Params 7, eflags: 0x0
// Checksum 0xa34313e5, Offset: 0x2418
// Size: 0x20a
function marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    player = self;
    killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
    if (newval == 1) {
        player.markerfx = killstreakcorebundle.fxvalidlocation;
    } else if (newval == 2) {
        player.markerfx = killstreakcorebundle.fxinvalidlocation;
    } else {
        player.markerfx = undefined;
    }
    if (isdefined(player.markerobj) && !player.markerobj hasdobj(localclientnum)) {
        return;
    }
    if (isdefined(player.markerfxhandle)) {
        killfx(localclientnum, player.markerfxhandle);
        player.markerfxhandle = undefined;
    }
    if (isdefined(player.markerfx)) {
        if (!isdefined(player.markerobj)) {
            player.markerobj = spawn(localclientnum, (0, 0, 0), "script_model");
            player.markerobj.angles = (270, 0, 0);
            player.markerobj setmodel("wpn_t7_none_world");
            player.markerobj util::waittill_dobj(localclientnum);
            player thread updatemarkerthread(localclientnum);
        }
        player.markerfxhandle = playfxontag(localclientnum, player.markerfx, player.markerobj, "tag_origin");
        return;
    }
    if (isdefined(player.markerobj)) {
        player.markerobj delete();
    }
}

