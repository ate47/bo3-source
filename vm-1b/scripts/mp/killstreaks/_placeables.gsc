#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/_oob;
#using scripts/shared/clientfield_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/util_shared;

#namespace placeables;

// Namespace placeables
// Params 18, eflags: 0x0
// Checksum 0x98abd6ea, Offset: 0x280
// Size: 0x414
function spawnplaceable(killstreakref, killstreakid, onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring) {
    player = self;
    self killstreaks::switch_to_last_non_killstreak_weapon();
    placeable = spawn("script_model", player.origin);
    placeable.cancelable = 1;
    placeable.held = 0;
    placeable.validmodel = validmodel;
    placeable.invalidmodel = invalidmodel;
    placeable.killstreakid = killstreakid;
    placeable.killstreakref = killstreakref;
    placeable.oncancel = oncancelcallback;
    placeable.onemp = onempcallback;
    placeable.onmove = onmovecallback;
    placeable.onplace = onplacecallback;
    placeable.onshutdown = onshutdowncallback;
    placeable.ondeath = ondeathcallback;
    placeable.owner = player;
    placeable.originalowner = player;
    placeable.ownerentnum = player.entnum;
    placeable.originalownerentnum = player.entnum;
    placeable.pickupstring = pickupstring;
    placeable.placedmodel = model;
    placeable.spawnsvehicle = spawnsvehicle;
    placeable.originalteam = player.team;
    placeable.timedout = 0;
    placeable.timeout = timeout;
    placeable.timeoutstarted = 0;
    placeable.angles = (0, player.angles[1], 0);
    placeable.placehintstring = placehintstring;
    placeable.invalidlocationhintstring = invalidlocationhintstring;
    if (!isdefined(placeable.placehintstring)) {
        placeable.placehintstring = "";
    }
    if (!isdefined(placeable.invalidlocationhintstring)) {
        placeable.invalidlocationhintstring = "";
    }
    placeable notsolid();
    if (isdefined(placeable.vehicle)) {
        placeable.vehicle notsolid();
    }
    placeable.othermodel = spawn("script_model", player.origin);
    placeable.othermodel setmodel(placeable.placedmodel);
    placeable.othermodel setinvisibletoplayer(player);
    placeable.othermodel notsolid();
    placeable.othermodel clientfield::set("enemyvehicle", 1);
    placeable killstreaks::configure_team(killstreakref, killstreakid, player);
    if (isdefined(health) && health > 0) {
        placeable.health = health;
        placeable setcandamage(0);
        placeable thread killstreaks::monitordamage(killstreakref, health, &ondeath, 0, undefined, empdamage, &onemp, 1);
    }
    player thread carryplaceable(placeable);
    level thread cancelongameend(placeable);
    player thread shutdownoncancelevent(placeable);
    player thread cancelonplayerdisconnect(placeable);
    placeable thread watchownergameevents();
    return placeable;
}

// Namespace placeables
// Params 3, eflags: 0x0
// Checksum 0x686ac2ea, Offset: 0x6a0
// Size: 0x4a
function updateplacementmodels(model, validmodel, invalidmodel) {
    placeable = self;
    placeable.placedmodel = model;
    placeable.validmodel = validmodel;
    placeable.invalidmodel = invalidmodel;
}

// Namespace placeables
// Params 1, eflags: 0x0
// Checksum 0x65e6e596, Offset: 0x6f8
// Size: 0x12a
function carryplaceable(placeable) {
    player = self;
    placeable show();
    placeable notsolid();
    if (isdefined(placeable.vehicle)) {
        placeable.vehicle notsolid();
    }
    if (isdefined(placeable.othermodel)) {
        placeable thread util::ghost_wait_show_to_player(player, 0.05, "abort_ghost_wait_show");
        placeable.othermodel thread util::ghost_wait_show_to_others(player, 0.05, "abort_ghost_wait_show");
        placeable.othermodel notsolid();
    }
    placeable.held = 1;
    player.holding_placeable = placeable;
    player carryturret(placeable, (40, 0, 0), (0, 0, 0));
    player util::function_f9e9f0f0();
    player thread watchplacement(placeable);
}

// Namespace placeables
// Params 0, eflags: 0x0
// Checksum 0xeac54ef6, Offset: 0x830
// Size: 0xc1
function innoplacementtrigger() {
    placeable = self;
    if (isdefined(level.noturretplacementtriggers)) {
        for (i = 0; i < level.noturretplacementtriggers.size; i++) {
            if (placeable istouching(level.noturretplacementtriggers[i])) {
                return true;
            }
        }
    }
    if (isdefined(level.fatal_triggers)) {
        for (i = 0; i < level.fatal_triggers.size; i++) {
            if (placeable istouching(level.fatal_triggers[i])) {
                return true;
            }
        }
    }
    if (placeable oob::istouchinganyoobtrigger()) {
        return true;
    }
    return false;
}

// Namespace placeables
// Params 1, eflags: 0x0
// Checksum 0xf7fafbd3, Offset: 0x900
// Size: 0x561
function watchplacement(placeable) {
    player = self;
    player endon(#"disconnect");
    player endon(#"death");
    placeable endon(#"placed");
    placeable endon(#"cancelled");
    player thread watchcarrycancelevents(placeable);
    lastattempt = -1;
    placeable.canbeplaced = 0;
    waitingforattackbuttonrelease = 1;
    while (true) {
        placement = player canplayerplaceturret();
        placeable.origin = placement["origin"];
        placeable.angles = placement["angles"];
        placeable.canbeplaced = placement["result"] && !placeable innoplacementtrigger();
        if (isdefined(placeable.othermodel)) {
            placeable.othermodel.origin = placement["origin"];
            placeable.othermodel.angles = placement["angles"];
        }
        if (placeable.canbeplaced != lastattempt) {
            if (placeable.canbeplaced) {
                placeable setmodel(placeable.validmodel);
                player sethintstring(istring(placeable.placehintstring));
            } else {
                placeable setmodel(placeable.invalidmodel);
                player sethintstring(istring(placeable.invalidlocationhintstring));
            }
            lastattempt = placeable.canbeplaced;
        }
        while (waitingforattackbuttonrelease && !player attackbuttonpressed()) {
            waitingforattackbuttonrelease = 0;
        }
        if (!waitingforattackbuttonrelease && placeable.canbeplaced && player attackbuttonpressed()) {
            if (placement["result"]) {
                placeable.origin = placement["origin"];
                placeable.angles = placement["angles"];
                player sethintstring("");
                player stopcarryturret(placeable);
                if (!player util::function_31827fe8()) {
                    player util::function_ee182f5d();
                }
                placeable.held = 0;
                player.holding_placeable = undefined;
                placeable.cancelable = 0;
                if (isdefined(placeable.health) && placeable.health) {
                    placeable setcandamage(1);
                    placeable solid();
                }
                if (isdefined(placeable.vehicle)) {
                    placeable.vehicle setcandamage(1);
                    placeable.vehicle solid();
                }
                if (isdefined(placeable.placedmodel) && !placeable.spawnsvehicle) {
                    placeable setmodel(placeable.placedmodel);
                } else {
                    placeable notify(#"abort_ghost_wait_show");
                    placeable.abort_ghost_wait_show_to_player = 1;
                    placeable.abort_ghost_wait_show_to_others = 1;
                    placeable ghost();
                    if (isdefined(placeable.othermodel)) {
                        placeable.othermodel notify(#"abort_ghost_wait_show");
                        placeable.othermodel.abort_ghost_wait_show_to_player = 1;
                        placeable.othermodel.abort_ghost_wait_show_to_others = 1;
                        placeable.othermodel ghost();
                    }
                }
                if (isdefined(placeable.timeout)) {
                    if (!placeable.timeoutstarted) {
                        placeable.timeoutstarted = 1;
                        placeable thread killstreaks::waitfortimeout(placeable.killstreakref, placeable.timeout, &ontimeout, "death", "cancelled");
                    } else if (placeable.timedout) {
                        placeable thread killstreaks::waitfortimeout(placeable.killstreakref, 5000, &ontimeout, "cancelled");
                    }
                }
                if (isdefined(placeable.onplace)) {
                    player [[ placeable.onplace ]](placeable);
                    if (isdefined(placeable.onmove) && !placeable.timedout) {
                        spawnmovetrigger(placeable, player);
                    }
                }
                placeable notify(#"placed");
            }
        }
        if (placeable.cancelable && player actionslotfourbuttonpressed()) {
            placeable notify(#"cancelled");
        }
        wait 0.05;
    }
}

// Namespace placeables
// Params 1, eflags: 0x0
// Checksum 0x4c4aa79c, Offset: 0xe70
// Size: 0x8c
function watchcarrycancelevents(placeable) {
    player = self;
    assert(isplayer(player));
    placeable endon(#"cancelled");
    placeable endon(#"placed");
    player util::waittill_any("death", "emp_jammed", "emp_grenaded", "disconnect", "joined_team");
    placeable notify(#"cancelled");
}

// Namespace placeables
// Params 0, eflags: 0x0
// Checksum 0xfa47ee5f, Offset: 0xf08
// Size: 0x72
function ontimeout() {
    placeable = self;
    if (isdefined(placeable.held) && placeable.held) {
        placeable.timedout = 1;
        return;
    }
    placeable notify(#"delete_placeable_trigger");
    placeable thread killstreaks::waitfortimeout(placeable.killstreakref, 5000, &forceshutdown, "cancelled");
}

// Namespace placeables
// Params 2, eflags: 0x0
// Checksum 0x6a041ab5, Offset: 0xf88
// Size: 0x4c
function ondeath(attacker, weapon) {
    placeable = self;
    if (isdefined(placeable.ondeath)) {
        [[ placeable.ondeath ]](attacker, weapon);
    }
    placeable notify(#"cancelled");
}

// Namespace placeables
// Params 1, eflags: 0x0
// Checksum 0x9fe0ea72, Offset: 0xfe0
// Size: 0x38
function onemp(attacker) {
    placeable = self;
    if (isdefined(placeable.onemp)) {
        placeable [[ placeable.onemp ]](attacker);
    }
}

// Namespace placeables
// Params 1, eflags: 0x0
// Checksum 0xf1fe611b, Offset: 0x1020
// Size: 0x7c
function cancelonplayerdisconnect(placeable) {
    placeable endon(#"hacked");
    player = self;
    assert(isplayer(player));
    placeable endon(#"cancelled");
    placeable endon(#"death");
    player util::waittill_any("disconnect", "joined_team");
    placeable notify(#"cancelled");
}

// Namespace placeables
// Params 1, eflags: 0x0
// Checksum 0x4610022f, Offset: 0x10a8
// Size: 0x30
function cancelongameend(placeable) {
    placeable endon(#"cancelled");
    placeable endon(#"death");
    level waittill(#"game_ended");
    placeable notify(#"cancelled");
}

// Namespace placeables
// Params 2, eflags: 0x0
// Checksum 0xe09a1dfd, Offset: 0x10e0
// Size: 0xf2
function spawnmovetrigger(placeable, player) {
    pos = placeable.origin + (0, 0, 15);
    placeable.pickuptrigger = spawn("trigger_radius_use", pos);
    placeable.pickuptrigger setcursorhint("HINT_NOICON", placeable);
    placeable.pickuptrigger sethintstring(placeable.pickupstring);
    placeable.pickuptrigger setteamfortrigger(player.team);
    player clientclaimtrigger(placeable.pickuptrigger);
    placeable thread watchpickup(player);
    placeable.pickuptrigger thread watchmovetriggershutdown(placeable);
}

// Namespace placeables
// Params 1, eflags: 0x0
// Checksum 0xac309c10, Offset: 0x11e0
// Size: 0x62
function watchmovetriggershutdown(placeable) {
    trigger = self;
    placeable util::waittill_any("cancelled", "picked_up", "death", "delete_placeable_trigger", "hacker_delete_placeable_trigger");
    placeable.pickuptrigger delete();
}

// Namespace placeables
// Params 1, eflags: 0x0
// Checksum 0xc5219f41, Offset: 0x1250
// Size: 0x20f
function watchpickup(player) {
    placeable = self;
    placeable endon(#"death");
    placeable endon(#"cancelled");
    assert(isdefined(placeable.pickuptrigger));
    trigger = placeable.pickuptrigger;
    while (true) {
        trigger waittill(#"trigger", player);
        if (!isalive(player)) {
            continue;
        }
        if (player isusingoffhand()) {
            continue;
        }
        if (!player isonground()) {
            continue;
        }
        if (isdefined(trigger.triggerteam) && player.team != trigger.triggerteam) {
            continue;
        }
        if (isdefined(trigger.claimedby) && player != trigger.claimedby) {
            continue;
        }
        if (player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() && !player attackbuttonpressed() && !(isdefined(player.isplanting) && player.isplanting) && !(isdefined(player.isdefusing) && player.isdefusing) && !player isremotecontrolling() && !isdefined(player.holding_placeable)) {
            placeable notify(#"picked_up");
            placeable.held = 1;
            placeable setcandamage(0);
            assert(isdefined(placeable.onmove));
            player [[ placeable.onmove ]](placeable);
            player thread carryplaceable(placeable);
            return;
        }
    }
}

// Namespace placeables
// Params 0, eflags: 0x0
// Checksum 0x316fa1b4, Offset: 0x1468
// Size: 0x24
function forceshutdown() {
    placeable = self;
    placeable.cancelable = 0;
    placeable notify(#"cancelled");
}

// Namespace placeables
// Params 0, eflags: 0x0
// Checksum 0x7e5e6b7, Offset: 0x1498
// Size: 0x82
function watchownergameevents() {
    self notify(#"watchownergameevents_singleton");
    self endon(#"watchownergameevents_singleton");
    placeable = self;
    placeable endon(#"cancelled");
    placeable.owner util::waittill_any("joined_team", "disconnect", "joined_spectators");
    if (isdefined(placeable)) {
        placeable.abandoned = 1;
        placeable forceshutdown();
    }
}

// Namespace placeables
// Params 1, eflags: 0x0
// Checksum 0xb91150f7, Offset: 0x1528
// Size: 0x1ca
function shutdownoncancelevent(placeable) {
    placeable endon(#"hacked");
    player = self;
    assert(isplayer(player));
    placeable util::waittill_any("cancelled", "death");
    if (isdefined(player) && isdefined(placeable) && placeable.held === 1) {
        player sethintstring("");
        player stopcarryturret(placeable);
        if (!player util::function_31827fe8()) {
            player util::function_ee182f5d();
        }
    }
    if (isdefined(placeable)) {
        if (placeable.cancelable) {
            if (isdefined(placeable.oncancel)) {
                [[ placeable.oncancel ]](placeable);
            }
        } else if (isdefined(placeable.onshutdown)) {
            [[ placeable.onshutdown ]](placeable);
        }
        if (isdefined(placeable)) {
            if (isdefined(placeable.vehicle)) {
                var_87487fcc = placeable.vehicle;
                var_87487fcc.selfdestruct = 1;
                var_87487fcc kill();
                placeable.vehicle = undefined;
                placeable.othermodel delete();
                placeable delete();
                return;
            }
            placeable.othermodel delete();
            placeable delete();
        }
    }
}

