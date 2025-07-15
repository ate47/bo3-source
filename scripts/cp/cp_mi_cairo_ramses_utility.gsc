#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace ramses_util;

// Namespace ramses_util
// Params 0, eflags: 0x2
// Checksum 0xed9a1d98, Offset: 0xb70
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "ramses_util", &__init__, undefined, undefined );
}

// Namespace ramses_util
// Params 0
// Checksum 0xec03d904, Offset: 0xbb0
// Size: 0x94
function __init__()
{
    clientfield::register( "toplayer", "ramses_sun_color", 1, 1, "int" );
    clientfield::register( "toplayer", "dni_eye", 1, 1, "int" );
    clientfield::register( "scriptmover", "hide_graphic_content", 1, 1, "counter" );
}

// Namespace ramses_util
// Params 0
// Checksum 0xd95b3ac0, Offset: 0xc50
// Size: 0x1a
function is_demo()
{
    return getdvarint( "is_demo_build", 0 );
}

// Namespace ramses_util
// Params 0
// Checksum 0x37c0993c, Offset: 0xc78
// Size: 0x84
function function_22e1a261()
{
    exploder::exploder( "transition" );
    level set_lighting_state_time_shift_2();
    getent( "lgt_shadow_block_trans", "targetname" ) show();
    level clientfield::set( "alley_fog_banks", 1 );
}

// Namespace ramses_util
// Params 0
// Checksum 0xc40079dc, Offset: 0xd08
// Size: 0xf2
function prepare_players_for_demo_warp()
{
    foreach ( player in level.players )
    {
        if ( player isinvehicle() )
        {
            vh_occupied = player getvehicleoccupied();
            n_seat = vh_occupied getoccupantseat( player );
            vh_occupied usevehicle( player, n_seat );
        }
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0x6041f593, Offset: 0xe08
// Size: 0xea
function set_low_ready_movement( b_enable )
{
    if ( !isdefined( b_enable ) )
    {
        b_enable = 1;
    }
    
    if ( !isarray( self ) )
    {
        a_e_players = array( self );
    }
    else
    {
        a_e_players = self;
    }
    
    foreach ( e_player in a_e_players )
    {
        e_player util::set_low_ready( b_enable );
    }
}

// Namespace ramses_util
// Params 0
// Checksum 0xce77b58d, Offset: 0xf00
// Size: 0xbc
function function_1903e7dc()
{
    hidemiscmodels( "arena_billboard_static2" );
    hidemiscmodels( "arena_billboard_02_static2" );
    hidemiscmodels( "cinema_collapse_static2" );
    hidemiscmodels( "quadtank_statue_static2" );
    hidemiscmodels( "rocket_static2" );
    hidemiscmodels( "glass_building_static2" );
    hidemiscmodels( "wall_collapse_static2" );
    function_2f9e262a();
}

// Namespace ramses_util
// Params 0
// Checksum 0x34222945, Offset: 0xfc8
// Size: 0x314
function function_2f9e262a()
{
    scene::add_scene_func( "p7_fxanim_cp_ramses_arena_billboard_bundle", &function_1c347e72, "init", "arena_billboard_static1" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_arena_billboard_bundle", &function_a72c2dda, "done", "arena_billboard_static2" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_arena_billboard_02_bundle", &function_1c347e72, "init", "arena_billboard_02_static1" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_arena_billboard_02_bundle", &function_a72c2dda, "done", "arena_billboard_02_static2" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_cinema_collapse_bundle", &function_1c347e72, "init", "cinema_collapse_static1" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_cinema_collapse_bundle", &function_a72c2dda, "done", "cinema_collapse_static2" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_quadtank_statue_bundle", &function_1c347e72, "init", "quadtank_statue_static1" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_quadtank_statue_bundle", &function_a72c2dda, "done", "quadtank_statue_static2" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle", &function_1c347e72, "init", "rocket_static1" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle", &function_a72c2dda, "done", "rocket_static2" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle", &function_1c347e72, "init", "glass_building_static1" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle", &function_a72c2dda, "done", "glass_building_static2" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &function_1c347e72, "init", "wall_collapse_static1" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &function_a72c2dda, "done", "wall_collapse_static2" );
}

// Namespace ramses_util
// Params 2
// Checksum 0xeaf84da5, Offset: 0x12e8
// Size: 0x2c
function function_1c347e72( a_ents, str_targetname )
{
    hidemiscmodels( str_targetname );
}

// Namespace ramses_util
// Params 2
// Checksum 0x81d0b3a2, Offset: 0x1320
// Size: 0xd2
function function_a72c2dda( a_ents, str_targetname )
{
    showmiscmodels( str_targetname );
    
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent ) && !issentient( ent ) )
        {
            ent delete();
        }
    }
}

// Namespace ramses_util
// Params 0
// Checksum 0x25af9c5a, Offset: 0x1400
// Size: 0xfa
function function_a0a9f927()
{
    a_mdl_fans = getentarray( "recovery_fan", "targetname" );
    
    foreach ( mdl_fan in a_mdl_fans )
    {
        mdl_fan thread rotate_fan( 2 );
        mdl_fan thread function_f81a38c8();
        wait randomfloatrange( 0.5, 1.5 );
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0xe60a0cfd, Offset: 0x1508
// Size: 0x54
function rotate_fan( var_5dbde88f )
{
    self endon( #"hash_fb28e86c" );
    
    while ( true )
    {
        self rotateyaw( 180, var_5dbde88f / 2 );
        wait var_5dbde88f / 2;
    }
}

// Namespace ramses_util
// Params 0
// Checksum 0x7dfc973e, Offset: 0x1568
// Size: 0x9c
function function_f81a38c8()
{
    t_damage = getent( self.target, "targetname" );
    t_damage waittill( #"trigger" );
    self notify( #"hash_fb28e86c" );
    self waittill( #"rotatedone" );
    self rotateto( self.angles + ( 0, 15, 0 ), 1.25, 0.05, 0.75 );
}

// Namespace ramses_util
// Params 1
// Checksum 0xd326292f, Offset: 0x1610
// Size: 0x20
function function_e7ebe596( b_on )
{
    if ( !isdefined( b_on ) )
    {
        b_on = 1;
    }
}

// Namespace ramses_util
// Params 2
// Checksum 0x1325d10e, Offset: 0x1638
// Size: 0x4c
function delete_ent_array( str_value, str_key )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    level thread _delete_ent_array( str_value, str_key );
}

// Namespace ramses_util
// Params 2
// Checksum 0x45f00088, Offset: 0x1690
// Size: 0xea
function _delete_ent_array( str_value, str_key )
{
    a_ents = getentarray( str_value, str_key );
    
    foreach ( i, ent in a_ents )
    {
        if ( i % 3 )
        {
            wait 0.05;
        }
        
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0x29e25696, Offset: 0x1788
// Size: 0x38c
function init_dead_turrets( b_fake_rs_turrets )
{
    if ( !isdefined( b_fake_rs_turrets ) )
    {
        b_fake_rs_turrets = 0;
    }
    
    level.a_e_dead_turrets_non_controllable = [];
    a_sp_turret_non_controllable = getentarray( "dead_turrets_non_controllable", "targetname" );
    
    if ( b_fake_rs_turrets )
    {
        foreach ( sp_turret in a_sp_turret_non_controllable )
        {
            m_turret = spawn( "script_model", sp_turret.origin );
            m_turret.angles = sp_turret.angles;
            m_turret setmodel( "veh_t7_turret_dead_system_ramses" );
        }
    }
    else
    {
        foreach ( sp_turret in a_sp_turret_non_controllable )
        {
            e_dead_turret = spawner::simple_spawn_single( sp_turret );
            level.a_e_dead_turrets_non_controllable[ level.a_e_dead_turrets_non_controllable.size ] = e_dead_turret;
            e_dead_turret.takedamage = 0;
        }
    }
    
    level.a_e_dead_turrets = [];
    a_sp_turret = getentarray( "dead_turrets", "script_noteworthy" );
    
    foreach ( sp_turret in a_sp_turret )
    {
        e_dead_turret = spawner::simple_spawn_single( sp_turret );
        level.a_e_dead_turrets[ level.a_e_dead_turrets.size ] = e_dead_turret;
        e_dead_turret.dead_turret_owned = 0;
        e_dead_turret.takedamage = 0;
        
        if ( isdefined( sp_turret.script_int ) )
        {
            assert( isdefined( e_dead_turret.script_int ), "<dev string:x28>" );
            e_dead_turret.script_int = sp_turret.script_int;
        }
    }
    
    level.a_e_all_dead_turrets = arraycombine( level.a_e_dead_turrets, level.a_e_dead_turrets_non_controllable, 1, 0 );
    level flag::set( "dead_turrets_initialized" );
}

// Namespace ramses_util
// Params 0
// Checksum 0xc1a3a6e3, Offset: 0x1b20
// Size: 0xc2
function delete_all_dead_turrets()
{
    level notify( #"stop_rs_dead_turret_vignettes" );
    
    if ( isdefined( level.a_e_all_dead_turrets ) )
    {
        foreach ( e_turret in level.a_e_all_dead_turrets )
        {
            e_turret delete();
        }
    }
    
    level.a_e_dead_turrets_non_controllable = undefined;
    level.a_e_dead_turrets = undefined;
    level.a_e_all_dead_turrets = undefined;
}

// Namespace ramses_util
// Params 1
// Checksum 0x7dc2a132, Offset: 0x1bf0
// Size: 0x12a
function hide_ents( b_connect )
{
    if ( !isdefined( b_connect ) )
    {
        b_connect = 0;
    }
    
    foreach ( e in self )
    {
        e hide();
    }
    
    if ( b_connect )
    {
        foreach ( e in self )
        {
            e connectpaths();
            wait 0.05;
        }
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0x575335da, Offset: 0x1d28
// Size: 0x222
function show_ents( b_disconnect )
{
    if ( !isdefined( b_disconnect ) )
    {
        b_disconnect = 0;
    }
    
    foreach ( e in self )
    {
        e show();
    }
    
    if ( b_disconnect )
    {
        foreach ( e in self )
        {
            if ( e.targetname !== "path_neutral" )
            {
                if ( isdefined( e.script_noteworthy ) && e.script_noteworthy == "connect_paths" )
                {
                    e connectpaths();
                }
                else if ( e.model == "p7_cai_stacking_cargo_crate" || e.classname === "script_model" && ( e.classname === "script_brushmodel" && e.script_noteworthy !== "do_not_disconnect" || e.model == "veh_t7_mil_vtol_dropship_troopcarrier" ) )
                {
                    e disconnectpaths();
                }
            }
            
            wait 0.05;
        }
    }
}

// Namespace ramses_util
// Params 0
// Checksum 0x390580a9, Offset: 0x1f58
// Size: 0x132
function spawn_from_structs()
{
    n_count = 0;
    
    foreach ( struct in self )
    {
        if ( isdefined( struct.model ) )
        {
            new_ent = spawn( "script_model", struct.origin );
            new_ent.angles = struct.angles;
            new_ent setmodel( struct.model );
            n_count++;
            
            if ( n_count % 10 == 0 )
            {
                util::wait_network_frame();
            }
        }
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0xb7c915d2, Offset: 0x2098
// Size: 0x15a
function make_not_solid( b_moving )
{
    if ( isarray( self ) )
    {
        a_e = self;
    }
    else
    {
        a_e = array( self );
    }
    
    foreach ( e in a_e )
    {
        e notsolid();
    }
    
    if ( isdefined( b_moving ) )
    {
        foreach ( e in a_e )
        {
            e setmovingplatformenabled( b_moving );
        }
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0xc3990c74, Offset: 0x2200
// Size: 0x15a
function make_solid( b_moving )
{
    if ( isarray( self ) )
    {
        a_e = self;
    }
    else
    {
        a_e = array( self );
    }
    
    foreach ( e in a_e )
    {
        e solid();
    }
    
    if ( isdefined( b_moving ) )
    {
        foreach ( e in a_e )
        {
            e setmovingplatformenabled( b_moving );
        }
    }
}

// Namespace ramses_util
// Params 2
// Checksum 0xc73e9390, Offset: 0x2368
// Size: 0x278
function set_visible( str_ent, b_visible )
{
    if ( !isdefined( b_visible ) )
    {
        b_visible = 1;
    }
    
    a_e_invis = getentarray( str_ent, "targetname" );
    a_e_players = self;
    
    if ( !isarray( self ) )
    {
        a_e_players = array( self );
    }
    
    if ( b_visible )
    {
        foreach ( e_player in a_e_players )
        {
            foreach ( e_invis in a_e_invis )
            {
                e_invis setvisibletoplayer( e_player );
            }
        }
        
        return;
    }
    
    foreach ( e_player in a_e_players )
    {
        foreach ( e_invis in a_e_invis )
        {
            e_invis setinvisibletoplayer( e_player );
        }
    }
}

// Namespace ramses_util
// Params 2
// Checksum 0xff793a60, Offset: 0x25e8
// Size: 0x1ca
function give_spike_launcher( b_force_switch, b_hint )
{
    if ( !isdefined( b_force_switch ) )
    {
        b_force_switch = 1;
    }
    
    if ( !isdefined( b_hint ) )
    {
        b_hint = 1;
    }
    
    if ( flagsys::get( "mobile_armory_in_use" ) )
    {
        return;
    }
    
    a_e_players = self;
    
    if ( !isarray( a_e_players ) )
    {
        a_e_players = array( a_e_players );
    }
    
    w_spike_launcher = getweapon( "spike_launcher" );
    
    foreach ( e_player in a_e_players )
    {
        e_player giveweapon( w_spike_launcher );
        e_player setweaponammoclip( w_spike_launcher, w_spike_launcher.clipsize );
        e_player givemaxammo( w_spike_launcher );
        
        if ( b_force_switch )
        {
            e_player switchtoweapon( w_spike_launcher );
        }
        
        if ( b_hint )
        {
            e_player thread spike_launcher_tutorial_hint( w_spike_launcher );
        }
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0xbec7a644, Offset: 0x27c0
// Size: 0x94
function spike_launcher_tutorial_hint( w_spike_launcher )
{
    self endon( #"death" );
    w_current = self getcurrentweapon();
    
    while ( !self flag::get( "spike_launcher_tutorial_complete" ) )
    {
        if ( w_current == w_spike_launcher )
        {
            self _wait_till_tutorial_complete( w_spike_launcher );
            continue;
        }
        
        self waittill( #"weapon_change_complete", w_current );
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0x6832dfee, Offset: 0x2860
// Size: 0x9c
function _wait_till_tutorial_complete( w_spike_launcher )
{
    self endon( #"death" );
    self endon( #"detonate" );
    self endon( #"last_stand_detonate" );
    self waittill( #"weapon_fired", w_current );
    
    if ( w_current == w_spike_launcher )
    {
        wait 2;
        self thread wait_till_detonate_button_pressed();
        self util::waittill_any( "detonate", "last_stand_detonate" );
    }
}

// Namespace ramses_util
// Params 0
// Checksum 0xdc5e12c0, Offset: 0x2908
// Size: 0x106
function wait_till_detonate_button_pressed()
{
    self endon( #"death" );
    self notify( #"wait_till_detonate_button_pressed" );
    self endon( #"wait_till_detonate_button_pressed" );
    
    if ( isdefined( self.var_f30613a1 ) )
    {
        self util::hide_hint_text();
        wait 0.05;
    }
    
    w_spike_launcher = getweapon( "spike_launcher" );
    self util::show_hint_text( &"CP_MI_CAIRO_RAMSES_SPIKE_LAUNCHER_DETONATE", 1, "spike_launcher_tutorial_complete", 20 );
    self.var_99c7680e = 1;
    self util::waittill_any_timeout( 20, "detonate", "last_stand_detonate" );
    self flag::set( "spike_launcher_tutorial_complete" );
    self.var_f30613a1 = undefined;
}

// Namespace ramses_util
// Params 0
// Checksum 0xdedc8bc0, Offset: 0x2a18
// Size: 0x100
function function_780e57a1()
{
    level endon( #"all_weak_points_destroyed" );
    self endon( #"detonate" );
    self endon( #"last_stand_detonate" );
    self endon( #"death" );
    w_current = self getcurrentweapon();
    w_spike_launcher = getweapon( "spike_launcher" );
    
    while ( !self flag::get( "spike_launcher_tutorial_complete" ) )
    {
        self waittill( #"weapon_change_complete", w_current );
        
        if ( w_current != w_spike_launcher )
        {
            self util::hide_hint_text();
            continue;
        }
        
        self util::show_hint_text( &"CP_MI_CAIRO_RAMSES_SPIKE_LAUNCHER_DETONATE", 1, "spike_launcher_tutorial_complete", 20 );
    }
}

// Namespace ramses_util
// Params 0
// Checksum 0x97a22154, Offset: 0x2b20
// Size: 0x11a
function take_spike_launcher()
{
    a_e_players = self;
    
    if ( !isarray( a_e_players ) )
    {
        a_e_players = array( a_e_players );
    }
    
    w_spike_launcher = getweapon( "spike_launcher" );
    
    foreach ( e_player in a_e_players )
    {
        if ( e_player hasweapon( w_spike_launcher ) )
        {
            e_player takeweapon( w_spike_launcher );
        }
    }
}

// Namespace ramses_util
// Params 3
// Checksum 0x85205fba, Offset: 0x2c48
// Size: 0x11c
function scale_spawn_manager_by_player_count( n_count_per_player, n_active_max_per_player, n_active_min_per_player )
{
    b_something_to_scale = isdefined( n_count_per_player ) || isdefined( n_active_max_per_player ) || isdefined( n_active_min_per_player );
    assert( isdefined( b_something_to_scale ) && b_something_to_scale, "<dev string:x69>" + self.targetname + "<dev string:xa8>" + self.origin );
    
    if ( isdefined( n_count_per_player ) )
    {
        self.count = get_num_scaled_by_player_count( self.count, n_count_per_player );
    }
    
    if ( isdefined( n_active_max_per_player ) )
    {
        self.sm_active_count_max = get_num_scaled_by_player_count( self.sm_active_count_max, n_active_max_per_player );
    }
    
    if ( isdefined( n_active_min_per_player ) )
    {
        self.sm_active_count_min = get_num_scaled_by_player_count( self.sm_active_count_min, n_active_min_per_player );
    }
}

// Namespace ramses_util
// Params 2
// Checksum 0x65b98840, Offset: 0x2d70
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

// Namespace ramses_util
// Params 0
// Checksum 0xe0adfa5e, Offset: 0x2e28
// Size: 0x48
function get_random_player()
{
    e_player = self[ 0 ];
    
    if ( self.size > 1 )
    {
        e_player = self[ randomint( self.size ) ];
    }
    
    return e_player;
}

// Namespace ramses_util
// Params 0
// Checksum 0xd562cf5a, Offset: 0x2e78
// Size: 0xc8
function get_not_in_laststand()
{
    a_e_players_up = [];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( !level.players[ i ] laststand::player_is_in_laststand() )
        {
            if ( !isdefined( a_e_players_up ) )
            {
                a_e_players_up = [];
            }
            else if ( !isarray( a_e_players_up ) )
            {
                a_e_players_up = array( a_e_players_up );
            }
            
            a_e_players_up[ a_e_players_up.size ] = level.players[ i ];
        }
    }
    
    return a_e_players_up;
}

// Namespace ramses_util
// Params 1
// Checksum 0x5c4a090f, Offset: 0x2f48
// Size: 0xd0
function kill_players( str_notify )
{
    level endon( str_notify );
    
    while ( true )
    {
        self waittill( #"trigger", e_toucher );
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( e_toucher == level.players[ i ] && !e_toucher laststand::player_is_in_laststand() )
            {
                e_toucher dodamage( e_toucher.health + 100, e_toucher.origin );
            }
        }
        
        wait 1;
    }
}

// Namespace ramses_util
// Params 0
// Checksum 0x97e25242, Offset: 0x3020
// Size: 0x90
function wait_till_no_players_looking_at()
{
    while ( true )
    {
        n_look_count = 0;
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( level.players[ i ] util::is_looking_at( self ) )
            {
                n_look_count++;
            }
        }
        
        if ( n_look_count == 0 )
        {
            return;
        }
        
        wait 0.25;
    }
}

// Namespace ramses_util
// Params 2
// Checksum 0x6193b31b, Offset: 0x30b8
// Size: 0x114
function track_player( str_endon, n_radius )
{
    if ( !isdefined( n_radius ) )
    {
        n_radius = 256;
    }
    
    self endon( #"death" );
    
    if ( isdefined( str_endon ) )
    {
        level endon( str_endon );
    }
    
    self.goalradius = n_radius;
    
    while ( true )
    {
        a_e_players_up = get_not_in_laststand();
        e_prey = a_e_players_up get_random_player();
        
        while ( isdefined( e_prey ) && !e_prey laststand::player_is_in_laststand() )
        {
            self setgoal( e_prey getorigin() );
            wait randomfloatrange( 2, 4 );
        }
        
        wait 0.15;
    }
}

// Namespace ramses_util
// Params 6
// Checksum 0x66f80af5, Offset: 0x31d8
// Size: 0x280
function ambient_spawns( str_spawners, str_key, n_spawners, t_cleanup, str_endon, n_next_wave_timeout )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    level endon( str_endon );
    a_e_ambients = [];
    a_spawners = getentarray( str_spawners, str_key );
    
    if ( !isdefined( n_spawners ) )
    {
        n_spawners = a_spawners.size;
    }
    
    t_cleanup thread ambient_spawns_cleanup( str_endon );
    
    while ( true )
    {
        a_spawners = array::randomize( a_spawners );
        
        for ( i = 0; i < n_spawners ; i++ )
        {
            e_ambient = a_spawners[ i ] spawner::spawn();
            wait 0.05;
            
            if ( isalive( e_ambient ) )
            {
                if ( isai( e_ambient ) )
                {
                    if ( !isdefined( a_e_ambients ) )
                    {
                        a_e_ambients = [];
                    }
                    else if ( !isarray( a_e_ambients ) )
                    {
                        a_e_ambients = array( a_e_ambients );
                    }
                    
                    a_e_ambients[ a_e_ambients.size ] = e_ambient;
                    e_ambient ai::set_ignoreall( 1 );
                    e_ambient.goalradius = 8;
                    continue;
                }
                
                if ( isvehicle( e_ambient ) )
                {
                    nd_spline = getvehiclenode( e_ambient.target, "targetname" );
                    e_ambient thread vehicle::get_on_and_go_path( nd_spline );
                }
            }
        }
        
        array::wait_till( a_e_ambients, "death", n_next_wave_timeout );
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0xe60676, Offset: 0x3460
// Size: 0xc8
function ambient_spawns_cleanup( str_endon )
{
    level endon( str_endon );
    
    while ( true )
    {
        self waittill( #"trigger", e_ambient );
        
        if ( isdefined( e_ambient ) )
        {
            if ( isai( e_ambient ) )
            {
                e_ambient delete();
                continue;
            }
            
            e_ambient.delete_on_death = 1;
            e_ambient notify( #"death" );
            
            if ( !isalive( e_ambient ) )
            {
                e_ambient delete();
            }
        }
    }
}

// Namespace ramses_util
// Params 10
// Checksum 0x1d8f9ab, Offset: 0x3530
// Size: 0x1f4
function spawn_phalanx( str_phalanx, str_formation, n_remaining_to_disperse, b_scatter, n_timeout_scatter, str_notify_scatter, b_rush_on_scatter, str_rusher_key, str_rusher_value, var_42e6f5b4 )
{
    if ( !isdefined( b_scatter ) )
    {
        b_scatter = 0;
    }
    
    if ( !isdefined( n_timeout_scatter ) )
    {
        n_timeout_scatter = 0;
    }
    
    if ( !isdefined( b_rush_on_scatter ) )
    {
        b_rush_on_scatter = 0;
    }
    
    v_start = struct::get( str_phalanx + "_start" ).origin;
    v_end = struct::get( str_phalanx + "_end" ).origin;
    o_phalanx = new robotphalanx();
    [[ o_phalanx ]]->initialize( str_formation, v_start, v_end, n_remaining_to_disperse, var_42e6f5b4 );
    
    if ( isdefined( str_notify_scatter ) )
    {
        level waittill( str_notify_scatter );
    }
    
    wait n_timeout_scatter;
    
    if ( b_scatter && o_phalanx.scattered_ == 0 )
    {
        o_phalanx robotphalanx::scatterphalanx();
    }
    
    if ( b_rush_on_scatter )
    {
        while ( isdefined( o_phalanx ) && o_phalanx.scattered_ == 0 )
        {
            wait 0.25;
        }
        
        make_rushers( str_rusher_key, str_rusher_value, get_num_scaled_by_player_count( 3, 1 ) );
    }
}

// Namespace ramses_util
// Params 4
// Checksum 0x372b5fd1, Offset: 0x3730
// Size: 0x146
function make_rushers( str_key, str_value, n_max, n_min )
{
    if ( !isdefined( str_value ) )
    {
        str_value = "targetname";
    }
    
    a_ai_robots = getentarray( str_key, str_value );
    a_ai_robots = array::randomize( a_ai_robots );
    n_rushers = a_ai_robots.size;
    
    if ( isdefined( n_max ) )
    {
        n_rushers = n_max;
    }
    
    if ( isdefined( n_min ) )
    {
        n_rushers = randomintrange( n_min, n_rushers + 1 );
    }
    
    for ( i = 0; i < n_rushers ; i++ )
    {
        if ( isalive( a_ai_robots[ i ] ) )
        {
            a_ai_robots[ i ] ai::set_behavior_attribute( "move_mode", "rusher" );
        }
    }
}

// Namespace ramses_util
// Params 2
// Checksum 0xfa6ac15c, Offset: 0x3880
// Size: 0x3a
function flag_then_func( str_flag, func )
{
    self flag::wait_till( str_flag );
    self thread [[ func ]]();
}

// Namespace ramses_util
// Params 0
// Checksum 0x4bc423ec, Offset: 0x38c8
// Size: 0x16a
function delete_all_non_hero_ai()
{
    a_friendly = getaiteamarray( "allies" );
    
    foreach ( ai in a_friendly )
    {
        if ( !isinarray( level.heroes, ai ) )
        {
            ai delete();
        }
    }
    
    a_enemy = getaiteamarray( "axis" );
    
    foreach ( ai in a_enemy )
    {
        ai delete();
    }
}

// Namespace ramses_util
// Params 6
// Checksum 0x5855606d, Offset: 0x3a40
// Size: 0x10c
function wait_till_flag_then_play( str_flag, str_scene, n_delay, n_wait, str_flag_cleanup, str_endon )
{
    if ( !isdefined( n_delay ) )
    {
        n_delay = 0;
    }
    
    if ( !isdefined( n_wait ) )
    {
        n_wait = 0;
    }
    
    if ( isdefined( str_endon ) )
    {
        level endon( str_endon );
    }
    
    level flag::wait_till( str_flag );
    wait n_delay;
    level thread scene::play( str_scene, "targetname" );
    
    if ( n_wait > 0 || isdefined( str_flag_cleanup ) )
    {
        if ( isdefined( str_flag_cleanup ) )
        {
            level flag::wait_till( str_flag_cleanup );
        }
        
        wait n_wait;
        level scene::stop( str_scene, "targetname", 1 );
    }
}

// Namespace ramses_util
// Params 2
// Checksum 0x38455e69, Offset: 0x3b58
// Size: 0x84
function play_scene_on_notify( str_scene, str_notify )
{
    assert( isdefined( str_scene ), "<dev string:xac>" );
    assert( isdefined( str_notify ), "<dev string:xd8>" );
    self waittill( str_notify );
    self scene::play( str_scene );
}

// Namespace ramses_util
// Params 3
// Checksum 0xbe44bcf0, Offset: 0x3be8
// Size: 0xbc
function skipto_notetrack_time_in_animation( anim_name, str_scene, str_notetrack )
{
    a_notetracks = getnotetracktimes( anim_name, str_notetrack );
    assert( a_notetracks.size, "<dev string:x105>" + str_scene + "<dev string:x12b>" + str_notetrack + "<dev string:x13f>" );
    n_time = a_notetracks[ 0 ];
    self thread scene::skipto_end( str_scene, undefined, undefined, n_time );
}

// Namespace ramses_util
// Params 2
// Checksum 0xc186bcbb, Offset: 0x3cb0
// Size: 0xa4
function function_3bc57aa8( a_ents, b_enable )
{
    if ( !isdefined( b_enable ) )
    {
        b_enable = 1;
    }
    
    if ( isdefined( level.ai_khalil ) )
    {
        level.ai_khalil sethighdetail( b_enable );
    }
    
    if ( isdefined( level.ai_hendricks ) )
    {
        level.ai_hendricks sethighdetail( b_enable );
    }
    
    if ( isdefined( level.ai_rachel ) )
    {
        level.ai_rachel sethighdetail( b_enable );
    }
}

// Namespace ramses_util
// Params 3
// Checksum 0xfffe3d26, Offset: 0x3d60
// Size: 0xfa
function enable_nodes( str_key, str_val, b_enable )
{
    if ( !isdefined( str_val ) )
    {
        str_val = "targetname";
    }
    
    if ( !isdefined( b_enable ) )
    {
        b_enable = 1;
    }
    
    a_nodes = getnodearray( str_key, str_val );
    
    foreach ( nd_node in a_nodes )
    {
        setenablenode( nd_node, b_enable );
    }
}

// Namespace ramses_util
// Params 3
// Checksum 0xfd193792, Offset: 0x3e68
// Size: 0x162
function link_traversals( str_key, str_val, b_link )
{
    if ( !isdefined( b_link ) )
    {
        b_link = 1;
    }
    
    a_nd = getnodearray( str_key, str_val );
    
    if ( b_link )
    {
        foreach ( nd in a_nd )
        {
            linktraversal( nd );
        }
        
        return;
    }
    
    foreach ( nd in a_nd )
    {
        unlinktraversal( nd );
    }
}

// Namespace ramses_util
// Params 3
// Checksum 0x6a422d75, Offset: 0x3fd8
// Size: 0x17c
function function_508a129e( str_notify, n_time, var_45778f27 )
{
    if ( !isdefined( var_45778f27 ) )
    {
        var_45778f27 = 1;
    }
    
    self notify( #"hash_5a334c0f" );
    self endon( #"death" );
    self endon( #"hash_5a334c0f" );
    level flag::wait_till( "intro_igc_done" );
    w_spike_launcher = getweapon( "spike_launcher" );
    
    while ( self getcurrentweapon() == w_spike_launcher )
    {
        wait 0.2;
    }
    
    self util::show_hint_text( &"COOP_EQUIP_SPIKE_LAUNCHER", 0, str_notify, n_time );
    
    while ( var_45778f27 == 0 )
    {
        self util::waittill_any( "wp_01_destroyed", "weapon_change_complete" );
        
        if ( self getcurrentweapon() == w_spike_launcher || level flag::get( "wp_01_destroyed" ) )
        {
            self notify( str_notify );
            var_45778f27 = 1;
            continue;
        }
        
        wait 0.1;
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0xa4c1dde2, Offset: 0x4160
// Size: 0xb4, Type: bool
function has_weapon( w_has )
{
    a_w_weapons = self getweaponslist();
    
    foreach ( w in a_w_weapons )
    {
        if ( w == w_has )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ramses_util
// Params 1
// Checksum 0x39028cc9, Offset: 0x4220
// Size: 0x3c, Type: bool
function is_using_weapon( str_weapon )
{
    return self getcurrentweapon() == getweapon( str_weapon );
}

/#

    // Namespace ramses_util
    // Params 1
    // Checksum 0xf276bc02, Offset: 0x4268
    // Size: 0x90, Type: dev
    function debug_linked( e )
    {
        self endon( #"death" );
        e endon( #"death" );
        
        while ( true )
        {
            line( e.origin, self.origin, ( 1, 0, 0 ), 0.1 );
            debug::drawarrow( self.origin, self.angles );
            wait 0.05;
        }
    }

    // Namespace ramses_util
    // Params 3
    // Checksum 0xcfe4cf02, Offset: 0x4300
    // Size: 0xf0, Type: dev
    function draw_line_to_target( target, n_timer, str_start_tag )
    {
        self endon( #"death" );
        target endon( #"death" );
        n_timer = gettime() + n_timer * 1000;
        
        while ( gettime() < n_timer )
        {
            v_start_point = self.origin;
            
            if ( isdefined( str_start_tag ) )
            {
                v_start_point = self gettagorigin( str_start_tag );
            }
            
            line( v_start_point, target.origin, ( 1, 0, 0 ), 0.1 );
            debug::drawarrow( target.origin, target.angles );
            wait 0.05;
        }
    }

    // Namespace ramses_util
    // Params 1
    // Checksum 0x9c0f5e65, Offset: 0x43f8
    // Size: 0xd8, Type: dev
    function debug_link_probe( e_probe )
    {
        while ( isdefined( e_probe ) && isdefined( self ) )
        {
            line( e_probe.origin, self.origin, ( 1, 0, 0 ), 0.1 );
            debug::debug_sphere( e_probe.origin, 16, ( 1, 0, 0 ), 0.5, 1 );
            debug::drawarrow( self.origin, self.angles );
            debug::drawarrow( e_probe.origin, e_probe.angles );
            wait 0.05;
        }
    }

#/

// Namespace ramses_util
// Params 0
// Checksum 0xf46e46c0, Offset: 0x44d8
// Size: 0x54
function arena_defend_flak_exploders()
{
    exploder::exploder( "exploder_flak_arena_defend" );
    level flag::wait_till( "flak_arena_defend_stop" );
    exploder::exploder_stop( "exploder_flak_arena_defend" );
}

// Namespace ramses_util
// Params 0
// Checksum 0xfd1e5a03, Offset: 0x4538
// Size: 0x54
function alley_flak_exploder()
{
    exploder::exploder( "exploder_flak_alley" );
    level flag::wait_till( "flak_alley_stop" );
    exploder::exploder_stop( "exploder_flak_alley" );
}

// Namespace ramses_util
// Params 1
// Checksum 0x60e4e3bc, Offset: 0x4598
// Size: 0x64
function ambient_walk_fx_exploder( b_on )
{
    if ( !isdefined( b_on ) )
    {
        b_on = 1;
    }
    
    if ( b_on )
    {
        exploder::exploder( "fx_exploder_station_ambient_pre_collapse" );
        return;
    }
    
    exploder::exploder_stop( "fx_exploder_station_ambient_pre_collapse" );
}

// Namespace ramses_util
// Params 0
// Checksum 0xf6b63c8c, Offset: 0x4608
// Size: 0x5c
function arena_defend_sinkhole_exploders()
{
    exploder::exploder( "fx_exploder_turn_off_collapse" );
    level flag::wait_till( "sinkhole_charges_detonated" );
    wait 1.5;
    exploder::exploder_stop( "fx_exploder_turn_off_collapse" );
}

// Namespace ramses_util
// Params 0
// Checksum 0xd217b054, Offset: 0x4670
// Size: 0x96
function set_lighting_state_on_spawn()
{
    util::wait_network_frame();
    
    if ( isdefined( level.lighting_state_ramses ) )
    {
        switch ( level.lighting_state_ramses )
        {
            case 1:
                self set_lighting_state_time_shift_1();
                break;
            case 2:
                self set_lighting_state_time_shift_2();
                break;
            case 3:
                self set_lighting_state_start();
                break;
        }
    }
}

// Namespace ramses_util
// Params 0
// Checksum 0xec0eed03, Offset: 0x4710
// Size: 0x3c
function set_lighting_state_time_shift_1()
{
    level.lighting_state_ramses = 1;
    self util::set_lighting_state( 0 );
    self set_sun_color( 1 );
}

// Namespace ramses_util
// Params 0
// Checksum 0xf36b53ef, Offset: 0x4758
// Size: 0x44
function set_lighting_state_time_shift_2()
{
    level.lighting_state_ramses = 2;
    self util::set_lighting_state( 2 );
    self set_sun_color( 0 );
}

// Namespace ramses_util
// Params 0
// Checksum 0xbd67918e, Offset: 0x47a8
// Size: 0x44
function set_lighting_state_start()
{
    level.lighting_state_ramses = 3;
    self util::set_lighting_state( 3 );
    self set_sun_color( 0 );
}

// Namespace ramses_util
// Params 1
// Checksum 0xce5bb1d7, Offset: 0x47f8
// Size: 0xfc
function set_sun_color( n_value )
{
    if ( self == level )
    {
        foreach ( player in level.players )
        {
            player set_sun_color( n_value );
        }
        
        return;
    }
    
    if ( isplayer( self ) )
    {
        self clientfield::set_to_player( "ramses_sun_color", n_value );
        return;
    }
    
    assertmsg( "<dev string:x14c>" );
}

// Namespace ramses_util
// Params 3
// Checksum 0x8e4a6203, Offset: 0x4900
// Size: 0x152
function light_shift_think( str_trigger_targetname, str_level_endon, func_on_trigger )
{
    assert( isdefined( str_trigger_targetname ), "<dev string:x181>" );
    assert( isdefined( str_level_endon ), "<dev string:x1c0>" );
    assert( isdefined( func_on_trigger ), "<dev string:x1f8>" );
    level endon( str_level_endon );
    t_light_shift = getent( str_trigger_targetname, "targetname" );
    assert( isdefined( t_light_shift ), "<dev string:x230>" + str_trigger_targetname + "<dev string:x26b>" );
    
    while ( true )
    {
        t_light_shift waittill( #"trigger", e_player );
        
        if ( isdefined( e_player ) && isplayer( e_player ) )
        {
            e_player [[ func_on_trigger ]]();
        }
    }
}

// Namespace ramses_util
// Params 0
// Checksum 0x43220242, Offset: 0x4a60
// Size: 0x13a
function function_eabc6e2f()
{
    level clientfield::set( "turn_on_rotating_fxanim_lights", 1 );
    exploder::exploder( "lgt_emergency" );
    a_lighting_ents = getentarray( "lgt_tent_probe", "script_noteworthy" );
    
    foreach ( ent in a_lighting_ents )
    {
        if ( ent.classname == "reflection_probe" )
        {
            ent.origin -= ( 0, 0, 5000 );
            continue;
        }
        
        ent delete();
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0x53747206, Offset: 0x4ba8
// Size: 0x264
function turret_pickup_think( s_obj )
{
    self endon( #"death" );
    waittillframeend();
    w_hero = getweapon( "lmg_light" );
    t_pickup = spawn( "trigger_radius", self.origin + ( 0, 0, 24 ), 0, s_obj.radius, 128 );
    t_pickup.targetname = "turret_pickup_trig";
    t_pickup.script_objective = "vtol_ride";
    t_pickup triggerignoreteam();
    self thread turret_pickup_hint( t_pickup, w_hero );
    
    while ( true )
    {
        t_pickup waittill( #"trigger", e_player );
        
        if ( isalive( e_player ) )
        {
            if ( e_player turret_pickup_button_pressed() && !e_player has_weapon( w_hero ) )
            {
                var_73a38d53 = self getseatoccupant( 0 );
                
                if ( isdefined( var_73a38d53 ) )
                {
                    if ( var_73a38d53 == e_player )
                    {
                        self usevehicle( e_player, 0 );
                    }
                    else
                    {
                        continue;
                    }
                }
                
                e_player giveweapon( w_hero );
                e_player switchtoweapon( w_hero );
                level notify( #"turret_picked_up" );
                break;
            }
        }
    }
    
    self.delete_on_death = 1;
    self notify( #"death" );
    
    if ( !isalive( self ) )
    {
        self delete();
    }
    
    t_pickup delete();
}

// Namespace ramses_util
// Params 2
// Checksum 0x83820ee8, Offset: 0x4e18
// Size: 0x178
function turret_pickup_hint( t_pickup, w_hero )
{
    t_pickup endon( #"death" );
    
    while ( true )
    {
        t_pickup waittill( #"trigger", e_player );
        
        if ( !isalive( self ) )
        {
            return;
        }
        
        var_73a38d53 = self getseatoccupant( 0 );
        
        if ( isdefined( var_73a38d53 ) && var_73a38d53 != e_player )
        {
            continue;
        }
        
        if ( isalive( e_player ) && !e_player has_weapon( w_hero ) )
        {
            hint = e_player openluimenu( "TurretTakeTutorial" );
            
            while ( isdefined( self ) && !e_player laststand::player_is_in_laststand() && !e_player turret_pickup_button_pressed() && e_player istouching( t_pickup ) )
            {
                wait 0.05;
            }
            
            e_player closeluimenu( hint );
        }
    }
}

// Namespace ramses_util
// Params 0
// Checksum 0x4dd89839, Offset: 0x4f98
// Size: 0x1a
function turret_pickup_button_pressed()
{
    return self meleebuttonpressed();
}

// Namespace ramses_util
// Params 0
// Checksum 0x53b5fc46, Offset: 0x4fc0
// Size: 0x1a
function turret_exit_button_pressed()
{
    return self usebuttonpressed();
}

// Namespace ramses_util
// Params 0
// Checksum 0xd60e5180, Offset: 0x4fe8
// Size: 0x5c
function remove_inventory_turret()
{
    w_hero = getweapon( "lmg_light" );
    
    if ( self hasweapon( w_hero ) )
    {
        self takeweapon( w_hero );
    }
}

// Namespace ramses_util
// Params 3
// Checksum 0x77652d9b, Offset: 0x5050
// Size: 0xce
function magic_bullet_shield_till_notify( str_kill_mbs, b_disable_w_player_shot, str_phalanx_scatter_notify )
{
    self endon( #"death" );
    self.cybercomtargetstatusoverride = 1;
    util::magic_bullet_shield( self );
    
    if ( b_disable_w_player_shot )
    {
        self thread stop_magic_bullet_shield_on_player_damage( str_kill_mbs, str_phalanx_scatter_notify );
    }
    
    util::waittill_any_ents( level, str_kill_mbs, self, str_kill_mbs, self, "ram_kill_mb", self, "ccom_locked_on", self, "cybercom_action" );
    util::stop_magic_bullet_shield( self );
    self.cybercomtargetstatusoverride = undefined;
}

// Namespace ramses_util
// Params 2
// Checksum 0xe434eb02, Offset: 0x5128
// Size: 0xac
function stop_magic_bullet_shield_on_player_damage( str_kill_mbs, str_phalanx_scatter_notify )
{
    self endon( #"ram_kill_mb" );
    self endon( str_kill_mbs );
    level endon( str_kill_mbs );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        
        if ( isplayer( attacker ) )
        {
            if ( isdefined( str_phalanx_scatter_notify ) )
            {
                level notify( str_phalanx_scatter_notify );
                wait 0.05;
                level notify( str_kill_mbs );
            }
            
            self notify( str_kill_mbs );
        }
    }
}

// Namespace ramses_util
// Params 2
// Checksum 0xe23c262, Offset: 0x51e0
// Size: 0xda
function function_f08afb37( b_on, var_eebad467 )
{
    if ( !isdefined( b_on ) )
    {
        b_on = 1;
    }
    
    if ( !isdefined( var_eebad467 ) )
    {
        var_eebad467 = 0.1;
    }
    
    self endon( #"death" );
    
    if ( isalive( self ) && issentient( self ) )
    {
        if ( b_on )
        {
            self.attackeraccuracy = var_eebad467;
            self.overrideactordamage = &function_74e97bfe;
            self notify( #"hash_4ef4ba2d" );
            return;
        }
        
        self.attackeraccuracy = var_eebad467;
        self.overrideactordamage = undefined;
        self notify( #"hash_cb188399" );
    }
}

// Namespace ramses_util
// Params 12
// Checksum 0x65252b9b, Offset: 0x52c8
// Size: 0x10e
function function_74e97bfe( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name )
{
    if ( isplayer( e_attacker ) )
    {
        function_f08afb37( 0 );
        return n_damage;
    }
    
    if ( str_means_of_death == "MOD_EXPLOSIVE" || str_means_of_death == "MOD_GRENADE" || str_means_of_death == "MOD_MELEE" || str_means_of_death == "MOD_MELEE_WEAPON_BUTT" )
    {
        return n_damage;
    }
    
    n_damage = 1;
    self.health += 1;
    return n_damage;
}

// Namespace ramses_util
// Params 2
// Checksum 0xafdc88e1, Offset: 0x53e0
// Size: 0x54
function staged_battle_outcomes( str_robot_sm, str_human_sm )
{
    level thread complete_staged_fight_become_rusher( str_robot_sm, str_human_sm );
    level thread complete_staged_fight_enlarge_goal_radius( str_robot_sm, str_human_sm );
}

// Namespace ramses_util
// Params 2
// Checksum 0xe59e34b0, Offset: 0x5440
// Size: 0x132
function complete_staged_fight_become_rusher( str_robot_sm, str_human_sm )
{
    do
    {
        wait 0.5;
        a_human_ais = spawn_manager::get_ai( str_human_sm );
    }
    while ( a_human_ais.size > 0 || spawn_manager::is_enabled( str_human_sm ) );
    
    a_robot_ais = spawn_manager::get_ai( str_robot_sm );
    
    foreach ( e_robot in a_robot_ais )
    {
        e_robot cleargoalvolume();
        e_robot ai::set_behavior_attribute( "move_mode", "rusher" );
    }
}

// Namespace ramses_util
// Params 2
// Checksum 0x962d8e82, Offset: 0x5580
// Size: 0x10a
function complete_staged_fight_enlarge_goal_radius( str_robot_sm, str_human_sm )
{
    do
    {
        wait 0.5;
        a_robot_ais = spawn_manager::get_ai( str_robot_sm );
    }
    while ( a_robot_ais.size > 0 || spawn_manager::is_enabled( str_robot_sm ) );
    
    a_human_ais = spawn_manager::get_ai( str_human_sm );
    
    foreach ( e_human in a_human_ais )
    {
        e_human.goalradius = 1024;
    }
}

// Namespace ramses_util
// Params 7
// Checksum 0x89516abb, Offset: 0x5698
// Size: 0x9dc
function player_walk_speed_adjustment( e_rubber_band_to, str_endon, n_dist_min, n_dist_max, n_speed_scale_min, n_speed_scale_max, var_d04843e1 )
{
    if ( !isdefined( n_speed_scale_min ) )
    {
        n_speed_scale_min = 0;
    }
    
    if ( !isdefined( n_speed_scale_max ) )
    {
        n_speed_scale_max = 1;
    }
    
    if ( !isdefined( var_d04843e1 ) )
    {
        var_d04843e1 = 20;
    }
    
    assert( isplayer( self ), "<dev string:x26e>" );
    assert( isdefined( e_rubber_band_to ), "<dev string:x2a8>" );
    assert( isdefined( n_dist_min ), "<dev string:x2f3>" );
    assert( isdefined( n_dist_max ), "<dev string:x338>" );
    self endon( str_endon );
    self endon( #"death" );
    self endon( #"disconnect" );
    self thread _player_walk_speed_reset( str_endon );
    
    if ( !isarray( e_rubber_band_to ) )
    {
        var_2328c0bb = array( e_rubber_band_to );
    }
    else
    {
        var_2328c0bb = e_rubber_band_to;
    }
    
    var_6987b601 = function_36bdd3e9( var_2328c0bb );
    n_prev_speed = 1;
    n_speed_new = 1;
    n_height_diff = 0;
    var_6996430b = math::linear_map( var_d04843e1, 0, 190, 0, 1 );
    var_c0a77ece = distance2d( self.origin, function_36bdd3e9( var_2328c0bb ) );
    b_first_frame = 1;
    var_d1c1929b = 0;
    var_3e7026da = 0;
    var_b054adb3 = 0;
    var_857f3b54 = 0;
    var_36d81334 = 0;
    
    if ( isdefined( self.var_1e462286 ) )
    {
        b_first_frame = 0;
        n_prev_speed = self.var_1e462286;
        self setmovespeedscale( self.var_1e462286 );
    }
    
    if ( isdefined( self.var_622d06be ) )
    {
        n_height_diff = self.var_622d06be;
    }
    
    while ( true )
    {
        var_856fe6c6 = function_36bdd3e9( var_2328c0bb );
        var_e730dd94 = distance( var_6987b601, var_856fe6c6 );
        var_6987b601 = var_856fe6c6;
        var_8b261109 = var_e730dd94 * 20;
        
        if ( var_2328c0bb.size > 1 )
        {
            var_8aab3fca = arraycopy( var_2328c0bb );
            arrayremoveindex( var_8aab3fca, 0, 0 );
            var_5db32273 = var_2328c0bb[ 0 ].origin - function_36bdd3e9( var_8aab3fca );
        }
        else
        {
            var_5db32273 = anglestoforward( ( 0, var_2328c0bb[ 0 ].angles[ 1 ], 0 ) );
        }
        
        v_player_forward = anglestoforward( self.angles );
        var_b054adb3 = var_3e7026da;
        var_3e7026da = 0;
        
        foreach ( entity in var_2328c0bb )
        {
            var_e71cd44d = distance2d( self.origin, entity.origin );
            var_671d9784 = vectordot( vectornormalize( var_5db32273 ), vectornormalize( self.origin - entity.origin ) );
            
            if ( var_e71cd44d <= 24 && var_671d9784 <= -0.25 )
            {
                var_3e7026da = 1;
                continue;
            }
            
            if ( var_e71cd44d <= 32 && var_671d9784 <= -0.5 )
            {
                var_3e7026da = 1;
                continue;
            }
            
            if ( var_e71cd44d <= 40 && var_671d9784 <= -0.75 )
            {
                var_3e7026da = 1;
            }
        }
        
        if ( n_prev_speed <= var_6996430b && !var_3e7026da )
        {
            var_857f3b54++;
            
            if ( var_857f3b54 > 10 )
            {
                var_36d81334 = 1;
            }
        }
        else
        {
            var_857f3b54 = 0;
        }
        
        var_8c034a31 = distance2d( self.origin, var_856fe6c6 );
        
        if ( !var_36d81334 && abs( var_8c034a31 - var_c0a77ece ) < 12 && !( var_3e7026da || var_b054adb3 ) )
        {
            wait 0.05;
            continue;
        }
        
        var_c0a77ece = var_8c034a31;
        var_16d9beb6 = vectordot( vectornormalize( var_5db32273 ), self.origin - var_2328c0bb[ 0 ].origin );
        
        if ( var_16d9beb6 <= 0 )
        {
            var_d3fe8f49 = math::linear_map( var_8b261109, var_d04843e1, 190, 0, 1 );
            n_height_diff = abs( var_856fe6c6[ 2 ] - self.origin[ 2 ] );
            self.var_622d06be = n_height_diff;
            
            if ( var_8c034a31 > n_dist_max || n_height_diff > 160 )
            {
                n_speed_new = 1;
            }
            else if ( var_8c034a31 <= n_dist_min )
            {
                n_speed_new = var_d3fe8f49;
            }
            else
            {
                n_dist_frac = math::linear_map( var_8c034a31, n_dist_min, n_dist_max, 0.5, 1 );
                n_speed_new = n_dist_frac;
            }
            
            if ( n_speed_new < var_6996430b )
            {
                n_speed_new = var_6996430b;
            }
            
            if ( var_3e7026da )
            {
                var_d1c1929b++;
                n_speed_new = var_6996430b - 0.05 * var_d1c1929b;
                
                if ( n_speed_new < 0.05 )
                {
                    n_speed_new = 0.05;
                }
            }
            else if ( var_d1c1929b > 0 )
            {
                var_d1c1929b = 0;
            }
        }
        else if ( n_height_diff <= 160 )
        {
            n_speed_new = var_6996430b;
        }
        
        if ( !b_first_frame )
        {
            if ( abs( n_speed_new - n_prev_speed ) < 0.1 )
            {
                n_speed_new = n_prev_speed;
            }
            else if ( n_prev_speed > n_speed_new + 0.1 )
            {
                n_speed_new = n_prev_speed - 0.1;
            }
            else if ( n_prev_speed < n_speed_new - 0.1 && n_height_diff <= 100 )
            {
                n_speed_new = n_prev_speed + 0.1;
            }
        }
        
        var_36d81334 = 0;
        b_first_frame = 0;
        n_prev_speed = n_speed_new;
        self setmovespeedscale( n_speed_new );
        self.var_1e462286 = n_speed_new;
        wait 0.05;
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0x966b2d30, Offset: 0x6080
// Size: 0xb0
function function_36bdd3e9( a_ents )
{
    var_4ce0e4b7 = ( 0, 0, 0 );
    
    foreach ( ent in a_ents )
    {
        var_4ce0e4b7 += ent.origin;
    }
    
    return var_4ce0e4b7 / a_ents.size;
}

// Namespace ramses_util
// Params 1
// Checksum 0xb48b0500, Offset: 0x6138
// Size: 0x78
function _player_walk_speed_reset( str_endon )
{
    level waittill( str_endon, b_reset );
    
    if ( !isdefined( b_reset ) )
    {
        b_reset = 1;
    }
    
    if ( isdefined( b_reset ) && b_reset )
    {
        self setmovespeedscale( 1 );
        self.var_1e462286 = 1;
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0x129ca8ae, Offset: 0x61b8
// Size: 0x124
function scene_model_streamer_hint( a_ents )
{
    n_hint_time = 5;
    
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent.model ) )
        {
            streamermodelhint( ent.model, n_hint_time );
        }
    }
    
    if ( isdefined( self.scenes[ 0 ]._s.nextscenebundle ) )
    {
        scene::add_scene_func( self.scenes[ 0 ]._s.nextscenebundle, &scene_model_streamer_hint, "play" );
    }
}

// Namespace ramses_util
// Params 1
// Checksum 0xd5b98472, Offset: 0x62e8
// Size: 0x3c
function force_stream_1stpersonplayer( n_hint_time )
{
    if ( !isdefined( n_hint_time ) )
    {
        n_hint_time = 5;
    }
    
    streamermodelhint( "c_hro_player_male_egypt_viewbody", n_hint_time );
}

// Namespace ramses_util
// Params 2
// Checksum 0xd5983588, Offset: 0x6330
// Size: 0xac
function co_op_teleport_on_igc_end( str_scene, str_teleport_name )
{
    assert( isdefined( str_scene ), "<dev string:x37d>" );
    assert( isdefined( str_teleport_name ), "<dev string:x394>" );
    scene::add_scene_func( str_scene, &teleport_co_op_players_on_scene_done, "players_done" );
    level thread wait_for_scene_done( str_scene, str_teleport_name );
}

// Namespace ramses_util
// Params 1
// Checksum 0x7fb7914d, Offset: 0x63e8
// Size: 0x78
function teleport_co_op_players_on_scene_done( a_ents )
{
    if ( isdefined( self.scenes[ 0 ] ) && isdefined( self.scenes[ 0 ]._str_notify_name ) )
    {
        level notify( self.scenes[ 0 ]._str_notify_name + "_level_done" );
        return;
    }
    
    level notify( self.scriptbundlename + "_level_done" );
}

// Namespace ramses_util
// Params 2
// Checksum 0x44823b0c, Offset: 0x6468
// Size: 0x152
function wait_for_scene_done( str_scene, str_teleport_name )
{
    level waittill( str_scene + "_level_done" );
    
    foreach ( player in level.players )
    {
        player ghost();
    }
    
    util::teleport_players_igc( str_teleport_name );
    wait 0.5;
    
    foreach ( player in level.players )
    {
        player show();
    }
}

// Namespace ramses_util
// Params 2
// Checksum 0x6c62373e, Offset: 0x65c8
// Size: 0x1a2
function function_7255e66( b_enable, str_script_string )
{
    if ( !isdefined( b_enable ) )
    {
        b_enable = 1;
    }
    
    var_335c4513 = getentarray( "mobile_armory", "script_noteworthy" );
    
    foreach ( var_a9960583 in var_335c4513 )
    {
        if ( var_a9960583.script_string === str_script_string || isdefined( var_a9960583.gameobject ) && !isdefined( str_script_string ) )
        {
            if ( !b_enable )
            {
                var_a9960583 oed::disable_thermal();
                var_a9960583 oed::disable_keyline();
                var_a9960583.gameobject gameobjects::disable_object();
                continue;
            }
            
            var_a9960583.gameobject gameobjects::enable_object();
            var_a9960583 oed::enable_thermal();
            var_a9960583 oed::enable_keyline();
        }
    }
}

// Namespace ramses_util
// Params 0
// Checksum 0x525fc699, Offset: 0x6778
// Size: 0x7c
function function_f2f98cfc()
{
    var_3354e659 = getent( "hotel_gate", "targetname" );
    var_3354e659 ghost();
    var_3354e659 notsolid();
    umbragate_set( "hotel", 1 );
}

// Namespace ramses_util
// Params 0
// Checksum 0xd032cb28, Offset: 0x6800
// Size: 0x54
function function_1aeb2873()
{
    getent( "defend_street_gate", "targetname" ) delete();
    umbragate_set( "defend_street", 1 );
}

// Namespace ramses_util
// Params 0
// Checksum 0xb9ac6dbb, Offset: 0x6860
// Size: 0x4c
function function_fb967724()
{
    getent( "hotel_gate", "targetname" ) show();
    umbragate_set( "hotel", 0 );
}

