#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/zm_temple_triggers;

#namespace zm_temple_traps;

// Namespace zm_temple_traps
// Params 0
// Checksum 0xd9e45a6c, Offset: 0x520
// Size: 0x4c
function init_temple_traps()
{
    level thread spear_trap_init();
    level thread waterfall_trap_init();
    level thread init_maze_trap();
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x73cdace8, Offset: 0x578
// Size: 0x6c
function trigger_wait_for_power()
{
    self sethintstring( &"ZOMBIE_NEED_POWER" );
    self setcursorhint( "HINT_NOICON" );
    self.in_use = 0;
    level flag::wait_till( "power_on" );
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x6eee6ce9, Offset: 0x5f0
// Size: 0x10e
function spear_trap_init()
{
    speartraps = getentarray( "spear_trap", "targetname" );
    
    for ( i = 0; i < speartraps.size ; i++ )
    {
        speartrap = speartraps[ i ];
        speartrap.clip = getent( speartrap.target, "targetname" );
        speartrap.clip notsolid();
        speartrap.clip connectpaths();
        speartrap.enable_flag = speartrap.script_noteworthy;
        speartrap thread spear_trap_think();
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x81e7c4af, Offset: 0x708
// Size: 0x10a
function spear_trap_think()
{
    if ( isdefined( self.enable_flag ) && !level flag::get( self.enable_flag ) )
    {
        level flag::wait_till( self.enable_flag );
    }
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( !isdefined( who ) || !isplayer( who ) || who.sessionstate == "spectator" )
        {
            continue;
        }
        
        for ( i = 0; i < 3 ; i++ )
        {
            wait 0.4;
            self thread sprear_trap_activate_spears( i, who );
            wait 2;
        }
    }
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0xc395bb44, Offset: 0x820
// Size: 0x4c
function sprear_trap_activate_spears( audio_counter, player )
{
    self spear_trap_damage_all_characters( audio_counter, player );
    self thread spear_activate( 0 );
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0x69963516, Offset: 0x878
// Size: 0x156
function spear_trap_damage_all_characters( audio_counter, player )
{
    wait 0.1;
    characters = arraycombine( getplayers(), getaispeciesarray( "axis" ), 1, 1 );
    
    for ( i = 0; i < characters.size ; i++ )
    {
        char = characters[ i ];
        
        if ( self spear_trap_is_character_touching( char ) )
        {
            self thread spear_damage_character( char );
            continue;
        }
        
        if ( isplayer( char ) && audio_counter == 0 && randomintrange( 0, 101 ) <= 10 )
        {
            if ( isdefined( player ) && player == char )
            {
                char thread delayed_spikes_close_vox();
            }
        }
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x5fc373ae, Offset: 0x9d8
// Size: 0x8c
function delayed_spikes_close_vox()
{
    self notify( #"playing_spikes_close_vox" );
    self endon( #"death" );
    self endon( #"playing_spikes_close_vox" );
    wait 0.5;
    
    if ( isdefined( self.spear_trap_slow ) && ( !isdefined( self.spear_trap_slow ) || isdefined( self ) && self.spear_trap_slow == 0 ) )
    {
        self thread zm_audio::create_and_play_dialog( "general", "spikes_close" );
    }
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0xc21af182, Offset: 0xa70
// Size: 0x24
function spear_damage_character( char )
{
    char thread spear_trap_slow();
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x9c12e22b, Offset: 0xaa0
// Size: 0x1a0
function spear_trap_slow()
{
    self endon( #"death" );
    
    if ( isdefined( self.spear_trap_slow ) && self.spear_trap_slow )
    {
        return;
    }
    
    self.spear_trap_slow = 1;
    
    if ( isplayer( self ) )
    {
        if ( zombie_utility::is_player_valid( self ) )
        {
            self thread zm_audio::create_and_play_dialog( "general", "spikes_damage" );
            self thread _fake_red();
            self dodamage( 5, self.origin );
            playsoundatposition( "evt_spear_butt", self.origin );
            self playrumbleonentity( "pistol_fire" );
        }
        
        self setvelocity( ( 0, 0, 0 ) );
        self setmovespeedscale( 0.2 );
        wait 1;
        self setmovespeedscale( 1 );
        wait 0.5;
    }
    else if ( !( isdefined( self.missinglegs ) && self.missinglegs ) )
    {
        self _zombie_spear_trap_damage_wait();
    }
    
    self.spear_trap_slow = 0;
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xd713184d, Offset: 0xc48
// Size: 0x30
function spear_choke()
{
    level._num_ai_released = 0;
    
    while ( true )
    {
        wait 0.05;
        level._num_ai_released = 0;
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xefc2fad9, Offset: 0xc80
// Size: 0xfc
function _zombie_spear_trap_damage_wait()
{
    self endon( #"death" );
    
    if ( !isdefined( level._spear_choke ) )
    {
        level._spear_choke = 1;
        level thread spear_choke();
    }
    
    endtime = gettime() + randomintrange( 800, 1200 );
    
    while ( endtime > gettime() )
    {
        if ( isdefined( self.missinglegs ) && self.missinglegs )
        {
            break;
        }
        
        wait 0.05;
    }
    
    while ( level._num_ai_released > 2 )
    {
        println( "<dev string:x28>" );
        wait 0.05;
    }
    
    self stopanimscripted( 0.5 );
    level._num_ai_released++;
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xde44c5d0, Offset: 0xd88
// Size: 0x174
function _fake_red()
{
    prompt = newclienthudelem( self );
    prompt.alignx = "left";
    prompt.x = 0;
    prompt.y = 0;
    prompt.alignx = "left";
    prompt.aligny = "top";
    prompt.horzalign = "fullscreen";
    prompt.vertalign = "fullscreen";
    fadetime = 1;
    prompt.color = ( 0.2, 0, 0 );
    prompt.alpha = 0.7;
    prompt fadeovertime( fadetime );
    prompt.alpha = 0;
    prompt.shader = "white";
    prompt setshader( "white", 640, 480 );
    wait fadetime;
    prompt destroy();
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x5e278eb9, Offset: 0xf08
// Size: 0x22
function spear_trap_is_character_touching( char )
{
    return self istouching( char );
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x6ef7956b, Offset: 0xf38
// Size: 0xbc
function spear_activate( delay )
{
    wait delay;
    
    if ( isdefined( self.clip ) )
    {
        self.clip solid();
        self.clip clientfield::set( "spiketrap", 1 );
    }
    
    wait 2;
    
    if ( isdefined( self.clip ) )
    {
        self.clip notsolid();
        self.clip clientfield::set( "spiketrap", 0 );
    }
    
    wait 0.2;
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x2c0a4874, Offset: 0x1000
// Size: 0x94
function spear_kill( magnitude )
{
    self startragdoll();
    self launchragdoll( ( 0, 0, 50 ) );
    util::wait_network_frame();
    self.a.gib_ref = "head";
    self dodamage( self.health + 666, self.origin );
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xf0bf4a00, Offset: 0x10a0
// Size: 0x1be
function temple_trap_move_switch()
{
    trap_switch = undefined;
    
    for ( i = 0; i < self.trap_switches.size ; i++ )
    {
        trap_switch = self.trap_switches[ i ];
        trap_switch movey( -5, 0.75 );
    }
    
    if ( isdefined( trap_switch ) )
    {
        trap_switch playloopsound( "zmb_pressure_plate_loop" );
        trap_switch waittill( #"movedone" );
        trap_switch stoploopsound();
        trap_switch playsound( "zmb_pressure_plate_lock" );
    }
    
    self notify( #"switch_activated" );
    self waittill( #"trap_ready" );
    
    for ( i = 0; i < self.trap_switches.size ; i++ )
    {
        trap_switch = self.trap_switches[ i ];
        trap_switch movey( 5, 0.75 );
        trap_switch playloopsound( "zmb_pressure_plate_loop" );
        trap_switch waittill( #"movedone" );
        trap_switch stoploopsound();
        trap_switch playsound( "zmb_pressure_plate_lock" );
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x9bf923bd, Offset: 0x1268
// Size: 0x3c6
function waterfall_trap_init()
{
    usetriggers = getentarray( "waterfall_trap", "targetname" );
    
    for ( i = 0; i < usetriggers.size ; i++ )
    {
        trapstruct = spawnstruct();
        trapstruct.usetrigger = usetriggers[ i ];
        trapstruct.usetrigger sethintstring( &"ZOMBIE_NEED_POWER" );
        trapstruct.usetrigger setcursorhint( "HINT_NOICON" );
        trapstruct.trap_switches = [];
        trapstruct.trap_damage = [];
        trapstruct.trap_shake = [];
        trapstruct.water_drop_trigs = [];
        trapstruct.var_41f396e4 = [];
        targetents = getentarray( trapstruct.usetrigger.target, "targetname" );
        targetstructs = struct::get_array( trapstruct.usetrigger.target, "targetname" );
        targets = arraycombine( targetents, targetstructs, 1, 1 );
        
        for ( j = 0; j < targets.size ; j++ )
        {
            if ( !isdefined( targets[ j ].script_noteworthy ) )
            {
                continue;
            }
            
            switch ( targets[ j ].script_noteworthy )
            {
                case "trap_switch":
                    trapstruct.trap_switches[ trapstruct.trap_switches.size ] = targets[ j ];
                    break;
                case "trap_damage":
                    trapstruct.trap_damage[ trapstruct.trap_damage.size ] = targets[ j ];
                    break;
                case "trap_shake":
                    trapstruct.trap_shake[ trapstruct.trap_shake.size ] = targets[ j ];
                    break;
                case "water_drop_trigger":
                    targets[ j ] triggerenable( 0 );
                    trapstruct.water_drop_trigs[ trapstruct.water_drop_trigs.size ] = targets[ j ];
                    break;
                default:
                    targets[ j ] triggerenable( 0 );
                    trapstruct.var_41f396e4[ trapstruct.var_41f396e4.size ] = targets[ j ];
                    break;
            }
        }
        
        trapstruct.enable_flag = trapstruct.usetrigger.script_noteworthy;
        trapstruct waterfall_trap_think();
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xc5d45d1a, Offset: 0x1638
// Size: 0x228
function waterfall_trap_think()
{
    while ( true )
    {
        self notify( #"trap_ready" );
        self.usetrigger sethintstring( &"ZM_TEMPLE_USE_WATER_TRAP" );
        self.usetrigger waittill( #"trigger", who );
        
        if ( zombie_utility::is_player_valid( who ) && !who zm_utility::in_revive_trigger() )
        {
            who.used_waterfall = 1;
            self thread temple_trap_move_switch();
            self waittill( #"switch_activated" );
            self.usetrigger sethintstring( "" );
            waterfall_trap_on();
            wait 0.5;
            who.used_waterfall = 0;
            array::thread_all( self.trap_damage, &waterfall_trap_damage );
            activetime = 5.5;
            array::thread_all( self.var_41f396e4, &waterfall_screen_fx, activetime );
            self thread waterfall_screen_shake( activetime );
            wait activetime;
            self notify( #"trap_off" );
            self.usetrigger sethintstring( &"ZM_TEMPLE_WATER_TRAP_COOL" );
            array::thread_all( self.var_41f396e4, &function_a6e2b85f );
            waterfall_trap_off();
            array::notify_all( self.trap_damage, "trap_off" );
            wait 30;
        }
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x31ca6b67, Offset: 0x1868
// Size: 0x2a
function function_a6e2b85f()
{
    self triggerenable( 0 );
    self notify( #"waterfall_trap_off" );
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0xe8683894, Offset: 0x18a0
// Size: 0x6c
function waterfall_screen_fx( activetime )
{
    self.water_drop_time = 5;
    self.waterdrops = 1;
    self.watersheeting = 1;
    wait 1.5;
    self.watersheetingtime = activetime - 1.5;
    self thread function_b68fdf22();
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xa703da4b, Offset: 0x1918
// Size: 0x78
function function_b68fdf22()
{
    self endon( #"waterfall_trap_off" );
    self triggerenable( 1 );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            self thread function_5e706bd9( who );
        }
    }
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0xf89ce165, Offset: 0x1998
// Size: 0x94
function function_5e706bd9( player )
{
    player endon( #"disconnect" );
    self thread zm_temple_triggers::water_drop_trig_entered( player );
    
    while ( isdefined( player ) && player istouching( self ) && self istriggerenabled() )
    {
        wait 0.05;
    }
    
    self thread zm_temple_triggers::water_drop_trig_exit( player );
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x2977555e, Offset: 0x1a38
// Size: 0x6e
function waterfall_screen_shake( activetime )
{
    wait 1;
    
    for ( i = 0; i < self.trap_shake.size ; i++ )
    {
        waterfall_screen_shake_single( activetime, self.trap_shake[ i ].origin );
    }
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0xf0adabf5, Offset: 0x1ab0
// Size: 0xa2
function waterfall_screen_shake_single( activetime, origin )
{
    remainingtime = 1;
    
    if ( activetime > 6 )
    {
        remainingtime = activetime - 6;
    }
    
    while ( remainingtime > 0 )
    {
        earthquake( 0.14, activetime, origin, 400 );
        wait 1;
        remainingtime -= 1;
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x4ba2c357, Offset: 0x1b60
// Size: 0xc4
function waterfall_trap_on()
{
    soundstruct = struct::get( "waterfall_trap_origin", "targetname" );
    
    if ( isdefined( soundstruct ) )
    {
        playsoundatposition( "evt_waterfall_trap", soundstruct.origin );
    }
    
    level notify( #"waterfall" );
    level clientfield::set( "waterfall_trap", 1 );
    exploder::exploder( "fxexp_21" );
    exploder::stop_exploder( "fxexp_20" );
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x622a57f9, Offset: 0x1c30
// Size: 0x34
function waterfall_trap_off()
{
    exploder::exploder( "fxexp_20" );
    exploder::stop_exploder( "fxexp_21" );
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xed467420, Offset: 0x1c70
// Size: 0x1b0
function waterfall_trap_damage()
{
    self endon( #"trap_off" );
    fwd = anglestoforward( self.angles );
    zombies_knocked_down = [];
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            if ( isdefined( self.script_string ) && self.script_string == "hurt_player" )
            {
                who dodamage( 20, self.origin );
                wait 1;
            }
            else
            {
                who thread waterfall_trap_player( fwd, 5.45 );
            }
        }
        
        if ( isdefined( who.animname ) && who.animname == "monkey_zombie" )
        {
            who thread waterfall_trap_monkey( randomintrange( 30, 80 ), fwd );
            continue;
        }
        
        if ( !ent_in_array( who, zombies_knocked_down ) )
        {
            zombies_knocked_down[ zombies_knocked_down.size ] = who;
            util::wait_network_frame();
            who thread zombie_waterfall_knockdown( self );
        }
    }
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0x21997b1f, Offset: 0x1e28
// Size: 0x84
function waterfall_trap_player( fwd, time )
{
    wait 1;
    vel = self getvelocity();
    self setvelocity( vel + fwd * 60 );
    self playrumbleonentity( "slide_rumble" );
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0x10e036d8, Offset: 0x1eb8
// Size: 0x84
function waterfall_trap_monkey( magnitude, dir )
{
    wait 1;
    self startragdoll();
    self launchragdoll( dir * magnitude );
    util::wait_network_frame();
    self dodamage( self.health + 666, self.origin );
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0x5d0a9b5b, Offset: 0x1f48
// Size: 0x5a, Type: bool
function ent_in_array( ent, _array )
{
    for ( i = 0; i < _array.size ; i++ )
    {
        if ( _array[ i ] == ent )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x1bbee468, Offset: 0x1fb0
// Size: 0x5e4
function init_maze_trap()
{
    level.mazecells = [];
    level.mazefloors = [];
    level.mazewalls = [];
    level.mazepath = [];
    level.startcells = [];
    level.pathplayers = [];
    level.pathactive = 0;
    mazeclip = getent( "maze_path_clip", "targetname" );
    
    if ( isdefined( mazeclip ) )
    {
        mazeclip delete();
    }
    
    init_maze_paths();
    mazetriggers = getentarray( "maze_trigger", "targetname" );
    
    for ( i = 0; i < mazetriggers.size ; i++ )
    {
        mazetrigger = mazetriggers[ i ];
        mazetrigger.pathcount = 0;
        triggernum = mazetrigger.script_int;
        
        if ( !isdefined( triggernum ) )
        {
            continue;
        }
        
        _add_maze_cell( triggernum );
        level.mazecells[ triggernum - 1 ].trigger = mazetrigger;
        
        if ( isdefined( mazetrigger.script_string ) )
        {
            startcell = mazetrigger.script_string == "start";
            
            if ( startcell )
            {
                level.startcells[ level.startcells.size ] = level.mazecells[ triggernum - 1 ];
            }
        }
    }
    
    mazefloors = getentarray( "maze_floor", "targetname" );
    
    for ( i = 0; i < mazefloors.size ; i++ )
    {
        mazefloor = mazefloors[ i ];
        floornum = mazefloor.script_int;
        
        if ( !isdefined( floornum ) )
        {
            continue;
        }
        
        mazefloor init_maze_mover( 16, 0.25, 0.5, 0, "evt_maze_floor_up", "evt_maze_floor_up", 0 );
        level.mazecells[ floornum - 1 ].floor = mazefloor;
        level.mazefloors[ level.mazefloors.size ] = mazefloor;
    }
    
    mazewalls = getentarray( "maze_door", "targetname" );
    
    for ( i = 0; i < mazewalls.size ; i++ )
    {
        mazewall = mazewalls[ i ];
        wallnum = mazewall.script_int;
        
        if ( !isdefined( wallnum ) )
        {
            continue;
        }
        
        mazewall init_maze_mover( -128, 0.25, 1, 1, "evt_maze_wall_down", "evt_maze_wall_up", 1 );
        mazewall notsolid();
        mazewall connectpaths();
        mazewall.script_fxid = level._effect[ "maze_wall_impact" ];
        mazewall.var_f88b106c = level._effect[ "maze_wall_raise" ];
        mazewall.fx_active_offset = ( 0, 0, -60 );
        mazewall.adjacentcells = [];
        adjacent_cell_nums = [];
        adjacent_cell_nums[ 0 ] = wallnum % 100;
        adjacent_cell_nums[ 1 ] = int( ( wallnum - wallnum % 100 ) / 100 );
        
        for ( j = 0; j < adjacent_cell_nums.size ; j++ )
        {
            cell_num = adjacent_cell_nums[ j ];
            
            if ( cell_num == 0 )
            {
                continue;
            }
            
            mazecell = level.mazecells[ cell_num - 1 ];
            mazecell.walls[ mazecell.walls.size ] = mazewall;
            mazewall.adjacentcells[ mazewall.adjacentcells.size ] = mazecell;
        }
        
        level.mazewalls[ level.mazewalls.size ] = mazewall;
    }
    
    maze_show_starts();
    array::thread_all( level.mazecells, &maze_cell_watch );
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x4d3854a1, Offset: 0x25a0
// Size: 0x614
function init_maze_paths()
{
    level.mazepathcounter = 0;
    level.mazepaths = [];
    add_maze_path( array( 5, 4, 3 ) );
    add_maze_path( array( 5, 4, 1, 0, 3 ) );
    add_maze_path( array( 5, 4, 7, 6, 3 ) );
    add_maze_path( array( 5, 4, 3, 6, 9, 12 ) );
    add_maze_path( array( 5, 4, 7, 10, 11, 14, 13, 12 ) );
    add_maze_path( array( 5, 4, 1, 0, 3, 6, 9, 12 ) );
    add_maze_path( array( 5, 4, 7, 8 ), 1 );
    add_maze_path( array( 5, 4, 1, 0, 3, 6, 7, 8 ), 1 );
    add_maze_path( array( 3, 4, 7, 10, 13, 12 ) );
    add_maze_path( array( 3, 4, 5, 8, 7, 6, 9, 12 ) );
    add_maze_path( array( 3, 4, 1, 2, 5, 8, 11, 10, 9, 12 ) );
    add_maze_path( array( 3, 4, 5 ) );
    add_maze_path( array( 3, 4, 7, 6, 9, 10, 11, 8, 5 ) );
    add_maze_path( array( 3, 4, 1, 2, 5 ) );
    add_maze_path( array( 3, 4, 7, 6 ), 1 );
    add_maze_path( array( 3, 4, 1, 2, 5, 8, 7, 6 ), 1 );
    add_maze_path( array( 12, 9, 6, 3 ) );
    add_maze_path( array( 12, 9, 10, 7, 4, 3 ) );
    add_maze_path( array( 12, 9, 10, 13, 14, 11, 8, 5, 4, 3 ) );
    add_maze_path( array( 12, 9, 6, 3, 4, 5 ) );
    add_maze_path( array( 12, 9, 10, 11, 8, 7, 4, 5 ) );
    add_maze_path( array( 12, 9, 6, 3, 0, 1, 2, 5 ) );
    add_maze_path( array( 12, 9, 10, 13 ), 1 );
    add_maze_path( array( 12, 9, 6, 7, 10, 13 ), 1 );
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0x9dd3e1ea, Offset: 0x2bc0
// Size: 0x86
function add_maze_path( path, loopback )
{
    if ( !isdefined( loopback ) )
    {
        loopback = 0;
    }
    
    s = spawnstruct();
    s.path = path;
    s.loopback = loopback;
    level.mazepaths[ level.mazepaths.size ] = s;
}

// Namespace zm_temple_traps
// Params 7
// Checksum 0x2c4f2ef5, Offset: 0x2c50
// Size: 0x130
function init_maze_mover( movedist, moveuptime, movedowntime, blockspaths, moveupsound, movedownsound, cliponly )
{
    self.isactive = 0;
    self.activecount = 0;
    self.ismoving = 0;
    self.movedist = movedist;
    self.activeheight = self.origin[ 2 ] + movedist;
    self.moveuptime = moveuptime;
    self.movedowntime = movedowntime;
    self.pathblocker = blockspaths;
    self.alwaysactive = 0;
    self.moveupsound = moveupsound;
    self.movedownsound = movedownsound;
    self.startangles = self.angles;
    self.cliponly = cliponly;
    
    if ( isdefined( self.script_string ) && self.script_string == "always_active" )
    {
        maze_mover_active( 1 );
        self.alwaysactive = 1;
    }
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x84b928b4, Offset: 0x2d88
// Size: 0x7e
function _add_maze_cell( cell_index )
{
    for ( i = level.mazecells.size; i < cell_index ; i++ )
    {
        level.mazecells[ i ] = spawnstruct();
        level.mazecells[ i ] _init_maze_cell();
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x76efb1aa, Offset: 0x2e10
// Size: 0x20
function _init_maze_cell()
{
    self.trigger = undefined;
    self.floor = undefined;
    self.walls = [];
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x576addf7, Offset: 0x2e38
// Size: 0x2fc
function maze_mover_active( active )
{
    if ( self.alwaysactive )
    {
        return;
    }
    
    if ( active )
    {
        self.activecount++;
    }
    else
    {
        self.activecount = int( max( 0, self.activecount - 1 ) );
    }
    
    active = self.activecount > 0;
    
    if ( self.isactive == active )
    {
        return;
    }
    
    if ( active && isdefined( self.moveupsound ) )
    {
        self playsound( self.moveupsound );
    }
    
    if ( !active && isdefined( self.movedownsound ) )
    {
        self playsound( self.movedownsound );
    }
    
    goalpos = ( self.origin[ 0 ], self.origin[ 1 ], self.activeheight );
    
    if ( !active )
    {
        goalpos = ( goalpos[ 0 ], goalpos[ 1 ], goalpos[ 2 ] - self.movedist );
    }
    
    movetime = self.moveuptime;
    
    if ( !active )
    {
        movetime = self.movedowntime;
    }
    
    if ( self.ismoving )
    {
        currentz = self.origin[ 2 ];
        goalz = goalpos[ 2 ];
        ratio = abs( goalz - currentz ) / abs( self.movedist );
        movetime *= ratio;
    }
    
    self notify( #"stop_maze_mover" );
    self.isactive = active;
    
    if ( self.cliponly )
    {
        if ( active )
        {
            self solid();
            self disconnectpaths();
            self clientfield::set( "mazewall", 1 );
        }
        else
        {
            self notsolid();
            self connectpaths();
            self clientfield::set( "mazewall", 0 );
        }
        
        return;
    }
    
    self thread _maze_mover_move( goalpos, movetime );
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0x8e8d01e6, Offset: 0x3140
// Size: 0x10c
function _maze_mover_move( goal, time )
{
    self endon( #"stop_maze_mover" );
    self.ismoving = 1;
    
    if ( time == 0 )
    {
        time = 0.01;
    }
    
    self moveto( goal, time );
    self waittill( #"movedone" );
    self.ismoving = 0;
    
    if ( self.isactive )
    {
        _maze_mover_play_fx( self.script_fxid, self.fx_active_offset );
    }
    else
    {
        _maze_mover_play_fx( self.var_f88b106c, self.var_2f5c5654 );
    }
    
    if ( self.pathblocker )
    {
        if ( self.isactive )
        {
            self disconnectpaths();
            return;
        }
        
        self connectpaths();
    }
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0xe5b347d6, Offset: 0x3258
// Size: 0x94
function _maze_mover_play_fx( fx_name, offset )
{
    if ( isdefined( fx_name ) )
    {
        vfwd = anglestoforward( self.angles );
        org = self.origin;
        
        if ( isdefined( offset ) )
        {
            org += offset;
        }
        
        playfx( fx_name, org, vfwd, ( 0, 0, 1 ) );
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x60aa273c, Offset: 0x32f8
// Size: 0x1d0
function maze_cell_watch()
{
    level endon( #"fake_death" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", who );
        
        if ( self.trigger.pathcount > 0 )
        {
            if ( isplayer( who ) )
            {
                if ( who is_player_maze_slow() )
                {
                    continue;
                }
                
                if ( who.sessionstate == "spectator" )
                {
                    continue;
                }
                
                self thread maze_cell_player_enter( who );
            }
            else if ( isdefined( who.animname ) && who.animname == "zombie" )
            {
                self.trigger thread zombie_normal_trigger_exit( who );
            }
            
            continue;
        }
        
        if ( isplayer( who ) )
        {
            if ( who is_player_on_path() )
            {
                continue;
            }
            
            if ( who.sessionstate == "spectator" )
            {
                continue;
            }
            
            self.trigger thread watch_slow_trigger_exit( who );
            continue;
        }
        
        if ( isdefined( who.animname ) && who.animname == "zombie" )
        {
            self.trigger thread zombie_slow_trigger_exit( who );
        }
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xd45db5d9, Offset: 0x34d0
// Size: 0x76
function zombie_mud_move_slow()
{
    self.var_5526feb3 = self.zombie_move_speed;
    
    switch ( self.zombie_move_speed )
    {
        case "run":
            self zombie_utility::set_zombie_run_cycle( "walk" );
            break;
        default:
            self zombie_utility::set_zombie_run_cycle( "run" );
            break;
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x7d5fe3aa, Offset: 0x3550
// Size: 0x24
function zombie_mud_move_normal()
{
    self zombie_utility::set_zombie_run_cycle( self.var_5526feb3 );
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x150a26e6, Offset: 0x3580
// Size: 0x154
function zombie_slow_trigger_exit( zombie )
{
    zombie endon( #"death" );
    
    if ( isdefined( zombie.mud_triggers ) )
    {
        if ( is_in_array( zombie.mud_triggers, self ) )
        {
            return;
        }
    }
    else
    {
        zombie.mud_triggers = [];
    }
    
    if ( !zombie zombie_on_mud() )
    {
        zombie zombie_mud_move_slow();
    }
    
    zombie.mud_triggers[ zombie.mud_triggers.size ] = self;
    
    while ( self.pathcount == 0 && zombie istouching( self ) )
    {
        wait 0.1;
    }
    
    arrayremovevalue( zombie.mud_triggers, self );
    
    if ( !zombie zombie_on_mud() && !zombie zombie_on_path() )
    {
        zombie zombie_mud_move_normal();
    }
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0x9ec19cb9, Offset: 0x36e0
// Size: 0x98, Type: bool
function is_in_array( array, item )
{
    foreach ( index in array )
    {
        if ( index == item )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x3f2644f3, Offset: 0x3780
// Size: 0x1c, Type: bool
function zombie_on_path()
{
    return isdefined( self.path_triggers ) && self.path_triggers.size > 0;
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x8a43c486, Offset: 0x37a8
// Size: 0x1c, Type: bool
function zombie_on_mud()
{
    return isdefined( self.mud_triggers ) && self.mud_triggers.size > 0;
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x9b9293cf, Offset: 0x37d0
// Size: 0x10c
function zombie_normal_trigger_exit( zombie )
{
    zombie endon( #"death" );
    
    if ( isdefined( zombie.path_triggers ) )
    {
        if ( is_in_array( zombie.path_triggers, self ) )
        {
            return;
        }
    }
    else
    {
        zombie.path_triggers = [];
    }
    
    if ( !zombie zombie_on_path() )
    {
        zombie zombie_mud_move_normal();
    }
    
    zombie.path_triggers[ zombie.path_triggers.size ] = self;
    
    while ( self.pathcount != 0 && zombie istouching( self ) )
    {
        wait 0.1;
    }
    
    arrayremovevalue( zombie.path_triggers, self );
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x43c04cb0, Offset: 0x38e8
// Size: 0x1c, Type: bool
function is_player_on_path()
{
    return isdefined( self.mazepathcells ) && self.mazepathcells.size > 0;
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xfee74f4b, Offset: 0x3910
// Size: 0x1c, Type: bool
function is_player_maze_slow()
{
    return isdefined( self.mazeslowtrigger ) && self.mazeslowtrigger.size > 0;
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0xb7f6391d, Offset: 0x3938
// Size: 0x1e4
function maze_cell_player_enter( player )
{
    if ( isdefined( player.mazepathcells ) )
    {
        if ( is_in_array( player.mazepathcells, self ) )
        {
            return;
        }
    }
    else
    {
        player.mazepathcells = [];
    }
    
    if ( !is_in_array( level.pathplayers, player ) )
    {
        level.pathplayers[ level.pathplayers.size ] = player;
    }
    
    player.mazepathcells[ player.mazepathcells.size ] = self;
    
    if ( !level.pathactive )
    {
        self maze_start_path();
    }
    
    on_maze_cell_enter();
    self path_trigger_wait( player );
    isplayervalid = isdefined( player );
    
    if ( isplayervalid )
    {
        arrayremovevalue( player.mazepathcells, self );
    }
    
    if ( !isplayervalid || !player is_player_on_path() )
    {
        level.pathplayers = array::remove_undefined( level.pathplayers );
        
        if ( isplayervalid )
        {
            arrayremovevalue( level.pathplayers, player );
        }
        
        if ( level.pathplayers.size == 0 )
        {
            maze_end_path();
        }
    }
    
    on_maze_cell_exit();
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0xc3aff33e, Offset: 0x3b28
// Size: 0x94
function path_trigger_wait( player )
{
    player endon( #"disconnect" );
    player endon( #"fake_death" );
    player endon( #"death" );
    level endon( #"maze_timer_end" );
    
    while ( self.trigger.pathcount != 0 && player istouching( self.trigger ) && player.sessionstate != "spectator" )
    {
        wait 0.1;
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x1f8abc2b, Offset: 0x3bc8
// Size: 0xe4
function on_maze_cell_enter()
{
    current = self;
    previous = current cell_get_previous();
    next = current cell_get_next();
    raise_floor( previous );
    raise_floor( current );
    raise_floor( next );
    activate_walls( previous );
    activate_walls( current );
    activate_walls( next );
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xdb8309e9, Offset: 0x3cb8
// Size: 0xe4
function on_maze_cell_exit()
{
    current = self;
    previous = current cell_get_previous();
    next = current cell_get_next();
    lower_floor( previous );
    lower_floor( current );
    lower_floor( next );
    lower_walls( previous );
    lower_walls( current );
    lower_walls( next );
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x105359c1, Offset: 0x3da8
// Size: 0x234
function watch_slow_trigger_exit( player )
{
    player endon( #"death" );
    player endon( #"fake_death" );
    player endon( #"disconnect" );
    player allowjump( 0 );
    
    if ( isdefined( player.mazeslowtrigger ) )
    {
        if ( is_in_array( player.mazeslowtrigger, self ) )
        {
            return;
        }
    }
    else
    {
        player.mazeslowtrigger = [];
    }
    
    if ( !player is_player_maze_slow() )
    {
        player allowsprint( 0 );
        player allowprone( 0 );
        player allowslide( 0 );
        player setmovespeedscale( 0.35 );
    }
    
    player.mazeslowtrigger[ player.mazeslowtrigger.size ] = self;
    
    while ( self.pathcount == 0 && player istouching( self ) )
    {
        wait 0.1;
    }
    
    arrayremovevalue( player.mazeslowtrigger, self );
    
    if ( !player is_player_maze_slow() )
    {
        player allowjump( 1 );
        player allowsprint( 1 );
        player allowprone( 1 );
        player allowslide( 1 );
        player setmovespeedscale( 1 );
    }
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0xa8632b77, Offset: 0x3fe8
// Size: 0x86
function lower_walls( cell )
{
    if ( !isdefined( cell ) )
    {
        return;
    }
    
    for ( i = 0; i < cell.walls.size ; i++ )
    {
        wall = cell.walls[ i ];
        wall thread maze_mover_active( 0 );
    }
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x72f22d4e, Offset: 0x4078
// Size: 0x1ae
function activate_walls( cell )
{
    if ( !isdefined( cell ) )
    {
        return;
    }
    
    previous = cell cell_get_previous();
    next = cell cell_get_next();
    previoussharedwall = maze_cells_get_shared_wall( previous, cell );
    nextsharedwall = maze_cells_get_shared_wall( cell, next );
    
    for ( i = 0; i < cell.walls.size ; i++ )
    {
        wall = cell.walls[ i ];
        activatewall = 1;
        
        if ( !isdefined( next ) && ( !isdefined( previous ) && ( isdefined( nextsharedwall ) && ( isdefined( previoussharedwall ) && wall == previoussharedwall || wall == nextsharedwall ) || wall.adjacentcells.size == 1 ) || wall.adjacentcells.size == 1 ) )
        {
            activatewall = 0;
        }
        
        wall thread maze_mover_active( activatewall );
    }
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0xdf1965be, Offset: 0x4230
// Size: 0x64
function raise_floor( mazecell )
{
    if ( isdefined( mazecell ) )
    {
        mazecell.trigger.pathcount++;
        mazecell.floor thread maze_mover_active( 1 );
        level thread delete_cell_corpses( mazecell );
    }
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0xca66184b, Offset: 0x42a0
// Size: 0xee
function delete_cell_corpses( mazecell )
{
    bodies = getcorpsearray();
    
    for ( i = 0; i < bodies.size ; i++ )
    {
        if ( !isdefined( bodies[ i ] ) )
        {
            continue;
        }
        
        if ( bodies[ i ] istouching( mazecell.trigger ) || bodies[ i ] istouching( mazecell.floor ) )
        {
            bodies[ i ] thread delete_corpse();
            util::wait_network_frame();
        }
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x204a83ff, Offset: 0x4398
// Size: 0x5c
function delete_corpse()
{
    self endon( #"death" );
    playfx( level._effect[ "animscript_gib_fx" ], self.origin );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0xd4ae6023, Offset: 0x4400
// Size: 0x4c
function lower_floor( mazecell )
{
    if ( isdefined( mazecell ) )
    {
        mazecell.trigger.pathcount--;
        mazecell.floor thread maze_mover_active( 0 );
    }
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0x5ea5e89a, Offset: 0x4458
// Size: 0xd8
function maze_cells_get_shared_wall( a, b )
{
    if ( !isdefined( a ) || !isdefined( b ) )
    {
        return undefined;
    }
    
    for ( i = 0; i < a.walls.size ; i++ )
    {
        for ( j = 0; j < b.walls.size ; j++ )
        {
            if ( a.walls[ i ] == b.walls[ j ] )
            {
                return a.walls[ i ];
            }
        }
    }
    
    return undefined;
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x40273d55, Offset: 0x4538
// Size: 0x4e
function maze_show_starts()
{
    for ( i = 0; i < level.startcells.size ; i++ )
    {
        raise_floor( level.startcells[ i ] );
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x3ff346c7, Offset: 0x4590
// Size: 0x8c
function maze_start_path()
{
    level.pathactive = 1;
    
    for ( i = 0; i < level.startcells.size ; i++ )
    {
        lower_floor( level.startcells[ i ] );
    }
    
    self maze_generate_path();
    level thread maze_path_timer( 10 );
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x44bc1800, Offset: 0x4628
// Size: 0x34
function maze_end_path()
{
    level notify( #"maze_path_end" );
    level.pathactive = 0;
    level thread maze_show_starts_delayed();
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x5641cffb, Offset: 0x4668
// Size: 0x24
function maze_show_starts_delayed()
{
    level endon( #"maze_all_safe" );
    wait 3;
    maze_show_starts();
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x7ab7cb61, Offset: 0x4698
// Size: 0x94
function maze_path_timer( time )
{
    level endon( #"maze_path_end" );
    level endon( #"maze_all_safe" );
    vibratetime = 3;
    wait time - vibratetime;
    level thread maze_vibrate_floor_stop();
    level thread maze_vibrate_active_floors( vibratetime );
    wait vibratetime;
    level notify( #"maze_timer_end" );
    level thread repath_zombies_in_maze();
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xdbd45999, Offset: 0x4738
// Size: 0x12a
function repath_zombies_in_maze()
{
    util::wait_network_frame();
    zombies = getaiteamarray( level.zombie_team );
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        zombie = zombies[ i ];
        
        if ( !isdefined( zombie ) )
        {
            continue;
        }
        
        if ( !isdefined( zombie.animname ) || zombie.animname == "monkey_zombie" )
        {
            continue;
        }
        
        if ( zombie zombie_on_path() || zombie zombie_on_mud() )
        {
            zombie notify( #"stop_find_flesh" );
            zombie notify( #"zombie_acquire_enemy" );
            util::wait_network_frame();
            zombie.ai_state = "find_flesh";
        }
    }
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x91b2b69b, Offset: 0x4870
// Size: 0x19c
function maze_vibrate_active_floors( time )
{
    level endon( #"maze_path_end" );
    level endon( #"maze_all_safe" );
    endtime = gettime() + time * 1000;
    
    while ( endtime > gettime() )
    {
        for ( i = 0; i < level.mazecells.size ; i++ )
        {
            cell = level.mazecells[ i ];
            
            if ( cell.floor.isactive )
            {
                cell thread maze_vibrate_floor( ( endtime - gettime() ) / 1000 );
                players = getplayers();
                
                for ( w = 0; w < players.size ; w++ )
                {
                    if ( players[ w ] istouching( cell.trigger ) )
                    {
                        cell.trigger thread trigger::function_thread( players[ w ], &temple_maze_player_vibrate_on, &temple_maze_player_vibrate_off );
                    }
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0xf621a88e, Offset: 0x4a18
// Size: 0x74
function temple_maze_player_vibrate_on( player, endon_condition )
{
    if ( isdefined( endon_condition ) )
    {
        player endon( endon_condition );
    }
    
    player clientfield::set_to_player( "floorrumble", 1 );
    util::wait_network_frame();
    self thread temple_inactive_floor_rumble_cancel( player );
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0xe4646f47, Offset: 0x4a98
// Size: 0x44
function temple_maze_player_vibrate_off( player )
{
    player endon( #"frc" );
    player clientfield::set_to_player( "floorrumble", 0 );
    player notify( #"frc" );
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x917f4bd2, Offset: 0x4ae8
// Size: 0x11c
function temple_inactive_floor_rumble_cancel( ent_player )
{
    ent_player endon( #"frc" );
    floor_piece = undefined;
    maze_floor_array = getentarray( "maze_floor", "targetname" );
    
    for ( i = 0; i < maze_floor_array.size ; i++ )
    {
        if ( maze_floor_array[ i ].script_int == self.script_int )
        {
            floor_piece = maze_floor_array[ i ];
        }
    }
    
    while ( isdefined( floor_piece ) && floor_piece.isactive == 1 )
    {
        wait 0.05;
    }
    
    if ( isdefined( ent_player ) )
    {
        ent_player clientfield::set_to_player( "floorrumble", 0 );
    }
    
    ent_player notify( #"frc" );
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0xfb5a4b6f, Offset: 0x4c10
// Size: 0xd4
function maze_vibrate_floor( time )
{
    if ( isdefined( self.isvibrating ) && self.isvibrating )
    {
        return;
    }
    
    self.floor playsound( "evt_maze_floor_collapse" );
    self.isvibrating = 1;
    dir = ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), 0 );
    self.floor vibrate( dir, 0.75, 0.3, time );
    wait time;
    self.isvibrating = 0;
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x84ad0f6b, Offset: 0x4cf0
// Size: 0x126
function maze_vibrate_floor_stop()
{
    level util::waittill_any( "maze_path_end", "maze_timer_end", "maze_all_safe" );
    
    for ( i = 0; i < level.mazecells.size ; i++ )
    {
        cell = level.mazecells[ i ];
        
        if ( isdefined( cell.isvibrating ) && cell.isvibrating )
        {
            cell.floor vibrate( ( 0, 0, 1 ), 1, 1, 0.05 );
            cell.floor rotateto( cell.floor.startangles, 0.1 );
            cell.floor stopsounds();
        }
    }
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0xa5545057, Offset: 0x4e20
// Size: 0x134
function maze_generate_path()
{
    level.mazepath = [];
    
    for ( i = 0; i < level.mazecells.size ; i++ )
    {
        level.mazecells[ i ].pathindex = -1;
    }
    
    path_index = self pick_random_path_index();
    path = level.mazepaths[ path_index ].path;
    level.mazepathlaststart = path[ 0 ];
    level.mazepathlastend = path[ path.size - 1 ];
    
    for ( i = 0; i < path.size ; i++ )
    {
        level.mazepath[ i ] = level.mazecells[ path[ i ] ];
        level.mazepath[ i ].pathindex = i;
    }
    
    level.mazepathcounter++;
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x5769542e, Offset: 0x4f60
// Size: 0x1f4
function pick_random_path_index()
{
    startindex = 0;
    
    for ( i = 0; i < level.mazecells.size ; i++ )
    {
        if ( level.mazecells[ i ] == self )
        {
            startindex = i;
            break;
        }
    }
    
    path_indexes = [];
    
    for ( i = 0; i < level.mazepaths.size ; i++ )
    {
        path_indexes[ i ] = i;
    }
    
    path_indexes = array::randomize( path_indexes );
    returnindex = -1;
    
    for ( i = 0; i < path_indexes.size ; i++ )
    {
        index = path_indexes[ i ];
        path = level.mazepaths[ index ].path;
        
        if ( level.mazepaths[ index ].loopback )
        {
            if ( level.mazepathcounter < 3 )
            {
                continue;
            }
            
            if ( randomfloat( 100 ) > 40 )
            {
                continue;
            }
        }
        
        if ( isdefined( level.mazepathlaststart ) && isdefined( level.mazepathlastend ) )
        {
            if ( level.mazepathlaststart == path[ 0 ] && level.mazepathlastend == path[ path.size - 1 ] )
            {
                continue;
            }
        }
        
        if ( startindex == path[ 0 ] )
        {
            returnindex = index;
            break;
        }
    }
    
    return returnindex;
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x2acca835, Offset: 0x5160
// Size: 0x48
function cell_get_next()
{
    index = self.pathindex;
    
    if ( index < level.mazepath.size - 1 )
    {
        return level.mazepath[ index + 1 ];
    }
    
    return undefined;
}

// Namespace zm_temple_traps
// Params 0
// Checksum 0x5dd35934, Offset: 0x51b0
// Size: 0x3c
function cell_get_previous()
{
    index = self.pathindex;
    
    if ( index > 0 )
    {
        return level.mazepath[ index - 1 ];
    }
    
    return undefined;
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x8deeeeea, Offset: 0x51f8
// Size: 0x44
function zombie_waterfall_knockdown( entity )
{
    self endon( #"death" );
    self.lander_knockdown = 1;
    wait 1.25;
    self zombie_utility::setup_zombie_knockdown( entity );
}

// Namespace zm_temple_traps
// Params 2
// Checksum 0x3a438bc1, Offset: 0x5248
// Size: 0x9c
function override_thundergun_damage_func( player, gib )
{
    dmg_point = struct::get( "waterfall_dmg_point", "script_noteworthy" );
    self.thundergun_handle_pain_notetracks = &handle_knockdown_pain_notetracks;
    self dodamage( 1, dmg_point.origin );
    self animcustom( &zm_weap_thundergun::playthundergunpainanim );
}

// Namespace zm_temple_traps
// Params 1
// Checksum 0x3d0337cf, Offset: 0x52f0
// Size: 0xc
function handle_knockdown_pain_notetracks( note )
{
    
}

