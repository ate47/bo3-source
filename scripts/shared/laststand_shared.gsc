#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/util_shared;

#namespace laststand;

// Namespace laststand
// Params 0
// Checksum 0xf997efc, Offset: 0x190
// Size: 0x40
function player_is_in_laststand()
{
    if ( !( isdefined( self.no_revive_trigger ) && self.no_revive_trigger ) )
    {
        return isdefined( self.revivetrigger );
    }
    
    return isdefined( self.laststand ) && self.laststand;
}

// Namespace laststand
// Params 0
// Checksum 0x310e3175, Offset: 0x1d8
// Size: 0x82
function player_num_in_laststand()
{
    num = 0;
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ] player_is_in_laststand() )
        {
            num++;
        }
    }
    
    return num;
}

// Namespace laststand
// Params 0
// Checksum 0x4fddb829, Offset: 0x268
// Size: 0x26, Type: bool
function player_all_players_in_laststand()
{
    return player_num_in_laststand() == getplayers().size;
}

// Namespace laststand
// Params 0
// Checksum 0xda614525, Offset: 0x298
// Size: 0x16, Type: bool
function player_any_player_in_laststand()
{
    return player_num_in_laststand() > 0;
}

// Namespace laststand
// Params 3
// Checksum 0x196606, Offset: 0x2b8
// Size: 0x38, Type: bool
function laststand_allowed( sweapon, smeansofdeath, shitloc )
{
    if ( level.laststandpistol == "none" )
    {
        return false;
    }
    
    return true;
}

// Namespace laststand
// Params 0
// Checksum 0xf977ffa6, Offset: 0x2f8
// Size: 0x36
function cleanup_suicide_hud()
{
    if ( isdefined( self.suicideprompt ) )
    {
        self.suicideprompt destroy();
    }
    
    self.suicideprompt = undefined;
}

// Namespace laststand
// Params 0
// Checksum 0x9c90e015, Offset: 0x338
// Size: 0xbc
function clean_up_suicide_hud_on_end_game()
{
    self endon( #"disconnect" );
    self endon( #"stop_revive_trigger" );
    self endon( #"player_revived" );
    self endon( #"bled_out" );
    level util::waittill_any( "game_ended", "stop_suicide_trigger" );
    self cleanup_suicide_hud();
    
    if ( isdefined( self.suicidetexthud ) )
    {
        self.suicidetexthud destroy();
    }
    
    if ( isdefined( self.suicideprogressbar ) )
    {
        self.suicideprogressbar hud::destroyelem();
    }
}

// Namespace laststand
// Params 0
// Checksum 0xbe6acc14, Offset: 0x400
// Size: 0xac
function clean_up_suicide_hud_on_bled_out()
{
    self endon( #"disconnect" );
    self endon( #"stop_revive_trigger" );
    self util::waittill_any( "bled_out", "player_revived", "fake_death" );
    self cleanup_suicide_hud();
    
    if ( isdefined( self.suicideprogressbar ) )
    {
        self.suicideprogressbar hud::destroyelem();
    }
    
    if ( isdefined( self.suicidetexthud ) )
    {
        self.suicidetexthud destroy();
    }
}

// Namespace laststand
// Params 2
// Checksum 0xdbf1bb69, Offset: 0x4b8
// Size: 0x15a, Type: bool
function is_facing( facee, requireddot )
{
    if ( !isdefined( requireddot ) )
    {
        requireddot = 0.9;
    }
    
    orientation = self getplayerangles();
    forwardvec = anglestoforward( orientation );
    forwardvec2d = ( forwardvec[ 0 ], forwardvec[ 1 ], 0 );
    unitforwardvec2d = vectornormalize( forwardvec2d );
    tofaceevec = facee.origin - self.origin;
    tofaceevec2d = ( tofaceevec[ 0 ], tofaceevec[ 1 ], 0 );
    unittofaceevec2d = vectornormalize( tofaceevec2d );
    dotproduct = vectordot( unitforwardvec2d, unittofaceevec2d );
    return dotproduct > requireddot;
}

// Namespace laststand
// Params 0
// Checksum 0x5cfc7d19, Offset: 0x620
// Size: 0x138
function revive_hud_create()
{
    self.revive_hud = newclienthudelem( self );
    self.revive_hud.alignx = "center";
    self.revive_hud.aligny = "middle";
    self.revive_hud.horzalign = "center";
    self.revive_hud.vertalign = "bottom";
    self.revive_hud.foreground = 1;
    self.revive_hud.font = "default";
    self.revive_hud.fontscale = 1.5;
    self.revive_hud.alpha = 0;
    self.revive_hud.color = ( 1, 1, 1 );
    self.revive_hud.hidewheninmenu = 1;
    self.revive_hud settext( "" );
    self.revive_hud.y = -148;
}

// Namespace laststand
// Params 0
// Checksum 0xcce6bb0d, Offset: 0x760
// Size: 0x50
function revive_hud_show()
{
    assert( isdefined( self ) );
    assert( isdefined( self.revive_hud ) );
    self.revive_hud.alpha = 1;
}

// Namespace laststand
// Params 1
// Checksum 0xfcd44f36, Offset: 0x7b8
// Size: 0x50
function revive_hud_show_n_fade( time )
{
    revive_hud_show();
    self.revive_hud fadeovertime( time );
    self.revive_hud.alpha = 0;
}

/#

    // Namespace laststand
    // Params 3
    // Checksum 0xd86f4efd, Offset: 0x810
    // Size: 0x25e, Type: dev
    function drawcylinder( pos, rad, height )
    {
        currad = rad;
        curheight = height;
        
        for ( r = 0; r < 20 ; r++ )
        {
            theta = r / 20 * 360;
            theta2 = ( r + 1 ) / 20 * 360;
            line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, 0 ) );
            line( pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, curheight ) );
            line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ) );
        }
    }

#/

// Namespace laststand
// Params 0
// Checksum 0xa29137ba, Offset: 0xa78
// Size: 0x7e
function get_lives_remaining()
{
    assert( level.laststandgetupallowed, "<dev string:x28>" );
    
    if ( level.laststandgetupallowed && isdefined( self.laststand_info ) && isdefined( self.laststand_info.type_getup_lives ) )
    {
        return max( 0, self.laststand_info.type_getup_lives );
    }
    
    return 0;
}

// Namespace laststand
// Params 1
// Checksum 0x8eab02c1, Offset: 0xb00
// Size: 0xda
function update_lives_remaining( increment )
{
    assert( level.laststandgetupallowed, "<dev string:x28>" );
    assert( isdefined( increment ), "<dev string:x56>" );
    increment = isdefined( increment ) ? increment : 0;
    self.laststand_info.type_getup_lives = max( 0, increment ? self.laststand_info.type_getup_lives + 1 : self.laststand_info.type_getup_lives - 1 );
    self notify( #"laststand_lives_updated" );
}

// Namespace laststand
// Params 0
// Checksum 0xb0221d88, Offset: 0xbe8
// Size: 0x50
function player_getup_setup()
{
    println( "<dev string:x7b>" );
    self.laststand_info = spawnstruct();
    self.laststand_info.type_getup_lives = 0;
}

// Namespace laststand
// Params 0
// Checksum 0x7a430a53, Offset: 0xc40
// Size: 0x84
function laststand_getup_damage_watcher()
{
    self endon( #"player_revived" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"damage" );
        self.laststand_info.getup_bar_value -= 0.1;
        
        if ( self.laststand_info.getup_bar_value < 0 )
        {
            self.laststand_info.getup_bar_value = 0;
        }
    }
}

// Namespace laststand
// Params 0
// Checksum 0x7210c0c0, Offset: 0xcd0
// Size: 0x190
function laststand_getup_hud()
{
    self endon( #"player_revived" );
    self endon( #"disconnect" );
    hudelem = newclienthudelem( self );
    hudelem.alignx = "left";
    hudelem.aligny = "middle";
    hudelem.horzalign = "left";
    hudelem.vertalign = "middle";
    hudelem.x = 5;
    hudelem.y = 170;
    hudelem.font = "big";
    hudelem.fontscale = 1.5;
    hudelem.foreground = 1;
    hudelem.hidewheninmenu = 1;
    hudelem.hidewhendead = 1;
    hudelem.sort = 2;
    hudelem.label = &"SO_WAR_LASTSTAND_GETUP_BAR";
    self thread laststand_getup_hud_destroy( hudelem );
    
    while ( true )
    {
        hudelem setvalue( self.laststand_info.getup_bar_value );
        wait 0.05;
    }
}

// Namespace laststand
// Params 1
// Checksum 0xd86b10f0, Offset: 0xe68
// Size: 0x4c
function laststand_getup_hud_destroy( hudelem )
{
    self util::waittill_either( "player_revived", "disconnect" );
    hudelem destroy();
}

// Namespace laststand
// Params 0
// Checksum 0xa6344d42, Offset: 0xec0
// Size: 0x6c
function cleanup_laststand_on_disconnect()
{
    self endon( #"player_revived" );
    self endon( #"player_suicide" );
    self endon( #"bled_out" );
    trig = self.revivetrigger;
    self waittill( #"disconnect" );
    
    if ( isdefined( trig ) )
    {
        trig delete();
    }
}

