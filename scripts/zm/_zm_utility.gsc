#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_faller;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_server_throttle;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_weapons;

#namespace zm_utility;

// Namespace zm_utility
// Params 0
// Checksum 0x99ec1590, Offset: 0xb00
// Size: 0x4
function init_utility()
{
    
}

// Namespace zm_utility
// Params 0
// Checksum 0xb4dd97d6, Offset: 0xb10
// Size: 0x8, Type: bool
function is_classic()
{
    return true;
}

// Namespace zm_utility
// Params 0
// Checksum 0xdee46e0a, Offset: 0xb20
// Size: 0x40, Type: bool
function is_standard()
{
    dvar = getdvarstring( "ui_gametype" );
    
    if ( dvar == "zstandard" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_utility
// Params 1
// Checksum 0xf3ba1460, Offset: 0xb68
// Size: 0x16
function convertsecondstomilliseconds( seconds )
{
    return seconds * 1000;
}

// Namespace zm_utility
// Params 0
// Checksum 0xf551cb3c, Offset: 0xb88
// Size: 0x54, Type: bool
function is_player()
{
    return isdefined( self.pers[ "isBot" ] ) && isdefined( self.pers ) && ( isplayer( self ) || self.pers[ "isBot" ] );
}

// Namespace zm_utility
// Params 1
// Checksum 0x177403b2, Offset: 0xbe8
// Size: 0x12c
function lerp( chunk )
{
    link = spawn( "script_origin", self getorigin() );
    link.angles = self.first_node.angles;
    self linkto( link );
    link rotateto( self.first_node.angles, level._contextual_grab_lerp_time );
    link moveto( self.attacking_spot, level._contextual_grab_lerp_time );
    link util::waittill_multiple( "rotatedone", "movedone" );
    self unlink();
    link delete();
}

// Namespace zm_utility
// Params 0
// Checksum 0x99ec1590, Offset: 0xd20
// Size: 0x4
function recalc_zombie_array()
{
    
}

// Namespace zm_utility
// Params 0
// Checksum 0xb4e118de, Offset: 0xd30
// Size: 0x19c
function init_zombie_run_cycle()
{
    if ( isdefined( level.speed_change_round ) )
    {
        if ( level.round_number >= level.speed_change_round )
        {
            speed_percent = 0.2 + ( level.round_number - level.speed_change_round ) * 0.2;
            speed_percent = min( speed_percent, 1 );
            change_round_max = int( level.speed_change_max * speed_percent );
            change_left = change_round_max - level.speed_change_num;
            
            if ( change_left == 0 )
            {
                self zombie_utility::set_zombie_run_cycle();
                return;
            }
            
            change_speed = randomint( 100 );
            
            if ( change_speed > 80 )
            {
                self change_zombie_run_cycle();
                return;
            }
            
            zombie_count = zombie_utility::get_current_zombie_count();
            zombie_left = level.zombie_ai_limit - zombie_count;
            
            if ( zombie_left == change_left )
            {
                self change_zombie_run_cycle();
                return;
            }
        }
    }
    
    self zombie_utility::set_zombie_run_cycle();
}

// Namespace zm_utility
// Params 0
// Checksum 0x453c16bf, Offset: 0xed8
// Size: 0x6c
function change_zombie_run_cycle()
{
    level.speed_change_num++;
    
    if ( level.gamedifficulty == 0 )
    {
        self zombie_utility::set_zombie_run_cycle( "sprint" );
    }
    else
    {
        self zombie_utility::set_zombie_run_cycle( "walk" );
    }
    
    self thread speed_change_watcher();
}

// Namespace zm_utility
// Params 0
// Checksum 0x16bd6a47, Offset: 0xf50
// Size: 0x24
function make_supersprinter()
{
    self zombie_utility::set_zombie_run_cycle( "super_sprint" );
}

// Namespace zm_utility
// Params 0
// Checksum 0xfd14a7b8, Offset: 0xf80
// Size: 0x28
function speed_change_watcher()
{
    self waittill( #"death" );
    
    if ( level.speed_change_num > 0 )
    {
        level.speed_change_num--;
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x7e41aae6, Offset: 0xfb0
// Size: 0x53c
function move_zombie_spawn_location( spot )
{
    self endon( #"death" );
    
    if ( isdefined( self.spawn_pos ) )
    {
        self notify( #"risen", self.spawn_pos.script_string );
        return;
    }
    
    self.spawn_pos = spot;
    
    if ( isdefined( spot.target ) )
    {
        self.target = spot.target;
    }
    
    if ( isdefined( spot.zone_name ) )
    {
        self.zone_name = spot.zone_name;
        self.previous_zone_name = spot.zone_name;
    }
    
    if ( isdefined( spot.script_parameters ) )
    {
        self.script_parameters = spot.script_parameters;
    }
    
    if ( !isdefined( spot.script_noteworthy ) )
    {
        spot.script_noteworthy = "spawn_location";
    }
    
    tokens = strtok( spot.script_noteworthy, " " );
    
    foreach ( index, token in tokens )
    {
        if ( isdefined( self.spawn_point_override ) )
        {
            spot = self.spawn_point_override;
            token = spot.script_noteworthy;
        }
        
        if ( token == "custom_spawner_entry" )
        {
            next_token = index + 1;
            
            if ( isdefined( tokens[ next_token ] ) )
            {
                str_spawn_entry = tokens[ next_token ];
                
                if ( isdefined( level.custom_spawner_entry ) && isdefined( level.custom_spawner_entry[ str_spawn_entry ] ) )
                {
                    self thread [[ level.custom_spawner_entry[ str_spawn_entry ] ]]( spot );
                    continue;
                }
            }
        }
        
        if ( token == "riser_location" )
        {
            self thread zm_spawner::do_zombie_rise( spot );
            continue;
        }
        
        if ( token == "faller_location" )
        {
            self thread zm_ai_faller::do_zombie_fall( spot );
            continue;
        }
        
        if ( token == "spawn_location" )
        {
            if ( isdefined( self.anchor ) )
            {
                return;
            }
            
            self.anchor = spawn( "script_origin", self.origin );
            self.anchor.angles = self.angles;
            self linkto( self.anchor );
            self.anchor thread anchor_delete_failsafe( self );
            
            if ( !isdefined( spot.angles ) )
            {
                spot.angles = ( 0, 0, 0 );
            }
            
            self ghost();
            self.anchor moveto( spot.origin, 0.05 );
            self.anchor waittill( #"movedone" );
            target_org = zombie_utility::get_desired_origin();
            
            if ( isdefined( target_org ) )
            {
                anim_ang = vectortoangles( target_org - self.origin );
                self.anchor rotateto( ( 0, anim_ang[ 1 ], 0 ), 0.05 );
                self.anchor waittill( #"rotatedone" );
            }
            
            if ( isdefined( level.zombie_spawn_fx ) )
            {
                playfx( level.zombie_spawn_fx, spot.origin );
            }
            
            self unlink();
            
            if ( isdefined( self.anchor ) )
            {
                self.anchor delete();
            }
            
            if ( !( isdefined( self.dontshow ) && self.dontshow ) )
            {
                self show();
            }
            
            self notify( #"risen", spot.script_string );
        }
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x553c20b3, Offset: 0x14f8
// Size: 0x44
function anchor_delete_failsafe( ai_zombie )
{
    ai_zombie endon( #"risen" );
    ai_zombie waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0x714e261c, Offset: 0x1548
// Size: 0x1a6
function run_spawn_functions()
{
    self endon( #"death" );
    waittillframeend();
    
    for ( i = 0; i < level.spawn_funcs[ self.team ].size ; i++ )
    {
        func = level.spawn_funcs[ self.team ][ i ];
        util::single_thread( self, func[ "function" ], func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ], func[ "param5" ] );
    }
    
    if ( isdefined( self.spawn_funcs ) )
    {
        for ( i = 0; i < self.spawn_funcs.size ; i++ )
        {
            func = self.spawn_funcs[ i ];
            util::single_thread( self, func[ "function" ], func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ] );
        }
        
        /#
            self.saved_spawn_functions = self.spawn_funcs;
        #/
        
        self.spawn_funcs = undefined;
        
        /#
            self.spawn_funcs = self.saved_spawn_functions;
            self.saved_spawn_functions = undefined;
        #/
        
        self.spawn_funcs = undefined;
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0x761decaf, Offset: 0x16f8
// Size: 0xdc
function create_simple_hud( client, team )
{
    if ( isdefined( team ) )
    {
        hud = newteamhudelem( team );
        hud.team = team;
    }
    else if ( isdefined( client ) )
    {
        hud = newclienthudelem( client );
    }
    else
    {
        hud = newhudelem();
    }
    
    level.hudelem_count++;
    hud.foreground = 1;
    hud.sort = 1;
    hud.hidewheninmenu = 0;
    return hud;
}

// Namespace zm_utility
// Params 0
// Checksum 0xc427f137, Offset: 0x17e0
// Size: 0x24
function destroy_hud()
{
    level.hudelem_count--;
    self destroy();
}

// Namespace zm_utility
// Params 2
// Checksum 0xffa3d479, Offset: 0x1810
// Size: 0xe2, Type: bool
function all_chunks_intact( barrier, barrier_chunks )
{
    if ( isdefined( barrier.zbarrier ) )
    {
        pieces = barrier.zbarrier getzbarrierpieceindicesinstate( "closed" );
        
        if ( pieces.size != barrier.zbarrier getnumzbarrierpieces() )
        {
            return false;
        }
    }
    else
    {
        for ( i = 0; i < barrier_chunks.size ; i++ )
        {
            if ( barrier_chunks[ i ] get_chunk_state() != "repaired" )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace zm_utility
// Params 2
// Checksum 0xf8ae108f, Offset: 0x1900
// Size: 0xc2, Type: bool
function no_valid_repairable_boards( barrier, barrier_chunks )
{
    if ( isdefined( barrier.zbarrier ) )
    {
        pieces = barrier.zbarrier getzbarrierpieceindicesinstate( "open" );
        
        if ( pieces.size )
        {
            return false;
        }
    }
    else
    {
        for ( i = 0; i < barrier_chunks.size ; i++ )
        {
            if ( barrier_chunks[ i ] get_chunk_state() == "destroyed" )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace zm_utility
// Params 0
// Checksum 0x241752a8, Offset: 0x19d0
// Size: 0x6, Type: bool
function is_survival()
{
    return false;
}

// Namespace zm_utility
// Params 0
// Checksum 0xdd378116, Offset: 0x19e0
// Size: 0x6, Type: bool
function is_encounter()
{
    return false;
}

// Namespace zm_utility
// Params 2
// Checksum 0x4875fb61, Offset: 0x19f0
// Size: 0x14a, Type: bool
function all_chunks_destroyed( barrier, barrier_chunks )
{
    if ( isdefined( barrier.zbarrier ) )
    {
        pieces = arraycombine( barrier.zbarrier getzbarrierpieceindicesinstate( "open" ), barrier.zbarrier getzbarrierpieceindicesinstate( "opening" ), 1, 0 );
        
        if ( pieces.size != barrier.zbarrier getnumzbarrierpieces() )
        {
            return false;
        }
    }
    else if ( isdefined( barrier_chunks ) )
    {
        assert( isdefined( barrier_chunks ), "<dev string:x28>" );
        
        for ( i = 0; i < barrier_chunks.size ; i++ )
        {
            if ( barrier_chunks[ i ] get_chunk_state() != "destroyed" )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace zm_utility
// Params 1
// Checksum 0xed174e11, Offset: 0x1b48
// Size: 0x10e
function check_point_in_playable_area( origin )
{
    playable_area = getentarray( "player_volume", "script_noteworthy" );
    
    if ( !isdefined( level.check_model ) )
    {
        level.check_model = spawn( "script_model", origin + ( 0, 0, 40 ) );
    }
    else
    {
        level.check_model.origin = origin + ( 0, 0, 40 );
    }
    
    valid_point = 0;
    
    for ( i = 0; i < playable_area.size ; i++ )
    {
        if ( level.check_model istouching( playable_area[ i ] ) )
        {
            valid_point = 1;
        }
    }
    
    return valid_point;
}

// Namespace zm_utility
// Params 3
// Checksum 0xf97a89eb, Offset: 0x1c60
// Size: 0x1e0
function check_point_in_enabled_zone( origin, zone_is_active, player_zones )
{
    if ( !isdefined( player_zones ) )
    {
        player_zones = getentarray( "player_volume", "script_noteworthy" );
    }
    
    if ( !isdefined( level.zones ) || !isdefined( player_zones ) )
    {
        return 1;
    }
    
    if ( !isdefined( level.e_check_point ) )
    {
        level.e_check_point = spawn( "script_origin", origin + ( 0, 0, 40 ) );
    }
    else
    {
        level.e_check_point.origin = origin + ( 0, 0, 40 );
    }
    
    one_valid_zone = 0;
    
    for ( i = 0; i < player_zones.size ; i++ )
    {
        if ( level.e_check_point istouching( player_zones[ i ] ) )
        {
            zone = level.zones[ player_zones[ i ].targetname ];
            
            if ( isdefined( zone.is_enabled ) && isdefined( zone ) && zone.is_enabled )
            {
                if ( isdefined( zone_is_active ) && zone_is_active == 1 && !( isdefined( zone.is_active ) && zone.is_active ) )
                {
                    continue;
                }
                
                one_valid_zone = 1;
                break;
            }
        }
    }
    
    return one_valid_zone;
}

// Namespace zm_utility
// Params 1
// Checksum 0x9049a9ce, Offset: 0x1e48
// Size: 0x4c
function round_up_to_ten( score )
{
    new_score = score - score % 10;
    
    if ( new_score < score )
    {
        new_score += 10;
    }
    
    return new_score;
}

// Namespace zm_utility
// Params 2
// Checksum 0xeee93fd0, Offset: 0x1ea0
// Size: 0x70
function round_up_score( score, value )
{
    score = int( score );
    new_score = score - score % value;
    
    if ( new_score < score )
    {
        new_score += value;
    }
    
    return new_score;
}

// Namespace zm_utility
// Params 1
// Checksum 0xd3c43031, Offset: 0x1f18
// Size: 0x3c
function halve_score( n_score )
{
    n_score /= 2;
    n_score = round_up_score( n_score, 10 );
    return n_score;
}

// Namespace zm_utility
// Params 0
// Checksum 0x3454e594, Offset: 0x1f60
// Size: 0x56
function random_tan()
{
    rand = randomint( 100 );
    
    if ( isdefined( level.char_percent_override ) )
    {
        percentnotcharred = level.char_percent_override;
        return;
    }
    
    percentnotcharred = 65;
}

// Namespace zm_utility
// Params 1
// Checksum 0x4101ed4c, Offset: 0x1fc0
// Size: 0x82
function places_before_decimal( num )
{
    abs_num = abs( num );
    count = 0;
    
    while ( true )
    {
        abs_num *= 0.1;
        count += 1;
        
        if ( abs_num < 1 )
        {
            return count;
        }
    }
}

// Namespace zm_utility
// Params 7
// Checksum 0x6d6a2e61, Offset: 0x2050
// Size: 0x1dc
function create_zombie_point_of_interest( attract_dist, num_attractors, added_poi_value, start_turned_on, initial_attract_func, arrival_attract_func, poi_team )
{
    if ( !isdefined( added_poi_value ) )
    {
        self.added_poi_value = 0;
    }
    else
    {
        self.added_poi_value = added_poi_value;
    }
    
    if ( !isdefined( start_turned_on ) )
    {
        start_turned_on = 1;
    }
    
    if ( !isdefined( attract_dist ) )
    {
        attract_dist = 1536;
    }
    
    self.script_noteworthy = "zombie_poi";
    self.poi_active = start_turned_on;
    
    if ( isdefined( attract_dist ) )
    {
        self.max_attractor_dist = attract_dist;
        self.poi_radius = attract_dist * attract_dist;
    }
    else
    {
        self.poi_radius = undefined;
    }
    
    self.num_poi_attracts = num_attractors;
    self.attract_to_origin = 1;
    self.attractor_array = [];
    self.initial_attract_func = undefined;
    self.arrival_attract_func = undefined;
    
    if ( isdefined( poi_team ) )
    {
        self._team = poi_team;
    }
    
    if ( isdefined( initial_attract_func ) )
    {
        self.initial_attract_func = initial_attract_func;
    }
    
    if ( isdefined( arrival_attract_func ) )
    {
        self.arrival_attract_func = arrival_attract_func;
    }
    
    if ( !isdefined( level.zombie_poi_array ) )
    {
        level.zombie_poi_array = [];
    }
    else if ( !isarray( level.zombie_poi_array ) )
    {
        level.zombie_poi_array = array( level.zombie_poi_array );
    }
    
    level.zombie_poi_array[ level.zombie_poi_array.size ] = self;
    self thread watch_for_poi_death();
}

// Namespace zm_utility
// Params 0
// Checksum 0x7c5f4587, Offset: 0x2238
// Size: 0x4c
function watch_for_poi_death()
{
    self waittill( #"death" );
    
    if ( isinarray( level.zombie_poi_array, self ) )
    {
        arrayremovevalue( level.zombie_poi_array, self );
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0xddc51697, Offset: 0x2290
// Size: 0x138
function debug_draw_new_attractor_positions()
{
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( attract in self.attractor_positions )
        {
            passed = bullettracepassed( attract[ 0 ] + ( 0, 0, 24 ), self.origin + ( 0, 0, 24 ), 0, self );
            
            if ( passed )
            {
                /#
                    debugstar( attract[ 0 ], 6, ( 1, 1, 1 ) );
                #/
                
                continue;
            }
            
            /#
                debugstar( attract[ 0 ], 6, ( 1, 0, 0 ) );
            #/
        }
        
        wait 0.05;
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0xb0f50c, Offset: 0x23d0
// Size: 0x2ea
function create_zombie_point_of_interest_attractor_positions( num_attract_dists, attract_dist )
{
    self endon( #"death" );
    
    if ( isdefined( self.script_noteworthy ) && ( !isdefined( self.num_poi_attracts ) || self.script_noteworthy != "zombie_poi" ) )
    {
        return;
    }
    
    if ( !isdefined( num_attract_dists ) )
    {
        num_attract_dists = 4;
    }
    
    queryresult = positionquery_source_navigation( self.origin, attract_dist / 2, self.max_attractor_dist, attract_dist / 2, attract_dist / 2, 1, attract_dist / 2 );
    
    if ( queryresult.data.size < self.num_poi_attracts )
    {
        self.num_poi_attracts = queryresult.data.size;
    }
    
    for ( i = 0; i < self.num_poi_attracts ; i++ )
    {
        if ( isdefined( level.validate_poi_attractors ) && level.validate_poi_attractors )
        {
            passed = bullettracepassed( queryresult.data[ i ].origin + ( 0, 0, 24 ), self.origin + ( 0, 0, 24 ), 0, self );
            
            if ( passed )
            {
                self.attractor_positions[ i ][ 0 ] = queryresult.data[ i ].origin;
                self.attractor_positions[ i ][ 1 ] = self;
            }
            
            continue;
        }
        
        self.attractor_positions[ i ][ 0 ] = queryresult.data[ i ].origin;
        self.attractor_positions[ i ][ 1 ] = self;
    }
    
    if ( !isdefined( self.attractor_positions ) )
    {
        self.attractor_positions = [];
    }
    
    self.num_attract_dists = num_attract_dists;
    self.last_index = [];
    
    for ( i = 0; i < num_attract_dists ; i++ )
    {
        self.last_index[ i ] = -1;
    }
    
    self.last_index[ 0 ] = 1;
    self.last_index[ 1 ] = self.attractor_positions.size;
    self.attract_to_origin = 0;
    self notify( #"attractor_positions_generated" );
    level notify( #"attractor_positions_generated" );
}

// Namespace zm_utility
// Params 4
// Checksum 0x67ecf780, Offset: 0x26c8
// Size: 0x41c
function generated_radius_attract_positions( forward, offset, num_positions, attract_radius )
{
    self endon( #"death" );
    epsilon = 1;
    failed = 0;
    degs_per_pos = 360 / num_positions;
    i = offset;
    
    while ( i < 360 + offset )
    {
        altforward = forward * attract_radius;
        rotated_forward = ( cos( i ) * altforward[ 0 ] - sin( i ) * altforward[ 1 ], sin( i ) * altforward[ 0 ] + cos( i ) * altforward[ 1 ], altforward[ 2 ] );
        
        if ( isdefined( level.poi_positioning_func ) )
        {
            pos = [[ level.poi_positioning_func ]]( self.origin, rotated_forward );
        }
        else if ( isdefined( level.use_alternate_poi_positioning ) && level.use_alternate_poi_positioning )
        {
            pos = zm_server_throttle::server_safe_ground_trace( "poi_trace", 10, self.origin + rotated_forward + ( 0, 0, 10 ) );
        }
        else
        {
            pos = zm_server_throttle::server_safe_ground_trace( "poi_trace", 10, self.origin + rotated_forward + ( 0, 0, 100 ) );
        }
        
        if ( !isdefined( pos ) )
        {
            failed++;
        }
        else if ( isdefined( level.use_alternate_poi_positioning ) && level.use_alternate_poi_positioning )
        {
            if ( isdefined( self ) && isdefined( self.origin ) )
            {
                if ( self.origin[ 2 ] >= pos[ 2 ] - epsilon && self.origin[ 2 ] - pos[ 2 ] <= 150 )
                {
                    pos_array = [];
                    pos_array[ 0 ] = pos;
                    pos_array[ 1 ] = self;
                    
                    if ( !isdefined( self.attractor_positions ) )
                    {
                        self.attractor_positions = [];
                    }
                    else if ( !isarray( self.attractor_positions ) )
                    {
                        self.attractor_positions = array( self.attractor_positions );
                    }
                    
                    self.attractor_positions[ self.attractor_positions.size ] = pos_array;
                }
            }
            else
            {
                failed++;
            }
        }
        else if ( abs( pos[ 2 ] - self.origin[ 2 ] ) < 60 )
        {
            pos_array = [];
            pos_array[ 0 ] = pos;
            pos_array[ 1 ] = self;
            
            if ( !isdefined( self.attractor_positions ) )
            {
                self.attractor_positions = [];
            }
            else if ( !isarray( self.attractor_positions ) )
            {
                self.attractor_positions = array( self.attractor_positions );
            }
            
            self.attractor_positions[ self.attractor_positions.size ] = pos_array;
        }
        else
        {
            failed++;
        }
        
        i += degs_per_pos;
    }
    
    return failed;
}

/#

    // Namespace zm_utility
    // Params 0
    // Checksum 0x288d4205, Offset: 0x2af0
    // Size: 0xa6, Type: dev
    function debug_draw_attractor_positions()
    {
        while ( true )
        {
            while ( !isdefined( self.attractor_positions ) )
            {
                wait 0.05;
                continue;
            }
            
            for ( i = 0; i < self.attractor_positions.size ; i++ )
            {
                line( self.origin, self.attractor_positions[ i ][ 0 ], ( 1, 0, 0 ), 1, 1 );
            }
            
            wait 0.05;
            
            if ( !isdefined( self ) )
            {
                return;
            }
        }
    }

    // Namespace zm_utility
    // Params 0
    // Checksum 0x7763f05, Offset: 0x2ba0
    // Size: 0xa6, Type: dev
    function debug_draw_claimed_attractor_positions()
    {
        while ( true )
        {
            while ( !isdefined( self.claimed_attractor_positions ) )
            {
                wait 0.05;
                continue;
            }
            
            for ( i = 0; i < self.claimed_attractor_positions.size ; i++ )
            {
                line( self.origin, self.claimed_attractor_positions[ i ][ 0 ], ( 0, 1, 0 ), 1, 1 );
            }
            
            wait 0.05;
            
            if ( !isdefined( self ) )
            {
                return;
            }
        }
    }

#/

// Namespace zm_utility
// Params 2
// Checksum 0xea120fe1, Offset: 0x2c50
// Size: 0x530
function get_zombie_point_of_interest( origin, poi_array )
{
    aiprofile_beginentry( "get_zombie_point_of_interest" );
    
    if ( isdefined( self.ignore_all_poi ) && self.ignore_all_poi )
    {
        aiprofile_endentry();
        return undefined;
    }
    
    curr_radius = undefined;
    
    if ( isdefined( poi_array ) )
    {
        ent_array = poi_array;
    }
    else
    {
        ent_array = level.zombie_poi_array;
    }
    
    best_poi = undefined;
    position = undefined;
    best_dist = 100000000;
    
    for ( i = 0; i < ent_array.size ; i++ )
    {
        if ( !isdefined( ent_array[ i ] ) || !isdefined( ent_array[ i ].poi_active ) || !ent_array[ i ].poi_active )
        {
            continue;
        }
        
        if ( isdefined( self.ignore_poi_targetname ) && self.ignore_poi_targetname.size > 0 )
        {
            if ( isdefined( ent_array[ i ].targetname ) )
            {
                ignore = 0;
                
                for ( j = 0; j < self.ignore_poi_targetname.size ; j++ )
                {
                    if ( ent_array[ i ].targetname == self.ignore_poi_targetname[ j ] )
                    {
                        ignore = 1;
                        break;
                    }
                }
                
                if ( ignore )
                {
                    continue;
                }
            }
        }
        
        if ( isdefined( self.ignore_poi ) && self.ignore_poi.size > 0 )
        {
            ignore = 0;
            
            for ( j = 0; j < self.ignore_poi.size ; j++ )
            {
                if ( self.ignore_poi[ j ] == ent_array[ i ] )
                {
                    ignore = 1;
                    break;
                }
            }
            
            if ( ignore )
            {
                continue;
            }
        }
        
        dist = distancesquared( origin, ent_array[ i ].origin );
        dist -= ent_array[ i ].added_poi_value;
        
        if ( isdefined( ent_array[ i ].poi_radius ) )
        {
            curr_radius = ent_array[ i ].poi_radius;
        }
        
        if ( ( !isdefined( curr_radius ) || dist < curr_radius ) && dist < best_dist && ent_array[ i ] can_attract( self ) )
        {
            best_poi = ent_array[ i ];
            best_dist = dist;
        }
    }
    
    if ( isdefined( best_poi ) )
    {
        if ( isdefined( best_poi._team ) )
        {
            if ( isdefined( self._race_team ) && self._race_team != best_poi._team )
            {
                aiprofile_endentry();
                return undefined;
            }
        }
        
        if ( isdefined( best_poi._new_ground_trace ) && best_poi._new_ground_trace )
        {
            position = [];
            position[ 0 ] = groundpos_ignore_water_new( best_poi.origin + ( 0, 0, 100 ) );
            position[ 1 ] = self;
        }
        else if ( isdefined( best_poi.attract_to_origin ) && best_poi.attract_to_origin )
        {
            position = [];
            position[ 0 ] = groundpos( best_poi.origin + ( 0, 0, 100 ) );
            position[ 1 ] = self;
        }
        else
        {
            position = self add_poi_attractor( best_poi );
        }
        
        if ( isdefined( best_poi.initial_attract_func ) )
        {
            self thread [[ best_poi.initial_attract_func ]]( best_poi );
        }
        
        if ( isdefined( best_poi.arrival_attract_func ) )
        {
            self thread [[ best_poi.arrival_attract_func ]]( best_poi );
        }
    }
    
    aiprofile_endentry();
    return position;
}

// Namespace zm_utility
// Params 0
// Checksum 0x88bffdc9, Offset: 0x3188
// Size: 0x28
function activate_zombie_point_of_interest()
{
    if ( self.script_noteworthy != "zombie_poi" )
    {
        return;
    }
    
    self.poi_active = 1;
}

// Namespace zm_utility
// Params 1
// Checksum 0x14eb05d6, Offset: 0x31b8
// Size: 0x104
function deactivate_zombie_point_of_interest( dont_remove )
{
    if ( self.script_noteworthy != "zombie_poi" )
    {
        return;
    }
    
    self.attractor_array = array::remove_undefined( self.attractor_array );
    
    for ( i = 0; i < self.attractor_array.size ; i++ )
    {
        self.attractor_array[ i ] notify( #"kill_poi" );
    }
    
    self.attractor_array = [];
    self.claimed_attractor_positions = [];
    self.poi_active = 0;
    
    if ( isdefined( dont_remove ) && dont_remove )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        if ( isinarray( level.zombie_poi_array, self ) )
        {
            arrayremovevalue( level.zombie_poi_array, self );
        }
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0x4a173f7e, Offset: 0x32c8
// Size: 0x118
function assign_zombie_point_of_interest( origin, poi )
{
    position = undefined;
    doremovalthread = 0;
    
    if ( isdefined( poi ) && poi can_attract( self ) )
    {
        if ( isdefined( poi.attractor_array ) && ( !isdefined( poi.attractor_array ) || !isinarray( poi.attractor_array, self ) ) )
        {
            doremovalthread = 1;
        }
        
        position = self add_poi_attractor( poi );
        
        if ( isdefined( position ) && doremovalthread && isinarray( poi.attractor_array, self ) )
        {
            self thread update_on_poi_removal( poi );
        }
    }
    
    return position;
}

// Namespace zm_utility
// Params 1
// Checksum 0xededf9f, Offset: 0x33e8
// Size: 0xf4
function remove_poi_attractor( zombie_poi )
{
    if ( !isdefined( zombie_poi ) || !isdefined( zombie_poi.attractor_array ) )
    {
        return;
    }
    
    for ( i = 0; i < zombie_poi.attractor_array.size ; i++ )
    {
        if ( zombie_poi.attractor_array[ i ] == self )
        {
            arrayremovevalue( zombie_poi.attractor_array, zombie_poi.attractor_array[ i ] );
            arrayremovevalue( zombie_poi.claimed_attractor_positions, zombie_poi.claimed_attractor_positions[ i ] );
            
            if ( isdefined( self ) )
            {
                self notify( #"kill_poi" );
            }
        }
    }
}

// Namespace zm_utility
// Params 3
// Checksum 0x7c474bcf, Offset: 0x34e8
// Size: 0x6a, Type: bool
function array_check_for_dupes_using_compare( array, single, is_equal_fn )
{
    for ( i = 0; i < array.size ; i++ )
    {
        if ( [[ is_equal_fn ]]( array[ i ], single ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_utility
// Params 2
// Checksum 0xcf9fc028, Offset: 0x3560
// Size: 0x26, Type: bool
function poi_locations_equal( loc1, loc2 )
{
    return loc1[ 0 ] == loc2[ 0 ];
}

// Namespace zm_utility
// Params 1
// Checksum 0xdc1a79bb, Offset: 0x3590
// Size: 0x54a
function add_poi_attractor( zombie_poi )
{
    if ( !isdefined( zombie_poi ) )
    {
        return;
    }
    
    if ( !isdefined( zombie_poi.attractor_array ) )
    {
        zombie_poi.attractor_array = [];
    }
    
    if ( !isinarray( zombie_poi.attractor_array, self ) )
    {
        if ( !isdefined( zombie_poi.claimed_attractor_positions ) )
        {
            zombie_poi.claimed_attractor_positions = [];
        }
        
        if ( !isdefined( zombie_poi.attractor_positions ) || zombie_poi.attractor_positions.size <= 0 )
        {
            return undefined;
        }
        
        start = -1;
        end = -1;
        last_index = -1;
        
        for ( i = 0; i < 4 ; i++ )
        {
            if ( zombie_poi.claimed_attractor_positions.size < zombie_poi.last_index[ i ] )
            {
                start = last_index + 1;
                end = zombie_poi.last_index[ i ];
                break;
            }
            
            last_index = zombie_poi.last_index[ i ];
        }
        
        best_dist = 100000000;
        best_pos = undefined;
        
        if ( start < 0 )
        {
            start = 0;
        }
        
        if ( end < 0 )
        {
            return undefined;
        }
        
        for ( i = int( start ); i <= int( end ) ; i++ )
        {
            if ( !isdefined( zombie_poi.attractor_positions[ i ] ) )
            {
                continue;
            }
            
            if ( array_check_for_dupes_using_compare( zombie_poi.claimed_attractor_positions, zombie_poi.attractor_positions[ i ], &poi_locations_equal ) )
            {
                if ( isdefined( zombie_poi.attractor_positions[ i ][ 0 ] ) && isdefined( self.origin ) )
                {
                    dist = distancesquared( zombie_poi.attractor_positions[ i ][ 0 ], zombie_poi.origin );
                    
                    if ( dist < best_dist || !isdefined( best_pos ) )
                    {
                        best_dist = dist;
                        best_pos = zombie_poi.attractor_positions[ i ];
                    }
                }
            }
        }
        
        if ( !isdefined( best_pos ) )
        {
            if ( isdefined( level.validate_poi_attractors ) && level.validate_poi_attractors )
            {
                valid_pos = [];
                valid_pos[ 0 ] = zombie_poi.origin;
                valid_pos[ 1 ] = zombie_poi;
                return valid_pos;
            }
            
            return undefined;
        }
        
        if ( !isdefined( zombie_poi.attractor_array ) )
        {
            zombie_poi.attractor_array = [];
        }
        else if ( !isarray( zombie_poi.attractor_array ) )
        {
            zombie_poi.attractor_array = array( zombie_poi.attractor_array );
        }
        
        zombie_poi.attractor_array[ zombie_poi.attractor_array.size ] = self;
        self thread update_poi_on_death( zombie_poi );
        
        if ( !isdefined( zombie_poi.claimed_attractor_positions ) )
        {
            zombie_poi.claimed_attractor_positions = [];
        }
        else if ( !isarray( zombie_poi.claimed_attractor_positions ) )
        {
            zombie_poi.claimed_attractor_positions = array( zombie_poi.claimed_attractor_positions );
        }
        
        zombie_poi.claimed_attractor_positions[ zombie_poi.claimed_attractor_positions.size ] = best_pos;
        return best_pos;
    }
    else
    {
        for ( i = 0; i < zombie_poi.attractor_array.size ; i++ )
        {
            if ( zombie_poi.attractor_array[ i ] == self )
            {
                if ( isdefined( zombie_poi.claimed_attractor_positions ) && isdefined( zombie_poi.claimed_attractor_positions[ i ] ) )
                {
                    return zombie_poi.claimed_attractor_positions[ i ];
                }
            }
        }
    }
    
    return undefined;
}

// Namespace zm_utility
// Params 1
// Checksum 0xc76eabdd, Offset: 0x3ae8
// Size: 0xa4, Type: bool
function can_attract( attractor )
{
    if ( !isdefined( self.attractor_array ) )
    {
        self.attractor_array = [];
    }
    
    if ( isdefined( self.attracted_array ) && !isinarray( self.attracted_array, attractor ) )
    {
        return false;
    }
    
    if ( isinarray( self.attractor_array, attractor ) )
    {
        return true;
    }
    
    if ( isdefined( self.num_poi_attracts ) && self.attractor_array.size >= self.num_poi_attracts )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_utility
// Params 1
// Checksum 0x5f1f3a17, Offset: 0x3b98
// Size: 0x3c
function update_poi_on_death( zombie_poi )
{
    self endon( #"kill_poi" );
    self waittill( #"death" );
    self remove_poi_attractor( zombie_poi );
}

// Namespace zm_utility
// Params 1
// Checksum 0x96da4cca, Offset: 0x3be0
// Size: 0xbe
function update_on_poi_removal( zombie_poi )
{
    zombie_poi waittill( #"death" );
    
    if ( !isdefined( zombie_poi.attractor_array ) )
    {
        return;
    }
    
    for ( i = 0; i < zombie_poi.attractor_array.size ; i++ )
    {
        if ( zombie_poi.attractor_array[ i ] == self )
        {
            arrayremoveindex( zombie_poi.attractor_array, i );
            arrayremoveindex( zombie_poi.claimed_attractor_positions, i );
        }
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0xb9961f3, Offset: 0x3ca8
// Size: 0x1fa
function invalidate_attractor_pos( attractor_pos, zombie )
{
    if ( !isdefined( self ) || !isdefined( attractor_pos ) )
    {
        wait 0.1;
        return undefined;
    }
    
    if ( isdefined( self.attractor_positions ) && !array_check_for_dupes_using_compare( self.attractor_positions, attractor_pos, &poi_locations_equal ) )
    {
        index = 0;
        
        for ( i = 0; i < self.attractor_positions.size ; i++ )
        {
            if ( poi_locations_equal( self.attractor_positions[ i ], attractor_pos ) )
            {
                index = i;
            }
        }
        
        for ( i = 0; i < self.last_index.size ; i++ )
        {
            if ( index <= self.last_index[ i ] )
            {
                self.last_index[ i ]--;
            }
        }
        
        arrayremovevalue( self.attractor_array, zombie );
        arrayremovevalue( self.attractor_positions, attractor_pos );
        
        for ( i = 0; i < self.claimed_attractor_positions.size ; i++ )
        {
            if ( self.claimed_attractor_positions[ i ][ 0 ] == attractor_pos[ 0 ] )
            {
                arrayremovevalue( self.claimed_attractor_positions, self.claimed_attractor_positions[ i ] );
            }
        }
    }
    else
    {
        wait 0.1;
    }
    
    return get_zombie_point_of_interest( zombie.origin );
}

// Namespace zm_utility
// Params 1
// Checksum 0xe9b98d76, Offset: 0x3eb0
// Size: 0x90
function remove_poi_from_ignore_list( poi )
{
    if ( isdefined( self.ignore_poi ) && self.ignore_poi.size > 0 )
    {
        for ( i = 0; i < self.ignore_poi.size ; i++ )
        {
            if ( self.ignore_poi[ i ] == poi )
            {
                arrayremovevalue( self.ignore_poi, self.ignore_poi[ i ] );
                return;
            }
        }
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x7373bc3c, Offset: 0x3f48
// Size: 0xb6
function add_poi_to_ignore_list( poi )
{
    if ( !isdefined( self.ignore_poi ) )
    {
        self.ignore_poi = [];
    }
    
    add_poi = 1;
    
    if ( self.ignore_poi.size > 0 )
    {
        for ( i = 0; i < self.ignore_poi.size ; i++ )
        {
            if ( self.ignore_poi[ i ] == poi )
            {
                add_poi = 0;
                break;
            }
        }
    }
    
    if ( add_poi )
    {
        self.ignore_poi[ self.ignore_poi.size ] = poi;
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x7d93802e, Offset: 0x4008
// Size: 0x66, Type: bool
function default_validate_enemy_path_length( player )
{
    max_dist = 1296;
    d = distancesquared( self.origin, player.origin );
    
    if ( d <= max_dist )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_utility
// Params 2
// Checksum 0x541595ae, Offset: 0x4078
// Size: 0x426
function get_closest_valid_player( origin, ignore_player )
{
    aiprofile_beginentry( "get_closest_valid_player" );
    valid_player_found = 0;
    players = getplayers();
    
    if ( isdefined( level.get_closest_valid_player_override ) )
    {
        players = [[ level.get_closest_valid_player_override ]]();
    }
    
    b_designated_target_exists = 0;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !player.am_i_valid )
        {
            continue;
        }
        
        if ( isdefined( level.evaluate_zone_path_override ) )
        {
            if ( ![[ level.evaluate_zone_path_override ]]( player ) )
            {
                array::add( ignore_player, player );
            }
        }
        
        if ( isdefined( player.b_is_designated_target ) && player.b_is_designated_target )
        {
            b_designated_target_exists = 1;
        }
    }
    
    if ( isdefined( ignore_player ) )
    {
        for ( i = 0; i < ignore_player.size ; i++ )
        {
            arrayremovevalue( players, ignore_player[ i ] );
        }
    }
    
    done = 0;
    
    while ( players.size && !done )
    {
        done = 1;
        
        for ( i = 0; i < players.size ; i++ )
        {
            player = players[ i ];
            
            if ( !player.am_i_valid )
            {
                arrayremovevalue( players, player );
                done = 0;
                break;
            }
            
            if ( b_designated_target_exists && !( isdefined( player.b_is_designated_target ) && player.b_is_designated_target ) )
            {
                arrayremovevalue( players, player );
                done = 0;
                break;
            }
        }
    }
    
    if ( players.size == 0 )
    {
        aiprofile_endentry();
        return undefined;
    }
    
    while ( !valid_player_found )
    {
        if ( isdefined( self.closest_player_override ) )
        {
            player = [[ self.closest_player_override ]]( origin, players );
        }
        else if ( isdefined( level.closest_player_override ) )
        {
            player = [[ level.closest_player_override ]]( origin, players );
        }
        else
        {
            player = arraygetclosest( origin, players );
        }
        
        if ( !isdefined( player ) || players.size == 0 )
        {
            aiprofile_endentry();
            return undefined;
        }
        
        if ( isdefined( player.allow_zombie_to_target_ai ) && ( isdefined( level.allow_zombie_to_target_ai ) && level.allow_zombie_to_target_ai || player.allow_zombie_to_target_ai ) )
        {
            aiprofile_endentry();
            return player;
        }
        
        if ( !player.am_i_valid )
        {
            arrayremovevalue( players, player );
            
            if ( players.size == 0 )
            {
                aiprofile_endentry();
                return undefined;
            }
            
            continue;
        }
        
        aiprofile_endentry();
        return player;
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0xc37d6f04, Offset: 0x44a8
// Size: 0x3ac
function update_valid_players( origin, ignore_player )
{
    aiprofile_beginentry( "update_valid_players" );
    valid_player_found = 0;
    players = arraycopy( level.players );
    
    foreach ( player in players )
    {
        self setignoreent( player, 1 );
    }
    
    b_designated_target_exists = 0;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !player.am_i_valid )
        {
            continue;
        }
        
        if ( isdefined( level.evaluate_zone_path_override ) )
        {
            if ( ![[ level.evaluate_zone_path_override ]]( player ) )
            {
                array::add( ignore_player, player );
            }
        }
        
        if ( isdefined( player.b_is_designated_target ) && player.b_is_designated_target )
        {
            b_designated_target_exists = 1;
        }
    }
    
    if ( isdefined( ignore_player ) )
    {
        for ( i = 0; i < ignore_player.size ; i++ )
        {
            arrayremovevalue( players, ignore_player[ i ] );
        }
    }
    
    done = 0;
    
    while ( players.size && !done )
    {
        done = 1;
        
        for ( i = 0; i < players.size ; i++ )
        {
            player = players[ i ];
            
            if ( !player.am_i_valid )
            {
                arrayremovevalue( players, player );
                done = 0;
                break;
            }
            
            if ( b_designated_target_exists && !( isdefined( player.b_is_designated_target ) && player.b_is_designated_target ) )
            {
                arrayremovevalue( players, player );
                done = 0;
                break;
            }
        }
    }
    
    foreach ( player in players )
    {
        self setignoreent( player, 0 );
        self getperfectinfo( player );
    }
    
    aiprofile_endentry();
}

// Namespace zm_utility
// Params 3
// Checksum 0xaecdd28f, Offset: 0x4860
// Size: 0x170
function is_player_valid( player, checkignoremeflag, ignore_laststand_players )
{
    if ( !isdefined( player ) )
    {
        return 0;
    }
    
    if ( !isalive( player ) )
    {
        return 0;
    }
    
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    if ( isdefined( player.is_zombie ) && player.is_zombie == 1 )
    {
        return 0;
    }
    
    if ( player.sessionstate == "spectator" )
    {
        return 0;
    }
    
    if ( player.sessionstate == "intermission" )
    {
        return 0;
    }
    
    if ( isdefined( level.intermission ) && level.intermission )
    {
        return 0;
    }
    
    if ( !( isdefined( ignore_laststand_players ) && ignore_laststand_players ) )
    {
        if ( player laststand::player_is_in_laststand() )
        {
            return 0;
        }
    }
    
    if ( isdefined( checkignoremeflag ) && checkignoremeflag && player.ignoreme )
    {
        return 0;
    }
    
    if ( isdefined( level.is_player_valid_override ) )
    {
        return [[ level.is_player_valid_override ]]( player );
    }
    
    return 1;
}

// Namespace zm_utility
// Params 0
// Checksum 0x75a045c2, Offset: 0x49d8
// Size: 0x8c
function get_number_of_valid_players()
{
    players = getplayers();
    num_player_valid = 0;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( is_player_valid( players[ i ] ) )
        {
            num_player_valid += 1;
        }
    }
    
    return num_player_valid;
}

// Namespace zm_utility
// Params 0
// Checksum 0x9e27bca8, Offset: 0x4a70
// Size: 0x10a
function in_revive_trigger()
{
    if ( isdefined( self.rt_time ) && self.rt_time + 100 >= gettime() )
    {
        return self.in_rt_cached;
    }
    
    self.rt_time = gettime();
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        current_player = players[ i ];
        
        if ( isdefined( current_player ) && isdefined( current_player.revivetrigger ) && isalive( current_player ) )
        {
            if ( self istouching( current_player.revivetrigger ) )
            {
                self.in_rt_cached = 1;
                return 1;
            }
        }
    }
    
    self.in_rt_cached = 0;
    return 0;
}

// Namespace zm_utility
// Params 2
// Checksum 0x415a86e4, Offset: 0x4b88
// Size: 0x2a
function get_closest_node( org, nodes )
{
    return arraygetclosest( org, nodes );
}

// Namespace zm_utility
// Params 2
// Checksum 0xa6b3c1da, Offset: 0x4bc0
// Size: 0x526
function non_destroyed_bar_board_order( origin, chunks )
{
    first_bars = [];
    first_bars1 = [];
    first_bars2 = [];
    
    for ( i = 0; i < chunks.size ; i++ )
    {
        if ( isdefined( chunks[ i ].script_team ) && chunks[ i ].script_team == "classic_boards" )
        {
            if ( isdefined( chunks[ i ].script_parameters ) && chunks[ i ].script_parameters == "board" )
            {
                return get_closest_2d( origin, chunks );
            }
            else if ( isdefined( chunks[ i ].script_team ) && chunks[ i ].script_team == "bar_board_variant1" || chunks[ i ].script_team == "bar_board_variant2" || chunks[ i ].script_team == "bar_board_variant4" || chunks[ i ].script_team == "bar_board_variant5" )
            {
                return undefined;
            }
            
            continue;
        }
        
        if ( isdefined( chunks[ i ].script_team ) && chunks[ i ].script_team == "new_barricade" )
        {
            if ( chunks[ i ].script_parameters == "repair_board" || isdefined( chunks[ i ].script_parameters ) && chunks[ i ].script_parameters == "barricade_vents" )
            {
                return get_closest_2d( origin, chunks );
            }
        }
    }
    
    for ( i = 0; i < chunks.size ; i++ )
    {
        if ( isdefined( chunks[ i ].script_team ) && chunks[ i ].script_team == "6_bars_bent" || chunks[ i ].script_team == "6_bars_prestine" )
        {
            if ( isdefined( chunks[ i ].script_parameters ) && chunks[ i ].script_parameters == "bar" )
            {
                if ( isdefined( chunks[ i ].script_noteworthy ) )
                {
                    if ( chunks[ i ].script_noteworthy == "4" || chunks[ i ].script_noteworthy == "6" )
                    {
                        first_bars[ first_bars.size ] = chunks[ i ];
                    }
                }
            }
        }
    }
    
    for ( i = 0; i < first_bars.size ; i++ )
    {
        if ( isdefined( chunks[ i ].script_team ) && chunks[ i ].script_team == "6_bars_bent" || chunks[ i ].script_team == "6_bars_prestine" )
        {
            if ( isdefined( chunks[ i ].script_parameters ) && chunks[ i ].script_parameters == "bar" )
            {
                if ( !first_bars[ i ].destroyed )
                {
                    return first_bars[ i ];
                }
            }
        }
    }
    
    for ( i = 0; i < chunks.size ; i++ )
    {
        if ( isdefined( chunks[ i ].script_team ) && chunks[ i ].script_team == "6_bars_bent" || chunks[ i ].script_team == "6_bars_prestine" )
        {
            if ( isdefined( chunks[ i ].script_parameters ) && chunks[ i ].script_parameters == "bar" )
            {
                if ( !chunks[ i ].destroyed )
                {
                    return get_closest_2d( origin, chunks );
                }
            }
        }
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0xd18ddb2b, Offset: 0x50f0
// Size: 0x572
function non_destroyed_grate_order( origin, chunks_grate )
{
    grate_order = [];
    grate_order1 = [];
    grate_order2 = [];
    grate_order3 = [];
    grate_order4 = [];
    grate_order5 = [];
    grate_order6 = [];
    
    if ( isdefined( chunks_grate ) )
    {
        for ( i = 0; i < chunks_grate.size ; i++ )
        {
            if ( isdefined( chunks_grate[ i ].script_parameters ) && chunks_grate[ i ].script_parameters == "grate" )
            {
                if ( isdefined( chunks_grate[ i ].script_noteworthy ) && chunks_grate[ i ].script_noteworthy == "1" )
                {
                    grate_order1[ grate_order1.size ] = chunks_grate[ i ];
                }
                
                if ( isdefined( chunks_grate[ i ].script_noteworthy ) && chunks_grate[ i ].script_noteworthy == "2" )
                {
                    grate_order2[ grate_order2.size ] = chunks_grate[ i ];
                }
                
                if ( isdefined( chunks_grate[ i ].script_noteworthy ) && chunks_grate[ i ].script_noteworthy == "3" )
                {
                    grate_order3[ grate_order3.size ] = chunks_grate[ i ];
                }
                
                if ( isdefined( chunks_grate[ i ].script_noteworthy ) && chunks_grate[ i ].script_noteworthy == "4" )
                {
                    grate_order4[ grate_order4.size ] = chunks_grate[ i ];
                }
                
                if ( isdefined( chunks_grate[ i ].script_noteworthy ) && chunks_grate[ i ].script_noteworthy == "5" )
                {
                    grate_order5[ grate_order5.size ] = chunks_grate[ i ];
                }
                
                if ( isdefined( chunks_grate[ i ].script_noteworthy ) && chunks_grate[ i ].script_noteworthy == "6" )
                {
                    grate_order6[ grate_order6.size ] = chunks_grate[ i ];
                }
            }
        }
        
        for ( i = 0; i < chunks_grate.size ; i++ )
        {
            if ( isdefined( chunks_grate[ i ].script_parameters ) && chunks_grate[ i ].script_parameters == "grate" )
            {
                if ( isdefined( grate_order1[ i ] ) )
                {
                    if ( grate_order1[ i ].state == "repaired" )
                    {
                        grate_order2[ i ] thread show_grate_pull();
                        return grate_order1[ i ];
                    }
                    
                    if ( grate_order2[ i ].state == "repaired" )
                    {
                        /#
                            iprintlnbold( "<dev string:x68>" );
                        #/
                        
                        grate_order3[ i ] thread show_grate_pull();
                        return grate_order2[ i ];
                    }
                    
                    if ( grate_order3[ i ].state == "repaired" )
                    {
                        /#
                            iprintlnbold( "<dev string:x74>" );
                        #/
                        
                        grate_order4[ i ] thread show_grate_pull();
                        return grate_order3[ i ];
                    }
                    
                    if ( grate_order4[ i ].state == "repaired" )
                    {
                        /#
                            iprintlnbold( "<dev string:x80>" );
                        #/
                        
                        grate_order5[ i ] thread show_grate_pull();
                        return grate_order4[ i ];
                    }
                    
                    if ( grate_order5[ i ].state == "repaired" )
                    {
                        /#
                            iprintlnbold( "<dev string:x8c>" );
                        #/
                        
                        grate_order6[ i ] thread show_grate_pull();
                        return grate_order5[ i ];
                    }
                    
                    if ( grate_order6[ i ].state == "repaired" )
                    {
                        return grate_order6[ i ];
                    }
                }
            }
        }
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0xcd013428, Offset: 0x5670
// Size: 0x3e2
function non_destroyed_variant1_order( origin, chunks_variant1 )
{
    variant1_order = [];
    variant1_order1 = [];
    variant1_order2 = [];
    variant1_order3 = [];
    variant1_order4 = [];
    variant1_order5 = [];
    variant1_order6 = [];
    
    if ( isdefined( chunks_variant1 ) )
    {
        for ( i = 0; i < chunks_variant1.size ; i++ )
        {
            if ( isdefined( chunks_variant1[ i ].script_team ) && chunks_variant1[ i ].script_team == "bar_board_variant1" )
            {
                if ( isdefined( chunks_variant1[ i ].script_noteworthy ) )
                {
                    if ( chunks_variant1[ i ].script_noteworthy == "1" )
                    {
                        variant1_order1[ variant1_order1.size ] = chunks_variant1[ i ];
                    }
                    
                    if ( chunks_variant1[ i ].script_noteworthy == "2" )
                    {
                        variant1_order2[ variant1_order2.size ] = chunks_variant1[ i ];
                    }
                    
                    if ( chunks_variant1[ i ].script_noteworthy == "3" )
                    {
                        variant1_order3[ variant1_order3.size ] = chunks_variant1[ i ];
                    }
                    
                    if ( chunks_variant1[ i ].script_noteworthy == "4" )
                    {
                        variant1_order4[ variant1_order4.size ] = chunks_variant1[ i ];
                    }
                    
                    if ( chunks_variant1[ i ].script_noteworthy == "5" )
                    {
                        variant1_order5[ variant1_order5.size ] = chunks_variant1[ i ];
                    }
                    
                    if ( chunks_variant1[ i ].script_noteworthy == "6" )
                    {
                        variant1_order6[ variant1_order6.size ] = chunks_variant1[ i ];
                    }
                }
            }
        }
        
        for ( i = 0; i < chunks_variant1.size ; i++ )
        {
            if ( isdefined( chunks_variant1[ i ].script_team ) && chunks_variant1[ i ].script_team == "bar_board_variant1" )
            {
                if ( isdefined( variant1_order2[ i ] ) )
                {
                    if ( variant1_order2[ i ].state == "repaired" )
                    {
                        return variant1_order2[ i ];
                    }
                    
                    if ( variant1_order3[ i ].state == "repaired" )
                    {
                        return variant1_order3[ i ];
                    }
                    
                    if ( variant1_order4[ i ].state == "repaired" )
                    {
                        return variant1_order4[ i ];
                    }
                    
                    if ( variant1_order6[ i ].state == "repaired" )
                    {
                        return variant1_order6[ i ];
                    }
                    
                    if ( variant1_order5[ i ].state == "repaired" )
                    {
                        return variant1_order5[ i ];
                    }
                    
                    if ( variant1_order1[ i ].state == "repaired" )
                    {
                        return variant1_order1[ i ];
                    }
                }
            }
        }
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0x93e2a8e2, Offset: 0x5a60
// Size: 0x4ca
function non_destroyed_variant2_order( origin, chunks_variant2 )
{
    variant2_order = [];
    variant2_order1 = [];
    variant2_order2 = [];
    variant2_order3 = [];
    variant2_order4 = [];
    variant2_order5 = [];
    variant2_order6 = [];
    
    if ( isdefined( chunks_variant2 ) )
    {
        for ( i = 0; i < chunks_variant2.size ; i++ )
        {
            if ( isdefined( chunks_variant2[ i ].script_team ) && chunks_variant2[ i ].script_team == "bar_board_variant2" )
            {
                if ( isdefined( chunks_variant2[ i ].script_noteworthy ) && chunks_variant2[ i ].script_noteworthy == "1" )
                {
                    variant2_order1[ variant2_order1.size ] = chunks_variant2[ i ];
                }
                
                if ( isdefined( chunks_variant2[ i ].script_noteworthy ) && chunks_variant2[ i ].script_noteworthy == "2" )
                {
                    variant2_order2[ variant2_order2.size ] = chunks_variant2[ i ];
                }
                
                if ( isdefined( chunks_variant2[ i ].script_noteworthy ) && chunks_variant2[ i ].script_noteworthy == "3" )
                {
                    variant2_order3[ variant2_order3.size ] = chunks_variant2[ i ];
                }
                
                if ( isdefined( chunks_variant2[ i ].script_noteworthy ) && chunks_variant2[ i ].script_noteworthy == "4" )
                {
                    variant2_order4[ variant2_order4.size ] = chunks_variant2[ i ];
                }
                
                if ( isdefined( chunks_variant2[ i ].script_noteworthy ) && chunks_variant2[ i ].script_noteworthy == "5" && isdefined( chunks_variant2[ i ].script_location ) && chunks_variant2[ i ].script_location == "5" )
                {
                    variant2_order5[ variant2_order5.size ] = chunks_variant2[ i ];
                }
                
                if ( isdefined( chunks_variant2[ i ].script_noteworthy ) && chunks_variant2[ i ].script_noteworthy == "5" && isdefined( chunks_variant2[ i ].script_location ) && chunks_variant2[ i ].script_location == "6" )
                {
                    variant2_order6[ variant2_order6.size ] = chunks_variant2[ i ];
                }
            }
        }
        
        for ( i = 0; i < chunks_variant2.size ; i++ )
        {
            if ( isdefined( chunks_variant2[ i ].script_team ) && chunks_variant2[ i ].script_team == "bar_board_variant2" )
            {
                if ( isdefined( variant2_order1[ i ] ) )
                {
                    if ( variant2_order1[ i ].state == "repaired" )
                    {
                        return variant2_order1[ i ];
                    }
                    
                    if ( variant2_order2[ i ].state == "repaired" )
                    {
                        return variant2_order2[ i ];
                    }
                    
                    if ( variant2_order3[ i ].state == "repaired" )
                    {
                        return variant2_order3[ i ];
                    }
                    
                    if ( variant2_order5[ i ].state == "repaired" )
                    {
                        return variant2_order5[ i ];
                    }
                    
                    if ( variant2_order4[ i ].state == "repaired" )
                    {
                        return variant2_order4[ i ];
                    }
                    
                    if ( variant2_order6[ i ].state == "repaired" )
                    {
                        return variant2_order6[ i ];
                    }
                }
            }
        }
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0x4fca0746, Offset: 0x5f38
// Size: 0x4ae
function non_destroyed_variant4_order( origin, chunks_variant4 )
{
    variant4_order = [];
    variant4_order1 = [];
    variant4_order2 = [];
    variant4_order3 = [];
    variant4_order4 = [];
    variant4_order5 = [];
    variant4_order6 = [];
    
    if ( isdefined( chunks_variant4 ) )
    {
        for ( i = 0; i < chunks_variant4.size ; i++ )
        {
            if ( isdefined( chunks_variant4[ i ].script_team ) && chunks_variant4[ i ].script_team == "bar_board_variant4" )
            {
                if ( isdefined( chunks_variant4[ i ].script_noteworthy ) && chunks_variant4[ i ].script_noteworthy == "1" && !isdefined( chunks_variant4[ i ].script_location ) )
                {
                    variant4_order1[ variant4_order1.size ] = chunks_variant4[ i ];
                }
                
                if ( isdefined( chunks_variant4[ i ].script_noteworthy ) && chunks_variant4[ i ].script_noteworthy == "2" )
                {
                    variant4_order2[ variant4_order2.size ] = chunks_variant4[ i ];
                }
                
                if ( isdefined( chunks_variant4[ i ].script_noteworthy ) && chunks_variant4[ i ].script_noteworthy == "3" )
                {
                    variant4_order3[ variant4_order3.size ] = chunks_variant4[ i ];
                }
                
                if ( isdefined( chunks_variant4[ i ].script_noteworthy ) && chunks_variant4[ i ].script_noteworthy == "1" && isdefined( chunks_variant4[ i ].script_location ) && chunks_variant4[ i ].script_location == "3" )
                {
                    variant4_order4[ variant4_order4.size ] = chunks_variant4[ i ];
                }
                
                if ( isdefined( chunks_variant4[ i ].script_noteworthy ) && chunks_variant4[ i ].script_noteworthy == "5" )
                {
                    variant4_order5[ variant4_order5.size ] = chunks_variant4[ i ];
                }
                
                if ( isdefined( chunks_variant4[ i ].script_noteworthy ) && chunks_variant4[ i ].script_noteworthy == "6" )
                {
                    variant4_order6[ variant4_order6.size ] = chunks_variant4[ i ];
                }
            }
        }
        
        for ( i = 0; i < chunks_variant4.size ; i++ )
        {
            if ( isdefined( chunks_variant4[ i ].script_team ) && chunks_variant4[ i ].script_team == "bar_board_variant4" )
            {
                if ( isdefined( variant4_order1[ i ] ) )
                {
                    if ( variant4_order1[ i ].state == "repaired" )
                    {
                        return variant4_order1[ i ];
                    }
                    
                    if ( variant4_order6[ i ].state == "repaired" )
                    {
                        return variant4_order6[ i ];
                    }
                    
                    if ( variant4_order3[ i ].state == "repaired" )
                    {
                        return variant4_order3[ i ];
                    }
                    
                    if ( variant4_order4[ i ].state == "repaired" )
                    {
                        return variant4_order4[ i ];
                    }
                    
                    if ( variant4_order2[ i ].state == "repaired" )
                    {
                        return variant4_order2[ i ];
                    }
                    
                    if ( variant4_order5[ i ].state == "repaired" )
                    {
                        return variant4_order5[ i ];
                    }
                }
            }
        }
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0xba240a11, Offset: 0x63f0
// Size: 0x44e
function non_destroyed_variant5_order( origin, chunks_variant5 )
{
    variant5_order = [];
    variant5_order1 = [];
    variant5_order2 = [];
    variant5_order3 = [];
    variant5_order4 = [];
    variant5_order5 = [];
    variant5_order6 = [];
    
    if ( isdefined( chunks_variant5 ) )
    {
        for ( i = 0; i < chunks_variant5.size ; i++ )
        {
            if ( isdefined( chunks_variant5[ i ].script_team ) && chunks_variant5[ i ].script_team == "bar_board_variant5" )
            {
                if ( isdefined( chunks_variant5[ i ].script_noteworthy ) )
                {
                    if ( chunks_variant5[ i ].script_noteworthy == "1" && !isdefined( chunks_variant5[ i ].script_location ) )
                    {
                        variant5_order1[ variant5_order1.size ] = chunks_variant5[ i ];
                    }
                    
                    if ( chunks_variant5[ i ].script_noteworthy == "2" )
                    {
                        variant5_order2[ variant5_order2.size ] = chunks_variant5[ i ];
                    }
                    
                    if ( isdefined( chunks_variant5[ i ].script_noteworthy ) && chunks_variant5[ i ].script_noteworthy == "1" && isdefined( chunks_variant5[ i ].script_location ) && chunks_variant5[ i ].script_location == "3" )
                    {
                        variant5_order3[ variant5_order3.size ] = chunks_variant5[ i ];
                    }
                    
                    if ( chunks_variant5[ i ].script_noteworthy == "4" )
                    {
                        variant5_order4[ variant5_order4.size ] = chunks_variant5[ i ];
                    }
                    
                    if ( chunks_variant5[ i ].script_noteworthy == "5" )
                    {
                        variant5_order5[ variant5_order5.size ] = chunks_variant5[ i ];
                    }
                    
                    if ( chunks_variant5[ i ].script_noteworthy == "6" )
                    {
                        variant5_order6[ variant5_order6.size ] = chunks_variant5[ i ];
                    }
                }
            }
        }
        
        for ( i = 0; i < chunks_variant5.size ; i++ )
        {
            if ( isdefined( chunks_variant5[ i ].script_team ) && chunks_variant5[ i ].script_team == "bar_board_variant5" )
            {
                if ( isdefined( variant5_order1[ i ] ) )
                {
                    if ( variant5_order1[ i ].state == "repaired" )
                    {
                        return variant5_order1[ i ];
                    }
                    
                    if ( variant5_order6[ i ].state == "repaired" )
                    {
                        return variant5_order6[ i ];
                    }
                    
                    if ( variant5_order3[ i ].state == "repaired" )
                    {
                        return variant5_order3[ i ];
                    }
                    
                    if ( variant5_order2[ i ].state == "repaired" )
                    {
                        return variant5_order2[ i ];
                    }
                    
                    if ( variant5_order5[ i ].state == "repaired" )
                    {
                        return variant5_order5[ i ];
                    }
                    
                    if ( variant5_order4[ i ].state == "repaired" )
                    {
                        return variant5_order4[ i ];
                    }
                }
            }
        }
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0xdea660fa, Offset: 0x6848
// Size: 0x5c
function show_grate_pull()
{
    wait 0.53;
    self show();
    self vibrate( ( 0, 270, 0 ), 0.2, 0.4, 0.4 );
}

// Namespace zm_utility
// Params 2
// Checksum 0xe50a4dd9, Offset: 0x68b0
// Size: 0x228
function get_closest_2d( origin, ents )
{
    if ( !isdefined( ents ) )
    {
        return undefined;
    }
    
    dist = distance2d( origin, ents[ 0 ].origin );
    index = 0;
    temp_array = [];
    
    for ( i = 1; i < ents.size ; i++ )
    {
        if ( isdefined( ents[ i ].unbroken ) && ents[ i ].unbroken == 1 )
        {
            ents[ i ].index = i;
            
            if ( !isdefined( temp_array ) )
            {
                temp_array = [];
            }
            else if ( !isarray( temp_array ) )
            {
                temp_array = array( temp_array );
            }
            
            temp_array[ temp_array.size ] = ents[ i ];
        }
    }
    
    if ( temp_array.size > 0 )
    {
        index = temp_array[ randomintrange( 0, temp_array.size ) ].index;
        return ents[ index ];
    }
    
    for ( i = 1; i < ents.size ; i++ )
    {
        temp_dist = distance2d( origin, ents[ i ].origin );
        
        if ( temp_dist < dist )
        {
            dist = temp_dist;
            index = i;
        }
    }
    
    return ents[ index ];
}

// Namespace zm_utility
// Params 0
// Checksum 0xe4f1d939, Offset: 0x6ae0
// Size: 0xb0, Type: bool
function in_playable_area()
{
    playable_area = getentarray( "player_volume", "script_noteworthy" );
    
    if ( !isdefined( playable_area ) )
    {
        println( "<dev string:x98>" );
        return true;
    }
    
    for ( i = 0; i < playable_area.size ; i++ )
    {
        if ( self istouching( playable_area[ i ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_utility
// Params 3
// Checksum 0x327492ca, Offset: 0x6b98
// Size: 0x126
function get_closest_non_destroyed_chunk( origin, barrier, barrier_chunks )
{
    chunks = undefined;
    chunks_grate = undefined;
    chunks_grate = get_non_destroyed_chunks_grate( barrier, barrier_chunks );
    chunks = get_non_destroyed_chunks( barrier, barrier_chunks );
    
    if ( isdefined( barrier.zbarrier ) )
    {
        if ( isdefined( chunks ) )
        {
            return array::randomize( chunks )[ 0 ];
        }
        
        if ( isdefined( chunks_grate ) )
        {
            return array::randomize( chunks_grate )[ 0 ];
        }
    }
    else if ( isdefined( chunks ) )
    {
        return non_destroyed_bar_board_order( origin, chunks );
    }
    else if ( isdefined( chunks_grate ) )
    {
        return non_destroyed_grate_order( origin, chunks_grate );
    }
    
    return undefined;
}

// Namespace zm_utility
// Params 2
// Checksum 0x213f1f86, Offset: 0x6cc8
// Size: 0x148
function get_random_destroyed_chunk( barrier, barrier_chunks )
{
    if ( isdefined( barrier.zbarrier ) )
    {
        ret = undefined;
        pieces = barrier.zbarrier getzbarrierpieceindicesinstate( "open" );
        
        if ( pieces.size )
        {
            ret = array::randomize( pieces )[ 0 ];
        }
        
        return ret;
    }
    
    chunk = undefined;
    chunks_repair_grate = undefined;
    chunks = get_destroyed_chunks( barrier_chunks );
    chunks_repair_grate = get_destroyed_repair_grates( barrier_chunks );
    
    if ( isdefined( chunks ) )
    {
        return chunks[ randomint( chunks.size ) ];
    }
    else if ( isdefined( chunks_repair_grate ) )
    {
        return grate_order_destroyed( chunks_repair_grate );
    }
    
    return undefined;
}

// Namespace zm_utility
// Params 1
// Checksum 0x6f3ce155, Offset: 0x6e18
// Size: 0xbc
function get_destroyed_repair_grates( barrier_chunks )
{
    array = [];
    
    for ( i = 0; i < barrier_chunks.size ; i++ )
    {
        if ( isdefined( barrier_chunks[ i ] ) )
        {
            if ( isdefined( barrier_chunks[ i ].script_parameters ) && barrier_chunks[ i ].script_parameters == "grate" )
            {
                array[ array.size ] = barrier_chunks[ i ];
            }
        }
    }
    
    if ( array.size == 0 )
    {
        return undefined;
    }
    
    return array;
}

// Namespace zm_utility
// Params 2
// Checksum 0x2120b009, Offset: 0x6ee0
// Size: 0x43e
function get_non_destroyed_chunks( barrier, barrier_chunks )
{
    if ( isdefined( barrier.zbarrier ) )
    {
        return barrier.zbarrier getzbarrierpieceindicesinstate( "closed" );
    }
    
    array = [];
    
    for ( i = 0; i < barrier_chunks.size ; i++ )
    {
        if ( isdefined( barrier_chunks[ i ].script_team ) && barrier_chunks[ i ].script_team == "classic_boards" )
        {
            if ( isdefined( barrier_chunks[ i ].script_parameters ) && barrier_chunks[ i ].script_parameters == "board" )
            {
                if ( barrier_chunks[ i ] get_chunk_state() == "repaired" )
                {
                    if ( barrier_chunks[ i ].origin == barrier_chunks[ i ].og_origin )
                    {
                        array[ array.size ] = barrier_chunks[ i ];
                    }
                }
            }
        }
        
        if ( isdefined( barrier_chunks[ i ].script_team ) && barrier_chunks[ i ].script_team == "new_barricade" )
        {
            if ( barrier_chunks[ i ].script_parameters == "repair_board" || isdefined( barrier_chunks[ i ].script_parameters ) && barrier_chunks[ i ].script_parameters == "barricade_vents" )
            {
                if ( barrier_chunks[ i ] get_chunk_state() == "repaired" )
                {
                    if ( barrier_chunks[ i ].origin == barrier_chunks[ i ].og_origin )
                    {
                        array[ array.size ] = barrier_chunks[ i ];
                    }
                }
            }
            
            continue;
        }
        
        if ( isdefined( barrier_chunks[ i ].script_team ) && barrier_chunks[ i ].script_team == "6_bars_bent" )
        {
            if ( isdefined( barrier_chunks[ i ].script_parameters ) && barrier_chunks[ i ].script_parameters == "bar" )
            {
                if ( barrier_chunks[ i ] get_chunk_state() == "repaired" )
                {
                    if ( barrier_chunks[ i ].origin == barrier_chunks[ i ].og_origin )
                    {
                        array[ array.size ] = barrier_chunks[ i ];
                    }
                }
            }
            
            continue;
        }
        
        if ( isdefined( barrier_chunks[ i ].script_team ) && barrier_chunks[ i ].script_team == "6_bars_prestine" )
        {
            if ( isdefined( barrier_chunks[ i ].script_parameters ) && barrier_chunks[ i ].script_parameters == "bar" )
            {
                if ( barrier_chunks[ i ] get_chunk_state() == "repaired" )
                {
                    if ( barrier_chunks[ i ].origin == barrier_chunks[ i ].og_origin )
                    {
                        array[ array.size ] = barrier_chunks[ i ];
                    }
                }
            }
        }
    }
    
    if ( array.size == 0 )
    {
        return undefined;
    }
    
    return array;
}

// Namespace zm_utility
// Params 2
// Checksum 0x6524e5fe, Offset: 0x7328
// Size: 0x102
function get_non_destroyed_chunks_grate( barrier, barrier_chunks )
{
    if ( isdefined( barrier.zbarrier ) )
    {
        return barrier.zbarrier getzbarrierpieceindicesinstate( "closed" );
    }
    
    array = [];
    
    for ( i = 0; i < barrier_chunks.size ; i++ )
    {
        if ( isdefined( barrier_chunks[ i ].script_parameters ) && barrier_chunks[ i ].script_parameters == "grate" )
        {
            if ( isdefined( barrier_chunks[ i ] ) )
            {
                array[ array.size ] = barrier_chunks[ i ];
            }
        }
    }
    
    if ( array.size == 0 )
    {
        return undefined;
    }
    
    return array;
}

// Namespace zm_utility
// Params 1
// Checksum 0x9babeda9, Offset: 0x7438
// Size: 0xbc
function get_non_destroyed_variant1( barrier_chunks )
{
    array = [];
    
    for ( i = 0; i < barrier_chunks.size ; i++ )
    {
        if ( isdefined( barrier_chunks[ i ].script_team ) && barrier_chunks[ i ].script_team == "bar_board_variant1" )
        {
            if ( isdefined( barrier_chunks[ i ] ) )
            {
                array[ array.size ] = barrier_chunks[ i ];
            }
        }
    }
    
    if ( array.size == 0 )
    {
        return undefined;
    }
    
    return array;
}

// Namespace zm_utility
// Params 1
// Checksum 0x8aeb0e58, Offset: 0x7500
// Size: 0xbc
function get_non_destroyed_variant2( barrier_chunks )
{
    array = [];
    
    for ( i = 0; i < barrier_chunks.size ; i++ )
    {
        if ( isdefined( barrier_chunks[ i ].script_team ) && barrier_chunks[ i ].script_team == "bar_board_variant2" )
        {
            if ( isdefined( barrier_chunks[ i ] ) )
            {
                array[ array.size ] = barrier_chunks[ i ];
            }
        }
    }
    
    if ( array.size == 0 )
    {
        return undefined;
    }
    
    return array;
}

// Namespace zm_utility
// Params 1
// Checksum 0x6cef1237, Offset: 0x75c8
// Size: 0xbc
function get_non_destroyed_variant4( barrier_chunks )
{
    array = [];
    
    for ( i = 0; i < barrier_chunks.size ; i++ )
    {
        if ( isdefined( barrier_chunks[ i ].script_team ) && barrier_chunks[ i ].script_team == "bar_board_variant4" )
        {
            if ( isdefined( barrier_chunks[ i ] ) )
            {
                array[ array.size ] = barrier_chunks[ i ];
            }
        }
    }
    
    if ( array.size == 0 )
    {
        return undefined;
    }
    
    return array;
}

// Namespace zm_utility
// Params 1
// Checksum 0x58156e91, Offset: 0x7690
// Size: 0xbc
function get_non_destroyed_variant5( barrier_chunks )
{
    array = [];
    
    for ( i = 0; i < barrier_chunks.size ; i++ )
    {
        if ( isdefined( barrier_chunks[ i ].script_team ) && barrier_chunks[ i ].script_team == "bar_board_variant5" )
        {
            if ( isdefined( barrier_chunks[ i ] ) )
            {
                array[ array.size ] = barrier_chunks[ i ];
            }
        }
    }
    
    if ( array.size == 0 )
    {
        return undefined;
    }
    
    return array;
}

// Namespace zm_utility
// Params 1
// Checksum 0x8872f7b1, Offset: 0x7758
// Size: 0x1e0
function get_destroyed_chunks( barrier_chunks )
{
    array = [];
    
    for ( i = 0; i < barrier_chunks.size ; i++ )
    {
        if ( barrier_chunks[ i ] get_chunk_state() == "destroyed" )
        {
            if ( isdefined( barrier_chunks[ i ].script_parameters ) && barrier_chunks[ i ].script_parameters == "board" )
            {
                array[ array.size ] = barrier_chunks[ i ];
                continue;
            }
            
            if ( isdefined( barrier_chunks[ i ].script_parameters ) && barrier_chunks[ i ].script_parameters == "repair_board" || barrier_chunks[ i ].script_parameters == "barricade_vents" )
            {
                array[ array.size ] = barrier_chunks[ i ];
                continue;
            }
            
            if ( isdefined( barrier_chunks[ i ].script_parameters ) && barrier_chunks[ i ].script_parameters == "bar" )
            {
                array[ array.size ] = barrier_chunks[ i ];
                continue;
            }
            
            if ( isdefined( barrier_chunks[ i ].script_parameters ) && barrier_chunks[ i ].script_parameters == "grate" )
            {
                return undefined;
            }
        }
    }
    
    if ( array.size == 0 )
    {
        return undefined;
    }
    
    return array;
}

// Namespace zm_utility
// Params 1
// Checksum 0x426b91ca, Offset: 0x7940
// Size: 0x59a
function grate_order_destroyed( chunks_repair_grate )
{
    grate_repair_order = [];
    grate_repair_order1 = [];
    grate_repair_order2 = [];
    grate_repair_order3 = [];
    grate_repair_order4 = [];
    grate_repair_order5 = [];
    grate_repair_order6 = [];
    
    for ( i = 0; i < chunks_repair_grate.size ; i++ )
    {
        if ( isdefined( chunks_repair_grate[ i ].script_parameters ) && chunks_repair_grate[ i ].script_parameters == "grate" )
        {
            if ( isdefined( chunks_repair_grate[ i ].script_noteworthy ) && chunks_repair_grate[ i ].script_noteworthy == "1" )
            {
                grate_repair_order1[ grate_repair_order1.size ] = chunks_repair_grate[ i ];
            }
            
            if ( isdefined( chunks_repair_grate[ i ].script_noteworthy ) && chunks_repair_grate[ i ].script_noteworthy == "2" )
            {
                grate_repair_order2[ grate_repair_order2.size ] = chunks_repair_grate[ i ];
            }
            
            if ( isdefined( chunks_repair_grate[ i ].script_noteworthy ) && chunks_repair_grate[ i ].script_noteworthy == "3" )
            {
                grate_repair_order3[ grate_repair_order3.size ] = chunks_repair_grate[ i ];
            }
            
            if ( isdefined( chunks_repair_grate[ i ].script_noteworthy ) && chunks_repair_grate[ i ].script_noteworthy == "4" )
            {
                grate_repair_order4[ grate_repair_order4.size ] = chunks_repair_grate[ i ];
            }
            
            if ( isdefined( chunks_repair_grate[ i ].script_noteworthy ) && chunks_repair_grate[ i ].script_noteworthy == "5" )
            {
                grate_repair_order5[ grate_repair_order5.size ] = chunks_repair_grate[ i ];
            }
            
            if ( isdefined( chunks_repair_grate[ i ].script_noteworthy ) && chunks_repair_grate[ i ].script_noteworthy == "6" )
            {
                grate_repair_order6[ grate_repair_order6.size ] = chunks_repair_grate[ i ];
            }
        }
    }
    
    for ( i = 0; i < chunks_repair_grate.size ; i++ )
    {
        if ( isdefined( chunks_repair_grate[ i ].script_parameters ) && chunks_repair_grate[ i ].script_parameters == "grate" )
        {
            if ( isdefined( grate_repair_order1[ i ] ) )
            {
                if ( grate_repair_order6[ i ].state == "destroyed" )
                {
                    /#
                        iprintlnbold( "<dev string:xdc>" );
                    #/
                    
                    return grate_repair_order6[ i ];
                }
                
                if ( grate_repair_order5[ i ].state == "destroyed" )
                {
                    /#
                        iprintlnbold( "<dev string:xe9>" );
                    #/
                    
                    grate_repair_order6[ i ] thread show_grate_repair();
                    return grate_repair_order5[ i ];
                }
                
                if ( grate_repair_order4[ i ].state == "destroyed" )
                {
                    /#
                        iprintlnbold( "<dev string:xf6>" );
                    #/
                    
                    grate_repair_order5[ i ] thread show_grate_repair();
                    return grate_repair_order4[ i ];
                }
                
                if ( grate_repair_order3[ i ].state == "destroyed" )
                {
                    /#
                        iprintlnbold( "<dev string:x103>" );
                    #/
                    
                    grate_repair_order4[ i ] thread show_grate_repair();
                    return grate_repair_order3[ i ];
                }
                
                if ( grate_repair_order2[ i ].state == "destroyed" )
                {
                    /#
                        iprintlnbold( "<dev string:x110>" );
                    #/
                    
                    grate_repair_order3[ i ] thread show_grate_repair();
                    return grate_repair_order2[ i ];
                }
                
                if ( grate_repair_order1[ i ].state == "destroyed" )
                {
                    /#
                        iprintlnbold( "<dev string:x11d>" );
                    #/
                    
                    grate_repair_order2[ i ] thread show_grate_repair();
                    return grate_repair_order1[ i ];
                }
            }
        }
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0xda45ef16, Offset: 0x7ee8
// Size: 0x24
function show_grate_repair()
{
    wait 0.34;
    self hide();
}

// Namespace zm_utility
// Params 0
// Checksum 0x4a8d599a, Offset: 0x7f18
// Size: 0x2a
function get_chunk_state()
{
    assert( isdefined( self.state ) );
    return self.state;
}

// Namespace zm_utility
// Params 2
// Checksum 0x64f48742, Offset: 0x7f50
// Size: 0x78
function array_limiter( array, total )
{
    new_array = [];
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( i < total )
        {
            new_array[ new_array.size ] = array[ i ];
        }
    }
    
    return new_array;
}

// Namespace zm_utility
// Params 2
// Checksum 0x698c9034, Offset: 0x7fd0
// Size: 0x158
function fake_physicslaunch( target_pos, power )
{
    start_pos = self.origin;
    gravity = getdvarint( "bg_gravity" ) * -1;
    dist = distance( start_pos, target_pos );
    time = dist / power;
    delta = target_pos - start_pos;
    drop = 0.5 * gravity * time * time;
    velocity = ( delta[ 0 ] / time, delta[ 1 ] / time, ( delta[ 2 ] - drop ) / time );
    level thread draw_line_ent_to_pos( self, target_pos );
    self movegravity( velocity, time );
    return time;
}

// Namespace zm_utility
// Params 2
// Checksum 0x4cb6cfea, Offset: 0x8130
// Size: 0x3e
function add_zombie_hint( ref, text )
{
    if ( !isdefined( level.zombie_hints ) )
    {
        level.zombie_hints = [];
    }
    
    level.zombie_hints[ ref ] = text;
}

// Namespace zm_utility
// Params 1
// Checksum 0xa997923d, Offset: 0x8178
// Size: 0x64
function get_zombie_hint( ref )
{
    if ( isdefined( level.zombie_hints[ ref ] ) )
    {
        return level.zombie_hints[ ref ];
    }
    
    println( "<dev string:x12a>" + ref );
    return level.zombie_hints[ "undefined" ];
}

// Namespace zm_utility
// Params 3
// Checksum 0x74c84254, Offset: 0x81e8
// Size: 0x114
function set_hint_string( ent, default_ref, cost )
{
    ref = default_ref;
    
    if ( isdefined( ent.script_hint ) )
    {
        ref = ent.script_hint;
    }
    
    if ( isdefined( level.legacy_hint_system ) && level.legacy_hint_system )
    {
        ref = ref + "_" + cost;
        self sethintstring( get_zombie_hint( ref ) );
        return;
    }
    
    hint = get_zombie_hint( ref );
    
    if ( isdefined( cost ) )
    {
        self sethintstring( hint, cost );
        return;
    }
    
    self sethintstring( hint );
}

// Namespace zm_utility
// Params 3
// Checksum 0x3aecf710, Offset: 0x8308
// Size: 0xa2
function get_hint_string( ent, default_ref, cost )
{
    ref = default_ref;
    
    if ( isdefined( ent.script_hint ) )
    {
        ref = ent.script_hint;
    }
    
    if ( isdefined( level.legacy_hint_system ) && level.legacy_hint_system && isdefined( cost ) )
    {
        ref = ref + "_" + cost;
    }
    
    return get_zombie_hint( ref );
}

// Namespace zm_utility
// Params 3
// Checksum 0xe2ae1476, Offset: 0x83b8
// Size: 0x1ca
function unitrigger_set_hint_string( ent, default_ref, cost )
{
    triggers = [];
    
    if ( self.trigger_per_player )
    {
        triggers = self.playertrigger;
    }
    else
    {
        triggers[ 0 ] = self.trigger;
    }
    
    foreach ( trigger in triggers )
    {
        ref = default_ref;
        
        if ( isdefined( ent.script_hint ) )
        {
            ref = ent.script_hint;
        }
        
        if ( isdefined( level.legacy_hint_system ) && level.legacy_hint_system )
        {
            ref = ref + "_" + cost;
            trigger sethintstring( get_zombie_hint( ref ) );
            continue;
        }
        
        hint = get_zombie_hint( ref );
        
        if ( isdefined( cost ) )
        {
            trigger sethintstring( hint, cost );
            continue;
        }
        
        trigger sethintstring( hint );
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0x46de2bfd, Offset: 0x8590
// Size: 0x3e
function add_sound( ref, alias )
{
    if ( !isdefined( level.zombie_sounds ) )
    {
        level.zombie_sounds = [];
    }
    
    level.zombie_sounds[ ref ] = alias;
}

// Namespace zm_utility
// Params 3
// Checksum 0x2fdea1cc, Offset: 0x85d8
// Size: 0xf4
function play_sound_at_pos( ref, pos, ent )
{
    if ( isdefined( ent ) )
    {
        if ( isdefined( ent.script_soundalias ) )
        {
            playsoundatposition( ent.script_soundalias, pos );
            return;
        }
        
        if ( isdefined( self.script_sound ) )
        {
            ref = self.script_sound;
        }
    }
    
    if ( ref == "none" )
    {
        return;
    }
    
    if ( !isdefined( level.zombie_sounds[ ref ] ) )
    {
        assertmsg( "<dev string:x146>" + ref + "<dev string:x14e>" );
        return;
    }
    
    playsoundatposition( level.zombie_sounds[ ref ], pos );
}

// Namespace zm_utility
// Params 1
// Checksum 0xf0cf55a, Offset: 0x86d8
// Size: 0xc4
function play_sound_on_ent( ref )
{
    if ( isdefined( self.script_soundalias ) )
    {
        self playsound( self.script_soundalias );
        return;
    }
    
    if ( isdefined( self.script_sound ) )
    {
        ref = self.script_sound;
    }
    
    if ( ref == "none" )
    {
        return;
    }
    
    if ( !isdefined( level.zombie_sounds[ ref ] ) )
    {
        assertmsg( "<dev string:x146>" + ref + "<dev string:x14e>" );
        return;
    }
    
    self playsound( level.zombie_sounds[ ref ] );
}

// Namespace zm_utility
// Params 1
// Checksum 0x774419bc, Offset: 0x87a8
// Size: 0x94
function play_loopsound_on_ent( ref )
{
    if ( isdefined( self.script_firefxsound ) )
    {
        ref = self.script_firefxsound;
    }
    
    if ( ref == "none" )
    {
        return;
    }
    
    if ( !isdefined( level.zombie_sounds[ ref ] ) )
    {
        assertmsg( "<dev string:x146>" + ref + "<dev string:x14e>" );
        return;
    }
    
    self playsound( level.zombie_sounds[ ref ] );
}

// Namespace zm_utility
// Params 1
// Checksum 0xce8c2bd, Offset: 0x8848
// Size: 0x132
function string_to_float( string )
{
    floatparts = strtok( string, "." );
    
    if ( floatparts.size == 1 )
    {
        return int( floatparts[ 0 ] );
    }
    
    whole = int( floatparts[ 0 ] );
    decimal = 0;
    
    for ( i = floatparts[ 1 ].size - 1; i >= 0 ; i-- )
    {
        decimal = decimal / 10 + int( floatparts[ 1 ][ i ] ) / 10;
    }
    
    if ( whole >= 0 )
    {
        return ( whole + decimal );
    }
    
    return whole - decimal;
}

// Namespace zm_utility
// Params 5
// Checksum 0x94956bd0, Offset: 0x8988
// Size: 0x10a
function set_zombie_var( zvar, value, is_float, column, is_team_based )
{
    if ( !isdefined( is_float ) )
    {
        is_float = 0;
    }
    
    if ( !isdefined( column ) )
    {
        column = 1;
    }
    
    if ( isdefined( is_team_based ) && is_team_based )
    {
        foreach ( team in level.teams )
        {
            level.zombie_vars[ team ][ zvar ] = value;
        }
    }
    else
    {
        level.zombie_vars[ zvar ] = value;
    }
    
    return value;
}

// Namespace zm_utility
// Params 5
// Checksum 0x97101071, Offset: 0x8aa0
// Size: 0xfc
function get_table_var( table, var_d45c761e, value, is_float, column )
{
    if ( !isdefined( table ) )
    {
        table = "mp/zombiemode.csv";
    }
    
    if ( !isdefined( is_float ) )
    {
        is_float = 0;
    }
    
    if ( !isdefined( column ) )
    {
        column = 1;
    }
    
    table_value = tablelookup( table, 0, var_d45c761e, column );
    
    if ( isdefined( table_value ) && table_value != "" )
    {
        if ( is_float )
        {
            value = string_to_float( table_value );
        }
        else
        {
            value = int( table_value );
        }
    }
    
    return value;
}

/#

    // Namespace zm_utility
    // Params 0
    // Checksum 0xcb454d51, Offset: 0x8ba8
    // Size: 0x98, Type: dev
    function hudelem_count()
    {
        max = 0;
        curr_total = 0;
        
        while ( true )
        {
            if ( level.hudelem_count > max )
            {
                max = level.hudelem_count;
            }
            
            println( "<dev string:x1b6>" + level.hudelem_count + "<dev string:x1c1>" + max + "<dev string:x1c9>" );
            wait 0.05;
        }
    }

    // Namespace zm_utility
    // Params 0
    // Checksum 0xb1d7b5f1, Offset: 0x8c48
    // Size: 0xa2, Type: dev
    function debug_round_advancer()
    {
        while ( true )
        {
            zombs = zombie_utility::get_round_enemy_array();
            
            for ( i = 0; i < zombs.size ; i++ )
            {
                zombs[ i ] dodamage( zombs[ i ].health + 666, ( 0, 0, 0 ) );
                wait 0.5;
            }
        }
    }

    // Namespace zm_utility
    // Params 1
    // Checksum 0xbf0283aa, Offset: 0x8cf8
    // Size: 0x60, Type: dev
    function print_run_speed( speed )
    {
        self endon( #"death" );
        
        while ( true )
        {
            print3d( self.origin + ( 0, 0, 64 ), speed, ( 1, 1, 1 ) );
            wait 0.05;
        }
    }

    // Namespace zm_utility
    // Params 2
    // Checksum 0x69de6cba, Offset: 0x8d60
    // Size: 0x98, Type: dev
    function draw_line_ent_to_ent( ent1, ent2 )
    {
        if ( getdvarint( "<dev string:x1cb>" ) != 1 )
        {
            return;
        }
        
        ent1 endon( #"death" );
        ent2 endon( #"death" );
        
        while ( true )
        {
            line( ent1.origin, ent2.origin );
            wait 0.05;
        }
    }

#/

// Namespace zm_utility
// Params 3
// Checksum 0x938e37e3, Offset: 0x8e00
// Size: 0xb8
function draw_line_ent_to_pos( ent, pos, end_on )
{
    /#
        if ( getdvarint( "<dev string:x1cb>" ) != 1 )
        {
            return;
        }
        
        ent endon( #"death" );
        ent notify( #"stop_draw_line_ent_to_pos" );
        ent endon( #"stop_draw_line_ent_to_pos" );
        
        if ( isdefined( end_on ) )
        {
            ent endon( end_on );
        }
        
        while ( true )
        {
            line( ent.origin, pos );
            wait 0.05;
        }
    #/
}

/#

    // Namespace zm_utility
    // Params 1
    // Checksum 0x3c45a5b4, Offset: 0x8ec0
    // Size: 0x54, Type: dev
    function debug_print( msg )
    {
        if ( getdvarint( "<dev string:x1cb>" ) > 0 )
        {
            println( "<dev string:x1d8>" + msg );
        }
    }

    // Namespace zm_utility
    // Params 3
    // Checksum 0x41c863b, Offset: 0x8f20
    // Size: 0x88, Type: dev
    function debug_blocker( pos, rad, height )
    {
        self notify( #"stop_debug_blocker" );
        self endon( #"stop_debug_blocker" );
        
        for ( ;; )
        {
            if ( getdvarint( "<dev string:x1cb>" ) != 1 )
            {
                return;
            }
            
            wait 0.05;
            drawcylinder( pos, rad, height );
        }
    }

    // Namespace zm_utility
    // Params 3
    // Checksum 0x39bbec13, Offset: 0x8fb0
    // Size: 0x25e, Type: dev
    function drawcylinder( pos, rad, height )
    {
        currad = rad;
        curheight = height;
        
        for ( r = 0; r < 20 ; r++ )
        {
            theta = r / 20 * 360;
            theta2 = ( r + 1 ) / 20 * 360;
            line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, 0 ) );
            line( pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, curheight ) );
            line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ) );
        }
    }

    // Namespace zm_utility
    // Params 4
    // Checksum 0x8c8147e9, Offset: 0x9218
    // Size: 0x98, Type: dev
    function print3d_at_pos( msg, pos, thread_endon, offset )
    {
        self endon( #"death" );
        
        if ( isdefined( thread_endon ) )
        {
            self notify( thread_endon );
            self endon( thread_endon );
        }
        
        if ( !isdefined( offset ) )
        {
            offset = ( 0, 0, 0 );
        }
        
        while ( true )
        {
            print3d( self.origin + offset, msg );
            wait 0.05;
        }
    }

    // Namespace zm_utility
    // Params 0
    // Checksum 0xaca53123, Offset: 0x92b8
    // Size: 0xc4, Type: dev
    function debug_breadcrumbs()
    {
        self endon( #"disconnect" );
        self notify( #"stop_debug_breadcrumbs" );
        self endon( #"stop_debug_breadcrumbs" );
        
        while ( true )
        {
            if ( getdvarint( "<dev string:x1cb>" ) != 1 )
            {
                wait 1;
                continue;
            }
            
            for ( i = 0; i < self.zombie_breadcrumbs.size ; i++ )
            {
                drawcylinder( self.zombie_breadcrumbs[ i ], 5, 5 );
            }
            
            wait 0.05;
        }
    }

    // Namespace zm_utility
    // Params 0
    // Checksum 0x23466137, Offset: 0x9388
    // Size: 0x170, Type: dev
    function debug_attack_spots_taken()
    {
        self notify( #"stop_debug_breadcrumbs" );
        self endon( #"stop_debug_breadcrumbs" );
        
        while ( true )
        {
            if ( getdvarint( "<dev string:x1cb>" ) != 2 )
            {
                wait 1;
                continue;
            }
            
            wait 0.05;
            count = 0;
            
            for ( i = 0; i < self.attack_spots_taken.size ; i++ )
            {
                if ( self.attack_spots_taken[ i ] )
                {
                    count++;
                    circle( self.attack_spots[ i ], 12, ( 1, 0, 0 ), 0, 1, 1 );
                    continue;
                }
                
                circle( self.attack_spots[ i ], 12, ( 0, 1, 0 ), 0, 1, 1 );
            }
            
            msg = "<dev string:x1eb>" + count + "<dev string:x1ec>" + self.attack_spots_taken.size;
            print3d( self.origin, msg );
        }
    }

    // Namespace zm_utility
    // Params 2
    // Checksum 0x2f509a1, Offset: 0x9500
    // Size: 0xb0, Type: dev
    function float_print3d( msg, time )
    {
        self endon( #"death" );
        time = gettime() + time * 1000;
        offset = ( 0, 0, 72 );
        
        while ( gettime() < time )
        {
            offset += ( 0, 0, 2 );
            print3d( self.origin + offset, msg, ( 1, 1, 1 ) );
            wait 0.05;
        }
    }

#/

// Namespace zm_utility
// Params 2
// Checksum 0x920ace36, Offset: 0x95b8
// Size: 0x110
function do_player_vo( snd, variation_count )
{
    index = get_player_index( self );
    sound = "zmb_vox_plr_" + index + "_" + snd;
    
    if ( isdefined( variation_count ) )
    {
        sound = sound + "_" + randomintrange( 0, variation_count );
    }
    
    if ( !isdefined( level.player_is_speaking ) )
    {
        level.player_is_speaking = 0;
    }
    
    if ( level.player_is_speaking == 0 )
    {
        level.player_is_speaking = 1;
        self playsoundwithnotify( sound, "sound_done" );
        self waittill( #"sound_done" );
        wait 2;
        level.player_is_speaking = 0;
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x77637776, Offset: 0x96d0
// Size: 0x3c, Type: bool
function is_magic_bullet_shield_enabled( ent )
{
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    return !( isdefined( ent.allowdeath ) && ent.allowdeath );
}

// Namespace zm_utility
// Params 1
// Checksum 0x832fb1df, Offset: 0x9718
// Size: 0x94
function really_play_2d_sound( sound )
{
    temp_ent = spawn( "script_origin", ( 0, 0, 0 ) );
    temp_ent playsoundwithnotify( sound, sound + "wait" );
    temp_ent waittill( sound + "wait" );
    wait 0.05;
    temp_ent delete();
}

// Namespace zm_utility
// Params 1
// Checksum 0xaa70bacb, Offset: 0x97b8
// Size: 0x24
function play_sound_2d( sound )
{
    level thread really_play_2d_sound( sound );
}

// Namespace zm_utility
// Params 2
// Checksum 0x84f5c297, Offset: 0x97e8
// Size: 0x6c
function include_weapon( weapon_name, in_box )
{
    println( "<dev string:x1f0>" + weapon_name );
    
    if ( !isdefined( in_box ) )
    {
        in_box = 1;
    }
    
    zm_weapons::include_zombie_weapon( weapon_name, in_box );
}

// Namespace zm_utility
// Params 1
// Checksum 0x3761078a, Offset: 0x9860
// Size: 0x86
function trigger_invisible( enable )
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

// Namespace zm_utility
// Params 6
// Checksum 0x438b81a2, Offset: 0x98f0
// Size: 0x130
function print3d_ent( text, color, scale, offset, end_msg, overwrite )
{
    self endon( #"death" );
    
    if ( isdefined( overwrite ) && overwrite && isdefined( self._debug_print3d_msg ) )
    {
        self notify( #"end_print3d" );
        wait 0.05;
    }
    
    self endon( #"end_print3d" );
    
    if ( !isdefined( color ) )
    {
        color = ( 1, 1, 1 );
    }
    
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    if ( isdefined( end_msg ) )
    {
        self endon( end_msg );
    }
    
    self._debug_print3d_msg = text;
    
    /#
        while ( !( isdefined( level.disable_print3d_ent ) && level.disable_print3d_ent ) )
        {
            print3d( self.origin + offset, self._debug_print3d_msg, color, scale );
            wait 0.05;
        }
    #/
}

// Namespace zm_utility
// Params 1
// Checksum 0xa9ad0278, Offset: 0x9a28
// Size: 0x108
function create_counter_hud( x )
{
    if ( !isdefined( x ) )
    {
        x = 0;
    }
    
    hud = create_simple_hud();
    hud.alignx = "left";
    hud.aligny = "top";
    hud.horzalign = "user_left";
    hud.vertalign = "user_top";
    hud.color = ( 1, 1, 1 );
    hud.fontscale = 32;
    hud.x = x;
    hud.alpha = 0;
    hud setshader( "hud_chalk_1", 64, 64 );
    return hud;
}

// Namespace zm_utility
// Params 1
// Checksum 0xa821e1a2, Offset: 0x9b38
// Size: 0x280
function get_current_zone( return_zone )
{
    level flag::wait_till( "zones_initialized" );
    
    if ( isdefined( self.cached_zone ) )
    {
        zone = self.cached_zone;
        zone_name = self.cached_zone_name;
        vol = self.cached_zone_volume;
        
        if ( self istouching( zone.volumes[ vol ] ) )
        {
            if ( isdefined( return_zone ) && return_zone )
            {
                return zone;
            }
            
            return zone_name;
        }
        
        for ( i = 0; i < zone.volumes.size ; i++ )
        {
            if ( i == vol )
            {
                continue;
            }
            
            if ( self istouching( zone.volumes[ i ] ) )
            {
                self.cached_zone = zone;
                self.cached_zone_volume = i;
                
                if ( isdefined( return_zone ) && return_zone )
                {
                    return zone;
                }
                
                return zone_name;
            }
        }
    }
    
    for ( z = 0; z < level.zone_keys.size ; z++ )
    {
        zone_name = level.zone_keys[ z ];
        zone = level.zones[ zone_name ];
        
        if ( zone === self.cached_zone )
        {
            continue;
        }
        
        for ( i = 0; i < zone.volumes.size ; i++ )
        {
            if ( self istouching( zone.volumes[ i ] ) )
            {
                self.cached_zone = zone;
                self.cached_zone_name = zone_name;
                self.cached_zone_volume = i;
                
                if ( isdefined( return_zone ) && return_zone )
                {
                    return zone;
                }
                
                return zone_name;
            }
        }
    }
    
    self.cached_zone = undefined;
    self.cached_zone_name = undefined;
    self.cached_zone_volume = undefined;
    return undefined;
}

// Namespace zm_utility
// Params 1
// Checksum 0x167e6505, Offset: 0x9dc0
// Size: 0x10
function remove_mod_from_methodofdeath( mod )
{
    return mod;
}

// Namespace zm_utility
// Params 0
// Checksum 0xeecd7496, Offset: 0x9dd8
// Size: 0x60
function clear_fog_threads()
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] notify( #"stop_fog" );
    }
}

// Namespace zm_utility
// Params 3
// Checksum 0xd9243e55, Offset: 0x9e40
// Size: 0xdc
function display_message( titletext, notifytext, duration )
{
    notifydata = spawnstruct();
    notifydata.titletext = notifytext;
    notifydata.notifytext = titletext;
    notifydata.sound = "mus_level_up";
    notifydata.duration = duration;
    notifydata.glowcolor = ( 1, 0, 0 );
    notifydata.color = ( 0, 0, 0 );
    notifydata.iconname = "hud_zombies_meat";
    self thread hud_message::notifymessage( notifydata );
}

// Namespace zm_utility
// Params 0
// Checksum 0x53276972, Offset: 0x9f28
// Size: 0x14, Type: bool
function is_quad()
{
    return self.animname == "quad_zombie";
}

// Namespace zm_utility
// Params 0
// Checksum 0xd24877f5, Offset: 0x9f48
// Size: 0x14, Type: bool
function is_leaper()
{
    return self.animname == "leaper_zombie";
}

// Namespace zm_utility
// Params 0
// Checksum 0x17591a5d, Offset: 0x9f68
// Size: 0x298
function shock_onpain()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self notify( #"stop_shock_onpain" );
    self endon( #"stop_shock_onpain" );
    
    if ( getdvarstring( "blurpain" ) == "" )
    {
        setdvar( "blurpain", "on" );
    }
    
    while ( true )
    {
        oldhealth = self.health;
        self waittill( #"damage", damage, attacker, direction_vec, point, mod );
        
        if ( isdefined( level.shock_onpain ) && !level.shock_onpain )
        {
            continue;
        }
        
        if ( isdefined( self.shock_onpain ) && !self.shock_onpain )
        {
            continue;
        }
        
        if ( self.health < 1 )
        {
            continue;
        }
        
        if ( isdefined( attacker ) && isdefined( attacker.custom_player_shellshock ) )
        {
            self [[ attacker.custom_player_shellshock ]]( damage, attacker, direction_vec, point, mod );
            continue;
        }
        
        if ( mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" )
        {
            continue;
        }
        
        if ( mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_EXPLOSIVE" )
        {
            shocktype = undefined;
            shocklight = undefined;
            
            if ( isdefined( self.is_burning ) && self.is_burning )
            {
                shocktype = "lava";
                shocklight = "lava_small";
            }
            
            self shock_onexplosion( damage, shocktype, shocklight );
            continue;
        }
        
        if ( getdvarstring( "blurpain" ) == "on" )
        {
            self shellshock( "pain_zm", 0.5 );
        }
    }
}

// Namespace zm_utility
// Params 3
// Checksum 0xb5f5df13, Offset: 0xa208
// Size: 0x11c
function shock_onexplosion( damage, shocktype, shocklight )
{
    time = 0;
    scaled_damage = 100 * damage / self.maxhealth;
    
    if ( scaled_damage >= 90 )
    {
        time = 4;
    }
    else if ( scaled_damage >= 50 )
    {
        time = 3;
    }
    else if ( scaled_damage >= 25 )
    {
        time = 2;
    }
    else if ( scaled_damage > 10 )
    {
        time = 1;
    }
    
    if ( time )
    {
        if ( !isdefined( shocktype ) )
        {
            shocktype = "explosion";
        }
        
        self shellshock( shocktype, time );
        return;
    }
    
    if ( isdefined( shocklight ) )
    {
        self shellshock( shocklight, time );
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0x321259fe, Offset: 0xa330
// Size: 0x38
function increment_ignoreme()
{
    if ( !isdefined( self.ignorme_count ) )
    {
        self.ignorme_count = 0;
    }
    
    self.ignorme_count++;
    self.ignoreme = self.ignorme_count > 0;
}

// Namespace zm_utility
// Params 0
// Checksum 0xd00f29fa, Offset: 0xa370
// Size: 0x68
function decrement_ignoreme()
{
    if ( !isdefined( self.ignorme_count ) )
    {
        self.ignorme_count = 0;
    }
    
    if ( self.ignorme_count > 0 )
    {
        self.ignorme_count--;
    }
    else
    {
        assertmsg( "<dev string:x208>" );
    }
    
    self.ignoreme = self.ignorme_count > 0;
}

// Namespace zm_utility
// Params 0
// Checksum 0x34f04fb1, Offset: 0xa3e0
// Size: 0x84
function increment_is_drinking()
{
    /#
        if ( isdefined( level.devgui_dpad_watch ) && level.devgui_dpad_watch )
        {
            self.is_drinking++;
            return;
        }
    #/
    
    if ( !isdefined( self.is_drinking ) )
    {
        self.is_drinking = 0;
    }
    
    if ( self.is_drinking == 0 )
    {
        self disableoffhandweapons();
        self disableweaponcycling();
    }
    
    self.is_drinking++;
}

// Namespace zm_utility
// Params 0
// Checksum 0xfee42f54, Offset: 0xa470
// Size: 0x10, Type: bool
function is_multiple_drinking()
{
    return self.is_drinking > 1;
}

// Namespace zm_utility
// Params 0
// Checksum 0xaaa24c8, Offset: 0xa488
// Size: 0x74
function decrement_is_drinking()
{
    if ( self.is_drinking > 0 )
    {
        self.is_drinking--;
    }
    else
    {
        assertmsg( "<dev string:x229>" );
    }
    
    if ( self.is_drinking == 0 )
    {
        self enableoffhandweapons();
        self enableweaponcycling();
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0xf2506f3c, Offset: 0xa508
// Size: 0x3c
function clear_is_drinking()
{
    self.is_drinking = 0;
    self enableoffhandweapons();
    self enableweaponcycling();
}

// Namespace zm_utility
// Params 0
// Checksum 0x3c0cabfc, Offset: 0xa550
// Size: 0x38
function increment_no_end_game_check()
{
    if ( !isdefined( level.n_no_end_game_check_count ) )
    {
        level.n_no_end_game_check_count = 0;
    }
    
    level.n_no_end_game_check_count++;
    level.no_end_game_check = level.n_no_end_game_check_count > 0;
}

// Namespace zm_utility
// Params 0
// Checksum 0xc823487f, Offset: 0xa590
// Size: 0x84
function decrement_no_end_game_check()
{
    if ( !isdefined( level.n_no_end_game_check_count ) )
    {
        level.n_no_end_game_check_count = 0;
    }
    
    if ( level.n_no_end_game_check_count > 0 )
    {
        level.n_no_end_game_check_count--;
    }
    else
    {
        assertmsg( "<dev string:x248>" );
    }
    
    level.no_end_game_check = level.n_no_end_game_check_count > 0;
    
    if ( !level.no_end_game_check )
    {
        level zm::checkforalldead();
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x49129836, Offset: 0xa620
// Size: 0xfe
function getweaponclasszm( weapon )
{
    assert( isdefined( weapon ) );
    
    if ( !isdefined( weapon ) )
    {
        return undefined;
    }
    
    if ( !isdefined( level.weaponclassarray ) )
    {
        level.weaponclassarray = [];
    }
    
    if ( isdefined( level.weaponclassarray[ weapon ] ) )
    {
        return level.weaponclassarray[ weapon ];
    }
    
    baseweaponindex = getbaseweaponitemindex( weapon );
    statstablename = util::getstatstablename();
    weaponclass = tablelookup( statstablename, 0, baseweaponindex, 2 );
    level.weaponclassarray[ weapon ] = weaponclass;
    return weaponclass;
}

// Namespace zm_utility
// Params 5
// Checksum 0xe3ca3e64, Offset: 0xa728
// Size: 0xe0
function spawn_weapon_model( weapon, model, origin, angles, options )
{
    if ( !isdefined( model ) )
    {
        model = weapon.worldmodel;
    }
    
    weapon_model = spawn( "script_model", origin );
    
    if ( isdefined( angles ) )
    {
        weapon_model.angles = angles;
    }
    
    if ( isdefined( options ) )
    {
        weapon_model useweaponmodel( weapon, model, options );
    }
    else
    {
        weapon_model useweaponmodel( weapon, model );
    }
    
    return weapon_model;
}

// Namespace zm_utility
// Params 5
// Checksum 0x55a91752, Offset: 0xa810
// Size: 0xf8
function spawn_buildkit_weapon_model( player, weapon, camo, origin, angles )
{
    weapon_model = spawn( "script_model", origin );
    
    if ( isdefined( angles ) )
    {
        weapon_model.angles = angles;
    }
    
    upgraded = zm_weapons::is_weapon_upgraded( weapon );
    
    if ( !isdefined( camo ) || upgraded && 0 > camo )
    {
        camo = zm_weapons::get_pack_a_punch_camo_index( undefined );
    }
    
    weapon_model usebuildkitweaponmodel( player, weapon, camo, upgraded );
    return weapon_model;
}

// Namespace zm_utility
// Params 1
// Checksum 0x1976a915, Offset: 0xa910
// Size: 0x34, Type: bool
function is_player_revive_tool( weapon )
{
    if ( weapon == level.weaponrevivetool || weapon === self.weaponrevivetool )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_utility
// Params 1
// Checksum 0xdb3e9b7d, Offset: 0xa950
// Size: 0x32, Type: bool
function is_limited_weapon( weapon )
{
    if ( isdefined( level.limited_weapons ) && isdefined( level.limited_weapons[ weapon ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_utility
// Params 1
// Checksum 0x2e67d168, Offset: 0xa990
// Size: 0x72
function register_lethal_grenade_for_level( weaponname )
{
    weapon = getweapon( weaponname );
    
    if ( is_lethal_grenade( weapon ) )
    {
        return;
    }
    
    if ( !isdefined( level.zombie_lethal_grenade_list ) )
    {
        level.zombie_lethal_grenade_list = [];
    }
    
    level.zombie_lethal_grenade_list[ weapon ] = weapon;
}

// Namespace zm_utility
// Params 1
// Checksum 0xbaa63134, Offset: 0xaa10
// Size: 0x3a, Type: bool
function is_lethal_grenade( weapon )
{
    if ( !isdefined( weapon ) || !isdefined( level.zombie_lethal_grenade_list ) )
    {
        return false;
    }
    
    return isdefined( level.zombie_lethal_grenade_list[ weapon ] );
}

// Namespace zm_utility
// Params 1
// Checksum 0x87fac3b8, Offset: 0xaa58
// Size: 0x38, Type: bool
function is_player_lethal_grenade( weapon )
{
    if ( !isdefined( weapon ) || !isdefined( self.current_lethal_grenade ) )
    {
        return false;
    }
    
    return self.current_lethal_grenade == weapon;
}

// Namespace zm_utility
// Params 0
// Checksum 0xa7a4e84b, Offset: 0xaa98
// Size: 0x34
function get_player_lethal_grenade()
{
    grenade = level.weaponnone;
    
    if ( isdefined( self.current_lethal_grenade ) )
    {
        grenade = self.current_lethal_grenade;
    }
    
    return grenade;
}

// Namespace zm_utility
// Params 1
// Checksum 0x314245a1, Offset: 0xaad8
// Size: 0x44
function set_player_lethal_grenade( weapon )
{
    if ( !isdefined( weapon ) )
    {
        weapon = level.weaponnone;
    }
    
    self notify( #"new_lethal_grenade", weapon );
    self.current_lethal_grenade = weapon;
}

// Namespace zm_utility
// Params 0
// Checksum 0x3f485972, Offset: 0xab28
// Size: 0x24
function init_player_lethal_grenade()
{
    self set_player_lethal_grenade( level.zombie_lethal_grenade_player_init );
}

// Namespace zm_utility
// Params 1
// Checksum 0x3075fda5, Offset: 0xab58
// Size: 0x72
function register_tactical_grenade_for_level( weaponname )
{
    weapon = getweapon( weaponname );
    
    if ( is_tactical_grenade( weapon ) )
    {
        return;
    }
    
    if ( !isdefined( level.zombie_tactical_grenade_list ) )
    {
        level.zombie_tactical_grenade_list = [];
    }
    
    level.zombie_tactical_grenade_list[ weapon ] = weapon;
}

// Namespace zm_utility
// Params 1
// Checksum 0xcb2f886c, Offset: 0xabd8
// Size: 0x3a, Type: bool
function is_tactical_grenade( weapon )
{
    if ( !isdefined( weapon ) || !isdefined( level.zombie_tactical_grenade_list ) )
    {
        return false;
    }
    
    return isdefined( level.zombie_tactical_grenade_list[ weapon ] );
}

// Namespace zm_utility
// Params 1
// Checksum 0xdb30e9bc, Offset: 0xac20
// Size: 0x38, Type: bool
function is_player_tactical_grenade( weapon )
{
    if ( !isdefined( weapon ) || !isdefined( self.current_tactical_grenade ) )
    {
        return false;
    }
    
    return self.current_tactical_grenade == weapon;
}

// Namespace zm_utility
// Params 0
// Checksum 0x7b3374d3, Offset: 0xac60
// Size: 0x34
function get_player_tactical_grenade()
{
    tactical = level.weaponnone;
    
    if ( isdefined( self.current_tactical_grenade ) )
    {
        tactical = self.current_tactical_grenade;
    }
    
    return tactical;
}

// Namespace zm_utility
// Params 1
// Checksum 0xf3e99c57, Offset: 0xaca0
// Size: 0x44
function set_player_tactical_grenade( weapon )
{
    if ( !isdefined( weapon ) )
    {
        weapon = level.weaponnone;
    }
    
    self notify( #"new_tactical_grenade", weapon );
    self.current_tactical_grenade = weapon;
}

// Namespace zm_utility
// Params 0
// Checksum 0xf6865152, Offset: 0xacf0
// Size: 0x24
function init_player_tactical_grenade()
{
    self set_player_tactical_grenade( level.zombie_tactical_grenade_player_init );
}

// Namespace zm_utility
// Params 1
// Checksum 0x3076f4e7, Offset: 0xad20
// Size: 0x5e, Type: bool
function is_placeable_mine( weapon )
{
    if ( !isdefined( level.placeable_mines ) )
    {
        level.placeable_mines = [];
    }
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone )
    {
        return false;
    }
    
    return isdefined( level.placeable_mines[ weapon.name ] );
}

// Namespace zm_utility
// Params 1
// Checksum 0x8faec420, Offset: 0xad88
// Size: 0x38, Type: bool
function is_player_placeable_mine( weapon )
{
    if ( !isdefined( weapon ) || !isdefined( self.current_placeable_mine ) )
    {
        return false;
    }
    
    return self.current_placeable_mine == weapon;
}

// Namespace zm_utility
// Params 0
// Checksum 0x9d9c64a4, Offset: 0xadc8
// Size: 0x34
function get_player_placeable_mine()
{
    placeable_mine = level.weaponnone;
    
    if ( isdefined( self.current_placeable_mine ) )
    {
        placeable_mine = self.current_placeable_mine;
    }
    
    return placeable_mine;
}

// Namespace zm_utility
// Params 1
// Checksum 0xe594bb88, Offset: 0xae08
// Size: 0x44
function set_player_placeable_mine( weapon )
{
    if ( !isdefined( weapon ) )
    {
        weapon = level.weaponnone;
    }
    
    self notify( #"new_placeable_mine", weapon );
    self.current_placeable_mine = weapon;
}

// Namespace zm_utility
// Params 0
// Checksum 0xc843f04a, Offset: 0xae58
// Size: 0x24
function init_player_placeable_mine()
{
    self set_player_placeable_mine( level.zombie_placeable_mine_player_init );
}

// Namespace zm_utility
// Params 1
// Checksum 0x25eb73c1, Offset: 0xae88
// Size: 0x72
function register_melee_weapon_for_level( weaponname )
{
    weapon = getweapon( weaponname );
    
    if ( is_melee_weapon( weapon ) )
    {
        return;
    }
    
    if ( !isdefined( level.zombie_melee_weapon_list ) )
    {
        level.zombie_melee_weapon_list = [];
    }
    
    level.zombie_melee_weapon_list[ weapon ] = weapon;
}

// Namespace zm_utility
// Params 1
// Checksum 0x3aef87f7, Offset: 0xaf08
// Size: 0x5a, Type: bool
function is_melee_weapon( weapon )
{
    if ( !isdefined( weapon ) || !isdefined( level.zombie_melee_weapon_list ) || weapon == getweapon( "none" ) )
    {
        return false;
    }
    
    return isdefined( level.zombie_melee_weapon_list[ weapon ] );
}

// Namespace zm_utility
// Params 1
// Checksum 0x421f7eab, Offset: 0xaf70
// Size: 0x38, Type: bool
function is_player_melee_weapon( weapon )
{
    if ( !isdefined( weapon ) || !isdefined( self.current_melee_weapon ) )
    {
        return false;
    }
    
    return self.current_melee_weapon == weapon;
}

// Namespace zm_utility
// Params 0
// Checksum 0x58b74a10, Offset: 0xafb0
// Size: 0x34
function get_player_melee_weapon()
{
    melee_weapon = level.weaponnone;
    
    if ( isdefined( self.current_melee_weapon ) )
    {
        melee_weapon = self.current_melee_weapon;
    }
    
    return melee_weapon;
}

// Namespace zm_utility
// Params 1
// Checksum 0x32098dde, Offset: 0xaff0
// Size: 0x44
function set_player_melee_weapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        weapon = level.weaponnone;
    }
    
    self notify( #"new_melee_weapon", weapon );
    self.current_melee_weapon = weapon;
}

// Namespace zm_utility
// Params 0
// Checksum 0xd052b66b, Offset: 0xb040
// Size: 0x24
function init_player_melee_weapon()
{
    self set_player_melee_weapon( level.zombie_melee_weapon_player_init );
}

// Namespace zm_utility
// Params 1
// Checksum 0xdf6ef51f, Offset: 0xb070
// Size: 0x72
function register_hero_weapon_for_level( weaponname )
{
    weapon = getweapon( weaponname );
    
    if ( is_hero_weapon( weapon ) )
    {
        return;
    }
    
    if ( !isdefined( level.zombie_hero_weapon_list ) )
    {
        level.zombie_hero_weapon_list = [];
    }
    
    level.zombie_hero_weapon_list[ weapon ] = weapon;
}

// Namespace zm_utility
// Params 1
// Checksum 0xdac8d68d, Offset: 0xb0f0
// Size: 0x3a, Type: bool
function is_hero_weapon( weapon )
{
    if ( !isdefined( weapon ) || !isdefined( level.zombie_hero_weapon_list ) )
    {
        return false;
    }
    
    return isdefined( level.zombie_hero_weapon_list[ weapon ] );
}

// Namespace zm_utility
// Params 1
// Checksum 0x43b50a3e, Offset: 0xb138
// Size: 0x38, Type: bool
function is_player_hero_weapon( weapon )
{
    if ( !isdefined( weapon ) || !isdefined( self.current_hero_weapon ) )
    {
        return false;
    }
    
    return self.current_hero_weapon == weapon;
}

// Namespace zm_utility
// Params 0
// Checksum 0x928fb102, Offset: 0xb178
// Size: 0x34
function get_player_hero_weapon()
{
    hero_weapon = level.weaponnone;
    
    if ( isdefined( self.current_hero_weapon ) )
    {
        hero_weapon = self.current_hero_weapon;
    }
    
    return hero_weapon;
}

// Namespace zm_utility
// Params 1
// Checksum 0x2811ddf1, Offset: 0xb1b8
// Size: 0x44
function set_player_hero_weapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        weapon = level.weaponnone;
    }
    
    self notify( #"new_hero_weapon", weapon );
    self.current_hero_weapon = weapon;
}

// Namespace zm_utility
// Params 0
// Checksum 0x8f6dd68, Offset: 0xb208
// Size: 0x24
function init_player_hero_weapon()
{
    self set_player_hero_weapon( level.zombie_hero_weapon_player_init );
}

// Namespace zm_utility
// Params 0
// Checksum 0xb45db9d9, Offset: 0xb238
// Size: 0x20, Type: bool
function has_player_hero_weapon()
{
    return isdefined( self.current_hero_weapon ) && self.current_hero_weapon != level.weaponnone;
}

// Namespace zm_utility
// Params 0
// Checksum 0xf013c31f, Offset: 0xb260
// Size: 0x16, Type: bool
function should_watch_for_emp()
{
    return isdefined( level.should_watch_for_emp ) && level.should_watch_for_emp;
}

// Namespace zm_utility
// Params 0
// Checksum 0xf4ca890a, Offset: 0xb280
// Size: 0xde
function register_offhand_weapons_for_level_defaults()
{
    if ( isdefined( level.register_offhand_weapons_for_level_defaults_override ) )
    {
        [[ level.register_offhand_weapons_for_level_defaults_override ]]();
        return;
    }
    
    register_lethal_grenade_for_level( "frag_grenade" );
    level.zombie_lethal_grenade_player_init = getweapon( "frag_grenade" );
    register_tactical_grenade_for_level( "cymbal_monkey" );
    level.zombie_tactical_grenade_player_init = undefined;
    level.zombie_placeable_mine_player_init = undefined;
    register_melee_weapon_for_level( "knife" );
    register_melee_weapon_for_level( "bowie_knife" );
    level.zombie_melee_weapon_player_init = getweapon( "knife" );
    level.zombie_equipment_player_init = undefined;
}

// Namespace zm_utility
// Params 0
// Checksum 0x40aac220, Offset: 0xb368
// Size: 0x64
function init_player_offhand_weapons()
{
    init_player_lethal_grenade();
    init_player_tactical_grenade();
    init_player_placeable_mine();
    init_player_melee_weapon();
    init_player_hero_weapon();
    zm_equipment::init_player_equipment();
}

// Namespace zm_utility
// Params 1
// Checksum 0x75e67106, Offset: 0xb3d8
// Size: 0x9a, Type: bool
function is_offhand_weapon( weapon )
{
    return is_lethal_grenade( weapon ) || is_tactical_grenade( weapon ) || is_placeable_mine( weapon ) || is_melee_weapon( weapon ) || is_hero_weapon( weapon ) || zm_equipment::is_equipment( weapon );
}

// Namespace zm_utility
// Params 1
// Checksum 0x70299640, Offset: 0xb480
// Size: 0x9a, Type: bool
function is_player_offhand_weapon( weapon )
{
    return self is_player_lethal_grenade( weapon ) || self is_player_tactical_grenade( weapon ) || self is_player_placeable_mine( weapon ) || self is_player_melee_weapon( weapon ) || self is_player_hero_weapon( weapon ) || self zm_equipment::is_player_equipment( weapon );
}

// Namespace zm_utility
// Params 0
// Checksum 0xfac0b5f5, Offset: 0xb528
// Size: 0x16, Type: bool
function has_powerup_weapon()
{
    return isdefined( self.has_powerup_weapon ) && self.has_powerup_weapon;
}

// Namespace zm_utility
// Params 0
// Checksum 0x6159834e, Offset: 0xb548
// Size: 0x4a, Type: bool
function has_hero_weapon()
{
    weapon = self getcurrentweapon();
    return isdefined( weapon.isheroweapon ) && weapon.isheroweapon;
}

// Namespace zm_utility
// Params 1
// Checksum 0xd847e727, Offset: 0xb5a0
// Size: 0xec
function give_start_weapon( b_switch_weapon )
{
    if ( !isdefined( self.hascompletedsuperee ) )
    {
        self.hascompletedsuperee = self zm_stats::get_global_stat( "DARKOPS_GENESIS_SUPER_EE" ) > 0;
    }
    
    if ( self.hascompletedsuperee )
    {
        self zm_weapons::weapon_give( level.start_weapon, 0, 0, 1, 0 );
        self givemaxammo( level.start_weapon );
        self zm_weapons::weapon_give( level.super_ee_weapon, 0, 0, 1, b_switch_weapon );
        return;
    }
    
    self zm_weapons::weapon_give( level.start_weapon, 0, 0, 1, b_switch_weapon );
}

// Namespace zm_utility
// Params 1
// Checksum 0x3d902e2f, Offset: 0xb698
// Size: 0xa8
function array_flag_wait_any( flag_array )
{
    if ( !isdefined( level._array_flag_wait_any_calls ) )
    {
        level._n_array_flag_wait_any_calls = 0;
    }
    else
    {
        level._n_array_flag_wait_any_calls++;
    }
    
    str_condition = "array_flag_wait_call_" + level._n_array_flag_wait_any_calls;
    
    for ( index = 0; index < flag_array.size ; index++ )
    {
        level thread array_flag_wait_any_thread( flag_array[ index ], str_condition );
    }
    
    level waittill( str_condition );
}

// Namespace zm_utility
// Params 2
// Checksum 0x493e262d, Offset: 0xb748
// Size: 0x3e
function array_flag_wait_any_thread( flag_name, condition )
{
    level endon( condition );
    level flag::wait_till( flag_name );
    level notify( condition );
}

// Namespace zm_utility
// Params 1
// Checksum 0x8f520332, Offset: 0xb790
// Size: 0x3c
function groundpos( origin )
{
    return bullettrace( origin, origin + ( 0, 0, -100000 ), 0, self )[ "position" ];
}

// Namespace zm_utility
// Params 1
// Checksum 0x4dd6e24c, Offset: 0xb7d8
// Size: 0x44
function groundpos_ignore_water( origin )
{
    return bullettrace( origin, origin + ( 0, 0, -100000 ), 0, self, 1 )[ "position" ];
}

// Namespace zm_utility
// Params 1
// Checksum 0x3564daa1, Offset: 0xb828
// Size: 0x44
function groundpos_ignore_water_new( origin )
{
    return groundtrace( origin, origin + ( 0, 0, -100000 ), 0, self, 1 )[ "position" ];
}

// Namespace zm_utility
// Params 0
// Checksum 0xba0eb1ce, Offset: 0xb878
// Size: 0x24
function self_delete()
{
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x675b61e5, Offset: 0xb8a8
// Size: 0x4c
function ignore_triggers( timer )
{
    self endon( #"death" );
    self.ignoretriggers = 1;
    
    if ( isdefined( timer ) )
    {
        wait timer;
    }
    else
    {
        wait 0.5;
    }
    
    self.ignoretriggers = 0;
}

// Namespace zm_utility
// Params 2
// Checksum 0xa18a6731, Offset: 0xb900
// Size: 0x234
function giveachievement_wrapper( achievement, all_players )
{
    if ( achievement == "" )
    {
        return;
    }
    
    if ( isdefined( level.zm_disable_recording_stats ) && level.zm_disable_recording_stats )
    {
        return;
    }
    
    achievement_lower = tolower( achievement );
    global_counter = 0;
    
    if ( isdefined( all_players ) && all_players )
    {
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            players[ i ] giveachievement( achievement );
            has_achievement = 0;
            
            if ( !( isdefined( has_achievement ) && has_achievement ) )
            {
                global_counter++;
            }
            
            if ( issplitscreen() && i == 0 || !issplitscreen() )
            {
                if ( isdefined( level.achievement_sound_func ) )
                {
                    players[ i ] thread [[ level.achievement_sound_func ]]( achievement_lower );
                }
            }
        }
    }
    else
    {
        if ( !isplayer( self ) )
        {
            println( "<dev string:x273>" );
            return;
        }
        
        self giveachievement( achievement );
        has_achievement = 0;
        
        if ( !( isdefined( has_achievement ) && has_achievement ) )
        {
            global_counter++;
        }
        
        if ( isdefined( level.achievement_sound_func ) )
        {
            self thread [[ level.achievement_sound_func ]]( achievement_lower );
        }
    }
    
    if ( global_counter )
    {
        incrementcounter( "global_" + achievement_lower, global_counter );
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x82ef318d, Offset: 0xbb40
// Size: 0x42
function getyaw( org )
{
    angles = vectortoangles( org - self.origin );
    return angles[ 1 ];
}

// Namespace zm_utility
// Params 1
// Checksum 0xa7722fc5, Offset: 0xbb90
// Size: 0x74
function getyawtospot( spot )
{
    pos = spot;
    yaw = self.angles[ 1 ] - getyaw( pos );
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace zm_utility
// Params 0
// Checksum 0x6a0b3ff4, Offset: 0xbc10
// Size: 0x54
function disable_react()
{
    assert( isalive( self ), "<dev string:x2b3>" );
    self.a.disablereact = 1;
    self.allowreact = 0;
}

// Namespace zm_utility
// Params 0
// Checksum 0xc18fa75c, Offset: 0xbc70
// Size: 0x54
function enable_react()
{
    assert( isalive( self ), "<dev string:x2d6>" );
    self.a.disablereact = 0;
    self.allowreact = 1;
}

// Namespace zm_utility
// Params 1
// Checksum 0xeaa824b4, Offset: 0xbcd0
// Size: 0x30, Type: bool
function bullet_attack( type )
{
    if ( type == "MOD_PISTOL_BULLET" )
    {
        return true;
    }
    
    return type == "MOD_RIFLE_BULLET";
}

// Namespace zm_utility
// Params 0
// Checksum 0x8dae37b0, Offset: 0xbd08
// Size: 0xac
function pick_up()
{
    player = self.owner;
    self destroy_ent();
    clip_ammo = player getweaponammoclip( self.weapon );
    clip_max_ammo = self.weapon.clipsize;
    
    if ( clip_ammo < clip_max_ammo )
    {
        clip_ammo++;
    }
    
    player setweaponammoclip( self.weapon, clip_ammo );
}

// Namespace zm_utility
// Params 0
// Checksum 0x62ef756a, Offset: 0xbdc0
// Size: 0x1c
function destroy_ent()
{
    self delete();
}

// Namespace zm_utility
// Params 0
// Checksum 0x5d3c979f, Offset: 0xbde8
// Size: 0xa0
function waittill_not_moving()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"detonated" );
    level endon( #"game_ended" );
    
    if ( self.classname == "grenade" )
    {
        self waittill( #"stationary" );
        return;
    }
    
    for ( prevorigin = self.origin; true ; prevorigin = self.origin )
    {
        wait 0.15;
        
        if ( self.origin == prevorigin )
        {
            break;
        }
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0xaf310145, Offset: 0xbe90
// Size: 0x4a
function get_closest_player( org )
{
    players = [];
    players = getplayers();
    return arraygetclosest( org, players );
}

// Namespace zm_utility
// Params 0
// Checksum 0x1b75b86b, Offset: 0xbee8
// Size: 0xa6
function ent_flag_init_ai_standards()
{
    message_array = [];
    message_array[ message_array.size ] = "goal";
    message_array[ message_array.size ] = "damage";
    
    for ( i = 0; i < message_array.size ; i++ )
    {
        self flag::init( message_array[ i ] );
        self thread ent_flag_wait_ai_standards( message_array[ i ] );
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x80296e66, Offset: 0xbf98
// Size: 0x32
function ent_flag_wait_ai_standards( message )
{
    self endon( #"death" );
    self waittill( message );
    self.ent_flag[ message ] = 1;
}

// Namespace zm_utility
// Params 1
// Checksum 0xceccb34e, Offset: 0xbfd8
// Size: 0x2e
function flat_angle( angle )
{
    rangle = ( 0, angle[ 1 ], 0 );
    return rangle;
}

// Namespace zm_utility
// Params 0
// Checksum 0x9ea6ac75, Offset: 0xc010
// Size: 0x44
function clear_run_anim()
{
    self.alwaysrunforward = undefined;
    self.a.combatrunanim = undefined;
    self.run_noncombatanim = undefined;
    self.walk_combatanim = undefined;
    self.walk_noncombatanim = undefined;
    self.precombatrunenabled = 1;
}

// Namespace zm_utility
// Params 0
// Checksum 0x4b047f57, Offset: 0xc060
// Size: 0x3e0
function track_players_intersection_tracker()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"end_game" );
    wait 5;
    
    while ( true )
    {
        killed_players = 0;
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( players[ i ] laststand::player_is_in_laststand() || "playing" != players[ i ].sessionstate )
            {
                continue;
            }
            
            for ( j = 0; j < players.size ; j++ )
            {
                if ( i == j || players[ j ] laststand::player_is_in_laststand() || "playing" != players[ j ].sessionstate )
                {
                    continue;
                }
                
                if ( isdefined( level.player_intersection_tracker_override ) )
                {
                    if ( players[ i ] [[ level.player_intersection_tracker_override ]]( players[ j ] ) )
                    {
                        continue;
                    }
                }
                
                playeri_origin = players[ i ].origin;
                playerj_origin = players[ j ].origin;
                
                if ( abs( playeri_origin[ 2 ] - playerj_origin[ 2 ] ) > 60 )
                {
                    continue;
                }
                
                distance_apart = distance2d( playeri_origin, playerj_origin );
                
                if ( abs( distance_apart ) > 18 )
                {
                    continue;
                }
                
                /#
                    iprintlnbold( "<dev string:x2f8>" );
                #/
                
                players[ i ] dodamage( 1000, ( 0, 0, 0 ) );
                players[ j ] dodamage( 1000, ( 0, 0, 0 ) );
                
                if ( !killed_players )
                {
                    players[ i ] playlocalsound( level.zmb_laugh_alias );
                }
                
                players[ i ] zm_stats::increment_map_cheat_stat( "cheat_too_friendly" );
                players[ i ] zm_stats::increment_client_stat( "cheat_too_friendly", 0 );
                players[ i ] zm_stats::increment_client_stat( "cheat_total", 0 );
                players[ j ] zm_stats::increment_map_cheat_stat( "cheat_too_friendly" );
                players[ j ] zm_stats::increment_client_stat( "cheat_too_friendly", 0 );
                players[ j ] zm_stats::increment_client_stat( "cheat_total", 0 );
                killed_players = 1;
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_utility
// Params 4
// Checksum 0x2a6e9621, Offset: 0xc448
// Size: 0x170
function is_player_looking_at( origin, dot, do_trace, ignore_ent )
{
    assert( isplayer( self ), "<dev string:x316>" );
    
    if ( !isdefined( dot ) )
    {
        dot = 0.7;
    }
    
    if ( !isdefined( do_trace ) )
    {
        do_trace = 1;
    }
    
    eye = self util::get_eye();
    delta_vec = anglestoforward( vectortoangles( origin - eye ) );
    view_vec = anglestoforward( self getplayerangles() );
    new_dot = vectordot( delta_vec, view_vec );
    
    if ( new_dot >= dot )
    {
        if ( do_trace )
        {
            return bullettracepassed( origin, eye, 0, ignore_ent );
        }
        else
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace zm_utility
// Params 4
// Checksum 0x251b83b2, Offset: 0xc5c0
// Size: 0x24
function add_gametype( gt, dummy1, name, dummy2 )
{
    
}

// Namespace zm_utility
// Params 4
// Checksum 0xf41cc52b, Offset: 0xc5f0
// Size: 0x24
function add_gameloc( gl, dummy1, name, dummy2 )
{
    
}

// Namespace zm_utility
// Params 3
// Checksum 0x4b01adb7, Offset: 0xc620
// Size: 0xf4
function get_closest_index( org, array, dist )
{
    if ( !isdefined( dist ) )
    {
        dist = 9999999;
    }
    
    distsq = dist * dist;
    
    if ( array.size < 1 )
    {
        return;
    }
    
    index = undefined;
    
    for ( i = 0; i < array.size ; i++ )
    {
        newdistsq = distancesquared( array[ i ].origin, org );
        
        if ( newdistsq >= distsq )
        {
            continue;
        }
        
        distsq = newdistsq;
        index = i;
    }
    
    return index;
}

// Namespace zm_utility
// Params 1
// Checksum 0xf6197358, Offset: 0xc720
// Size: 0xf6, Type: bool
function is_valid_zombie_spawn_point( point )
{
    liftedorigin = point.origin + ( 0, 0, 5 );
    size = 48;
    height = 64;
    mins = ( -1 * size, -1 * size, 0 );
    maxs = ( size, size, height );
    absmins = liftedorigin + mins;
    absmaxs = liftedorigin + maxs;
    
    if ( boundswouldtelefrag( absmins, absmaxs ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_utility
// Params 4
// Checksum 0xaadcc818, Offset: 0xc820
// Size: 0x144
function get_closest_index_to_entity( entity, array, dist, extra_check )
{
    org = entity.origin;
    
    if ( !isdefined( dist ) )
    {
        dist = 9999999;
    }
    
    distsq = dist * dist;
    
    if ( array.size < 1 )
    {
        return;
    }
    
    index = undefined;
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( isdefined( extra_check ) && ![[ extra_check ]]( entity, array[ i ] ) )
        {
            continue;
        }
        
        newdistsq = distancesquared( array[ i ].origin, org );
        
        if ( newdistsq >= distsq )
        {
            continue;
        }
        
        distsq = newdistsq;
        index = i;
    }
    
    return index;
}

// Namespace zm_utility
// Params 2
// Checksum 0xd3896d31, Offset: 0xc970
// Size: 0x4a
function set_gamemode_var( gvar, val )
{
    if ( !isdefined( game[ "gamemode_match" ] ) )
    {
        game[ "gamemode_match" ] = [];
    }
    
    game[ "gamemode_match" ][ gvar ] = val;
}

// Namespace zm_utility
// Params 2
// Checksum 0xa156c8d1, Offset: 0xc9c8
// Size: 0x62
function set_gamemode_var_once( gvar, val )
{
    if ( !isdefined( game[ "gamemode_match" ] ) )
    {
        game[ "gamemode_match" ] = [];
    }
    
    if ( !isdefined( game[ "gamemode_match" ][ gvar ] ) )
    {
        game[ "gamemode_match" ][ gvar ] = val;
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0x76a2c2, Offset: 0xca38
// Size: 0x22
function set_game_var( gvar, val )
{
    game[ gvar ] = val;
}

// Namespace zm_utility
// Params 2
// Checksum 0x61f90de8, Offset: 0xca68
// Size: 0x30
function set_game_var_once( gvar, val )
{
    if ( !isdefined( game[ gvar ] ) )
    {
        game[ gvar ] = val;
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0xa851d4a7, Offset: 0xcaa0
// Size: 0x26
function get_game_var( gvar )
{
    if ( isdefined( game[ gvar ] ) )
    {
        return game[ gvar ];
    }
    
    return undefined;
}

// Namespace zm_utility
// Params 1
// Checksum 0xa46431d0, Offset: 0xcad0
// Size: 0x48
function get_gamemode_var( gvar )
{
    if ( isdefined( game[ "gamemode_match" ] ) && isdefined( game[ "gamemode_match" ][ gvar ] ) )
    {
        return game[ "gamemode_match" ][ gvar ];
    }
    
    return undefined;
}

// Namespace zm_utility
// Params 6
// Checksum 0x951767c, Offset: 0xcb20
// Size: 0x1f0
function waittill_subset( min_num, string1, string2, string3, string4, string5 )
{
    self endon( #"death" );
    ent = spawnstruct();
    ent.threads = 0;
    returned_threads = 0;
    
    if ( isdefined( string1 ) )
    {
        self thread util::waittill_string( string1, ent );
        ent.threads++;
    }
    
    if ( isdefined( string2 ) )
    {
        self thread util::waittill_string( string2, ent );
        ent.threads++;
    }
    
    if ( isdefined( string3 ) )
    {
        self thread util::waittill_string( string3, ent );
        ent.threads++;
    }
    
    if ( isdefined( string4 ) )
    {
        self thread util::waittill_string( string4, ent );
        ent.threads++;
    }
    
    if ( isdefined( string5 ) )
    {
        self thread util::waittill_string( string5, ent );
        ent.threads++;
    }
    
    while ( ent.threads )
    {
        ent waittill( #"returned" );
        ent.threads--;
        returned_threads++;
        
        if ( returned_threads >= min_num )
        {
            break;
        }
    }
    
    ent notify( #"die" );
}

// Namespace zm_utility
// Params 3
// Checksum 0xa57e12d2, Offset: 0xcd18
// Size: 0xa4, Type: bool
function is_headshot( weapon, shitloc, smeansofdeath )
{
    if ( !isdefined( shitloc ) )
    {
        return false;
    }
    
    if ( shitloc != "head" && shitloc != "helmet" )
    {
        return false;
    }
    
    if ( smeansofdeath == "MOD_IMPACT" && weapon.isballisticknife )
    {
        return true;
    }
    
    return smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_IMPACT" && smeansofdeath != "MOD_UNKNOWN";
}

// Namespace zm_utility
// Params 0
// Checksum 0x122dbc9a, Offset: 0xcdc8
// Size: 0x30, Type: bool
function is_jumping()
{
    ground_ent = self getgroundent();
    return !isdefined( ground_ent );
}

// Namespace zm_utility
// Params 1
// Checksum 0x2551060f, Offset: 0xce00
// Size: 0x74, Type: bool
function is_explosive_damage( mod )
{
    if ( !isdefined( mod ) )
    {
        return false;
    }
    
    if ( mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_utility
// Params 1
// Checksum 0x53cda896, Offset: 0xce80
// Size: 0x66
function sndswitchannouncervox( who )
{
    switch ( who )
    {
        default:
            game[ "zmbdialog" ][ "prefix" ] = "vox_zmba_sam";
            level.zmb_laugh_alias = "zmb_laugh_sam";
            level.sndannouncerisrich = 0;
            break;
    }
}

// Namespace zm_utility
// Params 4
// Checksum 0xf9024d13, Offset: 0xcef0
// Size: 0xb4
function do_player_general_vox( category, type, timer, chance )
{
    if ( isdefined( timer ) && isdefined( level.votimer[ type ] ) && level.votimer[ type ] > 0 )
    {
        return;
    }
    
    self thread zm_audio::create_and_play_dialog( category, type );
    
    if ( isdefined( timer ) )
    {
        level.votimer[ type ] = timer;
        level thread general_vox_timer( level.votimer[ type ], type );
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0x779116b0, Offset: 0xcfb0
// Size: 0xc4
function general_vox_timer( timer, type )
{
    level endon( #"end_game" );
    println( "<dev string:x344>" + type + "<dev string:x362>" + timer + "<dev string:x366>" );
    
    while ( timer > 0 )
    {
        wait 1;
        timer--;
    }
    
    level.votimer[ type ] = timer;
    println( "<dev string:x368>" + type + "<dev string:x362>" + timer + "<dev string:x366>" );
}

// Namespace zm_utility
// Params 1
// Checksum 0xa0979b90, Offset: 0xd080
// Size: 0x1e
function create_vox_timer( type )
{
    level.votimer[ type ] = 0;
}

// Namespace zm_utility
// Params 3
// Checksum 0x2b5fc539, Offset: 0xd0a8
// Size: 0x1c
function play_vox_to_player( category, type, force_variant )
{
    
}

// Namespace zm_utility
// Params 1
// Checksum 0xce86269f, Offset: 0xd0d0
// Size: 0xa2, Type: bool
function is_favorite_weapon( weapon_to_check )
{
    if ( !isdefined( self.favorite_wall_weapons_list ) )
    {
        return false;
    }
    
    foreach ( weapon in self.favorite_wall_weapons_list )
    {
        if ( weapon_to_check == weapon )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_utility
// Params 2
// Checksum 0x636fff89, Offset: 0xd180
// Size: 0x26
function add_vox_response_chance( event, chance )
{
    level.response_chances[ event ] = chance;
}

// Namespace zm_utility
// Params 0
// Checksum 0xc92ef484, Offset: 0xd1b0
// Size: 0x214
function set_demo_intermission_point()
{
    spawnpoints = getentarray( "mp_global_intermission", "classname" );
    
    if ( !spawnpoints.size )
    {
        return;
    }
    
    spawnpoint = spawnpoints[ 0 ];
    match_string = "";
    location = level.scr_zm_map_start_location;
    
    if ( ( location == "default" || location == "" ) && isdefined( level.default_start_location ) )
    {
        location = level.default_start_location;
    }
    
    match_string = level.scr_zm_ui_gametype + "_" + location;
    
    for ( i = 0; i < spawnpoints.size ; i++ )
    {
        if ( isdefined( spawnpoints[ i ].script_string ) )
        {
            tokens = strtok( spawnpoints[ i ].script_string, " " );
            
            foreach ( token in tokens )
            {
                if ( token == match_string )
                {
                    spawnpoint = spawnpoints[ i ];
                    i = spawnpoints.size;
                    break;
                }
            }
        }
    }
    
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
}

// Namespace zm_utility
// Params 2
// Checksum 0x1cb7e08, Offset: 0xd3d0
// Size: 0x2c
function register_map_navcard( navcard_on_map, navcard_needed_for_computer )
{
    level.navcard_needed = navcard_needed_for_computer;
    level.map_navcard = navcard_on_map;
}

// Namespace zm_utility
// Params 1
// Checksum 0x61e22e3a, Offset: 0xd408
// Size: 0x2a
function does_player_have_map_navcard( player )
{
    return player zm_stats::get_global_stat( level.map_navcard );
}

// Namespace zm_utility
// Params 1
// Checksum 0xfc9f3253, Offset: 0xd440
// Size: 0x3a
function does_player_have_correct_navcard( player )
{
    if ( !isdefined( level.navcard_needed ) )
    {
        return 0;
    }
    
    return player zm_stats::get_global_stat( level.navcard_needed );
}

// Namespace zm_utility
// Params 4
// Checksum 0xc6e70b1e, Offset: 0xd488
// Size: 0x35c
function place_navcard( str_model, str_stat, org, angles )
{
    navcard = spawn( "script_model", org );
    navcard setmodel( str_model );
    navcard.angles = angles;
    wait 1;
    navcard_pickup_trig = spawn( "trigger_radius_use", org, 0, 84, 72 );
    navcard_pickup_trig setcursorhint( "HINT_NOICON" );
    navcard_pickup_trig sethintstring( &"ZOMBIE_NAVCARD_PICKUP" );
    navcard_pickup_trig triggerignoreteam();
    a_navcard_stats = array( "navcard_held_zm_transit", "navcard_held_zm_highrise", "navcard_held_zm_buried" );
    is_holding_card = 0;
    str_placing_stat = undefined;
    
    while ( true )
    {
        navcard_pickup_trig waittill( #"trigger", who );
        
        if ( is_player_valid( who ) )
        {
            foreach ( str_cur_stat in a_navcard_stats )
            {
                if ( who zm_stats::get_global_stat( str_cur_stat ) )
                {
                    str_placing_stat = str_cur_stat;
                    is_holding_card = 1;
                    who zm_stats::set_global_stat( str_cur_stat, 0 );
                }
            }
            
            who playsound( "zmb_buildable_piece_add" );
            who zm_stats::set_global_stat( str_stat, 1 );
            who.navcard_grabbed = str_stat;
            util::wait_network_frame();
            is_stat = who zm_stats::get_global_stat( str_stat );
            thread sq_refresh_player_navcard_hud();
            break;
        }
    }
    
    navcard delete();
    navcard_pickup_trig delete();
    
    if ( is_holding_card )
    {
        level thread place_navcard( str_model, str_placing_stat, org, angles );
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0xc6fd7676, Offset: 0xd7f0
// Size: 0xb2
function sq_refresh_player_navcard_hud()
{
    if ( !isdefined( level.navcards ) )
    {
        return;
    }
    
    players = getplayers();
    
    foreach ( player in players )
    {
        player thread sq_refresh_player_navcard_hud_internal();
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0xcce76c66, Offset: 0xd8b0
// Size: 0x13c
function sq_refresh_player_navcard_hud_internal()
{
    self endon( #"disconnect" );
    navcard_bits = 0;
    
    for ( i = 0; i < level.navcards.size ; i++ )
    {
        hasit = self zm_stats::get_global_stat( level.navcards[ i ] );
        
        if ( isdefined( self.navcard_grabbed ) && self.navcard_grabbed == level.navcards[ i ] )
        {
            hasit = 1;
        }
        
        if ( hasit )
        {
            navcard_bits += 1 << i;
        }
    }
    
    util::wait_network_frame();
    self clientfield::set( "navcard_held", 0 );
    
    if ( navcard_bits > 0 )
    {
        util::wait_network_frame();
        self clientfield::set( "navcard_held", navcard_bits );
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x1a76741b, Offset: 0xd9f8
// Size: 0xf4
function disable_player_move_states( forcestancechange )
{
    self allowcrouch( 1 );
    self allowlean( 0 );
    self allowads( 0 );
    self allowsprint( 0 );
    self allowprone( 0 );
    self allowmelee( 0 );
    
    if ( isdefined( forcestancechange ) && forcestancechange == 1 )
    {
        if ( self getstance() == "prone" )
        {
            self setstance( "crouch" );
        }
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0x31ca1302, Offset: 0xdaf8
// Size: 0x11c
function enable_player_move_states()
{
    if ( !isdefined( self._allow_lean ) || self._allow_lean == 1 )
    {
        self allowlean( 1 );
    }
    
    if ( !isdefined( self._allow_ads ) || self._allow_ads == 1 )
    {
        self allowads( 1 );
    }
    
    if ( !isdefined( self._allow_sprint ) || self._allow_sprint == 1 )
    {
        self allowsprint( 1 );
    }
    
    if ( !isdefined( self._allow_prone ) || self._allow_prone == 1 )
    {
        self allowprone( 1 );
    }
    
    if ( !isdefined( self._allow_melee ) || self._allow_melee == 1 )
    {
        self allowmelee( 1 );
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0x4b28afe1, Offset: 0xdc20
// Size: 0x34
function check_and_create_node_lists()
{
    if ( !isdefined( level._link_node_list ) )
    {
        level._link_node_list = [];
    }
    
    if ( !isdefined( level._unlink_node_list ) )
    {
        level._unlink_node_list = [];
    }
}

// Namespace zm_utility
// Params 3
// Checksum 0x598f9850, Offset: 0xdc60
// Size: 0x22c
function link_nodes( a, b, bdontunlinkonmigrate )
{
    if ( !isdefined( bdontunlinkonmigrate ) )
    {
        bdontunlinkonmigrate = 0;
    }
    
    if ( nodesarelinked( a, b ) )
    {
        return;
    }
    
    check_and_create_node_lists();
    a_index_string = "" + a.origin;
    b_index_string = "" + b.origin;
    
    if ( !isdefined( level._link_node_list[ a_index_string ] ) )
    {
        level._link_node_list[ a_index_string ] = spawnstruct();
        level._link_node_list[ a_index_string ].node = a;
        level._link_node_list[ a_index_string ].links = [];
        level._link_node_list[ a_index_string ].ignore_on_migrate = [];
    }
    
    if ( !isdefined( level._link_node_list[ a_index_string ].links[ b_index_string ] ) )
    {
        level._link_node_list[ a_index_string ].links[ b_index_string ] = b;
        level._link_node_list[ a_index_string ].ignore_on_migrate[ b_index_string ] = bdontunlinkonmigrate;
    }
    
    if ( isdefined( level._unlink_node_list[ a_index_string ] ) )
    {
        if ( isdefined( level._unlink_node_list[ a_index_string ].links[ b_index_string ] ) )
        {
            level._unlink_node_list[ a_index_string ].links[ b_index_string ] = undefined;
            level._unlink_node_list[ a_index_string ].ignore_on_migrate[ b_index_string ] = undefined;
        }
    }
    
    linknodes( a, b );
}

// Namespace zm_utility
// Params 3
// Checksum 0xa61c3c2c, Offset: 0xde98
// Size: 0x22c
function unlink_nodes( a, b, bdontlinkonmigrate )
{
    if ( !isdefined( bdontlinkonmigrate ) )
    {
        bdontlinkonmigrate = 0;
    }
    
    if ( !nodesarelinked( a, b ) )
    {
        return;
    }
    
    check_and_create_node_lists();
    a_index_string = "" + a.origin;
    b_index_string = "" + b.origin;
    
    if ( !isdefined( level._unlink_node_list[ a_index_string ] ) )
    {
        level._unlink_node_list[ a_index_string ] = spawnstruct();
        level._unlink_node_list[ a_index_string ].node = a;
        level._unlink_node_list[ a_index_string ].links = [];
        level._unlink_node_list[ a_index_string ].ignore_on_migrate = [];
    }
    
    if ( !isdefined( level._unlink_node_list[ a_index_string ].links[ b_index_string ] ) )
    {
        level._unlink_node_list[ a_index_string ].links[ b_index_string ] = b;
        level._unlink_node_list[ a_index_string ].ignore_on_migrate[ b_index_string ] = bdontlinkonmigrate;
    }
    
    if ( isdefined( level._link_node_list[ a_index_string ] ) )
    {
        if ( isdefined( level._link_node_list[ a_index_string ].links[ b_index_string ] ) )
        {
            level._link_node_list[ a_index_string ].links[ b_index_string ] = undefined;
            level._link_node_list[ a_index_string ].ignore_on_migrate[ b_index_string ] = undefined;
        }
    }
    
    unlinknodes( a, b );
}

// Namespace zm_utility
// Params 6
// Checksum 0xa4a67902, Offset: 0xe0d0
// Size: 0x13a
function spawn_path_node( origin, angles, k1, v1, k2, v2 )
{
    if ( !isdefined( level._spawned_path_nodes ) )
    {
        level._spawned_path_nodes = [];
    }
    
    node = spawnstruct();
    node.origin = origin;
    node.angles = angles;
    node.k1 = k1;
    node.v1 = v1;
    node.k2 = k2;
    node.v2 = v2;
    node.node = spawn_path_node_internal( origin, angles, k1, v1, k2, v2 );
    level._spawned_path_nodes[ level._spawned_path_nodes.size ] = node;
    return node.node;
}

// Namespace zm_utility
// Params 6
// Checksum 0xa330827, Offset: 0xe218
// Size: 0xce
function spawn_path_node_internal( origin, angles, k1, v1, k2, v2 )
{
    if ( isdefined( k2 ) )
    {
        return spawnpathnode( "node_pathnode", origin, angles, k1, v1, k2, v2 );
    }
    else if ( isdefined( k1 ) )
    {
        return spawnpathnode( "node_pathnode", origin, angles, k1, v1 );
    }
    else
    {
        return spawnpathnode( "node_pathnode", origin, angles );
    }
    
    return undefined;
}

// Namespace zm_utility
// Params 0
// Checksum 0x99ec1590, Offset: 0xe2f0
// Size: 0x4
function delete_spawned_path_nodes()
{
    
}

// Namespace zm_utility
// Params 0
// Checksum 0xb72939, Offset: 0xe300
// Size: 0xea
function respawn_path_nodes()
{
    if ( !isdefined( level._spawned_path_nodes ) )
    {
        return;
    }
    
    for ( i = 0; i < level._spawned_path_nodes.size ; i++ )
    {
        node_struct = level._spawned_path_nodes[ i ];
        println( "<dev string:x384>" + node_struct.origin );
        node_struct.node = spawn_path_node_internal( node_struct.origin, node_struct.angles, node_struct.k1, node_struct.v1, node_struct.k2, node_struct.v2 );
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0xd477c58f, Offset: 0xe3f8
// Size: 0x236
function link_changes_internal_internal( list, func )
{
    keys = getarraykeys( list );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        node = list[ keys[ i ] ].node;
        node_keys = getarraykeys( list[ keys[ i ] ].links );
        
        for ( j = 0; j < node_keys.size ; j++ )
        {
            if ( isdefined( list[ keys[ i ] ].links[ node_keys[ j ] ] ) )
            {
                if ( isdefined( list[ keys[ i ] ].ignore_on_migrate[ node_keys[ j ] ] ) && list[ keys[ i ] ].ignore_on_migrate[ node_keys[ j ] ] )
                {
                    println( "<dev string:x3a5>" + keys[ i ] + "<dev string:x3ae>" + node_keys[ j ] + "<dev string:x3bb>" );
                    continue;
                }
                
                println( "<dev string:x3a5>" + keys[ i ] + "<dev string:x3ae>" + node_keys[ j ] );
                [[ func ]]( node, list[ keys[ i ] ].links[ node_keys[ j ] ] );
            }
        }
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0x44a8aaef, Offset: 0xe638
// Size: 0xa4
function link_changes_internal( func_for_link_list, func_for_unlink_list )
{
    if ( isdefined( level._link_node_list ) )
    {
        println( "<dev string:x3c6>" );
        link_changes_internal_internal( level._link_node_list, func_for_link_list );
    }
    
    if ( isdefined( level._unlink_node_list ) )
    {
        println( "<dev string:x3d0>" );
        link_changes_internal_internal( level._unlink_node_list, func_for_unlink_list );
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0x3ae6a827, Offset: 0xe6e8
// Size: 0x4c
function link_nodes_wrapper( a, b )
{
    if ( !nodesarelinked( a, b ) )
    {
        linknodes( a, b );
    }
}

// Namespace zm_utility
// Params 2
// Checksum 0x3d700488, Offset: 0xe740
// Size: 0x4c
function unlink_nodes_wrapper( a, b )
{
    if ( nodesarelinked( a, b ) )
    {
        unlinknodes( a, b );
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0xead97bcf, Offset: 0xe798
// Size: 0x94
function undo_link_changes()
{
    /#
        println( "<dev string:x3dc>" );
        println( "<dev string:x3dc>" );
        println( "<dev string:x3e0>" );
    #/
    
    link_changes_internal( &unlink_nodes_wrapper, &link_nodes_wrapper );
    delete_spawned_path_nodes();
}

// Namespace zm_utility
// Params 0
// Checksum 0xa5f41f53, Offset: 0xe838
// Size: 0x94
function redo_link_changes()
{
    /#
        println( "<dev string:x3dc>" );
        println( "<dev string:x3dc>" );
        println( "<dev string:x3f9>" );
    #/
    
    respawn_path_nodes();
    link_changes_internal( &link_nodes_wrapper, &unlink_nodes_wrapper );
}

// Namespace zm_utility
// Params 1
// Checksum 0x35a17a69, Offset: 0xe8d8
// Size: 0xb2
function is_gametype_active( a_gametypes )
{
    b_is_gametype_active = 0;
    
    if ( !isarray( a_gametypes ) )
    {
        a_gametypes = array( a_gametypes );
    }
    
    for ( i = 0; i < a_gametypes.size ; i++ )
    {
        if ( getdvarstring( "g_gametype" ) == a_gametypes[ i ] )
        {
            b_is_gametype_active = 1;
        }
    }
    
    return b_is_gametype_active;
}

// Namespace zm_utility
// Params 2
// Checksum 0x44e10343, Offset: 0xe998
// Size: 0x3e
function register_custom_spawner_entry( spot_noteworthy, func )
{
    if ( !isdefined( level.custom_spawner_entry ) )
    {
        level.custom_spawner_entry = [];
    }
    
    level.custom_spawner_entry[ spot_noteworthy ] = func;
}

// Namespace zm_utility
// Params 1
// Checksum 0xc4eddaa4, Offset: 0xe9e0
// Size: 0x90
function get_player_weapon_limit( player )
{
    if ( isdefined( self.get_player_weapon_limit ) )
    {
        return [[ self.get_player_weapon_limit ]]( player );
    }
    
    if ( isdefined( level.get_player_weapon_limit ) )
    {
        return [[ level.get_player_weapon_limit ]]( player );
    }
    
    weapon_limit = 2;
    
    if ( player hasperk( "specialty_additionalprimaryweapon" ) )
    {
        weapon_limit = level.additionalprimaryweapon_limit;
    }
    
    return weapon_limit;
}

// Namespace zm_utility
// Params 0
// Checksum 0x36353639, Offset: 0xea78
// Size: 0x3c
function get_player_perk_purchase_limit()
{
    n_perk_purchase_limit_override = level.perk_purchase_limit;
    
    if ( isdefined( level.get_player_perk_purchase_limit ) )
    {
        n_perk_purchase_limit_override = self [[ level.get_player_perk_purchase_limit ]]();
    }
    
    return n_perk_purchase_limit_override;
}

// Namespace zm_utility
// Params 0
// Checksum 0x28a6b25, Offset: 0xeac0
// Size: 0x6e, Type: bool
function can_player_purchase_perk()
{
    if ( self.num_perks < self get_player_perk_purchase_limit() )
    {
        return true;
    }
    
    if ( self bgb::is_enabled( "zm_bgb_unquenchable" ) || self bgb::is_enabled( "zm_bgb_soda_fountain" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_utility
// Params 1
// Checksum 0x3c679c61, Offset: 0xeb38
// Size: 0x122
function give_player_all_perks( b_exclude_quick_revive )
{
    if ( !isdefined( b_exclude_quick_revive ) )
    {
        b_exclude_quick_revive = 0;
    }
    
    a_str_perks = getarraykeys( level._custom_perks );
    
    foreach ( str_perk in a_str_perks )
    {
        if ( str_perk == "specialty_quickrevive" && b_exclude_quick_revive )
        {
            continue;
        }
        
        if ( !self hasperk( str_perk ) )
        {
            self zm_perks::give_perk( str_perk, 0 );
            
            if ( isdefined( level.perk_bought_func ) )
            {
                self [[ level.perk_bought_func ]]( str_perk );
            }
        }
    }
}

// Namespace zm_utility
// Params 0
// Checksum 0x5165b61c, Offset: 0xec68
// Size: 0x1c
function wait_for_attractor_positions_complete()
{
    self waittill( #"attractor_positions_generated" );
    self.attract_to_origin = 0;
}

// Namespace zm_utility
// Params 1
// Checksum 0x5aa6ee9c, Offset: 0xec90
// Size: 0xda
function get_player_index( player )
{
    assert( isplayer( player ) );
    assert( isdefined( player.characterindex ) );
    
    /#
        if ( player.entity_num == 0 && getdvarstring( "<dev string:x412>" ) != "<dev string:x1eb>" )
        {
            new_vo_index = getdvarint( "<dev string:x412>" );
            return new_vo_index;
        }
    #/
    
    return player.characterindex;
}

// Namespace zm_utility
// Params 1
// Checksum 0xc1660863, Offset: 0xed78
// Size: 0x9a
function get_specific_character( n_character_index )
{
    foreach ( character in level.players )
    {
        if ( character.characterindex == n_character_index )
        {
            return character;
        }
    }
    
    return undefined;
}

// Namespace zm_utility
// Params 1
// Checksum 0xf52dfd0b, Offset: 0xee20
// Size: 0xd4
function zombie_goto_round( n_target_round )
{
    level notify( #"restart_round" );
    
    if ( n_target_round < 1 )
    {
        n_target_round = 1;
    }
    
    level.zombie_total = 0;
    zombie_utility::ai_calculate_health( n_target_round );
    zm::set_round_number( n_target_round - 1 );
    zombies = zombie_utility::get_round_enemy_array();
    
    if ( isdefined( zombies ) )
    {
        array::run_all( zombies, &kill );
    }
    
    level.sndgotoroundoccurred = 1;
    level waittill( #"between_round_over" );
}

// Namespace zm_utility
// Params 2
// Checksum 0xaf0c32ec, Offset: 0xef00
// Size: 0x1a6, Type: bool
function is_point_inside_enabled_zone( v_origin, ignore_zone )
{
    temp_ent = spawn( "script_origin", v_origin );
    
    foreach ( zone in level.zones )
    {
        if ( !zone.is_enabled )
        {
            continue;
        }
        
        if ( isdefined( ignore_zone ) && zone == ignore_zone )
        {
            continue;
        }
        
        foreach ( e_volume in zone.volumes )
        {
            if ( temp_ent istouching( e_volume ) )
            {
                temp_ent delete();
                return true;
            }
        }
    }
    
    temp_ent delete();
    return false;
}

// Namespace zm_utility
// Params 0
// Checksum 0x3a040836, Offset: 0xf0b0
// Size: 0x42
function clear_streamer_hint()
{
    if ( isdefined( self.streamer_hint ) )
    {
        self.streamer_hint delete();
        self.streamer_hint = undefined;
    }
    
    self notify( #"wait_clear_streamer_hint" );
}

// Namespace zm_utility
// Params 1
// Checksum 0x1cb60e03, Offset: 0xf100
// Size: 0x3c
function wait_clear_streamer_hint( lifetime )
{
    self endon( #"wait_clear_streamer_hint" );
    wait lifetime;
    
    if ( isdefined( self ) )
    {
        self clear_streamer_hint();
    }
}

// Namespace zm_utility
// Params 4
// Checksum 0x2b135a74, Offset: 0xf148
// Size: 0x1ac
function create_streamer_hint( origin, angles, value, lifetime )
{
    if ( self == level )
    {
        foreach ( player in getplayers() )
        {
            player clear_streamer_hint();
        }
    }
    
    self clear_streamer_hint();
    self.streamer_hint = createstreamerhint( origin, value );
    
    if ( isdefined( angles ) )
    {
        self.streamer_hint.angles = angles;
    }
    
    if ( self != level )
    {
        self.streamer_hint setinvisibletoall();
        self.streamer_hint setvisibletoplayer( self );
    }
    
    self.streamer_hint setincludemeshes( 1 );
    self notify( #"wait_clear_streamer_hint" );
    
    if ( isdefined( lifetime ) && lifetime > 0 )
    {
        self thread wait_clear_streamer_hint( lifetime );
    }
}

// Namespace zm_utility
// Params 1
// Checksum 0x9ed47bd9, Offset: 0xf300
// Size: 0x180
function approximate_path_dist( player )
{
    aiprofile_beginentry( "approximate_path_dist" );
    goal_pos = player.origin;
    
    if ( isdefined( player.last_valid_position ) )
    {
        goal_pos = player.last_valid_position;
    }
    
    if ( isdefined( player.b_teleporting ) && player.b_teleporting )
    {
        if ( isdefined( player.teleport_location ) )
        {
            goal_pos = player.teleport_location;
            
            if ( !ispointonnavmesh( goal_pos, self ) )
            {
                position = getclosestpointonnavmesh( goal_pos, 100, 15 );
                
                if ( isdefined( position ) )
                {
                    goal_pos = position;
                }
            }
        }
    }
    
    assert( isdefined( level.pathdist_type ), "<dev string:x42d>" );
    approx_dist = pathdistance( self.origin, goal_pos, 1, self, level.pathdist_type );
    aiprofile_endentry();
    return approx_dist;
}

// Namespace zm_utility
// Params 3
// Checksum 0x3f21e441, Offset: 0xf488
// Size: 0x8c
function register_slowdown( str_type, n_rate, n_duration )
{
    if ( !isdefined( level.a_n_slowdown_rates ) )
    {
        level.a_n_slowdown_rates = [];
    }
    
    level.a_s_slowdowns[ str_type ] = spawnstruct();
    level.a_s_slowdowns[ str_type ].n_rate = n_rate;
    level.a_s_slowdowns[ str_type ].n_duration = n_duration;
}

// Namespace zm_utility
// Params 1
// Checksum 0x7a59bb11, Offset: 0xf520
// Size: 0x284
function slowdown_ai( str_type )
{
    self notify( #"starting_slowdown_ai" );
    self endon( #"starting_slowdown_ai" );
    self endon( #"death" );
    assert( isdefined( level.a_s_slowdowns[ str_type ] ), "<dev string:x469>" + str_type + "<dev string:x474>" );
    
    if ( !isdefined( self.a_n_slowdown_timeouts ) )
    {
        self.a_n_slowdown_timeouts = [];
    }
    
    n_time = gettime();
    n_timeout = n_time + level.a_s_slowdowns[ str_type ].n_duration;
    
    if ( !isdefined( self.a_n_slowdown_timeouts[ str_type ] ) || self.a_n_slowdown_timeouts[ str_type ] < n_timeout )
    {
        self.a_n_slowdown_timeouts[ str_type ] = n_timeout;
    }
    
    while ( self.a_n_slowdown_timeouts.size )
    {
        str_lowest_type = undefined;
        n_lowest_rate = 10;
        
        foreach ( str_index, n_slowdown_timeout in self.a_n_slowdown_timeouts )
        {
            if ( n_slowdown_timeout <= n_time )
            {
                self.a_n_slowdown_timeouts[ str_index ] = undefined;
                continue;
            }
            
            if ( level.a_s_slowdowns[ str_index ].n_rate < n_lowest_rate )
            {
                str_lowest_type = str_index;
                n_lowest_rate = level.a_s_slowdowns[ str_index ].n_rate;
            }
        }
        
        if ( isdefined( str_lowest_type ) )
        {
            self asmsetanimationrate( n_lowest_rate );
            n_duration = self.a_n_slowdown_timeouts[ str_lowest_type ] - n_time;
            wait n_duration;
            self.a_n_slowdown_timeouts[ str_lowest_type ] = undefined;
        }
    }
    
    self asmsetanimationrate( 1 );
}

// Namespace zm_utility
// Params 1
// Checksum 0x9beb302d, Offset: 0xf7b0
// Size: 0x7c
function get_player_closest_to( e_target )
{
    a_players = arraycopy( level.activeplayers );
    arrayremovevalue( a_players, e_target );
    e_closest_player = arraygetclosest( e_target.origin, a_players );
    return e_closest_player;
}

// Namespace zm_utility
// Params 3
// Checksum 0xb53ef20, Offset: 0xf838
// Size: 0x18a, Type: bool
function is_facing( facee, requireddot, b_2d )
{
    if ( !isdefined( requireddot ) )
    {
        requireddot = 0.5;
    }
    
    if ( !isdefined( b_2d ) )
    {
        b_2d = 1;
    }
    
    orientation = self getplayerangles();
    v_forward = anglestoforward( orientation );
    v_to_facee = facee.origin - self.origin;
    
    if ( b_2d )
    {
        v_forward_computed = ( v_forward[ 0 ], v_forward[ 1 ], 0 );
        v_to_facee_computed = ( v_to_facee[ 0 ], v_to_facee[ 1 ], 0 );
    }
    else
    {
        v_forward_computed = v_forward;
        v_to_facee_computed = v_to_facee;
    }
    
    v_unit_forward_computed = vectornormalize( v_forward_computed );
    v_unit_to_facee_computed = vectornormalize( v_to_facee_computed );
    dotproduct = vectordot( v_unit_forward_computed, v_unit_to_facee_computed );
    return dotproduct > requireddot;
}

// Namespace zm_utility
// Params 0
// Checksum 0x343b0844, Offset: 0xf9d0
// Size: 0x32, Type: bool
function is_solo_ranked_game()
{
    return level.players.size == 1 && getdvarint( "zm_private_rankedmatch", 0 );
}

// Namespace zm_utility
// Params 1
// Checksum 0x8a6360a, Offset: 0xfa10
// Size: 0x7e
function upload_zm_dash_counters( force_upload )
{
    if ( !isdefined( force_upload ) )
    {
        force_upload = 0;
    }
    
    if ( !sessionmodeisonlinegame() )
    {
        return;
    }
    
    if ( isdefined( force_upload ) && ( isdefined( level.var_e097db22 ) && level.var_e097db22 || force_upload ) )
    {
        util::function_ad904acd();
    }
    
    level.var_e097db22 = undefined;
}

// Namespace zm_utility
// Params 0
// Checksum 0x49abf15f, Offset: 0xfa98
// Size: 0x12c
function upload_zm_dash_counters_end_game()
{
    foreach ( player in getplayers() )
    {
        if ( player flag::exists( "finished_reporting_consumables" ) )
        {
            player flag::wait_till( "finished_reporting_consumables" );
        }
    }
    
    if ( level flag::exists( "consumables_reported" ) && level flag::get( "consumables_reported" ) )
    {
        increment_zm_dash_counter( "end_reported_consumables", 1 );
    }
    
    upload_zm_dash_counters( 1 );
}

// Namespace zm_utility
// Params 2
// Checksum 0x56c30dc5, Offset: 0xfbd0
// Size: 0x64
function increment_zm_dash_counter( counter_name, amount )
{
    if ( !sessionmodeisonlinegame() )
    {
        return;
    }
    
    counter_name = function_62f3bbf4( counter_name );
    level.var_e097db22 = 1;
    util::function_a4c90358( counter_name, amount );
}

// Namespace zm_utility
// Params 1
// Checksum 0xd16c54f9, Offset: 0xfc40
// Size: 0x76
function function_62f3bbf4( counter_name )
{
    var_fa7fbeaf = "zm_dash_";
    
    if ( is_solo_ranked_game() )
    {
        var_fa7fbeaf += "solo_";
    }
    else
    {
        var_fa7fbeaf += "coop_";
    }
    
    var_fa7fbeaf += counter_name;
    return var_fa7fbeaf;
}

// Namespace zm_utility
// Params 3, eflags: 0x4
// Checksum 0x87cb84d7, Offset: 0xfcc0
// Size: 0xb4
function private function_8eb96012( ishost, var_95597467, issolo )
{
    path = spawnstruct();
    path.hosted = ishost ? "HOSTED" : "PLAYED";
    path.var_95597467 = var_95597467 ? "USED" : "UNUSED";
    path.var_c0cf8114 = issolo ? "SOLO" : "COOP";
    return path;
}

// Namespace zm_utility
// Params 2, eflags: 0x4
// Checksum 0xfe067fa6, Offset: 0xfd80
// Size: 0x72
function private function_9878c818( statpath, statname )
{
    return self getdstat( "dashboardingTrackingHistory", "gameSizeHistory", statpath.var_c0cf8114, "consumablesHistory", statpath.var_95597467, "periodHistory", statpath.hosted, statname );
}

// Namespace zm_utility
// Params 3, eflags: 0x4
// Checksum 0x80a342f, Offset: 0xfe00
// Size: 0xac
function private function_96c1b925( statpath, statname, value )
{
    self adddstat( "dashboardingTrackingHistory", "gameSizeHistory", statpath.var_c0cf8114, "consumablesHistory", statpath.var_95597467, "periodHistory", statpath.hosted, statname, value );
    self adddstat( "dashboardingTrackingHistory", "statsSinceLastComscoreEvent", statname, value );
}

// Namespace zm_utility
// Params 1, eflags: 0x4
// Checksum 0xadadd5c6, Offset: 0xfeb8
// Size: 0xe4
function private function_e33a692a( type )
{
    var_44222444 = self getdstat( "dashboardingTrackingHistory", "currentDashboardingTrackingHistoryIndex" );
    self setdstat( "dashboardingTrackingHistory", "quitType", var_44222444, type );
    var_36d3e544 = ( var_44222444 + 1 ) % 32;
    
    if ( var_36d3e544 == 0 )
    {
        self setdstat( "dashboardingTrackingHistory", "bufferFull", 1 );
    }
    
    self setdstat( "dashboardingTrackingHistory", "currentDashboardingTrackingHistoryIndex", var_36d3e544 );
}

// Namespace zm_utility
// Params 0
// Checksum 0x46ed9518, Offset: 0xffa8
// Size: 0x19c
function zm_dash_stats_game_start()
{
    if ( !( sessionmodeisonlinegame() && getdvarint( "zm_dash_stats_enable_tracking", 0 ) ) )
    {
        return;
    }
    
    level flag::wait_till( "all_players_connected" );
    self setdstat( "dashboardingTrackingHistory", "trackedFirstGame", 1 );
    statpath = function_8eb96012( self ishost(), 0, is_solo_ranked_game() );
    self function_96c1b925( statpath, "started", 1 );
    self setdstat( "dashboardingTrackingHistory", "lastGameWasHosted", self ishost() );
    self setdstat( "dashboardingTrackingHistory", "lastGameUsedConsumable", 0 );
    self setdstat( "dashboardingTrackingHistory", "lastGameWasCoop", !is_solo_ranked_game() );
    uploadstats( self );
}

// Namespace zm_utility
// Params 0
// Checksum 0xb1c0b49a, Offset: 0x10150
// Size: 0x134
function zm_dash_stats_game_end()
{
    if ( !( sessionmodeisonlinegame() && getdvarint( "zm_dash_stats_enable_tracking", 0 ) ) )
    {
        return;
    }
    
    var_822c3017 = self getdstat( "dashboardingTrackingHistory", "lastGameWasHosted" );
    var_f4d48599 = self getdstat( "dashboardingTrackingHistory", "lastGameUsedConsumable" );
    var_44d1dba9 = self getdstat( "dashboardingTrackingHistory", "lastGameWasCoop" );
    statpath = function_8eb96012( var_822c3017, var_f4d48599, !var_44d1dba9 );
    self function_96c1b925( statpath, "completed", 1 );
    self function_e33a692a( 4 );
}

// Namespace zm_utility
// Params 0
// Checksum 0x67d10ed0, Offset: 0x10290
// Size: 0x1a4
function zm_dash_stats_wait_for_consumable_use()
{
    if ( !( sessionmodeisonlinegame() && getdvarint( "zm_dash_stats_enable_tracking", 0 ) ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    self flag::wait_till( "used_consumable" );
    self setdstat( "dashboardingTrackingHistory", "lastGameUsedConsumable", 1 );
    var_9eb8805a = self getdstat( "dashboardingTrackingHistory", "lastGameWasHosted" );
    var_b47e6298 = self getdstat( "dashboardingTrackingHistory", "lastGameWasCoop" );
    var_ab363340 = function_8eb96012( var_9eb8805a, 0, !var_b47e6298 );
    var_c084221 = function_8eb96012( var_9eb8805a, 1, !var_b47e6298 );
    self function_96c1b925( var_ab363340, "started", -1 );
    self function_96c1b925( var_c084221, "started", 1 );
    uploadstats( self );
}

