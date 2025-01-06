#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/entityheadicons_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace decoy;

// Namespace decoy
// Params 0, eflags: 0x0
// Checksum 0xc7475156, Offset: 0x240
// Size: 0xdc
function init_shared() {
    level.var_69dcf9aa = [];
    level.var_69dcf9aa["fullauto"] = [];
    level.var_69dcf9aa["semiauto"] = [];
    level.var_69dcf9aa["fullauto"][level.var_69dcf9aa["fullauto"].size] = getweapon("ar_accurate");
    level.var_69dcf9aa["semiauto"][level.var_69dcf9aa["semiauto"].size] = getweapon("pistol_standard");
    callback::function_367a33a8(&function_590a0ae0);
}

// Namespace decoy
// Params 0, eflags: 0x0
// Checksum 0x69cd926c, Offset: 0x328
// Size: 0x88
function function_590a0ae0() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("nightingale", self.team);
    watcher.onspawn = &on_spawn;
    watcher.ondetonatecallback = &detonate;
    watcher.deleteondifferentobjectspawn = 0;
    watcher.headicon = 0;
}

// Namespace decoy
// Params 2, eflags: 0x0
// Checksum 0xbd5ce5c2, Offset: 0x3b8
// Size: 0x12c
function on_spawn(watcher, owner) {
    owner endon(#"disconnect");
    self endon(#"death");
    weaponobjects::onspawnuseweaponobject(watcher, owner);
    self.var_8d009e7f = self getvelocity();
    delay = 1;
    wait delay;
    var_ac1978dd = 30;
    spawn_time = gettime();
    owner addweaponstat(self.weapon, "used", 1);
    self thread function_a63701dd(owner);
    while (true) {
        if (gettime() > spawn_time + var_ac1978dd * 1000) {
            self destroy(watcher, owner);
            return;
        }
        wait 0.05;
    }
}

// Namespace decoy
// Params 5, eflags: 0x0
// Checksum 0x8621b3e, Offset: 0x4f0
// Size: 0x2d4
function move(owner, count, fire_time, var_8195a6f6, var_34e933d5) {
    self endon(#"death");
    self endon(#"done");
    if (!self isonground()) {
        return;
    }
    min_speed = 100;
    max_speed = -56;
    var_a9020b51 = 100;
    var_f2ed6233 = -56;
    var_77e994f4 = randomintrange(var_8195a6f6 - var_34e933d5, var_8195a6f6 + var_34e933d5);
    var_c1306e47 = (randomfloatrange(800, 1800) * (randomintrange(0, 2) * 2 - 1), 0, randomfloatrange(580, 940) * (randomintrange(0, 2) * 2 - 1));
    var_7068061a = randomfloatrange(var_a9020b51, var_f2ed6233);
    start_time = gettime();
    gravity = getdvarint("bg_gravity");
    for (i = 0; i < 1; i++) {
        angles = (0, randomintrange(var_77e994f4 - var_34e933d5, var_77e994f4 + var_34e933d5), 0);
        dir = anglestoforward(angles);
        dir = vectorscale(dir, randomfloatrange(min_speed, max_speed));
        deltatime = (gettime() - start_time) * 0.001;
        up = (0, 0, var_7068061a - 800 * deltatime);
        self launch(dir + up, var_c1306e47);
        wait fire_time;
    }
}

// Namespace decoy
// Params 2, eflags: 0x0
// Checksum 0xc401c86c, Offset: 0x7d0
// Size: 0x3c
function destroy(watcher, owner) {
    self notify(#"done");
    self entityheadicons::setentityheadicon("none");
}

// Namespace decoy
// Params 3, eflags: 0x0
// Checksum 0xb9d2828e, Offset: 0x818
// Size: 0x44
function detonate(attacker, weapon, target) {
    self notify(#"done");
    self entityheadicons::setentityheadicon("none");
}

// Namespace decoy
// Params 1, eflags: 0x0
// Checksum 0x6c51e50d, Offset: 0x868
// Size: 0x1a6
function function_a63701dd(owner) {
    owner endon(#"disconnect");
    self endon(#"death");
    self endon(#"done");
    weapon = function_b3d79ba3();
    self thread function_dba6f0ce(owner, weapon);
    self thread function_96634b70();
    self.var_34e933d5 = 30;
    weapon_class = util::getweaponclass(weapon);
    switch (weapon_class) {
    case "weapon_assault":
    case "weapon_cqb":
    case "weapon_hmg":
    case "weapon_lmg":
    case "weapon_smg":
        function_9d51e5e4(owner, weapon);
        break;
    case "weapon_sniper":
        function_3bf90541(owner, weapon);
        break;
    case "weapon_pistol":
        function_fcf76115(owner, weapon);
        break;
    case "weapon_shotgun":
        function_2d9e373e(owner, weapon);
        break;
    default:
        function_9d51e5e4(owner, weapon);
        break;
    }
}

// Namespace decoy
// Params 2, eflags: 0x0
// Checksum 0xfc2f3047, Offset: 0xa18
// Size: 0x64
function function_9d51e5e4(owner, weapon) {
    if (weapon.issemiauto) {
        function_c67d522d(owner, weapon);
        return;
    }
    function_660c06fa(owner, weapon);
}

// Namespace decoy
// Params 2, eflags: 0x0
// Checksum 0x9a06b8c9, Offset: 0xa88
// Size: 0x158
function function_c67d522d(owner, weapon) {
    clipsize = weapon.clipsize;
    firetime = weapon.firetime;
    reloadtime = weapon.reloadtime;
    var_ea3aa22e = 4;
    var_7cc2c3d0 = 10;
    while (true) {
        if (clipsize <= 1) {
            var_935b3a39 = 1;
        } else {
            var_935b3a39 = randomintrange(1, clipsize);
        }
        self thread move(owner, var_935b3a39, firetime, self.var_8195a6f6, self.var_34e933d5);
        self fire_burst(owner, weapon, firetime, var_935b3a39, 1);
        function_73d0b1f3(weapon, reloadtime, var_ea3aa22e, var_7cc2c3d0);
    }
}

// Namespace decoy
// Params 2, eflags: 0x0
// Checksum 0x4fed54e5, Offset: 0xbe8
// Size: 0x140
function function_fcf76115(owner, weapon) {
    clipsize = weapon.clipsize;
    firetime = weapon.firetime;
    reloadtime = weapon.reloadtime;
    var_ea3aa22e = 0.5;
    var_7cc2c3d0 = 4;
    while (true) {
        var_935b3a39 = randomintrange(1, clipsize);
        self thread move(owner, var_935b3a39, firetime, self.var_8195a6f6, self.var_34e933d5);
        self fire_burst(owner, weapon, firetime, var_935b3a39, 0);
        function_73d0b1f3(weapon, reloadtime, var_ea3aa22e, var_7cc2c3d0);
    }
}

// Namespace decoy
// Params 2, eflags: 0x0
// Checksum 0xe711d714, Offset: 0xd30
// Size: 0x158
function function_2d9e373e(owner, weapon) {
    clipsize = weapon.clipsize;
    firetime = weapon.firetime;
    reloadtime = weapon.reloadtime;
    if (clipsize > 2) {
        clipsize = 2;
    }
    var_ea3aa22e = 0.5;
    var_7cc2c3d0 = 4;
    while (true) {
        var_935b3a39 = randomintrange(1, clipsize);
        self thread move(owner, var_935b3a39, firetime, self.var_8195a6f6, self.var_34e933d5);
        self fire_burst(owner, weapon, firetime, var_935b3a39, 0);
        function_73d0b1f3(weapon, reloadtime, var_ea3aa22e, var_7cc2c3d0);
    }
}

// Namespace decoy
// Params 2, eflags: 0x0
// Checksum 0x12cbb3c7, Offset: 0xe90
// Size: 0x180
function function_660c06fa(owner, weapon) {
    clipsize = weapon.clipsize;
    firetime = weapon.firetime;
    reloadtime = weapon.reloadtime;
    if (clipsize > 30) {
        clipsize = 30;
    }
    var_ea3aa22e = 2;
    var_7cc2c3d0 = 6;
    while (true) {
        var_935b3a39 = randomintrange(int(clipsize * 0.6), clipsize);
        interrupt = 0;
        self thread move(owner, var_935b3a39, firetime, self.var_8195a6f6, self.var_34e933d5);
        self fire_burst(owner, weapon, firetime, var_935b3a39, interrupt);
        function_73d0b1f3(weapon, reloadtime, var_ea3aa22e, var_7cc2c3d0);
    }
}

// Namespace decoy
// Params 2, eflags: 0x0
// Checksum 0xd88cbb05, Offset: 0x1018
// Size: 0x150
function function_3bf90541(owner, weapon) {
    clipsize = weapon.clipsize;
    firetime = weapon.firetime;
    reloadtime = weapon.reloadtime;
    if (clipsize > 2) {
        clipsize = 2;
    }
    var_ea3aa22e = 3;
    var_7cc2c3d0 = 5;
    while (true) {
        var_935b3a39 = randomintrange(1, clipsize);
        self thread move(owner, var_935b3a39, firetime, self.var_8195a6f6, self.var_34e933d5);
        self fire_burst(owner, weapon, firetime, var_935b3a39, 0);
        function_73d0b1f3(weapon, reloadtime, var_ea3aa22e, var_7cc2c3d0);
    }
}

// Namespace decoy
// Params 5, eflags: 0x0
// Checksum 0x12b29e4f, Offset: 0x1170
// Size: 0xfe
function fire_burst(owner, weapon, firetime, count, interrupt) {
    var_5e25e2cd = count;
    if (interrupt) {
        var_5e25e2cd = int(count * randomfloatrange(0.6, 0.8));
    }
    self fakefire(owner, self.origin, weapon, var_5e25e2cd);
    wait firetime * var_5e25e2cd;
    if (interrupt) {
        self fakefire(owner, self.origin, weapon, count - var_5e25e2cd);
        wait firetime * (count - var_5e25e2cd);
    }
}

// Namespace decoy
// Params 4, eflags: 0x0
// Checksum 0xc5b877e2, Offset: 0x1278
// Size: 0x74
function function_73d0b1f3(weapon, reloadtime, var_ea3aa22e, var_7cc2c3d0) {
    if (function_16cd8fc7()) {
        function_50198ce0(weapon, reloadtime);
        return;
    }
    wait randomfloatrange(var_ea3aa22e, var_7cc2c3d0);
}

// Namespace decoy
// Params 2, eflags: 0x0
// Checksum 0x5d8dceb4, Offset: 0x12f8
// Size: 0x82
function function_50198ce0(weapon, reloadtime) {
    var_d7706c7 = (reloadtime - 0.1) / 2;
    wait 0.1;
    self playsound("fly_assault_reload_npc_mag_out");
    wait var_d7706c7;
    self playsound("fly_assault_reload_npc_mag_in");
    wait var_d7706c7;
}

// Namespace decoy
// Params 2, eflags: 0x0
// Checksum 0x8121e9e5, Offset: 0x1388
// Size: 0x9c
function function_dba6f0ce(owner, weapon) {
    self thread function_547d67b1();
    owner endon(#"disconnect");
    self endon(#"hash_deb9ad6f");
    self waittill(#"explode", pos);
    level thread do_explosion(owner, pos, weapon, randomintrange(5, 10));
}

// Namespace decoy
// Params 0, eflags: 0x0
// Checksum 0x27cbd27d, Offset: 0x1430
// Size: 0x2e
function function_547d67b1() {
    self waittill(#"death");
    wait 0.1;
    if (isdefined(self)) {
        self notify(#"hash_deb9ad6f");
    }
}

// Namespace decoy
// Params 4, eflags: 0x0
// Checksum 0xf18c82df, Offset: 0x1468
// Size: 0x14e
function do_explosion(owner, pos, weapon, count) {
    var_fc4df9ff = 100;
    var_5f58e301 = 500;
    for (i = 0; i < count; i++) {
        wait randomfloatrange(0.1, 0.5);
        offset = (randomfloatrange(var_fc4df9ff, var_5f58e301) * (randomintrange(0, 2) * 2 - 1), randomfloatrange(var_fc4df9ff, var_5f58e301) * (randomintrange(0, 2) * 2 - 1), 0);
        owner fakefire(owner, pos + offset, weapon, 1);
    }
}

// Namespace decoy
// Params 0, eflags: 0x0
// Checksum 0xb1f6d0e4, Offset: 0x15c0
// Size: 0xd6
function function_b3d79ba3() {
    type = "fullauto";
    if (randomintrange(0, 10) < 3) {
        type = "semiauto";
    }
    randomval = randomintrange(0, level.var_69dcf9aa[type].size);
    println("<dev string:x28>" + type + "<dev string:x35>" + level.var_69dcf9aa[type][randomval].name);
    return level.var_69dcf9aa[type][randomval];
}

// Namespace decoy
// Params 0, eflags: 0x0
// Checksum 0xac62a783, Offset: 0x16a0
// Size: 0x2c
function function_16cd8fc7() {
    if (randomintrange(0, 5) == 1) {
        return true;
    }
    return false;
}

// Namespace decoy
// Params 0, eflags: 0x0
// Checksum 0x96bf3906, Offset: 0x16d8
// Size: 0x130
function function_96634b70() {
    self endon(#"death");
    self endon(#"done");
    self.var_8195a6f6 = int(vectortoangles((self.var_8d009e7f[0], self.var_8d009e7f[1], 0))[1]);
    up = (0, 0, 1);
    while (true) {
        self waittill(#"grenade_bounce", pos, normal);
        dot = vectordot(normal, up);
        if (dot < 0.5 && dot > -0.5) {
            self.var_8195a6f6 = int(vectortoangles((normal[0], normal[1], 0))[1]);
        }
    }
}

