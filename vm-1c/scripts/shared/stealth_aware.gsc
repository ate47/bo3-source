#using scripts/shared/ai_sniper_shared;
#using scripts/shared/stealth_vo;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth_level;
#using scripts/shared/stealth_event;
#using scripts/shared/stealth_player;
#using scripts/shared/stealth_behavior;
#using scripts/shared/stealth;
#using scripts/shared/ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;

#namespace namespace_80045451;

// Namespace namespace_80045451
// Params 0, eflags: 0x1 linked
// Checksum 0x6f2fe7f1, Offset: 0x318
// Size: 0xac
function init() {
    assert(isdefined(self.stealth));
    self.stealth.var_d1b49f30 = [];
    self.stealth.var_c49c37ed = [];
    self.stealth.var_7a604d90 = [];
    /#
        self.stealth.var_1d4ba64b = [];
    #/
    self function_a2429809("unaware");
    self thread function_a85b6c52();
}

// Namespace namespace_80045451
// Params 0, eflags: 0x1 linked
// Checksum 0x98439db6, Offset: 0x3d0
// Size: 0x20
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.var_d1b49f30);
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0x6fc52195, Offset: 0x3f8
// Size: 0x48c
function function_a2429809(var_12131b3c) {
    assert(self enabled());
    var_b3c4b275 = self.awarenesslevelcurrent;
    if (!isdefined(var_b3c4b275)) {
        var_b3c4b275 = "unaware";
    }
    if (isdefined(self.awarenesslevelcurrent) && self.awarenesslevelcurrent != var_12131b3c) {
        self.awarenesslevelprevious = self.awarenesslevelcurrent;
    }
    self.awarenesslevelcurrent = var_12131b3c;
    var_1d811e47 = self.awarenesslevelcurrent != "combat";
    parms = namespace_ad45a419::function_b3269823(var_12131b3c);
    self.fovcosine = parms.fovcosine;
    self.fovcosinez = parms.fovcosinez;
    self.maxsightdist = parms.maxsightdist;
    self.maxsightdistsqrd = self.maxsightdist * self.maxsightdist;
    self.var_801fa77c = var_1d811e47;
    self setstealthsightawareness(self.awarenesslevelcurrent, var_1d811e47);
    if (isdefined(self.patroller) && self.patroller) {
        self.stealth.var_86030901 = 1;
    } else if (!(isdefined(self.stealth.var_86030901) && self.stealth.var_86030901) && !isdefined(self.stealth.var_b463484b) && self.awarenesslevelcurrent != "unaware") {
        self.stealth.var_b463484b = self.origin;
    }
    switch (self.awarenesslevelcurrent) {
    case 2:
    case 3:
    default:
        self function_216be1d1(1);
        break;
    }
    if (var_12131b3c == "unaware") {
        self.stealth.var_d1b49f30 = [];
        self.stealth.var_c49c37ed = [];
        self.stealth.var_7a604d90 = [];
        self serviceeventsinradius(self.origin, -1);
        if (isactor(self)) {
            self clearenemy();
        }
        self.awarenesslevelprevious = "unaware";
        if (isdefined(self.stealth.var_86030901) && self.stealth.var_86030901 && isdefined(self.currentgoal)) {
            self thread ai::patrol(self.currentgoal);
        } else if (isdefined(self.stealth.var_b463484b)) {
            if (isactor(self)) {
                self thread namespace_7829c86f::function_edba2e78(self.stealth.var_b463484b);
            }
            self.stealth.var_b463484b = undefined;
        }
    }
    if (self ai::has_behavior_attribute("stealth")) {
        self ai::set_behavior_attribute("stealth", var_1d811e47);
    }
    if (self ai::has_behavior_attribute("disablearrivals")) {
        self ai::set_behavior_attribute("disablearrivals", var_1d811e47);
    }
    if (self namespace_234a4910::enabled()) {
        self namespace_234a4910::set_stealth_mode(var_1d811e47);
    }
    if (var_b3c4b275 != var_12131b3c) {
        self notify(#"awareness", var_12131b3c);
    }
    if (var_1d811e47) {
        self.stealth.var_d1b49f30 = [];
    }
}

// Namespace namespace_80045451
// Params 0, eflags: 0x1 linked
// Checksum 0xa0b90120, Offset: 0x890
// Size: 0xa
function function_739525d() {
    return self.awarenesslevelcurrent;
}

// Namespace namespace_80045451
// Params 1, eflags: 0x0
// Checksum 0xa8f6d3fe, Offset: 0x8a8
// Size: 0x36
function function_e5e8ce80(entity) {
    return isdefined(self.stealth.var_c49c37ed[entity getentitynumber()]);
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0xd97730ba, Offset: 0x8e8
// Size: 0x1dc
function function_c82b617b(delta) {
    assert(self enabled());
    var_f93ad764 = self.awarenesslevelcurrent;
    var_83d91027 = abs(delta);
    if (var_83d91027 > 1) {
        for (i = 0; i < var_83d91027; i++) {
            if (delta > 0) {
                function_c82b617b(1);
                continue;
            }
            function_c82b617b(-1);
        }
        return (var_f93ad764 != self.awarenesslevelcurrent);
    }
    if (delta > 0) {
        switch (self.awarenesslevelcurrent) {
        case 3:
        default:
            self function_a2429809("high_alert");
            break;
        case 2:
            self function_a2429809("combat");
            break;
        }
    } else {
        switch (self.awarenesslevelcurrent) {
        case 2:
        case 3:
            self function_a2429809("unaware");
            break;
        case 1:
            self function_a2429809("high_alert");
            break;
        }
    }
    return var_f93ad764 != self.awarenesslevelcurrent;
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0xf71ac81a, Offset: 0xad0
// Size: 0xe2
function function_216be1d1(ignore) {
    assert(self enabled());
    foreach (enemy in level.stealth.enemies[self.team]) {
        if (!isdefined(enemy)) {
            continue;
        }
        self function_c62ada65(enemy, ignore);
    }
}

// Namespace namespace_80045451
// Params 2, eflags: 0x1 linked
// Checksum 0xe2aed551, Offset: 0xbc0
// Size: 0xf4
function function_c62ada65(sentient, ignore) {
    assert(self enabled());
    if (issentient(self) && issentient(sentient)) {
        self setignoreent(sentient, ignore);
    }
    /#
        if (ignore) {
            self.stealth.var_1d4ba64b[sentient getentitynumber()] = sentient;
            return;
        }
        self.stealth.var_1d4ba64b[sentient getentitynumber()] = undefined;
    #/
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0x2b0b1d2e, Offset: 0xcc0
// Size: 0x84
function function_ca6a0809(var_904f1fb9) {
    self endon(#"death");
    self endon(#"disconnect");
    e_originator = var_904f1fb9.parms[0];
    self notify(#"hash_234a4910", "alert");
    if (isplayer(e_originator)) {
        e_originator namespace_10443be6::function_ca6a0809(self);
    }
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0xd5f98e8a, Offset: 0xd50
// Size: 0x2ce
function function_617b90af(var_904f1fb9) {
    e_originator = var_904f1fb9.parms[0];
    if (!isdefined(e_originator)) {
        return;
    }
    debugreason = "";
    var_1f6ae92b = "unaware";
    var_fc08c604 = self function_739525d();
    var_f51f605d = e_originator getentitynumber();
    if (self stealth::function_2cfe5148(e_originator) && isalive(e_originator)) {
        var_1f6ae92b = "combat";
        /#
            debugreason = "stealth_no_return";
        #/
    } else if (e_originator enabled() && e_originator function_739525d() == "combat") {
        var_1f6ae92b = "high_alert";
        /#
            debugreason = "stealth_no_return";
        #/
    }
    var_edfa68f2 = 0;
    if (stealth::function_b889e36b(var_fc08c604, var_1f6ae92b) < 0) {
        var_edfa68f2 = self function_c82b617b(1);
    }
    if (var_edfa68f2 || !isdefined(self.stealth.var_c49c37ed[var_f51f605d]) || !isdefined(self.stealth.var_7a604d90[var_f51f605d])) {
        var_fc08c604 = self function_739525d();
        self notify(#"alert", var_fc08c604, e_originator.origin + (0, 0, 20), e_originator, debugreason);
        if (var_edfa68f2 && var_fc08c604 != "combat" && issentient(e_originator)) {
            self setstealthsightvalue(e_originator, 0);
        }
    }
    if (isdefined(e_originator) && self stealth::function_2cfe5148(e_originator)) {
        self.stealth.var_c49c37ed[var_f51f605d] = e_originator;
        self.stealth.var_7a604d90[var_f51f605d] = e_originator;
    }
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0xea238e8b, Offset: 0x1028
// Size: 0x2fe
function function_85b3a352(var_904f1fb9) {
    self endon(#"death");
    self endon(#"disconnect");
    if (getdvarint("stealth_no_return") && self function_739525d() == "combat") {
        return;
    }
    e_originator = var_904f1fb9.parms[0];
    var_7febec6d = "on_sight_end";
    if (isdefined(e_originator)) {
        var_7febec6d = var_7febec6d + "_" + e_originator getentitynumber();
    }
    self notify(var_7febec6d);
    self endon(var_7febec6d);
    var_5400af02 = stealth::function_b889e36b(self function_739525d(), "unaware");
    if (self.stealth.investigating != "infinite" || isdefined(self.stealth.investigating) && var_5400af02 == 1) {
        self waittill(#"hash_2481442d");
    }
    maxsightvalue = 0;
    foreach (enemy in self.stealth.var_c49c37ed) {
        if (!isdefined(enemy)) {
            continue;
        }
        if (!issentient(enemy)) {
            continue;
        }
        maxsightvalue = max(maxsightvalue, self getstealthsightvalue(enemy));
    }
    if (maxsightvalue <= 0 && self function_c82b617b(-1)) {
        if (self function_739525d() != "unaware") {
            if (isdefined(e_originator)) {
                if (issentient(e_originator)) {
                    self setstealthsightvalue(e_originator, 1);
                }
                return;
            }
            self notify(#"investigate", self.origin, undefined, "quick");
        }
    }
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0x43368798, Offset: 0x1330
// Size: 0x634
function function_6c10e440(var_904f1fb9) {
    var_effa6151 = self geteventpointofinterest();
    v_origin = var_effa6151;
    e_originator = self getcurrenteventoriginator();
    i_id = self getcurrenteventid();
    str_typename = self getcurrenteventtypename();
    var_d3a202ad = var_904f1fb9.parms[0];
    if (isdefined(str_typename) && str_typename == "grenade_ping") {
        var_d3a202ad = "combat";
    }
    if (var_d3a202ad == "low_alert") {
        var_d3a202ad = "high_alert";
    }
    if (isdefined(var_904f1fb9.parms[1])) {
        v_origin = var_904f1fb9.parms[1];
    }
    if (isdefined(var_904f1fb9.parms[2])) {
        e_originator = var_904f1fb9.parms[2];
    }
    if (stealth::function_b889e36b(var_d3a202ad, self function_739525d()) >= 0) {
        if (isdefined(v_origin)) {
            if (!isdefined(var_effa6151) || distancesquared(v_origin, var_effa6151) > 0.1) {
                deltaorigin = v_origin - self.origin;
                var_9d3fe635 = vectortoangles(deltaorigin);
                self.var_5ded47f6 = absangleclamp360(self.angles[1] - var_9d3fe635[1]);
            }
            if (isactor(self)) {
                if (var_d3a202ad == "combat" && isdefined(e_originator)) {
                    self thread function_20519577(e_originator, 0.5);
                } else {
                    self thread function_20519577(v_origin, 0.5);
                }
            }
        }
        /#
            debugreason = self getcurrenteventtypename() + self getcurrenteventname();
            if (!isdefined(debugreason) || debugreason == "stealth_no_return") {
                debugreason = "stealth_no_return";
            }
            if (isdefined(e_originator) && iscorpse(e_originator)) {
                debugreason = "stealth_no_return";
            }
            if (var_904f1fb9.parms.size > 1) {
                debugreason = var_904f1fb9.parms[var_904f1fb9.parms.size - 1];
            }
            if (isdefined(debugreason) && isstring(debugreason)) {
                self.stealth.var_6926a825 = debugreason;
            }
        #/
        if (str_typename == "explosion") {
            self notify(#"hash_234a4910", "explosion");
        } else if (isdefined(e_originator) && iscorpse(e_originator)) {
            self notify(#"hash_234a4910", "corpse");
        }
        self function_a2429809(var_d3a202ad);
        switch (var_d3a202ad) {
        case 2:
        case 3:
            self notify(#"investigate", v_origin, e_originator);
            break;
        }
        if (isdefined(i_id) && isdefined(e_originator) && iscorpse(e_originator)) {
            self thread function_e7cf1d24(8, i_id);
        }
        if (isplayer(e_originator) && var_d3a202ad == "combat" && level.stealth.var_e7ad9c1f == 0) {
            if (isdefined(self.blindaim) && self.blindaim) {
                e_originator namespace_234a4910::function_e3ae87b3("spotted_sniper", self, 2);
            } else if (isvehicle(self)) {
                e_originator namespace_234a4910::function_e3ae87b3("spotted_drone", self, 2);
            } else {
                e_originator namespace_234a4910::function_e3ae87b3("spotted", self, 2);
            }
        }
    }
    if (isdefined(e_originator) && self stealth::function_2cfe5148(e_originator)) {
        self.stealth.var_c49c37ed[e_originator getentitynumber()] = e_originator;
        if (var_d3a202ad == "combat") {
            self function_bc0ce0bf(e_originator);
        }
    }
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0xd0a7d45e, Offset: 0x1970
// Size: 0x9e
function function_101ac5(var_904f1fb9) {
    e_originator = var_904f1fb9.parms[0];
    if (!isentity(e_originator)) {
        return;
    }
    if (stealth::function_b889e36b(self.awarenesslevelcurrent, self.awarenesslevelprevious) > 0) {
        self notify(#"alert", "combat", e_originator.origin, e_originator, "close_combat");
    }
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0x4f3f1ec8, Offset: 0x1a18
// Size: 0x244
function function_933965f6(var_904f1fb9) {
    e_originator = var_904f1fb9.parms[0];
    var_62bc230d = var_904f1fb9.parms[1];
    if (self.awarenesslevelcurrent != "unaware") {
        return;
    }
    if (!isentity(e_originator)) {
        return;
    }
    if (!isentity(var_62bc230d)) {
        return;
    }
    if (stealth::function_b889e36b(self.awarenesslevelcurrent, self.awarenesslevelprevious) > 0) {
        if (isdefined(self.stealth.var_c9b747e1) && gettime() - self.stealth.var_c9b747e1 < 30000) {
            return;
        }
        goalpos = var_62bc230d getfinalpathpos();
        delta = goalpos - var_62bc230d.origin;
        if (lengthsquared(delta) > 250000) {
            var_fbbdb5f6 = var_62bc230d.origin + vectornormalize(delta) * 500;
            deltaorigin = var_62bc230d.origin - self.origin;
            var_9d3fe635 = vectortoangles(deltaorigin);
            self.var_5ded47f6 = absangleclamp360(self.angles[1] - var_9d3fe635[1]);
            self notify(#"investigate", var_fbbdb5f6, e_originator, "quick");
            self.stealth.var_c9b747e1 = gettime();
        }
    }
}

// Namespace namespace_80045451
// Params 4, eflags: 0x0
// Checksum 0xa69f4bfb, Offset: 0x1c68
// Size: 0x1c2
function function_ec265d65(group, var_d3a202ad, v_origin, e_originator) {
    group = getaiarray(group, "script_aigroup");
    maxdistsq = getdvarint("stealth_group_radius", 1000);
    maxdistsq *= maxdistsq;
    foreach (guy in group) {
        if (guy == self) {
            continue;
        }
        if (!isalive(guy)) {
            continue;
        }
        if (distancesquared(guy.origin, self.origin) > maxdistsq) {
            continue;
        }
        if (stealth::function_b889e36b(var_d3a202ad, guy function_739525d()) <= 0) {
            continue;
        }
        guy util::delay_notify(randomfloatrange(0.33, 0.66), "alert", undefined, var_d3a202ad, v_origin, e_originator);
    }
}

// Namespace namespace_80045451
// Params 2, eflags: 0x1 linked
// Checksum 0xb0e20e5e, Offset: 0x1e38
// Size: 0x25e
function function_20519577(lookat, delay) {
    self notify(#"hash_20519577");
    self endon(#"hash_20519577");
    ent = lookat;
    if (!isentity(lookat)) {
        if (!isdefined(self.var_4e7892f5)) {
            self.var_4e7892f5 = spawn("script_model", lookat);
        }
        ent = self.var_4e7892f5;
    } else if (isdefined(self.var_4e7892f5)) {
        self.var_4e7892f5 delete();
        self.var_4e7892f5 = undefined;
    }
    starttime = gettime();
    delayms = delay * 1000;
    wait(0.2);
    while (isdefined(self.stealth_reacting) && isalive(self) && self.stealth_reacting) {
        if (gettime() - starttime >= delayms) {
            self lookatentity(ent);
            /#
                if (namespace_e449108e::enabled()) {
                    line(self geteye(), ent.origin + (0, 0, 20), (0, 0, 1), 1, 1, 1);
                    debugstar(ent.origin + (0, 0, 20), 1, (0, 0, 1));
                }
            #/
        }
        wait(0.05);
    }
    if (isdefined(self)) {
        self lookatentity();
        if (isdefined(self.var_4e7892f5)) {
            self.var_4e7892f5 delete();
            self.var_4e7892f5 = undefined;
        }
    }
}

// Namespace namespace_80045451
// Params 2, eflags: 0x1 linked
// Checksum 0xa0e34ab3, Offset: 0x20a0
// Size: 0x3c
function function_e7cf1d24(delay, id) {
    self endon(#"death");
    wait(delay);
    self serviceevent(id);
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0xb38445ba, Offset: 0x20e8
// Size: 0xbe
function function_a7964595(var_904f1fb9) {
    self endon(#"death");
    e_attacker = var_904f1fb9.parms[0];
    debugreason = var_904f1fb9.parms[1];
    if (isdefined(e_attacker)) {
        if (stealth::function_b889e36b(self function_739525d(), "high_alert") < 0) {
            self notify(#"alert", "high_alert", e_attacker.origin, e_attacker, debugreason);
        }
    }
}

// Namespace namespace_80045451
// Params 1, eflags: 0x0
// Checksum 0x67f34230, Offset: 0x21b0
// Size: 0x6c
function function_a0693e3b(e_attacker) {
    self endon(#"death");
    if (isdefined(e_attacker) && self enabled()) {
        wait(randomfloatrange(0.25, 0.75));
        self function_bc0ce0bf(e_attacker);
    }
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0xba707156, Offset: 0x2228
// Size: 0x2b2
function function_bc0ce0bf(enemy) {
    if (!self enabled()) {
        return;
    }
    if (!isdefined(enemy) || !self stealth::function_2cfe5148(enemy)) {
        return;
    }
    self namespace_7829c86f::function_2481442d();
    self stopanimscripted();
    enemyentnum = enemy getentitynumber();
    self function_a2429809("combat");
    self function_c62ada65(enemy, 0);
    if (!isdefined(self.stealth.var_d1b49f30[enemyentnum])) {
        self.stealth.var_d1b49f30[enemyentnum] = enemy;
        self.stealth.var_c49c37ed[enemyentnum] = enemy;
        self thread function_899ae538(enemy);
        self notify(#"hash_234a4910", "enemy");
    }
    if (issentient(enemy)) {
        self setstealthsightvalue(enemy, 1);
    }
    self ai_sniper::function_782962c5();
    if (isplayer(enemy) && getdvarint("stealth_all_aware")) {
        foreach (player in level.activeplayers) {
            if (player == enemy) {
                continue;
            }
            playerentnum = player getentitynumber();
            if (!isdefined(self.stealth.var_d1b49f30[playerentnum])) {
                function_bc0ce0bf(player);
            }
        }
    }
}

// Namespace namespace_80045451
// Params 1, eflags: 0x1 linked
// Checksum 0x6b612cef, Offset: 0x24e8
// Size: 0x1f4
function function_899ae538(enemy) {
    self notify("combat_spread_thread_" + enemy getentitynumber());
    self endon("combat_spread_thread_" + enemy getentitynumber());
    self endon(#"death");
    idletime = 0;
    while (true) {
        wait(0.5);
        if (isdefined(self.silenced) && (!isdefined(enemy) || enemy.health <= 0 || self function_739525d() != "combat" || self.silenced)) {
            break;
        }
        self namespace_c8814633::function_7dd521be(self.team, self.origin, -56, 100, 0, "combat_spread", "combat", enemy, self);
        self namespace_c8814633::function_7dd521be(self.team, self.origin, 400, 300, 1, "combat_interest", enemy, self);
        if (!isdefined(self.enemy) || !self stealth::can_see(self.enemy)) {
            self setstealthsightawareness(self.awarenesslevelcurrent, 1);
            continue;
        }
        self setstealthsightawareness(self.awarenesslevelcurrent, 0);
    }
    self setstealthsightawareness(self.awarenesslevelcurrent, 1);
}

// Namespace namespace_80045451
// Params 0, eflags: 0x1 linked
// Checksum 0xd0fc0bcd, Offset: 0x26e8
// Size: 0x11a
function function_a85b6c52() {
    self endon(#"death");
    while (true) {
        self waittill(#"enemy");
        while (isdefined(self.enemy) && isalive(self.enemy)) {
            if (isdefined(self.enemy.var_8722cfb.civilian) && isdefined(self.enemy.var_8722cfb) && (isdefined(self.enemy.civilian) && self.enemy.civilian || self.enemy.var_8722cfb.civilian)) {
                self.avoid_cover = 1;
                self.silentshot = 1;
            } else {
                self.avoid_cover = undefined;
                self.silentshot = 0;
            }
            wait(0.05);
        }
        self notify(#"stealth_sight_end", self.enemy);
    }
}

