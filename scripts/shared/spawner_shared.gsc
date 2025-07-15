#using scripts/codescripts/struct;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/serverfaceanim_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;

#namespace spawner;

// Namespace spawner
// Params 0, eflags: 0x2
// Checksum 0x3503196b, Offset: 0x418
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "spawner", &__init__, &__main__, undefined );
}

// Namespace spawner
// Params 0
// Checksum 0x650b8de, Offset: 0x460
// Size: 0x2b4
function __init__()
{
    if ( getdvarstring( "noai" ) == "" )
    {
        setdvar( "noai", "off" );
    }
    
    level._nextcoverprint = 0;
    level._ai_group = [];
    level.killedaxis = 0;
    level.ffpoints = 0;
    level.missionfailed = 0;
    level.gather_delay = [];
    level.smoke_thrown = [];
    level.deathflags = [];
    level.spawner_number = 0;
    level.go_to_node_arrays = [];
    level.next_health_drop_time = 0;
    level.guys_to_die_before_next_health_drop = randomintrange( 1, 4 );
    level.portable_mg_gun_tag = "J_Shoulder_RI";
    level.mg42_hide_distance = 1024;
    level.global_spawn_timer = 0;
    level.global_spawn_count = 0;
    
    if ( !isdefined( level.maxfriendlies ) )
    {
        level.maxfriendlies = 11;
    }
    
    level.ai_classname_in_level = [];
    spawners = getspawnerarray();
    
    for ( i = 0; i < spawners.size ; i++ )
    {
        spawners[ i ] thread spawn_prethink();
    }
    
    thread process_deathflags();
    precache_player_weapon_drops( array( "rpg" ) );
    goal_volume_init();
    level thread spawner_targets_init();
    level.ai = [];
    add_global_spawn_function( "axis", &global_ai_array );
    add_global_spawn_function( "allies", &global_ai_array );
    add_global_spawn_function( "team3", &global_ai_array );
    level thread update_nav_triggers();
}

// Namespace spawner
// Params 0
// Checksum 0xe7567a93, Offset: 0x720
// Size: 0x114
function __main__()
{
    waittillframeend();
    ai = getaispeciesarray( "all" );
    array::thread_all( ai, &living_ai_prethink );
    
    foreach ( ai_guy in ai )
    {
        if ( isalive( ai_guy ) )
        {
            ai_guy.overrideactorkilled = &callback_track_dead_npcs_by_type;
            ai_guy thread spawn_think();
        }
    }
    
    level thread spawn_throttle_reset();
}

// Namespace spawner
// Params 0
// Checksum 0x4ce4eea3, Offset: 0x840
// Size: 0x120
function update_nav_triggers()
{
    level.valid_navmesh_positions = [];
    a_nav_triggers = getentarray( "trigger_navmesh", "classname" );
    
    if ( !a_nav_triggers.size )
    {
        return;
    }
    
    level.navmesh_zones = [];
    
    foreach ( trig in a_nav_triggers )
    {
        level.navmesh_zones[ trig.targetname ] = 0;
    }
    
    while ( true )
    {
        updatenavtriggers();
        level util::waittill_notify_or_timeout( "update_nav_triggers", 1 );
    }
}

// Namespace spawner
// Params 0
// Checksum 0xa90ea074, Offset: 0x968
// Size: 0x2b4
function global_ai_array()
{
    if ( !isdefined( level.ai[ self.team ] ) )
    {
        level.ai[ self.team ] = [];
    }
    else if ( !isarray( level.ai[ self.team ] ) )
    {
        level.ai[ self.team ] = array( level.ai[ self.team ] );
    }
    
    level.ai[ self.team ][ level.ai[ self.team ].size ] = self;
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( level.ai ) && isdefined( level.ai[ self.team ] ) && isinarray( level.ai[ self.team ], self ) )
        {
            arrayremovevalue( level.ai[ self.team ], self );
        }
        else
        {
            foreach ( aiarray in level.ai )
            {
                if ( isinarray( aiarray, self ) )
                {
                    arrayremovevalue( aiarray, self );
                    break;
                }
            }
        }
        
        return;
    }
    
    foreach ( array in level.ai )
    {
        for ( i = array.size - 1; i >= 0 ; i-- )
        {
            if ( !isdefined( array[ i ] ) )
            {
                arrayremoveindex( array, i );
            }
        }
    }
}

// Namespace spawner
// Params 0
// Checksum 0xab53b5a5, Offset: 0xc28
// Size: 0x3c
function spawn_throttle_reset()
{
    while ( true )
    {
        util::wait_network_frame();
        util::wait_network_frame();
        level.global_spawn_count = 0;
    }
}

// Namespace spawner
// Params 1
// Checksum 0xee27373e, Offset: 0xc70
// Size: 0x48
function global_spawn_throttle( n_count_per_network_frame )
{
    if ( !( isdefined( level.first_frame ) && level.first_frame ) )
    {
        while ( level.global_spawn_count >= n_count_per_network_frame )
        {
            wait 0.05;
        }
        
        level.global_spawn_count++;
    }
}

// Namespace spawner
// Params 0
// Checksum 0x1787f7b3, Offset: 0xcc0
// Size: 0x4
function callback_track_dead_npcs_by_type()
{
    
}

// Namespace spawner
// Params 0
// Checksum 0xc4f58ea2, Offset: 0xcd0
// Size: 0xec
function goal_volume_init()
{
    volumes = getentarray( "info_volume", "classname" );
    level.deathchain_goalvolume = [];
    level.goalvolumes = [];
    
    for ( i = 0; i < volumes.size ; i++ )
    {
        volume = volumes[ i ];
        
        if ( isdefined( volume.script_deathchain ) )
        {
            level.deathchain_goalvolume[ volume.script_deathchain ] = volume;
        }
        
        if ( isdefined( volume.script_goalvolume ) )
        {
            level.goalvolumes[ volume.script_goalvolume ] = volume;
        }
    }
}

// Namespace spawner
// Params 1
// Checksum 0x3467519c, Offset: 0xdc8
// Size: 0x10e
function precache_player_weapon_drops( weapon_names )
{
    level.ai_classname_in_level_keys = getarraykeys( level.ai_classname_in_level );
    
    for ( i = 0; i < level.ai_classname_in_level_keys.size ; i++ )
    {
        if ( weapon_names.size <= 0 )
        {
            break;
        }
        
        for ( j = 0; j < weapon_names.size ; j++ )
        {
            weaponname = weapon_names[ j ];
            
            if ( !issubstr( tolower( level.ai_classname_in_level_keys[ i ] ), weaponname ) )
            {
                continue;
            }
            
            arrayremovevalue( weapon_names, weaponname );
            break;
        }
    }
    
    level.ai_classname_in_level_keys = undefined;
}

// Namespace spawner
// Params 0
// Checksum 0x3287c083, Offset: 0xee0
// Size: 0xce
function process_deathflags()
{
    keys = getarraykeys( level.deathflags );
    level.deathflags = [];
    
    for ( i = 0; i < keys.size ; i++ )
    {
        deathflag = keys[ i ];
        level.deathflags[ deathflag ] = [];
        level.deathflags[ deathflag ][ "ai" ] = [];
        
        if ( !isdefined( level.flag[ deathflag ] ) )
        {
            level flag::init( deathflag );
        }
    }
}

// Namespace spawner
// Params 0
// Checksum 0xea2265f5, Offset: 0xfb8
// Size: 0x1c
function spawn_guys_until_death_or_no_count()
{
    self endon( #"death" );
    self waittill( #"count_gone" );
}

// Namespace spawner
// Params 1
// Checksum 0xd26305c6, Offset: 0xfe0
// Size: 0x7c
function flood_spawner_scripted( spawners )
{
    assert( isdefined( spawners ) && spawners.size, "<dev string:x28>" );
    array::thread_all( spawners, &flood_spawner_init );
    array::thread_all( spawners, &flood_spawner_think );
}

// Namespace spawner
// Params 1
// Checksum 0x58c09da9, Offset: 0x1068
// Size: 0x3c
function reincrement_count_if_deleted( spawner )
{
    spawner endon( #"death" );
    self waittill( #"death" );
    
    if ( !isdefined( self ) )
    {
        spawner.count++;
    }
}

// Namespace spawner
// Params 1
// Checksum 0xf80ab128, Offset: 0x10b0
// Size: 0x64
function kill_trigger( trigger )
{
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    if ( isdefined( trigger.targetname ) && trigger.targetname != "flood_spawner" )
    {
        return;
    }
    
    trigger delete();
}

// Namespace spawner
// Params 0
// Checksum 0x1231d3f3, Offset: 0x1120
// Size: 0x1c
function waittilldeathorpaindeath()
{
    self endon( #"death" );
    self waittill( #"pain_death" );
}

// Namespace spawner
// Params 0
// Checksum 0x8d189b6e, Offset: 0x1148
// Size: 0x15c
function drop_gear()
{
    team = self.team;
    waittilldeathorpaindeath();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.grenadeammo <= 0 )
    {
        return;
    }
    
    if ( isdefined( self.dropweapon ) && !self.dropweapon )
    {
        return;
    }
    
    if ( !isdefined( level.nextgrenadedrop ) )
    {
        level.nextgrenadedrop = randomint( 3 );
    }
    
    level.nextgrenadedrop--;
    
    if ( level.nextgrenadedrop > 0 )
    {
        return;
    }
    
    level.nextgrenadedrop = 2 + randomint( 2 );
    spawn_grenade_bag( self.origin + ( randomint( 25 ) - 12, randomint( 25 ) - 12, 2 ) + ( 0, 0, 42 ), ( 0, randomint( 360 ), 0 ), self.team );
}

// Namespace spawner
// Params 3
// Checksum 0x6f787029, Offset: 0x12b0
// Size: 0x174
function spawn_grenade_bag( origin, angles, team )
{
    if ( !isdefined( level.grenade_cache ) || !isdefined( level.grenade_cache[ team ] ) )
    {
        level.grenade_cache_index[ team ] = 0;
        level.grenade_cache[ team ] = [];
    }
    
    index = level.grenade_cache_index[ team ];
    grenade = level.grenade_cache[ team ][ index ];
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
    
    count = self.grenadeammo;
    grenade = sys::spawn( "weapon_" + self.grenadeweapon.name + level.game_mode_suffix, origin );
    level.grenade_cache[ team ][ index ] = grenade;
    level.grenade_cache_index[ team ] = ( index + 1 ) % 16;
    grenade.angles = angles;
    grenade.count = count;
}

// Namespace spawner
// Params 0
// Checksum 0xb9ee2ecc, Offset: 0x1430
// Size: 0x124
function spawn_prethink()
{
    assert( self != level );
    level.ai_classname_in_level[ self.classname ] = 1;
    
    /#
        if ( getdvarstring( "<dev string:x59>" ) != "<dev string:x5e>" )
        {
            self.count = 0;
            return;
        }
    #/
    
    if ( isdefined( self.script_aigroup ) )
    {
        aigroup_init( self.script_aigroup, self );
    }
    
    if ( isdefined( self.script_delete ) )
    {
        array_size = 0;
        
        if ( isdefined( level._ai_delete ) )
        {
            if ( isdefined( level._ai_delete[ self.script_delete ] ) )
            {
                array_size = level._ai_delete[ self.script_delete ].size;
            }
        }
        
        level._ai_delete[ self.script_delete ][ array_size ] = self;
    }
    
    if ( isdefined( self.target ) )
    {
        crawl_through_targets_to_init_flags();
    }
}

// Namespace spawner
// Params 0
// Checksum 0xd3e9150d, Offset: 0x1560
// Size: 0x5e
function update_nav_triggers_for_actor()
{
    level notify( #"update_nav_triggers" );
    
    while ( isalive( self ) )
    {
        self util::waittill_either( "death", "goal_changed" );
        level notify( #"update_nav_triggers" );
    }
}

// Namespace spawner
// Params 1
// Checksum 0x85444f87, Offset: 0x15c8
// Size: 0x266
function spawn_think( spawner )
{
    self endon( #"death" );
    
    if ( isdefined( self.spawn_think_thread_active ) )
    {
        return;
    }
    
    self.spawn_think_thread_active = 1;
    self.spawner = spawner;
    assert( isactor( self ) || isvehicle( self ), "spawner::spawn_think" + "<dev string:x62>" );
    
    if ( !isvehicle( self ) )
    {
        if ( !isalive( self ) )
        {
            return;
        }
        
        self.maxhealth = self.health;
        self thread update_nav_triggers_for_actor();
    }
    
    self.script_animname = undefined;
    
    if ( isdefined( self.script_aigroup ) )
    {
        level flag::set( self.script_aigroup + "_spawning" );
        self thread aigroup_think( level._ai_group[ self.script_aigroup ] );
    }
    
    if ( isdefined( spawner ) && isdefined( spawner.script_dropammo ) )
    {
        self.disableammodrop = !spawner.script_dropammo;
    }
    
    if ( isdefined( spawner ) && isdefined( spawner.spawn_funcs ) )
    {
        self.spawn_funcs = spawner.spawn_funcs;
    }
    
    if ( isai( self ) )
    {
        spawn_think_action( spawner );
        assert( isalive( self ) );
        assert( isdefined( self.team ) );
    }
    
    self thread run_spawn_functions();
    self.finished_spawning = 1;
    self notify( #"hash_f42b7e06" );
}

// Namespace spawner
// Params 0
// Checksum 0x752232f9, Offset: 0x1838
// Size: 0x28e
function run_spawn_functions()
{
    self endon( #"death" );
    
    if ( !isdefined( level.spawn_funcs ) )
    {
        return;
    }
    
    if ( isdefined( self.archetype ) && isdefined( level.spawn_funcs[ self.archetype ] ) )
    {
        for ( i = 0; i < level.spawn_funcs[ self.archetype ].size ; i++ )
        {
            func = level.spawn_funcs[ self.archetype ][ i ];
            util::single_thread( self, func[ "function" ], func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ], func[ "param5" ] );
        }
    }
    
    waittillframeend();
    callback::callback( #"hash_f96ca9bc" );
    
    if ( isdefined( level.spawn_funcs[ self.team ] ) )
    {
        for ( i = 0; i < level.spawn_funcs[ self.team ].size ; i++ )
        {
            func = level.spawn_funcs[ self.team ][ i ];
            util::single_thread( self, func[ "function" ], func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ], func[ "param5" ] );
        }
    }
    
    if ( isdefined( self.spawn_funcs ) )
    {
        for ( i = 0; i < self.spawn_funcs.size ; i++ )
        {
            func = self.spawn_funcs[ i ];
            util::single_thread( self, func[ "function" ], func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ], func[ "param5" ] );
        }
        
        /#
            return;
        #/
        
        self.spawn_funcs = undefined;
    }
}

// Namespace spawner
// Params 0
// Checksum 0xfe06d25f, Offset: 0x1ad0
// Size: 0x44
function living_ai_prethink()
{
    if ( isdefined( self.script_deathflag ) )
    {
        level.deathflags[ self.script_deathflag ] = 1;
    }
    
    if ( isdefined( self.target ) )
    {
        crawl_through_targets_to_init_flags();
    }
}

// Namespace spawner
// Params 0
// Checksum 0xb967abec, Offset: 0x1b20
// Size: 0xae
function crawl_through_targets_to_init_flags()
{
    array = get_node_funcs_based_on_target();
    
    if ( isdefined( array ) )
    {
        targets = array[ "node" ];
        get_func = array[ "get_target_func" ];
        
        for ( i = 0; i < targets.size ; i++ )
        {
            crawl_target_and_init_flags( targets[ i ], get_func );
        }
    }
}

// Namespace spawner
// Params 0
// Checksum 0xb7fb3a9b, Offset: 0x1bd8
// Size: 0xe
function remove_spawner_values()
{
    self.spawner_number = undefined;
}

// Namespace spawner
// Params 1
// Checksum 0x6caf08f8, Offset: 0x1bf0
// Size: 0x680
function spawn_think_action( spawner )
{
    remove_spawner_values();
    
    if ( isdefined( level._use_faceanim ) && level._use_faceanim )
    {
        self thread serverfaceanim::init_serverfaceanim();
    }
    
    if ( isdefined( spawner ) )
    {
        if ( isdefined( spawner.targetname ) && !isdefined( self.targetname ) )
        {
            self.targetname = spawner.targetname + "_ai";
        }
    }
    
    if ( isdefined( spawner ) && isdefined( spawner.script_animname ) )
    {
        self.animname = spawner.script_animname;
    }
    else if ( isdefined( self.script_animname ) )
    {
        self.animname = self.script_animname;
    }
    
    /#
        thread show_bad_path();
    #/
    
    if ( isdefined( self.script_forcecolor ) )
    {
        colors::set_force_color( self.script_forcecolor );
        
        if ( ( !isdefined( self.script_no_respawn ) || self.script_no_respawn < 1 ) && !isdefined( level.no_color_respawners_sm ) )
        {
            self thread replace_on_death();
        }
    }
    
    if ( isdefined( self.script_moveoverride ) && self.script_moveoverride == 1 )
    {
        override = 1;
    }
    else
    {
        override = 0;
    }
    
    self.heavy_machine_gunner = issubstr( self.classname, "mgportable" );
    gameskill::grenadeawareness();
    
    if ( isdefined( self.script_ignoreme ) )
    {
        assert( self.script_ignoreme == 1, "<dev string:x86>" );
        self.ignoreme = 1;
    }
    
    if ( isdefined( self.script_hero ) )
    {
        assert( self.script_hero == 1, "<dev string:xd9>" );
    }
    
    if ( isdefined( self.script_ignoreall ) )
    {
        assert( self.script_ignoreall == 1, "<dev string:x86>" );
        self.ignoreall = 1;
    }
    
    if ( isdefined( self.script_sightrange ) )
    {
        self.maxsightdistsqrd = self.script_sightrange;
    }
    else if ( self.weaponclass === "gas" )
    {
        self.maxsightdistsqrd = 1048576;
    }
    
    if ( self.team != "axis" )
    {
        if ( isdefined( self.script_followmin ) )
        {
            self.followmin = self.script_followmin;
        }
        
        if ( isdefined( self.script_followmax ) )
        {
            self.followmax = self.script_followmax;
        }
    }
    
    if ( self.team == "axis" )
    {
        if ( isdefined( self.type ) && self.type == "human" )
        {
        }
    }
    
    if ( isdefined( self.script_fightdist ) )
    {
        self.pathenemyfightdist = self.script_fightdist;
    }
    
    if ( isdefined( self.script_maxdist ) )
    {
        self.pathenemylookahead = self.script_maxdist;
    }
    
    if ( isdefined( self.script_longdeath ) )
    {
        assert( !self.script_longdeath, "<dev string:x10c>" + self.export );
        self.a.disablelongdeath = 1;
        assert( self.team != "<dev string:x16a>", "<dev string:x171>" + self.export );
    }
    
    if ( isdefined( self.script_grenades ) )
    {
        self.grenadeammo = self.script_grenades;
    }
    
    if ( isdefined( self.script_pacifist ) )
    {
        self.pacifist = 1;
    }
    
    if ( isdefined( self.script_startinghealth ) )
    {
        self.health = self.script_startinghealth;
    }
    
    if ( isdefined( self.script_allowdeath ) )
    {
        self.allowdeath = self.script_allowdeath;
    }
    
    if ( isdefined( self.script_forcegib ) )
    {
        self.force_gib = 1;
    }
    
    if ( isdefined( self.script_lights_on ) )
    {
        self.has_ir = 1;
    }
    
    if ( isdefined( self.script_stealth ) )
    {
    }
    
    if ( isdefined( self.script_patroller ) )
    {
        return;
    }
    
    if ( isdefined( self.script_rusher ) && self.script_rusher )
    {
        return;
    }
    
    if ( isdefined( self.used_an_mg42 ) )
    {
        return;
    }
    
    if ( override )
    {
        self thread set_goalradius_based_on_settings();
        self setgoal( self.origin );
        return;
    }
    
    if ( isdefined( level.using_awareness ) && level.using_awareness )
    {
        return;
    }
    
    if ( isdefined( self.vehicleclass ) && self.vehicleclass == "artillery" )
    {
        return;
    }
    
    if ( isdefined( self.target ) )
    {
        e_goal = getent( self.target, "targetname" );
        
        if ( isdefined( e_goal ) )
        {
            self setgoal( e_goal );
        }
        else
        {
            self thread go_to_node();
        }
    }
    else
    {
        self thread set_goalradius_based_on_settings();
        
        if ( isdefined( self.script_spawner_targets ) )
        {
            self thread go_to_spawner_target( strtok( self.script_spawner_targets, " " ) );
        }
    }
    
    if ( isdefined( self.script_goalvolume ) )
    {
        self thread set_goal_volume();
    }
    
    if ( isdefined( self.script_turnrate ) )
    {
        self.turnrate = self.script_turnrate;
    }
}

// Namespace spawner
// Params 0
// Checksum 0x5045471c, Offset: 0x2278
// Size: 0x28c
function set_goal_volume()
{
    self endon( #"death" );
    waittillframeend();
    volume = level.goalvolumes[ self.script_goalvolume ];
    
    if ( !isdefined( volume ) )
    {
        return;
    }
    
    if ( isdefined( volume.target ) )
    {
        node = getnode( volume.target, "targetname" );
        ent = getent( volume.target, "targetname" );
        struct = struct::get( volume.target, "targetname" );
        pos = undefined;
        
        if ( isdefined( node ) )
        {
            pos = node;
            self setgoal( pos );
        }
        else if ( isdefined( ent ) )
        {
            pos = ent;
            self setgoal( pos.origin );
        }
        else if ( isdefined( struct ) )
        {
            pos = struct;
            self setgoal( pos.origin );
        }
        
        if ( isdefined( pos.radius ) && pos.radius != 0 )
        {
            self.goalradius = pos.radius;
        }
        
        if ( isdefined( pos.goalheight ) && pos.goalheight != 0 )
        {
            self.goalheight = pos.goalheight;
        }
    }
    
    if ( isdefined( self.target ) )
    {
        self setgoal( volume );
        return;
    }
    
    if ( isdefined( self.script_spawner_targets ) )
    {
        self waittill( #"spawner_target_set" );
        self setgoal( volume );
        return;
    }
    
    self setgoal( volume );
}

// Namespace spawner
// Params 1
// Checksum 0x5fc57d3f, Offset: 0x2510
// Size: 0x2a
function get_target_ents( target )
{
    return getentarray( target, "targetname" );
}

// Namespace spawner
// Params 1
// Checksum 0x3f161449, Offset: 0x2548
// Size: 0x2a
function get_target_nodes( target )
{
    return getnodearray( target, "targetname" );
}

// Namespace spawner
// Params 1
// Checksum 0x91273fa2, Offset: 0x2580
// Size: 0x2a
function get_target_structs( target )
{
    return struct::get_array( target, "targetname" );
}

// Namespace spawner
// Params 1
// Checksum 0xb485d7c8, Offset: 0x25b8
// Size: 0x32, Type: bool
function node_has_radius( node )
{
    return isdefined( node.radius ) && node.radius != 0;
}

// Namespace spawner
// Params 2
// Checksum 0xd39d6c93, Offset: 0x25f8
// Size: 0x3c
function go_to_origin( node, optional_arrived_at_node_func )
{
    self go_to_node( node, "origin", optional_arrived_at_node_func );
}

// Namespace spawner
// Params 2
// Checksum 0x551db46d, Offset: 0x2640
// Size: 0x3c
function go_to_struct( node, optional_arrived_at_node_func )
{
    self go_to_node( node, "struct", optional_arrived_at_node_func );
}

// Namespace spawner
// Params 3
// Checksum 0xabf37034, Offset: 0x2688
// Size: 0xd4
function go_to_node( node, goal_type, optional_arrived_at_node_func )
{
    self endon( #"death" );
    
    if ( isdefined( self.used_an_mg42 ) )
    {
        return;
    }
    
    array = get_node_funcs_based_on_target( node, goal_type );
    
    if ( !isdefined( array ) )
    {
        self notify( #"reached_path_end" );
        return;
    }
    
    if ( !isdefined( optional_arrived_at_node_func ) )
    {
        optional_arrived_at_node_func = &util::empty;
    }
    
    go_to_node_using_funcs( array[ "node" ], array[ "get_target_func" ], array[ "set_goal_func_quits" ], optional_arrived_at_node_func );
}

// Namespace spawner
// Params 0
// Checksum 0x41860e1d, Offset: 0x2768
// Size: 0x8c
function spawner_targets_init()
{
    allnodes = getallnodes();
    level.script_spawner_targets_nodes = [];
    
    for ( i = 0; i < allnodes.size ; i++ )
    {
        if ( isdefined( allnodes[ i ].script_spawner_targets ) )
        {
            level.script_spawner_targets_nodes[ level.script_spawner_targets_nodes.size ] = allnodes[ i ];
        }
    }
}

// Namespace spawner
// Params 1
// Checksum 0xa7e1fe5b, Offset: 0x2800
// Size: 0x534
function go_to_spawner_target( target_names )
{
    self endon( #"death" );
    self notify( #"go_to_spawner_target" );
    self endon( #"go_to_spawner_target" );
    nodes = [];
    a_nodes_unavailable = [];
    nodespresent = 0;
    
    for ( i = 0; i < target_names.size ; i++ )
    {
        target_nodes = get_spawner_target_nodes( target_names[ i ] );
        
        if ( target_nodes.size > 0 )
        {
            nodespresent = 1;
        }
        
        foreach ( node in target_nodes )
        {
            if ( isdefined( node.node_claimed ) && ( isnodeoccupied( node ) || node.node_claimed ) )
            {
                if ( !isdefined( a_nodes_unavailable ) )
                {
                    a_nodes_unavailable = [];
                }
                else if ( !isarray( a_nodes_unavailable ) )
                {
                    a_nodes_unavailable = array( a_nodes_unavailable );
                }
                
                a_nodes_unavailable[ a_nodes_unavailable.size ] = node;
                continue;
            }
            
            if ( isdefined( node.spawnflags ) && ( node.spawnflags & 512 ) == 512 )
            {
                if ( !isdefined( a_nodes_unavailable ) )
                {
                    a_nodes_unavailable = [];
                }
                else if ( !isarray( a_nodes_unavailable ) )
                {
                    a_nodes_unavailable = array( a_nodes_unavailable );
                }
                
                a_nodes_unavailable[ a_nodes_unavailable.size ] = node;
                continue;
            }
            
            if ( !isdefined( nodes ) )
            {
                nodes = [];
            }
            else if ( !isarray( nodes ) )
            {
                nodes = array( nodes );
            }
            
            nodes[ nodes.size ] = node;
        }
    }
    
    if ( nodes.size == 0 )
    {
        while ( nodes.size == 0 )
        {
            foreach ( node in a_nodes_unavailable )
            {
                if ( !isnodeoccupied( node ) && !( isdefined( node.node_claimed ) && node.node_claimed ) && !( isdefined( node.spawnflags ) && ( node.spawnflags & 512 ) == 512 ) )
                {
                    if ( !isdefined( nodes ) )
                    {
                        nodes = [];
                    }
                    else if ( !isarray( nodes ) )
                    {
                        nodes = array( nodes );
                    }
                    
                    nodes[ nodes.size ] = node;
                    break;
                }
            }
            
            wait 0.2;
        }
    }
    
    assert( nodespresent, "<dev string:x1b3>" );
    goal = undefined;
    
    if ( nodes.size > 0 )
    {
        goal = array::random( nodes );
    }
    
    if ( isdefined( goal ) )
    {
        if ( isdefined( self.script_radius ) )
        {
            self.goalradius = self.script_radius;
        }
        else
        {
            self.goalradius = 400;
        }
        
        goal.node_claimed = 1;
        self setgoal( goal );
        self notify( #"spawner_target_set" );
        self thread release_spawner_target_node( goal );
        self waittill( #"goal" );
    }
    
    self set_goalradius_based_on_settings( goal );
}

// Namespace spawner
// Params 1
// Checksum 0xe4a910b5, Offset: 0x2d40
// Size: 0x42
function release_spawner_target_node( node )
{
    self util::waittill_any( "death", "goal_changed" );
    node.node_claimed = undefined;
}

// Namespace spawner
// Params 1
// Checksum 0x9551d670, Offset: 0x2d90
// Size: 0xf6
function get_spawner_target_nodes( group )
{
    if ( group == "" )
    {
        return [];
    }
    
    nodes = [];
    
    for ( i = 0; i < level.script_spawner_targets_nodes.size ; i++ )
    {
        groups = strtok( level.script_spawner_targets_nodes[ i ].script_spawner_targets, " " );
        
        for ( j = 0; j < groups.size ; j++ )
        {
            if ( groups[ j ] == group )
            {
                nodes[ nodes.size ] = level.script_spawner_targets_nodes[ i ];
            }
        }
    }
    
    return nodes;
}

// Namespace spawner
// Params 1
// Checksum 0x7d2cbeb8, Offset: 0x2e90
// Size: 0x14a
function get_least_used_from_array( array )
{
    assert( array.size > 0, "<dev string:x1d3>" );
    
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    targetname = array[ 0 ].targetname;
    
    if ( !isdefined( level.go_to_node_arrays[ targetname ] ) )
    {
        level.go_to_node_arrays[ targetname ] = array;
    }
    
    array = level.go_to_node_arrays[ targetname ];
    first = array[ 0 ];
    newarray = [];
    
    for ( i = 0; i < array.size - 1 ; i++ )
    {
        newarray[ i ] = array[ i + 1 ];
    }
    
    newarray[ array.size - 1 ] = array[ 0 ];
    level.go_to_node_arrays[ targetname ] = newarray;
    return first;
}

// Namespace spawner
// Params 5
// Checksum 0x3c54a625, Offset: 0x2fe8
// Size: 0x49c
function go_to_node_using_funcs( node, get_target_func, set_goal_func_quits, optional_arrived_at_node_func, require_player_dist )
{
    self endon( #"stop_going_to_node" );
    self endon( #"death" );
    
    for ( ;; )
    {
        node = get_least_used_from_array( node );
        player_wait_dist = require_player_dist;
        
        if ( isdefined( node.script_requires_player ) )
        {
            if ( node.script_requires_player > 1 )
            {
                player_wait_dist = node.script_requires_player;
            }
            else
            {
                player_wait_dist = 256;
            }
            
            node.script_requires_player = 0;
        }
        
        self set_goalradius_based_on_settings( node );
        
        if ( isdefined( node.height ) )
        {
            self.goalheight = node.height;
        }
        
        [[ set_goal_func_quits ]]( node );
        self waittill( #"goal" );
        [[ optional_arrived_at_node_func ]]( node );
        
        if ( isdefined( node.script_flag_set ) )
        {
            level flag::set( node.script_flag_set );
        }
        
        if ( isdefined( node.script_flag_clear ) )
        {
            level flag::set( node.script_flag_clear );
        }
        
        if ( isdefined( node.script_ent_flag_set ) )
        {
            if ( !self flag::exists( node.script_ent_flag_set ) )
            {
                assertmsg( "<dev string:x1f2>" + node.script_ent_flag_set + "<dev string:x20c>" );
            }
            
            self flag::set( node.script_ent_flag_set );
        }
        
        if ( isdefined( node.script_ent_flag_clear ) )
        {
            if ( !self flag::exists( node.script_ent_flag_clear ) )
            {
                assertmsg( "<dev string:x22e>" + node.script_ent_flag_clear + "<dev string:x20c>" );
            }
            
            self flag::clear( node.script_ent_flag_clear );
        }
        
        if ( isdefined( node.script_flag_wait ) )
        {
            level flag::wait_till( node.script_flag_wait );
        }
        
        while ( isdefined( node.script_requires_player ) )
        {
            node.script_requires_player = 0;
            
            if ( self go_to_node_wait_for_player( node, get_target_func, player_wait_dist ) )
            {
                node.script_requires_player = 1;
                node notify( #"script_requires_player" );
                break;
            }
            
            wait 0.1;
        }
        
        if ( isdefined( node.script_aigroup ) )
        {
            waittill_ai_group_cleared( node.script_aigroup );
        }
        
        node util::script_delay();
        
        if ( !isdefined( node.target ) )
        {
            break;
        }
        
        nextnode_array = update_target_array( node.target );
        
        if ( !nextnode_array.size )
        {
            break;
        }
        
        node = nextnode_array;
    }
    
    if ( isdefined( self.arrived_at_end_node_func ) )
    {
        [[ self.arrived_at_end_node_func ]]( node );
    }
    
    self notify( #"reached_path_end" );
    
    if ( isdefined( self.delete_on_path_end ) )
    {
        self delete();
    }
    
    self set_goalradius_based_on_settings( node );
}

// Namespace spawner
// Params 3
// Checksum 0xd2399195, Offset: 0x3490
// Size: 0x346, Type: bool
function go_to_node_wait_for_player( node, get_target_func, dist )
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( distancesquared( player.origin, node.origin ) < distancesquared( self.origin, node.origin ) )
        {
            return true;
        }
    }
    
    vec = anglestoforward( self.angles );
    
    if ( isdefined( node.target ) )
    {
        temp = [[ get_target_func ]]( node.target );
        
        if ( temp.size == 1 )
        {
            vec = vectornormalize( temp[ 0 ].origin - node.origin );
        }
        else if ( isdefined( node.angles ) )
        {
            vec = anglestoforward( node.angles );
        }
    }
    else if ( isdefined( node.angles ) )
    {
        vec = anglestoforward( node.angles );
    }
    
    vec2 = [];
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        vec2[ vec2.size ] = vectornormalize( player.origin - self.origin );
    }
    
    for ( i = 0; i < vec2.size ; i++ )
    {
        value = vec2[ i ];
        
        if ( vectordot( vec, value ) > 0 )
        {
            return true;
        }
    }
    
    dist2rd = dist * dist;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( distancesquared( player.origin, self.origin ) < dist2rd )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spawner
// Params 1
// Checksum 0xa1fd4d90, Offset: 0x37e0
// Size: 0x2c
function go_to_node_set_goal_pos( ent )
{
    self setgoal( ent.origin );
}

// Namespace spawner
// Params 1
// Checksum 0xac1e735, Offset: 0x3818
// Size: 0x24
function go_to_node_set_goal_node( node )
{
    self setgoal( node );
}

// Namespace spawner
// Params 1
// Checksum 0x4752a429, Offset: 0x3848
// Size: 0x26
function remove_crawled( ent )
{
    waittillframeend();
    
    if ( isdefined( ent ) )
    {
        ent.crawled = undefined;
    }
}

// Namespace spawner
// Params 2
// Checksum 0xce92a5ed, Offset: 0x3878
// Size: 0x1a2
function crawl_target_and_init_flags( ent, get_func )
{
    targets = [];
    index = 0;
    
    for ( ;; )
    {
        if ( !isdefined( ent.crawled ) )
        {
            ent.crawled = 1;
            level thread remove_crawled( ent );
            
            if ( isdefined( ent.script_flag_set ) )
            {
                if ( !isdefined( level.flag[ ent.script_flag_set ] ) )
                {
                    level flag::init( ent.script_flag_set );
                }
            }
            
            if ( isdefined( ent.script_flag_wait ) )
            {
                if ( !isdefined( level.flag[ ent.script_flag_wait ] ) )
                {
                    level flag::init( ent.script_flag_wait );
                }
            }
            
            if ( isdefined( ent.target ) )
            {
                new_targets = [[ get_func ]]( ent.target );
                array::add( targets, new_targets );
            }
        }
        
        index++;
        
        if ( index >= targets.size )
        {
            break;
        }
        
        ent = targets[ index ];
    }
}

// Namespace spawner
// Params 2
// Checksum 0xc25b008f, Offset: 0x3a28
// Size: 0x22e
function get_node_funcs_based_on_target( node, goal_type )
{
    get_target_func[ "origin" ] = &get_target_ents;
    get_target_func[ "node" ] = &get_target_nodes;
    get_target_func[ "struct" ] = &get_target_structs;
    set_goal_func_quits[ "origin" ] = &go_to_node_set_goal_pos;
    set_goal_func_quits[ "struct" ] = &go_to_node_set_goal_pos;
    set_goal_func_quits[ "node" ] = &go_to_node_set_goal_node;
    
    if ( !isdefined( goal_type ) )
    {
        goal_type = "node";
    }
    
    array = [];
    
    if ( isdefined( node ) )
    {
        array[ "node" ][ 0 ] = node;
    }
    else
    {
        node = getentarray( self.target, "targetname" );
        
        if ( node.size > 0 )
        {
            goal_type = "origin";
        }
        
        if ( goal_type == "node" )
        {
            node = getnodearray( self.target, "targetname" );
            
            if ( !node.size )
            {
                node = struct::get_array( self.target, "targetname" );
                
                if ( !node.size )
                {
                    return;
                }
                
                goal_type = "struct";
            }
        }
        
        array[ "node" ] = node;
    }
    
    array[ "get_target_func" ] = get_target_func[ goal_type ];
    array[ "set_goal_func_quits" ] = set_goal_func_quits[ goal_type ];
    return array;
}

// Namespace spawner
// Params 1
// Checksum 0x2001031d, Offset: 0x3c60
// Size: 0xb8
function update_target_array( str_target )
{
    a_nd_target = getnodearray( str_target, "targetname" );
    
    if ( a_nd_target.size )
    {
        return a_nd_target;
    }
    
    a_s_target = struct::get_array( str_target, "targetname" );
    
    if ( a_s_target.size )
    {
        return a_s_target;
    }
    
    a_e_target = getentarray( str_target, "targetname" );
    
    if ( a_e_target.size )
    {
        return a_e_target;
    }
}

// Namespace spawner
// Params 1
// Checksum 0x816c1d74, Offset: 0x3d20
// Size: 0xe4
function set_goalradius_based_on_settings( node )
{
    self endon( #"death" );
    waittillframeend();
    
    if ( isdefined( self.script_radius ) )
    {
        self.goalradius = self.script_radius;
    }
    else if ( isdefined( node ) && node_has_radius( node ) )
    {
        self.goalradius = node.radius;
    }
    
    if ( isdefined( self.script_forcegoal ) && self.script_forcegoal )
    {
        n_radius = self.script_forcegoal > 1 ? self.script_forcegoal : undefined;
        self thread ai::force_goal( get_goal( self.target ), n_radius );
    }
}

// Namespace spawner
// Params 2
// Checksum 0xa1ae2745, Offset: 0x3e10
// Size: 0x8a
function get_goal( str_goal, str_key )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    a_goals = getnodearray( str_goal, str_key );
    
    if ( !a_goals.size )
    {
        a_goals = getentarray( str_goal, str_key );
    }
    
    return array::random( a_goals );
}

// Namespace spawner
// Params 3
// Checksum 0x1efa1498, Offset: 0x3ea8
// Size: 0x160
function fallback_spawner_think( num, node_array, ignorewhilefallingback )
{
    self endon( #"death" );
    level.max_fallbackers[ num ] += self.count;
    firstspawn = 1;
    
    while ( self.count > 0 )
    {
        self waittill( #"spawned", spawn );
        
        if ( firstspawn )
        {
            /#
                if ( getdvarstring( "<dev string:x24a>" ) == "<dev string:x253>" )
                {
                    println( "<dev string:x255>", num );
                }
            #/
            
            level notify( "fallback_firstspawn" + num );
            firstspawn = 0;
        }
        
        wait 0.05;
        
        if ( spawn_failed( spawn ) )
        {
            level notify( "fallbacker_died" + num );
            level.max_fallbackers[ num ]--;
            continue;
        }
        
        spawn thread fallback_ai_think( num, node_array, "is spawner", ignorewhilefallingback );
    }
}

// Namespace spawner
// Params 2
// Checksum 0x45ad9a59, Offset: 0x4010
// Size: 0x44
function fallback_ai_think_death( ai, num )
{
    ai waittill( #"death" );
    level.current_fallbackers[ num ]--;
    level notify( "fallbacker_died" + num );
}

// Namespace spawner
// Params 4
// Checksum 0x93c98db1, Offset: 0x4060
// Size: 0xdc
function fallback_ai_think( num, node_array, spawner, ignorewhilefallingback )
{
    if ( !isdefined( self.fallback ) || !isdefined( self.fallback[ num ] ) )
    {
        self.fallback[ num ] = 1;
    }
    else
    {
        return;
    }
    
    self.script_fallback = num;
    
    if ( !isdefined( spawner ) )
    {
        level.current_fallbackers[ num ]++;
    }
    
    if ( isdefined( node_array ) && level.fallback_initiated[ num ] )
    {
        self thread fallback_ai( num, node_array, ignorewhilefallingback );
    }
    
    level thread fallback_ai_think_death( self, num );
}

// Namespace spawner
// Params 2
// Checksum 0x946de9d0, Offset: 0x4148
// Size: 0x60
function fallback_death( ai, num )
{
    ai waittill( #"death" );
    
    if ( isdefined( ai.fallback_node ) )
    {
        ai.fallback_node.fallback_occupied = 0;
    }
    
    level notify( "fallback_reached_goal" + num );
}

// Namespace spawner
// Params 1
// Checksum 0x517e74b7, Offset: 0x41b0
// Size: 0x5a
function fallback_goal( ignorewhilefallingback )
{
    self waittill( #"goal" );
    self.ignoresuppression = 0;
    
    if ( isdefined( ignorewhilefallingback ) && ignorewhilefallingback )
    {
        self.ignoreall = 0;
    }
    
    self notify( #"fallback_notify" );
    self notify( #"stop_coverprint" );
}

// Namespace spawner
// Params 0
// Checksum 0x6aacb57d, Offset: 0x4218
// Size: 0x96
function fallback_interrupt()
{
    self notify( #"stop_fallback_interrupt" );
    self endon( #"stop_fallback_interrupt" );
    self endon( #"stop_going_to_node" );
    self endon( #"hash_1f355ad7" );
    self endon( #"fallback_notify" );
    self endon( #"death" );
    
    while ( true )
    {
        origin = self.origin;
        wait 2;
        
        if ( self.origin == origin )
        {
            self.ignoreall = 0;
            return;
        }
    }
}

// Namespace spawner
// Params 3
// Checksum 0x8b83eeff, Offset: 0x42b8
// Size: 0x25c
function fallback_ai( num, node_array, ignorewhilefallingback )
{
    self notify( #"stop_going_to_node" );
    self endon( #"stop_going_to_node" );
    self endon( #"hash_1f355ad7" );
    self endon( #"death" );
    node = undefined;
    
    while ( true )
    {
        assert( node_array.size >= level.current_fallbackers[ num ], "<dev string:x268>" + num + "<dev string:x2af>" );
        node = node_array[ randomint( node_array.size ) ];
        
        if ( !isdefined( node.fallback_occupied ) || !node.fallback_occupied )
        {
            node.fallback_occupied = 1;
            self.fallback_node = node;
            break;
        }
        
        wait 0.1;
    }
    
    self.ignoresuppression = 1;
    
    if ( self.ignoreall == 0 && isdefined( ignorewhilefallingback ) && ignorewhilefallingback )
    {
        self.ignoreall = 1;
        self thread fallback_interrupt();
    }
    
    self setgoal( node );
    
    if ( node.radius != 0 )
    {
        self.goalradius = node.radius;
    }
    
    self endon( #"death" );
    level thread fallback_death( self, num );
    self thread fallback_goal( ignorewhilefallingback );
    
    /#
        if ( getdvarstring( "<dev string:x24a>" ) == "<dev string:x253>" )
        {
            self thread coverprint( node.origin );
        }
    #/
    
    self waittill( #"fallback_notify" );
    level notify( "fallback_reached_goal" + num );
}

/#

    // Namespace spawner
    // Params 1
    // Checksum 0x52d8461c, Offset: 0x4520
    // Size: 0xe0, Type: dev
    function coverprint( org )
    {
        self endon( #"fallback_notify" );
        self endon( #"stop_coverprint" );
        self endon( #"death" );
        
        while ( true )
        {
            line( self.origin + ( 0, 0, 35 ), org, ( 0.2, 0.5, 0.8 ), 0.5 );
            print3d( self.origin + ( 0, 0, 70 ), "<dev string:x2e9>", ( 0.98, 0.4, 0.26 ), 0.85 );
            wait 0.05;
        }
    }

#/

// Namespace spawner
// Params 4
// Checksum 0x715670cf, Offset: 0x4608
// Size: 0x104
function fallback_overmind( num, group, ignorewhilefallingback, percent )
{
    fallback_nodes = undefined;
    nodes = getallnodes();
    
    for ( i = 0; i < nodes.size ; i++ )
    {
        if ( isdefined( nodes[ i ].script_fallback ) && nodes[ i ].script_fallback == num )
        {
            array::add( fallback_nodes, nodes[ i ] );
        }
    }
    
    if ( isdefined( fallback_nodes ) )
    {
        level thread fallback_overmind_internal( num, group, fallback_nodes, ignorewhilefallingback, percent );
    }
}

// Namespace spawner
// Params 5
// Checksum 0x872445b8, Offset: 0x4718
// Size: 0x626
function fallback_overmind_internal( num, group, fallback_nodes, ignorewhilefallingback, percent )
{
    level.current_fallbackers[ num ] = 0;
    level.max_fallbackers[ num ] = 0;
    level.spawner_fallbackers[ num ] = 0;
    level.fallback_initiated[ num ] = 0;
    spawners = getspawnerarray();
    
    for ( i = 0; i < spawners.size ; i++ )
    {
        if ( isdefined( spawners[ i ].script_fallback ) && spawners[ i ].script_fallback == num )
        {
            if ( spawners[ i ].count > 0 )
            {
                spawners[ i ] thread fallback_spawner_think( num, fallback_nodes, ignorewhilefallingback );
                level.spawner_fallbackers[ num ]++;
            }
        }
    }
    
    assert( level.spawner_fallbackers[ num ] <= fallback_nodes.size, "<dev string:x2f6>" + num );
    ai = getaiarray();
    
    for ( i = 0; i < ai.size ; i++ )
    {
        if ( isdefined( ai[ i ].script_fallback ) && ai[ i ].script_fallback == num )
        {
            ai[ i ] thread fallback_ai_think( num, undefined, undefined, ignorewhilefallingback );
        }
    }
    
    if ( !level.current_fallbackers[ num ] && !level.spawner_fallbackers[ num ] )
    {
        return;
    }
    
    spawners = undefined;
    ai = undefined;
    thread fallback_wait( num, group, ignorewhilefallingback, percent );
    level waittill( "fallbacker_trigger" + num );
    fallback_add_previous_group( num, fallback_nodes );
    
    /#
        if ( getdvarstring( "<dev string:x24a>" ) == "<dev string:x253>" )
        {
            println( "<dev string:x364>", num );
        }
    #/
    
    level.fallback_initiated[ num ] = 1;
    fallback_ai = undefined;
    ai = getaiarray();
    
    for ( i = 0; i < ai.size ; i++ )
    {
        if ( isdefined( ai[ i ].script_fallback_group ) && isdefined( group ) && ( isdefined( ai[ i ].script_fallback ) && ai[ i ].script_fallback == num || ai[ i ].script_fallback_group == group ) )
        {
            array::add( fallback_ai, ai[ i ] );
        }
    }
    
    ai = undefined;
    
    if ( !isdefined( fallback_ai ) )
    {
        return;
    }
    
    if ( !isdefined( percent ) )
    {
        percent = 0.4;
    }
    
    first_half = fallback_ai.size * percent;
    first_half = int( first_half );
    level notify( "fallback initiated " + num );
    fallback_text( fallback_ai, 0, first_half );
    first_half_ai = [];
    
    for ( i = 0; i < first_half ; i++ )
    {
        fallback_ai[ i ] thread fallback_ai( num, fallback_nodes, ignorewhilefallingback );
        first_half_ai[ i ] = fallback_ai[ i ];
    }
    
    for ( i = 0; i < first_half ; i++ )
    {
        level waittill( "fallback_reached_goal" + num );
    }
    
    fallback_text( fallback_ai, first_half, fallback_ai.size );
    
    for ( i = 0; i < fallback_ai.size ; i++ )
    {
        if ( isalive( fallback_ai[ i ] ) )
        {
            set_fallback = 1;
            
            for ( p = 0; p < first_half_ai.size ; p++ )
            {
                if ( isalive( first_half_ai[ p ] ) )
                {
                    if ( fallback_ai[ i ] == first_half_ai[ p ] )
                    {
                        set_fallback = 0;
                    }
                }
            }
            
            if ( set_fallback )
            {
                fallback_ai[ i ] thread fallback_ai( num, fallback_nodes, ignorewhilefallingback );
            }
        }
    }
}

// Namespace spawner
// Params 3
// Checksum 0x12f745d2, Offset: 0x4d48
// Size: 0xa8
function fallback_text( fallbackers, start, end )
{
    if ( gettime() <= level._nextcoverprint )
    {
        return;
    }
    
    for ( i = start; i < end ; i++ )
    {
        if ( !isalive( fallbackers[ i ] ) )
        {
            continue;
        }
        
        level._nextcoverprint = gettime() + 2500 + randomint( 2000 );
        return;
    }
}

// Namespace spawner
// Params 4
// Checksum 0x24578858, Offset: 0x4df8
// Size: 0x338
function fallback_wait( num, group, ignorewhilefallingback, percent )
{
    level endon( "fallbacker_trigger" + num );
    
    /#
        if ( getdvarstring( "<dev string:x24a>" ) == "<dev string:x253>" )
        {
            println( "<dev string:x37e>", num );
        }
    #/
    
    for ( i = 0; i < level.spawner_fallbackers[ num ] ; i++ )
    {
        /#
            if ( getdvarstring( "<dev string:x24a>" ) == "<dev string:x253>" )
            {
                println( "<dev string:x391>", num, "<dev string:x3b5>", i );
            }
        #/
        
        level waittill( "fallback_firstspawn" + num );
    }
    
    /#
        if ( getdvarstring( "<dev string:x24a>" ) == "<dev string:x253>" )
        {
            println( "<dev string:x3ba>", num, "<dev string:x3ec>", level.current_fallbackers[ num ] );
        }
    #/
    
    ai = getaiarray();
    
    for ( i = 0; i < ai.size ; i++ )
    {
        if ( isdefined( ai[ i ].script_fallback_group ) && isdefined( group ) && ( isdefined( ai[ i ].script_fallback ) && ai[ i ].script_fallback == num || ai[ i ].script_fallback_group == group ) )
        {
            ai[ i ] thread fallback_ai_think( num, undefined, undefined, ignorewhilefallingback );
        }
    }
    
    ai = undefined;
    
    for ( deadfallbackers = 0; deadfallbackers < level.max_fallbackers[ num ] * percent ; deadfallbackers++ )
    {
        /#
            if ( getdvarstring( "<dev string:x24a>" ) == "<dev string:x253>" )
            {
                println( "<dev string:x3f1>" + deadfallbackers + "<dev string:x400>" + level.max_fallbackers[ num ] * 0.5 );
            }
        #/
        
        level waittill( "fallbacker_died" + num );
    }
    
    println( deadfallbackers, "<dev string:x412>" );
    level notify( "fallbacker_trigger" + num );
}

// Namespace spawner
// Params 1
// Checksum 0xbf2c4bba, Offset: 0x5138
// Size: 0x134
function fallback_think( trigger )
{
    ignorewhilefallingback = 0;
    
    if ( isdefined( trigger.script_ignoreall ) && trigger.script_ignoreall )
    {
        ignorewhilefallingback = 1;
    }
    
    if ( !isdefined( level.fallback ) || !isdefined( level.fallback[ trigger.script_fallback ] ) )
    {
        percent = 0.5;
        
        if ( isdefined( trigger.script_percent ) )
        {
            percent = trigger.script_percent / 100;
        }
        
        level thread fallback_overmind( trigger.script_fallback, trigger.script_fallback_group, ignorewhilefallingback, percent );
    }
    
    trigger waittill( #"trigger" );
    level notify( "fallbacker_trigger" + trigger.script_fallback );
    kill_trigger( trigger );
}

// Namespace spawner
// Params 2
// Checksum 0xcaf92468, Offset: 0x5278
// Size: 0x194
function fallback_add_previous_group( num, node_array )
{
    if ( !isdefined( level.current_fallbackers[ num - 1 ] ) )
    {
        return;
    }
    
    for ( i = 0; i < level.current_fallbackers[ num - 1 ] ; i++ )
    {
        level.max_fallbackers[ num ]++;
    }
    
    for ( i = 0; i < level.current_fallbackers[ num - 1 ] ; i++ )
    {
        level.current_fallbackers[ num ]++;
    }
    
    ai = getaiarray();
    
    for ( i = 0; i < ai.size ; i++ )
    {
        if ( isdefined( ai[ i ].script_fallback ) && ai[ i ].script_fallback == num - 1 )
        {
            ai[ i ].script_fallback++;
            
            if ( isdefined( ai[ i ].fallback_node ) )
            {
                ai[ i ].fallback_node.fallback_occupied = 0;
                ai[ i ].fallback_node = undefined;
            }
        }
    }
}

// Namespace spawner
// Params 2
// Checksum 0x6bc4be44, Offset: 0x5418
// Size: 0x28c
function aigroup_init( aigroup, spawner )
{
    if ( !isdefined( level._ai_group[ aigroup ] ) )
    {
        level._ai_group[ aigroup ] = spawnstruct();
        level._ai_group[ aigroup ].aigroup = aigroup;
        level._ai_group[ aigroup ].aicount = 0;
        level._ai_group[ aigroup ].killed_count = 0;
        level._ai_group[ aigroup ].ai = [];
        level._ai_group[ aigroup ].spawners = [];
        level._ai_group[ aigroup ].cleared_count = 0;
        
        if ( !isdefined( level.flag[ aigroup + "_cleared" ] ) )
        {
            level flag::init( aigroup + "_cleared" );
        }
        
        if ( !isdefined( level.flag[ aigroup + "_spawning" ] ) )
        {
            level flag::init( aigroup + "_spawning" );
        }
        
        level thread set_ai_group_cleared_flag( level._ai_group[ aigroup ] );
    }
    
    if ( isdefined( spawner ) )
    {
        if ( !isdefined( level._ai_group[ aigroup ].spawners ) )
        {
            level._ai_group[ aigroup ].spawners = [];
        }
        else if ( !isarray( level._ai_group[ aigroup ].spawners ) )
        {
            level._ai_group[ aigroup ].spawners = array( level._ai_group[ aigroup ].spawners );
        }
        
        level._ai_group[ aigroup ].spawners[ level._ai_group[ aigroup ].spawners.size ] = spawner;
        spawner thread aigroup_spawner_death( level._ai_group[ aigroup ] );
    }
}

// Namespace spawner
// Params 1
// Checksum 0xbdf63f13, Offset: 0x56b0
// Size: 0x44
function aigroup_spawner_death( tracker )
{
    self util::waittill_any( "death", "aigroup_spawner_death" );
    tracker notify( #"update_aigroup" );
}

// Namespace spawner
// Params 1
// Checksum 0xdff95000, Offset: 0x5700
// Size: 0xe0
function aigroup_think( tracker )
{
    tracker.aicount++;
    tracker.ai[ tracker.ai.size ] = self;
    tracker notify( #"update_aigroup" );
    
    if ( isdefined( self.script_deathflag_longdeath ) )
    {
        self waittilldeathorpaindeath();
    }
    else
    {
        self waittill( #"death" );
    }
    
    tracker.aicount--;
    tracker.killed_count++;
    tracker notify( #"update_aigroup" );
    wait 0.05;
    tracker.ai = array::remove_undefined( tracker.ai );
}

// Namespace spawner
// Params 1
// Checksum 0x9817c55c, Offset: 0x57e8
// Size: 0x8c
function set_ai_group_cleared_flag( tracker )
{
    waittillframeend();
    
    while ( tracker.aicount + get_ai_group_spawner_count( tracker.aigroup ) > tracker.cleared_count )
    {
        tracker waittill( #"update_aigroup" );
    }
    
    level flag::set( tracker.aigroup + "_cleared" );
}

// Namespace spawner
// Params 1
// Checksum 0xc15e6d62, Offset: 0x5880
// Size: 0x17c
function flood_trigger_think( trigger )
{
    assert( isdefined( trigger.target ), "<dev string:x43a>" + trigger.origin + "<dev string:x44c>" );
    floodspawners = getentarray( trigger.target, "targetname" );
    assert( floodspawners.size, "<dev string:x45c>" + trigger.target + "<dev string:x47a>" );
    
    for ( i = 0; i < floodspawners.size ; i++ )
    {
        floodspawners[ i ].script_trigger = trigger;
    }
    
    array::thread_all( floodspawners, &flood_spawner_init );
    trigger waittill( #"trigger" );
    floodspawners = getentarray( trigger.target, "targetname" );
    array::thread_all( floodspawners, &flood_spawner_think, trigger );
}

// Namespace spawner
// Params 1
// Checksum 0x19f6b350, Offset: 0x5a08
// Size: 0x7c
function flood_spawner_init( spawner )
{
    assert( isdefined( self.spawnflags ) && ( self.spawnflags & 1 ) == 1, "<dev string:x48f>" + self.origin + "<dev string:x4a1>" + self getorigin() + "<dev string:x4a3>" );
}

// Namespace spawner
// Params 1
// Checksum 0x1e3065fd, Offset: 0x5a90
// Size: 0x28, Type: bool
function trigger_requires_player( trigger )
{
    if ( !isdefined( trigger ) )
    {
        return false;
    }
    
    return isdefined( trigger.script_requires_player );
}

// Namespace spawner
// Params 1
// Checksum 0x5f93ff34, Offset: 0x5ac0
// Size: 0x258
function flood_spawner_think( trigger )
{
    self endon( #"death" );
    self notify( #"hash_87140c16" );
    self endon( #"hash_87140c16" );
    requires_player = trigger_requires_player( trigger );
    util::script_delay();
    
    while ( self.count > 0 )
    {
        if ( requires_player )
        {
            while ( !util::any_player_is_touching( trigger ) )
            {
                wait 0.5;
            }
        }
        
        soldier = self spawn();
        
        if ( spawn_failed( soldier ) )
        {
            wait 2;
            continue;
        }
        
        soldier thread reincrement_count_if_deleted( self );
        soldier waittill( #"death", attacker );
        
        if ( !player_saw_kill( soldier, attacker ) )
        {
            self.count++;
        }
        
        if ( !isdefined( soldier ) )
        {
            continue;
        }
        
        if ( !util::script_wait( 1 ) )
        {
            players = getplayers();
            
            if ( players.size == 1 )
            {
                wait randomfloatrange( 5, 9 );
                continue;
            }
            
            if ( players.size == 2 )
            {
                wait randomfloatrange( 3, 6 );
                continue;
            }
            
            if ( players.size == 3 )
            {
                wait randomfloatrange( 1, 4 );
                continue;
            }
            
            if ( players.size == 4 )
            {
                wait randomfloatrange( 0.5, 1.5 );
            }
        }
    }
}

// Namespace spawner
// Params 2
// Checksum 0xf382496e, Offset: 0x5d20
// Size: 0x252
function player_saw_kill( guy, attacker )
{
    if ( isdefined( self.script_force_count ) )
    {
        if ( self.script_force_count )
        {
            return 1;
        }
    }
    
    if ( !isdefined( guy ) )
    {
        return 0;
    }
    
    if ( isalive( attacker ) )
    {
        if ( isplayer( attacker ) )
        {
            return 1;
        }
        
        players = getplayers();
        
        for ( q = 0; q < players.size ; q++ )
        {
            if ( distancesquared( attacker.origin, players[ q ].origin ) < 40000 )
            {
                return 1;
            }
        }
    }
    else if ( isdefined( attacker ) )
    {
        if ( attacker.classname == "worldspawn" )
        {
            return 0;
        }
        
        player = util::get_closest_player( attacker.origin );
        
        if ( isdefined( player ) && distancesquared( attacker.origin, player.origin ) < 40000 )
        {
            return 1;
        }
    }
    
    closest_player = util::get_closest_player( guy.origin );
    
    if ( isdefined( closest_player ) && distancesquared( guy.origin, closest_player.origin ) < 40000 )
    {
        return 1;
    }
    
    return bullettracepassed( closest_player geteye(), guy geteye(), 0, undefined );
}

/#

    // Namespace spawner
    // Params 0
    // Checksum 0x360cfb9, Offset: 0x5f80
    // Size: 0x112, Type: dev
    function show_bad_path()
    {
        self endon( #"death" );
        last_bad_path_time = -5000;
        bad_path_count = 0;
        
        for ( ;; )
        {
            self waittill( #"bad_path", badpathpos );
            
            if ( !isdefined( level.debug_badpath ) || !level.debug_badpath )
            {
                continue;
            }
            
            if ( gettime() - last_bad_path_time > 5000 )
            {
                bad_path_count = 0;
            }
            else
            {
                bad_path_count++;
            }
            
            last_bad_path_time = gettime();
            
            if ( bad_path_count < 10 )
            {
                continue;
            }
            
            for ( p = 0; p < 200 ; p++ )
            {
                line( self.origin, badpathpos, ( 1, 0.4, 0.1 ), 0, 200 );
                wait 0.05;
            }
        }
    }

#/

// Namespace spawner
// Params 0
// Checksum 0x85934c07, Offset: 0x60a0
// Size: 0x8, Type: bool
function watches_for_friendly_fire()
{
    return true;
}

// Namespace spawner
// Params 5
// Checksum 0x4042a05f, Offset: 0x60b0
// Size: 0x886
function spawn( b_force, str_targetname, v_origin, v_angles, bignorespawninglimit )
{
    if ( !isdefined( b_force ) )
    {
        b_force = 0;
    }
    
    if ( isdefined( level.overrideglobalspawnfunc ) && self.team == "axis" )
    {
        return [[ level.overrideglobalspawnfunc ]]( b_force, str_targetname, v_origin, v_angles );
    }
    
    e_spawned = undefined;
    force_spawn = 0;
    makeroom = 0;
    infinitespawn = 0;
    deleteonzerocount = 0;
    
    /#
        if ( getdvarstring( "<dev string:x59>" ) != "<dev string:x5e>" )
        {
            return;
        }
    #/
    
    if ( !check_player_requirements() )
    {
        return;
    }
    
    while ( true )
    {
        if ( !( isdefined( bignorespawninglimit ) && bignorespawninglimit ) && !( isdefined( self.ignorespawninglimit ) && self.ignorespawninglimit ) )
        {
            global_spawn_throttle( 1 );
        }
        
        if ( sessionmodeiscampaignzombiesgame() && !isdefined( self ) )
        {
            return;
        }
        
        if ( isdefined( self.lastspawntime ) && self.lastspawntime >= gettime() )
        {
            wait 0.05;
            continue;
        }
        
        break;
    }
    
    if ( isactorspawner( self ) )
    {
        if ( isdefined( self.spawnflags ) && ( self.spawnflags & 2 ) == 2 )
        {
            makeroom = 1;
        }
    }
    else if ( isvehiclespawner( self ) )
    {
        if ( isdefined( self.spawnflags ) && ( self.spawnflags & 8 ) == 8 )
        {
            makeroom = 1;
        }
    }
    
    if ( isdefined( self.spawnflags ) && ( b_force || ( self.spawnflags & 16 ) == 16 ) || isdefined( self.script_forcespawn ) )
    {
        force_spawn = 1;
    }
    
    if ( isdefined( self.spawnflags ) && ( self.spawnflags & 64 ) == 64 )
    {
        infinitespawn = 1;
    }
    
    /#
        if ( isdefined( level.archetype_spawners ) && isarray( level.archetype_spawners ) )
        {
            archetype_spawner = undefined;
            
            if ( self.team == "<dev string:x4b6>" )
            {
                archetype = getdvarstring( "<dev string:x4bb>" );
                
                if ( getdvarstring( "<dev string:x4d6>" ) == "<dev string:x4f4>" )
                {
                    archetype = getdvarstring( "<dev string:x4f9>" );
                }
                
                archetype_spawner = level.archetype_spawners[ archetype ];
            }
            else if ( self.team == "<dev string:x16a>" )
            {
                archetype = getdvarstring( "<dev string:x4f9>" );
                
                if ( getdvarstring( "<dev string:x4d6>" ) == "<dev string:x513>" )
                {
                    archetype = getdvarstring( "<dev string:x4bb>" );
                }
                
                archetype_spawner = level.archetype_spawners[ archetype ];
            }
            
            if ( isspawner( archetype_spawner ) )
            {
                while ( isdefined( archetype_spawner.lastspawntime ) && archetype_spawner.lastspawntime >= gettime() )
                {
                    wait 0.05;
                }
                
                originalorigin = archetype_spawner.origin;
                originalangles = archetype_spawner.angles;
                originaltarget = archetype_spawner.target;
                originaltargetname = archetype_spawner.targetname;
                archetype_spawner.target = self.target;
                archetype_spawner.targetname = self.targetname;
                archetype_spawner.script_noteworthy = self.script_noteworthy;
                archetype_spawner.script_string = self.script_string;
                archetype_spawner.origin = self.origin;
                archetype_spawner.angles = self.angles;
                e_spawned = archetype_spawner spawnfromspawner( str_targetname, force_spawn, makeroom, infinitespawn );
                archetype_spawner.target = originaltarget;
                archetype_spawner.targetname = originaltargetname;
                archetype_spawner.origin = originalorigin;
                archetype_spawner.angles = originalangles;
                
                if ( isdefined( archetype_spawner.spawnflags ) && ( archetype_spawner.spawnflags & 64 ) == 64 )
                {
                    archetype_spawner.count++;
                }
                
                archetype_spawner.lastspawntime = gettime();
            }
        }
    #/
    
    if ( !isdefined( e_spawned ) )
    {
        female_override = undefined;
        use_female = randomint( 100 ) < level.female_percent;
        
        if ( level.dont_use_female_replacements === 1 )
        {
            use_female = 0;
        }
        
        if ( use_female && isdefined( self.aitypevariant ) )
        {
            e_spawned = self spawnfromspawner( str_targetname, force_spawn, makeroom, infinitespawn, "actor_" + self.aitypevariant );
        }
        else
        {
            override_aitype = undefined;
            
            if ( isdefined( level.override_spawned_aitype_func ) )
            {
                override_aitype = [[ level.override_spawned_aitype_func ]]( self );
            }
            
            if ( isdefined( override_aitype ) )
            {
                e_spawned = self spawnfromspawner( str_targetname, force_spawn, makeroom, infinitespawn, override_aitype );
            }
            else
            {
                e_spawned = self spawnfromspawner( str_targetname, force_spawn, makeroom, infinitespawn );
            }
        }
    }
    
    if ( isdefined( e_spawned ) )
    {
        if ( isdefined( level.run_custom_function_on_ai ) )
        {
            if ( isdefined( archetype_spawner ) )
            {
                e_spawned thread [[ level.run_custom_function_on_ai ]]( archetype_spawner, str_targetname, force_spawn );
            }
            else
            {
                e_spawned thread [[ level.run_custom_function_on_ai ]]( self, str_targetname, force_spawn );
            }
        }
        
        if ( isdefined( v_origin ) || isdefined( v_angles ) )
        {
            e_spawned teleport_spawned( v_origin, v_angles );
        }
        
        self.lastspawntime = gettime();
    }
    
    if ( isdefined( self.script_delete_on_zero ) && ( deleteonzerocount || self.script_delete_on_zero ) && isdefined( self.count ) && self.count <= 0 )
    {
        self delete();
    }
    
    if ( issentient( e_spawned ) )
    {
        if ( !spawn_failed( e_spawned ) )
        {
            return e_spawned;
        }
        
        return;
    }
    
    return e_spawned;
}

// Namespace spawner
// Params 3
// Checksum 0xd31c8fb2, Offset: 0x6940
// Size: 0xb8
function teleport_spawned( v_origin, v_angles, b_reset_entity )
{
    if ( !isdefined( b_reset_entity ) )
    {
        b_reset_entity = 1;
    }
    
    if ( !isdefined( v_origin ) )
    {
        v_origin = self.origin;
    }
    
    if ( !isdefined( v_angles ) )
    {
        v_angles = self.angles;
    }
    
    if ( isactor( self ) )
    {
        self forceteleport( v_origin, v_angles, 1, b_reset_entity );
        return;
    }
    
    self.origin = v_origin;
    self.angles = v_angles;
}

// Namespace spawner
// Params 0
// Checksum 0xd9fcf32e, Offset: 0x6a00
// Size: 0xfc, Type: bool
function check_player_requirements()
{
    if ( isdefined( level.players ) && level.players.size > 0 )
    {
        n_player_count = level.players.size;
    }
    else
    {
        n_player_count = getnumexpectedplayers();
    }
    
    if ( isdefined( self.script_minplayers ) )
    {
        if ( n_player_count < self.script_minplayers )
        {
            self delete();
            return false;
        }
    }
    
    if ( isdefined( self.script_numplayers ) )
    {
        if ( n_player_count < self.script_numplayers )
        {
            self delete();
            return false;
        }
    }
    
    if ( isdefined( self.script_maxplayers ) )
    {
        if ( n_player_count > self.script_maxplayers )
        {
            self delete();
            return false;
        }
    }
    
    return true;
}

// Namespace spawner
// Params 1
// Checksum 0x90d54c0d, Offset: 0x6b08
// Size: 0x66, Type: bool
function spawn_failed( spawn )
{
    if ( isalive( spawn ) )
    {
        if ( !isdefined( spawn.finished_spawning ) )
        {
            spawn waittill( #"hash_f42b7e06" );
        }
        
        waittillframeend();
        
        if ( isalive( spawn ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace spawner
// Params 1
// Checksum 0x93e61a03, Offset: 0x6b78
// Size: 0xb2
function kill_spawnernum( number )
{
    foreach ( sp in getspawnerarray( "" + number, "script_killspawner" ) )
    {
        sp delete();
    }
}

// Namespace spawner
// Params 0
// Checksum 0xc7ead2bb, Offset: 0x6c38
// Size: 0x1a
function disable_replace_on_death()
{
    self.replace_on_death = undefined;
    self notify( #"_disable_reinforcement" );
}

// Namespace spawner
// Params 0
// Checksum 0x822c5bad, Offset: 0x6c60
// Size: 0x14
function replace_on_death()
{
    colors::colornode_replace_on_death();
}

// Namespace spawner
// Params 2
// Checksum 0x8e35876b, Offset: 0x6c80
// Size: 0x48
function set_ai_group_cleared_count( aigroup, count )
{
    aigroup_init( aigroup );
    level._ai_group[ aigroup ].cleared_count = count;
}

// Namespace spawner
// Params 1
// Checksum 0x6972ef5f, Offset: 0x6cd0
// Size: 0x64
function waittill_ai_group_cleared( aigroup )
{
    assert( isdefined( level._ai_group[ aigroup ] ), "<dev string:x519>" + aigroup + "<dev string:x526>" );
    level flag::wait_till( aigroup + "_cleared" );
}

// Namespace spawner
// Params 2
// Checksum 0x10748141, Offset: 0x6d40
// Size: 0x6c
function waittill_ai_group_count( aigroup, count )
{
    while ( get_ai_group_spawner_count( aigroup ) + level._ai_group[ aigroup ].aicount > count )
    {
        level._ai_group[ aigroup ] waittill( #"update_aigroup" );
    }
}

// Namespace spawner
// Params 2
// Checksum 0xeab9fe90, Offset: 0x6db8
// Size: 0x50
function waittill_ai_group_ai_count( aigroup, count )
{
    while ( level._ai_group[ aigroup ].aicount > count )
    {
        level._ai_group[ aigroup ] waittill( #"update_aigroup" );
    }
}

// Namespace spawner
// Params 2
// Checksum 0x63761db9, Offset: 0x6e10
// Size: 0x50
function waittill_ai_group_spawner_count( aigroup, count )
{
    while ( get_ai_group_spawner_count( aigroup ) > count )
    {
        level._ai_group[ aigroup ] waittill( #"update_aigroup" );
    }
}

// Namespace spawner
// Params 2
// Checksum 0xf497b943, Offset: 0x6e68
// Size: 0x50
function waittill_ai_group_amount_killed( aigroup, amount_killed )
{
    while ( level._ai_group[ aigroup ].killed_count < amount_killed )
    {
        level._ai_group[ aigroup ] waittill( #"update_aigroup" );
    }
}

// Namespace spawner
// Params 1
// Checksum 0x773f74a4, Offset: 0x6ec0
// Size: 0x3c
function get_ai_group_count( aigroup )
{
    return get_ai_group_spawner_count( aigroup ) + level._ai_group[ aigroup ].aicount;
}

// Namespace spawner
// Params 1
// Checksum 0xef932398, Offset: 0x6f08
// Size: 0x22
function get_ai_group_sentient_count( aigroup )
{
    return level._ai_group[ aigroup ].aicount;
}

// Namespace spawner
// Params 1
// Checksum 0x75d3c609, Offset: 0x6f38
// Size: 0xc4
function get_ai_group_spawner_count( aigroup )
{
    n_count = 0;
    
    foreach ( sp in level._ai_group[ aigroup ].spawners )
    {
        if ( isdefined( sp ) )
        {
            n_count += sp.count;
        }
    }
    
    return n_count;
}

// Namespace spawner
// Params 1
// Checksum 0xfc936176, Offset: 0x7008
// Size: 0xbc
function get_ai_group_ai( aigroup )
{
    aiset = [];
    
    for ( index = 0; index < level._ai_group[ aigroup ].ai.size ; index++ )
    {
        if ( !isalive( level._ai_group[ aigroup ].ai[ index ] ) )
        {
            continue;
        }
        
        aiset[ aiset.size ] = level._ai_group[ aigroup ].ai[ index ];
    }
    
    return aiset;
}

// Namespace spawner
// Params 7
// Checksum 0xd8342a99, Offset: 0x70d0
// Size: 0x198
function add_global_spawn_function( team, spawn_func, param1, param2, param3, param4, param5 )
{
    if ( !isdefined( level.spawn_funcs ) )
    {
        level.spawn_funcs = [];
    }
    
    if ( !isdefined( level.spawn_funcs[ team ] ) )
    {
        level.spawn_funcs[ team ] = [];
    }
    
    func = [];
    func[ "function" ] = spawn_func;
    func[ "param1" ] = param1;
    func[ "param2" ] = param2;
    func[ "param3" ] = param3;
    func[ "param4" ] = param4;
    func[ "param5" ] = param5;
    
    if ( !isdefined( level.spawn_funcs[ team ] ) )
    {
        level.spawn_funcs[ team ] = [];
    }
    else if ( !isarray( level.spawn_funcs[ team ] ) )
    {
        level.spawn_funcs[ team ] = array( level.spawn_funcs[ team ] );
    }
    
    level.spawn_funcs[ team ][ level.spawn_funcs[ team ].size ] = func;
}

// Namespace spawner
// Params 7
// Checksum 0x9d501e2e, Offset: 0x7270
// Size: 0x198
function add_archetype_spawn_function( archetype, spawn_func, param1, param2, param3, param4, param5 )
{
    if ( !isdefined( level.spawn_funcs ) )
    {
        level.spawn_funcs = [];
    }
    
    if ( !isdefined( level.spawn_funcs[ archetype ] ) )
    {
        level.spawn_funcs[ archetype ] = [];
    }
    
    func = [];
    func[ "function" ] = spawn_func;
    func[ "param1" ] = param1;
    func[ "param2" ] = param2;
    func[ "param3" ] = param3;
    func[ "param4" ] = param4;
    func[ "param5" ] = param5;
    
    if ( !isdefined( level.spawn_funcs[ archetype ] ) )
    {
        level.spawn_funcs[ archetype ] = [];
    }
    else if ( !isarray( level.spawn_funcs[ archetype ] ) )
    {
        level.spawn_funcs[ archetype ] = array( level.spawn_funcs[ archetype ] );
    }
    
    level.spawn_funcs[ archetype ][ level.spawn_funcs[ archetype ].size ] = func;
}

// Namespace spawner
// Params 2
// Checksum 0x72555217, Offset: 0x7410
// Size: 0xd2
function remove_global_spawn_function( team, func )
{
    if ( isdefined( level.spawn_funcs ) && isdefined( level.spawn_funcs[ team ] ) )
    {
        array = [];
        
        for ( i = 0; i < level.spawn_funcs[ team ].size ; i++ )
        {
            if ( level.spawn_funcs[ team ][ i ][ "function" ] != func )
            {
                array[ array.size ] = level.spawn_funcs[ team ][ i ];
            }
        }
        
        level.spawn_funcs[ team ] = array;
    }
}

// Namespace spawner
// Params 6
// Checksum 0xc9f651f, Offset: 0x74f0
// Size: 0x12a
function add_spawn_function( spawn_func, param1, param2, param3, param4, param5 )
{
    assert( !isdefined( level._loadstarted ) || !isalive( self ), "<dev string:x536>" );
    func = [];
    func[ "function" ] = spawn_func;
    func[ "param1" ] = param1;
    func[ "param2" ] = param2;
    func[ "param3" ] = param3;
    func[ "param4" ] = param4;
    func[ "param5" ] = param5;
    
    if ( !isdefined( self.spawn_funcs ) )
    {
        self.spawn_funcs = [];
    }
    
    self.spawn_funcs[ self.spawn_funcs.size ] = func;
}

// Namespace spawner
// Params 1
// Checksum 0x1268af1f, Offset: 0x7628
// Size: 0x110
function remove_spawn_function( func )
{
    assert( !isdefined( level._loadstarted ) || !isalive( self ), "<dev string:x563>" );
    
    if ( isdefined( self.spawn_funcs ) )
    {
        array = [];
        
        for ( i = 0; i < self.spawn_funcs.size ; i++ )
        {
            if ( self.spawn_funcs[ i ][ "function" ] != func )
            {
                array[ array.size ] = self.spawn_funcs[ i ];
            }
        }
        
        assert( self.spawn_funcs.size != array.size, "<dev string:x593>" );
        self.spawn_funcs = array;
    }
}

// Namespace spawner
// Params 8
// Checksum 0x56d7c2da, Offset: 0x7740
// Size: 0x10c
function add_spawn_function_group( str_value, str_key, func_spawn, param_1, param_2, param_3, param_4, param_5 )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    assert( isdefined( str_value ), "<dev string:x5e6>" );
    assert( isdefined( func_spawn ), "<dev string:x625>" );
    a_spawners = getspawnerarray( str_value, str_key );
    array::run_all( a_spawners, &add_spawn_function, func_spawn, param_1, param_2, param_3, param_4, param_5 );
}

// Namespace spawner
// Params 7
// Checksum 0x4defd897, Offset: 0x7858
// Size: 0xf4
function add_spawn_function_ai_group( str_aigroup, func_spawn, param_1, param_2, param_3, param_4, param_5 )
{
    assert( isdefined( str_aigroup ), "<dev string:x665>" );
    assert( isdefined( func_spawn ), "<dev string:x6a9>" );
    a_spawners = getspawnerarray( str_aigroup, "script_aigroup" );
    array::run_all( a_spawners, &add_spawn_function, func_spawn, param_1, param_2, param_3, param_4, param_5 );
}

// Namespace spawner
// Params 7
// Checksum 0x1caf5be3, Offset: 0x7958
// Size: 0xdc
function remove_spawn_function_ai_group( str_aigroup, func_spawn, param_1, param_2, param_3, param_4, param_5 )
{
    assert( isdefined( str_aigroup ), "<dev string:x6ec>" );
    assert( isdefined( func_spawn ), "<dev string:x733>" );
    a_spawners = getspawnerarray( str_aigroup, "script_aigroup" );
    array::run_all( a_spawners, &remove_spawn_function, func_spawn );
}

// Namespace spawner
// Params 3
// Checksum 0xf16b73ee, Offset: 0x7a40
// Size: 0x19e
function simple_flood_spawn( name, spawn_func, spawn_func_2 )
{
    spawners = getentarray( name, "targetname" );
    assert( spawners.size, "<dev string:x779>" + name + "<dev string:x796>" );
    
    if ( isdefined( spawn_func ) )
    {
        for ( i = 0; i < spawners.size ; i++ )
        {
            spawners[ i ] add_spawn_function( spawn_func );
        }
    }
    
    if ( isdefined( spawn_func_2 ) )
    {
        for ( i = 0; i < spawners.size ; i++ )
        {
            spawners[ i ] add_spawn_function( spawn_func_2 );
        }
    }
    
    for ( i = 0; i < spawners.size ; i++ )
    {
        if ( i % 2 )
        {
            util::wait_network_frame();
        }
        
        spawners[ i ] thread flood_spawner_init();
        spawners[ i ] thread flood_spawner_think();
    }
}

// Namespace spawner
// Params 8
// Checksum 0x8797b29a, Offset: 0x7be8
// Size: 0x264
function simple_spawn( name_or_spawners, spawn_func, param1, param2, param3, param4, param5, bforce )
{
    spawners = [];
    
    if ( isstring( name_or_spawners ) )
    {
        spawners = getentarray( name_or_spawners, "targetname" );
        assert( spawners.size, "<dev string:x779>" + name_or_spawners + "<dev string:x796>" );
    }
    else
    {
        if ( !isdefined( name_or_spawners ) )
        {
            name_or_spawners = [];
        }
        else if ( !isarray( name_or_spawners ) )
        {
            name_or_spawners = array( name_or_spawners );
        }
        
        spawners = name_or_spawners;
    }
    
    a_spawned = [];
    
    foreach ( sp in spawners )
    {
        e_spawned = sp spawn( bforce );
        
        if ( isdefined( e_spawned ) )
        {
            if ( isdefined( spawn_func ) )
            {
                util::single_thread( e_spawned, spawn_func, param1, param2, param3, param4, param5 );
            }
            
            if ( !isdefined( a_spawned ) )
            {
                a_spawned = [];
            }
            else if ( !isarray( a_spawned ) )
            {
                a_spawned = array( a_spawned );
            }
            
            a_spawned[ a_spawned.size ] = e_spawned;
        }
    }
    
    return a_spawned;
}

// Namespace spawner
// Params 8
// Checksum 0xfec77c50, Offset: 0x7e58
// Size: 0xc0
function simple_spawn_single( name_or_spawner, spawn_func, param1, param2, param3, param4, param5, bforce )
{
    ai = simple_spawn( name_or_spawner, spawn_func, param1, param2, param3, param4, param5, bforce );
    assert( ai.size <= 1, "<dev string:x79e>" );
    
    if ( ai.size )
    {
        return ai[ 0 ];
    }
}

// Namespace spawner
// Params 1
// Checksum 0x8823e476, Offset: 0x7f20
// Size: 0x3c
function set_targets( spawner_targets )
{
    self thread go_to_spawner_target( strtok( spawner_targets, " " ) );
}

/#

    // Namespace spawner
    // Params 1
    // Checksum 0xaaffa16e, Offset: 0x7f68
    // Size: 0x8a, Type: dev
    function getscoreinfoxp( type )
    {
        if ( isdefined( level.scoreinfo ) && isdefined( level.scoreinfo[ type ] ) )
        {
            n_xp = level.scoreinfo[ type ][ "<dev string:x7ee>" ];
            
            if ( isdefined( level.xpmodifiercallback ) && isdefined( n_xp ) )
            {
                n_xp = [[ level.xpmodifiercallback ]]( type, n_xp );
            }
            
            return n_xp;
        }
    }

    // Namespace spawner
    // Params 0, eflags: 0x2
    // Checksum 0x54b03394, Offset: 0x8000
    // Size: 0x13c, Type: dev
    function autoexec init_npcdeathtracking()
    {
        level.a_npcdeaths = [];
        level.str_killsoutput = "<dev string:x7f1>";
        callback::add_callback( #"hash_8c38c12e", &track_npc_deaths );
        callback::add_callback( #"hash_acb66515", &track_vehicle_deaths );
        callback::add_callback( #"hash_7b543e98", &show_actor_damage );
        callback::add_callback( #"hash_9bd1e27f", &show_vehicle_damage );
        setdvar( "<dev string:x7f2>", 0 );
        setdvar( "<dev string:x801>", 0 );
        setdvar( "<dev string:x818>", 0 );
        setdvar( "<dev string:x82e>", 0 );
        level thread listenfornpcdeaths();
    }

    // Namespace spawner
    // Params 1
    // Checksum 0x1771125f, Offset: 0x8148
    // Size: 0x134, Type: dev
    function track_vehicle_deaths( params )
    {
        b_killed_by_player = 0;
        
        if ( isdefined( params ) && isplayer( params.eattacker ) )
        {
            b_killed_by_player = 1;
            
            if ( getdvarint( "<dev string:x7f2>" ) )
            {
                n_xp_value = getscoreinfoxp( "<dev string:x846>" + self.scoretype );
                v_death_position = self.origin;
                n_print_height = 50;
                
                if ( isdefined( self.height ) )
                {
                    n_print_height = self.height;
                }
                
                v_death_position += ( 0, 0, n_print_height );
                show_xp_popup_for_enemy( n_xp_value, v_death_position );
            }
        }
        
        adddeadnpctolist( b_killed_by_player );
    }

    // Namespace spawner
    // Params 1
    // Checksum 0x2e4c830b, Offset: 0x8288
    // Size: 0x124, Type: dev
    function track_npc_deaths( params )
    {
        b_killed_by_player = 0;
        
        if ( isplayer( params.eattacker ) )
        {
            b_killed_by_player = 1;
            
            if ( getdvarint( "<dev string:x7f2>" ) )
            {
                n_xp_value = getscoreinfoxp( "<dev string:x846>" + self.scoretype );
                v_death_position = self.origin;
                n_print_height = 72;
                
                if ( isdefined( self.goalheight ) )
                {
                    n_print_height = self.goalheight - 12;
                }
                
                v_death_position += ( 0, 0, n_print_height );
                show_xp_popup_for_enemy( n_xp_value, v_death_position );
            }
        }
        
        adddeadnpctolist( b_killed_by_player );
    }

    // Namespace spawner
    // Params 1
    // Checksum 0x8f68f498, Offset: 0x83b8
    // Size: 0x13c, Type: dev
    function show_actor_damage( params )
    {
        v_print_pos = ( 0, 0, 0 );
        n_damage_value = params.idamage;
        
        if ( getdvarstring( "<dev string:x84b>" ) == "<dev string:x858>" )
        {
            if ( isdefined( self gettagorigin( "<dev string:x85b>" ) ) )
            {
                v_position = self gettagorigin( "<dev string:x85b>" ) + ( 0, 0, 18 );
            }
            else
            {
                v_position = self getorigin() + ( 0, 0, 78 );
            }
            
            level thread show_number_popup( n_damage_value, v_position, "<dev string:x863>", "<dev string:x865>", ( 0.96, 0.12, 0.12 ), 1, 0.6 );
        }
    }

    // Namespace spawner
    // Params 1
    // Checksum 0xddc7639f, Offset: 0x8500
    // Size: 0xfc, Type: dev
    function show_vehicle_damage( params )
    {
        v_print_pos = ( 0, 0, 0 );
        n_damage_value = params.idamage;
        
        if ( getdvarstring( "<dev string:x84b>" ) == "<dev string:x858>" )
        {
            v_print_pos = self.origin;
            n_print_height = 50;
            
            if ( isdefined( self.height ) )
            {
                n_print_height = self.height;
            }
            
            v_print_pos += ( 0, 0, n_print_height );
            level thread show_number_popup( n_damage_value, v_print_pos, "<dev string:x863>", "<dev string:x865>", ( 0.96, 0.12, 0.12 ), 1, 0.6 );
        }
    }

    // Namespace spawner
    // Params 2
    // Checksum 0xba0335d1, Offset: 0x8608
    // Size: 0x6c, Type: dev
    function show_xp_popup_for_enemy( n_xp_value, v_position )
    {
        level thread show_number_popup( n_xp_value, v_position, "<dev string:x867>", "<dev string:x7ee>", ( 0.83, 0.18, 0.76 ), 1, 0.7 );
    }

    // Namespace spawner
    // Params 7
    // Checksum 0x57f4fe92, Offset: 0x8680
    // Size: 0x10a, Type: dev
    function show_number_popup( n_value, v_pos, string_prefix, string_suffix, color, n_alpha, n_size )
    {
        n_current_tick = 0;
        n_current_alpha = n_alpha;
        v_print_position = v_pos;
        
        while ( n_current_tick < 40 )
        {
            v_print_position += ( 0, 0, 1.125 );
            print3d( v_print_position, string_prefix + n_value + string_suffix, color, n_current_alpha, n_size, 1 );
            
            if ( n_current_tick >= 20 )
            {
                n_current_alpha -= 1 / 20;
            }
            
            wait 0.05;
            n_current_tick++;
        }
    }

    // Namespace spawner
    // Params 1
    // Checksum 0x64225c33, Offset: 0x8798
    // Size: 0x60, Type: dev
    function get_xp_value_for_enemy( e_enemy )
    {
        n_xp_value = getscoreinfoxp( "<dev string:x846>" + e_enemy.scoretype );
        
        if ( isdefined( n_xp_value ) )
        {
            return n_xp_value;
        }
        
        return 0;
    }

    // Namespace spawner
    // Params 1
    // Checksum 0x331d1f5f, Offset: 0x8800
    // Size: 0x25a, Type: dev
    function adddeadnpctolist( b_killed_by_player )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( self.team == "<dev string:x4b6>" || self.team == "<dev string:x869>" )
        {
            bentryexists = 0;
            
            for ( i = 0; i < level.a_npcdeaths.size ; i++ )
            {
                if ( level.a_npcdeaths[ i ].strscoretype == self.scoretype )
                {
                    level.a_npcdeaths[ i ].icount += 1;
                    
                    if ( b_killed_by_player )
                    {
                        level.a_npcdeaths[ i ].ikilledbyplayercount += 1;
                        
                        if ( isdefined( level.a_npcdeaths[ i ].ixpvaluesum ) )
                        {
                            level.a_npcdeaths[ i ].ixpvaluesum += get_xp_value_for_enemy( self );
                        }
                    }
                    
                    bentryexists = 1;
                }
            }
            
            if ( !bentryexists )
            {
                s_npcdeath = spawnstruct();
                s_npcdeath.strscoretype = self.scoretype;
                s_npcdeath.icount = 1;
                s_npcdeath.ikilledbyplayercount = 0;
                s_npcdeath.ixpvaluesum = 0;
                
                if ( b_killed_by_player )
                {
                    s_npcdeath.ikilledbyplayercount = 1;
                    s_npcdeath.ixpvaluesum = get_xp_value_for_enemy( self );
                }
                
                itypesofnpcskilled = level.a_npcdeaths.size;
                level.a_npcdeaths[ itypesofnpcskilled ] = s_npcdeath;
            }
        }
    }

    // Namespace spawner
    // Params 0
    // Checksum 0xa62c4046, Offset: 0x8a68
    // Size: 0x2e8, Type: dev
    function listenfornpcdeaths()
    {
        while ( true )
        {
            checkfordeathtrackingreset();
            
            if ( getdvarint( "<dev string:x801>" ) == 1 )
            {
                if ( !isdefined( level.npc_death_tracking_hud_text ) )
                {
                    level.npc_death_tracking_hud_text = newhudelem();
                    level.npc_death_tracking_hud_text.alignx = "<dev string:x86f>";
                    level.npc_death_tracking_hud_text.x = 50;
                    level.npc_death_tracking_hud_text.y = 60;
                    level.npc_death_tracking_hud_text.fontscale = 1.5;
                    level.npc_death_tracking_hud_text.color = ( 1, 1, 1 );
                    iprintlnbold( "<dev string:x874>" );
                }
                else
                {
                    level.s_killsoutput = "<dev string:x890>" + getaiteamarray( "<dev string:x4b6>" ).size + "<dev string:x8a4>" + getaiteamarray( "<dev string:x16a>" ).size + "<dev string:x8b8>";
                    level.s_killsoutput += "<dev string:x8bb>";
                    
                    if ( level.a_npcdeaths.size == 0 )
                    {
                        level.s_killsoutput += "<dev string:x8cb>";
                    }
                    else
                    {
                        foreach ( deadnpctypecount in level.a_npcdeaths )
                        {
                            level.s_killsoutput = level.s_killsoutput + deadnpctypecount.strscoretype + "<dev string:x8da>" + deadnpctypecount.icount + "<dev string:x8dd>" + deadnpctypecount.ikilledbyplayercount + "<dev string:x8e9>";
                        }
                    }
                    
                    if ( getdvarint( "<dev string:x82e>" ) == 1 )
                    {
                        level.npc_death_tracking_hud_text settext( level.s_killsoutput );
                    }
                }
            }
            else if ( isdefined( level.npc_death_tracking_hud_text ) )
            {
                level.npc_death_tracking_hud_text destroy();
                iprintlnbold( "<dev string:x8eb>" );
            }
            
            wait 0.25;
        }
    }

    // Namespace spawner
    // Params 0
    // Checksum 0x6e212213, Offset: 0x8d58
    // Size: 0x6c, Type: dev
    function checkfordeathtrackingreset()
    {
        if ( getdvarint( "<dev string:x818>" ) == 1 )
        {
            level.a_npcdeaths = [];
            iprintln( "<dev string:x906>" );
            setdvar( "<dev string:x818>", 0 );
        }
    }

#/

// Namespace spawner
// Params 0, eflags: 0x2
// Checksum 0x432f6d00, Offset: 0x8dd0
// Size: 0x24
function autoexec init_female_spawn()
{
    level.female_percent = 0;
    set_female_percent( 30 );
}

// Namespace spawner
// Params 1
// Checksum 0x8727635b, Offset: 0x8e00
// Size: 0x18
function set_female_percent( percent )
{
    level.female_percent = percent;
}

