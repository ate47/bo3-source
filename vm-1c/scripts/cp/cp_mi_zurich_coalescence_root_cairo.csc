#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_73dbe018;

// Namespace namespace_73dbe018
// Params 0, eflags: 0x1 linked
// Checksum 0x5f710e15, Offset: 0x358
// Size: 0x24
function main() {
    init_clientfields();
    function_ba0b35c();
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x1 linked
// Checksum 0xa2479f64, Offset: 0x388
// Size: 0x94
function init_clientfields() {
    clientfield::register("scriptmover", "vtol_spawn_fx", 1, 1, "counter", &function_c969e4b5, 0, 0);
    clientfield::register("world", "cairo_client_ents", 1, 1, "int", &function_889c4970, 0, 0);
}

// Namespace namespace_73dbe018
// Params 0, eflags: 0x1 linked
// Checksum 0xebc64784, Offset: 0x428
// Size: 0x1e
function function_ba0b35c() {
    level._effect["vtol_spawn_fx"] = "explosions/fx_exp_lightning_fold_infection";
}

// Namespace namespace_73dbe018
// Params 7, eflags: 0x1 linked
// Checksum 0x4b761066, Offset: 0x450
// Size: 0x34e
function function_889c4970(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(level.var_fdb616fc) && level.var_fdb616fc) {
            return;
        }
        level.var_fdb616fc = 1;
        scene::add_scene_func("p7_fxanim_cp_zurich_cairo_b_collapse_01_bundle", &namespace_8e9083ff::function_4dd02a03, "init", "cairo_root_client_cleanup");
        level thread scene::init("p7_fxanim_cp_zurich_cairo_b_collapse_01_bundle");
        scene::add_scene_func("p7_fxanim_cp_zurich_cairo_b_collapse_02_bundle", &namespace_8e9083ff::function_4dd02a03, "init", "cairo_root_client_cleanup");
        level thread scene::init("p7_fxanim_cp_zurich_cairo_b_collapse_02_bundle");
        scene::add_scene_func("p7_fxanim_cp_zurich_cairo_b_collapse_03_bundle", &namespace_8e9083ff::function_4dd02a03, "init", "cairo_root_client_cleanup");
        level thread scene::init("p7_fxanim_cp_zurich_cairo_b_collapse_03_bundle");
        scene::add_scene_func("p7_fxanim_cp_zurich_cairo_lightpole_bundle", &namespace_8e9083ff::function_4dd02a03, "init", "cairo_root_client_cleanup");
        level thread scene::init("p7_fxanim_cp_zurich_cairo_lightpole_bundle");
        scene::add_scene_func("p7_fxanim_cp_zurich_sinkhole_01_bundle", &namespace_8e9083ff::function_4dd02a03, "init", "cairo_root_client_cleanup");
        level thread scene::init("p7_fxanim_cp_zurich_sinkhole_01_bundle");
        scene::add_scene_func("p7_fxanim_cp_zurich_sinkhole_02_bundle", &namespace_8e9083ff::function_4dd02a03, "init", "cairo_root_client_cleanup");
        level thread scene::init("p7_fxanim_cp_zurich_sinkhole_02_bundle");
        var_84828c57 = getentarray(localclientnum, "cairo_client_building", "targetname");
        array::thread_all(var_84828c57, &function_ea552f44, localclientnum);
        var_c9a3a65d = getentarray(localclientnum, "cairo_client_explode", "targetname");
        array::thread_all(var_c9a3a65d, &function_9f362d5c, localclientnum);
        return;
    }
    level notify(#"hash_8ca632f9");
    level.var_fdb616fc = undefined;
}

// Namespace namespace_73dbe018
// Params 1, eflags: 0x1 linked
// Checksum 0xe3f4806d, Offset: 0x7a8
// Size: 0x6c
function function_ea552f44(localclientnum) {
    self waittill(#"trigger");
    assert(isdefined(self.script_string), "init");
    level thread scene::play("p7_fxanim_cp_zurich_cairo_" + self.script_string);
}

// Namespace namespace_73dbe018
// Params 1, eflags: 0x1 linked
// Checksum 0xed1bfbc2, Offset: 0x820
// Size: 0x6c
function function_9f362d5c(localclientnum) {
    self waittill(#"trigger");
    assert(isdefined(self.script_string), "init");
    level thread scene::play("p7_fxanim_cp_zurich_" + self.script_string);
}

// Namespace namespace_73dbe018
// Params 7, eflags: 0x1 linked
// Checksum 0xe6f7bf17, Offset: 0x898
// Size: 0x6c
function function_c969e4b5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["vtol_spawn_fx"], self, "tag_origin");
}

