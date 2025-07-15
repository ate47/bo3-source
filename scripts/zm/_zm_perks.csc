#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_filter;

#namespace zm_perks;

// Namespace zm_perks
// Params 0
// Checksum 0x75eda150, Offset: 0x1b8
// Size: 0x54
function init()
{
    callback::on_start_gametype( &init_perk_machines_fx );
    init_custom_perks();
    perks_register_clientfield();
    init_perk_custom_threads();
}

// Namespace zm_perks
// Params 0
// Checksum 0x44be60e2, Offset: 0x218
// Size: 0x11c
function perks_register_clientfield()
{
    if ( isdefined( level.zombiemode_using_perk_intro_fx ) && level.zombiemode_using_perk_intro_fx )
    {
        clientfield::register( "scriptmover", "clientfield_perk_intro_fx", 1, 1, "int", &perk_meteor_fx, 0, 0 );
    }
    
    if ( level._custom_perks.size > 0 )
    {
        a_keys = getarraykeys( level._custom_perks );
        
        for ( i = 0; i < a_keys.size ; i++ )
        {
            if ( isdefined( level._custom_perks[ a_keys[ i ] ].clientfield_register ) )
            {
                level [[ level._custom_perks[ a_keys[ i ] ].clientfield_register ]]();
            }
        }
    }
    
    level thread perk_init_code_callbacks();
}

// Namespace zm_perks
// Params 0
// Checksum 0x8bec9b24, Offset: 0x340
// Size: 0xb6
function perk_init_code_callbacks()
{
    wait 0.1;
    
    if ( level._custom_perks.size > 0 )
    {
        a_keys = getarraykeys( level._custom_perks );
        
        for ( i = 0; i < a_keys.size ; i++ )
        {
            if ( isdefined( level._custom_perks[ a_keys[ i ] ].clientfield_code_callback ) )
            {
                level [[ level._custom_perks[ a_keys[ i ] ].clientfield_code_callback ]]();
            }
        }
    }
}

// Namespace zm_perks
// Params 0
// Checksum 0x6e4514fa, Offset: 0x400
// Size: 0x1c
function init_custom_perks()
{
    if ( !isdefined( level._custom_perks ) )
    {
        level._custom_perks = [];
    }
}

// Namespace zm_perks
// Params 3
// Checksum 0x21f6a8d4, Offset: 0x428
// Size: 0xa4
function register_perk_clientfields( str_perk, func_clientfield_register, func_code_callback )
{
    _register_undefined_perk( str_perk );
    
    if ( !isdefined( level._custom_perks[ str_perk ].clientfield_register ) )
    {
        level._custom_perks[ str_perk ].clientfield_register = func_clientfield_register;
    }
    
    if ( !isdefined( level._custom_perks[ str_perk ].clientfield_code_callback ) )
    {
        level._custom_perks[ str_perk ].clientfield_code_callback = func_code_callback;
    }
}

// Namespace zm_perks
// Params 2
// Checksum 0xf69d5707, Offset: 0x4d8
// Size: 0x64
function register_perk_effects( str_perk, str_light_effect )
{
    _register_undefined_perk( str_perk );
    
    if ( !isdefined( level._custom_perks[ str_perk ].machine_light_effect ) )
    {
        level._custom_perks[ str_perk ].machine_light_effect = str_light_effect;
    }
}

// Namespace zm_perks
// Params 2
// Checksum 0xdad231df, Offset: 0x548
// Size: 0x64
function register_perk_init_thread( str_perk, func_init_thread )
{
    _register_undefined_perk( str_perk );
    
    if ( !isdefined( level._custom_perks[ str_perk ].init_thread ) )
    {
        level._custom_perks[ str_perk ].init_thread = func_init_thread;
    }
}

// Namespace zm_perks
// Params 0
// Checksum 0xb86bb0d3, Offset: 0x5b8
// Size: 0xae
function init_perk_custom_threads()
{
    if ( level._custom_perks.size > 0 )
    {
        a_keys = getarraykeys( level._custom_perks );
        
        for ( i = 0; i < a_keys.size ; i++ )
        {
            if ( isdefined( level._custom_perks[ a_keys[ i ] ].init_thread ) )
            {
                level thread [[ level._custom_perks[ a_keys[ i ] ].init_thread ]]();
            }
        }
    }
}

// Namespace zm_perks
// Params 1
// Checksum 0x6acc932b, Offset: 0x670
// Size: 0x5a
function _register_undefined_perk( str_perk )
{
    if ( !isdefined( level._custom_perks ) )
    {
        level._custom_perks = [];
    }
    
    if ( !isdefined( level._custom_perks[ str_perk ] ) )
    {
        level._custom_perks[ str_perk ] = spawnstruct();
    }
}

// Namespace zm_perks
// Params 7
// Checksum 0xdcfab8c5, Offset: 0x6d8
// Size: 0xac
function perk_meteor_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self.meteor_fx = playfxontag( localclientnum, level._effect[ "perk_meteor" ], self, "tag_origin" );
        return;
    }
    
    if ( isdefined( self.meteor_fx ) )
    {
        stopfx( localclientnum, self.meteor_fx );
    }
}

// Namespace zm_perks
// Params 1
// Checksum 0x12efd45c, Offset: 0x790
// Size: 0x74
function init_perk_machines_fx( localclientnum )
{
    if ( !level.enable_magic )
    {
        return;
    }
    
    wait 0.1;
    machines = struct::get_array( "zm_perk_machine", "targetname" );
    array::thread_all( machines, &perk_start_up );
}

// Namespace zm_perks
// Params 0
// Checksum 0x15419e0, Offset: 0x810
// Size: 0x142
function perk_start_up()
{
    if ( isdefined( self.script_int ) )
    {
        power_zone = self.script_int;
        int = undefined;
        
        while ( int != power_zone )
        {
            level waittill( #"power_on", int );
        }
    }
    else
    {
        level waittill( #"power_on" );
    }
    
    timer = 0;
    duration = 0.1;
    
    while ( true )
    {
        if ( isdefined( level._custom_perks[ self.script_noteworthy ] ) && isdefined( level._custom_perks[ self.script_noteworthy ].machine_light_effect ) )
        {
            self thread vending_machine_flicker_light( level._custom_perks[ self.script_noteworthy ].machine_light_effect, duration );
        }
        
        timer += duration;
        duration += 0.2;
        
        if ( timer >= 3 )
        {
            break;
        }
        
        wait duration;
    }
}

// Namespace zm_perks
// Params 2
// Checksum 0xc4a0758, Offset: 0x960
// Size: 0x76
function vending_machine_flicker_light( fx_light, duration )
{
    players = level.localplayers;
    
    for ( i = 0; i < players.size ; i++ )
    {
        self thread play_perk_fx_on_client( i, fx_light, duration );
    }
}

// Namespace zm_perks
// Params 3
// Checksum 0xb34faa2c, Offset: 0x9e0
// Size: 0xcc
function play_perk_fx_on_client( client_num, fx_light, duration )
{
    fxobj = spawn( client_num, self.origin + ( 0, 0, -50 ), "script_model" );
    fxobj setmodel( "tag_origin" );
    playfxontag( client_num, level._effect[ fx_light ], fxobj, "tag_origin" );
    wait duration;
    fxobj delete();
}

