#using scripts/zm/zm_moon_gravity;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_equip_gasmask;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_a9e990ad;

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0xd58cf54c, Offset: 0x4b0
// Size: 0xdc
function init() {
    level.zombie_init_done = &function_22afc09d;
    level thread function_d9f8aee0();
    zm_spawner::register_zombie_death_animscript_callback(&function_fc16fef9);
    callback::on_spawned(&function_76584b46);
    level thread function_6cde11c9();
    level thread function_120dc4d3();
    level thread function_597e721e();
    callback::on_spawned(&function_41720bcc);
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0xde6c0869, Offset: 0x598
// Size: 0xb2
function function_d9f8aee0() {
    keys = getarraykeys(level.zones);
    for (i = 0; i < level.zones.size; i++) {
        if (keys[i] == "nml_zone") {
            continue;
        }
        zerogravityvolumeon(keys[i]);
    }
    wait(0.5);
    level._effect["low_gravity_blood"] = "dlc5/moon/fx_bul_impact_blood_lowgrav";
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x0
// Checksum 0x8814f522, Offset: 0x658
// Size: 0xb8
function function_e56d070c() {
    while (true) {
        who = self waittill(#"trigger");
        if (!isplayer(who)) {
            self thread trigger::function_thread(who, &function_d03a733c, &function_a866a413);
            continue;
        }
        self thread trigger::function_thread(who, &function_671dc9eb, &function_bc826f7e);
    }
}

// Namespace namespace_a9e990ad
// Params 2, eflags: 0x1 linked
// Checksum 0x613a507b, Offset: 0x718
// Size: 0x6c
function function_d03a733c(ent, endon_condition) {
    if (!isdefined(ent.var_98905394)) {
        ent.var_98905394 = 0;
    }
    ent.var_98905394++;
    ent clientfield::set("low_gravity", 1);
}

// Namespace namespace_a9e990ad
// Params 1, eflags: 0x1 linked
// Checksum 0x1f123193, Offset: 0x790
// Size: 0x64
function function_a866a413(ent) {
    if (ent.var_98905394 > 0) {
        ent.var_98905394--;
        if (ent.var_98905394 == 0) {
            ent clientfield::set("low_gravity", 0);
        }
    }
}

// Namespace namespace_a9e990ad
// Params 2, eflags: 0x1 linked
// Checksum 0x55170b94, Offset: 0x800
// Size: 0x2c
function function_671dc9eb(ent, endon_condition) {
    ent setplayergravity(-120);
}

// Namespace namespace_a9e990ad
// Params 1, eflags: 0x1 linked
// Checksum 0xcbfd8c6e, Offset: 0x838
// Size: 0x24
function function_bc826f7e(ent) {
    ent clearplayergravity();
}

// Namespace namespace_a9e990ad
// Params 2, eflags: 0x1 linked
// Checksum 0xc14cfcb6, Offset: 0x868
// Size: 0x154
function function_c508229a(low_gravity, force_update) {
    if (!isdefined(self.animname)) {
        return;
    }
    if (isdefined(self.var_a7d1d70c) && self.var_a7d1d70c) {
        return;
    }
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
        return;
    }
    if (isdefined(self.var_98905394) && self.var_98905394 == low_gravity && !(isdefined(force_update) && force_update)) {
        return;
    }
    self.var_98905394 = low_gravity;
    if (low_gravity) {
        self clientfield::set("low_gravity", 1);
        self.script_noteworthy = "moon_gravity";
        self.var_4492808f = &function_7a7cde90;
        return;
    }
    self.var_4492808f = undefined;
    self.nogravity = undefined;
    self.script_noteworthy = undefined;
    util::wait_network_frame();
    if (isdefined(self)) {
        self clientfield::set("low_gravity", 0);
        self thread function_b4e07b39();
    }
}

// Namespace namespace_a9e990ad
// Params 5, eflags: 0x1 linked
// Checksum 0x11ad4b86, Offset: 0x9c8
// Size: 0xe8
function function_7a7cde90(mod, hit_location, var_8a2b6fe5, player, direction_vec) {
    if (mod === "MOD_PISTOL_BULLET" || mod === "MOD_RIFLE_BULLET") {
        forward = anglestoforward(direction_vec);
        up = anglestoup(direction_vec);
        right = anglestoright(direction_vec);
        playfx(level._effect["low_gravity_blood"], var_8a2b6fe5, forward, up);
        /#
        #/
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x835d80ae, Offset: 0xab8
// Size: 0x216
function function_fc16fef9() {
    if (isdefined(self._black_hole_bomb_collapse_death) && (!isdefined(self.var_98905394) || self.var_98905394 == 0 || self._black_hole_bomb_collapse_death)) {
        return false;
    }
    self startragdoll();
    var_99ac24c8 = randomintrange(-50, 50);
    var_bfae9f31 = randomintrange(-50, 50);
    var_e5b1199a = randomintrange(25, 45);
    var_d509c5fb = 75;
    var_aa77bab5 = 100;
    if (self.damagemod == "MOD_MELEE") {
        var_d509c5fb = 40;
        var_aa77bab5 = 50;
        var_e5b1199a = 15;
    } else if (self.damageweapon == level.start_weapon) {
        var_d509c5fb = 60;
        var_aa77bab5 = 75;
        var_e5b1199a = 20;
    } else if (self.damageweapon.weapclass == "spread") {
        var_d509c5fb = 100;
        var_aa77bab5 = -106;
    }
    scale = randomintrange(var_d509c5fb, var_aa77bab5);
    var_99ac24c8 = self.damagedir[0] * scale;
    var_bfae9f31 = self.damagedir[1] * scale;
    dir = (var_99ac24c8, var_bfae9f31, var_e5b1199a);
    self launchragdoll(dir);
    return false;
}

// Namespace namespace_a9e990ad
// Params 1, eflags: 0x1 linked
// Checksum 0xfcba135d, Offset: 0xcd8
// Size: 0x78
function function_9f360369(zone_name) {
    zone = getentarray(zone_name, "targetname");
    if (isdefined(zone[0].script_string) && zone[0].script_string == "lowgravity") {
        return true;
    }
    return false;
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x49096b13, Offset: 0xd58
// Size: 0x12c
function function_f25e5661() {
    self endon(#"death");
    util::wait_network_frame();
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.var_a7d1d70c) && self.var_a7d1d70c) {
        return;
    }
    if (self.zone_name == "nml_zone_spawners" || self.zone_name == "nml_area1_spawners" || self.zone_name == "nml_area2_spawners") {
        return;
    }
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
        self waittill(#"completed_emerging_into_playable_area");
    }
    if (!level flag::get("power_on") || isdefined(level.var_5f225972) && level.var_5f225972 && function_9f360369(self.zone_name)) {
        self function_c508229a(1);
        return;
    }
    self function_c508229a(0);
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x6276442b, Offset: 0xe90
// Size: 0x64
function function_22afc09d() {
    self.crawl_anim_override = &function_19c598a;
    self thread function_f25e5661();
    self thread function_a2b11def();
    self thread function_65123b80();
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x0
// Checksum 0xce0c1610, Offset: 0xf00
// Size: 0xc4
function function_becd5849() {
    self endon(#"death");
    var_811279e5 = undefined;
    if (self.zombie_move_speed == "walk" || self.zombie_move_speed == "run" || self.zombie_move_speed == "sprint") {
        var_811279e5 = "low_gravity_" + self.zombie_move_speed;
    }
    if (isdefined(var_811279e5)) {
        var_a4226c9e = self zombie_utility::append_missing_legs_suffix(var_811279e5);
        var_a4226c9e = "walk";
        self zombie_utility::set_zombie_run_cycle(var_a4226c9e);
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x6160e821, Offset: 0xfd0
// Size: 0xc4
function function_a2b11def() {
    self endon(#"death");
    var_25bc96d4 = 32;
    while (true) {
        if (isdefined(self.nogravity) && self.nogravity) {
            ground = self zm_utility::groundpos(self.origin);
            dist = self.origin[2] - ground[2];
            if (dist > var_25bc96d4) {
                util::wait_network_frame();
                self.nogravity = undefined;
            }
        }
        wait(0.2);
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x78b762f3, Offset: 0x10a0
// Size: 0xb2
function function_65123b80() {
    self endon(#"death");
    while (true) {
        note = self waittill(#"runanim");
        if (!isdefined(self.script_noteworthy) || self.script_noteworthy != "moon_gravity") {
            continue;
        }
        if (note == "gravity off") {
            self animmode("nogravity");
            self.nogravity = 1;
            continue;
        }
        if (note == "gravity code") {
            self.nogravity = undefined;
        }
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x2d855160, Offset: 0x1160
// Size: 0x14
function function_b4e07b39() {
    zombie_utility::set_zombie_run_cycle();
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x9979fd54, Offset: 0x1180
// Size: 0x3b0
function function_c710beca() {
    level flag::wait_till("start_zombie_round_logic");
    var_4c8e9aaf = -120;
    player_zones = getentarray("player_volume", "script_noteworthy");
    while (true) {
        players = getplayers();
        for (i = 0; i < player_zones.size; i++) {
            volume = player_zones[i];
            zone = undefined;
            if (isdefined(volume.targetname)) {
                zone = level.zones[volume.targetname];
            }
            if (isdefined(zone.is_enabled) && isdefined(zone) && zone.is_enabled) {
                for (j = 0; j < players.size; j++) {
                    player = players[j];
                    if (zombie_utility::is_player_valid(player) && player istouching(volume)) {
                        if (isdefined(level.var_5f225972) && level.var_5f225972 && !level flag::get("power_on")) {
                            player setperk("specialty_lowgravity");
                            if (!(isdefined(player.var_98905394) && player.var_98905394)) {
                                player clientfield::set_to_player("snd_lowgravity", 1);
                            }
                            player.var_98905394 = 1;
                            continue;
                        }
                        if (isdefined(volume.script_string) && volume.script_string == "lowgravity") {
                            player setperk("specialty_lowgravity");
                            if (!(isdefined(player.var_98905394) && player.var_98905394)) {
                                player clientfield::set_to_player("snd_lowgravity", 1);
                            }
                            player.var_98905394 = 1;
                            continue;
                        }
                        player unsetperk("specialty_lowgravity");
                        if (isdefined(player.var_98905394) && player.var_98905394) {
                            player clientfield::set_to_player("snd_lowgravity", 0);
                        }
                        player.var_98905394 = 0;
                    }
                }
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0xf370e94b, Offset: 0x1538
// Size: 0x86
function function_f41db41e() {
    level flag::wait_till("start_zombie_round_logic");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread function_58f7f2e8();
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0xbe1524a6, Offset: 0x15c8
// Size: 0x248
function function_58f7f2e8() {
    self endon(#"death");
    self endon(#"disconnect");
    var_b3b23275 = 40;
    while (true) {
        if (isdefined(self.var_98905394) && zombie_utility::is_player_valid(self) && self.var_98905394 && self isonground() && self issprinting()) {
            boost = randomint(100);
            if (boost < var_b3b23275) {
                time = randomfloatrange(0.75, 1.25);
                wait(time);
                if (isdefined(self.var_98905394) && self.var_98905394 && self isonground() && self issprinting()) {
                    self setorigin(self.origin + (0, 0, 1));
                    player_velocity = self getvelocity();
                    var_a4a3a420 = player_velocity + (0, 0, 100);
                    self setvelocity(var_a4a3a420);
                    if (!(isdefined(level.var_833e8251) && level.var_833e8251)) {
                        self thread zm_audio::create_and_play_dialog("general", "moonjump");
                        level.var_833e8251 = 1;
                    }
                    var_b3b23275 = 40;
                    wait(2);
                } else {
                    var_b3b23275 += 10;
                }
            } else {
                wait(2);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x0
// Checksum 0x2e414ef5, Offset: 0x1818
// Size: 0x86
function function_6dddd206() {
    level flag::wait_till("start_zombie_round_logic");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread function_76584b46();
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x60dba2fc, Offset: 0x18a8
// Size: 0x5d0
function function_76584b46() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"hash_c48e38d7");
    self endon(#"hash_c48e38d7");
    level flag::wait_till("start_zombie_round_logic");
    self.var_1450dbee = 0;
    var_5268ee68 = 0;
    var_467c2dc5 = 0;
    var_5e857e1f = 15000;
    var_934b9e1e = 17000;
    var_d5e40180 = 0;
    var_7233be3d = 0;
    var_c748993a = 7;
    var_58f5ef4b = [];
    var_58f5ef4b[0] = 1000;
    var_58f5ef4b[1] = 1250;
    var_58f5ef4b[2] = 1250;
    var_58f5ef4b[3] = 1500;
    var_58f5ef4b[4] = 1500;
    var_58f5ef4b[5] = 1750;
    var_58f5ef4b[6] = 2250;
    var_58f5ef4b[7] = 2500;
    var_d16f78e4 = [];
    var_d16f78e4[0] = 1;
    var_d16f78e4[1] = 2;
    var_d16f78e4[2] = 3;
    var_d16f78e4[3] = 5;
    var_d16f78e4[4] = 7;
    var_d16f78e4[5] = 8;
    var_d16f78e4[6] = 9;
    var_d16f78e4[7] = 10;
    var_152d58b1 = [];
    var_152d58b1[0] = 0.2;
    var_152d58b1[1] = 0.25;
    var_152d58b1[2] = 0.25;
    var_152d58b1[3] = 0.5;
    var_152d58b1[4] = 0.5;
    var_152d58b1[5] = 0.75;
    var_152d58b1[6] = 0.75;
    var_152d58b1[7] = 1;
    if (isdefined(level.var_3e99b966) && level.var_3e99b966) {
        var_467c2dc5 = 3000;
    }
    starttime = gettime();
    for (nexttime = gettime(); true; nexttime = gettime()) {
        diff = nexttime - starttime;
        if (isgodmode(self)) {
            var_5268ee68 = 0;
            var_7233be3d = 0;
            wait(1);
            continue;
        }
        if (!zombie_utility::is_player_valid(self) || !(isdefined(level.var_5f225972) && level.var_5f225972)) {
            var_5268ee68 = 0;
            var_7233be3d = 0;
            util::wait_network_frame();
            continue;
        }
        if (isdefined(self.var_98905394) && (!level flag::get("power_on") || self.var_98905394) && !self namespace_11fcf241::function_7dd87435()) {
            self thread function_cbabaabf();
            var_d5e40180 += diff;
            var_5268ee68 += diff;
            if (self hasperk("specialty_armorvest")) {
                var_467c2dc5 = var_934b9e1e;
            } else {
                var_467c2dc5 = var_5e857e1f;
            }
            if (var_5268ee68 > var_467c2dc5) {
                self playsoundtoplayer("evt_suffocate_whump", self);
                self dodamage(self.health * 10, self.origin);
                self setblur(0, 0.1);
            } else if (var_7233be3d < var_58f5ef4b.size && var_d5e40180 > var_58f5ef4b[var_7233be3d]) {
                self clientfield::set_to_player("gasp_rumble", 1);
                self playsoundtoplayer("evt_suffocate_whump", self);
                self setblur(var_d16f78e4[var_7233be3d], 0.1);
                self thread function_c143c167(var_152d58b1[var_7233be3d]);
                var_7233be3d++;
                if (var_7233be3d > var_c748993a) {
                    var_7233be3d = var_c748993a;
                }
                var_d5e40180 = 0;
            }
        } else if (var_5268ee68 > 0) {
            var_5268ee68 = 0;
            var_d5e40180 = 0;
            var_7233be3d = 0;
        }
        starttime = gettime();
        wait(0.1);
    }
}

// Namespace namespace_a9e990ad
// Params 1, eflags: 0x1 linked
// Checksum 0x61586d6c, Offset: 0x1e80
// Size: 0x5c
function function_c143c167(time) {
    self endon(#"disconnect");
    wait(time);
    self setblur(0, 0.1);
    self clientfield::set_to_player("gasp_rumble", 0);
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x90afbc2c, Offset: 0x1ee8
// Size: 0x128
function function_cbabaabf() {
    self endon(#"death");
    self endon(#"disconnect");
    entity_num = self.characterindex;
    if (isdefined(self.var_62030aa3)) {
        entity_num = self.var_62030aa3;
    }
    if (isdefined(level.player_4_vox_override) && entity_num == 2 && level.player_4_vox_override) {
        entity_num = 4;
    }
    if (!self.var_1450dbee) {
        self.var_1450dbee = 1;
        wait(2);
        if (isdefined(self.var_98905394) && isdefined(self) && self.var_98905394) {
            level.player_is_speaking = 1;
            self playsoundtoplayer("vox_plr_" + entity_num + "_location_airless_" + randomintrange(0, 5), self);
            wait(10);
            level.player_is_speaking = 0;
        }
        wait(0.1);
        self.var_1450dbee = 0;
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0xaa28113, Offset: 0x2018
// Size: 0x1d0
function function_6cde11c9() {
    level flag::wait_till("power_on");
    player_zones = getentarray("player_volume", "script_noteworthy");
    zombies = getaiarray();
    for (i = 0; i < player_zones.size; i++) {
        volume = player_zones[i];
        zone = undefined;
        if (isdefined(volume.targetname)) {
            zone = level.zones[volume.targetname];
        }
        if (isdefined(zone.is_enabled) && isdefined(zone) && zone.is_enabled) {
            if (isdefined(volume.script_string) && volume.script_string == "gravity") {
                for (j = 0; j < zombies.size; j++) {
                    zombie = zombies[j];
                    if (isdefined(zombie) && zombie istouching(volume)) {
                        zombie function_c508229a(0);
                    }
                }
            }
        }
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x3414cfc9, Offset: 0x21f0
// Size: 0x106
function function_120dc4d3() {
    level flag::wait_till("power_on");
    keys = getarraykeys(level.zones);
    for (i = 0; i < level.zones.size; i++) {
        if (keys[i] == "nml_zone") {
            continue;
        }
        volume = level.zones[keys[i]].volumes[0];
        if (isdefined(volume.script_string) && volume.script_string == "gravity") {
            zerogravityvolumeoff(keys[i]);
        }
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x0
// Checksum 0x24780e5d, Offset: 0x2300
// Size: 0x86
function function_4c9cd81c() {
    level flag::wait_till("start_zombie_round_logic");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread function_41720bcc();
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x85b2d7b1, Offset: 0x2390
// Size: 0x88
function function_41720bcc() {
    self notify(#"hash_41720bcc");
    self endon(#"hash_41720bcc");
    self endon(#"disconnect");
    level flag::wait_till("start_zombie_round_logic");
    while (true) {
        grenade, weapname = self waittill(#"grenade_fire");
        grenade thread function_3d7b829e();
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x3a035171, Offset: 0x2420
// Size: 0x28c
function function_3d7b829e() {
    self endon(#"death");
    self endon(#"explode");
    player_zones = getentarray("player_volume", "script_noteworthy");
    while (true) {
        if (isdefined(level.var_5f225972) && level.var_5f225972 && !level flag::get("power_on")) {
            if (isdefined(self) && isalive(self)) {
                self.script_noteworthy = "moon_gravity";
                self setentgravitytrajectory(1);
            }
            wait(0.25);
            continue;
        }
        for (i = 0; i < player_zones.size; i++) {
            volume = player_zones[i];
            zone = undefined;
            if (isdefined(volume.targetname)) {
                zone = level.zones[volume.targetname];
            }
            if (isdefined(zone.is_enabled) && isdefined(zone) && zone.is_enabled) {
                if (isdefined(volume.script_string) && volume.script_string == "lowgravity") {
                    if (isdefined(self) && isalive(self) && self istouching(volume)) {
                        if (volume.script_string == "lowgravity") {
                            self.script_noteworthy = "moon_gravity";
                            self setentgravitytrajectory(1);
                            continue;
                        }
                        if (volume.script_string == "gravity") {
                            self.script_noteworthy = undefined;
                            self setentgravitytrajectory(0);
                        }
                    }
                }
            }
        }
        wait(0.25);
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x8c767d47, Offset: 0x26b8
// Size: 0x76
function function_597e721e() {
    airlock_doors = getentarray("zombie_door_airlock", "script_noteworthy");
    for (i = 0; i < airlock_doors.size; i++) {
        airlock_doors[i] thread function_4c70c1d6();
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x1ba9dfb4, Offset: 0x2738
// Size: 0x248
function function_4c70c1d6() {
    while (true) {
        who = self waittill(#"trigger");
        if (isplayer(who)) {
            continue;
        }
        if (!level flag::get("power_on")) {
            continue;
        }
        if (isdefined(self.script_parameters)) {
            zone = getentarray(self.script_parameters, "targetname");
            var_a366310c = 0;
            for (i = 0; i < zone.size; i++) {
                if (who istouching(zone[i])) {
                    who function_c508229a(0);
                    var_a366310c = 1;
                    break;
                }
            }
            if (var_a366310c) {
                continue;
            }
        }
        if (self.script_string == "inside") {
            if (isdefined(self.doors[0].script_noteworthy)) {
                var_7b46c2ad = getentarray(self.doors[0].script_noteworthy, "targetname");
                if (var_7b46c2ad[0].script_string == "lowgravity") {
                    who function_c508229a(1);
                    self.script_string = "outside";
                } else {
                    who function_c508229a(0);
                }
            } else {
                who function_c508229a(0);
            }
            continue;
        }
        who function_c508229a(1);
    }
}

// Namespace namespace_a9e990ad
// Params 1, eflags: 0x1 linked
// Checksum 0x613879be, Offset: 0x2988
// Size: 0x1ac
function function_8820a302(zone_name) {
    zones = getentarray(zone_name, "targetname");
    zombies = getaiarray();
    throttle = 0;
    for (i = 0; i < zombies.size; i++) {
        zombie = zombies[i];
        if (isdefined(zombie)) {
            for (j = 0; j < zones.size; j++) {
                if (zombie istouching(zones[j])) {
                    zombie function_c508229a(1);
                    throttle++;
                }
            }
        }
        if (throttle && !(throttle % 10)) {
            util::wait_network_frame();
            util::wait_network_frame();
            util::wait_network_frame();
        }
    }
    if (isdefined(level.var_2f9ab492) && isdefined(level.var_2f9ab492[zone_name])) {
        exploder::delete_exploder_on_clients(level.var_2f9ab492[zone_name]);
    }
}

// Namespace namespace_a9e990ad
// Params 0, eflags: 0x1 linked
// Checksum 0x15ca9642, Offset: 0x2b40
// Size: 0x1a6
function function_19c598a() {
    var_f724cabe = getentarray("player_volume", "script_noteworthy");
    if (!(isdefined(level.var_5f225972) && level.var_5f225972)) {
        return;
    }
    if (!level flag::get("power_on")) {
        self function_c508229a(1, 1);
        return;
    }
    for (i = 0; i < var_f724cabe.size; i++) {
        volume = var_f724cabe[i];
        zone = undefined;
        if (isdefined(volume.targetname)) {
            zone = level.zones[volume.targetname];
        }
        if (isdefined(zone.is_enabled) && isdefined(zone) && zone.is_enabled) {
            if (self istouching(volume)) {
                if (isdefined(volume.script_string) && volume.script_string == "lowgravity") {
                    self function_c508229a(1, 1);
                }
            }
        }
    }
}

