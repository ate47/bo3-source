#using scripts/codescripts/struct;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_ai_monkey;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_shrink_ray;

#namespace zm_temple_ai_monkey;

// Namespace zm_temple_ai_monkey
// Params 0, eflags: 0x2
// Checksum 0x2f097df8, Offset: 0xac0
// Size: 0x44
function autoexec function_dafa313c()
{
    clientfield::register( "scriptmover", "monkey_ragdoll", 21000, 1, "int" );
    initmonkeybehaviorsandasm();
}

// Namespace zm_temple_ai_monkey
// Params 0, eflags: 0x4
// Checksum 0xc8165d87, Offset: 0xb10
// Size: 0x54
function private initmonkeybehaviorsandasm()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "templeMonkeyTargetService", &templemonkeytargetservice );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "templeMonkeyDeathStart", &templemonkeydeathstart );
}

// Namespace zm_temple_ai_monkey
// Params 1, eflags: 0x4
// Checksum 0xd19aac9e, Offset: 0xb70
// Size: 0x10, Type: bool
function private templemonkeytargetservice( entity )
{
    return true;
}

// Namespace zm_temple_ai_monkey
// Params 1, eflags: 0x4
// Checksum 0x83574584, Offset: 0xb88
// Size: 0x52
function private templemonkeydeathstart( entity )
{
    if ( isdefined( entity.powerup_to_grab ) )
    {
        entity.powerup_to_grab.claimed = 0;
        level notify( #"powerup_dropped", entity.powerup_to_grab );
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xb406ca32, Offset: 0xbe8
// Size: 0x1f4
function init()
{
    precache_ambient_monkey_anims();
    level._effect[ "monkey_death" ] = "maps/zombie/fx_zmb_monkey_death";
    level._effect[ "monkey_spawn" ] = "maps/zombie/fx_zombie_ape_spawn_dust";
    level._effect[ "monkey_eye_glow" ] = "maps/zombie/fx_zmb_monkey_eyes";
    level._effect[ "monkey_gib" ] = "maps/zombie_temple/fx_ztem_zombie_mini_squish";
    level._effect[ "monkey_gib_no_gore" ] = "dlc5/temple/fx_ztem_monkey_shrink";
    level._effect[ "monkey_launch" ] = "weapon/fx_trail_rpg";
    level.monkey_zombie_spawners = getentarray( "monkey_zombie_spawner", "targetname" );
    level.nextmonkeystealround = 1;
    level.monkey_zombie_health = level.zombie_vars[ "zombie_health_start" ];
    level.stealer_monkey_spawns = struct::get_array( "stealer_monkey_spawn", "targetname" );
    level.stealer_monkey_exits = struct::get_array( "stealer_monkey_exit", "targetname" );
    
    /#
        cheat = getdvarint( "<dev string:x28>" );
        
        if ( cheat )
        {
            level.nextmonkeystealround = 1;
        }
    #/
    
    level thread _setup_zone_info();
    level thread _watch_for_powerups();
    monkey_ambient_init();
    level thread monkey_grenade_watcher_temple();
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x47e93861, Offset: 0xde8
// Size: 0x3c
function monkey_grenade_watcher_temple()
{
    level flag::wait_till( "initial_players_connected" );
    level thread zm_ai_monkey::monkey_grenade_watcher();
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x2143c89d, Offset: 0xe30
// Size: 0x24
function monkey_templethink( spawner )
{
    self thread _monkey_templethinkinternal( spawner );
}

// Namespace zm_temple_ai_monkey
// Params 3
// Checksum 0xf0943f5f, Offset: 0xe60
// Size: 0x304
function monkey_getmonkeyspawnlocation( mindist, checkvisible, skipstartarea )
{
    visitedzones = [];
    needtovisit = [];
    startzone = self _ent_getzonename();
    needtovisit[ 0 ] = startzone;
    zonecounter = 0;
    
    while ( needtovisit.size > 0 )
    {
        zonecounter++;
        visitname = needtovisit[ 0 ];
        zone = level.zones[ visitname ];
        
        if ( !skipstartarea || isdefined( zone.barriers ) && startzone != visitname )
        {
            barriers = array_randomize_knuth( zone.barriers );
            
            for ( i = 0; i < barriers.size ; i++ )
            {
                text = "Zone: " + zonecounter + " Barrier: " + i;
                
                if ( barriers[ i ] barrier_test( zone, self, mindist, checkvisible ) )
                {
                    location = getbarrierattacklocation( barriers[ i ] );
                    return location;
                }
            }
        }
        
        visitedzones[ visitedzones.size ] = visitname;
        arrayremoveindex( needtovisit, 0 );
        azkeys = getarraykeys( zone.adjacent_zones );
        azkeys = array_randomize_knuth( azkeys );
        
        for ( i = 0; i < azkeys.size ; i++ )
        {
            name = azkeys[ i ];
            
            if ( !isinarray( visitedzones, name ) )
            {
                adjzone = zone.adjacent_zones[ name ];
                globalzone = level.zones[ name ];
                
                if ( adjzone.is_connected && globalzone.is_enabled )
                {
                    needtovisit[ needtovisit.size ] = name;
                }
            }
        }
    }
    
    return undefined;
}

// Namespace zm_temple_ai_monkey
// Params 4
// Checksum 0x6b4a293a, Offset: 0x1170
// Size: 0x190, Type: bool
function barrier_test( zone, ent, mindist, checkvisible )
{
    if ( !zone.is_active )
    {
        return true;
    }
    
    mindist2 = mindist * mindist;
    disttobarrier = distancesquared( ent.origin, self.origin );
    
    if ( disttobarrier < mindist2 )
    {
        return false;
    }
    
    if ( checkvisible )
    {
        playervisdist = 1800;
        playervisdist2 = playervisdist * playervisdist;
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            player = players[ i ];
            disttoplayer2 = distancesquared( player.origin, self.origin );
            
            if ( disttoplayer2 < playervisdist2 )
            {
                if ( self player_can_see_me( player ) )
                {
                    return false;
                }
            }
        }
    }
    
    return true;
}

// Namespace zm_temple_ai_monkey
// Params 3
// Checksum 0xbe00dfde, Offset: 0x1308
// Size: 0x1fe
function ent_gathervalidbarriers( zoneoverride, ignoreoccupied, ignorevisible )
{
    valid_barriers = [];
    monkeyzone = zoneoverride;
    
    if ( !isdefined( monkeyzone ) )
    {
        monkeyzone = self _ent_getzonename();
    }
    
    if ( isdefined( monkeyzone ) )
    {
        s = spawnstruct();
        zonenames = _getconnectedzonenames( monkeyzone, s );
        players = getplayers();
        
        for ( i = 0; i < zonenames.size ; i++ )
        {
            name = zonenames[ i ];
            zone = level.zones[ name ];
            
            if ( isdefined( ignoreoccupied ) && ignoreoccupied && zone.is_occupied )
            {
                continue;
            }
            
            barriers = [];
            
            if ( isdefined( ignorevisible ) && ignorevisible )
            {
                barriers = _get_non_visible_barriers( zone.barriers );
            }
            else if ( isdefined( zone.barriers ) )
            {
                barriers = zone.barriers;
            }
            
            if ( barriers.size > 0 )
            {
                valid_barriers = arraycombine( valid_barriers, barriers, 0, 0 );
            }
        }
    }
    
    return valid_barriers;
}

// Namespace zm_temple_ai_monkey
// Params 2
// Checksum 0x1e5d3abb, Offset: 0x1510
// Size: 0x188
function printtext( text, red )
{
    level endon( #"stopprints" );
    
    if ( !isdefined( level.printoffsets ) )
    {
        level.printoffsets = [];
    }
    
    originstr = "(" + self.origin[ 0 ] + "," + self.origin[ 1 ] + "," + self.origin[ 2 ] + ")";
    
    if ( !isdefined( level.printoffsets[ originstr ] ) )
    {
        level.printoffsets[ originstr ] = ( 0, 0, 0 );
    }
    else
    {
        level.printoffsets[ originstr ] += ( 0, 0, 20 );
    }
    
    offset = ( 0, 0, 45 ) + level.printoffsets[ originstr ];
    color = ( 0, 1, 0 );
    
    if ( isdefined( red ) && red )
    {
        color = ( 1, 0, 0 );
    }
    
    while ( true )
    {
        /#
            print3d( self.origin + offset, text, color, 0.85 );
        #/
        
        wait 0.05;
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x995768ab, Offset: 0x16a0
// Size: 0x1c
function printtextstop()
{
    level notify( #"stopprints" );
    level.printoffsets = [];
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0xe30ad362, Offset: 0x16c8
// Size: 0x154
function _get_non_visible_barriers( barriers )
{
    returnbarriers = [];
    
    if ( isdefined( barriers ) )
    {
        players = getplayers();
        
        for ( i = 0; i < barriers.size ; i++ )
        {
            cansee = 0;
            
            for ( j = 0; j < players.size ; j++ )
            {
                if ( abs( barriers[ i ].origin[ 2 ] - players[ j ].origin[ 2 ] ) < 200 )
                {
                    if ( barriers[ i ] player_can_see_me( players[ j ] ) )
                    {
                        cansee = 1;
                        break;
                    }
                }
            }
            
            if ( !cansee )
            {
                returnbarriers[ returnbarriers.size ] = barriers[ i ];
            }
        }
    }
    
    return returnbarriers;
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0xe24e9c6d, Offset: 0x1828
// Size: 0x1c0
function player_can_see_me( player )
{
    playerangles = player getplayerangles();
    playerforwardvec = anglestoforward( playerangles );
    playerunitforwardvec = vectornormalize( playerforwardvec );
    banzaipos = self.origin;
    playerpos = player geteyeapprox();
    playertobanzaivec = banzaipos - playerpos;
    playertobanzaiunitvec = vectornormalize( playertobanzaivec );
    forwarddotbanzai = vectordot( playerunitforwardvec, playertobanzaiunitvec );
    anglefromcenter = acos( forwarddotbanzai );
    playerfov = getdvarfloat( "cg_fov" );
    banzaivsplayerfovbuffer = getdvarfloat( "g_banzai_player_fov_buffer" );
    
    if ( banzaivsplayerfovbuffer <= 0 )
    {
        banzaivsplayerfovbuffer = 0.2;
    }
    
    playercanseeme = anglefromcenter <= playerfov * 0.5 * ( 1 - banzaivsplayerfovbuffer );
    return playercanseeme;
}

// Namespace zm_temple_ai_monkey
// Params 2
// Checksum 0xdf42307c, Offset: 0x19f0
// Size: 0x58
function function_16882cf8( loc, color )
{
    while ( true )
    {
        /#
            circle( loc, 16, color, 0, 1, 800 );
        #/
        
        wait 0.05;
    }
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0xa514484, Offset: 0x1a50
// Size: 0x84
function getbarrierattacklocation( barrier )
{
    forward = anglestoforward( barrier.angles );
    attack_location = barrier.origin + forward * 80;
    attack_location = getclosestpointonnavmesh( attack_location, 200 );
    return attack_location;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xd321cacc, Offset: 0x1ae0
// Size: 0x44
function _ent_getzone()
{
    zonename = self _ent_getzonename();
    
    if ( isdefined( zonename ) )
    {
        return level.zones[ zonename ];
    }
    
    return undefined;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xc8b17919, Offset: 0x1b30
// Size: 0xfc
function _ent_getzonename()
{
    zkeys = getarraykeys( level.zones );
    
    for ( z = 0; z < zkeys.size ; z++ )
    {
        zonename = zkeys[ z ];
        zone = level.zones[ zonename ];
        
        for ( v = 0; v < zone.volumes.size ; v++ )
        {
            touching = self istouching( zone.volumes[ v ] );
            
            if ( touching )
            {
                return zonename;
            }
        }
    }
    
    return undefined;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xd0dbac82, Offset: 0x1c38
// Size: 0x1e4
function _setup_zone_info()
{
    wait 1;
    checkent = spawn( "script_origin", ( 0, 0, 0 ) );
    
    for ( i = 0; i < level.exterior_goals.size ; i++ )
    {
        goal = level.exterior_goals[ i ];
        forward = anglestoforward( goal.angles );
        checkent.origin = goal.origin + forward * 100;
        zonename = checkent _ent_getzonename();
        valid = isdefined( zonename ) && isdefined( level.zones[ zonename ] );
        
        if ( !valid )
        {
            /#
                iprintln( "<dev string:x3b>" + checkent.origin );
            #/
            
            continue;
        }
        
        goal.zonename = zonename;
        zone = level.zones[ zonename ];
        
        if ( !isdefined( zone.barriers ) )
        {
            zone.barriers = [];
        }
        
        zone.barriers[ zone.barriers.size ] = goal;
    }
    
    checkent delete();
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x20b6862c, Offset: 0x1e28
// Size: 0xfc
function _monkey_templethinkinternal( spawner )
{
    self endon( #"death" );
    spawner.count = 100;
    spawner.last_spawn_time = gettime();
    playfx( level._effect[ "monkey_death" ], self.origin );
    playsoundatposition( "zmb_bolt", self.origin );
    self.deathfunction = &_monkey_zombietempledeathcallback;
    self.spawnzone = spawner.script_noteworthy;
    self.shrink_ray_fling = &_monkey_templefling;
    self thread monkey_zombie_choose_sprint_temple();
    self thread _monkey_gotoboards();
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x8e70bc11, Offset: 0x1f30
// Size: 0x3c
function monkey_zombie_choose_run_temple( moveplaybackrate )
{
    self.zombie_move_speed = "run";
    self zombie_utility::set_zombie_run_cycle( "run" );
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x2f967968, Offset: 0x1f78
// Size: 0x3c
function monkey_zombie_choose_sprint_temple( moveplaybackrate )
{
    self.zombie_move_speed = "sprint";
    self zombie_utility::set_zombie_run_cycle( "sprint" );
}

// Namespace zm_temple_ai_monkey
// Params 8
// Checksum 0x3d4f36fc, Offset: 0x1fc0
// Size: 0x126, Type: bool
function _monkey_zombietempledeathcallback( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    self zombie_utility::reset_attack_spot();
    self.grenadeammo = 0;
    self thread zombie_utility::zombie_eye_glow_stop();
    playfx( level._effect[ "monkey_death" ], self.origin );
    
    if ( isdefined( self.attacker ) && isplayer( self.attacker ) )
    {
        self.attacker zm_audio::create_and_play_dialog( "kill", "thief" );
    }
    
    if ( self.damagemod == "MOD_BURNED" )
    {
        self thread zombie_death::flame_death_fx();
    }
    
    return false;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xd277b31e, Offset: 0x20f0
// Size: 0x194
function _monkey_gotoboards()
{
    self endon( #"death" );
    self endon( #"shrink" );
    barriers = level.zones[ self.spawnzone ].barriers;
    
    if ( !isdefined( barriers ) )
    {
        barriers = [];
    }
    
    barriers = _sort_by_num_boards( barriers );
    
    for ( i = 0; i < barriers.size ; i++ )
    {
        barrier = barriers[ i ];
        location = getbarrierattacklocation( barrier );
        self.goalradius = 32;
        self setgoalpos( location );
        self waittill( #"goal" );
        self setgoalpos( self.origin );
        
        while ( true )
        {
            chunk = _find_chunk( barrier.barrier_chunks );
            
            if ( !isdefined( chunk ) )
            {
                break;
            }
            
            self _monkey_destroyboards( barrier, chunk, location );
        }
    }
    
    self _monkey_remove();
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x1e9dcd37, Offset: 0x2290
// Size: 0x98
function _find_chunk( barrier_chunks )
{
    assert( isdefined( barrier_chunks ), "<dev string:x5d>" );
    
    for ( i = 0; i < barrier_chunks.size ; i++ )
    {
        if ( barrier_chunks[ i ] zm_utility::get_chunk_state() == "repaired" )
        {
            return barrier_chunks[ i ];
        }
    }
    
    return undefined;
}

// Namespace zm_temple_ai_monkey
// Params 3
// Checksum 0x7d74ef5a, Offset: 0x2330
// Size: 0x1ba
function _monkey_destroyboards( barrier, chunk, location )
{
    chunk zm_blockers::update_states( "target_by_zombie" );
    self teleport( location, self.angles );
    time = self getanimlengthfromasd( "zm_attack_perks_front", 0 );
    self thread zm_ai_monkey::play_attack_impacts( time );
    zombie_shared::donotetracks( "attack_perks_front" );
    playfx( level._effect[ "wood_chunk_destory" ], chunk.origin );
    
    if ( chunk.script_noteworthy == "4" || chunk.script_noteworthy == "6" )
    {
        chunk thread zm_spawner::zombie_boardtear_offset_fx_horizontle( chunk, barrier );
    }
    else
    {
        chunk thread zm_spawner::zombie_boardtear_offset_fx_verticle( chunk, barrier );
    }
    
    level thread zm_blockers::remove_chunk( chunk, barrier, 1, self );
    chunk zm_blockers::update_states( "destroyed" );
    chunk notify( #"destroyed" );
    wait time;
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x542d9b90, Offset: 0x24f8
// Size: 0x10
function _sort_by_num_boards( barriers )
{
    return barriers;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x18dc800c, Offset: 0x2510
// Size: 0xc8
function _watch_for_powerups()
{
    if ( !isdefined( level.monkey_zombie_spawners ) || level.monkey_zombie_spawners.size == 0 )
    {
        return;
    }
    
    while ( true )
    {
        level waittill( #"powerup_dropped", powerup );
        
        if ( !isdefined( powerup ) )
        {
            continue;
        }
        
        if ( level.round_number < level.nextmonkeystealround )
        {
            continue;
        }
        
        wait randomfloatrange( 0, 1 );
        
        if ( _cangrabpowerup( powerup ) )
        {
            _grab_powerup( powerup );
        }
    }
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0xeb0aac2, Offset: 0x25e0
// Size: 0x38, Type: bool
function _cangrabpowerup( powerup )
{
    return !isdefined( powerup.claimed ) || isdefined( powerup ) && !powerup.claimed;
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x7cc7ddba, Offset: 0x2620
// Size: 0x258
function _grab_powerup( powerup )
{
    spawner = level.monkey_zombie_spawners[ 0 ];
    monkey = zombie_utility::spawn_zombie( spawner );
    
    if ( !isdefined( monkey ) )
    {
        return;
    }
    
    level.nextmonkeystealround = 1;
    
    /#
        cheat = getdvarint( "<dev string:x28>" );
        
        if ( cheat )
        {
            level.nextmonkeystealround = 1;
        }
    #/
    
    monkey.ignore_enemy_count = 1;
    monkey.meleedamage = 10;
    monkey.custom_damage_func = &monkey_temple_custom_damage;
    location = monkey _monkey_getspawnlocation( powerup );
    monkey forceteleport( location, monkey.angles );
    monkey.deathfunction = &_monkey_zombietempleescapedeathcallback;
    monkey.shrink_ray_fling = &_monkey_templefling;
    monkey.zombie_sliding = &_monkey_templesliding;
    monkey.no_shrink = 0;
    monkey.ignore_solo_last_stand = 1;
    spawner.count = 100;
    spawner.last_spawn_time = gettime();
    monkey thread monkey_zombie_choose_sprint_temple();
    monkey.powerup_to_grab = powerup;
    monkey thread _monkey_zombie_grenade_watcher();
    monkey thread _monkey_checkplayablearea();
    monkey thread _monkey_timeout();
    monkey thread _monkey_stealpowerup();
    monkey.zombie_think_done = 1;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x176b5b85, Offset: 0x2880
// Size: 0x50
function _monkey_play_stolen_loop()
{
    self endon( #"death" );
    self endon( #"powerup_dropped" );
    
    while ( true )
    {
        playsoundatposition( "zmb_stealer_stolen", self.origin );
        wait 0.845;
    }
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0xeacab488, Offset: 0x28d8
// Size: 0xc4
function _monkey_getspawnlocation( e_powerup )
{
    var_9199584e = self monkey_getmonkeyspawnlocation( 700, 0, 1 );
    
    if ( !isdefined( var_9199584e ) )
    {
        var_9199584e = self monkey_getmonkeyspawnlocation( 700, 1, 0 );
    }
    
    if ( !isdefined( var_9199584e ) )
    {
        var_9199584e = self monkey_getmonkeyspawnlocation( 0, 0, 0 );
    }
    
    if ( !isdefined( var_9199584e ) && isdefined( e_powerup ) )
    {
        var_9199584e = getbarrierattacklocation( e_powerup );
    }
    
    return var_9199584e;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xd66c5f06, Offset: 0x29a8
// Size: 0x9c
function _monkey_stealpowerup()
{
    self endon( #"death" );
    self endon( #"end_monkey_steal" );
    self _monkey_grabpowerup();
    
    if ( !isdefined( self.powerup ) && !( isdefined( self.attack_player ) && self.attack_player ) )
    {
        self monkey_attack_player();
    }
    
    self thread _monkey_pathcheck();
    self _monkey_escape();
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x176e26c9, Offset: 0x2a50
// Size: 0xfc
function _monkey_pathcheck()
{
    self notify( #"end_pathcheck" );
    self endon( #"end_pathcheck" );
    self endon( #"escape_goal" );
    self endon( #"death" );
    self waittill( #"bad_path" );
    self notify( #"end_monkey_steal" );
    self.melee_count = 0;
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( zombie_utility::is_player_valid( players[ i ] ) )
        {
            self.player_stole_power_up = players[ i ];
        }
    }
    
    self monkey_attack_player();
    self thread _monkey_stealpowerup();
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x11e9f4db, Offset: 0x2b58
// Size: 0x1cc
function _monkey_grabpowerup()
{
    if ( isdefined( self.powerup_to_grab ) )
    {
        self.goalradius = 16;
        powerup_pos = getclosestpointonnavmesh( self.powerup_to_grab.origin, 200 );
        self setgoalpos( powerup_pos );
        self _monkey_grap_powerup_wait();
    }
    
    if ( _cangrabpowerup( self.powerup_to_grab ) )
    {
        self monkey_zombie_choose_run_temple();
        self.powerup_to_grab show();
        self _monkey_bindpowerup( self.powerup_to_grab );
        self.powerup = self.powerup_to_grab;
        self.powerup_to_grab = undefined;
        
        if ( isdefined( self.powerup.grab_count ) )
        {
            self.powerup.grab_count++;
        }
        else
        {
            self.powerup.grab_count = 1;
        }
        
        self.powerup thread powerup_red( self );
        self.powerup thread _powerup_randomize( self );
        self thread _monkey_play_stolen_loop();
        self.powerup.stolen = 1;
        self.powerup notify( #"powerup_grabbed" );
        self thread player_random_response_to_theft();
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x9947f194, Offset: 0x2d30
// Size: 0xb0
function player_random_response_to_theft()
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( distancesquared( self.origin, players[ i ].origin ) <= 250000 )
        {
            players[ i ] thread zm_audio::create_and_play_dialog( "general", "thief_steal" );
            return;
        }
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x561fce2e, Offset: 0x2de8
// Size: 0x3c
function _monkey_grap_powerup_wait()
{
    self endon( #"goal" );
    self.powerup_to_grab waittill( #"death" );
    self.player_stole_power_up = self.powerup_to_grab.power_up_grab_player;
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0xb2673d07, Offset: 0x2e30
// Size: 0xdc
function powerup_red( monkey )
{
    monkey endon( #"death" );
    self.fx_red = zm_net::network_safe_spawn( "monkey_red_powerup", 2, "script_model", self.origin );
    self.fx_red setmodel( "tag_origin" );
    self.fx_red linkto( self );
    playfxontag( level._effect[ "powerup_on_red" ], self.fx_red, "tag_origin" );
    self clientfield::set( "powerup_fx", 3 );
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x423e6b8a, Offset: 0x2f18
// Size: 0x324
function _monkey_escape()
{
    self endon( #"death" );
    self endon( #"end_monkey_steal" );
    self notify( #"stop_find_flesh" );
    self.escaping = 1;
    self _monkey_add_time();
    location = ( 0, 0, 0 );
    angles = ( 0, 0, 0 );
    playexitanim = 0;
    
    if ( level.stealer_monkey_exits.size > 0 )
    {
        playexitanim = 1;
        randstruct = array::random( level.stealer_monkey_exits );
        location = randstruct.origin;
        angles = randstruct.angles;
    }
    else
    {
        valid_escapes = self ent_gathervalidbarriers();
        maxdist = 0;
        bestbarrier = undefined;
        
        for ( i = 0; i < valid_escapes.size ; i++ )
        {
            dist2 = distancesquared( self.origin, valid_escapes[ i ].origin );
            
            if ( dist2 > maxdist )
            {
                maxdist = dist2;
                bestbarrier = valid_escapes[ i ];
            }
        }
        
        location = getbarrierattacklocation( bestbarrier );
    }
    
    self.goalradius = 8;
    location = getclosestpointonnavmesh( location, 200 );
    self setgoalpos( location );
    self waittill( #"goal" );
    self notify( #"escape_goal" );
    
    if ( playexitanim )
    {
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        escape_anim = "rtrg_ai_zm_dlc5_monkey_pap_escape";
        time = getanimlength( escape_anim );
        self animscripted( "escape_anim", self.origin, self.angles, escape_anim );
        wait time;
    }
    
    haspowerup = isdefined( self.powerup );
    
    if ( haspowerup )
    {
        level notify( #"monkey_powerup_escape" );
    }
    
    level thread escape_monkey_counter( haspowerup );
    self _monkey_remove();
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0xdf23e1c6, Offset: 0x3248
// Size: 0x74
function escape_monkey_counter( haspowerup )
{
    if ( !isdefined( level.monkey_escape_count ) )
    {
        level.monkey_escape_count = 0;
        level.monkey_escape_with_powerup_count = 0;
    }
    
    level.monkey_escape_count++;
    
    if ( haspowerup )
    {
        level.monkey_escape_with_powerup_count++;
    }
    
    if ( level.monkey_escape_with_powerup_count % 5 == 0 )
    {
        level thread launch_monkey();
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xa9ee6bd7, Offset: 0x32c8
// Size: 0x12c
function launch_monkey()
{
    effectent = spawn( "script_model", ( -24, 1448, 1000 ) );
    
    if ( isdefined( effectent ) )
    {
        effectent endon( #"death" );
        effectent setmodel( "tag_origin" );
        effectent.angles = ( 90, 0, 0 );
        playfxontag( level._effect[ "monkey_launch" ], effectent, "tag_origin" );
        launchtime = 6;
        effectent moveto( effectent.origin + ( 0, 0, 2500 ), launchtime, 3 );
        wait launchtime;
        effectent delete();
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xa9d6105d, Offset: 0x3400
// Size: 0x170
function _monkey_checkplayablearea()
{
    self endon( #"death" );
    candamage = 1;
    areas = getentarray( "player_volume", "script_noteworthy" );
    
    while ( true )
    {
        inarea = 0;
        
        for ( i = 0; i < areas.size && !inarea ; i++ )
        {
            inarea = self istouching( areas[ i ] );
        }
        
        if ( candamage && !inarea )
        {
            println( "<dev string:xa2>" );
            candamage = 0;
            self util::magic_bullet_shield();
        }
        else if ( !candamage && inarea )
        {
            println( "<dev string:xb3>" );
            candamage = 1;
            self util::stop_magic_bullet_shield();
        }
        
        wait 0.2;
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x91a5a15e, Offset: 0x3578
// Size: 0x64
function _monkey_timeout()
{
    self endon( #"death" );
    
    if ( !isdefined( self.endtime ) )
    {
        self.endtime = gettime() + 60000;
    }
    
    while ( self.endtime > gettime() )
    {
        wait 0.5;
    }
    
    self _monkey_remove();
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xcdf54b17, Offset: 0x35e8
// Size: 0x18
function _monkey_add_time()
{
    self.endtime = gettime() + 60000;
}

// Namespace zm_temple_ai_monkey
// Params 8
// Checksum 0x15b32224, Offset: 0x3608
// Size: 0x286, Type: bool
function _monkey_zombietempleescapedeathcallback( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    self.grenadeammo = 0;
    playsoundatposition( "zmb_stealer_death", self.origin );
    self thread zombie_utility::zombie_eye_glow_stop();
    
    if ( isdefined( self.attacker ) && isplayer( self.attacker ) )
    {
        self.attacker zm_audio::create_and_play_dialog( "kill", "thief" );
        isfavoriteenemy = isdefined( self.favoriteenemy ) && self.favoriteenemy == self.attacker;
        nomeleehits = !isdefined( self.melee_count ) || self.melee_count == 0;
        
        if ( isdefined( self.attacking_player ) && self.attacking_player && nomeleehits && isfavoriteenemy )
        {
            self.attacker zm_score::player_add_points( "thundergun_fling", 500, ( 0, 0, 0 ), 0 );
        }
    }
    
    if ( isdefined( self.attacker ) && isplayer( self.attacker ) )
    {
        self.attacker zm_score::player_add_points( "damage" );
    }
    
    if ( isdefined( self.powerup ) )
    {
        self _monkey_dropstolenpowerup();
    }
    
    if ( "rottweil72_upgraded_zm" == self.damageweapon.name && "MOD_RIFLE_BULLET" == self.damagemod )
    {
        self thread _monkey_temple_dragons_breath_flame_death_fx();
    }
    
    if ( isdefined( self.do_gib_death ) && self.do_gib_death )
    {
        self thread _monkey_gib();
        self util::delay( 0.05, undefined, &zm_utility::self_delete );
    }
    
    return false;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xf9aa0d5d, Offset: 0x3898
// Size: 0x284
function _monkey_temple_dragons_breath_flame_death_fx()
{
    if ( self.isdog )
    {
        return;
    }
    
    if ( !isdefined( level._effect ) || !isdefined( level._effect[ "character_fire_death_sm" ] ) )
    {
        println( "<dev string:xc1>" );
        return;
    }
    
    playfxontag( level._effect[ "character_fire_death_sm" ], self, "J_SpineLower" );
    tagarray = [];
    
    if ( !isdefined( self.a.gib_ref ) || self.a.gib_ref != "left_arm" )
    {
        tagarray[ tagarray.size ] = "J_Elbow_LE";
        tagarray[ tagarray.size ] = "J_Wrist_LE";
    }
    
    if ( !isdefined( self.a.gib_ref ) || self.a.gib_ref != "right_arm" )
    {
        tagarray[ tagarray.size ] = "J_Elbow_RI";
        tagarray[ tagarray.size ] = "J_Wrist_RI";
    }
    
    if ( self.a.gib_ref != "no_legs" && ( !isdefined( self.a.gib_ref ) || self.a.gib_ref != "left_leg" ) )
    {
        tagarray[ tagarray.size ] = "J_Knee_LE";
        tagarray[ tagarray.size ] = "J_Ankle_LE";
    }
    
    if ( self.a.gib_ref != "no_legs" && ( !isdefined( self.a.gib_ref ) || self.a.gib_ref != "right_leg" ) )
    {
        tagarray[ tagarray.size ] = "J_Knee_RI";
        tagarray[ tagarray.size ] = "J_Ankle_RI";
    }
    
    tagarray = array::randomize( tagarray );
    playfxontag( level._effect[ "character_fire_death_sm" ], self, tagarray[ 0 ] );
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x3705b379, Offset: 0x3b28
// Size: 0x1c2
function _monkey_dropstolenpowerup()
{
    returnpowerup = self.powerup;
    
    if ( isdefined( self.powerup ) )
    {
        self notify( #"powerup_dropped" );
        self.powerup notify( #"stop_randomize" );
        
        if ( isdefined( self.powerup.fx_red ) )
        {
            self.powerup.fx_red util::delay( 0.1, undefined, &zm_utility::self_delete );
            self.powerup.fx_red = undefined;
        }
        
        self.powerup.claimed = 0;
        level notify( #"powerup_dropped", self.powerup );
        origin = self.origin;
        
        if ( isdefined( self.is_traversing ) && self.is_traversing )
        {
            origin = zm_utility::groundpos( self.origin + ( 0, 0, 10 ) );
        }
        
        origin += ( 0, 0, 40 );
        self.powerup unlink();
        self.powerup.origin = origin;
        self.powerup thread zm_powerups::powerup_timeout();
        self.powerup thread zm_powerups::powerup_wobble();
        self.powerup thread zm_powerups::powerup_grab();
        self.powerup = undefined;
    }
    
    return returnpowerup;
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x22cbe561, Offset: 0x3cf8
// Size: 0xcc
function _monkey_remove( playfx )
{
    self notify( #"remove" );
    
    if ( !isdefined( playfx ) )
    {
        playfx = 1;
    }
    
    if ( isdefined( self.powerup ) )
    {
        if ( isdefined( self.powerup.fx_red ) )
        {
            self.powerup.fx_red delete();
            self.powerup.fx_red = undefined;
        }
        
        self.powerup zm_powerups::powerup_delete();
    }
    
    self thread zombie_utility::zombie_eye_glow_stop();
    self delete();
}

// Namespace zm_temple_ai_monkey
// Params 2
// Checksum 0xd688fa7f, Offset: 0x3dd0
// Size: 0x1be
function _getconnectedzonenames( zonename, params )
{
    if ( !isdefined( params.tested ) )
    {
        params.tested = [];
    }
    
    ret = [];
    
    if ( !isdefined( params.tested[ zonename ] ) )
    {
        ret[ 0 ] = zonename;
        params.tested[ zonename ] = 1;
        zone = level.zones[ zonename ];
        azkeys = getarraykeys( zone.adjacent_zones );
        
        for ( i = 0; i < azkeys.size ; i++ )
        {
            name = azkeys[ i ];
            adjzone = zone.adjacent_zones[ name ];
            globalzone = level.zones[ name ];
            
            if ( adjzone.is_connected && globalzone.is_enabled )
            {
                zonenames = _getconnectedzonenames( name, params );
                ret = arraycombine( ret, zonenames, 0, 0 );
            }
        }
    }
    
    return ret;
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x4be5ae30, Offset: 0x3f98
// Size: 0x312
function _powerup_randomize( monkey )
{
    self endon( #"stop_randomize" );
    monkey endon( #"remove" );
    powerup_cycle = array( "carpenter", "fire_sale", "nuke", "double_points", "insta_kill" );
    powerup_cycle = array_randomize_knuth( powerup_cycle );
    powerup_cycle[ powerup_cycle.size ] = "full_ammo";
    
    if ( level.chest_moves < 1 )
    {
        arrayremovevalue( powerup_cycle, "fire_sale" );
    }
    
    if ( level.round_number <= 1 )
    {
        arrayremovevalue( powerup_cycle, "nuke" );
    }
    
    currentpowerup = undefined;
    keys = getarraykeys( level.zombie_powerups );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        if ( level.zombie_powerups[ keys[ i ] ].model_name == self.model )
        {
            currentpowerup = keys[ i ];
            break;
        }
    }
    
    if ( isdefined( currentpowerup ) )
    {
        arrayremovevalue( powerup_cycle, currentpowerup );
        arrayinsert( powerup_cycle, currentpowerup, 0 );
    }
    
    if ( currentpowerup == "full_ammo" && self.grab_count == 1 )
    {
        index = randomintrange( 1, powerup_cycle.size - 1 );
        arrayinsert( powerup_cycle, "free_perk", index );
    }
    
    wait 1;
    index = 1;
    
    while ( true )
    {
        powerupname = powerup_cycle[ index ];
        index++;
        
        if ( index >= powerup_cycle.size )
        {
            index = 0;
        }
        
        self zm_powerups::powerup_setup( powerupname, undefined, undefined, undefined, 0 );
        self playsound( "zmb_temple_powerup_switch" );
        monkey _monkey_bindpowerup( self );
        
        if ( powerupname == "free_perk" )
        {
            wait 0.25;
            continue;
        }
        
        wait 1;
    }
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x74814c20, Offset: 0x42b8
// Size: 0xa6
function array_randomize_knuth( array )
{
    n = array.size;
    
    while ( n > 0 )
    {
        index = randomint( n );
        n -= 1;
        temp = array[ index ];
        array[ index ] = array[ n ];
        array[ n ] = temp;
    }
    
    return array;
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x549d06dc, Offset: 0x4368
// Size: 0xa4
function _monkey_bindpowerup( powerup )
{
    powerup unlink();
    powerup.angles = self.angles;
    powerup.origin = self.origin;
    offset = ( 0, 0, 40 );
    angles = ( 0, 0, 0 );
    powerup linkto( self, "tag_origin", offset, angles );
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x6e8d74e3, Offset: 0x4418
// Size: 0x4c
function _monkey_gib()
{
    playfx( level._effect[ "monkey_gib_no_gore" ], self.origin );
    self ghost();
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x8a6cce18, Offset: 0x4470
// Size: 0x44
function _monkey_templefling( player )
{
    self.do_gib_death = 1;
    self dodamage( self.health + 666, self.origin, player );
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x2ba3ab1f, Offset: 0x44c0
// Size: 0x154
function _monkey_templesliding( slide_node )
{
    self endon( #"death" );
    level endon( #"intermission" );
    
    if ( isdefined( self.sliding ) && self.sliding )
    {
        return;
    }
    
    self notify( #"end_monkey_steal" );
    self.is_traversing = 1;
    self notify( #"zombie_start_traverse" );
    self.sliding = 1;
    self.ignoreall = 1;
    self thread set_monkey_slide_anim();
    self setgoalnode( slide_node );
    check_dist_squared = 3600;
    
    while ( distancesquared( self.origin, slide_node.origin ) > check_dist_squared )
    {
        wait 0.01;
    }
    
    self thread monkey_zombie_choose_sprint_temple();
    self notify( #"water_slide_exit" );
    self.sliding = 0;
    self.is_traversing = 0;
    self notify( #"zombie_end_traverse" );
    self thread _monkey_stealpowerup();
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xbd9d26, Offset: 0x4620
// Size: 0x24
function set_monkey_slide_anim()
{
    self zombie_utility::set_zombie_run_cycle( "sprint_slide" );
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x99ec1590, Offset: 0x4650
// Size: 0x4
function precache_ambient_monkey_anims()
{
    
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x4b8af38a, Offset: 0x4660
// Size: 0xa4
function monkey_ambient_init()
{
    level flag::init( "monkey_ambient_excited" );
    monkey_ambient_level_set_next_sound();
    level.ambient_monkey_locations = struct::get_array( "monkey_ambient", "targetname" );
    level thread monkey_crowd_noise();
    level thread monkey_ambient_drops_add_array();
    level thread manage_ambient_monkeys( 4 );
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x14e98d43, Offset: 0x4710
// Size: 0x140
function monkey_crowd_noise()
{
    origin1 = getent( "evt_monkey_crowd01_origin", "targetname" );
    origin2 = getent( "evt_monkey_crowd02_origin", "targetname" );
    
    if ( !isdefined( origin1 ) || !isdefined( origin2 ) )
    {
        return;
    }
    
    while ( true )
    {
        level flag::wait_till( "monkey_ambient_excited" );
        origin1 playloopsound( "evt_monkey_crowd01", 2 );
        origin2 playloopsound( "evt_monkey_crowd02", 2 );
        
        while ( level flag::get( "monkey_ambient_excited" ) )
        {
            wait 0.1;
        }
        
        origin1 stoploopsound( 3 );
        origin2 stoploopsound( 3 );
    }
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0xfb7e8522, Offset: 0x4858
// Size: 0x1c0
function manage_ambient_monkeys( max_monkeys )
{
    checkzone = "temple_start_zone";
    level.active_monkeys = [];
    playerinzone = 0;
    hacktofixstart = 1;
    
    while ( true )
    {
        if ( !hacktofixstart )
        {
            util::wait_network_frame();
        }
        
        if ( zone_is_active( checkzone ) || hacktofixstart )
        {
            if ( level.active_monkeys.size == 0 && !playerinzone )
            {
                level.ambient_monkey_locations = array_randomize_knuth( level.ambient_monkey_locations );
                
                if ( level.ambient_monkey_locations.size > 0 )
                {
                    for ( i = 0; i < max_monkeys ; i++ )
                    {
                        level.ambient_monkey_locations[ i ] monkey_ambient_spawn();
                        
                        if ( !hacktofixstart )
                        {
                            util::wait_network_frame();
                        }
                        
                        util::wait_network_frame();
                    }
                }
            }
            
            if ( hacktofixstart )
            {
                while ( !zone_is_active( checkzone ) )
                {
                    wait 0.1;
                }
            }
            
            hacktofixstart = 0;
            playerinzone = 1;
            continue;
        }
        
        playerinzone = 0;
        array::remove_undefined( level.active_monkeys );
    }
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0xa3957ff8, Offset: 0x4a20
// Size: 0x54, Type: bool
function zone_is_active( zone_name )
{
    if ( !isdefined( level.zones ) || !isdefined( level.zones[ zone_name ] ) || !level.zones[ zone_name ].is_active )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xc16be99d, Offset: 0x4a80
// Size: 0x23c
function monkey_ambient_spawn()
{
    self.monkey = util::spawn_model( "c_zom_dlchd_shangrila_monkey", self.origin, self.angles );
    self.monkey.animname = "monkey";
    self.monkey setcandamage( 1 );
    self.monkey.v_starting_origin = self.origin;
    self.monkey.var_2e8d47d3 = self.angles;
    self.health = 9999;
    zm_weap_shrink_ray::add_shrinkable_object( self.monkey );
    self.monkey.location = self;
    self.monkey.anim_spot = util::spawn_model( "tag_origin", self.origin, self.angles );
    
    if ( !isdefined( level.active_monkeys ) )
    {
        level.active_monkeys = [];
    }
    else if ( !isarray( level.active_monkeys ) )
    {
        level.active_monkeys = array( level.active_monkeys );
    }
    
    level.active_monkeys[ level.active_monkeys.size ] = self.monkey;
    self.monkey monkey_ambient_set_next_sound();
    self.monkey thread monkey_ambient_noise();
    self.monkey thread monkey_ambient_watch_for_power_up();
    self.monkey thread monkey_ambient_wait_to_be_shot();
    self.monkey thread monkey_ambient_idle();
    self.monkey thread monkey_ambient_shrink();
    self.monkey clientfield::set( "monkey_ragdoll", 1 );
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x9bec44d0, Offset: 0x4cc8
// Size: 0xb4
function monkey_ambient_idle()
{
    self endon( #"monkey_killed" );
    self endon( #"monkey_cleanup" );
    level flag::wait_till( "zm_temple_connected" );
    self.anim_spot notify( #"monkey_stop_loop" );
    self useanimtree( $critter );
    self animation::stop( 0.2 );
    self animation::play( "rtrg_ai_zm_dlc5_monkey_calm_idle_loop_03", self.v_starting_origin, self.var_2e8d47d3 );
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xa93299e7, Offset: 0x4d88
// Size: 0xf4
function monkey_ambient_wait_to_be_shot()
{
    self endon( #"monkey_cleanup" );
    self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags );
    self.alive = 0;
    self notify( #"monkey_killed" );
    playsoundatposition( "zmb_stealer_death", self.origin );
    self animation::stop();
    self startragdoll();
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x24c39bbe, Offset: 0x4e88
// Size: 0x20
function monkey_ambient_wait_for_remove()
{
    self endon( #"monkey_cleanup" );
    self endon( #"monkey_killed" );
    wait 10;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xbcbdf10f, Offset: 0x4eb0
// Size: 0xd0
function monkey_ambient_drops_add_array()
{
    self endon( #"monkey_cleanup" );
    self endon( #"monkey_killed" );
    
    while ( true )
    {
        level waittill( #"powerup_dropped", powerup );
        level flag::set( "monkey_ambient_excited" );
        
        do
        {
            wait 0.3;
            level.monkey_drops = zm_powerups::get_powerups();
            level.monkey_drops = array::remove_undefined( level.monkey_drops );
        }
        while ( level.monkey_drops.size != 0 );
        
        level flag::clear( "monkey_ambient_excited" );
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x17f02a14, Offset: 0x4f88
// Size: 0x368
function monkey_ambient_watch_for_power_up()
{
    self endon( #"monkey_killed" );
    self endon( #"monkey_cleanup" );
    
    if ( !isdefined( self.var_188503aa ) )
    {
        self.var_188503aa = [];
        
        if ( !isdefined( self.var_188503aa ) )
        {
            self.var_188503aa = [];
        }
        else if ( !isarray( self.var_188503aa ) )
        {
            self.var_188503aa = array( self.var_188503aa );
        }
        
        self.var_188503aa[ self.var_188503aa.size ] = "rtrg_ai_zm_dlc5_monkey_freaked_01";
        
        if ( !isdefined( self.var_188503aa ) )
        {
            self.var_188503aa = [];
        }
        else if ( !isarray( self.var_188503aa ) )
        {
            self.var_188503aa = array( self.var_188503aa );
        }
        
        self.var_188503aa[ self.var_188503aa.size ] = "rtrg_ai_zm_dlc5_monkey_freaked_01a";
        
        if ( !isdefined( self.var_188503aa ) )
        {
            self.var_188503aa = [];
        }
        else if ( !isarray( self.var_188503aa ) )
        {
            self.var_188503aa = array( self.var_188503aa );
        }
        
        self.var_188503aa[ self.var_188503aa.size ] = "rtrg_ai_zm_dlc5_monkey_freaked_01b";
        
        if ( !isdefined( self.var_188503aa ) )
        {
            self.var_188503aa = [];
        }
        else if ( !isarray( self.var_188503aa ) )
        {
            self.var_188503aa = array( self.var_188503aa );
        }
        
        self.var_188503aa[ self.var_188503aa.size ] = "rtrg_ai_zm_dlc5_monkey_freaked_01c";
    }
    
    while ( true )
    {
        self.var_188503aa = array::randomize( self.var_188503aa );
        level flag::wait_till( "monkey_ambient_excited" );
        wait randomfloatrange( 0, 1 );
        self.excited = 1;
        self thread monkey_ambient_excited_noise();
        self.anim_spot notify( #"monkey_stop_loop" );
        
        for ( n_index = 0; true ; n_index = 0 )
        {
            self animation::stop( 0.2 );
            self animation::play( self.var_188503aa[ n_index ], self.v_starting_origin, self.var_2e8d47d3 );
            
            if ( !level flag::get( "monkey_ambient_excited" ) )
            {
                break;
            }
            
            if ( n_index < self.var_188503aa.size - 2 )
            {
                n_index++;
                continue;
            }
        }
        
        self.excited = 0;
        self thread monkey_ambient_idle();
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x5aaa6460, Offset: 0x52f8
// Size: 0x34
function monkey_ambient_level_set_next_sound()
{
    level.ambient_monkey_next_sound_time = gettime() + randomfloatrange( 3, 6 ) * 1000;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x4c53a161, Offset: 0x5338
// Size: 0x34
function monkey_ambient_set_next_sound()
{
    self.next_sound_time = gettime() + randomfloatrange( 6, 12 ) * 1000;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xae7cae88, Offset: 0x5378
// Size: 0x30, Type: bool
function monkey_ambient_can_make_sound()
{
    if ( gettime() < level.ambient_monkey_next_sound_time )
    {
        return false;
    }
    
    if ( gettime() < self.next_sound_time )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x2111173f, Offset: 0x53b0
// Size: 0x88
function monkey_ambient_noise()
{
    self endon( #"monkey_killed" );
    self endon( #"monkey_cleanup" );
    
    while ( true )
    {
        if ( self monkey_ambient_can_make_sound() )
        {
            self thread monkey_ambient_play_sound( "zmb_stealer_ambient" );
            self monkey_ambient_set_next_sound();
            monkey_ambient_level_set_next_sound();
        }
        
        wait 0.1;
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x623475eb, Offset: 0x5440
// Size: 0x68
function monkey_ambient_excited_noise()
{
    self endon( #"monkey_killed" );
    self endon( #"monkey_cleanup" );
    
    while ( self.excited )
    {
        self thread monkey_ambient_play_sound( "zmb_stealer_excited" );
        wait randomfloatrange( 1.5, 3 );
    }
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x38765847, Offset: 0x54b0
// Size: 0x78
function monkey_ambient_play_sound( soundname )
{
    while ( isdefined( level.monkey_ambient_sound_choke ) && level.monkey_ambient_sound_choke )
    {
        util::wait_network_frame();
    }
    
    level.monkey_ambient_sound_choke = 1;
    self playsound( soundname );
    util::wait_network_frame();
    level.monkey_ambient_sound_choke = 0;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xf07cb6dc, Offset: 0x5530
// Size: 0x84
function monkey_ambient_shrink()
{
    waitstr = self util::waittill_any_return( "shrunk", "death", "monkey_killed", "monkey_cleanup" );
    zm_weap_shrink_ray::remove_shrinkable_object( self );
    
    if ( waitstr == "shrunk" )
    {
        self thread _monkey_gib();
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xd16a3d68, Offset: 0x55c0
// Size: 0x66
function monkey_ambient_gib_all()
{
    for ( i = level.active_monkeys.size - 1; i >= 0 ; i-- )
    {
        monkey = level.active_monkeys[ i ];
        monkey thread _monkey_gib();
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x3cf77c40, Offset: 0x5630
// Size: 0x1a0
function _monkey_zombie_grenade_watcher()
{
    self endon( #"death" );
    grenade_respond_dist_sq = 14400;
    
    while ( true )
    {
        if ( isdefined( self.monkey_grenade ) && self.monkey_grenade )
        {
            util::wait_network_frame();
            continue;
        }
        
        if ( isdefined( level.monkey_grenades ) && level.monkey_grenades.size > 0 )
        {
            for ( i = 0; i < level.monkey_grenades.size ; i++ )
            {
                grenade = level.monkey_grenades[ i ];
                
                if ( !isdefined( grenade ) || isdefined( grenade.monkey ) )
                {
                    util::wait_network_frame();
                    continue;
                }
                
                if ( isdefined( self.powerup ) )
                {
                    util::wait_network_frame();
                    continue;
                }
                
                grenade_dist_sq = distancesquared( self.origin, grenade.origin );
                
                if ( grenade_dist_sq <= grenade_respond_dist_sq )
                {
                    grenade.monkey = self;
                    self.monkey_grenade = grenade;
                    self monkey_zombie_grenade_response();
                    break;
                }
            }
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xd652b634, Offset: 0x57d8
// Size: 0x44
function monkey_zombie_grenade_response()
{
    self endon( #"death" );
    self notify( #"end_monkey_steal" );
    self monkey_zombie_grenade_pickup();
    self thread _monkey_stealpowerup();
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xe7c9d3c4, Offset: 0x5828
// Size: 0x228
function monkey_zombie_grenade_pickup()
{
    self endon( #"death" );
    pickup_dist_sq = 1024;
    picked_up = 0;
    
    while ( isdefined( self.monkey_grenade ) )
    {
        self setgoalpos( self.monkey_grenade.origin );
        grenade_dist_sq = distancesquared( self.origin, self.monkey_grenade.origin );
        
        if ( grenade_dist_sq <= pickup_dist_sq )
        {
            self.monkey_thrower = self.monkey_grenade.thrower;
            self.monkey_grenade delete();
            self.monkey_grenade = undefined;
            picked_up = 1;
        }
        
        util::wait_network_frame();
    }
    
    if ( picked_up )
    {
        while ( true )
        {
            self setgoalpos( self.monkey_thrower.origin );
            target_dir = self.monkey_thrower.origin - self.origin;
            monkey_dir = anglestoforward( self.angles );
            dot = vectordot( vectornormalize( target_dir ), vectornormalize( monkey_dir ) );
            
            if ( dot >= 0.5 )
            {
                break;
            }
            
            util::wait_network_frame();
        }
        
        self thread monkey_zombie_grenade_throw( self.monkey_thrower );
        self waittill( #"throw_done" );
    }
}

// Namespace zm_temple_ai_monkey
// Params 2
// Checksum 0x5f4c4640, Offset: 0x5a58
// Size: 0x184
function monkey_zombie_grenade_throw_watcher( target, animname )
{
    self endon( #"death" );
    self waittillmatch( animname, "grenade_throw" );
    throw_angle = randomintrange( 20, 30 );
    dir = vectortoangles( target.origin - self.origin );
    dir = ( dir[ 0 ] - throw_angle, dir[ 1 ], dir[ 2 ] );
    dir = anglestoforward( dir );
    velocity = dir * 550;
    fuse = randomfloatrange( 1, 2 );
    hand_pos = self gettagorigin( "J_Thumb_RI_1" );
    grenade_type = target zm_utility::get_player_lethal_grenade();
    self magicgrenadetype( grenade_type, hand_pos, velocity, fuse );
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x5254a107, Offset: 0x5be8
// Size: 0x1a
function monkey_zombie_grenade_throw( target )
{
    self notify( #"throw_done" );
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0x732bdb57, Offset: 0x5c10
// Size: 0x128
function monkey_attack_player()
{
    self endon( #"death" );
    self.attack_player = 1;
    self.attacking_player = 1;
    players = getplayers();
    self.ignore_player = [];
    player = undefined;
    
    if ( isdefined( self.player_stole_power_up ) && zombie_utility::is_player_valid( self.player_stole_power_up ) )
    {
        player = self.player_stole_power_up;
    }
    
    if ( isdefined( player ) )
    {
        self.favoriteenemy = player;
        self thread monkey_obvious_vox();
        self _monkey_add_time();
        self thread monkey_pathing();
        self thread monkey_attack_player_wait_wrapper( self.favoriteenemy );
        self waittill( #"end_monkey_attacks" );
    }
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0xcf93ebe0, Offset: 0x5d40
// Size: 0x3c
function monkey_attack_player_wait_wrapper( player )
{
    self monkey_attack_player_wait( player );
    self monkey_stop_attck_player();
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0xcd0124a7, Offset: 0x5d88
// Size: 0x90
function monkey_attack_player_wait( player )
{
    self endon( #"death" );
    self endon( #"end_monkey_steal" );
    attacktimeend = gettime() + 20000;
    
    while ( attacktimeend > gettime() )
    {
        if ( !zombie_utility::is_player_valid( player ) )
        {
            break;
        }
        
        if ( isdefined( self.melee_count ) && self.melee_count >= 1 )
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xddce5699, Offset: 0x5e20
// Size: 0x48
function monkey_stop_attck_player()
{
    self notify( #"end_monkey_attacks" );
    self.ignoreall = 1;
    
    if ( isalive( self ) )
    {
        self.favoriteenemy = undefined;
        self.attacking_player = 0;
    }
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xbea096fc, Offset: 0x5e70
// Size: 0xa0
function monkey_pathing()
{
    self endon( #"death" );
    self endon( #"end_monkey_attacks" );
    self.ignoreall = 0;
    self.meleeattackdist = 64;
    
    while ( isdefined( self.favoriteenemy ) )
    {
        self.goalradius = 32;
        self orientmode( "face default" );
        self setgoalpos( self.favoriteenemy.origin );
        util::wait_network_frame();
    }
}

// Namespace zm_temple_ai_monkey
// Params 1
// Checksum 0x9b540e7b, Offset: 0x5f18
// Size: 0xc8
function monkey_temple_custom_damage( player )
{
    self endon( #"death" );
    damage = self.meleedamage;
    
    if ( !isdefined( self.melee_count ) )
    {
        self.melee_count = 0;
    }
    
    self.melee_count++;
    
    if ( isdefined( player ) && player.score > 0 )
    {
        pointstosteal = int( min( player.score, 50 ) );
        player zm_score::minus_to_player_score( pointstosteal );
    }
    
    return damage;
}

// Namespace zm_temple_ai_monkey
// Params 0
// Checksum 0xd071502c, Offset: 0x5fe8
// Size: 0x58
function monkey_obvious_vox()
{
    self endon( #"death" );
    self endon( #"end_monkey_attacks" );
    
    while ( true )
    {
        self playsound( "zmb_stealer_attack" );
        wait randomfloatrange( 2, 4 );
    }
}

