#using scripts/zm/_zm_pack_a_punch;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/codescripts/struct;

#namespace zm_castle_pap_quest;

// Namespace zm_castle_pap_quest
// Params 0, eflags: 0x2
// Checksum 0x72592320, Offset: 0x140
// Size: 0x2e
function autoexec main() {
    register_clientfields();
    level._effect["pap_tp"] = "dlc1/castle/fx_castle_pap_reform";
}

// Namespace zm_castle_pap_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x3f56612b, Offset: 0x178
// Size: 0x4c
function register_clientfields() {
    clientfield::register("scriptmover", "pap_tp_fx", 5000, 1, "counter", &pap_tp_fx, 0, 0);
}

// Namespace zm_castle_pap_quest
// Params 7, eflags: 0x1 linked
// Checksum 0xb5fad7c4, Offset: 0x1d0
// Size: 0x6c
function pap_tp_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect["pap_tp"], self.origin);
}

