#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;

#namespace namespace_37a1dc33;

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xf05fc218, Offset: 0x5d0
// Size: 0x29a
function function_4d39a2af() {
    accolades::register("MISSION_NEWWORLD_UNTOUCHED");
    accolades::register("MISSION_NEWWORLD_SCORE");
    accolades::register("MISSION_NEWWORLD_COLLECTIBLE");
    accolades::register("MISSION_NEWWORLD_CHALLENGE3", "ch03_light_enemies_on_fire");
    accolades::register("MISSION_NEWWORLD_CHALLENGE4", "ch04_wall_run_kills");
    accolades::register("MISSION_NEWWORLD_CHALLENGE5", "ch05_penetrate_bullet_kills");
    accolades::register("MISSION_NEWWORLD_CHALLENGE6", "ch06_cybercom_robot_kills");
    accolades::register("MISSION_NEWWORLD_CHALLENGE7", "ch07_explosion_triple_kill");
    accolades::register("MISSION_NEWWORLD_CHALLENGE8", "ch08_grenade_throwback_kill");
    accolades::register("MISSION_NEWWORLD_CHALLENGE9", "ch09_icicle_kill");
    accolades::register("MISSION_NEWWORLD_CHALLENGE10", "ch10_disabled_robot_kill");
    accolades::register("MISSION_NEWWORLD_CHALLENGE11", "ch11_chase_no_reload");
    accolades::register("MISSION_NEWWORLD_CHALLENGE12", "ch12_chase_no_civilians");
    accolades::register("MISSION_NEWWORLD_CHALLENGE13", "ch13_turret_kill");
    accolades::register("MISSION_NEWWORLD_CHALLENGE14", "ch14_shotgun_kills");
    accolades::register("MISSION_NEWWORLD_CHALLENGE15", "ch15_wall_run_train");
    callback::on_spawned(&function_3a6b5b3e);
    function_89a4c66f();
    function_314eff4a();
    function_2b972244();
    function_e346bcd4();
    function_5a3da660();
    function_a87e96e();
    function_353e449e();
    function_6972c343();
    function_80820e19();
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xbc82afd1, Offset: 0x878
// Size: 0x42
function function_3a6b5b3e() {
    self function_9f8d841b();
    self function_b4b1da62();
    self function_9c7144b6();
    self thread function_7e35ccbc();
}

// Namespace namespace_37a1dc33
// Params 2, eflags: 0x0
// Checksum 0x25a00859, Offset: 0x8c8
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

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x147d4231, Offset: 0x968
// Size: 0x11
function function_9f8d841b() {
    self.var_57582aca = 0;
    self.var_6659e536 = undefined;
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xe593e8c2, Offset: 0x988
// Size: 0x22
function function_89a4c66f() {
    callback::on_actor_killed(&function_595dc718);
}

// Namespace namespace_37a1dc33
// Params 1, eflags: 0x0
// Checksum 0x6d23e051, Offset: 0x9b8
// Size: 0x192
function function_595dc718(params) {
    if (isplayer(params.eattacker) && params.smeansofdeath == "MOD_BURNED") {
        if (!isdefined(params.eattacker.var_6659e536) || params.eattacker.var_6659e536 != params.einflictor) {
            params.eattacker.var_6659e536 = params.einflictor;
            params.eattacker.var_57582aca = 1;
            params.eattacker notify(#"hash_6daef24a");
            wait 0.05;
            if (params.eattacker.var_6659e536 == params.eattacker) {
                params.eattacker thread function_840d3bcc();
            }
            return;
        }
        if (params.eattacker.var_6659e536 === params.einflictor && !isdefined(self.var_93eeceb)) {
            params.eattacker.var_57582aca++;
            self.var_93eeceb = 1;
            if (params.eattacker.var_57582aca == 3) {
                params.eattacker notify(#"ch03_light_enemies_on_fire");
            }
            return;
        }
        params.eattacker.var_6659e536 = params.einflictor;
        params.eattacker.var_57582aca = 1;
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x3f164e42, Offset: 0xb58
// Size: 0x3a
function function_840d3bcc() {
    self endon(#"death");
    self endon(#"hash_6daef24a");
    self endon(#"ch03_light_enemies_on_fire");
    wait 0.5;
    self.var_6659e536 = undefined;
    self.var_57582aca = 0;
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x7ad927dc, Offset: 0xba0
// Size: 0x22
function function_314eff4a() {
    callback::on_ai_killed(&function_9257e223);
}

// Namespace namespace_37a1dc33
// Params 1, eflags: 0x0
// Checksum 0xabb5a4a9, Offset: 0xbd0
// Size: 0x62
function function_9257e223(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (player iswallrunning()) {
            player function_c27610f9("ch04_wall_run_kills");
        }
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x9661c3c9, Offset: 0xc40
// Size: 0x22
function function_2b972244() {
    callback::on_ai_killed(&function_9d5a87b1);
}

// Namespace namespace_37a1dc33
// Params 1, eflags: 0x0
// Checksum 0x470197f2, Offset: 0xc70
// Size: 0xca
function function_9d5a87b1(params) {
    if (self.team !== "axis") {
        return;
    }
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        var_3d9e461f = !bullettracepassed(player geteye(), self geteye(), 0, self);
        if (util::isbulletimpactmod(params.smeansofdeath) && var_3d9e461f) {
            player function_c27610f9("ch05_penetrate_bullet_kills");
        }
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xc9acf46, Offset: 0xd48
// Size: 0x22
function function_b4b1da62() {
    self.var_c81126e8 = 0;
    self.s_timer = util::new_timer(2);
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xe0232f90, Offset: 0xd78
// Size: 0x2a
function function_5a3da660() {
    spawner::add_archetype_spawn_function("robot", &function_f9a5c6a1);
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xf63dddaa, Offset: 0xdb0
// Size: 0xee
function function_f9a5c6a1() {
    self waittill(#"cybercom_action", weapon, eattacker);
    if (isplayer(eattacker)) {
        if (eattacker.var_c81126e8 == 0) {
            eattacker.s_timer = util::new_timer(2);
            eattacker.var_c81126e8++;
            return;
        }
        eattacker.var_c81126e8++;
        if (eattacker.var_c81126e8 >= 5 && eattacker.s_timer util::get_time_left() > 0) {
            eattacker notify(#"ch06_cybercom_robot_kills");
            return;
        }
        if (eattacker.s_timer util::get_time_left() <= 0) {
            eattacker.s_timer = util::new_timer(2);
            eattacker.var_c81126e8 = 1;
        }
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xabf7166, Offset: 0xea8
// Size: 0x11
function function_9c7144b6() {
    self.var_b2c73b97 = 0;
    self.var_b5385d9d = undefined;
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xe5e1fd00, Offset: 0xec8
// Size: 0x22
function function_e346bcd4() {
    callback::on_ai_killed(&function_1b6f43c5);
}

// Namespace namespace_37a1dc33
// Params 1, eflags: 0x0
// Checksum 0x4d4c270a, Offset: 0xef8
// Size: 0x186
function function_1b6f43c5(params) {
    if (self.team !== "axis") {
        return;
    }
    if (params.smeansofdeath == "MOD_GRENADE" || params.smeansofdeath == "MOD_GRENADE_SPLASH" || params.smeansofdeath == "MOD_EXPLOSIVE" || params.smeansofdeath == "MOD_EXPLOSIVE_SPLASH" || params.smeansofdeath == "MOD_PROJECTILE" || isplayer(params.eattacker) && params.smeansofdeath == "MOD_PROJECTILE_SPLASH") {
        if (!isdefined(params.eattacker.var_b5385d9d)) {
            params.eattacker.var_b5385d9d = params.einflictor;
            params.eattacker.var_b2c73b97 = 1;
            return;
        }
        if (params.eattacker.var_b5385d9d === params.einflictor) {
            params.eattacker.var_b2c73b97++;
            if (params.eattacker.var_b2c73b97 >= 3) {
                params.eattacker notify(#"ch07_explosion_triple_kill");
            }
            return;
        }
        params.eattacker.var_b5385d9d = params.einflictor;
        params.eattacker.var_b2c73b97 = 1;
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x3e698d6f, Offset: 0x1088
// Size: 0x65
function function_7e35ccbc() {
    self endon(#"death");
    self.var_c6c262e8 = 0;
    while (true) {
        self waittill(#"grenade_throwback", var_2d789ddd, grenade);
        if (var_2d789ddd.team == "axis") {
            self.var_fc30fc22 = grenade;
            self thread function_23ad043b();
        }
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xfb92c16e, Offset: 0x10f8
// Size: 0x32
function function_23ad043b() {
    self endon(#"death");
    self.var_fc30fc22 waittill(#"explode");
    self.var_fc30fc22 = undefined;
    wait 0.5;
    self.var_c6c262e8 = 0;
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xf272761f, Offset: 0x1138
// Size: 0x22
function function_a87e96e() {
    callback::on_ai_killed(&function_ee3272c2);
}

// Namespace namespace_37a1dc33
// Params 1, eflags: 0x0
// Checksum 0xe85804e3, Offset: 0x1168
// Size: 0x8e
function function_ee3272c2(params) {
    if (isplayer(params.eattacker)) {
        if (isdefined(params.eattacker.var_fc30fc22)) {
            if (params.einflictor == params.eattacker.var_fc30fc22) {
                params.eattacker.var_c6c262e8++;
                if (params.eattacker.var_c6c262e8 == 3) {
                    params.eattacker notify(#"ch08_grenade_throwback_kill");
                }
            }
        }
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x90d648da, Offset: 0x1200
// Size: 0x22
function function_353e449e() {
    callback::on_ai_killed(&function_3867e45c);
}

// Namespace namespace_37a1dc33
// Params 1, eflags: 0x0
// Checksum 0xf8e53fa2, Offset: 0x1230
// Size: 0x52
function function_3867e45c(params) {
    if (isplayer(params.eattacker) && params.eattacker.weap === "icicle") {
        params.eattacker notify(#"ch09_icicle_kill");
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x7c0e3747, Offset: 0x1290
// Size: 0x4a
function function_6972c343() {
    spawner::add_archetype_spawn_function("robot", &function_deb99e6);
    callback::on_ai_killed(&function_c008ffe2);
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x4dba0687, Offset: 0x12e8
// Size: 0x45
function function_deb99e6() {
    self endon(#"death");
    while (true) {
        self.b_disabled = 0;
        self waittill(#"emp_fx_start");
        self.b_disabled = 1;
        self waittill(#"emp_shutdown_end");
        self.b_disabled = 0;
    }
}

// Namespace namespace_37a1dc33
// Params 1, eflags: 0x0
// Checksum 0xa6668fdb, Offset: 0x1338
// Size: 0x56
function function_c008ffe2(params) {
    if (isplayer(params.eattacker) && self.archetype == "robot") {
        if (self.b_disabled) {
            params.eattacker notify(#"ch10_disabled_robot_kill");
        }
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x2e971c42, Offset: 0x1398
// Size: 0xeb
function function_cd261d0b() {
    level flag::wait_till("all_players_spawned");
    foreach (player in level.players) {
        player thread function_af529683();
    }
    level flag::wait_till("chase_done");
    foreach (player in level.players) {
        player thread function_2d344335();
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xf52d78d2, Offset: 0x1490
// Size: 0x32
function function_af529683() {
    self endon(#"death");
    level endon(#"chase_done");
    self waittill(#"reload");
    self savegame::set_player_data("b_nw_accolade_11_failed", 1);
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x3e55efda, Offset: 0x14d0
// Size: 0x72
function function_2d344335() {
    if (self savegame::function_36adbb9c("b_nw_accolade_11_failed") !== 1 && self savegame::function_36adbb9c("b_has_done_chase") !== 0 && self savegame::function_36adbb9c("b_nw_accolade_11_completed") !== 1) {
        self notify(#"ch11_chase_no_reload");
        self savegame::set_player_data("b_nw_accolade_11_completed", 1);
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xadcc6c27, Offset: 0x1550
// Size: 0x112
function function_323baa37() {
    level flag::wait_till("all_players_spawned");
    callback::on_actor_killed(&function_bc7f04af);
    callback::on_ai_spawned(&function_829b12c4);
    level flag::wait_till("chase_done");
    foreach (player in level.players) {
        player thread function_8af9d448();
    }
    callback::remove_on_actor_killed(&function_bc7f04af);
    callback::remove_on_ai_spawned(&function_829b12c4);
}

// Namespace namespace_37a1dc33
// Params 1, eflags: 0x0
// Checksum 0x8de82bda, Offset: 0x1670
// Size: 0x6a
function function_bc7f04af(params) {
    if ((self.archetype == "civilian" || self.archetype == "allies") && isplayer(params.eattacker)) {
        params.eattacker savegame::set_player_data("b_nw_accolade_12_failed", 1);
    }
}

// Namespace namespace_37a1dc33
// Params 1, eflags: 0x0
// Checksum 0x6236aaca, Offset: 0x16e8
// Size: 0x7a
function function_829b12c4(params) {
    self endon(#"death");
    if (self.archetype == "civilian" || self.archetype == "allies") {
        self waittill(#"touch", var_efb53e77);
        if (isplayer(var_efb53e77)) {
            var_efb53e77 savegame::set_player_data("b_nw_accolade_12_failed", 1);
        }
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x750b5224, Offset: 0x1770
// Size: 0x72
function function_8af9d448() {
    if (self savegame::function_36adbb9c("b_nw_accolade_12_failed") !== 1 && self savegame::function_36adbb9c("b_has_done_chase") !== 0 && self savegame::function_36adbb9c("b_nw_accolade_12_completed") !== 1) {
        self notify(#"ch12_chase_no_civilians");
        self savegame::set_player_data("b_nw_accolade_12_completed", 1);
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x5bc03255, Offset: 0x17f0
// Size: 0x4a
function function_f7dd9b2c() {
    callback::on_ai_killed(&function_e50c8d4a);
    level waittill(#"hash_c37d20e3");
    callback::remove_on_ai_killed(&function_e50c8d4a);
}

// Namespace namespace_37a1dc33
// Params 1, eflags: 0x0
// Checksum 0xa88e5307, Offset: 0x1848
// Size: 0x92
function function_e50c8d4a(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && isdefined(params.eattacker.hijacked_vehicle_entity) && params.eattacker.hijacked_vehicle_entity.archetype === "turret") {
        if (params.eattacker.hijacked_vehicle_entity !== self) {
            params.eattacker notify(#"ch13_turret_kill");
        }
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x1e6b1d89, Offset: 0x18e8
// Size: 0xa2
function function_8bb97e0() {
    foreach (player in level.players) {
        player thread function_ee166ee8();
    }
    callback::on_spawned(&function_ee166ee8);
    callback::on_ai_killed(&function_85ed003e);
}

// Namespace namespace_37a1dc33
// Params 1, eflags: 0x0
// Checksum 0x1725bb35, Offset: 0x1998
// Size: 0x80
function function_85ed003e(params) {
    var_8c90e32b = util::getweaponclass(params.weapon);
    if (self.archetype === "robot" && var_8c90e32b === "weapon_cqb") {
        player = params.eattacker;
        player.var_89be6da0++;
        if (player.var_89be6da0 >= 8) {
            player notify(#"ch14_shotgun_kills");
        }
    }
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0xb26d9d39, Offset: 0x1a20
// Size: 0x32
function function_ee166ee8() {
    self endon(#"death");
    self.var_89be6da0 = 0;
    self waittill(#"reload");
    wait 0.05;
    self thread function_ee166ee8();
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x96d45557, Offset: 0x1a60
// Size: 0x3a
function function_80820e19() {
    var_4fa896d4 = getent("newworld_accolade_15", "targetname");
    var_4fa896d4 thread function_14316bd1();
}

// Namespace namespace_37a1dc33
// Params 0, eflags: 0x0
// Checksum 0x497612e8, Offset: 0x1aa8
// Size: 0xc7
function function_14316bd1() {
    level endon(#"train_station_end_gate_closed");
    while (true) {
        self waittill(#"trigger", ent);
        if (isplayer(ent) && ent iswallrunning()) {
            a_trace = bullettrace(ent.origin, ent.origin - (0, 0, 1000), 0, ent);
            if (isdefined(a_trace["entity"]) && a_trace["entity"].script_noteworthy === "chase_train") {
                ent notify(#"ch15_wall_run_train");
            }
        }
    }
}

