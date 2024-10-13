#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_zurich_newworld_fx;

// Namespace cp_mi_zurich_newworld_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x9baaa0ab, Offset: 0xf8
// Size: 0x4c
function main() {
    clientfield::register("world", "set_fog_bank", 1, 2, "int", &set_fog_bank, 0, 0);
}

// Namespace cp_mi_zurich_newworld_fx
// Params 7, eflags: 0x1 linked
// Checksum 0xad1477c8, Offset: 0x150
// Size: 0x12e
function set_fog_bank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
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

