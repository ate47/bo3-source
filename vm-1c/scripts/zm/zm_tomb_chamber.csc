#using scripts/zm/_zm_utility;
#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;

#namespace namespace_a528e918;

// Namespace namespace_a528e918
// Params 0, eflags: 0x2
// namespace_a528e918<file_0>::function_2dc19561
// Checksum 0x316af679, Offset: 0x140
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_tomb_chamber", &__init__, undefined, undefined);
}

// Namespace namespace_a528e918
// Params 0, eflags: 0x1 linked
// namespace_a528e918<file_0>::function_8c87d8eb
// Checksum 0xe27b5683, Offset: 0x180
// Size: 0x4c
function __init__() {
    clientfield::register("scriptmover", "divider_fx", 21000, 1, "counter", &function_fa586bee, 0, 0);
}

// Namespace namespace_a528e918
// Params 7, eflags: 0x1 linked
// namespace_a528e918<file_0>::function_fa586bee
// Checksum 0x68ecc20c, Offset: 0x1d8
// Size: 0xa6
function function_fa586bee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        for (i = 1; i <= 9; i++) {
            playfxontag(localclientnum, level._effect["crypt_wall_drop"], self, "tag_fx_dust_0" + i);
        }
    }
}

