#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_altbody_beast;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;

#namespace zm_zod_beastcode;

// Namespace zm_zod_beastcode
// Method(s) 25 Total 25
class cbeastcode
{

    // Namespace cbeastcode
    // Params 2
    // Checksum 0x59bb32f7, Offset: 0x1a08
    // Size: 0x80
    function interpret_trigger_event( player, n_index )
    {
        self.m_n_device_state = 0;
        hide_given_input( n_index );
        self.m_a_current[ self.m_n_input_index ] = n_index;
        self.m_n_input_index++;
        
        if ( self.m_n_input_index == 3 )
        {
            activate_input_device();
        }
        
        self.m_n_device_state = 1;
    }

    // Namespace cbeastcode
    // Params 0
    // Checksum 0xe6de8cde, Offset: 0x19f0
    // Size: 0xa
    function get_keycode_device_state()
    {
        return self.m_n_device_state;
    }

    // Namespace cbeastcode
    // Params 2
    // Checksum 0xad544e1c, Offset: 0x1930
    // Size: 0xb4
    function keycode_input_trigger_think( o_beastcode, n_index )
    {
        while ( true )
        {
            self waittill( #"trigger", player );
            
            if ( o_beastcode.var_71f130fa <= 0 )
            {
                continue;
            }
            
            if ( player zm_utility::in_revive_trigger() )
            {
                continue;
            }
            
            if ( !( isdefined( [[ o_beastcode ]]->get_keycode_device_state() ) && [[ o_beastcode ]]->get_keycode_device_state() ) )
            {
                continue;
            }
            
            [[ o_beastcode ]]->interpret_trigger_event( player, n_index );
        }
    }

    // Namespace cbeastcode
    // Params 1
    // Checksum 0xeaa53e1a, Offset: 0x1570
    // Size: 0x3b8
    function keycode_input_prompt( player )
    {
        self endon( #"kill_trigger" );
        player endon( #"death_or_disconnect" );
        str_hint = &"";
        str_old_hint = &"";
        a_s_input_button_tags = [[ self.stub.o_keycode ]]->get_tags_from_input_device();
        
        while ( true )
        {
            n_state = [[ self.stub.o_keycode ]]->get_keycode_device_state();
            
            switch ( n_state )
            {
                case 2:
                    str_hint = &"ZM_ZOD_KEYCODE_TRYING";
                    break;
                case 3:
                    str_hint = &"ZM_ZOD_KEYCODE_SUCCESS";
                    break;
                case 4:
                    str_hint = &"ZM_ZOD_KEYCODE_FAIL";
                    break;
                case 0:
                    str_hint = &"ZM_ZOD_KEYCODE_UNAVAILABLE";
                    break;
                case 1:
                    player.n_keycode_lookat_tag = undefined;
                    n_closest_dot = 0.996;
                    v_eye_origin = player getplayercamerapos();
                    v_eye_direction = anglestoforward( player getplayerangles() );
                    
                    foreach ( s_tag in a_s_input_button_tags )
                    {
                        v_tag_origin = s_tag.v_origin;
                        v_eye_to_tag = vectornormalize( v_tag_origin - v_eye_origin );
                        n_dot = vectordot( v_eye_to_tag, v_eye_direction );
                        
                        if ( n_dot > n_closest_dot )
                        {
                            n_closest_dot = n_dot;
                            player.n_keycode_lookat_tag = s_tag.n_index;
                        }
                    }
                    
                    if ( !isdefined( player.n_keycode_lookat_tag ) )
                    {
                        str_hint = &"";
                    }
                    else if ( player.n_keycode_lookat_tag < 3 )
                    {
                        str_hint = &"ZM_ZOD_KEYCODE_INCREMENT_NUMBER";
                    }
                    else
                    {
                        str_hint = &"ZM_ZOD_KEYCODE_ACTIVATE";
                    }
                    
                    break;
            }
            
            if ( str_old_hint != str_hint )
            {
                str_old_hint = str_hint;
                self.stub.hint_string = str_hint;
                
                if ( str_hint === &"ZM_ZOD_KEYCODE_INCREMENT_NUMBER" )
                {
                    self sethintstring( self.stub.hint_string, player.n_keycode_lookat_tag + 1 );
                }
                else
                {
                    self sethintstring( self.stub.hint_string );
                }
            }
            
            wait 0.1;
        }
    }

    // Namespace cbeastcode
    // Params 1
    // Checksum 0xcf010192, Offset: 0x14e8
    // Size: 0x7a, Type: bool
    function keycode_input_visibility( player )
    {
        b_is_invis = !( isdefined( player.beastmode ) && player.beastmode );
        self setinvisibletoplayer( player, b_is_invis );
        self thread keycode_input_prompt( player );
        return !b_is_invis;
    }

    // Namespace cbeastcode
    // Params 3
    // Checksum 0x78e69d39, Offset: 0x1288
    // Size: 0x252
    function function_71154a2( t_lookat, n_code_index, var_d7d7b586 )
    {
        var_c929283d = struct::get( t_lookat.target, "targetname" );
        var_43544e59 = var_c929283d.origin;
        
        while ( true )
        {
            t_lookat waittill( #"trigger", player );
            
            while ( player istouching( t_lookat ) )
            {
                v_eye_origin = player getplayercamerapos();
                v_eye_direction = anglestoforward( player getplayerangles() );
                var_744d3805 = vectornormalize( var_43544e59 - v_eye_origin );
                n_dot = vectordot( var_744d3805, v_eye_direction );
                
                if ( n_dot > 0.9 )
                {
                    n_number = get_number_in_code( n_code_index, var_d7d7b586 );
                    player.var_ab153665 = player hud::createprimaryprogressbartext();
                    player.var_ab153665 settext( "You sense the number " + n_number );
                    player.var_ab153665 hud::showelem();
                }
                
                wait 0.05;
                
                if ( isdefined( player.var_ab153665 ) )
                {
                    player.var_ab153665 hud::destroyelem();
                    player.var_ab153665 = undefined;
                }
            }
        }
    }

    // Namespace cbeastcode
    // Params 0
    // Checksum 0x41bf41ed, Offset: 0x10c8
    // Size: 0x1b4
    function create_code_input_unitrigger()
    {
        width = 128;
        height = 128;
        length = 128;
        m_mdl_input.unitrigger_stub = spawnstruct();
        m_mdl_input.unitrigger_stub.origin = m_mdl_input.origin;
        m_mdl_input.unitrigger_stub.angles = m_mdl_input.angles;
        m_mdl_input.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
        m_mdl_input.unitrigger_stub.cursor_hint = "HINT_NOICON";
        m_mdl_input.unitrigger_stub.script_width = width;
        m_mdl_input.unitrigger_stub.script_height = height;
        m_mdl_input.unitrigger_stub.script_length = length;
        m_mdl_input.unitrigger_stub.require_look_at = 0;
        m_mdl_input.unitrigger_stub.o_keycode = self;
        m_mdl_input.unitrigger_stub.prompt_and_visibility_func = &keycode_input_visibility;
        zm_unitrigger::register_static_unitrigger( m_mdl_input.unitrigger_stub, &keycode_input_trigger_think );
    }

    // Namespace cbeastcode
    // Params 1
    // Checksum 0xffa6dece, Offset: 0x1060
    // Size: 0x60, Type: bool
    function test_current_code_against_this_code( a_code )
    {
        for ( i = 0; i < a_code.size ; i++ )
        {
            if ( !isinarray( self.m_a_current, a_code[ i ] ) )
            {
                return false;
            }
        }
        
        return true;
    }

    // Namespace cbeastcode
    // Params 0
    // Checksum 0x72a1e1c9, Offset: 0xee8
    // Size: 0x16c
    function activate_input_device()
    {
        self.var_71f130fa -= 1;
        
        for ( i = 0; i < self.m_a_codes.size ; i++ )
        {
            if ( test_current_code_against_this_code( self.m_a_codes[ i ] ) )
            {
                playsoundatposition( "zmb_zod_sword_symbol_right", ( 2624, -5104, -312 ) );
                self.m_n_device_state = 3;
                hide_readout( 1 );
                [[ self.m_a_funcs[ i ] ]]();
                return;
            }
        }
        
        self.m_n_device_state = 4;
        self.m_n_input_index = 0;
        playsoundatposition( "zmb_zod_sword_symbol_wrong", ( 2624, -5104, -312 ) );
        
        if ( self.var_71f130fa > 0 )
        {
            hide_readout( 1 );
            wait 3;
            hide_readout( 0 );
            self.m_n_device_state = 1;
            return;
        }
        
        hide_readout( 1 );
    }

    // Namespace cbeastcode
    // Params 1
    // Checksum 0x24bdb145, Offset: 0xdc0
    // Size: 0x11e
    function update_clue_numbers_for_code( n_index )
    {
        if ( !isdefined( n_index ) )
        {
            n_index = 0;
        }
        
        a_code = self.m_a_codes[ n_index ];
        
        for ( i = 0; i < 3 ; i++ )
        {
            mdl_clue_number = self.m_a_mdl_clues[ n_index ][ i ];
            
            for ( j = 0; j < 10 ; j++ )
            {
                mdl_clue_number hidepart( "J_" + j );
                mdl_clue_number hidepart( "p7_zm_zod_keepers_code_0" + j );
            }
            
            mdl_clue_number showpart( "p7_zm_zod_keepers_code_0" + a_code[ i ] );
        }
    }

    // Namespace cbeastcode
    // Params 2
    // Checksum 0xf72c379e, Offset: 0xd50
    // Size: 0x64
    function set_input_number_visibility( n_index, b_is_visible )
    {
        if ( b_is_visible )
        {
            self.m_a_mdl_inputs[ n_index ] show();
            return;
        }
        
        self.m_a_mdl_inputs[ n_index ] hide();
    }

    // Namespace cbeastcode
    // Params 2
    // Checksum 0x29f759f6, Offset: 0xc78
    // Size: 0xcc
    function set_input_number( n_index, n_value )
    {
        mdl_input = self.m_a_mdl_inputs[ n_index ];
        
        for ( i = 0; i < 10 ; i++ )
        {
            mdl_input hidepart( "J_" + i );
            mdl_input hidepart( "j_keeper_" + i );
        }
        
        mdl_input showpart( "j_keeper_" + n_value );
    }

    // Namespace cbeastcode
    // Params 0
    // Checksum 0xc4d70e94, Offset: 0xc10
    // Size: 0x5c
    function function_36c50de5()
    {
        while ( true )
        {
            level waittill( #"start_of_round" );
            
            if ( 0 >= self.var_71f130fa )
            {
                hide_readout( 0 );
                self.m_n_device_state = 1;
            }
            
            self.var_71f130fa = self.var_36948aba;
        }
    }

    // Namespace cbeastcode
    // Params 0
    // Checksum 0x6217fb4c, Offset: 0xb68
    // Size: 0x9e
    function setup_input_threads()
    {
        for ( i = 0; i < self.m_a_mdl_inputs.size ; i++ )
        {
            self.m_a_mdl_inputs[ i ] thread zm_altbody_beast::watch_lightning_damage( self.m_a_t_inputs[ i ] );
            self.m_a_t_inputs[ i ] thread keycode_input_trigger_think( self, i );
            set_input_number( i, i );
        }
    }

    // Namespace cbeastcode
    // Params 1
    // Checksum 0x271b5dc, Offset: 0xb30
    // Size: 0x2c
    function hide_given_input( n_index )
    {
        self.m_a_mdl_inputs[ n_index ] ghost();
    }

    // Namespace cbeastcode
    // Params 1
    // Checksum 0x2aaefd80, Offset: 0xa48
    // Size: 0xda
    function hide_readout( b_hide )
    {
        if ( !isdefined( b_hide ) )
        {
            b_hide = 1;
        }
        
        foreach ( mdl_input in self.m_a_mdl_inputs )
        {
            if ( b_hide )
            {
                mdl_input ghost();
                continue;
            }
            
            mdl_input show();
            zm_altbody_beast::function_41cc3fc8();
        }
    }

    // Namespace cbeastcode
    // Params 2
    // Checksum 0x60982e6d, Offset: 0x9c0
    // Size: 0x7c
    function set_clue_numbers_for_code( a_mdl_clues, n_index )
    {
        if ( !isdefined( n_index ) )
        {
            n_index = 0;
        }
        
        if ( !isdefined( self.m_a_mdl_clues ) )
        {
            self.m_a_mdl_clues = array( undefined );
        }
        
        self.m_a_mdl_clues[ n_index ] = a_mdl_clues;
        self thread update_clue_numbers_for_code( n_index );
    }

    // Namespace cbeastcode
    // Params 2
    // Checksum 0x81d19590, Offset: 0x9a0
    // Size: 0x14
    function add_code_function_pair( a_code, func_custom )
    {
        
    }

    // Namespace cbeastcode
    // Params 0
    // Checksum 0x521180f3, Offset: 0x880
    // Size: 0x118
    function generate_random_code()
    {
        a_n_numbers = array( 0, 1, 2, 3, 4, 5, 6, 7, 8 );
        a_code = [];
        
        for ( i = 0; i < 3 ; i++ )
        {
            a_n_numbers = array::randomize( a_n_numbers );
            n_number = array::pop_front( a_n_numbers );
            
            if ( !isdefined( a_code ) )
            {
                a_code = [];
            }
            else if ( !isarray( a_code ) )
            {
                a_code = array( a_code );
            }
            
            a_code[ a_code.size ] = n_number;
        }
        
        return a_code;
    }

    // Namespace cbeastcode
    // Params 0
    // Checksum 0xea4c9267, Offset: 0x868
    // Size: 0xa
    function get_tags_from_input_device()
    {
        return self.m_a_s_input_button_tags;
    }

    // Namespace cbeastcode
    // Params 2
    // Checksum 0x54ec2ca, Offset: 0x838
    // Size: 0x26
    function get_number_in_code( n_code_index, n_place_index )
    {
        return self.m_a_codes[ n_code_index ][ n_place_index ];
    }

    // Namespace cbeastcode
    // Params 1
    // Checksum 0x81da9e91, Offset: 0x7f0
    // Size: 0x3e
    function get_code( n_code_index )
    {
        if ( !isdefined( n_code_index ) )
        {
            n_code_index = 0;
        }
        
        a_code = self.m_a_codes[ n_code_index ];
        return a_code;
    }

    // Namespace cbeastcode
    // Params 4
    // Checksum 0x6a80b72f, Offset: 0x6c0
    // Size: 0x124
    function init( a_mdl_inputs, a_t_inputs, a_t_clue, func_activate )
    {
        self.m_a_mdl_inputs = a_mdl_inputs;
        self.m_a_t_inputs = a_t_inputs;
        self.var_1d4fdfa6 = a_t_clue;
        self.m_a_current = array( 0, 0, 0 );
        self.m_n_input_index = 0;
        self.m_a_codes = array( generate_random_code() );
        self.m_a_funcs = array( func_activate );
        self.var_36948aba = 1;
        self.var_71f130fa = self.var_36948aba;
        self thread setup_input_threads();
        self thread function_36c50de5();
        self.m_b_discovered = 0;
        self.m_n_device_state = 1;
    }

}

// Namespace zm_zod_beastcode
// Params 0, eflags: 0x2
// Checksum 0xf5ac61d0, Offset: 0x438
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_zod_beastcode", &__init__, undefined, undefined );
}

// Namespace zm_zod_beastcode
// Params 0
// Checksum 0x99ec1590, Offset: 0x478
// Size: 0x4
function __init__()
{
    
}

// Namespace zm_zod_beastcode
// Params 0
// Checksum 0xf86350c0, Offset: 0x488
// Size: 0x200
function init()
{
    a_mdl_inputs = [];
    a_mdl_clues = [];
    a_t_inputs = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        mdl_clue_number = getent( "keeper_sword_locker_clue_" + i, "targetname" );
        a_mdl_clues[ a_mdl_clues.size ] = mdl_clue_number;
    }
    
    for ( i = 0; i < 10 ; i++ )
    {
        mdl_beast_number = getent( "keeper_sword_locker_number_" + i, "targetname" );
        a_mdl_inputs[ a_mdl_inputs.size ] = mdl_beast_number;
        t_input = getent( "keeper_sword_locker_trigger_" + i, "targetname" );
        a_t_inputs[ a_t_inputs.size ] = t_input;
    }
    
    a_t_clue = getentarray( "keeper_sword_locker_clue_lookat", "targetname" );
    level.o_canal_beastcode = new cbeastcode();
    [[ level.o_canal_beastcode ]]->init( a_mdl_inputs, a_t_inputs, a_t_clue, &keeper_sword_locker_open_locker );
    a_code = [[ level.o_canal_beastcode ]]->get_code();
    [[ level.o_canal_beastcode ]]->set_clue_numbers_for_code( a_mdl_clues );
}

// Namespace zm_zod_beastcode
// Params 0
// Checksum 0xa3b990ef, Offset: 0x690
// Size: 0x24
function keeper_sword_locker_open_locker()
{
    level flag::set( "keeper_sword_locker" );
}

