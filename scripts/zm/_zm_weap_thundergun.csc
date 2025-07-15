#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_weapons;

#namespace zm_weap_thundergun;

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x2
// Checksum 0xce2f642e, Offset: 0x168
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_weap_thundergun", &__init__, &__main__, undefined );
}

// Namespace zm_weap_thundergun
// Params 0
// Checksum 0xd307c89f, Offset: 0x1b0
// Size: 0x44
function __init__()
{
    level.weaponzmthundergun = getweapon( "thundergun" );
    level.weaponzmthundergunupgraded = getweapon( "thundergun_upgraded" );
}

// Namespace zm_weap_thundergun
// Params 0
// Checksum 0xe953a7f, Offset: 0x200
// Size: 0x24
function __main__()
{
    callback::on_localplayer_spawned( &localplayer_spawned );
}

// Namespace zm_weap_thundergun
// Params 1
// Checksum 0xf227c11c, Offset: 0x230
// Size: 0x24
function localplayer_spawned( localclientnum )
{
    self thread watch_for_thunderguns( localclientnum );
}

// Namespace zm_weap_thundergun
// Params 1
// Checksum 0xb74661f3, Offset: 0x260
// Size: 0xa0
function watch_for_thunderguns( localclientnum )
{
    self endon( #"disconnect" );
    self notify( #"watch_for_thunderguns" );
    self endon( #"watch_for_thunderguns" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"weapon_change", w_new_weapon, w_old_weapon );
        
        if ( w_new_weapon == level.weaponzmthundergun || w_new_weapon == level.weaponzmthundergunupgraded )
        {
            self thread thundergun_fx_power_cell( localclientnum, w_new_weapon );
        }
    }
}

// Namespace zm_weap_thundergun
// Params 2
// Checksum 0x8200f40, Offset: 0x308
// Size: 0x158
function thundergun_fx_power_cell( localclientnum, w_weapon )
{
    self endon( #"disconnect" );
    self endon( #"weapon_change" );
    self endon( #"entityshutdown" );
    n_old_ammo = -1;
    n_shader_val = 0;
    
    while ( true )
    {
        wait 0.1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        n_ammo = getweaponammoclip( localclientnum, w_weapon );
        
        if ( n_old_ammo > 0 && n_old_ammo != n_ammo )
        {
            thundergun_fx_fire( localclientnum );
        }
        
        n_old_ammo = n_ammo;
        
        if ( n_ammo == 0 )
        {
            self mapshaderconstant( localclientnum, 0, "scriptVector2", 0, 0, 0, 0 );
            continue;
        }
        
        n_shader_val = 4 - n_ammo;
        self mapshaderconstant( localclientnum, 0, "scriptVector2", 0, 1, n_shader_val, 0 );
    }
}

// Namespace zm_weap_thundergun
// Params 1
// Checksum 0x84760c27, Offset: 0x468
// Size: 0x2c
function thundergun_fx_fire( localclientnum )
{
    playsound( localclientnum, "wpn_thunder_breath", ( 0, 0, 0 ) );
}

