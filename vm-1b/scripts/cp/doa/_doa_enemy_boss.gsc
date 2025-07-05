#using scripts/codescripts/struct;
#using scripts/cp/cp_doa_bo3_enemy;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;

#using_animtree("generic");

#namespace DOA_BOSS;

// Namespace DOA_BOSS
// Params 0, eflags: 0x0
// Checksum 0xe0673731, Offset: 0x478
// Size: 0x62
function init() {
    level.doa.var_55dddb3a = getent("doa_silverback_spawner", "targetname");
    if (isdefined(level.doa.var_55dddb3a)) {
        level thread function_d95d34bd(level.doa.var_55dddb3a);
    }
}

// Namespace DOA_BOSS
// Params 1, eflags: 0x4
// Checksum 0xbb9e55c8, Offset: 0x4e8
// Size: 0x42f
function private function_d95d34bd(spawner) {
    level notify(#"hash_d95d34bd");
    level endon(#"hash_d95d34bd");
    while (true) {
        level waittill(#"opening_exits");
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
        spawn_set = level.doa.arenas[level.doa.var_90873830].name + "_enemy_spawn";
        if (level.doa.spawners[spawn_set]["boss"].size == 0) {
            continue;
        }
        loc = level.doa.spawners[spawn_set]["boss"][randomint(level.doa.spawners[spawn_set]["boss"].size)];
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
            level.doa.boss thread _doaBossDamageShield();
            level.doa.boss thread function_5bd24aae();
            level.doa.boss thread function_e5e28b1b();
            level.doa.boss thread function_555608c7();
            level.doa.boss.var_f1eeb152 = getclosestpointonnavmesh(level.doa.boss.origin, 512);
            waittillframeend();
            level.doa.boss function_a2756e92();
            if (!isdefined(level.doa.boss)) {
                continue;
            }
            level.doa.boss thread _doaBossCollectPickups();
            level.doa.boss thread function_66efd1eb();
        }
        level waittill(#"exit_taken");
    }
}

// Namespace DOA_BOSS
// Params 0, eflags: 0x4
// Checksum 0x8911acc1, Offset: 0x920
// Size: 0x38d
function private function_555608c7() {
    self endon(#"death");
    level.doa.boss.takedamage = 1;
    while (true) {
        self waittill(#"damage", amount, attacker);
        if (isdefined(attacker) && isplayer(attacker)) {
            break;
        }
    }
    self thread namespace_1a381543::function_90118d8c("zmb_simianaut_roar");
    self.health = 999999;
    level.doa.boss.takedamage = 0;
    waittillframeend();
    self clearforcedgoal();
    self clearpath();
    self setgoal(self.origin, 1);
    self.var_88168473 = 1;
    if (isdefined(attacker) && isplayer(attacker)) {
        self.ignoreall = 0;
        self.favoriteenemy = attacker;
        self setentitytarget(attacker);
        self orientmode("face enemy");
    }
    self.anchor = spawn("script_origin", self.origin);
    self.anchor thread namespace_49107f3a::function_981c685d(self);
    self.anchor.angles = self.angles;
    self linkto(self.anchor);
    anim_ang = vectortoangles(attacker.origin - self.origin);
    self.anchor rotateto((0, anim_ang[1], 0), 0.5);
    self.anchor waittill(#"rotatedone");
    self thread namespace_1a381543::function_90118d8c("zmb_simianaut_roar");
    self forceteleport(self.origin, (0, anim_ang[1], 0));
    self unlink();
    self orientmode("face enemy");
    self animscripted("pissedoff", self.origin, self.angles, "ai_zombie_doa_simianaut_ground_pound");
    self waittillmatch(#"pissedoff", "zombie_melee");
    playfx(level._effect["ground_pound"], self.origin);
    self waittillmatch(#"pissedoff", "end");
    self.anchor delete();
    self.var_faa677d7 = gettime() + 10000;
    self thread namespace_1a381543::function_90118d8c("zmb_simianaut_roar");
    self.zombie_move_speed = "run";
    if (isdefined(attacker) && isplayer(attacker)) {
        self setgoal(attacker.origin, 1);
        self.ignoreall = 0;
        self.favoriteenemy = attacker;
        self waittill(#"goal");
    }
    self.var_88168473 = undefined;
}

// Namespace DOA_BOSS
// Params 1, eflags: 0x4
// Checksum 0xbaccf1b3, Offset: 0xcb8
// Size: 0x26
function private function_4e81959(waittime) {
    self endon(#"death");
    wait waittime;
    self.zombie_move_speed = "sprint";
}

// Namespace DOA_BOSS
// Params 0, eflags: 0x4
// Checksum 0x2bde4c0f, Offset: 0xce8
// Size: 0x102
function private function_a2756e92() {
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
    self util::waittill_any_timeout(14, "goal", "damage");
    self.var_88168473 = undefined;
    self.zombie_move_speed = "run";
    self thread function_4e81959(20);
}

// Namespace DOA_BOSS
// Params 0, eflags: 0x4
// Checksum 0x9f2b4762, Offset: 0xdf8
// Size: 0x251
function private _doaBossDamageShield() {
    trigger = spawn("trigger_radius", self.origin, 2, 32, 50);
    trigger.targetname = "_doaBossDamageShield";
    trigger enablelinkto();
    trigger linkto(self, "tag_origin");
    trigger endon(#"death");
    trigger thread namespace_49107f3a::function_783519c1("exit_taken", 1);
    trigger thread namespace_49107f3a::function_981c685d(self);
    trigger.silverback = 1;
    while (isdefined(self)) {
        trigger waittill(#"trigger", guy);
        if (isdefined(level.var_a7749866)) {
            continue;
        }
        if (isdefined(self)) {
            if (!isplayer(guy)) {
                self animscripted("pissedoff", self.origin, self.angles, "ai_zombie_doa_simianaut_attack_v1");
                self waittillmatch(#"pissedoff", "zombie_melee");
                playfx(level._effect["ground_pound"], guy.origin);
                if (isdefined(guy)) {
                    guy dodamage(guy.health + 107, self.origin, undefined, undefined, "MOD_EXPLOSIVE");
                }
                continue;
            }
            if (!isdefined(guy.doa)) {
                continue;
            }
            if (isdefined(guy.doa.var_1db1e638) && gettime() < guy.doa.var_1db1e638) {
                continue;
            }
            guy dodamage(666, guy.origin, self, self);
            if (isdefined(guy.doa)) {
                guy.doa.var_1db1e638 = gettime() + 10000;
                self animscripted("pissedoff", self.origin, self.angles, "ai_zombie_doa_simianaut_chestbeat");
                self waittillmatch(#"pissedoff", "end");
            }
        }
    }
}

// Namespace DOA_BOSS
// Params 0, eflags: 0x4
// Checksum 0xf669ab4a, Offset: 0x1058
// Size: 0x215
function private function_66efd1eb() {
    self endon(#"death");
    self endon(#"hash_19503b17");
    while (isdefined(self)) {
        wait 0.05;
        if (isdefined(self.var_faa677d7)) {
            if (gettime() < self.var_faa677d7) {
                continue;
            }
        }
        self.ignoreall = 1;
        self.favoriteenemy = undefined;
        self clearentitytarget();
        allies = arraycombine(getaiteamarray("allies"), doa_player_utility::function_5eb6e4d1(), 0, 0);
        for (i = 0; i < allies.size; i++) {
            player = allies[i];
            if (!isdefined(player) || !isalive(player)) {
                continue;
            }
            if (isplayer(player) && isdefined(player.doa.var_1db1e638) && gettime() < player.doa.var_1db1e638) {
                continue;
            }
            distsq = distancesquared(self.origin, player.origin);
            if (distsq <= -128 * -128) {
                self.ignoreall = 0;
                if (getdvarint("scr_boss_debug", 0)) {
                    level thread namespace_2f63e553::function_5e6b8376(self.origin, 100, 0.5, (1, 0, 0));
                }
                wait 0.5;
                break;
            }
        }
        if (getdvarint("scr_boss_debug", 0)) {
            level thread namespace_2f63e553::function_5e6b8376(self.origin, -128, 500, (1, 0.8, 0.8));
            level thread namespace_2f63e553::function_5e6b8376(self.origin, 32, 0.05, (0, 1, 0));
        }
    }
}

// Namespace DOA_BOSS
// Params 0, eflags: 0x4
// Checksum 0xb97d7755, Offset: 0x1278
// Size: 0x51
function private function_5bd24aae() {
    self endon(#"death");
    level waittill(#"exit_taken");
    level namespace_49107f3a::function_d0e32ad0(1);
    level notify(#"hash_48b870e4");
    self delete();
    level.doa.boss = undefined;
}

// Namespace DOA_BOSS
// Params 0, eflags: 0x4
// Checksum 0x34e9fdb1, Offset: 0x12d8
// Size: 0x3e2
function private _doaBossCollectPickups() {
    self endon(#"death");
    wait 0.1;
    tries = 5;
    for (failed = 0; tries; failed = 1) {
        wait 0.05;
        if (isdefined(self.var_88168473) && self.var_88168473) {
            continue;
        }
        if (self.ignoreall == 0) {
            continue;
        }
        if (failed) {
            tries--;
        }
        var_6792dc08 = getentarray("a_pickup_item", "script_noteworthy");
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
                self util::waittill_any_timeout(10, "goal");
                self.var_f4a5c4fe = undefined;
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
        org.targetname = "_doaBossCollectPickups";
        org setmodel("tag_origin");
        self linkto(org, "tag_origin");
        org thread namespace_eaa992c::function_285a2999("boss_takeoff");
        spot = self.origin + (0, 0, 2000);
        org thread namespace_49107f3a::function_a98c85b2(spot, 0.8);
        self util::waittill_any_timeout(2, "movedone");
        org delete();
    }
    self delete();
}

// Namespace DOA_BOSS
// Params 0, eflags: 0x4
// Checksum 0x1e21e566, Offset: 0x16c8
// Size: 0xc5
function private function_e5e28b1b() {
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
        wait 0.1;
    }
}

// Namespace DOA_BOSS
// Params 0, eflags: 0x0
// Checksum 0x5850fafd, Offset: 0x1798
// Size: 0x53
function function_76b30cc1() {
    self endon(#"death");
    amount = int(self.health * 0.15);
    while (self.health > 0) {
        wait 3;
        self notify(#"damage", amount);
    }
}

