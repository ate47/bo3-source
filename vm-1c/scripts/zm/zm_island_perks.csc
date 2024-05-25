#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_electric_cherry;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perks;
#using scripts/zm/_filter;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_c8222934;

// Namespace namespace_c8222934
// Params 0, eflags: 0x1 linked
// Checksum 0x93a98cde, Offset: 0x408
// Size: 0x1b4
function init() {
    clientfield::register("world", "perk_light_speed_cola", 1, 3, "int", &function_c574aa0c, 0, 0);
    clientfield::register("world", "perk_light_doubletap", 1, 3, "int", &function_59525d83, 0, 0);
    clientfield::register("world", "perk_light_quick_revive", 1, 3, "int", &function_e63629a0, 0, 0);
    clientfield::register("world", "perk_light_staminup", 1, 3, "int", &function_b169f826, 0, 0);
    clientfield::register("world", "perk_light_juggernog", 1, 3, "int", &function_3cfbcaf5, 0, 0);
    clientfield::register("world", "perk_light_mule_kick", 1, 1, "int", &function_eb0b323d, 0, 0);
}

// Namespace namespace_c8222934
// Params 7, eflags: 0x1 linked
// Checksum 0xc551649f, Offset: 0x5c8
// Size: 0x9c
function function_c574aa0c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_7202315c = "lgt_sleight_" + newval;
        exploder::exploder(level.var_7202315c);
        return;
    }
    if (isdefined(level.var_7202315c)) {
        exploder::stop_exploder(level.var_7202315c);
    }
}

// Namespace namespace_c8222934
// Params 7, eflags: 0x1 linked
// Checksum 0xa140f3a3, Offset: 0x670
// Size: 0x9c
function function_59525d83(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_c09154cb = "lgt_doubletap_" + newval;
        exploder::exploder(level.var_c09154cb);
        return;
    }
    if (isdefined(level.var_c09154cb)) {
        exploder::stop_exploder(level.var_c09154cb);
    }
}

// Namespace namespace_c8222934
// Params 7, eflags: 0x1 linked
// Checksum 0xd38c1140, Offset: 0x718
// Size: 0x9c
function function_e63629a0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_2ff875ec = "lgt_revive_" + newval;
        exploder::exploder(level.var_2ff875ec);
        return;
    }
    if (isdefined(level.var_2ff875ec)) {
        exploder::stop_exploder(level.var_2ff875ec);
    }
}

// Namespace namespace_c8222934
// Params 7, eflags: 0x1 linked
// Checksum 0xbaaf4844, Offset: 0x7c0
// Size: 0x9c
function function_b169f826(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_d3ce4f8e = "lgt_staminup_" + newval;
        exploder::exploder(level.var_d3ce4f8e);
        return;
    }
    if (isdefined(level.var_d3ce4f8e)) {
        exploder::stop_exploder(level.var_d3ce4f8e);
    }
}

// Namespace namespace_c8222934
// Params 7, eflags: 0x1 linked
// Checksum 0x92ce3ed7, Offset: 0x868
// Size: 0x9c
function function_3cfbcaf5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_7202315c = "lgt_jugg_" + newval;
        exploder::exploder(level.var_7202315c);
        return;
    }
    if (isdefined(level.var_7202315c)) {
        exploder::stop_exploder(level.var_7202315c);
    }
}

// Namespace namespace_c8222934
// Params 7, eflags: 0x1 linked
// Checksum 0xeb8f6421, Offset: 0x910
// Size: 0x7c
function function_eb0b323d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_island_vending_mulekick_on");
        return;
    }
    exploder::stop_exploder("lgt_island_vending_mulekick_on");
}

