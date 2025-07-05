#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_hive_gun;

#namespace hive_gun;

// Namespace hive_gun
// Params 0, eflags: 0x2
// Checksum 0x703b4250, Offset: 0x110
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("hive_gun", &__init__, undefined, undefined);
}

// Namespace hive_gun
// Params 0, eflags: 0x0
// Checksum 0x4174ff25, Offset: 0x150
// Size: 0x14
function __init__() {
    init_shared();
}

