#using scripts/shared/vehicleriders_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom_gadget_firefly;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/gametypes/coop;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_hazard;
#using scripts/cp/_dialog;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_79e1cd97;

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x4616a35f, Offset: 0xfa0
// Size: 0xbc
function function_bff1a867(str_objective) {
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_2fd26037 colors::set_force_color("b");
    level.var_2fd26037 setthreatbiasgroup("heroes");
    skipto::teleport_ai(str_objective, level.var_2fd26037);
    level.var_2fd26037 setgoal(level.var_2fd26037.origin, 1);
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x728c8ab0, Offset: 0x1068
// Size: 0x6c
function function_da579a5d(str_objective) {
    level.var_3d556bcd = util::function_740f8516("kane");
    level.var_3d556bcd setthreatbiasgroup("heroes");
    skipto::teleport_ai(str_objective, level.var_3d556bcd);
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xb73c51a6, Offset: 0x10e0
// Size: 0x80
function function_913d882() {
    self notify(#"hash_1fffa65c");
    self endon(#"death");
    self endon(#"hash_1fffa65c");
    while (true) {
        if (self isplayerunderwater() && !(isdefined(self.var_5ea9c8b7) && self.var_5ea9c8b7)) {
            self thread function_41018429();
        }
        wait 0.5;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x16b4ea7e, Offset: 0x1168
// Size: 0x150
function function_41018429() {
    self notify(#"hash_8f1abd30");
    self endon(#"hash_8f1abd30");
    self endon(#"death");
    self.var_5ea9c8b7 = 1;
    self hazard::function_459e5eff("o2", 0);
    var_dd075cd2 = 1;
    e_volume = getent("subway_water", "targetname");
    if (isdefined(e_volume) && self istouching(e_volume)) {
        self thread function_c6b38f1e();
    }
    while (self isplayerunderwater()) {
        wait 1;
        var_dd075cd2 = self hazard::do_damage("o2", 5);
    }
    self hazard::function_459e5eff("o2", 1);
    self.var_5ea9c8b7 = 0;
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xc58013bf, Offset: 0x12c0
// Size: 0x74
function function_c6b38f1e() {
    self endon(#"death");
    self clientfield::set_to_player("subway_water", 1);
    while (self isplayerunderwater()) {
        wait 0.05;
    }
    self clientfield::set_to_player("subway_water", 0);
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x1d47e33c, Offset: 0x1340
// Size: 0x1c
function function_8f7c9f3c() {
    self function_151e32b9(0);
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xb0124863, Offset: 0x1368
// Size: 0x170
function function_2c33b48e() {
    self notify(#"hash_bdc2988");
    self endon(#"death");
    self endon(#"hash_bdc2988");
    self.var_eb7c5a24 = 0;
    self.var_f82cc610 = 0;
    while (true) {
        level flag::wait_till("objective_igc_completed");
        if ((self.var_ff9883fd || self util::use_button_held() && self.var_3f081af5) && !self.var_eb7c5a24) {
            self function_151e32b9(1);
            while (util::use_button_held()) {
                wait 0.05;
            }
            while (!self usebuttonpressed() && !self jumpbuttonpressed() && !self sprintbuttonpressed() && self.var_eb7c5a24) {
                wait 0.05;
            }
            if (self.var_eb7c5a24) {
                self function_151e32b9(0);
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x57ee40dd, Offset: 0x14e0
// Size: 0x2c
function function_ed7faf05() {
    self notify(#"hash_bdc2988");
    self function_151e32b9(0);
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xe6b6bf3f, Offset: 0x1518
// Size: 0x40c
function function_151e32b9(var_6ffe741b) {
    if (isdefined(self.var_eb7c5a24) && self.var_eb7c5a24 && !var_6ffe741b) {
        if (isdefined(self.var_b1a4293e)) {
            self.var_b1a4293e delete();
        }
        self allowstand(1);
        self allowprone(1);
        self allowsprint(1);
        self setstance("stand");
        if (isdefined(self getluimenu("AnchorDeployed"))) {
            self closeluimenu(self getluimenu("AnchorDeployed"));
        }
        self.var_eb7c5a24 = 0;
        level notify(#"enable_cybercom", self, 1);
        self util::hide_hint_text();
        self notify(#"hash_af6705ff");
        return;
    }
    if (var_6ffe741b) {
        if (!self iswallrunning() && !(isdefined(self.laststand) && self.laststand) && !self isplayerunderwater() && !self ismantling()) {
            level notify(#"disable_cybercom", self, 1);
            if (!self isonground()) {
                self.var_b1a4293e = spawn("script_origin", self.origin);
                self playerlinkto(self.var_b1a4293e);
                v_ground = groundpos_ignore_water(self.origin);
                n_speed = distance(v_ground, self.origin) * 0.002;
                self.var_b1a4293e moveto(v_ground, n_speed);
                self.var_b1a4293e waittill(#"movedone");
                self unlink();
                self.var_b1a4293e delete();
            }
            if (!(isdefined(self.is_reviving_any) && self.is_reviving_any)) {
                self thread scene::play("cin_gen_ground_anchor_player", self);
                self waittill(#"hash_97a4dd11");
            }
            self.var_eb7c5a24 = 1;
            self allowstand(0);
            self allowprone(0);
            self allowsprint(0);
            self.var_b1a4293e = spawn("script_origin", self.origin);
            if (!isdefined(self getluimenu("AnchorDeployed"))) {
                self openluimenu("AnchorDeployed");
            }
            self thread function_a81e2f8f();
            self thread function_c87bc7e2();
        }
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xe4ae1060, Offset: 0x1930
// Size: 0x44
function function_c87bc7e2() {
    self endon(#"death");
    self endon(#"hash_af6705ff");
    wait 20;
    if (self.var_eb7c5a24) {
        self function_151e32b9(0);
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x8e808815, Offset: 0x1980
// Size: 0x20c
function function_a81e2f8f() {
    self endon(#"death");
    while (self.var_ff9883fd || isdefined(self.var_b1a4293e) && self.var_3f081af5) {
        var_3b8c7376 = distance2dsquared(self.origin, self.var_b1a4293e.origin);
        if (var_3b8c7376 > 3600 && var_3b8c7376 < 10000) {
            if (!self.var_62269fcc) {
                self.var_62269fcc = 1;
                self util::show_hint_text(%CP_MI_SING_BLACKSTATION_ANCHOR_WARNRANGE, 1);
            }
        } else if (var_3b8c7376 > 10000 && var_3b8c7376 <= 22500) {
            if (!self.var_62269fcc) {
                self.var_62269fcc = 1;
                self util::show_hint_text(%CP_MI_SING_BLACKSTATION_ANCHOR_OUTRANGE, 1);
            }
        } else if (var_3b8c7376 > 22500) {
            if (self.var_eb7c5a24) {
                self.var_62269fcc = 0;
                self function_151e32b9(0);
            }
        } else {
            self.var_62269fcc = 0;
            self util::hide_hint_text();
        }
        if (!isdefined(self.hint_menu_handle)) {
            self.var_62269fcc = 0;
        }
        util::wait_network_frame();
    }
    if (isdefined(self getluimenu("AnchorDeployed"))) {
        self closeluimenu(self getluimenu("AnchorDeployed"));
    }
    self util::hide_hint_text();
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xe168e6bb, Offset: 0x1b98
// Size: 0x8c
function function_12398a8b(a_ents) {
    self endon(#"death");
    var_b1a4293e = a_ents["spike"];
    self waittill(#"hash_97a4dd11");
    if (isdefined(var_b1a4293e)) {
        wait 0.1;
        while (isdefined(self.var_eb7c5a24) && self.var_eb7c5a24) {
            wait 0.1;
        }
        var_b1a4293e delete();
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xa0954e5f, Offset: 0x1c30
// Size: 0x11a
function function_3ceb3ad7() {
    foreach (player in level.activeplayers) {
        player util::show_hint_text(%CP_MI_SING_BLACKSTATION_USE_ANCHOR_FULL);
    }
    wait 4;
    foreach (player in level.activeplayers) {
        player util::show_hint_text(%CP_MI_SING_BLACKSTATION_ANCHOR_AREA);
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x99fb12d2, Offset: 0x1d58
// Size: 0x11a
function function_72b35612() {
    foreach (player in level.activeplayers) {
        if (!isdefined(player.var_22246212)) {
            player.var_22246212 = 0;
        }
        if (isdefined(player.var_f3d107c2) && player.var_f3d107c2) {
            if (player.var_22246212 < 2) {
                player.var_22246212++;
                player.var_f3d107c2 = 0;
                player util::show_hint_text(%CP_MI_SING_BLACKSTATION_USE_ANCHOR);
            }
        }
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xf4dae49f, Offset: 0x1e80
// Size: 0x74
function function_f2e7ba4b() {
    var_3be169e6 = getent("anchor_intro_wind", "targetname");
    var_3be169e6 trigger::wait_till();
    self thread function_61a28877(var_3be169e6);
    self thread function_3b881872(var_3be169e6);
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x14185e51, Offset: 0x1f00
// Size: 0x1ac
function function_61a28877(var_473cf959) {
    self notify(#"hash_afb0e5d8");
    self endon(#"hash_afb0e5d8");
    self endon(#"disconnect");
    var_473cf959 endon(#"death");
    self.var_ff9883fd = 0;
    while (!level flag::get("breached")) {
        while (self istouching(var_473cf959)) {
            self.var_ff9883fd = 1;
            self allowsprint(0);
            if (!(isdefined(var_473cf959.var_d956869f) && var_473cf959.var_d956869f)) {
                self setmovespeedscale(0.7);
                if (self.var_eb7c5a24) {
                    self playrumbleonentity("bs_wind_rumble_low");
                } else {
                    self playrumbleonentity("bs_wind_rumble");
                }
            } else {
                self setmovespeedscale(0.5);
            }
            wait 0.05;
        }
        self allowsprint(1);
        self setmovespeedscale(1);
        self.var_ff9883fd = 0;
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x11d843d5, Offset: 0x20b8
// Size: 0x178
function function_3b881872(var_473cf959) {
    self notify(#"hash_27db3d49");
    self endon(#"hash_27db3d49");
    self endon(#"disconnect");
    var_473cf959 endon(#"death");
    self.var_1ecf7ddf = 0;
    while (!level flag::get("breached")) {
        while (self istouching(var_473cf959)) {
            if (!(isdefined(var_473cf959.var_f6362118) && var_473cf959.var_f6362118)) {
                if (self.var_1ecf7ddf != 1) {
                    self.var_1ecf7ddf = 1;
                    self clientfield::set_to_player("sndWindSystem", 1);
                }
            } else if (self.var_1ecf7ddf != 2) {
                self.var_1ecf7ddf = 2;
                self clientfield::set_to_player("sndWindSystem", 2);
            }
            wait 0.05;
        }
        if (self.var_1ecf7ddf != 0) {
            self.var_1ecf7ddf = 0;
            self clientfield::set_to_player("sndWindSystem", 0);
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x2e3f40b5, Offset: 0x2238
// Size: 0x348
function function_3c6fc4cb() {
    self endon(#"death");
    while (true) {
        level flag::wait_till("allow_wind_gust");
        level exploder::exploder("fx_expl_debris_high_winds");
        level thread function_e56ec11d(self);
        n_time = randomfloatrange(3, 4);
        foreach (player in level.activeplayers) {
            if (isdefined(player.var_ff9883fd) && player.var_ff9883fd) {
                if (!isdefined(player.var_ce01d699)) {
                    player.var_ce01d699 = 0;
                }
                if (!player.var_ce01d699) {
                    player.var_ce01d699 = 1;
                    player util::show_hint_text(%CP_MI_SING_BLACKSTATION_USE_ANCHOR);
                }
                player thread function_4d386bf("WeatherWarning", "kill_weather");
                player thread function_c86ecb59(n_time);
            }
        }
        wait n_time;
        level exploder::stop_exploder("fx_expl_debris_high_winds");
        level flag::set("kill_weather");
        self.var_d956869f = 0;
        self.var_f6362118 = 0;
        level thread function_72b35612();
        foreach (player in level.activeplayers) {
            if (isdefined(player.var_ff9883fd) && player.var_eb7c5a24 && player.var_ff9883fd) {
                player function_151e32b9(0);
            }
        }
        n_timeout = randomfloatrange(5.5, 8.5);
        level flag::wait_till_clear_timeout(n_timeout, "allow_wind_gust");
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x44de1c7c, Offset: 0x2588
// Size: 0x64
function function_c86ecb59(n_time) {
    self endon(#"death");
    wait 1;
    self clientfield::set_to_player("wind_blur", 1);
    wait n_time;
    self clientfield::set_to_player("wind_blur", 0);
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x4dbf65a9, Offset: 0x25f8
// Size: 0x388
function function_e56ec11d(var_473cf959) {
    level flag::clear("kill_weather");
    level endon(#"kill_weather");
    var_473cf959 endon(#"death");
    var_73e585a1 = struct::get(var_473cf959.target);
    level notify(#"hash_5dd3aa3a");
    var_473cf959.var_f6362118 = 1;
    util::waittill_notify_or_timeout("end_gust_warning", 1);
    while (true) {
        foreach (player in level.players) {
            if (player istouching(var_473cf959)) {
                if (!isdefined(player getluimenu("WeatherWarning"))) {
                    player thread function_4d386bf("WeatherWarning", "kill_weather");
                }
                v_dir = anglestoforward((0, var_73e585a1.angles[1], 0));
                n_push_strength = -6;
                var_473cf959.var_d956869f = 1;
                if (!player.var_4cfe7265 && !(isdefined(player.laststand) && player.laststand)) {
                    if (!player.var_eb7c5a24) {
                        player setvelocity(v_dir * n_push_strength);
                        player.var_f3d107c2 = 1;
                    } else if (isdefined(player.var_b1a4293e)) {
                        var_3b8c7376 = distance2dsquared(player.origin, player.var_b1a4293e.origin);
                        if (distance2dsquared(player.origin, player.var_b1a4293e.origin) > 10000) {
                            player setvelocity(v_dir * n_push_strength);
                        }
                    }
                }
                if (player.var_eb7c5a24) {
                    player playrumbleonentity("bs_gust_rumble_low");
                    continue;
                }
                player playrumbleonentity("bs_gust_rumble");
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x27cb4021, Offset: 0x2988
// Size: 0x186
function function_3a563d3() {
    level endon(#"anchor_intro_done");
    var_5abaf1e2 = struct::get("debris_junk_fling");
    s_move = struct::get("debris_junk_move");
    level thread function_f9ecd375();
    while (true) {
        level waittill(#"hash_5dd3aa3a");
        wait 1.5;
        foreach (player in level.activeplayers) {
            e_debris = spawn("script_model", var_5abaf1e2.origin);
            e_debris function_e82b5091();
            e_debris setplayercollision(0);
            if (isdefined(player)) {
                player function_ec10a9e7(e_debris);
            }
        }
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x54a49335, Offset: 0x2b18
// Size: 0x12a
function function_f9ecd375() {
    trigger::wait_till("trigger_hendricks_anchor_done");
    level thread scene::play("p7_fxanim_cp_blackstation_boatroom_bundle");
    wait 2.5;
    var_c6dce143 = struct::get("objective_port_assault_ai");
    foreach (player in level.activeplayers) {
        if (distance2dsquared(player.origin, var_c6dce143.origin) <= 640000) {
            player playrumbleonentity("cp_blackstation_shelter_rumble");
        }
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x45331e04, Offset: 0x2c50
// Size: 0x40
function function_e7bf1516() {
    level endon(#"anchor_intro_done");
    while (true) {
        level waittill(#"hash_5dd3aa3a");
        level thread function_59c54810();
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xc0cdf85e, Offset: 0x2c98
// Size: 0x1d6
function function_59c54810() {
    var_a35aa0b0 = struct::get_array("debris_random_start");
    var_64dd962c = array("p7_debris_junkyard_scrap_pile_01", "p7_debris_junkyard_scrap_pile_02", "p7_debris_junkyard_scrap_pile_03", "p7_debris_concrete_rubble_lg_03", "p7_debris_metal_scrap_01", "p7_debris_ibeam_dmg", "p7_sin_wall_metal_slats", "p7_toilet_bathroom_open");
    for (i = 0; i < randomintrange(10, 16); i++) {
        e_debris = spawn("script_model", var_a35aa0b0[randomint(var_a35aa0b0.size)].origin);
        e_debris setmodel(var_64dd962c[randomint(var_64dd962c.size)]);
        if (randomint(2) == 0) {
            e_debris playloopsound("evt_debris_rando_looper");
        } else {
            e_debris playloopsound("evt_debris_metal_looper");
        }
        wait randomfloatrange(0.1, 0.5);
        e_debris thread function_95e08db9();
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x915d73aa, Offset: 0x2e78
// Size: 0x404
function function_cb28102c() {
    var_baae3b1d = getentarray("debris_stage_1", "targetname");
    foreach (var_4804abd in var_baae3b1d) {
        var_4804abd thread function_8efe7a7();
    }
    trigger::wait_till("trigger_stage_1");
    foreach (var_4804abd in var_baae3b1d) {
        var_4804abd thread function_88a9ee8a();
        var_4804abd thread function_f5cdc056();
        var_4804abd thread function_2d329cdb();
    }
    var_d68e5742 = getent("debris_fridge", "targetname");
    var_e0b0b586 = getentarray("debris_stage_2", "targetname");
    arrayinsert(var_e0b0b586, var_d68e5742, 0);
    foreach (var_2a82c526 in var_e0b0b586) {
        var_2a82c526 thread function_8efe7a7();
    }
    trigger::wait_till("trigger_stage_2");
    level waittill(#"hash_5dd3aa3a");
    wait 1.7;
    foreach (var_2a82c526 in var_e0b0b586) {
        var_2a82c526 thread function_88a9ee8a();
        var_2a82c526 thread function_f5cdc056();
        var_2a82c526 thread function_2d329cdb();
    }
    var_6b05f5fd = getent("debris_tree", "targetname");
    var_6b05f5fd thread function_8efe7a7();
    trigger::wait_till("trigger_stage_3");
    level waittill(#"hash_5dd3aa3a");
    wait 1.7;
    var_6b05f5fd thread function_88a9ee8a();
    var_6b05f5fd thread function_f5cdc056();
    var_6b05f5fd thread function_2d329cdb();
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x5a3c07f2, Offset: 0x3288
// Size: 0xc4
function function_8efe7a7() {
    self endon(#"death");
    self endon(#"launch");
    while (true) {
        self movey(1, 0.05);
        self rotatepitch(1, 0.05);
        self waittill(#"movedone");
        self movey(-1, 0.05);
        self rotatepitch(-1, 0.05);
        self waittill(#"movedone");
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x89438986, Offset: 0x3358
// Size: 0x9c
function function_88a9ee8a() {
    self notify(#"launch");
    self moveto(self.origin + (0, 200, 0), 0.5);
    self waittill(#"movedone");
    self moveto(self.origin + (0, 6000, 1200), 8);
    self waittill(#"movedone");
    self delete();
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x2b206069, Offset: 0x3400
// Size: 0xbc
function function_95e08db9() {
    self movez(-16, 0.1);
    self waittill(#"movedone");
    self thread function_f5cdc056();
    self thread function_2d329cdb();
    self moveto(self.origin + (0, 6000, randomintrange(20, 60)), 4);
    self waittill(#"movedone");
    self delete();
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x31f65012, Offset: 0x34c8
// Size: 0xf4
function function_ec10a9e7(e_debris) {
    self endon(#"disconnect");
    e_debris thread function_f5cdc056();
    e_debris thread function_2d329cdb();
    e_debris movez(-16, 0.1);
    e_debris waittill(#"movedone");
    e_debris moveto(self.origin + (randomint(100), 1000, randomintrange(80, 100)), 3);
    e_debris waittill(#"movedone");
    e_debris delete();
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x798681d3, Offset: 0x35c8
// Size: 0x40
function function_f5cdc056() {
    self endon(#"death");
    while (true) {
        self rotateroll(-90, 0.3);
        wait 0.25;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x48f1ae58, Offset: 0x3610
// Size: 0x1dc
function function_e82b5091() {
    n_rand = randomint(7);
    switch (n_rand) {
    case 0:
        var_ac791ba4 = "p7_bucket_plastic_5_gal_blue";
        self playloopsound("evt_debris_rando_looper");
        break;
    case 1:
        var_ac791ba4 = "p7_sin_wall_metal_slats";
        self playloopsound("evt_debris_metal_looper");
        break;
    case 2:
        var_ac791ba4 = "p7_debris_metal_scrap_01";
        self playloopsound("evt_debris_metal_looper");
        break;
    case 3:
        var_ac791ba4 = "p7_water_container_plastic_large_distressed";
        self playloopsound("evt_debris_metal_special_looper");
        break;
    case 4:
        var_ac791ba4 = "p7_light_spotlight_generator_02";
        self playloopsound("evt_debris_metal_special_looper");
        break;
    case 5:
        var_ac791ba4 = "p7_foliage_treetrunk_fallen_01";
        self playloopsound("evt_debris_tree_looper");
        break;
    case 6:
        var_ac791ba4 = "p7_debris_drywall_chunks_corner_01";
        self playloopsound("evt_debris_rando_looper");
        break;
    }
    self setmodel(var_ac791ba4);
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x0
// Checksum 0xf4f55334, Offset: 0x37f8
// Size: 0x68
function function_378fdd41() {
    self endon(#"death");
    while (true) {
        self movez(3, 0.1);
        wait 0.05;
        self movez(-3, 0.1);
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x339296d4, Offset: 0x3868
// Size: 0x174
function function_2d329cdb() {
    self endon(#"death");
    self endon(#"hash_313ebe7a");
    n_hit_dist_sq = 1600;
    while (true) {
        foreach (player in level.players) {
            if (distancesquared(self.origin, player getcentroid()) < n_hit_dist_sq) {
                player dodamage(player.health / 8, self.origin, undefined, undefined, undefined, "MOD_FALLING");
                player shellshock("default", 1.5);
                player playrumbleonentity("artillery_rumble");
                break;
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xb0a85948, Offset: 0x39e8
// Size: 0x44
function groundpos_ignore_water(origin) {
    return groundtrace(origin, origin + (0, 0, -100000), 0, undefined, 1)["position"];
}

// Namespace namespace_79e1cd97
// Params 3, eflags: 0x1 linked
// Checksum 0x455e228a, Offset: 0x3a38
// Size: 0xfa
function function_4d386bf(str_menu, str_flag, str_notify) {
    self endon(#"death");
    if (!isdefined(self getluimenu(str_menu))) {
        warning = self openluimenu(str_menu);
        self thread function_c4626d1d();
    }
    if (isdefined(str_notify)) {
        self util::waittill_any_timeout(3, str_notify);
    } else {
        util::waittill_any_ents(level, str_flag, self, "player_bleedout");
    }
    if (isdefined(warning)) {
        self closeluimenu(warning);
        self notify(#"hash_72181299");
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xdc3530c3, Offset: 0x3b40
// Size: 0x48
function function_c4626d1d() {
    self endon(#"death");
    self endon(#"hash_72181299");
    while (true) {
        self playlocalsound("uin_weather_warning");
        wait 0.25;
    }
}

// Namespace namespace_79e1cd97
// Params 3, eflags: 0x1 linked
// Checksum 0xc700d002, Offset: 0x3b90
// Size: 0x136
function function_43367596(str_warning, str_flag, str_endon) {
    self thread function_cdf3d127();
    while (true) {
        level waittill(str_warning);
        if (level.var_2fd26037 istouching(self) && !level.var_2fd26037.var_f005c227) {
            level.var_2fd26037 scene::play("cin_gen_ground_anchor_start", level.var_2fd26037);
            level.var_2fd26037 thread scene::play("cin_gen_ground_anchor_idle", level.var_2fd26037);
            wait 0.5;
            level flag::wait_till(str_flag);
            level.var_2fd26037 scene::play("cin_gen_ground_anchor_end", level.var_2fd26037);
        }
        if (level flag::get(str_endon)) {
            break;
        }
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xbb24d594, Offset: 0x3cd0
// Size: 0xc0
function function_cdf3d127() {
    level endon(#"hash_4561e3f");
    var_e63023e3 = getent(self.targetname + "_hero_safety", "script_noteworthy");
    if (!isdefined(var_e63023e3)) {
        return;
    }
    while (true) {
        while (level.var_2fd26037 istouching(var_e63023e3)) {
            level.var_2fd26037.var_f005c227 = 1;
            wait 0.05;
        }
        level.var_2fd26037.var_f005c227 = 0;
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x16104e96, Offset: 0x3d98
// Size: 0x6c
function function_d3e22b53(var_473cf959) {
    var_473cf959 thread function_98fd2a69();
    var_473cf959 thread function_43367596("surge_warning", "kill_surge", "surge_done");
    var_473cf959 thread function_e7121462();
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x0
// Checksum 0x1a6c16f8, Offset: 0x3e10
// Size: 0xb6
function function_4a8c1765(a_triggers) {
    var_bec72e2a = 0;
    foreach (trigger in a_triggers) {
        if (self istouching(trigger)) {
            var_bec72e2a = 1;
        }
    }
    return var_bec72e2a;
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xb8b3ee86, Offset: 0x3ed0
// Size: 0xa8
function function_98fd2a69() {
    self endon(#"death");
    while (true) {
        level flag::set("surging_inward");
        level thread function_252086f2(self);
        wait 1.5;
        level flag::wait_till_clear("surging_inward");
        self.var_f52921cf = 0;
        wait randomfloatrange(5.5, 6.5);
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x0
// Checksum 0xd5bd8611, Offset: 0x3f80
// Size: 0x2c
function function_b0c5c886() {
    level endon(#"tanker_smash");
    level clientfield::set("water_level", 1);
}

// Namespace namespace_79e1cd97
// Params 3, eflags: 0x1 linked
// Checksum 0x5f67fa4d, Offset: 0x3fb8
// Size: 0x148
function function_3c57957(var_8b856a66, var_64dd962c, str_endon) {
    var_e7610d59 = "p7_fxanim_cp_blackstation_" + var_8b856a66.script_string + "_bundle";
    level scene::add_scene_func(var_e7610d59, &function_8fbe0681, "play", str_endon, var_64dd962c, var_8b856a66);
    if (isdefined(var_64dd962c)) {
        array::thread_all(var_64dd962c, &function_c1eab89b, var_8b856a66);
    }
    level flag::wait_till("surging_inward");
    while (!level flag::get(str_endon)) {
        level scene::play(var_8b856a66.targetname);
        var_8b856a66 notify(#"hash_856e667");
        level flag::wait_till_clear("surging_inward");
    }
}

// Namespace namespace_79e1cd97
// Params 4, eflags: 0x1 linked
// Checksum 0xf3d4f7c5, Offset: 0x4108
// Size: 0x34c
function function_8fbe0681(a_ents, str_endon, var_64dd962c, var_8b856a66) {
    var_e7610d59 = var_8b856a66.script_string;
    var_32cdba86 = a_ents[var_e7610d59];
    e_debris = a_ents[var_e7610d59 + "_debris"];
    e_debris thread function_1168d325(var_8b856a66);
    var_29f7937 = "wave_trigger_jnt";
    var_8b856a66 enablelinkto();
    var_8b856a66.origin = var_32cdba86 gettagorigin(var_29f7937);
    var_8b856a66 linkto(var_32cdba86, var_29f7937, (0, 120, -35), (0, -90, 0));
    level flag::set("surge_active");
    foreach (player in level.players) {
        var_8b856a66 thread function_32d3b286(player);
        var_8b856a66 thread surge_warning(player);
    }
    var_8b856a66 thread function_c1972ac();
    var_8b856a66 thread function_9ea9bed();
    wait 0.05;
    var_32cdba86 clientfield::set("water_disturbance", 1);
    var_8b856a66 waittill(#"hash_856e667");
    var_32cdba86 notify(self.scriptbundlename);
    level notify(var_8b856a66.script_noteworthy);
    level flag::set("end_surge");
    if (self.scriptbundlename == "p7_fxanim_cp_blackstation_wave_01_bundle") {
        level flag::set("cover_switch");
    }
    level flag::clear("surging_inward");
    level flag::clear("surge_active");
    level flag::clear("end_surge");
    var_32cdba86 stopanimscripted();
    var_32cdba86 clientfield::set("water_disturbance", 0);
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x10c75d10, Offset: 0x4460
// Size: 0x10e
function function_1168d325(var_8b856a66) {
    var_b7926b3a = var_8b856a66.script_float;
    for (x = 1; x <= var_b7926b3a; x++) {
        if (x < 10) {
            var_fe8d5ebb = "debris_0" + x + "_jnt";
        } else {
            var_fe8d5ebb = "debris_" + x + "_jnt";
        }
        n_chance = randomintrange(0, 100);
        if (n_chance > 33) {
            self hidepart(var_fe8d5ebb);
            continue;
        }
        self showpart(var_fe8d5ebb);
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x89214913, Offset: 0x4578
// Size: 0x134
function surge_warning(player) {
    self endon(#"death");
    self endon(#"hash_4735ec09");
    level endon(#"end_surge");
    player endon(#"death");
    while (distance2dsquared(self.origin, player.origin) > 490000) {
        wait 0.1;
    }
    if (player.var_f82cc610 && !isdefined(player getluimenu("SurgeWarning"))) {
        player thread function_8b5bccf1("SurgeWarning");
        return;
    }
    while (!player.var_f82cc610) {
        wait 0.05;
    }
    if (!isdefined(player getluimenu("SurgeWarning"))) {
        player thread function_8b5bccf1("SurgeWarning");
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x92834c95, Offset: 0x46b8
// Size: 0x84
function function_8b5bccf1(str_menu) {
    if (!isdefined(self.var_25f6f033)) {
        self.var_25f6f033 = 0;
    }
    if (!self.var_25f6f033) {
        self.var_25f6f033 = 1;
        self util::show_hint_text(%CP_MI_SING_BLACKSTATION_USE_ANCHOR);
    }
    self thread function_4d386bf(str_menu, "end_surge", "stop_surge");
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x86a8083c, Offset: 0x4748
// Size: 0xc8
function function_9ea9bed() {
    self endon(#"death");
    level endon(self.script_noteworthy);
    while (true) {
        var_480743 = self waittill(#"trigger");
        if (isdefined(var_480743.var_284432c3) && isalive(var_480743) && var_480743.team == "axis" && !var_480743.var_284432c3) {
            var_480743.var_284432c3 = 1;
            var_480743 thread function_3de3b792(self);
        }
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xbc5f4efe, Offset: 0x4818
// Size: 0x94
function function_3de3b792(var_12377408) {
    self endon(#"death");
    v_dir = vectornormalize(self.origin - var_12377408.origin);
    self startragdoll();
    self launchragdoll(v_dir * 75);
    self kill();
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xb63aeb28, Offset: 0x48b8
// Size: 0x31c
function function_c1eab89b(var_12377408) {
    self endon(#"death");
    var_12377408 endon(#"death");
    var_b097e0fd = 0.012;
    n_offset = -76;
    if (isdefined(self.target)) {
        while (!self istouching(var_12377408)) {
            wait 0.1;
        }
        s_goal = struct::get(self.target);
        n_speed = distance(s_goal.origin, self.origin) * var_b097e0fd;
        self clientfield::increment("water_splash_lrg");
        self playsound("evt_surge_impact_debris");
        self moveto(s_goal.origin, n_speed);
        self rotateto(s_goal.angles, n_speed);
        self waittill(#"movedone");
        level flag::wait_till_clear("surging_inward");
        while (isdefined(s_goal.target)) {
            s_goal = struct::get(s_goal.target);
            level flag::wait_till("surging_inward");
            while (!self istouching(var_12377408)) {
                wait 0.1;
            }
            n_speed = distance(s_goal.origin, self.origin) * var_b097e0fd;
            self clientfield::increment("water_splash_lrg");
            self moveto(s_goal.origin, n_speed);
            self rotateto(s_goal.angles, n_speed);
            self waittill(#"movedone");
            if (isdefined(s_goal.target)) {
                level flag::wait_till_clear("surging_inward");
            }
        }
    }
    self thread function_d1bc8584();
    self thread function_43990014(var_12377408);
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x18cc671f, Offset: 0x4be0
// Size: 0xb8
function function_43990014(var_12377408) {
    self endon(#"death");
    var_12377408 endon(#"death");
    while (true) {
        level flag::wait_till("surging_inward");
        while (!self istouching(var_12377408)) {
            wait 0.1;
        }
        self clientfield::increment("water_splash_lrg");
        level flag::wait_till_clear("surging_inward");
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x78dd5729, Offset: 0x4ca0
// Size: 0x5c
function function_d1bc8584() {
    self endon(#"death");
    if (isdefined(self.script_int)) {
        str_scene = "p7_fxanim_cp_blackstation_cars_rocking_0" + self.script_int + "_bundle";
        level thread scene::play(str_scene);
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x2ba9fe1c, Offset: 0x4d08
// Size: 0x2c
function function_98c7a42() {
    if (isdefined(self.modelscale)) {
        self setscale(self.modelscale);
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xcd9ace91, Offset: 0x4d40
// Size: 0x8c
function function_c1972ac() {
    self endon(#"death");
    level endon(self.script_noteworthy);
    level endon(#"tanker_ride_done");
    while (true) {
        while (distance2dsquared(self.origin, level.var_2fd26037.origin) > 722500) {
            wait 0.05;
        }
        self thread function_2403047c();
        break;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x87cb8a7c, Offset: 0x4dd8
// Size: 0x8c
function function_2403047c() {
    level endon(#"tanker_ride_done");
    level flag::clear("kill_surge");
    level notify(#"surge_warning");
    while (isdefined(self) && level.var_2fd26037 istouching(self)) {
        wait 0.05;
    }
    level flag::set("kill_surge");
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xb51d6c1a, Offset: 0x4e70
// Size: 0x11c
function function_32d3b286(player) {
    self endon(#"death");
    self endon(#"hash_4735ec09");
    level endon(self.script_noteworthy);
    player endon(#"death");
    while (true) {
        var_4a36ffac = self waittill(#"trigger");
        if (var_4a36ffac == player && !player.var_1cd4d4e6) {
            player.var_1cd4d4e6 = 1;
            player thread function_b8c35195(self);
            player thread function_c61ca0be(self);
            player thread function_adade905(self);
            player thread function_6b6e7b58(self);
            player playsound("evt_surge_impact");
            break;
        }
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xf4ad21e9, Offset: 0x4f98
// Size: 0x74
function function_6b6e7b58(var_12377408) {
    self endon(#"death");
    while (self istouching(var_12377408)) {
        util::wait_network_frame();
    }
    wait 0.5;
    if (self.var_eb7c5a24) {
        self function_151e32b9(0);
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x651b15e1, Offset: 0x5018
// Size: 0xe4
function function_b8c35195(var_12377408) {
    self endon(#"death");
    self clientfield::set_to_player("wave_hit", 1);
    self clientfield::set_to_player("wind_blur", 1);
    while (isdefined(var_12377408) && self istouching(var_12377408)) {
        wait 0.05;
    }
    self.var_1cd4d4e6 = 0;
    if (isdefined(var_12377408)) {
        var_12377408 notify(#"hash_4735ec09");
    }
    self clientfield::set_to_player("wave_hit", 0);
    self clientfield::set_to_player("wind_blur", 0);
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x2e8d057d, Offset: 0x5108
// Size: 0x98
function function_adade905(var_59ed1f41) {
    level endon(#"end_surge");
    self endon(#"death");
    self endon(#"stop_surge");
    var_59ed1f41 endon(#"hash_4735ec09");
    earthquake(0.5, 2, self.origin, 100);
    while (true) {
        self playrumbleonentity("damage_heavy");
        wait 0.1;
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x20e33826, Offset: 0x51a8
// Size: 0x19c
function function_c61ca0be(var_59ed1f41) {
    level endon(#"end_surge");
    self endon(#"death");
    self endon(#"stop_surge");
    var_59ed1f41 endon(#"hash_4735ec09");
    n_push_strength = -56;
    v_dir = anglestoforward((0, 90, 0));
    while (true) {
        if (!self.var_4cfe7265 && !self.var_eb7c5a24 && !(isdefined(self.laststand) && self.laststand)) {
            self setvelocity(v_dir * n_push_strength);
        } else if (isdefined(self.var_b1a4293e)) {
            var_3b8c7376 = distance2dsquared(self.origin, self.var_b1a4293e.origin);
            if (distance2dsquared(self.origin, self.var_b1a4293e.origin) > 10000) {
                self setvelocity(v_dir * n_push_strength);
            }
        }
        if (!self.var_f82cc610) {
            self notify(#"stop_surge");
            self util::hide_hint_text();
            break;
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x3110f39c, Offset: 0x5350
// Size: 0xf8
function function_252086f2(var_473cf959) {
    level endon(#"end_surge");
    var_473cf959 endon(#"death");
    while (true) {
        foreach (player in level.players) {
            if (player istouching(var_473cf959)) {
                player.var_f82cc610 = 1;
                var_473cf959.var_f52921cf = 1;
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x1641f503, Offset: 0x5450
// Size: 0x338
function function_55221935() {
    self notify(#"hash_8af17fe2");
    self endon(#"hash_8af17fe2");
    self endon(#"death");
    var_473cf959 = getent("port_assault_low_surge", "targetname");
    var_473cf959 endon(#"death");
    self.var_3f081af5 = 0;
    while (true) {
        while (self istouching(var_473cf959)) {
            self.var_3f081af5 = 1;
            self.var_f82cc610 = 1;
            self allowprone(0);
            self allowsprint(0);
            if (!(isdefined(var_473cf959.var_f52921cf) && var_473cf959.var_f52921cf)) {
                switch (var_473cf959.script_string) {
                case "high":
                    self setmovespeedscale(0.7);
                    break;
                default:
                    self setmovespeedscale(0.9);
                    break;
                }
            } else {
                switch (var_473cf959.script_string) {
                case "high":
                    self setmovespeedscale(0.5);
                    break;
                default:
                    self setmovespeedscale(0.7);
                    break;
                }
            }
            wait 0.05;
        }
        var_e59bb0e8 = getentarray(var_473cf959.script_noteworthy, "script_noteworthy");
        var_77bf815f = 0;
        foreach (trigger in var_e59bb0e8) {
            if (self istouching(trigger)) {
                var_77bf815f = 1;
            }
        }
        if (!var_77bf815f) {
            self setmovespeedscale(1);
            self allowprone(1);
            self allowsprint(1);
            self.var_3f081af5 = 0;
            self.var_f82cc610 = 0;
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x3f3f8f35, Offset: 0x5790
// Size: 0x88
function function_e7121462() {
    self endon(#"death");
    while (true) {
        while (level.var_2fd26037 istouching(self)) {
            level.var_2fd26037 asmsetanimationrate(0.9);
            wait 0.1;
        }
        level.var_2fd26037 asmsetanimationrate(1);
        wait 0.1;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x0
// Checksum 0xb90d3e42, Offset: 0x5820
// Size: 0x16a
function function_2a18b01f() {
    var_1c4b4b63 = getentarray("pier_wave_left", "script_noteworthy");
    var_d8a504d6 = getentarray("pier_wave_right", "script_noteworthy");
    var_f6a86bdd = arraycombine(var_1c4b4b63, var_d8a504d6, 0, 0);
    foreach (wave in var_f6a86bdd) {
        wave ghost();
        var_59ed1f41 = getent(wave.target, "targetname");
        var_59ed1f41 enablelinkto();
        var_59ed1f41 linkto(wave);
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x6247e897, Offset: 0x5998
// Size: 0xaa
function function_9ad97cf7() {
    level flag::wait_till("all_players_spawned");
    foreach (player in level.players) {
        player thread function_f99affa5();
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x15560a37, Offset: 0x5a50
// Size: 0x6e
function function_f99affa5() {
    var_8ad4cf96 = getentarray("trigger_pier_safe", "targetname");
    for (i = 0; i < var_8ad4cf96.size; i++) {
        self thread function_fab6808c();
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xa890e404, Offset: 0x5ac8
// Size: 0x80
function function_fab6808c() {
    self endon(#"death");
    while (true) {
        player = self waittill(#"trigger");
        if (isplayer(player)) {
            self.var_4cfe7265 = 1;
            player notify(#"hash_db60e15");
            self thread function_34e20912(player);
        }
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x71f16eda, Offset: 0x5b50
// Size: 0x60
function function_34e20912(player) {
    player endon(#"death");
    player endon(#"hash_db60e15");
    while (true) {
        if (!player istouching(self)) {
            self.var_4cfe7265 = 0;
            break;
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x0
// Checksum 0x2889cc0b, Offset: 0x5bb8
// Size: 0x5c
function wave_manager() {
    self endon(#"death");
    while (true) {
        wait randomfloatrange(3.5, 4.5);
        level thread function_cf51be1b(self);
        self.var_5963798b = 0;
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xc4d7a7be, Offset: 0x5c20
// Size: 0x498
function function_cf51be1b(var_473cf959) {
    level flag::clear("kill_wave");
    level endon(#"kill_wave");
    var_473cf959 endon(#"death");
    level notify(#"hash_9a604c47");
    wait 1;
    var_1c4b4b63 = getentarray("pier_wave_left", "script_noteworthy");
    var_d8a504d6 = getentarray("pier_wave_right", "script_noteworthy");
    var_f6a86bdd = arraycombine(var_1c4b4b63, var_d8a504d6, 0, 0);
    var_32cdba86 = var_f6a86bdd[randomintrange(0, var_f6a86bdd.size)];
    s_wave = struct::get(var_32cdba86.target, "targetname");
    var_59ed1f41 = getent(var_32cdba86.target, "targetname");
    var_32cdba86 playsound("evt_wave_dist");
    var_59ed1f41 playsound("evt_wave_splash");
    array::thread_all(getentarray("wave_fodder", "script_noteworthy"), &function_d2607594, var_59ed1f41, s_wave);
    foreach (player in level.players) {
        player thread function_486381ce(var_59ed1f41);
    }
    var_59ed1f41 thread function_e5633001();
    level thread function_2adb901e(var_32cdba86);
    while (true) {
        foreach (player in level.players) {
            if (player istouching(var_59ed1f41)) {
                if (!isdefined(player getluimenu("WaveWarning"))) {
                    player thread function_4d386bf("WaveWarning", "kill_wave");
                }
                v_dir = anglestoforward((0, s_wave.angles[1], 0));
                n_push_strength = -6;
                var_59ed1f41.var_5963798b = 1;
                if (!player.var_4cfe7265 && !player.var_eb7c5a24) {
                    player setvelocity(v_dir * n_push_strength);
                }
                if (player.var_eb7c5a24) {
                    player playrumbleonentity("bs_wave_anchored");
                    continue;
                }
                player playrumbleonentity("bs_wave");
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 2, eflags: 0x1 linked
// Checksum 0xf4af62af, Offset: 0x60c0
// Size: 0x108
function function_d2607594(var_59ed1f41, s_wave) {
    self endon(#"death");
    var_59ed1f41 endon(#"death");
    level endon(#"kill_wave");
    while (true) {
        if (self istouching(var_59ed1f41)) {
            v_dir = vectornormalize(self.origin - (s_wave.origin[0], self.origin[1], s_wave.origin[2]));
            self startragdoll();
            self launchragdoll(v_dir * 100);
            self kill();
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xcafa6539, Offset: 0x61d0
// Size: 0x28c
function function_2adb901e(var_32cdba86) {
    s_wave = struct::get(var_32cdba86.target, "targetname");
    var_32cdba86.var_59ed1f41 = getent(var_32cdba86.target, "targetname");
    var_32cdba86.origin = s_wave.origin;
    var_32cdba86.angles = s_wave.angles;
    if (var_32cdba86.script_noteworthy == "pier_wave_left") {
        n_dist = -450;
    } else {
        n_dist = 450;
    }
    var_32cdba86 moveto(var_32cdba86.origin + (0, 0, 150), 0.1);
    var_32cdba86 waittill(#"movedone");
    var_32cdba86 moveto(var_32cdba86.origin + (n_dist, 0, -106), 2.5);
    foreach (player in level.players) {
        var_32cdba86 thread function_bccf1e12(player);
    }
    var_32cdba86 thread function_4083c129();
    var_32cdba86 waittill(#"movedone");
    var_32cdba86 moveto(var_32cdba86.origin + (n_dist, 0, -150), 0.5);
    var_32cdba86 waittill(#"movedone");
    var_32cdba86 notify(#"hash_1144b7ed");
    level flag::set("kill_wave");
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x736af07f, Offset: 0x6468
// Size: 0xf0
function function_bccf1e12(player) {
    player endon(#"death");
    self endon(#"hash_1144b7ed");
    player.var_b7677aee = 0;
    while (true) {
        var_4a36ffac = self.var_59ed1f41 waittill(#"trigger");
        if (var_4a36ffac == player && !player.var_b7677aee) {
            var_cbf4698a = player.attackeraccuracy;
            player.attackeraccuracy = 0;
            player.var_b7677aee = 1;
            self waittill(#"movedone");
            player.attackeraccuracy = var_cbf4698a;
            player.var_b7677aee = 0;
        }
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xa755b7ca, Offset: 0x6560
// Size: 0x90
function function_486381ce(var_473cf959) {
    self endon(#"death");
    var_473cf959 endon(#"death");
    level endon(#"kill_weather");
    self.var_5963798b = 0;
    while (true) {
        while (self istouching(var_473cf959)) {
            self.var_5963798b = 1;
            wait 0.05;
        }
        self.var_5963798b = 0;
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xfadf8b6c, Offset: 0x65f8
// Size: 0xa0
function function_e5633001() {
    self endon(#"death");
    level endon(#"kill_weather");
    while (true) {
        var_480743 = self waittill(#"trigger");
        if (isalive(var_480743) && var_480743.team == "axis" && !isdefined(var_480743.var_284432c3)) {
            self function_9cf489b(var_480743);
        }
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x45fd0e5c, Offset: 0x66a0
// Size: 0x1bc
function function_9cf489b(var_480743) {
    self endon(#"death");
    var_480743 endon(#"death");
    var_480743.var_284432c3 = 1;
    var_201cd90f = var_480743.angles[1];
    if (var_201cd90f >= 0 && var_201cd90f <= -76) {
        if (self.script_noteworthy == "pier_wave_left_trigger") {
            var_94edb8e1 = -100;
            var_480743 thread scene::play("cin_bla_06_02_vign_wave_swept_left", var_480743);
        } else {
            var_94edb8e1 = 100;
            var_480743 thread scene::play("cin_bla_06_02_vign_wave_swept_right", var_480743);
        }
    } else if (self.script_noteworthy == "pier_wave_left_trigger") {
        var_94edb8e1 = -100;
        var_480743 thread scene::play("cin_bla_06_02_vign_wave_swept_right", var_480743);
    } else {
        var_94edb8e1 = 100;
        var_480743 thread scene::play("cin_bla_06_02_vign_wave_swept_left", var_480743);
    }
    var_480743 waittill(#"swept_away");
    var_480743 startragdoll();
    var_480743 launchragdoll((0, 100, 40));
    var_480743 kill();
}

// Namespace namespace_79e1cd97
// Params 3, eflags: 0x1 linked
// Checksum 0x84209868, Offset: 0x6868
// Size: 0x134
function function_d01267bd(var_2e939094, n_delay, str_endon) {
    if (!isdefined(var_2e939094)) {
        var_2e939094 = 1;
    }
    if (!isdefined(n_delay)) {
        n_delay = 1;
    }
    self endon(#"death");
    if (isdefined(str_endon)) {
        level endon(str_endon);
    }
    var_531b88b4 = 0;
    while (var_531b88b4 < var_2e939094) {
        var_dfb53de7 = self vehicle::function_ad4ec07a("gunner1");
        if (isalive(var_dfb53de7)) {
            var_dfb53de7 waittill(#"death");
        } else {
            var_dfb53de7 = function_392ca6eb(self);
            if (isalive(var_dfb53de7)) {
                var_dfb53de7 vehicle::get_in(self, "gunner1", 0);
                var_531b88b4++;
            }
        }
        wait n_delay;
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xb7b7d45e, Offset: 0x69a8
// Size: 0x70
function function_392ca6eb(var_45900c37) {
    a_ai_enemies = getaiarchetypearray("human", "axis");
    var_997800be = arraysortclosest(a_ai_enemies, var_45900c37.origin);
    return var_997800be[0];
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x49cbba78, Offset: 0x6a20
// Size: 0x7c
function function_fae23684(str_pos) {
    ai_rider = self vehicle::function_ad4ec07a(str_pos);
    if (isdefined(ai_rider)) {
        ai_rider vehicle::get_out();
        ai_rider util::stop_magic_bullet_shield();
        ai_rider.nocybercom = 0;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xd1d4e3d0, Offset: 0x6aa8
// Size: 0xa4
function function_c262adca() {
    self endon(#"death");
    while (!isdefined(self vehicle::function_ad4ec07a("driver"))) {
        wait 0.1;
    }
    var_44762fa4 = self vehicle::function_ad4ec07a("driver");
    if (isalive(var_44762fa4)) {
        var_44762fa4.nocybercom = 1;
        var_44762fa4 util::magic_bullet_shield();
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x8872340f, Offset: 0x6b58
// Size: 0xbc
function function_4083c129() {
    self.e_fx = util::spawn_model("tag_origin", self.origin);
    self.e_fx linkto(self);
    self.e_fx fx::play("wave_pier", self.e_fx.origin + (0, 0, -32), undefined, 2, 1);
    self waittill(#"movedone");
    if (isdefined(self.e_fx)) {
        self.e_fx delete();
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x42051a9b, Offset: 0x6c20
// Size: 0xc2
function function_90db9f9c() {
    a_corpses = getentarray("immortal_police_station_corpse", "targetname");
    foreach (var_fe80b161 in a_corpses) {
        var_fe80b161 thread scene::play(var_fe80b161.script_noteworthy, var_fe80b161);
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x79d5128c, Offset: 0x6cf0
// Size: 0x1b4
function function_6778ea09(var_d7636298) {
    switch (var_d7636298) {
    case "none":
        var_4d33888e = 0;
        break;
    case "light_se":
        var_4d33888e = 1;
        break;
    case "med_se":
        var_4d33888e = 2;
        break;
    case "drench_se":
        var_4d33888e = 3;
        break;
    case "light_ne":
        var_4d33888e = 4;
        break;
    case "med_ne":
        var_4d33888e = 5;
        break;
    case "drench_ne":
        var_4d33888e = 6;
        break;
    }
    if (self == level) {
        foreach (player in level.players) {
            player.var_1b3b1022 = 1;
            player clientfield::set_to_player("player_rain", var_4d33888e);
        }
        return;
    }
    if (isplayer(self)) {
        self.var_1b3b1022 = 1;
        self clientfield::set_to_player("player_rain", var_4d33888e);
    }
}

// Namespace namespace_79e1cd97
// Params 2, eflags: 0x1 linked
// Checksum 0x3bfff747, Offset: 0x6eb0
// Size: 0xf0
function function_c2d8b452(str_exploder, str_endon) {
    level endon(str_endon);
    while (true) {
        for (i = 0; i < 5; i++) {
            level exploder::exploder(str_exploder);
            wait 0.05;
            level exploder::stop_exploder(str_exploder);
            wait 0.05;
        }
        playsoundatposition("amb_2d_thunder_hits", (0, 0, 0));
        level exploder::exploder_duration(str_exploder, 1);
        wait randomfloatrange(8, 11.5);
    }
}

// Namespace namespace_79e1cd97
// Params 5, eflags: 0x1 linked
// Checksum 0xa61e9893, Offset: 0x6fa8
// Size: 0x140
function function_bd1bfce2(var_4afc7733, var_d8f507f8, var_fef78261, var_6908bd27, str_endon) {
    level endon(str_endon);
    while (true) {
        exploder::exploder(var_4afc7733);
        level thread function_5bf870a4(var_6908bd27);
        wait randomfloatrange(0.05, 0.11);
        exploder::exploder(var_d8f507f8);
        level thread function_5bf870a4(var_6908bd27);
        wait randomfloatrange(0.11, 0.25);
        if (math::cointoss()) {
            exploder::exploder(var_fef78261);
            level thread function_5bf870a4(var_6908bd27);
        }
        wait randomfloatrange(0.7, 3);
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xb6779369, Offset: 0x70f0
// Size: 0x9a
function function_5bf870a4(var_6908bd27) {
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("toggle_ukko", var_6908bd27);
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x23a0262a, Offset: 0x7198
// Size: 0x19c
function hendricks_debris_traversal_ready() {
    level thread function_3ceb3ad7();
    foreach (player in level.activeplayers) {
        player thread function_2c33b48e();
    }
    level.var_2fd26037 colors::disable();
    level.var_2fd26037 ai::set_behavior_attribute("move_mode", "rambo");
    level.var_2fd26037 ai::set_behavior_attribute("can_melee", 0);
    level thread scene::play("cin_bla_05_01_debristraversal_vign_useanchor_start");
    level waittill(#"hash_153898ed");
    level flag::set("hendricks_debris_traversal_ready");
    level.var_2fd26037 ai::set_behavior_attribute("move_mode", "normal");
    level.var_2fd26037 ai::set_behavior_attribute("can_melee", 1);
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x45d1e0c6, Offset: 0x7340
// Size: 0x60
function function_ef275fb3() {
    self endon(#"death");
    while (true) {
        var_e40110b0 = self waittill(#"missile_fire");
        if (isdefined(var_e40110b0)) {
            var_e40110b0 thread function_eef51bcb(var_e40110b0, self);
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 2, eflags: 0x1 linked
// Checksum 0x3e5e116e, Offset: 0x73a8
// Size: 0x11c
function function_eef51bcb(var_e40110b0, var_c73fc1db) {
    self endon(#"death");
    e_target = var_c73fc1db.enemy;
    n_dist = distancesquared(var_c73fc1db.origin, e_target.origin);
    var_c003c84d = getent("wind_target", "targetname");
    while (isdefined(var_e40110b0)) {
        if (isdefined(e_target) && distancesquared(var_e40110b0.origin, e_target.origin) < 0.5 * n_dist) {
            var_e40110b0 missile_settarget(var_c003c84d);
            break;
        }
        wait 0.05;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x4537294d, Offset: 0x74d0
// Size: 0x21e
function function_33942907() {
    level notify(#"hash_affb79f4");
    level endon(#"hash_affb79f4");
    while (true) {
        if (isdefined(level.heroes) && level.heroes.size > 0) {
            foreach (e_hero in level.heroes) {
                if (e_hero function_30dbc9bf()) {
                    e_hero.allowbattlechatter["bc"] = 1;
                    continue;
                }
                e_hero.allowbattlechatter["bc"] = 0;
            }
        }
        a_ai = getaiteamarray("axis");
        var_39e0fee4 = 0;
        if (isdefined(a_ai) && a_ai.size > 0) {
            foreach (ai in a_ai) {
                if (ai function_30dbc9bf()) {
                    var_39e0fee4 = 1;
                }
            }
        }
        if (var_39e0fee4) {
            battlechatter::function_d9f49fba(1);
        } else {
            battlechatter::function_d9f49fba(0);
        }
        wait 1;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x0
// Checksum 0x1343bb83, Offset: 0x76f8
// Size: 0xd4
function function_704add6a() {
    level notify(#"hash_affb79f4");
    if (isdefined(level.heroes) && level.heroes.size > 0) {
        foreach (e_hero in level.heroes) {
            e_hero.allowbattlechatter["bc"] = 1;
        }
    }
    battlechatter::function_d9f49fba(1);
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xf03fb272, Offset: 0x77d8
// Size: 0x74
function function_30dbc9bf() {
    return !(isdefined(self.ignoreme) && self.ignoreme) && !isdefined(self.current_scene) && isdefined(self) && isalive(self) && !isdefined(self._o_scene) && !(isdefined(self.ignoreall) && self.ignoreall);
}

// Namespace namespace_79e1cd97
// Params 2, eflags: 0x1 linked
// Checksum 0x1a1108f2, Offset: 0x7858
// Size: 0x294
function function_ba29155a(var_c047ec73, var_3b15866b) {
    if (!isdefined(var_c047ec73)) {
        var_c047ec73 = -6;
    }
    if (!isdefined(var_3b15866b)) {
        var_3b15866b = var_c047ec73 * 0.5;
    }
    self notify(#"hash_2f5b059f");
    self endon(#"death");
    self endon(#"hash_2f5b059f");
    self endon(#"hash_a2ba32d");
    self thread function_a2ba32d();
    while (true) {
        wait 0.05;
        if (!isdefined(self.goalpos)) {
            continue;
        }
        v_goal = self.goalpos;
        e_player = arraygetclosest(v_goal, level.players);
        e_closest = arraygetclosest(v_goal, array(e_player, self));
        n_dist = distance2dsquared(self.origin, e_player.origin);
        var_c4197ac8 = isplayer(e_closest);
        if (n_dist < var_3b15866b * var_3b15866b || var_c4197ac8) {
            self ai::set_behavior_attribute("cqb", 0);
            self ai::set_behavior_attribute("sprint", 1);
            continue;
        }
        if (n_dist < var_c047ec73 * var_c047ec73) {
            self ai::set_behavior_attribute("cqb", 0);
            self ai::set_behavior_attribute("sprint", 0);
            continue;
        }
        if (n_dist > var_c047ec73 * var_c047ec73 * 1.25) {
            self ai::set_behavior_attribute("cqb", 1);
            self ai::set_behavior_attribute("sprint", 0);
            continue;
        }
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xf552e86, Offset: 0x7af8
// Size: 0x64
function function_a2ba32d() {
    self endon(#"hash_2f5b059f");
    self endon(#"death");
    self waittill(#"hash_a2ba32d");
    self ai::set_behavior_attribute("cqb", 0);
    self ai::set_behavior_attribute("sprint", 0);
}

// Namespace namespace_79e1cd97
// Params 2, eflags: 0x1 linked
// Checksum 0x57be1ab7, Offset: 0x7b68
// Size: 0x2c
function function_746a2da4(a_ents, str_teleport_name) {
    util::function_93831e79(str_teleport_name);
}

// Namespace namespace_79e1cd97
// Params 2, eflags: 0x1 linked
// Checksum 0xa47c13a1, Offset: 0x7ba0
// Size: 0x13a
function function_da77906f(a_ents, str_state) {
    if (!isdefined(a_ents)) {
        a_ents = [];
    } else if (!isarray(a_ents)) {
        a_ents = array(a_ents);
    }
    foreach (e_ent in a_ents) {
        if (e_ent.spawnflags & 1) {
            if (str_state === "connect") {
                e_ent connectpaths();
                continue;
            }
            if (str_state === "disconnect") {
                e_ent disconnectpaths(2, 0);
            }
        }
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x27986c94, Offset: 0x7ce8
// Size: 0x3c
function cleanup_ai() {
    array::run_all(getaiteamarray("axis"), &delete);
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x0
// Checksum 0x4bd619c1, Offset: 0x7d30
// Size: 0xf4
function function_7aa1381() {
    self endon(#"death");
    self util::show_hint_text(%COOP_EQUIP_MICROMISSILE);
    n_timeout = 0;
    while (self getcurrentweapon() != getweapon("micromissile_launcher") && n_timeout <= 10) {
        n_timeout += 0.1;
        wait 0.1;
    }
    if (self getcurrentweapon() == getweapon("micromissile_launcher")) {
        self.var_f44af1ef = 1;
    }
    self util::hide_hint_text();
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x0
// Checksum 0x79efc614, Offset: 0x7e30
// Size: 0xde
function function_2292647e() {
    self endon(#"death");
    self endon(#"weapon_change");
    n_timeout = 0;
    while (!self adsbuttonpressed() && n_timeout >= 10) {
        n_timeout += 0.05;
        wait 0.05;
    }
    wait 2;
    if (isdefined(self getluimenu("MissileLauncherHint"))) {
        self closeluimenu(self getluimenu("MissileLauncherHint"));
        self.var_fca564e8 = 1;
        self notify(#"hash_242a99a3");
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x0
// Checksum 0x362d22bd, Offset: 0x7f18
// Size: 0x74
function function_dd4b4942() {
    self endon(#"death");
    self endon(#"hash_242a99a3");
    self waittill(#"weapon_change");
    if (isdefined(self getluimenu("MissileLauncherHint"))) {
        self closeluimenu(self getluimenu("MissileLauncherHint"));
    }
}

// Namespace namespace_79e1cd97
// Params 3, eflags: 0x1 linked
// Checksum 0xdfef7507, Offset: 0x7f98
// Size: 0xd8
function function_76b75dc7(str_endon, var_cca258db, var_ab7d99d) {
    if (!isdefined(var_cca258db)) {
        var_cca258db = 12;
    }
    if (!isdefined(var_ab7d99d)) {
        var_ab7d99d = -56;
    }
    level endon(str_endon);
    self endon(#"death");
    while (true) {
        player = self waittill(#"trigger");
        player thread function_ed7faf05();
        if (!player.var_32939eb7) {
            player.var_32939eb7 = 1;
            player thread function_7b145e0b(self, str_endon, var_cca258db, var_ab7d99d);
        }
    }
}

// Namespace namespace_79e1cd97
// Params 4, eflags: 0x1 linked
// Checksum 0xf3851c77, Offset: 0x8078
// Size: 0x37c
function function_7b145e0b(var_c80d3f8f, str_endon, var_cca258db, var_ab7d99d) {
    self endon(#"death");
    level endon(str_endon);
    var_c80d3f8f endon(#"death");
    if (self laststand::player_is_in_laststand()) {
        self.var_116f2fb8 = 1;
    }
    e_linkto = util::spawn_model("tag_origin", self.origin, self.angles);
    self playerlinktodelta(e_linkto, "tag_origin", 1, 45, 45, 45, 45);
    self clientfield::set_to_player("player_water_swept", 1);
    e_linkto thread scene::play("cin_blackstation_24_01_ride_vign_body_player_flail", self);
    e_linkto moveto((e_linkto.origin[0], e_linkto.origin[1], var_cca258db), 0.3);
    e_linkto waittill(#"movedone");
    s_pos = struct::get(var_c80d3f8f.target);
    n_dist = distance(e_linkto.origin, s_pos.origin);
    n_time = n_dist / var_ab7d99d;
    e_linkto thread function_49510c4b(3);
    e_linkto moveto((s_pos.origin[0], s_pos.origin[1], var_cca258db), n_time);
    e_linkto waittill(#"movedone");
    e_linkto moveto(s_pos.origin, 1);
    e_linkto waittill(#"movedone");
    e_linkto scene::stop("cin_blackstation_24_01_ride_vign_body_player_flail");
    self unlink();
    self.var_32939eb7 = 0;
    self clientfield::set_to_player("player_water_swept", 0);
    util::wait_network_frame();
    self setplayerangles(s_pos.angles);
    e_linkto delete();
    self thread function_2c33b48e();
    if (self.var_116f2fb8) {
        self.var_116f2fb8 = 0;
        self dodamage(self.health, self.origin);
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x93513290, Offset: 0x8400
// Size: 0x48
function function_49510c4b(n_rate) {
    self endon(#"death");
    while (true) {
        self rotateyaw(-180, n_rate);
        wait 0.9;
    }
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x641daa87, Offset: 0x8450
// Size: 0x7c
function function_d70754a2() {
    objectives::set("cp_level_blackstation_qzone");
    objectives::set("cp_level_blackstation_intercept");
    objectives::set("cp_level_blackstation_goto_docks");
    objectives::set("cp_level_blackstation_neutralize");
    objectives::complete("cp_level_blackstation_neutralize");
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x7b8c0cee, Offset: 0x84d8
// Size: 0x162
function function_5d4fc658() {
    var_5db4d3e4 = getentarray("qzone_civilian_body", "targetname");
    foreach (e_corpse in var_5db4d3e4) {
        e_corpse thread scene::play(e_corpse.script_noteworthy, e_corpse);
    }
    level flag::wait_till("tanker_go");
    foreach (e_corpse in var_5db4d3e4) {
        if (isdefined(e_corpse)) {
            e_corpse delete();
        }
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0x9d8af911, Offset: 0x8648
// Size: 0x102
function function_4f96504c(ai_target) {
    type = self cybercom::function_5e3d3aa();
    var_1eba5cf1 = vectortoangles(ai_target.origin - self.origin);
    var_1eba5cf1 = (0, var_1eba5cf1[1], 0);
    self animscripted("ai_cybercom_anim", self.origin, var_1eba5cf1, "ai_base_rifle_" + type + "_exposed_cybercom_activate", "normal", undefined, undefined, 0.3, 0.3);
    self cybercom::function_f8669cbf(0);
    self waittillmatch(#"ai_cybercom_anim", "fire");
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0x305ee62, Offset: 0x8758
// Size: 0x1d0
function function_dccf6ccc() {
    self endon(#"hash_d60979de");
    while (true) {
        wait randomfloatrange(5, 7);
        if (isdefined(self.enemy) && !isdefined(self.enemy.current_scene) && !isdefined(self.enemy._o_scene) && self.enemy.archetype != "warlord") {
            ai_target = self.enemy;
            if (isalive(ai_target) && !self isplayinganimscripted()) {
                if (ai_target.archetype == "human") {
                    var_3e2155a7 = "cybercom_immolation";
                } else if (math::cointoss()) {
                    var_3e2155a7 = "cybercom_servoshortout";
                } else {
                    var_3e2155a7 = "cybercom_immolation";
                }
                self ai::set_ignoreall(1);
                self function_4f96504c(ai_target);
                if (isalive(ai_target)) {
                    self thread cybercom::function_d240e350(var_3e2155a7, ai_target, 0, 1);
                }
                self ai::set_ignoreall(0);
            }
        }
    }
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xaf75f464, Offset: 0x8930
// Size: 0x4c
function function_d870e0(str_trigger) {
    self endon(#"death");
    trigger::wait_till(str_trigger, "targetname", self);
    self thread coop::function_e9f7384d();
}

// Namespace namespace_79e1cd97
// Params 0, eflags: 0x1 linked
// Checksum 0xae1a498a, Offset: 0x8988
// Size: 0xa4
function function_46dd77b0() {
    level endon(#"debris_path_one_ready");
    level flag::wait_till("hendricks_debris_traversal_ready");
    wait 5;
    level.var_2fd26037 dialog::say("hend_hurry_it_up_we_need_0");
    wait 6;
    level.var_2fd26037 dialog::say("hend_what_are_you_waiting_6");
    wait 7;
    level.var_2fd26037 dialog::say("hend_we_d_better_get_movi_0");
}

// Namespace namespace_79e1cd97
// Params 1, eflags: 0x1 linked
// Checksum 0xe0fa11a, Offset: 0x8a38
// Size: 0x6c
function function_70aaf37b(b_active) {
    e_blocker = getent("hotel_blocker", "targetname");
    if (b_active) {
        e_blocker solid();
        return;
    }
    e_blocker notsolid();
}

