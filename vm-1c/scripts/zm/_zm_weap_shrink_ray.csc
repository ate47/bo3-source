#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;

#namespace zm_weap_shrink_ray;

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x2
// Checksum 0x83664836, Offset: 0x1b0
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_weap_shrink_ray", &__init__, &__main__, undefined);
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0x2acdbb0b, Offset: 0x1f8
// Size: 0x4c
function __init__() {
    clientfield::register("actor", "fun_size", 5000, 1, "int", &fun_size, 0, 0);
}

// Namespace zm_weap_shrink_ray
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x250
// Size: 0x4
function __main__() {
    
}

// Namespace zm_weap_shrink_ray
// Params 7, eflags: 0x0
// Checksum 0x37dc10be, Offset: 0x260
// Size: 0x60
function fun_size(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_ec8b2835(newval);
    self.shrunken = newval;
}

