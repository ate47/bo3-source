#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace decoy;

// Namespace decoy
// Params 0
// Checksum 0x9c1b8c04, Offset: 0xf8
// Size: 0x44
function init_shared()
{
    level thread level_watch_for_fake_fire();
    callback::add_weapon_type( "nightingale", &spawned );
}

// Namespace decoy
// Params 1
// Checksum 0x32f989bd, Offset: 0x148
// Size: 0x24
function spawned( localclientnum )
{
    self thread watch_for_fake_fire( localclientnum );
}

// Namespace decoy
// Params 1
// Checksum 0x346133b7, Offset: 0x178
// Size: 0x60
function watch_for_fake_fire( localclientnum )
{
    self endon( #"entityshutdown" );
    
    while ( true )
    {
        self waittill( #"fake_fire" );
        playfxontag( localclientnum, level._effect[ "decoy_fire" ], self, "tag_origin" );
    }
}

// Namespace decoy
// Params 0
// Checksum 0xecbe9d4f, Offset: 0x1e0
// Size: 0x28
function level_watch_for_fake_fire()
{
    while ( true )
    {
        self waittill( #"fake_fire", origin );
    }
}

