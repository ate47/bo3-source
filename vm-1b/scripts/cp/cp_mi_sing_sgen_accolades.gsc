#using scripts/cp/_accolades;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/util_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_99202726;

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_66df416f
// Checksum 0x2bc0c133, Offset: 0x600
// Size: 0x345
function function_66df416f() {
    accolades::register("MISSION_SGEN_UNTOUCHED");
    accolades::register("MISSION_SGEN_SCORE");
    accolades::register("MISSION_SGEN_COLLECTIBLE");
    accolades::register("MISSION_SGEN_CHALLENGE3", "accolade_3_doubleshot_success");
    accolades::register("MISSION_SGEN_CHALLENGE4", "accolade_04_immolate_grant");
    accolades::register("MISSION_SGEN_CHALLENGE5", "accolade_05_melee_kill");
    accolades::register("MISSION_SGEN_CHALLENGE6", "accolade_06_confirmed_hit");
    accolades::register("MISSION_SGEN_CHALLENGE7", "accolade_07_stealth_kill");
    accolades::register("MISSION_SGEN_CHALLENGE8", "accolade_08_sniper_kill");
    accolades::register("MISSION_SGEN_CHALLENGE9", "accolade_09_long_shot_success");
    accolades::register("MISSION_SGEN_CHALLENGE10", "accolade_10_electro_bots_success");
    accolades::register("MISSION_SGEN_CHALLENGE11", "accolade_11_flood_exterminate_grant");
    accolades::register("MISSION_SGEN_CHALLENGE13", "accolade_13_stay_awhile_grant");
    accolades::register("MISSION_SGEN_CHALLENGE15", "accolade_15_depth_charge_damage_granted");
    accolades::register("MISSION_SGEN_CHALLENGE16", "accolade_16_kill_depth_charge_success");
    accolades::register("MISSION_SGEN_CHALLENGE17", "accolade_17_rocket_kill_success");
    level flag::wait_till("all_players_spawned");
    level thread function_b5ffeeac();
    level thread function_3fafea6d();
    level thread function_3bf99ff5();
    level thread function_3be7776b();
    level thread function_5335c37e();
    level thread function_a07abde9();
    callback::on_spawned(&function_d5c2bb53);
    level flag::wait_till("all_players_spawned");
    switch (level.var_c0e97bd) {
    case 31:
        function_6a1ab5fc();
        function_b2309b8();
        function_6a2780bc();
        break;
    case 30:
        function_6a1ab5fc();
        function_b2309b8();
        function_6a2780bc();
        break;
    case 32:
        function_f3915502();
    default:
        break;
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_d5c2bb53
// Checksum 0xc767e57f, Offset: 0x950
// Size: 0x22
function function_d5c2bb53() {
    self function_b67d38c4();
    self function_a07abde9();
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_b5ffeeac
// Checksum 0xebee1bfb, Offset: 0x980
// Size: 0x79
function function_b5ffeeac() {
    callback::on_ai_killed(&function_6b1e8f3c);
    foreach (player in level.activeplayers) {
        player.var_f329477a = undefined;
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_b67d38c4
// Checksum 0x75ab9892, Offset: 0xa08
// Size: 0x9
function function_b67d38c4() {
    self.var_f329477a = undefined;
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_6b1e8f3c
// Checksum 0x3ec8a94, Offset: 0xa20
// Size: 0xd6
function function_6b1e8f3c(params) {
    if (isplayer(params.eattacker)) {
        if (params.smeansofdeath == "MOD_PISTOL_BULLET" || isdefined(params.weapon) && params.smeansofdeath == "MOD_RIFLE_BULLET") {
            if (isdefined(params.eattacker.var_f329477a)) {
                if (params.eattacker.var_f329477a == params.eattacker._bbdata["shots"]) {
                    params.eattacker notify(#"hash_450a5f27");
                }
            }
            params.eattacker.var_f329477a = params.eattacker._bbdata["shots"];
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_3fafea6d
// Checksum 0x97dac574, Offset: 0xb00
// Size: 0x7a
function function_3fafea6d() {
    foreach (player in level.activeplayers) {
        player.var_370e0a49 = 0;
    }
    callback::on_ai_killed(&function_ed6cec59);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_ed6cec59
// Checksum 0x4350cdc3, Offset: 0xb88
// Size: 0x1ea
function function_ed6cec59(s_params) {
    if (self.archetype === "robot" && s_params.weapon.name == "gadget_immolation") {
        if (!isdefined(s_params.eattacker.var_6749af1d)) {
            s_params.eattacker.var_6749af1d = [];
        }
        n_time_current = gettime();
        if (!isdefined(s_params.eattacker.var_6749af1d)) {
            s_params.eattacker.var_6749af1d = [];
        } else if (!isarray(s_params.eattacker.var_6749af1d)) {
            s_params.eattacker.var_6749af1d = array(s_params.eattacker.var_6749af1d);
        }
        s_params.eattacker.var_6749af1d[s_params.eattacker.var_6749af1d.size] = n_time_current;
        if (s_params.eattacker.var_6749af1d.size >= 4) {
            var_10db1e52 = s_params.eattacker.var_6749af1d.size - 4;
            var_97e374a8 = n_time_current - 1500;
            var_84abbef6 = 0;
            for (i = var_10db1e52; i < s_params.eattacker.var_6749af1d.size; i++) {
                if (s_params.eattacker.var_6749af1d[i] >= var_97e374a8) {
                    var_84abbef6++;
                }
            }
            if (var_84abbef6 >= 4) {
                s_params.eattacker notify(#"hash_be3e251c");
            }
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_3bf99ff5
// Checksum 0xebf08a31, Offset: 0xd80
// Size: 0x22
function function_3bf99ff5() {
    callback::on_ai_killed(&function_25a5bc35);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_25a5bc35
// Checksum 0x3213d6cd, Offset: 0xdb0
// Size: 0x76
function function_25a5bc35(params) {
    if (self.archetype == "robot" && self.movemode == "run") {
        if (isplayer(params.eattacker)) {
            if (function_3dc86a1(params)) {
                params.eattacker notify(#"hash_55b52735");
            }
        }
    }
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_3dc86a1
// Checksum 0xdf1c52db, Offset: 0xe30
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

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_3be7776b
// Checksum 0xef19b959, Offset: 0xed0
// Size: 0xa2
function function_3be7776b() {
    foreach (player in level.activeplayers) {
        player function_c05b6c67();
    }
    callback::on_spawned(&function_c05b6c67);
    callback::on_ai_damage(&function_d77515b3);
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_c05b6c67
// Checksum 0xc7c21e26, Offset: 0xf80
// Size: 0x12
function function_c05b6c67() {
    self.var_ad8b41e2 = 0;
    self.var_ad217527 = 0;
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_d77515b3
// Checksum 0xcbb1ffb2, Offset: 0xfa0
// Size: 0x16e
function function_d77515b3(params) {
    if (isplayer(params.eattacker)) {
        if (self.archetype == "robot") {
            if (params.shitloc == "head" || params.shitloc == "helmet" || params.shitloc == "neck") {
                if (!params.eattacker.var_ad8b41e2) {
                    params.eattacker.var_ad217527 = params.eattacker._bbdata["shots"];
                } else {
                    params.eattacker.var_ad217527++;
                }
                if (params.eattacker.var_ad217527 == params.eattacker._bbdata["shots"]) {
                    params.eattacker.var_ad8b41e2++;
                    if (params.eattacker.var_ad8b41e2 >= 5) {
                        params.eattacker notify(#"hash_d90d93fc");
                    }
                } else {
                    params.eattacker.var_ad8b41e2 = 1;
                }
                return;
            }
            params.eattacker.var_ad8b41e2 = 0;
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_6a1ab5fc
// Checksum 0x34453517, Offset: 0x1118
// Size: 0x22
function function_6a1ab5fc() {
    callback::on_ai_killed(&function_94847029);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_94847029
// Checksum 0xde2808e7, Offset: 0x1148
// Size: 0x4e
function function_94847029(params) {
    if (isplayer(params.eattacker)) {
        if (!level flag::get("exterior_gone_hot")) {
            params.eattacker notify(#"hash_8ff5db7c");
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_45afef12
// Checksum 0xa614583, Offset: 0x11a0
// Size: 0x22
function function_45afef12() {
    callback::remove_on_ai_killed(&function_94847029);
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_b2309b8
// Checksum 0xd12fe9b0, Offset: 0x11d0
// Size: 0x22
function function_b2309b8() {
    callback::on_ai_killed(&function_52b96b46);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_52b96b46
// Checksum 0x507db414, Offset: 0x1200
// Size: 0x62
function function_52b96b46(params) {
    if (isplayer(params.eattacker)) {
        if (!level flag::get("exterior_gone_hot")) {
            if (self.scoretype == "_sniper") {
                params.eattacker notify(#"hash_4a89e4c7");
            }
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_59fa6593
// Checksum 0xf7e84d14, Offset: 0x1270
// Size: 0x22
function function_59fa6593() {
    callback::remove_on_ai_killed(&function_52b96b46);
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_6a2780bc
// Checksum 0x80da8b35, Offset: 0x12a0
// Size: 0x22
function function_6a2780bc() {
    callback::on_ai_killed(&function_707a731a);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_707a731a
// Checksum 0x98ede2a8, Offset: 0x12d0
// Size: 0x7a
function function_707a731a(params) {
    if (isplayer(params.eattacker)) {
        var_701fc082 = params.eattacker.origin;
        v_target_loc = self.origin;
        if (distance(var_701fc082, v_target_loc) > 2500) {
            params.eattacker notify(#"hash_f1d371eb");
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_6d2fd9d2
// Checksum 0x6bc8ec7f, Offset: 0x1358
// Size: 0x22
function function_6d2fd9d2() {
    callback::remove_on_ai_killed(&function_707a731a);
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_5335c37e
// Checksum 0xbfd8cbb6, Offset: 0x1388
// Size: 0x22
function function_5335c37e() {
    callback::on_ai_killed(&function_e7cebc20);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_e7cebc20
// Checksum 0xbbab2239, Offset: 0x13b8
// Size: 0xda
function function_e7cebc20(params) {
    if (isplayer(params.eattacker)) {
        if (params.smeansofdeath == "MOD_ELECTROCUTED") {
            if (isdefined(params.eattacker.var_e6cc8b44)) {
                if (params.eattacker.var_e6cc8b44 == params.einflictor) {
                    params.eattacker.var_60d52155++;
                    if (params.eattacker.var_60d52155 == 2) {
                        params.eattacker notify(#"hash_b6737fd1");
                    }
                } else {
                    function_5fc826b3(params);
                }
                return;
            }
            function_5fc826b3(params);
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_17b77884
// Checksum 0xe42f163f, Offset: 0x14a0
// Size: 0x11
function function_17b77884() {
    self.var_60d52155 = 0;
    self.var_e6cc8b44 = undefined;
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_5fc826b3
// Checksum 0x8bb6c8ae, Offset: 0x14c0
// Size: 0x3a
function function_5fc826b3(params) {
    params.eattacker.var_e6cc8b44 = params.einflictor;
    params.eattacker.var_60d52155 = 0;
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_bc2458f5
// Checksum 0x94497243, Offset: 0x1508
// Size: 0x79
function function_bc2458f5() {
    if (!level flag::get("flood_runner_escaped")) {
        foreach (player in level.activeplayers) {
            player notify(#"hash_ff15c287");
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_c75f9c25
// Checksum 0x9d0f8309, Offset: 0x1590
// Size: 0x5d
function function_c75f9c25() {
    foreach (player in level.players) {
        player notify(#"hash_4b80918a");
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_f3915502
// Checksum 0x8881262d, Offset: 0x15f8
// Size: 0x82
function function_f3915502() {
    foreach (player in level.activeplayers) {
        player function_79aac6ce();
    }
    callback::on_spawned(&function_79aac6ce);
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_79aac6ce
// Checksum 0xeede9b5e, Offset: 0x1688
// Size: 0x1a
function function_79aac6ce() {
    self.var_bae308b3 = 0;
    self thread function_962154a7();
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_962154a7
// Checksum 0x80acafb5, Offset: 0x16b0
// Size: 0x65
function function_962154a7() {
    self endon(#"death");
    level endon(#"hash_1e73602d");
    while (true) {
        damage, attacker = self waittill(#"damage");
        if (isdefined(attacker.scoretype)) {
            if (attacker.scoretype == "_depth_charge") {
                self.var_bae308b3 = 1;
            }
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_fde8c3ce
// Checksum 0x780f8258, Offset: 0x1720
// Size: 0x69
function function_fde8c3ce() {
    foreach (player in level.activeplayers) {
        if (!player.var_bae308b3) {
            player notify(#"hash_cdcbe1e7");
        }
    }
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_e85e2afd
// Checksum 0x689beb34, Offset: 0x1798
// Size: 0x14
function function_e85e2afd(e_attacker) {
    e_attacker notify(#"hash_5a5ed90f");
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_a07abde9
// Checksum 0xefc69940, Offset: 0x17b8
// Size: 0x79
function function_a07abde9() {
    callback::on_ai_killed(&function_89c51083);
    foreach (player in level.activeplayers) {
        player.var_9dbb738f = undefined;
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// namespace_99202726<file_0>::function_d669046f
// Checksum 0xee77566, Offset: 0x1840
// Size: 0x9
function function_d669046f() {
    self.var_9dbb738f = undefined;
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// namespace_99202726<file_0>::function_89c51083
// Checksum 0x801545fb, Offset: 0x1858
// Size: 0xde
function function_89c51083(params) {
    if (isplayer(params.eattacker)) {
        if (!params.eattacker isonground()) {
            if (params.weapon.weapclass == "rocketlauncher") {
                if (isdefined(params.eattacker.var_9dbb738f)) {
                    if (params.eattacker.var_9dbb738f == params.eattacker._bbdata["shots"]) {
                        params.eattacker notify(#"hash_ed8b1690");
                    }
                }
                params.eattacker.var_9dbb738f = params.eattacker._bbdata["shots"];
            }
        }
    }
}

