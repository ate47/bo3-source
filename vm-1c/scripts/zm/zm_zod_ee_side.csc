#using scripts/zm/zm_zod;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_54c8dc69;

// Namespace namespace_54c8dc69
// Params 0, eflags: 0x2
// namespace_54c8dc69<file_0>::function_2dc19561
// Checksum 0x7f2f7ecb, Offset: 0x2c0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_ee_side", &__init__, undefined, undefined);
}

// Namespace namespace_54c8dc69
// Params 0, eflags: 0x0
// namespace_54c8dc69<file_0>::function_8c87d8eb
// Checksum 0xb9f33274, Offset: 0x300
// Size: 0xca
function __init__() {
    clientfield::register("world", "change_bouncingbetties", 1, 2, "int", &function_fc478037, 0, 0);
    clientfield::register("world", "lil_arnie_dance", 1, 1, "int", &function_905dbf86, 0, 0);
    level._effect["portal_3p"] = "zombie/fx_quest_portal_trail_zod_zmb";
    level._effect["octobomb_explode"] = "zombie/fx_octobomb_explo_death_ee_zod_zmb";
}

// Namespace namespace_54c8dc69
// Params 7, eflags: 0x0
// namespace_54c8dc69<file_0>::function_fc478037
// Checksum 0xc771e5b6, Offset: 0x3d8
// Size: 0x9e
function function_fc478037(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        level._effect["fx_betty_exp"] = "zombie/fx_donut_exp_zod_zmb";
        break;
    case 2:
        level._effect["fx_betty_exp"] = "zombie/fx_cake_exp_zod_zmb";
        break;
    }
}

// Namespace namespace_54c8dc69
// Params 7, eflags: 0x0
// namespace_54c8dc69<file_0>::function_905dbf86
// Checksum 0x3614c8b1, Offset: 0x480
// Size: 0x64
function function_905dbf86(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        thread function_a5b33f7(localclientnum);
    }
}

// Namespace namespace_54c8dc69
// Params 1, eflags: 0x0
// namespace_54c8dc69<file_0>::function_a5b33f7
// Checksum 0x23321553, Offset: 0x4f0
// Size: 0xb4
function function_a5b33f7(localclientnum) {
    scene::add_scene_func("zm_zod_lil_arnie_dance", &function_75ad5595, "play");
    level scene::play("zm_zod_lil_arnie_dance");
    s_center = struct::get("lil_arnie_stage_center");
    playfx(localclientnum, level._effect["octobomb_explode"], s_center.origin);
}

// Namespace namespace_54c8dc69
// Params 1, eflags: 0x4
// namespace_54c8dc69<file_0>::function_75ad5595
// Checksum 0xf5f50ae6, Offset: 0x5b0
// Size: 0x122
function private function_75ad5595(var_ff840495) {
    var_ff840495["arnie_tie_mdl"] setscale(0.13);
    var_ff840495["arnie_hat_mdl"] setscale(0.18);
    var_ff840495["arnie_cane_mdl"] setscale(0.08);
    foreach (mdl_prop in var_ff840495) {
        playfx(0, level._effect["portal_3p"], mdl_prop.origin);
    }
}

