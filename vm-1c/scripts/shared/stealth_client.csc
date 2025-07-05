#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace stealth_client;

// Namespace stealth_client
// Params 0, eflags: 0x2
// Checksum 0xf825c14d, Offset: 0x170
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("stealth_client", &__init__, undefined, undefined);
}

// Namespace stealth_client
// Params 0, eflags: 0x0
// Checksum 0xf0ab345b, Offset: 0x1b0
// Size: 0x2c
function __init__() {
    init_clientfields();
    level.var_39a2f1a5 = 0;
    level.var_ba40d63 = 0;
}

// Namespace stealth_client
// Params 0, eflags: 0x0
// Checksum 0xedee5511, Offset: 0x1e8
// Size: 0x94
function init_clientfields() {
    clientfield::register("toplayer", "stealth_sighting", 1, 2, "int", &function_f35fe4e2, 0, 0);
    clientfield::register("toplayer", "stealth_alerted", 1, 1, "int", &function_b1ff0e4c, 0, 0);
}

// Namespace stealth_client
// Params 7, eflags: 0x0
// Checksum 0xd459bdd0, Offset: 0x288
// Size: 0xa2
function function_f35fe4e2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval > 0) {
        if (level.var_ba40d63 == 0 || newval == 2) {
            level.var_ba40d63 = newval;
            self thread function_b557fc53();
        }
        return;
    }
    level.var_ba40d63 = 0;
    self notify(#"hash_72012023");
}

// Namespace stealth_client
// Params 7, eflags: 0x0
// Checksum 0x3fae3892, Offset: 0x338
// Size: 0x94
function function_b1ff0e4c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (level.var_39a2f1a5 == 0) {
            self thread function_d473128e();
            level.var_39a2f1a5 = 1;
        }
        return;
    }
    self notify(#"hash_71c558d9");
    level.var_39a2f1a5 = 0;
}

// Namespace stealth_client
// Params 0, eflags: 0x0
// Checksum 0x3c15178a, Offset: 0x3d8
// Size: 0x9e
function function_b557fc53() {
    self notify(#"hash_72012023");
    self endon(#"hash_72012023");
    self endon(#"hash_71c558d9");
    self endon(#"death");
    self endon(#"disconnect");
    var_c6b203b0 = 3;
    if (level.var_ba40d63 == 2) {
        var_c6b203b0 = 1;
    }
    while (isdefined(self)) {
        self playsound(self, "uin_stealth_beep");
        wait var_c6b203b0;
    }
}

// Namespace stealth_client
// Params 0, eflags: 0x0
// Checksum 0x568f94c3, Offset: 0x480
// Size: 0x76
function function_d473128e() {
    self notify(#"hash_71c558d9");
    self endon(#"hash_71c558d9");
    self endon(#"death");
    self endon(#"disconnect");
    if (level.var_ba40d63 == 1) {
        self playsound(self, "uin_stealth_hint");
    }
    while (isdefined(self)) {
        wait 4;
    }
}

