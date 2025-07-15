#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_powerup_ww_grenade;

// Namespace zm_powerup_ww_grenade
// Params 0, eflags: 0x2
// Checksum 0xd36f6c9a, Offset: 0x368
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_powerup_ww_grenade", &__init__, undefined, undefined );
}

// Namespace zm_powerup_ww_grenade
// Params 0
// Checksum 0xc4ae65d7, Offset: 0x3a8
// Size: 0xdc
function __init__()
{
    zm_powerups::register_powerup( "ww_grenade", &grab_ww_grenade );
    
    if ( tolower( getdvarstring( "g_gametype" ) ) != "zcleansed" )
    {
        zm_powerups::add_zombie_powerup( "ww_grenade", "p7_zm_power_up_widows_wine", &"ZOMBIE_POWERUP_WW_GRENADE", &zm_powerups::func_should_never_drop, 1, 0, 0 );
        zm_powerups::powerup_set_player_specific( "ww_grenade", 1 );
    }
    
    /#
        level thread ww_grenade_devgui();
    #/
}

// Namespace zm_powerup_ww_grenade
// Params 1
// Checksum 0x79ea64f5, Offset: 0x490
// Size: 0x44
function grab_ww_grenade( player )
{
    level thread ww_grenade_powerup( self, player );
    player thread zm_powerups::powerup_vo( "bonus_points_solo" );
}

// Namespace zm_powerup_ww_grenade
// Params 2
// Checksum 0x12de9328, Offset: 0x4e0
// Size: 0x144
function ww_grenade_powerup( item, player )
{
    if ( !player laststand::player_is_in_laststand() && !( player.sessionstate == "spectator" ) )
    {
        if ( player hasperk( "specialty_widowswine" ) )
        {
            change = 1;
            oldammo = player getweaponammoclip( player.current_lethal_grenade );
            maxammo = player.current_lethal_grenade.startammo;
            newammo = int( min( maxammo, max( 0, oldammo + change ) ) );
            player setweaponammoclip( player.current_lethal_grenade, newammo );
        }
    }
}

/#

    // Namespace zm_powerup_ww_grenade
    // Params 0
    // Checksum 0xcc671cc9, Offset: 0x630
    // Size: 0x7c, Type: dev
    function ww_grenade_devgui()
    {
        level flagsys::wait_till( "<dev string:x28>" );
        wait 1;
        zm_devgui::add_custom_devgui_callback( &ww_grenade_devgui_callback );
        adddebugcommand( "<dev string:x41>" );
        adddebugcommand( "<dev string:x8c>" );
    }

    // Namespace zm_powerup_ww_grenade
    // Params 0
    // Checksum 0xd22e48ff, Offset: 0x6b8
    // Size: 0x38, Type: dev
    function detect_reentry()
    {
        if ( isdefined( self.var_2654b40c ) )
        {
            if ( self.var_2654b40c == gettime() )
            {
                return 1;
            }
        }
        
        self.var_2654b40c = gettime();
        return 0;
    }

    // Namespace zm_powerup_ww_grenade
    // Params 1
    // Checksum 0x68d49251, Offset: 0x6f8
    // Size: 0x110, Type: dev
    function ww_grenade_devgui_callback( cmd )
    {
        players = getplayers();
        retval = 0;
        
        switch ( cmd )
        {
            default:
                if ( level detect_reentry() )
                {
                    return 1;
                }
                
                array::thread_all( players, &zm_devgui::zombie_devgui_give_powerup_player, cmd, 1 );
                return 1;
            case "<dev string:xea>":
                if ( level detect_reentry() )
                {
                    return 1;
                }
                
                array::thread_all( players, &zm_devgui::zombie_devgui_give_powerup_player, getsubstr( cmd, 5 ), 0 );
                return 1;
        }
        
        return retval;
    }

#/
