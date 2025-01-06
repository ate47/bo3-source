#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace weaponobjects;

// Namespace weaponobjects
// Params 0, eflags: 0x2
// Checksum 0x7d19c464, Offset: 0x298
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("weaponobjects", &__init__, undefined, undefined);
}

// Namespace weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xef711d70, Offset: 0x2d0
// Size: 0x32
function __init__() {
    init_shared();
    level setupscriptmovercompassicons();
    level setupmissilecompassicons();
}

// Namespace weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x3bf691e4, Offset: 0x310
// Size: 0xa7
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
// Params 0, eflags: 0x0
// Checksum 0xd7dab26a, Offset: 0x3c0
// Size: 0x53
function setupmissilecompassicons() {
    if (!isdefined(level.missilecompassicons)) {
        level.missilecompassicons = [];
    }
    if (isdefined(getweapon("drone_strike"))) {
        level.missilecompassicons[getweapon("drone_strike")] = "compass_lodestar";
    }
}

