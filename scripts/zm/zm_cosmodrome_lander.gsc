#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/zm_cosmodrome_amb;
#using scripts/zm/zm_cosmodrome_eggs;

#namespace zm_cosmodrome_lander;

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xc3aaa2f3, Offset: 0xa38
// Size: 0x4fc
function init()
{
    level flag::init( "lander_power" );
    level flag::init( "lander_connected" );
    level flag::init( "lander_grounded" );
    level flag::init( "lander_takeoff" );
    level flag::init( "lander_landing" );
    level flag::init( "lander_cooldown" );
    level flag::init( "lander_inuse" );
    level.zone_connected = 0;
    level.lander_in_use = 0;
    level.lander_ridden = 0;
    lander = getent( "lander", "targetname" );
    lander.console = getent( "lander_console", "targetname" );
    lander.console linkto( lander );
    lander.door_north = getent( "zipline_door_n", "script_noteworthy" );
    lander.door_south = getent( "zipline_door_s", "script_noteworthy" );
    lander setforcenocull();
    lander.door_north setforcenocull();
    lander.door_south setforcenocull();
    lander.station = "lander_station5";
    lander.state = "idle";
    lander.called = 0;
    lander.anchor = spawn( "script_origin", lander.origin );
    lander.anchor.angles = lander.angles;
    lander linkto( lander.anchor );
    lander link_pieces( undefined, 1 );
    lander.door_north link_pieces( undefined, 1 );
    lander.door_south link_pieces( undefined, 1 );
    lander.zone = [];
    lander.zone[ "lander_station1" ] = "base_entry_zone";
    lander.zone[ "lander_station3" ] = "north_catwalk_zone3";
    lander.zone[ "lander_station4" ] = "storage_lander_zone";
    lander.zone[ "lander_station5" ] = "centrifuge_zone";
    lander.stations_waiting = 3;
    init_call_boxes();
    level thread lander_poi_init();
    level flag::wait_till( "start_zombie_round_logic" );
    callback::on_connect( &function_7a1aff0c );
    setup_initial_lander_states();
    level notify( #"lander_launched" );
    wait 0.1;
    level flag::wait_till( "power_on" );
    enable_callboxes();
    open_lander_gate();
    level thread lander_cooldown_think();
    level thread play_launch_unlock_vox();
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x21100c3d, Offset: 0xf40
// Size: 0x30
function function_7a1aff0c()
{
    if ( level flag::get( "lander_intro_done" ) )
    {
        self.lander = 0;
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xe3cff25e, Offset: 0xf78
// Size: 0x64
function setup_initial_lander_states()
{
    level clientfield::set( "COSMO_LANDER_BASE_ENTRY_BAY", 1 );
    level clientfield::set( "COSMO_LANDER_CATWALK_BAY", 1 );
    level clientfield::set( "COSMO_LANDER_STORAGE_BAY", 1 );
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x106bd433, Offset: 0xfe8
// Size: 0xa6
function lander_poi_init()
{
    lander_poi = getentarray( "lander_poi", "targetname" );
    
    for ( i = 0; i < lander_poi.size ; i++ )
    {
        lander_poi[ i ] zm_utility::create_zombie_point_of_interest( undefined, 30, 0, 0 );
        lander_poi[ i ] thread zm_utility::create_zombie_point_of_interest_attractor_positions( 4, 45 );
    }
}

// Namespace zm_cosmodrome_lander
// Params 1
// Checksum 0xb0380fd, Offset: 0x1098
// Size: 0x104
function activate_lander_poi( station )
{
    if ( !isdefined( station ) )
    {
        return;
    }
    
    current_poi = undefined;
    lander_poi = getentarray( "lander_poi", "targetname" );
    
    for ( i = 0; i < lander_poi.size ; i++ )
    {
        if ( lander_poi[ i ].script_string == station )
        {
            current_poi = lander_poi[ i ];
        }
    }
    
    current_poi zm_utility::activate_zombie_point_of_interest();
    level flag::wait_till( "lander_grounded" );
    current_poi zm_utility::deactivate_zombie_point_of_interest();
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xbb854883, Offset: 0x11a8
// Size: 0x24
function init_lander_screen()
{
    self setmodel( "p_zom_lunar_control_scrn_on" );
}

// Namespace zm_cosmodrome_lander
// Params 2
// Checksum 0xaefad0b3, Offset: 0x11d8
// Size: 0x136
function link_pieces( piece, no_cull )
{
    pieces = getentarray( self.target, "targetname" );
    
    for ( i = 0; i < pieces.size ; i++ )
    {
        if ( isdefined( pieces[ i ].script_noteworthy ) && pieces[ i ].script_noteworthy == "zip_buy" )
        {
            pieces[ i ] enablelinkto();
        }
        
        if ( isdefined( piece ) )
        {
            pieces[ i ] linkto( piece );
        }
        else
        {
            pieces[ i ] linkto( self );
        }
        
        if ( isdefined( no_cull ) && no_cull )
        {
            pieces[ i ] setforcenocull();
        }
    }
}

// Namespace zm_cosmodrome_lander
// Params 1
// Checksum 0xaa458abc, Offset: 0x1318
// Size: 0xac
function close_lander_door( time )
{
    open_pos = struct::get( self.target, "targetname" );
    start_pos = struct::get( open_pos.target, "targetname" );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "shaft_cap" )
    {
        return;
    }
    
    level flag::wait_till( "lander_grounded" );
}

// Namespace zm_cosmodrome_lander
// Params 1
// Checksum 0x818a7461, Offset: 0x13d0
// Size: 0x68
function open_lander_door( time )
{
    open_pos = struct::get( self.target, "targetname" );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "shaft_cap" )
    {
        level waittill( #"lander_launched" );
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xe667acb7, Offset: 0x1440
// Size: 0xdc
function open_lander_gate()
{
    lander = getent( "lander", "targetname" );
    north_pos = getent( "zipline_door_n_pos", "script_noteworthy" );
    south_pos = getent( "zipline_door_s_pos", "script_noteworthy" );
    lander.door_north thread move_gate( north_pos, 1 );
    lander.door_south thread move_gate( south_pos, 1 );
}

// Namespace zm_cosmodrome_lander
// Params 1
// Checksum 0xd4f7c597, Offset: 0x1528
// Size: 0x11c
function close_lander_gate( time )
{
    lander = getent( "lander", "targetname" );
    north_pos = getent( "zipline_door_n_pos", "script_noteworthy" );
    south_pos = getent( "zipline_door_s_pos", "script_noteworthy" );
    center_pos = getent( "zipline_center", "script_noteworthy" );
    lander.door_north thread move_gate( north_pos, 0, time );
    lander.door_south thread move_gate( south_pos, 0, time );
}

// Namespace zm_cosmodrome_lander
// Params 3
// Checksum 0xd77989ed, Offset: 0x1650
// Size: 0x23c
function move_gate( pos, lower, time )
{
    if ( !isdefined( time ) )
    {
        time = 1;
    }
    
    lander = getent( "lander", "targetname" );
    self unlink();
    
    if ( lower )
    {
        self notsolid();
        
        if ( self.classname == "script_brushmodel" )
        {
            self moveto( pos.origin + ( 0, 0, -132 ), time );
        }
        else
        {
            self playsound( "zmb_lander_gate" );
            self moveto( pos.origin + ( 0, 0, -44 ), time );
        }
        
        self waittill( #"movedone" );
        
        if ( self.classname == "script_brushmodel" )
        {
            self notsolid();
        }
    }
    else
    {
        if ( self.classname == "script_brushmodel" )
        {
        }
        else
        {
            self playsound( "zmb_lander_gate" );
        }
        
        self notsolid();
        self moveto( pos.origin, time );
        self waittill( #"movedone" );
        
        if ( self.classname == "script_brushmodel" )
        {
            self solid();
        }
    }
    
    self linkto( lander.anchor );
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x5a0dd003, Offset: 0x1898
// Size: 0x44
function init_buy()
{
    trigger = getent( "zip_buy", "script_noteworthy" );
    trigger thread lander_buy_think();
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xb6d8348, Offset: 0x18e8
// Size: 0xa6
function init_call_boxes()
{
    level flag::wait_till( "zones_initialized" );
    trigger = getentarray( "zip_call_box", "targetname" );
    
    for ( i = 0; i < trigger.size ; i++ )
    {
        trigger[ i ] thread call_box_think();
        self.destination = "lander_station5";
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x4e4a52c, Offset: 0x1998
// Size: 0x338
function call_box_think()
{
    level endon( #"fake_death" );
    lander = getent( "lander", "targetname" );
    self sethintstring( &"ZOMBIE_NEED_POWER" );
    self setcursorhint( "HINT_NOICON" );
    level flag::wait_till( "power_on" );
    self.activated_station = 0;
    
    if ( lander.station != self.script_noteworthy )
    {
        self sethintstring( &"ZM_COSMODROME_LANDER_CALL" );
    }
    else
    {
        self sethintstring( &"ZM_COSMODROME_LANDER_AT_STATION" );
        self setcursorhint( "HINT_NOICON" );
    }
    
    while ( true )
    {
        who = undefined;
        self waittill( #"trigger", who );
        
        if ( who laststand::player_is_in_laststand() )
        {
            continue;
        }
        
        if ( level flag::get( "lander_cooldown" ) || level flag::get( "lander_inuse" ) )
        {
            continue;
        }
        
        if ( !self.activated_station )
        {
            self.activated_station = 1;
        }
        
        if ( lander.station != self.script_noteworthy )
        {
            call_destination = self.script_noteworthy;
            lander.called = 1;
            level.lander_in_use = 1;
            self playsound( "zmb_push_button" );
            self playsound( "vox_ann_lander_current_0" );
            
            switch ( call_destination )
            {
                default:
                    level clientfield::set( "COSMO_LANDER_DEST", 4 );
                    break;
                case "lander_station1":
                    level clientfield::set( "COSMO_LANDER_DEST", 3 );
                    break;
                case "lander_station3":
                    level clientfield::set( "COSMO_LANDER_DEST", 2 );
                    break;
                case "lander_station4":
                    level clientfield::set( "COSMO_LANDER_DEST", 1 );
                    break;
            }
            
            self thread lander_take_off( call_destination );
        }
        
        wait 0.05;
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xdb5bffd8, Offset: 0x1cd8
// Size: 0x77c
function lander_buy_think()
{
    level endon( #"fake_death" );
    self sethintstring( &"ZOMBIE_NEED_POWER" );
    level flag::wait_till( "power_on" );
    lander = getent( "lander", "targetname" );
    panel = getent( "rocket_launch_panel", "targetname" );
    self sethintstring( &"ZM_COSMODROME_LANDER_NO_CONNECTIONS" );
    level clientfield::set( "COSMO_LANDER_STATUS_LIGHTS", 1 );
    level clientfield::set( "COSMO_LANDER_STATION", 4 );
    
    while ( !lander.called )
    {
        wait 1;
    }
    
    level.zone_connected = 1;
    level flag::set( "lander_connected" );
    self sethintstring( &"ZM_COSMODROME_LANDER", 250 );
    node = getnode( "goto_centrifuge", "targetname" );
    
    while ( true )
    {
        who = undefined;
        self waittill( #"trigger", who );
        
        if ( level flag::get( "lander_cooldown" ) || level flag::get( "lander_inuse" ) )
        {
            zm_utility::play_sound_at_pos( "no_purchase", self.origin );
            continue;
        }
        
        if ( who laststand::player_is_in_laststand() )
        {
            zm_utility::play_sound_at_pos( "no_purchase", self.origin );
            continue;
        }
        
        rider_trigger = getent( lander.station + "_riders", "targetname" );
        touching = 0;
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( rider_trigger istouching( players[ i ] ) )
            {
                touching = 1;
            }
        }
        
        if ( !touching )
        {
            continue;
        }
        
        if ( zombie_utility::is_player_valid( who ) && who zm_score::can_player_purchase( level.lander_cost ) )
        {
            who zm_score::minus_to_player_score( level.lander_cost );
            zm_utility::play_sound_at_pos( "purchase", self.origin );
            self playsound( "zmb_push_button" );
            self playsound( "vox_ann_lander_current_0" );
            level.lander_in_use = 1;
            lander.called = 0;
            
            if ( lander.station != "lander_station5" )
            {
                lander thread function_bd6e70fe();
            }
            
            call_box = getent( lander.station, "script_noteworthy" );
            
            if ( lander.station == "lander_station5" )
            {
                dest = [];
                azkeys = getarraykeys( lander.zone );
                
                for ( i = 0; i < azkeys.size ; i++ )
                {
                    if ( azkeys[ i ] == lander.station )
                    {
                        continue;
                    }
                    
                    zone = level.zones[ lander.zone[ azkeys[ i ] ] ];
                    
                    if ( isdefined( zone ) && zone.is_enabled )
                    {
                        dest[ dest.size ] = azkeys[ i ];
                    }
                }
                
                dest = array::randomize( dest );
                call_box.destination = dest[ 0 ];
            }
            else
            {
                call_box.destination = "lander_station5";
            }
            
            lander.driver = who;
            
            if ( isplayer( who ) )
            {
            }
            
            lander playsound( "zmb_lander_start" );
            lander playloopsound( "zmb_lander_exhaust_loop", 1 );
            
            switch ( call_box.destination )
            {
                default:
                    level clientfield::set( "COSMO_LANDER_DEST", 4 );
                    break;
                case "lander_station1":
                    level clientfield::set( "COSMO_LANDER_DEST", 3 );
                    break;
                case "lander_station3":
                    level clientfield::set( "COSMO_LANDER_DEST", 2 );
                    break;
                case "lander_station4":
                    level clientfield::set( "COSMO_LANDER_DEST", 1 );
                    break;
            }
            
            self lander_take_off( call_box.destination );
        }
        else
        {
            zm_utility::play_sound_at_pos( "no_purchase", self.origin );
            who zm_audio::create_and_play_dialog( "general", "no_money", 0 );
            continue;
        }
        
        wait 0.05;
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x8c9f29c4, Offset: 0x2460
// Size: 0x11c
function function_bd6e70fe()
{
    str_flag_name = "";
    var_49df99ed = "";
    
    switch ( self.station )
    {
        case "lander_station1":
            str_flag_name = "lander_a_used";
            var_49df99ed = "COSMO_LAUNCH_PANEL_BASEENTRY_STATUS";
            break;
        case "lander_station3":
            str_flag_name = "lander_b_used";
            var_49df99ed = "COSMO_LAUNCH_PANEL_CATWALK_STATUS";
            break;
        default:
            str_flag_name = "lander_c_used";
            var_49df99ed = "COSMO_LAUNCH_PANEL_STORAGE_STATUS";
            break;
    }
    
    level notify( #"new_lander_used" );
    level flag::set( str_flag_name );
    wait 2;
    level flag::wait_till( "lander_grounded" );
    self clientfield::set( var_49df99ed, 1 );
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xe60414, Offset: 0x2588
// Size: 0x16e
function enable_callboxes()
{
    call_boxes = getentarray( "zip_call_box", "targetname" );
    lander = getent( "lander", "targetname" );
    
    for ( j = 0; j < call_boxes.size ; j++ )
    {
        if ( call_boxes[ j ].script_noteworthy != lander.station )
        {
            call_boxes[ j ] triggerenable( 1 );
            call_boxes[ j ] sethintstring( &"ZM_COSMODROME_LANDER_CALL" );
            continue;
        }
        
        call_boxes[ j ] triggerenable( 1 );
        call_boxes[ j ] sethintstring( "" );
        call_boxes[ j ] setcursorhint( "HINT_NOICON" );
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x4b25c1d0, Offset: 0x2700
// Size: 0x444
function new_lander_intro()
{
    level.intro_lander = 1;
    level thread lander_intro_think();
    lander = getent( "lander", "targetname" );
    north_pos = getent( "zipline_door_n_pos", "script_noteworthy" );
    south_pos = getent( "zipline_door_s_pos", "script_noteworthy" );
    lander.og_angles = lander.angles;
    north_pos.og_angles = north_pos.angles;
    south_pos.og_angles = south_pos.angles;
    thread close_lander_gate( 0.05 );
    level flag::wait_till( "initial_players_connected" );
    
    while ( !aretexturesloaded() )
    {
        wait 0.05;
    }
    
    wait 3.5;
    lander = getent( "lander", "targetname" );
    lander lock_players_intro();
    lander playloopsound( "zmb_lander_exhaust_loop" );
    lander.sound_ent = spawn( "script_origin", lander.origin );
    lander.sound_ent linkto( lander );
    lander.sound_ent playsound( "zmb_lander_launch" );
    lander.sound_ent playloopsound( "zmb_lander_flying_low_loop" );
    lander_struct = struct::get( "lander_station5", "targetname" );
    spot1 = lander_struct.origin;
    wait 1.5;
    level thread lander_engine_fx();
    lander.anchor moveto( spot1, 8, 0.1, 7.9 );
    level notify( #"lander_launched" );
    util::delay( 6, undefined, &flag::set, "lander_intro_done" );
    lander.anchor waittill( #"movedone" );
    level.intro_lander = 0;
    level flag::set( "lander_grounded" );
    level thread zm_cosmodrome_amb::play_cosmo_announcer_vox( "vox_ann_startup" );
    lander.sound_ent stoploopsound( 3 );
    lander stoploopsound( 3 );
    playsoundatposition( "zmb_lander_land", lander.sound_ent.origin );
    open_lander_gate();
    unlock_players();
    level thread force_wait_for_gersh_line();
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xe67263ca, Offset: 0x2b50
// Size: 0x84
function lander_intro_think()
{
    trigger = getent( "zip_buy", "script_noteworthy" );
    trigger setcursorhint( "HINT_NOICON" );
    level flag::wait_till( "lander_grounded" );
    wait 15;
    init_buy();
}

// Namespace zm_cosmodrome_lander
// Params 1
// Checksum 0x488991a6, Offset: 0x2be0
// Size: 0x754
function lander_take_off( dest )
{
    level flag::clear( "lander_grounded" );
    level flag::set( "lander_takeoff" );
    lander = getent( "lander", "targetname" );
    level clientfield::set( "COSMO_LANDER_STATUS_LIGHTS", 1 );
    lander thread lock_players( dest );
    level notify( #"lu", lander.riders, self );
    lander.depart_station = lander.station;
    depart = getent( lander.station, "script_noteworthy" );
    
    if ( depart.target == "catwalk_zip_door" )
    {
        level clientfield::set( "COSMO_LANDER_CATWALK_BAY", 3 );
    }
    else if ( depart.target == "base_entry_zip_door" )
    {
        level clientfield::set( "COSMO_LANDER_BASE_ENTRY_BAY", 3 );
    }
    else if ( depart.target == "centrifuge_zip_door" )
    {
        level clientfield::set( "COSMO_LANDER_CENTRIFUGE_BAY", 3 );
    }
    else if ( depart.target == "storage_zip_door" )
    {
        level clientfield::set( "COSMO_LANDER_STORAGE_BAY", 3 );
    }
    
    depart_door = getentarray( depart.target, "targetname" );
    
    for ( i = 0; i < depart_door.size ; i++ )
    {
        depart_door[ i ] thread open_lander_door();
    }
    
    close_lander_gate();
    station = struct::get( lander.station, "targetname" );
    hub = struct::get( station.target, "targetname" );
    level flag::clear( "spawn_zombies" );
    level thread lander_engine_fx();
    wait 1;
    
    if ( lander.called == 1 )
    {
        lander.station = self.script_noteworthy;
    }
    else
    {
        lander.station = dest;
    }
    
    arrive = getent( lander.station, "script_noteworthy" );
    
    if ( isdefined( arrive.target ) )
    {
        if ( arrive.target == "catwalk_zip_door" )
        {
            level clientfield::set( "COSMO_LANDER_CATWALK_BAY", 2 );
            depart thread function_5f5d494f();
        }
        else if ( arrive.target == "base_entry_zip_door" )
        {
            level clientfield::set( "COSMO_LANDER_BASE_ENTRY_BAY", 2 );
            depart thread function_5f5d494f();
        }
        else if ( arrive.target == "centrifuge_zip_door" )
        {
            level clientfield::set( "COSMO_LANDER_CENTRIFUGE_BAY", 2 );
            depart thread function_5f5d494f();
        }
        else if ( arrive.target == "storage_zip_door" )
        {
            level clientfield::set( "COSMO_LANDER_STORAGE_BAY", 2 );
            depart thread function_5f5d494f();
        }
    }
    
    lander.sound_ent playsound( "zmb_lander_launch" );
    lander.sound_ent playloopsound( "zmb_lander_flying_low_loop" );
    lander.anchor moveto( hub.origin, 3, 2, 1 );
    lander.anchor thread lander_takeoff_wobble();
    level notify( #"lander_launched" );
    level flag::clear( "lander_takeoff" );
    wait 3.1;
    lander clientfield::set( "COSMO_LANDER_MOVE_FX", 1 );
    lander.anchor lander_hover_idle();
    
    if ( isdefined( hub.target ) )
    {
        extra_dest = struct::get( hub.target, "targetname" );
        lander.anchor moveto( extra_dest.origin, 2 );
        lander.anchor waittill( #"movedone" );
    }
    
    call_box = getent( lander.station, "script_noteworthy" );
    call_box playsound( "vox_ann_lander_current_1" );
    lander clientfield::set( "COSMO_LANDER_MOVE_FX", 0 );
    lander_goto_dest();
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xc6a57975, Offset: 0x3340
// Size: 0x104
function function_5f5d494f()
{
    level flag::wait_till( "lander_inuse" );
    
    if ( self.target == "catwalk_zip_door" )
    {
        level clientfield::set( "COSMO_LANDER_CATWALK_BAY", 1 );
        return;
    }
    
    if ( self.target == "base_entry_zip_door" )
    {
        level clientfield::set( "COSMO_LANDER_BASE_ENTRY_BAY", 1 );
        return;
    }
    
    if ( self.target == "centrifuge_zip_door" )
    {
        level clientfield::set( "COSMO_LANDER_CENTRIFUGE_BAY", 1 );
        return;
    }
    
    if ( self.target == "storage_zip_door" )
    {
        level clientfield::set( "COSMO_LANDER_STORAGE_BAY", 1 );
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xfd8af888, Offset: 0x3450
// Size: 0x10c
function lander_hover_idle()
{
    num = self.angles[ 0 ] + randomintrange( -3, 3 );
    num1 = self.angles[ 1 ] + randomintrange( -3, 3 );
    self rotateto( ( num, num1, randomfloatrange( 0, 5 ) ), 0.5 );
    self moveto( ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 20 ), 0.5, 0.1 );
    wait 0.5;
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x72609dd6, Offset: 0x3568
// Size: 0x308
function player_blocking_lander()
{
    players = getplayers();
    lander = getent( "lander", "targetname" );
    rider_trigger = getent( lander.station + "_riders", "targetname" );
    crumb = struct::get( rider_trigger.target, "targetname" );
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( rider_trigger istouching( players[ i ] ) )
        {
            players[ i ] setorigin( crumb.origin + ( randomintrange( -20, 20 ), randomintrange( -20, 20 ), 0 ) );
            players[ i ] dodamage( players[ i ].health + 10000, players[ i ].origin );
        }
    }
    
    zombies = getaispeciesarray( "axis" );
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        if ( isdefined( zombies[ i ] ) )
        {
            if ( rider_trigger istouching( zombies[ i ] ) )
            {
                level.zombie_total++;
                playsoundatposition( "nuked", zombies[ i ].origin );
                playfx( level._effect[ "zomb_gib" ], zombies[ i ].origin );
                
                if ( isdefined( zombies[ i ].lander_death ) )
                {
                    zombies[ i ] [[ zombies[ i ].lander_death ]]();
                }
                
                zombies[ i ] delete();
            }
        }
    }
    
    wait 0.5;
}

// Namespace zm_cosmodrome_lander
// Params 1
// Checksum 0x41d67280, Offset: 0x3878
// Size: 0x620
function lock_players( destination )
{
    lander = getent( "lander", "targetname" );
    lander.riders = 0;
    spots = getentarray( "zipline_spots", "script_noteworthy" );
    taken = [];
    zipline_door1 = getent( "zipline_door_n", "script_noteworthy" );
    zipline_door2 = getent( "zipline_door_s", "script_noteworthy" );
    base = getent( "lander_base", "script_noteworthy" );
    ls_taken = [];
    rider_trigger = getent( lander.station + "_riders", "targetname" );
    crumb = struct::get( rider_trigger.target, "targetname" );
    lander thread takeoff_nuke( undefined, 80, 1, rider_trigger );
    lander thread takeoff_knockdown( 81, 250 );
    players = getplayers();
    lander_trig = getent( "zip_buy", "script_noteworthy" );
    x = 0;
    
    while ( !level flag::get( "lander_grounded" ) )
    {
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( !rider_trigger istouching( players[ i ] ) && !players[ i ] istouching( zipline_door1 ) && !players[ i ] istouching( zipline_door2 ) && !players[ i ] istouching( base ) && x < 8 )
            {
                continue;
            }
            
            if ( !players[ i ] istouching( lander_trig ) )
            {
                continue;
            }
            
            if ( isdefined( players[ i ].lander ) && players[ i ].lander )
            {
                continue;
            }
            
            max_dist = 10000;
            grab = -1;
            
            for ( j = 0; j < 4 ; j++ )
            {
                if ( isdefined( taken[ j ] ) && taken[ j ] == 1 )
                {
                    continue;
                }
                
                dist = distance2d( players[ i ].origin, spots[ j ].origin );
                
                if ( dist < max_dist )
                {
                    max_dist = dist;
                    grab = j;
                }
            }
            
            taken[ grab ] = 1;
            
            if ( players[ i ] laststand::player_is_in_laststand() )
            {
                players[ i ] thread function_e323fa97();
            }
            
            players[ i ] playerlinktodelta( spots[ grab ], undefined, 1, 180, 180, 180, 180, 1 );
            players[ i ] enableinvulnerability();
            players[ i ] thread zm::store_crumb( crumb.origin );
            players[ i ].lander = 1;
            players[ i ].lander_link_spot = spots[ grab ];
            players[ i ] clientfield::set( "COSMO_PLAYER_LANDER_FOG", 1 );
            lander.riders++;
        }
        
        wait 0.25;
        x++;
        
        if ( x == 4 )
        {
            if ( lander.riders == players.size )
            {
                level thread activate_lander_poi( destination );
            }
        }
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x238e2495, Offset: 0x3ea0
// Size: 0xe4
function function_e323fa97()
{
    self endon( #"bled_out" );
    self.on_lander_last_stand = 1;
    self allowcrouch( 0 );
    self allowstand( 0 );
    self.lander = 1;
    
    while ( self.lander === 1 && self laststand::player_is_in_laststand() )
    {
        wait 0.05;
    }
    
    self.on_lander_last_stand = undefined;
    self allowcrouch( 1 );
    self allowstand( 1 );
    self setstance( "stand" );
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xd7a73ab1, Offset: 0x3f90
// Size: 0x236
function lock_players_intro()
{
    lander = getent( "lander", "targetname" );
    lander.riders = 0;
    spots = getentarray( "zipline_spots", "script_noteworthy" );
    players = getplayers();
    taken = [];
    rider_trigger = getent( "lander_in_sky_riders", "targetname" );
    crumb = struct::get( rider_trigger.target, "targetname" );
    
    for ( i = 0; i < players.size ; i++ )
    {
        grab = -1;
        
        for ( j = 0; j < 4 ; j++ )
        {
            if ( isdefined( taken[ j ] ) && taken[ j ] == 1 )
            {
                continue;
            }
            
            grab = j;
        }
        
        taken[ grab ] = 1;
        players[ i ] playerlinkto( spots[ grab ], undefined, 0, 180, 180, 180, 180, 1 );
        players[ i ] enableinvulnerability();
        players[ i ].lander = 1;
        lander.riders++;
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x51c79b78, Offset: 0x41d0
// Size: 0x1d2
function unlock_players()
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] unlink();
        players[ i ] disableinvulnerability();
        players[ i ].on_lander_last_stand = undefined;
        
        /#
            if ( getdvarint( "<dev string:x28>" ) >= 1 && getdvarint( "<dev string:x28>" ) <= 3 )
            {
                players[ i ] enableinvulnerability();
            }
        #/
        
        players[ i ] thread zm::store_crumb( players[ i ].origin );
        players[ i ].lander = 0;
    }
    
    lander = getent( "lander", "targetname" );
    
    if ( isdefined( lander.driver ) && lander.driver zombie_utility::is_zombie() )
    {
        lander.driver unlink();
        lander.driver = undefined;
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x637c4718, Offset: 0x43b0
// Size: 0x9cc
function lander_goto_dest()
{
    level endon( #"intermission" );
    lander = getent( "lander", "targetname" );
    final_dest = struct::get( lander.station, "targetname" );
    arrive = getent( lander.station, "script_noteworthy" );
    
    if ( isdefined( final_dest.target ) )
    {
        current_dest = struct::get( final_dest.target, "targetname" );
        
        if ( isdefined( current_dest.target ) )
        {
            lander.anchor thread lander_flight_wobble( lander, final_dest );
            extra_dest = struct::get( current_dest.target, "targetname" );
            lander.anchor moveto( extra_dest.origin, 5, 1 );
            lander.anchor waittill( #"movedone" );
            lander_clean_up_corpses( lander.anchor.origin, 150 );
            lander.anchor moveto( current_dest.origin, 2, 0, 2 );
            lander.anchor waittill( #"movedone" );
        }
        else
        {
            lander.anchor thread lander_flight_wobble( lander, final_dest );
            lander.anchor moveto( current_dest.origin, 7, 1, 2.75 );
            lander.anchor waittill( #"movedone" );
        }
    }
    
    lander_clean_up_corpses( lander.anchor.origin, 150 );
    level flag::wait_till( "lander_landing" );
    movetime = 5;
    acceltime = 0.1;
    deceltime = 4.9;
    var_5021702 = "";
    
    if ( isdefined( arrive.target ) )
    {
        if ( arrive.target == "catwalk_zip_door" )
        {
            level clientfield::set( "COSMO_LANDER_CATWALK_BAY", 3 );
            var_5021702 = "lgt_exp_padup_catwalk";
        }
        else if ( arrive.target == "base_entry_zip_door" )
        {
            movetime = 6;
            acceltime = 0.1;
            deceltime = 5.9;
            level clientfield::set( "COSMO_LANDER_BASE_ENTRY_BAY", 3 );
            var_5021702 = "lgt_exp_padup_base_entry";
        }
        else if ( arrive.target == "centrifuge_zip_door" )
        {
            movetime = 7;
            acceltime = 0.1;
            deceltime = 6.9;
            level clientfield::set( "COSMO_LANDER_CENTRIFUGE_BAY", 3 );
            var_5021702 = "lgt_exp_padup_centrifuge";
        }
        else if ( arrive.target == "storage_zip_door" )
        {
            movetime = 6;
            acceltime = 0.1;
            deceltime = 5.9;
            level clientfield::set( "COSMO_LANDER_STORAGE_BAY", 3 );
            var_5021702 = "lgt_exp_padup_storage";
        }
    }
    
    if ( var_5021702 != "" )
    {
        exploder::exploder( var_5021702 );
    }
    
    arrive_door = getentarray( arrive.target, "targetname" );
    
    for ( i = 0; i < arrive_door.size ; i++ )
    {
        arrive_door[ i ] thread close_lander_door( 1 );
    }
    
    lander.anchor moveto( final_dest.origin, movetime, acceltime, deceltime );
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ].lander )
        {
            players[ i ] clientfield::set( "COSMO_PLAYER_LANDER_FOG", 0 );
        }
    }
    
    lander.anchor thread lander_landing_wobble( movetime );
    level thread player_blocking_lander();
    lander.anchor waittill( #"movedone" );
    lander.sound_ent stoploopsound( 1 );
    lander stoploopsound( 3 );
    playsoundatposition( "zmb_lander_land", lander.origin );
    put_players_back_on_lander();
    level flag::set( "lander_grounded" );
    level flag::clear( "lander_landing" );
    level flag::set( "spawn_zombies" );
    open_lander_gate();
    unlock_players();
    level.lander_in_use = 0;
    lander.called = 0;
    
    if ( isdefined( arrive.target ) )
    {
        switch ( arrive.target )
        {
            case "catwalk_zip_door":
                level clientfield::set( "COSMO_LANDER_STATION", 2 );
                level clientfield::set( "COSMO_LANDER_CATWALK_BAY", 0 );
                break;
            case "base_entry_zip_door":
                level clientfield::set( "COSMO_LANDER_STATION", 3 );
                level clientfield::set( "COSMO_LANDER_BASE_ENTRY_BAY", 0 );
                break;
            case "centrifuge_zip_door":
                level clientfield::set( "COSMO_LANDER_STATION", 4 );
                level clientfield::set( "COSMO_LANDER_CENTRIFUGE_BAY", 0 );
                break;
            default:
                level clientfield::set( "COSMO_LANDER_STATION", 1 );
                level clientfield::set( "COSMO_LANDER_STORAGE_BAY", 0 );
                break;
        }
    }
    
    if ( level flag::get( "lander_a_used" ) && level flag::get( "lander_b_used" ) && level flag::get( "lander_c_used" ) && !level flag::get( "launch_activated" ) )
    {
        level flag::set( "launch_activated" );
    }
    
    if ( var_5021702 != "" )
    {
        wait 1;
        exploder::kill_exploder( var_5021702 );
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x75d067e9, Offset: 0x4d88
// Size: 0x10c
function lander_engine_fx()
{
    lander_base = getent( "lander_base", "script_noteworthy" );
    lander_base clientfield::set( "COSMO_LANDER_ENGINE_FX", 1 );
    lander_base clientfield::set( "COSMO_LANDER_RUMBLE_AND_QUAKE", 1 );
    level flag::wait_till( "lander_grounded" );
    lander_base clientfield::set( "COSMO_LANDER_RUMBLE_AND_QUAKE", 0 );
    wait 2.5;
    playfx( level._effect[ "lunar_lander_dust" ], lander_base.origin );
    lander_base clientfield::set( "COSMO_LANDER_ENGINE_FX", 0 );
}

// Namespace zm_cosmodrome_lander
// Params 4
// Checksum 0x4ab8f159, Offset: 0x4ea0
// Size: 0x12c
function takeoff_nuke( max_zombies, range, delay, trig )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    zombies = getaispeciesarray( "axis" );
    spot = self.origin;
    zombies = util::get_array_of_closest( self.origin, zombies, undefined, max_zombies, range );
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        if ( !zombies[ i ] istouching( trig ) )
        {
            continue;
        }
        
        zombies[ i ] thread zombie_burst();
    }
    
    wait 0.5;
    lander_clean_up_corpses( spot, 250 );
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x2b146bc3, Offset: 0x4fd8
// Size: 0xb4
function zombie_burst()
{
    self endon( #"death" );
    wait randomfloatrange( 0.2, 0.3 );
    level.zombie_total++;
    playsoundatposition( "nuked", self.origin );
    playfx( level._effect[ "zomb_gib" ], self.origin );
    
    if ( isdefined( self.lander_death ) )
    {
        self [[ self.lander_death ]]();
    }
    
    self delete();
}

// Namespace zm_cosmodrome_lander
// Params 2
// Checksum 0x24c74af2, Offset: 0x5098
// Size: 0xde
function takeoff_knockdown( min_range, max_range )
{
    zombies = getaispeciesarray( "axis" );
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        dist = distancesquared( zombies[ i ].origin, self.origin );
        
        if ( dist >= min_range * min_range && dist <= max_range * max_range )
        {
            zombies[ i ] thread zombie_knockdown();
        }
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xb3380a79, Offset: 0x5180
// Size: 0x8c
function zombie_knockdown()
{
    self endon( #"death" );
    wait randomfloatrange( 0.2, 0.3 );
    self.lander_knockdown = 1;
    
    if ( isdefined( self.thundergun_knockdown_func ) )
    {
        self [[ self.thundergun_knockdown_func ]]( self, 0 );
    }
    
    self.thundergun_handle_pain_notetracks = &zm_weap_thundergun::handle_thundergun_pain_notetracks;
    self dodamage( 1, self.origin );
}

// Namespace zm_cosmodrome_lander
// Params 2
// Checksum 0x8459ba80, Offset: 0x5218
// Size: 0xb6
function lander_clean_up_corpses( spot, range )
{
    corpses = getcorpsearray();
    
    if ( isdefined( corpses ) )
    {
        for ( i = 0; i < corpses.size ; i++ )
        {
            if ( distancesquared( spot, corpses[ i ].origin ) <= range * range )
            {
                corpses[ i ] thread lander_remove_corpses();
            }
        }
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xefdf9c8f, Offset: 0x52d8
// Size: 0x74
function lander_remove_corpses()
{
    wait randomfloatrange( 0.05, 0.25 );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    playfx( level._effect[ "zomb_gib" ], self.origin );
    self delete();
}

// Namespace zm_cosmodrome_lander
// Params 2
// Checksum 0x118c00ce, Offset: 0x5358
// Size: 0x3fe
function lander_flight_wobble( lander, final_dest )
{
    self thread lander_flight_stop_wobble();
    self endon( #"movedone" );
    self endon( #"start_approach" );
    first_time = 1;
    rot_time = 0.75;
    
    while ( true )
    {
        if ( first_time )
        {
            rot_time = 1.75;
        }
        
        if ( lander.depart_station == "lander_station5" && final_dest.targetname == "lander_station1" )
        {
            self rotateto( ( randomfloatrange( 345, 355 ), 0, randomfloatrange( 0, 5 ) ), rot_time );
        }
        else if ( lander.depart_station == "lander_station1" && final_dest.targetname == "lander_station5" )
        {
            self rotateto( ( randomfloatrange( 370, 380 ), 0, randomfloatrange( -5, 0 ) ), rot_time );
        }
        else if ( lander.depart_station == "lander_station5" && final_dest.targetname == "lander_station4" )
        {
            self rotateto( ( randomfloatrange( 370, 380 ), 0, randomfloatrange( -5, 0 ) ), rot_time );
        }
        else if ( lander.depart_station == "lander_station4" && final_dest.targetname == "lander_station5" )
        {
            self rotateto( ( randomfloatrange( 345, 355 ), 0, randomfloatrange( 0, 5 ) ), rot_time );
        }
        else if ( lander.depart_station == "lander_station5" && final_dest.targetname == "lander_station3" )
        {
            self rotateto( ( randomfloatrange( 5, 10 ), 0, randomfloatrange( -15, -10 ) ), rot_time );
        }
        else if ( lander.depart_station == "lander_station3" && final_dest.targetname == "lander_station5" )
        {
            self rotateto( ( randomfloatrange( -10, -5 ), 0, randomfloatrange( 10, 15 ) ), rot_time );
        }
        else
        {
            self rotateto( ( randomfloatrange( -5, 5 ), 0, randomfloatrange( -5, 5 ) ), rot_time );
        }
        
        wait rot_time;
        
        if ( first_time )
        {
            first_time = 0;
        }
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x2510ace8, Offset: 0x5760
// Size: 0x70
function lander_takeoff_wobble()
{
    level endon( #"lander_launched" );
    
    while ( true )
    {
        self rotateto( ( randomfloatrange( -10, 10 ), 0, randomfloatrange( -10, 10 ) ), 0.5 );
        wait 0.5;
    }
}

// Namespace zm_cosmodrome_lander
// Params 1
// Checksum 0x7fb51ad2, Offset: 0x57d8
// Size: 0xcc
function lander_landing_wobble( movetime )
{
    time = movetime - 1;
    timer = gettime() + time * 1000;
    
    while ( gettime() < timer )
    {
        self rotateto( ( randomfloatrange( -5, 5 ), 0, randomfloatrange( -5, 5 ) ), 0.75 );
        wait 0.75;
    }
    
    self rotateto( ( 0, 0, 0 ), 0.75 );
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0xbb66eddb, Offset: 0x58b0
// Size: 0xc4
function lander_flight_stop_wobble()
{
    wait 3;
    self notify( #"start_approach" );
    self.old_angles = self.angles;
    self rotateto( ( self.angles[ 0 ] * -1, self.angles[ 1 ] * -1, self.angles[ 2 ] * -1 ), 2.75 );
    wait 3;
    self rotateto( self.old_angles, 2 );
    level flag::set( "lander_landing" );
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x8fd287b1, Offset: 0x5980
// Size: 0x698
function lander_cooldown_think()
{
    lander_use_trig = getent( "zip_buy", "script_noteworthy" );
    lander_callboxes = getentarray( "zip_call_box", "targetname" );
    lander = getent( "lander", "targetname" );
    
    while ( true )
    {
        level waittill( #"lu", riders, trig );
        level flag::set( "lander_inuse" );
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            lander_use_trig setinvisibletoplayer( players[ i ], 1 );
        }
        
        for ( i = 0; i < lander_callboxes.size ; i++ )
        {
            if ( lander_callboxes[ i ] == trig )
            {
                lander_callboxes[ i ] sethintstring( &"ZM_COSMODROME_LANDER_ON_WAY" );
                lander_callboxes[ i ] setcursorhint( "HINT_NOICON" );
                continue;
            }
            
            lander_callboxes[ i ] sethintstring( &"ZM_COSMODROME_LANDER_IN_USE" );
            lander_callboxes[ i ] setcursorhint( "HINT_NOICON" );
        }
        
        while ( level.lander_in_use )
        {
            wait 0.1;
        }
        
        level flag::clear( "lander_inuse" );
        level flag::set( "lander_cooldown" );
        cooldown = 3;
        str = &"ZM_COSMODROME_LANDER_COOLDOWN";
        
        if ( riders != 0 )
        {
            cooldown = 30;
            str = &"ZM_COSMODROME_LANDER_REFUEL";
            
            for ( i = 0; i < lander_callboxes.size ; i++ )
            {
                lander_callboxes[ i ] playsound( "vox_ann_lander_cooldown" );
            }
            
            lander playsound( "zmb_lander_pump_start" );
            lander playloopsound( "zmb_lander_pump_loop", 1 );
        }
        
        lander_use_trig sethintstring( str );
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            lander_use_trig setinvisibletoplayer( players[ i ], 0 );
        }
        
        for ( i = 0; i < lander_callboxes.size ; i++ )
        {
            if ( lander_callboxes[ i ].script_noteworthy != lander.station )
            {
                lander_callboxes[ i ] sethintstring( str );
                continue;
            }
            
            lander_callboxes[ i ] sethintstring( &"ZM_COSMODROME_LANDER_AT_STATION" );
            lander_callboxes[ i ] setcursorhint( "HINT_NOICON" );
        }
        
        if ( !isdefined( level.var_a1879e28 ) || level.var_a1879e28 )
        {
            wait cooldown;
        }
        else
        {
            wait 1;
        }
        
        lander stoploopsound( 1.5 );
        lander playsound( "zmb_lander_pump_end" );
        
        if ( cooldown == 30 )
        {
            for ( i = 0; i < lander_callboxes.size ; i++ )
            {
                lander_callboxes[ i ] playsound( "vox_ann_lander_ready" );
            }
        }
        
        level clientfield::set( "COSMO_LANDER_STATUS_LIGHTS", 2 );
        lander_use_trig sethintstring( &"ZM_COSMODROME_LANDER", 250 );
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            lander_use_trig setinvisibletoplayer( players[ i ], 0 );
        }
        
        for ( i = 0; i < lander_callboxes.size ; i++ )
        {
            if ( lander_callboxes[ i ].script_noteworthy != lander.station )
            {
                lander_callboxes[ i ] sethintstring( &"ZM_COSMODROME_LANDER_CALL" );
                continue;
            }
            
            lander_callboxes[ i ] sethintstring( &"ZM_COSMODROME_LANDER_AT_STATION" );
            lander_callboxes[ i ] setcursorhint( "HINT_NOICON" );
        }
        
        level flag::clear( "lander_cooldown" );
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x54871d5, Offset: 0x6020
// Size: 0xbc
function play_launch_unlock_vox()
{
    while ( true )
    {
        level flag::wait_till( "lander_grounded" );
        
        if ( level flag::get( "lander_a_used" ) && level flag::get( "lander_b_used" ) && level flag::get( "lander_c_used" ) )
        {
            level thread zm_cosmodrome_amb::play_cosmo_announcer_vox( "vox_ann_landers_used" );
            return;
        }
        
        wait 0.05;
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x72f10bd4, Offset: 0x60e8
// Size: 0x2c
function force_wait_for_gersh_line()
{
    wait 10;
    level thread zm_cosmodrome_eggs::play_egg_vox( undefined, "vox_gersh_egg_start", 0 );
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x78712dfd, Offset: 0x6120
// Size: 0x14e
function put_players_back_on_lander()
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !( isdefined( players[ i ].lander ) && players[ i ].lander ) && !( isdefined( players[ i ].on_lander_last_stand ) && players[ i ].on_lander_last_stand ) )
        {
            continue;
        }
        
        if ( !players[ i ] is_player_on_lander() )
        {
            if ( isdefined( players[ i ].lander_link_spot ) )
            {
                players[ i ] setorigin( players[ i ].lander_link_spot.origin );
                players[ i ] playsound( "zmb_laugh_child" );
            }
        }
    }
}

// Namespace zm_cosmodrome_lander
// Params 0
// Checksum 0x5db606b8, Offset: 0x6278
// Size: 0x13c, Type: bool
function is_player_on_lander()
{
    lander = getent( "lander", "targetname" );
    rider_trigger = getent( lander.station + "_riders", "targetname" );
    lander_trig = getent( "zip_buy", "script_noteworthy" );
    base = getent( "lander_base", "script_noteworthy" );
    
    if ( rider_trigger istouching( self ) || self istouching( lander_trig ) || distance( self.origin, base.origin ) < 200 )
    {
        return true;
    }
    
    return false;
}

