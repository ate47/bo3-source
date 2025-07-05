#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace electroball_grenade;

// Namespace electroball_grenade
// Params 0, eflags: 0x2
// Checksum 0xfd18013, Offset: 0x3e8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("electroball_grenade", &__init__, undefined, undefined);
}

// Namespace electroball_grenade
// Params 0, eflags: 0x0
// Checksum 0x7758a97b, Offset: 0x428
// Size: 0x224
function __init__() {
    clientfield::register("toplayer", "tazered", 1, 1, "int", undefined, 0, 0);
    clientfield::register("allplayers", "electroball_shock", 1, 1, "int", &function_1619af16, 0, 0);
    clientfield::register("actor", "electroball_make_sparky", 1, 1, "int", &function_72eeb2e6, 0, 0);
    clientfield::register("missile", "electroball_stop_trail", 1, 1, "int", &function_bd1f6a88, 0, 0);
    clientfield::register("missile", "electroball_play_landed_fx", 1, 1, "int", &electroball_play_landed_fx, 0, 0);
    level._effect["fx_wpn_115_blob"] = "dlc1/castle/fx_wpn_115_blob";
    level._effect["fx_wpn_115_bul_trail"] = "dlc1/castle/fx_wpn_115_bul_trail";
    level._effect["fx_wpn_115_canister"] = "dlc1/castle/fx_wpn_115_canister";
    level._effect["electroball_grenade_player_shock"] = "weapon/fx_prox_grenade_impact_player_spwner";
    level._effect["electroball_grenade_sparky_conversion"] = "weapon/fx_prox_grenade_exp";
    callback::add_weapon_type("electroball_grenade", &proximity_spawned);
    level thread watchforproximityexplosion();
}

// Namespace electroball_grenade
// Params 1, eflags: 0x0
// Checksum 0x1ac2c6a6, Offset: 0x658
// Size: 0xb4
function proximity_spawned(localclientnum) {
    self util::waittill_dobj(localclientnum);
    if (self isgrenadedud()) {
        return;
    }
    self.var_886cac6a = playfxontag(localclientnum, level._effect["fx_wpn_115_bul_trail"], self, "j_grenade_front");
    self.var_5470a25d = playfxontag(localclientnum, level._effect["fx_wpn_115_canister"], self, "j_grenade_back");
}

// Namespace electroball_grenade
// Params 0, eflags: 0x0
// Checksum 0x1a0a9f4e, Offset: 0x718
// Size: 0x198
function watchforproximityexplosion() {
    if (getactivelocalclients() > 1) {
        return;
    }
    weapon_proximity = getweapon("electroball_grenade");
    while (true) {
        level waittill(#"explode", localclientnum, position, mod, weapon, owner_cent);
        if (weapon.rootweapon != weapon_proximity) {
            continue;
        }
        localplayer = getlocalplayer(localclientnum);
        if (!localplayer util::is_player_view_linked_to_entity(localclientnum)) {
            explosionradius = weapon.explosionradius;
            if (distancesquared(localplayer.origin, position) < explosionradius * explosionradius) {
                if (isdefined(owner_cent)) {
                    if (owner_cent == localplayer || !owner_cent util::function_f36b8920(localclientnum, 1)) {
                        localplayer thread postfx::playpostfxbundle("pstfx_shock_charge");
                    }
                }
            }
        }
    }
}

// Namespace electroball_grenade
// Params 7, eflags: 0x0
// Checksum 0xd7a9e66f, Offset: 0x8b8
// Size: 0x154
function function_72eeb2e6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    ai_zombie = self;
    if (isdefined(level.var_5069a5f6)) {
        var_1ee145b0 = arraygetclosest(ai_zombie.origin, level.var_5069a5f6);
    }
    var_de7d63cb = array("J_Spine4", "J_SpineUpper", "J_Spine1");
    tag = array::random(var_de7d63cb);
    if (isdefined(var_1ee145b0)) {
        var_d72ccbc = beamlaunch(localclientnum, var_1ee145b0, "tag_origin", ai_zombie, tag, "electric_arc_beam_electroball");
        wait 1;
        if (isdefined(var_d72ccbc)) {
            beamkill(localclientnum, var_d72ccbc);
        }
    }
}

// Namespace electroball_grenade
// Params 7, eflags: 0x0
// Checksum 0x723acdd3, Offset: 0xa18
// Size: 0x78
function function_1619af16(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    fx = playfxontag(localclientnum, level._effect["electroball_grenade_player_shock"], self, "J_SpineUpper");
}

// Namespace electroball_grenade
// Params 7, eflags: 0x0
// Checksum 0x38108816, Offset: 0xa98
// Size: 0x124
function function_bd1f6a88(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.var_5069a5f6)) {
        level.var_5069a5f6 = [];
    }
    array::add(level.var_5069a5f6, self);
    self thread function_1d823abf();
    if (isdefined(self.var_886cac6a)) {
        stopfx(localclientnum, self.var_886cac6a);
    }
    if (isdefined(self.var_626a3201)) {
        stopfx(localclientnum, self.var_626a3201);
    }
    if (isdefined(self.var_7a731cc6)) {
        stopfx(localclientnum, self.var_7a731cc6);
    }
    if (isdefined(self.var_5470a25d)) {
        stopfx(localclientnum, self.var_5470a25d);
    }
}

// Namespace electroball_grenade
// Params 0, eflags: 0x0
// Checksum 0xaa9ef4bf, Offset: 0xbc8
// Size: 0x34
function function_1d823abf() {
    self waittill(#"entityshutdown");
    level.var_5069a5f6 = array::remove_undefined(level.var_5069a5f6);
}

// Namespace electroball_grenade
// Params 7, eflags: 0x0
// Checksum 0x5e8f2ea5, Offset: 0xc08
// Size: 0xb8
function electroball_play_landed_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.var_3b22ba3c = playfxontag(localclientnum, level._effect["fx_wpn_115_blob"], self, "tag_origin");
    dynent = createdynentandlaunch(localclientnum, "p7_zm_ctl_115_grenade_broken", self.origin, self.angles, self.origin, (0, 0, 0));
}

