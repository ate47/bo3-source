#using scripts/zm/_zm_weap_elemental_bow;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace _zm_weap_elemental_bow_rune_prison;

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 0, eflags: 0x2
// Checksum 0x48dbd3c, Offset: 0x510
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("_zm_weap_elemental_bow_rune_prison", &__init__, undefined, undefined);
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 0, eflags: 0x1 linked
// Checksum 0x2a6a6b8c, Offset: 0x550
// Size: 0x32e
function __init__() {
    clientfield::register("toplayer", "elemental_bow_rune_prison" + "_ambient_bow_fx", 5000, 1, "int", &function_8339cd3d, 0, 0);
    clientfield::register("missile", "elemental_bow_rune_prison" + "_arrow_impact_fx", 5000, 1, "int", &function_4b59f7f4, 0, 0);
    clientfield::register("missile", "elemental_bow_rune_prison4" + "_arrow_impact_fx", 5000, 1, "int", &function_ed22f261, 0, 0);
    clientfield::register("scriptmover", "runeprison_rock_fx", 5000, 1, "int", &runeprison_rock_fx, 0, 0);
    clientfield::register("scriptmover", "runeprison_explode_fx", 5000, 1, "int", &runeprison_explode_fx, 0, 0);
    clientfield::register("scriptmover", "runeprison_lava_geyser_fx", 5000, 1, "int", &runeprison_lava_geyser_fx, 0, 0);
    clientfield::register("actor", "runeprison_lava_geyser_dot_fx", 5000, 1, "int", &runeprison_lava_geyser_dot_fx, 0, 0);
    clientfield::register("actor", "runeprison_zombie_charring", 5000, 1, "int", &runeprison_zombie_charring, 0, 0);
    clientfield::register("actor", "runeprison_zombie_death_skull", 5000, 1, "int", &runeprison_zombie_death_skull, 0, 0);
    level._effect["rune_ambient_bow"] = "dlc1/zmb_weapon/fx_bow_rune_ambient_1p_zmb";
    level._effect["rune_arrow_impact"] = "dlc1/zmb_weapon/fx_bow_rune_impact_zmb";
    level._effect["rune_fire_pillar"] = "dlc1/zmb_weapon/fx_bow_rune_impact_ug_fire_zmb";
    level._effect["rune_lava_geyser"] = "dlc1/zmb_weapon/fx_bow_rune_impact_aoe_zmb";
    level._effect["rune_lava_geyser_dot"] = "dlc1/zmb_weapon/fx_bow_rune_fire_torso_zmb";
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 7, eflags: 0x1 linked
// Checksum 0xc37dc270, Offset: 0x888
// Size: 0x64
function function_8339cd3d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self namespace_790026d5::function_3158b481(localclientnum, newval, "rune_ambient_bow");
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 7, eflags: 0x1 linked
// Checksum 0xe93829d1, Offset: 0x8f8
// Size: 0x74
function function_4b59f7f4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["rune_arrow_impact"], self.origin);
    }
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 7, eflags: 0x1 linked
// Checksum 0xc2eab864, Offset: 0x978
// Size: 0x74
function function_ed22f261(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["rune_arrow_impact"], self.origin);
    }
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 7, eflags: 0x1 linked
// Checksum 0xea86c45d, Offset: 0x9f8
// Size: 0x126
function runeprison_rock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 0:
        self scene_play("p7_fxanim_zm_bow_rune_prison_01_bundle");
        if (!isdefined(self)) {
            return;
        }
        self thread scene_play("p7_fxanim_zm_bow_rune_prison_01_dissolve_bundle", self.var_728caca2);
        self.var_728caca2 thread function_79854312(localclientnum);
        break;
    case 1:
        self thread scene::init("p7_fxanim_zm_bow_rune_prison_01_bundle");
        self.var_728caca2 = util::spawn_model(localclientnum, "p7_fxanim_zm_bow_rune_prison_dissolve_mod", self.origin, self.angles);
        break;
    }
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 2, eflags: 0x1 linked
// Checksum 0xb7ef3984, Offset: 0xb28
// Size: 0x84
function scene_play(scene, var_7b98b639) {
    self notify(#"scene_play");
    self endon(#"scene_play");
    self scene::stop();
    self function_6221b6b9(scene, var_7b98b639);
    if (isdefined(self)) {
        self scene::stop();
    }
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 2, eflags: 0x1 linked
// Checksum 0x5da365bc, Offset: 0xbb8
// Size: 0x3c
function function_6221b6b9(scene, var_7b98b639) {
    level endon(#"demo_jump");
    self scene::play(scene, var_7b98b639);
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 1, eflags: 0x1 linked
// Checksum 0xcc36c409, Offset: 0xc00
// Size: 0x118
function function_79854312(localclientnum) {
    self endon(#"entityshutdown");
    n_start_time = gettime();
    n_end_time = n_start_time + 1633;
    b_is_updating = 1;
    while (b_is_updating) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_end_time);
            b_is_updating = 0;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector0", n_shader_value, 0, 0);
        wait 0.016;
    }
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 7, eflags: 0x1 linked
// Checksum 0x776f42c8, Offset: 0xd20
// Size: 0x7c
function runeprison_explode_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["rune_fire_pillar"], self.origin, (0, 0, 1), (1, 0, 0));
    }
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 7, eflags: 0x1 linked
// Checksum 0xfbe809e1, Offset: 0xda8
// Size: 0xa4
function runeprison_lava_geyser_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect["rune_lava_geyser"], self.origin, (0, 0, 1), (1, 0, 0));
        self playsound(0, "wpn_rune_prison_lava_lump", self.origin);
    }
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 7, eflags: 0x1 linked
// Checksum 0xcb126a2f, Offset: 0xe58
// Size: 0x9c
function runeprison_lava_geyser_dot_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_1892be10 = playfxontag(localclientnum, level._effect["rune_lava_geyser_dot"], self, "j_spine4");
        return;
    }
    deletefx(localclientnum, self.var_1892be10, 0);
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 7, eflags: 0x1 linked
// Checksum 0xa6c6940a, Offset: 0xf00
// Size: 0xf8
function runeprison_zombie_charring(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    if (newval) {
        var_7929bbd6 = gettime();
        n_start_time = var_7929bbd6;
        var_39255d08 = var_7929bbd6 + 1200;
        while (var_7929bbd6 < var_39255d08) {
            var_dd5c416e = (var_7929bbd6 - n_start_time) / 1200;
            self mapshaderconstant(localclientnum, 0, "scriptVector0", var_dd5c416e, var_dd5c416e, 0);
            wait 0.016;
            var_7929bbd6 = gettime();
        }
    }
}

// Namespace _zm_weap_elemental_bow_rune_prison
// Params 7, eflags: 0x1 linked
// Checksum 0x3470f574, Offset: 0x1000
// Size: 0x10c
function runeprison_zombie_death_skull(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        var_3704946b = self gettagorigin("j_head");
        var_94fe2196 = self gettagangles("j_head");
        createdynentandlaunch(localclientnum, "rune_prison_death_skull", var_3704946b, var_94fe2196, self.origin, (randomfloatrange(-0.15, 0.15), randomfloatrange(-0.15, 0.15), 0.1));
    }
}

