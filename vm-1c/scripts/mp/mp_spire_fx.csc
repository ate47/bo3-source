#using scripts/codescripts/struct;

#namespace namespace_d4c614ff;

// Namespace namespace_d4c614ff
// Params 0, eflags: 0x1 linked
// namespace_d4c614ff<file_0>::function_f45953c
// Checksum 0x99ec1590, Offset: 0xa8
// Size: 0x4
function function_f45953c() {
    
}

// Namespace namespace_d4c614ff
// Params 0, eflags: 0x0
// namespace_d4c614ff<file_0>::function_8a899530
// Checksum 0xa074cc26, Offset: 0xb8
// Size: 0x26
function function_8a899530() {
    level.scr_anim = [];
    level.scr_anim["fxanim_props"] = [];
}

// Namespace namespace_d4c614ff
// Params 0, eflags: 0x1 linked
// namespace_d4c614ff<file_0>::function_d290ebfa
// Checksum 0x98b140fb, Offset: 0xe8
// Size: 0x54
function main() {
    var_c65a3ce5 = getdvarint("disable_fx");
    if (!isdefined(var_c65a3ce5) || var_c65a3ce5 <= 0) {
        function_f45953c();
    }
}

