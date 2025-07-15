#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/zm/zm_sumpf_perks;
#using scripts/zm/zm_sumpf_trap_pendulum;
#using scripts/zm/zm_sumpf_zipline;

#namespace zm_sumpf_magic_box;

// Namespace zm_sumpf_magic_box
// Params 0
// Checksum 0xd83f6499, Offset: 0x2c8
// Size: 0xbc
function magic_box_init()
{
    level thread waitfor_flag_open_chest_location( "nw_magic_box" );
    level thread waitfor_flag_open_chest_location( "ne_magic_box" );
    level thread waitfor_flag_open_chest_location( "se_magic_box" );
    level thread waitfor_flag_open_chest_location( "sw_magic_box" );
    level thread waitfor_flag_open_chest_location( "start_zombie_round_logic" );
    level.pandora_fx_func = &swamp_pandora_fx_func;
}

// Namespace zm_sumpf_magic_box
// Params 0
// Checksum 0x85698f57, Offset: 0x390
// Size: 0xf4
function swamp_pandora_fx_func()
{
    self.pandora_light = spawn( "script_model", self.origin );
    self.pandora_light.angles = self.angles + ( -90, -90, 0 );
    self.pandora_light setmodel( "tag_origin" );
    
    if ( self.script_noteworthy == "start_chest" )
    {
        playfxontag( level._effect[ "lght_marker" ], self.pandora_light, "tag_origin" );
        return;
    }
    
    playfxontag( level._effect[ "lght_marker_old" ], self.pandora_light, "tag_origin" );
}

// Namespace zm_sumpf_magic_box
// Params 1
// Checksum 0xdc865184, Offset: 0x490
// Size: 0x2fa
function waitfor_flag_open_chest_location( which )
{
    wait 3;
    
    switch ( which )
    {
        case "nw_magic_box":
            function_a0db1fb9();
            break;
        case "ne_magic_box":
            level flag::wait_till( "ne_magic_box" );
            level thread zm_sumpf_zipline::initzipline();
            break;
        case "se_magic_box":
            level flag::wait_till( "se_magic_box" );
            break;
        case "sw_magic_box":
            level flag::wait_till( "sw_magic_box" );
            break;
        case "start_zombie_round_logic":
            level flag::wait_till( "start_zombie_round_logic" );
            break;
        default:
            return;
    }
    
    if ( isdefined( level.randomize_perks ) && level.randomize_perks == 0 )
    {
        zm_sumpf_perks::randomize_vending_machines();
        level.vending_model_info = [];
        level.vending_model_info[ level.vending_model_info.size ] = "p7_zm_vending_jugg";
        level.vending_model_info[ level.vending_model_info.size ] = "p7_zm_vending_doubletap2";
        level.vending_model_info[ level.vending_model_info.size ] = "p7_zm_vending_revive";
        level.vending_model_info[ level.vending_model_info.size ] = "p7_zm_vending_sleight";
        level.vending_model_info[ level.vending_model_info.size ] = "p7_zm_vending_three_gun";
        level.randomize_perks = 1;
    }
    
    switch ( which )
    {
        case "nw_magic_box":
            level flag::wait_till( "northwest_building_unlocked" );
            zm_sumpf_perks::vending_randomization_effect( 0 );
            break;
        case "ne_magic_box":
            level flag::wait_till( "northeast_building_unlocked" );
            zm_sumpf_perks::vending_randomization_effect( 1 );
            break;
        case "se_magic_box":
            level flag::wait_till( "southeast_building_unlocked" );
            zm_sumpf_perks::vending_randomization_effect( 2 );
            break;
        default:
            level flag::wait_till( "southwest_building_unlocked" );
            zm_sumpf_perks::vending_randomization_effect( 3 );
            break;
        case "start_zombie_round_logic":
            break;
    }
}

// Namespace zm_sumpf_magic_box
// Params 0
// Checksum 0x1aa1f55a, Offset: 0x798
// Size: 0x124
function function_a0db1fb9()
{
    penbuytrigger = getentarray( "pendulum_buy_trigger", "targetname" );
    
    foreach ( var_d8a7af6f in penbuytrigger )
    {
        var_d8a7af6f sethintstring( &"ZOMBIE_CLEAR_DEBRIS" );
        var_d8a7af6f setcursorhint( "HINT_NOICON" );
    }
    
    level flag::wait_till( "nw_magic_box" );
    zm_sumpf_trap_pendulum::initpendulumtrap();
    array::thread_all( penbuytrigger, &zm_sumpf_trap_pendulum::penthink );
}

