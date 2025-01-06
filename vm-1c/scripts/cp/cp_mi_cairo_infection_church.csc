#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace church;

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0xb428c5bf, Offset: 0x198
// Size: 0x14
function main() {
    init_clientfields();
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x7fda2da8, Offset: 0x1b8
// Size: 0x94
function init_clientfields() {
    clientfield::register("world", "light_church_int_cath_all", 1, 1, "int", &function_1fa35d0a, 0, 0);
    clientfield::register("world", "toggle_cathedral_fog_banks", 1, 1, "int", &function_4ab4a437, 0, 0);
}

// Namespace church
// Params 7, eflags: 0x0
// Checksum 0xa37e4494, Offset: 0x258
// Size: 0x84
function function_1fa35d0a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        exploder::exploder("light_church_int_cath_all");
        return;
    }
    exploder::stop_exploder("light_church_int_cath_all");
}

// Namespace church
// Params 7, eflags: 0x0
// Checksum 0xf70a2d7c, Offset: 0x2e8
// Size: 0x8c
function function_4ab4a437(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4780a11e = 0;
    if (newval == 1) {
        var_4780a11e = 2;
    } else {
        var_4780a11e = 0;
    }
    setworldfogactivebank(localclientnum, var_4780a11e);
}

