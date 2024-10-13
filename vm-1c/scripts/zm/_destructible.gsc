#using scripts/zm/_challenges;
#using scripts/zm/gametypes/_globallogic_player;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/codescripts/struct;

#using_animtree("mp_vehicles");

#namespace destructible;

// Namespace destructible
// Params 0, eflags: 0x2
// Checksum 0xe2265f2a, Offset: 0x3f0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("destructible", &__init__, undefined, undefined);
}

// Namespace destructible
// Params 0, eflags: 0x1 linked
// Checksum 0x995d206c, Offset: 0x430
// Size: 0x134
function __init__() {
    level.destructible_callbacks = [];
    destructibles = getentarray("destructible", "targetname");
    clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int");
    if (destructibles.size <= 0) {
        return;
    }
    for (i = 0; i < destructibles.size; i++) {
        if (getsubstr(destructibles[i].destructibledef, 0, 4) == "veh_") {
            destructibles[i] thread destructible_car_death_think();
            destructibles[i] thread destructible_car_grenade_stuck_think();
        }
    }
    function_1a193c6();
}

// Namespace destructible
// Params 0, eflags: 0x1 linked
// Checksum 0x54662caf, Offset: 0x570
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
// Checksum 0xe786b521, Offset: 0x6b0
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
// Checksum 0x86560d2f, Offset: 0x770
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
// Checksum 0x9e4fe93, Offset: 0x878
// Size: 0x45e
function destructible_event_callback(destructible_event, attacker, weapon) {
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
        damage_type = tokens[2];
        explosion_radius_type = tokens[3];
        explosion_radius = 300;
        switch (damage_type) {
        case "concussive":
            if (explosion_radius_type == "large") {
                explosion_radius = 280;
            } else {
                explosion_radius = -36;
            }
            break;
        case "electrical":
            if (explosion_radius_type == "large") {
                explosion_radius = 60;
            } else {
                explosion_radius = -46;
            }
            break;
        case "incendiary":
            if (explosion_radius_type == "large") {
                explosion_radius = -6;
            } else {
                explosion_radius = -56;
            }
            break;
        }
    }
    if (issubstr(destructible_event, "simple_timed_explosion")) {
        self thread simple_timed_explosion(destructible_event, attacker);
        return;
    }
    switch (destructible_event) {
    case "destructible_car_explosion":
        self destructible_car_explosion(attacker);
        if (isdefined(weapon)) {
            self.destroyingweapon = weapon;
        }
        break;
    case "destructible_car_fire":
        self thread destructible_car_fire_think(attacker);
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
        self thread [[ level.destructible_callbacks[destructible_event] ]](destructible_event, attacker);
    }
}

// Namespace destructible
// Params 1, eflags: 0x1 linked
// Checksum 0xaa005df8, Offset: 0xce0
// Size: 0x104
function simple_explosion(attacker) {
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
// Checksum 0x7fafac95, Offset: 0xdf0
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
// Checksum 0xb92b401a, Offset: 0xf38
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
// Checksum 0xddaa5deb, Offset: 0x1058
// Size: 0x19c
function destructible_car_explosion(attacker, physics_explosion) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0xab8f7b95, Offset: 0x1200
// Size: 0x64
function destructible_car_death_think() {
    self endon(#"car_dead");
    self.car_dead = 0;
    self thread destructible_car_death_notify();
    attacker = self waittill(#"destructible_base_piece_death");
    if (isdefined(self)) {
        self thread destructible_car_explosion(attacker, 0);
    }
}

// Namespace destructible
// Params 0, eflags: 0x1 linked
// Checksum 0xd16d8a5, Offset: 0x1270
// Size: 0xd8
function destructible_car_grenade_stuck_think() {
    self endon(#"destructible_base_piece_death");
    self endon(#"car_dead");
    self endon(#"death");
    for (;;) {
        missile = self waittill(#"grenade_stuck");
        if (!isdefined(missile) || !isdefined(missile.model)) {
            continue;
        }
        if (missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "wpn_t7_c4_world") {
            self thread destructible_car_grenade_stuck_explode(missile);
        }
    }
}

// Namespace destructible
// Params 1, eflags: 0x1 linked
// Checksum 0x35cfcdb, Offset: 0x1350
// Size: 0x12c
function destructible_car_grenade_stuck_explode(missile) {
    self endon(#"destructible_base_piece_death");
    self endon(#"car_dead");
    self endon(#"death");
    owner = getmissileowner(missile);
    if (isdefined(owner) && missile.model == "wpn_t7_c4_world") {
        owner endon(#"disconnect");
        owner endon(#"weapon_object_destroyed");
        missile endon(#"picked_up");
        missile thread destructible_car_hacked_c4(self);
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
// Checksum 0xec415e1b, Offset: 0x1488
// Size: 0x6c
function destructible_car_hacked_c4(car) {
    car endon(#"destructible_base_piece_death");
    car endon(#"car_dead");
    car endon(#"death");
    self endon(#"death");
    self waittill(#"hacked");
    self notify(#"picked_up");
    car thread destructible_car_grenade_stuck_explode(self);
}

// Namespace destructible
// Params 0, eflags: 0x1 linked
// Checksum 0x42be802f, Offset: 0x1500
// Size: 0x3a
function destructible_car_death_notify() {
    self endon(#"car_dead");
    attacker = self waittill(#"death");
    self notify(#"destructible_base_piece_death", attacker);
}

// Namespace destructible
// Params 1, eflags: 0x1 linked
// Checksum 0xf1c72790, Offset: 0x1548
// Size: 0x4c
function destructible_car_fire_think(attacker) {
    self endon(#"death");
    wait randomintrange(7, 10);
    self thread destructible_car_explosion(attacker);
}

// Namespace destructible
// Params 5, eflags: 0x0
// Checksum 0x46c2ed14, Offset: 0x15a0
// Size: 0x11c
function codecallback_destructibleevent(event, param1, param2, param3, param4) {
    if (event == "broken") {
        notify_type = param1;
        attacker = param2;
        piece = param3;
        weapon = param4;
        destructible_event_callback(notify_type, attacker, weapon);
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
// Checksum 0x69821486, Offset: 0x16c8
// Size: 0x64
function breakafter(time, damage, piece) {
    self notify(#"breakafter");
    self endon(#"breakafter");
    wait time;
    self dodamage(damage, self.origin, undefined, undefined);
}

// Namespace destructible
// Params 3, eflags: 0x1 linked
// Checksum 0xd438c8a6, Offset: 0x1738
// Size: 0x174
function explosive_incendiary_explosion(attacker, explosion_radius, physics_explosion) {
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 380, 95, attacker, "MOD_BURNED", getweapon("incendiary_fire"));
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 380, 95);
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
// Checksum 0x9894917b, Offset: 0x18b8
// Size: 0x15c
function explosive_electrical_explosion(attacker, explosion_radius, physics_explosion) {
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 350, 80, attacker, "MOD_ELECTROCUTED");
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 350, 80);
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
// Checksum 0x80d73c74, Offset: 0x1a20
// Size: 0x15c
function explosive_concussive_explosion(attacker, explosion_radius, physics_explosion) {
    if (!isvehicle(self)) {
        offset = (0, 0, 5);
        if (isdefined(attacker)) {
            self radiusdamage(self.origin + offset, explosion_radius, 300, 50, attacker, "MOD_GRENADE");
        } else {
            self radiusdamage(self.origin + offset, explosion_radius, 300, 50);
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

