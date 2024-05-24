#using scripts/zm/_filter;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_912a86f7;

// Namespace namespace_912a86f7
// Params 0, eflags: 0x0
// Checksum 0x7ee498bb, Offset: 0x2d0
// Size: 0x1fc
function init() {
    clientfield::register("world", "perk_light_doubletap", 5000, 1, "int", &function_59525d83, 0, 0);
    clientfield::register("world", "perk_light_juggernaut", 5000, 1, "int", &function_865d7d93, 0, 0);
    clientfield::register("world", "perk_light_mule_kick", 1, 1, "int", &function_eb0b323d, 0, 0);
    clientfield::register("world", "perk_light_quick_revive", 5000, 1, "int", &function_e63629a0, 0, 0);
    clientfield::register("world", "perk_light_speed_cola", 5000, 1, "int", &function_c574aa0c, 0, 0);
    clientfield::register("world", "perk_light_staminup", 5000, 1, "int", &function_b169f826, 0, 0);
    clientfield::register("world", "perk_light_widows_wine", 5000, 1, "int", &function_9021b00a, 0, 0);
}

// Namespace namespace_912a86f7
// Params 7, eflags: 0x0
// Checksum 0xd87ee69a, Offset: 0x4d8
// Size: 0x7c
function function_c574aa0c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_vending_speed_on");
        return;
    }
    exploder::stop_exploder("lgt_vending_speed_on");
}

// Namespace namespace_912a86f7
// Params 7, eflags: 0x0
// Checksum 0x4ed0cd38, Offset: 0x560
// Size: 0x7c
function function_865d7d93(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_vending_jugg_on");
        return;
    }
    exploder::stop_exploder("lgt_vending_jugg_on");
}

// Namespace namespace_912a86f7
// Params 7, eflags: 0x0
// Checksum 0x911a6fd0, Offset: 0x5e8
// Size: 0x7c
function function_59525d83(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_vending_tap_on");
        return;
    }
    exploder::stop_exploder("lgt_vending_tap_on");
}

// Namespace namespace_912a86f7
// Params 7, eflags: 0x0
// Checksum 0xc6ab7d18, Offset: 0x670
// Size: 0x7c
function function_e63629a0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("quick_revive_lgts");
        return;
    }
    exploder::stop_exploder("quick_revive_lgts");
}

// Namespace namespace_912a86f7
// Params 7, eflags: 0x0
// Checksum 0x38823405, Offset: 0x6f8
// Size: 0x7c
function function_9021b00a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_vending_widows_wine_on");
        return;
    }
    exploder::stop_exploder("lgt_vending_widows_wine_on");
}

// Namespace namespace_912a86f7
// Params 7, eflags: 0x0
// Checksum 0xc4776434, Offset: 0x780
// Size: 0x7c
function function_eb0b323d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_vending_mulekick_on");
        return;
    }
    exploder::stop_exploder("lgt_vending_mulekick_on");
}

// Namespace namespace_912a86f7
// Params 7, eflags: 0x0
// Checksum 0x9dc63521, Offset: 0x808
// Size: 0x7c
function function_b169f826(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("lgt_vending_ stamina_up");
        return;
    }
    exploder::stop_exploder("lgt_vending_ stamina_up");
}

