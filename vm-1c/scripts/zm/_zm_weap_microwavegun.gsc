#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_audio;
#using scripts/zm/_util;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_1a0051d2;

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x2
// namespace_1a0051d2<file_0>::function_2dc19561
// Checksum 0x85f96191, Offset: 0x650
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_microwavegun", &__init__, undefined, undefined);
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_8c87d8eb
// Checksum 0x908c6f5, Offset: 0x690
// Size: 0x304
function __init__() {
    clientfield::register("actor", "toggle_microwavegun_hit_response", 21000, 1, "int");
    clientfield::register("actor", "toggle_microwavegun_expand_response", 21000, 1, "int");
    clientfield::register("clientuimodel", "hudItems.showDpadLeft_WaveGun", 21000, 1, "int");
    clientfield::register("clientuimodel", "hudItems.dpadLeftAmmo", 21000, 5, "int");
    zm_spawner::register_zombie_damage_callback(&function_6590a495);
    zm_spawner::register_zombie_death_animscript_callback(&function_a663c32a);
    zombie_utility::set_zombie_var("microwavegun_cylinder_radius", -76);
    zombie_utility::set_zombie_var("microwavegun_sizzle_range", 480);
    level._effect["microwavegun_zap_shock_dw"] = "dlc5/zmb_weapon/fx_zap_shock_dw";
    level._effect["microwavegun_zap_shock_eyes_dw"] = "dlc5/zmb_weapon/fx_zap_shock_eyes_dw";
    level._effect["microwavegun_zap_shock_lh"] = "dlc5/zmb_weapon/fx_zap_shock_lh";
    level._effect["microwavegun_zap_shock_eyes_lh"] = "dlc5/zmb_weapon/fx_zap_shock_eyes_lh";
    level._effect["microwavegun_zap_shock_ug"] = "dlc5/zmb_weapon/fx_zap_shock_ug";
    level._effect["microwavegun_zap_shock_eyes_ug"] = "dlc5/zmb_weapon/fx_zap_shock_eyes_ug";
    animationstatenetwork::registernotetrackhandlerfunction("expand", &function_5c6b11a6);
    animationstatenetwork::registernotetrackhandlerfunction("explode", &function_f8d8850f);
    level thread function_e862b441();
    level.var_f5376ce = [];
    level.var_12fcda98 = getweapon("microwavegun");
    level.var_6ae86bb = getweapon("microwavegun_upgraded");
    level.var_9c43352b = getweapon("microwavegundw");
    level.var_5736548e = getweapon("microwavegundw_upgraded");
    callback::on_spawned(&on_player_spawned);
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_aebcf025
// Checksum 0xc3e82734, Offset: 0x9a0
// Size: 0x1c
function on_player_spawned() {
    self thread function_8f95fde5();
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_8f95fde5
// Checksum 0x6a5fffe7, Offset: 0x9c8
// Size: 0x15e
function function_8f95fde5() {
    self notify(#"hash_8f95fde5");
    self endon(#"hash_8f95fde5");
    self endon(#"disconnect");
    while (true) {
        weapon = self waittill(#"weapon_give");
        weapon = zm_weapons::get_nonalternate_weapon(weapon);
        if (weapon == level.var_9c43352b || weapon == level.var_5736548e) {
            self clientfield::set_player_uimodel("hudItems.showDpadLeft_WaveGun", 1);
            self.var_59dcbbd4 = zm_weapons::is_weapon_upgraded(weapon);
            self thread function_1402f75f();
            continue;
        }
        if (!self zm_weapons::has_weapon_or_upgrade(level.var_9c43352b)) {
            self clientfield::set_player_uimodel("hudItems.showDpadLeft_WaveGun", 0);
            self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", 0);
            self notify(#"hash_e3517683");
            self.var_59dcbbd4 = undefined;
        }
    }
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_1402f75f
// Checksum 0xc0a7a079, Offset: 0xb30
// Size: 0x100
function function_1402f75f() {
    self notify(#"hash_1402f75f");
    self endon(#"hash_1402f75f");
    self endon(#"hash_e3517683");
    self endon(#"disconnect");
    self.var_db2418ce = 1;
    while (true) {
        if (isdefined(self.var_59dcbbd4)) {
            if (self.var_59dcbbd4) {
                ammocount = self getammocount(level.var_6ae86bb);
            } else {
                ammocount = self getammocount(level.var_12fcda98);
            }
            self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", ammocount);
        } else {
            self clientfield::set_player_uimodel("hudItems.dpadLeftAmmo", 0);
        }
        wait(0.05);
    }
}

// Namespace namespace_1a0051d2
// Params 1, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_d4224082
// Checksum 0xb021d907, Offset: 0xc38
// Size: 0x2c
function function_d4224082(ent) {
    array::add(level.var_f5376ce, ent, 0);
}

// Namespace namespace_1a0051d2
// Params 1, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_1ef3ad2b
// Checksum 0xbf5eb938, Offset: 0xc70
// Size: 0x2c
function function_1ef3ad2b(ent) {
    arrayremovevalue(level.var_f5376ce, ent);
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_e862b441
// Checksum 0xa4222416, Offset: 0xca8
// Size: 0x38
function function_e862b441() {
    for (;;) {
        player = level waittill(#"connecting");
        player thread function_4717127f();
    }
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_4717127f
// Checksum 0x3bf57649, Offset: 0xce8
// Size: 0x90
function function_4717127f() {
    self endon(#"disconnect");
    self waittill(#"spawned_player");
    for (;;) {
        self waittill(#"weapon_fired");
        currentweapon = self getcurrentweapon();
        if (currentweapon == level.var_12fcda98 || currentweapon == level.var_6ae86bb) {
            self thread function_50d51913(currentweapon == level.var_6ae86bb);
        }
    }
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_d570a914
// Checksum 0x7c31e53d, Offset: 0xd80
// Size: 0x4c
function function_d570a914() {
    level.var_3337c3c0++;
    if (!(level.var_3337c3c0 % 10)) {
        util::wait_network_frame();
        util::wait_network_frame();
        util::wait_network_frame();
    }
}

// Namespace namespace_1a0051d2
// Params 1, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_50d51913
// Checksum 0x7368de20, Offset: 0xdd8
// Size: 0x104
function function_50d51913(upgraded) {
    if (!isdefined(level.var_c42d5619)) {
        level.var_c42d5619 = [];
        level.var_f422510e = [];
    }
    self function_d87e2d1a(upgraded, 0);
    self function_d87e2d1a(upgraded, 1);
    level.var_3337c3c0 = 0;
    for (i = 0; i < level.var_c42d5619.size; i++) {
        function_d570a914();
        level.var_c42d5619[i] thread function_7e749c35(self, level.var_f422510e[i], i);
    }
    level.var_c42d5619 = [];
    level.var_f422510e = [];
}

// Namespace namespace_1a0051d2
// Params 2, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_d87e2d1a
// Checksum 0x2f821297, Offset: 0xee8
// Size: 0x5d4
function function_d87e2d1a(upgraded, var_7e2828ad) {
    view_pos = self getweaponmuzzlepoint();
    var_6d86f57c = [];
    range = level.zombie_vars["microwavegun_sizzle_range"];
    cylinder_radius = level.zombie_vars["microwavegun_cylinder_radius"];
    if (var_7e2828ad) {
        var_6d86f57c = level.var_f5376ce;
        range *= 10;
        cylinder_radius *= 10;
    } else {
        var_6d86f57c = zombie_utility::get_round_enemy_array();
    }
    zombies = util::get_array_of_closest(view_pos, var_6d86f57c, undefined, undefined, range);
    if (!isdefined(zombies)) {
        return;
    }
    var_3c5c4900 = range * range;
    cylinder_radius_squared = cylinder_radius * cylinder_radius;
    forward_view_angles = self getweaponforwarddir();
    end_pos = view_pos + vectorscale(forward_view_angles, range);
    /#
        if (2 == getdvarint("microwavegun_cylinder_radius")) {
            near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
            circle(near_circle_pos, cylinder_radius, (1, 0, 0), 0, 0, 100);
            line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
            circle(end_pos, cylinder_radius, (1, 0, 0), 0, 0, 100);
        }
    #/
    for (i = 0; i < zombies.size; i++) {
        if (isai(zombies[i]) && (!isdefined(zombies[i]) || !isalive(zombies[i]))) {
            continue;
        }
        test_origin = zombies[i] getcentroid();
        test_range_squared = distancesquared(view_pos, test_origin);
        if (test_range_squared > var_3c5c4900) {
            zombies[i] function_5724b132("range", (1, 0, 0));
            return;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (0 > dot) {
            zombies[i] function_5724b132("dot", (1, 0, 0));
            continue;
        }
        radial_origin = pointonsegmentnearesttopoint(view_pos, end_pos, test_origin);
        if (distancesquared(test_origin, radial_origin) > cylinder_radius_squared) {
            zombies[i] function_5724b132("cylinder", (1, 0, 0));
            continue;
        }
        if (0 == zombies[i] damageconetrace(view_pos, self)) {
            zombies[i] function_5724b132("cone", (1, 0, 0));
            continue;
        }
        if (isai(zombies[i])) {
            level.var_c42d5619[level.var_c42d5619.size] = zombies[i];
            dist_mult = (var_3c5c4900 - test_range_squared) / var_3c5c4900;
            var_fb9246e3 = vectornormalize(test_origin - view_pos);
            if (5000 < test_range_squared) {
                var_fb9246e3 += vectornormalize(test_origin - radial_origin);
            }
            var_fb9246e3 = (var_fb9246e3[0], var_fb9246e3[1], abs(var_fb9246e3[2]));
            var_fb9246e3 = vectorscale(var_fb9246e3, 100 + 100 * dist_mult);
            level.var_f422510e[level.var_f422510e.size] = var_fb9246e3;
            continue;
        }
        zombies[i] notify(#"hash_d26ed760", self);
    }
}

// Namespace namespace_1a0051d2
// Params 2, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_5724b132
// Checksum 0xbd766163, Offset: 0x14c8
// Size: 0x8c
function function_5724b132(msg, color) {
    /#
        if (!getdvarint("microwavegun_cylinder_radius")) {
            return;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        print3d(self.origin + (0, 0, 60), msg, color, 1, 1, 40);
    #/
}

// Namespace namespace_1a0051d2
// Params 3, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_7e749c35
// Checksum 0x83d8d031, Offset: 0x1560
// Size: 0x2b4
function function_7e749c35(player, var_fb9246e3, index) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (isdefined(self.var_bb3019d)) {
        self [[ self.var_bb3019d ]](player);
        return;
    }
    self.no_gib = 1;
    self.gibbed = 1;
    self.skipautoragdoll = 1;
    self.microwavegun_death = 1;
    self dodamage(self.health + 666, player.origin, player);
    if (self.health <= 0) {
        points = 10;
        if (!index) {
            points = zm_score::function_b2baf1b5();
        } else if (1 == index) {
            points = 30;
        }
        player zm_score::player_add_points("thundergun_fling", points);
        var_5cbd696 = 0;
        if (self.isdog) {
            self.a.nodeath = undefined;
            var_5cbd696 = 1;
        }
        if (isdefined(self.in_the_ceiling) && (isdefined(self.is_traversing) && self.is_traversing || self.in_the_ceiling)) {
            self.deathanim = undefined;
            var_5cbd696 = 1;
        }
        if (var_5cbd696) {
            if (isdefined(self.animname) && self.animname != "astro_zombie") {
                self thread function_45da712(player);
            }
            self clientfield::set("toggle_microwavegun_expand_response", 1);
            self thread function_51641b77();
            return;
        }
        if (isdefined(self.animname) && self.animname != "astro_zombie") {
            self thread function_45da712(player, 6);
        }
        self clientfield::set("toggle_microwavegun_hit_response", 1);
        self.nodeathragdoll = 1;
        self.var_2d2c3b8f = &function_db28a1e3;
    }
}

// Namespace namespace_1a0051d2
// Params 1, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_db28a1e3
// Checksum 0x6b8cc7fb, Offset: 0x1820
// Size: 0x84
function function_db28a1e3(note) {
    if (note == "expand") {
        self clientfield::set("toggle_microwavegun_expand_response", 1);
        return;
    }
    if (note == "explode") {
        self clientfield::set("toggle_microwavegun_expand_response", 0);
        self thread function_51641b77();
    }
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_51641b77
// Checksum 0x5f0d0fe8, Offset: 0x18b0
// Size: 0x44
function function_51641b77() {
    if (!isdefined(self)) {
        return;
    }
    self ghost();
    wait(0.1);
    self zm_utility::self_delete();
}

// Namespace namespace_1a0051d2
// Params 3, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_895f6a7
// Checksum 0xe1161be3, Offset: 0x1900
// Size: 0x184
function function_895f6a7(mod, damageweapon, player) {
    player endon(#"disconnect");
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (self.isdog) {
        self.a.nodeath = undefined;
    }
    if (isdefined(self.is_traversing) && self.is_traversing) {
        self.deathanim = undefined;
    }
    self.skipautoragdoll = 1;
    self.var_bac7b83d = 1;
    self thread function_83daadee(damageweapon);
    if (isdefined(self.var_b05e6bbb)) {
        self [[ self.var_b05e6bbb ]](player);
        return;
    } else {
        self dodamage(self.health + 666, self.origin, player);
    }
    player zm_score::player_add_points("death", "", "");
    if (randomintrange(0, 101) >= 75) {
        player thread zm_audio::create_and_play_dialog("kill", "micro_dual");
    }
}

// Namespace namespace_1a0051d2
// Params 1, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_2275c601
// Checksum 0xe3157613, Offset: 0x1a90
// Size: 0x92
function function_2275c601(weapon) {
    if (weapon == getweapon("microwavegundw")) {
        return level._effect["microwavegun_zap_shock_dw"];
    }
    if (weapon == getweapon("microwavegunlh")) {
        return level._effect["microwavegun_zap_shock_lh"];
    }
    return level._effect["microwavegun_zap_shock_ug"];
}

// Namespace namespace_1a0051d2
// Params 1, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_24f24c2e
// Checksum 0xc9ae30ff, Offset: 0x1b30
// Size: 0x92
function function_24f24c2e(weapon) {
    if (weapon == getweapon("microwavegundw")) {
        return level._effect["microwavegun_zap_shock_eyes_dw"];
    }
    if (weapon == getweapon("microwavegunlh")) {
        return level._effect["microwavegun_zap_shock_eyes_lh"];
    }
    return level._effect["microwavegun_zap_shock_eyes_ug"];
}

// Namespace namespace_1a0051d2
// Params 1, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_208fa6f4
// Checksum 0x3d5487c7, Offset: 0x1bd0
// Size: 0x4c
function function_208fa6f4(weapon) {
    self endon(#"death");
    zm_net::network_safe_play_fx_on_tag("microwavegun_zap_death_fx", 2, function_24f24c2e(weapon), self, "J_Eyeball_LE");
}

// Namespace namespace_1a0051d2
// Params 1, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_83daadee
// Checksum 0xacd041fa, Offset: 0x1c28
// Size: 0xf4
function function_83daadee(weapon) {
    tag = "J_SpineUpper";
    if (self.isdog) {
        tag = "J_Spine1";
    }
    zm_net::network_safe_play_fx_on_tag("microwavegun_zap_death_fx", 2, function_2275c601(weapon), self, tag);
    self playsound("wpn_imp_tesla");
    if (isdefined(self.head_gibbed) && self.head_gibbed) {
        return;
    }
    if (isdefined(self.var_35112f59)) {
        self thread [[ self.var_35112f59 ]](weapon);
        return;
    }
    if ("quad_zombie" != self.animname) {
        self thread function_208fa6f4(weapon);
    }
}

// Namespace namespace_1a0051d2
// Params 13, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_6590a495
// Checksum 0x6b7e186, Offset: 0x1d28
// Size: 0xb4
function function_6590a495(str_mod, var_5afff096, var_7c5a4ee4, e_attacker, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (self function_652d52d3()) {
        self thread function_895f6a7(str_mod, self.damageweapon, e_attacker);
        return true;
    }
    return false;
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_a663c32a
// Checksum 0x88726fca, Offset: 0x1de8
// Size: 0xa8
function function_a663c32a() {
    if (self function_760c6a2f()) {
        if (isdefined(self.attacker) && isdefined(level.hero_power_update)) {
            level thread [[ level.hero_power_update ]](self.attacker, self);
        }
        return true;
    } else if (self function_227551b1()) {
        if (isdefined(self.attacker) && isdefined(level.hero_power_update)) {
            level thread [[ level.hero_power_update ]](self.attacker, self);
        }
        return true;
    }
    return false;
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_652d52d3
// Checksum 0x853f8321, Offset: 0x1e98
// Size: 0xa0
function function_652d52d3() {
    return (self.damageweapon == getweapon("microwavegundw") || self.damageweapon == getweapon("microwavegundw_upgraded") || self.damageweapon == getweapon("microwavegunlh") || isdefined(self.damageweapon) && self.damageweapon == getweapon("microwavegunlh_upgraded")) && self.damagemod == "MOD_IMPACT";
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_760c6a2f
// Checksum 0xa7ac0d97, Offset: 0x1f40
// Size: 0x16
function function_760c6a2f() {
    return isdefined(self.var_bac7b83d) && self.var_bac7b83d;
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x0
// namespace_1a0051d2<file_0>::function_c2925d0d
// Checksum 0xf1972cee, Offset: 0x1f60
// Size: 0x5c
function function_c2925d0d() {
    return self.damagemod != "MOD_GRENADE" && (self.damageweapon == level.var_12fcda98 || isdefined(self.damageweapon) && self.damageweapon == level.var_6ae86bb) && self.damagemod != "MOD_GRENADE_SPLASH";
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_227551b1
// Checksum 0x5124e6f8, Offset: 0x1fc8
// Size: 0x16
function function_227551b1() {
    return isdefined(self.microwavegun_death) && self.microwavegun_death;
}

// Namespace namespace_1a0051d2
// Params 0, eflags: 0x0
// namespace_1a0051d2<file_0>::function_972820f5
// Checksum 0xbc2b4748, Offset: 0x1fe8
// Size: 0x110
function function_972820f5() {
    self endon(#"disconnect");
    self waittill(#"spawned_player");
    for (;;) {
        result = self util::waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback");
        if (!isdefined(result)) {
            continue;
        }
        if ((result == "weapon_change" || result == "grenade_fire") && self getcurrentweapon() == level.var_12fcda98) {
            self playloopsound("tesla_idle", 0.25);
            continue;
        }
        self notify(#"weap_away");
        self stoploopsound(0.25);
    }
}

// Namespace namespace_1a0051d2
// Params 2, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_45da712
// Checksum 0x83826ae9, Offset: 0x2100
// Size: 0x9c
function function_45da712(player, waittime) {
    level notify(#"hash_8daa84a8");
    level endon(#"hash_8daa84a8");
    if (!isdefined(waittime)) {
        waittime = 0.05;
    }
    wait(waittime);
    if (50 > randomintrange(1, 100) && isdefined(player)) {
        player thread zm_audio::create_and_play_dialog("kill", "micro_single");
    }
}

// Namespace namespace_1a0051d2
// Params 1, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_5c6b11a6
// Checksum 0xba4713c1, Offset: 0x21a8
// Size: 0x2c
function function_5c6b11a6(entity) {
    self clientfield::set("toggle_microwavegun_expand_response", 1);
}

// Namespace namespace_1a0051d2
// Params 1, eflags: 0x1 linked
// namespace_1a0051d2<file_0>::function_f8d8850f
// Checksum 0xbcf33dc7, Offset: 0x21e0
// Size: 0x44
function function_f8d8850f(entity) {
    self clientfield::set("toggle_microwavegun_expand_response", 0);
    self thread function_51641b77();
}

