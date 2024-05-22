#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace weaponobjects;

// Namespace weaponobjects
// Params 0, eflags: 0x2
// Checksum 0xe878a9fe, Offset: 0x298
// Size: 0x34
function function_2dc19561() {
    system::register("weaponobjects", &__init__, undefined, undefined);
}

// Namespace weaponobjects
// Params 0, eflags: 0x1 linked
// Checksum 0x7888b3e, Offset: 0x2d8
// Size: 0x44
function __init__() {
    init_shared();
    level setupscriptmovercompassicons();
    level setupmissilecompassicons();
}

// Namespace weaponobjects
// Params 0, eflags: 0x1 linked
// Checksum 0x86400493, Offset: 0x328
// Size: 0xc2
function setupscriptmovercompassicons() {
    if (!isdefined(level.scriptmovercompassicons)) {
        level.scriptmovercompassicons = [];
    }
    level.scriptmovercompassicons["wpn_t7_turret_emp_core"] = "compass_empcore_white";
    level.scriptmovercompassicons["t6_wpn_turret_ads_world"] = "compass_guardian_white";
    level.scriptmovercompassicons["veh_t7_drone_uav_enemy_vista"] = "compass_uav";
    level.scriptmovercompassicons["veh_t7_mil_vtol_fighter_mp"] = "compass_lightningstrike";
    level.scriptmovercompassicons["veh_t7_drone_rolling_thunder"] = "compass_lodestar";
    level.scriptmovercompassicons["veh_t7_drone_srv_blimp"] = "t7_hud_minimap_hatr";
}

// Namespace weaponobjects
// Params 0, eflags: 0x1 linked
// Checksum 0x14dc09d4, Offset: 0x3f8
// Size: 0x5e
function setupmissilecompassicons() {
    if (!isdefined(level.missilecompassicons)) {
        level.missilecompassicons = [];
    }
    if (isdefined(getweapon("drone_strike"))) {
        level.missilecompassicons[getweapon("drone_strike")] = "compass_lodestar";
    }
}

