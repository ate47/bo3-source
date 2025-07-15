#using scripts/codescripts/struct;
#using scripts/shared/ai/margwa;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_ai_margwa_elemental;
#using scripts/zm/_zm_ai_margwa_no_idgun;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_genesis_spiders;
#using scripts/zm/_zm_light_zombie;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_shadow_zombie;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_genesis;
#using scripts/zm/zm_genesis_apothicon_fury;
#using scripts/zm/zm_genesis_cleanup_mgr;
#using scripts/zm/zm_genesis_fx;
#using scripts/zm/zm_genesis_keeper;
#using scripts/zm/zm_genesis_mechz;
#using scripts/zm/zm_genesis_power;
#using scripts/zm/zm_genesis_shadowman;
#using scripts/zm/zm_genesis_spiders;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_vo;
#using scripts/zm/zm_genesis_wasp;

#namespace zm_genesis_ai_spawning;

// Namespace zm_genesis_ai_spawning
// Params 0, eflags: 0x2
// Checksum 0xa9a80da0, Offset: 0x728
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_genesis_ai_spawning", &__init__, undefined, undefined );
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0xc477dcd4, Offset: 0x768
// Size: 0x11c
function __init__()
{
    clientfield::register( "toplayer", "chaos_postfx_set", 15000, 1, "int" );
    clientfield::register( "world", "chaos_fog_bank_switch", 15000, 1, "int" );
    visionset_mgr::register_info( "visionset", "zm_chaos_organge", 15000, 100, 1, 1 );
    level thread function_a70ab4c3();
    level.var_8cd70c57 = 0;
    level.var_c4336559 = [];
    level.var_c4336559[ "parasite" ] = 0;
    level.var_c4336559[ "apothicon_fury" ] = 0;
    level.var_c4336559[ "keeper" ] = 0;
    
    /#
        level thread function_28e53883();
    #/
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x3b11c6, Offset: 0x890
// Size: 0x138
function function_a70ab4c3()
{
    level.var_783db6ab = randomintrange( 5, 7 );
    
    while ( true )
    {
        level waittill( #"between_round_over" );
        
        if ( level.round_number > level.var_783db6ab )
        {
            level.var_783db6ab = level.round_number + randomintrange( 2, 4 );
        }
        
        if ( level.round_number == level.var_783db6ab )
        {
            if ( isdefined( level.var_256b19d4 ) && level.var_256b19d4 )
            {
                level.var_783db6ab++;
                continue;
            }
            
            level.sndmusicspecialround = 1;
            level thread zm_audio::sndmusicsystem_playstate( "chaos_start" );
            function_c87827a3();
            level.var_783db6ab = level.round_number + randomintrange( 9, 11 );
            
            if ( level.var_783db6ab == level.var_ba0d6d40 )
            {
                level.var_783db6ab += 2;
            }
        }
    }
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x1e9f69bf, Offset: 0x9d0
// Size: 0x154
function function_c87827a3()
{
    level notify( #"chaos_round_start" );
    level.var_b7572a82 = 1;
    level.a_zombie_respawn_type = [];
    level thread zm_genesis_vo::function_c74d1a57();
    level flag::clear( "zombie_drop_powerups" );
    var_ddda26e = level.round_spawn_func;
    var_da2533b8 = level.round_wait_func;
    level.round_spawn_func = &function_8e64e16a;
    level.round_wait_func = &function_aa92a46b;
    level.var_8cd70c57++;
    level util::waittill_any( "chaos_round_complete", "kill_round" );
    level.round_spawn_func = var_ddda26e;
    level.round_wait_func = var_da2533b8;
    level.zombie_ai_limit = level.zombie_vars[ "zombie_max_ai" ];
    level flag::set( "zombie_drop_powerups" );
    level.var_b7572a82 = 0;
    level.sndmusicspecialround = 0;
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0xe251bc6d, Offset: 0xb30
// Size: 0x226
function function_8e64e16a()
{
    function_3586b759();
    zombie_utility::ai_calculate_health( level.round_number );
    level thread function_e7ec74b4();
    level.n_override_cleanup_dist_sq = 122500;
    level.var_1f12d3b8 = gettime();
    function_1fe60e52();
    level notify( #"hash_3e06faeb" );
    zm_spawner::register_zombie_death_event_callback( &function_8d6f4be5 );
    level thread function_a61de87c();
    level endon( #"last_ai_down" );
    
    while ( true )
    {
        foreach ( str_index, str_archetype in level.a_zombie_respawn_type )
        {
            if ( level.a_zombie_respawn_type[ str_index ] > 0 )
            {
                level.var_c4336559[ str_index ] += level.a_zombie_respawn_type[ str_index ];
                level.a_zombie_respawn_type[ str_index ] = 0;
            }
        }
        
        if ( level.zombie_total > 0 )
        {
            var_1e528a4e = zombie_utility::get_current_zombie_count();
            
            if ( var_1e528a4e < level.var_5a97b435 )
            {
                level thread function_3cf05b99();
                wait get_spawn_delay();
            }
        }
        
        util::wait_network_frame();
        
        if ( isdefined( level.var_d9d6646 ) && level.var_d9d6646 )
        {
            level.var_d9d6646 = undefined;
        }
    }
}

// Namespace zm_genesis_ai_spawning
// Params 2
// Checksum 0xa9d75099, Offset: 0xd60
// Size: 0x10c
function function_66a5ce12( ai_last, e_attacker )
{
    if ( isdefined( level.zm_override_ai_aftermath_powerup_drop ) )
    {
        [[ level.zm_override_ai_aftermath_powerup_drop ]]( ai_last, level.var_6a6f912a );
        return;
    }
    
    var_4a50cb2a = level.var_6a6f912a;
    
    if ( isdefined( var_4a50cb2a ) )
    {
        mdl_powerup = level zm_powerups::specific_powerup_drop( "full_ammo", var_4a50cb2a );
        
        if ( isplayer( e_attacker ) )
        {
            v_destination = e_attacker.origin;
        }
        else
        {
            e_player = zm_utility::get_closest_player( var_4a50cb2a );
            v_destination = e_player.origin;
        }
        
        mdl_powerup thread function_630f7ed5( v_destination );
    }
}

// Namespace zm_genesis_ai_spawning
// Params 1
// Checksum 0x140d6b63, Offset: 0xe78
// Size: 0x7c
function function_630f7ed5( v_origin )
{
    self endon( #"death" );
    v_navmesh = getclosestpointonnavmesh( v_origin, 512, 16 );
    
    if ( isdefined( v_navmesh ) )
    {
        wait 2;
        self moveto( v_navmesh + ( 0, 0, 40 ), 2 );
    }
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x3e885316, Offset: 0xf00
// Size: 0xbe
function function_5a772555()
{
    a_players = getplayers();
    
    if ( a_players.size == 1 )
    {
        n_num = 18;
    }
    else if ( a_players.size == 2 )
    {
        n_num = 21;
    }
    else if ( a_players.size == 3 )
    {
        n_num = 24;
    }
    else
    {
        n_num = 30;
    }
    
    if ( level.var_8cd70c57 > 1 )
    {
        n_num += 10 * ( level.var_8cd70c57 - 1 );
    }
    
    return n_num;
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x24e5f0c4, Offset: 0xfc8
// Size: 0x10c
function function_3586b759()
{
    zm_genesis_wasp::parasite_round_fx();
    wait 0.5;
    level clientfield::set( "chaos_fog_bank_switch", 1 );
    
    foreach ( e_player in level.players )
    {
        visionset_mgr::activate( "visionset", "zm_chaos_organge", e_player );
        e_player clientfield::set_to_player( "chaos_postfx_set", 1 );
        e_player.var_8b5008fe = 0;
    }
    
    wait 3;
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x32d77ef7, Offset: 0x10e0
// Size: 0x222
function function_a61de87c()
{
    level waittill( #"last_ai_down", ai_last, e_attacker );
    level thread function_4a9010ae();
    level thread function_66a5ce12( e_attacker );
    zm_genesis_power::function_5003c1cd( 0, 0 );
    
    while ( true )
    {
        var_720ddf8a = zombie_utility::get_current_zombie_count();
        
        if ( var_720ddf8a == 0 )
        {
            break;
        }
        
        util::wait_network_frame();
    }
    
    level.n_override_cleanup_dist_sq = undefined;
    zm_spawner::deregister_zombie_death_event_callback( &function_8d6f4be5 );
    level.zombie_ai_limit = level.zombie_vars[ "zombie_max_ai" ];
    zm_genesis_wasp::parasite_round_fx();
    level clientfield::set( "chaos_fog_bank_switch", 0 );
    
    foreach ( e_player in level.players )
    {
        visionset_mgr::deactivate( "visionset", "zm_chaos_organge", e_player );
        e_player clientfield::set_to_player( "chaos_postfx_set", 0 );
        
        if ( e_player.var_8b5008fe == 0 )
        {
            level notify( #"hash_d290d94f", e_player );
        }
        
        e_player.var_8b5008fe = undefined;
    }
    
    level notify( #"chaos_round_complete" );
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0xc17c83d5, Offset: 0x1310
// Size: 0x4c
function function_4a9010ae()
{
    level util::waittill_any( "last_ai_down", "chaos_round_complete" );
    level thread zm_audio::sndmusicsystem_playstate( "chaos_end" );
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0xabb3a0c3, Offset: 0x1368
// Size: 0x5c
function get_spawn_delay()
{
    n_round_time = ( gettime() - level.var_1f12d3b8 ) / 1000;
    
    if ( n_round_time < 5 )
    {
        n_delay = 0.2;
    }
    else
    {
        n_delay = 1.6;
    }
    
    return n_delay;
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x90b2f78f, Offset: 0x13d0
// Size: 0x28
function function_aa92a46b()
{
    level endon( #"restart_round" );
    level endon( #"kill_round" );
    level waittill( #"chaos_round_complete" );
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x2032f2a4, Offset: 0x1400
// Size: 0x1d2
function function_3cf05b99()
{
    var_f09dee4f = [];
    
    foreach ( str_index, var_2bbee316 in level.var_c4336559 )
    {
        if ( var_2bbee316 > 0 )
        {
            var_f09dee4f[ var_f09dee4f.size ] = str_index;
        }
    }
    
    if ( var_f09dee4f.size )
    {
        var_f09dee4f = array::randomize( var_f09dee4f );
        str_ai = var_f09dee4f[ 0 ];
    }
    else
    {
        str_ai = "parasite";
    }
    
    switch ( str_ai )
    {
        case "apothicon_fury":
            level thread function_21bbe70d();
            level notify( #"chaos_round_spawn_apothicon" );
            break;
        case "keeper":
            ai_zombie = function_f55d851b();
            level notify( #"chaos_round_spawn_keeper" );
            break;
        case "parasite":
        default:
            if ( zm_genesis_wasp::ready_to_spawn_wasp() )
            {
                zm_genesis_wasp::spawn_wasp( 1, 1 );
                level notify( #"chaos_round_spawn_parasite" );
                level.var_c4336559[ "parasite" ]--;
            }
            
            break;
    }
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0xe4e6c437, Offset: 0x15e0
// Size: 0x2a2
function function_1fe60e52()
{
    var_f3f94801 = function_5a772555();
    level.var_5a97b435 = function_6647fb88();
    
    if ( level.var_8cd70c57 == 1 )
    {
        level.var_c4336559[ "parasite" ] = var_f3f94801;
        level.var_c4336559[ "apothicon_fury" ] = 0;
        level.var_c4336559[ "keeper" ] = 0;
    }
    else if ( level.var_8cd70c57 == 2 )
    {
        level.var_c4336559[ "parasite" ] = int( var_f3f94801 * 0.6 );
        level.var_c4336559[ "apothicon_fury" ] = int( var_f3f94801 * 0.4 );
        level.var_c4336559[ "keeper" ] = 0;
    }
    else
    {
        level.var_c4336559[ "parasite" ] = int( var_f3f94801 * 0.5 );
        level.var_c4336559[ "apothicon_fury" ] = int( var_f3f94801 * 0.3 );
        level.var_c4336559[ "keeper" ] = int( var_f3f94801 * 0.2 );
    }
    
    var_a126d2f9 = int( level.var_c4336559[ "parasite" ] * 0.1 );
    level.var_c4336559[ "parasite" ] = level.var_c4336559[ "parasite" ] + var_a126d2f9;
    level.zombie_total = 0;
    
    foreach ( n_total in level.var_c4336559 )
    {
        level.zombie_total += n_total;
    }
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0xfaa8f32d, Offset: 0x1890
// Size: 0x90
function function_6647fb88()
{
    a_players = getplayers();
    
    if ( a_players.size == 1 )
    {
        n_num = 15;
    }
    else if ( a_players.size == 2 )
    {
        n_num = 16;
    }
    else if ( a_players.size == 3 )
    {
        n_num = 17;
    }
    else
    {
        n_num = 18;
    }
    
    return n_num;
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x686df979, Offset: 0x1928
// Size: 0x5e
function function_1089db10()
{
    var_cecd0670 = zombie_utility::get_current_zombie_count();
    var_cecd0670 -= zm_genesis_util::function_adcc0e33();
    var_cecd0670 -= zm_genesis_util::function_e3e6bdba();
    return var_cecd0670;
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x9e531aa9, Offset: 0x1990
// Size: 0x326
function function_f55d851b()
{
    a_players = getplayers();
    e_player = function_25a4a7d4();
    queryresult = positionquery_source_navigation( e_player.origin, 600, 900, 128, 20 );
    
    if ( isdefined( queryresult ) && queryresult.data.size > 0 )
    {
        a_spots = array::randomize( queryresult.data );
        
        for ( i = 0; i < a_spots.size ; i++ )
        {
            v_origin = a_spots[ i ].origin;
            v_angles = zm_genesis_util::get_lookat_angles( v_origin, e_player.origin );
            str_zone = zm_zonemgr::get_zone_from_position( v_origin, 1 );
            
            if ( isdefined( str_zone ) && level.zones[ str_zone ].is_active )
            {
                e_keeper = spawnactor( "spawner_zm_genesis_keeper", v_origin, v_angles, undefined, 1, 1 );
                
                if ( isdefined( e_keeper ) )
                {
                    level.zombie_total--;
                    level.var_c4336559[ "keeper" ]--;
                    e_keeper endon( #"death" );
                    e_keeper.spawn_time = gettime();
                    e_keeper.var_b8385ee5 = 1;
                    e_keeper.health = level.zombie_health;
                    e_keeper.heroweapon_kill_power = 2;
                    level thread zm_spawner::zombie_death_event( e_keeper );
                    level thread function_6cc52664( e_keeper.origin );
                    e_keeper.voiceprefix = "keeper";
                    e_keeper.animname = "keeper";
                    e_keeper thread zm_spawner::play_ambient_zombie_vocals();
                    e_keeper thread zm_audio::zmbaivox_notifyconvert();
                    wait 1.3;
                    e_keeper.zombie_think_done = 1;
                    e_keeper thread zombie_utility::round_spawn_failsafe();
                    e_keeper thread function_77d3a18d();
                    return e_keeper;
                }
            }
        }
    }
    
    return undefined;
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0xe5a51cd6, Offset: 0x1cc0
// Size: 0x36
function function_77d3a18d()
{
    self.ignore_nuke = 1;
    self endon( #"death" );
    util::wait_network_frame();
    self.ignore_nuke = undefined;
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0xc821ae2a, Offset: 0x1d00
// Size: 0x286
function function_21bbe70d()
{
    a_players = getplayers();
    e_player = function_25a4a7d4();
    queryresult = positionquery_source_navigation( e_player.origin, 600, 800, 128, 20 );
    
    if ( isdefined( queryresult ) && queryresult.data.size > 0 )
    {
        a_spots = array::randomize( queryresult.data );
        
        for ( i = 0; i < a_spots.size ; i++ )
        {
            v_origin = a_spots[ i ].origin;
            v_angles = zm_genesis_util::get_lookat_angles( v_origin, e_player.origin );
            str_zone = zm_zonemgr::get_zone_from_position( v_origin, 1 );
            
            if ( isdefined( str_zone ) && level.zones[ str_zone ].is_active )
            {
                function_1f0a0b52( v_origin );
                var_ecb2c615 = zm_genesis_apothicon_fury::function_21bbe70d( v_origin, v_angles, 0 );
                
                if ( isdefined( var_ecb2c615 ) )
                {
                    level.zombie_total--;
                    level.var_c4336559[ "apothicon_fury" ]--;
                    var_ecb2c615 endon( #"death" );
                    var_ecb2c615.health = level.zombie_health;
                    wait 1;
                    var_ecb2c615.zombie_think_done = 1;
                    var_ecb2c615.heroweapon_kill_power = 2;
                    var_ecb2c615 ai::set_behavior_attribute( "move_speed", "run" );
                    var_ecb2c615 thread zombie_utility::round_spawn_failsafe();
                    return var_ecb2c615;
                }
            }
        }
    }
    
    return undefined;
}

// Namespace zm_genesis_ai_spawning
// Params 1
// Checksum 0xc5fa068f, Offset: 0x1f90
// Size: 0x18c
function function_1f0a0b52( v_spawn_pos )
{
    v_start_pos = ( v_spawn_pos[ 0 ], v_spawn_pos[ 1 ], v_spawn_pos[ 2 ] + 1000 );
    var_2c69e810 = spawn( "script_model", v_spawn_pos );
    var_2c69e810 setmodel( "tag_origin" );
    playfxontag( level._effect[ "fury_ground_tell_fx" ], var_2c69e810, "tag_origin" );
    var_3dd66385 = spawn( "script_model", v_start_pos );
    var_3dd66385 setmodel( "tag_origin" );
    util::wait_network_frame();
    var_3dd66385 clientfield::set( "apothicon_fury_spawn_meteor", 1 );
    var_3dd66385 moveto( v_spawn_pos, 1.5 );
    var_3dd66385 waittill( #"movedone" );
    var_3dd66385 delete();
    var_2c69e810 delete();
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0xacf6c598, Offset: 0x2128
// Size: 0x62
function function_e7ec74b4()
{
    a_players = getplayers();
    
    for ( i = 0; i < a_players.size ; i++ )
    {
        a_players[ i ].var_ddcf1ca1 = 0;
    }
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0xaf21c4f1, Offset: 0x2198
// Size: 0xf4
function function_25a4a7d4()
{
    a_players = getplayers();
    var_b474403b = 9999999;
    var_6c9f55e = a_players[ 0 ];
    
    for ( i = 0; i < a_players.size ; i++ )
    {
        e_player = a_players[ i ];
        
        if ( !isdefined( e_player.var_ddcf1ca1 ) )
        {
            e_player.var_ddcf1ca1 = 0;
        }
        
        if ( e_player.var_ddcf1ca1 < var_b474403b )
        {
            var_6c9f55e = e_player;
            var_b474403b = e_player.var_ddcf1ca1;
        }
    }
    
    var_6c9f55e.var_ddcf1ca1++;
    return var_6c9f55e;
}

// Namespace zm_genesis_ai_spawning
// Params 1
// Checksum 0x7329de98, Offset: 0x2298
// Size: 0xac
function function_6cc52664( v_origin )
{
    var_986156a0 = util::spawn_model( "tag_origin", v_origin, ( 0, 0, 0 ) );
    playfxontag( level._effect[ "keeper_spawn" ], var_986156a0, "tag_origin" );
    var_986156a0 playsound( "evt_keeper_portal_start" );
    wait 1.5;
    var_986156a0 delete();
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x81d7a88, Offset: 0x2350
// Size: 0x148
function spawn_zombie()
{
    e_spawner = array::random( level.zombie_spawners );
    ai_zombie = zombie_utility::spawn_zombie( e_spawner, e_spawner.targetname );
    n_random = randomint( 100 );
    
    if ( n_random < 3 )
    {
        ai_zombie zm_elemental_zombie::function_1b1bb1b();
    }
    else if ( n_random < 6 )
    {
        ai_zombie zm_genesis_util::function_c8040935( 1 );
    }
    
    if ( n_random < 9 )
    {
        ai_zombie zm_shadow_zombie::function_1b2b62b();
    }
    else if ( n_random < 12 )
    {
        ai_zombie zm_light_zombie::function_a35db70f();
    }
    else if ( n_random < 35 )
    {
        ai_zombie zm_utility::make_supersprinter();
    }
    
    return ai_zombie;
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x715cb3f3, Offset: 0x24a0
// Size: 0xc4
function function_b3e803ec()
{
    level endon( #"chaos_round_complete" );
    level waittill( #"kill_round" );
    a_ai = getaiarray();
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        e_zombie = a_ai[ i ];
        
        if ( isdefined( e_zombie.var_953b581c ) && e_zombie.var_953b581c )
        {
            e_zombie kill();
        }
    }
    
    level.var_d9d6646 = 1;
}

// Namespace zm_genesis_ai_spawning
// Params 1
// Checksum 0xfce94441, Offset: 0x2570
// Size: 0x7e
function function_8d6f4be5( e_attacker )
{
    if ( isdefined( level.var_b7572a82 ) && level.var_b7572a82 )
    {
        if ( level.zombie_total <= 0 )
        {
            n_alive = zm_genesis_util::function_1bd652e9();
            
            if ( n_alive == 0 )
            {
                level.var_6a6f912a = self.origin;
                level notify( #"last_ai_down", self, e_attacker );
            }
        }
    }
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0x6e6b47ad, Offset: 0x25f8
// Size: 0x184
function function_fd8b24f5()
{
    if ( level.round_number < 13 )
    {
        return 0;
    }
    
    if ( level.zombie_total <= 10 )
    {
        return 0;
    }
    
    var_c0692329 = 0;
    n_random = randomfloat( 100 );
    
    if ( level.round_number > 25 )
    {
        if ( n_random < 5 )
        {
            var_c0692329 = 1;
        }
    }
    else if ( level.round_number > 20 )
    {
        if ( n_random < 4 )
        {
            var_c0692329 = 1;
        }
    }
    else if ( level.round_number > 15 )
    {
        if ( n_random < 3 )
        {
            var_c0692329 = 1;
        }
    }
    else if ( n_random < 2 )
    {
        var_c0692329 = 1;
    }
    
    if ( var_c0692329 )
    {
        n_roll = randomint( 100 );
        
        if ( n_roll < 50 )
        {
            function_21bbe70d();
        }
        else
        {
            ai_zombie = function_f55d851b();
        }
    }
    
    return var_c0692329;
}

// Namespace zm_genesis_ai_spawning
// Params 0
// Checksum 0xcc6950ce, Offset: 0x2788
// Size: 0x16c
function function_47b2f1f4()
{
    if ( level.a_zombie_respawn_type.size )
    {
        b_valid = 0;
        
        foreach ( str_index, n_val in level.a_zombie_respawn_type )
        {
            if ( n_val > 0 )
            {
                switch ( str_index )
                {
                    default:
                        self thread zm_elemental_zombie::function_1b1bb1b();
                        b_valid = 1;
                        break;
                    case "napalm":
                        self thread zm_elemental_zombie::function_f4defbc2();
                        b_valid = 1;
                        break;
                    case "shadow":
                        self thread zm_shadow_zombie::function_1b2b62b();
                        b_valid = 1;
                        break;
                    case "light":
                        self thread zm_light_zombie::function_a35db70f();
                        b_valid = 1;
                        break;
                }
            }
            
            if ( b_valid )
            {
                level.a_zombie_respawn_type[ str_index ]--;
                break;
            }
        }
    }
}

/#

    // Namespace zm_genesis_ai_spawning
    // Params 0
    // Checksum 0x17cd62f1, Offset: 0x2900
    // Size: 0x44, Type: dev
    function function_28e53883()
    {
        level thread zm_genesis_util::setup_devgui_func( "<dev string:x28>", "<dev string:x44>", 1, &function_b6f47996 );
    }

    // Namespace zm_genesis_ai_spawning
    // Params 1
    // Checksum 0x5c539fda, Offset: 0x2950
    // Size: 0x74, Type: dev
    function function_b6f47996( n_val )
    {
        zm_utility::zombie_goto_round( level.var_783db6ab - 1 );
        level notify( #"kill_round" );
        iprintlnbold( "<dev string:x5c>" );
        zm_genesis_power::function_5003c1cd( 0, 1 );
    }

#/
