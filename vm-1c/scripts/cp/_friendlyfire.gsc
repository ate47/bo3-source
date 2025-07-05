#using scripts/cp/_util;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/callbacks_shared;
#using scripts/shared/load_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace friendlyfire;

// Namespace friendlyfire
// Params 0, eflags: 0x2
// Checksum 0x8f431ea0, Offset: 0x308
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("friendlyfire", &__init__, undefined, undefined);
}

// Namespace friendlyfire
// Params 0, eflags: 0x0
// Checksum 0x5bcd9dae, Offset: 0x348
// Size: 0x10c
function __init__() {
    level.var_4d4e553d["min_participation"] = -1600;
    level.var_4d4e553d["max_participation"] = 1000;
    level.var_4d4e553d["enemy_kill_points"] = -6;
    level.var_4d4e553d["friend_kill_points"] = -600;
    level.var_4d4e553d["civ_kill_points"] = -900;
    level.var_4d4e553d["point_loss_interval"] = 0.75;
    level.var_8300d543 = 1;
    if (util::coopgame()) {
        setdvar("friendlyfire_enabled", "0");
    }
    if (!isdefined(level.friendlyfiredisabled)) {
        level.friendlyfiredisabled = 0;
    }
    callback::on_connect(&init_player);
}

// Namespace friendlyfire
// Params 0, eflags: 0x0
// Checksum 0xb679ea8b, Offset: 0x460
// Size: 0x5c
function init_player() {
    assert(isdefined(self), "<dev string:x28>");
    self.participation = 0;
    self thread debug_friendlyfire();
    self thread participation_point_flattenovertime();
}

// Namespace friendlyfire
// Params 1, eflags: 0x0
// Checksum 0x87f3e56, Offset: 0x4c8
// Size: 0x94
function function_8e961e39(msg) {
    /#
        if (getdvarstring("<dev string:x3c>") == "<dev string:x4f>") {
            iprintlnbold(msg);
        }
        if (getdvarstring("<dev string:x52>") == "<dev string:x4f>") {
            println("<dev string:x69>" + msg);
        }
    #/
}

// Namespace friendlyfire
// Params 0, eflags: 0x0
// Checksum 0xe91b0691, Offset: 0x568
// Size: 0xce8
function debug_friendlyfire() {
    self endon(#"hash_cca1b1b9");
    /#
        self endon(#"disconnect");
        if (getdvarstring("<dev string:x3c>") == "<dev string:x79>") {
            setdvar("<dev string:x3c>", "<dev string:x7a>");
        }
        if (getdvarstring("<dev string:x52>") == "<dev string:x79>") {
            setdvar("<dev string:x52>", "<dev string:x7a>");
        }
        var_a4c398c5 = level.var_4d4e553d["<dev string:x7e>"] - level.var_4d4e553d["<dev string:x90>"];
        var_db33b685 = 520;
        var_97e29ff = 620;
        ypos = -126;
        bar_width = var_97e29ff - var_db33b685;
        friendly_fire = newdebughudelem();
        friendly_fire.fontscale = 3;
        friendly_fire.alignx = "<dev string:xa2>";
        friendly_fire.aligny = "<dev string:xa8>";
        friendly_fire.x = var_97e29ff - bar_width * level.var_4d4e553d["<dev string:x7e>"] / var_a4c398c5 - log(self.participation) * friendly_fire.fontscale;
        friendly_fire.y = 100;
        friendly_fire.alpha = 1;
        var_9234aec3 = newdebughudelem();
        var_9234aec3.fontscale = 1.5;
        var_9234aec3.alignx = "<dev string:xa2>";
        var_9234aec3.aligny = "<dev string:xa8>";
        var_9234aec3.x = var_db33b685 - (ceil(max(log(abs(level.var_4d4e553d["<dev string:x90>"])) / log(10), 0)) - 2 + (self.participation < 0)) * friendly_fire.fontscale;
        var_9234aec3.y = ypos;
        var_9234aec3.alpha = 1;
        var_9234aec3 setvalue(level.var_4d4e553d["<dev string:x90>"]);
        var_edb99954 = newdebughudelem();
        var_edb99954.fontscale = 1.5;
        var_edb99954.alignx = "<dev string:xa2>";
        var_edb99954.aligny = "<dev string:xa8>";
        var_edb99954.x = var_97e29ff + 2 * (ceil(max(log(abs(level.var_4d4e553d["<dev string:x7e>"])) / log(10), 0)) + 2.5 + (self.participation < 0)) * friendly_fire.fontscale;
        var_edb99954.y = ypos;
        var_edb99954.alpha = 1;
        var_edb99954 setvalue(level.var_4d4e553d["<dev string:x7e>"]);
        var_4327ab81 = newclienthudelem(self);
        var_4327ab81.alignx = "<dev string:xa2>";
        var_4327ab81.aligny = "<dev string:xa8>";
        var_4327ab81.x = var_97e29ff;
        var_4327ab81.y = ypos;
        var_4327ab81.sort = 1;
        var_4327ab81.alpha = 1;
        var_4327ab81.foreground = 1;
        var_4327ab81.color = (0.4, 0.4, 0.4);
        var_4327ab81 setshader("<dev string:xaf>", bar_width, 9);
        debug_health_bar = newclienthudelem(self);
        debug_health_bar.alignx = "<dev string:xa2>";
        debug_health_bar.aligny = "<dev string:xa8>";
        debug_health_bar.x = 620;
        debug_health_bar.y = ypos;
        debug_health_bar.sort = 4;
        debug_health_bar.alpha = 1;
        debug_health_bar.foreground = 1;
        debug_health_bar.color = (0, 0, 0.9);
        debug_health_bar setshader("<dev string:xaf>", 4, 15);
        var_4c91c06 = newclienthudelem(self);
        var_4c91c06.alignx = "<dev string:xa2>";
        var_4c91c06.aligny = "<dev string:xa8>";
        var_4c91c06.x = var_db33b685;
        var_4c91c06.y = ypos;
        var_4c91c06.sort = 2;
        var_4c91c06.alpha = 1;
        var_4c91c06.foreground = 1;
        var_4c91c06 setshader("<dev string:xb5>", 4, 21);
        var_8ff245f7 = newclienthudelem(self);
        var_8ff245f7.alignx = "<dev string:xa2>";
        var_8ff245f7.aligny = "<dev string:xa8>";
        var_8ff245f7.x = var_97e29ff;
        var_8ff245f7.y = ypos;
        var_8ff245f7.sort = 2;
        var_8ff245f7.alpha = 1;
        var_8ff245f7.foreground = 1;
        var_8ff245f7 setshader("<dev string:xb5>", 4, 21);
        var_d2572fe4 = newclienthudelem(self);
        var_d2572fe4.alignx = "<dev string:xa2>";
        var_d2572fe4.aligny = "<dev string:xa8>";
        var_d2572fe4.x = var_db33b685 + level.var_4d4e553d["<dev string:x90>"] * -1 / var_a4c398c5 * bar_width;
        var_d2572fe4.y = ypos + 9;
        var_d2572fe4.sort = 2;
        var_d2572fe4.alpha = 1;
        var_d2572fe4.foreground = 1;
        var_d2572fe4 setshader("<dev string:xb5>", 4, 4);
        var_5c31876e = newclienthudelem(self);
        var_5c31876e.alignx = "<dev string:xa2>";
        var_5c31876e.aligny = "<dev string:xa8>";
        var_5c31876e.x = var_db33b685 + level.var_4d4e553d["<dev string:x90>"] * -1 / var_a4c398c5 * bar_width;
        var_5c31876e.y = ypos - 9;
        var_5c31876e.sort = 2;
        var_5c31876e.alpha = 1;
        var_5c31876e.foreground = 1;
        var_5c31876e setshader("<dev string:xb5>", 4, 4);
        for (;;) {
            if (getdvarstring("<dev string:x3c>") == "<dev string:x4f>") {
                friendly_fire.alpha = 1;
                var_9234aec3.alpha = 1;
                var_edb99954.alpha = 1;
                var_4327ab81.alpha = 1;
                debug_health_bar.alpha = 1;
                var_4c91c06.alpha = 1;
                var_8ff245f7.alpha = 1;
                var_d2572fe4.alpha = 1;
                var_5c31876e.alpha = 1;
            } else {
                friendly_fire.alpha = 0;
                var_9234aec3.alpha = 0;
                var_edb99954.alpha = 0;
                var_4327ab81.alpha = 0;
                debug_health_bar.alpha = 0;
                var_4c91c06.alpha = 0;
                var_8ff245f7.alpha = 0;
                var_d2572fe4.alpha = 0;
                var_5c31876e.alpha = 0;
            }
            xpos = (level.var_4d4e553d["<dev string:x7e>"] - self.participation) / var_a4c398c5 * bar_width;
            debug_health_bar.x = var_97e29ff - xpos;
            friendly_fire setvalue(self.participation);
            friendly_fire.x = var_97e29ff - bar_width * level.var_4d4e553d["<dev string:x7e>"] / var_a4c398c5 + (ceil(max(log(abs(self.participation)) / log(10), 0)) + 1 + (self.participation < 0)) * friendly_fire.fontscale * 2;
            wait 0.25;
        }
    #/
}

// Namespace friendlyfire
// Params 1, eflags: 0x0
// Checksum 0x6a1c25f3, Offset: 0x1258
// Size: 0x3e
function function_b74e3e5b(entity) {
    if (entity.archetype == "warlord_soldier") {
        return (entity.shieldhealth <= 0);
    }
    return false;
}

// Namespace friendlyfire
// Params 4, eflags: 0x0
// Checksum 0x3dd72d5a, Offset: 0x12a0
// Size: 0x5a4
function function_36510feb(entity, damage, attacker, method) {
    if (!isdefined(entity)) {
        return;
    }
    if (!isdefined(entity.team)) {
        entity.team = "allies";
    }
    if (!isdefined(entity)) {
        return;
    }
    var_c288fcaa = function_b74e3e5b(entity);
    if (entity.health <= 0) {
        if (!var_c288fcaa) {
            return;
        }
    }
    if (level.friendlyfiredisabled) {
        return;
    }
    if (isdefined(entity.nofriendlyfire) && entity.nofriendlyfire) {
        return;
    }
    if (!isdefined(attacker)) {
        return;
    }
    var_95f4f36a = 0;
    if (isplayer(attacker)) {
        var_95f4f36a = 1;
    } else if (isdefined(attacker.classname) && attacker.classname == "script_vehicle") {
        owner = attacker getvehicleowner();
        if (isdefined(owner)) {
            if (isplayer(owner)) {
                if (!isdefined(owner.var_3659fa11)) {
                    var_95f4f36a = 1;
                    attacker = owner;
                }
            }
        }
    }
    if (!var_95f4f36a) {
        return;
    }
    same_team = entity.team == attacker.team;
    if (attacker.team == "allies") {
        if (entity.team == "neutral" && !(isdefined(level.var_5dcc7f9) && level.var_5dcc7f9)) {
            same_team = 1;
        }
    }
    if (entity.team == "neutral" && (entity.team != "neutral" || !(isdefined(level.var_5dcc7f9) && level.var_5dcc7f9))) {
        attacker.var_93d35b85 = entity.team;
    }
    killed = damage >= entity.health || var_c288fcaa;
    if (!entity.allowdeath) {
        killed = 0;
    }
    if (!same_team) {
        if (killed) {
            attacker.participation += level.var_4d4e553d["enemy_kill_points"];
            attacker participation_point_cap();
            function_8e961e39("Enemy killed: +" + level.var_4d4e553d["enemy_kill_points"]);
        }
        return;
    }
    if (isdefined(entity.var_bb4f67f3)) {
        return;
    }
    if (killed) {
        if (entity.team == "neutral") {
            level notify(#"hash_b3760d31");
            attacker.participation += level.var_4d4e553d["civ_kill_points"];
            function_8e961e39("Civilian killed: -" + 0 - level.var_4d4e553d["civ_kill_points"]);
        } else if (isdefined(entity) && isdefined(entity.var_64f2c3c2)) {
            attacker.participation += entity.var_64f2c3c2;
            function_8e961e39("Friendly killed with custom penalty: -" + 0 - entity.var_64f2c3c2);
        } else {
            attacker.participation += level.var_4d4e553d["friend_kill_points"];
            function_8e961e39("Friendly killed: -" + 0 - level.var_4d4e553d["friend_kill_points"]);
        }
    } else {
        attacker.participation -= damage;
        function_8e961e39("Friendly hurt: -" + damage);
    }
    attacker participation_point_cap();
    if (check_grenade(entity, method) && savecommit_aftergrenade()) {
        return;
    }
    attacker friendly_fire_checkpoints();
}

// Namespace friendlyfire
// Params 1, eflags: 0x0
// Checksum 0x30087afe, Offset: 0x1850
// Size: 0x610
function friendly_fire_think(entity) {
    level endon(#"hash_77e184");
    entity endon(#"hash_37b92239");
    if (!isdefined(entity)) {
        return;
    }
    if (!isdefined(entity.team)) {
        entity.team = "allies";
    }
    for (;;) {
        if (!isdefined(entity)) {
            return;
        }
        entity waittill(#"damage", damage, attacker, _, _, method);
        if (level.friendlyfiredisabled) {
            continue;
        }
        if (!isdefined(entity)) {
            return;
        }
        if (isdefined(entity.nofriendlyfire) && entity.nofriendlyfire) {
            continue;
        }
        if (!isdefined(attacker)) {
            continue;
        }
        var_95f4f36a = 0;
        if (isplayer(attacker)) {
            var_95f4f36a = 1;
        } else if (isdefined(attacker.classname) && attacker.classname == "script_vehicle") {
            owner = attacker getvehicleowner();
            if (isdefined(owner)) {
                if (isplayer(owner)) {
                    if (!isdefined(owner.var_3659fa11)) {
                        var_95f4f36a = 1;
                        attacker = owner;
                    }
                }
            }
        }
        if (!var_95f4f36a) {
            continue;
        }
        same_team = entity.team == attacker.team;
        if (attacker.team == "allies") {
            if (entity.team == "neutral" && !(isdefined(level.var_5dcc7f9) && level.var_5dcc7f9)) {
                same_team = 1;
            }
        }
        if (entity.team == "neutral" && (entity.team != "neutral" || !(isdefined(level.var_5dcc7f9) && level.var_5dcc7f9))) {
            attacker.var_93d35b85 = entity.team;
        }
        killed = damage >= entity.health;
        if (!same_team) {
            if (killed) {
                attacker.participation += level.var_4d4e553d["enemy_kill_points"];
                attacker participation_point_cap();
                function_8e961e39("Enemy killed: +" + level.var_4d4e553d["enemy_kill_points"]);
            }
            return;
        }
        if (isdefined(entity.var_bb4f67f3)) {
            continue;
        }
        if (killed) {
            if (entity.team == "neutral") {
                level notify(#"hash_b3760d31");
                if (attacker.participation <= 0) {
                    attacker.participation += level.var_4d4e553d["min_participation"];
                    function_8e961e39("Civilian killed with negative score, autofail!");
                } else {
                    attacker.participation += level.var_4d4e553d["civ_kill_points"];
                    function_8e961e39("Civilian killed: -" + 0 - level.var_4d4e553d["civ_kill_points"]);
                }
            } else if (isdefined(entity) && isdefined(entity.var_64f2c3c2)) {
                attacker.participation += entity.var_64f2c3c2;
                function_8e961e39("Friendly killed with custom penalty: -" + 0 - entity.var_64f2c3c2);
            } else {
                attacker.participation += level.var_4d4e553d["friend_kill_points"];
                function_8e961e39("Friendly killed: -" + 0 - level.var_4d4e553d["friend_kill_points"]);
            }
        } else {
            attacker.participation -= damage;
            function_8e961e39("Friendly hurt: -" + damage);
        }
        attacker participation_point_cap();
        if (check_grenade(entity, method) && savecommit_aftergrenade()) {
            if (killed) {
                return;
            }
            continue;
        }
        attacker friendly_fire_checkpoints();
    }
}

// Namespace friendlyfire
// Params 0, eflags: 0x0
// Checksum 0x3fca0fb4, Offset: 0x1e68
// Size: 0x34
function friendly_fire_checkpoints() {
    if (self.participation <= level.var_4d4e553d["min_participation"]) {
        self thread missionfail();
    }
}

// Namespace friendlyfire
// Params 2, eflags: 0x0
// Checksum 0xcf582966, Offset: 0x1ea8
// Size: 0x9a
function check_grenade(entity, method) {
    if (!isdefined(entity)) {
        return 0;
    }
    var_99b0802 = 0;
    if (isdefined(entity.damageweapon) && entity.damageweapon.name == "none") {
        var_99b0802 = 1;
    }
    if (isdefined(method) && method == "MOD_GRENADE_SPLASH") {
        var_99b0802 = 1;
    }
    return var_99b0802;
}

// Namespace friendlyfire
// Params 0, eflags: 0x0
// Checksum 0x707086bb, Offset: 0x1f50
// Size: 0x44
function savecommit_aftergrenade() {
    currenttime = gettime();
    if (currenttime < 4500) {
        println("<dev string:xbb>");
        return true;
    }
    return false;
}

// Namespace friendlyfire
// Params 0, eflags: 0x0
// Checksum 0x84e6f7e5, Offset: 0x1fa0
// Size: 0xa0
function participation_point_cap() {
    if (!isdefined(self.participation)) {
        assertmsg("<dev string:x124>");
        return;
    }
    if (self.participation > level.var_4d4e553d["max_participation"]) {
        self.participation = level.var_4d4e553d["max_participation"];
    }
    if (self.participation < level.var_4d4e553d["min_participation"]) {
        self.participation = level.var_4d4e553d["min_participation"];
    }
}

// Namespace friendlyfire
// Params 0, eflags: 0x0
// Checksum 0xbf157873, Offset: 0x2048
// Size: 0x66
function participation_point_flattenovertime() {
    level endon(#"hash_99f182f3");
    self endon(#"disconnect");
    for (;;) {
        if (self.participation > 0) {
            self.participation--;
        } else if (self.participation < 0) {
            self.participation++;
        }
        wait level.var_4d4e553d["point_loss_interval"];
    }
}

// Namespace friendlyfire
// Params 0, eflags: 0x0
// Checksum 0x51d81f6d, Offset: 0x20b8
// Size: 0x10
function turnbackon() {
    level.friendlyfiredisabled = 0;
}

// Namespace friendlyfire
// Params 0, eflags: 0x0
// Checksum 0x1265aa88, Offset: 0x20d0
// Size: 0x10
function turnoff() {
    level.friendlyfiredisabled = 1;
}

// Namespace friendlyfire
// Params 0, eflags: 0x0
// Checksum 0xc7fd51ff, Offset: 0x20e8
// Size: 0x8c
function missionfail() {
    self endon(#"death");
    level endon(#"hash_1078e68a");
    self.participation = 0;
    self.lives = 0;
    if (self.var_93d35b85 === "neutral") {
        util::function_207f8667(%SCRIPT_MISSIONFAIL_KILLTEAM_NEUTRAL, %SCRIPT_MISSIONFAIL_WATCH_FIRE);
        return;
    }
    util::function_207f8667(%SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN, %SCRIPT_MISSIONFAIL_WATCH_FIRE);
}

// Namespace friendlyfire
// Params 1, eflags: 0x0
// Checksum 0x58ad3d55, Offset: 0x2180
// Size: 0x7c
function notifydamage(entity) {
    level endon(#"hash_77e184");
    entity endon(#"death");
    for (;;) {
        entity waittill(#"damage", damage, attacker, _, _, method);
        entity notify(#"friendlyfire_notify", damage, attacker, undefined, undefined, method);
    }
}

// Namespace friendlyfire
// Params 1, eflags: 0x0
// Checksum 0xd2f3d1c0, Offset: 0x2208
// Size: 0x6c
function notifydamagenotdone(entity) {
    level endon(#"hash_77e184");
    entity waittill(#"damage_notdone", damage, attacker, _, _, method);
    entity notify(#"friendlyfire_notify", -1, attacker, undefined, undefined, method);
}

// Namespace friendlyfire
// Params 1, eflags: 0x0
// Checksum 0x37a32e72, Offset: 0x2280
// Size: 0x5c
function notifydeath(entity) {
    level endon(#"hash_77e184");
    entity waittill(#"death", attacker, method);
    entity notify(#"friendlyfire_notify", -1, attacker, undefined, undefined, method);
}

