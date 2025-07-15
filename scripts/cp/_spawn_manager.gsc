#using scripts/cp/_spawn_manager_debug;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/name_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace spawn_manager;

// Namespace spawn_manager
// Params 0, eflags: 0x2
// Checksum 0x27fc78a0, Offset: 0x298
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "spawn_manager", &__init__, undefined, undefined );
}

// Namespace spawn_manager
// Params 0
// Checksum 0xa1862027, Offset: 0x2d8
// Size: 0xe4
function __init__()
{
    level.spawn_manager_total_count = 0;
    level.spawn_manager_max_ai = 50;
    level.spawn_manager_active_ai = 0;
    level.spawn_manager_auto_targetname_num = 0;
    level.spawn_managers = [];
    level.spawn_managers = getentarray( "spawn_manager", "classname" );
    array::thread_all( level.spawn_managers, &spawn_manager_think );
    start_triggers();
    
    /#
        callback::on_connect( &on_player_connect );
        level thread spawn_manager_debug();
    #/
}

// Namespace spawn_manager
// Params 0
// Checksum 0x5b25470f, Offset: 0x3c8
// Size: 0x1c4
function spawn_manager_setup()
{
    assert( isdefined( self ) );
    assert( isdefined( self.target ) );
    assert( self.sm_group_size_max >= self.sm_group_size_min, "<dev string:x28>" + self.sm_id );
    
    if ( !isdefined( self.sm_spawner_count_min ) || self.sm_spawner_count_min > self.allspawners.size )
    {
        self.sm_spawner_count_min = self.allspawners.size;
    }
    
    if ( !isdefined( self.sm_spawner_count_max ) || self.sm_spawner_count_max > self.allspawners.size )
    {
        self.sm_spawner_count_max = self.allspawners.size;
    }
    
    assert( self.sm_spawner_count_max >= self.sm_spawner_count_min, "<dev string:x28>" + self.sm_id );
    self.sm_spawner_count = randomintrange( self.sm_spawner_count_min, self.sm_spawner_count_max + 1 );
    self.spawners = self spawn_manager_get_spawners();
    update_for_coop();
    assert( self.sm_group_size_min <= self.sm_active_count_max, "<dev string:x7d>" );
    
    if ( !isdefined( self.script_forcespawn ) )
    {
        self.script_forcespawn = 0;
    }
}

// Namespace spawn_manager
// Params 1
// Checksum 0xbeaf2174, Offset: 0x598
// Size: 0x164
function spawn_manager_can_spawn( spawngroupsize )
{
    totalfree = self.count >= 0 ? self.count : level.spawn_manager_max_ai;
    activefree = self.sm_active_count_max - self.activeai.size;
    canspawngroup = activefree >= spawngroupsize && totalfree >= spawngroupsize && spawngroupsize > 0;
    globalfree = level.spawn_manager_max_ai - level.spawn_manager_active_ai;
    assert( self.enable == level flag::get( "<dev string:xad>" + self.sm_id + "<dev string:xb1>" ), "<dev string:xba>" );
    
    if ( self.script_forcespawn == 0 )
    {
        return ( totalfree > 0 && activefree > 0 && globalfree > 0 && canspawngroup && self.enable );
    }
    
    return totalfree > 0 && activefree > 0 && self.enable;
}

// Namespace spawn_manager
// Params 1
// Checksum 0xbb9533ca, Offset: 0x708
// Size: 0x84
function spawn_manager_spawn( maxdelay )
{
    self endon( #"death" );
    start = gettime();
    
    while ( true )
    {
        ai = self spawner::spawn();
        
        if ( isdefined( ai ) || gettime() - start > 1000 * maxdelay )
        {
            return ai;
        }
        
        wait 0.5;
    }
}

// Namespace spawn_manager
// Params 2
// Checksum 0x618cc10, Offset: 0x798
// Size: 0x136
function spawn_manager_spawn_group( spawner, spawngroupsize )
{
    for ( i = 0; i < spawngroupsize ; i++ )
    {
        ai = undefined;
        
        if ( isdefined( spawner ) && isdefined( spawner.targetname ) )
        {
            ai = spawner spawn_manager_spawn( 2 );
            
            if ( isdefined( ai ) )
            {
                ai.sm_id = self.sm_id;
            }
        }
        else
        {
            continue;
        }
        
        if ( !spawner::spawn_failed( ai ) )
        {
            if ( isdefined( self.script_radius ) )
            {
                ai.script_radius = self.script_radius;
            }
            
            if ( isdefined( spawner.script_radius ) )
            {
                ai.script_radius = spawner.script_radius;
            }
            
            ai thread spawn_accounting( spawner, self );
        }
    }
}

// Namespace spawn_manager
// Params 2
// Checksum 0xf4aab3fb, Offset: 0x8d8
// Size: 0x15c
function spawn_accounting( spawner, manager )
{
    targetname = manager.targetname;
    classname = spawner.classname;
    level.spawn_manager_total_count++;
    manager.spawncount++;
    
    if ( manager.count > 0 )
    {
        manager.count--;
    }
    
    level.spawn_manager_active_ai++;
    origin = spawner.origin;
    manager.activeai[ manager.activeai.size ] = self;
    spawner.activeai[ spawner.activeai.size ] = self;
    self waittill( #"death" );
    
    if ( isdefined( spawner ) )
    {
        arrayremovevalue( spawner.activeai, self );
    }
    
    if ( isdefined( manager ) )
    {
        arrayremovevalue( manager.activeai, self );
    }
    
    level.spawn_manager_active_ai--;
}

// Namespace spawn_manager
// Params 0
// Checksum 0xb2e51fdd, Offset: 0xa40
// Size: 0x198
function set_defaults()
{
    if ( isdefined( self.name ) )
    {
        /#
            check_name( self.name );
        #/
        
        self.sm_id = self.name;
    }
    else if ( isdefined( self.targetname ) && !strstartswith( self.targetname, "pf" ) )
    {
        /#
            check_name( self.targetname );
        #/
        
        self.sm_id = self.targetname;
    }
    else
    {
        auto_id();
    }
    
    if ( !isdefined( self.sm_count_1player ) )
    {
        self.sm_count_1player = self.count;
    }
    
    if ( !isdefined( self.sm_active_count_min_1player ) )
    {
        self.sm_active_count_min_1player = isdefined( self.sm_active_count_min ) ? self.sm_active_count_min : level.spawn_manager_max_ai;
    }
    
    if ( !isdefined( self.sm_active_count_max_1player ) )
    {
        self.sm_active_count_max_1player = isdefined( self.sm_active_count_max ) ? self.sm_active_count_max : level.spawn_manager_max_ai;
    }
    
    if ( !isdefined( self.sm_group_size_min_1player ) )
    {
        self.sm_group_size_min_1player = isdefined( self.sm_group_size_min ) ? self.sm_group_size_min : 1;
    }
    
    if ( !isdefined( self.sm_group_size_max_1player ) )
    {
        self.sm_group_size_max_1player = isdefined( self.sm_group_size_max ) ? self.sm_group_size_max : 1;
    }
}

/#

    // Namespace spawn_manager
    // Params 1
    // Checksum 0x617d5545, Offset: 0xbe0
    // Size: 0x13a, Type: dev
    function check_name( str_name )
    {
        a_spawn_managers = getentarray( "<dev string:xf5>", "<dev string:x103>" );
        
        foreach ( sm in a_spawn_managers )
        {
            if ( sm != self )
            {
                if ( sm.targetname === str_name || sm.name === str_name )
                {
                    assertmsg( "<dev string:x10d>" + str_name + "<dev string:x13a>" + self.origin + "<dev string:x150>" + sm.origin );
                }
            }
        }
    }

#/

// Namespace spawn_manager
// Params 0
// Checksum 0x36173650, Offset: 0xd28
// Size: 0x3c
function auto_id()
{
    if ( !isdefined( level.sm_auto_id ) )
    {
        level.sm_auto_id = 0;
    }
    
    self.sm_id = "sm_auto" + level.sm_auto_id;
    level.sm_auto_id++;
}

// Namespace spawn_manager
// Params 0
// Checksum 0x4f2b672, Offset: 0xd70
// Size: 0xd0
function update_count_for_coop()
{
    if ( level.players.size >= 4 && isdefined( self.sm_count_4player ) )
    {
        n_count = self.sm_count_4player;
    }
    else if ( level.players.size >= 3 && isdefined( self.sm_count_3player ) )
    {
        n_count = self.sm_count_3player;
    }
    else if ( level.players.size >= 2 && isdefined( self.sm_count_2player ) )
    {
        n_count = self.sm_count_2player;
    }
    else
    {
        n_count = self.sm_count_1player;
    }
    
    if ( n_count > 0 )
    {
        self.count = n_count;
        return;
    }
    
    self.count = -1;
}

// Namespace spawn_manager
// Params 0
// Checksum 0x91f6d51c, Offset: 0xe48
// Size: 0xb0
function update_active_count_min_for_coop()
{
    if ( level.players.size >= 4 && isdefined( self.sm_active_count_min_4player ) )
    {
        self.sm_active_count_min = self.sm_active_count_min_4player;
        return;
    }
    
    if ( level.players.size >= 3 && isdefined( self.sm_active_count_min_3player ) )
    {
        self.sm_active_count_min = self.sm_active_count_min_3player;
        return;
    }
    
    if ( level.players.size >= 2 && isdefined( self.sm_active_count_min_2player ) )
    {
        self.sm_active_count_min = self.sm_active_count_min_2player;
        return;
    }
    
    self.sm_active_count_min = self.sm_active_count_min_1player;
}

// Namespace spawn_manager
// Params 0
// Checksum 0x6462833a, Offset: 0xf00
// Size: 0xb0
function update_active_count_max_for_coop()
{
    if ( level.players.size >= 4 && isdefined( self.sm_active_count_max_4player ) )
    {
        self.sm_active_count_max = self.sm_active_count_max_4player;
        return;
    }
    
    if ( level.players.size >= 3 && isdefined( self.sm_active_count_max_3player ) )
    {
        self.sm_active_count_max = self.sm_active_count_max_3player;
        return;
    }
    
    if ( level.players.size >= 2 && isdefined( self.sm_active_count_max_2player ) )
    {
        self.sm_active_count_max = self.sm_active_count_max_2player;
        return;
    }
    
    self.sm_active_count_max = self.sm_active_count_max_1player;
}

// Namespace spawn_manager
// Params 0
// Checksum 0x945f929c, Offset: 0xfb8
// Size: 0xb0
function update_group_size_min_for_coop()
{
    if ( level.players.size >= 4 && isdefined( self.sm_group_size_min_4player ) )
    {
        self.sm_group_size_min = self.sm_group_size_min_4player;
        return;
    }
    
    if ( level.players.size >= 3 && isdefined( self.sm_group_size_min_3player ) )
    {
        self.sm_group_size_min = self.sm_group_size_min_3player;
        return;
    }
    
    if ( level.players.size >= 2 && isdefined( self.sm_group_size_min_2player ) )
    {
        self.sm_group_size_min = self.sm_group_size_min_2player;
        return;
    }
    
    self.sm_group_size_min = self.sm_group_size_min_1player;
}

// Namespace spawn_manager
// Params 0
// Checksum 0x91b5f4fa, Offset: 0x1070
// Size: 0xb0
function update_group_size_max_for_coop()
{
    if ( level.players.size >= 4 && isdefined( self.sm_group_size_max_4player ) )
    {
        self.sm_group_size_max = self.sm_group_size_max_4player;
        return;
    }
    
    if ( level.players.size >= 3 && isdefined( self.sm_group_size_max_3player ) )
    {
        self.sm_group_size_max = self.sm_group_size_max_3player;
        return;
    }
    
    if ( level.players.size >= 2 && isdefined( self.sm_group_size_max_2player ) )
    {
        self.sm_group_size_max = self.sm_group_size_max_2player;
        return;
    }
    
    self.sm_group_size_max = self.sm_group_size_max_1player;
}

// Namespace spawn_manager
// Params 0
// Checksum 0xdc1046d0, Offset: 0x1128
// Size: 0x10a
function update_for_coop()
{
    update_count_for_coop();
    update_active_count_min_for_coop();
    update_active_count_max_for_coop();
    update_group_size_min_for_coop();
    update_group_size_max_for_coop();
    
    foreach ( sp in self.spawners )
    {
        sp update_count_for_coop();
        sp update_active_count_min_for_coop();
        sp update_active_count_max_for_coop();
    }
}

// Namespace spawn_manager
// Params 0
// Checksum 0x2d2a4116, Offset: 0x1240
// Size: 0x98
function spawn_manager_wave_wait()
{
    if ( !isdefined( self.sm_wave_wait_min ) )
    {
        self.sm_wave_wait_min = 0;
    }
    
    if ( !isdefined( self.sm_wave_wait_max ) )
    {
        self.sm_wave_wait_max = 0;
    }
    
    if ( self.sm_wave_wait_max > 0 && self.sm_wave_wait_max > self.sm_wave_wait_min )
    {
        wait randomfloatrange( self.sm_wave_wait_min, self.sm_wave_wait_max );
        return;
    }
    
    if ( self.sm_wave_wait_min > 0 )
    {
        wait self.sm_wave_wait_min;
    }
}

// Namespace spawn_manager
// Params 0
// Checksum 0x75a9ea4a, Offset: 0x12e0
// Size: 0x7c4
function spawn_manager_think()
{
    self endon( #"death" );
    self set_defaults();
    self spawn_manager_flags_setup();
    self thread spawn_manager_enable_think();
    self thread spawn_manager_kill_think();
    self.enable = 0;
    self.activeai = [];
    self.spawncount = 0;
    isfirsttime = 1;
    self.allspawners = getentarray( self.target, "targetname" );
    assert( self.allspawners.size, "<dev string:x158>" + self.sm_id + "<dev string:x168>" );
    level flag::wait_till( "sm_" + self.sm_id + "_enabled" );
    util::script_delay();
    self spawn_manager_setup();
    b_spawn_up = 1;
    self spawn_manager_get_spawn_group_size();
    
    while ( self.count != 0 && self.spawners.size > 0 )
    {
        cleanup_spawners();
        n_active = self.activeai.size;
        n_active_budget = self.sm_active_count_max - n_active;
        
        if ( !b_spawn_up && self.activeai.size <= self.sm_active_count_min )
        {
            b_spawn_up = 1;
            spawn_manager_wave_wait();
        }
        else if ( b_spawn_up && n_active_budget < self.sm_group_size )
        {
            b_spawn_up = 0;
        }
        
        if ( !b_spawn_up )
        {
            wait 0.05;
            continue;
        }
        
        self spawn_manager_get_spawn_group_size();
        
        if ( self.count > 0 )
        {
            if ( self.sm_group_size > self.count )
            {
                self.sm_group_size = self.count;
            }
        }
        
        spawned = 0;
        
        while ( !spawned )
        {
            cleanup_spawners();
            
            if ( self.spawners.size <= 0 )
            {
                break;
            }
            
            if ( self spawn_manager_can_spawn( self.sm_group_size ) )
            {
                assert( self.sm_group_size > 0 );
                potential_spawners = [];
                priority_spawners = [];
                
                for ( i = 0; i < self.spawners.size ; i++ )
                {
                    current_spawner = self.spawners[ i ];
                    
                    if ( isdefined( current_spawner ) )
                    {
                        if ( current_spawner.activeai.size > current_spawner.sm_active_count_min )
                        {
                            continue;
                        }
                        
                        spawnerfree = current_spawner.sm_active_count_max - current_spawner.activeai.size;
                        
                        if ( spawnerfree >= self.sm_group_size )
                        {
                            if ( isdefined( current_spawner.spawnflags ) && ( current_spawner.spawnflags & 32 ) == 32 )
                            {
                                priority_spawners[ priority_spawners.size ] = current_spawner;
                                continue;
                            }
                            
                            potential_spawners[ potential_spawners.size ] = current_spawner;
                        }
                    }
                }
                
                if ( potential_spawners.size > 0 || priority_spawners.size > 0 )
                {
                    if ( priority_spawners.size > 0 )
                    {
                        spawner = array::random( priority_spawners );
                    }
                    else
                    {
                        spawner = array::random( potential_spawners );
                    }
                    
                    if ( !( isdefined( spawner.spawnflags ) && ( spawner.spawnflags & 64 ) == 64 ) && spawner.count < self.sm_group_size )
                    {
                        self.sm_group_size = spawner.count;
                    }
                    
                    if ( !isfirsttime )
                    {
                        spawn_manager_wait();
                    }
                    else
                    {
                        isfirsttime = 0;
                    }
                    
                    if ( !self.enable )
                    {
                        continue;
                    }
                    
                    self spawn_manager_spawn_group( spawner, self.sm_group_size );
                    spawned = 1;
                }
                else
                {
                    spawner_max_active_count = 0;
                    
                    for ( i = 0; i < self.spawners.size ; i++ )
                    {
                        current_spawner = self.spawners[ i ];
                        
                        if ( isdefined( current_spawner ) )
                        {
                            if ( current_spawner.sm_active_count_max > spawner_max_active_count )
                            {
                                spawner_max_active_count = current_spawner.sm_active_count_max;
                            }
                        }
                    }
                    
                    if ( spawner_max_active_count < self.sm_group_size_max )
                    {
                        self.sm_group_size_max = spawner_max_active_count;
                        self spawn_manager_get_spawn_group_size();
                    }
                }
            }
            
            wait 0.05;
        }
        
        wait 0.05;
        assert( !level flag::get( "<dev string:xad>" + self.sm_id + "<dev string:x187>" ), "<dev string:xba>" );
        assert( !level flag::get( "<dev string:xad>" + self.sm_id + "<dev string:x18f>" ), "<dev string:xba>" );
        
        if ( !( isdefined( self.script_forcespawn ) && self.script_forcespawn ) )
        {
            numplayers = max( getplayers().size, 1 );
            wait laststand::player_num_in_laststand() / numplayers * 8;
        }
    }
    
    self spawn_manager_flag_complete();
    
    if ( isdefined( self.activeai ) && self.activeai.size != 0 )
    {
        array::wait_till( self.activeai, "death" );
    }
    
    self delete();
}

// Namespace spawn_manager
// Params 0
// Checksum 0x2bab9b2a, Offset: 0x1ab0
// Size: 0x74
function spawn_manager_enable_think()
{
    while ( isdefined( self ) )
    {
        self waittill( #"enable" );
        self.enable = 1;
        self spawn_manager_flag_enabled();
        self waittill( #"disable" );
        self spawn_manager_flag_disabled();
    }
    
    self spawn_manager_flag_disabled();
}

// Namespace spawn_manager
// Params 1
// Checksum 0x3b531811, Offset: 0x1b30
// Size: 0x4c
function spawn_manager_enable_trigger_think( spawn_manager )
{
    spawn_manager endon( #"death" );
    spawn_manager endon( #"enable" );
    self endon( #"death" );
    self waittill( #"trigger" );
    spawn_manager notify( #"enable" );
}

// Namespace spawn_manager
// Params 0
// Checksum 0xc2687fc9, Offset: 0x1b88
// Size: 0x14c
function spawn_manager_kill_think()
{
    self waittill( #"death" );
    sm_id = self.sm_id;
    a_spawners = self.allspawners;
    a_active_ai = self.activeai;
    level flag::clear( "sm_" + sm_id + "_enabled" );
    level flag::set( "sm_" + sm_id + "_killed" );
    level flag::set( "sm_" + sm_id + "_complete" );
    array::delete_all( a_spawners );
    
    if ( a_active_ai.size )
    {
        array::wait_till( a_active_ai, "death" );
    }
    
    level flag::set( "sm_" + sm_id + "_cleared" );
    level.spawn_managers = array::remove_undefined( level.spawn_managers );
}

// Namespace spawn_manager
// Params 1
// Checksum 0x1266c6de, Offset: 0x1ce0
// Size: 0x198
function start_triggers( trigger_type )
{
    triggers = trigger::get_all( "trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage", "trigger_box" );
    
    foreach ( trig in triggers )
    {
        if ( isdefined( trig.target ) )
        {
            targets = get_spawn_manager_array( trig.target );
            
            foreach ( target in targets )
            {
                trig thread spawn_manager_enable_trigger_think( target );
            }
        }
    }
}

// Namespace spawn_manager
// Params 1
// Checksum 0x12118e47, Offset: 0x1e80
// Size: 0x120
function get_spawn_manager_array( targetname )
{
    if ( isdefined( targetname ) )
    {
        spawn_manager_array = [];
        
        for ( i = 0; i < level.spawn_managers.size ; i++ )
        {
            if ( isdefined( level.spawn_managers[ i ] ) )
            {
                if ( level.spawn_managers[ i ].targetname === targetname || level.spawn_managers[ i ].name === targetname )
                {
                    if ( !isdefined( spawn_manager_array ) )
                    {
                        spawn_manager_array = [];
                    }
                    else if ( !isarray( spawn_manager_array ) )
                    {
                        spawn_manager_array = array( spawn_manager_array );
                    }
                    
                    spawn_manager_array[ spawn_manager_array.size ] = level.spawn_managers[ i ];
                }
            }
        }
        
        return spawn_manager_array;
    }
    
    return level.spawn_managers;
}

// Namespace spawn_manager
// Params 0
// Checksum 0x751cbd0f, Offset: 0x1fa8
// Size: 0x38c
function spawn_manager_get_spawners()
{
    arrayremovevalue( self.allspawners, undefined );
    exclude = [];
    
    for ( i = 0; i < self.allspawners.size ; i++ )
    {
        if ( isdefined( level._gamemode_norandomdogs ) && self.allspawners[ i ].classname == "actor_enemy_dog_sp" )
        {
            if ( !isdefined( exclude ) )
            {
                exclude = [];
            }
            else if ( !isarray( exclude ) )
            {
                exclude = array( exclude );
            }
            
            exclude[ exclude.size ] = self.allspawners[ i ];
        }
    }
    
    self.allspawners = array::exclude( self.allspawners, exclude );
    spawner_count_with_max_active = 0;
    
    foreach ( sp in self.allspawners )
    {
        if ( !isdefined( sp.sm_count_1player ) )
        {
            sp.sm_count_1player = sp.count;
        }
        
        if ( !isdefined( sp.sm_active_count_max_1player ) )
        {
            sp.sm_active_count_max_1player = isdefined( sp.sm_active_count_max ) ? sp.sm_active_count_max : level.spawn_manager_max_ai;
        }
        
        if ( !isdefined( sp.sm_active_count_min_1player ) )
        {
            sp.sm_active_count_min_1player = isdefined( sp.sm_active_count_min ) ? sp.sm_active_count_min : sp.sm_active_count_max_1player;
        }
        
        sp.activeai = [];
    }
    
    groupspawners = arraycopy( self.allspawners );
    spawner_count = self.sm_spawner_count;
    
    if ( spawner_count > self.allspawners.size )
    {
        spawner_count = self.allspawners.size;
    }
    
    spawners = [];
    
    while ( spawners.size < spawner_count )
    {
        spawner = array::random( groupspawners );
        
        if ( !isdefined( spawners ) )
        {
            spawners = [];
        }
        else if ( !isarray( spawners ) )
        {
            spawners = array( spawners );
        }
        
        spawners[ spawners.size ] = spawner;
        arrayremovevalue( groupspawners, spawner );
    }
    
    return spawners;
}

// Namespace spawn_manager
// Params 0
// Checksum 0xe70357d4, Offset: 0x2340
// Size: 0x5e
function spawn_manager_get_spawn_group_size()
{
    if ( self.sm_group_size_min < self.sm_group_size_max )
    {
        self.sm_group_size = randomintrange( self.sm_group_size_min, self.sm_group_size_max + 1 );
    }
    else
    {
        self.sm_group_size = self.sm_group_size_min;
    }
    
    return self.sm_group_size;
}

// Namespace spawn_manager
// Params 0
// Checksum 0x77a52018, Offset: 0x23a8
// Size: 0xc4
function cleanup_spawners()
{
    spawners = [];
    
    for ( i = 0; i < self.spawners.size ; i++ )
    {
        if ( isdefined( self.spawners[ i ] ) )
        {
            if ( self.spawners[ i ].count != 0 )
            {
                spawners[ spawners.size ] = self.spawners[ i ];
                continue;
            }
            
            self.spawners[ i ] delete();
        }
    }
    
    self.spawners = spawners;
}

// Namespace spawn_manager
// Params 0
// Checksum 0x4edb3063, Offset: 0x2478
// Size: 0x194
function spawn_manager_wait()
{
    if ( isdefined( self.script_wait ) )
    {
        wait self.script_wait;
        
        if ( isdefined( self.script_wait_add ) )
        {
            self.script_wait += self.script_wait_add;
        }
        
        return;
    }
    
    if ( isdefined( self.script_wait_min ) && isdefined( self.script_wait_max ) )
    {
        coop_scalar = 1;
        players = getplayers();
        
        if ( players.size == 2 )
        {
            coop_scalar = 0.7;
        }
        else if ( players.size == 3 )
        {
            coop_scalar = 0.5;
        }
        else if ( players.size == 4 )
        {
            coop_scalar = 0.3;
        }
        
        diff = self.script_wait_max - self.script_wait_min;
        
        if ( abs( diff ) > 0 )
        {
            wait randomfloatrange( self.script_wait_min, self.script_wait_min + diff * coop_scalar );
        }
        else
        {
            wait self.script_wait_min;
        }
        
        if ( isdefined( self.script_wait_add ) )
        {
            self.script_wait_min += self.script_wait_add;
            self.script_wait_max += self.script_wait_add;
        }
    }
}

// Namespace spawn_manager
// Params 0
// Checksum 0x47ce8276, Offset: 0x2618
// Size: 0xc4
function spawn_manager_flags_setup()
{
    level flag::init( "sm_" + self.sm_id + "_enabled" );
    level flag::init( "sm_" + self.sm_id + "_complete" );
    level flag::init( "sm_" + self.sm_id + "_killed" );
    level flag::init( "sm_" + self.sm_id + "_cleared" );
}

// Namespace spawn_manager
// Params 0
// Checksum 0xd66492a6, Offset: 0x26e8
// Size: 0x7c
function spawn_manager_flag_enabled()
{
    assert( !level flag::get( "<dev string:xad>" + self.sm_id + "<dev string:xb1>" ), "<dev string:xba>" );
    level flag::set( "sm_" + self.sm_id + "_enabled" );
}

// Namespace spawn_manager
// Params 0
// Checksum 0xbccc0114, Offset: 0x2770
// Size: 0x3c
function spawn_manager_flag_disabled()
{
    self.enable = 0;
    level flag::clear( "sm_" + self.sm_id + "_enabled" );
}

// Namespace spawn_manager
// Params 0
// Checksum 0x15daa95c, Offset: 0x27b8
// Size: 0x7c
function spawn_manager_flag_killed()
{
    assert( !level flag::get( "<dev string:xad>" + self.sm_id + "<dev string:x187>" ), "<dev string:xba>" );
    level flag::set( "sm_" + self.sm_id + "_killed" );
}

// Namespace spawn_manager
// Params 0
// Checksum 0xcd78f4a9, Offset: 0x2840
// Size: 0x7c
function spawn_manager_flag_complete()
{
    assert( !level flag::get( "<dev string:xad>" + self.sm_id + "<dev string:x18f>" ), "<dev string:xba>" );
    level flag::set( "sm_" + self.sm_id + "_complete" );
}

// Namespace spawn_manager
// Params 0
// Checksum 0xa0247fc5, Offset: 0x28c8
// Size: 0x7c
function spawn_manager_flag_cleared()
{
    assert( !level flag::get( "<dev string:xad>" + self.sm_id + "<dev string:x199>" ), "<dev string:xba>" );
    level flag::set( "sm_" + self.sm_id + "_cleared" );
}

// Namespace spawn_manager
// Params 1
// Checksum 0x646173e4, Offset: 0x2950
// Size: 0x40
function set_global_active_count( cnt )
{
    assert( cnt <= 32, "<dev string:x1a2>" );
    level.spawn_manager_max_ai = cnt;
}

// Namespace spawn_manager
// Params 4
// Checksum 0x53620539, Offset: 0x2998
// Size: 0x14c
function use_trig_when_complete( spawn_manager_targetname, trig_name, trig_key, once_only )
{
    if ( isdefined( once_only ) && once_only )
    {
        trigger = getent( trig_name, trig_key );
        assert( isdefined( trigger ), "<dev string:x1df>" + trig_key + "<dev string:x1ec>" + trig_name + "<dev string:x1f0>" );
        trigger endon( #"trigger" );
    }
    
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + spawn_manager_targetname + "_complete" );
        trigger::use( trig_name, trig_key );
        return;
    }
    
    assertmsg( "<dev string:x201>" + spawn_manager_targetname + "<dev string:x229>" );
}

// Namespace spawn_manager
// Params 4
// Checksum 0x8240c588, Offset: 0x2af0
// Size: 0x14c
function use_trig_when_cleared( spawn_manager_targetname, trig_name, trig_key, once_only )
{
    if ( isdefined( once_only ) && once_only )
    {
        trigger = getent( trig_name, trig_key );
        assert( isdefined( trigger ), "<dev string:x1df>" + trig_key + "<dev string:x1ec>" + trig_name + "<dev string:x1f0>" );
        trigger endon( #"trigger" );
    }
    
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + spawn_manager_targetname + "_cleared" );
        trigger::use( trig_name, trig_key );
        return;
    }
    
    assertmsg( "<dev string:x236>" + spawn_manager_targetname + "<dev string:x229>" );
}

// Namespace spawn_manager
// Params 4
// Checksum 0x1e036be0, Offset: 0x2c48
// Size: 0x14c
function use_trig_when_enabled( spawn_manager_targetname, trig_name, trig_key, once_only )
{
    if ( isdefined( once_only ) && once_only )
    {
        trigger = getent( trig_name, trig_key );
        assert( isdefined( trigger ), "<dev string:x1df>" + trig_key + "<dev string:x1ec>" + trig_name + "<dev string:x1f0>" );
        trigger endon( #"trigger" );
    }
    
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + spawn_manager_targetname + "_enabled" );
        trigger::use( trig_name, trig_key );
        return;
    }
    
    assertmsg( "<dev string:x236>" + spawn_manager_targetname + "<dev string:x229>" );
}

// Namespace spawn_manager
// Params 8
// Checksum 0x292ca172, Offset: 0x2da0
// Size: 0x10c
function run_func_when_complete( spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5 )
{
    assert( isdefined( process ), "<dev string:x260>" );
    assert( level flag::exists( "<dev string:xad>" + spawn_manager_targetname + "<dev string:xb1>" ), "<dev string:x294>" + spawn_manager_targetname + "<dev string:x229>" );
    wait_till_complete( spawn_manager_targetname );
    util::single_func( ent, process, var1, var2, var3, var4, var5 );
}

// Namespace spawn_manager
// Params 8
// Checksum 0xed260135, Offset: 0x2eb8
// Size: 0x10c
function run_func_when_cleared( spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5 )
{
    assert( isdefined( process ), "<dev string:x2bc>" );
    assert( level flag::exists( "<dev string:xad>" + spawn_manager_targetname + "<dev string:xb1>" ), "<dev string:x2ef>" + spawn_manager_targetname + "<dev string:x229>" );
    wait_till_cleared( spawn_manager_targetname );
    util::single_func( ent, process, var1, var2, var3, var4, var5 );
}

// Namespace spawn_manager
// Params 8
// Checksum 0xa8013596, Offset: 0x2fd0
// Size: 0x10c
function run_func_when_enabled( spawn_manager_targetname, process, ent, var1, var2, var3, var4, var5 )
{
    assert( isdefined( process ), "<dev string:x316>" );
    assert( level flag::exists( "<dev string:xad>" + spawn_manager_targetname + "<dev string:xb1>" ), "<dev string:x349>" + spawn_manager_targetname + "<dev string:x229>" );
    wait_till_enabled( spawn_manager_targetname );
    util::single_func( ent, process, var1, var2, var3, var4, var5 );
}

// Namespace spawn_manager
// Params 2
// Checksum 0x9c323a2d, Offset: 0x30e8
// Size: 0x124
function enable( spawn_manager_targetname, no_assert )
{
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        foreach ( sm in level.spawn_managers )
        {
            if ( isdefined( sm ) && sm.sm_id == spawn_manager_targetname )
            {
                sm notify( #"enable" );
                return;
            }
        }
        
        return;
    }
    
    if ( !( isdefined( no_assert ) && no_assert ) )
    {
        assertmsg( "<dev string:x370>" + spawn_manager_targetname + "<dev string:x229>" );
    }
}

// Namespace spawn_manager
// Params 2
// Checksum 0x5145bf25, Offset: 0x3218
// Size: 0x124
function disable( spawn_manager_targetname, no_assert )
{
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        foreach ( sm in level.spawn_managers )
        {
            if ( isdefined( sm ) && sm.sm_id == spawn_manager_targetname )
            {
                sm notify( #"disable" );
                return;
            }
        }
        
        return;
    }
    
    if ( !( isdefined( no_assert ) && no_assert ) )
    {
        assertmsg( "<dev string:x388>" + spawn_manager_targetname + "<dev string:x229>" );
    }
}

// Namespace spawn_manager
// Params 2
// Checksum 0x73fab842, Offset: 0x3348
// Size: 0x14c
function kill( spawn_manager_targetname, no_assert )
{
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        foreach ( sm in level.spawn_managers )
        {
            if ( isdefined( sm ) && sm.sm_id == spawn_manager_targetname )
            {
                sm delete();
                level.spawn_managers = array::remove_undefined( level.spawn_managers );
                return;
            }
        }
        
        return;
    }
    
    if ( !( isdefined( no_assert ) && no_assert ) )
    {
        assertmsg( "<dev string:x3a1>" + spawn_manager_targetname + "<dev string:x229>" );
    }
}

// Namespace spawn_manager
// Params 1
// Checksum 0xe35129a3, Offset: 0x34a0
// Size: 0x9c
function is_enabled( spawn_manager_targetname )
{
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        if ( level flag::get( "sm_" + spawn_manager_targetname + "_enabled" ) )
        {
            return 1;
        }
        
        return 0;
    }
    
    assertmsg( "<dev string:x3b7>" + spawn_manager_targetname + "<dev string:x229>" );
}

// Namespace spawn_manager
// Params 1
// Checksum 0x53b0ac1f, Offset: 0x3548
// Size: 0x9c
function is_complete( spawn_manager_targetname )
{
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        if ( level flag::get( "sm_" + spawn_manager_targetname + "_complete" ) )
        {
            return 1;
        }
        
        return 0;
    }
    
    assertmsg( "<dev string:x3d3>" + spawn_manager_targetname + "<dev string:x229>" );
}

// Namespace spawn_manager
// Params 1
// Checksum 0x139c59aa, Offset: 0x35f0
// Size: 0x9c
function is_cleared( spawn_manager_targetname )
{
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        if ( level flag::get( "sm_" + spawn_manager_targetname + "_cleared" ) )
        {
            return 1;
        }
        
        return 0;
    }
    
    assertmsg( "<dev string:x3f0>" + spawn_manager_targetname + "<dev string:x229>" );
}

// Namespace spawn_manager
// Params 1
// Checksum 0x417f75c4, Offset: 0x3698
// Size: 0x9c
function is_killed( spawn_manager_targetname )
{
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        if ( level flag::get( "sm_" + spawn_manager_targetname + "_killed" ) )
        {
            return 1;
        }
        
        return 0;
    }
    
    assertmsg( "<dev string:x40c>" + spawn_manager_targetname + "<dev string:x229>" );
}

// Namespace spawn_manager
// Params 1
// Checksum 0x1e8a7dab, Offset: 0x3740
// Size: 0x8c
function wait_till_cleared( spawn_manager_targetname )
{
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + spawn_manager_targetname + "_cleared" );
        return;
    }
    
    assertmsg( "<dev string:x427>" + spawn_manager_targetname + "<dev string:x229>" );
}

// Namespace spawn_manager
// Params 2
// Checksum 0x42954ba5, Offset: 0x37d8
// Size: 0x134
function wait_till_ai_remaining( spawn_manager_targetname, count_to_reach )
{
    assert( isdefined( count_to_reach ), "<dev string:x44a>" );
    assert( count_to_reach, "<dev string:x490>" );
    
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + spawn_manager_targetname + "_complete" );
    }
    else
    {
        assertmsg( "<dev string:x4ee>" + spawn_manager_targetname + "<dev string:x229>" );
    }
    
    if ( level flag::get( "sm_" + spawn_manager_targetname + "_cleared" ) )
    {
        return;
    }
    
    while ( get_ai( spawn_manager_targetname ).size > count_to_reach )
    {
        wait 0.1;
    }
}

// Namespace spawn_manager
// Params 1
// Checksum 0xe9ddf758, Offset: 0x3918
// Size: 0x8c
function wait_till_complete( spawn_manager_targetname )
{
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + spawn_manager_targetname + "_complete" );
        return;
    }
    
    assertmsg( "<dev string:x516>" + spawn_manager_targetname + "<dev string:x229>" );
}

// Namespace spawn_manager
// Params 1
// Checksum 0xb3d03906, Offset: 0x39b0
// Size: 0x8c
function wait_till_enabled( spawn_manager_targetname )
{
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + spawn_manager_targetname + "_enabled" );
        return;
    }
    
    assertmsg( "<dev string:x53a>" + spawn_manager_targetname + "<dev string:x229>" );
}

// Namespace spawn_manager
// Params 2
// Checksum 0x6f9cfc62, Offset: 0x3a48
// Size: 0x16c
function wait_till_spawned_count( spawn_manager_targetname, count )
{
    if ( level flag::exists( "sm_" + spawn_manager_targetname + "_enabled" ) )
    {
        level flag::wait_till( "sm_" + spawn_manager_targetname + "_enabled" );
    }
    else
    {
        assertmsg( "<dev string:x55d>" + spawn_manager_targetname + "<dev string:x229>" );
    }
    
    spawn_manager = get_spawn_manager_array( spawn_manager_targetname );
    assert( spawn_manager.size, "<dev string:x586>" );
    assert( spawn_manager.size == 1, "<dev string:x5cf>" );
    
    while ( true )
    {
        if ( isdefined( spawn_manager[ 0 ].spawncount ) && spawn_manager[ 0 ].spawncount < count && !is_killed( spawn_manager_targetname ) )
        {
            wait 0.5;
            continue;
        }
        
        break;
    }
}

// Namespace spawn_manager
// Params 1
// Checksum 0x964e17d3, Offset: 0x3bc0
// Size: 0x3c
function get_ai( spawn_manager_targetname )
{
    a_ai = getaiarray( spawn_manager_targetname, "sm_id" );
    return a_ai;
}

