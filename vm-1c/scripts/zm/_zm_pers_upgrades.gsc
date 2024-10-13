#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pers_upgrades_system;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_perks;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_95add22b;

// Namespace namespace_95add22b
// Params 0, eflags: 0x0
// Checksum 0xf069e25a, Offset: 0x3b8
// Size: 0xec
function function_432f925d() {
    function_e3f25872();
    function_8196f416();
    function_dfff590b();
    function_89ba29ee();
    function_934fdbad();
    function_4c0caa98();
    function_535bb383();
    function_8c91c0f();
    function_aaa88abe();
    function_13a98c70();
    function_25915a30();
    function_71bfadf();
    function_ac121789();
    level thread namespace_d93d7691::function_4f17af50();
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x0
// Checksum 0x502ac88d, Offset: 0x4b0
// Size: 0xa4
function function_d83e4ca() {
    self.var_7a77e398 = 0;
    self.failed_revives = 0;
    self.var_a82a23e8 = 0;
    self.pers["last_headshot_kill_time"] = gettime();
    self.pers["zombies_multikilled"] = 0;
    self.var_937c6d27 = 0;
    if (isdefined(level.var_55d2ea99) && level.var_55d2ea99) {
        self.var_bf349207 = undefined;
    }
    if (isdefined(level.var_f4735dd3) && level.var_f4735dd3) {
        self thread namespace_25f8c2ad::function_830c8552();
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xca89964, Offset: 0x560
// Size: 0x34
function function_69f37d91() {
    if (!zm_utility::is_classic()) {
        return false;
    }
    if (function_4ab3f2ab()) {
        return false;
    }
    return false;
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xdf03d28b, Offset: 0x5a0
// Size: 0x6
function function_4ab3f2ab() {
    return false;
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x21539d0b, Offset: 0x5b0
// Size: 0x6c
function function_e3f25872() {
    if (isdefined(level.var_a2fe812c) && level.var_a2fe812c) {
        level.var_d81e1548 = 10;
        level.var_e146cf60 = 74;
        namespace_d93d7691::function_8562a0f6("board", &function_8726ed89, "pers_boarding", level.var_e146cf60, 0);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x1129ebbc, Offset: 0x628
// Size: 0x74
function function_8196f416() {
    if (isdefined(level.var_4d91d5d4) && level.var_4d91d5d4) {
        level.var_cf93f24f = 17;
        level.var_7e0c4364 = 1;
        namespace_d93d7691::function_8562a0f6("revive", &function_26eddba1, "pers_revivenoperk", level.var_cf93f24f, 1);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xf2c7ddb8, Offset: 0x6a8
// Size: 0x6c
function function_dfff590b() {
    if (isdefined(level.var_7698eecd) && level.var_7698eecd) {
        level.var_a121f145 = 5;
        level.var_9b1b9c4b = 25;
        namespace_d93d7691::function_8562a0f6("multikill_headshots", &function_29534a7e, "pers_multikill_headshots", level.var_a121f145, 0);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xb11726ea, Offset: 0x720
// Size: 0xac
function function_89ba29ee() {
    if (isdefined(level.var_bac53324) && level.var_bac53324) {
        level.var_db62f146 = 50;
        level.var_c434d051 = 15;
        level.var_a8f683d7 = 1;
        level.var_82949e7a = 1000;
        namespace_d93d7691::function_8562a0f6("cash_back", &function_c29eb071, "pers_cash_back_bought", level.var_db62f146, 0);
        namespace_d93d7691::function_f17b9229("cash_back", "pers_cash_back_prone", level.var_c434d051);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x5bd2f3a9, Offset: 0x7d8
// Size: 0x6c
function function_934fdbad() {
    if (isdefined(level.var_6e4e78c7) && level.var_6e4e78c7) {
        level.var_4cf213 = 2;
        level.var_2a6e5316 = 18;
        namespace_d93d7691::function_8562a0f6("insta_kill", &function_744187f0, "pers_insta_kill", level.var_4cf213, 0);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x9e6da8c, Offset: 0x850
// Size: 0x94
function function_4c0caa98() {
    if (isdefined(level.var_70e80676) && level.var_70e80676) {
        level.var_f6be23f9 = 3;
        level.var_34be9153 = 2;
        level.var_64717f34 = 1;
        level.var_5a4f8be0 = 15;
        level.var_eb469fd1 = 90;
        namespace_d93d7691::function_8562a0f6("jugg", &function_7f74d80b, "pers_jugg", level.var_f6be23f9, 0);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x390d2c19, Offset: 0x8f0
// Size: 0x64
function function_535bb383() {
    if (isdefined(level.var_57f7a081) && level.var_57f7a081) {
        level.var_1a219dbf = 1;
        namespace_d93d7691::function_8562a0f6("carpenter", &function_3737e5a, "pers_carpenter", level.var_1a219dbf, 0);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x94160e9, Offset: 0x960
// Size: 0x6c
function function_8c91c0f() {
    if (isdefined(level.var_52f5a971) && level.var_52f5a971) {
        level.var_1d4251ad = 6;
        level.pers_perk_lose_counter = 3;
        namespace_d93d7691::function_8562a0f6("perk_lose", &function_30223dca, "pers_perk_lose_counter", level.pers_perk_lose_counter, 0);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x35a35f31, Offset: 0x9d8
// Size: 0x7c
function function_aaa88abe() {
    if (isdefined(level.var_cfce124) && level.var_cfce124) {
        level.var_a4afe255 = 8;
        level.var_5d181faf = 0.25;
        level.pers_pistol_points_counter = 1;
        namespace_d93d7691::function_8562a0f6("pistol_points", &function_27be4a71, "pers_pistol_points_counter", level.pers_pistol_points_counter, 0);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x95222e62, Offset: 0xa60
// Size: 0x6c
function function_13a98c70() {
    if (isdefined(level.var_10626b86) && level.var_10626b86) {
        level.var_2ce89398 = 2500;
        level.pers_double_points_counter = 1;
        namespace_d93d7691::function_8562a0f6("double_points", &function_b8b4fcdb, "pers_double_points_counter", level.pers_double_points_counter, 0);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x491cd130, Offset: 0xad8
// Size: 0x84
function function_25915a30() {
    if (isdefined(level.var_2eafd286) && level.var_2eafd286) {
        level.var_98b6d77b = 5;
        level.var_441ad7ba = 800;
        level.pers_sniper_counter = 1;
        level.var_4de1c840 = 3;
        namespace_d93d7691::function_8562a0f6("sniper", &function_729cf9db, "pers_sniper_counter", level.pers_sniper_counter, 0);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x9d39d1ef, Offset: 0xb68
// Size: 0x6c
function function_71bfadf() {
    if (isdefined(level.var_55d2ea99) && level.var_55d2ea99) {
        level.pers_box_weapon_counter = 5;
        level.var_21500b7f = 10;
        namespace_d93d7691::function_8562a0f6("box_weapon", &function_f7fb14e2, "pers_box_weapon_counter", level.pers_box_weapon_counter, 0);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x60153df5, Offset: 0xbe0
// Size: 0x7c
function function_ac121789() {
    if (isdefined(level.var_f4735dd3) && level.var_f4735dd3) {
        level.pers_nube_counter = 1;
        level.var_ea5b9bd9 = 10;
        level.var_8d9746cc = 5;
        namespace_d93d7691::function_8562a0f6("nube", &function_e69589a4, "pers_nube_counter", level.pers_nube_counter, 0);
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xabd8812d, Offset: 0xc68
// Size: 0xa0
function function_8726ed89() {
    self endon(#"disconnect");
    for (var_e9cfa030 = level.round_number; true; var_e9cfa030 = level.round_number) {
        self waittill(#"hash_90dc1354");
        if (level.round_number >= var_e9cfa030) {
            if (function_69f37d91()) {
                if (self.rebuild_barrier_reward == 0) {
                    self zm_stats::zero_client_stat("pers_boarding", 0);
                    return;
                }
            }
        }
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x3b4e8b1a, Offset: 0xd10
// Size: 0x7e
function function_26eddba1() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"player_failed_revive");
        if (function_69f37d91()) {
            if (self.failed_revives >= level.var_7e0c4364) {
                self zm_stats::zero_client_stat("pers_revivenoperk", 0);
                self.failed_revives = 0;
                return;
            }
        }
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x881a1220, Offset: 0xd98
// Size: 0x86
function function_29534a7e() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"zombie_death_no_headshot");
        if (function_69f37d91()) {
            self.var_937c6d27++;
            if (self.var_937c6d27 >= level.var_9b1b9c4b) {
                self zm_stats::zero_client_stat("pers_multikill_headshots", 0);
                self.var_937c6d27 = 0;
                return;
            }
        }
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x55f61829, Offset: 0xe28
// Size: 0xd2
function function_c29eb071() {
    self endon(#"disconnect");
    wait 0.5;
    /#
    #/
    wait 0.5;
    while (true) {
        self waittill(#"hash_56b30d01");
        wait 0.1;
        /#
        #/
        if (function_69f37d91()) {
            self.var_a82a23e8++;
            if (self.var_a82a23e8 >= level.var_a8f683d7) {
                self zm_stats::zero_client_stat("pers_cash_back_bought", 0);
                self zm_stats::zero_client_stat("pers_cash_back_prone", 0);
                self.var_a82a23e8 = 0;
                wait 0.4;
                /#
                #/
                return;
            }
        }
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xb0c3e7ca, Offset: 0xf08
// Size: 0x158
function function_744187f0() {
    self endon(#"disconnect");
    wait 0.2;
    /#
    #/
    wait 0.2;
    while (true) {
        self waittill(#"hash_35c06a37");
        if (function_69f37d91()) {
            if (isdefined(level.var_7b63c6af)) {
                e_zombie = level.var_7b63c6af;
                if (isdefined(e_zombie.is_zombie) && isalive(e_zombie) && e_zombie.is_zombie) {
                    e_zombie.marked_for_insta_upgraded_death = 1;
                    e_zombie dodamage(e_zombie.health + 666, e_zombie.origin, self, self, "none", "MOD_PISTOL_BULLET", 0);
                }
                level.var_7b63c6af = undefined;
            }
            break;
        }
    }
    self zm_stats::zero_client_stat("pers_insta_kill", 0);
    self function_ea7d0979();
    wait 0.4;
    /#
    #/
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x4e6ba02b, Offset: 0x1068
// Size: 0x64
function function_4332a58a() {
    if (function_69f37d91()) {
        if (self zm_powerups::is_insta_kill_active()) {
            if (isdefined(self.var_698f7e["insta_kill"]) && self.var_698f7e["insta_kill"]) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xfa10ce0a, Offset: 0x10d8
// Size: 0x134
function function_7f74d80b() {
    self endon(#"disconnect");
    wait 0.5;
    /#
    #/
    wait 0.5;
    self zm_perks::function_78f42790("jugg_upgrade", 1, 0);
    while (true) {
        level waittill(#"start_of_round");
        if (function_69f37d91()) {
            if (level.round_number == level.var_5a4f8be0) {
                /#
                #/
                self zm_stats::increment_client_stat("pers_jugg_downgrade_count", 0);
                wait 0.5;
                if (self.pers["pers_jugg_downgrade_count"] >= level.var_64717f34) {
                    break;
                }
            }
        }
    }
    self zm_perks::function_78f42790("jugg_upgrade", 1, 1);
    /#
    #/
    self zm_stats::zero_client_stat("pers_jugg", 0);
    self zm_stats::zero_client_stat("pers_jugg_downgrade_count", 0);
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xce114927, Offset: 0x1218
// Size: 0xb8
function function_3737e5a() {
    self endon(#"disconnect");
    wait 0.2;
    /#
    #/
    wait 0.2;
    level waittill(#"carpenter_finished");
    self.var_7b43d46f = undefined;
    while (true) {
        self waittill(#"hash_b182e276");
        if (function_69f37d91()) {
            if (!isdefined(self.var_7b43d46f)) {
                break;
            }
            /#
            #/
        }
        self.var_7b43d46f = undefined;
    }
    self zm_stats::zero_client_stat("pers_carpenter", 0);
    wait 0.4;
    /#
    #/
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xcd6fea34, Offset: 0x12d8
// Size: 0x1b6
function function_ce147d1() {
    if (isdefined(level.var_57f7a081) && level.var_57f7a081) {
        self endon(#"disconnect");
        /#
        #/
        if (isdefined(self.var_698f7e["carpenter"]) && self.var_698f7e["carpenter"]) {
            level.var_2d4f1f79 = 1;
        }
        self.var_b8ccb8b1 = 1;
        self.var_7b43d46f = undefined;
        var_f2b36700 = 3;
        var_a09a29b = undefined;
        level.var_a09a29b = undefined;
        while (true) {
            if (!function_4ab3f2ab()) {
                if (!isdefined(level.carpenter_powerup_active)) {
                    if (!isdefined(level.var_a09a29b)) {
                        level.var_a09a29b = gettime();
                    }
                    time = gettime();
                    dt = (time - level.var_a09a29b) / 1000;
                    if (dt >= var_f2b36700) {
                        break;
                    }
                }
                if (isdefined(self.var_7b43d46f)) {
                    if (isdefined(self.var_698f7e["carpenter"]) && self.var_698f7e["carpenter"]) {
                        break;
                    } else {
                        self zm_stats::increment_client_stat("pers_carpenter", 0);
                    }
                }
            }
            wait 0.01;
        }
        self notify(#"hash_b182e276");
        self.var_b8ccb8b1 = undefined;
        level.var_2d4f1f79 = undefined;
    }
}

// Namespace namespace_95add22b
// Params 2, eflags: 0x1 linked
// Checksum 0xf6878a2f, Offset: 0x1498
// Size: 0x78
function function_290a4934(attacker, v_pos) {
    if (function_69f37d91()) {
        if (zm_utility::is_player_valid(attacker)) {
            if (isdefined(attacker.var_b8ccb8b1)) {
                if (!zm_utility::check_point_in_playable_area(v_pos)) {
                    attacker.var_7b43d46f = 1;
                }
            }
        }
    }
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xfd8d30e4, Offset: 0x1518
// Size: 0x6c
function function_8e30b6f3() {
    if (self.zombie_vars["zombie_powerup_insta_kill_ug_on"]) {
        self.zombie_vars["zombie_powerup_insta_kill_ug_time"] = level.var_2a6e5316;
        return;
    }
    self.zombie_vars["zombie_powerup_insta_kill_ug_on"] = 1;
    self._show_solo_hud = 1;
    self thread function_4217fc1f();
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x4490c489, Offset: 0x1590
// Size: 0x7c
function function_4217fc1f() {
    self endon(#"disconnect");
    self endon(#"hash_ea7d0979");
    while (self.zombie_vars["zombie_powerup_insta_kill_ug_time"] >= 0) {
        wait 0.05;
        self.zombie_vars["zombie_powerup_insta_kill_ug_time"] = self.zombie_vars["zombie_powerup_insta_kill_ug_time"] - 0.05;
    }
    self function_ea7d0979();
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xa5566df1, Offset: 0x1618
// Size: 0x4a
function function_ea7d0979() {
    self.zombie_vars["zombie_powerup_insta_kill_ug_on"] = 0;
    self._show_solo_hud = 0;
    self.zombie_vars["zombie_powerup_insta_kill_ug_time"] = level.var_2a6e5316;
    self notify(#"hash_ea7d0979");
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x25c3e0fb, Offset: 0x1670
// Size: 0x94
function function_30223dca() {
    self endon(#"disconnect");
    wait 0.5;
    /#
        iprintlnbold("<dev string:x28>");
    #/
    wait 0.5;
    self.var_5f32df0c = level.round_number;
    self waittill(#"hash_5c51868d");
    /#
        iprintlnbold("<dev string:x4d>");
    #/
    self zm_stats::zero_client_stat("pers_perk_lose_counter", 0);
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xdb8a6008, Offset: 0x1710
// Size: 0xc4
function function_27be4a71() {
    self endon(#"disconnect");
    wait 0.5;
    /#
        iprintlnbold("<dev string:x73>");
    #/
    wait 0.5;
    while (true) {
        self waittill(#"hash_5e5bb250");
        accuracy = self namespace_25f8c2ad::function_eac49a00();
        if (accuracy > level.var_5d181faf) {
            break;
        }
    }
    /#
        iprintlnbold("<dev string:x9c>");
    #/
    self zm_stats::zero_client_stat("pers_pistol_points_counter", 0);
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x76dba4d3, Offset: 0x17e0
// Size: 0x84
function function_b8b4fcdb() {
    self endon(#"disconnect");
    wait 0.5;
    /#
        iprintlnbold("<dev string:xc6>");
    #/
    wait 0.5;
    self waittill(#"hash_b985df1d");
    /#
        iprintlnbold("<dev string:xef>");
    #/
    self zm_stats::zero_client_stat("pers_double_points_counter", 0);
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x881b71dd, Offset: 0x1870
// Size: 0x84
function function_729cf9db() {
    self endon(#"disconnect");
    wait 0.5;
    /#
        iprintlnbold("<dev string:x119>");
    #/
    wait 0.5;
    self waittill(#"hash_d83e52c6");
    /#
        iprintlnbold("<dev string:x13b>");
    #/
    self zm_stats::zero_client_stat("pers_sniper_counter", 0);
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0xac48035d, Offset: 0x1900
// Size: 0xe4
function function_f7fb14e2() {
    self endon(#"disconnect");
    wait 0.5;
    /#
        iprintlnbold("<dev string:x15e>");
    #/
    self thread namespace_25f8c2ad::function_85e94769();
    wait 0.5;
    self.var_bf349207 = 1;
    while (true) {
        level waittill(#"start_of_round");
        if (function_69f37d91()) {
            if (level.round_number >= level.var_21500b7f) {
                break;
            }
        }
    }
    /#
        iprintlnbold("<dev string:x184>");
    #/
    self zm_stats::zero_client_stat("pers_box_weapon_counter", 0);
}

// Namespace namespace_95add22b
// Params 0, eflags: 0x1 linked
// Checksum 0x5663f4, Offset: 0x19f0
// Size: 0xc4
function function_e69589a4() {
    self endon(#"disconnect");
    wait 0.5;
    /#
        iprintlnbold("<dev string:x1ab>");
    #/
    wait 0.5;
    while (true) {
        level waittill(#"start_of_round");
        if (function_69f37d91()) {
            if (level.round_number >= level.var_ea5b9bd9) {
                break;
            }
        }
    }
    /#
        iprintlnbold("<dev string:x1cb>");
    #/
    self zm_stats::zero_client_stat("pers_nube_counter", 0);
}

