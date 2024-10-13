#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_weap_glaive;

// Namespace zm_weap_glaive
// Params 0, eflags: 0x2
// Checksum 0xb0bf3911, Offset: 0x3d8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_glaive", &__init__, undefined, undefined);
}

// Namespace zm_weap_glaive
// Params 0, eflags: 0x0
// Checksum 0xd86598c6, Offset: 0x418
// Size: 0x2ae
function __init__() {
    clientfield::register("allplayers", "slam_fx", 1, 1, "counter", &function_69a90263, 0, 0);
    clientfield::register("toplayer", "throw_fx", 1, 1, "counter", &function_6b6e650c, 0, 0);
    clientfield::register("toplayer", "swipe_fx", 1, 1, "counter", &function_b881d4aa, 0, 0);
    clientfield::register("toplayer", "swipe_lv2_fx", 1, 1, "counter", &function_647dc27d, 0, 0);
    clientfield::register("actor", "zombie_slice_r", 1, 2, "counter", &function_bbeb4c2c, 1, 0);
    clientfield::register("actor", "zombie_slice_l", 1, 2, "counter", &function_38924d95, 1, 0);
    level._effect["sword_swipe_1p"] = "zombie/fx_sword_trail_1p_zod_zmb";
    level._effect["sword_swipe_lv2_1p"] = "zombie/fx_sword_trail_1p_lvl2_zod_zmb";
    level._effect["sword_bloodswipe_r_1p"] = "zombie/fx_sword_slash_right_1p_zod_zmb";
    level._effect["sword_bloodswipe_l_1p"] = "zombie/fx_sword_slash_left_1p_zod_zmb";
    level._effect["sword_bloodswipe_r_level2_1p"] = "zombie/fx_keeper_death_zod_zmb";
    level._effect["sword_bloodswipe_l_level2_1p"] = "zombie/fx_keeper_death_zod_zmb";
    level._effect["groundhit_1p"] = "zombie/fx_sword_slam_elec_1p_zod_zmb";
    level._effect["groundhit_3p"] = "zombie/fx_sword_slam_elec_3p_zod_zmb";
    level._effect["sword_lvl2_throw"] = "zombie/fx_sword_lvl2_throw_1p_zod_zmb";
}

// Namespace zm_weap_glaive
// Params 7, eflags: 0x0
// Checksum 0x14c14bce, Offset: 0x6d0
// Size: 0xec
function function_b881d4aa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    owner = self getowner(localclientnum);
    if (isdefined(owner) && owner == getlocalplayer(localclientnum)) {
        swipe_fx = playviewmodelfx(localclientnum, level._effect["sword_swipe_1p"], "tag_flash");
        wait 3;
        deletefx(localclientnum, swipe_fx, 1);
    }
}

// Namespace zm_weap_glaive
// Params 7, eflags: 0x0
// Checksum 0x84b7450a, Offset: 0x7c8
// Size: 0xec
function function_647dc27d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    owner = self getowner(localclientnum);
    if (isdefined(owner) && owner == getlocalplayer(localclientnum)) {
        swipe_lv2_fx = playviewmodelfx(localclientnum, level._effect["sword_swipe_lv2_1p"], "tag_flash");
        wait 3;
        deletefx(localclientnum, swipe_lv2_fx, 1);
    }
}

// Namespace zm_weap_glaive
// Params 7, eflags: 0x0
// Checksum 0xe4cc7b1c, Offset: 0x8c0
// Size: 0x104
function function_bbeb4c2c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (util::is_mature() && !util::is_gib_restricted_build()) {
        if (newval == 1) {
            playfxontag(localclientnum, level._effect["sword_bloodswipe_r_1p"], self, "j_spine4");
        } else if (newval == 2) {
            playfxontag(localclientnum, level._effect["sword_bloodswipe_r_level2_1p"], self, "j_spineupper");
        }
    }
    self playsound(0, "zmb_sword_zombie_explode");
}

// Namespace zm_weap_glaive
// Params 7, eflags: 0x0
// Checksum 0x69290ad2, Offset: 0x9d0
// Size: 0x104
function function_38924d95(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (util::is_mature() && !util::is_gib_restricted_build()) {
        if (newval == 1) {
            playfxontag(localclientnum, level._effect["sword_bloodswipe_l_1p"], self, "j_spine4");
        } else if (newval == 2) {
            playfxontag(localclientnum, level._effect["sword_bloodswipe_l_level2_1p"], self, "j_spineupper");
        }
    }
    self playsound(0, "zmb_sword_zombie_explode");
}

// Namespace zm_weap_glaive
// Params 7, eflags: 0x0
// Checksum 0x639f2132, Offset: 0xae0
// Size: 0x5c
function function_69a90263(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    thread do_gravity_spike_fx(localclientnum, self, self.origin);
}

// Namespace zm_weap_glaive
// Params 7, eflags: 0x0
// Checksum 0x3a70cc4d, Offset: 0xb48
// Size: 0xec
function function_6b6e650c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    owner = self getowner(localclientnum);
    if (isdefined(owner) && owner == getlocalplayer(localclientnum)) {
        var_b7fb3c1b = playfxoncamera(localclientnum, level._effect["sword_lvl2_throw"], (0, 0, 0), (0, 1, 0), (0, 0, 1));
        wait 3;
        deletefx(localclientnum, var_b7fb3c1b, 1);
    }
}

// Namespace zm_weap_glaive
// Params 3, eflags: 0x0
// Checksum 0x1e70591a, Offset: 0xc40
// Size: 0x19c
function do_gravity_spike_fx(localclientnum, owner, position) {
    usefirst = 0;
    if (self isplayer() && self islocalplayer() && !isdemoplaying()) {
        if (!isdefined(self getlocalclientnumber()) || localclientnum == self getlocalclientnumber()) {
            usefirst = 1;
        }
    }
    if (usefirst) {
        fx = level._effect["groundhit_1p"];
        fwd = anglestoforward(owner.angles);
        playfx(localclientnum, fx, position + fwd * 100, fwd);
        return;
    }
    fx = level._effect["groundhit_3p"];
    fwd = anglestoforward(owner.angles);
    playfx(localclientnum, fx, position, fwd);
}

// Namespace zm_weap_glaive
// Params 5, eflags: 0x0
// Checksum 0x5e85fb25, Offset: 0xde8
// Size: 0xb6
function getideallocationforfx(startpos, fxindex, fxcount, defaultdistance, rotation) {
    currentangle = 360 / fxcount * fxindex;
    coscurrent = cos(currentangle + rotation);
    sincurrent = sin(currentangle + rotation);
    return startpos + (defaultdistance * coscurrent, defaultdistance * sincurrent, 0);
}

// Namespace zm_weap_glaive
// Params 3, eflags: 0x0
// Checksum 0x75a51745, Offset: 0xea8
// Size: 0xe2
function randomizelocation(startpos, max_x_offset, max_y_offset) {
    half_x = int(max_x_offset / 2);
    half_y = int(max_y_offset / 2);
    rand_x = randomintrange(half_x * -1, half_x);
    rand_y = randomintrange(half_y * -1, half_y);
    return startpos + (rand_x, rand_y, 0);
}

// Namespace zm_weap_glaive
// Params 2, eflags: 0x0
// Checksum 0x4fd5a9d4, Offset: 0xf98
// Size: 0x72
function ground_trace(startpos, owner) {
    trace_height = 50;
    trace_depth = 100;
    return bullettrace(startpos + (0, 0, trace_height), startpos - (0, 0, trace_depth), 0, owner);
}

