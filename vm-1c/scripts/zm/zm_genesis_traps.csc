#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_trap_electric;

#namespace zm_genesis_traps;

// Namespace zm_genesis_traps
// Params 0, eflags: 0x2
// Checksum 0x511f18cd, Offset: 0x130
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_genesis_traps", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0x6b717a1a, Offset: 0x178
// Size: 0x14
function __init__() {
    function_f45953c();
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x198
// Size: 0x4
function __main__() {
    
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0xf5606d67, Offset: 0x1a8
// Size: 0x1e
function function_f45953c() {
    level._effect["zapper"] = "dlc1/castle/fx_elec_trap_castle";
}

