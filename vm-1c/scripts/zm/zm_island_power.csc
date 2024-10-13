#using scripts/zm/_zm_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_island_power;

// Namespace zm_island_power
// Params 0, eflags: 0x1 linked
// Checksum 0xa58a8e1a, Offset: 0x258
// Size: 0x16c
function init() {
    clientfield::register("scriptmover", "bucket_fx", 9000, 1, "int", &bucket_fx, 0, 0);
    clientfield::register("world", "power_switch_1_fx", 9000, 1, "int", &power_switch_1_fx, 0, 0);
    clientfield::register("world", "power_switch_2_fx", 9000, 1, "int", &power_switch_2_fx, 0, 0);
    clientfield::register("world", "penstock_fx_anim", 9000, 1, "int", &function_8816d2aa, 0, 0);
    clientfield::register("scriptmover", "power_plant_glow", 9000, 1, "int", &power_plant_glow, 0, 0);
}

// Namespace zm_island_power
// Params 7, eflags: 0x1 linked
// Checksum 0x5c8cebd, Offset: 0x3d0
// Size: 0xdc
function bucket_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.fx_id)) {
        deletefx(localclientnum, self.fx_id);
        self.fx_id = undefined;
    }
    if (newval == 1) {
        self.fx_id = playfxontag(localclientnum, level._effect["bucket_fx"], self, "tag_origin");
    }
}

// Namespace zm_island_power
// Params 7, eflags: 0x1 linked
// Checksum 0xb2c01677, Offset: 0x4b8
// Size: 0x3a4
function power_switch_1_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    a_s_fx = struct::get_array("power_switch_1_fx", "targetname");
    foreach (s_fx in a_s_fx) {
        if (isdefined(s_fx.var_e709b4fd)) {
            a_keys = getarraykeys(s_fx.var_e709b4fd);
            if (isinarray(a_keys, localclientnum)) {
                deletefx(localclientnum, s_fx.var_e709b4fd[localclientnum], 0);
            }
        }
    }
    if (newval == 1) {
        var_92ee343f = getent(localclientnum, "power_wires_lab_a", "targetname");
        var_92ee343f thread function_5ae9f178(localclientnum, 0);
        foreach (s_fx in a_s_fx) {
            if (!isdefined(s_fx.var_e709b4fd)) {
                s_fx.var_e709b4fd = [];
            }
            s_fx.var_e709b4fd[localclientnum] = playfx(localclientnum, level._effect["tower_light_red"], s_fx.origin);
        }
        return;
    }
    var_92ee343f = getent(localclientnum, "power_wires_lab_a", "targetname");
    var_92ee343f thread function_5ae9f178(localclientnum, 1);
    foreach (s_fx in a_s_fx) {
        if (!isdefined(s_fx.var_e709b4fd)) {
            s_fx.var_e709b4fd = [];
        }
        s_fx.var_e709b4fd[localclientnum] = playfx(localclientnum, level._effect["tower_light_green"], s_fx.origin);
    }
}

// Namespace zm_island_power
// Params 7, eflags: 0x1 linked
// Checksum 0x8315189e, Offset: 0x868
// Size: 0x3a4
function power_switch_2_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    a_s_fx = struct::get_array("power_switch_2_fx", "targetname");
    foreach (s_fx in a_s_fx) {
        if (isdefined(s_fx.var_e709b4fd)) {
            a_keys = getarraykeys(s_fx.var_e709b4fd);
            if (isinarray(a_keys, localclientnum)) {
                deletefx(localclientnum, s_fx.var_e709b4fd[localclientnum], 0);
            }
        }
    }
    if (newval == 1) {
        var_92ee343f = getent(localclientnum, "power_wires_lab_b", "targetname");
        var_92ee343f thread function_5ae9f178(localclientnum, 0);
        foreach (s_fx in a_s_fx) {
            if (!isdefined(s_fx.var_e709b4fd)) {
                s_fx.var_e709b4fd = [];
            }
            s_fx.var_e709b4fd[localclientnum] = playfx(localclientnum, level._effect["tower_light_red"], s_fx.origin);
        }
        return;
    }
    var_92ee343f = getent(localclientnum, "power_wires_lab_b", "targetname");
    var_92ee343f thread function_5ae9f178(localclientnum, 1);
    foreach (s_fx in a_s_fx) {
        if (!isdefined(s_fx.var_e709b4fd)) {
            s_fx.var_e709b4fd = [];
        }
        s_fx.var_e709b4fd[localclientnum] = playfx(localclientnum, level._effect["tower_light_green"], s_fx.origin);
    }
}

// Namespace zm_island_power
// Params 2, eflags: 0x1 linked
// Checksum 0x3eb5843, Offset: 0xc18
// Size: 0x1c0
function function_5ae9f178(localclientnum, b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    self endon(#"entityshutdown");
    self notify(#"hash_67a9e087");
    self endon(#"hash_67a9e087");
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
    while (b_is_updating) {
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

// Namespace zm_island_power
// Params 7, eflags: 0x1 linked
// Checksum 0x50bb08b9, Offset: 0xde0
// Size: 0x84
function function_8816d2aa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        scene::init("p7_fxanim_zm_island_penstock_vent_stuck_bundle");
        return;
    }
    scene::play("p7_fxanim_zm_island_penstock_vent_stuck_bundle");
}

// Namespace zm_island_power
// Params 7, eflags: 0x1 linked
// Checksum 0x114b2009, Offset: 0xe70
// Size: 0x84
function power_plant_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread function_a88bde9b(localclientnum, 1);
        return;
    }
    self thread function_a88bde9b(localclientnum, 0);
}

// Namespace zm_island_power
// Params 2, eflags: 0x1 linked
// Checksum 0x77305cee, Offset: 0xf00
// Size: 0x1c0
function function_a88bde9b(localclientnum, b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    self endon(#"entityshutdown");
    self notify(#"hash_67a9e087");
    self endon(#"hash_67a9e087");
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
    while (b_is_updating) {
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

