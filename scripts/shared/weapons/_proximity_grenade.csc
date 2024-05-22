#using scripts/shared/postfx_shared;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace proximity_grenade;

// Namespace proximity_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0x666763f5, Offset: 0x2f0
// Size: 0x104
function init_shared() {
    clientfield::register("toplayer", "tazered", 1, 1, "int", undefined, 0, 0);
    level._effect["prox_grenade_friendly_default"] = "weapon/fx_prox_grenade_scan_blue";
    level._effect["prox_grenade_friendly_warning"] = "weapon/fx_prox_grenade_wrn_grn";
    level._effect["prox_grenade_enemy_default"] = "weapon/fx_prox_grenade_scan_orng";
    level._effect["prox_grenade_enemy_warning"] = "weapon/fx_prox_grenade_wrn_red";
    level._effect["prox_grenade_player_shock"] = "weapon/fx_prox_grenade_impact_player_spwner";
    callback::add_weapon_type("proximity_grenade", &proximity_spawned);
    level thread watchforproximityexplosion();
}

// Namespace proximity_grenade
// Params 1, eflags: 0x1 linked
// Checksum 0xe3118a1e, Offset: 0x400
// Size: 0x84
function proximity_spawned(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self.equipmentfriendfx = level._effect["prox_grenade_friendly_default"];
    self.equipmentenemyfx = level._effect["prox_grenade_enemy_default"];
    self.equipmenttagfx = "tag_fx";
    self thread weaponobjects::equipmentteamobject(localclientnum);
}

// Namespace proximity_grenade
// Params 0, eflags: 0x1 linked
// Checksum 0xc1a64e51, Offset: 0x490
// Size: 0x198
function watchforproximityexplosion() {
    if (getactivelocalclients() > 1) {
        return;
    }
    weapon_proximity = getweapon("proximity_grenade");
    while (true) {
        localclientnum, position, mod, weapon, owner_cent = level waittill(#"explode");
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

