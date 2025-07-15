#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/system_shared;

#namespace doors;

// Namespace doors
// Method(s) 24 Total 24
class cdoor
{

    // Namespace cdoor
    // Params 0
    // Checksum 0x9f3f54b6, Offset: 0x230
    // Size: 0x34
    function constructor()
    {
        self.m_n_trigger_height = 80;
        self.m_override_swing_angle = undefined;
        self.m_door_open_delay_time = 0;
        self.m_e_trigger_player = undefined;
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0x8da9aea7, Offset: 0x270
    // Size: 0x2c
    function destructor()
    {
        if ( isdefined( self.m_e_trigger ) )
        {
            self.m_e_trigger delete();
        }
    }

    // Namespace cdoor
    // Params 1
    // Checksum 0x4509ff20, Offset: 0x1958
    // Size: 0x18
    function setdooropendelay( delay_time )
    {
        self.m_door_open_delay_time = delay_time;
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0x4659aa50, Offset: 0x1910
    // Size: 0x40
    function getswingangle()
    {
        if ( isdefined( self.m_override_swing_angle ) )
        {
            angle = self.m_override_swing_angle;
        }
        else
        {
            angle = self.m_s_bundle.door_swing_angle;
        }
        
        return angle;
    }

    // Namespace cdoor
    // Params 1
    // Checksum 0x743ee8a4, Offset: 0x18f0
    // Size: 0x18
    function set_swing_angle( angle )
    {
        self.m_override_swing_angle = angle;
    }

    // Namespace cdoor
    // Params 3
    // Checksum 0x6da45de7, Offset: 0x17d0
    // Size: 0x118
    function calculate_offset_position( v_origin, v_angles, v_offset )
    {
        v_pos = v_origin;
        
        if ( v_offset[ 0 ] )
        {
            v_side = anglestoforward( v_angles );
            v_pos += v_offset[ 0 ] * v_side;
        }
        
        if ( v_offset[ 1 ] )
        {
            v_dir = anglestoright( v_angles );
            v_pos += v_offset[ 1 ] * v_dir;
        }
        
        if ( v_offset[ 2 ] )
        {
            v_up = anglestoup( v_angles );
            v_pos += v_offset[ 2 ] * v_up;
        }
        
        return v_pos;
    }

    // Namespace cdoor
    // Params 1
    // Checksum 0x53ebb206, Offset: 0x17b0
    // Size: 0x18
    function set_door_paths( n_door_connect_paths )
    {
        self.m_n_door_connect_paths = n_door_connect_paths;
    }

    // Namespace cdoor
    // Params 2
    // Checksum 0x483a0bae, Offset: 0x16e8
    // Size: 0xbc
    function init_movement( n_slide_up, n_slide_amount )
    {
        if ( self.m_s_bundle.door_open_method == "slide" )
        {
            if ( n_slide_up )
            {
                v_offset = ( 0, 0, n_slide_amount );
            }
            else
            {
                v_offset = ( n_slide_amount, 0, 0 );
            }
            
            self.m_v_open_pos = calculate_offset_position( self.m_e_door.origin, self.m_e_door.angles, v_offset );
            self.m_v_close_pos = self.m_e_door.origin;
        }
    }

    // Namespace cdoor
    // Params 1
    // Checksum 0x9be49c60, Offset: 0x15e0
    // Size: 0xfa
    function set_script_flags( b_set )
    {
        if ( isdefined( self.m_str_script_flag ) )
        {
            a_flags = strtok( self.m_str_script_flag, "," );
            
            foreach ( str_flag in a_flags )
            {
                if ( b_set )
                {
                    level flag::set( str_flag );
                    continue;
                }
                
                level flag::clear( str_flag );
            }
        }
    }

    // Namespace cdoor
    // Params 2
    // Checksum 0xbb002632, Offset: 0x13c8
    // Size: 0x20c
    function init_trigger( v_offset, n_radius )
    {
        v_pos = calculate_offset_position( self.m_e_door.origin, self.m_e_door.angles, v_offset );
        v_pos = ( v_pos[ 0 ], v_pos[ 1 ], v_pos[ 2 ] + 50 );
        
        if ( isdefined( self.m_s_bundle.door_trigger_at_target ) && self.m_s_bundle.door_trigger_at_target )
        {
            e_target = getent( self.m_str_target, "targetname" );
            
            if ( isdefined( e_target ) )
            {
                v_pos = e_target.origin;
            }
        }
        
        if ( isdefined( self.m_s_bundle.door_use_trigger ) && self.m_s_bundle.door_use_trigger )
        {
            self.m_e_trigger = spawn( "trigger_radius_use", v_pos, 0, n_radius, self.m_n_trigger_height );
            self.m_e_trigger triggerignoreteam();
            self.m_e_trigger setvisibletoall();
            self.m_e_trigger setteamfortrigger( "none" );
            self.m_e_trigger usetriggerrequirelookat();
            self.m_e_trigger setcursorhint( "HINT_NOICON" );
            return;
        }
        
        self.m_e_trigger = spawn( "trigger_radius", v_pos, 0, n_radius, self.m_n_trigger_height );
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0xad8cdf04, Offset: 0x1240
    // Size: 0x180
    function process_hint_trigger_message()
    {
        str_hint = "";
        
        if ( isdefined( self.m_s_bundle.door_trigger_at_target ) && self.m_s_bundle.door_trigger_at_target )
        {
            str_hint = "This door is controlled elsewhere";
        }
        else if ( self.m_s_bundle.door_unlock_method == "hack" )
        {
            str_hint = "This door is electronically locked";
        }
        
        while ( true )
        {
            self.m_e_hint_trigger sethintstring( str_hint );
            
            if ( isdefined( self.m_s_bundle.door_trigger_at_target ) && self.m_s_bundle.door_trigger_at_target )
            {
                self flag::wait_till( "open" );
            }
            else
            {
                self flag::wait_till_clear( "locked" );
            }
            
            self.m_e_hint_trigger sethintstring( "" );
            
            if ( isdefined( self.m_s_bundle.door_trigger_at_target ) && self.m_s_bundle.door_trigger_at_target )
            {
                self flag::wait_till_clear( "open" );
                continue;
            }
            
            self flag::wait_till( "locked" );
        }
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0x27951f73, Offset: 0x1000
    // Size: 0x238
    function run_lock_fx()
    {
        if ( !isdefined( self.m_s_bundle.door_locked_fx ) && !isdefined( self.m_s_bundle.door_unlocked_fx ) )
        {
            return;
        }
        
        e_fx = undefined;
        v_pos = get_hack_pos();
        v_angles = get_hack_angles();
        
        while ( true )
        {
            self flag::wait_till( "locked" );
            
            if ( isdefined( e_fx ) )
            {
                e_fx delete();
                e_fx = undefined;
            }
            
            if ( isdefined( self.m_s_bundle.door_locked_fx ) )
            {
                e_fx = spawn( "script_model", v_pos );
                e_fx setmodel( "tag_origin" );
                e_fx.angles = v_angles;
                playfxontag( self.m_s_bundle.door_locked_fx, e_fx, "tag_origin" );
            }
            
            self flag::wait_till_clear( "locked" );
            
            if ( isdefined( e_fx ) )
            {
                e_fx delete();
                e_fx = undefined;
            }
            
            if ( isdefined( self.m_s_bundle.door_unlocked_fx ) )
            {
                e_fx = spawn( "script_model", v_pos );
                e_fx setmodel( "tag_origin" );
                e_fx.angles = v_angles;
                playfxontag( self.m_s_bundle.door_unlocked_fx, e_fx, "tag_origin" );
            }
        }
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0x80e55f01, Offset: 0xed0
    // Size: 0x122
    function update_use_message()
    {
        if ( !( isdefined( self.m_s_bundle.door_use_trigger ) && self.m_s_bundle.door_use_trigger ) )
        {
            return;
        }
        
        if ( self flag::get( "open" ) )
        {
            if ( !( isdefined( self.m_s_bundle.door_closes ) && self.m_s_bundle.door_closes ) )
            {
            }
            
            return;
        }
        
        if ( isdefined( self.m_s_bundle.door_open_message ) && self.m_s_bundle.door_open_message != "" )
        {
            return;
        }
        
        if ( isdefined( self.m_s_bundle.door_use_hold ) && self.m_s_bundle.door_use_hold )
        {
            return;
        }
        
        if ( self.m_s_bundle.door_unlock_method == "key" )
        {
            return;
        }
        
        if ( self flag::get( "locked" ) )
        {
        }
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0xd665cd3, Offset: 0xb70
    // Size: 0x354
    function open_internal()
    {
        self flag::set( "animating" );
        self.m_e_door notify( #"door_opening" );
        
        if ( isdefined( self.m_s_bundle.door_start_sound ) && self.m_s_bundle.door_start_sound != "" )
        {
            self.m_e_door playsound( self.m_s_bundle.door_start_sound );
        }
        
        if ( isdefined( self.m_s_bundle.b_loop_sound ) && self.m_s_bundle.b_loop_sound )
        {
            sndent = spawn( "script_origin", self.m_e_door.origin );
            sndent linkto( self.m_e_door );
            sndent playloopsound( self.m_s_bundle.door_loop_sound, 1 );
        }
        
        if ( self.m_s_bundle.door_open_method == "slide" )
        {
            self.m_e_door moveto( self.m_v_open_pos, self.m_s_bundle.door_open_time );
        }
        else if ( self.m_s_bundle.door_open_method == "swing" )
        {
            angle = getswingangle();
            v_angle = ( self.m_e_door.angles[ 0 ], self.m_e_door.angles[ 1 ] + angle, self.m_e_door.angles[ 2 ] );
            self.m_e_door rotateto( v_angle, self.m_s_bundle.door_open_time );
        }
        
        if ( isdefined( self.m_n_door_connect_paths ) && self.m_n_door_connect_paths )
        {
            self.m_e_door connectpaths();
        }
        
        wait self.m_s_bundle.door_open_time;
        
        if ( isdefined( self.m_s_bundle.b_loop_sound ) && self.m_s_bundle.b_loop_sound )
        {
            sndent delete();
        }
        
        if ( isdefined( self.m_s_bundle.door_stop_sound ) && self.m_s_bundle.door_stop_sound != "" )
        {
            self.m_e_door playsound( self.m_s_bundle.door_stop_sound );
        }
        
        flag::clear( "animating" );
        set_script_flags( 1 );
        update_use_message();
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0xffd4001c, Offset: 0xb40
    // Size: 0x24
    function close()
    {
        self flag::clear( "open" );
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0x28aefd97, Offset: 0x7d8
    // Size: 0x35c
    function close_internal()
    {
        self flag::clear( "open" );
        set_script_flags( 0 );
        self flag::set( "animating" );
        
        if ( isdefined( self.m_s_bundle.b_loop_sound ) && self.m_s_bundle.b_loop_sound )
        {
            self.m_e_door playsound( self.m_s_bundle.door_start_sound );
            sndent = spawn( "script_origin", self.m_e_door.origin );
            sndent linkto( self.m_e_door );
            sndent playloopsound( self.m_s_bundle.door_loop_sound, 1 );
        }
        else if ( isdefined( self.m_s_bundle.door_stop_sound ) && self.m_s_bundle.door_stop_sound != "" )
        {
            self.m_e_door playsound( self.m_s_bundle.door_stop_sound );
        }
        
        if ( self.m_s_bundle.door_open_method == "slide" )
        {
            self.m_e_door moveto( self.m_v_close_pos, self.m_s_bundle.door_open_time );
        }
        else if ( self.m_s_bundle.door_open_method == "swing" )
        {
            angle = getswingangle();
            v_angle = ( self.m_e_door.angles[ 0 ], self.m_e_door.angles[ 1 ] - angle, self.m_e_door.angles[ 2 ] );
            self.m_e_door rotateto( v_angle, self.m_s_bundle.door_open_time );
        }
        
        wait self.m_s_bundle.door_open_time;
        
        if ( isdefined( self.m_n_door_connect_paths ) && self.m_n_door_connect_paths )
        {
            self.m_e_door disconnectpaths();
        }
        
        if ( isdefined( self.m_s_bundle.b_loop_sound ) && self.m_s_bundle.b_loop_sound )
        {
            sndent delete();
            self.m_e_door playsound( self.m_s_bundle.door_stop_sound );
        }
        
        flag::clear( "animating" );
        update_use_message();
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0x1735149a, Offset: 0x7a8
    // Size: 0x24
    function open()
    {
        self flag::set( "open" );
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0x1aac9c86, Offset: 0x748
    // Size: 0x58
    function delete_door()
    {
        self.m_e_door delete();
        self.m_e_door = undefined;
        
        if ( isdefined( self.m_e_trigger ) )
        {
            self.m_e_trigger delete();
            self.m_e_trigger = undefined;
        }
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0x2a5369bb, Offset: 0x718
    // Size: 0x24
    function unlock()
    {
        self flag::clear( "locked" );
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0xb234477b, Offset: 0x6d8
    // Size: 0x34
    function lock()
    {
        self flag::set( "locked" );
        update_use_message();
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0xef60c3c9, Offset: 0x4e0
    // Size: 0x1ec
    function init_hint_trigger()
    {
        if ( self.m_s_bundle.door_unlock_method == "default" && !( isdefined( self.m_s_bundle.door_trigger_at_target ) && self.m_s_bundle.door_trigger_at_target ) )
        {
            return;
        }
        
        if ( self.m_s_bundle.door_unlock_method == "key" )
        {
            return;
        }
        
        v_offset = self.m_s_bundle.v_trigger_offset;
        n_radius = self.m_s_bundle.door_trigger_radius;
        v_pos = calculate_offset_position( self.m_e_door.origin, self.m_e_door.angles, v_offset );
        v_pos = ( v_pos[ 0 ], v_pos[ 1 ], v_pos[ 2 ] + 50 );
        e_trig = spawn( "trigger_radius_use", v_pos, 0, n_radius, self.m_n_trigger_height );
        e_trig triggerignoreteam();
        e_trig setvisibletoall();
        e_trig setteamfortrigger( "none" );
        e_trig usetriggerrequirelookat();
        e_trig setcursorhint( "HINT_NOICON" );
        self.m_e_hint_trigger = e_trig;
        thread process_hint_trigger_message();
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0x57820e12, Offset: 0x460
    // Size: 0x74
    function get_hack_angles()
    {
        v_angles = self.m_e_door.angles;
        
        if ( isdefined( self.m_str_target ) )
        {
            e_target = getent( self.m_str_target, "targetname" );
            
            if ( isdefined( e_target ) )
            {
                return e_target.angles;
            }
        }
        
        return v_angles;
    }

    // Namespace cdoor
    // Params 0
    // Checksum 0x46e8e6c9, Offset: 0x370
    // Size: 0xe4
    function get_hack_pos()
    {
        v_trigger_offset = self.m_s_bundle.v_trigger_offset;
        v_pos = calculate_offset_position( self.m_e_door.origin, self.m_e_door.angles, v_trigger_offset );
        v_pos = ( v_pos[ 0 ], v_pos[ 1 ], v_pos[ 2 ] + 50 );
        
        if ( isdefined( self.m_str_target ) )
        {
            e_target = getent( self.m_str_target, "targetname" );
            
            if ( isdefined( e_target ) )
            {
                return e_target.origin;
            }
        }
        
        return v_pos;
    }

    // Namespace cdoor
    // Params 4
    // Checksum 0x69916ea7, Offset: 0x2a8
    // Size: 0xbc
    function init_xmodel( str_xmodel, connect_paths, v_origin, v_angles )
    {
        if ( !isdefined( str_xmodel ) )
        {
            str_xmodel = "script_origin";
        }
        
        self.m_e_door = spawn( "script_model", v_origin, 1 );
        self.m_e_door setmodel( str_xmodel );
        self.m_e_door.angles = v_angles;
        
        if ( connect_paths )
        {
            self.m_e_door disconnectpaths();
        }
    }

}

// Namespace doors
// Params 0, eflags: 0x2
// Checksum 0xf1df7e63, Offset: 0x1e28
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "doors", &__init__, undefined, undefined );
}

// Namespace doors
// Params 0
// Checksum 0x9ae5757f, Offset: 0x1e68
// Size: 0xda
function __init__()
{
    a_doors = struct::get_array( "scriptbundle_doors", "classname" );
    
    foreach ( s_instance in a_doors )
    {
        c_door = s_instance init();
        
        if ( isdefined( c_door ) )
        {
            s_instance.c_door = c_door;
        }
    }
}

// Namespace doors
// Params 0
// Checksum 0xbde7e972, Offset: 0x1f50
// Size: 0x5a
function init()
{
    if ( !isdefined( self.angles ) )
    {
        self.angles = ( 0, 0, 0 );
    }
    
    s_door_bundle = level.scriptbundles[ "doors" ][ self.scriptbundlename ];
    return setup_door_scriptbundle( s_door_bundle, self );
}

// Namespace doors
// Params 2
// Checksum 0xd682492c, Offset: 0x1fb8
// Size: 0x768
function setup_door_scriptbundle( s_door_bundle, s_door_instance )
{
    c_door = new cdoor();
    c_door flag::init( "locked", 0 );
    c_door flag::init( "open", 0 );
    c_door flag::init( "animating", 0 );
    c_door.m_s_bundle = s_door_bundle;
    c_door.m_str_targetname = s_door_instance.targetname;
    c_door.m_str_target = s_door_instance.target;
    c_door.m_str_script_flag = s_door_instance.script_flag;
    
    if ( c_door.m_s_bundle.door_unlock_method == "key" )
    {
        if ( isdefined( c_door.m_s_bundle.door_key_model ) )
        {
            level.door_key_model = c_door.m_s_bundle.door_key_model;
        }
        
        if ( isdefined( c_door.m_s_bundle.door_key_icon ) )
        {
            level.door_key_icon = c_door.m_s_bundle.door_key_icon;
        }
        
        if ( isdefined( c_door.m_s_bundle.door_key_fx ) )
        {
            level.door_key_fx = c_door.m_s_bundle.door_key_fx;
        }
    }
    
    if ( c_door.m_s_bundle.door_unlock_method == "hack" && !( isdefined( level.door_hack_precached ) && level.door_hack_precached ) )
    {
        level.door_hack_precached = 1;
    }
    
    str_door_xmodel = c_door.m_s_bundle.model;
    
    if ( isdefined( c_door.m_s_bundle.door_triggeroffsetx ) )
    {
        n_xoffset = c_door.m_s_bundle.door_triggeroffsetx;
    }
    else
    {
        n_xoffset = 0;
    }
    
    if ( isdefined( c_door.m_s_bundle.door_triggeroffsety ) )
    {
        n_yoffset = c_door.m_s_bundle.door_triggeroffsety;
    }
    else
    {
        n_yoffset = 0;
    }
    
    if ( isdefined( c_door.m_s_bundle.door_triggeroffsetz ) )
    {
        n_zoffset = c_door.m_s_bundle.door_triggeroffsetz;
    }
    else
    {
        n_zoffset = 0;
    }
    
    v_trigger_offset = ( n_xoffset, n_yoffset, n_zoffset );
    c_door.m_s_bundle.v_trigger_offset = v_trigger_offset;
    n_trigger_radius = c_door.m_s_bundle.door_trigger_radius;
    
    if ( isdefined( c_door.m_s_bundle.door_slide_horizontal ) && c_door.m_s_bundle.door_slide_horizontal )
    {
        n_slide_up = 0;
    }
    else
    {
        n_slide_up = 1;
    }
    
    n_open_time = c_door.m_s_bundle.door_open_time;
    n_slide_amount = c_door.m_s_bundle.door_slide_open_units;
    
    if ( !isdefined( c_door.m_s_bundle.door_swing_angle ) )
    {
        c_door.m_s_bundle.door_swing_angle = 0;
    }
    
    if ( isdefined( c_door.m_s_bundle.door_closes ) && c_door.m_s_bundle.door_closes )
    {
        n_door_closes = 1;
    }
    else
    {
        n_door_closes = 0;
    }
    
    if ( isdefined( c_door.m_s_bundle.door_connect_paths ) && c_door.m_s_bundle.door_connect_paths )
    {
        n_door_connect_paths = 1;
    }
    else
    {
        n_door_connect_paths = 0;
    }
    
    if ( isdefined( c_door.m_s_bundle.door_start_open ) && c_door.m_s_bundle.door_start_open )
    {
        c_door flag::set( "open" );
    }
    
    if ( isdefined( c_door.m_str_script_flag ) )
    {
        a_flags = strtok( c_door.m_str_script_flag, "," );
        
        foreach ( str_flag in a_flags )
        {
            level flag::init( str_flag );
        }
    }
    
    [[ c_door ]]->init_xmodel( str_door_xmodel, n_door_connect_paths, s_door_instance.origin, s_door_instance.angles );
    [[ c_door ]]->init_trigger( v_trigger_offset, n_trigger_radius, c_door.m_s_bundle );
    [[ c_door ]]->init_hint_trigger();
    thread [[ c_door ]]->run_lock_fx();
    [[ c_door ]]->init_movement( n_slide_up, n_slide_amount );
    
    if ( !isdefined( c_door.m_s_bundle.door_open_time ) )
    {
        c_door.m_s_bundle.door_open_time = 0.4;
    }
    
    [[ c_door ]]->set_door_paths( n_door_connect_paths );
    c_door.m_s_bundle.b_loop_sound = isdefined( c_door.m_s_bundle.door_loop_sound ) && c_door.m_s_bundle.door_loop_sound != "";
    level thread door_update( c_door );
    return c_door;
}

// Namespace doors
// Params 1
// Checksum 0x8243f2c9, Offset: 0x2728
// Size: 0x3c8
function door_open_update( c_door )
{
    str_unlock_method = "default";
    
    if ( isdefined( c_door.m_s_bundle.door_unlock_method ) )
    {
        str_unlock_method = c_door.m_s_bundle.door_unlock_method;
    }
    
    b_auto_close = isdefined( c_door.m_s_bundle.door_closes ) && c_door.m_s_bundle.door_closes && !( isdefined( c_door.m_s_bundle.door_use_trigger ) && c_door.m_s_bundle.door_use_trigger );
    b_hold_open = isdefined( c_door.m_s_bundle.door_use_hold ) && c_door.m_s_bundle.door_use_hold;
    b_manual_close = isdefined( c_door.m_s_bundle.door_closes ) && isdefined( c_door.m_s_bundle.door_use_trigger ) && c_door.m_s_bundle.door_use_trigger && c_door.m_s_bundle.door_closes;
    
    while ( true )
    {
        c_door.m_e_trigger waittill( #"trigger", e_who );
        c_door.m_e_trigger_player = e_who;
        
        if ( !c_door flag::get( "open" ) )
        {
            if ( !c_door flag::get( "locked" ) )
            {
                if ( b_hold_open || b_auto_close )
                {
                    [[ c_door ]]->open();
                    
                    if ( b_hold_open )
                    {
                        e_who player_freeze_in_place( 1 );
                        e_who disableweapons();
                        e_who disableoffhandweapons();
                    }
                    
                    door_wait_until_clear( c_door, e_who );
                    [[ c_door ]]->close();
                    
                    if ( b_hold_open )
                    {
                        wait 0.05;
                        c_door flag::wait_till_clear( "animating" );
                        e_who player_freeze_in_place( 0 );
                        e_who enableweapons();
                        e_who enableoffhandweapons();
                    }
                }
                else if ( str_unlock_method == "key" )
                {
                    if ( e_who player_has_key( "door" ) )
                    {
                        e_who player_take_key( "door" );
                        [[ c_door ]]->open();
                    }
                    else
                    {
                        iprintlnbold( "You need a key." );
                    }
                }
                else
                {
                    [[ c_door ]]->open();
                }
            }
            
            continue;
        }
        
        if ( b_manual_close )
        {
            [[ c_door ]]->close();
        }
    }
}

// Namespace doors
// Params 1
// Checksum 0xb03fb4df, Offset: 0x2af8
// Size: 0x272
function door_update( c_door )
{
    str_unlock_method = "default";
    
    if ( isdefined( c_door.m_s_bundle.door_unlock_method ) )
    {
        str_unlock_method = c_door.m_s_bundle.door_unlock_method;
    }
    
    if ( isdefined( c_door.m_s_bundle.door_locked ) && c_door.m_s_bundle.door_locked && str_unlock_method != "key" )
    {
        c_door flag::set( "locked" );
        
        if ( isdefined( c_door.m_str_targetname ) )
        {
            thread door_update_lock_scripted( c_door );
        }
    }
    
    thread door_open_update( c_door );
    [[ c_door ]]->update_use_message();
    
    while ( true )
    {
        if ( c_door flag::get( "locked" ) )
        {
            c_door flag::wait_till_clear( "locked" );
        }
        
        c_door flag::wait_till( "open" );
        
        if ( c_door.m_door_open_delay_time > 0 )
        {
            c_door.m_e_door notify( #"door_waiting_to_open", c_door.m_e_trigger_player );
            wait c_door.m_door_open_delay_time;
        }
        
        [[ c_door ]]->open_internal();
        c_door flag::wait_till_clear( "open" );
        [[ c_door ]]->close_internal();
        
        if ( !( isdefined( c_door.m_s_bundle.door_closes ) && c_door.m_s_bundle.door_closes ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    c_door.m_e_trigger delete();
    c_door.m_e_trigger = undefined;
}

// Namespace doors
// Params 1
// Checksum 0xd1a569cd, Offset: 0x2d78
// Size: 0x80
function door_update_lock_scripted( c_door )
{
    door_str = c_door.m_str_targetname;
    c_door.m_e_trigger.targetname = door_str + "_trig";
    
    while ( true )
    {
        c_door.m_e_trigger waittill( #"unlocked" );
        [[ c_door ]]->unlock();
    }
}

// Namespace doors
// Params 1
// Checksum 0xfe6c3b34, Offset: 0x2e00
// Size: 0x11c
function player_freeze_in_place( b_do_freeze )
{
    if ( !b_do_freeze )
    {
        if ( isdefined( self.freeze_origin ) )
        {
            self unlink();
            self.freeze_origin delete();
            self.freeze_origin = undefined;
        }
        
        return;
    }
    
    if ( !isdefined( self.freeze_origin ) )
    {
        self.freeze_origin = spawn( "script_model", self.origin );
        self.freeze_origin setmodel( "tag_origin" );
        self.freeze_origin.angles = self.angles;
        self playerlinktodelta( self.freeze_origin, "tag_origin", 1, 45, 45, 45, 45 );
    }
}

// Namespace doors
// Params 1
// Checksum 0xcd587d65, Offset: 0x2f28
// Size: 0xea
function trigger_wait_until_clear( c_door )
{
    self endon( #"death" );
    last_trigger_time = gettime();
    self.ents_in_trigger = 1;
    str_kill_trigger_notify = "trigger_now_clear";
    self thread trigger_check_for_ents_touching( str_kill_trigger_notify );
    
    while ( true )
    {
        time = gettime();
        
        if ( self.ents_in_trigger == 1 )
        {
            self.ents_in_trigger = 0;
            last_trigger_time = time;
        }
        
        dt = ( time - last_trigger_time ) / 1000;
        
        if ( dt >= 0.3 )
        {
            break;
        }
        
        wait 0.05;
    }
    
    self notify( str_kill_trigger_notify );
}

// Namespace doors
// Params 3
// Checksum 0x6954bd70, Offset: 0x3020
// Size: 0xf6
function door_wait_until_user_release( c_door, e_triggerer, str_kill_on_door_notify )
{
    if ( isdefined( str_kill_on_door_notify ) )
    {
        c_door endon( str_kill_on_door_notify );
    }
    
    wait 0.25;
    max_dist_sq = c_door.m_s_bundle.door_trigger_radius * c_door.m_s_bundle.door_trigger_radius;
    b_pressed = 1;
    n_dist = 0;
    
    do
    {
        wait 0.05;
        b_pressed = e_triggerer usebuttonpressed();
        n_dist = distancesquared( e_triggerer.origin, self.origin );
    }
    while ( b_pressed && n_dist < max_dist_sq );
}

// Namespace doors
// Params 2
// Checksum 0x4f1d9dc3, Offset: 0x3120
// Size: 0x214
function door_wait_until_clear( c_door, e_triggerer )
{
    e_trigger = c_door.m_e_trigger;
    e_temp_trigger = undefined;
    
    if ( isdefined( c_door.m_s_bundle.door_trigger_at_target ) && c_door.m_s_bundle.door_trigger_at_target )
    {
        e_door = c_door.m_e_door;
        v_trigger_offset = c_door.m_s_bundle.v_trigger_offset;
        v_pos = [[ c_door ]]->calculate_offset_position( e_door.origin, e_door.angles, v_trigger_offset );
        n_radius = c_door.m_s_bundle.door_trigger_radius;
        n_height = c_door.m_n_trigger_height;
        e_temp_trigger = spawn( "trigger_radius", v_pos, 0, n_radius, n_height );
        e_trigger = e_temp_trigger;
    }
    
    if ( isdefined( c_door.m_s_bundle.door_use_hold ) && isplayer( e_triggerer ) && c_door.m_s_bundle.door_use_hold )
    {
        c_door.m_e_trigger door_wait_until_user_release( c_door, e_triggerer );
    }
    
    e_trigger trigger_wait_until_clear( c_door );
    
    if ( isdefined( e_temp_trigger ) )
    {
        e_temp_trigger delete();
    }
}

// Namespace doors
// Params 1
// Checksum 0xee1affa2, Offset: 0x3340
// Size: 0x50
function trigger_check_for_ents_touching( str_kill_trigger_notify )
{
    self endon( #"death" );
    self endon( str_kill_trigger_notify );
    
    while ( true )
    {
        self waittill( #"trigger", e_who );
        self.ents_in_trigger = 1;
    }
}

// Namespace doors
// Params 1
// Checksum 0x517ba6bf, Offset: 0x3398
// Size: 0x90
function door_debug_line( v_origin )
{
    self endon( #"death" );
    
    while ( true )
    {
        v_start = v_origin;
        v_end = v_start + ( 0, 0, 1000 );
        v_col = ( 0, 0, 1 );
        
        /#
            line( v_start, v_end, ( 0, 0, 1 ) );
        #/
        
        wait 0.1;
    }
}

// Namespace doors
// Params 1
// Checksum 0xa3e29db3, Offset: 0x3430
// Size: 0x4e, Type: bool
function player_has_key( str_key_type )
{
    if ( !isdefined( self.collectible_keys ) )
    {
        return false;
    }
    
    if ( !isdefined( self.collectible_keys[ str_key_type ] ) )
    {
        return false;
    }
    
    return self.collectible_keys[ str_key_type ].num_keys > 0;
}

// Namespace doors
// Params 1
// Checksum 0xff21ef6d, Offset: 0x3488
// Size: 0xba
function player_take_key( str_key_type )
{
    if ( !player_has_key( str_key_type ) )
    {
        return;
    }
    
    self.collectible_keys[ str_key_type ].num_keys--;
    
    if ( self.collectible_keys[ str_key_type ].num_keys <= 0 && isdefined( self.collectible_keys[ str_key_type ].hudelem ) )
    {
        self.collectible_keys[ str_key_type ].hudelem destroy();
        self.collectible_keys[ str_key_type ].hudelem = undefined;
    }
}

// Namespace doors
// Params 0
// Checksum 0xe8f7b543, Offset: 0x3550
// Size: 0x40
function rotate_key_forever()
{
    self endon( #"death" );
    
    while ( true )
    {
        self rotateyaw( 180, 3 );
        wait 2.5;
    }
}

// Namespace doors
// Params 3
// Checksum 0x4a64825a, Offset: 0x3598
// Size: 0x174
function key_process_timeout( n_timeout_sec, e_trigger, e_model )
{
    e_trigger endon( #"death" );
    
    if ( n_timeout_sec < 5 )
    {
        n_timeout_sec = 5 + 1;
    }
    
    wait n_timeout_sec - 5;
    n_stepsize = 0.5;
    b_on = 1;
    f = 0;
    
    while ( f < 5 )
    {
        if ( b_on )
        {
            e_model hide();
        }
        else
        {
            e_model show();
        }
        
        b_on = !b_on;
        wait n_stepsize;
        
        if ( n_stepsize > 0.15 )
        {
            n_stepsize *= 0.9;
        }
        
        f += n_stepsize;
    }
    
    level notify( #"key_drop_timeout" );
    e_model delete();
    e_trigger delete();
}

// Namespace doors
// Params 2
// Checksum 0x40e6ea88, Offset: 0x3718
// Size: 0x29c
function give_ai_key_internal( n_timeout_sec, str_key_type )
{
    v_pos = self.origin;
    e_model = spawn( "script_model", v_pos + ( 0, 0, 80 ) );
    e_model.angles = ( 10, 0, 10 );
    e_model setmodel( level.door_key_model );
    
    if ( isdefined( level.door_key_fx ) )
    {
        playfxontag( level.door_key_fx, e_model, "tag_origin" );
    }
    
    while ( isalive( self ) )
    {
        e_model moveto( self.origin + ( 0, 0, 80 ), 0.2 );
        e_model rotateyaw( 30, 0.2 );
        wait 0.1;
    }
    
    e_model movez( -60, 1 );
    wait 1;
    e_model thread rotate_key_forever();
    e_trigger = spawn( "trigger_radius", e_model.origin, 0, 25, 100 );
    
    if ( isdefined( n_timeout_sec ) )
    {
        level thread key_process_timeout( n_timeout_sec, e_trigger, e_model );
    }
    
    e_trigger endon( #"death" );
    
    while ( true )
    {
        e_trigger waittill( #"trigger", e_who );
        
        if ( isplayer( e_who ) )
        {
            e_who give_player_key( str_key_type );
            break;
        }
    }
    
    e_model delete();
    e_trigger delete();
}

// Namespace doors
// Params 2
// Checksum 0xf57cc901, Offset: 0x39c0
// Size: 0x84
function give_ai_key( n_timeout_sec, str_key_type )
{
    if ( !isdefined( n_timeout_sec ) )
    {
        n_timeout_sec = undefined;
    }
    
    if ( !isdefined( str_key_type ) )
    {
        str_key_type = "door";
    }
    
    assert( isdefined( level.door_key_model ), "<dev string:x28>" );
    self thread give_ai_key_internal( n_timeout_sec, str_key_type );
}

// Namespace doors
// Params 1
// Checksum 0x230f1ad7, Offset: 0x3a50
// Size: 0x210
function give_player_key( str_key_type )
{
    if ( !isdefined( str_key_type ) )
    {
        str_key_type = "door";
    }
    
    assert( isdefined( level.door_key_icon ), "<dev string:x81>" );
    
    if ( !isdefined( self.collectible_keys ) )
    {
        self.collectible_keys = [];
    }
    
    if ( !isdefined( self.collectible_keys[ str_key_type ] ) )
    {
        self.collectible_keys[ str_key_type ] = spawnstruct();
        self.collectible_keys[ str_key_type ].num_keys = 0;
        self.collectible_keys[ str_key_type ].type = str_key_type;
    }
    
    hudelem = self.collectible_keys[ str_key_type ].hudelem;
    
    if ( !isdefined( hudelem ) )
    {
        hudelem = newclienthudelem( self );
    }
    
    hudelem.alignx = "right";
    hudelem.aligny = "bottom";
    hudelem.horzalign = "right";
    hudelem.vertalign = "bottom";
    hudelem.hidewheninmenu = 1;
    hudelem.hidewhenindemo = 1;
    hudelem.y = -75;
    hudelem.x = -25;
    hudelem setshader( level.door_key_icon, 16, 16 );
    self.collectible_keys[ str_key_type ].hudelem = hudelem;
    self.collectible_keys[ str_key_type ].num_keys++;
}

// Namespace doors
// Params 1
// Checksum 0xbbf92a43, Offset: 0x3c68
// Size: 0x10e
function unlock_all( b_do_open )
{
    if ( !isdefined( b_do_open ) )
    {
        b_do_open = 1;
    }
    
    a_s_inst_list = struct::get_array( "scriptbundle_doors", "classname" );
    
    foreach ( s_inst in a_s_inst_list )
    {
        c_door = s_inst.c_door;
        
        if ( isdefined( c_door ) )
        {
            [[ c_door ]]->unlock();
            
            if ( b_do_open )
            {
                [[ c_door ]]->open();
            }
        }
    }
}

// Namespace doors
// Params 3
// Checksum 0x5dae71b2, Offset: 0x3d80
// Size: 0x12a
function unlock( str_name, str_name_type, b_do_open )
{
    if ( !isdefined( str_name_type ) )
    {
        str_name_type = "targetname";
    }
    
    if ( !isdefined( b_do_open ) )
    {
        b_do_open = 1;
    }
    
    a_s_inst_list = struct::get_array( str_name, str_name_type );
    
    foreach ( s_inst in a_s_inst_list )
    {
        if ( isdefined( s_inst.c_door ) )
        {
            [[ s_inst.c_door ]]->unlock();
            
            if ( b_do_open )
            {
                [[ s_inst.c_door ]]->open();
            }
        }
    }
}

