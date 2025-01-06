#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_weapons;

#namespace zm_island_planting;

// Namespace zm_island_planting
// Params 0, eflags: 0x0
// Checksum 0xfbbe0173, Offset: 0x610
// Size: 0x31c
function init() {
    clientfield::register("scriptmover", "plant_growth_siege_anims", 9000, 2, "int", &plant_growth_siege_anims, 0, 0);
    clientfield::register("scriptmover", "cache_plant_interact_fx", 9000, 1, "int", &function_d6804e46, 0, 0);
    clientfield::register("scriptmover", "plant_hit_with_ww_fx", 9000, 1, "int", &plant_hit_with_ww, 0, 0);
    clientfield::register("scriptmover", "plant_watered_fx", 9000, 1, "int", &plant_watered, 0, 0);
    clientfield::register("scriptmover", "planter_model_watered", 9000, 1, "int", &planter_model_watered, 0, 0);
    clientfield::register("scriptmover", "babysitter_plant_fx", 9000, 1, "int", &babysitter_plant_fx, 0, 0);
    clientfield::register("scriptmover", "trap_plant_fx", 9000, 1, "int", &trap_plant_fx, 0, 0);
    clientfield::register("toplayer", "player_spawned_from_clone_plant", 9000, 1, "int", &player_spawned_from_clone_plant, 0, 0);
    clientfield::register("toplayer", "player_cloned_fx", 9000, 1, "int", &player_cloned_fx, 0, 0);
    clientfield::register("scriptmover", "zombie_or_grenade_spawned_from_minor_cache_plant", 9000, 2, "int", &zombie_or_grenade_spawned_from_minor_cache_plant, 0, 0);
    clientfield::register("allplayers", "player_vomit_fx", 9000, 1, "int", &player_vomit_fx, 0, 0);
}

// Namespace zm_island_planting
// Params 7, eflags: 0x0
// Checksum 0x6f02f9eb, Offset: 0x938
// Size: 0x37c
function plant_growth_siege_anims(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_600eec00)) {
        self.var_600eec00 = util::spawn_model(localclientnum, "p7_fxanim_zm_island_plant_bulb_smod", self.origin, self.angles);
    }
    if (!isdefined(self.var_a32dfd4)) {
        self.var_a32dfd4 = util::spawn_model(localclientnum, "p7_fxanim_zm_island_plant_roots_smod", self.origin, self.angles);
    }
    if (newval == 1) {
        self endon(#"hash_336ee8b2");
        self.var_600eec00 siegecmd("set_anim", "p7_fxanim_zm_island_plant_bulb_grow1_sanim", "unloop");
        self.var_a32dfd4 siegecmd("set_anim", "p7_fxanim_zm_island_plant_roots_grow1_sanim", "unloop");
        n_wait_time = getanimlength("p7_fxanim_zm_island_plant_bulb_grow1_sanim");
        wait n_wait_time;
        self.var_600eec00 siegecmd("set_anim", "p7_fxanim_zm_island_plant_bulb_grow1_idle_sanim", "loop");
        self.var_a32dfd4 siegecmd("set_anim", "p7_fxanim_zm_island_plant_roots_grow1_idle_sanim", "loop");
        return;
    }
    if (newval == 2) {
        self endon(#"hash_d6c6e49");
        self notify(#"hash_336ee8b2");
        self.var_600eec00 siegecmd("set_anim", "p7_fxanim_zm_island_plant_bulb_grow2_sanim", "unloop");
        self.var_a32dfd4 siegecmd("set_anim", "p7_fxanim_zm_island_plant_roots_grow2_sanim", "unloop");
        n_wait_time = getanimlength("p7_fxanim_zm_island_plant_bulb_grow2_sanim");
        wait n_wait_time;
        self.var_600eec00 siegecmd("set_anim", "p7_fxanim_zm_island_plant_bulb_grow2_idle_sanim", "loop");
        self.var_a32dfd4 siegecmd("set_anim", "p7_fxanim_zm_island_plant_roots_grow2_idle_sanim", "loop");
        return;
    }
    if (newval == 3) {
        self notify(#"hash_d6c6e49");
        self.var_600eec00 siegecmd("set_anim", "p7_fxanim_zm_island_plant_bulb_open_sanim", "unloop");
        self.var_a32dfd4 siegecmd("set_anim", "p7_fxanim_zm_island_plant_roots_open_sanim", "unloop");
        return;
    }
    self.var_600eec00 siegecmd("set_anim", "p7_fxanim_zm_island_plant_bulb_dead_sanim", "unloop");
}

// Namespace zm_island_planting
// Params 7, eflags: 0x0
// Checksum 0x31e7e1d, Offset: 0xcc0
// Size: 0xbc
function function_d6804e46(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.fx_id)) {
        deletefx(localclientnum, self.fx_id, 0);
        self.fx_id = undefined;
        return;
    }
    if (newval == 1) {
        self.fx_id = playfxontag(localclientnum, level._effect["major_cache_plant"], self, "fx_tag_plant_cache_major_jnt");
    }
}

// Namespace zm_island_planting
// Params 7, eflags: 0x0
// Checksum 0xca083f16, Offset: 0xd88
// Size: 0xbe
function babysitter_plant_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.babysitter_plant_fx = playfxontag(localclientnum, level._effect["babysitter_plant"], self, "tag_origin");
        return;
    }
    if (isdefined(self.babysitter_plant_fx)) {
        deletefx(localclientnum, self.babysitter_plant_fx, 0);
        self.babysitter_plant_fx = undefined;
    }
}

// Namespace zm_island_planting
// Params 7, eflags: 0x0
// Checksum 0x4c0965db, Offset: 0xe50
// Size: 0xbe
function trap_plant_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.trap_plant_fx = playfxontag(localclientnum, level._effect["trap_plant"], self, "tag_origin");
        return;
    }
    if (isdefined(self.trap_plant_fx)) {
        deletefx(localclientnum, self.trap_plant_fx, 0);
        self.trap_plant_fx = undefined;
    }
}

// Namespace zm_island_planting
// Params 7, eflags: 0x0
// Checksum 0x966fda38, Offset: 0xf18
// Size: 0xce
function plant_hit_with_ww(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_c00f8b20 = playfx(localclientnum, level._effect["plant_hit_with_ww"], self.origin + (0, 0, 8));
        return;
    }
    if (isdefined(self.var_c00f8b20)) {
        deletefx(localclientnum, self.var_c00f8b20, 0);
        self.var_c00f8b20 = undefined;
    }
}

// Namespace zm_island_planting
// Params 7, eflags: 0x0
// Checksum 0xe84e4693, Offset: 0xff0
// Size: 0xa4
function plant_watered(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_15110cf6");
    if (isdefined(self.var_5257f4ba)) {
        deletefx(localclientnum, self.var_5257f4ba, 0);
        self.var_5257f4ba = undefined;
    }
    if (newval == 1) {
        self thread function_2179698b(localclientnum);
    }
}

// Namespace zm_island_planting
// Params 1, eflags: 0x0
// Checksum 0xc0dcfc71, Offset: 0x10a0
// Size: 0xc4
function function_2179698b(localclientnum) {
    level endon(#"demo_jump");
    self endon(#"hash_15110cf6");
    self.var_5257f4ba = playfx(localclientnum, level._effect["plant_watered_startup"], self.origin + (0, 0, 8));
    wait 2;
    if (isdefined(self)) {
        self.var_5257f4ba = playfx(localclientnum, level._effect["plant_watered"], self.origin + (0, 0, 8));
    }
}

// Namespace zm_island_planting
// Params 7, eflags: 0x0
// Checksum 0xc2bc7107, Offset: 0x1170
// Size: 0x84
function planter_model_watered(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread function_b8ba462e(localclientnum, 1);
        return;
    }
    self thread function_b8ba462e(localclientnum, 0);
}

// Namespace zm_island_planting
// Params 2, eflags: 0x0
// Checksum 0xd90db32, Offset: 0x1200
// Size: 0x1d0
function function_b8ba462e(localclientnum, b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    self endon(#"entityshutdown");
    self notify(#"hash_67a9e087");
    self endon(#"hash_67a9e087");
    level endon(#"demo_jump");
    n_start_time = gettime();
    n_end_time = n_start_time + 2 * 1000;
    b_is_updating = 1;
    if (isdefined(b_on) && b_on) {
        n_max = 1;
        n_min = 0;
    } else {
        n_max = 0;
        n_min = 1;
    }
    while (b_is_updating && isdefined(self)) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            n_shader_value = mapfloat(n_start_time, n_end_time, n_min, n_max, n_end_time);
            b_is_updating = 0;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, n_min, n_max, n_time);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
        wait 0.01;
    }
}

// Namespace zm_island_planting
// Params 7, eflags: 0x0
// Checksum 0x9fe6b0ba, Offset: 0x13d8
// Size: 0x8c
function player_spawned_from_clone_plant(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread postfx::playpostfxbundle("pstfx_thrasher_stomach");
        return;
    }
    if (isdefined(self.playingpostfxbundle)) {
        self thread postfx::function_9493d991();
    }
}

// Namespace zm_island_planting
// Params 7, eflags: 0x0
// Checksum 0x6fb72d5c, Offset: 0x1470
// Size: 0xbe
function player_cloned_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_23200cb7 = playfxontag(localclientnum, level._effect["clone_plant_emerge"], self, "tag_camera");
        return;
    }
    if (isdefined(self.var_23200cb7)) {
        deletefx(localclientnum, self.var_23200cb7, 0);
        self.var_23200cb7 = undefined;
    }
}

// Namespace zm_island_planting
// Params 7, eflags: 0x0
// Checksum 0x70305d3a, Offset: 0x1538
// Size: 0x106
function zombie_or_grenade_spawned_from_minor_cache_plant(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_7fec15a0 = playfxontag(localclientnum, level._effect["cache_slime"], self, "plant_cache_major_feeler_03_03_jnt");
        return;
    }
    if (newval == 2) {
        self.var_7fec15a0 = playfxontag(localclientnum, level._effect["cache_slime_small"], self, "plant_cache_major_feeler_03_03_jnt");
        return;
    }
    if (isdefined(self.var_7fec15a0)) {
        deletefx(localclientnum, self.var_7fec15a0, 0);
        self.var_7fec15a0 = undefined;
    }
}

// Namespace zm_island_planting
// Params 7, eflags: 0x0
// Checksum 0xddb6b668, Offset: 0x1648
// Size: 0xbe
function player_vomit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_a56aa1f9 = playfxontag(localclientnum, level._effect["fruit_plant_vomit"], self, "j_neck");
        return;
    }
    if (isdefined(self.var_a56aa1f9)) {
        deletefx(localclientnum, self.var_a56aa1f9, 0);
        self.var_a56aa1f9 = undefined;
    }
}

