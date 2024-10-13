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
// Params 0, eflags: 0x1 linked
// Checksum 0x397cb501, Offset: 0x570
// Size: 0x25c
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
    function_d2fd62e7();
    function_5d520d55();
    function_ec78b0b7();
    function_f891bcbe();
    callback::on_spawned(&function_3856af47);
}

// Namespace namespace_523da15d
// Params 2, eflags: 0x1 linked
// Checksum 0xe0828e65, Offset: 0x7d8
// Size: 0xd6
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
// Params 0, eflags: 0x1 linked
// Checksum 0xff883064, Offset: 0x8b8
// Size: 0x34
function function_dab879d0() {
    level.apartment_enemies_killed = 0;
    callback::on_ai_killed(&function_9d6f9365);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x188e3640, Offset: 0x8f8
// Size: 0x24
function function_6b863b66() {
    callback::remove_on_ai_killed(&function_9d6f9365);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x1 linked
// Checksum 0xe52928b, Offset: 0x928
// Size: 0x94
function function_9d6f9365(params) {
    if (isplayer(params.eattacker)) {
        if (array::contains(level.var_1dca7888, self)) {
            level.apartment_enemies_killed++;
            if (level.apartment_enemies_killed == level.var_7819b21b) {
                level function_c27610f9("apartment_enemies_killed", &function_6b863b66);
            }
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x74bfce8b, Offset: 0x9c8
// Size: 0x4c
function function_b510823b() {
    level.var_387f8f17 = 0;
    level.var_56cd8232 = util::new_timer(6);
    callback::on_ai_killed(&function_12042cfc);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x32db63da, Offset: 0xa20
// Size: 0x24
function function_692da451() {
    callback::remove_on_ai_killed(&function_12042cfc);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x1 linked
// Checksum 0xad8a4701, Offset: 0xa50
// Size: 0xb4
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
// Params 0, eflags: 0x1 linked
// Checksum 0x4c7fbb72, Offset: 0xb10
// Size: 0x24
function function_d2fd62e7() {
    callback::on_ai_killed(&function_27e99cb1);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// Checksum 0x287b5b27, Offset: 0xb40
// Size: 0x24
function function_6900909d() {
    callback::remove_on_ai_killed(&function_27e99cb1);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x1 linked
// Checksum 0x135c896b, Offset: 0xb70
// Size: 0x9c
function function_27e99cb1(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (isdefined(self.scoretype) && self.scoretype == "_sniper") {
            if (player iswallrunning()) {
                player function_c27610f9("killing_street_sniper_kill");
            }
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x95a9e5c4, Offset: 0xc18
// Size: 0x1c
function function_e887345e() {
    level thread function_da492b95();
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0xd61e527, Offset: 0xc40
// Size: 0x54
function function_da492b95() {
    level flag::wait_till("dogleg_1_end");
    if (!(isdefined(level.var_508337f6) && level.var_508337f6)) {
        level function_c27610f9("cafe_stealth");
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x7eacb9b, Offset: 0xca0
// Size: 0x3c
function function_cae14a51() {
    if (!isdefined(level.var_39caf01b)) {
        level.var_39caf01b = 0;
    }
    callback::on_vehicle_killed(&function_9a43cef1);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x862afe37, Offset: 0xce8
// Size: 0x24
function function_82266abb() {
    callback::remove_on_vehicle_killed(&function_9a43cef1);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x1 linked
// Checksum 0xc3f0a726, Offset: 0xd18
// Size: 0x104
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
// Params 0, eflags: 0x1 linked
// Checksum 0xee1b17e5, Offset: 0xe28
// Size: 0x24
function function_eda4634d() {
    callback::on_ai_killed(&function_87d295ed);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0xb038a896, Offset: 0xe58
// Size: 0x24
function function_a4b67c57() {
    callback::remove_on_ai_killed(&function_87d295ed);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x1 linked
// Checksum 0x95922912, Offset: 0xe88
// Size: 0xfc
function function_87d295ed(params) {
    if (isplayer(params.eattacker)) {
        if (params.smeansofdeath === "MOD_MELEE" || params.smeansofdeath === "MOD_MELEE_ASSASSINATE" || params.smeansofdeath === "MOD_MELEE_WEAPON_BUTT" || params.weapon === level.cybercom.var_e3b77070.var_fdd3ea57) {
            player = params.eattacker;
            if (!(isdefined(level.var_508337f6) && level.var_508337f6)) {
                player function_c27610f9("cafe_stealth_melee");
            }
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x5ce45b10, Offset: 0xf90
// Size: 0x1c
function function_a6fadcaa() {
    level thread function_bd67e1d1();
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x809afc75, Offset: 0xfb8
// Size: 0x64
function function_bd67e1d1() {
    level flag::wait_till("temple_end");
    if (!level flag::get("temple_stealth_broken")) {
        level function_c27610f9("temple_stealth");
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0xcc57ea2e, Offset: 0x1028
// Size: 0x24
function function_5d520d55() {
    callback::on_ai_killed(&function_56a787d6);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// Checksum 0xa82c47c9, Offset: 0x1058
// Size: 0x24
function function_47ff9a8f() {
    callback::remove_on_ai_killed(&function_56a787d6);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x1 linked
// Checksum 0xaa325f91, Offset: 0x1088
// Size: 0xd4
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
// Params 0, eflags: 0x1 linked
// Checksum 0xebcedfc1, Offset: 0x1168
// Size: 0xe
function function_3856af47() {
    self.var_fb01e8c9 = undefined;
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x46b731fc, Offset: 0x1180
// Size: 0x24
function function_ec78b0b7() {
    callback::on_ai_killed(&function_e4b54cbf);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x1 linked
// Checksum 0xf4446912, Offset: 0x11b0
// Size: 0x16c
function function_e4b54cbf(params) {
    if (isplayer(params.eattacker)) {
        if (!isdefined(self.stealth)) {
            return;
        }
        if (params.smeansofdeath == "MOD_PISTOL_BULLET" || isdefined(params.weapon) && params.smeansofdeath == "MOD_RIFLE_BULLET") {
            if (isdefined(params.eattacker.var_f329477a)) {
                if (params.eattacker.var_f329477a == params.eattacker._bbdata["shots"]) {
                    if (!level flag::get("stealth_combat") && !level flag::get("stealth_discovered")) {
                        params.eattacker notify(#"temple_stealth_double_kill");
                    }
                }
            }
            params.eattacker.var_f329477a = params.eattacker._bbdata["shots"];
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x580931cd, Offset: 0x1328
// Size: 0xac
function function_2c3bbf49() {
    foreach (player in level.activeplayers) {
        player thread function_612cfe91();
    }
    callback::on_spawned(&function_612cfe91);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0xdedcecae, Offset: 0x13e0
// Size: 0x24
function function_612cfe91() {
    self.var_78485064 = 0;
    self thread function_2cb00a9b();
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x57344f5a, Offset: 0x1410
// Size: 0x88
function function_2cb00a9b() {
    self endon(#"death");
    level endon(#"garage_enemies_dead");
    while (true) {
        damage, attacker = self waittill(#"damage");
        if (isdefined(attacker.script_aigroup) && attacker.script_aigroup == "garage_snipers") {
            self.var_78485064 = 1;
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0xc72f5c89, Offset: 0x14a0
// Size: 0xa2
function function_f766f1e0() {
    foreach (player in level.activeplayers) {
        if (!player.var_78485064) {
            player function_c27610f9("garage_sniper_nohit");
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0x9f7f5209, Offset: 0x1550
// Size: 0x24
function function_f891bcbe() {
    callback::on_ai_killed(&function_6f8febd3);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// Checksum 0x8546e7a3, Offset: 0x1580
// Size: 0x24
function function_7867d398() {
    callback::remove_on_ai_killed(&function_6f8febd3);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x1 linked
// Checksum 0xd5064ad3, Offset: 0x15b0
// Size: 0xe4
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
// Params 0, eflags: 0x1 linked
// Checksum 0xacafa067, Offset: 0x16a0
// Size: 0x24
function function_f03a38c7() {
    callback::on_ai_killed(&function_4e4b36c4);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0xcdcae87a, Offset: 0x16d0
// Size: 0x24
function function_b4f6e07d() {
    callback::remove_on_ai_killed(&function_4e4b36c4);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x1 linked
// Checksum 0x33d6984d, Offset: 0x1700
// Size: 0xbc
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
// Params 0, eflags: 0x1 linked
// Checksum 0x698d0bca, Offset: 0x17c8
// Size: 0x24
function function_6f52c808() {
    callback::on_ai_killed(&function_91236111);
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x0
// Checksum 0x3331df7b, Offset: 0x17f8
// Size: 0x24
function function_b13b2dae() {
    callback::remove_on_ai_killed(&function_91236111);
}

// Namespace namespace_523da15d
// Params 1, eflags: 0x1 linked
// Checksum 0x5c6286e1, Offset: 0x1828
// Size: 0xac
function function_91236111(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
        if (player is_jumping() && !isdefined(player.hijacked_vehicle_entity) && !player isinvehicle()) {
            player function_c27610f9("plaza_midair_kill");
        }
    }
}

// Namespace namespace_523da15d
// Params 0, eflags: 0x1 linked
// Checksum 0xfa29a41e, Offset: 0x18e0
// Size: 0x30
function is_jumping() {
    ground_ent = self getgroundent();
    return !isdefined(ground_ent);
}

