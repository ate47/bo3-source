#using scripts/shared/trigger_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/_util;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/codescripts/struct;

#namespace lotus_util;

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0xf4229920, Offset: 0xbf0
// Size: 0xcc
function function_3b6587d6(b_on, str_name) {
    var_cecf22e2 = getent(str_name + "_switch", "targetname");
    if (b_on) {
        var_cecf22e2 show();
        var_cecf22e2 solid();
    } else {
        var_cecf22e2 ghost();
        var_cecf22e2 notsolid();
    }
    umbragate_set(str_name, !b_on);
}

// Namespace lotus_util
// Params 6, eflags: 0x1 linked
// Checksum 0xb8a3b3ff, Offset: 0xcc8
// Size: 0x918
function function_b26ca094(var_959da48b, var_59dc7746, var_f70ba7ec, var_e4075f18, var_b77c8968, var_1e2eebb8) {
    if (!isdefined(var_59dc7746)) {
        var_59dc7746 = 0;
    }
    if (!isdefined(var_f70ba7ec)) {
        var_f70ba7ec = 0;
    }
    if (!isdefined(var_e4075f18)) {
        var_e4075f18 = 0;
    }
    if (!isdefined(var_1e2eebb8)) {
        var_1e2eebb8 = 0;
    }
    var_aa7aca48 = getentarray(var_959da48b, "groupname");
    if (isarray(var_aa7aca48) && var_aa7aca48.size >= 3) {
        println("<dev string:x28>");
    }
    var_bcf73ab6 = [];
    a_models = [];
    a_weapons = [];
    foreach (var_6f05825 in var_aa7aca48) {
        if (var_6f05825.classname == "script_brushmodel") {
            if (var_6f05825.targetname === "mobile_destructible") {
                if (isdefined(var_6f05825.var_bcf73ab6) && var_6f05825.var_bcf73ab6.size > 0) {
                    var_6f05825.var_bcf73ab6 = array::remove_undefined(var_6f05825.var_bcf73ab6);
                }
                var_6f05825 thread function_cdf9cde7();
                if (!isdefined(var_bcf73ab6)) {
                    var_bcf73ab6 = [];
                } else if (!isarray(var_bcf73ab6)) {
                    var_bcf73ab6 = array(var_bcf73ab6);
                }
                var_bcf73ab6[var_bcf73ab6.size] = var_6f05825;
            } else {
                if (isdefined(var_6f05825.var_75cccf1) && var_6f05825.var_75cccf1.size > 0) {
                    var_6f05825.var_75cccf1 = array::remove_undefined(var_6f05825.var_75cccf1);
                }
                var_f9a1ddd6 = var_6f05825;
            }
            continue;
        }
        if (var_6f05825.classname == "script_model") {
            if (var_6f05825.targetname === "mobile_weapon") {
                if (isdefined(var_6f05825.a_weapons) && var_6f05825.a_weapons.size > 0) {
                    var_6f05825.a_weapons = array::remove_undefined(var_6f05825.a_weapons);
                }
                var_6f05825 hide();
                if (!isdefined(a_weapons)) {
                    a_weapons = [];
                } else if (!isarray(a_weapons)) {
                    a_weapons = array(a_weapons);
                }
                a_weapons[a_weapons.size] = var_6f05825;
                continue;
            }
            if (isdefined(var_6f05825.a_models) && var_6f05825.a_models.size > 0 && var_6f05825.targetname != "minigun_auto") {
                var_6f05825.a_models = array::remove_undefined(var_6f05825.a_models);
            }
            if (!isdefined(a_models)) {
                a_models = [];
            } else if (!isarray(a_models)) {
                a_models = array(a_models);
            }
            a_models[a_models.size] = var_6f05825;
        }
    }
    arrayremovevalue(var_aa7aca48, var_f9a1ddd6);
    var_aa7aca48 = array::exclude(var_aa7aca48, var_bcf73ab6);
    var_aa7aca48 = array::exclude(var_aa7aca48, a_models);
    var_aa7aca48 = array::exclude(var_aa7aca48, a_weapons);
    var_f9a1ddd6.var_bcf73ab6 = var_bcf73ab6;
    var_f9a1ddd6.a_models = a_models;
    var_f9a1ddd6.a_weapons = a_weapons;
    var_d199cd64 = arraycombine(var_bcf73ab6, a_models, 0, 0);
    var_d199cd64 = arraycombine(var_d199cd64, a_weapons, 0, 0);
    foreach (var_f00752c0 in var_d199cd64) {
        var_f00752c0 linkto(var_f9a1ddd6);
    }
    if (isdefined(var_59dc7746) && var_59dc7746) {
        foreach (var_e28769a6 in var_aa7aca48) {
            if (isdefined(var_e4075f18) && var_e4075f18) {
                if (var_e28769a6.model != "wpn_t7_mingun_world") {
                    if (!isdefined(var_b77c8968)) {
                        var_83f53318 = util::spawn_model("wpn_t7_mingun_world", var_e28769a6.origin, var_e28769a6.angles);
                    } else {
                        var_83f53318 = util::spawn_model(var_b77c8968, var_e28769a6.origin, var_e28769a6.angles);
                    }
                } else {
                    var_83f53318 = var_e28769a6;
                }
            } else {
                var_83f53318 = spawner::simple_spawn_single(var_e28769a6);
                if (isdefined(var_f70ba7ec) && var_f70ba7ec) {
                    var_83f53318 vehicle_ai::turnoff();
                }
            }
            var_83f53318 linkto(var_f9a1ddd6);
            if (isdefined(var_1e2eebb8) && var_1e2eebb8) {
                var_83f53318 hide();
            } else {
                var_409f4c83 = var_83f53318 function_c7b0a169(var_e4075f18, var_1e2eebb8);
                var_409f4c83 linkto(var_f9a1ddd6);
            }
            if (!isdefined(var_f9a1ddd6.var_75cccf1)) {
                var_f9a1ddd6.var_75cccf1 = [];
            }
            if (!isdefined(var_f9a1ddd6.var_75cccf1)) {
                var_f9a1ddd6.var_75cccf1 = [];
            } else if (!isarray(var_f9a1ddd6.var_75cccf1)) {
                var_f9a1ddd6.var_75cccf1 = array(var_f9a1ddd6.var_75cccf1);
            }
            var_f9a1ddd6.var_75cccf1[var_f9a1ddd6.var_75cccf1.size] = var_83f53318;
        }
    }
    return var_f9a1ddd6;
}

// Namespace lotus_util
// Params 1, eflags: 0x0
// Checksum 0xc097597, Offset: 0x15e8
// Size: 0x118
function function_bc5f7909(str_weapon) {
    self show();
    self oed::function_e228c18a(1);
    var_1c023cce = spawn("trigger_radius_use", self.origin);
    var_1c023cce triggerignoreteam();
    var_1c023cce sethintstring(%CP_MI_CAIRO_LOTUS_GRAB_SMAW);
    var_1c023cce setcursorhint("HINT_NOICON");
    var_1c023cce enablelinkto();
    var_1c023cce.targetname = "trig_weapon";
    self.var_1c023cce = var_1c023cce;
    self thread function_d2eba93d(var_1c023cce, str_weapon);
    return var_1c023cce;
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0xede645e8, Offset: 0x1708
// Size: 0x14a
function function_d2eba93d(var_1c023cce, str_weapon) {
    self endon(#"death");
    self thread function_951a5eb();
    player = var_1c023cce waittill(#"trigger");
    w_weapon = getweapon(str_weapon);
    n_ammo_total = w_weapon.clipsize + w_weapon.maxammo;
    n_ammo = player getammocount(w_weapon);
    if (player hasweapon(w_weapon) && n_ammo >= n_ammo_total) {
        self thread function_d2eba93d(var_1c023cce, str_weapon);
        return;
    }
    var_1c023cce delete();
    player thread function_73647b0a(str_weapon);
    self notify(#"hash_951a5eb");
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x82e5b4c7, Offset: 0x1860
// Size: 0x5c
function function_951a5eb() {
    self endon(#"death");
    self waittill(#"hash_951a5eb");
    self hide();
    if (isdefined(self.var_1c023cce)) {
        self.var_1c023cce delete();
    }
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0xa626748a, Offset: 0x18c8
// Size: 0xec
function function_73647b0a(str_weapon) {
    self endon(#"death");
    w_weapon = getweapon(str_weapon);
    if (self hasweapon(w_weapon)) {
        self givemaxammo(w_weapon);
        self setweaponammoclip(w_weapon, w_weapon.clipsize);
        return;
    }
    self giveweapon(w_weapon);
    self switchtoweapon(w_weapon);
    self notify(#"weapon_given");
    self thread function_d3cb8a55();
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0xbe64e6a5, Offset: 0x19c0
// Size: 0x202
function function_d3cb8a55() {
    self notify(#"hash_b729e030");
    self endon(#"hash_b729e030");
    self endon(#"death");
    var_67aa166f = 0;
    var_90911853 = getweapon("launcher_standard");
    w_minigun = getweapon("minigun_lotus");
    self.var_271f03e = 0;
    while (self hasweapon(var_90911853, 1)) {
        self waittill(#"weapon_fired");
        if (!level flag::get("gunship_high_out_of_battle")) {
            if (self getcurrentweapon() == var_90911853 && self getammocount(var_90911853) > 0) {
                self.var_271f03e = 0;
            }
            if (self getcurrentweapon() != var_90911853 && self getcurrentweapon() != w_minigun && self getammocount(var_90911853) > 0) {
                self.var_271f03e += 1;
            }
            if (self.var_271f03e >= 10) {
                self util::show_hint_text(%COOP_EQUIP_XM53, 0);
                var_67aa166f += 1;
                self.var_271f03e = 0;
                wait 10;
                if (var_67aa166f >= 3) {
                    return;
                }
            }
        }
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0xb928555e, Offset: 0x1bd0
// Size: 0x210
function function_6fc3995f() {
    a_str_types = array("casino", "medical", "merchant", "restaurant", "tattoo");
    foreach (str_type in a_str_types) {
        switch (str_type) {
        case "casino":
            var_2e3ccdfd = 5;
            break;
        case "medical":
            var_2e3ccdfd = 1;
            break;
        case "merchant":
            var_2e3ccdfd = 2;
            break;
        case "restaurant":
            var_2e3ccdfd = 4;
            break;
        case "tattoo":
            var_2e3ccdfd = 3;
            break;
        }
        var_989cfb0 = getentarray(str_type + "_shop", "script_noteworthy");
        foreach (var_6ff04f8d in var_989cfb0) {
            var_6ff04f8d clientfield::set("mobile_shop_fxanims", var_2e3ccdfd);
            util::wait_network_frame();
        }
    }
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0x5bdafaef, Offset: 0x1de8
// Size: 0x1fe
function function_c7b0a169(var_e4075f18, var_1e2eebb8) {
    if (isdefined(var_1e2eebb8) && var_1e2eebb8) {
        self show();
    }
    self oed::function_e228c18a(1);
    var_409f4c83 = spawn("trigger_radius_use", self.origin);
    var_409f4c83 triggerignoreteam();
    var_409f4c83 sethintstring(%CP_MI_CAIRO_LOTUS_GRAB_MINIGUN);
    var_409f4c83 setcursorhint("HINT_NOICON");
    var_409f4c83 enablelinkto();
    var_409f4c83.targetname = "trig_minigun";
    self.var_409f4c83 = var_409f4c83;
    self thread function_e0fd159d(var_409f4c83, var_e4075f18, var_1e2eebb8);
    w_minigun = getweapon("minigun_lotus");
    foreach (player in level.players) {
        if (player hasweapon(w_minigun)) {
            var_409f4c83 setinvisibletoplayer(player);
        }
    }
    return var_409f4c83;
}

// Namespace lotus_util
// Params 3, eflags: 0x1 linked
// Checksum 0x75c8b25e, Offset: 0x1ff0
// Size: 0x1c6
function function_e0fd159d(var_409f4c83, var_e4075f18, var_1e2eebb8) {
    self endon(#"death");
    self thread function_28a4f84e(var_e4075f18, var_1e2eebb8);
    player = var_409f4c83 waittill(#"trigger");
    w_minigun = getweapon("minigun_lotus");
    if (player hasweapon(w_minigun)) {
        self thread function_e0fd159d(var_409f4c83, var_e4075f18, var_1e2eebb8);
        return;
    }
    var_409f4c83 delete();
    player thread function_25899d6a();
    self notify(#"hash_f779ed1b");
    level notify(#"hash_3987ce06");
    var_d4caa2c2 = getentarray("trig_minigun", "targetname");
    foreach (var_8811f25f in var_d4caa2c2) {
        var_8811f25f setinvisibletoplayer(player);
    }
    self notify(#"hash_28a4f84e");
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0x2a41c140, Offset: 0x21c0
// Size: 0xc4
function function_28a4f84e(var_e4075f18, var_1e2eebb8) {
    self endon(#"death");
    self waittill(#"hash_28a4f84e");
    if (isdefined(var_e4075f18) && var_e4075f18) {
        if (isdefined(var_1e2eebb8) && var_1e2eebb8) {
            self hide();
        } else {
            self delete();
        }
        return;
    }
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0xbe69bb38, Offset: 0x2290
// Size: 0x8c
function function_25899d6a(var_cb36173a) {
    self endon(#"death");
    w_minigun = getweapon("minigun_lotus");
    self giveweapon(w_minigun);
    self switchtoweapon(w_minigun);
    self notify(#"hash_2dcf6940");
    self thread function_a6145523();
}

// Namespace lotus_util
// Params 1, eflags: 0x0
// Checksum 0x8e8dad8c, Offset: 0x2328
// Size: 0x98
function function_a5f8943a(w_weapon) {
    self endon(#"death");
    self endon(#"drop_minigun");
    n_ammo = self getammocount(w_weapon);
    while (n_ammo > 0) {
        self.var_cb36173a = n_ammo;
        n_ammo = self getammocount(w_weapon);
        wait 0.05;
    }
    self.var_cb36173a = n_ammo;
}

// Namespace lotus_util
// Params 0, eflags: 0x0
// Checksum 0x16c67fd0, Offset: 0x23c8
// Size: 0x42
function function_f45c9a02() {
    self endon(#"death");
    self endon(#"drop_minigun");
    self waittill(#"weapon_change");
    self waittill(#"weapon_change");
    self notify(#"drop_minigun");
}

// Namespace lotus_util
// Params 1, eflags: 0x0
// Checksum 0x4b60bb6c, Offset: 0x2418
// Size: 0x184
function minigun_drop(var_cb36173a) {
    self endon(#"death");
    w_weapon = getweapon("minigun_lotus");
    self takeweapon(w_weapon);
    self notify(#"hash_35d77d15");
    var_5cf8dff2 = util::spawn_model("wpn_t7_mingun_world", self.origin + (0, 0, 12), self.angles);
    var_5cf8dff2 physicslaunch(var_5cf8dff2.origin, (0, 0, 0));
    var_5cf8dff2.var_cb36173a = self.var_cb36173a;
    self.var_cb36173a = undefined;
    var_8811f25f = spawn("trigger_radius_use", var_5cf8dff2.origin);
    var_8811f25f triggerignoreteam();
    var_8811f25f setcursorhint("HINT_NOICON");
    var_8811f25f enablelinkto();
    var_8811f25f linkto(var_5cf8dff2);
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0xedfec0a8, Offset: 0x25a8
// Size: 0x202
function function_a6145523() {
    self notify(#"hash_763a826a");
    self endon(#"hash_763a826a");
    self endon(#"death");
    var_1b2c2712 = 0;
    w_minigun = getweapon("minigun_lotus");
    var_90911853 = getweapon("launcher_standard");
    self.var_3bb3fc6d = 0;
    while (self hasweapon(w_minigun, 1)) {
        self waittill(#"weapon_fired");
        if (!level flag::get("gunship_high_out_of_battle")) {
            if (self getcurrentweapon() == w_minigun && self getammocount(w_minigun) > 0) {
                self.var_3bb3fc6d = 0;
            }
            if (self getcurrentweapon() != w_minigun && self getcurrentweapon() != var_90911853 && self getammocount(w_minigun) > 0) {
                self.var_3bb3fc6d += 1;
            }
            if (self.var_3bb3fc6d >= 10) {
                self util::show_hint_text(%CP_MI_CAIRO_LOTUS_MINIGUN_REMINDER, 0);
                var_1b2c2712 += 1;
                self.var_3bb3fc6d = 0;
                wait 10;
                if (var_1b2c2712 >= 3) {
                    return;
                }
            }
        }
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x0
// Checksum 0x5e4d93c7, Offset: 0x27b8
// Size: 0x8a
function function_5408b0dd() {
    foreach (player in level.players) {
        player thread function_ac865287();
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0xd31cb236, Offset: 0x2850
// Size: 0xd2
function function_ac865287() {
    self notify(#"hash_68eb28e6");
    self endon(#"hash_68eb28e6");
    self endon(#"death");
    w_current = self getcurrentweapon();
    var_b17e7b20 = getweapon("shotgun_pump_taser");
    while (self hasweapon(var_b17e7b20, 1)) {
        if (w_current == var_b17e7b20) {
            wait 20;
            continue;
        }
        wait 2;
        self util::show_hint_text(%CP_MI_CAIRO_LOTUS_SHOTGUN_REMINDER, 0);
        return;
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x0
// Checksum 0xefa346a5, Offset: 0x2930
// Size: 0xf2
function function_285a93c9() {
    a_triggers = getentarray("trig_juiced_shotgun", "targetname");
    foreach (var_e16f479 in a_triggers) {
        var_e16f479 triggerenable(1);
        var_e16f479 sethintstring(%CP_MI_CAIRO_LOTUS_GRAB_SHOTGUN);
        var_e16f479 thread function_5f5b1e5f();
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x2bbbf821, Offset: 0x2a30
// Size: 0xa8
function function_5f5b1e5f() {
    self endon(#"death");
    var_b17e7b20 = getweapon("shotgun_pump_taser");
    while (true) {
        e_player = self waittill(#"trigger");
        if (!e_player hasweapon(var_b17e7b20)) {
            e_player giveweapon(var_b17e7b20);
        }
        e_player switchtoweapon(var_b17e7b20);
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x0
// Checksum 0x8c47cdc8, Offset: 0x2ae0
// Size: 0x22c
function function_69533bc9() {
    spawner::add_spawn_function_group("robot_level_1", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "level_1");
    spawner::add_spawn_function_group("robot_level_2", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "level_2");
    spawner::add_spawn_function_group("robot_level_3", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "level_3");
    spawner::add_spawn_function_group("robot_forced_level_1", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "forced_level_1");
    spawner::add_spawn_function_group("robot_forced_level_2", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "forced_level_2");
    spawner::add_spawn_function_group("robot_forced_level_3", "script_noteworthy", &ai::set_behavior_attribute, "rogue_control", "forced_level_3");
    spawner::add_spawn_function_group("climber_robot_forced_level_1", "script_noteworthy", &function_b4c5517f, "forced_level_1");
    spawner::add_spawn_function_group("climber_robot_forced_level_2", "script_noteworthy", &function_b4c5517f, "forced_level_2");
    spawner::add_spawn_function_group("climber_robot_forced_level_3", "script_noteworthy", &function_b4c5517f, "forced_level_3");
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0x5a8b3829, Offset: 0x2d18
// Size: 0x3c
function function_b4c5517f(var_66674d1) {
    self waittill(#"scriptedanim");
    self ai::set_behavior_attribute("rogue_control", var_66674d1);
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0x346e90a3, Offset: 0x2d60
// Size: 0x228
function function_cdf9cde7(var_e6795c86) {
    if (!isdefined(var_e6795c86)) {
        var_e6795c86 = undefined;
    }
    self endon(#"death");
    self setcandamage(1);
    self.health = 10000;
    if (isdefined(self.script_fxid)) {
        if (isdefined(self.script_noteworthy)) {
            var_a178d2fe = function_8108bdb8(self.script_fxid, self.script_noteworthy, self);
            if (isdefined(var_a178d2fe)) {
                var_a178d2fe hide();
            }
        }
        if (isdefined(self.script_label)) {
            var_3e1ea936 = function_8108bdb8(self.script_fxid, self.script_label, self);
            if (isdefined(var_3e1ea936)) {
                var_3e1ea936 hide();
            }
        }
    }
    b_destroyed = 0;
    while (!b_destroyed) {
        n_damage, e_attacker, var_a3382de1, v_point, str_means_of_death, var_c4fe462, var_e64d69f9, var_c04aef90, w_weapon = self waittill(#"damage");
        if (str_means_of_death == "MOD_PROJECTILE" || e_attacker.vehicletype === "veh_bo3_mil_gunship_nrc" && str_means_of_death == "MOD_PROJECTILE_SPLASH") {
            self function_aabc561a(var_e6795c86);
            b_destroyed = 1;
        }
        self.health = 10000;
        wait 0.05;
    }
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0xb07cd304, Offset: 0x2f90
// Size: 0x2fc
function function_aabc561a(var_e6795c86) {
    if (!isdefined(var_e6795c86)) {
        var_e6795c86 = undefined;
    }
    if (self.script_ignoreme === 0) {
        self notsolid();
        self hide();
        if (isdefined(self.script_fxid)) {
            var_6bcf377a = self.script_fxid + "_" + self.targetname;
            s_fx = struct::get(var_6bcf377a, "targetname");
            if (isdefined(s_fx)) {
                s_fx thread scene::play();
                if (isdefined(var_e6795c86)) {
                    s_fx thread fx::play(var_e6795c86);
                }
            }
            if (isdefined(self.script_parameters)) {
                var_54a0ec88 = function_8108bdb8(self.script_fxid, self.script_parameters, self);
                if (isdefined(var_54a0ec88)) {
                    var_54a0ec88 notsolid();
                    var_54a0ec88 hide();
                    var_54a0ec88 delete();
                }
            }
            if (isdefined(self.target)) {
                var_dc0bfd76 = function_8108bdb8(self.script_fxid, self.target, self);
                if (isdefined(var_dc0bfd76)) {
                    var_dc0bfd76 function_8effc214();
                }
            }
        }
        if (isdefined(self.script_noteworthy)) {
            var_a178d2fe = function_8108bdb8(self.script_fxid, self.script_noteworthy, self);
            if (isdefined(var_a178d2fe)) {
                var_a178d2fe show();
            }
        }
        if (isdefined(self.script_label)) {
            var_3e1ea936 = function_8108bdb8(self.script_fxid, self.script_label, self);
            if (isdefined(var_3e1ea936)) {
                var_3e1ea936 notsolid();
                var_3e1ea936 hide();
            }
        }
        if (isdefined(self.script_ignoreme)) {
            self.script_ignoreme = 1;
        }
        self delete();
    }
}

// Namespace lotus_util
// Params 3, eflags: 0x1 linked
// Checksum 0xd61c9aa6, Offset: 0x3298
// Size: 0xfc
function function_8108bdb8(var_700327f8, str_targetname, refobj) {
    if (!isdefined(refobj)) {
        refobj = undefined;
    }
    var_442c186f = undefined;
    a_mdls = getentarray(str_targetname, "targetname");
    foreach (var_f582979c in a_mdls) {
        if (var_f582979c.script_fxid === var_700327f8) {
            var_442c186f = var_f582979c;
        }
    }
    return var_442c186f;
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0x146ea37f, Offset: 0x33a0
// Size: 0xec
function function_8effc214(var_449c8315, var_217954db) {
    if (!isdefined(var_449c8315)) {
        var_449c8315 = 0;
    }
    if (!isdefined(var_217954db)) {
        var_217954db = 0;
    }
    if (isdefined(self.script_ignoreme) && self.script_ignoreme == 0 && isdefined(self.script_label) && isdefined(self.script_fxid)) {
        var_a788dff4 = function_8108bdb8(self.script_fxid, self.script_label, self);
        var_a788dff4 show();
        if (var_217954db) {
            var_a788dff4 thread function_cdf9cde7();
        }
        if (var_449c8315) {
            self hide();
        }
    }
}

// Namespace lotus_util
// Params 1, eflags: 0x0
// Checksum 0xccb3af5d, Offset: 0x3498
// Size: 0x26c
function function_f95b0d3c(var_2e2d440f) {
    if (var_2e2d440f) {
        type = "robot";
    } else {
        type = "human";
    }
    playfxontag(level._effect["burn_loop_" + type + "_left_arm"], self, "j_shoulder_le_rot");
    playfxontag(level._effect["burn_loop_" + type + "_left_arm"], self, "j_elbow_le_rot");
    playfxontag(level._effect["burn_loop_" + type + "_right_arm"], self, "j_shoulder_ri_rot");
    playfxontag(level._effect["burn_loop_" + type + "_right_arm"], self, "j_elbow_ri_rot");
    playfxontag(level._effect["burn_loop_" + type + "_left_leg"], self, "j_hip_le");
    playfxontag(level._effect["burn_loop_" + type + "_left_leg"], self, "j_knee_le");
    playfxontag(level._effect["burn_loop_" + type + "_right_leg"], self, "j_hip_ri");
    playfxontag(level._effect["burn_loop_" + type + "_right_leg"], self, "j_knee_ri");
    playfxontag(level._effect["burn_loop_" + type + "_head"], self, "j_head");
    playfxontag(level._effect["burn_loop_" + type + "_torso"], self, "j_mainroot");
}

// Namespace lotus_util
// Params 2, eflags: 0x0
// Checksum 0x6e481dff, Offset: 0x3710
// Size: 0x44
function function_2838f054(var_dd528041, var_bb4455a6) {
    function_c9fa49c2(var_dd528041, var_bb4455a6);
    objectives::breadcrumb(var_bb4455a6);
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0x719fb6ba, Offset: 0x3760
// Size: 0x70
function function_c9fa49c2(var_dd528041, str_trigger_name) {
    var_bfa7ba25 = getent(str_trigger_name, "targetname");
    if (isdefined(var_bfa7ba25)) {
        objectives::set(var_dd528041, var_bfa7ba25.origin);
    }
}

// Namespace lotus_util
// Params 3, eflags: 0x0
// Checksum 0xe1f8661a, Offset: 0x37d8
// Size: 0x80
function function_50ae49cd(var_46c42db4, b_debug, var_fc275254) {
    if (!isdefined(b_debug)) {
        b_debug = 1;
    }
    for (var_17688fb5 = var_46c42db4; isdefined(var_17688fb5); var_17688fb5 = function_20fc45fd(var_17688fb5, b_debug)) {
    }
    if (isdefined(var_fc275254)) {
        level notify(var_fc275254);
    }
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0x1ee29aea, Offset: 0x3860
// Size: 0x160
function function_20fc45fd(var_17688fb5, b_debug) {
    var_fe6eb061 = getent(var_17688fb5, "targetname");
    if (isdefined(var_fe6eb061)) {
        v_position = var_fe6eb061.origin;
        if (isdefined(var_fe6eb061.target)) {
            s_current = struct::get(var_fe6eb061.target, "targetname");
            if (isdefined(s_current)) {
                v_position = s_current.origin;
            }
        }
        objectives::set("cp_waypoint_breadcrumb", v_position);
        trigger::wait_till(var_17688fb5);
        objectives::complete("cp_waypoint_breadcrumb");
        var_c15deb89 = var_fe6eb061.target;
    }
    /#
        if (isdefined(var_c15deb89) && b_debug) {
            iprintlnbold(var_c15deb89);
        }
    #/
    return var_c15deb89;
}

// Namespace lotus_util
// Params 1, eflags: 0x0
// Checksum 0x7f5a8bc, Offset: 0x39c8
// Size: 0x12c
function function_393c81a5(a_ents) {
    self endon(#"scene_done");
    array::thread_all(a_ents, &function_5a92c897, self);
    array::thread_all(a_ents, &function_27e365e2, "killed_by_nrc", "axis");
    array::wait_any(a_ents, "damage");
    util::wait_network_frame();
    foreach (ent in a_ents) {
        ent notify(#"hash_9ac59272");
    }
    self scene::stop();
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0xca5680b9, Offset: 0x3b00
// Size: 0x134
function function_f2596cbe(a_ents) {
    self endon(#"scene_done");
    array::thread_all(a_ents, &function_5a92c897, self);
    array::wait_any(a_ents, "death");
    util::wait_network_frame();
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreall(0);
            ent ai::set_ignoreme(0);
        }
    }
    self scene::stop();
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0x557b6295, Offset: 0x3c40
// Size: 0x10c
function function_5a92c897(var_d6f141bd) {
    self endon(#"death");
    if (!isai(self)) {
        return;
    }
    if (self.team === "allies") {
        self thread function_6c396cfa(1);
    } else {
        self thread function_6c396cfa(1);
        self thread ai::set_behavior_attribute("can_be_meleed", 0);
    }
    var_d6f141bd waittill(#"scene_done");
    if (self.team === "allies") {
        self thread function_6c396cfa(0);
        return;
    }
    self thread function_6c396cfa(0);
    self thread ai::set_behavior_attribute("can_be_meleed", 1);
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0x69bcba8e, Offset: 0x3d58
// Size: 0x34
function function_6c396cfa(var_c5d9e0f5) {
    if (isai(self)) {
        self.ignoreme = var_c5d9e0f5;
    }
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0x7f84f75a, Offset: 0x3d98
// Size: 0x1f2
function function_5da90c71(a_ents) {
    foreach (ent in a_ents) {
        if (isai(ent)) {
            ent ai::set_ignoreme(1);
            ent ai::set_ignoreall(1);
            ent util::magic_bullet_shield();
        }
    }
    while (scene::is_active(self.scriptbundlename)) {
        wait 0.05;
    }
    foreach (ent in a_ents) {
        if (isdefined(ent) && isai(ent) && isalive(ent)) {
            ent ai::set_ignoreme(0);
            ent ai::set_ignoreall(0);
            ent util::stop_magic_bullet_shield();
        }
    }
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0xb88ad210, Offset: 0x3f98
// Size: 0x1cc
function function_36a6e271(var_a9fa335a, a_ai) {
    if (!isdefined(a_ai)) {
        a_ai = [];
    }
    while (true) {
        var_790129b = 0;
        var_6c4dd462 = 0;
        foreach (player in level.players) {
            if (player istouching(self)) {
                var_790129b++;
            }
        }
        foreach (ai in a_ai) {
            if (ai istouching(self)) {
                var_6c4dd462++;
            }
        }
        if (var_790129b == level.players.size && var_6c4dd462 == a_ai.size) {
            if (isdefined(var_a9fa335a) && var_a9fa335a) {
                self util::self_delete();
            }
            break;
        }
        wait 0.1;
    }
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0xe01fdc47, Offset: 0x4170
// Size: 0x194
function function_d720c23e(str_name) {
    level flag::wait_till("all_players_spawned");
    e_trigger = getent("ambient_mobile_" + str_name + "_trigger", "script_noteworthy");
    if (!isdefined(e_trigger)) {
        e_trigger = getent("ambient_mobile_" + str_name + "_0_trigger", "script_noteworthy");
    }
    if (isdefined(e_trigger)) {
        var_2e308a20 = getentarray(e_trigger.target, "targetname");
        foreach (e_piece in var_2e308a20) {
            e_piece.groupname = str_name;
        }
        function_b26ca094(str_name);
        e_trigger trigger::use();
    }
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0xa0bf8d02, Offset: 0x4310
// Size: 0x12c
function function_14be4cad(var_1d3f7e09) {
    if (!isdefined(var_1d3f7e09)) {
        var_1d3f7e09 = 0;
    }
    level thread function_d720c23e("bb_n_mshop_a");
    level thread function_d720c23e("bb_s_mshop_a");
    level thread function_d720c23e("bb_s_mshop_b");
    level thread function_d720c23e("bb_s_mshop_c");
    level thread function_d720c23e("center_mshop");
    wait 7;
    function_fe64b86b("rainman", struct::get("bridge_battle_corpse_drop"), 0);
    wait 25;
    function_fe64b86b("rainman", struct::get("bridge_battle_corpse_drop2"), 0);
}

// Namespace lotus_util
// Params 0, eflags: 0x0
// Checksum 0x8cf2597, Offset: 0x4448
// Size: 0x13a
function function_ba1b651d() {
    var_633462a1 = "bridge_battle_mobile_shop";
    var_5bed9cb6 = "mshop_n_entrance_a_01";
    var_bef0b623 = function_c7bebe99(var_633462a1, var_5bed9cb6, 15, undefined, 10, 0, 0);
    var_27d8849a = [[ var_bef0b623 ]]->function_9bc3d62a();
    var_a175a10b = util::spawn_model("tag_origin", var_27d8849a.origin, var_27d8849a.angles);
    while (true) {
        /#
            iprintlnbold("<dev string:x61>");
        #/
        level function_de4512ae(var_bef0b623, "mshop_n_entrance_a_01");
        trigger::use(var_633462a1, "target");
        level waittill("vehicle_platform_" + var_633462a1 + "_stop");
    }
}

// Namespace lotus_util
// Params 7, eflags: 0x1 linked
// Checksum 0xf0ae3511, Offset: 0x4590
// Size: 0xc8
function function_c7bebe99(var_633462a1, var_9a2454dd, var_5a861da0, str_waittill, n_wait_amount, var_b14a36c3, var_149d7b19) {
    if (!isdefined(var_b14a36c3)) {
        var_b14a36c3 = 0;
    }
    if (!isdefined(var_149d7b19)) {
        var_149d7b19 = 0;
    }
    var_bef0b623 = new class_fa0d90fd();
    [[ var_bef0b623 ]]->init(var_633462a1, var_9a2454dd);
    var_27d8849a = [[ var_bef0b623 ]]->function_9bc3d62a();
    var_27d8849a.takedamage = 0;
    return var_bef0b623;
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0x5727e6a6, Offset: 0x4660
// Size: 0x58
function function_de4512ae(var_ca404144, var_5bed9cb6) {
    var_23abba9c = [[ var_ca404144 ]]->function_9bc3d62a();
    var_23abba9c clearvehgoalpos();
    [[ var_ca404144 ]]->function_845aae7f(var_5bed9cb6);
}

// Namespace lotus_util
// Params 4, eflags: 0x1 linked
// Checksum 0x1453749f, Offset: 0x46c0
// Size: 0x1ac
function function_99514074(var_3c3195e7, str_spawner, var_2a151a84, n_delay) {
    if (!isdefined(var_2a151a84)) {
        var_2a151a84 = undefined;
    }
    if (!isdefined(n_delay)) {
        n_delay = undefined;
    }
    var_253fcf81 = struct::get(var_3c3195e7, "targetname");
    var_d3c173bf = getent(str_spawner, "targetname");
    assert(isdefined(var_253fcf81) && isdefined(var_d3c173bf), "<dev string:x86>");
    if (!isactor(var_d3c173bf)) {
        var_4c5a6632 = spawner::simple_spawn_single(str_spawner);
    } else {
        var_4c5a6632 = var_d3c173bf;
    }
    if (isdefined(n_delay) || isdefined(var_2a151a84)) {
        var_253fcf81 scene::init(var_4c5a6632);
        if (isdefined(var_2a151a84)) {
            level flag::wait_till(var_2a151a84);
        }
        if (isdefined(n_delay) && n_delay > 0) {
            wait n_delay;
        }
    }
    if (isalive(var_4c5a6632)) {
        var_253fcf81 scene::play(var_4c5a6632);
    }
}

// Namespace lotus_util
// Params 4, eflags: 0x0
// Checksum 0x6bd99514, Offset: 0x4878
// Size: 0x30c
function function_c7cc24f8(var_3c3195e7, var_18dfedfa, var_8556dacc, n_delay) {
    if (!isdefined(var_8556dacc)) {
        var_8556dacc = undefined;
    }
    if (!isdefined(n_delay)) {
        n_delay = undefined;
    }
    var_253fcf81 = struct::get(var_3c3195e7, "targetname");
    var_33edae4e = 1;
    var_629f93f0 = [];
    var_8060ff07 = [];
    for (i = 0; i < var_18dfedfa.size; i++) {
        var_629f93f0[i] = getent(var_18dfedfa[i], "targetname");
        if (!isdefined(var_629f93f0[i])) {
            var_33edae4e = 0;
            continue;
        }
        var_8060ff07[i] = spawner::simple_spawn_single(var_18dfedfa[i]);
    }
    if (isdefined(var_253fcf81) && var_33edae4e) {
        var_2c4dc501 = var_253fcf81.scriptbundlename;
        var_253fcf81 thread function_e3b58585(var_8060ff07);
        if (isdefined(n_delay) || isdefined(var_8556dacc)) {
            var_253fcf81 scene::init(var_8060ff07);
            if (isdefined(var_8556dacc) && flag::exists(var_8556dacc)) {
                level flag::wait_till(var_8556dacc);
            } else if (!flag::exists(var_8556dacc)) {
                /#
                    iprintlnbold("<dev string:xb0>");
                #/
            }
            if (isdefined(n_delay)) {
                wait n_delay;
            }
        }
        var_7d90afcb = 1;
        foreach (var_3a90b959 in var_8060ff07) {
            if (!isalive(var_3a90b959)) {
                var_7d90afcb = 0;
            }
        }
        if (var_7d90afcb) {
            var_253fcf81 scene::play(var_8060ff07);
        }
        return;
    }
    /#
        iprintlnbold("<dev string:xe5>");
    #/
}

// Namespace lotus_util
// Params 5, eflags: 0x0
// Checksum 0xb750d5c4, Offset: 0x4b90
// Size: 0x4a4
function function_c92cb5b(var_3c3195e7, var_b79165e6, var_fddd6a7f, str_key, var_2a151a84) {
    if (!isdefined(str_key)) {
        str_key = "script_noteworthy";
    }
    if (!isdefined(var_2a151a84)) {
        var_2a151a84 = undefined;
    }
    s_scene = struct::get(var_3c3195e7, "targetname");
    var_2c4dc501 = s_scene.scriptbundlename;
    /#
        var_c6befe75 = var_2c4dc501 + "<dev string:x10b>" + var_b79165e6 + "<dev string:x10f>" + var_fddd6a7f;
        iprintlnbold(var_c6befe75);
    #/
    v_death = s_scene.origin;
    a_enemies = getaiarray(var_fddd6a7f, str_key);
    var_3f3a4339 = arraygetclosest(v_death, a_enemies);
    if (isalive(var_3f3a4339)) {
        var_3f3a4339 ai::set_ignoreme(1);
        var_3f3a4339 setgoal(v_death, 1);
        var_3f3a4339.var_bb8d3f02 = 1;
        var_3f3a4339.goalradius = 48;
        var_3f3a4339 waittill(#"goal");
        if (isdefined(var_2a151a84)) {
            level flag::wait_till(var_2a151a84);
        }
        a_enemies = getaiarray(var_b79165e6, str_key);
        var_f6c5842 = arraygetclosest(v_death, a_enemies);
        if (isalive(var_f6c5842) && isalive(var_3f3a4339)) {
            var_f6c5842 ai::set_ignoreall(1);
            var_f6c5842 ai::set_ignoreme(1);
            var_3f3a4339 setignoreent(var_f6c5842, 1);
            var_f6c5842 setignoreent(var_3f3a4339, 1);
            var_f6c5842 ai::set_behavior_attribute("rogue_control_speed", "run");
            var_f6c5842.var_bb8d3f02 = 1;
            a_enemies = array(var_f6c5842, var_3f3a4339);
            s_scene thread scene::play(a_enemies);
            while (isalive(var_f6c5842) && isalive(var_3f3a4339) && s_scene scene::is_playing()) {
                wait 0.1;
            }
        }
    }
    if (s_scene scene::is_playing()) {
        s_scene scene::stop();
    }
    if (isalive(var_f6c5842)) {
        var_f6c5842.var_fd5a8f70 = 1;
        var_f6c5842 ai::set_ignoreall(0);
        var_f6c5842 ai::set_ignoreme(0);
        var_f6c5842 cleargoalvolume();
    }
    if (isalive(var_3f3a4339)) {
        var_3f3a4339 ai::set_ignoreall(0);
        var_3f3a4339 ai::set_ignoreme(0);
    }
}

// Namespace lotus_util
// Params 6, eflags: 0x0
// Checksum 0x138445f, Offset: 0x5040
// Size: 0x28c
function function_283fcbc5(var_3c3195e7, var_27f9c50e, var_2a151a84, n_delay, var_af5ecc04, str_endon) {
    if (!isdefined(var_2a151a84)) {
        var_2a151a84 = undefined;
    }
    if (!isdefined(n_delay)) {
        n_delay = undefined;
    }
    if (!isdefined(var_af5ecc04)) {
        var_af5ecc04 = 0;
    }
    if (!isdefined(str_endon)) {
        str_endon = undefined;
    }
    var_f6c5842 = spawner::simple_spawn_single(var_27f9c50e, &function_986d0100, "forced_level_2", 1);
    var_f7f2381b = struct::get(var_3c3195e7, "targetname");
    var_f6c5842 ai::set_ignoreall(1);
    var_f6c5842 ai::set_ignoreme(1);
    level.var_2fd26037 setignoreent(var_f6c5842, 1);
    if (!var_af5ecc04) {
        var_f6c5842 setgoal(var_f7f2381b.origin, 1);
        var_f6c5842 waittill(#"goal");
    } else {
        var_f6c5842 teleport(var_f7f2381b.origin);
    }
    var_8060ff07 = array(level.var_2fd26037, var_f6c5842);
    var_8060ff07 = array(level.var_2fd26037, var_f6c5842);
    var_f7f2381b thread function_e3b58585(var_8060ff07);
    if (isdefined(var_2a151a84) || isdefined(n_delay)) {
        var_f7f2381b scene::init(var_8060ff07);
        if (isdefined(var_2a151a84)) {
            flag::wait_till(var_2a151a84);
        }
        if (isdefined(n_delay) && n_delay > 0) {
            wait n_delay;
        }
    }
    var_f7f2381b scene::play(var_8060ff07);
}

// Namespace lotus_util
// Params 4, eflags: 0x0
// Checksum 0x6f1effb0, Offset: 0x52d8
// Size: 0x1cc
function function_90b3f11f(var_a31fd6f4, str_target, n_range, str_endon) {
    if (!isdefined(n_range)) {
        n_range = 300;
    }
    if (!isdefined(str_endon)) {
        str_endon = undefined;
    }
    ai_target = getent(str_target, "targetname");
    if (isdefined(ai_target)) {
        if (isspawner(ai_target)) {
            ai_target = spawner::simple_spawn_single(str_target, &function_986d0100);
        }
        if (isactor(ai_target)) {
            level.var_2fd26037 setignoreent(ai_target, 1);
            ai_target ai::force_goal(level.var_2fd26037);
            s_scene = struct::get(var_a31fd6f4, "targetname");
            level thread function_bc628f1d(s_scene, level.var_2fd26037, ai_target, n_range, str_endon);
        } else {
            /#
                iprintlnbold("<dev string:x115>" + ai_target.targetname + "<dev string:x147>");
            #/
        }
        return;
    }
    /#
        iprintlnbold("<dev string:x168>" + str_target + "<dev string:x190>");
    #/
}

// Namespace lotus_util
// Params 5, eflags: 0x1 linked
// Checksum 0xc631b06d, Offset: 0x54b0
// Size: 0x23c
function function_bc628f1d(s_scene, var_f7b00b2b, ai_target, n_range, str_endon) {
    if (!isdefined(n_range)) {
        n_range = 300;
    }
    if (!isdefined(str_endon)) {
        str_endon = undefined;
    }
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    while (isalive(var_f7b00b2b) && isalive(ai_target) && distance2d(ai_target.origin, var_f7b00b2b.origin) > n_range) {
        wait 0.1;
    }
    if (isalive(var_f7b00b2b) && isalive(ai_target)) {
        ai_target ai::force_goal(ai_target.origin, 100, 1);
        s_scene.origin = ai_target.origin;
        s_scene.angles = ai_target.angles;
        var_8060ff07 = array(var_f7b00b2b, ai_target);
        s_scene scene::init(s_scene.scriptbundlename, var_8060ff07);
        s_scene thread scene::play(var_8060ff07);
        while (isalive(var_f7b00b2b) && isalive(ai_target)) {
            wait 0.1;
        }
        if (s_scene scene::is_playing()) {
            s_scene scene::stop();
        }
    }
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0x7763cef9, Offset: 0x56f8
// Size: 0xc4
function function_986d0100(var_9bed3c76, b_sprint) {
    if (!isdefined(var_9bed3c76)) {
        var_9bed3c76 = "forced_level_2";
    }
    if (!isdefined(b_sprint)) {
        b_sprint = 0;
    }
    self endon(#"death");
    self.goalradius = 512;
    if (b_sprint) {
        self ai::set_behavior_attribute("rogue_control_speed", "sprint");
    }
    self ai::set_behavior_attribute("rogue_allow_pregib", 0);
    self ai::set_behavior_attribute("rogue_control", var_9bed3c76);
}

// Namespace lotus_util
// Params 5, eflags: 0x0
// Checksum 0x68550b8a, Offset: 0x57c8
// Size: 0x31c
function function_df89b05b(var_e5a5bdaf, var_177a81e1, str_flag, n_delay, str_endon) {
    if (!isdefined(var_177a81e1)) {
        var_177a81e1 = undefined;
    }
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    if (!isdefined(str_endon)) {
        str_endon = undefined;
    }
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    var_f6c5842 = spawner::simple_spawn_single(var_e5a5bdaf + "_robot", &function_986d0100, var_177a81e1);
    var_3f3a4339 = spawner::simple_spawn_single(var_e5a5bdaf + "_human");
    var_3f3a4339 ai::set_ignoreme(1);
    var_f6c5842 ai::set_ignoreme(1);
    var_8060ff07 = array(var_f6c5842, var_3f3a4339);
    s_scene = struct::get(var_e5a5bdaf, "targetname");
    s_scene thread function_c37d1015(var_f6c5842, var_3f3a4339);
    if (function_91986f4b(var_8060ff07)) {
        s_scene scene::init(var_8060ff07);
    } else {
        if (isalive(var_3f3a4339)) {
            var_3f3a4339 ai::set_ignoreme(0);
        }
        if (isalive(var_f6c5842)) {
            var_f6c5842 ai::set_ignoreme(0);
        }
        return;
    }
    if (isdefined(str_flag) && flag::exists(str_flag)) {
        level flag::wait_till(str_flag);
    }
    if (n_delay !== 0) {
        wait n_delay;
    }
    if (function_91986f4b(var_8060ff07)) {
        s_scene scene::play(var_8060ff07);
    }
    if (isalive(var_3f3a4339)) {
        /#
            iprintln("<dev string:x1a9>" + s_scene.targetname + "<dev string:x1b8>");
        #/
        var_3f3a4339 startragdoll();
        var_3f3a4339 kill();
    }
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0xdc7b7637, Offset: 0x5af0
// Size: 0xc2
function function_91986f4b(var_8060ff07) {
    var_7d90afcb = 1;
    foreach (var_3a90b959 in var_8060ff07) {
        if (!isdefined(var_3a90b959) || !isalive(var_3a90b959)) {
            var_7d90afcb = 0;
        }
    }
    return var_7d90afcb;
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0xfeb69461, Offset: 0x5bc0
// Size: 0x12c
function function_c37d1015(var_f6c5842, var_3f3a4339) {
    self endon(#"done");
    while (isalive(var_f6c5842) && isalive(var_3f3a4339)) {
        wait 0.05;
    }
    self scene::stop();
    if (isalive(var_3f3a4339)) {
        /#
            iprintlnbold("<dev string:x1d3>");
        #/
        var_3f3a4339 startragdoll();
        var_3f3a4339 kill();
    }
    if (isalive(var_f6c5842)) {
        /#
            iprintlnbold("<dev string:x1f1>");
        #/
        var_f6c5842 ai::set_ignoreme(0);
    }
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0xa2b0794b, Offset: 0x5cf8
// Size: 0x114
function function_e3b58585(var_8060ff07) {
    self endon(#"done");
    var_cde0e1c7 = 1;
    while (var_cde0e1c7) {
        foreach (var_3a90b959 in var_8060ff07) {
            if (!isalive(var_3a90b959)) {
                var_cde0e1c7 = 0;
            }
        }
        wait 0.1;
    }
    self scene::stop();
    /#
        iprintln("<dev string:x210>");
        iprintln("<dev string:x21c>");
    #/
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x1d87afbb, Offset: 0x5e18
// Size: 0x1c
function function_e58f5689() {
    exploder::exploder("fx_vista_read_int_haboob");
}

// Namespace lotus_util
// Params 0, eflags: 0x0
// Checksum 0xa30c1811, Offset: 0x5e40
// Size: 0x1c
function function_176c92fd() {
    exploder::exploder("fx_vista_read_haboob1");
}

// Namespace lotus_util
// Params 1, eflags: 0x0
// Checksum 0x7670fd, Offset: 0x5e68
// Size: 0x6c
function function_f80cafbd(b_show) {
    var_cb5f3fd1 = getent("skybridge_cloud_coverage", "targetname");
    if (b_show) {
        var_cb5f3fd1 show();
        return;
    }
    var_cb5f3fd1 hide();
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0xfcd5bd61, Offset: 0x5ee0
// Size: 0x21c
function function_c8849158(n_dist, n_delay) {
    self endon(#"death");
    var_2540d664 = 0;
    if (self flagsys::get("scriptedanim")) {
        self flagsys::wait_till_clear("scriptedanim");
    }
    if (isdefined(n_delay)) {
        wait n_delay;
    }
    while (var_2540d664 == 0) {
        wait 1;
        foreach (player in level.players) {
            if (isvehicle(self)) {
                var_911c6902 = self function_4246bc05(player);
            } else if (isactor(self)) {
                var_911c6902 = self cansee(player);
            } else {
                assertmsg("<dev string:x238>");
                return;
            }
            if (var_911c6902 == 0 && distance(self.origin, player.origin) > n_dist && player util::is_player_looking_at(self.origin, undefined, 0) == 0) {
                var_2540d664 = 1;
            }
        }
    }
    self delete();
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0x3882ad56, Offset: 0x6108
// Size: 0x5c
function function_27e365e2(str_notify, var_46368a9d) {
    if (self.team !== var_46368a9d) {
        self endon(#"death");
        self endon(#"hash_9ac59272");
        self waittill(str_notify);
        self function_3e9f1592();
    }
}

// Namespace lotus_util
// Params 1, eflags: 0x0
// Checksum 0x1579e3cb, Offset: 0x6170
// Size: 0xaa
function function_510331a4(a_ents) {
    foreach (ent in a_ents) {
        if (ent.team == "axis") {
            ent thread function_3e9f1592();
        }
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0xcc19c1e0, Offset: 0x6228
// Size: 0x8c
function function_3e9f1592() {
    self endon(#"death");
    while (isdefined(self.current_scene)) {
        wait 0.05;
    }
    if (isdefined(self)) {
        self util::stop_magic_bullet_shield();
        self notsolid();
        self startragdoll(1);
        self kill();
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x7480322e, Offset: 0x62c0
// Size: 0xcc
function function_5b57004a() {
    self endon(#"death");
    n_damage = 0;
    while (n_damage < 2 && self.health > 2) {
        n_damage, e_attacker = self waittill(#"damage");
    }
    wait 0.05;
    self util::stop_magic_bullet_shield();
    self notsolid();
    self startragdoll(1);
    self kill(self.origin, e_attacker);
}

// Namespace lotus_util
// Params 0, eflags: 0x0
// Checksum 0x68f0ff05, Offset: 0x6398
// Size: 0x64
function function_a7dc2319() {
    while (!isdefined(self.finished_scene)) {
        wait 0.05;
    }
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    self thread function_c8849158(500);
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0x475f9368, Offset: 0x6408
// Size: 0xda
function function_484bc3aa(b_enable) {
    level flag::wait_till("all_players_spawned");
    var_9dff5377 = b_enable ? 1 : 0;
    foreach (player in level.players) {
        player clientfield::set_to_player("player_dust_fx", var_9dff5377);
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x0
// Checksum 0x1e051251, Offset: 0x64f0
// Size: 0x11e
function corpse_cleanup() {
    var_b18bb272 = [];
    foreach (e_corpse in getcorpsearray()) {
        if (isdefined(e_corpse.birthtime) && e_corpse.birthtime + 200000 < gettime()) {
            var_b18bb272[var_b18bb272.size] = e_corpse;
        }
    }
    for (index = 0; index < var_b18bb272.size; index++) {
        var_b18bb272[index] delete();
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x299b01d8, Offset: 0x6618
// Size: 0x140
function function_fda257c3() {
    level notify(#"hash_1206d494");
    level endon(#"hash_1206d494");
    if (level.var_31aefea8 == "mobile_shop_ride2" || level.var_31aefea8 == "bridge_battle" || level.var_31aefea8 == "up_to_detention_center" || level.var_31aefea8 == "stand_down" || level.var_31aefea8 == "pursuit") {
        level thread function_a76d24ab();
    }
    while (true) {
        var_56db412d = struct::get_array("corpse_drop");
        s_drop = var_56db412d[randomint(var_56db412d.size)];
        function_fe64b86b("rainman", s_drop);
        wait randomfloatrange(8, 17);
    }
}

// Namespace lotus_util
// Params 3, eflags: 0x1 linked
// Checksum 0xee6408bb, Offset: 0x6760
// Size: 0x12c
function function_fe64b86b(str_targetname, s_struct, b_randomize) {
    if (!isdefined(b_randomize)) {
        b_randomize = 1;
    }
    ai_corpse = spawner::simple_spawn_single(str_targetname);
    if (!isdefined(ai_corpse)) {
        return;
    }
    if (b_randomize) {
        ai_corpse forceteleport(s_struct.origin + (randomintrange(-200, -56), randomintrange(-200, -56), 0), s_struct.angles);
    } else {
        ai_corpse forceteleport(s_struct.origin, s_struct.angles);
    }
    ai_corpse startragdoll();
    ai_corpse kill();
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x3ef77867, Offset: 0x6898
// Size: 0x128
function function_a76d24ab() {
    level endon(#"hash_1206d494");
    while (true) {
        a_corpses = getcorpsearray();
        n_current_time = gettime();
        foreach (e_corpse in a_corpses) {
            if (e_corpse.origin[2] > 18500) {
                if (n_current_time - e_corpse.birthtime > 5500) {
                    e_corpse delete();
                }
            }
        }
        wait 0.5;
    }
}

// Namespace lotus_util
// Params 3, eflags: 0x1 linked
// Checksum 0x9938f1aa, Offset: 0x69c8
// Size: 0x242
function function_a516f0de(str_targetname, var_f2ce48d2, var_9fd93917) {
    if (!isdefined(var_f2ce48d2)) {
        var_f2ce48d2 = 7;
    }
    if (!isdefined(var_9fd93917)) {
        var_9fd93917 = 3;
    }
    level endon(#"hash_fb8a92fd");
    level notify(#"hash_c087d549", 1);
    function_b9976e82();
    level flag::wait_till("all_players_spawned");
    var_522ce6c6 = 0;
    wait 1;
    while (true) {
        var_50042eb8 = getentarray(str_targetname, "targetname");
        if (var_50042eb8.size == 0) {
            return;
        }
        if (var_50042eb8[0].script_parameters === "vertical") {
            var_1c660783 = array(2, 4, 5);
        } else {
            var_1c660783 = array(1, 3, 6);
        }
        var_983e0b02 = "cp_lotus_projection_ravengrafitti" + var_1c660783[randomint(var_1c660783.size)];
        level thread function_545a568f(var_f2ce48d2, var_983e0b02);
        videostart(var_983e0b02);
        function_67212ab4(var_50042eb8, 1);
        var_522ce6c6++;
        var_90bf3c0b = level waittill(#"hash_c087d549");
        if (var_90bf3c0b === 1 || var_522ce6c6 >= var_9fd93917) {
            videostop(var_983e0b02);
            function_67212ab4(var_50042eb8, 1);
            return;
        }
    }
}

// Namespace lotus_util
// Params 2, eflags: 0x1 linked
// Checksum 0xabb6c2a2, Offset: 0x6c18
// Size: 0x96
function function_545a568f(var_f2ce48d2, var_983e0b02) {
    level endon(#"hash_c087d549");
    if (var_f2ce48d2 < 3) {
        var_f2ce48d2 = 3 + 1;
    }
    wait 5;
    wait randomintrange(3, var_f2ce48d2 + 1);
    videostop(var_983e0b02);
    wait 1;
    level notify(#"hash_c087d549");
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x622b11d6, Offset: 0x6cb8
// Size: 0x4c
function function_b9976e82() {
    var_50042eb8 = getentarray("raven_video_loc", "script_noteworthy");
    function_67212ab4(var_50042eb8, 0);
}

// Namespace lotus_util
// Params 3, eflags: 0x1 linked
// Checksum 0xef47f8cd, Offset: 0x6d10
// Size: 0x1fc
function function_511cba45(str_identifier, n_delay, var_983e0b02) {
    level endon(#"hash_fb8a92fd");
    level notify(#"hash_c18cb916");
    function_b9976e82();
    if (isdefined(n_delay)) {
        wait n_delay;
    }
    var_cb3e8a32 = getentarray("raven_video_loc", "script_noteworthy");
    var_50042eb8 = [];
    foreach (e_loc in var_cb3e8a32) {
        if (isstring(e_loc.targetname) && issubstr(e_loc.targetname, str_identifier)) {
            array::add(var_50042eb8, e_loc);
        }
    }
    if (!isdefined(var_983e0b02)) {
        var_983e0b02 = "cp_lotus_projection_ravengrafitti" + randomintrange(1, 6);
    }
    videostart(var_983e0b02);
    function_67212ab4(var_50042eb8, 1);
    wait 7;
    videostop(var_983e0b02);
    function_67212ab4(var_50042eb8, 0);
}

// Namespace lotus_util
// Params 3, eflags: 0x1 linked
// Checksum 0xb79b2418, Offset: 0x6f18
// Size: 0x202
function function_67212ab4(var_50042eb8, b_show, var_acc1160) {
    if (!isdefined(var_acc1160)) {
        var_acc1160 = 0;
    }
    if (b_show) {
        foreach (e_loc in var_50042eb8) {
            if (isdefined(e_loc)) {
                if (e_loc.script_string === "decal") {
                    e_loc clientfield::set("raven_decal", 1);
                    continue;
                }
                e_loc show();
            }
        }
        return;
    }
    foreach (e_loc in var_50042eb8) {
        if (isdefined(e_loc)) {
            if (e_loc.script_string === "decal") {
                if (var_acc1160) {
                    e_loc.script_noteworthy = undefined;
                }
                e_loc clientfield::set("raven_decal", 0);
                continue;
            }
            if (var_acc1160) {
                e_loc delete();
                continue;
            }
            e_loc hide();
        }
    }
}

// Namespace lotus_util
// Params 4, eflags: 0x1 linked
// Checksum 0x39c471ef, Offset: 0x7128
// Size: 0x384
function function_e577c596(var_a55eb7ca, trigger, var_c1afab5f, var_983e0b02) {
    if (isdefined(trigger)) {
        trigger trigger::wait_till();
    }
    foreach (player in level.players) {
        player thread function_c90abe1a();
        visionset_mgr::activate("visionset", "cp_raven_hallucination", player);
        player playsoundtoplayer("vox_dying_infected_after", player);
        player playsoundtoplayer("evt_dni_interrupt", player);
    }
    a_scenes = struct::get_array(var_a55eb7ca);
    foreach (s_scene in a_scenes) {
        if (s_scene.scriptbundlename === "cin_gen_traversal_raven_fly_away") {
            s_scene util::delay(randomfloat(5), undefined, &scene::play);
            continue;
        }
        s_scene thread scene::play();
    }
    if (isdefined(var_c1afab5f)) {
        level thread function_511cba45(var_c1afab5f, undefined, var_983e0b02);
    }
    wait 7;
    foreach (player in level.players) {
        player thread function_c90abe1a();
        player playsoundtoplayer("evt_dni_interrupt", player);
        util::delay(0.75, undefined, &visionset_mgr::deactivate, "visionset", "cp_raven_hallucination", player);
    }
    level thread scene::stop(var_a55eb7ca, "targetname");
    if (isdefined(var_983e0b02)) {
        videostop(var_983e0b02);
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x1ebb287f, Offset: 0x74b8
// Size: 0x7c
function function_c90abe1a() {
    self endon(#"death");
    self clientfield::increment_to_player("postfx_ravens", 1);
    self clientfield::set_to_player("hijack_static_effect", 1);
    wait 0.5;
    self clientfield::set_to_player("hijack_static_effect", 0);
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x8c8102e6, Offset: 0x7540
// Size: 0x10c
function function_77bfc3b2() {
    level scene::add_scene_func("cin_gen_ambient_raven_idle", &function_e547724d, "init");
    level scene::add_scene_func("cin_gen_ambient_raven_idle_eating_raven", &function_e547724d, "init");
    level scene::add_scene_func("cin_gen_traversal_raven_fly_away", &function_e547724d, "init");
    level scene::add_scene_func("cin_gen_ambient_raven_idle", &function_3f6f483d);
    level scene::add_scene_func("cin_gen_ambient_raven_idle_eating_raven", &function_3f6f483d);
    level scene::add_scene_func("cin_gen_traversal_raven_fly_away", &function_86b1cd8a);
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0x16b71b9a, Offset: 0x7658
// Size: 0x2c
function function_e547724d(a_ents) {
    a_ents["raven"] hide();
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0x856e394d, Offset: 0x7690
// Size: 0x2c
function function_3f6f483d(a_ents) {
    a_ents["raven"] show();
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0xa47fd66f, Offset: 0x76c8
// Size: 0x7c
function function_86b1cd8a(a_ents) {
    if (self.targetname === "hakim_door_raven_fly_away") {
        return;
    }
    a_ents["raven"] ghost();
    a_ents["raven"] waittill(#"hash_db8335ba");
    a_ents["raven"] show();
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0x71b80581, Offset: 0x7750
// Size: 0x134
function function_78805698(str_location) {
    foreach (player in level.activeplayers) {
        player util::delay(1.5, undefined, &clientfield::set, "player_frost_breath", 1);
        player thread function_5157e72f(str_location);
    }
    callback::on_spawned(&function_6edd9874);
    callback::on_spawned(&function_5157e72f);
    level.var_2fd26037 clientfield::set("hendricks_frost_breath", 1);
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x36318f01, Offset: 0x7890
// Size: 0x54
function function_6edd9874() {
    self clientfield::set("player_frost_breath", 1);
    if (self.var_6e127f9d === 1) {
        self clientfield::set_to_player("frost_post_fx", 1);
    }
}

// Namespace lotus_util
// Params 1, eflags: 0x1 linked
// Checksum 0x2c1b7337, Offset: 0x78f0
// Size: 0x2ca
function function_5157e72f(str_location) {
    if (!isdefined(str_location)) {
        str_location = "";
    }
    self endon(#"death");
    trigger = getent("trig_snow_fog_begin_" + str_location, "targetname");
    if (isdefined(trigger)) {
        trigger trigger::wait_till(undefined, undefined, self);
    }
    if (self.var_6e127f9d !== 0) {
        self util::delay(1.5, undefined, &clientfield::set_to_player, "frost_post_fx", 1);
    }
    level notify(#"hash_23be1ef");
    self clientfield::set_to_player("snow_fog", 1);
    self clientfield::set_to_player("player_dust_fx", 0);
    self clientfield::increment_to_player("postfx_frozen_forest", 1);
    self.var_4cf41af4 = 1;
    if (self flag::exists("end_snow_fx")) {
        self flag::clear("end_snow_fx");
    } else {
        self flag::init("end_snow_fx");
    }
    self playsound("evt_dni_glitch");
    self playloopsound("evt_snowverlay");
    if (self.var_5b9f1ca7 !== 1) {
        self thread function_c7402e23();
    }
    trigger = getent("trig_snow_fog_end_" + str_location, "targetname");
    if (isdefined(trigger)) {
        trigger trigger::wait_till(undefined, undefined, self);
        self thread function_3684f44b();
        self function_f21ea22f();
        self stoploopsound(1);
        self playsound("evt_dni_delusion_outro");
        level notify(#"hash_d77cf6d0");
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x336ae446, Offset: 0x7bc8
// Size: 0x14e
function function_f21ea22f() {
    self clientfield::set("player_frost_breath", 0);
    if (!self flag::exists("end_snow_fx")) {
        self flag::init("end_snow_fx");
    }
    if (!level flag::exists("end_snow_videos")) {
        level flag::init("end_snow_videos");
    }
    self flag::set("end_snow_fx");
    level flag::set("end_snow_videos");
    self clientfield::set_to_player("snow_fog", 0);
    self clientfield::set_to_player("frost_post_fx", 0);
    self clientfield::set_to_player("player_dust_fx", 1);
    self.var_4cf41af4 = undefined;
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x1212fb8c, Offset: 0x7d20
// Size: 0xb8
function function_c7402e23() {
    self notify(#"hash_7507ad85");
    self endon(#"hash_7507ad85");
    self endon(#"hash_d3d93f76");
    self endon(#"death");
    self thread function_f15e5e64();
    self.var_5b9f1ca7 = 1;
    do {
        playfxoncamera(level._effect["fx_snow_lotus"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        wait 0.05;
    } while (!self flag::get("end_snow_fx"));
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0xbd6feb2c, Offset: 0x7de0
// Size: 0x98
function function_f15e5e64() {
    self endon(#"hash_7507ad85");
    self endon(#"end_snow_fx");
    self endon(#"death");
    while (true) {
        trigger::wait_till("trig_pause_snow_camera_fx", undefined, undefined, 0);
        self notify(#"hash_d3d93f76");
        trigger::wait_till("trig_snow_fog_begin_pursuit", undefined, undefined, 0);
        self thread function_c7402e23();
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x0
// Checksum 0x1886d5ff, Offset: 0x7e80
// Size: 0x10a
function function_cf37ec3() {
    if (!level flag::exists("end_snow_videos")) {
        level flag::init("end_snow_videos");
    }
    while (!level flag::get("end_snow_videos")) {
        for (i = 1; i < 5; i++) {
            var_983e0b02 = "cp_lotus_projection_salem" + i;
            videostart(var_983e0b02);
            wait randomintrange(3, 5) + 5;
            videostop(var_983e0b02);
            wait 1.5;
        }
    }
}

// Namespace lotus_util
// Params 0, eflags: 0x1 linked
// Checksum 0x13c8e498, Offset: 0x7f98
// Size: 0x54
function function_3684f44b() {
    self endon(#"death");
    self clientfield::set_to_player("hijack_static_effect", 1);
    wait 1.2;
    self clientfield::set_to_player("hijack_static_effect", 0);
}

