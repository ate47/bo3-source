#using scripts/cp/_accolades;
#using scripts/shared/spawner_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_769dc23f;

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_4d39a2af
// Checksum 0xa57d1a1, Offset: 0x470
// Size: 0x22a
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
// namespace_769dc23f<file_0>::function_ed573577
// Checksum 0x8cd130c1, Offset: 0x6a8
// Size: 0x82
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
// namespace_769dc23f<file_0>::function_f7dd9b2c
// Checksum 0x8497c020, Offset: 0x738
// Size: 0x42
function function_f7dd9b2c() {
    callback::on_spawned(&function_1d06a38e);
    callback::on_ai_killed(&function_deda4654);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_1d06a38e
// Checksum 0xe5f1b505, Offset: 0x788
// Size: 0xa
function function_1d06a38e() {
    self.var_50ef9076 = 0;
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// namespace_769dc23f<file_0>::function_deda4654
// Checksum 0x1b7f0482, Offset: 0x7a0
// Size: 0xc6
function function_deda4654(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && isdefined(params.eattacker.hijacked_vehicle_entity) && params.eattacker.hijacked_vehicle_entity.archetype === "turret") {
        if (params.eattacker.hijacked_vehicle_entity !== self && params.eattacker.var_50ef9076 < 8) {
            params.eattacker.var_50ef9076++;
            params.eattacker notify(#"hash_e3795b02");
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_c2b4b432
// Checksum 0xf561cb16, Offset: 0x870
// Size: 0x42
function function_c2b4b432() {
    callback::remove_on_ai_killed(&function_deda4654);
    callback::remove_on_spawned(&function_1d06a38e);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_e3f60acf
// Checksum 0x97e7ba4a, Offset: 0x8c0
// Size: 0x42
function function_e3f60acf() {
    callback::on_spawned(&function_80cc63b);
    callback::on_vehicle_killed(&function_674f33f);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_80cc63b
// Checksum 0x7092582, Offset: 0x910
// Size: 0x12
function function_80cc63b() {
    self.var_d7f97874 = 0;
    self.var_fd2e786f = 0;
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_8b1e395
// Checksum 0xff624c11, Offset: 0x930
// Size: 0x52
function function_8b1e395() {
    if (level.var_62b29d5a !== 1) {
        callback::remove_on_spawned(&function_80cc63b);
        callback::remove_on_vehicle_killed(&function_674f33f);
        level.var_62b29d5a = 1;
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// namespace_769dc23f<file_0>::function_674f33f
// Checksum 0x46f32668, Offset: 0x990
// Size: 0xce
function function_674f33f(params) {
    if (self.archetype === "wasp" && isdefined(params.eattacker) && isplayer(params.eattacker)) {
        if (params.eattacker.var_d7f97874 < 6) {
            if (params.eattacker.var_fd2e786f !== 1) {
                params.eattacker thread function_3c326d55();
                return;
            }
            params.eattacker.var_d7f97874++;
            if (params.eattacker.var_d7f97874 === 6) {
                params.eattacker notify(#"hash_bff7939a");
            }
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_3c326d55
// Checksum 0xbe34e3a5, Offset: 0xa68
// Size: 0x3e
function function_3c326d55() {
    if (self.var_fd2e786f != 1) {
        self.var_fd2e786f = 1;
        self.var_d7f97874 = 1;
        wait(2);
        self.var_fd2e786f = 0;
        self.var_d7f97874 = 0;
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_9ccc0413
// Checksum 0xcfe38a2a, Offset: 0xab0
// Size: 0x62
function function_9ccc0413() {
    callback::on_spawned(&function_215224ef);
    callback::on_ai_damage(&function_d5374ce7);
    callback::on_vehicle_killed(&function_2506f279);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_203ca39
// Checksum 0xd89e680, Offset: 0xb20
// Size: 0x62
function function_203ca39() {
    callback::remove_on_spawned(&function_215224ef);
    callback::remove_on_ai_damage(&function_d5374ce7);
    callback::remove_on_vehicle_killed(&function_2506f279);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_215224ef
// Checksum 0xa1b6b07, Offset: 0xb90
// Size: 0x29
function function_215224ef() {
    self.var_dd1a6664 = 0;
    self.var_399b086d = 0;
    self.var_6917783e = 0;
    self.var_be5f3952 = 0;
    self.var_f497e6fe = undefined;
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// namespace_769dc23f<file_0>::function_d5374ce7
// Checksum 0x9d7e2d89, Offset: 0xbc8
// Size: 0x106
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
// namespace_769dc23f<file_0>::function_62deee75
// Checksum 0x33f31677, Offset: 0xcd8
// Size: 0x3d
function function_62deee75() {
    self endon(#"hash_32230ba9");
    while (isdefined(self.var_399b086d) && self.var_399b086d) {
        self waittill(#"weapon_fired");
        self thread function_a1bcadc9();
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_a1bcadc9
// Checksum 0xb2da48e3, Offset: 0xd20
// Size: 0x46
function function_a1bcadc9() {
    wait(0.2);
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
// namespace_769dc23f<file_0>::function_2506f279
// Checksum 0xfbcf4348, Offset: 0xd70
// Size: 0xd2
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
// namespace_769dc23f<file_0>::function_afa04665
// Checksum 0x1f7fe379, Offset: 0xe50
// Size: 0x26
function function_afa04665(n_psoffsettime) {
    if (self.var_f497e6fe !== n_psoffsettime) {
        self.var_6917783e++;
        self.var_f497e6fe = n_psoffsettime;
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// namespace_769dc23f<file_0>::function_7d503e87
// Checksum 0xf3255d70, Offset: 0xe80
// Size: 0x1e
function function_7d503e87(str_meansofdeath) {
    return str_meansofdeath === "MOD_RIFLE_BULLET" || str_meansofdeath === "MOD_PISTOL_BULLET";
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_968d885a
// Checksum 0xb5527910, Offset: 0xea8
// Size: 0x42
function function_968d885a() {
    callback::on_spawned(&function_f57769d0);
    callback::on_actor_killed(&function_4989deb7);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_f57769d0
// Checksum 0x4373b977, Offset: 0xef8
// Size: 0x1a
function function_f57769d0() {
    self.var_545e4fb7 = 0;
    self.var_c152ffb6 = undefined;
    self.var_ce5a7d30 = 0;
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_befbcf64
// Checksum 0x9011b019, Offset: 0xf20
// Size: 0x52
function function_befbcf64() {
    if (level.var_2b239a23 !== 1) {
        callback::remove_on_spawned(&function_f57769d0);
        callback::remove_on_actor_killed(&function_4989deb7);
        level.var_2b239a23 = 1;
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// namespace_769dc23f<file_0>::function_4989deb7
// Checksum 0xce9e2820, Offset: 0xf80
// Size: 0x136
function function_4989deb7(params) {
    if (isplayer(params.eattacker) && self.archetype === "robot" && params.eattacker.var_ce5a7d30 === 0) {
        if (isdefined(params.weapon)) {
            if (params.smeansofdeath === "MOD_GRENADE" || params.smeansofdeath === "MOD_GRENADE_SPLASH") {
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
// namespace_769dc23f<file_0>::function_44126609
// Checksum 0xb8584381, Offset: 0x10c0
// Size: 0x42
function function_44126609() {
    callback::on_spawned(&function_8a4f2851);
    callback::on_actor_killed(&function_9c292522);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_8a4f2851
// Checksum 0x24d0faf6, Offset: 0x1110
// Size: 0xa
function function_8a4f2851() {
    self.var_f62f9f5d = 0;
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_d975b9e3
// Checksum 0x20ae3a55, Offset: 0x1128
// Size: 0x52
function function_d975b9e3() {
    if (level.var_43dd4669 !== 1) {
        callback::remove_on_spawned(&function_8a4f2851);
        callback::remove_on_actor_killed(&function_9c292522);
        level.var_43dd4669 = 1;
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// namespace_769dc23f<file_0>::function_9c292522
// Checksum 0x6e97ccae, Offset: 0x1188
// Size: 0xc6
function function_9c292522(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && isdefined(params.eattacker.hijacked_vehicle_entity) && params.eattacker.hijacked_vehicle_entity.archetype === "siegebot") {
        if (params.eattacker.hijacked_vehicle_entity !== self && params.eattacker.var_f62f9f5d < 8) {
            params.eattacker.var_f62f9f5d++;
            params.eattacker notify(#"hash_9c3e76f1");
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_8ca89944
// Checksum 0xd1856c5, Offset: 0x1258
// Size: 0x1a
function function_8ca89944() {
    function_17fe87c5("stalactite_kill");
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_72f8596b
// Checksum 0xef246d35, Offset: 0x1280
// Size: 0x95
function function_72f8596b() {
    if (level.players.size > 2) {
        var_1e94bf2c = 10;
    } else {
        var_1e94bf2c = 6;
    }
    level.var_57f2d2db++;
    if (level.var_57f2d2db == var_1e94bf2c) {
        foreach (player in level.activeplayers) {
            player notify(#"hash_c7302d58");
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_3f59ea45
// Checksum 0x11f825ef, Offset: 0x1320
// Size: 0x42
function function_3f59ea45() {
    callback::on_spawned(&function_7b80820d);
    callback::on_actor_killed(&function_eaf6eb1a);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_7b80820d
// Checksum 0xaef71697, Offset: 0x1370
// Size: 0xa
function function_7b80820d() {
    self.var_6a653e1a = 0;
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_16509d1f
// Checksum 0xbbbb6c1d, Offset: 0x1388
// Size: 0x42
function function_16509d1f() {
    callback::remove_on_spawned(&function_7b80820d);
    callback::remove_on_actor_killed(&function_eaf6eb1a);
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// namespace_769dc23f<file_0>::function_eaf6eb1a
// Checksum 0x8b3ba6e3, Offset: 0x13d8
// Size: 0x8e
function function_eaf6eb1a(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && params.eattacker.var_23304c9e === 1) {
        if (params.eattacker.var_6a653e1a < 3) {
            params.eattacker.var_6a653e1a++;
            params.eattacker notify(#"hash_331cb827");
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_e77dc7c0
// Checksum 0xd5941a7e, Offset: 0x1470
// Size: 0x22
function function_e77dc7c0() {
    callback::on_vehicle_killed(&function_9cda9485);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_4b47f9f6
// Checksum 0xe7ec9ca2, Offset: 0x14a0
// Size: 0x22
function function_4b47f9f6() {
    callback::remove_on_vehicle_killed(&function_9cda9485);
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// namespace_769dc23f<file_0>::function_9cda9485
// Checksum 0x21357355, Offset: 0x14d0
// Size: 0x5a
function function_9cda9485(params) {
    if (self.vehicletype == "spawner_enemy_54i_vehicle_hunter_rocket") {
        if (isdefined(params.eattacker) && isplayer(params.eattacker)) {
            function_17fe87c5("hunter_kill");
        }
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_765fa7e9
// Checksum 0xb5060617, Offset: 0x1538
// Size: 0x12
function function_765fa7e9() {
    level thread function_fcc8b758();
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_fcc8b758
// Checksum 0xea488fd6, Offset: 0x1558
// Size: 0x42
function function_fcc8b758() {
    self endon(#"hash_3a2c1be8");
    level waittill(#"hash_b0ab1d93");
    if (level._ai_group["supertrees_enemies"].aicount === 0) {
        function_17fe87c5("accolade_supertrees_cleared");
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_b5aa3655
// Checksum 0x98158da1, Offset: 0x15a8
// Size: 0x6a
function function_b5aa3655() {
    level.var_3234f804 = getent("t_underwater_kill", "targetname");
    callback::on_spawned(&function_9dcab1fd);
    callback::on_actor_killed(&function_4d4eb70e);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_9dcab1fd
// Checksum 0xb767df26, Offset: 0x1620
// Size: 0xa
function function_9dcab1fd() {
    self.var_58aa080e = 0;
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_a057c38f
// Checksum 0x52412503, Offset: 0x1638
// Size: 0x42
function function_a057c38f() {
    callback::remove_on_spawned(&function_9dcab1fd);
    callback::remove_on_actor_killed(&function_4d4eb70e);
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// namespace_769dc23f<file_0>::function_4d4eb70e
// Checksum 0x2f30d7a, Offset: 0x1688
// Size: 0x96
function function_4d4eb70e(params) {
    if (isdefined(params.eattacker) && isplayer(params.eattacker) && params.eattacker istouching(level.var_3234f804) && params.eattacker.var_58aa080e < 4) {
        params.eattacker.var_58aa080e++;
        params.eattacker notify(#"hash_e859318d");
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_bccd89ad
// Checksum 0xb5fc5bac, Offset: 0x1728
// Size: 0xa
function function_bccd89ad() {
    level.var_eaa1b961 = 0;
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_b5cf7b68
// Checksum 0x14be5db6, Offset: 0x1740
// Size: 0x32
function function_b5cf7b68() {
    if (level.var_eaa1b961 < 5) {
        level.var_eaa1b961++;
        function_17fe87c5("accolade_destroy_x_guard_towers");
    }
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_10fc44d8
// Checksum 0xe4bb0a8e, Offset: 0x1780
// Size: 0x2a
function function_10fc44d8() {
    level.var_7ff8e5dc = 0;
    callback::on_vehicle_killed(&function_5fde05cb);
}

// Namespace namespace_769dc23f
// Params 0, eflags: 0x0
// namespace_769dc23f<file_0>::function_92955d5e
// Checksum 0x5e7f4109, Offset: 0x17b8
// Size: 0x3a
function function_92955d5e() {
    if (level.var_2b53c89b !== 1) {
        level.var_2b53c89b = 1;
        callback::remove_on_vehicle_killed(&function_5fde05cb);
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// namespace_769dc23f<file_0>::function_5fde05cb
// Checksum 0x1071e6dc, Offset: 0x1800
// Size: 0x9a
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
// namespace_769dc23f<file_0>::function_17fe87c5
// Checksum 0xe2f93a57, Offset: 0x18a8
// Size: 0x5f
function function_17fe87c5(var_5ba0c4e7) {
    foreach (plr in level.activeplayers) {
        plr notify(var_5ba0c4e7);
    }
}

// Namespace namespace_769dc23f
// Params 1, eflags: 0x0
// namespace_769dc23f<file_0>::function_fea6ae9f
// Checksum 0x27720a3e, Offset: 0x1910
// Size: 0xf
function function_fea6ae9f(var_5ba0c4e7) {
    self notify(var_5ba0c4e7);
}

