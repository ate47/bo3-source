#using scripts/cp/_oed;
#using scripts/shared/clientfield_shared;
#using scripts/shared/stealth;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace stealth_tagging;

// Namespace stealth_tagging
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x148
// Size: 0x2
function init() {
    
}

// Namespace stealth_tagging
// Params 0, eflags: 0x0
// Checksum 0x50df55b1, Offset: 0x158
// Size: 0x1e
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.tagging);
}

// Namespace stealth_tagging
// Params 0, eflags: 0x0
// Checksum 0x45f6e95a, Offset: 0x180
// Size: 0x55
function function_b6579d92() {
    return isdefined(self.stealth.tagging.tagged) && isdefined(self.stealth) && isdefined(self.stealth.tagging) && self.stealth.tagging.tagged;
}

// Namespace stealth_tagging
// Params 0, eflags: 0x0
// Checksum 0x1bb2dc3f, Offset: 0x1e0
// Size: 0x475
function function_fe19d58d() {
    assert(isplayer(self));
    assert(self enabled());
    self endon(#"disconnect");
    var_9c648312 = 0.25;
    wait randomfloatrange(0.05, 1);
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
        wait var_9c648312;
    }
}

// Namespace stealth_tagging
// Params 1, eflags: 0x0
// Checksum 0x1a90f703, Offset: 0x660
// Size: 0xa2
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

// Namespace stealth_tagging
// Params 2, eflags: 0x0
// Checksum 0x2e037de2, Offset: 0x710
// Size: 0xcc
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

