#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/doors_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace sgen_util;

// Namespace sgen_util
// Params 0
// Checksum 0xf656144a, Offset: 0x3e0
// Size: 0xb4
function trig_mover()
{
    self endon( #"death" );
    assert( isdefined( self.target ), "<dev string:x28>" + self.origin + "<dev string:x3d>" );
    a_mdl_movers = getentarray( self.target, "targetname" );
    self waittill( #"trigger" );
    self util::script_wait();
    array::thread_all( a_mdl_movers, &start_mover );
}

// Namespace sgen_util
// Params 0
// Checksum 0x1cb32df2, Offset: 0x4a0
// Size: 0x216
function start_mover()
{
    self util::script_wait();
    time = 0.5;
    
    if ( isdefined( self.script_float ) )
    {
        time = self.script_float;
    }
    
    if ( !isdefined( self.script_string ) )
    {
        self.script_string = "move";
    }
    
    switch ( self.script_string )
    {
        case "rotate":
            if ( isdefined( self.script_angles ) )
            {
                self rotateto( self.script_angles, time, 0, 0 );
            }
            else if ( isdefined( self.script_int ) )
            {
                self rotateyaw( self.script_int, time, 0, 0 );
            }
            
            break;
        case "move":
        default:
            self setmovingplatformenabled( 1 );
            
            if ( isdefined( self.script_vector ) )
            {
                vector = self.script_vector;
                
                if ( time >= 0.5 )
                {
                    self moveto( self.origin + self.script_vector, time, time * 0.25, time * 0.25 );
                }
                else
                {
                    self moveto( self.origin + self.script_vector, time );
                }
            }
            else if ( isdefined( self.script_int ) )
            {
                self movez( self.script_int, time, 0, 0 );
            }
            
            wait time;
            self setmovingplatformenabled( 0 );
            break;
    }
}

// Namespace sgen_util
// Params 1
// Checksum 0xcd27b823, Offset: 0x6c0
// Size: 0x174
function fake_head_track_player( n_range )
{
    if ( !isdefined( n_range ) )
    {
        n_range = 256;
    }
    
    self endon( #"death" );
    self endon( #"stop_head_track_player" );
    v_home_angles = self.angles;
    v_base_offset = ( 270, 90, 180 );
    
    while ( isdefined( self ) )
    {
        e_player = arraygetclosest( self.origin, level.players, n_range );
        
        if ( !isdefined( e_player ) )
        {
            if ( self.angles != v_home_angles )
            {
                self rotateto( v_home_angles, 1 );
            }
            
            wait 1;
            continue;
        }
        
        v_to_player = vectortoangles( e_player.origin - self.origin );
        v_face_angles = ( 0, v_to_player[ 1 ], 0 ) + v_base_offset;
        self rotateto( v_face_angles, 0.5 );
        self waittill( #"rotatedone" );
    }
}

// Namespace sgen_util
// Params 1
// Checksum 0xe7f08be1, Offset: 0x840
// Size: 0x100
function head_track_closest_player( n_range )
{
    if ( !isdefined( n_range ) )
    {
        n_range = 512;
    }
    
    self endon( #"death" );
    self endon( #"stop_head_track_player" );
    
    while ( true )
    {
        e_player = arraygetclosest( self.origin, level.players, n_range );
        
        if ( !isdefined( e_player ) )
        {
            if ( isdefined( self.e_look_at ) )
            {
                self.e_look_at = undefined;
                self lookatentity();
            }
        }
        else if ( !isdefined( self.e_look_at ) || self.e_look_at != e_player )
        {
            self.e_look_at = e_player;
            self lookatentity( self.e_look_at );
        }
        
        wait 1;
    }
}

// Namespace sgen_util
// Params 4
// Checksum 0x998581ec, Offset: 0x948
// Size: 0x78
function do_in_order( func1, param1, func2, param2 )
{
    if ( isdefined( param1 ) )
    {
        [[ func1 ]]( param1 );
    }
    else
    {
        [[ func1 ]]();
    }
    
    if ( isdefined( param2 ) )
    {
        [[ func2 ]]( param2 );
        return;
    }
    
    [[ func2 ]]();
}

// Namespace sgen_util
// Params 0
// Checksum 0xc677d0ca, Offset: 0x9c8
// Size: 0xe4
function delete_corpse()
{
    self notify( #"deleting_corpse" );
    self endon( #"deleting_corpse" );
    
    while ( true )
    {
        a_bodies = getcorpsearray();
        
        foreach ( corpse in a_bodies )
        {
            if ( isdefined( corpse ) )
            {
                corpse delete();
            }
        }
        
        wait 10;
    }
}

// Namespace sgen_util
// Params 2
// Checksum 0x28fdf9ce, Offset: 0xab8
// Size: 0x1cc
function gather_point_wait( should_delete, a_ai )
{
    if ( !isdefined( a_ai ) )
    {
        a_ai = [];
    }
    
    while ( true )
    {
        n_player_ready = 0;
        n_ai_ready = 0;
        
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                n_player_ready++;
            }
        }
        
        foreach ( ai in a_ai )
        {
            if ( ai istouching( self ) )
            {
                n_ai_ready++;
            }
        }
        
        if ( n_player_ready == level.players.size && n_ai_ready == a_ai.size )
        {
            if ( isdefined( should_delete ) && should_delete )
            {
                self util::self_delete();
            }
            
            break;
        }
        
        wait 0.1;
    }
}

/#

    // Namespace sgen_util
    // Params 4
    // Checksum 0xefe2795c, Offset: 0xc90
    // Size: 0x90, Type: dev
    function print3ddraw( org, text, color, str_notify )
    {
        if ( isdefined( str_notify ) )
        {
            self endon( str_notify );
        }
        
        while ( true )
        {
            if ( isdefined( self ) && isdefined( self.origin ) )
            {
                org = self.origin;
            }
            
            print3d( org, text, color );
            wait 0.05;
        }
    }

#/

// Namespace sgen_util
// Params 1
// Checksum 0x1f255dc5, Offset: 0xd28
// Size: 0x164
function robot_init_mind_control( n_level )
{
    switch ( n_level )
    {
        case 1:
            self ai::set_behavior_attribute( "rogue_control", "forced_level_1" );
            break;
        case 2:
            self ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
            break;
        case 3:
            self ai::set_behavior_attribute( "rogue_control", "forced_level_3" );
            break;
    }
    
    n_rand = randomint( 5 );
    
    if ( n_rand == 0 )
    {
        self ai::set_behavior_attribute( "rogue_control_speed", "walk" );
        return;
    }
    
    if ( n_rand == 1 )
    {
        self ai::set_behavior_attribute( "rogue_control_speed", "run" );
        return;
    }
    
    self ai::set_behavior_attribute( "rogue_control_speed", "sprint" );
}

// Namespace sgen_util
// Params 3
// Checksum 0x69546822, Offset: 0xe98
// Size: 0xac
function hendricks_play_idle( str_scene_struct, str_end_flag, b_pause_at_end )
{
    if ( !isdefined( b_pause_at_end ) )
    {
        b_pause_at_end = 1;
    }
    
    s_scene = struct::get( str_scene_struct );
    s_scene thread scene::play( level.ai_hendricks );
    level.ai_hendricks waittill( #"goal" );
    level flag::wait_till( str_end_flag );
    s_scene scene::stop();
}

// Namespace sgen_util
// Params 2
// Checksum 0x1ee48aa4, Offset: 0xf50
// Size: 0x13a
function set_door_state( str_name, str_state )
{
    a_s_doors = struct::get_array( str_name, "targetname" );
    
    if ( isdefined( a_s_doors ) && a_s_doors.size > 0 )
    {
        foreach ( s_door in a_s_doors )
        {
            if ( str_state === "open" )
            {
                [[ s_door.c_door ]]->unlock();
                [[ s_door.c_door ]]->open();
                continue;
            }
            
            [[ s_door.c_door ]]->close();
            [[ s_door.c_door ]]->lock();
        }
    }
}

// Namespace sgen_util
// Params 2
// Checksum 0xdf332340, Offset: 0x1098
// Size: 0xe4
function door_move( v_units, n_time )
{
    self playsound( "evt_door_close_start" );
    self playloopsound( "evt_door_close_loop", 0.5 );
    self moveto( self.origin + v_units, n_time, n_time * 0.1, n_time * 0.25 );
    self waittill( #"movedone" );
    self playsound( "evt_door_close_stop" );
    self stoploopsound( 0.4 );
}

// Namespace sgen_util
// Params 0
// Checksum 0xcee734e1, Offset: 0x1188
// Size: 0x54
function stumble_trigger_think()
{
    level endon( #"skip_stumble_trigger_think" );
    self waittill( #"trigger", e_player );
    level quake( 0.2, 2, self.origin, 5000 );
}

// Namespace sgen_util
// Params 7
// Checksum 0x934c2773, Offset: 0x11e8
// Size: 0x34c
function quake( n_mag, n_duration, v_org, n_range, n_shock_min, n_shock_max, str_rumble )
{
    if ( !isdefined( n_range ) )
    {
        n_range = 5000;
    }
    
    if ( !isdefined( n_shock_min ) )
    {
        n_shock_min = 1;
    }
    
    if ( !isdefined( n_shock_max ) )
    {
        n_shock_max = n_shock_min + 2;
    }
    
    if ( !isdefined( str_rumble ) )
    {
        str_rumble = "cp_sgen_flood_earthquake_rumble";
    }
    
    e_player = array::random( level.players );
    v_pos = math::random_vector( 1700 );
    playrumbleonposition( str_rumble, e_player.origin + v_pos );
    earthquake( n_mag, n_duration, v_org, n_range );
    
    if ( n_mag >= 3 )
    {
        foreach ( player in level.players )
        {
            player notify( #"new_quake" );
            visionset_mgr::activate( "overlay", "earthquake_blur", player, 0.25 );
            player util::delay( n_duration + 3, "new_quake", &visionset_mgr::deactivate, "overlay", "earthquake_blur", player );
            player shellshock( "tankblast_mp", randomfloatrange( n_shock_min, n_shock_max ) );
        }
    }
    
    v_angles = ( randomint( 360 ), randomint( 360 ), randomint( 360 ) );
    v_forward = anglestoforward( v_angles );
    n_range = randomfloatrange( 500, 1000 );
    v_location = e_player.origin + v_forward * n_range;
    playsoundatposition( "evt_base_explo_deep", v_location );
}

// Namespace sgen_util
// Params 0
// Checksum 0xd19fe14c, Offset: 0x1540
// Size: 0xae
function get_players_center()
{
    v_origin = ( 0, 0, 0 );
    
    foreach ( player in level.players )
    {
        v_origin += player.origin;
    }
    
    return v_origin / level.players.size;
}

// Namespace sgen_util
// Params 0
// Checksum 0xd2f2fe2f, Offset: 0x15f8
// Size: 0x6c
function robot_underwater_callback()
{
    self.script_accuracy = 0.2;
    self.health = 100;
    self.skipdeath = 1;
    self asmsetanimationrate( 0.7 );
    self clientfield::set( "robot_bubbles", 1 );
}

// Namespace sgen_util
// Params 2
// Checksum 0x55593771, Offset: 0x1670
// Size: 0xda
function rename_coop_spawn_points( str_name, str_new_name )
{
    a_s_spawnpoints = struct::get_array( "cp_coop_spawn", "targetname" );
    
    foreach ( s_spawnpoint in a_s_spawnpoints )
    {
        if ( s_spawnpoint.script_objective === str_name )
        {
            s_spawnpoint.script_objective = str_new_name;
        }
    }
}

// Namespace sgen_util
// Params 0
// Checksum 0x5521eadb, Offset: 0x1758
// Size: 0x68
function teleport_to_underwater()
{
    if ( isai( self ) )
    {
        self forceteleport( self.origin + level.v_underwater_offset, self.angles );
        return;
    }
    
    self.origin += level.v_underwater_offset;
}

// Namespace sgen_util
// Params 1
// Checksum 0x9827c40c, Offset: 0x17c8
// Size: 0x3c
function scene_stop_if_active( str_scene )
{
    if ( scene::is_active( str_scene ) )
    {
        scene::stop( str_scene );
    }
}

// Namespace sgen_util
// Params 5
// Checksum 0x4bbda627, Offset: 0x1810
// Size: 0x124
function player_stick( b_look, n_clamp_right, n_clamp_left, n_clamp_top, n_clamp_bottom )
{
    if ( !isdefined( b_look ) )
    {
        b_look = 0;
    }
    
    self.m_link = spawn( "script_model", self.origin );
    self.m_link.angles = self.angles;
    self.m_link setmodel( "tag_origin" );
    self allowsprint( 0 );
    
    if ( b_look )
    {
        self playerlinktodelta( self.m_link, "tag_origin", 1, n_clamp_right, n_clamp_left, n_clamp_top, n_clamp_bottom, 1 );
        return;
    }
    
    self playerlinktoabsolute( self.m_link, "tag_origin" );
}

// Namespace sgen_util
// Params 0
// Checksum 0xd1e9fc39, Offset: 0x1940
// Size: 0x44
function player_unstick()
{
    if ( isdefined( self.m_link ) )
    {
        self.m_link delete();
        self allowsprint( 1 );
    }
}

// Namespace sgen_util
// Params 1
// Checksum 0x6f5cc564, Offset: 0x1990
// Size: 0x4c
function round_up_to_ten( n_value )
{
    n_new_value = n_value - n_value % 10;
    
    if ( n_new_value < n_value )
    {
        n_new_value += 10;
    }
    
    return n_new_value;
}

// Namespace sgen_util
// Params 4
// Checksum 0xfb4b8f22, Offset: 0x19e8
// Size: 0xde
function add_notetrack_custom_function( str_anim, str_notetrack, func_callback, is_loop )
{
    if ( self != level )
    {
        self endon( #"death" );
    }
    
    level flagsys::wait_till( str_anim + "_playing" );
    
    do
    {
        str_notify = self util::waittill_any_return( str_notetrack, str_anim + "_playing" );
        
        if ( str_notify == str_notetrack )
        {
            self thread [[ func_callback ]]();
        }
    }
    while ( isdefined( is_loop ) && is_loop && level flagsys::get( str_anim + "_playing" ) );
}

// Namespace sgen_util
// Params 0
// Checksum 0x447689a9, Offset: 0x1ad0
// Size: 0x3c
function fade_in()
{
    array::thread_all( level.players, &util::screen_fade_to_alpha, 0, 0.5 );
}

// Namespace sgen_util
// Params 0
// Checksum 0x438b8ffd, Offset: 0x1b18
// Size: 0x3c
function fade_out()
{
    array::thread_all( level.players, &util::screen_fade_to_alpha, 1, 0.5 );
}

// Namespace sgen_util
// Params 2
// Checksum 0x8327aa49, Offset: 0x1b60
// Size: 0x3c
function wait_for_scene_done( str_scene, str_teleport_name )
{
    level waittill( str_scene + "_done" );
    util::teleport_players_igc( str_teleport_name );
}

// Namespace sgen_util
// Params 2
// Checksum 0xc46e378c, Offset: 0x1ba8
// Size: 0xb0
function get_num_scaled_by_player_count( n_base, n_add_per_player )
{
    n_num = n_base - n_add_per_player;
    
    foreach ( e_player in level.players )
    {
        n_num += n_add_per_player;
    }
    
    return n_num;
}

// Namespace sgen_util
// Params 0
// Checksum 0x876cec4f, Offset: 0x1c60
// Size: 0x2c
function hotjoin_disable()
{
    level.gametypespawnwaiter_old = level.gametypespawnwaiter;
    level.gametypespawnwaiter = &wait_to_spawn;
}

// Namespace sgen_util
// Params 0
// Checksum 0x10a275e, Offset: 0x1c98
// Size: 0x42
function hotjoin_enable()
{
    assert( isdefined( level.gametypespawnwaiter_old ) );
    level.gametypespawnwaiter = level.gametypespawnwaiter_old;
    level notify( #"hotjoin_enabled" );
}

// Namespace sgen_util
// Params 0
// Checksum 0x2aede328, Offset: 0x1ce8
// Size: 0x30, Type: bool
function wait_to_spawn()
{
    level util::waittill_either( "objective_changed", "hotjoin_enabled" );
    return true;
}

// Namespace sgen_util
// Params 0
// Checksum 0xe1cdecc7, Offset: 0x1d20
// Size: 0xba
function igc_end()
{
    foreach ( e_player in level.players )
    {
        e_player freezecontrols( 0 );
        e_player util::show_hud( 1 );
        e_player enableweapons();
    }
}

// Namespace sgen_util
// Params 0
// Checksum 0x789d6943, Offset: 0x1de8
// Size: 0xda
function refill_ammo()
{
    a_w_weapons = self getweaponslist();
    
    foreach ( w_weapon in a_w_weapons )
    {
        self givemaxammo( w_weapon );
        self setweaponammoclip( w_weapon, w_weapon.clipsize );
    }
}

// Namespace sgen_util
// Params 2
// Checksum 0xaf54d07, Offset: 0x1ed0
// Size: 0x214
function wait_to_delete( n_dist, n_delay )
{
    self endon( #"death" );
    b_can_delete = 0;
    
    if ( self flagsys::get( "scriptedanim" ) )
    {
        self flagsys::wait_till_clear( "scriptedanim" );
    }
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    while ( !b_can_delete )
    {
        wait 1;
        
        foreach ( player in level.players )
        {
            if ( isvehicle( self ) )
            {
                b_can_see_player = self vehcansee( player );
            }
            else if ( isactor( self ) )
            {
                b_can_see_player = self cansee( player );
            }
            else
            {
                assertmsg( "<dev string:x5c>" );
                return;
            }
            
            if ( !b_can_see_player && distance( self.origin, player.origin ) > n_dist && player util::is_player_looking_at( self.origin, undefined, 0 ) == 0 )
            {
                b_can_delete = 1;
            }
        }
    }
    
    self delete();
}

