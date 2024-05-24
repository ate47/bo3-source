#using scripts/zm/_zm_weapons;
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
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_perk_additionalprimaryweapon;

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x2
// Checksum 0x786dd918, Offset: 0x3f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_additionalprimaryweapon", &__init__, undefined, undefined);
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0xb675cfd1, Offset: 0x438
// Size: 0x5c
function __init__() {
    level.additionalprimaryweapon_limit = 3;
    enable_additional_primary_weapon_perk_for_level();
    callback::on_laststand(&on_laststand);
    level.var_81546dd1 = &function_81546dd1;
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0xe20b6915, Offset: 0x4a0
// Size: 0x12c
function enable_additional_primary_weapon_perk_for_level() {
    zm_perks::register_perk_basic_info("specialty_additionalprimaryweapon", "additionalprimaryweapon", 4000, %ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON, getweapon("zombie_perk_bottle_additionalprimaryweapon"));
    zm_perks::register_perk_precache_func("specialty_additionalprimaryweapon", &additional_primary_weapon_precache);
    zm_perks::register_perk_clientfields("specialty_additionalprimaryweapon", &additional_primary_weapon_register_clientfield, &additional_primary_weapon_set_clientfield);
    zm_perks::register_perk_machine("specialty_additionalprimaryweapon", &additional_primary_weapon_perk_machine_setup);
    zm_perks::register_perk_threads("specialty_additionalprimaryweapon", &give_additional_primary_weapon_perk, &take_additional_primary_weapon_perk);
    zm_perks::register_perk_host_migration_params("specialty_additionalprimaryweapon", "vending_additionalprimaryweapon", "additionalprimaryweapon_light");
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0xeacd55a6, Offset: 0x5d8
// Size: 0xe0
function additional_primary_weapon_precache() {
    if (isdefined(level.var_796aeab4)) {
        [[ level.var_796aeab4 ]]();
        return;
    }
    level._effect["additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_zmb";
    level.machine_assets["specialty_additionalprimaryweapon"] = spawnstruct();
    level.machine_assets["specialty_additionalprimaryweapon"].weapon = getweapon("zombie_perk_bottle_additionalprimaryweapon");
    level.machine_assets["specialty_additionalprimaryweapon"].off_model = "p7_zm_vending_three_gun";
    level.machine_assets["specialty_additionalprimaryweapon"].on_model = "p7_zm_vending_three_gun";
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0xeb234b9f, Offset: 0x6c0
// Size: 0x34
function additional_primary_weapon_register_clientfield() {
    clientfield::register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int");
}

// Namespace zm_perk_additionalprimaryweapon
// Params 1, eflags: 0x1 linked
// Checksum 0x8b943970, Offset: 0x700
// Size: 0x2c
function additional_primary_weapon_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", state);
}

// Namespace zm_perk_additionalprimaryweapon
// Params 4, eflags: 0x1 linked
// Checksum 0x97dfe0fa, Offset: 0x738
// Size: 0xbc
function additional_primary_weapon_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_mulekick_jingle";
    use_trigger.script_string = "tap_perk";
    use_trigger.script_label = "mus_perks_mulekick_sting";
    use_trigger.target = "vending_additionalprimaryweapon";
    perk_machine.script_string = "tap_perk";
    perk_machine.targetname = "vending_additionalprimaryweapon";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "tap_perk";
    }
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x800
// Size: 0x4
function give_additional_primary_weapon_perk() {
    
}

// Namespace zm_perk_additionalprimaryweapon
// Params 3, eflags: 0x1 linked
// Checksum 0xb40091f4, Offset: 0x810
// Size: 0x44
function take_additional_primary_weapon_perk(b_pause, str_perk, str_result) {
    if (b_pause || str_result == str_perk) {
        self function_9f037faa();
    }
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0x52556200, Offset: 0x860
// Size: 0x1ec
function function_9f037faa() {
    var_e213ec9b = level.weaponnone;
    if (isdefined(self.var_bfa19c73["specialty_additionalprimaryweapon"]) && isdefined(self.var_bfa19c73) && (isdefined(self.var_7fceabe1) && self.var_7fceabe1 || self.var_bfa19c73["specialty_additionalprimaryweapon"])) {
        return var_e213ec9b;
    }
    var_f67834f6 = [];
    primaryweapons = self getweaponslistprimaries();
    for (i = 0; i < primaryweapons.size; i++) {
        if (zm_weapons::is_weapon_included(primaryweapons[i]) || zm_weapons::is_weapon_upgraded(primaryweapons[i])) {
            var_f67834f6[var_f67834f6.size] = primaryweapons[i];
        }
    }
    self.var_a6f78ce = [];
    var_35389d53 = var_f67834f6.size;
    while (var_35389d53 >= 3) {
        var_e213ec9b = var_f67834f6[var_35389d53 - 1];
        self.var_a6f78ce[var_e213ec9b] = zm_weapons::get_player_weapondata(self, var_e213ec9b);
        var_35389d53--;
        if (var_e213ec9b == self getcurrentweapon()) {
            self switchtoweapon(var_f67834f6[0]);
        }
        self takeweapon(var_e213ec9b);
    }
    return var_e213ec9b;
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0x5188ebd1, Offset: 0xa58
// Size: 0x44
function on_laststand() {
    if (self hasperk("specialty_additionalprimaryweapon")) {
        self.var_cd3f6e8f = function_9f037faa();
    }
}

// Namespace zm_perk_additionalprimaryweapon
// Params 1, eflags: 0x1 linked
// Checksum 0xe552b3df, Offset: 0xaa8
// Size: 0x5c
function function_81546dd1(var_f52f94ab) {
    if (isdefined(self.var_a6f78ce[var_f52f94ab])) {
        self zm_weapons::weapondata_give(self.var_a6f78ce[var_f52f94ab]);
        return;
    }
    self zm_weapons::give_build_kit_weapon(var_f52f94ab);
}

