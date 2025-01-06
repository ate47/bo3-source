#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;

#namespace zm_island_side_ee_golden_bucket;

// Namespace zm_island_side_ee_golden_bucket
// Params 0, eflags: 0x0
// Checksum 0x1dfd866e, Offset: 0x1c8
// Size: 0x94
function init() {
    clientfield::register("world", "reveal_golden_bucket_planting_location", 9000, 1, "int", &reveal_golden_bucket_planting_location, 0, 0);
    clientfield::register("scriptmover", "golden_bucket_glow_fx", 9000, 1, "int", &golden_bucket_glow_fx, 0, 0);
}

// Namespace zm_island_side_ee_golden_bucket
// Params 7, eflags: 0x0
// Checksum 0xacd85009, Offset: 0x268
// Size: 0x102
function reveal_golden_bucket_planting_location(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        var_6f80c1d8 = getentarray(localclientnum, "swamp_planter_skull_reveal", "targetname");
        foreach (var_31678178 in var_6f80c1d8) {
            var_31678178 movez(-45, 2);
        }
    }
}

// Namespace zm_island_side_ee_golden_bucket
// Params 7, eflags: 0x0
// Checksum 0xf6678922, Offset: 0x378
// Size: 0xc4
function golden_bucket_glow_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_f8cafdc6[localclientnum] = playfx(localclientnum, level._effect["plant_hit_with_ww"], self.origin);
        return;
    }
    if (isdefined(self.var_f8cafdc6[localclientnum])) {
        deletefx(localclientnum, self.var_f8cafdc6[localclientnum]);
    }
}

