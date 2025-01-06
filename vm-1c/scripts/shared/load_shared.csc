#using scripts/shared/_explode;
#using scripts/shared/blood;
#using scripts/shared/drown;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/fx_shared;
#using scripts/shared/player_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/water_surface;
#using scripts/shared/weapons/_empgrenade;
#using scripts/shared/weapons_shared;

#namespace load;

// Namespace load
// Params 0, eflags: 0x2
// Checksum 0xa6285f1a, Offset: 0x228
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("load", &__init__, undefined, undefined);
}

// Namespace load
// Params 0, eflags: 0x0
// Checksum 0xeb152b63, Offset: 0x268
// Size: 0x2c
function __init__() {
    /#
        level thread first_frame();
    #/
    function_b018f2a7();
}

/#

    // Namespace load
    // Params 0, eflags: 0x0
    // Checksum 0xbf1fdc1, Offset: 0x2a0
    // Size: 0x26
    function first_frame() {
        level.first_frame = 1;
        wait 0.05;
        level.first_frame = undefined;
    }

#/

// Namespace load
// Params 0, eflags: 0x0
// Checksum 0xcb85f097, Offset: 0x2d0
// Size: 0x64
function function_b018f2a7() {
    var_ae867510 = getdvarfloat("tu16_physicsPushOutThreshold", -1);
    if (var_ae867510 != -1) {
        setdvar("tu16_physicsPushOutThreshold", 20);
    }
}

// Namespace load
// Params 0, eflags: 0x0
// Checksum 0xc008a629, Offset: 0x340
// Size: 0x7c
function art_review() {
    if (getdvarstring("art_review") == "") {
        setdvar("art_review", "0");
    }
    if (getdvarstring("art_review") == "1") {
        level waittill(#"forever");
    }
}

