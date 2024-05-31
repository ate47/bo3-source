#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_3ecfcb30;

// Namespace namespace_3ecfcb30
// Params 0, eflags: 0x2
// namespace_3ecfcb30<file_0>::function_2dc19561
// Checksum 0xd8bfb07, Offset: 0x240
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_flavor_hexed", &__init__, undefined, "bgb");
}

// Namespace namespace_3ecfcb30
// Params 0, eflags: 0x1 linked
// namespace_3ecfcb30<file_0>::function_8c87d8eb
// Checksum 0x85b9d166, Offset: 0x280
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_flavor_hexed", "event", &event, undefined, undefined, undefined);
}

// Namespace namespace_3ecfcb30
// Params 0, eflags: 0x1 linked
// namespace_3ecfcb30<file_0>::function_279e4e97
// Checksum 0x1c0336dd, Offset: 0x2e0
// Size: 0x1c4
function event() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self.var_c3a5a8 = [];
    var_2cf032a6 = self.bgb_pack;
    foreach (str_bgb, var_410edbc8 in level.bgb) {
        if (var_410edbc8.consumable == 1) {
            if (!isinarray(var_2cf032a6, str_bgb) && str_bgb != "zm_bgb_flavor_hexed") {
                if (!isdefined(self.var_c3a5a8)) {
                    self.var_c3a5a8 = [];
                } else if (!isarray(self.var_c3a5a8)) {
                    self.var_c3a5a8 = array(self.var_c3a5a8);
                }
                self.var_c3a5a8[self.var_c3a5a8.size] = str_bgb;
            }
        }
    }
    assert(self.var_c3a5a8.size, "<unknown string>");
    var_50f0f8bb = array::random(self.var_c3a5a8);
    self thread function_9a45adfb(var_50f0f8bb);
}

// Namespace namespace_3ecfcb30
// Params 1, eflags: 0x1 linked
// namespace_3ecfcb30<file_0>::function_9a45adfb
// Checksum 0x82b521a0, Offset: 0x4b0
// Size: 0x84
function function_9a45adfb(var_50f0f8bb) {
    wait(1);
    self thread function_655e0571(var_50f0f8bb);
    self playsoundtoplayer("zmb_bgb_flavorhex", self);
    self thread bgb::give(var_50f0f8bb);
    arrayremovevalue(self.var_c3a5a8, var_50f0f8bb);
}

// Namespace namespace_3ecfcb30
// Params 1, eflags: 0x1 linked
// namespace_3ecfcb30<file_0>::function_655e0571
// Checksum 0x218d34aa, Offset: 0x540
// Size: 0x104
function function_655e0571(var_50f0f8bb) {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_gumball_anim_give");
    self waittill("bgb_update_give_" + var_50f0f8bb);
    self notify("bgb_flavor_hexed_give_" + var_50f0f8bb);
    var_1531e8c4, var_9a4acf7 = self waittill(#"bgb_update");
    if (var_9a4acf7 === var_50f0f8bb && self.var_c3a5a8.size) {
        var_df8558a0 = array::random(self.var_c3a5a8);
        self playsoundtoplayer("zmb_bgb_flavorhex", self);
        self thread function_21f6c6f5(var_df8558a0);
        self bgb::give(var_df8558a0);
    }
}

// Namespace namespace_3ecfcb30
// Params 1, eflags: 0x1 linked
// namespace_3ecfcb30<file_0>::function_21f6c6f5
// Checksum 0x8ed1a3ad, Offset: 0x650
// Size: 0x48
function function_21f6c6f5(var_50f0f8bb) {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self waittill("bgb_update_give_" + var_50f0f8bb);
    self notify("bgb_flavor_hexed_give_" + var_50f0f8bb);
}

