#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;

#namespace zm_temple_waterslide;

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0xf2a5fde1, Offset: 0x480
// Size: 0x8e
function precache_assets()
{
    level._effect[ "fx_slide_wake" ] = "bio/player/fx_player_water_swim_wake";
    level._effect[ "fx_slide_splash" ] = "bio/player/fx_player_water_splash";
    level._effect[ "fx_slide_splash_2" ] = "env/water/fx_water_splash_fountain_lg";
    level._effect[ "fx_slide_splash_3" ] = "maps/pow/fx_pow_cave_water_splash";
    level._effect[ "fx_slide_water_fall" ] = "maps/pow/fx_pow_cave_water_fall";
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0x9d672953, Offset: 0x518
// Size: 0x29e
function waterslide_main()
{
    level flag::init( "waterslide_open" );
    zombie_cave_slide_init();
    messagetrigger = getent( "waterslide_message_trigger", "targetname" );
    
    if ( isdefined( messagetrigger ) )
    {
        messagetrigger setcursorhint( "HINT_NOICON" );
    }
    
    cheat = 0;
    
    /#
        cheat = getdvarint( "<dev string:x28>" ) > 0;
    #/
    
    if ( !cheat )
    {
        if ( isdefined( messagetrigger ) )
        {
            messagetrigger sethintstring( &"ZOMBIE_NEED_POWER" );
        }
        
        level flag::wait_till( "power_on" );
        
        if ( isdefined( messagetrigger ) )
        {
            messagetrigger sethintstring( &"ZM_TEMPLE_DESTINATION_NOT_OPEN" );
        }
        
        level flag::wait_till_any( array( "cave01_to_cave02", "pressure_to_cave01" ) );
    }
    
    level flag::set( "waterslide_open" );
    
    if ( isdefined( messagetrigger ) )
    {
        messagetrigger sethintstring( "" );
    }
    
    var_144a9b89 = getentarray( "water_slide_blocker", "targetname" );
    
    if ( isdefined( var_144a9b89 ) && var_144a9b89.size > 0 )
    {
        foreach ( e_blocker in var_144a9b89 )
        {
            e_blocker connectpaths();
            e_blocker movez( 128, 1 );
        }
    }
    
    level notify( #"slide_open" );
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0x9c1cf1b0, Offset: 0x7c0
// Size: 0xfc
function zombie_cave_slide_init()
{
    level flag::init( "slide_anim_change_allowed" );
    level.zombies_slide_anim_change = [];
    level thread slide_anim_change_throttle();
    level flag::set( "slide_anim_change_allowed" );
    slide_trigs = getentarray( "zombie_cave_slide", "targetname" );
    array::thread_all( slide_trigs, &slide_trig_watch );
    level thread slide_player_enter_watch();
    level thread slide_player_exit_watch();
    level thread zombie_caveslide_anim_failsafe();
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0x67fa6af1, Offset: 0x8c8
// Size: 0xb0
function zombie_caveslide_anim_failsafe()
{
    trig = getent( "zombie_cave_slide_failsafe", "targetname" );
    
    if ( isdefined( trig ) )
    {
        while ( true )
        {
            trig waittill( #"trigger", who );
            
            if ( isdefined( who.sliding ) && who.sliding )
            {
                who.sliding = 0;
                who thread reset_zombie_anim();
            }
        }
    }
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0xb3c808bc, Offset: 0x980
// Size: 0x174
function slide_trig_watch()
{
    slide_node = getnode( self.target, "targetname" );
    
    if ( !isdefined( slide_node ) )
    {
        return;
    }
    
    self triggerenable( 0 );
    level waittill( #"slide_open" );
    self triggerenable( 1 );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( who.animname == "zombie" || who.animname == "sonic_zombie" || who.animname == "napalm_zombie" )
        {
            if ( isdefined( who.sliding ) && who.sliding == 1 )
            {
                continue;
            }
            else
            {
                who thread zombie_sliding( slide_node );
            }
            
            continue;
        }
        
        if ( isdefined( who.zombie_sliding ) )
        {
            who thread [[ who.zombie_sliding ]]( slide_node );
        }
    }
}

// Namespace zm_temple_waterslide
// Params 1
// Checksum 0xc1fc8d61, Offset: 0xb00
// Size: 0x270
function zombie_sliding( slide_node )
{
    self endon( #"death" );
    level endon( #"intermission" );
    
    if ( !isdefined( self.cave_slide_flag_init ) )
    {
        self flag::init( "slide_anim_change" );
        self.cave_slide_flag_init = 1;
    }
    
    self.is_traversing = 1;
    self notify( #"zombie_start_traverse" );
    self thread zombie_slide_watch();
    self thread play_zombie_slide_looper();
    self.ignore_find_flesh = 1;
    self.sliding = 1;
    self.ignoreall = 1;
    self.b_ignore_cleanup = 1;
    self thread gibbed_while_sliding();
    self notify( #"stop_find_flesh" );
    self notify( #"zombie_acquire_enemy" );
    self.var_9c5ae704 = self.zombie_move_speed;
    self thread set_zombie_slide_anim();
    
    if ( !( isdefined( self.missinglegs ) && self.missinglegs ) )
    {
        self setphysparams( 15, 0, 24 );
    }
    
    self setgoalnode( slide_node );
    check_dist_squared = 3600;
    
    while ( distancesquared( self.origin, slide_node.origin ) > check_dist_squared )
    {
        wait 0.01;
    }
    
    self thread reset_zombie_anim();
    
    if ( !( isdefined( self.missinglegs ) && self.missinglegs ) )
    {
        self setphysparams( 15, 0, 72 );
    }
    
    self notify( #"water_slide_exit" );
    self.ignore_find_flesh = 0;
    self.sliding = 0;
    self.is_traversing = 0;
    self notify( #"zombie_end_traverse" );
    self.ignoreall = 0;
    self.b_ignore_cleanup = 0;
    self.ai_state = "find_flesh";
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0xc88b4c7f, Offset: 0xd78
// Size: 0x84
function play_zombie_slide_looper()
{
    self endon( #"death" );
    level endon( #"intermission" );
    self playloopsound( "fly_dtp_slide_loop_npc_snow", 0.5 );
    self util::waittill_any( "zombie_end_traverse", "death" );
    self stoploopsound( 0.5 );
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0xefd43c05, Offset: 0xe08
// Size: 0x14
function set_zombie_slide_anim()
{
    self.zombie_move_speed = "slide";
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0xe08f3ddc, Offset: 0xe28
// Size: 0x20
function reset_zombie_anim()
{
    if ( isdefined( self.var_9c5ae704 ) )
    {
        self.zombie_move_speed = self.var_9c5ae704;
    }
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0xa466b9f, Offset: 0xe50
// Size: 0xac
function death_while_sliding()
{
    self endon( #"death" );
    
    if ( self.animname == "sonic_zombie" || self.animname == "napalm_zombie" )
    {
        return self.deathanim;
    }
    
    death_animation = undefined;
    rand = randomintrange( 1, 5 );
    
    if ( !self.missinglegs )
    {
        death_animation = level.scr_anim[ self.animname ][ "attracted_death_" + rand ];
    }
    
    return death_animation;
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0xb367d0da, Offset: 0xf08
// Size: 0x94
function gibbed_while_sliding()
{
    self endon( #"death" );
    
    if ( self.animname == "sonic_zombie" || self.animname == "napalm_zombie" )
    {
        return;
    }
    
    if ( self.missinglegs )
    {
        return;
    }
    
    while ( self.sliding )
    {
        if ( self.missinglegs && self._had_legs == 1 )
        {
            self thread set_zombie_slide_anim();
            return;
        }
        
        wait 0.1;
    }
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0xd0ac906f, Offset: 0xfa8
// Size: 0x1f8
function slide_anim_change_throttle()
{
    if ( !isdefined( level.zombies_slide_anim_change ) )
    {
        level.zombies_slide_anim_change = [];
    }
    
    int_max_num_zombies_per_frame = 7;
    array_zombies_allowed_to_switch = [];
    
    while ( isdefined( level.zombies_slide_anim_change ) )
    {
        if ( level.zombies_slide_anim_change.size == 0 )
        {
            wait 0.1;
            continue;
        }
        
        array_zombies_allowed_to_switch = level.zombies_slide_anim_change;
        
        for ( i = 0; i < array_zombies_allowed_to_switch.size ; i++ )
        {
            if ( isdefined( array_zombies_allowed_to_switch[ i ] ) && isalive( array_zombies_allowed_to_switch[ i ] ) )
            {
                array_zombies_allowed_to_switch[ i ] flag::set( "slide_anim_change" );
            }
            
            if ( i >= int_max_num_zombies_per_frame )
            {
                break;
            }
        }
        
        level flag::clear( "slide_anim_change_allowed" );
        
        for ( i = 0; i < array_zombies_allowed_to_switch.size ; i++ )
        {
            if ( array_zombies_allowed_to_switch[ i ] flag::get( "slide_anim_change" ) )
            {
                level.zombies_slide_anim_change = arrayremovevalue( level.zombies_slide_anim_change, array_zombies_allowed_to_switch[ i ] );
            }
        }
        
        level.zombies_slide_anim_change = array::remove_dead( level.zombies_slide_anim_change );
        level flag::set( "slide_anim_change_allowed" );
        util::wait_network_frame();
        wait 0.1;
    }
}

// Namespace zm_temple_waterslide
// Params 2
// Checksum 0xe2dbf2ed, Offset: 0x11a8
// Size: 0x11c
function array_remove( array, object )
{
    if ( !isdefined( array ) && !isdefined( object ) )
    {
        return;
    }
    
    new_array = [];
    
    foreach ( item in array )
    {
        if ( item != object )
        {
            if ( !isdefined( new_array ) )
            {
                new_array = [];
            }
            else if ( !isarray( new_array ) )
            {
                new_array = array( new_array );
            }
            
            new_array[ new_array.size ] = item;
        }
    }
    
    return new_array;
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0x4cb62c4b, Offset: 0x12d0
// Size: 0x118
function slide_player_enter_watch()
{
    level endon( #"fake_death" );
    trig = getent( "cave_slide_force_crouch", "targetname" );
    
    while ( true )
    {
        trig waittill( #"trigger", who );
        
        if ( isdefined( who ) && isplayer( who ) && who.sessionstate != "spectator" && !( isdefined( who.on_slide ) && who.on_slide ) )
        {
            who.on_slide = 1;
            who thread player_slide_watch();
            who thread zm_audio::create_and_play_dialog( "general", "slide" );
        }
    }
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0x37932d7c, Offset: 0x13f0
// Size: 0xdc
function slide_player_exit_watch()
{
    trig = getent( "cave_slide_force_stand", "targetname" );
    
    while ( true )
    {
        trig waittill( #"trigger", who );
        
        if ( isdefined( who.on_slide ) && isdefined( who ) && isplayer( who ) && who.sessionstate != "spectator" && who.on_slide )
        {
            who.on_slide = 0;
            who notify( #"water_slide_exit" );
        }
    }
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0x33f89f59, Offset: 0x14d8
// Size: 0x84
function player_slide_watch()
{
    self thread on_player_enter_slide();
    self thread player_slide_fake_death_watch();
    self util::waittill_any( "water_slide_exit", "death", "disconnect" );
    
    if ( isdefined( self ) )
    {
        self thread on_player_exit_slide();
    }
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0x702f4fbb, Offset: 0x1568
// Size: 0x64
function player_slide_fake_death_watch()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"water_slide_exit" );
    self waittill( #"fake_death" );
    self allowstand( 1 );
    self allowprone( 1 );
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0xe46e171e, Offset: 0x15d8
// Size: 0x10c
function on_player_enter_slide()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"water_slide_exit" );
    self playloopsound( "evt_slideloop" );
    
    while ( self laststand::player_is_in_laststand() )
    {
        self.bleedout_time = 0;
        self playlocalsound( level.zmb_laugh_alias );
        self.on_slide = 0;
        return;
    }
    
    while ( isdefined( self.divetoprone ) && self.divetoprone )
    {
        wait 0.1;
    }
    
    self allowstand( 0 );
    self allowprone( 0 );
    self setstance( "crouch" );
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0x5e2c5038, Offset: 0x16f0
// Size: 0x9c
function on_player_exit_slide()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self allowstand( 1 );
    self allowprone( 1 );
    
    if ( !self laststand::player_is_in_laststand() )
    {
        self setstance( "stand" );
    }
    
    self stoploopsound();
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0x5b1e63ec, Offset: 0x1798
// Size: 0x5c
function zombie_slide_watch()
{
    self thread on_zombie_enter_slide();
    self util::waittill_any( "water_slide_exit", "death" );
    self thread on_zombie_exit_slide();
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0xf73001cc, Offset: 0x1800
// Size: 0x24
function on_zombie_enter_slide()
{
    self playloopsound( "evt_slideloop" );
}

// Namespace zm_temple_waterslide
// Params 0
// Checksum 0xaf09e203, Offset: 0x1830
// Size: 0x1c
function on_zombie_exit_slide()
{
    self stoploopsound();
}

