#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_laststand;

// Namespace zm_laststand
// Params 0, eflags: 0x2
// Checksum 0xfad1cdbb, Offset: 0x680
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_laststand", &__init__, undefined, undefined);
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xf3743730, Offset: 0x6c0
// Size: 0x1fc
function __init__() {
    function_72c619a4();
    level.laststand_update_clientfields = [];
    for (i = 0; i < 4; i++) {
        level.laststand_update_clientfields[i] = "laststand_update" + i;
        clientfield::register("world", level.laststand_update_clientfields[i], 1, 5, "counter");
    }
    level.weaponsuicide = getweapon("death_self");
    level.primaryprogressbarx = 0;
    level.primaryprogressbary = 110;
    level.primaryprogressbarheight = 4;
    level.primaryprogressbarwidth = 120;
    level.var_f0aa5b7d = 280;
    if (getdvarstring("revive_trigger_radius") == "") {
        setdvar("revive_trigger_radius", "40");
    }
    level.var_da98bf76 = 0;
    if (!isdefined(level.var_5a1519a3)) {
        level.var_5a1519a3 = 1000;
    }
    visionset_mgr::register_info("visionset", "zombie_last_stand", 1, level.var_5a1519a3, 31, 1, &visionset_mgr::ramp_in_thread_per_player, 0);
    if (!isdefined(level.var_ba5842c1)) {
        level.var_ba5842c1 = 1100;
    }
    visionset_mgr::register_info("visionset", "zombie_death", 1, level.var_ba5842c1, 31, 1, &visionset_mgr::ramp_in_thread_per_player, 0);
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x829613ea, Offset: 0x8c8
// Size: 0xa6
function function_72c619a4() {
    level.var_638daea0 = 0;
    level.var_47df2be6 = 0.5;
    level.var_82457459 = 0.0025;
    level.var_2ffda0f5 = 0.1;
    level.var_b4442f7e = [];
    level.var_b4442f7e[0] = %ZOMBIE_PLAYER_NAME_0;
    level.var_b4442f7e[1] = %ZOMBIE_PLAYER_NAME_1;
    level.var_b4442f7e[2] = %ZOMBIE_PLAYER_NAME_2;
    level.var_b4442f7e[3] = %ZOMBIE_PLAYER_NAME_3;
}

// Namespace zm_laststand
// Params 9, eflags: 0x0
// Checksum 0x32ce7c9d, Offset: 0x978
// Size: 0x2dc
function player_last_stand_stats(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(attacker) && isplayer(attacker) && attacker != self) {
        if ("zcleansed" == level.gametype) {
            demo::bookmark("kill", gettime(), attacker, self, 0, einflictor);
        }
        if ("zcleansed" == level.gametype) {
            if (!(isdefined(attacker.is_zombie) && attacker.is_zombie)) {
                attacker.kills++;
            } else {
                attacker.downs++;
            }
        } else {
            attacker.kills++;
        }
        attacker zm_stats::increment_client_stat("kills");
        attacker zm_stats::increment_player_stat("kills");
        attacker addweaponstat(weapon, "kills", 1);
        if (zm_utility::is_headshot(weapon, shitloc, smeansofdeath)) {
            attacker.headshots++;
            attacker zm_stats::increment_client_stat("headshots");
            attacker addweaponstat(weapon, "headshots", 1);
            attacker zm_stats::increment_player_stat("headshots");
        }
    }
    self increment_downed_stat();
    if (level flag::get("solo_game") && !self.lives && getnumconnectedplayers() < 2) {
        self zm_stats::increment_client_stat("deaths");
        self zm_stats::increment_player_stat("deaths");
        self namespace_25f8c2ad::function_3699cfb6();
    }
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xd77d42b9, Offset: 0xc60
// Size: 0x10c
function increment_downed_stat() {
    if ("zcleansed" != level.gametype) {
        self.downs++;
    }
    self zm_stats::increment_global_stat("TOTAL_DOWNS");
    self zm_stats::increment_map_stat("TOTAL_DOWNS");
    self zm_stats::increment_client_stat("downs");
    self add_weighted_down();
    self zm_stats::increment_player_stat("downs");
    zonename = self zm_utility::get_current_zone();
    if (!isdefined(zonename)) {
        zonename = "";
    }
    self recordplayerdownzombies(zonename);
}

// Namespace zm_laststand
// Params 9, eflags: 0x0
// Checksum 0x6070820b, Offset: 0xd78
// Size: 0x43c
function playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    self notify(#"entering_last_stand");
    self disableweaponcycling();
    if (isdefined(level.var_c7048fc8)) {
        self [[ level.var_c7048fc8 ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    }
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    if (isdefined(self.in_zombify_call) && self.in_zombify_call) {
        return;
    }
    self thread player_last_stand_stats(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    if (isdefined(level.var_a6179873)) {
        [[ level.var_a6179873 ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    }
    self.health = 1;
    self.laststand = 1;
    self set_ignoreme(1);
    callback::callback(#"hash_6751ab5b");
    self thread gameobjects::on_player_last_stand();
    if (!(isdefined(self.no_revive_trigger) && self.no_revive_trigger)) {
        self revive_trigger_spawn();
    } else {
        self undolaststand();
    }
    if (isdefined(self.is_zombie) && self.is_zombie) {
        self takeallweapons();
        if (isdefined(attacker) && isplayer(attacker) && attacker != self) {
            attacker notify(#"killed_a_zombie_player", einflictor, self, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        }
    } else {
        self laststand_disable_player_weapons();
        self laststand_give_pistol();
    }
    if (isdefined(level.var_ede2ac9e) && level.var_ede2ac9e && getplayers().size > 1) {
        if (!isdefined(level.canplayersuicide) || self [[ level.canplayersuicide ]]()) {
            self thread function_32b4342();
        }
    }
    if (isdefined(self.var_46793f8f)) {
        self.var_46793f8f = [];
    }
    if (level.var_da98bf76) {
        self thread function_38c5da09();
    } else {
        bleedout_time = getdvarfloat("player_lastStandBleedoutTime");
        if (isdefined(self.n_bleedout_time_multiplier)) {
            bleedout_time *= self.n_bleedout_time_multiplier;
        }
        level clientfield::increment("laststand_update" + self getentitynumber(), 30);
        self thread laststand_bleedout(bleedout_time);
    }
    demo::bookmark("player_downed", gettime(), self);
    self notify(#"player_downed");
    self thread refire_player_downed();
    self thread laststand::function_d4eb424f();
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xac0b3f6b, Offset: 0x11c0
// Size: 0x46
function refire_player_downed() {
    self endon(#"player_revived");
    self endon(#"death");
    self endon(#"disconnect");
    wait 1;
    if (self.num_perks) {
        self notify(#"player_downed");
    }
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x811e5ad9, Offset: 0x1210
// Size: 0x49e
function laststand_disable_player_weapons() {
    self disableweaponcycling();
    weaponinventory = self getweaponslist(1);
    self.var_7e00777a = self getweaponslistprimaries();
    self.lastactiveweapon = self getcurrentweapon();
    var_136e492e = 0;
    if (isdefined(self) && self isswitchingweapons()) {
        var_136e492e = 1;
    }
    if (self isthrowinggrenade() && zm_utility::is_offhand_weapon(self.lastactiveweapon)) {
        var_136e492e = 1;
    }
    if (zm_utility::is_hero_weapon(self.lastactiveweapon)) {
        var_136e492e = 1;
    }
    if (self.lastactiveweapon.isriotshield) {
        var_136e492e = 1;
    }
    if (var_136e492e) {
        if (isdefined(self.var_7e00777a) && self.var_7e00777a.size > 0) {
            self switchtoweaponimmediate();
        } else {
            self zm_weapons::give_fallback_weapon(1);
        }
        self util::waittill_any_timeout(1, "weapon_change_complete");
    }
    self.lastactiveweapon = self getcurrentweapon();
    self function_927e3c75(self.lastactiveweapon);
    self.laststandpistol = undefined;
    self.hadpistol = 0;
    for (i = 0; i < weaponinventory.size; i++) {
        weapon = weaponinventory[i];
        var_5ee50b20 = weapon.weapclass;
        if (weapon.isballisticknife) {
            var_5ee50b20 = "knife";
        }
        if ((var_5ee50b20 == "pistol" || var_5ee50b20 == "pistol spread" || var_5ee50b20 == "pistolspread") && !isdefined(self.laststandpistol)) {
            self.laststandpistol = weapon;
            self.hadpistol = 1;
        }
        if (weapon == level.weaponrevivetool || weapon === self.weaponrevivetool) {
            self zm_stats::increment_client_stat("failed_sacrifices");
            self zm_stats::increment_player_stat("failed_sacrifices");
        } else if (weapon.isperkbottle) {
            self takeweapon(weapon);
            self.lastactiveweapon = level.weaponnone;
            continue;
        }
        if (isdefined(zm_utility::get_gamemode_var("item_meat_weapon"))) {
            if (weapon == zm_utility::get_gamemode_var("item_meat_weapon")) {
                self takeweapon(weapon);
                self.lastactiveweapon = level.weaponnone;
            }
        }
    }
    if (isdefined(self.hadpistol) && self.hadpistol && isdefined(level.var_ea98d60f)) {
        self [[ level.var_ea98d60f ]]();
    }
    if (!isdefined(self.laststandpistol)) {
        if (!isdefined(self.var_cfcd9f89)) {
            self.var_cfcd9f89 = self zm_stats::get_global_stat("DARKOPS_GENESIS_SUPER_EE") > 0;
        }
        if (self.var_cfcd9f89) {
            self.laststandpistol = level.super_ee_weapon;
        } else {
            self.laststandpistol = level.laststandpistol;
        }
    }
    self notify(#"weapons_taken_for_last_stand");
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x4da5832e, Offset: 0x16b8
// Size: 0x22e
function laststand_enable_player_weapons() {
    if (self hasperk("specialty_additionalprimaryweapon") && isdefined(self.var_cd3f6e8f)) {
        if (isdefined(level.var_81546dd1)) {
            self [[ level.var_81546dd1 ]](self.var_cd3f6e8f);
        } else {
            self zm_weapons::give_build_kit_weapon(self.var_cd3f6e8f);
        }
    } else if (isdefined(self.var_cd3f6e8f) && self.lastactiveweapon == self.var_cd3f6e8f) {
        self.lastactiveweapon = level.weaponnone;
    }
    if (isdefined(self.hadpistol) && !self.hadpistol && isdefined(self.laststandpistol)) {
        self takeweapon(self.laststandpistol);
    }
    if (isdefined(self.hadpistol) && self.hadpistol == 1 && isdefined(level.var_c725f229) && isdefined(self.laststandpistol)) {
        [[ level.var_c725f229 ]]();
    }
    self enableweaponcycling();
    self enableoffhandweapons();
    if (self.lastactiveweapon != level.weaponnone && self hasweapon(self.lastactiveweapon) && !zm_utility::is_placeable_mine(self.lastactiveweapon) && !zm_equipment::is_equipment(self.lastactiveweapon) && !zm_utility::is_hero_weapon(self.lastactiveweapon)) {
        self switchtoweapon(self.lastactiveweapon);
    } else {
        self switchtoweapon();
    }
    self.laststandpistol = undefined;
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x2508235b, Offset: 0x18f0
// Size: 0x28
function laststand_has_players_weapons_returned(e_player) {
    if (isdefined(e_player.laststandpistol)) {
        return false;
    }
    return true;
}

// Namespace zm_laststand
// Params 3, eflags: 0x0
// Checksum 0x857b1750, Offset: 0x1920
// Size: 0x104
function laststand_clean_up_on_disconnect(e_revivee, w_reviver, w_revive_tool) {
    self endon(#"do_revive_ended_normally");
    revivetrigger = e_revivee.revivetrigger;
    e_revivee waittill(#"disconnect");
    if (isdefined(revivetrigger)) {
        revivetrigger delete();
    }
    self laststand::function_4a66f284();
    if (isdefined(self.var_30d551a2)) {
        self.var_30d551a2 hud::destroyelem();
    }
    if (isdefined(self.var_fca62492)) {
        self.var_fca62492 destroy();
    }
    if (isdefined(w_reviver) && isdefined(w_revive_tool)) {
        self revive_give_back_weapons(w_reviver, w_revive_tool);
    }
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x93a66eba, Offset: 0x1a30
// Size: 0xb4
function laststand_clean_up_reviving_any(e_revivee) {
    self endon(#"do_revive_ended_normally");
    e_revivee util::waittill_any("disconnect", "zombified", "stop_revive_trigger");
    self.is_reviving_any--;
    if (0 > self.is_reviving_any) {
        self.is_reviving_any = 0;
    }
    if (isdefined(self.var_30d551a2)) {
        self.var_30d551a2 hud::destroyelem();
    }
    if (isdefined(self.var_fca62492)) {
        self.var_fca62492 destroy();
    }
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xb093f9fa, Offset: 0x1af0
// Size: 0xec
function laststand_give_pistol() {
    assert(isdefined(self.laststandpistol));
    assert(self.laststandpistol != level.weaponnone);
    if (isdefined(level.zombie_last_stand)) {
        [[ level.zombie_last_stand ]]();
    } else {
        self giveweapon(self.laststandpistol);
        self givemaxammo(self.laststandpistol);
        self switchtoweapon(self.laststandpistol);
    }
    self thread wait_switch_weapon(1, self.laststandpistol);
}

// Namespace zm_laststand
// Params 2, eflags: 0x0
// Checksum 0x95858956, Offset: 0x1be8
// Size: 0x64
function wait_switch_weapon(n_delay, w_weapon) {
    self endon(#"player_revived");
    self endon(#"player_suicide");
    self endon(#"zombified");
    self endon(#"disconnect");
    wait n_delay;
    self switchtoweapon(w_weapon);
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x4c189c15, Offset: 0x1c58
// Size: 0x2f4
function laststand_bleedout(delay) {
    self endon(#"player_revived");
    self endon(#"player_suicide");
    self endon(#"zombified");
    self endon(#"disconnect");
    if (isdefined(self.no_revive_trigger) && (isdefined(self.is_zombie) && self.is_zombie || self.no_revive_trigger)) {
        self notify(#"bled_out");
        util::wait_network_frame();
        self bleed_out();
        return;
    }
    self clientfield::set("zmbLastStand", 1);
    self.bleedout_time = delay;
    n_default_bleedout_time = getdvarfloat("player_lastStandBleedoutTime");
    n_bleedout_time = self.bleedout_time;
    n_start_time = gettime();
    while (self.bleedout_time > int(delay * 0.5)) {
        if (n_bleedout_time > n_default_bleedout_time && !isdefined(self.n_bleedout_time_multiplier)) {
            n_current_time = gettime();
            n_total_time = (n_current_time - n_start_time) / 1000;
            if (n_total_time > n_default_bleedout_time) {
                delay = 4;
                self.bleedout_time = 2;
                break;
            }
        }
        self.bleedout_time -= 1;
        wait 1;
    }
    visionset_mgr::activate("visionset", "zombie_death", self, delay * 0.5);
    while (self.bleedout_time > 0) {
        self.bleedout_time -= 1;
        level clientfield::increment("laststand_update" + self getentitynumber(), self.bleedout_time + 1);
        wait 1;
    }
    while (isdefined(self.revivetrigger) && isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived == 1) {
        wait 0.1;
    }
    self notify(#"bled_out");
    util::wait_network_frame();
    self bleed_out();
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xfeff0eb3, Offset: 0x1f58
// Size: 0x23c
function bleed_out() {
    self laststand::function_4a66f284();
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
    }
    self.revivetrigger = undefined;
    self clientfield::set("zmbLastStand", 0);
    self zm_stats::increment_client_stat("deaths");
    self zm_stats::increment_player_stat("deaths");
    self namespace_25f8c2ad::function_3699cfb6();
    self recordplayerdeathzombies();
    self.last_bleed_out_time = gettime();
    self zm_equipment::take();
    self zm_hero_weapon::function_fbd02062();
    level clientfield::increment("laststand_update" + self getentitynumber(), 1);
    demo::bookmark("zm_player_bledout", gettime(), self, undefined, 1);
    level notify(#"bleed_out", self.characterindex);
    self undolaststand();
    visionset_mgr::deactivate("visionset", "zombie_last_stand", self);
    visionset_mgr::deactivate("visionset", "zombie_death", self);
    if (isdefined(level.is_zombie_level) && level.is_zombie_level) {
        self thread [[ level.player_becomes_zombie ]]();
        return;
    }
    if (isdefined(level.var_551b3248) && level.var_551b3248) {
        self thread [[ level.spawnspectator ]]();
        return;
    }
    self set_ignoreme(0);
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x47fc10a8, Offset: 0x21a0
// Size: 0x17c
function function_32b4342() {
    radius = getdvarint("revive_trigger_radius");
    self.suicideprompt = newclienthudelem(self);
    self.suicideprompt.alignx = "center";
    self.suicideprompt.aligny = "middle";
    self.suicideprompt.horzalign = "center";
    self.suicideprompt.vertalign = "bottom";
    self.suicideprompt.y = -170;
    if (self issplitscreen()) {
        self.suicideprompt.y = -132;
    }
    self.suicideprompt.foreground = 1;
    self.suicideprompt.font = "default";
    self.suicideprompt.fontscale = 1.5;
    self.suicideprompt.alpha = 1;
    self.suicideprompt.color = (1, 1, 1);
    self.suicideprompt.hidewheninmenu = 1;
    self thread function_5c3b9a2f();
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xc26aa55d, Offset: 0x2328
// Size: 0x272
function function_5c3b9a2f() {
    self endon(#"disconnect");
    self endon(#"zombified");
    self endon(#"stop_revive_trigger");
    self endon(#"player_revived");
    self endon(#"bled_out");
    self endon(#"fake_death");
    level endon(#"end_game");
    level endon(#"stop_suicide_trigger");
    self thread laststand::function_9a3e66fc();
    self thread laststand::function_a5c40dbc();
    while (self usebuttonpressed()) {
        wait 1;
    }
    if (!isdefined(self.suicideprompt)) {
        return;
    }
    while (true) {
        wait 0.1;
        if (!isdefined(self.suicideprompt)) {
            continue;
        }
        self.suicideprompt settext(%ZOMBIE_BUTTON_TO_SUICIDE);
        if (!self is_suiciding()) {
            continue;
        }
        self.var_7602ee2c = self getcurrentweapon();
        self giveweapon(level.weaponsuicide);
        self switchtoweapon(level.weaponsuicide);
        duration = self docowardswayanims();
        var_8677f253 = function_51ede748(duration);
        self.laststand = undefined;
        self takeweapon(level.weaponsuicide);
        if (var_8677f253) {
            self notify(#"player_suicide");
            util::wait_network_frame();
            self zm_stats::increment_client_stat("suicides");
            self bleed_out();
            return;
        }
        self switchtoweapon(self.var_7602ee2c);
        self.var_7602ee2c = undefined;
    }
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x7304a51, Offset: 0x25a8
// Size: 0x308
function function_51ede748(duration) {
    level endon(#"end_game");
    level endon(#"stop_suicide_trigger");
    var_6d12a464 = duration;
    timer = 0;
    var_5da69e51 = 0;
    self.suicideprompt settext("");
    if (!isdefined(self.var_af0e0d25)) {
        self.var_af0e0d25 = self hud::createprimaryprogressbar();
    }
    if (!isdefined(self.var_292c9541)) {
        self.var_292c9541 = newclienthudelem(self);
    }
    self.var_af0e0d25 hud::updatebar(0.01, 1 / var_6d12a464);
    self.var_292c9541.alignx = "center";
    self.var_292c9541.aligny = "middle";
    self.var_292c9541.horzalign = "center";
    self.var_292c9541.vertalign = "bottom";
    self.var_292c9541.y = -173;
    if (self issplitscreen()) {
        self.var_292c9541.y = -147;
    }
    self.var_292c9541.foreground = 1;
    self.var_292c9541.font = "default";
    self.var_292c9541.fontscale = 1.8;
    self.var_292c9541.alpha = 1;
    self.var_292c9541.color = (1, 1, 1);
    self.var_292c9541.hidewheninmenu = 1;
    self.var_292c9541 settext(%ZOMBIE_SUICIDING);
    while (self is_suiciding()) {
        wait 0.05;
        timer += 0.05;
        if (timer >= var_6d12a464) {
            var_5da69e51 = 1;
            break;
        }
    }
    if (isdefined(self.var_af0e0d25)) {
        self.var_af0e0d25 hud::destroyelem();
    }
    if (isdefined(self.var_292c9541)) {
        self.var_292c9541 destroy();
    }
    if (isdefined(self.suicideprompt)) {
        self.suicideprompt settext(%ZOMBIE_BUTTON_TO_SUICIDE);
    }
    return var_5da69e51;
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x9193ff27, Offset: 0x28b8
// Size: 0x86
function can_suicide() {
    if (!isalive(self)) {
        return false;
    }
    if (!self laststand::player_is_in_laststand()) {
        return false;
    }
    if (!isdefined(self.suicideprompt)) {
        return false;
    }
    if (isdefined(self.is_zombie) && self.is_zombie) {
        return false;
    }
    if (isdefined(level.intermission) && level.intermission) {
        return false;
    }
    return true;
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x65451413, Offset: 0x2948
// Size: 0x3a
function is_suiciding(revivee) {
    return self usebuttonpressed() && can_suicide();
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x6cd1e842, Offset: 0x2990
// Size: 0x174
function revive_trigger_spawn() {
    if (isdefined(level.var_35062dcd)) {
        [[ level.var_35062dcd ]](self);
    } else {
        radius = getdvarint("revive_trigger_radius");
        self.revivetrigger = spawn("trigger_radius", (0, 0, 0), 0, radius, radius);
        self.revivetrigger sethintstring("");
        self.revivetrigger setcursorhint("HINT_NOICON");
        self.revivetrigger setmovingplatformenabled(1);
        self.revivetrigger enablelinkto();
        self.revivetrigger.origin = self.origin;
        self.revivetrigger linkto(self);
        self.revivetrigger setinvisibletoplayer(self);
        self.revivetrigger.beingrevived = 0;
        self.revivetrigger.createtime = gettime();
    }
    self thread revive_trigger_think();
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x931be956, Offset: 0x2b10
// Size: 0x522
function revive_trigger_think(t_secondary) {
    self endon(#"disconnect");
    self endon(#"zombified");
    self endon(#"stop_revive_trigger");
    level endon(#"end_game");
    self endon(#"death");
    while (true) {
        wait 0.05;
        if (isdefined(t_secondary)) {
            t_revive = t_secondary;
        } else {
            t_revive = self.revivetrigger;
        }
        t_revive sethintstring("");
        for (i = 0; i < level.players.size; i++) {
            n_depth = 0;
            n_depth = self depthinwater();
            if (isdefined(t_secondary)) {
                if (level.players[i] can_revive(self, 1, 1) && level.players[i] istouching(t_revive) || n_depth > 20) {
                    t_revive setrevivehintstring(%ZOMBIE_BUTTON_TO_REVIVE_PLAYER, self.team);
                    break;
                }
                continue;
            }
            if (level.players[i] can_revive_via_override(self) || level.players[i] can_revive(self) || n_depth > 20) {
                t_revive setrevivehintstring(%ZOMBIE_BUTTON_TO_REVIVE_PLAYER, self.team);
                break;
            }
        }
        for (i = 0; i < level.players.size; i++) {
            e_reviver = level.players[i];
            if (self == e_reviver || !e_reviver is_reviving(self, t_secondary)) {
                continue;
            }
            if (!isdefined(e_reviver.s_revive_override_used) || e_reviver.s_revive_override_used.b_use_revive_tool) {
                w_revive_tool = level.weaponrevivetool;
                if (isdefined(e_reviver.weaponrevivetool)) {
                    w_revive_tool = e_reviver.weaponrevivetool;
                }
                w_reviver = e_reviver getcurrentweapon();
                assert(isdefined(w_reviver));
                if (w_reviver == w_revive_tool) {
                    continue;
                }
                e_reviver giveweapon(w_revive_tool);
                e_reviver switchtoweapon(w_revive_tool);
                e_reviver setweaponammostock(w_revive_tool, 1);
                e_reviver thread revive_give_back_weapons_when_done(w_reviver, w_revive_tool, self);
            } else {
                w_reviver = undefined;
                w_revive_tool = undefined;
            }
            b_revive_successful = e_reviver revive_do_revive(self, w_reviver, w_revive_tool, t_secondary);
            e_reviver notify(#"revive_done");
            if (isplayer(self)) {
                self allowjump(1);
            }
            self.laststand = undefined;
            if (b_revive_successful) {
                if (isdefined(level.a_revive_success_perk_func)) {
                    foreach (func in level.a_revive_success_perk_func) {
                        self [[ func ]]();
                    }
                }
                self thread revive_success(e_reviver);
                self laststand::function_4a66f284();
                self notify(#"stop_revive_trigger");
                return;
            }
        }
    }
}

// Namespace zm_laststand
// Params 2, eflags: 0x0
// Checksum 0x837f5de9, Offset: 0x3040
// Size: 0x5e
function revive_give_back_weapons_wait(e_reviver, e_revivee) {
    e_revivee endon(#"disconnect");
    e_revivee endon(#"zombified");
    e_revivee endon(#"stop_revive_trigger");
    level endon(#"end_game");
    e_revivee endon(#"death");
    e_reviver waittill(#"revive_done");
}

// Namespace zm_laststand
// Params 3, eflags: 0x0
// Checksum 0x97a18d1d, Offset: 0x30a8
// Size: 0x54
function revive_give_back_weapons_when_done(w_reviver, w_revive_tool, e_revivee) {
    revive_give_back_weapons_wait(self, e_revivee);
    self revive_give_back_weapons(w_reviver, w_revive_tool);
}

// Namespace zm_laststand
// Params 2, eflags: 0x0
// Checksum 0x3c6ebbe8, Offset: 0x3108
// Size: 0x10c
function revive_give_back_weapons(w_reviver, w_revive_tool) {
    self takeweapon(w_revive_tool);
    if (self laststand::player_is_in_laststand()) {
        return;
    }
    if (isdefined(level.var_24b087ad) && self [[ level.var_24b087ad ]](w_reviver)) {
        return;
    }
    if (w_reviver != level.weaponnone && !zm_utility::is_placeable_mine(w_reviver) && !zm_equipment::is_equipment(w_reviver) && !w_reviver.isflourishweapon && self hasweapon(w_reviver)) {
        self zm_weapons::switch_back_primary_weapon(w_reviver);
        return;
    }
    self zm_weapons::switch_back_primary_weapon();
}

// Namespace zm_laststand
// Params 3, eflags: 0x0
// Checksum 0x85cfe637, Offset: 0x3220
// Size: 0x2fe
function can_revive(e_revivee, ignore_sight_checks, ignore_touch_checks) {
    if (!isdefined(ignore_sight_checks)) {
        ignore_sight_checks = 0;
    }
    if (!isdefined(ignore_touch_checks)) {
        ignore_touch_checks = 0;
    }
    if (!isdefined(e_revivee.revivetrigger)) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self laststand::player_is_in_laststand()) {
        return false;
    }
    if (self.team != e_revivee.team) {
        return false;
    }
    if (isdefined(self.is_zombie) && self.is_zombie) {
        return false;
    }
    if (self zm_utility::has_powerup_weapon()) {
        return false;
    }
    if (self zm_utility::has_hero_weapon()) {
        return false;
    }
    if (isdefined(level.can_revive_use_depthinwater_test) && level.can_revive_use_depthinwater_test && e_revivee depthinwater() > 10) {
        return true;
    }
    if (isdefined(level.can_revive) && ![[ level.can_revive ]](e_revivee)) {
        return false;
    }
    if (isdefined(level.var_ae6ced2b) && ![[ level.var_ae6ced2b ]](e_revivee)) {
        return false;
    }
    if (!ignore_sight_checks && isdefined(level.revive_trigger_should_ignore_sight_checks)) {
        ignore_sight_checks = [[ level.revive_trigger_should_ignore_sight_checks ]](self);
        if (ignore_sight_checks && isdefined(e_revivee.revivetrigger.beingrevived) && e_revivee.revivetrigger.beingrevived == 1) {
            ignore_touch_checks = 1;
        }
    }
    if (!ignore_touch_checks) {
        if (!self istouching(e_revivee.revivetrigger)) {
            return false;
        }
    }
    if (!ignore_sight_checks) {
        if (!self laststand::is_facing(e_revivee)) {
            return false;
        }
        if (!sighttracepassed(self.origin + (0, 0, 50), e_revivee.origin + (0, 0, 30), 0, undefined)) {
            return false;
        }
        if (!bullettracepassed(self.origin + (0, 0, 50), e_revivee.origin + (0, 0, 30), 0, undefined)) {
            return false;
        }
    }
    return true;
}

// Namespace zm_laststand
// Params 2, eflags: 0x0
// Checksum 0x6bb4dd14, Offset: 0x3528
// Size: 0xba
function is_reviving(e_revivee, t_secondary) {
    if (self is_reviving_via_override(e_revivee)) {
        return true;
    }
    if (isdefined(t_secondary)) {
        return (self usebuttonpressed() && self can_revive(e_revivee, 1, 1) && self istouching(t_secondary));
    }
    return self usebuttonpressed() && can_revive(e_revivee);
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xec94b82d, Offset: 0x35f0
// Size: 0x16
function is_reviving_any() {
    return isdefined(self.is_reviving_any) && self.is_reviving_any;
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x51786d81, Offset: 0x3610
// Size: 0xa4
function revive_get_revive_time(e_revivee) {
    revivetime = 3;
    if (self hasperk("specialty_quickrevive")) {
        revivetime /= 2;
    }
    if (self namespace_25f8c2ad::function_d3c7ee5c()) {
        revivetime *= 0.5;
    }
    if (isdefined(self.get_revive_time)) {
        revivetime = self [[ self.get_revive_time ]](e_revivee);
    }
    return revivetime;
}

// Namespace zm_laststand
// Params 4, eflags: 0x0
// Checksum 0x5b65afb1, Offset: 0x36c0
// Size: 0x600
function revive_do_revive(e_revivee, w_reviver, w_revive_tool, t_secondary) {
    assert(self is_reviving(e_revivee, t_secondary));
    revivetime = self revive_get_revive_time(e_revivee);
    timer = 0;
    revived = 0;
    e_revivee.revivetrigger.beingrevived = 1;
    name = level.var_b4442f7e[self getentitynumber()];
    e_revivee.revive_hud settext(%ZOMBIE_PLAYER_IS_REVIVING_YOU, name);
    e_revivee laststand::revive_hud_show_n_fade(3);
    e_revivee.revivetrigger sethintstring("");
    if (isplayer(e_revivee)) {
        e_revivee startrevive(self);
    }
    if (0 && !isdefined(self.var_30d551a2)) {
        self.var_30d551a2 = self hud::createprimaryprogressbar();
    }
    if (!isdefined(self.var_fca62492)) {
        self.var_fca62492 = newclienthudelem(self);
    }
    self thread laststand_clean_up_on_disconnect(e_revivee, w_reviver, w_revive_tool);
    if (!isdefined(self.is_reviving_any)) {
        self.is_reviving_any = 0;
    }
    self.is_reviving_any++;
    self thread laststand_clean_up_reviving_any(e_revivee);
    if (isdefined(self.var_30d551a2)) {
        self.var_30d551a2 hud::updatebar(0.01, 1 / revivetime);
    }
    self.var_fca62492.alignx = "center";
    self.var_fca62492.aligny = "middle";
    self.var_fca62492.horzalign = "center";
    self.var_fca62492.vertalign = "bottom";
    self.var_fca62492.y = -113;
    if (self issplitscreen()) {
        self.var_fca62492.y = -347;
    }
    self.var_fca62492.foreground = 1;
    self.var_fca62492.font = "default";
    self.var_fca62492.fontscale = 1.8;
    self.var_fca62492.alpha = 1;
    self.var_fca62492.color = (1, 1, 1);
    self.var_fca62492.hidewheninmenu = 1;
    if (self namespace_25f8c2ad::function_d3c7ee5c()) {
        self.var_fca62492.color = (0.5, 0.5, 1);
    }
    self.var_fca62492 settext(%ZOMBIE_REVIVING);
    self thread check_for_failed_revive(e_revivee);
    while (self is_reviving(e_revivee, t_secondary)) {
        wait 0.05;
        timer += 0.05;
        if (self laststand::player_is_in_laststand()) {
            break;
        }
        if (isdefined(e_revivee.revivetrigger.auto_revive) && e_revivee.revivetrigger.auto_revive == 1) {
            break;
        }
        if (timer >= revivetime) {
            revived = 1;
            break;
        }
    }
    if (isdefined(self.var_30d551a2)) {
        self.var_30d551a2 hud::destroyelem();
    }
    if (isdefined(self.var_fca62492)) {
        self.var_fca62492 destroy();
    }
    if (isdefined(e_revivee.revivetrigger.auto_revive) && e_revivee.revivetrigger.auto_revive == 1) {
    } else if (!revived) {
        if (isplayer(e_revivee)) {
            e_revivee stoprevive(self);
        }
    }
    e_revivee.revivetrigger sethintstring(%ZOMBIE_BUTTON_TO_REVIVE_PLAYER);
    e_revivee.revivetrigger.beingrevived = 0;
    self notify(#"do_revive_ended_normally");
    self.is_reviving_any--;
    if (!revived) {
        e_revivee thread checkforbleedout(self);
    }
    return revived;
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x63e1c1af, Offset: 0x3cc8
// Size: 0xa0
function checkforbleedout(player) {
    self endon(#"player_revived");
    self endon(#"player_suicide");
    self endon(#"disconnect");
    player endon(#"disconnect");
    if (isdefined(player) && zm_utility::is_classic()) {
        if (!isdefined(player.failed_revives)) {
            player.failed_revives = 0;
        }
        player.failed_revives++;
        player notify(#"player_failed_revive");
    }
}

// Namespace zm_laststand
// Params 2, eflags: 0x0
// Checksum 0x9be30147, Offset: 0x3d70
// Size: 0x304
function auto_revive(reviver, var_358f18e0) {
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger.auto_revive = 1;
        if (self.revivetrigger.beingrevived == 1) {
            while (true) {
                if (!isdefined(self.revivetrigger) || self.revivetrigger.beingrevived == 0) {
                    break;
                }
                util::wait_network_frame();
            }
        }
        if (isdefined(self.revivetrigger)) {
            self.revivetrigger.auto_trigger = 0;
        }
    }
    self reviveplayer();
    self zm_perks::function_78f42790("health_reboot", 1, 0);
    self clientfield::set("zmbLastStand", 0);
    self notify(#"stop_revive_trigger");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    self laststand::function_4a66f284();
    visionset_mgr::deactivate("visionset", "zombie_last_stand", self);
    visionset_mgr::deactivate("visionset", "zombie_death", self);
    self notify(#"clear_red_flashing_overlay");
    self allowjump(1);
    self util::delay(2, "death", &set_ignoreme, 0);
    self.laststand = undefined;
    if (!(isdefined(level.isresetting_grief) && level.isresetting_grief)) {
        if (isplayer(reviver)) {
            reviver.revives++;
            reviver zm_stats::increment_client_stat("revives");
            reviver zm_stats::increment_player_stat("revives");
            self recordplayerrevivezombies(reviver);
            demo::bookmark("zm_player_revived", gettime(), reviver, self);
        }
    }
    self notify(#"player_revived", reviver);
    wait 0.05;
    if (!isdefined(var_358f18e0) || var_358f18e0 == 0) {
        self laststand_enable_player_weapons();
    }
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xba4c687c, Offset: 0x4080
// Size: 0x5c
function remote_revive(reviver) {
    if (!self laststand::player_is_in_laststand()) {
        return;
    }
    self playsound("zmb_character_remote_revived");
    self thread auto_revive(reviver);
}

// Namespace zm_laststand
// Params 2, eflags: 0x0
// Checksum 0xfd0e21ea, Offset: 0x40e8
// Size: 0x32c
function revive_success(reviver, b_track_stats) {
    if (!isdefined(b_track_stats)) {
        b_track_stats = 1;
    }
    if (!isplayer(self)) {
        self notify(#"player_revived", reviver);
        return;
    }
    if (isdefined(b_track_stats) && b_track_stats) {
        demo::bookmark("zm_player_revived", gettime(), reviver, self);
    }
    self notify(#"player_revived", reviver);
    reviver notify(#"player_did_a_revive", self);
    self reviveplayer();
    self zm_perks::function_78f42790("health_reboot", 1, 0);
    if (isdefined(self.var_698f7e["perk_lose"]) && self.var_698f7e["perk_lose"]) {
        self thread namespace_25f8c2ad::function_ac62adf2();
    }
    if (isdefined(b_track_stats) && !(isdefined(level.isresetting_grief) && level.isresetting_grief) && b_track_stats) {
        reviver.revives++;
        reviver zm_stats::increment_client_stat("revives");
        reviver zm_stats::increment_player_stat("revives");
        reviver xp_revive_once_per_round(self);
        self recordplayerrevivezombies(reviver);
        reviver.var_8cc9518d = self.origin;
    }
    if (isdefined(b_track_stats) && zm_utility::is_classic() && b_track_stats) {
        namespace_25f8c2ad::function_9c80877a(reviver);
    }
    if (isdefined(b_track_stats) && b_track_stats) {
        reviver thread check_for_sacrifice();
    }
    if (isdefined(level.var_bb4b8883)) {
    }
    self clientfield::set("zmbLastStand", 0);
    self.revivetrigger delete();
    self.revivetrigger = undefined;
    self laststand::function_4a66f284();
    self util::delay(2, "death", &set_ignoreme, 0);
    visionset_mgr::deactivate("visionset", "zombie_last_stand", self);
    visionset_mgr::deactivate("visionset", "zombie_death", self);
    wait 0.05;
    self laststand_enable_player_weapons();
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x19fe3493, Offset: 0x4420
// Size: 0xae
function xp_revive_once_per_round(player_being_revived) {
    if (!isdefined(self.number_revives_per_round)) {
        self.number_revives_per_round = [];
    }
    if (!isdefined(self.number_revives_per_round[player_being_revived.characterindex])) {
        self.number_revives_per_round[player_being_revived.characterindex] = 0;
    }
    if (self.number_revives_per_round[player_being_revived.characterindex] == 0) {
        scoreevents::processscoreevent("revive_an_ally", self);
    }
    self.number_revives_per_round[player_being_revived.characterindex]++;
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x49cd6b10, Offset: 0x44d8
// Size: 0x74
function set_ignoreme(var_4ccd5cb0) {
    if (!isdefined(self.var_9c12843e)) {
        self.var_9c12843e = 0;
    }
    if (var_4ccd5cb0 != self.var_9c12843e) {
        self.var_9c12843e = var_4ccd5cb0;
        if (var_4ccd5cb0) {
            self zm_utility::function_139befeb();
            return;
        }
        self zm_utility::function_36f941b3();
    }
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xdb33622a, Offset: 0x4558
// Size: 0x8c
function revive_force_revive(reviver) {
    assert(isdefined(self));
    assert(isplayer(self));
    assert(self laststand::player_is_in_laststand());
    self thread revive_success(reviver);
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0xf69ce144, Offset: 0x45f0
// Size: 0x54
function function_590a49b2() {
    println("<dev string:x28>");
    self.var_5ad7ff7e = spawnstruct();
    self.var_5ad7ff7e.var_5aa0f5d3 = level.var_638daea0;
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x4bedec30, Offset: 0x4650
// Size: 0x134
function function_38c5da09() {
    self endon(#"player_revived");
    self endon(#"disconnect");
    println("<dev string:x48>");
    self laststand::function_cd85ffaf(0);
    self clientfield::set("zmbLastStand", 1);
    self.var_5ad7ff7e.var_8b479de8 = level.var_47df2be6;
    self thread laststand::function_5006c91f();
    self thread function_5d050fca();
    while (self.var_5ad7ff7e.var_8b479de8 < 1) {
        self.var_5ad7ff7e.var_8b479de8 += level.var_82457459;
        wait 0.05;
    }
    self auto_revive(self);
    self clientfield::set("zmbLastStand", 0);
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x1c268730, Offset: 0x4790
// Size: 0x84
function function_5d050fca() {
    self endon(#"player_revived");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"damage");
        self.var_5ad7ff7e.var_8b479de8 -= level.var_2ffda0f5;
        if (self.var_5ad7ff7e.var_8b479de8 < 0) {
            self.var_5ad7ff7e.var_8b479de8 = 0;
        }
    }
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x58df4d9c, Offset: 0x4820
// Size: 0x7c
function check_for_sacrifice() {
    self util::delay_notify("sacrifice_denied", 1);
    self endon(#"sacrifice_denied");
    self waittill(#"player_downed");
    self zm_stats::increment_client_stat("sacrifices");
    self zm_stats::increment_player_stat("sacrifices");
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xf0ed170c, Offset: 0x48a8
// Size: 0xa4
function check_for_failed_revive(e_revivee) {
    self endon(#"disconnect");
    e_revivee endon(#"disconnect");
    e_revivee endon(#"player_suicide");
    self notify(#"checking_for_failed_revive");
    self endon(#"checking_for_failed_revive");
    e_revivee endon(#"player_revived");
    e_revivee waittill(#"bled_out");
    self zm_stats::increment_client_stat("failed_revives");
    self zm_stats::increment_player_stat("failed_revives");
}

// Namespace zm_laststand
// Params 0, eflags: 0x0
// Checksum 0x531c95c3, Offset: 0x4958
// Size: 0x94
function add_weighted_down() {
    if (!level.curr_gametype_affects_rank) {
        return;
    }
    weighted_down = 1000;
    if (level.round_number > 0) {
        weighted_down = int(1000 / ceil(level.round_number / 5));
    }
    self addplayerstat("weighted_downs", weighted_down);
}

// Namespace zm_laststand
// Params 3, eflags: 0x0
// Checksum 0x87cf43ba, Offset: 0x49f8
// Size: 0xee
function register_revive_override(func_is_reviving, func_can_revive, b_use_revive_tool) {
    if (!isdefined(func_can_revive)) {
        func_can_revive = undefined;
    }
    if (!isdefined(b_use_revive_tool)) {
        b_use_revive_tool = 0;
    }
    if (!isdefined(self.a_s_revive_overrides)) {
        self.a_s_revive_overrides = [];
    }
    s_revive_override = spawnstruct();
    s_revive_override.func_is_reviving = func_is_reviving;
    if (isdefined(func_can_revive)) {
        s_revive_override.func_can_revive = func_can_revive;
    } else {
        s_revive_override.func_can_revive = func_is_reviving;
    }
    s_revive_override.b_use_revive_tool = b_use_revive_tool;
    self.a_s_revive_overrides[self.a_s_revive_overrides.size] = s_revive_override;
    return s_revive_override;
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x5b6c5064, Offset: 0x4af0
// Size: 0x34
function deregister_revive_override(s_revive_override) {
    if (isdefined(self.a_s_revive_overrides)) {
        arrayremovevalue(self.a_s_revive_overrides, s_revive_override);
    }
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0x68426bae, Offset: 0x4b30
// Size: 0x74
function can_revive_via_override(e_revivee) {
    if (isdefined(self.a_s_revive_overrides)) {
        for (i = 0; i < self.a_s_revive_overrides.size; i++) {
            if (self [[ self.a_s_revive_overrides[i].func_can_revive ]](e_revivee)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_laststand
// Params 1, eflags: 0x0
// Checksum 0xeab66055, Offset: 0x4bb0
// Size: 0x94
function is_reviving_via_override(e_revivee) {
    if (isdefined(self.a_s_revive_overrides)) {
        for (i = 0; i < self.a_s_revive_overrides.size; i++) {
            if (self [[ self.a_s_revive_overrides[i].func_is_reviving ]](e_revivee)) {
                self.s_revive_override_used = self.a_s_revive_overrides[i];
                return true;
            }
        }
    }
    self.s_revive_override_used = undefined;
    return false;
}

