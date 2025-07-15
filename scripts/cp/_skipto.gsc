#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_achievements;
#using scripts/cp/_bb;
#using scripts/cp/_challenges;
#using scripts/cp/_decorations;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_spawning;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/load_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/music_shared;
#using scripts/shared/player_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace skipto;

// Namespace skipto
// Params 0, eflags: 0x2
// Checksum 0xb3e302f9, Offset: 0x1008
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "skipto", &__init__, &__main__, undefined );
}

// Namespace skipto
// Params 1
// Checksum 0xeb808336, Offset: 0x1050
// Size: 0x18
function function_97bb1111( mapname )
{
    return mapname + "_nightmares";
}

// Namespace skipto
// Params 0
// Checksum 0x5333694a, Offset: 0x1070
// Size: 0x178
function function_23eda99c()
{
    var_cfc9cbb7 = [];
    array::add( var_cfc9cbb7, "cp_mi_cairo_aquifer" );
    array::add( var_cfc9cbb7, "cp_mi_cairo_infection" );
    array::add( var_cfc9cbb7, "cp_mi_cairo_lotus" );
    array::add( var_cfc9cbb7, "cp_mi_cairo_ramses" );
    array::add( var_cfc9cbb7, "cp_mi_eth_prologue" );
    array::add( var_cfc9cbb7, "cp_mi_sing_biodomes" );
    array::add( var_cfc9cbb7, "cp_mi_sing_blackstation" );
    array::add( var_cfc9cbb7, "cp_mi_sing_sgen" );
    array::add( var_cfc9cbb7, "cp_mi_sing_vengeance" );
    array::add( var_cfc9cbb7, "cp_mi_zurich_coalescence" );
    array::add( var_cfc9cbb7, "cp_mi_zurich_newworld" );
    return var_cfc9cbb7;
}

// Namespace skipto
// Params 0
// Checksum 0x6cd7d766, Offset: 0x11f0
// Size: 0x27c
function __init__()
{
    level flag::init( "start_skiptos" );
    level flag::init( "running_skipto" );
    level flag::init( "level_has_skiptos" );
    level flag::init( "level_has_skipto_branches" );
    level flag::init( "skip_safehouse_after_map" );
    level flag::init( "final_level" );
    level flag::init( "_exit" );
    clientfield::register( "toplayer", "catch_up_transition", 1, 1, "counter" );
    clientfield::register( "world", "set_last_map_dvar", 1, 1, "counter" );
    add_internal( "_default" );
    add_internal( "_exit", &level_completed );
    add_internal( "no_game", &nogame );
    load_mission_table( "gamedata/tables/cp/cp_mapmissions.csv", level.script );
    level.filter_spawnpoints = &filter_spawnpoints;
    callback::on_finalize_initialization( &on_finalize_initialization );
    callback::on_spawned( &on_player_spawn );
    callback::on_connect( &on_player_connect );
    
    /#
        level thread update_billboard();
        callback::on_spawned( &update_player_billboard );
    #/
}

// Namespace skipto
// Params 0
// Checksum 0x1296e8ca, Offset: 0x1478
// Size: 0x4c
function __main__()
{
    level thread entity_mover_main();
    level thread handle();
    level thread function_52904bc9();
}

// Namespace skipto
// Params 7
// Checksum 0x91513088, Offset: 0x14d0
// Size: 0x34c
function add( skipto, func, str_name, cleanup_func, launch_after, end_before, var_2bc8bbd9 )
{
    if ( !isdefined( var_2bc8bbd9 ) )
    {
        var_2bc8bbd9 = 0;
    }
    
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
                    
                    level.skipto_settings[ level.last_skipto ].end_before[ level.skipto_settings[ level.last_skipto ].end_before.size ] = skipto;
                }
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
    
    struct = add_internal( skipto, func, str_name, cleanup_func, launch_after, end_before, var_2bc8bbd9 );
    struct.public = 1;
    level flag::set( "level_has_skiptos" );
}

// Namespace skipto
// Params 6
// Checksum 0xf4ae8e96, Offset: 0x1828
// Size: 0x70
function function_d68e678e( skipto, func, str_name, cleanup_func, launch_after, end_before )
{
    struct = add( skipto, func, str_name, cleanup_func, launch_after, undefined, 1 );
}

// Namespace skipto
// Params 6
// Checksum 0xf40f861c, Offset: 0x18a0
// Size: 0x318
function add_branch( skipto, func, str_name, cleanup_func, launch_after, end_before )
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
                    
                    level.skipto_settings[ level.last_skipto ].end_before[ level.skipto_settings[ level.last_skipto ].end_before.size ] = skipto;
                }
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
    
    struct = add_internal( skipto, func, str_name, cleanup_func, launch_after, end_before );
    struct.public = 1;
    level flag::set( "level_has_skiptos" );
    level flag::set( "level_has_skipto_branches" );
    return struct;
}

// Namespace skipto
// Params 6
// Checksum 0x8ed1f06d, Offset: 0x1bc0
// Size: 0x84
function function_75d02344( skipto, func, str_name, cleanup_func, launch_after, end_before )
{
    struct = add_branch( skipto, func, str_name, cleanup_func, launch_after, end_before );
    
    if ( isdefined( struct ) )
    {
        struct.looping = 1;
    }
}

// Namespace skipto
// Params 6
// Checksum 0x5a135921, Offset: 0x1c50
// Size: 0xd4
function add_dev( skipto, func, str_name, cleanup_func, launch_after, end_before )
{
    if ( !isdefined( level.default_skipto ) )
    {
        level.default_skipto = skipto;
    }
    
    if ( is_dev( skipto ) )
    {
        struct = add_internal( skipto, func, str_name, cleanup_func, launch_after, end_before );
        struct.dev_skipto = 1;
        return;
    }
    
    errormsg( "<dev string:x136>" );
}

// Namespace skipto
// Params 1
// Checksum 0x70d4a16a, Offset: 0x1d30
// Size: 0xfa
function objective_leave_incomplete( skipto )
{
    if ( !isdefined( level.skipto_settings[ skipto ] ) )
    {
        assertmsg( "<dev string:x15f>" + skipto + "<dev string:x182>" );
        return;
    }
    
    level.skipto_settings[ skipto ].objective_mark_complete = 0;
    
    foreach ( player in level.players )
    {
        bb::logobjectivestatuschange( skipto, player, "leave_objective_incomplete" );
    }
}

// Namespace skipto
// Params 5
// Checksum 0xaa2ba3b0, Offset: 0x1e38
// Size: 0x72
function add_billboard( skipto, event_name, event_type, event_size, event_state )
{
    if ( !isdefined( level.billboards ) )
    {
        level.billboards = [];
    }
    
    level.billboards[ skipto ] = array( event_name, event_type, event_size, event_state );
}

// Namespace skipto
// Params 7
// Checksum 0x9cbeee9d, Offset: 0x1eb8
// Size: 0x108
function add_internal( msg, func, str_name, cleanup_func, launch_after, end_before, var_2bc8bbd9 )
{
    assert( !isdefined( level._loadstarted ), "<dev string:x1b7>" );
    msg = tolower( msg );
    struct = add_construct( msg, func, str_name, cleanup_func, launch_after, end_before, var_2bc8bbd9 );
    level.skipto_settings[ msg ] = struct;
    level flag::init( msg );
    level flag::init( msg + "_completed" );
    return struct;
}

// Namespace skipto
// Params 6
// Checksum 0x3ca0f9ee, Offset: 0x1fc8
// Size: 0x124
function change( msg, func, str_name, cleanup_func, launch_after, end_before )
{
    struct = level.skipto_settings[ msg ];
    
    if ( isdefined( func ) )
    {
        struct.skipto_func = func;
    }
    
    if ( isdefined( str_name ) )
    {
        struct.str_name = str_name;
    }
    
    if ( isdefined( cleanup_func ) )
    {
        struct.cleanup_func = cleanup_func;
    }
    
    if ( isdefined( launch_after ) )
    {
        struct.completion_conditions = struct parse_launch_after( launch_after );
    }
    
    if ( isdefined( end_before ) )
    {
        struct.end_before = strtok( end_before, "," );
        struct.next = struct.end_before;
    }
}

// Namespace skipto
// Params 1
// Checksum 0xd3fab905, Offset: 0x20f8
// Size: 0x18
function set_skipto_cleanup_func( func )
{
    level.func_skipto_cleanup = func;
}

// Namespace skipto
// Params 7
// Checksum 0x2fa11fab, Offset: 0x2118
// Size: 0x1e0
function add_construct( msg, func, str_name, cleanup_func, launch_after, end_before, var_2bc8bbd9 )
{
    if ( !isdefined( var_2bc8bbd9 ) )
    {
        var_2bc8bbd9 = 0;
    }
    
    struct = spawnstruct();
    struct.name = msg;
    struct.code_index = registerskipto( msg );
    struct.skipto_func = func;
    struct.str_name = str_name;
    struct.cleanup_func = cleanup_func;
    struct.next = [];
    struct.prev = [];
    struct.completion_conditions = "";
    struct.launch_after = [];
    struct.var_2bc8bbd9 = var_2bc8bbd9;
    
    if ( isdefined( launch_after ) )
    {
        struct.completion_conditions = struct parse_launch_after( launch_after );
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
// Checksum 0x553f2964, Offset: 0x2300
// Size: 0x22
function level_has_skipto_points()
{
    return level flag::get( "level_has_skiptos" );
}

/#

    // Namespace skipto
    // Params 1
    // Checksum 0x66db5c6c, Offset: 0x2330
    // Size: 0x2c, Type: dev
    function parse_error( msg )
    {
        assertmsg( msg );
    }

#/

// Namespace skipto
// Params 1
// Checksum 0x46097ecf, Offset: 0x2368
// Size: 0x2f4
function split_top_level_and_or( instring )
{
    op = "";
    ret = [];
    outindex = 0;
    ret[ outindex ] = "";
    paren = 0;
    
    for ( i = 0; i < instring.size ; i++ )
    {
        c = getsubstr( instring, i, i + 1 );
        
        if ( c == "(" )
        {
            paren++;
            ret[ outindex ] += c;
            continue;
        }
        
        if ( c == ")" )
        {
            paren--;
            ret[ outindex ] += c;
            continue;
        }
        
        if ( paren == 0 && c == "&" )
        {
            if ( op == "|" )
            {
                /#
                    parse_error( "<dev string:x1d8>" + instring );
                #/
            }
            
            op = "&";
            outindex++;
            ret[ outindex ] = "";
            continue;
        }
        
        if ( paren == 0 && c == "|" )
        {
            if ( op == "&" )
            {
                /#
                    parse_error( "<dev string:x1d8>" + instring );
                #/
            }
            
            op = "|";
            outindex++;
            ret[ outindex ] = "";
            continue;
        }
        
        ret[ outindex ] += c;
    }
    
    if ( paren != 0 )
    {
        /#
            parse_error( "<dev string:x204>" + instring );
        #/
    }
    
    for ( j = 0; j <= outindex ; j++ )
    {
        ret[ j ] = remove_parens( ret[ j ] );
    }
    
    if ( outindex == 0 )
    {
        return ret[ outindex ];
    }
    
    ret[ "op" ] = op;
    return ret;
}

// Namespace skipto
// Params 1
// Checksum 0x8a5da9d9, Offset: 0x2668
// Size: 0x16e
function remove_parens( instring )
{
    c = getsubstr( instring, 0, 1 );
    
    if ( c == "(" )
    {
        c2 = getsubstr( instring, instring.size - 1, instring.size );
        
        if ( c2 != ")" )
        {
            /#
                parse_error( "<dev string:x204>" + instring );
            #/
        }
        
        s = getsubstr( instring, 1, instring.size - 1 );
        return split_top_level_and_or( s );
    }
    
    if ( !isdefined( self.launch_after ) )
    {
        self.launch_after = [];
    }
    else if ( !isarray( self.launch_after ) )
    {
        self.launch_after = array( self.launch_after );
    }
    
    self.launch_after[ self.launch_after.size ] = instring;
    return instring;
}

// Namespace skipto
// Params 1
// Checksum 0x9c926c7, Offset: 0x27e0
// Size: 0x52
function parse_launch_after( launch_after )
{
    retval = split_top_level_and_or( launch_after );
    
    if ( isarray( retval ) )
    {
        return retval;
    }
    
    return "";
}

// Namespace skipto
// Params 2
// Checksum 0xb6056e57, Offset: 0x2840
// Size: 0x172
function check_skipto_condition( conditions, adding )
{
    if ( !isarray( conditions ) )
    {
        if ( isdefined( level.skipto_settings[ conditions ].objective_running ) && level.skipto_settings[ conditions ].objective_running || isdefined( level.skipto_settings[ conditions ] ) && isinarray( adding, conditions ) )
        {
            return 0;
        }
        
        return 1;
    }
    
    if ( conditions[ "op" ] == "|" )
    {
        for ( i = 0; i < conditions.size - 1 ; i++ )
        {
            if ( check_skipto_condition( conditions[ i ], adding ) )
            {
                return 1;
            }
        }
        
        return 0;
    }
    
    for ( i = 0; i < conditions.size - 1 ; i++ )
    {
        if ( !check_skipto_condition( conditions[ i ], adding ) )
        {
            return 0;
        }
    }
    
    return 1;
}

// Namespace skipto
// Params 1
// Checksum 0x9ae446ba, Offset: 0x29c0
// Size: 0x11c
function check_skipto_conditions( objectives )
{
    result = [];
    
    foreach ( name in objectives )
    {
        if ( check_skipto_condition( level.skipto_settings[ name ].completion_conditions, result ) )
        {
            if ( !isdefined( result ) )
            {
                result = [];
            }
            else if ( !isarray( result ) )
            {
                result = array( result );
            }
            
            result[ result.size ] = name;
        }
    }
    
    return result;
}

// Namespace skipto
// Params 0
// Checksum 0x75a36697, Offset: 0x2ae8
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
// Checksum 0xeb6401ea, Offset: 0x3210
// Size: 0x52
function get_next_skiptos( skipto_name )
{
    if ( isdefined( level.skipto_settings[ skipto_name ] ) )
    {
        return level.skipto_settings[ skipto_name ].next;
    }
    
    return level.skipto_settings[ "_default" ].next;
}

// Namespace skipto
// Params 1
// Checksum 0xf7edfe17, Offset: 0x3270
// Size: 0xd8
function skiptos_to_string( skiptos )
{
    skiptostr = "";
    first = 1;
    
    foreach ( skipto in skiptos )
    {
        if ( !first )
        {
            skiptostr += ",";
        }
        
        first = 0;
        skiptostr += skipto;
    }
    
    return skiptostr;
}

// Namespace skipto
// Params 1
// Checksum 0xf3abb158, Offset: 0x3350
// Size: 0x124
function get_current_skiptos( var_533a04a6 )
{
    var_c61bfb3e = getdvarstring( "skipto_jump" );
    
    if ( isdefined( var_c61bfb3e ) && var_c61bfb3e.size )
    {
        if ( var_c61bfb3e == "_default" )
        {
            var_c61bfb3e = "";
        }
        
        skiptos = [];
        skiptos[ 0 ] = var_c61bfb3e;
        return skiptos;
    }
    
    if ( isdefined( var_533a04a6 ) && var_533a04a6 )
    {
        skiptos = tolower( getdvarstring( "sv_saveGameSkipto" ) );
    }
    else
    {
        skiptos = tolower( getskiptos() );
    }
    
    result = strtok( skiptos, "," );
    return result;
}

// Namespace skipto
// Params 0
// Checksum 0x89792aab, Offset: 0x3480
// Size: 0x4e
function function_52c50cb8()
{
    if ( !isdefined( level.skipto_point ) || !isdefined( level.skipto_settings[ level.skipto_point ] ) )
    {
        return -1;
    }
    
    return level.skipto_settings[ level.skipto_point ].code_index;
}

// Namespace skipto
// Params 1
// Checksum 0x4b2d3652, Offset: 0x34d8
// Size: 0x9c
function set_current_skipto( skipto )
{
    if ( skipto != "" && level.skipto_settings[ skipto ].var_2bc8bbd9 === 1 )
    {
        setskiptos( tolower( skipto ), 1 );
        return;
    }
    
    setskiptos( tolower( skipto ), 0 );
}

// Namespace skipto
// Params 1
// Checksum 0xb09513e, Offset: 0x3580
// Size: 0x34
function set_current_skiptos( skiptos )
{
    set_current_skipto( skiptos_to_string( skiptos ) );
}

// Namespace skipto
// Params 0
// Checksum 0xb7f0b3fe, Offset: 0x35c0
// Size: 0x3c
function use_default_skipto()
{
    if ( !isdefined( level.default_skipto ) )
    {
        level.default_skipto = "";
    }
    
    set_current_skipto( level.default_skipto );
}

/#

    // Namespace skipto
    // Params 2
    // Checksum 0x9a685c4f, Offset: 0x3608
    // Size: 0x1f4, Type: dev
    function indicate( skipto, index )
    {
        if ( isdefined( getdvarstring( "<dev string:x22f>" ) ) && getdvarint( "<dev string:x22f>" ) )
        {
            return;
        }
        
        hudelem = newhudelem();
        hudelem.alignx = "<dev string:x241>";
        hudelem.aligny = "<dev string:x246>";
        hudelem.x = 125;
        hudelem.y = 20 * ( index + 2 );
        hudelem.fontscale = 1.5;
        hudelem.sort = 20;
        hudelem.alpha = 0;
        hudelem.color = ( 0.8, 0.8, 0.8 );
        hudelem.font = "<dev string:x24a>";
        hudelem settext( skipto );
        wait 0.25 * ( index + 1 );
        hudelem fadeovertime( 0.25 );
        hudelem.alpha = 1;
        wait 0.25;
        wait 3;
        hudelem fadeovertime( 0.75 );
        hudelem.alpha = 0;
        wait 0.75;
        hudelem destroy();
    }

#/

// Namespace skipto
// Params 1
// Checksum 0x27646b6c, Offset: 0x3808
// Size: 0xf6
function validate_skiptos( skiptos )
{
    done = 0;
    
    while ( isdefined( skiptos ) && skiptos.size && !done )
    {
        done = 1;
        
        foreach ( skipto in skiptos )
        {
            if ( !isdefined( level.skipto_settings[ skipto ] ) )
            {
                arrayremovevalue( skiptos, skipto, 0 );
                done = 0;
                break;
            }
        }
    }
    
    return skiptos;
}

// Namespace skipto
// Params 0
// Checksum 0x5351eeed, Offset: 0x3908
// Size: 0x33c
function handle()
{
    build_objective_tree();
    clear_menu();
    level flag::wait_till( "start_skiptos" );
    default_skiptos = get_next_skiptos( "_default" );
    skiptos = get_current_skiptos( 1 );
    var_c61bfb3e = getdvarstring( "skipto_jump" );
    
    if ( isdefined( var_c61bfb3e ) && var_c61bfb3e.size )
    {
        setdvar( "skipto_jump", "" );
    }
    
    skiptos = validate_skiptos( skiptos );
    assert( isdefined( level.first_frame ) && level.first_frame, "<dev string:x250>" );
    
    if ( isdefined( level.skipto_point ) )
    {
        skiptos = [];
        skiptos[ 0 ] = level.skipto_point;
    }
    
    level.skipto_current_objective = skiptos;
    skipto = skiptos[ 0 ];
    
    if ( isdefined( skipto ) && isdefined( level.skipto_settings[ skipto ] ) )
    {
        level.skipto_point = skipto;
    }
    
    is_default = 0;
    start = level.skipto_current_objective;
    
    if ( start.size < 1 )
    {
        is_default = 1;
        start = default_skiptos;
        
        if ( isdefined( level.default_skipto ) )
        {
            level.skipto_point = level.default_skipto;
        }
        
        savegame_create();
    }
    
    level.skipto_points = start;
    skipto = start[ 0 ];
    
    if ( isdefined( skipto ) && isdefined( level.skipto_settings[ skipto ] ) )
    {
        level.skipto_point = skipto;
    }
    
    if ( start.size < 1 )
    {
        return;
    }
    
    if ( !is_default )
    {
        entity_mover_use_objectives( default_skiptos );
    }
    
    level flagsys::set( "scene_on_load_wait" );
    set_level_objective( start, 1 );
    
    if ( is_default )
    {
        thread savegame::save();
    }
    else
    {
        thread savegame::load();
    }
    
    thread devgui();
    
    /#
        waittillframeend();
        thread menu();
        level thread dev_warning();
    #/
}

// Namespace skipto
// Params 2
// Checksum 0xcb8396ec, Offset: 0x3c50
// Size: 0x1cc
function create( skipto, index )
{
    alpha = 1;
    color = ( 0.9, 0.9, 0.9 );
    
    if ( index != -1 )
    {
        if ( index != 4 )
        {
            alpha = 1 - abs( 4 - index ) / 4;
        }
        else
        {
            color = ( 1, 1, 0 );
        }
    }
    
    if ( alpha == 0 )
    {
        alpha = 0.05;
    }
    
    hudelem = newhudelem();
    hudelem.alignx = "left";
    hudelem.aligny = "middle";
    hudelem.x = 80;
    hudelem.y = 80 + index * 18;
    hudelem settext( skipto );
    hudelem.alpha = 0;
    hudelem.foreground = 1;
    hudelem.color = color;
    hudelem.fontscale = 1.75;
    hudelem fadeovertime( 0.5 );
    hudelem.alpha = alpha;
    return hudelem;
}

// Namespace skipto
// Params 0
// Checksum 0xa5831ccc, Offset: 0x3e28
// Size: 0x2c
function clear_menu()
{
    rootclear = "devgui_remove \"Map/Skipto\" \n";
    adddebugcommand( rootclear );
}

// Namespace skipto
// Params 0
// Checksum 0x4556b1f4, Offset: 0x3e60
// Size: 0x2b8
function devgui()
{
    rootmenu = "devgui_cmd \"Map/Skipto/";
    jumpmenu = rootmenu + "Jump to/";
    index = 1;
    adddebugcommand( jumpmenu + "Default:0\" \"set " + "skipto_jump" + " " + "_default" + "\" \n" );
    
    foreach ( struct in level.skipto_settings )
    {
        name = struct.name + ":" + index;
        index++;
        adddebugcommand( jumpmenu + name + "\" \"set " + "skipto_jump" + " " + struct.name + "\" \n" );
    }
    
    adddebugcommand( jumpmenu + "No Game:" + index + "\" \"set " + "skipto_jump" + " " + "no_game" + "\" \n" );
    
    for ( ;; )
    {
        jumpto = getdvarstring( "skipto_jump" );
        
        if ( isdefined( jumpto ) && jumpto.size )
        {
            music::setmusicstate( "death" );
            map_restart();
            return;
        }
        
        complete = getdvarstring( "skipto_complete" );
        
        if ( isdefined( complete ) && complete.size )
        {
            setdvar( "skipto_complete", "" );
            level objective_completed( complete, getplayers()[ 0 ] );
        }
        
        wait 0.05;
    }
}

/#

    // Namespace skipto
    // Params 0
    // Checksum 0xa6dd03b9, Offset: 0x4120
    // Size: 0x160, Type: dev
    function menu()
    {
        level flag::wait_till( "<dev string:x265>" );
        player = getplayers()[ 0 ];
        
        while ( isdefined( player ) && player buttonpressed( "<dev string:x279>" ) )
        {
            wait 0.05;
        }
        
        level thread watch_key_combo();
        
        for ( ;; )
        {
            if ( isdefined( getdvarint( "<dev string:x282>" ) ) && getdvarint( "<dev string:x282>" ) )
            {
                setdvar( "<dev string:x282>", 0 );
                getplayers()[ 0 ] allowjump( 0 );
                display();
                getplayers()[ 0 ] allowjump( 1 );
            }
            
            wait 0.05;
        }
    }

#/

// Namespace skipto
// Params 0
// Checksum 0xdf90c5c, Offset: 0x4288
// Size: 0xbe, Type: bool
function key_combo_pressed()
{
    player = getplayers()[ 0 ];
    
    if ( isdefined( player ) && player buttonpressed( "BUTTON_X" ) && player buttonpressed( "DPAD_RIGHT" ) && player buttonpressed( "BUTTON_LSHLDR" ) && player buttonpressed( "BUTTON_RSHLDR" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace skipto
// Params 0
// Checksum 0x7f65fe6b, Offset: 0x4350
// Size: 0x68
function watch_key_combo()
{
    for ( ;; )
    {
        while ( !key_combo_pressed() )
        {
            wait 0.05;
        }
        
        setdvar( "debug_skipto", 1 );
        
        while ( key_combo_pressed() )
        {
            wait 0.05;
        }
    }
}

// Namespace skipto
// Params 1
// Checksum 0x426a6b09, Offset: 0x43c0
// Size: 0x152
function change_completion_menu( objectives )
{
    rootclear = "devgui_remove \"Map/Skipto/Complete\" \n";
    adddebugcommand( rootclear );
    rootmenu = "devgui_cmd \"Map/Skipto/";
    compmenu = rootmenu + "Complete/";
    index = 1;
    
    foreach ( objective in objectives )
    {
        name = objective + ":" + index;
        index++;
        adddebugcommand( compmenu + name + "\" \"set " + "skipto_complete" + " " + objective + "\" \n" );
    }
}

// Namespace skipto
// Params 0
// Checksum 0x993781fd, Offset: 0x4520
// Size: 0xc8
function get_names()
{
    index = 0;
    names = [];
    
    foreach ( struct in level.skipto_settings )
    {
        name = struct.name;
        names[ index ] = name;
        index++;
    }
    
    return names;
}

// Namespace skipto
// Params 0
// Checksum 0xaf9cb378, Offset: 0x45f0
// Size: 0x634
function display()
{
    if ( level.skipto_settings.size <= 0 )
    {
        return;
    }
    
    names = get_names();
    elems = list_menu();
    title = create( "Selected skipto:", -1 );
    title.color = ( 1, 1, 1 );
    strings = [];
    
    for ( i = 0; i < names.size ; i++ )
    {
        s_name = names[ i ];
        skipto_string = "[" + names[ i ] + "]";
        strings[ strings.size ] = skipto_string;
    }
    
    selected = names.size - 1;
    up_pressed = 0;
    down_pressed = 0;
    found_current_skipto = 0;
    
    while ( selected > 0 )
    {
        if ( names[ selected ] == level.skipto_point )
        {
            found_current_skipto = 1;
            break;
        }
        
        selected--;
    }
    
    if ( !found_current_skipto )
    {
        selected = names.size - 1;
    }
    
    list_settext( elems, strings, selected );
    old_selected = selected;
    
    for ( ;; )
    {
        if ( old_selected != selected )
        {
            list_settext( elems, strings, selected );
            old_selected = selected;
        }
        
        if ( !up_pressed )
        {
            if ( getplayers()[ 0 ] buttonpressed( "UPARROW" ) || getplayers()[ 0 ] buttonpressed( "DPAD_UP" ) || getplayers()[ 0 ] buttonpressed( "APAD_UP" ) )
            {
                up_pressed = 1;
                selected--;
            }
        }
        else if ( !getplayers()[ 0 ] buttonpressed( "UPARROW" ) && !getplayers()[ 0 ] buttonpressed( "DPAD_UP" ) && !getplayers()[ 0 ] buttonpressed( "APAD_UP" ) )
        {
            up_pressed = 0;
        }
        
        if ( !down_pressed )
        {
            if ( getplayers()[ 0 ] buttonpressed( "DOWNARROW" ) || getplayers()[ 0 ] buttonpressed( "DPAD_DOWN" ) || getplayers()[ 0 ] buttonpressed( "APAD_DOWN" ) )
            {
                down_pressed = 1;
                selected++;
            }
        }
        else if ( !getplayers()[ 0 ] buttonpressed( "DOWNARROW" ) && !getplayers()[ 0 ] buttonpressed( "DPAD_DOWN" ) && !getplayers()[ 0 ] buttonpressed( "APAD_DOWN" ) )
        {
            down_pressed = 0;
        }
        
        if ( selected < 0 )
        {
            selected = names.size - 1;
        }
        
        if ( selected >= names.size )
        {
            selected = 0;
        }
        
        if ( getplayers()[ 0 ] buttonpressed( "BUTTON_B" ) )
        {
            display_cleanup( elems, title );
            break;
        }
        
        if ( getplayers()[ 0 ] buttonpressed( "kp_enter" ) || getplayers()[ 0 ] buttonpressed( "BUTTON_A" ) || getplayers()[ 0 ] buttonpressed( "enter" ) )
        {
            if ( names[ selected ] == "cancel" )
            {
                display_cleanup( elems, title );
                break;
            }
            
            set_current_skipto( names[ selected ] );
            map_restart();
            return;
        }
        
        wait 0.05;
    }
}

// Namespace skipto
// Params 0
// Checksum 0x2d199890, Offset: 0x4c30
// Size: 0x78
function list_menu()
{
    hud_array = [];
    
    for ( i = 0; i < 8 ; i++ )
    {
        hud = create( "", i );
        hud_array[ hud_array.size ] = hud;
    }
    
    return hud_array;
}

// Namespace skipto
// Params 3
// Checksum 0x5a753745, Offset: 0x4cb0
// Size: 0xbe
function list_settext( hud_array, strings, num )
{
    for ( i = 0; i < hud_array.size ; i++ )
    {
        index = i + num - 4;
        
        if ( isdefined( strings[ index ] ) )
        {
            text = strings[ index ];
        }
        else
        {
            text = "";
        }
        
        hud_array[ i ] settext( text );
    }
}

// Namespace skipto
// Params 2
// Checksum 0x7e2eaceb, Offset: 0x4d78
// Size: 0x76
function display_cleanup( elems, title )
{
    title destroy();
    
    for ( i = 0; i < elems.size ; i++ )
    {
        elems[ i ] destroy();
    }
}

// Namespace skipto
// Params 0
// Checksum 0xc77b9c1c, Offset: 0x4df8
// Size: 0x96
function nogame()
{
    guys = getaiarray();
    guys = arraycombine( guys, getspawnerarray(), 1, 0 );
    
    for ( i = 0; i < guys.size ; i++ )
    {
        guys[ i ] delete();
    }
}

// Namespace skipto
// Params 0
// Checksum 0x7e14ffb2, Offset: 0x4e98
// Size: 0x13c
function dev_warning()
{
    if ( !is_current_dev() )
    {
        return;
    }
    
    hudelem = newhudelem();
    hudelem.alignx = "left";
    hudelem.aligny = "top";
    hudelem.x = 0;
    hudelem.y = 70;
    hudelem settext( "This skipto is for development purposes only!  The level may not progress from this point." );
    hudelem.alpha = 1;
    hudelem.fontscale = 1.8;
    hudelem.color = ( 1, 0.55, 0 );
    wait 7;
    hudelem fadeovertime( 1 );
    hudelem.alpha = 0;
    wait 1;
    hudelem destroy();
}

// Namespace skipto
// Params 1
// Checksum 0x3cf53c0d, Offset: 0x4fe0
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
// Checksum 0x5e4f9d2c, Offset: 0x5048
// Size: 0x1a, Type: bool
function is_current_dev()
{
    return is_dev( level.skipto_point );
}

// Namespace skipto
// Params 0
// Checksum 0xfc91aad1, Offset: 0x5070
// Size: 0x32
function is_no_game()
{
    if ( !isdefined( level.skipto_point ) )
    {
        return 0;
    }
    
    return issubstr( level.skipto_point, "no_game" );
}

// Namespace skipto
// Params 0
// Checksum 0x90f8584e, Offset: 0x50b0
// Size: 0xa0
function do_no_game()
{
    if ( !is_no_game() )
    {
        return;
    }
    
    level.stop_load = 1;
    
    if ( isdefined( level.custom_no_game_setupfunc ) )
    {
        level [[ level.custom_no_game_setupfunc ]]();
    }
    
    level thread load::all_players_spawned();
    array::thread_all( getentarray( "water", "targetname" ), &load::water_think );
    level waittill( #"eternity" );
}

// Namespace skipto
// Params 1
// Checksum 0xf1480212, Offset: 0x5158
// Size: 0x18
function set_cleanup_func( func )
{
    level.func_skipto_cleanup = func;
}

// Namespace skipto
// Params 1
// Checksum 0xe0ec05b8, Offset: 0x5178
// Size: 0x18
function default_skipto( skipto )
{
    level.default_skipto = skipto;
}

// Namespace skipto
// Params 3
// Checksum 0x8056e64e, Offset: 0x5198
// Size: 0x4c
function teleport( skipto_name, friendly_ai, coop_sort )
{
    teleport_ai( skipto_name, friendly_ai );
    teleport_players( skipto_name, coop_sort );
}

// Namespace skipto
// Params 2
// Checksum 0x7c0d512d, Offset: 0x51f0
// Size: 0x2da
function teleport_ai( skipto_name, friendly_ai )
{
    if ( !isdefined( friendly_ai ) )
    {
        if ( isdefined( level.heroes ) )
        {
            friendly_ai = level.heroes;
        }
        else
        {
            friendly_ai = getaiteamarray( "allies" );
        }
    }
    
    if ( isstring( friendly_ai ) )
    {
        friendly_ai = getaiarray( friendly_ai, "script_noteworthy" );
    }
    
    if ( !isarray( friendly_ai ) )
    {
        friendly_ai = array( friendly_ai );
    }
    
    friendly_ai = array::remove_dead( friendly_ai );
    a_skipto_structs = arraycopy( struct::get_array( skipto_name + "_ai", "targetname" ) );
    assert( a_skipto_structs.size >= friendly_ai.size, "<dev string:x28f>" + skipto_name + "<dev string:x2b5>" + friendly_ai.size + "<dev string:x2cb>" + a_skipto_structs.size + "<dev string:x2d8>" );
    
    if ( !a_skipto_structs.size )
    {
        return;
    }
    
    foreach ( ai in friendly_ai )
    {
        if ( isdefined( ai ) )
        {
            start_i = 0;
            
            if ( isdefined( ai.script_int ) )
            {
                for ( j = 0; j < a_skipto_structs.size ; j++ )
                {
                    if ( isdefined( a_skipto_structs[ j ].script_int ) )
                    {
                        if ( a_skipto_structs[ j ].script_int == ai.script_int )
                        {
                            start_i = j;
                            break;
                        }
                    }
                }
            }
            
            ai teleport_single_ai( a_skipto_structs[ start_i ] );
            arrayremovevalue( a_skipto_structs, a_skipto_structs[ start_i ] );
        }
    }
}

// Namespace skipto
// Params 1
// Checksum 0xef432080, Offset: 0x54d8
// Size: 0x104
function teleport_single_ai( ai_skipto_spot )
{
    if ( isdefined( ai_skipto_spot.angles ) )
    {
        self forceteleport( ai_skipto_spot.origin, ai_skipto_spot.angles );
    }
    else
    {
        self forceteleport( ai_skipto_spot.origin );
    }
    
    if ( isdefined( ai_skipto_spot.target ) )
    {
        node = getnode( ai_skipto_spot.target, "targetname" );
        
        if ( isdefined( node ) )
        {
            self setgoal( node );
            return;
        }
    }
    
    self setgoal( ai_skipto_spot.origin );
}

// Namespace skipto
// Params 2
// Checksum 0x688c44ed, Offset: 0x55e8
// Size: 0x186
function teleport_players( skipto_name, coop_sort )
{
    level flag::wait_till( "all_players_spawned" );
    skipto_spots = get_spots( skipto_name, coop_sort );
    assert( skipto_spots.size >= level.players.size, "<dev string:x2e1>" );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        var_ac126ac5 = skipto_spots[ i ].origin;
        var_ac126ac5 = level.players[ i ] player::get_snapped_spot_origin( var_ac126ac5 );
        level.players[ i ] setorigin( var_ac126ac5 );
        
        if ( isdefined( skipto_spots[ i ].angles ) )
        {
            level.players[ i ] util::delay_network_frames( 2, "disconnect", &setplayerangles, skipto_spots[ i ].angles );
        }
    }
}

// Namespace skipto
// Params 2
// Checksum 0x1f19ce7d, Offset: 0x5778
// Size: 0x206
function get_spots( skipto_name, coop_sort )
{
    if ( !isdefined( coop_sort ) )
    {
        coop_sort = 0;
    }
    
    skipto_spots = struct::get_array( skipto_name, "targetname" );
    
    if ( !skipto_spots.size )
    {
        skipto_spots = spawnlogic::get_spawnpoint_array( "cp_coop_spawn", 1 );
        skipto_spots = filter_player_spawnpoints( undefined, skipto_spots, skipto_name );
    }
    
    if ( coop_sort )
    {
        for ( i = 0; i < skipto_spots.size ; i++ )
        {
            for ( j = i; j < skipto_spots.size ; j++ )
            {
                assert( isdefined( skipto_spots[ j ].script_int ), "<dev string:x309>" + skipto_spots[ j ].origin + "<dev string:x323>" );
                assert( isdefined( skipto_spots[ i ].script_int ), "<dev string:x309>" + skipto_spots[ i ].origin + "<dev string:x323>" );
                
                if ( skipto_spots[ j ].script_int < skipto_spots[ i ].script_int )
                {
                    temp = skipto_spots[ i ];
                    skipto_spots[ i ] = skipto_spots[ j ];
                    skipto_spots[ j ] = temp;
                }
            }
        }
    }
    
    return skipto_spots;
}

// Namespace skipto
// Params 3
// Checksum 0x4927b4c7, Offset: 0x5988
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
// Checksum 0xba87a2f0, Offset: 0x5a98
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
// Checksum 0x99ec1590, Offset: 0x5c18
// Size: 0x4
function load_mission_init()
{
    
}

// Namespace skipto
// Params 0
// Checksum 0x25941dca, Offset: 0x5c28
// Size: 0x24
function on_finalize_initialization()
{
    level flag::set( "start_skiptos" );
}

// Namespace skipto
// Params 0
// Checksum 0xadde746e, Offset: 0x5c58
// Size: 0x54
function on_player_spawn()
{
    if ( getdvarint( "ui_blocksaves" ) == 0 && isdefined( self savegame::get_player_data( "savegame_score" ) ) )
    {
        return;
    }
    
    globallogic_player::function_a5ac6877();
}

// Namespace skipto
// Params 0
// Checksum 0xf87eb6e1, Offset: 0x5cb8
// Size: 0x36
function function_f2b024f8()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self function_a5a105e8();
        wait 5;
    }
}

// Namespace skipto
// Params 4
// Checksum 0xa63a30c3, Offset: 0x5cf8
// Size: 0xa4
function function_bc7b05ac( var_87fe1234, var_a3b4af10, var_eece3936, var_5db7ef95 )
{
    var_a88ef0ad = 0;
    var_17986f3e = 0;
    
    if ( isdefined( var_5db7ef95 ) )
    {
        var_17986f3e = var_5db7ef95;
    }
    
    if ( isdefined( var_eece3936 ) )
    {
        var_a88ef0ad = var_eece3936;
    }
    
    var_96f7be40 = var_17986f3e - var_a88ef0ad;
    self matchrecordsetcheckpointstat( var_a3b4af10, var_87fe1234, var_96f7be40 );
}

// Namespace skipto
// Params 2
// Checksum 0xa0acae66, Offset: 0x5da8
// Size: 0x744
function function_84008d8d( objectivename, player )
{
    objectiveindex = level.skipto_settings[ objectivename ].code_index;
    player function_bc7b05ac( "kills_total", objectiveindex, player.var_dc615b.kills, player.kills );
    totalshots = player getdstat( "PlayerStatsList", "TOTAL_SHOTS", "statValue" );
    totalhits = player getdstat( "PlayerStatsList", "HITS", "statValue" );
    
    if ( isdefined( totalshots ) )
    {
        player function_bc7b05ac( "shots_total", objectiveindex, player.var_dc615b.shots, totalshots );
    }
    
    if ( isdefined( totalhits ) )
    {
        player function_bc7b05ac( "hits_total", objectiveindex, player.var_dc615b.hits, totalhits );
    }
    
    player function_bc7b05ac( "incaps_total", objectiveindex, player.var_dc615b.incaps, player.incaps );
    player function_bc7b05ac( "deaths_total", objectiveindex, player.var_dc615b.deaths, player.deaths );
    player function_bc7b05ac( "revives_total", objectiveindex, player.var_dc615b.revives, player.revives );
    player function_bc7b05ac( "headshots_total", objectiveindex, player.var_dc615b.headshots, player.headshots );
    player function_bc7b05ac( "duration_total", objectiveindex, player.var_dc615b.timestamp, gettime() );
    player function_bc7b05ac( "score_total", objectiveindex, player.var_dc615b.score, player.score );
    player function_bc7b05ac( "grenades_total", objectiveindex, player.var_dc615b.grenadesused, player.grenadesused );
    player function_bc7b05ac( "igcSeconds", objectiveindex, player.var_dc615b.var_7479d3c, player.totaligcviewtime );
    player function_bc7b05ac( "secondsPaused", objectiveindex, player.var_dc615b.var_adac7b4d, int( gettotalserverpausetime() / 1000 ) );
    var_b1f1efe7 = 0;
    var_394190fb = 0;
    var_d88606f6 = 0;
    wallruncount = 0;
    var_4dbe4ef9 = 0;
    
    if ( isdefined( player.movementtracking ) )
    {
        if ( isdefined( player.movementtracking.wallrunning ) )
        {
            var_394190fb = player.movementtracking.wallrunning.distance;
            wallruncount = player.movementtracking.wallrunning.count;
        }
        
        if ( isdefined( player.movementtracking.sprinting ) )
        {
            var_b1f1efe7 = player.movementtracking.sprinting.distance;
        }
        
        if ( isdefined( player.movementtracking.doublejump ) )
        {
            var_d88606f6 = player.movementtracking.doublejump.distance;
            var_4dbe4ef9 = player.movementtracking.doublejump.count;
        }
    }
    
    player function_bc7b05ac( "distance_wallrun", objectiveindex, player.var_dc615b.distance_wallrun, int( var_394190fb ) );
    player function_bc7b05ac( "distance_sprinted", objectiveindex, player.var_dc615b.distance_sprinted, int( var_b1f1efe7 ) );
    player function_bc7b05ac( "distance_boosted", objectiveindex, player.var_dc615b.distance_boosted, int( var_d88606f6 ) );
    player function_bc7b05ac( "wallruns_total", objectiveindex, player.var_dc615b.wallruns_total, int( wallruncount ) );
    player function_bc7b05ac( "boosts_total", objectiveindex, player.var_dc615b.boosts_total, int( var_4dbe4ef9 ) );
    player matchrecordsetcheckpointstat( objectiveindex, "start_difficulty", player.var_dc615b.difficulty );
    player matchrecordsetcheckpointstat( objectiveindex, "end_difficulty", level.gameskill );
    
    if ( isdefined( level.sceneskippedcount ) )
    {
        player matchrecordsetcheckpointstat( objectiveindex, "igcSkippedNum", level.sceneskippedcount );
    }
}

// Namespace skipto
// Params 1
// Checksum 0x2cf64545, Offset: 0x64f8
// Size: 0x4d8
function function_723221dd( player )
{
    if ( !isdefined( player.var_dc615b ) )
    {
        player.var_dc615b = spawnstruct();
    }
    
    player.var_dc615b.kills = player.kills;
    shots = player getdstat( "PlayerStatsList", "TOTAL_SHOTS", "statValue" );
    player.var_dc615b.shots = isdefined( shots ) ? shots : 0;
    hits = player getdstat( "PlayerStatsList", "HITS", "statValue" );
    player.var_dc615b.hits = isdefined( hits ) ? hits : 0;
    player.var_dc615b.incaps = player.incaps;
    player.var_dc615b.deaths = player.deaths;
    player.var_dc615b.revives = player.revives;
    player.var_dc615b.headshots = player.headshots;
    player.var_dc615b.timestamp = gettime();
    player.var_dc615b.score = player.score;
    player.var_dc615b.grenadesused = player.grenadesused;
    player.var_dc615b.var_7479d3c = player.totaligcviewtime;
    player.var_dc615b.var_adac7b4d = int( gettotalserverpausetime() / 1000 );
    player.var_dc615b.difficulty = level.gameskill;
    var_b1f1efe7 = 0;
    var_394190fb = 0;
    var_d88606f6 = 0;
    wallruncount = 0;
    var_4dbe4ef9 = 0;
    
    if ( isdefined( player.movementtracking ) )
    {
        if ( isdefined( player.movementtracking.wallrunning ) )
        {
            var_394190fb = player.movementtracking.wallrunning.distance;
            wallruncount = player.movementtracking.wallrunning.count;
        }
        
        if ( isdefined( player.movementtracking.sprinting ) )
        {
            var_b1f1efe7 = player.movementtracking.sprinting.distance;
        }
        
        if ( isdefined( player.movementtracking.doublejump ) )
        {
            var_d88606f6 = player.movementtracking.doublejump.distance;
            var_4dbe4ef9 = player.movementtracking.doublejump.count;
        }
    }
    
    player.var_dc615b.distance_wallrun = int( var_394190fb );
    player.var_dc615b.distance_sprinted = int( var_b1f1efe7 );
    player.var_dc615b.distance_boosted = int( var_d88606f6 );
    player.var_dc615b.wallruns_total = int( wallruncount );
    player.var_dc615b.boosts_total = int( var_4dbe4ef9 );
}

// Namespace skipto
// Params 0
// Checksum 0xe77c4dbf, Offset: 0x69d8
// Size: 0x58c
function on_player_connect()
{
    if ( util::is_safehouse() )
    {
        return;
    }
    
    if ( isdefined( level.deadops ) && level.deadops )
    {
        return;
    }
    
    if ( !isdefined( getrootmapname() ) )
    {
        return;
    }
    
    self thread function_f2b024f8();
    
    if ( getdvarint( "ui_blocksaves" ) == 0 )
    {
        if ( self ishost() )
        {
            scoreboard_migrated = 1;
            
            if ( sessionmodeisonlinegame() )
            {
                scoreboard_migrated = isdefined( self getdstat( "scoreboard_migrated" ) ) && self getdstat( "scoreboard_migrated" );
            }
            else
            {
                scoreboard_migrated = isdefined( self getdstat( "reserveBools", 0 ) ) && self getdstat( "reserveBools", 0 );
            }
            
            if ( !scoreboard_migrated )
            {
                self savegame::set_player_data( "savegame_score", self function_df7ef426( "SCORE" ) );
                self savegame::set_player_data( "savegame_kills", self function_df7ef426( "KILLS" ) );
                self savegame::set_player_data( "savegame_assists", self function_df7ef426( "ASSISTS" ) );
                self savegame::set_player_data( "savegame_incaps", self function_df7ef426( "INCAPS" ) );
                self savegame::set_player_data( "savegame_revives", self function_df7ef426( "REVIVES" ) );
                
                if ( sessionmodeisonlinegame() )
                {
                    self setdstat( "scoreboard_migrated", 1 );
                }
                else
                {
                    self setdstat( "reserveBools", 0, 1 );
                }
                
                uploadstats( self );
            }
            
            if ( !isdefined( self savegame::get_player_data( "savegame_score" ) ) )
            {
                self savegame::set_player_data( "savegame_score", 0 );
            }
            
            if ( !isdefined( self savegame::get_player_data( "savegame_kills" ) ) )
            {
                self savegame::set_player_data( "savegame_kills", 0 );
            }
            
            if ( !isdefined( self savegame::get_player_data( "savegame_assists" ) ) )
            {
                self savegame::set_player_data( "savegame_assists", 0 );
            }
            
            if ( !isdefined( self savegame::get_player_data( "savegame_incaps" ) ) )
            {
                self savegame::set_player_data( "savegame_incaps", 0 );
            }
            
            if ( !isdefined( self savegame::get_player_data( "savegame_revives" ) ) )
            {
                self savegame::set_player_data( "savegame_revives", 0 );
            }
            
            self.pers[ "score" ] = self savegame::get_player_data( "savegame_score", 0 );
            self.pers[ "kills" ] = self savegame::get_player_data( "savegame_kills", 0 );
            self.pers[ "assists" ] = self savegame::get_player_data( "savegame_assists", 0 );
            self.pers[ "incaps" ] = self savegame::get_player_data( "savegame_incaps", 0 );
            self.pers[ "revives" ] = self savegame::get_player_data( "savegame_revives", 0 );
            self.score = self.pers[ "score" ];
            self.kills = self.pers[ "kills" ];
            self.assists = self.pers[ "assists" ];
            self.incaps = self.pers[ "incaps" ];
            self.revives = self.pers[ "revives" ];
        }
    }
    
    function_723221dd( self );
}

// Namespace skipto
// Params 2
// Checksum 0x6c067933, Offset: 0x6f70
// Size: 0x29c
function objective_completed( name, player )
{
    assert( isdefined( level.skipto_settings[ name ] ), "<dev string:x351>" + name + "<dev string:x362>" );
    setdvar( "NPCDeathTracking_Save", 1 );
    
    foreach ( statplayer in level.players )
    {
        if ( statplayer istestclient() )
        {
            continue;
        }
        
        bb::logobjectivestatuschange( name, statplayer, "complete" );
        statplayer globallogic_player::function_ece4ca01();
    }
    
    if ( isdefined( name ) )
    {
        if ( isdefined( player ) )
        {
            function_84008d8d( name, player );
        }
        else
        {
            foreach ( var_63af5576 in level.players )
            {
                function_84008d8d( name, var_63af5576 );
            }
        }
        
        level stop_objective_logic( name, 0, 1, player );
    }
    
    next = get_next_skiptos( name );
    next = check_skipto_conditions( next );
    
    if ( isdefined( next ) && next.size > 0 )
    {
        level set_level_objective( next, 0, player );
        level thread savegame::save();
    }
}

// Namespace skipto
// Params 0, eflags: 0x4
// Checksum 0xa525a40f, Offset: 0x7218
// Size: 0xa2
function private function_52904bc9()
{
    foreach ( trig in trigger::get_all() )
    {
        if ( isdefined( trig.scriptgroup_playerspawns_regroup ) )
        {
            trig thread function_87fe8621();
        }
    }
}

// Namespace skipto
// Params 0, eflags: 0x4
// Checksum 0xfc459ad6, Offset: 0x72c8
// Size: 0x272
function private function_87fe8621()
{
    self endon( #"death" );
    level flag::wait_till( "all_players_spawned" );
    var_717810f = function_659bb22b( self.scriptgroup_playerspawns_regroup );
    assert( var_717810f.size >= 3, "<dev string:x38b>" );
    
    while ( true )
    {
        self waittill( #"trigger", lead_player );
        
        if ( isplayer( lead_player ) )
        {
            self notify( #"hash_c0b9931e" );
            
            foreach ( player in level.players )
            {
                if ( player != lead_player )
                {
                    if ( player.sessionstate === "playing" )
                    {
                        n_dist = isdefined( self.script_regroup_distance ) ? self.script_regroup_distance * self.script_regroup_distance : 2250000;
                        n_player_dist = distancesquared( player.origin, lead_player.origin );
                        
                        if ( n_player_dist > n_dist )
                        {
                            if ( !player istouching( self ) )
                            {
                                player thread function_61843b91( var_717810f, n_player_dist );
                            }
                        }
                        
                        continue;
                    }
                    
                    if ( isdefined( player.initialloadoutgiven ) && player.sessionstate === "spectator" && player.initialloadoutgiven )
                    {
                        player thread function_61843b91( var_717810f );
                    }
                }
            }
            
            break;
        }
    }
}

// Namespace skipto
// Params 1
// Checksum 0x3e12e959, Offset: 0x7548
// Size: 0x124
function function_659bb22b( str_num )
{
    a_ret = [];
    var_717810f = spawnlogic::get_all_spawn_points( 1 );
    
    foreach ( loc in var_717810f )
    {
        if ( loc.scriptgroup_playerspawns_regroup === str_num )
        {
            if ( !isdefined( a_ret ) )
            {
                a_ret = [];
            }
            else if ( !isarray( a_ret ) )
            {
                a_ret = array( a_ret );
            }
            
            a_ret[ a_ret.size ] = loc;
        }
    }
    
    return a_ret;
}

// Namespace skipto
// Params 2, eflags: 0x4
// Checksum 0xaf9f131a, Offset: 0x7678
// Size: 0x3d2
function private function_61843b91( var_717810f, n_player_dist )
{
    self endon( #"death" );
    
    if ( self isinvehicle() )
    {
        vh_occupied = self getvehicleoccupied();
        n_seat = vh_occupied getoccupantseat( self );
        vh_occupied usevehicle( self, n_seat );
        
        if ( isdefined( self.hijacked_vehicle_entity ) )
        {
            self waittill( #"transition_done" );
        }
    }
    
    if ( isdefined( self.hijacked_vehicle_entity ) )
    {
        self.hijacked_vehicle_entity delete();
    }
    
    if ( self.sessionstate === "spectator" )
    {
        self thread [[ level.spawnplayer ]]();
        waittillframeend();
    }
    else if ( self laststand::player_is_in_laststand() )
    {
        self notify( #"auto_revive" );
    }
    
    if ( self isplayinganimscripted() )
    {
        self stopanimscripted();
    }
    
    if ( isdefined( self getlinkedent() ) )
    {
        self unlink();
        wait 0.1;
    }
    
    foreach ( loc in var_717810f )
    {
        if ( !( isdefined( loc.b_used ) && loc.b_used ) )
        {
            loc.b_used = 1;
            self.b_teleport_invulnerability = 1;
            self freezecontrols( 1 );
            self playsoundtoplayer( "evt_coop_regroup_out", self );
            
            if ( isdefined( n_player_dist ) && n_player_dist < 250000 )
            {
                clientfield::increment_to_player( "postfx_igc", 3 );
            }
            else
            {
                clientfield::increment_to_player( "postfx_igc", 1 );
            }
            
            wait 0.5;
            self setorigin( loc.origin );
            
            if ( isdefined( loc.angles ) )
            {
                util::delay_network_frames( 2, "disconnect", &setplayerangles, loc.angles );
            }
            
            self playsoundtoplayer( "evt_coop_regroup_in", self );
            break;
        }
    }
    
    wait 2;
    self freezecontrols( 0 );
    wait 0.05;
    
    if ( isdefined( level.var_1895e0f9 ) )
    {
        self [[ level.var_1895e0f9 ]]();
    }
    
    self util::streamer_wait( undefined, 0, 5 );
    wait 5;
    self.b_teleport_invulnerability = undefined;
}

/#

    // Namespace skipto
    // Params 1
    // Checksum 0x4c8f1864, Offset: 0x7a58
    // Size: 0x12c, Type: dev
    function show_level_objectives( objectives )
    {
        setdvar( "<dev string:x3b6>", 1 );
        index = 0;
        
        foreach ( name in objectives )
        {
            skipto_struct = level.skipto_settings[ name ];
            
            if ( isdefined( skipto_struct.str_name ) && skipto_struct.str_name.size )
            {
                thread indicate( skipto_struct.str_name, index );
                index++;
            }
        }
        
        setdvar( "<dev string:x3b6>", 0 );
    }

#/

// Namespace skipto
// Params 3
// Checksum 0x9c3965c4, Offset: 0x7b90
// Size: 0x2fc
function set_level_objective( objectives, starting, player )
{
    clear_recursion();
    
    foreach ( name in objectives )
    {
        if ( isdefined( level.skipto_settings[ name ] ) )
        {
            stop_objective_logic( level.skipto_settings[ name ].prev, starting, 0, player );
        }
    }
    
    if ( isdefined( level.func_skipto_cleanup ) )
    {
        foreach ( name in objectives )
        {
            thread [[ level.func_skipto_cleanup ]]( name );
        }
    }
    
    /#
        thread show_level_objectives( objectives );
    #/
    
    start_objective_logic( objectives, starting );
    level.skipto_point = level.skipto_current_objective[ 0 ];
    
    if ( !( isdefined( level.level_ending ) && level.level_ending ) )
    {
        set_current_skiptos( level.skipto_current_objective );
    }
    
    level notify( #"objective_changed", level.skipto_current_objective );
    
    if ( isdefined( level.var_26b4fb80 ) )
    {
        [[ level.var_26b4fb80 ]]( level.skipto_current_objective );
    }
    
    change_completion_menu( level.skipto_current_objective );
    
    if ( isdefined( player ) )
    {
        function_723221dd( player );
    }
    else
    {
        foreach ( var_63af5576 in level.players )
        {
            function_723221dd( var_63af5576 );
        }
    }
    
    level thread update_spawn_points( starting );
}

// Namespace skipto
// Params 1
// Checksum 0x6bbe60d6, Offset: 0x7e98
// Size: 0xac
function update_spawn_points( starting )
{
    level notify( #"update_spawn_points" );
    level endon( #"update_spawn_points" );
    level endon( #"objective_changed" );
    level flag::wait_till( "first_player_spawned" );
    spawnlogic::clear_spawn_points();
    spawnlogic::add_spawn_points( "allies", "cp_coop_spawn" );
    spawnlogic::add_spawn_points( "allies", "cp_coop_respawn" );
    spawning::updateallspawnpoints();
}

// Namespace skipto
// Params 2
// Checksum 0x4b808a76, Offset: 0x7f50
// Size: 0x392
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
            
            if ( !getdvarint( "art_review", 0 ) )
            {
                standard_objective_init( name, starting );
                
                if ( isdefined( level.skipto_settings[ name ].skipto_func ) )
                {
                    thread [[ level.skipto_settings[ name ].skipto_func ]]( name, starting );
                    savegame::checkpoint_save( level.skipto_settings[ name ].var_2bc8bbd9 );
                }
            }
        }
        
        if ( !( isdefined( level.skipto_settings[ name ].logic_running ) && level.skipto_settings[ name ].logic_running ) && isdefined( level.skipto_settings[ name ].logic_func ) )
        {
            level.skipto_settings[ name ].logic_running = 1;
            thread [[ level.skipto_settings[ name ].logic_func ]]( name );
        }
    }
    
    foreach ( player in level.players )
    {
        bb::logobjectivestatuschange( name, player, "start" );
    }
}

// Namespace skipto
// Params 0
// Checksum 0x2700a7fc, Offset: 0x82f0
// Size: 0x86
function clear_recursion()
{
    foreach ( skipto in level.skipto_settings )
    {
        skipto.cleanup_recursion = 0;
    }
}

// Namespace skipto
// Params 4
// Checksum 0xf07e784e, Offset: 0x8380
// Size: 0x404
function stop_objective_logic( name, starting, direct, player )
{
    if ( isarray( name ) )
    {
        foreach ( element in name )
        {
            stop_objective_logic( element, starting, direct, player );
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
            
            if ( !getdvarint( "art_review", 0 ) )
            {
                if ( isdefined( level.skipto_settings[ name ].cleanup_func ) )
                {
                    thread [[ level.skipto_settings[ name ].cleanup_func ]]( name, starting, direct, player );
                }
                
                standard_objective_done( name, starting, direct, player );
            }
            
            level notify( name + "_terminate" );
        }
        
        if ( !( isdefined( level.skipto_settings[ name ].cleanup_recursion ) && level.skipto_settings[ name ].cleanup_recursion ) )
        {
            level.skipto_settings[ name ].cleanup_recursion = 1;
            
            if ( !( isdefined( level.skipto_settings[ name ].looping ) && level.skipto_settings[ name ].looping ) )
            {
                prev = level.skipto_settings[ name ].prev;
                
                foreach ( element in prev )
                {
                    stop_objective_logic( element, starting, 0, player );
                }
            }
            
            if ( starting && !cleaned )
            {
                if ( !getdvarint( "art_review", 0 ) )
                {
                    if ( isdefined( level.skipto_settings[ name ].cleanup_func ) )
                    {
                        thread [[ level.skipto_settings[ name ].cleanup_func ]]( name, starting, 0, player );
                    }
                    
                    standard_objective_done( name, starting, 0, player );
                }
            }
        }
    }
}

// Namespace skipto
// Params 1
// Checksum 0xb6de3033, Offset: 0x8790
// Size: 0x22
function filter_spawnpoints( spawnpoints )
{
    return filter_player_spawnpoints( undefined, spawnpoints );
}

// Namespace skipto
// Params 3
// Checksum 0xd1c03e7b, Offset: 0x87c0
// Size: 0x424
function filter_player_spawnpoints( player, spawnpoints, str_skipto )
{
    objectives = isdefined( str_skipto ) ? str_skipto : level.skipto_current_objective;
    
    if ( !isdefined( objectives ) || !objectives.size )
    {
        objectives = get_current_skiptos();
        
        if ( !isdefined( objectives ) || !objectives.size )
        {
            objectives = level.default_skipto;
        }
    }
    
    filter = [];
    
    if ( !isdefined( objectives ) )
    {
        objectives = [];
    }
    else if ( !isarray( objectives ) )
    {
        objectives = array( objectives );
    }
    
    foreach ( objective in objectives )
    {
        if ( isdefined( level.skipto_settings[ objective ] ) )
        {
            if ( isdefined( level.skipto_settings[ objective ].dev_skipto ) && ( isdefined( level.skipto_settings[ objective ].public ) && level.skipto_settings[ objective ].public || level.skipto_settings[ objective ].dev_skipto ) )
            {
                if ( !isdefined( filter ) )
                {
                    filter = [];
                }
                else if ( !isarray( filter ) )
                {
                    filter = array( filter );
                }
                
                filter[ filter.size ] = objective;
            }
        }
    }
    
    if ( isdefined( filter ) && filter.size > 0 )
    {
        anypoints = [];
        retpoints = [];
        
        foreach ( point in spawnpoints )
        {
            point.different_skipto = 0;
            
            if ( isdefined( point.script_objective ) && isinarray( filter, point.script_objective ) )
            {
                if ( !isdefined( retpoints ) )
                {
                    retpoints = [];
                }
                else if ( !isarray( retpoints ) )
                {
                    retpoints = array( retpoints );
                }
                
                retpoints[ retpoints.size ] = point;
                continue;
            }
            
            if ( !isdefined( point.script_objective ) )
            {
                if ( !isdefined( anypoints ) )
                {
                    anypoints = [];
                }
                else if ( !isarray( anypoints ) )
                {
                    anypoints = array( anypoints );
                }
                
                anypoints[ anypoints.size ] = point;
                continue;
            }
            
            point.different_skipto = 1;
        }
        
        if ( retpoints.size > 0 )
        {
            return retpoints;
        }
        
        return anypoints;
    }
    
    return spawnpoints;
}

// Namespace skipto
// Params 1
// Checksum 0xba3a9eb1, Offset: 0x8bf0
// Size: 0x102
function delete_start_spawns( str_skipto )
{
    a_spawns = spawnlogic::get_spawnpoint_array( "cp_coop_spawn" );
    
    foreach ( spawn_point in a_spawns )
    {
        if ( spawn_point.script_objective == str_skipto )
        {
            if ( spawn_point.classname === "script_model" )
            {
                spawn_point delete();
                continue;
            }
            
            spawn_point struct::delete();
        }
    }
}

// Namespace skipto
// Params 0
// Checksum 0xf2db3205, Offset: 0x8d00
// Size: 0x84
function function_b0e512a3()
{
    level.var_696b1f33 = 1;
    str_next_map = function_c7f783fe();
    
    if ( should_skip_safehouse() )
    {
        switchmap_preload( str_next_map );
        return;
    }
    
    assert( 0, "<dev string:x3d2>" );
}

// Namespace skipto
// Params 0
// Checksum 0xbb640eec, Offset: 0x8d90
// Size: 0x62
function function_2711019f()
{
    while ( true )
    {
        var_14bd4dfe = getlobbyclientcount();
        
        if ( var_14bd4dfe <= level.var_897126b5 )
        {
            level flag::set( "all_players_closed_aar" );
            break;
        }
        
        wait 1;
    }
}

// Namespace skipto
// Params 0
// Checksum 0xdcf51043, Offset: 0x8e00
// Size: 0x29c
function function_f380969b()
{
    self endon( #"disconnect" );
    self endon( #"hash_33722592" );
    var_67bda5a5 = self getdstat( "currentRankXP" );
    currentRankXP = self rank::getrankxpstat();
    hasSeenMaxLevelNotification = self getdstat( "hasSeenMaxLevelNotification" );
    
    if ( hasSeenMaxLevelNotification != 1 && currentRankXP >= rank::getrankinfominxp( level.ranktable.size - 1 ) )
    {
        self.var_a4c14d95 = self openluimenu( "CPMaxLevelNotification" );
        self setdstat( "hasSeenMaxLevelNotification", 1 );
    }
    else
    {
        self.var_a4c14d95 = self openluimenu( "RewardsOverlayCP" );
    }
    
    self waittill( #"menuresponse", menu, response );
    
    while ( response != "closed" )
    {
        self waittill( #"menuresponse", menu, response );
    }
    
    foreach ( player in getplayers() )
    {
        if ( player == self )
        {
            continue;
        }
        
        player notify( #"hash_33722592" );
        player function_33722592();
    }
    
    self closeluimenu( self.var_a4c14d95 );
    self.var_a4c14d95 = undefined;
    next_map = function_c7f783fe();
    
    if ( isdefined( next_map ) )
    {
        self globallogic_player::function_4cef9872( next_map );
    }
    
    level.var_897126b5++;
}

// Namespace skipto
// Params 0
// Checksum 0xc6eb198b, Offset: 0x90a8
// Size: 0xda
function function_c7f783fe()
{
    str_next_map = getnextmap();
    
    if ( isdefined( str_next_map ) && sessionmodeiscampaignzombiesgame() )
    {
        tokens = strtok( str_next_map, "_" );
        var_a2a8516f = "cp";
        
        for ( i = 1; i < tokens.size - 1 ; i++ )
        {
            var_a2a8516f = var_a2a8516f + "_" + tokens[ i ];
        }
        
        str_next_map = var_a2a8516f;
    }
    
    return str_next_map;
}

// Namespace skipto
// Params 1
// Checksum 0x514f4d9, Offset: 0x9190
// Size: 0x10c
function function_ab286e9e( stat_name )
{
    var_8edaf582 = self function_df7ef426( stat_name );
    var_571a5472 = self savegame::get_player_data( "savegame_" + stat_name );
    var_aa6cf955 = self getdstat( "PlayerStatsByMap", getrootmapname(), "currentStats", stat_name );
    var_a74fbb99 = var_8edaf582 - var_571a5472;
    var_aa6cf955 += var_a74fbb99;
    self setdstat( "PlayerStatsByMap", getrootmapname(), "currentStats", stat_name, var_aa6cf955 );
}

// Namespace skipto
// Params 0
// Checksum 0x9ced6753, Offset: 0x92a8
// Size: 0xe4
function function_61688376()
{
    self endon( #"disconnect" );
    assert( isdefined( level.var_a7c3eb6f ) );
    assert( level flag::exists( "<dev string:x414>" ) );
    self function_a5a105e8();
    util::waittill_notify_or_timeout( "stats_changed", 2 );
    level.var_a7c3eb6f++;
    var_7fba07d2 = getlobbyclientcount();
    
    if ( var_7fba07d2 <= level.var_a7c3eb6f )
    {
        level flag::set( "all_players_set_aar_scoreboard" );
    }
}

// Namespace skipto
// Params 0
// Checksum 0x8f684282, Offset: 0x9398
// Size: 0x11c
function function_88bd85cc()
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    
    if ( isdefined( self.var_40ac72fa ) )
    {
        self closeluimenu( self.var_40ac72fa );
        self freezecontrols( 0 );
        
        if ( self ishost() )
        {
            if ( savegame::function_f6ab8f28() )
            {
                mapindex = getmaporder();
                self setdstat( "highestMapReached", mapindex + 1 );
            }
        }
    }
    
    level flag::set( "credits_done" );
}

// Namespace skipto
// Params 0
// Checksum 0x5c044b6b, Offset: 0x94c0
// Size: 0x108
function function_33722592()
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    
    if ( isdefined( self.var_a4c14d95 ) )
    {
        self closeluimenu( self.var_a4c14d95 );
        self luinotifyevent( &"close_cpaar", 0 );
        self thread lui::screen_fade_out( 0.1, "black" );
        next_map = function_c7f783fe();
        
        if ( isdefined( next_map ) )
        {
            self globallogic_player::function_4cef9872( next_map );
        }
        
        self.var_a4c14d95 = undefined;
        level.var_897126b5++;
    }
}

// Namespace skipto
// Params 2
// Checksum 0x6ca61f8b, Offset: 0x95d0
// Size: 0x196c
function level_completed( skipto, starting )
{
    /#
        level thread function_27c2dde4();
    #/
    
    if ( isdefined( level.level_ending ) && level.level_ending )
    {
        return;
    }
    
    level.level_ending = 1;
    
    foreach ( var_63af5576 in level.players )
    {
        bb::logobjectivestatuschange( "_level", var_63af5576, "complete" );
        bb::logmatchsummary( var_63af5576 );
    }
    
    matchrecordsetcurrentlevelcomplete();
    matchrecordsetleveldifficultyforindex( 1, level.gameskill );
    
    if ( level.var_6e1075a2 !== 0 )
    {
        level lui::screen_fade_out( 1 );
    }
    
    str_next_map = undefined;
    
    if ( is_final_level() )
    {
        level thread sndcreditsmusic();
        level flag::init( "credits_done" );
        
        foreach ( player in level.players )
        {
            player thread function_4aa085d7();
        }
        
        str_next_map = getmapatindex( 0 );
        level flag::wait_till( "credits_done" );
    }
    else
    {
        str_next_map = function_c7f783fe();
    }
    
    if ( isdefined( str_next_map ) )
    {
        /#
            if ( skipto == "<dev string:x433>" && starting )
            {
                wait 4;
            }
        #/
        
        world.next_map = str_next_map;
        
        if ( ( !isdefined( world.highest_map_reached ) || getmaporder( str_next_map ) > getmaporder( world.highest_map_reached ) ) && savegame::function_f6ab8f28() )
        {
            world.highest_map_reached = str_next_map;
            mapindex = getmaporder( str_next_map );
            
            foreach ( player in level.players )
            {
                if ( player ishost() )
                {
                    player setdstat( "highestMapReached", mapindex );
                    break;
                }
            }
        }
        
        world.last_map = level.script;
        level clientfield::increment( "set_last_map_dvar" );
        level accolades::commit( str_next_map );
        
        if ( should_skip_safehouse() || sessionmodeiscampaignzombiesgame() )
        {
            str_intro_movie = getmapintromovie( str_next_map );
            
            if ( isdefined( str_intro_movie ) )
            {
                switchmap_setloadingmovie( str_intro_movie );
            }
            
            if ( !( isdefined( level.var_696b1f33 ) && level.var_696b1f33 ) )
            {
                if ( sessionmodeiscampaignzombiesgame() )
                {
                    if ( !is_final_level() )
                    {
                        switchmap_load( str_next_map );
                    }
                }
                else
                {
                    switchmap_load( str_next_map );
                }
                
                setskiptos( "", 1 );
            }
        }
        else
        {
            str_outro_movie = getmapoutromovie();
            
            if ( isdefined( str_outro_movie ) )
            {
                switchmap_setloadingmovie( str_outro_movie );
            }
            
            if ( !( isdefined( level.var_696b1f33 ) && level.var_696b1f33 ) )
            {
                setdvar( "cp_queued_level", str_next_map );
                var_f26d4e96 = util::get_next_safehouse( str_next_map );
                switchmap_load( var_f26d4e96 );
                setskiptos( "", 1 );
            }
        }
    }
    
    util::wait_network_frame();
    set_current_skipto( "" );
    
    foreach ( player in getplayers() )
    {
        player player::take_weapons();
        player savegame::set_player_data( "saved_weapon", player._current_weapon.name );
        player savegame::set_player_data( "saved_weapondata", player._weapons );
        player savegame::set_player_data( "lives", player.lives );
        player._weapons = undefined;
        player.gun_removed = undefined;
    }
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        next_map = function_c7f783fe();
        
        if ( isdefined( next_map ) && function_cb7247d8( next_map ) )
        {
            foreach ( player in level.players )
            {
                player globallogic_player::function_4cef9872( next_map );
            }
        }
    }
    
    uploadstats();
    
    if ( !is_final_level() )
    {
        if ( getdvarint( "tu1_saveNextMapOnLevelComplete", 1 ) )
        {
            next_map = function_c7f783fe();
            
            if ( isdefined( next_map ) )
            {
                setskiptos( "", 1 );
                savegame_create( next_map );
            }
            else
            {
                savegame_create();
            }
        }
        else
        {
            savegame_create();
        }
    }
    
    if ( !isdefined( str_next_map ) || function_cb7247d8( str_next_map ) )
    {
        foreach ( e_player in level.players )
        {
            if ( getdvarint( "ui_blocksaves" ) == 0 && e_player ishost() && isdefined( e_player savegame::get_player_data( "savegame_score" ) ) )
            {
                e_player savegame::set_player_data( "savegame_score", e_player.pers[ "score" ] );
                e_player savegame::set_player_data( "savegame_kills", e_player.pers[ "kills" ] );
                e_player savegame::set_player_data( "savegame_assists", e_player.pers[ "assists" ] );
                e_player savegame::set_player_data( "savegame_incaps", e_player.pers[ "incaps" ] );
                e_player savegame::set_player_data( "savegame_revives", e_player.pers[ "revives" ] );
                e_player function_ab286e9e( "score" );
                e_player function_ab286e9e( "kills" );
                e_player function_ab286e9e( "assists" );
                e_player function_ab286e9e( "incaps" );
                e_player function_ab286e9e( "revives" );
                e_player savegame::set_player_data( "savegame_score", undefined );
                e_player savegame::set_player_data( "savegame_kills", undefined );
                e_player savegame::set_player_data( "savegame_assists", undefined );
                e_player savegame::set_player_data( "savegame_incaps", undefined );
                e_player savegame::set_player_data( "savegame_revives", undefined );
                e_player util::waittill_notify_or_timeout( "stats_changed", 2 );
            }
            
            if ( !isdefined( getrootmapname() ) )
            {
            }
            else
            {
                e_player savegame::set_player_data( "saved_weapon", undefined );
                e_player savegame::set_player_data( "saved_weapondata", undefined );
                e_player savegame::set_player_data( "lives", undefined );
                var_1e8a9261 = !e_player getdstat( "PlayerStatsByMap", getrootmapname(), "hasBeenCompleted" );
                
                if ( isdefined( var_1e8a9261 ) && var_1e8a9261 )
                {
                    e_player setdstat( "PlayerStatsByMap", getrootmapname(), "hasBeenCompleted", 1 );
                    
                    if ( sessionmodeisonlinegame() )
                    {
                        e_player setdstat( "PlayerStatsByMap", getrootmapname(), "firstTimeCompletedUTC", getutc() );
                    }
                    
                    e_player thread challenges::function_96ed590f( "career_tokens" );
                    e_player giveunlocktoken( 1 );
                }
                
                if ( e_player function_8295f89d( level.gameskilllowest ) )
                {
                    switch ( level.gameskilllowest )
                    {
                        case 0:
                            break;
                        case 1:
                            break;
                        case 2:
                            break;
                        case 3:
                            e_player givedecoration( "cp_medal_complete_on_veteran" );
                            break;
                        case 4:
                            e_player givedecoration( "cp_medal_complete_on_veteran" );
                            e_player givedecoration( "cp_medal_complete_on_realistic" );
                            break;
                    }
                }
            }
            
            e_player setdstat( "PlayerStatsByMap", getrootmapname(), "completedDifficulties", level.gameskilllowest, 1 );
            var_a4b6fa1f = e_player getdstat( "PlayerStatsByMap", getrootmapname(), "highestStats", "HIGHEST_DIFFICULTY" );
            
            if ( sessionmodeisonlinegame() )
            {
                e_player setdstat( "PlayerStatsByMap", getrootmapname(), "lastCompletedUTC", getutc() );
                timescompleted = e_player getdstat( "PlayerStatsByMap", getrootmapname(), "numCompletions" );
                
                if ( isdefined( timescompleted ) )
                {
                    e_player setdstat( "PlayerStatsByMap", getrootmapname(), "numCompletions", timescompleted + 1 );
                }
            }
            
            recordcomscoreevent( "defeat_level", "game_level", getrootmapname(), "game_difficulty_lowest", level.gameskilllowest, "game_difficulty_highest", level.gameskillhighest, "game_difficulty", level.gameskill, "player_count", level.players.size, "level_duration", gettime() - level.starttime );
            
            if ( level.gameskilllowest > var_a4b6fa1f )
            {
                e_player setdstat( "PlayerStatsByMap", getrootmapname(), "highestStats", "HIGHEST_DIFFICULTY", level.gameskilllowest );
            }
            
            e_player function_178f7e85( getrootmapname(), level.gameskilllowest );
            achievements::function_733a6065( e_player, getrootmapname(), level.gameskilllowest, sessionmodeiscampaignzombiesgame() );
            
            if ( level.gameskilllowest >= 2 )
            {
                e_player notify( #"hash_ee109657", level.savename );
                e_player addplayerstat( "mission_diff_" + getsubstr( getmissionname(), 0, 3 ), 1 );
            }
            
            e_player function_95093ed5();
            e_player savegame::set_player_data( "last_mission", "" );
            e_player clearallnoncheckpointdata();
            e_player setdstat( "PlayerStatsByMap", getrootmapname(), "lastCompletedDifficulty", level.gameskilllowest );
            
            if ( !e_player decorations::function_25328f50( "cp_medal_no_deaths" ) )
            {
                if ( level.gameskilllowest >= 3 && !( isdefined( world.var_bf966ebd ) && world.var_bf966ebd ) )
                {
                    e_player setdstat( "PlayerStatsByMap", getrootmapname(), "checkpointUsed", 0 );
                    
                    if ( e_player decorations::function_931263b1( 3 ) )
                    {
                        e_player givedecoration( "cp_medal_no_deaths" );
                    }
                }
                else if ( var_a4b6fa1f >= 3 && !( isdefined( e_player getdstat( "PlayerStatsByMap", getrootmapname(), "checkpointUsed" ) ) && e_player getdstat( "PlayerStatsByMap", getrootmapname(), "checkpointUsed" ) ) )
                {
                }
                else
                {
                    e_player setdstat( "PlayerStatsByMap", getrootmapname(), "checkpointUsed", 1 );
                }
            }
            
            if ( e_player decorations::function_bea4ff57() )
            {
                e_player givedecoration( "cp_medal_all_weapon_unlocks" );
            }
        }
    }
    
    level flag::init( "all_players_set_aar_scoreboard" );
    level.var_a7c3eb6f = 0;
    
    foreach ( player in getplayers() )
    {
        player thread function_61688376();
    }
    
    level flag::wait_till_timeout( 3, "all_players_set_aar_scoreboard" );
    function_54fdc879();
    world.var_bf966ebd = undefined;
    recordgameresult( "draw" );
    globallogic_player::recordactiveplayersendgamematchrecordstats();
    finalizematchrecord();
    
    if ( isdefined( str_next_map ) )
    {
        if ( isdefined( level.var_d086f08f ) && level.var_d086f08f && !sessionmodeiscampaignzombiesgame() )
        {
            level accolades::commit( str_next_map );
            
            foreach ( e_player in level.players )
            {
                e_player setdstat( "PlayerStatsByMap", getrootmapname(), "lastCompletedDifficulty", level.gameskilllowest );
                
                if ( e_player decorations::function_e72fc18() )
                {
                    e_player givedecoration( "cp_medal_all_accolades" );
                }
            }
            
            level flag::init( "all_players_closed_aar" );
            level.var_897126b5 = 0;
            level thread function_2711019f();
            
            for ( i = 0; i < level.players.size ; i++ )
            {
                level.players[ i ] thread function_f380969b();
            }
            
            callback::on_spawned( &function_3fbee503 );
            
            if ( !is_final_level() )
            {
                util::clientnotify( "aar" );
                music::setmusicstate( "aar" );
            }
            
            level flag::wait_till( "all_players_closed_aar" );
        }
        else if ( !sessionmodeiscampaignzombiesgame() )
        {
            if ( function_cb7247d8( str_next_map ) )
            {
                foreach ( player in getplayers() )
                {
                    player savegame::set_player_data( "show_aar", 1 );
                }
            }
            else
            {
                world.show_aar = undefined;
            }
        }
        
        if ( !is_final_level() )
        {
            switchmap_switch();
            uploadstats();
        }
        else
        {
            level notify( #"sndstopcreditsmusic" );
            music::setmusicstate( "death" );
            wait 1;
            
            if ( sessionmodeiscampaignzombiesgame() )
            {
                uploadstats();
                exitlevel( 0 );
            }
            else
            {
                switchmap_switch();
                uploadstats();
            }
        }
        
        return;
    }
    
    uploadstats();
    exitlevel( 0 );
}

// Namespace skipto
// Params 0
// Checksum 0x9a7a2330, Offset: 0xaf48
// Size: 0x38
function function_3d23f76a()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self freezecontrols( 1 );
        wait 0.05;
    }
}

// Namespace skipto
// Params 0
// Checksum 0x35ebdac0, Offset: 0xaf88
// Size: 0xac
function function_3fbee503()
{
    self endon( #"disconnect" );
    level.var_897126b5++;
    self util::set_low_ready( 1 );
    self thread function_3d23f76a();
    var_d21ab194 = self openluimenu( "SpinnerFullscreenBlack" );
    level flag::wait_till( "all_players_closed_aar" );
    self closeluimenu( var_d21ab194 );
}

// Namespace skipto
// Params 0
// Checksum 0xa9660b8b, Offset: 0xb040
// Size: 0x194
function function_4aa085d7()
{
    self endon( #"disconnect" );
    self endon( #"hash_88bd85cc" );
    
    if ( isdefined( self ) )
    {
        self.var_40ac72fa = self openluimenu( "Credit_Fullscreen", 1 );
        self freezecontrols( 1 );
        self waittill( #"menuresponse", menu, response );
        self closeluimenu( self.var_40ac72fa );
        self freezecontrols( 0 );
        self.var_40ac72fa = undefined;
        
        foreach ( player in getplayers() )
        {
            if ( player == self )
            {
                continue;
            }
            
            player notify( #"hash_88bd85cc" );
            player function_88bd85cc();
        }
        
        level flag::set( "credits_done" );
    }
}

// Namespace skipto
// Params 0
// Checksum 0x3f576d67, Offset: 0xb1e0
// Size: 0x6c
function sndcreditsmusic()
{
    level endon( #"sndstopcreditsmusic" );
    wait 59;
    music::setmusicstate( "unstoppable_credits" );
    wait 148;
    music::setmusicstate( "credits_song_3" );
    wait 85;
    music::setmusicstate( "credits_song_loop" );
}

// Namespace skipto
// Params 1
// Checksum 0x6b704031, Offset: 0xb258
// Size: 0x24, Type: bool
function function_cb7247d8( next_level_name )
{
    return !ismapsublevel( next_level_name );
}

// Namespace skipto
// Params 2
// Checksum 0x902ec35, Offset: 0xb288
// Size: 0xfa
function function_df7ef426( stat_name, map_name )
{
    if ( !isdefined( map_name ) )
    {
        map_name = getrootmapname();
    }
    
    laststat = self getdstat( "PlayerStatsByMap", map_name, "currentStats", stat_name );
    var_9948d116 = self getdstat( "PlayerStatsList", stat_name, "statValue" );
    assert( laststat <= var_9948d116 );
    return int( abs( var_9948d116 - laststat ) );
}

// Namespace skipto
// Params 1
// Checksum 0xd4d3d9fa, Offset: 0xb390
// Size: 0x39c
function function_95093ed5( map_name )
{
    if ( !isdefined( map_name ) )
    {
        map_name = getrootmapname();
    }
    
    var_32c2816f = [];
    array::add( var_32c2816f, "KILLS" );
    array::add( var_32c2816f, "SCORE" );
    array::add( var_32c2816f, "ASSISTS" );
    array::add( var_32c2816f, "REVIVES" );
    
    foreach ( var_8dca536c in var_32c2816f )
    {
        var_43ea6c98 = function_df7ef426( var_8dca536c, map_name );
        assert( var_43ea6c98 >= 0 );
        var_c2a4cf78 = self getdstat( "PlayerStatsByMap", map_name, "highestStats", var_8dca536c );
        
        if ( var_43ea6c98 > var_c2a4cf78 )
        {
            self setdstat( "PlayerStatsByMap", map_name, "highestStats", var_8dca536c, var_43ea6c98 );
        }
    }
    
    var_43ea6c98 = function_df7ef426( "INCAPS", map_name );
    
    if ( !( isdefined( self getdstat( "PlayerStatsByMap", map_name, "hasBeenCompleted" ) != 1 ) && self getdstat( "PlayerStatsByMap", map_name, "hasBeenCompleted" ) != 1 ) )
    {
        self setdstat( "PlayerStatsByMap", map_name, "highestStats", "INCAPS", var_43ea6c98 );
    }
    else
    {
        var_c2a4cf78 = self getdstat( "PlayerStatsByMap", map_name, "highestStats", "INCAPS" );
        
        if ( var_43ea6c98 < var_c2a4cf78 )
        {
            self setdstat( "PlayerStatsByMap", map_name, "highestStats", "INCAPS", var_43ea6c98 );
        }
    }
    
    if ( level.gameskilllowest >= 2 )
    {
        var_c2a4cf78 = self getdstat( "PlayerStatsByMap", getrootmapname(), "highestStats", "INCAPS" );
        
        if ( var_c2a4cf78 == 0 )
        {
            self thread challenges::function_96ed590f( "mission_diff_nodeaths" );
        }
    }
}

// Namespace skipto
// Params 1
// Checksum 0x354b878d, Offset: 0xb738
// Size: 0x138, Type: bool
function function_8295f89d( difficulty )
{
    if ( self getdstat( "PlayerStatsByMap", getrootmapname(), "completedDifficulties", difficulty ) == 1 )
    {
        return false;
    }
    
    var_cfc9cbb7 = function_23eda99c();
    
    foreach ( mission in var_cfc9cbb7 )
    {
        if ( mission == getrootmapname() )
        {
            continue;
        }
        
        if ( self getdstat( "PlayerStatsByMap", mission, "completedDifficulties", difficulty ) == 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace skipto
// Params 2
// Checksum 0x41890999, Offset: 0xb878
// Size: 0x20e
function function_178f7e85( var_deb20b04, difficulty )
{
    if ( self getdstat( "PlayerStatsByMap", var_deb20b04, "receivedXPForDifficulty", difficulty ) != 0 )
    {
        return;
    }
    
    for ( i = difficulty; i >= 0 ; i-- )
    {
        if ( self getdstat( "PlayerStatsByMap", var_deb20b04, "receivedXPForDifficulty", i ) == 0 )
        {
            switch ( i )
            {
                case 0:
                    self addrankxp( "complete_mission_recruit" );
                    break;
                case 1:
                    self addrankxp( "complete_mission_regular" );
                    break;
                case 2:
                    self addrankxp( "complete_mission_hardened" );
                    self thread challenges::function_96ed590f( "career_difficulty_hard" );
                    break;
                case 3:
                    self addrankxp( "complete_mission_veteran" );
                    self thread challenges::function_96ed590f( "career_difficulty_vet" );
                    break;
                case 4:
                    self addrankxp( "complete_mission_heroic" );
                    self thread challenges::function_96ed590f( "career_difficulty_real" );
                    break;
            }
            
            self setdstat( "PlayerStatsByMap", var_deb20b04, "receivedXPForDifficulty", i, 1 );
        }
    }
}

// Namespace skipto
// Params 0
// Checksum 0x9ee42bb2, Offset: 0xba90
// Size: 0x25e
function function_a5a105e8()
{
    playerlist = getplayers();
    
    for ( i = 0; i < playerlist.size ; i++ )
    {
        e_player = playerlist[ i ];
        entnum = e_player getentitynumber();
        var_a4306248 = e_player function_df7ef426( "score" );
        var_aae80abd = e_player function_df7ef426( "kills" );
        var_8ce58b30 = e_player function_df7ef426( "incaps" );
        var_fcdd29fe = e_player function_df7ef426( "assists" );
        var_5c1478bc = e_player function_df7ef426( "revives" );
        self setdstat( "AfterActionReportStats", "playerStats", entnum, "score", var_a4306248 );
        self setdstat( "AfterActionReportStats", "playerStats", entnum, "kills", var_aae80abd );
        self setdstat( "AfterActionReportStats", "playerStats", entnum, "deaths", var_8ce58b30 );
        self setdstat( "AfterActionReportStats", "playerStats", entnum, "assists", var_fcdd29fe );
        self setdstat( "AfterActionReportStats", "playerStats", entnum, "revives", var_5c1478bc );
    }
}

// Namespace skipto
// Params 0
// Checksum 0x4e640d9, Offset: 0xbcf8
// Size: 0x17a
function function_54fdc879()
{
    var_cfc9cbb7 = function_23eda99c();
    
    foreach ( player in level.players )
    {
        var_6511b67a = 1;
        
        foreach ( mission in var_cfc9cbb7 )
        {
            if ( player getdstat( "PlayerStatsByMap", mission, "hasBeenCompleted" ) == 0 )
            {
                var_6511b67a = 0;
                break;
            }
        }
        
        if ( var_6511b67a )
        {
            player setdstat( "zmCampaignData", "unlocked", 1 );
        }
    }
}

// Namespace skipto
// Params 2, eflags: 0x4
// Checksum 0x7a44328d, Offset: 0xbe80
// Size: 0x86
function private standard_objective_init( skipto, starting )
{
    if ( isdefined( level.bzmstartobjectivecallback ) )
    {
        [[ level.bzmstartobjectivecallback ]]( skipto, starting );
    }
    
    level flag::set( skipto );
    level thread watch_completion( skipto );
    level.current_skipto = skipto;
    level notify( #"update_billboard" );
}

// Namespace skipto
// Params 1
// Checksum 0x60df9955, Offset: 0xbf10
// Size: 0x24
function set_level_start_flag( str_flag )
{
    util::set_level_start_flag( str_flag );
}

// Namespace skipto
// Params 4, eflags: 0x4
// Checksum 0xbf3327c7, Offset: 0xbf40
// Size: 0x29a
function private standard_objective_done( skipto, starting, direct, player )
{
    if ( isdefined( level.bzmwaitforobjectivecompletioncallback ) )
    {
        [[ level.bzmwaitforobjectivecompletioncallback ]]();
    }
    
    level flag::clear( skipto );
    level flag::set( skipto + "_completed" );
    
    if ( !isdefined( level.skipto_settings[ skipto ] ) )
    {
        assertmsg( "<dev string:x439>" + skipto );
    }
    
    if ( !( isdefined( level.preserve_script_objective_ents ) && level.preserve_script_objective_ents ) )
    {
        waittillframeend();
        a_entities = getentarray( skipto, "script_objective" );
        
        foreach ( entity in a_entities )
        {
            if ( issentient( entity ) )
            {
                if ( !isdefined( level.heroes ) || !isinarray( level.heroes, entity ) )
                {
                    entity thread util::auto_delete();
                }
                
                continue;
            }
            
            if ( isvehicle( entity ) )
            {
                entity.delete_on_death = 1;
                entity notify( #"death" );
                
                if ( !isalive( entity ) )
                {
                    entity delete();
                }
                
                continue;
            }
            
            if ( sessionmodeiscampaignzombiesgame() && entity.script_noteworthy === "bonuszm_magicbox" )
            {
                if ( isdefined( level.bzm_cleanupmagicboxondeletioncallback ) )
                {
                    [[ level.bzm_cleanupmagicboxondeletioncallback ]]( entity );
                }
                
                continue;
            }
            
            entity delete();
        }
    }
}

// Namespace skipto
// Params 1
// Checksum 0xf10a5d87, Offset: 0xc1e8
// Size: 0x102
function watch_completion( name )
{
    first_trigger = undefined;
    objective_triggers = getentarray( "objective", "targetname" );
    
    foreach ( trigger in objective_triggers )
    {
        if ( trigger.script_objective == name )
        {
            if ( !isdefined( first_trigger ) )
            {
                first_trigger = trigger;
            }
            
            first_trigger thread trigger_watch_completion( trigger, name );
        }
    }
}

// Namespace skipto
// Params 1
// Checksum 0xac583600, Offset: 0xc2f8
// Size: 0xac, Type: bool
function all_players_touching( trigger )
{
    foreach ( player in getplayers() )
    {
        if ( !player istouching( trigger ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace skipto
// Params 2
// Checksum 0xc5a7a133, Offset: 0xc3b0
// Size: 0x170
function trigger_wait_completion( trigger, name )
{
    trigger endon( #"death" );
    level endon( name + "_terminate" );
    
    if ( trigger.script_noteworthy === "allplayers" )
    {
        do
        {
            trigger waittill( #"trigger", player );
        }
        while ( !all_players_touching( trigger ) );
    }
    else
    {
        trigger waittill( #"trigger", player );
        
        if ( trigger.script_noteworthy === "warpplayers" )
        {
            foreach ( other_player in level.players )
            {
                if ( other_player != player )
                {
                    other_player thread catch_up_teleport();
                }
            }
        }
    }
    
    level thread objective_completed( trigger.script_objective, player );
    return player;
}

// Namespace skipto
// Params 2
// Checksum 0x6782af96, Offset: 0xc528
// Size: 0x56
function trigger_watch_completion( trigger, name )
{
    self endon( #"trigger_watch_completion" );
    player = trigger_wait_completion( trigger, name );
    self notify( #"trigger_watch_completion" );
}

// Namespace skipto
// Params 0
// Checksum 0xa7318d0, Offset: 0xc588
// Size: 0xa2
function catch_up_teleport()
{
    self.suicide = 0;
    self.teamkilled = 0;
    timepassed = undefined;
    
    if ( isdefined( self.respawntimerstarttime ) )
    {
        timepassed = ( gettime() - self.respawntimerstarttime ) / 1000;
    }
    
    if ( self laststand::player_is_in_laststand() )
    {
        self notify( #"auto_revive" );
        waittillframeend();
    }
    
    self notify( #"death" );
    self thread [[ level.spawnclient ]]( timepassed );
    self.respawntimerstarttime = undefined;
}

// Namespace skipto
// Params 0
// Checksum 0x7b557f5d, Offset: 0xc638
// Size: 0x248
function entity_mover_main()
{
    entity_movers = struct::get_array( "entity_objective_loc" );
    
    foreach ( mover in entity_movers )
    {
        if ( !isdefined( mover.angles ) )
        {
            mover.angles = ( 0, 0, 0 );
        }
        
        if ( isdefined( mover.script_objective ) && isdefined( level.skipto_settings[ mover.script_objective ] ) )
        {
            if ( !isdefined( level.skipto_settings[ mover.script_objective ].ent_movers ) )
            {
                level.skipto_settings[ mover.script_objective ].ent_movers = [];
            }
            else if ( !isarray( level.skipto_settings[ mover.script_objective ].ent_movers ) )
            {
                level.skipto_settings[ mover.script_objective ].ent_movers = array( level.skipto_settings[ mover.script_objective ].ent_movers );
            }
            
            level.skipto_settings[ mover.script_objective ].ent_movers[ level.skipto_settings[ mover.script_objective ].ent_movers.size ] = mover;
        }
    }
    
    for ( ;; )
    {
        level waittill( #"objective_changed", objectives );
        entity_mover_use_objectives( objectives );
    }
}

// Namespace skipto
// Params 1
// Checksum 0x38d1310f, Offset: 0xc888
// Size: 0x110
function entity_mover_use_objectives( objectives )
{
    foreach ( objective in objectives )
    {
        foreach ( mover in level.skipto_settings[ objective ].ent_movers )
        {
            thread apply_mover( mover );
        }
    }
}

// Namespace skipto
// Params 1
// Checksum 0x28dfc60a, Offset: 0xc9a0
// Size: 0x4e2
function apply_mover( mover )
{
    targets = getentarray( mover.target, "targetname" );
    
    if ( isdefined( mover.script_noteworthy ) && mover.script_noteworthy == "relative" )
    {
        speed = 0;
        
        if ( isdefined( mover.script_int ) )
        {
            speed = mover.script_int;
        }
        
        if ( speed == 0 )
        {
            speed = 0.05;
        }
        
        foreach ( target in targets )
        {
            if ( !isdefined( target.start_mover ) )
            {
                target.start_mover = mover;
                target.last_mover = mover;
            }
            else
            {
                start_mover = target.last_mover;
            }
            
            if ( !isdefined( start_mover ) )
            {
                start_mover = mover;
                speed = 0.05;
                continue;
            }
            
            assert( start_mover == target.last_mover, "<dev string:x452>" );
        }
        
        if ( !isdefined( start_mover ) || start_mover == mover )
        {
            return;
        }
        
        script_mover = spawn( "script_origin", start_mover.origin );
        script_mover.angles = start_mover.angles;
        
        foreach ( target in targets )
        {
            target linkto( script_mover, "", script_mover worldtolocalcoords( target.origin ), target.angles - script_mover.angles );
        }
        
        util::wait_network_frame();
        script_mover moveto( mover.origin, speed );
        script_mover rotateto( mover.angles, speed );
        script_mover waittill( #"movedone" );
        
        foreach ( target in targets )
        {
            target.last_mover = mover;
            target unlink();
        }
        
        script_mover delete();
        return;
    }
    
    foreach ( target in targets )
    {
        target.origin = mover.origin;
        
        if ( isdefined( mover.angles ) )
        {
            target.angles = mover.angles;
        }
    }
}

// Namespace skipto
// Params 0
// Checksum 0xe4066b0e, Offset: 0xce90
// Size: 0x24
function set_skip_safehouse()
{
    level flag::set( "skip_safehouse_after_map" );
}

// Namespace skipto
// Params 0
// Checksum 0x9234abc6, Offset: 0xcec0
// Size: 0x3a, Type: bool
function should_skip_safehouse()
{
    return level flag::get( "skip_safehouse_after_map" ) || sessionmodeiscampaignzombiesgame();
}

// Namespace skipto
// Params 0
// Checksum 0xd3f81f36, Offset: 0xcf08
// Size: 0x24
function set_final_level()
{
    level flag::set( "final_level" );
}

// Namespace skipto
// Params 0
// Checksum 0x1a5026a8, Offset: 0xcf38
// Size: 0x22
function is_final_level()
{
    return level flag::get( "final_level" );
}

/#

    // Namespace skipto
    // Params 0
    // Checksum 0xce9aa465, Offset: 0xcf68
    // Size: 0xe2, Type: dev
    function function_27c2dde4()
    {
        if ( isdefined( level.scriptbundles ) && isdefined( level.scriptbundles[ "<dev string:x489>" ] ) )
        {
            foreach ( scene in level.scriptbundles[ "<dev string:x489>" ] )
            {
                if ( !isdefined( scene.used ) )
                {
                    println( "<dev string:x48f>" + scene.name );
                }
            }
        }
    }

    // Namespace skipto
    // Params 0
    // Checksum 0x41883b8, Offset: 0xd058
    // Size: 0x244, Type: dev
    function update_billboard()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( isdefined( level.billboards ) && isdefined( level.billboards[ level.current_skipto ] ) )
            {
                event_name = level.billboards[ level.current_skipto ][ 0 ];
                b_same_event = level.billboard_event === event_name;
                
                if ( !b_same_event )
                {
                    level.billboard_event = event_name;
                    level.billboard_event_type = level.billboards[ level.current_skipto ][ 1 ];
                    level.billboard_event_size = level.billboards[ level.current_skipto ][ 2 ];
                    level.billboard_event_state = level.billboards[ level.current_skipto ][ 3 ];
                    
                    foreach ( player in level.players )
                    {
                        player notify( #"update_billboard" );
                    }
                }
                else
                {
                    assert( level.billboard_event_type == level.billboards[ level.current_skipto ][ 1 ], "<dev string:x4b9>" );
                    assert( level.billboard_event_size == level.billboards[ level.current_skipto ][ 2 ], "<dev string:x4ed>" );
                    assert( level.billboard_event_state == level.billboards[ level.current_skipto ][ 3 ], "<dev string:x521>" );
                }
            }
            
            level waittill( #"update_billboard" );
        }
    }

    // Namespace skipto
    // Params 0
    // Checksum 0xa6e94386, Offset: 0xd2a8
    // Size: 0x1a4, Type: dev
    function update_player_billboard()
    {
        self endon( #"death" );
        lui_menu = undefined;
        
        while ( true )
        {
            if ( isdefined( level.billboard_event ) )
            {
                if ( level.billboard_event == "<dev string:x556>" )
                {
                    if ( isdefined( lui_menu ) )
                    {
                        self closeluimenu( lui_menu );
                        lui_menu = undefined;
                    }
                }
                else
                {
                    if ( !isdefined( lui_menu ) )
                    {
                        lui_menu = self openluimenu( "<dev string:x55c>" );
                    }
                    
                    self lui::play_animation( lui_menu, "<dev string:x571>" );
                    
                    if ( isdefined( level.billboard_event_state ) )
                    {
                        self setluimenudata( lui_menu, "<dev string:x578>", level.billboard_event + "<dev string:x57d>" + level.billboard_event_state + "<dev string:x580>" );
                    }
                    else
                    {
                        self setluimenudata( lui_menu, "<dev string:x578>", level.billboard_event );
                    }
                    
                    self setluimenudata( lui_menu, "<dev string:x582>", level.billboard_event_type );
                    self setluimenudata( lui_menu, "<dev string:x587>", level.billboard_event_size );
                }
            }
            
            self waittill( #"update_billboard" );
        }
    }

#/
