#using scripts/codescripts/struct;

#namespace perplayer;

// Namespace perplayer
// Params 3, eflags: 0x0
// Checksum 0xf9cee4ad, Offset: 0x98
// Size: 0xbc
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
// Checksum 0xe85c2b12, Offset: 0x160
// Size: 0x146
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
// Checksum 0x7efddcd4, Offset: 0x2b0
// Size: 0x14e
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
// Checksum 0xbda69a53, Offset: 0x408
// Size: 0x180
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
// Checksum 0x2d37404b, Offset: 0x590
// Size: 0xcc
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
// Checksum 0xcf14f3f8, Offset: 0x668
// Size: 0x48
function onjoinedteam(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"joined_team");
        self thread unhandleplayer(handler, 1, 0);
    }
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0x1d57679c, Offset: 0x6b8
// Size: 0x48
function onjoinedspectators(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"joined_spectators");
        self thread unhandleplayer(handler, 1, 0);
    }
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0xf95ea169, Offset: 0x708
// Size: 0x40
function onplayerspawned(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"spawned_player");
        self thread handleplayer(handler);
    }
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0x5139db7c, Offset: 0x750
// Size: 0x48
function onplayerkilled(handler) {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"killed_player");
        self thread unhandleplayer(handler, 1, 0);
    }
}

// Namespace perplayer
// Params 1, eflags: 0x0
// Checksum 0xe45f05f4, Offset: 0x7a0
// Size: 0xb0
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
// Checksum 0x79b1d2fe, Offset: 0x858
// Size: 0xc4
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

