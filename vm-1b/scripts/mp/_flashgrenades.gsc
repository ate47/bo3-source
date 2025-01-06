#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_flashgrenades;

#namespace flashgrenades;

// Namespace flashgrenades
// Params 0, eflags: 0x2
// Checksum 0xde2303f2, Offset: 0x120
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("flashgrenades", &__init__, undefined, undefined);
}

// Namespace flashgrenades
// Params 0, eflags: 0x0
// Checksum 0xffcb801f, Offset: 0x158
// Size: 0x12
function __init__() {
    init_shared();
}

