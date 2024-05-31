#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace coop;

// Namespace coop
// Params 0, eflags: 0x2
// Checksum 0xa4072122, Offset: 0xf0
// Size: 0x84
function autoexec init() {
    registerclientfield("playercorpse", "hide_body", 1, 1, "int", &function_d630ecfc, 0);
    registerclientfield("toplayer", "killcam_menu", 1, 1, "int", &function_9f1677e1, 0);
}

// Namespace coop
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x180
// Size: 0x4
function main() {
    
}

// Namespace coop
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x190
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace coop
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1a0
// Size: 0x4
function onstartgametype() {
    
}

// Namespace coop
// Params 7, eflags: 0x1 linked
// Checksum 0x175a42be, Offset: 0x1b0
// Size: 0xd4
function function_9f1677e1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (getinkillcam(localclientnum)) {
        return;
    }
    if (!isdefined(self.var_20f03684)) {
        self.var_20f03684 = createluimenu(localclientnum, "CPKillcam");
    }
    if (newval) {
        openluimenu(localclientnum, self.var_20f03684);
        return;
    }
    closeluimenu(localclientnum, self.var_20f03684);
}

// Namespace coop
// Params 7, eflags: 0x1 linked
// Checksum 0xd464b116, Offset: 0x290
// Size: 0x8c
function function_d630ecfc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval && !getinkillcam(localclientnum)) {
        self hide();
        return;
    }
    self show();
}

