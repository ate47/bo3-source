#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_spider;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb_machine;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;

#namespace zm_ai_spiders;

// Namespace zm_ai_spiders
// Params 0, eflags: 0x2
// Checksum 0x478ddf65, Offset: 0x838
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_ai_spiders", &__init__, &__main__, undefined );
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x76f44131, Offset: 0x880
// Size: 0x16c
function __init__()
{
    level.var_9d7b5e00 = 200;
    level.var_6ea0fe2e = 1;
    level flag::init( "spider_round" );
    
    /#
        adddebugcommand( "<dev string:x28>" );
        adddebugcommand( "<dev string:x6a>" );
        adddebugcommand( "<dev string:xc1>" );
        adddebugcommand( "<dev string:x109>" );
        level thread function_3fd0c070();
    #/
    
    function_5c48d276();
    init();
    callback::on_spawned( &function_83a70ec3 );
    spawner::add_archetype_spawn_function( "spider", &function_82b6256d );
    spawner::add_archetype_spawn_function( "spider", &function_df94945b );
    zm::register_vehicle_damage_callback( &function_5b625d74 );
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xdd26c302, Offset: 0x9f8
// Size: 0x14
function __main__()
{
    register_clientfields();
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xba007c2f, Offset: 0xa18
// Size: 0x94
function register_clientfields()
{
    clientfield::register( "toplayer", "spider_round_fx", 9000, 1, "counter" );
    clientfield::register( "toplayer", "spider_round_ring_fx", 9000, 1, "counter" );
    clientfield::register( "toplayer", "spider_end_of_round_reset", 9000, 1, "counter" );
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xa2fd47c2, Offset: 0xab8
// Size: 0xa8
function function_83a70ec3()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"bled_out" );
        
        if ( level flag::get( "spider_round_in_progress" ) )
        {
            self waittill( #"spawned_player" );
            level flag::wait_till_clear( "spider_round_in_progress" );
            util::wait_network_frame();
            self clientfield::increment_to_player( "spider_end_of_round_reset", 1 );
        }
    }
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x1a8bce3d, Offset: 0xb68
// Size: 0x1b4
function init()
{
    level.var_173ca157 = 1;
    level.var_347e707c = 0;
    level.var_7f2af1cf = 1;
    level.var_c38a4fee = [];
    level flag::init( "spider_clips" );
    level flag::init( "spider_round_in_progress" );
    level.aat[ "zm_aat_turned" ].immune_trigger[ "spider" ] = 1;
    level.aat[ "zm_aat_thunder_wall" ].immune_result_indirect[ "spider" ] = 1;
    level.aat[ "zm_aat_dead_wire" ].immune_trigger[ "spider" ] = 1;
    level.melee_range_sav = getdvarstring( "ai_meleeRange" );
    level.melee_width_sav = getdvarstring( "ai_meleeWidth" );
    level.melee_height_sav = getdvarstring( "ai_meleeHeight" );
    function_7a544164();
    level thread function_fd32a77c();
    visionset_mgr::register_info( "visionset", "zm_isl_parasite_spider_visionset", 9000, 33, 16, 0, &visionset_mgr::ramp_in_out_thread, 0 );
}

// Namespace zm_ai_spiders
// Params 1
// Checksum 0xc0072293, Offset: 0xd28
// Size: 0x34
function function_1c624caf( a_ents )
{
    if ( self.model === "tag_origin" )
    {
        self zm_utility::self_delete();
    }
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x1c086475, Offset: 0xd68
// Size: 0x1e
function function_5c48d276()
{
    level._effect[ "spider_gib" ] = "dlc2/island/fx_spider_death_explo_sm";
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xe23b7af0, Offset: 0xd90
// Size: 0x206
function function_fd32a77c()
{
    clips_on = 0;
    level.spider_clips = getentarray( "spider_clips", "targetname" );
    
    while ( true )
    {
        for ( i = 0; i < level.spider_clips.size ; i++ )
        {
            level.spider_clips[ i ] connectpaths();
        }
        
        level flag::wait_till( "spider_clips" );
        
        if ( isdefined( level.var_e564e9cd ) && level.var_e564e9cd == 1 )
        {
            return;
        }
        
        for ( i = 0; i < level.spider_clips.size ; i++ )
        {
            level.spider_clips[ i ] disconnectpaths();
            util::wait_network_frame();
        }
        
        var_26b8af54 = 1;
        
        while ( var_26b8af54 || level flag::get( "spider_round" ) )
        {
            var_26b8af54 = 0;
            a_spiders = getvehiclearray( "zombie_spider", "targetname" );
            
            for ( i = 0; i < a_spiders.size ; i++ )
            {
                if ( isalive( a_spiders[ i ] ) )
                {
                    var_26b8af54 = 1;
                }
            }
            
            wait 1;
        }
        
        level flag::clear( "spider_clips" );
        wait 1;
    }
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xe07b6724, Offset: 0xfa0
// Size: 0x44
function function_d2716ad8()
{
    level.var_347e707c = 1;
    
    if ( !isdefined( level.var_33655cba ) )
    {
        level.var_33655cba = &function_2a424152;
    }
    
    level thread [[ level.var_33655cba ]]();
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x4f3411d4, Offset: 0xff0
// Size: 0x19c
function function_7a544164()
{
    level.var_c38a4fee = getentarray( "zombie_spider_spawner", "script_noteworthy" );
    var_c84b3c65 = getentarray( "later_round_spider_spawners", "script_noteworthy" );
    level.var_c7f0b45b = arraycombine( level.var_c38a4fee, var_c84b3c65, 1, 0 );
    
    if ( level.var_c38a4fee.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < level.var_c38a4fee.size ; i++ )
    {
        if ( zm_spawner::is_spawner_targeted_by_blocker( level.var_c38a4fee[ i ] ) )
        {
            level.var_c38a4fee[ i ].is_enabled = 0;
            continue;
        }
        
        level.var_c38a4fee[ i ].is_enabled = 1;
        level.var_c38a4fee[ i ].script_forcespawn = 1;
    }
    
    assert( level.var_c38a4fee.size > 0 );
    array::thread_all( level.var_c38a4fee, &spawner::add_spawn_function, &spider_init );
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xf5b240f, Offset: 0x1198
// Size: 0x11c
function spider_init()
{
    function_6e19aa86();
    self.targetname = "zombie_spider";
    self.maxhealth = level.var_fda270a4;
    self.health = self.maxhealth;
    self.no_gib = 1;
    self.b_is_spider = 1;
    self.no_eye_glow = 1;
    self.custom_player_shellshock = &function_c685a92b;
    self.team = level.zombie_team;
    self.missinglegs = 0;
    self.thundergun_knockdown_func = &function_96d38ff4;
    self.lightning_chain_immune = 1;
    self thread function_747a2fea();
    self thread function_7609fd9();
    self playsound( "zmb_spider_spawn" );
    self thread function_eebdfab2();
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xf0a6064e, Offset: 0x12c0
// Size: 0xb0
function function_747a2fea()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", n_amount, e_attacker, v_direction, v_hit_location, str_mod );
        
        if ( isplayer( e_attacker ) )
        {
            e_attacker.use_weapon_type = str_mod;
            self thread zm_powerups::check_for_instakill( e_attacker, str_mod, v_hit_location );
        }
    }
}

// Namespace zm_ai_spiders
// Params 2
// Checksum 0x4d8caa36, Offset: 0x1378
// Size: 0x74
function function_96d38ff4( e_player, gib )
{
    self endon( #"death" );
    n_damage = int( self.maxhealth * 0.5 );
    self dodamage( n_damage, self.origin, e_player );
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x99ec1590, Offset: 0x13f8
// Size: 0x4
function spider_think()
{
    
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x5a05079d, Offset: 0x1408
// Size: 0x78
function function_eebdfab2()
{
    self endon( #"death" );
    wait randomfloatrange( 3, 6 );
    
    while ( true )
    {
        self playsoundontag( "zmb_spider_vocals_ambient", "tag_eye" );
        wait randomfloatrange( 2, 6 );
    }
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x8e406d16, Offset: 0x1488
// Size: 0x214
function function_7609fd9()
{
    self waittill( #"death", e_attacker );
    
    if ( function_c9adb887() == 0 && level.zombie_total == 0 )
    {
        if ( !isdefined( level.zm_ai_round_over ) || [[ level.zm_ai_round_over ]]() )
        {
            level.last_ai_origin = self.origin;
            level notify( #"last_ai_down", self );
        }
    }
    
    if ( isplayer( e_attacker ) )
    {
        if ( !( isdefined( self.deathpoints_already_given ) && self.deathpoints_already_given ) )
        {
            e_attacker zm_score::player_add_points( "death_spider" );
        }
        
        if ( isdefined( self.riotshield_death ) && self.riotshield_death )
        {
            level notify( #"hash_92ad8590", e_attacker );
        }
        
        if ( isdefined( level.hero_power_update ) )
        {
            [[ level.hero_power_update ]]( e_attacker, self );
        }
        
        e_attacker notify( #"player_killed_spider" );
        e_attacker zm_stats::increment_client_stat( "zspiders_killed" );
        e_attacker zm_stats::increment_player_stat( "zspiders_killed" );
    }
    
    if ( isdefined( e_attacker ) && isai( e_attacker ) )
    {
        if ( isdefined( e_attacker.var_5a513941 ) && e_attacker.var_5a513941 )
        {
            level notify( #"hash_9218d45f", e_attacker );
        }
        
        e_attacker notify( #"killed", self );
    }
    
    if ( isdefined( self ) )
    {
        self stoploopsound();
        self thread function_c3147dc1( self.origin );
    }
}

// Namespace zm_ai_spiders
// Params 1
// Checksum 0xcca3ab52, Offset: 0x16a8
// Size: 0x2c
function function_c3147dc1( v_pos )
{
    self thread fx::play( "spider_gib", v_pos );
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x79dffecc, Offset: 0x16e0
// Size: 0x1f4
function function_2a424152()
{
    level.var_3013498 = level.round_number + randomintrange( 4, 7 );
    level.var_5ccd3661 = level.var_3013498;
    old_spawn_func = level.round_spawn_func;
    old_wait_func = level.round_wait_func;
    
    while ( true )
    {
        level waittill( #"between_round_over" );
        
        /#
            if ( getdvarint( "<dev string:x15d>" ) > 0 )
            {
                level.var_3013498 = level.round_number;
            }
        #/
        
        if ( level.round_number == level.var_3013498 )
        {
            level.sndmusicspecialround = 1;
            old_spawn_func = level.round_spawn_func;
            old_wait_func = level.round_wait_func;
            function_9f7a20d2();
            level.round_spawn_func = &function_a2a299a1;
            level.round_wait_func = &function_872e306e;
            level.var_3013498 = level.round_number + randomintrange( 4, 6 );
            
            /#
                getplayers()[ 0 ] iprintln( "<dev string:x16b>" + level.var_3013498 );
            #/
            
            continue;
        }
        
        if ( level flag::get( "spider_round" ) )
        {
            function_123b370a();
            level.round_spawn_func = old_spawn_func;
            level.round_wait_func = old_wait_func;
            level.var_6ea0fe2e += 1;
        }
    }
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xf2fbfccf, Offset: 0x18e0
// Size: 0xec
function spider_round_fx()
{
    foreach ( player in level.players )
    {
        player clientfield::increment_to_player( "spider_round_fx" );
        player clientfield::increment_to_player( "spider_round_ring_fx" );
    }
    
    visionset_mgr::activate( "visionset", "zm_isl_parasite_spider_visionset", undefined, 1.5, &function_fad41aec, 2 );
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xfdd0cd29, Offset: 0x19d8
// Size: 0x24
function function_fad41aec()
{
    level flag::wait_till_clear( "spider_round_in_progress" );
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xb895dc88, Offset: 0x1a08
// Size: 0x240
function function_a2a299a1()
{
    level endon( #"intermission" );
    level endon( #"end_of_round" );
    level endon( #"restart_round" );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        level.players[ i ].hunted_by = 0;
    }
    
    level endon( #"kill_round" );
    
    /#
        if ( getdvarint( "<dev string:x17f>" ) == 2 || getdvarint( "<dev string:x17f>" ) >= 4 )
        {
            return;
        }
    #/
    
    if ( level.intermission )
    {
        return;
    }
    
    level flag::set( "spider_round_in_progress" );
    level thread function_f602171e();
    array::thread_all( level.players, &function_cb42e438 );
    wait 1;
    spider_round_fx();
    wait 4;
    var_c15d44e9 = function_67c1c842();
    
    /#
        if ( getdvarstring( "<dev string:x15d>" ) != "<dev string:x18c>" )
        {
            var_c15d44e9 = getdvarint( "<dev string:x15d>" );
        }
    #/
    
    level.zombie_total = var_c15d44e9;
    
    while ( true )
    {
        while ( level.zombie_total > 0 )
        {
            if ( isdefined( level.bzm_worldpaused ) && level.bzm_worldpaused )
            {
                util::wait_network_frame();
                continue;
            }
            
            spawn_spiders();
            util::wait_network_frame();
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xf975dbcd, Offset: 0x1c50
// Size: 0x4c
function function_67c1c842()
{
    if ( level.var_6ea0fe2e < 3 )
    {
        n_wave_count = level.players.size * 6;
    }
    else
    {
        n_wave_count = level.players.size * 8;
    }
    
    return n_wave_count;
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x8f28c98d, Offset: 0x1ca8
// Size: 0x20c
function spawn_spiders()
{
    while ( !function_c1730af7() )
    {
        wait 0.1;
    }
    
    s_spawn_loc = undefined;
    var_19764360 = get_favorite_enemy();
    
    if ( !isdefined( var_19764360 ) )
    {
        wait randomfloatrange( 0.333333, 0.666667 );
        return;
    }
    
    if ( isdefined( level.var_21f08627 ) )
    {
        s_spawn_loc = [[ level.var_21f08627 ]]( var_19764360 );
    }
    else
    {
        s_spawn_loc = function_570247b9( var_19764360 );
    }
    
    if ( !isdefined( s_spawn_loc ) )
    {
        wait randomfloatrange( 0.333333, 0.666667 );
        return;
    }
    
    if ( level flag::exists( "spiders_from_mars_round" ) && level flag::get( "spiders_from_mars_round" ) && isdefined( level.var_39b24700 ) )
    {
        ai = zombie_utility::spawn_zombie( level.var_39b24700[ 0 ] );
    }
    else
    {
        ai = zombie_utility::spawn_zombie( level.var_c38a4fee[ 0 ] );
    }
    
    if ( isdefined( ai ) )
    {
        s_spawn_loc thread function_49e57a3b( ai, s_spawn_loc );
        level.zombie_total--;
        level thread zm_spawner::zombie_death_event( ai );
        
        if ( isdefined( level.var_2aacffb1 ) )
        {
            ai thread [[ level.var_2aacffb1 ]]();
        }
        
        function_1abf8192();
    }
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xc1d0bca3, Offset: 0x1ec0
// Size: 0x90, Type: bool
function function_c1730af7()
{
    var_621b3c65 = function_c9adb887();
    var_8817ee62 = var_621b3c65 >= 13;
    var_72a71294 = var_621b3c65 >= level.players.size * 4;
    
    if ( var_8817ee62 || var_72a71294 || !level flag::get( "spawn_zombies" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xebf80140, Offset: 0x1f58
// Size: 0xd6
function function_c9adb887()
{
    a_ai_spiders = getentarray( "zombie_spider", "targetname" );
    var_aa45da74 = a_ai_spiders.size;
    
    foreach ( ai_spider in a_ai_spiders )
    {
        if ( !isalive( ai_spider ) )
        {
            var_aa45da74--;
        }
    }
    
    return var_aa45da74;
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xc842299f, Offset: 0x2038
// Size: 0x80
function function_872e306e()
{
    level endon( #"restart_round" );
    level endon( #"kill_round" );
    
    if ( level flag::get( "spider_round" ) )
    {
        level flag::wait_till( "spider_round_in_progress" );
        level flag::wait_till_clear( "spider_round_in_progress" );
    }
    
    level.sndmusicspecialround = 0;
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x23bbad6d, Offset: 0x20c0
// Size: 0xe4
function function_9f7a20d2()
{
    level flag::set( "spider_round" );
    level flag::set( "special_round" );
    
    if ( !isdefined( level.var_8276ee15 ) )
    {
        level.var_8276ee15 = 0;
    }
    
    level.var_8276ee15 = 1;
    level notify( #"hash_f96039de" );
    level thread zm_audio::sndmusicsystem_playstate( "spider_roundstart" );
    
    if ( isdefined( level.var_9d7b5e00 ) )
    {
        setdvar( "ai_meleeRange", level.var_9d7b5e00 );
        return;
    }
    
    setdvar( "ai_meleeRange", 100 );
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xc32408cb, Offset: 0x21b0
// Size: 0xd4
function function_123b370a()
{
    level flag::clear( "spider_round" );
    level flag::clear( "special_round" );
    
    if ( !isdefined( level.var_8276ee15 ) )
    {
        level.var_8276ee15 = 0;
    }
    
    level.var_8276ee15 = 0;
    level notify( #"hash_daeb2e4f" );
    setdvar( "ai_meleeRange", level.melee_range_sav );
    setdvar( "ai_meleeWidth", level.melee_width_sav );
    setdvar( "ai_meleeHeight", level.melee_height_sav );
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x78d3e2de, Offset: 0x2290
// Size: 0x88
function function_1abf8192()
{
    switch ( level.players.size )
    {
        case 1:
            n_default_wait = 2.25;
            break;
        case 2:
            n_default_wait = 2;
            break;
        case 3:
            n_default_wait = 1.75;
            break;
        default:
            n_default_wait = 1.5;
            break;
    }
    
    wait n_default_wait;
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x6842d65, Offset: 0x2320
// Size: 0x11c
function function_6e19aa86()
{
    if ( isdefined( level.var_718361fb ) )
    {
        level.var_fda270a4 = level.var_718361fb;
        return;
    }
    
    switch ( level.var_6ea0fe2e )
    {
        case 1:
            level.var_fda270a4 = 400;
            break;
        case 2:
            level.var_fda270a4 = 900;
            break;
        case 3:
            level.var_fda270a4 = 1300;
            break;
        default:
            level.var_fda270a4 = 1600;
            break;
    }
    
    level.var_fda270a4 = int( level.var_fda270a4 * 0.5 );
    
    if ( level flag::exists( "spiders_from_mars_round" ) && level flag::get( "spiders_from_mars_round" ) )
    {
        level.var_fda270a4 *= 2;
    }
}

// Namespace zm_ai_spiders
// Params 1
// Checksum 0x4d0eb201, Offset: 0x2448
// Size: 0x2e8
function function_570247b9( var_19764360 )
{
    switch ( level.players.size )
    {
        case 1:
            var_3a613778 = 2500;
            var_e27d607a = 490000;
            break;
        case 2:
            var_3a613778 = 2500;
            var_e27d607a = 810000;
            break;
        case 3:
            var_3a613778 = 2500;
            var_e27d607a = 1000000;
            break;
        case 4:
            var_3a613778 = 2500;
            var_e27d607a = 1000000;
            break;
        default:
            var_3a613778 = 2500;
            var_e27d607a = 490000;
            break;
    }
    
    if ( isdefined( level.zm_loc_types[ "spider_location" ] ) )
    {
        var_aa136cb0 = array::randomize( level.zm_loc_types[ "spider_location" ] );
    }
    else
    {
        assertmsg( "<dev string:x18d>" );
        return;
    }
    
    for ( i = 0; i < var_aa136cb0.size ; i++ )
    {
        if ( isdefined( level.var_fcbb5ce0 ) && level.var_fcbb5ce0 == var_aa136cb0[ i ] )
        {
            continue;
        }
        
        n_dist_squared = distancesquared( var_aa136cb0[ i ].origin, var_19764360.origin );
        n_height_diff = abs( var_aa136cb0[ i ].origin[ 2 ] - var_19764360.origin[ 2 ] );
        
        if ( n_dist_squared > var_3a613778 && n_dist_squared < var_e27d607a && n_height_diff < 128 )
        {
            s_spawn_loc = function_4df33b5a( var_aa136cb0[ i ] );
            level.var_fcbb5ce0 = s_spawn_loc;
            return s_spawn_loc;
        }
    }
    
    s_spawn_loc = function_4df33b5a( arraygetclosest( var_19764360.origin, var_aa136cb0 ) );
    level.var_fcbb5ce0 = s_spawn_loc;
    return s_spawn_loc;
}

// Namespace zm_ai_spiders
// Params 1
// Checksum 0x117f963a, Offset: 0x2738
// Size: 0x74
function function_4df33b5a( s_spawn_loc )
{
    assert( isdefined( s_spawn_loc ), "<dev string:x1c4>" );
    var_8bf32428 = s_spawn_loc;
    var_8bf32428.origin = s_spawn_loc.origin + ( 0, 0, 16 );
    return var_8bf32428;
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x46e19929, Offset: 0x27b8
// Size: 0x24
function function_cb42e438()
{
    self playlocalsound( "zmb_raps_round_start" );
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x56f34428, Offset: 0x27e8
// Size: 0x262
function function_f602171e()
{
    level waittill( #"last_ai_down", e_enemy_ai );
    level thread zm_audio::sndmusicsystem_playstate( "spider_roundend" );
    
    if ( isdefined( level.zm_override_ai_aftermath_powerup_drop ) )
    {
        [[ level.zm_override_ai_aftermath_powerup_drop ]]( e_enemy_ai, level.last_ai_origin );
    }
    else
    {
        var_4a50cb2a = level.last_ai_origin;
        
        if ( !ispointonnavmesh( var_4a50cb2a, e_enemy_ai ) )
        {
            var_4a50cb2a = getclosestpointonnavmesh( var_4a50cb2a, 100 );
            
            if ( !isdefined( var_4a50cb2a ) )
            {
                e_player = zm_utility::get_closest_player( level.last_ai_origin );
                var_4a50cb2a = e_player.origin;
            }
        }
        
        trace = groundtrace( var_4a50cb2a + ( 0, 0, 15 ), var_4a50cb2a + ( 0, 0, -1000 ), 0, undefined );
        var_4a50cb2a = trace[ "position" ];
        
        if ( isdefined( var_4a50cb2a ) )
        {
            level thread zm_powerups::specific_powerup_drop( "full_ammo", var_4a50cb2a );
        }
    }
    
    wait 2;
    level.sndmusicspecialround = 0;
    
    if ( isdefined( level.var_c102a998 ) )
    {
        [[ level.var_c102a998 ]]();
        return;
    }
    
    wait 6;
    level flag::clear( "spider_round_in_progress" );
    
    foreach ( player in level.players )
    {
        player clientfield::increment_to_player( "spider_end_of_round_reset", 1 );
    }
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x842589d, Offset: 0x2a58
// Size: 0x134
function get_favorite_enemy()
{
    var_5a210579 = level.players;
    e_least_hunted = var_5a210579[ 0 ];
    
    for ( i = 0; i < var_5a210579.size ; i++ )
    {
        if ( !isdefined( var_5a210579[ i ].hunted_by ) )
        {
            var_5a210579[ i ].hunted_by = 0;
        }
        
        if ( !zm_utility::is_player_valid( var_5a210579[ i ] ) )
        {
            continue;
        }
        
        if ( !zm_utility::is_player_valid( e_least_hunted ) )
        {
            e_least_hunted = var_5a210579[ i ];
        }
        
        if ( var_5a210579[ i ].hunted_by < e_least_hunted.hunted_by )
        {
            e_least_hunted = var_5a210579[ i ];
        }
    }
    
    e_least_hunted.hunted_by += 1;
    return e_least_hunted;
}

// Namespace zm_ai_spiders
// Params 2
// Checksum 0x5782b6b4, Offset: 0x2b98
// Size: 0x238
function function_f4bd92a2( n_to_spawn, s_spawn_point )
{
    a_spiders = getvehiclearray( "zombie_spider", "targetname" );
    
    if ( isdefined( a_spiders ) && a_spiders.size >= 9 )
    {
        return 0;
    }
    
    if ( !isdefined( n_to_spawn ) )
    {
        n_to_spawn = 1;
    }
    
    var_c46ed637 = 0;
    
    while ( var_c46ed637 < n_to_spawn )
    {
        var_19764360 = get_favorite_enemy();
        
        if ( isdefined( level.var_21f08627 ) )
        {
            if ( !isdefined( s_spawn_point ) )
            {
                s_spawn_point = [[ level.var_21f08627 ]]( level.var_c38a4fee, var_19764360 );
            }
            
            ai = zombie_utility::spawn_zombie( level.var_c38a4fee[ 0 ] );
            
            if ( isdefined( ai ) )
            {
                s_spawn_point thread function_49e57a3b( ai, s_spawn_point );
                level.zombie_total--;
                var_c46ed637++;
                level flag::set( "spider_clips" );
            }
        }
        else
        {
            if ( !isdefined( s_spawn_point ) )
            {
                s_spawn_point = function_570247b9( var_19764360 );
            }
            
            ai = zombie_utility::spawn_zombie( level.var_c38a4fee[ 0 ] );
            
            if ( isdefined( ai ) )
            {
                s_spawn_point thread function_49e57a3b( ai, s_spawn_point );
                level.zombie_total--;
                var_c46ed637++;
                level flag::set( "spider_clips" );
            }
        }
        
        function_1abf8192();
    }
    
    if ( isdefined( ai ) )
    {
        return ai;
    }
    
    return undefined;
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x7bf84d9b, Offset: 0x2dd8
// Size: 0xea
function function_82b6256d()
{
    self waittill( #"death", e_attacker );
    self zm_spawner::check_zombie_death_event_callbacks( e_attacker );
    
    if ( isdefined( level.var_a5d2ba4 ) && isdefined( level.var_26af7b39 ) && isplayer( e_attacker ) && level.var_26af7b39 && level.var_a5d2ba4 )
    {
        var_46927a7e = getent( "apothicon_belly_center", "targetname" );
        
        if ( e_attacker istouching( var_46927a7e ) && self istouching( var_46927a7e ) )
        {
            level notify( #"hash_ca3a841" );
        }
    }
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0xc90b97bb, Offset: 0x2ed0
// Size: 0x34
function function_df94945b()
{
    self thread zm_spawner::enemy_death_detection();
    self.completed_emerging_into_playable_area = 1;
    self.ignore_zombie_lift = 1;
}

// Namespace zm_ai_spiders
// Params 15
// Checksum 0x79476a02, Offset: 0x2f10
// Size: 0x10c
function function_5b625d74( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    if ( isdefined( self.archetype ) && self.archetype == "spider" )
    {
        if ( isdefined( eattacker ) )
        {
            if ( isdefined( eattacker.team ) && eattacker.team == self.team )
            {
                return 0;
            }
        }
        
        if ( !( isdefined( self.next_shot_kills ) && self.next_shot_kills ) )
        {
            self.next_shot_kills = 1;
        }
        else
        {
            return self.health;
        }
    }
    
    return idamage;
}

// Namespace zm_ai_spiders
// Params 3
// Checksum 0xd35e0191, Offset: 0x3028
// Size: 0x6f0
function function_49e57a3b( ai_spider, ent, var_a79b986e )
{
    if ( !isdefined( var_a79b986e ) )
    {
        var_a79b986e = 0;
    }
    
    if ( !isdefined( ent ) )
    {
        ent = self;
    }
    
    ai_spider endon( #"death" );
    
    if ( !isdefined( ent.target ) || var_a79b986e )
    {
        ai_spider ghost();
        ai_spider util::delay( 0.2, "death", &show );
        ai_spider util::delay_notify( 0.2, "visible", "death" );
        ai_spider.origin = ent.origin;
        ai_spider.angles = ent.angles;
        ai_spider vehicle_ai::set_state( "scripted" );
        
        if ( isalive( ai_spider ) )
        {
            a_ground_trace = groundtrace( ai_spider.origin + ( 0, 0, 100 ), ai_spider.origin - ( 0, 0, 1000 ), 0, ai_spider, 1 );
            
            if ( isdefined( a_ground_trace[ "position" ] ) )
            {
                var_197f1988 = util::spawn_model( "tag_origin", a_ground_trace[ "position" ], ai_spider.angles );
            }
            else
            {
                var_197f1988 = util::spawn_model( "tag_origin", ai_spider.origin, ai_spider.angles );
            }
            
            var_197f1988 scene::play( "scene_zm_dlc2_spider_burrow_out_of_ground", ai_spider );
            state = "combat";
            
            if ( randomfloat( 1 ) > 0.6 )
            {
                state = "meleeCombat";
            }
            
            ai_spider vehicle_ai::set_state( state );
            ai_spider setvisibletoall();
            ai_spider ai::set_ignoreme( 0 );
        }
        
        return;
    }
    
    ai_spider ai::set_ignoreall( 0 );
    ai_spider.meleeattackdist = 64;
    ai_spider.disablearrivals = 1;
    ai_spider.disableexits = 1;
    ai_spider vehicle_ai::set_state( "scripted" );
    ai_spider notify( #"visible" );
    var_ce7c81e4 = struct::get_array( ent.target, "targetname" );
    var_ed41ff6b = array::random( var_ce7c81e4 );
    
    if ( isdefined( var_ed41ff6b ) && isalive( ai_spider ) )
    {
        var_ed41ff6b.script_play_multiple = 1;
        level scene::play( ent.target, ai_spider );
    }
    else
    {
        var_36eb5144 = getvehiclenodearray( ent.target, "targetname" );
        var_a8deb964 = array::random( var_36eb5144 );
        ai_spider ghost();
        ai_spider.var_75bf86b = spawner::simple_spawn_single( "spider_mover_spawner" );
        ai_spider.origin = ai_spider.var_75bf86b.origin;
        ai_spider.angles = ai_spider.var_75bf86b.angles;
        ai_spider linkto( ai_spider.var_75bf86b );
        s_end = struct::get( var_a8deb964.target, "targetname" );
        ai_spider.var_75bf86b vehicle::get_on_path( var_a8deb964 );
        ai_spider show();
        
        if ( isdefined( var_a8deb964.script_int ) )
        {
            ai_spider.var_75bf86b setspeed( var_a8deb964.script_int );
        }
        else
        {
            ai_spider.var_75bf86b setspeed( 20 );
        }
        
        ai_spider.var_75bf86b vehicle::go_path();
        ai_spider notify( #"hash_a81735f9" );
        ai_spider unlink();
        ai_spider.var_75bf86b delete();
    }
    
    earthquake( 0.1, 0.5, ai_spider.origin, 256 );
    state = "combat";
    
    if ( randomfloat( 1 ) > 0.6 )
    {
        state = "meleeCombat";
    }
    
    ai_spider vehicle_ai::set_state( state );
    ai_spider.completed_emerging_into_playable_area = 1;
}

// Namespace zm_ai_spiders
// Params 5
// Checksum 0x74a5e5e4, Offset: 0x3720
// Size: 0x54
function function_c685a92b( damage, attacker, direction_vec, point, mod )
{
    if ( mod == "MOD_EXPLOSIVE" )
    {
        self thread function_81cf36fd();
    }
}

// Namespace zm_ai_spiders
// Params 0
// Checksum 0x52fb929b, Offset: 0x3780
// Size: 0x8c
function function_81cf36fd()
{
    self endon( #"death" );
    
    if ( !isdefined( self.var_7f8ad3ef ) )
    {
        self.var_7f8ad3ef = 0;
    }
    
    self.var_7f8ad3ef++;
    
    if ( self.var_7f8ad3ef >= 4 )
    {
        self shellshock( "pain", 1 );
    }
    
    self util::waittill_any_timeout( 10, "death" );
    self.var_7f8ad3ef--;
}

// Namespace zm_ai_spiders
// Params 1
// Checksum 0x6bc1fbc8, Offset: 0x3818
// Size: 0x8c
function function_d8cfc139( e_dest )
{
    self endon( #"death" );
    var_366514d8 = util::spawn_model( "tag_origin", self.origin, self.angles );
    var_366514d8 thread scene::play( "scene_zm_dlc2_spider_web_engage", self );
    self waittill( #"web" );
    self spit_projectile( e_dest );
}

// Namespace zm_ai_spiders
// Params 1
// Checksum 0x4fe0440b, Offset: 0x38b0
// Size: 0x114
function spit_projectile( e_dest )
{
    v_origin = self gettagorigin( "head_1" );
    v_angles = self gettagangles( "head_1" );
    var_e9ad0294 = util::spawn_model( "tag_origin", v_origin, v_angles );
    var_e9ad0294 thread fx::play( "spider_web_spit_reweb", v_origin, v_angles, "movedone", 1 );
    var_e9ad0294 moveto( e_dest.origin, 0.5 );
    var_e9ad0294 waittill( #"movedone" );
    var_e9ad0294 delete();
}

// Namespace zm_ai_spiders
// Params 1
// Checksum 0xf300ce14, Offset: 0x39d0
// Size: 0x11e, Type: bool
function function_7be01d65( str_zone )
{
    e_zone = level.zones[ str_zone ];
    
    for ( i = 0; i < e_zone.volumes.size ; i++ )
    {
        foreach ( player in level.players )
        {
            if ( zm_utility::is_player_valid( player, 0, 0 ) && player istouching( e_zone.volumes[ i ] ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

/#

    // Namespace zm_ai_spiders
    // Params 0
    // Checksum 0x445cb7c3, Offset: 0x3af8
    // Size: 0x44, Type: dev
    function function_3fd0c070()
    {
        level flagsys::wait_till( "<dev string:x1f1>" );
        zm_devgui::add_custom_devgui_callback( &function_8457e10f );
    }

    // Namespace zm_ai_spiders
    // Params 1
    // Checksum 0x9dcb747e, Offset: 0x3b48
    // Size: 0x296, Type: dev
    function function_8457e10f( cmd )
    {
        switch ( cmd )
        {
            case "<dev string:x20a>":
                var_19764360 = get_favorite_enemy();
                s_spawn_point = function_570247b9( var_19764360 );
                ai = zombie_utility::spawn_zombie( level.var_c38a4fee[ 0 ] );
                
                if ( isdefined( ai ) && isdefined( s_spawn_point ) )
                {
                    s_spawn_point thread function_49e57a3b( ai, s_spawn_point );
                }
                
                break;
            case "<dev string:x217>":
                var_19764360 = get_favorite_enemy();
                s_spawn_point = function_570247b9( var_19764360 );
                ai = zombie_utility::spawn_zombie( level.var_c38a4fee[ 0 ] );
                
                if ( isdefined( ai ) && isdefined( s_spawn_point ) )
                {
                    s_spawn_point thread function_49e57a3b( ai, s_spawn_point, 1 );
                }
                
                break;
            case "<dev string:x22b>":
                a_enemies = getaiteamarray( level.zombie_team );
                
                if ( a_enemies.size > 0 )
                {
                    foreach ( e_enemy in a_enemies )
                    {
                        if ( isdefined( e_enemy.b_is_spider ) && e_enemy.b_is_spider )
                        {
                            e_enemy kill();
                        }
                    }
                }
                
                break;
            case "<dev string:x237>":
                level.var_3013498 = level.round_number + 1;
                zm_devgui::zombie_devgui_goto_round( level.var_3013498 );
                break;
            default:
                level.var_42034f6a = 100;
                break;
        }
    }

#/
