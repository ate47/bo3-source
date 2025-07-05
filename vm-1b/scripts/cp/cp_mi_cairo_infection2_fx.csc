#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace infection2_fx;

// Namespace infection2_fx
// Params 0, eflags: 0x2
// Checksum 0x2f1eb333, Offset: 0x120
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("infection2_fx", &__init__, undefined, undefined);
}

// Namespace infection2_fx
// Params 0, eflags: 0x0
// Checksum 0x5befa148, Offset: 0x158
// Size: 0x22
function __init__() {
    init_fx();
    init_clientfields();
}

// Namespace infection2_fx
// Params 0, eflags: 0x0
// Checksum 0x7d77c546, Offset: 0x188
// Size: 0x1b
function init_fx() {
    level._effect["water_motes"] = "water/fx_underwater_debris_player_loop";
}

// Namespace infection2_fx
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1b0
// Size: 0x2
function init_clientfields() {
    
}

