#using scripts/codescripts/struct;

#namespace mp_rise_fx;

// Namespace mp_rise_fx
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xa8
// Size: 0x2
function function_f45953c() {
    
}

// Namespace mp_rise_fx
// Params 0, eflags: 0x0
// Checksum 0xb6b4694a, Offset: 0xb8
// Size: 0x1b
function function_8a899530() {
    level.scr_anim = [];
    level.scr_anim["fxanim_props"] = [];
}

// Namespace mp_rise_fx
// Params 0, eflags: 0x0
// Checksum 0xedb58122, Offset: 0xe0
// Size: 0x42
function main() {
    var_c65a3ce5 = getdvarint("disable_fx");
    if (!isdefined(var_c65a3ce5) || var_c65a3ce5 <= 0) {
        function_f45953c();
    }
}

