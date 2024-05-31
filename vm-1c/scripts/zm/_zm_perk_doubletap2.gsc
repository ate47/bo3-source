#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_pers_upgrades_system;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_perks;
#using scripts/zm/_util;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_f95f1bc4;

// Namespace namespace_f95f1bc4
// Params 0, eflags: 0x2
// Checksum 0x99801de0, Offset: 0x340
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_doubletap2", &__init__, undefined, undefined);
}

// Namespace namespace_f95f1bc4
// Params 0, eflags: 0x1 linked
// Checksum 0x307a5aac, Offset: 0x380
// Size: 0x14
function __init__() {
    function_67e7f8cd();
}

// Namespace namespace_f95f1bc4
// Params 0, eflags: 0x1 linked
// Checksum 0xbbeab13c, Offset: 0x3a0
// Size: 0xf4
function function_67e7f8cd() {
    zm_perks::register_perk_basic_info("specialty_doubletap2", "doubletap", 2000, %ZOMBIE_PERK_DOUBLETAP, getweapon("zombie_perk_bottle_doubletap"));
    zm_perks::register_perk_precache_func("specialty_doubletap2", &function_150621ef);
    zm_perks::register_perk_clientfields("specialty_doubletap2", &function_90c13e4d, &function_7a56affa);
    zm_perks::register_perk_machine("specialty_doubletap2", &function_fa064ac);
    zm_perks::register_perk_host_migration_params("specialty_doubletap2", "vending_doubletap", "doubletap2_light");
}

// Namespace namespace_f95f1bc4
// Params 0, eflags: 0x1 linked
// Checksum 0x93aa75ae, Offset: 0x4a0
// Size: 0xe0
function function_150621ef() {
    if (isdefined(level.var_54ded91b)) {
        [[ level.var_54ded91b ]]();
        return;
    }
    level._effect["doubletap2_light"] = "zombie/fx_perk_doubletap2_zmb";
    level.machine_assets["specialty_doubletap2"] = spawnstruct();
    level.machine_assets["specialty_doubletap2"].weapon = getweapon("zombie_perk_bottle_doubletap");
    level.machine_assets["specialty_doubletap2"].off_model = "p7_zm_vending_doubletap2";
    level.machine_assets["specialty_doubletap2"].on_model = "p7_zm_vending_doubletap2";
}

// Namespace namespace_f95f1bc4
// Params 0, eflags: 0x1 linked
// Checksum 0x492d32f, Offset: 0x588
// Size: 0x34
function function_90c13e4d() {
    clientfield::register("clientuimodel", "hudItems.perks.doubletap2", 1, 2, "int");
}

// Namespace namespace_f95f1bc4
// Params 1, eflags: 0x1 linked
// Checksum 0x682b1fa0, Offset: 0x5c8
// Size: 0x2c
function function_7a56affa(state) {
    self clientfield::set_player_uimodel("hudItems.perks.doubletap2", state);
}

// Namespace namespace_f95f1bc4
// Params 4, eflags: 0x1 linked
// Checksum 0xbbcebed8, Offset: 0x600
// Size: 0xbc
function function_fa064ac(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_doubletap_jingle";
    use_trigger.script_string = "tap_perk";
    use_trigger.script_label = "mus_perks_doubletap_sting";
    use_trigger.target = "vending_doubletap";
    perk_machine.script_string = "tap_perk";
    perk_machine.targetname = "vending_doubletap";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "tap_perk";
    }
}

