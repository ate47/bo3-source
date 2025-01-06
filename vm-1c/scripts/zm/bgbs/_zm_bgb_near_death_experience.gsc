#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_near_death_experience;

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x2
// Checksum 0xd4499142, Offset: 0x358
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_near_death_experience", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x0
// Checksum 0xf79b960, Offset: 0x398
// Size: 0xf4
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    clientfield::register("allplayers", "zm_bgb_near_death_experience_3p_fx", 15000, 1, "int");
    clientfield::register("toplayer", "zm_bgb_near_death_experience_1p_fx", 15000, 1, "int");
    bgb::register("zm_bgb_near_death_experience", "rounds", 3, &enable, &disable, undefined, undefined);
    bgb::register_lost_perk_override("zm_bgb_near_death_experience", &lost_perk_override, 1);
}

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x0
// Checksum 0x16c20e6a, Offset: 0x498
// Size: 0xac
function enable() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    if (!isdefined(level.var_81ca70ba)) {
        level.var_81ca70ba = 0;
    }
    self thread bgb::function_4ed517b9(-16, &function_ff41ae2d, &function_3c1690be);
    self thread function_1a31df5b();
    self thread revive_override();
}

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x550
// Size: 0x4
function disable() {
    
}

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x0
// Checksum 0xfb568d8a, Offset: 0x560
// Size: 0x82
function function_1a31df5b() {
    self endon(#"disconnect");
    self clientfield::set("zm_bgb_near_death_experience_3p_fx", 1);
    self util::waittill_either("bled_out", "bgb_update");
    self clientfield::set("zm_bgb_near_death_experience_3p_fx", 0);
    self notify(#"zm_bgb_near_death_experience_complete");
}

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x0
// Checksum 0x6e4d6282, Offset: 0x5f0
// Size: 0x1da
function revive_override() {
    foreach (e_player in level.players) {
        e_player function_8b5fe69();
    }
    if (level.var_81ca70ba == 0) {
        callback::on_connect(&on_connect);
    }
    level.var_81ca70ba++;
    self util::waittill_any("disconnect", "bled_out", "bgb_update");
    level.var_81ca70ba--;
    if (level.var_81ca70ba == 0) {
        callback::remove_on_connect(&on_connect);
    }
    foreach (e_player in level.players) {
        e_player zm_laststand::deregister_revive_override(e_player.var_e82a0595[0]);
        arrayremoveindex(e_player.var_e82a0595, 0);
    }
}

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x0
// Checksum 0x5c4f2489, Offset: 0x7d8
// Size: 0x1c
function on_connect() {
    self function_8b5fe69();
}

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x0
// Checksum 0xa3fac9ac, Offset: 0x800
// Size: 0xb2
function function_8b5fe69() {
    if (!isdefined(self.var_e82a0595)) {
        self.var_e82a0595 = [];
    }
    s_revive_override = self zm_laststand::register_revive_override(&function_73277c01);
    if (!isdefined(self.var_e82a0595)) {
        self.var_e82a0595 = [];
    } else if (!isarray(self.var_e82a0595)) {
        self.var_e82a0595 = array(self.var_e82a0595);
    }
    self.var_e82a0595[self.var_e82a0595.size] = s_revive_override;
}

// Namespace zm_bgb_near_death_experience
// Params 1, eflags: 0x0
// Checksum 0xe615eb8a, Offset: 0x8c0
// Size: 0x216
function function_73277c01(e_revivee) {
    if (!isdefined(e_revivee.revivetrigger)) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (self laststand::player_is_in_laststand()) {
        return false;
    }
    if (self.team != e_revivee.team) {
        return false;
    }
    if (isdefined(self.is_zombie) && self.is_zombie) {
        return false;
    }
    if (isdefined(level.can_revive_use_depthinwater_test) && level.can_revive_use_depthinwater_test && e_revivee depthinwater() > 10) {
        return true;
    }
    if (isdefined(level.can_revive) && ![[ level.can_revive ]](e_revivee)) {
        return false;
    }
    if (isdefined(level.var_ae6ced2b) && ![[ level.var_ae6ced2b ]](e_revivee)) {
        return false;
    }
    if (e_revivee zm::in_kill_brush() || !e_revivee zm::in_enabled_playable_area()) {
        return false;
    }
    if (self bgb::is_enabled("zm_bgb_near_death_experience") && isdefined(self.var_6638f10b) && array::contains(self.var_6638f10b, e_revivee)) {
        return true;
    }
    if (e_revivee bgb::is_enabled("zm_bgb_near_death_experience") && isdefined(e_revivee.var_6638f10b) && array::contains(e_revivee.var_6638f10b, self)) {
        return true;
    }
    return false;
}

// Namespace zm_bgb_near_death_experience
// Params 3, eflags: 0x0
// Checksum 0xe882d5bb, Offset: 0xae0
// Size: 0x5e
function lost_perk_override(perk, var_2488e46a, var_24df4040) {
    if (!isdefined(var_2488e46a)) {
        var_2488e46a = undefined;
    }
    if (!isdefined(var_24df4040)) {
        var_24df4040 = undefined;
    }
    self thread bgb::revive_and_return_perk_on_bgb_activation(perk);
    return false;
}

// Namespace zm_bgb_near_death_experience
// Params 1, eflags: 0x0
// Checksum 0x9769d7b9, Offset: 0xb48
// Size: 0x112
function function_ff41ae2d(e_player) {
    var_5b3c4fd2 = "zm_bgb_near_death_experience_proximity_end_" + self getentitynumber();
    e_player endon(var_5b3c4fd2);
    e_player endon(#"disconnect");
    self endon(#"disconnect");
    self endon(#"zm_bgb_near_death_experience_complete");
    while (true) {
        if (!e_player laststand::player_is_in_laststand() && !self laststand::player_is_in_laststand()) {
            util::waittill_any_ents_two(e_player, "player_downed", self, "player_downed");
        }
        self thread function_1863dac5(e_player, var_5b3c4fd2);
        var_c888b99d = "zm_bgb_near_death_experience_1p_fx_stop_" + self getentitynumber();
        e_player waittill(var_c888b99d);
    }
}

// Namespace zm_bgb_near_death_experience
// Params 2, eflags: 0x0
// Checksum 0xd2df0eb3, Offset: 0xc68
// Size: 0x10a
function function_1863dac5(e_player, str_notify) {
    var_ac3e3041 = self function_52d6b4dc(e_player, str_notify);
    if (!(isdefined(var_ac3e3041) && var_ac3e3041)) {
        return;
    }
    self function_d1d595b5();
    e_player function_d1d595b5();
    self function_c8cee225(e_player, str_notify);
    if (isdefined(self)) {
        self function_c0b35f9d();
    }
    if (isdefined(e_player)) {
        e_player function_c0b35f9d();
        e_player notify("zm_bgb_near_death_experience_1p_fx_stop_" + self getentitynumber());
    }
}

// Namespace zm_bgb_near_death_experience
// Params 2, eflags: 0x0
// Checksum 0xa73d97e9, Offset: 0xd80
// Size: 0x90
function function_52d6b4dc(e_player, str_notify) {
    e_player endon(str_notify);
    e_player endon(#"disconnect");
    self endon(#"disconnect");
    self endon(#"zm_bgb_near_death_experience_complete");
    while (!self function_73277c01(e_player) && !e_player function_73277c01(self)) {
        wait 0.1;
    }
    return true;
}

// Namespace zm_bgb_near_death_experience
// Params 2, eflags: 0x0
// Checksum 0xbfd14348, Offset: 0xe18
// Size: 0x84
function function_c8cee225(e_player, str_notify) {
    e_player endon(str_notify);
    e_player endon(#"disconnect");
    self endon(#"disconnect");
    self endon(#"zm_bgb_near_death_experience_complete");
    while (self function_73277c01(e_player) || e_player function_73277c01(self)) {
        wait 0.1;
    }
}

// Namespace zm_bgb_near_death_experience
// Params 1, eflags: 0x0
// Checksum 0xb2d36609, Offset: 0xea8
// Size: 0x3e
function function_3c1690be(e_player) {
    str_notify = "zm_bgb_near_death_experience_proximity_end_" + self getentitynumber();
    e_player notify(str_notify);
}

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x0
// Checksum 0xf2eb5a4d, Offset: 0xef0
// Size: 0x60
function function_d1d595b5() {
    if (!isdefined(self.var_62125e4d) || self.var_62125e4d == 0) {
        self.var_62125e4d = 1;
        self clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 1);
        return;
    }
    self.var_62125e4d++;
}

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x0
// Checksum 0xf53890c7, Offset: 0xf58
// Size: 0x3c
function function_c0b35f9d() {
    self.var_62125e4d--;
    if (self.var_62125e4d == 0) {
        self clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 0);
    }
}

