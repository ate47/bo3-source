#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/weaponlist;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;

#namespace gameskill;

// Namespace gameskill
// Params 0, eflags: 0x2
// namespace_6c41e242<file_0>::function_c35e6aab
// Checksum 0x865ce485, Offset: 0x430
// Size: 0x10
function autoexec init() {
    level.gameskill = 0;
}

// Namespace gameskill
// Params 2, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_a1bbf812
// Checksum 0xd77f5ac2, Offset: 0x448
// Size: 0x214
function setskill(reset, var_4f8d5b23) {
    if (!isdefined(level.script)) {
        level.script = tolower(getdvarstring("mapname"));
    }
    if (!(isdefined(reset) && reset)) {
        if (isdefined(level.var_6108a7cb) && level.var_6108a7cb) {
            return;
        }
        level.var_6a21f752 = &function_79977f70;
        level.var_e88bb559 = &function_79977f70;
        level.var_6c56e098 = &function_79977f70;
        util::set_console_status();
        thread function_610dfe1();
        if (util::coopgame()) {
            thread function_4c34249a();
            thread function_4e14dca9();
            thread function_a3f0621e();
        }
        level.var_6108a7cb = 1;
    }
    var_6dba9ec = getdvarint("ui_singlemission");
    if (var_6dba9ec == 1) {
        var_fd945ffe = getdvarint("ui_singlemission_difficulty");
        if (var_fd945ffe >= 0) {
            var_4f8d5b23 = var_fd945ffe;
        }
    }
    level thread function_2fb240f(var_4f8d5b23);
    if (!isdefined(level.var_878f8b6)) {
        level.var_878f8b6 = 1;
    }
    anim.run_accuracy = 0.5;
    level.var_f5410582 = 1;
    anim.pain_test = &pain_protection;
    set_difficulty_from_locked_settings();
}

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_40e90163
// Checksum 0xa86c37d4, Offset: 0x668
// Size: 0x11c
function function_40e90163(var_f5d45e8b) {
    level.playerhealth_regularregendelay = function_c127b241();
    level.worthydamageratio = function_1aed2639();
    if (level.var_f5410582) {
        thread function_2a22a275(var_f5d45e8b);
    }
    level.longregentime = function_41990a66();
    anim.player_attacker_accuracy = function_72524c50() * level.var_878f8b6;
    anim.var_9d0779eb = function_36a65b50();
    anim.dog_health = function_f4229065();
    anim.var_70acedfa = function_8a1f9500();
    setsaveddvar("ai_accuracyDistScale", 1);
    thread function_93270a2(var_f5d45e8b);
}

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_2a22a275
// Checksum 0xc4707a33, Offset: 0x790
// Size: 0xa2
function function_2a22a275(var_f5d45e8b) {
    level flag::wait_till("all_players_connected");
    players = level.players;
    for (i = 0; i < players.size; i++) {
        players[i].threatbias = int(function_872f62f0());
    }
}

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_93270a2
// Checksum 0xd485dd39, Offset: 0x840
// Size: 0xc
function function_93270a2(var_f5d45e8b) {
    
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_cdd7baaf
// Checksum 0x6d7218f9, Offset: 0x858
// Size: 0x24
function set_difficulty_from_locked_settings() {
    function_40e90163(&function_829cbbf8);
}

// Namespace gameskill
// Params 2, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_829cbbf8
// Checksum 0xdec404ae, Offset: 0x888
// Size: 0x2a
function function_829cbbf8(msg, ignored) {
    return level.difficultysettings[msg][level.currentdifficulty];
}

// Namespace gameskill
// Params 0, eflags: 0x0
// namespace_6c41e242<file_0>::function_a3920725
// Checksum 0xb1f6ee86, Offset: 0x8c0
// Size: 0x6
function always_pain() {
    return false;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_7d3a2615
// Checksum 0xeeb78d9c, Offset: 0x8d0
// Size: 0x4a
function pain_protection() {
    if (!pain_protection_check()) {
        return false;
    }
    return randomint(100) > function_f8ae406c() * 100;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_d9b23600
// Checksum 0xf8999036, Offset: 0x928
// Size: 0xd2
function pain_protection_check() {
    if (!isalive(self.enemy)) {
        return false;
    }
    if (!isplayer(self.enemy)) {
        return false;
    }
    if (!isalive(level.painai) || level.painai.a.script != "pain") {
        level.painai = self;
    }
    if (self == level.painai) {
        return false;
    }
    if (self.damageweapon != level.weaponnone && self.damageweapon.isboltaction) {
        return false;
    }
    return true;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_610dfe1
// Checksum 0x353e2c8c, Offset: 0xa08
// Size: 0xe8
function function_610dfe1() {
    /#
        setdvar("No Die Time", "No Die Time");
        waittillframeend();
        while (true) {
            while (true) {
                if (getdvarstring("No Die Time") != "No Die Time") {
                    break;
                }
                wait(0.5);
            }
            thread function_6227a919();
            while (true) {
                if (getdvarstring("No Die Time") == "No Die Time") {
                    break;
                }
                wait(0.5);
            }
            level notify(#"hash_31415269");
            function_b75a45fc();
        }
    #/
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_6227a919
// Checksum 0x817797fd, Offset: 0xaf8
// Size: 0x6be
function function_6227a919() {
    level notify(#"hash_3871a4a1");
    level endon(#"hash_3871a4a1");
    y = 40;
    level.var_7e842153 = [];
    level.var_fbe7c2fe[0] = "Health";
    level.var_fbe7c2fe[1] = "No Hit Time";
    level.var_fbe7c2fe[2] = "No Die Time";
    if (!isdefined(level.var_76f0070e)) {
        level.var_76f0070e = 0;
    }
    if (!isdefined(level.var_6ab88489)) {
        level.var_6ab88489 = 0;
    }
    for (i = 0; i < level.var_fbe7c2fe.size; i++) {
        key = level.var_fbe7c2fe[i];
        var_31704579 = newhudelem();
        var_31704579.x = -106;
        var_31704579.y = y;
        var_31704579.alignx = "left";
        var_31704579.aligny = "top";
        var_31704579.horzalign = "fullscreen";
        var_31704579.vertalign = "fullscreen";
        var_31704579 settext(key);
        bgbar = newhudelem();
        bgbar.x = -106 + 79;
        bgbar.y = y + 1;
        bgbar.z = 1;
        bgbar.alignx = "left";
        bgbar.aligny = "top";
        bgbar.horzalign = "fullscreen";
        bgbar.vertalign = "fullscreen";
        bgbar.maxwidth = 3;
        bgbar setshader("white", bgbar.maxwidth, 10);
        bgbar.color = (0.5, 0.5, 0.5);
        bar = newhudelem();
        bar.x = -106 + 80;
        bar.y = y + 2;
        bar.alignx = "left";
        bar.aligny = "top";
        bar.horzalign = "fullscreen";
        bar.vertalign = "fullscreen";
        bar setshader("black", 1, 8);
        bar.sort = 1;
        var_31704579.bar = bar;
        var_31704579.bgbar = bgbar;
        var_31704579.key = key;
        y += 10;
        level.var_7e842153[key] = var_31704579;
    }
    level flag::wait_till("all_players_spawned");
    while (true) {
        wait(0.05);
        players = level.players;
        for (i = 0; i < level.var_fbe7c2fe.size && players.size > 0; i++) {
            key = level.var_fbe7c2fe[i];
            player = players[0];
            width = 0;
            if (i == 0) {
                width = player.health / player.maxhealth * 300;
                level.var_7e842153[key] settext(level.var_fbe7c2fe[0] + " " + player.health);
            } else if (i == 1) {
                width = (level.var_76f0070e - gettime()) / 1000 * 40;
            } else if (i == 2) {
                width = (level.var_6ab88489 - gettime()) / 1000 * 40;
            }
            width = int(max(width, 1));
            width = int(min(width, 300));
            bar = level.var_7e842153[key].bar;
            bar setshader("black", width, 8);
            bgbar = level.var_7e842153[key].bgbar;
            if (width + 2 > bgbar.maxwidth) {
                bgbar.maxwidth = width + 2;
                bgbar setshader("white", bgbar.maxwidth, 10);
                bgbar.color = (0.5, 0.5, 0.5);
            }
        }
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_b75a45fc
// Checksum 0xd59a8dbd, Offset: 0x11c0
// Size: 0xd6
function function_b75a45fc() {
    level notify(#"hash_3871a4a1");
    if (!isdefined(level.var_7e842153)) {
        return;
    }
    for (i = 0; i < level.var_fbe7c2fe.size; i++) {
        level.var_7e842153[level.var_fbe7c2fe[i]].bgbar destroy();
        level.var_7e842153[level.var_fbe7c2fe[i]].bar destroy();
        level.var_7e842153[level.var_fbe7c2fe[i]] destroy();
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_f7773608
// Checksum 0xb32eec7b, Offset: 0x12a0
// Size: 0x54
function function_f7773608() {
    self endon(#"hash_e178ef00");
    self endon(#"death");
    if (isdefined(level.script) && level.script != "core_frontend") {
        self function_80e52fad();
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_54f3f08b
// Checksum 0x77ba2a24, Offset: 0x1300
// Size: 0x2c
function function_54f3f08b() {
    self endon(#"hash_e178ef00");
    self endon(#"death");
    self function_e2c49328();
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_fabc32f
// Checksum 0xac383c7a, Offset: 0x1338
// Size: 0x348
function function_fabc32f() {
    self endon(#"death");
    self endon(#"hash_84984c12");
    self.var_1428596a = 0;
    for (;;) {
        amount, attacker, dir, point, mod = self waittill(#"damage");
        if (isdefined(attacker) && isplayer(attacker) && attacker.team == self.team) {
            continue;
        }
        self.var_1428596a = 1;
        self.damagepoint = point;
        self.damageattacker = attacker;
        if (isdefined(mod) && mod == "MOD_BURNED") {
            self setburn(0.5);
            self playsound("chr_burn");
        }
        var_7a2a169 = amount / self.maxhealth >= level.worthydamageratio;
        var_4c5c8654 = 0;
        if (self.health <= 1 && self function_10a2e0f5()) {
            var_7a2a169 = 1;
            var_23fe4143 = function_9d895340();
            var_a66b3dd5 = function_d6a24e36();
            var_4c5c8654 = var_23fe4143 * var_a66b3dd5;
            self.var_73881ee1 = 0;
            self thread function_58f840ea();
            level.var_6ab88489 = gettime() + var_4c5c8654;
        }
        var_3d0925a9 = self.health / self.maxhealth;
        level notify(#"hash_4bd1d9d5");
        var_4d2b26fb = 0;
        hurttime = gettime();
        if (!isdefined(level.var_eafffb33)) {
            self startfadingblur(3, 0.8);
        }
        if (!var_7a2a169) {
            continue;
        }
        if (self flag::get("player_is_invulnerable")) {
            continue;
        }
        self flag::set("player_is_invulnerable");
        level notify(#"hash_b995d6a3");
        if (var_4c5c8654 < function_6c4efa62()) {
            var_2ce8450a = function_6c4efa62();
        } else {
            var_2ce8450a = var_4c5c8654;
        }
        self thread function_bd76f2fc(var_2ce8450a);
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_d1591847
// Checksum 0x4aaa7543, Offset: 0x1688
// Size: 0x442
function playerhealthregen() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_905a46e");
    if (!isdefined(self.flag)) {
        self.flag = [];
        self.flags_lock = [];
    }
    if (!isdefined(self.flag["player_has_red_flashing_overlay"])) {
        self flag::init("player_has_red_flashing_overlay");
        self flag::init("player_is_invulnerable");
    }
    self flag::clear("player_has_red_flashing_overlay");
    self flag::clear("player_is_invulnerable");
    self thread function_a52cfd21();
    self function_499dc9dc();
    self thread healthoverlay();
    var_3d0925a9 = 1;
    var_4d2b26fb = 0;
    veryhurt = 0;
    var_b72c1399 = 0;
    var_2ce8450a = 0;
    hurttime = 0;
    newhealth = 0;
    self.attackeraccuracy = 1;
    self.var_b13e596e = 1;
    self.ignorebulletdamage = 0;
    self thread function_fabc32f();
    if (!isdefined(self.veryhurt)) {
        self.veryhurt = 0;
    }
    self.var_65e2ccf7 = 0;
    for (;;) {
        wait(0.05);
        waittillframeend();
        if (self.health == self.maxhealth) {
            if (self flag::get("player_has_red_flashing_overlay")) {
                flag::clear("player_has_red_flashing_overlay");
            }
            var_b72c1399 = 0;
            veryhurt = 0;
            continue;
        }
        if (self.health <= 0) {
            return;
        }
        wasveryhurt = veryhurt;
        var_55ed49d3 = self.health / self.maxhealth;
        if (var_55ed49d3 <= function_a7c2f2c3()) {
            veryhurt = 1;
            self thread function_cd0999e2();
            if (!wasveryhurt) {
                hurttime = gettime();
                self flag::set("player_has_red_flashing_overlay");
                var_b72c1399 = 1;
            }
        }
        if (self.var_1428596a) {
            hurttime = gettime();
            self.var_1428596a = 0;
        }
        if (var_55ed49d3 >= var_3d0925a9) {
            if (gettime() - hurttime < level.playerhealth_regularregendelay) {
                continue;
            }
            if (veryhurt) {
                self.veryhurt = 1;
                newhealth = var_55ed49d3;
                if (gettime() > hurttime + level.longregentime) {
                    newhealth += 0.1;
                }
                if (newhealth >= 1) {
                    reducetakecoverwarnings();
                }
            } else {
                newhealth = 1;
                self.veryhurt = 0;
            }
            if (newhealth > 1) {
                newhealth = 1;
            }
            if (newhealth <= 0) {
                return;
            }
            self setnormalhealth(newhealth);
            var_3d0925a9 = self.health / self.maxhealth;
        }
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_5554c7f0
// Checksum 0xa2e7396b, Offset: 0x1ad8
// Size: 0xac
function reducetakecoverwarnings() {
    players = level.players;
    if (isdefined(players[0]) && isalive(players[0])) {
        takecoverwarnings = getlocalprofileint("takeCoverWarnings");
        if (takecoverwarnings > 0) {
            takecoverwarnings--;
            setlocalprofilevar("takeCoverWarnings", takecoverwarnings);
            /#
                function_4b54a797();
            #/
        }
    }
}

/#

    // Namespace gameskill
    // Params 0, eflags: 0x1 linked
    // namespace_6c41e242<file_0>::function_4b54a797
    // Checksum 0x34adc747, Offset: 0x1b90
    // Size: 0xac
    function function_4b54a797() {
        if (getdvarstring("No Die Time") == "No Die Time") {
            setdvar("No Die Time", "No Die Time");
        }
        if (getdvarstring("No Die Time") == "No Die Time") {
            iprintln("No Die Time", getlocalprofileint("No Die Time") - 3);
        }
    }

#/

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_bd76f2fc
// Checksum 0xbefcfcfe, Offset: 0x1c48
// Size: 0xb4
function function_bd76f2fc(timer) {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_b13e596e = self.attackeraccuracy;
    if (timer > 0) {
        self.attackeraccuracy = 0;
        self.ignorebulletdamage = 1;
        level.var_76f0070e = gettime() + timer * 1000;
        wait(timer);
    }
    self.attackeraccuracy = self.var_b13e596e;
    self.ignorebulletdamage = 0;
    self flag::clear("player_is_invulnerable");
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_356d8ec0
// Checksum 0x70f1aa8f, Offset: 0x1d08
// Size: 0xe4
function grenadeawareness() {
    if (self.team == "allies") {
        self.grenadeawareness = 0.9;
        return;
    }
    if (self.team == "axis") {
        if (isdefined(level.gameskill) && level.gameskill >= 2) {
            if (randomint(100) < 33) {
                self.grenadeawareness = 0.2;
            } else {
                self.grenadeawareness = 0.5;
            }
            return;
        }
        if (randomint(100) < 33) {
            self.grenadeawareness = 0;
            return;
        }
        self.grenadeawareness = 0.2;
    }
}

// Namespace gameskill
// Params 1, eflags: 0x0
// namespace_6c41e242<file_0>::function_7d69a720
// Checksum 0x88c92fab, Offset: 0x1df8
// Size: 0x100
function function_7d69a720(healthcap) {
    self endon(#"disconnect");
    self endon(#"killed_player");
    wait(2);
    player = self;
    ent = undefined;
    for (;;) {
        wait(0.2);
        if (player.health >= healthcap) {
            if (isdefined(ent)) {
                ent stoploopsound(1.5);
                level thread delayed_delete(ent, 1.5);
            }
            continue;
        }
        ent = spawn("script_origin", self.origin);
        ent playloopsound("", 0.5);
    }
}

// Namespace gameskill
// Params 2, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_1a32c391
// Checksum 0x292fb450, Offset: 0x1f00
// Size: 0x3c
function delayed_delete(ent, time) {
    wait(time);
    ent delete();
    ent = undefined;
}

// Namespace gameskill
// Params 2, eflags: 0x0
// namespace_6c41e242<file_0>::function_5cad004c
// Checksum 0xf95c12c9, Offset: 0x1f48
// Size: 0xbc
function function_5cad004c(overlay, var_4fa2ad65) {
    self notify(#"hash_48d7d8e0");
    self endon(#"hash_48d7d8e0");
    while (!(isdefined(level.var_a250f238) && level.var_a250f238) && var_4fa2ad65 > 0) {
        wait(0.05);
        var_4fa2ad65 -= 0.05;
    }
    if (isdefined(level.var_a250f238) && level.var_a250f238) {
        overlay.alpha = 0;
        overlay fadeovertime(0.05);
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_8ddec31d
// Checksum 0x99ec1590, Offset: 0x2010
// Size: 0x4
function function_8ddec31d() {
    
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_18001e6d
// Checksum 0x806cff98, Offset: 0x2020
// Size: 0x2c
function healthoverlay() {
    self endon(#"disconnect");
    self endon(#"hash_a5d08426");
    function_8ddec31d();
}

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_105a9902
// Checksum 0xcc3deeb0, Offset: 0x2058
// Size: 0x19c
function function_105a9902(aligny) {
    if (level.console) {
        self.fontscale = 2;
    } else {
        self.fontscale = 1.6;
    }
    self.x = 0;
    self.y = -36;
    self.alignx = "center";
    self.aligny = "bottom";
    self.horzalign = "center";
    self.vertalign = "middle";
    if (!isdefined(self.background)) {
        return;
    }
    self.background.x = 0;
    self.background.y = -40;
    self.background.alignx = "center";
    self.background.aligny = "middle";
    self.background.horzalign = "center";
    self.background.vertalign = "middle";
    if (level.console) {
        self.background setshader("popmenu_bg", 650, 52);
    } else {
        self.background setshader("popmenu_bg", 650, 42);
    }
    self.background.alpha = 0.5;
}

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_810b6482
// Checksum 0xd24ed4ab, Offset: 0x2200
// Size: 0xd0
function function_810b6482(player) {
    level notify(#"hash_ba9b454a");
    hudelem = newhudelem();
    hudelem function_105a9902();
    hudelem thread function_f4820efa(player);
    hudelem settext(%GAME_GET_TO_COVER);
    hudelem.fontscale = 1.85;
    hudelem.alpha = 1;
    hudelem.color = (1, 0.6, 0);
    return hudelem;
}

// Namespace gameskill
// Params 0, eflags: 0x0
// namespace_6c41e242<file_0>::function_87118343
// Checksum 0x6b18a257, Offset: 0x22d8
// Size: 0x5c
function function_87118343() {
    if (isdefined(self.veryhurt)) {
        if (self.veryhurt == 0) {
            if (randomintrange(0, 1) == 1) {
                playsoundatposition("chr_breathing_hurt_start", self.origin);
            }
        }
    }
}

// Namespace gameskill
// Params 0, eflags: 0x0
// namespace_6c41e242<file_0>::function_1819459d
// Checksum 0xd77119b9, Offset: 0x2340
// Size: 0x1c
function function_1819459d() {
    level endon(#"hash_4bd1d9d5");
    self waittill(#"damage");
}

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_f4820efa
// Checksum 0xc266cb57, Offset: 0x2368
// Size: 0x54
function function_f4820efa(player) {
    self endon(#"being_destroyed");
    self endon(#"death");
    level flag::wait_till("missionfailed");
    self thread function_24c9c57a(1);
}

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_24c9c57a
// Checksum 0xd9f3bab2, Offset: 0x23c8
// Size: 0x8c
function function_24c9c57a(fadeout) {
    self notify(#"being_destroyed");
    self.beingdestroyed = 1;
    if (fadeout) {
        self fadeovertime(0.5);
        self.alpha = 0;
        wait(0.5);
    }
    self util::death_notify_wrapper();
    self destroy();
}

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_f651876d
// Checksum 0x896451b7, Offset: 0x2460
// Size: 0x34
function function_f651876d(var_17dfcbe) {
    if (!isdefined(var_17dfcbe)) {
        return false;
    }
    if (isdefined(var_17dfcbe.beingdestroyed)) {
        return false;
    }
    return true;
}

// Namespace gameskill
// Params 2, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_fd208a76
// Checksum 0x5e9c4f6d, Offset: 0x24a0
// Size: 0x78
function function_fd208a76(scale, timer) {
    self endon(#"death");
    scale *= 2;
    dif = scale - self.fontscale;
    self changefontscaleovertime(timer);
    self.fontscale += dif;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_cd0999e2
// Checksum 0x66e0d768, Offset: 0x2520
// Size: 0x1dc
function function_cd0999e2() {
    level endon(#"missionfailed");
    if (self shouldshowcoverwarning()) {
        var_17dfcbe = function_810b6482(self);
        level.var_f0887a01 = var_17dfcbe;
        var_17dfcbe endon(#"death");
        var_af9bd93e = gettime() + level.longregentime;
        var_72edb94e = 0.7;
        while (gettime() < var_af9bd93e && isalive(self)) {
            for (i = 0; i < 7; i++) {
                var_72edb94e += 0.03;
                var_17dfcbe.color = (1, var_72edb94e, 0);
                wait(0.05);
            }
            for (i = 0; i < 7; i++) {
                var_72edb94e -= 0.03;
                var_17dfcbe.color = (1, var_72edb94e, 0);
                wait(0.05);
            }
        }
        if (function_f651876d(var_17dfcbe)) {
            var_17dfcbe fadeovertime(0.5);
            var_17dfcbe.alpha = 0;
        }
        wait(0.5);
        wait(5);
        var_17dfcbe destroy();
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_3ad879d4
// Checksum 0x7cd21157, Offset: 0x2708
// Size: 0xe
function shouldshowcoverwarning() {
    return false;
}

// Namespace gameskill
// Params 5, eflags: 0x0
// namespace_6c41e242<file_0>::function_bbe24e91
// Checksum 0x4904baa3, Offset: 0x27f0
// Size: 0x398
function function_bbe24e91(overlay, var_17dfcbe, severity, mult, var_7170800d) {
    fadeintime = 0.8 * 0.1;
    var_a93d5122 = 0.8 * (0.1 + severity * 0.2);
    var_ac705df5 = 0.8 * (0.1 + severity * 0.1);
    var_97b1675d = 0.8 * 0.3;
    remainingtime = 0.8 - fadeintime - var_a93d5122 - var_ac705df5 - var_97b1675d;
    assert(remainingtime >= -0.001);
    if (remainingtime < 0) {
        remainingtime = 0;
    }
    var_84c9a0be = 0.8 + severity * 0.1;
    var_833e5b9c = 0.5 + severity * 0.3;
    overlay fadeovertime(fadeintime);
    overlay.alpha = mult * 1;
    if (function_f651876d(var_17dfcbe)) {
        if (!var_7170800d) {
            var_17dfcbe fadeovertime(fadeintime);
            var_17dfcbe.alpha = mult * 1;
        }
    }
    if (isdefined(var_17dfcbe)) {
        var_17dfcbe thread function_fd208a76(1, fadeintime);
    }
    wait(fadeintime + var_a93d5122);
    overlay fadeovertime(var_ac705df5);
    overlay.alpha = mult * var_84c9a0be;
    if (function_f651876d(var_17dfcbe)) {
        if (!var_7170800d) {
            var_17dfcbe fadeovertime(var_ac705df5);
            var_17dfcbe.alpha = mult * var_84c9a0be;
        }
    }
    wait(var_ac705df5);
    overlay fadeovertime(var_97b1675d);
    overlay.alpha = mult * var_833e5b9c;
    if (function_f651876d(var_17dfcbe)) {
        if (!var_7170800d) {
            var_17dfcbe fadeovertime(var_97b1675d);
            var_17dfcbe.alpha = mult * var_833e5b9c;
        }
    }
    if (isdefined(var_17dfcbe)) {
        var_17dfcbe thread function_fd208a76(0.9, var_97b1675d);
    }
    wait(var_97b1675d);
    wait(remainingtime);
}

// Namespace gameskill
// Params 1, eflags: 0x0
// namespace_6c41e242<file_0>::function_2d8009b8
// Checksum 0x95027db7, Offset: 0x2b90
// Size: 0x6c
function function_2d8009b8(overlay) {
    self endon(#"disconnect");
    self util::waittill_any("noHealthOverlay", "death");
    overlay fadeovertime(3.5);
    overlay.alpha = 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_499dc9dc
// Checksum 0x38489455, Offset: 0x2c08
// Size: 0xac
function function_499dc9dc() {
    var_fc70911a = level.script == "training" || level.script == "cargoship" || level.script == "coup";
    if (getlocalprofileint("takeCoverWarnings") == -1 || var_fc70911a) {
        setlocalprofilevar("takeCoverWarnings", 9);
    }
    /#
        function_4b54a797();
    #/
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_a52cfd21
// Checksum 0x3564f7d0, Offset: 0x2cc0
// Size: 0xec
function function_a52cfd21() {
    if (!isplayer(self)) {
        return;
    }
    level notify(#"hash_310aee47");
    level endon(#"hash_310aee47");
    self waittill(#"death");
    if (!self flag::get("player_has_red_flashing_overlay")) {
        return;
    }
    if (level.gameskill > 1) {
        return;
    }
    var_cf4def2a = getlocalprofileint("takeCoverWarnings");
    if (var_cf4def2a < 10) {
        setlocalprofilevar("takeCoverWarnings", var_cf4def2a + 1);
    }
    /#
        function_4b54a797();
    #/
}

// Namespace gameskill
// Params 5, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_79977f70
// Checksum 0x3aee0351, Offset: 0x2db8
// Size: 0x2c
function function_79977f70(type, loc, point, attacker, amount) {
    
}

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_2fb240f
// Checksum 0xbd9d0c7c, Offset: 0x2df0
// Size: 0x374
function function_2fb240f(var_4f8d5b23) {
    level notify(#"hash_16cdf7b1");
    level endon(#"hash_16cdf7b1");
    level.var_57830ddc = 9999;
    level.var_a76de5fa = 0;
    var_1fc6cd58 = -1;
    while (!isdefined(var_4f8d5b23)) {
        level.gameskill = getlocalprofileint("g_gameskill");
        if (level.gameskill != var_1fc6cd58) {
            if (!isdefined(level.gameskill)) {
                level.gameskill = 0;
            }
            setdvar("saved_gameskill", level.gameskill);
            switch (level.gameskill) {
            case 0:
                setdvar("currentDifficulty", "easy");
                level.currentdifficulty = "easy";
                break;
            case 1:
                setdvar("currentDifficulty", "normal");
                level.currentdifficulty = "normal";
                break;
            case 2:
                setdvar("currentDifficulty", "hardened");
                level.currentdifficulty = "hardened";
                break;
            case 3:
                setdvar("currentDifficulty", "veteran");
                level.currentdifficulty = "veteran";
                break;
            case 4:
                setdvar("currentDifficulty", "realistic");
                level.currentdifficulty = "realistic";
                break;
            }
            println("No Die Time" + level.gameskill);
            var_1fc6cd58 = level.gameskill;
            if (level.gameskill < level.var_57830ddc) {
                level.var_57830ddc = level.gameskill;
                matchrecordsetleveldifficultyforindex(2, level.gameskill);
            }
            if (level.gameskill > level.var_a76de5fa) {
                level.var_a76de5fa = level.gameskill;
                matchrecordsetleveldifficultyforindex(3, level.gameskill);
            }
            foreach (player in getplayers()) {
                player clientfield::set_player_uimodel("serverDifficulty", level.gameskill);
            }
        }
        wait(1);
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_4e14dca9
// Checksum 0x289d9eba, Offset: 0x3170
// Size: 0xa0
function function_4e14dca9() {
    level flagsys::wait_till("load_main_complete");
    level flag::wait_till("all_players_connected");
    while (level.players.size > 1) {
        players = getplayers("allies");
        level.var_82243644 = function_6979803c();
        wait(0.5);
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_a3f0621e
// Checksum 0xbf83d5ee, Offset: 0x3218
// Size: 0xa0
function function_a3f0621e() {
    level flagsys::wait_till("load_main_complete");
    level flag::wait_till("all_players_connected");
    while (level.players.size > 1) {
        players = getplayers("allies");
        level.var_b8384d83 = function_c29e1b7d();
        wait(0.5);
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_80e52fad
// Checksum 0x93a87c73, Offset: 0x32c0
// Size: 0x5c
function function_80e52fad() {
    self endon(#"death");
    initialvalue = self.baseaccuracy;
    self.baseaccuracy = initialvalue * function_6979803c();
    wait(randomfloatrange(3, 5));
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_e2c49328
// Checksum 0x6d942f6, Offset: 0x3328
// Size: 0x80
function function_e2c49328() {
    self endon(#"death");
    initialvalue = self.baseaccuracy;
    while (level.players.size > 1) {
        if (!isdefined(level.var_b8384d83)) {
            wait(0.5);
            continue;
        }
        self.baseaccuracy = initialvalue * level.var_b8384d83;
        wait(randomfloatrange(3, 5));
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_4c34249a
// Checksum 0x527855e2, Offset: 0x33b0
// Size: 0x8a
function function_4c34249a() {
    while (true) {
        wait(5);
        if (level.var_f5410582) {
            players = getplayers("allies");
            for (i = 0; i < players.size; i++) {
                function_f099ec5c(players[i]);
            }
        }
    }
}

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_f099ec5c
// Checksum 0x3a945aa6, Offset: 0x3448
// Size: 0x98
function function_f099ec5c(player) {
    level.var_f5410582 = 1;
    players = level.players;
    level.var_5bef6e1d = function_35c3fd5f();
    if (!isdefined(level.var_5bef6e1d)) {
        level.var_5bef6e1d = 1;
    }
    player.threatbias = int(function_872f62f0() * level.var_5bef6e1d);
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_74d15397
// Checksum 0x81fc3dd3, Offset: 0x34e8
// Size: 0x12a
function function_74d15397() {
    reload = 0;
    /#
        reload = 1;
    #/
    if (reload || !isdefined(level.var_1bace747)) {
        level.var_1bace747 = [];
        level.var_1bace747[0] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_easy");
        level.var_1bace747[1] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_medium");
        level.var_1bace747[2] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_hard");
        level.var_1bace747[3] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_veteran");
        level.var_1bace747[4] = struct::get_script_bundle("gamedifficulty", "gamedifficulty_realistic");
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_872f62f0
// Checksum 0xfef970b2, Offset: 0x3620
// Size: 0x54
function function_872f62f0() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].threatbias;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_684ec97e
// Checksum 0x54c0056e, Offset: 0x3680
// Size: 0x56
function function_684ec97e() {
    function_74d15397();
    var_2e40420 = level.var_1bace747[level.gameskill].difficulty_xp_multiplier;
    if (isdefined(var_2e40420)) {
        return var_2e40420;
    }
    return 1;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_a7c2f2c3
// Checksum 0x26289c48, Offset: 0x36e0
// Size: 0x54
function function_a7c2f2c3() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].healthoverlaycutoff;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_f8ae406c
// Checksum 0xd0d1979c, Offset: 0x3740
// Size: 0x90
function function_f8ae406c() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].var_c42b417b;
    modifier = function_242ea84e();
    if (isdefined(var_d35c182a)) {
        var_d35c182a = modifier * var_d35c182a;
        return var_d35c182a;
    }
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_9d895340
// Checksum 0xc89a47a6, Offset: 0x37d8
// Size: 0x54
function function_9d895340() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].player_deathinvulnerabletime;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_72524c50
// Checksum 0x899adc6c, Offset: 0x3838
// Size: 0x54
function function_72524c50() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].base_enemy_accuracy;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_f0299cbc
// Checksum 0x837cb2e2, Offset: 0x3898
// Size: 0x54
function function_f0299cbc() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].playerdifficultyhealth;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_6c4efa62
// Checksum 0x98bd5271, Offset: 0x38f8
// Size: 0x80
function function_6c4efa62() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].playerhitinvulntime;
    modifier = function_e314b70d();
    if (isdefined(var_d35c182a)) {
        var_d35c182a = modifier * var_d35c182a;
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_702b3695
// Checksum 0x2c1888c5, Offset: 0x3980
// Size: 0x54
function function_702b3695() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].misstimeconstant;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_7deab2f2
// Checksum 0x93f6832d, Offset: 0x39e0
// Size: 0x54
function function_7deab2f2() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].misstimeresetdelay;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_43c73456
// Checksum 0x90361532, Offset: 0x3a40
// Size: 0x54
function function_43c73456() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].misstimedistancefactor;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_f4229065
// Checksum 0x97747351, Offset: 0x3aa0
// Size: 0x54
function function_f4229065() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].dog_health;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_8a1f9500
// Checksum 0x2c5ac59, Offset: 0x3b00
// Size: 0x54
function function_8a1f9500() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].var_70acedfa;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_36a65b50
// Checksum 0x3c4108a1, Offset: 0x3b60
// Size: 0x54
function function_36a65b50() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].var_9d0779eb;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_41990a66
// Checksum 0xcd547dd2, Offset: 0x3bc0
// Size: 0x54
function function_41990a66() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].longregentime;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_c127b241
// Checksum 0xfbf91624, Offset: 0x3c20
// Size: 0x54
function function_c127b241() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].playerhealth_regularregendelay;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_1aed2639
// Checksum 0x94faf59a, Offset: 0x3c80
// Size: 0x54
function function_1aed2639() {
    function_74d15397();
    var_d35c182a = level.var_1bace747[level.gameskill].worthydamageratio;
    if (isdefined(var_d35c182a)) {
        return var_d35c182a;
    }
    return 0;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_6979803c
// Checksum 0xbb2f5a71, Offset: 0x3ce0
// Size: 0x146
function function_6979803c() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_689cb84e;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_ed19e9a8;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_537a43e;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_7c30779c;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    }
    return 1;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_c29e1b7d
// Checksum 0xd9255e96, Offset: 0x3e30
// Size: 0x152
function function_c29e1b7d() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_e6ba970d;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_ed274ed3;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_f071abbd;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_fd59fce7;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    default:
        return 1;
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_35c3fd5f
// Checksum 0x3d1e7358, Offset: 0x3f90
// Size: 0x152
function function_35c3fd5f() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_84dbf919;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_4c0a2833;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_7c84daa9;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_f45f8e27;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    default:
        return 1;
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_c7e81340
// Checksum 0xaa733a55, Offset: 0x40f0
// Size: 0x152
function function_c7e81340() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_17d30e79;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_b19673f7;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_520c9b29;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_7fc7ac2b;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    default:
        return 1;
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_d6a24e36
// Checksum 0x8c5a7af5, Offset: 0x4250
// Size: 0x152
function function_d6a24e36() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_4b093797;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_89052855;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_c2c11e27;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_161f6fd1;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    default:
        return 1;
    }
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_e314b70d
// Checksum 0x8f491374, Offset: 0x43b0
// Size: 0x146
function function_e314b70d() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_c58523a1;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_9ef90923;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_b23aedb1;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_f2af205f;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    }
    return 1;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_242ea84e
// Checksum 0xb373ac07, Offset: 0x4500
// Size: 0x146
function function_242ea84e() {
    function_74d15397();
    switch (level.players.size) {
    case 1:
        var_d35c182a = level.var_1bace747[level.gameskill].var_8dfa5ba;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 2:
        var_d35c182a = level.var_1bace747[level.gameskill].var_1bb1260;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 3:
        var_d35c182a = level.var_1bace747[level.gameskill].var_f2f8b9aa;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    case 4:
        var_d35c182a = level.var_1bace747[level.gameskill].var_550f6f64;
        if (isdefined(var_d35c182a)) {
            return var_d35c182a;
        } else {
            return 0;
        }
        break;
    }
    return 1;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_1ef3d569
// Checksum 0x9d1c89a4, Offset: 0x4650
// Size: 0x42
function function_1ef3d569() {
    value = level.gameskill + level.players.size - 1;
    if (value < 0) {
        value = 0;
    }
    return value;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_10a2e0f5
// Checksum 0xa43fd0dd, Offset: 0x46a0
// Size: 0x46
function function_10a2e0f5() {
    player = self;
    if (level.gameskill >= 4) {
        return 0;
    }
    if (!isdefined(self.var_73881ee1)) {
        self.var_73881ee1 = 1;
    }
    return self.var_73881ee1;
}

// Namespace gameskill
// Params 0, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_58f840ea
// Checksum 0xe61dd83c, Offset: 0x46f0
// Size: 0x54
function function_58f840ea() {
    self endon(#"disconnect");
    self endon(#"death");
    while (!self.var_73881ee1) {
        if (self.health >= self.maxhealth) {
            self.var_73881ee1 = 1;
        }
        wait(0.05);
    }
}

// Namespace gameskill
// Params 7, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_57ab3c9d
// Checksum 0x7b492b4a, Offset: 0x4750
// Size: 0xaa
function function_57ab3c9d(player, eattacker, einflictor, idamage, weapon, shitloc, var_785f4b6e) {
    var_332fb907 = function_c7e81340();
    var_c3484aa3 = function_f0299cbc() * var_332fb907;
    var_6a9a46fe = 100 / var_c3484aa3;
    idamage *= var_6a9a46fe;
    return idamage;
}

// Namespace gameskill
// Params 7, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_904126cf
// Checksum 0x7afb1ecc, Offset: 0x4808
// Size: 0x12e
function function_904126cf(player, eattacker, einflictor, idamage, weapon, shitloc, var_785f4b6e) {
    if ((var_785f4b6e == "MOD_MELEE" || var_785f4b6e == "MOD_MELEE_WEAPON_BUTT") && isentity(eattacker)) {
        idamage /= 5;
        if (idamage > 40) {
            playerforward = anglestoforward(player.angles);
            var_ca0031a3 = vectornormalize(eattacker.origin - player.origin);
            if (vectordot(playerforward, var_ca0031a3) < 0.342) {
                idamage = 40;
            }
        }
    }
    return idamage;
}

// Namespace gameskill
// Params 0, eflags: 0x0
// namespace_6c41e242<file_0>::function_305cdc5c
// Checksum 0x645eb3bb, Offset: 0x4940
// Size: 0x20
function function_305cdc5c() {
    self endon(#"death");
    self.baseaccuracy = self.accuracy;
}

// Namespace gameskill
// Params 1, eflags: 0x1 linked
// namespace_6c41e242<file_0>::function_bc280431
// Checksum 0x8fff7fa8, Offset: 0x4968
// Size: 0x4cc
function function_bc280431(ai) {
    self endon(#"death");
    if (getdvarint("ai_codeGameskill")) {
        return;
    }
    while (true) {
        if (isdefined(ai.enemy)) {
            if (isplayer(ai.enemy)) {
                if (!isdefined(ai.var_ffec2e60)) {
                    ai.var_ffec2e60 = ai.enemy;
                    ai.var_5a348cf0 = 0;
                    ai.var_8a14057b = gettime();
                    ai.lastshottime = ai.var_8a14057b;
                }
                if (ai.enemy != ai.var_ffec2e60) {
                    ai.var_ffec2e60 = ai.enemy;
                    ai.var_5a348cf0 = 0;
                    ai.var_8a14057b = gettime();
                    ai.lastshottime = ai.var_8a14057b;
                } else {
                    ai.var_42a4172a = function_702b3695();
                    ai.var_31b4c6e3 = function_43c73456();
                    ai.var_5017455f = function_7deab2f2();
                    if (ai.accuratefire) {
                        ai.var_5017455f *= 2;
                    }
                    var_a8d559fa = gettime();
                    var_9b68b629 = var_a8d559fa - ai.var_8a14057b;
                    distance = distance(ai.origin, ai.enemy.origin);
                    misstime = ai.var_42a4172a * 1000;
                    var_a82beafe = misstime + distance * ai.var_31b4c6e3;
                    var_d9ed1275 = anglestoforward(ai.enemy.angles);
                    var_e8ca7d79 = vectornormalize(ai.origin - ai.enemy.origin);
                    if (vectordot(var_d9ed1275, var_e8ca7d79) < 0.7) {
                        var_a82beafe *= 2;
                    }
                    if (var_a8d559fa - ai.lastshottime > ai.var_5017455f) {
                        ai.var_5a348cf0 = 0;
                        ai.var_8a14057b = var_a8d559fa;
                        var_9b68b629 = 0;
                    }
                    if (var_9b68b629 > var_a82beafe) {
                        ai.var_5a348cf0 = 1;
                    }
                    if (var_9b68b629 <= var_a82beafe && var_9b68b629 > var_a82beafe * 0.66) {
                        ai.var_5a348cf0 = 0.66;
                    }
                    if (var_9b68b629 <= var_a82beafe * 0.66 && var_9b68b629 > var_a82beafe * 0.33) {
                        ai.var_5a348cf0 = 0.33;
                    }
                    if (var_9b68b629 <= var_a82beafe * 0.33) {
                        ai.var_5a348cf0 = 0;
                    }
                    ai.lastshottime = var_a8d559fa;
                }
            } else {
                ai.var_5a348cf0 = 1;
            }
            ai.accuracy = ai.baseaccuracy * ai.var_5a348cf0;
        }
        self waittill(#"about_to_shoot");
    }
}

