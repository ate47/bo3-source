#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_zm_bgb_machine;
#using scripts/zm/_zm_bgb;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_72609f96;

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0xcd5e9a67, Offset: 0x540
// Size: 0x894
function function_6d502b1e() {
    callback::on_connect(&function_3c93cd15);
    var_1abbe98a = getentarray("zipline_buy_trigger", "targetname");
    var_c66fc62 = undefined;
    var_3e679961 = undefined;
    level.direction = undefined;
    level.var_99ff87c = [];
    level.var_b9b7b494 = [];
    level.var_93eb9000 = 0;
    for (i = 0; i < var_1abbe98a.size; i++) {
        var_1abbe98a[i].zip = getent(var_1abbe98a[i].target, "targetname");
        var_1abbe98a[i].blocker = getent("zipline_blocker", "targetname");
        var_1abbe98a[i].var_1508405b = getent("zipline_ai_blocker", "targetname");
        var_1abbe98a[i].var_d63fb455 = getentarray("zip_temp_clip", "targetname");
        var_1abbe98a[i].handle = getent("zip_handle", "targetname");
        var_1abbe98a[i].lever = getent("zip_lever", "targetname");
        var_1abbe98a[i].volume = getent(var_1abbe98a[i].zip.target, "targetname");
        var_1abbe98a[i].var_692f76f7 = getent(var_1abbe98a[i].volume.target, "targetname");
        var_1abbe98a[i].var_ddeffde7 = getent(var_1abbe98a[i].var_692f76f7.target, "targetname");
        if (isdefined(var_1abbe98a[i].script_noteworthy) && var_1abbe98a[i].script_noteworthy == "nonstatic") {
            var_c66fc62 = var_1abbe98a[i];
        } else if (isdefined(var_1abbe98a[i].script_noteworthy) && var_1abbe98a[i].script_noteworthy == "static") {
            var_3e679961 = var_1abbe98a[i];
        }
        level.var_99ff87c = getentarray("zipline_nodes", "script_noteworthy");
        level.var_b9b7b494 = [];
        var_1abbe98a[i] setcursorhint("HINT_NOICON");
    }
    var_c66fc62 enablelinkto();
    var_c66fc62 linkto(var_c66fc62.zip);
    var_3e679961 triggerenable(0);
    var_1abbe98a[0].volume enablelinkto();
    var_1abbe98a[0].volume linkto(var_1abbe98a[0].zip);
    var_1abbe98a[0].var_692f76f7 enablelinkto();
    var_1abbe98a[0].var_692f76f7 linkto(var_1abbe98a[0].zip);
    var_1abbe98a[0].var_ddeffde7 enablelinkto();
    var_1abbe98a[0].var_ddeffde7 linkto(var_1abbe98a[0].zip);
    for (i = 0; i < var_1abbe98a[0].var_d63fb455.size; i++) {
        var_1abbe98a[0].var_d63fb455[i] linkto(var_1abbe98a[0].zip);
    }
    var_af174c5b = getent("zip_lever_trigger", "targetname");
    var_af174c5b.lever = getent(var_af174c5b.target, "targetname");
    var_af174c5b sethintstring(%ZOMBIE_ZIPLINE_ACTIVATE);
    var_af174c5b setcursorhint("HINT_NOICON");
    who = var_af174c5b waittill(#"trigger");
    var_27f3715d = getent("zipline_deactivated_hint_trigger", "targetname");
    var_27f3715d delete();
    var_af174c5b thread function_db0b6487(-76);
    var_af174c5b waittill(#"hash_62858b4e");
    who thread zm_audio::create_and_play_dialog("level", "zipline");
    var_af174c5b delete();
    var_3e679961 thread function_7b2ebc83(undefined);
    var_3e679961 waittill(#"hash_fc2c232a");
    var_1abbe98a[0].blocker connectpaths();
    var_1abbe98a[0].blocker notsolid();
    zm_utility::play_sound_at_pos("door_rotate_open", var_1abbe98a[0].blocker.origin);
    var_1abbe98a[0].blocker rotateyaw(80, 1);
    var_1abbe98a[0].blocker playsound("zmb_wooden_door");
    var_1abbe98a[0].blocker waittill(#"rotatedone");
    var_1abbe98a[0].blocker thread function_9ae0a79();
    waittime = 40;
    /#
        if (getdvarint("static") > 0) {
            waittime = 5;
        }
    #/
    wait(waittime);
    var_3e679961 thread function_db0b6487(-180);
    var_3e679961 waittill(#"hash_62858b4e");
    array::thread_all(var_1abbe98a, &function_ae60d5e);
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0x6fdb58db, Offset: 0xde0
// Size: 0x8e
function function_ce43e0ca() {
    var_d0047899 = getentarray("zip_line_rope", "targetname");
    for (i = 0; i < var_d0047899.size; i++) {
        if (isdefined(var_d0047899[i].script_sound)) {
            var_d0047899[i] thread function_6762b54();
        }
    }
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0x451f06dc, Offset: 0xe78
// Size: 0x12e
function function_4cc9d40c() {
    level thread function_ce43e0ca();
    var_c41f3f75 = getentarray("zip_line_wheel", "targetname");
    for (i = 0; i < var_c41f3f75.size; i++) {
        if (isdefined(var_c41f3f75[i].script_label)) {
            var_c41f3f75[i] playsound(var_c41f3f75[i].script_label);
        }
        if (isdefined(var_c41f3f75[i].script_sound)) {
            var_c41f3f75[i] playloopsound(var_c41f3f75[i].script_sound, 1);
        }
        var_c41f3f75[i] thread function_d313f19b();
    }
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0x49f509f6, Offset: 0xfb0
// Size: 0x58
function function_6762b54() {
    level endon(#"hash_bcfb537a");
    while (true) {
        wait(randomfloatrange(0.5, 1.5));
        self playsound(self.script_sound);
    }
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0xb14dafc1, Offset: 0x1010
// Size: 0x54
function function_d313f19b() {
    level waittill(#"hash_bcfb537a");
    self stoploopsound(1);
    if (isdefined(self.script_label)) {
        self playsound("zmb_motor_stop_left");
    }
}

// Namespace namespace_72609f96
// Params 1, eflags: 0x1 linked
// Checksum 0xabbc0366, Offset: 0x1070
// Size: 0xd2
function function_db0b6487(dir) {
    self.lever rotatepitch(dir, 0.5);
    org = getent("zip_line_switch", "targetname");
    if (isdefined(org)) {
        if (dir == -76) {
            org playsound("zmb_switch_on");
        } else {
            org playsound("zmb_switch_off");
        }
    }
    self.lever waittill(#"rotatedone");
    self notify(#"hash_62858b4e");
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0x5427c54e, Offset: 0x1150
// Size: 0xba
function function_3c93cd15() {
    var_68782483 = getentarray("zipline_buy_trigger", "targetname");
    foreach (e_trigger in var_68782483) {
        e_trigger setinvisibletoplayer(self);
    }
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0x31e1ec6f, Offset: 0x1218
// Size: 0x188
function function_73a6adde() {
    level endon(#"end_game");
    foreach (player in level.players) {
        self setinvisibletoplayer(player);
    }
    while (true) {
        foreach (player in level.players) {
            if (player istouching(self) && !(isdefined(player.var_ff423fef) && player.var_ff423fef)) {
                player.var_ff423fef = 1;
                player thread function_d3655c8e(self);
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_72609f96
// Params 1, eflags: 0x1 linked
// Checksum 0xc02d9d6f, Offset: 0x13a8
// Size: 0x230
function function_d3655c8e(e_trigger) {
    level endon(#"end_game");
    self endon(#"disconnect");
    while (self istouching(e_trigger)) {
        wait(0.05);
        if (self laststand::player_is_in_laststand() || self zm_utility::in_revive_trigger()) {
            e_trigger setinvisibletoplayer(self);
            continue;
        }
        if (isdefined(self.is_drinking) && self.is_drinking > 0) {
            e_trigger setinvisibletoplayer(self);
            continue;
        }
        if (self bgb::is_enabled("zm_bgb_disorderly_combat")) {
            e_trigger setinvisibletoplayer(self);
            continue;
        }
        initial_current_weapon = self getcurrentweapon();
        current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
        if (current_weapon.isheroweapon || current_weapon.isgadget) {
            e_trigger setinvisibletoplayer(self);
            continue;
        }
        if (zm_equipment::is_equipment(current_weapon)) {
            e_trigger setinvisibletoplayer(self);
            continue;
        }
        if (self.zombie_vars["zombie_powerup_minigun_on"] === 1) {
            e_trigger setinvisibletoplayer(self);
            continue;
        }
        e_trigger setvisibletoplayer(self);
    }
    e_trigger setinvisibletoplayer(self);
    self.var_ff423fef = 0;
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0xc9054239, Offset: 0x15e0
// Size: 0x654
function function_ae60d5e() {
    self sethintstring(%ZOMBIE_ZIPLINE_USE);
    self setcursorhint("HINT_NOICON");
    self.zombie_cost = 1500;
    var_1abbe98a = getentarray("zipline_buy_trigger", "targetname");
    self thread function_73a6adde();
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic") {
        self.var_a4b9a274 = 1;
        self unlink();
        self thread function_23cf0719();
    }
    while (true) {
        who = self waittill(#"trigger");
        if (who zm_utility::in_revive_trigger()) {
            continue;
        }
        if (zombie_utility::is_player_valid(who)) {
            if (who zm_score::can_player_purchase(self.zombie_cost)) {
                if (!level.var_93eb9000) {
                    if (isdefined(self.script_noteworthy) && (isdefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic" && who istouching(self.volume) || self.script_noteworthy == "static")) {
                        level.var_93eb9000 = 1;
                        for (i = 0; i < var_1abbe98a.size; i++) {
                            if (isdefined(var_1abbe98a[i].script_noteworthy) && var_1abbe98a[i].script_noteworthy == "nonstatic") {
                                var_1abbe98a[i] notify(#"hash_b1dd546c");
                                var_1abbe98a[i] linkto(var_1abbe98a[i].zip);
                                var_1abbe98a[i] sethintstring("");
                                continue;
                            }
                            if (isdefined(var_1abbe98a[i].script_noteworthy) && var_1abbe98a[i].script_noteworthy == "static" && !isdefined(level.direction)) {
                                var_1abbe98a[i] triggerenable(0);
                            }
                        }
                        zm_utility::play_sound_at_pos("purchase", who.origin);
                        if (isdefined(self.script_noteworthy) && self.script_noteworthy == "static") {
                            self thread function_db0b6487(-76);
                            self waittill(#"hash_62858b4e");
                        }
                        who zm_score::minus_to_player_score(self.zombie_cost);
                        if (isdefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic") {
                            self thread function_7b2ebc83(who);
                        } else if (isdefined(self.script_noteworthy) && self.script_noteworthy == "static") {
                            self thread function_7b2ebc83(undefined);
                        }
                        self waittill(#"hash_fc2c232a");
                        if (isdefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic") {
                            self unlink();
                            self function_8f0b91a5();
                        }
                        waittime = 40;
                        /#
                            if (getdvarint("static") > 0) {
                                waittime = 5;
                            }
                        #/
                        wait(waittime);
                        if (isdefined(self.script_noteworthy) && self.script_noteworthy == "static") {
                            self thread function_db0b6487(-180);
                            self waittill(#"hash_62858b4e");
                        }
                        for (i = 0; i < var_1abbe98a.size; i++) {
                            if (isdefined(var_1abbe98a[i].script_noteworthy) && var_1abbe98a[i].script_noteworthy == "nonstatic") {
                                var_1abbe98a[i] sethintstring(%ZOMBIE_ZIPLINE_USE);
                                var_1abbe98a[i] setcursorhint("HINT_NOICON");
                                var_1abbe98a[i] triggerenable(1);
                                var_1abbe98a[i] thread function_23cf0719();
                            }
                            if (isdefined(var_1abbe98a[i].script_noteworthy) && var_1abbe98a[i].script_noteworthy == "static" && !isdefined(level.direction)) {
                                var_1abbe98a[i] triggerenable(1);
                            }
                        }
                        level.var_93eb9000 = 0;
                    }
                }
            }
        }
    }
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0xa9e0de78, Offset: 0x1c40
// Size: 0x60
function function_b7bfa783() {
    if (isdefined(self.var_a4b9a274) && !self.var_a4b9a274) {
        self.origin = (self.origin[0], self.origin[1], self.origin[2] + 10000);
        self.var_a4b9a274 = 1;
    }
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0x18c204c5, Offset: 0x1ca8
// Size: 0x60
function function_8f0b91a5() {
    if (isdefined(self.var_a4b9a274) && self.var_a4b9a274) {
        self.origin = (self.origin[0], self.origin[1], self.origin[2] - 10000);
        self.var_a4b9a274 = 0;
    }
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0xffbc1c65, Offset: 0x1d10
// Size: 0x2c6
function function_23cf0719() {
    self endon(#"hash_b1dd546c");
    while (true) {
        players = getplayers();
        var_c208aaa0 = [];
        aliveplayers = [];
        var_fafa849b = 0;
        for (i = 0; i < players.size; i++) {
            if (players[i] laststand::player_is_in_laststand() && players[i] istouching(self.volume)) {
                if (!isdefined(var_c208aaa0)) {
                    var_c208aaa0 = [];
                } else if (!isarray(var_c208aaa0)) {
                    var_c208aaa0 = array(var_c208aaa0);
                }
                var_c208aaa0[var_c208aaa0.size] = players[i];
                continue;
            }
            if (isdefined(players[i]) && isalive(players[i])) {
                if (!isdefined(aliveplayers)) {
                    aliveplayers = [];
                } else if (!isarray(aliveplayers)) {
                    aliveplayers = array(aliveplayers);
                }
                aliveplayers[aliveplayers.size] = players[i];
            }
        }
        if (aliveplayers.size > 0 && var_c208aaa0.size > 0) {
            for (i = 0; i < aliveplayers.size; i++) {
                for (p = 0; p < var_c208aaa0.size; p++) {
                    if (aliveplayers[i] istouching(var_c208aaa0[p].revivetrigger)) {
                        var_fafa849b = 1;
                        break;
                    }
                }
                if (var_fafa849b) {
                    break;
                }
            }
        }
        if (var_fafa849b) {
            self function_8f0b91a5();
        } else {
            self function_b7bfa783();
        }
        wait(1);
    }
}

// Namespace namespace_72609f96
// Params 1, eflags: 0x1 linked
// Checksum 0xed8343c7, Offset: 0x1fe0
// Size: 0x902
function function_7b2ebc83(rider) {
    zombs = getaispeciesarray("axis");
    self.riders = [];
    self.var_5dbcd881 = 0;
    for (i = 0; i < zombs.size; i++) {
        if (isdefined(zombs[i]) && isalive(zombs[i]) && zombs[i] istouching(self.var_ddeffde7)) {
            if (zombs[i].isdog) {
                zombs[i].a.nodeath = 1;
            } else {
                zombs[i] startragdoll();
            }
            zombs[i] dodamage(zombs[i].health + 600, zombs[i].origin);
        }
    }
    level thread function_4cc9d40c();
    var_d496a1ae = array("link_player1", "link_player2", "link_player3", "link_player4");
    var_82291cb6 = getplayers();
    for (i = 0; i < var_82291cb6.size; i++) {
        if (isdefined(rider) && (var_82291cb6[i] istouching(self.volume) || zombie_utility::is_player_valid(var_82291cb6[i]) && var_82291cb6[i] == rider)) {
            prevdist = undefined;
            var_6051060a = undefined;
            playerorg = var_82291cb6[i] getorigin();
            foreach (var_bcd49665 in var_d496a1ae) {
                var_5c0457e0 = self.zip gettagorigin(var_bcd49665);
                dist = distance2d(playerorg, var_5c0457e0);
                if (!isdefined(prevdist)) {
                    prevdist = dist;
                    var_6051060a = var_bcd49665;
                    continue;
                }
                if (dist <= prevdist) {
                    prevdist = dist;
                    var_6051060a = var_bcd49665;
                }
            }
            if (!isdefined(self.riders)) {
                self.riders = [];
            } else if (!isarray(self.riders)) {
                self.riders = array(self.riders);
            }
            self.riders[self.riders.size] = var_82291cb6[i];
            var_82291cb6[i] freezecontrols(1);
            var_82291cb6[i] thread util::magic_bullet_shield();
            var_82291cb6[i].on_zipline = 1;
            var_82291cb6[i] setstance("stand");
            var_82291cb6[i] allowcrouch(0);
            var_82291cb6[i] allowprone(0);
            var_82291cb6[i] clientfield::set("player_legs_hide", 1);
            var_82291cb6[i] playerlinkto(self.zip, var_6051060a, 0, -76, -76, -76, -76, 1);
            arrayremovevalue(var_d496a1ae, var_6051060a);
        }
    }
    wait(0.1);
    if (var_d496a1ae.size > 0) {
        center = self.zip gettagorigin("link_zipline_jnt");
        physicsexplosionsphere(center, -128, 64, 2);
    }
    self thread function_58047fdd();
    if (!isdefined(level.direction)) {
        self.var_1508405b solid();
        self.var_1508405b disconnectpaths(0, 0);
        for (i = 0; i < self.riders.size; i++) {
            self.riders[i] thread zm::function_9ca63ef4((11216, 2883, -648));
        }
        level scene::play("p7_fxanim_zm_sumpf_zipline_down_bundle");
        level notify(#"hash_23abc63f");
        level.direction = "back";
    } else {
        for (i = 0; i < self.riders.size; i++) {
            self.riders[i] thread zm::function_9ca63ef4((10750, 1516, -501));
        }
        level scene::play("p7_fxanim_zm_sumpf_zipline_up_bundle");
        self.var_1508405b notsolid();
        self.var_1508405b connectpaths();
        level.direction = undefined;
    }
    self.var_50592df0 = 0;
    wait(0.1);
    for (i = 0; i < self.riders.size; i++) {
        if (isdefined(self.riders[i])) {
            self.riders[i] unlink();
            self.riders[i] util::stop_magic_bullet_shield();
            self.riders[i] thread zm::function_9ca63ef4(self.origin);
            self.riders[i].on_zipline = 0;
            self.riders[i] allowcrouch(1);
            self.riders[i] allowprone(1);
            self.riders[i] freezecontrols(0);
            self.riders[i] clientfield::set("player_legs_hide", 0);
        }
    }
    self function_f0f3f1d3();
    self notify(#"hash_fc2c232a");
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0x60335074, Offset: 0x28f0
// Size: 0x30
function function_58047fdd() {
    wait(0.5);
    self.var_692f76f7 thread function_f872ea59(self);
    self.var_50592df0 = 1;
}

// Namespace namespace_72609f96
// Params 1, eflags: 0x1 linked
// Checksum 0x3504b92c, Offset: 0x2928
// Size: 0xb8
function function_f872ea59(parent) {
    while (true) {
        ent = self waittill(#"trigger");
        if (parent.var_50592df0 == 1 && isdefined(ent) && isalive(ent)) {
            if (isplayer(ent)) {
                ent thread function_396566a8(parent);
                continue;
            }
            ent thread function_1d0184cf();
        }
    }
}

// Namespace namespace_72609f96
// Params 1, eflags: 0x1 linked
// Checksum 0x462887dc, Offset: 0x29e8
// Size: 0x10a
function function_396566a8(parent) {
    self endon(#"death");
    self endon(#"disconnect");
    players = getplayers();
    for (i = 0; i < parent.riders.size; i++) {
        if (self == parent.riders[i]) {
            return;
        }
    }
    if (!isdefined(self.var_a4278c) && !self laststand::player_is_in_laststand() && parent.var_5dbcd881 == 1) {
        self.var_a4278c = 1;
        self shellshock("death", 3);
        wait(2);
        self.var_a4278c = undefined;
    }
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0xc3548fcb, Offset: 0x2b00
// Size: 0x74
function function_1d0184cf() {
    self endon(#"death");
    if (self.isdog) {
        self.a.nodeath = 1;
    } else {
        self startragdoll();
    }
    self dodamage(self.health + 600, self.origin);
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0xe206fa40, Offset: 0x2b80
// Size: 0xcc
function function_9ae0a79() {
    self endon(#"hash_cca58996");
    while (true) {
        players = getplayers();
        player_touching = 0;
        for (i = 0; i < players.size; i++) {
            if (players[i] istouching(self)) {
                player_touching = 1;
                break;
            }
        }
        if (!player_touching) {
            self solid();
            return;
        }
        wait(0.5);
    }
}

// Namespace namespace_72609f96
// Params 0, eflags: 0x1 linked
// Checksum 0xcecfadae, Offset: 0x2c58
// Size: 0x236
function function_f0f3f1d3() {
    /#
        assert(isdefined(self));
    #/
    /#
        assert(isdefined(self.var_d63fb455));
    #/
    if (isdefined(level.direction)) {
        return;
    }
    base = undefined;
    for (i = 0; i < self.var_d63fb455.size; i++) {
        clip = self.var_d63fb455[i];
        if (isdefined(clip.script_noteworthy) && clip.script_noteworthy == "zip_base") {
            base = clip;
            break;
        }
    }
    /#
        assert(isdefined(base));
    #/
    z = base.origin[2];
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!zombie_utility::is_player_valid(player)) {
            continue;
        }
        if (!player istouching(base)) {
            continue;
        }
        if (player.origin[2] < z) {
            offset = z + 6;
            origin = (player.origin[0], player.origin[1], offset);
            player setorigin(origin);
        }
    }
}

