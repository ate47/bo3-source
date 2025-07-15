#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _gadget_shock_field;

// Namespace _gadget_shock_field
// Params 0, eflags: 0x2
// Checksum 0x16894bc6, Offset: 0x260
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_shock_field", &__init__, undefined, undefined );
}

// Namespace _gadget_shock_field
// Params 0
// Checksum 0x552495a1, Offset: 0x2a0
// Size: 0x114
function __init__()
{
    clientfield::register( "allplayers", "shock_field", 1, 1, "int" );
    ability_player::register_gadget_activation_callbacks( 39, &gadget_shock_field_on, &gadget_shock_field_off );
    ability_player::register_gadget_possession_callbacks( 39, &gadget_shock_field_on_give, &gadget_shock_field_on_take );
    ability_player::register_gadget_flicker_callbacks( 39, &gadget_shock_field_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 39, &gadget_shock_field_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 39, &gadget_shock_field_is_flickering );
    callback::on_connect( &gadget_shock_field_on_connect );
}

// Namespace _gadget_shock_field
// Params 1
// Checksum 0x5bae1465, Offset: 0x3c0
// Size: 0x22
function gadget_shock_field_is_inuse( slot )
{
    return self gadgetisactive( slot );
}

// Namespace _gadget_shock_field
// Params 1
// Checksum 0x295742d3, Offset: 0x3f0
// Size: 0xc
function gadget_shock_field_is_flickering( slot )
{
    
}

// Namespace _gadget_shock_field
// Params 2
// Checksum 0x388f0484, Offset: 0x408
// Size: 0x14
function gadget_shock_field_on_flicker( slot, weapon )
{
    
}

// Namespace _gadget_shock_field
// Params 2
// Checksum 0x61bf7317, Offset: 0x428
// Size: 0x34
function gadget_shock_field_on_give( slot, weapon )
{
    self clientfield::set( "shock_field", 0 );
}

// Namespace _gadget_shock_field
// Params 2
// Checksum 0x8c45e4c6, Offset: 0x468
// Size: 0x34
function gadget_shock_field_on_take( slot, weapon )
{
    self clientfield::set( "shock_field", 0 );
}

// Namespace _gadget_shock_field
// Params 0
// Checksum 0x99ec1590, Offset: 0x4a8
// Size: 0x4
function gadget_shock_field_on_connect()
{
    
}

// Namespace _gadget_shock_field
// Params 2
// Checksum 0x78865025, Offset: 0x4b8
// Size: 0x6c
function gadget_shock_field_on( slot, weapon )
{
    self gadgetsetactivatetime( slot, gettime() );
    self thread shock_field_think( slot, weapon );
    self clientfield::set( "shock_field", 1 );
}

// Namespace _gadget_shock_field
// Params 2
// Checksum 0x3f54a044, Offset: 0x530
// Size: 0x44
function gadget_shock_field_off( slot, weapon )
{
    self notify( #"shock_field_off" );
    self clientfield::set( "shock_field", 0 );
}

// Namespace _gadget_shock_field
// Params 2
// Checksum 0x3647e524, Offset: 0x580
// Size: 0x2de
function shock_field_think( slot, weapon )
{
    self endon( #"shock_field_off" );
    self notify( #"shock_field_on" );
    self endon( #"shock_field_on" );
    
    while ( true )
    {
        wait 0.25;
        
        if ( !self gadget_shock_field_is_inuse( slot ) )
        {
            return;
        }
        
        entities = getdamageableentarray( self.origin, weapon.gadget_shockfield_radius );
        
        foreach ( entity in entities )
        {
            if ( isplayer( entity ) )
            {
                if ( self getentitynumber() == entity getentitynumber() )
                {
                    continue;
                }
                
                if ( self.team == entity.team )
                {
                    continue;
                }
                
                if ( !isalive( entity ) )
                {
                    continue;
                }
                
                if ( bullettracepassed( self.origin + ( 0, 0, 30 ), entity.origin + ( 0, 0, 30 ), 1, self, undefined, 0, 1 ) )
                {
                    entity dodamage( weapon.gadget_shockfield_damage, self.origin + ( 0, 0, 30 ), self, self, 0, "MOD_GRENADE_SPLASH" );
                    entity setdoublejumpenergy( 0 );
                    entity resetdoublejumprechargetime();
                    entity thread shock_field_zap_sound( weapon );
                    self thread flicker_field_fx();
                    shellshock_duration = 0.25;
                    
                    if ( entity util::mayapplyscreeneffect() )
                    {
                        shellshock_duration = 0.5;
                        entity shellshock( "proximity_grenade", shellshock_duration, 0 );
                    }
                }
            }
        }
    }
}

// Namespace _gadget_shock_field
// Params 1
// Checksum 0x852d1fa3, Offset: 0x868
// Size: 0x68
function shock_field_zap_sound( weapon )
{
    if ( isdefined( self.shock_field_zap_sound ) && self.shock_field_zap_sound )
    {
        return;
    }
    
    self.shock_field_zap_sound = 1;
    self playsound( "wpn_taser_mine_zap" );
    wait 1;
    
    if ( isdefined( self ) )
    {
        self.shock_field_zap_sound = 0;
    }
}

// Namespace _gadget_shock_field
// Params 0
// Checksum 0x3b5b5e28, Offset: 0x8d8
// Size: 0x8c
function flicker_field_fx()
{
    self endon( #"shock_field_off" );
    self notify( #"flicker_field_fx" );
    self endon( #"flicker_field_fx" );
    self clientfield::set( "shock_field", 0 );
    wait randomfloatrange( 0.03, 0.23 );
    
    if ( isdefined( self ) )
    {
        self clientfield::set( "shock_field", 1 );
    }
}

