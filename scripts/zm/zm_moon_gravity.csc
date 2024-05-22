#namespace namespace_a9e990ad;

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x88
// Size: 0x4
function init() {
    
}

// Namespace namespace_a9e990ad
// Params 7, eflags: 0x0
// Checksum 0xdb43cddc, Offset: 0x98
// Size: 0x78
function function_642dc173(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"death");
    self endon(#"entityshutdown");
    if (newval) {
        self.var_36de0da9 = 1;
        return;
    }
    self.var_36de0da9 = 0;
}

// Namespace namespace_a9e990ad
// Params 7, eflags: 0x0
// Checksum 0x20bb67be, Offset: 0x118
// Size: 0xc6
function function_20286238(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"death");
    self endon(#"entityshutdown");
    if (newval) {
        if (!isdefined(self.var_9f5aac3e)) {
            self.var_9f5aac3e = self playloopsound("zmb_moon_bg_airless");
        }
        return;
    }
    if (isdefined(self.var_9f5aac3e)) {
        self stoploopsound(self.var_9f5aac3e);
        self.var_9f5aac3e = undefined;
    }
}

