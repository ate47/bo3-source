#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_raps;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_5d6b4fef;

// Namespace namespace_5d6b4fef
// Params 0, eflags: 0x2
// Checksum 0xb3e6a28a, Offset: 0x240
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("raps_mp", &__init__, undefined, undefined);
}

// Namespace namespace_5d6b4fef
// Params 0, eflags: 0x1 linked
// Checksum 0x6b22e53d, Offset: 0x280
// Size: 0xdc
function __init__() {
    clientfield::register("vehicle", "monitor_raps_drop_landing", 1, 1, "int", &function_affb8bd1, 0, 0);
    clientfield::register("vehicle", "raps_heli_low_health", 1, 1, "int", &function_7175b6c4, 0, 0);
    clientfield::register("vehicle", "raps_heli_extra_low_health", 1, 1, "int", &function_939778c3, 0, 0);
}

// Namespace namespace_5d6b4fef
// Params 7, eflags: 0x1 linked
// Checksum 0x8304ecb0, Offset: 0x368
// Size: 0x94
function function_7175b6c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        return;
    }
    self endon(#"entityshutdown");
    vehicle::function_b7c7870e(localclientnum);
    playfxontag(localclientnum, "killstreaks/fx_heli_raps_exp_trail", self, "tag_fx_engine_left_front");
}

// Namespace namespace_5d6b4fef
// Params 7, eflags: 0x1 linked
// Checksum 0xb95afff3, Offset: 0x408
// Size: 0x94
function function_939778c3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        return;
    }
    self endon(#"entityshutdown");
    vehicle::function_b7c7870e(localclientnum);
    playfxontag(localclientnum, "killstreaks/fx_heli_raps_exp_trail", self, "tag_fx_engine_right_back");
}

// Namespace namespace_5d6b4fef
// Params 7, eflags: 0x1 linked
// Checksum 0x43461af6, Offset: 0x4a8
// Size: 0x5c
function function_affb8bd1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self thread function_943cee13(localclientnum);
}

// Namespace namespace_5d6b4fef
// Params 1, eflags: 0x1 linked
// Checksum 0x1cba122b, Offset: 0x510
// Size: 0x394
function function_943cee13(localclientnum) {
    self endon(#"entityshutdown");
    self notify(#"hash_38871899");
    self endon(#"hash_38871899");
    a_trace = bullettrace(self.origin + (0, 0, -200), self.origin + (0, 0, -5000), 0, self, 1);
    v_ground = a_trace["position"];
    wait(0.5);
    var_58d69cbf = 0;
    if (isdefined(v_ground)) {
        var_418040be = 1;
        while (var_418040be) {
            velocity = self getvelocity();
            var_58d69cbf = max(var_58d69cbf, abs(velocity[2]) * 0.15 + 193.044 * 0.15 * 0.15);
            var_c923aa1 = var_58d69cbf * var_58d69cbf;
            distance_squared = distancesquared(self.origin, v_ground);
            var_418040be = distance_squared > var_c923aa1;
            if (var_418040be) {
                wait(distance_squared > var_c923aa1 * 4 ? 0.1 : 0.05);
            }
        }
        self playsound(localclientnum, "veh_raps_first_land");
    }
    while (distancesquared(self.origin, v_ground) > 576 || velocity[2] <= 0) {
        velocity = self getvelocity();
        wait(0.016);
    }
    bundle = struct::get_script_bundle("killstreak", "killstreak_" + "raps");
    if (isdefined(bundle) && isdefined(bundle.var_5e90a53) && isdefined(a_trace["surfacetype"])) {
        fx_to_play = getfxfromsurfacetable(bundle.var_5e90a53, a_trace["surfacetype"]);
        if (isdefined(fx_to_play)) {
            playfx(localclientnum, fx_to_play, self.origin);
        }
    }
    if (isdefined(bundle) && isdefined(bundle.var_ada330cc)) {
        playfx(localclientnum, bundle.var_ada330cc, self.origin);
    }
    playrumbleonposition(localclientnum, "raps_land", self.origin);
}

