#using scripts/shared/ai/systems/blackboard;
#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/util_shared;

#namespace ai_sniper;

// Namespace ai_sniper
// Params 0, eflags: 0x2
// Checksum 0x76eda00b, Offset: 0x200
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("ai_sniper", &__init__, undefined, undefined);
}

// Namespace ai_sniper
// Params 0, eflags: 0x0
// Checksum 0x90f969ab, Offset: 0x238
// Size: 0x12
function __init__() {
    thread function_abc49676();
}

// Namespace ai_sniper
// Params 1, eflags: 0x0
// Checksum 0xbb02e55c, Offset: 0x258
// Size: 0x23b
function function_abc49676(targetname) {
    wait 0.05;
    if (!isdefined(targetname)) {
        targetname = "ai_sniper_node_scan";
    }
    var_406775ae = struct::get_array(targetname, "targetname");
    var_6ab55afd = getentarray(targetname, "targetname");
    foreach (struct in var_406775ae) {
        var_6ab55afd[var_6ab55afd.size] = struct;
    }
    foreach (point in var_6ab55afd) {
        if (isdefined(point.target)) {
            node = getnode(point.target, "targetname");
            if (isdefined(node)) {
                if (!isdefined(node.var_565daac6)) {
                    node.var_565daac6 = [];
                }
                node.var_565daac6[node.var_565daac6.size] = point;
            }
        }
    }
    nodelist = getnodearray(targetname, "script_noteworthy");
    foreach (node in nodelist) {
        if (isdefined(node.script_linkto)) {
            node.var_57357d16 = struct::get(node.script_linkto, "script_linkname");
            if (!isdefined(node.var_57357d16)) {
                node.var_57357d16 = getent(node.script_linkto, "script_linkname");
            }
        }
    }
}

// Namespace ai_sniper
// Params 0, eflags: 0x0
// Checksum 0x71970703, Offset: 0x4a0
// Size: 0x32
function agent_init() {
    self thread function_8d1875dc();
    self thread function_6a517a0a();
    self thread function_6fb6a6d3();
}

// Namespace ai_sniper
// Params 1, eflags: 0x0
// Checksum 0x77502a72, Offset: 0x4e0
// Size: 0xef
function function_b61dfa9e(node) {
    if (!isdefined(node)) {
        return;
    }
    if (!isdefined(node.var_565daac6) && !isdefined(node.var_57357d16)) {
        return;
    }
    self notify(#"hash_b61dfa9e");
    self endon(#"hash_b61dfa9e");
    self endon(#"death");
    self endon(#"hash_565daac6");
    if (isdefined(self.patroller) && self.patroller) {
        self ai::end_and_clean_patrol_behaviors();
    }
    goalpos = node.origin;
    if (isdefined(self.pathgoalpos)) {
        goalpos = self.pathgoalpos;
    }
    if (isdefined(self.arrivalfinalpos)) {
        goalpos = self.arrivalfinalpos;
    }
    while (distancesquared(self.origin, goalpos) > 256) {
        wait 0.05;
    }
    self notify(#"hash_50b88a46", node);
}

// Namespace ai_sniper
// Params 0, eflags: 0x0
// Checksum 0x3a602399, Offset: 0x5d8
// Size: 0x4d
function function_6a517a0a() {
    self notify(#"hash_6a517a0a");
    self endon(#"hash_6a517a0a");
    self endon(#"death");
    while (true) {
        node = self waittill(#"patrol_goal");
        self function_b61dfa9e(node);
    }
}

// Namespace ai_sniper
// Params 0, eflags: 0x0
// Checksum 0x6df77474, Offset: 0x630
// Size: 0x8a
function function_6fb6a6d3() {
    self notify(#"hash_6fb6a6d3");
    self endon(#"hash_6fb6a6d3");
    self endon(#"death");
    if (isdefined(self.target) && !(isdefined(self.patroller) && self.patroller)) {
        node = getnode(self.target, "targetname");
        if (isdefined(node)) {
            self waittill(#"goal");
            self function_b61dfa9e(node);
        }
    }
}

// Namespace ai_sniper
// Params 0, eflags: 0x0
// Checksum 0xc5f3e6b4, Offset: 0x6c8
// Size: 0x1f5
function function_8d1875dc() {
    self notify(#"hash_8d1875dc");
    self endon(#"hash_8d1875dc");
    self endon(#"death");
    while (true) {
        var_360359e4 = 0;
        node = self waittill(#"hash_50b88a46");
        if (isdefined(node.var_57357d16)) {
            self thread function_6840179(node.var_57357d16);
        } else {
            self thread function_6840179(node.var_565daac6);
        }
        if (self ai::has_behavior_attribute("stealth")) {
            var_360359e4 = self ai::get_behavior_attribute("stealth");
            self ai::set_behavior_attribute("stealth", 0);
        }
        if (isdefined(self.currentgoal) && isdefined(self.currentgoal.target) && self.currentgoal.target != "") {
            self setgoal(node, 1);
            self waittill(#"hash_b39fffd7");
            self notify(#"hash_565daac6");
            self laseroff();
            self.holdfire = 0;
            self ai::stop_shoot_at_target();
            if (isdefined(self.var_d1ddf246)) {
                self.goalradius = self.var_d1ddf246;
                self.var_d1ddf246 = undefined;
            }
            if (isdefined(self.currentgoal)) {
                self thread ai::patrol(self.currentgoal);
            }
            if (var_360359e4 && self ai::has_behavior_attribute("stealth")) {
                self ai::set_behavior_attribute("stealth", self.awarenesslevelcurrent != "combat");
            }
            continue;
        }
        break;
    }
}

// Namespace ai_sniper
// Params 1, eflags: 0x0
// Checksum 0x90bf9a6, Offset: 0x8c8
// Size: 0x282
function function_6840179(var_f1f6e3d) {
    self notify(#"hash_565daac6");
    self endon(#"hash_565daac6");
    self endon(#"death");
    self.holdfire = 1;
    self.blindaim = 1;
    if (!isdefined(self.var_d1ddf246)) {
        self.var_d1ddf246 = self.goalradius;
    }
    self.goalradius = 8;
    if (isdefined(self.__blackboard) && isdefined(self.script_parameters) && self.script_parameters == "steady") {
        blackboard::setblackboardattribute(self, "_context", "steady");
    }
    if (!isdefined(var_f1f6e3d) && isdefined(self.target)) {
        var_f1f6e3d = struct::get(self.target, "targetname");
    }
    if (isarray(var_f1f6e3d) && (!isdefined(var_f1f6e3d) || var_f1f6e3d.size == 0)) {
        /#
            iprintlnbold("<dev string:x28>");
        #/
        return;
    }
    firstpoint = undefined;
    if (isarray(var_f1f6e3d)) {
        firstpoint = var_f1f6e3d[0];
    } else {
        firstpoint = var_f1f6e3d;
    }
    if (!isdefined(self.var_9eb700da)) {
        self.var_9eb700da = spawn("script_model", function_9bab0bf(firstpoint));
        self.var_9eb700da setmodel("tag_origin");
        self.var_9eb700da.velocity = (100, 0, 0);
        self thread util::delete_on_death(self.var_9eb700da);
    }
    if (self.var_9eb700da.health <= 0) {
        self.var_9eb700da.health = 1;
    }
    self thread ai::shoot_at_target("shoot_until_target_dead", self.var_9eb700da);
    self.var_9eb700da thread function_6eceec3e(var_f1f6e3d, self);
    self.var_9eb700da thread function_cc2a65b3(self geteye(), var_f1f6e3d, self);
    self thread function_2ba378ce();
    self thread function_659cb4db();
}

// Namespace ai_sniper
// Params 0, eflags: 0x0
// Checksum 0xf47381ec, Offset: 0xb58
// Size: 0xa2
function function_782962c5() {
    if (!isdefined(self.var_9eb700da)) {
        return;
    }
    self notify(#"hash_565daac6");
    self.holdfire = 0;
    self.blindaim = 0;
    self.var_9eb700da delete();
    self.var_9eb700da = undefined;
    self clearentitytarget();
    if (isdefined(self.var_d1ddf246)) {
        self.goalradius = self.var_d1ddf246;
        self.var_d1ddf246 = undefined;
    }
    self laseroff();
    if (isdefined(self.__blackboard)) {
        blackboard::setblackboardattribute(self, "_context", undefined);
    }
}

/#

    // Namespace ai_sniper
    // Params 0, eflags: 0x0
    // Checksum 0xb0a30915, Offset: 0xc08
    // Size: 0x75
    function function_d065af50() {
        self endon(#"death");
        lastpos = self.origin;
        while (true) {
            debugstar(self.origin, 1, (1, 0, 0));
            line(self.origin, lastpos, (1, 0, 0), 1, 0, 20);
            lastpos = self.origin;
            wait 0.05;
        }
    }

#/

// Namespace ai_sniper
// Params 0, eflags: 0x0
// Checksum 0x970340bb, Offset: 0xc88
// Size: 0x75
function function_2ba378ce() {
    self endon(#"death");
    self endon(#"hash_565daac6");
    var_bef987c0 = gettime();
    while (true) {
        if (self asmistransdecrunning()) {
            var_bef987c0 = gettime();
            self laseroff();
        } else if (gettime() - var_bef987c0 > 350) {
            self laseron();
        }
        wait 0.05;
    }
}

// Namespace ai_sniper
// Params 0, eflags: 0x0
// Checksum 0xdb748ed0, Offset: 0xd08
// Size: 0x2a
function function_659cb4db() {
    self endon(#"hash_565daac6");
    self waittill(#"death");
    if (isdefined(self)) {
        self laseroff();
    }
}

// Namespace ai_sniper
// Params 1, eflags: 0x0
// Checksum 0xd06961a2, Offset: 0xd40
// Size: 0x8e
function function_9bab0bf(var_79b9c7a7) {
    if (!isdefined(var_79b9c7a7)) {
        return (0, 0, 0);
    }
    result = var_79b9c7a7;
    if (!isvec(var_79b9c7a7) && isdefined(var_79b9c7a7.origin)) {
        result = var_79b9c7a7.origin;
        if (isplayer(var_79b9c7a7) || isactor(var_79b9c7a7)) {
            result = var_79b9c7a7 geteye();
        }
    }
    return result;
}

// Namespace ai_sniper
// Params 3, eflags: 0x0
// Checksum 0xe4c009e6, Offset: 0xdd8
// Size: 0x2dd
function function_cc2a65b3(v_eye, var_f1f6e3d, var_717108ce) {
    self notify(#"hash_d7925cd8");
    self endon(#"hash_d7925cd8");
    self endon(#"death");
    if (!isdefined(level.var_b8032721)) {
        level.var_b8032721 = [];
    }
    if (!isdefined(level.var_2b420add)) {
        level.var_2b420add = 0;
    }
    while (true) {
        var_6121992f = vectornormalize(self.origin - v_eye);
        if (gettime() > level.var_2b420add) {
            level.var_b8032721 = getplayers();
            var_28a2096c = getaiteamarray("allies");
            foreach (actor in var_28a2096c) {
                if (isdefined(actor.ignoreme) && actor.ignoreme) {
                    continue;
                }
                if (isalive(actor)) {
                    level.var_b8032721[level.var_b8032721.size] = actor;
                }
            }
            level.var_2b420add = gettime() + 1000;
        }
        for (i = 0; i < level.var_b8032721.size; i++) {
            ally = level.var_b8032721[i];
            if (!isalive(ally)) {
                continue;
            }
            if (isdefined(ally.ignoreme) && (ally isnotarget() || ally.ignoreme)) {
                continue;
            }
            var_633cfa62 = function_9bab0bf(ally);
            var_c4827684 = vectornormalize(var_633cfa62 - v_eye);
            if (vectordot(var_6121992f, var_c4827684) < 0.7) {
                continue;
            }
            var_6a3f5d89 = pointonsegmentnearesttopoint(v_eye, self.origin, var_633cfa62);
            if (distancesquared(var_633cfa62, var_6a3f5d89) < 40000) {
                if (sighttracepassed(v_eye, var_633cfa62, 0, undefined)) {
                    if (isdefined(var_717108ce)) {
                        var_717108ce notify(#"alert", "combat", var_633cfa62, ally);
                    }
                    self function_b77b41d1(v_eye, ally, var_717108ce);
                    break;
                }
            }
        }
        wait 0.05;
    }
}

// Namespace ai_sniper
// Params 4, eflags: 0x0
// Checksum 0x77a1f7f8, Offset: 0x10c0
// Size: 0x8a
function function_b77b41d1(v_eye, var_79b9c7a7, var_717108ce, var_12065f0b) {
    if (!isdefined(var_12065f0b)) {
        var_12065f0b = 1;
    }
    var_5143a614 = 7;
    if (isdefined(self.var_717108ce) && isdefined(self.var_717108ce.var_815502c4)) {
        var_5143a614 = self.var_717108ce.var_815502c4;
    }
    self function_e57ea743(v_eye, var_79b9c7a7, var_5143a614, var_717108ce, 1, var_12065f0b);
}

// Namespace ai_sniper
// Params 2, eflags: 0x0
// Checksum 0xecc5253d, Offset: 0x1158
// Size: 0x1d3
function function_6eceec3e(var_f1f6e3d, e_owner) {
    self notify(#"hash_565daac6");
    self endon(#"hash_565daac6");
    self endon(#"death");
    pausetime = randomfloatrange(2, 4);
    if (isarray(var_f1f6e3d) && var_f1f6e3d.size <= 0) {
        return;
    }
    index = 0;
    start = var_f1f6e3d;
    while (true) {
        while (isdefined(self.var_8722cfb)) {
            wait 0.05;
            continue;
        }
        if (isarray(var_f1f6e3d)) {
            self function_5ee81302(var_f1f6e3d[index], e_owner);
            if (!isvec(var_f1f6e3d[index]) && isdefined(var_f1f6e3d[index].script_wait)) {
                wait var_f1f6e3d[index].script_wait;
            }
        } else {
            var_f1f6e3d = function_b75b8fc4(var_f1f6e3d);
            self function_5ee81302(var_f1f6e3d, e_owner);
            if (!isvec(var_f1f6e3d) && isdefined(var_f1f6e3d.script_wait)) {
                wait var_f1f6e3d.script_wait;
            }
        }
        looped = 0;
        if (isarray(var_f1f6e3d)) {
            index += 1;
            if (index >= var_f1f6e3d.size) {
                index = 0;
                looped = 1;
            }
        } else if (var_f1f6e3d == start) {
            looped = 1;
        }
        if (looped) {
            self notify(#"hash_b39fffd7");
            if (isdefined(e_owner)) {
                e_owner notify(#"hash_b39fffd7");
            }
        }
    }
}

// Namespace ai_sniper
// Params 3, eflags: 0x0
// Checksum 0x4594bfb2, Offset: 0x1338
// Size: 0x2bd
function function_9c1ac1cb(endposition, totaltime, var_5d61a864) {
    self notify(#"hash_9c1ac1cb");
    self endon(#"hash_9c1ac1cb");
    self endon(#"death");
    startposition = self.origin;
    startvelocity = self.velocity;
    var_c8240fdb = vectornormalize(self.velocity);
    var_ed017668 = totaltime * 4;
    phase = length(self.velocity) / var_ed017668 * 2;
    starttime = gettime();
    totaltimems = totaltime * 1000;
    var_1632b53d = totaltimems * 0.75;
    notified = 0;
    var_3d372c1a = 65000;
    if (!isdefined(var_5d61a864) || var_5d61a864) {
        self endon(#"hash_9744842a");
    }
    while (gettime() - starttime < totaltimems) {
        if (!notified && gettime() - starttime > var_1632b53d) {
            self notify(#"hash_9744842a");
            notified = 1;
        }
        deltatime = float(gettime() - starttime) / 1000;
        var_67fe8eb1 = min(deltatime, var_ed017668);
        var_e42cf565 = startposition + startvelocity * var_67fe8eb1;
        var_7a592a87 = var_e42cf565 + var_c8240fdb * phase * -0.5 * var_67fe8eb1 * var_67fe8eb1;
        coef = deltatime / totaltime;
        coef = 1 - 0.5 + cos(coef * -76) * 0.5;
        var_515ca7cf = endposition;
        assert(isdefined(var_515ca7cf));
        neworigin = vectorlerp(var_7a592a87, var_515ca7cf, coef);
        self.velocity = (neworigin - self.origin) / 0.05;
        if (neworigin[0] > var_3d372c1a * -1 && neworigin[0] < var_3d372c1a && neworigin[1] > var_3d372c1a * -1 && neworigin[1] < var_3d372c1a && neworigin[2] > var_3d372c1a * -1 && neworigin[2] < var_3d372c1a) {
            self.origin = neworigin;
        }
        wait 0.05;
    }
}

// Namespace ai_sniper
// Params 1, eflags: 0x0
// Checksum 0x6250d3ff, Offset: 0x1600
// Size: 0x125
function function_b75b8fc4(node) {
    if (!isdefined(node)) {
        return undefined;
    }
    var_e236c887 = undefined;
    var_702f594c = undefined;
    if (isdefined(node.target) && isdefined(node.script_linkto)) {
        var_e236c887 = struct::get(node.target, "targetname");
        var_702f594c = struct::get(node.script_linkto, "script_linkname");
    } else if (isdefined(node.target)) {
        var_e236c887 = struct::get(node.target, "targetname");
    } else if (isdefined(node.script_linkto)) {
        var_e236c887 = struct::get(node.script_linkto, "script_linkname");
    }
    if (isdefined(var_e236c887) && isdefined(var_702f594c)) {
        if (randomfloatrange(0, 1) < 0.5) {
            return var_e236c887;
        }
        return var_702f594c;
    }
    return var_e236c887;
}

// Namespace ai_sniper
// Params 2, eflags: 0x0
// Checksum 0xaa54859a, Offset: 0x1730
// Size: 0x15c
function function_5ee81302(var_79b9c7a7, owner) {
    self notify(#"hash_5ee81302");
    self endon(#"hash_5ee81302");
    self endon(#"death");
    if (isentity(var_79b9c7a7)) {
        var_79b9c7a7 endon(#"death");
        while (true) {
            point = function_9bab0bf(var_79b9c7a7);
            delta = point - self.origin;
            delta *= 0.2;
            self.origin = self.origin + delta;
            wait 0.05;
        }
        return;
    }
    speed = 200;
    point = function_9bab0bf(var_79b9c7a7);
    time = distance(point, self.origin) / speed;
    var_779fd53f = 0;
    if (isdefined(owner) && isdefined(owner.var_26c21ea3)) {
        var_779fd53f = 1;
        time = min(time, owner.var_26c21ea3);
    }
    if (time > 0) {
        self thread function_9c1ac1cb(point, time, var_779fd53f);
        self waittill(#"hash_9744842a");
    }
}

// Namespace ai_sniper
// Params 6, eflags: 0x0
// Checksum 0x3feec10a, Offset: 0x1898
// Size: 0x1d1
function function_e57ea743(v_eye, var_79b9c7a7, var_5143a614, var_717108ce, fire_weapon, var_12065f0b) {
    if (!isdefined(var_12065f0b)) {
        var_12065f0b = 1;
    }
    if (!var_12065f0b || isdefined(self.var_8722cfb) && self.var_8722cfb == var_79b9c7a7) {
        return;
    }
    self notify(#"hash_e57ea743");
    self endon(#"hash_e57ea743");
    self endon(#"death");
    self.var_8722cfb = var_79b9c7a7;
    self thread function_5ee81302(var_79b9c7a7, var_717108ce);
    var_2cbaef6c = 0;
    var_4bbe1b92 = 0;
    var_94a708a2 = 0;
    if (isdefined(var_717108ce.var_dfa3c2cb)) {
        var_94a708a2 = var_717108ce.var_dfa3c2cb;
    }
    if (!isdefined(fire_weapon)) {
        fire_weapon = 1;
    }
    while (true) {
        if (var_4bbe1b92 >= var_94a708a2) {
            if (isactor(var_717108ce)) {
                var_717108ce.holdfire = !fire_weapon;
                if (fire_weapon) {
                    var_717108ce.var_8c2ddc6 = gettime();
                }
            }
        }
        if (!isdefined(var_79b9c7a7) || var_2cbaef6c >= var_5143a614) {
            self notify(#"hash_5ee81302");
            break;
        }
        if (!sighttracepassed(v_eye, function_9bab0bf(var_79b9c7a7), 0, undefined)) {
            var_2cbaef6c += 0.05;
        } else {
            var_2cbaef6c = 0;
        }
        var_4bbe1b92 += 0.05;
        wait 0.05;
    }
    if (isactor(var_717108ce)) {
        var_717108ce.holdfire = 1;
    }
    self.var_8722cfb = undefined;
}

// Namespace ai_sniper
// Params 1, eflags: 0x0
// Checksum 0x6cf20d5a, Offset: 0x1a78
// Size: 0x32
function is_firing(var_717108ce) {
    if (!isdefined(var_717108ce)) {
        return false;
    }
    if (!isdefined(var_717108ce.var_8c2ddc6)) {
        return false;
    }
    return gettime() - var_717108ce.var_8c2ddc6 < 3000;
}

