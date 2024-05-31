#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace scrambler;

// Namespace scrambler
// Params 0, eflags: 0x0
// namespace_ba0d5c0a<file_0>::function_1463e4e5
// Checksum 0x94fea33, Offset: 0x238
// Size: 0x16c
function init_shared() {
    level._effect["scrambler_enemy_light"] = "_t6/misc/fx_equip_light_red";
    level._effect["scrambler_friendly_light"] = "_t6/misc/fx_equip_light_green";
    level.var_aa893e08 = 1;
    level.var_312e999e = 1440000;
    level.var_7ab38fa4 = 250000;
    level.var_4b07dce5 = "mpl_scrambler_static";
    level.var_615f7b8e = "mpl_cuav_static";
    level.var_57e1f301 = "mpl_scrambler_alert";
    level.var_65068111 = "mpl_scrambler_ping";
    level.var_c019c5c9 = "mpl_scrambler_burst";
    clientfield::register("missile", "scrambler", 1, 1, "int", &function_948c304e, 0, 0);
    level.scramblers = [];
    level.var_188fa221 = [];
    localclientnum = 0;
    util::waitforclient(localclientnum);
    level thread function_2fbb0cd5(localclientnum);
    level thread checkforplayerswitch();
}

// Namespace scrambler
// Params 2, eflags: 0x0
// namespace_ba0d5c0a<file_0>::function_948c304e
// Checksum 0x42665048, Offset: 0x3b0
// Size: 0x4c
function function_948c304e(localclientnum, set) {
    if (!set) {
        return;
    }
    if (localclientnum != 0) {
        return;
    }
    self spawned(localclientnum, set, 1);
}

// Namespace scrambler
// Params 7, eflags: 0x0
// namespace_ba0d5c0a<file_0>::function_d621d691
// Checksum 0x9c94beb0, Offset: 0x408
// Size: 0x74
function function_d621d691(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    if (localclientnum != 0) {
        return;
    }
    self spawned(localclientnum, newval, 0);
}

// Namespace scrambler
// Params 3, eflags: 0x0
// namespace_ba0d5c0a<file_0>::function_ab1f9ea1
// Checksum 0xba4ba597, Offset: 0x488
// Size: 0x234
function spawned(localclientnum, set, var_5d749438) {
    if (!set) {
        return;
    }
    if (localclientnum != 0) {
        return;
    }
    var_aa893e08 = level.var_aa893e08;
    level.var_aa893e08++;
    size = level.scramblers.size;
    level.scramblers[size] = spawnstruct();
    level.scramblers[size].var_aa893e08 = var_aa893e08;
    level.scramblers[size].cent = self;
    level.scramblers[size].team = self.team;
    level.scramblers[size].var_5d749438 = var_5d749438;
    level.scramblers[size].sndent = spawn(0, self.origin, "script_origin");
    level.scramblers[size].var_dde7199 = -1;
    level.scramblers[size].var_8bebc2b9 = spawn(0, self.origin, "script_origin");
    level.scramblers[size].var_462368b1 = -1;
    players = level.localplayers;
    owner = self getowner(localclientnum);
    util::local_players_entity_thread(self, &function_8bbd150b, var_5d749438, var_aa893e08);
    level thread function_ddc2c972(self, var_aa893e08, var_5d749438, localclientnum);
}

// Namespace scrambler
// Params 3, eflags: 0x0
// namespace_ba0d5c0a<file_0>::function_8bbd150b
// Checksum 0xf713b19f, Offset: 0x6c8
// Size: 0x354
function function_8bbd150b(localclientnum, var_5d749438, var_aa893e08) {
    player = getlocalplayer(localclientnum);
    isenemy = self function_900e2038(localclientnum);
    owner = self getowner(localclientnum);
    var_8c65e876 = undefined;
    for (i = 0; i < level.scramblers.size; i++) {
        if (level.scramblers[i].var_aa893e08 == var_aa893e08) {
            var_8c65e876 = i;
            break;
        }
    }
    if (!isdefined(var_8c65e876)) {
        return;
    }
    if (!isenemy) {
        if (var_5d749438) {
            if (owner == player && !isspectating(localclientnum, 0)) {
                player addfriendlyscrambler(self.origin[0], self.origin[1], var_aa893e08);
            }
            if (isdefined(level.scramblers[var_8c65e876].sndent)) {
                level.scramblers[var_8c65e876].var_dde7199 = level.scramblers[var_8c65e876].sndent playloopsound(level.var_57e1f301);
                playsound(0, level.var_c019c5c9, level.scramblers[var_8c65e876].sndent.origin);
            }
            if (isdefined(level.scramblers[var_8c65e876].var_8bebc2b9)) {
                level.scramblers[var_8c65e876].var_462368b1 = level.scramblers[var_8c65e876].var_8bebc2b9 playloopsound(level.var_65068111);
            }
        }
    } else {
        var_4b07dce5 = level.var_4b07dce5;
        if (var_5d749438 == 0) {
            var_4b07dce5 = level.var_615f7b8e;
        }
        if (isdefined(level.scramblers[var_8c65e876].sndent)) {
            level.scramblers[var_8c65e876].var_dde7199 = level.scramblers[var_8c65e876].sndent playloopsound(var_4b07dce5);
        }
    }
    self thread fx::blinky_light(localclientnum, "tag_light", level._effect["scrambler_friendly_light"], level._effect["scrambler_enemy_light"]);
}

// Namespace scrambler
// Params 1, eflags: 0x0
// namespace_ba0d5c0a<file_0>::function_2fbb0cd5
// Checksum 0xf5ba1137, Offset: 0xa28
// Size: 0x8b0
function function_2fbb0cd5(localclientnum) {
    var_bee6c5a3 = level.var_312e999e;
    var_3951dae0 = level.var_312e999e;
    for (;;) {
        players = level.localplayers;
        for (localclientnum = 0; localclientnum < players.size; localclientnum++) {
            player = players[localclientnum];
            if (!isdefined(player.team)) {
                continue;
            }
            if (!isdefined(level.var_188fa221[localclientnum])) {
                level.var_188fa221[localclientnum] = spawnstruct();
                level.var_188fa221[localclientnum].var_bb2af1b9 = player.team;
                player removeallfriendlyscramblers();
            }
            if (level.var_188fa221[localclientnum].var_bb2af1b9 != player.team) {
                teamchanged = 1;
                level.var_188fa221[localclientnum].var_bb2af1b9 = player.team;
            } else {
                teamchanged = 0;
            }
            var_9399af70 = 0;
            var_29b97fb5 = 0;
            var_bee6c5a3 = level.var_312e999e;
            var_3951dae0 = level.var_312e999e;
            var_27e14f8d = 0;
            var_f613eadb = level.var_312e999e;
            var_5ab0759a = undefined;
            for (i = 0; i < level.scramblers.size; i++) {
                if (!isdefined(level.scramblers[i].cent)) {
                    continue;
                }
                if (isdefined(level.scramblers[i].cent.stunned) && level.scramblers[i].cent.stunned) {
                    level.scramblers[i].cent.var_83976e1f = 1;
                    player removefriendlyscrambler(level.scramblers[i].var_aa893e08);
                    continue;
                } else if (isdefined(level.scramblers[i].cent.var_83976e1f) && level.scramblers[i].cent.var_83976e1f) {
                    teamchanged = 1;
                    level.scramblers[i].cent.var_83976e1f = 0;
                }
                if (level.scramblers[i].var_5d749438) {
                    var_f613eadb = distancesquared(player.origin, level.scramblers[i].cent.origin);
                }
                if (!level.scramblers[i].var_5d749438 && level.scramblers[i].cent function_900e2038(localclientnum)) {
                    var_27e14f8d = 1;
                }
                isenemy = level.scramblers[i].cent function_900e2038(localclientnum);
                if (level.scramblers[i].team != level.scramblers[i].cent.team) {
                    var_727ff13f = 1;
                    level.scramblers[i].team = level.scramblers[i].cent.team;
                } else {
                    var_727ff13f = 0;
                }
                if (teamchanged || var_727ff13f) {
                    level.scramblers[i] function_f8ee1baf(isenemy);
                }
                if (isenemy) {
                    if (var_bee6c5a3 > var_f613eadb) {
                        var_5ab0759a = level.scramblers[i].cent;
                        var_bee6c5a3 = var_f613eadb;
                    }
                    if (teamchanged || level.scramblers[i].var_5d749438 && var_727ff13f) {
                        player removefriendlyscrambler(level.scramblers[i].var_aa893e08);
                    }
                    continue;
                }
                if (level.scramblers[i].var_5d749438) {
                    if (var_3951dae0 > var_f613eadb) {
                        var_3951dae0 = var_f613eadb;
                    }
                    owner = level.scramblers[i].cent getowner(localclientnum);
                    if (owner == player && !isspectating(localclientnum, 0)) {
                        if (teamchanged || var_727ff13f) {
                            player addfriendlyscrambler(level.scramblers[i].cent.origin[0], level.scramblers[i].cent.origin[1], level.scramblers[i].var_aa893e08);
                        }
                    }
                }
            }
            if (var_bee6c5a3 < level.var_312e999e) {
                var_4cf86dcf = 1 - (var_bee6c5a3 - level.var_7ab38fa4) / (level.var_312e999e - level.var_7ab38fa4);
            } else {
                var_4cf86dcf = 0;
            }
            if (var_3951dae0 < level.var_7ab38fa4) {
                var_29b97fb5 = 1;
            } else if (var_3951dae0 < level.var_312e999e) {
                var_29b97fb5 = 1 - (var_3951dae0 - level.var_7ab38fa4) / (level.var_312e999e - level.var_7ab38fa4);
            }
            player setfriendlyscrambleramount(var_29b97fb5);
            if (level.scramblers.size > 0 && isdefined(var_5ab0759a)) {
                player setnearestenemyscrambler(var_5ab0759a);
            } else {
                player clearnearestenemyscrambler();
            }
            if (var_27e14f8d && player hasperk(localclientnum, "specialty_immunecounteruav") == 0) {
                player setenemyglobalscrambler(1);
            } else {
                player setenemyglobalscrambler(0);
            }
            if (var_4cf86dcf > 1) {
                var_4cf86dcf = 1;
            }
            if (getdvarfloat("snd_futz") != var_4cf86dcf) {
                setdvar("snd_futz", var_4cf86dcf);
            }
        }
        wait(0.25);
        util::waitforallclients();
    }
}

// Namespace scrambler
// Params 4, eflags: 0x0
// namespace_ba0d5c0a<file_0>::function_ddc2c972
// Checksum 0x151400e3, Offset: 0x12e0
// Size: 0x2f6
function function_ddc2c972(scramblerent, var_aa893e08, var_5d749438, localclientnum) {
    scramblerent waittill(#"entityshutdown");
    players = level.localplayers;
    for (j = 0; j < level.scramblers.size; j++) {
        size = level.scramblers.size;
        if (var_aa893e08 == level.scramblers[j].var_aa893e08) {
            playsound(0, level.var_c019c5c9, level.scramblers[j].sndent.origin);
            level.scramblers[j].sndent delete();
            level.scramblers[j].sndent = self.scramblers[size - 1].sndent;
            level.scramblers[j].var_8bebc2b9 delete();
            level.scramblers[j].var_8bebc2b9 = self.scramblers[size - 1].var_8bebc2b9;
            level.scramblers[j].cent = level.scramblers[size - 1].cent;
            level.scramblers[j].var_aa893e08 = level.scramblers[size - 1].var_aa893e08;
            level.scramblers[j].team = level.scramblers[size - 1].team;
            level.scramblers[j].var_5d749438 = level.scramblers[size - 1].var_5d749438;
            level.scramblers[size - 1] = undefined;
            break;
        }
    }
    if (var_5d749438) {
        for (i = 0; i < players.size; i++) {
            players[i] removefriendlyscrambler(var_aa893e08);
        }
    }
}

// Namespace scrambler
// Params 1, eflags: 0x0
// namespace_ba0d5c0a<file_0>::function_900e2038
// Checksum 0x636f277e, Offset: 0x15e0
// Size: 0x5e
function function_900e2038(localclientnum) {
    /#
        if (getdvarint("<unknown string>", 0)) {
            return 1;
        }
    #/
    enemy = !util::function_f36b8920(localclientnum);
    return enemy;
}

// Namespace scrambler
// Params 0, eflags: 0x0
// namespace_ba0d5c0a<file_0>::function_22979bf
// Checksum 0xb0df6b07, Offset: 0x1648
// Size: 0x154
function checkforplayerswitch() {
    while (true) {
        level waittill(#"player_switch");
        waittillframeend();
        players = level.localplayers;
        for (localclientnum = 0; localclientnum < players.size; localclientnum++) {
            for (j = 0; j < level.scramblers.size; j++) {
                ent = level.scramblers[j].cent;
                ent thread fx::stop_blinky_light(localclientnum);
                ent thread fx::blinky_light(localclientnum, "tag_light", level._effect["scrambler_friendly_light"], level._effect["scrambler_enemy_light"]);
                isenemy = ent function_900e2038(localclientnum);
                level.scramblers[j] function_f8ee1baf(isenemy);
            }
        }
    }
}

// Namespace scrambler
// Params 1, eflags: 0x0
// namespace_ba0d5c0a<file_0>::function_f8ee1baf
// Checksum 0xa7c804a0, Offset: 0x17a8
// Size: 0xec
function function_f8ee1baf(isenemy) {
    if (self.var_dde7199 != -1) {
        self.sndent stopallloopsounds(0.1);
        self.var_dde7199 = -1;
    }
    if (!isenemy) {
        if (self.var_5d749438) {
            self.var_dde7199 = self.sndent playloopsound(level.var_57e1f301);
        }
        return;
    }
    var_5d749438 = self.var_5d749438;
    var_4b07dce5 = level.var_4b07dce5;
    if (var_5d749438 == 0) {
        var_4b07dce5 = level.var_615f7b8e;
    }
    self.var_dde7199 = self.sndent playloopsound(var_4b07dce5);
}

