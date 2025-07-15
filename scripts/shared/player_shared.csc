#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace player;

// Namespace player
// Params 0, eflags: 0x2
// Checksum 0xdc7a9049, Offset: 0xf0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "player", &__init__, undefined, undefined );
}

// Namespace player
// Params 0
// Checksum 0xac5b2152, Offset: 0x130
// Size: 0x4c
function __init__()
{
    clientfield::register( "world", "gameplay_started", 4000, 1, "int", &gameplay_started_callback, 0, 1 );
}

// Namespace player
// Params 7
// Checksum 0x5e2ea3c, Offset: 0x188
// Size: 0x5c
function gameplay_started_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    setdvar( "cg_isGameplayActive", newval );
}

