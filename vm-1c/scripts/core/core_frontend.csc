#using scripts/codescripts/struct;
#using scripts/core/_multi_extracam;
#using scripts/core/core_frontend_fx;
#using scripts/core/core_frontend_sound;
#using scripts/shared/scene_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace core_frontend;

// Namespace core_frontend
// Params 0, eflags: 0x0
// Checksum 0xcb5f049b, Offset: 0x198
// Size: 0x54
function main() {
    core_frontend_fx::main();
    core_frontend_sound::main();
    util::waitforclient(0);
    forcestreamxmodel("p7_monitor_wall_theater_01");
}

