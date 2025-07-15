#using scripts/codescripts/struct;
#using scripts/cp/_skipto;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace elevator;

// Namespace elevator
// Params 0, eflags: 0x2
// Checksum 0x484bd289, Offset: 0x2d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "elevator", &__init__, undefined, undefined );
}

// Namespace elevator
// Params 0
// Checksum 0x302ca9a0, Offset: 0x318
// Size: 0x39c
function __init__()
{
    platform_triggers = getentarray( "elevator_trigger", "targetname" );
    
    if ( platform_triggers.size <= 0 )
    {
        return;
    }
    
    platform_switches = [];
    platforms_non_switched = [];
    platforms_total = [];
    trigger_target_targets = [];
    
    for ( i = 0; i < platform_triggers.size ; i++ )
    {
        a_trigger_targets = getentarray( platform_triggers[ i ].target, "targetname" );
        
        for ( j = 0; j < a_trigger_targets.size ; j++ )
        {
            if ( a_trigger_targets[ j ].classname == "script_brushmodel" )
            {
                trigger_target = a_trigger_targets[ j ];
                break;
            }
        }
        
        if ( !isdefined( trigger_target ) )
        {
            assertmsg( "<dev string:x28>" + platform_triggers[ i ].origin );
        }
        
        if ( isdefined( trigger_target ) )
        {
            trigger_target_targets = getentarray( trigger_target.target, "targetname" );
            platforms_non_switched[ platforms_non_switched.size ] = trigger_target;
        }
    }
    
    for ( i = 0; i < platform_switches.size ; i++ )
    {
        platform = getent( platform_switches[ i ].target, "targetname" );
        
        if ( !isdefined( platform ) )
        {
            assertmsg( "<dev string:x4e>" + platform_switches[ i ].origin );
            continue;
        }
        
        counter = 0;
        
        for ( x = 0; x < platforms_total.size ; x++ )
        {
            if ( platform == platforms_total[ x ] )
            {
                counter++;
            }
        }
        
        if ( counter > 0 )
        {
            continue;
        }
        
        platforms_total[ platforms_total.size ] = platform;
    }
    
    for ( i = 0; i < platforms_non_switched.size ; i++ )
    {
        counter = 0;
        
        for ( x = 0; x < platforms_total.size ; x++ )
        {
            if ( platforms_non_switched[ i ] == platforms_total[ x ] )
            {
                counter++;
            }
        }
        
        if ( counter > 0 )
        {
            continue;
        }
        
        platforms_total[ platforms_total.size ] = platforms_non_switched[ i ];
    }
    
    array::thread_all( platforms_total, &define_elevator_parts, 0 );
}

// Namespace elevator
// Params 0
// Checksum 0x59508032, Offset: 0x6c0
// Size: 0x584
function define_elevator_parts()
{
    self setmovingplatformenabled( 1 );
    audio_points = [];
    klaxon_speakers = [];
    elevator_doors = [];
    platform_start = undefined;
    platform = self;
    platform_name = platform.targetname;
    platform.at_start = 1;
    platform_triggers = [];
    targets_platform = getentarray( platform_name, "target" );
    n_start_delay = 0;
    
    for ( i = 0; i < targets_platform.size ; i++ )
    {
        if ( targets_platform[ i ].classname == "script_model" || targets_platform[ i ].classname == "script_brushmodel" )
        {
            switch_trigger = getent( targets_platform[ i ].targetname, "target" );
            platform_triggers[ platform_triggers.size ] = switch_trigger;
            continue;
        }
        
        platform_triggers[ platform_triggers.size ] = targets_platform[ i ];
    }
    
    platform_targets_ents = getentarray( platform.target, "targetname" );
    platform_targets_structs = struct::get_array( platform.target, "targetname" );
    platform_targets = arraycombine( platform_targets_ents, platform_targets_structs, 1, 0 );
    
    if ( platform_targets.size <= 0 )
    {
        assertmsg( "<dev string:x77>" + platform.origin );
    }
    
    if ( isdefined( platform_targets ) )
    {
        for ( i = 0; i < platform_targets.size ; i++ )
        {
            if ( isdefined( platform_targets[ i ].script_noteworthy ) )
            {
                if ( platform_targets[ i ].script_noteworthy == "audio_point" )
                {
                    audio_points[ audio_points.size ] = platform_targets[ i ];
                }
                
                if ( platform_targets[ i ].script_noteworthy == "elevator_door" )
                {
                    elevator_doors[ elevator_doors.size ] = platform_targets[ i ];
                }
                
                if ( platform_targets[ i ].script_noteworthy == "elevator_klaxon_speaker" )
                {
                    klaxon_speakers[ klaxon_speakers.size ] = platform_targets[ i ];
                }
                
                if ( platform_targets[ i ].script_noteworthy == "platform_start" )
                {
                    platform_start = get_start_point_in_path( platform_targets[ i ] );
                }
            }
        }
    }
    
    if ( !isdefined( platform_start ) )
    {
        assertmsg( "<dev string:xa1>" + platform.origin );
    }
    
    if ( isdefined( elevator_doors ) && elevator_doors.size > 0 )
    {
        array::thread_all( elevator_doors, &setup_elevator_doors, platform_name, platform );
    }
    
    if ( isdefined( klaxon_speakers ) && klaxon_speakers.size > 0 )
    {
        array::thread_all( klaxon_speakers, &elevator_looping_sounds, "elevator_" + platform_name + "_move", "stop_" + platform_name + "_movement_sound" );
    }
    
    if ( isdefined( audio_points ) && audio_points.size > 0 )
    {
        array::thread_all( audio_points, &elevator_looping_sounds, "start_" + platform_name + "_klaxon", "stop_" + platform_name + "_klaxon" );
    }
    
    array::thread_all( platform_triggers, &trigger_think, platform_name );
    platform.loop_snd_ent = spawn( "script_origin", self.origin );
    platform.loop_snd_ent linkto( self );
    platform thread move_platform( platform_start, platform_name, n_start_delay );
}

// Namespace elevator
// Params 1
// Checksum 0x90796d1c, Offset: 0xc50
// Size: 0x134
function get_start_point_in_path( s_start_point )
{
    s_platform_start = s_start_point;
    
    if ( isdefined( s_platform_start.script_objective ) )
    {
        world flag::wait_till( "skipto_player_connected" );
        waittillframeend();
        
        if ( level flag::get( s_platform_start.script_objective + "_completed" ) )
        {
            while ( true )
            {
                if ( isdefined( s_platform_start.target ) )
                {
                    s_platform_start = struct::get( s_platform_start.target, "targetname" );
                }
                else
                {
                    break;
                }
                
                if ( isdefined( s_platform_start.script_objective ) )
                {
                    if ( s_platform_start.script_objective == level.current_skipto )
                    {
                        break;
                    }
                }
            }
        }
    }
    
    if ( isdefined( s_platform_start.script_wait ) )
    {
        n_start_delay = s_platform_start.script_wait;
    }
    
    return s_platform_start;
}

// Namespace elevator
// Params 1
// Checksum 0x1bfc28c, Offset: 0xd90
// Size: 0x150
function trigger_think( platform_name )
{
    self endon( #"death" );
    level endon( platform_name + "_disabled" );
    
    if ( isdefined( level.heroes ) && isdefined( self.script_string ) && self.script_string == "all_heroes" )
    {
        self thread wait_for_all_heroes( platform_name );
    }
    
    while ( true )
    {
        self trigger::wait_till();
        level notify( "start_" + platform_name + "_klaxon" );
        level notify( "close_" + platform_name + "_doors" );
        
        if ( isdefined( self.script_wait ) )
        {
            wait self.script_wait;
        }
        else
        {
            wait 2;
        }
        
        level notify( "elevator_" + platform_name + "_move" );
        level waittill( "elevator_" + platform_name + "_stop" );
        level notify( "stop_" + platform_name + "_klaxon" );
        level notify( "open_" + platform_name + "_doors" );
    }
}

// Namespace elevator
// Params 1
// Checksum 0x16b19c8f, Offset: 0xee8
// Size: 0x138
function wait_for_all_heroes( platform_name )
{
    level endon( "elevator_" + platform_name + "_move" );
    level endon( platform_name + "_disabled" );
    heroes_present = 0;
    wait 1;
    
    while ( true )
    {
        heroes_present = 1;
        
        foreach ( hero in level.heroes )
        {
            heroes_present &= hero istouching( self );
        }
        
        if ( heroes_present )
        {
            self triggerenable( 1 );
        }
        else
        {
            self triggerenable( 0 );
        }
        
        wait 0.2;
    }
}

// Namespace elevator
// Params 2
// Checksum 0xe5dd8ec5, Offset: 0x1028
// Size: 0x5c
function elevator_looping_sounds( notify_play, notify_stop )
{
    level waittill( notify_play );
    
    if ( isdefined( self.script_sound ) )
    {
        self thread sound::loop_in_space( level.scr_sound[ self.script_sound ], self.origin, notify_stop );
    }
}

// Namespace elevator
// Params 2
// Checksum 0x3a0bcd7b, Offset: 0x1090
// Size: 0x2d4
function setup_elevator_doors( platform_name, platform )
{
    open_struct = struct::get( self.target, "targetname" );
    
    if ( !isdefined( open_struct ) )
    {
        assertmsg( "<dev string:xfc>" + self.origin );
    }
    
    if ( isdefined( open_struct.target ) )
    {
        closed_struct = struct::get( open_struct.target, "targetname" );
    }
    
    if ( !isdefined( closed_struct ) )
    {
        assertmsg( "<dev string:x13e>" + self.origin );
    }
    
    if ( isdefined( open_struct.script_float ) )
    {
        n_opening_time = open_struct.script_float;
    }
    else
    {
        n_opening_time = 1;
    }
    
    if ( isdefined( closed_struct.script_float ) )
    {
        n_closing_time = closed_struct.script_float;
    }
    else
    {
        n_closing_time = 1;
    }
    
    stay_closed = 0;
    
    if ( isdefined( closed_struct.script_noteworthy ) && closed_struct.script_noteworthy == "stay_closed" )
    {
        stay_closed = 1;
    }
    
    self.origin = open_struct.origin;
    self.angles = open_struct.angles;
    v_move_to_close = closed_struct.origin - self.origin;
    v_angles_to_close = closed_struct.angles - self.angles;
    v_move_to_open = self.origin - closed_struct.origin;
    v_angles_to_open = self.angles - closed_struct.angles;
    self thread move_elevator_doors( platform_name, "close_", platform, v_move_to_close, v_angles_to_close, n_closing_time );
    
    if ( !stay_closed )
    {
        self thread move_elevator_doors( platform_name, "open_", platform, v_move_to_open, v_angles_to_open, n_opening_time );
    }
}

// Namespace elevator
// Params 6
// Checksum 0xfce5b524, Offset: 0x1370
// Size: 0x108
function move_elevator_doors( platform_name, direction, platform, v_moveto, v_angles, n_time )
{
    level endon( platform_name + "_disabled" );
    self linkto( platform );
    
    while ( true )
    {
        level waittill( direction + platform_name + "_doors" );
        self unlink();
        self moveto( self.origin + v_moveto, n_time );
        self rotateto( self.angles + v_angles, n_time );
        wait n_time;
        self linkto( platform );
    }
}

// Namespace elevator
// Params 3
// Checksum 0xba4ce7d2, Offset: 0x1480
// Size: 0x504
function move_platform( platform_start, platform_name, n_start_delay )
{
    level endon( platform_name + "_disabled" );
    move_path = [];
    var_95fa47b1 = 0;
    
    if ( isdefined( platform_start.script_objective ) )
    {
        self.origin = platform_start.origin;
        self.angles = platform_start.angles;
    }
    
    self.platform_name = platform_name;
    
    if ( !isdefined( move_path ) )
    {
        move_path = [];
    }
    else if ( !isarray( move_path ) )
    {
        move_path = array( move_path );
    }
    
    move_path[ move_path.size ] = platform_start;
    
    if ( isdefined( platform_start.target ) )
    {
        platform_start_first_target = struct::get( platform_start.target, "targetname" );
    }
    
    if ( !isdefined( platform_start_first_target ) )
    {
        return;
    }
    
    path = 1;
    pstruct = platform_start;
    
    while ( path )
    {
        if ( isdefined( pstruct.target ) )
        {
            pstruct = struct::get( pstruct.target, "targetname" );
            
            if ( isdefined( pstruct ) && move_path[ 0 ] != pstruct )
            {
                if ( !isdefined( move_path ) )
                {
                    move_path = [];
                }
                else if ( !isarray( move_path ) )
                {
                    move_path = array( move_path );
                }
                
                move_path[ move_path.size ] = pstruct;
            }
            else
            {
                var_95fa47b1 = 1;
                path = 0;
            }
            
            continue;
        }
        
        path = 0;
    }
    
    while ( true )
    {
        level waittill( "elevator_" + platform_name + "_move" );
        wait n_start_delay;
        
        if ( isdefined( level.scr_sound ) && isdefined( level.scr_sound[ "elevator_start" ] ) )
        {
            self playsound( level.scr_sound[ "elevator_start" ] );
        }
        
        self playsound( "veh_" + platform_name + "_start" );
        self.loop_snd_ent playloopsound( "veh_" + platform_name + "_loop", 0.5 );
        speed = -1;
        
        do
        {
            for ( i = 0; i < move_path.size ; i++ )
            {
                org = move_path[ i ];
                
                if ( !isdefined( org ) )
                {
                    continue;
                }
                
                if ( self.origin != org.origin )
                {
                    speed = get_speed( org, speed );
                    time = distance( self.origin, org.origin ) / speed;
                    time = time <= 0 ? 1 : time;
                    self moveto( org.origin, time, time / 2, time / 2 );
                    self rotateto( org.angles, time, time * 0.5, time * 0.5 );
                    self waittill( #"movedone" );
                }
                
                process_node( org, platform_name );
            }
        }
        while ( isdefined( var_95fa47b1 ) && var_95fa47b1 );
        
        stop();
        move_path = array::reverse( move_path );
        self.at_start = !self.at_start;
    }
}

// Namespace elevator
// Params 0
// Checksum 0x4c5020c7, Offset: 0x1990
// Size: 0x12c
function stop()
{
    level notify( "elevator_" + self.platform_name + "_stop" );
    level notify( "stop_" + self.platform_name + "_movement_sound" );
    self.origin = self.origin;
    self.angles = self.angles;
    
    if ( isdefined( self.script_sound ) )
    {
        self playsound( level.scr_sound[ self.script_sound ] );
    }
    
    self.loop_snd_ent stoploopsound( 0.5 );
    self playsound( "veh_" + self.platform_name + "_stop" );
    
    if ( isdefined( level.scr_sound ) && isdefined( level.scr_sound[ "elevator_end" ] ) )
    {
        self playsound( level.scr_sound[ "elevator_end" ] );
    }
}

// Namespace elevator
// Params 2
// Checksum 0x6c21270a, Offset: 0x1ac8
// Size: 0x124
function process_node( node, platform_name )
{
    if ( isdefined( node.script_notify ) )
    {
        level notify( node.script_notify );
        self notify( node.script_notify );
    }
    
    if ( isdefined( node.script_waittill ) )
    {
        level util::waittill_any_ents_two( level, node.script_waittill, self, node.script_waittill );
    }
    
    if ( isdefined( node.script_wait ) )
    {
        self playsound( "veh_" + platform_name + "_dc" );
        wait node.script_wait;
        level notify( "elevator_" + self.platform_name + "_script_wait_done" );
        self notify( "elevator_" + self.platform_name + "_script_wait_done" );
    }
}

// Namespace elevator
// Params 2
// Checksum 0xf0f10bbc, Offset: 0x1bf8
// Size: 0x54
function get_speed( path_point, speed )
{
    if ( speed <= 0 )
    {
        speed = 100;
    }
    
    if ( isdefined( path_point.speed ) )
    {
        speed = path_point.speed;
    }
    
    return speed;
}

