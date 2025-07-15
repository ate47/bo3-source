#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_powerup_free_perk;

// Namespace zm_powerup_free_perk
// Params 0, eflags: 0x2
// Checksum 0xe7d34556, Offset: 0x310
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_powerup_free_perk", &__init__, undefined, undefined );
}

// Namespace zm_powerup_free_perk
// Params 0
// Checksum 0x8ca9df50, Offset: 0x350
// Size: 0x9c
function __init__()
{
    zm_powerups::register_powerup( "free_perk", &grab_free_perk );
    
    if ( tolower( getdvarstring( "g_gametype" ) ) != "zcleansed" )
    {
        zm_powerups::add_zombie_powerup( "free_perk", "zombie_pickup_perk_bottle", &"ZOMBIE_POWERUP_FREE_PERK", &zm_powerups::func_should_never_drop, 0, 0, 0 );
    }
}

// Namespace zm_powerup_free_perk
// Params 1
// Checksum 0x1b7d60af, Offset: 0x3f8
// Size: 0x24
function grab_free_perk( player )
{
    level thread free_perk_powerup( self );
}

// Namespace zm_powerup_free_perk
// Params 1
// Checksum 0x322affb7, Offset: 0x428
// Size: 0x196
function free_perk_powerup( item )
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !players[ i ] laststand::player_is_in_laststand() && !( players[ i ].sessionstate == "spectator" ) )
        {
            player = players[ i ];
            
            if ( isdefined( item.ghost_powerup ) )
            {
                player zm_stats::increment_client_stat( "buried_ghost_perk_acquired", 0 );
                player zm_stats::increment_player_stat( "buried_ghost_perk_acquired" );
                player notify( #"player_received_ghost_round_free_perk" );
            }
            
            free_perk = player zm_perks::give_random_perk();
            
            if ( isdefined( level.disable_free_perks_before_power ) && level.disable_free_perks_before_power )
            {
                player thread disable_perk_before_power( free_perk );
            }
            
            if ( isdefined( free_perk ) && isdefined( level.perk_bought_func ) )
            {
                player [[ level.perk_bought_func ]]( free_perk );
            }
        }
    }
}

// Namespace zm_powerup_free_perk
// Params 1
// Checksum 0x6dad2831, Offset: 0x5c8
// Size: 0xe4
function disable_perk_before_power( perk )
{
    self endon( #"disconnect" );
    
    if ( isdefined( perk ) )
    {
        wait 0.1;
        
        if ( !level flag::get( "power_on" ) )
        {
            a_players = getplayers();
            
            if ( isdefined( a_players ) && a_players.size == 1 && perk == "specialty_quickrevive" )
            {
                return;
            }
            
            self zm_perks::perk_pause( perk );
            level flag::wait_till( "power_on" );
            self zm_perks::perk_unpause( perk );
        }
    }
}

