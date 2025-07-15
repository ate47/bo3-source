#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_blockers;
#using scripts/zm/zm_temple;
#using scripts/zm/zm_temple_pack_a_punch;

#namespace zm_temple_elevators;

// Namespace zm_temple_elevators
// Params 0
// Checksum 0x55a9ecba, Offset: 0x438
// Size: 0x34
function init_elevator()
{
    level flag::wait_till( "initial_players_connected" );
    init_temple_geyser();
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0x9a7d2048, Offset: 0x478
// Size: 0x4be
function init_temple_geyser()
{
    level.geysers = getentarray( "temple_geyser", "targetname" );
    
    for ( i = 0; i < level.geysers.size ; i++ )
    {
        level.geysers[ i ].enabled = 0;
        level.geysers[ i ].line_emitter = i;
        geysertrigger = level.geysers[ i ];
        parms = strtok( geysertrigger.script_parameters, "," );
        geysertrigger.push_x = float( parms[ 0 ] );
        geysertrigger.push_y = float( parms[ 1 ] );
        geysertrigger.push_z = float( parms[ 2 ] );
        geysertrigger.push_time = float( parms[ 3 ] );
        geysertrigger.lift = getent( geysertrigger.target, "targetname" );
        geysertrigger.bottom = struct::get( geysertrigger.target, "targetname" );
        
        if ( !isdefined( geysertrigger.bottom.angles ) )
        {
            geysertrigger.bottom.angles = ( 0, 0, 0 );
        }
        
        geysertrigger.top = struct::get( geysertrigger.bottom.target, "targetname" );
        
        if ( !isdefined( geysertrigger.top.angles ) )
        {
            geysertrigger.top.angles = ( 0, 0, 0 );
        }
        
        geysertrigger.trigger_dust = getent( "trigger_" + geysertrigger.script_noteworthy + "_dust", "targetname" );
        
        if ( isdefined( geysertrigger.trigger_dust ) )
        {
            geysertrigger.trigger_dust thread geyser_trigger_dust_think();
        }
        
        if ( isdefined( geysertrigger.script_noteworthy ) )
        {
            level flag::init( geysertrigger.script_noteworthy + "_active" );
            blocker = getent( geysertrigger.script_noteworthy + "_blocker", "targetname" );
            
            if ( isdefined( blocker ) )
            {
                geysertrigger thread geyser_blocker_think( blocker );
            }
            
            geysertrigger.jump_down_start = getnode( geysertrigger.script_noteworthy + "_jump_down", "targetname" );
            
            if ( isdefined( geysertrigger.jump_down_start ) )
            {
                setenablenode( geysertrigger.jump_down_start, 0 );
                geysertrigger.jump_down_end = getnode( geysertrigger.jump_down_start.target, "targetname" );
            }
            
            geysertrigger.var_5a14c16 = getnode( geysertrigger.script_noteworthy + "_jump_up", "targetname" );
            
            if ( isdefined( geysertrigger.var_5a14c16 ) )
            {
                setenablenode( geysertrigger.var_5a14c16, 0 );
            }
        }
    }
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0x8ca64c25, Offset: 0x940
// Size: 0x12c
function alternate_geysers()
{
    currentgeyser = undefined;
    level waittill( #"geyser_enabled" );
    
    while ( true )
    {
        geysers = [];
        
        for ( i = 0; i < level.geysers.size ; i++ )
        {
            g = level.geysers[ i ];
            
            if ( ( !isdefined( currentgeyser ) || g != currentgeyser ) && g.enabled )
            {
                geysers[ geysers.size ] = g;
            }
        }
        
        if ( isdefined( currentgeyser ) )
        {
            currentgeyser notify( #"geyser_end" );
            currentgeyser = undefined;
        }
        
        if ( geysers.size > 0 )
        {
            currentgeyser = array::random( geysers );
            currentgeyser thread geyser_start();
        }
        
        level waittill( #"between_round_over" );
    }
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0xc1ac263a, Offset: 0xa78
// Size: 0xe4
function geyser_start()
{
    self.geyser_active = 0;
    var_f3e27be7 = getnode( self.script_noteworthy + "_jump_up", "targetname" );
    
    if ( isdefined( var_f3e27be7 ) )
    {
        setenablenode( var_f3e27be7, 1 );
    }
    
    var_2ba76614 = getnode( self.script_noteworthy + "_jump_down", "targetname" );
    
    if ( isdefined( var_2ba76614 ) )
    {
        setenablenode( var_2ba76614, 1 );
    }
    
    self thread geyser_watch_for_player();
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0x99fc5013, Offset: 0xb68
// Size: 0x70
function geyser_watch_for_zombies()
{
    self endon( #"geyser_end" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( !self.geyser_active )
        {
            continue;
        }
        
        if ( isai( who ) )
        {
            who zombie_geyser_kill();
        }
    }
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0xdcc63d98, Offset: 0xbe0
// Size: 0x228
function geyser_watch_for_player()
{
    self endon( #"geyser_end" );
    level endon( #"intermission" );
    level endon( #"fake_death" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( !isplayer( who ) )
        {
            continue;
        }
        
        if ( who.sessionstate == "spectator" )
        {
            continue;
        }
        
        if ( !self.geyser_active )
        {
            if ( who.origin[ 2 ] - self.bottom.origin[ 2 ] > 70 )
            {
                continue;
            }
        }
        
        if ( self.geyser_active )
        {
            who thread player_geyser_move( self );
            continue;
        }
        
        self playsound( "evt_geyser_buildup" );
        starttime = gettime();
        players = getplayers();
        
        while ( true )
        {
            playerstouching = [];
            
            for ( i = 0; i < players.size ; i++ )
            {
                if ( players[ i ] istouching( self ) )
                {
                    playerstouching[ playerstouching.size ] = players[ i ];
                }
            }
            
            if ( playerstouching.size == 0 )
            {
                break;
            }
            
            earthquake( 0.2, 0.1, self.bottom.origin, 100 );
            
            if ( gettime() - starttime > 1800 )
            {
                self thread geyser_activate( playerstouching );
                break;
            }
            
            wait 0.1;
        }
    }
}

// Namespace zm_temple_elevators
// Params 1
// Checksum 0x7a11dfc8, Offset: 0xe10
// Size: 0x2a
function geyser_activate( playerstouching )
{
    self geyser_erupt( playerstouching );
    wait 5;
}

// Namespace zm_temple_elevators
// Params 1
// Checksum 0x39207fb6, Offset: 0xe48
// Size: 0x1e0
function geyser_erupt( playerstouching )
{
    self.geyser_active = 1;
    
    if ( isdefined( self.trigger_dust ) )
    {
        self.trigger_dust thread geyser_trigger_dust_activate();
    }
    
    self thread geyser_fx();
    
    if ( isdefined( self.line_emitter ) )
    {
        util::clientnotify( "ge" + self.line_emitter );
    }
    
    for ( i = 0; i < playerstouching.size ; i++ )
    {
        playerstouching[ i ] thread player_geyser_move( self );
        playerstouching[ i ] thread zm_audio::create_and_play_dialog( "general", "geyser" );
    }
    
    if ( isdefined( self.jump_down_start ) && isdefined( self.jump_down_end ) )
    {
        unlinknodes( self.jump_down_start, self.jump_down_end );
    }
    
    level flag::set( self.script_noteworthy + "_active" );
    wait 10;
    self notify( #"stop_geyser_fx" );
    level flag::clear( self.script_noteworthy + "_active" );
    
    if ( isdefined( self.jump_down_start ) && isdefined( self.jump_down_end ) )
    {
        linknodes( self.jump_down_start, self.jump_down_end );
    }
    
    self.geyser_active = 0;
}

// Namespace zm_temple_elevators
// Params 1
// Checksum 0x6f61622b, Offset: 0x1030
// Size: 0x428
function player_geyser_move( geyser )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"spawned_spectator" );
    
    if ( isdefined( self.intermission ) && ( isdefined( self.riding_geyser ) && self.riding_geyser || self.intermission ) )
    {
        return;
    }
    
    self.riding_geyser = 1;
    
    if ( self laststand::player_is_in_laststand() )
    {
        self.geyser_anim = "geyserfakeprone";
    }
    else if ( self getstance() == "prone" )
    {
        self clientfield::set( "geyserfakeprone", 1 );
        self.geyser_anim = "geyserfakeprone";
    }
    else
    {
        self clientfield::set( "geyserfakestand", 1 );
        self.geyser_anim = "geyserfakestand";
    }
    
    if ( !self laststand::player_is_in_laststand() )
    {
        self ghost();
    }
    
    self.geyser_dust_time = gettime() + 2000;
    scale = ( geyser.top.origin[ 2 ] - self.origin[ 2 ] ) / ( geyser.top.origin[ 2 ] - geyser.bottom.origin[ 2 ] );
    scale = math::clamp( scale, 0.4, 1 );
    mover = spawn( "script_origin", self.origin );
    self playerlinkto( mover );
    x = geyser.push_x;
    y = geyser.push_y;
    z = geyser.push_z * scale;
    time = geyser.push_time * scale;
    mover movegravity( ( x, y, z ), time );
    self player_geyser_move_wait( time );
    vel = self getvelocity();
    
    if ( isdefined( self ) )
    {
        self clientfield::set( self.geyser_anim, 0 );
        util::wait_network_frame();
        self show();
    }
    
    self unlink();
    mover delete();
    
    if ( y > 0 )
    {
        self setvelocity( vel + ( 0, 175, 0 ) );
    }
    else
    {
        self setvelocity( vel + ( 0, -175, 0 ) );
    }
    
    wait 0.1;
    self.riding_geyser = 0;
}

// Namespace zm_temple_elevators
// Params 1
// Checksum 0x5d188c1f, Offset: 0x1460
// Size: 0x28
function player_geyser_move_wait( waittime )
{
    self endon( #"death" );
    self endon( #"player_downed" );
    wait waittime;
}

// Namespace zm_temple_elevators
// Params 1
// Checksum 0x4a973dd5, Offset: 0x1490
// Size: 0x2d0
function geyser_erupt_old( playerstouching )
{
    self.geyser_active = 1;
    self thread geyser_fx();
    moveuptime = 0.5;
    movedowntime = 0.1;
    movedist = 500;
    lift = getent( "geyser_lift", "targetname" );
    wait 0.1;
    start_origin = self.lift.origin;
    start_angles = self.lift.angles;
    
    for ( i = 0; i < playerstouching.size ; i++ )
    {
        playerstouching[ i ] setplayerangles( self.bottom.angles );
    }
    
    self.lift movez( movedist, moveuptime, 0.1, 0.3 );
    wait moveuptime;
    bouncetime = 0.3;
    bouncedist = 20;
    
    for ( i = 0; i < 2 ; i++ )
    {
        self.lift movez( bouncedist, bouncetime, bouncetime / 2, bouncetime / 2 );
        wait bouncetime;
        self.lift movez( -1 * bouncedist, bouncetime, bouncetime / 2, bouncetime / 2 );
        wait bouncetime;
    }
    
    self.lift movez( -250, 3, 0.2, 0.2 );
    wait 3;
    self.lift notsolid();
    self.lift.angles = start_angles;
    self.lift.origin = start_origin;
    wait 0.1;
    self.lift solid();
    wait 5;
    self notify( #"stop_geyser_fx" );
    self.geyser_active = 0;
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0xcd5d42ae, Offset: 0x1768
// Size: 0x9c
function geyser_fx()
{
    self thread geyser_earthquake();
    fxobj = spawnfx( level._effect[ "fx_ztem_geyser" ], self.bottom.origin );
    triggerfx( fxobj );
    self waittill( #"stop_geyser_fx" );
    wait 5;
    fxobj delete();
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0x9ca8988c, Offset: 0x1810
// Size: 0x50
function geyser_earthquake()
{
    self endon( #"stop_geyser_fx" );
    
    while ( true )
    {
        earthquake( 0.2, 0.1, self.origin, 100 );
        wait 0.1;
    }
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0x96b2c951, Offset: 0x1868
// Size: 0x74
function zombie_geyser_kill()
{
    self startragdoll();
    self launchragdoll( ( 0, 0, 1 ) * 300 );
    util::wait_network_frame();
    self dodamage( self.health + 666, self.origin );
}

// Namespace zm_temple_elevators
// Params 1
// Checksum 0xccf0fc9e, Offset: 0x18e8
// Size: 0x1b6
function geyser_blocker_think( blocker )
{
    switch ( self.script_noteworthy )
    {
        case "start_geyser":
            level flag::wait_till_any( array( "cave02_to_cave_water", "cave_water_to_power", "cave_water_to_waterfall" ) );
            exploder::exploder( "fxexp_8" );
            geyser_sounds( "geyser02", "evt_water_spout02", "evt_geyser_amb", 1 );
            break;
        case "minecart_geyser":
            level flag::wait_till_any( array( "start_to_pressure", "pressure_to_cave01" ) );
            level flag::wait_till_any( array( "cave01_to_cave02", "pressure_to_cave01" ) );
            exploder::exploder( "fxexp_9" );
            geyser_sounds( "geyser01", "evt_water_spout01", "evt_geyser_amb", 1 );
        default:
            break;
    }
    
    blocker thread geyser_blocker_remove();
    self thread geyser_start();
    self.enabled = 1;
    level notify( #"geyser_enabled", self );
}

// Namespace zm_temple_elevators
// Params 4
// Checksum 0xbdab0b65, Offset: 0x1aa8
// Size: 0x10c
function geyser_sounds( struct_name, sfx_start, sfx_loop, sfx_loop_delay )
{
    sound_struct = struct::get( struct_name, "targetname" );
    
    if ( isdefined( sound_struct ) )
    {
        level thread sound::play_in_space( sfx_start, sound_struct.origin );
        
        if ( isdefined( sfx_loop_delay ) && sfx_loop_delay > 0 )
        {
            wait sfx_loop_delay;
        }
        
        ambient_ent = spawn( "script_origin", ( 0, 0, 1 ) );
        
        if ( isdefined( ambient_ent ) )
        {
            ambient_ent.origin = sound_struct.origin;
            ambient_ent playloopsound( sfx_loop );
        }
    }
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0x2e58c912, Offset: 0x1bc0
// Size: 0x10c
function geyser_blocker_remove()
{
    clip = getent( self.target, "targetname" );
    clip notsolid();
    clip connectpaths();
    struct = spawnstruct();
    struct.origin = self.origin + ( 0, 0, 500 );
    struct.angles = self.angles + ( 0, 180, 0 );
    self.script_noteworthy = "jiggle";
    self.script_firefx = "poltergeist";
    self.script_fxid = "large_ceiling_dust";
    self zm_blockers::debris_move( struct );
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0x8f9732da, Offset: 0x1cd8
// Size: 0x3c
function geyser_trigger_dust_activate()
{
    self triggerenable( 1 );
    wait 3;
    self triggerenable( 0 );
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0xf16e40da, Offset: 0x1d20
// Size: 0xc0
function geyser_trigger_dust_think()
{
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( isdefined( player ) && isdefined( player.geyser_dust_time ) && player.geyser_dust_time > gettime() )
        {
            playfx( level._effect[ "player_land_dust" ], player.origin );
            player playsound( "fly_bodyfall_large_dirt" );
            player.geyser_dust_time = 0;
        }
    }
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0xc1ede475, Offset: 0x1de8
// Size: 0x20
function init_geyser_anims()
{
    level.geyser_anims = [];
    level.geyser_animtree = $generic;
}

// Namespace zm_temple_elevators
// Params 0
// Checksum 0x99ec1590, Offset: 0x1e10
// Size: 0x4
function init_animtree()
{
    
}

