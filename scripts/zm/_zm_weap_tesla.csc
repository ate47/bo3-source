#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_lightning_chain;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_40b4687d;

// Namespace namespace_40b4687d
// Params 0, eflags: 0x0
// Checksum 0x744bfa64, Offset: 0x340
// Size: 0x184
function init() {
    level.var_168d703f = getweapon("tesla_gun");
    level.var_d22a87eb = getweapon("tesla_gun_upgraded");
    if (!zm_weapons::is_weapon_included(level.var_168d703f) && !(isdefined(level.var_2bb2277c) && level.var_2bb2277c)) {
        return;
    }
    level._effect["tesla_viewmodel_rail"] = "zombie/fx_tesla_rail_view_zmb";
    level._effect["tesla_viewmodel_tube"] = "zombie/fx_tesla_tube_view_zmb";
    level._effect["tesla_viewmodel_tube2"] = "zombie/fx_tesla_tube_view2_zmb";
    level._effect["tesla_viewmodel_tube3"] = "zombie/fx_tesla_tube_view3_zmb";
    level._effect["tesla_viewmodel_rail_upgraded"] = "zombie/fx_tesla_rail_view_ug_zmb";
    level._effect["tesla_viewmodel_tube_upgraded"] = "zombie/fx_tesla_tube_view_ug_zmb";
    level._effect["tesla_viewmodel_tube2_upgraded"] = "zombie/fx_tesla_tube_view2_ug_zmb";
    level._effect["tesla_viewmodel_tube3_upgraded"] = "zombie/fx_tesla_tube_view3_ug_zmb";
    level thread player_init();
    level thread function_2727564b();
}

// Namespace namespace_40b4687d
// Params 0, eflags: 0x1 linked
// Checksum 0x69c2fb84, Offset: 0x4d0
// Size: 0x10e
function player_init() {
    util::waitforclient(0);
    level.var_f1cff8ac = [];
    level.var_c82683aa = 1;
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        level.var_f1cff8ac[i] = 0;
        players[i] thread tesla_fx_rail(i);
        players[i] thread tesla_fx_tube(i);
        players[i] thread function_42b7c319(i);
        players[i] thread function_a99414e8(i);
    }
}

// Namespace namespace_40b4687d
// Params 1, eflags: 0x1 linked
// Checksum 0x308fbea, Offset: 0x5e8
// Size: 0x1b8
function tesla_fx_rail(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    for (;;) {
        wait(randomfloatrange(8, 12));
        if (!level.var_f1cff8ac[localclientnum]) {
            continue;
        }
        if (!level.var_c82683aa) {
            continue;
        }
        currentweapon = getcurrentweapon(localclientnum);
        if (currentweapon != level.var_168d703f && currentweapon != level.var_d22a87eb) {
            continue;
        }
        if (isads(localclientnum) || isthrowinggrenade(localclientnum) || ismeleeing(localclientnum) || isonturret(localclientnum)) {
            continue;
        }
        if (getweaponammoclip(localclientnum, currentweapon) <= 0) {
            continue;
        }
        fx = level._effect["tesla_viewmodel_rail"];
        if (currentweapon == level.var_d22a87eb) {
            fx = level._effect["tesla_viewmodel_rail_upgraded"];
        }
        playviewmodelfx(localclientnum, fx, "tag_flash");
        playsound(localclientnum, "wpn_tesla_effects", (0, 0, 0));
    }
}

// Namespace namespace_40b4687d
// Params 1, eflags: 0x1 linked
// Checksum 0x5c5f757e, Offset: 0x7a8
// Size: 0x350
function tesla_fx_tube(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    for (;;) {
        wait(0.1);
        if (!level.var_f1cff8ac[localclientnum]) {
            continue;
        }
        w_current = getcurrentweapon(localclientnum);
        if (w_current != level.var_168d703f && w_current != level.var_d22a87eb) {
            continue;
        }
        if (isthrowinggrenade(localclientnum) || ismeleeing(localclientnum) || isonturret(localclientnum)) {
            continue;
        }
        n_ammo = getweaponammoclip(localclientnum, w_current);
        if (n_ammo <= 0) {
            self clear_tesla_tube_effect(localclientnum);
            continue;
        }
        str_fx = level._effect["tesla_viewmodel_tube"];
        if (w_current == level.var_d22a87eb) {
            switch (n_ammo) {
            case 1:
            case 2:
                str_fx = level._effect["tesla_viewmodel_tube3_upgraded"];
                n_tint = 2;
                break;
            case 3:
            case 4:
                str_fx = level._effect["tesla_viewmodel_tube2_upgraded"];
                n_tint = 1;
                break;
            default:
                str_fx = level._effect["tesla_viewmodel_tube_upgraded"];
                n_tint = 0;
                break;
            }
        } else {
            switch (n_ammo) {
            case 1:
                str_fx = level._effect["tesla_viewmodel_tube3"];
                n_tint = 2;
                break;
            case 2:
                str_fx = level._effect["tesla_viewmodel_tube2"];
                n_tint = 1;
                break;
            default:
                str_fx = level._effect["tesla_viewmodel_tube"];
                n_tint = 0;
                break;
            }
        }
        if (self.str_tesla_current_tube_effect === str_fx) {
            continue;
        }
        if (isdefined(self.n_tesla_tube_fx_id)) {
            deletefx(localclientnum, self.n_tesla_tube_fx_id, 1);
        }
        self.str_tesla_current_tube_effect = str_fx;
        self.n_tesla_tube_fx_id = playviewmodelfx(localclientnum, str_fx, "tag_brass");
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, n_tint, 0);
    }
}

// Namespace namespace_40b4687d
// Params 0, eflags: 0x1 linked
// Checksum 0x2ea8fe49, Offset: 0xb00
// Size: 0x7a
function function_2727564b() {
    for (;;) {
        localclientnum, note = level waittill(#"notetrack");
        switch (note) {
        case 22:
            level.var_f1cff8ac[localclientnum] = 0;
            break;
        case 23:
            level.var_f1cff8ac[localclientnum] = 1;
            break;
        }
    }
}

// Namespace namespace_40b4687d
// Params 1, eflags: 0x1 linked
// Checksum 0x8011ab1b, Offset: 0xb88
// Size: 0xa0
function function_42b7c319(localclientnum) {
    for (;;) {
        level waittill(#"hash_d323b64a");
        currentweapon = getcurrentweapon(localclientnum);
        if (currentweapon == level.var_168d703f || currentweapon == level.var_d22a87eb) {
            playsound(localclientnum, "wpn_tesla_happy", (0, 0, 0));
            level.var_c82683aa = 0;
            wait(2);
            level.var_c82683aa = 1;
        }
    }
}

// Namespace namespace_40b4687d
// Params 1, eflags: 0x1 linked
// Checksum 0xe074b7d5, Offset: 0xc30
// Size: 0x48
function function_a99414e8(localclientnum) {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"weapon_change");
        self clear_tesla_tube_effect(localclientnum);
    }
}

// Namespace namespace_40b4687d
// Params 1, eflags: 0x1 linked
// Checksum 0x94ea0ee4, Offset: 0xc80
// Size: 0x7c
function clear_tesla_tube_effect(localclientnum) {
    if (isdefined(self.n_tesla_tube_fx_id)) {
        deletefx(localclientnum, self.n_tesla_tube_fx_id, 1);
        self.n_tesla_tube_fx_id = undefined;
        self.str_tesla_current_tube_effect = undefined;
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 3, 0);
    }
}

