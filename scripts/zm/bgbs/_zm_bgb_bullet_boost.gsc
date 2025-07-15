#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_bgb_bullet_boost;

// Namespace zm_bgb_bullet_boost
// Params 0, eflags: 0x2
// Checksum 0xb4d0182e, Offset: 0x220
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_bullet_boost", &__init__, undefined, "bgb" );
}

// Namespace zm_bgb_bullet_boost
// Params 0
// Checksum 0x1bb414a6, Offset: 0x260
// Size: 0x7c
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_bullet_boost", "activated", 2, undefined, undefined, &validation, &activation );
    bgb::function_f132da9c( "zm_bgb_bullet_boost" );
}

// Namespace zm_bgb_bullet_boost
// Params 0
// Checksum 0x2c0f609c, Offset: 0x2e8
// Size: 0x130, Type: bool
function validation()
{
    current_weapon = self getcurrentweapon();
    
    if ( !self zm_weapons::can_upgrade_weapon( current_weapon ) && ( isdefined( self.intermission ) && ( !self zm_magicbox::can_buy_weapon() || self laststand::player_is_in_laststand() || self.intermission ) || self isthrowinggrenade() || !zm_weapons::weapon_supports_aat( current_weapon ) ) )
    {
        return false;
    }
    
    if ( self isswitchingweapons() )
    {
        return false;
    }
    
    if ( !zm_weapons::is_weapon_or_base_included( current_weapon ) )
    {
        return false;
    }
    
    b_weapon_supports_aat = zm_weapons::weapon_supports_aat( current_weapon );
    
    if ( !b_weapon_supports_aat )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_bgb_bullet_boost
// Params 0
// Checksum 0x3fd0e64c, Offset: 0x420
// Size: 0x16c
function activation()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self playsoundtoplayer( "zmb_bgb_bullet_boost", self );
    self util::waittill_any_timeout( 1, "weapon_change_complete", "death", "disconnect" );
    current_weapon = self getcurrentweapon();
    current_weapon = self zm_weapons::switch_from_alt_weapon( current_weapon );
    var_3a5329e8 = 0;
    
    while ( current_weapon === level.weaponnone || !zm_weapons::weapon_supports_aat( current_weapon ) )
    {
        wait 0.05;
        current_weapon = self getcurrentweapon();
        var_3a5329e8++;
        
        if ( ( current_weapon === level.weaponnone || !zm_weapons::weapon_supports_aat( current_weapon ) ) && var_3a5329e8 > 300 )
        {
            return;
        }
    }
    
    self aat::acquire( current_weapon );
}

