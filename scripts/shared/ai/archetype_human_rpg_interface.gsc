#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_human_rpg;

#namespace humanrpginterface;

// Namespace humanrpginterface
// Params 0, eflags: 0x1 linked
// Checksum 0x262765a2, Offset: 0x118
// Size: 0x11c
function registerhumanrpginterfaceattributes() {
    ai::registermatchedinterface("human_rpg", "can_be_meleed", 1, array(1, 0));
    ai::registermatchedinterface("human_rpg", "can_melee", 1, array(1, 0));
    ai::registermatchedinterface("human_rpg", "coverIdleOnly", 0, array(1, 0));
    ai::registermatchedinterface("human_rpg", "sprint", 0, array(1, 0));
    ai::registermatchedinterface("human_rpg", "patrol", 0, array(1, 0));
}

