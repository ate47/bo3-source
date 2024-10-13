#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_cairo_ramses_fx;

// Namespace cp_mi_cairo_ramses_fx
// Params 0, eflags: 0x0
// Checksum 0x6fc03e9, Offset: 0x108
// Size: 0x72
function main() {
    clientfield::register("world", "defend_fog_banks", 1, 1, "int", &function_c109794d, 0, 0);
    clientfield::register("world", "start_fog_banks", 1, 1, "int", &function_d36983d1, 0, 0);
}

// Namespace cp_mi_cairo_ramses_fx
// Params 7, eflags: 0x0
// Checksum 0x46e1a0fa, Offset: 0x188
// Size: 0x99
function function_c109794d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        setlitfogbank(localclientnum, -1, 1, 1);
        setworldfogactivebank(localclientnum, 2);
        setexposureactivebank(localclientnum, 2);
        setpbgactivebank(localclientnum, 2);
    }
}

// Namespace cp_mi_cairo_ramses_fx
// Params 7, eflags: 0x0
// Checksum 0x594cf0ba, Offset: 0x230
// Size: 0x99
function function_d36983d1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        setlitfogbank(localclientnum, -1, 0, 1);
        setworldfogactivebank(localclientnum, 1);
        setexposureactivebank(localclientnum, 1);
        setpbgactivebank(localclientnum, 1);
    }
}

