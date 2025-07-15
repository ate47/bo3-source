#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_powerup_empty_perk;

// Namespace zm_powerup_empty_perk
// Params 0, eflags: 0x2
// Checksum 0xb25eb9fa, Offset: 0x2f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_powerup_empty_perk", &__init__, undefined, undefined );
}

// Namespace zm_powerup_empty_perk
// Params 0
// Checksum 0x92939947, Offset: 0x338
// Size: 0xec
function __init__()
{
    zm_powerups::register_powerup( "empty_perk", &function_59e7b1f8 );
    
    if ( tolower( getdvarstring( "g_gametype" ) ) != "zcleansed" )
    {
        zm_powerups::add_zombie_powerup( "empty_perk", "zombie_pickup_perk_bottle", &"", &zm_powerups::func_should_never_drop, 1, 0, 0 );
        zm_powerups::powerup_set_statless_powerup( "empty_perk" );
    }
    
    level.get_player_perk_purchase_limit = &function_c396add0;
    
    /#
        thread function_ac499d74();
    #/
}

// Namespace zm_powerup_empty_perk
// Params 1
// Checksum 0xe59ec9fa, Offset: 0x430
// Size: 0x24
function function_59e7b1f8( player )
{
    player thread function_ba8751f2();
}

// Namespace zm_powerup_empty_perk
// Params 0
// Checksum 0xd20565be, Offset: 0x460
// Size: 0x3c
function function_ba8751f2()
{
    if ( !isdefined( self.player_perk_purchase_limit ) )
    {
        self.player_perk_purchase_limit = level.perk_purchase_limit;
    }
    
    if ( self.player_perk_purchase_limit < level.var_1eddc9ee )
    {
        self.player_perk_purchase_limit++;
    }
}

// Namespace zm_powerup_empty_perk
// Params 0
// Checksum 0x7648fc35, Offset: 0x4a8
// Size: 0x26
function function_c396add0()
{
    if ( !isdefined( self.player_perk_purchase_limit ) )
    {
        self.player_perk_purchase_limit = level.perk_purchase_limit;
    }
    
    return self.player_perk_purchase_limit;
}

/#

    // Namespace zm_powerup_empty_perk
    // Params 0
    // Checksum 0x310c5fd1, Offset: 0x4d8
    // Size: 0x7c, Type: dev
    function function_ac499d74()
    {
        level flagsys::wait_till( "<dev string:x28>" );
        wait 1;
        zm_devgui::add_custom_devgui_callback( &function_5d69c3e );
        adddebugcommand( "<dev string:x41>" );
        adddebugcommand( "<dev string:x8c>" );
    }

    // Namespace zm_powerup_empty_perk
    // Params 1
    // Checksum 0xf3ace2cd, Offset: 0x560
    // Size: 0xb4, Type: dev
    function function_5d69c3e( cmd )
    {
        players = getplayers();
        retval = 0;
        
        switch ( cmd )
        {
            case "<dev string:xdf>":
                zm_devgui::zombie_devgui_give_powerup( cmd, 1 );
                break;
            default:
                zm_devgui::zombie_devgui_give_powerup( getsubstr( cmd, 5 ), 0 );
                break;
        }
        
        return retval;
    }

#/
