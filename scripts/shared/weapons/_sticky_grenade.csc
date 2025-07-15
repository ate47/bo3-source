#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace sticky_grenade;

// Namespace sticky_grenade
// Params 0, eflags: 0x2
// Checksum 0x2f7cbaf1, Offset: 0x1f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "sticky_grenade", &__init__, undefined, undefined );
}

// Namespace sticky_grenade
// Params 0
// Checksum 0x550c155c, Offset: 0x238
// Size: 0x44
function __init__()
{
    level._effect[ "grenade_light" ] = "weapon/fx_equip_light_os";
    callback::add_weapon_type( "sticky_grenade", &spawned );
}

// Namespace sticky_grenade
// Params 1
// Checksum 0x90778741, Offset: 0x288
// Size: 0x44
function spawned( localclientnum )
{
    if ( self isgrenadedud() )
    {
        return;
    }
    
    self thread fx_think( localclientnum );
}

// Namespace sticky_grenade
// Params 1
// Checksum 0xc914722a, Offset: 0x2d8
// Size: 0x2c
function stop_sound_on_ent_shutdown( handle )
{
    self waittill( #"entityshutdown" );
    stopsound( handle );
}

// Namespace sticky_grenade
// Params 1
// Checksum 0xa452fdc0, Offset: 0x310
// Size: 0x20c
function fx_think( localclientnum )
{
    self notify( #"light_disable" );
    self endon( #"light_disable" );
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    handle = self playsound( localclientnum, "wpn_semtex_countdown" );
    self thread stop_sound_on_ent_shutdown( handle );
    
    for ( interval = 0.3;  ; interval = math::clamp( interval / 1.2, 0.08, 0.3 ) )
    {
        self stop_light_fx( localclientnum );
        localplayer = getlocalplayer( localclientnum );
        
        if ( !localplayer isentitylinkedtotag( self, "j_head" ) && !localplayer isentitylinkedtotag( self, "j_elbow_le" ) && !localplayer isentitylinkedtotag( self, "j_spineupper" ) )
        {
            self start_light_fx( localclientnum );
        }
        
        self fullscreen_fx( localclientnum );
        util::server_wait( localclientnum, interval, 0.01, "player_switch" );
        self util::waittill_dobj( localclientnum );
    }
}

// Namespace sticky_grenade
// Params 1
// Checksum 0x1e1cd13d, Offset: 0x528
// Size: 0x6c
function start_light_fx( localclientnum )
{
    player = getlocalplayer( localclientnum );
    self.fx = playfxontag( localclientnum, level._effect[ "grenade_light" ], self, "tag_fx" );
}

// Namespace sticky_grenade
// Params 1
// Checksum 0x42ab7a2c, Offset: 0x5a0
// Size: 0x4e
function stop_light_fx( localclientnum )
{
    if ( isdefined( self.fx ) && self.fx != 0 )
    {
        stopfx( localclientnum, self.fx );
        self.fx = undefined;
    }
}

// Namespace sticky_grenade
// Params 2
// Checksum 0x98e7f689, Offset: 0x5f8
// Size: 0xd4
function sticky_indicator( player, localclientnum )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    stickyimagemodel = createuimodel( controllermodel, "hudItems.stickyImage" );
    setuimodelvalue( stickyimagemodel, "hud_icon_stuck_semtex" );
    player thread stick_indicator_watch_early_shutdown( stickyimagemodel );
    
    while ( isdefined( self ) )
    {
        wait 0.016;
    }
    
    setuimodelvalue( stickyimagemodel, "blacktransparent" );
    player notify( #"sticky_shutdown" );
}

// Namespace sticky_grenade
// Params 1
// Checksum 0xca91a046, Offset: 0x6d8
// Size: 0x4c
function stick_indicator_watch_early_shutdown( stickyimagemodel )
{
    self endon( #"sticky_shutdown" );
    self endon( #"entityshutdown" );
    self waittill( #"player_flashback" );
    setuimodelvalue( stickyimagemodel, "blacktransparent" );
}

// Namespace sticky_grenade
// Params 1
// Checksum 0x2d0ee09b, Offset: 0x730
// Size: 0x12c
function fullscreen_fx( localclientnum )
{
    player = getlocalplayer( localclientnum );
    
    if ( isdefined( player ) )
    {
        if ( player getinkillcam( localclientnum ) )
        {
            return;
        }
        else if ( player util::is_player_view_linked_to_entity( localclientnum ) )
        {
            return;
        }
    }
    
    if ( self isfriendly( localclientnum ) )
    {
        return;
    }
    
    parent = self getparententity();
    
    if ( isdefined( parent ) && parent == player )
    {
        parent playrumbleonentity( localclientnum, "buzz_high" );
        
        if ( getdvarint( "ui_hud_hardcore" ) == 0 )
        {
            self thread sticky_indicator( player, localclientnum );
        }
    }
}

