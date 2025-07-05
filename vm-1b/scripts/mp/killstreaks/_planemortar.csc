#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace planemortar;

// Namespace planemortar
// Params 0, eflags: 0x2
// Checksum 0x27c4d154, Offset: 0x140
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("planemortar", &__init__, undefined, undefined);
}

// Namespace planemortar
// Params 0, eflags: 0x0
// Checksum 0xc0eb5aa8, Offset: 0x178
// Size: 0x4a
function __init__() {
    level.planemortarexhaustfx = "killstreaks/fx_ls_exhaust_afterburner";
    clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
}

// Namespace planemortar
// Params 7, eflags: 0x0
// Checksum 0x7f17db66, Offset: 0x1d0
// Size: 0x7a
function planemortar_contrail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self endon(#"entityshutdown");
    if (newval) {
        self.fx = playfxontag(localclientnum, level.planemortarexhaustfx, self, "tag_fx");
    }
}

