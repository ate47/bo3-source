#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_filter;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_electric_cherry;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_perks;

#namespace zm_island_perks;

// Namespace zm_island_perks
// Params 0, eflags: 0x0
// Checksum 0x93a98cde, Offset: 0x408
// Size: 0x1b4
function init() {
    clientfield::register("world", "perk_light_speed_cola", 1, 3, "int", &perk_light_speed_cola, 0, 0);
    clientfield::register("world", "perk_light_doubletap", 1, 3, "int", &perk_light_doubletap, 0, 0);
    clientfield::register("world", "perk_light_quick_revive", 1, 3, "int", &perk_light_quick_revive, 0, 0);
    clientfield::register("world", "perk_light_staminup", 1, 3, "int", &perk_light_staminup, 0, 0);
    clientfield::register("world", "perk_light_juggernog", 1, 3, "int", &perk_light_juggernog, 0, 0);
    clientfield::register("world", "perk_light_mule_kick", 1, 1, "int", &perk_light_mule_kick, 0, 0);
}

// Namespace zm_island_perks
// Params 7, eflags: 0x0
// Checksum 0xc551649f, Offset: 0x5c8
// Size: 0x9c
function perk_light_speed_cola(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_7202315c = "lgt_sleight_" + newval;
        exploder::exploder(level.var_7202315c);
        return;
    }
    if (isdefined(level.var_7202315c)) {
        exploder::stop_exploder(level.var_7202315c);
    }
}

// Namespace zm_island_perks
// Params 7, eflags: 0x0
// Checksum 0xa140f3a3, Offset: 0x670
// Size: 0x9c
function perk_light_doubletap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_c09154cb = "lgt_doubletap_" + newval;
        exploder::exploder(level.var_c09154cb);
        return;
    }
    if (isdefined(level.var_c09154cb)) {
        exploder::stop_exploder(level.var_c09154cb);
    }
}

// Namespace zm_island_perks
// Params 7, eflags: 0x0
// Checksum 0xd38c1140, Offset: 0x718
// Size: 0x9c
function perk_light_quick_revive(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_2ff875ec = "lgt_revive_" + newval;
        exploder::exploder(level.var_2ff875ec);
        return;
    }
    if (isdefined(level.var_2ff875ec)) {
        exploder::stop_exploder(level.var_2ff875ec);
    }
}

// Namespace zm_island_perks
// Params 7, eflags: 0x0
// Checksum 0xbaaf4844, Offset: 0x7c0
// Size: 0x9c
function perk_light_staminup(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_d3ce4f8e = "lgt_staminup_" + newval;
        exploder::exploder(level.var_d3ce4f8e);
        return;
    }
    if (isdefined(level.var_d3ce4f8e)) {
        exploder::stop_exploder(level.var_d3ce4f8e);
    }
}

// Namespace zm_island_perks
// Params 7, eflags: 0x0
// Checksum 0x92ce3ed7, Offset: 0x868
// Size: 0x9c
function perk_light_juggernog(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level.var_7202315c = "lgt_jugg_" + newval;
        exploder::exploder(level.var_7202315c);
        return;
    }
    if (isdefined(level.var_7202315c)) {
        exploder::stop_exploder(level.var_7202315c);
    }
}

// Namespace zm_island_perks
// Params 7, eflags: 0x0
// Checksum 0xeb8f6421, Offset: 0x910
// Size: 0x7c
function perk_light_mule_kick(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_island_vending_mulekick_on");
        return;
    }
    exploder::stop_exploder("lgt_island_vending_mulekick_on");
}

