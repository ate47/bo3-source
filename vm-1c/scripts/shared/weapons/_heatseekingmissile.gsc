#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace heatseekingmissile;

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_1463e4e5
// Checksum 0x50a1eadf, Offset: 0x318
// Size: 0x84
function init_shared() {
    game["locking_on_sound"] = "uin_alert_lockon_start";
    game["locked_on_sound"] = "uin_alert_lockon";
    callback::on_spawned(&on_player_spawned);
    level.fx_flare = "killstreaks/fx_heli_chaff";
    /#
        setdvar("top", "top");
    #/
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_aebcf025
// Checksum 0xf794b0f4, Offset: 0x3a8
// Size: 0x4c
function on_player_spawned() {
    self endon(#"disconnect");
    self clearirtarget();
    thread stingertoggleloop();
    self thread stingerfirednotify();
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_e63c5c9a
// Checksum 0xde948d44, Offset: 0x400
// Size: 0x17c
function clearirtarget() {
    self notify(#"stop_lockon_sound");
    self notify(#"stop_locked_sound");
    self.stingerlocksound = undefined;
    self stoprumble("stinger_lock_rumble");
    self.stingerlockstarttime = 0;
    self.stingerlockstarted = 0;
    self.stingerlockfinalized = 0;
    self.stingerlockdetected = 0;
    if (isdefined(self.stingertarget)) {
        self.stingertarget notify(#"missile_unlocked");
        self lockingon(self.stingertarget, 0);
        self lockedon(self.stingertarget, 0);
    }
    self.stingertarget = undefined;
    self weaponlockfree();
    self weaponlocktargettooclose(0);
    self weaponlocknoclearance(0);
    self stoplocalsound(game["locking_on_sound"]);
    self stoplocalsound(game["locked_on_sound"]);
    self destroylockoncanceledmessage();
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_31cadfdc
// Checksum 0xa4bf0f7a, Offset: 0x588
// Size: 0xb8
function stingerfirednotify() {
    self endon(#"disconnect");
    self endon(#"death");
    while (true) {
        missile, weapon = self waittill(#"missile_fire");
        /#
            thread debug_missile(missile);
        #/
        if (weapon.lockontype == "Legacy Single") {
            if (isdefined(self.stingertarget) && self.stingerlockfinalized) {
                self.stingertarget notify(#"stinger_fired_at_me", missile, weapon, self);
            }
        }
    }
}

/#

    // Namespace heatseekingmissile
    // Params 1, eflags: 0x1 linked
    // namespace_181a2aa3<file_0>::function_57990cff
    // Checksum 0xec561dea, Offset: 0x648
    // Size: 0x248
    function debug_missile(missile) {
        level notify(#"debug_missile");
        level endon(#"debug_missile");
        level.debug_missile_dots = [];
        while (true) {
            if (getdvarint("top", 0) == 0) {
                wait(0.5);
                continue;
            }
            if (isdefined(missile)) {
                missile_info = spawnstruct();
                missile_info.origin = missile.origin;
                target = missile missile_gettarget();
                missile_info.targetentnum = isdefined(target) ? target getentitynumber() : undefined;
                if (!isdefined(level.debug_missile_dots)) {
                    level.debug_missile_dots = [];
                } else if (!isarray(level.debug_missile_dots)) {
                    level.debug_missile_dots = array(level.debug_missile_dots);
                }
                level.debug_missile_dots[level.debug_missile_dots.size] = missile_info;
            }
            foreach (missile_info in level.debug_missile_dots) {
                dot_color = isdefined(missile_info.targetentnum) ? (1, 0, 0) : (0, 1, 0);
                dev::debug_sphere(missile_info.origin, 10, dot_color, 0.66, 1);
            }
            wait(0.05);
        }
    }

#/

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_5bffc47b
// Checksum 0x1fe97987, Offset: 0x898
// Size: 0x70
function stingerwaitforads() {
    while (!self playerstingerads()) {
        wait(0.05);
        currentweapon = self getcurrentweapon();
        if (currentweapon.lockontype != "Legacy Single") {
            return false;
        }
    }
    return true;
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_ba6760b3
// Checksum 0x9bca456, Offset: 0x910
// Size: 0x138
function stingertoggleloop() {
    self endon(#"disconnect");
    self endon(#"death");
    for (;;) {
        weapon = self waittill(#"weapon_change");
        while (weapon.lockontype == "Legacy Single") {
            if (self getweaponammoclip(weapon) == 0) {
                wait(0.05);
                weapon = self getcurrentweapon();
                continue;
            }
            if (!stingerwaitforads()) {
                break;
            }
            self thread stingerirtloop(weapon);
            while (self playerstingerads()) {
                wait(0.05);
            }
            self notify(#"stinger_irt_off");
            self clearirtarget();
            weapon = self getcurrentweapon();
        }
    }
}

// Namespace heatseekingmissile
// Params 1, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_f14a1516
// Checksum 0x1fbb6c0, Offset: 0xa50
// Size: 0x670
function stingerirtloop(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"stinger_irt_off");
    locklength = self getlockonspeed();
    for (;;) {
        wait(0.05);
        if (!self hasweapon(weapon)) {
            break;
        }
        if (self.stingerlockfinalized) {
            passed = softsighttest();
            if (!passed) {
                continue;
            }
            if (!self isstillvalidtarget(self.stingertarget, weapon) || self insidestingerreticlelocked(self.stingertarget, weapon) == 0) {
                self setweaponlockonpercent(weapon, 0);
                self clearirtarget();
                continue;
            }
            if (!self.stingertarget.locked_on) {
                self.stingertarget notify(#"missile_lock", self, self getcurrentweapon());
            }
            self lockingon(self.stingertarget, 0);
            self lockedon(self.stingertarget, 1);
            if (isdefined(weapon)) {
                setfriendlyflags(weapon, self.stingertarget);
            }
            thread looplocallocksound(game["locked_on_sound"], 0.75);
            continue;
        }
        if (self.stingerlockstarted) {
            if (!self isstillvalidtarget(self.stingertarget, weapon) || self insidestingerreticlelocked(self.stingertarget, weapon) == 0) {
                self setweaponlockonpercent(weapon, 0);
                self clearirtarget();
                continue;
            }
            self lockingon(self.stingertarget, 1);
            self lockedon(self.stingertarget, 0);
            if (isdefined(weapon)) {
                setfriendlyflags(weapon, self.stingertarget);
            }
            passed = softsighttest();
            if (!passed) {
                continue;
            }
            timepassed = gettime() - self.stingerlockstarttime;
            if (isdefined(weapon)) {
                self setweaponlockonpercent(weapon, timepassed / locklength * 100);
                setfriendlyflags(weapon, self.stingertarget);
            }
            if (timepassed < locklength) {
                continue;
            }
            assert(isdefined(self.stingertarget));
            self notify(#"stop_lockon_sound");
            self.stingerlockfinalized = 1;
            self weaponlockfinalize(self.stingertarget);
            continue;
        }
        besttarget = self getbeststingertarget(weapon);
        if (isdefined(self.stingertarget) && (!isdefined(besttarget) || self.stingertarget != besttarget)) {
            self destroylockoncanceledmessage();
            if (self.stingerlockdetected == 1) {
                self weaponlockfree();
                self.stingerlockdetected = 0;
            }
            continue;
        }
        if (!self locksighttest(besttarget)) {
            self destroylockoncanceledmessage();
            continue;
        }
        if (isdefined(besttarget.lockondelay) && besttarget.lockondelay) {
            self displaylockoncanceledmessage();
            continue;
        }
        if (!targetwithinrangeofplayspace(besttarget)) {
            self displaylockoncanceledmessage();
            continue;
        }
        self destroylockoncanceledmessage();
        if (self insidestingerreticlelocked(besttarget, weapon) == 0) {
            if (self.stingerlockdetected == 0) {
                self weaponlockdetect(besttarget);
            }
            self.stingerlockdetected = 1;
            if (isdefined(weapon)) {
                setfriendlyflags(weapon, besttarget);
            }
            continue;
        }
        self.stingerlockdetected = 0;
        initlockfield(besttarget);
        self.stingertarget = besttarget;
        self.stingerlockstarttime = gettime();
        self.stingerlockstarted = 1;
        self.stingerlostsightlinetime = 0;
        self weaponlockstart(besttarget);
        self thread looplocalseeksound(game["locking_on_sound"], 0.6);
    }
}

// Namespace heatseekingmissile
// Params 1, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_de35ef7
// Checksum 0xda82c207, Offset: 0x10c8
// Size: 0x170
function targetwithinrangeofplayspace(target) {
    /#
        if (getdvarint("top", 0) > 0) {
            extraradiusdvar = getdvarint("top", 5000);
            if (extraradiusdvar != (isdefined(level.missilelockplayspacecheckextraradius) ? level.missilelockplayspacecheckextraradius : 0)) {
                level.missilelockplayspacecheckextraradius = extraradiusdvar;
                level.missilelockplayspacecheckradiussqr = undefined;
            }
        }
    #/
    if (level.missilelockplayspacecheckenabled === 1) {
        if (!isdefined(target)) {
            return false;
        }
        if (!isdefined(level.playspacecenter)) {
            level.playspacecenter = util::getplayspacecenter();
        }
        if (!isdefined(level.missilelockplayspacecheckradiussqr)) {
            level.missilelockplayspacecheckradiussqr = (util::getplayspacemaxwidth() * 0.5 + level.missilelockplayspacecheckextraradius) * (util::getplayspacemaxwidth() * 0.5 + level.missilelockplayspacecheckextraradius);
        }
        if (distance2dsquared(target.origin, level.playspacecenter) > level.missilelockplayspacecheckradiussqr) {
            return false;
        }
    }
    return true;
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_7e6838e7
// Checksum 0xe97b552, Offset: 0x1240
// Size: 0x2c
function destroylockoncanceledmessage() {
    if (isdefined(self.lockoncanceledmessage)) {
        self.lockoncanceledmessage destroy();
    }
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_ec576e9f
// Checksum 0x770f8f57, Offset: 0x1278
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

// Namespace heatseekingmissile
// Params 1, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_30c2ba82
// Checksum 0x7799c0ea, Offset: 0x13d8
// Size: 0x3bc
function getbeststingertarget(weapon) {
    targetsall = [];
    if (isdefined(self.get_stinger_target_override)) {
        targetsall = self [[ self.get_stinger_target_override ]]();
    } else {
        targetsall = target_getarray();
    }
    targetsvalid = [];
    for (idx = 0; idx < targetsall.size; idx++) {
        /#
            if (getdvarstring("top") == "top") {
                if (self insidestingerreticlenolock(targetsall[idx], weapon)) {
                    targetsvalid[targetsvalid.size] = targetsall[idx];
                }
                continue;
            }
        #/
        target = targetsall[idx];
        if (level.teambased || level.use_team_based_logic_for_locking_on === 1) {
            if (isdefined(target.team) && target.team != self.team) {
                if (self insidestingerreticledetect(target, weapon)) {
                    if (!isdefined(self.is_valid_target_for_stinger_override) || self [[ self.is_valid_target_for_stinger_override ]](target)) {
                        hascamo = isdefined(target.camo_state) && target.camo_state == 1 && !self hasperk("specialty_showenemyequipment");
                        if (!hascamo) {
                            targetsvalid[targetsvalid.size] = target;
                        }
                    }
                }
            }
            continue;
        }
        if (self insidestingerreticledetect(target, weapon)) {
            if (isplayer(target) && (isdefined(target.owner) && self != target.owner || self != target)) {
                if (!isdefined(self.is_valid_target_for_stinger_override) || self [[ self.is_valid_target_for_stinger_override ]](target)) {
                    targetsvalid[targetsvalid.size] = target;
                }
            }
        }
    }
    if (targetsvalid.size == 0) {
        return undefined;
    }
    besttarget = targetsvalid[0];
    if (targetsvalid.size > 1) {
        closestratio = 0;
        foreach (target in targetsvalid) {
            ratio = ratiodistancefromscreencenter(target, weapon);
            if (ratio > closestratio) {
                closestratio = ratio;
                besttarget = target;
            }
        }
    }
    return besttarget;
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_4e41de8e
// Checksum 0x3cbc8529, Offset: 0x17a0
// Size: 0xfa
function calclockonradius(target, weapon) {
    radius = self getlockonradius();
    if (isdefined(weapon) && isdefined(weapon.lockonscreenradius) && weapon.lockonscreenradius > radius) {
        radius = weapon.lockonscreenradius;
    }
    if (isdefined(level.lockoncloserange) && isdefined(level.lockoncloseradiusscaler)) {
        dist2 = distancesquared(target.origin, self.origin);
        if (dist2 < level.lockoncloserange * level.lockoncloserange) {
            radius *= level.lockoncloseradiusscaler;
        }
    }
    return radius;
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_bbb66c73
// Checksum 0x9236a5d1, Offset: 0x18a8
// Size: 0xfa
function calclockonlossradius(target, weapon) {
    radius = self getlockonlossradius();
    if (isdefined(weapon) && isdefined(weapon.lockonscreenradius) && weapon.lockonscreenradius > radius) {
        radius = weapon.lockonscreenradius;
    }
    if (isdefined(level.lockoncloserange) && isdefined(level.lockoncloseradiusscaler)) {
        dist2 = distancesquared(target.origin, self.origin);
        if (dist2 < level.lockoncloserange * level.lockoncloserange) {
            radius *= level.lockoncloseradiusscaler;
        }
    }
    return radius;
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_5098f394
// Checksum 0xf62b7cae, Offset: 0x19b0
// Size: 0x5a
function ratiodistancefromscreencenter(target, weapon) {
    radius = calclockonradius(target, weapon);
    return target_scaleminmaxradius(target, self, 65, 0, radius);
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_dcbc2b46
// Checksum 0xe2c3cb46, Offset: 0x1a18
// Size: 0x5a
function insidestingerreticledetect(target, weapon) {
    radius = calclockonradius(target, weapon);
    return target_isincircle(target, self, 65, radius);
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_6b6aff1f
// Checksum 0xc8aaaf54, Offset: 0x1a80
// Size: 0x5a
function insidestingerreticlenolock(target, weapon) {
    radius = calclockonradius(target, weapon);
    return target_isincircle(target, self, 65, radius);
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_289c9899
// Checksum 0x2065fddd, Offset: 0x1ae8
// Size: 0x5a
function insidestingerreticlelocked(target, weapon) {
    radius = calclockonlossradius(target, weapon);
    return target_isincircle(target, self, 65, radius);
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_d02638da
// Checksum 0xe206145f, Offset: 0x1b50
// Size: 0xae
function isstillvalidtarget(ent, weapon) {
    if (!isdefined(ent)) {
        return 0;
    }
    if (isdefined(self.is_still_valid_target_for_stinger_override)) {
        return self [[ self.is_still_valid_target_for_stinger_override ]](ent, weapon);
    }
    if (!target_istarget(ent) && !(isdefined(ent.allowcontinuedlockonafterinvis) && ent.allowcontinuedlockonafterinvis)) {
        return 0;
    }
    if (!insidestingerreticledetect(ent, weapon)) {
        return 0;
    }
    return 1;
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_3f580a4a
// Checksum 0xb73ad6d0, Offset: 0x1c08
// Size: 0x24
function playerstingerads() {
    return self playerads() == 1;
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_7f46761d
// Checksum 0xd249438c, Offset: 0x1c38
// Size: 0x7c
function looplocalseeksound(alias, interval) {
    self endon(#"stop_lockon_sound");
    self endon(#"disconnect");
    self endon(#"death");
    for (;;) {
        self playsoundforlocalplayer(alias);
        self playrumbleonentity("stinger_lock_rumble");
        wait(interval / 2);
    }
}

// Namespace heatseekingmissile
// Params 1, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_6f69e521
// Checksum 0x2fc92d8d, Offset: 0x1cc0
// Size: 0x8c
function playsoundforlocalplayer(alias) {
    if (self isinvehicle()) {
        sound_target = self getvehicleoccupied();
        if (isdefined(sound_target)) {
            sound_target playsoundtoplayer(alias, self);
        }
        return;
    }
    self playlocalsound(alias);
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_cddaeeb2
// Checksum 0x5cc53d84, Offset: 0x1d58
// Size: 0x152
function looplocallocksound(alias, interval) {
    self endon(#"stop_locked_sound");
    self endon(#"disconnect");
    self endon(#"death");
    if (isdefined(self.stingerlocksound)) {
        return;
    }
    self.stingerlocksound = 1;
    for (;;) {
        self playsoundforlocalplayer(alias);
        self playrumbleonentity("stinger_lock_rumble");
        wait(interval / 6);
        self playsoundforlocalplayer(alias);
        self playrumbleonentity("stinger_lock_rumble");
        wait(interval / 6);
        self playsoundforlocalplayer(alias);
        self playrumbleonentity("stinger_lock_rumble");
        wait(interval / 6);
        self stoprumble("stinger_lock_rumble");
    }
    self.stingerlocksound = undefined;
}

// Namespace heatseekingmissile
// Params 1, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_27f7300b
// Checksum 0x9ae55e44, Offset: 0x1eb8
// Size: 0x220
function locksighttest(target) {
    camerapos = self getplayercamerapos();
    if (!isdefined(target)) {
        return false;
    }
    if (isdefined(target.parent)) {
        passed = bullettracepassed(camerapos, target.origin, 0, target, target.parent);
    } else {
        passed = bullettracepassed(camerapos, target.origin, 0, target);
    }
    if (passed) {
        return true;
    }
    front = target getpointinbounds(1, 0, 0);
    if (isdefined(target.parent)) {
        passed = bullettracepassed(camerapos, front, 0, target, target.parent);
    } else {
        passed = bullettracepassed(camerapos, front, 0, target);
    }
    if (passed) {
        return true;
    }
    back = target getpointinbounds(-1, 0, 0);
    if (isdefined(target.parent)) {
        passed = bullettracepassed(camerapos, back, 0, target, target.parent);
    } else {
        passed = bullettracepassed(camerapos, back, 0, target);
    }
    if (passed) {
        return true;
    }
    return false;
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_821d606c
// Checksum 0xc2cf59ae, Offset: 0x20e0
// Size: 0xa4
function softsighttest() {
    lost_sight_limit = 500;
    if (self locksighttest(self.stingertarget)) {
        self.stingerlostsightlinetime = 0;
        return true;
    }
    if (self.stingerlostsightlinetime == 0) {
        self.stingerlostsightlinetime = gettime();
    }
    timepassed = gettime() - self.stingerlostsightlinetime;
    if (timepassed >= lost_sight_limit) {
        self clearirtarget();
        return false;
    }
    return true;
}

// Namespace heatseekingmissile
// Params 1, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_b0f0dc06
// Checksum 0xfd54e46a, Offset: 0x2190
// Size: 0x54
function initlockfield(target) {
    if (isdefined(target.locking_on)) {
        return;
    }
    target.locking_on = 0;
    target.locked_on = 0;
    target.locking_on_hacking = 0;
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_d444036b
// Checksum 0xa960e7cf, Offset: 0x21f0
// Size: 0xf8
function lockingon(target, lock) {
    assert(isdefined(target.locking_on));
    clientnum = self getentitynumber();
    if (lock) {
        target notify(#"hash_b081980b");
        target.locking_on |= 1 << clientnum;
        self thread watchclearlockingon(target, clientnum);
        return;
    }
    self notify(#"locking_on_cleared");
    target.locking_on &= ~(1 << clientnum);
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_a4a86263
// Checksum 0x1e4c6477, Offset: 0x22f0
// Size: 0x78
function watchclearlockingon(target, clientnum) {
    target endon(#"death");
    self endon(#"locking_on_cleared");
    self util::waittill_any("death", "disconnect");
    target.locking_on &= ~(1 << clientnum);
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_78a804bc
// Checksum 0x1c3dc256, Offset: 0x2370
// Size: 0xe8
function lockedon(target, lock) {
    assert(isdefined(target.locked_on));
    clientnum = self getentitynumber();
    if (lock) {
        target.locked_on |= 1 << clientnum;
        self thread watchclearlockedon(target, clientnum);
        return;
    }
    self notify(#"locked_on_cleared");
    target.locked_on &= ~(1 << clientnum);
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_bcfbf0cb
// Checksum 0xeaee5728, Offset: 0x2460
// Size: 0xf8
function targetinghacking(target, lock) {
    assert(isdefined(target.locking_on_hacking));
    clientnum = self getentitynumber();
    if (lock) {
        target notify(#"hash_e1494b46");
        target.locking_on_hacking |= 1 << clientnum;
        self thread watchclearhacking(target, clientnum);
        return;
    }
    self notify(#"locking_on_hacking_cleared");
    target.locking_on_hacking &= ~(1 << clientnum);
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_1c635562
// Checksum 0x39d39304, Offset: 0x2560
// Size: 0x78
function watchclearhacking(target, clientnum) {
    target endon(#"death");
    self endon(#"locking_on_hacking_cleared");
    self util::waittill_any("death", "disconnect");
    target.locking_on_hacking &= ~(1 << clientnum);
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_4479538b
// Checksum 0x97d833a5, Offset: 0x25e0
// Size: 0x52c
function setfriendlyflags(weapon, target) {
    if (!self isinvehicle()) {
        self setfriendlyhacking(weapon, target);
        self setfriendlytargetting(weapon, target);
        self setfriendlytargetlocked(weapon, target);
        if (isdefined(level.killstreakmaxhealthfunction)) {
            if (isdefined(target.usevtoltime) && isdefined(level.vtol)) {
                killstreakendtime = level.vtol.killstreakendtime;
                if (isdefined(killstreakendtime)) {
                    self settargetedentityendtime(weapon, killstreakendtime);
                }
            } else if (isdefined(target.killstreakendtime)) {
                self settargetedentityendtime(weapon, target.killstreakendtime);
            } else if (isdefined(target.parentstruct) && isdefined(target.parentstruct.killstreakendtime)) {
                self settargetedentityendtime(weapon, target.parentstruct.killstreakendtime);
            } else {
                self settargetedentityendtime(weapon, 0);
            }
            self settargetedmissilesremaining(weapon, 0);
            killstreaktype = target.killstreaktype;
            if (!isdefined(target.killstreaktype) && isdefined(target.parentstruct) && isdefined(target.parentstruct.killstreaktype)) {
                killstreaktype = target.parentstruct.killstreaktype;
            } else if (isdefined(target.usevtoltime) && isdefined(level.vtol.killstreaktype)) {
                killstreaktype = level.vtol.killstreaktype;
            }
            if (isdefined(killstreaktype) && isdefined(level.killstreakbundle[killstreaktype])) {
                if (isdefined(target.forceonemissile)) {
                    self settargetedmissilesremaining(weapon, 1);
                    return;
                }
                if (isdefined(target.usevtoltime) && isdefined(level.vtol) && isdefined(level.vtol.totalrockethits) && isdefined(level.vtol.missiletodestroy)) {
                    self settargetedmissilesremaining(weapon, level.vtol.missiletodestroy - level.vtol.totalrockethits);
                    return;
                }
                maxhealth = [[ level.killstreakmaxhealthfunction ]](killstreaktype);
                damagetaken = target.damagetaken;
                if (!isdefined(damagetaken) && isdefined(target.parentstruct)) {
                    damagetaken = target.parentstruct.damagetaken;
                }
                if (isdefined(target.missiletrackdamage)) {
                    damagetaken = target.missiletrackdamage;
                }
                if (isdefined(damagetaken) && isdefined(maxhealth)) {
                    damageperrocket = maxhealth / level.killstreakbundle[killstreaktype].ksrocketstokill + 1;
                    remaininghealth = maxhealth - damagetaken;
                    if (remaininghealth > 0) {
                        missilesremaining = int(ceil(remaininghealth / damageperrocket));
                        if (isdefined(target.numflares) && target.numflares > 0) {
                            missilesremaining += target.numflares;
                        }
                        if (isdefined(target.flak_drone)) {
                            missilesremaining += 1;
                        }
                        self settargetedmissilesremaining(weapon, missilesremaining);
                    }
                }
            }
        }
    }
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_7ae5e0b
// Checksum 0x8dd04a, Offset: 0x2b18
// Size: 0xbc
function setfriendlyhacking(weapon, target) {
    if (level.teambased) {
        friendlyhackingmask = target.locking_on_hacking;
        if (isdefined(friendlyhackingmask)) {
            friendlyhacking = 0;
            clientnum = self getentitynumber();
            friendlyhackingmask &= ~(1 << clientnum);
            if (friendlyhackingmask != 0) {
                friendlyhacking = 1;
            }
            self setweaponfriendlyhacking(weapon, friendlyhacking);
        }
    }
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_8427e69d
// Checksum 0x13856911, Offset: 0x2be0
// Size: 0xbc
function setfriendlytargetting(weapon, target) {
    if (level.teambased) {
        friendlytargetingmask = target.locking_on;
        if (isdefined(friendlytargetingmask)) {
            friendlytargeting = 0;
            clientnum = self getentitynumber();
            friendlytargetingmask &= ~(1 << clientnum);
            if (friendlytargetingmask != 0) {
                friendlytargeting = 1;
            }
            self setweaponfriendlytargeting(weapon, friendlytargeting);
        }
    }
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_9f82af3b
// Checksum 0xd29af4bb, Offset: 0x2ca8
// Size: 0xec
function setfriendlytargetlocked(weapon, target) {
    if (level.teambased) {
        friendlytargetlocked = 0;
        friendlylockingonmask = target.locked_on;
        if (isdefined(friendlylockingonmask)) {
            friendlytargetlocked = 0;
            clientnum = self getentitynumber();
            friendlylockingonmask &= ~(1 << clientnum);
            if (friendlylockingonmask != 0) {
                friendlytargetlocked = 1;
            }
        }
        if (friendlytargetlocked == 0) {
            friendlytargetlocked = target missiletarget_isotherplayermissileincoming(self);
        }
        self setweaponfriendlytargetlocked(weapon, friendlytargetlocked);
    }
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_74e3cc84
// Checksum 0xba84ae61, Offset: 0x2da0
// Size: 0x78
function watchclearlockedon(target, clientnum) {
    self endon(#"locked_on_cleared");
    self util::waittill_any("death", "disconnect");
    if (isdefined(target)) {
        target.locked_on &= ~(1 << clientnum);
    }
}

// Namespace heatseekingmissile
// Params 3, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_e97f1ff5
// Checksum 0xdeed5377, Offset: 0x2e20
// Size: 0x230
function missiletarget_lockonmonitor(player, endon1, endon2) {
    self endon(#"death");
    if (isdefined(endon1)) {
        self endon(endon1);
    }
    if (isdefined(endon2)) {
        self endon(endon2);
    }
    for (;;) {
        if (target_istarget(self)) {
            if (self missiletarget_ismissileincoming()) {
                self clientfield::set("heli_warn_fired", 1);
                self clientfield::set("heli_warn_locked", 0);
                self clientfield::set("heli_warn_targeted", 0);
            } else if (isdefined(self.locked_on) && self.locked_on) {
                self clientfield::set("heli_warn_locked", 1);
                self clientfield::set("heli_warn_fired", 0);
                self clientfield::set("heli_warn_targeted", 0);
            } else if (isdefined(self.locking_on) && self.locking_on) {
                self clientfield::set("heli_warn_targeted", 1);
                self clientfield::set("heli_warn_fired", 0);
                self clientfield::set("heli_warn_locked", 0);
            } else {
                self clientfield::set("heli_warn_fired", 0);
                self clientfield::set("heli_warn_targeted", 0);
                self clientfield::set("heli_warn_locked", 0);
            }
        }
        wait(0.1);
    }
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_1d72ff4
// Checksum 0x87ced7fb, Offset: 0x3058
// Size: 0xdc
function _incomingmissile(missile, attacker) {
    if (!isdefined(self.incoming_missile)) {
        self.incoming_missile = 0;
    }
    if (!isdefined(self.incoming_missile_owner)) {
        self.incoming_missile_owner = [];
    }
    if (!isdefined(self.incoming_missile_owner[attacker.entnum])) {
        self.incoming_missile_owner[attacker.entnum] = 0;
    }
    self.incoming_missile++;
    self.incoming_missile_owner[attacker.entnum]++;
    attacker lockedon(self, 1);
    self thread _incomingmissiletracker(missile, attacker);
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_a8bd8510
// Checksum 0xbc2b3a76, Offset: 0x3140
// Size: 0xc4
function _incomingmissiletracker(missile, attacker) {
    self endon(#"death");
    attacker_entnum = attacker.entnum;
    missile waittill(#"death");
    self.incoming_missile--;
    self.incoming_missile_owner[attacker_entnum]--;
    if (self.incoming_missile_owner[attacker_entnum] == 0) {
        self.incoming_missile_owner[attacker_entnum] = undefined;
    }
    if (isdefined(attacker)) {
        attacker lockedon(self, 0);
    }
    assert(self.incoming_missile >= 0);
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_360ba185
// Checksum 0xa0bf9f6, Offset: 0x3210
// Size: 0x26
function missiletarget_ismissileincoming() {
    if (!isdefined(self.incoming_missile)) {
        return false;
    }
    if (self.incoming_missile) {
        return true;
    }
    return false;
}

// Namespace heatseekingmissile
// Params 1, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_1a52130
// Checksum 0x8a0af1f7, Offset: 0x3240
// Size: 0x66
function missiletarget_isotherplayermissileincoming(attacker) {
    if (!isdefined(self.incoming_missile_owner)) {
        return false;
    }
    if (self.incoming_missile_owner.size == 0) {
        return false;
    }
    if (self.incoming_missile_owner.size == 1 && isdefined(self.incoming_missile_owner[attacker.entnum])) {
        return false;
    }
    return true;
}

// Namespace heatseekingmissile
// Params 4, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_e62dae7b
// Checksum 0x5a040b2b, Offset: 0x32b0
// Size: 0xde
function missiletarget_handleincomingmissile(responsefunc, endon1, endon2, allowdirectdamage) {
    level endon(#"game_ended");
    self endon(#"death");
    if (isdefined(endon1)) {
        self endon(endon1);
    }
    if (isdefined(endon2)) {
        self endon(endon2);
    }
    for (;;) {
        missile, weapon, attacker = self waittill(#"stinger_fired_at_me");
        _incomingmissile(missile, attacker);
        if (isdefined(responsefunc)) {
            [[ responsefunc ]](missile, attacker, weapon, endon1, endon2, allowdirectdamage);
        }
    }
}

// Namespace heatseekingmissile
// Params 3, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_3492826e
// Checksum 0xce2f6394, Offset: 0x3398
// Size: 0x4c
function missiletarget_proximitydetonateincomingmissile(endon1, endon2, allowdirectdamage) {
    missiletarget_handleincomingmissile(&missiletarget_proximitydetonate, endon1, endon2, allowdirectdamage);
}

// Namespace heatseekingmissile
// Params 6, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_effbfe10
// Checksum 0x888ae76e, Offset: 0x33f0
// Size: 0x194
function _missiledetonate(attacker, weapon, range, mindamage, maxdamage, allowdirectdamage) {
    origin = self.origin;
    target = self missile_gettarget();
    self detonate();
    if (allowdirectdamage === 1 && isdefined(target) && isdefined(target.origin)) {
        mindistsq = isdefined(target.locked_missile_min_distsq) ? target.locked_missile_min_distsq : range * range;
        distsq = distancesquared(self.origin, target.origin);
        if (distsq < mindistsq) {
            target dodamage(maxdamage, origin, attacker, self, "none", "MOD_PROJECTILE", 0, weapon);
        }
    }
    radiusdamage(origin, range, maxdamage, mindamage, attacker, "MOD_PROJECTILE_SPLASH", weapon);
}

// Namespace heatseekingmissile
// Params 6, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_48a51eba
// Checksum 0x4c0a86fa, Offset: 0x3590
// Size: 0x33c
function missiletarget_proximitydetonate(missile, attacker, weapon, endon1, endon2, allowdirectdamage) {
    level endon(#"game_ended");
    missile endon(#"death");
    if (isdefined(endon1)) {
        self endon(endon1);
    }
    if (isdefined(endon2)) {
        self endon(endon2);
    }
    mindist = distancesquared(missile.origin, self.origin);
    lastcenter = self.origin;
    missile missile_settarget(self, isdefined(target_getoffset(self)) ? target_getoffset(self) : (0, 0, 0));
    if (isdefined(self.missiletargetmissdistance)) {
        misseddistancesq = self.missiletargetmissdistance * self.missiletargetmissdistance;
    } else {
        misseddistancesq = 250000;
    }
    flaredistancesq = 12250000;
    for (;;) {
        if (!isdefined(self)) {
            center = lastcenter;
        } else {
            center = self.origin;
        }
        lastcenter = center;
        curdist = distancesquared(missile.origin, center);
        if (curdist < flaredistancesq && isdefined(self.numflares) && self.numflares > 0) {
            self.numflares--;
            self thread missiletarget_playflarefx();
            self challenges::trackassists(attacker, 0, 1);
            newtarget = self missiletarget_deployflares(missile.origin, missile.angles);
            missile missile_settarget(newtarget, isdefined(target_getoffset(newtarget)) ? target_getoffset(newtarget) : (0, 0, 0));
            missiletarget = newtarget;
            return;
        }
        if (curdist < mindist) {
            mindist = curdist;
        }
        if (curdist > mindist) {
            if (curdist > misseddistancesq) {
                return;
            }
            missile thread _missiledetonate(attacker, weapon, 500, 600, 600, allowdirectdamage);
            return;
        }
        wait(0.05);
    }
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_4db10219
// Checksum 0x154f29a7, Offset: 0x38d8
// Size: 0xe4
function missiletarget_playflarefx() {
    if (!isdefined(self)) {
        return;
    }
    flare_fx = level.fx_flare;
    if (isdefined(self.fx_flare)) {
        flare_fx = self.fx_flare;
    }
    if (isdefined(self.flare_ent)) {
        playfxontag(flare_fx, self.flare_ent, "tag_origin");
    } else {
        playfxontag(flare_fx, self, "tag_origin");
    }
    if (isdefined(self.owner)) {
        self playsoundtoplayer("veh_huey_chaff_drop_plr", self.owner);
    }
    self playsound("veh_huey_chaff_explo_npc");
}

// Namespace heatseekingmissile
// Params 2, eflags: 0x1 linked
// namespace_181a2aa3<file_0>::function_b45bf801
// Checksum 0x2e661a2f, Offset: 0x39c8
// Size: 0x2c8
function missiletarget_deployflares(origin, angles) {
    vec_toforward = anglestoforward(self.angles);
    vec_toright = anglestoright(self.angles);
    vec_tomissileforward = anglestoforward(angles);
    delta = self.origin - origin;
    dot = vectordot(vec_tomissileforward, vec_toright);
    sign = 1;
    if (dot > 0) {
        sign = -1;
    }
    flare_dir = vectornormalize(vectorscale(vec_toforward, -0.5) + vectorscale(vec_toright, sign));
    velocity = vectorscale(flare_dir, randomintrange(-56, 400));
    velocity = (velocity[0], velocity[1], velocity[2] - randomintrange(10, 100));
    flareorigin = self.origin;
    flareorigin += vectorscale(flare_dir, randomintrange(600, 800));
    flareorigin += (0, 0, 500);
    if (isdefined(self.flareoffset)) {
        flareorigin += self.flareoffset;
    }
    flareobject = spawn("script_origin", flareorigin);
    flareobject.angles = self.angles;
    flareobject setmodel("tag_origin");
    flareobject movegravity(velocity, 5);
    flareobject thread util::deleteaftertime(5);
    /#
        self thread debug_tracker(flareobject);
    #/
    return flareobject;
}

/#

    // Namespace heatseekingmissile
    // Params 1, eflags: 0x1 linked
    // namespace_181a2aa3<file_0>::function_a844306f
    // Checksum 0x246a2efe, Offset: 0x3c98
    // Size: 0x60
    function debug_tracker(target) {
        target endon(#"death");
        while (true) {
            dev::debug_sphere(target.origin, 10, (1, 0, 0), 1, 1);
            wait(0.05);
        }
    }

#/
