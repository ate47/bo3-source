#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_traps;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_dragon_strike;
#using scripts/zm/_zm_weap_riotshield;
#using scripts/zm/_zm_weapons;
#using scripts/zm/craftables/_zm_craft_shield;

#namespace namespace_8215525;

// Namespace namespace_8215525
// Params 0, eflags: 0x2
// Checksum 0x88d4c809, Offset: 0x958
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_weap_dragonshield", &__init__, &__main__, undefined);
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0xded349f0, Offset: 0x9a0
// Size: 0x49c
function __init__() {
    zm_craft_shield::init("craft_shield_zm", "dragonshield", "wpn_t7_zmb_dlc3_dragon_shield_dmg0_world", %ZOMBIE_DRAGON_SHIELD_CRAFT, %ZOMBIE_DRAGON_SHIELD_TAKEN, %ZOMBIE_DRAGON_SHIELD_PICKUP);
    clientfield::register("allplayers", "ds_ammo", 12000, 1, "int");
    clientfield::register("allplayers", "burninate", 12000, 1, "counter");
    clientfield::register("allplayers", "burninate_upgraded", 12000, 1, "counter");
    clientfield::register("actor", "dragonshield_snd_projectile_impact", 12000, 1, "counter");
    clientfield::register("vehicle", "dragonshield_snd_projectile_impact", 12000, 1, "counter");
    clientfield::register("actor", "dragonshield_snd_zombie_knockdown", 12000, 1, "counter");
    clientfield::register("vehicle", "dragonshield_snd_zombie_knockdown", 12000, 1, "counter");
    level flag::init("dragon_shield_used");
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    level.weaponriotshield = getweapon("dragonshield");
    zm_equipment::register("dragonshield", %ZOMBIE_DRAGON_SHIELD_PICKUP, %ZOMBIE_DRAGON_SHIELD_HINT, undefined, "riotshield");
    level.var_cff260cc = getweapon("dragonshield_upgraded");
    zm_equipment::register("dragonshield_upgraded", %ZOMBIE_DRAGON_SHIELD_UPGRADE_PICKUP, %ZOMBIE_DRAGON_SHIELD_HINT, undefined, "riotshield");
    level.var_7ba638ea = getweapon("dragonshield_projectile");
    level.var_855a12ba = getweapon("dragonshield_projectile_upgraded");
    level.riotshield_melee_power = &function_71d88f26;
    level.should_shield_absorb_damage = &should_shield_absorb_damage;
    zombie_utility::set_zombie_var("dragonshield_proximity_fling_radius", 96);
    zombie_utility::set_zombie_var("dragonshield_proximity_knockdown_radius", -128);
    zombie_utility::set_zombie_var("dragonshield_cylinder_radius", -76);
    zombie_utility::set_zombie_var("dragonshield_fling_range", 480);
    zombie_utility::set_zombie_var("dragonshield_gib_range", 900);
    zombie_utility::set_zombie_var("dragonshield_gib_damage", 75);
    zombie_utility::set_zombie_var("dragonshield_knockdown_range", 1200);
    zombie_utility::set_zombie_var("dragonshield_knockdown_damage", 15);
    zombie_utility::set_zombie_var("dragonshield_projectile_lifetime", 1.1);
    level.var_d73afd29 = [];
    level.var_d73afd29[level.var_d73afd29.size] = "guts";
    level.var_d73afd29[level.var_d73afd29.size] = "right_arm";
    level.var_d73afd29[level.var_d73afd29.size] = "left_arm";
    level.var_337d1ed2 = &zombie_knockdown;
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0xff136aa5, Offset: 0xe48
// Size: 0x17c
function __main__() {
    zm_equipment::register_for_level("dragonshield");
    zm_equipment::include("dragonshield");
    zm_equipment::set_ammo_driven("dragonshield", level.weaponriotshield.startammo, 1);
    zm_equipment::register_for_level("dragonshield_upgraded");
    zm_equipment::include("dragonshield_upgraded");
    zm_equipment::set_ammo_driven("dragonshield_upgraded", level.var_cff260cc.startammo, 1);
    zombie_utility::set_zombie_var("riotshield_fling_damage_shield", 100);
    zombie_utility::set_zombie_var("riotshield_knockdown_damage_shield", 15);
    zombie_utility::set_zombie_var("riotshield_fling_range", 120);
    zombie_utility::set_zombie_var("riotshield_gib_range", 120);
    zombie_utility::set_zombie_var("riotshield_knockdown_range", 120);
    /#
        level thread function_a3a9c2dc();
    #/
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0xd74ed34a, Offset: 0xfd0
// Size: 0x1c
function on_player_connect() {
    self thread function_2de246fd();
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0x2bdd36e6, Offset: 0xff8
// Size: 0xac
function function_2de246fd() {
    self endon(#"disconnect");
    while (isdefined(self)) {
        self waittill(#"weapon_change", newweapon);
        if (newweapon.isriotshield) {
            break;
        }
    }
    self notify(#"hide_equipment_hint_text");
    level flag::set("dragon_shield_used");
    util::wait_network_frame();
    self.var_ed53639f = 1;
    zm_equipment::show_hint_text(%ZOMBIE_DRAGON_SHIELD_HINT, 5);
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0x5f865fd2, Offset: 0x10b0
// Size: 0x7c
function on_player_spawned() {
    self thread function_98962bde();
    self thread function_9fdb0cd6();
    self thread function_3fbc315a();
    self.player_shield_apply_damage = &function_247d568b;
    self.riotshield_damage_absorb_callback = &riotshield_damage_absorb_callback;
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0xf9520209, Offset: 0x1138
// Size: 0xa0
function function_98962bde() {
    self notify(#"hash_34db92fa");
    self endon(#"hash_34db92fa");
    self endon(#"disconnect");
    while (isdefined(self)) {
        level waittill(#"start_of_round");
        if (isdefined(self.hasriotshield) && isdefined(self) && self.hasriotshield) {
            self zm_equipment::change_ammo(self.weaponriotshield, 1);
            self thread function_7221d39f(self.weaponriotshield);
        }
    }
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0xe1f05a13, Offset: 0x11e0
// Size: 0xc8
function function_9fdb0cd6() {
    self notify(#"hash_9fdb0cd6");
    self endon(#"hash_9fdb0cd6");
    for (;;) {
        self waittill(#"equipment_ammo_changed", equipment);
        if (isstring(equipment)) {
            equipment = getweapon(equipment);
        }
        if (equipment == getweapon("dragonshield") || equipment == getweapon("dragonshield_upgraded")) {
            self thread function_7221d39f(equipment);
        }
    }
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0x7819e21a, Offset: 0x12b0
// Size: 0x68
function function_3fbc315a() {
    self notify(#"hash_3fbc315a");
    self endon(#"hash_3fbc315a");
    for (;;) {
        self waittill(#"zmb_max_ammo");
        wait 0.05;
        if (isdefined(self.hasriotshield) && self.hasriotshield) {
            self thread function_7221d39f(self.weaponriotshield);
        }
    }
}

// Namespace namespace_8215525
// Params 1, eflags: 0x0
// Checksum 0x7a1738ae, Offset: 0x1320
// Size: 0x64
function function_7221d39f(weapon) {
    wait 0.05;
    if (isdefined(self)) {
        ammo = self getweaponammoclip(weapon);
        self clientfield::set("ds_ammo", ammo);
    }
}

// Namespace namespace_8215525
// Params 10, eflags: 0x0
// Checksum 0x3f026e8b, Offset: 0x1390
// Size: 0x14a
function should_shield_absorb_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (isdefined(self.hasriotshield) && self.hasriotshield) {
        if (isdefined(eattacker.var_6c653628) && isdefined(self.hasriotshieldequipped) && self.hasriotshieldequipped && smeansofdeath == "MOD_EXPLOSIVE" && isdefined(eattacker) && eattacker.var_6c653628 && eattacker.var_9a02a614 === "napalm") {
            return 1;
        }
        if (isdefined(self.hasriotshieldequipped) && self.hasriotshieldequipped && smeansofdeath == "MOD_BURNED") {
            return 1;
        }
    }
    return riotshield::should_shield_absorb_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
}

// Namespace namespace_8215525
// Params 4, eflags: 0x0
// Checksum 0x8b78a4df, Offset: 0x14e8
// Size: 0x7c
function function_247d568b(idamage, bheld, fromcode, smod) {
    if (!isdefined(fromcode)) {
        fromcode = 0;
    }
    if (!isdefined(smod)) {
        smod = "MOD_UNKNOWN";
    }
    if (smod != "MOD_BURNED") {
        riotshield::player_damage_shield(idamage, bheld, fromcode, smod);
    }
}

// Namespace namespace_8215525
// Params 4, eflags: 0x0
// Checksum 0x4798668f, Offset: 0x1570
// Size: 0x24
function riotshield_damage_absorb_callback(eattacker, idamage, shitloc, smeansofdeath) {
    
}

// Namespace namespace_8215525
// Params 1, eflags: 0x0
// Checksum 0x4c466e01, Offset: 0x15a0
// Size: 0xe4
function function_71d88f26(weapon) {
    ammo = self getammocount(weapon);
    disabled = isdefined(self.var_a0a9409e) && self.var_a0a9409e;
    if (ammo > 0 && !disabled) {
        self zm_equipment::change_ammo(weapon, -1);
        self thread function_f894ad3e();
        self thread burninate(weapon);
        self thread function_7221d39f(weapon);
        return;
    }
    riotshield::riotshield_melee(weapon);
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0x9794b1e0, Offset: 0x1690
// Size: 0x158
function function_f894ad3e() {
    self playrumbleonentity("zod_shield_juke");
    if (self zm_equipment::get_player_equipment() == getweapon("dragonshield")) {
        var_e93a0115 = "burninate";
        var_c3937998 = level.var_7ba638ea;
    } else {
        var_e93a0115 = "burninate_upgraded";
        var_c3937998 = level.var_855a12ba;
    }
    self clientfield::increment(var_e93a0115);
    range = level.zombie_vars["dragonshield_knockdown_range"];
    view_pos = self getweaponmuzzlepoint();
    forward_view_angles = self getweaponforwarddir();
    end_pos = view_pos + range * forward_view_angles;
    var_aa911866 = magicbullet(var_c3937998, view_pos, end_pos, self);
}

// Namespace namespace_8215525
// Params 1, eflags: 0x0
// Checksum 0x92627d0, Offset: 0x17f0
// Size: 0x54
function function_c9b3ba45(e_attacker) {
    self.marked_for_death = 1;
    if (isdefined(self)) {
        self dodamage(self.health + 666, e_attacker.origin, e_attacker);
    }
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0x2970f0f7, Offset: 0x1850
// Size: 0x4c
function function_3f5e8a65() {
    level.var_9e674825++;
    if (!(level.var_9e674825 % 10)) {
        util::wait_network_frame();
        util::wait_network_frame();
        util::wait_network_frame();
    }
}

// Namespace namespace_8215525
// Params 1, eflags: 0x0
// Checksum 0x454d0bc0, Offset: 0x18a8
// Size: 0xa6
function burninate(w_weapon) {
    physicsexplosioncylinder(self.origin, 600, -16, 1);
    if (w_weapon == getweapon("dragonshield_upgraded")) {
        n_clientfield = 2;
    } else {
        n_clientfield = 1;
    }
    self thread function_8b8bd269(n_clientfield);
    self notify(#"hash_10fa975d", w_weapon);
}

// Namespace namespace_8215525
// Params 1, eflags: 0x0
// Checksum 0xd64c0cfb, Offset: 0x1958
// Size: 0x238
function function_8b8bd269(n_clientfield) {
    if (!isdefined(level.var_2f79fc7)) {
        level.var_2f79fc7 = [];
        level.var_490f6a0d = [];
        level.var_e4a96ed9 = [];
        level.var_1c1b4cce = [];
    }
    self function_459dacdd();
    self.var_3a6322f2 = 0;
    level.var_9e674825 = 0;
    for (i = 0; i < level.var_e4a96ed9.size; i++) {
        if (level.var_e4a96ed9[i].archetype === "zombie") {
            level.var_e4a96ed9[i] clientfield::set("dragon_strike_zombie_fire", n_clientfield);
        }
        level.var_e4a96ed9[i] thread function_64bd9bf5(self, level.var_1c1b4cce[i], i);
        function_3f5e8a65();
    }
    for (i = 0; i < level.var_2f79fc7.size; i++) {
        if (level.var_2f79fc7[i].archetype === "zombie") {
            level.var_2f79fc7[i] clientfield::set("dragon_strike_zombie_fire", n_clientfield);
        }
        level.var_2f79fc7[i] thread function_c25e3d4b(self, level.var_490f6a0d[i]);
        function_3f5e8a65();
    }
    self notify(#"hash_8c80a390", self.var_3a6322f2);
    level.var_2f79fc7 = [];
    level.var_490f6a0d = [];
    level.var_e4a96ed9 = [];
    level.var_1c1b4cce = [];
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0xc56dc6d3, Offset: 0x1b98
// Size: 0x976
function function_459dacdd() {
    view_pos = self getweaponmuzzlepoint();
    zombies = array::get_all_closest(view_pos, getaiteamarray(level.zombie_team), undefined, undefined, level.zombie_vars["dragonshield_knockdown_range"]);
    if (!isdefined(zombies)) {
        return;
    }
    knockdown_range_squared = level.zombie_vars["dragonshield_knockdown_range"] * level.zombie_vars["dragonshield_knockdown_range"];
    gib_range_squared = level.zombie_vars["dragonshield_gib_range"] * level.zombie_vars["dragonshield_gib_range"];
    fling_range_squared = level.zombie_vars["dragonshield_fling_range"] * level.zombie_vars["dragonshield_fling_range"];
    cylinder_radius_squared = level.zombie_vars["dragonshield_cylinder_radius"] * level.zombie_vars["dragonshield_cylinder_radius"];
    var_26ce68e3 = level.zombie_vars["dragonshield_proximity_knockdown_radius"] * level.zombie_vars["dragonshield_proximity_knockdown_radius"];
    var_36f73bb5 = level.zombie_vars["dragonshield_proximity_fling_radius"] * level.zombie_vars["dragonshield_proximity_fling_radius"];
    forward_view_angles = self getweaponforwarddir();
    end_pos = view_pos + vectorscale(forward_view_angles, level.zombie_vars["dragonshield_knockdown_range"]);
    /#
        if (2 == getdvarint("<dev string:x28>")) {
            near_circle_pos = view_pos + vectorscale(forward_view_angles, 2);
            circle(near_circle_pos, level.zombie_vars["<dev string:x3f>"], (1, 0, 0), 0, 0, 100);
            line(near_circle_pos, end_pos, (0, 0, 1), 1, 0, 100);
            circle(end_pos, level.zombie_vars["<dev string:x3f>"], (1, 0, 0), 0, 0, 100);
        }
    #/
    for (i = 0; i < zombies.size; i++) {
        if (!isdefined(zombies[i]) || !isalive(zombies[i])) {
            continue;
        }
        test_origin = zombies[i] getcentroid();
        test_range_squared = distancesquared(view_pos, test_origin);
        if (test_range_squared > knockdown_range_squared) {
            zombies[i] function_8e9a1613("range", (1, 0, 0));
            return;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (test_range_squared < var_36f73bb5) {
            level.var_e4a96ed9[level.var_e4a96ed9.size] = zombies[i];
            dist_mult = 1;
            fling_vec = vectornormalize(test_origin - view_pos);
            fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
            fling_vec = vectorscale(fling_vec, 50 + 50 * dist_mult);
            level.var_1c1b4cce[level.var_1c1b4cce.size] = fling_vec;
            zombies[i] thread function_41f7c503(self, 1, 0, 0);
            continue;
        } else if (test_range_squared < var_26ce68e3 && 0 > dot) {
            if (!isdefined(zombies[i].var_e1dbd63)) {
                zombies[i].var_e1dbd63 = level.var_337d1ed2;
            }
            level.var_2f79fc7[level.var_2f79fc7.size] = zombies[i];
            level.var_490f6a0d[level.var_490f6a0d.size] = 0;
            zombies[i] thread function_41f7c503(self, 0, 0, 1);
            continue;
        }
        if (0 > dot) {
            zombies[i] function_8e9a1613("dot", (1, 0, 0));
            continue;
        }
        radial_origin = pointonsegmentnearesttopoint(view_pos, end_pos, test_origin);
        if (distancesquared(test_origin, radial_origin) > cylinder_radius_squared) {
            zombies[i] function_8e9a1613("cylinder", (1, 0, 0));
            continue;
        }
        if (0 == zombies[i] damageconetrace(view_pos, self)) {
            zombies[i] function_8e9a1613("cone", (1, 0, 0));
            continue;
        }
        var_6ce0bf79 = level.zombie_vars["dragonshield_projectile_lifetime"];
        zombies[i].var_d8486721 = var_6ce0bf79 * sqrt(test_range_squared) / level.zombie_vars["dragonshield_knockdown_range"];
        if (test_range_squared < fling_range_squared) {
            level.var_e4a96ed9[level.var_e4a96ed9.size] = zombies[i];
            dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
            fling_vec = vectornormalize(test_origin - view_pos);
            if (5000 < test_range_squared) {
                fling_vec += vectornormalize(test_origin - radial_origin);
            }
            fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
            fling_vec = vectorscale(fling_vec, 50 + 50 * dist_mult);
            level.var_1c1b4cce[level.var_1c1b4cce.size] = fling_vec;
            zombies[i] thread function_41f7c503(self, 1, 0, 0);
            continue;
        }
        if (test_range_squared < gib_range_squared) {
            if (!isdefined(zombies[i].var_e1dbd63)) {
                zombies[i].var_e1dbd63 = level.var_337d1ed2;
            }
            level.var_2f79fc7[level.var_2f79fc7.size] = zombies[i];
            level.var_490f6a0d[level.var_490f6a0d.size] = 1;
            zombies[i] thread function_41f7c503(self, 0, 1, 0);
            continue;
        }
        if (!isdefined(zombies[i].var_e1dbd63)) {
            zombies[i].var_e1dbd63 = level.var_337d1ed2;
        }
        level.var_2f79fc7[level.var_2f79fc7.size] = zombies[i];
        level.var_490f6a0d[level.var_490f6a0d.size] = 0;
        zombies[i] thread function_41f7c503(self, 0, 0, 1);
    }
}

// Namespace namespace_8215525
// Params 2, eflags: 0x0
// Checksum 0x3b641b81, Offset: 0x2518
// Size: 0x8c
function function_8e9a1613(msg, color) {
    /#
        if (!getdvarint("<dev string:x28>")) {
            return;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        print3d(self.origin + (0, 0, 60), msg, color, 1, 1, 40);
    #/
}

// Namespace namespace_8215525
// Params 3, eflags: 0x0
// Checksum 0xfece0a27, Offset: 0x25b0
// Size: 0x190
function function_64bd9bf5(player, fling_vec, index) {
    delay = self.var_d8486721;
    if (isdefined(delay) && delay > 0.05) {
        wait delay;
    }
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (isdefined(self.var_23340a5d)) {
        self [[ self.var_23340a5d ]](player);
        return;
    }
    self function_c9b3ba45(player);
    if (self.health <= 0) {
        if (!(isdefined(self.no_damage_points) && self.no_damage_points)) {
            points = 10;
            if (!index) {
                points = zm_score::function_b2baf1b5();
            } else if (1 == index) {
                points = 30;
            }
            player zm_score::player_add_points("riotshield_fling", points);
        }
        self startragdoll();
        self launchragdoll(fling_vec);
        self.var_5eeaffc8 = 1;
        player.var_3a6322f2++;
    }
}

// Namespace namespace_8215525
// Params 2, eflags: 0x0
// Checksum 0x1434c65, Offset: 0x2748
// Size: 0x200
function zombie_knockdown(player, gib) {
    delay = self.var_d8486721;
    if (isdefined(delay) && delay > 0.05) {
        wait delay;
    }
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (!isvehicle(self)) {
        if (gib && !(isdefined(self.gibbed) && self.gibbed)) {
            self.a.gib_ref = array::random(level.var_d73afd29);
            self thread zombie_death::do_gib();
        } else {
            self zombie_utility::setup_zombie_knockdown(player);
        }
    }
    if (isdefined(level.var_d532d63)) {
        self [[ level.var_d532d63 ]](player, gib);
        return;
    }
    damage = level.zombie_vars["dragonshield_knockdown_damage"];
    self clientfield::increment("dragonshield_snd_zombie_knockdown");
    self.var_2a2a6dce = &function_21b74baa;
    self dodamage(damage, player.origin, player);
    if (!isvehicle(self)) {
        self animcustom(&function_2d1a5562);
    }
    if (self.health <= 0) {
        player.var_3a6322f2++;
    }
}

// Namespace namespace_8215525
// Params 0, eflags: 0x0
// Checksum 0xddf66692, Offset: 0x2950
// Size: 0x23c
function function_2d1a5562() {
    self notify(#"hash_21776edb");
    self endon(#"killanimscript");
    self endon(#"death");
    self endon(#"hash_21776edb");
    if (isdefined(self.marked_for_death) && self.marked_for_death) {
        return;
    }
    if (self.damageyaw <= -135 || self.damageyaw >= -121) {
        if (self.missinglegs) {
            fallanim = "zm_dragonshield_fall_front_crawl";
        } else {
            fallanim = "zm_dragonshield_fall_front";
        }
        getupanim = "zm_dragonshield_getup_belly_early";
    } else if (self.damageyaw > -135 && self.damageyaw < -45) {
        fallanim = "zm_dragonshield_fall_left";
        getupanim = "zm_dragonshield_getup_belly_early";
    } else if (self.damageyaw > 45 && self.damageyaw < -121) {
        fallanim = "zm_dragonshield_fall_right";
        getupanim = "zm_dragonshield_getup_belly_early";
    } else {
        fallanim = "zm_dragonshield_fall_back";
        if (randomint(100) < 50) {
            getupanim = "zm_dragonshield_getup_back_early";
        } else {
            getupanim = "zm_dragonshield_getup_back_late";
        }
    }
    self setanimstatefromasd(fallanim);
    self zombie_shared::donotetracks("dragonshield_fall_anim", self.var_2a2a6dce);
    if (isdefined(self.marked_for_death) && (!isdefined(self) || !isalive(self) || self.missinglegs || self.marked_for_death)) {
        return;
    }
    self setanimstatefromasd(getupanim);
    self zombie_shared::donotetracks("dragonshield_getup_anim");
}

// Namespace namespace_8215525
// Params 2, eflags: 0x0
// Checksum 0x70e869a4, Offset: 0x2b98
// Size: 0x88
function function_c25e3d4b(player, gib) {
    self endon(#"death");
    self clientfield::increment("dragonshield_snd_projectile_impact");
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (isdefined(self.var_e1dbd63)) {
        self [[ self.var_e1dbd63 ]](player, gib);
    }
}

// Namespace namespace_8215525
// Params 1, eflags: 0x0
// Checksum 0x9a1ea5bb, Offset: 0x2c28
// Size: 0x94
function function_21b74baa(note) {
    if (note == "zombie_knockdown_ground_impact") {
        playfx(level._effect["dragonshield_knockdown_ground"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        self clientfield::increment("dragonshield_snd_zombie_knockdown");
    }
}

// Namespace namespace_8215525
// Params 4, eflags: 0x0
// Checksum 0x327520dd, Offset: 0x2cc8
// Size: 0xd4
function function_41f7c503(player, fling, gib, knockdown) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (gib || !fling && knockdown) {
        if (25 > randomintrange(1, 100)) {
        }
    }
    if (fling) {
        if (30 > randomintrange(1, 100)) {
            player zm_audio::create_and_play_dialog("kill", "rocketshield");
        }
    }
}

/#

    // Namespace namespace_8215525
    // Params 0, eflags: 0x0
    // Checksum 0xd4ac19c9, Offset: 0x2da8
    // Size: 0xcc
    function function_a3a9c2dc() {
        level flagsys::wait_till("<dev string:x5c>");
        wait 1;
        zm_devgui::add_custom_devgui_callback(&function_6f901616);
        adddebugcommand("<dev string:x75>");
        adddebugcommand("<dev string:xc9>");
        adddebugcommand("<dev string:x130>");
        if (getdvarint("<dev string:x194>") > 0) {
            adddebugcommand("<dev string:x1a1>");
        }
    }

    // Namespace namespace_8215525
    // Params 1, eflags: 0x0
    // Checksum 0xfe4fb03f, Offset: 0x2e80
    // Size: 0x148
    function function_6f901616(cmd) {
        players = getplayers();
        retval = 0;
        switch (cmd) {
        case "<dev string:x207>":
            array::thread_all(players, &zm_devgui::zombie_devgui_equipment_give, "<dev string:x219>");
            retval = 1;
            break;
        case "<dev string:x226>":
            array::thread_all(players, &zm_devgui::zombie_devgui_equipment_give, "<dev string:x241>");
            retval = 1;
            break;
        case "<dev string:x257>":
            array::thread_all(players, &function_f685a6db);
            retval = 1;
            break;
        case "<dev string:x26b>":
            array::thread_all(players, &function_eeac5a22);
            retval = 1;
            break;
        }
        return retval;
    }

    // Namespace namespace_8215525
    // Params 0, eflags: 0x0
    // Checksum 0x4c8619ca, Offset: 0x2fd0
    // Size: 0x38
    function function_2449723c() {
        if (isdefined(self.var_9dc82bca)) {
            if (self.var_9dc82bca == gettime()) {
                return 1;
            }
        }
        self.var_9dc82bca = gettime();
        return 0;
    }

    // Namespace namespace_8215525
    // Params 0, eflags: 0x0
    // Checksum 0x20de0634, Offset: 0x3010
    // Size: 0x154
    function function_f685a6db() {
        if (self function_2449723c()) {
            return;
        }
        self notify(#"hash_f685a6db");
        self endon(#"hash_f685a6db");
        level flagsys::wait_till("<dev string:x5c>");
        self.var_f685a6db = !(isdefined(self.var_f685a6db) && self.var_f685a6db);
        if (self.var_f685a6db) {
            while (isdefined(self)) {
                damagemax = level.weaponriotshield.weaponstarthitpoints;
                if (isdefined(self.weaponriotshield)) {
                    damagemax = self.weaponriotshield.weaponstarthitpoints;
                }
                shieldhealth = self damageriotshield(0);
                if (shieldhealth == 0) {
                    shieldhealth = self damageriotshield(damagemax * -1);
                } else {
                    shieldhealth = self damageriotshield(int(damagemax / 10));
                }
                wait 0.5;
            }
        }
    }

    // Namespace namespace_8215525
    // Params 0, eflags: 0x0
    // Checksum 0x637e728c, Offset: 0x3170
    // Size: 0xe6
    function function_eeac5a22() {
        if (self function_2449723c()) {
            return;
        }
        self notify(#"hash_eeac5a22");
        self endon(#"hash_eeac5a22");
        level flagsys::wait_till("<dev string:x5c>");
        self.var_eeac5a22 = !(isdefined(self.var_eeac5a22) && self.var_eeac5a22);
        if (self.var_eeac5a22) {
            while (isdefined(self)) {
                if (isdefined(self.hasriotshield) && self.hasriotshield) {
                    self zm_equipment::change_ammo(self.weaponriotshield, 1);
                    self thread function_7221d39f(self.weaponriotshield);
                }
                wait 1;
            }
        }
    }

#/
