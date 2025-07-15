#using scripts/shared/animation_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;

#namespace animation;

/#

    // Namespace animation
    // Params 0, eflags: 0x2
    // Checksum 0x49208920, Offset: 0xe0
    // Size: 0xd0, Type: dev
    function autoexec __init__()
    {
        setdvar( "<dev string:x28>", 0 );
        setdvar( "<dev string:x33>", 0 );
        
        while ( true )
        {
            anim_debug = getdvarint( "<dev string:x28>", 0 ) || getdvarint( "<dev string:x33>", 0 );
            level flagsys::set_val( "<dev string:x28>", anim_debug );
            
            if ( !anim_debug )
            {
                level notify( #"kill_anim_debug" );
            }
            
            wait 0.05;
        }
    }

    // Namespace animation
    // Params 7
    // Checksum 0xa1bfacd9, Offset: 0x1b8
    // Size: 0x6e8, Type: dev
    function anim_info_render_thread( animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp )
    {
        self endon( #"death" );
        self endon( #"scriptedanim" );
        self notify( #"_anim_info_render_thread_" );
        self endon( #"_anim_info_render_thread_" );
        
        if ( !isvec( v_origin_or_ent ) )
        {
            v_origin_or_ent endon( #"death" );
        }
        
        recordent( self );
        
        while ( true )
        {
            level flagsys::wait_till( "<dev string:x28>" );
            b_anim_debug_on = 1;
            _init_frame();
            str_extra_info = "<dev string:x44>";
            color = ( 1, 1, 0 );
            
            if ( flagsys::get( "<dev string:x45>" ) )
            {
                str_extra_info += "<dev string:x50>";
            }
            
            s_pos = _get_align_pos( v_origin_or_ent, v_angles_or_tag );
            self anim_origin_render( s_pos.origin, s_pos.angles, undefined, undefined, !b_anim_debug_on );
            
            if ( b_anim_debug_on )
            {
                line( self.origin, s_pos.origin, color, 0.5, 1 );
                sphere( s_pos.origin, 2, ( 0.3, 0.3, 0.3 ), 0.5, 1 );
            }
            
            recordline( self.origin, s_pos.origin, color, "<dev string:x5e>" );
            recordsphere( s_pos.origin, 2, ( 0.3, 0.3, 0.3 ), "<dev string:x5e>" );
            
            if ( v_origin_or_ent != self && !isvec( v_origin_or_ent ) && v_origin_or_ent != level )
            {
                str_name = "<dev string:x6b>";
                
                if ( isdefined( v_origin_or_ent.animname ) )
                {
                    str_name = v_origin_or_ent.animname;
                }
                else if ( isdefined( v_origin_or_ent.targetname ) )
                {
                    str_name = v_origin_or_ent.targetname;
                }
                
                if ( b_anim_debug_on )
                {
                    print3d( v_origin_or_ent.origin + ( 0, 0, 5 ), str_name, ( 0.3, 0.3, 0.3 ), 1, 0.15 );
                }
                
                record3dtext( str_name, v_origin_or_ent.origin + ( 0, 0, 5 ), ( 0.3, 0.3, 0.3 ), "<dev string:x5e>" );
            }
            
            self anim_origin_render( self.origin, self.angles, undefined, undefined, !b_anim_debug_on );
            str_name = "<dev string:x6b>";
            
            if ( isdefined( self.anim_debug_name ) )
            {
                str_name = self.anim_debug_name;
            }
            else if ( isdefined( self.animname ) )
            {
                str_name = self.animname;
            }
            else if ( isdefined( self.targetname ) )
            {
                str_name = self.targetname;
            }
            
            if ( b_anim_debug_on )
            {
                print3d( self.origin, self getentnum() + get_ent_type() + "<dev string:x73>" + str_name, color, 0.8, 0.3 );
                print3d( self.origin - ( 0, 0, 5 ), "<dev string:x7a>" + animation, color, 0.8, 0.3 );
                print3d( self.origin - ( 0, 0, 7 ), str_extra_info, color, 0.8, 0.15 );
            }
            
            record3dtext( self getentnum() + get_ent_type() + "<dev string:x73>" + str_name, self.origin, color, "<dev string:x5e>" );
            record3dtext( "<dev string:x7a>" + animation, self.origin - ( 0, 0, 5 ), color, "<dev string:x5e>" );
            record3dtext( str_extra_info, self.origin - ( 0, 0, 7 ), color, "<dev string:x5e>" );
            render_tag( "<dev string:x85>", "<dev string:x96>", !b_anim_debug_on );
            render_tag( "<dev string:x9c>", "<dev string:xac>", !b_anim_debug_on );
            render_tag( "<dev string:xb1>", "<dev string:xbc>", !b_anim_debug_on );
            render_tag( "<dev string:xc3>", "<dev string:xce>", !b_anim_debug_on );
            _reset_frame();
            wait 0.05;
        }
    }

    // Namespace animation
    // Params 0
    // Checksum 0x559085f3, Offset: 0x8a8
    // Size: 0x6e, Type: dev
    function get_ent_type()
    {
        if ( isactor( self ) )
        {
            return "<dev string:xd5>";
        }
        
        if ( isvehicle( self ) )
        {
            return "<dev string:xda>";
        }
        
        return "<dev string:xe4>" + self.classname + "<dev string:xe6>";
    }

    // Namespace animation
    // Params 0
    // Checksum 0x4681cb72, Offset: 0x920
    // Size: 0x24, Type: dev
    function _init_frame()
    {
        self.v_centroid = self getcentroid();
    }

    // Namespace animation
    // Params 0
    // Checksum 0x5c8339b3, Offset: 0x950
    // Size: 0x12, Type: dev
    function _reset_frame()
    {
        self.v_centroid = undefined;
    }

    // Namespace animation
    // Params 3
    // Checksum 0xa930cfb8, Offset: 0x970
    // Size: 0x144, Type: dev
    function render_tag( str_tag, str_label, b_recorder_only )
    {
        if ( !isdefined( str_label ) )
        {
            str_label = str_tag;
        }
        
        if ( !isdefined( self.v_centroid ) )
        {
            self.v_centroid = self getcentroid();
        }
        
        v_tag_org = self gettagorigin( str_tag );
        
        if ( isdefined( v_tag_org ) )
        {
            v_tag_ang = self gettagangles( str_tag );
            anim_origin_render( v_tag_org, v_tag_ang, 2, str_label, b_recorder_only );
            
            if ( !b_recorder_only )
            {
                line( self.v_centroid, v_tag_org, ( 0.3, 0.3, 0.3 ), 0.5, 1 );
            }
            
            recordline( self.v_centroid, v_tag_org, ( 0.3, 0.3, 0.3 ), "<dev string:x5e>" );
        }
    }

    // Namespace animation
    // Params 5
    // Checksum 0xe0c0ba68, Offset: 0xac0
    // Size: 0x25c, Type: dev
    function anim_origin_render( org, angles, line_length, str_label, b_recorder_only )
    {
        if ( !isdefined( line_length ) )
        {
            line_length = 6;
        }
        
        if ( isdefined( org ) && isdefined( angles ) )
        {
            originendpoint = org + vectorscale( anglestoforward( angles ), line_length );
            originrightpoint = org + vectorscale( anglestoright( angles ), -1 * line_length );
            originuppoint = org + vectorscale( anglestoup( angles ), line_length );
            
            if ( !b_recorder_only )
            {
                line( org, originendpoint, ( 1, 0, 0 ) );
                line( org, originrightpoint, ( 0, 1, 0 ) );
                line( org, originuppoint, ( 0, 0, 1 ) );
            }
            
            recordline( org, originendpoint, ( 1, 0, 0 ), "<dev string:x5e>" );
            recordline( org, originrightpoint, ( 0, 1, 0 ), "<dev string:x5e>" );
            recordline( org, originuppoint, ( 0, 0, 1 ), "<dev string:x5e>" );
            
            if ( isdefined( str_label ) )
            {
                if ( !b_recorder_only )
                {
                    print3d( org, str_label, ( 1, 0.752941, 0.796078 ), 1, 0.05 );
                }
                
                record3dtext( str_label, org, ( 1, 0.752941, 0.796078 ), "<dev string:x5e>" );
            }
        }
    }

#/
