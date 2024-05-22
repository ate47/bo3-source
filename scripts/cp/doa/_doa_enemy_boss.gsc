#using scripts/cp/cp_doa_bo3_enemy;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

// Can't decompile export namespace_4973e019::function_555608c7

// Can't decompile export namespace_4973e019::function_ce73145c

#namespace namespace_4973e019;

// Namespace namespace_4973e019
// Params 0, eflags: 0x1 linked
// Checksum 0x6e375a1d, Offset: 0x488
// Size: 0x6c
function init() {
    level.doa.var_55dddb3a = getent("doa_silverback_spawner", "targetname");
    if (isdefined(level.doa.var_55dddb3a)) {
        level thread function_d95d34bd(level.doa.var_55dddb3a);
    }
}

// Namespace namespace_4973e019
// Params 1, eflags: 0x5 linked
// Checksum 0x889a2704, Offset: 0x500
// Size: 0x4a4
function function_d95d34bd(spawner) {
    level notify(#"hash_d95d34bd");
    level endon(#"hash_d95d34bd");
    while (true) {
        level waittill(#"hash_31b5dd0d");
        if (!getdvarint("scr_boss_force_spawn", 0)) {
            if (level.doa.round_number < level.doa.rules.var_cd6c242e) {
                continue;
            }
            if (randomint(100) > level.doa.var_4714c375) {
                level.doa.var_4714c375 += 5;
                continue;
            }
            level.doa.var_4714c375 = level.doa.rules.var_ca8dc008;
            if (isdefined(level.doa.var_c03fe5f1)) {
                if (!namespace_3ca3c537::function_85c94f67(level.doa.var_c03fe5f1)) {
                    continue;
                }
            }
        }
        var_a47b1f6f = level.doa.arenas[level.doa.var_90873830].name + "_enemy_spawn";
        if (level.doa.spawners[var_a47b1f6f]["boss"].size == 0) {
            continue;
        }
        loc = level.doa.spawners[var_a47b1f6f]["boss"][randomint(level.doa.spawners[var_a47b1f6f]["boss"].size)];
        level.doa.boss = namespace_51bd792::function_36aa8b6c(loc);
        if (getdvarint("scr_boss_debug", 0) && isdefined(spawner)) {
            level thread namespace_2f63e553::function_5e6b8376(spawner.origin, 20, 500, (0, 0, 1));
        }
        if (isdefined(level.doa.boss)) {
            level.doa.boss.takedamage = 0;
            level.doa.boss.ignoreall = 1;
            level.doa.boss.ignoreme = 1;
            level.doa.boss.goalradius = 64;
            level.doa.boss.goalheight = 256;
            level.doa.boss thread namespace_eaa992c::function_285a2999("red_shield");
            level.doa.boss thread function_ce73145c();
            level.doa.boss thread function_5bd24aae();
            level.doa.boss thread function_e5e28b1b();
            level.doa.boss thread function_555608c7();
            level.doa.boss.var_f1eeb152 = getclosestpointonnavmesh(level.doa.boss.origin, 512);
            waittillframeend();
            level.doa.boss function_a2756e92();
            if (!isdefined(level.doa.boss)) {
                continue;
            }
            level.doa.boss thread function_2ca4656();
            level.doa.boss thread function_66efd1eb();
        }
        level waittill(#"exit_taken");
    }
}

// Namespace namespace_4973e019
// Params 1, eflags: 0x5 linked
// Checksum 0x3e01cd2c, Offset: 0xe10
// Size: 0x2c
function function_4e81959(waittime) {
    self endon(#"death");
    wait(waittime);
    self.zombie_move_speed = "sprint";
}

// Namespace namespace_4973e019
// Params 0, eflags: 0x5 linked
// Checksum 0x126ad4fb, Offset: 0xe48
// Size: 0x154
function function_a2756e92() {
    self endon(#"death");
    self notify(#"hash_d96c599c");
    self thread namespace_1a381543::function_90118d8c("zmb_simianaut_roar");
    self.var_88168473 = 1;
    self.zombie_move_speed = "walk";
    self.var_f4a5c4fe = namespace_a7e6beb5::function_ac410a13().origin;
    if (isdefined(self.var_f4a5c4fe)) {
        self setgoal(self.var_f4a5c4fe, 1);
    }
    if (getdvarint("scr_boss_debug", 0)) {
        level thread namespace_2f63e553::function_5e6b8376(self.var_f4a5c4fe, -128, 0.5, (1, 0, 0));
    }
    self util::waittill_any_timeout(14, "goal", "damage", "death");
    self.var_88168473 = undefined;
    self.zombie_move_speed = "run";
    self thread function_4e81959(20);
}

// Namespace namespace_4973e019
// Params 0, eflags: 0x5 linked
// Checksum 0x7b38ad91, Offset: 0x12c8
// Size: 0x330
function function_66efd1eb() {
    self endon(#"death");
    self endon(#"hash_19503b17");
    while (isdefined(self)) {
        wait(0.05);
        if (isdefined(self.var_faa677d7)) {
            if (gettime() < self.var_faa677d7) {
                continue;
            }
        }
        self.ignoreall = 1;
        self.favoriteenemy = undefined;
        self clearentitytarget();
        if (isdefined(level.hostmigrationtimer) && level.hostmigrationtimer) {
            continue;
        }
        allies = arraycombine(getaiteamarray("allies"), namespace_831a4a7c::function_5eb6e4d1(), 0, 0);
        for (i = 0; i < allies.size; i++) {
            player = allies[i];
            if (!isdefined(player) || !isalive(player)) {
                continue;
            }
            if (isplayer(player) && isdefined(player.doa.var_1db1e638) && gettime() < player.doa.var_1db1e638) {
                continue;
            }
            if (isdefined(player.doa.respawning) && isplayer(player) && player.doa.respawning) {
                continue;
            }
            if (isdefined(player.vehicle)) {
                continue;
            }
            distsq = distancesquared(self.origin, player.origin);
            if (distsq <= -128 * -128) {
                self.ignoreall = 0;
                if (getdvarint("scr_boss_debug", 0)) {
                    level thread namespace_2f63e553::function_5e6b8376(self.origin, 100, 0.5, (1, 0, 0));
                }
                wait(0.5);
                break;
            }
        }
        if (getdvarint("scr_boss_debug", 0)) {
            level thread namespace_2f63e553::function_5e6b8376(self.origin, -128, 500, (1, 0.8, 0.8));
            level thread namespace_2f63e553::function_5e6b8376(self.origin, 32, 0.05, (0, 1, 0));
        }
    }
}

// Namespace namespace_4973e019
// Params 0, eflags: 0x5 linked
// Checksum 0x44bc310e, Offset: 0x1600
// Size: 0x6c
function function_5bd24aae() {
    self endon(#"death");
    level waittill(#"exit_taken");
    level notify(#"hash_48b870e4");
    level.doa.boss = undefined;
    level namespace_49107f3a::function_d0e32ad0(1);
    self delete();
}

// Namespace namespace_4973e019
// Params 0, eflags: 0x5 linked
// Checksum 0x96f403e1, Offset: 0x1678
// Size: 0x69c
function function_2ca4656() {
    self endon(#"death");
    wait(0.1);
    timeout = gettime() + 10000;
    while (isdefined(self.var_88168473) && self.var_88168473 && gettime() < timeout) {
        wait(0.05);
    }
    tries = 5;
    for (failed = 0; tries; failed = 1) {
        wait(0.05);
        if (self.ignoreall == 0) {
            wait(1);
            tries--;
            continue;
        }
        if (failed) {
            tries--;
        }
        items = getentarray("a_pickup_item", "script_noteworthy");
        var_6792dc08 = [];
        foreach (item in items) {
            if (!isdefined(item)) {
                continue;
            }
            if (isdefined(item.unreachable) && item.unreachable) {
                continue;
            }
            var_6792dc08[var_6792dc08.size] = item;
        }
        if (failed && var_6792dc08.size > 0) {
            target = var_6792dc08[randomint(var_6792dc08.size)];
        } else {
            target = self namespace_49107f3a::function_1bfb2259(var_6792dc08);
        }
        failed = 0;
        if (isdefined(target)) {
            spot = getclosestpointonnavmesh(target.origin, 512, 36);
            if (isdefined(spot) && self findpath(self.origin, spot, 1, 0)) {
                self.var_f4a5c4fe = spot;
                self setgoal(self.var_f4a5c4fe, 1);
                if (getdvarint("scr_boss_debug", 0)) {
                    level thread namespace_2f63e553::function_5e6b8376(target.origin, 32, 500, (1, 1, 0));
                }
                self util::waittill_any_timeout(10, "goal", "death");
                self.var_f4a5c4fe = undefined;
                if (isdefined(target)) {
                    target.unreachable = 1;
                }
            } else {
                failed = 1;
            }
            continue;
        }
    }
    self notify(#"hash_19503b17");
    self.var_88168473 = 1;
    self.zombie_move_speed = "sprint";
    self.ignoreall = 1;
    self.favoriteenemy = undefined;
    self clearentitytarget();
    self.var_f4a5c4fe = self.var_f1eeb152;
    tries = 0;
    while (isdefined(self.var_f4a5c4fe) && self findpath(self.origin, self.var_f4a5c4fe, 1, 0)) {
        distsq = distancesquared(self.origin, self.var_f1eeb152);
        if (distsq > 64 || tries > 9) {
            self setgoal(self.var_f4a5c4fe, 1);
            self waittill(#"goal");
            self.var_f4a5c4fe = self.var_f1eeb152;
            tries++;
            continue;
        }
        break;
    }
    if (isdefined(self.var_f1eeb152)) {
        distsq = distancesquared(self.origin, self.var_f1eeb152);
    }
    if (!isdefined(distsq) || distsq > 64) {
        org = spawn("script_model", self.origin);
        org thread namespace_49107f3a::function_981c685d(self);
        org.targetname = "_doaBossCollectPickups";
        org setmodel("tag_origin");
        self linkto(org, "tag_origin");
        org thread namespace_eaa992c::function_285a2999("boss_takeoff");
        spot = self.origin + (0, 0, 2000);
        org thread namespace_49107f3a::function_a98c85b2(spot, 0.8);
        self util::waittill_any_timeout(2, "movedone", "death");
        org delete();
    }
    if (isdefined(level.doa.var_2836c8ee) && level.doa.var_2836c8ee) {
        self thread namespace_eaa992c::function_285a2999("spawnZombie");
        wait(1);
    }
    self delete();
}

// Namespace namespace_4973e019
// Params 0, eflags: 0x5 linked
// Checksum 0x924bab, Offset: 0x1d20
// Size: 0xfc
function function_e5e28b1b() {
    self endon(#"death");
    while (true) {
        var_6792dc08 = getentarray("a_pickup_item", "script_noteworthy");
        for (i = 0; i < var_6792dc08.size; i++) {
            pickup = var_6792dc08[i];
            if (isdefined(pickup)) {
                distsq = distancesquared(self.origin, pickup.origin);
                if (distsq < 72 * 72) {
                    pickup thread namespace_a7e6beb5::function_6b4a5f81();
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_4973e019
// Params 0, eflags: 0x1 linked
// Checksum 0x83fcddb2, Offset: 0x1e28
// Size: 0x6a
function function_76b30cc1() {
    self endon(#"death");
    amount = int(self.health * 0.15);
    while (self.health > 0) {
        wait(3);
        self notify(#"damage", amount);
    }
}

