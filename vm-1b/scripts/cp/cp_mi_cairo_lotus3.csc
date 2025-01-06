#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_lotus3_fx;
#using scripts/cp/cp_mi_cairo_lotus3_sound;
#using scripts/cp/lotus_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_lotus3;

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0xfef8c0e6, Offset: 0x598
// Size: 0x72
function main() {
    util::function_57b966c8(&force_streamer, 4);
    init_clientfields();
    cp_mi_cairo_lotus3_fx::main();
    cp_mi_cairo_lotus3_sound::main();
    load::main();
    util::waitforclient(0);
}

// Namespace cp_mi_cairo_lotus3
// Params 0, eflags: 0x0
// Checksum 0xdf70a6ff, Offset: 0x618
// Size: 0x1c2
function init_clientfields() {
    clientfield::register("toplayer", "sand_fx", 1, 1, "int", &function_9a25841f, 0, 0);
    clientfield::register("vehicle", "boss_left_outer_fx", 1, 1, "int", &function_9f0a1f48, 0, 0);
    clientfield::register("vehicle", "boss_left_inner_fx", 1, 1, "int", &function_260a2497, 0, 0);
    clientfield::register("vehicle", "boss_right_inner_fx", 1, 1, "int", &function_4be69226, 0, 0);
    clientfield::register("vehicle", "boss_right_outer_fx", 1, 1, "int", &function_47274359, 0, 0);
    clientfield::register("vehicle", "gunship_rumble_off", 1, 1, "int", &function_307fd74a, 0, 0);
    clientfield::register("vehicle", "play_raps_trail_fx", 1, 1, "int", &function_66f3947f, 0, 0);
    clientfield::register("world", "t2a_paper_burst", 1, 1, "int", &function_1be9086e, 0, 0);
}

// Namespace cp_mi_cairo_lotus3
// Params 7, eflags: 0x0
// Checksum 0x3ce2e9c, Offset: 0x7e8
// Size: 0x52
function function_1be9086e(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_f9aa8824) {
    if (var_3a04fa7e) {
        level scene::play("p7_fxanim_gp_trash_paper_burst_out_01_bundle");
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7, eflags: 0x0
// Checksum 0x2f27d43d, Offset: 0x848
// Size: 0x82
function function_9a25841f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread function_a3af9e95(localclientnum);
        return;
    }
    self notify(#"hash_614dea17");
    if (isdefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 1, eflags: 0x0
// Checksum 0xf573d953, Offset: 0x8d8
// Size: 0x7d
function function_a3af9e95(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    self endon(#"hash_614dea17");
    while (true) {
        v_eye = self geteye();
        self.n_fx_id = playfx(localclientnum, level._effect["player_sand"], v_eye);
        wait 0.1;
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7, eflags: 0x0
// Checksum 0x1ca8b541, Offset: 0x960
// Size: 0x7a
function function_9f0a1f48(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    if (newval) {
        playfxontag(localclientnum, level._effect["gunship_fan_damage"], self, "tag_target_fan_left_outer");
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7, eflags: 0x0
// Checksum 0x514bb7dd, Offset: 0x9e8
// Size: 0x7a
function function_260a2497(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    if (newval) {
        playfxontag(localclientnum, level._effect["gunship_fan_damage"], self, "tag_target_fan_left_inner");
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7, eflags: 0x0
// Checksum 0x9eae7db9, Offset: 0xa70
// Size: 0x7a
function function_4be69226(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    if (newval) {
        playfxontag(localclientnum, level._effect["gunship_fan_damage"], self, "tag_target_fan_right_inner");
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7, eflags: 0x0
// Checksum 0xf7137dd1, Offset: 0xaf8
// Size: 0x7a
function function_47274359(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    if (newval) {
        playfxontag(localclientnum, level._effect["gunship_fan_damage"], self, "tag_target_fan_right_outer");
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 7, eflags: 0x0
// Checksum 0x90aa68de, Offset: 0xb80
// Size: 0x66
function function_307fd74a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    if (newval) {
        self.rumbleon = 0;
        return;
    }
    self.rumbleon = 1;
}

// Namespace cp_mi_cairo_lotus3
// Params 7, eflags: 0x0
// Checksum 0x85510622, Offset: 0xbf0
// Size: 0xa2
function function_66f3947f(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_f9aa8824) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    if (var_3a04fa7e) {
        self.fx_trail = playfxontag(var_6575414d, "vehicle/fx_gunship_raps_trail", self, "tag_origin");
        return;
    }
    if (isdefined(self.fx_trail)) {
        stopfx(var_6575414d, self.fx_trail);
    }
}

// Namespace cp_mi_cairo_lotus3
// Params 1, eflags: 0x0
// Checksum 0xf234ae67, Offset: 0xca0
// Size: 0x209
function force_streamer(n_index) {
    switch (n_index) {
    case 1:
        forcestreambundle("cin_lot_09_01_pursuit_1st_switch_end");
        break;
    case 2:
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh010");
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh020");
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh030");
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh040");
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh050");
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh060");
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh070");
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh080");
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh090");
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh100");
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh110");
        forcestreambundle("cin_lot_11_tower2ascent_3rd_sh120");
        break;
    case 3:
        forcestreambundle("cin_lot_15_taylorintro_3rd_sh010");
        forcestreambundle("cin_lot_15_taylorintro_3rd_sh020");
        forcestreambundle("cin_lot_15_taylorintro_3rd_sh030");
        forcestreambundle("cin_lot_15_taylorintro_3rd_sh040");
        forcestreambundle("cin_lot_15_taylorintro_3rd_sh050");
        forcestreambundle("cin_lot_15_taylorintro_3rd_sh060");
        break;
    default:
        break;
    }
}

