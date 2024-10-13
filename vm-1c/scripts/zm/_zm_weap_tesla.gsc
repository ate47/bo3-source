#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_lightning_chain;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace _zm_weap_tesla;

// Namespace _zm_weap_tesla
// Params 0, eflags: 0x1 linked
// Checksum 0x7ab7098, Offset: 0x688
// Size: 0x3cc
function init() {
    level.var_168d703f = getweapon("tesla_gun");
    level.var_d22a87eb = getweapon("tesla_gun_upgraded");
    if (!zm_weapons::is_weapon_included(level.var_168d703f) && !(isdefined(level.var_2bb2277c) && level.var_2bb2277c)) {
        return;
    }
    level._effect["tesla_viewmodel_rail"] = "zombie/fx_tesla_rail_view_zmb";
    level._effect["tesla_viewmodel_tube"] = "zombie/fx_tesla_tube_view_zmb";
    level._effect["tesla_viewmodel_tube2"] = "zombie/fx_tesla_tube_view2_zmb";
    level._effect["tesla_viewmodel_tube3"] = "zombie/fx_tesla_tube_view3_zmb";
    level._effect["tesla_viewmodel_rail_upgraded"] = "zombie/fx_tesla_rail_view_ug_zmb";
    level._effect["tesla_viewmodel_tube_upgraded"] = "zombie/fx_tesla_tube_view_ug_zmb";
    level._effect["tesla_viewmodel_tube2_upgraded"] = "zombie/fx_tesla_tube_view2_ug_zmb";
    level._effect["tesla_viewmodel_tube3_upgraded"] = "zombie/fx_tesla_tube_view3_ug_zmb";
    level._effect["tesla_shock_eyes"] = "zombie/fx_tesla_shock_eyes_zmb";
    zm::register_zombie_damage_override_callback(&function_e7472a4d);
    zm_spawner::register_zombie_death_animscript_callback(&function_2cffa872);
    zombie_utility::set_zombie_var("tesla_max_arcs", 5);
    zombie_utility::set_zombie_var("tesla_max_enemies_killed", 10);
    zombie_utility::set_zombie_var("tesla_radius_start", 300);
    zombie_utility::set_zombie_var("tesla_radius_decay", 20);
    zombie_utility::set_zombie_var("tesla_head_gib_chance", 75);
    zombie_utility::set_zombie_var("tesla_arc_travel_time", 0.11, 1);
    zombie_utility::set_zombie_var("tesla_kills_for_powerup", 10);
    zombie_utility::set_zombie_var("tesla_min_fx_distance", -128);
    zombie_utility::set_zombie_var("tesla_network_death_choke", 4);
    level.var_9991892 = lightning_chain::create_lightning_chain_params(level.zombie_vars["tesla_max_arcs"], level.zombie_vars["tesla_max_enemies_killed"], level.zombie_vars["tesla_radius_start"], level.zombie_vars["tesla_radius_decay"], level.zombie_vars["tesla_head_gib_chance"], level.zombie_vars["tesla_arc_travel_time"], level.zombie_vars["tesla_kills_for_powerup"], level.zombie_vars["tesla_min_fx_distance"], level.zombie_vars["tesla_network_death_choke"], undefined, undefined, "wpn_tesla_bounce");
    /#
        level thread function_4303154c();
    #/
    callback::on_spawned(&on_player_spawned);
}

/#

    // Namespace _zm_weap_tesla
    // Params 0, eflags: 0x1 linked
    // Checksum 0xde424d41, Offset: 0xa60
    // Size: 0x21c
    function function_4303154c() {
        if (!zm_weapons::is_weapon_included(level.var_168d703f)) {
            return;
        }
        setdvar("<dev string:x28>", level.zombie_vars["<dev string:x3b>"]);
        setdvar("<dev string:x4a>", level.zombie_vars["<dev string:x60>"]);
        setdvar("<dev string:x79>", level.zombie_vars["<dev string:x90>"]);
        setdvar("<dev string:xa3>", level.zombie_vars["<dev string:xba>"]);
        setdvar("<dev string:xcd>", level.zombie_vars["<dev string:xe7>"]);
        setdvar("<dev string:xfd>", level.zombie_vars["<dev string:x117>"]);
        for (;;) {
            level.zombie_vars["<dev string:x3b>"] = getdvarint("<dev string:x28>");
            level.zombie_vars["<dev string:x60>"] = getdvarint("<dev string:x4a>");
            level.zombie_vars["<dev string:x90>"] = getdvarint("<dev string:x79>");
            level.zombie_vars["<dev string:xba>"] = getdvarint("<dev string:xa3>");
            level.zombie_vars["<dev string:xe7>"] = getdvarint("<dev string:xcd>");
            level.zombie_vars["<dev string:x117>"] = getdvarfloat("<dev string:xfd>");
            wait 0.5;
        }
    }

#/

// Namespace _zm_weap_tesla
// Params 3, eflags: 0x1 linked
// Checksum 0x47ac2fff, Offset: 0xc88
// Size: 0x194
function function_51e87beb(hit_location, var_8a2b6fe5, player) {
    player endon(#"disconnect");
    if (isdefined(player.tesla_firing) && player.tesla_firing) {
        zm_utility::debug_print("TESLA: Player: '" + player.name + "' currently processing tesla damage");
        return;
    }
    if (isdefined(self.var_128cd975) && self.var_128cd975) {
        return;
    }
    zm_utility::debug_print("TESLA: Player: '" + player.name + "' hit with the tesla gun");
    player.tesla_enemies = undefined;
    player.tesla_enemies_hit = 1;
    player.var_691298ec = 0;
    player.tesla_arc_count = 0;
    player.tesla_firing = 1;
    self lightning_chain::arc_damage(self, player, 1, level.var_9991892);
    if (player.tesla_enemies_hit >= 4) {
        player thread function_ea96aa67();
    }
    player.tesla_enemies_hit = 0;
    player.tesla_firing = 0;
}

// Namespace _zm_weap_tesla
// Params 2, eflags: 0x1 linked
// Checksum 0xabb8d75d, Offset: 0xe28
// Size: 0x50
function function_53e27b27(mod, weapon) {
    return mod == "MOD_PROJECTILE" || (weapon == level.var_168d703f || weapon == level.var_d22a87eb) && mod == "MOD_PROJECTILE_SPLASH";
}

// Namespace _zm_weap_tesla
// Params 0, eflags: 0x1 linked
// Checksum 0x5e770a09, Offset: 0xe80
// Size: 0x16
function function_88a72013() {
    return isdefined(self.tesla_death) && self.tesla_death;
}

// Namespace _zm_weap_tesla
// Params 0, eflags: 0x1 linked
// Checksum 0xfed2fdf5, Offset: 0xea0
// Size: 0x4c
function on_player_spawned() {
    self thread function_3f6b791d();
    self thread function_59434970();
    self thread function_669acd5c();
}

// Namespace _zm_weap_tesla
// Params 0, eflags: 0x1 linked
// Checksum 0x7d7ecec4, Offset: 0xef8
// Size: 0x1c0
function function_3f6b791d() {
    self endon(#"disconnect");
    for (;;) {
        result = self util::waittill_any_return("grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback", "disconnect");
        if (!isdefined(result)) {
            continue;
        }
        if (self getcurrentweapon() == level.var_168d703f || (result == "weapon_change" || result == "grenade_fire") && self getcurrentweapon() == level.var_d22a87eb) {
            if (!isdefined(self.var_c7f6502b)) {
                self.var_c7f6502b = spawn("script_origin", self.origin);
                self.var_c7f6502b linkto(self);
                self thread function_a3d8ec34(self.var_c7f6502b);
            }
            self.var_c7f6502b playloopsound("wpn_tesla_idle", 0.25);
            self thread function_42e262c5();
            continue;
        }
        self notify(#"weap_away");
        if (isdefined(self.var_c7f6502b)) {
            self.var_c7f6502b stoploopsound(0.25);
        }
    }
}

// Namespace _zm_weap_tesla
// Params 1, eflags: 0x1 linked
// Checksum 0x11755d5a, Offset: 0x10c0
// Size: 0x3c
function function_a3d8ec34(loop_sound) {
    self waittill(#"disconnect");
    if (isdefined(loop_sound)) {
        loop_sound delete();
    }
}

// Namespace _zm_weap_tesla
// Params 0, eflags: 0x1 linked
// Checksum 0x77495a78, Offset: 0x1108
// Size: 0x60
function function_42e262c5() {
    self endon(#"disconnect");
    self endon(#"weap_away");
    while (true) {
        wait randomintrange(7, 15);
        self function_a7f8c5b7("wpn_tesla_sweeps_idle");
    }
}

// Namespace _zm_weap_tesla
// Params 0, eflags: 0x1 linked
// Checksum 0x25ba9847, Offset: 0x1170
// Size: 0x1b0
function function_59434970() {
    self endon(#"disconnect");
    self endon(#"death");
    for (;;) {
        attacker, weapon, damage, mod = self waittill(#"hash_7e96ab29");
        if (self laststand::player_is_in_laststand()) {
            continue;
        }
        if (weapon != level.var_168d703f && weapon != level.var_d22a87eb) {
            continue;
        }
        if (mod != "MOD_PROJECTILE" && mod != "MOD_PROJECTILE_SPLASH") {
            continue;
        }
        if (self == attacker) {
            damage = int(self.maxhealth * 0.25);
            if (damage < 25) {
                damage = 25;
            }
            if (self.health - damage < 1) {
                self.health = 1;
            } else {
                self.health -= damage;
            }
        }
        self setelectrified(1);
        self shellshock("electrocution", 1);
        self playsound("wpn_tesla_bounce");
    }
}

// Namespace _zm_weap_tesla
// Params 1, eflags: 0x1 linked
// Checksum 0x49932a2d, Offset: 0x1328
// Size: 0x128
function function_a7f8c5b7(var_5f7e5be4) {
    self endon(#"disconnect");
    if (!isdefined(level.var_dd92bf7)) {
        level.var_dd92bf7 = 0;
        level.var_9533aed = 0;
    }
    if (level.var_dd92bf7 == 0) {
        level.var_9533aed++;
        level.var_dd92bf7 = 1;
        org = spawn("script_origin", self.origin);
        org linkto(self);
        org playsoundwithnotify(var_5f7e5be4, "sound_complete" + "_" + level.var_9533aed);
        org waittill("sound_complete" + "_" + level.var_9533aed);
        org delete();
        level.var_dd92bf7 = 0;
    }
}

// Namespace _zm_weap_tesla
// Params 0, eflags: 0x1 linked
// Checksum 0xda5aef5c, Offset: 0x1458
// Size: 0x5c
function function_ea96aa67() {
    self endon(#"disconnect");
    self zm_audio::create_and_play_dialog("kill", "tesla");
    wait 3.5;
    level util::clientnotify("TGH");
}

// Namespace _zm_weap_tesla
// Params 0, eflags: 0x1 linked
// Checksum 0x42fd9012, Offset: 0x14c0
// Size: 0x54
function function_669acd5c() {
    self endon(#"disconnect");
    self endon(#"death");
    self.tesla_network_death_choke = 0;
    for (;;) {
        util::wait_network_frame();
        util::wait_network_frame();
        self.tesla_network_death_choke = 0;
    }
}

// Namespace _zm_weap_tesla
// Params 0, eflags: 0x1 linked
// Checksum 0xf5823fd7, Offset: 0x1520
// Size: 0x26
function function_2cffa872() {
    if (self function_88a72013()) {
        return true;
    }
    return false;
}

// Namespace _zm_weap_tesla
// Params 13, eflags: 0x1 linked
// Checksum 0x86ea0614, Offset: 0x1550
// Size: 0xb4
function function_e7472a4d(willbekilled, inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (self function_53e27b27(meansofdeath, weapon)) {
        self thread function_51e87beb(shitloc, vpoint, attacker);
        return true;
    }
    return false;
}

