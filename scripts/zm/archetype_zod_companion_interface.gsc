#using scripts/shared/ai/systems/ai_interface;
#using scripts/zm/archetype_zod_companion;

#namespace zodcompanioninterface;

// Namespace zodcompanioninterface
// Params 0
// Checksum 0x24852f7b, Offset: 0xe8
// Size: 0x3c
function registerzodcompanioninterfaceattributes()
{
    ai::registermatchedinterface( "zod_companion", "sprint", 0, array( 1, 0 ) );
}

