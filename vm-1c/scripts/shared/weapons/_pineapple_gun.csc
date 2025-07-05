#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace sticky_grenade;

// Namespace sticky_grenade
// Params 0, eflags: 0x2
// Checksum 0xffb22d9f, Offset: 0x130
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("pineapple_gun", &__init__, undefined, undefined);
}

// Namespace sticky_grenade
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x170
// Size: 0x4
function __init__() {
    
}

