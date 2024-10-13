#using scripts/mp/_challenges;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;

#using_animtree("mp_vehicles");

#namespace destructible;

// Namespace destructible
// Params 0, eflags: 0x2
// Checksum 0xf6e8d8a9, Offset: 0x420
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("destructible", &__init__, undefined, undefined);
}

// Namespace destructible
// Params 0, eflags: 0x1 linked
// Checksum 0x28af7e00, Offset: 0x460
// Size: 0x174
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
// Params 0, eflags: 0x1 linked
// Checksum 0xc9b5a225, Offset: 0x5e0
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
// Params 0, eflags: 0x1 linked
// Checksum 0x1364f78e, Offset: 0x720
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
// Params 3, eflags: 0x1 linked
// Checksum 0x283168f7, Offset: 0x7e0
// Size: 0xfc
function physics_explosion_and_rumble(origin, radius, physics_explosion) {
    var_7d0c93e1 = function_aeee3204();
    var_7d0c93e1.in_use = 1;
    var_7d0c93e1.origin = origin;
    assert(radius <= pow(2, 10) - 1);
    if (isdefined(physics_explosion) && physics_explosion) {
        radius += 1 << 9;
    }
    wait 0.05;
    var_7d0c93e1 clientfield::set("start_destructible_explosion", radius);
    var_7d0c93e1.in_use = 0;
}

// Namespace destructible
// Params 3, eflags: 0x1 linked
// Checksum 0x7ae1bc34, Offset: 0x8e8
// Size: 0x3f2
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
// Params 1, eflags: 0x1 linked
// Checksum 0x5670904a, Offset: 0xce8
// Size: 0x124
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
// Params 2, eflags: 0x1 linked
// Checksum 0x6bfc082b, Offset: 0xe18
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
// Params 2, eflags: 0x1 linked
// Checksum 0x6b217750, Offset: 0xf60
// Size: 0x114
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
// Params 2, eflags: 0x1 linked
// Checksum 0xb41d05fb, Offset: 0x1080
// Size: 0x1ac
function car_explosion(attacker, physics_explosion) {
    if (isdefined(self.car_dead) && self.car_dead) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0xa7463f20, Offset: 0x1238
// Size: 0xc8
function tank_grenade_stuck_think() {
    self endon(#"destructible_base_piece_death");
    self endon(#"death");
    for (;;) {
        missile = self waittill(#"grenade_stuck");
        if (!isdefined(missile) || !isdefined(missile.model)) {
            continue;
        }
        if (missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world") {
            self thread tank_grenade_stuck_explode(missile);
        }
    }
}

// Namespace destructible
// Params 1, eflags: 0x1 linked
// Checksum 0x9c9944a3, Offset: 0x1308
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
// Params 1, eflags: 0x1 linked
// Checksum 0x17cf4082, Offset: 0x1438
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
// Params 0, eflags: 0x1 linked
// Checksum 0xf2529244, Offset: 0x14a8
// Size: 0x64
function car_death_think() {
    self endon(#"car_dead");
    self.car_dead = 0;
    self thread car_death_notify();
    attacker = self waittill(#"destructible_base_piece_death");
    if (isdefined(self)) {
        self thread car_explosion(attacker, 0);
    }
}

// Namespace destructible
// Params 0, eflags: 0x1 linked
// Checksum 0x4d4a9d3e, Offset: 0x1518
// Size: 0xd8
function car_grenade_stuck_think() {
    self endon(#"destructible_base_piece_death");
    self endon(#"car_dead");
    self endon(#"death");
    for (;;) {
        missile = self waittill(#"grenade_stuck");
        if (!isdefined(missile) || !isdefined(missile.model)) {
            continue;
        }
        if (missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world") {
            self thread car_grenade_stuck_explode(missile);
        }
    }
}

// Namespace destructible
// Params 1, eflags: 0x1 linked
// Checksum 0xe4ddb076, Offset: 0x15f8
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
// Params 1, eflags: 0x1 linked
// Checksum 0xbbd7beb6, Offset: 0x1730
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
// Params 0, eflags: 0x1 linked
// Checksum 0xa24192d6, Offset: 0x17a8
// Size: 0x3a
function car_death_notify() {
    self endon(#"car_dead");
    attacker = self waittill(#"death");
    self notify(#"destructible_base_piece_death", attacker);
}

// Namespace destructible
// Params 1, eflags: 0x1 linked
// Checksum 0xe8cb223d, Offset: 0x17f0
// Size: 0x4c
function car_fire_think(attacker) {
    self endon(#"death");
    wait randomintrange(7, 10);
    self thread car_explosion(attacker);
}

// Namespace destructible
// Params 5, eflags: 0x1 linked
// Checksum 0x43158b3b, Offset: 0x1848
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
// Params 3, eflags: 0x1 linked
// Checksum 0x38060ae6, Offset: 0x1970
// Size: 0x64
function breakafter(time, damage, piece) {
    self notify(#"breakafter");
    self endon(#"breakafter");
    wait time;
    self dodamage(damage, self.origin, undefined, undefined);
}

// Namespace destructible
// Params 3, eflags: 0x1 linked
// Checksum 0x262f1612, Offset: 0x19e0
// Size: 0x174
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
// Params 3, eflags: 0x1 linked
// Checksum 0x26ef00b1, Offset: 0x1b60
// Size: 0x15c
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
// Params 3, eflags: 0x1 linked
// Checksum 0x2e08145c, Offset: 0x1cc8
// Size: 0x15c
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

