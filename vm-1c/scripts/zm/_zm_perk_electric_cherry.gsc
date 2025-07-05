#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades_system;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_perk_electric_cherry;

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x2
// Checksum 0x1998692b, Offset: 0x5c8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_perk_electric_cherry", &__init__, undefined, undefined);
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x7b7c9358, Offset: 0x608
// Size: 0x14
function __init__() {
    enable_electric_cherry_perk_for_level();
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xdd4d310c, Offset: 0x628
// Size: 0x164
function enable_electric_cherry_perk_for_level() {
    zm_perks::register_perk_basic_info("specialty_electriccherry", "electric_cherry", 10, %ZOMBIE_PERK_WIDOWSWINE, getweapon("zombie_perk_bottle_cherry"));
    zm_perks::register_perk_precache_func("specialty_electriccherry", &electric_cherry_precache);
    zm_perks::register_perk_clientfields("specialty_electriccherry", &electric_cherry_register_clientfield, &electric_cherry_set_clientfield);
    zm_perks::register_perk_machine("specialty_electriccherry", &electric_cherry_perk_machine_setup);
    zm_perks::register_perk_host_migration_params("specialty_electriccherry", "vending_electriccherry", "electric_cherry_light");
    zm_perks::register_perk_threads("specialty_electriccherry", &electric_cherry_reload_attack, &electric_cherry_perk_lost);
    if (isdefined(level.custom_electric_cherry_perk_threads) && level.custom_electric_cherry_perk_threads) {
        level thread [[ level.custom_electric_cherry_perk_threads ]]();
    }
    init_electric_cherry();
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x3e6723f2, Offset: 0x798
// Size: 0xe0
function electric_cherry_precache() {
    if (isdefined(level.var_ad083728)) {
        [[ level.var_ad083728 ]]();
        return;
    }
    level._effect["electric_cherry_light"] = "_t6/misc/fx_zombie_cola_revive_on";
    level.machine_assets["specialty_electriccherry"] = spawnstruct();
    level.machine_assets["specialty_electriccherry"].weapon = getweapon("zombie_perk_bottle_cherry");
    level.machine_assets["specialty_electriccherry"].off_model = "p7_zm_vending_nuke";
    level.machine_assets["specialty_electriccherry"].on_model = "p7_zm_vending_nuke";
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xaf5faf, Offset: 0x880
// Size: 0x34
function electric_cherry_register_clientfield() {
    clientfield::register("clientuimodel", "hudItems.perks.electric_cherry", 1, 2, "int");
}

// Namespace zm_perk_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0x91b5a8ad, Offset: 0x8c0
// Size: 0x2c
function electric_cherry_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.electric_cherry", state);
}

// Namespace zm_perk_electric_cherry
// Params 4, eflags: 0x0
// Checksum 0xe2a8c5b8, Offset: 0x8f8
// Size: 0xbc
function electric_cherry_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
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

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x6261c9ee, Offset: 0x9c0
// Size: 0x144
function init_electric_cherry() {
    level._effect["electric_cherry_explode"] = "dlc1/castle/fx_castle_electric_cherry_down";
    level.custom_laststand_func = &electric_cherry_laststand;
    zombie_utility::set_zombie_var("tesla_head_gib_chance", 50);
    clientfield::register("allplayers", "electric_cherry_reload_fx", 1, 2, "int");
    clientfield::register("actor", "tesla_death_fx", 1, 1, "int");
    clientfield::register("vehicle", "tesla_death_fx_veh", 10000, 1, "int");
    clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int");
    clientfield::register("vehicle", "tesla_shock_eyes_fx_veh", 10000, 1, "int");
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x3f1485b6, Offset: 0xb10
// Size: 0x268
function function_1867899c() {
    init_electric_cherry();
    while (true) {
        machine = getentarray("vendingelectric_cherry", "targetname");
        machine_triggers = getentarray("vending_electriccherry", "target");
        for (i = 0; i < machine.size; i++) {
            machine[i] setmodel("p7_zm_vending_nuke");
        }
        level thread zm_perks::do_initial_power_off_callback(machine, "electriccherry");
        array::thread_all(machine_triggers, &zm_perks::set_power_on, 0);
        level waittill(#"hash_f6e94a64");
        for (i = 0; i < machine.size; i++) {
            machine[i] setmodel("p7_zm_vending_nuke");
            machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
            machine[i] playsound("zmb_perks_power_on");
            machine[i] thread zm_perks::perk_fx("electriccherry");
            machine[i] thread zm_perks::play_loop_on_machine();
        }
        level notify(#"hash_4cc54e61");
        array::thread_all(machine_triggers, &zm_perks::set_power_on, 1);
        level waittill(#"hash_80c00e12");
        array::thread_all(machine_triggers, &zm_perks::turn_perk_off);
    }
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xe7163a6c, Offset: 0xd80
// Size: 0x10a
function electric_cherry_host_migration_func() {
    a_electric_cherry_perk_machines = getentarray("vending_electriccherry", "targetname");
    foreach (perk_machine in a_electric_cherry_perk_machines) {
        if (isdefined(perk_machine.model) && perk_machine.model == "p7_zm_vending_nuke") {
            perk_machine zm_perks::perk_fx(undefined, 1);
            perk_machine thread zm_perks::perk_fx("electriccherry");
        }
    }
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x76437d95, Offset: 0xe98
// Size: 0x232
function electric_cherry_laststand() {
    visionsetlaststand("zombie_last_stand", 1);
    if (isdefined(self)) {
        playfx(level._effect["electric_cherry_explode"], self.origin);
        self playsound("zmb_cherry_explode");
        self notify(#"electric_cherry_start");
        wait 0.05;
        a_zombies = zombie_utility::get_round_enemy_array();
        a_zombies = util::get_array_of_closest(self.origin, a_zombies, undefined, undefined, 500);
        for (i = 0; i < a_zombies.size; i++) {
            if (isalive(self) && isalive(a_zombies[i])) {
                if (a_zombies[i].health <= 1000) {
                    a_zombies[i] thread electric_cherry_death_fx();
                    if (isdefined(self.var_5d79e160)) {
                        self.var_5d79e160++;
                    }
                    self zm_score::add_to_player_score(40);
                } else {
                    a_zombies[i] thread electric_cherry_stun();
                    a_zombies[i] thread electric_cherry_shock_fx();
                }
                wait 0.1;
                a_zombies[i] dodamage(1000, self.origin, self, self, "none");
            }
        }
        self notify(#"electric_cherry_end");
    }
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x366f3c4, Offset: 0x10d8
// Size: 0xfc
function electric_cherry_death_fx() {
    self endon(#"death");
    self playsound("zmb_elec_jib_zombie");
    if (!(isdefined(self.head_gibbed) && self.head_gibbed)) {
        if (isvehicle(self)) {
            self clientfield::set("tesla_shock_eyes_fx_veh", 1);
        } else {
            self clientfield::set("tesla_shock_eyes_fx", 1);
        }
        return;
    }
    if (isvehicle(self)) {
        self clientfield::set("tesla_death_fx_veh", 1);
        return;
    }
    self clientfield::set("tesla_death_fx", 1);
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x6ae0d783, Offset: 0x11e0
// Size: 0xec
function electric_cherry_shock_fx() {
    self endon(#"death");
    if (isvehicle(self)) {
        self clientfield::set("tesla_shock_eyes_fx_veh", 1);
    } else {
        self clientfield::set("tesla_shock_eyes_fx", 1);
    }
    self playsound("zmb_elec_jib_zombie");
    self waittill(#"stun_fx_end");
    if (isvehicle(self)) {
        self clientfield::set("tesla_shock_eyes_fx_veh", 0);
        return;
    }
    self clientfield::set("tesla_shock_eyes_fx", 0);
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xa1142538, Offset: 0x12d8
// Size: 0xba
function electric_cherry_stun() {
    self endon(#"death");
    self notify(#"stun_zombie");
    self endon(#"stun_zombie");
    if (self.health <= 0) {
        /#
            iprintln("<dev string:x28>");
        #/
        return;
    }
    if (self.ai_state !== "zombie_think") {
        return;
    }
    self.var_128cd975 = 1;
    self.ignoreall = 1;
    wait 4;
    if (isdefined(self)) {
        self.var_128cd975 = 0;
        self.ignoreall = 0;
        self notify(#"stun_fx_end");
    }
}

// Namespace zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xbb48159b, Offset: 0x13a0
// Size: 0x4a6
function electric_cherry_reload_attack() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon("specialty_electriccherry" + "_stop");
    self.wait_on_reload = [];
    self.consecutive_electric_cherry_attacks = 0;
    while (true) {
        self waittill(#"reload_start");
        current_weapon = self getcurrentweapon();
        if (isinarray(self.wait_on_reload, current_weapon)) {
            continue;
        }
        self.wait_on_reload[self.wait_on_reload.size] = current_weapon;
        self.consecutive_electric_cherry_attacks++;
        n_clip_current = 1;
        n_clip_max = 10;
        n_fraction = n_clip_current / n_clip_max;
        perk_radius = math::linear_map(n_fraction, 1, 0, 32, -128);
        perk_dmg = math::linear_map(n_fraction, 1, 0, 1, 1045);
        self thread check_for_reload_complete(current_weapon);
        if (isdefined(self)) {
            switch (self.consecutive_electric_cherry_attacks) {
            case 0:
            case 1:
                n_zombie_limit = undefined;
                break;
            case 2:
                n_zombie_limit = 8;
                break;
            case 3:
                n_zombie_limit = 4;
                break;
            case 4:
                n_zombie_limit = 2;
                break;
            default:
                n_zombie_limit = 0;
                break;
            }
            self thread electric_cherry_cooldown_timer(current_weapon);
            if (isdefined(n_zombie_limit) && n_zombie_limit == 0) {
                continue;
            }
            self thread electric_cherry_reload_fx(n_fraction);
            self notify(#"electric_cherry_start");
            self playsound("zmb_cherry_explode");
            a_zombies = zombie_utility::get_round_enemy_array();
            a_zombies = util::get_array_of_closest(self.origin, a_zombies, undefined, undefined, perk_radius);
            n_zombies_hit = 0;
            for (i = 0; i < a_zombies.size; i++) {
                if (isalive(self) && isalive(a_zombies[i])) {
                    if (isdefined(n_zombie_limit)) {
                        if (n_zombies_hit < n_zombie_limit) {
                            n_zombies_hit++;
                        } else {
                            break;
                        }
                    }
                    if (a_zombies[i].health <= perk_dmg) {
                        a_zombies[i] thread electric_cherry_death_fx();
                        if (isdefined(self.var_5d79e160)) {
                            self.var_5d79e160++;
                        }
                        self zm_score::add_to_player_score(40);
                    } else {
                        if (!isdefined(a_zombies[i].is_brutus)) {
                            a_zombies[i] thread electric_cherry_stun();
                        }
                        a_zombies[i] thread electric_cherry_shock_fx();
                    }
                    wait 0.1;
                    if (isdefined(a_zombies[i]) && isalive(a_zombies[i])) {
                        a_zombies[i] dodamage(perk_dmg, self.origin, self, self, "none");
                    }
                }
            }
            self notify(#"electric_cherry_end");
        }
    }
}

// Namespace zm_perk_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0x54069c5a, Offset: 0x1850
// Size: 0xc4
function electric_cherry_cooldown_timer(current_weapon) {
    self notify(#"electric_cherry_cooldown_started");
    self endon(#"electric_cherry_cooldown_started");
    self endon(#"death");
    self endon(#"disconnect");
    n_reload_time = 0.25;
    if (self hasperk("specialty_fastreload")) {
        n_reload_time *= getdvarfloat("perk_weapReloadMultiplier");
    }
    n_cooldown_time = n_reload_time + 3;
    wait n_cooldown_time;
    self.consecutive_electric_cherry_attacks = 0;
}

// Namespace zm_perk_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0x5b60cb14, Offset: 0x1920
// Size: 0xd8
function check_for_reload_complete(weapon) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon("player_lost_weapon_" + weapon.name);
    self thread weapon_replaced_monitor(weapon);
    while (true) {
        self waittill(#"reload");
        current_weapon = self getcurrentweapon();
        if (current_weapon == weapon) {
            arrayremovevalue(self.wait_on_reload, weapon);
            self notify("weapon_reload_complete_" + weapon.name);
            break;
        }
    }
}

// Namespace zm_perk_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0xc1289b2, Offset: 0x1a00
// Size: 0xcc
function weapon_replaced_monitor(weapon) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon("weapon_reload_complete_" + weapon.name);
    while (true) {
        self waittill(#"weapon_change");
        primaryweapons = self getweaponslistprimaries();
        if (!isinarray(primaryweapons, weapon)) {
            self notify("player_lost_weapon_" + weapon.name);
            arrayremovevalue(self.wait_on_reload, weapon);
            break;
        }
    }
}

// Namespace zm_perk_electric_cherry
// Params 1, eflags: 0x0
// Checksum 0x70b5f166, Offset: 0x1ad8
// Size: 0xd4
function electric_cherry_reload_fx(n_fraction) {
    if (n_fraction >= 0.67) {
        codesetclientfield(self, "electric_cherry_reload_fx", 1);
    } else if (n_fraction >= 0.33 && n_fraction < 0.67) {
        codesetclientfield(self, "electric_cherry_reload_fx", 2);
    } else {
        codesetclientfield(self, "electric_cherry_reload_fx", 3);
    }
    wait 1;
    codesetclientfield(self, "electric_cherry_reload_fx", 0);
}

// Namespace zm_perk_electric_cherry
// Params 3, eflags: 0x0
// Checksum 0xadcf3f34, Offset: 0x1bb8
// Size: 0x34
function electric_cherry_perk_lost(b_pause, str_perk, str_result) {
    self notify("specialty_electriccherry" + "_stop");
}

