#using scripts/codescripts/struct;
#using scripts/shared/util_shared;

#namespace cp_doa_bo3_sound;

// Namespace cp_doa_bo3_sound
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xd0
// Size: 0x2
function main() {
    
}

#namespace namespace_1a381543;

// Namespace namespace_1a381543
// Params 0, eflags: 0x0
// Checksum 0x5f862995, Offset: 0xe0
// Size: 0x62
function function_68fdd800() {
    if (!isdefined(level.var_ae4549e5)) {
        level.var_ae4549e5 = spawn("script_origin", (0, 0, 0));
    }
    level.var_ae4549e5 playloopsound("amb_rally_bg");
    level.var_ae4549e5 function_42b6c406();
}

// Namespace namespace_1a381543
// Params 0, eflags: 0x0
// Checksum 0x75185adc, Offset: 0x150
// Size: 0x2a
function function_42b6c406() {
    level waittill(#"hash_37480f48");
    self stoploopsound();
    wait 1;
    self delete();
}

