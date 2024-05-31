#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_6d813654;

// Namespace namespace_6d813654
// Params 0, eflags: 0x2
// namespace_6d813654<file_0>::function_2dc19561
// Checksum 0x40bf0fe8, Offset: 0x388
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_equip_hacker", &__init__, &__main__, undefined);
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_8c87d8eb
// Checksum 0x7fd05cc3, Offset: 0x3d0
// Size: 0x12c
function __init__() {
    zm_equipment::register("equip_hacker", %ZOMBIE_EQUIP_HACKER_PICKUP_HINT_STRING, %ZOMBIE_EQUIP_HACKER_HOWTO, undefined, "hacker");
    level.var_c919fdca = [];
    level.var_f623598a = [];
    callback::on_connect(&function_bba1feec);
    callback::on_spawned(&function_fa12cef4);
    level thread function_a7c3e09a();
    level thread function_7fae632a();
    level thread function_c35fff84();
    if (getdvarint("scr_debug_hacker") == 1) {
        level thread function_9049492b();
    }
    level.var_bbd4901d = getweapon("equip_hacker");
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_5b6b9132
// Checksum 0x2f76f0a5, Offset: 0x508
// Size: 0x34
function __main__() {
    zm_equipment::register_for_level("equip_hacker");
    zm_equipment::include("equip_hacker");
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_fa12cef4
// Checksum 0x71e35195, Offset: 0x548
// Size: 0x34
function function_fa12cef4() {
    self thread function_b743c597();
    self thread function_778301bd();
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_c35fff84
// Checksum 0xfbb38e7d, Offset: 0x588
// Size: 0x1b6
function function_c35fff84() {
    while (true) {
        level waittill(#"end_of_round");
        if (!isdefined(level.var_49486970)) {
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                if (isdefined(players[i] zm_equipment::get_player_equipment()) && players[i] zm_equipment::get_player_equipment() == level.var_bbd4901d) {
                    if (isdefined(players[i].equipment_got_in_round[level.var_bbd4901d])) {
                        var_d0962564 = players[i].equipment_got_in_round[level.var_bbd4901d];
                        var_86bce82d = level.round_number - var_d0962564;
                        var_86bce82d -= 1;
                        if (var_86bce82d > 0) {
                            var_86bce82d = min(var_86bce82d, 5);
                            score = var_86bce82d * 500;
                            players[i] zm_score::add_to_player_score(int(score));
                        }
                    }
                }
            }
            continue;
        }
        level.var_49486970 = undefined;
    }
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_9049492b
// Checksum 0x68f4a329, Offset: 0x748
// Size: 0x18c
function function_9049492b() {
    while (true) {
        for (i = 0; i < level.var_c919fdca.size; i++) {
            hackable = level.var_c919fdca[i];
            if (isdefined(hackable.pooled) && hackable.pooled) {
                if (isdefined(hackable._trigger)) {
                    col = (0, 255, 0);
                    if (isdefined(hackable.var_db47953c)) {
                        col = hackable.var_db47953c;
                    }
                    /#
                        print3d(hackable.origin, "trigger_", col, 1, 1);
                    #/
                } else {
                    /#
                        print3d(hackable.origin, "trigger_", (0, 0, 255), 1, 1);
                    #/
                }
                continue;
            }
            /#
                print3d(hackable.origin, "trigger_", (255, 0, 0), 1, 1);
            #/
        }
        wait(0.1);
    }
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_7fae632a
// Checksum 0x5c9cb870, Offset: 0x8e0
// Size: 0xcc
function function_7fae632a() {
    if (!isdefined(level.var_b9554289)) {
        level.var_b9554289 = 8;
    }
    var_21c8d8 = 0;
    level.var_ea3a2497 = [];
    while (true) {
        if (var_21c8d8) {
            if (!function_acac2fc2()) {
                function_52f0c27c();
            } else {
                function_cedb49a2();
                function_70b869d1();
            }
        } else if (function_acac2fc2()) {
            var_21c8d8 = 1;
        }
        wait(0.1);
    }
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_52f0c27c
// Checksum 0x8d88849f, Offset: 0x9b8
// Size: 0x88
function function_52f0c27c() {
    var_21c8d8 = 0;
    for (i = 0; i < level.var_ea3a2497.size; i++) {
        level.var_ea3a2497[i]._trigger delete();
        level.var_ea3a2497[i]._trigger = undefined;
    }
    level.var_ea3a2497 = [];
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_cedb49a2
// Checksum 0x17107939, Offset: 0xa48
// Size: 0xe8
function function_cedb49a2() {
    var_af1dff97 = [];
    for (i = 0; i < level.var_ea3a2497.size; i++) {
        if (level.var_ea3a2497[i] function_eebaacb4()) {
            var_af1dff97[var_af1dff97.size] = level.var_ea3a2497[i];
            continue;
        }
        if (isdefined(level.var_ea3a2497[i]._trigger)) {
            level.var_ea3a2497[i]._trigger delete();
        }
        level.var_ea3a2497[i]._trigger = undefined;
    }
    level.var_ea3a2497 = var_af1dff97;
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_eebaacb4
// Checksum 0xce47b176, Offset: 0xb38
// Size: 0x12c
function function_eebaacb4() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i] zm_equipment::hacker_active()) {
            if (isdefined(self.entity)) {
                if (self.entity != players[i]) {
                    if (distance2dsquared(players[i].origin, self.entity.origin) <= self.radius * self.radius) {
                        return true;
                    }
                }
                continue;
            }
            if (distance2dsquared(players[i].origin, self.origin) <= self.radius * self.radius) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_70b869d1
// Checksum 0x50de5e97, Offset: 0xc70
// Size: 0x270
function function_70b869d1() {
    candidates = [];
    for (i = 0; i < level.var_c919fdca.size; i++) {
        hackable = level.var_c919fdca[i];
        if (isdefined(hackable.pooled) && hackable.pooled && !isdefined(hackable._trigger)) {
            if (!isinarray(level.var_ea3a2497, hackable)) {
                if (hackable function_eebaacb4()) {
                    candidates[candidates.size] = hackable;
                }
            }
        }
    }
    for (i = 0; i < candidates.size; i++) {
        candidate = candidates[i];
        height = 72;
        radius = 32;
        if (isdefined(candidate.radius)) {
            radius = candidate.radius;
        }
        if (isdefined(candidate.height)) {
            height = candidate.height;
        }
        trigger = spawn("trigger_radius_use", candidate.origin, 0, radius, height);
        trigger usetriggerrequirelookat();
        trigger triggerignoreteam();
        trigger setcursorhint("HINT_NOICON");
        trigger.radius = radius;
        trigger.height = height;
        trigger.beinghacked = 0;
        candidate._trigger = trigger;
        level.var_ea3a2497[level.var_ea3a2497.size] = candidate;
    }
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x0
// namespace_6d813654<file_0>::function_c0b1504
// Checksum 0x5f856108, Offset: 0xee8
// Size: 0x94
function function_c0b1504() {
    if (isdefined(self.door)) {
        return self.door;
    }
    if (isdefined(self.perk)) {
        return self.perk;
    }
    if (isdefined(self.window)) {
        return self.window.unitrigger_stub.trigger;
    }
    if (isdefined(self.classname) && getsubstr(self.classname, 0, 7) == "trigger_") {
        return self;
    }
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_acac2fc2
// Checksum 0xfa42406a, Offset: 0xf88
// Size: 0x70
function function_acac2fc2() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i] zm_equipment::hacker_active()) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_6d813654
// Params 3, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_cf413d9a
// Checksum 0xe9cdd9ac, Offset: 0x1000
// Size: 0x1ee
function function_cf413d9a(name, var_7f647925, qualifier_func) {
    structs = struct::get_array(name, "script_noteworthy");
    if (!isdefined(structs)) {
        println("trigger_" + name + "trigger_");
        return;
    }
    for (i = 0; i < structs.size; i++) {
        if (!isinarray(level.var_c919fdca, structs[i])) {
            structs[i].var_67f708a8 = var_7f647925;
            structs[i].var_73dfc737 = qualifier_func;
            structs[i].pooled = level.var_826a0c5c;
            if (isdefined(structs[i].targetname)) {
                structs[i].var_90fb1e1d = getent(structs[i].targetname, "targetname");
            }
            level.var_c919fdca[level.var_c919fdca.size] = structs[i];
            if (isdefined(level.var_826a0c5c)) {
                level.var_f623598a[level.var_f623598a.size] = structs[i];
            }
            structs[i] thread function_ff2d4d2b();
            util::wait_network_frame();
        }
    }
}

// Namespace namespace_6d813654
// Params 3, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_e6296c4e
// Checksum 0x86a188ed, Offset: 0x11f8
// Size: 0x114
function function_e6296c4e(struct, var_7f647925, qualifier_func) {
    if (!isinarray(level.var_c919fdca, struct)) {
        struct.var_67f708a8 = var_7f647925;
        struct.var_73dfc737 = qualifier_func;
        struct.pooled = level.var_826a0c5c;
        if (isdefined(struct.targetname)) {
            struct.var_90fb1e1d = getent(struct.targetname, "targetname");
        }
        level.var_c919fdca[level.var_c919fdca.size] = struct;
        if (isdefined(level.var_826a0c5c)) {
            level.var_f623598a[level.var_f623598a.size] = struct;
        }
        struct thread function_ff2d4d2b();
    }
}

// Namespace namespace_6d813654
// Params 3, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_66764564
// Checksum 0x774f82ef, Offset: 0x1318
// Size: 0x4e
function function_66764564(struct, var_7f647925, qualifier_func) {
    level.var_826a0c5c = 1;
    function_e6296c4e(struct, var_7f647925, qualifier_func);
    level.var_826a0c5c = undefined;
}

// Namespace namespace_6d813654
// Params 3, eflags: 0x0
// namespace_6d813654<file_0>::function_e1b92ee4
// Checksum 0xd7ed9cc1, Offset: 0x1370
// Size: 0x4e
function function_e1b92ee4(name, var_7f647925, qualifier_func) {
    level.var_826a0c5c = 1;
    function_cf413d9a(name, var_7f647925, qualifier_func);
    level.var_826a0c5c = undefined;
}

// Namespace namespace_6d813654
// Params 1, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_fcbe2f17
// Checksum 0x691dd008, Offset: 0x13c8
// Size: 0x194
function function_fcbe2f17(struct) {
    if (isinarray(level.var_c919fdca, struct)) {
        new_list = [];
        for (i = 0; i < level.var_c919fdca.size; i++) {
            if (level.var_c919fdca[i] != struct) {
                new_list[new_list.size] = level.var_c919fdca[i];
                continue;
            }
            level.var_c919fdca[i] notify(#"hash_450c3de8");
            if (isdefined(level.var_c919fdca[i]._trigger)) {
                level.var_c919fdca[i]._trigger delete();
            }
            if (isdefined(level.var_c919fdca[i].pooled) && level.var_c919fdca[i].pooled) {
                arrayremovevalue(level.var_ea3a2497, level.var_c919fdca[i]);
                arrayremovevalue(level.var_f623598a, level.var_c919fdca[i]);
            }
        }
        level.var_c919fdca = new_list;
    }
}

// Namespace namespace_6d813654
// Params 1, eflags: 0x0
// namespace_6d813654<file_0>::function_ba04ea11
// Checksum 0xf0337c44, Offset: 0x1568
// Size: 0x16c
function function_ba04ea11(noteworthy) {
    new_list = [];
    for (i = 0; i < level.var_c919fdca.size; i++) {
        if (!isdefined(level.var_c919fdca[i].script_noteworthy) || level.var_c919fdca[i].script_noteworthy != noteworthy) {
            new_list[new_list.size] = level.var_c919fdca[i];
        } else {
            level.var_c919fdca[i] notify(#"hash_450c3de8");
            if (isdefined(level.var_c919fdca[i]._trigger)) {
                level.var_c919fdca[i]._trigger delete();
            }
        }
        if (isdefined(level.var_c919fdca[i].pooled) && level.var_c919fdca[i].pooled) {
            arrayremovevalue(level.var_ea3a2497, level.var_c919fdca[i]);
        }
    }
    level.var_c919fdca = new_list;
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_a7c3e09a
// Checksum 0x4fec3f9e, Offset: 0x16e0
// Size: 0x19c
function function_a7c3e09a() {
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            player = players[i];
            for (j = 0; j < level.var_c919fdca.size; j++) {
                hackable = level.var_c919fdca[j];
                if (isdefined(hackable._trigger)) {
                    qualifier_passed = 1;
                    if (isdefined(hackable.var_73dfc737)) {
                        qualifier_passed = hackable [[ hackable.var_73dfc737 ]](player);
                    }
                    if (player zm_equipment::hacker_active() && qualifier_passed && !hackable._trigger.beinghacked) {
                        hackable._trigger setinvisibletoplayer(player, 0);
                        continue;
                    }
                    hackable._trigger setinvisibletoplayer(player, 1);
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_6d813654
// Params 1, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_a449518a
// Checksum 0xbaf1c376, Offset: 0x1888
// Size: 0x176
function is_facing(facee) {
    orientation = self getplayerangles();
    forwardvec = anglestoforward(orientation);
    forwardvec2d = (forwardvec[0], forwardvec[1], 0);
    unitforwardvec2d = vectornormalize(forwardvec2d);
    tofaceevec = facee.origin - self.origin;
    tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
    unittofaceevec2d = vectornormalize(tofaceevec2d);
    dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
    var_e984946e = 0.8;
    if (isdefined(facee.var_e984946e)) {
        var_e984946e = facee.var_e984946e;
    }
    return dotproduct > var_e984946e;
}

// Namespace namespace_6d813654
// Params 1, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_a5a73067
// Checksum 0x1fea1f67, Offset: 0x1a08
// Size: 0x2e8
function function_a5a73067(hackable) {
    if (!isalive(self)) {
        return false;
    }
    if (self laststand::player_is_in_laststand()) {
        return false;
    }
    if (!self zm_equipment::hacker_active()) {
        return false;
    }
    if (!isdefined(hackable._trigger)) {
        return false;
    }
    if (isdefined(hackable.player)) {
        if (hackable.player != self) {
            return false;
        }
    }
    if (self throwbuttonpressed()) {
        return false;
    }
    if (self fragbuttonpressed()) {
        return false;
    }
    if (isdefined(hackable.var_73dfc737)) {
        if (!hackable [[ hackable.var_73dfc737 ]](self)) {
            return false;
        }
    }
    if (!isinarray(level.var_c919fdca, hackable)) {
        return false;
    }
    var_172f299d = 1024;
    if (isdefined(hackable.radius)) {
        var_172f299d = hackable.radius * hackable.radius;
    }
    origin = hackable.origin;
    if (isdefined(hackable.entity)) {
        origin = hackable.entity.origin;
    }
    if (distance2dsquared(self.origin, origin) > var_172f299d) {
        return false;
    }
    if (!isdefined(hackable.var_ae10f09) && !self istouching(hackable._trigger)) {
        return false;
    }
    if (!self is_facing(hackable)) {
        return false;
    }
    if (!isdefined(hackable.var_9aa3be3b) && !sighttracepassed(self.origin + (0, 0, 50), origin, 0, undefined)) {
        return false;
    }
    if (!isdefined(hackable.var_39787651) && !bullettracepassed(self.origin + (0, 0, 50), origin, 0, undefined)) {
        return false;
    }
    return true;
}

// Namespace namespace_6d813654
// Params 1, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_fccf6969
// Checksum 0x6fc165d5, Offset: 0x1cf8
// Size: 0x3a
function function_fccf6969(hackable) {
    return function_a5a73067(hackable) && self usebuttonpressed();
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_6dc470f1
// Checksum 0xd9cad803, Offset: 0x1d40
// Size: 0xac
function function_6dc470f1() {
    if (isdefined(self._trigger)) {
        if (isdefined(self.var_2cb6d1fc)) {
            self._trigger sethintstring(self.var_2cb6d1fc);
            return;
        }
        if (!isdefined(self.script_int) || self.script_int <= 0) {
            self._trigger sethintstring(%ZOMBIE_HACK_NO_COST);
            return;
        }
        self._trigger sethintstring(%ZOMBIE_HACK, self.script_int);
    }
}

// Namespace namespace_6d813654
// Params 1, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_99286508
// Checksum 0xafab32ac, Offset: 0x1df8
// Size: 0x74
function function_99286508(hackable) {
    self endon(#"hash_f1622f45");
    hackable waittill(#"hash_450c3de8");
    if (isdefined(self.var_4877737d)) {
        self.var_4877737d hud::destroyelem();
    }
    if (isdefined(self.var_7b9c0c69)) {
        self.var_7b9c0c69 destroy();
    }
}

// Namespace namespace_6d813654
// Params 1, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_ff133197
// Checksum 0x1879c239, Offset: 0x1e78
// Size: 0x41a
function function_ff133197(hackable) {
    timer = 0;
    hacked = 0;
    hackable._trigger.beinghacked = 1;
    if (!isdefined(self.var_4877737d)) {
        self.var_4877737d = self hud::createprimaryprogressbar();
    }
    if (!isdefined(self.var_7b9c0c69)) {
        self.var_7b9c0c69 = newclienthudelem(self);
    }
    hack_duration = hackable.script_float;
    if (self hasperk("specialty_fastreload")) {
        hack_duration *= 0.66;
    }
    hack_duration = max(1.5, hack_duration);
    self thread function_99286508(hackable);
    self.var_4877737d hud::updatebar(0.01, 1 / hack_duration);
    self.var_7b9c0c69.alignx = "center";
    self.var_7b9c0c69.aligny = "middle";
    self.var_7b9c0c69.horzalign = "center";
    self.var_7b9c0c69.vertalign = "bottom";
    self.var_7b9c0c69.y = -140;
    if (issplitscreen()) {
        self.var_7b9c0c69.y = -134;
    }
    self.var_7b9c0c69.foreground = 1;
    self.var_7b9c0c69.font = "default";
    self.var_7b9c0c69.fontscale = 1.8;
    self.var_7b9c0c69.alpha = 1;
    self.var_7b9c0c69.color = (1, 1, 1);
    self.var_7b9c0c69 settext(%ZOMBIE_HACKING);
    self playloopsound("zmb_progress_bar", 0.5);
    while (self function_fccf6969(hackable)) {
        wait(0.05);
        timer += 0.05;
        if (self laststand::player_is_in_laststand()) {
            break;
        }
        if (timer >= hack_duration) {
            hacked = 1;
            break;
        }
    }
    self stoploopsound(0.5);
    if (hacked) {
        self playsound("vox_mcomp_hack_success");
    } else {
        self playsound("vox_mcomp_hack_fail");
    }
    if (isdefined(self.var_4877737d)) {
        self.var_4877737d hud::destroyelem();
    }
    if (isdefined(self.var_7b9c0c69)) {
        self.var_7b9c0c69 destroy();
    }
    hackable function_6dc470f1();
    if (isdefined(hackable._trigger)) {
        hackable._trigger.beinghacked = 0;
    }
    self notify(#"hash_f1622f45");
    return hacked;
}

// Namespace namespace_6d813654
// Params 1, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_9fa8ae4a
// Checksum 0x83e1d548, Offset: 0x22a0
// Size: 0x4c
function function_9fa8ae4a(player) {
    player endon(#"disconnected");
    self endon(#"hash_d0852c39");
    self waittill(#"hash_450c3de8");
    player setlowready(0);
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_ff2d4d2b
// Checksum 0x2428e82a, Offset: 0x22f8
// Size: 0x48a
function function_ff2d4d2b() {
    self endon(#"hash_450c3de8");
    height = 72;
    radius = 64;
    if (isdefined(self.radius)) {
        radius = self.radius;
    }
    if (isdefined(self.height)) {
        height = self.height;
    }
    if (!isdefined(self.pooled)) {
        trigger = spawn("trigger_radius_use", self.origin, 0, radius, height);
        trigger usetriggerrequirelookat();
        trigger setcursorhint("HINT_NOICON");
        trigger.radius = radius;
        trigger.height = height;
        trigger.beinghacked = 0;
        self._trigger = trigger;
    }
    cost = 0;
    if (isdefined(self.script_int)) {
        cost = self.script_int;
    }
    duration = 1;
    if (isdefined(self.script_float)) {
        duration = self.script_float;
    }
    while (true) {
        wait(0.1);
        if (!isdefined(self._trigger)) {
            continue;
        }
        players = getplayers();
        if (isdefined(self._trigger)) {
            if (isdefined(self.entity)) {
                self.origin = self.entity.origin;
                self._trigger.origin = self.entity.origin;
                if (isdefined(self.trigger_offset)) {
                    self._trigger.origin += self.trigger_offset;
                }
            }
        }
        for (i = 0; i < players.size; i++) {
            if (players[i] function_a5a73067(self)) {
                self function_6dc470f1();
                break;
            }
        }
        for (i = 0; i < players.size; i++) {
            hacker = players[i];
            if (!hacker function_fccf6969(self)) {
                continue;
            }
            if (hacker.score >= cost || cost <= 0) {
                hacker setlowready(1);
                self thread function_9fa8ae4a(hacker);
                hack_success = hacker function_ff133197(self);
                self notify(#"hash_d0852c39");
                if (isdefined(hacker)) {
                    hacker setlowready(0);
                }
                if (isdefined(hacker) && hack_success) {
                    if (cost) {
                        if (cost > 0) {
                            hacker zm_score::minus_to_player_score(cost);
                        } else {
                            hacker zm_score::add_to_player_score(cost * -1, 1, "equip_hacker");
                        }
                    }
                    hacker notify(#"hash_33f8465d");
                    if (isdefined(self.var_67f708a8)) {
                        self thread [[ self.var_67f708a8 ]](hacker);
                    }
                }
                continue;
            }
            hacker zm_utility::play_sound_on_ent("no_purchase");
            hacker zm_audio::create_and_play_dialog("general", "no_money", 1);
        }
    }
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_bba1feec
// Checksum 0x1db0a2b4, Offset: 0x2790
// Size: 0xfc
function function_bba1feec() {
    struct = spawnstruct();
    struct.origin = self.origin;
    struct.radius = 48;
    struct.height = 64;
    struct.script_float = 10;
    struct.script_int = 500;
    struct.entity = self;
    struct.trigger_offset = (0, 0, 48);
    function_66764564(struct, &function_2d6b9312, &function_945b65f3);
    struct thread function_d646d3ee(self);
}

// Namespace namespace_6d813654
// Params 1, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_d646d3ee
// Checksum 0x559c4d94, Offset: 0x2898
// Size: 0x2c
function function_d646d3ee(player) {
    player waittill(#"disconnect");
    function_fcbe2f17(self);
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_b743c597
// Checksum 0xf7403287, Offset: 0x28d0
// Size: 0x80
function function_b743c597() {
    self notify(#"hash_36caa6f");
    self endon(#"hash_36caa6f");
    self endon(#"disconnect");
    while (true) {
        equipment = self waittill(#"player_given");
        if (equipment == level.var_bbd4901d) {
            self clientfield::set_player_uimodel("hudItems.showDpadDown_HackTool", 1);
        }
    }
}

// Namespace namespace_6d813654
// Params 0, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_778301bd
// Checksum 0x1dde1074, Offset: 0x2958
// Size: 0x60
function function_778301bd() {
    self notify(#"hash_b90a8375");
    self endon(#"hash_b90a8375");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"hash_e15d5390");
        self clientfield::set_player_uimodel("hudItems.showDpadDown_HackTool", 0);
    }
}

// Namespace namespace_6d813654
// Params 1, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_2d6b9312
// Checksum 0xacfb6cc, Offset: 0x29c0
// Size: 0x6c
function function_2d6b9312(hacker) {
    if (isdefined(self.entity)) {
        self.entity zm_score::player_add_points("hacker_transfer", 500);
    }
    if (isdefined(hacker)) {
        hacker thread zm_audio::create_and_play_dialog("general", "hack_plr");
    }
}

// Namespace namespace_6d813654
// Params 1, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_945b65f3
// Checksum 0xac40880d, Offset: 0x2a38
// Size: 0xa8
function function_945b65f3(player) {
    if (player == self.entity) {
        return false;
    }
    if (self.entity laststand::player_is_in_laststand()) {
        return false;
    }
    if (player laststand::player_is_in_laststand()) {
        return false;
    }
    if (isdefined(self.entity.sessionstate == "spectator") && self.entity.sessionstate == "spectator") {
        return false;
    }
    return true;
}

// Namespace namespace_6d813654
// Params 2, eflags: 0x1 linked
// namespace_6d813654<file_0>::function_4edfe9fb
// Checksum 0xd7af7019, Offset: 0x2ae8
// Size: 0x19c
function function_4edfe9fb(var_70d18318, var_b98175e6) {
    var_ce5361fd = 0;
    while (true) {
        if (isdefined(var_70d18318)) {
            self [[ var_70d18318 ]](var_b98175e6);
        }
        if (function_acac2fc2()) {
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                if (players[i] zm_equipment::hacker_active()) {
                    self setinvisibletoplayer(players[i], 1);
                    var_ce5361fd = 1;
                    continue;
                }
                self setinvisibletoplayer(players[i], 0);
            }
        } else if (var_ce5361fd) {
            var_ce5361fd = 0;
            players = getplayers();
            for (i = 0; i < players.size; i++) {
                self setinvisibletoplayer(players[i], 0);
            }
        }
        wait(0.1);
    }
}

/#

    // Namespace namespace_6d813654
    // Params 2, eflags: 0x0
    // namespace_6d813654<file_0>::function_73c65cef
    // Checksum 0x2b7d5403, Offset: 0x2c90
    // Size: 0x8c
    function function_73c65cef(msg, color) {
        if (!getdvarint("trigger_")) {
            return;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        print3d(self.origin + (0, 0, 60), msg, color, 1, 1, 40);
    }

#/
