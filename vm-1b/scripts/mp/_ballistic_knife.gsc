#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_ballistic_knife;

#namespace ballistic_knife;

// Namespace ballistic_knife
// Params 0, eflags: 0x2
// Checksum 0x6d2b5245, Offset: 0x138
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("ballistic_knife", &__init__, undefined, undefined);
}

// Namespace ballistic_knife
// Params 0, eflags: 0x0
// Checksum 0xba3fe019, Offset: 0x170
// Size: 0x12
function __init__() {
    init_shared();
}

