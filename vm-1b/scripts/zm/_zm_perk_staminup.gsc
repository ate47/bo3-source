#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades_system;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_perk_staminup;

// Namespace zm_perk_staminup
// Params 0, eflags: 0x2
// Checksum 0xed3ee007, Offset: 0x330
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("zm_perk_staminup", &__init__, undefined, undefined);
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x5784d252, Offset: 0x368
// Size: 0x12
function __init__() {
    enable_staminup_perk_for_level();
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x72c1915b, Offset: 0x388
// Size: 0xf2
function enable_staminup_perk_for_level() {
    zm_perks::register_perk_basic_info("specialty_staminup", "marathon", 2000, %ZOMBIE_PERK_MARATHON, getweapon("zombie_perk_bottle_marathon"));
    zm_perks::register_perk_precache_func("specialty_staminup", &staminup_precache);
    zm_perks::register_perk_clientfields("specialty_staminup", &staminup_register_clientfield, &staminup_set_clientfield);
    zm_perks::register_perk_machine("specialty_staminup", &staminup_perk_machine_setup);
    zm_perks::register_perk_host_migration_params("specialty_staminup", "vending_marathon", "marathon_light");
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x75525375, Offset: 0x488
// Size: 0xc2
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
// Params 0, eflags: 0x0
// Checksum 0xf9838263, Offset: 0x558
// Size: 0x2a
function staminup_register_clientfield() {
    clientfield::register("clientuimodel", "hudItems.perks.marathon", 1, 2, "int");
}

// Namespace zm_perk_staminup
// Params 1, eflags: 0x0
// Checksum 0x48ae9b8f, Offset: 0x590
// Size: 0x22
function staminup_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.marathon", state);
}

// Namespace zm_perk_staminup
// Params 4, eflags: 0x0
// Checksum 0x8ede0c7c, Offset: 0x5c0
// Size: 0x9a
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

