#using scripts/cp/_oed;
#using scripts/shared/clientfield_shared;
#using scripts/shared/stealth;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;

#namespace namespace_f917b91a;

// Namespace namespace_f917b91a
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x148
// Size: 0x4
function init() {
    
}

// Namespace namespace_f917b91a
// Params 0, eflags: 0x1 linked
// Checksum 0xce06e423, Offset: 0x158
// Size: 0x20
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.tagging);
}

// Namespace namespace_f917b91a
// Params 0, eflags: 0x0
// Checksum 0xe5f3d06a, Offset: 0x180
// Size: 0x56
function function_b6579d92() {
    return isdefined(self.stealth.tagging.tagged) && isdefined(self.stealth) && isdefined(self.stealth.tagging) && self.stealth.tagging.tagged;
}

// Namespace namespace_f917b91a
// Params 0, eflags: 0x0
// Checksum 0x93d85160, Offset: 0x1e0
// Size: 0x580
function function_fe19d58d() {
    assert(isplayer(self));
    assert(self enabled());
    self endon(#"disconnect");
    var_9c648312 = 0.25;
    wait(randomfloatrange(0.05, 1));
    while (true) {
        if (self playerads() > 0.3) {
            var_cdb312b = anglestoforward(self getplayerangles());
            var_10387988 = self getplayercamerapos();
            rangesq = self.stealth.tagging.range * self.stealth.tagging.range;
            trace = bullettrace(var_10387988, var_10387988 + var_cdb312b * 32000, 1, self);
            foreach (enemy in level.stealth.enemies[self.team]) {
                if (!isdefined(enemy) || !isalive(enemy)) {
                    continue;
                }
                if (isdefined(enemy.stealth.tagging.tagged) && (!enemy enabled() || enemy.stealth.tagging.tagged)) {
                    continue;
                }
                if (!isactor(enemy)) {
                    continue;
                }
                enemyentnum = enemy getentitynumber();
                var_74aa899f = isdefined(trace["entity"]) && trace["entity"] == enemy;
                var_dc78c986 = 0;
                if (!var_74aa899f) {
                    distsq = distancesquared(enemy.origin, var_10387988);
                    var_36e15574 = vectornormalize(enemy.origin + (0, 0, 30) - var_10387988);
                    if (distsq < rangesq && vectordot(var_36e15574, var_cdb312b) > self.stealth.tagging.var_5c4da700) {
                        var_dc78c986 = self function_980170b6(var_10387988, enemy);
                    }
                }
                if (var_74aa899f || var_dc78c986) {
                    if (!isdefined(self.stealth.tagging.var_96a12af4[enemyentnum])) {
                        self.stealth.tagging.var_96a12af4[enemyentnum] = 0;
                    }
                    self.stealth.tagging.var_96a12af4[enemyentnum] = self.stealth.tagging.var_96a12af4[enemyentnum] + 1 / self.stealth.tagging.tag_time * var_9c648312;
                    if (self.stealth.tagging.var_96a12af4[enemyentnum] >= 1) {
                        if (isplayer(self)) {
                            self playsoundtoplayer("uin_gadget_fully_charged", self);
                        }
                        enemy thread function_a10a834e(1);
                    }
                    continue;
                }
                if (isdefined(self.stealth.tagging.var_96a12af4[enemyentnum])) {
                    self.stealth.tagging.var_96a12af4[enemyentnum] = undefined;
                }
            }
        }
        wait(var_9c648312);
    }
}

// Namespace namespace_f917b91a
// Params 1, eflags: 0x1 linked
// Checksum 0xdf939e08, Offset: 0x768
// Size: 0xbc
function function_a10a834e(tagged) {
    if (isalive(self)) {
        self oed::function_6e4b8a4f(tagged);
        if (isdefined(self.stealth) && isdefined(self.stealth.tagging)) {
            if (!tagged) {
                self.stealth.tagging.tagged = undefined;
            } else {
                self.stealth.tagging.tagged = tagged;
            }
        }
        self clientfield::set("tagged", tagged);
    }
}

// Namespace namespace_f917b91a
// Params 2, eflags: 0x1 linked
// Checksum 0xd87d8997, Offset: 0x830
// Size: 0x114
function function_980170b6(var_10387988, enemy) {
    result = 0;
    if (isactor(enemy)) {
        if (!result && sighttracepassed(var_10387988, enemy gettagorigin("j_head"), 0, self)) {
            result = 1;
        }
        if (!result && sighttracepassed(var_10387988, enemy gettagorigin("j_spinelower"), 0, self)) {
            result = 1;
        }
    }
    if (!result && sighttracepassed(var_10387988, enemy.origin, 0, self)) {
        result = 1;
    }
    return result;
}

