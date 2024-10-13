#using scripts/zm/zm_temple_pack_a_punch;
#using scripts/zm/zm_temple;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace zm_temple_elevators;

// Namespace zm_temple_elevators
// Params 0, eflags: 0x1 linked
// Checksum 0x55a9ecba, Offset: 0x438
// Size: 0x34
function init_elevator() {
    level flag::wait_till("initial_players_connected");
    function_c9f11049();
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x1 linked
// Checksum 0x9a7d2048, Offset: 0x478
// Size: 0x4be
function function_c9f11049() {
    level.var_2567a173 = getentarray("temple_geyser", "targetname");
    for (i = 0; i < level.var_2567a173.size; i++) {
        level.var_2567a173[i].enabled = 0;
        level.var_2567a173[i].line_emitter = i;
        var_5d5ddc2c = level.var_2567a173[i];
        parms = strtok(var_5d5ddc2c.script_parameters, ",");
        var_5d5ddc2c.var_95b4324 = float(parms[0]);
        var_5d5ddc2c.var_2f5dbd8d = float(parms[1]);
        var_5d5ddc2c.var_556037f6 = float(parms[2]);
        var_5d5ddc2c.var_ae66a707 = float(parms[3]);
        var_5d5ddc2c.var_91311a06 = getent(var_5d5ddc2c.target, "targetname");
        var_5d5ddc2c.bottom = struct::get(var_5d5ddc2c.target, "targetname");
        if (!isdefined(var_5d5ddc2c.bottom.angles)) {
            var_5d5ddc2c.bottom.angles = (0, 0, 0);
        }
        var_5d5ddc2c.top = struct::get(var_5d5ddc2c.bottom.target, "targetname");
        if (!isdefined(var_5d5ddc2c.top.angles)) {
            var_5d5ddc2c.top.angles = (0, 0, 0);
        }
        var_5d5ddc2c.var_82af2e7e = getent("trigger_" + var_5d5ddc2c.script_noteworthy + "_dust", "targetname");
        if (isdefined(var_5d5ddc2c.var_82af2e7e)) {
            var_5d5ddc2c.var_82af2e7e thread function_9af7029();
        }
        if (isdefined(var_5d5ddc2c.script_noteworthy)) {
            level flag::init(var_5d5ddc2c.script_noteworthy + "_active");
            blocker = getent(var_5d5ddc2c.script_noteworthy + "_blocker", "targetname");
            if (isdefined(blocker)) {
                var_5d5ddc2c thread function_270ec846(blocker);
            }
            var_5d5ddc2c.var_aa1716ad = getnode(var_5d5ddc2c.script_noteworthy + "_jump_down", "targetname");
            if (isdefined(var_5d5ddc2c.var_aa1716ad)) {
                setenablenode(var_5d5ddc2c.var_aa1716ad, 0);
                var_5d5ddc2c.var_a2dea53e = getnode(var_5d5ddc2c.var_aa1716ad.target, "targetname");
            }
            var_5d5ddc2c.var_5a14c16 = getnode(var_5d5ddc2c.script_noteworthy + "_jump_up", "targetname");
            if (isdefined(var_5d5ddc2c.var_5a14c16)) {
                setenablenode(var_5d5ddc2c.var_5a14c16, 0);
            }
        }
    }
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x0
// Checksum 0x8ca64c25, Offset: 0x940
// Size: 0x12c
function function_42e422b0() {
    var_45db17d = undefined;
    level waittill(#"hash_3caae66a");
    while (true) {
        var_2567a173 = [];
        for (i = 0; i < level.var_2567a173.size; i++) {
            g = level.var_2567a173[i];
            if ((!isdefined(var_45db17d) || g != var_45db17d) && g.enabled) {
                var_2567a173[var_2567a173.size] = g;
            }
        }
        if (isdefined(var_45db17d)) {
            var_45db17d notify(#"hash_6626f64e");
            var_45db17d = undefined;
        }
        if (var_2567a173.size > 0) {
            var_45db17d = array::random(var_2567a173);
            var_45db17d thread function_ba4b707d();
        }
        level waittill(#"between_round_over");
    }
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x1 linked
// Checksum 0xc1ac263a, Offset: 0xa78
// Size: 0xe4
function function_ba4b707d() {
    self.geyser_active = 0;
    var_f3e27be7 = getnode(self.script_noteworthy + "_jump_up", "targetname");
    if (isdefined(var_f3e27be7)) {
        setenablenode(var_f3e27be7, 1);
    }
    var_2ba76614 = getnode(self.script_noteworthy + "_jump_down", "targetname");
    if (isdefined(var_2ba76614)) {
        setenablenode(var_2ba76614, 1);
    }
    self thread function_6c76a328();
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x0
// Checksum 0x99fc5013, Offset: 0xb68
// Size: 0x70
function function_a00ab344() {
    self endon(#"hash_6626f64e");
    while (true) {
        who = self waittill(#"trigger");
        if (!self.geyser_active) {
            continue;
        }
        if (isai(who)) {
            who function_b3bdd182();
        }
    }
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x1 linked
// Checksum 0xdcc63d98, Offset: 0xbe0
// Size: 0x228
function function_6c76a328() {
    self endon(#"hash_6626f64e");
    level endon(#"intermission");
    level endon(#"fake_death");
    while (true) {
        who = self waittill(#"trigger");
        if (!isplayer(who)) {
            continue;
        }
        if (who.sessionstate == "spectator") {
            continue;
        }
        if (!self.geyser_active) {
            if (who.origin[2] - self.bottom.origin[2] > 70) {
                continue;
            }
        }
        if (self.geyser_active) {
            who thread function_e7c975f0(self);
            continue;
        }
        self playsound("evt_geyser_buildup");
        starttime = gettime();
        players = getplayers();
        while (true) {
            var_e187d686 = [];
            for (i = 0; i < players.size; i++) {
                if (players[i] istouching(self)) {
                    var_e187d686[var_e187d686.size] = players[i];
                }
            }
            if (var_e187d686.size == 0) {
                break;
            }
            earthquake(0.2, 0.1, self.bottom.origin, 100);
            if (gettime() - starttime > 1800) {
                self thread function_c74ccd80(var_e187d686);
                break;
            }
            wait 0.1;
        }
    }
}

// Namespace zm_temple_elevators
// Params 1, eflags: 0x1 linked
// Checksum 0x7a11dfc8, Offset: 0xe10
// Size: 0x2a
function function_c74ccd80(var_e187d686) {
    self function_deb57ec7(var_e187d686);
    wait 5;
}

// Namespace zm_temple_elevators
// Params 1, eflags: 0x1 linked
// Checksum 0x39207fb6, Offset: 0xe48
// Size: 0x1e0
function function_deb57ec7(var_e187d686) {
    self.geyser_active = 1;
    if (isdefined(self.var_82af2e7e)) {
        self.var_82af2e7e thread function_502566d8();
    }
    self thread function_a3f470f9();
    if (isdefined(self.line_emitter)) {
        util::clientnotify("ge" + self.line_emitter);
    }
    for (i = 0; i < var_e187d686.size; i++) {
        var_e187d686[i] thread function_e7c975f0(self);
        var_e187d686[i] thread zm_audio::create_and_play_dialog("general", "geyser");
    }
    if (isdefined(self.var_aa1716ad) && isdefined(self.var_a2dea53e)) {
        unlinknodes(self.var_aa1716ad, self.var_a2dea53e);
    }
    level flag::set(self.script_noteworthy + "_active");
    wait 10;
    self notify(#"hash_e1be7112");
    level flag::clear(self.script_noteworthy + "_active");
    if (isdefined(self.var_aa1716ad) && isdefined(self.var_a2dea53e)) {
        linknodes(self.var_aa1716ad, self.var_a2dea53e);
    }
    self.geyser_active = 0;
}

// Namespace zm_temple_elevators
// Params 1, eflags: 0x1 linked
// Checksum 0x6f61622b, Offset: 0x1030
// Size: 0x428
function function_e7c975f0(geyser) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"spawned_spectator");
    if (isdefined(self.intermission) && (isdefined(self.var_8b90a9e4) && self.var_8b90a9e4 || self.intermission)) {
        return;
    }
    self.var_8b90a9e4 = 1;
    if (self laststand::player_is_in_laststand()) {
        self.var_640ad2c0 = "geyserfakeprone";
    } else if (self getstance() == "prone") {
        self clientfield::set("geyserfakeprone", 1);
        self.var_640ad2c0 = "geyserfakeprone";
    } else {
        self clientfield::set("geyserfakestand", 1);
        self.var_640ad2c0 = "geyserfakestand";
    }
    if (!self laststand::player_is_in_laststand()) {
        self ghost();
    }
    self.var_d4800095 = gettime() + 2000;
    scale = (geyser.top.origin[2] - self.origin[2]) / (geyser.top.origin[2] - geyser.bottom.origin[2]);
    scale = math::clamp(scale, 0.4, 1);
    mover = spawn("script_origin", self.origin);
    self playerlinkto(mover);
    x = geyser.var_95b4324;
    y = geyser.var_2f5dbd8d;
    z = geyser.var_556037f6 * scale;
    time = geyser.var_ae66a707 * scale;
    mover movegravity((x, y, z), time);
    self function_26a12238(time);
    vel = self getvelocity();
    if (isdefined(self)) {
        self clientfield::set(self.var_640ad2c0, 0);
        util::wait_network_frame();
        self show();
    }
    self unlink();
    mover delete();
    if (y > 0) {
        self setvelocity(vel + (0, 175, 0));
    } else {
        self setvelocity(vel + (0, -175, 0));
    }
    wait 0.1;
    self.var_8b90a9e4 = 0;
}

// Namespace zm_temple_elevators
// Params 1, eflags: 0x1 linked
// Checksum 0x5d188c1f, Offset: 0x1460
// Size: 0x28
function function_26a12238(waittime) {
    self endon(#"death");
    self endon(#"player_downed");
    wait waittime;
}

// Namespace zm_temple_elevators
// Params 1, eflags: 0x0
// Checksum 0x4a973dd5, Offset: 0x1490
// Size: 0x2d0
function function_a0b13de9(var_e187d686) {
    self.geyser_active = 1;
    self thread function_a3f470f9();
    var_974df0d6 = 0.5;
    var_5d5a0d45 = 0.1;
    movedist = 500;
    var_91311a06 = getent("geyser_lift", "targetname");
    wait 0.1;
    start_origin = self.var_91311a06.origin;
    start_angles = self.var_91311a06.angles;
    for (i = 0; i < var_e187d686.size; i++) {
        var_e187d686[i] setplayerangles(self.bottom.angles);
    }
    self.var_91311a06 movez(movedist, var_974df0d6, 0.1, 0.3);
    wait var_974df0d6;
    var_a366f1c2 = 0.3;
    var_33ed5d15 = 20;
    for (i = 0; i < 2; i++) {
        self.var_91311a06 movez(var_33ed5d15, var_a366f1c2, var_a366f1c2 / 2, var_a366f1c2 / 2);
        wait var_a366f1c2;
        self.var_91311a06 movez(-1 * var_33ed5d15, var_a366f1c2, var_a366f1c2 / 2, var_a366f1c2 / 2);
        wait var_a366f1c2;
    }
    self.var_91311a06 movez(-250, 3, 0.2, 0.2);
    wait 3;
    self.var_91311a06 notsolid();
    self.var_91311a06.angles = start_angles;
    self.var_91311a06.origin = start_origin;
    wait 0.1;
    self.var_91311a06 solid();
    wait 5;
    self notify(#"hash_e1be7112");
    self.geyser_active = 0;
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x1 linked
// Checksum 0xcd5d42ae, Offset: 0x1768
// Size: 0x9c
function function_a3f470f9() {
    self thread function_9b780f50();
    fxobj = spawnfx(level._effect["fx_ztem_geyser"], self.bottom.origin);
    triggerfx(fxobj);
    self waittill(#"hash_e1be7112");
    wait 5;
    fxobj delete();
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x1 linked
// Checksum 0x9ca8988c, Offset: 0x1810
// Size: 0x50
function function_9b780f50() {
    self endon(#"hash_e1be7112");
    while (true) {
        earthquake(0.2, 0.1, self.origin, 100);
        wait 0.1;
    }
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x1 linked
// Checksum 0x96b2c951, Offset: 0x1868
// Size: 0x74
function function_b3bdd182() {
    self startragdoll();
    self launchragdoll((0, 0, 1) * 300);
    util::wait_network_frame();
    self dodamage(self.health + 666, self.origin);
}

// Namespace zm_temple_elevators
// Params 1, eflags: 0x1 linked
// Checksum 0xccf0fc9e, Offset: 0x18e8
// Size: 0x1b6
function function_270ec846(blocker) {
    switch (self.script_noteworthy) {
    case "start_geyser":
        level flag::wait_till_any(array("cave02_to_cave_water", "cave_water_to_power", "cave_water_to_waterfall"));
        exploder::exploder("fxexp_8");
        function_17e2e86f("geyser02", "evt_water_spout02", "evt_geyser_amb", 1);
        break;
    case "minecart_geyser":
        level flag::wait_till_any(array("start_to_pressure", "pressure_to_cave01"));
        level flag::wait_till_any(array("cave01_to_cave02", "pressure_to_cave01"));
        exploder::exploder("fxexp_9");
        function_17e2e86f("geyser01", "evt_water_spout01", "evt_geyser_amb", 1);
    default:
        break;
    }
    blocker thread function_296497e();
    self thread function_ba4b707d();
    self.enabled = 1;
    level notify(#"hash_3caae66a", self);
}

// Namespace zm_temple_elevators
// Params 4, eflags: 0x1 linked
// Checksum 0xbdab0b65, Offset: 0x1aa8
// Size: 0x10c
function function_17e2e86f(var_426bda58, var_ce7a643f, var_6be6bdbf, var_51e9a553) {
    var_36e9b7f6 = struct::get(var_426bda58, "targetname");
    if (isdefined(var_36e9b7f6)) {
        level thread sound::play_in_space(var_ce7a643f, var_36e9b7f6.origin);
        if (isdefined(var_51e9a553) && var_51e9a553 > 0) {
            wait var_51e9a553;
        }
        var_bb240ded = spawn("script_origin", (0, 0, 1));
        if (isdefined(var_bb240ded)) {
            var_bb240ded.origin = var_36e9b7f6.origin;
            var_bb240ded playloopsound(var_6be6bdbf);
        }
    }
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x1 linked
// Checksum 0x2e58c912, Offset: 0x1bc0
// Size: 0x10c
function function_296497e() {
    clip = getent(self.target, "targetname");
    clip notsolid();
    clip connectpaths();
    struct = spawnstruct();
    struct.origin = self.origin + (0, 0, 500);
    struct.angles = self.angles + (0, 180, 0);
    self.script_noteworthy = "jiggle";
    self.script_firefx = "poltergeist";
    self.script_fxid = "large_ceiling_dust";
    self zm_blockers::debris_move(struct);
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x1 linked
// Checksum 0x8f9732da, Offset: 0x1cd8
// Size: 0x3c
function function_502566d8() {
    self triggerenable(1);
    wait 3;
    self triggerenable(0);
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x1 linked
// Checksum 0xf16e40da, Offset: 0x1d20
// Size: 0xc0
function function_9af7029() {
    while (true) {
        player = self waittill(#"trigger");
        if (isdefined(player) && isdefined(player.var_d4800095) && player.var_d4800095 > gettime()) {
            playfx(level._effect["player_land_dust"], player.origin);
            player playsound("fly_bodyfall_large_dirt");
            player.var_d4800095 = 0;
        }
    }
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x0
// Checksum 0xc1ede475, Offset: 0x1de8
// Size: 0x20
function function_92abfe84() {
    level.var_4ee98ceb = [];
    level.var_f6aa5438 = #generic;
}

// Namespace zm_temple_elevators
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1e10
// Size: 0x4
function init_animtree() {
    
}

