#using scripts/zm/_zm_perks;
#using scripts/zm/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_2547ab20;

// Namespace namespace_2547ab20
// Params 0, eflags: 0x2
// namespace_2547ab20<file_0>::function_2dc19561
// Checksum 0x31e42b91, Offset: 0x2e8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_playerhealth", &__init__, undefined, undefined);
}

// Namespace namespace_2547ab20
// Params 0, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_8c87d8eb
// Checksum 0x1e9db964, Offset: 0x328
// Size: 0x33c
function __init__() {
    clientfield::register("toplayer", "sndZombieHealth", 21000, 1, "int");
    level.var_6a21f752 = &function_79977f70;
    level.var_e88bb559 = &function_79977f70;
    level.difficultytype[0] = "easy";
    level.difficultytype[1] = "normal";
    level.difficultytype[2] = "hardened";
    level.difficultytype[3] = "veteran";
    level.difficultystring["easy"] = %GAMESKILL_EASY;
    level.difficultystring["normal"] = %GAMESKILL_NORMAL;
    level.difficultystring["hardened"] = %GAMESKILL_HARDENED;
    level.difficultystring["veteran"] = %GAMESKILL_VETERAN;
    /#
        thread function_610dfe1();
    #/
    level.gameskill = 1;
    switch (level.gameskill) {
    case 0:
        setdvar("currentDifficulty", "easy");
        break;
    case 1:
        setdvar("currentDifficulty", "normal");
        break;
    case 2:
        setdvar("currentDifficulty", "hardened");
        break;
    case 3:
        setdvar("currentDifficulty", "veteran");
        break;
    }
    /#
        print("GAMESKILL_EASY" + level.gameskill);
    #/
    level.player_deathinvulnerabletime = 1700;
    level.longregentime = 5000;
    level.healthoverlaycutoff = 0.2;
    level.invultime_preshield = 0.35;
    level.invultime_onshield = 0.5;
    level.invultime_postshield = 0.3;
    level.playerhealth_regularregendelay = 2400;
    level.worthydamageratio = 0.1;
    callback::on_spawned(&on_player_spawned);
    if (!isdefined(level.var_2f04d4bd)) {
        level.var_2f04d4bd = 22;
    }
    visionset_mgr::register_info("overlay", "zm_health_blur", 1, level.var_2f04d4bd, 1, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1);
}

// Namespace namespace_2547ab20
// Params 0, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_aebcf025
// Checksum 0xc7762652, Offset: 0x670
// Size: 0x44
function on_player_spawned() {
    self zm_perks::function_78f42790("health_reboot", 1, 0);
    self notify(#"hash_a5d08426");
    self thread playerhealthregen();
}

// Namespace namespace_2547ab20
// Params 0, eflags: 0x0
// namespace_2547ab20<file_0>::function_8f07d3ea
// Checksum 0xb14fa474, Offset: 0x6c0
// Size: 0x54
function function_8f07d3ea() {
    visionset_mgr::deactivate("overlay", "zm_health_blur", self);
    visionset_mgr::activate("overlay", "zm_health_blur", self, 0, 1, 1);
}

// Namespace namespace_2547ab20
// Params 0, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_fabc32f
// Checksum 0x8af64608, Offset: 0x720
// Size: 0xcc
function function_fabc32f() {
    self endon(#"hash_a5d08426");
    self.var_1428596a = 0;
    for (;;) {
        amount, attacker, dir, point, mod = self waittill(#"damage");
        if (isdefined(attacker) && isplayer(attacker) && attacker.team == self.team) {
            continue;
        }
        self.var_1428596a = 1;
        self.damagepoint = point;
        self.damageattacker = attacker;
    }
}

// Namespace namespace_2547ab20
// Params 0, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_d1591847
// Checksum 0x8d589359, Offset: 0x7f8
// Size: 0x730
function playerhealthregen() {
    self notify(#"playerhealthregen");
    self endon(#"playerhealthregen");
    self endon(#"death");
    self endon(#"disconnect");
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
    self thread healthoverlay();
    var_3d0925a9 = 1;
    var_4d2b26fb = 0;
    regenrate = 0.1;
    veryhurt = 0;
    var_b72c1399 = 0;
    var_2ce8450a = 0;
    hurttime = 0;
    newhealth = 0;
    var_d80fbb0e = 1;
    self thread function_fabc32f();
    if (!isdefined(self.veryhurt)) {
        self.veryhurt = 0;
    }
    self.var_65e2ccf7 = 0;
    if (getdvarstring("scr_playerInvulTimeScale") == "") {
        setdvar("scr_playerInvulTimeScale", 1);
    }
    var_a43f2f3 = getdvarfloat("scr_playerInvulTimeScale");
    for (;;) {
        wait(0.05);
        waittillframeend();
        if (self.health == self.maxhealth) {
            if (self flag::get("player_has_red_flashing_overlay")) {
                self clientfield::set_to_player("sndZombieHealth", 0);
                self flag::clear("player_has_red_flashing_overlay");
            }
            var_d80fbb0e = 1;
            var_b72c1399 = 0;
            veryhurt = 0;
            continue;
        }
        if (self.health <= 0) {
            /#
                function_adec9ac9();
            #/
            return;
        }
        wasveryhurt = veryhurt;
        var_55ed49d3 = self.health / self.maxhealth;
        if (var_55ed49d3 <= level.healthoverlaycutoff) {
            veryhurt = 1;
            if (!wasveryhurt) {
                hurttime = gettime();
                self startfadingblur(3.6, 2);
                self clientfield::set_to_player("sndZombieHealth", 1);
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
                    newhealth += regenrate;
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
            /#
                if (newhealth > var_55ed49d3) {
                    function_895a501c(newhealth);
                }
            #/
            self setnormalhealth(newhealth);
            var_3d0925a9 = self.health / self.maxhealth;
            continue;
        }
        var_7a2a169 = var_d80fbb0e - var_55ed49d3 > level.worthydamageratio;
        if (self.health <= 1) {
            self setnormalhealth(2 / self.maxhealth);
            var_7a2a169 = 1;
            /#
                if (!isdefined(level.var_6ab88489)) {
                    level.var_6ab88489 = 0;
                }
                if (level.var_6ab88489 < gettime()) {
                    level.var_6ab88489 = gettime() + getdvarint("GAMESKILL_EASY");
                }
            #/
        }
        var_3d0925a9 = self.health / self.maxhealth;
        level notify(#"hash_4bd1d9d5");
        var_4d2b26fb = 0;
        hurttime = gettime();
        self startfadingblur(3, 0.8);
        if (!var_7a2a169 || var_a43f2f3 <= 0) {
            /#
                function_2055ee00(self.health, 0);
            #/
            continue;
        }
        if (self flag::get("player_is_invulnerable")) {
            continue;
        }
        self flag::set("player_is_invulnerable");
        level notify(#"hash_b995d6a3");
        if (var_b72c1399) {
            var_2ce8450a = level.invultime_onshield;
            var_b72c1399 = 0;
        } else if (veryhurt) {
            var_2ce8450a = level.invultime_postshield;
        } else {
            var_2ce8450a = level.invultime_preshield;
        }
        var_2ce8450a *= var_a43f2f3;
        /#
            function_2055ee00(self.health, var_2ce8450a);
        #/
        var_d80fbb0e = self.health / self.maxhealth;
        self thread function_bd76f2fc(var_2ce8450a);
    }
}

// Namespace namespace_2547ab20
// Params 1, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_bd76f2fc
// Checksum 0x7c3c6426, Offset: 0xf30
// Size: 0x6c
function function_bd76f2fc(timer) {
    self endon(#"death");
    self endon(#"disconnect");
    if (timer > 0) {
        /#
            level.var_76f0070e = gettime() + timer * 1000;
        #/
        wait(timer);
    }
    self flag::clear("player_is_invulnerable");
}

// Namespace namespace_2547ab20
// Params 0, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_18001e6d
// Checksum 0x5bb3085f, Offset: 0xfa8
// Size: 0x1e0
function healthoverlay() {
    self endon(#"disconnect");
    self endon(#"hash_a5d08426");
    if (!isdefined(self.var_90f9d92b)) {
        self.var_90f9d92b = newclienthudelem(self);
        self.var_90f9d92b.x = 0;
        self.var_90f9d92b.y = 0;
        self.var_90f9d92b setshader("overlay_low_health", 640, 480);
        self.var_90f9d92b.alignx = "left";
        self.var_90f9d92b.aligny = "top";
        self.var_90f9d92b.horzalign = "fullscreen";
        self.var_90f9d92b.vertalign = "fullscreen";
        self.var_90f9d92b.alpha = 0;
    }
    overlay = self.var_90f9d92b;
    self thread function_2d8009b8(overlay);
    self thread function_129bb55f(overlay);
    pulsetime = 0.8;
    for (;;) {
        if (overlay.alpha > 0) {
            overlay fadeovertime(0.5);
        }
        overlay.alpha = 0;
        self flag::wait_till("player_has_red_flashing_overlay");
        self function_131503b4(overlay);
    }
}

// Namespace namespace_2547ab20
// Params 4, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_bbe24e91
// Checksum 0x7e454e0b, Offset: 0x1190
// Size: 0x240
function function_bbe24e91(overlay, severity, mult, var_7170800d) {
    pulsetime = 0.8;
    scalemin = 0.5;
    fadeintime = pulsetime * 0.1;
    var_a93d5122 = pulsetime * (0.1 + severity * 0.2);
    var_ac705df5 = pulsetime * (0.1 + severity * 0.1);
    var_97b1675d = pulsetime * 0.3;
    remainingtime = pulsetime - fadeintime - var_a93d5122 - var_ac705df5 - var_97b1675d;
    assert(remainingtime >= -0.001);
    if (remainingtime < 0) {
        remainingtime = 0;
    }
    var_84c9a0be = 0.8 + severity * 0.1;
    var_833e5b9c = 0.5 + severity * 0.3;
    overlay fadeovertime(fadeintime);
    overlay.alpha = mult * 1;
    wait(fadeintime + var_a93d5122);
    overlay fadeovertime(var_ac705df5);
    overlay.alpha = mult * var_84c9a0be;
    wait(var_ac705df5);
    overlay fadeovertime(var_97b1675d);
    overlay.alpha = mult * var_833e5b9c;
    wait(var_97b1675d);
    wait(remainingtime);
}

// Namespace namespace_2547ab20
// Params 1, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_129bb55f
// Checksum 0x58cbcec4, Offset: 0x13d8
// Size: 0xae
function function_129bb55f(overlay) {
    self endon(#"hash_3f7b661c");
    while (isdefined(overlay)) {
        self waittill(#"clear_red_flashing_overlay");
        self clientfield::set_to_player("sndZombieHealth", 0);
        self flag::clear("player_has_red_flashing_overlay");
        overlay fadeovertime(0.05);
        overlay.alpha = 0;
        self notify(#"hash_4bd1d9d5");
    }
}

// Namespace namespace_2547ab20
// Params 1, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_131503b4
// Checksum 0xaa59a084, Offset: 0x1490
// Size: 0x24a
function function_131503b4(overlay) {
    self endon(#"hash_4bd1d9d5");
    self endon(#"damage");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"clear_red_flashing_overlay");
    self.var_af9bd93e = gettime() + level.longregentime;
    if (!(isdefined(self.is_in_process_of_zombify) && self.is_in_process_of_zombify) && !(isdefined(self.is_zombie) && self.is_zombie)) {
        function_bbe24e91(overlay, 1, 1, 0);
        while (!(isdefined(self.is_in_process_of_zombify) && self.is_in_process_of_zombify) && gettime() < self.var_af9bd93e && isalive(self) && !(isdefined(self.is_zombie) && self.is_zombie)) {
            function_bbe24e91(overlay, 0.9, 1, 0);
        }
        if (!(isdefined(self.is_in_process_of_zombify) && self.is_in_process_of_zombify) && !(isdefined(self.is_zombie) && self.is_zombie)) {
            if (isalive(self)) {
                function_bbe24e91(overlay, 0.65, 0.8, 0);
            }
            function_bbe24e91(overlay, 0, 0.6, 1);
        }
    }
    overlay fadeovertime(0.5);
    overlay.alpha = 0;
    self flag::clear("player_has_red_flashing_overlay");
    self clientfield::set_to_player("sndZombieHealth", 0);
    wait(0.5);
    self notify(#"hash_4bd1d9d5");
}

// Namespace namespace_2547ab20
// Params 1, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_2d8009b8
// Checksum 0x15591e96, Offset: 0x16e8
// Size: 0x6c
function function_2d8009b8(overlay) {
    self endon(#"disconnect");
    self util::waittill_any("noHealthOverlay", "death");
    overlay fadeovertime(3.5);
    overlay.alpha = 0;
}

// Namespace namespace_2547ab20
// Params 5, eflags: 0x1 linked
// namespace_2547ab20<file_0>::function_79977f70
// Checksum 0xb17f6bcb, Offset: 0x1760
// Size: 0x2c
function function_79977f70(type, loc, point, attacker, amount) {
    
}

/#

    // Namespace namespace_2547ab20
    // Params 2, eflags: 0x1 linked
    // namespace_2547ab20<file_0>::function_2055ee00
    // Checksum 0x59f3e9d, Offset: 0x1798
    // Size: 0x18
    function function_2055ee00(newhealth, var_2ce8450a) {
        
    }

    // Namespace namespace_2547ab20
    // Params 1, eflags: 0x1 linked
    // namespace_2547ab20<file_0>::function_895a501c
    // Checksum 0x1acf3c81, Offset: 0x17b8
    // Size: 0x10
    function function_895a501c(newhealth) {
        
    }

    // Namespace namespace_2547ab20
    // Params 0, eflags: 0x1 linked
    // namespace_2547ab20<file_0>::function_adec9ac9
    // Checksum 0x1c49d3a3, Offset: 0x17d0
    // Size: 0x8
    function function_adec9ac9() {
        
    }

    // Namespace namespace_2547ab20
    // Params 0, eflags: 0x1 linked
    // namespace_2547ab20<file_0>::function_610dfe1
    // Checksum 0x13442feb, Offset: 0x17e0
    // Size: 0x110
    function function_610dfe1() {
        if (getdvarstring("GAMESKILL_EASY") == "GAMESKILL_EASY") {
            setdvar("GAMESKILL_EASY", "GAMESKILL_EASY");
        }
        waittillframeend();
        while (true) {
            while (true) {
                if (getdvarstring("GAMESKILL_EASY") != "GAMESKILL_EASY") {
                    break;
                }
                wait(0.5);
            }
            thread function_6227a919();
            while (true) {
                if (getdvarstring("GAMESKILL_EASY") == "GAMESKILL_EASY") {
                    break;
                }
                wait(0.5);
            }
            level notify(#"hash_31415269");
            function_b75a45fc();
        }
    }

    // Namespace namespace_2547ab20
    // Params 0, eflags: 0x1 linked
    // namespace_2547ab20<file_0>::function_6227a919
    // Checksum 0x28e276b8, Offset: 0x18f8
    // Size: 0x66e
    function function_6227a919() {
        level notify(#"hash_3871a4a1");
        level endon(#"hash_3871a4a1");
        x = 40;
        y = 40;
        level.var_7e842153 = [];
        level.var_fbe7c2fe[0] = "GAMESKILL_EASY";
        level.var_fbe7c2fe[1] = "GAMESKILL_EASY";
        level.var_fbe7c2fe[2] = "GAMESKILL_EASY";
        if (!isdefined(level.var_76f0070e)) {
            level.var_76f0070e = 0;
        }
        if (!isdefined(level.var_6ab88489)) {
            level.var_6ab88489 = 0;
        }
        for (i = 0; i < level.var_fbe7c2fe.size; i++) {
            key = level.var_fbe7c2fe[i];
            var_31704579 = newhudelem();
            var_31704579.x = x;
            var_31704579.y = y;
            var_31704579.alignx = "GAMESKILL_EASY";
            var_31704579.aligny = "GAMESKILL_EASY";
            var_31704579.horzalign = "GAMESKILL_EASY";
            var_31704579.vertalign = "GAMESKILL_EASY";
            var_31704579 settext(key);
            bgbar = newhudelem();
            bgbar.x = x + 79;
            bgbar.y = y + 1;
            bgbar.alignx = "GAMESKILL_EASY";
            bgbar.aligny = "GAMESKILL_EASY";
            bgbar.horzalign = "GAMESKILL_EASY";
            bgbar.vertalign = "GAMESKILL_EASY";
            bgbar.maxwidth = 3;
            bgbar setshader("GAMESKILL_EASY", bgbar.maxwidth, 10);
            bgbar.color = (0.5, 0.5, 0.5);
            bar = newhudelem();
            bar.x = x + 80;
            bar.y = y + 2;
            bar.alignx = "GAMESKILL_EASY";
            bar.aligny = "GAMESKILL_EASY";
            bar.horzalign = "GAMESKILL_EASY";
            bar.vertalign = "GAMESKILL_EASY";
            bar setshader("GAMESKILL_EASY", 1, 8);
            var_31704579.bar = bar;
            var_31704579.bgbar = bgbar;
            var_31704579.key = key;
            y += 10;
            level.var_7e842153[key] = var_31704579;
        }
        level flag::wait_till("GAMESKILL_EASY");
        while (true) {
            wait(0.05);
            players = getplayers();
            for (i = 0; i < level.var_fbe7c2fe.size && players.size > 0; i++) {
                key = level.var_fbe7c2fe[i];
                player = players[0];
                width = 0;
                if (i == 0) {
                    width = player.health / player.maxhealth * 300;
                } else if (i == 1) {
                    width = (level.var_76f0070e - gettime()) / 1000 * 40;
                } else if (i == 2) {
                    width = (level.var_6ab88489 - gettime()) / 1000 * 40;
                }
                width = int(max(width, 1));
                width = int(min(width, 300));
                bar = level.var_7e842153[key].bar;
                bar setshader("GAMESKILL_EASY", width, 8);
                bgbar = level.var_7e842153[key].bgbar;
                if (width + 2 > bgbar.maxwidth) {
                    bgbar.maxwidth = width + 2;
                    bgbar setshader("GAMESKILL_EASY", bgbar.maxwidth, 10);
                    bgbar.color = (0.5, 0.5, 0.5);
                }
            }
        }
    }

    // Namespace namespace_2547ab20
    // Params 0, eflags: 0x1 linked
    // namespace_2547ab20<file_0>::function_b75a45fc
    // Checksum 0x96689f7b, Offset: 0x1f70
    // Size: 0xce
    function function_b75a45fc() {
        if (!isdefined(level.var_7e842153)) {
            return;
        }
        for (i = 0; i < level.var_fbe7c2fe.size; i++) {
            level.var_7e842153[level.var_fbe7c2fe[i]].bgbar destroy();
            level.var_7e842153[level.var_fbe7c2fe[i]].bar destroy();
            level.var_7e842153[level.var_fbe7c2fe[i]] destroy();
        }
    }

#/
