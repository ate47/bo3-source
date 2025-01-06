#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_decoy;
#using scripts/shared/weapons/_weaponobjects;

#namespace threat_detector;

// Namespace threat_detector
// Params 0, eflags: 0x2
// Checksum 0x2fa52062, Offset: 0x1f8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("threat_detector", &__init__, undefined, undefined);
}

// Namespace threat_detector
// Params 0, eflags: 0x0
// Checksum 0xf0fb71a0, Offset: 0x230
// Size: 0x4a
function __init__() {
    level.var_f8f606cd = 1;
    level.var_1b11b392 = [];
    clientfield::register("missile", "threat_detector", 1, 1, "int", &function_82ee334b, 0, 0);
}

// Namespace threat_detector
// Params 7, eflags: 0x0
// Checksum 0xe226ab4c, Offset: 0x288
// Size: 0x16a
function function_82ee334b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != 1) {
        return;
    }
    if (getlocalplayer(localclientnum) != self.owner) {
        return;
    }
    var_4386cfe5 = level.var_1b11b392.size;
    level.var_f8f606cd++;
    level.var_1b11b392[var_4386cfe5] = spawnstruct();
    level.var_1b11b392[var_4386cfe5].handle = level.var_f8f606cd;
    level.var_1b11b392[var_4386cfe5].cent = self;
    level.var_1b11b392[var_4386cfe5].team = self.team;
    level.var_1b11b392[var_4386cfe5].owner = self getowner(localclientnum);
    level.var_1b11b392[var_4386cfe5].owner addsensorgrenadearea(self.origin, level.var_f8f606cd);
    self.owner thread function_aa1a4765(self, level.var_f8f606cd, localclientnum);
    self.owner thread function_8490a224(self, level.var_f8f606cd, localclientnum);
}

// Namespace threat_detector
// Params 3, eflags: 0x0
// Checksum 0x24aa7c1c, Offset: 0x400
// Size: 0x191
function function_aa1a4765(var_f0a669b2, var_f8f606cd, localclientnum) {
    var_f0a669b2 endon(#"entityshutdown");
    if (isdefined(var_f0a669b2.owner) == 0) {
        return;
    }
    while (true) {
        players = getplayers(localclientnum);
        foreach (player in players) {
            if (self util::isenemyplayer(player)) {
                if (player hasperk(localclientnum, "specialty_nomotionsensor") || player hasperk(localclientnum, "specialty_sengrenjammer")) {
                    player duplicate_render::set_player_threat_detected(localclientnum, 0);
                    continue;
                }
                var_3c98bcd9 = getdvarfloat("cg_threatDetectorRadius", 0);
                var_5aaadaef = var_3c98bcd9 * var_3c98bcd9;
                if (distancesquared(player.origin, var_f0a669b2.origin) < var_5aaadaef) {
                    player duplicate_render::set_player_threat_detected(localclientnum, 1);
                    continue;
                }
                player duplicate_render::set_player_threat_detected(localclientnum, 0);
            }
        }
        wait 1;
    }
}

// Namespace threat_detector
// Params 3, eflags: 0x0
// Checksum 0x2267cb38, Offset: 0x5a0
// Size: 0x13b
function function_8490a224(var_f0a669b2, var_f8f606cd, localclientnum) {
    var_f0a669b2 waittill(#"entityshutdown");
    entindex = 0;
    for (i = 0; i < level.var_1b11b392.size; i++) {
        size = level.var_1b11b392.size;
        if (var_f8f606cd == level.var_1b11b392[i].handle) {
            level.var_1b11b392[i].owner removesensorgrenadearea(var_f8f606cd);
            entindex = 0;
            break;
        }
    }
    players = getplayers(localclientnum);
    foreach (player in players) {
        if (self util::isenemyplayer(player)) {
            player duplicate_render::set_player_threat_detected(localclientnum, 0);
        }
    }
}

