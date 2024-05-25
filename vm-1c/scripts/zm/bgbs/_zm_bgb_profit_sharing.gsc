#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_19b2be8a;

// Namespace namespace_19b2be8a
// Params 0, eflags: 0x2
// Checksum 0x349e44d2, Offset: 0x288
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_profit_sharing", &__init__, undefined, "bgb");
}

// Namespace namespace_19b2be8a
// Params 0, eflags: 0x1 linked
// Checksum 0x56cf753d, Offset: 0x2c8
// Size: 0xf4
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    clientfield::register("allplayers", "zm_bgb_profit_sharing_3p_fx", 15000, 1, "int");
    clientfield::register("toplayer", "zm_bgb_profit_sharing_1p_fx", 15000, 1, "int");
    bgb::register("zm_bgb_profit_sharing", "time", 600, &enable, &disable, undefined, undefined);
    bgb::function_ff4b2998("zm_bgb_profit_sharing", &add_to_player_score_override, 1);
}

// Namespace namespace_19b2be8a
// Params 0, eflags: 0x1 linked
// Checksum 0x835a979a, Offset: 0x3c8
// Size: 0x74
function enable() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    self thread bgb::function_4ed517b9(720, &function_ff41ae2d, &function_3c1690be);
    self thread function_677e212b();
}

// Namespace namespace_19b2be8a
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x448
// Size: 0x4
function disable() {
    
}

// Namespace namespace_19b2be8a
// Params 0, eflags: 0x1 linked
// Checksum 0x68b0a1b8, Offset: 0x458
// Size: 0x82
function function_677e212b() {
    self endon(#"disconnect");
    self clientfield::set("zm_bgb_profit_sharing_3p_fx", 1);
    self util::waittill_either("bled_out", "bgb_update");
    self clientfield::set("zm_bgb_profit_sharing_3p_fx", 0);
    self notify(#"hash_13182d68");
}

// Namespace namespace_19b2be8a
// Params 3, eflags: 0x1 linked
// Checksum 0x487fe3a7, Offset: 0x4e8
// Size: 0x236
function add_to_player_score_override(n_points, str_awarded_by, var_1ed9bd9b) {
    if (str_awarded_by == "zm_bgb_profit_sharing") {
        return n_points;
    }
    switch (str_awarded_by) {
    case 10:
    case 11:
    case 12:
    case 13:
        return n_points;
    default:
        break;
    }
    if (!var_1ed9bd9b) {
        foreach (e_player in level.players) {
            if (isdefined(e_player) && "zm_bgb_profit_sharing" == e_player bgb::get_enabled()) {
                if (isdefined(e_player.var_6638f10b) && array::contains(e_player.var_6638f10b, self)) {
                    e_player thread zm_score::add_to_player_score(n_points, 1, "zm_bgb_profit_sharing");
                }
            }
        }
    } else if (isdefined(self.var_6638f10b) && self.var_6638f10b.size > 0) {
        foreach (e_player in self.var_6638f10b) {
            if (isdefined(e_player)) {
                e_player thread zm_score::add_to_player_score(n_points, 1, "zm_bgb_profit_sharing");
            }
        }
    }
    return n_points;
}

// Namespace namespace_19b2be8a
// Params 1, eflags: 0x1 linked
// Checksum 0x9cae7a35, Offset: 0x728
// Size: 0xdc
function function_ff41ae2d(e_player) {
    self function_d1d595b5();
    e_player function_d1d595b5();
    str_notify = "profit_sharing_fx_stop_" + self getentitynumber();
    level util::waittill_any_ents(e_player, "disconnect", e_player, str_notify, self, "disconnect", self, "profit_sharing_complete");
    if (isdefined(self)) {
        self function_c0b35f9d();
    }
    if (isdefined(e_player)) {
        e_player function_c0b35f9d();
    }
}

// Namespace namespace_19b2be8a
// Params 1, eflags: 0x1 linked
// Checksum 0xe52af0dc, Offset: 0x810
// Size: 0x3e
function function_3c1690be(e_player) {
    str_notify = "profit_sharing_fx_stop_" + self getentitynumber();
    e_player notify(str_notify);
}

// Namespace namespace_19b2be8a
// Params 0, eflags: 0x1 linked
// Checksum 0x6534358c, Offset: 0x858
// Size: 0x60
function function_d1d595b5() {
    if (!isdefined(self.var_95b54) || self.var_95b54 == 0) {
        self.var_95b54 = 1;
        self clientfield::set_to_player("zm_bgb_profit_sharing_1p_fx", 1);
        return;
    }
    self.var_95b54++;
}

// Namespace namespace_19b2be8a
// Params 0, eflags: 0x1 linked
// Checksum 0xd977b079, Offset: 0x8c0
// Size: 0x3c
function function_c0b35f9d() {
    self.var_95b54--;
    if (self.var_95b54 == 0) {
        self clientfield::set_to_player("zm_bgb_profit_sharing_1p_fx", 0);
    }
}

