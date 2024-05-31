#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace planemortar;

// Namespace planemortar
// Params 0, eflags: 0x2
// namespace_fa29b58e<file_0>::function_2dc19561
// Checksum 0x4fda7bb, Offset: 0x140
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("planemortar", &__init__, undefined, undefined);
}

// Namespace planemortar
// Params 0, eflags: 0x1 linked
// namespace_fa29b58e<file_0>::function_8c87d8eb
// Checksum 0x527c0c8, Offset: 0x180
// Size: 0x5c
function __init__() {
    level.planemortarexhaustfx = "killstreaks/fx_ls_exhaust_afterburner";
    clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
}

// Namespace planemortar
// Params 7, eflags: 0x1 linked
// namespace_fa29b58e<file_0>::function_3d63af51
// Checksum 0xfe15e5f4, Offset: 0x1e8
// Size: 0x84
function planemortar_contrail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self endon(#"entityshutdown");
    if (newval) {
        self.fx = playfxontag(localclientnum, level.planemortarexhaustfx, self, "tag_fx");
    }
}

