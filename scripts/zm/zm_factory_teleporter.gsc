#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/music_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_factory;

#namespace zm_factory_teleporter;

// Namespace zm_factory_teleporter
// Params 0, eflags: 0x2
// Checksum 0x91a8c2ae, Offset: 0x740
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_factory_teleporter", &__init__, &__main__, undefined );
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x660d51b4, Offset: 0x788
// Size: 0x16c
function __init__()
{
    level.dog_melee_range = 130;
    level thread dog_blocker_clip();
    level.teleport = [];
    level.active_links = 0;
    level.countdown = 0;
    level.teleport_delay = 2;
    level.teleport_cost = 1500;
    level.teleport_cooldown = 5;
    level.is_cooldown = 0;
    level.active_timer = -1;
    level.teleport_time = 0;
    level.teleport_pad_names = [];
    level.teleport_pad_names[ 0 ] = "a";
    level.teleport_pad_names[ 1 ] = "c";
    level.teleport_pad_names[ 2 ] = "b";
    level flag::init( "teleporter_pad_link_1" );
    level flag::init( "teleporter_pad_link_2" );
    level flag::init( "teleporter_pad_link_3" );
    visionset_mgr::register_info( "overlay", "zm_factory_teleport", 1, 61, 1, 1 );
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x2bb30da1, Offset: 0x900
// Size: 0x256
function __main__()
{
    for ( i = 0; i < 3 ; i++ )
    {
        trig = getent( "trigger_teleport_pad_" + i, "targetname" );
        
        if ( isdefined( trig ) )
        {
            level.teleporter_pad_trig[ i ] = trig;
        }
    }
    
    level thread teleport_pad_think( 0 );
    level thread teleport_pad_think( 1 );
    level thread teleport_pad_think( 2 );
    level thread teleport_core_think();
    level thread init_pack_door();
    level.no_dog_clip = 1;
    packapunch_see = getent( "packapunch_see", "targetname" );
    
    if ( isdefined( packapunch_see ) )
    {
        packapunch_see thread play_packa_see_vox();
    }
    
    level.teleport_ae_funcs = [];
    
    if ( !issplitscreen() )
    {
        level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_fov;
    }
    
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_shellshock;
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_shellshock_electric;
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_bw_vision;
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_red_vision;
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_flashy_vision;
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_flare_vision;
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0xffd88330, Offset: 0xb60
// Size: 0x336
function init_pack_door()
{
    collision = spawn( "script_model", ( -56, 467, 157 ) );
    collision setmodel( "collision_wall_128x128x10" );
    collision.angles = ( 0, 0, 0 );
    collision hide();
    door = getent( "pack_door", "targetname" );
    door movez( -50, 0.05, 0 );
    wait 1;
    level flag::wait_till( "start_zombie_round_logic" );
    door movez( 50, 1.5, 0 );
    door playsound( "evt_packa_door_1" );
    wait 2;
    collision delete();
    level flag::wait_till( "teleporter_pad_link_1" );
    door movez( -35, 1.5, 1 );
    door playsound( "evt_packa_door_2" );
    door thread packa_door_reminder();
    wait 2;
    level flag::wait_till( "teleporter_pad_link_2" );
    door movez( -25, 1.5, 1 );
    door playsound( "evt_packa_door_2" );
    wait 2;
    level flag::wait_till( "teleporter_pad_link_3" );
    door movez( -60, 1.5, 1 );
    door playsound( "evt_packa_door_2" );
    clip = getentarray( "pack_door_clip", "targetname" );
    
    for ( i = 0; i < clip.size ; i++ )
    {
        clip[ i ] connectpaths();
        clip[ i ] delete();
    }
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0xff47d615, Offset: 0xea0
// Size: 0x12e
function pad_manager()
{
    for ( i = 0; i < level.teleporter_pad_trig.size ; i++ )
    {
        level.teleporter_pad_trig[ i ] sethintstring( &"ZOMBIE_TELEPORT_COOLDOWN" );
        level.teleporter_pad_trig[ i ] teleport_trigger_invisible( 0 );
    }
    
    level.is_cooldown = 1;
    wait level.teleport_cooldown;
    level.is_cooldown = 0;
    
    for ( i = 0; i < level.teleporter_pad_trig.size ; i++ )
    {
        if ( level.teleporter_pad_trig[ i ].teleport_active )
        {
            level.teleporter_pad_trig[ i ] sethintstring( &"ZOMBIE_TELEPORT_TO_CORE" );
            continue;
        }
        
        level.teleporter_pad_trig[ i ] sethintstring( &"ZOMBIE_LINK_TPAD" );
    }
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0xfc60d137, Offset: 0xfd8
// Size: 0x3dc
function teleport_pad_think( index )
{
    tele_help = getent( "tele_help_" + index, "targetname" );
    
    if ( isdefined( tele_help ) )
    {
        tele_help thread play_tele_help_vox();
    }
    
    active = 0;
    level.teleport[ index ] = "waiting";
    trigger = level.teleporter_pad_trig[ index ];
    trigger setcursorhint( "HINT_NOICON" );
    trigger sethintstring( &"ZOMBIE_NEED_POWER" );
    level flag::wait_till( "power_on" );
    trigger sethintstring( &"ZOMBIE_POWER_UP_TPAD" );
    trigger.teleport_active = 0;
    
    if ( isdefined( trigger ) )
    {
        while ( !active )
        {
            trigger waittill( #"trigger" );
            
            if ( level.active_links < 3 )
            {
                trigger_core = getent( "trigger_teleport_core", "targetname" );
                trigger_core teleport_trigger_invisible( 0 );
            }
            
            for ( i = 0; i < level.teleporter_pad_trig.size ; i++ )
            {
                level.teleporter_pad_trig[ i ] teleport_trigger_invisible( 1 );
            }
            
            level.teleport[ index ] = "timer_on";
            trigger thread teleport_pad_countdown( index, 30 );
            teleporter_vo( "countdown", trigger );
            
            while ( level.teleport[ index ] == "timer_on" )
            {
                wait 0.05;
            }
            
            if ( level.teleport[ index ] == "active" )
            {
                active = 1;
                level util::clientnotify( "pw" + index );
                level util::clientnotify( "tp" + index );
                teleporter_wire_wait( index );
                trigger thread player_teleporting( index );
            }
            else
            {
                for ( i = 0; i < level.teleporter_pad_trig.size ; i++ )
                {
                    level.teleporter_pad_trig[ i ] teleport_trigger_invisible( 0 );
                }
            }
            
            wait 0.05;
        }
        
        if ( level.is_cooldown )
        {
            trigger sethintstring( &"ZOMBIE_TELEPORT_COOLDOWN" );
            trigger teleport_trigger_invisible( 0 );
            trigger.teleport_active = 1;
            return;
        }
        
        trigger thread teleport_pad_active_think( index );
    }
}

// Namespace zm_factory_teleporter
// Params 2
// Checksum 0x8485c858, Offset: 0x13c0
// Size: 0x154
function teleport_pad_countdown( index, time )
{
    self endon( #"stop_countdown" );
    
    if ( level.active_timer < 0 )
    {
        level.active_timer = index;
    }
    
    level.countdown++;
    self thread sndcountdown();
    level util::clientnotify( "TRf" );
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] thread zm_timer::start_timer( time + 1, "stop_countdown" );
    }
    
    wait time + 1;
    
    if ( level.active_timer == index )
    {
        level.active_timer = -1;
    }
    
    level.teleport[ index ] = "timer_off";
    level util::clientnotify( "TRs" );
    level.countdown--;
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x5ea3d68e, Offset: 0x1520
// Size: 0x13c
function sndcountdown()
{
    self endon( #"stop_countdown" );
    clock_sound = spawn( "script_origin", ( 0, 0, 0 ) );
    clock_sound thread clock_timer();
    level thread zm_factory::sndpa_dovox( "vox_maxis_teleporter_ultimatum_0" );
    count = 30;
    num = 11;
    
    while ( count > 0 )
    {
        play = count == 20 || count == 15 || count <= 10;
        
        if ( play )
        {
            level thread zm_factory::sndpa_dovox( "vox_maxis_teleporter_count_" + num, undefined, 1 );
            num--;
        }
        
        wait 1;
        count--;
    }
    
    level notify( #"stop_countdown" );
    level thread zm_factory::sndpa_dovox( "vox_maxis_teleporter_expired_0" );
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x977560f1, Offset: 0x1668
// Size: 0xec
function clock_timer()
{
    level util::delay( 0, undefined, &zm_audio::sndmusicsystem_playstate, "timer" );
    self playloopsound( "evt_clock_tick_1sec" );
    level waittill( #"stop_countdown" );
    
    if ( isdefined( level.musicsystem.currentstate ) && level.musicsystem.currentstate == "timer" )
    {
        level thread zm_audio::sndmusicsystem_stopandflush();
        music::setmusicstate( "none" );
    }
    
    self stoploopsound( 0 );
    self delete();
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0xd3666f00, Offset: 0x1760
// Size: 0x130
function teleport_pad_active_think( index )
{
    self setcursorhint( "HINT_NOICON" );
    self.teleport_active = 1;
    user = undefined;
    
    while ( true )
    {
        self waittill( #"trigger", user );
        
        if ( zm_utility::is_player_valid( user ) && user zm_score::can_player_purchase( level.teleport_cost ) && !level.is_cooldown )
        {
            for ( i = 0; i < level.teleporter_pad_trig.size ; i++ )
            {
                level.teleporter_pad_trig[ i ] teleport_trigger_invisible( 1 );
            }
            
            user zm_score::minus_to_player_score( level.teleport_cost );
            self player_teleporting( index );
        }
    }
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0xa74f6ab9, Offset: 0x1898
// Size: 0x230
function player_teleporting( index )
{
    time_since_last_teleport = gettime() - level.teleport_time;
    exploder::exploder_duration( "teleporter_" + level.teleport_pad_names[ index ] + "_teleporting", 5.3 );
    exploder::exploder_duration( "mainframe_warm_up", 4.8 );
    level util::clientnotify( "tpw" + index );
    level thread zm_factory::sndpa_dovox( "vox_maxis_teleporter_success_0" );
    self thread teleport_pad_player_fx( level.teleport_delay );
    self thread teleport_2d_audio();
    self thread teleport_nuke( 20, 300 );
    wait level.teleport_delay;
    self notify( #"fx_done" );
    self thread zm_factory::function_c7b37638();
    self teleport_players();
    
    if ( level.is_cooldown == 0 )
    {
        thread pad_manager();
    }
    
    wait 2;
    ss = struct::get( "teleporter_powerup", "targetname" );
    
    if ( isdefined( ss ) )
    {
        ss thread zm_powerups::special_powerup_drop( ss.origin );
    }
    
    if ( time_since_last_teleport < 60000 && level.active_links == 3 && level.round_number > 20 )
    {
        thread zm_utility::play_sound_2d( "vox_sam_nospawn" );
    }
    
    level.teleport_time = gettime();
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0xcbba02aa, Offset: 0x1ad0
// Size: 0x86
function teleport_trigger_invisible( enable )
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( players[ i ] ) )
        {
            self setinvisibletoplayer( players[ i ], enable );
        }
    }
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0xee9a7e5a, Offset: 0x1b60
// Size: 0x8e, Type: bool
function player_is_near_pad( player )
{
    radius = 88;
    scale_factor = 2;
    dist = distance2d( player.origin, self.origin );
    dist_touching = radius * scale_factor;
    
    if ( dist < dist_touching )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0x5a44095f, Offset: 0x1bf8
// Size: 0xb6
function teleport_pad_player_fx( duration )
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( players[ i ] ) )
        {
            if ( self player_is_near_pad( players[ i ] ) )
            {
                visionset_mgr::activate( "overlay", "zm_trap_electric", players[ i ], 1.25, 1.25 );
            }
        }
    }
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x2acd89de, Offset: 0x1cb8
// Size: 0x8b4
function teleport_players()
{
    player_radius = 16;
    players = getplayers();
    core_pos = [];
    occupied = [];
    image_room = [];
    players_touching = [];
    player_idx = 0;
    prone_offset = ( 0, 0, 49 );
    crouch_offset = ( 0, 0, 20 );
    stand_offset = ( 0, 0, 0 );
    
    for ( i = 0; i < 4 ; i++ )
    {
        core_pos[ i ] = getent( "origin_teleport_player_" + i, "targetname" );
        occupied[ i ] = 0;
        image_room[ i ] = getent( "teleport_room_" + i, "targetname" );
        
        if ( isdefined( players[ i ] ) )
        {
            if ( self player_is_near_pad( players[ i ] ) )
            {
                players[ i ].b_teleporting = 1;
                players_touching[ player_idx ] = i;
                player_idx++;
                
                if ( isdefined( image_room[ i ] ) )
                {
                    visionset_mgr::deactivate( "overlay", "zm_trap_electric", players[ i ] );
                    visionset_mgr::activate( "overlay", "zm_factory_teleport", players[ i ] );
                    players[ i ] disableoffhandweapons();
                    players[ i ] disableweapons();
                    
                    if ( players[ i ] getstance() == "prone" )
                    {
                        desired_origin = image_room[ i ].origin + prone_offset;
                    }
                    else if ( players[ i ] getstance() == "crouch" )
                    {
                        desired_origin = image_room[ i ].origin + crouch_offset;
                    }
                    else
                    {
                        desired_origin = image_room[ i ].origin + stand_offset;
                    }
                    
                    players[ i ].teleport_origin = spawn( "script_origin", players[ i ].origin );
                    players[ i ].teleport_origin.angles = players[ i ].angles;
                    players[ i ] linkto( players[ i ].teleport_origin );
                    players[ i ].teleport_origin.origin = desired_origin;
                    players[ i ] freezecontrols( 1 );
                    util::wait_network_frame();
                    
                    if ( isdefined( players[ i ] ) )
                    {
                        util::setclientsysstate( "levelNotify", "black_box_start", players[ i ] );
                        players[ i ].teleport_origin.angles = image_room[ i ].angles;
                    }
                }
            }
        }
    }
    
    wait 2;
    core = getent( "trigger_teleport_core", "targetname" );
    core thread teleport_nuke( undefined, 300 );
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( players[ i ] ) )
        {
            for ( j = 0; j < 4 ; j++ )
            {
                if ( !occupied[ j ] )
                {
                    dist = distance2d( core_pos[ j ].origin, players[ i ].origin );
                    
                    if ( dist < player_radius )
                    {
                        occupied[ j ] = 1;
                    }
                }
            }
            
            util::setclientsysstate( "levelNotify", "black_box_end", players[ i ] );
        }
    }
    
    util::wait_network_frame();
    
    for ( i = 0; i < players_touching.size ; i++ )
    {
        player_idx = players_touching[ i ];
        player = players[ player_idx ];
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        slot = i;
        start = 0;
        
        while ( occupied[ slot ] && start < 4 )
        {
            start++;
            slot++;
            
            if ( slot >= 4 )
            {
                slot = 0;
            }
        }
        
        occupied[ slot ] = 1;
        pos_name = "origin_teleport_player_" + slot;
        teleport_core_pos = getent( pos_name, "targetname" );
        player unlink();
        assert( isdefined( player.teleport_origin ) );
        player.teleport_origin delete();
        player.teleport_origin = undefined;
        visionset_mgr::deactivate( "overlay", "zm_factory_teleport", player );
        player enableweapons();
        player enableoffhandweapons();
        player setorigin( core_pos[ slot ].origin );
        player setplayerangles( core_pos[ slot ].angles );
        player freezecontrols( 0 );
        player thread teleport_aftereffects();
        vox_rand = randomintrange( 1, 100 );
        
        if ( vox_rand <= 2 )
        {
        }
        
        player.b_teleporting = 0;
    }
    
    exploder::exploder_duration( "mainframe_arrival", 1.7 );
    exploder::exploder_duration( "mainframe_steam", 14.6 );
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0xe420c0be, Offset: 0x2578
// Size: 0x100
function teleport_core_hint_update()
{
    self setcursorhint( "HINT_NOICON" );
    
    while ( true )
    {
        if ( !level flag::get( "power_on" ) )
        {
            self sethintstring( &"ZOMBIE_NEED_POWER" );
        }
        else if ( teleport_pads_are_active() )
        {
            self sethintstring( &"ZOMBIE_LINK_TPAD" );
        }
        else if ( level.active_links == 0 )
        {
            self sethintstring( &"ZOMBIE_INACTIVE_TPAD" );
        }
        else
        {
            self sethintstring( "" );
        }
        
        wait 0.05;
    }
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x18bc7a90, Offset: 0x2680
// Size: 0x428
function teleport_core_think()
{
    trigger = getent( "trigger_teleport_core", "targetname" );
    
    if ( isdefined( trigger ) )
    {
        trigger thread teleport_core_hint_update();
        level flag::wait_till( "power_on" );
        
        /#
            if ( getdvarint( "<dev string:x28>" ) >= 6 )
            {
                for ( i = 0; i < level.teleport.size ; i++ )
                {
                    level.teleport[ i ] = "<dev string:x35>";
                }
            }
        #/
        
        while ( true )
        {
            if ( teleport_pads_are_active() )
            {
                cheat = 0;
                
                /#
                    if ( getdvarint( "<dev string:x28>" ) >= 6 )
                    {
                        cheat = 1;
                    }
                #/
                
                if ( !cheat )
                {
                    trigger waittill( #"trigger" );
                }
                
                for ( i = 0; i < level.teleport.size ; i++ )
                {
                    if ( isdefined( level.teleport[ i ] ) )
                    {
                        if ( level.teleport[ i ] == "timer_on" )
                        {
                            level.teleport[ i ] = "active";
                            level.active_links++;
                            level flag::set( "teleporter_pad_link_" + level.active_links );
                            level thread zm_factory::sndpa_dovox( "vox_maxis_teleporter_" + i + "active_0" );
                            level util::delay( 10, undefined, &zm_audio::sndmusicsystem_playstate, "teleporter_" + level.active_links );
                            exploder::exploder( "teleporter_" + level.teleport_pad_names[ i ] + "_linked" );
                            exploder::exploder( "lgt_teleporter_" + level.teleport_pad_names[ i ] + "_linked" );
                            exploder::exploder_duration( "mainframe_steam", 14.6 );
                            
                            if ( level.active_links == 3 )
                            {
                                exploder::exploder_duration( "mainframe_link_all", 4.6 );
                                exploder::exploder( "mainframe_ambient" );
                                level util::clientnotify( "pap1" );
                                teleporter_vo( "linkall", trigger );
                                earthquake( 0.3, 2, trigger.origin, 3700 );
                            }
                            
                            pad = "trigger_teleport_pad_" + i;
                            trigger_pad = getent( pad, "targetname" );
                            trigger_pad stop_countdown();
                            level util::clientnotify( "TRs" );
                            level.active_timer = -1;
                        }
                    }
                }
            }
            
            wait 0.05;
        }
    }
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0xedb4d5c3, Offset: 0x2ab0
// Size: 0x80
function stop_countdown()
{
    self notify( #"stop_countdown" );
    level notify( #"stop_countdown" );
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] notify( #"stop_countdown" );
    }
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x7d903a8d, Offset: 0x2b38
// Size: 0x72, Type: bool
function teleport_pads_are_active()
{
    if ( isdefined( level.teleport ) )
    {
        for ( i = 0; i < level.teleport.size ; i++ )
        {
            if ( isdefined( level.teleport[ i ] ) )
            {
                if ( level.teleport[ i ] == "timer_on" )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x12fd169c, Offset: 0x2bb8
// Size: 0xca
function teleport_2d_audio()
{
    self endon( #"fx_done" );
    
    while ( true )
    {
        players = getplayers();
        wait 1.7;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( isdefined( players[ i ] ) )
            {
                if ( self player_is_near_pad( players[ i ] ) )
                {
                    util::setclientsysstate( "levelNotify", "t2d", players[ i ] );
                }
            }
        }
    }
}

// Namespace zm_factory_teleporter
// Params 2
// Checksum 0xf4b7a4ca, Offset: 0x2c90
// Size: 0x17e
function teleport_nuke( max_zombies, range )
{
    zombies = getaispeciesarray( level.zombie_team );
    zombies = util::get_array_of_closest( self.origin, zombies, undefined, max_zombies, range );
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        wait randomfloatrange( 0.2, 0.3 );
        
        if ( !isdefined( zombies[ i ] ) )
        {
            continue;
        }
        
        if ( zm_utility::is_magic_bullet_shield_enabled( zombies[ i ] ) )
        {
            continue;
        }
        
        if ( !zombies[ i ].isdog )
        {
            zombies[ i ] zombie_utility::zombie_head_gib();
        }
        
        zombies[ i ] dodamage( 10000, zombies[ i ].origin );
        playsoundatposition( "nuked", zombies[ i ].origin );
    }
}

// Namespace zm_factory_teleporter
// Params 2
// Checksum 0x22e4a439, Offset: 0x2e18
// Size: 0x140
function teleporter_vo( tele_vo_type, location )
{
    if ( !isdefined( location ) )
    {
        self thread teleporter_vo_play( tele_vo_type, 2 );
        return;
    }
    
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( distance( players[ i ].origin, location.origin ) < 64 )
        {
            switch ( tele_vo_type )
            {
                default:
                    players[ i ] thread teleporter_vo_play( "tele_linkall" );
                    break;
                case "countdown":
                    players[ i ] thread teleporter_vo_play( "tele_count", 3 );
                    break;
            }
        }
    }
}

// Namespace zm_factory_teleporter
// Params 2
// Checksum 0x5fe4ebab, Offset: 0x2f60
// Size: 0x2c
function teleporter_vo_play( vox_type, pre_wait )
{
    if ( !isdefined( pre_wait ) )
    {
        pre_wait = 0;
    }
    
    wait pre_wait;
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x8a4c7ac1, Offset: 0x2f98
// Size: 0xb0
function play_tele_help_vox()
{
    level endon( #"tele_help_end" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( level flag::get( "power_on" ) )
        {
            who thread teleporter_vo_play( "tele_help" );
            level notify( #"tele_help_end" );
        }
        
        while ( isdefined( who ) && who istouching( self ) )
        {
            wait 0.1;
        }
    }
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x7d45dfc9, Offset: 0x3050
// Size: 0x5c
function play_packa_see_vox()
{
    wait 10;
    
    if ( !level flag::get( "teleporter_pad_link_3" ) )
    {
        self waittill( #"trigger", who );
        who thread teleporter_vo_play( "perk_packa_see" );
    }
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0xae12c567, Offset: 0x30b8
// Size: 0xbe
function teleporter_wire_wait( index )
{
    targ = struct::get( "pad_" + index + "_wire", "targetname" );
    
    if ( !isdefined( targ ) )
    {
        return;
    }
    
    while ( isdefined( targ ) )
    {
        if ( isdefined( targ.target ) )
        {
            target = struct::get( targ.target, "targetname" );
            wait 0.1;
            targ = target;
            continue;
        }
        
        break;
    }
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x50d9b2, Offset: 0x3180
// Size: 0x9a
function teleport_aftereffects()
{
    if ( getdvarstring( "factoryAftereffectOverride" ) == "-1" )
    {
        self thread [[ level.teleport_ae_funcs[ randomint( level.teleport_ae_funcs.size ) ] ]]();
        return;
    }
    
    self thread [[ level.teleport_ae_funcs[ int( getdvarstring( "factoryAftereffectOverride" ) ) ] ]]();
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x509b45fb, Offset: 0x3228
// Size: 0x44
function teleport_aftereffect_shellshock()
{
    println( "<dev string:x3e>" );
    self shellshock( "explosion", 4 );
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0xe24ffd95, Offset: 0x3278
// Size: 0x44
function teleport_aftereffect_shellshock_electric()
{
    println( "<dev string:x5c>" );
    self shellshock( "electrocution", 4 );
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0xeaf2bad, Offset: 0x32c8
// Size: 0x24
function teleport_aftereffect_fov()
{
    util::setclientsysstate( "levelNotify", "tae", self );
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0x9c685e9, Offset: 0x32f8
// Size: 0x2c
function teleport_aftereffect_bw_vision( localclientnum )
{
    util::setclientsysstate( "levelNotify", "tae", self );
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0x3d87ea37, Offset: 0x3330
// Size: 0x2c
function teleport_aftereffect_red_vision( localclientnum )
{
    util::setclientsysstate( "levelNotify", "tae", self );
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0x715742, Offset: 0x3368
// Size: 0x2c
function teleport_aftereffect_flashy_vision( localclientnum )
{
    util::setclientsysstate( "levelNotify", "tae", self );
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0x3646d2a3, Offset: 0x33a0
// Size: 0x2c
function teleport_aftereffect_flare_vision( localclientnum )
{
    util::setclientsysstate( "levelNotify", "tae", self );
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x934b1147, Offset: 0x33d8
// Size: 0x76
function packa_door_reminder()
{
    while ( !level flag::get( "teleporter_pad_link_3" ) )
    {
        rand = randomintrange( 4, 16 );
        self playsound( "evt_packa_door_hitch" );
        wait rand;
    }
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x1b2c580b, Offset: 0x3458
// Size: 0xf4
function dog_blocker_clip()
{
    collision = spawn( "script_model", ( -106, -2294, 216 ) );
    collision setmodel( "collision_wall_128x128x10" );
    collision.angles = ( 0, 37.2, 0 );
    collision hide();
    collision = spawn( "script_model", ( -1208, -439, 363 ) );
    collision setmodel( "collision_wall_128x128x10" );
    collision.angles = ( 0, 0, 0 );
    collision hide();
}

