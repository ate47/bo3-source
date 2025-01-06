#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_weapons;

#namespace namespace_48e69557;

// Namespace namespace_48e69557
// Params 0, eflags: 0x2
// Checksum 0x60faeea, Offset: 0x188
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_castle_rocketshield", &__init__, undefined, undefined);
}

// Namespace namespace_48e69557
// Params 0, eflags: 0x0
// Checksum 0xf652febd, Offset: 0x1c8
// Size: 0x4c
function __init__() {
    clientfield::register("allplayers", "rs_ammo", 1, 1, "int", &function_fddc5fe6, 0, 0);
}

// Namespace namespace_48e69557
// Params 7, eflags: 0x0
// Checksum 0x992abe1, Offset: 0x220
// Size: 0xa4
function function_fddc5fe6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, 0);
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
}

