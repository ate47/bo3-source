#using scripts/zm/zm_island_vo;
#using scripts/zm/_zm_weap_mirg2000;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_ai_thrasher;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/laststand_shared;
#using scripts/shared/drown;
#using scripts/shared/fx_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_7a07aa2f;

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0xfc5cab27, Offset: 0x748
// Size: 0x354
function init() {
    if (getdvarint("splitscreen_playerCount") > 2) {
        array::run_all(getentarray("mdl_mushroom_spore", "targetname"), &delete);
        array::run_all(getentarray("t_spore_explode", "script_noteworthy"), &delete);
        array::run_all(getentarray("t_spore_damage", "script_noteworthy"), &delete);
        array::thread_all(struct::get_array("spore_fx_org", "script_noteworthy"), &struct::delete);
        array::thread_all(struct::get_array("spore_cloud_org_stage_01", "script_noteworthy"), &struct::delete);
        array::thread_all(struct::get_array("spore_cloud_org_stage_02", "script_noteworthy"), &struct::delete);
        array::thread_all(struct::get_array("spore_cloud_org_stage_03", "script_noteworthy"), &struct::delete);
        struct::function_368120a1("scene", "p7_fxanim_zm_island_spores_rock_stage_01_bundle");
        struct::function_368120a1("scene", "p7_fxanim_zm_island_spores_rock_stage_02_bundle");
        struct::function_368120a1("scene", "p7_fxanim_zm_island_spores_rock_stage_02_rapid_bundle");
        struct::function_368120a1("scene", "p7_fxanim_zm_island_spores_rock_stage_03_bundle");
        struct::function_368120a1("scene", "p7_fxanim_zm_island_spores_wall_stage_01_bundle");
        struct::function_368120a1("scene", "p7_fxanim_zm_island_spores_wall_stage_02_bundle");
        struct::function_368120a1("scene", "p7_fxanim_zm_island_spores_wall_stage_02_rapid_bundle");
        struct::function_368120a1("scene", "p7_fxanim_zm_island_spores_wall_stage_03_bundle");
        return;
    }
    level.var_1abc7758 = getentarray("mdl_mushroom_spore", "targetname");
    array::thread_all(level.var_1abc7758, &function_53848c29);
    level.var_d6539691 = &function_62f658cb;
}

// Namespace namespace_7a07aa2f
// Params 3, eflags: 0x1 linked
// Checksum 0xd474af86, Offset: 0xaa8
// Size: 0x1dc
function function_62f658cb(v_origin, weapon, e_attacker) {
    var_a21dd47a = util::spawn_model("tag_origin", v_origin);
    var_a21dd47a.var_a5969fbf = spawnstruct();
    var_a21dd47a.var_a5969fbf.origin = v_origin;
    var_a21dd47a.var_a5969fbf.angles = (0, 0, 0);
    var_a21dd47a.var_338f3084 = spawnstruct();
    var_a21dd47a.var_338f3084.origin = v_origin;
    var_a21dd47a.var_338f3084.angles = (0, 0, 0);
    var_a21dd47a.var_5991aaed = spawnstruct();
    var_a21dd47a.var_5991aaed.origin = v_origin;
    var_a21dd47a.var_5991aaed.angles = (0, 0, 0);
    if (namespace_7cee2b44::is_wonder_weapon(weapon)) {
        var_a21dd47a function_4c6beece(2, 1, e_attacker);
    } else {
        var_a21dd47a function_4c6beece(2, 0, e_attacker);
    }
    util::wait_network_frame();
    var_a21dd47a delete();
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0x4e698295, Offset: 0xc90
// Size: 0x3d4
function function_53848c29() {
    self ghost();
    level flag::wait_till("start_zombie_round_logic");
    wait(randomintrange(2, 4));
    self clientfield::set("spore_grows", 4);
    if (self.script_noteworthy === "rock") {
        self.var_9d567097 = arraygetclosest(self.origin, getentarray("t_spore_explode", "script_noteworthy"));
        self.var_eec2cd7b = arraygetclosest(self.origin, getentarray("t_spore_damage", "script_noteworthy"));
        self.var_a5969fbf = arraygetclosest(self.origin, struct::get_array("spore_cloud_org_stage_01", "script_noteworthy"));
        self.var_338f3084 = arraygetclosest(self.origin, struct::get_array("spore_cloud_org_stage_02", "script_noteworthy"));
        self.var_5991aaed = arraygetclosest(self.origin, struct::get_array("spore_cloud_org_stage_03", "script_noteworthy"));
    } else {
        var_40c45d15 = getentarray(self.target, "targetname");
        var_c9234aca = struct::get_array(self.target, "targetname");
        foreach (var_6d602035 in var_40c45d15) {
            switch (var_6d602035.script_noteworthy) {
            case 4:
                self.var_9d567097 = var_6d602035;
                break;
            case 5:
                self.var_eec2cd7b = var_6d602035;
                break;
            }
        }
        foreach (var_dc604ef4 in var_c9234aca) {
            switch (var_dc604ef4.script_noteworthy) {
            case 7:
                self.var_a5969fbf = var_dc604ef4;
                break;
            case 8:
                self.var_338f3084 = var_dc604ef4;
                break;
            case 9:
                self.var_5991aaed = var_dc604ef4;
                break;
            }
        }
    }
    self thread function_e92dbdce();
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0x8a1a56bb, Offset: 0x1070
// Size: 0x34
function function_e92dbdce() {
    while (true) {
        self thread function_3dc43cc5();
        self waittill(#"hash_dcef79ff");
    }
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0xf2abfe69, Offset: 0x10b0
// Size: 0x68
function function_15e20abb() {
    self endon(#"hash_dcef79ff");
    while (true) {
        e_who = self.var_9d567097 waittill(#"touch");
        if (isai(e_who)) {
            self thread function_dcef79ff(0);
        }
    }
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0x64175cd9, Offset: 0x1120
// Size: 0x1da
function function_3dc43cc5() {
    self endon(#"hash_dcef79ff");
    if (!isdefined(self.var_4448f463)) {
        self.var_4448f463 = 0;
    }
    self.var_4448f463 = randomintrange(3, 5);
    self.var_f9f788a6 = 0;
    while (self.var_4448f463 > 0) {
        level waittill(#"end_of_round");
        self.var_4448f463 -= 1;
        if (self.var_4448f463 < 3) {
            self.var_f9f788a6 += 1;
            wait(randomfloatrange(3.5, 6.5));
            switch (self.var_f9f788a6) {
            case 1:
                self clientfield::set("spore_grows", 1);
                self thread function_523b2f00();
                break;
            case 2:
                self clientfield::set("spore_grows", 2);
                break;
            case 3:
                self clientfield::set("spore_grows", 3);
                self thread function_15e20abb();
                self thread function_c77e825c();
                self clientfield::set("spore_glow_fx", 1);
                break;
            }
        }
    }
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0xcddd2199, Offset: 0x1308
// Size: 0x114
function function_523b2f00() {
    self endon(#"hash_dcef79ff");
    self setcandamage(1);
    damage, e_attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags = self.var_eec2cd7b waittill(#"damage");
    e_attacker notify(#"hash_4f70cd59");
    if (namespace_7cee2b44::is_wonder_weapon(weapon)) {
        self thread function_dcef79ff(1, e_attacker);
        return;
    }
    self thread function_dcef79ff(0, e_attacker);
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0x92563c2a, Offset: 0x1428
// Size: 0x4c
function function_c77e825c() {
    self endon(#"hash_dcef79ff");
    e_who = self.var_eec2cd7b waittill(#"touch");
    self thread function_dcef79ff(0, e_who);
}

// Namespace namespace_7a07aa2f
// Params 2, eflags: 0x1 linked
// Checksum 0x79029291, Offset: 0x1480
// Size: 0xcc
function function_dcef79ff(b_hero_weapon, e_attacker) {
    var_f9f788a6 = self.var_f9f788a6;
    self thread function_4c6beece(var_f9f788a6, b_hero_weapon, e_attacker);
    self notify(#"hash_dcef79ff");
    if (var_f9f788a6 == 1) {
        self clientfield::set("spore_grows", 5);
    } else {
        self clientfield::set("spore_grows", 0);
    }
    self clientfield::set("spore_glow_fx", 0);
}

// Namespace namespace_7a07aa2f
// Params 3, eflags: 0x1 linked
// Checksum 0xff4d8a60, Offset: 0x1558
// Size: 0x24c
function function_4c6beece(var_f9f788a6, b_hero_weapon, e_attacker) {
    if (var_f9f788a6 == 1) {
        var_d7bb540a = 5;
        var_66bbb0c0 = 44;
        s_org = self.var_a5969fbf;
    } else if (var_f9f788a6 == 2) {
        var_d7bb540a = 10;
        var_66bbb0c0 = 60;
        s_org = self.var_338f3084;
    } else {
        var_d7bb540a = 15;
        var_66bbb0c0 = 76;
        s_org = self.var_5991aaed;
    }
    self thread function_63a5615b(b_hero_weapon, var_f9f788a6);
    playsoundatposition("zmb_spore_eject", self.origin);
    var_6d602035 = self function_cc07e4ad(var_66bbb0c0, s_org);
    while (var_d7bb540a > 0) {
        var_d7bb540a -= 0.25;
        a_e_enemies = var_6d602035 array::get_touching(getaiteamarray("axis"));
        a_e_players = var_6d602035 array::get_touching(level.players);
        array::thread_all(a_e_enemies, &function_ba7a3b74, 1, b_hero_weapon, e_attacker);
        array::thread_all(a_e_players, &function_ba7a3b74, 0, b_hero_weapon, undefined);
        wait(0.25);
    }
    self clientfield::set("spore_cloud_fx", 0);
    var_6d602035 notify(#"cleanup");
    var_6d602035 delete();
}

// Namespace namespace_7a07aa2f
// Params 2, eflags: 0x1 linked
// Checksum 0x5470e3c3, Offset: 0x17b0
// Size: 0x5c
function function_63a5615b(b_hero_weapon, var_f9f788a6) {
    var_f0ee45c9 = b_hero_weapon ? 0 : 3;
    self clientfield::set("spore_cloud_fx", var_f9f788a6 + var_f0ee45c9);
}

// Namespace namespace_7a07aa2f
// Params 2, eflags: 0x1 linked
// Checksum 0xf8b90ef9, Offset: 0x1818
// Size: 0x80
function function_cc07e4ad(var_66bbb0c0, s_org) {
    var_6d602035 = spawn("trigger_radius", s_org.origin - (0, 0, 60), 0, var_66bbb0c0, 90);
    var_6d602035.angles = s_org.angles;
    return var_6d602035;
}

// Namespace namespace_7a07aa2f
// Params 3, eflags: 0x1 linked
// Checksum 0x6dd67368, Offset: 0x18a0
// Size: 0x5ec
function function_ba7a3b74(var_2cfe5148, b_hero_weapon, e_attacker) {
    if (!isdefined(self.var_d07c64b6)) {
        self.var_d07c64b6 = 0;
    }
    if (var_2cfe5148) {
        self endon(#"death");
        if (self.targetname === "zombie") {
            if (!self.var_d07c64b6) {
                self.var_d07c64b6 = 1;
                if (b_hero_weapon) {
                    self clientfield::set("spore_trail_enemy_fx", 1);
                    self thread function_94e2552f();
                    wait(10);
                    self.var_d07c64b6 = 0;
                    self notify(#"hash_ab24308c");
                    self clientfield::set("spore_trail_enemy_fx", 0);
                } else {
                    self clientfield::set("spore_trail_enemy_fx", 2);
                    if (randomint(100) < 15 && namespace_756d2c3d::function_6d24956b(self.origin) && namespace_756d2c3d::function_cb4aac76(self) && !(isdefined(self.var_cbbe29a9) && self.var_cbbe29a9) && level.var_b5799c7c) {
                        var_e3372b59 = namespace_756d2c3d::function_8b323113(self);
                    } else {
                        self.var_317d58a6 = self.zombie_move_speed;
                        self zombie_utility::set_zombie_run_cycle("walk");
                        wait(10);
                        self zombie_utility::set_zombie_run_cycle(self.var_317d58a6);
                        self.var_d07c64b6 = 0;
                        self clientfield::set("spore_trail_enemy_fx", 0);
                    }
                }
            }
        } else if (isdefined(self.var_3940f450) && self.var_3940f450) {
            if (level flag::get("spiders_from_mars_round")) {
                return;
            }
            if (!self.var_d07c64b6) {
                self.var_d07c64b6 = 1;
                if (isdefined(e_attacker)) {
                    e_attacker notify(#"hash_2e126bd2");
                }
                if (b_hero_weapon) {
                    a_enemies = array::get_all_closest(self.origin, getaiteamarray("axis"), undefined, undefined, -128);
                    array::run_all(a_enemies, &dodamage, 1000, self.origin);
                } else {
                    self kill();
                }
            }
        } else if (isdefined(self.var_61f7b3a0) && self.var_61f7b3a0) {
            if (!self.var_d07c64b6) {
                if (b_hero_weapon) {
                    self.var_d07c64b6 = 1;
                    self dodamage(self.health / 2, self.origin);
                    wait(10);
                    self.var_d07c64b6 = 0;
                }
            }
        }
        return;
    }
    self endon(#"disconnect");
    if (isdefined(self.var_59bd3c5a)) {
        self.var_59bd3c5a kill();
        return;
    }
    if (!self.var_d07c64b6) {
        self.var_d07c64b6 = 1;
        if (self isplayerunderwater()) {
            self thread function_703ef5e8();
            wait(5);
        } else if (b_hero_weapon) {
            self clientfield::set("spore_trail_player_fx", 1);
            self clientfield::set_to_player("spore_camera_fx", 1);
            self thread function_365b46bb();
            wait(10);
        } else if (self.var_df4182b1) {
            self notify(#"hash_b56a74a8");
            wait(5);
        } else {
            self clientfield::set("spore_trail_player_fx", 2);
            self clientfield::set_to_player("spore_camera_fx", 2);
            self thread function_6cea25bb();
            self thread function_7fa4a0dd();
            self thread function_afacd209();
            self notify(#"hash_ece519d9");
            self waittill(#"hash_59bc7047");
            wait(1);
        }
        self.var_d07c64b6 = 0;
        self notify(#"hash_dd8e5266");
        self clientfield::set("spore_trail_player_fx", 0);
        self clientfield::set_to_player("spore_camera_fx", 0);
        self clientfield::set_to_player("play_spore_bubbles", 0);
    }
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0xbf2eaff1, Offset: 0x1e98
// Size: 0x18c
function function_365b46bb() {
    self endon(#"death");
    self notify(#"hash_a5098f25");
    self setmovespeedscale(1.15);
    self function_ba25e637(4);
    self function_e67885f8(0);
    self setperk("specialty_unlimitedsprint");
    self clientfield::set_to_player("wind_blur", 1);
    self playsound("zmb_spore_power_start");
    self playloopsound("zmb_spore_power_loop", 0.5);
    self waittill(#"hash_dd8e5266");
    self playsound("zmb_spore_power_stop");
    self stoploopsound(1);
    self unsetperk("specialty_unlimitedsprint");
    self setmovespeedscale(1);
    self clientfield::set_to_player("wind_blur", 0);
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0x83a72594, Offset: 0x2030
// Size: 0x7c
function function_703ef5e8() {
    self notify(#"hash_337fabcf");
    self.drownstage = 0;
    self clientfield::set_to_player("drown_stage", 0);
    self.lastwaterdamagetime = gettime();
    self drown::deactivate_player_health_visionset();
    self clientfield::set_to_player("play_spore_bubbles", 1);
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0xd43413f0, Offset: 0x20b8
// Size: 0x56
function function_94e2552f() {
    self endon(#"hash_ab24308c");
    self endon(#"death");
    while (true) {
        self dodamage(self.health / 10, self.origin);
        wait(1);
    }
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0x52b5b84f, Offset: 0x2118
// Size: 0xfc
function function_6cea25bb() {
    self endon(#"death");
    if (self isinvehicle()) {
        return;
    }
    if (!(isdefined(self.var_a20b0a07) && self.var_a20b0a07)) {
        self thread namespace_f333593c::function_cf763858();
        wait(0.15);
        self.var_a20b0a07 = 1;
        self.dontspeak = 0;
        if (!(isdefined(self.var_7149fc41) && self.var_7149fc41)) {
            self thread function_4febf04e();
            self zm_audio::create_and_play_dialog("spores", "attacked");
            wait(5);
        } else {
            self thread zm_audio::playerexert("cough", 1);
            wait(1);
        }
        self.var_a20b0a07 = 0;
    }
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0xa3598bec, Offset: 0x2220
// Size: 0x2c
function function_4febf04e() {
    self endon(#"death");
    self.var_7149fc41 = 1;
    wait(120);
    self.var_7149fc41 = 0;
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0x21fbc0f0, Offset: 0x2258
// Size: 0x5a
function function_afacd209() {
    self endon(#"disconnect");
    self endon(#"hash_59bc7047");
    self waittill(#"hash_89eb445c");
    if (self.is_drinking > 0) {
        self zm_utility::decrement_is_drinking();
    }
    self notify(#"hash_59bc7047");
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0x5578058e, Offset: 0x22c0
// Size: 0xce
function function_7fa4a0dd() {
    self endon(#"disconnect");
    self endon(#"hash_59bc7047");
    if (self isinvehicle()) {
        return;
    }
    self.var_e1f8edd6 = 0;
    self thread function_2ce1c95f();
    self util::waittill_any("fake_death", "death", "player_downed", "weapon_change_complete", "player_cancel_cough", "coughing_complete");
    self function_909c515f();
    self.var_e1f8edd6 = 0;
    self notify(#"hash_59bc7047");
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0x47c8715b, Offset: 0x2398
// Size: 0x1bc
function function_2ce1c95f() {
    self endon(#"disconnect");
    self endon(#"hash_59bc7047");
    if (isdefined(zm_utility::is_player_valid(self)) && !(self.is_drinking > 0) && zm_utility::is_player_valid(self)) {
        self zm_utility::increment_is_drinking();
    } else {
        wait(1);
        self notify(#"hash_59bc7047");
    }
    w_original = self getcurrentweapon();
    var_cb4caef3 = getweapon("zombie_cough");
    if (isdefined(zm_utility::is_player_valid(self)) && w_original != level.weaponnone && !(isdefined(self zm_laststand::is_reviving_any()) && self zm_laststand::is_reviving_any()) && zm_utility::is_player_valid(self)) {
        self.original_weapon = w_original;
    } else {
        wait(1);
        self notify(#"hash_5591fd88");
        return;
    }
    self.var_e1f8edd6 = 1;
    self zm_utility::disable_player_move_states(1);
    self giveweapon(var_cb4caef3);
    self switchtoweapon(var_cb4caef3);
}

// Namespace namespace_7a07aa2f
// Params 0, eflags: 0x1 linked
// Checksum 0xdae774f4, Offset: 0x2560
// Size: 0x1cc
function function_909c515f() {
    self endon(#"disconnect");
    self endon(#"hash_59bc7047");
    self zm_utility::enable_player_move_states();
    var_cb4caef3 = getweapon("zombie_cough");
    if (isdefined(self.intermission) && (self laststand::player_is_in_laststand() || self.intermission)) {
        self takeweapon(var_cb4caef3);
        return;
    }
    if (self.is_drinking > 0) {
        self zm_utility::decrement_is_drinking();
    }
    a_primaries = self getweaponslistprimaries();
    self takeweapon(var_cb4caef3);
    if (self.is_drinking > 0) {
        return;
    }
    if (isdefined(self.original_weapon)) {
        self switchtoweapon(self.original_weapon);
        return;
    }
    if (isdefined(a_primaries) && a_primaries.size > 0) {
        self switchtoweapon(a_primaries[0]);
        return;
    }
    if (self hasweapon(level.laststandpistol)) {
        self switchtoweapon(level.laststandpistol);
        return;
    }
    self zm_weapons::give_fallback_weapon();
}

