#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_bouncingbetty;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_genesis_util;

#namespace zm_genesis_minor_ee;

// Namespace zm_genesis_minor_ee
// Params 0, eflags: 0x2
// Checksum 0x3caff76, Offset: 0x268
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_genesis_minor_ee", &__init__, &__main__, undefined );
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x99ec1590, Offset: 0x2b0
// Size: 0x4
function __init__()
{
    
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0xc4f59970, Offset: 0x2c0
// Size: 0x28
function __main__()
{
    level.explode_1st_offset = 0;
    level.explode_2nd_offset = 0;
    level.explode_main_offset = 0;
}

