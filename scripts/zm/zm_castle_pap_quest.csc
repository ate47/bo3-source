#using scripts/zm/_zm_pack_a_punch;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/codescripts/struct;

#namespace namespace_155a700c;

// Namespace namespace_155a700c
// Params 0, eflags: 0x2
// Checksum 0x72592320, Offset: 0x140
// Size: 0x2e
function autoexec main() {
    register_clientfields();
    level._effect["pap_tp"] = "dlc1/castle/fx_castle_pap_reform";
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x0
// Checksum 0x3f56612b, Offset: 0x178
// Size: 0x4c
function register_clientfields() {
    clientfield::register("scriptmover", "pap_tp_fx", 5000, 1, "counter", &function_58d6b2a0, 0, 0);
}

// Namespace namespace_155a700c
// Params 7, eflags: 0x0
// Checksum 0xb5fad7c4, Offset: 0x1d0
// Size: 0x6c
function function_58d6b2a0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect["pap_tp"], self.origin);
}

