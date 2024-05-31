#using scripts/cp/_accolades;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_b5b83650;

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_4d39a2af
// Checksum 0x345984b, Offset: 0x5b0
// Size: 0x294
function function_4d39a2af() {
    accolades::register("MISSION_AQUIFER_UNTOUCHED");
    accolades::register("MISSION_AQUIFER_SCORE");
    accolades::register("MISSION_AQUIFER_COLLECTIBLE");
    accolades::register("MISSION_AQUIFER_CHALLENGE3", "aq_thirty_kill_vtol");
    accolades::register("MISSION_AQUIFER_CHALLENGE4", "aq_three_hunters_vtol");
    accolades::register("MISSION_AQUIFER_CHALLENGE5", "aq_quads_only_guns");
    accolades::register("MISSION_AQUIFER_CHALLENGE6", "aq_threefer_missile");
    accolades::register("MISSION_AQUIFER_CHALLENGE7", "aq_six_under_two");
    accolades::register("MISSION_AQUIFER_CHALLENGE9", "aq_zero_damage_defenses");
    accolades::register("MISSION_AQUIFER_CHALLENGE10", "aq_tnt");
    accolades::register("MISSION_AQUIFER_CHALLENGE11", "aq_defend_egyptians");
    accolades::register("MISSION_AQUIFER_CHALLENGE12", "aq_vtol_drop_block");
    accolades::register("MISSION_AQUIFER_CHALLENGE13", "aq_dogfight_kill_only_guns");
    accolades::register("MISSION_AQUIFER_CHALLENGE14", "aq_boss_zero_damage");
    accolades::register("MISSION_AQUIFER_CHALLENGE15", "aq_boss_cybercore_only");
    level.var_bb70984c = [];
    level.var_bb70984c["aq_thirty_kill_vtol"] = 90;
    level.var_bb70984c["aq_three_hunters_vtol"] = 7;
    level.var_bb70984c["aq_dogfight_kill_only_guns"] = 8;
    level.var_bb70984c["aq_threefer_missile"] = 1;
    level.var_bb70984c["aq_vtol_drop_block"] = 5;
    level.var_bb70984c["aq_tnt"] = 15;
    level.var_bb70984c["aq_defend_egyptians"] = 45;
    thread function_89f596d9();
}

// Namespace namespace_b5b83650
// Params 3, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_c27610f9
// Checksum 0x401b6c66, Offset: 0x850
// Size: 0x1ea
function function_c27610f9(var_8e087689, var_70b01bd3, var_513753b4) {
    if (!isdefined(var_513753b4)) {
        var_513753b4 = 1;
    }
    if (!isdefined(var_8e087689)) {
        var_8e087689 = "dummy";
    }
    if (!isdefined(level.var_bb70984c[var_8e087689])) {
        level.var_bb70984c[var_8e087689] = 1;
    }
    player = self;
    players = [];
    if (self == level) {
        players = level.activeplayers;
    } else {
        players[players.size] = self;
    }
    foreach (player in players) {
        if (!isdefined(player.var_ec496e8b)) {
            player.var_ec496e8b = [];
        }
        if (!isdefined(player.var_ec496e8b[var_8e087689])) {
            player.var_ec496e8b[var_8e087689] = 0;
        }
        player.var_ec496e8b[var_8e087689]++;
        player notify(var_8e087689);
        /#
            iprintln("MISSION_AQUIFER_CHALLENGE5" + var_8e087689 + "MISSION_AQUIFER_CHALLENGE5" + player.var_ec496e8b[var_8e087689] + "MISSION_AQUIFER_CHALLENGE5" + level.var_bb70984c[var_8e087689]);
        #/
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_89f596d9
// Checksum 0xefe3eef1, Offset: 0xa48
// Size: 0x104
function function_89f596d9() {
    callback::on_ai_killed(&function_eab778af);
    thread function_a8831ac1();
    thread function_f208dfd8();
    callback::on_ai_killed(&function_e3e41d63);
    callback::on_ai_killed(&function_c7122e75);
    callback::on_ai_killed(&function_171499d7);
    callback::on_ai_killed(&function_6be65617);
    callback::on_vehicle_killed(&function_9cda9485);
    thread function_dcb19e2a();
    thread function_f42b5fa1();
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_171499d7
// Checksum 0x776ce5c8, Offset: 0xb58
// Size: 0x94
function function_171499d7(params) {
    if (isplayer(params.eattacker) && !isvehicle(self)) {
        if (params.einflictor.targetname === "destructible") {
            params.eattacker accolades::increment("MISSION_AQUIFER_CHALLENGE10");
        }
    }
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_6be65617
// Checksum 0x9ba0cad6, Offset: 0xbf8
// Size: 0x11c
function function_6be65617(params) {
    if (level flag::get("destroy_defenses2_completed")) {
        callback::remove_on_ai_killed(&function_6be65617);
        return;
    }
    if (isplayer(params.eattacker) && !isvehicle(self) && level flag::get("destroy_defenses2")) {
        if (isdefined(params.eattacker.var_8fedf36c) && params.eattacker islinkedto(params.eattacker.var_8fedf36c)) {
            params.eattacker accolades::increment("MISSION_AQUIFER_CHALLENGE11");
        }
    }
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_c7122e75
// Checksum 0xb373ec4c, Offset: 0xd20
// Size: 0xdc
function function_c7122e75(params) {
    if (isplayer(params.eattacker) && !isvehicle(self) && self.team !== "allies") {
        if (isdefined(params.eattacker.var_8fedf36c) && params.eattacker islinkedto(params.eattacker.var_8fedf36c)) {
            params.eattacker function_c27610f9("aq_thirty_kill_vtol", &function_b49b24ca);
        }
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_b49b24ca
// Checksum 0x925ae9db, Offset: 0xe08
// Size: 0x24
function function_b49b24ca() {
    callback::remove_on_ai_killed(&function_c7122e75);
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_9cda9485
// Checksum 0x48b513c7, Offset: 0xe38
// Size: 0xcc
function function_9cda9485(params) {
    if (isplayer(params.eattacker) && isdefined(self.archetype) && self.archetype == "hunter") {
        if (isdefined(params.eattacker.var_8fedf36c) && params.eattacker islinkedto(params.eattacker.var_8fedf36c)) {
            params.eattacker function_c27610f9("aq_three_hunters_vtol", &function_ff25056a);
        }
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_ff25056a
// Checksum 0x89a459a0, Offset: 0xf10
// Size: 0x24
function function_ff25056a() {
    callback::remove_on_vehicle_killed(&function_9cda9485);
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_a8831ac1
// Checksum 0xd61d6b35, Offset: 0xf40
// Size: 0x94
function function_a8831ac1() {
    callback::on_vehicle_killed(&function_5ae2cb8a);
    level.var_67a0c1e2 = 0;
    flag::wait_till("destroy_defenses2_completed");
    if (level.var_67a0c1e2 == 0) {
        level function_c27610f9("aq_quads_only_guns");
    }
    callback::remove_on_vehicle_killed(&function_5ae2cb8a);
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_5ae2cb8a
// Checksum 0xd347d509, Offset: 0xfe0
// Size: 0x94
function function_5ae2cb8a(params) {
    if (isplayer(params.eattacker) && isdefined(self.archetype) && self.archetype == "quadtank") {
        if (isdefined(params.weapon) && params.weapon.name != "vtol_fighter_player_turret") {
            level.var_67a0c1e2 = 1;
        }
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// namespace_b5b83650<file_0>::function_282c46db
// Checksum 0x18ee2af6, Offset: 0x1080
// Size: 0x24
function function_282c46db() {
    callback::remove_on_vehicle_killed(&function_9cda9485);
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_eab778af
// Checksum 0xc179f252, Offset: 0x10b0
// Size: 0x18c
function function_eab778af(params) {
    if (isplayer(params.eattacker) && !isvehicle(self)) {
        if (isdefined(params.eattacker.var_8fedf36c) && params.eattacker islinkedto(params.eattacker.var_8fedf36c) && params.weapon.type == "projectile") {
            if (!isdefined(params.eattacker.var_be2c6b19) || params.eattacker.var_be2c6b19 != gettime()) {
                params.eattacker.var_be2c6b19 = gettime();
                params.eattacker.var_eb0c14e = 0;
            }
            params.eattacker.var_eb0c14e++;
            if (params.eattacker.var_eb0c14e >= 5) {
                params.eattacker function_c27610f9("aq_threefer_missile", &function_a3f650bc);
            }
        }
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_a3f650bc
// Checksum 0x5ae42c36, Offset: 0x1248
// Size: 0x24
function function_a3f650bc() {
    callback::remove_on_ai_killed(&function_eab778af);
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_e3e41d63
// Checksum 0x10b8b370, Offset: 0x1278
// Size: 0x21c
function function_e3e41d63(params) {
    if (isplayer(params.eattacker) && !isvehicle(self)) {
        player = params.eattacker;
        if (isdefined(player.var_2aec500b)) {
            return;
        }
        if (!isdefined(player.var_c3919891)) {
            player.var_c3919891 = [];
        }
        t = gettime();
        if (player.var_c3919891.size > 0) {
            dirty = 1;
            while (dirty) {
                dirty = 0;
                for (i = 0; i < player.var_c3919891.size; i++) {
                    if (player.var_c3919891[i] < t) {
                        player.var_c3919891 = array::remove_index(player.var_c3919891, i);
                        dirty = 1;
                        break;
                    }
                }
            }
        }
        player.var_c3919891[player.var_c3919891.size] = t + 2000;
        /#
            iprintln("MISSION_AQUIFER_CHALLENGE5" + player.var_c3919891.size);
        #/
        if (player.var_c3919891.size >= 10) {
            player.var_2aec500b = 1;
            player function_c27610f9("aq_six_under_two");
        }
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// namespace_b5b83650<file_0>::function_8618bd31
// Checksum 0x99ec1590, Offset: 0x14a0
// Size: 0x4
function function_8618bd31() {
    
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// namespace_b5b83650<file_0>::function_3b8b405
// Checksum 0xebc84f05, Offset: 0x14b0
// Size: 0x18e
function function_3b8b405() {
    flag::wait_till("player_active_in_level");
    flag::wait_till("intro_dogfight_completed");
    var_e4047762 = level.activeplayers;
    foreach (player in var_e4047762) {
        player thread function_2edc96bc();
    }
    flag::wait_till("destroy_defenses_completed");
    foreach (player in var_e4047762) {
        if (array::contains(level.activeplayers, player)) {
            player notify(#"hash_c843f11");
        }
    }
    wait(1);
    level notify(#"hash_ebe4266");
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_2edc96bc
// Checksum 0x676cdeb1, Offset: 0x1648
// Size: 0x94
function function_2edc96bc() {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"hash_ebe4266");
    retval = self util::waittill_any_return("player_took_accolade_damage", "destroy_defenses_completed");
    if (isdefined(retval) && retval == "destroy_defenses_completed") {
        self function_c27610f9("aq_zero_damage_defenses");
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_f208dfd8
// Checksum 0x45ad8ffa, Offset: 0x16e8
// Size: 0x162
function function_f208dfd8() {
    level flag::wait_till("player_active_in_level");
    level flag::wait_till("intro_dogfight_completed");
    if (!level flag::get("destroy_defenses_completed")) {
        array::thread_all(level.activeplayers, &function_deee0b62);
    }
    level flag::wait_till("destroy_defenses_completed");
    foreach (player in level.activeplayers) {
        if (isdefined(player.var_80329ae2) && !player.var_80329ae2) {
            player function_c27610f9("aq_zero_damage_defenses");
        }
    }
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_deee0b62
// Checksum 0xf284c7f6, Offset: 0x1858
// Size: 0x100
function function_deee0b62(params) {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"hash_4af9ae51");
    self.var_80329ae2 = 0;
    while (true) {
        if (isdefined(self.var_8fedf36c)) {
            damage, attacker, direction_vec, point, meansofdeath, tagname, modelname, partname, weapon = self.var_8fedf36c waittill(#"damage");
            if (weapon.type != "bullet") {
                self.var_80329ae2 = 1;
            }
            continue;
        }
        wait(0.05);
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_dcb19e2a
// Checksum 0xe638224, Offset: 0x1960
// Size: 0xbc
function function_dcb19e2a() {
    flag::wait_till("player_active_in_level");
    flag::wait_till("destroy_defenses_completed");
    callback::on_vehicle_killed(&function_3718be07);
    flag::wait_till("hack_terminal_left_completed");
    flag::wait_till("hack_terminal_right_completed");
    flag::wait_till("hack_terminals3_completed");
    callback::remove_on_vehicle_killed(&function_3718be07);
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_3718be07
// Checksum 0xc80dc45c, Offset: 0x1a28
// Size: 0xb4
function function_3718be07(params) {
    if (self.targetname == "res_vtol1_vh" || self.targetname == "res_vtol2_vh" || self.targetname == "port_vtol1_vh" || self.targetname == "port_vtol2_vh" || isplayer(params.eattacker) && self.targetname == "lcombat_dropoff_vtol_vh") {
        level function_c27610f9("aq_vtol_drop_block");
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_f42b5fa1
// Checksum 0x1fbd553a, Offset: 0x1ae8
// Size: 0x1ce
function function_f42b5fa1() {
    flag::wait_till("player_active_in_level");
    level flag::wait_till("start_battle");
    level flag::wait_till("sniper_boss_spawned");
    var_e4047762 = level.activeplayers;
    foreach (player in var_e4047762) {
        player thread function_a2aa8ca8();
        player thread function_b362fb44();
    }
    level flag::wait_till("end_battle");
    foreach (player in var_e4047762) {
        if (array::contains(level.activeplayers, player)) {
            player notify(#"hash_8c7ead91");
        }
    }
    wait(1);
    level notify(#"hash_2899a2c7");
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_a2aa8ca8
// Checksum 0x37fab50a, Offset: 0x1cc0
// Size: 0x9c
function function_a2aa8ca8() {
    self endon(#"disconnect");
    level endon(#"hash_2899a2c7");
    self thread function_c2ba8da();
    retval = self util::waittill_any_return("sniper_boss_damage", "accolades_boss_done");
    if (isdefined(retval) && retval == "accolades_boss_done") {
        self function_c27610f9("aq_boss_zero_damage");
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_c2ba8da
// Checksum 0x67512523, Offset: 0x1d68
// Size: 0xca
function function_c2ba8da() {
    self endon(#"disconnect");
    level endon(#"hash_2899a2c7");
    attacker = self;
    while (attacker != level.sniper_boss) {
        damage, attacker, dir, loc, type, model, tag, part, weapon, flags = self waittill(#"damage");
    }
    self notify(#"hash_703e1e78");
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x1 linked
// namespace_b5b83650<file_0>::function_b362fb44
// Checksum 0x771ad3f2, Offset: 0x1e40
// Size: 0x84
function function_b362fb44() {
    self endon(#"disconnect");
    level endon(#"hash_2899a2c7");
    retval = self util::waittill_any_return("weapon_fired", "accolades_boss_done");
    if (isdefined(retval) && retval == "accolades_boss_done") {
        self function_c27610f9("aq_boss_cybercore_only");
    }
}

