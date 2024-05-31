#using scripts/cp/_accolades;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_e9d9fb34;

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0xee12f66b, Offset: 0x580
// Size: 0x2ca
function function_4d39a2af() {
    accolades::register("MISSION_ZURICH_UNTOUCHED");
    accolades::register("MISSION_ZURICH_SCORE");
    accolades::register("MISSION_ZURICH_COLLECTIBLE");
    accolades::register("MISSION_ZURICH_CHALLENGE3", "got_m_all");
    accolades::register("MISSION_ZURICH_CHALLENGE4", "hand_cannon");
    accolades::register("MISSION_ZURICH_CHALLENGE5", "why_u_cry");
    accolades::register("MISSION_ZURICH_CHALLENGE6", "robo_slapper");
    accolades::register("MISSION_ZURICH_CHALLENGE7", "exp_entertainment");
    accolades::register("MISSION_ZURICH_CHALLENGE8", "raps_fan");
    accolades::register("MISSION_ZURICH_CHALLENGE9", "2_kills_1_shot");
    accolades::register("MISSION_ZURICH_CHALLENGE10", "quick_slap");
    accolades::register("MISSION_ZURICH_CHALLENGE11", "container_destroyed");
    accolades::register("MISSION_ZURICH_CHALLENGE12", "perfect_timing");
    accolades::register("MISSION_ZURICH_CHALLENGE13", "dodge_this");
    accolades::register("MISSION_ZURICH_CHALLENGE14", "bots_go_boom");
    accolades::register("MISSION_ZURICH_CHALLENGE15", "clip_their_wings");
    callback::on_spawned(&function_b75a0f7);
    function_53d8882b();
    function_11f62094();
    function_d116d4ed();
    function_8c0cbe3e();
    function_e06c631f();
    function_5384b888();
    function_996c3f92();
    function_131f8d11();
    function_8dec7f28();
    function_605fefbf();
    function_6e040346();
    function_4b53d895();
}

// Namespace namespace_e9d9fb34
// Params 2, eflags: 0x0
// Checksum 0x730f6f2a, Offset: 0x858
// Size: 0x73
function function_c27610f9(var_8e087689, var_70b01bd3) {
    foreach (player in level.activeplayers) {
        player notify(var_8e087689);
    }
    if (isdefined(var_70b01bd3)) {
        [[ var_70b01bd3 ]]();
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x2bf017a4, Offset: 0x8d8
// Size: 0x9a
function function_b75a0f7() {
    self.var_e2f09ac4 = 0;
    self.var_11b787d4 = util::new_timer(10);
    self.var_4d964e27 = undefined;
    self.var_5d4efbf2 = 0;
    self.var_dd160974 = undefined;
    self.var_f4415abf = 0;
    self.var_3e18c869 = util::new_timer(10);
    self.var_6d525c8b = 0;
    self.var_bbb7a4e5 = util::new_timer(5);
    self thread function_17c6bcd0();
    self function_ec61897e();
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0x4aa840b8, Offset: 0x980
// Size: 0x95
function function_3dc86a1(params) {
    if (params.weapon.type == "melee") {
        return 1;
    }
    if (params.smeansofdeath == "MOD_MELEE_WEAPON_BUTT") {
        return 1;
    }
    if (params.weapon.name == "hero_gravity_spikes_cyebercom") {
        return 1;
    }
    if (params.weapon.name == "hero_gravity_spikes_cyebercom_upgraded") {
        return 1;
    }
    return 0;
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0x516a6c07, Offset: 0xa20
// Size: 0xc9
function function_dd0b5d28(params) {
    if (params.weapon.type == "projectile") {
        return 1;
    }
    if (params.smeansofdeath == "MOD_EXPLOSIVE" || params.smeansofdeath === "MOD_EXPLOSIVE_SPLASH" || params.smeansofdeath == "MOD_GRENADE" || params.smeansofdeath === "MOD_GRENADE_SPLASH") {
        return 1;
    }
    if (params.weapon.name == "spike_charge" || params.weapon.name == "spike_launcher") {
        return 1;
    }
    return 0;
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x9ed3be53, Offset: 0xaf8
// Size: 0x4a
function function_62b0213a() {
    trigger::wait_till("stop_depth_charges");
    if (!(isdefined(level.var_e83d53e9) && level.var_e83d53e9)) {
        function_c27610f9("got_m_all");
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x151dbff, Offset: 0xb50
// Size: 0x2a
function function_53d8882b() {
    spawner::add_archetype_spawn_function("siegebot", &function_d7b4afc8);
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x1afe3a1f, Offset: 0xb88
// Size: 0x3a
function function_d7b4afc8() {
    self endon(#"death");
    callback::on_vehicle_damage(&function_ce871b4e);
    self thread function_793c2b3f();
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0xe321997d, Offset: 0xbd0
// Size: 0x4b
function function_ce871b4e(params) {
    if (isplayer(params.eattacker) && params.weapon.weapclass != "pistol") {
        self notify(#"hash_cf910502");
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x97f73fc9, Offset: 0xc28
// Size: 0x92
function function_793c2b3f() {
    self endon(#"hash_cf910502");
    eattacker, damagefromunderneath, weapon, point, dir = self waittill(#"death");
    if (isdefined(weapon) && isplayer(eattacker) && weapon.weapclass === "pistol") {
        function_c27610f9("hand_cannon");
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x456f0276, Offset: 0xcc8
// Size: 0x22
function function_11f62094() {
    callback::on_actor_killed(&function_90ece8b9);
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x59e7041a, Offset: 0xcf8
// Size: 0x22
function function_ee6a5a6a() {
    callback::remove_on_actor_killed(&function_90ece8b9);
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0x1cdcb257, Offset: 0xd28
// Size: 0x72
function function_90ece8b9(params) {
    if (!(self.archetype === "robot") || !isplayer(params.eattacker)) {
        return;
    }
    if (params.weapon.weapclass === "turret") {
        level accolades::increment("MISSION_ZURICH_CHALLENGE5");
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x20ca6a73, Offset: 0xda8
// Size: 0x32
function function_d116d4ed() {
    callback::on_actor_killed(&function_b6ef6322);
    level thread function_cdb4b3f7();
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x240fbd13, Offset: 0xde8
// Size: 0x2a
function function_cdb4b3f7() {
    level waittill(#"hash_52e251bc");
    callback::remove_on_actor_killed(&function_b6ef6322);
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0x8942cf4b, Offset: 0xe20
// Size: 0x15a
function function_b6ef6322(params) {
    if (isplayer(params.eattacker)) {
        if (isdefined(function_3dc86a1(params)) && self.archetype === "robot" && function_3dc86a1(params)) {
            if (params.eattacker.var_e2f09ac4 === 0) {
                params.eattacker.var_11b787d4 = util::new_timer(10);
                params.eattacker.var_e2f09ac4++;
                return;
            }
            params.eattacker.var_e2f09ac4++;
            if (params.eattacker.var_e2f09ac4 >= 5 && params.eattacker.var_11b787d4 util::get_time_left() > 0) {
                params.eattacker notify(#"hash_4ca3efeb");
                return;
            }
            if (params.eattacker.var_11b787d4 util::get_time_left() <= 0) {
                params.eattacker.var_e2f09ac4 = 0;
            }
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0xbe8a5c6e, Offset: 0xf88
// Size: 0x1a
function function_17c6bcd0() {
    self.var_1191fe8d = 0;
    self.var_87550951 = undefined;
    self.var_56a9030 = 0;
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0xdf7301d4, Offset: 0xfb0
// Size: 0x22
function function_8c0cbe3e() {
    callback::on_actor_killed(&function_dcf1dd8b);
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0x2608bcd, Offset: 0xfe0
// Size: 0x132
function function_dcf1dd8b(params) {
    if (self.team === "allies") {
        return;
    }
    if (isplayer(params.eattacker) && params.eattacker.var_56a9030 === 0) {
        if (isdefined(params.weapon)) {
            if (isdefined(function_dd0b5d28(params)) && function_dd0b5d28(params)) {
                if (params.einflictor !== params.eattacker.var_87550951) {
                    params.eattacker.var_1191fe8d = 0;
                    params.eattacker.var_87550951 = params.einflictor;
                }
                params.eattacker.var_1191fe8d++;
                if (params.eattacker.var_1191fe8d >= 3) {
                    params.eattacker notify(#"hash_fd0e8159");
                    params.eattacker.var_56a9030 = 1;
                }
            }
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0xeb1f98ec, Offset: 0x1120
// Size: 0x42
function function_e06c631f() {
    spawner::add_archetype_spawn_function("raps", &function_2c0e41ab);
    level.var_e3b7af42 = 0;
    level thread function_748a64c5();
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x6d1959d, Offset: 0x1170
// Size: 0x52
function function_748a64c5() {
    level util::waittill_any("accolade_8_raps_check", "friendly_raps_damaged");
    if (!(isdefined(level.var_aead8b98) && level.var_aead8b98)) {
        function_c27610f9("raps_fan");
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x7a0c8a59, Offset: 0x11d0
// Size: 0x62
function function_2c0e41ab() {
    if (isdefined(level.var_aead8b98) && level.var_aead8b98) {
        return;
    }
    self thread function_b6f90f();
    level.var_e3b7af42++;
    if (!(isdefined(level.var_ebd2f83b) && level.var_ebd2f83b)) {
        level thread function_6b2c4236();
        level.var_ebd2f83b = 1;
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0xa666bb2c, Offset: 0x1240
// Size: 0x59
function function_b6f90f() {
    eattacker, damagefromunderneath, weapon, point, dir = self waittill(#"death");
    level.var_e3b7af42--;
    if (level.var_e3b7af42 <= 0) {
        level.var_ebd2f83b = undefined;
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x31d082da, Offset: 0x12a8
// Size: 0x42
function function_6b2c4236() {
    var_b97ed523 = getaiteamarray("allies");
    array::thread_all(var_b97ed523, &function_99009628);
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x30dd445, Offset: 0x12f8
// Size: 0x6f
function function_99009628() {
    self endon(#"death");
    n_damage, eattacker, v_direction, v_point, var_4ae4f03b = self waittill(#"damage");
    if (eattacker.archetype === "raps") {
        level.var_aead8b98 = 1;
        level notify(#"hash_1e4d3423");
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x6f915d2c, Offset: 0x1370
// Size: 0x22
function function_5384b888() {
    callback::on_ai_killed(&function_590aa5a5);
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0xa2f9e3d3, Offset: 0x13a0
// Size: 0x22
function function_956d1e2e() {
    callback::on_ai_killed(&function_590aa5a5);
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x374afe0e, Offset: 0x13d0
// Size: 0x9
function function_ec61897e() {
    self.var_c8397fe4 = undefined;
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0xf1f58d87, Offset: 0x13e8
// Size: 0x146
function function_590aa5a5(params) {
    if (self.team === "allies") {
        return;
    }
    if (isplayer(params.eattacker) && params.eattacker.var_5d4efbf2 === 0) {
        if (params.smeansofdeath == "MOD_PISTOL_BULLET" || isdefined(params.weapon) && !issubstr(params.weapon.name, "turret") && params.smeansofdeath == "MOD_RIFLE_BULLET") {
            if (isdefined(params.eattacker.var_c8397fe4)) {
                if (params.eattacker.var_c8397fe4 == params.eattacker._bbdata["shots"]) {
                    params.eattacker notify(#"hash_7a018db6");
                    params.eattacker.var_5d4efbf2 = 1;
                }
            }
            params.eattacker.var_c8397fe4 = params.eattacker._bbdata["shots"];
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x96ee09fa, Offset: 0x1538
// Size: 0x32
function function_996c3f92() {
    callback::on_actor_killed(&function_fa041c17);
    level thread function_1b5b3a2c();
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0xd9c98b16, Offset: 0x1578
// Size: 0x2a
function function_1b5b3a2c() {
    level waittill(#"hash_73b00182");
    callback::remove_on_actor_killed(&function_fa041c17);
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0xa35608f, Offset: 0x15b0
// Size: 0x1ba
function function_fa041c17(params) {
    if (self.team === "allies") {
        return;
    }
    if (isplayer(params.eattacker)) {
        if (isdefined(function_3dc86a1(params)) && (self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined(self.archetype) && self.archetype == "civilian") && function_3dc86a1(params)) {
            if (params.eattacker.var_f4415abf === 0) {
                params.eattacker.var_3e18c869 = util::new_timer(10);
                params.eattacker.var_f4415abf++;
                return;
            }
            params.eattacker.var_f4415abf++;
            if (params.eattacker.var_f4415abf >= 5 && params.eattacker.var_3e18c869 util::get_time_left() > 0) {
                params.eattacker notify(#"hash_dc8b2e3b");
                return;
            }
            if (params.eattacker.var_3e18c869 util::get_time_left() <= 0) {
                params.eattacker.var_f4415abf = 0;
            }
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x3e4be521, Offset: 0x1778
// Size: 0xab
function function_131f8d11() {
    var_1a69ce4d = getentarray("destructible", "targetname");
    foreach (var_6ee6e2fe in var_1a69ce4d) {
        if (issubstr(var_6ee6e2fe.destructibledef, "p7_dest_explosive_")) {
            var_6ee6e2fe thread 32403965();
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0xcb442a05, Offset: 0x1830
// Size: 0x5a
function 32403965() {
    level endon(#"hash_65fc298e");
    n_damage, eattacker, v_direction, v_point, var_4ae4f03b = self waittill(#"damage");
    level accolades::increment("MISSION_ZURICH_CHALLENGE11");
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x3ad7d9c7, Offset: 0x1898
// Size: 0x22
function function_8dec7f28() {
    callback::on_actor_killed(&function_adff2745);
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0xdc714465, Offset: 0x18c8
// Size: 0xc2
function function_adff2745(params) {
    if (!(self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined(self.archetype) && self.archetype == "civilian") || !isplayer(params.eattacker)) {
        return;
    }
    if (params.weapon.type === "grenade") {
        params.eattacker accolades::increment("MISSION_ZURICH_CHALLENGE12");
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0xd1bc79e8, Offset: 0x1998
// Size: 0x2a
function function_605fefbf() {
    spawner::add_archetype_spawn_function("siegebot", &function_13829246);
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0xfed9f240, Offset: 0x19d0
// Size: 0x7b
function function_13829246(params) {
    foreach (player in level.activeplayers) {
        player thread function_baf56cfa(self);
        player thread function_b1f08628(self);
    }
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0xa78161e0, Offset: 0x1a58
// Size: 0x57
function function_baf56cfa(var_f37c20b3) {
    var_f37c20b3 endon(#"death");
    self endon(#"hash_35d17c89");
    while (true) {
        damage, eattacker = self waittill(#"damage");
        if (eattacker === var_f37c20b3) {
            var_f37c20b3 notify(#"hash_700a2ace");
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0x88c0d63d, Offset: 0x1ab8
// Size: 0x6f
function function_b1f08628(var_f37c20b3) {
    var_f37c20b3 endon(#"hash_700a2ace");
    eattacker, damagefromunderneath, weapon, point, dir = var_f37c20b3 waittill(#"death");
    if (isplayer(eattacker)) {
        self notify(#"hash_35d17c89");
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0xaa4d8ae7, Offset: 0x1b30
// Size: 0x22
function function_6e040346() {
    callback::on_actor_killed(&function_61fa3273);
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0x39df5d64, Offset: 0x1b60
// Size: 0xa2
function function_61fa3273(params) {
    if (!(self.archetype === "robot") || !isplayer(params.eattacker)) {
        return;
    }
    if (params.smeansofdeath == "MOD_GRENADE" || params.weapon.name === "hero_pineapplegun" && params.smeansofdeath == "MOD_GRENADE_SPLASH") {
        params.eattacker accolades::increment("MISSION_ZURICH_CHALLENGE14");
    }
}

// Namespace namespace_e9d9fb34
// Params 0, eflags: 0x0
// Checksum 0x27e48a1e, Offset: 0x1c10
// Size: 0x22
function function_4b53d895() {
    callback::on_actor_killed(&function_3bf7b80a);
}

// Namespace namespace_e9d9fb34
// Params 1, eflags: 0x0
// Checksum 0x39f117ab, Offset: 0x1c40
// Size: 0x192
function function_3bf7b80a(params) {
    if (self.team === "allies") {
        return;
    }
    if (isplayer(params.eattacker)) {
        if (self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined(self.archetype) && self.archetype == "civilian") {
            if (params.eattacker.var_6d525c8b === 0) {
                params.eattacker.var_bbb7a4e5 = util::new_timer(5);
                params.eattacker.var_6d525c8b++;
                return;
            }
            params.eattacker.var_6d525c8b++;
            if (params.eattacker.var_6d525c8b >= 3 && params.eattacker.var_bbb7a4e5 util::get_time_left() > 0) {
                params.eattacker notify(#"hash_72346d97");
                return;
            }
            if (params.eattacker.var_bbb7a4e5 util::get_time_left() <= 0) {
                params.eattacker.var_6d525c8b = 0;
            }
        }
    }
}

