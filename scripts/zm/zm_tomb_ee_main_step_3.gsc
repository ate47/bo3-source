#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_vo;

#namespace zm_tomb_ee_main_step_3;

// Namespace zm_tomb_ee_main_step_3
// Params 0
// Checksum 0x7d98c26f, Offset: 0x470
// Size: 0x54
function init()
{
    zm_sidequests::declare_sidequest_stage( "little_girl_lost", "step_3", &init_stage, &stage_logic, &exit_stage );
}

// Namespace zm_tomb_ee_main_step_3
// Params 0
// Checksum 0xb44b34fb, Offset: 0x4d0
// Size: 0x3c
function init_stage()
{
    level._cur_stage_name = "step_3";
    level.check_valid_poi = &mech_zombie_hole_valid;
    create_buttons_and_triggers();
}

// Namespace zm_tomb_ee_main_step_3
// Params 0
// Checksum 0x2a196402, Offset: 0x518
// Size: 0x94
function stage_logic()
{
    /#
        iprintln( level._cur_stage_name + "<dev string:x28>" );
    #/
    
    level thread watch_for_triple_attack();
    level flag::wait_till( "ee_mech_zombie_hole_opened" );
    util::wait_network_frame();
    zm_sidequests::stage_completed( "little_girl_lost", level._cur_stage_name );
}

// Namespace zm_tomb_ee_main_step_3
// Params 1
// Checksum 0x6ce2d383, Offset: 0x5b8
// Size: 0x136
function exit_stage( success )
{
    level.check_valid_poi = undefined;
    level notify( #"fire_link_cooldown" );
    level flag::set( "fire_link_enabled" );
    a_buttons = getentarray( "fire_link_button", "targetname" );
    array::delete_all( a_buttons );
    a_structs = struct::get_array( "fire_link", "targetname" );
    
    foreach ( unitrigger_stub in a_structs )
    {
        zm_unitrigger::unregister_unitrigger( unitrigger_stub );
    }
    
    level notify( #"hash_7bcf8600" );
}

// Namespace zm_tomb_ee_main_step_3
// Params 0
// Checksum 0xa159047, Offset: 0x6f8
// Size: 0x1aa
function create_buttons_and_triggers()
{
    a_structs = struct::get_array( "fire_link", "targetname" );
    
    foreach ( unitrigger_stub in a_structs )
    {
        unitrigger_stub.radius = 36;
        unitrigger_stub.height = 256;
        unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
        unitrigger_stub.cursor_hint = "HINT_NOICON";
        unitrigger_stub.require_look_at = 1;
        m_model = spawn( "script_model", unitrigger_stub.origin );
        m_model setmodel( "p7_zm_ori_button_alarm" );
        m_model.angles = unitrigger_stub.angles;
        m_model.targetname = "fire_link_button";
        m_model thread ready_to_activate( unitrigger_stub );
        util::wait_network_frame();
    }
}

// Namespace zm_tomb_ee_main_step_3
// Params 1
// Checksum 0x69d0d61e, Offset: 0x8b0
// Size: 0xa4
function ready_to_activate( unitrigger_stub )
{
    self endon( #"death" );
    self playsoundwithnotify( "vox_maxi_robot_sync_0", "sync_done" );
    self waittill( #"sync_done" );
    wait 0.5;
    self playsoundwithnotify( "vox_maxi_robot_await_0", "ready_to_use" );
    self waittill( #"ready_to_use" );
    zm_unitrigger::register_static_unitrigger( unitrigger_stub, &activate_fire_link );
}

// Namespace zm_tomb_ee_main_step_3
// Params 0
// Checksum 0x6d684f4, Offset: 0x960
// Size: 0x1ba
function watch_for_triple_attack()
{
    t_hole = getent( "fire_link_damage", "targetname" );
    
    while ( !level flag::get( "ee_mech_zombie_hole_opened" ) )
    {
        t_hole waittill( #"damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon );
        
        if ( isdefined( weapon ) && weapon.name == "beacon" && level flag::get( "fire_link_enabled" ) )
        {
            playsoundatposition( "zmb_squest_robot_floor_collapse", t_hole.origin );
            wait 3;
            m_floor = getent( "easter_mechzombie_spawn", "targetname" );
            m_floor delete();
            level flag::set( "ee_mech_zombie_hole_opened" );
            t_hole delete();
            return;
        }
    }
}

// Namespace zm_tomb_ee_main_step_3
// Params 1
// Checksum 0xd0fa915e, Offset: 0xb28
// Size: 0x60
function mech_zombie_hole_valid( valid )
{
    t_hole = getent( "fire_link_damage", "targetname" );
    
    if ( self istouching( t_hole ) )
    {
        return 1;
    }
    
    return valid;
}

// Namespace zm_tomb_ee_main_step_3
// Params 0
// Checksum 0x4564865b, Offset: 0xb90
// Size: 0x176
function activate_fire_link()
{
    self endon( #"kill_trigger" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        self playsound( "zmb_squest_robot_button" );
        
        if ( level flag::get( "three_robot_round" ) )
        {
            level thread fire_link_cooldown( self );
            self playsound( "zmb_squest_robot_button_activate" );
            self playloopsound( "zmb_squest_robot_button_timer", 0.5 );
            level flag::wait_till_clear( "fire_link_enabled" );
            self stoploopsound( 0.5 );
            self playsound( "zmb_squest_robot_button_deactivate" );
            continue;
        }
        
        self playsound( "vox_maxi_robot_abort_0" );
        self playsound( "zmb_squest_robot_button_deactivate" );
        wait 3;
    }
}

// Namespace zm_tomb_ee_main_step_3
// Params 1
// Checksum 0xd24681a6, Offset: 0xd10
// Size: 0xbc
function fire_link_cooldown( t_button )
{
    level notify( #"fire_link_cooldown" );
    level endon( #"fire_link_cooldown" );
    level flag::set( "fire_link_enabled" );
    
    if ( isdefined( t_button ) )
    {
        t_button playsound( "vox_maxi_robot_activated_0" );
    }
    
    wait 35;
    
    if ( isdefined( t_button ) )
    {
        t_button playsound( "vox_maxi_robot_deactivated_0" );
    }
    
    level flag::clear( "fire_link_enabled" );
}

