#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_utility;

#namespace zm_challenges_tomb;

// Namespace zm_challenges_tomb
// Params 0, eflags: 0x2
// Checksum 0x3f5e0d4a, Offset: 0x178
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_challenges_tomb", &__init__, undefined, undefined );
}

// Namespace zm_challenges_tomb
// Params 0
// Checksum 0x5a1a0d0e, Offset: 0x1b8
// Size: 0x124
function __init__()
{
    clientfield::register( "toplayer", "challenges.challenge_complete_1", 21000, 2, "int", &zm_utility::setinventoryuimodels, 0, 1 );
    clientfield::register( "toplayer", "challenges.challenge_complete_2", 21000, 2, "int", &zm_utility::setinventoryuimodels, 0, 1 );
    clientfield::register( "toplayer", "challenges.challenge_complete_3", 21000, 2, "int", &zm_utility::setinventoryuimodels, 0, 1 );
    clientfield::register( "toplayer", "challenges.challenge_complete_4", 21000, 2, "int", &function_2d46c9fd, 0, 1 );
}

// Namespace zm_challenges_tomb
// Params 7
// Checksum 0x6d8295f5, Offset: 0x2e8
// Size: 0x94
function function_2d46c9fd( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval == 2 && isspectating( localclientnum ) )
    {
        return;
    }
    
    zm_utility::setsharedinventoryuimodels( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump );
}

