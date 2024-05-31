#using scripts/cp/_accolades;
#using scripts/shared/stealth_level;
#using scripts/shared/stealth;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_523da15d;

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_4d39a2af
// Checksum 0xdf7c922c, Offset: 0x568
// Size: 0x24a
function function_4d39a2af() {
    accolades::register("MISSION_VENGEANCE_UNTOUCHED");
    accolades::register("MISSION_VENGEANCE_SCORE");
    accolades::register("MISSION_VENGEANCE_COLLECTIBLE");
    accolades::register("MISSION_VENGEANCE_CHALLENGE3", "apartment_enemies_killed");
    accolades::register("MISSION_VENGEANCE_CHALLENGE4", "takedown_timed_kill");
    accolades::register("MISSION_VENGEANCE_CHALLENGE5", "killing_street_sniper_kill");
    accolades::register("MISSION_VENGEANCE_CHALLENGE6", "cafe_stealth");
    accolades::register("MISSION_VENGEANCE_CHALLENGE7", "cafe_wasp_kill");
    accolades::register("MISSION_VENGEANCE_CHALLENGE8", "cafe_stealth_melee");
    accolades::register("MISSION_VENGEANCE_CHALLENGE9", "temple_stealth");
    accolades::register("MISSION_VENGEANCE_CHALLENGE10", "temple_stealth_kill");
    accolades::register("MISSION_VENGEANCE_CHALLENGE11", "temple_stealth_double_kill");
    accolades::register("MISSION_VENGEANCE_CHALLENGE12", "garage_sniper_nohit");
    accolades::register("MISSION_VENGEANCE_CHALLENGE14", "plaza_mounted_turret_kill");
    accolades::register("MISSION_VENGEANCE_CHALLENGE15", "siegebot_hijack_kill");
    accolades::register("MISSION_VENGEANCE_CHALLENGE16", "plaza_midair_kill");
    function_6f52c808();
    function_5d520d55();
    function_ec78b0b7();
    function_f891bcbe();
    callback::on_spawned(&function_3856af47);
}

// Namespace namespace_523da15d
// Params 2, eflags: 0x0
// namespace_523da15d<file_0>::function_c27610f9
// Checksum 0xa57b39ec, Offset: 0x7c0
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

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_dab879d0
// Checksum 0x565ddbf2, Offset: 0x860
// Size: 0x2a
function function_dab879d0() {
    level.var_e9a8d710 = 0;
    callback::on_ai_killed(&function_9d6f9365);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_6b863b66
// Checksum 0x18d0f34b, Offset: 0x898
// Size: 0x22
function function_6b863b66() {
    callback::remove_on_ai_killed(&function_9d6f9365);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x0
// namespace_523da15d<file_0>::function_9d6f9365
// Checksum 0x62e7d90c, Offset: 0x8c8
// Size: 0x82
function function_9d6f9365(params) {
    if (isplayer(params.eattacker)) {
        if (array::contains(level.var_1dca7888, self)) {
            level.var_e9a8d710++;
            if (level.var_e9a8d710 == level.var_7819b21b) {
                level function_c27610f9("apartment_enemies_killed", &function_6b863b66);
            }
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_b510823b
// Checksum 0x1c6ec65c, Offset: 0x958
// Size: 0x42
function function_b510823b() {
    level.var_387f8f17 = 0;
    level.var_56cd8232 = util::new_timer(6);
    callback::on_ai_killed(&function_12042cfc);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_692da451
// Checksum 0x2570e668, Offset: 0x9a8
// Size: 0x22
function function_692da451() {
    callback::remove_on_ai_killed(&function_12042cfc);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x0
// namespace_523da15d<file_0>::function_12042cfc
// Checksum 0xa30213ba, Offset: 0x9d8
// Size: 0x9a
function function_12042cfc(params) {
    if (isplayer(params.eattacker)) {
        if (array::contains(level.var_d9f6d6, self)) {
            level.var_387f8f17++;
            if (level.var_387f8f17 >= level.var_6e0b32d8 && level.var_56cd8232 util::get_time_left() > 0) {
                level function_c27610f9("takedown_timed_kill", &function_692da451);
            }
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_9bba5da
// Checksum 0x8e9d55be, Offset: 0xa80
// Size: 0x22
function function_9bba5da() {
    callback::on_ai_killed(&function_2267b38c);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_3229ece4
// Checksum 0x4ecf6c5d, Offset: 0xab0
// Size: 0x22
function function_3229ece4() {
    callback::remove_on_ai_killed(&function_2267b38c);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x0
// namespace_523da15d<file_0>::function_2267b38c
// Checksum 0x1b650537, Offset: 0xae0
// Size: 0x6a
function function_2267b38c(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (level.var_abd93cb3 === self) {
            if (player iswallrunning()) {
                player function_c27610f9("killing_street_sniper_kill");
            }
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_e887345e
// Checksum 0xc91991d2, Offset: 0xb58
// Size: 0x12
function function_e887345e() {
    level thread function_da492b95();
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_da492b95
// Checksum 0x36c47ded, Offset: 0xb78
// Size: 0x4a
function function_da492b95() {
    level flag::wait_till("dogleg_1_end");
    if (!(isdefined(level.var_508337f6) && level.var_508337f6)) {
        level function_c27610f9("cafe_stealth");
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_cae14a51
// Checksum 0xdc0267b8, Offset: 0xbd0
// Size: 0x32
function function_cae14a51() {
    if (!isdefined(level.var_39caf01b)) {
        level.var_39caf01b = 0;
    }
    callback::on_vehicle_killed(&function_9a43cef1);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_82266abb
// Checksum 0x47cc3dcf, Offset: 0xc10
// Size: 0x22
function function_82266abb() {
    callback::remove_on_vehicle_killed(&function_9a43cef1);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x0
// namespace_523da15d<file_0>::function_9a43cef1
// Checksum 0xf1e7b65d, Offset: 0xc40
// Size: 0xda
function function_9a43cef1(params) {
    if (isdefined(params.eattacker.archetype) && params.eattacker.archetype === "wasp" && (isplayer(params.eattacker) || params.smeansofdeath == "MOD_EXPLOSIVE")) {
        if (!level flag::get("dogleg_1_end")) {
            if (self.archetype === "wasp") {
                level.var_39caf01b++;
                if (level.var_39caf01b == level.var_4843e321) {
                    level function_c27610f9("cafe_wasp_kill", &function_82266abb);
                }
            }
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_eda4634d
// Checksum 0xe6ff64fd, Offset: 0xd28
// Size: 0x22
function function_eda4634d() {
    callback::on_ai_killed(&function_87d295ed);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_a4b67c57
// Checksum 0xc11e28ef, Offset: 0xd58
// Size: 0x22
function function_a4b67c57() {
    callback::remove_on_ai_killed(&function_87d295ed);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x0
// namespace_523da15d<file_0>::function_87d295ed
// Checksum 0xd10fcb89, Offset: 0xd88
// Size: 0xa2
function function_87d295ed(params) {
    if (params.smeansofdeath === "MOD_MELEE" || params.smeansofdeath === "MOD_MELEE_ASSASSINATE" || isplayer(params.eattacker) && params.smeansofdeath === "MOD_MELEE_WEAPON_BUTT") {
        player = params.eattacker;
        if (!(isdefined(level.var_508337f6) && level.var_508337f6)) {
            player function_c27610f9("cafe_stealth_melee");
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_a6fadcaa
// Checksum 0xfdd7e574, Offset: 0xe38
// Size: 0x12
function function_a6fadcaa() {
    level thread function_bd67e1d1();
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_bd67e1d1
// Checksum 0x9f1c0116, Offset: 0xe58
// Size: 0x4a
function function_bd67e1d1() {
    level flag::wait_till("temple_end");
    if (!level flag::get("temple_stealth_broken")) {
        level function_c27610f9("temple_stealth");
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_5d520d55
// Checksum 0x6dcc2ba, Offset: 0xeb0
// Size: 0x22
function function_5d520d55() {
    callback::on_ai_killed(&function_56a787d6);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_47ff9a8f
// Checksum 0x99e3b070, Offset: 0xee0
// Size: 0x22
function function_47ff9a8f() {
    callback::remove_on_ai_killed(&function_56a787d6);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x0
// namespace_523da15d<file_0>::function_56a787d6
// Checksum 0x21d91ff1, Offset: 0xf10
// Size: 0xaa
function function_56a787d6(params) {
    if (isdefined(self.var_8c4675f4) && (isplayer(params.eattacker) || self.var_8c4675f4 == 1)) {
        if (!isdefined(self.stealth)) {
            return;
        }
        if (!level flag::get("stealth_alert") && !level flag::get("stealth_combat") && !level flag::get("stealth_discovered")) {
            level function_c27610f9("temple_stealth_kill");
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_3856af47
// Checksum 0xca957cce, Offset: 0xfc8
// Size: 0x9
function function_3856af47() {
    self.var_fb01e8c9 = undefined;
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_ec78b0b7
// Checksum 0x411101bf, Offset: 0xfe0
// Size: 0x22
function function_ec78b0b7() {
    callback::on_ai_killed(&function_e4b54cbf);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x0
// namespace_523da15d<file_0>::function_e4b54cbf
// Checksum 0xfa282834, Offset: 0x1010
// Size: 0x11a
function function_e4b54cbf(params) {
    if (isplayer(params.eattacker)) {
        if (!isdefined(self.stealth)) {
            return;
        }
        if (params.smeansofdeath == "MOD_PISTOL_BULLET" || isdefined(params.weapon) && params.smeansofdeath == "MOD_RIFLE_BULLET") {
            if (isdefined(params.eattacker.var_f329477a)) {
                if (params.eattacker.var_f329477a == params.eattacker._bbdata["shots"]) {
                    if (!level flag::get("stealth_combat") && !level flag::get("stealth_discovered")) {
                        params.eattacker notify(#"hash_41510dc5");
                    }
                }
            }
            params.eattacker.var_f329477a = params.eattacker._bbdata["shots"];
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_2c3bbf49
// Checksum 0x508c4894, Offset: 0x1138
// Size: 0x82
function function_2c3bbf49() {
    foreach (player in level.activeplayers) {
        player thread function_612cfe91();
    }
    callback::on_spawned(&function_612cfe91);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_612cfe91
// Checksum 0xed9aa823, Offset: 0x11c8
// Size: 0x1a
function function_612cfe91() {
    self.var_78485064 = 0;
    self thread function_2cb00a9b();
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_2cb00a9b
// Checksum 0xb2cd4671, Offset: 0x11f0
// Size: 0x65
function function_2cb00a9b() {
    self endon(#"death");
    level endon(#"hash_d72a35d0");
    while (true) {
        damage, attacker = self waittill(#"damage");
        if (isdefined(attacker.script_aigroup) && attacker.script_aigroup == "garage_snipers") {
            self.var_78485064 = 1;
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_f766f1e0
// Checksum 0xf3818223, Offset: 0x1260
// Size: 0x73
function function_f766f1e0() {
    foreach (player in level.activeplayers) {
        if (!player.var_78485064) {
            player function_c27610f9("garage_sniper_nohit");
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_f891bcbe
// Checksum 0xdeb68250, Offset: 0x12e0
// Size: 0x22
function function_f891bcbe() {
    callback::on_ai_killed(&function_6f8febd3);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_7867d398
// Checksum 0xb30a98f5, Offset: 0x1310
// Size: 0x22
function function_7867d398() {
    callback::remove_on_ai_killed(&function_6f8febd3);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x0
// namespace_523da15d<file_0>::function_6f8febd3
// Checksum 0x7cbe41b5, Offset: 0x1340
// Size: 0xc2
function function_6f8febd3(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (player isinvehicle() && !isdefined(player.hijacked_vehicle_entity)) {
            player function_c27610f9("plaza_mounted_turret_kill");
            return;
        }
        if (player isinvehicle() && player.hijacked_vehicle_entity.archetype === "turret") {
            player function_c27610f9("plaza_mounted_turret_kill");
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_f03a38c7
// Checksum 0xd571ecfa, Offset: 0x1410
// Size: 0x22
function function_f03a38c7() {
    callback::on_ai_killed(&function_4e4b36c4);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_b4f6e07d
// Checksum 0xdbbe4e56, Offset: 0x1440
// Size: 0x22
function function_b4f6e07d() {
    callback::remove_on_ai_killed(&function_4e4b36c4);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x0
// namespace_523da15d<file_0>::function_4e4b36c4
// Checksum 0x684f44cb, Offset: 0x1470
// Size: 0x8a
function function_4e4b36c4(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (isdefined(player.hijacked_vehicle_entity) && isdefined(player.hijacked_vehicle_entity.archetype)) {
            if (player.hijacked_vehicle_entity.archetype === "siegebot") {
                player function_c27610f9("siegebot_hijack_kill");
            }
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_6f52c808
// Checksum 0x80d95a32, Offset: 0x1508
// Size: 0x22
function function_6f52c808() {
    callback::on_ai_killed(&function_91236111);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_b13b2dae
// Checksum 0xd827f5bb, Offset: 0x1538
// Size: 0x22
function function_b13b2dae() {
    callback::remove_on_ai_killed(&function_91236111);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x0
// namespace_523da15d<file_0>::function_91236111
// Checksum 0x6ee2bc79, Offset: 0x1568
// Size: 0x82
function function_91236111(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (player is_jumping() && !isdefined(player.hijacked_vehicle_entity) && !player isinvehicle()) {
            player function_c27610f9("plaza_midair_kill");
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// namespace_523da15d<file_0>::function_4f749468
// Checksum 0x8a47e37d, Offset: 0x15f8
// Size: 0x20
function is_jumping() {
    ground_ent = self getgroundent();
    return !isdefined(ground_ent);
}

