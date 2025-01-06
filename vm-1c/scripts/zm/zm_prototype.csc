#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_radio;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_prototype_amb;
#using scripts/zm/zm_prototype_barrels;
#using scripts/zm/zm_prototype_ffotd;
#using scripts/zm/zm_prototype_fx;

#namespace zm_prototype;

// Namespace zm_prototype
// Params 0, eflags: 0x2
// Checksum 0x98ee5ad8, Offset: 0x590
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_prototype", &__init__, undefined, undefined);
}

// Namespace zm_prototype
// Params 0, eflags: 0x0
// Checksum 0x28c4f651, Offset: 0x5d0
// Size: 0x24
function __init__() {
    println("<dev string:x28>");
}

// Namespace zm_prototype
// Params 0, eflags: 0x2
// Checksum 0xcacf6a26, Offset: 0x600
// Size: 0x1c
function autoexec function_d9af860b() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace zm_prototype
// Params 0, eflags: 0x0
// Checksum 0x6f73405a, Offset: 0x628
// Size: 0xbc
function main() {
    zm_prototype_ffotd::main_start();
    zm_prototype_fx::main();
    level.default_game_mode = "zclassic";
    level.default_start_location = "default";
    level._uses_sticky_grenades = 1;
    function_b211e563();
    level thread zm_prototype_amb::main();
    util::waitforclient(0);
    level thread function_6ac83719();
    zm_prototype_ffotd::main_end();
}

// Namespace zm_prototype
// Params 0, eflags: 0x0
// Checksum 0x3a1e6247, Offset: 0x6f0
// Size: 0x4c
function function_b211e563() {
    include_weapons();
    load::main();
    _zm_weap_cymbal_monkey::init();
    level thread function_d87a7dcc();
}

// Namespace zm_prototype
// Params 0, eflags: 0x0
// Checksum 0x1c24a6a, Offset: 0x748
// Size: 0x24
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_prototype_weapons.csv", 1);
}

// Namespace zm_prototype
// Params 0, eflags: 0x0
// Checksum 0x7b8de698, Offset: 0x778
// Size: 0xca
function function_d87a7dcc() {
    for (var_bd7ba30 = 0; true; var_bd7ba30 = 1) {
        if (!level clientfield::get("zombie_power_on")) {
            level.power_on = 0;
            if (var_bd7ba30) {
                level notify(#"hash_dc853f6c");
            }
            level util::waittill_any("power_on", "pwr", "ZPO");
        }
        level notify(#"hash_dc853f6c");
        level util::waittill_any("pwo", "ZPOff");
    }
}

// Namespace zm_prototype
// Params 0, eflags: 0x0
// Checksum 0x1fd1531d, Offset: 0x850
// Size: 0x5c
function function_6ac83719() {
    visionset_mgr::function_980ca37e("zm_prototype", 0.1);
    visionset_mgr::function_a95252c1("");
    visionset_mgr::function_3aea3c1a(0, "zm_prototype");
}

