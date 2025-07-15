#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/util_shared;
#using scripts/zm/zm_temple;
#using scripts/zm/zm_temple_elevators;

#namespace zm_temple_pack_a_punch;

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x744bf300, Offset: 0x4a0
// Size: 0x16c
function init_pack_a_punch()
{
    level flag::init( "pap_round" );
    level flag::init( "pap_active" );
    level flag::init( "pap_open" );
    level flag::init( "pap_enabled" );
    level.pack_a_punch_round_time = 30;
    level.pack_a_punch_stone_timer = getentarray( "pack_a_punch_timer", "targetname" );
    level.pack_a_punch_stone_timer_dist = 176;
    util::registerclientsys( "pap_indicator_spinners" );
    level.pap_active_time = 60;
    
    /#
        if ( getdvarint( "<dev string:x28>" ) )
        {
            level.pap_active_time = 20;
        }
    #/
    
    _setup_pap_blocker();
    _setup_pap_timer();
    _setup_pap_path();
    _setup_pap_fx();
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xf5b5ebc1, Offset: 0x618
// Size: 0x554
function _setup_pap_blocker()
{
    level thread _setup_simultaneous_pap_triggers();
    var_45648617 = getent( "pap_stairs_mesh", "targetname" );
    var_45648617 delete();
    level.pap_stairs = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        stair = getent( "pap_stairs" + i + 1, "targetname" );
        
        if ( !isdefined( stair.script_vector ) )
        {
            stair.script_vector = ( 0, 0, 72 );
        }
        
        stair.movetime = 3;
        stair.movedist = stair.script_vector;
        
        if ( i == 3 )
        {
            stair.down_origin = stair.origin;
            stair.up_origin = stair.down_origin + stair.movedist;
        }
        else
        {
            stair.up_origin = stair.origin;
            stair.down_origin = stair.up_origin - stair.movedist;
            stair.origin = stair.down_origin;
        }
        
        stair.state = "down";
        level.pap_stairs[ i ] = stair;
    }
    
    level.pap_stairs_clip = getent( "pap_stairs_clip", "targetname" );
    
    if ( isdefined( level.pap_stairs_clip ) )
    {
        level.pap_stairs_clip.zmove = 72;
    }
    
    level.pap_playerclip = getentarray( "pap_playerclip", "targetname" );
    
    for ( i = 0; i < level.pap_playerclip.size ; i++ )
    {
        level.pap_playerclip[ i ].saved_origin = level.pap_playerclip[ i ].origin;
    }
    
    level.pap_ramp = getent( "pap_ramp", "targetname" );
    level.brush_pap_traversal = getent( "brush_pap_traversal", "targetname" );
    
    if ( isdefined( level.brush_pap_traversal ) )
    {
        level.brush_pap_traversal solid();
        level.brush_pap_traversal disconnectpaths();
        a_nodes = getnodearray( "node_pap_jump_bottom", "targetname" );
        
        foreach ( node in a_nodes )
        {
            linktraversal( node );
        }
    }
    
    level.brush_pap_side_l = getent( "brush_pap_side_l", "targetname" );
    
    if ( isdefined( level.brush_pap_side_l ) )
    {
        level.brush_pap_side_l _pap_brush_disconnect_paths();
    }
    
    level.brush_pap_side_r = getent( "brush_pap_side_r", "targetname" );
    
    if ( isdefined( level.brush_pap_side_r ) )
    {
        level.brush_pap_side_r _pap_brush_disconnect_paths();
    }
    
    brush_pap_pathing_ramp_r = getent( "brush_pap_pathing_ramp_r", "targetname" );
    
    if ( isdefined( brush_pap_pathing_ramp_r ) )
    {
        brush_pap_pathing_ramp_r delete();
    }
    
    brush_pap_pathing_ramp_l = getent( "brush_pap_pathing_ramp_l", "targetname" );
    
    if ( isdefined( brush_pap_pathing_ramp_l ) )
    {
        brush_pap_pathing_ramp_l delete();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x409afe65, Offset: 0xb78
// Size: 0x1d4
function _watch_for_fall()
{
    wait 0.1;
    self setcontents( 0 );
    self startragdoll();
    self.base setcandamage( 1 );
    self.base.health = 1;
    self.base waittill( #"damage" );
    mover = getent( self.base.target, "targetname" );
    geyserfx = isdefined( self.base.script_string ) && self.base.script_string == "geyser";
    self.base delete();
    self.base = undefined;
    wait 0.5;
    
    if ( geyserfx )
    {
        level thread _play_geyser_fx( mover.origin );
    }
    
    mover movez( -14, 1, 0.2, 0 );
    mover waittill( #"movedone" );
    level.zombie_drops_left -= 1;
    
    if ( level.zombie_drops_left <= 0 )
    {
        level flag::set( "pap_enabled" );
    }
}

// Namespace zm_temple_pack_a_punch
// Params 1
// Checksum 0xcf66f97c, Offset: 0xd58
// Size: 0x74
function _play_geyser_fx( origin )
{
    fxobj = spawnfx( level._effect[ "geyser_active" ], origin );
    triggerfx( fxobj );
    wait 3;
    fxobj delete();
}

// Namespace zm_temple_pack_a_punch
// Params 2
// Checksum 0xc92c8a02, Offset: 0xdd8
// Size: 0x6c
function power( base, exp )
{
    assert( exp >= 0 );
    
    if ( exp == 0 )
    {
        return 1;
    }
    
    return base * power( base, exp - 1 );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x7b8de192, Offset: 0xe50
// Size: 0x3f8
function _setup_simultaneous_pap_triggers()
{
    spots = getentarray( "hanging_base", "targetname" );
    
    for ( i = 0; i < spots.size ; i++ )
    {
        spots[ i ] delete();
    }
    
    level flag::wait_till( "power_on" );
    triggers = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        triggers[ i ] = getent( "pap_blocker_trigger" + i + 1, "targetname" );
    }
    
    _randomize_pressure_plates( triggers );
    array::thread_all( triggers, &_pap_pressure_plate_move );
    wait 1;
    last_num_plates_active = -1;
    last_plate_state = -1;
    
    while ( true )
    {
        players = getplayers();
        num_plates_needed = players.size;
        
        /#
            if ( getdvarint( "<dev string:x40>" ) == 2 )
            {
                num_plates_needed = 1;
            }
        #/
        
        num_plates_active = 0;
        plate_state = 0;
        
        for ( i = 0; i < triggers.size ; i++ )
        {
            if ( triggers[ i ].plate.active )
            {
                num_plates_active++;
            }
            
            if ( triggers[ i ].plate.active || triggers[ i ].requiredplayers - 1 >= num_plates_needed )
            {
                plate_state += power( 2, triggers[ i ].requiredplayers - 1 );
            }
        }
        
        if ( last_num_plates_active != num_plates_active || plate_state != last_plate_state )
        {
            last_num_plates_active = num_plates_active;
            last_plate_state = plate_state;
            _set_num_plates_active( num_plates_active, plate_state );
        }
        
        _update_stairs( triggers );
        
        if ( num_plates_active >= num_plates_needed )
        {
            for ( i = 0; i < triggers.size ; i++ )
            {
                triggers[ i ] notify( #"pap_active" );
                triggers[ i ].plate _plate_move_down();
            }
            
            _pap_think();
            _randomize_pressure_plates( triggers );
            array::thread_all( triggers, &_pap_pressure_plate_move );
            _set_num_plates_active( 4, 15 );
            wait 1;
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 1
// Checksum 0x8a49ee3d, Offset: 0x1250
// Size: 0x9a
function _randomize_pressure_plates( triggers )
{
    rand_nums = array( 1, 2, 3, 4 );
    rand_nums = array::randomize( rand_nums );
    
    for ( i = 0; i < triggers.size ; i++ )
    {
        triggers[ i ].requiredplayers = rand_nums[ i ];
    }
}

// Namespace zm_temple_pack_a_punch
// Params 1
// Checksum 0xe7b4f7ad, Offset: 0x12f8
// Size: 0x106
function _update_stairs( triggers )
{
    numtouched = 0;
    
    for ( i = 0; i < triggers.size ; i++ )
    {
        if ( isdefined( triggers[ i ].touched ) && triggers[ i ].touched )
        {
            numtouched++;
        }
    }
    
    for ( i = 0; i < numtouched ; i++ )
    {
        level.pap_stairs[ i ] _stairs_move_up();
    }
    
    for ( i = numtouched; i < level.pap_stairs.size ; i++ )
    {
        level.pap_stairs[ i ] _stairs_move_down();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x43be0f43, Offset: 0x1408
// Size: 0x3c, Type: bool
function _pap_pressure_plate_move_enabled()
{
    numplayers = getplayers().size;
    
    if ( numplayers >= self.requiredplayers )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x74e8c822, Offset: 0x1450
// Size: 0x2f4
function _pap_pressure_plate_move()
{
    self endon( #"pap_active" );
    plate = getent( self.target, "targetname" );
    self.plate = plate;
    plate.movetime = 2;
    plate.movedist = ( 0, 0, 10 );
    plate.down_origin = plate.origin;
    plate.up_origin = plate.origin + plate.movedist;
    plate.origin = plate.down_origin;
    plate.state = "down";
    movespeed = 10;
    
    while ( true )
    {
        while ( !self _pap_pressure_plate_move_enabled() )
        {
            plate.active = 0;
            self.touched = 0;
            plate thread _plate_move_down();
            wait 0.1;
        }
        
        plate.active = 0;
        self.touched = 0;
        plate _plate_move_up();
        plate waittill( #"state_set" );
        
        while ( self _pap_pressure_plate_move_enabled() )
        {
            players = getplayers();
            touching = 0;
            
            if ( !self _pap_pressure_plate_move_enabled() )
            {
                break;
            }
            
            for ( i = 0; i < players.size && !touching ; i++ )
            {
                if ( players[ i ].sessionstate != "spectator" )
                {
                    touching = players[ i ] istouching( self );
                }
            }
            
            self.touched = touching;
            
            if ( touching )
            {
                plate _plate_move_down();
            }
            else
            {
                plate _plate_move_up();
            }
            
            plate.active = plate.state == "down";
            wait 0.1;
        }
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xccdce5fb, Offset: 0x1750
// Size: 0x3c
function _stairs_playmovesound()
{
    self _stairs_stopmovesound();
    self playloopsound( "zmb_staircase_loop" );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x4b3cd9b4, Offset: 0x1798
// Size: 0x1c
function _stairs_stopmovesound()
{
    self stoploopsound();
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xe12f5a74, Offset: 0x17c0
// Size: 0x24
function _stairs_playlockedsound()
{
    self playsound( "zmb_staircase_lock" );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xe18ab681, Offset: 0x17f0
// Size: 0x3c
function _plate_playmovesound()
{
    self _plate_stopmovesound();
    self playloopsound( "zmb_pressure_plate_loop" );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x270677c3, Offset: 0x1838
// Size: 0x1c
function _plate_stopmovesound()
{
    self stoploopsound();
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x8dd455ab, Offset: 0x1860
// Size: 0x24
function _plate_playlockedsound()
{
    self playsound( "zmb_pressure_plate_lock" );
}

// Namespace zm_temple_pack_a_punch
// Params 1
// Checksum 0x7b463015, Offset: 0x1890
// Size: 0x42
function _mover_get_origin( state )
{
    if ( state == "up" )
    {
        return self.up_origin;
    }
    else if ( state == "down" )
    {
        return self.down_origin;
    }
    
    return undefined;
}

// Namespace zm_temple_pack_a_punch
// Params 3
// Checksum 0x34ed23bb, Offset: 0x18e0
// Size: 0x14a
function _move_pap_mover_wait( state, onmovefunc, onstopfunc )
{
    self endon( #"move" );
    goalorigin = self _mover_get_origin( state );
    movetime = self.movetime;
    timescale = abs( self.origin[ 2 ] - goalorigin[ 2 ] ) / self.movedist[ 2 ];
    movetime *= timescale;
    self.state = "moving_" + state;
    
    if ( movetime > 0 )
    {
        if ( isdefined( onmovefunc ) )
        {
            self thread [[ onmovefunc ]]();
        }
        
        self moveto( goalorigin, movetime );
        self waittill( #"movedone" );
        
        if ( isdefined( onstopfunc ) )
        {
            self thread [[ onstopfunc ]]();
        }
    }
    
    self.state = state;
    self notify( #"state_set" );
}

// Namespace zm_temple_pack_a_punch
// Params 3
// Checksum 0x7abd5f42, Offset: 0x1a38
// Size: 0x74
function _move_pap_mover( state, onmovefunc, onstopfunc )
{
    if ( self.state == state || self.state == "moving_" + state )
    {
        return;
    }
    
    self notify( #"move" );
    self thread _move_pap_mover_wait( state, onmovefunc, onstopfunc );
}

// Namespace zm_temple_pack_a_punch
// Params 2
// Checksum 0xc3246341, Offset: 0x1ab8
// Size: 0x3c
function _move_down( onmovefunc, onstopfunc )
{
    self thread _move_pap_mover( "down", onmovefunc, onstopfunc );
}

// Namespace zm_temple_pack_a_punch
// Params 2
// Checksum 0x3cc92fde, Offset: 0x1b00
// Size: 0x3c
function _move_up( onmovefunc, onstopfunc )
{
    self thread _move_pap_mover( "up", onmovefunc, onstopfunc );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xf1170644, Offset: 0x1b48
// Size: 0x54
function _plate_move_up()
{
    onmovefunc = &_plate_onmove;
    onstopfunc = &_plate_onstop;
    self thread _move_up( onmovefunc, onstopfunc );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x3b854b52, Offset: 0x1ba8
// Size: 0x54
function _plate_move_down()
{
    onmovefunc = &_plate_onmove;
    onstopfunc = &_plate_onstop;
    self thread _move_down( onmovefunc, onstopfunc );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xd842f6e, Offset: 0x1c08
// Size: 0x1c
function _plate_onmove()
{
    self _plate_playmovesound();
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x37ca33e, Offset: 0x1c30
// Size: 0x34
function _plate_onstop()
{
    self _plate_stopmovesound();
    self _plate_playlockedsound();
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x5eff0ba2, Offset: 0x1c70
// Size: 0x4e
function _move_all_stairs_down()
{
    for ( i = 0; i < level.pap_stairs.size ; i++ )
    {
        level.pap_stairs[ i ] thread _stairs_move_down();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x1c590d5, Offset: 0x1cc8
// Size: 0x4e
function _move_all_stairs_up()
{
    for ( i = 0; i < level.pap_stairs.size ; i++ )
    {
        level.pap_stairs[ i ] thread _stairs_move_up();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xe13d06e6, Offset: 0x1d20
// Size: 0x54
function _stairs_move_up()
{
    onmovefunc = &_stairs_onmove;
    onstopfunc = &_stairs_onstop;
    self _move_up( onmovefunc, onstopfunc );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x3811c7d9, Offset: 0x1d80
// Size: 0x54
function _stairs_move_down()
{
    onmovefunc = &_stairs_onmove;
    onstopfunc = &_stairs_onstop;
    self _move_down( onmovefunc, onstopfunc );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xcf2baa59, Offset: 0x1de0
// Size: 0x1c
function _stairs_onmove()
{
    self _stairs_playmovesound();
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x872bcf5f, Offset: 0x1e08
// Size: 0x34
function _stairs_onstop()
{
    self _stairs_stopmovesound();
    self _stairs_playlockedsound();
}

// Namespace zm_temple_pack_a_punch
// Params 1
// Checksum 0x4a62a31c, Offset: 0x1e48
// Size: 0x82
function _wait_for_all_stairs( state )
{
    for ( i = 0; i < level.pap_stairs.size ; i++ )
    {
        stair = level.pap_stairs[ i ];
        
        while ( true )
        {
            if ( stair.state == state )
            {
                break;
            }
            
            wait 0.1;
        }
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xabbf9d59, Offset: 0x1ed8
// Size: 0x15c
function _wait_for_all_stairs_up()
{
    _wait_for_all_stairs( "up" );
    
    if ( isdefined( level.brush_pap_traversal ) )
    {
        a_nodes = getnodearray( "node_pap_jump_bottom", "targetname" );
        
        foreach ( node in a_nodes )
        {
            unlinktraversal( node );
        }
        
        level.brush_pap_traversal notsolid();
        level.brush_pap_traversal connectpaths();
    }
    
    if ( isdefined( level.brush_pap_side_l ) )
    {
        level.brush_pap_side_l _pap_brush_connect_paths();
    }
    
    if ( isdefined( level.brush_pap_side_r ) )
    {
        level.brush_pap_side_r _pap_brush_connect_paths();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x78f25bb9, Offset: 0x2040
// Size: 0x15c
function _wait_for_all_stairs_down()
{
    _wait_for_all_stairs( "down" );
    
    if ( isdefined( level.brush_pap_traversal ) )
    {
        a_nodes = getnodearray( "node_pap_jump_bottom", "targetname" );
        
        foreach ( node in a_nodes )
        {
            linktraversal( node );
        }
        
        level.brush_pap_traversal solid();
        level.brush_pap_traversal disconnectpaths();
    }
    
    if ( isdefined( level.brush_pap_side_l ) )
    {
        level.brush_pap_side_l _pap_brush_disconnect_paths();
    }
    
    if ( isdefined( level.brush_pap_side_r ) )
    {
        level.brush_pap_side_r _pap_brush_disconnect_paths();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x55a6832, Offset: 0x21a8
// Size: 0x1d4
function _pap_think()
{
    player_blocker = getent( "pap_stairs_player_clip", "targetname" );
    level flag::set( "pap_active" );
    level thread _pap_clean_up_corpses();
    
    if ( isdefined( level.pap_stairs_clip ) )
    {
        level.pap_stairs_clip movez( level.pap_stairs_clip.zmove, 2, 0.5, 0.5 );
    }
    
    _move_all_stairs_up();
    _wait_for_all_stairs_up();
    
    if ( isdefined( player_blocker ) )
    {
        player_blocker notsolid();
    }
    
    level stop_pap_fx();
    level thread _wait_for_pap_reset();
    level waittill( #"flush_done" );
    level flag::clear( "pap_active" );
    
    if ( isdefined( level.pap_stairs_clip ) )
    {
        level.pap_stairs_clip movez( -1 * level.pap_stairs_clip.zmove, 2, 0.5, 0.5 );
    }
    
    level thread _pap_ramp();
    _move_all_stairs_down();
    _wait_for_all_stairs_down();
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x6b6746c9, Offset: 0x2388
// Size: 0x116
function _pap_clean_up_corpses()
{
    corpse_trig = getent( "pap_target_finder", "targetname" );
    stairs_trig = getent( "pap_target_finder2", "targetname" );
    corpses = getcorpsearray();
    
    if ( isdefined( corpses ) )
    {
        for ( i = 0; i < corpses.size ; i++ )
        {
            if ( corpses[ i ] istouching( corpse_trig ) || corpses[ i ] istouching( stairs_trig ) )
            {
                corpses[ i ] thread _pap_remove_corpse();
            }
        }
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x71c79a4b, Offset: 0x24a8
// Size: 0x4c
function _pap_remove_corpse()
{
    playfx( level._effect[ "corpse_gib" ], self.origin );
    self delete();
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x4963679b, Offset: 0x2500
// Size: 0x1a4
function _pap_ramp()
{
    if ( isdefined( level.pap_ramp ) )
    {
        level thread playerclip_restore();
        
        if ( !isdefined( level.pap_ramp.original_origin ) )
        {
            level.pap_ramp.original_origin = level.pap_ramp.origin;
        }
        
        level.pap_ramp rotateroll( 45, 0.5 );
        wait 1;
        level.pap_ramp rotateroll( 45, 0.5 );
        level.pap_ramp moveto( struct::get( "pap_ramp_push1", "targetname" ).origin, 1 );
        level.pap_ramp waittill( #"movedone" );
        level.pap_ramp moveto( struct::get( "pap_ramp_push2", "targetname" ).origin, 2 );
        level.pap_ramp waittill( #"movedone" );
        level.pap_ramp.origin = level.pap_ramp.original_origin;
        level.pap_ramp rotateroll( -90, 0.5 );
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xe6adfe1c, Offset: 0x26b0
// Size: 0x17c
function playerclip_restore()
{
    volume = getent( "pap_target_finder", "targetname" );
    
    while ( true )
    {
        touching = 0;
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( players[ i ] istouching( volume ) || players[ i ] istouching( level.pap_player_flush_temp_trig ) )
            {
                touching = 1;
            }
        }
        
        if ( !touching )
        {
            break;
        }
        
        wait 0.05;
    }
    
    player_clip = getent( "pap_stairs_player_clip", "targetname" );
    
    if ( isdefined( player_clip ) )
    {
        player_clip solid();
    }
    
    if ( isdefined( level.pap_player_flush_temp_trig ) )
    {
        level.pap_player_flush_temp_trig delete();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x168eb14b, Offset: 0x2838
// Size: 0xe4
function _wait_for_pap_reset()
{
    level endon( #"fake_death" );
    array::thread_all( level.pap_timers, &_move_visual_timer );
    array::thread_all( level.pap_timers, &_pack_a_punch_timer_sounds );
    level thread _pack_a_punch_warning_fx( level.pap_active_time );
    fx_time_offset = 0.5;
    wait level.pap_active_time - fx_time_offset;
    level start_pap_fx();
    level thread _pap_fx_timer();
    wait fx_time_offset;
    _find_ents_to_flush();
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xceed6217, Offset: 0x2928
// Size: 0x1a
function _pap_fx_timer()
{
    wait 5.5;
    level notify( #"flush_fx_done" );
}

// Namespace zm_temple_pack_a_punch
// Params 1
// Checksum 0xf59486b9, Offset: 0x2950
// Size: 0x34
function _pack_a_punch_warning_fx( pap_time )
{
    wait pap_time - 5;
    exploder::exploder( "fxexp_60" );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x3cd98c0c, Offset: 0x2990
// Size: 0xb4
function _pack_a_punch_timer_sounds()
{
    pap_timer_length = 8.5;
    self playsound( "evt_pap_timer_start" );
    self playloopsound( "evt_pap_timer_loop" );
    wait level.pap_active_time - pap_timer_length;
    self playsound( "evt_pap_timer_countdown" );
    wait pap_timer_length;
    self stoploopsound();
    self playsound( "evt_pap_timer_stop" );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x94aced7f, Offset: 0x2a50
// Size: 0x30e
function _find_ents_to_flush()
{
    level notify( #"flush_ents" );
    level endon( #"fake_death" );
    _play_flush_sounds();
    level.flushspeed = 400;
    level.ents_being_flushed = 0;
    level.flushscale = 1;
    volume = getent( "pap_target_finder", "targetname" );
    level.pap_player_flush_temp_trig = spawn( "trigger_radius", ( -8, 560, 288 ), 0, 768, 256 );
    players = getplayers();
    touching_players = [];
    
    for ( i = 0; i < players.size ; i++ )
    {
        touching = players[ i ] istouching( volume ) || players[ i ] istouching( level.pap_player_flush_temp_trig );
        
        if ( touching )
        {
            touching_players[ touching_players.size ] = players[ i ];
            players[ i ] thread _player_flushed_out( volume );
        }
    }
    
    bottom_stairs_vol = getent( "pap_target_finder2", "targetname" );
    zombies_to_flush = [];
    zombies = getaispeciesarray( "axis", "all" );
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        if ( zombies[ i ] istouching( volume ) || zombies[ i ] istouching( bottom_stairs_vol ) )
        {
            zombies_to_flush[ zombies_to_flush.size ] = zombies[ i ];
        }
    }
    
    if ( zombies_to_flush.size > 0 )
    {
        level thread do_zombie_flush( zombies_to_flush );
    }
    
    level notify( #"flush_done" );
    
    while ( level.ents_being_flushed > 0 )
    {
        util::wait_network_frame();
    }
    
    level notify( #"pap_reset_complete" );
}

// Namespace zm_temple_pack_a_punch
// Params 1
// Checksum 0x612b2908, Offset: 0x2d68
// Size: 0x100
function _player_flushed_out( volume )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"flush_fx_done" );
    water_start_org = ( 0, 408, 304 );
    max_dist = 400;
    time = 1.5;
    dist = distance( self.origin, water_start_org );
    scale_dist = dist / max_dist;
    time *= scale_dist;
    wait time;
    
    while ( true )
    {
        if ( !self istouching( volume ) )
        {
            break;
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x1e20c649, Offset: 0x2e70
// Size: 0x64
function _play_flush_sounds()
{
    snd_struct = struct::get( "pap_water", "targetname" );
    
    if ( isdefined( snd_struct ) )
    {
        level thread sound::play_in_space( "evt_pap_water", snd_struct.origin );
    }
}

// Namespace zm_temple_pack_a_punch
// Params 2
// Checksum 0xf9695ad4, Offset: 0x2ee0
// Size: 0x92, Type: bool
function _flush_compare_func( p1, p2 )
{
    dist1 = distancesquared( p1.origin, level.flush_path.origin );
    dist2 = distancesquared( p2.origin, level.flush_path.origin );
    return dist1 > dist2;
}

// Namespace zm_temple_pack_a_punch
// Params 1
// Checksum 0x5aa7e5c7, Offset: 0x2f80
// Size: 0x4b4
function _player_flush( index )
{
    self enableinvulnerability();
    self allowprone( 0 );
    self allowcrouch( 0 );
    self playrumblelooponentity( "tank_rumble" );
    self thread pap_flush_screen_shake( 3 );
    mover = spawn( "script_origin", self.origin );
    self playerlinkto( mover );
    pc = level.pap_playerclip[ index ];
    pc.origin = self.origin;
    pc linkto( self );
    level.ents_being_flushed++;
    self.flushed = 1;
    useaccel = 1;
    flushspeed = level.flushspeed - 30 * index;
    wait index * 0.1;
    
    for ( nexttarget = self _ent_getnextflushtarget(); isdefined( nexttarget ) ; nexttarget = nexttarget.next )
    {
        movetarget = ( self.origin[ 0 ], nexttarget.origin[ 1 ], nexttarget.origin[ 2 ] );
        
        if ( !isdefined( nexttarget.next ) )
        {
            movetarget = ( movetarget[ 0 ], self.origin[ 1 ] + ( movetarget[ 1 ] - self.origin[ 1 ] ) * level.flushscale, movetarget[ 2 ] );
            level.flushscale -= 0.25;
            
            if ( level.flushscale <= 0 )
            {
                level.flushscale = 0.1;
            }
        }
        
        dist = abs( nexttarget.origin[ 1 ] - self.origin[ 1 ] );
        time = dist / flushspeed;
        accel = 0;
        decel = 0;
        
        if ( useaccel )
        {
            useaccel = 0;
            accel = min( 0.2, time );
        }
        
        if ( !isdefined( nexttarget.target ) )
        {
            accel = 0;
            decel = time;
            time += 0.5;
        }
        
        mover moveto( movetarget, time, accel, decel );
        waittime = max( time, 0 );
        wait waittime;
    }
    
    mover delete();
    self stoprumble( "tank_rumble" );
    self notify( #"pap_flush_done" );
    pc unlink();
    pc.origin = pc.saved_origin;
    self allowprone( 1 );
    self allowcrouch( 1 );
    self.flushed = 0;
    self disableinvulnerability();
    level.ents_being_flushed--;
}

// Namespace zm_temple_pack_a_punch
// Params 1
// Checksum 0xf5d1b2ed, Offset: 0x3440
// Size: 0xa0
function pap_flush_screen_shake( activetime )
{
    self endon( #"pap_flush_done" );
    
    while ( true )
    {
        earthquake( randomfloatrange( 0.2, 0.4 ), randomfloatrange( 1, 2 ), self.origin, 100, self );
        wait randomfloatrange( 0.1, 0.3 );
    }
}

// Namespace zm_temple_pack_a_punch
// Params 1
// Checksum 0x61286185, Offset: 0x34e8
// Size: 0x86
function do_zombie_flush( zombies_to_flush )
{
    for ( i = 0; i < zombies_to_flush.size ; i++ )
    {
        if ( isdefined( zombies_to_flush[ i ] ) && isalive( zombies_to_flush[ i ] ) )
        {
            zombies_to_flush[ i ] thread _zombie_flush();
        }
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xe517c5c4, Offset: 0x3578
// Size: 0x1bc
function _zombie_flush()
{
    self endon( #"death" );
    water_start_org = ( 0, 408, 304 );
    max_dist = 400;
    time = 1.5;
    dist = distance( self.origin, water_start_org );
    scale_dist = dist / max_dist;
    time *= scale_dist;
    wait time;
    self startragdoll();
    nexttarget = self _ent_getnextflushtarget();
    launchdir = nexttarget.origin - self.origin;
    launchdir = ( 0, launchdir[ 1 ], launchdir[ 2 ] );
    launchdir = vectornormalize( launchdir );
    self launchragdoll( launchdir * 50 );
    util::wait_network_frame();
    self.no_gib = 1;
    level.zombie_total++;
    self dodamage( self.health + 666, self.origin );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xe8ff3350, Offset: 0x3740
// Size: 0x64
function _ent_getnextflushtarget()
{
    for ( current_node = level.flush_path; true ; current_node = current_node.next )
    {
        if ( self.origin[ 1 ] >= current_node.origin[ 1 ] )
        {
            break;
        }
    }
    
    return current_node;
}

// Namespace zm_temple_pack_a_punch
// Params 2
// Checksum 0x72717874, Offset: 0x37b0
// Size: 0x4c
function _set_num_plates_active( num, state )
{
    level.pap_plates_active = num;
    level.pap_plates_state = state;
    clientfield::set( "papspinners", state );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x9e96b542, Offset: 0x3808
// Size: 0x2d8
function _setup_pap_timer()
{
    level.pap_timers = getentarray( "pap_timer", "targetname" );
    
    for ( i = 0; i < level.pap_timers.size ; i++ )
    {
        timer = level.pap_timers[ i ];
        timer.path = [];
        
        for ( targetname = timer.target; isdefined( targetname ) ; targetname = s.target )
        {
            s = struct::get( targetname, "targetname" );
            
            if ( !isdefined( s ) )
            {
                break;
            }
            
            timer.path[ timer.path.size ] = s;
        }
        
        timer.origin = timer.path[ 0 ].origin;
        pathlength = 0;
        
        for ( p = 1; p < timer.path.size ; p++ )
        {
            length = distance( timer.path[ p - 1 ].origin, timer.path[ p ].origin );
            timer.path[ p ].pathlength = length;
            pathlength += length;
        }
        
        timer.pathlength = pathlength;
        
        for ( p = timer.path.size - 2; p >= 0 ; p-- )
        {
            length = distance( timer.path[ p + 1 ].origin, timer.path[ p ].origin );
            timer.path[ p ].pathlengthreverse = length;
        }
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x2946edf8, Offset: 0x3ae8
// Size: 0xbc
function _move_visual_timer()
{
    reversespin = self.angles[ 1 ] != 0;
    speed = self.pathlength / level.pap_active_time;
    self _travel_path( speed, reversespin );
    returntime = 4;
    speed = self.pathlength / returntime;
    self _travel_path_reverse( speed, reversespin );
    self.origin = self.path[ 0 ].origin;
}

// Namespace zm_temple_pack_a_punch
// Params 2
// Checksum 0xce2a2992, Offset: 0x3bb0
// Size: 0x17a
function _travel_path( speed, reversespin )
{
    for ( i = 1; i < self.path.size ; i++ )
    {
        length = self.path[ i ].pathlength;
        time = length / speed;
        acceltime = 0;
        deceltime = 0;
        
        if ( i == 1 )
        {
            acceltime = 0.2;
        }
        else if ( i == self.path.size - 1 )
        {
            deceltime = 0.2;
        }
        
        self moveto( self.path[ i ].origin, time, acceltime, deceltime );
        rotatespeed = speed * -4;
        
        if ( reversespin )
        {
            rotatespeed *= -1;
        }
        
        self rotatevelocity( ( 0, 0, rotatespeed ), time );
        self waittill( #"movedone" );
    }
}

// Namespace zm_temple_pack_a_punch
// Params 2
// Checksum 0x3a675b4, Offset: 0x3d38
// Size: 0x1b6
function _travel_path_reverse( speed, reversespin )
{
    for ( i = self.path.size - 2; i >= 0 ; i-- )
    {
        length = self.path[ i ].pathlengthreverse;
        time = length / speed;
        acceltime = 0;
        deceltime = 0;
        
        if ( i == self.path.size - 2 )
        {
            acceltime = 0.2;
        }
        else if ( i == 0 )
        {
            deceltime = 0.5;
        }
        
        self moveto( self.path[ i ].origin, time, acceltime, deceltime );
        rotatespeed = speed * 4;
        
        if ( reversespin )
        {
            rotatespeed *= -1;
        }
        
        self rotatevelocity( ( 0, 0, rotatespeed ), time );
        self waittill( #"movedone" );
        self playsound( "evt_pap_timer_stop" );
        self playsound( "evt_pap_timer_start" );
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x799f76f2, Offset: 0x3ef8
// Size: 0xb2
function _setup_pap_path()
{
    level.flush_path = struct::get( "pap_flush_path", "targetname" );
    
    for ( current_node = level.flush_path; true ; current_node = next_node )
    {
        if ( !isdefined( current_node.target ) )
        {
            break;
        }
        
        next_node = struct::get( current_node.target, "targetname" );
        current_node.next = next_node;
    }
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x99ec1590, Offset: 0x3fb8
// Size: 0x4
function _setup_pap_fx()
{
    
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x8124e1c7, Offset: 0x3fc8
// Size: 0x1c
function start_pap_fx()
{
    exploder::exploder( "fxexp_61" );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x6d52a295, Offset: 0x3ff0
// Size: 0x1c
function stop_pap_fx()
{
    exploder::stop_exploder( "fxexp_61" );
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0x580c02a3, Offset: 0x4018
// Size: 0x4c
function _pap_brush_disconnect_paths()
{
    self solid();
    self disconnectpaths();
    self notsolid();
}

// Namespace zm_temple_pack_a_punch
// Params 0
// Checksum 0xd5a62504, Offset: 0x4070
// Size: 0x4c
function _pap_brush_connect_paths()
{
    self solid();
    self connectpaths();
    self notsolid();
}

