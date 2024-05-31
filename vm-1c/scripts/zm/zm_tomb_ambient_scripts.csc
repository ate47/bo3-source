#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_a2c37c4f;

// Namespace namespace_a2c37c4f
// Params 0, eflags: 0x1 linked
// namespace_a2c37c4f<file_0>::function_d290ebfa
// Checksum 0xcab87353, Offset: 0x150
// Size: 0x4c
function main() {
    clientfield::register("scriptmover", "zeppelin_fx", 21000, 1, "int", &function_3f9c04ed, 0, 0);
}

// Namespace namespace_a2c37c4f
// Params 7, eflags: 0x1 linked
// namespace_a2c37c4f<file_0>::function_3f9c04ed
// Checksum 0xc1bc4b49, Offset: 0x1a8
// Size: 0xac
function function_3f9c04ed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_1f4bb75 = playfxontag(localclientnum, level._effect["zeppelin_lights"], self, "tag_body");
        return;
    }
    if (isdefined(self.var_1f4bb75)) {
        stopfx(localclientnum, self.var_1f4bb75);
    }
}

