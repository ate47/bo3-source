#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_e822cb43;

// Namespace namespace_e822cb43
// Params 0, eflags: 0x2
// namespace_e822cb43<file_0>::function_2dc19561
// Checksum 0x83664836, Offset: 0x1b0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_weap_shrink_ray", &__init__, &__main__, undefined);
}

// Namespace namespace_e822cb43
// Params 0, eflags: 0x1 linked
// namespace_e822cb43<file_0>::function_8c87d8eb
// Checksum 0x2acdbb0b, Offset: 0x1f8
// Size: 0x4c
function __init__() {
    clientfield::register("actor", "fun_size", 5000, 1, "int", &function_891e0258, 0, 0);
}

// Namespace namespace_e822cb43
// Params 0, eflags: 0x1 linked
// namespace_e822cb43<file_0>::function_5b6b9132
// Checksum 0x99ec1590, Offset: 0x250
// Size: 0x4
function __main__() {
    
}

// Namespace namespace_e822cb43
// Params 7, eflags: 0x1 linked
// namespace_e822cb43<file_0>::function_891e0258
// Checksum 0x37dc10be, Offset: 0x260
// Size: 0x60
function function_891e0258(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_ec8b2835(newval);
    self.var_f71294d7 = newval;
}

