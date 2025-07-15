#using scripts/shared/ai/archetype_thrasher;
#using scripts/shared/ai/systems/ai_interface;

#namespace thrasherinterface;

// Namespace thrasherinterface
// Params 0
// Checksum 0xfae534bd, Offset: 0x118
// Size: 0xcc
function registerthrasherinterfaceattributes()
{
    ai::registermatchedinterface( "thrasher", "stunned", 0, array( 1, 0 ) );
    ai::registermatchedinterface( "thrasher", "move_mode", "normal", array( "normal", "friendly" ), &thrasherserverutils::thrashermovemodeattributecallback );
    ai::registermatchedinterface( "thrasher", "use_attackable", 0, array( 1, 0 ) );
}

