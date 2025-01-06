#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/shared/callbacks_shared;
#using scripts/shared/spawner_shared;

#namespace namespace_769dc23f;

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xf6925371, Offset: 0x4b0
// Size: 0x234
function function_4d39a2af() {
    level.var_57f2d2db = 0;
    accolades::register("MISSION_BIODOMES_CHALLENGE3", "grant_turret_kill_accolade");
    accolades::register("MISSION_BIODOMES_CHALLENGE5", "grant_wasp_accolade");
    accolades::register("MISSION_BIODOMES_CHALLENGE7", "accolade_nomiss_wasp_kills");
    accolades::register("MISSION_BIODOMES_CHALLENGE8", "grenade_robot_groupkill");
    accolades::register("MISSION_BIODOMES_CHALLENGE9", "siege_bot_smash");
    accolades::register("MISSION_BIODOMES_CHALLENGE10", "stalactite_kill");
    accolades::register("MISSION_BIODOMES_CHALLENGE11", "accolade_kill_all_server_zippers");
    accolades::register("MISSION_BIODOMES_CHALLENGE12", "zipline_kill");
    accolades::register("MISSION_BIODOMES_CHALLENGE13", "hunter_kill");
    accolades::register("MISSION_BIODOMES_CHALLENGE14", "accolade_supertrees_cleared");
    accolades::register("MISSION_BIODOMES_CHALLENGE15", "underwater_kill");
    accolades::register("MISSION_BIODOMES_CHALLENGE16", "accolade_destroy_x_guard_towers");
    accolades::register("MISSION_BIODOMES_CHALLENGE17", "accolade_destroy_x_enemy_trucks");
    function_f7dd9b2c();
    function_e3f60acf();
    function_9ccc0413();
    function_968d885a();
    function_44126609();
    function_3f59ea45();
    function_e77dc7c0();
    function_bccd89ad();
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x3aa7e9eb, Offset: 0x6f0
// Size: 0x84
function function_ed573577() {
    function_c2b4b432();
    function_8b1e395();
    function_203ca39();
    function_befbcf64();
    function_d975b9e3();
    function_16509d1f();
    function_4b47f9f6();
    function_92955d5e();
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x129015ac, Offset: 0x780
// Size: 0x44
function function_f7dd9b2c() {
    callback::on_spawned(&function_1d06a38e);
    callback::on_ai_killed(&function_deda4654);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x43d01906, Offset: 0x7d0
// Size: 0x10
function function_1d06a38e() {
    self.var_50ef9076 = 0;
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0xd1cfe865, Offset: 0x7e8
// Size: 0xf8
function function_deda4654(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && isdefined(params.eattacker.hijacked_vehicle_entity) && params.eattacker.hijacked_vehicle_entity.archetype === "turret") {
        if (params.eattacker.hijacked_vehicle_entity !== self && params.eattacker.var_50ef9076 < 8) {
            params.eattacker.var_50ef9076++;
            params.eattacker notify(#"grant_turret_kill_accolade");
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x5789a3cc, Offset: 0x8e8
// Size: 0x44
function function_c2b4b432() {
    callback::remove_on_ai_killed(&function_deda4654);
    callback::remove_on_spawned(&function_1d06a38e);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xaa97b91b, Offset: 0x938
// Size: 0x44
function function_e3f60acf() {
    callback::on_spawned(&function_80cc63b);
    callback::on_vehicle_killed(&function_674f33f);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x3c4f0f78, Offset: 0x988
// Size: 0x1c
function function_80cc63b() {
    self.var_d7f97874 = 0;
    self.var_fd2e786f = 0;
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xfbacd403, Offset: 0x9b0
// Size: 0x60
function function_8b1e395() {
    if (level.var_62b29d5a !== 1) {
        callback::remove_on_spawned(&function_80cc63b);
        callback::remove_on_vehicle_killed(&function_674f33f);
        level.var_62b29d5a = 1;
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0x2eb20406, Offset: 0xa18
// Size: 0x110
function function_674f33f(params) {
    if (self.archetype === "wasp" && isdefined(params.eattacker) && isplayer(params.eattacker)) {
        if (params.eattacker.var_d7f97874 < 6) {
            if (params.eattacker.var_fd2e786f !== 1) {
                params.eattacker thread function_3c326d55();
                return;
            }
            params.eattacker.var_d7f97874++;
            if (params.eattacker.var_d7f97874 === 6) {
                params.eattacker notify(#"grant_wasp_accolade");
            }
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x3e08f4d7, Offset: 0xb30
// Size: 0x50
function function_3c326d55() {
    if (self.var_fd2e786f != 1) {
        self.var_fd2e786f = 1;
        self.var_d7f97874 = 1;
        wait 2;
        self.var_fd2e786f = 0;
        self.var_d7f97874 = 0;
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xf34e6444, Offset: 0xb88
// Size: 0x64
function function_9ccc0413() {
    callback::on_spawned(&function_215224ef);
    callback::on_ai_damage(&function_d5374ce7);
    callback::on_vehicle_killed(&function_2506f279);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x73dea869, Offset: 0xbf8
// Size: 0x64
function function_203ca39() {
    callback::remove_on_spawned(&function_215224ef);
    callback::remove_on_ai_damage(&function_d5374ce7);
    callback::remove_on_vehicle_killed(&function_2506f279);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x897d91f9, Offset: 0xc68
// Size: 0x3e
function function_215224ef() {
    self.var_dd1a6664 = 0;
    self.var_399b086d = 0;
    self.var_6917783e = 0;
    self.var_be5f3952 = 0;
    self.var_f497e6fe = undefined;
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0x921d9902, Offset: 0xcb0
// Size: 0x148
function function_d5374ce7(params) {
    if (isplayer(params.eattacker)) {
        if (params.eattacker.var_399b086d === 1 && function_7d503e87(params.smeansofdeath)) {
            params.eattacker function_afa04665(params.psoffsettime);
        } else if (self.archetype === "wasp") {
            params.eattacker.var_399b086d = 1;
            params.eattacker.var_6917783e = 1;
            params.eattacker.var_be5f3952 = 1;
            params.eattacker thread function_62deee75();
        }
        params.eattacker.var_f497e6fe = params.psoffsettime;
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x83f07977, Offset: 0xe00
// Size: 0x50
function function_62deee75() {
    self endon(#"accolade_nomiss_wasp_kills");
    while (isdefined(self.var_399b086d) && self.var_399b086d) {
        self waittill(#"weapon_fired");
        self thread function_a1bcadc9();
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xeed0bc5a, Offset: 0xe58
// Size: 0x58
function function_a1bcadc9() {
    wait 0.2;
    self.var_be5f3952++;
    if (self.var_be5f3952 > self.var_6917783e) {
        self.var_399b086d = 0;
        self.var_be5f3952 = 0;
        self.var_6917783e = 0;
        self.var_dd1a6664 = 0;
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0x4ca66750, Offset: 0xeb8
// Size: 0x10c
function function_2506f279(params) {
    if (isdefined(params.eattacker.var_399b086d) && isplayer(params.eattacker) && params.eattacker.var_399b086d && self.archetype === "wasp") {
        params.eattacker.var_dd1a6664++;
        params.eattacker function_afa04665(params.psoffsettime);
        if (params.eattacker.var_dd1a6664 === 3) {
            params.eattacker function_fea6ae9f("accolade_nomiss_wasp_kills");
        }
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0xafb9e3ce, Offset: 0xfd0
// Size: 0x30
function function_afa04665(n_psoffsettime) {
    if (self.var_f497e6fe !== n_psoffsettime) {
        self.var_6917783e++;
        self.var_f497e6fe = n_psoffsettime;
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0xafbd3669, Offset: 0x1008
// Size: 0x28
function function_7d503e87(str_meansofdeath) {
    return str_meansofdeath === "MOD_RIFLE_BULLET" || str_meansofdeath === "MOD_PISTOL_BULLET";
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x1f171da3, Offset: 0x1038
// Size: 0x44
function function_968d885a() {
    callback::on_spawned(&function_f57769d0);
    callback::on_actor_killed(&function_4989deb7);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x1b9cc846, Offset: 0x1088
// Size: 0x24
function function_f57769d0() {
    self.var_545e4fb7 = 0;
    self.var_c152ffb6 = undefined;
    self.var_ce5a7d30 = 0;
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x3f86a17d, Offset: 0x10b8
// Size: 0x60
function function_befbcf64() {
    if (level.var_2b239a23 !== 1) {
        callback::remove_on_spawned(&function_f57769d0);
        callback::remove_on_actor_killed(&function_4989deb7);
        level.var_2b239a23 = 1;
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0x4fbd5e3c, Offset: 0x1120
// Size: 0x220
function function_4989deb7(params) {
    if (isplayer(params.eattacker) && self.archetype === "robot" && params.eattacker.var_ce5a7d30 === 0) {
        if (isdefined(params.weapon)) {
            str_weapon_name = "";
            str_weapon_name = params.weapon.rootweapon.name;
            if (str_weapon_name == "bouncingbetty" && (str_weapon_name == "incendiary_grenade" && (params.smeansofdeath === "MOD_GRENADE" || params.smeansofdeath === "MOD_GRENADE_SPLASH" || params.smeansofdeath == "MOD_BURNED") || params.smeansofdeath == "MOD_EXPLOSIVE")) {
                if (params.einflictor !== params.eattacker.var_c152ffb6) {
                    params.eattacker.var_545e4fb7 = 0;
                    params.eattacker.var_c152ffb6 = params.einflictor;
                }
                params.eattacker.var_545e4fb7++;
                if (params.eattacker.var_545e4fb7 == 3) {
                    params.eattacker function_fea6ae9f("grenade_robot_groupkill");
                    params.eattacker.var_ce5a7d30 = 1;
                }
            }
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x13a5a421, Offset: 0x1348
// Size: 0x44
function function_44126609() {
    callback::on_spawned(&function_8a4f2851);
    callback::on_actor_killed(&function_9c292522);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xc9f7b53d, Offset: 0x1398
// Size: 0x10
function function_8a4f2851() {
    self.var_f62f9f5d = 0;
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xeac35df6, Offset: 0x13b0
// Size: 0x60
function function_d975b9e3() {
    if (level.var_43dd4669 !== 1) {
        callback::remove_on_spawned(&function_8a4f2851);
        callback::remove_on_actor_killed(&function_9c292522);
        level.var_43dd4669 = 1;
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0x91e8cec, Offset: 0x1418
// Size: 0xf8
function function_9c292522(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && isdefined(params.eattacker.hijacked_vehicle_entity) && params.eattacker.hijacked_vehicle_entity.archetype === "siegebot") {
        if (params.eattacker.hijacked_vehicle_entity !== self && params.eattacker.var_f62f9f5d < 8) {
            params.eattacker.var_f62f9f5d++;
            params.eattacker notify(#"siege_bot_smash");
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x7e898b63, Offset: 0x1518
// Size: 0x1c
function function_8ca89944() {
    function_17fe87c5("stalactite_kill");
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x8691d752, Offset: 0x1540
// Size: 0xce
function function_72f8596b() {
    if (level.players.size > 2) {
        var_1e94bf2c = 10;
    } else {
        var_1e94bf2c = 6;
    }
    level.var_57f2d2db++;
    if (level.var_57f2d2db == var_1e94bf2c) {
        foreach (player in level.activeplayers) {
            player notify(#"accolade_kill_all_server_zippers");
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x4800fddf, Offset: 0x1618
// Size: 0x24
function function_3f59ea45() {
    callback::on_ai_killed(&function_eaf6eb1a);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x81b957fa, Offset: 0x1648
// Size: 0x24
function function_16509d1f() {
    callback::remove_on_ai_killed(&function_eaf6eb1a);
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0x31418285, Offset: 0x1678
// Size: 0x84
function function_eaf6eb1a(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && params.eattacker.var_23304c9e === 1) {
        params.eattacker accolades::increment("MISSION_BIODOMES_CHALLENGE12");
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xc345211, Offset: 0x1708
// Size: 0x24
function function_e77dc7c0() {
    callback::on_vehicle_killed(&function_9cda9485);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xf43ffc6b, Offset: 0x1738
// Size: 0x24
function function_4b47f9f6() {
    callback::remove_on_vehicle_killed(&function_9cda9485);
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0x55cddcef, Offset: 0x1768
// Size: 0x6c
function function_9cda9485(params) {
    if (self.vehicletype == "spawner_enemy_54i_vehicle_hunter_rocket") {
        if (isdefined(params.eattacker) && isplayer(params.eattacker)) {
            function_17fe87c5("hunter_kill");
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x5f0ce10f, Offset: 0x17e0
// Size: 0x1c
function function_765fa7e9() {
    level thread function_fcc8b758();
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xda1785a4, Offset: 0x1808
// Size: 0x54
function function_fcc8b758() {
    self endon(#"hash_3a2c1be8");
    level waittill(#"hash_b0ab1d93");
    if (level._ai_group["supertrees_enemies"].aicount === 0) {
        function_17fe87c5("accolade_supertrees_cleared");
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x8af75fa, Offset: 0x1868
// Size: 0x6c
function function_b5aa3655() {
    level.t_underwater_kill = getent("t_underwater_kill", "targetname");
    callback::on_spawned(&function_9dcab1fd);
    callback::on_actor_killed(&function_4d4eb70e);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x5e7266b5, Offset: 0x18e0
// Size: 0x10
function function_9dcab1fd() {
    self.var_58aa080e = 0;
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xbb1f86f6, Offset: 0x18f8
// Size: 0x44
function function_a057c38f() {
    callback::remove_on_spawned(&function_9dcab1fd);
    callback::remove_on_actor_killed(&function_4d4eb70e);
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0xdee89398, Offset: 0x1948
// Size: 0xbc
function function_4d4eb70e(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && params.eattacker istouching(level.t_underwater_kill) && params.eattacker.var_58aa080e < 4) {
        params.eattacker.var_58aa080e++;
        params.eattacker notify(#"underwater_kill");
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0xd78c66c1, Offset: 0x1a10
// Size: 0x10
function function_bccd89ad() {
    level.var_eaa1b961 = 0;
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x506d81a6, Offset: 0x1a28
// Size: 0x3c
function function_b5cf7b68() {
    if (level.var_eaa1b961 < 5) {
        level.var_eaa1b961++;
        function_17fe87c5("accolade_destroy_x_guard_towers");
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x4967fdcf, Offset: 0x1a70
// Size: 0x34
function function_10fc44d8() {
    level.var_7ff8e5dc = 0;
    callback::on_vehicle_killed(&function_5fde05cb);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// Checksum 0x9bf3ecf3, Offset: 0x1ab0
// Size: 0x44
function function_92955d5e() {
    if (level.var_2b53c89b !== 1) {
        level.var_2b53c89b = 1;
        callback::remove_on_vehicle_killed(&function_5fde05cb);
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0xe43e1561, Offset: 0x1b00
// Size: 0xac
function function_5fde05cb(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && self.vehicletype === "veh_bo3_civ_truck_pickup_tech_54i" && level.var_7ff8e5dc < 6) {
        level.var_7ff8e5dc++;
        function_17fe87c5("accolade_destroy_x_enemy_trucks");
    }
    if (level.var_7ff8e5dc >= 6) {
        function_92955d5e();
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0x330556a0, Offset: 0x1bb8
// Size: 0x88
function function_17fe87c5(var_5ba0c4e7) {
    foreach (plr in level.activeplayers) {
        plr notify(var_5ba0c4e7);
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// Checksum 0x8fa1313f, Offset: 0x1c48
// Size: 0x16
function function_fea6ae9f(var_5ba0c4e7) {
    self notify(var_5ba0c4e7);
}

