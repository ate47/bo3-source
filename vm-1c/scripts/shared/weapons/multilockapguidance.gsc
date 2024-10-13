#using scripts/shared/abilities/_ability_util;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace multilockap_guidance;

// Namespace multilockap_guidance
// Params 0, eflags: 0x2
// Checksum 0xca70156d, Offset: 0x230
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("multilockap_guidance", &__init__, undefined, undefined);
}

// Namespace multilockap_guidance
// Params 0, eflags: 0x1 linked
// Checksum 0x2a44aba0, Offset: 0x270
// Size: 0x44
function __init__() {
    callback::on_spawned(&on_player_spawned);
    setdvar("scr_max_simLocks", 3);
}

// Namespace multilockap_guidance
// Params 0, eflags: 0x1 linked
// Checksum 0xaa6f7ebe, Offset: 0x2c0
// Size: 0x4c
function on_player_spawned() {
    self endon(#"disconnect");
    self clearaptarget();
    thread aptoggleloop();
    self thread function_c0677ebd();
}

// Namespace multilockap_guidance
// Params 2, eflags: 0x1 linked
// Checksum 0xbab8300c, Offset: 0x318
// Size: 0x27c
function clearaptarget(weapon, whom) {
    if (!isdefined(self.multilocklist)) {
        self.multilocklist = [];
    }
    if (isdefined(whom)) {
        for (i = 0; i < self.multilocklist.size; i++) {
            if (whom.aptarget == self.multilocklist[i].aptarget) {
                if (isdefined(self.multilocklist[i].aptarget)) {
                    self.multilocklist[i].aptarget notify(#"missile_unlocked");
                }
                self notify("stop_sound" + whom.apsoundid);
                self weaponlockremoveslot(i);
                arrayremovevalue(self.multilocklist, whom, 0);
                break;
            }
        }
    } else {
        for (i = 0; i < self.multilocklist.size; i++) {
            self.multilocklist[i].aptarget notify(#"missile_unlocked");
            self notify("stop_sound" + self.multilocklist[i].apsoundid);
        }
        self.multilocklist = [];
    }
    if (self.multilocklist.size == 0) {
        self stoprumble("stinger_lock_rumble");
        self weaponlockremoveslot(-1);
        if (isdefined(weapon)) {
            if (isdefined(weapon.lockonseekersearchsound)) {
                self stoplocalsound(weapon.lockonseekersearchsound);
            }
            if (isdefined(weapon.lockonseekerlockedsound)) {
                self stoplocalsound(weapon.lockonseekerlockedsound);
            }
        }
        self destroylockoncanceledmessage();
    }
}

// Namespace multilockap_guidance
// Params 0, eflags: 0x1 linked
// Checksum 0x5071d4fb, Offset: 0x5a0
// Size: 0x11e
function function_c0677ebd() {
    self endon(#"disconnect");
    self endon(#"death");
    while (true) {
        missile, weapon = self waittill(#"missile_fire");
        if (weapon.lockontype == "AP Multi") {
            foreach (target in self.multilocklist) {
                if (isdefined(target.aptarget) && target.aplockfinalized) {
                    target.aptarget notify(#"stinger_fired_at_me", missile, weapon, self);
                }
            }
        }
    }
}

// Namespace multilockap_guidance
// Params 0, eflags: 0x1 linked
// Checksum 0xd5937d3, Offset: 0x6c8
// Size: 0x178
function aptoggleloop() {
    self endon(#"disconnect");
    self endon(#"death");
    for (;;) {
        weapon = self waittill(#"weapon_change");
        while (weapon.lockontype == "AP Multi") {
            abort = 0;
            while (!(self playerads() == 1)) {
                wait 0.05;
                currentweapon = self getcurrentweapon();
                if (currentweapon.lockontype != "AP Multi") {
                    abort = 1;
                    break;
                }
            }
            if (abort) {
                break;
            }
            self thread aplockloop(weapon);
            while (self playerads() == 1) {
                wait 0.05;
            }
            self notify(#"ap_off");
            self clearaptarget(weapon);
            weapon = self getcurrentweapon();
        }
    }
}

// Namespace multilockap_guidance
// Params 1, eflags: 0x1 linked
// Checksum 0x293136a1, Offset: 0x848
// Size: 0x5b6
function aplockloop(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"ap_off");
    locklength = self getlockonspeed();
    self.multilocklist = [];
    for (;;) {
        wait 0.05;
        do {
            done = 1;
            foreach (target in self.multilocklist) {
                if (target.aplockfinalized) {
                    if (!isstillvalidtarget(weapon, target.aptarget)) {
                        self clearaptarget(weapon, target);
                        done = 0;
                        break;
                    }
                }
            }
        } while (!done);
        inlockingstate = 0;
        do {
            done = 1;
            for (i = 0; i < self.multilocklist.size; i++) {
                target = self.multilocklist[i];
                if (target.aplocking) {
                    if (!isstillvalidtarget(weapon, target.aptarget)) {
                        self clearaptarget(weapon, target);
                        done = 0;
                        break;
                    }
                    inlockingstate = 1;
                    timepassed = gettime() - target.aplockstarttime;
                    if (timepassed < locklength) {
                        continue;
                    }
                    assert(isdefined(target.aptarget));
                    target.aplockfinalized = 1;
                    target.aplocking = 0;
                    target.aplockpending = 0;
                    self weaponlockfinalize(target.aptarget, i);
                    self thread seekersound(weapon.lockonseekerlockedsound, weapon.lockonseekerlockedsoundloops, target.apsoundid);
                    target.aptarget notify(#"missile_lock", self, weapon);
                }
            }
        } while (!done);
        if (!inlockingstate) {
            do {
                done = 1;
                for (i = 0; i < self.multilocklist.size; i++) {
                    target = self.multilocklist[i];
                    if (target.aplockpending) {
                        if (!isstillvalidtarget(weapon, target.aptarget)) {
                            self clearaptarget(weapon, target);
                            done = 0;
                            break;
                        }
                        target.aplockstarttime = gettime();
                        target.aplockfinalized = 0;
                        target.aplockpending = 0;
                        target.aplocking = 1;
                        self thread seekersound(weapon.lockonseekersearchsound, weapon.lockonseekersearchsoundloops, target.apsoundid);
                        done = 1;
                        break;
                    }
                }
            } while (!done);
        }
        if (self.multilocklist.size >= getdvarint("scr_max_simLocks") || self.multilocklist.size >= self getweaponammoclip(weapon)) {
            continue;
        }
        besttarget = self getbesttarget(weapon);
        if (!isdefined(besttarget) && self.multilocklist.size == 0) {
            self destroylockoncanceledmessage();
            continue;
        }
        if (isdefined(besttarget) && self.multilocklist.size < getdvarint("scr_max_simLocks") && self.multilocklist.size < self getweaponammoclip(weapon)) {
            self weaponlockstart(besttarget.aptarget, self.multilocklist.size);
            self.multilocklist[self.multilocklist.size] = besttarget;
        }
    }
}

// Namespace multilockap_guidance
// Params 0, eflags: 0x1 linked
// Checksum 0x73d61fbc, Offset: 0xe08
// Size: 0x2c
function destroylockoncanceledmessage() {
    if (isdefined(self.lockoncanceledmessage)) {
        self.lockoncanceledmessage destroy();
    }
}

// Namespace multilockap_guidance
// Params 0, eflags: 0x0
// Checksum 0x61279067, Offset: 0xe40
// Size: 0x154
function displaylockoncanceledmessage() {
    if (isdefined(self.lockoncanceledmessage)) {
        return;
    }
    self.lockoncanceledmessage = newclienthudelem(self);
    self.lockoncanceledmessage.fontscale = 1.25;
    self.lockoncanceledmessage.x = 0;
    self.lockoncanceledmessage.y = 50;
    self.lockoncanceledmessage.alignx = "center";
    self.lockoncanceledmessage.aligny = "top";
    self.lockoncanceledmessage.horzalign = "center";
    self.lockoncanceledmessage.vertalign = "top";
    self.lockoncanceledmessage.foreground = 1;
    self.lockoncanceledmessage.hidewhendead = 0;
    self.lockoncanceledmessage.hidewheninmenu = 1;
    self.lockoncanceledmessage.archived = 0;
    self.lockoncanceledmessage.alpha = 1;
    self.lockoncanceledmessage settext(%MP_CANNOT_LOCKON_TO_TARGET);
}

// Namespace multilockap_guidance
// Params 1, eflags: 0x1 linked
// Checksum 0xaf268941, Offset: 0xfa0
// Size: 0x53e
function getbesttarget(weapon) {
    playertargets = getplayers();
    vehicletargets = target_getarray();
    targetsall = getaiteamarray();
    targetsall = arraycombine(targetsall, playertargets, 0, 0);
    targetsall = arraycombine(targetsall, vehicletargets, 0, 0);
    targetsvalid = [];
    for (idx = 0; idx < targetsall.size; idx++) {
        if (level.teambased) {
            if (isdefined(targetsall[idx].team) && targetsall[idx].team != self.team) {
                if (self insideapreticlenolock(targetsall[idx])) {
                    if (self locksighttest(targetsall[idx])) {
                        targetsvalid[targetsvalid.size] = targetsall[idx];
                    }
                }
            }
            continue;
        }
        if (self insideapreticlenolock(targetsall[idx])) {
            if (isdefined(targetsall[idx].owner) && self != targetsall[idx].owner) {
                if (self locksighttest(targetsall[idx])) {
                    targetsvalid[targetsvalid.size] = targetsall[idx];
                }
            }
        }
    }
    if (targetsvalid.size == 0) {
        return undefined;
    }
    playerforward = anglestoforward(self getplayerangles());
    dots = [];
    for (i = 0; i < targetsvalid.size; i++) {
        newitem = spawnstruct();
        newitem.index = i;
        newitem.dot = vectordot(playerforward, vectornormalize(targetsvalid[i].origin - self.origin));
        array::function_5fee9333(dots, &targetinsertionsortcompare, newitem);
    }
    index = 0;
    foreach (dot in dots) {
        found = 0;
        foreach (lock in self.multilocklist) {
            if (lock.aptarget == targetsvalid[dot.index]) {
                found = 1;
            }
        }
        if (found) {
            continue;
        }
        newentry = spawnstruct();
        newentry.aptarget = targetsvalid[dot.index];
        newentry.aplockstarttime = gettime();
        newentry.aplockpending = 1;
        newentry.aplocking = 0;
        newentry.aplockfinalized = 0;
        newentry.aplostsightlinetime = 0;
        newentry.apsoundid = randomint(2147483647);
        return newentry;
    }
    return undefined;
}

// Namespace multilockap_guidance
// Params 2, eflags: 0x1 linked
// Checksum 0xe4a4b175, Offset: 0x14e8
// Size: 0x60
function targetinsertionsortcompare(a, b) {
    if (a.dot < b.dot) {
        return -1;
    }
    if (a.dot > b.dot) {
        return 1;
    }
    return 0;
}

// Namespace multilockap_guidance
// Params 1, eflags: 0x1 linked
// Checksum 0x5b2ad39b, Offset: 0x1550
// Size: 0x52
function insideapreticlenolock(target) {
    radius = self getlockonradius();
    return target_isincircle(target, self, 65, radius);
}

// Namespace multilockap_guidance
// Params 1, eflags: 0x1 linked
// Checksum 0xaec77aba, Offset: 0x15b0
// Size: 0x52
function insideapreticlelocked(target) {
    radius = self getlockonlossradius();
    return target_isincircle(target, self, 65, radius);
}

// Namespace multilockap_guidance
// Params 2, eflags: 0x1 linked
// Checksum 0xec082c7b, Offset: 0x1610
// Size: 0x86
function isstillvalidtarget(weapon, ent) {
    if (!isdefined(ent)) {
        return false;
    }
    if (!insideapreticlelocked(ent)) {
        return false;
    }
    if (!isalive(ent)) {
        return false;
    }
    if (!locksighttest(ent)) {
        return false;
    }
    return true;
}

// Namespace multilockap_guidance
// Params 3, eflags: 0x1 linked
// Checksum 0x99f29f6b, Offset: 0x16a0
// Size: 0xec
function seekersound(alias, looping, id) {
    self notify("stop_sound" + id);
    self endon("stop_sound" + id);
    self endon(#"disconnect");
    self endon(#"death");
    if (isdefined(alias)) {
        self playrumbleonentity("stinger_lock_rumble");
        time = soundgetplaybacktime(alias) * 0.001;
        do {
            self playlocalsound(alias);
            wait time;
        } while (looping);
        self stoprumble("stinger_lock_rumble");
    }
}

// Namespace multilockap_guidance
// Params 1, eflags: 0x1 linked
// Checksum 0x853466a8, Offset: 0x1798
// Size: 0x180
function locksighttest(target) {
    eyepos = self geteye();
    if (!isdefined(target)) {
        return false;
    }
    if (!isalive(target)) {
        return false;
    }
    pos = target getshootatpos();
    if (isdefined(pos)) {
        passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
        if (passed) {
            return true;
        }
    }
    pos = target getcentroid();
    if (isdefined(pos)) {
        passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
        if (passed) {
            return true;
        }
    }
    pos = target.origin;
    passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
    if (passed) {
        return true;
    }
    return false;
}

