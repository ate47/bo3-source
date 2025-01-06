#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;

#namespace namespace_38256252;

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x3b98ddcb, Offset: 0x508
// Size: 0x22a
function function_4d39a2af() {
    accolades::register("MISSION_RAMSES_UNTOUCHED");
    accolades::register("MISSION_RAMSES_SCORE");
    accolades::register("MISSION_RAMSES_COLLECTIBLE");
    accolades::register("MISSION_RAMSES_CHALLENGE3", "wasp_melee_kill");
    accolades::register("MISSION_RAMSES_CHALLENGE4", "raps_hijack_kill");
    accolades::register("MISSION_RAMSES_CHALLENGE5", "jumping_kill");
    accolades::register("MISSION_RAMSES_CHALLENGE6", "robot_quick_kills");
    accolades::register("MISSION_RAMSES_CHALLENGE7", "raps_midair_kill");
    accolades::register("MISSION_RAMSES_CHALLENGE8", "spike_launcher_impale");
    accolades::register("MISSION_RAMSES_CHALLENGE9", "spike_launcher_explosion");
    accolades::register("MISSION_RAMSES_CHALLENGE10", "billboard_kill");
    accolades::register("MISSION_RAMSES_CHALLENGE11", "spike_launcher_impale_long_range");
    accolades::register("MISSION_RAMSES_CHALLENGE12", "wasp_hijack_kill");
    accolades::register("MISSION_RAMSES_CHALLENGE13", "alley_enemies_killed");
    accolades::register("MISSION_RAMSES_CHALLENGE14", "alley_wallrun_kills");
    accolades::register("MISSION_RAMSES_CHALLENGE15", "alley_wallrun_melee_kill");
    accolades::register("MISSION_RAMSES_CHALLENGE16", "quad_tank_slide");
    accolades::register("MISSION_RAMSES_CHALLENGE17", "remote_hijack_variety_kills");
}

// Namespace namespace_38256252
// Params 2, eflags: 0x0
// Checksum 0x2b7da42e, Offset: 0x740
// Size: 0x97
function function_c27610f9(var_8e087689, var_70b01bd3) {
    if (self == level) {
        foreach (player in level.activeplayers) {
            player notify(var_8e087689);
        }
    } else if (isplayer(self)) {
        self notify(var_8e087689);
    }
    if (isdefined(var_70b01bd3)) {
        [[ var_70b01bd3 ]]();
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x7d610582, Offset: 0x7e0
// Size: 0x22
function function_43898266() {
    callback::on_vehicle_killed(&function_4e9ab343);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xfefa7cc9, Offset: 0x810
// Size: 0x22
function function_15009df0() {
    callback::remove_on_vehicle_killed(&function_4e9ab343);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0xaa528a67, Offset: 0x840
// Size: 0x9a
function function_4e9ab343(params) {
    if (params.smeansofdeath === "MOD_MELEE" || params.smeansofdeath === "MOD_MELEE_ASSASSINATE" || isplayer(params.eattacker) && params.smeansofdeath === "MOD_MELEE_WEAPON_BUTT") {
        player = params.eattacker;
        if (self.archetype === "wasp") {
            player function_c27610f9("wasp_melee_kill");
        }
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xddb1a708, Offset: 0x8e8
// Size: 0x22
function function_e1862c87() {
    callback::on_ai_killed(&function_53a23004);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xe960ba3d, Offset: 0x918
// Size: 0x22
function function_a3c86b3d() {
    callback::remove_on_ai_killed(&function_53a23004);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0xaca83960, Offset: 0x948
// Size: 0x28b
function function_53a23004(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (!isdefined(player.var_23c05f0a)) {
            player.var_23c05f0a = 0;
        }
        if (isdefined(player.hijacked_vehicle_entity) && isdefined(player.hijacked_vehicle_entity.archetype)) {
            if (player.hijacked_vehicle_entity.archetype === "raps") {
                if (player.var_23c05f0a == 0) {
                    player thread function_aac5b080();
                }
                player.var_23c05f0a++;
                if (player.var_23c05f0a >= 2) {
                    if (self.archetype === "raps" && self !== player.hijacked_vehicle_entity) {
                        player function_c27610f9("raps_hijack_kill");
                    }
                }
            }
        }
    }
    foreach (player in level.activeplayers) {
        if (!isdefined(player.var_23c05f0a)) {
            player.var_23c05f0a = 0;
        }
        if (isdefined(player.hijacked_vehicle_entity) && isdefined(player.hijacked_vehicle_entity.archetype)) {
            if (player.hijacked_vehicle_entity.archetype === "raps" && self.archetype === "raps") {
                n_distance_sq = distancesquared(self.origin, player.hijacked_vehicle_entity.origin);
                var_4e9389d8 = lengthsquared(player.hijacked_vehicle_entity getvelocity());
                if (n_distance_sq < 10000 && var_4e9389d8 > 10000 && player.var_23c05f0a >= 2 && self !== player.hijacked_vehicle_entity) {
                    player function_c27610f9("raps_hijack_kill");
                }
            }
        }
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xf137a232, Offset: 0xbe0
// Size: 0x2a
function function_aac5b080() {
    self util::waittill_any("return_to_body", "death");
    self.var_23c05f0a = 0;
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x62a74837, Offset: 0xc18
// Size: 0x22
function function_6f52c808() {
    callback::on_ai_killed(&function_91236111);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x8135784a, Offset: 0xc48
// Size: 0x22
function function_b13b2dae() {
    callback::remove_on_ai_killed(&function_91236111);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0x695a2e76, Offset: 0xc78
// Size: 0x62
function function_91236111(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (!player isonground()) {
            player function_c27610f9("jumping_kill");
        }
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x1309838, Offset: 0xce8
// Size: 0x22
function function_7f657f7a() {
    callback::on_actor_killed(&function_2026df43);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x6d2368d, Offset: 0xd18
// Size: 0x22
function tank_handleairburst() {
    callback::remove_on_actor_killed(&function_2026df43);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0xd18046eb, Offset: 0xd48
// Size: 0x11a
function function_2026df43(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (!isdefined(player.var_b6086ab2)) {
            player.var_b6086ab2 = 0;
        }
        if (self.archetype === "robot") {
            if (player.var_b6086ab2 == 0) {
                player.var_e0006b82 = util::new_timer(1);
                player.var_b6086ab2++;
                return;
            }
            player.var_b6086ab2++;
            if (player.var_b6086ab2 >= 5 && player.var_e0006b82 util::get_time_left() > 0) {
                player function_c27610f9("robot_quick_kills");
                return;
            }
            if (player.var_e0006b82 util::get_time_left() <= 0) {
                player.var_b6086ab2 = 0;
            }
        }
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x67328334, Offset: 0xe70
// Size: 0x22
function function_fec73937() {
    callback::on_vehicle_killed(&function_19efc118);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xca96425e, Offset: 0xea0
// Size: 0x22
function function_6d6e6d0d() {
    callback::remove_on_vehicle_killed(&function_19efc118);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0xe7adecc9, Offset: 0xed0
// Size: 0x102
function function_19efc118(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        b_falling = 0;
        trace = physicstrace(self.origin + (0, 0, self.radius * 2), self.origin - (0, 0, 500), (-10, -10, -10), (10, 10, 10), self, 2);
        if (self.origin[2] - trace["position"][2] > 8) {
            b_falling = 1;
        }
        if (isdefined(self.is_jumping) && self.is_jumping || self.archetype === "raps" && b_falling) {
            player function_c27610f9("raps_midair_kill");
        }
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x241e7841, Offset: 0xfe0
// Size: 0x22
function function_bb0dee49() {
    callback::on_actor_killed(&function_b9641d15);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x8ad4d963, Offset: 0x1010
// Size: 0x22
function function_4df6d923() {
    callback::remove_on_actor_killed(&function_b9641d15);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0xef7d2f7f, Offset: 0x1040
// Size: 0xfa
function function_b9641d15(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (!isdefined(player.var_433bafc6)) {
            player.var_433bafc6 = 0;
        }
        if (isdefined(params.weapon)) {
            if (params.weapon.name === "spike_launcher" && params.smeansofdeath === "MOD_IMPACT") {
                level notify(#"hash_2de65b48");
                if (player.var_433bafc6 === 0) {
                    params.einflictor thread function_940b7b45(player);
                }
                player.var_433bafc6++;
            }
            if (player.var_433bafc6 == 2) {
                player function_c27610f9("spike_launcher_impale");
            }
        }
    }
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0x9339532, Offset: 0x1148
// Size: 0x26
function function_940b7b45(player) {
    player endon(#"death");
    self waittill(#"death");
    player.var_433bafc6 = 0;
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x649e8422, Offset: 0x1178
// Size: 0x22
function function_69c025f8() {
    callback::on_ai_killed(&function_d44c2ef0);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xb45c2b8e, Offset: 0x11a8
// Size: 0x22
function function_eb593e7e() {
    callback::remove_on_ai_killed(&function_d44c2ef0);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0x9c451b3, Offset: 0x11d8
// Size: 0x152
function function_d44c2ef0(params) {
    if (isdefined(params.weapon) && isplayer(params.eattacker)) {
        player = params.eattacker;
        if (!isdefined(player.var_310e9a7d)) {
            player.var_310e9a7d = 0;
        }
        if (params.smeansofdeath === "MOD_EXPLOSIVE" || params.smeansofdeath === "MOD_EXPLOSIVE_SPLASH" || params.smeansofdeath === "MOD_GRENADE" || params.weapon.name === "spike_charge" && params.smeansofdeath === "MOD_GRENADE_SPLASH") {
            if (player.var_310e9a7d === 0) {
                player thread function_d91eb48d();
            }
            player.var_310e9a7d++;
        }
        if (player.var_310e9a7d >= 7) {
            if (!(isdefined(player.var_20e5f2) && player.var_20e5f2)) {
                player.var_20e5f2 = 1;
                player function_c27610f9("spike_launcher_explosion");
            }
        }
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xdef71b3f, Offset: 0x1338
// Size: 0x16
function function_d91eb48d() {
    self endon(#"death");
    wait 1;
    self.var_310e9a7d = 0;
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x5b0d6771, Offset: 0x1358
// Size: 0x22
function function_5553172f() {
    callback::on_ai_killed(&function_95b934b0);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x20f56aba, Offset: 0x1388
// Size: 0x22
function function_a64e00f5() {
    callback::remove_on_ai_killed(&function_95b934b0);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0x15d16b6b, Offset: 0x13b8
// Size: 0x8a
function function_95b934b0(params) {
    if (isdefined(params.einflictor) && isdefined(params.einflictor.targetname)) {
        if (params.einflictor.targetname === "arena_billboard" || params.einflictor.targetname === "arena_billboard_02") {
            level function_c27610f9("billboard_kill", &function_a64e00f5);
        }
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xd2c4077f, Offset: 0x1450
// Size: 0x22
function function_cef37178() {
    callback::on_ai_killed(&function_ab3dab38);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x4b3c9feb, Offset: 0x1480
// Size: 0x22
function function_508c89fe() {
    callback::remove_on_ai_killed(&function_ab3dab38);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0x2903ab55, Offset: 0x14b0
// Size: 0xca
function function_ab3dab38(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (isdefined(params.weapon)) {
            if (params.weapon.name === "spike_launcher" && params.smeansofdeath === "MOD_IMPACT") {
                var_d3d59692 = distancesquared(player.origin, self.origin);
                if (var_d3d59692 >= 1440000) {
                    player function_c27610f9("spike_launcher_impale_long_range");
                }
            }
        }
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xe75fef79, Offset: 0x1588
// Size: 0x22
function function_8e872dc8() {
    callback::on_ai_killed(&function_86e525b5);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x76a29b2e, Offset: 0x15b8
// Size: 0x22
function function_d06f936e() {
    callback::remove_on_ai_killed(&function_86e525b5);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0x884140f0, Offset: 0x15e8
// Size: 0x92
function function_86e525b5(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (isdefined(player.hijacked_vehicle_entity) && isdefined(player.hijacked_vehicle_entity.archetype)) {
            if (player.hijacked_vehicle_entity.archetype === "wasp") {
                player function_c27610f9("wasp_hijack_kill");
            }
        }
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xb691f8fb, Offset: 0x1688
// Size: 0x62
function function_17a34ad1() {
    level.var_c4bb3386 = 0;
    level.var_4c41e902 = 0;
    callback::on_ai_spawned(&function_3fa09dec);
    callback::on_ai_killed(&function_b5b577c9);
    level thread function_c0e39bcc();
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xd3fe1e51, Offset: 0x16f8
// Size: 0x42
function function_cee86b3b() {
    callback::remove_on_ai_spawned(&function_3fa09dec);
    callback::remove_on_ai_killed(&function_b5b577c9);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x15882897, Offset: 0x1748
// Size: 0x42
function function_c0e39bcc() {
    level waittill(#"hash_6f120ac6");
    if (level.var_c4bb3386 === level.var_4c41e902) {
        level function_c27610f9("alley_enemies_killed", &function_cee86b3b);
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xbd39642a, Offset: 0x1798
// Size: 0x26
function function_3fa09dec() {
    if (self getteam() === "axis") {
        level.var_c4bb3386++;
    }
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0x9db806ee, Offset: 0x17c8
// Size: 0x2e
function function_b5b577c9(params) {
    if (self getteam() === "axis") {
        level.var_4c41e902++;
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xa02e5f23, Offset: 0x1800
// Size: 0x22
function function_3484502e() {
    callback::on_ai_killed(&function_507d47d2);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x1e51fcbf, Offset: 0x1830
// Size: 0x22
function function_59132ae8() {
    callback::remove_on_ai_killed(&function_507d47d2);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0xd85979a2, Offset: 0x1860
// Size: 0x102
function function_507d47d2(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (!isdefined(player.var_6f2cedd3)) {
            player.var_6f2cedd3 = 0;
        }
        if (player iswallrunning() && player.var_6f2cedd3 === 0) {
            player thread function_aad12c7();
            player.var_6f2cedd3++;
        } else if (player iswallrunning() || player.var_6f2cedd3 > 0 && !player isonground()) {
            player.var_6f2cedd3++;
        }
        if (player.var_6f2cedd3 >= 3) {
            player function_c27610f9("alley_wallrun_kills");
        }
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xc68e0e6c, Offset: 0x1970
// Size: 0x42
function function_aad12c7() {
    self endon(#"death");
    while (self iswallrunning() || !self isonground()) {
        wait 0.05;
    }
    self.var_6f2cedd3 = 0;
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x8efacab7, Offset: 0x19c0
// Size: 0xb2
function function_a17fa88e() {
    callback::on_actor_killed(&function_61c57bec);
    if (isdefined(level.players)) {
        foreach (player in level.players) {
            player thread function_caaf5ba9();
        }
    }
    callback::on_spawned(&function_fbc946b1);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x6a0cab62, Offset: 0x1a80
// Size: 0x9a
function function_c60e8348() {
    callback::remove_on_actor_killed(&function_61c57bec);
    foreach (player in level.activeplayers) {
        player notify(#"hash_ca0391ab");
    }
    callback::remove_on_spawned(&function_fbc946b1);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0xca56cc2b, Offset: 0x1b28
// Size: 0xa2
function function_61c57bec(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (isdefined(player.var_56ffc45b)) {
            if (params.smeansofdeath === "MOD_MELEE" || params.smeansofdeath === "MOD_MELEE_ASSASSINATE" || player.var_56ffc45b && params.smeansofdeath === "MOD_MELEE_WEAPON_BUTT") {
                player function_c27610f9("alley_wallrun_melee_kill");
            }
        }
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xe79c885d, Offset: 0x1bd8
// Size: 0x12
function function_fbc946b1() {
    self thread function_caaf5ba9();
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x211d4ff9, Offset: 0x1bf8
// Size: 0x95
function function_caaf5ba9() {
    self endon(#"death");
    self endon(#"hash_ca0391ab");
    self.var_56ffc45b = 0;
    while (true) {
        while (!self iswallrunning()) {
            wait 0.05;
        }
        self.var_56ffc45b = 1;
        while (self iswallrunning()) {
            wait 0.05;
        }
        while (!self isonground()) {
            wait 0.05;
        }
        self.var_56ffc45b = 0;
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xfba4d694, Offset: 0x1c98
// Size: 0x22
function function_f77ccfb1() {
    callback::on_ai_spawned(&function_1411fbaf);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x6a786404, Offset: 0x1cc8
// Size: 0x22
function function_84fd481b() {
    callback::remove_on_ai_spawned(&function_1411fbaf);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x7154057d, Offset: 0x1cf8
// Size: 0x22
function function_1411fbaf() {
    if (self.archetype === "quadtank") {
        self thread function_1dc324f4();
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x4e549334, Offset: 0x1d28
// Size: 0xdd
function function_1dc324f4() {
    self endon(#"death");
    self endon(#"hash_f71b1ef0");
    while (true) {
        foreach (player in level.activeplayers) {
            var_d3d59692 = distance2dsquared(player.origin, self.origin);
            if (player issliding() && var_d3d59692 <= 1600) {
                player function_c27610f9("quad_tank_slide");
                self notify(#"hash_f71b1ef0");
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0x360e789d, Offset: 0x1e10
// Size: 0x22
function function_359e6bb1() {
    callback::on_ai_killed(&function_fd243f30);
}

// Namespace namespace_38256252
// Params 0, eflags: 0x0
// Checksum 0xaa5a71de, Offset: 0x1e40
// Size: 0x22
function function_c31ee41b() {
    callback::remove_on_ai_killed(&function_fd243f30);
}

// Namespace namespace_38256252
// Params 1, eflags: 0x0
// Checksum 0xab30fe76, Offset: 0x1e70
// Size: 0x19a
function function_fd243f30(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (!isdefined(player.var_4c1b77b6)) {
            player.var_4c1b77b6 = 0;
        }
        if (!isdefined(player.var_a43dc1f)) {
            player.var_a43dc1f = 0;
        }
        if (!isdefined(player.var_204359de)) {
            player.var_204359de = 0;
        }
        if (!isdefined(player.var_218b552)) {
            player.var_218b552 = 0;
        }
        if (isdefined(player.hijacked_vehicle_entity) && isdefined(player.hijacked_vehicle_entity.archetype)) {
            switch (player.hijacked_vehicle_entity.archetype) {
            case "raps":
                player.var_4c1b77b6 = 1;
                break;
            case "wasp":
                player.var_a43dc1f = 1;
                break;
            case "amws":
                player.var_204359de = 1;
                break;
            case "quadtank":
                player.var_218b552 = 1;
                break;
            default:
                break;
            }
            if (player.var_4c1b77b6 && player.var_a43dc1f && player.var_204359de && player.var_218b552) {
                player function_c27610f9("remote_hijack_variety_kills");
            }
        }
    }
}

