#using scripts/zm/_zm_devgui;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_3a47cb81;

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x2
// Checksum 0x654c2274, Offset: 0x460
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_ai_quadrotor", &__init__, undefined, undefined);
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x6b0e8db7, Offset: 0x4a0
// Size: 0x64
function __init__() {
    vehicle::add_main_callback("zm_quadrotor", &function_612faa55);
    /#
        execdevgui("reached_end_node");
        level thread function_a05da9fb();
    #/
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x9883ea80, Offset: 0x510
// Size: 0x17c
function function_612faa55() {
    self useanimtree(#generic);
    target_set(self, (0, 0, 0));
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist(64);
    self.flyheight = -128;
    self setvehicleavoidance(1);
    self.var_31c3c12 = 0;
    self.var_229d1289 = 0.574;
    self.vehaircraftcollisionenabled = 1;
    self.goalradius = -128;
    self setgoal(self.origin, 0, self.goalradius, self.flyheight);
    self thread function_41e1ce83();
    self thread quadrotor_damage();
    function_a7ec51ae();
    self thread function_530a674b("allies");
}

// Namespace namespace_3a47cb81
// Params 1, eflags: 0x1 linked
// Checksum 0x31dddd55, Offset: 0x698
// Size: 0x1a8
function follow_ent(var_4b2fe35c) {
    level endon(#"end_game");
    self endon(#"death");
    while (isdefined(var_4b2fe35c)) {
        if (!self.var_73545c79) {
            v_facing = var_4b2fe35c getplayerangles();
            v_forward = anglestoforward((0, v_facing[1], 0));
            var_93d32d2c = var_4b2fe35c.origin + v_forward * -128;
            var_d528efa8 = physicstrace(self.origin, var_93d32d2c);
            if (var_d528efa8["position"] == var_93d32d2c) {
                self.current_pathto_pos = var_4b2fe35c.origin + v_forward * -128;
            } else {
                self.current_pathto_pos = var_4b2fe35c.origin + (0, 0, 60);
            }
            self.current_pathto_pos = self getclosestpointonnavvolume(self.current_pathto_pos, 100);
            if (!isdefined(self.current_pathto_pos)) {
                self.current_pathto_pos = self.origin;
            }
        }
        wait(randomfloatrange(1, 2));
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x8dd52d18, Offset: 0x848
// Size: 0x34
function function_a7ec51ae() {
    self.current_pathto_pos = self.origin;
    self.var_73545c79 = 0;
    function_bbc7d544();
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0xab38657f, Offset: 0x888
// Size: 0x7c
function function_bbc7d544() {
    self thread function_c2c9e6f9();
    self thread function_1353e6d4();
    self thread function_c29f99f7();
    self thread function_f92a6e99();
    self thread function_18c37253();
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x880a2e58, Offset: 0x910
// Size: 0x1a8
function function_1353e6d4() {
    level endon(#"end_game");
    self endon(#"death");
    while (true) {
        if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
            self setlookatent(self.enemy);
            self setturrettargetent(self.enemy);
            startaim = gettime();
            while (!self.turretontarget && vehicle_ai::timesince(startaim) < 3) {
                wait(0.2);
            }
            self function_d930b61d(randomfloatrange(1.5, 3));
            if (isdefined(self.enemy) && isai(self.enemy)) {
                wait(randomfloatrange(0.5, 1));
            } else {
                wait(randomfloatrange(0.5, 1.5));
            }
            continue;
        }
        self clearlookatent();
        wait(0.4);
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x124b4058, Offset: 0xac0
// Size: 0xac
function function_18c37253() {
    self endon(#"death");
    level waittill(#"end_game");
    if (isdefined(self)) {
        playfx(level._effect["tesla_elec_kill"], self.origin);
        self playsound("zmb_qrdrone_leave");
        self delete();
        /#
            iprintln("reached_end_node");
        #/
    }
}

// Namespace namespace_3a47cb81
// Params 1, eflags: 0x0
// Checksum 0xae670c7a, Offset: 0xb78
// Size: 0x6e
function function_1f42066b(position) {
    results = physicstrace(self.origin, position, (-15, -15, -5), (15, 15, 5));
    if (results["fraction"] == 1) {
        return true;
    }
    return false;
}

// Namespace namespace_3a47cb81
// Params 1, eflags: 0x0
// Checksum 0xf4d5d9f6, Offset: 0xbf0
// Size: 0x168
function function_e8fd2f7d(goalpos) {
    if (isdefined(self.enemy)) {
        if (isai(self.enemy)) {
            offset = 45;
        } else {
            offset = -100;
        }
        if (self.enemy.origin[2] + offset > goalpos[2]) {
            var_e47958bf = self.enemy.origin[2] + offset;
            if (var_e47958bf > goalpos[2] + 400) {
                var_e47958bf = goalpos[2] + 400;
            }
            results = physicstrace(goalpos, (goalpos[0], goalpos[1], var_e47958bf), (-15, -15, -5), (15, 15, 5));
            if (results["fraction"] == 1) {
                goalpos = (goalpos[0], goalpos[1], var_e47958bf);
            }
        }
    }
    return goalpos;
}

// Namespace namespace_3a47cb81
// Params 1, eflags: 0x1 linked
// Checksum 0xb010948e, Offset: 0xd60
// Size: 0x12c
function function_8a7ff235(pos) {
    start = pos + (0, 0, self.flyheight);
    end = pos + (0, 0, self.flyheight * -1);
    trace = bullettrace(start, end, 0, self, 0, 0);
    end = trace["position"];
    pos = end + (0, 0, self.flyheight);
    z = self getheliheightlockheight(pos);
    pos = (pos[0], pos[1], z);
    pos = self getclosestpointonnavvolume(pos, 100);
    if (!isdefined(pos)) {
        pos = self.origin;
    }
    return pos;
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0xc2a54bbc, Offset: 0xe98
// Size: 0x5c
function waittill_pathing_done() {
    level endon(#"end_game");
    self endon(#"death");
    self endon(#"change_state");
    if (self.vehonpath) {
        self util::waittill_any("near_goal", "reached_end_node", "force_goal");
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0xb3c60c42, Offset: 0xf00
// Size: 0xcc4
function function_c29f99f7() {
    level endon(#"end_game");
    self endon(#"death");
    self endon(#"change_state");
    /#
        assert(isalive(self));
    #/
    a_powerups = [];
    var_ecb63c8c = self.current_pathto_pos;
    self.current_pathto_pos = self function_8a7ff235(self.current_pathto_pos);
    if (!self.vehonpath) {
        if (isdefined(self.attachedpath)) {
            self util::script_delay();
        } else if (self.current_pathto_pos[2] > var_ecb63c8c[2] + 10 || distancesquared(self.origin, self.current_pathto_pos) < 10000 && self.origin[2] + 10 < self.current_pathto_pos[2]) {
            self setvehgoalpos(self.current_pathto_pos, 1, 1);
            self pathvariableoffset((0, 0, 20), 2);
            self util::waittill_any_timeout(4, "near_goal", "force_goal", "death", "change_state");
        } else {
            goalpos = self function_51c0b62c();
            self setvehgoalpos(goalpos, 1, 1);
            self util::waittill_any_timeout(2, "near_goal", "force_goal", "death", "change_state");
        }
    }
    /#
        assert(isalive(self));
    #/
    self setvehicleavoidance(1);
    while (true) {
        self waittill_pathing_done();
        self thread function_c2c9e6f9();
        if (self.var_73545c79) {
            self setneargoalnotifydist(64);
            self setheliheightlock(0);
            var_45093ab0 = 0;
            var_d4400a09 = level.var_3c3bf0e1.pickup_trig.model;
            var_946c2ab7 = self getclosestpointonnavvolume(var_d4400a09.origin, 100);
            if (isdefined(var_946c2ab7)) {
                var_45093ab0 = self setvehgoalpos(var_946c2ab7, 1, 1);
            }
            if (var_45093ab0) {
                self notify(#"hash_54472f9");
                self util::waittill_any("near_goal", "force_goal", "reached_end_node", "return_timeout");
                continue;
            } else {
                self thread function_8427d796();
            }
            self util::waittill_any("near_goal", "force_goal", "reached_end_node", "return_timeout");
        }
        if (!isdefined(self.revive_target)) {
            player = self function_d65089d6(500);
            if (isdefined(player)) {
                self.revive_target = player;
                player.var_d9fc32dc = 1;
            }
        }
        if (isdefined(self.revive_target)) {
            origin = self.revive_target.origin;
            origin = (origin[0], origin[1], origin[2] + 100);
            origin = self getclosestpointonnavvolume(origin, 100);
            /#
                assert(isdefined(origin));
            #/
            if (self setvehgoalpos(origin, 1, 1)) {
                self util::waittill_any("near_goal", "force_goal", "reached_end_node");
                level thread function_49d083f3(self);
                wait(1);
                if (isdefined(self.revive_target) && self.revive_target laststand::player_is_in_laststand()) {
                    self.revive_target notify(#"remote_revive", self.player_owner);
                    self.player_owner notify(#"hash_340af45b");
                }
                self.revive_target = undefined;
                self setvehgoalpos(origin, 1, 1);
                wait(1);
                continue;
            } else {
                player.var_d9fc32dc = undefined;
            }
            wait(0.1);
        }
        a_powerups = [];
        if (level.active_powerups.size > 0 && isdefined(self.player_owner)) {
            a_powerups = util::get_array_of_closest(self.player_owner.origin, level.active_powerups, undefined, undefined, 500);
        }
        if (a_powerups.size > 0) {
            var_485db0b3 = 0;
            foreach (powerup in a_powerups) {
                var_2b346da7 = self getclosestpointonnavvolume(powerup.origin, 100);
                if (!isdefined(var_2b346da7)) {
                    continue;
                }
                if (self setvehgoalpos(var_2b346da7, 1, 1)) {
                    self util::waittill_any("near_goal", "force_goal", "reached_end_node");
                    if (isdefined(powerup)) {
                        self.player_owner.ignore_range_powerup = powerup;
                        var_485db0b3 = 1;
                    }
                    wait(1);
                    break;
                }
            }
            if (var_485db0b3) {
                continue;
            }
            wait(0.1);
        }
        var_ebf8a63f = getentarray("quad_special_item", "script_noteworthy");
        if (isdefined(level.var_65b9544f) && level.var_65b9544f > 0 && isdefined(self.player_owner)) {
            var_b379fbf8 = arraygetclosest(self.player_owner.origin, var_ebf8a63f, 500);
            if (isdefined(var_b379fbf8)) {
                var_146a0124 = self getclosestpointonnavvolume(var_b379fbf8.origin, 100);
                self setvehgoalpos(var_146a0124, 1, 1);
                self util::waittill_any("near_goal", "force_goal", "reached_end_node");
                wait(1);
                playfx(level._effect["staff_charge"], var_b379fbf8.origin);
                var_b379fbf8 hide();
                level.var_65b9544f--;
                level notify(#"hash_409f85a3", self);
                if (level.var_65b9544f == 0) {
                    var_94325f0b = struct::get("mgspawn", "targetname");
                    var_50cc6658 = self getclosestpointonnavvolume(var_94325f0b.origin, 100);
                    self setvehgoalpos(var_50cc6658 + (0, 0, 30), 1, 1);
                    self util::waittill_any("near_goal", "force_goal", "reached_end_node");
                    wait(1);
                    playfx(level._effect["staff_charge"], var_50cc6658);
                    var_b379fbf8 playsound("zmb_perks_packa_ready");
                    level flag::set("ee_medallions_collected");
                }
                var_b379fbf8 delete();
                self setneargoalnotifydist(30);
                self setvehgoalpos(self.origin, 1, 1);
            }
        }
        if (isdefined(level.var_789c3e33)) {
            self [[ level.var_789c3e33 ]]();
        }
        goalpos = function_1bfe5ccd();
        if (self setvehgoalpos(goalpos, 1, 1)) {
            if (isdefined(self.var_c5f9f37f)) {
                self.var_c5f9f37f.var_3c1543fe = 1;
            }
            self util::waittill_any_timeout(12, "near_goal", "force_goal", "reached_end_node", "change_state", "death");
            if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
                wait(randomfloatrange(1, 4));
            } else {
                wait(randomfloatrange(1, 3));
            }
            if (isdefined(self.var_c5f9f37f)) {
                self.var_c5f9f37f.var_3c1543fe = undefined;
            }
            continue;
        }
        if (isdefined(self.var_c5f9f37f)) {
            self.var_c5f9f37f.var_2351b762 = 1;
        }
        self.current_pathto_pos = self.origin;
        self setvehgoalpos(self.origin, 1, 1);
        wait(0.5);
        continue;
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0xc0a36311, Offset: 0x1bd0
// Size: 0x18a
function function_8427d796() {
    /#
        iprintln("reached_end_node");
    #/
    self.current_pathto_pos = self.origin + (0, 0, 2048);
    var_1a3730a6 = self setvehgoalpos(self.current_pathto_pos, 1, 0);
    var_d528efa8 = physicstrace(self.origin, self.current_pathto_pos);
    if (var_1a3730a6 && var_d528efa8["position"] == self.current_pathto_pos) {
        /#
            iprintln("reached_end_node");
        #/
        self notify(#"hash_54472f9");
        return;
    }
    /#
        iprintln("reached_end_node");
    #/
    self notify(#"hash_54472f9");
    playfx(level._effect["tesla_elec_kill"], self.origin);
    self playsound("zmb_qrdrone_leave");
    self delete();
    level notify(#"hash_3577ab25");
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0xd07f300c, Offset: 0x1d68
// Size: 0x122
function function_51c0b62c() {
    nodes = getnodesinradiussorted(self.origin, -56, 0, 500, "Path");
    if (nodes.size == 0) {
        nodes = getnodesinradiussorted(self.current_pathto_pos, 3000, 0, 2000, "Path");
    }
    foreach (node in nodes) {
        if (node.type == "BAD NODE") {
            continue;
        }
        return function_8a7ff235(node.origin);
    }
    return self.origin;
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x28471008, Offset: 0x1e98
// Size: 0x32c
function function_1bfe5ccd() {
    if (!isdefined(self.current_pathto_pos)) {
        self.current_pathto_pos = self.origin;
    }
    origin = self.current_pathto_pos;
    nodes = getnodesinradius(self.current_pathto_pos, self.goalradius, 0, self.flyheight + 300, "Path");
    if (nodes.size == 0) {
        nodes = getnodesinradius(self.current_pathto_pos, self.goalradius + 1000, 0, self.flyheight + 1000, "Path");
    }
    if (nodes.size == 0) {
        nodes = getnodesinradius(self.current_pathto_pos, self.goalradius + 5000, 0, self.flyheight + 4000, "Path");
    }
    best_node = undefined;
    best_score = 0;
    foreach (node in nodes) {
        if (node.type == "BAD NODE") {
            continue;
        }
        if (isdefined(node.var_2351b762) || isdefined(node.var_3c1543fe)) {
            score = randomfloat(30);
        } else {
            score = randomfloat(100);
        }
        if (score > best_score) {
            best_score = score;
            best_node = node;
        }
    }
    if (isdefined(best_node)) {
        node_origin = best_node.origin + (0, 0, self.flyheight + randomfloatrange(-30, 40));
        z = self getheliheightlockheight(node_origin);
        node_origin = (node_origin[0], node_origin[1], z);
        node_origin = self getclosestpointonnavvolume(node_origin, 100);
        if (isdefined(node_origin)) {
            origin = node_origin;
            self.var_c5f9f37f = best_node;
        }
    }
    return origin;
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x0
// Checksum 0x513b5794, Offset: 0x21d0
// Size: 0x24
function function_40b24410() {
    self.origin = self function_51c0b62c();
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0xa00208fc, Offset: 0x2200
// Size: 0x240
function quadrotor_damage() {
    self endon(#"crash_done");
    while (isdefined(self)) {
        damage, _, dir, point, type = self waittill(#"damage");
        if (isdefined(self.off)) {
            continue;
        }
        if (type == "MOD_EXPLOSIVE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE_SPLASH") {
            self setvehvelocity(self.velocity + vectornormalize(dir) * 300);
            ang_vel = self getangularvelocity();
            ang_vel += (randomfloatrange(-300, 300), randomfloatrange(-300, 300), randomfloatrange(-300, 300));
            self setangularvelocity(ang_vel);
        } else {
            ang_vel = self getangularvelocity();
            yaw_vel = randomfloatrange(-320, 320);
            if (yaw_vel < 0) {
                yaw_vel -= -106;
            } else {
                yaw_vel += -106;
            }
            ang_vel += (randomfloatrange(-150, -106), yaw_vel, randomfloatrange(-150, -106));
            self setangularvelocity(ang_vel);
        }
        wait(0.3);
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0xed4d36ee, Offset: 0x2448
// Size: 0x2c
function function_6f4de6ea() {
    if (isdefined(self.stun_fx)) {
        self.stun_fx delete();
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0xa89b50fb, Offset: 0x2480
// Size: 0x1d6
function function_41e1ce83() {
    wait(0.1);
    self notify(#"nodeath_thread");
    attacker, damagefromunderneath, weaponname, point, dir = self waittill(#"death");
    self notify(#"nodeath_thread");
    if (isdefined(self.var_c5f9f37f) && isdefined(self.var_c5f9f37f.var_3c1543fe)) {
        self.var_c5f9f37f.var_3c1543fe = undefined;
    }
    if (isdefined(self.delete_on_death)) {
        if (isdefined(self)) {
            self function_6f4de6ea();
            self delete();
            level.var_461e417 = undefined;
        }
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self disableaimassist();
    self death_fx();
    self thread death_radius_damage();
    self thread set_death_model(self.deathmodel, self.modelswapdelay);
    self thread function_be2b424c(attacker, dir);
    self function_6f4de6ea();
    self waittill(#"crash_done");
    self delete();
    level.var_461e417 = undefined;
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x811022a0, Offset: 0x2660
// Size: 0x54
function death_fx() {
    if (isdefined(self.deathfx)) {
        playfxontag(self.deathfx, self, self.deathfxtag);
    }
    self playsound("veh_qrdrone_sparks");
}

// Namespace namespace_3a47cb81
// Params 2, eflags: 0x1 linked
// Checksum 0x62108dc1, Offset: 0x26c0
// Size: 0x3b6
function function_be2b424c(attacker, hitdir) {
    level endon(#"end_game");
    self endon(#"crash_done");
    self endon(#"death");
    self cancelaimove();
    self clearvehgoalpos();
    self clearlookatent();
    self setphysacceleration((0, 0, -800));
    self.vehcheckforpredictedcrash = 1;
    if (!isdefined(hitdir)) {
        hitdir = (1, 0, 0);
    }
    side_dir = vectorcross(hitdir, (0, 0, 1));
    side_dir_mag = randomfloatrange(-100, 100);
    side_dir_mag += math::sign(side_dir_mag) * 80;
    side_dir *= side_dir_mag;
    self setvehvelocity(self.velocity + (0, 0, 100) + vectornormalize(side_dir));
    ang_vel = self getangularvelocity();
    ang_vel = (ang_vel[0] * 0.3, ang_vel[1], ang_vel[2] * 0.3);
    yaw_vel = randomfloatrange(0, -46) * math::sign(ang_vel[1]);
    yaw_vel += math::sign(yaw_vel) * -76;
    ang_vel += (randomfloatrange(-1, 1), yaw_vel, randomfloatrange(-1, 1));
    self setangularvelocity(ang_vel);
    self.crash_accel = randomfloatrange(75, 110);
    if (!isdefined(self.off)) {
        self thread function_b07608f5();
    }
    self thread function_f92a6e99();
    self playsound("veh_qrdrone_dmg_hit");
    if (!isdefined(self.off)) {
        self thread function_2b48803();
    }
    wait(0.1);
    if (randomint(100) < 40 && !isdefined(self.off)) {
        self thread function_d930b61d(randomfloatrange(0.7, 2));
    }
    wait(15);
    self notify(#"crash_done");
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x85dd98a3, Offset: 0x2a80
// Size: 0xcc
function function_2b48803() {
    dmg_ent = spawn("script_origin", self.origin);
    dmg_ent linkto(self);
    dmg_ent playloopsound("veh_qrdrone_dmg_loop");
    self util::waittill_any("crash_done", "death");
    dmg_ent stoploopsound(1);
    wait(2);
    dmg_ent delete();
}

// Namespace namespace_3a47cb81
// Params 1, eflags: 0x1 linked
// Checksum 0xa91f341, Offset: 0x2b58
// Size: 0x154
function function_d930b61d(totalfiretime) {
    level endon(#"end_game");
    self endon(#"crash_done");
    self endon(#"change_state");
    self endon(#"death");
    if (isdefined(self.emped)) {
        return;
    }
    weapon = self seatgetweapon(0);
    firetime = weapon.firetime;
    time = 0;
    firecount = 1;
    while (time < totalfiretime && !isdefined(self.emped)) {
        if (isdefined(self.enemy) && isdefined(self.enemy.attackeraccuracy) && self.enemy.attackeraccuracy == 0) {
            self fireweapon(undefined, undefined, 1);
        } else {
            self fireweapon();
        }
        firecount++;
        wait(firetime);
        time += firetime;
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0xd7d6c669, Offset: 0x2cb8
// Size: 0x1c8
function function_b07608f5() {
    level endon(#"end_game");
    self endon(#"crash_done");
    self endon(#"death");
    count = 0;
    while (true) {
        self setvehvelocity(self.velocity + anglestoup(self.angles) * self.crash_accel);
        self.crash_accel *= 0.98;
        wait(0.1);
        count++;
        if (count % 8 == 0) {
            if (randomint(100) > 40) {
                if (self.velocity[2] > 150) {
                    self.crash_accel *= 0.75;
                    continue;
                }
                if (self.velocity[2] < 40 && count < 60) {
                    if (abs(self.angles[0]) > 30 || abs(self.angles[2]) > 30) {
                        self.crash_accel = randomfloatrange(-96, -56);
                        continue;
                    }
                    self.crash_accel = randomfloatrange(85, 120);
                }
            }
        }
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x667feba0, Offset: 0x2e88
// Size: 0x86
function function_a42c41a8() {
    level endon(#"end_game");
    self endon(#"crash_done");
    self endon(#"death");
    while (true) {
        velocity, normal = self waittill(#"veh_predictedcollision");
        if (normal[2] >= 0.6) {
            self notify(#"veh_collision", velocity, normal);
        }
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x0
// Checksum 0x4ee4685b, Offset: 0x2f18
// Size: 0x100
function function_6c50dd0b() {
    level endon(#"end_game");
    self endon(#"change_state");
    self endon(#"crash_done");
    self endon(#"death");
    while (true) {
        velocity, normal = self waittill(#"veh_collision");
        driver = self getseatoccupant(0);
        if (isdefined(driver) && lengthsquared(velocity) > 4900) {
            earthquake(0.25, 0.25, driver.origin, 50);
            driver playrumbleonentity("damage_heavy");
        }
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x2829e489, Offset: 0x3020
// Size: 0x546
function function_f92a6e99() {
    level endon(#"end_game");
    self endon(#"change_state");
    self endon(#"crash_done");
    self endon(#"death");
    if (!isalive(self)) {
        self thread function_a42c41a8();
    }
    self.var_7e211e5 = 0;
    var_32c4d3ec = 0;
    while (true) {
        velocity, normal = self waittill(#"veh_collision");
        ang_vel = self getangularvelocity() * 0.5;
        self setangularvelocity(ang_vel);
        if (isalive(self) && (normal[2] < 0.6 || !isdefined(self.emped))) {
            self setvehvelocity(self.velocity + normal * 90);
            self playsound("veh_qrdrone_wall");
            if (normal[2] < 0.6) {
                fx_origin = self.origin - normal * 28;
            } else {
                fx_origin = self.origin - normal * 10;
            }
            current_time = gettime();
            if (current_time - var_32c4d3ec < 1000) {
                self.var_7e211e5 += 1;
                if (self.var_7e211e5 > 2) {
                    self notify(#"force_goal");
                    self.var_7e211e5 = 0;
                }
            } else {
                self.var_7e211e5 = 0;
            }
            var_32c4d3ec = gettime();
            continue;
        }
        if (isdefined(self.emped)) {
            if (isdefined(self.bounced)) {
                self playsound("veh_qrdrone_wall");
                self setvehvelocity((0, 0, 0));
                self setangularvelocity((0, 0, 0));
                if (self.angles[0] < 0) {
                    if (self.angles[0] < -15) {
                        self.angles = (-15, self.angles[1], self.angles[2]);
                    } else if (self.angles[0] > -10) {
                        self.angles = (-10, self.angles[1], self.angles[2]);
                    }
                } else if (self.angles[0] > 15) {
                    self.angles = (15, self.angles[1], self.angles[2]);
                } else if (self.angles[0] < 10) {
                    self.angles = (10, self.angles[1], self.angles[2]);
                }
                self.bounced = undefined;
                self notify(#"landed");
                return;
            } else {
                self.bounced = 1;
                self setvehvelocity(self.velocity + normal * 120);
                self playsound("veh_qrdrone_wall");
                if (normal[2] < 0.6) {
                    fx_origin = self.origin - normal * 28;
                } else {
                    fx_origin = self.origin - normal * 10;
                }
                playfx(level._effect["quadrotor_nudge"], fx_origin, normal);
            }
            continue;
        }
        createdynentandlaunch(self.deathmodel, self.origin, self.angles, self.origin, self.velocity * 0.01);
        self playsound("veh_qrdrone_explo");
        self thread death_fire_loop_audio();
        self notify(#"crash_done");
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x2f0c9711, Offset: 0x3570
// Size: 0x8c
function death_fire_loop_audio() {
    sound_ent = spawn("script_origin", self.origin);
    sound_ent playloopsound("veh_qrdrone_death_fire_loop", 0.1);
    wait(11);
    sound_ent stoploopsound(1);
    sound_ent delete();
}

// Namespace namespace_3a47cb81
// Params 1, eflags: 0x1 linked
// Checksum 0x4c5bafec, Offset: 0x3608
// Size: 0x5c
function function_530a674b(team) {
    self.team = team;
    self.var_d40496 = team;
    self setteam(team);
    if (!isdefined(self.off)) {
        function_c2c9e6f9();
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x78d28147, Offset: 0x3670
// Size: 0x4c
function function_c2c9e6f9() {
    level endon(#"end_game");
    self endon(#"death");
    self vehicle::lights_off();
    wait(0.1);
    self vehicle::lights_on();
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x0
// Checksum 0xc9f34e25, Offset: 0x36c8
// Size: 0x1ac
function function_1075562a() {
    level endon(#"end_game");
    self endon(#"death");
    self endon(#"exit_vehicle");
    self_destruct = 0;
    var_2b2fe37c = 0;
    while (true) {
        if (!self_destruct) {
            if (level.player meleebuttonpressed()) {
                self_destruct = 1;
                var_2b2fe37c = 5;
            }
            wait(0.05);
            continue;
        }
        iprintlnbold(var_2b2fe37c);
        wait(1);
        var_2b2fe37c -= 1;
        if (var_2b2fe37c == 0) {
            driver = self getseatoccupant(0);
            if (isdefined(driver)) {
                driver disableinvulnerability();
            }
            earthquake(3, 1, self.origin, 256);
            radiusdamage(self.origin, 1000, 15000, 15000, level.player, "MOD_EXPLOSIVE");
            self dodamage(self.health + 1000, self.origin);
        }
        continue;
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x0
// Checksum 0xa56ff709, Offset: 0x3880
// Size: 0x100
function function_cbb6895e() {
    level endon(#"end_game");
    self endon(#"death");
    self endon(#"emped");
    self endon(#"landed");
    while (isdefined(self.emped)) {
        velocity = self.velocity;
        self.angles = (self.angles[0] * 0.85, self.angles[1], self.angles[2] * 0.85);
        ang_vel = self getangularvelocity() * 0.85;
        self setangularvelocity(ang_vel);
        self setvehvelocity(velocity);
        wait(0.05);
    }
}

// Namespace namespace_3a47cb81
// Params 1, eflags: 0x0
// Checksum 0x13e8bab3, Offset: 0x3988
// Size: 0x74
function function_3b87284(var_ac7ce67c) {
    self notify(#"bullet_shield");
    self endon(#"bullet_shield");
    self.bullet_shield = 1;
    wait(var_ac7ce67c);
    if (isdefined(self)) {
        self.bullet_shield = undefined;
        wait(3);
        if (isdefined(self) && self.health < 40) {
            self.health = 40;
        }
    }
}

// Namespace namespace_3a47cb81
// Params 0, eflags: 0x1 linked
// Checksum 0x5af37f0e, Offset: 0x3a08
// Size: 0x7c
function death_radius_damage() {
    if (!isdefined(self) || self.radiusdamageradius <= 0) {
        return;
    }
    wait(0.05);
    if (isdefined(self)) {
        self radiusdamage(self.origin + (0, 0, 15), self.radiusdamageradius, self.radiusdamagemax, self.radiusdamagemin, self, "MOD_EXPLOSIVE");
    }
}

// Namespace namespace_3a47cb81
// Params 2, eflags: 0x1 linked
// Checksum 0xfc86dc36, Offset: 0x3a90
// Size: 0x84
function set_death_model(smodel, fdelay) {
    /#
        assert(isdefined(smodel));
    #/
    if (isdefined(fdelay) && fdelay > 0) {
        wait(fdelay);
    }
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.deathmodel_attached)) {
        return;
    }
    self setmodel(smodel);
}

// Namespace namespace_3a47cb81
// Params 1, eflags: 0x1 linked
// Checksum 0x92c1d38, Offset: 0x3b20
// Size: 0x162
function function_d65089d6(range) {
    players = getplayers();
    if (players.size == 1) {
        return;
    }
    foreach (player in players) {
        if (player laststand::player_is_in_laststand() && distancesquared(self.origin, player.origin) < range * range && !isdefined(player.var_d9fc32dc)) {
            var_d46f516e = self getclosestpointonnavvolume(player.origin + (0, 0, 100), 100);
            if (!isdefined(var_d46f516e)) {
                continue;
            }
            return player;
        }
    }
}

// Namespace namespace_3a47cb81
// Params 1, eflags: 0x1 linked
// Checksum 0xe592ea94, Offset: 0x3c90
// Size: 0xf2
function function_49d083f3(var_f8d81a41) {
    var_28c00c94 = var_f8d81a41;
    owner = var_f8d81a41.player_owner;
    revive_target = var_f8d81a41.revive_target;
    revive_target endon(#"bled_out");
    revive_target endon(#"disconnect");
    level thread function_85d873a0(var_28c00c94, revive_target);
    revive_target.revive_hud settext(%GAME_PLAYER_IS_REVIVING_YOU, owner);
    revive_target laststand::revive_hud_show_n_fade(1);
    wait(1);
    if (isdefined(revive_target)) {
        revive_target.var_d9fc32dc = undefined;
    }
}

// Namespace namespace_3a47cb81
// Params 2, eflags: 0x1 linked
// Checksum 0x78426348, Offset: 0x3d90
// Size: 0x1d4
function function_85d873a0(var_28c00c94, revive_target) {
    e_fx = spawn("script_model", var_28c00c94 gettagorigin("tag_origin"));
    e_fx setmodel("tag_origin");
    e_fx playsound("zmb_drone_revive_fire");
    e_fx playloopsound("zmb_drone_revive_loop", 0.2);
    e_fx moveto(revive_target.origin, 1);
    timer = 0;
    while (true) {
        if (isdefined(revive_target) && revive_target laststand::player_is_in_laststand() && isdefined(var_28c00c94)) {
            wait(0.1);
            timer += 0.1;
            if (timer >= 1) {
                e_fx stoploopsound(0.1);
                e_fx playsound("zmb_drone_revive_revive_3d");
                revive_target playsoundtoplayer("zmb_drone_revive_revive_plr", revive_target);
                break;
            }
            continue;
        }
        break;
    }
    e_fx delete();
}

/#

    // Namespace namespace_3a47cb81
    // Params 0, eflags: 0x5 linked
    // Checksum 0x9aad8be7, Offset: 0x3f70
    // Size: 0x44
    function private function_a05da9fb() {
        level flagsys::wait_till("reached_end_node");
        zm_devgui::add_custom_devgui_callback(&function_d3a31a35);
    }

    // Namespace namespace_3a47cb81
    // Params 1, eflags: 0x5 linked
    // Checksum 0x56d97388, Offset: 0x3fc0
    // Size: 0xc8
    function private function_d3a31a35(cmd) {
        if (cmd == "reached_end_node") {
            player = level.players[0];
            var_28c00c94 = spawnvehicle("reached_end_node", player.origin + (0, 0, 32), (0, 0, 0));
            if (isalive(var_28c00c94)) {
                var_28c00c94 thread follow_ent(player);
                var_28c00c94.player_owner = player;
            }
        }
    }

#/
