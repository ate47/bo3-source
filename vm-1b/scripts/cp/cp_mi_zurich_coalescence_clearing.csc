#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace namespace_29799936;

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// Checksum 0xc355defb, Offset: 0x2b8
// Size: 0x1a
function main() {
    init_clientfields();
    level.var_493ff3b4 = [];
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// Checksum 0x8a2200a5, Offset: 0x2e0
// Size: 0xca
function init_clientfields() {
    var_c0e9f8c3 = getminbitcountfornum(5);
    clientfield::register("world", "zurich_waterfall_bodies", 1, 1, "int", &function_3ccbd173, 1, 1);
    clientfield::register("world", "clearing_vinewall_init", 1, var_c0e9f8c3, "int", &function_e607bb59, 0, 0);
    clientfield::register("world", "clearing_vinewall_open", 1, var_c0e9f8c3, "int", &function_df47f2bb, 0, 0);
}

// Namespace namespace_29799936
// Params 7, eflags: 0x0
// Checksum 0xc2b3dddc, Offset: 0x3b8
// Size: 0x19b
function function_e607bb59(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval >= 1) {
        var_a77e33f7 = [];
        switch (newval) {
        case 1:
            var_a77e33f7 = array("p7_fxanim_cp_zurich_root_door_round_bundle");
            break;
        case 2:
            var_a77e33f7 = array("p7_fxanim_cp_zurich_root_door_left_bundle");
            break;
        case 3:
            var_a77e33f7 = array("p7_fxanim_cp_zurich_root_door_center_bundle");
            break;
        case 4:
            var_a77e33f7 = array("p7_fxanim_cp_zurich_root_door_right_bundle");
            break;
        case 5:
            var_a77e33f7 = array("p7_fxanim_cp_zurich_root_door_round_bundle", "p7_fxanim_cp_zurich_root_door_left_bundle", "p7_fxanim_cp_zurich_root_door_center_bundle", "p7_fxanim_cp_zurich_root_door_right_bundle");
            break;
        }
        foreach (var_648c7d5d in var_a77e33f7) {
            scene::add_scene_func(var_648c7d5d, &function_109ac1f6, "init");
            level thread scene::init(var_648c7d5d);
        }
    }
}

// Namespace namespace_29799936
// Params 7, eflags: 0x0
// Checksum 0x1d1a9567, Offset: 0x560
// Size: 0xdf
function function_df47f2bb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval >= 1) {
        switch (newval) {
        case 1:
            str_scene = "p7_fxanim_cp_zurich_root_door_round_bundle";
            break;
        case 2:
            str_scene = "p7_fxanim_cp_zurich_root_door_left_bundle";
            break;
        case 3:
            str_scene = "p7_fxanim_cp_zurich_root_door_center_bundle";
            break;
        case 4:
            str_scene = "p7_fxanim_cp_zurich_root_door_right_bundle";
            break;
        case 5:
            level notify(#"hash_32d9dc55");
            return;
        }
        level thread scene::play(str_scene);
        return;
    }
    level notify(#"hash_32d9dc55");
}

// Namespace namespace_29799936
// Params 1, eflags: 0x0
// Checksum 0x89c26705, Offset: 0x648
// Size: 0xab
function function_109ac1f6(a_ents) {
    level waittill(#"hash_32d9dc55");
    if (isdefined(a_ents) && isarray(a_ents)) {
        a_ents = array::remove_undefined(a_ents);
        if (a_ents.size) {
            foreach (e_ent in a_ents) {
                e_ent delete();
            }
        }
    }
}

// Namespace namespace_29799936
// Params 7, eflags: 0x0
// Checksum 0x21b837d5, Offset: 0x700
// Size: 0x97
function function_3ccbd173(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(level.var_493ff3b4[localclientnum]) && level.var_493ff3b4[localclientnum]) {
            return;
        }
        level.var_493ff3b4[localclientnum] = 1;
        level thread function_8f4d8a35();
        return;
    }
    level.var_493ff3b4[localclientnum] = undefined;
    level notify(#"hash_387877f0");
}

// Namespace namespace_29799936
// Params 0, eflags: 0x0
// Checksum 0xbf678e75, Offset: 0x7a0
// Size: 0x9a
function function_8f4d8a35() {
    level thread scene::play("cin_zur_16_02_clearing_vign_bodies01");
    level thread scene::play("cin_zur_16_02_clearing_vign_bodies02");
    level thread scene::play("cin_zur_16_02_clearing_vign_bodies03");
    level waittill(#"hash_387877f0");
    level thread scene::stop("cin_zur_16_02_clearing_vign_bodies01", 1);
    level thread scene::stop("cin_zur_16_02_clearing_vign_bodies02", 1);
    level thread scene::stop("cin_zur_16_02_clearing_vign_bodies03", 1);
}

