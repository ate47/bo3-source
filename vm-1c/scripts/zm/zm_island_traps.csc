#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_14b4d4ab;

// Namespace namespace_14b4d4ab
// Params 0, eflags: 0x1 linked
// namespace_14b4d4ab<file_0>::function_c35e6aab
// Checksum 0xdf5d7f41, Offset: 0x218
// Size: 0x124
function init() {
    clientfield::register("world", "proptrap_downdraft_rumble", 9000, 1, "int", &function_a9e415bd, 0, 0);
    clientfield::register("toplayer", "proptrap_downdraft_blur", 9000, 1, "int", &function_fb8158d9, 0, 0);
    clientfield::register("world", "walltrap_draft_rumble", 9000, 1, "int", &function_4736704, 0, 0);
    clientfield::register("toplayer", "walltrap_draft_blur", 9000, 1, "int", &function_3abeaee0, 0, 0);
}

// Namespace namespace_14b4d4ab
// Params 7, eflags: 0x1 linked
// namespace_14b4d4ab<file_0>::function_a9e415bd
// Checksum 0xc9d4db6d, Offset: 0x348
// Size: 0x2ee
function function_a9e415bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    if (isdefined(newval) && newval) {
        if (!isdefined(player.var_69abefde)) {
            player.var_69abefde = [];
            var_719bbcb8 = struct::get_array("s_proptrap_downdraft_rumble", "targetname");
            foreach (var_dd3351d8 in var_719bbcb8) {
                var_9866f6f9 = util::spawn_model(localclientnum, "tag_origin", var_dd3351d8.origin, var_dd3351d8.angles);
                array::add(player.var_69abefde, var_9866f6f9);
            }
        }
        foreach (var_9866f6f9 in player.var_69abefde) {
            var_9866f6f9 playrumbleonentity(localclientnum, "zm_island_rumble_proptrap_downdraft");
        }
        return;
    }
    if (isdefined(player.var_69abefde)) {
        foreach (var_9866f6f9 in player.var_69abefde) {
            var_9866f6f9 stoprumble(localclientnum, "zm_island_rumble_proptrap_downdraft");
            var_9866f6f9 delete();
        }
    }
    player.var_69abefde = undefined;
}

// Namespace namespace_14b4d4ab
// Params 7, eflags: 0x1 linked
// namespace_14b4d4ab<file_0>::function_fb8158d9
// Checksum 0xa8befd82, Offset: 0x640
// Size: 0x8c
function function_fb8158d9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_24f1be38(localclientnum, "s_proptrap_downdraft_rumble");
        return;
    }
    self notify(#"hash_602aae2b");
    disablespeedblur(localclientnum);
}

// Namespace namespace_14b4d4ab
// Params 7, eflags: 0x1 linked
// namespace_14b4d4ab<file_0>::function_4736704
// Checksum 0x27daf088, Offset: 0x6d8
// Size: 0x2ee
function function_4736704(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    if (isdefined(newval) && newval) {
        if (!isdefined(player.var_d33c558c)) {
            player.var_d33c558c = [];
            var_52928b68 = struct::get_array("s_walltrap_draft_rumble", "targetname");
            foreach (var_7f2e4e88 in var_52928b68) {
                var_9866f6f9 = util::spawn_model(localclientnum, "tag_origin", var_7f2e4e88.origin, var_7f2e4e88.angles);
                array::add(player.var_d33c558c, var_9866f6f9);
            }
        }
        foreach (var_9866f6f9 in player.var_d33c558c) {
            var_9866f6f9 playrumbleonentity(localclientnum, "zm_island_rumble_proptrap_downdraft");
        }
        return;
    }
    if (isdefined(player.var_d33c558c)) {
        foreach (var_9866f6f9 in player.var_d33c558c) {
            var_9866f6f9 stoprumble(localclientnum, "zm_island_rumble_proptrap_downdraft");
            var_9866f6f9 delete();
        }
    }
    player.var_d33c558c = undefined;
}

// Namespace namespace_14b4d4ab
// Params 7, eflags: 0x1 linked
// namespace_14b4d4ab<file_0>::function_3abeaee0
// Checksum 0x82eaeb21, Offset: 0x9d0
// Size: 0x8c
function function_3abeaee0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_24f1be38(localclientnum, "s_walltrap_draft_rumble");
        return;
    }
    self notify(#"hash_602aae2b");
    disablespeedblur(localclientnum);
}

// Namespace namespace_14b4d4ab
// Params 2, eflags: 0x1 linked
// namespace_14b4d4ab<file_0>::function_24f1be38
// Checksum 0x81875fd7, Offset: 0xa68
// Size: 0x150
function function_24f1be38(localclientnum, var_3f5c9bdb) {
    self endon(#"hash_602aae2b");
    self endon(#"death");
    var_719bbcb8 = struct::get_array(var_3f5c9bdb, "targetname");
    while (true) {
        foreach (var_dd3351d8 in var_719bbcb8) {
            if (isdefined(self) && distancesquared(self.origin, var_dd3351d8.origin) < 3600) {
                enablespeedblur(localclientnum, 0.1, 0.5, 0.75);
                continue;
            }
            disablespeedblur(localclientnum);
        }
        wait(0.5);
    }
}

