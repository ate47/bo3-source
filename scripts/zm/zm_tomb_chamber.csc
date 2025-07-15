#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_utility;

#namespace zm_challenges_tomb;

// Namespace zm_challenges_tomb
// Params 0, eflags: 0x2
// Checksum 0x316af679, Offset: 0x140
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_tomb_chamber", &__init__, undefined, undefined );
}

// Namespace zm_challenges_tomb
// Params 0
// Checksum 0xe27b5683, Offset: 0x180
// Size: 0x4c
function __init__()
{
    clientfield::register( "scriptmover", "divider_fx", 21000, 1, "counter", &function_fa586bee, 0, 0 );
}

// Namespace zm_challenges_tomb
// Params 7
// Checksum 0x68ecc20c, Offset: 0x1d8
// Size: 0xa6
function function_fa586bee( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        for ( i = 1; i <= 9 ; i++ )
        {
            playfxontag( localclientnum, level._effect[ "crypt_wall_drop" ], self, "tag_fx_dust_0" + i );
        }
    }
}

