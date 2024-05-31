#using scripts/shared/system_shared;
#using scripts/zm/zm_zod_quest;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_81256d2f;

// Namespace namespace_81256d2f
// Params 0, eflags: 0x2
// namespace_81256d2f<file_0>::function_2dc19561
// Checksum 0x2b3fb5ec, Offset: 0x5f0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_pods", &__init__, undefined, undefined);
}

// Namespace namespace_81256d2f
// Params 0, eflags: 0x0
// namespace_81256d2f<file_0>::function_8c87d8eb
// Checksum 0xeb501313, Offset: 0x630
// Size: 0x2d4
function __init__() {
    clientfield::register("toplayer", "ZM_ZOD_UI_POD_SPRAYER_PICKUP", 1, 1, "int", &zm_utility::zm_ui_infotext, 0, 1);
    clientfield::register("scriptmover", "update_fungus_pod_level", 1, 3, "int", &function_69377ddc, 0, 0);
    clientfield::register("scriptmover", "pod_sprayer_glint", 1, 1, "int", &function_7b94eca8, 0, 0);
    clientfield::register("scriptmover", "pod_miasma", 1, 1, "counter", &function_59408649, 0, 0);
    clientfield::register("scriptmover", "pod_harvest", 1, 1, "counter", &function_1d1d005f, 0, 0);
    clientfield::register("scriptmover", "pod_self_destruct", 1, 1, "counter", &function_8144ccdc, 0, 0);
    clientfield::register("toplayer", "pod_sprayer_held", 1, 1, "int", &zm_utility::setinventoryuimodels, 0, 1);
    clientfield::register("toplayer", "pod_sprayer_hint_range", 1, 1, "int", &zm_utility::setinventoryuimodels, 0, 0);
    scene::init("p7_fxanim_zm_zod_fungus_pod_stage1_bundle");
    scene::init("p7_fxanim_zm_zod_fungus_pod_stage1_death_bundle");
    scene::init("p7_fxanim_zm_zod_fungus_pod_stage2_bundle");
    scene::init("p7_fxanim_zm_zod_fungus_pod_stage2_death_bundle");
    scene::init("p7_fxanim_zm_zod_fungus_pod_stage3_bundle");
    scene::init("p7_fxanim_zm_zod_fungus_pod_stage3_death_bundle");
}

// Namespace namespace_81256d2f
// Params 7, eflags: 0x0
// namespace_81256d2f<file_0>::function_69377ddc
// Checksum 0xb537fec5, Offset: 0x910
// Size: 0x382
function function_69377ddc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_aa0684b4)) {
        stopfx(localclientnum, self.var_aa0684b4);
        self stopallloopsounds();
    }
    if (!isdefined(level.var_63c365e9)) {
        level.var_63c365e9 = [];
    }
    if (!isdefined(level.var_63c365e9[localclientnum])) {
        level.var_63c365e9[localclientnum] = [];
    }
    if (!isdefined(level.var_63c365e9[localclientnum][self getentitynumber()])) {
        level.var_63c365e9[localclientnum][self getentitynumber()] = util::spawn_model(localclientnum, "p7_fxanim_zm_zod_fungus_pod_base_mod", self.origin, self.angles);
    }
    mdl_pod = level.var_63c365e9[localclientnum][self getentitynumber()];
    if (isdemoplaying() && getnumfreeentities(localclientnum) < 100) {
        var_2a6bebf9 = getnumfreeentities(localclientnum);
        if (!isdefined(self.var_8486ae6a)) {
            self.var_8486ae6a = 1;
        }
        return;
    }
    if (!isdefined(self.var_8486ae6a)) {
        self.var_8486ae6a = 1;
    }
    switch (newval) {
    case 0:
    case 4:
        self thread scene_play("p7_fxanim_zm_zod_fungus_pod_stage" + self.var_8486ae6a + "_death_bundle", mdl_pod);
        self.var_8486ae6a = 0;
        break;
    case 1:
        self thread scene_play("p7_fxanim_zm_zod_fungus_pod_stage1_bundle", mdl_pod);
        self.var_aa0684b4 = playfx(localclientnum, "zombie/fx_fungus_pod_ambient_sm_zod_zmb", self.origin);
        self.var_8486ae6a = newval;
        break;
    case 2:
        self thread scene_play("p7_fxanim_zm_zod_fungus_pod_stage2_bundle", mdl_pod);
        self.var_aa0684b4 = playfx(localclientnum, "zombie/fx_fungus_pod_ambient_md_zod_zmb", self.origin);
        self.var_8486ae6a = newval;
        break;
    case 3:
        self thread scene_play("p7_fxanim_zm_zod_fungus_pod_stage3_bundle", mdl_pod);
        self.var_aa0684b4 = playfx(localclientnum, "zombie/fx_fungus_pod_ambient_lg_zod_zmb", self.origin);
        self.var_8486ae6a = newval;
        break;
    }
}

// Namespace namespace_81256d2f
// Params 2, eflags: 0x0
// namespace_81256d2f<file_0>::function_406fdb8
// Checksum 0x9c398ac2, Offset: 0xca0
// Size: 0x7c
function scene_play(scene, mdl_pod) {
    self notify(#"scene_play");
    self endon(#"scene_play");
    self scene::stop();
    self function_6221b6b9(scene, mdl_pod);
    self scene::stop();
}

// Namespace namespace_81256d2f
// Params 2, eflags: 0x0
// namespace_81256d2f<file_0>::function_6221b6b9
// Checksum 0x601d8249, Offset: 0xd28
// Size: 0x3c
function function_6221b6b9(scene, mdl_pod) {
    level endon(#"demo_jump");
    self scene::play(scene, mdl_pod);
}

// Namespace namespace_81256d2f
// Params 7, eflags: 0x0
// namespace_81256d2f<file_0>::function_1d1d005f
// Checksum 0x4c45e64c, Offset: 0xd70
// Size: 0x1b4
function function_1d1d005f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval === 0) {
        return;
    }
    v_origin = self.origin;
    v_angles = anglestoforward(self.angles);
    var_8486ae6a = self.var_8486ae6a;
    if (isdefined(self.var_aa0684b4)) {
        stopfx(localclientnum, self.var_aa0684b4);
    }
    switch (var_8486ae6a) {
    case 1:
        var_9a5eae23 = "zombie/fx_fungus_pod_explo_sm_zod_zmb";
        var_ae4d7909 = "zombie/fx_fungus_pod_linger_sm_zod_zmb";
        break;
    case 2:
        var_9a5eae23 = "zombie/fx_fungus_pod_explo_md_zod_zmb";
        var_ae4d7909 = "zombie/fx_fungus_pod_linger_md_zod_zmb";
        break;
    case 3:
        var_9a5eae23 = "zombie/fx_fungus_pod_explo_lg_zod_zmb";
        var_ae4d7909 = "zombie/fx_fungus_pod_linger_lg_zod_zmb";
        break;
    }
    level thread function_b77a78c9(localclientnum, "zombie/fx_sprayer_mist_zod_zmb", v_origin, 2, v_angles);
    wait(0.3);
    level thread function_b77a78c9(localclientnum, var_ae4d7909, v_origin, 8, v_angles);
}

// Namespace namespace_81256d2f
// Params 5, eflags: 0x0
// namespace_81256d2f<file_0>::function_b77a78c9
// Checksum 0xec6c8210, Offset: 0xf30
// Size: 0xb4
function function_b77a78c9(localclientnum, str_fx, v_origin, n_duration, v_angles) {
    if (isdefined(v_angles)) {
        fx = playfx(localclientnum, str_fx, v_origin, v_angles);
    } else {
        fx = playfx(localclientnum, str_fx, v_origin);
    }
    wait(n_duration);
    stopfx(localclientnum, fx);
}

// Namespace namespace_81256d2f
// Params 7, eflags: 0x0
// namespace_81256d2f<file_0>::function_59408649
// Checksum 0xd6c42eb8, Offset: 0xff0
// Size: 0x74
function function_59408649(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread function_b77a78c9(localclientnum, "zombie/fx_fungus_pod_miasma_zod_zmb", self.origin, 5);
    }
}

// Namespace namespace_81256d2f
// Params 7, eflags: 0x0
// namespace_81256d2f<file_0>::function_8144ccdc
// Checksum 0x4b3b710a, Offset: 0x1070
// Size: 0x7c
function function_8144ccdc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread function_b77a78c9(localclientnum, "zombie/fx_fungus_pod_explo_maxevo_zod_zmb", self.origin, 5, (0, 90, 0));
    }
}

// Namespace namespace_81256d2f
// Params 7, eflags: 0x0
// namespace_81256d2f<file_0>::function_7b94eca8
// Checksum 0xe245609f, Offset: 0x10f8
// Size: 0x9c
function function_7b94eca8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_eb0a02e9)) {
        stopfx(localclientnum, self.var_eb0a02e9);
    }
    if (newval) {
        self.var_eb0a02e9 = playfxontag(localclientnum, "zombie/fx_sprayer_glint_zod_zmb", self, "tag_origin");
    }
}

