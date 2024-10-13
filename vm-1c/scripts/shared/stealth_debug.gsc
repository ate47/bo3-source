#using scripts/shared/stealth_actor;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;

#namespace stealth_debug;

/#

    // Namespace stealth_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8e310234, Offset: 0x110
    // Size: 0x84
    function init() {
        if (isdefined(self.stealth)) {
            self.stealth.var_6926a825 = "<dev string:x28>";
        }
        var_c39a9f3e = getdvarint("<dev string:x29>", -1);
        if (var_c39a9f3e == -1) {
            setdvar("<dev string:x29>", 0);
        }
    }

    // Namespace stealth_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa5846daa, Offset: 0x1a0
    // Size: 0x24
    function enabled() {
        return getdvarint("<dev string:x29>", 0);
    }

    // Namespace stealth_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0x234ae209, Offset: 0x1d0
    // Size: 0x84
    function init_debug() {
        if (self == level) {
            self thread function_70b08fc4();
        }
        if (isactor(self) && enabled()) {
            self thread function_53d6792c();
            self thread function_2dd1012();
        }
    }

    // Namespace stealth_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe66d7c4f, Offset: 0x260
    // Size: 0x23a
    function function_70b08fc4() {
        self notify(#"hash_70b08fc4");
        self endon(#"hash_70b08fc4");
        prevvalue = enabled();
        while (true) {
            if (enabled() != prevvalue) {
                entities = getentarray();
                if (enabled()) {
                    foreach (entity in entities) {
                        if (isactor(entity) && entity stealth_actor::enabled()) {
                            entity thread function_53d6792c();
                            entity thread function_2dd1012();
                        }
                    }
                } else {
                    foreach (entity in entities) {
                        if (isactor(entity) && entity stealth_actor::enabled()) {
                            entity notify(#"hash_53d6792c");
                            entity notify(#"hash_2dd1012");
                        }
                    }
                }
                prevvalue = enabled();
            }
            wait 1;
        }
    }

    // Namespace stealth_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0xee996c91, Offset: 0x4a8
    // Size: 0x398
    function function_53d6792c() {
        self notify(#"hash_53d6792c");
        self endon(#"hash_53d6792c");
        self endon(#"death");
        self endon(#"stop_stealth");
        while (true) {
            if (enabled()) {
                origin = self.origin;
                print3d(origin, "<dev string:x28>" + self.awarenesslevelcurrent, stealth::function_b7ff7c00(self.awarenesslevelcurrent), 1, 0.5, 1);
                origin = (origin[0], origin[1], origin[2] + 15);
                if (isdefined(self.stealth.var_6926a825) && self.stealth.var_6926a825 != "<dev string:x28>" && self.awarenesslevelcurrent != "<dev string:x37>") {
                    print3d(origin, self.stealth.var_6926a825, stealth::function_b7ff7c00(self.awarenesslevelcurrent), 1, 0.5, 1);
                    origin = (origin[0], origin[1], origin[2] + 15);
                }
                if (isdefined(self.enemy)) {
                    print3d(origin, "<dev string:x3f>" + self.enemy getentitynumber() + "<dev string:x48>", stealth::function_b7ff7c00(self.awarenesslevelcurrent), 1, 0.5, 1);
                    origin = (origin[0], origin[1], origin[2] + 15);
                }
                if (isdefined(self.stealth.var_85e6f33c) && self.stealth.var_85e6f33c != "<dev string:x28>") {
                    print3d(origin, self.stealth.var_85e6f33c, stealth::function_b7ff7c00(self.awarenesslevelcurrent), 1, 0.5, 1);
                    origin = (origin[0], origin[1], origin[2] + 15);
                }
                if (isdefined(self.stealth.var_edba2e78)) {
                    box(self.stealth.var_edba2e78, (-16, -16, 0), (16, 16, 60), 0, (1, 0, 1));
                    line(self.origin + (0, 0, 80), self.stealth.var_edba2e78 + (0, 0, 60), (1, 0, 1));
                }
            }
            wait 0.05;
        }
    }

    // Namespace stealth_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc94171c7, Offset: 0x848
    // Size: 0x2f8
    function function_2dd1012() {
        self notify(#"hash_2dd1012");
        self endon(#"hash_2dd1012");
        self endon(#"death");
        self endon(#"stop_stealth");
        if (!isactor(self)) {
            return;
        }
        wait 0.05;
        while (true) {
            wait 0.05;
            if (enabled()) {
                awareness = self stealth_aware::function_739525d();
                var_1118b447 = level.stealth.var_1118b447.awareness[awareness];
                if (enabled() > 1) {
                    var_80364fb2 = (0, self gettagangles("<dev string:x4b>")[1], 0);
                    color = (0.5, 0.5, 0.5);
                    foreach (enemy in level.stealth.enemies[self.team]) {
                        if (self cansee(enemy)) {
                            color = (1, 0.5, 0);
                            break;
                        }
                    }
                    if (awareness != "<dev string:x53>") {
                        self function_2188901b(self.origin + (0, 0, 16), var_80364fb2, self.fovcosine, self.fovcosinez, sqrt(self.maxsightdistsqrd), color);
                    }
                }
                pointofinterest = self geteventpointofinterest();
                if (isdefined(pointofinterest)) {
                    color = stealth::function_b7ff7c00(awareness);
                    line(self.origin, pointofinterest, color, 0, 1);
                    debugstar(pointofinterest, 1, color);
                }
            }
        }
    }

    // Namespace stealth_debug
    // Params 6, eflags: 0x1 linked
    // Checksum 0x65559ce3, Offset: 0xb48
    // Size: 0x3f8
    function function_2188901b(origin, angles, fovcosine, fovcosinez, viewdist, color) {
        var_b5f739f1 = acos(fovcosine);
        var_d69e0db2 = acos(fovcosinez);
        height = tan(var_d69e0db2) * viewdist;
        fwd = anglestoforward((0, angles[1], 0));
        var_cb5028c4 = anglestoforward((0, angles[1] + var_b5f739f1, 0));
        var_4e576457 = anglestoforward((0, angles[1] - var_b5f739f1, 0));
        v_left_end = origin + var_cb5028c4 * viewdist;
        v_right_end = origin + var_4e576457 * viewdist;
        util::debug_line(origin, v_left_end, color, 1, 1, 1);
        util::debug_line(origin, v_right_end, color, 1, 1, 1);
        var_3a111617 = origin + fwd * viewdist;
        var_140e9bae = origin + fwd * viewdist + (0, 0, height);
        util::debug_line(var_3a111617, var_140e9bae, color, 1, 1, 1);
        util::debug_line(var_140e9bae, origin, color, 1, 1, 1);
        var_876d8fae = [];
        var_27175f0d = var_b5f739f1 * 2 / 10;
        for (j = 1; j < 10 - 1; j++) {
            n_angle = angles[1] - var_b5f739f1 + var_27175f0d * j;
            v_dir = anglestoforward((0, n_angle, 0));
            var_876d8fae[var_876d8fae.size] = v_dir * viewdist + origin;
        }
        var_876d8fae[var_876d8fae.size] = v_left_end;
        var_be3a488f = v_right_end;
        var_2233fb24 = undefined;
        for (j = 0; j < var_876d8fae.size; j++) {
            var_2233fb24 = var_876d8fae[j];
            util::debug_line(var_be3a488f, var_2233fb24, color, 1, 1, 1);
            var_be3a488f = var_2233fb24;
        }
    }

    // Namespace stealth_debug
    // Params 6, eflags: 0x1 linked
    // Checksum 0xc53de8f7, Offset: 0xf48
    // Size: 0x478
    function function_1c1f41ef(text, color, alpha, scale, origin, life) {
        spacing = 10;
        riserate = 3;
        if (!isdefined(origin) || !isdefined(text)) {
            return;
        }
        start = gettime();
        if (!isdefined(self.stealth.debug_rising)) {
            self.stealth.debug_rising = [];
            self.stealth.var_53fc8847 = -1;
        }
        self.stealth.var_53fc8847++;
        myid = self.stealth.var_53fc8847;
        self.stealth.debug_rising[myid] = origin;
        for (previd = myid - 1; isdefined(self.stealth.debug_rising[previd]); previd -= 1) {
            delta = self.stealth.debug_rising[previd][2] - self.stealth.debug_rising[previd + 1][2];
            if (delta >= spacing) {
                break;
            }
            self.stealth.debug_rising[previd] = (self.stealth.debug_rising[previd][0], self.stealth.debug_rising[previd][1], self.stealth.debug_rising[previd + 1][2] + spacing + delta);
        }
        draworigin = self.stealth.debug_rising[myid];
        while (gettime() - start < life * 1000) {
            wait 0.05;
            if (isdefined(self) && isalive(self) && isdefined(self.stealth) && isdefined(self.stealth.debug_rising) && isdefined(self.stealth.debug_rising[myid])) {
                draworigin = self.stealth.debug_rising[myid];
            }
            print3d(draworigin, text, color, alpha, scale, 1);
            draworigin = (draworigin[0], draworigin[1], draworigin[2] + riserate);
            if (isdefined(self) && isalive(self) && isdefined(self.stealth) && isdefined(self.stealth.debug_rising) && isdefined(self.stealth.debug_rising[myid])) {
                self.stealth.debug_rising[myid] = (self.stealth.debug_rising[myid][0], self.stealth.debug_rising[myid][1], self.stealth.debug_rising[myid][2] + riserate);
            }
        }
        if (isdefined(self) && isalive(self) && isdefined(self.stealth) && isdefined(self.stealth.debug_rising) && isdefined(self.stealth.debug_rising[myid])) {
            self.stealth.debug_rising[myid] = undefined;
        }
    }

    // Namespace stealth_debug
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2db4fedc, Offset: 0x13c8
    // Size: 0xae
    function debug_text(var_37b8a117) {
        if (!isdefined(var_37b8a117)) {
            return "<dev string:x5a>";
        }
        if (isweapon(var_37b8a117)) {
            return ("<dev string:x66>" + var_37b8a117.name + "<dev string:x6e>");
        }
        if (isentity(var_37b8a117)) {
            return ("<dev string:x70>" + var_37b8a117 getentitynumber() + "<dev string:x6e>");
        }
        return "<dev string:x28>" + var_37b8a117;
    }

#/
