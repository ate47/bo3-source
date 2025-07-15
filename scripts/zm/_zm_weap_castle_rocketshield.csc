#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_weapons;

#namespace castle_rocketshield;

// Namespace castle_rocketshield
// Params 0, eflags: 0x2
// Checksum 0x60faeea, Offset: 0x188
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_weap_castle_rocketshield", &__init__, undefined, undefined );
}

// Namespace castle_rocketshield
// Params 0
// Checksum 0xf652febd, Offset: 0x1c8
// Size: 0x4c
function __init__()
{
    clientfield::register( "allplayers", "rs_ammo", 1, 1, "int", &set_rocketshield_ammo, 0, 0 );
}

// Namespace castle_rocketshield
// Params 7
// Checksum 0x992abe1, Offset: 0x220
// Size: 0xa4
function set_rocketshield_ammo( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self mapshaderconstant( localclientnum, 0, "scriptVector2", 0, 1, 0, 0 );
        return;
    }
    
    self mapshaderconstant( localclientnum, 0, "scriptVector2", 0, 0, 0, 0 );
}

