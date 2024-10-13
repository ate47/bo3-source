#using scripts/zm/craftables/_zm_craft_shield;
#using scripts/zm/_zm_weap_riotshield;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_equipment;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace tomb_shield;

// Namespace tomb_shield
// Params 0, eflags: 0x2
// Checksum 0x3bc626a9, Offset: 0x230
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_weap_tomb_shield", &__init__, &__main__, undefined);
}

// Namespace tomb_shield
// Params 0, eflags: 0x1 linked
// Checksum 0x8b2512db, Offset: 0x278
// Size: 0x7c
function __init__() {
    zm_craft_shield::init("craft_shield_zm", "tomb_shield", "wpn_t7_zmb_hd_origins_shield_dmg00_world");
    level.weaponriotshield = getweapon("tomb_shield");
    zm_equipment::register("tomb_shield", %ZOMBIE_EQUIP_RIOTSHIELD_PICKUP_HINT_STRING, %ZOMBIE_EQUIP_RIOTSHIELD_HOWTO, undefined, "riotshield");
}

// Namespace tomb_shield
// Params 0, eflags: 0x1 linked
// Checksum 0xaabe1c15, Offset: 0x300
// Size: 0x34
function __main__() {
    zm_equipment::register_for_level("tomb_shield");
    zm_equipment::include("tomb_shield");
}

