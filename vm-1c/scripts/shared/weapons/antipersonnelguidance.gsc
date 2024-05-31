#using scripts/shared/abilities/_ability_util;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace singlelockap_guidance;

// Namespace singlelockap_guidance
// Params 0, eflags: 0x2
// namespace_37f9aca4<file_0>::function_2dc19561
// Checksum 0xbbae0cb4, Offset: 0x220
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("singlelockap_guidance", &__init__, undefined, undefined);
}

// Namespace singlelockap_guidance
// Params 0, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_8c87d8eb
// Checksum 0x5be798ca, Offset: 0x260
// Size: 0x24
function __init__() {
    callback::on_spawned(&on_player_spawned);
}

// Namespace singlelockap_guidance
// Params 0, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_aebcf025
// Checksum 0xfacdcaab, Offset: 0x290
// Size: 0x4c
function on_player_spawned() {
    self endon(#"disconnect");
    self clearaptarget();
    thread aptoggleloop();
    self thread function_c0677ebd();
}

// Namespace singlelockap_guidance
// Params 2, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_4da93304
// Checksum 0xc2305dc3, Offset: 0x2e8
// Size: 0x25c
function clearaptarget(weapon, whom) {
    if (!isdefined(self.multilocklist)) {
        self.multilocklist = [];
    }
    if (isdefined(whom)) {
        for (i = 0; i < self.multilocklist.size; i++) {
            if (whom.aptarget == self.multilocklist[i].aptarget) {
                self.multilocklist[i].aptarget notify(#"missile_unlocked");
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

// Namespace singlelockap_guidance
// Params 0, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_c0677ebd
// Checksum 0x91d5f765, Offset: 0x550
// Size: 0x11e
function function_c0677ebd() {
    self endon(#"disconnect");
    self endon(#"death");
    while (true) {
        missile, weapon = self waittill(#"missile_fire");
        if (weapon.lockontype == "AP Single") {
            foreach (target in self.multilocklist) {
                if (isdefined(target.aptarget) && target.aplockfinalized) {
                    target.aptarget notify(#"stinger_fired_at_me", missile, weapon, self);
                }
            }
        }
    }
}

// Namespace singlelockap_guidance
// Params 0, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_8d1ede4
// Checksum 0x64971312, Offset: 0x678
// Size: 0x178
function aptoggleloop() {
    self endon(#"disconnect");
    self endon(#"death");
    for (;;) {
        weapon = self waittill(#"weapon_change");
        while (weapon.lockontype == "AP Single") {
            abort = 0;
            while (!(self playerads() == 1)) {
                wait(0.05);
                currentweapon = self getcurrentweapon();
                if (currentweapon.lockontype != "AP Single") {
                    abort = 1;
                    break;
                }
            }
            if (abort) {
                break;
            }
            self thread aplockloop(weapon);
            while (self playerads() == 1) {
                wait(0.05);
            }
            self notify(#"ap_off");
            self clearaptarget(weapon);
            weapon = self getcurrentweapon();
        }
    }
}

// Namespace singlelockap_guidance
// Params 1, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_601d4865
// Checksum 0xe2d2772b, Offset: 0x7f8
// Size: 0x53e
function aplockloop(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"ap_off");
    locklength = self getlockonspeed();
    self.multilocklist = [];
    for (;;) {
        wait(0.05);
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
        if (self.multilocklist.size >= 1) {
            continue;
        }
        besttarget = self getbesttarget(weapon);
        if (!isdefined(besttarget) && self.multilocklist.size == 0) {
            self destroylockoncanceledmessage();
            continue;
        }
        if (isdefined(besttarget) && self.multilocklist.size < 1) {
            self weaponlockstart(besttarget.aptarget, self.multilocklist.size);
            self.multilocklist[self.multilocklist.size] = besttarget;
        }
    }
}

// Namespace singlelockap_guidance
// Params 0, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_7e6838e7
// Checksum 0xc6888913, Offset: 0xd40
// Size: 0x2c
function destroylockoncanceledmessage() {
    if (isdefined(self.lockoncanceledmessage)) {
        self.lockoncanceledmessage destroy();
    }
}

// Namespace singlelockap_guidance
// Params 0, eflags: 0x0
// namespace_37f9aca4<file_0>::function_ec576e9f
// Checksum 0x94186abf, Offset: 0xd78
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

// Namespace singlelockap_guidance
// Params 1, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_7f1a054a
// Checksum 0x9532387b, Offset: 0xed8
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

// Namespace singlelockap_guidance
// Params 2, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_aa0319d2
// Checksum 0x1cec925f, Offset: 0x1420
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

// Namespace singlelockap_guidance
// Params 1, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_13957682
// Checksum 0x8a706d32, Offset: 0x1488
// Size: 0x52
function insideapreticlenolock(target) {
    radius = self getlockonradius();
    return target_isincircle(target, self, 65, radius);
}

// Namespace singlelockap_guidance
// Params 1, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_66358804
// Checksum 0x6f08f229, Offset: 0x14e8
// Size: 0x52
function insideapreticlelocked(target) {
    radius = self getlockonlossradius();
    return target_isincircle(target, self, 65, radius);
}

// Namespace singlelockap_guidance
// Params 2, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_d02638da
// Checksum 0x4d53bd73, Offset: 0x1548
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

// Namespace singlelockap_guidance
// Params 3, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_17816f15
// Checksum 0x18b99623, Offset: 0x15d8
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
            wait(time);
        } while (looping);
        self stoprumble("stinger_lock_rumble");
    }
}

// Namespace singlelockap_guidance
// Params 1, eflags: 0x1 linked
// namespace_37f9aca4<file_0>::function_27f7300b
// Checksum 0xd9f4a47c, Offset: 0x16d0
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

