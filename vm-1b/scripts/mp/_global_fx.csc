#using scripts/codescripts/struct;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;

#namespace global_fx;

// Namespace global_fx
// Params 0, eflags: 0x2
// Checksum 0x6c3bac7d, Offset: 0x150
// Size: 0x3a
function autoexec __init__sytem__() {
    system::register("global_fx", &__init__, &main, undefined);
}

// Namespace global_fx
// Params 0, eflags: 0x0
// Checksum 0xf21cad7e, Offset: 0x198
// Size: 0x12
function __init__() {
    function_26ae781b();
}

// Namespace global_fx
// Params 0, eflags: 0x0
// Checksum 0xefb0e73f, Offset: 0x1b8
// Size: 0x12
function main() {
    check_for_wind_override();
}

// Namespace global_fx
// Params 0, eflags: 0x0
// Checksum 0xfdfe2611, Offset: 0x1d8
// Size: 0x8a
function function_26ae781b() {
    setsaveddvar("enable_global_wind", 0);
    setsaveddvar("wind_global_vector", "0 0 0");
    setsaveddvar("wind_global_low_altitude", 0);
    setsaveddvar("wind_global_hi_altitude", 10000);
    setsaveddvar("wind_global_low_strength_percent", 0.5);
}

// Namespace global_fx
// Params 0, eflags: 0x0
// Checksum 0x894152e6, Offset: 0x270
// Size: 0x18
function check_for_wind_override() {
    if (isdefined(level.custom_wind_callback)) {
        level thread [[ level.custom_wind_callback ]]();
    }
}

