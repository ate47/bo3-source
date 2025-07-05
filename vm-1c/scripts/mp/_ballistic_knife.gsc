#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_ballistic_knife;

#namespace ballistic_knife;

// Namespace ballistic_knife
// Params 0, eflags: 0x2
// Checksum 0x852db5ef, Offset: 0x138
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("ballistic_knife", &__init__, undefined, undefined);
}

// Namespace ballistic_knife
// Params 0, eflags: 0x0
// Checksum 0xf5f2a142, Offset: 0x178
// Size: 0x14
function __init__() {
    init_shared();
}

