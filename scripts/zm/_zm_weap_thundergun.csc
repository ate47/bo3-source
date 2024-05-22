#using scripts/zm/_zm_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_weap_thundergun;

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x2
// Checksum 0xf681ef31, Offset: 0x168
// Size: 0x3c
function function_2dc19561() {
    system::register("zm_weap_thundergun", &__init__, &__main__, undefined);
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x0
// Checksum 0x60c22cbe, Offset: 0x1b0
// Size: 0x44
function __init__() {
    level.var_65cd3ef2 = getweapon("thundergun");
    level.var_15a75be2 = getweapon("thundergun_upgraded");
}

// Namespace zm_weap_thundergun
// Params 0, eflags: 0x0
// Checksum 0xea008cfd, Offset: 0x200
// Size: 0x24
function __main__() {
    callback::on_localplayer_spawned(&localplayer_spawned);
}

// Namespace zm_weap_thundergun
// Params 1, eflags: 0x0
// Checksum 0x358669e2, Offset: 0x230
// Size: 0x24
function localplayer_spawned(localclientnum) {
    self thread function_c94bc3fc(localclientnum);
}

// Namespace zm_weap_thundergun
// Params 1, eflags: 0x0
// Checksum 0x998364cb, Offset: 0x260
// Size: 0xa0
function function_c94bc3fc(localclientnum) {
    self endon(#"disconnect");
    self notify(#"hash_c94bc3fc");
    self endon(#"hash_c94bc3fc");
    while (isdefined(self)) {
        w_new_weapon, w_old_weapon = self waittill(#"weapon_change");
        if (w_new_weapon == level.var_65cd3ef2 || w_new_weapon == level.var_15a75be2) {
            self thread function_966c584f(localclientnum, w_new_weapon);
        }
    }
}

// Namespace zm_weap_thundergun
// Params 2, eflags: 0x0
// Checksum 0xa4d347a0, Offset: 0x308
// Size: 0x158
function function_966c584f(localclientnum, w_weapon) {
    self endon(#"disconnect");
    self endon(#"weapon_change");
    self endon(#"entityshutdown");
    n_old_ammo = -1;
    n_shader_val = 0;
    while (true) {
        wait(0.1);
        if (!isdefined(self)) {
            return;
        }
        n_ammo = getweaponammoclip(localclientnum, w_weapon);
        if (n_old_ammo > 0 && n_old_ammo != n_ammo) {
            thundergun_fx_fire(localclientnum);
        }
        n_old_ammo = n_ammo;
        if (n_ammo == 0) {
            self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
            continue;
        }
        n_shader_val = 4 - n_ammo;
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, n_shader_val, 0);
    }
}

// Namespace zm_weap_thundergun
// Params 1, eflags: 0x0
// Checksum 0x9b09bee2, Offset: 0x468
// Size: 0x2c
function thundergun_fx_fire(localclientnum) {
    playsound(localclientnum, "wpn_thunder_breath", (0, 0, 0));
}

