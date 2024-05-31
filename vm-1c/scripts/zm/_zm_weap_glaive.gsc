#using scripts/shared/abilities/_ability_player;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_death;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_lightning_chain;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_raps;
#using scripts/shared/vehicles/_glaive;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/throttle_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/codescripts/struct;

#namespace namespace_2318f091;

// Namespace namespace_2318f091
// Params 0, eflags: 0x2
// Checksum 0xc756e12b, Offset: 0x700
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_glaive", &__init__, undefined, undefined);
}

// Namespace namespace_2318f091
// Params 0, eflags: 0x1 linked
// Checksum 0x6e9d7651, Offset: 0x740
// Size: 0x424
function __init__() {
    clientfield::register("allplayers", "slam_fx", 1, 1, "counter");
    clientfield::register("toplayer", "throw_fx", 1, 1, "counter");
    clientfield::register("toplayer", "swipe_fx", 1, 1, "counter");
    clientfield::register("toplayer", "swipe_lv2_fx", 1, 1, "counter");
    clientfield::register("actor", "zombie_slice_r", 1, 2, "counter");
    clientfield::register("actor", "zombie_slice_l", 1, 2, "counter");
    level._effect["glaive_blood_spurt"] = "impacts/fx_flesh_hit_knife_lg_zmb";
    level.var_8e4d3487 = -16;
    level.var_f1ed42ce = level.var_8e4d3487 * level.var_8e4d3487;
    level.var_906ed1e7 = 100;
    level.var_db3c626e = level.var_906ed1e7 * level.var_906ed1e7;
    level.var_69d41b2c = 120;
    level.var_b1a6353f = level.var_69d41b2c * level.var_69d41b2c;
    level.var_3e0110d = -96;
    level.var_42894cb8 = level.var_3e0110d * level.var_3e0110d;
    callback::on_connect(&function_5d561ab0);
    for (i = 0; i < 4; i++) {
        zombie_utility::add_zombie_gib_weapon_callback("glaive_apothicon" + "_" + i, &function_906dfe04, &function_9e3debe7);
        zombie_utility::add_zombie_gib_weapon_callback("glaive_keeper" + "_" + i, &function_906dfe04, &function_9e3debe7);
        zm_hero_weapon::function_d29010f8("glaive_apothicon" + "_" + i);
        zm_hero_weapon::function_d29010f8("glaive_keeper" + "_" + i);
        zm_hero_weapon::function_3d766bf2(getweapon("glaive_apothicon" + "_" + i), &function_4a948f8a);
        zm_hero_weapon::function_3d766bf2(getweapon("glaive_keeper" + "_" + i), &function_4a948f8a);
    }
    level.var_44a72fa6 = array("left_arm_upper", "left_arm_lower", "left_hand", "right_arm_upper", "right_arm_lower", "right_hand");
    level thread function_e97f78f0();
    level.var_b31b9421 = new throttle();
    [[ level.var_b31b9421 ]]->initialize(6, 0.1);
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x1 linked
// Checksum 0x5c4cc332, Offset: 0xb70
// Size: 0x8c
function function_c3226e09(var_a38bb577) {
    var_e4be281f = undefined;
    if (var_a38bb577 == 1) {
        var_e4be281f = "glaive_apothicon";
    } else {
        var_e4be281f = "glaive_keeper";
    }
    var_e4be281f = var_e4be281f + "_" + self.characterindex;
    wpn = getweapon(var_e4be281f);
    return wpn;
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x1 linked
// Checksum 0xfd497def, Offset: 0xc08
// Size: 0xd8
function function_3f820ba7(var_9fd9c680) {
    self endon(#"hash_b29853d8");
    while (isdefined(self)) {
        wpn_cur, wpn_prev = self waittill(#"weapon_change");
        if (wpn_cur != level.weaponnone && wpn_cur != var_9fd9c680) {
            self.var_c8364c36 = 0;
            if (self.var_376974d8) {
                self enableoffhandweapons();
                self thread function_762ff0b6(var_9fd9c680);
                self waittill(#"hash_8a993396");
            }
            self function_24587ddb();
            self notify(#"hash_b29853d8");
            return;
        }
    }
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x1 linked
// Checksum 0x56bd8edf, Offset: 0xce8
// Size: 0xd8
function function_762ff0b6(wpn_prev) {
    self endon(#"hash_8a993396");
    var_fbfaeadb = gettime();
    while (isdefined(self.var_376974d8) && isdefined(self) && self.var_376974d8) {
        rate = 1.667;
        if (isdefined(wpn_prev.gadget_power_usage_rate)) {
            rate = wpn_prev.gadget_power_usage_rate;
        }
        self.var_c9265b2e -= 0.0005 * rate;
        self gadgetpowerset(0, self.var_c9265b2e * 100);
        wait(0.05);
    }
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x1 linked
// Checksum 0x2844e7ff, Offset: 0xdc8
// Size: 0x2c
function function_50cf29d(evt) {
    self playrumbleonentity("lightninggun_charge");
}

// Namespace namespace_2318f091
// Params 4, eflags: 0x1 linked
// Checksum 0x9894f53a, Offset: 0xe00
// Size: 0x42c
function function_5c998ffc(var_52baa43a, var_c93fc6c, wpn_cur, wpn_prev) {
    if (self.var_86a785ad && !self.var_c8364c36) {
        if (wpn_cur == var_c93fc6c) {
            self.var_a0bd515a = var_c93fc6c;
            self.var_2ef815cf = 0;
            self disableoffhandweapons();
            self notify(#"altbody_end");
            self thread function_3f820ba7(wpn_cur);
            if (!(isdefined(self.var_c8364c36) && self.var_c8364c36)) {
                self gadgetpowerset(0, 100);
                self clientfield::set_player_uimodel("zmhud.swordEnergy", 1);
                self clientfield::set_player_uimodel("zmhud.swordState", 2);
                self.var_c9265b2e = 1;
            }
            self notify(#"hash_b74ad0fb");
            self thread function_50cf29d("lv2start");
            self.var_c8364c36 = 1;
            self.var_376974d8 = 0;
            slot = self gadgetgetslot(var_c93fc6c);
            self thread function_a15f6f64(slot);
            self thread function_d0a73497(wpn_cur, 1);
            self thread function_1fb44d05(var_c93fc6c);
            self waittill(#"hash_b29853d8");
            self enableoffhandweapons();
            self allowmeleepowerleft(1);
            self.var_c8364c36 = 0;
            self function_24587ddb();
            return;
        }
        if (wpn_cur == var_52baa43a) {
            self.var_a0bd515a = var_52baa43a;
            self.var_2ef815cf = 1;
            self disableoffhandweapons();
            self notify(#"altbody_end");
            self thread function_3f820ba7(wpn_cur);
            if (!(isdefined(self.var_c8364c36) && self.var_c8364c36)) {
                self gadgetpowerset(0, 100);
                self clientfield::set_player_uimodel("zmhud.swordEnergy", 1);
                self clientfield::set_player_uimodel("zmhud.swordState", 6);
                self.var_c9265b2e = 1;
            }
            self notify(#"hash_b74ad0fb");
            self thread function_50cf29d("lv1start");
            self.var_c8364c36 = 1;
            self.var_376974d8 = 0;
            slot = self gadgetgetslot(var_52baa43a);
            self thread function_a15f6f64(slot);
            self thread function_d0a73497(var_52baa43a, 0);
            self thread function_1de29b67(var_52baa43a);
            self waittill(#"hash_b29853d8");
            self enableoffhandweapons();
            self allowmeleepowerleft(1);
            self.var_c8364c36 = 0;
            self function_24587ddb();
        }
    }
}

// Namespace namespace_2318f091
// Params 0, eflags: 0x5 linked
// Checksum 0xd89fbdf, Offset: 0x1238
// Size: 0xc8
function private function_5d561ab0() {
    self endon(#"disconnect");
    var_52baa43a = self function_c3226e09(1);
    var_c93fc6c = self function_c3226e09(2);
    self.var_86a785ad = 1;
    self.var_c8364c36 = 0;
    while (true) {
        wpn_cur, wpn_prev = self waittill(#"weapon_change");
        self function_5c998ffc(var_52baa43a, var_c93fc6c, wpn_cur, wpn_prev);
    }
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x5 linked
// Checksum 0xbfbc337b, Offset: 0x1308
// Size: 0x44
function private function_906dfe04(damage_percent) {
    self.var_5f40519e = "none";
    if (damage_percent > 99.8) {
        self.var_5f40519e = "neck";
        return true;
    }
    return false;
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x5 linked
// Checksum 0x437463af, Offset: 0x1358
// Size: 0x7c
function private function_9e3debe7(damage_location) {
    if (self.var_5f40519e === "neck") {
        return true;
    }
    if (!isdefined(damage_location)) {
        return false;
    }
    if (damage_location == "head") {
        return true;
    }
    if (damage_location == "helmet") {
        return true;
    }
    if (damage_location == "neck") {
        return true;
    }
    return false;
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x5 linked
// Checksum 0x584df384, Offset: 0x13e0
// Size: 0x98
function private function_1de29b67(var_52baa43a) {
    self endon(#"hash_b29853d8");
    self endon(#"disconnect");
    self endon(#"bled_out");
    while (true) {
        weapon = self waittill(#"weapon_melee_power_left");
        if (weapon == var_52baa43a) {
            self clientfield::increment("slam_fx");
            self thread function_da195a32(var_52baa43a);
        }
    }
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x5 linked
// Checksum 0x725bdacf, Offset: 0x1480
// Size: 0x2c2
function private function_da195a32(var_52baa43a) {
    view_pos = self getweaponmuzzlepoint();
    forward_view_angles = self getweaponforwarddir();
    zombie_list = getaiteamarray(level.zombie_team);
    foreach (ai in zombie_list) {
        if (!isdefined(ai) || !isalive(ai)) {
            continue;
        }
        test_origin = ai getcentroid();
        dist_sq = distancesquared(view_pos, test_origin);
        if (dist_sq < level.var_f1ed42ce) {
            if (isdefined(ai.var_a3b60c68)) {
                self thread [[ ai.var_a3b60c68 ]](ai, var_52baa43a);
            } else {
                self thread electrocute_actor(ai, var_52baa43a);
            }
            continue;
        }
        if (dist_sq > level.var_db3c626e) {
            continue;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (0.707 > dot) {
            continue;
        }
        if (0 == ai damageconetrace(view_pos, self)) {
            continue;
        }
        if (isdefined(ai.var_a3b60c68)) {
            self thread [[ ai.var_a3b60c68 ]](ai, var_52baa43a);
            continue;
        }
        self thread electrocute_actor(ai, var_52baa43a);
    }
}

// Namespace namespace_2318f091
// Params 2, eflags: 0x1 linked
// Checksum 0xc02aaf17, Offset: 0x1750
// Size: 0xe4
function electrocute_actor(ai, var_52baa43a) {
    self endon(#"disconnect");
    if (!isdefined(ai) || !isalive(ai)) {
        return;
    }
    if (!isdefined(self.tesla_enemies_hit)) {
        self.tesla_enemies_hit = 1;
    }
    ai notify(#"bhtn_action_notify", "electrocute");
    function_72ca5a88();
    ai.tesla_death = 0;
    ai thread arc_damage_init(ai.origin, ai.origin, self);
    ai thread tesla_death(self);
}

// Namespace namespace_2318f091
// Params 0, eflags: 0x1 linked
// Checksum 0x22b7069f, Offset: 0x1840
// Size: 0x60
function function_72ca5a88() {
    level.var_ba84a05b = lightning_chain::create_lightning_chain_params(1);
    level.var_ba84a05b.head_gib_chance = 100;
    level.var_ba84a05b.network_death_choke = 4;
    level.var_ba84a05b.should_kill_enemies = 0;
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x1 linked
// Checksum 0x3b880fcf, Offset: 0x18a8
// Size: 0x7c
function tesla_death(player) {
    self endon(#"death");
    self thread function_862aadab(1);
    wait(2);
    player thread zm_audio::create_and_play_dialog("kill", "sword_slam");
    self dodamage(self.health + 1, self.origin);
}

// Namespace namespace_2318f091
// Params 3, eflags: 0x1 linked
// Checksum 0xa990ebbd, Offset: 0x1930
// Size: 0x64
function arc_damage_init(hit_location, var_8a2b6fe5, player) {
    player endon(#"disconnect");
    if (isdefined(self.var_128cd975) && self.var_128cd975) {
        return;
    }
    self lightning_chain::arc_damage_ent(player, 1, level.var_ba84a05b);
}

// Namespace namespace_2318f091
// Params 4, eflags: 0x1 linked
// Checksum 0x755b2ed3, Offset: 0x19a0
// Size: 0x1b4
function chop_actor(ai, upgraded, leftswing, weapon) {
    if (!isdefined(weapon)) {
        weapon = level.weaponnone;
    }
    self endon(#"disconnect");
    if (!isdefined(ai) || !isalive(ai)) {
        return;
    }
    if (isdefined(upgraded) && upgraded) {
        if (9317 >= ai.health) {
            ai.ignoremelee = 1;
        }
        [[ level.var_b31b9421 ]]->waitinqueue(ai);
        ai dodamage(9317, self.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);
    } else {
        if (3594 >= ai.health) {
            ai.ignoremelee = 1;
        }
        [[ level.var_b31b9421 ]]->waitinqueue(ai);
        ai dodamage(3594, self.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);
    }
    ai blood_death_fx(leftswing, upgraded);
    util::wait_network_frame();
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x1 linked
// Checksum 0x38e1d52d, Offset: 0x1b60
// Size: 0x12c
function function_862aadab(random_gibs) {
    if (isdefined(self) && isactor(self)) {
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibhead(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibleftarm(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibrightarm(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::giblegs(self);
        }
    }
}

// Namespace namespace_2318f091
// Params 2, eflags: 0x5 linked
// Checksum 0xf706aecf, Offset: 0x1c98
// Size: 0xec
function private blood_death_fx(var_d98455ab, var_26ba0d4c) {
    if (self.archetype == "zombie") {
        if (var_d98455ab) {
            if (isdefined(var_26ba0d4c) && var_26ba0d4c) {
                self clientfield::increment("zombie_slice_l", 2);
            } else {
                self clientfield::increment("zombie_slice_l", 1);
            }
            return;
        }
        if (isdefined(var_26ba0d4c) && var_26ba0d4c) {
            self clientfield::increment("zombie_slice_r", 2);
            return;
        }
        self clientfield::increment("zombie_slice_r", 1);
    }
}

// Namespace namespace_2318f091
// Params 4, eflags: 0x1 linked
// Checksum 0x8e742c1c, Offset: 0x1d90
// Size: 0x30a
function chop_zombies(first_time, var_10ee11e, leftswing, weapon) {
    if (!isdefined(weapon)) {
        weapon = level.weaponnone;
    }
    view_pos = self getweaponmuzzlepoint();
    forward_view_angles = self getweaponforwarddir();
    zombie_list = getaiteamarray(level.zombie_team);
    foreach (ai in zombie_list) {
        if (!isdefined(ai) || !isalive(ai)) {
            continue;
        }
        if (first_time) {
            ai.chopped = 0;
        } else if (isdefined(ai.chopped) && ai.chopped) {
            continue;
        }
        test_origin = ai getcentroid();
        dist_sq = distancesquared(view_pos, test_origin);
        dist_to_check = level.var_b1a6353f;
        if (var_10ee11e) {
            dist_to_check = level.var_42894cb8;
        }
        if (dist_sq > dist_to_check) {
            continue;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (dot <= 0) {
            continue;
        }
        if (0 == ai damageconetrace(view_pos, self)) {
            continue;
        }
        ai.chopped = 1;
        if (isdefined(ai.chop_actor_cb)) {
            self thread [[ ai.chop_actor_cb ]](ai, self, weapon);
            continue;
        }
        self thread chop_actor(ai, var_10ee11e, leftswing, weapon);
    }
}

// Namespace namespace_2318f091
// Params 2, eflags: 0x1 linked
// Checksum 0x5b4299fb, Offset: 0x20a8
// Size: 0xd4
function function_4a6a1b77(player, var_10ee11e) {
    if (var_10ee11e) {
        player clientfield::increment_to_player("swipe_lv2_fx");
    } else {
        player clientfield::increment_to_player("swipe_fx");
    }
    player thread chop_zombies(1, var_10ee11e, 1, self);
    wait(0.3);
    player thread chop_zombies(0, var_10ee11e, 1, self);
    wait(0.5);
    player thread chop_zombies(0, var_10ee11e, 0, self);
}

// Namespace namespace_2318f091
// Params 2, eflags: 0x5 linked
// Checksum 0x245a67a7, Offset: 0x2188
// Size: 0x88
function private function_d0a73497(weapon, var_10ee11e) {
    self endon(#"hash_b29853d8");
    self endon(#"disconnect");
    self endon(#"bled_out");
    while (true) {
        self util::waittill_any("weapon_melee_power", "weapon_melee");
        weapon thread function_4a6a1b77(self, var_10ee11e);
    }
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x5 linked
// Checksum 0x224c3688, Offset: 0x2218
// Size: 0x88
function private function_1fb44d05(var_c93fc6c) {
    self endon(#"hash_b29853d8");
    self endon(#"disconnect");
    self endon(#"bled_out");
    while (true) {
        weapon = self waittill(#"weapon_melee_power_left");
        if (weapon == var_c93fc6c && self.var_376974d8 == 0) {
            self thread function_946ce935(var_c93fc6c);
        }
    }
}

// Namespace namespace_2318f091
// Params 0, eflags: 0x1 linked
// Checksum 0x8dc10d32, Offset: 0x22a8
// Size: 0x6c
function function_86ee93a8() {
    if (isdefined(self.var_8f6c69b8) && self.var_8f6c69b8) {
        return;
    }
    self.var_8f6c69b8 = 1;
    self notify(#"hide_equipment_hint_text");
    util::wait_network_frame();
    zm_equipment::show_hint_text(%ZM_ZOD_SWORD_RECOVERY_HINT, 3.2);
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x5 linked
// Checksum 0xab305dd9, Offset: 0x2320
// Size: 0xe4
function private function_729af361(var_1c7a4c9a) {
    self endon(#"disconnect");
    self endon(#"hash_b29853d8");
    self endon(#"weapon_change");
    var_1c7a4c9a endon(#"hash_3de4334");
    var_1c7a4c9a endon(#"disconnect");
    self thread function_86ee93a8();
    self.var_c0d25105._glaive_must_return_to_owner = 0;
    while (isdefined(self) && self throwbuttonpressed()) {
        wait(0.05);
    }
    while (isdefined(self)) {
        if (self throwbuttonpressed()) {
            self.var_c0d25105._glaive_must_return_to_owner = 1;
            return;
        }
        wait(0.05);
    }
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x5 linked
// Checksum 0x777d00d4, Offset: 0x2410
// Size: 0x2d4
function private function_946ce935(var_c93fc6c) {
    var_37d6ca9f = getspawnerarray("glaive_spawner", "script_noteworthy");
    var_8e77ef3f = var_37d6ca9f[0];
    var_8e77ef3f.count = 1;
    var_1c7a4c9a = var_8e77ef3f spawnfromspawner("player_glaive_" + self.characterindex, 1);
    self.var_c0d25105 = var_1c7a4c9a;
    if (isdefined(var_1c7a4c9a)) {
        var_1c7a4c9a vehicle::lights_on();
        self clientfield::increment_to_player("throw_fx");
        var_1c7a4c9a.origin = self.origin + 80 * anglestoforward(self.angles) + (0, 0, 50);
        var_1c7a4c9a.angles = self getplayerangles();
        var_1c7a4c9a.owner = self;
        var_1c7a4c9a.weapon = var_c93fc6c;
        var_1c7a4c9a.var_7cc7e526 = math::clamp(self.var_c9265b2e * 100, 10, 60);
        self.var_376974d8 = 1;
        self allowmeleepowerleft(0);
        self thread function_50cf29d("lv2launch");
        self thread function_729af361(var_1c7a4c9a);
        var_1c7a4c9a util::waittill_any("returned_to_owner", "disconnect");
        self thread function_50cf29d("lv2recover");
        self allowmeleepowerleft(1);
        self.var_376974d8 = 0;
        self notify(#"hash_8a993396");
        self.var_c0d25105 = undefined;
        if (isdefined(self)) {
            util::wait_network_frame();
            self playsound("wpn_sword2_return");
        }
        var_1c7a4c9a delete();
    }
}

// Namespace namespace_2318f091
// Params 0, eflags: 0x1 linked
// Checksum 0x67bdacb7, Offset: 0x26f0
// Size: 0x2c8
function function_e97f78f0() {
    while (true) {
        foreach (player in getplayers()) {
            if (isdefined(player.var_c9265b2e) && !player.var_86a785ad) {
                player.var_c9265b2e = player gadgetpowerget(0) / 100;
                player clientfield::set_player_uimodel("zmhud.swordEnergy", player.var_c9265b2e);
                if (player.var_c9265b2e >= 1) {
                    player.var_86a785ad = 1;
                    if (isdefined(player.var_a0bd515a) && !(isdefined(player.var_c8364c36) && player.var_c8364c36) && !(isdefined(player.var_376974d8) && player.var_376974d8)) {
                        player giveweapon(player.var_a0bd515a);
                        player.var_86a785ad = 1;
                        player gadgetpowerset(0, 100);
                        player clientfield::set_player_uimodel("zmhud.swordEnergy", 1);
                        if (isdefined(player.var_2ef815cf) && player.var_2ef815cf) {
                            player clientfield::set_player_uimodel("zmhud.swordState", 6);
                        } else {
                            player clientfield::set_player_uimodel("zmhud.swordState", 2);
                        }
                        player.var_c9265b2e = 1;
                        player zm_equipment::show_hint_text(%ZM_ZOD_SWORD_HINT, 2);
                    }
                }
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_2318f091
// Params 0, eflags: 0x1 linked
// Checksum 0x332e9f18, Offset: 0x29c0
// Size: 0x1b4
function function_24587ddb() {
    if (isdefined(self.var_c8364c36) && self.var_c8364c36) {
        return;
    }
    var_52baa43a = self function_c3226e09(1);
    var_c93fc6c = self function_c3226e09(2);
    /#
        if (isdefined(self.var_8135101c) && self.var_8135101c) {
            self.var_86a785ad = 1;
            return;
        }
    #/
    self.var_86a785ad = 0;
    if (self hasweapon(var_c93fc6c)) {
        self clientfield::set_player_uimodel("zmhud.swordState", 1);
        if (false) {
            self clientfield::set_player_uimodel("zmhud.swordEnergy", 0);
            self gadgetpowerset(0, 0);
            self.var_c9265b2e = 0;
        }
        return;
    }
    if (self hasweapon(var_52baa43a)) {
        self clientfield::set_player_uimodel("zmhud.swordState", 5);
        if (false) {
            self clientfield::set_player_uimodel("zmhud.swordEnergy", 0);
            self gadgetpowerset(0, 0);
            self.var_c9265b2e = 0;
        }
    }
}

// Namespace namespace_2318f091
// Params 1, eflags: 0x1 linked
// Checksum 0x249be0d, Offset: 0x2b80
// Size: 0x2c2
function function_a15f6f64(slot) {
    self endon(#"disconnect");
    self endon(#"hash_b29853d8");
    while (isdefined(self.var_376974d8) && (isdefined(self.var_c8364c36) && self.var_c8364c36 || isdefined(self) && self.var_376974d8) && self.var_c9265b2e > 0) {
        if (isdefined(self.teleporting) && self.teleporting) {
            wait(0.05);
            continue;
        }
        self.var_c9265b2e = self gadgetpowerget(slot) / 100;
        self clientfield::set_player_uimodel("zmhud.swordEnergy", self.var_c9265b2e);
        if (isdefined(self.var_2ef815cf) && self.var_2ef815cf) {
            self clientfield::set_player_uimodel("zmhud.swordState", 7);
        } else {
            self clientfield::set_player_uimodel("zmhud.swordState", 3);
        }
        /#
            if (isdefined(self.var_8135101c) && self.var_8135101c) {
                self.var_c9265b2e = 1;
                self clientfield::set_player_uimodel("zombie_slice_r", 1);
                if (isdefined(self.var_2ef815cf) && self.var_2ef815cf) {
                    self clientfield::set_player_uimodel("zombie_slice_r", 6);
                } else {
                    self clientfield::set_player_uimodel("zombie_slice_r", 2);
                }
                self gadgetpowerset(0, 100);
            }
        #/
        wait(0.05);
    }
    self thread function_50cf29d("oopower");
    self.var_c8364c36 = 0;
    self.var_376974d8 = 0;
    self notify(#"hash_8a993396");
    if (isdefined(self.var_c0d25105)) {
        self.var_c0d25105._glaive_must_return_to_owner = 1;
    }
    while (self isslamming()) {
        wait(0.05);
    }
    self function_24587ddb();
    self notify(#"hash_b29853d8");
}

// Namespace namespace_2318f091
// Params 2, eflags: 0x1 linked
// Checksum 0x443c20e2, Offset: 0x2e50
// Size: 0x1d4
function function_4a948f8a(player, enemy) {
    if (player laststand::player_is_in_laststand()) {
        return;
    }
    if (!(isdefined(player.var_c8364c36) && player.var_c8364c36) && isdefined(player) && !(isdefined(player.var_376974d8) && player.var_376974d8) && isdefined(player.var_a0bd515a)) {
        if (isdefined(enemy.sword_kill_power)) {
            perkfactor = 1;
            if (player hasperk("specialty_overcharge")) {
                perkfactor = getdvarfloat("gadgetPowerOverchargePerkScoreFactor");
            }
            temp = player.var_c9265b2e + perkfactor * enemy.sword_kill_power / 100;
            player.var_c9265b2e = math::clamp(temp, 0, 1);
            player clientfield::set_player_uimodel("zmhud.swordEnergy", player.var_c9265b2e);
            player gadgetpowerset(0, 100 * player.var_c9265b2e);
            player clientfield::increment_uimodel("zmhud.swordChargeUpdate");
        }
    }
}

/#

    // Namespace namespace_2318f091
    // Params 1, eflags: 0x1 linked
    // Checksum 0x62106619, Offset: 0x3030
    // Size: 0x24
    function function_7855de72(player) {
        player ability_player::abilities_devgui_power_fill();
    }

#/
