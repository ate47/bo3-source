#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapons;

#namespace explosive_bolt;

// Namespace explosive_bolt
// Params 0, eflags: 0x2
// Checksum 0xc651f55f, Offset: 0x140
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "explosive_bolt", &__init__, undefined, undefined );
}

// Namespace explosive_bolt
// Params 0
// Checksum 0xf806a4a7, Offset: 0x180
// Size: 0x24
function __init__()
{
    callback::on_spawned( &on_player_spawned );
}

// Namespace explosive_bolt
// Params 0
// Checksum 0xec314c6c, Offset: 0x1b0
// Size: 0x1c
function on_player_spawned()
{
    self thread begin_other_grenade_tracking();
}

// Namespace explosive_bolt
// Params 0
// Checksum 0x355c3886, Offset: 0x1d8
// Size: 0x138
function begin_other_grenade_tracking()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self notify( #"bolttrackingstart" );
    self endon( #"bolttrackingstart" );
    weapon_bolt = getweapon( "explosive_bolt" );
    
    for ( ;; )
    {
        self waittill( #"grenade_fire", grenade, weapon, cooktime );
        
        if ( grenade util::ishacked() )
        {
            continue;
        }
        
        if ( weapon == weapon_bolt )
        {
            grenade.ownerweaponatlaunch = self.currentweapon;
            grenade.owneradsatlaunch = self playerads() == 1 ? 1 : 0;
            grenade thread watch_bolt_detonation( self );
            grenade thread weapons::check_stuck_to_player( 1, 0, weapon );
        }
    }
}

// Namespace explosive_bolt
// Params 1
// Checksum 0xcb036af0, Offset: 0x318
// Size: 0xc
function watch_bolt_detonation( owner )
{
    
}

