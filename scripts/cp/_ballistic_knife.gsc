#using scripts/shared/weapons/_ballistic_knife;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace ballistic_knife;

// Namespace ballistic_knife
// Params 0, eflags: 0x2
// Checksum 0x5394aadd, Offset: 0x138
// Size: 0x34
function function_2dc19561() {
    system::register("ballistic_knife", &__init__, undefined, undefined);
}

// Namespace ballistic_knife
// Params 0, eflags: 0x1 linked
// Checksum 0xfbffd01e, Offset: 0x178
// Size: 0x14
function __init__() {
    init_shared();
}

