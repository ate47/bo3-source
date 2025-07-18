#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/name_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_zod_train;
#using scripts/zm/zm_zod_vo;

#namespace zm_zod_robot;

// Namespace zm_zod_robot
// Params 0, eflags: 0x2
// Checksum 0xd19e6e35, Offset: 0x6e8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_zod_robot", &__init__, undefined, undefined );
}

// Namespace zm_zod_robot
// Params 0
// Checksum 0x8e4ffc, Offset: 0x728
// Size: 0x64
function __init__()
{
    clientfield::register( "scriptmover", "robot_switch", 1, 1, "int" );
    clientfield::register( "world", "robot_lights", 1, 2, "int" );
}

// Namespace zm_zod_robot
// Params 0
// Checksum 0xd397fbb1, Offset: 0x798
// Size: 0x274
function init()
{
    level flag::init( "police_box_ready" );
    level flag::init( "police_box_in_use" );
    level flag::init( "police_box_hide" );
    level.ai_robot_remaining_cost = 2000;
    level flag::wait_till( "initial_blackscreen_passed" );
    zombie_utility::add_zombie_gib_weapon_callback( "ar_standard_companion", &gib_check, &gib_head_check );
    level.zombie_robot_spawners = getentarray( "zombie_robot_spawner", "script_noteworthy" );
    level.var_c1b7d765 = getentarray( "zombie_robot_gold_spawner", "script_noteworthy" );
    a_e_triggers = getentarray( "robot_activate_trig", "targetname" );
    level.a_robot_areanames = array( "junction", "slums", "canal", "theater" );
    
    foreach ( str_areaname in level.a_robot_areanames )
    {
        create_callbox_unitrigger( str_areaname, &robot_callbox_trigger_visibility, &robot_callbox_trigger_think );
    }
    
    level thread monitor_robot_power();
    level thread function_63fe1ddd();
    level thread update_readouts_for_remaining_robot_cost();
    
    /#
        level thread function_33a20979();
    #/
}

// Namespace zm_zod_robot
// Params 0
// Checksum 0xf6bcaca, Offset: 0xa18
// Size: 0xd0
function function_63fe1ddd()
{
    level endon( #"_zombie_game_over" );
    level flag::wait_till( "police_box_ready" );
    
    while ( true )
    {
        level clientfield::set( "robot_lights", 1 );
        level waittill( #"hash_421e5b59" );
        level clientfield::set( "robot_lights", 2 );
        level waittill( #"hash_10a36fa2" );
        level clientfield::set( "robot_lights", 3 );
        
        while ( isdefined( level.ai_robot ) )
        {
            wait 0.05;
        }
    }
}

// Namespace zm_zod_robot
// Params 0
// Checksum 0xfea27e6a, Offset: 0xaf0
// Size: 0xdc
function monitor_robot_power()
{
    level waittill( #"hash_5b9acfd8" );
    level flag::set( "police_box_ready" );
    var_6f73bd35 = getent( "police_box", "targetname" );
    
    if ( isdefined( var_6f73bd35 ) )
    {
        var_6f73bd35 playsound( "zmb_bm_interaction_machine_start" );
    }
    
    e_player = zm_utility::get_closest_player( var_6f73bd35.origin );
    e_player zm_zod_vo::function_81ba60e2();
    var_6f73bd35 clientfield::set( "robot_switch", 1 );
}

/#

    // Namespace zm_zod_robot
    // Params 0
    // Checksum 0xa319764b, Offset: 0xbd8
    // Size: 0x34, Type: dev
    function function_33a20979()
    {
        level waittill( #"open_sesame" );
        level flag::set( "<dev string:x28>" );
    }

#/

// Namespace zm_zod_robot
// Params 3
// Checksum 0x7d576df, Offset: 0xc18
// Size: 0x1ec
function create_callbox_unitrigger( str_areaname, func_trigger_visibility, func_trigger_thread )
{
    width = 110;
    height = 90;
    length = 110;
    s_callbox = struct::get( "robot_callbox_" + str_areaname, "script_noteworthy" );
    s_callbox.unitrigger_stub = spawnstruct();
    s_callbox.unitrigger_stub.origin = s_callbox.origin;
    s_callbox.unitrigger_stub.angles = s_callbox.angles;
    s_callbox.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_callbox.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_callbox.unitrigger_stub.script_width = width;
    s_callbox.unitrigger_stub.script_height = height;
    s_callbox.unitrigger_stub.script_length = length;
    s_callbox.unitrigger_stub.require_look_at = 0;
    s_callbox.unitrigger_stub.str_areaname = str_areaname;
    s_callbox.unitrigger_stub.prompt_and_visibility_func = func_trigger_visibility;
    zm_unitrigger::register_static_unitrigger( s_callbox.unitrigger_stub, func_trigger_thread );
}

// Namespace zm_zod_robot
// Params 1
// Checksum 0x2f2db86e, Offset: 0xe10
// Size: 0x1ca, Type: bool
function robot_callbox_trigger_visibility( player )
{
    b_is_invis = isdefined( player.beastmode ) && player.beastmode || level flag::get( "police_box_hide" );
    self setinvisibletoplayer( player, b_is_invis );
    
    if ( !level flag::get( "police_box_ready" ) )
    {
        self sethintstring( &"ZM_ZOD_ROBOT_NEEDS_POWER" );
    }
    else if ( isdefined( level.ai_robot ) )
    {
        switch ( level.ai_robot_area_called )
        {
            case "junction":
                hintstring_areaname = &"ZM_ZOD_AREA_NAME_JUNCTION";
                break;
            case "slums":
                hintstring_areaname = &"ZM_ZOD_AREA_NAME_SLUMS";
                break;
            case "canal":
                hintstring_areaname = &"ZM_ZOD_AREA_NAME_CANAL";
                break;
            default:
                hintstring_areaname = &"ZM_ZOD_AREA_NAME_THEATER";
                break;
        }
        
        self sethintstring( &"ZM_ZOD_ROBOT_ONCALL_IN", hintstring_areaname );
    }
    else if ( player.score < level.ai_robot_remaining_cost )
    {
        self sethintstring( &"ZM_ZOD_ROBOT_PAY_TOWARDS" );
    }
    else
    {
        self sethintstring( &"ZM_ZOD_ROBOT_SUMMON" );
    }
    
    return !b_is_invis;
}

// Namespace zm_zod_robot
// Params 0
// Checksum 0x4f19bdda, Offset: 0xfe8
// Size: 0x2c8
function robot_callbox_trigger_think()
{
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( player zm_utility::in_revive_trigger() )
        {
            continue;
        }
        
        if ( player.is_drinking > 0 )
        {
            continue;
        }
        
        if ( !zm_utility::is_player_valid( player ) )
        {
            continue;
        }
        
        if ( isdefined( level.ai_robot ) )
        {
            continue;
        }
        
        if ( level flag::get( "police_box_ready" ) !== 1 )
        {
            continue;
        }
        
        if ( level flag::get( "police_box_in_use" ) )
        {
            continue;
        }
        
        if ( !player zm_score::can_player_purchase( level.ai_robot_remaining_cost ) )
        {
            level.ai_robot_remaining_cost -= player.score;
            player zm_score::minus_to_player_score( player.score );
            self.stub zm_unitrigger::run_visibility_function_for_all_triggers();
            level thread update_readouts_for_remaining_robot_cost();
            continue;
        }
        
        level flag::set( "police_box_in_use" );
        self sethintstring( "" );
        player zm_score::minus_to_player_score( level.ai_robot_remaining_cost );
        
        if ( !player bgb::is_enabled( "zm_bgb_shopping_free" ) )
        {
            level.ai_robot_remaining_cost = 0;
            level thread update_readouts_for_remaining_robot_cost();
        }
        
        n_spawn_delay = 3;
        level thread spawn_robot( player, self.stub, n_spawn_delay );
        player notify( #"hash_b7f8e77c" );
        level notify( #"hash_421e5b59" );
        level thread function_f9a6039c( self, "activated" );
        self playsound( "evt_police_box_siren" );
        wait 1.5;
        player zm_audio::create_and_play_dialog( "robot", "activate" );
    }
}

// Namespace zm_zod_robot
// Params 3
// Checksum 0x2df3cee5, Offset: 0x12b8
// Size: 0x66c
function spawn_robot( player, trig_stub, n_spawn_delay )
{
    a_s_start_pos = struct::get_array( "robot_start_pos", "targetname" );
    a_s_start_pos = array::filter( a_s_start_pos, 0, &filter_callbox_name, trig_stub.str_areaname );
    robot_start_pos = a_s_start_pos[ 0 ];
    trace = bullettrace( robot_start_pos.origin, robot_start_pos.origin + ( 0, 0, -256 ), 0, robot_start_pos );
    v_ground_position = trace[ "position" ];
    var_36e9b69a = v_ground_position + ( 0, 0, 650 );
    level thread function_70541dc1( v_ground_position );
    
    if ( isdefined( n_spawn_delay ) )
    {
        wait n_spawn_delay;
    }
    
    if ( level flag::get( "ee_complete" ) )
    {
        spawner = level.var_c1b7d765[ 0 ];
    }
    else
    {
        spawner = level.zombie_robot_spawners[ 0 ];
    }
    
    level.ai_robot = spawner spawnfromspawner( "companion_spawner", 1 );
    level.ai_robot.maxhealth = level.ai_robot.health;
    level.ai_robot.allow_zombie_to_target_ai = 0;
    level.ai_robot.on_train = 0;
    level.ai_robot.can_gib_zombies = 1;
    level.ai_robot setcandamage( 0 );
    level.ai_robot_area_called = trig_stub.str_areaname;
    trig_stub zm_unitrigger::run_visibility_function_for_all_triggers();
    level.ai_robot.time_expired = 0;
    level.ai_robot playloopsound( "fly_civil_protector_loop" );
    level.var_bfd9ed83 = player;
    
    foreach ( player in level.players )
    {
        player setperk( "specialty_pistoldeath" );
    }
    
    if ( isdefined( level.ai_robot ) )
    {
        level.ai_robot forceteleport( var_36e9b69a );
        level.ai_robot thread function_ab4d9ece( v_ground_position, player );
        level.ai_robot scene::play( "cin_zod_robot_companion_entrance" );
        level notify( #"hash_10a36fa2" );
        level.ai_robot.companion_anchor_point = v_ground_position;
    }
    
    level thread function_f9a6039c( level.ai_robot, "active", 2 );
    level.ai_robot thread function_be60a9fd();
    level.ai_robot thread function_677061ac();
    level flag::clear( "police_box_in_use" );
    function_490cbdf5();
    level.ai_robot.time_expired = 1;
    
    while ( level.ai_robot.reviving_a_player == 1 )
    {
        wait 0.05;
    }
    
    foreach ( player in level.players )
    {
        player unsetperk( "specialty_pistoldeath" );
    }
    
    level.ai_robot setcandamage( 1 );
    
    if ( isdefined( level.o_zod_train ) )
    {
        if ( [[ level.o_zod_train ]]->is_touching_train_volume( level.ai_robot ) )
        {
            level.ai_robot linkto( [[ level.o_zod_train ]]->get_train_vehicle() );
        }
    }
    
    level.ai_robot scene::play( "cin_zod_robot_companion_exit_death" );
    level.ai_robot = undefined;
    players = getplayers();
    
    if ( players.size != 1 || !level flag::get( "solo_game" ) || !( isdefined( players[ 0 ].waiting_to_revive ) && players[ 0 ].waiting_to_revive ) )
    {
        level zm::checkforalldead();
    }
    
    level.ai_robot_remaining_cost = 2000;
    trig_stub zm_unitrigger::run_visibility_function_for_all_triggers();
    level thread update_readouts_for_remaining_robot_cost();
}

// Namespace zm_zod_robot
// Params 0
// Checksum 0x53ab88ba, Offset: 0x1930
// Size: 0x14
function function_490cbdf5()
{
    level endon( #"hash_223edfde" );
    wait 120;
}

// Namespace zm_zod_robot
// Params 2
// Checksum 0x6967b721, Offset: 0x1950
// Size: 0x176
function function_ab4d9ece( var_21e230b7, e_player )
{
    level.ai_robot thread robot_sky_trail();
    wait 0.5;
    earthquake( 0.55, 1.2, var_21e230b7, 1200 );
    playfx( level._effect[ "robot_landing" ], var_21e230b7 );
    level thread function_fa1df614( var_21e230b7, undefined, 350 );
    var_329d5820 = 5;
    
    for ( i = 0; i < var_329d5820 ; i++ )
    {
        foreach ( player in level.players )
        {
            player playrumbleonentity( "damage_heavy" );
        }
        
        wait 0.1;
    }
}

// Namespace zm_zod_robot
// Params 0
// Checksum 0x89c3793, Offset: 0x1ad0
// Size: 0xb4
function robot_sky_trail()
{
    var_8d888091 = spawn( "script_model", self.origin );
    var_8d888091 setmodel( "tag_origin" );
    playfxontag( level._effect[ "robot_sky_trail" ], var_8d888091, "tag_origin" );
    var_8d888091 linkto( self );
    level waittill( #"hash_10a36fa2" );
    var_8d888091 delete();
}

// Namespace zm_zod_robot
// Params 1
// Checksum 0xf29419bf, Offset: 0x1b90
// Size: 0xa4
function function_70541dc1( v_ground_position )
{
    var_b47822ca = spawn( "script_model", v_ground_position );
    var_b47822ca setmodel( "tag_origin" );
    playfxontag( level._effect[ "robot_ground_spawn" ], var_b47822ca, "tag_origin" );
    level waittill( #"hash_10a36fa2" );
    var_b47822ca delete();
}

// Namespace zm_zod_robot
// Params 3
// Checksum 0xdefd340f, Offset: 0x1c40
// Size: 0x2ba
function function_fa1df614( v_origin, eattacker, n_radius )
{
    team = "axis";
    
    if ( isdefined( level.zombie_team ) )
    {
        team = level.zombie_team;
    }
    
    a_ai_zombies = array::get_all_closest( v_origin, getaiteamarray( team ), undefined, undefined, n_radius );
    
    foreach ( ai_zombie in a_ai_zombies )
    {
        if ( isdefined( eattacker ) )
        {
            ai_zombie dodamage( ai_zombie.health + 10000, ai_zombie.origin, eattacker );
        }
        else
        {
            ai_zombie dodamage( ai_zombie.health + 10000, ai_zombie.origin );
        }
        
        n_radius_sqr = n_radius * n_radius;
        n_distance_sqr = distancesquared( ai_zombie.origin, v_origin );
        n_dist_mult = n_distance_sqr / n_radius_sqr;
        v_fling = ai_zombie.origin - v_origin;
        v_fling += ( 0, 0, 15 );
        v_fling = vectornormalize( v_fling );
        n_size = 50 + 20 * n_dist_mult;
        v_fling = ( v_fling[ 0 ], v_fling[ 1 ], abs( v_fling[ 2 ] ) );
        v_fling = vectorscale( v_fling, n_size );
        ai_zombie startragdoll();
        ai_zombie launchragdoll( v_fling );
    }
}

// Namespace zm_zod_robot
// Params 2
// Checksum 0xc9b003f5, Offset: 0x1f08
// Size: 0x48, Type: bool
function filter_callbox_name( e_entity, str_areaname )
{
    if ( !isdefined( e_entity.script_string ) || e_entity.script_string != str_areaname )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_zod_robot
// Params 0
// Checksum 0x80f9912b, Offset: 0x1f58
// Size: 0xb2
function update_readouts_for_remaining_robot_cost()
{
    a_e_readouts = getentarray( "robot_readout_model", "targetname" );
    
    foreach ( e_readout in a_e_readouts )
    {
        e_readout update_readout_for_remaining_robot_cost();
    }
}

// Namespace zm_zod_robot
// Params 0
// Checksum 0x15ff3f96, Offset: 0x2018
// Size: 0xde
function update_readout_for_remaining_robot_cost()
{
    a_cost = get_placed_array_from_number( level.ai_robot_remaining_cost );
    
    for ( i = 0; i < 4 ; i++ )
    {
        for ( j = 0; j < 10 ; j++ )
        {
            self hidepart( "J_" + i + "_" + j );
        }
        
        self showpart( "J_" + i + "_" + a_cost[ i ] );
    }
}

// Namespace zm_zod_robot
// Params 1
// Checksum 0x425271c4, Offset: 0x2100
// Size: 0xb8
function get_placed_array_from_number( n_number )
{
    a_number = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        n_place = pow( 10, 3 - i );
        a_number[ i ] = floor( n_number / n_place );
        n_number -= a_number[ i ] * n_place;
    }
    
    return a_number;
}

// Namespace zm_zod_robot
// Params 1, eflags: 0x4
// Checksum 0x29201cf4, Offset: 0x21c0
// Size: 0x3a, Type: bool
function private gib_head_check( damage_location )
{
    if ( !isdefined( damage_location ) )
    {
        return false;
    }
    
    switch ( damage_location )
    {
        case "head":
            return true;
        case "helmet":
            return true;
        case "neck":
            return true;
        default:
            return false;
    }
}

// Namespace zm_zod_robot
// Params 1, eflags: 0x4
// Checksum 0x94f9e, Offset: 0x2230
// Size: 0x10, Type: bool
function private gib_check( damage_percent )
{
    return true;
}

// Namespace zm_zod_robot
// Params 3
// Checksum 0xa205695c, Offset: 0x2248
// Size: 0x14c
function function_f9a6039c( entity, suffix, delay )
{
    entity endon( #"death" );
    entity endon( #"disconnect" );
    alias = "vox_crbt_robot_" + suffix;
    num_variants = zm_spawner::get_number_variants( alias );
    
    if ( num_variants <= 0 )
    {
        return;
    }
    
    var_4dc11cc = randomintrange( 0, num_variants + 1 );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( entity ) && !( isdefined( entity.is_speaking ) && entity.is_speaking ) )
    {
        entity.is_speaking = 1;
        entity playsoundwithnotify( alias + "_" + var_4dc11cc, "sndDone" );
        entity waittill( #"snddone" );
        entity.is_speaking = 0;
    }
}

// Namespace zm_zod_robot
// Params 0
// Checksum 0x95dcd2bc, Offset: 0x23a0
// Size: 0x88
function function_be60a9fd()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"killed", who );
        
        if ( randomintrange( 0, 101 ) <= 30 )
        {
            level thread function_f9a6039c( level.ai_robot, "kills" );
        }
    }
}

// Namespace zm_zod_robot
// Params 0
// Checksum 0x26415ba4, Offset: 0x2430
// Size: 0x68
function function_677061ac()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        wait randomintrange( 15, 25 );
        level thread function_f9a6039c( level.ai_robot, "active" );
    }
}

