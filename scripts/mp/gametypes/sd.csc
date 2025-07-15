#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/callbacks_shared;

#namespace sd;

// Namespace sd
// Params 0
// Checksum 0xfdd46164, Offset: 0xf8
// Size: 0x64
function main()
{
    callback::on_spawned( &on_player_spawned );
    
    if ( getgametypesetting( "silentPlant" ) != 0 )
    {
        setsoundcontext( "bomb_plant", "silent" );
    }
}

// Namespace sd
// Params 0
// Checksum 0x99ec1590, Offset: 0x168
// Size: 0x4
function onstartgametype()
{
    
}

// Namespace sd
// Params 1
// Checksum 0x8be7ef9, Offset: 0x178
// Size: 0x3c
function on_player_spawned( localclientnum )
{
    self thread player_sound_context_hack();
    self thread globallogic::watch_plant_sound( localclientnum );
}

// Namespace sd
// Params 0
// Checksum 0x40b028a5, Offset: 0x1c0
// Size: 0x7e
function player_sound_context_hack()
{
    if ( getgametypesetting( "silentPlant" ) != 0 )
    {
        self endon( #"entityshutdown" );
        self notify( #"player_sound_context_hack" );
        self endon( #"player_sound_context_hack" );
        
        while ( true )
        {
            self setsoundentcontext( "bomb_plant", "silent" );
            wait 1;
        }
    }
}

