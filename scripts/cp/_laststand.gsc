#using scripts/cp/gametypes/coop;
#using scripts/cp/gametypes/_healthoverlay;
#using scripts/cp/gametypes/_globallogic_spawn;
#using scripts/cp/_skipto;
#using scripts/cp/_bb;
#using scripts/cp/_util;
#using scripts/shared/lui_shared;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace laststand;

// Namespace laststand
// Params 0, eflags: 0x2
// Checksum 0x1688b90, Offset: 0x6b8
// Size: 0x34
function function_2dc19561() {
    system::register("laststand", &__init__, undefined, undefined);
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x7bbf750c, Offset: 0x6f8
// Size: 0x204
function __init__() {
    if (level.script == "frontend") {
        return;
    }
    level.laststand_update_clientfields = [];
    for (i = 0; i < 4; i++) {
        level.laststand_update_clientfields[i] = "laststand_update" + i;
        clientfield::register("world", level.laststand_update_clientfields[i], 1, 5, "counter");
    }
    if (!isdefined(level.var_a6179873)) {
        level.var_a6179873 = &player_laststand;
    }
    level.weaponrevivetool = getweapon("syrette");
    if (!isdefined(level.laststandpistol)) {
        level.laststandpistol = getweapon("noweapon");
    }
    level thread revive_hud_think();
    level.primaryprogressbarx = 0;
    level.primaryprogressbary = 110;
    level.primaryprogressbarheight = 4;
    level.primaryprogressbarwidth = 120;
    level.var_f0aa5b7d = 280;
    if (getdvarstring("revive_trigger_radius") == "") {
        setdvar("revive_trigger_radius", "100");
    }
    level.var_da98bf76 = 0;
    if (isdefined(level.var_be177839)) {
        visionsetlaststand(level.var_be177839);
        return;
    }
    visionsetlaststand("zombie_last_stand");
}

// Namespace laststand
// Params 9, eflags: 0x1 linked
// Checksum 0x90d7b20f, Offset: 0x908
// Size: 0xe4
function player_last_stand_stats(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(attacker) && isplayer(attacker) && attacker != self) {
        attacker.kills++;
        if (isdefined(weapon)) {
            var_a362aff = weapon;
            attacker addweaponstat(var_a362aff, "kills", 1);
        }
    }
    self increment_downed_stat();
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x5e2815bc, Offset: 0x9f8
// Size: 0x11e
function increment_downed_stat() {
    self.downs++;
    self addplayerstat("INCAPS", 1);
    if (isdefined(getrootmapname())) {
        var_e7ce5f85 = self getdstat("PlayerStatsList", "INCAPS", "statValue");
        self setnoncheckpointdata("INCAPS", var_e7ce5f85);
        self.incaps = var_e7ce5f85 - self getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", "INCAPS");
        /#
            assert(self.incaps > 0);
        #/
        self.pers["incaps"] = self.incaps;
    }
}

// Namespace laststand
// Params 0, eflags: 0x5 linked
// Checksum 0x29164f23, Offset: 0xb20
// Size: 0x38
function force_last_stand() {
    /#
        if (getdvarstring("") == "") {
            return true;
        }
    #/
    return false;
}

// Namespace laststand
// Params 9, eflags: 0x1 linked
// Checksum 0x440c5589, Offset: 0xb60
// Size: 0x6a4
function playerlaststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride) {
    if (isdefined(self.var_32218fc7) && self.var_32218fc7) {
        return;
    }
    self notify(#"entering_last_stand");
    if (isdefined(level.var_c7048fc8)) {
        self [[ level.var_c7048fc8 ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride);
    }
    if (self player_is_in_laststand()) {
        return;
    }
    if (level.players.size == 1 && self.lives == 0 && !force_last_stand()) {
        return;
    }
    self closemenu(game["menu_changeclass"]);
    self clientfield::set_to_player("mobile_armory_cac", 0);
    if (!self util::function_31827fe8()) {
        self util::function_ee182f5d();
    }
    self.laststandparams = spawnstruct();
    self.var_afe5253c = spawnstruct();
    self.laststandparams.einflictor = einflictor;
    self.var_afe5253c.var_a21e8eb8 = -1;
    if (isdefined(einflictor)) {
        self.var_afe5253c.var_a21e8eb8 = einflictor getentitynumber();
    }
    self.var_afe5253c.attackernum = -1;
    if (isdefined(attacker)) {
        self.var_afe5253c.attackernum = einflictor getentitynumber();
    }
    self.laststandparams.attacker = attacker;
    self.laststandparams.idamage = idamage;
    self.laststandparams.smeansofdeath = smeansofdeath;
    self.laststandparams.sweapon = weapon;
    self.laststandparams.vdir = vdir;
    self.laststandparams.shitloc = shitloc;
    self.laststandparams.laststandstarttime = gettime();
    self thread player_last_stand_stats(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride);
    bb::function_945c54c5("enter_last_stand", self);
    self recordmapevent(1, gettime(), self.origin, skipto::function_52c50cb8());
    if (isdefined(level.var_a6179873)) {
        [[ level.var_a6179873 ]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride);
    }
    self.health = 1;
    self.laststand = 1;
    self.ignoreme = 1;
    self enableinvulnerability();
    self.meleeattackers = undefined;
    self util::show_hud(0);
    callback::callback(#"hash_6751ab5b");
    if (!(isdefined(self.no_revive_trigger) && self.no_revive_trigger)) {
        self revive_trigger_spawn();
    } else {
        self undolaststand();
    }
    if (!isdefined(level.var_83405e54) || !level.var_83405e54) {
        self thread function_188d6155();
    }
    self laststand_disable_player_weapons();
    if (!isdefined(level.var_83405e54) || !level.var_83405e54) {
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
    if (level.var_da98bf76 && delayoverride != -1) {
        self thread function_38c5da09();
    } else {
        bleedout_time = getdvarfloat("player_lastStandBleedoutTime");
        if (delayoverride != 0) {
            if (delayoverride == -1) {
                delayoverride = 0;
            }
            bleedout_time = delayoverride;
        }
        level clientfield::increment("laststand_update" + self getentitynumber(), 30);
        self thread laststand_bleedout(bleedout_time);
    }
    demo::bookmark("player_downed", gettime(), self);
    self notify(#"player_downed");
    self thread refire_player_downed();
    self thread function_d4eb424f();
    self thread auto_revive_on_notify();
    self thread function_fb3dd978();
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x94689a8a, Offset: 0x1210
// Size: 0x3c
function function_fb3dd978() {
    self endon(#"player_revived");
    self endon(#"disconnect");
    self waittill(#"death");
    self undolaststand();
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x1d5a518f, Offset: 0x1258
// Size: 0x3e
function refire_player_downed() {
    self endon(#"player_revived");
    self endon(#"death");
    self endon(#"disconnect");
    wait(1);
    self notify(#"player_downed");
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x9034c2ec, Offset: 0x12a0
// Size: 0x34
function function_515f3287() {
    self endon(#"weapon_change");
    while (!self attackbuttonpressed()) {
        wait(0.05);
    }
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x4711b1ed, Offset: 0x12e0
// Size: 0x20c
function function_188d6155() {
    self endon(#"bled_out");
    self endon(#"disconnect");
    self endon(#"player_revived");
    while (true) {
        newweapon = self waittill(#"weapon_change");
        /#
            assert(isdefined(self.laststandpistol));
        #/
        /#
            assert(self.laststandpistol != level.weaponnone);
        #/
        if (newweapon == self.laststandpistol) {
            break;
        }
        weaponinventory = self getweaponslist(1);
        self.lastactiveweapon = self getcurrentweapon();
        if (self isthrowinggrenade() || self cybercom::function_1be27df7()) {
            primaryweapons = self getweaponslistprimaries();
            if (isdefined(primaryweapons) && primaryweapons.size > 0) {
                self.lastactiveweapon = primaryweapons[0];
                self switchtoweaponimmediate(self.lastactiveweapon);
            }
        }
        self function_927e3c75(self.lastactiveweapon);
    }
    self function_515f3287();
    self laststand_enable_player_weapons(0);
    self.ignoreme = 0;
    self disableinvulnerability();
    self util::show_hud(1);
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x994ac592, Offset: 0x14f8
// Size: 0x16a
function laststand_disable_player_weapons() {
    weaponinventory = self getweaponslist(1);
    self.lastactiveweapon = self getcurrentweapon();
    if (self isthrowinggrenade() || self cybercom::function_1be27df7()) {
        primaryweapons = self getweaponslistprimaries();
        if (isdefined(primaryweapons) && primaryweapons.size > 0) {
            self.lastactiveweapon = primaryweapons[0];
            self switchtoweaponimmediate(self.lastactiveweapon);
        }
    }
    self function_927e3c75(self.lastactiveweapon);
    self.laststandpistol = undefined;
    if (!isdefined(self.laststandpistol)) {
        self.laststandpistol = level.laststandpistol;
    }
    if (isdefined(self.var_deb71c1e)) {
        self.laststandpistol = self.var_deb71c1e;
    }
    if (isdefined(level.var_f7507137)) {
        [[ level.var_f7507137 ]]();
    }
    self notify(#"weapons_taken_for_last_stand");
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x97ee6c0c, Offset: 0x1670
// Size: 0x170
function laststand_enable_player_weapons(var_24621d3b) {
    if (!isdefined(var_24621d3b)) {
        var_24621d3b = 1;
    }
    if (isdefined(self.laststandpistol)) {
        self takeweapon(self.laststandpistol);
    }
    self setlowready(0);
    self enableweaponcycling();
    if (var_24621d3b) {
        self enableoffhandweapons();
    }
    if (isdefined(self.lastactiveweapon) && self.lastactiveweapon != level.weaponnone && self hasweapon(self.lastactiveweapon)) {
        self switchtoweapon(self.lastactiveweapon);
    } else {
        primaryweapons = self getweaponslistprimaries();
        if (isdefined(primaryweapons) && primaryweapons.size > 0) {
            self switchtoweapon(primaryweapons[0]);
        }
    }
    if (isdefined(level.var_4c76230a)) {
        [[ level.var_4c76230a ]]();
    }
}

// Namespace laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x53493740, Offset: 0x17e8
// Size: 0x104
function laststand_clean_up_on_interrupt(playerbeingrevived, var_3012e872) {
    self endon(#"do_revive_ended_normally");
    revivetrigger = playerbeingrevived.revivetrigger;
    playerbeingrevived util::waittill_any("disconnect", "game_ended", "death");
    if (isdefined(revivetrigger)) {
        revivetrigger delete();
    }
    self function_4a66f284();
    if (isdefined(self.var_30d551a2)) {
        self.var_30d551a2 hud::destroyelem();
    }
    if (isdefined(self.var_fca62492)) {
        self.var_fca62492 destroy();
    }
    self revive_give_back_weapons(var_3012e872);
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x622e8813, Offset: 0x18f8
// Size: 0x68
function laststand_clean_up_reviving_any(playerbeingrevived) {
    self endon(#"do_revive_ended_normally");
    playerbeingrevived util::waittill_any("disconnect", "zombified", "stop_revive_trigger");
    self.is_reviving_any--;
    if (0 > self.is_reviving_any) {
        self.is_reviving_any = 0;
    }
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x854e5097, Offset: 0x1968
// Size: 0xc8
function laststand_give_pistol() {
    /#
        assert(isdefined(self.laststandpistol));
    #/
    /#
        assert(self.laststandpistol != level.weaponnone);
    #/
    self giveweapon(self.laststandpistol);
    self givemaxammo(self.laststandpistol);
    self switchtoweapon(self.laststandpistol);
    if (isdefined(level.var_d33a5232)) {
        [[ level.var_d33a5232 ]]();
    }
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x7d270d12, Offset: 0x1a38
// Size: 0x64
function function_ee6922c8() {
    self.bleedout_time -= 1;
    wait(1);
    while (isdefined(self.revivetrigger) && isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived == 1) {
        wait(0.1);
    }
}

// Namespace laststand
// Params 0, eflags: 0x5 linked
// Checksum 0xdbb93507, Offset: 0x1aa8
// Size: 0x1c6
function function_c690c6b2() {
    players = getplayers();
    if (players.size == 1) {
        if (self.lives == 0) {
            self.bleedout_time = 3;
        }
        return;
    }
    var_6b49ec9d = 0;
    foreach (player in players) {
        if (!(isdefined(player.laststand) && player.laststand) || isalive(player) && player.lives > 0) {
            var_6b49ec9d = 1;
            break;
        }
    }
    if (!var_6b49ec9d) {
        level.var_ee7cb602 = 1;
        foreach (player in players) {
            player.bleedout_time = 3;
        }
    }
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x4e1b4267, Offset: 0x1c78
// Size: 0x98
function laststand_bleedout_damage() {
    self endon(#"player_revived");
    self endon(#"player_suicide");
    self endon(#"disconnect");
    self endon(#"bled_out");
    if (level.players.size == 1) {
        return;
    }
    while (true) {
        amt = self waittill(#"laststand_damage");
        if (!self.ignoreme) {
            self.bleedout_time -= 0.02 * amt;
        }
    }
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x17c3da39, Offset: 0x1d18
// Size: 0x19c
function laststand_bleedout(delay) {
    self endon(#"player_revived");
    self endon(#"player_suicide");
    self endon(#"disconnect");
    self endon(#"death");
    self clientfield::set_to_player("sndHealth", 2);
    self.var_320b6880 = delay;
    self.bleedout_time = delay;
    if (delay != 0 && !force_last_stand()) {
        function_c690c6b2();
    }
    if (isdefined(level.var_ee7cb602) && level.var_ee7cb602) {
        playsoundatposition("evt_death_down", (0, 0, 0));
    }
    self thread laststand_bleedout_damage();
    do {
        function_ee6922c8();
        level clientfield::increment("laststand_update" + self getentitynumber(), self.bleedout_time + 1);
    } while (self.bleedout_time > 0);
    self notify(#"bled_out");
    bb::function_945c54c5("player_bled_out", self);
    util::wait_network_frame();
    self bleed_out();
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x25d88984, Offset: 0x1ec0
// Size: 0x2c
function function_8c0630b5() {
    if (!isdefined(self.laststandparams.attacker)) {
        self.laststandparams.attacker = self;
    }
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xd0cd3520, Offset: 0x1ef8
// Size: 0x224
function bleed_out() {
    if (getdvarint("enable_new_death_cam", 1)) {
        var_6afb4351 = getdvarfloat("bleed_out_screen_fade_speed", 1.5);
        self playlocalsound("chr_health_laststand_bleedout");
        self lui::screen_fade(var_6afb4351, 1, 0, "black", 0);
        wait(var_6afb4351 + 0.2);
    }
    self function_4a66f284();
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
    }
    self.revivetrigger = undefined;
    self clientfield::set_to_player("sndHealth", 0);
    level clientfield::increment("laststand_update" + self getentitynumber(), 1);
    demo::bookmark("player_bledout", gettime(), self, undefined, 1);
    level notify(#"bleed_out", self.characterindex);
    self notify(#"player_bleedout");
    self coop::function_6dc12009();
    self undolaststand();
    self.ignoreme = 0;
    self util::show_hud(1);
    self.uselaststandparams = 1;
    self function_8c0630b5();
    self suicide();
    self thread respawn_player_after_time(15);
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x29e1b9ef, Offset: 0x2128
// Size: 0x9c
function respawn_player_after_time(n_time_seconds) {
    self endon(#"disconnect");
    players = getplayers();
    if (players.size == 1) {
        return;
    }
    self waittill(#"spawned_spectator");
    self endon(#"spawned");
    level endon(#"objective_changed");
    wait(n_time_seconds);
    if (self.sessionstate == "spectator") {
        self thread globallogic_spawn::waitandspawnclient();
    }
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x5a265427, Offset: 0x21d0
// Size: 0x15c
function function_32b4342() {
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

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x9daef907, Offset: 0x2338
// Size: 0x24a
function function_5c3b9a2f() {
    self endon(#"disconnect");
    self endon(#"stop_revive_trigger");
    self endon(#"player_revived");
    self endon(#"bled_out");
    self endon(#"fake_death");
    level endon(#"game_ended");
    level endon(#"stop_suicide_trigger");
    self thread function_9a3e66fc();
    self thread function_a5c40dbc();
    while (self usebuttonpressed()) {
        wait(1);
    }
    if (!isdefined(self.suicideprompt)) {
        return;
    }
    while (true) {
        wait(0.1);
        if (!isdefined(self.suicideprompt)) {
            continue;
        }
        self.suicideprompt settext(%COOP_BUTTON_TO_SUICIDE);
        if (!self is_suiciding()) {
            continue;
        }
        self.var_7602ee2c = self getcurrentweapon();
        self giveweapon(level.var_339f8cb2);
        self switchtoweapon(level.var_339f8cb2);
        duration = self docowardswayanims();
        var_8677f253 = function_51ede748(duration);
        self.laststand = undefined;
        self takeweapon(level.var_339f8cb2);
        if (var_8677f253) {
            self notify(#"player_suicide");
            util::wait_network_frame();
            self bleed_out();
            return;
        }
        self switchtoweapon(self.var_7602ee2c);
        self.var_7602ee2c = undefined;
    }
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xae46b3e2, Offset: 0x2590
// Size: 0x320
function function_51ede748(duration) {
    level endon(#"game_ended");
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
    self.var_292c9541 settext(%COOP_SUICIDING);
    bb::function_945c54c5("last_stand_suicide", self);
    while (self is_suiciding()) {
        wait(0.05);
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
        self.suicideprompt settext(%COOP_BUTTON_TO_SUICIDE);
    }
    return var_5da69e51;
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x68beeda0, Offset: 0x28b8
// Size: 0x6a
function can_suicide() {
    if (!isalive(self)) {
        return false;
    }
    if (!self player_is_in_laststand()) {
        return false;
    }
    if (!isdefined(self.suicideprompt)) {
        return false;
    }
    if (isdefined(level.intermission) && level.intermission) {
        return false;
    }
    return true;
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x8bc5549b, Offset: 0x2930
// Size: 0x3a
function is_suiciding(revivee) {
    return self usebuttonpressed() && can_suicide();
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x92960da2, Offset: 0x2978
// Size: 0x15c
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
        self.revivetrigger.beingrevived = 0;
        self.revivetrigger.createtime = gettime();
    }
    self thread revive_trigger_think();
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x56017297, Offset: 0x2ae0
// Size: 0x304
function revive_trigger_think() {
    self endon(#"disconnect");
    self endon(#"stop_revive_trigger");
    level endon(#"game_ended");
    self endon(#"death");
    while (true) {
        wait(0.1);
        if (!isdefined(self.revivetrigger)) {
            self notify(#"stop_revive_trigger");
        }
        self.revivetrigger sethintstring("");
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i] can_revive(self)) {
                self.revivetrigger setrevivehintstring(%COOP_BUTTON_TO_REVIVE_PLAYER, self.team);
                break;
            }
        }
        for (i = 0; i < players.size; i++) {
            reviver = players[i];
            if (self == reviver || !reviver is_reviving(self)) {
                continue;
            }
            gun = reviver getcurrentweapon();
            /#
                assert(isdefined(gun));
            #/
            if (gun == level.weaponrevivetool) {
                continue;
            }
            reviver giveweapon(level.weaponrevivetool);
            reviver switchtoweapon(level.weaponrevivetool);
            reviver setweaponammostock(level.weaponrevivetool, 1);
            reviver disableweaponfire();
            reviver disableweaponcycling();
            reviver disableusability();
            reviver disableoffhandweapons();
            revive_success = reviver revive_do_revive(self, gun);
            reviver revive_give_back_weapons(gun);
            if (revive_success) {
                self thread revive_success(reviver);
                self function_4a66f284();
                return;
            }
        }
    }
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xde8f2a50, Offset: 0x2df0
// Size: 0x134
function revive_give_back_weapons(gun) {
    self takeweapon(level.weaponrevivetool);
    self enableweaponfire();
    self enableweaponcycling();
    self enableusability();
    self enableoffhandweapons();
    if (self player_is_in_laststand()) {
        return;
    }
    if (self hasweapon(gun)) {
        self switchtoweapon(gun);
        return;
    }
    primaryweapons = self getweaponslistprimaries();
    if (isdefined(primaryweapons) && primaryweapons.size > 0) {
        self switchtoweapon(primaryweapons[0]);
    }
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x5451a421, Offset: 0x2f30
// Size: 0x25e
function can_revive(revivee) {
    if (!isdefined(revivee.revivetrigger)) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self player_is_in_laststand()) {
        return false;
    }
    if (self.team != revivee.team) {
        return false;
    }
    if (isdefined(level.can_revive) && ![[ level.can_revive ]](revivee)) {
        return false;
    }
    if (isdefined(level.var_ae6ced2b) && ![[ level.var_ae6ced2b ]](revivee)) {
        return false;
    }
    ignore_sight_checks = 0;
    ignore_touch_checks = 0;
    if (isdefined(level.revive_trigger_should_ignore_sight_checks)) {
        ignore_sight_checks = [[ level.revive_trigger_should_ignore_sight_checks ]](self);
        if (ignore_sight_checks && isdefined(revivee.revivetrigger.beingrevived) && revivee.revivetrigger.beingrevived == 1) {
            ignore_touch_checks = 1;
        }
    }
    if (!ignore_touch_checks) {
        if (!self istouching(revivee.revivetrigger)) {
            return false;
        }
    }
    if (!ignore_sight_checks) {
        if (!self is_facing(revivee, 0.8)) {
            return false;
        }
        if (!sighttracepassed(self.origin + (0, 0, 50), revivee.origin + (0, 0, 30), 0, undefined)) {
            return false;
        }
        if (!bullettracepassed(self.origin + (0, 0, 50), revivee.origin + (0, 0, 30), 0, undefined)) {
            return false;
        }
    }
    return true;
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x59900967, Offset: 0x3198
// Size: 0x3a
function is_reviving(revivee) {
    return self usebuttonpressed() && can_revive(revivee);
}

// Namespace laststand
// Params 0, eflags: 0x0
// Checksum 0x5fe0804a, Offset: 0x31e0
// Size: 0x16
function is_reviving_any() {
    return isdefined(self.is_reviving_any) && self.is_reviving_any;
}

// Namespace laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x89711ebd, Offset: 0x3200
// Size: 0x638
function revive_do_revive(playerbeingrevived, var_3012e872) {
    /#
        assert(self is_reviving(playerbeingrevived));
    #/
    revivetime = getdvarfloat("g_reviveTime", 3);
    if (self hasperk("specialty_quickrevive")) {
        revivetime /= 2;
    }
    timer = 0;
    revived = 0;
    playerbeingrevived.revivetrigger.beingrevived = 1;
    playerbeingrevived.revive_hud settext(%COOP_PLAYER_IS_REVIVING_YOU, self);
    playerbeingrevived revive_hud_show_n_fade(3);
    playerbeingrevived.revivetrigger sethintstring("");
    if (isplayer(playerbeingrevived)) {
        playerbeingrevived startrevive(self);
    }
    if (0 && !isdefined(self.var_30d551a2)) {
        self.var_30d551a2 = self hud::createprimaryprogressbar();
    }
    if (!isdefined(self.var_fca62492)) {
        self.var_fca62492 = newclienthudelem(self);
    }
    self cybercom::function_f8669cbf(2);
    self thread laststand_clean_up_on_interrupt(playerbeingrevived, var_3012e872);
    if (!isdefined(self.is_reviving_any)) {
        self.is_reviving_any = 0;
    }
    self.is_reviving_any++;
    self thread laststand_clean_up_reviving_any(playerbeingrevived);
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
    self.var_fca62492 settext(%COOP_REVIVING);
    self thread check_for_failed_revive(playerbeingrevived);
    self playlocalsound("chr_revive_start");
    while (self is_reviving(playerbeingrevived)) {
        wait(0.05);
        timer += 0.05;
        if (self player_is_in_laststand()) {
            break;
        }
        if (isdefined(playerbeingrevived.revivetrigger.auto_revive) && playerbeingrevived.revivetrigger.auto_revive == 1) {
            break;
        }
        if (timer >= revivetime) {
            revived = 1;
            if (!isdefined(self.revives) || self.revives <= 10) {
                scoreevents::processscoreevent("player_did_revived", self);
            }
            break;
        }
    }
    self playlocalsound("chr_revive_end");
    if (isdefined(self.var_30d551a2)) {
        self.var_30d551a2 hud::destroyelem();
    }
    if (isdefined(self.var_fca62492)) {
        self.var_fca62492 destroy();
    }
    if (isdefined(playerbeingrevived.revivetrigger.auto_revive) && playerbeingrevived.revivetrigger.auto_revive == 1) {
    } else if (!revived) {
        if (isplayer(playerbeingrevived)) {
            playerbeingrevived stoprevive(self);
        }
    }
    playerbeingrevived.revivetrigger sethintstring(%COOP_BUTTON_TO_REVIVE_PLAYER);
    playerbeingrevived.revivetrigger.beingrevived = 0;
    self notify(#"do_revive_ended_normally");
    self.is_reviving_any--;
    if (!revived) {
        playerbeingrevived thread checkforbleedout(self);
    }
    return revived;
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x7fa89ff8, Offset: 0x3840
// Size: 0x4c
function checkforbleedout(player) {
    self endon(#"player_revived");
    self endon(#"player_suicide");
    self endon(#"disconnect");
    player endon(#"disconnect");
    player notify(#"player_failed_revive");
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xcccb16aa, Offset: 0x3898
// Size: 0x4c
function auto_revive_on_notify() {
    self endon(#"player_revived");
    reviver, var_358f18e0 = self waittill(#"auto_revive");
    auto_revive(reviver, var_358f18e0);
}

// Namespace laststand
// Params 2, eflags: 0x1 linked
// Checksum 0xdf95879e, Offset: 0x38f0
// Size: 0x352
function auto_revive(reviver, var_358f18e0) {
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger.auto_revive = 1;
        if (self.revivetrigger.beingrevived == 1) {
            while (true) {
                if (self.revivetrigger.beingrevived == 0) {
                    break;
                }
                util::wait_network_frame();
            }
        }
        self.revivetrigger.auto_trigger = 0;
    }
    self reviveplayer();
    self clientfield::set_to_player("sndHealth", 0);
    self notify(#"stop_revive_trigger");
    if (isdefined(self.revivetrigger)) {
        self.revivetrigger delete();
        self.revivetrigger = undefined;
    }
    self function_4a66f284();
    if (!isdefined(var_358f18e0) || var_358f18e0 == 0) {
        self laststand_enable_player_weapons();
    }
    self allowjump(1);
    self.ignoreme = 0;
    self disableinvulnerability();
    self.laststand = undefined;
    self util::show_hud(1);
    self lui::screen_close_menu();
    if (!(isdefined(level.isresetting_grief) && level.isresetting_grief)) {
        if (isdefined(reviver)) {
            if (isplayer(reviver) && isdefined(getrootmapname())) {
                reviver addplayerstat("REVIVES", 1);
                var_8642deaf = reviver getdstat("PlayerStatsList", "REVIVES", "statValue");
                reviver setnoncheckpointdata("REVIVES", var_8642deaf);
                reviver.revives = var_8642deaf - reviver getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", "REVIVES");
                /#
                    assert(reviver.revives > 0);
                #/
                reviver.pers["revives"] = reviver.revives;
            }
        }
    }
    self notify(#"player_revived", reviver);
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x7c831957, Offset: 0x3c50
// Size: 0x44
function remote_revive(reviver) {
    if (!self player_is_in_laststand()) {
        return;
    }
    self auto_revive(reviver);
}

// Namespace laststand
// Params 2, eflags: 0x1 linked
// Checksum 0x8b1ab81e, Offset: 0x3ca0
// Size: 0x364
function revive_success(reviver, b_track_stats) {
    if (!isdefined(b_track_stats)) {
        b_track_stats = 1;
    }
    if (!isplayer(self)) {
        self notify(#"player_revived", reviver);
        return;
    }
    if (isdefined(b_track_stats) && b_track_stats) {
        demo::bookmark("player_revived", gettime(), reviver, self);
    }
    if (isplayer(self)) {
        self allowjump(1);
    }
    self.laststand = undefined;
    self notify(#"player_revived", reviver);
    bb::function_945c54c5("player_revived", self);
    self reviveplayer();
    if (isplayer(reviver) && isdefined(getrootmapname())) {
        reviver addplayerstat("REVIVES", 1);
        var_8642deaf = reviver getdstat("PlayerStatsList", "REVIVES", "statValue");
        reviver setnoncheckpointdata("REVIVES", var_8642deaf);
        reviver.revives = var_8642deaf - reviver getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", "REVIVES");
        /#
            assert(reviver.revives > 0);
        #/
        reviver.pers["revives"] = reviver.revives;
    }
    reviver.var_8cc9518d = self.origin;
    if (isdefined(b_track_stats) && b_track_stats) {
        reviver thread check_for_sacrifice();
    }
    if (isdefined(level.var_bb4b8883)) {
    }
    self clientfield::set_to_player("sndHealth", 0);
    self.revivetrigger delete();
    self.revivetrigger = undefined;
    self function_4a66f284();
    self laststand_enable_player_weapons();
    self lui::screen_close_menu();
    self.ignoreme = 0;
    self disableinvulnerability();
    self util::show_hud(1);
}

// Namespace laststand
// Params 1, eflags: 0x0
// Checksum 0xb644743c, Offset: 0x4010
// Size: 0x8c
function revive_force_revive(reviver) {
    /#
        assert(isdefined(self));
    #/
    /#
        assert(isplayer(self));
    #/
    /#
        assert(self player_is_in_laststand());
    #/
    self thread revive_success(reviver);
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x3c63fe80, Offset: 0x40a8
// Size: 0x2ac
function revive_hud_think() {
    level endon(#"game_ended");
    while (true) {
        wait(0.1);
        if (!player_any_player_in_laststand()) {
            continue;
        }
        revived = 0;
        foreach (team in level.teams) {
            playertorevive = undefined;
            foreach (player in level.aliveplayers[team]) {
                if (!isdefined(player.revivetrigger) || !isdefined(player.revivetrigger.createtime)) {
                    continue;
                }
                if (!isdefined(playertorevive) || playertorevive.revivetrigger.createtime > player.revivetrigger.createtime) {
                    playertorevive = player;
                }
            }
            if (isdefined(playertorevive)) {
                foreach (player in level.aliveplayers[team]) {
                    if (player player_is_in_laststand()) {
                        continue;
                    }
                    player thread faderevivemessageover(playertorevive, 3);
                }
                playertorevive.revivetrigger.createtime = undefined;
                revived = 1;
            }
        }
        if (revived) {
            wait(3.5);
        }
    }
}

// Namespace laststand
// Params 2, eflags: 0x1 linked
// Checksum 0xd3ae4c7e, Offset: 0x4360
// Size: 0x90
function faderevivemessageover(playertorevive, time) {
    function_89c586ec();
    self.revive_hud.hidewheninkillcam = 1;
    self.revive_hud settext(%COOP_PLAYER_NEEDS_TO_BE_REVIVED, playertorevive);
    self.revive_hud fadeovertime(time);
    self.revive_hud.alpha = 0;
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x8fd0a96, Offset: 0x43f8
// Size: 0x14c
function function_38c5da09() {
    self endon(#"player_revived");
    self endon(#"disconnect");
    /#
        println("");
    #/
    self function_cd85ffaf(0);
    self clientfield::set_to_player("sndHealth", 2);
    self.var_5ad7ff7e.var_8b479de8 = 0.5;
    self thread function_5006c91f();
    self thread function_5d050fca();
    while (self.var_5ad7ff7e.var_8b479de8 < 1) {
        self.var_5ad7ff7e.var_8b479de8 += 0.0025;
        wait(0.05);
    }
    self auto_revive(self);
    bb::function_945c54c5("last_stand_getup", self);
    self clientfield::set_to_player("sndHealth", 0);
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0x5ffc96a5, Offset: 0x4550
// Size: 0x3c
function check_for_sacrifice() {
    self util::delay_notify("sacrifice_denied", 1);
    self endon(#"sacrifice_denied");
    self waittill(#"player_downed");
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0xf15870c9, Offset: 0x4598
// Size: 0x66
function check_for_failed_revive(playerbeingrevived) {
    self endon(#"disconnect");
    playerbeingrevived endon(#"disconnect");
    playerbeingrevived endon(#"player_suicide");
    self notify(#"checking_for_failed_revive");
    self endon(#"checking_for_failed_revive");
    playerbeingrevived endon(#"player_revived");
    playerbeingrevived waittill(#"bled_out");
}

// Namespace laststand
// Params 0, eflags: 0x0
// Checksum 0x98b22813, Offset: 0x4608
// Size: 0x8c
function add_weighted_down() {
    weighted_down = 1000;
    if (level.round_number > 0) {
        weighted_down = int(1000 / ceil(level.round_number / 5));
    }
    self addplayerstat("weighted_downs", weighted_down);
}

// Namespace laststand
// Params 2, eflags: 0x1 linked
// Checksum 0xdd41c149, Offset: 0x46a0
// Size: 0x34
function function_863079e7(duration, var_343833b4) {
    level endon(var_343833b4);
    self healthoverlay::function_ec5615ca(duration);
}

// Namespace laststand
// Params 1, eflags: 0x1 linked
// Checksum 0x1a2b9b7d, Offset: 0x46e0
// Size: 0x2bc
function wait_and_revive(var_a5aee4b9) {
    if (!isdefined(var_a5aee4b9)) {
        var_a5aee4b9 = 0;
    }
    self endon(#"disconnect");
    self endon(#"death");
    level flag::set("wait_and_revive");
    if (isdefined(self.waiting_to_revive) && self.waiting_to_revive == 1) {
        return;
    }
    self.waiting_to_revive = 1;
    var_2840ac64 = 10;
    bleedout_time = getdvarfloat("player_lastStandBleedoutTime");
    if (bleedout_time <= var_2840ac64) {
        var_2840ac64 = bleedout_time * 0.5;
    }
    if (isdefined(var_a5aee4b9) && var_a5aee4b9) {
        if (level.players.size == 1) {
            self.revive_hud settext(%COOP_REVIVE_EMERGENCY_RESERVE_ONCE);
        } else {
            self.revive_hud settext(%COOP_REVIVE_EMERGENCY_RESERVE);
        }
    }
    self startrevive(self);
    self revive_hud_show_n_fade(var_2840ac64);
    self thread function_863079e7(var_2840ac64, "instant_revive");
    level flag::wait_till_timeout(var_2840ac64, "instant_revive");
    self stoprevive(self);
    self.var_78f63664 = 1;
    self setcontrolleruimodelvalue("hudItems.regenDelayProgress", 1);
    if (level flag::get("instant_revive")) {
        self revive_hud_show_n_fade(1);
    }
    level flag::clear("wait_and_revive");
    self auto_revive(self);
    self.lives--;
    /#
        if (isdefined(self.var_6c733586) && self.var_6c733586) {
            self.lives = level.numlives;
        }
    #/
    self.waiting_to_revive = 0;
}

// Namespace laststand
// Params 0, eflags: 0x1 linked
// Checksum 0xb07d7281, Offset: 0x49a8
// Size: 0x8c
function function_4f798a75() {
    self endon(#"death");
    self endon(#"player_revived");
    for (var_c951fac1 = 1; var_c951fac1; var_c951fac1 = 0) {
        reviver = self waittill(#"remote_revive");
        if (reviver.team == self.team) {
        }
    }
    self remote_revive(reviver);
}

// Namespace laststand
// Params 9, eflags: 0x1 linked
// Checksum 0xa444627f, Offset: 0x4a40
// Size: 0x12c
function player_laststand(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    var_54d1a8f4 = 0;
    self allowjump(0);
    currweapon = self getcurrentweapon();
    statweapon = currweapon;
    if (isdefined(self.lives) && self.lives > 0) {
        self thread wait_and_revive(self function_76f34311("cybercom_emergencyreserve") != 0);
    }
    self thread function_4f798a75();
    self disableoffhandweapons();
}

