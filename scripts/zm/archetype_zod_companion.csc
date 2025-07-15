#using scripts/shared/ai/systems/fx_character;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace zodcompanionclientutils;

// Namespace zodcompanionclientutils
// Params 0, eflags: 0x2
// Checksum 0x10cc164, Offset: 0x290
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_zod_companion", &__init__, undefined, undefined );
}

// Namespace zodcompanionclientutils
// Params 0
// Checksum 0xf4b4988d, Offset: 0x2d0
// Size: 0xec
function __init__()
{
    clientfield::register( "allplayers", "being_robot_revived", 1, 1, "int", &play_revival_fx, 0, 0 );
    ai::add_archetype_spawn_function( "zod_companion", &zodcompanionspawnsetup );
    level._effect[ "fx_dest_robot_head_sparks" ] = "destruct/fx_dest_robot_head_sparks";
    level._effect[ "fx_dest_robot_body_sparks" ] = "destruct/fx_dest_robot_body_sparks";
    level._effect[ "companion_revive_effect" ] = "zombie/fx_robot_helper_revive_player_zod_zmb";
    ai::add_archetype_spawn_function( "robot", &zodcompanionspawnsetup );
}

// Namespace zodcompanionclientutils
// Params 1, eflags: 0x4
// Checksum 0x10fefd58, Offset: 0x3c8
// Size: 0x134
function private zodcompanionspawnsetup( localclientnum )
{
    entity = self;
    gibclientutils::addgibcallback( localclientnum, entity, 8, &zodcompanionheadgibfx );
    gibclientutils::addgibcallback( localclientnum, entity, 8, &_gibcallback );
    gibclientutils::addgibcallback( localclientnum, entity, 16, &_gibcallback );
    gibclientutils::addgibcallback( localclientnum, entity, 32, &_gibcallback );
    gibclientutils::addgibcallback( localclientnum, entity, 128, &_gibcallback );
    gibclientutils::addgibcallback( localclientnum, entity, 256, &_gibcallback );
    fxclientutils::playfxbundle( localclientnum, entity, entity.fxdef );
}

// Namespace zodcompanionclientutils
// Params 3
// Checksum 0xac04fc83, Offset: 0x508
// Size: 0x104
function zodcompanionheadgibfx( localclientnum, entity, gibflag )
{
    if ( !isdefined( entity ) || !entity isai() || !isalive( entity ) )
    {
        return;
    }
    
    if ( isdefined( entity.mindcontrolheadfx ) )
    {
        stopfx( localclientnum, entity.mindcontrolheadfx );
        entity.mindcontrolheadfx = undefined;
    }
    
    entity.headgibfx = playfxontag( localclientnum, level._effect[ "fx_dest_robot_head_sparks" ], entity, "j_neck" );
    playsound( 0, "prj_bullet_impact_robot_headshot", entity.origin );
}

// Namespace zodcompanionclientutils
// Params 2
// Checksum 0x834f8091, Offset: 0x618
// Size: 0x90
function zodcompaniondamagedfx( localclientnum, entity )
{
    if ( !isdefined( entity ) || !entity isai() || !isalive( entity ) )
    {
        return;
    }
    
    entity.damagedfx = playfxontag( localclientnum, level._effect[ "fx_dest_robot_body_sparks" ], entity, "j_spine4" );
}

// Namespace zodcompanionclientutils
// Params 2
// Checksum 0x8a42d885, Offset: 0x6b0
// Size: 0x3a
function zodcompanionclearfx( localclientnum, entity )
{
    if ( !isdefined( entity ) || !entity isai() )
    {
        return;
    }
}

// Namespace zodcompanionclientutils
// Params 3, eflags: 0x4
// Checksum 0x579aa4e2, Offset: 0x6f8
// Size: 0x92
function private _gibcallback( localclientnum, entity, gibflag )
{
    if ( !isdefined( entity ) || !entity isai() )
    {
        return;
    }
    
    switch ( gibflag )
    {
        case 8:
            break;
        case 16:
            break;
        case 32:
            break;
        case 128:
            break;
        case 256:
            break;
    }
}

// Namespace zodcompanionclientutils
// Params 7
// Checksum 0x86b0ed7b, Offset: 0x798
// Size: 0xdc
function play_revival_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.robot_revival_fx ) && oldval == 1 && newval == 0 )
    {
        stopfx( localclientnum, self.robot_revival_fx );
    }
    
    if ( newval === 1 )
    {
        self playsound( 0, "evt_civil_protector_revive_plr" );
        self.robot_revival_fx = playfxontag( localclientnum, level._effect[ "companion_revive_effect" ], self, "j_spineupper" );
    }
}

