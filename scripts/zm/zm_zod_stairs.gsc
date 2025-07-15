#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
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
#using scripts/zm/zm_zod_poweronswitch;

#namespace zm_zod_stairs;

// Namespace zm_zod_stairs
// Method(s) 12 Total 12
class cstair
{

    // Namespace cstair
    // Params 0
    // Checksum 0x51e71b8a, Offset: 0xeb0
    // Size: 0x44
    function move_blocker()
    {
        self moveto( self.origin - ( 0, 0, 10000 ), 0.05 );
        wait 0.05;
    }

    // Namespace cstair
    // Params 4
    // Checksum 0xdf28c6e0, Offset: 0xe58
    // Size: 0x4c
    function function_15ee241e( e_mover, v_angles, n_rotate, n_duration )
    {
        e_mover rotateto( v_angles + ( 0, n_rotate, 0 ), n_duration );
    }

    // Namespace cstair
    // Params 4
    // Checksum 0x1d4685a5, Offset: 0xdb8
    // Size: 0x94
    function element_move( e_mover, b_is_extending, n_step_rise_distance, n_duration )
    {
        if ( !b_is_extending )
        {
            n_step_rise_distance *= -1;
        }
        
        v_offset = anglestoup( ( 0, 0, 0 ) ) * n_step_rise_distance;
        e_mover moveto( e_mover.origin + v_offset, n_duration );
    }

    // Namespace cstair
    // Params 2
    // Checksum 0xf80d374f, Offset: 0x870
    // Size: 0x53c
    function stair_move( b_is_extending, b_is_instant )
    {
        if ( self.m_str_areaname != "underground" && self.m_str_areaname != "club" && b_is_extending && !b_is_instant )
        {
            self.var_f2f66550[ 0 ] scene::play( "p7_fxanim_zm_zod_mechanical_stairs_bundle" );
            
            foreach ( e_gate in self.var_39624e3b )
            {
                e_gate thread scene::play( "p7_fxanim_zm_zod_gate_scissor_short_bundle" );
            }
            
            self.m_n_state = 2;
            self.m_a_e_clip[ 0 ] move_blocker();
            self.m_a_e_clip[ 0 ] connectpaths();
            return;
        }
        
        if ( b_is_instant )
        {
            n_step_rise_duration = 0.05;
            n_barricade_duration = 0.05;
        }
        else
        {
            n_step_rise_duration = 0.5;
            n_barricade_duration = 0.25;
        }
        
        if ( b_is_extending )
        {
            self.m_n_state = 1;
        }
        else
        {
            self.m_n_state = 3;
        }
        
        if ( !b_is_extending )
        {
            foreach ( e_blocker in self.m_a_e_blockers )
            {
                self thread element_move( e_blocker, !b_is_extending, 64, n_barricade_duration );
            }
        }
        
        foreach ( e_step in self.m_a_e_steps )
        {
            if ( b_is_extending && isdefined( e_step.script_noteworthy ) && e_step.script_noteworthy == "swing_door" && isdefined( e_step.angles ) && isdefined( e_step.script_float ) )
            {
                self thread function_15ee241e( e_step, e_step.angles, e_step.script_float, 0.5 );
            }
            else
            {
                self thread element_move( e_step, b_is_extending, e_step.script_int, n_step_rise_duration );
            }
            
            if ( isdefined( self.m_n_pause_between_steps ) )
            {
                wait self.m_n_pause_between_steps;
            }
        }
        
        wait n_step_rise_duration;
        
        if ( b_is_extending )
        {
            foreach ( e_blocker in self.m_a_e_blockers )
            {
                self thread element_move( e_blocker, !b_is_extending, 64, n_barricade_duration );
            }
        }
        
        if ( b_is_extending )
        {
            self.m_n_state = 2;
            self.m_a_e_clip[ 0 ] move_blocker();
            self.m_a_e_clip[ 0 ] connectpaths();
        }
        else
        {
            self.m_n_state = 0;
            self.m_a_e_clip[ 0 ] setvisibletoall();
            self.m_a_e_clip[ 0 ] disconnectpaths();
        }
        
        if ( b_is_extending )
        {
            if ( isdefined( self.m_a_e_steps[ 0 ].script_flag_set ) )
            {
                level flag::set( self.m_a_e_steps[ 0 ].script_flag_set );
            }
        }
    }

    // Namespace cstair
    // Params 0
    // Checksum 0x73f11971, Offset: 0x838
    // Size: 0x2c
    function stair_wait()
    {
        level flag::wait_till( "power_on" + self.m_n_power_index );
    }

    // Namespace cstair
    // Params 0
    // Checksum 0x4cc52059, Offset: 0x800
    // Size: 0x2c
    function stair_think()
    {
        stair_wait();
        stair_move( 1, 0 );
    }

    // Namespace cstair
    // Params 0
    // Checksum 0xc0dfd74f, Offset: 0x7e8
    // Size: 0x10
    function get_blocker()
    {
        return self.m_a_e_blockers[ 0 ];
    }

    // Namespace cstair
    // Params 2
    // Checksum 0xdfc8a256, Offset: 0x798
    // Size: 0x48, Type: bool
    function filter_areaname( e_entity, str_areaname )
    {
        if ( !isdefined( e_entity.script_string ) || e_entity.script_string != str_areaname )
        {
            return false;
        }
        
        return true;
    }

    // Namespace cstair
    // Params 0
    // Checksum 0xe69f1baa, Offset: 0x758
    // Size: 0x34
    function start_stair()
    {
        stair_move( 0, 1 );
        self thread stair_think();
    }

    // Namespace cstair
    // Params 2
    // Checksum 0x9cebafaf, Offset: 0x518
    // Size: 0x234
    function init_stair( str_areaname, n_power_index )
    {
        self.m_n_state = 0;
        self.m_n_pause_between_steps = 0.1;
        self.m_str_areaname = str_areaname;
        self.m_a_e_steps = getentarray( "stair_step", "targetname" );
        self.m_a_e_blockers = getentarray( "stair_blocker", "targetname" );
        self.m_a_e_clip = getentarray( "stair_clip", "targetname" );
        self.var_f2f66550 = struct::get_array( "stair_staircase", "targetname" );
        self.var_39624e3b = struct::get_array( "stair_gate", "targetname" );
        self.m_a_e_steps = array::filter( self.m_a_e_steps, 0, &filter_areaname, str_areaname );
        self.m_a_e_blockers = array::filter( self.m_a_e_blockers, 0, &filter_areaname, str_areaname );
        self.m_a_e_clip = array::filter( self.m_a_e_clip, 0, &filter_areaname, str_areaname );
        self.var_f2f66550 = array::filter( self.var_f2f66550, 0, &filter_areaname, str_areaname );
        self.var_39624e3b = array::filter( self.var_39624e3b, 0, &filter_areaname, str_areaname );
        self.m_n_power_index = n_power_index;
        self.m_b_discovered = 0;
    }

}

// Namespace zm_zod_stairs
// Params 0, eflags: 0x2
// Checksum 0x40bb9f1f, Offset: 0x340
// Size: 0x2c
function autoexec __init__sytem__()
{
    system::register( "zm_zod_stairs", undefined, &__main__, undefined );
}

// Namespace zm_zod_stairs
// Params 0
// Checksum 0x6057b528, Offset: 0x378
// Size: 0x1c
function __main__()
{
    level thread init_stairs();
}

// Namespace zm_zod_stairs
// Params 0
// Checksum 0xc9fa6b54, Offset: 0x3a0
// Size: 0xdc
function init_stairs()
{
    if ( !isdefined( level.a_o_stair ) )
    {
        level.a_o_stair = [];
        init_stair( "slums", 11 );
        init_stair( "canal", 12 );
        init_stair( "theater", 13 );
        init_stair( "start", 14 );
        init_stair( "brothel", 16 );
        init_stair( "underground", 15 );
    }
}

// Namespace zm_zod_stairs
// Params 2
// Checksum 0xef2aa094, Offset: 0x488
// Size: 0x84
function init_stair( str_areaname, n_power_index )
{
    if ( !isdefined( level.a_o_stair[ n_power_index ] ) )
    {
        level.a_o_stair[ n_power_index ] = new cstair();
        [[ level.a_o_stair[ n_power_index ] ]]->init_stair( str_areaname, n_power_index );
        [[ level.a_o_stair[ n_power_index ] ]]->start_stair();
    }
}

