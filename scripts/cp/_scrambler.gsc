#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_scrambler;

#namespace scrambler;

// Namespace scrambler
// Params 0, eflags: 0x2
// Checksum 0x429c06ec, Offset: 0x138
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "scrambler", &__init__, undefined, undefined );
}

// Namespace scrambler
// Params 0
// Checksum 0x926914f9, Offset: 0x178
// Size: 0x14
function __init__()
{
    init_shared();
}

