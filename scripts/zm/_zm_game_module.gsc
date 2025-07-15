#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;

#namespace zm_game_module;

// Namespace zm_game_module
// Params 7
// Checksum 0xb699760b, Offset: 0x210
// Size: 0x238
function register_game_module( index, module_name, pre_init_func, post_init_func, pre_init_zombie_spawn_func, post_init_zombie_spawn_func, hub_start_func )
{
    if ( !isdefined( level._game_modules ) )
    {
        level._game_modules = [];
        level._num_registered_game_modules = 0;
    }
    
    for ( i = 0; i < level._num_registered_game_modules ; i++ )
    {
        if ( !isdefined( level._game_modules[ i ] ) )
        {
            continue;
        }
        
        if ( isdefined( level._game_modules[ i ].index ) && level._game_modules[ i ].index == index )
        {
            assert( level._game_modules[ i ].index != index, "<dev string:x28>" + index + "<dev string:x58>" );
        }
    }
    
    level._game_modules[ level._num_registered_game_modules ] = spawnstruct();
    level._game_modules[ level._num_registered_game_modules ].index = index;
    level._game_modules[ level._num_registered_game_modules ].module_name = module_name;
    level._game_modules[ level._num_registered_game_modules ].pre_init_func = pre_init_func;
    level._game_modules[ level._num_registered_game_modules ].post_init_func = post_init_func;
    level._game_modules[ level._num_registered_game_modules ].pre_init_zombie_spawn_func = pre_init_zombie_spawn_func;
    level._game_modules[ level._num_registered_game_modules ].post_init_zombie_spawn_func = post_init_zombie_spawn_func;
    level._game_modules[ level._num_registered_game_modules ].hub_start_func = hub_start_func;
    level._num_registered_game_modules++;
}

// Namespace zm_game_module
// Params 1
// Checksum 0xc303764, Offset: 0x450
// Size: 0xac
function set_current_game_module( game_module_index )
{
    if ( !isdefined( game_module_index ) )
    {
        level.current_game_module = level.game_module_classic_index;
        level.scr_zm_game_module = level.game_module_classic_index;
        return;
    }
    
    game_module = get_game_module( game_module_index );
    
    if ( !isdefined( game_module ) )
    {
        assert( isdefined( game_module ), "<dev string:x5a>" + game_module_index + "<dev string:x58>" );
        return;
    }
    
    level.current_game_module = game_module_index;
}

// Namespace zm_game_module
// Params 0
// Checksum 0xa9200637, Offset: 0x508
// Size: 0x1a
function get_current_game_module()
{
    return get_game_module( level.current_game_module );
}

// Namespace zm_game_module
// Params 1
// Checksum 0xdc5d0d66, Offset: 0x530
// Size: 0x7a
function get_game_module( game_module_index )
{
    if ( !isdefined( game_module_index ) )
    {
        return undefined;
    }
    
    for ( i = 0; i < level._game_modules.size ; i++ )
    {
        if ( level._game_modules[ i ].index == game_module_index )
        {
            return level._game_modules[ i ];
        }
    }
    
    return undefined;
}

// Namespace zm_game_module
// Params 0
// Checksum 0xef8244e8, Offset: 0x5b8
// Size: 0x5c
function game_module_pre_zombie_spawn_init()
{
    current_module = get_current_game_module();
    
    if ( !isdefined( current_module ) || !isdefined( current_module.pre_init_zombie_spawn_func ) )
    {
        return;
    }
    
    self [[ current_module.pre_init_zombie_spawn_func ]]();
}

// Namespace zm_game_module
// Params 0
// Checksum 0xda46626f, Offset: 0x620
// Size: 0x5c
function game_module_post_zombie_spawn_init()
{
    current_module = get_current_game_module();
    
    if ( !isdefined( current_module ) || !isdefined( current_module.post_init_zombie_spawn_func ) )
    {
        return;
    }
    
    self [[ current_module.post_init_zombie_spawn_func ]]();
}

// Namespace zm_game_module
// Params 1
// Checksum 0xf2433d7e, Offset: 0x688
// Size: 0x76
function freeze_players( freeze )
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] util::freeze_player_controls( freeze );
    }
}

// Namespace zm_game_module
// Params 0
// Checksum 0xecb72f48, Offset: 0x708
// Size: 0x10a
function respawn_spectators_and_freeze_players()
{
    players = getplayers();
    
    foreach ( player in players )
    {
        if ( player.sessionstate == "spectator" )
        {
            if ( isdefined( player.spectate_hud ) )
            {
                player.spectate_hud destroy();
            }
            
            player [[ level.spawnplayer ]]();
        }
        
        player util::freeze_player_controls( 1 );
    }
}

// Namespace zm_game_module
// Params 10
// Checksum 0x96304f2e, Offset: 0x820
// Size: 0xc8
function damage_callback_no_pvp_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, eapon, vpoint, vdir, shitloc, psoffsettime )
{
    if ( isdefined( eattacker ) && isplayer( eattacker ) && eattacker == self )
    {
        return idamage;
    }
    
    if ( isdefined( eattacker ) && !isplayer( eattacker ) )
    {
        return idamage;
    }
    
    if ( !isdefined( eattacker ) )
    {
        return idamage;
    }
    
    return 0;
}

// Namespace zm_game_module
// Params 0
// Checksum 0xf83d6d4c, Offset: 0x8f0
// Size: 0xba
function respawn_players()
{
    players = getplayers();
    
    foreach ( player in players )
    {
        player [[ level.spawnplayer ]]();
        player util::freeze_player_controls( 1 );
    }
}

// Namespace zm_game_module
// Params 1
// Checksum 0x727eb208, Offset: 0x9b8
// Size: 0x10a
function zombie_goto_round( target_round )
{
    level notify( #"restart_round" );
    
    if ( target_round < 1 )
    {
        target_round = 1;
    }
    
    level.zombie_total = 0;
    zombie_utility::ai_calculate_health( target_round );
    zombies = zombie_utility::get_round_enemy_array();
    
    if ( isdefined( zombies ) )
    {
        for ( i = 0; i < zombies.size ; i++ )
        {
            zombies[ i ] dodamage( zombies[ i ].health + 666, zombies[ i ].origin );
        }
    }
    
    respawn_players();
    wait 1;
}

// Namespace zm_game_module
// Params 0
// Checksum 0xe8377067, Offset: 0xad0
// Size: 0x24
function make_supersprinter()
{
    self zombie_utility::set_zombie_run_cycle( "super_sprint" );
}

// Namespace zm_game_module
// Params 1
// Checksum 0x41c6c77, Offset: 0xb00
// Size: 0x384
function game_module_custom_intermission( intermission_struct )
{
    self closeingamemenu();
    level endon( #"stop_intermission" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self notify( #"_zombie_game_over" );
    self.score = self.score_total;
    self.sessionstate = "intermission";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.friendlydamage = undefined;
    s_point = struct::get( intermission_struct, "targetname" );
    
    if ( !isdefined( level.intermission_cam_model ) )
    {
        level.intermission_cam_model = spawn( "script_model", s_point.origin );
        level.intermission_cam_model.angles = s_point.angles;
        level.intermission_cam_model setmodel( "tag_origin" );
    }
    
    self.game_over_bg = newclienthudelem( self );
    self.game_over_bg.horzalign = "fullscreen";
    self.game_over_bg.vertalign = "fullscreen";
    self.game_over_bg setshader( "black", 640, 480 );
    self.game_over_bg.alpha = 1;
    self spawn( level.intermission_cam_model.origin, level.intermission_cam_model.angles );
    self camerasetposition( level.intermission_cam_model );
    self camerasetlookat();
    self cameraactivate( 1 );
    self linkto( level.intermission_cam_model );
    level.intermission_cam_model moveto( struct::get( s_point.target, "targetname" ).origin, 12 );
    
    if ( isdefined( level.intermission_cam_model.angles ) )
    {
        level.intermission_cam_model rotateto( struct::get( s_point.target, "targetname" ).angles, 12 );
    }
    
    self.game_over_bg fadeovertime( 2 );
    self.game_over_bg.alpha = 0;
    wait 2;
    self.game_over_bg thread zm::fade_up_over_time( 1 );
}

// Namespace zm_game_module
// Params 4
// Checksum 0xbd00a67b, Offset: 0xe90
// Size: 0x120
function create_fireworks( launch_spots, min_wait, max_wait, randomize )
{
    level endon( #"stop_fireworks" );
    
    while ( true )
    {
        if ( isdefined( randomize ) && randomize )
        {
            launch_spots = array::randomize( launch_spots );
        }
        
        foreach ( spot in launch_spots )
        {
            level thread fireworks_launch( spot );
            wait randomfloatrange( min_wait, max_wait );
        }
        
        wait randomfloatrange( min_wait, max_wait );
    }
}

// Namespace zm_game_module
// Params 1
// Checksum 0xac5616a1, Offset: 0xfb8
// Size: 0x2bc
function fireworks_launch( launch_spot )
{
    firework = spawn( "script_model", launch_spot.origin + ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 ) );
    firework setmodel( "tag_origin" );
    util::wait_network_frame();
    playfxontag( level._effect[ "fw_trail_cheap" ], firework, "tag_origin" );
    firework playloopsound( "zmb_souls_loop", 0.75 );
    dest = launch_spot;
    
    while ( isdefined( dest ) && isdefined( dest.target ) )
    {
        random_offset = ( randomintrange( -60, 60 ), randomintrange( -60, 60 ), 0 );
        new_dests = struct::get_array( dest.target, "targetname" );
        new_dest = array::random( new_dests );
        dest = new_dest;
        dist = distance( new_dest.origin + random_offset, firework.origin );
        time = dist / 700;
        firework moveto( new_dest.origin + random_offset, time );
        firework waittill( #"movedone" );
    }
    
    firework playsound( "zmb_souls_end" );
    playfx( level._effect[ "fw_pre_burst" ], firework.origin );
    firework delete();
}

