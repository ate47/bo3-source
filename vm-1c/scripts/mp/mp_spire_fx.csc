#using scripts/codescripts/struct;

#namespace mp_spire_fx;

// Namespace mp_spire_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xa8
// Size: 0x4
function function_f45953c() {
    
}

// Namespace mp_spire_fx
// Params 0, eflags: 0x0
// Checksum 0xa074cc26, Offset: 0xb8
// Size: 0x26
function function_8a899530() {
    level.scr_anim = [];
    level.scr_anim["fxanim_props"] = [];
}

// Namespace mp_spire_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x98b140fb, Offset: 0xe8
// Size: 0x54
function main() {
    var_c65a3ce5 = getdvarint("disable_fx");
    if (!isdefined(var_c65a3ce5) || var_c65a3ce5 <= 0) {
        function_f45953c();
    }
}

