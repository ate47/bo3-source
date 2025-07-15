#using scripts/shared/ai/behavior_zombie_dog;
#using scripts/shared/ai/systems/ai_interface;

#namespace zombiedoginterface;

// Namespace zombiedoginterface
// Params 0
// Checksum 0x26b16e52, Offset: 0x110
// Size: 0xbc
function registerzombiedoginterfaceattributes()
{
    ai::registermatchedinterface( "zombie_dog", "gravity", "normal", array( "low", "normal" ), &zombiedogbehavior::zombiedoggravity );
    ai::registermatchedinterface( "zombie_dog", "min_run_dist", 500 );
    ai::registermatchedinterface( "zombie_dog", "sprint", 0, array( 1, 0 ) );
}

