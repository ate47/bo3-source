#using scripts/codescripts/struct;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace objectives;

// Namespace objectives
// Method(s) 13 Total 13
class cobjective
{

    // Namespace cobjective
    // Params 0
    // Checksum 0xe72e69a1, Offset: 0xff0
    // Size: 0x6, Type: bool
    function is_breadcrumb()
    {
        return false;
    }

    // Namespace cobjective
    // Params 1
    // Checksum 0xa755aac, Offset: 0xf28
    // Size: 0xba
    function get_id_for_target( e_target )
    {
        foreach ( i, obj_id in self.m_a_game_obj )
        {
            ent = self.m_a_targets[ i ];
            
            if ( isdefined( ent ) && ent == e_target )
            {
                return obj_id;
            }
        }
        
        return -1;
    }

    // Namespace cobjective
    // Params 1
    // Checksum 0xf39d87d3, Offset: 0xe50
    // Size: 0xcc
    function show_for_target( e_target )
    {
        foreach ( i, obj_id in self.m_a_game_obj )
        {
            ent = self.m_a_targets[ i ];
            
            if ( isdefined( ent ) && ent == e_target )
            {
                objective_state( obj_id, "active" );
                return;
            }
        }
    }

    // Namespace cobjective
    // Params 1
    // Checksum 0xea5d996c, Offset: 0xd78
    // Size: 0xcc
    function hide_for_target( e_target )
    {
        foreach ( i, obj_id in self.m_a_game_obj )
        {
            ent = self.m_a_targets[ i ];
            
            if ( isdefined( ent ) && ent == e_target )
            {
                objective_state( obj_id, "invisible" );
                return;
            }
        }
    }

    // Namespace cobjective
    // Params 1
    // Checksum 0x395b10e7, Offset: 0xc08
    // Size: 0x162
    function show( e_player )
    {
        if ( isdefined( e_player ) )
        {
            assert( isplayer( e_player ), "<dev string:x5b>" );
            
            foreach ( obj_id in self.m_a_game_obj )
            {
                objective_setvisibletoplayer( obj_id, e_player );
            }
            
            return;
        }
        
        foreach ( obj_id in self.m_a_game_obj )
        {
            objective_setvisibletoall( obj_id );
        }
    }

    // Namespace cobjective
    // Params 1
    // Checksum 0x8b597ffd, Offset: 0xa98
    // Size: 0x162
    function hide( e_player )
    {
        if ( isdefined( e_player ) )
        {
            assert( isplayer( e_player ), "<dev string:x28>" );
            
            foreach ( obj_id in self.m_a_game_obj )
            {
                objective_setinvisibletoplayer( obj_id, e_player );
            }
            
            return;
        }
        
        foreach ( obj_id in self.m_a_game_obj )
        {
            objective_setinvisibletoall( obj_id );
        }
    }

    // Namespace cobjective
    // Params 1
    // Checksum 0xb18f993a, Offset: 0x820
    // Size: 0x26c
    function complete( a_target_or_list )
    {
        if ( a_target_or_list.size > 0 )
        {
            foreach ( target in a_target_or_list )
            {
                for ( i = self.m_a_targets.size - 1; i >= 0 ; i-- )
                {
                    if ( self.m_a_targets[ i ] == target )
                    {
                        objective_state( self.m_a_game_obj[ i ], "done" );
                        arrayremoveindex( self.m_a_game_obj, i );
                        arrayremoveindex( self.m_a_targets, i );
                        break;
                    }
                }
            }
        }
        else
        {
            foreach ( n_gobj_id in self.m_a_game_obj )
            {
                objective_state( n_gobj_id, "done" );
            }
            
            for ( i = self.m_a_targets.size - 1; i >= 0 ; i-- )
            {
                arrayremoveindex( self.m_a_game_obj, i );
                arrayremoveindex( self.m_a_targets, i );
            }
        }
        
        if ( self.m_a_game_obj.size == 0 )
        {
            arrayremovevalue( level.a_objectives, self, 1 );
        }
    }

    // Namespace cobjective
    // Params 1
    // Checksum 0x38f22e8a, Offset: 0x668
    // Size: 0x1ac
    function add_target( target )
    {
        if ( isinarray( self.m_a_targets, target ) )
        {
            return;
        }
        
        gobj_id = undefined;
        
        if ( self.m_a_targets.size < self.m_a_game_obj.size )
        {
            gobj_id = self.m_a_game_obj[ self.m_a_game_obj.size - 1 ];
        }
        else
        {
            gobj_id = gameobjects::get_next_obj_id();
            array::add( self.m_a_game_obj, gobj_id );
        }
        
        if ( isvec( target ) || isentity( target ) )
        {
            objective_add( gobj_id, "active", target, istring( self.m_str_type ) );
        }
        else
        {
            objective_add( gobj_id, "active", target.origin, istring( self.m_str_type ) );
        }
        
        array::add( self.m_a_targets, target );
        assert( self.m_a_targets.size == self.m_a_game_obj.size );
    }

    // Namespace cobjective
    // Params 2
    // Checksum 0xc55be099, Offset: 0x600
    // Size: 0x5c
    function update_counter( x_val, y_val )
    {
        update_value( "obj_x", x_val );
        
        if ( isdefined( y_val ) )
        {
            update_value( "obj_y", y_val );
        }
    }

    // Namespace cobjective
    // Params 2
    // Checksum 0x7b090724, Offset: 0x5a8
    // Size: 0x4c
    function update_value( str_menu_data_name, value )
    {
        gobj_id = self.m_a_game_obj[ 0 ];
        objective_setuimodelvalue( gobj_id, str_menu_data_name, value );
    }

    // Namespace cobjective
    // Params 3
    // Checksum 0xd71af9bb, Offset: 0x3c0
    // Size: 0x1dc
    function init( str_type, a_target_list, b_done )
    {
        if ( !isdefined( b_done ) )
        {
            b_done = 0;
        }
        
        self.m_a_targets = [];
        self.m_a_game_obj = [];
        self.m_str_type = str_type;
        
        if ( b_done )
        {
            gobj_id = gameobjects::get_next_obj_id();
            self.m_a_game_obj = array( gobj_id );
            objective_add( gobj_id, "done", ( 0, 0, 0 ), istring( str_type ) );
            return;
        }
        
        if ( isdefined( a_target_list ) && a_target_list.size > 0 )
        {
            foreach ( target in a_target_list )
            {
                add_target( target );
            }
            
            return;
        }
        
        gobj_id = gameobjects::get_next_obj_id();
        self.m_a_game_obj = array( gobj_id );
        objective_add( gobj_id, "active", ( 0, 0, 0 ), istring( str_type ) );
    }

}

// Namespace objectives
// Method(s) 12 Total 18
class cbreadcrumbobjective : cobjective
{

    // Namespace cbreadcrumbobjective
    // Params 0
    // Checksum 0xef999e9c, Offset: 0x1d48
    // Size: 0xa
    function is_done()
    {
        return self.m_done;
    }

    // Namespace cbreadcrumbobjective
    // Params 0
    // Checksum 0x3fe0c49d, Offset: 0x1d38
    // Size: 0x8, Type: bool
    function is_breadcrumb()
    {
        return true;
    }

    // Namespace cbreadcrumbobjective
    // Params 1
    // Checksum 0xff77e1ab, Offset: 0x1a50
    // Size: 0x2dc
    function do_player_breadcrumb( player )
    {
        level endon( "breadcrumb_" + self.m_str_type );
        level endon( "breadcrumb_" + self.m_str_type + "_complete" );
        player endon( #"death" );
        str_trig_targetname = self.m_str_first_trig_targetname;
        entnum = player getentitynumber();
        obj_id = self.m_a_player_game_obj[ entnum ];
        objective_setvisibletoplayer( obj_id, player );
        
        do
        {
            t_current = getent( str_trig_targetname, "targetname" );
            
            if ( isdefined( t_current ) )
            {
                if ( isdefined( t_current.target ) )
                {
                    if ( isdefined( t_current.script_flag_true ) )
                    {
                        objective_setinvisibletoplayer( obj_id, player );
                        level flag::wait_till( t_current.script_flag_true );
                        objective_setvisibletoplayer( obj_id, player );
                    }
                    
                    s_current = struct::get( t_current.target, "targetname" );
                    
                    if ( isdefined( s_current ) )
                    {
                        set_player_objective( player, s_current );
                    }
                    else
                    {
                        set_player_objective( player, t_current );
                    }
                }
                else
                {
                    set_player_objective( player, t_current );
                }
                
                str_trig_targetname = t_current.target;
                t_current trigger::wait_till( undefined, undefined, player );
                continue;
            }
            
            str_trig_targetname = undefined;
        }
        while ( isdefined( str_trig_targetname ) );
        
        objective_setinvisibletoplayer( obj_id, player );
        
        foreach ( player in level.players )
        {
            player.v_current_active_breadcrumb = undefined;
        }
        
        self.m_done = 1;
    }

    // Namespace cbreadcrumbobjective
    // Params 2, eflags: 0x4
    // Checksum 0xdf5c259e, Offset: 0x1910
    // Size: 0x134
    function private set_player_objective( player, target )
    {
        entnum = player getentitynumber();
        obj_id = self.m_a_player_game_obj[ entnum ];
        n_breadcrumb_height = 72;
        v_pos = target;
        
        if ( !isvec( target ) )
        {
            v_pos = target.origin;
            
            if ( isdefined( target.script_height ) )
            {
                n_breadcrumb_height = target.script_height;
            }
        }
        
        v_pos = util::ground_position( v_pos, 300, n_breadcrumb_height );
        player.v_current_active_breadcrumb = v_pos;
        objective_position( obj_id, v_pos );
        objective_state( obj_id, "active" );
    }

    // Namespace cbreadcrumbobjective
    // Params 1
    // Checksum 0x7d679bc9, Offset: 0x1850
    // Size: 0xb4
    function add_player( player )
    {
        entnum = player getentitynumber();
        obj_id = self.m_a_player_game_obj[ entnum ];
        objective_setinvisibletoall( obj_id );
        objective_setvisibletoplayer( obj_id, player );
        objective_state( obj_id, "active" );
        thread do_player_breadcrumb( player );
    }

    // Namespace cbreadcrumbobjective
    // Params 1
    // Checksum 0x33d25588, Offset: 0x1798
    // Size: 0xaa
    function start( str_trig_targetname )
    {
        self.m_str_first_trig_targetname = str_trig_targetname;
        self.m_done = 0;
        
        foreach ( player in level.players )
        {
            add_player( player );
        }
    }

    // Namespace cbreadcrumbobjective
    // Params 1
    // Checksum 0x30f9045, Offset: 0x1690
    // Size: 0xfe
    function show( e_player )
    {
        if ( isdefined( e_player ) )
        {
            assert( isplayer( e_player ), "<dev string:x8e>" );
            entnum = e_player getentitynumber();
            obj_id = self.m_a_player_game_obj[ entnum ];
            objective_setvisibletoplayer( obj_id, e_player );
            return;
        }
        
        for ( i = 0; i < 4 ; i++ )
        {
            obj_id = self.m_a_player_game_obj[ i ];
            objective_setvisibletoplayerbyindex( obj_id, i );
        }
    }

    // Namespace cbreadcrumbobjective
    // Params 1
    // Checksum 0x811d1ab3, Offset: 0x1588
    // Size: 0xfe
    function hide( e_player )
    {
        if ( isdefined( e_player ) )
        {
            assert( isplayer( e_player ), "<dev string:x8e>" );
            entnum = e_player getentitynumber();
            obj_id = self.m_a_player_game_obj[ entnum ];
            objective_setinvisibletoplayer( obj_id, e_player );
            return;
        }
        
        for ( i = 0; i < 4 ; i++ )
        {
            obj_id = self.m_a_player_game_obj[ i ];
            objective_setinvisibletoplayerbyindex( obj_id, i );
        }
    }

    // Namespace cbreadcrumbobjective
    // Params 1
    // Checksum 0xed9e6446, Offset: 0x1458
    // Size: 0x124
    function complete( a_target_or_list )
    {
        level notify( "breadcrumb_" + self.m_str_type + "_complete" );
        
        for ( i = 0; i < 4 ; i++ )
        {
            obj_id = self.m_a_player_game_obj[ i ];
            objective_state( obj_id, "done" );
        }
        
        foreach ( player in level.players )
        {
            player.v_current_active_breadcrumb = undefined;
        }
        
        cobjective::complete( a_target_or_list );
    }

    // Namespace cbreadcrumbobjective
    // Params 3
    // Checksum 0xc2fabe03, Offset: 0x12d0
    // Size: 0x17c
    function init( str_type, a_target_list, b_done )
    {
        if ( !isdefined( b_done ) )
        {
            b_done = 0;
        }
        
        cobjective::init( str_type, a_target_list, b_done );
        self.m_str_first_trig_targetname = "";
        self.m_done = b_done;
        self.m_a_player_game_obj = [];
        
        for ( i = 0; i < 4 ; i++ )
        {
            obj_id = gameobjects::get_next_obj_id();
            self.m_a_player_game_obj[ i ] = obj_id;
            
            if ( self.m_done )
            {
                objective_add( obj_id, "done", ( 0, 0, 0 ), istring( self.m_str_type ) );
                continue;
            }
            
            objective_add( obj_id, "empty", ( 0, 0, 0 ), istring( self.m_str_type ) );
        }
        
        obj_id = self.m_a_game_obj[ 0 ];
        objective_setinvisibletoall( obj_id );
    }

}

// Namespace objectives
// Params 0, eflags: 0x2
// Checksum 0xb5c7ab63, Offset: 0x2260
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "objectives", &__init__, undefined, undefined );
}

// Namespace objectives
// Params 0
// Checksum 0xffb95eb8, Offset: 0x22a0
// Size: 0x3c
function __init__()
{
    level.a_objectives = [];
    level.n_obj_index = 0;
    callback::on_spawned( &on_player_spawned );
}

// Namespace objectives
// Params 3
// Checksum 0xe5311779, Offset: 0x22e8
// Size: 0x1c2
function set( str_obj_type, a_target_or_list, b_breadcrumb )
{
    if ( !isdefined( level.a_objectives ) )
    {
        level.a_objectives = [];
    }
    
    if ( !isdefined( b_breadcrumb ) )
    {
        b_breadcrumb = 0;
    }
    
    if ( !isdefined( a_target_or_list ) )
    {
        a_target_or_list = [];
    }
    else if ( !isarray( a_target_or_list ) )
    {
        a_target_or_list = array( a_target_or_list );
    }
    
    o_objective = undefined;
    
    if ( isdefined( level.a_objectives[ str_obj_type ] ) )
    {
        o_objective = level.a_objectives[ str_obj_type ];
        
        if ( isdefined( a_target_or_list ) )
        {
            foreach ( target in a_target_or_list )
            {
                [[ o_objective ]]->add_target( target );
            }
        }
    }
    else
    {
        if ( b_breadcrumb )
        {
            o_objective = new cbreadcrumbobjective();
        }
        else
        {
            o_objective = new cobjective();
        }
        
        [[ o_objective ]]->init( str_obj_type, a_target_or_list );
        level.a_objectives[ str_obj_type ] = o_objective;
    }
    
    return o_objective;
}

// Namespace objectives
// Params 2
// Checksum 0x73b7b942, Offset: 0x24b8
// Size: 0x116
function complete( str_obj_type, a_target_or_list )
{
    if ( !isdefined( a_target_or_list ) )
    {
        a_target_or_list = [];
    }
    else if ( !isarray( a_target_or_list ) )
    {
        a_target_or_list = array( a_target_or_list );
    }
    
    if ( isdefined( level.a_objectives[ str_obj_type ] ) )
    {
        o_objective = level.a_objectives[ str_obj_type ];
        [[ o_objective ]]->complete( a_target_or_list );
        return;
    }
    
    if ( str_obj_type == "cp_waypoint_breadcrumb" )
    {
        o_objective = new cbreadcrumbobjective();
    }
    else
    {
        o_objective = new cobjective();
    }
    
    [[ o_objective ]]->init( str_obj_type, undefined, 1 );
    level.a_objectives[ str_obj_type ] = o_objective;
}

// Namespace objectives
// Params 2
// Checksum 0x9ebb1b12, Offset: 0x25d8
// Size: 0xa0
function set_with_counter( str_obj_id, a_targets )
{
    if ( !isdefined( a_targets ) )
    {
        a_targets = [];
    }
    else if ( !isarray( a_targets ) )
    {
        a_targets = array( a_targets );
    }
    
    o_obj = set( str_obj_id, a_targets );
    [[ o_obj ]]->update_counter( 0, a_targets.size );
}

// Namespace objectives
// Params 3
// Checksum 0x3b343737, Offset: 0x2680
// Size: 0x58
function update_counter( str_obj_id, x_val, y_val )
{
    o_obj = level.a_objectives[ str_obj_id ];
    
    if ( isdefined( o_obj ) )
    {
        [[ o_obj ]]->update_counter( x_val, y_val );
    }
}

// Namespace objectives
// Params 3
// Checksum 0x3d66a80e, Offset: 0x26e0
// Size: 0x58
function set_value( str_obj_id, str_menu_data_name, value )
{
    o_obj = level.a_objectives[ str_obj_id ];
    
    if ( isdefined( o_obj ) )
    {
        [[ o_obj ]]->update_value( str_menu_data_name, value );
    }
}

// Namespace objectives
// Params 3
// Checksum 0xab32e7af, Offset: 0x2740
// Size: 0x114
function breadcrumb( str_trig_targetname, str_obj_id, b_complete_on_first_player_finish )
{
    if ( !isdefined( str_obj_id ) )
    {
        str_obj_id = "cp_waypoint_breadcrumb";
    }
    
    if ( !isdefined( b_complete_on_first_player_finish ) )
    {
        b_complete_on_first_player_finish = 1;
    }
    
    level notify( "breadcrumb_" + str_obj_id );
    level endon( "breadcrumb_" + str_obj_id );
    
    if ( isdefined( level.a_objectives[ str_obj_id ] ) )
    {
        complete( str_obj_id );
    }
    
    o_objective = set( str_obj_id, undefined, 1 );
    [[ o_objective ]]->start( str_trig_targetname );
    
    while ( ![[ o_objective ]]->is_done() )
    {
        wait 0.05;
    }
    
    if ( b_complete_on_first_player_finish )
    {
        complete( str_obj_id );
    }
}

// Namespace objectives
// Params 2
// Checksum 0x725ddd3b, Offset: 0x2860
// Size: 0x7c
function hide( str_obj_type, e_player )
{
    if ( isdefined( level.a_objectives[ str_obj_type ] ) )
    {
        o_objective = level.a_objectives[ str_obj_type ];
        [[ o_objective ]]->hide( e_player );
        return;
    }
    
    assert( 0, "<dev string:xcb>" );
}

// Namespace objectives
// Params 2
// Checksum 0xa326bcfc, Offset: 0x28e8
// Size: 0x7c
function hide_for_target( str_obj_type, e_target )
{
    if ( isdefined( level.a_objectives[ str_obj_type ] ) )
    {
        o_objective = level.a_objectives[ str_obj_type ];
        [[ o_objective ]]->hide_for_target( e_target );
        return;
    }
    
    assert( 0, "<dev string:xcb>" );
}

// Namespace objectives
// Params 2
// Checksum 0xe9c9ce84, Offset: 0x2970
// Size: 0x7c
function show( str_obj_type, e_player )
{
    if ( isdefined( level.a_objectives[ str_obj_type ] ) )
    {
        o_objective = level.a_objectives[ str_obj_type ];
        [[ o_objective ]]->show( e_player );
        return;
    }
    
    assert( 0, "<dev string:x10c>" );
}

// Namespace objectives
// Params 2
// Checksum 0xb48bd41, Offset: 0x29f8
// Size: 0x7c
function show_for_target( str_obj_type, e_target )
{
    if ( isdefined( level.a_objectives[ str_obj_type ] ) )
    {
        o_objective = level.a_objectives[ str_obj_type ];
        [[ o_objective ]]->show_for_target( e_target );
        return;
    }
    
    assert( 0, "<dev string:xcb>" );
}

// Namespace objectives
// Params 2
// Checksum 0xf1481587, Offset: 0x2a80
// Size: 0xa0
function get_id_for_target( str_obj_type, e_target )
{
    id = -1;
    
    if ( isdefined( level.a_objectives[ str_obj_type ] ) )
    {
        o_objective = level.a_objectives[ str_obj_type ];
        id = [[ o_objective ]]->get_id_for_target( e_target );
    }
    
    if ( id < 0 )
    {
        assert( 0, "<dev string:x14d>" );
    }
    
    return id;
}

// Namespace objectives
// Params 1
// Checksum 0x8fe357eb, Offset: 0x2b28
// Size: 0xa2
function event_message( istr_message )
{
    foreach ( player in level.players )
    {
        util::show_event_message( player, istring( istr_message ) );
    }
}

// Namespace objectives
// Params 4
// Checksum 0x55c2d488, Offset: 0x2bd8
// Size: 0x1d8
function create_temp_icon( str_obj_type, str_obj_name, v_pos, v_offset )
{
    if ( !isdefined( v_offset ) )
    {
        v_offset = ( 0, 0, 0 );
    }
    
    switch ( str_obj_type )
    {
        case "target":
            str_shader = "waypoint_targetneutral";
            break;
        case "capture":
            str_shader = "waypoint_capture";
            break;
        case "capture_a":
            str_shader = "waypoint_capture_a";
            break;
        case "capture_b":
            str_shader = "waypoint_capture_b";
            break;
        case "capture_c":
            str_shader = "waypoint_capture_c";
            break;
        case "defend":
            str_shader = "waypoint_defend";
            break;
        case "defend_a":
            str_shader = "waypoint_defend_a";
            break;
        case "defend_b":
            str_shader = "waypoint_defend_b";
            break;
        case "defend_c":
            str_shader = "waypoint_defend_c";
            break;
        case "return":
            str_shader = "waypoint_return";
            break;
        default:
            assertmsg( "<dev string:x18c>" + str_obj_type + "<dev string:x193>" );
            break;
    }
    
    nextobjpoint = objpoints::create( str_obj_name, v_pos + v_offset, "all", str_shader );
    nextobjpoint setwaypoint( 1, str_shader );
    return nextobjpoint;
}

// Namespace objectives
// Params 0
// Checksum 0xfd79d6b6, Offset: 0x2db8
// Size: 0x1c
function destroy_temp_icon()
{
    objpoints::delete( self );
}

// Namespace objectives
// Params 0, eflags: 0x4
// Checksum 0x76e69d94, Offset: 0x2de0
// Size: 0xbe
function private on_player_spawned()
{
    if ( isdefined( level.a_objectives ) )
    {
        foreach ( o_objective in level.a_objectives )
        {
            if ( [[ o_objective ]]->is_breadcrumb() && ![[ o_objective ]]->is_done() )
            {
                [[ o_objective ]]->add_player( self );
            }
        }
    }
}

