#using scripts/shared/postfx_shared;
#using scripts/shared/fx_shared;
#using scripts/codescripts/struct;

#namespace namespace_34e37984;

// Namespace namespace_34e37984
// Params 0, eflags: 0x1 linked
// namespace_34e37984<file_0>::function_d290ebfa
// Checksum 0xad0e7071, Offset: 0x158
// Size: 0x1e
function main() {
    level._effect["player_tunnel_dust"] = "dirt/fx_dust_motes_player_loop_lite";
}

// Namespace namespace_34e37984
// Params 1, eflags: 0x1 linked
// namespace_34e37984<file_0>::function_fda9ad5f
// Checksum 0x15784d07, Offset: 0x180
// Size: 0x110
function function_fda9ad5f(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    var_59579cf9 = getent(localclientnum, "turn_off_tunnel_dust_fx", "targetname");
    var_c866fc0d = getent(localclientnum, "turn_on_tunnel_dust_fx", "targetname");
    if (isdefined(var_59579cf9) && isdefined(var_c866fc0d)) {
        while (true) {
            var_c866fc0d waittill(#"trigger");
            self function_ba9197c(localclientnum, 0, 1, 0, 0, undefined, 0);
            var_59579cf9 waittill(#"trigger");
            self function_ba9197c(localclientnum, 1, 0, 0, 0, undefined, 0);
        }
    }
}

// Namespace namespace_34e37984
// Params 7, eflags: 0x1 linked
// namespace_34e37984<file_0>::function_ba9197c
// Checksum 0x1ed9eab9, Offset: 0x298
// Size: 0x114
function function_ba9197c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(self.n_fx_id)) {
            deletefx(localclientnum, self.n_fx_id, 1);
            self notify(#"hash_4db222ba");
            wait(0.1);
        }
        self.n_fx_id = playfxoncamera(localclientnum, level._effect["player_tunnel_dust"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        return;
    }
    self notify(#"hash_4db222ba");
    if (isdefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
    }
}

// Namespace namespace_34e37984
// Params 7, eflags: 0x1 linked
// namespace_34e37984<file_0>::function_55f87893
// Checksum 0x957ed9ea, Offset: 0x3b8
// Size: 0x64
function function_55f87893(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self postfx::playpostfxbundle("pstfx_blood_spatter");
    }
}

