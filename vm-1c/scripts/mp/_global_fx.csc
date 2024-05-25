#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/codescripts/struct;

#namespace global_fx;

// Namespace global_fx
// Params 0, eflags: 0x2
// Checksum 0x16e132c9, Offset: 0x150
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("global_fx", &__init__, &main, undefined);
}

// Namespace global_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x87c3f446, Offset: 0x198
// Size: 0x14
function __init__() {
    function_26ae781b();
}

// Namespace global_fx
// Params 0, eflags: 0x1 linked
// Checksum 0xe3dce9dd, Offset: 0x1b8
// Size: 0x14
function main() {
    check_for_wind_override();
}

// Namespace global_fx
// Params 0, eflags: 0x1 linked
// Checksum 0xa958fc3b, Offset: 0x1d8
// Size: 0x94
function function_26ae781b() {
    setsaveddvar("enable_global_wind", 0);
    setsaveddvar("wind_global_vector", "0 0 0");
    setsaveddvar("wind_global_low_altitude", 0);
    setsaveddvar("wind_global_hi_altitude", 10000);
    setsaveddvar("wind_global_low_strength_percent", 0.5);
}

// Namespace global_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x206421fd, Offset: 0x278
// Size: 0x20
function check_for_wind_override() {
    if (isdefined(level.custom_wind_callback)) {
        level thread [[ level.custom_wind_callback ]]();
    }
}

