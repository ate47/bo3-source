#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;

#namespace zm_fog;

// Namespace zm_fog
// Params 0, eflags: 0x2
// Checksum 0x706d9577, Offset: 0x180
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_fog", &__init__, &__main__, undefined );
}

// Namespace zm_fog
// Params 0
// Checksum 0x9aa1599c, Offset: 0x1c8
// Size: 0x94
function __init__()
{
    clientfield::register( "world", "globalfog_bank", 15000, 2, "int" );
    clientfield::register( "world", "litfog_scriptid_to_edit", 15000, 4, "int" );
    clientfield::register( "world", "litfog_bank", 15000, 2, "int" );
}

// Namespace zm_fog
// Params 0
// Checksum 0xc6b3e7a5, Offset: 0x268
// Size: 0x4c
function __main__()
{
    setdvar( "fogtest_litfog_scriptid", 0 );
    level.var_f87fe25d = [];
    level.var_9814fc19 = 0;
    level thread devgui_fog();
}

// Namespace zm_fog
// Params 1
// Checksum 0xdd9f0af1, Offset: 0x2c0
// Size: 0x116
function function_b8a83a11( var_1cafad33 )
{
    assert( isdefined( level.var_f87fe25d[ var_1cafad33 ] ), "<dev string:x28>" + var_1cafad33 + "<dev string:x35>" );
    var_f832704f = level.var_f87fe25d[ var_1cafad33 ];
    
    if ( isdefined( var_f832704f.var_400d18c9 ) )
    {
        function_facb5f71( var_f832704f.var_400d18c9 );
    }
    
    if ( isdefined( var_f832704f.var_67098efc ) )
    {
        for ( i = 0; i < var_f832704f.var_67098efc.size ; i++ )
        {
            if ( isdefined( var_f832704f.var_67098efc[ i ] ) )
            {
                function_bd594680( i, var_f832704f.var_67098efc[ i ] );
            }
        }
    }
}

// Namespace zm_fog
// Params 2
// Checksum 0xb1bbe4e6, Offset: 0x3e0
// Size: 0x68
function function_848b74be( var_1cafad33, var_400d18c9 )
{
    if ( !isdefined( level.var_f87fe25d[ var_1cafad33 ] ) )
    {
        level.var_f87fe25d[ var_1cafad33 ] = spawnstruct();
    }
    
    level.var_f87fe25d[ var_1cafad33 ].var_400d18c9 = var_400d18c9;
}

// Namespace zm_fog
// Params 3
// Checksum 0x647105, Offset: 0x450
// Size: 0xae
function function_e920efc6( var_1cafad33, var_965632d6, var_ab3af963 )
{
    if ( !isdefined( level.var_f87fe25d[ var_1cafad33 ] ) )
    {
        level.var_f87fe25d[ var_1cafad33 ] = spawnstruct();
    }
    
    if ( !isdefined( level.var_f87fe25d[ var_1cafad33 ].var_67098efc ) )
    {
        level.var_f87fe25d[ var_1cafad33 ].var_67098efc = [];
    }
    
    level.var_f87fe25d[ var_1cafad33 ].var_67098efc[ var_965632d6 ] = var_ab3af963;
}

// Namespace zm_fog
// Params 1
// Checksum 0xb1d29c8d, Offset: 0x508
// Size: 0x2c
function function_facb5f71( var_400d18c9 )
{
    clientfield::set( "globalfog_bank", var_400d18c9 );
}

// Namespace zm_fog
// Params 2
// Checksum 0x669d8e70, Offset: 0x540
// Size: 0x64
function function_bd594680( var_965632d6, n_bank )
{
    clientfield::set( "litfog_scriptid_to_edit", var_965632d6 );
    util::wait_network_frame();
    clientfield::set( "litfog_bank", n_bank );
}

// Namespace zm_fog
// Params 5
// Checksum 0x54e78503, Offset: 0x5b0
// Size: 0x120
function setup_devgui_func( str_devgui_path, str_dvar, n_value, func, n_base_value )
{
    if ( !isdefined( n_base_value ) )
    {
        n_base_value = -1;
    }
    
    setdvar( str_dvar, n_base_value );
    adddebugcommand( "devgui_cmd \"" + str_devgui_path + "\" \"" + str_dvar + " " + n_value + "\"\n" );
    
    while ( true )
    {
        n_dvar = getdvarint( str_dvar );
        
        if ( n_dvar > n_base_value )
        {
            [[ func ]]( n_dvar );
            setdvar( str_dvar, n_base_value );
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_fog
// Params 0
// Checksum 0x2c08b2b, Offset: 0x6d8
// Size: 0x116
function devgui_fog()
{
    /#
        for ( i = 0; i < 4 ; i++ )
        {
            level thread setup_devgui_func( "<dev string:x49>" + i, "<dev string:x61>", i, &function_3dec91b9 );
        }
        
        for ( i = 0; i < 16 ; i++ )
        {
            level thread setup_devgui_func( "<dev string:x78>" + i, "<dev string:x97>", i, &function_49720b6e );
        }
        
        for ( i = 1; i <= 4 ; i++ )
        {
            level thread setup_devgui_func( "<dev string:xaf>" + i, "<dev string:xde>", i, &function_124286f7 );
        }
    #/
}

/#

    // Namespace zm_fog
    // Params 1
    // Checksum 0xa1c2a2e8, Offset: 0x7f8
    // Size: 0x4c, Type: dev
    function function_3dec91b9( n_val )
    {
        iprintlnbold( "<dev string:xf2>" + n_val );
        function_facb5f71( n_val );
    }

    // Namespace zm_fog
    // Params 1
    // Checksum 0xee07c534, Offset: 0x850
    // Size: 0x3c, Type: dev
    function function_49720b6e( n_val )
    {
        level.var_9814fc19 = n_val;
        iprintlnbold( "<dev string:x10b>" + n_val );
    }

    // Namespace zm_fog
    // Params 1
    // Checksum 0x6bbd5c4f, Offset: 0x898
    // Size: 0x64, Type: dev
    function function_124286f7( n_val )
    {
        iprintlnbold( "<dev string:x126>" + level.var_9814fc19 + "<dev string:x132>" + n_val );
        function_bd594680( level.var_9814fc19, n_val - 1 );
    }

#/
