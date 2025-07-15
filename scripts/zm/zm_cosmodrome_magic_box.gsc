#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;

#namespace zm_cosmodrome_magic_box;

// Namespace zm_cosmodrome_magic_box
// Params 0
// Checksum 0xb4e22bc9, Offset: 0x220
// Size: 0xe4
function magic_box_init()
{
    util::registerclientsys( "box_indicator" );
    level._cosmodrome_no_power = "n";
    level._cosmodrome_fire_sale = "f";
    level._box_locations = array( "start_chest", "chest1", "chest2", "base_entry_chest", "storage_area_chest", "chest5", "chest6", "warehouse_lander_chest" );
    level thread magic_box_update();
    level thread cosmodrome_maintenance_respawn_fix();
    setdvar( "zombiemode_path_minz_bias", 28 );
}

// Namespace zm_cosmodrome_magic_box
// Params 1
// Checksum 0xa18d0f9a, Offset: 0x310
// Size: 0xb4
function get_location_from_chest_index( chest_index )
{
    if ( isdefined( level.chests[ chest_index ] ) )
    {
        chest_loc = level.chests[ chest_index ].script_noteworthy;
        
        for ( i = 0; i < level._box_locations.size ; i++ )
        {
            if ( level._box_locations[ i ] == chest_loc )
            {
                return i;
            }
        }
    }
    
    assertmsg( "<dev string:x28>" + chest_index );
}

// Namespace zm_cosmodrome_magic_box
// Params 0
// Checksum 0x26ee666, Offset: 0x3d0
// Size: 0x2c4
function magic_box_update()
{
    wait 2;
    util::setclientsysstate( "box_indicator", level._cosmodrome_no_power );
    box_mode = "no_power";
    
    while ( true )
    {
        if ( ( !level flag::get( "power_on" ) || level flag::get( "moving_chest_now" ) ) && level.zombie_vars[ "zombie_powerup_fire_sale_on" ] == 0 )
        {
            box_mode = "no_power";
        }
        else if ( isdefined( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] ) && level.zombie_vars[ "zombie_powerup_fire_sale_on" ] == 1 )
        {
            box_mode = "fire_sale";
        }
        else
        {
            box_mode = "box_available";
        }
        
        switch ( box_mode )
        {
            case "no_power":
                util::setclientsysstate( "box_indicator", level._cosmodrome_no_power );
                
                while ( !level flag::get( "power_on" ) && level.zombie_vars[ "zombie_powerup_fire_sale_on" ] == 0 )
                {
                    wait 0.1;
                }
                
                break;
            case "fire_sale":
                util::setclientsysstate( "box_indicator", level._cosmodrome_fire_sale );
                
                while ( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] == 1 )
                {
                    wait 0.1;
                }
                
                break;
            case "box_available":
                util::setclientsysstate( "box_indicator", get_location_from_chest_index( level.chest_index ) );
                
                while ( !level flag::get( "moving_chest_now" ) && level.zombie_vars[ "zombie_powerup_fire_sale_on" ] == 0 && !level flag::get( "launch_activated" ) )
                {
                    wait 0.1;
                }
                
                break;
            default:
                util::setclientsysstate( "box_indicator", level._cosmodrome_no_power );
                break;
        }
        
        wait 1;
    }
}

// Namespace zm_cosmodrome_magic_box
// Params 0
// Checksum 0x5d5a895c, Offset: 0x6a0
// Size: 0x15c
function cosmodrome_maintenance_respawn_fix()
{
    respawn_points = struct::get_array( "player_respawn_point", "targetname" );
    
    for ( i = 0; i < respawn_points.size ; i++ )
    {
        if ( respawn_points[ i ].script_noteworthy == "storage_lander_zone" )
        {
            respawn_positions = struct::get_array( respawn_points[ i ].target, "targetname" );
            
            for ( j = 0; j < respawn_positions.size ; j++ )
            {
                if ( isdefined( respawn_positions[ j ].script_int ) && respawn_positions[ j ].script_int == 1 && respawn_positions[ j ].origin[ 0 ] == -159.5 )
                {
                    respawn_positions[ j ].origin = ( -159.5, -1292.7, -119 );
                }
            }
        }
    }
}

