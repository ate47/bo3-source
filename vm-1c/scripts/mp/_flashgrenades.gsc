#using scripts/mp/_util;
#using scripts/shared/weapons/_flashgrenades;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace flashgrenades;

// Namespace flashgrenades
// Params 0, eflags: 0x2
// Checksum 0x8928e154, Offset: 0x120
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("flashgrenades", &__init__, undefined, undefined);
}

// Namespace flashgrenades
// Params 0, eflags: 0x1 linked
// Checksum 0xe6724fdc, Offset: 0x160
// Size: 0x14
function __init__() {
    init_shared();
}

