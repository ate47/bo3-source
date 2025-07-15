#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace util;

/#

    // Namespace util
    // Params 1
    // Checksum 0xa1fd40f2, Offset: 0x270
    // Size: 0x74, Type: dev
    function error( msg )
    {
        println( "<dev string:x28>", msg );
        wait 0.05;
        
        if ( getdvarstring( "<dev string:x33>" ) != "<dev string:x39>" )
        {
            assertmsg( "<dev string:x3b>" );
        }
    }

    // Namespace util
    // Params 1
    // Checksum 0xa02aa6f1, Offset: 0x2f0
    // Size: 0x34, Type: dev
    function warning( msg )
    {
        println( "<dev string:x68>" + msg );
    }

#/

// Namespace util
// Params 0
// Checksum 0x29c03407, Offset: 0x330
// Size: 0xec
function brush_delete()
{
    num = self.v[ "exploder" ];
    
    if ( isdefined( self.v[ "delay" ] ) )
    {
        wait self.v[ "delay" ];
    }
    else
    {
        wait 0.05;
    }
    
    if ( !isdefined( self.model ) )
    {
        return;
    }
    
    assert( isdefined( self.model ) );
    
    if ( !isdefined( self.v[ "fxid" ] ) || self.v[ "fxid" ] == "No FX" )
    {
        self.v[ "exploder" ] = undefined;
    }
    
    waittillframeend();
    self.model delete();
}

// Namespace util
// Params 0
// Checksum 0x8dd2055d, Offset: 0x428
// Size: 0x7c
function brush_show()
{
    if ( isdefined( self.v[ "delay" ] ) )
    {
        wait self.v[ "delay" ];
    }
    
    assert( isdefined( self.model ) );
    self.model show();
    self.model solid();
}

// Namespace util
// Params 0
// Checksum 0x47e4c043, Offset: 0x4b0
// Size: 0x20c
function brush_throw()
{
    if ( isdefined( self.v[ "delay" ] ) )
    {
        wait self.v[ "delay" ];
    }
    
    ent = undefined;
    
    if ( isdefined( self.v[ "target" ] ) )
    {
        ent = getent( self.v[ "target" ], "targetname" );
    }
    
    if ( !isdefined( ent ) )
    {
        self.model delete();
        return;
    }
    
    self.model show();
    startorg = self.v[ "origin" ];
    startang = self.v[ "angles" ];
    org = ent.origin;
    temp_vec = org - self.v[ "origin" ];
    x = temp_vec[ 0 ];
    y = temp_vec[ 1 ];
    z = temp_vec[ 2 ];
    self.model rotatevelocity( ( x, y, z ), 12 );
    self.model movegravity( ( x, y, z ), 12 );
    self.v[ "exploder" ] = undefined;
    wait 6;
    self.model delete();
}

// Namespace util
// Params 2
// Checksum 0x8d6618ce, Offset: 0x6c8
// Size: 0x176
function playsoundonplayers( sound, team )
{
    assert( isdefined( level.players ) );
    
    if ( level.splitscreen )
    {
        if ( isdefined( level.players[ 0 ] ) )
        {
            level.players[ 0 ] playlocalsound( sound );
        }
        
        return;
    }
    
    if ( isdefined( team ) )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            
            if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
            {
                player playlocalsound( sound );
            }
        }
        
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        level.players[ i ] playlocalsound( sound );
    }
}

// Namespace util
// Params 0
// Checksum 0xaf6a8c70, Offset: 0x848
// Size: 0xa
function get_player_height()
{
    return 70;
}

// Namespace util
// Params 1
// Checksum 0xf8a53991, Offset: 0x860
// Size: 0x3c, Type: bool
function isbulletimpactmod( smeansofdeath )
{
    return issubstr( smeansofdeath, "BULLET" ) || smeansofdeath == "MOD_HEAD_SHOT";
}

// Namespace util
// Params 0
// Checksum 0x673c12e1, Offset: 0x8a8
// Size: 0x40
function waitrespawnbutton()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    
    while ( self usebuttonpressed() != 1 )
    {
        wait 0.05;
    }
}

// Namespace util
// Params 3
// Checksum 0x393a04cd, Offset: 0x8f0
// Size: 0x200
function setlowermessage( text, time, combinemessageandtimer )
{
    if ( !isdefined( self.lowermessage ) )
    {
        return;
    }
    
    if ( isdefined( self.lowermessageoverride ) && text != &"" )
    {
        text = self.lowermessageoverride;
        time = undefined;
    }
    
    self notify( #"lower_message_set" );
    self.lowermessage settext( text );
    
    if ( isdefined( time ) && time > 0 )
    {
        if ( !isdefined( combinemessageandtimer ) || !combinemessageandtimer )
        {
            self.lowertimer.label = &"";
        }
        else
        {
            self.lowermessage settext( "" );
            self.lowertimer.label = text;
        }
        
        self.lowertimer settimer( time );
    }
    else
    {
        self.lowertimer settext( "" );
        self.lowertimer.label = &"";
    }
    
    if ( self issplitscreen() )
    {
        self.lowermessage.fontscale = 1.4;
    }
    
    self.lowermessage fadeovertime( 0.05 );
    self.lowermessage.alpha = 1;
    self.lowertimer fadeovertime( 0.05 );
    self.lowertimer.alpha = 1;
}

// Namespace util
// Params 3
// Checksum 0x85b3cb54, Offset: 0xaf8
// Size: 0x228
function setlowermessagevalue( text, value, combinemessage )
{
    if ( !isdefined( self.lowermessage ) )
    {
        return;
    }
    
    if ( isdefined( self.lowermessageoverride ) && text != &"" )
    {
        text = self.lowermessageoverride;
        time = undefined;
    }
    
    self notify( #"lower_message_set" );
    
    if ( !isdefined( combinemessage ) || !combinemessage )
    {
        self.lowermessage settext( text );
    }
    else
    {
        self.lowermessage settext( "" );
    }
    
    if ( isdefined( value ) && value > 0 )
    {
        if ( !isdefined( combinemessage ) || !combinemessage )
        {
            self.lowertimer.label = &"";
        }
        else
        {
            self.lowertimer.label = text;
        }
        
        self.lowertimer setvalue( value );
    }
    else
    {
        self.lowertimer settext( "" );
        self.lowertimer.label = &"";
    }
    
    if ( self issplitscreen() )
    {
        self.lowermessage.fontscale = 1.4;
    }
    
    self.lowermessage fadeovertime( 0.05 );
    self.lowermessage.alpha = 1;
    self.lowertimer fadeovertime( 0.05 );
    self.lowertimer.alpha = 1;
}

// Namespace util
// Params 1
// Checksum 0xa108f191, Offset: 0xd28
// Size: 0xf4
function clearlowermessage( fadetime )
{
    if ( !isdefined( self.lowermessage ) )
    {
        return;
    }
    
    self notify( #"lower_message_set" );
    
    if ( !isdefined( fadetime ) || fadetime == 0 )
    {
        setlowermessage( &"" );
        return;
    }
    
    self endon( #"disconnect" );
    self endon( #"lower_message_set" );
    self.lowermessage fadeovertime( fadetime );
    self.lowermessage.alpha = 0;
    self.lowertimer fadeovertime( fadetime );
    self.lowertimer.alpha = 0;
    wait fadetime;
    self setlowermessage( "" );
}

// Namespace util
// Params 2
// Checksum 0x4a3577e3, Offset: 0xe28
// Size: 0xd6
function printonteam( text, team )
{
    assert( isdefined( level.players ) );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            player iprintln( text );
        }
    }
}

// Namespace util
// Params 2
// Checksum 0x616f55c6, Offset: 0xf08
// Size: 0xd6
function printboldonteam( text, team )
{
    assert( isdefined( level.players ) );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            player iprintlnbold( text );
        }
    }
}

// Namespace util
// Params 3
// Checksum 0x2f21df99, Offset: 0xfe8
// Size: 0xde
function printboldonteamarg( text, team, arg )
{
    assert( isdefined( level.players ) );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == team )
        {
            player iprintlnbold( text, arg );
        }
    }
}

// Namespace util
// Params 3
// Checksum 0x526cb98c, Offset: 0x10d0
// Size: 0x1c
function printonteamarg( text, team, arg )
{
    
}

// Namespace util
// Params 2
// Checksum 0x72cb3b72, Offset: 0x10f8
// Size: 0xee
function printonplayers( text, team )
{
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( team ) )
        {
            if ( isdefined( players[ i ].pers[ "team" ] ) && players[ i ].pers[ "team" ] == team )
            {
                players[ i ] iprintln( text );
            }
            
            continue;
        }
        
        players[ i ] iprintln( text );
    }
}

// Namespace util
// Params 7
// Checksum 0xbaaa1ade, Offset: 0x11f0
// Size: 0x516
function printandsoundoneveryone( team, enemyteam, printfriendly, printenemy, soundfriendly, soundenemy, printarg )
{
    shoulddosounds = isdefined( soundfriendly );
    shoulddoenemysounds = 0;
    
    if ( isdefined( soundenemy ) )
    {
        assert( shoulddosounds );
        shoulddoenemysounds = 1;
    }
    
    if ( !isdefined( printarg ) )
    {
        printarg = "";
    }
    
    if ( level.splitscreen || !shoulddosounds )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            playerteam = player.pers[ "team" ];
            
            if ( isdefined( playerteam ) )
            {
                if ( playerteam == team && isdefined( printfriendly ) && printfriendly != &"" )
                {
                    player iprintln( printfriendly, printarg );
                    continue;
                }
                
                if ( isdefined( printenemy ) && printenemy != &"" )
                {
                    if ( isdefined( enemyteam ) && playerteam == enemyteam )
                    {
                        player iprintln( printenemy, printarg );
                        continue;
                    }
                    
                    if ( !isdefined( enemyteam ) && playerteam != team )
                    {
                        player iprintln( printenemy, printarg );
                    }
                }
            }
        }
        
        if ( shoulddosounds )
        {
            assert( level.splitscreen );
            level.players[ 0 ] playlocalsound( soundfriendly );
        }
        
        return;
    }
    
    assert( shoulddosounds );
    
    if ( shoulddoenemysounds )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            playerteam = player.pers[ "team" ];
            
            if ( isdefined( playerteam ) )
            {
                if ( playerteam == team )
                {
                    if ( isdefined( printfriendly ) && printfriendly != &"" )
                    {
                        player iprintln( printfriendly, printarg );
                    }
                    
                    player playlocalsound( soundfriendly );
                    continue;
                }
                
                if ( !isdefined( enemyteam ) && ( isdefined( enemyteam ) && playerteam == enemyteam || playerteam != team ) )
                {
                    if ( isdefined( printenemy ) && printenemy != &"" )
                    {
                        player iprintln( printenemy, printarg );
                    }
                    
                    player playlocalsound( soundenemy );
                }
            }
        }
        
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        playerteam = player.pers[ "team" ];
        
        if ( isdefined( playerteam ) )
        {
            if ( playerteam == team )
            {
                if ( isdefined( printfriendly ) && printfriendly != &"" )
                {
                    player iprintln( printfriendly, printarg );
                }
                
                player playlocalsound( soundfriendly );
                continue;
            }
            
            if ( isdefined( printenemy ) && printenemy != &"" )
            {
                if ( isdefined( enemyteam ) && playerteam == enemyteam )
                {
                    player iprintln( printenemy, printarg );
                    continue;
                }
                
                if ( !isdefined( enemyteam ) && playerteam != team )
                {
                    player iprintln( printenemy, printarg );
                }
            }
        }
    }
}

// Namespace util
// Params 1
// Checksum 0xd456b4b4, Offset: 0x1710
// Size: 0x4c
function _playlocalsound( soundalias )
{
    if ( level.splitscreen && !self ishost() )
    {
        return;
    }
    
    self playlocalsound( soundalias );
}

// Namespace util
// Params 1
// Checksum 0x260e7090, Offset: 0x1768
// Size: 0x74
function getotherteam( team )
{
    if ( team == "allies" )
    {
        return "axis";
    }
    else if ( team == "axis" )
    {
        return "allies";
    }
    else
    {
        return "allies";
    }
    
    assertmsg( "<dev string:x74>" + team );
}

// Namespace util
// Params 1
// Checksum 0xe633f130, Offset: 0x17e8
// Size: 0x64
function getteammask( team )
{
    if ( !level.teambased || !isdefined( team ) || !isdefined( level.spawnsystem.ispawn_teammask[ team ] ) )
    {
        return level.spawnsystem.ispawn_teammask_free;
    }
    
    return level.spawnsystem.ispawn_teammask[ team ];
}

// Namespace util
// Params 1
// Checksum 0x68a95ee8, Offset: 0x1858
// Size: 0xc4
function getotherteamsmask( skip_team )
{
    mask = 0;
    
    foreach ( team in level.teams )
    {
        if ( team == skip_team )
        {
            continue;
        }
        
        mask |= getteammask( team );
    }
    
    return mask;
}

/#

    // Namespace util
    // Params 5
    // Checksum 0x46f5f282, Offset: 0x1928
    // Size: 0x10e, Type: dev
    function plot_points( plotpoints, r, g, b, timer )
    {
        lastpoint = plotpoints[ 0 ];
        
        if ( !isdefined( r ) )
        {
            r = 1;
        }
        
        if ( !isdefined( g ) )
        {
            g = 1;
        }
        
        if ( !isdefined( b ) )
        {
            b = 1;
        }
        
        if ( !isdefined( timer ) )
        {
            timer = 0.05;
        }
        
        for ( i = 1; i < plotpoints.size ; i++ )
        {
            line( lastpoint, plotpoints[ i ], ( r, g, b ), 1, timer );
            lastpoint = plotpoints[ i ];
        }
    }

#/

// Namespace util
// Params 1
// Checksum 0xe2a1b730, Offset: 0x1a40
// Size: 0x50
function getfx( fx )
{
    assert( isdefined( level._effect[ fx ] ), "<dev string:x90>" + fx + "<dev string:x94>" );
    return level._effect[ fx ];
}

// Namespace util
// Params 3
// Checksum 0xd0c9770f, Offset: 0x1a98
// Size: 0x92
function set_dvar_if_unset( dvar, value, reset )
{
    if ( !isdefined( reset ) )
    {
        reset = 0;
    }
    
    if ( reset || getdvarstring( dvar ) == "" )
    {
        setdvar( dvar, value );
        return value;
    }
    
    return getdvarstring( dvar );
}

// Namespace util
// Params 3
// Checksum 0xc7e74d2b, Offset: 0x1b38
// Size: 0x8a
function set_dvar_float_if_unset( dvar, value, reset )
{
    if ( !isdefined( reset ) )
    {
        reset = 0;
    }
    
    if ( reset || getdvarstring( dvar ) == "" )
    {
        setdvar( dvar, value );
    }
    
    return getdvarfloat( dvar );
}

// Namespace util
// Params 3
// Checksum 0x494368f8, Offset: 0x1bd0
// Size: 0xa2
function set_dvar_int_if_unset( dvar, value, reset )
{
    if ( !isdefined( reset ) )
    {
        reset = 0;
    }
    
    if ( reset || getdvarstring( dvar ) == "" )
    {
        setdvar( dvar, value );
        return int( value );
    }
    
    return getdvarint( dvar );
}

// Namespace util
// Params 2
// Checksum 0x9c25316e, Offset: 0x1c80
// Size: 0x38, Type: bool
function isstrstart( string1, substr )
{
    return getsubstr( string1, 0, substr.size ) == substr;
}

// Namespace util
// Params 0
// Checksum 0x5dfd93aa, Offset: 0x1cc0
// Size: 0x16, Type: bool
function iskillstreaksenabled()
{
    return isdefined( level.killstreaksenabled ) && level.killstreaksenabled;
}

// Namespace util
// Params 1
// Checksum 0x394b61ba, Offset: 0x1ce0
// Size: 0x82
function setusingremote( remotename )
{
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
    }
    
    assert( !self isusingremote() );
    self.usingremote = remotename;
    self disableoffhandweapons();
    self notify( #"using_remote" );
}

// Namespace util
// Params 0
// Checksum 0xfea073ea, Offset: 0x1d70
// Size: 0x32
function getremotename()
{
    assert( self isusingremote() );
    return self.usingremote;
}

// Namespace util
// Params 2
// Checksum 0x977051ab, Offset: 0x1db0
// Size: 0x32
function setobjectivetext( team, text )
{
    game[ "strings" ][ "objective_" + team ] = text;
}

// Namespace util
// Params 2
// Checksum 0x907ea9e3, Offset: 0x1df0
// Size: 0x32
function setobjectivescoretext( team, text )
{
    game[ "strings" ][ "objective_score_" + team ] = text;
}

// Namespace util
// Params 2
// Checksum 0x74881b0, Offset: 0x1e30
// Size: 0x32
function setobjectivehinttext( team, text )
{
    game[ "strings" ][ "objective_hint_" + team ] = text;
}

// Namespace util
// Params 1
// Checksum 0xe4e71209, Offset: 0x1e70
// Size: 0x24
function getobjectivetext( team )
{
    return game[ "strings" ][ "objective_" + team ];
}

// Namespace util
// Params 1
// Checksum 0x337a7ca5, Offset: 0x1ea0
// Size: 0x24
function getobjectivescoretext( team )
{
    return game[ "strings" ][ "objective_score_" + team ];
}

// Namespace util
// Params 1
// Checksum 0x5c0b9bdd, Offset: 0x1ed0
// Size: 0x24
function getobjectivehinttext( team )
{
    return game[ "strings" ][ "objective_hint_" + team ];
}

// Namespace util
// Params 2
// Checksum 0xc29b81f9, Offset: 0x1f00
// Size: 0x64
function registerroundswitch( minvalue, maxvalue )
{
    level.roundswitch = math::clamp( getgametypesetting( "roundSwitch" ), minvalue, maxvalue );
    level.roundswitchmin = minvalue;
    level.roundswitchmax = maxvalue;
}

// Namespace util
// Params 2
// Checksum 0x713c3392, Offset: 0x1f70
// Size: 0x64
function registerroundlimit( minvalue, maxvalue )
{
    level.roundlimit = math::clamp( getgametypesetting( "roundLimit" ), minvalue, maxvalue );
    level.roundlimitmin = minvalue;
    level.roundlimitmax = maxvalue;
}

// Namespace util
// Params 2
// Checksum 0xa14bf1e8, Offset: 0x1fe0
// Size: 0x64
function registerroundwinlimit( minvalue, maxvalue )
{
    level.roundwinlimit = math::clamp( getgametypesetting( "roundWinLimit" ), minvalue, maxvalue );
    level.roundwinlimitmin = minvalue;
    level.roundwinlimitmax = maxvalue;
}

// Namespace util
// Params 2
// Checksum 0x2003c062, Offset: 0x2050
// Size: 0x84
function registerscorelimit( minvalue, maxvalue )
{
    level.scorelimit = math::clamp( getgametypesetting( "scoreLimit" ), minvalue, maxvalue );
    level.scorelimitmin = minvalue;
    level.scorelimitmax = maxvalue;
    setdvar( "ui_scorelimit", level.scorelimit );
}

// Namespace util
// Params 2
// Checksum 0x36d23cf6, Offset: 0x20e0
// Size: 0x84
function registertimelimit( minvalue, maxvalue )
{
    level.timelimit = math::clamp( getgametypesetting( "timeLimit" ), minvalue, maxvalue );
    level.timelimitmin = minvalue;
    level.timelimitmax = maxvalue;
    setdvar( "ui_timelimit", level.timelimit );
}

// Namespace util
// Params 2
// Checksum 0x11c9519d, Offset: 0x2170
// Size: 0x64
function registernumlives( minvalue, maxvalue )
{
    level.numlives = math::clamp( getgametypesetting( "playerNumLives" ), minvalue, maxvalue );
    level.numlivesmin = minvalue;
    level.numlivesmax = maxvalue;
}

// Namespace util
// Params 1
// Checksum 0xd89a118c, Offset: 0x21e0
// Size: 0x7e
function getplayerfromclientnum( clientnum )
{
    if ( clientnum < 0 )
    {
        return undefined;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] getentitynumber() == clientnum )
        {
            return level.players[ i ];
        }
    }
    
    return undefined;
}

// Namespace util
// Params 0
// Checksum 0xb7703687, Offset: 0x2268
// Size: 0x4c, Type: bool
function ispressbuild()
{
    buildtype = getdvarstring( "buildType" );
    
    if ( isdefined( buildtype ) && buildtype == "press" )
    {
        return true;
    }
    
    return false;
}

// Namespace util
// Params 0
// Checksum 0x5b41c029, Offset: 0x22c0
// Size: 0x1c, Type: bool
function isflashbanged()
{
    return isdefined( self.flashendtime ) && gettime() < self.flashendtime;
}

// Namespace util
// Params 5
// Checksum 0x4c7fc933, Offset: 0x22e8
// Size: 0xbc
function domaxdamage( origin, attacker, inflictor, headshot, mod )
{
    if ( isdefined( self.damagedtodeath ) && self.damagedtodeath )
    {
        return;
    }
    
    if ( isdefined( self.maxhealth ) )
    {
        damage = self.maxhealth + 1;
    }
    else
    {
        damage = self.health + 1;
    }
    
    self.damagedtodeath = 1;
    self dodamage( damage, origin, attacker, inflictor, headshot, mod );
}

// Namespace util
// Params 5
// Checksum 0xbfd0e975, Offset: 0x23b0
// Size: 0x328
function get_array_of_closest( org, array, excluders, max, maxdist )
{
    if ( !isdefined( max ) )
    {
        max = array.size;
    }
    
    if ( !isdefined( excluders ) )
    {
        excluders = [];
    }
    
    maxdists2rd = undefined;
    
    if ( isdefined( maxdist ) )
    {
        maxdists2rd = maxdist * maxdist;
    }
    
    dist = [];
    index = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( !isdefined( array[ i ] ) )
        {
            continue;
        }
        
        if ( isinarray( excluders, array[ i ] ) )
        {
            continue;
        }
        
        if ( isvec( array[ i ] ) )
        {
            length = distancesquared( org, array[ i ] );
        }
        else
        {
            length = distancesquared( org, array[ i ].origin );
        }
        
        if ( isdefined( maxdists2rd ) && maxdists2rd < length )
        {
            continue;
        }
        
        dist[ dist.size ] = length;
        index[ index.size ] = i;
    }
    
    for ( ;; )
    {
        change = 0;
        
        for ( i = 0; i < dist.size - 1 ; i++ )
        {
            if ( dist[ i ] <= dist[ i + 1 ] )
            {
                continue;
            }
            
            change = 1;
            temp = dist[ i ];
            dist[ i ] = dist[ i + 1 ];
            dist[ i + 1 ] = temp;
            temp = index[ i ];
            index[ i ] = index[ i + 1 ];
            index[ i + 1 ] = temp;
        }
        
        if ( !change )
        {
            break;
        }
    }
    
    newarray = [];
    
    if ( max > dist.size )
    {
        max = dist.size;
    }
    
    for ( i = 0; i < max ; i++ )
    {
        newarray[ i ] = array[ index[ i ] ];
    }
    
    return newarray;
}

