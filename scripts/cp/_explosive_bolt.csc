#using scripts/codescripts/struct;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace _explosive_bolt;

// Namespace _explosive_bolt
// Params 0
// Checksum 0x8a023d93, Offset: 0x128
// Size: 0x1e
function main()
{
    level._effect[ "crossbow_light" ] = "weapon/fx_equip_light_os";
}

// Namespace _explosive_bolt
// Params 1
// Checksum 0x439528b7, Offset: 0x150
// Size: 0x44
function spawned( localclientnum )
{
    if ( self isgrenadedud() )
    {
        return;
    }
    
    self thread fx_think( localclientnum );
}

// Namespace _explosive_bolt
// Params 1
// Checksum 0x350353a4, Offset: 0x1a0
// Size: 0x12c
function fx_think( localclientnum )
{
    self notify( #"light_disable" );
    self endon( #"entityshutdown" );
    self endon( #"light_disable" );
    self util::waittill_dobj( localclientnum );
    
    for ( interval = 0.3;  ; interval = math::clamp( interval / 1.2, 0.08, 0.3 ) )
    {
        self stop_light_fx( localclientnum );
        self start_light_fx( localclientnum );
        self fullscreen_fx( localclientnum );
        self playsound( localclientnum, "wpn_semtex_alert" );
        util::server_wait( localclientnum, interval, 0.01, "player_switch" );
    }
}

// Namespace _explosive_bolt
// Params 1
// Checksum 0xbfc8117e, Offset: 0x2d8
// Size: 0x6c
function start_light_fx( localclientnum )
{
    player = getlocalplayer( localclientnum );
    self.fx = playfxontag( localclientnum, level._effect[ "crossbow_light" ], self, "tag_origin" );
}

// Namespace _explosive_bolt
// Params 1
// Checksum 0xdb6b62d7, Offset: 0x350
// Size: 0x4e
function stop_light_fx( localclientnum )
{
    if ( isdefined( self.fx ) && self.fx != 0 )
    {
        stopfx( localclientnum, self.fx );
        self.fx = undefined;
    }
}

// Namespace _explosive_bolt
// Params 1
// Checksum 0x17a0a744, Offset: 0x3a8
// Size: 0xd4
function fullscreen_fx( localclientnum )
{
    player = getlocalplayer( localclientnum );
    
    if ( isdefined( player ) )
    {
        if ( player util::is_player_view_linked_to_entity( localclientnum ) )
        {
            return;
        }
    }
    
    if ( self util::friend_not_foe( localclientnum ) )
    {
        return;
    }
    
    parent = self getparententity();
    
    if ( isdefined( parent ) && parent == player )
    {
        parent playrumbleonentity( localclientnum, "buzz_high" );
    }
}

