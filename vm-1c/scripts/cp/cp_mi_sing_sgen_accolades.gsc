#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace namespace_99202726;

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x6b1a0793, Offset: 0x600
// Size: 0x396
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
    case "post_intro":
        function_6a1ab5fc();
        function_b2309b8();
        function_6a2780bc();
        break;
    case "enter_sgen":
        function_6a1ab5fc();
        function_b2309b8();
        function_6a2780bc();
        break;
    case "silo_swim":
        function_f3915502();
    default:
        break;
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x34e5263d, Offset: 0x9a0
// Size: 0x34
function function_d5c2bb53() {
    self function_b67d38c4();
    self function_a07abde9();
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x73a73a4, Offset: 0x9e0
// Size: 0xa0
function function_b5ffeeac() {
    callback::on_ai_killed(&function_6b1e8f3c);
    foreach (player in level.activeplayers) {
        player.var_f329477a = undefined;
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x2905df66, Offset: 0xa88
// Size: 0xe
function function_b67d38c4() {
    self.var_f329477a = undefined;
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0xbc925887, Offset: 0xaa0
// Size: 0x118
function function_6b1e8f3c(params) {
    if (isplayer(params.eattacker)) {
        if (params.smeansofdeath == "MOD_PISTOL_BULLET" || isdefined(params.weapon) && params.smeansofdeath == "MOD_RIFLE_BULLET") {
            if (isdefined(params.eattacker.var_f329477a)) {
                if (params.eattacker.var_f329477a == params.eattacker._bbdata["shots"]) {
                    params.eattacker notify(#"accolade_3_doubleshot_success");
                }
            }
            params.eattacker.var_f329477a = params.eattacker._bbdata["shots"];
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x57209d47, Offset: 0xbc0
// Size: 0xa4
function function_3fafea6d() {
    foreach (player in level.activeplayers) {
        player.var_370e0a49 = 0;
    }
    callback::on_ai_killed(&function_ed6cec59);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0xbf578bb6, Offset: 0xc70
// Size: 0x264
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
                s_params.eattacker notify(#"accolade_04_immolate_grant");
            }
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x867fb796, Offset: 0xee0
// Size: 0x24
function function_3bf99ff5() {
    callback::on_ai_killed(&function_25a5bc35);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0x56ae5f94, Offset: 0xf10
// Size: 0x84
function function_25a5bc35(params) {
    if (self.archetype == "robot" && self.movemode == "run") {
        if (isplayer(params.eattacker)) {
            if (function_3dc86a1(params)) {
                params.eattacker notify(#"accolade_05_melee_kill");
            }
        }
    }
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0x4b5d14c7, Offset: 0xfa0
// Size: 0xba
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
// Checksum 0xe156d92, Offset: 0x1068
// Size: 0xcc
function function_3be7776b() {
    foreach (player in level.activeplayers) {
        player function_c05b6c67();
    }
    callback::on_spawned(&function_c05b6c67);
    callback::on_ai_damage(&function_d77515b3);
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x463fc380, Offset: 0x1140
// Size: 0x1c
function function_c05b6c67() {
    self.var_ad8b41e2 = 0;
    self.var_ad217527 = 0;
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0x8cb63d04, Offset: 0x1168
// Size: 0x204
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
                        params.eattacker notify(#"accolade_06_confirmed_hit");
                    }
                } else {
                    params.eattacker.var_ad217527 = params.eattacker._bbdata["shots"];
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
// Checksum 0xe0014840, Offset: 0x1378
// Size: 0x24
function function_6a1ab5fc() {
    callback::on_ai_killed(&function_94847029);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0xd3db063, Offset: 0x13a8
// Size: 0x64
function function_94847029(params) {
    if (isplayer(params.eattacker)) {
        if (!level flag::get("exterior_gone_hot")) {
            params.eattacker notify(#"accolade_07_stealth_kill");
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0xe005f7b5, Offset: 0x1418
// Size: 0x24
function function_45afef12() {
    callback::remove_on_ai_killed(&function_94847029);
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x6ee91f97, Offset: 0x1448
// Size: 0x24
function function_b2309b8() {
    callback::on_ai_killed(&function_52b96b46);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0xce1c8609, Offset: 0x1478
// Size: 0x7c
function function_52b96b46(params) {
    if (isplayer(params.eattacker)) {
        if (!level flag::get("exterior_gone_hot")) {
            if (self.scoretype == "_sniper") {
                params.eattacker notify(#"accolade_08_sniper_kill");
            }
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x58ed0bd6, Offset: 0x1500
// Size: 0x24
function function_59fa6593() {
    callback::remove_on_ai_killed(&function_52b96b46);
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x2d80123b, Offset: 0x1530
// Size: 0x24
function function_6a2780bc() {
    callback::on_ai_killed(&function_707a731a);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0x2296944e, Offset: 0x1560
// Size: 0x9c
function function_707a731a(params) {
    if (isplayer(params.eattacker)) {
        var_701fc082 = params.eattacker.origin;
        v_target_loc = self.origin;
        if (distance(var_701fc082, v_target_loc) > 2500) {
            params.eattacker notify(#"accolade_09_long_shot_success");
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x6c2f219d, Offset: 0x1608
// Size: 0x24
function function_6d2fd9d2() {
    callback::remove_on_ai_killed(&function_707a731a);
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x8fd624a5, Offset: 0x1638
// Size: 0x24
function function_5335c37e() {
    callback::on_ai_killed(&function_e7cebc20);
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0xd9a76ff7, Offset: 0x1668
// Size: 0x114
function function_e7cebc20(params) {
    if (isplayer(params.eattacker)) {
        if (params.smeansofdeath == "MOD_ELECTROCUTED") {
            if (isdefined(params.eattacker.var_e6cc8b44)) {
                if (params.eattacker.var_e6cc8b44 == params.einflictor) {
                    params.eattacker.var_60d52155++;
                    if (params.eattacker.var_60d52155 == 2) {
                        params.eattacker notify(#"accolade_10_electro_bots_success");
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
// Checksum 0x4e02ec83, Offset: 0x1788
// Size: 0x1a
function function_17b77884() {
    self.var_60d52155 = 0;
    self.var_e6cc8b44 = undefined;
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0xc44d4f3b, Offset: 0x17b0
// Size: 0x48
function function_5fc826b3(params) {
    params.eattacker.var_e6cc8b44 = params.einflictor;
    params.eattacker.var_60d52155 = 0;
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x244afe59, Offset: 0x1800
// Size: 0xa6
function function_bc2458f5() {
    if (!level flag::get("flood_runner_escaped")) {
        foreach (player in level.activeplayers) {
            player notify(#"accolade_11_flood_exterminate_grant");
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x2a3290a0, Offset: 0x18b0
// Size: 0x82
function function_c75f9c25() {
    foreach (player in level.players) {
        player notify(#"accolade_13_stay_awhile_grant");
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x6488f5f7, Offset: 0x1940
// Size: 0xac
function function_f3915502() {
    foreach (player in level.activeplayers) {
        player function_79aac6ce();
    }
    callback::on_spawned(&function_79aac6ce);
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x9df26c98, Offset: 0x19f8
// Size: 0x24
function function_79aac6ce() {
    self.var_bae308b3 = 0;
    self thread function_962154a7();
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x639a69cd, Offset: 0x1a28
// Size: 0x88
function function_962154a7() {
    self endon(#"death");
    level endon(#"hash_1e73602d");
    while (true) {
        self waittill(#"damage", damage, attacker);
        if (isdefined(attacker.scoretype)) {
            if (attacker.scoretype == "_depth_charge") {
                self.var_bae308b3 = 1;
            }
        }
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x8cb72815, Offset: 0x1ab8
// Size: 0x92
function function_fde8c3ce() {
    foreach (player in level.activeplayers) {
        if (!player.var_bae308b3) {
            player notify(#"accolade_15_depth_charge_damage_granted");
        }
    }
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0x7b01ffb6, Offset: 0x1b58
// Size: 0x1c
function function_e85e2afd(e_attacker) {
    e_attacker notify(#"accolade_16_kill_depth_charge_success");
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0x686b47e3, Offset: 0x1b80
// Size: 0xa0
function function_a07abde9() {
    callback::on_ai_killed(&function_89c51083);
    foreach (player in level.activeplayers) {
        player.var_9dbb738f = undefined;
    }
}

// Namespace namespace_99202726
// Params 0, eflags: 0x0
// Checksum 0xe82c2e16, Offset: 0x1c28
// Size: 0xe
function function_d669046f() {
    self.var_9dbb738f = undefined;
}

// Namespace namespace_99202726
// Params 1, eflags: 0x0
// Checksum 0x6623aa27, Offset: 0x1c40
// Size: 0x110
function function_89c51083(params) {
    if (isplayer(params.eattacker)) {
        if (!params.eattacker isonground()) {
            if (params.weapon.weapclass == "rocketlauncher") {
                if (isdefined(params.eattacker.var_9dbb738f)) {
                    if (params.eattacker.var_9dbb738f == params.eattacker._bbdata["shots"]) {
                        params.eattacker notify(#"accolade_17_rocket_kill_success");
                    }
                }
                params.eattacker.var_9dbb738f = params.eattacker._bbdata["shots"];
            }
        }
    }
}

