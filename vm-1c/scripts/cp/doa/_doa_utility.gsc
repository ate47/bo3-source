#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_dev;
#using scripts/shared/lui_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_49107f3a;

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_4e9a23a9
// Checksum 0x140994e2, Offset: 0x368
// Size: 0x9c
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
// namespace_49107f3a<file_0>::function_7874f1ab
// Checksum 0xf077f613, Offset: 0x410
// Size: 0x68
function isheadshot(sweapon, shitloc, smeansofdeath) {
    return (shitloc == "head" || shitloc == "helmet") && smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_BAYONET" && smeansofdeath != "MOD_IMPACT";
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// namespace_49107f3a<file_0>::function_261a5dc5
// Checksum 0x83b99469, Offset: 0x480
// Size: 0x64
function isexplosivedamage(damage_mod) {
    if (damage_mod == "MOD_GRENADE" || damage_mod == "MOD_GRENADE_SPLASH" || damage_mod == "MOD_PROJECTILE" || damage_mod == "MOD_PROJECTILE_SPLASH" || damage_mod == "MOD_EXPLOSIVE") {
        return true;
    }
    return false;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// namespace_49107f3a<file_0>::function_767f35f5
// Checksum 0x48b3a0a6, Offset: 0x4f0
// Size: 0x48
function function_767f35f5(mod) {
    return mod == "MOD_PROJECTILE" || isdefined(self.damageweapon) && self.damageweapon == "zombietron_tesla_gun" && mod == "MOD_PROJECTILE_SPLASH";
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// namespace_49107f3a<file_0>::function_698a0b31
// Checksum 0xaff35b26, Offset: 0x540
// Size: 0x132
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
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_124b9a08
// Checksum 0xa60b1b24, Offset: 0x680
// Size: 0x3c
function function_124b9a08() {
    while (true) {
        if (level flag::get("doa_round_active")) {
            return;
        }
        wait(0.05);
    }
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_c8f4d63a
// Checksum 0x824f4da6, Offset: 0x6c8
// Size: 0x34
function function_c8f4d63a() {
    while (level flag::get("doa_bonusroom_active")) {
        wait(0.05);
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_d0e32ad0
// Checksum 0x6a2a90b0, Offset: 0x708
// Size: 0x84
function function_d0e32ad0(state) {
    if (state == 1) {
        while (!level flag::get("doa_screen_faded_out")) {
            wait(0.05);
        }
        return;
    }
    if (state == 0) {
        while (level flag::get("doa_screen_faded_out")) {
            wait(0.05);
        }
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_44eb090b
// Checksum 0xa7ce7a22, Offset: 0x798
// Size: 0x24
function function_44eb090b(time) {
    function_a5821e05(time);
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_390adefe
// Checksum 0xd75152ad, Offset: 0x7c8
// Size: 0x3c
function function_390adefe(unfreeze) {
    if (!isdefined(unfreeze)) {
        unfreeze = 1;
    }
    function_c85960dd(1.2, unfreeze);
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_a5821e05
// Checksum 0x2fd19a70, Offset: 0x810
// Size: 0x1bc
function function_a5821e05(time) {
    if (!isdefined(time)) {
        time = 1;
    }
    if (isdefined(level.var_a7749866)) {
        /#
            debugmsg("MOD_PROJECTILE_SPLASH");
        #/
        return;
    }
    level.var_a7749866 = gettime();
    /#
        debugmsg("MOD_PROJECTILE_SPLASH" + level.var_a7749866);
    #/
    level thread function_1d62c13a();
    foreach (player in getplayers()) {
        player freezecontrols(1);
        player thread namespace_831a4a7c::function_4519b17(1);
    }
    level lui::screen_fade_out(time, "black");
    wait(time);
    /#
        debugmsg("MOD_PROJECTILE_SPLASH" + gettime());
    #/
    level notify(#"hash_96377490");
    level flag::set("doa_screen_faded_out");
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_c85960dd
// Checksum 0xd48c5ab5, Offset: 0x9d8
// Size: 0x214
function function_c85960dd(hold_black_time, unfreeze) {
    if (!isdefined(hold_black_time)) {
        hold_black_time = 1.2;
    }
    if (!isdefined(unfreeze)) {
        unfreeze = 1;
    }
    /#
        debugmsg("MOD_PROJECTILE_SPLASH");
    #/
    wait(hold_black_time);
    foreach (player in getplayers()) {
        player notify(#"hash_ff28e404");
    }
    level lui::screen_fade_in(1.5);
    if (unfreeze) {
        foreach (player in getplayers()) {
            player freezecontrols(0);
            player thread namespace_831a4a7c::function_4519b17(0);
        }
    }
    level notify(#"hash_dec47e9f");
    /#
        debugmsg("MOD_PROJECTILE_SPLASH");
    #/
    level flag::clear("doa_screen_faded_out");
    level.var_a7749866 = undefined;
    level lui::screen_close_menu();
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_1d62c13a
// Checksum 0xd0de82f1, Offset: 0xbf8
// Size: 0xa4
function function_1d62c13a() {
    level endon(#"hash_dec47e9f");
    while (isdefined(level.var_a7749866)) {
        if (level flag::get("doa_game_is_over")) {
            return;
        }
        if (level flag::get("doa_round_spawning")) {
            break;
        }
        wait(0.05);
    }
    /#
        debugmsg("MOD_PROJECTILE_SPLASH");
    #/
    level thread function_c85960dd();
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// namespace_49107f3a<file_0>::function_d0c69425
// Checksum 0x5d0eecfe, Offset: 0xca8
// Size: 0xb4
function function_d0c69425(waitsec) {
    level endon(#"hash_dec47e9f");
    while (!(isdefined(level.var_de693c3) && level.var_de693c3)) {
        wait(0.05);
    }
    timeout = gettime() + waitsec * 1000;
    while (isdefined(level.var_a7749866) && gettime() < timeout) {
        wait(0.05);
    }
    /#
        debugmsg("MOD_PROJECTILE_SPLASH");
    #/
    level thread function_c85960dd();
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_5ee38fe3
// Checksum 0x58c024b5, Offset: 0xd68
// Size: 0x82
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
// Params 3, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_a7eabaf
// Checksum 0x94bf13bd, Offset: 0xdf8
// Size: 0xdc
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
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_1bfb2259
// Checksum 0x31224f8b, Offset: 0xee0
// Size: 0x2a
function function_1bfb2259(&entarray) {
    return function_5ee38fe3(self.origin, entarray);
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// namespace_49107f3a<file_0>::function_999bba85
// Checksum 0xd0ef0b58, Offset: 0xf18
// Size: 0x84
function function_999bba85(origin, time) {
    self moveto(origin, time, 0, 0);
    wait(time);
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_80409246
// Checksum 0x775443c7, Offset: 0xfa8
// Size: 0x2e
function function_80409246(note, timeout) {
    self endon(#"death");
    wait(timeout);
    self notify(note);
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_31931862
// Checksum 0x4e571fb5, Offset: 0xfe0
// Size: 0x64
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
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_75e76155
// Checksum 0xfad5abe3, Offset: 0x1050
// Size: 0x114
function function_75e76155(other, note) {
    if (!isdefined(other)) {
        return;
    }
    killnote = function_2ccf4b82("DeleteNote");
    self thread function_f5db70f1(other, killnote);
    if (isplayer(other)) {
        if (note == "disconnect") {
            other util::waittill_any(note, killnote);
        } else {
            other util::waittill_any(note, "disconnect", killnote);
        }
    } else {
        other util::waittill_any(note, killnote);
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_f5db70f1
// Checksum 0x66e6e345, Offset: 0x1170
// Size: 0x4a
function function_f5db70f1(other, note) {
    self endon(note);
    other endon(#"death");
    self waittill(#"death");
    if (isdefined(other)) {
        other notify(note);
    }
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_24245456
// Checksum 0xd70422a9, Offset: 0x11c8
// Size: 0x144
function function_24245456(other, note) {
    if (!isdefined(other)) {
        return;
    }
    self endon(#"death");
    killnote = function_2ccf4b82("killNote");
    self thread function_f5db70f1(other, killnote);
    if (isplayer(other)) {
        if (note == "disconnect") {
            other util::waittill_any(note, killnote);
        } else {
            other util::waittill_any(note, "disconnect", killnote);
        }
    } else {
        other util::waittill_any(note, killnote);
    }
    if (isdefined(self)) {
        self notify(killnote);
        self.aioverridedamage = undefined;
        self.takedamage = 1;
        self.allowdeath = 1;
        self thread function_ba30b321(0);
    }
}

// Namespace namespace_49107f3a
// Params 5, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_d1686f4c
// Checksum 0x208b5ec6, Offset: 0x1318
// Size: 0x56
function function_d1686f4c(note, sec, endnote, param1, param2) {
    self endon(endnote);
    self endon(#"disconnect");
    wait(sec);
    self notify(note, param1, param2);
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_783519c1
// Checksum 0xd44da52, Offset: 0x1378
// Size: 0xa4
function function_783519c1(note, var_8b804bd9) {
    if (!isdefined(var_8b804bd9)) {
        var_8b804bd9 = 0;
    }
    self endon(#"death");
    self endon("abort" + note);
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
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_1bd67aef
// Checksum 0xc2cf097e, Offset: 0x1428
// Size: 0x5c
function function_1bd67aef(time) {
    self endon(#"death");
    wait(time);
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self delete();
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_981c685d
// Checksum 0x36476b4a, Offset: 0x1490
// Size: 0xfc
function function_981c685d(var_627e7613) {
    self endon(#"death");
    killnote = function_2ccf4b82("deathNote");
    self thread function_f5db70f1(var_627e7613, killnote);
    if (isplayer(var_627e7613)) {
        var_627e7613 util::waittill_any("death", "disconnect", killnote);
    } else {
        var_627e7613 util::waittill_any("death", killnote);
    }
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self delete();
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_a625b5d3
// Checksum 0xe9945f5e, Offset: 0x1598
// Size: 0x74
function function_a625b5d3(player) {
    assert(isplayer(player), "MOD_PROJECTILE_SPLASH");
    self endon(#"death");
    player waittill(#"disconnect");
    self delete();
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_c157030a
// Checksum 0x1b84b512, Offset: 0x1618
// Size: 0x24
function function_c157030a() {
    while (function_b99d78c7() > 0) {
        wait(1);
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_1ced251e
// Checksum 0x73c364de, Offset: 0x1648
// Size: 0x5e
function function_1ced251e(all) {
    if (!isdefined(all)) {
        all = 0;
    }
    while (function_b99d78c7() > 0) {
        function_f798b582(all);
        wait(1);
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_2f0d697f
// Checksum 0x1a870cdd, Offset: 0x16b0
// Size: 0xdc
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
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_b99d78c7
// Checksum 0x52b9a55, Offset: 0x1798
// Size: 0x5e
function function_b99d78c7() {
    var_594dffdc = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
    return var_594dffdc.size;
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_fb2ad2fb
// Checksum 0x386a796, Offset: 0x1800
// Size: 0x4a
function function_fb2ad2fb() {
    return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_fe180f6f
// Checksum 0x9cfac255, Offset: 0x1858
// Size: 0x19a
function function_fe180f6f(count) {
    if (!isdefined(count)) {
        count = 1;
    }
    var_54a85fb0 = 4;
    var_76cfbf10 = 0;
    enemies = function_fb2ad2fb();
    foreach (guy in enemies) {
        if (count <= 0) {
            return;
        }
        if (!isdefined(guy)) {
            continue;
        }
        if (isdefined(guy.boss) && guy.boss) {
            continue;
        }
        if (!(isdefined(guy.spawner.var_8d1af144) && guy.spawner.var_8d1af144)) {
            continue;
        }
        guy thread function_ba30b321(0);
        var_76cfbf10++;
        count--;
        if (var_76cfbf10 == var_54a85fb0) {
            util::wait_network_frame();
            var_76cfbf10 = 0;
        }
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_f798b582
// Checksum 0x15838382, Offset: 0x1a00
// Size: 0x18a
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
// Params 4, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_e3c30240
// Checksum 0x10a103cb, Offset: 0x1b98
// Size: 0x104
function function_e3c30240(dir, var_e3e1b987, var_1f32eac0, attacker) {
    if (!isdefined(var_e3e1b987)) {
        var_e3e1b987 = 100;
    }
    if (!isdefined(var_1f32eac0)) {
        var_1f32eac0 = 0.1;
    }
    if (!isdefined(self)) {
        return;
    }
    self thread function_ba30b321(var_1f32eac0, attacker);
    if (isdefined(self.var_7ebc405c) && self.var_7ebc405c) {
        return;
    }
    self endon(#"death");
    self setplayercollision(0);
    self startragdoll();
    if (isdefined(dir)) {
        dir = vectornormalize(dir);
        self launchragdoll(dir * var_e3e1b987);
    }
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_ba30b321
// Checksum 0xe14d6d0c, Offset: 0x1ca8
// Size: 0x134
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
        wait(time);
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
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_308fa126
// Checksum 0x1f763b37, Offset: 0x1de8
// Size: 0x2ba
function function_308fa126(num) {
    if (!isdefined(num)) {
        num = 5;
    }
    locs = [];
    players = getplayers();
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
        if (isdefined(player.vehicle)) {
            continue;
        }
        locs[locs.size] = player.origin;
        num--;
        if (num == 0) {
            return locs;
        }
    }
    return locs;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_8fc4387a
// Checksum 0x4424964f, Offset: 0x20b0
// Size: 0x1d2
function function_8fc4387a(num) {
    if (!isdefined(num)) {
        num = 5;
    }
    locs = [];
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
// namespace_49107f3a<file_0>::function_812b4715
// Checksum 0xaf27915b, Offset: 0x2290
// Size: 0x84
function function_812b4715(side) {
    switch (side) {
    case 29:
        return "bottom";
    case 28:
        return "top";
    case 31:
        return "right";
    case 30:
        return "left";
    }
    assert(0);
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_5b4fbaef
// Checksum 0x46514e56, Offset: 0x2320
// Size: 0xa2
function function_5b4fbaef() {
    /#
        if (getdvarint("MOD_PROJECTILE_SPLASH", 0)) {
            return "MOD_PROJECTILE_SPLASH";
        }
    #/
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
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_b8b76821
// Checksum 0xd715a5b1, Offset: 0x23d0
// Size: 0xd4
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
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_fcaa5774
// Checksum 0xeb94ebaf, Offset: 0x24b0
// Size: 0x42
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x0
// namespace_49107f3a<file_0>::function_cf5857a3
// Checksum 0x4796ce05, Offset: 0x2500
// Size: 0x54
function function_cf5857a3(ent, note) {
    if (note != "death") {
        ent endon(#"death");
    }
    ent waittill(note);
    ent unlink();
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_a98c85b2
// Checksum 0xfc8fd807, Offset: 0x2560
// Size: 0xd6
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
        self.origin -= increment;
        wait(0.05);
    }
    self notify(#"movedone");
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_89a258a7
// Checksum 0x353d5c43, Offset: 0x2640
// Size: 0xcc
function function_89a258a7() {
    self endon(#"death");
    self endon(#"hash_3d81b494");
    while (true) {
        wait(0.5);
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
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_5fd5c3ea
// Checksum 0x6e0e7992, Offset: 0x2718
// Size: 0x4a
function addpoi(entity) {
    entity thread function_89a258a7();
    level.doa.var_f953d785[level.doa.var_f953d785.size] = entity;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_3d81b494
// Checksum 0x721b9527, Offset: 0x2770
// Size: 0x34
function function_3d81b494(entity) {
    arrayremovevalue(level.doa.var_f953d785, entity);
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_1acb8a7c
// Checksum 0x42797da0, Offset: 0x27b0
// Size: 0x3a
function function_1acb8a7c(origin, radiussq) {
    return function_5ee38fe3(origin, level.doa.var_f953d785, radiussq);
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_c8ecd848
// Checksum 0x7c15cfa0, Offset: 0x27f8
// Size: 0xc6
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
// namespace_49107f3a<file_0>::function_5f54cafa
// Checksum 0x34d5dbfb, Offset: 0x28c8
// Size: 0x4e
function function_5f54cafa(waittime) {
    level notify(#"hash_5f54cafa");
    level endon(#"hash_5f54cafa");
    while (true) {
        clearallcorpses();
        wait(waittime);
    }
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_2ccf4b82
// Checksum 0x8b429b9f, Offset: 0x2920
// Size: 0x58
function function_2ccf4b82(note) {
    if (!isdefined(level.doa.var_24cbf490)) {
        level.doa.var_24cbf490 = 0;
    }
    level.doa.var_24cbf490++;
    return note + level.doa.var_24cbf490;
}

// Namespace namespace_49107f3a
// Params 5, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_c5f3ece8
// Checksum 0xcd42b0d3, Offset: 0x2980
// Size: 0x1f6
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
    level notify(#"hash_b96c96ac");
}

// Namespace namespace_49107f3a
// Params 5, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_37fb5c23
// Checksum 0x2e26646e, Offset: 0x2b80
// Size: 0x1ce
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
    level notify(#"hash_97276c43");
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_13fbad22
// Checksum 0x34d2a491, Offset: 0x2d58
// Size: 0x7c
function function_13fbad22() {
    if (isdefined(world.var_c642e28c)) {
        for (i = 0; i < world.var_c642e28c; i++) {
            function_11f3f381(i, 1);
            util::wait_network_frame();
        }
    }
    world.var_c642e28c = 0;
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_c9fb43e9
// Checksum 0x708d965b, Offset: 0x2de0
// Size: 0xb0
function function_c9fb43e9(text, position) {
    index = world.var_c642e28c;
    world.var_c642e28c++;
    luinotifyevent(%doa_bubble, 6, -1, index, text, int(position[0]), int(position[1]), int(position[2]));
    return index;
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_11f3f381
// Checksum 0x7ebc171e, Offset: 0x2e98
// Size: 0x4c
function function_11f3f381(index, fadetime) {
    luinotifyevent(%doa_bubble, 2, isdefined(fadetime) ? fadetime : 0, index);
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_dbcf48a0
// Checksum 0x444ff08, Offset: 0x2ef0
// Size: 0x21c
function function_dbcf48a0(delay, width, height) {
    if (!isdefined(delay)) {
        delay = 0;
    }
    if (!isdefined(width)) {
        width = 40;
    }
    if (!isdefined(height)) {
        height = 40;
    }
    if (delay) {
        wait(delay);
    }
    if (!isdefined(self)) {
        return;
    }
    trigger = spawn("trigger_radius", self.origin, 1, width, height);
    trigger.targetname = "touchmeTrigger";
    trigger enablelinkto();
    trigger linkto(self);
    trigger thread function_981c685d(self);
    trigger endon(#"death");
    while (isdefined(self)) {
        guy = trigger waittill(#"trigger");
        if (isdefined(guy)) {
            if (isdefined(guy.var_cb05ea19) && guy.var_cb05ea19) {
                continue;
            }
            if (isdefined(guy.boss) && guy.boss) {
                continue;
            }
            if (isdefined(guy.doa) && isdefined(guy.doa.vehicle)) {
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
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_1ded48e6
// Checksum 0xe5796a6, Offset: 0x3118
// Size: 0xb6
function function_1ded48e6(time, var_f88fd757) {
    if (!isdefined(self)) {
        return 0;
    }
    if (isdefined(var_f88fd757)) {
        return (time * var_f88fd757);
    }
    if (self.doa.fate == 2) {
        time *= level.doa.rules.var_f2d5f54d;
    } else if (self.doa.fate == 11) {
        time *= level.doa.rules.var_b3d39edc;
    }
    return time;
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_a4d1f25e
// Checksum 0xd6b1f83, Offset: 0x31d8
// Size: 0x2e
function function_a4d1f25e(note, time) {
    self endon(#"death");
    wait(time);
    self notify(note);
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_1c0abd70
// Checksum 0xaa9a5f21, Offset: 0x3210
// Size: 0x9c
function function_1c0abd70(var_8e25979b, var_5e50267c, ignore) {
    start = var_8e25979b + (0, 0, var_5e50267c);
    end = var_8e25979b - (0, 0, 1024);
    a_trace = groundtrace(start, end, 0, ignore, 1);
    return a_trace["position"];
}

// Namespace namespace_49107f3a
// Params 3, eflags: 0x0
// namespace_49107f3a<file_0>::function_3d4bdb47
// Checksum 0x67787d55, Offset: 0x32b8
// Size: 0x4a
function addoffsetontopoint(point, angles, offset) {
    offset_world = rotatepoint(offset, angles);
    return point + offset_world;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x0
// namespace_49107f3a<file_0>::function_c43df297
// Checksum 0x3fdd65a, Offset: 0x3310
// Size: 0x5c
function getyawtospot(spot) {
    yaw = self.angles[1] - getyaw(spot);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace namespace_49107f3a
// Params 2, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_fa8a86e8
// Checksum 0x5639e5fc, Offset: 0x3378
// Size: 0xd0
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
    // Params 4, eflags: 0x1 linked
    // namespace_49107f3a<file_0>::function_b5002a71
    // Checksum 0xecb3dc32, Offset: 0x3450
    // Size: 0xa4
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
    // Params 4, eflags: 0x1 linked
    // namespace_49107f3a<file_0>::function_a9c39c8b
    // Checksum 0x8055cf29, Offset: 0x3500
    // Size: 0x64
    function debug_line(p1, p2, seconds, color) {
        line(p1, p2, color, 1, 0, int(seconds * 20));
    }

    // Namespace namespace_49107f3a
    // Params 4, eflags: 0x0
    // namespace_49107f3a<file_0>::function_a0e51d80
    // Checksum 0x99ba6664, Offset: 0x3570
    // Size: 0x1d0
    function function_a0e51d80(point, timesec, size, color) {
        self endon(#"hash_b67acf30");
        end = gettime() + timesec * 1000;
        halfwidth = int(size / 2);
        var_a84bd888 = point + (halfwidth * -1, 0, 0);
        var_1a5347c3 = point + (halfwidth, 0, 0);
        var_5e2b69e1 = point + (0, halfwidth * -1, 0);
        var_842de44a = point + (0, halfwidth, 0);
        var_e4d48d14 = point + (0, 0, halfwidth * -1);
        var_56dbfc4f = point + (0, 0, halfwidth);
        while (end > gettime()) {
            line(var_a84bd888, var_1a5347c3, color, 1, 0, 1);
            line(var_5e2b69e1, var_842de44a, color, 1, 0, 1);
            line(var_e4d48d14, var_56dbfc4f, color, 1, 0, 1);
            wait(0.05);
        }
    }

    // Namespace namespace_49107f3a
    // Params 3, eflags: 0x1 linked
    // namespace_49107f3a<file_0>::function_4d1ec408
    // Checksum 0xcc098ed1, Offset: 0x3748
    // Size: 0x1d8
    function debugorigin(timesec, size, color) {
        self endon(#"hash_c32e3b78");
        end = gettime() + timesec * 1000;
        halfwidth = int(size / 2);
        while (end > gettime()) {
            point = self.origin;
            var_a84bd888 = point + (halfwidth * -1, 0, 0);
            var_1a5347c3 = point + (halfwidth, 0, 0);
            var_5e2b69e1 = point + (0, halfwidth * -1, 0);
            var_842de44a = point + (0, halfwidth, 0);
            var_e4d48d14 = point + (0, 0, halfwidth * -1);
            var_56dbfc4f = point + (0, 0, halfwidth);
            line(var_a84bd888, var_1a5347c3, color, 1, 0, 1);
            line(var_5e2b69e1, var_842de44a, color, 1, 0, 1);
            line(var_e4d48d14, var_56dbfc4f, color, 1, 0, 1);
            wait(0.05);
        }
    }

    // Namespace namespace_49107f3a
    // Params 1, eflags: 0x1 linked
    // namespace_49107f3a<file_0>::function_aacf4c41
    // Checksum 0x6255f834, Offset: 0x3928
    // Size: 0x34
    function debugmsg(txt) {
        println("MOD_PROJECTILE_SPLASH" + txt);
    }

#/

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_b85473ac
// Checksum 0x74e1a408, Offset: 0x3968
// Size: 0x2c
function set_lighting_state(state) {
    level.lighting_state = state;
    setlightingstate(state);
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_5233dbc0
// Checksum 0xbd82ad46, Offset: 0x39a0
// Size: 0xb2
function function_5233dbc0() {
    foreach (player in getplayers()) {
        if (isdefined(player.doa) && isdefined(player.doa.vehicle)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_5bca1086
// Checksum 0x7dc42ecc, Offset: 0x3a60
// Size: 0x114
function function_5bca1086() {
    if (!isdefined(self)) {
        return namespace_3ca3c537::function_61d60e0b();
    }
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_1d2ed40) && level.doa.arenas[level.doa.var_90873830].var_1d2ed40.size) {
        spot = function_5ee38fe3(self.origin, level.doa.arenas[level.doa.var_90873830].var_1d2ed40);
        if (!isdefined(spot)) {
            spot = self.origin;
        } else {
            spot = spot.origin;
        }
    } else {
        spot = self.origin;
    }
    return spot;
}

// Namespace namespace_49107f3a
// Params 1, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_14a10231
// Checksum 0x315ab981, Offset: 0x3b80
// Size: 0x102
function function_14a10231(origin) {
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_1d2ed40) && level.doa.arenas[level.doa.var_90873830].var_1d2ed40.size) {
        spot = level.doa.arenas[level.doa.var_90873830].var_1d2ed40[randomint(level.doa.arenas[level.doa.var_90873830].var_1d2ed40.size)].origin;
    } else {
        spot = origin;
    }
    return spot;
}

// Namespace namespace_49107f3a
// Params 0, eflags: 0x1 linked
// namespace_49107f3a<file_0>::function_ada6d90
// Checksum 0x4da92468, Offset: 0x3c90
// Size: 0xd2
function function_ada6d90() {
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_1d2ed40) && level.doa.arenas[level.doa.var_90873830].var_1d2ed40.size) {
        return level.doa.arenas[level.doa.var_90873830].var_1d2ed40[randomint(level.doa.arenas[level.doa.var_90873830].var_1d2ed40.size)];
    }
}

