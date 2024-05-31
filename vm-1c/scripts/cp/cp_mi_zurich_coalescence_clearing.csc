#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_29799936;

// Namespace namespace_29799936
// Params 0, eflags: 0x1 linked
// Checksum 0xb9d1f322, Offset: 0x2b8
// Size: 0x20
function main() {
    init_clientfields();
    level.var_493ff3b4 = [];
}

// Namespace namespace_29799936
// Params 0, eflags: 0x1 linked
// Checksum 0xb362399e, Offset: 0x2e0
// Size: 0x104
function init_clientfields() {
    var_c0e9f8c3 = getminbitcountfornum(5);
    clientfield::register("world", "zurich_waterfall_bodies", 1, 1, "int", &function_3ccbd173, 1, 1);
    clientfield::register("world", "clearing_vinewall_init", 1, var_c0e9f8c3, "int", &function_e607bb59, 0, 0);
    clientfield::register("world", "clearing_vinewall_open", 1, var_c0e9f8c3, "int", &function_df47f2bb, 0, 0);
}

// Namespace namespace_29799936
// Params 7, eflags: 0x1 linked
// Checksum 0x9adeaff0, Offset: 0x3f0
// Size: 0x1fa
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
// Params 7, eflags: 0x1 linked
// Checksum 0xdae23cc2, Offset: 0x5f8
// Size: 0x106
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
// Params 1, eflags: 0x1 linked
// Checksum 0xf15a9a87, Offset: 0x708
// Size: 0xea
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
// Params 7, eflags: 0x1 linked
// Checksum 0x2ffdc6ee, Offset: 0x800
// Size: 0xba
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
// Params 0, eflags: 0x1 linked
// Checksum 0x7f44d5af, Offset: 0x8c8
// Size: 0xd4
function function_8f4d8a35() {
    level thread scene::play("cin_zur_16_02_clearing_vign_bodies01");
    level thread scene::play("cin_zur_16_02_clearing_vign_bodies02");
    level thread scene::play("cin_zur_16_02_clearing_vign_bodies03");
    level waittill(#"hash_387877f0");
    level thread scene::stop("cin_zur_16_02_clearing_vign_bodies01", 1);
    level thread scene::stop("cin_zur_16_02_clearing_vign_bodies02", 1);
    level thread scene::stop("cin_zur_16_02_clearing_vign_bodies03", 1);
}

