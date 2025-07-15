#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_powerup_beast_mana;

// Namespace zm_powerup_beast_mana
// Params 0, eflags: 0x2
// Checksum 0x10d4fc6b, Offset: 0x340
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_powerup_beast_mana", &__init__, undefined, undefined );
}

// Namespace zm_powerup_beast_mana
// Params 0
// Checksum 0x23a9d5cf, Offset: 0x380
// Size: 0xa4
function __init__()
{
    zm_powerups::register_powerup( "beast_mana", &grab_beast_mana );
    
    if ( tolower( getdvarstring( "g_gametype" ) ) != "zcleansed" )
    {
        zm_powerups::add_zombie_powerup( "beast_mana", "zombie_z_money_icon", &"ZM_ZOD_POWERUP_BEAST_MANA", &zm_powerups::func_should_never_drop, 1, 0, 0 );
    }
}

// Namespace zm_powerup_beast_mana
// Params 1
// Checksum 0x7fed1127, Offset: 0x430
// Size: 0x44
function grab_beast_mana( player )
{
    level thread beast_mana_powerup( self, player );
    player thread zm_powerups::powerup_vo( "bonus_points_solo" );
}

// Namespace zm_powerup_beast_mana
// Params 2
// Checksum 0x168e0b4d, Offset: 0x480
// Size: 0x12c
function beast_mana_powerup( item, player )
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !players[ i ] laststand::player_is_in_laststand() && !( players[ i ].sessionstate == "spectator" ) )
        {
            if ( isdefined( players[ i ].beastmode ) && players[ i ].beastmode )
            {
                players[ i ].beastmana = 1;
                continue;
            }
            
            players[ i ].beastlives++;
        }
    }
    
    level thread mana_on_hud( item, player.team );
}

// Namespace zm_powerup_beast_mana
// Params 2
// Checksum 0x189de10b, Offset: 0x5b8
// Size: 0x124
function mana_on_hud( drop_item, player_team )
{
    self endon( #"disconnect" );
    hudelem = hud::createserverfontstring( "objective", 2, player_team );
    hudelem hud::setpoint( "TOP", undefined, 0, level.zombie_vars[ "zombie_timer_offset" ] - level.zombie_vars[ "zombie_timer_offset_interval" ] * 2 );
    hudelem.sort = 0.5;
    hudelem.alpha = 0;
    hudelem fadeovertime( 0.5 );
    hudelem.alpha = 1;
    
    if ( isdefined( drop_item ) )
    {
        hudelem.label = drop_item.hint;
    }
    
    hudelem thread full_ammo_move_hud( player_team );
}

// Namespace zm_powerup_beast_mana
// Params 1
// Checksum 0x4ee9d9a3, Offset: 0x6e8
// Size: 0xd4
function full_ammo_move_hud( player_team )
{
    players = getplayers( player_team );
    players[ 0 ] playsoundtoteam( "zmb_full_ammo", player_team );
    wait 0.5;
    move_fade_time = 1.5;
    self fadeovertime( move_fade_time );
    self moveovertime( move_fade_time );
    self.y = 270;
    self.alpha = 0;
    wait move_fade_time;
    self destroy();
}

