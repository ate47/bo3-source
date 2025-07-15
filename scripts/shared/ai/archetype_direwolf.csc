#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace archetypedirewolf;

// Namespace archetypedirewolf
// Params 0, eflags: 0x2
// Checksum 0xacae8f51, Offset: 0x140
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "direwolf", &__init__, undefined, undefined );
}

// Namespace archetypedirewolf
// Params 0, eflags: 0x2
// Checksum 0x3dec4ee8, Offset: 0x180
// Size: 0x1e
function autoexec precache()
{
    level._effect[ "fx_bio_direwolf_eyes" ] = "animals/fx_bio_direwolf_eyes";
}

// Namespace archetypedirewolf
// Params 0
// Checksum 0x11ddfcb1, Offset: 0x1a8
// Size: 0x64
function __init__()
{
    if ( ai::shouldregisterclientfieldforarchetype( "direwolf" ) )
    {
        clientfield::register( "actor", "direwolf_eye_glow_fx", 1, 1, "int", &direwolfeyeglowfxhandler, 0, 1 );
    }
}

// Namespace archetypedirewolf
// Params 7, eflags: 0x4
// Checksum 0xf0df0394, Offset: 0x218
// Size: 0x108
function private direwolfeyeglowfxhandler( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    entity = self;
    
    if ( isdefined( entity.archetype ) && entity.archetype != "direwolf" )
    {
        return;
    }
    
    if ( isdefined( entity.eyeglowfx ) )
    {
        stopfx( localclientnum, entity.eyeglowfx );
        entity.eyeglowfx = undefined;
    }
    
    if ( newvalue )
    {
        entity.eyeglowfx = playfxontag( localclientnum, level._effect[ "fx_bio_direwolf_eyes" ], entity, "tag_eye" );
    }
}

