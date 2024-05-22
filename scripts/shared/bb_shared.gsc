#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace bb;

// Namespace bb
// Params 0, eflags: 0x1 linked
// Checksum 0x3aae8d24, Offset: 0x218
// Size: 0x24
function init_shared() {
    callback::on_start_gametype(&init);
}

// Namespace bb
// Params 0, eflags: 0x1 linked
// Checksum 0x1292c834, Offset: 0x248
// Size: 0x44
function init() {
    callback::on_connect(&player_init);
    callback::on_spawned(&on_player_spawned);
}

// Namespace bb
// Params 0, eflags: 0x1 linked
// Checksum 0xeaeeda8, Offset: 0x298
// Size: 0x1c
function player_init() {
    self thread on_player_death();
}

// Namespace bb
// Params 0, eflags: 0x1 linked
// Checksum 0xa46f1e92, Offset: 0x2c0
// Size: 0x7e
function on_player_spawned() {
    self endon(#"disconnect");
    self._bbdata = [];
    self._bbdata["score"] = 0;
    self._bbdata["momentum"] = 0;
    self._bbdata["spawntime"] = gettime();
    self._bbdata["shots"] = 0;
    self._bbdata["hits"] = 0;
}

// Namespace bb
// Params 0, eflags: 0x0
// Checksum 0xee53c396, Offset: 0x348
// Size: 0x2c
function on_player_disconnect() {
    for (;;) {
        self waittill(#"disconnect");
        self commit_spawn_data();
        break;
    }
}

// Namespace bb
// Params 0, eflags: 0x1 linked
// Checksum 0xbde88803, Offset: 0x380
// Size: 0x38
function on_player_death() {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"death");
        self commit_spawn_data();
    }
}

// Namespace bb
// Params 0, eflags: 0x1 linked
// Checksum 0xba180f58, Offset: 0x3c0
// Size: 0xac
function commit_spawn_data() {
    /#
        /#
            assert(isdefined(self._bbdata));
        #/
    #/
    if (!isdefined(self._bbdata)) {
        return;
    }
    bbprint("mpplayerlives", "gametime %d spawnid %d lifescore %d lifemomentum %d lifetime %d name %s", gettime(), getplayerspawnid(self), self._bbdata["score"], self._bbdata["momentum"], gettime() - self._bbdata["spawntime"], self.name);
}

// Namespace bb
// Params 3, eflags: 0x1 linked
// Checksum 0x8c564503, Offset: 0x478
// Size: 0x146
function commit_weapon_data(spawnid, currentweapon, time0) {
    /#
        /#
            assert(isdefined(self._bbdata));
        #/
    #/
    if (!isdefined(self._bbdata)) {
        return;
    }
    time1 = gettime();
    blackboxeventname = "mpweapons";
    if (sessionmodeiscampaigngame()) {
        blackboxeventname = "cpweapons";
    } else if (sessionmodeiszombiesgame()) {
        blackboxeventname = "zmweapons";
    }
    bbprint(blackboxeventname, "spawnid %d name %s duration %d shots %d hits %d", spawnid, currentweapon.name, time1 - time0, self._bbdata["shots"], self._bbdata["hits"]);
    self._bbdata["shots"] = 0;
    self._bbdata["hits"] = 0;
}

// Namespace bb
// Params 2, eflags: 0x1 linked
// Checksum 0x8e22cb3c, Offset: 0x5c8
// Size: 0x56
function add_to_stat(statname, delta) {
    if (isdefined(self._bbdata) && isdefined(self._bbdata[statname])) {
        self._bbdata[statname] = self._bbdata[statname] + delta;
    }
}

// Namespace bb
// Params 1, eflags: 0x1 linked
// Checksum 0xbb0627d7, Offset: 0x628
// Size: 0xd4
function function_6a33da3c(var_758db14b) {
    if (isdefined(level.gametype) && level.gametype === "doa") {
        return;
    }
    var_2b0e341 = self getmatchrecordlifeindex();
    if (var_2b0e341 == -1) {
        return;
    }
    movementtype = "";
    stance = "";
    bbprint(var_758db14b, "gametime %d lifeIndex %d posx %d posy %d posz %d yaw %d pitch %d movetype %s stance %s", gettime(), var_2b0e341, self.origin, self.angles[0], self.angles[1], movementtype, stance);
}

// Namespace bb
// Params 1, eflags: 0x1 linked
// Checksum 0x3c081c84, Offset: 0x708
// Size: 0xec
function function_543e7299(var_758db14b) {
    level endon(#"game_ended");
    if (isdefined(level.gametype) && (!sessionmodeisonlinegame() || level.gametype === "doa")) {
        return;
    }
    while (true) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isalive(player)) {
                player function_6a33da3c(var_758db14b);
            }
        }
        wait(2);
    }
}

