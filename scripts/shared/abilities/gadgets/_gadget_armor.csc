#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_armor;

// Namespace _gadget_armor
// Params 0, eflags: 0x2
// Checksum 0xd2f680b0, Offset: 0x2f0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_armor", &__init__, undefined, undefined );
}

// Namespace _gadget_armor
// Params 0
// Checksum 0x8982a122, Offset: 0x330
// Size: 0xfc
function __init__()
{
    callback::on_localplayer_spawned( &on_local_player_spawned );
    clientfield::register( "allplayers", "armor_status", 1, 5, "int", &player_armor_changed, 0, 0 );
    clientfield::register( "toplayer", "player_damage_type", 1, 1, "int", &player_damage_type_changed, 0, 0 );
    duplicate_render::set_dr_filter_framebuffer_duplicate( "armor_pl", 40, "armor_on", undefined, 1, "mc/mtl_power_armor", 0 );
    
    /#
        level thread armor_overlay_think();
    #/
}

// Namespace _gadget_armor
// Params 1
// Checksum 0x506372ad, Offset: 0x438
// Size: 0x6c
function on_local_player_spawned( localclientnum )
{
    if ( self != getlocalplayer( localclientnum ) )
    {
        return;
    }
    
    newval = self clientfield::get( "armor_status" );
    self player_armor_changed_event( localclientnum, newval );
}

// Namespace _gadget_armor
// Params 7
// Checksum 0x1ac1566d, Offset: 0x4b0
// Size: 0x5c
function player_damage_type_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self armor_update_fx_event( localclientnum, newval );
}

// Namespace _gadget_armor
// Params 7
// Checksum 0x92c36ae1, Offset: 0x518
// Size: 0x5c
function player_armor_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self player_armor_changed_event( localclientnum, newval );
}

// Namespace _gadget_armor
// Params 2
// Checksum 0xe55162b3, Offset: 0x580
// Size: 0x54
function player_armor_changed_event( localclientnum, newval )
{
    self armor_update_fx_event( localclientnum, newval );
    self armor_update_shader_event( localclientnum, newval );
}

// Namespace _gadget_armor
// Params 2
// Checksum 0xc661cae3, Offset: 0x5e0
// Size: 0x224
function armor_update_shader_event( localclientnum, armorstatusnew )
{
    if ( armorstatusnew )
    {
        self duplicate_render::update_dr_flag( localclientnum, "armor_on", 1 );
        shieldexpansionncolor = "scriptVector3";
        shieldexpansionvaluex = 0.3;
        colorvector = armor_get_shader_color( armorstatusnew );
        
        if ( getdvarint( "scr_armor_dev" ) )
        {
            shieldexpansionvaluex = getdvarfloat( "scr_armor_expand", shieldexpansionvaluex );
            colorvector = ( getdvarfloat( "scr_armor_colorR", colorvector[ 0 ] ), getdvarfloat( "scr_armor_colorG", colorvector[ 1 ] ), getdvarfloat( "scr_armor_colorB", colorvector[ 2 ] ) );
        }
        
        colortintvaluey = colorvector[ 0 ];
        colortintvaluez = colorvector[ 1 ];
        colortintvaluew = colorvector[ 2 ];
        damagestate = "scriptVector4";
        damagestatevalue = armorstatusnew / 5;
        self mapshaderconstant( localclientnum, 0, shieldexpansionncolor, shieldexpansionvaluex, colortintvaluey, colortintvaluez, colortintvaluew );
        self mapshaderconstant( localclientnum, 0, damagestate, damagestatevalue );
        return;
    }
    
    self duplicate_render::update_dr_flag( localclientnum, "armor_on", 0 );
}

// Namespace _gadget_armor
// Params 1
// Checksum 0x682c141d, Offset: 0x810
// Size: 0x36
function armor_get_shader_color( armorstatusnew )
{
    color = ( 0.3, 0.3, 0.2 );
    return color;
}

// Namespace _gadget_armor
// Params 2
// Checksum 0x5aa83e2a, Offset: 0x850
// Size: 0xac
function armor_update_fx_event( localclientnum, doarmorfx )
{
    if ( !self armor_is_local_player( localclientnum ) )
    {
        return;
    }
    
    if ( doarmorfx )
    {
        self setdamagedirectionindicator( 1 );
        setsoundcontext( "plr_impact", "pwr_armor" );
        return;
    }
    
    self setdamagedirectionindicator( 0 );
    setsoundcontext( "plr_impact", "" );
}

// Namespace _gadget_armor
// Params 2
// Checksum 0x6d03d5bb, Offset: 0x908
// Size: 0x150
function armor_overlay_transition_fx( localclientnum, armorstatusnew )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( self._gadget_armor_state ) )
    {
        self._gadget_armor_state = 0;
    }
    
    if ( armorstatusnew == self._gadget_armor_state )
    {
        return;
    }
    
    self._gadget_armor_state = armorstatusnew;
    
    if ( armorstatusnew == 5 )
    {
        return;
    }
    
    if ( isdefined( self._armor_doing_transition ) && self._armor_doing_transition )
    {
        return;
    }
    
    self._armor_doing_transition = 1;
    transition = 0;
    flicker_start_time = getrealtime();
    saved_vision = getvisionsetnaked( localclientnum );
    visionsetnaked( localclientnum, "taser_mine_shock", transition );
    self playsound( 0, "wpn_taser_mine_tacmask" );
    wait 0.3;
    visionsetnaked( localclientnum, saved_vision, transition );
    self._armor_doing_transition = 0;
}

// Namespace _gadget_armor
// Params 1
// Checksum 0x282f2f3a, Offset: 0xa60
// Size: 0x4a
function armor_is_local_player( localclientnum )
{
    player_view = getlocalplayer( localclientnum );
    sameentity = self == player_view;
    return sameentity;
}

/#

    // Namespace _gadget_armor
    // Params 0
    // Checksum 0xef0a8c9a, Offset: 0xab8
    // Size: 0x140, Type: dev
    function armor_overlay_think()
    {
        armorstatus = 0;
        setdvar( "<dev string:x28>", 0 );
        
        while ( true )
        {
            wait 0.1;
            armorstatusnew = getdvarint( "<dev string:x28>" );
            
            if ( armorstatusnew != armorstatus )
            {
                players = getlocalplayers();
                
                foreach ( i, localplayer in players )
                {
                    if ( !isdefined( localplayer ) )
                    {
                        continue;
                    }
                    
                    localplayer player_armor_changed_event( i, armorstatusnew );
                }
                
                armorstatus = armorstatusnew;
            }
        }
    }

#/
