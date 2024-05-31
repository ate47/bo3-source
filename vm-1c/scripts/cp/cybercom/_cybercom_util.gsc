#using scripts/cp/gametypes/_save;
#using scripts/cp/_bb;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/math_shared;
#using scripts/shared/array_shared;
#using scripts/cp/cybercom/_cybercom_tactical_rig_emergencyreserve;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/flag_shared;

#namespace cybercom;

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0x4145ca4f, Offset: 0x808
// Size: 0x5c
function function_da99f3e1() {
    level flagsys::wait_till("load_main_complete");
    /#
        level thread namespace_afd2f70b::function_b9907dab();
    #/
    setdvar("scr_max_simLocks", 5);
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0xfb05d0e3, Offset: 0x870
// Size: 0x2ea
function function_80fe1bad(vehicle) {
    if (isdefined(vehicle.archetype)) {
        vehicle.var_9147087d = [];
        switch (vehicle.archetype) {
        case 12:
            vehicle.nocybercom = 1;
            break;
        case 14:
            vehicle function_59965309("cybercom_surge");
            vehicle function_59965309("cybercom_servoshortout");
            vehicle function_59965309("cybercom_systemoverload");
            vehicle function_59965309("cybercom_smokescreen");
            vehicle function_59965309("cybercom_immolate");
            vehicle.var_9147087d["cybercom_hijack"] = getdvarint("scr_hacktime_quadtank", 11);
            vehicle.var_9147087d["cybercom_iffoverride"] = getdvarint("scr_hacktime_quadtank", 11);
            vehicle.var_6c8af4c4 = 0;
            vehicle.var_ced13b2f = 1;
            break;
        case 15:
            vehicle function_59965309("cybercom_surge");
            vehicle function_59965309("cybercom_servoshortout");
            vehicle function_59965309("cybercom_smokescreen");
            vehicle function_59965309("cybercom_immolate");
            vehicle.var_9147087d["cybercom_hijack"] = getdvarint("scr_hacktime_siegebot", 9);
            vehicle.var_9147087d["cybercom_iffoverride"] = getdvarint("scr_hacktime_siegebot", 9);
            vehicle.var_6c8af4c4 = 0;
            vehicle.var_ced13b2f = 1;
            break;
        case 11:
        case 13:
            vehicle.nocybercom = 1;
        default:
            break;
        }
    }
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x6561c314, Offset: 0xb68
// Size: 0x4c
function function_79bafe1d(vehicle) {
    vehicle clientfield::set("cybercom_shortout", 0);
    vehicle clientfield::set("cybercom_surge", 0);
}

// Namespace cybercom
// Params 2, eflags: 0x1 linked
// Checksum 0x8b6f84fa, Offset: 0xbc0
// Size: 0x4e
function function_fabadf47(vehicle, var_b5ddd355) {
    if (var_b5ddd355) {
        vehicle.var_f40d252c = 1;
        return;
    }
    vehicle.var_d3f57f67 = undefined;
    vehicle.var_f40d252c = undefined;
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0x83c8ef19, Offset: 0xc18
// Size: 0x14c
function function_facd1caa() {
    self.cybercom.flags.var_68ec1e9e = self function_814d6f0c();
    self function_4b916b34();
    self.cybercom.flags.type = self function_2eef1193();
    self.cybercom.flags.abilities = [];
    self.cybercom.flags.upgrades = [];
    for (i = 0; i <= 2; i++) {
        self.cybercom.flags.abilities[i] = self function_9d0fefb1(i);
        self.cybercom.flags.upgrades[i] = self function_9d36c436(i);
    }
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0xea6acd9d, Offset: 0xd70
// Size: 0x7e
function function_b6b97f75() {
    self function_facd1caa();
    self.cybercom.var_578ffe14 = self namespace_d00ec32::function_d6be99c6();
    self.cybercom.menu = "AbilityWheel";
    self.pers["cybercom_flags"] = self.cybercom.flags;
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0xda0ce597, Offset: 0xdf8
// Size: 0xf6
function function_222dca46() {
    self function_7bd2c4b9(self.cybercom.flags.var_68ec1e9e);
    self function_751ff137(self.cybercom.flags.type);
    for (i = 0; i <= 2; i++) {
        self function_9a5a502a(self.cybercom.flags.abilities[i], i);
        self function_88655a58(self.cybercom.flags.upgrades[i], i);
    }
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x72c9f525, Offset: 0xef8
// Size: 0x20a
function function_ddcda2fd(flags) {
    if (isdefined(flags)) {
        self.cybercom.flags = flags;
    }
    self function_222dca46();
    self function_b6b97f75();
    foreach (ability in self.cybercom.var_578ffe14) {
        status = self function_1a9006bd(ability.name);
        if (status == 0) {
            continue;
        }
        self namespace_d00ec32::function_c381ce2(ability, status == 2);
    }
    foreach (ability in level.var_ab0cd3b2) {
        status = self function_76f34311(ability.name);
        if (status == 0) {
            continue;
        }
        self cybercom_tacrig::function_fea5c2ac(ability.name, status == 2);
    }
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0xdc551ebc, Offset: 0x1110
// Size: 0x5e
function function_cc812e3b(var_632e4fca) {
    itemindex = getitemindexfromref(var_632e4fca + "_pro");
    if (itemindex != -1) {
        return self isitempurchased(itemindex);
    }
    return 0;
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x8ba64885, Offset: 0x1178
// Size: 0x1ba
function function_8b088b97(var_f1362994) {
    debugmsg("CYBERCORE: " + var_f1362994);
    abilities = namespace_d00ec32::function_ef1b66d4(var_f1362994);
    foreach (ability in abilities) {
        itemindex = getitemindexfromref(ability.name);
        if (self isitempurchased(itemindex)) {
            upgraded = self function_cc812e3b(ability.name);
            self function_ace111f5(ability.name, upgraded);
            debugmsg(ability.name + " UPGRADED: " + upgraded);
            continue;
        }
        debugmsg(ability.name + " NOT INSTALLED");
    }
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x9f684b2c, Offset: 0x1340
// Size: 0xc6
function function_1e4531c7(var_e4230c26) {
    switch (var_e4230c26) {
    case 0:
        self namespace_d00ec32::function_c381ce2(namespace_d00ec32::function_85c33215("cybercom_ravagecore"));
        break;
    case 1:
        self namespace_d00ec32::function_c381ce2(namespace_d00ec32::function_85c33215("cybercom_rapidstrike"));
        break;
    case 2:
        self namespace_d00ec32::function_c381ce2(namespace_d00ec32::function_85c33215("cybercom_es_strike"));
        break;
    }
}

// Namespace cybercom
// Params 2, eflags: 0x1 linked
// Checksum 0xac7a0738, Offset: 0x1410
// Size: 0x3aa
function function_1adaa876(var_e4230c26, var_f4132a83) {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    var_d66f8a9e = int(self getdstat("PlayerStatsList", "LAST_CYBERCOM_EQUIPPED", "statValue"));
    var_2324b7c = var_d66f8a9e & 1024 - 1;
    var_768ee804 = var_d66f8a9e >> 10;
    self function_1e4531c7(var_e4230c26);
    if (isdefined(var_f4132a83) && var_f4132a83 && var_2324b7c > 99 && var_2324b7c < -114) {
        var_cac3be21 = tablelookup("gamedata/stats/cp/cp_statstable.csv", 0, var_2324b7c, 4);
        var_b5725157 = namespace_d00ec32::function_85c33215(var_cac3be21);
        if (self function_1a9006bd(var_b5725157.name)) {
            if (isdefined(self.var_fe7a7fe4) && (var_e4230c26 == var_b5725157.type || self function_6e0bf068() || self.var_fe7a7fe4 == 1)) {
                self function_751ff137(var_b5725157.type);
                self.var_768ee804 = var_768ee804;
                self namespace_d00ec32::function_eb512967(var_b5725157.name, 0);
                self setcontrolleruimodelvalue("AbilityWheel.Selected" + var_b5725157.type + 1, self.var_768ee804);
                return;
            }
        }
    }
    self clientfield::set_to_player("resetAbilityWheel", 1);
    self function_751ff137(var_e4230c26);
    abilities = namespace_d00ec32::function_ef1b66d4(var_e4230c26);
    abilityindex = 1;
    foreach (ability in abilities) {
        if (self function_1a9006bd(ability.name)) {
            self.var_768ee804 = abilityindex;
            self namespace_d00ec32::function_eb512967(ability.name, 0);
            self setcontrolleruimodelvalue("AbilityWheel.Selected" + ability.type + 1, abilityindex);
            return;
        }
        abilityindex++;
    }
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0xb6c787f1, Offset: 0x17c8
// Size: 0x3a
function function_6e0bf068() {
    return isdefined(self.var_8201758a) && isdefined(self.var_8201758a) && (self.cur_ranknum + 1 >= 20 || self.var_8201758a);
}

// Namespace cybercom
// Params 3, eflags: 0x1 linked
// Checksum 0x1576cd02, Offset: 0x1810
// Size: 0x1dc
function function_674d724c(class_num_for_global_weapons, var_f4132a83, var_f69e782a) {
    if (!isdefined(var_f69e782a)) {
        var_f69e782a = 1;
    }
    self endon(#"hash_3f7b661c");
    if (!isdefined(self.var_fe7a7fe4) || self.var_fe7a7fe4 != 1) {
        for (var_f1362994 = 0; var_f1362994 <= 2; var_f1362994++) {
            self function_8b088b97(var_f1362994);
        }
    }
    var_d1833846["cybercore_control"] = 0;
    var_d1833846["cybercore_martial"] = 1;
    var_d1833846["cybercore_chaos"] = 2;
    var_fb135494 = self getloadoutitemref(0, "cybercore");
    if (var_fb135494 != "weapon_null" && var_fb135494 != "weapon_null_cp" && isdefined(var_d1833846[var_fb135494])) {
        self function_1adaa876(var_d1833846[var_fb135494], var_f4132a83);
        self function_b6b97f75();
    }
    if (var_f69e782a) {
        ret = self util::waittill_any_timeout(7, "loadout_changed");
        if (ret != "timeout") {
            function_674d724c(class_num_for_global_weapons, var_f4132a83, 0);
        }
    }
}

// Namespace cybercom
// Params 4, eflags: 0x1 linked
// Checksum 0x7b0d5022, Offset: 0x19f8
// Size: 0x51c
function function_4b8ac464(class_num, class_num_for_global_weapons, var_f4132a83, var_5a13c491) {
    self function_d8df9418();
    var_40cc9116 = self getloadoutitemref(class_num, "cybercom_tacrig1");
    var_1aca16ad = self getloadoutitemref(class_num, "cybercom_tacrig2");
    if (isdefined(var_5a13c491)) {
        var_40cc9116 = var_5a13c491 getloadoutitemref(class_num, "cybercom_tacrig1");
        var_1aca16ad = var_5a13c491 getloadoutitemref(class_num, "cybercom_tacrig2");
    }
    if (strendswith(var_40cc9116, "_pro")) {
        var_40cc9116 = getsubstr(var_40cc9116, 0, var_40cc9116.size - 4);
        var_65303699 = 1;
    } else {
        var_65303699 = 0;
    }
    if (strendswith(var_1aca16ad, "_pro")) {
        var_1aca16ad = getsubstr(var_1aca16ad, 0, var_1aca16ad.size - 4);
        var_2e518e8 = 1;
    } else {
        var_2e518e8 = 0;
    }
    if (isdefined(self.var_8201758a) && self.var_8201758a) {
        var_65303699 = 1;
        var_2e518e8 = 1;
    } else if (class_num < 5) {
        var_65303699 = self function_cc812e3b(var_40cc9116);
        var_2e518e8 = self function_cc812e3b(var_1aca16ad);
        if (isdefined(var_5a13c491)) {
            var_65303699 = var_5a13c491 function_cc812e3b(var_40cc9116);
            var_2e518e8 = var_5a13c491 function_cc812e3b(var_1aca16ad);
        }
    }
    self cybercom_tacrig::function_78908229();
    if (!self flag::exists("in_training_sim") || !self flag::get("in_training_sim")) {
        var_9e7e6766 = self savegame::function_36adbb9c("saved_rig1", undefined);
        if (isdefined(var_9e7e6766)) {
            var_40cc9116 = var_9e7e6766;
            var_65303699 = self savegame::function_36adbb9c("saved_rig1_upgraded", undefined);
            var_1aca16ad = self savegame::function_36adbb9c("saved_rig2", undefined);
            var_2e518e8 = self savegame::function_36adbb9c("saved_rig2_upgraded", undefined);
            assert(isdefined(var_65303699));
        }
    }
    self cybercom_tacrig::function_8ffa26e2(var_40cc9116, var_65303699, 0, 0);
    self cybercom_tacrig::function_8ffa26e2(var_1aca16ad, var_2e518e8, 1, 0);
    if (!self flag::exists("in_training_sim") || !self flag::get("in_training_sim")) {
        self savegame::set_player_data("saved_rig1", var_40cc9116);
        self savegame::set_player_data("saved_rig1_upgraded", var_65303699);
        self savegame::set_player_data("saved_rig2", var_1aca16ad);
        self savegame::set_player_data("saved_rig2_upgraded", var_2e518e8);
    }
    debugmsg("RIG1: " + var_40cc9116 + " UPGRADED:" + var_65303699);
    debugmsg("RIG2: " + var_1aca16ad + " UPGRADED:" + var_2e518e8);
    self thread function_674d724c(class_num_for_global_weapons, var_f4132a83);
}

// Namespace cybercom
// Params 3, eflags: 0x1 linked
// Checksum 0xf4eed652, Offset: 0x1f20
// Size: 0x12c
function function_2006f7d0(slot, weapon, var_775ebc1b) {
    self endon(#"disconnect");
    self endon(#"death");
    self function_e4588dde();
    if (!isdefined(self.cybercom.var_d1460543)) {
        self.cybercom.var_d1460543 = [];
    }
    locks = isdefined(var_775ebc1b) ? var_775ebc1b : getdvarint("scr_max_simLocks");
    assert(locks <= 5, "cybercom_hijack");
    self thread function_17fea3ed(slot, weapon, locks);
    self thread function_d4f9f451(slot, weapon);
    self thread function_348de0be(slot, weapon);
}

// Namespace cybercom
// Params 2, eflags: 0x1 linked
// Checksum 0x349145f9, Offset: 0x2058
// Size: 0x234
function function_348de0be(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_d51412df");
    self endon(#"hash_e9579630");
    self notify(#"hash_348de0be");
    self endon(#"hash_348de0be");
    if (!isdefined(self.cybercom.var_46483c8f)) {
        return;
    }
    if (self.cybercom.var_46483c8f & 1) {
        self thread function_86113d72("weapon_change");
    }
    if (self.cybercom.var_46483c8f & 2) {
        self thread function_86113d72("reload");
    }
    if (self.cybercom.var_46483c8f & 4) {
        self thread function_86113d72("weapon_fired");
    }
    if (self.cybercom.var_46483c8f & 8) {
        self thread function_86113d72("weapon_melee");
        self thread function_86113d72("melee_end");
    }
    if (self.cybercom.var_46483c8f & 16) {
        self thread function_86113d72("weapon_ads");
    }
    if (self.cybercom.var_46483c8f & 32) {
        self thread function_86113d72("damage");
    }
    reason = self waittill(#"hash_3b3a12de");
    self function_29bf9dee(undefined, 8);
    self gadgetdeactivate(slot, weapon, 1);
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x2e07b05e, Offset: 0x2298
// Size: 0x3e
function function_86113d72(note) {
    self endon(#"hash_e9579630");
    self endon(#"hash_3b3a12de");
    self waittill(note);
    self notify(#"hash_3b3a12de", note);
}

// Namespace cybercom
// Params 2, eflags: 0x1 linked
// Checksum 0x99a54ab2, Offset: 0x22e0
// Size: 0x1e4
function function_d4f9f451(slot, weapon) {
    self notify(#"hash_d4f9f451");
    self endon(#"hash_d4f9f451");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_d51412df");
    self endon(#"hash_e9579630");
    while (true) {
        for (i = 0; i < self.cybercom.var_d1460543.size; i++) {
            if (!isdefined(self.cybercom.var_d1460543[i].target)) {
                continue;
            }
            if (!isdefined(self.cybercom.var_d1460543[i].target.var_5001b74f) || self.cybercom.var_d1460543[i].target.var_5001b74f != self) {
                continue;
            }
            if (isdefined(self.cybercom.var_d1460543[i].target.var_1e1a5e6f) && self.cybercom.var_d1460543[i].target.var_1e1a5e6f != 1) {
                continue;
            }
            if (isdefined(self.cybercom.var_73d069a7)) {
                function_c5b2f654(self);
                [[ self.cybercom.var_73d069a7 ]](slot, weapon);
                return;
            }
        }
        wait(0.05);
    }
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x220a16aa, Offset: 0x24d0
// Size: 0x62
function function_d51412df(weapon) {
    self function_a3e55896(weapon);
    waittillframeend();
    function_b04ec032(1);
    self function_f5799ee1();
    self notify(#"hash_e9579630");
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0xdb7c2801, Offset: 0x2540
// Size: 0x9c
function function_f5c296aa(weapon) {
    self notify(#"hash_d51412df");
    self endon(#"hash_d51412df");
    self endon(#"hash_e9579630");
    slot, var_188a4cc0 = self waittill(#"gadget_forced_off");
    if (weapon == var_188a4cc0) {
        self function_d51412df(weapon);
        return;
    }
    self thread function_f5c296aa(weapon);
}

// Namespace cybercom
// Params 1, eflags: 0x5 linked
// Checksum 0x944238d, Offset: 0x25e8
// Size: 0x18c
function private function_7806352d(weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_e9579630");
    event = self util::waittill_any_return(weapon.name + "_fired");
    level notify(#"hash_825eb47e", self, weapon);
    foreach (item in self.cybercom.var_d1460543) {
        if (isdefined(item.target)) {
            item.target notify(#"hash_825eb47e", self, weapon);
            if (isdefined(item.target.var_5001b74f) && item.target.var_5001b74f == self) {
                item.target.var_5001b74f = undefined;
            }
        }
    }
    self function_d51412df(weapon);
}

// Namespace cybercom
// Params 2, eflags: 0x5 linked
// Checksum 0x9030ed22, Offset: 0x2780
// Size: 0x570
function private function_9c5e5a9b(target, var_b3464abe) {
    if (!isdefined(var_b3464abe)) {
        var_b3464abe = 1;
    }
    eyepos = self geteye();
    if (!isdefined(target)) {
        return 0;
    }
    if (!isalive(target)) {
        return 0;
    }
    if (target isragdoll()) {
        return 0;
    }
    if (!isdefined(target.cybercom)) {
        target.cybercom = spawnstruct();
    }
    if (!isdefined(target.cybercom.var_8d2f4636)) {
        target.cybercom.var_8d2f4636 = [];
    }
    pos = target getshootatpos();
    if (isdefined(pos)) {
        passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
        if (passed) {
            target.cybercom.var_8d2f4636[self getentitynumber()] = gettime();
            return 1;
        }
    }
    pos = target getcentroid();
    if (isdefined(pos)) {
        passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
        if (passed) {
            target.cybercom.var_8d2f4636[self getentitynumber()] = gettime();
            return 1;
        }
    }
    if (var_b3464abe) {
        mins = target getmins();
        maxs = target getmaxs();
        var_d11e725f = (maxs[2] - mins[2]) / 4;
        for (i = 0; i <= 4; i++) {
            pos = target.origin + (0, 0, var_d11e725f * i);
            passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
            if (passed) {
                target.cybercom.var_8d2f4636[self getentitynumber()] = gettime();
                return 1;
            }
            pos = target.origin + (mins[0], mins[1], var_d11e725f * i);
            passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
            if (passed) {
                target.cybercom.var_8d2f4636[self getentitynumber()] = gettime();
                return 1;
            }
            pos = target.origin + (maxs[0], maxs[1], var_d11e725f * i);
            passed = bullettracepassed(eyepos, pos, 0, target, undefined, 1, 1);
            if (passed) {
                target.cybercom.var_8d2f4636[self getentitynumber()] = gettime();
                return 1;
            }
        }
        lastseen = target.cybercom.var_8d2f4636[self getentitynumber()];
        if (isdefined(lastseen) && lastseen + getdvarint("scr_los_latency", 3000) > gettime()) {
            trace = bullettrace(eyepos, pos, 0, target);
            distsq = distancesquared(pos, trace["position"]);
            if (distsq <= getdvarint("scr_cached_dist_threshhold", 315 * 315)) {
                return 2;
            } else {
                return 0;
            }
        }
    }
    return 0;
}

// Namespace cybercom
// Params 3, eflags: 0x1 linked
// Checksum 0x682e7666, Offset: 0x2cf8
// Size: 0x318
function function_7a7d1608(target, weapon, var_112e5b60) {
    if (!isdefined(var_112e5b60)) {
        var_112e5b60 = 1;
    }
    result = 1;
    if (!isdefined(target)) {
        return 0;
    }
    if (!isalive(target)) {
        return 0;
    }
    if (target isragdoll()) {
        return 0;
    }
    if (isdefined(target.is_disabled) && target.is_disabled) {
        return 0;
    }
    if (!(isdefined(target.takedamage) && target.takedamage)) {
        return 0;
    }
    if (isdefined(target._ai_melee_opponent)) {
        return 0;
    }
    if (!target isonground() || isactor(target) && isdefined(target.traversestartnode)) {
        return 0;
    }
    if (isdefined(target.var_69dd5d62)) {
        if (target.var_69dd5d62 == 0) {
            return 0;
        }
    } else {
        if (isdefined(target.magic_bullet_shield) && target.magic_bullet_shield) {
            return 0;
        }
        if (isactor(target) && target isinscriptedstate()) {
            if (isdefined(self.var_1b425382)) {
                if (isdefined(self.var_1b425382.position) && issubstr(self.var_1b425382.position, "gunner")) {
                    return 1;
                }
            }
        }
        if (isdefined(target.allowdeath) && !target.allowdeath) {
            return 0;
        }
    }
    if (var_112e5b60 && isdefined(self.cybercom) && isdefined(self.cybercom.var_c40accd3)) {
        result = self [[ self.cybercom.var_c40accd3 ]](target);
    }
    if (result && isdefined(level.var_732e9c7d)) {
        result &= [[ level.var_732e9c7d ]](self, target, weapon);
    }
    if (isdefined(target.var_fb7ce72a)) {
        var_9a8f2571 = target [[ target.var_fb7ce72a ]](self, weapon);
        if (isdefined(var_9a8f2571)) {
            return var_9a8f2571;
        }
    }
    return result;
}

// Namespace cybercom
// Params 3, eflags: 0x1 linked
// Checksum 0xf31e072, Offset: 0x3018
// Size: 0xc4
function function_95dfb5f4(target, maxrange, weapon) {
    if (isdefined(target.var_fb7ce72a)) {
        var_a3ded052 = target [[ target.var_fb7ce72a ]](self, weapon);
        if (isdefined(var_a3ded052)) {
            return var_a3ded052;
        }
    }
    if (isdefined(maxrange)) {
        distancesqr = distancesquared(target.origin, self.origin);
        if (distancesqr > maxrange * maxrange) {
            return 0;
        }
    }
    return 1;
}

// Namespace cybercom
// Params 4, eflags: 0x1 linked
// Checksum 0xd6ac58b7, Offset: 0x30e8
// Size: 0x268
function function_2e65f35d(target, radius, weapon, maxrange) {
    result = 1;
    if (isdefined(target.var_fb7ce72a)) {
        var_a3ded052 = target [[ target.var_fb7ce72a ]](self, weapon);
        if (isdefined(var_a3ded052)) {
            return var_a3ded052;
        }
    }
    isvalid = self function_7a7d1608(target, weapon);
    if (!(isdefined(isvalid) && isvalid)) {
        self function_29bf9dee(target, 1);
        return 0;
    }
    if (isdefined(maxrange)) {
        distancesqr = distancesquared(target.origin, self.origin);
        if (distancesqr > maxrange * maxrange) {
            self function_29bf9dee(target, 3);
            return 0;
        }
    }
    var_edc325e = self function_9c5e5a9b(target);
    if (var_edc325e == 0) {
        self function_29bf9dee(target, 5);
        return 0;
    }
    if (var_edc325e == 2) {
        radius *= 2;
    }
    if (isdefined(radius)) {
        distsq = distancesquared(self.origin, target.origin);
        if (distsq > -112 * -112) {
            result = target_isincircle(target, self, 65, radius);
        }
    }
    if (result == 0) {
        self function_29bf9dee(target, 1);
    }
    return result;
}

// Namespace cybercom
// Params 2, eflags: 0x1 linked
// Checksum 0x39735dc, Offset: 0x3358
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

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0xcfab4795, Offset: 0x33c0
// Size: 0xea
function function_18d9de78(target) {
    if (isdefined(target.var_5001b74f) && target.var_5001b74f == self) {
        function_c5b2f654(self);
        target.var_6c8af4c4 = gettime() - target.var_9d876bed;
        target thread function_5ad57748();
        target.var_9d876bed = undefined;
        target.var_87aa3c26 = gettime() + -106;
        target.var_5001b74f = undefined;
        target.var_9d876bed = undefined;
        target.var_1e1a5e6f = undefined;
        self notify(#"hash_9641f650");
        self notify(#"ccom_lost_lock", target);
    }
}

// Namespace cybercom
// Params 3, eflags: 0x1 linked
// Checksum 0xbb559609, Offset: 0x34b8
// Size: 0x112
function function_d23326c3(slot, note, var_86abddd9) {
    if (isdefined(self.cybercom.var_d1460543[slot])) {
        item = self.cybercom.var_d1460543[slot];
        if (isdefined(item.target)) {
            if (isdefined(note)) {
                item.target notify(note);
            }
            self weaponlocknoclearance(0, item.var_b88e0bc);
            self weaponlockremoveslot(item.var_b88e0bc);
            if (isdefined(var_86abddd9) && var_86abddd9) {
                self function_18d9de78(item.target);
            }
            item.target = undefined;
        }
    }
}

// Namespace cybercom
// Params 1, eflags: 0x5 linked
// Checksum 0x139ccee0, Offset: 0x35d8
// Size: 0xb4
function private function_27fa88d6(player) {
    self endon(#"ccom_lost_lock");
    self notify(#"hash_27fa88d6");
    self endon(#"hash_27fa88d6");
    slot = player function_aecdfd5e(self);
    self util::waittill_any("death", "ccom_lock_fired", "ccom_lock_aborted_unique");
    player weaponlocknoclearance(0, slot);
    player weaponlockremoveslot(slot);
}

// Namespace cybercom
// Params 4, eflags: 0x1 linked
// Checksum 0xcd9a3cf8, Offset: 0x3698
// Size: 0x5e4
function function_f5c2844(slot, target, maxrange, weapon) {
    if (slot == -1 || slot >= getdvarint("scr_max_simLocks")) {
        return;
    }
    if (isdefined(target.var_87aa3c26) && gettime() < target.var_87aa3c26) {
        return;
    }
    if (isdefined(self.cybercom.var_d1460543[slot])) {
        self function_d23326c3(slot, "ccom_lost_lock");
        newitem = self.cybercom.var_d1460543[slot];
        newitem.target = target;
    } else {
        newitem = spawnstruct();
        newitem.target = target;
        newitem.var_b88e0bc = slot;
        self.cybercom.var_d1460543[slot] = newitem;
    }
    if (isdefined(newitem.target)) {
        if (isdefined(newitem.target.var_9147087d) && isdefined(newitem.target.var_9147087d[self.cybercom.var_b6fd26ae.name])) {
            if (!isdefined(newitem.target.var_5001b74f)) {
                newitem.target.var_9d876bed = gettime() - newitem.target.var_6c8af4c4;
                newitem.target.var_5001b74f = self;
                newitem.target notify(#"hash_1bf7ef5");
                curstart = newitem.target.var_6c8af4c4 / newitem.target.var_9147087d[self.cybercom.var_b6fd26ae.name] * 1000;
                function_eae88e7f(self, newitem.target.var_9147087d[self.cybercom.var_b6fd26ae.name], curstart);
                level thread function_9641f650(self);
            }
            if (isdefined(newitem.target.var_5001b74f) && newitem.target.var_5001b74f == self) {
                newitem.target.var_1e1a5e6f = math::clamp((gettime() - newitem.target.var_9d876bed) / newitem.target.var_9147087d[self.cybercom.var_b6fd26ae.name] * 1000, 0, 1);
            }
        }
        self weaponlockstart(newitem.target, newitem.var_b88e0bc);
        newitem.inrange = 1;
        if (!self function_95dfb5f4(newitem.target, maxrange, weapon)) {
            newitem.inrange = 0;
            self weaponlocknoclearance(1, slot);
        }
        if (isdefined(newitem.target.var_1e1a5e6f)) {
            if (newitem.target.var_5001b74f == self) {
                if (newitem.target.var_1e1a5e6f != 1) {
                    newitem.inrange = 2;
                    self weaponlocknoclearance(1, slot);
                }
            } else {
                newitem.inrange = 0;
                self weaponlocknoclearance(1, slot);
            }
        }
        if (newitem.inrange == 1) {
            function_c5b2f654(self);
            self weaponlocknoclearance(0, slot);
            self weaponlockfinalize(newitem.target, newitem.var_b88e0bc);
            newitem.target notify(#"hash_92698df4", self);
            level notify(#"hash_92698df4", newitem.target, self);
        } else {
            newitem.target notify(#"ccom_lock_being_targeted", self);
            level notify(#"ccom_lock_being_targeted", newitem.target, self);
        }
        newitem.target thread function_27fa88d6(self);
    }
}

// Namespace cybercom
// Params 3, eflags: 0x1 linked
// Checksum 0x75e99dfa, Offset: 0x3c88
// Size: 0xe4
function function_eae88e7f(hacker, duration, var_ecbee74c) {
    val = duration & 31;
    if (var_ecbee74c > 0) {
        cur = math::clamp(var_ecbee74c, 0, 1);
        offset = int(cur * -128) << 5;
        val += offset;
    }
    hacker clientfield::set_to_player("hacking_progress", val);
    hacker clientfield::set_to_player("sndCCHacking", 1);
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0xdc432aea, Offset: 0x3d78
// Size: 0x54
function function_c5b2f654(hacker) {
    if (isdefined(hacker)) {
        hacker clientfield::set_to_player("hacking_progress", 0);
        hacker clientfield::set_to_player("sndCCHacking", 0);
    }
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0xef551414, Offset: 0x3dd8
// Size: 0x84
function function_9641f650(hacker) {
    hacker endon(#"disconnect");
    hacker notify(#"hash_9641f650");
    hacker endon(#"hash_9641f650");
    hacker util::waittill_any("death", "ccom_lockOnProgress_Cleared", "ccom_lost_lock", "ccom_locked_on");
    function_c5b2f654(hacker);
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0xf74302bd, Offset: 0x3e68
// Size: 0x9c
function function_aecdfd5e(target) {
    for (i = 0; i < self.cybercom.var_d1460543.size; i++) {
        if (!isdefined(self.cybercom.var_d1460543[i].target)) {
            continue;
        }
        if (self.cybercom.var_d1460543[i].target == target) {
            return i;
        }
    }
    return -1;
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0x717d8181, Offset: 0x3f10
// Size: 0xa2
function function_47af001d() {
    targets = [];
    for (i = 0; i < self.cybercom.var_d1460543.size; i++) {
        if (!isdefined(self.cybercom.var_d1460543[i].target)) {
            continue;
        }
        targets[targets.size] = self.cybercom.var_d1460543[i].target;
    }
    return targets;
}

// Namespace cybercom
// Params 2, eflags: 0x1 linked
// Checksum 0xee1fa0cb, Offset: 0x3fc0
// Size: 0x364
function function_70bb0188(target, force) {
    if (!isdefined(force)) {
        force = 0;
    }
    if (self.cybercom.var_d1460543.size < getdvarint("scr_max_simLocks")) {
        return self.cybercom.var_d1460543.size;
    }
    var_2b28b05a = self function_aecdfd5e(target);
    if (var_2b28b05a != -1) {
        return var_2b28b05a;
    }
    slot = -1;
    playerforward = anglestoforward(self getplayerangles());
    dots = [];
    for (i = 0; i < self.cybercom.var_d1460543.size; i++) {
        locktarget = self.cybercom.var_d1460543[i].target;
        if (!isdefined(locktarget)) {
            return i;
        }
        newitem = spawnstruct();
        newitem.dot = vectordot(playerforward, vectornormalize(locktarget.origin - self.origin));
        var_f72b478f = isdefined(self.cybercom.var_f72b478f) ? self.cybercom.var_f72b478f : 0.83;
        if (newitem.dot > var_f72b478f) {
            newitem.target = locktarget;
            array::function_5fee9333(dots, &targetinsertionsortcompare, newitem);
        }
    }
    newitem = spawnstruct();
    newitem.dot = vectordot(playerforward, vectornormalize(target.origin - self.origin));
    newitem.target = target;
    array::function_5fee9333(dots, &targetinsertionsortcompare, newitem);
    var_20abbd09 = dots[dots.size - 1].target;
    if (!force && var_20abbd09 == target) {
        return -1;
    }
    return self function_aecdfd5e(var_20abbd09);
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0xc6e9f9cf, Offset: 0x4330
// Size: 0xc0
function function_b04ec032(var_86abddd9) {
    if (!isdefined(var_86abddd9)) {
        var_86abddd9 = 0;
    }
    if (isdefined(self.cybercom) && isdefined(self.cybercom.var_d1460543)) {
        for (i = 0; i < self.cybercom.var_d1460543.size; i++) {
            self function_d23326c3(i, undefined, var_86abddd9);
        }
    }
    self weaponlockremoveslot(-1);
    self.cybercom.var_d1460543 = [];
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x6efec0a0, Offset: 0x43f8
// Size: 0x304
function function_b5f4e597(weapon) {
    self endon(#"disconnect");
    self notify(#"hash_b5f4e597");
    self endon(#"hash_b5f4e597");
    if (weapon.requirelockontofire) {
        maxrange = 1500;
        if (isdefined(weapon.lockonmaxrange)) {
            maxrange = weapon.lockonmaxrange;
        }
        var_e80a7386 = maxrange * maxrange;
    } else {
        var_e80a7386 = 0;
    }
    var_6f023b72 = 0;
    while (self hasweapon(weapon)) {
        if (var_e80a7386 > 0) {
            if (isdefined(self.cybercom.var_9d8e0758)) {
                enemies = self [[ self.cybercom.var_9d8e0758 ]](weapon);
            } else {
                enemies = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
            }
            foreach (enemy in enemies) {
                distsq = distancesquared(self.origin, enemy.origin);
                if (distsq > var_e80a7386) {
                    continue;
                }
                var_b766574c = self.cybercom.var_b766574c;
                var_42d20903 = self.cybercom.var_42d20903;
                if (!function_7a7d1608(enemy, weapon)) {
                    self.cybercom.var_b766574c = var_b766574c;
                    self.cybercom.var_42d20903 = var_42d20903;
                    continue;
                }
                var_6f023b72 = 1;
                break;
            }
        } else {
            var_6f023b72 = 1;
        }
        self clientfield::set_player_uimodel("playerAbilities.inRange", var_6f023b72);
        wait(0.05);
    }
    var_6f023b72 = 0;
    self clientfield::set_player_uimodel("playerAbilities.inRange", var_6f023b72);
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0x61cac150, Offset: 0x4708
// Size: 0xc0
function function_5ad57748() {
    self endon(#"death");
    self notify(#"hash_5ad57748");
    self endon(#"hash_5ad57748");
    self endon(#"hash_1bf7ef5");
    var_82361971 = int(getdvarfloat("scr_hacktime_decay_rate", 0.25) / 20 * 1000);
    while (self.var_6c8af4c4 > 0) {
        wait(0.05);
        self.var_6c8af4c4 -= var_82361971;
        if (self.var_6c8af4c4 < 0) {
            self.var_6c8af4c4 = 0;
        }
    }
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0xf4fe5f35, Offset: 0x47d0
// Size: 0x214
function function_f5799ee1() {
    if (!isdefined(self.cybercom.var_4eb8cd67) || self.cybercom.var_4eb8cd67.size == 0) {
        return;
    }
    var_4eb8cd67 = [];
    foreach (target in self.cybercom.var_4eb8cd67) {
        if (!isdefined(target)) {
            continue;
        }
        found = 0;
        if (self.cybercom.var_d1460543.size) {
            foreach (var_9ddde835 in self.cybercom.var_d1460543) {
                if (!isdefined(var_9ddde835.target)) {
                    continue;
                }
                if (var_9ddde835.target == target) {
                    found = 1;
                    break;
                }
            }
        }
        if (!found) {
            target notify(#"ccom_lost_lock", self);
            level notify(#"ccom_lost_lock", target, self);
            self function_18d9de78(target);
            continue;
        }
        var_4eb8cd67[var_4eb8cd67.size] = target;
    }
    self.cybercom.var_4eb8cd67 = var_4eb8cd67;
}

// Namespace cybercom
// Params 3, eflags: 0x1 linked
// Checksum 0xee5f5d4a, Offset: 0x49f0
// Size: 0x9a6
function function_17fea3ed(slot, weapon, maxtargets) {
    self notify(#"hash_e9579630");
    self endon(#"hash_e9579630");
    self endon(#"weapon_change");
    self endon(#"disconnect");
    self endon(#"death");
    radius = isdefined(self.cybercom.var_23d4a73a) ? self.cybercom.var_23d4a73a : -126;
    if (!isdefined(maxtargets)) {
        maxtargets = 3;
    }
    self thread function_7806352d(weapon);
    self thread function_f5c296aa(weapon);
    if (maxtargets < 1) {
        maxtargets = 1;
    }
    if (maxtargets > 5) {
        maxtargets = 5;
    }
    maxrange = 1500;
    if (isdefined(weapon.lockonmaxrange)) {
        maxrange = weapon.lockonmaxrange;
    }
    validtargets = [];
    dots = [];
    while (self hasweapon(weapon)) {
        wait(0.05);
        self function_f5799ee1();
        self function_b04ec032();
        self.cybercom.var_b766574c = 0;
        if (isdefined(self.cybercom.var_9d8e0758)) {
            enemies = self [[ self.cybercom.var_9d8e0758 ]](weapon);
        } else {
            enemies = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
        }
        if (enemies.size == 0) {
            self function_29bf9dee(undefined, 1);
        }
        var_ab2554ab = [];
        playerforward = anglestoforward(self getplayerangles());
        var_6f14dd02 = self gettagorigin("tag_aim");
        foreach (enemy in enemies) {
            center = enemy getcentroid();
            dirtotarget = vectornormalize(center - var_6f14dd02);
            enemy.var_4ddba9ea = vectordot(dirtotarget, playerforward);
            if (isdefined(enemy.var_fb7ce72a)) {
                result = enemy [[ enemy.var_fb7ce72a ]](self, weapon);
                if (isdefined(result) && result) {
                    var_ab2554ab[var_ab2554ab.size] = enemy;
                    continue;
                }
            }
            var_f72b478f = isdefined(self.cybercom.var_f72b478f) ? self.cybercom.var_f72b478f : 0.83;
            if (enemy.var_4ddba9ea > var_f72b478f) {
                var_ab2554ab[var_ab2554ab.size] = enemy;
            }
        }
        if (var_ab2554ab.size == 0) {
            self function_29bf9dee(undefined, 1);
            continue;
        }
        validtargets = [];
        potentialtargets = [];
        foreach (enemy in var_ab2554ab) {
            if (!isdefined(enemy)) {
                continue;
            }
            if (!self function_2e65f35d(enemy, radius, weapon, maxrange)) {
                continue;
            }
            validtargets[validtargets.size] = enemy;
        }
        var_304647c9 = dots.size;
        dots = [];
        foreach (target in validtargets) {
            newitem = spawnstruct();
            newitem.dot = target.var_4ddba9ea;
            newitem.target = target;
            array::function_5fee9333(dots, &targetinsertionsortcompare, newitem);
        }
        if (dots.size) {
            i = 0;
            foreach (item in dots) {
                i++;
                if (i > maxtargets) {
                    break;
                }
                if (isdefined(item.target)) {
                    if (isdefined(item.target.var_ced13b2f) && item.target.var_ced13b2f && self function_aecdfd5e(item.target) == -1) {
                        foreach (other in self.cybercom.var_4eb8cd67) {
                            if (other == item.target) {
                                continue;
                            }
                            if (isdefined(other.var_ced13b2f) && other.var_ced13b2f) {
                                item.target = undefined;
                                break;
                            }
                        }
                    }
                    if (!isdefined(item.target)) {
                        continue;
                    }
                    if (self function_aecdfd5e(item.target) != -1) {
                        continue;
                    }
                    slot = self function_70bb0188(item.target);
                    if (slot == -1) {
                        continue;
                    }
                    if (!isinarray(self.cybercom.var_4eb8cd67, item.target)) {
                        self.cybercom.var_4eb8cd67[self.cybercom.var_4eb8cd67.size] = item.target;
                    }
                    self function_f5c2844(slot, item.target, maxrange, weapon);
                }
            }
            self playrumbleonentity("damage_light");
        }
    }
    self notify(#"hash_e9579630");
}

/#

    // Namespace cybercom
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5441e03a, Offset: 0x53a0
    // Size: 0x40
    function function_252cee46() {
        self endon(#"death");
        for (;;) {
            debug_arrow(self.origin, self.angles);
            wait(0.05);
        }
    }

    // Namespace cybercom
    // Params 3, eflags: 0x1 linked
    // Checksum 0xaece29d4, Offset: 0x53e8
    // Size: 0x2bc
    function debug_arrow(org, ang, opcolor) {
        forward = anglestoforward(ang);
        forwardfar = vectorscale(forward, 50);
        forwardclose = vectorscale(forward, 50 * 0.8);
        right = anglestoright(ang);
        leftdraw = vectorscale(right, 50 * -0.2);
        rightdraw = vectorscale(right, 50 * 0.2);
        up = anglestoup(ang);
        right = vectorscale(right, 50);
        up = vectorscale(up, 50);
        red = (0.9, 0.2, 0.2);
        green = (0.2, 0.9, 0.2);
        blue = (0.2, 0.2, 0.9);
        if (isdefined(opcolor)) {
            red = opcolor;
            green = opcolor;
            blue = opcolor;
        }
        line(org, org + forwardfar, red, 0.9);
        line(org + forwardfar, org + forwardclose + rightdraw, red, 0.9);
        line(org + forwardfar, org + forwardclose + leftdraw, red, 0.9);
        line(org, org + right, blue, 0.9);
        line(org, org + up, green, 0.9);
    }

    // Namespace cybercom
    // Params 4, eflags: 0x1 linked
    // Checksum 0xbda5ff5, Offset: 0x56b0
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

#/

// Namespace cybercom
// Params 3, eflags: 0x1 linked
// Checksum 0xe137cf18, Offset: 0x5760
// Size: 0x74
function function_5ee38fe3(origin, entarray, max) {
    if (!isdefined(entarray)) {
        return;
    }
    if (entarray.size == 0) {
        return;
    }
    arraysortclosest(entarray, origin, 1, 0, isdefined(max) ? max : 2048);
    return entarray[0];
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x689e4a2c, Offset: 0x57e0
// Size: 0xb2
function function_cf41922d(name) {
    ability = namespace_d00ec32::function_85c33215(name);
    if (isdefined(ability)) {
        shift = 8 * ability.type;
        return (ability.flag << shift);
    }
    if (isdefined(level.var_ab0cd3b2[name])) {
        return (1 << 24 + level.var_ab0cd3b2[name].type);
    }
    return;
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0xdbc7e41, Offset: 0x58a0
// Size: 0x106
function function_58c312f2() {
    if (!isdefined(self)) {
        return;
    }
    self function_e4588dde();
    foreach (ability in level.cybercom.abilities) {
        if (!isdefined(ability)) {
            continue;
        }
        flag = function_cf41922d(ability.name);
        if (isdefined(flag)) {
            self.cybercom.var_6f227ef9 |= flag;
        }
    }
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0xa21d9079, Offset: 0x59b0
// Size: 0x80
function function_59965309(name) {
    if (!isdefined(self)) {
        return;
    }
    flag = function_cf41922d(name);
    if (!isdefined(flag)) {
        return;
    }
    self function_e4588dde();
    self.cybercom.var_6f227ef9 |= flag;
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x2060018b, Offset: 0x5a38
// Size: 0x84
function function_a1f70a02(name) {
    if (!isdefined(self)) {
        return;
    }
    self function_e4588dde();
    flag = function_cf41922d(name);
    if (!isdefined(flag)) {
        return;
    }
    self.cybercom.var_6f227ef9 &= ~flag;
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0xa112f33, Offset: 0x5ac8
// Size: 0xa0
function function_8fd8f5b1(name) {
    if (!isdefined(self)) {
        return false;
    }
    if (isdefined(self.nocybercom) && self.nocybercom) {
        return true;
    }
    self function_e4588dde();
    flag = function_cf41922d(name);
    if (!isdefined(flag)) {
        return false;
    }
    if (self.cybercom.var_6f227ef9 & flag) {
        return true;
    }
    return false;
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0xd2bfaeac, Offset: 0x5b70
// Size: 0x54
function function_e4588dde() {
    if (!isdefined(self.cybercom)) {
        self.cybercom = spawnstruct();
    }
    if (!isdefined(self.cybercom.var_6f227ef9)) {
        self.cybercom.var_6f227ef9 = 0;
    }
}

// Namespace cybercom
// Params 2, eflags: 0x1 linked
// Checksum 0x179c50d2, Offset: 0x5bd0
// Size: 0x44
function function_28d7b2ad(note, animname) {
    self endon(note);
    self endon(#"death");
    self waittillmatch(animname, "end");
    self notify(note);
}

// Namespace cybercom
// Params 5, eflags: 0x1 linked
// Checksum 0x4e962aac, Offset: 0x5c20
// Size: 0x164
function function_cf64f12c(note, animname, kill, attacker, weapon) {
    if (!isdefined(kill)) {
        kill = 0;
    }
    self notify("stopOnNotify" + note + animname);
    self endon("stopOnNotify" + note + animname);
    if (isdefined(animname)) {
        self thread function_28d7b2ad("stopOnNotify" + note + animname, animname);
    }
    self util::waittill_any_return(note, "death");
    if (isdefined(self) && self isinscriptedstate()) {
        self stopanimscripted(0.3);
    }
    if (isdefined(kill) && isalive(self) && kill) {
        self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
    }
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0x8221df29, Offset: 0x5d90
// Size: 0xd0
function function_421746e0() {
    if (isdefined(self.allowdeath)) {
        if (self.allowdeath == 0) {
            return false;
        }
    }
    if (isdefined(self.var_770a8906) && self.var_770a8906) {
        return true;
    }
    if (isdefined(self.var_1b425382)) {
        return true;
    }
    if (isdefined(self.archetype) && self.archetype == "robot" && !function_76e3026d(self)) {
        return true;
    }
    if (isactor(self) && !self isonground()) {
        return true;
    }
    return false;
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0x154c4168, Offset: 0x5e68
// Size: 0x1c
function islinked() {
    return isdefined(self getlinkedent());
}

// Namespace cybercom
// Params 2, eflags: 0x1 linked
// Checksum 0x10157c9f, Offset: 0x5e90
// Size: 0xf0
function function_8257bcb3(context, max) {
    if (!isdefined(max)) {
        max = 2;
    }
    if (!isdefined(self.cybercom.variants)) {
        self.cybercom.variants = [];
    }
    if (isdefined(self.cybercom.variants[context])) {
        self.cybercom.variants[context] = undefined;
    }
    self.cybercom.variants[context] = spawnstruct();
    self.cybercom.variants[context].var_9689b47c = 0;
    self.cybercom.variants[context].var_51b4aeb8 = max;
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x87e89e14, Offset: 0x5f88
// Size: 0x132
function function_e06423b6(context) {
    if (!isdefined(self.cybercom) || !isdefined(self.cybercom.variants) || !isdefined(self.cybercom.variants[context])) {
        return "";
    }
    cur = self.cybercom.variants[context].var_9689b47c;
    self.cybercom.variants[context].var_9689b47c++;
    if (self.cybercom.variants[context].var_9689b47c > self.cybercom.variants[context].var_51b4aeb8) {
        self.cybercom.variants[context].var_9689b47c = 0;
    }
    if (cur == 0) {
        return "";
    }
    return "_" + cur;
}

// Namespace cybercom
// Params 6, eflags: 0x0
// Checksum 0xf70e5f51, Offset: 0x60c8
// Size: 0xa4
function function_a2ec096c(origin, mins, maxs, yaw, frames, color) {
    if (!isdefined(yaw)) {
        yaw = 0;
    }
    if (!isdefined(frames)) {
        frames = 20;
    }
    if (!isdefined(color)) {
        color = (1, 0, 0);
    }
    /#
        box(origin, mins, maxs, yaw, color, 1, 0, frames);
    #/
}

// Namespace cybercom
// Params 5, eflags: 0x1 linked
// Checksum 0xf77bd5ee, Offset: 0x6178
// Size: 0xe4
function debug_sphere(origin, radius, color, alpha, timeframes) {
    if (!isdefined(color)) {
        color = (1, 0, 0);
    }
    if (!isdefined(alpha)) {
        alpha = 0.1;
    }
    if (!isdefined(timeframes)) {
        timeframes = 1;
    }
    /#
        sides = int(10 * (1 + int(radius) % 100));
        sphere(origin, radius, color, alpha, 1, sides, timeframes);
    #/
}

// Namespace cybercom
// Params 2, eflags: 0x0
// Checksum 0xd840ce16, Offset: 0x6268
// Size: 0x36
function function_d1686f4c(note, seconds) {
    self endon(note);
    self endon(#"death");
    wait(seconds);
    self notify(note);
}

// Namespace cybercom
// Params 2, eflags: 0x0
// Checksum 0xfbcd0fc8, Offset: 0x62a8
// Size: 0x3a
function function_b4daec13(note, var_7ad67496) {
    self endon(note);
    self endon(#"death");
    self waittill(var_7ad67496);
    self notify(note);
}

// Namespace cybercom
// Params 2, eflags: 0x1 linked
// Checksum 0xe2091ed3, Offset: 0x62f0
// Size: 0x4c
function function_f569ef38(note, ent) {
    ent endon(#"death");
    self waittill(note);
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x382f8377, Offset: 0x6348
// Size: 0x2c
function function_f8669cbf(var_9b185703) {
    clientfield::increment("cyber_arm_pulse", var_9b185703);
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0x99770fb6, Offset: 0x6380
// Size: 0x52
function getentitypose() {
    assert(isactor(self), "cybercom_hijack");
    return blackboard::getblackboardattribute(self, "_stance");
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0xf4eeefae, Offset: 0x63e0
// Size: 0x8e
function function_5e3d3aa() {
    assert(isactor(self), "cybercom_hijack");
    stance = self getentitypose();
    if (stance == "stand") {
        return "stn";
    }
    if (stance == "crouch") {
        return "crc";
    }
    return "";
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0xd5d761fd, Offset: 0x6478
// Size: 0x34
function debugmsg(txt) {
    println("cybercom_hijack" + txt);
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x7c69e97b, Offset: 0x64b8
// Size: 0x8c
function function_76e3026d(entity) {
    if (isdefined(entity.missinglegs) && entity.missinglegs) {
        return 0;
    }
    if (isdefined(entity.iscrawler) && entity.iscrawler) {
        return 0;
    }
    return gibserverutils::isgibbed(entity, 384) == 0 ? 1 : 0;
}

// Namespace cybercom
// Params 4, eflags: 0x1 linked
// Checksum 0x45ed2f18, Offset: 0x6550
// Size: 0x5c
function function_c3c6aff4(slot, weapon, var_ecc9d566, endnote) {
    self endon(#"death");
    self endon(endnote);
    self waittill(var_ecc9d566);
    self gadgetdeactivate(slot, weapon);
}

// Namespace cybercom
// Params 2, eflags: 0x1 linked
// Checksum 0x9a705051, Offset: 0x65b8
// Size: 0xc6
function function_adc40f11(weapon, fired) {
    if (fired) {
        self notify(weapon.name + "_fired");
        level notify(weapon.name + "_fired");
        self notify(#"hash_81c0052c", weapon);
        bb::function_42ffd679(self, "fired", weapon);
        self gadgettargetresult(1);
        return;
    }
    self gadgettargetresult(0);
    self notify(#"hash_2bc5d416", weapon);
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x75a0197c, Offset: 0x6688
// Size: 0x270
function function_a3e55896(weapon) {
    if (self.cybercom.var_d1460543.size == 0 || self.cybercom.var_b766574c != 0 && self.cybercom.var_b766574c == 8) {
        if (self.cybercom.var_b766574c == 2 && isdefined(self.cybercom.var_42d20903)) {
            var_edc325e = self function_9c5e5a9b(self.cybercom.var_42d20903, 0);
            if (var_edc325e == 0) {
                self.cybercom.var_b766574c = 1;
            }
        }
        switch (self.cybercom.var_b766574c) {
        case 2:
            self settargetwrongtypehint(weapon);
            break;
        case 3:
            self settargetoorhint(weapon);
            break;
        case 4:
            self settargetalreadyinusehint(weapon);
            break;
        case 1:
            self setnotargetshint(weapon);
            break;
        case 5:
            self setnolosontargetshint(weapon);
            break;
        case 6:
            self setdisabledtargethint(weapon);
            break;
        case 7:
            self settargetalreadytargetedhint(weapon);
            break;
        case 8:
            self settargetingabortedhint(weapon);
            break;
        }
        level notify(#"hash_dce473f9", self, self.cybercom.var_b766574c);
        self notify(#"hash_dce473f9", self.cybercom.var_b766574c);
        self.cybercom.var_b766574c = 0;
    }
}

// Namespace cybercom
// Params 4, eflags: 0x1 linked
// Checksum 0xad17d725, Offset: 0x6900
// Size: 0x148
function function_29bf9dee(var_42d20903, var_b766574c, var_10853dc3, priority) {
    if (!isdefined(var_10853dc3)) {
        var_10853dc3 = 1;
    }
    if (!isdefined(priority)) {
        priority = 1;
    }
    if (!isplayer(self) || !isdefined(self.cybercom)) {
        return;
    }
    if (var_10853dc3 && !(isdefined(self.cybercom.var_301030f7) && self.cybercom.var_301030f7)) {
        return;
    }
    if (!(isdefined(self.cybercom.var_8967863e) && self.cybercom.var_8967863e)) {
        return;
    }
    if (priority) {
        if (var_b766574c > self.cybercom.var_b766574c) {
            self.cybercom.var_b766574c = var_b766574c;
            self.cybercom.var_42d20903 = var_42d20903;
        }
        return;
    }
    self.cybercom.var_b766574c = var_b766574c;
    self.cybercom.var_42d20903 = var_42d20903;
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x81828564, Offset: 0x6a50
// Size: 0x74
function getyawtospot(spot) {
    pos = spot;
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace cybercom
// Params 1, eflags: 0x1 linked
// Checksum 0x9bf0ca, Offset: 0x6ad0
// Size: 0x42
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace cybercom
// Params 3, eflags: 0x1 linked
// Checksum 0xb46eb2c0, Offset: 0x6b20
// Size: 0x196
function function_5ad6b98d(eattacker, eplayer, idamage) {
    if (!isplayer(eplayer) || !isdefined(eattacker) || !isdefined(eattacker.aitype)) {
        return idamage;
    }
    if (!isdefined(eplayer.cybercom.var_5e76d31b) || !eplayer.cybercom.var_5e76d31b) {
        return idamage;
    }
    var_31dd08f5 = level.var_e4e6dd84[eattacker.aitype];
    if (!isdefined(var_31dd08f5)) {
        var_31dd08f5 = level.var_e4e6dd84["default"];
    }
    damage_scale = 1;
    distancetoplayer = distance(eattacker.origin, eplayer.origin);
    if (distancetoplayer < 750) {
        damage_scale = var_31dd08f5.var_974cd16f;
    } else if (distancetoplayer < 1500) {
        damage_scale = var_31dd08f5.var_e909f6f0;
    } else {
        damage_scale = var_31dd08f5.var_3d1b9c0c;
    }
    return idamage * damage_scale;
}

// Namespace cybercom
// Params 0, eflags: 0x1 linked
// Checksum 0xa4fb3533, Offset: 0x6cc0
// Size: 0x58
function function_1be27df7() {
    if (self.currentweapon == getweapon("gadget_unstoppable_force") || isdefined(self.currentweapon) && self.currentweapon == getweapon("gadget_unstoppable_force_upgraded")) {
        return true;
    }
    return false;
}

