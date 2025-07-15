#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace weaponobjects;

// Namespace weaponobjects
// Params 0, eflags: 0x2
// Checksum 0x4fed97ab, Offset: 0x180
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "weaponobjects", &__init__, undefined, undefined );
}

// Namespace weaponobjects
// Params 0
// Checksum 0xbaa078d5, Offset: 0x1c0
// Size: 0x14
function __init__()
{
    init_shared();
}

