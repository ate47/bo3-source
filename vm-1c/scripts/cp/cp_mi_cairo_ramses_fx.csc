#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/codescripts/struct;

#namespace namespace_b9254c21;

// Namespace namespace_b9254c21
// Params 0, eflags: 0x1 linked
// namespace_b9254c21<file_0>::function_d290ebfa
// Checksum 0x6d6db820, Offset: 0x108
// Size: 0x94
function main() {
    clientfield::register("world", "defend_fog_banks", 1, 1, "int", &function_c109794d, 0, 0);
    clientfield::register("world", "start_fog_banks", 1, 1, "int", &function_d36983d1, 0, 0);
}

// Namespace namespace_b9254c21
// Params 7, eflags: 0x1 linked
// namespace_b9254c21<file_0>::function_c109794d
// Checksum 0x5cc72003, Offset: 0x1a8
// Size: 0xce
function function_c109794d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        setlitfogbank(localclientnum, -1, 1, 1);
        setworldfogactivebank(localclientnum, 2);
        setexposureactivebank(localclientnum, 2);
        setpbgactivebank(localclientnum, 2);
    }
}

// Namespace namespace_b9254c21
// Params 7, eflags: 0x1 linked
// namespace_b9254c21<file_0>::function_d36983d1
// Checksum 0xc03e9b45, Offset: 0x280
// Size: 0xc6
function function_d36983d1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        setlitfogbank(localclientnum, -1, 0, 1);
        setworldfogactivebank(localclientnum, 1);
        setexposureactivebank(localclientnum, 1);
        setpbgactivebank(localclientnum, 1);
    }
}

