#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_powerup_weapon_minigun;

// Namespace zm_powerup_weapon_minigun
// Params 0, eflags: 0x2
// Checksum 0xab254377, Offset: 0x360
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_powerup_weapon_minigun", &__init__, undefined, undefined);
}

// Namespace zm_powerup_weapon_minigun
// Params 0, eflags: 0x0
// Checksum 0x91d9045b, Offset: 0x3a0
// Size: 0x184
function __init__() {
    zm_powerups::register_powerup("minigun", &grab_minigun);
    zm_powerups::register_powerup_weapon("minigun", &minigun_countdown);
    zm_powerups::powerup_set_prevent_pick_up_if_drinking("minigun", 1);
    zm_powerups::set_weapon_ignore_max_ammo("minigun");
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("minigun", "zombie_pickup_minigun", %ZOMBIE_POWERUP_MINIGUN, &func_should_drop_minigun, 1, 0, 0, undefined, "powerup_mini_gun", "zombie_powerup_minigun_time", "zombie_powerup_minigun_on");
        level.zombie_powerup_weapon["minigun"] = getweapon("minigun");
    }
    callback::on_connect(&init_player_zombie_vars);
    zm::register_actor_damage_callback(&minigun_damage_adjust);
}

// Namespace zm_powerup_weapon_minigun
// Params 1, eflags: 0x0
// Checksum 0x76b7ab7a, Offset: 0x530
// Size: 0x64
function grab_minigun(player) {
    level thread minigun_weapon_powerup(player);
    player thread zm_powerups::powerup_vo("minigun");
    if (isdefined(level._grab_minigun)) {
        level thread [[ level._grab_minigun ]](player);
    }
}

// Namespace zm_powerup_weapon_minigun
// Params 0, eflags: 0x0
// Checksum 0x83c26c6a, Offset: 0x5a0
// Size: 0x2e
function init_player_zombie_vars() {
    self.zombie_vars["zombie_powerup_minigun_on"] = 0;
    self.zombie_vars["zombie_powerup_minigun_time"] = 0;
}

// Namespace zm_powerup_weapon_minigun
// Params 0, eflags: 0x0
// Checksum 0x82f7216b, Offset: 0x5d8
// Size: 0x1e
function func_should_drop_minigun() {
    if (zm_powerups::minigun_no_drop()) {
        return false;
    }
    return true;
}

// Namespace zm_powerup_weapon_minigun
// Params 2, eflags: 0x0
// Checksum 0xd0aef139, Offset: 0x600
// Size: 0x22c
function minigun_weapon_powerup(ent_player, time) {
    ent_player endon(#"disconnect");
    ent_player endon(#"death");
    ent_player endon(#"player_downed");
    if (!isdefined(time)) {
        time = 30;
    }
    if (isdefined(level._minigun_time_override)) {
        time = level._minigun_time_override;
    }
    if (isdefined(ent_player.has_powerup_weapon["minigun"]) && (level.zombie_powerup_weapon["minigun"] == ent_player getcurrentweapon() || ent_player.zombie_vars["zombie_powerup_minigun_on"] && ent_player.has_powerup_weapon["minigun"])) {
        if (ent_player.zombie_vars["zombie_powerup_minigun_time"] < time) {
            ent_player.zombie_vars["zombie_powerup_minigun_time"] = time;
        }
        return;
    }
    level._zombie_minigun_powerup_last_stand_func = &minigun_powerup_last_stand;
    stance_disabled = 0;
    if (ent_player getstance() === "prone") {
        ent_player allowcrouch(0);
        ent_player allowprone(0);
        stance_disabled = 1;
        while (ent_player getstance() != "stand") {
            wait 0.05;
        }
    }
    zm_powerups::weapon_powerup(ent_player, time, "minigun", 1);
    if (stance_disabled) {
        ent_player allowcrouch(1);
        ent_player allowprone(1);
    }
}

// Namespace zm_powerup_weapon_minigun
// Params 0, eflags: 0x0
// Checksum 0xb9e2c0f6, Offset: 0x838
// Size: 0x1c
function minigun_powerup_last_stand() {
    zm_powerups::weapon_watch_gunner_downed("minigun");
}

// Namespace zm_powerup_weapon_minigun
// Params 2, eflags: 0x0
// Checksum 0xcebba751, Offset: 0x860
// Size: 0x6e
function minigun_countdown(ent_player, str_weapon_time) {
    while (ent_player.zombie_vars[str_weapon_time] > 0) {
        wait 0.05;
        ent_player.zombie_vars[str_weapon_time] = ent_player.zombie_vars[str_weapon_time] - 0.05;
    }
}

// Namespace zm_powerup_weapon_minigun
// Params 0, eflags: 0x0
// Checksum 0x938b7360, Offset: 0x8d8
// Size: 0x1a
function minigun_weapon_powerup_off() {
    self.zombie_vars["zombie_powerup_minigun_time"] = 0;
}

// Namespace zm_powerup_weapon_minigun
// Params 12, eflags: 0x0
// Checksum 0x5d16575c, Offset: 0x900
// Size: 0x186
function minigun_damage_adjust(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (weapon.name != "minigun") {
        return -1;
    }
    if (self.archetype == "zombie" || self.archetype == "zombie_dog" || self.archetype == "zombie_quad") {
        n_percent_damage = self.health * randomfloatrange(0.34, 0.75);
    }
    if (isdefined(level.minigun_damage_adjust_override)) {
        n_override_damage = thread [[ level.minigun_damage_adjust_override ]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype);
        if (isdefined(n_override_damage)) {
            n_percent_damage = n_override_damage;
        }
    }
    if (isdefined(n_percent_damage)) {
        damage += n_percent_damage;
    }
    return damage;
}

