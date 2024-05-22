#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_6294c69f;

// Namespace namespace_6294c69f
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1b0
// Size: 0x4
function function_ba281e3f() {
    
}

// Namespace namespace_6294c69f
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1c0
// Size: 0x4
function function_3e539ffc() {
    
}

// Namespace namespace_6294c69f
// Params 1, eflags: 0x0
// Checksum 0x10947887, Offset: 0x1d0
// Size: 0x20a
function function_16d66993(convo) {
    self endon(#"disconnect");
    /#
        assert(isdefined(convo), "plr_1");
    #/
    if (!level flag::get("story_vo_playing")) {
        level flag::set("story_vo_playing");
        self thread function_b80e4987();
        self.dontspeak = 1;
        self clientfield::set_to_player("isspeaking", 1);
        for (i = 0; i < convo.size; i++) {
            if (isdefined(self.afterlife) && self.afterlife) {
                self.dontspeak = 0;
                self clientfield::set_to_player("isspeaking", 0);
                level flag::clear("story_vo_playing");
                self notify(#"hash_ced7d10d");
                return;
            } else {
                self playsoundwithnotify(convo[i], "sound_done" + convo[i]);
                self waittill("sound_done" + convo[i]);
            }
            wait(1);
        }
        self.dontspeak = 0;
        self clientfield::set_to_player("isspeaking", 0);
        level flag::clear("story_vo_playing");
        self notify(#"hash_ced7d10d");
    }
}

// Namespace namespace_6294c69f
// Params 0, eflags: 0x1 linked
// Checksum 0xfb29d215, Offset: 0x3e8
// Size: 0x3c
function function_b80e4987() {
    self endon(#"hash_ced7d10d");
    self waittill(#"disconnect");
    level flag::clear("story_vo_playing");
}

// Namespace namespace_6294c69f
// Params 1, eflags: 0x0
// Checksum 0xfbd773cd, Offset: 0x430
// Size: 0x704
function function_b1c2ac2a(convo) {
    /#
        assert(isdefined(convo), "plr_1");
    #/
    players = getplayers();
    if (players.size == 4 && !level flag::get("story_vo_playing")) {
        level flag::set("story_vo_playing");
        var_c49044df = undefined;
        var_3b1f0101 = undefined;
        n_dist = 0;
        var_87f75eaa = 1500;
        var_4cd6b5cb = undefined;
        var_dacf4690 = undefined;
        var_d1c0f9 = undefined;
        var_bede2506 = undefined;
        foreach (player in players) {
            if (isdefined(player)) {
                switch (player.var_f7af1630) {
                case 3:
                    var_4cd6b5cb = player;
                    break;
                case 6:
                    var_dacf4690 = player;
                    break;
                case 4:
                    var_d1c0f9 = player;
                    break;
                case 5:
                    var_bede2506 = player;
                    break;
                }
            }
        }
        if (!isdefined(var_4cd6b5cb) || !isdefined(var_dacf4690) || !isdefined(var_d1c0f9) || !isdefined(var_bede2506)) {
            return;
        } else {
            foreach (player in players) {
                if (isdefined(player)) {
                    player.dontspeak = 1;
                    player clientfield::set_to_player("isspeaking", 1);
                }
            }
        }
        for (i = 0; i < convo.size; i++) {
            players = getplayers();
            if (players.size != 4) {
                foreach (player in players) {
                    if (isdefined(player)) {
                        player.dontspeak = 0;
                        player clientfield::set_to_player("isspeaking", 0);
                    }
                }
                level flag::clear("story_vo_playing");
                return;
            }
            if (issubstr(convo[i], "plr_0")) {
                var_3b1f0101 = var_bede2506;
            } else if (issubstr(convo[i], "plr_1")) {
                var_3b1f0101 = var_dacf4690;
            } else if (issubstr(convo[i], "plr_2")) {
                var_3b1f0101 = var_d1c0f9;
            } else if (issubstr(convo[i], "plr_3")) {
                var_3b1f0101 = var_4cd6b5cb;
            }
            if (isdefined(var_c49044df)) {
                n_dist = distance(var_c49044df.origin, var_3b1f0101.origin);
            }
            if (var_3b1f0101.afterlife || n_dist > var_87f75eaa) {
                foreach (player in players) {
                    if (isdefined(player)) {
                        player.dontspeak = 0;
                        player clientfield::set_to_player("isspeaking", 0);
                    }
                }
                level flag::clear("story_vo_playing");
                return;
            } else {
                var_3b1f0101 playsoundwithnotify(convo[i], "sound_done" + convo[i]);
                var_3b1f0101 waittill("sound_done" + convo[i]);
                var_c49044df = var_3b1f0101;
            }
            wait(1);
        }
        foreach (player in players) {
            if (isdefined(player)) {
                player.dontspeak = 0;
                player clientfield::set_to_player("isspeaking", 0);
            }
        }
        level flag::clear("story_vo_playing");
    }
}

