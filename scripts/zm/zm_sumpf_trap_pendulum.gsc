#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_sumpf;
#using scripts/zm/zm_sumpf_zipline;

#namespace zm_sumpf_trap_pendulum;

// Namespace zm_sumpf_trap_pendulum
// Params 0
// Checksum 0x21d92f5e, Offset: 0x428
// Size: 0x210
function initpendulumtrap()
{
    penbuytrigger = getentarray( "pendulum_buy_trigger", "targetname" );
    
    for ( i = 0; i < penbuytrigger.size ; i++ )
    {
        penbuytrigger[ i ].lever = getent( penbuytrigger[ i ].target, "targetname" );
        penbuytrigger[ i ].pendamagetrig = getent( penbuytrigger[ i ].lever.target, "targetname" );
        penbuytrigger[ i ].pen = getent( penbuytrigger[ i ].pendamagetrig.target, "targetname" );
        penbuytrigger[ i ].pulley = getent( penbuytrigger[ i ].pen.target, "targetname" );
        penbuytrigger[ i ]._trap_type = "flogger";
    }
    
    penbuytrigger[ 0 ].pendamagetrig enablelinkto();
    penbuytrigger[ 0 ].pendamagetrig linkto( penbuytrigger[ 0 ].pen );
    level thread zm_sumpf::turnlightgreen( "pendulum_light" );
    level.var_99432870 = 0;
}

// Namespace zm_sumpf_trap_pendulum
// Params 0
// Checksum 0x84a42404, Offset: 0x640
// Size: 0xe2
function moveleverdown()
{
    soundent_left = getent( "switch_left", "targetname" );
    soundent_right = getent( "switch_right", "targetname" );
    self.lever rotatepitch( 180, 0.5 );
    soundent_left playsound( "zmb_switch_on" );
    soundent_right playsound( "zmb_switch_on" );
    self.lever waittill( #"rotatedone" );
    self notify( #"leverdown" );
}

// Namespace zm_sumpf_trap_pendulum
// Params 0
// Checksum 0xdaa11660, Offset: 0x730
// Size: 0xe2
function moveleverup()
{
    soundent_left = getent( "switch_left", "targetname" );
    soundent_right = getent( "switch_right", "targetname" );
    self.lever rotatepitch( -180, 0.5 );
    soundent_left playsound( "zmb_switch_off" );
    soundent_right playsound( "zmb_switch_off" );
    self.lever waittill( #"rotatedone" );
    self notify( #"leverup" );
}

// Namespace zm_sumpf_trap_pendulum
// Params 1
// Checksum 0x2a2f17d1, Offset: 0x820
// Size: 0xa4
function hint_string( string )
{
    if ( string == &"ZOMBIE_BUTTON_BUY_TRAP" )
    {
        self.is_available = 1;
        self.zombie_cost = 750;
        self.in_use = 0;
        self sethintstring( string, self.zombie_cost );
    }
    else
    {
        self sethintstring( string );
    }
    
    self setcursorhint( "HINT_NOICON" );
}

// Namespace zm_sumpf_trap_pendulum
// Params 0
// Checksum 0x98de429a, Offset: 0x8d0
// Size: 0x438
function penthink()
{
    self sethintstring( "" );
    pa_system = getent( "speaker_by_log", "targetname" );
    wait 0.5;
    self.is_available = 1;
    self.zombie_cost = 750;
    self sethintstring( &"ZOMBIE_BUTTON_BUY_TRAP", self.zombie_cost );
    self setcursorhint( "HINT_NOICON" );
    triggers = getentarray( "pendulum_buy_trigger", "targetname" );
    array::thread_all( triggers, &hint_string, &"ZOMBIE_BUTTON_BUY_TRAP" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        self.used_by = who;
        
        if ( who zm_utility::in_revive_trigger() || level.var_99432870 )
        {
            continue;
        }
        
        if ( zombie_utility::is_player_valid( who ) )
        {
            if ( who zm_score::can_player_purchase( self.zombie_cost ) )
            {
                if ( !level.var_99432870 )
                {
                    level.var_99432870 = 1;
                    level thread zm_sumpf::turnlightred( "pendulum_light" );
                    array::thread_all( triggers, &hint_string, &"ZOMBIE_TRAP_ACTIVE" );
                    zm_utility::play_sound_at_pos( "purchase", who.origin );
                    who thread zm_audio::create_and_play_dialog( "level", "trap_log" );
                    who zm_score::minus_to_player_score( self.zombie_cost );
                    self thread moveleverdown();
                    self waittill( #"leverdown" );
                    motor_left = getent( "engine_loop_left", "targetname" );
                    motor_right = getent( "engine_loop_right", "targetname" );
                    playsoundatposition( "zmb_motor_start_left", motor_left.origin );
                    playsoundatposition( "zmb_motor_start_right", motor_right.origin );
                    wait 0.5;
                    self thread activatepen( motor_left, motor_right, who );
                    self waittill( #"pendown" );
                    array::thread_all( triggers, &hint_string, &"ZOMBIE_TRAP_COOLDOWN" );
                    self thread moveleverup();
                    self waittill( #"leverup" );
                    wait 45;
                    pa_system playsound( "zmb_warning" );
                    level thread zm_sumpf::turnlightgreen( "pendulum_light" );
                    level.var_99432870 = 0;
                    array::thread_all( triggers, &hint_string, &"ZOMBIE_BUTTON_BUY_TRAP" );
                }
            }
        }
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 3
// Checksum 0xf4e47c6c, Offset: 0xd10
// Size: 0x344
function activatepen( motor_left, motor_right, who )
{
    wheel_left = spawn( "script_origin", motor_left.origin );
    wheel_right = spawn( "script_origin", motor_right.origin );
    util::wait_network_frame();
    motor_left playloopsound( "zmb_motor_loop_left" );
    motor_right playloopsound( "zmb_motor_loop_right" );
    util::wait_network_frame();
    wheel_left playloopsound( "zmb_wheel_loop" );
    wheel_right playloopsound( "zmb_belt_loop" );
    self.pen notify( #"stopmonitorsolid" );
    self.pen notsolid();
    self.pendamagetrig triggerenable( 1 );
    self.pendamagetrig thread pendamage( self, who );
    self.penactive = 1;
    
    if ( self.script_noteworthy == "1" )
    {
        self.pulley rotatepitch( -14040, 30, 6, 6 );
        self.pen rotatepitch( -14040, 30, 6, 6 );
    }
    else
    {
        self.pulley rotatepitch( 14040, 30, 6, 6 );
        self.pen rotatepitch( 14040, 30, 6, 6 );
    }
    
    level thread trap_sounds( motor_left, motor_right, wheel_left, wheel_right );
    self.pen thread blade_sounds();
    self.pen waittill( #"rotatedone" );
    self.pendamagetrig triggerenable( 0 );
    self.penactive = 0;
    self.pen thread zm_sumpf_zipline::objectsolid();
    self notify( #"pendown" );
    level notify( #"stop_blade_sounds" );
    wait 3;
    wheel_left delete();
    wheel_right delete();
}

// Namespace zm_sumpf_trap_pendulum
// Params 0
// Checksum 0x3d95905d, Offset: 0x1060
// Size: 0x26a
function blade_sounds()
{
    self endon( #"rotatedone" );
    blade_left = getent( "blade_left", "targetname" );
    blade_right = getent( "blade_right", "targetname" );
    
    for ( lastangle = self.angles[ 0 ];  ; lastangle = angle )
    {
        wooshangle = 90;
        wait 0.01;
        angle = self.angles[ 0 ];
        speed = int( abs( angle - lastangle ) ) % 360;
        relpos = int( abs( angle ) ) % 360;
        lastrelpos = int( abs( lastangle ) ) % 360;
        
        if ( relpos == lastrelpos || speed < 7 )
        {
            lastangle = angle;
            continue;
        }
        
        if ( relpos > wooshangle && lastrelpos <= wooshangle )
        {
            blade_left playsound( "zmb_blade_right" );
            blade_right playsound( "zmb_blade_right" );
        }
        
        if ( ( relpos + 180 ) % 360 > wooshangle && ( lastrelpos + 180 ) % 360 <= wooshangle )
        {
            blade_left playsound( "zmb_blade_right" );
            blade_right playsound( "zmb_blade_right" );
        }
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 4
// Checksum 0xb9afc176, Offset: 0x12d8
// Size: 0xd4
function trap_sounds( motor_left, motor_right, wheel_left, wheel_right )
{
    wait 13;
    motor_left stoploopsound( 2 );
    motor_left playsound( "zmb_motor_stop_left" );
    motor_right stoploopsound( 2 );
    motor_right playsound( "zmb_motor_stop_right" );
    wait 8;
    wheel_left stoploopsound( 8 );
    wheel_right stoploopsound( 8 );
}

// Namespace zm_sumpf_trap_pendulum
// Params 2
// Checksum 0x76900d20, Offset: 0x13b8
// Size: 0xb8
function pendamage( parent, who )
{
    level thread customtimer();
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( parent.penactive == 1 )
        {
            if ( isplayer( ent ) )
            {
                ent thread playerpendamage();
                continue;
            }
            
            ent thread zombiependamage( parent, who );
        }
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 0
// Checksum 0xf4bfac35, Offset: 0x1478
// Size: 0x44
function customtimer()
{
    level.my_time = 0;
    
    while ( level.my_time <= 20 )
    {
        wait 0.1;
        level.my_time += 0.1;
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 0
// Checksum 0x866f0943, Offset: 0x14c8
// Size: 0xec
function playerpendamage()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    players = getplayers();
    
    if ( players.size == 1 )
    {
        self dodamage( 80, self.origin + ( 0, 0, 20 ) );
        self setstance( "crouch" );
        return;
    }
    
    if ( !self laststand::player_is_in_laststand() )
    {
        radiusdamage( self.origin, 10, self.health + 100, self.health + 100 );
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 2
// Checksum 0xe12da9f6, Offset: 0x15c0
// Size: 0x264
function zombiependamage( parent, who )
{
    self endon( #"death" );
    self.var_9a9a0f55 = parent;
    self.var_aa99de67 = who;
    parent.activated_by_player = who;
    
    if ( level flag::get( "dog_round" ) )
    {
        self.a.nodeath = 1;
        return;
    }
    
    if ( !isdefined( level.numlaunched ) )
    {
        level thread launch_monitor();
    }
    
    if ( !isdefined( self.flung ) )
    {
        if ( parent.script_noteworthy == "1" )
        {
            x = randomintrange( 200, 250 );
            y = randomintrange( -35, 35 );
            z = randomintrange( 95, 120 );
        }
        else
        {
            x = randomintrange( -250, -200 );
            y = randomintrange( -35, 35 );
            z = randomintrange( 95, 120 );
        }
        
        if ( level.my_time < 6 )
        {
            adjustment = level.my_time / 6;
        }
        else if ( level.my_time > 24 )
        {
            adjustment = ( 30 - level.my_time ) / 6;
        }
        else
        {
            adjustment = 1;
        }
        
        x *= adjustment;
        y *= adjustment;
        z *= adjustment;
        self thread do_launch( x, y, z, parent );
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 0
// Checksum 0xcc78f9f3, Offset: 0x1830
// Size: 0x4c
function launch_monitor()
{
    level.numlaunched = 0;
    
    while ( true )
    {
        util::wait_network_frame();
        util::wait_network_frame();
        level.numlaunched = 0;
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 4
// Checksum 0x11dafd2a, Offset: 0x1888
// Size: 0x13c
function do_launch( x, y, z, parent )
{
    self.flung = 1;
    
    while ( level.numlaunched > 4 )
    {
        util::wait_network_frame();
    }
    
    self thread play_imp_sound();
    self startragdoll();
    self launchragdoll( ( x, y, z ) );
    util::wait_network_frame();
    self dodamage( self.health, self.origin, parent );
    
    if ( isdefined( parent.activated_by_player ) && isplayer( parent.activated_by_player ) )
    {
        parent.activated_by_player zm_stats::increment_challenge_stat( "ZOMBIE_HUNTER_KILL_TRAP" );
    }
    
    level.numlaunched++;
}

// Namespace zm_sumpf_trap_pendulum
// Params 0
// Checksum 0xaee0d34, Offset: 0x19d0
// Size: 0x40
function flogger_vocal_monitor()
{
    while ( true )
    {
        level.numfloggervox = 0;
        util::wait_network_frame();
        util::wait_network_frame();
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 0
// Checksum 0x427ed8a9, Offset: 0x1a18
// Size: 0xcc
function play_imp_sound()
{
    if ( !isdefined( level.numfloggervox ) )
    {
        level thread flogger_vocal_monitor();
    }
    
    self playsound( "zmb_flogger_death" );
    
    if ( level.numfloggervox < 5 )
    {
        self playsound( "zmb_vocals_zombie_death" );
        self clientfield::set( "zombie_flogger_trap", 1 );
        level.numfloggervox++;
    }
    
    wait 0.75;
    self dodamage( self.health + 600, self.origin );
}

