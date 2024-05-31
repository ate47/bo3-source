#using scripts/cp/_accolades;
#using scripts/shared/trigger_shared;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/util_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_f25bd8c8;

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xc11546be, Offset: 0x528
// Size: 0x20a
function function_66df416f() {
    accolades::register("MISSION_INFECTION_UNTOUCHED");
    accolades::register("MISSION_INFECTION_SCORE");
    accolades::register("MISSION_INFECTION_COLLECTIBLE");
    accolades::register("MISSION_INFECTION_CHALLENGE3", "ch03_quick_kills_complete");
    accolades::register("MISSION_INFECTION_CHALLENGE4", "ch04_theia_battle_no_damage_completed");
    accolades::register("MISSION_INFECTION_HATTRICK", "ch05_helmet_shot");
    accolades::register("MISSION_INFECTION_CHALLENGE6", "ch06_mg42_kill");
    accolades::register("MISSION_INFECTION_CHALLENGE9", "ch09_wolf_midair_kills_granted");
    accolades::register("MISSION_INFECTION_CHALLENGE10", "ch10_wolf_melee_granted");
    accolades::register("MISSION_INFECTION_CHALLENGE11", "ch11_wolf_bite_granted");
    accolades::register("MISSION_INFECTION_CHALLENGE12", "ch12_tank_killer_granted");
    accolades::register("MISSION_INFECTION_CHALLENGE14", "ch14_cathedral_untouchable_grant");
    accolades::register("MISSION_INFECTION_CHALLENGE15", "ch15_zombies_untouchable_grant");
    accolades::register("MISSION_INFECTION_CHALLENGE16", "ch16_zombie_bonfire");
    accolades::register("MISSION_INFECTION_CHALLENGE17", "ch17_confirmed_hit");
    accolades::register("MISSION_INFECTION_CHALLENGE18", "ch18_sarah_grenaded");
    callback::on_connect(&on_player_connect);
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x54b93aa4, Offset: 0x740
// Size: 0x12
function on_player_connect() {
    self function_804e65bb();
}

// Namespace namespace_f25bd8c8
// Params 3, eflags: 0x0
// Checksum 0xbfaad7ee, Offset: 0x760
// Size: 0x2d
function function_5a97e5bd(var_8e087689, e_player, var_70b01bd3) {
    e_player notify(var_8e087689);
    if (isdefined(var_70b01bd3)) {
        [[ var_70b01bd3 ]]();
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x5e4cf9ab, Offset: 0x798
// Size: 0x32
function function_804e65bb() {
    self.var_be5d3b1b = 0;
    self.var_9ac129fc = 0;
    callback::on_actor_killed(&function_ba00a6fc);
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x3e72f9a6, Offset: 0x7d8
// Size: 0x9a
function function_346b87d1() {
    n_count = 0;
    foreach (player in level.activeplayers) {
        if (player.var_be5d3b1b) {
            n_count++;
        }
    }
    if (n_count == level.activeplayers.size) {
        callback::remove_on_actor_killed(&function_ba00a6fc);
    }
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0x85b08863, Offset: 0x880
// Size: 0x12a
function function_ba00a6fc(params) {
    if (isplayer(params.eattacker)) {
        var_e546abd0 = params.eattacker;
        if (!var_e546abd0.var_be5d3b1b) {
            if (!isdefined(var_e546abd0.var_a952433c)) {
                var_e546abd0.var_a952433c = [];
            }
            array::push(var_e546abd0.var_a952433c, gettime(), 0);
            if (var_e546abd0.var_a952433c.size > 5) {
                arrayremoveindex(var_e546abd0.var_a952433c, 5, 0);
            }
            var_2e019997 = var_e546abd0.var_a952433c[0];
            var_c96d3593 = var_e546abd0.var_a952433c[4];
            if (isdefined(var_c96d3593)) {
                n_time_delta = var_2e019997 - var_c96d3593;
                if (n_time_delta < 10000) {
                    var_e546abd0.var_be5d3b1b = 1;
                    function_5a97e5bd("ch03_quick_kills_complete", var_e546abd0, &function_346b87d1);
                }
            }
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xd909aa8c, Offset: 0x9b8
// Size: 0x2a
function function_ad15914d() {
    self.var_6385535e = 1;
    self thread function_9d23c86c();
    self thread function_6427aa57();
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xef0f5080, Offset: 0x9f0
// Size: 0x32
function function_6427aa57() {
    self endon(#"death");
    level waittill(#"hash_1d7591db");
    if (self.var_6385535e) {
        function_5a97e5bd("ch04_theia_battle_no_damage_completed", self);
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x33d22381, Offset: 0xa30
// Size: 0x3e
function function_9d23c86c() {
    level endon(#"hash_1d7591db");
    self endon(#"death");
    damage, attacker = self waittill(#"damage");
    if (isdefined(attacker)) {
        self.var_6385535e = 0;
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x703b6466, Offset: 0xa78
// Size: 0x22
function function_15b29a5a() {
    callback::on_actor_killed(&function_918d0428);
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0x7de13714, Offset: 0xaa8
// Size: 0x7e
function function_918d0428(params) {
    if (params.eattacker.classname == "player") {
        if (destructserverutils::getpiececount(self) >= 1 && destructserverutils::isdestructed(self, 1) && !function_3dc86a1(params)) {
            params.eattacker notify(#"hash_8cd8aeae");
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xdce46e04, Offset: 0xb30
// Size: 0x22
function function_ecd2ed4() {
    callback::remove_on_actor_killed(&function_918d0428);
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x519bac18, Offset: 0xb60
// Size: 0x22
function function_c081e535() {
    callback::on_actor_killed(&function_e7e68fa2);
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0xcd043e7, Offset: 0xb90
// Size: 0x72
function function_e7e68fa2(params) {
    if (params.eattacker.classname == "player" && params.eattacker.team !== self.team) {
        if (params.weapon.name == "turret_bo3_germans") {
            params.eattacker notify(#"hash_f8f73c2a");
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xdacaabbc, Offset: 0xc10
// Size: 0x22
function function_a0f567cb() {
    callback::remove_on_actor_killed(&function_e7e68fa2);
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x2b8c1072, Offset: 0xc40
// Size: 0x42
function function_341d8f7a() {
    callback::on_ai_killed(&function_423d8d8c);
    callback::on_ai_spawned(&function_21f98ad9);
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0x4fbf4f4d, Offset: 0xc90
// Size: 0x70
function function_423d8d8c(params) {
    if (self.archetype == "direwolf") {
        if (isplayer(params.eattacker)) {
            player = params.eattacker;
            if (isdefined(self.var_e91cc22f) && self.var_e91cc22f) {
                player notify(#"hash_115383d3");
            }
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x933becfe, Offset: 0xd08
// Size: 0x22
function function_21f98ad9() {
    if (self.archetype === "direwolf") {
        self thread function_a12f3181();
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xc456167e, Offset: 0xd38
// Size: 0x49
function function_a12f3181() {
    self endon(#"death");
    level endon(#"hash_f07948a5");
    self.var_e91cc22f = 0;
    while (true) {
        self waittill(#"hash_e27de0db");
        self.var_e91cc22f = 1;
        self waittill(#"hash_8b0841b8");
        self.var_e91cc22f = 0;
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x9b50f2ea, Offset: 0xd90
// Size: 0x42
function function_a2179c84() {
    callback::remove_on_ai_killed(&function_423d8d8c);
    callback::remove_on_ai_spawned(&function_21f98ad9);
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xe985324c, Offset: 0xde0
// Size: 0xab
function function_8c0b0cd0() {
    callback::on_ai_killed(&function_20c5379e);
    callback::on_spawned(&function_b59240f2);
    foreach (player in level.activeplayers) {
        player.var_63b33b24 = 0;
        player.var_a1930cfd = 1;
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x8dd886c, Offset: 0xe98
// Size: 0x12
function function_b59240f2() {
    self.var_63b33b24 = 0;
    self.var_a1930cfd = 1;
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0x433aeb50, Offset: 0xeb8
// Size: 0x8a
function function_20c5379e(params) {
    if (self.archetype == "direwolf") {
        if (isplayer(params.eattacker)) {
            params.eattacker.var_63b33b24 += 1;
            if (!function_3dc86a1(params)) {
                params.eattacker.var_a1930cfd = 0;
            }
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0xf34108cf, Offset: 0xf50
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

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x7ab4f9d5, Offset: 0xff0
// Size: 0xb5
function function_74b401d8() {
    callback::remove_on_ai_killed(&function_20c5379e);
    callback::remove_on_spawned(&function_b59240f2);
    foreach (player in level.activeplayers) {
        if (player.var_a1930cfd && player.var_63b33b24 > 0) {
            player notify(#"hash_a4d9772b");
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x359d2f50, Offset: 0x10b0
// Size: 0x9f
function function_aea367c1() {
    callback::on_player_damage(&function_d9aaed7d);
    callback::on_spawned(&function_6bc56950);
    foreach (player in level.activeplayers) {
        player.var_1bece4df = 1;
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x48cd2392, Offset: 0x1158
// Size: 0xa
function function_6bc56950() {
    self.var_1bece4df = 1;
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x2427434e, Offset: 0x1170
// Size: 0xc1
function function_d9aaed7d() {
    self endon(#"death");
    self endon(#"hash_f07948a5");
    self endon(#"hash_c0e469ca");
    while (true) {
        damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags = self waittill(#"damage");
        if (attacker.archetype === "direwolf") {
            if (isplayer(self)) {
                self.var_1bece4df = 0;
            }
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x520c7089, Offset: 0x1240
// Size: 0xb5
function function_b3cf52bf() {
    callback::remove_on_player_damage(&function_d9aaed7d);
    callback::remove_on_spawned(&function_6bc56950);
    foreach (player in level.activeplayers) {
        if (player.var_1bece4df && player.var_63b33b24 > 0) {
            player notify(#"hash_c0e469ca");
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x9dae1a22, Offset: 0x1300
// Size: 0x36
function function_7356f9fd() {
    self endon(#"death");
    self.var_b42f169e = 0;
    self thread function_2c3b4c78();
    self waittill(#"weapon_fired");
    self.var_b42f169e = 1;
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xbbfad6f7, Offset: 0x1340
// Size: 0x79
function function_2c3b4c78() {
    self waittill(#"death");
    if (isdefined(self)) {
        if (self.var_b42f169e == 0) {
            foreach (player in level.activeplayers) {
                player notify(#"hash_6182e6ea");
            }
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xdc695d62, Offset: 0x13c8
// Size: 0x7f
function function_211b07c5() {
    callback::on_player_damage(&function_9f9141fd);
    foreach (player in level.activeplayers) {
        player.var_a400c99f = 1;
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x4f69803f, Offset: 0x1450
// Size: 0x1e
function function_9f9141fd() {
    self endon(#"death");
    self waittill(#"damage");
    self.var_a400c99f = 0;
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x5856b04, Offset: 0x1478
// Size: 0x89
function function_2c8ffdaf() {
    callback::remove_on_player_damage(&function_9f9141fd);
    foreach (player in level.activeplayers) {
        if (player.var_a400c99f) {
            player notify(#"hash_de1125ba");
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xf9bb3cc7, Offset: 0x1510
// Size: 0x73
function function_6c777c8d() {
    foreach (player in level.activeplayers) {
        player.var_1cd562c7 = 1;
        player thread function_335ecd05();
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xbce969bb, Offset: 0x1590
// Size: 0x26
function function_335ecd05() {
    self endon(#"death");
    self endon(#"hash_f0f63627");
    self waittill(#"damage");
    self.var_1cd562c7 = 0;
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x26d706ec, Offset: 0x15c0
// Size: 0x69
function function_e9c21474() {
    foreach (player in level.activeplayers) {
        if (player.var_1cd562c7 === 1) {
            player notify(#"hash_c708c742");
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xa2d6293c, Offset: 0x1638
// Size: 0x9f
function function_a0fb8ca9() {
    callback::on_ai_killed(&function_98c5c5a1);
    callback::on_spawned(&function_7eac16b1);
    foreach (player in level.activeplayers) {
        player.var_abed6924 = 0;
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xc3e360f2, Offset: 0x16e0
// Size: 0xa
function function_7eac16b1() {
    self.var_abed6924 = 0;
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0x8d161564, Offset: 0x16f8
// Size: 0x72
function function_98c5c5a1(params) {
    if (self.archetype === "zombie" && isplayer(params.eattacker) && self.var_e069c441 === 1) {
        params.eattacker.var_abed6924 += 1;
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xb9d4cdfe, Offset: 0x1778
// Size: 0xa9
function function_bbb224b7() {
    callback::remove_on_ai_killed(&function_98c5c5a1);
    callback::remove_on_spawned(&function_7eac16b1);
    foreach (player in level.activeplayers) {
        if (player.var_abed6924 >= 4) {
            player notify(#"hash_a5e46a2e");
        }
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0xbd46bbdc, Offset: 0x1830
// Size: 0xa2
function function_70cafec1() {
    foreach (player in level.activeplayers) {
        player function_f6215929();
    }
    callback::on_spawned(&function_f6215929);
    callback::on_ai_killed(&function_7dfda27d);
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x85088839, Offset: 0x18e0
// Size: 0xa
function function_f6215929() {
    self.var_5bfcdcf4 = 0;
}

// Namespace namespace_f25bd8c8
// Params 1, eflags: 0x0
// Checksum 0xd880f418, Offset: 0x18f8
// Size: 0xbe
function function_7dfda27d(params) {
    if (params.eattacker.classname == "player") {
        if (params.shitloc == "head" || params.shitloc == "helmet" || params.shitloc == "neck") {
            params.eattacker.var_5bfcdcf4++;
            if (params.eattacker.var_5bfcdcf4 >= 10) {
                params.eattacker notify(#"hash_f9d95f8c");
            }
            return;
        }
        params.eattacker.var_5bfcdcf4 = 0;
    }
}

// Namespace namespace_f25bd8c8
// Params 0, eflags: 0x0
// Checksum 0x4f5abf3d, Offset: 0x19c0
// Size: 0x5d
function function_cce60169() {
    foreach (player in level.activeplayers) {
        player notify(#"hash_98743ed4");
    }
}

