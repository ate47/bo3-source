#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_c70bea9a;

// Namespace namespace_c70bea9a
// Params 0, eflags: 0x1 linked
// namespace_c70bea9a<file_0>::function_c35e6aab
// Checksum 0x34b56d3e, Offset: 0x120
// Size: 0x94
function init() {
    clientfield::register("allplayers", "oneinchpunch_impact", 21000, 1, "int", &function_c9202f92, 0, 0);
    clientfield::register("actor", "oneinchpunch_physics_launchragdoll", 21000, 1, "int", &function_7c6b248c, 0, 0);
}

// Namespace namespace_c70bea9a
// Params 7, eflags: 0x1 linked
// namespace_c70bea9a<file_0>::function_c9202f92
// Checksum 0x5bcc485e, Offset: 0x1c0
// Size: 0x17c
function function_c9202f92(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"death");
    self endon(#"disconnect");
    var_4383636a = 75;
    var_bf0c8e05 = 60;
    if (newval == 1) {
        if (!isdefined(level.var_57220446)) {
            level.var_57220446 = [];
        }
        level.var_57220446[self getentitynumber()] = gettime();
        self earthquake(0.5, 0.5, self.origin, 300);
        self playrumbleonentity(localclientnum, "damage_heavy");
        if (isdefined(self.var_21412003) && self.var_21412003 && isdefined(self.var_b37dabd2) && self.var_b37dabd2 == "air") {
            var_4383636a *= 2;
        }
        physicsexplosioncylinder(localclientnum, self.origin, var_4383636a, var_bf0c8e05, 1);
    }
}

// Namespace namespace_c70bea9a
// Params 7, eflags: 0x1 linked
// namespace_c70bea9a<file_0>::function_7c6b248c
// Checksum 0xa4ad2197, Offset: 0x348
// Size: 0x1d4
function function_7c6b248c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"entity_shutdown");
    if (newval == 1) {
        var_70efc576 = undefined;
        var_17013cd1 = 0;
        if (isdefined(level.var_57220446)) {
            for (i = 0; i < level.var_57220446.size; i++) {
                if (isdefined(level.var_57220446[i]) && level.var_57220446[i] > var_17013cd1) {
                    var_70efc576 = i;
                    var_17013cd1 = level.var_57220446[i];
                }
            }
        }
        if (isdefined(var_70efc576)) {
            a_players = getlocalplayers();
            var_b262e13f = a_players[var_70efc576];
        }
        if (isdefined(var_b262e13f)) {
            v_launch = vectornormalize(self.origin - var_b262e13f.origin) * randomintrange(125, -106) + (0, 0, randomintrange(75, -106));
        }
        if (isdefined(v_launch)) {
            self launchragdoll(v_launch);
        }
    }
}

