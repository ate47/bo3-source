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

#namespace zm_perk_staminup;

// Namespace zm_perk_staminup
// Params 0, eflags: 0x2
// namespace_4e64316d<file_0>::function_2dc19561
// Checksum 0xd1504b87, Offset: 0x330
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_staminup", &__init__, undefined, undefined);
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x1 linked
// namespace_4e64316d<file_0>::function_8c87d8eb
// Checksum 0x84d59c04, Offset: 0x370
// Size: 0x14
function __init__() {
    enable_staminup_perk_for_level();
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x1 linked
// namespace_4e64316d<file_0>::function_d5673936
// Checksum 0x808a4b49, Offset: 0x390
// Size: 0xf4
function enable_staminup_perk_for_level() {
    zm_perks::register_perk_basic_info("specialty_staminup", "marathon", 2000, %ZOMBIE_PERK_MARATHON, getweapon("zombie_perk_bottle_marathon"));
    zm_perks::register_perk_precache_func("specialty_staminup", &staminup_precache);
    zm_perks::register_perk_clientfields("specialty_staminup", &staminup_register_clientfield, &staminup_set_clientfield);
    zm_perks::register_perk_machine("specialty_staminup", &staminup_perk_machine_setup);
    zm_perks::register_perk_host_migration_params("specialty_staminup", "vending_marathon", "marathon_light");
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x1 linked
// namespace_4e64316d<file_0>::function_867a6f34
// Checksum 0xb674a3aa, Offset: 0x490
// Size: 0xe0
function staminup_precache() {
    if (isdefined(level.var_5a8d1a8c)) {
        [[ level.var_5a8d1a8c ]]();
        return;
    }
    level._effect["marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
    level.machine_assets["specialty_staminup"] = spawnstruct();
    level.machine_assets["specialty_staminup"].weapon = getweapon("zombie_perk_bottle_marathon");
    level.machine_assets["specialty_staminup"].off_model = "p7_zm_vending_marathon";
    level.machine_assets["specialty_staminup"].on_model = "p7_zm_vending_marathon";
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x1 linked
// namespace_4e64316d<file_0>::function_55e325e
// Checksum 0x810bf9ce, Offset: 0x578
// Size: 0x34
function staminup_register_clientfield() {
    clientfield::register("clientuimodel", "hudItems.perks.marathon", 1, 2, "int");
}

// Namespace zm_perk_staminup
// Params 1, eflags: 0x1 linked
// namespace_4e64316d<file_0>::function_80d0080f
// Checksum 0xf0c8efd6, Offset: 0x5b8
// Size: 0x2c
function staminup_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.marathon", state);
}

// Namespace zm_perk_staminup
// Params 4, eflags: 0x1 linked
// namespace_4e64316d<file_0>::function_86229daf
// Checksum 0x2522895, Offset: 0x5f0
// Size: 0xbc
function staminup_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_stamin_jingle";
    use_trigger.script_string = "marathon_perk";
    use_trigger.script_label = "mus_perks_stamin_sting";
    use_trigger.target = "vending_marathon";
    perk_machine.script_string = "marathon_perk";
    perk_machine.targetname = "vending_marathon";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "marathon_perk";
    }
}

