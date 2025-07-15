#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/zombie;

#namespace zombieinterface;

// Namespace zombieinterface
// Params 0
// Checksum 0x2ea92298, Offset: 0x110
// Size: 0xe4
function registerzombieinterfaceattributes()
{
    ai::registermatchedinterface( "zombie", "can_juke", 0, array( 1, 0 ) );
    ai::registermatchedinterface( "zombie", "suicidal_behavior", 0, array( 1, 0 ) );
    ai::registermatchedinterface( "zombie", "spark_behavior", 0, array( 1, 0 ) );
    ai::registermatchedinterface( "zombie", "use_attackable", 0, array( 1, 0 ) );
}

