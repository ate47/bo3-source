#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_human;

#namespace humaninterface;

// Namespace humaninterface
// Params 0, eflags: 0x1 linked
// namespace_5ad83c65<file_0>::function_1f1da765
// Checksum 0x5707d523, Offset: 0x1b8
// Size: 0x3c4
function registerhumaninterfaceattributes() {
    ai::registermatchedinterface("human", "can_be_meleed", 1, array(1, 0));
    ai::registermatchedinterface("human", "can_melee", 1, array(1, 0));
    ai::registermatchedinterface("human", "can_initiateaivsaimelee", 1, array(1, 0));
    ai::registermatchedinterface("human", "coverIdleOnly", 0, array(1, 0));
    ai::registermatchedinterface("human", "cqb", 0, array(1, 0), &humansoldierserverutils::cqbattributecallback);
    ai::registermatchedinterface("human", "forceTacticalWalk", 0, array(1, 0), &humansoldierserverutils::forcetacticalwalkcallback);
    ai::registermatchedinterface("human", "move_mode", "normal", array("normal", "rambo"), &humansoldierserverutils::movemodeattributecallback);
    ai::registermatchedinterface("human", "useAnimationOverride", 0, array(1, 0), &humansoldierserverutils::useanimationoverridecallback);
    ai::registermatchedinterface("human", "sprint", 0, array(1, 0));
    ai::registermatchedinterface("human", "patrol", 0, array(1, 0));
    ai::registermatchedinterface("human", "disablearrivals", 0, array(1, 0));
    ai::registermatchedinterface("human", "disablesprint", 0, array(1, 0));
    ai::registermatchedinterface("human", "stealth", 0, array(1, 0));
    ai::registermatchedinterface("human", "vignette_mode", "off", array("off", "slow", "fast"), &humansoldierserverutils::vignettemodecallback);
    ai::registermatchedinterface("human", "useGrenades", 1, array(1, 0));
}

