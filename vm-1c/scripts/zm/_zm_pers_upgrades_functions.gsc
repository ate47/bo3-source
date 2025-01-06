#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/gametypes/_globallogic_score;

#namespace namespace_25f8c2ad;

// Namespace namespace_25f8c2ad
// Params 1, eflags: 0x0
// Checksum 0x3d20a2f7, Offset: 0x5b8
// Size: 0xd0
function function_66dcadff(zbarrier) {
    if (isdefined(level.var_a2fe812c) && level.var_a2fe812c) {
        if (namespace_95add22b::function_69f37d91()) {
            if (!(isdefined(self.var_698f7e["board"]) && self.var_698f7e["board"])) {
                if (level.round_number >= level.var_d81e1548) {
                    self zm_stats::increment_client_stat("pers_boarding", 0);
                    if (self.pers["pers_boarding"] >= level.var_e146cf60) {
                        if (isdefined(zbarrier)) {
                            self.var_8cc9518d = zbarrier.origin;
                        }
                    }
                }
            }
        }
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x941cb0d9, Offset: 0x690
// Size: 0x4c
function function_d3c7ee5c() {
    if (namespace_95add22b::function_69f37d91()) {
        if (isdefined(self.var_698f7e["revive"]) && self.var_698f7e["revive"]) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_25f8c2ad
// Params 1, eflags: 0x0
// Checksum 0x196263cd, Offset: 0x6e8
// Size: 0x3c
function function_9c80877a(reviver) {
    if (namespace_95add22b::function_69f37d91()) {
        reviver zm_stats::increment_client_stat("pers_revivenoperk", 0);
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x73181d76, Offset: 0x730
// Size: 0x58
function function_2f3a2d06() {
    if (namespace_95add22b::function_69f37d91()) {
        if (isdefined(self.var_698f7e["multikill_headshots"]) && isdefined(self.var_698f7e) && self.var_698f7e["multikill_headshots"]) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_25f8c2ad
// Params 2, eflags: 0x0
// Checksum 0xa80023f8, Offset: 0x790
// Size: 0xf0
function function_56da3688(time_of_death, zombie) {
    if (namespace_95add22b::function_69f37d91()) {
        if (self.pers["last_headshot_kill_time"] == time_of_death) {
            self.pers["zombies_multikilled"]++;
        } else {
            self.pers["zombies_multikilled"] = 1;
        }
        self.pers["last_headshot_kill_time"] = time_of_death;
        if (self.pers["zombies_multikilled"] == 2) {
            if (isdefined(zombie)) {
                self.var_8cc9518d = zombie.origin;
            }
            self zm_stats::increment_client_stat("pers_multikill_headshots", 0);
            self.var_937c6d27 = 0;
        }
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x38695c70, Offset: 0x888
// Size: 0xe4
function function_c7dbceb7() {
    if (namespace_95add22b::function_69f37d91()) {
        if (isdefined(level.var_bac53324) && level.var_bac53324) {
            if (isdefined(self.var_698f7e["cash_back"]) && self.var_698f7e["cash_back"]) {
                self thread function_eb301e4f();
                self thread function_7c2cb828(1);
                return;
            }
            if (self.pers["pers_cash_back_bought"] < level.var_db62f146) {
                self zm_stats::increment_client_stat("pers_cash_back_bought", 0);
                return;
            }
            self thread function_7c2cb828(0);
        }
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x2450f522, Offset: 0x978
// Size: 0x96
function function_eb301e4f() {
    self endon(#"death");
    step = 5;
    var_6dd78192 = int(level.var_82949e7a / step);
    for (i = 0; i < step; i++) {
        self zm_score::add_to_player_score(var_6dd78192);
        wait 0.2;
    }
}

// Namespace namespace_25f8c2ad
// Params 1, eflags: 0x0
// Checksum 0xbc04b666, Offset: 0xa18
// Size: 0xfa
function function_7c2cb828(var_9443d9e6) {
    self endon(#"death");
    var_3861f53 = 2.5;
    start_time = gettime();
    while (true) {
        time = gettime();
        dt = (time - start_time) / 1000;
        if (dt > var_3861f53) {
            break;
        }
        if (self getstance() == "prone") {
            if (!var_9443d9e6) {
                self zm_stats::increment_client_stat("pers_cash_back_prone", 0);
                wait 0.8;
            }
            return;
        }
        wait 0.01;
    }
    if (var_9443d9e6) {
        self notify(#"hash_56b30d01");
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0xd4785b08, Offset: 0xb20
// Size: 0x1ec
function function_a312b387() {
    if (isdefined(level.var_6e4e78c7) && level.var_6e4e78c7) {
        self endon(#"death");
        if (!namespace_95add22b::function_69f37d91()) {
            return;
        }
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            e_player = players[i];
            if (isdefined(e_player.var_698f7e["insta_kill"]) && e_player.var_698f7e["insta_kill"]) {
                e_player thread function_51f00958(level.var_2a6e5316);
            }
        }
        if (!(isdefined(self.var_698f7e["insta_kill"]) && self.var_698f7e["insta_kill"])) {
            var_75ca41c9 = self globallogic_score::getpersstat("kills");
            self waittill(#"insta_kill_over");
            var_c49a2012 = self globallogic_score::getpersstat("kills");
            var_96bc24b1 = var_c49a2012 - var_75ca41c9;
            if (var_96bc24b1 > 0) {
                self zm_stats::zero_client_stat("pers_insta_kill", 0);
                return;
            }
            self zm_stats::increment_client_stat("pers_insta_kill", 0);
        }
    }
}

// Namespace namespace_25f8c2ad
// Params 1, eflags: 0x0
// Checksum 0x9fba5898, Offset: 0xd18
// Size: 0x290
function function_51f00958(active_time) {
    self endon(#"death");
    wait 0.25;
    if (namespace_95add22b::function_4ab3f2ab()) {
        return;
    }
    self thread namespace_95add22b::function_8e30b6f3();
    start_time = gettime();
    var_febdfae9 = 50;
    var_12be6860 = 100;
    while (true) {
        time = gettime();
        dt = (time - start_time) / 1000;
        if (dt > active_time) {
            break;
        }
        if (!zm_powerups::is_insta_kill_active()) {
            break;
        }
        a_zombies = getaiteamarray(level.zombie_team);
        e_closest = undefined;
        for (i = 0; i < a_zombies.size; i++) {
            e_zombie = a_zombies[i];
            if (isdefined(e_zombie.marked_for_insta_upgraded_death)) {
                continue;
            }
            height_diff = abs(self.origin[2] - e_zombie.origin[2]);
            if (height_diff < var_12be6860) {
                dist = distance2d(self.origin, e_zombie.origin);
                if (dist < var_febdfae9) {
                    dist_max = dist;
                    e_closest = e_zombie;
                }
            }
        }
        if (isdefined(e_closest)) {
            e_closest.marked_for_insta_upgraded_death = 1;
            e_closest dodamage(e_closest.health + 666, e_closest.origin, self, self, "none", "MOD_PISTOL_BULLET", 0);
        }
        wait 0.01;
    }
}

// Namespace namespace_25f8c2ad
// Params 2, eflags: 0x0
// Checksum 0xc0cd28c1, Offset: 0xfb0
// Size: 0x88
function function_19d853ae(smeansofdeath, eattacker) {
    if (namespace_95add22b::function_69f37d91()) {
        if (isdefined(smeansofdeath) && smeansofdeath == "MOD_MELEE") {
            if (isplayer(self) && namespace_95add22b::function_4332a58a()) {
                self notify(#"hash_35c06a37");
                level.var_7b63c6af = eattacker;
            }
        }
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x70ea2180, Offset: 0x1040
// Size: 0x90
function function_3699cfb6() {
    if (isdefined(level.var_70e80676) && level.var_70e80676) {
        if (namespace_95add22b::function_69f37d91()) {
            if (!(isdefined(self.var_698f7e["jugg"]) && self.var_698f7e["jugg"])) {
                if (level.round_number <= level.var_34be9153) {
                    self zm_stats::increment_client_stat("pers_jugg", 0);
                    /#
                    #/
                }
            }
        }
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x1b6cc39a, Offset: 0x10d8
// Size: 0x58
function function_dadedde6() {
    if (namespace_95add22b::function_69f37d91()) {
        if (isdefined(self.var_698f7e["jugg"]) && isdefined(self.var_698f7e) && self.var_698f7e["jugg"]) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0xbea5d2eb, Offset: 0x1138
// Size: 0xf6
function function_b0f6b767() {
    if (!namespace_95add22b::function_69f37d91()) {
        return;
    }
    if (!isdefined(self.var_f9bb9c1f)) {
        self.var_f9bb9c1f = 0;
    }
    self.var_f9bb9c1f++;
    if (!(isdefined(self.var_698f7e["pistol_points"]) && self.var_698f7e["pistol_points"])) {
        if (self.var_f9bb9c1f >= level.var_a4afe255) {
            accuracy = self function_eac49a00();
            if (accuracy <= level.var_5d181faf) {
                self zm_stats::increment_client_stat("pers_pistol_points_counter", 0);
                /#
                    iprintlnbold("<dev string:x28>");
                #/
            }
        }
        return;
    }
    self notify(#"hash_5e5bb250");
}

// Namespace namespace_25f8c2ad
// Params 4, eflags: 0x0
// Checksum 0xb7fdd81, Offset: 0x1238
// Size: 0x10c
function function_e4398b36(score, event, mod, damage_weapon) {
    if (namespace_95add22b::function_69f37d91()) {
        if (isdefined(self.var_698f7e["pistol_points"]) && self.var_698f7e["pistol_points"]) {
            if (isdefined(event)) {
                if (event == "rebuild_board") {
                    return score;
                }
                if (isdefined(damage_weapon)) {
                    weapon_class = zm_utility::getweaponclasszm(damage_weapon);
                    if (weapon_class != "weapon_pistol") {
                        return score;
                    }
                }
                if (isdefined(mod) && isstring(mod) && mod == "MOD_PISTOL_BULLET") {
                    score *= 2;
                }
            }
        }
    }
    return score;
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x9317941b, Offset: 0x1350
// Size: 0x2e6
function function_bb9a6b2c() {
    self endon(#"death");
    self endon(#"disconnect");
    if (!namespace_95add22b::function_69f37d91()) {
        return;
    }
    if (isdefined(self.var_f8727a07) && self.var_f8727a07) {
        self.var_bd367d9e = gettime();
        return;
    }
    self.var_f8727a07 = 1;
    level.var_bd49be0c = 1;
    start_points = self.score;
    if (isdefined(self.var_cbe5509c)) {
        var_a2c87e80 = self.var_cbe5509c;
    } else {
        var_a2c87e80 = 0;
    }
    self.var_bd367d9e = gettime();
    var_17911606 = self.score;
    var_767aca76 = 0;
    while (true) {
        if (self.score > var_17911606) {
            var_767aca76 = 1;
        }
        var_17911606 = self.score;
        time = gettime();
        dt = (time - self.var_bd367d9e) / 1000;
        if (dt >= 30) {
            break;
        }
        wait 0.1;
    }
    level.var_bd49be0c = undefined;
    if (isdefined(self.var_cbe5509c)) {
        var_58a1ce53 = self.var_cbe5509c;
    } else {
        var_58a1ce53 = 0;
    }
    if (var_58a1ce53 < var_a2c87e80) {
        var_160e92c8 = var_a2c87e80 - var_58a1ce53;
        var_1831beb8 = level.var_5caba3af * var_160e92c8;
        var_49733d83 = level.var_b6882e02 * var_160e92c8;
        var_44d7dd9c = var_49733d83 - var_1831beb8;
    } else {
        var_44d7dd9c = 0;
    }
    if (isdefined(self.var_698f7e["double_points"]) && self.var_698f7e["double_points"]) {
        if (var_767aca76 == 1) {
            self notify(#"hash_b985df1d");
        }
    } else {
        total_points = self.score - start_points;
        total_points -= var_44d7dd9c;
        if (total_points >= level.var_2ce89398) {
            self zm_stats::increment_client_stat("pers_double_points_counter", 0);
            /#
                iprintlnbold("<dev string:x28>");
            #/
        }
    }
    self.var_f8727a07 = undefined;
}

// Namespace namespace_25f8c2ad
// Params 1, eflags: 0x0
// Checksum 0x28858f3b, Offset: 0x1640
// Size: 0x8c
function function_9b3073fc(score) {
    if (namespace_95add22b::function_69f37d91()) {
        if (isdefined(self.var_698f7e["double_points"]) && self.var_698f7e["double_points"]) {
            if (isdefined(level.var_bd49be0c) && level.var_bd49be0c) {
                /#
                #/
                score = int(score * 0.5);
            }
        }
    }
    return score;
}

// Namespace namespace_25f8c2ad
// Params 1, eflags: 0x0
// Checksum 0x322e48d9, Offset: 0x16d8
// Size: 0x74
function function_4ef410da(current_cost) {
    if (namespace_95add22b::function_69f37d91()) {
        if (isdefined(self.var_698f7e["double_points"]) && self.var_698f7e["double_points"]) {
            current_cost = int(current_cost / 2);
        }
    }
    return current_cost;
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0xa047c3e2, Offset: 0x1758
// Size: 0x4e
function function_dc08b4af() {
    if (isdefined(self.var_698f7e["double_points"]) && self.var_698f7e["double_points"]) {
        if (isdefined(level.var_bd49be0c) && level.var_bd49be0c) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x2dcc7969, Offset: 0x17b0
// Size: 0x13a
function function_1425fc15() {
    if (!namespace_95add22b::function_69f37d91()) {
        return;
    }
    wait 1;
    if (!(isdefined(self.var_698f7e["perk_lose"]) && self.var_698f7e["perk_lose"])) {
        if (level.round_number <= level.var_1d4251ad) {
            if (!isdefined(self.var_dde369de)) {
                a_perks = self zm_perks::get_perk_array();
                if (isdefined(a_perks) && a_perks.size == 4) {
                    self zm_stats::increment_client_stat("pers_perk_lose_counter", 0);
                    /#
                        iprintlnbold("<dev string:x48>");
                    #/
                    self.var_dde369de = 1;
                }
            }
        }
        return;
    }
    if (isdefined(self.var_5f32df0c)) {
        if (level.round_number > 1 && self.var_5f32df0c == level.round_number) {
            self notify(#"hash_5c51868d");
        }
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x882863b, Offset: 0x18f8
// Size: 0x14e
function function_b725835b() {
    if (namespace_95add22b::function_69f37d91()) {
        if (isdefined(self.perks_active)) {
            self.var_37207e8c = [];
            self.var_37207e8c = arraycopy(self.perks_active);
        } else {
            self.var_37207e8c = self zm_perks::get_perk_array();
        }
        self.var_b9e39295 = self getweaponslistprimaries();
        self.var_53b6d197 = [];
        index = 0;
        foreach (weapon in self.var_b9e39295) {
            self.var_53b6d197[index] = zm_weapons::get_player_weapondata(self, weapon);
            index++;
        }
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x9378c49d, Offset: 0x1a50
// Size: 0x302
function function_ac62adf2() {
    if (namespace_95add22b::function_69f37d91()) {
        var_c06c2a8e = 0;
        var_6fbdda06 = 0;
        if (isdefined(self.var_37207e8c) && self.var_37207e8c.size >= 2) {
            for (i = 0; i < self.var_37207e8c.size; i++) {
                perk = self.var_37207e8c[i];
                if (perk == "specialty_quickrevive") {
                    var_6fbdda06 = 1;
                }
            }
            if (var_6fbdda06 == 1) {
                size = self.var_37207e8c.size;
            } else {
                size = self.var_37207e8c.size - 1;
            }
            for (i = 0; i < size; i++) {
                perk = self.var_37207e8c[i];
                if (var_6fbdda06 == 1 && perk == "specialty_quickrevive") {
                    continue;
                }
                if (perk == "specialty_additionalprimaryweapon") {
                    var_c06c2a8e = 1;
                }
                if (self hasperk(perk)) {
                    continue;
                }
                self zm_perks::give_perk(perk);
                util::wait_network_frame();
            }
        }
        if (var_c06c2a8e) {
            var_9a43980a = self getweaponslistprimaries();
            for (i = 0; i < self.var_53b6d197.size; i++) {
                saved_weapon = self.var_53b6d197[i];
                found = 0;
                for (j = 0; j < var_9a43980a.size; j++) {
                    current_weapon = var_9a43980a[j];
                    if (current_weapon == saved_weapon["weapon"]) {
                        found = 1;
                        break;
                    }
                }
                if (found == 0) {
                    self zm_weapons::weapondata_give(self.var_53b6d197[i]);
                    self switchtoweapon(var_9a43980a[0]);
                    break;
                }
            }
        }
        self.var_37207e8c = undefined;
        self.var_b9e39295 = undefined;
        self.var_53b6d197 = undefined;
    }
}

// Namespace namespace_25f8c2ad
// Params 2, eflags: 0x0
// Checksum 0xeff16f5, Offset: 0x1d60
// Size: 0x1fc
function function_8d1310c0(zombie, attacker) {
    if (!namespace_95add22b::function_69f37d91()) {
        return;
    }
    if (!isdefined(zombie) || !isdefined(attacker)) {
        return;
    }
    if (isdefined(zombie.marked_for_insta_upgraded_death) && zombie.marked_for_insta_upgraded_death) {
        return;
    }
    weapon = zombie.damageweapon;
    if (weapon.issniperweapon) {
        return;
    }
    if (isdefined(self.var_698f7e["sniper"]) && self.var_698f7e["sniper"]) {
        self thread function_c055872c();
        return;
    }
    dist = distance(zombie.origin, attacker.origin);
    if (dist < level.var_441ad7ba) {
        return;
    }
    if (!isdefined(self.var_f1bc926c)) {
        self.var_f1bc926c = level.round_number;
        self.var_4355968f = 0;
    } else if (self.var_f1bc926c != level.round_number) {
        self.var_f1bc926c = level.round_number;
        self.var_4355968f = 0;
    }
    self.var_4355968f++;
    /#
        iprintlnbold("<dev string:x64>");
    #/
    if (self.var_4355968f >= level.var_98b6d77b) {
        self zm_stats::increment_client_stat("pers_sniper_counter", 0);
        /#
            iprintlnbold("<dev string:x81>");
        #/
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x4773f872, Offset: 0x1f68
// Size: 0xbe
function function_c055872c() {
    self endon(#"disconnect");
    self endon(#"death");
    if (namespace_95add22b::function_69f37d91()) {
        total_score = 300;
        steps = 10;
        var_30449d68 = int(total_score / steps);
        for (i = 0; i < steps; i++) {
            self zm_score::add_to_player_score(var_30449d68);
            wait 0.25;
        }
    }
}

// Namespace namespace_25f8c2ad
// Params 2, eflags: 0x0
// Checksum 0xadfc444a, Offset: 0x2030
// Size: 0xe0
function function_cec61a4d(weapon, hit) {
    if (!namespace_95add22b::function_69f37d91()) {
        return;
    }
    if (isdefined(weapon) && isdefined(hit)) {
        if (isdefined(self.var_698f7e["sniper"]) && self.var_698f7e["sniper"]) {
            if (weapon.issniperweapon) {
                if (!isdefined(self.var_5a6714aa)) {
                    self.var_5a6714aa = 0;
                }
                if (hit) {
                    self.var_5a6714aa = 0;
                    return;
                }
                self.var_5a6714aa++;
                if (self.var_5a6714aa >= level.var_4de1c840) {
                    self notify(#"hash_d83e52c6");
                    self.var_5a6714aa = 0;
                }
            }
        }
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x35ee9c67, Offset: 0x2118
// Size: 0x88
function function_eac49a00() {
    accuracy = 1;
    total_shots = self globallogic_score::getpersstat("total_shots");
    var_8302185e = self globallogic_score::getpersstat("hits");
    if (total_shots > 0) {
        accuracy = var_8302185e / total_shots;
    }
    return accuracy;
}

// Namespace namespace_25f8c2ad
// Params 2, eflags: 0x0
// Checksum 0xd361310f, Offset: 0x21a8
// Size: 0x160
function function_61be7933(e_user, e_grabber) {
    if (!namespace_95add22b::function_69f37d91()) {
        return;
    }
    if (level.round_number >= level.var_21500b7f) {
        return;
    }
    if (isdefined(e_grabber) && isplayer(e_grabber)) {
        if (isdefined(e_grabber.var_bf349207) && e_grabber.var_bf349207) {
            return;
        }
        if (isdefined(e_grabber.var_698f7e["box_weapon"]) && e_grabber.var_698f7e["box_weapon"]) {
            return;
        }
        e_grabber zm_stats::increment_client_stat("pers_box_weapon_counter", 0);
        /#
        #/
        return;
    }
    if (isdefined(e_user) && isplayer(e_user)) {
        if (isdefined(e_user.var_698f7e["box_weapon"]) && e_user.var_698f7e["box_weapon"]) {
            return;
        }
        e_user zm_stats::zero_client_stat("pers_box_weapon_counter", 0);
        /#
        #/
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x823a6610, Offset: 0x2310
// Size: 0x384
function function_85e94769() {
    self endon(#"disconnect");
    if (isdefined(level.var_8aa76743) && level.var_8aa76743) {
        self thread function_8aa76743();
    }
    var_61bb264b = spawn("script_model", self.origin);
    var_61bb264b setmodel(level.chest_joker_model);
    var_61bb264b function_bc64f9a1(level.chest_index);
    self.var_4db55a5c = var_61bb264b;
    var_61bb264b setinvisibletoall();
    wait 0.1;
    var_61bb264b setvisibletoplayer(self);
    while (true) {
        box = level.chests[level.chest_index];
        if (level.round_number >= level.var_21500b7f) {
            break;
        }
        if (namespace_95add22b::function_4ab3f2ab()) {
            var_61bb264b setinvisibletoall();
            while (true) {
                if (!namespace_95add22b::function_4ab3f2ab()) {
                    break;
                }
                wait 0.01;
            }
            var_61bb264b setvisibletoplayer(self);
        }
        if (level flag::get("moving_chest_now")) {
            var_61bb264b setinvisibletoall();
            while (level flag::get("moving_chest_now")) {
                wait 0.1;
            }
            var_61bb264b function_bc64f9a1(level.chest_index);
            wait 0.1;
            var_61bb264b setvisibletoplayer(self);
        }
        if (isdefined(level.var_c23d93ae) && level.var_c23d93ae) {
            var_61bb264b setinvisibletoall();
            while (isdefined(level.var_c23d93ae) && level.var_c23d93ae) {
                wait 0.1;
            }
            var_61bb264b function_bc64f9a1(level.chest_index);
            wait 0.1;
            var_61bb264b setvisibletoplayer(self);
        }
        if (isdefined(box._box_open) && box._box_open) {
            var_61bb264b setinvisibletoall();
            while (true) {
                if (!(isdefined(box._box_open) && box._box_open)) {
                    break;
                }
                wait 0.01;
            }
            var_61bb264b setvisibletoplayer(self);
        }
        wait 0.01;
    }
    var_61bb264b delete();
}

// Namespace namespace_25f8c2ad
// Params 1, eflags: 0x0
// Checksum 0x5be8f21e, Offset: 0x26a0
// Size: 0x170
function function_bc64f9a1(var_902e3799) {
    box = level.chests[var_902e3799];
    if (isdefined(box.zbarrier)) {
        v_origin = box.zbarrier.origin;
        v_angles = box.zbarrier.angles;
    } else {
        v_origin = box.origin;
        v_angles = box.angles;
    }
    v_up = anglestoup(v_angles);
    height_offset = 22;
    self.origin = v_origin + v_up * height_offset;
    dp = vectordot(v_up, (0, 0, 1));
    if (dp > 0) {
        var_f5ca3a62 = (0, 90, 0);
    } else {
        var_f5ca3a62 = (0, -90, -10);
    }
    self.angles = v_angles + var_f5ca3a62;
}

// Namespace namespace_25f8c2ad
// Params 1, eflags: 0x0
// Checksum 0x68bdf7f3, Offset: 0x2818
// Size: 0x256
function function_ef89461c(player) {
    var_612f807a = randomfloat(1);
    if (!isdefined(player.var_2d6526b6)) {
        player.var_2d6526b6 = 0;
    }
    if (player.var_2d6526b6 == 0 || player.var_2d6526b6 < 2 && var_612f807a < 0.6) {
        /#
        #/
        player.var_2d6526b6++;
        if (isdefined(level.var_680950f5)) {
            [[ level.var_680950f5 ]]();
        } else {
            function_7f93d5d8();
        }
        keys = array::randomize(level.var_cfff4e41);
        /#
            forced_weapon_name = getdvarstring("<dev string:x9a>");
            forced_weapon = getweapon(forced_weapon_name);
            if (forced_weapon_name != "<dev string:xab>" && isdefined(level.zombie_weapons[getweapon(forced_weapon)])) {
                arrayinsert(keys, forced_weapon, 0);
            }
        #/
        var_10f9c82c = zm_pap_util::function_f925b7b9();
        for (i = 0; i < keys.size; i++) {
            if (zm_magicbox::function_9821da97(player, keys[i], var_10f9c82c)) {
                return keys[i];
            }
        }
        return keys[0];
    }
    /#
    #/
    player.var_2d6526b6 = 0;
    weapon = zm_magicbox::function_f4e72416(player);
    return weapon;
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0xee7bd16f, Offset: 0x2a78
// Size: 0x10e
function function_7f93d5d8() {
    if (!isdefined(level.var_cfff4e41)) {
        level.var_cfff4e41 = [];
        level.var_cfff4e41[level.var_cfff4e41.size] = getweapon("ray_gun");
        level.var_cfff4e41[level.var_cfff4e41.size] = getweapon("knife_ballistic");
        level.var_cfff4e41[level.var_cfff4e41.size] = getweapon("srm1216");
        level.var_cfff4e41[level.var_cfff4e41.size] = getweapon("hamr");
        level.var_cfff4e41[level.var_cfff4e41.size] = getweapon("tar21");
        level.var_cfff4e41[level.var_cfff4e41.size] = getweapon("raygun_mark2");
    }
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x12118b3a, Offset: 0x2b90
// Size: 0x10c
function function_8aa76743() {
    self endon(#"disconnect");
    wait 1;
    while (true) {
        if (level.zombie_vars["zombie_powerup_fire_sale_on"] == 1) {
            wait 5;
            for (i = 0; i < level.chests.size; i++) {
                if (i == level.chest_index) {
                    continue;
                }
                box = level.chests[i];
                self thread function_dd713e62(box, i);
            }
            while (true) {
                if (level.zombie_vars["zombie_powerup_fire_sale_on"] == 0) {
                    break;
                }
                wait 0.01;
            }
        }
        if (level.round_number >= level.var_21500b7f) {
            return;
        }
        wait 0.5;
    }
}

// Namespace namespace_25f8c2ad
// Params 2, eflags: 0x0
// Checksum 0x76d6dbe7, Offset: 0x2ca8
// Size: 0x194
function function_dd713e62(box, var_902e3799) {
    self endon(#"disconnect");
    var_61bb264b = spawn("script_model", self.origin);
    var_61bb264b setmodel(level.chest_joker_model);
    var_61bb264b function_bc64f9a1(var_902e3799);
    var_61bb264b setinvisibletoall();
    wait 0.1;
    var_61bb264b setvisibletoplayer(self);
    while (true) {
        if (isdefined(box._box_open) && box._box_open) {
            var_61bb264b setinvisibletoall();
            while (true) {
                if (!(isdefined(box._box_open) && box._box_open)) {
                    break;
                }
                wait 0.01;
            }
            var_61bb264b setvisibletoplayer(self);
        }
        if (level.zombie_vars["zombie_powerup_fire_sale_on"] == 0) {
            break;
        }
        wait 0.01;
    }
    var_61bb264b delete();
}

// Namespace namespace_25f8c2ad
// Params 0, eflags: 0x0
// Checksum 0x5e63d1dc, Offset: 0x2e48
// Size: 0x1aa
function function_830c8552() {
    self endon(#"disconnect");
    if (!namespace_95add22b::function_69f37d91()) {
        return;
    }
    self.var_cca71f51 = 0;
    if (self.pers["pers_max_round_reached"] >= level.var_ea5b9bd9) {
        return;
    }
    var_3a09f6d0 = self.pers["melee_kills"];
    var_623ffa82 = self.pers["headshots"];
    for (var_947d2805 = self.pers["boards"]; true; var_947d2805 = self.pers["boards"]) {
        self waittill(#"hash_6d159f37");
        if (self.pers["pers_max_round_reached"] >= level.var_ea5b9bd9) {
            self.var_cca71f51 = 0;
            return;
        }
        if (var_3a09f6d0 == self.pers["melee_kills"] && var_623ffa82 == self.pers["headshots"] && var_947d2805 == self.pers["boards"]) {
            self.var_cca71f51++;
            continue;
        }
        self.var_cca71f51 = 0;
        var_3a09f6d0 = self.pers["melee_kills"];
        var_623ffa82 = self.pers["headshots"];
    }
}

// Namespace namespace_25f8c2ad
// Params 1, eflags: 0x0
// Checksum 0x97492683, Offset: 0x3000
// Size: 0x30
function function_50235f20(player) {
    if (player.var_cca71f51 >= level.var_8d9746cc) {
        return true;
    }
    return false;
}

// Namespace namespace_25f8c2ad
// Params 2, eflags: 0x0
// Checksum 0x1adfc5cc, Offset: 0x3038
// Size: 0x1ac
function function_11390813(player, weapon) {
    if (namespace_95add22b::function_69f37d91()) {
        if (weapon.name == "rottweil72") {
            if (!(isdefined(player.var_698f7e["nube"]) && player.var_698f7e["nube"])) {
                if (function_50235f20(player)) {
                    player zm_stats::increment_client_stat("pers_nube_counter", 0);
                    weapon = getweapon("ray_gun");
                    fx_org = player.origin;
                    v_dir = anglestoforward(player getplayerangles());
                    v_up = anglestoup(player getplayerangles());
                    fx_org = fx_org + v_dir * 5 + v_up * 12;
                    player.var_8cc9518d = fx_org;
                }
            } else {
                weapon = getweapon("ray_gun");
            }
        }
    }
    return weapon;
}

// Namespace namespace_25f8c2ad
// Params 2, eflags: 0x0
// Checksum 0xb072dd19, Offset: 0x31f0
// Size: 0x134
function function_8c231229(player, weapon) {
    if (namespace_95add22b::function_69f37d91()) {
        if (weapon.name == "rottweil72") {
            if (isdefined(player.var_698f7e["nube"]) && player.var_698f7e["nube"]) {
                var_1fc5e233 = getweapon("ray_gun");
                if (player hasweapon(var_1fc5e233)) {
                    weapon = getweapon(var_1fc5e233);
                }
                var_fd2f2ee6 = getweapon("ray_gun_upgraded");
                if (player hasweapon(var_fd2f2ee6)) {
                    weapon = getweapon(var_fd2f2ee6);
                }
            }
        }
    }
    return weapon;
}

// Namespace namespace_25f8c2ad
// Params 3, eflags: 0x0
// Checksum 0xf703b58e, Offset: 0x3330
// Size: 0x212
function function_e8007b34(player_has_weapon, player, var_3e5a7880) {
    if (!namespace_95add22b::function_69f37d91()) {
        return player_has_weapon;
    }
    if (player.pers["pers_max_round_reached"] >= level.var_ea5b9bd9) {
        return player_has_weapon;
    }
    if (!function_50235f20(player)) {
        return player_has_weapon;
    }
    rottweil_weapon = getweapon("rottweil72");
    if (var_3e5a7880 != rottweil_weapon) {
        return player_has_weapon;
    }
    var_5cc59155 = player hasweapon(rottweil_weapon) || player hasweapon(getweapon("rottweil72_upgraded"));
    var_a28473c4 = player hasweapon(getweapon("ray_gun")) || player hasweapon(getweapon("ray_gun_upgraded"));
    if (var_5cc59155 && var_a28473c4) {
        player_has_weapon = 1;
    } else if (function_50235f20(player) && var_5cc59155 && var_a28473c4 == 0) {
        player_has_weapon = 0;
    } else if (isdefined(player.var_698f7e["nube"]) && player.var_698f7e["nube"] && var_a28473c4) {
        player_has_weapon = 1;
    }
    return player_has_weapon;
}

// Namespace namespace_25f8c2ad
// Params 2, eflags: 0x0
// Checksum 0x8eb67f56, Offset: 0x3550
// Size: 0xc0
function function_6ddeae49(player, weapon) {
    ammo_cost = 0;
    if (!namespace_95add22b::function_69f37d91()) {
        return false;
    }
    if (weapon.name == "rottweil72") {
        ammo_cost = function_57dde7c7(player, ammo_cost);
    }
    if (!ammo_cost) {
        return false;
    }
    self.stub.hint_string = %ZOMBIE_WEAPONAMMOONLY;
    self sethintstring(self.stub.hint_string, ammo_cost);
    return true;
}

// Namespace namespace_25f8c2ad
// Params 2, eflags: 0x0
// Checksum 0x4db33991, Offset: 0x3618
// Size: 0x84
function function_57dde7c7(player, ammo_cost) {
    if (player hasweapon(getweapon("ray_gun"))) {
        ammo_cost = -6;
    }
    if (player hasweapon(getweapon("ray_gun_upgraded"))) {
        ammo_cost = 4500;
    }
    return ammo_cost;
}

// Namespace namespace_25f8c2ad
// Params 3, eflags: 0x0
// Checksum 0xedb0966e, Offset: 0x36a8
// Size: 0x74
function function_3c5b1e58(player, weapon, ammo_cost) {
    if (!namespace_95add22b::function_69f37d91()) {
        return ammo_cost;
    }
    if (weapon.name == "rottweil72") {
        ammo_cost = function_57dde7c7(player, ammo_cost);
    }
    return ammo_cost;
}

