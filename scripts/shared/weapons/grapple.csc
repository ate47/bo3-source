#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/filter_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace grapple;

// Namespace grapple
// Params 0, eflags: 0x2
// Checksum 0xd9b8185f, Offset: 0x190
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "grapple", &__init__, undefined, undefined );
}

// Namespace grapple
// Params 0
// Checksum 0x99ec1590, Offset: 0x1d0
// Size: 0x4
function __init__()
{
    
}

