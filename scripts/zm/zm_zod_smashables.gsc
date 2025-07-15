#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_zod_portals;
#using scripts/zm/zm_zod_quest;

#namespace zm_zod_smashables;

// Namespace zm_zod_smashables
// Method(s) 19 Total 19
class csmashable
{

    // Namespace csmashable
    // Params 0
    // Checksum 0xc1bb7744, Offset: 0x448
    // Size: 0x28
    function constructor()
    {
        self.m_a_callbacks = [];
        self.m_a_b_parameters = [];
        self.m_a_e_models = [];
    }

    // Namespace csmashable
    // Params 0
    // Checksum 0x80b5ad1f, Offset: 0x15e0
    // Size: 0x22, Type: bool
    function function_3408f1a2()
    {
        if ( self.var_afea543d && self.var_6e27ff4 )
        {
            return true;
        }
        
        return false;
    }

    // Namespace csmashable
    // Params 1
    // Checksum 0xb649329c, Offset: 0x1558
    // Size: 0x80
    function function_89be164a( e_trigger )
    {
        if ( isdefined( e_trigger.script_int ) && isdefined( e_trigger.script_percent ) )
        {
            self.var_afea543d = e_trigger.script_int;
            self.var_6e27ff4 = e_trigger.script_percent;
            return;
        }
        
        self.var_afea543d = 0;
        self.var_6e27ff4 = 0;
    }

    // Namespace csmashable
    // Params 1
    // Checksum 0x99c7cbb2, Offset: 0x1460
    // Size: 0xec
    function watch_all_damage( e_clip )
    {
        e_clip setcandamage( 1 );
        
        while ( true )
        {
            e_clip waittill( #"damage", n_amt, e_attacker, v_dir, v_pos, str_type );
            
            if ( isdefined( e_attacker.beastmode ) && isdefined( e_attacker ) && isplayer( e_attacker ) && e_attacker.beastmode && str_type === "MOD_MELEE" )
            {
                self.m_e_trigger notify( #"trigger", e_attacker );
                break;
            }
        }
    }

    // Namespace csmashable
    // Params 4
    // Checksum 0x9092c83d, Offset: 0x1168
    // Size: 0x2ea
    function add_callback( fn_callback, param1, param2, param3 )
    {
        assert( isdefined( fn_callback ) && isfunctionptr( fn_callback ) );
        s = spawnstruct();
        s.fn = fn_callback;
        s.params = [];
        
        if ( isdefined( param1 ) )
        {
            if ( !isdefined( s.params ) )
            {
                s.params = [];
            }
            else if ( !isarray( s.params ) )
            {
                s.params = array( s.params );
            }
            
            s.params[ s.params.size ] = param1;
        }
        
        if ( isdefined( param2 ) )
        {
            if ( !isdefined( s.params ) )
            {
                s.params = [];
            }
            else if ( !isarray( s.params ) )
            {
                s.params = array( s.params );
            }
            
            s.params[ s.params.size ] = param2;
        }
        
        if ( isdefined( param3 ) )
        {
            if ( !isdefined( s.params ) )
            {
                s.params = [];
            }
            else if ( !isarray( s.params ) )
            {
                s.params = array( s.params );
            }
            
            s.params[ s.params.size ] = param3;
        }
        
        if ( !isdefined( self.m_a_callbacks ) )
        {
            self.m_a_callbacks = [];
        }
        else if ( !isarray( self.m_a_callbacks ) )
        {
            self.m_a_callbacks = array( self.m_a_callbacks );
        }
        
        self.m_a_callbacks[ self.m_a_callbacks.size ] = s;
    }

    // Namespace csmashable
    // Params 0, eflags: 0x4
    // Checksum 0x2a99ccba, Offset: 0xfe0
    // Size: 0x180
    function private execute_callbacks()
    {
        foreach ( s_cb in self.m_a_callbacks )
        {
            switch ( s_cb.params.size )
            {
                case 0:
                    self thread [[ s_cb.fn ]]();
                    break;
                case 1:
                    self thread [[ s_cb.fn ]]( s_cb.params[ 0 ] );
                    break;
                case 2:
                    self thread [[ s_cb.fn ]]( s_cb.params[ 0 ], s_cb.params[ 1 ] );
                    break;
                case 3:
                    self thread [[ s_cb.fn ]]( s_cb.params[ 0 ], s_cb.params[ 1 ], s_cb.params[ 2 ] );
                    break;
            }
        }
    }

    // Namespace csmashable
    // Params 0, eflags: 0x4
    // Checksum 0x9c3fa03f, Offset: 0xd30
    // Size: 0x2a8
    function private main()
    {
        self.m_e_trigger waittill( #"trigger", who );
        
        if ( isdefined( who ) )
        {
            who notify( #"smashable_smashed" );
        }
        
        foreach ( model in self.m_a_e_models )
        {
            if ( model.targetname == "fxanim_beast_door" )
            {
                model playsound( "zmb_bm_interaction_door" );
            }
            
            if ( model.targetname == "fxanim_crate_breakable_01" )
            {
                model playsound( "zmb_bm_interaction_crate_large" );
            }
            
            if ( model.targetname == "fxanim_crate_breakable_02" )
            {
                model playsound( "zmb_bm_interaction_crate_small" );
            }
            
            if ( model.targetname == "fxanim_crate_breakable_03" )
            {
                model playsound( "zmb_bm_interaction_crate_small" );
            }
        }
        
        execute_callbacks();
        
        foreach ( e_clip in self.m_a_clip )
        {
            e_clip delete();
        }
        
        toggle_shader( 0 );
        fadeout_shader( 0 );
        
        if ( isdefined( self.m_e_trigger.script_flag_set ) )
        {
            level flag::set( self.m_e_trigger.script_flag_set );
        }
        
        if ( isdefined( self.m_func_trig ) )
        {
            [[ self.m_func_trig ]]( self.m_arg );
        }
    }

    // Namespace csmashable
    // Params 0, eflags: 0x4
    // Checksum 0x4bc00414, Offset: 0xcf8
    // Size: 0x2c
    function private function_387c449e()
    {
        self waittill( #"hash_13f02a5d" );
        self clientfield::set( "set_fade_material", 0 );
    }

    // Namespace csmashable
    // Params 0, eflags: 0x4
    // Checksum 0x3f763d8e, Offset: 0xcb8
    // Size: 0x36
    function private function_d8055c34()
    {
        self thread function_387c449e();
        wait 10;
        
        if ( isdefined( self ) )
        {
            self notify( #"hash_13f02a5d" );
        }
    }

    // Namespace csmashable
    // Params 1, eflags: 0x4
    // Checksum 0xecda0067, Offset: 0xbf0
    // Size: 0xba
    function private fadeout_shader( b_shader_on )
    {
        foreach ( e_model in self.m_a_e_models )
        {
            if ( b_shader_on )
            {
                e_model clientfield::set( "set_fade_material", 1 );
                continue;
            }
            
            e_model thread function_d8055c34();
        }
    }

    // Namespace csmashable
    // Params 1, eflags: 0x4
    // Checksum 0x2f57be24, Offset: 0xb40
    // Size: 0xa8
    function private toggle_shader( b_shader_on )
    {
        foreach ( e_model in self.m_a_e_models )
        {
            e_model clientfield::set( "bminteract", b_shader_on );
        }
        
        self.m_b_shader_on = b_shader_on;
    }

    // Namespace csmashable
    // Params 0
    // Checksum 0x28b91ca8, Offset: 0xae0
    // Size: 0x54
    function function_82bc26b5()
    {
        wait 1;
        level clientfield::set( "breakable_show", self.var_afea543d );
        level clientfield::set( "breakable_hide", self.var_6e27ff4 );
    }

    // Namespace csmashable
    // Params 0, eflags: 0x4
    // Checksum 0x10f788af, Offset: 0x978
    // Size: 0x15c
    function private setup_fxanims()
    {
        s_bundle_inst = struct::get( self.m_e_trigger.target, "targetname" );
        
        if ( isdefined( s_bundle_inst ) && isdefined( s_bundle_inst.scriptbundlename ) )
        {
            if ( !isdefined( level.zod_smashable_scriptbundles ) )
            {
                level.zod_smashable_scriptbundles = [];
            }
            
            if ( !isdefined( level.zod_smashable_scriptbundles[ s_bundle_inst.scriptbundlename ] ) )
            {
                level.zod_smashable_scriptbundles[ s_bundle_inst.scriptbundlename ] = s_bundle_inst.scriptbundlename;
            }
            
            if ( function_3408f1a2() )
            {
                self thread function_82bc26b5();
            }
            else
            {
                level scene::init( self.m_e_trigger.target, "targetname" );
            }
            
            var_5b3a6271 = function_3408f1a2();
            add_callback( &zm_zod_smashables::cb_fxanim, var_5b3a6271, self.var_afea543d, self.var_6e27ff4 );
        }
    }

    // Namespace csmashable
    // Params 1
    // Checksum 0xc0bb2836, Offset: 0x890
    // Size: 0xdc
    function add_model( e_model )
    {
        if ( !isdefined( self.m_a_e_models ) )
        {
            self.m_a_e_models = [];
        }
        else if ( !isarray( self.m_a_e_models ) )
        {
            self.m_a_e_models = array( self.m_a_e_models );
        }
        
        self.m_a_e_models[ self.m_a_e_models.size ] = e_model;
        
        if ( has_parameter( "any_damage" ) )
        {
            thread watch_all_damage( e_model );
        }
        
        toggle_shader( self.m_b_shader_on );
        fadeout_shader( 1 );
    }

    // Namespace csmashable
    // Params 1
    // Checksum 0xf0928bec, Offset: 0x858
    // Size: 0x2c, Type: bool
    function has_parameter( str_parameter )
    {
        return isdefined( self.m_a_b_parameters[ str_parameter ] ) && self.m_a_b_parameters[ str_parameter ];
    }

    // Namespace csmashable
    // Params 0, eflags: 0x4
    // Checksum 0xdf483ab, Offset: 0x660
    // Size: 0x1ea
    function private parse_parameters()
    {
        if ( !isdefined( self.m_e_trigger.script_parameters ) )
        {
            return;
        }
        
        a_params = strtok( self.m_e_trigger.script_parameters, "," );
        
        foreach ( str_param in a_params )
        {
            self.m_a_b_parameters[ str_param ] = 1;
            
            if ( str_param == "connect_paths" )
            {
                add_callback( &zm_zod_smashables::cb_connect_paths );
                continue;
            }
            
            if ( str_param == "any_damage" )
            {
                foreach ( e_clip in self.m_a_clip )
                {
                    thread watch_all_damage( e_clip );
                }
                
                continue;
            }
            
            assertmsg( "<dev string:x28>" + str_param + "<dev string:x43>" + self.m_e_trigger.targetname + "<dev string:x54>" );
        }
    }

    // Namespace csmashable
    // Params 2
    // Checksum 0x9b0e0a50, Offset: 0x628
    // Size: 0x2c
    function set_trigger_func( func_trig, arg )
    {
        self.m_func_trig = func_trig;
        self.m_arg = arg;
    }

    // Namespace csmashable
    // Params 1
    // Checksum 0x1cbc39f5, Offset: 0x478
    // Size: 0x1a4
    function init( e_trigger )
    {
        self.m_e_trigger = e_trigger;
        self.m_a_clip = getentarray( e_trigger.target, "targetname" );
        self.m_a_nodes = getnodearray( e_trigger.target, "targetname" );
        
        foreach ( node in self.m_a_nodes )
        {
            if ( isdefined( node.script_noteworthy ) && node.script_noteworthy == "air_beast_node" )
            {
                unlinktraversal( node );
            }
        }
        
        function_89be164a( e_trigger );
        setup_fxanims();
        parse_parameters();
        toggle_shader( 1 );
        fadeout_shader( 1 );
        thread main();
    }

}

// Namespace zm_zod_smashables
// Params 0, eflags: 0x2
// Checksum 0x873314bf, Offset: 0x408
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_zod_smashables", &__init__, undefined, undefined );
}

// Namespace zm_zod_smashables
// Params 0
// Checksum 0x6a6bfee7, Offset: 0x19e0
// Size: 0xb2
function __init__()
{
    level thread init_smashables();
    
    foreach ( str_bundle in level.zod_smashable_scriptbundles )
    {
        scene::add_scene_func( str_bundle, &add_scriptbundle_models, "init" );
    }
}

// Namespace zm_zod_smashables
// Params 1, eflags: 0x4
// Checksum 0xee087432, Offset: 0x1aa0
// Size: 0xbe
function private smashable_from_scriptbundle_targetname( str_targetname )
{
    foreach ( o_smash in level.zod_smashables )
    {
        if ( isdefined( o_smash.m_e_trigger.target ) && o_smash.m_e_trigger.target == str_targetname )
        {
            return o_smash;
        }
    }
    
    return undefined;
}

// Namespace zm_zod_smashables
// Params 1, eflags: 0x4
// Checksum 0xd83fc7c7, Offset: 0x1b68
// Size: 0xe6
function private add_scriptbundle_models( a_models )
{
    o_smash = undefined;
    
    foreach ( e_model in a_models )
    {
        if ( !isdefined( o_smash ) )
        {
            o_smash = smashable_from_scriptbundle_targetname( e_model._o_scene._e_root.targetname );
        }
        
        if ( isdefined( o_smash ) )
        {
            [[ o_smash ]]->add_model( e_model );
        }
    }
}

// Namespace zm_zod_smashables
// Params 0, eflags: 0x4
// Checksum 0xe898167c, Offset: 0x1c58
// Size: 0x29a
function private init_smashables()
{
    level.zod_smashables = [];
    a_smashable_triggers = getentarray( "beast_melee_only", "script_noteworthy" );
    n_id = 0;
    
    foreach ( trigger in a_smashable_triggers )
    {
        str_id = "smash_unnamed_" + n_id;
        
        if ( isdefined( trigger.targetname ) )
        {
            str_id = trigger.targetname;
        }
        else
        {
            trigger.targetname = str_id;
            n_id++;
        }
        
        if ( isdefined( level.zod_smashables[ str_id ] ) )
        {
            assertmsg( "<dev string:x56>" + str_id + "<dev string:x81>" );
            continue;
        }
        
        o_smashable = new csmashable();
        level.zod_smashables[ str_id ] = o_smashable;
        
        if ( issubstr( str_id, "portal" ) )
        {
            [[ o_smashable ]]->set_trigger_func( &zm_zod_portals::function_54ec766b, str_id );
        }
        
        if ( issubstr( str_id, "memento" ) )
        {
            [[ o_smashable ]]->set_trigger_func( &zm_zod_quest::reveal_personal_item, str_id );
        }
        
        if ( issubstr( str_id, "beast_kiosk" ) )
        {
            [[ o_smashable ]]->set_trigger_func( &unlock_beast_kiosk, str_id );
        }
        
        if ( str_id === "unlock_quest_key" )
        {
            [[ o_smashable ]]->set_trigger_func( &unlock_quest_key, str_id );
        }
        
        [[ o_smashable ]]->init( trigger );
    }
}

// Namespace zm_zod_smashables
// Params 1
// Checksum 0x194d5801, Offset: 0x1f00
// Size: 0x4c
function unlock_beast_kiosk( str_id )
{
    unlock_beast_trigger( "beast_mode_kiosk_unavailable", str_id );
    unlock_beast_trigger( "beast_mode_kiosk", str_id );
}

// Namespace zm_zod_smashables
// Params 2
// Checksum 0xc71a8978, Offset: 0x1f58
// Size: 0xda
function unlock_beast_trigger( str_targetname, str_id )
{
    triggers = getentarray( str_targetname, "targetname" );
    
    foreach ( trigger in triggers )
    {
        if ( trigger.script_noteworthy === str_id )
        {
            trigger.is_unlocked = 1;
        }
    }
}

// Namespace zm_zod_smashables
// Params 1
// Checksum 0xbd1dd1bd, Offset: 0x2040
// Size: 0x18
function unlock_quest_key( str_id )
{
    level.quest_key_can_be_picked_up = 1;
}

// Namespace zm_zod_smashables
// Params 5
// Checksum 0xf72c2cb0, Offset: 0x2060
// Size: 0xa8
function add_callback( targetname, fn_callback, param1, param2, param3 )
{
    o_smashable = level.zod_smashables[ targetname ];
    
    if ( !isdefined( o_smashable ) )
    {
        assertmsg( "<dev string:x83>" + targetname + "<dev string:xc4>" );
        return;
    }
    
    [[ o_smashable ]]->add_callback( fn_callback, param1, param2, param3 );
}

// Namespace zm_zod_smashables
// Params 0, eflags: 0x4
// Checksum 0x3e491af4, Offset: 0x2110
// Size: 0xe2
function private cb_connect_paths()
{
    self.m_a_clip[ 0 ] connectpaths();
    
    if ( isdefined( self.m_a_nodes ) )
    {
        foreach ( node in self.m_a_nodes )
        {
            if ( isdefined( node.script_noteworthy ) && node.script_noteworthy == "air_beast_node" )
            {
                linktraversal( node );
            }
        }
    }
}

// Namespace zm_zod_smashables
// Params 3, eflags: 0x4
// Checksum 0xef2183cd, Offset: 0x2200
// Size: 0xd4
function private cb_fxanim( var_5b3a6271, var_bc554281, var_6bf8cfb8 )
{
    str_fxanim = self.m_e_trigger.target;
    s_fxanim = struct::get( str_fxanim, "targetname" );
    
    if ( var_bc554281 )
    {
        level clientfield::set( "breakable_hide", var_bc554281 );
    }
    
    level scene::play( str_fxanim, "targetname" );
    
    if ( var_6bf8cfb8 )
    {
        level clientfield::set( "breakable_show", var_6bf8cfb8 );
    }
}

