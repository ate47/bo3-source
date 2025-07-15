#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _gadget_hero_weapon;

// Namespace _gadget_hero_weapon
// Params 0, eflags: 0x2
// Checksum 0x3a7d22bd, Offset: 0x240
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_hero_weapon", &__init__, undefined, undefined );
}

// Namespace _gadget_hero_weapon
// Params 0
// Checksum 0x87386b55, Offset: 0x280
// Size: 0xe4
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 14, &gadget_hero_weapon_on_activate, &gadget_hero_weapon_on_off );
    ability_player::register_gadget_possession_callbacks( 14, &gadget_hero_weapon_on_give, &gadget_hero_weapon_on_take );
    ability_player::register_gadget_flicker_callbacks( 14, &gadget_hero_weapon_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 14, &gadget_hero_weapon_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 14, &gadget_hero_weapon_is_flickering );
    ability_player::register_gadget_ready_callbacks( 14, &gadget_hero_weapon_ready );
}

// Namespace _gadget_hero_weapon
// Params 1
// Checksum 0xa5d54ba9, Offset: 0x370
// Size: 0x22
function gadget_hero_weapon_is_inuse( slot )
{
    return self gadgetisactive( slot );
}

// Namespace _gadget_hero_weapon
// Params 1
// Checksum 0x709d7d04, Offset: 0x3a0
// Size: 0x22
function gadget_hero_weapon_is_flickering( slot )
{
    return self gadgetflickering( slot );
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0xce16c13b, Offset: 0x3d0
// Size: 0x14
function gadget_hero_weapon_on_flicker( slot, weapon )
{
    
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0xac8f379b, Offset: 0x3f0
// Size: 0x194
function gadget_hero_weapon_on_give( slot, weapon )
{
    if ( !isdefined( self.pers[ "held_hero_weapon_ammo_count" ] ) )
    {
        self.pers[ "held_hero_weapon_ammo_count" ] = [];
    }
    
    if ( weapon.gadget_power_consume_on_ammo_use || !isdefined( self.pers[ "held_hero_weapon_ammo_count" ][ weapon ] ) )
    {
        self.pers[ "held_hero_weapon_ammo_count" ][ weapon ] = 0;
    }
    
    self setweaponammoclip( weapon, self.pers[ "held_hero_weapon_ammo_count" ][ weapon ] );
    n_ammo = self getammocount( weapon );
    
    if ( n_ammo > 0 )
    {
        stock = self.pers[ "held_hero_weapon_ammo_count" ][ weapon ] - n_ammo;
        
        if ( stock > 0 && !weapon.iscliponly )
        {
            self setweaponammostock( weapon, stock );
        }
        
        self hero_handle_ammo_save( slot, weapon );
        return;
    }
    
    self gadgetcharging( slot, 1 );
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0x8ac5dcb9, Offset: 0x590
// Size: 0x14
function gadget_hero_weapon_on_take( slot, weapon )
{
    
}

// Namespace _gadget_hero_weapon
// Params 0
// Checksum 0x99ec1590, Offset: 0x5b0
// Size: 0x4
function gadget_hero_weapon_on_connect()
{
    
}

// Namespace _gadget_hero_weapon
// Params 0
// Checksum 0x99ec1590, Offset: 0x5c0
// Size: 0x4
function gadget_hero_weapon_on_spawn()
{
    
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0xabb89c15, Offset: 0x5d0
// Size: 0x84
function gadget_hero_weapon_on_activate( slot, weapon )
{
    self.heroweaponkillcount = 0;
    self.heroweaponshots = 0;
    self.heroweaponhits = 0;
    
    if ( !weapon.gadget_power_consume_on_ammo_use )
    {
        self hero_give_ammo( slot, weapon );
        self hero_handle_ammo_save( slot, weapon );
    }
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0x63ff5311, Offset: 0x660
// Size: 0x44
function gadget_hero_weapon_on_off( slot, weapon )
{
    if ( weapon.gadget_power_consume_on_ammo_use )
    {
        self setweaponammoclip( weapon, 0 );
    }
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0x5b045b9a, Offset: 0x6b0
// Size: 0x44
function gadget_hero_weapon_ready( slot, weapon )
{
    if ( weapon.gadget_power_consume_on_ammo_use )
    {
        hero_give_ammo( slot, weapon );
    }
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0xdaa9a4ef, Offset: 0x700
// Size: 0x54
function hero_give_ammo( slot, weapon )
{
    self givemaxammo( weapon );
    self setweaponammoclip( weapon, weapon.clipsize );
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0x48a25928, Offset: 0x760
// Size: 0x74
function hero_handle_ammo_save( slot, weapon )
{
    self thread hero_wait_for_out_of_ammo( slot, weapon );
    self thread hero_wait_for_game_end( slot, weapon );
    self thread hero_wait_for_death( slot, weapon );
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0xece65a54, Offset: 0x7e0
// Size: 0x7c
function hero_wait_for_game_end( slot, weapon )
{
    self endon( #"disconnect" );
    self notify( #"hero_ongameend" );
    self endon( #"hero_ongameend" );
    level waittill( #"game_ended" );
    
    if ( isalive( self ) )
    {
        self hero_save_ammo( slot, weapon );
    }
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0xa86036a7, Offset: 0x868
// Size: 0x64
function hero_wait_for_death( slot, weapon )
{
    self endon( #"disconnect" );
    self notify( #"hero_ondeath" );
    self endon( #"hero_ondeath" );
    self waittill( #"death" );
    self hero_save_ammo( slot, weapon );
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0xd369c5fb, Offset: 0x8d8
// Size: 0x44
function hero_save_ammo( slot, weapon )
{
    self.pers[ "held_hero_weapon_ammo_count" ][ weapon ] = self getammocount( weapon );
}

// Namespace _gadget_hero_weapon
// Params 2
// Checksum 0xb33d04fa, Offset: 0x928
// Size: 0xc4
function hero_wait_for_out_of_ammo( slot, weapon )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self notify( #"hero_noammo" );
    self endon( #"hero_noammo" );
    
    while ( true )
    {
        wait 0.1;
        n_ammo = self getammocount( weapon );
        
        if ( n_ammo == 0 )
        {
            break;
        }
    }
    
    self gadgetpowerreset( slot );
    self gadgetcharging( slot, 1 );
}

// Namespace _gadget_hero_weapon
// Params 3
// Checksum 0x7e8d0856, Offset: 0x9f8
// Size: 0xb4
function set_gadget_hero_weapon_status( weapon, status, time )
{
    timestr = "";
    
    if ( isdefined( time ) )
    {
        timestr = "^3" + ", time: " + time;
    }
    
    if ( getdvarint( "scr_cpower_debug_prints" ) > 0 )
    {
        self iprintlnbold( "Hero Weapon " + weapon.name + ": " + status + timestr );
    }
}

