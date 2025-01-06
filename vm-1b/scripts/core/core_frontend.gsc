#using scripts/codescripts/struct;
#using scripts/core/core_frontend_fx;
#using scripts/core/core_frontend_sound;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace core_frontend;

// Namespace core_frontend
// Params 0, eflags: 0x0
// Checksum 0xa9a01ff9, Offset: 0x148
// Size: 0x52
function main() {
    precache();
    core_frontend_fx::main();
    core_frontend_sound::main();
    setdvar("compassmaxrange", "2100");
}

// Namespace core_frontend
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1a8
// Size: 0x2
function precache() {
    
}

