#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;

#namespace zm_genesis_util;

// Namespace zm_genesis_util
// Params 0, eflags: 0x2
// Checksum 0x7caed6f5, Offset: 0x400
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_genesis_util", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_util
// Params 0, eflags: 0x0
// Checksum 0xdf2873db, Offset: 0x448
// Size: 0x3dc
function __init__() {
    n_bits = getminbitcountfornum(8);
    clientfield::register("toplayer", "player_rumble_and_shake", 15000, n_bits, "int", &player_rumble_and_shake, 0, 0);
    n_bits = getminbitcountfornum(4);
    clientfield::register("scriptmover", "emit_smoke", 15000, n_bits, "int", &emit_smoke, 0, 0);
    n_bits = getminbitcountfornum(4);
    clientfield::register("scriptmover", "fire_trap", 15000, n_bits, "int", &fire_trap, 0, 0);
    clientfield::register("actor", "fire_trap_ignite_enemy", 15000, 1, "int", &fire_trap_ignite_enemy, 0, 0);
    clientfield::register("scriptmover", "rq_gateworm_magic", 15000, 1, "int", &rq_gateworm_magic, 0, 0);
    clientfield::register("scriptmover", "rq_gateworm_dissolve_finish", 15000, 1, "int", &rq_gateworm_dissolve_finish, 0, 0);
    clientfield::register("scriptmover", "rq_rune_glow", 15000, 1, "int", &rq_rune_glow, 0, 0);
    registerclientfield("world", "gen_rune_electricity", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "gen_rune_fire", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "gen_rune_light", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    registerclientfield("world", "gen_rune_shadow", 15000, 1, "int", &zm_utility::setsharedinventoryuimodels, 0, 1);
    clientfield::register("clientuimodel", "zmInventory.widget_rune_parts", 15000, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_rune_quest", 15000, 1, "int", undefined, 0, 0);
}

// Namespace zm_genesis_util
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x830
// Size: 0x4
function __main__() {
    
}

// Namespace zm_genesis_util
// Params 7, eflags: 0x0
// Checksum 0x38d77b9e, Offset: 0x840
// Size: 0x292
function player_rumble_and_shake(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"disconnect");
    switch (newval) {
    case 5:
        self thread function_878b1e6c(localclientnum, 1);
        break;
    case 6:
        self notify(#"hash_f9095a82");
        self earthquake(0.6, 1.5, self.origin, 100);
        self playrumbleonentity(localclientnum, "artillery_rumble");
        break;
    case 4:
        self earthquake(0.6, 1.5, self.origin, 100);
        self playrumbleonentity(localclientnum, "artillery_rumble");
        break;
    case 3:
        self earthquake(0.3, 1.5, self.origin, 100);
        self playrumbleonentity(localclientnum, "shotgun_fire");
        break;
    case 2:
        self earthquake(0.1, 1, self.origin, 100);
        self playrumbleonentity(localclientnum, "damage_light");
        break;
    case 1:
        self playrumbleonentity(localclientnum, "reload_large");
        break;
    case 7:
        self thread function_878b1e6c(localclientnum, 3, 0);
        break;
    case 0:
        self notify(#"hash_f9095a82");
        break;
    default:
        self notify(#"hash_f9095a82");
        break;
    }
}

// Namespace zm_genesis_util
// Params 3, eflags: 0x0
// Checksum 0x32db5bc7, Offset: 0xae0
// Size: 0x204
function function_878b1e6c(localclientnum, var_6bd691d0, var_10ba4a4c) {
    if (!isdefined(var_10ba4a4c)) {
        var_10ba4a4c = 1;
    }
    self notify(#"hash_f9095a82");
    self endon(#"disconnect");
    self endon(#"hash_f9095a82");
    start_time = gettime();
    while (gettime() - start_time < 120000) {
        if (isdefined(self) && self islocalplayer() && isdefined(self)) {
            switch (var_6bd691d0) {
            case 1:
                if (var_10ba4a4c) {
                    self earthquake(0.2, 1, self.origin, 100);
                }
                self playrumbleonentity(localclientnum, "reload_small");
                wait 0.05;
                break;
            case 2:
                if (var_10ba4a4c) {
                    self earthquake(0.3, 1, self.origin, 100);
                }
                self playrumbleonentity(localclientnum, "damage_light");
                break;
            case 3:
                if (var_10ba4a4c) {
                    self earthquake(0.3, 1, self.origin, 100);
                }
                self playrumbleonentity(localclientnum, "artillery_rumble");
                break;
            }
        }
        wait 0.1;
    }
}

// Namespace zm_genesis_util
// Params 7, eflags: 0x0
// Checksum 0x64355709, Offset: 0xcf0
// Size: 0x22e
function emit_smoke(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        self.var_c9da3e70 = playfx(localclientnum, level._effect["smoke_standard"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        break;
    case 2:
        self.var_c9da3e70 = playfx(localclientnum, level._effect["smoke_wall"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        break;
    case 3:
        self.var_c9da3e70 = playfx(localclientnum, level._effect["smoke_geyser"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        break;
    case 0:
        self notify(#"hash_b9956414");
        if (isdefined(self.var_c9da3e70)) {
            deletefx(localclientnum, self.var_c9da3e70, 0);
        }
        break;
    default:
        assert(0, "<dev string:x28>");
        break;
    }
}

// Namespace zm_genesis_util
// Params 3, eflags: 0x0
// Checksum 0x582360a5, Offset: 0xf28
// Size: 0xda
function function_ed6c6bcf(localclientnum, str_fx_name, var_bec640ba) {
    self endon(#"hash_b9956414");
    v_forward = anglestoforward(self.angles);
    v_up = anglestoup(self.angles);
    while (true) {
        self.var_c9da3e70 = playfx(localclientnum, level._effect[str_fx_name], self.origin, v_forward, v_up);
        wait var_bec640ba + randomfloatrange(0, 0.3);
    }
}

// Namespace zm_genesis_util
// Params 7, eflags: 0x0
// Checksum 0xc37e986d, Offset: 0x1010
// Size: 0x186
function fire_trap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    switch (newval) {
    case 0:
        self function_379d49e8(localclientnum);
        break;
    case 1:
        self.var_39d354b5 = playfxontag(localclientnum, level._effect["fire_ground_spotfire"], self, "tag_origin");
        break;
    case 2:
        self thread function_379d49e8(localclientnum, 1);
        self.var_39d354b5 = playfxontag(localclientnum, level._effect["fire_ground_spotfire_smoke"], self, "tag_origin");
        break;
    case 3:
        self function_379d49e8(localclientnum);
        self.var_39d354b5 = playfxontag(localclientnum, level._effect["fire_moving_fire_trap"], self, "tag_origin");
        break;
    }
}

// Namespace zm_genesis_util
// Params 2, eflags: 0x0
// Checksum 0xeaf8a08, Offset: 0x11a0
// Size: 0x64
function function_379d49e8(localclientnum, n_delay) {
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    self endon(#"entityshutdown");
    wait n_delay;
    if (isdefined(self.var_39d354b5)) {
        deletefx(localclientnum, self.var_39d354b5, 0);
    }
}

// Namespace zm_genesis_util
// Params 7, eflags: 0x0
// Checksum 0x9aee19bc, Offset: 0x1210
// Size: 0x74
function fire_trap_ignite_enemy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["fire_ignite_zombie"], self, "J_SpineUpper");
    }
}

// Namespace zm_genesis_util
// Params 5, eflags: 0x0
// Checksum 0xb278c18, Offset: 0x1290
// Size: 0x190
function function_267f859f(localclientnum, fx_id, b_on, var_afcc5d76, str_tag) {
    if (!isdefined(fx_id)) {
        fx_id = undefined;
    }
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (!isdefined(var_afcc5d76)) {
        var_afcc5d76 = 0;
    }
    if (!isdefined(str_tag)) {
        str_tag = "tag_origin";
    }
    if (!isdefined(self.var_270913b5)) {
        self.var_270913b5 = [];
    }
    if (b_on) {
        if (!isdefined(self)) {
            return;
        }
        if (isdefined(self.var_270913b5[localclientnum])) {
            stopfx(localclientnum, self.var_270913b5[localclientnum]);
        }
        if (var_afcc5d76) {
            self.var_270913b5[localclientnum] = playfxontag(localclientnum, fx_id, self, str_tag);
        } else {
            self.var_270913b5[localclientnum] = playfx(localclientnum, fx_id, self.origin, self.angles);
        }
        return;
    }
    if (isdefined(self.var_270913b5[localclientnum])) {
        stopfx(localclientnum, self.var_270913b5[localclientnum]);
        self.var_270913b5[localclientnum] = undefined;
    }
}

// Namespace zm_genesis_util
// Params 7, eflags: 0x0
// Checksum 0xbd27b902, Offset: 0x1428
// Size: 0xfc
function rq_gateworm_magic(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_7bd93049 = playfxontag(localclientnum, level._effect["rq_gateworm_dissolve"], self, "tag_origin");
        self thread rq_gateworm_dissolve(localclientnum, "scriptVector2");
        return;
    }
    if (isdefined(self.var_7bd93049)) {
        killfx(localclientnum, self.var_1ac96e93);
    }
    playfxontag(localclientnum, level._effect["rq_gateworm_magic_explo"], self, "j_head_1");
}

// Namespace zm_genesis_util
// Params 2, eflags: 0x0
// Checksum 0x190937ae, Offset: 0x1530
// Size: 0x140
function rq_gateworm_dissolve(localclientnum, var_9304bb31) {
    self endon(#"entityshutdown");
    n_start_time = gettime();
    n_end_time = n_start_time + 2 * 1000;
    b_is_updating = 1;
    while (b_is_updating) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_end_time);
            b_is_updating = 0;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
        }
        self mapshaderconstant(localclientnum, 0, var_9304bb31, n_shader_value, 0, 0);
        wait 0.01;
    }
}

// Namespace zm_genesis_util
// Params 7, eflags: 0x0
// Checksum 0xf8d076e9, Offset: 0x1678
// Size: 0x5c
function rq_gateworm_dissolve_finish(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread rq_gateworm_dissolve(localclientnum, "scriptVector0");
}

// Namespace zm_genesis_util
// Params 7, eflags: 0x0
// Checksum 0xfc55f258, Offset: 0x16e0
// Size: 0x136
function rq_rune_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_fc9c3ea1 = playfxontag(localclientnum, level._effect["rq_rune_glow"], self, "tag_origin");
        self playsound(0, "zmb_main_searchparty_rune_appear");
        if (!isdefined(self.var_a20d5c5c)) {
            self.var_a20d5c5c = self playloopsound("zmb_main_searchparty_rune_lp", 1);
        }
        return;
    }
    if (isdefined(self.n_fx)) {
        killfx(localclientnum, self.var_fc9c3ea1);
    }
    if (isdefined(self.var_a20d5c5c)) {
        self stoploopsound(self.var_a20d5c5c);
        self.var_a20d5c5c = undefined;
    }
}

