#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace satchel_charge;

// Namespace satchel_charge
// Params 1
// Checksum 0xb6ac2d4a, Offset: 0x1b0
// Size: 0x6c
function init_shared( localclientnum )
{
    level._effect[ "satchel_charge_enemy_light" ] = "weapon/fx_c4_light_orng";
    level._effect[ "satchel_charge_friendly_light" ] = "weapon/fx_c4_light_blue";
    callback::add_weapon_type( "satchel_charge", &satchel_spawned );
}

// Namespace satchel_charge
// Params 1
// Checksum 0x25a4dde6, Offset: 0x228
// Size: 0x8c
function satchel_spawned( localclientnum )
{
    self endon( #"entityshutdown" );
    
    if ( self isgrenadedud() )
    {
        return;
    }
    
    self.equipmentfriendfx = level._effect[ "satchel_charge_friendly_light" ];
    self.equipmentenemyfx = level._effect[ "satchel_charge_enemy_light" ];
    self.equipmenttagfx = "tag_origin";
    self thread weaponobjects::equipmentteamobject( localclientnum );
}

