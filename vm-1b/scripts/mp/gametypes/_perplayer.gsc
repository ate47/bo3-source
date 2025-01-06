#using scripts/codescripts/struct;

#namespace perplayer;

// Namespace perplayer
// Params 3, eflags: 0x0
// Checksum 0x11ac24a1, Offset: 0x98
// Size: 0x8c
function init(id, playerbegincallback, playerendcallback) {
    handler = spawnstruct();
    handler.id = id;
    handler.playerbegincallback = playerbegincallback;
    handler.playerendcallback = playerendcallback;
    handler.enabled = 0;
    handler.players = [];
    thread onplayerconnect(handler);
    level.handlerglobalflagval = 0;
    return handler;
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0x5667ee64, Offset: 0x130
// Size: 0xe9
function enable(handler) {
    if (handler.enabled) {
        return;
    }
    handler.enabled = 1;
    level.handlerglobalflagval++;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i].handlerflagval = level.handlerglobalflagval;
    }
    players = handler.players;
    for (i = 0; i < players.size; i++) {
        if (players[i].handlerflagval != level.handlerglobalflagval) {
            continue;
        }
        if (players[i].handlers[handler.id].ready) {
            players[i] handleplayer(handler);
        }
    }
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0x15eb8235, Offset: 0x228
// Size: 0xe9
function disable(handler) {
    if (!handler.enabled) {
        return;
    }
    handler.enabled = 0;
    level.handlerglobalflagval++;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i].handlerflagval = level.handlerglobalflagval;
    }
    players = handler.players;
    for (i = 0; i < players.size; i++) {
        if (players[i].handlerflagval != level.handlerglobalflagval) {
            continue;
        }
        if (players[i].handlers[handler.id].ready) {
            players[i] unhandleplayer(handler, 0, 0);
        }
    }
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0xa44b072, Offset: 0x320
// Size: 0x10d
function onplayerconnect(handler) {
    for (;;) {
        level waittill(#"connecting", player);
        if (!isdefined(player.handlers)) {
            player.handlers = [];
        }
        player.handlers[handler.id] = spawnstruct();
        player.handlers[handler.id].ready = 0;
        player.handlers[handler.id].handled = 0;
        player.handlerflagval = -1;
        handler.players[handler.players.size] = player;
        player thread onplayerdisconnect(handler);
        player thread onplayerspawned(handler);
        player thread onjoinedteam(handler);
        player thread onjoinedspectators(handler);
        player thread onplayerkilled(handler);
    }
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0x75817d1d, Offset: 0x438
// Size: 0x8a
function onplayerdisconnect(handler) {
    self waittill(#"disconnect");
    newplayers = [];
    for (i = 0; i < handler.players.size; i++) {
        if (handler.players[i] != self) {
            newplayers[newplayers.size] = handler.players[i];
        }
    }
    handler.players = newplayers;
    self thread unhandleplayer(handler, 1, 1);
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0x6f8463c2, Offset: 0x4d0
// Size: 0x35
function onjoinedteam(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"joined_team");
        self thread unhandleplayer(handler, 1, 0);
    }
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0x4fd1980b, Offset: 0x510
// Size: 0x35
function onjoinedspectators(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"joined_spectators");
        self thread unhandleplayer(handler, 1, 0);
    }
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0x8911fde1, Offset: 0x550
// Size: 0x35
function onplayerspawned(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"spawned_player");
        self thread handleplayer(handler);
    }
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0x26074dda, Offset: 0x590
// Size: 0x35
function onplayerkilled(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"killed_player");
        self thread unhandleplayer(handler, 1, 0);
    }
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0x4223a410, Offset: 0x5d0
// Size: 0x80
function handleplayer(handler) {
    self.handlers[handler.id].ready = 1;
    if (!handler.enabled) {
        return;
    }
    if (self.handlers[handler.id].handled) {
        return;
    }
    self.handlers[handler.id].handled = 1;
    self thread [[ handler.playerbegincallback ]]();
}

// Namespace perplayer
// Params 3, eflags: 0x0
// Checksum 0x79e28e82, Offset: 0x658
// Size: 0x94
function unhandleplayer(handler, unsetready, disconnected) {
    if (!disconnected && unsetready) {
        self.handlers[handler.id].ready = 0;
    }
    if (!self.handlers[handler.id].handled) {
        return;
    }
    if (!disconnected) {
        self.handlers[handler.id].handled = 0;
    }
    self thread [[ handler.playerendcallback ]](disconnected);
}

