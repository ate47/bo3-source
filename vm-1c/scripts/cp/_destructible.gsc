#using scripts/cp/_achievements;
#using scripts/cp/_bb;
#using scripts/cp/_challenges;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#using_animtree("mp_vehicles");

#namespace destructible;

// Namespace destructible
// Params 0, eflags: 0x2
// Checksum 0xbaef40eb, Offset: 0x4d0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("destructible", &__init__, &__main__, undefined);
}

// Namespace destructible
// Params 0, eflags: 0x0
// Checksum 0xb0790c96, Offset: 0x518
// Size: 0x174
function __init__() {
    clientfield::register("scriptmover", "start_destructible_explosion", 1, 11, "int");
    level.destructible_callbacks = [];
    destructibles = getentarray("destructible", "targetname");
    if (destructibles.size <= 0) {
        return;
    }
    for (i = 0; i < destructibles.size; i++) {
        if (getsubstr(destructibles[i].destructibledef, 0, 4) == "veh_") {
            destructibles[i] thread car_death_think();
            destructibles[i] thread car_grenade_stuck_think();
            continue;
        }
        if (destructibles[i].destructibledef == "fxdest_upl_metal_tank_01") {
            destructibles[i] thread tank_grenade_stuck_think();
        }
    }
    function_1a193c6();
}

// Namespace destructible
// Params 0, eflags: 0x0
// Checksum 0x9d891769, Offset: 0x698
// Size: 0x13a
function __main__() {
    waittillframeend();
    var_bcf73ab6 = getentarray("destructible", "targetname");
    if (var_bcf73ab6.size <= 0) {
        return;
    }
    foreach (e_destructible in var_bcf73ab6) {
        if (issubstr(e_destructible.destructibledef, "explosive_concussive") || issubstr(e_destructible.destructibledef, "explosive_electrical") || issubstr(e_destructible.destructibledef, "explosive_incendiary")) {
            e_destructible thread oed::enable_thermal();
        }
    }
}

// Namespace destructible
// Params 0, eflags: 0x0
// Checksum 0xe687c0f6, Offset: 0x7e0
// Size: 0x134
function function_1a193c6() {
    level.var_ea11bb1e = spawnstruct();
    level.var_ea11bb1e.count = 0;
    level.var_ea11bb1e.var_111e074d = [];
    for (i = 0; i < 32; i++) {
        var_7d0c93e1 = spawn("script_model", (0, 0, 0));
        if (!isdefined(level.var_ea11bb1e.var_111e074d)) {
            level.var_ea11bb1e.var_111e074d = [];
        } else if (!isarray(level.var_ea11bb1e.var_111e074d)) {
            level.var_ea11bb1e.var_111e074d = array(level.var_ea11bb1e.var_111e074d);
        }
        level.var_ea11bb1e.var_111e074d[level.var_ea11bb1e.var_111e074d.size] = var_7d0c93e1;
    }
}

// Namespace destructible
// Params 0, eflags: 0x0
// Checksum 0x102b4a5a, Offset: 0x920
// Size: 0xb8
function function_aeee3204() {
    foreach (explosion in level.var_ea11bb1e.var_111e074d) {
        if (!(isdefined(explosion.in_use) && explosion.in_use)) {
            return explosion;
        }
    }
    return level.var_ea11bb1e.var_111e074d[0];
}

// Namespace destructible
// Params 4, eflags: 0x0
// Checksum 0x3646d451, Offset: 0x9e0
// Size: 0x154
function physics_explosion_and_rumble(origin, radius, var_824b40e2, var_34aa7e9b) {
    if (!isdefined(var_824b40e2)) {
        var_824b40e2 = 1;
    }
    if (!isdefined(var_34aa7e9b)) {
        var_34aa7e9b = 0;
    }
    var_7d0c93e1 = function_aeee3204();
    var_7d0c93e1.in_use = 1;
    var_7d0c93e1.origin = origin;
    wait 0.05;
    assert(radius <= pow(2, 10) - 1);
    var_e0d11135 = radius;
    if (var_824b40e2) {
        var_e0d11135 += 1 << 10;
    }
    if (var_34aa7e9b) {
        var_e0d11135 += 1 << 9;
    }
    var_7d0c93e1 clientfield::set("start_destructible_explosion", var_e0d11135);
    var_7d0c93e1.in_use = 0;
}

// Namespace destructible
// Params 3, eflags: 0x0
// Checksum 0x9432782d, Offset: 0xb40
// Size: 0x3ce
function event_callback(destructible_event, attacker, weapon) {
    explosion_radius = 0;
    if (issubstr(destructible_event, "explode") && destructible_event != "explode") {
        tokens = strtok(destructible_event, "_");
        explosion_radius = tokens[1];
        if (explosion_radius == "sm") {
            explosion_radius = -106;
        } else if (explosion_radius == "lg") {
            explosion_radius = 450;
        } else {
            explosion_radius = int(explosion_radius);
        }
        destructible_event = "explode_complex";
    }
    if (issubstr(destructible_event, "simple_timed_explosion")) {
        self thread simple_timed_explosion(destructible_event, attacker);
        return;
    }
    if (isdefined(weapon)) {
        self.destroyingweapon = weapon;
    }
    switch (destructible_event) {
    case "destructible_car_explosion":
        self car_explosion(attacker);
        break;
    case "destructible_car_fire":
        level thread battlechatter::function_bf5d6349(self, "car");
        self thread car_fire_think(attacker);
        break;
    case "explode":
        self thread simple_explosion(attacker);
        break;
    case "explode_complex":
        self thread complex_explosion(attacker, 300);
        break;
    case "destructible_explosive_incendiary_small":
        self explosive_incendiary_explosion(attacker, -26);
        break;
    case "destructible_explosive_incendiary_large":
        self explosive_incendiary_explosion(attacker, 265, 1);
        break;
    case "destructible_explosive_electrical_small":
        self explosive_electrical_explosion(attacker, -16);
        break;
    case "destructible_explosive_electrical_large":
        self explosive_electrical_explosion(attacker, 290, 1);
        break;
    case "destructible_explosive_concussive_small":
        self explosive_concussive_explosion(attacker, -16);
        break;
    case "destructible_explosive_concussive_large":
        self explosive_concussive_explosion(attacker, 275, 1);
        break;
    default:
        break;
    }
    if (isdefined(attacker) && isplayer(attacker)) {
        attacker matchrecordincrementcheckpointstat(skipto::function_52c50cb8(), "destructibles_destroyed");
    }
    bb::function_1a69bad6(self, attacker, destructible_event, explosion_radius);
    if (isdefined(level.destructible_callbacks[destructible_event])) {
        self thread [[ level.destructible_callbacks[destructible_event] ]](destructible_event, attacker);
    }
}

// Namespace destructible
// Params 1, eflags: 0x0
// Checksum 0xb75096cf, Offset: 0xf18
// Size: 0x4c
function car_fire_think(attacker) {
    self endon(#"death");
    wait randomintrange(7, 10);
    self thread car_explosion(attacker);
}

// Namespace destructible
// Params 1, eflags: 0x0
// Checksum 0xaa3e1c70, Offset: 0xf70
// Size: 0x124
function simple_explosion(attacker) {
    if (isdefined(self.exploded) && self.exploded) {
        return;
    }
    self.exploded = 1;
    offset = (0, 0, 5);
    self radiusdamage(self.origin + offset, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon("explodable_barrel"));
    physics_explosion_and_rumble(self.origin, -1, 0);
    if (isdefined(attacker)) {
        self dodamage(self.health + 10000, self.origin + offset, attacker);
        return;
    }
    self dodamage(self.health + 10000, self.origin + offset);
}

// Namespace destructible
// Params 2, eflags: 0x0
// Checksum 0xc52aa86a, Offset: 0x10a0
// Size: 0x13c
function simple_timed_explosion(destructible_event, attacker) {
    self endon(#"death");
    wait_times = [];
    str = getsubstr(destructible_event, 23);
    tokens = strtok(str, "_");
    for (i = 0; i < tokens.size; i++) {
        wait_times[wait_times.size] = int(tokens[i]);
    }
    if (wait_times.size <= 0) {
        wait_times[0] = 5;
        wait_times[1] = 10;
    }
    wait randomintrange(wait_times[0], wait_times[1]);
    simple_explosion(attacker);
}

// Namespace destructible
// Params 2, eflags: 0x0
// Checksum 0x70b2562f, Offset: 0x11e8
// Size: 0x124
function complex_explosion(attacker, max_radius) {
    offset = (0, 0, 5);
    if (isdefined(attacker)) {
        self radiusdamage(self.origin + offset, max_radius, 300, 100, attacker);
    } else {
        self radiusdamage(self.origin + offset, max_radius, 300, 100);
    }
    physics_explosion_and_rumble(self.origin + offset, max_radius, 0);
    if (isdefined(attacker)) {
        self dodamage(20000, self.origin + offset, attacker, 0);
        return;
    }
    self dodamage(20000, self.origin + offset);
}

// Namespace destructible
// Params 2, eflags: 0x0
// Checksum 0xde2c219b, Offset: 0x1318
// Size: 0x1c4
function car_explosion(attacker, physics_explosion) {
    if (isdefined(self.car_dead) && self.car_dead) {
        return;
    }
    if (!isdefined(physics_explosion)) {
        physics_explosion = 1;
    }
    self notify(#"car_dead");
    self.car_dead = 1;
    if (!isvehicle(self)) {
        if (isdefined(attacker)) {
            self radiusdamage(self.origin, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon("destructible_car"));
        } else {
            self radiusdamage(self.origin, 256, 300, 75);
        }
        physics_explosion_and_rumble(self.origin, -1, 0);
    }
    if (isdefined(attacker)) {
        attacker thread challenges::destroyed_car();
    }
    level.globalcarsdestroyed++;
    if (isdefined(attacker)) {
        self dodamage(self.health + 10000, self.origin + (0, 0, 1), attacker);
    } else {
        self dodamage(self.health + 10000, self.origin + (0, 0, 1));
    }
    self markdestructibledestroyed();
}

// Namespace destructible
// Params 0, eflags: 0x0
// Checksum 0x6ae7220d, Offset: 0x14e8
// Size: 0xc8
function tank_grenade_stuck_think() {
    self endon(#"destructible_base_piece_death");
    self endon(#"death");
    for (;;) {
        self waittill(#"grenade_stuck", missile);
        if (!isdefined(missile) || !isdefined(missile.model)) {
            continue;
        }
        if (missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world") {
            self thread tank_grenade_stuck_explode(missile);
        }
    }
}

// Namespace destructible
// Params 1, eflags: 0x0
// Checksum 0x4a9aee59, Offset: 0x15b8
// Size: 0x124
function tank_grenade_stuck_explode(missile) {
    self endon(#"destructible_base_piece_death");
    self endon(#"death");
    owner = getmissileowner(missile);
    if (isdefined(owner) && missile.model == "wpn_t7_c4_world") {
        owner endon(#"disconnect");
        owner endon(#"weapon_object_destroyed");
        missile endon(#"picked_up");
        missile thread tank_hacked_c4(self);
    }
    missile waittill(#"explode");
    if (isdefined(owner)) {
        self dodamage(self.health + 10000, self.origin + (0, 0, 1), owner);
        return;
    }
    self dodamage(self.health + 10000, self.origin + (0, 0, 1));
}

// Namespace destructible
// Params 1, eflags: 0x0
// Checksum 0x5f30ca38, Offset: 0x16e8
// Size: 0x64
function tank_hacked_c4(tank) {
    tank endon(#"destructible_base_piece_death");
    tank endon(#"death");
    self endon(#"death");
    self waittill(#"hacked");
    self notify(#"picked_up");
    tank thread tank_grenade_stuck_explode(self);
}

// Namespace destructible
// Params 0, eflags: 0x0
// Checksum 0x97d00261, Offset: 0x1758
// Size: 0x64
function car_death_think() {
    self endon(#"car_dead");
    self.car_dead = 0;
    self thread car_death_notify();
    self waittill(#"destructible_base_piece_death", attacker);
    if (isdefined(self)) {
        self thread car_explosion(attacker, 0);
    }
}

// Namespace destructible
// Params 0, eflags: 0x0
// Checksum 0x716f1a2f, Offset: 0x17c8
// Size: 0xd8
function car_grenade_stuck_think() {
    self endon(#"destructible_base_piece_death");
    self endon(#"car_dead");
    self endon(#"death");
    for (;;) {
        self waittill(#"grenade_stuck", missile);
        if (!isdefined(missile) || !isdefined(missile.model)) {
            continue;
        }
        if (missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world") {
            self thread car_grenade_stuck_explode(missile);
        }
    }
}

// Namespace destructible
// Params 1, eflags: 0x0
// Checksum 0xa4cd371, Offset: 0x18a8
// Size: 0x12c
function car_grenade_stuck_explode(missile) {
    self endon(#"destructible_base_piece_death");
    self endon(#"car_dead");
    self endon(#"death");
    owner = getmissileowner(missile);
    if (isdefined(owner) && missile.model == "wpn_t7_c4_world") {
        owner endon(#"disconnect");
        owner endon(#"weapon_object_destroyed");
        missile endon(#"picked_up");
        missile thread car_hacked_c4(self);
    }
    missile waittill(#"explode");
    if (isdefined(owner)) {
        self dodamage(self.health + 10000, self.origin + (0, 0, 1), owner);
        return;
    }
    self dodamage(self.health + 10000, self.origin + (0, 0, 1));
}

// Namespace destructible
// Params 1, eflags: 0x0
// Checksum 0x357ec4b1, Offset: 0x19e0
// Size: 0x6c
function car_hacked_c4(car) {
    car endon(#"destructible_base_piece_death");
    car endon(#"car_dead");
    car endon(#"death");
    self endon(#"death");
    self waittill(#"hacked");
    self notify(#"picked_up");
    car thread car_grenade_stuck_explode(self);
}

// Namespace destructible
// Params 0, eflags: 0x0
// Checksum 0xc8815dbb, Offset: 0x1a58
// Size: 0x3a
function car_death_notify() {
    self endon(#"car_dead");
    self waittill(#"death", attacker);
    self notify(#"destructible_base_piece_death", attacker);
}

// Namespace destructible
// Params 5, eflags: 0x0
// Checksum 0xb501ea33, Offset: 0x1aa0
// Size: 0x11c
function codecallback_destructibleevent(event, param1, param2, param3, param4) {
    if (event == "broken") {
        notify_type = param1;
        attacker = param2;
        piece = param3;
        weapon = param4;
        event_callback(notify_type, attacker, weapon);
        self notify(event, notify_type, attacker);
        return;
    }
    if (event == "breakafter") {
        piece = param1;
        time = param2;
        damage = param3;
        self thread breakafter(time, damage, piece);
    }
}

// Namespace destructible
// Params 3, eflags: 0x0
// Checksum 0x2d7ab1c2, Offset: 0x1bc8
// Size: 0x64
function breakafter(time, damage, piece) {
    self notify(#"breakafter");
    self endon(#"breakafter");
    wait time;
    self dodamage(damage, self.origin, undefined, undefined);
}

// Namespace destructible
// Params 3, eflags: 0x0
// Checksum 0xa7a30c58, Offset: 0x1c38
// Size: 0x1e4
function explosive_incendiary_explosion(attacker, explosion_radius, var_34aa7e9b) {
    if (!isdefined(var_34aa7e9b)) {
        var_34aa7e9b = 0;
    }
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 300, 10, attacker, "MOD_BURNED", getweapon("incendiary_fire"));
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 300, 10);
        }
        physics_explosion_and_rumble(self.origin, explosion_radius, 1, var_34aa7e9b);
        if (var_34aa7e9b) {
            level thread function_906eae90(self.origin, 80, 10);
        } else {
            level thread function_906eae90(self.origin, 50, 10);
        }
    }
    if (isdefined(self.target)) {
        dest_clip = getent(self.target, "targetname");
        if (isdefined(dest_clip)) {
            dest_clip delete();
        }
    }
    self markdestructibledestroyed();
}

// Namespace destructible
// Params 3, eflags: 0x0
// Checksum 0xe30d7a2e, Offset: 0x1e28
// Size: 0x84
function function_906eae90(v_origin, n_radius, n_time) {
    e_trig = spawn("trigger_radius_hurt", v_origin, 0, n_radius, n_radius);
    e_trig.var_75dbd7 = "heat";
    wait n_time;
    e_trig delete();
}

// Namespace destructible
// Params 3, eflags: 0x0
// Checksum 0xdfdf4049, Offset: 0x1eb8
// Size: 0x164
function explosive_electrical_explosion(attacker, explosion_radius, var_34aa7e9b) {
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 300, 10, attacker, "MOD_ELECTROCUTED");
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 300, 10);
        }
        physics_explosion_and_rumble(self.origin, explosion_radius, 1, var_34aa7e9b);
    }
    if (isdefined(self.target)) {
        dest_clip = getent(self.target, "targetname");
        if (isdefined(dest_clip)) {
            dest_clip delete();
        }
    }
    self markdestructibledestroyed();
}

// Namespace destructible
// Params 3, eflags: 0x0
// Checksum 0x53764405, Offset: 0x2028
// Size: 0x164
function explosive_concussive_explosion(attacker, explosion_radius, var_34aa7e9b) {
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 300, 10, attacker, "MOD_GRENADE");
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 300, 10);
        }
        physics_explosion_and_rumble(self.origin, explosion_radius, 1, var_34aa7e9b);
    }
    if (isdefined(self.target)) {
        dest_clip = getent(self.target, "targetname");
        if (isdefined(dest_clip)) {
            dest_clip delete();
        }
    }
    self markdestructibledestroyed();
}

