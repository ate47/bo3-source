#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_zod_util;

// Namespace zm_zod_util
// Params 7, eflags: 0x0
// Checksum 0x7873f0d8, Offset: 0x180
// Size: 0x276
function player_rumble_and_shake(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"disconnect");
    if (newval == 5) {
        self thread function_878b1e6c(localclientnum, 1);
        return;
    }
    if (newval == 6) {
        self notify(#"hash_f9095a82");
        self earthquake(0.6, 1.5, self.origin, 100);
        self playrumbleonentity(localclientnum, "artillery_rumble");
        return;
    }
    if (newval == 4) {
        self earthquake(0.6, 1.5, self.origin, 100);
        self playrumbleonentity(localclientnum, "artillery_rumble");
        return;
    }
    if (newval == 3) {
        self earthquake(0.3, 1.5, self.origin, 100);
        self playrumbleonentity(localclientnum, "shotgun_fire");
        return;
    }
    if (newval == 2) {
        self earthquake(0.1, 1, self.origin, 100);
        self playrumbleonentity(localclientnum, "damage_heavy");
        return;
    }
    if (newval == 1) {
        self playrumbleonentity(localclientnum, "damage_light");
        return;
    }
    if (newval == 7) {
        self thread function_878b1e6c(localclientnum, 1, 0);
        return;
    }
    self notify(#"hash_f9095a82");
}

// Namespace zm_zod_util
// Params 3, eflags: 0x0
// Checksum 0xdaf0a5d6, Offset: 0x400
// Size: 0x180
function function_878b1e6c(localclientnum, var_4be1e559, var_d2e77e71) {
    if (!isdefined(var_d2e77e71)) {
        var_d2e77e71 = 1;
    }
    self notify(#"hash_f9095a82");
    self endon(#"disconnect");
    self endon(#"hash_f9095a82");
    start_time = gettime();
    while (gettime() - start_time < 120000) {
        if (isdefined(self) && self islocalplayer() && isdefined(self)) {
            if (var_4be1e559 == 1) {
                if (var_d2e77e71) {
                    self earthquake(0.2, 1, self.origin, 100);
                }
                self playrumbleonentity(localclientnum, "reload_small");
                wait 0.05;
            } else {
                if (var_d2e77e71) {
                    self earthquake(0.3, 1, self.origin, 100);
                }
                self playrumbleonentity(localclientnum, "damage_light");
            }
        }
        wait 0.1;
    }
}

