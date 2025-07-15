#using scripts/shared/flagsys_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace util;

// Namespace util
// Params 5
// Checksum 0x8eece268, Offset: 0x2b0
// Size: 0x2c
function empty( a, b, c, d, e )
{
    
}

// Namespace util
// Params 0
// Checksum 0x33122f03, Offset: 0x2e8
// Size: 0x86
function waitforallclients()
{
    localclient = 0;
    
    if ( !isdefined( level.localplayers ) )
    {
        while ( !isdefined( level.localplayers ) )
        {
            wait 0.016;
        }
    }
    
    while ( level.localplayers.size <= 0 )
    {
        wait 0.016;
    }
    
    while ( localclient < level.localplayers.size )
    {
        waitforclient( localclient );
        localclient++;
    }
}

// Namespace util
// Params 1
// Checksum 0xa401ac1c, Offset: 0x378
// Size: 0x34
function waitforclient( client )
{
    while ( !clienthassnapshot( client ) )
    {
        wait 0.016;
    }
}

// Namespace util
// Params 2
// Checksum 0x944b1c1a, Offset: 0x3b8
// Size: 0x62
function get_dvar_float_default( str_dvar, default_val )
{
    value = getdvarstring( str_dvar );
    return value != "" ? float( value ) : default_val;
}

// Namespace util
// Params 2
// Checksum 0xde99debf, Offset: 0x428
// Size: 0x62
function get_dvar_int_default( str_dvar, default_val )
{
    value = getdvarstring( str_dvar );
    return value != "" ? int( value ) : default_val;
}

// Namespace util
// Params 4
// Checksum 0x9a2dcb15, Offset: 0x498
// Size: 0xac
function spawn_model( n_client, str_model, origin, angles )
{
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    model = spawn( n_client, origin, "script_model" );
    model setmodel( str_model );
    model.angles = angles;
    return model;
}

// Namespace util
// Params 2
// Checksum 0x49b06d09, Offset: 0x550
// Size: 0x58
function waittill_string( msg, ent )
{
    if ( msg != "entityshutdown" )
    {
        self endon( #"entityshutdown" );
    }
    
    ent endon( #"die" );
    self waittill( msg );
    ent notify( #"returned", msg );
}

// Namespace util
// Params 1, eflags: 0x20 variadic
// Checksum 0x7554b5f1, Offset: 0x5b0
// Size: 0xaa
function waittill_multiple( ... )
{
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    
    for ( i = 0; i < vararg.size ; i++ )
    {
        self thread _waitlogic( s_tracker, vararg[ i ] );
    }
    
    if ( s_tracker._wait_count > 0 )
    {
        s_tracker waittill( #"waitlogic_finished" );
    }
}

// Namespace util
// Params 1, eflags: 0x20 variadic
// Checksum 0x3c0e4eba, Offset: 0x668
// Size: 0x1e2
function waittill_multiple_ents( ... )
{
    a_ents = [];
    a_notifies = [];
    
    for ( i = 0; i < vararg.size ; i++ )
    {
        if ( i % 2 )
        {
            if ( !isdefined( a_notifies ) )
            {
                a_notifies = [];
            }
            else if ( !isarray( a_notifies ) )
            {
                a_notifies = array( a_notifies );
            }
            
            a_notifies[ a_notifies.size ] = vararg[ i ];
            continue;
        }
        
        if ( !isdefined( a_ents ) )
        {
            a_ents = [];
        }
        else if ( !isarray( a_ents ) )
        {
            a_ents = array( a_ents );
        }
        
        a_ents[ a_ents.size ] = vararg[ i ];
    }
    
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    
    for ( i = 0; i < a_ents.size ; i++ )
    {
        ent = a_ents[ i ];
        
        if ( isdefined( ent ) )
        {
            ent thread _waitlogic( s_tracker, a_notifies[ i ] );
        }
    }
    
    if ( s_tracker._wait_count > 0 )
    {
        s_tracker waittill( #"waitlogic_finished" );
    }
}

// Namespace util
// Params 2
// Checksum 0xc88c8f6e, Offset: 0x858
// Size: 0xd0
function _waitlogic( s_tracker, notifies )
{
    s_tracker._wait_count++;
    
    if ( !isdefined( notifies ) )
    {
        notifies = [];
    }
    else if ( !isarray( notifies ) )
    {
        notifies = array( notifies );
    }
    
    notifies[ notifies.size ] = "entityshutdown";
    waittill_any_array( notifies );
    s_tracker._wait_count--;
    
    if ( s_tracker._wait_count == 0 )
    {
        s_tracker notify( #"waitlogic_finished" );
    }
}

// Namespace util
// Params 7
// Checksum 0x776fb161, Offset: 0x930
// Size: 0x268
function waittill_any_return( string1, string2, string3, string4, string5, string6, string7 )
{
    if ( !isdefined( string7 ) || ( !isdefined( string6 ) || ( !isdefined( string5 ) || ( !isdefined( string4 ) || ( !isdefined( string3 ) || ( !isdefined( string2 ) || ( !isdefined( string1 ) || string1 != "entityshutdown" ) && string2 != "entityshutdown" ) && string3 != "entityshutdown" ) && string4 != "entityshutdown" ) && string5 != "entityshutdown" ) && string6 != "entityshutdown" ) && string7 != "entityshutdown" )
    {
        self endon( #"entityshutdown" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        self thread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        self thread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        self thread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        self thread waittill_string( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        self thread waittill_string( string5, ent );
    }
    
    if ( isdefined( string6 ) )
    {
        self thread waittill_string( string6, ent );
    }
    
    if ( isdefined( string7 ) )
    {
        self thread waittill_string( string7, ent );
    }
    
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace util
// Params 1, eflags: 0x20 variadic
// Checksum 0xd9aff40c, Offset: 0xba0
// Size: 0x1cc
function waittill_any_ex( ... )
{
    s_common = spawnstruct();
    e_current = self;
    n_arg_index = 0;
    
    if ( strisnumber( vararg[ 0 ] ) )
    {
        n_timeout = vararg[ 0 ];
        n_arg_index++;
        
        if ( n_timeout > 0 )
        {
            s_common thread _timeout( n_timeout );
        }
    }
    
    if ( isarray( vararg[ n_arg_index ] ) )
    {
        a_params = vararg[ n_arg_index ];
        n_start_index = 0;
    }
    else
    {
        a_params = vararg;
        n_start_index = n_arg_index;
    }
    
    for ( i = n_start_index; i < a_params.size ; i++ )
    {
        if ( !isstring( a_params[ i ] ) )
        {
            e_current = a_params[ i ];
            continue;
        }
        
        if ( isdefined( e_current ) )
        {
            e_current thread waittill_string( a_params[ i ], s_common );
        }
    }
    
    s_common waittill( #"returned", str_notify );
    s_common notify( #"die" );
    return str_notify;
}

// Namespace util
// Params 1
// Checksum 0x191bf226, Offset: 0xd78
// Size: 0x118
function waittill_any_array_return( a_notifies )
{
    if ( isinarray( a_notifies, "entityshutdown" ) )
    {
        self endon( #"entityshutdown" );
    }
    
    s_tracker = spawnstruct();
    
    foreach ( str_notify in a_notifies )
    {
        if ( isdefined( str_notify ) )
        {
            self thread waittill_string( str_notify, s_tracker );
        }
    }
    
    s_tracker waittill( #"returned", msg );
    s_tracker notify( #"die" );
    return msg;
}

// Namespace util
// Params 5
// Checksum 0x827b0c90, Offset: 0xe98
// Size: 0x84
function waittill_any( str_notify1, str_notify2, str_notify3, str_notify4, str_notify5 )
{
    assert( isdefined( str_notify1 ) );
    waittill_any_array( array( str_notify1, str_notify2, str_notify3, str_notify4, str_notify5 ) );
}

// Namespace util
// Params 1
// Checksum 0x6bce93a1, Offset: 0xf28
// Size: 0x8c
function waittill_any_array( a_notifies )
{
    assert( isdefined( a_notifies[ 0 ] ), "<dev string:x28>" );
    
    for ( i = 1; i < a_notifies.size ; i++ )
    {
        if ( isdefined( a_notifies[ i ] ) )
        {
            self endon( a_notifies[ i ] );
        }
    }
    
    self waittill( a_notifies[ 0 ] );
}

// Namespace util
// Params 6
// Checksum 0x8261b2f8, Offset: 0xfc0
// Size: 0x1f0
function waittill_any_timeout( n_timeout, string1, string2, string3, string4, string5 )
{
    if ( !isdefined( string5 ) || ( !isdefined( string4 ) || ( !isdefined( string3 ) || ( !isdefined( string2 ) || ( !isdefined( string1 ) || string1 != "entityshutdown" ) && string2 != "entityshutdown" ) && string3 != "entityshutdown" ) && string4 != "entityshutdown" ) && string5 != "entityshutdown" )
    {
        self endon( #"entityshutdown" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        self thread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        self thread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        self thread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        self thread waittill_string( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        self thread waittill_string( string5, ent );
    }
    
    ent thread _timeout( n_timeout );
    ent waittill( #"returned", msg );
    ent notify( #"die" );
    return msg;
}

// Namespace util
// Params 1
// Checksum 0x52de6ba9, Offset: 0x11b8
// Size: 0x32
function _timeout( delay )
{
    self endon( #"die" );
    wait delay;
    self notify( #"returned", "timeout" );
}

// Namespace util
// Params 2
// Checksum 0xa3251a25, Offset: 0x11f8
// Size: 0x22
function waittill_notify_or_timeout( msg, timer )
{
    self endon( msg );
    wait timer;
}

// Namespace util
// Params 14
// Checksum 0x4a1a4249, Offset: 0x1228
// Size: 0x174
function waittill_any_ents( ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7 )
{
    assert( isdefined( ent1 ) );
    assert( isdefined( string1 ) );
    
    if ( isdefined( ent2 ) && isdefined( string2 ) )
    {
        ent2 endon( string2 );
    }
    
    if ( isdefined( ent3 ) && isdefined( string3 ) )
    {
        ent3 endon( string3 );
    }
    
    if ( isdefined( ent4 ) && isdefined( string4 ) )
    {
        ent4 endon( string4 );
    }
    
    if ( isdefined( ent5 ) && isdefined( string5 ) )
    {
        ent5 endon( string5 );
    }
    
    if ( isdefined( ent6 ) && isdefined( string6 ) )
    {
        ent6 endon( string6 );
    }
    
    if ( isdefined( ent7 ) && isdefined( string7 ) )
    {
        ent7 endon( string7 );
    }
    
    ent1 waittill( string1 );
}

// Namespace util
// Params 4
// Checksum 0x418113d0, Offset: 0x13a8
// Size: 0x8e
function waittill_any_ents_two( ent1, string1, ent2, string2 )
{
    assert( isdefined( ent1 ) );
    assert( isdefined( string1 ) );
    
    if ( isdefined( ent2 ) && isdefined( string2 ) )
    {
        ent2 endon( string2 );
    }
    
    ent1 waittill( string1 );
}

// Namespace util
// Params 8
// Checksum 0x74a1ab65, Offset: 0x1440
// Size: 0x16e
function single_func( entity, func, arg1, arg2, arg3, arg4, arg5, arg6 )
{
    if ( !isdefined( entity ) )
    {
        entity = level;
    }
    
    if ( isdefined( arg6 ) )
    {
        return entity [[ func ]]( arg1, arg2, arg3, arg4, arg5, arg6 );
    }
    
    if ( isdefined( arg5 ) )
    {
        return entity [[ func ]]( arg1, arg2, arg3, arg4, arg5 );
    }
    
    if ( isdefined( arg4 ) )
    {
        return entity [[ func ]]( arg1, arg2, arg3, arg4 );
    }
    
    if ( isdefined( arg3 ) )
    {
        return entity [[ func ]]( arg1, arg2, arg3 );
    }
    
    if ( isdefined( arg2 ) )
    {
        return entity [[ func ]]( arg1, arg2 );
    }
    
    if ( isdefined( arg1 ) )
    {
        return entity [[ func ]]( arg1 );
    }
    
    return entity [[ func ]]();
}

// Namespace util
// Params 7
// Checksum 0x8dea8452, Offset: 0x15b8
// Size: 0xe8
function new_func( func, arg1, arg2, arg3, arg4, arg5, arg6 )
{
    s_func = spawnstruct();
    s_func.func = func;
    s_func.arg1 = arg1;
    s_func.arg2 = arg2;
    s_func.arg3 = arg3;
    s_func.arg4 = arg4;
    s_func.arg5 = arg5;
    s_func.arg6 = arg6;
    return s_func;
}

// Namespace util
// Params 1
// Checksum 0xc0a45989, Offset: 0x16a8
// Size: 0x72
function call_func( s_func )
{
    return single_func( self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6 );
}

// Namespace util
// Params 7
// Checksum 0x710c3196, Offset: 0x1728
// Size: 0x16c
function array_ent_thread( entities, func, arg1, arg2, arg3, arg4, arg5 )
{
    assert( isdefined( entities ), "<dev string:x6d>" );
    assert( isdefined( func ), "<dev string:xa5>" );
    
    if ( isarray( entities ) )
    {
        if ( entities.size )
        {
            keys = getarraykeys( entities );
            
            for ( i = 0; i < keys.size ; i++ )
            {
                single_thread( self, func, entities[ keys[ i ] ], arg1, arg2, arg3, arg4, arg5 );
            }
        }
        
        return;
    }
    
    single_thread( self, func, entities, arg1, arg2, arg3, arg4, arg5 );
}

// Namespace util
// Params 8
// Checksum 0xef0e77ee, Offset: 0x18a0
// Size: 0x184
function single_thread( entity, func, arg1, arg2, arg3, arg4, arg5, arg6 )
{
    assert( isdefined( entity ), "<dev string:xd9>" );
    
    if ( isdefined( arg6 ) )
    {
        entity thread [[ func ]]( arg1, arg2, arg3, arg4, arg5, arg6 );
        return;
    }
    
    if ( isdefined( arg5 ) )
    {
        entity thread [[ func ]]( arg1, arg2, arg3, arg4, arg5 );
        return;
    }
    
    if ( isdefined( arg4 ) )
    {
        entity thread [[ func ]]( arg1, arg2, arg3, arg4 );
        return;
    }
    
    if ( isdefined( arg3 ) )
    {
        entity thread [[ func ]]( arg1, arg2, arg3 );
        return;
    }
    
    if ( isdefined( arg2 ) )
    {
        entity thread [[ func ]]( arg1, arg2 );
        return;
    }
    
    if ( isdefined( arg1 ) )
    {
        entity thread [[ func ]]( arg1 );
        return;
    }
    
    entity thread [[ func ]]();
}

// Namespace util
// Params 7
// Checksum 0x89a716e9, Offset: 0x1a30
// Size: 0x6c
function add_listen_thread( wait_till, func, param1, param2, param3, param4, param5 )
{
    level thread add_listen_thread_internal( wait_till, func, param1, param2, param3, param4, param5 );
}

// Namespace util
// Params 7
// Checksum 0x5806aaa2, Offset: 0x1aa8
// Size: 0x78
function add_listen_thread_internal( wait_till, func, param1, param2, param3, param4, param5 )
{
    for ( ;; )
    {
        level waittill( wait_till );
        single_thread( level, func, param1, param2, param3, param4, param5 );
    }
}

// Namespace util
// Params 8
// Checksum 0xe165ca36, Offset: 0x1b28
// Size: 0xd4
function timeout( n_time, func, arg1, arg2, arg3, arg4, arg5, arg6 )
{
    self endon( #"entityshutdown" );
    
    if ( isdefined( n_time ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s delay_notify( n_time, "timeout" );
    }
    
    single_func( self, func, arg1, arg2, arg3, arg4, arg5, arg6 );
}

// Namespace util
// Params 9
// Checksum 0x1e8a8113, Offset: 0x1c08
// Size: 0x84
function delay( time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6 )
{
    self thread _delay( time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6 );
}

// Namespace util
// Params 9
// Checksum 0xbfcfe531, Offset: 0x1c98
// Size: 0xc4
function _delay( time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6 )
{
    self endon( #"entityshutdown" );
    
    if ( isdefined( str_endon ) )
    {
        self endon( str_endon );
    }
    
    if ( isstring( time_or_notify ) )
    {
        self waittill( time_or_notify );
    }
    else
    {
        wait time_or_notify;
    }
    
    single_func( self, func, arg1, arg2, arg3, arg4, arg5, arg6 );
}

// Namespace util
// Params 3
// Checksum 0xb6a36da2, Offset: 0x1d68
// Size: 0x3c
function delay_notify( time_or_notify, str_notify, str_endon )
{
    self thread _delay_notify( time_or_notify, str_notify, str_endon );
}

// Namespace util
// Params 3
// Checksum 0x8f9ad867, Offset: 0x1db0
// Size: 0x6c
function _delay_notify( time_or_notify, str_notify, str_endon )
{
    self endon( #"entityshutdown" );
    
    if ( isdefined( str_endon ) )
    {
        self endon( str_endon );
    }
    
    if ( isstring( time_or_notify ) )
    {
        self waittill( time_or_notify );
    }
    else
    {
        wait time_or_notify;
    }
    
    self notify( str_notify );
}

// Namespace util
// Params 1
// Checksum 0x7c0bb092, Offset: 0x1e28
// Size: 0x50
function new_timer( n_timer_length )
{
    s_timer = spawnstruct();
    s_timer.n_time_created = gettime();
    s_timer.n_length = n_timer_length;
    return s_timer;
}

// Namespace util
// Params 0
// Checksum 0xa5d5574, Offset: 0x1e80
// Size: 0x20
function get_time()
{
    t_now = gettime();
    return t_now - self.n_time_created;
}

// Namespace util
// Params 0
// Checksum 0xe2a3f7d6, Offset: 0x1ea8
// Size: 0x18
function get_time_in_seconds()
{
    return get_time() / 1000;
}

// Namespace util
// Params 1
// Checksum 0xa129ed4a, Offset: 0x1ec8
// Size: 0x52
function get_time_frac( n_end_time )
{
    if ( !isdefined( n_end_time ) )
    {
        n_end_time = self.n_length;
    }
    
    return lerpfloat( 0, 1, get_time_in_seconds() / n_end_time );
}

// Namespace util
// Params 0
// Checksum 0x408daa33, Offset: 0x1f28
// Size: 0x58
function get_time_left()
{
    if ( isdefined( self.n_length ) )
    {
        n_current_time = get_time_in_seconds();
        return max( self.n_length - n_current_time, 0 );
    }
    
    return -1;
}

// Namespace util
// Params 0
// Checksum 0x5b6f6f20, Offset: 0x1f88
// Size: 0x16, Type: bool
function is_time_left()
{
    return get_time_left() != 0;
}

// Namespace util
// Params 1
// Checksum 0x8b84f150, Offset: 0x1fa8
// Size: 0x6c
function timer_wait( n_wait )
{
    if ( isdefined( self.n_length ) )
    {
        n_wait = min( n_wait, get_time_left() );
    }
    
    wait n_wait;
    n_current_time = get_time_in_seconds();
    return n_current_time;
}

// Namespace util
// Params 2
// Checksum 0x866bc067, Offset: 0x2020
// Size: 0x84
function add_remove_list( &a, on_off )
{
    if ( !isdefined( a ) )
    {
        a = [];
    }
    
    if ( on_off )
    {
        if ( !isinarray( a, self ) )
        {
            arrayinsert( a, self, a.size );
        }
        
        return;
    }
    
    arrayremovevalue( a, self, 0 );
}

// Namespace util
// Params 1
// Checksum 0xf2ab6fab, Offset: 0x20b0
// Size: 0xe2
function clean_deleted( &array )
{
    done = 0;
    
    while ( !done && array.size > 0 )
    {
        done = 1;
        
        foreach ( key, val in array )
        {
            if ( !isdefined( val ) )
            {
                arrayremoveindex( array, key, 0 );
                done = 0;
                break;
            }
        }
    }
}

// Namespace util
// Params 0
// Checksum 0xa43fe45a, Offset: 0x21a0
// Size: 0xd4
function get_eye()
{
    if ( sessionmodeiscampaigngame() )
    {
        if ( self isplayer() )
        {
            linked_ent = self getlinkedent();
            
            if ( isdefined( linked_ent ) && getdvarint( "cg_cameraUseTagCamera" ) > 0 )
            {
                camera = linked_ent gettagorigin( "tag_camera" );
                
                if ( isdefined( camera ) )
                {
                    return camera;
                }
            }
        }
    }
    
    pos = self geteye();
    return pos;
}

// Namespace util
// Params 0
// Checksum 0x39e2d8e4, Offset: 0x2280
// Size: 0xa8
function spawn_player_arms()
{
    arms = spawn( self getlocalclientnumber(), self.origin + ( 0, 0, -1000 ), "script_model" );
    
    if ( isdefined( level.player_viewmodel ) )
    {
        arms setmodel( level.player_viewmodel );
    }
    else
    {
        arms setmodel( "c_usa_cia_masonjr_viewhands" );
    }
    
    return arms;
}

// Namespace util
// Params 7
// Checksum 0x8f83e1e6, Offset: 0x2330
// Size: 0x142
function lerp_dvar( str_dvar, n_start_val, n_end_val, n_lerp_time, b_saved_dvar, b_client_dvar, n_client )
{
    if ( !isdefined( n_client ) )
    {
        n_client = 0;
    }
    
    if ( !isdefined( n_start_val ) )
    {
        n_start_val = getdvarfloat( str_dvar );
    }
    
    s_timer = new_timer();
    
    do
    {
        n_time_delta = s_timer timer_wait( 0.01666 );
        n_curr_val = lerpfloat( n_start_val, n_end_val, n_time_delta / n_lerp_time );
        
        if ( isdefined( b_saved_dvar ) && b_saved_dvar )
        {
            setsaveddvar( str_dvar, n_curr_val );
            continue;
        }
        
        setdvar( str_dvar, n_curr_val );
    }
    while ( n_time_delta < n_lerp_time );
}

// Namespace util
// Params 1
// Checksum 0xa92f97e5, Offset: 0x2480
// Size: 0x1e, Type: bool
function is_valid_type_for_callback( type )
{
    switch ( type )
    {
        case "NA":
        case "actor":
        case "general":
        case "helicopter":
        case "missile":
        case "plane":
        case "player":
        case "scriptmover":
        case "trigger":
        case "turret":
        case "vehicle":
            return true;
        default:
            return false;
    }
}

// Namespace util
// Params 2
// Checksum 0xa83a3ff9, Offset: 0x2510
// Size: 0xa4
function wait_till_not_touching( e_to_check, e_to_touch )
{
    assert( isdefined( e_to_check ), "<dev string:x10a>" );
    assert( isdefined( e_to_touch ), "<dev string:x148>" );
    e_to_check endon( #"entityshutdown" );
    e_to_touch endon( #"entityshutdown" );
    
    while ( e_to_check istouching( e_to_touch ) )
    {
        wait 0.05;
    }
}

/#

    // Namespace util
    // Params 1
    // Checksum 0xc17cbce5, Offset: 0x25c0
    // Size: 0x34, Type: dev
    function error( message )
    {
        println( "<dev string:x186>", message );
        wait 0.05;
    }

#/

// Namespace util
// Params 2
// Checksum 0x1bd5b5e, Offset: 0x2600
// Size: 0xd8
function register_system( ssysname, cbfunc )
{
    if ( !isdefined( level._systemstates ) )
    {
        level._systemstates = [];
    }
    
    if ( level._systemstates.size >= 32 )
    {
        /#
            error( "<dev string:x194>" );
        #/
        
        return;
    }
    
    if ( isdefined( level._systemstates[ ssysname ] ) )
    {
        /#
            error( "<dev string:x1b5>" + ssysname );
        #/
        
        return;
    }
    
    level._systemstates[ ssysname ] = spawnstruct();
    level._systemstates[ ssysname ].callback = cbfunc;
}

// Namespace util
// Params 7
// Checksum 0x6f8a68ac, Offset: 0x26e0
// Size: 0x48
function field_set_lighting_ent( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level.light_entity = self;
}

// Namespace util
// Params 7
// Checksum 0x372d0d26, Offset: 0x2730
// Size: 0x3c
function field_use_lighting_ent( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    
}

// Namespace util
// Params 1
// Checksum 0x5fcf7e7, Offset: 0x2778
// Size: 0x3c
function waittill_dobj( localclientnum )
{
    while ( isdefined( self ) && !self hasdobj( localclientnum ) )
    {
        wait 0.016;
    }
}

// Namespace util
// Params 4
// Checksum 0xb4e33953, Offset: 0x27c0
// Size: 0x122
function server_wait( localclientnum, seconds, waitbetweenchecks, level_endon )
{
    if ( isdefined( level_endon ) )
    {
        level endon( level_endon );
    }
    
    if ( level.isdemoplaying && seconds != 0 )
    {
        if ( !isdefined( waitbetweenchecks ) )
        {
            waitbetweenchecks = 0.2;
        }
        
        waitcompletedsuccessfully = 0;
        starttime = level.servertime;
        lasttime = starttime;
        endtime = starttime + seconds * 1000;
        
        while ( level.servertime < endtime && level.servertime >= lasttime )
        {
            lasttime = level.servertime;
            wait waitbetweenchecks;
        }
        
        if ( lasttime < level.servertime )
        {
            waitcompletedsuccessfully = 1;
        }
    }
    else
    {
        wait seconds;
        waitcompletedsuccessfully = 1;
    }
    
    return waitcompletedsuccessfully;
}

// Namespace util
// Params 2
// Checksum 0xcd5f35c1, Offset: 0x28f0
// Size: 0x14c, Type: bool
function friend_not_foe( localclientindex, predicted )
{
    player = getnonpredictedlocalplayer( localclientindex );
    
    if ( isdefined( player ) && isdefined( player.team ) && ( isdefined( predicted ) && predicted || player.team == "spectator" ) )
    {
        player = getlocalplayer( localclientindex );
    }
    
    if ( isdefined( player ) && isdefined( player.team ) )
    {
        team = player.team;
        
        if ( team == "free" )
        {
            owner = self getowner( localclientindex );
            
            if ( isdefined( owner ) && owner == player )
            {
                return true;
            }
        }
        else if ( self.team == team )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace util
// Params 3
// Checksum 0x4ec08c2e, Offset: 0x2a48
// Size: 0xe4, Type: bool
function friend_not_foe_team( localclientindex, team, predicted )
{
    player = getnonpredictedlocalplayer( localclientindex );
    
    if ( isdefined( player ) && isdefined( player.team ) && ( isdefined( predicted ) && predicted || player.team == "spectator" ) )
    {
        player = getlocalplayer( localclientindex );
    }
    
    if ( isdefined( player ) && isdefined( player.team ) )
    {
        if ( player.team == team )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace util
// Params 1
// Checksum 0xee926cb8, Offset: 0x2b38
// Size: 0x9c, Type: bool
function isenemyplayer( player )
{
    assert( isdefined( player ) );
    
    if ( !player isplayer() )
    {
        return false;
    }
    
    if ( player.team != "free" )
    {
        if ( player.team == self.team )
        {
            return false;
        }
    }
    else if ( player == self )
    {
        return false;
    }
    
    return true;
}

// Namespace util
// Params 1
// Checksum 0x85f8153f, Offset: 0x2be0
// Size: 0x4e, Type: bool
function is_player_view_linked_to_entity( localclientnum )
{
    if ( self isdriving( localclientnum ) )
    {
        return true;
    }
    
    if ( self islocalplayerweaponviewonlylinked() )
    {
        return true;
    }
    
    return false;
}

// Namespace util
// Params 0
// Checksum 0x1242c61b, Offset: 0x2c38
// Size: 0xd4
function init_utility()
{
    level.isdemoplaying = isdemoplaying();
    level.localplayers = [];
    level.numgametypereservedobjectives = [];
    level.releasedobjectives = [];
    maxlocalclients = getmaxlocalclients();
    
    for ( localclientnum = 0; localclientnum < maxlocalclients ; localclientnum++ )
    {
        level.releasedobjectives[ localclientnum ] = [];
        level.numgametypereservedobjectives[ localclientnum ] = 0;
    }
    
    waitforclient( 0 );
    level.localplayers = getlocalplayers();
}

// Namespace util
// Params 4
// Checksum 0x7b19bc71, Offset: 0x2d18
// Size: 0xa2, Type: bool
function within_fov( start_origin, start_angles, end_origin, fov )
{
    normal = vectornormalize( end_origin - start_origin );
    forward = anglestoforward( start_angles );
    dot = vectordot( forward, normal );
    return dot >= fov;
}

// Namespace util
// Params 0
// Checksum 0x3b2e7eb4, Offset: 0x2dc8
// Size: 0x12
function is_mature()
{
    return ismaturecontentenabled();
}

// Namespace util
// Params 0
// Checksum 0xc7f32cc1, Offset: 0x2de8
// Size: 0x36, Type: bool
function is_gib_restricted_build()
{
    if ( !( ismaturecontentenabled() && isshowgibsenabled() ) )
    {
        return true;
    }
    
    return false;
}

// Namespace util
// Params 2
// Checksum 0xb9b641e8, Offset: 0x2e28
// Size: 0xd8
function registersystem( ssysname, cbfunc )
{
    if ( !isdefined( level._systemstates ) )
    {
        level._systemstates = [];
    }
    
    if ( level._systemstates.size >= 32 )
    {
        /#
            error( "<dev string:x194>" );
        #/
        
        return;
    }
    
    if ( isdefined( level._systemstates[ ssysname ] ) )
    {
        /#
            error( "<dev string:x1b5>" + ssysname );
        #/
        
        return;
    }
    
    level._systemstates[ ssysname ] = spawnstruct();
    level._systemstates[ ssysname ].callback = cbfunc;
}

// Namespace util
// Params 0
// Checksum 0xe485bd4f, Offset: 0x2f08
// Size: 0x4c
function getstatstablename()
{
    if ( sessionmodeiscampaigngame() )
    {
        return "gamedata/stats/cp/cp_statstable.csv";
    }
    
    if ( sessionmodeiszombiesgame() )
    {
        return "gamedata/stats/zm/zm_statstable.csv";
    }
    
    return "gamedata/stats/mp/mp_statstable.csv";
}

// Namespace util
// Params 2
// Checksum 0xd377b04, Offset: 0x2f60
// Size: 0x62
function add_trigger_to_ent( ent, trig )
{
    if ( !isdefined( ent._triggers ) )
    {
        ent._triggers = [];
    }
    
    ent._triggers[ trig getentitynumber() ] = 1;
}

// Namespace util
// Params 2
// Checksum 0x601e8a9c, Offset: 0x2fd0
// Size: 0x82
function remove_trigger_from_ent( ent, trig )
{
    if ( !isdefined( ent._triggers ) )
    {
        return;
    }
    
    if ( !isdefined( ent._triggers[ trig getentitynumber() ] ) )
    {
        return;
    }
    
    ent._triggers[ trig getentitynumber() ] = 0;
}

// Namespace util
// Params 1
// Checksum 0x54cc1c39, Offset: 0x3060
// Size: 0x70, Type: bool
function ent_already_in_trigger( trig )
{
    if ( !isdefined( self._triggers ) )
    {
        return false;
    }
    
    if ( !isdefined( self._triggers[ trig getentitynumber() ] ) )
    {
        return false;
    }
    
    if ( !self._triggers[ trig getentitynumber() ] )
    {
        return false;
    }
    
    return true;
}

// Namespace util
// Params 3
// Checksum 0xf23f481, Offset: 0x30d8
// Size: 0xfc
function trigger_thread( ent, on_enter_payload, on_exit_payload )
{
    ent endon( #"entityshutdown" );
    
    if ( ent ent_already_in_trigger( self ) )
    {
        return;
    }
    
    add_trigger_to_ent( ent, self );
    
    if ( isdefined( on_enter_payload ) )
    {
        [[ on_enter_payload ]]( ent );
    }
    
    while ( isdefined( ent ) && ent istouching( self ) )
    {
        wait 0.016;
    }
    
    if ( isdefined( ent ) && isdefined( on_exit_payload ) )
    {
        [[ on_exit_payload ]]( ent );
    }
    
    if ( isdefined( ent ) )
    {
        remove_trigger_from_ent( ent, self );
    }
}

// Namespace util
// Params 3
// Checksum 0x79da31b8, Offset: 0x31e0
// Size: 0xfc
function local_player_trigger_thread_always_exit( ent, on_enter_payload, on_exit_payload )
{
    if ( ent ent_already_in_trigger( self ) )
    {
        return;
    }
    
    add_trigger_to_ent( ent, self );
    
    if ( isdefined( on_enter_payload ) )
    {
        [[ on_enter_payload ]]( ent );
    }
    
    while ( isdefined( ent ) && ent istouching( self ) && ent issplitscreenhost() )
    {
        wait 0.016;
    }
    
    if ( isdefined( on_exit_payload ) )
    {
        [[ on_exit_payload ]]( ent );
    }
    
    if ( isdefined( ent ) )
    {
        remove_trigger_from_ent( ent, self );
    }
}

// Namespace util
// Params 7
// Checksum 0x168448bf, Offset: 0x32e8
// Size: 0x94
function local_player_entity_thread( localclientnum, entity, func, arg1, arg2, arg3, arg4 )
{
    entity endon( #"entityshutdown" );
    entity waittill_dobj( localclientnum );
    single_thread( entity, func, localclientnum, arg1, arg2, arg3, arg4 );
}

// Namespace util
// Params 6
// Checksum 0x6e8b7f10, Offset: 0x3388
// Size: 0xae
function local_players_entity_thread( entity, func, arg1, arg2, arg3, arg4 )
{
    players = level.localplayers;
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] thread local_player_entity_thread( i, entity, func, arg1, arg2, arg3, arg4 );
    }
}

/#

    // Namespace util
    // Params 4
    // Checksum 0xca7f475b, Offset: 0x3440
    // Size: 0xac, Type: dev
    function debug_line( from, to, color, time )
    {
        level.debug_line = getdvarint( "<dev string:x1dd>", 0 );
        
        if ( isdefined( level.debug_line ) && level.debug_line == 1 )
        {
            if ( !isdefined( time ) )
            {
                time = 1000;
            }
            
            line( from, to, color, 1, 1, time );
        }
    }

    // Namespace util
    // Params 3
    // Checksum 0x36a2d4d9, Offset: 0x34f8
    // Size: 0xac, Type: dev
    function debug_star( origin, color, time )
    {
        level.debug_star = getdvarint( "<dev string:x1ec>", 0 );
        
        if ( isdefined( level.debug_star ) && level.debug_star == 1 )
        {
            if ( !isdefined( time ) )
            {
                time = 1000;
            }
            
            if ( !isdefined( color ) )
            {
                color = ( 1, 1, 1 );
            }
            
            debugstar( origin, time, color );
        }
    }

#/

// Namespace util
// Params 0
// Checksum 0xe56e953f, Offset: 0x35b0
// Size: 0x30
function servertime()
{
    for ( ;; )
    {
        level.servertime = getservertime( 0 );
        wait 0.016;
    }
}

// Namespace util
// Params 1
// Checksum 0xb7755a33, Offset: 0x35e8
// Size: 0x110
function getnextobjid( localclientnum )
{
    nextid = 0;
    
    if ( level.releasedobjectives[ localclientnum ].size > 0 )
    {
        nextid = level.releasedobjectives[ localclientnum ][ level.releasedobjectives[ localclientnum ].size - 1 ];
        level.releasedobjectives[ localclientnum ][ level.releasedobjectives[ localclientnum ].size - 1 ] = undefined;
    }
    else
    {
        nextid = level.numgametypereservedobjectives[ localclientnum ];
        level.numgametypereservedobjectives[ localclientnum ]++;
    }
    
    /#
        if ( nextid > 31 )
        {
            println( "<dev string:x1fb>" );
        }
        
        assert( nextid < 32 );
    #/
    
    if ( nextid > 31 )
    {
        nextid = 31;
    }
    
    return nextid;
}

// Namespace util
// Params 2
// Checksum 0x8eab1241, Offset: 0x3700
// Size: 0xb0
function releaseobjid( localclientnum, objid )
{
    assert( objid < level.numgametypereservedobjectives[ localclientnum ] );
    
    for ( i = 0; i < level.releasedobjectives[ localclientnum ].size ; i++ )
    {
        if ( objid == level.releasedobjectives[ localclientnum ][ i ] )
        {
            return;
        }
    }
    
    level.releasedobjectives[ localclientnum ][ level.releasedobjectives[ localclientnum ].size ] = objid;
}

// Namespace util
// Params 1
// Checksum 0xe087cd68, Offset: 0x37b8
// Size: 0x2e
function get_next_safehouse( str_next_map )
{
    switch ( str_next_map )
    {
        case "cp_mi_sing_biodomes":
        case "cp_mi_sing_blackstation":
        case "cp_mi_sing_sgen":
            return "cp_sh_singapore";
        case "cp_mi_cairo_aquifer":
        case "cp_mi_cairo_infection":
        case "cp_mi_cairo_lotus":
            return "cp_sh_cairo";
        default:
            return "cp_sh_mobile";
    }
}

// Namespace util
// Params 1
// Checksum 0xfdd175cb, Offset: 0x3830
// Size: 0x5a, Type: bool
function is_safehouse( str_next_map )
{
    if ( !isdefined( str_next_map ) )
    {
        str_next_map = tolower( getdvarstring( "mapname" ) );
    }
    
    switch ( str_next_map )
    {
        case "cp_sh_cairo":
        case "cp_sh_mobile":
        case "cp_sh_singapore":
            return true;
        default:
            return false;
    }
}

/#

    // Namespace util
    // Params 1
    // Checksum 0x98c7a806, Offset: 0x38c0
    // Size: 0x120, Type: dev
    function button_held_think( which_button )
    {
        self endon( #"disconnect" );
        
        if ( !isdefined( self._holding_button ) )
        {
            self._holding_button = [];
        }
        
        self._holding_button[ which_button ] = 0;
        time_started = 0;
        
        while ( true )
        {
            if ( self._holding_button[ which_button ] )
            {
                if ( !self [[ level._button_funcs[ which_button ] ]]() )
                {
                    self._holding_button[ which_button ] = 0;
                }
            }
            else if ( self [[ level._button_funcs[ which_button ] ]]() )
            {
                if ( time_started == 0 )
                {
                    time_started = gettime();
                }
                
                if ( gettime() - time_started > 250 )
                {
                    self._holding_button[ which_button ] = 1;
                }
            }
            else if ( time_started != 0 )
            {
                time_started = 0;
            }
            
            wait 0.016;
        }
    }

    // Namespace util
    // Params 0
    // Checksum 0xbcdc8fe3, Offset: 0x39e8
    // Size: 0x52, Type: dev
    function init_button_wrappers()
    {
        if ( !isdefined( level._button_funcs ) )
        {
            level._button_funcs[ 4 ] = &up_button_pressed;
            level._button_funcs[ 5 ] = &down_button_pressed;
        }
    }

    // Namespace util
    // Params 0
    // Checksum 0x28f1a770, Offset: 0x3a48
    // Size: 0x5e, Type: dev
    function up_button_held()
    {
        init_button_wrappers();
        
        if ( !isdefined( self._up_button_think_threaded ) )
        {
            self thread button_held_think( 4 );
            self._up_button_think_threaded = 1;
        }
        
        return self._holding_button[ 4 ];
    }

    // Namespace util
    // Params 0
    // Checksum 0xce566df5, Offset: 0x3ab0
    // Size: 0x5e, Type: dev
    function down_button_held()
    {
        init_button_wrappers();
        
        if ( !isdefined( self._down_button_think_threaded ) )
        {
            self thread button_held_think( 5 );
            self._down_button_think_threaded = 1;
        }
        
        return self._holding_button[ 5 ];
    }

    // Namespace util
    // Params 0
    // Checksum 0xa274f376, Offset: 0x3b18
    // Size: 0x44, Type: dev
    function up_button_pressed()
    {
        return self buttonpressed( "<dev string:x226>" ) || self buttonpressed( "<dev string:x22e>" );
    }

    // Namespace util
    // Params 0
    // Checksum 0xc77ff59, Offset: 0x3b68
    // Size: 0x2c, Type: dev
    function waittill_up_button_pressed()
    {
        while ( !self up_button_pressed() )
        {
            wait 0.05;
        }
    }

    // Namespace util
    // Params 0
    // Checksum 0xb61215b3, Offset: 0x3ba0
    // Size: 0x44, Type: dev
    function down_button_pressed()
    {
        return self buttonpressed( "<dev string:x236>" ) || self buttonpressed( "<dev string:x240>" );
    }

    // Namespace util
    // Params 0
    // Checksum 0xe3221dd8, Offset: 0x3bf0
    // Size: 0x2c, Type: dev
    function waittill_down_button_pressed()
    {
        while ( !self down_button_pressed() )
        {
            wait 0.05;
        }
    }

#/
