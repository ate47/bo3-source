#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace hazard;

// Namespace hazard
// Params 0, eflags: 0x2
// Checksum 0x4d9cadcf, Offset: 0x248
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("hazard", &__init__, undefined, undefined);
}

// Namespace hazard
// Params 0, eflags: 0x1 linked
// Checksum 0xbc6fbdbe, Offset: 0x288
// Size: 0x13c
function __init__() {
    function_6c2729dd("heat", 500, 50, 1, &function_476442fb);
    function_6c2729dd("filter", 500, 50, 2);
    function_6c2729dd("o2", 500, 60, 3, &function_8b413656);
    function_6c2729dd("radation", 500, 50, 4);
    function_6c2729dd("biohazard", 500, 50, 5);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_killed(&on_player_killed);
    callback::on_connect(&on_player_connect);
}

// Namespace hazard
// Params 5, eflags: 0x1 linked
// Checksum 0x3d1698c4, Offset: 0x3d0
// Size: 0xec
function function_6c2729dd(str_name, var_4758598, n_regen_rate, n_type, var_f313500d) {
    if (!isdefined(level.var_7817fe3c)) {
        level.var_7817fe3c = [];
    }
    if (!isdefined(level.var_7817fe3c[str_name])) {
        level.var_7817fe3c[str_name] = spawnstruct();
    }
    level.var_7817fe3c[str_name].var_4758598 = var_4758598;
    level.var_7817fe3c[str_name].n_regen_rate = n_regen_rate;
    level.var_7817fe3c[str_name].n_type = n_type;
    level.var_7817fe3c[str_name].var_f313500d = var_f313500d;
}

// Namespace hazard
// Params 0, eflags: 0x1 linked
// Checksum 0x3f6eee1c, Offset: 0x4c8
// Size: 0x1c
function on_player_spawned() {
    reset(1);
}

// Namespace hazard
// Params 0, eflags: 0x1 linked
// Checksum 0x8b2a3fcf, Offset: 0x4f0
// Size: 0x4c
function on_player_connect() {
    reset(0);
    self thread function_b6af57a8();
    self thread function_a421f870();
}

// Namespace hazard
// Params 0, eflags: 0x1 linked
// Checksum 0xab3171a, Offset: 0x548
// Size: 0x1c
function on_player_killed() {
    reset(1);
}

// Namespace hazard
// Params 1, eflags: 0x1 linked
// Checksum 0x7100897c, Offset: 0x570
// Size: 0x11c
function reset(var_b18f74fe) {
    foreach (str_name, _ in level.var_7817fe3c) {
        self.var_7dec7e93[str_name] = 0;
        self.var_6c3e78bb[str_name] = 1;
    }
    self.var_8657b6f = [];
    self.var_8657b6f["hudItems.hess1"] = 0;
    self.var_8657b6f["hudItems.hess2"] = 0;
    if (var_b18f74fe) {
        self setcontrolleruimodelvalue("hudItems.hess1.type", 0);
        self setcontrolleruimodelvalue("hudItems.hess2.type", 0);
    }
}

// Namespace hazard
// Params 0, eflags: 0x1 linked
// Checksum 0xb6fdd4c3, Offset: 0x698
// Size: 0xf6
function function_b6af57a8() {
    self endon(#"disconnect");
    while (true) {
        level waittill(#"save_restore");
        if (isdefined(self.var_8dcb3948) && self.var_8dcb3948) {
            continue;
        }
        var_8601d520 = getarraykeys(level.var_7817fe3c);
        foreach (str_name in var_8601d520) {
            self do_damage(str_name, 3, undefined);
            wait(0.1);
        }
    }
}

// Namespace hazard
// Params 0, eflags: 0x1 linked
// Checksum 0xcfe483d9, Offset: 0x798
// Size: 0xce
function function_a421f870() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"player_revived");
        foreach (str_name, _ in level.var_7817fe3c) {
            if (function_b78a859e(str_name) >= 1) {
                function_12231466(str_name);
            }
        }
    }
}

// Namespace hazard
// Params 1, eflags: 0x1 linked
// Checksum 0x6f222bbb, Offset: 0x870
// Size: 0x56
function function_12231466(str_name) {
    assert(isdefined(level.var_7817fe3c[str_name]), "hudItems.hess1.type" + str_name + "hudItems.hess1.type");
    self.var_7dec7e93[str_name] = 0;
}

// Namespace hazard
// Params 4, eflags: 0x1 linked
// Checksum 0xbfde7e7b, Offset: 0x8d0
// Size: 0x1c6
function do_damage(str_name, n_damage, e_ent, disable_ui) {
    assert(isdefined(level.var_7817fe3c[str_name]), "hudItems.hess1.type" + str_name + "hudItems.hess1.type");
    if (!isdefined(disable_ui)) {
        disable_ui = 0;
    }
    if (scene::is_igc_active()) {
        return false;
    }
    var_1fc26863 = level.var_7817fe3c[str_name];
    self.var_7dec7e93[str_name] = min(self.var_7dec7e93[str_name] + n_damage, var_1fc26863.var_4758598);
    if (self.var_7dec7e93[str_name] < var_1fc26863.var_4758598) {
        self thread function_be12f5f8(str_name, e_ent, disable_ui);
        return true;
    }
    switch (str_name) {
    case 3:
        str_mod = "MOD_DROWN";
        break;
    case 1:
        str_mod = "MOD_BURNED";
        break;
    default:
        str_mod = "MOD_UNKNOWN";
        break;
    }
    self dodamage(self.health, self.origin, undefined, undefined, undefined, str_mod);
    return false;
}

// Namespace hazard
// Params 1, eflags: 0x1 linked
// Checksum 0xe9fcf0c3, Offset: 0xaa0
// Size: 0x50
function function_eaa9157d(str_name) {
    assert(isdefined(self.var_7dec7e93[str_name]), "hudItems.hess1.type" + str_name + "hudItems.hess1.type");
    return self.var_7dec7e93[str_name];
}

// Namespace hazard
// Params 1, eflags: 0x1 linked
// Checksum 0xe1b74171, Offset: 0xaf8
// Size: 0x68
function function_b78a859e(str_name) {
    assert(isdefined(self.var_7dec7e93[str_name]), "hudItems.hess1.type" + str_name + "hudItems.hess1.type");
    return self.var_7dec7e93[str_name] / level.var_7817fe3c[str_name].var_4758598;
}

// Namespace hazard
// Params 2, eflags: 0x1 linked
// Checksum 0xe491cff7, Offset: 0xb68
// Size: 0x76
function function_459e5eff(str_name, var_5b9ad5b3) {
    if (!isdefined(var_5b9ad5b3)) {
        var_5b9ad5b3 = 1;
    }
    assert(isdefined(self.var_6c3e78bb[str_name]), "hudItems.hess1.type" + str_name + "hudItems.hess1.type");
    self.var_6c3e78bb[str_name] = var_5b9ad5b3;
}

// Namespace hazard
// Params 3, eflags: 0x5 linked
// Checksum 0xf67374c3, Offset: 0xbe8
// Size: 0x38c
function private function_be12f5f8(str_name, e_ent, disable_ui) {
    self notify("_hazard_protection_" + str_name);
    self endon("_hazard_protection_" + str_name);
    self endon(#"death");
    var_1fc26863 = level.var_7817fe3c[str_name];
    var_c8fe868d = "";
    foreach (model, type in self.var_8657b6f) {
        if (type == var_1fc26863.n_type) {
            var_c8fe868d = model;
            break;
        }
    }
    if (var_c8fe868d == "") {
        foreach (model, type in self.var_8657b6f) {
            if (type == 0) {
                var_c8fe868d = model;
                break;
            }
        }
    }
    if (var_c8fe868d != "") {
        if (!disable_ui) {
            self setcontrolleruimodelvalue(var_c8fe868d + ".type", var_1fc26863.n_type);
        }
        self.var_8657b6f[var_c8fe868d] = var_1fc26863.n_type;
    }
    do {
        n_frac = mapfloat(0, var_1fc26863.var_4758598, 1, 0, self.var_7dec7e93[str_name]);
        if (var_c8fe868d != "" && !disable_ui) {
            self setcontrolleruimodelvalue(var_c8fe868d + ".ratio", n_frac);
        }
        if (isdefined(var_1fc26863.var_f313500d)) {
            [[ var_1fc26863.var_f313500d ]](n_frac, e_ent);
        }
        wait(0.05);
        if (self.var_6c3e78bb[str_name] == 1) {
            self.var_7dec7e93[str_name] = self.var_7dec7e93[str_name] - var_1fc26863.n_regen_rate * 0.05;
        }
    } while (self.var_7dec7e93[str_name] >= 0);
    self function_45f02912();
    if (var_c8fe868d != "") {
        if (!disable_ui) {
            self setcontrolleruimodelvalue(var_c8fe868d + ".type", 0);
        }
        self.var_8657b6f[var_c8fe868d] = 0;
        return;
    }
    assert("hudItems.hess1.type");
}

// Namespace hazard
// Params 0, eflags: 0x1 linked
// Checksum 0xfdb4c3a0, Offset: 0xf80
// Size: 0x44
function function_45f02912() {
    self clientfield::set("burn", 0);
    self clientfield::set_to_player("player_cam_bubbles", 0);
}

// Namespace hazard
// Params 2, eflags: 0x1 linked
// Checksum 0xdf4b273f, Offset: 0xfd0
// Size: 0xe4
function function_476442fb(var_e9a83a8e, e_ent) {
    if (!isdefined(e_ent) || scene::is_igc_active()) {
        self.var_65e617f8 = undefined;
        self clientfield::set("burn", 0);
        return;
    }
    if (!(isdefined(self.var_65e617f8) && self.var_65e617f8) && self istouching(e_ent)) {
        self clientfield::set("burn", 1);
        return;
    }
    self.var_65e617f8 = undefined;
    self clientfield::set("burn", 0);
}

// Namespace hazard
// Params 0, eflags: 0x1 linked
// Checksum 0xe9c8fd62, Offset: 0x10c0
// Size: 0x54
function function_503a50a8() {
    self endon(#"death");
    self clientfield::set_to_player("player_cam_bubbles", 1);
    wait(4);
    self clientfield::set_to_player("player_cam_bubbles", 0);
}

// Namespace hazard
// Params 2, eflags: 0x1 linked
// Checksum 0x173e20b7, Offset: 0x1120
// Size: 0x214
function function_8b413656(var_d2eebe84, e_ent) {
    if (!isdefined(self.var_18c7e911)) {
        self.var_18c7e911 = 0;
    }
    if (var_d2eebe84 <= 0.2) {
        if (self.var_18c7e911 > 0.2) {
            self thread function_503a50a8();
        }
    } else if (var_d2eebe84 <= 0.1) {
        if (self.var_18c7e911 > 0.1) {
            self thread function_503a50a8();
        }
    }
    var_b45ec125 = array(0.5, 0.3, 0.2, 0.15, 0.1, 0.5);
    foreach (num in var_b45ec125) {
        if (var_d2eebe84 != 0 && var_d2eebe84 <= num) {
            if (self.var_18c7e911 > num) {
                self playsound("vox_plyr_uw_gasp");
                if (num < 0.4) {
                    self thread function_fda01c41("vox_plyr_uw_emerge_gasp");
                } else {
                    self thread function_fda01c41("vox_plyr_uw_emerge");
                }
                break;
            }
        }
    }
    self.var_18c7e911 = var_d2eebe84;
}

// Namespace hazard
// Params 1, eflags: 0x1 linked
// Checksum 0x15c159cc, Offset: 0x1340
// Size: 0x84
function function_fda01c41(alias) {
    self notify(#"hash_fda01c41");
    self endon(#"hash_fda01c41");
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"save_restore");
    while (self isplayerunderwater()) {
        wait(0.1);
    }
    self playsound(alias);
}

// Namespace hazard
// Params 2, eflags: 0x0
// Checksum 0x76e0ff17, Offset: 0x13d0
// Size: 0x54
function function_e9b126ef(n_time, var_827d6de0) {
    if (!isdefined(var_827d6de0)) {
        var_827d6de0 = 1;
    }
    self thread function_ccddb105("o2", 4, n_time, var_827d6de0);
}

// Namespace hazard
// Params 4, eflags: 0x1 linked
// Checksum 0x40dde053, Offset: 0x1430
// Size: 0x1fa
function function_ccddb105(str_hazard, var_6d20ee14, n_time, var_827d6de0) {
    assert(isdefined(level.var_7817fe3c[str_hazard]), "hudItems.hess1.type" + str_hazard + "hudItems.hess1.type");
    self notify("stop_hazard_dot_" + str_hazard);
    self endon("stop_hazard_dot_" + str_hazard);
    self endon(#"death");
    self function_459e5eff(str_hazard, 0);
    var_dd075cd2 = 1;
    var_1fc26863 = level.var_7817fe3c[str_hazard];
    n_damage = var_6d20ee14;
    if (isdefined(n_time)) {
        var_97dd249c = self function_eaa9157d(str_hazard);
        var_90d01cd2 = var_1fc26863.var_4758598;
        var_7046c7b3 = var_827d6de0 * var_90d01cd2;
        var_a6321c17 = var_7046c7b3 - var_97dd249c;
        if (var_a6321c17 > 0) {
        }
    }
    for (n_damage = var_a6321c17 / n_time; true; n_damage = var_6d20ee14) {
        wait(1);
        var_dd075cd2 = self do_damage(str_hazard, n_damage);
        var_7ba0abc9 = self function_b78a859e(str_hazard);
        if (n_damage > var_6d20ee14 && var_7ba0abc9 >= var_827d6de0) {
        }
    }
}

// Namespace hazard
// Params 1, eflags: 0x0
// Checksum 0x10c8cc52, Offset: 0x1638
// Size: 0x3c
function function_60455f28(str_hazard) {
    self notify("stop_hazard_dot_" + str_hazard);
    self function_459e5eff(str_hazard, 1);
}

