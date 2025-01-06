#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
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
#using scripts/zm/_zm_weapons;

#namespace zm_perk_additionalprimaryweapon;

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x2
// Checksum 0x20eccb41, Offset: 0x3f8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("zm_perk_additionalprimaryweapon", &__init__, undefined, undefined);
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x47aa559, Offset: 0x430
// Size: 0x3a
function __init__() {
    level.additionalprimaryweapon_limit = 3;
    enable_additional_primary_weapon_perk_for_level();
    callback::on_laststand(&on_laststand);
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0xc35e3eb8, Offset: 0x478
// Size: 0x12a
function enable_additional_primary_weapon_perk_for_level() {
    zm_perks::register_perk_basic_info("specialty_additionalprimaryweapon", "additionalprimaryweapon", 4000, %ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON, getweapon("zombie_perk_bottle_additionalprimaryweapon"));
    zm_perks::register_perk_precache_func("specialty_additionalprimaryweapon", &additional_primary_weapon_precache);
    zm_perks::register_perk_clientfields("specialty_additionalprimaryweapon", &additional_primary_weapon_register_clientfield, &additional_primary_weapon_set_clientfield);
    zm_perks::register_perk_machine("specialty_additionalprimaryweapon", &additional_primary_weapon_perk_machine_setup);
    zm_perks::register_perk_threads("specialty_additionalprimaryweapon", &give_additional_primary_weapon_perk, &take_additional_primary_weapon_perk);
    zm_perks::register_perk_host_migration_params("specialty_additionalprimaryweapon", "vending_additionalprimaryweapon", "additionalprimaryweapon_light");
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x48b9a2ae, Offset: 0x5b0
// Size: 0xc2
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
// Params 0, eflags: 0x0
// Checksum 0xd3c68c1f, Offset: 0x680
// Size: 0x2a
function additional_primary_weapon_register_clientfield() {
    clientfield::register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int");
}

// Namespace zm_perk_additionalprimaryweapon
// Params 1, eflags: 0x0
// Checksum 0xa0a8be0b, Offset: 0x6b8
// Size: 0x22
function additional_primary_weapon_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", state);
}

// Namespace zm_perk_additionalprimaryweapon
// Params 4, eflags: 0x0
// Checksum 0x1582a63b, Offset: 0x6e8
// Size: 0x9a
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
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x790
// Size: 0x2
function give_additional_primary_weapon_perk() {
    
}

// Namespace zm_perk_additionalprimaryweapon
// Params 3, eflags: 0x0
// Checksum 0x52c92866, Offset: 0x7a0
// Size: 0x3a
function take_additional_primary_weapon_perk(b_pause, str_perk, str_result) {
    if (b_pause || str_result == str_perk) {
        self function_9f037faa();
    }
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0xd9eef195, Offset: 0x7e8
// Size: 0x137
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
    var_35389d53 = var_f67834f6.size;
    while (var_35389d53 >= 3) {
        var_e213ec9b = var_f67834f6[var_35389d53 - 1];
        var_35389d53--;
        if (var_e213ec9b == self getcurrentweapon()) {
            self switchtoweapon(var_f67834f6[0]);
        }
        self takeweapon(var_e213ec9b);
    }
    return var_e213ec9b;
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x65afd285, Offset: 0x928
// Size: 0x32
function on_laststand() {
    if (self hasperk("specialty_additionalprimaryweapon")) {
        self.var_cd3f6e8f = function_9f037faa();
    }
}

