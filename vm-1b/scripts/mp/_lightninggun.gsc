#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_lightninggun;

#namespace lightninggun;

// Namespace lightninggun
// Params 0, eflags: 0x2
// Checksum 0x115d0a1f, Offset: 0x130
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("lightninggun", &__init__, undefined, undefined);
}

// Namespace lightninggun
// Params 0, eflags: 0x0
// Checksum 0xe8cadab3, Offset: 0x168
// Size: 0x12
function __init__() {
    init_shared();
}

