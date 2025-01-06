#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_fate;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_shield_pickup;
#using scripts/cp/doa/_doa_tesla_pickup;
#using scripts/cp/doa/_doa_turret_pickup;
#using scripts/cp/doa/_doa_utility;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace namespace_831a4a7c;

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x61a5751, Offset: 0xaa0
// Size: 0x16a
function function_138c35de() {
    self show();
    if (!isdefined(self.entnum)) {
        self.entnum = self getentitynumber();
    }
    assert(!isdefined(self.doa), "<dev string:x28>");
    level flagsys::wait_till("doa_init_complete");
    self setthreatbiasgroup("players");
    self setcharacterbodytype(self.entnum, self.entnum);
    self setcharacterbodystyle(0);
    self setcharacterhelmetstyle(0);
    self.doa = spawnstruct();
    self enablelinkto();
    self thread turnplayershieldon(0);
    self thread function_bbb1254c(1);
    if (isdefined(level.doa) && isdefined(level.doa.var_bc9b7c71)) {
        self thread [[ level.doa.var_bc9b7c71 ]]();
    }
    self thread function_7d7a7fde();
    self function_60123d1c();
    self thread function_70339630();
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x1dc26bcb, Offset: 0xc18
// Size: 0x46
function function_70339630() {
    self endon(#"disconnect");
    while (array::contains(level.activeplayers, self) == 0) {
        self.ignoreme = 1;
        wait 0.05;
    }
    self.ignoreme = 0;
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0xc4f14dd8, Offset: 0xc68
// Size: 0x4e1
function function_bbb1254c(var_44eb97b0) {
    if (!isdefined(var_44eb97b0)) {
        var_44eb97b0 = 0;
    }
    if (!isdefined(self)) {
        return;
    }
    self.doa.multiplier = 1;
    self.doa.var_d55e6679 = 0;
    self.doa.var_1c03b6ad = 1;
    self.doa.weapontime = 0;
    self.doa.var_91c268dc = 0;
    self.doa.weaponlevel = 0;
    self.doa.var_c2b9d7d0 = 0;
    self.topdowncamera = 1;
    self.ignoreme = 0;
    self.doa.respawning = 0;
    if (var_44eb97b0) {
        self.headshots = 0;
        self.downs = 0;
        self.revives = 0;
        self.score = 0;
        self.assists = 0;
        self.kills = 0;
        self.deaths = 0;
        self.skulls = 0;
        self.gems = 0;
        self.chickens = 0;
        self.doa.score = 0;
        self.doa.fate = 0;
        self.doa.bombs = level.doa.rules.var_812a15ac;
        self.doa.var_c5e98ad6 = level.doa.rules.var_ec21c11e;
        self.doa.lives = level.doa.rules.var_1a69346e;
        self.doa.var_ca0a87c8 = getweapon(level.doa.rules.default_weapon);
        self.doa.var_295df6ca = level.doa.rules.var_61b88ecb;
        self.doa.var_5d2140f2 = level.doa.rules.var_a9114441;
        self.doa.lightstate = 1;
        self.doa.var_c5fe2763 = undefined;
        self.doa.var_af875fb7 = [];
        self notify(#"hash_44eb97b0");
        wait 0.05;
        if (isdefined(self.doa.var_3cdd8203)) {
            foreach (chicken in self.doa.var_3cdd8203) {
                if (isdefined(chicken.bird)) {
                    chicken.bird delete();
                }
                chicken delete();
            }
            self.doa.var_3cdd8203 = [];
        }
    }
    if (self.doa.fate == 4 || self.doa.fate == 13) {
        self.doa.var_1c03b6ad = level.doa.rules.var_b92b82b;
    }
    self.doa.var_7c1bcaf3 = 0;
    if (self.doa.fate == 2) {
        self.doa.var_7c1bcaf3 = 1;
    } else if (self.doa.fate == 11) {
        self.doa.var_7c1bcaf3 = 2;
    }
    self setmovespeedscale(self.doa.var_1c03b6ad);
    self function_aea40863();
    self function_1a86a494();
    self thread function_4eabae51();
    self thread function_ab0e2cf3();
    self thread function_73d40751();
    self thread function_f19e9b07();
    self thread infiniteammo();
    self thread function_60123d1c();
    self thread function_7d7a7fde();
    self thread function_d7c57981();
    self thread function_e6b2517f();
    /#
    #/
    self setplayercollision(1);
    self cleardamageindicator();
    if (isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback destroy();
        self.hud_damagefeedback = undefined;
    }
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x4126f27c, Offset: 0x1158
// Size: 0x2d5
function function_eb67e3d2() {
    while (true) {
        if (self stancebuttonpressed()) {
            stance = 1;
        }
        if (self fragbuttonpressed()) {
            frag = 1;
        }
        if (self reloadbuttonpressed()) {
            reload = 1;
        }
        if (self secondaryoffhandbuttonpressed()) {
            var_6275e96c = 1;
        }
        if (self inventorybuttonpressed()) {
            inventory = 1;
        }
        if (self offhandspecialbuttonpressed()) {
            var_41f5c788 = 1;
        }
        if (self weaponswitchbuttonpressed()) {
            var_ad9943fa = 1;
        }
        if (self vehiclemoveupbuttonpressed()) {
            var_affc5722 = 1;
        }
        if (self actionbuttonpressed()) {
            action = 1;
        }
        if (self jumpbuttonpressed()) {
            jump = 1;
        }
        if (self sprintbuttonpressed()) {
            sprint = 1;
        }
        if (self meleebuttonpressed()) {
            melee = 1;
        }
        if (self throwbuttonpressed()) {
            throw = 1;
        }
        if (self adsbuttonpressed()) {
            ads = 1;
        }
        if (self actionslotfourbuttonpressed()) {
            var_5a25f449 = 1;
        }
        if (self actionslotthreebuttonpressed()) {
            var_18325856 = 1;
        }
        if (self actionslottwobuttonpressed()) {
            var_3e34d2bf = 1;
        }
        if (self actionslotonebuttonpressed()) {
            action1 = 1;
        }
        if (self attackbuttonpressed()) {
            attack = 1;
        }
        if (self boostbuttonpressed()) {
            boost = 1;
        }
        if (self changeseatbuttonpressed()) {
            var_eecc1ec6 = 1;
        }
        if (self usebuttonpressed()) {
            use = 1;
        }
        wait 0.05;
    }
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xe2de927e, Offset: 0x1438
// Size: 0x82
function function_7e372abd() {
    self endon(#"disconnect");
    while (!isdefined(self.doa)) {
        wait 0.05;
    }
    self.doa.var_f4a883ed = undefined;
    self disableinvulnerability();
    if (!isalive(self)) {
        self function_ad1d5fcb(1);
        return;
    }
    self function_bbb1254c(1);
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x74816429, Offset: 0x14c8
// Size: 0x6b
function function_4db260cb() {
    foreach (player in getplayers()) {
        player thread function_7e372abd();
    }
}

// Namespace namespace_831a4a7c
// Params 2, eflags: 0x0
// Checksum 0x6a5f60d8, Offset: 0x1540
// Size: 0xdd
function function_895845f9(origin, ignore_player) {
    valid_player_found = 0;
    players = getplayers();
    if (isdefined(ignore_player)) {
        for (i = 0; i < ignore_player.size; i++) {
            if (isdefined(ignore_player[i])) {
                players = arrayremovevalue(players, ignore_player[i]);
            }
        }
    }
    while (!valid_player_found) {
        player = namespace_49107f3a::function_5ee38fe3(origin, players);
        if (!isdefined(player)) {
            return undefined;
        }
        if (!isplayervalid(player, 1)) {
            players = arrayremovevalue(players, player);
            continue;
        }
        return player;
    }
}

// Namespace namespace_831a4a7c
// Params 2, eflags: 0x0
// Checksum 0xf0b17932, Offset: 0x1628
// Size: 0x79
function isplayervalid(player, checkignoremeflag) {
    if (!isdefined(player)) {
        return false;
    }
    if (!isalive(player)) {
        return false;
    }
    if (!isplayer(player)) {
        return false;
    }
    if (player.sessionstate == "spectator") {
        return false;
    }
    if (player.sessionstate == "intermission") {
        return false;
    }
    return true;
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x6a653fac, Offset: 0x16b0
// Size: 0xb2
function function_5bcae97c(trigger) {
    trigger endon(#"death");
    msg = self util::waittill_any_return("enter_vehicle", "disconnect", "turnPlayerShieldOn", "turnPlayerShieldOff");
    if (isdefined(self)) {
        self function_4519b17(0);
        self.doa.var_3b383993 = undefined;
        self thread namespace_eaa992c::turnofffx("player_shield_short");
        self thread namespace_eaa992c::turnofffx("player_shield_long");
    }
    trigger delete();
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x71913891, Offset: 0x1770
// Size: 0x213
function turnplayershieldon(var_f8ae67a3) {
    if (!isdefined(var_f8ae67a3)) {
        var_f8ae67a3 = 1;
    }
    if (!isplayer(self)) {
        return;
    }
    self endon(#"disconnect");
    self endon(#"enter_vehicle");
    self notify(#"turnplayershieldon");
    self endon(#"turnplayershieldon");
    if (!isdefined(self.doa) || isdefined(self.doa.vehicle)) {
        return;
    }
    if (isdefined(self.doa.var_3b383993)) {
        self notify(#"turnPlayerShieldOff");
        waittillframeend();
    } else if (var_f8ae67a3) {
        self thread namespace_1a381543::function_90118d8c("zmb_player_shield_half");
    } else {
        self playsound("zmb_player_shield_full");
    }
    self function_4519b17(1);
    trigger = spawn("trigger_radius", self.origin, 17, 50, 50);
    trigger.targetname = "turnPlayerShieldOn";
    self thread function_5bcae97c(trigger);
    self.doa.var_3b383993 = trigger;
    trigger enablelinkto();
    trigger linkto(self);
    trigger thread function_e6711e4e(self);
    trigger thread namespace_49107f3a::function_1bd67aef(9.85);
    trigger thread namespace_49107f3a::function_a625b5d3(self);
    util::wait_network_frame();
    if (var_f8ae67a3) {
        self thread namespace_eaa992c::function_285a2999("player_shield_short");
    } else {
        self thread namespace_eaa992c::function_285a2999("player_shield_long");
        wait 6;
    }
    self thread namespace_1a381543::function_90118d8c("zmb_player_shield_half");
    wait 3;
    self thread namespace_1a381543::function_90118d8c("zmb_player_shield_end");
    self function_4519b17(0);
    self notify(#"turnPlayerShieldOff");
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x4
// Checksum 0x4fa6bdba, Offset: 0x1990
// Size: 0x1d
function private function_6b0da7ff() {
    self endon(#"death");
    while (true) {
        wait 0.05;
    }
}

// Namespace namespace_831a4a7c
// Params 3, eflags: 0x0
// Checksum 0xf0004e9f, Offset: 0x19b8
// Size: 0x382
function function_e6711e4e(player, var_c1ff53d9, thresh) {
    self endon(#"death");
    self thread function_6b0da7ff();
    self thread function_ab9cf24b(player);
    self.player = player;
    while (isdefined(player)) {
        self waittill(#"trigger", guy);
        if (!isdefined(guy)) {
            continue;
        }
        if (isplayer(guy)) {
            continue;
        }
        if (isdefined(guy.launched)) {
            continue;
        }
        if (!issentient(guy)) {
            continue;
        }
        if (!(isdefined(guy.takedamage) && guy.takedamage)) {
            continue;
        }
        if (isdefined(guy.boss) && guy.boss) {
            continue;
        }
        if (guy.team == player.team) {
            continue;
        }
        ok = 1;
        if (isdefined(var_c1ff53d9)) {
            v_velocity = var_c1ff53d9 getvelocity();
            speed = lengthsquared(v_velocity);
            /#
            #/
            ok = speed < thresh * thresh;
        }
        if (!ok) {
            continue;
        }
        guy setplayercollision(0);
        if (!isvehicle(guy)) {
            if (!(isdefined(guy.var_7ebc405c) && guy.var_7ebc405c)) {
                guy.launched = 1;
                if (randomint(100) < getdvarint("scr_doa_ragdoll_toss_up_chance", 25)) {
                    velocity = function_93739933(player getvelocity());
                    if (velocity > 30 && !(isdefined(guy.var_ad61c13d) && guy.var_ad61c13d)) {
                        guy clientfield::set("zombie_rhino_explosion", 1);
                        namespace_fba031c8::trygibbinglimb(guy, 5000);
                        namespace_fba031c8::trygibbinglegs(guy, 5000, undefined, 1, player);
                    }
                    assert(!(isdefined(guy.boss) && guy.boss));
                    guy startragdoll();
                    guy launchragdoll((0, 0, 220));
                    guy thread namespace_1a381543::function_90118d8c("zmb_ragdoll_launched");
                    guy thread namespace_49107f3a::function_ba30b321(0.2, player);
                } else {
                    guy dodamage(guy.health, player.origin, player, player, "none", "MOD_EXPLOSIVE");
                }
            } else {
                guy dodamage(guy.health, player.origin, player, player, "none", "MOD_EXPLOSIVE");
            }
            continue;
        }
        guy thread namespace_49107f3a::function_ba30b321(0, player);
    }
    self delete();
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x633451a7, Offset: 0x1d48
// Size: 0x22
function function_93739933(vel) {
    return length(vel) * 0.0568182;
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x4
// Checksum 0xd176049f, Offset: 0x1d78
// Size: 0xcd
function private function_ab9cf24b(player) {
    self endon(#"death");
    if (!isdefined(level.doa) || !isdefined(level.doa.var_7817fe3c)) {
        return;
    }
    while (true) {
        foreach (hazard in level.doa.var_7817fe3c) {
            if (self istouching(hazard) && isdefined(hazard.death_func)) {
                hazard thread [[ hazard.death_func ]]();
            }
        }
        wait 0.1;
    }
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x86a8c878, Offset: 0x1e50
// Size: 0x7d
function infiniteammo() {
    self notify(#"hash_93c32bc6");
    self endon(#"hash_93c32bc6");
    self endon(#"disconnect");
    wait 1;
    while (true) {
        wait 2;
        weaponslist = self getweaponslistprimaries();
        for (idx = 0; idx < weaponslist.size; idx++) {
            self setweaponammoclip(weaponslist[idx], 666);
        }
    }
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x6106298b, Offset: 0x1ed8
// Size: 0x152
function function_1a86a494() {
    assert(isdefined(self.doa));
    if (self.doa.var_c5e98ad6 < 1) {
        self.doa.var_c5e98ad6 = 1;
    }
    if (self.doa.fate == 4) {
        if (self.doa.var_c5e98ad6 < 2) {
            self.doa.var_c5e98ad6 = 2;
        }
    } else if (self.doa.fate == 13) {
        if (self.doa.var_c5e98ad6 < 4) {
            self.doa.var_c5e98ad6 = 4;
        }
    } else if (self.doa.fate == 11) {
        if (!isdefined(self.doa.var_3df27425)) {
            self thread namespace_6df66aa5::magnet_update(10);
        }
    } else if (self.doa.fate == 10) {
        if (self.doa.bombs < 1) {
            self.doa.bombs = 1;
        }
    }
    self.health = self.maxhealth;
    self.ignoreme = 0;
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xf062b961, Offset: 0x2038
// Size: 0x89
function function_82e3b1cb() {
    players = function_5eb6e4d1();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i]) && !isalive(players[i])) {
            players[i] function_ad1d5fcb();
        }
        players[i] function_1a86a494();
    }
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xec5066f0, Offset: 0x20d0
// Size: 0x92
function function_aea40863() {
    self function_d5f89a15(self.doa.var_ca0a87c8.name);
    self disableweaponcycling();
    self allowjump(0);
    self allowcrouch(0);
    self allowprone(0);
    self allowsprint(0);
    self setstance("stand");
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x1adf586b, Offset: 0x2170
// Size: 0xa2
function function_6a52a347(count) {
    if (!isdefined(count)) {
        count = 1;
    }
    assert(isdefined(self.doa));
    max = level.doa.rules.var_fd29bc1;
    if (self.doa.fate == 11) {
        max += 1;
    }
    self.doa.lives = namespace_49107f3a::clamp(self.doa.lives + count, 0, max);
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x36664a85, Offset: 0x2220
// Size: 0xa2
function function_ba145a39(count) {
    if (!isdefined(count)) {
        count = 1;
    }
    assert(isdefined(self.doa));
    max = level.doa.rules.var_42117843;
    if (self.doa.fate == 11) {
        max += 1;
    }
    self.doa.bombs = namespace_49107f3a::clamp(self.doa.bombs + count, 0, max);
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0xdc91749a, Offset: 0x22d0
// Size: 0xa2
function function_f3748dcb(count) {
    if (!isdefined(count)) {
        count = 1;
    }
    assert(isdefined(self.doa));
    max = level.doa.rules.var_376b21db;
    if (self.doa.fate == 11) {
        max += 1;
    }
    self.doa.var_c5e98ad6 = namespace_49107f3a::clamp(self.doa.var_c5e98ad6 + count, 0, max);
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x4
// Checksum 0x26e8b5e9, Offset: 0x2380
// Size: 0xaa
function private function_3f041ff1() {
    self endon(#"disconnect");
    self util::waittill_any("new_speed_pickup", "player_died", "speed_expired");
    self thread namespace_eaa992c::turnofffx("boots");
    self.doa.fast_feet = undefined;
    self setmovespeedscale(self.doa.var_1c03b6ad);
    self thread namespace_1a381543::function_4f06fb8("zmb_pwup_speed_loop");
    self thread namespace_1a381543::function_90118d8c("zmb_pwup_speed_end");
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x1d71cb13, Offset: 0x2438
// Size: 0x127
function function_832d21c2() {
    self notify(#"new_speed_pickup");
    self endon(#"new_speed_pickup");
    self endon(#"disconnect");
    self thread function_3f041ff1();
    wait 0.05;
    self thread namespace_1a381543::function_90118d8c("zmb_pwup_speed_loop");
    self setmovespeedscale(level.doa.rules.var_b92b82b);
    self thread namespace_eaa992c::function_285a2999("boots");
    self.doa.fast_feet = 1;
    self.doa.slow_feet = undefined;
    timeleft = gettime() + self namespace_49107f3a::function_1ded48e6(level.doa.rules.var_ef812b7e) * 1000;
    while (isdefined(self.doa.fast_feet) && self.doa.fast_feet && gettime() < timeleft) {
        wait 0.05;
    }
    self notify(#"speed_expired");
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x4
// Checksum 0xc16a1851, Offset: 0x2568
// Size: 0xaa
function private function_af5211c2() {
    self endon(#"disconnect");
    self util::waittill_any("new_speed_pickup", "player_died", "speed_expired");
    self thread namespace_eaa992c::turnofffx("slow_feet");
    self.doa.slow_feet = undefined;
    self thread namespace_1a381543::function_4f06fb8("zmb_pwup_slow_speed_loop");
    self thread namespace_1a381543::function_90118d8c("zmb_pwup_slow_speed_end");
    self setmovespeedscale(self.doa.var_1c03b6ad);
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xebcbaa13, Offset: 0x2620
// Size: 0x117
function function_3840375a() {
    self notify(#"hash_c70bfe29");
    self endon(#"hash_c70bfe29");
    self endon(#"disconnect");
    self thread function_af5211c2();
    wait 0.05;
    self thread namespace_1a381543::function_90118d8c("zmb_pwup_slow_speed_loop");
    self setmovespeedscale(level.doa.rules.var_ee067ec);
    self thread namespace_eaa992c::function_285a2999("slow_feet");
    self.doa.slow_feet = 1;
    self.doa.fast_feet = undefined;
    timeleft = gettime() + level.doa.rules.var_353018d2 * 1000;
    while (isdefined(self.doa.slow_feet) && self.doa.slow_feet && gettime() < timeleft) {
        wait 0.05;
    }
    self notify(#"speed_expired");
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xf4c8f8e3, Offset: 0x2740
// Size: 0x4a
function function_d7c57981() {
    self notify(#"hash_d7c57981");
    self endon(#"hash_d7c57981");
    self waittill(#"hash_9132a424", attacker);
    self thread function_3840375a();
    self thread function_d7c57981();
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x175f4564, Offset: 0x2798
// Size: 0x6b
function function_e5fa8e6a() {
    self thread namespace_1a381543::function_90118d8c("zmb_player_poisoned");
    self.doa.var_91c268dc = 0;
    self.doa.weaponlevel = 0;
    self function_d5f89a15(self.doa.var_ca0a87c8.name);
    self notify(#"kill_shield");
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xa74e6732, Offset: 0x2810
// Size: 0x4a
function function_e6b2517f() {
    self notify(#"hash_e6b2517f");
    self endon(#"hash_e6b2517f");
    self waittill(#"poisoned", attacker);
    self thread function_e5fa8e6a();
    self thread function_e6b2517f();
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x84c9ec14, Offset: 0x2868
// Size: 0x46d
function function_ab0e2cf3() {
    self notify(#"boosterThink");
    self endon(#"boosterThink");
    self endon(#"disconnect");
    while (true) {
        wait 0.05;
        if (!isalive(self)) {
            continue;
        }
        if (isdefined(level.var_3259f885) && level.var_3259f885) {
            continue;
        }
        if (isdefined(self.doa.var_3e3bcaa1) && self.doa.var_3e3bcaa1) {
            continue;
        }
        if (!isdefined(self.doa.vehicle) && (isdefined(self.doa.var_3be905bb) && self.doa.var_3be905bb || self fragbuttonpressed())) {
            self.doa.var_3be905bb = 0;
            if (isdefined(self.doa.var_c5e98ad6) && self.doa.var_c5e98ad6 > 0) {
                self.doa.var_8a9447a5 = 0;
                self.doa.slow_feet = undefined;
                self playsound("zmb_speed_boost_activate");
                self.doa.var_c5e98ad6--;
                self thread turnplayershieldon();
                curdir = anglestoforward((0, 0, 0));
                trigger = spawn("trigger_radius", self.origin, 1, 85, 50);
                trigger.targetname = "triggerBoost1";
                trigger enablelinkto();
                trigger linkto(self, "tag_origin", curdir * -56, self.angles);
                trigger thread function_e6711e4e(self);
                trigger thread namespace_49107f3a::function_a625b5d3(self);
                trigger thread namespace_49107f3a::function_75e76155(self, "boosterThink");
                trigger thread namespace_49107f3a::function_1bd67aef(0.6);
                trigger2 = spawn("trigger_radius", self.origin, 1, 85, 50);
                trigger2.targetname = "triggerBoost2";
                trigger2 enablelinkto();
                trigger2 linkto(self, "tag_origin", curdir * 50, self.angles);
                trigger2 thread function_e6711e4e(self);
                trigger2 thread namespace_49107f3a::function_a625b5d3(self);
                trigger2 thread namespace_49107f3a::function_75e76155(self, "boosterThink");
                trigger2 thread namespace_49107f3a::function_1bd67aef(0.6);
                curdir = anglestoforward(self.angles);
                endtime = gettime() + 600;
                var_a6ae3c9c = curdir * 2000;
                var_a6ae3c9c += (0, 0, 200);
                self setvelocity(var_a6ae3c9c);
                var_a6ae3c9c -= (0, 0, 200);
                self playrumbleonentity("zombietron_booster_rumble");
                if (isdefined(self.doa.var_3caf8e2) && (self.doa.fate == 13 || self.doa.var_3caf8e2)) {
                    self thread namespace_23f188a4::function_3caf8e2(endtime);
                }
                while (gettime() < endtime) {
                    self setvelocity(var_a6ae3c9c);
                    wait 0.05;
                }
                if (self.doa.var_8a9447a5 >= 20) {
                }
                self.doa.var_8a9447a5 = undefined;
                if (isdefined(trigger)) {
                    trigger delete();
                }
                if (isdefined(trigger2)) {
                    trigger2 delete();
                }
            }
        }
    }
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x9113eba9, Offset: 0x2ce0
// Size: 0x1a
function function_7d7a7fde() {
    self clientfield::increment_to_player("controlBinding");
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x4
// Checksum 0x13a19613, Offset: 0x2d08
// Size: 0x3a
function private function_9fc6e261() {
    self waittill(#"actor_corpse", corpse);
    wait 0.05;
    if (isdefined(corpse)) {
        corpse clientfield::increment("burnCorpse");
    }
}

// Namespace namespace_831a4a7c
// Params 4, eflags: 0x4
// Checksum 0x868da01a, Offset: 0x2d50
// Size: 0x3da
function private function_d392db04(var_adc420e5, origin, player, updir) {
    self endon(#"death");
    assert(!(isdefined(self.boss) && self.boss));
    if (!isdefined(level.var_b3050900)) {
        level.var_b3050900 = -96 * -96;
        level.var_5e8840d3 = 512 * 512;
        level.var_c4dbc378 = 75;
        level.var_619a7a66 = -6;
        level.var_38e68ca7 = 1;
    }
    distsq = distancesquared(self.origin, origin);
    var_b3458cba = namespace_49107f3a::clamp(distsq / level.var_5e8840d3, 0.1, 1);
    time = namespace_49107f3a::clamp(var_adc420e5 * var_b3458cba, 0.05, var_adc420e5);
    wait time;
    if (isdefined(self.archetype) && self.archetype == "robot") {
        self namespace_fba031c8::function_7b3e39cb();
    } else {
        self thread function_9fc6e261();
        if (!(isdefined(self.var_52b0b328) && self.var_52b0b328) && isactor(self)) {
            self clientfield::increment("burnZombie");
        }
        if (isactor(self) && !(isdefined(self.var_7ebc405c) && self.var_7ebc405c) && randomint(100) < getdvarint("scr_doa_ragdoll_toss_up_chance", 25)) {
            assert(!(isdefined(self.boss) && self.boss));
            self startragdoll(1);
            dir = vectornormalize(self.origin - origin + (0, 0, 72));
            var_a9ff6845 = distsq < level.var_b3050900 ? 1 - var_b3458cba * var_b3458cba : 1 - var_b3458cba;
            var_c45ed401 = namespace_49107f3a::clamp(level.var_c4dbc378 / var_b3458cba, level.var_c4dbc378, level.var_619a7a66);
            launch = vectornormalize(updir * level.var_38e68ca7 + dir * (1 - var_a9ff6845)) * var_c45ed401;
            self launchragdoll(launch);
            self.launched = 1;
        }
    }
    if (self.archetype == "zombie") {
        roll = randomint(100);
        if (roll < 10) {
            self clientfield::set("zombie_rhino_explosion", 1);
            util::wait_network_frame();
        } else if (roll < 40) {
            self clientfield::set("zombie_gut_explosion", 1);
            util::wait_network_frame();
        } else if (roll < 70) {
            self clientfield::set("zombie_saw_explosion", 1);
            util::wait_network_frame();
        }
    }
    self dodamage(self.health + 1, origin, isdefined(player) ? player : undefined, undefined, "none", "MOD_EXPLOSIVE");
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xdab8a1f3, Offset: 0x3138
// Size: 0x75
function function_73d40751() {
    self notify(#"hash_73d40751");
    self endon(#"hash_73d40751");
    self endon(#"disconnect");
    while (true) {
        wait 0.05;
        if (self weaponswitchbuttonpressed()) {
            self clientfield::increment_to_player("changeCamera");
            while (self weaponswitchbuttonpressed()) {
                wait 0.05;
            }
        }
    }
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xeb715f02, Offset: 0x31b8
// Size: 0xad
function function_f19e9b07() {
    self notify(#"hash_f26fb3a4");
    self endon(#"hash_f26fb3a4");
    self endon(#"disconnect");
    while (true) {
        wait 0.05;
        if (!isalive(self)) {
            continue;
        }
        if (self stancebuttonpressed()) {
            if (isdefined(self.doa.vehicle)) {
                self notify(#"hash_d28ba89d");
            } else {
                self namespace_a7e6beb5::function_9615d68f();
            }
            while (self stancebuttonpressed()) {
                wait 0.05;
            }
        }
    }
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xda2cc9c5, Offset: 0x3270
// Size: 0x40d
function function_4eabae51() {
    self notify(#"hash_97fb783");
    self endon(#"hash_97fb783");
    self endon(#"disconnect");
    while (true) {
        wait 0.05;
        if (!isalive(self)) {
            continue;
        }
        if (isdefined(self.doa.var_3024fd0f) && self.doa.var_3024fd0f) {
            continue;
        }
        if (isdefined(level.var_3259f885) && level.var_3259f885) {
            continue;
        }
        if (isdefined(self.doa.var_f30b49ec) && self.doa.var_f30b49ec) {
            if (self jumpbuttonpressed()) {
                continue;
            } else {
                self.doa.var_f30b49ec = undefined;
            }
        }
        if (isdefined(self.doa.var_f2870a9e) && self.doa.var_f2870a9e || self jumpbuttonpressed()) {
            self.doa.var_f2870a9e = 0;
            self.doa.var_f30b49ec = 1;
            if (isdefined(self.doa.bombs) && self.doa.bombs > 0) {
                self.doa.bombs--;
                player_org = self.origin;
                origin = player_org + (20, 0, 800);
                self clientfield::set("bombDrop", 1);
                self thread turnplayershieldon();
                namespace_49107f3a::clearallcorpses();
                wait 0.4;
                playrumbleonposition("artillery_rumble", self.origin);
                util::wait_network_frame();
                level notify(#"hash_8817f58");
                enemies = namespace_49107f3a::function_fb2ad2fb();
                camerapos = namespace_3ca3c537::function_5147636f();
                updir = vectornormalize(camerapos - player_org);
                var_adc420e5 = 0.3;
                foreach (guy in enemies) {
                    if (isdefined(guy)) {
                        if (isdefined(guy.boss) && guy.boss) {
                            guy.nuked = gettime();
                            continue;
                        }
                        if (isvehicle(guy)) {
                            guy dodamage(guy.health + 1, player_org, self, self, "none", "MOD_EXPLOSIVE", 0, getweapon("none"));
                        }
                        guy thread function_d392db04(var_adc420e5, player_org, self, updir);
                    }
                }
                foreach (hazard in level.doa.var_7817fe3c) {
                    if (isdefined(hazard.death_func)) {
                        hazard thread [[ hazard.death_func ]]();
                    }
                }
                util::wait_network_frame();
                self clientfield::set("bombDrop", 0);
                physicsexplosionsphere(player_org, 1024, 1024, 3);
            }
        }
    }
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0xdfcd8be2, Offset: 0x3688
// Size: 0xad
function function_350f42fa(weaponpack) {
    self endon(#"disconnect");
    self notify(#"hash_42ae3dd7");
    self endon(#"hash_42ae3dd7");
    while (true) {
        self waittill(#"missile_fire", projectile, weapon);
        if (weapon == level.doa.var_e30c10ec) {
            projectile thread function_48b5439d(self);
            projectile thread function_62c5034a(self);
            continue;
        }
        if (weapon == level.doa.var_ccb54987) {
            self thread function_5e373fc6();
        }
    }
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x91fd7c1d, Offset: 0x3740
// Size: 0x145
function function_62c5034a(owner) {
    self endon(#"death");
    owner endon(#"hash_42ae3dd7");
    owner endon(#"disconnect");
    while (true) {
        self waittill(#"grenade_bounce", pos, normal, ent, surface);
        physicsexplosionsphere(pos, getdvarint("scr_doa_secondary_explo_rad", 64), getdvarint("scr_doa_secondary_explo_rad", 64), 3);
        radiusdamage(pos, getdvarint("scr_doa_secondary_explo_rad", 64), getdvarint("scr_doa_secondary_explo_dmg", 2000), getdvarint("scr_doa_secondary_explo_dmg", 2000), owner);
        playfx(level._effect["impact_raygun"], pos);
        wait getdvarfloat("scr_doa_secondary_firerate_frac", 0.65);
    }
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x10a1e14c, Offset: 0x3890
// Size: 0xa5
function function_48b5439d(owner) {
    self endon(#"death");
    owner endon(#"hash_42ae3dd7");
    owner endon(#"disconnect");
    owner.doa.var_cdd906a9 = 0;
    while (true) {
        owner waittill(#"hash_21f7a743", victim);
        time = gettime();
        if (owner.doa.var_cdd906a9 > time) {
            continue;
        }
        owner.doa.var_cdd906a9 = time;
        level thread namespace_3f3eaecb::function_395fdfb8(victim, owner);
    }
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0xb49fd8a2, Offset: 0x3940
// Size: 0x3a
function missile_logic(target) {
    self waittill(#"missile_fire", missile, weap);
    missile missile_settarget(target);
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x61f4e2ba, Offset: 0x3988
// Size: 0x28a
function function_5e373fc6() {
    if (!isdefined(self.doa.var_5af6f9a9)) {
        self.doa.var_5af6f9a9 = getweapon("zombietron_rpg_2_secondary");
    }
    enemies = namespace_49107f3a::function_fb2ad2fb();
    if (enemies.size == 0) {
        return;
    }
    var_d9574143 = arraysortclosest(enemies, self.origin, enemies.size, 0, 4096);
    var_4f33000c = [];
    foreach (guy in var_d9574143) {
        if (isdefined(guy.boss) && guy.boss) {
            continue;
        }
        if (util::within_fov(self.origin, self.angles, guy.origin, 0.8)) {
            var_4f33000c[var_4f33000c.size] = guy;
        }
        if (var_4f33000c.size >= 2) {
            break;
        }
    }
    if (var_4f33000c.size == 0) {
        return;
    }
    target1 = var_4f33000c[0];
    target2 = var_4f33000c.size > 1 ? var_4f33000c[1] : var_4f33000c[0];
    v_spawn = self gettagorigin("tag_flash");
    if (!isdefined(v_spawn)) {
        return;
    }
    v_dir = anglestoforward(self.angles);
    self.doa.var_b5d64970 = gettime() + getdvarint("scr_doa_secondary_firerate", int(getdvarfloat("scr_doa_secondary_firerate_frac", 0.65) * 1000));
    self thread missile_logic(target1);
    magicbullet(self.doa.var_5af6f9a9, v_spawn, v_spawn + 50 * v_dir, self);
    wait 0.05;
    self thread missile_logic(target2);
    magicbullet(self.doa.var_5af6f9a9, v_spawn, v_spawn + 50 * v_dir, self);
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x458e3cf0, Offset: 0x3c20
// Size: 0x14a
function function_baa7411e(weapon) {
    self takeallweapons();
    self giveweapon(weapon);
    self switchtoweaponimmediate(weapon);
    self thread turnOnFlashlight(level.doa.var_458c27d == 3);
    self.doa.var_d898dd8e = weapon;
    if (weapon.type == "gas") {
        self.doa.var_d898dd8e = level.doa.var_e6a7c945;
        return;
    }
    if (weapon.name == "zombietron_launcher") {
        self.doa.var_d898dd8e = level.doa.var_ab5c3535;
        return;
    }
    if (weapon.name == "zombietron_launcher_1") {
        self.doa.var_d898dd8e = level.doa.var_5706a235;
        return;
    }
    if (weapon.name == "zombietron_launcher_2") {
        self.doa.var_d898dd8e = level.doa.var_7d091c9e;
    }
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x4a86b928, Offset: 0x3d78
// Size: 0x332
function function_71dab8e8(amount) {
    if (!isdefined(amount)) {
        amount = 1;
    }
    if (!isdefined(self.doa.weaponpack)) {
        return;
    }
    if (isdefined(self.doa.respawning) && self.doa.respawning) {
        return;
    }
    self.doa.var_91c268dc += int(getdvarint("scr_doa_weapon_increment", 64) * amount);
    if (self.doa.var_91c268dc >= getdvarint("scr_doa_weapon_increment_range", 1024)) {
        if (self.doa.weaponlevel < 2) {
            oldlevel = self.doa.weaponlevel;
            self.doa.weaponlevel += int(self.doa.var_91c268dc / getdvarint("scr_doa_weapon_increment_range", 1024));
            if (self.doa.weaponlevel > 2) {
                self.doa.weaponlevel = 2;
            }
            self.doa.var_91c268dc -= (self.doa.weaponlevel - oldlevel) * getdvarint("scr_doa_weapon_increment_range", 1024);
            graceperiod = gettime() + 2000;
            if (isdefined(self.doa.var_c2b9d7d0) && self.doa.var_c2b9d7d0 < graceperiod) {
                self.doa.var_c2b9d7d0 = graceperiod;
            }
            self function_baa7411e(self.doa.weaponpack[self.doa.weaponlevel]);
            self playsoundtoplayer("zmb_weapon_upgraded", self);
            /#
                namespace_49107f3a::debugmsg("<dev string:x3e>" + self.name + "<dev string:x46>" + self.doa.weaponlevel + "<dev string:x61>" + self.doa.weaponpack[self.doa.weaponlevel].name);
            #/
        } else {
            self.doa.var_91c268dc = getdvarint("scr_doa_weapon_increment_range", 1024) - 1;
        }
    }
    self.doa.var_91c268dc = math::clamp(self.doa.var_91c268dc, 0, getdvarint("scr_doa_weapon_increment_range", 1024) - 1);
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x52819b3b, Offset: 0x40b8
// Size: 0x332
function updateweapon() {
    if (!isdefined(self.doa) || !isdefined(self.doa.var_a2d31b4a)) {
        return;
    }
    if (self.doa.var_ca0a87c8 == level.doa.var_69899304 && self.doa.var_a2d31b4a == self.doa.var_ca0a87c8.name) {
        self.doa.weaponlevel = 2;
        self.doa.var_91c268dc = getdvarint("scr_doa_weapon_increment_range", 1024) - 1;
        return;
    }
    if (gettime() < self.doa.var_c2b9d7d0) {
        return;
    }
    if (self.doa.var_91c268dc > 0) {
        decay = getdvarint("scr_doa_weapon_increment_decay", 1) + self.doa.var_f303ab59;
        self.doa.var_f303ab59 = 0;
        if (self isfiring()) {
            decay = int(decay * (getdvarint("scr_doa_weapon_increment_decayscale", 5) - self.doa.var_7c1bcaf3));
        }
        self.doa.var_91c268dc -= decay;
        if (self.doa.var_91c268dc < 0) {
            self.doa.var_91c268dc = 0;
        }
    } else if (self.doa.weaponlevel > 0) {
        self.doa.weaponlevel--;
        self.doa.var_91c268dc = getdvarint("scr_doa_weapon_increment_range", 1024) - 1;
        self function_baa7411e(self.doa.weaponpack[self.doa.weaponlevel]);
        self thread turnOnFlashlight(level.doa.var_458c27d == 3);
        /#
            namespace_49107f3a::debugmsg("<dev string:x3e>" + self.name + "<dev string:x68>" + self.doa.weaponlevel + "<dev string:x61>" + self.doa.weaponpack[self.doa.weaponlevel].name);
        #/
    }
    if (self.doa.var_91c268dc == 0 && self.doa.weaponlevel == 0 && self.doa.var_a2d31b4a != self.doa.var_ca0a87c8.name) {
        self function_d5f89a15(self.doa.var_ca0a87c8.name);
    }
}

// Namespace namespace_831a4a7c
// Params 2, eflags: 0x0
// Checksum 0x3a8a0994, Offset: 0x43f8
// Size: 0x382
function function_d5f89a15(name, weaponpickup) {
    if (!isdefined(weaponpickup)) {
        weaponpickup = 0;
    }
    if (!isdefined(self.doa)) {
        return;
    }
    if (isdefined(weaponpickup) && weaponpickup) {
        fill = 1;
        if (isdefined(self.doa.var_a2d31b4a) && self.doa.var_a2d31b4a == name) {
            self function_71dab8e8(getdvarint("scr_doa_weapon_increment_range", 1024) / getdvarint("scr_doa_weapon_increment", 64));
            return;
        }
    }
    if (isdefined(self.doa.var_a2d31b4a) && (!isdefined(self.doa.var_a2d31b4a) || self.doa.var_a2d31b4a != name)) {
        self.doa.weaponpack = [];
        self.doa.var_a2d31b4a = name;
        self.doa.var_91c268dc = 0;
        self.doa.weaponlevel = 0;
        self.doa.var_c2b9d7d0 = 0;
        self.doa.var_b5d64970 = 0;
        self.doa.var_f303ab59 = 0;
        self takeallweapons();
        var_5f2870f1 = getweapon(name);
        assert(isdefined(var_5f2870f1));
        var_3925f688 = getweapon(name + "_1");
        var_ab2d65c3 = getweapon(name + "_2");
        self.doa.weaponpack[0] = var_5f2870f1;
        self.doa.weaponpack[1] = var_3925f688 != level.weaponnone ? var_3925f688 : var_5f2870f1;
        self.doa.weaponpack[2] = var_3925f688 != level.weaponnone ? var_3925f688 : var_ab2d65c3 != level.weaponnone ? var_ab2d65c3 : var_5f2870f1;
        self function_baa7411e(self.doa.weaponpack[self.doa.weaponlevel]);
        self thread function_350f42fa(self.doa.var_a2d31b4a);
    } else {
        self function_baa7411e(self.doa.weaponpack[self.doa.weaponlevel]);
    }
    if (isdefined(fill) && fill) {
        self.doa.var_91c268dc = getdvarint("scr_doa_weapon_increment_range", 1024) - 1;
    }
    /#
        namespace_49107f3a::debugmsg("<dev string:x3e>" + self.name + "<dev string:x85>" + self.doa.var_a2d31b4a + "<dev string:x99>" + (isdefined(fill) && fill ? "<dev string:xa0>" : "<dev string:xa5>"));
        self thread function_1318d1e4();
    #/
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x95a344f, Offset: 0x4788
// Size: 0x4a
function function_1318d1e4() {
    self notify(#"hash_1318d1e4");
    self endon(#"hash_1318d1e4");
    self endon(#"disconnect");
    self waittill(#"weapon_fired", weapon);
    namespace_49107f3a::debugmsg("Weapon Fired " + weapon.name);
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x9043f51e, Offset: 0x47e0
// Size: 0x2a
function function_7f33210a() {
    if (!isdefined(self) || !isdefined(self.doa)) {
        return;
    }
    self.doa.lightstate = 0;
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x459e9ace, Offset: 0x4818
// Size: 0x56
function function_b5843d4f(isnight) {
    self endon(#"disconnect");
    if (!isdefined(self) || !isdefined(self.doa)) {
        return;
    }
    if (isdefined(self.doa.vehicle)) {
        return;
    }
    self.doa.lightstate = isnight ? 2 : 1;
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0xd0ed86d6, Offset: 0x4878
// Size: 0xba
function turnOnFlashlight(on) {
    if (!isdefined(on)) {
        on = 1;
    }
    if (!isdefined(self)) {
        return;
    }
    self notify(#"turnOnFlashlight");
    self endon(#"turnOnFlashlight");
    self endon(#"disconnect");
    if (!isdefined(self) || !isdefined(self.doa)) {
        return;
    }
    if (isdefined(self.doa.vehicle)) {
        return;
    }
    self util::waittill_any_timeout(0.25, "weapon_change_complete");
    if (isdefined(self) && isdefined(self.entnum)) {
        if (on) {
            self thread namespace_eaa992c::function_285a2999("player_flashlight");
            return;
        }
        self thread namespace_eaa992c::turnofffx("player_flashlight");
    }
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x1d809c, Offset: 0x4940
// Size: 0xca
function function_7e85dbee() {
    var_b427d4ac = self.doa.multiplier;
    if (self.doa.fate == 2) {
        var_b427d4ac--;
    }
    if (self.doa.fate == 11) {
        var_b427d4ac -= 2;
    }
    if (var_b427d4ac > 1) {
        var_516eed4b = namespace_49107f3a::clamp(int(randomfloatrange(0.3, 0.5) * (var_b427d4ac - 1) * 4), 3);
        level thread namespace_a7e6beb5::function_16237a19(self.origin, var_516eed4b, 10, 1, 1);
    }
}

// Namespace namespace_831a4a7c
// Params 9, eflags: 0x0
// Checksum 0xee51ab68, Offset: 0x4a18
// Size: 0x31a
function function_3682cfe4(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
    self globallogic_score::incpersstat("deaths", 1, 1, 1);
    self thread namespace_1a381543::function_90118d8c("zmb_player_death");
    self notify(#"player_died");
    self freezecontrols(1);
    self function_7f33210a();
    self setplayercollision(0);
    self thread function_7e85dbee();
    self.doa.var_91c268dc = 0;
    self.doa.weaponlevel = 0;
    self.doa.var_c2b9d7d0 = 0;
    self thread namespace_64c6b720::function_850bb47e();
    self.deaths = math::clamp(self.deaths + 1, 0, 1023);
    /#
        namespace_49107f3a::debugmsg("<dev string:xab>" + smeansofdeath + "<dev string:xbd>" + idamage);
        if (isdefined(einflictor)) {
            namespace_49107f3a::debugmsg("<dev string:xca>" + einflictor getentitynumber() + "<dev string:xe7>" + einflictor.classname + (isdefined(einflictor.targetname) ? "<dev string:xf6>" + einflictor.targetname : "<dev string:x106>"));
        }
        if (isdefined(attacker)) {
            namespace_49107f3a::debugmsg("<dev string:x107>" + attacker getentitynumber() + "<dev string:xe7>" + attacker.classname + (isdefined(attacker.targetname) ? "<dev string:xf6>" + attacker.targetname : "<dev string:x106>"));
        }
    #/
    if (self.doa.lives == 0) {
        players = function_5eb6e4d1();
        count = 0;
        for (i = 0; i < players.size; i++) {
            if (!isalive(players[i]) && players[i].doa.lives == 0) {
                count++;
            }
        }
        if (count == players.size) {
            level flag::set("doa_game_is_over");
            level notify(#"player_challenge_failure");
        } else {
            self thread function_c7471371();
        }
        return;
    }
    self thread function_161ce9cd();
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x4
// Checksum 0xf06bc300, Offset: 0x4d40
// Size: 0x39
function private function_fdf74b3() {
    self notify(#"new_ignore_attacker");
    self endon(#"new_ignore_attacker");
    self endon(#"disconnect");
    wait level.rules.ignore_enemy_timer;
    self.doa.ignoreattacker = undefined;
}

// Namespace namespace_831a4a7c
// Params 13, eflags: 0x0
// Checksum 0x80bd1b9a, Offset: 0x4d88
// Size: 0x31a
function function_bfbc53f4(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    if (isdefined(smeansofdeath) && smeansofdeath == "MOD_FALLING") {
        idamage = 0;
    }
    if (!isdefined(self.doa)) {
        idamage = 0;
    } else {
        if (isdefined(self.doa.vehicle)) {
            var_807d2344 = 0;
        }
        if (isdefined(self.doa.var_3b383993)) {
            self cleardamageindicator();
            idamage = 0;
        }
        if (isdefined(eattacker)) {
            if (eattacker == self) {
                idamage = 0;
            }
            if (isdefined(self.doa.ignoreattacker) && self.doa.ignoreattacker == eattacker) {
                idamage = 0;
            }
            if (isdefined(eattacker.owner)) {
                eattacker = eattacker.owner;
            }
            if (eattacker.team == self.team) {
                idamage = 0;
            }
            if (eattacker isragdoll()) {
                idamage = 0;
            }
            if (isdefined(eattacker.knocked_out) && eattacker.knocked_out) {
                idamage = 0;
            }
            if (isdefined(eattacker.is_zombie) && eattacker.is_zombie) {
                self.doa.ignoreattacker = eattacker;
                self thread function_fdf74b3();
            }
            if (isdefined(eattacker.meleedamage)) {
                idamage = eattacker.meleedamage;
            }
            if (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_BURNED" || !(isdefined(eattacker.boss) && eattacker.boss) && smeansofdeath == "MOD_EXPLOSIVE") {
                self cleardamageindicator();
                idamage = 0;
            }
            if (isdefined(eattacker.custom_damage_func)) {
                idamage = eattacker [[ eattacker.custom_damage_func ]]();
            }
            if (isdefined(eattacker.boss) && eattacker.boss) {
                eattacker.damagedplayer = gettime();
            }
            if (isdefined(eattacker.var_65e0af26) && eattacker.var_65e0af26) {
                self notify(#"hash_9132a424", eattacker);
            }
            if (isdefined(eattacker.var_dcdf7239) && eattacker.var_dcdf7239) {
                self notify(#"poisoned", eattacker);
            }
        }
    }
    self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

// Namespace namespace_831a4a7c
// Params 13, eflags: 0x0
// Checksum 0xd2eb1eca, Offset: 0x50b0
// Size: 0x92
function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
    self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

// Namespace namespace_831a4a7c
// Params 9, eflags: 0x0
// Checksum 0x2958d696, Offset: 0x5150
// Size: 0x4a
function playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    
}

// Namespace namespace_831a4a7c
// Params 9, eflags: 0x0
// Checksum 0x7049199e, Offset: 0x51a8
// Size: 0x4a
function function_f847ee8c(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x4512328, Offset: 0x5200
// Size: 0x7c
function function_68ece679(entnum) {
    points = level.doa.arenas[level.doa.var_90873830].var_b1370bf0;
    assert(points.size);
    if (isdefined(entnum) && isdefined(points[entnum])) {
        return points[entnum];
    }
    return points[randomint(points.size)];
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x4
// Checksum 0x6ffe7a67, Offset: 0x5288
// Size: 0xba
function private function_161ce9cd(delay) {
    if (!isdefined(delay)) {
        delay = 2;
    }
    self endon(#"disconnect");
    wait delay;
    if (self.doa.lives < 1) {
        return;
    }
    if (level flag::get("doa_game_is_over")) {
        return;
    }
    self.doa.lives = namespace_49107f3a::clamp(self.doa.lives - 1, 0, level.doa.rules.var_fd29bc1);
    self notify(#"playerLifeRespawn");
    self function_ad1d5fcb();
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x4
// Checksum 0x6144ea9b, Offset: 0x5350
// Size: 0x28b
function private function_ad1d5fcb(var_243f32c0) {
    if (!isdefined(var_243f32c0)) {
        var_243f32c0 = 0;
    }
    self endon(#"disconnect");
    if (!isdefined(self)) {
        return;
    }
    assert(isdefined(self.doa));
    self.doa.respawning = 0;
    self.var_9ea856f6 = 0;
    self.doa.var_f4a883ed = undefined;
    self disableinvulnerability();
    self show();
    if (!var_243f32c0 && isdefined(self.doa.var_bac6a79)) {
        switch (self.doa.var_bac6a79) {
        case "spawn_at_start":
            spot = function_68ece679(self.entnum).origin;
            break;
        case "spawn_at_safe":
            spot = namespace_49107f3a::function_5ee38fe3(self.origin, level.doa.arenas[level.doa.var_90873830].var_1d2ed40).origin;
            break;
        default:
            spot = function_68ece679(self.entnum).origin;
            break;
        }
        self.doa.var_bac6a79 = undefined;
    }
    self reviveplayer();
    if (!isdefined(spot)) {
        spot = self.origin;
    }
    self setorigin(spot);
    if (!var_243f32c0) {
        self playsound("zmb_player_respawn");
        self thread namespace_eaa992c::function_285a2999("player_respawn_" + function_ee495f41(self.entnum));
        self thread turnplayershieldon(0);
        self thread turnOnFlashlight(level.doa.var_458c27d == 3);
    }
    self thread function_b5843d4f(level.doa.var_458c27d == 3);
    wait 0.05;
    self thread function_bbb1254c(var_243f32c0);
    self setplayercollision(1);
    self freezecontrols(0);
    self notify(#"player_respawned");
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x4
// Checksum 0x1ba75602, Offset: 0x55e8
// Size: 0xa5
function private function_bbdc9bc0() {
    self endon(#"disconnect");
    self endon(#"player_respawned");
    level endon(#"doa_game_is_over");
    while (!level flag::get("doa_game_is_over")) {
        if (self.doa.lives > 0) {
            self function_161ce9cd(isdefined(self.doa.var_ec2548a9) && self.doa.var_ec2548a9 ? 0 : 2);
            return;
        }
        wait 0.2;
    }
    self.doa.respawning = undefined;
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x76dd5a18, Offset: 0x5698
// Size: 0x182
function function_27202201() {
    self endon(#"disconnect");
    level endon(#"doa_game_is_over");
    self endon(#"player_respawned");
    self.doa.respawning = 1;
    self.var_9ea856f6 = level.doa.rules.var_575e919f;
    while (!isalive(self) && self.var_9ea856f6 > 0) {
        wait 1;
        self.var_9ea856f6 = self.var_9ea856f6 - 1;
        players = function_5eb6e4d1();
        count = 0;
        for (i = 0; i < players.size; i++) {
            if (!isalive(players[i]) && players[i].doa.lives == 0) {
                count++;
            }
        }
        if (count == players.size) {
            level flag::set("doa_game_is_over");
            level notify(#"player_challenge_failure");
            self.doa.respawning = 0;
            self.var_9ea856f6 = 0;
            return;
        }
    }
    if (!isalive(self)) {
        self.doa.respawning = 0;
        self.var_9ea856f6 = 0;
        self function_ad1d5fcb();
    }
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xe3bccc1f, Offset: 0x5828
// Size: 0x129
function function_c7471371() {
    self endon(#"disconnect");
    level endon(#"doa_game_is_over");
    self thread function_bbdc9bc0();
    self thread function_27202201();
    while (self.lives == 0 && !level flag::get("doa_game_is_over")) {
        players = function_5eb6e4d1();
        var_85a0b236 = undefined;
        var_594d20a9 = 0;
        foreach (player in players) {
            if (player == self) {
                continue;
            }
            if (player.doa.lives > var_594d20a9) {
                var_594d20a9 = player.doa.lives;
                var_85a0b236 = player;
            }
        }
        if (isdefined(var_85a0b236)) {
            level thread _stealLifeFrom(var_85a0b236, self);
            return;
        }
        wait 1;
    }
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x4
// Checksum 0xb66ea44f, Offset: 0x5960
// Size: 0x51
function private function_79489c4c(time) {
    self endon(#"disconnect");
    level endon(#"doa_game_is_over");
    self notify(#"hash_79489c4c");
    self endon(#"hash_79489c4c");
    self.doa.var_c5fe2763 = 1;
    wait time;
    self.doa.var_c5fe2763 = undefined;
}

// Namespace namespace_831a4a7c
// Params 3, eflags: 0x4
// Checksum 0xe3ae1e8c, Offset: 0x59c0
// Size: 0x189
function private _lifeLink(source, dest, orb) {
    self endon(#"disconnect");
    dest endon(#"disconnect");
    level endon(#"doa_game_is_over");
    if (!isdefined(orb)) {
        orb = spawn("script_model", self.origin + (0, 0, 50));
        orb.targetname = "_lifeLink";
        orb setmodel("tag_origin");
    }
    orb thread namespace_eaa992c::function_285a2999("trail_fast");
    orb thread namespace_49107f3a::function_75e76155(source, "disconnect");
    orb thread namespace_49107f3a::function_75e76155(dest, "disconnect");
    orb thread namespace_49107f3a::function_75e76155(source, "end_life_link");
    orb thread namespace_49107f3a::function_783519c1("doa_game_is_over", 1);
    orb thread namespace_49107f3a::function_1bd67aef(4);
    end = dest.origin + (0, 0, 50);
    while (isdefined(orb)) {
        orb moveto(end, 0.2, 0, 0);
        wait 0.5;
        if (isdefined(orb)) {
            orb.origin = self.origin + (0, 0, 50);
        }
    }
}

// Namespace namespace_831a4a7c
// Params 2, eflags: 0x4
// Checksum 0x20d1b099, Offset: 0x5b58
// Size: 0x73a
function private _stealLifeFrom(source, dest) {
    self endon(#"disconnect");
    level endon(#"doa_game_is_over");
    if (dest.doa.lives > 0) {
        return;
    }
    if (!isdefined(source) || source.doa.lives < 1) {
        return;
    }
    if (isdefined(source.doa.var_c5fe2763) && source.doa.var_c5fe2763) {
        return;
    }
    if (isdefined(dest.doa.var_c5fe2763) && dest.doa.var_c5fe2763) {
        return;
    }
    source thread function_79489c4c(10);
    source thread _lifeLink(source, dest);
    dest thread function_79489c4c(level.doa.rules.var_378eec79 + 5);
    wait 1;
    origin = source.origin;
    pickup = spawn("script_model", origin);
    pickup.targetname = "_stealLifeFrom";
    pickup.angles = source.angles;
    pickup setmodel(level.doa.var_890f74c0);
    pickup thread namespace_eaa992c::function_285a2999("glow_white");
    source thread turnplayershieldon(1);
    pickup thread namespace_49107f3a::function_75e76155(source, "disconnect");
    pickup thread namespace_49107f3a::function_75e76155(dest, "disconnect");
    pickup moveto(dest.origin, 1, 0, 0);
    pickup thread namespace_1a381543::function_90118d8c("zmb_pickup_life_shimmer");
    pickup thread namespace_49107f3a::function_1bd67aef(3);
    pickup util::waittill_any_timeout(2, "movedone");
    source notify(#"end_life_link");
    pickup delete();
    if (dest.doa.lives > 0) {
        return;
    }
    dest.doa.lives++;
    dest.doa.var_ec2548a9 = 1;
    source.doa.lives--;
    if (source.doa.lives < 0) {
        source.doa.lives = 0;
    }
    if (isdefined(source.doa.vehicle)) {
        if (math::cointoss()) {
            namespace_49107f3a::debugmsg("Life reward BOOSTERS to: " + source.name);
            level thread namespace_a7e6beb5::function_ab651d00(source, level.doa.var_37366651, 4);
            return;
        }
        namespace_49107f3a::debugmsg("Life reward NUKES to: " + source.name);
        level thread namespace_a7e6beb5::function_ab651d00(source, level.doa.var_501f85b4, 3);
        return;
    }
    roll = randomint(100);
    if (roll < 80) {
        roll = randomint(100);
        if (roll < 20) {
            namespace_49107f3a::debugmsg("Life reward BLADES to: " + source.name);
            level thread namespace_a7e6beb5::function_ab651d00(source, level.doa.var_97bbae9c);
            wait 0.1;
            level thread namespace_a7e6beb5::function_ab651d00(source, level.doa.var_37366651);
            wait 0.1;
            level thread namespace_a7e6beb5::function_ab651d00(source, level.doa.var_97bbae9c);
            wait 0.1;
            level thread namespace_a7e6beb5::function_ab651d00(source, level.doa.var_501f85b4);
        } else if (roll < 50) {
            namespace_49107f3a::debugmsg("Life reward BOOSTERS to: " + source.name);
            level thread namespace_a7e6beb5::function_ab651d00(source, level.doa.var_37366651, 4);
        } else if (roll < 70) {
            namespace_49107f3a::debugmsg("Life reward NUKES to: " + source.name);
            level thread namespace_a7e6beb5::function_ab651d00(source, level.doa.var_501f85b4, 3);
        } else {
            namespace_49107f3a::debugmsg("Life reward CHICKENS to: " + source.name);
            level thread namespace_a7e6beb5::function_ab651d00(source, level.doa.var_8d63e734, 3);
        }
        return;
    }
    roll = randomint(100);
    if (roll < 40 && gettime() > level.doa.var_d2b5415f) {
        level.doa.var_d2b5415f = gettime() + 60000;
        namespace_49107f3a::debugmsg("Life reward SkelArmy to: " + source.name);
        source thread namespace_1a381543::function_90118d8c("zmb_army_skeleton");
        for (i = 0; i < 10; i++) {
            spot = source namespace_49107f3a::function_37548bf4();
            level thread namespace_a7e6beb5::function_411355c0(30, source, spot);
            wait 0.5;
        }
        return;
    }
    if (roll < 70 && gettime() > level.doa.var_d2b5415f) {
        level.doa.var_d2b5415f = gettime() + 60000;
        namespace_49107f3a::debugmsg("Life reward RoboArmy to: " + source.name);
        source thread namespace_1a381543::function_90118d8c("zmb_army_robot");
        for (i = 0; i < 4; i++) {
            spot = source namespace_49107f3a::function_37548bf4();
            level thread namespace_a7e6beb5::function_411355c0(31, source, spot);
            wait 0.5;
        }
        return;
    }
    namespace_49107f3a::debugmsg("Life reward HELO to: " + source.name);
    level thread namespace_a7e6beb5::function_ab651d00(source, level.doa.var_3b704a85);
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0x678a3c45, Offset: 0x62a0
// Size: 0x123
function function_60123d1c() {
    self notify(#"hash_cca1b1b9");
    self notify(#"hash_50d14846");
    self notify(#"hash_905a46e");
    self notify(#"noHealthOverlay");
    self notify(#"killspawnmonitor");
    self notify(#"killmonitorreloads");
    self notify(#"hash_43360787");
    self notify(#"killspawnmonitor");
    self notify(#"hash_e9460c7d");
    self notify(#"hash_84984c12");
    self notify(#"hash_7b1c9d84");
    self notify(#"killhackermonitor");
    self notify(#"hash_23671b0c");
    self notify(#"track_riot_shield");
    self notify(#"killdtpmonitor");
    self notify(#"hash_ae13f274");
    self notify(#"hash_15683a6d");
    self notify(#"hash_a9de32eb");
    self notify(#"killplayersprintmonitor");
    self notify(#"killempmonitor");
    self notify(#"hash_7fac4805");
    self notify(#"watch_remove_influencer");
    self notify(#"hash_3b109bff");
    self notify(#"killmantlemonitor");
    self notify(#"hash_310aee47");
    self notify(#"bolttrackingstart");
    self notify(#"hash_a852d5c9");
    self notify(#"hash_916b3972");
    self notify(#"hash_854e75e1");
    self notify(#"hash_35275331");
    self notify(#"grenadetrackingstart");
    self notify(#"hash_5c6cd2a");
    self notify(#"killonpainmonitor");
    self notify(#"hash_7156ad3a");
    self notify(#"end_healthregen");
    level notify(#"stop_spawn_weight_debug");
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x5f4a99df, Offset: 0x63d0
// Size: 0x69
function function_fea7ed75(num) {
    if (!isdefined(num)) {
        return (1, 1, 1);
    }
    switch (num) {
    case 0:
        return (0, 1, 0);
    case 1:
        return (0, 0, 1);
    case 2:
        return (1, 0, 0);
    case 3:
        return (1, 1, 0);
    default:
        assert(0);
        break;
    }
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x3cc07999, Offset: 0x6448
// Size: 0x22
function function_e7e0aa7f(num) {
    return "glow_" + function_ee495f41(num);
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0xc6cf21a7, Offset: 0x6478
// Size: 0x71
function function_ee495f41(num) {
    switch (num) {
    case 0:
        return "green";
    case 1:
        return "blue";
    case 2:
        return "red";
    case 3:
        return "yellow";
    default:
        assert(0);
        break;
    }
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xb3e245, Offset: 0x64f8
// Size: 0x85
function function_5eb6e4d1() {
    players = [];
    foreach (player in getplayers()) {
        if (!isdefined(player)) {
            continue;
        }
        if (isdefined(player.doa)) {
            players[players.size] = player;
        }
    }
    return players;
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0xd0b8e980, Offset: 0x6588
// Size: 0x121
function function_35f36dec(origin) {
    players = function_5eb6e4d1();
    if (players.size == 0) {
        return undefined;
    }
    if (players.size == 1) {
        return players[0];
    }
    bestent = players[0];
    var_37ddc7cf = 8192 * 8192;
    foreach (player in players) {
        if (!isdefined(player) || !isalive(player)) {
            continue;
        }
        if (isdefined(player.ignoreme) && player.ignoreme) {
            continue;
        }
        distsq = distancesquared(player.origin, origin);
        if (distsq < var_37ddc7cf) {
            bestent = player;
            var_37ddc7cf = distsq;
        }
    }
    return bestent;
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xae611bdc, Offset: 0x66b8
// Size: 0x75
function function_f300c612() {
    self endon(#"disconnect");
    self notify(#"hash_f300c612");
    self endon(#"hash_f300c612");
    while (true) {
        wait 0.05;
        if (isdefined(self.doa.var_f4a883ed) && self.doa.var_f4a883ed) {
            namespace_2f63e553::drawcylinder(self.origin, 50, 50, 1, (1, 0, 0));
        }
    }
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x68f6c9b1, Offset: 0x6738
// Size: 0x132
function function_4519b17(on) {
    if (!isdefined(self) || !isdefined(self.doa)) {
        return;
    }
    if (isdefined(level.doa.var_e5a69065) && level.doa.var_e5a69065) {
        self thread function_f300c612();
    }
    if (on) {
        if (!isdefined(self.doa.var_f4a883ed)) {
            self.doa.var_f4a883ed = 1;
            self enableinvulnerability();
        } else {
            assert(self.doa.var_f4a883ed > 0);
            self.doa.var_f4a883ed++;
        }
        return;
    }
    if (isdefined(self.doa.var_f4a883ed)) {
        self.doa.var_f4a883ed--;
    }
    if (!isdefined(self.doa.var_f4a883ed) || self.doa.var_f4a883ed == 0) {
        self.doa.var_f4a883ed = undefined;
        self disableinvulnerability();
    }
}

// Namespace namespace_831a4a7c
// Params 1, eflags: 0x0
// Checksum 0x169de1eb, Offset: 0x6878
// Size: 0x38d
function function_139199e1(type) {
    while (!level flag::get("doa_round_active")) {
        wait 0.05;
    }
    if (!isdefined(type)) {
        if (randomint(100) > 50) {
            type = "fury";
        } else {
            type = "force";
        }
    }
    if (self.doa.fate == 10 && type == "fury") {
        type = "force";
    }
    if (self.doa.fate == 13 && type == "force") {
        type = "fury";
    }
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_CHALLENGE_VICTOR);
    wait 3;
    level.doa.var_9b77ca48 = 1;
    switch (type) {
    case "fury":
        level thread namespace_49107f3a::function_37fb5c23(%DOA_REWARD_FURY);
        var_213a57a7 = self.doa.var_ca0a87c8;
        wait 2;
        level thread namespace_23f188a4::directedFate(self, "zombietron_statue_fury", 0.5, &donothing);
        self.doa.var_ca0a87c8 = level.doa.var_69899304;
        self function_d5f89a15(self.doa.var_ca0a87c8.name);
        while (level flag::get("doa_round_active")) {
            wait 0.05;
        }
        self.doa.var_ca0a87c8 = var_213a57a7;
        self function_d5f89a15(self.doa.var_ca0a87c8.name);
        break;
    case "force":
        level thread namespace_49107f3a::function_37fb5c23(%DOA_REWARD_FORCE);
        wait 1;
        level thread namespace_a7e6beb5::function_ab651d00(self, level.doa.var_37366651, 6);
        wait 1;
        level thread namespace_23f188a4::directedFate(self, "zombietron_statue_force", 0.5, &donothing);
        self.doa.var_3caf8e2 = 1;
        defaultspeed = self.doa.var_1c03b6ad;
        self.doa.var_1c03b6ad = level.doa.rules.var_b92b82b;
        self setmovespeedscale(self.doa.var_1c03b6ad);
        while (level flag::get("doa_round_active")) {
            wait 0.05;
        }
        self.doa.var_3caf8e2 = undefined;
        self.doa.var_1c03b6ad = defaultspeed;
        self setmovespeedscale(self.doa.var_1c03b6ad);
        break;
    }
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_REWARD_EXPIRE);
    wait 2;
    level thread namespace_49107f3a::function_37fb5c23(%DOA_REWARD_EXPIRE2);
    wait 5;
    level.doa.var_9b77ca48 = undefined;
}

// Namespace namespace_831a4a7c
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x6c10
// Size: 0x2
function donothing() {
    
}

