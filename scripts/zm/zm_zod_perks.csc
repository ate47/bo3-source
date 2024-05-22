#using scripts/zm/_filter;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_bb738c6;

// Namespace namespace_bb738c6
// Params 0, eflags: 0x1 linked
// Checksum 0x64727547, Offset: 0x3c0
// Size: 0x324
function init() {
    level._effect["bottle_jugg"] = "zombie/fx_bottle_break_glow_jugg_zmb";
    level._effect["bottle_dtap"] = "zombie/fx_bottle_break_glow_dtap_zmb";
    level._effect["bottle_speed"] = "zombie/fx_bottle_break_glow_speed_zmb";
    clientfield::register("world", "perk_light_speed_cola", 1, 2, "int", &function_c574aa0c, 0, 0);
    clientfield::register("world", "perk_light_juggernog", 1, 2, "int", &function_3cfbcaf5, 0, 0);
    clientfield::register("world", "perk_light_doubletap", 1, 2, "int", &function_59525d83, 0, 0);
    clientfield::register("world", "perk_light_quick_revive", 1, 1, "int", &function_e63629a0, 0, 0);
    clientfield::register("world", "perk_light_widows_wine", 1, 1, "int", &function_9021b00a, 0, 0);
    clientfield::register("world", "perk_light_mule_kick", 1, 1, "int", &function_eb0b323d, 0, 0);
    clientfield::register("world", "perk_light_staminup", 1, 1, "int", &function_b169f826, 0, 0);
    clientfield::register("scriptmover", "perk_bottle_speed_cola_fx", 1, 1, "int", &function_96fbf181, 0, 0);
    clientfield::register("scriptmover", "perk_bottle_juggernog_fx", 1, 1, "int", &function_fdc76a3e, 0, 0);
    clientfield::register("scriptmover", "perk_bottle_doubletap_fx", 1, 1, "int", &function_5192f840, 0, 0);
}

// Namespace namespace_bb738c6
// Params 7, eflags: 0x1 linked
// Checksum 0x79e3829f, Offset: 0x6f0
// Size: 0xa4
function function_c574aa0c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_320cd7b4 = "lgt_vending_speed_" + newval + "_on";
        exploder::exploder(level.var_320cd7b4);
        return;
    }
    if (isdefined(level.var_320cd7b4)) {
        exploder::stop_exploder(level.var_320cd7b4);
    }
}

// Namespace namespace_bb738c6
// Params 7, eflags: 0x1 linked
// Checksum 0x7965421d, Offset: 0x7a0
// Size: 0xa4
function function_3cfbcaf5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_d1316ad = "lgt_vending_jugg_" + newval + "_on";
        exploder::exploder(level.var_d1316ad);
        return;
    }
    if (isdefined(level.var_d1316ad)) {
        exploder::stop_exploder(level.var_d1316ad);
    }
}

// Namespace namespace_bb738c6
// Params 7, eflags: 0x1 linked
// Checksum 0x5cd4ca2a, Offset: 0x850
// Size: 0xa4
function function_59525d83(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_c09154cb = "lgt_vending_tap_" + newval + "_on";
        exploder::exploder(level.var_c09154cb);
        return;
    }
    if (isdefined(level.var_c09154cb)) {
        exploder::stop_exploder(level.var_c09154cb);
    }
}

// Namespace namespace_bb738c6
// Params 7, eflags: 0x1 linked
// Checksum 0x604f0ec, Offset: 0x900
// Size: 0x7c
function function_e63629a0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("quick_revive_lgts");
        return;
    }
    exploder::stop_exploder("quick_revive_lgts");
}

// Namespace namespace_bb738c6
// Params 7, eflags: 0x1 linked
// Checksum 0x55512872, Offset: 0x988
// Size: 0x7c
function function_9021b00a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_vending_widows_wine_on");
        return;
    }
    exploder::stop_exploder("lgt_vending_widows_wine_on");
}

// Namespace namespace_bb738c6
// Params 7, eflags: 0x1 linked
// Checksum 0xc8fb8059, Offset: 0xa10
// Size: 0x7c
function function_eb0b323d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_vending_mulekick_on");
        return;
    }
    exploder::stop_exploder("lgt_vending_mulekick_on");
}

// Namespace namespace_bb738c6
// Params 7, eflags: 0x1 linked
// Checksum 0x8c655f26, Offset: 0xa98
// Size: 0x7c
function function_b169f826(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_vending_stamina_up");
        return;
    }
    exploder::stop_exploder("lgt_vending_stamina_up");
}

// Namespace namespace_bb738c6
// Params 7, eflags: 0x1 linked
// Checksum 0xdc49eee, Offset: 0xb20
// Size: 0x6c
function function_96fbf181(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["bottle_speed"], self, "tag_origin");
}

// Namespace namespace_bb738c6
// Params 7, eflags: 0x1 linked
// Checksum 0xa0b7505d, Offset: 0xb98
// Size: 0x6c
function function_fdc76a3e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["bottle_jugg"], self, "tag_origin");
}

// Namespace namespace_bb738c6
// Params 7, eflags: 0x1 linked
// Checksum 0xaa0f9bb2, Offset: 0xc10
// Size: 0x6c
function function_5192f840(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["bottle_dtap"], self, "tag_origin");
}

