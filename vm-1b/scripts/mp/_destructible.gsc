#using scripts/mp/_challenges;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#using_animtree("mp_vehicles");

#namespace destructible;

// Namespace destructible
// Params 0, eflags: 0x2
// Checksum 0xeb23e371, Offset: 0x420
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("destructible", &__init__, undefined, undefined);
}

// Namespace destructible
// Params 0, eflags: 0x0
// Checksum 0x172d5d23, Offset: 0x458
// Size: 0x11a
function __init__() {
    clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int");
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
// Checksum 0x12a94a0e, Offset: 0x580
// Size: 0x111
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
// Checksum 0x16683e24, Offset: 0x6a0
// Size: 0x86
function function_aeee3204() {
    foreach (explosion in level.var_ea11bb1e.var_111e074d) {
        if (!(isdefined(explosion.in_use) && explosion.in_use)) {
            return explosion;
        }
    }
    return level.var_ea11bb1e.var_111e074d[0];
}

// Namespace destructible
// Params 3, eflags: 0x0
// Checksum 0xd1d2fd91, Offset: 0x730
// Size: 0xbe
function physics_explosion_and_rumble(origin, radius, physics_explosion) {
    var_7d0c93e1 = function_aeee3204();
    var_7d0c93e1.in_use = 1;
    var_7d0c93e1.origin = origin;
    assert(radius <= pow(2, 10) - 1);
    if (isdefined(physics_explosion) && physics_explosion) {
        InvalidOpCode(0xc1, 9, 1, radius);
        // Unknown operator (0xc1, t7_1b, PC)
    }
    wait 0.05;
    var_7d0c93e1 clientfield::set("start_destructible_explosion", radius);
    var_7d0c93e1.in_use = 0;
}

// Namespace destructible
// Params 3, eflags: 0x0
// Checksum 0x74281ca0, Offset: 0x7f8
// Size: 0x2f5
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
    if (issubstr(destructible_event, "explosive")) {
        tokens = strtok(destructible_event, "_");
        explosion_radius_type = tokens[3];
        if (explosion_radius_type == "small") {
            explosion_radius = -106;
        } else if (explosion_radius_type == "large") {
            explosion_radius = 450;
        } else {
            explosion_radius = 300;
        }
    }
    if (issubstr(destructible_event, "simple_timed_explosion")) {
        self thread simple_timed_explosion(destructible_event, attacker);
        return;
    }
    switch (destructible_event) {
    case "destructible_car_explosion":
        self car_explosion(attacker);
        if (isdefined(weapon)) {
            self.destroyingweapon = weapon;
        }
        break;
    case "destructible_car_fire":
        level thread battlechatter::on_player_near_explodable(self, "car");
        self thread car_fire_think(attacker);
        if (isdefined(weapon)) {
            self.destroyingweapon = weapon;
        }
        break;
    case "explode":
        self thread simple_explosion(attacker);
        break;
    case "explode_complex":
        self thread complex_explosion(attacker, explosion_radius);
        break;
    case "destructible_explosive_incendiary_large":
    case "destructible_explosive_incendiary_small":
        self explosive_incendiary_explosion(attacker, explosion_radius, 0);
        if (isdefined(weapon)) {
            self.destroyingweapon = weapon;
        }
        break;
    case "destructible_explosive_electrical_large":
    case "destructible_explosive_electrical_small":
        self explosive_electrical_explosion(attacker, explosion_radius, 0);
        if (isdefined(weapon)) {
            self.destroyingweapon = weapon;
        }
        break;
    case "destructible_explosive_concussive_large":
    case "destructible_explosive_concussive_small":
        self explosive_concussive_explosion(attacker, explosion_radius, 0);
        if (isdefined(weapon)) {
            self.destroyingweapon = weapon;
        }
        break;
    default:
        break;
    }
    if (isdefined(level.destructible_callbacks[destructible_event])) {
        self thread [[ level.destructible_callbacks[destructible_event] ]](destructible_event, attacker, weapon);
    }
}

// Namespace destructible
// Params 1, eflags: 0x0
// Checksum 0xd156ef27, Offset: 0xaf8
// Size: 0xf2
function simple_explosion(attacker) {
    if (isdefined(self.exploded) && self.exploded) {
        return;
    }
    self.exploded = 1;
    offset = (0, 0, 5);
    self radiusdamage(self.origin + offset, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon("explodable_barrel"));
    physics_explosion_and_rumble(self.origin, -1, 1);
    if (isdefined(attacker)) {
        self dodamage(self.health + 10000, self.origin + offset, attacker);
        return;
    }
    self dodamage(self.health + 10000, self.origin + offset);
}

// Namespace destructible
// Params 2, eflags: 0x0
// Checksum 0xc8061f69, Offset: 0xbf8
// Size: 0xda
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
// Checksum 0x2bdc228d, Offset: 0xce0
// Size: 0xda
function complex_explosion(attacker, max_radius) {
    offset = (0, 0, 5);
    if (isdefined(attacker)) {
        self radiusdamage(self.origin + offset, max_radius, 300, 100, attacker);
    } else {
        self radiusdamage(self.origin + offset, max_radius, 300, 100);
    }
    physics_explosion_and_rumble(self.origin, max_radius, 1);
    if (isdefined(attacker)) {
        self dodamage(20000, self.origin + offset, attacker);
        return;
    }
    self dodamage(20000, self.origin + offset);
}

// Namespace destructible
// Params 2, eflags: 0x0
// Checksum 0x9717cc5d, Offset: 0xdc8
// Size: 0x13a
function car_explosion(attacker, physics_explosion) {
    if (self.car_dead) {
        return;
    }
    if (!isdefined(physics_explosion)) {
        physics_explosion = 1;
    }
    self notify(#"car_dead");
    self.car_dead = 1;
    if (isdefined(attacker)) {
        self radiusdamage(self.origin, 256, 300, 75, attacker, "MOD_EXPLOSIVE", getweapon("destructible_car"));
    } else {
        self radiusdamage(self.origin, 256, 300, 75);
    }
    physics_explosion_and_rumble(self.origin, -1, physics_explosion);
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
// Checksum 0xa25ecdd2, Offset: 0xf10
// Size: 0x95
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
// Checksum 0x2289a699, Offset: 0xfb0
// Size: 0xe2
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
// Checksum 0x73547b79, Offset: 0x10a0
// Size: 0x4a
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
// Checksum 0xbfe9f49e, Offset: 0x10f8
// Size: 0x52
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
// Checksum 0xac10db34, Offset: 0x1158
// Size: 0x9d
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
// Checksum 0x1f81c12f, Offset: 0x1200
// Size: 0xea
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
// Checksum 0x52d4f93e, Offset: 0x12f8
// Size: 0x52
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
// Checksum 0xe17ca804, Offset: 0x1358
// Size: 0x2b
function car_death_notify() {
    self endon(#"car_dead");
    self waittill(#"death", attacker);
    self notify(#"destructible_base_piece_death", attacker);
}

// Namespace destructible
// Params 1, eflags: 0x0
// Checksum 0xac43545b, Offset: 0x1390
// Size: 0x3a
function car_fire_think(attacker) {
    self endon(#"death");
    wait randomintrange(7, 10);
    self thread car_explosion(attacker);
}

// Namespace destructible
// Params 5, eflags: 0x0
// Checksum 0x78fcaa92, Offset: 0x13d8
// Size: 0xd2
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
// Checksum 0x965276de, Offset: 0x14b8
// Size: 0x4a
function breakafter(time, damage, piece) {
    self notify(#"breakafter");
    self endon(#"breakafter");
    wait time;
    self dodamage(damage, self.origin, undefined, undefined);
}

// Namespace destructible
// Params 3, eflags: 0x0
// Checksum 0xabda791e, Offset: 0x1510
// Size: 0x122
function explosive_incendiary_explosion(attacker, explosion_radius, physics_explosion) {
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_BURNED", getweapon("incendiary_fire"));
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
        }
        physics_explosion_and_rumble(self.origin, -1, physics_explosion);
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
// Checksum 0x12d2399b, Offset: 0x1640
// Size: 0x10a
function explosive_electrical_explosion(attacker, explosion_radius, physics_explosion) {
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_ELECTROCUTED");
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
        }
        physics_explosion_and_rumble(self.origin, -1, physics_explosion);
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
// Checksum 0x2ae85019, Offset: 0x1758
// Size: 0x10a
function explosive_concussive_explosion(attacker, explosion_radius, physics_explosion) {
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75, attacker, "MOD_GRENADE");
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 256, 75);
        }
        physics_explosion_and_rumble(self.origin, -1, physics_explosion);
    }
    if (isdefined(self.target)) {
        dest_clip = getent(self.target, "targetname");
        if (isdefined(dest_clip)) {
            dest_clip delete();
        }
    }
    self markdestructibledestroyed();
}

