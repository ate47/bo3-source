#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/behavior_zombie_dog;
#using scripts/shared/spawner_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#namespace namespace_46de4034;

// Namespace namespace_46de4034
// Params 0, eflags: 0x2
// Checksum 0xec7ca82e, Offset: 0x220
// Size: 0x34
function function_2dc19561() {
    system::register("direwolf", &__init__, undefined, undefined);
}

// Namespace namespace_46de4034
// Params 0, eflags: 0x1 linked
// Checksum 0xf11774c0, Offset: 0x260
// Size: 0x1cc
function __init__() {
    spawner::add_archetype_spawn_function("direwolf", &namespace_1db6d2c9::archetypezombiedogblackboardinit);
    spawner::add_archetype_spawn_function("direwolf", &function_722f5b6f);
    ai::registermatchedinterface("direwolf", "sprint", 0, array(1, 0));
    ai::registermatchedinterface("direwolf", "howl_chance", 0.3);
    ai::registermatchedinterface("direwolf", "can_initiateaivsaimelee", 1, array(1, 0));
    ai::registermatchedinterface("direwolf", "spacing_near_dist", 120);
    ai::registermatchedinterface("direwolf", "spacing_far_dist", 480);
    ai::registermatchedinterface("direwolf", "spacing_horz_dist", -112);
    ai::registermatchedinterface("direwolf", "spacing_value", 0);
    if (ai::shouldregisterclientfieldforarchetype("direwolf")) {
        clientfield::register("actor", "direwolf_eye_glow_fx", 1, 1, "int");
    }
}

// Namespace namespace_46de4034
// Params 0, eflags: 0x5 linked
// Checksum 0x61639958, Offset: 0x438
// Size: 0xe4
function function_722f5b6f() {
    self setteam("team3");
    self allowpitchangle(1);
    self setpitchorient();
    self setavoidancemask("avoid all");
    self function_1762804b(1);
    self ai::set_behavior_attribute("spacing_value", randomfloatrange(-1, 1));
    self clientfield::set("direwolf_eye_glow_fx", 1);
}

