#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_36389e13;

// Namespace namespace_36389e13
// Params 0, eflags: 0x1 linked
// Checksum 0x27558d1b, Offset: 0x10d8
// Size: 0xbc
function main() {
    function_e6258024();
    function_f45953c();
    var_c65a3ce5 = getdvarint("disable_fx");
    if (!isdefined(var_c65a3ce5) || var_c65a3ce5 <= 0) {
        function_f45953c();
    }
    level thread function_11100deb();
    level thread function_2f56cbec();
    level thread function_e7f5550b();
}

// Namespace namespace_36389e13
// Params 0, eflags: 0x1 linked
// Checksum 0xbdaed5a8, Offset: 0x11a0
// Size: 0x86
function function_11100deb() {
    util::waitforclient(0);
    wait(3);
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        level thread function_bbc51c7e(i);
    }
}

// Namespace namespace_36389e13
// Params 0, eflags: 0x1 linked
// Checksum 0x313e8033, Offset: 0x1230
// Size: 0x7e
function function_2f56cbec() {
    util::waitforallclients();
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread function_95cb438f(i);
    }
}

// Namespace namespace_36389e13
// Params 1, eflags: 0x1 linked
// Checksum 0x2e319dce, Offset: 0x12b8
// Size: 0x14e
function function_95cb438f(localclientnum) {
    level waittill(#"power_on");
    var_2043fd45 = struct::get_array("s_airlock_jambs_fx", "targetname");
    for (i = 0; i < var_2043fd45.size; i++) {
        if (isdefined(var_2043fd45[i].script_vector)) {
            forwardvec = vectornormalize(anglestoforward(var_2043fd45[i].script_vector));
        } else {
            forwardvec = vectornormalize(anglestoforward(var_2043fd45[i].angles));
        }
        playfx(localclientnum, level._effect["airlock_fx"], var_2043fd45[i].origin, forwardvec);
    }
}

// Namespace namespace_36389e13
// Params 0, eflags: 0x1 linked
// Checksum 0x52797ece, Offset: 0x1410
// Size: 0x3ba
function function_f45953c() {
    level._effect["switch_sparks"] = "env/electrical/fx_elec_wire_spark_burst";
    level._effect["zapper_fx"] = "maps/zombie/fx_zombie_zapper_powerbox_on";
    level._effect["zapper_wall"] = "maps/zombie/fx_zombie_zapper_wall_control_on";
    level._effect["elec_trail_one_shot"] = "maps/zombie/fx_zombie_elec_trail_oneshot";
    level._effect["wire_sparks_oneshot"] = "electrical/fx_elec_wire_spark_dl_oneshot";
    level._effect["airlock_fx"] = "dlc5/moon/fx_moon_airlock_door_forcefield";
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
    level._effect["headshot"] = "impacts/fx_flesh_hit";
    level._effect["headshot_nochunks"] = "misc/fx_zombie_bloodsplat";
    level._effect["bloodspurt"] = "misc/fx_zombie_bloodspurt";
    level._effect["animscript_gib_fx"] = "weapon/bullet/fx_flesh_gib_fatal_01";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level._effect["fx_weak_sauce_trail"] = "dlc5/zmb_weapon/fx_staff_charge_souls";
    level._effect["soul_swap_trail"] = "dlc5/moon/fx_moon_soul_swap";
    level._effect["vrill_glow"] = "dlc5/moon/fx_moon_vril_glow";
    level._effect["rise_billow_lg"] = "dlc5/moon/fx_moon_body_dirt_billowing";
    level._effect["rise_dust_lg"] = "dlc5/moon/fx_moon_body_dust_falling";
    level._effect["rise_burst_lg"] = "dlc5/moon/fx_moon_hand_dirt_burst";
    level._effect["exca_beam"] = "dlc5/moon/fx_digger_light_beam";
    level._effect["exca_blink"] = "dlc5/moon/fx_beacon_light_red";
    level._effect["exca_blink_blue"] = "dlc5/moon/fx_beacon_light_blue";
    level._effect["exca_body_all"] = "dlc5/moon/fx_digger_body_all";
    level._effect["exca_arm_all"] = "dlc5/moon/fx_digger_arm_beacons_all";
    level._effect["digger_treadfx_fwd"] = "dlc5/moon/fx_digger_treadfx_fwd";
    level._effect["digger_treadfx_bkwd"] = "dlc5/moon/fx_digger_treadfx_rev";
    level._effect["panel_on"] = "dlc5/moon/fx_moon_digger_panel_on";
    level._effect["panel_off"] = "dlc5/moon/fx_moon_digger_panel_off";
    level._effect["test_spin_fx"] = "env/light/fx_light_warning";
    level._effect["blue_eyes"] = "dlc5/zmhd/fx_zombie_eye_single_blue";
    level._effect["jump_pad_active"] = "dlc5/moon/fx_moon_jump_pad_on";
    level._effect["jump_pad_jump"] = "dlc5/moon/fx_moon_jump_pad_pulse";
    level._effect["perk_machine_light_yellow"] = "dlc5/zmhd/fx_wonder_fizz_light_yellow";
    level._effect["perk_machine_light_red"] = "dlc5/zmhd/fx_wonder_fizz_light_red";
    level._effect["perk_machine_light_green"] = "dlc5/zmhd/fx_wonder_fizz_light_green";
}

// Namespace namespace_36389e13
// Params 0, eflags: 0x1 linked
// Checksum 0x25aa980f, Offset: 0x17d8
// Size: 0x382
function function_e6258024() {
    level._effect["fx_mp_fog_xsm_int"] = "maps/zombie_old/fx_mp_fog_xsm_int";
    level._effect["fx_moon_fog_spawn_closet"] = "maps/zombie_moon/fx_moon_fog_spawn_closet";
    level._effect["fx_zmb_fog_thick_300x300"] = "maps/zombie/fx_zmb_fog_thick_300x300";
    level._effect["fx_zmb_fog_thick_600x600"] = "maps/zombie/fx_zmb_fog_thick_600x600";
    level._effect["fx_moon_fog_canyon"] = "maps/zombie_moon/fx_moon_fog_canyon";
    level._effect["fx_moon_vent_wall_mist"] = "maps/zombie_moon/fx_moon_vent_wall_mist";
    level._effect["fx_dust_motes_blowing"] = "env/debris/fx_dust_motes_blowing";
    level._effect["fx_zmb_coast_sparks_int_runner"] = "maps/zombie/fx_zmb_coast_sparks_int_runner";
    level._effect["fx_moon_floodlight_narrow"] = "maps/zombie_moon/fx_moon_floodlight_narrow";
    level._effect["fx_moon_floodlight_wide"] = "maps/zombie_moon/fx_moon_floodlight_wide";
    level._effect["fx_moon_tube_light"] = "maps/zombie_moon/fx_moon_tube_light";
    level._effect["fx_moon_lamp_glow"] = "maps/zombie_moon/fx_moon_lamp_glow";
    level._effect["fx_moon_trap_switch_light_glow"] = "maps/zombie_moon/fx_moon_trap_switch_light_glow";
    level._effect["fx_moon_teleporter_beam"] = "maps/zombie_moon/fx_moon_teleporter_beam";
    level._effect["fx_moon_teleporter_start"] = "maps/zombie_moon/fx_moon_teleporter_start";
    level._effect["fx_moon_teleporter_pad_start"] = "maps/zombie_moon/fx_moon_teleporter_pad_start";
    level._effect["fx_moon_teleporter2_beam"] = "maps/zombie_moon/fx_moon_teleporter2_beam";
    level._effect["fx_moon_teleporter2_pad_start"] = "maps/zombie_moon/fx_moon_teleporter2_pad_start";
    level._effect["fx_moon_pyramid_egg"] = "maps/zombie_moon/fx_moon_pyramid_egg";
    level._effect["fx_moon_pyramid_drop"] = "maps/zombie_moon/fx_moon_pyramid_drop";
    level._effect["fx_moon_pyramid_opening"] = "maps/zombie_moon/fx_moon_pyramid_opening";
    level._effect["fx_moon_ceiling_cave_dust"] = "maps/zombie_moon/fx_moon_ceiling_cave_dust";
    level._effect["fx_moon_ceiling_cave_collapse"] = "maps/zombie_moon/fx_moon_ceiling_cave_collapse";
    level._effect["fx_moon_digger_dig_dust"] = "maps/zombie_moon/fx_moon_digger_dig_dust";
    level._effect["fx_moon_airlock_hatch_forcefield"] = "maps/zombie_moon/fx_moon_airlock_hatch_forcefield";
    level._effect["fx_moon_biodome_ceiling_breach"] = "maps/zombie_moon/fx_moon_biodome_ceiling_breach";
    level._effect["fx_moon_biodome_breach_dirt"] = "maps/zombie_moon/fx_moon_biodome_breach_dirt";
    level._effect["fx_moon_breach_debris_room_os"] = "maps/zombie_moon/fx_moon_breach_debris_room_os";
    level._effect["fx_moon_breach_debris_out_os"] = "maps/zombie_moon/fx_moon_breach_debris_out_os";
    level._effect["fx_earth_destroyed"] = "maps/zombie_moon/fx_earth_destroyed";
    level._effect["lght_marker_flare"] = "dlc5/zmhd/fx_zombie_coast_marker_fl";
    level._effect["fx_quad_vent_break"] = "maps/zombie/fx_zombie_crawler_vent_break";
}

// Namespace namespace_36389e13
// Params 0, eflags: 0x1 linked
// Checksum 0x372eacb2, Offset: 0x1b68
// Size: 0x10
function function_e7f5550b() {
    level waittill(#"power_on");
}

// Namespace namespace_36389e13
// Params 3, eflags: 0x0
// Checksum 0x17e182a, Offset: 0x1b80
// Size: 0xb2
function trap_fx_monitor(name, side, trap_type) {
    while (true) {
        level waittill(name);
        points = struct::get_array(name, "targetname");
        for (i = 0; i < points.size; i++) {
            points[i] thread function_1fc3f4ef(name, side, trap_type);
        }
    }
}

// Namespace namespace_36389e13
// Params 0, eflags: 0x1 linked
// Checksum 0xcd634da9, Offset: 0x1c40
// Size: 0x7a
function function_885ea84e() {
    exploder::exploder("fxexp_300 ");
    if (!level clientfield::get("zombie_power_on")) {
        level util::waittill_any("power_on", "pwr", "ZPO");
    }
    level notify(#"hash_147d1558");
}

// Namespace namespace_36389e13
// Params 0, eflags: 0x1 linked
// Checksum 0x1b420036, Offset: 0x1cc8
// Size: 0x86
function function_4d92f4d4() {
    exploder::exploder("fxexp_320");
    if (!level clientfield::get("zombie_power_on")) {
        level util::waittill_any("power_on", "pwr", "ZPO");
    }
    level notify(#"hash_d2897965");
    level notify(#"hash_f88bf3ce");
}

// Namespace namespace_36389e13
// Params 0, eflags: 0x1 linked
// Checksum 0x97857759, Offset: 0x1d58
// Size: 0x7a
function function_a9bf6d81() {
    exploder::exploder("fxexp_340");
    if (!level clientfield::get("zombie_power_on")) {
        level util::waittill_any("power_on", "pwr", "ZPO");
    }
    level notify(#"hash_ac86fefc");
}

// Namespace namespace_36389e13
// Params 3, eflags: 0x1 linked
// Checksum 0xfba9c75a, Offset: 0x1de0
// Size: 0x270
function function_1fc3f4ef(name, side, trap_type) {
    ang = self.angles;
    forward = anglestoforward(ang);
    up = anglestoup(ang);
    if (isdefined(self.loopfx)) {
        for (i = 0; i < self.loopfx.size; i++) {
            self.loopfx[i] delete();
        }
        self.loopfx = [];
    }
    if (!isdefined(self.loopfx)) {
        self.loopfx = [];
    }
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        switch (trap_type) {
        case 144:
            self.loopfx[i] = spawnfx(i, level._effect["zapper"], self.origin, 0, forward, up);
            break;
        case 145:
        default:
            self.loopfx[i] = spawnfx(i, level._effect["fire_trap_med"], self.origin, 0, forward, up);
            break;
        }
        triggerfx(self.loopfx[i]);
    }
    level waittill(side + "off");
    for (i = 0; i < self.loopfx.size; i++) {
        self.loopfx[i] delete();
    }
    self.loopfx = [];
}

// Namespace namespace_36389e13
// Params 1, eflags: 0x1 linked
// Checksum 0x606f9567, Offset: 0x2058
// Size: 0x224
function function_bbc51c7e(localclientnum) {
    var_62cf79c9 = getentarray(localclientnum, "zombie_moonExterior", "targetname");
    array::thread_all(var_62cf79c9, &function_fd0916fe, &function_59554ebd);
    var_f7d8bbab = getentarray(localclientnum, "zombie_moonInterior", "targetname");
    array::thread_all(var_f7d8bbab, &function_fd0916fe, &function_faf77143);
    var_cd5ed146 = getentarray(localclientnum, "zombie_moonBiodome", "targetname");
    array::thread_all(var_cd5ed146, &function_fd0916fe, &function_1decddc);
    var_cd5ed146 = getentarray(localclientnum, "zombie_moonTunnels", "targetname");
    array::thread_all(var_cd5ed146, &function_fd0916fe, &function_6a3198a);
    var_48bff2ec = getentarray(localclientnum, "zombie_nmlVision", "targetname");
    if (isdefined(var_48bff2ec) && var_48bff2ec.size > 0) {
        array::thread_all(var_48bff2ec, &function_fd0916fe, &function_2931cece);
    }
}

// Namespace namespace_36389e13
// Params 1, eflags: 0x1 linked
// Checksum 0x3f12a206, Offset: 0x2288
// Size: 0x68
function function_fd0916fe(var_c4d905ce) {
    while (true) {
        who = self waittill(#"trigger");
        if (who islocalplayer()) {
            self thread util::trigger_thread(who, var_c4d905ce);
        }
    }
}

// Namespace namespace_36389e13
// Params 1, eflags: 0x1 linked
// Checksum 0x19b8d9c5, Offset: 0x22f8
// Size: 0x1dc
function function_59554ebd(ent_player) {
    if (!isdefined(ent_player)) {
        return;
    }
    ent_player endon(#"entityshutdown");
    var_82267cf6 = 2098.71;
    var_370979c5 = 1740.12;
    half_height = 1332.23;
    var_ce3acb38 = 576.887;
    var_4f40cb18 = 0.0196078;
    var_ad258895 = 0.0235294;
    var_ef192488 = 0.0352941;
    var_e6f7f220 = 4.1367;
    var_ffae135d = 0.247;
    var_e17a08c0 = 0.235;
    var_9f866ccd = 0.16;
    var_706cff38 = 0.796421;
    var_966f79a1 = 0.425854;
    var_bc71f40a = 0.429374;
    var_14c07505 = 0;
    var_7b5a55b1 = 55;
    time = 0;
    var_d6eebf82 = 0.95;
    setclientvolumetricfog(var_82267cf6, var_370979c5, half_height, var_ce3acb38, var_4f40cb18, var_ad258895, var_ef192488, var_e6f7f220, var_ffae135d, var_e17a08c0, var_9f866ccd, var_706cff38, var_966f79a1, var_bc71f40a, var_14c07505, var_7b5a55b1, time, var_d6eebf82);
}

// Namespace namespace_36389e13
// Params 1, eflags: 0x1 linked
// Checksum 0x24c03f06, Offset: 0x24e0
// Size: 0x1dc
function function_faf77143(ent_player) {
    if (!isdefined(ent_player)) {
        return;
    }
    ent_player endon(#"entityshutdown");
    var_82267cf6 = 2098.71;
    var_370979c5 = 1740.12;
    half_height = 1332.23;
    var_ce3acb38 = 576.887;
    var_4f40cb18 = 0.0196078;
    var_ad258895 = 0.0235294;
    var_ef192488 = 0.0352941;
    var_e6f7f220 = 4.1367;
    var_ffae135d = 0.247;
    var_e17a08c0 = 0.235;
    var_9f866ccd = 0.16;
    var_706cff38 = 0.796421;
    var_966f79a1 = 0.425854;
    var_bc71f40a = 0.429374;
    var_14c07505 = 0;
    var_7b5a55b1 = 55;
    time = 0;
    var_d6eebf82 = 0.95;
    setclientvolumetricfog(var_82267cf6, var_370979c5, half_height, var_ce3acb38, var_4f40cb18, var_ad258895, var_ef192488, var_e6f7f220, var_ffae135d, var_e17a08c0, var_9f866ccd, var_706cff38, var_966f79a1, var_bc71f40a, var_14c07505, var_7b5a55b1, time, var_d6eebf82);
}

// Namespace namespace_36389e13
// Params 1, eflags: 0x1 linked
// Checksum 0x8dac57ed, Offset: 0x26c8
// Size: 0x1dc
function function_1decddc(ent_player) {
    if (!isdefined(ent_player)) {
        return;
    }
    ent_player endon(#"entityshutdown");
    var_82267cf6 = 65.3744;
    var_370979c5 = 860.241;
    half_height = 35.1158;
    var_ce3acb38 = 116.637;
    var_4f40cb18 = 0.117647;
    var_ad258895 = 0.137255;
    var_ef192488 = 0.101961;
    var_e6f7f220 = 2.96282;
    var_ffae135d = 0.341176;
    var_e17a08c0 = 0.231373;
    var_9f866ccd = 0.141176;
    var_706cff38 = 0.315232;
    var_966f79a1 = 0.132689;
    var_bc71f40a = -0.939693;
    var_14c07505 = 0;
    var_7b5a55b1 = 44.4323;
    time = 0;
    var_d6eebf82 = 0.836437;
    setclientvolumetricfog(var_82267cf6, var_370979c5, half_height, var_ce3acb38, var_4f40cb18, var_ad258895, var_ef192488, var_e6f7f220, var_ffae135d, var_e17a08c0, var_9f866ccd, var_706cff38, var_966f79a1, var_bc71f40a, var_14c07505, var_7b5a55b1, time, var_d6eebf82);
}

// Namespace namespace_36389e13
// Params 1, eflags: 0x1 linked
// Checksum 0xcfcc9bdf, Offset: 0x28b0
// Size: 0x1dc
function function_6a3198a(ent_player) {
    if (!isdefined(ent_player)) {
        return;
    }
    ent_player endon(#"entityshutdown");
    var_82267cf6 = 1413.46;
    var_370979c5 = 4300.81;
    half_height = 32.2476;
    var_ce3acb38 = -238.873;
    var_4f40cb18 = 0.192157;
    var_ad258895 = 0.137255;
    var_ef192488 = 0.180392;
    var_e6f7f220 = 3.2984;
    var_ffae135d = 0.34902;
    var_e17a08c0 = 0.129412;
    var_9f866ccd = 0.219608;
    var_706cff38 = 0.954905;
    var_966f79a1 = 0.280395;
    var_bc71f40a = 0.0976461;
    var_14c07505 = 0;
    var_7b5a55b1 = 0;
    time = 0;
    var_d6eebf82 = 0.22;
    setclientvolumetricfog(var_82267cf6, var_370979c5, half_height, var_ce3acb38, var_4f40cb18, var_ad258895, var_ef192488, var_e6f7f220, var_ffae135d, var_e17a08c0, var_9f866ccd, var_706cff38, var_966f79a1, var_bc71f40a, var_14c07505, var_7b5a55b1, time, var_d6eebf82);
}

// Namespace namespace_36389e13
// Params 1, eflags: 0x1 linked
// Checksum 0x99218139, Offset: 0x2a98
// Size: 0x1f4
function function_2931cece(ent_player) {
    if (isdefined(level.var_abc92c08) && (!isdefined(ent_player) || level.var_abc92c08)) {
        return;
    }
    ent_player endon(#"entityshutdown");
    var_82267cf6 = 1662.13;
    var_370979c5 = 18604.1;
    half_height = 2618.86;
    var_ce3acb38 = -5373.56;
    var_4f40cb18 = 0.764706;
    var_ad258895 = 0.505882;
    var_ef192488 = 0.231373;
    var_e6f7f220 = 5;
    var_ffae135d = 0.8;
    var_e17a08c0 = 0.435294;
    var_9f866ccd = 0.101961;
    var_706cff38 = 0.796421;
    var_966f79a1 = 0.425854;
    var_bc71f40a = 0.429374;
    var_14c07505 = 0;
    var_7b5a55b1 = 45.87;
    time = 0;
    var_d6eebf82 = 0.72;
    setclientvolumetricfog(var_82267cf6, var_370979c5, half_height, var_ce3acb38, var_4f40cb18, var_ad258895, var_ef192488, var_e6f7f220, var_ffae135d, var_e17a08c0, var_9f866ccd, var_706cff38, var_966f79a1, var_bc71f40a, var_14c07505, var_7b5a55b1, time, var_d6eebf82);
}

