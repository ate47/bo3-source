#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_forced_malfunction;

// Namespace _gadget_forced_malfunction
// Params 0, eflags: 0x2
// Checksum 0xcb712a30, Offset: 0x1f8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_forced_malfunction", &__init__, undefined, undefined);
}

// Namespace _gadget_forced_malfunction
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x238
// Size: 0x4
function __init__() {
    
}

