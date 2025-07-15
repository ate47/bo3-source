#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_quad;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_quad;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_zonemgr;

#namespace zm_theater_quad;

// Namespace zm_theater_quad
// Params 0, eflags: 0x2
// Checksum 0x5001f15a, Offset: 0x650
// Size: 0x14
function autoexec init()
{
    function_66da4eb0();
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x4
// Checksum 0x7ae4cd28, Offset: 0x670
// Size: 0x1a4
function private function_66da4eb0()
{
    behaviortreenetworkutility::registerbehaviortreeaction( "traverseWallCrawlAction", &traversewallcrawlaction, &function_7d285db1, undefined );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "shouldWallTraverse", &shouldwalltraverse );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "shouldWallCrawl", &shouldwallcrawl );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "traverseWallIntro", &traversewallintro );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "traverseWallJumpOff", &traversewalljumpoff );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "quadCollisionService", &quadcollisionservice );
    animationstatenetwork::registeranimationmocomp( "quad_wall_traversal", &function_dd3e35df, undefined, undefined );
    animationstatenetwork::registeranimationmocomp( "quad_wall_jump_off", &function_5d8b540c, undefined, &function_18650281 );
    animationstatenetwork::registeranimationmocomp( "quad_move_strict_traversal", &function_9e9b3f8b, undefined, &function_2433815e );
}

// Namespace zm_theater_quad
// Params 2
// Checksum 0x56fc6e99, Offset: 0x820
// Size: 0x30
function traversewallcrawlaction( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    return 5;
}

// Namespace zm_theater_quad
// Params 2
// Checksum 0xf3a23c38, Offset: 0x858
// Size: 0x38
function function_7d285db1( entity, asmstatename )
{
    if ( !shouldwallcrawl( entity ) )
    {
        return 4;
    }
    
    return 5;
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0x35ff4fde, Offset: 0x898
// Size: 0x56, Type: bool
function shouldwalltraverse( entity )
{
    if ( isdefined( entity.traversestartnode ) )
    {
        if ( issubstr( entity.traversestartnode.animscript, "zm_wall_crawl_drop" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0x97e9290b, Offset: 0x8f8
// Size: 0x30, Type: bool
function shouldwallcrawl( entity )
{
    if ( isdefined( self.var_2826ab5d ) )
    {
        if ( gettime() >= self.var_2826ab5d )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0x411a7aab, Offset: 0x930
// Size: 0xf4
function traversewallintro( entity )
{
    entity allowpitchangle( 0 );
    entity.clamptonavmesh = 0;
    
    if ( isdefined( entity.traversestartnode ) )
    {
        entity.var_1bb3c5d0 = entity.traversestartnode;
        entity.var_7531a5e3 = entity.traverseendnode;
        
        if ( entity.traversestartnode.animscript == "zm_wall_crawl_drop" )
        {
            blackboard::setblackboardattribute( self, "_quad_wall_crawl", "quad_wall_crawl_theater" );
            return;
        }
        
        blackboard::setblackboardattribute( self, "_quad_wall_crawl", "quad_wall_crawl_start" );
    }
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0xef2f813a, Offset: 0xa30
// Size: 0x16
function traversewalljumpoff( entity )
{
    self.var_2826ab5d = undefined;
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0x3334f975, Offset: 0xa50
// Size: 0x1de, Type: bool
function quadcollisionservice( behaviortreeentity )
{
    if ( isdefined( behaviortreeentity.dontpushtime ) )
    {
        if ( gettime() < behaviortreeentity.dontpushtime )
        {
            return true;
        }
    }
    
    zombies = getaiteamarray( level.zombie_team );
    
    foreach ( zombie in zombies )
    {
        if ( zombie == behaviortreeentity )
        {
            continue;
        }
        
        if ( isdefined( zombie.knockdown ) && ( isdefined( zombie.missinglegs ) && zombie.missinglegs || zombie.knockdown ) )
        {
            continue;
        }
        
        dist_sq = distancesquared( behaviortreeentity.origin, zombie.origin );
        
        if ( dist_sq < 14400 )
        {
            behaviortreeentity pushactors( 0 );
            behaviortreeentity.dontpushtime = gettime() + 3000;
            zombie thread function_77876867();
            return true;
        }
    }
    
    behaviortreeentity pushactors( 1 );
    return false;
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0x507e84aa, Offset: 0xc38
// Size: 0x4c
function function_77876867()
{
    self endon( #"death" );
    self setavoidancemask( "avoid all" );
    wait 3;
    self setavoidancemask( "avoid none" );
}

// Namespace zm_theater_quad
// Params 5, eflags: 0x4
// Checksum 0x2b82fe84, Offset: 0xc90
// Size: 0x158
function private function_dd3e35df( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    animdist = abs( getmovedelta( mocompanim, 0, 1 )[ 2 ] );
    self.ground_pos = bullettrace( self.var_7531a5e3.origin, self.var_7531a5e3.origin + ( 0, 0, -100000 ), 0, self )[ "position" ];
    physdist = abs( self.origin[ 2 ] - self.ground_pos[ 2 ] - 60 );
    cycles = physdist / animdist;
    time = cycles * getanimlength( mocompanim );
    self.var_2826ab5d = gettime() + time * 1000;
}

// Namespace zm_theater_quad
// Params 5, eflags: 0x4
// Checksum 0x226cbd3a, Offset: 0xdf0
// Size: 0x4c
function private function_5d8b540c( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    entity animmode( "noclip", 0 );
}

// Namespace zm_theater_quad
// Params 5, eflags: 0x4
// Checksum 0x96dd1e2e, Offset: 0xe48
// Size: 0x58
function private function_18650281( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    entity allowpitchangle( 1 );
    entity.clamptonavmesh = 1;
}

// Namespace zm_theater_quad
// Params 5, eflags: 0x4
// Checksum 0xe7f116bc, Offset: 0xea8
// Size: 0x114
function private function_9e9b3f8b( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    assert( isdefined( entity.traversestartnode ) );
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity animmode( "noclip", 0 );
    entity forceteleport( entity.traversestartnode.origin, entity.traversestartnode.angles, 0 );
    entity orientmode( "face angle", entity.traversestartnode.angles[ 1 ] );
}

// Namespace zm_theater_quad
// Params 5, eflags: 0x4
// Checksum 0xa7a9829b, Offset: 0xfc8
// Size: 0x64
function private function_2433815e( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    entity finishtraversal();
    entity.usegoalanimweight = 0;
    entity.blockingpain = 0;
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0xe90eb5df, Offset: 0x1038
// Size: 0x84
function init_roofs()
{
    level flag::wait_till( "curtains_done" );
    level thread quad_stage_roof_break();
    level thread quad_lobby_roof_break();
    level thread quad_dining_roof_break();
    level thread function_79dea782();
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0xfd3e855, Offset: 0x10c8
// Size: 0x14c
function quad_roof_crumble_fx_play( n_index )
{
    play_quad_first_sounds();
    roof_parts = getentarray( self.target, "targetname" );
    
    if ( isdefined( roof_parts ) )
    {
        for ( i = 0; i < roof_parts.size ; i++ )
        {
            roof_parts[ i ] delete();
        }
    }
    
    fx = struct::get( self.target, "targetname" );
    
    if ( isdefined( fx ) )
    {
        self function_b7b3e976( n_index );
        thread rumble_all_players( "damage_heavy" );
    }
    
    if ( isdefined( self.script_noteworthy ) )
    {
        util::clientnotify( self.script_noteworthy );
    }
    
    if ( isdefined( self.script_int ) )
    {
        exploder::exploder( self.script_int );
    }
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0xe3935fd4, Offset: 0x1220
// Size: 0x164
function function_b7b3e976( n_index )
{
    switch ( n_index )
    {
        case 0:
            str_exploder_name = "fxexp_1012";
            break;
        case 1:
            str_exploder_name = "fxexp_1007";
            break;
        case 2:
            str_exploder_name = "fxexp_1008";
            break;
        case 3:
            str_exploder_name = "fxexp_1009";
            break;
        case 4:
            str_exploder_name = "fxexp_1010";
            break;
        case 5:
            str_exploder_name = "fxexp_1003";
            break;
        case 6:
            str_exploder_name = "fxexp_1004";
            break;
        case 7:
            str_exploder_name = "fxexp_1001";
            break;
        case 8:
            str_exploder_name = "fxexp_1002";
            break;
        case 10:
            str_exploder_name = "fxexp_1006";
            break;
        case 12:
            str_exploder_name = "fxexp_1014";
            break;
        case 15:
            str_exploder_name = "fxexp_1011";
            break;
    }
    
    if ( isdefined( str_exploder_name ) )
    {
        exploder::exploder( str_exploder_name );
    }
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0x5f003fa5, Offset: 0x1390
// Size: 0x9c
function play_quad_first_sounds()
{
    location = struct::get( self.target, "targetname" );
    self playsoundwithnotify( "zmb_vocals_quad_spawn", "sounddone" );
    self waittill( #"sounddone" );
    self playsound( "zmb_quad_roof_hit" );
    thread play_wood_land_sound( location.origin );
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0x94223b28, Offset: 0x1438
// Size: 0x3c
function play_wood_land_sound( origin )
{
    wait 1;
    playsoundatposition( "zmb_quad_roof_break_land", origin - ( 0, 0, 150 ) );
}

// Namespace zm_theater_quad
// Params 5
// Checksum 0xa9679396, Offset: 0x1480
// Size: 0x156
function rumble_all_players( high_rumble_string, low_rumble_string, rumble_org, high_rumble_range, low_rumble_range )
{
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( high_rumble_range ) && isdefined( low_rumble_range ) && isdefined( rumble_org ) )
        {
            if ( distance( players[ i ].origin, rumble_org ) < high_rumble_range )
            {
                players[ i ] playrumbleonentity( high_rumble_string );
            }
            else if ( distance( players[ i ].origin, rumble_org ) < low_rumble_range )
            {
                players[ i ] playrumbleonentity( low_rumble_string );
            }
            
            continue;
        }
        
        players[ i ] playrumbleonentity( high_rumble_string );
    }
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0x26af6178, Offset: 0x15e0
// Size: 0x4c
function quad_traverse_death_fx()
{
    self endon( #"traverse_anim" );
    self waittill( #"death" );
    playfx( level._effect[ "quad_grnd_dust_spwnr" ], self.origin );
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0x964a7798, Offset: 0x1638
// Size: 0x88
function begin_quad_introduction( quad_round_name )
{
    if ( level flag::get( "dog_round" ) )
    {
        level flag::clear( "dog_round" );
    }
    
    if ( level.next_dog_round == level.round_number + 1 )
    {
        level.next_dog_round++;
    }
    
    level.zombie_total = 0;
    level.quad_round_name = quad_round_name;
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0x4f2fd7a0, Offset: 0x16c8
// Size: 0x84
function theater_quad_round()
{
    level.zombie_health = level.zombie_vars[ "zombie_health_start" ];
    old_round = zm::get_round_number();
    level.zombie_total = 0;
    level.zombie_health = 100 * old_round;
    kill_all_zombies();
    zm::set_round_number( old_round );
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0xdee4c526, Offset: 0x1758
// Size: 0x12c
function spawn_second_wave_quads( second_wave_targetname )
{
    second_wave_spawners = [];
    second_wave_spawners = getentarray( second_wave_targetname, "targetname" );
    
    if ( second_wave_spawners.size < 1 )
    {
        assertmsg( "<dev string:x28>" );
        return;
    }
    
    for ( i = 0; i < second_wave_spawners.size ; i++ )
    {
        ai = zombie_utility::spawn_zombie( second_wave_spawners[ i ] );
        
        if ( isdefined( ai ) )
        {
            ai thread zombie_utility::round_spawn_failsafe();
            ai thread quad_traverse_death_fx();
        }
        
        wait randomintrange( 10, 45 );
    }
    
    util::wait_network_frame();
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0x80a24967, Offset: 0x1890
// Size: 0xbc
function spawn_a_quad_zombie( spawn_array )
{
    spawn_point = spawn_array[ randomint( spawn_array.size ) ];
    ai = zombie_utility::spawn_zombie( spawn_point );
    
    if ( isdefined( ai ) )
    {
        ai thread zombie_utility::round_spawn_failsafe();
        ai thread quad_traverse_death_fx();
    }
    
    wait level.zombie_vars[ "zombie_spawn_delay" ];
    util::wait_network_frame();
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0x3c6c674d, Offset: 0x1958
// Size: 0xce
function kill_all_zombies()
{
    zombies = getaispeciesarray( "axis", "all" );
    
    if ( isdefined( zombies ) )
    {
        for ( i = 0; i < zombies.size ; i++ )
        {
            if ( !isdefined( zombies[ i ] ) )
            {
                continue;
            }
            
            zombies[ i ] dodamage( zombies[ i ].health + 666, zombies[ i ].origin );
            util::wait_network_frame();
        }
    }
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0xdc5abe72, Offset: 0x1a30
// Size: 0x40
function prevent_round_ending()
{
    level endon( #"quad_round_can_end" );
    
    while ( true )
    {
        if ( level.zombie_total < 1 )
        {
            level.zombie_total = 1;
        }
        
        wait 0.5;
    }
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0x2243fc26, Offset: 0x1a78
// Size: 0x376
function intro_quad_spawn()
{
    timer = gettime();
    spawned = 0;
    previous_spawn_delay = level.zombie_vars[ "zombie_spawn_delay" ];
    thread prevent_round_ending();
    initial_spawners = [];
    
    switch ( level.quad_round_name )
    {
        case "initial_round":
            initial_spawners = getentarray( "initial_first_round_quad_spawner", "targetname" );
            break;
        case "theater_round":
            initial_spawners = getentarray( "initial_theater_round_quad_spawner", "targetname" );
            break;
        default:
            assertmsg( "<dev string:x57>" );
            return;
    }
    
    if ( initial_spawners.size < 1 )
    {
        assertmsg( "<dev string:x86>" );
        return;
    }
    
    while ( true )
    {
        if ( isdefined( level.delay_spawners ) )
        {
            manage_zombie_spawn_delay( timer );
        }
        
        level.delay_spawners = 1;
        spawn_a_quad_zombie( initial_spawners );
        wait 0.2;
        spawned++;
        
        if ( spawned > level.quads_per_round )
        {
            break;
        }
    }
    
    spawned = 0;
    second_spawners = [];
    
    switch ( level.quad_round_name )
    {
        case "initial_round":
            second_spawners = getentarray( "initial_first_round_quad_spawner_second_wave", "targetname" );
            break;
        case "theater_round":
            second_spawners = getentarray( "theater_round_quad_spawner_second_wave", "targetname" );
            break;
        default:
            assertmsg( "<dev string:xb1>" );
            return;
    }
    
    if ( second_spawners.size < 1 )
    {
        assertmsg( "<dev string:xda>" );
        return;
    }
    
    while ( true )
    {
        manage_zombie_spawn_delay( timer );
        spawn_a_quad_zombie( second_spawners );
        wait 0.2;
        spawned++;
        
        if ( spawned > level.quads_per_round * 2 )
        {
            break;
        }
    }
    
    level.zombie_vars[ "zombie_spawn_delay" ] = previous_spawn_delay;
    level.zombie_health = level.zombie_vars[ "zombie_health_start" ];
    level.zombie_total = 0;
    level.round_spawn_func = &zm::round_spawning;
    level thread [[ level.round_spawn_func ]]();
    wait 2;
    level notify( #"quad_round_can_end" );
    level.delay_spawners = undefined;
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0xc295855a, Offset: 0x1df8
// Size: 0x11e
function manage_zombie_spawn_delay( start_timer )
{
    if ( gettime() - start_timer < 15000 )
    {
        level.zombie_vars[ "zombie_spawn_delay" ] = randomintrange( 30, 45 );
        return;
    }
    
    if ( gettime() - start_timer < 25000 )
    {
        level.zombie_vars[ "zombie_spawn_delay" ] = randomintrange( 15, 30 );
        return;
    }
    
    if ( gettime() - start_timer < 35000 )
    {
        level.zombie_vars[ "zombie_spawn_delay" ] = randomintrange( 10, 15 );
        return;
    }
    
    if ( gettime() - start_timer < 50000 )
    {
        level.zombie_vars[ "zombie_spawn_delay" ] = randomintrange( 5, 10 );
    }
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0x7cd9e68d, Offset: 0x1f20
// Size: 0xe4
function quad_lobby_roof_break()
{
    zone = level.zones[ "foyer_zone" ];
    
    while ( true )
    {
        if ( zone.is_occupied )
        {
            flag::set( "lobby_occupied" );
            break;
        }
        
        util::wait_network_frame();
    }
    
    quad_stage_roof_break_single( 5 );
    wait 0.4;
    quad_stage_roof_break_single( 6 );
    wait 2;
    quad_stage_roof_break_single( 7 );
    wait 1;
    quad_stage_roof_break_single( 8 );
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0x126de1ce, Offset: 0x2010
// Size: 0xac
function quad_dining_roof_break()
{
    level endon( #"hash_e1db2a20" );
    zone = level.zones[ "dining_zone" ];
    
    while ( true )
    {
        if ( zone.is_occupied )
        {
            flag::set( "dining_occupied" );
            break;
        }
        
        util::wait_network_frame();
    }
    
    quad_stage_roof_break_single( 9 );
    wait 1;
    quad_stage_roof_break_single( 10 );
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0x894e9259, Offset: 0x20c8
// Size: 0x15c
function quad_stage_roof_break()
{
    quad_stage_roof_break_single( 1 );
    wait 2;
    quad_stage_roof_break_single( 3 );
    wait 0.33;
    quad_stage_roof_break_single( 2 );
    wait 1;
    quad_stage_roof_break_single( 0 );
    wait 0.45;
    quad_stage_roof_break_single( 4 );
    level thread play_quad_start_vo();
    wait 0.33;
    quad_stage_roof_break_single( 15 );
    wait 0.4;
    quad_stage_roof_break_single( 11 );
    wait 0.45;
    quad_stage_roof_break_single( 12 );
    wait 0.3;
    quad_stage_roof_break_single( 13 );
    wait 0.35;
    quad_stage_roof_break_single( 14 );
    zm_ai_quad::function_5af423f4();
}

// Namespace zm_theater_quad
// Params 1
// Checksum 0xd0e5aeb3, Offset: 0x2230
// Size: 0x5c
function quad_stage_roof_break_single( index )
{
    trigger = getent( "quad_roof_crumble_fx_origin_" + index, "target" );
    trigger thread quad_roof_crumble_fx_play( index );
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0xce845c53, Offset: 0x2298
// Size: 0x74
function play_quad_start_vo()
{
    players = getplayers();
    player = players[ randomintrange( 0, players.size ) ];
    player zm_audio::create_and_play_dialog( "general", "quad_spawn" );
}

// Namespace zm_theater_quad
// Params 0
// Checksum 0xfc971e39, Offset: 0x2318
// Size: 0xd6
function function_79dea782()
{
    trigger = getent( "quad_roof_crumble_fx_origin_10", "target" );
    trigger waittill( #"trigger", who );
    level notify( #"hash_e1db2a20" );
    roof_parts = getentarray( trigger.target, "targetname" );
    
    if ( isdefined( roof_parts ) )
    {
        for ( i = 0; i < roof_parts.size ; i++ )
        {
            roof_parts[ i ] delete();
        }
    }
}

