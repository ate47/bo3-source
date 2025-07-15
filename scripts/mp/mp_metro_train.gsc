#using scripts/codescripts/struct;
#using scripts/mp/_events;
#using scripts/mp/_util;
#using scripts/mp/gametypes/ctf;
#using scripts/mp/killstreaks/_supplydrop;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace mp_metro_train;

// Namespace mp_metro_train
// Params 0
// Checksum 0x835624a, Offset: 0x738
// Size: 0x624
function init()
{
    level.train_positions = [];
    level.train_angles = [];
    start1 = getvehiclenode( "train_start_1", "targetname" );
    start2 = getvehiclenode( "train_start_2", "targetname" );
    cars1 = [];
    cars2 = [];
    var_db3e7a5c = [];
    var_4d45e997 = [];
    spawn_start_train( cars1, var_db3e7a5c, start1, "train1" );
    spawn_start_train( cars2, var_4d45e997, start2, "train2" );
    var_c7297b2b = getentarray( "metro_doors_inside_left", "targetname" );
    var_fe680264 = getentarray( "metro_doors_outside_left", "targetname" );
    var_c3f0dd82 = getentarray( "metro_doors_end_left", "targetname" );
    var_1ec2db3f = struct::get_array( "metro_train_track_vox_left" );
    var_7ce6af9e = getentarray( "metro_doors_inside_right", "targetname" );
    var_5159825b = getentarray( "metro_doors_outside_right", "targetname" );
    var_e1604af1 = getentarray( "metro_doors_end_right", "targetname" );
    var_f66166da = struct::get_array( "metro_train_track_vox_right" );
    var_d1439c1d = getent( "train_killtrigger_left", "targetname" );
    var_7d375500 = getent( "train_killtrigger_right", "targetname" );
    var_fe600fa3 = getent( "train_killtrigger_left_end", "targetname" );
    var_fe18c116 = getent( "train_killtrigger_right_end", "targetname" );
    var_e91b1c22 = getentarray( "mp_metro_platform_edge_left", "targetname" );
    var_c318a1b9 = getentarray( "mp_metro_platform_edge_right", "targetname" );
    level._effect[ "fx_light_red_train_track_warning" ] = "light/fx_light_red_train_track_warning";
    level._effect[ "fx_water_train_mist_kick_up_metro" ] = "water/fx_water_train_mist_kick_up_metro";
    waittillframeend();
    
    if ( level.timelimit )
    {
        seconds = level.timelimit * 60;
        events::add_timed_event( int( seconds * 0.25 ), "train_start_1" );
        events::add_timed_event( int( seconds * 0.75 ), "train_start_2" );
    }
    else if ( level.scorelimit )
    {
        events::add_score_event( int( level.scorelimit * 0.25 ), "train_start_1" );
        events::add_score_event( int( level.scorelimit * 0.75 ), "train_start_2" );
    }
    else if ( level.roundscorelimit )
    {
        events::add_round_score_event( int( level.roundscorelimit * 0.25 ), "train_start_1" );
        events::add_round_score_event( int( level.roundscorelimit * 0.75 ), "train_start_2" );
    }
    
    wait 1;
    
    if ( level.gametype == "escort" )
    {
        return;
    }
    
    level thread train_think( cars1, var_db3e7a5c, "train_start_1", start1, var_c7297b2b, var_fe680264, var_c3f0dd82, var_e91b1c22, var_7d375500, var_fe18c116, var_f66166da, "right" );
    level thread train_think( cars2, var_4d45e997, "train_start_2", start2, var_7ce6af9e, var_5159825b, var_e1604af1, var_c318a1b9, var_d1439c1d, var_fe600fa3, var_1ec2db3f, "left" );
}

// Namespace mp_metro_train
// Params 2
// Checksum 0x5858f9e7, Offset: 0xd68
// Size: 0x7c
function setup_gate( gate, gate_kill )
{
    gate setmovingplatformenabled( 1 );
    gate.gate_kill = gate_kill;
    gate.gate_kill enablelinkto();
    gate.gate_kill linkto( gate );
}

// Namespace mp_metro_train
// Params 4
// Checksum 0x5cc4dbac, Offset: 0xdf0
// Size: 0x276
function spawn_start_train( &cars, &dividers, start, name )
{
    cars[ 0 ] = spawnvehicle( "train_test_mp", ( 0, -2000, -200 ), ( 0, 0, 0 ), name );
    cars[ 0 ] setteam( "neutral" );
    cars[ 0 ] ghost();
    cars[ 0 ].ismagicbullet = 1;
    max_cars = getdvarint( "train_length", 10 );
    
    for ( i = 1; i < max_cars ; i++ )
    {
        if ( i == max_cars - 1 )
        {
            cars[ i ] = spawn( "script_model", ( 0, -2000, -200 ) );
            cars[ i ] setmodel( "p7_zur_metro_train_cab_module" );
            cars[ i ].var_48adb15 = 1;
        }
        else
        {
            cars[ i ] = spawn( "script_model", ( 0, -2000, -200 ) );
            cars[ i ] setmodel( "p7_zur_metro_train_car_module" );
        }
        
        cars[ i ] ghost();
        dividers[ i ] = spawn( "script_model", ( 0, -2000, -200 ) );
        dividers[ i ] setmodel( "p7_zur_metro_train_divider" );
        dividers[ i ] ghost();
    }
}

// Namespace mp_metro_train
// Params 1
// Checksum 0x7ddb3bbc, Offset: 0x1070
// Size: 0x24
function showaftertime( time )
{
    wait time;
    self show();
}

// Namespace mp_metro_train
// Params 5
// Checksum 0x5f7af435, Offset: 0x10a0
// Size: 0x1a4
function function_1b3e50b5( var_50a9e5d9, waittime, rotatetime, rotateangles, var_8efac8e4 )
{
    skip = var_8efac8e4;
    
    foreach ( var_4a3ded66 in var_50a9e5d9 )
    {
        if ( !skip )
        {
            var_4a3ded66 rotateto( var_4a3ded66.originalangles + rotateangles, rotatetime );
            wait waittime;
        }
        
        skip = !skip;
    }
    
    foreach ( var_4a3ded66 in var_50a9e5d9 )
    {
        if ( !skip )
        {
            var_4a3ded66 rotateto( var_4a3ded66.originalangles + rotateangles, rotatetime );
            wait waittime;
        }
        
        skip = !skip;
    }
}

// Namespace mp_metro_train
// Params 12
// Checksum 0x7f8d3134, Offset: 0x1250
// Size: 0xc70
function train_think( cars, dividers, notifier, start, gate_a, gate_b, var_9071646e, var_fbb2796a, var_4eb99366, var_5f47c084, var_c4ecec2, trackside )
{
    level endon( #"game_ended" );
    
    foreach ( gate in gate_a )
    {
        gate.originalangles = gate.angles;
    }
    
    foreach ( gate in gate_b )
    {
        gate.originalangles = gate.angles;
    }
    
    foreach ( gate in var_9071646e )
    {
        gate.originalangles = gate.angles;
    }
    
    foreach ( barrier in var_fbb2796a )
    {
        barrier.originalorigin = barrier.origin;
    }
    
    var_ddb7f7d7 = ( 0, 90, 0 );
    
    if ( trackside == "left" )
    {
        var_ddb7f7d7 *= -1;
    }
    
    for ( ;; )
    {
        level waittill( notifier );
        
        foreach ( speaker in var_c4ecec2 )
        {
            playsoundatposition( "vox_metr_metro_approaching", speaker.origin );
        }
        
        metro_vox_wait_time = getdvarfloat( "metro_vox_wait_time", 4 );
        wait metro_vox_wait_time;
        gate_move_time = getdvarfloat( "gate_move_time", 2 );
        gate_end_move_time = getdvarfloat( "gate_end_move_time", 1 );
        var_b909fdbf = getdvarfloat( "gate_wait_time", 0.3 );
        gate_a[ 0 ] playloopsound( "amb_train_alarm" );
        gate_b[ 0 ] playloopsound( "amb_train_alarm" );
        barrier_move_time = getdvarfloat( "barrier_move_time", 2 );
        barrier_move_height = getdvarfloat( "barrier_move_height", 30 );
        
        foreach ( barrier in var_fbb2796a )
        {
            barrier moveto( barrier.origin + ( 0, 0, barrier_move_height ), barrier_move_time );
            barrier playsound( "evt_wall_up" );
        }
        
        gate_wait_train_time = getdvarfloat( "gate_wait_train_time", 5 );
        wait gate_wait_train_time;
        cars[ 0 ] attachpath( start );
        cars[ 0 ] startpath();
        cars[ 0 ] showaftertime( 0.1 );
        cars[ 0 ] thread record_positions( trackside );
        cars[ 0 ] playloopsound( "amb_train_by" );
        max_cars = getdvarint( "train_length", 10 );
        
        for ( i = 1; i < max_cars ; i++ )
        {
            wait 0.3;
            dividers[ i ] thread car_move( trackside );
            dividers[ i ] thread watch_player_touch();
            wait 0.3;
            cars[ i ] thread car_move( trackside );
            cars[ i ] thread watch_player_touch();
            cars[ i ] playloopsound( "amb_train_by" );
        }
        
        foreach ( speaker in var_c4ecec2 )
        {
            playsoundatposition( "vox_metr_metro_gap", speaker.origin );
        }
        
        level thread function_1b3e50b5( var_9071646e, 1, gate_end_move_time, var_ddb7f7d7 * -1, 0 );
        var_9071646e[ 0 ] playsound( "evt_gate_open" );
        var_5f47c084 function_a202446a( 0, 0, gate_end_move_time );
        level thread function_1b3e50b5( gate_a, var_b909fdbf, gate_move_time, var_ddb7f7d7, 0 );
        gate_a[ 0 ] playsound( "evt_gate_open" );
        level thread function_1b3e50b5( gate_b, var_b909fdbf, gate_move_time, var_ddb7f7d7, 1 );
        gate_b[ 0 ] playsound( "evt_gate_open" );
        var_4eb99366 function_a202446a( 1, 0, gate_move_time );
        wait getdvarfloat( "gate_wait_close_door_end", 8 );
        level thread function_1b3e50b5( var_9071646e, 1, gate_move_time, ( 0, 0, 0 ), 0 );
        var_9071646e[ 0 ] playsound( "evt_gate_close" );
        var_5f47c084 function_a202446a( 0, 0, gate_move_time );
        wait getdvarfloat( "gate_wait_close_doors", 4 );
        level thread function_1b3e50b5( gate_a, var_b909fdbf, gate_move_time, ( 0, 0, 0 ), 0 );
        gate_a[ 0 ] playsound( "evt_gate_close" );
        level thread function_1b3e50b5( gate_b, var_b909fdbf, gate_move_time, ( 0, 0, 0 ), 1 );
        gate_b[ 0 ] playsound( "evt_gate_close" );
        var_4eb99366 function_a202446a( 0, 0, gate_move_time );
        var_4eb99366 function_a202446a( 1, gate_move_time, 0.25 );
        
        foreach ( barrier in var_fbb2796a )
        {
            barrier moveto( barrier.originalorigin, barrier_move_time );
            barrier playsound( "evt_wall_down" );
        }
        
        gate_a[ 0 ] stoploopsound( 2 );
        gate_b[ 0 ] stoploopsound( 2 );
        cars[ 0 ] waittill( #"reached_end_node" );
        cars[ 0 ] stoploopsound( 2 );
        
        for ( i = 1; i < max_cars ; i++ )
        {
            cars[ i ] ghost();
            cars[ i ] notify( #"stop_kill" );
            dividers[ i ] ghost();
            dividers[ i ] notify( #"stop_kill" );
            cars[ i ] stoploopsound( 2 );
        }
        
        cars[ 0 ] notify( #"stop_kill" );
        cars[ 0 ] ghost();
    }
}

// Namespace mp_metro_train
// Params 1
// Checksum 0x24112229, Offset: 0x1ec8
// Size: 0x2c8
function record_positions( tracknum )
{
    self endon( #"reached_end_node" );
    level.train_positions[ tracknum ] = [];
    level.train_angles[ tracknum ] = [];
    
    if ( tracknum == "left" )
    {
        var_d5a44988 = getdvarint( "train_position_start_water_left", 205 );
        var_b8428bfa = getdvarint( "train_dust_kickup_1_left", 150 );
        var_92401191 = getdvarint( "train_dust_kickup_2_left", 174 );
        var_6c3d9728 = getdvarint( "train_dust_kickup_3_left", 200 );
    }
    else
    {
        var_d5a44988 = getdvarint( "train_position_start_water_right", 205 );
        var_b8428bfa = getdvarint( "train_dust_kickup_1_right", 150 );
        var_92401191 = getdvarint( "train_dust_kickup_1_right", 174 );
        var_6c3d9728 = getdvarint( "train_dust_kickup_1_right", 200 );
    }
    
    for ( ;; )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        level.train_positions[ tracknum ][ level.train_positions[ tracknum ].size ] = self.origin;
        level.train_angles[ tracknum ][ level.train_angles[ tracknum ].size ] = self.angles;
        
        if ( level.train_angles[ tracknum ].size == var_d5a44988 )
        {
            playfxontag( level._effect[ "fx_water_train_mist_kick_up_metro" ], self, "tag_origin" );
        }
        else if ( level.train_angles[ tracknum ].size == var_b8428bfa )
        {
            level thread dust_kickup( 1, tracknum );
        }
        else if ( level.train_angles[ tracknum ].size == var_92401191 )
        {
            level thread dust_kickup( 2, tracknum );
        }
        else if ( level.train_angles[ tracknum ].size == var_6c3d9728 )
        {
            level thread dust_kickup( 3, tracknum );
        }
        
        wait 0.05;
    }
}

// Namespace mp_metro_train
// Params 2
// Checksum 0x428d0496, Offset: 0x2198
// Size: 0x74
function dust_kickup( index, trackside )
{
    explodername = "Train_dust_kickup_" + index + "_" + trackside;
    exploder::exploder( explodername );
    wait 5.5;
    exploder::stop_exploder( explodername );
}

// Namespace mp_metro_train
// Params 1
// Checksum 0x29fc7808, Offset: 0x2218
// Size: 0x186
function car_move( tracknum )
{
    self endon( #"stop_kill" );
    
    if ( tracknum == "left" )
    {
        var_d5a44988 = getdvarint( "train_position_start_water_left", 205 );
    }
    else
    {
        var_d5a44988 = getdvarint( "train_position_start_water_right", 205 );
    }
    
    for ( i = 0; i < level.train_positions[ tracknum ].size ; i++ )
    {
        if ( i == var_d5a44988 )
        {
            playfxontag( level._effect[ "fx_water_train_mist_kick_up_metro" ], self, "tag_origin" );
        }
        
        self.origin = level.train_positions[ tracknum ][ i ];
        self.angles = level.train_angles[ tracknum ][ i ];
        
        if ( isdefined( self.var_48adb15 ) && self.var_48adb15 == 1 )
        {
            self.angles += ( 0, 180, 0 );
        }
        
        wait 0.05;
        
        if ( i == 4 )
        {
            self show();
        }
    }
}

// Namespace mp_metro_train
// Params 0
// Checksum 0x92cb1ca2, Offset: 0x23a8
// Size: 0xb8
function watch_player_touch()
{
    self endon( #"end_of_track" );
    self endon( #"stop_kill" );
    self endon( #"delete" );
    self endon( #"death" );
    self.disablefinalkillcam = 1;
    
    for ( ;; )
    {
        self waittill( #"touch", entity );
        
        if ( isplayer( entity ) )
        {
            entity dodamage( entity.health * 2, self.origin + ( 0, 0, 1 ), self, self, 0, "MOD_CRUSH" );
        }
    }
}

// Namespace mp_metro_train
// Params 0
// Checksum 0xc1d2a140, Offset: 0x2468
// Size: 0x140, Type: bool
function train_setup_clock()
{
    metro_clock_1 = getent( "MP_Metro_clock_1", "targetname" );
    metro_clock_2 = getent( "MP_Metro_clock_2", "targetname" );
    
    if ( !isdefined( metro_clock_1 ) || !isdefined( metro_clock_2 ) )
    {
        return false;
    }
    
    level.clockmodel1 = util::spawn_model( "tag_origin", metro_clock_1.origin, metro_clock_1.angles );
    level.clockmodel1 clientfield::set( "mp_metro_train_timer", 1 );
    level.clockmodel2 = util::spawn_model( "tag_origin", metro_clock_2.origin, metro_clock_2.angles );
    level.clockmodel2 clientfield::set( "mp_metro_train_timer", 1 );
    return true;
}

// Namespace mp_metro_train
// Params 3
// Checksum 0x964a41, Offset: 0x25b0
// Size: 0x660
function function_a202446a( killplayers, waittime, var_24d445fd )
{
    self endon( #"hash_e0b163fa" );
    self.disablefinalkillcam = 1;
    door = self;
    corpse_delay = 0;
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    var_791e12da = 0;
    
    while ( var_24d445fd > var_791e12da )
    {
        wait 0.2;
        var_791e12da += 0.2;
        entities = getdamageableentarray( self.origin, 200 );
        
        foreach ( entity in entities )
        {
            if ( !entity istouching( self ) )
            {
                continue;
            }
            
            if ( !isalive( entity ) )
            {
                continue;
            }
            
            if ( isdefined( entity.targetname ) )
            {
                if ( entity.targetname == "talon" )
                {
                    entity notify( #"death" );
                    continue;
                }
            }
            
            if ( isdefined( entity.helitype ) && entity.helitype == "qrdrone" )
            {
                watcher = entity.owner weaponobjects::getweaponobjectwatcher( "qrdrone" );
                watcher thread weaponobjects::waitanddetonate( entity, 0, undefined );
                continue;
            }
            
            if ( entity.classname == "grenade" )
            {
                if ( !isdefined( entity.name ) )
                {
                    continue;
                }
                
                if ( !isdefined( entity.owner ) )
                {
                    continue;
                }
                
                if ( entity.name == "proximity_grenade_mp" )
                {
                    watcher = entity.owner weaponobjects::getwatcherforweapon( entity.name );
                    watcher thread weaponobjects::waitanddetonate( entity, 0, undefined, "script_mover_mp" );
                    continue;
                }
                
                if ( !entity.isequipment )
                {
                    continue;
                }
                
                watcher = entity.owner weaponobjects::getwatcherforweapon( entity.name );
                
                if ( !isdefined( watcher ) )
                {
                    continue;
                }
                
                watcher thread weaponobjects::waitanddetonate( entity, 0, undefined, "script_mover_mp" );
                continue;
            }
            
            if ( entity.classname == "auto_turret" )
            {
                if ( !isdefined( entity.damagedtodeath ) || !entity.damagedtodeath )
                {
                    entity util::domaxdamage( self.origin + ( 0, 0, 1 ), self, self, 0, "MOD_CRUSH" );
                }
                
                continue;
            }
            
            if ( !isdefined( entity.team ) || isvehicle( entity ) && entity.team != "neutral" )
            {
                entity kill();
                continue;
            }
            
            if ( killplayers == 0 && isplayer( entity ) )
            {
                continue;
            }
            
            entity dodamage( entity.health * 2, self.origin + ( 0, 0, 1 ), self, self, 0, "MOD_CRUSH" );
            
            if ( isplayer( entity ) )
            {
                corpse_delay = gettime() + 1000;
            }
        }
        
        self destroy_supply_crates();
        
        if ( gettime() > corpse_delay )
        {
            self destroy_corpses();
        }
        
        if ( level.gametype == "ctf" )
        {
            foreach ( flag in level.flags )
            {
                if ( flag.visuals[ 0 ] istouching( self ) )
                {
                    flag ctf::returnflag();
                }
            }
            
            continue;
        }
        
        if ( level.gametype == "sd" && !level.multibomb )
        {
            if ( level.sdbomb.visuals[ 0 ] istouching( self ) )
            {
                level.sdbomb gameobjects::return_home();
            }
        }
    }
}

// Namespace mp_metro_train
// Params 0
// Checksum 0x6544780f, Offset: 0x2c18
// Size: 0x15a
function destroy_supply_crates()
{
    crates = getentarray( "care_package", "script_noteworthy" );
    
    foreach ( crate in crates )
    {
        if ( distancesquared( crate.origin, self.origin ) < 40000 )
        {
            if ( crate istouching( self ) )
            {
                playfx( level._supply_drop_explosion_fx, crate.origin );
                playsoundatposition( "wpn_grenade_explode", crate.origin );
                wait 0.1;
                crate supplydrop::cratedelete();
            }
        }
    }
}

// Namespace mp_metro_train
// Params 0
// Checksum 0xadd7fbc9, Offset: 0x2d80
// Size: 0x9e
function destroy_corpses()
{
    corpses = getcorpsearray();
    
    for ( i = 0; i < corpses.size ; i++ )
    {
        if ( distancesquared( corpses[ i ].origin, self.origin ) < 40000 )
        {
            corpses[ i ] delete();
        }
    }
}

// Namespace mp_metro_train
// Params 2
// Checksum 0x42bb6cb9, Offset: 0x2e28
// Size: 0xf2
function get_closest( org, array )
{
    dist = 9999999;
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
    
    return array[ index ];
}

