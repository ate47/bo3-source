#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_c7c6fa6;

// Namespace namespace_c7c6fa6
// Params 0, eflags: 0x0
// Checksum 0x561e08ff, Offset: 0x2b8
// Size: 0x12
function main() {
    init_clientfields();
}

// Namespace namespace_c7c6fa6
// Params 0, eflags: 0x0
// Checksum 0xf43660ea, Offset: 0x2d8
// Size: 0x11a
function init_clientfields() {
    clientfield::register("world", "sgen_test_chamber_pod_graphics", 1, 1, "int", &function_8d81452c, 0, 0);
    clientfield::register("world", "sgen_test_chamber_time_lapse", 1, 1, "int", &function_20d4178a, 0, 0);
    clientfield::register("scriptmover", "sgen_test_guys_decay", 1, 1, "int", &function_e1732ad0, 0, 0);
    clientfield::register("world", "fxanim_hive_cluster_break", 1, 1, "int", &function_c7de1e6e, 0, 0);
    clientfield::register("world", "fxanim_time_lapse_objects", 1, 1, "int", &function_c1f973b7, 0, 0);
}

// Namespace namespace_c7c6fa6
// Params 7, eflags: 0x0
// Checksum 0x9f59905e, Offset: 0x400
// Size: 0x9a
function function_c7de1e6e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::init("p7_fxanim_cp_infection_sgen_hive_drop_bundle");
        return;
    }
    scene::add_scene_func("p7_fxanim_cp_infection_sgen_hive_drop_bundle", &function_1902c83c, "play");
    level thread scene::play("p7_fxanim_cp_infection_sgen_hive_drop_bundle");
}

// Namespace namespace_c7c6fa6
// Params 1, eflags: 0x0
// Checksum 0xd8c864f7, Offset: 0x4a8
// Size: 0x2a
function function_1902c83c(var_38fa6e84) {
    wait(8);
    var_38fa6e84["sgen_hive_drop"] delete();
}

// Namespace namespace_c7c6fa6
// Params 7, eflags: 0x0
// Checksum 0x7ec946ee, Offset: 0x4e0
// Size: 0x183
function function_8d81452c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_d83aa1ec = getentarray(localclientnum, "dni_testing_pod", "targetname");
    if (oldval != newval) {
        if (newval == 1) {
            foreach (var_79536eed in var_d83aa1ec) {
                var_79536eed attach("p7_sgen_dni_testing_pod_graphics_01_screen", "tag_origin");
                var_79536eed attach("p7_sgen_dni_testing_pod_graphics_01_door", "tag_door_anim");
            }
            return;
        }
        foreach (var_79536eed in var_d83aa1ec) {
            var_79536eed detach("p7_sgen_dni_testing_pod_graphics_01_screen", "tag_origin");
            var_79536eed detach("p7_sgen_dni_testing_pod_graphics_01_door", "tag_door_anim");
        }
    }
}

// Namespace namespace_c7c6fa6
// Params 7, eflags: 0x0
// Checksum 0xbcd65c60, Offset: 0x670
// Size: 0xc3
function function_20d4178a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_d83aa1ec = getentarray(localclientnum, "dni_testing_pod", "targetname");
    foreach (var_79536eed in var_d83aa1ec) {
        var_79536eed thread function_e3273538();
    }
}

// Namespace namespace_c7c6fa6
// Params 0, eflags: 0x0
// Checksum 0x49ee41a2, Offset: 0x740
// Size: 0x79
function function_e3273538() {
    var_575cb898 = 0.0666667;
    var_137967eb = 1 / -76;
    var_8d0c7ad9 = 0;
    for (i = 0; i <= 12; i += var_575cb898) {
        self mapshaderconstant(0, 0, "scriptVector0", var_8d0c7ad9, 0, 0, 0);
        var_8d0c7ad9 += var_137967eb;
        wait(var_575cb898);
    }
}

// Namespace namespace_c7c6fa6
// Params 7, eflags: 0x0
// Checksum 0xc41a0dc4, Offset: 0x7c8
// Size: 0x4a
function function_e1732ad0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_bc50283c(localclientnum);
}

// Namespace namespace_c7c6fa6
// Params 1, eflags: 0x0
// Checksum 0x79c86bbe, Offset: 0x820
// Size: 0xa9
function function_bc50283c(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    self notify(#"hash_bc50283c");
    self endon(#"hash_bc50283c");
    var_9ef7f234 = 1 / 6.5;
    for (i = 0; i <= 6.5; i += 0.01) {
        if (!isdefined(self)) {
            return;
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector0", i * var_9ef7f234, 0, 0, 0);
        wait(0.01);
    }
}

// Namespace namespace_c7c6fa6
// Params 7, eflags: 0x0
// Checksum 0x10d1acea, Offset: 0x8d8
// Size: 0x52
function function_c1f973b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_infection_sgen_time_lapse_objects_bundle");
    }
}

