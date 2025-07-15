#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/footsteps_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_driving_fx;
#using scripts/zm/_filter;
#using scripts/zm/_sticky_grenade;

#namespace callback;

// Namespace callback
// Params 0, eflags: 0x2
// Checksum 0x5ad5873d, Offset: 0x238
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "callback", &__init__, undefined, undefined );
}

// Namespace callback
// Params 0
// Checksum 0x5d7e15a0, Offset: 0x278
// Size: 0x1c
function __init__()
{
    level thread set_default_callbacks();
}

// Namespace callback
// Params 0
// Checksum 0xcbf53703, Offset: 0x2a0
// Size: 0xac
function set_default_callbacks()
{
    level.callbackplayerspawned = &playerspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.callbackentityspawned = &entityspawned;
    level.callbackhostmigration = &host_migration;
    level.callbackplayaifootstep = &footsteps::playaifootstep;
    level.callbackplaylightloopexploder = &exploder::playlightloopexploder;
    level._custom_weapon_cb_func = &spawned_weapon_type;
}

// Namespace callback
// Params 1
// Checksum 0x4a89d19c, Offset: 0x358
// Size: 0x74
function localclientconnect( localclientnum )
{
    println( "<dev string:x28>" + localclientnum );
    callback( #"hash_da8d7d74", localclientnum );
    
    if ( isdefined( level.charactercustomizationsetup ) )
    {
        [[ level.charactercustomizationsetup ]]( localclientnum );
    }
}

// Namespace callback
// Params 1
// Checksum 0xde18dded, Offset: 0x3d8
// Size: 0xc4
function playerspawned( localclientnum )
{
    self endon( #"entityshutdown" );
    
    if ( isdefined( level._playerspawned_override ) )
    {
        self thread [[ level._playerspawned_override ]]( localclientnum );
        return;
    }
    
    println( "<dev string:x55>" );
    
    if ( self islocalplayer() )
    {
        callback( #"hash_842e788a", localclientnum );
    }
    
    callback( #"hash_bc12b61f", localclientnum );
    level.localplayers = getlocalplayers();
}

// Namespace callback
// Params 1
// Checksum 0xe536f726, Offset: 0x4a8
// Size: 0x268
function entityspawned( localclientnum )
{
    self endon( #"entityshutdown" );
    
    if ( self isplayer() )
    {
        if ( isdefined( level._clientfaceanimonplayerspawned ) )
        {
            self thread [[ level._clientfaceanimonplayerspawned ]]( localclientnum );
        }
    }
    
    if ( isdefined( level._entityspawned_override ) )
    {
        self thread [[ level._entityspawned_override ]]( localclientnum );
        return;
    }
    
    if ( !isdefined( self.type ) )
    {
        println( "<dev string:x64>" );
        return;
    }
    
    if ( self.type == "missile" )
    {
        if ( isdefined( level._custom_weapon_cb_func ) )
        {
            self thread [[ level._custom_weapon_cb_func ]]( localclientnum );
        }
        
        switch ( self.weapon.name )
        {
            default:
                self thread _sticky_grenade::spawned( localclientnum );
                break;
        }
        
        return;
    }
    
    if ( self.type == "vehicle" || self.type == "helicopter" || self.type == "plane" )
    {
        if ( isdefined( level._customvehiclecbfunc ) )
        {
            self thread [[ level._customvehiclecbfunc ]]( localclientnum );
        }
        
        self thread vehicle::field_toggle_exhaustfx_handler( localclientnum, undefined, 0, 1 );
        self thread vehicle::field_toggle_lights_handler( localclientnum, undefined, 0, 1 );
        
        if ( self.type == "plane" || self.type == "helicopter" )
        {
            self thread vehicle::aircraft_dustkick();
        }
        else
        {
            self thread driving_fx::play_driving_fx( localclientnum );
        }
        
        if ( self.type == "helicopter" )
        {
        }
        
        return;
    }
    
    if ( self.type == "actor" )
    {
        if ( isdefined( level._customactorcbfunc ) )
        {
            self thread [[ level._customactorcbfunc ]]( localclientnum );
        }
    }
}

// Namespace callback
// Params 1
// Checksum 0x8e874c0b, Offset: 0x718
// Size: 0x24
function host_migration( localclientnum )
{
    level thread prevent_round_switch_animation();
}

// Namespace callback
// Params 0
// Checksum 0xcfcd975c, Offset: 0x748
// Size: 0xa
function prevent_round_switch_animation()
{
    wait 3;
}

