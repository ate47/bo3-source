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
#using scripts/zm/zm_tomb_craftables;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_vo;

#namespace zm_tomb_ee_main_step_1;

// Namespace zm_tomb_ee_main_step_1
// Params 0
// Checksum 0x9491bd93, Offset: 0x280
// Size: 0x54
function init()
{
    zm_sidequests::declare_sidequest_stage( "little_girl_lost", "step_1", &init_stage, &stage_logic, &exit_stage );
}

// Namespace zm_tomb_ee_main_step_1
// Params 0
// Checksum 0x7572f9a6, Offset: 0x2e0
// Size: 0x14
function init_stage()
{
    level._cur_stage_name = "step_1";
}

// Namespace zm_tomb_ee_main_step_1
// Params 0
// Checksum 0x392795d, Offset: 0x300
// Size: 0x7c
function stage_logic()
{
    /#
        iprintln( level._cur_stage_name + "<dev string:x28>" );
    #/
    
    level flag::wait_till( "ee_all_staffs_upgraded" );
    util::wait_network_frame();
    zm_sidequests::stage_completed( "little_girl_lost", level._cur_stage_name );
}

// Namespace zm_tomb_ee_main_step_1
// Params 1
// Checksum 0x342996aa, Offset: 0x388
// Size: 0x1a
function exit_stage( success )
{
    level notify( #"hash_e6967d42" );
}

