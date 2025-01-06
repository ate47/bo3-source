#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_ai_monkey;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/zm_temple_ai_monkey;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/zm_temple_sq_brock;

#namespace zm_temple_powerups;

// Namespace zm_temple_powerups
// Params 0, eflags: 0x0
// Checksum 0xfc4eec90, Offset: 0x388
// Size: 0x9e
function init() {
    level.var_a92d13f4 = &function_2eebf279;
    level._zombiemode_powerup_grab = &function_3542f800;
    zm_powerups::add_zombie_powerup("monkey_swarm", "zombie_pickup_monkey", %ZOMBIE_POWERUP_MONKEY_SWARM);
    level.playable_area = getentarray("player_volume", "script_noteworthy");
    level._effect["zombie_kill"] = "impacts/fx_flesh_hit_body_fatal_lg_exit_mp";
}

// Namespace zm_temple_powerups
// Params 1, eflags: 0x0
// Checksum 0x553d299f, Offset: 0x430
// Size: 0x10
function function_2eebf279(powerup) {
    return true;
}

// Namespace zm_temple_powerups
// Params 1, eflags: 0x0
// Checksum 0x78ff231, Offset: 0x448
// Size: 0x62
function function_3542f800(powerup) {
    if (!isdefined(powerup)) {
        return;
    }
    switch (powerup.powerup_name) {
    case "monkey_swarm":
        level thread monkey_swarm(powerup);
        break;
    default:
        break;
    }
}

// Namespace zm_temple_powerups
// Params 1, eflags: 0x0
// Checksum 0x331e8a12, Offset: 0x4b8
// Size: 0xfc
function monkey_swarm(powerup) {
    var_43f396a6 = 2;
    level flag::clear("spawn_zombies");
    players = getplayers();
    level.var_59e046cd = players.size * var_43f396a6;
    for (i = 0; i < players.size; i++) {
        players[i] thread function_ae946d1b(var_43f396a6);
    }
    while (level.var_59e046cd > 0) {
        util::wait_network_frame();
    }
    level flag::set("spawn_zombies");
}

// Namespace zm_temple_powerups
// Params 1, eflags: 0x0
// Checksum 0xbd35dde9, Offset: 0x5c0
// Size: 0x5ce
function function_ae946d1b(var_5fbde02b) {
    spawns = getentarray("monkey_zombie_spawner", "targetname");
    if (spawns.size == 0) {
        level.var_59e046cd -= var_5fbde02b;
        return;
    }
    spawnradius = 10;
    var_1b4b9af = undefined;
    if (isdefined(self.var_147b8776) && self.var_147b8776) {
        var_1b4b9af = "caves1_zone";
    } else if (isdefined(self.var_680ede5d) && self.var_680ede5d) {
        var_1b4b9af = "waterfall_lower_zone";
    }
    barriers = self zm_temple_ai_monkey::function_f593d568(var_1b4b9af);
    println("<dev string:x28>" + var_5fbde02b);
    for (i = 0; i < var_5fbde02b; i++) {
        wait randomfloatrange(1, 2);
        zombie = self function_b2850fe(300);
        if (!isdefined(zombie)) {
            zombie = self function_b2850fe();
        }
        var_85260145 = 0;
        angles = (0, randomfloat(360), 0);
        forward = anglestoforward(angles);
        spawnloc = self.origin + spawnradius * forward;
        spawnangles = self.angles;
        if (isdefined(zombie)) {
            spawnloc = zombie.origin + (0, 0, 50);
            spawnangles = zombie.angles;
            zombie delete();
            level.zombie_total++;
            var_85260145 = 1;
        } else if (barriers.size > 0) {
            best = undefined;
            bestdist = 0;
            for (b = 0; b < barriers.size; b++) {
                barrier = barriers[b];
                dist2 = distancesquared(barrier.origin, self.origin);
                if (!isdefined(best) || dist2 < bestdist) {
                    best = barrier;
                    bestdist = dist2;
                }
            }
            spawnloc = zm_temple_ai_monkey::function_2d0fbe55(best);
            spawnangles = best.angles;
        }
        level.var_59e046cd--;
        println("<dev string:x38>");
        monkey = zombie_utility::spawn_zombie(spawns[i]);
        if (spawner::spawn_failed(monkey)) {
            println("<dev string:x48>");
            continue;
        }
        spawns[i].count = 100;
        spawns[i].last_spawn_time = gettime();
        monkey.var_4bafe058 = 0;
        monkey.no_shrink = 1;
        monkey setplayercollision(0);
        monkey namespace_8fb880d9::function_fd927951();
        monkey forceteleport(spawnloc, spawnangles);
        if (var_85260145) {
            playfx(level._effect["zombie_kill"], spawnloc);
        }
        playfx(level._effect["monkey_death"], spawnloc);
        playsoundatposition("zmb_bolt", spawnloc);
        monkey util::magic_bullet_shield();
        monkey.allowpain = 0;
        monkey thread namespace_8fb880d9::function_602b3d53();
        monkey thread function_42449827();
        monkey thread function_c96b4d62(self);
    }
}

// Namespace zm_temple_powerups
// Params 0, eflags: 0x0
// Checksum 0xbccb8931, Offset: 0xb98
// Size: 0xbc
function function_42449827() {
    wait 60;
    self.timeout = 1;
    while (self.var_4bafe058) {
        wait 0.1;
    }
    if (isdefined(self.zombie)) {
        self.zombie.var_3dd9b5b4 = 0;
    }
    playfx(level._effect["monkey_death"], self.origin);
    playsoundatposition("zmb_bolt", self.origin);
    self notify(#"timeout");
    self delete();
}

// Namespace zm_temple_powerups
// Params 1, eflags: 0x0
// Checksum 0xacd17c8a, Offset: 0xc60
// Size: 0x1a0
function function_c96b4d62(player) {
    self endon(#"timeout");
    wait 0.5;
    while (true) {
        if (isdefined(self.timeout) && self.timeout) {
            self waittill(#"forever");
        }
        zombie = player function_b2850fe();
        if (isdefined(zombie)) {
            self thread function_6e41eda(zombie);
            self util::waittill_any("bad_path", "zombie_killed");
            if (isdefined(zombie)) {
                zombie.var_3dd9b5b4 = 0;
            }
        } else {
            goaldist = 64;
            checkdist2 = goaldist * goaldist;
            dist2 = distancesquared(self.origin, player.origin);
            if (dist2 > checkdist2) {
                self.goalradius = goaldist;
                self setgoalentity(player);
                self waittill(#"goal");
                self setgoalpos(self.origin);
            }
        }
        wait 0.5;
    }
}

// Namespace zm_temple_powerups
// Params 1, eflags: 0x0
// Checksum 0x6869a0f0, Offset: 0xe08
// Size: 0x292
function function_6e41eda(zombie) {
    self endon(#"bad_path");
    self endon(#"timeout");
    self.zombie = zombie;
    zombie.var_3dd9b5b4 = 1;
    self.goalradius = 32;
    self setgoalpos(zombie.origin);
    checkdist2 = self.goalradius * self.goalradius;
    while (true) {
        if (!isdefined(zombie) || !isalive(zombie)) {
            self notify(#"zombie_killed");
            return;
        }
        dist2 = distancesquared(zombie.origin, self.origin);
        if (dist2 < checkdist2) {
            break;
        }
        self setgoalpos(zombie.origin);
        util::wait_network_frame();
    }
    self.var_4bafe058 = 1;
    zombie notify(#"stop_find_flesh");
    forward = anglestoforward(zombie.angles);
    self.var_4bafe058 = 0;
    if (isdefined(zombie)) {
        zombie.no_powerups = 1;
        zombie.a.gib_ref = "head";
        zombie dodamage(zombie.health + 666, zombie.origin);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            players[i] zm_score::player_add_points("nuke_powerup", 20);
        }
    }
    self.zombie = undefined;
    self notify(#"zombie_killed");
}

// Namespace zm_temple_powerups
// Params 1, eflags: 0x0
// Checksum 0xe487a470, Offset: 0x10a8
// Size: 0x1ea
function function_b2850fe(mindist) {
    var_65865f59 = undefined;
    bestdist = 0;
    zombies = getaispeciesarray("axis", "all");
    if (isdefined(mindist)) {
        bestdist = mindist * mindist;
    } else {
        bestdist = 1e+08;
    }
    for (i = 0; i < zombies.size; i++) {
        z = zombies[i];
        if (isdefined(z.var_3dd9b5b4) && z.var_3dd9b5b4) {
            continue;
        }
        if (isdefined(z.animname) && z.animname == "monkey_zombie") {
            continue;
        }
        if (z.classname == "actor_zombie_napalm" || z.classname == "actor_zombie_sonic") {
            continue;
        }
        dist2 = distancesquared(z.origin, self.origin);
        if (dist2 < bestdist) {
            valid = z function_26bf3c6a();
            if (valid) {
                var_65865f59 = z;
                bestdist = dist2;
            }
        }
    }
    return var_65865f59;
}

// Namespace zm_temple_powerups
// Params 0, eflags: 0x0
// Checksum 0x7dbf2ba2, Offset: 0x12a0
// Size: 0x58
function function_26bf3c6a() {
    for (i = 0; i < level.playable_area.size; i++) {
        if (self istouching(level.playable_area[i])) {
            return true;
        }
    }
    return false;
}

