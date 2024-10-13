#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_cairo_infection_sgen_test_chamber;

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 0, eflags: 0x0
// Checksum 0xf07b5103, Offset: 0x2b8
// Size: 0x14
function main() {
    init_clientfields();
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 0, eflags: 0x0
// Checksum 0xb9bd98e3, Offset: 0x2d8
// Size: 0x16c
function init_clientfields() {
    clientfield::register("world", "sgen_test_chamber_pod_graphics", 1, 1, "int", &function_8d81452c, 0, 0);
    clientfield::register("world", "sgen_test_chamber_time_lapse", 1, 1, "int", &function_20d4178a, 0, 0);
    clientfield::register("scriptmover", "sgen_test_guys_decay", 1, 1, "int", &function_e1732ad0, 0, 0);
    clientfield::register("world", "fxanim_hive_cluster_break", 1, 1, "int", &fxanim_hive_cluster_break, 0, 0);
    clientfield::register("world", "fxanim_time_lapse_objects", 1, 1, "int", &fxanim_time_lapse_objects, 0, 0);
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 7, eflags: 0x0
// Checksum 0x2be197b4, Offset: 0x450
// Size: 0xbc
function fxanim_hive_cluster_break(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::init("p7_fxanim_cp_infection_sgen_hive_drop_bundle");
        return;
    }
    scene::add_scene_func("p7_fxanim_cp_infection_sgen_hive_drop_bundle", &function_1902c83c, "play");
    level thread scene::play("p7_fxanim_cp_infection_sgen_hive_drop_bundle");
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 1, eflags: 0x0
// Checksum 0xb6afe4b3, Offset: 0x518
// Size: 0x34
function function_1902c83c(var_38fa6e84) {
    wait 8;
    var_38fa6e84["sgen_hive_drop"] delete();
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 7, eflags: 0x0
// Checksum 0xbc2acdc3, Offset: 0x558
// Size: 0x202
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

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 7, eflags: 0x0
// Checksum 0xafd7deef, Offset: 0x768
// Size: 0xf2
function function_20d4178a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_d83aa1ec = getentarray(localclientnum, "dni_testing_pod", "targetname");
    foreach (var_79536eed in var_d83aa1ec) {
        var_79536eed thread time_lapse();
    }
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 0, eflags: 0x0
// Checksum 0x4f78c9b4, Offset: 0x868
// Size: 0xb6
function time_lapse() {
    var_575cb898 = 0.0666667;
    var_137967eb = 1 / -76;
    var_8d0c7ad9 = 0;
    for (i = 0; i <= 12; i += var_575cb898) {
        self mapshaderconstant(0, 0, "scriptVector0", var_8d0c7ad9, 0, 0, 0);
        var_8d0c7ad9 += var_137967eb;
        wait var_575cb898;
    }
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 7, eflags: 0x0
// Checksum 0x4cf5c5f7, Offset: 0x928
// Size: 0x54
function function_e1732ad0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_bc50283c(localclientnum);
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 1, eflags: 0x0
// Checksum 0x9967399a, Offset: 0x988
// Size: 0xda
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
        wait 0.01;
    }
}

// Namespace cp_mi_cairo_infection_sgen_test_chamber
// Params 7, eflags: 0x0
// Checksum 0x3bedd30b, Offset: 0xa70
// Size: 0x64
function fxanim_time_lapse_objects(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_infection_sgen_time_lapse_objects_bundle");
    }
}

