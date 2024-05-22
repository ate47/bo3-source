#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/codescripts/struct;

#namespace namespace_bbfcd64f;

// Namespace namespace_bbfcd64f
// Params 0, eflags: 0x0
// Checksum 0x9baaa0ab, Offset: 0xf8
// Size: 0x4c
function main() {
    clientfield::register("world", "set_fog_bank", 1, 2, "int", &function_c49f36a3, 0, 0);
}

// Namespace namespace_bbfcd64f
// Params 7, eflags: 0x0
// Checksum 0xad1477c8, Offset: 0x150
// Size: 0x12e
function function_c49f36a3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        var_3a456a21 = 1;
    } else if (newval == 1) {
        var_3a456a21 = 2;
    } else if (newval == 2) {
        var_3a456a21 = 3;
    }
    for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
        setworldfogactivebank(localclientnum, var_3a456a21);
        if (var_3a456a21 == 3) {
            setexposureactivebank(localclientnum, var_3a456a21);
            continue;
        }
        if (var_3a456a21 == 1) {
            setexposureactivebank(localclientnum, var_3a456a21);
        }
    }
}

