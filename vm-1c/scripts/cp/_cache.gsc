#using scripts/cp/_skipto;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;

#namespace cache;

// Namespace cache
// Params 0, eflags: 0x2
// Checksum 0x6f879fc8, Offset: 0x2e0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("cache", &__init__, undefined, undefined);
}

// Namespace cache
// Params 0, eflags: 0x1 linked
// Checksum 0x1dfcdc5a, Offset: 0x320
// Size: 0xa4
function __init__() {
    var_346386ce = getentarray("sys_ammo_cache", "targetname");
    array::thread_all(var_346386ce, &function_af11d807);
    var_b430d2a8 = getentarray("sys_weapon_cache", "targetname");
    array::thread_all(var_b430d2a8, &function_2b0d49bd);
}

// Namespace cache
// Params 0, eflags: 0x1 linked
// Checksum 0xf33394be, Offset: 0x3d0
// Size: 0x80
function function_af11d807() {
    util::waittill_asset_loaded("xmodel", self.model);
    self thread function_2f6eaad8();
    if (self.model != "p6_ammo_resupply_future_01" && self.model != "p6_ammo_resupply_80s_final_01") {
    }
    if (isdefined(level.var_4fd5c4a4)) {
        self thread [[ level.var_4fd5c4a4 ]]();
    }
}

// Namespace cache
// Params 0, eflags: 0x1 linked
// Checksum 0x95af93a6, Offset: 0x458
// Size: 0x74
function function_2b0d49bd() {
    util::waittill_asset_loaded("xmodel", self.model);
    level flag::wait_till("all_players_connected");
    self thread function_5ad8638a();
    self thread function_acb5494d();
}

// Namespace cache
// Params 0, eflags: 0x1 linked
// Checksum 0x6db1becd, Offset: 0x4d8
// Size: 0x260
function function_2f6eaad8() {
    self endon(#"hash_b6ecc65b");
    var_b0fde15b = self function_5d73924();
    if (isdefined(var_b0fde15b.script_string) && var_b0fde15b.script_string == "no_grenade") {
        var_b0fde15b.var_947d7e0b = 1;
    }
    var_b0fde15b sethintstring(%SCRIPT_AMMO_REFILL);
    var_b0fde15b setcursorhint("HINT_NOICON");
    while (true) {
        e_player = var_b0fde15b waittill(#"trigger");
        e_player disableweapons();
        e_player playsound("fly_ammo_crate_refill");
        wait(2);
        a_weapons = e_player getweaponslist();
        foreach (weapon in a_weapons) {
            if (isdefined(var_b0fde15b.var_947d7e0b) && var_b0fde15b.var_947d7e0b && weapons::is_grenade(weapon)) {
                continue;
            }
            e_player givemaxammo(weapon);
            e_player setweaponammoclip(weapon, weapon.clipsize);
        }
        e_player enableweapons();
        e_player notify(#"hash_a88bbdc9");
    }
}

// Namespace cache
// Params 0, eflags: 0x1 linked
// Checksum 0xc914fb1, Offset: 0x740
// Size: 0x5c
function function_5d73924() {
    var_301cff54 = getentarray("trigger_ammo_cache", "targetname");
    var_b0fde15b = arraygetclosest(self.origin, var_301cff54);
    return var_b0fde15b;
}

// Namespace cache
// Params 0, eflags: 0x1 linked
// Checksum 0xe3eff64d, Offset: 0x7a8
// Size: 0x588
function function_5ad8638a() {
    var_9a9860c6 = level.players[0] getloadoutweapon(0, "primary");
    var_bb78fd0e = level.players[0] getloadoutweapon(0, "secondary");
    var_5d00b0c = (-5, 0, 15);
    var_1b46be27 = (-10, 0, 15);
    var_2ba1c80f = (0, 0, 15);
    var_47db02d5 = 0;
    var_42ec473e = var_9a9860c6.rootweapon;
    if (var_42ec473e != level.weaponnull && isassetloaded("weapon", var_42ec473e.name)) {
        var_d6eae42f = self gettagorigin("loadOut_B");
        var_d31f6c52 = anglestoright(self gettagangles("loadOut_B")) * var_47db02d5;
        var_c1e132ef = spawn("weapon_" + var_9a9860c6.name + level.game_mode_suffix, var_d6eae42f + var_d31f6c52 + var_2ba1c80f, 8);
        var_c1e132ef.angles = self gettagangles("loadOut_B") + (0, -90, 0);
    } else if (isassetloaded("weapon", "hk416" + level.game_mode_suffix)) {
        var_d6eae42f = self gettagorigin("loadOut_B");
        var_d31f6c52 = anglestoright(self gettagangles("loadOut_B")) * var_47db02d5;
        var_c1e132ef = spawn("weapon_" + "ar_standard" + level.game_mode_suffix, var_d6eae42f + var_d31f6c52 + var_2ba1c80f, 8);
        var_c1e132ef.angles = self gettagangles("loadOut_B") + (0, -90, 0);
    }
    switch (self.model) {
    case 20:
    case 21:
        var_47db02d5 = -3;
        break;
    default:
        var_47db02d5 = -4;
        break;
    }
    var_50e503e6 = var_bb78fd0e.rootweapon;
    if (var_50e503e6 != level.weaponnull && isassetloaded("weapon", var_50e503e6.name)) {
        var_8501a503 = self gettagorigin("loadOut_A");
        var_d31f6c52 = anglestoright(self gettagangles("loadOut_A")) * var_47db02d5;
        var_c1e132ef = spawn("weapon_" + var_bb78fd0e + level.game_mode_suffix, var_8501a503 + var_d31f6c52 + var_2ba1c80f, 8);
        var_c1e132ef.angles = self gettagangles("loadOut_A") + (0, -90, 0);
        return;
    }
    if (isassetloaded("weapon", "smg_fastfire" + level.game_mode_suffix)) {
        var_8501a503 = self gettagorigin("loadOut_A");
        var_d31f6c52 = anglestoright(self gettagangles("loadOut_A")) * var_47db02d5;
        var_c1e132ef = spawn("weapon_" + "smg_fastfire" + level.game_mode_suffix, var_8501a503 + var_d31f6c52 + var_2ba1c80f, 8);
        var_c1e132ef.angles = self gettagangles("loadOut_A") + (0, -90, 0);
    }
}

// Namespace cache
// Params 0, eflags: 0x1 linked
// Checksum 0xc6864b5, Offset: 0xd38
// Size: 0x284
function function_acb5494d() {
    if (isdefined(self.var_175017a9)) {
        var_10d1f7d8 = self gettagorigin("auxilary_A");
        assert(isdefined(var_10d1f7d8), "no_grenade");
        switch (self.model) {
        default:
            var_d31f6c52 = anglestoright(self gettagangles("auxilary_A")) * 5;
            break;
        }
        var_c1e132ef = spawn("weapon_" + self.var_175017a9 + level.game_mode_suffix, var_10d1f7d8 + var_d31f6c52 + (0, 0, 10), 8);
        var_c1e132ef.angles = self gettagangles("auxilary_A") + (0, -90, 0);
        var_c1e132ef itemweaponsetammo(9999, 9999);
    }
    if (isdefined(self.var_3d529212)) {
        var_10d1f7d8 = self gettagorigin("secondary_A");
        assert(isdefined(var_10d1f7d8), "no_grenade");
        var_d31f6c52 = anglestoforward(self gettagangles("secondary_A")) * 10;
        var_c1e132ef = spawn("weapon_" + self.var_3d529212 + level.game_mode_suffix, var_10d1f7d8 + var_d31f6c52 + (0, 0, 10), 8);
        var_c1e132ef.angles = self gettagangles("secondary_A");
        var_c1e132ef itemweaponsetammo(9999, 9999);
    }
}

/#

    // Namespace cache
    // Params 0, eflags: 0x0
    // Checksum 0x1aa4595d, Offset: 0xfc8
    // Size: 0x142
    function function_fdbce913() {
        tag_array = [];
        tag_array[tag_array.size] = "no_grenade";
        tag_array[tag_array.size] = "no_grenade";
        tag_array[tag_array.size] = "no_grenade";
        tag_array[tag_array.size] = "no_grenade";
        tag_array[tag_array.size] = "no_grenade";
        tag_array[tag_array.size] = "no_grenade";
        tag_array[tag_array.size] = "no_grenade";
        tag_array[tag_array.size] = "no_grenade";
        foreach (tag in tag_array) {
            self thread function_4fe8e0cc(tag);
        }
    }

    // Namespace cache
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7a265192, Offset: 0x1118
    // Size: 0x80
    function function_4fe8e0cc(tag) {
        while (true) {
            if (isdefined(self gettagorigin(tag))) {
                print3d(self gettagorigin(tag), tag, (1, 1, 1), 1, 0.15);
            }
            wait(0.05);
        }
    }

#/

// Namespace cache
// Params 1, eflags: 0x0
// Checksum 0xc3cfcd6, Offset: 0x11a0
// Size: 0x104
function function_b6ecc65b(var_e9338998) {
    var_301cff54 = getentarray(var_e9338998, "script_noteworthy");
    assert(isdefined(var_301cff54), "no_grenade" + var_e9338998 + "no_grenade");
    if (var_301cff54.size > 1) {
        assertmsg("no_grenade" + var_e9338998 + "no_grenade");
    }
    var_301cff54[0] notify(#"hash_b6ecc65b");
    var_b0fde15b = var_301cff54[0] function_5d73924();
    var_b0fde15b triggerenable(0);
}

// Namespace cache
// Params 2, eflags: 0x0
// Checksum 0xc2c88761, Offset: 0x12b0
// Size: 0x2dc
function function_7189f668(var_c59a5f80, w_weapon) {
    if (var_c59a5f80 < 1 || var_c59a5f80 > 2) {
        assertmsg("no_grenade");
    }
    assert(isdefined(w_weapon), "no_grenade");
    if (var_c59a5f80 == 1) {
        var_10d1f7d8 = self gettagorigin("auxilary_A");
        assert(isdefined(var_10d1f7d8), "no_grenade");
        var_d31f6c52 = anglestoright(self gettagangles("auxilary_A")) * 5;
        var_c1e132ef = spawn("weapon_" + w_weapon.name + level.game_mode_suffix, var_10d1f7d8 + var_d31f6c52 + (0, 0, 10), 8);
        var_c1e132ef.angles = self gettagangles("auxilary_A") + (0, -90, 0);
        var_c1e132ef itemweaponsetammo(9999, 9999);
    }
    if (var_c59a5f80 == 2) {
        var_10d1f7d8 = self gettagorigin("secondary_A");
        assert(isdefined(var_10d1f7d8), "no_grenade");
        var_d31f6c52 = anglestoforward(self gettagangles("secondary_A")) * 7;
        var_c1e132ef = spawn("weapon_" + w_weapon.name + level.game_mode_suffix, var_10d1f7d8 + var_d31f6c52 + (0, 0, 10), 8);
        var_c1e132ef.angles = self gettagangles("secondary_A");
        var_c1e132ef itemweaponsetammo(9999, 9999);
    }
}

// Namespace cache
// Params 0, eflags: 0x0
// Checksum 0x4fb6a4fd, Offset: 0x1598
// Size: 0x234
function cleanup_cache() {
    if (issubstr(self.model, "p6_weapon_")) {
        var_4f64ee67 = [];
        var_f0d803 = getitemarray();
        foreach (item in var_f0d803) {
            if (issubstr(item.classname, "weapon_")) {
                var_4f64ee67[var_4f64ee67.size] = item;
            }
        }
        var_ee5ad949 = 2;
        if (isdefined(self.var_175017a9)) {
            var_ee5ad949++;
        }
        if (isdefined(self.var_3d529212)) {
            var_ee5ad949++;
        }
        for (x = 0; x < var_ee5ad949; x++) {
            var_62eb07c9 = arraygetclosest(self.origin, var_4f64ee67, 50);
            if (isdefined(var_62eb07c9)) {
                var_62eb07c9 delete();
            }
        }
        self delete();
        return;
    }
    self notify(#"hash_b6ecc65b");
    var_578a4cdd = function_5d73924();
    if (isdefined(var_578a4cdd)) {
        var_578a4cdd delete();
    }
    self delete();
}

