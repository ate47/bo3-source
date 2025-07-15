#using scripts/shared/animation_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;

#namespace animation;

/#

    // Namespace animation
    // Params 0, eflags: 0x2
    // Checksum 0x2d796748, Offset: 0xe0
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
    // Checksum 0x4ce08cad, Offset: 0x1b8
    // Size: 0x4c0, Type: dev
    function anim_info_render_thread( animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp )
    {
        self endon( #"death" );
        self endon( #"scriptedanim" );
        self notify( #"_anim_info_render_thread_" );
        self endon( #"_anim_info_render_thread_" );
        
        while ( true )
        {
            level flagsys::wait_till( "<dev string:x28>" );
            _init_frame();
            str_extra_info = "<dev string:x44>";
            color = ( 0, 1, 1 );
            
            if ( flagsys::get( "<dev string:x45>" ) )
            {
                str_extra_info += "<dev string:x50>";
            }
            
            s_pos = _get_align_pos( v_origin_or_ent, v_angles_or_tag );
            self anim_origin_render( s_pos.origin, s_pos.angles );
            line( self.origin, s_pos.origin, color, 0.5, 1 );
            sphere( s_pos.origin, 2, ( 0.3, 0.3, 0.3 ), 0.5, 1 );
            
            if ( v_origin_or_ent != self && !isvec( v_origin_or_ent ) && v_origin_or_ent != level )
            {
                str_name = "<dev string:x5e>";
                
                if ( isdefined( v_origin_or_ent.animname ) )
                {
                    str_name = v_origin_or_ent.animname;
                }
                else if ( isdefined( v_origin_or_ent.targetname ) )
                {
                    str_name = v_origin_or_ent.targetname;
                }
                
                print3d( v_origin_or_ent.origin + ( 0, 0, 5 ), str_name, ( 0.3, 0.3, 0.3 ), 1, 0.15 );
            }
            
            self anim_origin_render( self.origin, self.angles );
            str_name = "<dev string:x5e>";
            
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
            
            print3d( self.origin, self getentnum() + get_ent_type() + "<dev string:x66>" + str_name, color, 0.8, 0.3 );
            print3d( self.origin - ( 0, 0, 5 ), "<dev string:x6d>" + animation, color, 0.8, 0.3 );
            print3d( self.origin - ( 0, 0, 7 ), str_extra_info, color, 0.8, 0.15 );
            render_tag( "<dev string:x78>", "<dev string:x89>" );
            render_tag( "<dev string:x8f>", "<dev string:x9f>" );
            render_tag( "<dev string:xa4>", "<dev string:xaf>" );
            render_tag( "<dev string:xb6>", "<dev string:xc1>" );
            _reset_frame();
            wait 0.01;
        }
    }

    // Namespace animation
    // Params 0
    // Checksum 0xf464e42, Offset: 0x680
    // Size: 0x3a, Type: dev
    function get_ent_type()
    {
        return "<dev string:xc8>" + ( isdefined( self.classname ) ? self.classname : "<dev string:x44>" ) + "<dev string:xca>";
    }

    // Namespace animation
    // Params 0
    // Checksum 0x3eda4064, Offset: 0x6c8
    // Size: 0x8, Type: dev
    function _init_frame()
    {
        
    }

    // Namespace animation
    // Params 0
    // Checksum 0xa115834f, Offset: 0x6d8
    // Size: 0x12, Type: dev
    function _reset_frame()
    {
        self.v_centroid = undefined;
    }

    // Namespace animation
    // Params 2
    // Checksum 0xba824c8c, Offset: 0x6f8
    // Size: 0xe4, Type: dev
    function render_tag( str_tag, str_label )
    {
        if ( !isdefined( str_label ) )
        {
            str_label = str_tag;
        }
        
        v_tag_org = self gettagorigin( str_tag );
        
        if ( isdefined( v_tag_org ) )
        {
            v_tag_ang = self gettagangles( str_tag );
            anim_origin_render( v_tag_org, v_tag_ang, 2, str_label );
            
            if ( isdefined( self.v_centroid ) )
            {
                line( self.v_centroid, v_tag_org, ( 0.3, 0.3, 0.3 ), 0.5, 1 );
            }
        }
    }

    // Namespace animation
    // Params 4
    // Checksum 0x9d5e1456, Offset: 0x7e8
    // Size: 0x18c, Type: dev
    function anim_origin_render( org, angles, line_length, str_label )
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
            line( org, originendpoint, ( 1, 0, 0 ) );
            line( org, originrightpoint, ( 0, 1, 0 ) );
            line( org, originuppoint, ( 0, 0, 1 ) );
            
            if ( isdefined( str_label ) )
            {
                print3d( org, str_label, ( 1, 0.752941, 0.796078 ), 1, 0.05 );
            }
        }
    }

#/
