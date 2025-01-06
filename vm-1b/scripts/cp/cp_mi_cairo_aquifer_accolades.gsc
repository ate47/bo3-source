#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;

#namespace namespace_b5b83650;

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0xf56222d6, Offset: 0x578
// Size: 0x26a
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
    level.var_bb70984c["aq_vtol_drop_block"] = 4;
    level.var_bb70984c["aq_tnt"] = 15;
    level.var_bb70984c["aq_defend_egyptians"] = 45;
    thread function_89f596d9();
}

// Namespace namespace_b5b83650
// Params 3, eflags: 0x0
// Checksum 0x15868e5b, Offset: 0x7f0
// Size: 0x153
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
            iprintln("<dev string:x28>" + var_8e087689 + "<dev string:x32>" + player.var_ec496e8b[var_8e087689] + "<dev string:x35>" + level.var_bb70984c[var_8e087689]);
        #/
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0x6e65ce0, Offset: 0x950
// Size: 0x102
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
// Params 1, eflags: 0x0
// Checksum 0x2de4581b, Offset: 0xa60
// Size: 0x72
function function_171499d7(params) {
    if (isplayer(params.eattacker) && !isvehicle(self)) {
        if (params.einflictor.targetname === "destructible") {
            params.eattacker accolades::increment("MISSION_AQUIFER_CHALLENGE10");
        }
    }
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x0
// Checksum 0xb1f97a46, Offset: 0xae0
// Size: 0xe2
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
// Params 1, eflags: 0x0
// Checksum 0xe79bafd1, Offset: 0xbd0
// Size: 0xa2
function function_c7122e75(params) {
    if (isplayer(params.eattacker) && !isvehicle(self)) {
        if (isdefined(params.eattacker.var_8fedf36c) && params.eattacker islinkedto(params.eattacker.var_8fedf36c)) {
            params.eattacker function_c27610f9("aq_thirty_kill_vtol", &function_b49b24ca);
        }
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0x3514122e, Offset: 0xc80
// Size: 0x22
function function_b49b24ca() {
    callback::remove_on_ai_killed(&function_c7122e75);
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x0
// Checksum 0x798b58db, Offset: 0xcb0
// Size: 0xb2
function function_9cda9485(params) {
    if (isplayer(params.eattacker) && isdefined(self.archetype) && self.archetype == "hunter") {
        if (isdefined(params.eattacker.var_8fedf36c) && params.eattacker islinkedto(params.eattacker.var_8fedf36c)) {
            params.eattacker function_c27610f9("aq_three_hunters_vtol", &function_ff25056a);
        }
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0x6ff14145, Offset: 0xd70
// Size: 0x22
function function_ff25056a() {
    callback::remove_on_vehicle_killed(&function_9cda9485);
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0x49ed378b, Offset: 0xda0
// Size: 0x82
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
// Params 1, eflags: 0x0
// Checksum 0x8b1ce589, Offset: 0xe30
// Size: 0x76
function function_5ae2cb8a(params) {
    if (isplayer(params.eattacker) && isdefined(self.archetype) && self.archetype == "quadtank") {
        if (isdefined(params.weapon) && params.weapon.name != "vtol_fighter_player_turret") {
            level.var_67a0c1e2 = 1;
        }
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0xb29856c6, Offset: 0xeb0
// Size: 0x22
function function_282c46db() {
    callback::remove_on_vehicle_killed(&function_9cda9485);
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x0
// Checksum 0x4e6dceed, Offset: 0xee0
// Size: 0x142
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
// Params 0, eflags: 0x0
// Checksum 0x9ef55d52, Offset: 0x1030
// Size: 0x22
function function_a3f650bc() {
    callback::remove_on_ai_killed(&function_eab778af);
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x0
// Checksum 0x4d104eff, Offset: 0x1060
// Size: 0x18a
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
            iprintln("<dev string:x3a>" + player.var_c3919891.size);
        #/
        if (player.var_c3919891.size >= 10) {
            player.var_2aec500b = 1;
            player function_c27610f9("aq_six_under_two");
        }
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x11f8
// Size: 0x2
function function_8618bd31() {
    
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0xa96bed3d, Offset: 0x1208
// Size: 0x12f
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
            player notify(#"destroy_defenses_completed");
        }
    }
    wait 1;
    level notify(#"hash_ebe4266");
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0x70a8d814, Offset: 0x1340
// Size: 0x72
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
// Params 0, eflags: 0x0
// Checksum 0xd25293f, Offset: 0x13c0
// Size: 0x10b
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
// Params 1, eflags: 0x0
// Checksum 0x2dd091ad, Offset: 0x14d8
// Size: 0xc7
function function_deee0b62(params) {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"hash_4af9ae51");
    self.var_80329ae2 = 0;
    while (true) {
        if (isdefined(self.var_8fedf36c)) {
            self.var_8fedf36c waittill(#"damage", damage, attacker, direction_vec, point, meansofdeath, tagname, modelname, partname, weapon);
            if (weapon.type != "bullet") {
                self.var_80329ae2 = 1;
            }
        }
        waittillframeend();
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0xfb02ea19, Offset: 0x15a8
// Size: 0xa2
function function_dcb19e2a() {
    flag::wait_till("player_active_in_level");
    flag::wait_till("destroy_defenses_completed");
    callback::on_vehicle_killed(&function_3718be07);
    flag::wait_till("hack_terminal_left_completed");
    flag::wait_till("hack_terminal_right_completed");
    callback::remove_on_vehicle_killed(&function_3718be07);
}

// Namespace namespace_b5b83650
// Params 1, eflags: 0x0
// Checksum 0xf6d29dcb, Offset: 0x1658
// Size: 0x8a
function function_3718be07(params) {
    if (self.targetname == "res_vtol1_vh" || self.targetname == "res_vtol2_vh" || self.targetname == "port_vtol1_vh" || isplayer(params.eattacker) && self.targetname == "port_vtol2_vh") {
        level function_c27610f9("aq_vtol_drop_block");
    }
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0xa26e6da5, Offset: 0x16f0
// Size: 0x157
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
            player notify(#"accolades_boss_done");
        }
    }
    wait 1;
    level notify(#"hash_2899a2c7");
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0xe75e6c3f, Offset: 0x1850
// Size: 0x7a
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
// Params 0, eflags: 0x0
// Checksum 0x3a6f6214, Offset: 0x18d8
// Size: 0x9f
function function_c2ba8da() {
    self endon(#"disconnect");
    level endon(#"hash_2899a2c7");
    attacker = self;
    while (attacker != level.sniper_boss) {
        self waittill(#"damage", damage, attacker, dir, loc, type, model, tag, part, weapon, flags);
    }
    self notify(#"sniper_boss_damage");
}

// Namespace namespace_b5b83650
// Params 0, eflags: 0x0
// Checksum 0xe46ff6d9, Offset: 0x1980
// Size: 0x6a
function function_b362fb44() {
    self endon(#"disconnect");
    level endon(#"hash_2899a2c7");
    retval = self util::waittill_any_return("weapon_fired", "accolades_boss_done");
    if (isdefined(retval) && retval == "accolades_boss_done") {
        self function_c27610f9("aq_boss_cybercore_only");
    }
}

