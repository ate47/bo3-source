#using scripts/zm/_zm_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_34c58dc;

// Namespace namespace_34c58dc
// Params 0, eflags: 0x1 linked
// namespace_34c58dc<file_0>::function_c35e6aab
// Checksum 0x4aed2560, Offset: 0x170
// Size: 0x4c
function init() {
    clientfield::register("vehicle", "sewer_current_fx", 9000, 1, "int", &function_1647aec4, 0, 0);
}

// Namespace namespace_34c58dc
// Params 7, eflags: 0x1 linked
// namespace_34c58dc<file_0>::function_1647aec4
// Checksum 0xd740ad0a, Offset: 0x1c8
// Size: 0xcc
function function_1647aec4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_7e61ace3)) {
            self.var_7e61ace3 = [];
        }
        self thread function_a39e4663(localclientnum);
        return;
    }
    self notify(#"hash_ab837d11");
    if (isdefined(self.var_7e61ace3[localclientnum])) {
        deletefx(localclientnum, self.var_7e61ace3[localclientnum], 0);
    }
}

// Namespace namespace_34c58dc
// Params 1, eflags: 0x1 linked
// namespace_34c58dc<file_0>::function_a39e4663
// Checksum 0xee601996, Offset: 0x2a0
// Size: 0x68
function function_a39e4663(localclientnum) {
    self endon(#"hash_ab837d11");
    while (true) {
        self.var_7e61ace3[localclientnum] = playfxontag(localclientnum, level._effect["current_effect"], self, "tag_origin");
        wait(0.05);
    }
}

