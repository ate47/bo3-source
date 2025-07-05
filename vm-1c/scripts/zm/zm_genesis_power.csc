#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_genesis_util;

#using_animtree("generic");

#namespace zm_genesis_power;

// Namespace zm_genesis_power
// Params 0, eflags: 0x2
// Checksum 0x63b9d68c, Offset: 0x4f0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_genesis_power", &__init__, undefined, undefined);
}

// Namespace zm_genesis_power
// Params 0, eflags: 0x0
// Checksum 0xe1133cc0, Offset: 0x530
// Size: 0x116
function __init__() {
    clientfield::register("scriptmover", "power_zombie_soul", 15000, 1, "int", &function_cb47574e, 0, 0);
    clientfield::register("scriptmover", "power_cables_shader", 15000, 1, "int", &power_cables_shader, 0, 0);
    for (i = 1; i <= 4; i++) {
        str_name = "corruption_tower" + i;
        clientfield::register("world", str_name, 15000, 7, "float", &corruption_tower, 0, 0);
    }
}

// Namespace zm_genesis_power
// Params 7, eflags: 0x0
// Checksum 0x45d99c80, Offset: 0x650
// Size: 0xbc
function function_cb47574e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["corruption_engine_soul"], self, "tag_origin");
        self playsound(0, "zmb_ee_soul_start");
        self.sndlooper = self playloopsound("zmb_ee_soul_lp");
    }
}

// Namespace zm_genesis_power
// Params 7, eflags: 0x0
// Checksum 0x34e936a2, Offset: 0x718
// Size: 0xa4
function power_cables_shader(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0, 0);
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
}

// Namespace zm_genesis_power
// Params 7, eflags: 0x0
// Checksum 0xd3048bf4, Offset: 0x7c8
// Size: 0x5fc
function corruption_tower(var_6575414d, var_a53f7c1b, var_143c4e26, var_f16ed138, var_406ad39b, str_field, var_ffbb7dc) {
    var_6bf7783a = getent(var_6575414d, str_field, "targetname");
    var_6bf7783a util::waittill_dobj(var_6575414d);
    if (!isdefined(var_6bf7783a.var_62bb476b)) {
        var_6bf7783a.var_62bb476b = [];
    }
    if (!var_6bf7783a hasanimtree()) {
        var_6bf7783a useanimtree(#generic);
    }
    if (var_143c4e26 <= 0) {
        var_6bf7783a function_1292b31d(var_6575414d, 2, "tag_fx_main", "corruption_tower_active_top_ember", "tag_fx_main_ember");
        return;
    }
    if (var_143c4e26 >= 1) {
        var_6bf7783a clearanim("p7_fxanim_zm_gen_apoth_corpt_engine_pillar_rise_anim", 0.2);
        var_6bf7783a setanim("p7_fxanim_zm_gen_apoth_corpt_engine_pillar_rise_idle_anim", 1, 0.2);
        var_6bf7783a function_1292b31d(var_6575414d, 3, "tag_fx_btm_01", "corruption_tower_complete");
        var_6bf7783a function_1292b31d(var_6575414d, 3, "tag_fx_btm_02", "corruption_tower_complete");
        var_6bf7783a function_1292b31d(var_6575414d, 3, "tag_fx_top_01", "corruption_tower_complete");
        var_6bf7783a function_1292b31d(var_6575414d, 3, "tag_fx_top_02", "corruption_tower_complete");
        var_6bf7783a function_1292b31d(var_6575414d, 3, "tag_fx_cnt", "corruption_tower_complete");
        var_6bf7783a function_1292b31d(var_6575414d, 3, "tag_fx_main", "corruption_tower_complete_top");
        var_6bf7783a function_1292b31d(var_6575414d, 3, "tag_fx_main", "corruption_tower_active_top_ember", "tag_fx_main_ember");
        return;
    }
    var_6bf7783a setanim("p7_fxanim_zm_gen_apoth_corpt_engine_pillar_rise_anim", var_143c4e26, 0.2);
    var_6bf7783a setanim("p7_fxanim_zm_gen_apoth_corpt_engine_pillar_reverse_anim", 1 - var_143c4e26, 0.2);
    if (var_143c4e26 > var_a53f7c1b) {
        if (var_143c4e26 > 0) {
            var_6bf7783a function_1292b31d(var_6575414d, 1, "tag_fx_main", "corruption_tower_active", "tag_fx_main_ember");
        }
        if (var_143c4e26 > 0.03) {
            var_6bf7783a function_1292b31d(var_6575414d, 1, "tag_fx_btm_01", "corruption_tower_active");
            var_6bf7783a function_1292b31d(var_6575414d, 1, "tag_fx_btm_02", "corruption_tower_active");
        }
        if (var_143c4e26 > 0.44) {
            var_6bf7783a function_1292b31d(var_6575414d, 1, "tag_fx_top_01", "corruption_tower_active");
            var_6bf7783a function_1292b31d(var_6575414d, 1, "tag_fx_top_02", "corruption_tower_active");
        }
        if (var_143c4e26 > 0.76) {
            var_6bf7783a function_1292b31d(var_6575414d, 1, "tag_fx_cnt", "corruption_tower_active");
            var_6bf7783a function_1292b31d(var_6575414d, 1, "tag_fx_main", "corruption_tower_active_top");
        }
        return;
    }
    if (var_143c4e26 < 0.03) {
        var_6bf7783a function_1292b31d(var_6575414d, 2, "tag_fx_btm_01");
        var_6bf7783a function_1292b31d(var_6575414d, 2, "tag_fx_btm_02");
    }
    if (var_143c4e26 < 0.44) {
        var_6bf7783a function_1292b31d(var_6575414d, 2, "tag_fx_top_01");
        var_6bf7783a function_1292b31d(var_6575414d, 2, "tag_fx_top_02");
    }
    if (var_143c4e26 > 0.76) {
        var_6bf7783a function_1292b31d(var_6575414d, 2, "tag_fx_cnt");
        var_6bf7783a function_1292b31d(var_6575414d, 2, "tag_fx_main");
    }
}

// Namespace zm_genesis_power
// Params 5, eflags: 0x0
// Checksum 0x253433ea, Offset: 0xdd0
// Size: 0x2e4
function function_1292b31d(var_6575414d, var_47d9b5f4, str_tag, str_fx, str_alias) {
    if (var_47d9b5f4 == 2 || var_47d9b5f4 == 3) {
        if (isdefined(str_alias)) {
            for (i = 1; i <= 4; i++) {
                var_3805981f = "pillar_0" + i + "_" + str_alias;
                if (isdefined(self.var_62bb476b[var_3805981f])) {
                    stopfx(var_6575414d, self.var_62bb476b[var_3805981f]);
                    self.var_62bb476b[var_3805981f] = undefined;
                }
            }
        } else {
            for (i = 1; i <= 4; i++) {
                var_da7eab4b = "pillar_0" + i + "_" + str_tag;
                if (isdefined(self.var_62bb476b[var_da7eab4b])) {
                    stopfx(var_6575414d, self.var_62bb476b[var_da7eab4b]);
                    self.var_62bb476b[var_da7eab4b] = undefined;
                }
            }
        }
    }
    if (var_47d9b5f4 == 1 || var_47d9b5f4 == 3) {
        if (isdefined(str_alias)) {
            for (i = 1; i <= 4; i++) {
                var_da7eab4b = "pillar_0" + i + "_" + str_tag;
                var_3805981f = "pillar_0" + i + "_" + str_alias;
                if (!isdefined(self.var_62bb476b[var_3805981f])) {
                    self.var_62bb476b[var_3805981f] = playfxontag(var_6575414d, level._effect[str_fx], self, var_da7eab4b);
                }
            }
            return;
        }
        for (i = 1; i <= 4; i++) {
            var_da7eab4b = "pillar_0" + i + "_" + str_tag;
            if (!isdefined(self.var_62bb476b[var_da7eab4b])) {
                self.var_62bb476b[var_da7eab4b] = playfxontag(var_6575414d, level._effect[str_fx], self, var_da7eab4b);
            }
        }
    }
}

