#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;

#namespace zm_castle_util;

// Namespace zm_castle_util
// Params 4
// Checksum 0x69792900, Offset: 0x180
// Size: 0x15c
function create_unitrigger( str_hint, n_radius, func_prompt_and_visibility, func_unitrigger_logic )
{
    if ( !isdefined( n_radius ) )
    {
        n_radius = 64;
    }
    
    if ( !isdefined( func_prompt_and_visibility ) )
    {
        func_prompt_and_visibility = &unitrigger_prompt_and_visibility;
    }
    
    if ( !isdefined( func_unitrigger_logic ) )
    {
        func_unitrigger_logic = &unitrigger_logic;
    }
    
    s_unitrigger = spawnstruct();
    s_unitrigger.origin = self.origin;
    s_unitrigger.angles = self.angles;
    s_unitrigger.script_unitrigger_type = "unitrigger_radius_use";
    s_unitrigger.cursor_hint = "HINT_NOICON";
    s_unitrigger.hint_string = str_hint;
    s_unitrigger.prompt_and_visibility_func = func_prompt_and_visibility;
    s_unitrigger.related_parent = self;
    s_unitrigger.radius = n_radius;
    self.s_unitrigger = s_unitrigger;
    zm_unitrigger::register_static_unitrigger( s_unitrigger, func_unitrigger_logic );
}

// Namespace zm_castle_util
// Params 1
// Checksum 0x9c33223, Offset: 0x2e8
// Size: 0x22
function unitrigger_prompt_and_visibility( player )
{
    b_visible = 1;
    return b_visible;
}

// Namespace zm_castle_util
// Params 0
// Checksum 0x24b3b4a0, Offset: 0x318
// Size: 0xbc
function unitrigger_logic()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( player zm_utility::in_revive_trigger() )
        {
            continue;
        }
        
        if ( player.is_drinking > 0 )
        {
            continue;
        }
        
        if ( !zm_utility::is_player_valid( player ) )
        {
            continue;
        }
        
        if ( isdefined( self.stub.related_parent ) )
        {
            self.stub.related_parent notify( #"trigger_activated", player );
        }
    }
}

// Namespace zm_castle_util
// Params 0
// Checksum 0xac5e3585, Offset: 0x3e0
// Size: 0x1f4
function function_fa7da172()
{
    self endon( #"death" );
    var_82a4f07b = struct::get( "keeper_end_loc" );
    var_77b9bd02 = 0;
    
    while ( isdefined( level.var_8ef26cd9 ) && level.var_8ef26cd9 )
    {
        str_player_zone = self zm_zonemgr::get_player_zone();
        
        if ( zm_utility::is_player_valid( self ) && str_player_zone === "zone_undercroft" )
        {
            if ( !( isdefined( var_77b9bd02 ) && var_77b9bd02 ) && distance2dsquared( var_82a4f07b.origin, self.origin ) <= 53361 )
            {
                self clientfield::set_to_player( "gravity_trap_rumble", 1 );
                var_77b9bd02 = 1;
            }
            else if ( isdefined( var_77b9bd02 ) && var_77b9bd02 && distance2dsquared( var_82a4f07b.origin, self.origin ) > 53361 )
            {
                self clientfield::set_to_player( "gravity_trap_rumble", 0 );
                var_77b9bd02 = 0;
            }
        }
        else if ( isdefined( var_77b9bd02 ) && var_77b9bd02 )
        {
            self clientfield::set_to_player( "gravity_trap_rumble", 0 );
            var_77b9bd02 = 0;
        }
        
        wait 0.15;
    }
    
    self clientfield::set_to_player( "gravity_trap_rumble", 0 );
}

/#

    // Namespace zm_castle_util
    // Params 4
    // Checksum 0xc51fadf6, Offset: 0x5e0
    // Size: 0x108, Type: dev
    function function_8faf1d24( v_color, str_print, n_scale, str_endon )
    {
        if ( !isdefined( v_color ) )
        {
            v_color = ( 0, 0, 255 );
        }
        
        if ( !isdefined( str_print ) )
        {
            str_print = "<dev string:x28>";
        }
        
        if ( !isdefined( n_scale ) )
        {
            n_scale = 0.25;
        }
        
        if ( !isdefined( str_endon ) )
        {
            str_endon = "<dev string:x2a>";
        }
        
        if ( getdvarint( "<dev string:x3c>" ) == 0 )
        {
            return;
        }
        
        if ( isdefined( str_endon ) )
        {
            self endon( str_endon );
        }
        
        origin = self.origin;
        
        while ( true )
        {
            print3d( origin, str_print, v_color, n_scale );
            wait 0.1;
        }
    }

    // Namespace zm_castle_util
    // Params 5
    // Checksum 0xd3574411, Offset: 0x6f0
    // Size: 0x120, Type: dev
    function setup_devgui_func( str_devgui_path, str_dvar, n_value, func, n_base_value )
    {
        if ( !isdefined( n_base_value ) )
        {
            n_base_value = -1;
        }
        
        setdvar( str_dvar, n_base_value );
        adddebugcommand( "<dev string:x49>" + str_devgui_path + "<dev string:x56>" + str_dvar + "<dev string:x5a>" + n_value + "<dev string:x5c>" );
        
        while ( true )
        {
            n_dvar = getdvarint( str_dvar );
            
            if ( n_dvar > n_base_value )
            {
                [[ func ]]( n_dvar );
                setdvar( str_dvar, n_base_value );
            }
            
            util::wait_network_frame();
        }
    }

#/
