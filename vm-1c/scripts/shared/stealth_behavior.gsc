#using scripts/shared/stealth_vo;
#using scripts/shared/stealth_player;
#using scripts/shared/stealth_actor;
#using scripts/shared/stealth_aware;
#using scripts/shared/ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;

#namespace namespace_7829c86f;

// Namespace namespace_7829c86f
// Params 1, eflags: 0x1 linked
// namespace_7829c86f<file_0>::function_de77b9e6
// Checksum 0x8787611, Offset: 0x1a8
// Size: 0xcc
function function_de77b9e6(var_904f1fb9) {
    if (!isactor(self) || !isalive(self)) {
        return;
    }
    v_origin = var_904f1fb9.parms[0];
    e_originator = var_904f1fb9.parms[1];
    str_type = var_904f1fb9.parms[2];
    if (isdefined(v_origin)) {
        self thread function_b78807a5(v_origin, e_originator, str_type);
    }
}

// Namespace namespace_7829c86f
// Params 3, eflags: 0x1 linked
// namespace_7829c86f<file_0>::function_a1dec77
// Checksum 0x32da9a7d, Offset: 0x280
// Size: 0x258
function function_a1dec77(v_origin, var_3c58247b, var_9b351631) {
    var_b8cbb409 = undefined;
    goalpoint = undefined;
    searchradius = var_3c58247b * 0.5;
    var_7b342bc5 = 0;
    while (!isdefined(var_b8cbb409) && var_7b342bc5 < 4) {
        var_7b342bc5++;
        searchradius *= 2;
        var_b8cbb409 = getclosestpointonnavmesh(v_origin, searchradius, 30);
    }
    if (isdefined(var_b8cbb409)) {
        var_6ab55afd = util::positionquery_pointarray(v_origin, 0, searchradius + 50, 70, 64);
        valid = 0;
        var_2b89b3df = distancesquared(self.origin, v_origin);
        foreach (point in var_6ab55afd) {
            distsq = distancesquared(point, v_origin);
            if (var_2b89b3df > 256 && distsq > var_2b89b3df) {
                continue;
            }
            valid += 1;
            chance = 1 / valid;
            if (randomfloatrange(0, 1) <= chance) {
                goalpoint = point;
            }
        }
    }
    return goalpoint;
}

// Namespace namespace_7829c86f
// Params 0, eflags: 0x1 linked
// namespace_7829c86f<file_0>::function_2481442d
// Checksum 0x399bff44, Offset: 0x4e0
// Size: 0x1e
function function_2481442d() {
    self.stealth.investigating = undefined;
    self notify(#"hash_2481442d");
}

// Namespace namespace_7829c86f
// Params 3, eflags: 0x1 linked
// namespace_7829c86f<file_0>::function_b78807a5
// Checksum 0x81284246, Offset: 0x508
// Size: 0x3bc
function function_b78807a5(v_origin, e_originator, str_type) {
    self notify(#"hash_b78807a5");
    self endon(#"hash_b78807a5");
    self endon(#"death");
    self endon(#"hash_94ff6d85");
    self endon(#"hash_2481442d");
    assert(self namespace_aec89ff8::enabled());
    if (!isdefined(str_type)) {
        str_type = "default";
    }
    self stopanimscripted();
    self.stealth.investigating = str_type;
    self notify(#"hash_565daac6");
    self laseroff();
    if (isplayer(e_originator) && e_originator namespace_10443be6::enabled()) {
        e_originator namespace_234a4910::function_e3ae87b3("investigating", self, 1);
    }
    nearestnode = undefined;
    goalradius = -128;
    var_d0808a0e = gettime() + randomfloatrange(25, 30) * 1000;
    if (str_type == "infinite") {
        var_d0808a0e = -1;
    } else if (str_type == "quick") {
        var_d0808a0e = gettime() + randomfloatrange(10, 15) * 1000;
    }
    if (var_d0808a0e > 0) {
        self thread function_628d42af((var_d0808a0e - gettime()) / 1000);
    }
    self notify(#"hash_234a4910", "alert");
    if (isdefined(self.patroller) && self.patroller) {
        self ai::end_and_clean_patrol_behaviors();
    }
    result = "";
    while ((var_d0808a0e < 0 || gettime() < var_d0808a0e) && isdefined(v_origin)) {
        var_ee99fa5c = function_a1dec77(v_origin, 256, result);
        if (isdefined(var_ee99fa5c)) {
            /#
                self.stealth.var_85e6f33c = undefined;
            #/
            result = self function_edba2e78(var_ee99fa5c);
            if (result == "bad_path") {
                /#
                    self.stealth.var_85e6f33c = "resume";
                #/
                v_origin = self.origin;
                wait(1);
            } else {
                self waittill(#"stealthidleterminate");
            }
            continue;
        }
        /#
            self.stealth.var_85e6f33c = "resume";
        #/
        v_origin = self.origin;
        wait(1);
    }
    self namespace_80045451::function_a2429809("unaware");
    self function_2481442d();
}

// Namespace namespace_7829c86f
// Params 1, eflags: 0x1 linked
// namespace_7829c86f<file_0>::function_628d42af
// Checksum 0xd9db9f01, Offset: 0x8d0
// Size: 0x94
function function_628d42af(delayseconds) {
    self endon(#"hash_b78807a5");
    self endon(#"death");
    self endon(#"hash_94ff6d85");
    self endon(#"hash_2481442d");
    wait(delayseconds);
    self.stealth_resume_after_idle = 1;
    self notify(#"hash_234a4910", "resume");
    self namespace_80045451::function_a2429809("unaware");
    self function_2481442d();
}

// Namespace namespace_7829c86f
// Params 1, eflags: 0x1 linked
// namespace_7829c86f<file_0>::function_edba2e78
// Checksum 0xf727aac1, Offset: 0x970
// Size: 0xfe
function function_edba2e78(v_origin) {
    self notify(#"hash_edba2e78");
    self endon(#"hash_edba2e78");
    self endon(#"hash_b78807a5");
    self endon(#"death");
    self endon(#"hash_94ff6d85");
    assert(self namespace_aec89ff8::enabled());
    self setgoalpos(v_origin, 1, 8);
    /#
        self.stealth.var_edba2e78 = v_origin;
    #/
    result = self util::waittill_any_timeout(30, "goal", "near_goal", "bad_path");
    /#
        self.stealth.var_edba2e78 = undefined;
    #/
    return result;
}

