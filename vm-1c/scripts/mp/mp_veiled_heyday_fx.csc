#using scripts/shared/util_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_afeeaece;

// Namespace namespace_afeeaece
// Params 0, eflags: 0x1 linked
// Checksum 0xc0a3f37f, Offset: 0x118
// Size: 0x24
function main() {
    callback::on_localplayer_spawned(&on_player_spawned);
}

// Namespace namespace_afeeaece
// Params 1, eflags: 0x1 linked
// Checksum 0x480cae72, Offset: 0x148
// Size: 0x24
function on_player_spawned(localclientnum) {
    level thread function_ac25f220(localclientnum);
}

// Namespace namespace_afeeaece
// Params 1, eflags: 0x1 linked
// Checksum 0xa7ca0f6, Offset: 0x178
// Size: 0xea
function function_ac25f220(localclientnum) {
    localplayer = getlocalplayer(localclientnum);
    triggers = getentarray(localclientnum, "clientLightExploder", "targetname");
    foreach (trigger in triggers) {
        trigger thread function_549815fe(localclientnum, localplayer);
    }
}

// Namespace namespace_afeeaece
// Params 2, eflags: 0x1 linked
// Checksum 0xbd02b06a, Offset: 0x270
// Size: 0x160
function function_549815fe(localclientnum, localplayer) {
    localplayer endon(#"death");
    assert(isdefined(self.script_stop_exploder_radiant) || isdefined(self.script_exploder_radiant));
    string = isdefined(self.script_exploder_radiant) ? self.script_exploder_radiant : self.script_stop_exploder_radiant;
    while (true) {
        while (true) {
            client = self waittill(#"trigger");
            if (client == localplayer) {
                break;
            }
        }
        playradiantexploder(localclientnum, string);
        self thread function_a2845863(localclientnum, localplayer, string);
        wait(0.016);
        while (isdefined(localplayer) && localplayer istouching(self)) {
            wait(0.1);
        }
        stopradiantexploder(localclientnum, string);
        self notify(#"hash_54e754c1");
        wait(0.016);
    }
}

// Namespace namespace_afeeaece
// Params 3, eflags: 0x1 linked
// Checksum 0xcc1a0fee, Offset: 0x3d8
// Size: 0x54
function function_a2845863(localclientnum, localplayer, string) {
    self endon(#"hash_54e754c1");
    localplayer waittill(#"death");
    stopradiantexploder(localclientnum, string);
}

