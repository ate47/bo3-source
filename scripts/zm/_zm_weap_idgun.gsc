#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/ai/zombie_vortex;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_42517170;

// Namespace namespace_42517170
// Params 0, eflags: 0x2
// Checksum 0xfad59313, Offset: 0x2f8
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("idgun", &init, &main, undefined);
}

// Namespace namespace_42517170
// Params 0, eflags: 0x0
// Checksum 0x74e324f9, Offset: 0x340
// Size: 0x44
function init() {
    callback::on_connect(&function_2bd571b9);
    zm::register_player_damage_callback(&function_b618ee82);
}

// Namespace namespace_42517170
// Params 0, eflags: 0x0
// Checksum 0x67009005, Offset: 0x390
// Size: 0xac
function main() {
    if (!isdefined(level.idgun_weapons)) {
        if (!isdefined(level.idgun_weapons)) {
            level.idgun_weapons = [];
        } else if (!isarray(level.idgun_weapons)) {
            level.idgun_weapons = array(level.idgun_weapons);
        }
        level.idgun_weapons[level.idgun_weapons.size] = getweapon("idgun");
    }
    level zm::register_vehicle_damage_callback(&function_61f631bc);
}

// Namespace namespace_42517170
// Params 1, eflags: 0x0
// Checksum 0xdd04d39a, Offset: 0x448
// Size: 0x3e
function is_idgun_damage(weapon) {
    if (isdefined(level.idgun_weapons)) {
        if (isinarray(level.idgun_weapons, weapon)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_42517170
// Params 1, eflags: 0x0
// Checksum 0x5e7ebeb, Offset: 0x490
// Size: 0x46
function function_9b7ac6a9(weapon) {
    if (is_idgun_damage(weapon) && zm_weapons::is_weapon_upgraded(weapon)) {
        return true;
    }
    return false;
}

// Namespace namespace_42517170
// Params 1, eflags: 0x0
// Checksum 0x4da0a6df, Offset: 0x4e0
// Size: 0x94
function function_6fbe2b2c(v_vortex_origin) {
    v_nearest_navmesh_point = getclosestpointonnavmesh(v_vortex_origin, 36, 15);
    if (isdefined(v_nearest_navmesh_point)) {
        f_distance = distance(v_vortex_origin, v_nearest_navmesh_point);
        if (f_distance < 41) {
            v_vortex_origin += (0, 0, 36);
        }
    }
    return v_vortex_origin;
}

// Namespace namespace_42517170
// Params 0, eflags: 0x0
// Checksum 0xd7829532, Offset: 0x580
// Size: 0x170
function function_2bd571b9() {
    self endon(#"disconnect");
    while (true) {
        weapon, position, radius, attacker, normal = self waittill(#"projectile_impact");
        position = function_6fbe2b2c(position + normal * 20);
        if (is_idgun_damage(weapon)) {
            var_12edbbc6 = radius * 1.8;
            if (function_9b7ac6a9(weapon)) {
                thread zombie_vortex::start_timed_vortex(position, radius, 9, 10, var_12edbbc6, self, weapon, 1, undefined, 0, 2);
            } else {
                thread zombie_vortex::start_timed_vortex(position, radius, 4, 5, var_12edbbc6, self, weapon, 1, undefined, 0, 1);
            }
            level notify(#"hash_2751215d", position, weapon, self);
        }
        wait(0.05);
    }
}

// Namespace namespace_42517170
// Params 10, eflags: 0x0
// Checksum 0x2cda0760, Offset: 0x6f8
// Size: 0x76
function function_b618ee82(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
    if (is_idgun_damage(sweapon)) {
        return 0;
    }
    return -1;
}

// Namespace namespace_42517170
// Params 15, eflags: 0x0
// Checksum 0xa6c1fe18, Offset: 0x778
// Size: 0xc4
function function_61f631bc(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(weapon)) {
        if (is_idgun_damage(weapon) && !(isdefined(self.veh_idgun_allow_damage) && self.veh_idgun_allow_damage)) {
            idamage = 0;
        }
    }
    return idamage;
}

