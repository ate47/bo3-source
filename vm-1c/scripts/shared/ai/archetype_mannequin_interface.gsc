#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/zombie;

#namespace mannequininterface;

// Namespace mannequininterface
// Params 0, eflags: 0x0
// Checksum 0xe164e6d, Offset: 0x100
// Size: 0xac
function registermannequininterfaceattributes() {
    ai::registermatchedinterface("mannequin", "can_juke", 0, array(1, 0));
    ai::registermatchedinterface("mannequin", "suicidal_behavior", 0, array(1, 0));
    ai::registermatchedinterface("mannequin", "spark_behavior", 0, array(1, 0));
}

