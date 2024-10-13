#using scripts/zm/craftables/_zm_craft_shield;
#using scripts/zm/_zm_weap_riotshield;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_audio;
#using scripts/zm/_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_b2c57c5e;

// Namespace namespace_b2c57c5e
// Params 0, eflags: 0x2
// Checksum 0x54be60ec, Offset: 0x498
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_weap_island_shield", &__init__, &__main__, undefined);
}

// Namespace namespace_b2c57c5e
// Params 0, eflags: 0x1 linked
// Checksum 0x7d158a1f, Offset: 0x4e0
// Size: 0x7c
function __init__() {
    zm_craft_shield::init("craft_shield_zm", "island_riotshield", "wpn_t7_zmb_dlc2_shield_world");
    level.weaponriotshield = getweapon("island_riotshield");
    zm_equipment::register("island_riotshield", %ZOMBIE_EQUIP_RIOTSHIELD_PICKUP_HINT_STRING, %ZOMBIE_EQUIP_RIOTSHIELD_HOWTO, undefined, "riotshield");
}

// Namespace namespace_b2c57c5e
// Params 0, eflags: 0x1 linked
// Checksum 0x69ed35a7, Offset: 0x568
// Size: 0x10c
function __main__() {
    zm_equipment::register_for_level("island_riotshield");
    zm_equipment::include("island_riotshield");
    zombie_utility::set_zombie_var("riotshield_fling_damage_shield", 100);
    zombie_utility::set_zombie_var("riotshield_knockdown_damage_shield", 15);
    zombie_utility::set_zombie_var("riotshield_juke_damage_shield", 0);
    zombie_utility::set_zombie_var("riotshield_fling_force_juke", -81);
    zombie_utility::set_zombie_var("riotshield_fling_range", 120);
    zombie_utility::set_zombie_var("riotshield_gib_range", 120);
    zombie_utility::set_zombie_var("riotshield_knockdown_range", 120);
}

