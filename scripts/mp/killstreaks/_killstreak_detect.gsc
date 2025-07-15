#using scripts/codescripts/struct;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_proximity_grenade;

#namespace killstreak_detect;

// Namespace killstreak_detect
// Params 0, eflags: 0x2
// Checksum 0xd46200ea, Offset: 0x1e8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "killstreak_detect", &__init__, undefined, undefined );
}

// Namespace killstreak_detect
// Params 0
// Checksum 0x7913edc6, Offset: 0x228
// Size: 0x124
function __init__()
{
    clientfield::register( "vehicle", "enemyvehicle", 1, 2, "int" );
    clientfield::register( "scriptmover", "enemyvehicle", 1, 2, "int" );
    clientfield::register( "helicopter", "enemyvehicle", 1, 2, "int" );
    clientfield::register( "missile", "enemyvehicle", 1, 2, "int" );
    clientfield::register( "actor", "enemyvehicle", 1, 2, "int" );
    clientfield::register( "vehicle", "vehicletransition", 1, 1, "int" );
}

// Namespace killstreak_detect
// Params 2
// Checksum 0x4880e7cb, Offset: 0x358
// Size: 0x6c
function killstreaktargetset( killstreakentity, offset )
{
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    target_set( killstreakentity, offset );
    
    /#
        killstreakentity thread killstreak_hacking::killstreak_switch_team( killstreakentity.owner );
    #/
}

// Namespace killstreak_detect
// Params 1
// Checksum 0x998556bf, Offset: 0x3d0
// Size: 0x3c
function killstreaktargetclear( killstreakentity )
{
    target_remove( killstreakentity );
    
    /#
        killstreakentity thread killstreak_hacking::killstreak_switch_team_end();
    #/
}

