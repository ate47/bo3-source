#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_hive_gun;

#namespace hive_gun;

// Namespace hive_gun
// Params 0, eflags: 0x2
// Checksum 0xc4384876, Offset: 0x110
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("hive_gun", &__init__, undefined, undefined);
}

// Namespace hive_gun
// Params 0, eflags: 0x0
// Checksum 0xdee306d2, Offset: 0x148
// Size: 0x12
function __init__() {
    init_shared();
}

