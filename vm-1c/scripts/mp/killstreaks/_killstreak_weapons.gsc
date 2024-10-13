#using scripts/mp/killstreaks/_supplydrop;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace killstreak_weapons;

// Namespace killstreak_weapons
// Params 0, eflags: 0x0
// Checksum 0xe0f85950, Offset: 0x570
// Size: 0x284
function init() {
    killstreaks::register("minigun", "minigun", "killstreak_minigun", "minigun_used", &usecarriedkillstreakweapon, 0, 1, "MINIGUN_USED");
    killstreaks::function_f79fd1e9("minigun", %KILLSTREAK_EARNED_MINIGUN, %KILLSTREAK_MINIGUN_NOT_AVAILABLE, %KILLSTREAK_MINIGUN_INBOUND, undefined, %KILLSTREAK_MINIGUN_HACKED);
    killstreaks::register_dialog("minigun", "mpl_killstreak_minigun", "kls_death_used", "", "kls_death_enemy", "", "kls_death_ready");
    killstreaks::register("m32", "m32", "killstreak_m32", "m32_used", &usecarriedkillstreakweapon, 0, 1, "M32_USED");
    killstreaks::function_f79fd1e9("m32", %KILLSTREAK_EARNED_M32, %KILLSTREAK_M32_NOT_AVAILABLE, %KILLSTREAK_M32_INBOUND, undefined, %KILLSTREAK_M32_HACKED);
    killstreaks::register_dialog("m32", "mpl_killstreak_m32", "kls_mgl_used", "", "kls_mgl_enemy", "", "kls_mgl_ready");
    killstreaks::override_entity_camera_in_demo("m32", 1);
    level.killstreakicons["killstreak_minigun"] = "hud_ks_minigun";
    level.killstreakicons["killstreak_m32"] = "hud_ks_m32";
    level.killstreakicons["killstreak_m202_flash"] = "hud_ks_m202";
    level.killstreakicons["killstreak_m220_tow_drop"] = "hud_ks_tv_guided_marker";
    level.killstreakicons["killstreak_m220_tow"] = "hud_ks_tv_guided_missile";
    callback::on_spawned(&on_player_spawned);
    setdvar("scr_HeldKillstreak_Penalty", 0);
}

// Namespace killstreak_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x9781c0d5, Offset: 0x800
// Size: 0x8c
function on_player_spawned() {
    self endon(#"disconnect");
    self.firedkillstreakweapon = 0;
    self.usingkillstreakheldweapon = undefined;
    if (!util::isfirstround() && !util::isoneround()) {
        if (level.roundstartkillstreakdelay > globallogic_utils::gettimepassed() / 1000) {
            self thread watchkillstreakweapondelay();
        }
    }
}

// Namespace killstreak_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0xb827ebb8, Offset: 0x898
// Size: 0x1a0
function watchkillstreakweapondelay() {
    self endon(#"disconnect");
    self endon(#"death");
    while (true) {
        currentweapon = self getcurrentweapon();
        newweapon = self waittill(#"weapon_change");
        if (level.roundstartkillstreakdelay < globallogic_utils::gettimepassed() / 1000) {
            return;
        }
        if (!killstreaks::is_killstreak_weapon(newweapon)) {
            wait 0.5;
            continue;
        }
        killstreak = killstreaks::get_killstreak_for_weapon(newweapon);
        if (killstreaks::is_delayable_killstreak(killstreak) && newweapon.iscarriedkillstreak) {
            timeleft = int(level.roundstartkillstreakdelay - globallogic_utils::gettimepassed() / 1000);
            if (!timeleft) {
                timeleft = 1;
            }
            self iprintlnbold(%MP_UNAVAILABLE_FOR_N, " " + timeleft + " ", %EXE_SECONDS);
            self switchtoweapon(currentweapon);
            wait 0.5;
        }
    }
}

// Namespace killstreak_weapons
// Params 1, eflags: 0x0
// Checksum 0xdc2e927d, Offset: 0xa40
// Size: 0x7c
function usekillstreakweapondrop(hardpointtype) {
    if (self supplydrop::issupplydropgrenadeallowed(hardpointtype) == 0) {
        return 0;
    }
    result = self supplydrop::usesupplydropmarker();
    self notify(#"supply_drop_marker_done");
    if (!isdefined(result) || !result) {
        return 0;
    }
    return result;
}

// Namespace killstreak_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x910925fc, Offset: 0xac8
// Size: 0x6ba
function usecarriedkillstreakweapon(hardpointtype) {
    if (!isdefined(hardpointtype)) {
        return false;
    }
    if (self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0) {
        self switchtoweapon(self.lastdroppableweapon);
        return false;
    }
    currentweapon = self getcurrentweapon();
    killstreakweapon = killstreaks::get_killstreak_weapon(hardpointtype);
    if (killstreakweapon == level.weaponnone) {
        return false;
    }
    level weapons::add_limited_weapon(killstreakweapon, self, 3);
    if (issubstr(killstreakweapon.name, "inventory")) {
        isfrominventory = 1;
    } else {
        isfrominventory = 0;
    }
    currentammo = self getammocount(killstreakweapon);
    if ((hardpointtype == "m32" || hardpointtype == "inventory_m32") && ((hardpointtype == "minigun" || hardpointtype == "inventory_minigun") && !(isdefined(self.minigunstart) && self.minigunstart) || !(isdefined(self.m32start) && self.m32start))) {
        if (hardpointtype == "minigun" || hardpointtype == "inventory_minigun") {
            self.minigunstart = 1;
        } else {
            self.m32start = 1;
        }
        self killstreaks::play_killstreak_start_dialog(hardpointtype, self.team, 1);
        self addweaponstat(killstreakweapon, "used", 1);
        level thread popups::displayteammessagetoall(level.killstreaks[hardpointtype].inboundtext, self);
        self.pers["held_killstreak_clip_count"][killstreakweapon] = killstreakweapon.clipsize > currentammo ? currentammo : killstreakweapon.clipsize;
        if (isfrominventory == 0) {
            if (self.pers["killstreak_quantity"][killstreakweapon] > 0) {
                ammopool = killstreakweapon.maxammo;
            } else {
                ammopool = self.pers["held_killstreak_ammo_count"][killstreakweapon];
            }
            self setweaponammoclip(killstreakweapon, self.pers["held_killstreak_clip_count"][killstreakweapon]);
            self setweaponammostock(killstreakweapon, ammopool - self.pers["held_killstreak_clip_count"][killstreakweapon]);
        }
    }
    if (hardpointtype == "minigun" || hardpointtype == "inventory_minigun") {
        if (!(isdefined(self.minigunactive) && self.minigunactive)) {
            killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team, 0, 0);
            if (hardpointtype == "inventory_minigun") {
                killstreak_id = self.pers["killstreak_unique_id"][self.pers["killstreak_unique_id"].size - 1];
            }
            self.minigunid = killstreak_id;
            self.minigunactive = 1;
        } else {
            killstreak_id = self.minigunid;
        }
    } else if (!(isdefined(self.m32active) && self.m32active)) {
        killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team, 0, 0);
        if (hardpointtype == "inventory_m32") {
            killstreak_id = self.pers["killstreak_unique_id"][self.pers["killstreak_unique_id"].size - 1];
        }
        self.m32id = killstreak_id;
        self.m32active = 1;
    } else {
        killstreak_id = self.m32id;
    }
    assert(killstreak_id != -1);
    self.firedkillstreakweapon = 0;
    self setblockweaponpickup(killstreakweapon, 1);
    if (isfrominventory) {
        self setweaponammoclip(killstreakweapon, self.pers["held_killstreak_clip_count"][killstreakweapon]);
        self setweaponammostock(killstreakweapon, self.pers["killstreak_ammo_count"][self.pers["killstreak_ammo_count"].size - 1] - self.pers["held_killstreak_clip_count"][killstreakweapon]);
    }
    notifystring = "killstreakWeapon_" + killstreakweapon.name;
    self notify(notifystring);
    self thread watchkillstreakweaponswitch(killstreakweapon, killstreak_id, isfrominventory);
    self thread watchkillstreakweapondeath(killstreakweapon, killstreak_id, isfrominventory);
    self thread watchkillstreakroundchange(isfrominventory, killstreak_id);
    self thread watchplayerdeath(killstreakweapon);
    if (isfrominventory) {
        self thread watchkillstreakremoval(hardpointtype, killstreak_id);
    }
    self.usingkillstreakheldweapon = 1;
    return false;
}

// Namespace killstreak_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x83a49612, Offset: 0x1190
// Size: 0x194
function usekillstreakweaponfromcrate(hardpointtype) {
    if (!isdefined(hardpointtype)) {
        return false;
    }
    killstreakweapon = killstreaks::get_killstreak_weapon(hardpointtype);
    if (killstreakweapon == level.weaponnone) {
        return false;
    }
    self.firedkillstreakweapon = 0;
    self setblockweaponpickup(killstreakweapon, 1);
    killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team, 0, 0);
    assert(killstreak_id != -1);
    if (issubstr(killstreakweapon.name, "inventory")) {
        isfrominventory = 1;
    } else {
        isfrominventory = 0;
    }
    self thread watchkillstreakweaponswitch(killstreakweapon, killstreak_id, isfrominventory);
    self thread watchkillstreakweapondeath(killstreakweapon, killstreak_id, isfrominventory);
    if (isfrominventory) {
        self thread watchkillstreakremoval(hardpointtype, killstreak_id);
    }
    self.usingkillstreakheldweapon = 1;
    return true;
}

// Namespace killstreak_weapons
// Params 3, eflags: 0x1 linked
// Checksum 0x98ba25e4, Offset: 0x1330
// Size: 0x4a4
function watchkillstreakweaponswitch(killstreakweapon, killstreak_id, isfrominventory) {
    self endon(#"disconnect");
    self endon(#"death");
    noneweapon = getweapon("none");
    minigunweapon = getweapon("minigun");
    miniguninventoryweapon = getweapon("inventory_minigun");
    while (true) {
        currentweapon = self getcurrentweapon();
        newweapon = self waittill(#"weapon_change");
        if (level.infinalkillcam) {
            continue;
        }
        if (newweapon == noneweapon) {
            continue;
        }
        currentammo = self getammocount(killstreakweapon);
        currentammoinclip = self getweaponammoclip(killstreakweapon);
        if (isfrominventory && currentammo > 0) {
            killstreakindex = self killstreaks::get_killstreak_index_by_id(killstreak_id);
            if (isdefined(killstreakindex)) {
                self.pers["killstreak_ammo_count"][killstreakindex] = currentammo;
                self.pers["held_killstreak_clip_count"][killstreakweapon] = currentammoinclip;
            }
        }
        if (killstreaks::is_killstreak_weapon(newweapon) && !newweapon.iscarriedkillstreak) {
            continue;
        }
        if (newweapon.isgameplayweapon) {
            continue;
        }
        if (newweapon == self.lastnonkillstreakweapon && newweapon.iscarriedkillstreak) {
            continue;
        }
        killstreakid = killstreaks::get_top_killstreak_unique_id();
        self.pers["held_killstreak_ammo_count"][killstreakweapon] = currentammo;
        self.pers["held_killstreak_clip_count"][killstreakweapon] = currentammoinclip;
        if (killstreak_id != -1) {
            self notify(#"killstreak_weapon_switch");
        }
        self.firedkillstreakweapon = 0;
        self.usingkillstreakheldweapon = undefined;
        waittillframeend();
        if (isfrominventory && isdefined(killstreakid) && (currentammo == 0 || self.pers["killstreak_quantity"][killstreakweapon] > 0 || killstreakid != killstreak_id)) {
            killstreakrules::killstreakstop(killstreaks::get_killstreak_for_weapon(killstreakweapon), self.team, killstreak_id);
            if (killstreakweapon == miniguninventoryweapon || killstreakweapon == minigunweapon) {
                self.minigunstart = 0;
                self.minigunactive = 0;
            } else {
                self.m32start = 0;
                self.m32active = 0;
            }
            if (self.pers["killstreak_quantity"][killstreakweapon] > 0) {
                self.pers["held_killstreak_ammo_count"][killstreakweapon] = killstreakweapon.maxammo;
                self loadout::function_8de272c8(killstreakweapon, self.pers["held_killstreak_ammo_count"][killstreakweapon]);
                self.pers["killstreak_quantity"][killstreakweapon]--;
            }
        }
        if (isfrominventory && currentammo == 0) {
            self takeweapon(killstreakweapon);
            self killstreaks::remove_used_killstreak(killstreaks::get_killstreak_for_weapon(killstreakweapon), killstreak_id);
            self killstreaks::activate_next();
        }
        break;
    }
}

// Namespace killstreak_weapons
// Params 3, eflags: 0x1 linked
// Checksum 0xcd1ae03c, Offset: 0x17e0
// Size: 0x4fc
function watchkillstreakweapondeath(killstreakweapon, killstreak_id, isfrominventory) {
    self endon(#"disconnect");
    self endon(#"killstreak_weapon_switch");
    if (killstreak_id == -1) {
        return;
    }
    oldteam = self.team;
    self waittill(#"death");
    penalty = getdvarfloat("scr_HeldKillstreak_Penalty", 0.5);
    maxammo = killstreakweapon.maxammo;
    currentammo = self getammocount(killstreakweapon);
    currentammoinclip = self getweaponammoclip(killstreakweapon);
    if (self.pers["killstreak_quantity"].size == 0) {
        currentammo = 0;
        currentammoinclip = 0;
    }
    maxclipsize = killstreakweapon.clipsize;
    newammo = int(currentammo - maxammo * penalty);
    killstreakid = killstreaks::get_top_killstreak_unique_id();
    if (self.lastnonkillstreakweapon == killstreakweapon) {
        if (newammo < 0) {
            self.pers["held_killstreak_ammo_count"][killstreakweapon] = 0;
            self.pers["held_killstreak_clip_count"][killstreakweapon] = 0;
        } else {
            self.pers["held_killstreak_ammo_count"][killstreakweapon] = newammo;
            self.pers["held_killstreak_clip_count"][killstreakweapon] = maxclipsize <= newammo ? maxclipsize : newammo;
        }
    }
    self.usingkillstreakheldweapon = 0;
    killstreaktype = killstreaks::get_killstreak_for_weapon(killstreakweapon);
    if (isfrominventory && isdefined(killstreakid) && (newammo <= 0 || self.pers["killstreak_quantity"][killstreakweapon] > 0 || killstreakid != killstreak_id)) {
        killstreakrules::killstreakstop(killstreaktype, oldteam, killstreak_id);
        if (killstreaktype == "minigun" || killstreaktype == "inventory_minigun") {
            self.minigunstart = 0;
            self.minigunactive = 0;
        } else {
            self.m32start = 0;
            self.m32active = 0;
        }
        if (isdefined(self.pers["killstreak_quantity"][killstreakweapon]) && self.pers["killstreak_quantity"][killstreakweapon] > 0) {
            self.pers["held_killstreak_ammo_count"][killstreakweapon] = maxammo;
            self.pers["held_killstreak_clip_count"][killstreakweapon] = maxclipsize;
            self setweaponammoclip(killstreakweapon, self.pers["held_killstreak_clip_count"][killstreakweapon]);
            self setweaponammostock(killstreakweapon, self.pers["held_killstreak_ammo_count"][killstreakweapon] - self.pers["held_killstreak_clip_count"][killstreakweapon]);
            self.pers["killstreak_quantity"][killstreakweapon]--;
        }
    }
    if (isfrominventory && newammo <= 0) {
        self takeweapon(killstreakweapon);
        self killstreaks::remove_used_killstreak(killstreaktype, killstreak_id);
        self killstreaks::activate_next();
        return;
    }
    if (isfrominventory) {
        killstreakindex = self killstreaks::get_killstreak_index_by_id(killstreak_id);
        if (isdefined(killstreakindex)) {
            self.pers["killstreak_ammo_count"][killstreakindex] = self.pers["held_killstreak_ammo_count"][killstreakweapon];
        }
    }
}

// Namespace killstreak_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x6ba2f7a2, Offset: 0x1ce8
// Size: 0xc0
function watchplayerdeath(killstreakweapon) {
    self endon(#"disconnect");
    endonweaponstring = "killstreakWeapon_" + killstreakweapon.name;
    self endon(endonweaponstring);
    self waittill(#"death");
    currentammo = self getammocount(killstreakweapon);
    self.pers["held_killstreak_clip_count"][killstreakweapon] = killstreakweapon.clipsize <= currentammo ? killstreakweapon.clipsize : currentammo;
}

// Namespace killstreak_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0xaaa4ffda, Offset: 0x1db0
// Size: 0xe8
function watchkillstreakremoval(killstreaktype, killstreak_id) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killstreak_weapon_switch");
    removedkillstreaktype, removed_id = self waittill(#"oldest_killstreak_removed");
    if (killstreaktype == removedkillstreaktype && killstreak_id == removed_id) {
        removedkillstreakweapon = killstreaks::get_killstreak_weapon(removedkillstreaktype);
        if (removedkillstreakweapon.name == "inventory_minigun") {
            self.minigunstart = 0;
            self.minigunactive = 0;
            return;
        }
        self.m32start = 0;
        self.m32active = 0;
    }
}

// Namespace killstreak_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0xd356f5a9, Offset: 0x1ea0
// Size: 0x1a8
function watchkillstreakroundchange(isfrominventory, killstreak_id) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killstreak_weapon_switch");
    self waittill(#"round_ended");
    currentweapon = self getcurrentweapon();
    if (!currentweapon.iscarriedkillstreak) {
        return;
    }
    currentammo = self getammocount(currentweapon);
    maxclipsize = currentweapon.clipsize;
    if (isfrominventory && currentammo > 0) {
        killstreakindex = self killstreaks::get_killstreak_index_by_id(killstreak_id);
        if (isdefined(killstreakindex)) {
            self.pers["killstreak_ammo_count"][killstreakindex] = currentammo;
            self.pers["held_killstreak_clip_count"][currentweapon] = maxclipsize <= currentammo ? maxclipsize : currentammo;
        }
        return;
    }
    self.pers["held_killstreak_ammo_count"][currentweapon] = currentammo;
    self.pers["held_killstreak_clip_count"][currentweapon] = maxclipsize <= currentammo ? maxclipsize : currentammo;
}

// Namespace killstreak_weapons
// Params 4, eflags: 0x0
// Checksum 0x9940a900, Offset: 0x2050
// Size: 0x236
function checkifswitchableweapon(currentweapon, newweapon, killstreakweapon, currentkillstreakid) {
    switchableweapon = 1;
    topkillstreak = killstreaks::get_top_killstreak();
    killstreakid = killstreaks::get_top_killstreak_unique_id();
    if (!isdefined(killstreakid)) {
        killstreakid = -1;
    }
    if (self hasweapon(killstreakweapon) && !self getammocount(killstreakweapon)) {
        switchableweapon = 1;
    } else if (self.firedkillstreakweapon && newweapon == killstreakweapon && currentweapon.iscarriedkillstreak) {
        switchableweapon = 1;
    } else if (newweapon.isequipment) {
        switchableweapon = 1;
    } else if (isdefined(level.grenade_array[newweapon])) {
        switchableweapon = 0;
    } else if (!isdefined(currentkillstreakid) || newweapon.iscarriedkillstreak && currentweapon.iscarriedkillstreak && currentkillstreakid != killstreakid) {
        switchableweapon = 1;
    } else if (killstreaks::is_killstreak_weapon(newweapon)) {
        switchableweapon = 0;
    } else if (newweapon.isgameplayweapon) {
        switchableweapon = 0;
    } else if (self.firedkillstreakweapon) {
        switchableweapon = 1;
    } else if (self.lastnonkillstreakweapon == killstreakweapon) {
        switchableweapon = 0;
    } else if (isdefined(topkillstreak) && topkillstreak == killstreakweapon && currentkillstreakid == killstreakid) {
        switchableweapon = 0;
    }
    return switchableweapon;
}

