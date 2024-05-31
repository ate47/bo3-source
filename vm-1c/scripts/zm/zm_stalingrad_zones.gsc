#using scripts/zm/zm_stalingrad;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_audio;
#using scripts/zm/_load;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_521a050e;

// Namespace namespace_521a050e
// Params 0, eflags: 0x1 linked
// namespace_521a050e<file_0>::function_c35e6aab
// Checksum 0x386efe02, Offset: 0x740
// Size: 0x2424
function init() {
    level flag::init("always_on");
    level flag::set("always_on");
    level flag::init("department_store_upper_open");
    zm_zonemgr::zone_init("library_A_zone");
    zm_zonemgr::zone_init("library_B_zone");
    zm_zonemgr::zone_init("factory_A_zone");
    zm_zonemgr::zone_init("factory_B_zone");
    zm_zonemgr::zone_init("factory_C_zone");
    zm_zonemgr::zone_init("factory_arm_zone");
    zm_zonemgr::zone_init("powered_bridge_zone");
    zm_zonemgr::zone_init("powered_bridge_A_zone");
    zm_zonemgr::zone_init("powered_bridge_B_zone");
    zm_zonemgr::zone_init("library_street_A_zone");
    zm_zonemgr::zone_init("library_street_B_zone");
    zm_zonemgr::zone_init("library_street_C_zone");
    zm_zonemgr::zone_init("factory_street_A_zone");
    zm_zonemgr::zone_init("factory_street_B_zone");
    zm_zonemgr::zone_init("judicial_street_zone");
    zm_zonemgr::zone_init("judicial_B_zone");
    zm_zonemgr::zone_init("judicial_A_zone");
    zm_zonemgr::zone_init("alley_B_zone");
    zm_zonemgr::zone_init("alley_A_zone");
    zm_zonemgr::zone_init("bunker_zone");
    zm_zonemgr::zone_init("yellow_A_zone");
    zm_zonemgr::zone_init("yellow_B_zone");
    zm_zonemgr::zone_init("yellow_C_zone");
    zm_zonemgr::zone_init("yellow_D_zone");
    zm_zonemgr::zone_init("red_brick_A_zone");
    zm_zonemgr::zone_init("red_brick_B_zone");
    zm_zonemgr::zone_init("red_brick_C_zone");
    zm_zonemgr::zone_init("department_store_zone");
    zm_zonemgr::zone_init("department_store_floor2_A_zone");
    zm_zonemgr::zone_init("department_store_floor2_B_zone");
    zm_zonemgr::zone_init("department_store_floor3_A_zone");
    zm_zonemgr::zone_init("department_store_floor3_B_zone");
    zm_zonemgr::zone_init("department_store_floor3_C_zone");
    zm_zonemgr::zone_init("start_A_zone");
    zm_zonemgr::zone_init("start_B_zone");
    zm_zonemgr::zone_init("start_C_zone");
    zm_zonemgr::zone_init("pavlovs_A_zone");
    zm_zonemgr::zone_init("pavlovs_B_zone");
    zm_zonemgr::zone_init("pavlovs_C_zone");
    zm_zonemgr::add_adjacent_zone("start_A_zone", "start_B_zone", "always_on", 1);
    zm_zonemgr::add_adjacent_zone("start_A_zone", "start_C_zone", "always_on", 1);
    zm_zonemgr::add_adjacent_zone("start_A_zone", "department_store_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("start_B_zone", "start_A_zone", "always_on", 1);
    zm_zonemgr::add_adjacent_zone("start_B_zone", "start_C_zone", "always_on", 1);
    zm_zonemgr::add_adjacent_zone("start_B_zone", "department_store_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("start_B_zone", "department_store_floor2_A_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("start_C_zone", "start_A_zone", "always_on", 1);
    zm_zonemgr::add_adjacent_zone("start_C_zone", "start_B_zone", "always_on", 1);
    zm_zonemgr::add_adjacent_zone("start_C_zone", "department_store_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("start_C_zone", "department_store_floor2_A_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_zone", "department_store_floor2_A_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_zone", "department_store_floor2_B_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_zone", "start_A_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_zone", "start_B_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_zone", "start_C_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor2_A_zone", "department_store_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor2_A_zone", "department_store_floor2_B_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor2_A_zone", "start_A_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor2_A_zone", "department_store_floor3_A_zone", "department_store_2f_to_3f", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor2_A_zone", "department_store_floor3_B_zone", "department_store_2f_to_3f", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor2_A_zone", "alley_B_zone", "alley_to_department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor2_B_zone", "department_store_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor2_B_zone", "department_store_floor2_A_zone", "department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor2_B_zone", "department_store_floor3_A_zone", "department_store_2f_to_3f", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor2_B_zone", "department_store_floor3_B_zone", "department_store_2f_to_3f", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor2_B_zone", "alley_B_zone", "alley_to_department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_A_zone", "department_store_floor3_B_zone", "department_store_upper_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_A_zone", "department_store_floor3_C_zone", "department_store_upper_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_A_zone", "red_brick_C_zone", "department_floor3_to_red_brick_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_B_zone", "department_store_floor3_A_zone", "department_store_upper_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_B_zone", "department_store_floor3_C_zone", "department_store_upper_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_B_zone", "department_store_floor2_A_zone", "department_store_2f_to_3f", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_B_zone", "red_brick_C_zone", "department_floor3_to_red_brick_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_C_zone", "department_store_floor3_A_zone", "department_store_upper_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_C_zone", "department_store_floor3_B_zone", "department_store_upper_open", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_C_zone", "department_store_floor2_A_zone", "department_store_2f_to_3f", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_C_zone", "department_store_floor2_B_zone", "department_store_2f_to_3f", 1);
    zm_zonemgr::add_adjacent_zone("department_store_floor3_C_zone", "yellow_C_zone", "dept_to_yellow", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_A_zone", "red_brick_B_zone", "activate_red_brick", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_A_zone", "red_brick_C_zone", "activate_red_brick", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_A_zone", "powered_bridge_A_zone", "activate_red_brick", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_A_zone", "bunker_zone", "red_brick_to_bunker_open", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_A_zone", "factory_street_B_zone", "red_brick_to_factory_street_open", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_A_zone", "judicial_street_zone", "red_brick_to_judicial_street_open", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_B_zone", "red_brick_A_zone", "activate_red_brick", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_B_zone", "red_brick_C_zone", "activate_red_brick", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_B_zone", "powered_bridge_A_zone", "activate_red_brick", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_B_zone", "factory_arm_zone", "power_on", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_B_zone", "factory_B_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_C_zone", "red_brick_B_zone", "activate_red_brick", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_C_zone", "powered_bridge_A_zone", "activate_red_brick", 1);
    zm_zonemgr::add_adjacent_zone("red_brick_C_zone", "department_store_floor3_A_zone", "department_floor3_to_red_brick_open", 1);
    zm_zonemgr::add_adjacent_zone("yellow_A_zone", "yellow_B_zone", "activate_yellow", 1);
    zm_zonemgr::add_adjacent_zone("yellow_A_zone", "library_street_A_zone", "library_street_to_yellow_open", 1);
    zm_zonemgr::add_adjacent_zone("yellow_A_zone", "library_street_B_zone", "library_street_to_yellow_open", 1);
    zm_zonemgr::add_adjacent_zone("yellow_B_zone", "yellow_A_zone", "activate_yellow", 1);
    zm_zonemgr::add_adjacent_zone("yellow_B_zone", "yellow_C_zone", "activate_yellow", 1);
    zm_zonemgr::add_adjacent_zone("yellow_B_zone", "library_street_A_zone", "library_street_to_yellow_open", 1);
    zm_zonemgr::add_adjacent_zone("yellow_B_zone", "judicial_street_B_zone", "yellow_to_judicial_street_open", 1);
    zm_zonemgr::add_adjacent_zone("yellow_B_zone", "bunker_zone", "yellow_to_bunker_open", 1);
    zm_zonemgr::add_adjacent_zone("yellow_C_zone", "yellow_B_zone", "activate_yellow", 1);
    zm_zonemgr::add_adjacent_zone("yellow_C_zone", "yellow_D_zone", "activate_yellow", 1);
    zm_zonemgr::add_adjacent_zone("yellow_C_zone", "department_store_floor3_C_zone", "dept_to_yellow", 1);
    zm_zonemgr::add_adjacent_zone("yellow_C_zone", "library_street_C_zone", "power_on", 1);
    zm_zonemgr::add_adjacent_zone("yellow_D_zone", "powered_bridge_B_zone", "activate_yellow", 1);
    zm_zonemgr::add_adjacent_zone("yellow_D_zone", "yellow_C_zone", "power_on", 1);
    zm_zonemgr::add_adjacent_zone("yellow_D_zone", "library_street_C_zone", "power_on", 1);
    zm_zonemgr::add_adjacent_zone("yellow_D_zone", "library_B_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("judicial_A_zone", "judicial_B_zone", "activate_judicial", 1);
    zm_zonemgr::add_adjacent_zone("judicial_A_zone", "judicial_street_zone", "activate_judicial", 1);
    zm_zonemgr::add_adjacent_zone("judicial_A_zone", "judicial_street_B_zone", "activate_judicial", 1);
    zm_zonemgr::add_adjacent_zone("judicial_B_zone", "judicial_A_zone", "activate_judicial", 1);
    zm_zonemgr::add_adjacent_zone("judicial_B_zone", "judicial_street_zone", "activate_judicial", 1);
    zm_zonemgr::add_adjacent_zone("judicial_street_zone", "judicial_A_zone", "activate_judicial", 1);
    zm_zonemgr::add_adjacent_zone("judicial_street_zone", "judicial_B_zone", "activate_judicial", 1);
    zm_zonemgr::add_adjacent_zone("judicial_street_zone", "judicial_street_B_zone", "activate_judicial", 1);
    zm_zonemgr::add_adjacent_zone("judicial_street_zone", "red_brick_A_zone", "red_brick_to_judicial_street_open", 1);
    zm_zonemgr::add_adjacent_zone("judicial_street_zone", "red_brick_B_zone", "red_brick_to_judicial_street_open", 1);
    zm_zonemgr::add_adjacent_zone("judicial_street_zone", "yellow_B_zone", "yellow_to_judicial_street_open", 1);
    zm_zonemgr::add_adjacent_zone("judicial_street_B_zone", "judicial_A_zone", "activate_judicial", 1);
    zm_zonemgr::add_adjacent_zone("judicial_street_B_zone", "judicial_street_zone", "activate_judicial", 1);
    zm_zonemgr::add_adjacent_zone("judicial_street_B_zone", "red_brick_A_zone", "red_brick_to_judicial_street_open", 1);
    zm_zonemgr::add_adjacent_zone("judicial_street_B_zone", "yellow_B_zone", "yellow_to_judicial_street_open", 1);
    zm_zonemgr::add_adjacent_zone("alley_A_zone", "alley_B_zone", "activate_bunker", 1);
    zm_zonemgr::add_adjacent_zone("alley_A_zone", "bunker_zone", "activate_bunker", 1);
    zm_zonemgr::add_adjacent_zone("alley_A_zone", "department_store_floor2_B_zone", "alley_to_department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("alley_B_zone", "alley_A_zone", "activate_bunker", 1);
    zm_zonemgr::add_adjacent_zone("alley_B_zone", "bunker_zone", "activate_bunker", 1);
    zm_zonemgr::add_adjacent_zone("alley_B_zone", "department_store_floor2_A_zone", "alley_to_department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("alley_B_zone", "department_store_floor2_B_zone", "alley_to_department_store_open", 1);
    zm_zonemgr::add_adjacent_zone("bunker_zone", "alley_A_zone", "activate_bunker", 1);
    zm_zonemgr::add_adjacent_zone("bunker_zone", "red_brick_A_zone", "red_brick_to_bunker_open", 1);
    zm_zonemgr::add_adjacent_zone("bunker_zone", "yellow_B_zone", "yellow_to_bunker_open", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_A_zone", "red_brick_A_zone", "activate_red_brick", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_A_zone", "red_brick_B_zone", "activate_red_brick", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_A_zone", "red_brick_C_zone", "activate_red_brick", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_A_zone", "powered_bridge_B_zone", "activate_bridge", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_A_zone", "powered_bridge_zone", "activate_bridge", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_B_zone", "powered_bridge_A_zone", "activate_bridge", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_B_zone", "yellow_D_zone", "activate_yellow", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_B_zone", "yellow_C_zone", "activate_yellow", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_B_zone", "library_street_C_zone", "power_on", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_zone", "powered_bridge_A_zone", "activate_bridge", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_zone", "powered_bridge_B_zone", "activate_bridge", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_zone", "yellow_D_zone", "activate_bridge", 1);
    zm_zonemgr::add_adjacent_zone("powered_bridge_zone", "red_brick_C_zone", "activate_bridge", 1);
    zm_zonemgr::add_adjacent_zone("library_street_A_zone", "library_street_B_zone", "activate_library_street", 1);
    zm_zonemgr::add_adjacent_zone("library_street_A_zone", "yellow_A_zone", "activate_library_street", 1);
    zm_zonemgr::add_adjacent_zone("library_street_A_zone", "library_street_C_zone", "library_street_dropdown_open", 1);
    zm_zonemgr::add_adjacent_zone("library_street_A_zone", "library_A_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("library_street_B_zone", "library_street_A_zone", "activate_library_street", 1);
    zm_zonemgr::add_adjacent_zone("library_street_B_zone", "yellow_A_zone", "library_street_to_yellow_open", 1);
    zm_zonemgr::add_adjacent_zone("library_street_B_zone", "library_street_C_zone", "library_street_dropdown_open", 1);
    zm_zonemgr::add_adjacent_zone("library_street_B_zone", "library_A_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("library_street_B_zone", "library_B_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("library_street_C_zone", "yellow_C_zone", "power_on", 1);
    zm_zonemgr::add_adjacent_zone("library_street_C_zone", "yellow_D_zone", "power_on", 1);
    zm_zonemgr::add_adjacent_zone("library_street_C_zone", "powered_bridge_B_zone", "power_on", 1);
    zm_zonemgr::add_adjacent_zone("library_street_C_zone", "library_street_A_zone", "library_street_dropdown_open", 1);
    zm_zonemgr::add_adjacent_zone("library_street_C_zone", "library_street_B_zone", "library_street_dropdown_open", 1);
    zm_zonemgr::add_adjacent_zone("library_street_C_zone", "library_B_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("library_A_zone", "library_B_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("library_A_zone", "library_street_A_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("library_A_zone", "library_street_B_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("library_B_zone", "library_A_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("library_B_zone", "library_street_B_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("library_B_zone", "library_street_C_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("library_B_zone", "yellow_D_zone", "library_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_A_zone", "factory_street_A_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_A_zone", "factory_street_B_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_A_zone", "factory_B_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_A_zone", "factory_C_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_A_zone", "factory_arm_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_B_zone", "factory_A_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_B_zone", "factory_C_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_B_zone", "factory_arm_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_B_zone", "factory_street_A_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_B_zone", "red_brick_B_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_C_zone", "factory_A_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_C_zone", "factory_B_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_C_zone", "factory_arm_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_C_zone", "factory_street_A_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_arm_zone", "factory_A_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_arm_zone", "factory_B_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_arm_zone", "factory_C_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_arm_zone", "red_brick_B_zone", "power_on", 1);
    zm_zonemgr::add_adjacent_zone("factory_arm_zone", "factory_street_B_zone", "factory_bridge_dropdown_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_street_A_zone", "factory_street_B_zone", "red_brick_to_factory_street_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_street_A_zone", "red_brick_A_zone", "red_brick_to_factory_street_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_street_A_zone", "factory_arm_zone", "factory_bridge_dropdown_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_street_A_zone", "factory_A_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_street_B_zone", "factory_street_A_zone", "red_brick_to_factory_street_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_street_B_zone", "red_brick_A_zone", "red_brick_to_factory_street_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_street_B_zone", "factory_arm_zone", "factory_bridge_dropdown_open", 1);
    zm_zonemgr::add_adjacent_zone("factory_street_B_zone", "factory_A_zone", "factory_open", 1);
    zm_zonemgr::add_adjacent_zone("pavlovs_A_zone", "pavlovs_B_zone", "dragonride_crafted", 1);
    zm_zonemgr::add_adjacent_zone("pavlovs_C_zone", "pavlovs_B_zone", "dragonride_crafted", 1);
    zm_zonemgr::zone_init("boss_arena_zone");
    zm_zonemgr::add_zone_flags("department_store_2f_to_3f", "department_store_upper_open");
    zm_zonemgr::add_zone_flags("dept_to_yellow", "department_store_upper_open");
    zm_zonemgr::add_zone_flags("department_floor3_to_red_brick_open", "department_store_upper_open");
    zm_zonemgr::add_zone_flags("yellow_to_judicial_street_open", "activate_yellow");
    zm_zonemgr::add_zone_flags("red_brick_to_judicial_street_open", "activate_yellow");
    zm_zonemgr::add_zone_flags("dept_to_yellow", "activate_yellow");
    zm_zonemgr::add_zone_flags("yellow_to_bunker_open", "activate_yellow");
    zm_zonemgr::add_zone_flags("activate_bridge", "activate_yellow");
    zm_zonemgr::add_zone_flags("department_floor3_to_red_brick_open", "activate_red_brick");
    zm_zonemgr::add_zone_flags("red_brick_to_judicial_street_open", "activate_red_brick");
    zm_zonemgr::add_zone_flags("yellow_to_judicial_street_open", "activate_red_brick");
    zm_zonemgr::add_zone_flags("red_brick_to_bunker_open", "activate_red_brick");
    zm_zonemgr::add_zone_flags("activate_bridge", "activate_red_brick");
    zm_zonemgr::add_zone_flags("red_brick_to_judicial_street_open", "activate_judicial");
    zm_zonemgr::add_zone_flags("yellow_to_judicial_street_open", "activate_judicial");
    zm_zonemgr::add_zone_flags("library_street_to_yellow_open", "activate_library_street");
    zm_zonemgr::add_zone_flags("alley_to_department_store_open", "activate_bunker");
    zm_zonemgr::add_zone_flags("red_brick_to_bunker_open", "activate_bunker");
    zm_zonemgr::add_zone_flags("yellow_to_bunker_open", "activate_bunker");
}

