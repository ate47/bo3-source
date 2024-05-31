#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_3d19ef22;

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x0
// namespace_3d19ef22<file_0>::function_d290ebfa
// Checksum 0xdb25adf6, Offset: 0x4d0
// Size: 0x43
function main() {
    init_clientfields();
    level._effect["green_light"] = "light/fx_light_depth_charge_inactive";
    level._effect["yellow_light"] = "light/fx_light_depth_charge_warning";
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x0
// namespace_3d19ef22<file_0>::function_2ea898a8
// Checksum 0x979b2a5a, Offset: 0x520
// Size: 0xaa
function init_clientfields() {
    clientfield::register("scriptmover", "sm_depth_charge_fx", 1, 1, "int", &function_21197c95, 0, 0);
    clientfield::register("scriptmover", "water_disturbance", 1, 1, "int", &function_f354307b, 0, 0);
    clientfield::register("toplayer", "umbra_tome_singapore", 1, 1, "counter", &function_2b6fcfd1, 0, 0);
}

// Namespace namespace_3d19ef22
// Params 2, eflags: 0x0
// namespace_3d19ef22<file_0>::function_5bcd68f2
// Checksum 0x13748bef, Offset: 0x5d8
// Size: 0x9a
function function_5bcd68f2(str_objective, var_74cd64bc) {
    level thread function_5f80268d();
    level thread function_b087f50();
    level thread function_69ec3f06();
    level thread function_320f5638();
    level thread function_a9bc976();
    setwavewaterenabled("sing_water", 1);
    level thread scene::play("root_singapore_shutters", "targetname");
}

// Namespace namespace_3d19ef22
// Params 2, eflags: 0x0
// namespace_3d19ef22<file_0>::function_95b88092
// Checksum 0xd5203c65, Offset: 0x680
// Size: 0x4a
function function_95b88092(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_5f80268d();
        level thread function_b087f50();
        level thread function_69ec3f06();
    }
}

// Namespace namespace_3d19ef22
// Params 2, eflags: 0x0
// namespace_3d19ef22<file_0>::function_5c143f59
// Checksum 0x8cad41d4, Offset: 0x6d8
// Size: 0x122
function skipto_end(str_objective, var_74cd64bc) {
    level thread scene::stop("root_singapore_shutters", "targetname");
    setwavewaterenabled("sing_water", 0);
    level thread scene::stop("cin_zur_16_02_singapore_vign_bodies01");
    level thread scene::stop("cin_zur_16_02_singapore_vign_bodies02");
    level thread scene::stop("cin_zur_16_02_singapore_vign_bodies03");
    level thread scene::stop("cin_zur_16_02_singapore_vign_pulled01");
    level thread scene::stop("cin_zur_16_02_singapore_vign_pulled02");
    level thread scene::stop("cin_zur_16_02_singapore_vign_pulled03");
    level thread scene::stop("cin_zur_16_02_singapore_hanging_shortrope");
    level thread scene::stop("cin_zur_16_02_singapore_hanging_shortrope_2");
    level notify(#"hash_1c383277");
    level thread namespace_8e9083ff::function_3bf27f88(str_objective);
}

// Namespace namespace_3d19ef22
// Params 7, eflags: 0x0
// namespace_3d19ef22<file_0>::function_2b6fcfd1
// Checksum 0xc1df4434, Offset: 0x808
// Size: 0x52
function function_2b6fcfd1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    umbra_settometrigger(localclientnum, "");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x0
// namespace_3d19ef22<file_0>::function_5f80268d
// Checksum 0xe21d73bd, Offset: 0x868
// Size: 0x312
function function_5f80268d() {
    scene::add_scene_func("p7_fxanim_cp_zurich_roots_water01_bundle", &namespace_8e9083ff::function_4dd02a03, "done", "root_singapore_cleanup");
    scene::add_scene_func("p7_fxanim_cp_zurich_roots_water02_bundle", &namespace_8e9083ff::function_4dd02a03, "done", "root_singapore_cleanup");
    scene::add_scene_func("p7_fxanim_gp_shutter_lt_02_red_bundle", &namespace_8e9083ff::function_4dd02a03, "done", "root_singapore_cleanup");
    scene::add_scene_func("p7_fxanim_gp_shutter_rt_02_red_bundle", &namespace_8e9083ff::function_4dd02a03, "done", "root_singapore_cleanup");
    scene::add_scene_func("p7_fxanim_gp_shutter_lt_10_red_white_bundle", &namespace_8e9083ff::function_4dd02a03, "done", "root_singapore_cleanup");
    scene::add_scene_func("p7_fxanim_gp_shutter_rt_10_red_white_bundle", &namespace_8e9083ff::function_4dd02a03, "done", "root_singapore_cleanup");
    scene::add_scene_func("cin_zur_16_02_singapore_vign_bodies01", &namespace_8e9083ff::function_4dd02a03, "play", "root_singapore_cleanup");
    scene::add_scene_func("cin_zur_16_02_singapore_vign_bodies02", &namespace_8e9083ff::function_4dd02a03, "play", "root_singapore_cleanup");
    scene::add_scene_func("cin_zur_16_02_singapore_vign_bodies03", &namespace_8e9083ff::function_4dd02a03, "play", "root_singapore_cleanup");
    scene::add_scene_func("cin_zur_16_02_singapore_vign_pulled01", &namespace_8e9083ff::function_4dd02a03, "play", "root_singapore_cleanup");
    scene::add_scene_func("cin_zur_16_02_singapore_vign_pulled02", &namespace_8e9083ff::function_4dd02a03, "play", "root_singapore_cleanup");
    scene::add_scene_func("cin_zur_16_02_singapore_vign_pulled03", &namespace_8e9083ff::function_4dd02a03, "play", "root_singapore_cleanup");
    scene::add_scene_func("cin_zur_16_02_singapore_hanging_shortrope", &namespace_8e9083ff::function_4dd02a03, "play", "root_singapore_cleanup");
    scene::add_scene_func("cin_zur_16_02_singapore_hanging_shortrope_2", &namespace_8e9083ff::function_4dd02a03, "play", "root_singapore_cleanup");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x0
// namespace_3d19ef22<file_0>::function_b087f50
// Checksum 0xc5e1147b, Offset: 0xb88
// Size: 0x6a
function function_b087f50() {
    level thread scene::init("p7_fxanim_cp_zurich_roots_water01_bundle");
    level thread scene::init("p7_fxanim_cp_zurich_roots_water02_bundle");
    wait(2.5);
    level thread scene::play("p7_fxanim_cp_zurich_roots_water01_bundle");
    wait(2);
    level thread scene::play("p7_fxanim_cp_zurich_roots_water02_bundle");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x0
// namespace_3d19ef22<file_0>::function_69ec3f06
// Checksum 0x2cbacbd3, Offset: 0xc00
// Size: 0x4a
function function_69ec3f06() {
    level thread scene::play("cin_zur_16_02_singapore_vign_bodies01");
    level thread scene::play("cin_zur_16_02_singapore_vign_bodies02");
    level thread scene::play("cin_zur_16_02_singapore_vign_bodies03");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x0
// namespace_3d19ef22<file_0>::function_320f5638
// Checksum 0x1d42989c, Offset: 0xc58
// Size: 0x6a
function function_320f5638() {
    level thread scene::play("cin_zur_16_02_singapore_vign_pulled01");
    wait(randomfloatrange(2, 5));
    level thread scene::play("cin_zur_16_02_singapore_vign_pulled02");
    wait(randomfloatrange(2, 5));
    level thread scene::play("cin_zur_16_02_singapore_vign_pulled03");
}

// Namespace namespace_3d19ef22
// Params 0, eflags: 0x0
// namespace_3d19ef22<file_0>::function_a9bc976
// Checksum 0xc5326e3b, Offset: 0xcd0
// Size: 0x42
function function_a9bc976() {
    level thread scene::play("cin_zur_16_02_singapore_hanging_shortrope");
    wait(randomfloatrange(2, 5));
    level thread scene::play("cin_zur_16_02_singapore_hanging_shortrope_2");
}

// Namespace namespace_3d19ef22
// Params 7, eflags: 0x0
// namespace_3d19ef22<file_0>::function_f354307b
// Checksum 0xd1297380, Offset: 0xd20
// Size: 0x12a
function function_f354307b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_2e7c1306)) {
        str_tag = "zur_wave_jnt";
        self.var_2e7c1306 = util::spawn_model(localclientnum, "tag_origin", self gettagorigin(str_tag), self gettagangles(str_tag));
        self.var_2e7c1306 linkto(self, str_tag);
        self.var_2e7c1306 setwaterdisturbanceparams(0.4, 1000, 2500, 1, 0);
    }
    if (newval) {
        self.var_2e7c1306.waterdisturbance = 1;
        return;
    }
    self.var_2e7c1306.waterdisturbance = 0;
    wait(0.016);
    self.var_2e7c1306 delete();
}

// Namespace namespace_3d19ef22
// Params 7, eflags: 0x0
// namespace_3d19ef22<file_0>::function_21197c95
// Checksum 0x8be7c799, Offset: 0xe58
// Size: 0xed
function function_21197c95(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.light_fx)) {
        stopfx(localclientnum, self.light_fx);
        self.light_fx = undefined;
    }
    switch (newval) {
    case 0:
        self.light_fx = playfxontag(localclientnum, level._effect["yellow_light"], self, "tag_origin");
        break;
    case 1:
        self.light_fx = playfxontag(localclientnum, level._effect["green_light"], self, "tag_origin");
        break;
    }
}

