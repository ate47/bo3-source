#using scripts/shared/bots/bot_buttons;
#using scripts/shared/bots/_bot;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/array_shared;

#namespace namespace_5cd60c9f;

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0xb9eea440, Offset: 0x180
// Size: 0x16c
function function_a859fd70() {
    if (self function_231137e6()) {
        if (self function_cf5babf2()) {
            self update_threat();
        } else {
            self thread [[ level.var_a4c843d6 ]]();
        }
    }
    if (!self function_231137e6() && !self function_d53dcdb7()) {
        return;
    } else if (self function_231137e6()) {
        if (!self threat_visible() || self.bot.threat.var_7ee7b150 > level.botsettings.var_253386f) {
            self function_d53dcdb7(level.botsettings.var_a4232b8d);
        }
    }
    if (self threat_visible()) {
        self thread [[ level.var_1a99051e ]]();
        self thread [[ level.var_e3cf16d9 ]]();
        return;
    }
    self thread [[ level.var_1a85a65e ]]();
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0xcec84a4f, Offset: 0x2f8
// Size: 0x22
function is_alive(entity) {
    return isalive(entity);
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0xbe4c1b4, Offset: 0x328
// Size: 0x32
function function_459e3f9f(maxdistance) {
    if (!isdefined(maxdistance)) {
        maxdistance = 0;
    }
    return self function_423acd9b(maxdistance);
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x49dcb002, Offset: 0x368
// Size: 0x1a
function function_3aa9220a() {
    return getaiteamarray("axis");
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// Checksum 0xadde8142, Offset: 0x390
// Size: 0xe
function function_a1c8dbdc(entity) {
    return false;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0xde59d988, Offset: 0x3a8
// Size: 0x24
function function_c507b448(entity) {
    return !issentient(entity);
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0xe2e3cb35, Offset: 0x3d8
// Size: 0x1c
function function_231137e6() {
    return isdefined(self.bot.threat.entity);
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x301a4eb5, Offset: 0x400
// Size: 0x36
function threat_visible() {
    return self function_231137e6() && self.bot.threat.visible;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x48b413b8, Offset: 0x440
// Size: 0x82
function function_cf5babf2() {
    if (!self function_231137e6()) {
        return 0;
    }
    if (isdefined(level.var_492758f)) {
        return self [[ level.var_492758f ]](self.bot.threat.entity);
    }
    return isalive(self.bot.threat.entity);
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0xe7593144, Offset: 0x4d0
// Size: 0x74
function function_77724c2e(entity) {
    self.bot.threat.entity = entity;
    self.bot.threat.aimoffset = self function_54cd01e1(entity);
    self update_threat(1);
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0xe2baabce, Offset: 0x550
// Size: 0x44
function function_dc473bdb() {
    self.bot.threat.entity = undefined;
    self function_77c0a2f5();
    self function_66d6ef34();
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0x2648f662, Offset: 0x5a0
// Size: 0x3f0
function update_threat(newthreat) {
    if (isdefined(newthreat) && newthreat) {
        self.bot.threat.var_4f08b23e = 0;
        self function_77c0a2f5();
    } else {
        self.bot.threat.var_4f08b23e = self.bot.threat.visible;
    }
    velocity = self.bot.threat.entity getvelocity();
    distancesq = distancesquared(self geteye(), self.bot.threat.entity.origin);
    predictiontime = isdefined(level.botsettings.var_d74d136c) ? level.botsettings.var_d74d136c : 0.05;
    predictedposition = self.bot.threat.entity.origin + velocity * predictiontime;
    aimpoint = predictedposition + self.bot.threat.aimoffset;
    dot = self bot::fwd_dot(aimpoint);
    fov = self function_1032c029();
    if (isdefined(newthreat) && newthreat) {
        self.bot.threat.visible = 1;
    } else if (dot < fov || !self botsighttrace(self.bot.threat.entity)) {
        self.bot.threat.visible = 0;
        return;
    }
    self.bot.threat.visible = 1;
    self.bot.threat.var_d9d24b9e = gettime();
    self.bot.threat.var_7ee7b150 = distancesq;
    self.bot.threat.var_8d4eec98 = velocity;
    self.bot.threat.lastposition = predictedposition;
    self.bot.threat.aimpoint = aimpoint;
    self.bot.threat.dot = dot;
    weapon = self getcurrentweapon();
    var_34c2bc4c = function_a54977ff(weapon);
    self.bot.threat.inrange = distancesq < var_34c2bc4c * var_34c2bc4c;
    var_e3a5ed08 = function_eff9244e(weapon);
    self.bot.threat.incloserange = distancesq < var_e3a5ed08 * var_e3a5ed08;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0x81aee3b0, Offset: 0x998
// Size: 0x7c
function function_d53dcdb7(maxdistance) {
    entity = self function_9c78ebae(maxdistance);
    if (isdefined(entity) && entity !== self.bot.threat.entity) {
        self function_77724c2e(entity);
        return true;
    }
    return false;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0xb9522eee, Offset: 0xa20
// Size: 0xcc
function function_9c78ebae(maxdistance) {
    threats = self [[ level.var_423acd9b ]](maxdistance);
    if (!isdefined(threats)) {
        return undefined;
    }
    foreach (entity in threats) {
        if (self [[ level.var_b27b0b06 ]](entity)) {
            continue;
        }
        return entity;
    }
    return undefined;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0xc002a5fd, Offset: 0xaf8
// Size: 0x4bc
function function_47e9a4b7() {
    if (!self.bot.threat.var_4f08b23e && self.bot.threat.visible && !self isthrowinggrenade() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() && !self isswitchingweapons()) {
        var_efbf54a4 = randomint(100);
        var_e22df1b0 = isdefined(level.botsettings.var_a819fe0b) ? level.botsettings.var_a819fe0b : 0;
        if (var_efbf54a4 < var_e22df1b0 && self.bot.threat.var_7ee7b150 >= level.botsettings.var_8190d80e && self.bot.threat.var_7ee7b150 <= level.botsettings.var_706015f4 && self getweaponammostock(self.grenadetypeprimary)) {
            self function_77c0a2f5();
            self throw_grenade(self.grenadetypeprimary, self.bot.threat.lastposition);
            return;
        }
        var_efbf54a4 -= var_e22df1b0;
        var_e22df1b0 = isdefined(level.botsettings.var_be47c90a) ? level.botsettings.var_be47c90a : 0;
        if (var_efbf54a4 >= 0 && var_efbf54a4 < var_e22df1b0 && self.bot.threat.var_7ee7b150 >= level.botsettings.var_42d92b9d && self.bot.threat.var_7ee7b150 <= level.botsettings.var_833a914f && self getweaponammostock(self.grenadetypesecondary)) {
            self function_77c0a2f5();
            self throw_grenade(self.grenadetypesecondary, self.bot.threat.lastposition);
            return;
        }
        self.bot.threat.aimoffset = self function_54cd01e1(self.bot.threat.entity);
    }
    if (self fragbuttonpressed()) {
        self throw_grenade(self.grenadetypeprimary, self.bot.threat.lastposition);
        return;
    } else if (self secondaryoffhandbuttonpressed()) {
        self throw_grenade(self.grenadetypesecondary, self.bot.threat.lastposition);
        return;
    }
    self function_927ae397();
    if (self isreloading() || self isswitchingweapons() || self isthrowinggrenade() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self ismeleeing()) {
        return;
    }
    if (function_90d71e42()) {
        return;
    }
    self function_22db31d2();
    self fire_weapon();
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x95ce1b32, Offset: 0xfc0
// Size: 0x13c
function function_22585c05() {
    if (self botundermanualcontrol()) {
        return;
    }
    if (self.bot.threat.var_4f08b23e || self function_2b2bd09f() && !self.bot.threat.visible) {
        return;
    }
    radius = function_20513b0d();
    radiussq = radius * radius;
    var_dbb0f1ed = distance2dsquared(self.origin, self.bot.threat.lastposition);
    if (var_dbb0f1ed < radiussq || !self function_b4a0b3c5(self.bot.threat.lastposition, radius)) {
        self function_191f4091();
    }
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x9ccb08de, Offset: 0x1108
// Size: 0xe2
function function_20513b0d() {
    weapon = self getcurrentweapon();
    if (!self getweaponammoclip(weapon) && (randomint(100) < 10 || weapon.weapclass == "melee" || !self getweaponammostock(weapon))) {
        return level.botsettings.meleerange;
    }
    return randomintrange(level.botsettings.var_a4232b8d, level.botsettings.var_e18736a3);
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x5b1c39cb, Offset: 0x11f8
// Size: 0x14c
function fire_weapon() {
    if (!self.bot.threat.inrange) {
        return;
    }
    weapon = self getcurrentweapon();
    if (weapon == level.weaponnone || !self getweaponammoclip(weapon) || self.bot.threat.dot < function_defc094(weapon)) {
        return;
    }
    if (weapon.firetype == "Single Shot" || weapon.firetype == "Burst" || weapon.firetype == "Charge Shot") {
        if (self attackbuttonpressed()) {
            return;
        }
    }
    self bot::function_d31799d0();
    if (weapon.isdualwield) {
        self bot::function_39edb972();
    }
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x9120be55, Offset: 0x1350
// Size: 0x98
function function_90d71e42() {
    if (self.bot.threat.dot < level.botsettings.var_d7047444) {
        return false;
    }
    if (distancesquared(self.origin, self.bot.threat.lastposition) > level.botsettings.meleerangesq) {
        return false;
    }
    self bot::function_6e37f7f0();
    return true;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x15539658, Offset: 0x13f0
// Size: 0x1b4
function function_2322b744() {
    if (self botundermanualcontrol()) {
        return;
    }
    if (self.bot.threat.var_4f08b23e && !self.bot.threat.visible) {
        self function_77c0a2f5();
        self function_b4a0b3c5(self.bot.threat.lastposition);
        self bot::sprint_to_goal();
        return;
    }
    if (self.bot.threat.var_d9d24b9e + (isdefined(level.botsettings.var_c06c6206) ? level.botsettings.var_c06c6206 : 0) < gettime()) {
        self function_dc473bdb();
        return;
    }
    if (!self function_2b2bd09f()) {
        self bot::function_2e1b3e51(self.bot.threat.var_8d4eec98, self.botsettings.var_647e63de, self.botsettings.var_b755d2a0, self.botsettings.var_6bab2b39, self.botsettings.var_d038cb92);
        self function_dc473bdb();
    }
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0xf906a30b, Offset: 0x15b0
// Size: 0xb8
function function_54cd01e1(entity) {
    if (issentient(entity) && randomint(100) < (isdefined(level.botsettings.var_4a127efb) ? level.botsettings.var_4a127efb : 0)) {
        return (entity geteye() - entity.origin);
    }
    return entity getcentroid() - entity.origin;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x894dc0a8, Offset: 0x1670
// Size: 0x1f4
function function_927ae397() {
    if (!isdefined(self.bot.threat.aimstarttime)) {
        self function_2eb14b34();
    }
    var_3639d67 = gettime() - self.bot.threat.aimstarttime;
    if (var_3639d67 < 0) {
        return;
    }
    if (var_3639d67 >= self.bot.threat.var_3639d67 || !isdefined(self.bot.threat.var_facee39e)) {
        self botlookatpoint(self.bot.threat.aimpoint);
        return;
    }
    eyepoint = self geteye();
    var_ad12f93d = vectortoangles(self.bot.threat.aimpoint - eyepoint);
    var_b511cbdb = var_ad12f93d + self.bot.threat.var_facee39e;
    var_cb769ff9 = vectorlerp(var_b511cbdb, var_ad12f93d, var_3639d67 / self.bot.threat.var_3639d67);
    playerangles = self getplayerangles();
    self botsetlookangles(anglestoforward(var_cb769ff9));
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0xd75065e7, Offset: 0x1870
// Size: 0x19c
function function_2eb14b34() {
    self.bot.threat.aimstarttime = gettime() + (isdefined(level.botsettings.var_e2d09e81) ? level.botsettings.var_e2d09e81 : 0) * 1000;
    self.bot.threat.var_3639d67 = (isdefined(level.botsettings.var_3639d67) ? level.botsettings.var_3639d67 : 0) * 1000;
    pitcherror = function_fc294b50(isdefined(level.botsettings.var_4060ed34) ? level.botsettings.var_4060ed34 : 0, isdefined(level.botsettings.var_b8a6c7f6) ? level.botsettings.var_b8a6c7f6 : 0);
    yawerror = function_fc294b50(isdefined(level.botsettings.var_be38a373) ? level.botsettings.var_be38a373 : 0, isdefined(level.botsettings.var_97c3da75) ? level.botsettings.var_97c3da75 : 0);
    self.bot.threat.var_facee39e = (pitcherror, yawerror, 0);
}

// Namespace namespace_5cd60c9f
// Params 2, eflags: 0x1 linked
// Checksum 0xff5424a3, Offset: 0x1a18
// Size: 0x86
function function_fc294b50(anglemin, anglemax) {
    angle = anglemax - anglemin;
    angle *= randomfloatrange(-1, 1);
    if (angle < 0) {
        angle -= anglemin;
    } else {
        angle += anglemin;
    }
    return angle;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0xd30a5d1b, Offset: 0x1aa8
// Size: 0x6a
function function_77c0a2f5() {
    if (!isdefined(self.bot.threat.aimstarttime)) {
        return;
    }
    self.bot.threat.aimstarttime = undefined;
    self.bot.threat.var_3639d67 = undefined;
    self.bot.threat.var_facee39e = undefined;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x74e72767, Offset: 0x1b20
// Size: 0x164
function function_9fd498fd() {
    if (self function_231137e6()) {
        return;
    }
    if (isdefined(self.bot.damage.time) && self.bot.damage.time + 1500 > gettime()) {
        if (self function_231137e6() && self.bot.damage.time > self.bot.threat.var_d9d24b9e) {
            self function_dc473bdb();
        }
        self bot::function_2e1b3e51(self.bot.damage.attackdir, level.botsettings.var_8d20da7, level.botsettings.var_ae2c2f19, level.botsettings.var_37c4a030, level.botsettings.var_f8a87229);
        self bot::function_e20cd351();
        self function_4d9b8f48();
    }
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1c90
// Size: 0x4
function function_b5eda34() {
    
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x311bb27f, Offset: 0x1ca0
// Size: 0x104
function function_22db31d2() {
    if (!self.bot.threat.inrange || self.bot.threat.incloserange) {
        return;
    }
    weapon = self getcurrentweapon();
    if (weapon == level.weaponnone || weapon.isdualwield || weapon.weapclass == "melee" || self getweaponammoclip(weapon) <= 0) {
        return;
    }
    if (self.bot.threat.dot < function_93200106(weapon)) {
        return;
    }
    self bot::function_f1371fe4();
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0xf6d0e3a5, Offset: 0x1db0
// Size: 0xfe
function function_93200106(weapon) {
    if (weapon.issniperweapon) {
        return level.botsettings.var_af3c8082;
    } else if (weapon.isrocketlauncher) {
        return level.botsettings.var_b3027019;
    }
    switch (weapon.weapclass) {
    case "mg":
        return level.botsettings.var_6252ec2d;
    case "smg":
        return level.botsettings.var_340e5772;
    case "spread":
        return level.botsettings.var_93302b16;
    case "pistol":
        return level.botsettings.var_c6ecad86;
    case "rifle":
        return level.botsettings.var_3e3d8939;
    }
    return level.botsettings.var_57b2f18e;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0x4d88569, Offset: 0x1eb8
// Size: 0xfe
function function_defc094(weapon) {
    if (weapon.issniperweapon) {
        return level.botsettings.var_44f8d8f8;
    } else if (weapon.isrocketlauncher) {
        return level.botsettings.var_b2766c99;
    }
    switch (weapon.weapclass) {
    case "mg":
        return level.botsettings.var_c74525ad;
    case "smg":
        return level.botsettings.var_49190448;
    case "spread":
        return level.botsettings.var_ddd241cc;
    case "pistol":
        return level.botsettings.var_ea95749c;
    case "rifle":
        return level.botsettings.var_ad5ca539;
    }
    return level.botsettings.var_87be8d44;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0x45b8fe45, Offset: 0x1fc0
// Size: 0xfe
function function_a54977ff(weapon) {
    if (weapon.issniperweapon) {
        return level.botsettings.var_26f95cb;
    } else if (weapon.isrocketlauncher) {
        return level.botsettings.var_a6d4f494;
    }
    switch (weapon.weapclass) {
    case "mg":
        return level.botsettings.var_72e3f6b8;
    case "smg":
        return level.botsettings.var_19cebd7b;
    case "spread":
        return level.botsettings.var_c70636af;
    case "pistol":
        return level.botsettings.var_db430edf;
    case "rifle":
        return level.botsettings.var_bd6449b4;
    }
    return level.botsettings.var_367bd117;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0xb3567cd3, Offset: 0x20c8
// Size: 0xfe
function function_eff9244e(weapon) {
    if (weapon.issniperweapon) {
        return level.botsettings.var_a69620c5;
    } else if (weapon.isrocketlauncher) {
        return level.botsettings.var_fe2d7320;
    }
    switch (weapon.weapclass) {
    case "mg":
        return level.botsettings.var_8da5d014;
    case "smg":
        return level.botsettings.var_58c8baf5;
    case "spread":
        return level.botsettings.var_43825ba9;
    case "pistol":
        return level.botsettings.var_8987a1d9;
    case "rifle":
        return level.botsettings.var_b84b40c0;
    }
    return level.botsettings.var_ec8dbb61;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x6e5f8073, Offset: 0x21d0
// Size: 0x35a
function switch_weapon() {
    currentweapon = self getcurrentweapon();
    if (self isswitchingweapons() || currentweapon.isheroweapon || currentweapon.isitem) {
        return false;
    }
    weapon = bot::function_506b3702();
    if (weapon != level.weaponnone) {
        if (!isdefined(level.enemyempactive) || !self [[ level.enemyempactive ]]()) {
            self bot::function_cf8f9518(weapon);
            return true;
        }
    }
    weapons = self getweaponslistprimaries();
    if (currentweapon == level.weaponnone || currentweapon.weapclass == "melee" || currentweapon.weapclass == "rocketLauncher" || currentweapon.weapclass == "pistol") {
        foreach (weapon in weapons) {
            if (weapon == currentweapon) {
                continue;
            }
            if (self getweaponammoclip(weapon) || self getweaponammostock(weapon)) {
                self botswitchtoweapon(weapon);
                return true;
            }
        }
        return false;
    }
    currentammostock = self getweaponammostock(currentweapon);
    if (currentammostock) {
        return false;
    }
    var_82ffdeb5 = 0.3;
    var_6f414386 = self function_68881ee1(currentweapon);
    if (var_6f414386 > var_82ffdeb5) {
        return false;
    }
    foreach (weapon in weapons) {
        if (self getweaponammostock(weapon) || self function_68881ee1(weapon) > var_82ffdeb5) {
            self botswitchtoweapon(weapon);
            return true;
        }
    }
    return false;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0xe97da6c4, Offset: 0x2538
// Size: 0x24a
function function_e891ab0f() {
    currentweapon = self getcurrentweapon();
    if (self isswitchingweapons() || self getweaponammoclip(currentweapon) || currentweapon.isitem) {
        return;
    }
    currentammostock = self getweaponammostock(currentweapon);
    weapons = self getweaponslistprimaries();
    foreach (weapon in weapons) {
        if (weapon == currentweapon || weapon.requirelockontofire) {
            continue;
        }
        if (weapon.weapclass == "melee") {
            if (currentammostock && randomintrange(0, 100) < 75) {
                continue;
            }
        } else {
            if (!self getweaponammoclip(weapon) && currentammostock) {
                continue;
            }
            var_15c214df = self getweaponammostock(weapon);
            if (!currentammostock && !var_15c214df) {
                continue;
            }
            if (weapon.weapclass != "pistol" && randomintrange(0, 100) < 75) {
                continue;
            }
        }
        self botswitchtoweapon(weapon);
    }
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0xfe651764, Offset: 0x2790
// Size: 0xcc
function reload_weapon() {
    weapon = self getcurrentweapon();
    if (!self getweaponammostock(weapon)) {
        return false;
    }
    var_7769c8e6 = 0.5;
    if (weapon.weapclass == "mg") {
        var_7769c8e6 = 0.25;
    }
    if (self function_68881ee1(weapon) < var_7769c8e6) {
        self bot::function_14cf6d8f();
        return true;
    }
    return false;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0xf355a527, Offset: 0x2868
// Size: 0x64
function function_68881ee1(weapon) {
    if (weapon.clipsize <= 0) {
        return 1;
    }
    clipammo = self getweaponammoclip(weapon);
    return clipammo / weapon.clipsize;
}

// Namespace namespace_5cd60c9f
// Params 2, eflags: 0x1 linked
// Checksum 0xf6fbde65, Offset: 0x28d8
// Size: 0xdc
function throw_grenade(weapon, target) {
    if (!isdefined(self.bot.threat.aimstarttime)) {
        self function_e30e47e3(weapon, target);
        self function_c4fdfd68(weapon);
        return;
    }
    if (self.bot.threat.aimstarttime + self.bot.threat.var_3639d67 > gettime()) {
        return;
    }
    if (self function_2389cc09(weapon, target)) {
        return;
    }
    self function_c4fdfd68(weapon);
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0xfe18d520, Offset: 0x29c0
// Size: 0x5c
function function_c4fdfd68(weapon) {
    if (weapon == self.grenadetypeprimary) {
        self bot::function_9f451aa4();
        return;
    }
    if (weapon == self.grenadetypesecondary) {
        self bot::function_edc9063e();
    }
}

// Namespace namespace_5cd60c9f
// Params 2, eflags: 0x1 linked
// Checksum 0x1ca88626, Offset: 0x2a28
// Size: 0x84
function function_e30e47e3(weapon, target) {
    var_89e7d1c5 = target + (0, 0, 100);
    self.bot.threat.aimstarttime = gettime();
    self.bot.threat.var_3639d67 = 1500;
    self function_546ecee9(var_89e7d1c5);
}

// Namespace namespace_5cd60c9f
// Params 2, eflags: 0x1 linked
// Checksum 0x88297306, Offset: 0x2ab8
// Size: 0x158
function function_2389cc09(weapon, target) {
    velocity = function_cead22d0(weapon);
    var_fedb5399 = self geteye();
    var_c8bf42bc = distance2d(var_fedb5399, target);
    var_b9b9351d = distance2d(velocity, (0, 0, 0));
    t = var_c8bf42bc / var_b9b9351d;
    gravity = getdvarfloat("bg_gravity") * -1;
    var_b33a49b2 = var_fedb5399[2] + velocity[2] * t + gravity * t * t * 0.5;
    return abs(var_b33a49b2 - target[2]) < 20;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// Checksum 0x1b6210cd, Offset: 0x2c18
// Size: 0x5a
function function_cead22d0(weapon) {
    angles = self getplayerangles();
    forward = anglestoforward(angles);
    return forward * 928;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x0
// Checksum 0x78dbad39, Offset: 0x2c80
// Size: 0xda
function function_e72f9013() {
    weaponslist = self getweaponslist();
    foreach (weapon in weaponslist) {
        if (weapon.type == "grenade" && self getweaponammostock(weapon)) {
            return weapon;
        }
    }
    return level.weaponnone;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x227b42da, Offset: 0x2d68
// Size: 0x194
function function_75cfa67f() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        damage, attacker, direction, point, mod, unused1, var_f35b000f, var_cd5885a6, weapon, flags, inflictor = self waittill(#"damage");
        self.bot.damage.entity = attacker;
        self.bot.damage.amount = damage;
        self.bot.damage.attackdir = vectornormalize(attacker.origin - self.origin);
        self.bot.damage.weapon = weapon;
        self.bot.damage.mod = mod;
        self.bot.damage.time = gettime();
        self thread [[ level.var_694f5886 ]]();
    }
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// Checksum 0x3923b7d8, Offset: 0x2f08
// Size: 0x92
function function_4d9b8f48() {
    self.bot.damage.entity = undefined;
    self.bot.damage.amount = undefined;
    self.bot.damage.direction = undefined;
    self.bot.damage.weapon = undefined;
    self.bot.damage.mod = undefined;
    self.bot.damage.time = undefined;
}

// Namespace namespace_5cd60c9f
// Params 5, eflags: 0x1 linked
// Checksum 0x5510f30c, Offset: 0x2fa8
// Size: 0x394
function function_191f4091(radiusmin, radiusmax, spacing, var_a968cf17, var_8bf93a69) {
    if (!isdefined(radiusmin)) {
        radiusmin = isdefined(level.botsettings.var_56731c28) ? level.botsettings.var_56731c28 : 0;
    }
    if (!isdefined(radiusmax)) {
        radiusmax = isdefined(level.botsettings.var_716847d6) ? level.botsettings.var_716847d6 : 0;
    }
    if (!isdefined(spacing)) {
        spacing = isdefined(level.botsettings.var_141b3f07) ? level.botsettings.var_141b3f07 : 0;
    }
    if (!isdefined(var_a968cf17)) {
        var_a968cf17 = isdefined(level.botsettings.var_b59415a) ? level.botsettings.var_b59415a : 0;
    }
    if (!isdefined(var_8bf93a69)) {
        var_8bf93a69 = isdefined(level.botsettings.var_e0c73614) ? level.botsettings.var_e0c73614 : 0;
    }
    fwd = anglestoforward(self.angles);
    /#
    #/
    queryresult = positionquery_source_navigation(self.origin, radiusmin, radiusmax, 64, spacing, self);
    best_point = undefined;
    foreach (point in queryresult.data) {
        movedir = vectornormalize(point.origin - self.origin);
        dot = vectordot(movedir, fwd);
        if (dot >= var_a968cf17 && dot <= var_8bf93a69) {
            point.score = mapfloat(radiusmin, radiusmax, 0, 50, point.disttoorigin2d);
            point.score += randomfloatrange(0, 50);
        }
        /#
        #/
        if (!isdefined(best_point) || point.score > best_point.score) {
            best_point = point;
        }
    }
    if (isdefined(best_point)) {
        /#
        #/
        self function_b4a0b3c5(best_point.origin);
        self bot::function_e20cd351();
    }
}

