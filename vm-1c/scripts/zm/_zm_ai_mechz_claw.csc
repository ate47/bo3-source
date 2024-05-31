#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;

#namespace namespace_19d9d56d;

// Namespace namespace_19d9d56d
// Params 0, eflags: 0x2
// namespace_19d9d56d<file_0>::function_2dc19561
// Checksum 0x89e45e09, Offset: 0x1b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_ai_mechz_claw", &__init__, undefined, undefined);
}

// Namespace namespace_19d9d56d
// Params 0, eflags: 0x5 linked
// namespace_19d9d56d<file_0>::function_8c87d8eb
// Checksum 0x4c4d1b5d, Offset: 0x1f0
// Size: 0x13c
function private __init__() {
    clientfield::register("actor", "mechz_fx", 21000, 12, "int", &function_22b149ce, 0, 0);
    clientfield::register("scriptmover", "mechz_claw", 21000, 1, "int", &function_2ad55883, 0, 0);
    clientfield::register("actor", "mechz_wpn_source", 21000, 1, "int", &function_54ae128d, 0, 0);
    clientfield::register("toplayer", "mechz_grab", 21000, 1, "int", &function_8dfa08c1, 0, 0);
    level.var_ed6989ab = &function_ed6989ab;
}

// Namespace namespace_19d9d56d
// Params 0, eflags: 0x4
// namespace_19d9d56d<file_0>::function_5b6b9132
// Checksum 0x99ec1590, Offset: 0x338
// Size: 0x4
function private __main__() {
    
}

// Namespace namespace_19d9d56d
// Params 7, eflags: 0x5 linked
// namespace_19d9d56d<file_0>::function_ed6989ab
// Checksum 0xf9f83fd2, Offset: 0x348
// Size: 0x174
function private function_ed6989ab(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    pos = self gettagorigin("tag_claw");
    ang = self gettagangles("tag_claw");
    velocity = self getvelocity();
    dynent = createdynentandlaunch(localclientnum, "c_t7_zm_dlchd_origins_mech_claw", pos, ang, self.origin, velocity);
    playfxontag(localclientnum, level._effect["fx_mech_dmg_armor"], self, "tag_grappling_source_fx");
    self playsound(0, "zmb_ai_mechz_destruction");
    playfxontag(localclientnum, level._effect["fx_mech_dmg_sparks"], self, "tag_grappling_source_fx");
}

// Namespace namespace_19d9d56d
// Params 7, eflags: 0x5 linked
// namespace_19d9d56d<file_0>::function_22b149ce
// Checksum 0x9a423dc9, Offset: 0x4c8
// Size: 0x3c
function private function_22b149ce(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    
}

// Namespace namespace_19d9d56d
// Params 7, eflags: 0x5 linked
// namespace_19d9d56d<file_0>::function_2ad55883
// Checksum 0xc5ef36f3, Offset: 0x510
// Size: 0x74
function private function_2ad55883(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        playfxontag(localclientnum, level._effect["mechz_claw"], self, "tag_origin");
    }
}

// Namespace namespace_19d9d56d
// Params 7, eflags: 0x5 linked
// namespace_19d9d56d<file_0>::function_54ae128d
// Checksum 0x4388791f, Offset: 0x590
// Size: 0xb6
function private function_54ae128d(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self.var_ba7e45cf = playfxontag(localclientnum, level._effect["mechz_wpn_source"], self, "j_elbow_le");
        return;
    }
    if (isdefined(self.var_ba7e45cf)) {
        stopfx(localclientnum, self.var_ba7e45cf);
        self.var_ba7e45cf = undefined;
    }
}

// Namespace namespace_19d9d56d
// Params 7, eflags: 0x5 linked
// namespace_19d9d56d<file_0>::function_8dfa08c1
// Checksum 0x92adcc87, Offset: 0x650
// Size: 0x74
function private function_8dfa08c1(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self hideviewlegs();
        return;
    }
    self showviewlegs();
}

