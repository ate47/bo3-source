#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/zm/_zm;

#namespace zm_genesis_spiders;

// Namespace zm_genesis_spiders
// Params 0, eflags: 0x2
// Checksum 0xc5e0455c, Offset: 0x100
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_island_spiders", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_spiders
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x148
// Size: 0x4
function __init__() {
    
}

// Namespace zm_genesis_spiders
// Params 0, eflags: 0x0
// Checksum 0x7a9bf9e7, Offset: 0x158
// Size: 0x14
function __main__() {
    register_clientfields();
}

// Namespace zm_genesis_spiders
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x178
// Size: 0x4
function register_clientfields() {
    
}

