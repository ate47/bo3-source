#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_craftables;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;

#namespace namespace_a159a601;

// Namespace namespace_a159a601
// Params 0, eflags: 0x1 linked
// Checksum 0x9491bd93, Offset: 0x280
// Size: 0x54
function init() {
    namespace_6e97c459::function_5a90ed82("little_girl_lost", "step_1", &init_stage, &function_7747c56, &function_cc3f3f6a);
}

// Namespace namespace_a159a601
// Params 0, eflags: 0x1 linked
// Checksum 0x7572f9a6, Offset: 0x2e0
// Size: 0x14
function init_stage() {
    level.var_ca733eed = "step_1";
}

// Namespace namespace_a159a601
// Params 0, eflags: 0x1 linked
// Checksum 0x392795d, Offset: 0x300
// Size: 0x7c
function function_7747c56() {
    /#
        iprintln(level.var_ca733eed + "<unknown string>");
    #/
    level flag::wait_till("ee_all_staffs_upgraded");
    util::wait_network_frame();
    namespace_6e97c459::function_2f3ced1f("little_girl_lost", level.var_ca733eed);
}

// Namespace namespace_a159a601
// Params 1, eflags: 0x1 linked
// Checksum 0x342996aa, Offset: 0x388
// Size: 0x1a
function function_cc3f3f6a(success) {
    level notify(#"hash_e6967d42");
}

