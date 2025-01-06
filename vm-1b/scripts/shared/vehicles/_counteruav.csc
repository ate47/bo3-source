#using scripts/codescripts/struct;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace counteruav;

// Namespace counteruav
// Params 0, eflags: 0x2
// Checksum 0x35192941, Offset: 0x1a8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("counteruav", &__init__, undefined, undefined);
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1e0
// Size: 0x2
function __init__() {
    
}

