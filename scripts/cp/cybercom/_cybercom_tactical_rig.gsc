#using scripts/codescripts/struct;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/cp/cybercom/_cybercom_tactical_rig_copycat;
#using scripts/cp/cybercom/_cybercom_tactical_rig_emergencyreserve;
#using scripts/cp/cybercom/_cybercom_tactical_rig_multicore;
#using scripts/cp/cybercom/_cybercom_tactical_rig_playermovement;
#using scripts/cp/cybercom/_cybercom_tactical_rig_proximitydeterrent;
#using scripts/cp/cybercom/_cybercom_tactical_rig_repulsorarmor;
#using scripts/cp/cybercom/_cybercom_tactical_rig_sensorybuffer;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom_tacrig;

// Namespace cybercom_tacrig
// Params 0
// Checksum 0xc26c7ec8, Offset: 0x3b8
// Size: 0x74
function init()
{
    cybercom_tacrig_sensorybuffer::init();
    cybercom_tacrig_emergencyreserve::init();
    cybercom_tacrig_proximitydeterrent::init();
    cybercom_tacrig_respulsorarmor::init();
    cybercom_tacrig_playermovement::init();
    cybercom_tacrig_copycat::init();
    cybercom_tacrig_multicore::init();
}

// Namespace cybercom_tacrig
// Params 0
// Checksum 0xf4c1d185, Offset: 0x438
// Size: 0xb4
function main()
{
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    cybercom_tacrig_sensorybuffer::main();
    cybercom_tacrig_emergencyreserve::main();
    cybercom_tacrig_proximitydeterrent::main();
    cybercom_tacrig_respulsorarmor::main();
    cybercom_tacrig_playermovement::main();
    cybercom_tacrig_copycat::main();
    cybercom_tacrig_multicore::main();
}

// Namespace cybercom_tacrig
// Params 0
// Checksum 0x99ec1590, Offset: 0x4f8
// Size: 0x4
function on_player_connect()
{
    
}

// Namespace cybercom_tacrig
// Params 0
// Checksum 0x99ec1590, Offset: 0x508
// Size: 0x4
function on_player_spawned()
{
    
}

// Namespace cybercom_tacrig
// Params 2
// Checksum 0xe35b2a5c, Offset: 0x518
// Size: 0x9c
function register_cybercom_rig_ability( name, type )
{
    if ( !isdefined( level._cybercom_rig_ability ) )
    {
        level._cybercom_rig_ability = [];
    }
    
    if ( !isdefined( level._cybercom_rig_ability[ name ] ) )
    {
        level._cybercom_rig_ability[ name ] = spawnstruct();
        level._cybercom_rig_ability[ name ].name = name;
        level._cybercom_rig_ability[ name ].type = type;
    }
}

// Namespace cybercom_tacrig
// Params 3
// Checksum 0x442ede7, Offset: 0x5c0
// Size: 0x282
function register_cybercom_rig_possession_callbacks( name, on_give, on_take )
{
    assert( isdefined( level._cybercom_rig_ability[ name ] ) );
    
    if ( !isdefined( level._cybercom_rig_ability[ name ].on_give ) )
    {
        level._cybercom_rig_ability[ name ].on_give = [];
    }
    
    if ( !isdefined( level._cybercom_rig_ability[ name ].on_take ) )
    {
        level._cybercom_rig_ability[ name ].on_take = [];
    }
    
    if ( isdefined( on_give ) )
    {
        if ( !isdefined( level._cybercom_rig_ability[ name ].on_give ) )
        {
            level._cybercom_rig_ability[ name ].on_give = [];
        }
        else if ( !isarray( level._cybercom_rig_ability[ name ].on_give ) )
        {
            level._cybercom_rig_ability[ name ].on_give = array( level._cybercom_rig_ability[ name ].on_give );
        }
        
        level._cybercom_rig_ability[ name ].on_give[ level._cybercom_rig_ability[ name ].on_give.size ] = on_give;
    }
    
    if ( isdefined( on_take ) )
    {
        if ( !isdefined( level._cybercom_rig_ability[ name ].on_take ) )
        {
            level._cybercom_rig_ability[ name ].on_take = [];
        }
        else if ( !isarray( level._cybercom_rig_ability[ name ].on_take ) )
        {
            level._cybercom_rig_ability[ name ].on_take = array( level._cybercom_rig_ability[ name ].on_take );
        }
        
        level._cybercom_rig_ability[ name ].on_take[ level._cybercom_rig_ability[ name ].on_take.size ] = on_take;
    }
}

// Namespace cybercom_tacrig
// Params 3
// Checksum 0xfd823f8c, Offset: 0x850
// Size: 0x282
function register_cybercom_rig_activation_callbacks( name, turn_on, turn_off )
{
    assert( isdefined( level._cybercom_rig_ability[ name ] ) );
    
    if ( !isdefined( level._cybercom_rig_ability[ name ].turn_on ) )
    {
        level._cybercom_rig_ability[ name ].turn_on = [];
    }
    
    if ( !isdefined( level._cybercom_rig_ability[ name ].turn_off ) )
    {
        level._cybercom_rig_ability[ name ].turn_off = [];
    }
    
    if ( isdefined( turn_on ) )
    {
        if ( !isdefined( level._cybercom_rig_ability[ name ].turn_on ) )
        {
            level._cybercom_rig_ability[ name ].turn_on = [];
        }
        else if ( !isarray( level._cybercom_rig_ability[ name ].turn_on ) )
        {
            level._cybercom_rig_ability[ name ].turn_on = array( level._cybercom_rig_ability[ name ].turn_on );
        }
        
        level._cybercom_rig_ability[ name ].turn_on[ level._cybercom_rig_ability[ name ].turn_on.size ] = turn_on;
    }
    
    if ( isdefined( turn_off ) )
    {
        if ( !isdefined( level._cybercom_rig_ability[ name ].turn_off ) )
        {
            level._cybercom_rig_ability[ name ].turn_off = [];
        }
        else if ( !isarray( level._cybercom_rig_ability[ name ].turn_off ) )
        {
            level._cybercom_rig_ability[ name ].turn_off = array( level._cybercom_rig_ability[ name ].turn_off );
        }
        
        level._cybercom_rig_ability[ name ].turn_off[ level._cybercom_rig_ability[ name ].turn_off.size ] = turn_off;
    }
}

// Namespace cybercom_tacrig
// Params 2
// Checksum 0x75067220, Offset: 0xae0
// Size: 0xd6
function rigabilitygiven( type, upgraded )
{
    if ( !isdefined( level._cybercom_rig_ability[ type ] ) )
    {
        return;
    }
    
    if ( isdefined( level._cybercom_rig_ability[ type ].on_give ) )
    {
        foreach ( on_give in level._cybercom_rig_ability[ type ].on_give )
        {
            self [[ on_give ]]( type );
        }
    }
}

// Namespace cybercom_tacrig
// Params 4
// Checksum 0x642f9668, Offset: 0xbc0
// Size: 0xf0, Type: bool
function giverigability( type, upgraded, slot, setflags )
{
    if ( !isdefined( upgraded ) )
    {
        upgraded = 0;
    }
    
    if ( !isdefined( setflags ) )
    {
        setflags = 1;
    }
    
    if ( !isdefined( level._cybercom_rig_ability[ type ] ) )
    {
        return false;
    }
    
    if ( !isdefined( slot ) )
    {
        self setcybercomrig( type, upgraded );
    }
    else
    {
        self setcybercomrig( type, upgraded, slot );
    }
    
    if ( setflags )
    {
        self cybercom::updatecybercomflags();
    }
    
    self rigabilitygiven( type );
    return true;
}

// Namespace cybercom_tacrig
// Params 1
// Checksum 0x2be67616, Offset: 0xcb8
// Size: 0x40, Type: bool
function function_ccca7010( type )
{
    if ( !isdefined( level._cybercom_rig_ability[ type ] ) )
    {
        return false;
    }
    
    self _take_rig_ability( type );
    return true;
}

// Namespace cybercom_tacrig
// Params 1, eflags: 0x4
// Checksum 0xd9625089, Offset: 0xd00
// Size: 0x130, Type: bool
function private _take_rig_ability( type )
{
    if ( !isdefined( level._cybercom_rig_ability[ type ] ) )
    {
        return false;
    }
    
    if ( isdefined( level._cybercom_rig_ability[ type ] ) && isdefined( level._cybercom_rig_ability[ type ].on_take ) )
    {
        foreach ( on_take in level._cybercom_rig_ability[ type ].on_take )
        {
            self [[ on_take ]]( type );
        }
    }
    
    self notify( "take_ability_" + type );
    self clearcybercomrig( type );
    self cybercom::updatecybercomflags();
    return true;
}

// Namespace cybercom_tacrig
// Params 0
// Checksum 0x9fb48b37, Offset: 0xe38
// Size: 0xd4
function takeallrigabilities()
{
    foreach ( ability in level._cybercom_rig_ability )
    {
        if ( self hascybercomrig( ability.name ) != 0 )
        {
            _take_rig_ability( ability.name );
        }
    }
    
    self cybercom::updatecybercomflags();
}

// Namespace cybercom_tacrig
// Params 0
// Checksum 0x70f2cf9a, Offset: 0xf18
// Size: 0xf4
function giveallrigabilities()
{
    foreach ( ability in level._cybercom_rig_ability )
    {
        status = self hascybercomrig( ability.name );
        
        if ( status != 0 )
        {
            self giverigability( ability.name, status == 2 );
        }
    }
    
    self cybercom::updatecybercomflags();
}

// Namespace cybercom_tacrig
// Params 1
// Checksum 0xdf2d2562, Offset: 0x1018
// Size: 0x102
function turn_rig_ability_on( type )
{
    reserveability = self hascybercomrig( type );
    
    if ( reserveability == 0 )
    {
        return;
    }
    
    if ( isdefined( level._cybercom_rig_ability[ type ] ) && isdefined( level._cybercom_rig_ability[ type ].turn_on ) )
    {
        foreach ( turn_on in level._cybercom_rig_ability[ type ].turn_on )
        {
            self [[ turn_on ]]( type );
        }
    }
}

// Namespace cybercom_tacrig
// Params 1
// Checksum 0x80a4c4ff, Offset: 0x1128
// Size: 0x102
function turn_rig_ability_off( type )
{
    reserveability = self hascybercomrig( type );
    
    if ( reserveability == 0 )
    {
        return;
    }
    
    if ( isdefined( level._cybercom_rig_ability[ type ] ) && isdefined( level._cybercom_rig_ability[ type ].turn_off ) )
    {
        foreach ( turn_off in level._cybercom_rig_ability[ type ].turn_off )
        {
            self [[ turn_off ]]( type );
        }
    }
}

