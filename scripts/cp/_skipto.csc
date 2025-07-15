#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/load_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace skipto;

// Namespace skipto
// Params 0, eflags: 0x2
// Checksum 0xf6497cb8, Offset: 0x2f0
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "skipto", &__init__, &__main__, undefined );
}

// Namespace skipto
// Params 0
// Checksum 0xb395c696, Offset: 0x338
// Size: 0x18c
function __init__()
{
    level flag::init( "running_skipto" );
    level flag::init( "level_has_skiptos" );
    level flag::init( "level_has_skipto_branches" );
    level.skipto_current_objective = [];
    clientfield::register( "toplayer", "catch_up_transition", 1, 1, "counter", &catch_up_transition, 0, 0 );
    clientfield::register( "world", "set_last_map_dvar", 1, 1, "counter", &set_last_map_dvar, 0, 0 );
    add_internal( "_default" );
    add_internal( "no_game" );
    load_mission_table( "gamedata/tables/cp/cp_mapmissions.csv", getdvarstring( "mapname" ) );
    level thread watch_players_connect();
    level thread function_91c7f6af();
}

// Namespace skipto
// Params 0
// Checksum 0xdc31582f, Offset: 0x4d0
// Size: 0xcc
function __main__()
{
    level thread handle();
    nextmapmodel = getuimodel( getglobaluimodel(), "nextMap" );
    
    if ( !util::is_safehouse() )
    {
        nextmapmodel = createuimodel( getglobaluimodel(), "nextMap" );
        setuimodelvalue( nextmapmodel, getdvarstring( "ui_mapname" ) );
    }
}

// Namespace skipto
// Params 6
// Checksum 0xcfa0fcf, Offset: 0x5a8
// Size: 0x32c
function add( skipto, func, loc_string, cleanup_func, launch_after, end_before )
{
    if ( !isdefined( level.default_skipto ) )
    {
        level.default_skipto = skipto;
    }
    
    if ( is_dev( skipto ) )
    {
        errormsg( "<dev string:x28>" );
        return;
    }
    
    if ( isdefined( launch_after ) || isdefined( end_before ) )
    {
        errormsg( "<dev string:x4c>" );
        return;
    }
    
    if ( level flag::get( "level_has_skipto_branches" ) )
    {
        errormsg( "<dev string:x86>" );
    }
    
    if ( !isdefined( launch_after ) )
    {
        if ( isdefined( level.last_skipto ) )
        {
            if ( isdefined( level.skipto_settings[ level.last_skipto ] ) )
            {
                if ( !isdefined( level.skipto_settings[ level.last_skipto ].end_before ) || level.skipto_settings[ level.last_skipto ].end_before.size < 1 )
                {
                    if ( !isdefined( level.skipto_settings[ level.last_skipto ].end_before ) )
                    {
                        level.skipto_settings[ level.last_skipto ].end_before = [];
                    }
                    else if ( !isarray( level.skipto_settings[ level.last_skipto ].end_before ) )
                    {
                        level.skipto_settings[ level.last_skipto ].end_before = array( level.skipto_settings[ level.last_skipto ].end_before );
                    }
                }
                
                level.skipto_settings[ level.last_skipto ].end_before[ level.skipto_settings[ level.last_skipto ].end_before.size ] = skipto;
            }
        }
        
        if ( isdefined( level.last_skipto ) )
        {
            launch_after = level.last_skipto;
        }
        
        level.last_skipto = skipto;
    }
    
    if ( !isdefined( func ) )
    {
        assert( isdefined( func ), "<dev string:xd6>" );
    }
    
    struct = add_internal( skipto, func, loc_string, cleanup_func, launch_after, end_before );
    struct.public = 1;
    level flag::set( "level_has_skiptos" );
}

// Namespace skipto
// Params 6
// Checksum 0xea0b4b2d, Offset: 0x8e0
// Size: 0x314
function add_branch( skipto, func, loc_string, cleanup_func, launch_after, end_before )
{
    if ( !isdefined( level.default_skipto ) )
    {
        level.default_skipto = skipto;
    }
    
    if ( is_dev( skipto ) )
    {
        errormsg( "<dev string:x28>" );
        return;
    }
    
    if ( !isdefined( launch_after ) && !isdefined( end_before ) )
    {
        errormsg( "<dev string:x104>" );
        return;
    }
    
    if ( !isdefined( launch_after ) )
    {
        if ( isdefined( level.last_skipto ) )
        {
            if ( isdefined( level.skipto_settings[ level.last_skipto ] ) )
            {
                if ( !isdefined( level.skipto_settings[ level.last_skipto ].end_before ) || level.skipto_settings[ level.last_skipto ].end_before.size < 1 )
                {
                    if ( !isdefined( level.skipto_settings[ level.last_skipto ].end_before ) )
                    {
                        level.skipto_settings[ level.last_skipto ].end_before = [];
                    }
                    else if ( !isarray( level.skipto_settings[ level.last_skipto ].end_before ) )
                    {
                        level.skipto_settings[ level.last_skipto ].end_before = array( level.skipto_settings[ level.last_skipto ].end_before );
                    }
                }
                
                level.skipto_settings[ level.last_skipto ].end_before[ level.skipto_settings[ level.last_skipto ].end_before.size ] = skipto;
            }
        }
        
        if ( isdefined( level.last_skipto ) )
        {
            launch_after = level.last_skipto;
        }
        
        level.last_skipto = skipto;
    }
    
    if ( !isdefined( func ) )
    {
        assert( isdefined( func ), "<dev string:xd6>" );
    }
    
    struct = add_internal( skipto, func, loc_string, cleanup_func, launch_after, end_before );
    struct.public = 1;
    level flag::set( "level_has_skiptos" );
    level flag::set( "level_has_skipto_branches" );
}

// Namespace skipto
// Params 6
// Checksum 0x1e4797c, Offset: 0xc00
// Size: 0xd4
function add_dev( skipto, func, loc_string, cleanup_func, launch_after, end_before )
{
    if ( !isdefined( level.default_skipto ) )
    {
        level.default_skipto = skipto;
    }
    
    if ( is_dev( skipto ) )
    {
        struct = add_internal( skipto, func, loc_string, cleanup_func, launch_after, end_before );
        struct.dev_skipto = 1;
        return;
    }
    
    errormsg( "<dev string:x136>" );
}

// Namespace skipto
// Params 6
// Checksum 0x3adc9a1f, Offset: 0xce0
// Size: 0xc6
function add_internal( msg, func, loc_string, cleanup_func, launch_after, end_before )
{
    assert( !isdefined( level._loadstarted ), "<dev string:x15f>" );
    msg = tolower( msg );
    struct = add_construct( msg, func, loc_string, cleanup_func, launch_after, end_before );
    level.skipto_settings[ msg ] = struct;
    return struct;
}

// Namespace skipto
// Params 6
// Checksum 0x1888b6dc, Offset: 0xdb0
// Size: 0x194
function change( msg, func, loc_string, cleanup_func, launch_after, end_before )
{
    struct = level.skipto_settings[ msg ];
    
    if ( isdefined( func ) )
    {
        struct.skipto_func = func;
    }
    
    if ( isdefined( loc_string ) )
    {
        struct.skipto_loc_string = loc_string;
    }
    
    if ( isdefined( cleanup_func ) )
    {
        struct.cleanup_func = cleanup_func;
    }
    
    if ( isdefined( launch_after ) )
    {
        if ( !isdefined( struct.launch_after ) )
        {
            struct.launch_after = [];
        }
        else if ( !isarray( struct.launch_after ) )
        {
            struct.launch_after = array( struct.launch_after );
        }
        
        struct.launch_after[ struct.launch_after.size ] = launch_after;
    }
    
    if ( isdefined( end_before ) )
    {
        struct.end_before = strtok( end_before, "," );
        struct.next = struct.end_before;
    }
}

// Namespace skipto
// Params 1
// Checksum 0x11ce4f04, Offset: 0xf50
// Size: 0x18
function set_skipto_cleanup_func( func )
{
    level.func_skipto_cleanup = func;
}

// Namespace skipto
// Params 6
// Checksum 0xfa7ca7cb, Offset: 0xf70
// Size: 0x1f8
function add_construct( msg, func, loc_string, cleanup_func, launch_after, end_before )
{
    struct = spawnstruct();
    struct.name = msg;
    struct.skipto_func = func;
    struct.skipto_loc_string = loc_string;
    struct.cleanup_func = cleanup_func;
    struct.next = [];
    struct.prev = [];
    struct.completion_conditions = "";
    struct.launch_after = [];
    
    if ( isdefined( launch_after ) )
    {
        if ( !isdefined( struct.launch_after ) )
        {
            struct.launch_after = [];
        }
        else if ( !isarray( struct.launch_after ) )
        {
            struct.launch_after = array( struct.launch_after );
        }
        
        struct.launch_after[ struct.launch_after.size ] = launch_after;
    }
    
    struct.end_before = [];
    
    if ( isdefined( end_before ) )
    {
        struct.end_before = strtok( end_before, "," );
        struct.next = struct.end_before;
    }
    
    struct.ent_movers = [];
    return struct;
}

// Namespace skipto
// Params 0
// Checksum 0x4df09a09, Offset: 0x1170
// Size: 0x71c
function build_objective_tree()
{
    foreach ( struct in level.skipto_settings )
    {
        if ( isdefined( struct.public ) && struct.public )
        {
            if ( struct.launch_after.size )
            {
                foreach ( launch_after in struct.launch_after )
                {
                    if ( isdefined( level.skipto_settings[ launch_after ] ) )
                    {
                        if ( !isinarray( level.skipto_settings[ launch_after ].next, struct.name ) )
                        {
                            if ( !isdefined( level.skipto_settings[ launch_after ].next ) )
                            {
                                level.skipto_settings[ launch_after ].next = [];
                            }
                            else if ( !isarray( level.skipto_settings[ launch_after ].next ) )
                            {
                                level.skipto_settings[ launch_after ].next = array( level.skipto_settings[ launch_after ].next );
                            }
                            
                            level.skipto_settings[ launch_after ].next[ level.skipto_settings[ launch_after ].next.size ] = struct.name;
                        }
                        
                        continue;
                    }
                    
                    if ( !isdefined( level.skipto_settings[ "_default" ].next ) )
                    {
                        level.skipto_settings[ "_default" ].next = [];
                    }
                    else if ( !isarray( level.skipto_settings[ "_default" ].next ) )
                    {
                        level.skipto_settings[ "_default" ].next = array( level.skipto_settings[ "_default" ].next );
                    }
                    
                    level.skipto_settings[ "_default" ].next[ level.skipto_settings[ "_default" ].next.size ] = struct.name;
                }
            }
            else
            {
                if ( !isdefined( level.skipto_settings[ "_default" ].next ) )
                {
                    level.skipto_settings[ "_default" ].next = [];
                }
                else if ( !isarray( level.skipto_settings[ "_default" ].next ) )
                {
                    level.skipto_settings[ "_default" ].next = array( level.skipto_settings[ "_default" ].next );
                }
                
                level.skipto_settings[ "_default" ].next[ level.skipto_settings[ "_default" ].next.size ] = struct.name;
            }
            
            foreach ( end_before in struct.end_before )
            {
                if ( isdefined( level.skipto_settings[ end_before ] ) )
                {
                    if ( !isdefined( level.skipto_settings[ end_before ].prev ) )
                    {
                        level.skipto_settings[ end_before ].prev = [];
                    }
                    else if ( !isarray( level.skipto_settings[ end_before ].prev ) )
                    {
                        level.skipto_settings[ end_before ].prev = array( level.skipto_settings[ end_before ].prev );
                    }
                    
                    level.skipto_settings[ end_before ].prev[ level.skipto_settings[ end_before ].prev.size ] = struct.name;
                }
            }
        }
    }
    
    foreach ( struct in level.skipto_settings )
    {
        if ( isdefined( struct.public ) && struct.public )
        {
            if ( struct.next.size < 1 )
            {
                if ( !isdefined( struct.next ) )
                {
                    struct.next = [];
                }
                else if ( !isarray( struct.next ) )
                {
                    struct.next = array( struct.next );
                }
                
                struct.next[ struct.next.size ] = "_exit";
            }
        }
    }
}

// Namespace skipto
// Params 1
// Checksum 0x3ad732f, Offset: 0x1898
// Size: 0x60, Type: bool
function is_dev( skipto )
{
    substr = tolower( getsubstr( skipto, 0, 4 ) );
    
    if ( substr == "dev_" )
    {
        return true;
    }
    
    return false;
}

// Namespace skipto
// Params 0
// Checksum 0x101492ef, Offset: 0x1900
// Size: 0x22
function level_has_skipto_points()
{
    return level flag::get( "level_has_skiptos" );
}

// Namespace skipto
// Params 0
// Checksum 0x5fbed789, Offset: 0x1930
// Size: 0x64
function get_current_skiptos()
{
    skiptos = tolower( getskiptos() );
    result = strtok( skiptos, "," );
    return result;
}

// Namespace skipto
// Params 0
// Checksum 0x934f972, Offset: 0x19a0
// Size: 0xb8
function handle()
{
    wait_for_first_player();
    build_objective_tree();
    run_initial_logic();
    skiptos = get_current_skiptos();
    set_level_objective( skiptos, 1 );
    
    while ( true )
    {
        level waittill( #"skiptos_changed" );
        skiptos = get_current_skiptos();
        set_level_objective( skiptos, 0 );
    }
}

// Namespace skipto
// Params 1
// Checksum 0x17e5378, Offset: 0x1a60
// Size: 0x18
function set_cleanup_func( func )
{
    level.func_skipto_cleanup = func;
}

// Namespace skipto
// Params 1
// Checksum 0x4a331fdb, Offset: 0x1a80
// Size: 0x18
function default_skipto( skipto )
{
    level.default_skipto = skipto;
}

// Namespace skipto
// Params 3
// Checksum 0x3ce8a45c, Offset: 0x1aa0
// Size: 0x108
function convert_token( str, fromtok, totok )
{
    sarray = strtok( str, fromtok );
    ostr = "";
    first = 1;
    
    foreach ( s in sarray )
    {
        if ( !first )
        {
            ostr += totok;
        }
        
        first = 0;
        ostr += s;
    }
    
    return ostr;
}

// Namespace skipto
// Params 3
// Checksum 0xbc62726f, Offset: 0x1bb0
// Size: 0x174
function load_mission_table( table, levelname, sublevel )
{
    if ( !isdefined( sublevel ) )
    {
        sublevel = "";
    }
    
    index = 0;
    
    for ( row = tablelookuprow( table, index ); isdefined( row ) ; row = tablelookuprow( table, index ) )
    {
        if ( row[ 0 ] == levelname && row[ 1 ] == sublevel )
        {
            skipto = row[ 2 ];
            launch_after = row[ 3 ];
            end_before = row[ 4 ];
            end_before = convert_token( end_before, "+", "," );
            locstr = row[ 5 ];
            add_branch( skipto, &load_mission_init, locstr, undefined, launch_after, end_before );
        }
        
        index++;
    }
}

// Namespace skipto
// Params 0
// Checksum 0x99ec1590, Offset: 0x1d30
// Size: 0x4
function load_mission_init()
{
    
}

// Namespace skipto
// Params 0
// Checksum 0xd45890a5, Offset: 0x1d40
// Size: 0x24
function wait_for_first_player()
{
    level flag::wait_till( "skipto_player_connected" );
}

// Namespace skipto
// Params 0
// Checksum 0x7dbc5bf9, Offset: 0x1d70
// Size: 0x6c
function watch_players_connect()
{
    if ( !level flag::exists( "skipto_player_connected" ) )
    {
        level flag::init( "skipto_player_connected" );
    }
    
    callback::add_callback( #"hash_da8d7d74", &on_player_connect );
}

// Namespace skipto
// Params 1
// Checksum 0x1f49fbec, Offset: 0x1de8
// Size: 0x2c
function on_player_connect( localclientnum )
{
    level flag::set( "skipto_player_connected" );
}

// Namespace skipto
// Params 2
// Checksum 0xc1f392ea, Offset: 0x1e20
// Size: 0x2a4
function set_level_objective( objectives, starting )
{
    clear_recursion();
    
    if ( starting )
    {
        foreach ( objective in objectives )
        {
            if ( isdefined( level.skipto_settings[ objective ] ) )
            {
                stop_objective_logic( level.skipto_settings[ objective ].prev, starting );
            }
        }
    }
    else
    {
        foreach ( skipto in level.skipto_settings )
        {
            if ( isdefined( skipto.objective_running ) && skipto.objective_running && !isinarray( objectives, skipto.name ) )
            {
                stop_objective_logic( skipto.name, starting );
            }
        }
    }
    
    if ( isdefined( level.func_skipto_cleanup ) )
    {
        foreach ( name in objectives )
        {
            thread [[ level.func_skipto_cleanup ]]( name );
        }
    }
    
    start_objective_logic( objectives, starting );
    level.skipto_point = level.skipto_current_objective[ 0 ];
    level notify( #"objective_changed", level.skipto_current_objective );
    level.skipto_current_objective = objectives;
}

// Namespace skipto
// Params 1
// Checksum 0x53504fc9, Offset: 0x20d0
// Size: 0xe6
function run_initial_logic( objectives )
{
    foreach ( skipto in level.skipto_settings )
    {
        if ( !( isdefined( skipto.logic_running ) && skipto.logic_running ) )
        {
            skipto.logic_running = 1;
            
            if ( isdefined( skipto.logic_func ) )
            {
                thread [[ skipto.logic_func ]]( skipto.name );
            }
        }
    }
}

// Namespace skipto
// Params 2
// Checksum 0x546751aa, Offset: 0x21c0
// Size: 0x220
function start_objective_logic( name, starting )
{
    if ( isarray( name ) )
    {
        foreach ( element in name )
        {
            start_objective_logic( element, starting );
        }
        
        return;
    }
    
    if ( isdefined( level.skipto_settings[ name ] ) )
    {
        if ( !( isdefined( level.skipto_settings[ name ].objective_running ) && level.skipto_settings[ name ].objective_running ) )
        {
            if ( !isinarray( level.skipto_current_objective, name ) )
            {
                if ( !isdefined( level.skipto_current_objective ) )
                {
                    level.skipto_current_objective = [];
                }
                else if ( !isarray( level.skipto_current_objective ) )
                {
                    level.skipto_current_objective = array( level.skipto_current_objective );
                }
                
                level.skipto_current_objective[ level.skipto_current_objective.size ] = name;
            }
            
            level notify( name + "_init" );
            level.skipto_settings[ name ].objective_running = 1;
            standard_objective_init( name, starting );
            
            if ( isdefined( level.skipto_settings[ name ].skipto_func ) )
            {
                thread [[ level.skipto_settings[ name ].skipto_func ]]( name, starting );
            }
        }
    }
}

// Namespace skipto
// Params 0
// Checksum 0x67897d1c, Offset: 0x23e8
// Size: 0x86
function clear_recursion()
{
    foreach ( skipto in level.skipto_settings )
    {
        skipto.cleanup_recursion = 0;
    }
}

// Namespace skipto
// Params 2
// Checksum 0x43e8b003, Offset: 0x2478
// Size: 0x2e4
function stop_objective_logic( name, starting )
{
    if ( isarray( name ) )
    {
        foreach ( element in name )
        {
            stop_objective_logic( element, starting );
        }
        
        return;
    }
    
    if ( isdefined( level.skipto_settings[ name ] ) )
    {
        cleaned = 0;
        
        if ( isdefined( level.skipto_settings[ name ].objective_running ) && level.skipto_settings[ name ].objective_running )
        {
            cleaned = 1;
            level.skipto_settings[ name ].objective_running = 0;
            
            if ( isinarray( level.skipto_current_objective, name ) )
            {
                arrayremovevalue( level.skipto_current_objective, name );
            }
            
            if ( isdefined( level.skipto_settings[ name ].cleanup_func ) )
            {
                thread [[ level.skipto_settings[ name ].cleanup_func ]]( name, starting );
            }
            
            standard_objective_done( name, starting );
            level notify( name + "_terminate" );
        }
        
        if ( starting && !( isdefined( level.skipto_settings[ name ].cleanup_recursion ) && level.skipto_settings[ name ].cleanup_recursion ) )
        {
            level.skipto_settings[ name ].cleanup_recursion = 1;
            stop_objective_logic( level.skipto_settings[ name ].prev, starting );
            
            if ( !cleaned )
            {
                if ( isdefined( level.skipto_settings[ name ].cleanup_func ) )
                {
                    thread [[ level.skipto_settings[ name ].cleanup_func ]]( name, starting );
                }
                
                standard_objective_done( name, starting );
            }
        }
    }
}

// Namespace skipto
// Params 7
// Checksum 0xd4574b8d, Offset: 0x2768
// Size: 0x7c
function set_last_map_dvar( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    missionname = getdvarstring( "ui_mapname" );
    setdvar( "last_map", missionname );
}

// Namespace skipto
// Params 2, eflags: 0x4
// Checksum 0x27dddc59, Offset: 0x27f0
// Size: 0x14
function private standard_objective_init( objective, starting )
{
    
}

// Namespace skipto
// Params 2, eflags: 0x4
// Checksum 0x281598c5, Offset: 0x2810
// Size: 0x14
function private standard_objective_done( objective, starting )
{
    
}

// Namespace skipto
// Params 7
// Checksum 0x4fc21311, Offset: 0x2830
// Size: 0x54
function catch_up_transition( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    postfx::playpostfxbundle( "pstfx_cp_transition_sprite" );
}

// Namespace skipto
// Params 0
// Checksum 0xaae5bfd5, Offset: 0x2890
// Size: 0x2c
function function_91c7f6af()
{
    level waittill( #"aar" );
    audio::snd_set_snapshot( "cmn_aar_screen" );
}

