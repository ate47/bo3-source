#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;

#namespace zm_zod_bridges;

#using_animtree( "generic" );

// Namespace zm_zod_bridges
// Method(s) 7 Total 7
class cbridge
{

    // Namespace cbridge
    // Params 0
    // Checksum 0xe2e1d080, Offset: 0xb38
    // Size: 0x44
    function move_blocker()
    {
        self moveto( self.origin - ( 0, 0, 10000 ), 0.05 );
        wait 0.05;
    }

    // Namespace cbridge
    // Params 0
    // Checksum 0xb3e1e759, Offset: 0xa80
    // Size: 0xac
    function unlock_zones()
    {
        str_zonename = self.m_str_areaname + "_district_zone_high";
        
        if ( !zm_zonemgr::zone_is_enabled( str_zonename ) )
        {
            zm_zonemgr::zone_init( str_zonename );
            zm_zonemgr::enable_zone( str_zonename );
        }
        
        zm_zonemgr::add_adjacent_zone( self.m_str_areaname + "_district_zone_B", str_zonename, "enter_" + self.m_str_areaname + "_district_high_from_B" );
    }

    // Namespace cbridge
    // Params 2
    // Checksum 0xceed0c4d, Offset: 0x8a8
    // Size: 0x1cc
    function bridge_connect( t_trigger_a, t_trigger_b )
    {
        util::waittill_any_ents_two( t_trigger_a, "trigger", t_trigger_b, "trigger" );
        
        foreach ( e_blocker in self.m_a_e_blockers )
        {
            e_blocker setanim( %p7_fxanim_zm_zod_gate_scissor_short_open_anim );
        }
        
        self.m_e_walkway setanim( %p7_fxanim_zm_zod_beast_bridge_open_anim );
        self.m_e_walkway setvisibletoall();
        self.m_e_pull_target setinvisibletoall();
        self.m_e_pull_target clientfield::set( "bminteract", 0 );
        self.m_e_pull_target setgrapplabletype( 0 );
        level.beast_mode_targets = array::exclude( level.beast_mode_targets, self.m_e_pull_target );
        wait 1;
        self.m_e_clip_blocker move_blocker();
        self.m_e_clip_blocker connectpaths();
        unlock_zones();
    }

    // Namespace cbridge
    // Params 2
    // Checksum 0x5a78bae8, Offset: 0x858
    // Size: 0x48, Type: bool
    function filter_areaname( e_entity, str_areaname )
    {
        if ( !isdefined( e_entity.script_string ) || e_entity.script_string != str_areaname )
        {
            return false;
        }
        
        return true;
    }

    // Namespace cbridge
    // Params 1
    // Checksum 0x5ffbac61, Offset: 0x488
    // Size: 0x3c4
    function init_bridge( str_areaname )
    {
        self.m_str_areaname = str_areaname;
        m_n_state = 0;
        m_n_pause_between_steps = 0.1;
        door_name = str_areaname + "_bridge_door";
        m_door_array = getentarray( door_name, "script_noteworthy" );
        self.m_a_e_blockers = getentarray( "bridge_blocker", "targetname" );
        a_e_clip_blockers = getentarray( "bridge_clip_blocker", "targetname" );
        a_e_walkway = getentarray( "bridge_walkway", "targetname" );
        a_t_pull_trigger = getentarray( "bridge_pull_trigger", "targetname" );
        a_e_pull_target = getentarray( "bridge_pull_target", "targetname" );
        self.m_a_e_blockers = array::filter( self.m_a_e_blockers, 0, &filter_areaname, str_areaname );
        a_e_clip_blockers = array::filter( a_e_clip_blockers, 0, &filter_areaname, str_areaname );
        self.m_e_clip_blocker = a_e_clip_blockers[ 0 ];
        a_e_walkway = array::filter( a_e_walkway, 0, &filter_areaname, str_areaname );
        self.m_e_walkway = a_e_walkway[ 0 ];
        a_e_pull_target = array::filter( a_e_pull_target, 0, &filter_areaname, str_areaname );
        self.m_e_pull_target = a_e_pull_target[ 0 ];
        self.m_b_discovered = 0;
        self.m_e_walkway setinvisibletoall();
        
        foreach ( e_blocker in self.m_a_e_blockers )
        {
            e_blocker useanimtree( #animtree );
        }
        
        self.m_e_walkway useanimtree( #animtree );
        self.m_e_pull_target setgrapplabletype( 3 );
        array::add( level.beast_mode_targets, self.m_e_pull_target, 0 );
        self.m_e_pull_target clientfield::set( "bminteract", 3 );
        self thread bridge_connect( m_door_array[ 0 ], m_door_array[ 1 ] );
    }

}

// Namespace zm_zod_bridges
// Params 0, eflags: 0x2
// Checksum 0xd1f51ee3, Offset: 0x330
// Size: 0x2c
function autoexec __init__sytem__()
{
    system::register( "zm_zod_bridges", undefined, &__main__, undefined );
}

// Namespace zm_zod_bridges
// Params 0
// Checksum 0x9b24a9a6, Offset: 0x368
// Size: 0x1c
function __main__()
{
    level thread init_bridges();
}

// Namespace zm_zod_bridges
// Params 0
// Checksum 0xee322fe9, Offset: 0x390
// Size: 0x94
function init_bridges()
{
    if ( !isdefined( level.beast_mode_targets ) )
    {
        level.beast_mode_targets = [];
    }
    
    if ( !isdefined( level.a_o_bridge ) )
    {
        level.a_o_bridge = [];
        init_bridge( "slums", 1 );
        init_bridge( "canal", 2 );
        init_bridge( "theater", 3 );
    }
}

// Namespace zm_zod_bridges
// Params 2
// Checksum 0x645bb9c5, Offset: 0x430
// Size: 0x50
function init_bridge( str_areaname, n_index )
{
    level.a_o_bridge[ n_index ] = new cbridge();
    [[ level.a_o_bridge[ n_index ] ]]->init_bridge( str_areaname );
}

