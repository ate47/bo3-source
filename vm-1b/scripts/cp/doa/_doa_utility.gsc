#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/util_shared;

#namespace namespace_49107f3a;

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x91883edc, Offset: 0x3a8
// Size: 0x67
function function_4e9a23a9(array) {
    for (i = 0; i < array.size; i++) {
        j = randomint(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x0
// Checksum 0x79aab553, Offset: 0x418
// Size: 0x52
function isheadshot(sweapon, shitloc, smeansofdeath) {
    return (shitloc == "head" || shitloc == "helmet") && smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_BAYONET" && smeansofdeath != "MOD_IMPACT";
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x8842e2d3, Offset: 0x478
// Size: 0x49
function isexplosivedamage(damage_mod) {
    if (damage_mod == "MOD_GRENADE" || damage_mod == "MOD_GRENADE_SPLASH" || damage_mod == "MOD_PROJECTILE" || damage_mod == "MOD_PROJECTILE_SPLASH" || damage_mod == "MOD_EXPLOSIVE") {
        return true;
    }
    return false;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x8d9a21bc, Offset: 0x4d0
// Size: 0x3e
function function_767f35f5(mod) {
    return mod == "MOD_PROJECTILE" || isdefined(self.damageweapon) && self.damageweapon == "zombietron_tesla_gun" && mod == "MOD_PROJECTILE_SPLASH";
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0xbe555f03, Offset: 0x518
// Size: 0xcf
function stringtofloat(string) {
    var_afc525ad = strtok(string, ".");
    if (var_afc525ad.size == 1) {
        return int(var_afc525ad[0]);
    }
    var_6e31c636 = int(var_afc525ad[0]);
    decimal = 0;
    for (i = var_afc525ad[1].size - 1; i >= 0; i--) {
        decimal = decimal / 10 + int(var_afc525ad[1][i]) / 10;
    }
    if (var_6e31c636 >= 0) {
        return (var_6e31c636 + decimal);
    }
    return var_6e31c636 - decimal;
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0x41843a4d, Offset: 0x5f0
// Size: 0x29
function function_124b9a08() {
    while (true) {
        if (level flag::get("doa_round_active")) {
            return;
        }
        wait 0.05;
    }
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0x62c97e98, Offset: 0x628
// Size: 0x29
function function_c8f4d63a() {
    while (level flag::get("doa_bonusroom_active")) {
        wait 0.05;
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x6e7390dc, Offset: 0x660
// Size: 0x69
function function_d0e32ad0(state) {
    if (state == 1) {
        while (!level flag::get("doa_screen_faded_out")) {
            wait 0.05;
        }
        return;
    }
    if (state == 0) {
        while (level flag::get("doa_screen_faded_out")) {
            wait 0.05;
        }
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x742b3e87, Offset: 0x6d8
// Size: 0x1a
function function_44eb090b(time) {
    function_a5821e05(time);
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0xe21dc674, Offset: 0x700
// Size: 0x32
function function_390adefe(unfreeze) {
    if (!isdefined(unfreeze)) {
        unfreeze = 1;
    }
    function_c85960dd(1.2, unfreeze);
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0xd2a6e3fe, Offset: 0x740
// Size: 0xf2
function function_a5821e05(time) {
    if (!isdefined(time)) {
        time = 1;
    }
    level.var_a7749866 = gettime();
    level thread function_1d62c13a();
    level thread function_d0c69425(12);
    foreach (player in getplayers()) {
        player freezecontrols(1);
        player thread doa_player_utility::function_4519b17(1);
    }
    level lui::screen_fade_out(time, "black");
    wait time;
    level notify(#"hash_96377490");
    level flag::set("doa_screen_faded_out");
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0xee4e3546, Offset: 0x840
// Size: 0x149
function function_c85960dd(hold_black_time, unfreeze) {
    if (!isdefined(hold_black_time)) {
        hold_black_time = 1.2;
    }
    if (!isdefined(unfreeze)) {
        unfreeze = 1;
    }
    wait hold_black_time;
    foreach (player in getplayers()) {
        player notify(#"killInitialBlack");
    }
    level lui::screen_fade_in(1.5);
    if (unfreeze) {
        foreach (player in getplayers()) {
            player freezecontrols(0);
            player thread doa_player_utility::function_4519b17(0);
        }
    }
    level notify(#"hash_dec47e9f");
    level flag::clear("doa_screen_faded_out");
    level.var_a7749866 = undefined;
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0x52ec24f5, Offset: 0x998
// Size: 0x7a
function function_1d62c13a() {
    level endon(#"hash_dec47e9f");
    while (isdefined(level.var_a7749866)) {
        if (level flag::get("doa_game_is_over")) {
            return;
        }
        if (level flag::get("doa_round_spawning")) {
            break;
        }
        wait 0.05;
    }
    debugmsg("FullscreenBlack FAILSAFE [Round Active]");
    level thread function_c85960dd();
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0xb2f288cc, Offset: 0xa20
// Size: 0x6a
function function_d0c69425(waitsec) {
    level endon(#"hash_dec47e9f");
    timeout = gettime() + waitsec * 1000;
    while (isdefined(level.var_a7749866) && gettime() < timeout) {
        wait 0.05;
    }
    debugmsg("FullscreenBlack FAILSAFE [Timeout]");
    level thread function_c85960dd();
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x0
// Checksum 0xe70aed70, Offset: 0xa98
// Size: 0x59
function function_5ee38fe3(origin, &entarray, maxdist) {
    if (!isdefined(maxdist)) {
        maxdist = 2048;
    }
    if (!isdefined(entarray)) {
        return;
    }
    if (entarray.size == 0) {
        return;
    }
    if (entarray.size == 1) {
        return entarray[0];
    }
    return arraygetclosest(origin, entarray, maxdist);
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x0
// Checksum 0xfb4d42d, Offset: 0xb00
// Size: 0x99
function function_a7eabaf(origin, &entarray, var_d16f4517) {
    items = [];
    if (isdefined(entarray) && entarray.size) {
        for (i = 0; i < entarray.size; i++) {
            if (!isdefined(entarray[i])) {
                continue;
            }
            distsq = distancesquared(entarray[i].origin, origin);
            if (distsq < var_d16f4517) {
                items[items.size] = entarray[i];
            }
        }
    }
    return items;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0xc47d55d2, Offset: 0xba8
// Size: 0x21
function function_1bfb2259(&entarray) {
    return function_5ee38fe3(self.origin, entarray);
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0x970194de, Offset: 0xbd8
// Size: 0x6a
function function_999bba85(origin, time) {
    self moveto(origin, time, 0, 0);
    wait time;
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x0
// Checksum 0xbec263c8, Offset: 0xc50
// Size: 0xcd
function function_fa1ff28d(note, time_left, var_903752e9) {
    if (!isdefined(var_903752e9)) {
        var_903752e9 = 0;
    }
    if (isplayer(self)) {
        self endon(#"disconnect");
        self endon(#"death");
    }
    if (isactor(self)) {
        self endon(#"death");
    }
    while (time_left > 0) {
        var_4a91cb76 = self util::waittill_any_timeout(1, note);
        if (note == var_4a91cb76) {
            return;
        }
        if (!(isdefined(level.doa.var_6f2c52d8) && var_903752e9 && level.doa.var_6f2c52d8)) {
            time_left -= 1;
        }
    }
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0x3a5780cb, Offset: 0xd28
// Size: 0x23
function function_80409246(note, timeout) {
    self endon(#"death");
    wait timeout;
    self notify(note);
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x0
// Checksum 0xeb9361bd, Offset: 0xd58
// Size: 0x44
function clamp(val, min, max) {
    if (isdefined(min)) {
        if (val < min) {
            val = min;
        }
    }
    if (isdefined(max)) {
        if (val > max) {
            val = max;
        }
    }
    return val;
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0x504c2107, Offset: 0xda8
// Size: 0x92
function function_75e76155(other, note) {
    self endon(#"death");
    if (!isdefined(other)) {
        return;
    }
    if (isplayer(other)) {
        if (note == "disconnect") {
            other util::waittill_any(note);
        } else {
            other util::waittill_any(note, "disconnect");
        }
    } else {
        other waittill(note);
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0xd755be57, Offset: 0xe48
// Size: 0x2e
function function_cd8b3ae0(player, note) {
    self endon(#"death");
    player waittill(note);
    if (isdefined(self)) {
        self notify(note, player);
    }
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0xb3b834dc, Offset: 0xe80
// Size: 0x6a
function function_783519c1(note, var_8b804bd9) {
    if (!isdefined(var_8b804bd9)) {
        var_8b804bd9 = 0;
    }
    self endon(#"death");
    if (!var_8b804bd9) {
        self waittill(note);
    } else {
        level waittill(note);
    }
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self delete();
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0xe165fc8a, Offset: 0xef8
// Size: 0x4a
function function_1bd67aef(time) {
    self endon(#"death");
    wait time;
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self delete();
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0xebc46b4b, Offset: 0xf50
// Size: 0x52
function function_981c685d(var_627e7613) {
    self endon(#"death");
    var_627e7613 waittill(#"death");
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self delete();
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x6b9e389a, Offset: 0xfb0
// Size: 0x5a
function function_a625b5d3(player) {
    assert(isplayer(player), "<dev string:x28>");
    self endon(#"death");
    player waittill(#"disconnect");
    self delete();
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0x60d54dee, Offset: 0x1018
// Size: 0x1d
function function_c157030a() {
    while (function_b99d78c7() > 0) {
        wait 1;
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x748f140c, Offset: 0x1040
// Size: 0x41
function function_1ced251e(all) {
    if (!isdefined(all)) {
        all = 0;
    }
    while (function_b99d78c7() > 0) {
        function_f798b582(all);
        wait 1;
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0xcec5462b, Offset: 0x1090
// Size: 0x95
function function_2f0d697f(spawner) {
    count = 0;
    ai = function_fb2ad2fb();
    foreach (guy in ai) {
        if (isdefined(guy.spawner) && guy.spawner == spawner) {
            count++;
        }
    }
    return count;
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0x95f62b7c, Offset: 0x1130
// Size: 0x4f
function function_b99d78c7() {
    var_594dffdc = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
    return var_594dffdc.size;
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0xf933c795, Offset: 0x1188
// Size: 0x41
function function_fb2ad2fb() {
    return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x55224279, Offset: 0x11d8
// Size: 0x107
function function_f798b582(all) {
    if (!isdefined(all)) {
        all = 0;
    }
    var_54a85fb0 = 4;
    var_76cfbf10 = 0;
    enemies = function_fb2ad2fb();
    foreach (guy in enemies) {
        if (!isdefined(guy)) {
            continue;
        }
        if (isdefined(guy.boss) && !all && guy.boss) {
            continue;
        }
        guy.aioverridedamage = undefined;
        guy.takedamage = 1;
        guy.allowdeath = 1;
        guy thread function_ba30b321(0);
        var_76cfbf10++;
        if (var_76cfbf10 == var_54a85fb0) {
            util::wait_network_frame();
            var_76cfbf10 = 0;
        }
    }
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x0
// Checksum 0x8ec9e280, Offset: 0x12e8
// Size: 0x102
function function_ba30b321(time, attacker, mod) {
    if (!isdefined(mod)) {
        mod = "MOD_HIT_BY_OBJECT";
    }
    assert(!isplayer(self));
    if (isdefined(self.boss) && self.boss) {
        return;
    }
    self endon(#"death");
    if (time > 0) {
        wait time;
    }
    self.takedamage = 1;
    self.allowdeath = 1;
    if (isdefined(attacker)) {
        self dodamage(self.health + -69, self.origin, attacker, attacker, "none", mod, 0, getweapon("none"));
        return;
    }
    self dodamage(self.health + -69, self.origin);
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x592581b0, Offset: 0x13f8
// Size: 0x25d
function function_308fa126(num) {
    if (!isdefined(num)) {
        num = 5;
    }
    locs = [];
    players = getplayers();
    location = struct::get(namespace_3ca3c537::function_d2d75f5d() + "_doa_teleporter", "targetname");
    if (!isdefined(location)) {
        spot = namespace_3ca3c537::function_61d60e0b();
    } else {
        spot = location.origin;
    }
    if (isdefined(spot)) {
        locs[locs.size] = spot;
        num--;
        if (num == 0) {
            return locs;
        }
    }
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_1d2ed40)) {
        foreach (spot in level.doa.arenas[level.doa.var_90873830].var_1d2ed40) {
            locs[locs.size] = spot.origin;
            num--;
            if (num == 0) {
                return locs;
            }
        }
    }
    if (isdefined(level.doa.var_3361a074)) {
        foreach (spot in level.doa.var_3361a074) {
            locs[locs.size] = spot.origin;
            num--;
            if (num == 0) {
                return locs;
            }
        }
    }
    foreach (player in players) {
        locs[locs.size] = player.origin;
        num--;
        if (num == 0) {
            return locs;
        }
    }
    return locs;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x90ad436e, Offset: 0x1660
// Size: 0x1c3
function function_8fc4387a(num) {
    if (!isdefined(num)) {
        num = 5;
    }
    locs = [];
    players = getplayers();
    location = struct::get(namespace_3ca3c537::function_d2d75f5d() + "_doa_teleporter", "targetname");
    if (isdefined(location)) {
        locs[locs.size] = location;
        num--;
        if (num == 0) {
            return locs;
        }
    }
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_1d2ed40)) {
        foreach (spot in level.doa.arenas[level.doa.var_90873830].var_1d2ed40) {
            locs[locs.size] = spot;
            num--;
            if (num == 0) {
                return locs;
            }
        }
    }
    if (isdefined(level.doa.var_3361a074)) {
        foreach (spot in level.doa.var_3361a074) {
            locs[locs.size] = spot;
            num--;
            if (num == 0) {
                return locs;
            }
        }
    }
    return locs;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x90c7e061, Offset: 0x1830
// Size: 0x7a
function function_812b4715(side) {
    switch (side) {
    case "top":
        return "bottom";
    case "bottom":
        return "top";
    case "left":
        return "right";
    case "right":
        return "left";
    }
    assert(0);
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0x68986d00, Offset: 0x18b8
// Size: 0x71
function function_5b4fbaef() {
    switch (randomint(4)) {
    case 0:
        return "bottom";
    case 1:
        return "top";
    case 2:
        return "right";
    case 3:
        return "left";
    }
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0xe4f51203, Offset: 0x1938
// Size: 0x9e
function getyawtoenemy() {
    pos = undefined;
    if (isdefined(self.enemy)) {
        pos = self.enemy.origin;
    } else {
        forward = anglestoforward(self.angles);
        forward = vectorscale(forward, -106);
        pos = self.origin + forward;
    }
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x29824bb, Offset: 0x19e0
// Size: 0x31
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0x7622c080, Offset: 0x1a20
// Size: 0x42
function function_cf5857a3(ent, note) {
    if (note != "death") {
        ent endon(#"death");
    }
    ent waittill(note);
    ent unlink();
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0xc5d30b59, Offset: 0x1a70
// Size: 0x93
function function_a98c85b2(location, timesec) {
    if (!isdefined(timesec)) {
        timesec = 1;
    }
    self notify(#"hash_a98c85b2");
    self endon(#"hash_a98c85b2");
    if (timesec <= 0) {
        timesec = 1;
    }
    increment = (self.origin - location) / timesec * 20;
    targettime = gettime() + timesec * 1000;
    while (gettime() < targettime) {
        self.origin = self.origin - increment;
        wait 0.05;
    }
    self notify(#"movedone");
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0xb69a23eb, Offset: 0x1b10
// Size: 0x99
function function_89a258a7() {
    self endon(#"death");
    self endon(#"hash_3d81b494");
    while (true) {
        wait 0.5;
        if (isdefined(self.var_111c7bbb)) {
            distsq = distancesquared(self.var_111c7bbb, self.origin);
            if (distsq < 32 * 32) {
                continue;
            }
        }
        var_111c7bbb = getclosestpointonnavmesh(self.origin, 64, 16);
        if (isdefined(var_111c7bbb)) {
            self.var_111c7bbb = var_111c7bbb;
        }
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x32fe3f7a, Offset: 0x1bb8
// Size: 0x3b
function addpoi(entity) {
    entity thread function_89a258a7();
    level.doa.var_f953d785[level.doa.var_f953d785.size] = entity;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x820a9045, Offset: 0x1c00
// Size: 0x2a
function function_3d81b494(entity) {
    arrayremovevalue(level.doa.var_f953d785, entity);
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0x3e18c3fe, Offset: 0x1c38
// Size: 0x31
function function_1acb8a7c(origin, radiussq) {
    return function_5ee38fe3(origin, level.doa.var_f953d785, radiussq);
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x4c644d4b, Offset: 0x1c78
// Size: 0x89
function clearallcorpses(num) {
    if (!isdefined(num)) {
        num = 99;
    }
    corpse_array = getcorpsearray();
    if (num == 99) {
        total = corpse_array.size;
    } else {
        total = num;
    }
    for (i = 0; i < total; i++) {
        if (isdefined(corpse_array[i])) {
            corpse_array[i] delete();
        }
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x44287a20, Offset: 0x1d10
// Size: 0x39
function function_5f54cafa(waittime) {
    level notify(#"hash_5f54cafa");
    level endon(#"hash_5f54cafa");
    while (true) {
        clearallcorpses();
        wait waittime;
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x37e25fa0, Offset: 0x1d58
// Size: 0x4e
function function_2ccf4b82(note) {
    if (!isdefined(level.doa.var_24cbf490)) {
        level.doa.var_24cbf490 = 0;
    }
    level.doa.var_24cbf490++;
    return note + level.doa.var_24cbf490;
}

// Namespace namespace_49107f3a
// Params 5, eflags: 0x0
// Checksum 0x9322e6e, Offset: 0x1db0
// Size: 0x18b
function function_c5f3ece8(text, param, holdtime, color, note) {
    if (!isdefined(holdtime)) {
        holdtime = 5;
    }
    if (!isdefined(color)) {
        color = (0.9, 0.9, 0);
    }
    if (!isdefined(note)) {
        note = "title1Fade";
    }
    self notify(#"hash_c5f3ece8");
    self endon(#"hash_c5f3ece8");
    level.doa.var_4bc31566.color = color;
    level.doa.var_4bc31566.alpha = 0;
    if (isdefined(param)) {
        level.doa.var_4bc31566 settext(text, param);
    } else {
        level.doa.var_4bc31566 settext(text);
    }
    level.doa.var_4bc31566 fadeovertime(1);
    level.doa.var_4bc31566.alpha = 1;
    if (holdtime == -1) {
        level waittill(note);
    } else {
        level util::waittill_any_timeout(holdtime, note);
    }
    level.doa.var_4bc31566 fadeovertime(1);
    level.doa.var_4bc31566.alpha = 0;
    level notify(#"title1Fade");
}

// Namespace namespace_49107f3a
// Params 5, eflags: 0x0
// Checksum 0x88c0a9a1, Offset: 0x1f48
// Size: 0x173
function function_37fb5c23(text, param, holdtime, color, note) {
    if (!isdefined(holdtime)) {
        holdtime = 5;
    }
    if (!isdefined(color)) {
        color = (1, 1, 0);
    }
    if (!isdefined(note)) {
        note = "title2Fade";
    }
    self notify(#"hash_37fb5c23");
    self endon(#"hash_37fb5c23");
    level.doa.var_25c09afd.color = color;
    level.doa.var_25c09afd.alpha = 0;
    if (isdefined(param)) {
        level.doa.var_25c09afd settext(text, param);
    } else {
        level.doa.var_25c09afd settext(text);
    }
    level.doa.var_25c09afd fadeovertime(1);
    level.doa.var_25c09afd.alpha = 1;
    level util::waittill_any_timeout(holdtime, note);
    level.doa.var_25c09afd fadeovertime(1);
    level.doa.var_25c09afd.alpha = 0;
    level notify(#"title2Fade");
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0x69b16b59, Offset: 0x20c8
// Size: 0xa
function function_13fbad22() {
    InvalidOpCode(0xc9);
    // Unknown operator (0xc9, t7_1b, PC)
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0x28700b98, Offset: 0x2130
// Size: 0x1a
function function_c9fb43e9(text, position) {
    InvalidOpCode(0xc9);
    // Unknown operator (0xc9, t7_1b, PC)
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0xdff51fbe, Offset: 0x21c0
// Size: 0x3a
function function_11f3f381(index, fadetime) {
    luinotifyevent(%doa_bubble, 2, isdefined(fadetime) ? fadetime : 0, index);
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0x92a10a3b, Offset: 0x2208
// Size: 0x122
function function_dbcf48a0(width, height) {
    if (!isdefined(width)) {
        width = 40;
    }
    if (!isdefined(height)) {
        height = 40;
    }
    trigger = spawn("trigger_radius", self.origin, 1, width, height);
    trigger.targetname = "touchmeTrigger";
    trigger enablelinkto();
    trigger linkto(self);
    trigger thread function_981c685d(self);
    trigger endon(#"death");
    while (isdefined(self)) {
        trigger waittill(#"trigger", guy);
        if (isdefined(guy)) {
            if (isdefined(guy.var_cb05ea19) && guy.var_cb05ea19) {
                continue;
            }
            guy dodamage(guy.health + 1, guy.origin);
        }
    }
    if (isdefined(trigger)) {
        trigger delete();
    }
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x0
// Checksum 0x182c3472, Offset: 0x2338
// Size: 0xb9
function function_1ded48e6(time, var_d9e56903, var_f88fd757) {
    if (!isdefined(self)) {
        return 0.1;
    }
    if (self.doa.fate == 2) {
        time *= level.doa.rules.var_f2d5f54d;
    } else if (self.doa.fate == 11) {
        time *= level.doa.rules.var_b3d39edc;
    } else if (isdefined(var_d9e56903) && self.doa.fate == var_d9e56903) {
        time *= var_f88fd757;
    }
    return time;
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0x33cec677, Offset: 0x2400
// Size: 0x23
function function_a4d1f25e(note, time) {
    self endon(#"death");
    wait time;
    self notify(note);
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x0
// Checksum 0x231fb1f8, Offset: 0x2430
// Size: 0x6c
function function_1c0abd70(var_8e25979b, dist, ignore) {
    start = var_8e25979b + (0, 0, dist);
    end = var_8e25979b - (0, 0, dist);
    a_trace = bullettrace(start, end, 0, ignore, 1);
    return a_trace["position"];
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x0
// Checksum 0xfd41e83b, Offset: 0x24a8
// Size: 0x39
function addoffsetontopoint(point, angles, offset) {
    offset_world = rotatepoint(offset, angles);
    return point + offset_world;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x546dc32a, Offset: 0x24f0
// Size: 0x46
function getyawtospot(spot) {
    yaw = self.angles[1] - getyaw(spot);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// Checksum 0xd4e10321, Offset: 0x2540
// Size: 0x95
function function_fa8a86e8(ent, target) {
    v_diff = target.origin - ent.origin;
    x = v_diff[0];
    y = v_diff[1];
    if (x != 0) {
        var_d17dd9c9 = y / x;
        yaw = atan(var_d17dd9c9);
        if (x < 0) {
            yaw += -76;
        }
    }
    return yaw;
}

/#

    // Namespace namespace_49107f3a
    // Params 4, eflags: 0x0
    // Checksum 0x35e04e9a, Offset: 0x25e0
    // Size: 0x7a
    function debug_circle(origin, radius, seconds, color) {
        if (!isdefined(seconds)) {
            seconds = 1;
        }
        if (!isdefined(color)) {
            color = (1, 0, 0);
        }
        frames = int(20 * seconds);
        circle(origin, radius, color, 0, 1, frames);
    }

    // Namespace namespace_49107f3a
    // Params 4, eflags: 0x0
    // Checksum 0x9890d847, Offset: 0x2668
    // Size: 0x52
    function debug_line(p1, p2, seconds, color) {
        line(p1, p2, color, 1, 0, int(seconds * 20));
    }

    // Namespace namespace_49107f3a
    // Params 4, eflags: 0x0
    // Checksum 0x6f9ddbe4, Offset: 0x26c8
    // Size: 0x13d
    function function_a0e51d80(point, timesec, size, color) {
        self endon(#"hash_b67acf30");
        end = gettime() + timesec * 1000;
        halfwidth = int(size / 2);
        var_a84bd888 = point + (halfwidth * -1, 0, 0);
        l2 = point + (halfwidth, 0, 0);
        var_5e2b69e1 = point + (0, halfwidth * -1, 0);
        var_842de44a = point + (0, halfwidth, 0);
        var_e4d48d14 = point + (0, 0, halfwidth * -1);
        var_56dbfc4f = point + (0, 0, halfwidth);
        while (end > gettime()) {
            line(var_a84bd888, l2, color, 1, 0, 1);
            line(var_5e2b69e1, var_842de44a, color, 1, 0, 1);
            line(var_e4d48d14, var_56dbfc4f, color, 1, 0, 1);
            wait 0.05;
        }
    }

    // Namespace namespace_49107f3a
    // Params 3, eflags: 0x0
    // Checksum 0xa81a5e67, Offset: 0x2810
    // Size: 0x145
    function debugorigin(timesec, size, color) {
        self endon(#"hash_c32e3b78");
        end = gettime() + timesec * 1000;
        halfwidth = int(size / 2);
        while (end > gettime()) {
            point = self.origin;
            var_a84bd888 = point + (halfwidth * -1, 0, 0);
            l2 = point + (halfwidth, 0, 0);
            var_5e2b69e1 = point + (0, halfwidth * -1, 0);
            var_842de44a = point + (0, halfwidth, 0);
            var_e4d48d14 = point + (0, 0, halfwidth * -1);
            var_56dbfc4f = point + (0, 0, halfwidth);
            line(var_a84bd888, l2, color, 1, 0, 1);
            line(var_5e2b69e1, var_842de44a, color, 1, 0, 1);
            line(var_e4d48d14, var_56dbfc4f, color, 1, 0, 1);
            wait 0.05;
        }
    }

#/

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x309a4d09, Offset: 0x2960
// Size: 0x2a
function debugmsg(txt) {
    println("<dev string:x4d>" + txt);
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// Checksum 0x2dc7dea3, Offset: 0x2998
// Size: 0x22
function set_lighting_state(state) {
    level.lighting_state = state;
    setlightingstate(state);
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0x568b71e7, Offset: 0x29c8
// Size: 0x7e
function function_5233dbc0() {
    foreach (player in getplayers()) {
        if (isdefined(player.doa) && isdefined(player.doa.vehicle)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0xd5e6228b, Offset: 0x2a50
// Size: 0xba
function function_5bca1086() {
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_1d2ed40) && level.doa.arenas[level.doa.var_90873830].var_1d2ed40.size) {
        spot = function_5ee38fe3(self.origin, level.doa.arenas[level.doa.var_90873830].var_1d2ed40).origin;
    } else {
        spot = self.origin;
    }
    return spot;
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x0
// Checksum 0x87d1b075, Offset: 0x2b18
// Size: 0xaa
function function_37548bf4() {
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_1d2ed40)) {
        spot = level.doa.arenas[level.doa.var_90873830].var_1d2ed40[randomint(level.doa.arenas[level.doa.var_90873830].var_1d2ed40.size)].origin;
    } else {
        spot = self.origin;
    }
    return spot;
}

