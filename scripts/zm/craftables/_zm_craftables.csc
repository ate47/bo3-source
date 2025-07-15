#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;

#namespace zm_craftables;

// Namespace zm_craftables
// Params 0, eflags: 0x2
// Checksum 0xa9be9630, Offset: 0x148
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_craftables", &__init__, undefined, undefined );
}

// Namespace zm_craftables
// Params 0
// Checksum 0x55691903, Offset: 0x188
// Size: 0x34
function __init__()
{
    level.craftable_piece_count = 0;
    callback::on_finalize_initialization( &set_craftable_clientfield );
}

// Namespace zm_craftables
// Params 1
// Checksum 0xde710676, Offset: 0x1c8
// Size: 0x44
function set_craftable_clientfield( localclientnum )
{
    if ( !isdefined( level.zombie_craftables ) )
    {
        level.zombie_craftables = [];
    }
    
    set_piece_count( level.zombie_craftables.size + 1 );
}

// Namespace zm_craftables
// Params 0
// Checksum 0xe30558f1, Offset: 0x218
// Size: 0x20
function init()
{
    if ( isdefined( level.init_craftables ) )
    {
        [[ level.init_craftables ]]();
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0xc2bd7839, Offset: 0x240
// Size: 0x86
function add_zombie_craftable( craftable_name )
{
    if ( !isdefined( level.zombie_include_craftables ) )
    {
        level.zombie_include_craftables = [];
    }
    
    if ( isdefined( level.zombie_include_craftables ) && !isdefined( level.zombie_include_craftables[ craftable_name ] ) )
    {
        return;
    }
    
    craftable_name = level.zombie_include_craftables[ craftable_name ];
    
    if ( !isdefined( level.zombie_craftables ) )
    {
        level.zombie_craftables = [];
    }
    
    level.zombie_craftables[ craftable_name ] = craftable_name;
}

// Namespace zm_craftables
// Params 0
// Checksum 0x9420ddf2, Offset: 0x2d0
// Size: 0x44
function set_clientfield_craftables_code_callbacks()
{
    wait 0.1;
    
    if ( level.zombie_craftables.size > 0 )
    {
        setupclientfieldcodecallbacks( "toplayer", 1, "craftable" );
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0x89dcfc27, Offset: 0x320
// Size: 0x36
function include_zombie_craftable( craftable_name )
{
    if ( !isdefined( level.zombie_include_craftables ) )
    {
        level.zombie_include_craftables = [];
    }
    
    level.zombie_include_craftables[ craftable_name ] = craftable_name;
}

// Namespace zm_craftables
// Params 1
// Checksum 0xf214e544, Offset: 0x360
// Size: 0x6c
function set_piece_count( n_count )
{
    bits = getminbitcountfornum( n_count );
    registerclientfield( "toplayer", "craftable", 1, bits, "int", undefined, 0, 1 );
}

