#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace global_fx;

// Namespace global_fx
// Params 0, eflags: 0x2
// namespace_d6a4e7f5<file_0>::function_2dc19561
// Checksum 0x3da3d744, Offset: 0x138
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("global_fx", &__init__, &main, undefined);
}

// Namespace global_fx
// Params 0, eflags: 0x1 linked
// namespace_d6a4e7f5<file_0>::function_8c87d8eb
// Checksum 0x87812e0b, Offset: 0x180
// Size: 0x14
function __init__() {
    function_26ae781b();
}

// Namespace global_fx
// Params 0, eflags: 0x1 linked
// namespace_d6a4e7f5<file_0>::function_d290ebfa
// Checksum 0x4c072555, Offset: 0x1a0
// Size: 0x14
function main() {
    check_for_wind_override();
}

// Namespace global_fx
// Params 0, eflags: 0x1 linked
// namespace_d6a4e7f5<file_0>::function_26ae781b
// Checksum 0x6795a472, Offset: 0x1c0
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
// namespace_d6a4e7f5<file_0>::function_a660fd6f
// Checksum 0xedbefb1e, Offset: 0x260
// Size: 0x20
function check_for_wind_override() {
    if (isdefined(level.custom_wind_callback)) {
        level thread [[ level.custom_wind_callback ]]();
    }
}

