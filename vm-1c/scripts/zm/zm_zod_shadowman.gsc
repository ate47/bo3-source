#using scripts/zm/zm_zod_util;
#using scripts/zm/zm_zod_quest_vo;
#using scripts/zm/zm_zod_pods;
#using scripts/zm/zm_zod_margwa;
#using scripts/zm/zm_zod_ee;
#using scripts/zm/zm_zod_defend_areas;
#using scripts/zm/zm_zod_craftables;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_ai_wasp;
#using scripts/zm/_zm_ai_raps;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace zm_zod_shadowman;

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x2
// Checksum 0xcc01b180, Offset: 0x9f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_shadowman", &__init__, undefined, undefined);
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x1 linked
// Checksum 0x30fb7582, Offset: 0xa38
// Size: 0xac
function __init__() {
    callback::on_connect(&on_player_connect);
    level._effect["shadowman_ground_tell"] = "zombie/fx_shdw_spell_tell_zod_zmb";
    level._effect["cursetrap_explosion"] = "zombie/fx_ee_explo_ritual_zod_zmb";
    level._effect["shadowman_impact_fx"] = "zombie/fx_shdw_impact_zod_zmb";
    level flag::init("shadowman_first_seen");
    /#
        level thread function_e4f74672();
    #/
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xaf0
// Size: 0x4
function on_player_connect() {
    
}

// Namespace zm_zod_shadowman
// Params 4, eflags: 0x1 linked
// Checksum 0x1894b472, Offset: 0xb00
// Size: 0x1c4
function function_12e7164a(var_5b35973a, var_d250bd20, var_b7791b4b, var_32a5629a) {
    if (!isdefined(var_5b35973a)) {
        var_5b35973a = 1;
    }
    if (!isdefined(var_d250bd20)) {
        var_d250bd20 = 0;
    }
    if (!isdefined(var_b7791b4b)) {
        var_b7791b4b = 0;
    }
    if (!isdefined(var_32a5629a)) {
        var_32a5629a = 0;
    }
    self.var_93dad597 = util::spawn_model("c_zom_zod_shadowman_fb", self.origin, self.angles);
    self.var_93dad597 useanimtree(#generic);
    if (!var_b7791b4b) {
        self.var_93dad597 clientfield::set("shadowman_fx", 1);
    }
    self.var_93dad597 playsound("zmb_shadowman_tele_in");
    self.var_93dad597.health = 1000000;
    if (var_d250bd20) {
        if (var_32a5629a) {
            self.var_93dad597 thread animation::play("ai_zombie_zod_shadowman_float_idle_loop");
        } else {
            self.var_93dad597 thread animation::play("ai_zombie_zod_shadowman_human_stand_idle_loop");
        }
    }
    if (var_5b35973a) {
        self.var_93dad597 setcandamage(1);
        return;
    }
    self.var_93dad597 setcandamage(0);
}

// Namespace zm_zod_shadowman
// Params 4, eflags: 0x1 linked
// Checksum 0x8b8c22c0, Offset: 0xcd0
// Size: 0x224
function function_8888a532(var_5b35973a, var_d250bd20, var_2c1a0d8f, var_32a5629a) {
    if (!isdefined(var_5b35973a)) {
        var_5b35973a = 1;
    }
    if (!isdefined(var_d250bd20)) {
        var_d250bd20 = 0;
    }
    if (!isdefined(var_2c1a0d8f)) {
        var_2c1a0d8f = 0;
    }
    if (!isdefined(var_32a5629a)) {
        var_32a5629a = 0;
    }
    self.var_5afdc7fe = util::spawn_model("c_zom_zod_shadowman_tentacles_fb", self.origin, self.angles);
    self.var_5afdc7fe useanimtree(#generic);
    self.var_5afdc7fe.health = 1000000;
    self.var_5afdc7fe clientfield::set("shadowman_fx", 1);
    if (var_d250bd20) {
        if (var_32a5629a) {
            self.var_5afdc7fe thread animation::play("ai_zombie_zod_shadowman_float_idle_loop");
        } else {
            self.var_5afdc7fe thread animation::play("ai_zombie_zod_shadowman_stand_idle_loop");
        }
    }
    if (var_5b35973a) {
        self.var_5afdc7fe setcandamage(1);
    } else {
        self.var_5afdc7fe setcandamage(0);
    }
    if (var_2c1a0d8f) {
        self.var_5afdc7fe setinvisibletoall();
        return;
    }
    self.var_5afdc7fe attach("p7_fxanim_zm_zod_redemption_key_ritual_mod", "tag_weapon_right");
    playfxontag(level._effect["ritual_key_glow"], self.var_5afdc7fe, "tag_weapon_right");
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x1 linked
// Checksum 0xa623ea10, Offset: 0xf00
// Size: 0x6c
function function_f25f7ff3() {
    self.var_93dad597 clientfield::set("shadowman_fx", 2);
    self.var_93dad597 playsound("zmb_shadowman_tele_out");
    wait 0.5;
    self.var_93dad597 delete();
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x1 linked
// Checksum 0x4a21fbc4, Offset: 0xf78
// Size: 0x1c
function function_57b6041b() {
    self.var_5afdc7fe delete();
}

// Namespace zm_zod_shadowman
// Params 5, eflags: 0x1 linked
// Checksum 0x7eee5cfb, Offset: 0xfa0
// Size: 0x3ca
function function_f3805c8a(var_8f0a8b6a, str_script_noteworthy, var_a21704fb, var_e033b3aa, var_f5525b44) {
    if (!isdefined(level.shadowman)) {
        level.shadowman = spawnstruct();
    }
    level.shadowman.var_8f0a8b6a = var_8f0a8b6a;
    a_s_spawnpoints = struct::get_array(var_8f0a8b6a, "targetname");
    if (level clientfield::get("ee_quest_state") === 1) {
        a_s_spawnpoints = array::filter(a_s_spawnpoints, 0, &function_726d4cc4, 0);
    }
    if (isdefined(str_script_noteworthy)) {
        a_s_spawnpoints = array::filter(a_s_spawnpoints, 0, &function_69330ce7, str_script_noteworthy);
    } else {
        a_s_spawnpoints = array::randomize(a_s_spawnpoints);
    }
    level.shadowman.s_spawnpoint = a_s_spawnpoints[a_s_spawnpoints.size - 1];
    var_2e456dd1 = level.shadowman.s_spawnpoint.origin;
    var_7e1ba25f = level.shadowman.s_spawnpoint.angles;
    level.shadowman.var_93dad597 = spawn("script_model", var_2e456dd1);
    level.shadowman.var_93dad597.angles = var_7e1ba25f;
    level.shadowman.var_93dad597 setmodel("c_zom_zod_shadowman_tentacles_fb");
    level.shadowman.var_93dad597 useanimtree(#generic);
    level.shadowman.var_93dad597 setcandamage(1);
    level.shadowman.var_93dad597 clientfield::set("shadowman_fx", 1);
    level.shadowman.var_93dad597 playsound("zmb_shadowman_tele_in");
    level.shadowman.var_93dad597 attach("p7_fxanim_zm_zod_redemption_key_ritual_mod", "tag_weapon_right");
    level.shadowman.n_script_int = 0;
    level.shadowman.str_script_noteworthy = str_script_noteworthy;
    level.shadowman thread function_b6c7fd80();
    level.shadowman.var_e033b3aa = var_e033b3aa;
    level.shadowman.var_f5525b44 = var_f5525b44;
    level.shadowman.var_a21704fb = var_a21704fb;
    level.shadowman thread function_43eea1de();
    level.shadowman.var_93dad597 thread animation::play("ai_zombie_zod_shadowman_float_idle_loop", undefined, undefined, 1);
    return level.shadowman;
}

// Namespace zm_zod_shadowman
// Params 3, eflags: 0x0
// Checksum 0xb394de33, Offset: 0x1378
// Size: 0x88
function function_d04f45cf(var_a21704fb, var_e033b3aa, var_f5525b44) {
    if (!isdefined(level.shadowman)) {
        return;
    }
    if (isdefined(var_e033b3aa)) {
        level.shadowman.var_e033b3aa = var_e033b3aa;
    }
    if (isdefined(var_f5525b44)) {
        level.shadowman.var_f5525b44 = var_f5525b44;
    }
    if (isdefined(var_a21704fb)) {
        level.shadowman.var_a21704fb = var_a21704fb;
    }
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x1 linked
// Checksum 0xd062c1ed, Offset: 0x1408
// Size: 0xc4
function function_e48af0db() {
    if (!isdefined(level.shadowman)) {
        return;
    }
    level notify(#"hash_a881e3fa");
    if (!isdefined(level.shadowman.var_93dad597)) {
        return;
    }
    var_93dad597 = level.shadowman.var_93dad597;
    if (isdefined(var_93dad597)) {
        var_93dad597 clientfield::set("shadowman_fx", 2);
        var_93dad597 playsound("zmb_shadowman_tele_out");
    }
    wait 0.5;
    if (isdefined(var_93dad597)) {
        var_93dad597 delete();
    }
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x1 linked
// Checksum 0x428df4f8, Offset: 0x14d8
// Size: 0x178
function function_43eea1de() {
    level endon(#"hash_a881e3fa");
    while (true) {
        var_47364533 = randomfloatrange(self.var_e033b3aa, self.var_f5525b44);
        wait var_47364533;
        n_roll = randomfloatrange(0, 1);
        var_6ab32645 = 0;
        foreach (s_move in self.var_a21704fb) {
            var_6ab32645 += s_move.probability;
            if (n_roll <= var_6ab32645) {
                if (!(isdefined(self.var_8abfb076) && self.var_8abfb076)) {
                    self [[ s_move.func ]](s_move.var_572b6f62);
                }
                break;
            }
        }
        self.var_a21704fb = array::randomize(self.var_a21704fb);
    }
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x1 linked
// Checksum 0xbd1710bb, Offset: 0x1658
// Size: 0x590
function function_b6c7fd80() {
    level notify(#"hash_b6c7fd80");
    level endon(#"hash_b6c7fd80");
    level endon(#"hash_a881e3fa");
    a_s_spawnpoints = struct::get_array(self.var_8f0a8b6a, "targetname");
    if (isdefined(self.str_script_noteworthy)) {
        a_s_spawnpoints = array::filter(a_s_spawnpoints, 0, &function_69330ce7, self.str_script_noteworthy);
    } else {
        a_s_spawnpoints = array::randomize(a_s_spawnpoints);
    }
    var_bac4e70 = 0;
    var_90530d3 = 0;
    self.var_8abfb076 = 0;
    while (true) {
        self.var_93dad597.health = 1000000;
        amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon = self.var_93dad597 waittill(#"damage");
        playfx(level._effect["shadowman_impact_fx"], point);
        var_90530d3 += amount;
        var_6b401aad = 0;
        for (i = 0; i < 2; i++) {
            var_566556d8 = getweapon(level.idgun[i].var_e4be281f);
            assert(isdefined(var_566556d8));
            if (weapon === var_566556d8) {
                var_6b401aad = 1;
            }
        }
        n_player_count = level.activeplayers.size;
        var_d6a1b83c = 0.5 + 0.5 * (n_player_count - 1) / 3;
        var_9bd75db5 = 1000 * var_d6a1b83c;
        var_e3b39dfc = 0;
        if (var_90530d3 >= var_9bd75db5) {
            var_e3b39dfc = 1;
        }
        if (!var_e3b39dfc && !var_6b401aad) {
            continue;
        }
        var_90530d3 = 0;
        if (level clientfield::get("ee_quest_state") === 1 && level flag::get("ee_boss_vulnerable") === 0) {
            continue;
        }
        self.var_8abfb076 = 1;
        level notify(#"hash_82a23c03");
        if (level flag::get("ee_boss_started")) {
            if (self.n_script_int < 8) {
                self.n_script_int++;
                self.s_spawnpoint = function_293235e9(self.var_8f0a8b6a, self.s_spawnpoint, self.n_script_int);
            }
            var_685eb707 = 0.1;
            function_284b1884(self, self.s_spawnpoint, var_685eb707, undefined);
            self.var_93dad597 thread animation::play("ai_zombie_zod_shadowman_captured_intro", undefined, undefined, 1);
            continue;
        }
        var_bac4e70++;
        if (var_bac4e70 == a_s_spawnpoints.size) {
            a_s_spawnpoints = array::randomize(a_s_spawnpoints);
            var_bac4e70 = 0;
        }
        self.s_spawnpoint = a_s_spawnpoints[var_bac4e70];
        var_685eb707 = randomfloatrange(5, 10);
        self.var_8abfb076 = 0;
        var_5d186a94 = level.var_6e3c8a77.origin;
        v_dir = vectornormalize(var_5d186a94 - self.s_spawnpoint.origin);
        v_angles = vectortoangles(v_dir);
        function_284b1884(self, self.s_spawnpoint, var_685eb707, v_angles);
        self.var_93dad597 thread animation::play("ai_zombie_zod_shadowman_float_idle_loop", undefined, undefined, 1);
    }
}

// Namespace zm_zod_shadowman
// Params 4, eflags: 0x1 linked
// Checksum 0x54a76c1d, Offset: 0x1bf0
// Size: 0x17c
function function_284b1884(var_dbc3a0ef, s_target, var_685eb707, v_angles) {
    var_dbc3a0ef.var_93dad597 animation::stop();
    var_dbc3a0ef.var_93dad597 clientfield::set("shadowman_fx", 2);
    var_dbc3a0ef.var_93dad597 playsound("zmb_shadowman_tele_out");
    var_dbc3a0ef.var_93dad597 hide();
    var_dbc3a0ef.var_93dad597.origin = s_target.origin;
    if (isdefined(v_angles)) {
        var_dbc3a0ef.var_93dad597.angles = v_angles;
    }
    if (isdefined(var_685eb707)) {
        wait var_685eb707;
    }
    var_dbc3a0ef.var_93dad597 clientfield::set("shadowman_fx", 1);
    var_dbc3a0ef.var_93dad597 playsound("zmb_shadowman_tele_in");
    var_dbc3a0ef.var_93dad597 show();
}

// Namespace zm_zod_shadowman
// Params 3, eflags: 0x1 linked
// Checksum 0xa235ad81, Offset: 0x1d78
// Size: 0xf0
function function_293235e9(var_8f0a8b6a, var_1e5c1571, n_script_int) {
    a_s_spawnpoints = struct::get_array(var_8f0a8b6a, "targetname");
    if (isdefined(var_1e5c1571)) {
        arrayremovevalue(a_s_spawnpoints, var_1e5c1571);
    }
    if (isdefined(n_script_int)) {
        a_s_spawnpoints = array::filter(a_s_spawnpoints, 0, &function_726d4cc4, n_script_int);
    }
    assert(a_s_spawnpoints.size > 0);
    a_s_spawnpoints = array::randomize(a_s_spawnpoints);
    return a_s_spawnpoints[0];
}

// Namespace zm_zod_shadowman
// Params 2, eflags: 0x1 linked
// Checksum 0x8c0ad48c, Offset: 0x1e70
// Size: 0x6e
function function_726d4cc4(s_loc, n_script_int) {
    if (!isdefined(s_loc) || !isdefined(s_loc.script_int) || !(isdefined(s_loc.script_int === n_script_int) && s_loc.script_int === n_script_int)) {
        return false;
    }
    return true;
}

// Namespace zm_zod_shadowman
// Params 2, eflags: 0x1 linked
// Checksum 0x674eaa59, Offset: 0x1ee8
// Size: 0x6e
function function_69330ce7(s_loc, str_script_noteworthy) {
    if (!isdefined(s_loc) || !isdefined(s_loc.script_noteworthy) || !(isdefined(s_loc.script_noteworthy === str_script_noteworthy) && s_loc.script_noteworthy === str_script_noteworthy)) {
        return false;
    }
    return true;
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x0
// Checksum 0xa5fce3fa, Offset: 0x1f60
// Size: 0x9c
function function_1c6bcf90(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_8cf7b520 = "buffed_zombie_spawn_point_" + self.var_93c52a20;
    n_spawn_count = randomintrange(1, 3);
    self function_52243341(var_8cf7b520, var_572b6f62, 0, n_spawn_count, 0.25, 0.5);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x0
// Checksum 0x6d5cf8fe, Offset: 0x2008
// Size: 0x9c
function function_58a299d8(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_8cf7b520 = "buffed_zombie_spawn_point_" + self.var_93c52a20;
    n_spawn_count = randomintrange(3, 6);
    self function_52243341(var_8cf7b520, var_572b6f62, 0, n_spawn_count, 0.1, 0.2);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x0
// Checksum 0x72aa8485, Offset: 0x20b0
// Size: 0x74
function function_8e16c7ef(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_8cf7b520 = "buffed_elemental_spawn_point_" + self.var_93c52a20;
    self function_52243341(var_8cf7b520, var_572b6f62, 2, 1, 0.25, 0.5);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x0
// Checksum 0xe0c9a8ab, Offset: 0x2130
// Size: 0x74
function function_801629a7(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_8cf7b520 = "buffed_elemental_spawn_point_" + self.var_93c52a20;
    self function_52243341(var_8cf7b520, var_572b6f62, 2, 3, 0.1, 0.2);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x0
// Checksum 0xd08f4f4e, Offset: 0x21b0
// Size: 0xd4
function function_2c57b431(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_8cf7b520 = "buffed_elemental_spawn_point";
    var_39ec9ec2 = level clientfield::get("ee_quest_state");
    if (var_39ec9ec2 == 0) {
        var_8388cfbb = level.var_6e3c8a77.origin;
    } else if (var_39ec9ec2 == 1) {
    }
    self function_52243341(var_8cf7b520, var_572b6f62, 2, 1, 0.25, 0.5, var_8388cfbb);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x0
// Checksum 0xd643abbf, Offset: 0x2290
// Size: 0xd4
function function_6e618ab9(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_8cf7b520 = "buffed_elemental_spawn_point";
    var_39ec9ec2 = level clientfield::get("ee_quest_state");
    if (var_39ec9ec2 == 0) {
        var_8388cfbb = level.var_6e3c8a77.origin;
    } else if (var_39ec9ec2 == 1) {
    }
    self function_52243341(var_8cf7b520, var_572b6f62, 2, 3, 0.1, 0.2, var_8388cfbb);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x1e5b4926, Offset: 0x2370
// Size: 0x138
function function_4a41b207(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_8388cfbb = level.var_6e3c8a77.origin;
    self function_a3821eb5(var_572b6f62);
    n_spawn_count = randomintrange(5, 9);
    var_78436f04 = zm_ai_wasp::get_favorite_enemy();
    for (i = 0; i < n_spawn_count; i++) {
        spawn_point = zm_ai_wasp::function_e76b0f73(var_78436f04);
        self thread function_4ef376eb(spawn_point);
        n_wait = randomfloatrange(0.1, 0.3);
        wait n_wait;
    }
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x0
// Checksum 0x5638b6ab, Offset: 0x24b0
// Size: 0x10a
function function_c073c1e6(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_32cbfe17 = [];
    var_10284ef9 = zm_zod_util::function_15166300(4);
    if (var_10284ef9 >= 1) {
        if (!isdefined(var_32cbfe17)) {
            var_32cbfe17 = [];
        } else if (!isarray(var_32cbfe17)) {
            var_32cbfe17 = array(var_32cbfe17);
        }
        var_32cbfe17[var_32cbfe17.size] = &function_32e7f676;
    }
    if (var_32cbfe17.size > 0) {
        var_b37e00f9 = array::random(var_32cbfe17);
        self [[ var_b37e00f9 ]](var_572b6f62);
    }
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x394cf1df, Offset: 0x25c8
// Size: 0x262
function function_b4b792ef(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_2c563e77 = zm_zod_util::function_15166300(1);
    var_57689abe = zm_zod_util::function_15166300(3);
    var_32cbfe17 = [];
    if (var_2c563e77 >= 4) {
        if (!isdefined(var_32cbfe17)) {
            var_32cbfe17 = [];
        } else if (!isarray(var_32cbfe17)) {
            var_32cbfe17 = array(var_32cbfe17);
        }
        var_32cbfe17[var_32cbfe17.size] = &function_c94f30a2;
    }
    if (var_57689abe >= 3) {
        if (!isdefined(var_32cbfe17)) {
            var_32cbfe17 = [];
        } else if (!isarray(var_32cbfe17)) {
            var_32cbfe17 = array(var_32cbfe17);
        }
        var_32cbfe17[var_32cbfe17.size] = &function_45c7d9eb;
    }
    if (var_32cbfe17.size === 0) {
        if (!isdefined(var_32cbfe17)) {
            var_32cbfe17 = [];
        } else if (!isarray(var_32cbfe17)) {
            var_32cbfe17 = array(var_32cbfe17);
        }
        var_32cbfe17[var_32cbfe17.size] = &function_e44c4f1b;
    } else {
        if (!isdefined(var_32cbfe17)) {
            var_32cbfe17 = [];
        } else if (!isarray(var_32cbfe17)) {
            var_32cbfe17 = array(var_32cbfe17);
        }
        var_32cbfe17[var_32cbfe17.size] = &function_fcd226a8;
    }
    var_b37e00f9 = array::random(var_32cbfe17);
    self [[ var_b37e00f9 ]](var_572b6f62);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x4e43e85c, Offset: 0x2838
// Size: 0xa4
function function_c94f30a2(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_2c563e77 = zm_zod_util::function_15166300(1);
    n_spawn_count = min(var_2c563e77, 8);
    self function_52243341("spawn_point_boss_fight", var_572b6f62, 0, n_spawn_count, 5, 8);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x457ac59f, Offset: 0x28e8
// Size: 0xac
function function_45c7d9eb(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_57689abe = zm_zod_util::function_15166300(3);
    n_spawn_count = min(var_57689abe, 5);
    self function_52243341("spawn_point_boss_fight", var_572b6f62, 2, n_spawn_count, 5, 8);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0xd09b5665, Offset: 0x29a0
// Size: 0xac
function function_32e7f676(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    var_10284ef9 = zm_zod_util::function_15166300(4);
    n_spawn_count = min(var_10284ef9, 1);
    self function_52243341("spawn_point_boss_fight", var_572b6f62, 3, n_spawn_count, 5, 8);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0xa17c21e7, Offset: 0x2a58
// Size: 0xca
function function_fcd226a8(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    self function_a3821eb5(var_572b6f62);
    var_9eb45ed3 = array("boxer", "detective", "femme", "magician");
    var_d7e2a718 = array::random(var_9eb45ed3);
    level clientfield::set("ee_keeper_" + var_d7e2a718 + "_state", 6);
    wait var_572b6f62;
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x73f4303c, Offset: 0x2b30
// Size: 0x118
function function_e44c4f1b(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    self function_a3821eb5(var_572b6f62);
    var_9eb45ed3 = array("boxer", "detective", "femme", "magician");
    foreach (var_d7e2a718 in var_9eb45ed3) {
        level clientfield::set("ee_keeper_" + var_d7e2a718 + "_state", 6);
    }
    wait var_572b6f62;
}

// Namespace zm_zod_shadowman
// Params 8, eflags: 0x1 linked
// Checksum 0x3b8cfa68, Offset: 0x2c50
// Size: 0xb4
function function_52243341(var_8cf7b520, var_572b6f62, var_cbdd21c0, n_spawn_count, var_58655a9e, var_ab3cc960, var_8388cfbb, s_target) {
    if (!isdefined(var_cbdd21c0)) {
        var_cbdd21c0 = 0;
    }
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    self function_a3821eb5(var_572b6f62);
    self function_1bd7a0f4(var_8cf7b520, var_cbdd21c0, n_spawn_count, var_58655a9e, var_ab3cc960, var_8388cfbb);
}

// Namespace zm_zod_shadowman
// Params 2, eflags: 0x1 linked
// Checksum 0x9deccc24, Offset: 0x2d10
// Size: 0x35c
function function_a3821eb5(var_572b6f62, var_8fc8c481) {
    if (!isdefined(var_8fc8c481)) {
        var_8fc8c481 = 1;
    }
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    self.var_93dad597 animation::stop();
    self.var_93dad597 clientfield::set("shadowman_fx", 3);
    self.var_93dad597 playsound("zmb_shadowman_spell_start");
    self.var_93dad597 playloopsound("zmb_shadowman_spell_loop", 0.75);
    self.var_93dad597 clearanim("ai_zombie_zod_shadowman_float_idle_loop", 0);
    self.var_93dad597 animation::play("ai_zombie_zod_shadowman_float_attack_aoe_charge_intro", undefined, undefined, var_8fc8c481);
    player = level.activeplayers[0];
    self.var_93dad597 animation::stop();
    self.var_93dad597 clientfield::set("shadowman_fx", 4);
    self.var_93dad597 clearanim("ai_zombie_zod_shadowman_float_attack_aoe_charge_intro", 0);
    self.var_93dad597 thread animation::play("ai_zombie_zod_shadowman_float_attack_aoe_charge_loop", undefined, undefined, var_8fc8c481);
    level thread zm_zod_util::function_3a7a7013(5, 1024, self.var_93dad597.origin, var_572b6f62);
    wait var_572b6f62;
    self.var_93dad597 animation::stop();
    self.var_93dad597 clientfield::set("shadowman_fx", 5);
    self.var_93dad597 stoploopsound(0.1);
    self.var_93dad597 playsound("zmb_shadowman_spell_cast");
    self.var_93dad597 clearanim("ai_zombie_zod_shadowman_float_attack_aoe_charge_loop", 0);
    self.var_93dad597 animation::play("ai_zombie_zod_shadowman_float_attack_aoe_deploy", undefined, undefined, var_8fc8c481);
    level thread zm_zod_util::function_3a7a7013(6, 1024, self.var_93dad597.origin, 1);
    self.var_93dad597 clientfield::set("shadowman_fx", 6);
    self.var_93dad597 clearanim("ai_zombie_zod_shadowman_float_attack_aoe_deploy", 0);
    self.var_93dad597 thread animation::play("ai_zombie_zod_shadowman_float_idle_loop", undefined, undefined, var_8fc8c481);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x0
// Checksum 0x154f9793, Offset: 0x3078
// Size: 0x294
function function_bd35f3d6(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    self.var_93dad597 clientfield::set("shadowman_fx", 3);
    self.var_93dad597 playsound("zmb_shadowman_spell_start");
    self.var_93dad597 playloopsound("zmb_shadowman_spell_loop", 0.75);
    self.var_93dad597 animation::play("ai_zombie_zod_shadowman_float_attack_aoe_charge_intro", undefined, undefined);
    player = level.activeplayers[0];
    self.var_93dad597 animation::stop();
    self.var_93dad597 clientfield::set("shadowman_fx", 4);
    self.var_93dad597 thread animation::play("ai_zombie_zod_shadowman_float_attack_aoe_charge_loop", undefined, undefined);
    level thread zm_zod_util::function_3a7a7013(5, 1024, self.var_93dad597.origin, var_572b6f62);
    wait var_572b6f62;
    self.var_93dad597 animation::stop();
    self.var_93dad597 clientfield::set("shadowman_fx", 5);
    self.var_93dad597 stoploopsound(0.1);
    self.var_93dad597 playsound("zmb_shadowman_spell_cast");
    self.var_93dad597 animation::play("ai_zombie_zod_shadowman_float_attack_aoe_deploy", undefined, undefined);
    level thread zm_zod_util::function_3a7a7013(6, 1024, self.var_93dad597.origin, 1);
    self.var_93dad597 clientfield::set("shadowman_fx", 6);
    self function_80fd208e(self.var_93c52a20);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x0
// Checksum 0xd51c5b7b, Offset: 0x3318
// Size: 0xb4
function function_3803c75b(var_572b6f62) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    self.var_93dad597 thread animation::play("ai_zombie_zod_keeper_give_me_sword_intro", undefined, undefined, var_572b6f62);
    wait var_572b6f62;
    player = getplayers()[0];
    v_origin = player getorigin();
    function_ada13668(v_origin, undefined, 0);
}

// Namespace zm_zod_shadowman
// Params 6, eflags: 0x1 linked
// Checksum 0x9c6fcb6e, Offset: 0x33d8
// Size: 0x1d0
function function_1bd7a0f4(var_8cf7b520, var_cbdd21c0, n_spawn_count, var_58655a9e, var_ab3cc960, var_8388cfbb) {
    a_s_spawnpoints = struct::get_array(var_8cf7b520, "targetname");
    a_s_spawnpoints = array::randomize(a_s_spawnpoints);
    v_origin = self.var_93dad597.origin;
    for (i = 0; i < n_spawn_count; i++) {
        v_target = a_s_spawnpoints[i].origin;
        switch (var_cbdd21c0) {
        case 0:
            self thread function_1063429a(a_s_spawnpoints[i]);
            break;
        case 1:
            self thread function_4ef376eb(a_s_spawnpoints[i]);
            break;
        case 2:
            self thread function_7a4cf63(a_s_spawnpoints[i], var_8388cfbb);
            break;
        case 3:
            self thread zm_zod_margwa::function_8bcb72e9(0, a_s_spawnpoints[i]);
            break;
        }
        var_dc7b7a0f = randomfloatrange(var_58655a9e, var_ab3cc960);
        wait var_dc7b7a0f;
    }
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0xbd2883ff, Offset: 0x35b0
// Size: 0x1d4
function function_1063429a(s_spawnpoint) {
    var_42513f6e = getent("ritual_zombie_spawner", "targetname");
    var_7a88c258 = spawn("script_model", s_spawnpoint.origin);
    var_7a88c258 setmodel("tag_origin");
    var_7a88c258 clientfield::set("darkportal_fx", 1);
    var_7a88c258 playsound("evt_keeper_portal_start");
    var_7a88c258 playloopsound("evt_keeper_portal_loop", 1.2);
    self thread function_82fc1cb2(var_7a88c258);
    wait 0.5;
    ai = zombie_utility::spawn_zombie(var_42513f6e, "buffed_zombie", s_spawnpoint);
    ai thread function_27bb9b3b();
    ai thread function_827ad6f();
    ai.var_93c52a20 = self.var_93c52a20;
    wait 3;
    var_7a88c258 clientfield::set("darkportal_fx", 0);
    var_7a88c258 playsound("evt_keeper_portal_end");
    var_7a88c258 delete();
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0xc1c972e0, Offset: 0x3790
// Size: 0x14c
function function_4ef376eb(s_spawnpoint) {
    var_42513f6e = getent("ritual_zombie_spawner", "targetname");
    var_aaefedf3 = zombie_utility::spawn_zombie(level.var_c03323ec[0], "buffed_parasite", s_spawnpoint);
    if (isdefined(var_aaefedf3)) {
        if (!isdefined(level.var_27fa160f)) {
            level.var_27fa160f = [];
        }
        if (!isdefined(level.var_27fa160f)) {
            level.var_27fa160f = [];
        } else if (!isarray(level.var_27fa160f)) {
            level.var_27fa160f = array(level.var_27fa160f);
        }
        level.var_27fa160f[level.var_27fa160f.size] = var_aaefedf3;
        var_aaefedf3.favoriteenemy = array::random(level.activeplayers);
        level thread zm_ai_wasp::function_198fe8b9(var_aaefedf3, s_spawnpoint.origin);
    }
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x0
// Checksum 0x2370721, Offset: 0x38e8
// Size: 0x1b8
function function_33ddc9ed(var_93c52a20) {
    self endon(#"death");
    while (true) {
        s_pod = undefined;
        while (!isdefined(s_pod)) {
            s_pod = function_479785a0(var_93c52a20);
            wait 0.1;
        }
        s_pod.var_70ac16f8 = 1;
        wait 5;
        self vehicle_ai::set_state("scripted");
        goal = self getclosestpointonnavvolume(s_pod.origin + (0, 0, 32), 50);
        self setvehgoalpos(goal, 0, 1);
        self waittill(#"goal");
        if (isdefined(s_pod.var_9a8117f3) && s_pod.var_9a8117f3) {
            s_pod.buff = 1;
            s_pod.var_7a88c258 = spawn("script_model", s_pod.origin);
            s_pod.var_7a88c258 setmodel("tag_origin");
            s_pod.var_7a88c258 clientfield::set("curse_tell_fx", 1);
        }
    }
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0xdbcb2a09, Offset: 0x3aa8
// Size: 0xf4
function function_80fd208e(var_93c52a20) {
    s_pod = function_479785a0(var_93c52a20);
    if (!isdefined(s_pod)) {
        return;
    }
    s_pod.buff = 1;
    s_pod.var_7a88c258 = spawn("script_model", s_pod.origin);
    s_pod.var_7a88c258 setmodel("tag_origin");
    s_pod.var_7a88c258 playloopsound("evt_pod_plague_magic_lp", 1);
    s_pod.var_7a88c258 clientfield::set("curse_tell_fx", 1);
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x21923889, Offset: 0x3ba8
// Size: 0xcc
function function_479785a0(var_e28c6e5d) {
    oldzone = "ee_plague_pods_" + var_e28c6e5d;
    if (!isdefined(level.var_c0f45612[oldzone].spawned)) {
        return undefined;
    }
    var_c0eb23cc = array::filter(level.var_c0f45612[oldzone].spawned, 0, &function_9edae260);
    if (var_c0eb23cc.size === 0) {
        return undefined;
    }
    s_pod = array::random(var_c0eb23cc);
    return s_pod;
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x49f55be3, Offset: 0x3c80
// Size: 0x90
function function_9edae260(s_pod) {
    if (isdefined(s_pod.buff) && (isdefined(s_pod.var_70ac16f8) && (!isdefined(s_pod) || s_pod.var_70ac16f8) || s_pod.buff) || !(isdefined(s_pod.var_e81cb074) && s_pod.var_e81cb074)) {
        return false;
    }
    return true;
}

// Namespace zm_zod_shadowman
// Params 2, eflags: 0x1 linked
// Checksum 0x66dff0a7, Offset: 0x3d18
// Size: 0x194
function function_7a4cf63(s_spawnpoint, var_8388cfbb) {
    var_42513f6e = getent("ritual_zombie_spawner", "targetname");
    var_3e32f05a = zombie_utility::spawn_zombie(level.var_b15f9e1f[0], "buffed_elemental", s_spawnpoint);
    if (isdefined(var_3e32f05a)) {
        if (!isdefined(level.var_35fcee79)) {
            level.var_35fcee79 = [];
        }
        if (!isdefined(level.var_35fcee79)) {
            level.var_35fcee79 = [];
        } else if (!isarray(level.var_35fcee79)) {
            level.var_35fcee79 = array(level.var_35fcee79);
        }
        level.var_35fcee79[level.var_35fcee79.size] = var_3e32f05a;
        var_3e32f05a clientfield::set("veh_status_fx", 2);
        var_3e32f05a.favoriteenemy = array::random(level.activeplayers);
        s_spawnpoint thread namespace_5ace0f0e::function_5a37de3a(var_3e32f05a, s_spawnpoint);
        if (isdefined(var_8388cfbb)) {
            var_3e32f05a thread function_4a3d00d6(var_8388cfbb);
        }
    }
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x294c3ff1, Offset: 0x3eb8
// Size: 0x94
function function_4a3d00d6(goal) {
    self endon(#"death");
    wait 5;
    self vehicle_ai::set_state("scripted");
    goal = getclosestpointonnavmesh(goal, 50);
    self setvehgoalpos(goal, 0, 1);
    self thread function_75c9aad2(goal, 64);
}

// Namespace zm_zod_shadowman
// Params 3, eflags: 0x1 linked
// Checksum 0xdc056f30, Offset: 0x3f58
// Size: 0xb0
function function_75c9aad2(var_8388cfbb, n_radius, var_9c795730) {
    if (!isdefined(var_9c795730)) {
        var_9c795730 = 0;
    }
    self endon(#"death");
    var_699d80d5 = n_radius * n_radius;
    while (true) {
        if (distance2dsquared(self.origin, var_8388cfbb) <= var_699d80d5) {
            if (var_9c795730) {
                level notify(#"hash_d103204");
            }
            self kill();
        }
        wait 0.1;
    }
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x21d8ac33, Offset: 0x4010
// Size: 0x84
function function_82fc1cb2(var_7a88c258) {
    level endon(#"hash_a881e3fa");
    level waittill(#"hash_82a23c03");
    if (isdefined(var_7a88c258)) {
        var_7a88c258 clientfield::set("darkportal_fx", 0);
        var_7a88c258 playsound("evt_keeper_portal_end");
        var_7a88c258 delete();
    }
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x1 linked
// Checksum 0xc78576ea, Offset: 0x40a0
// Size: 0xd2
function function_27bb9b3b() {
    self endon(#"death");
    self.script_string = "find_flesh";
    self setphysparams(15, 0, 72);
    self.ignore_enemy_count = 1;
    self.no_powerups = 1;
    self.deathpoints_already_given = 1;
    self.var_8ac75273 = 1;
    self.exclude_cleanup_adding_to_total = 1;
    util::wait_network_frame();
    self clientfield::set("status_fx", 1);
    find_flesh_struct_string = "find_flesh";
    self notify(#"zombie_custom_think_done", find_flesh_struct_string);
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x1 linked
// Checksum 0x8e7b9a93, Offset: 0x4180
// Size: 0xb4
function function_827ad6f() {
    attacker, mod, weapon, point = self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    self clientfield::set("status_fx", 0);
    v_origin = self.origin;
    v_origin += (0, 0, 2);
    level thread function_ada13668(v_origin, undefined, 0);
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x4240
// Size: 0x4
function function_d74385f9() {
    
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x4250
// Size: 0x4
function function_ed1e1c78() {
    
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x4260
// Size: 0x4
function function_6c24da7d() {
    
}

// Namespace zm_zod_shadowman
// Params 5, eflags: 0x0
// Checksum 0xffbf48a0, Offset: 0x4270
// Size: 0xd8
function function_21fc375(v_origin, var_71f5107e, var_c4cc7f40, var_975b0849, var_4071777f) {
    if (!isdefined(var_975b0849)) {
        var_975b0849 = 64;
    }
    if (!isdefined(var_4071777f)) {
        var_4071777f = 256;
    }
    var_feed8b5b = 0;
    var_1c445caf = randomintrange(var_71f5107e, var_c4cc7f40);
    var_1e7e1004 = 360 / var_1c445caf;
    for (i = 0; i < var_1c445caf; i++) {
        var_feed8b5b += var_1e7e1004;
    }
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x5ca2d656, Offset: 0x4350
// Size: 0x24e
function function_f38a6a2a(var_8661a082) {
    var_c9a88def = struct::get_array("cursetrap_point", "targetname");
    var_c9a88def = array::randomize(var_c9a88def);
    var_9e546be = [];
    var_5543272f = [];
    for (i = 0; i < var_c9a88def.size; i++) {
        if (isdefined(var_c9a88def[i].active) && var_c9a88def[i].active) {
            if (!isdefined(var_9e546be)) {
                var_9e546be = [];
            } else if (!isarray(var_9e546be)) {
                var_9e546be = array(var_9e546be);
            }
            var_9e546be[var_9e546be.size] = var_c9a88def[i];
            continue;
        }
        if (!isdefined(var_5543272f)) {
            var_5543272f = [];
        } else if (!isarray(var_5543272f)) {
            var_5543272f = array(var_5543272f);
        }
        var_5543272f[var_5543272f.size] = var_c9a88def[i];
    }
    var_e1b2953e = var_9e546be.size;
    n_diff = var_8661a082 - var_e1b2953e;
    var_4162cc72 = abs(n_diff);
    for (i = 0; i < var_4162cc72; i++) {
        if (n_diff > 0) {
            var_5543272f[i].active = 1;
            continue;
        }
        if (n_diff < 0) {
            var_9e546be[i].active = 0;
        }
    }
}

// Namespace zm_zod_shadowman
// Params 0, eflags: 0x1 linked
// Checksum 0xaabaf6a, Offset: 0x45a8
// Size: 0x1d0
function function_6ceb834f() {
    level notify(#"hash_6ceb834f");
    level endon(#"hash_6ceb834f");
    var_c9a88def = struct::get_array("cursetrap_point", "targetname");
    while (true) {
        foreach (var_c2099ecc in var_c9a88def) {
            if (isdefined(var_c2099ecc.active) && var_c2099ecc.active && function_ab84e253(var_c2099ecc.origin, 1024)) {
                if (!isdefined(var_c2099ecc.var_7a88c258)) {
                    var_c2099ecc thread function_ada13668(var_c2099ecc.origin, undefined, 1, 1);
                }
                continue;
            }
            if (isdefined(var_c2099ecc.var_7a88c258)) {
                if (isdefined(var_c2099ecc.var_7a88c258.trigger)) {
                    var_c2099ecc.var_7a88c258.trigger delete();
                }
                var_c2099ecc.var_7a88c258 delete();
            }
        }
        wait 0.1;
    }
}

// Namespace zm_zod_shadowman
// Params 2, eflags: 0x1 linked
// Checksum 0x6b5c245, Offset: 0x4780
// Size: 0xda
function function_ab84e253(v_origin, n_radius) {
    var_5a3ad5d6 = n_radius * n_radius;
    foreach (player in level.activeplayers) {
        if (isdefined(player) && distance2dsquared(player.origin, v_origin) <= var_5a3ad5d6) {
            return true;
        }
    }
    return false;
}

// Namespace zm_zod_shadowman
// Params 4, eflags: 0x1 linked
// Checksum 0xaa58c142, Offset: 0x4868
// Size: 0x20a
function function_ada13668(v_origin, n_duration, var_23217d90, var_526fc172) {
    if (!isdefined(var_526fc172)) {
        var_526fc172 = 0;
    }
    if (var_526fc172) {
        while (function_ab84e253(v_origin, 64)) {
            wait 1;
        }
    }
    if (var_23217d90) {
        self.var_7a88c258 = spawn("script_model", v_origin);
        self.var_7a88c258.angles = (-90, 0, 0);
        self.var_7a88c258 setmodel("tag_origin");
        self.var_7a88c258 clientfield::set("cursetrap_fx", 1);
        self.var_7a88c258 thread function_48fccb59(self);
        return;
    }
    if (!isdefined(n_duration)) {
        n_duration = randomfloatrange(2, 5);
    }
    var_7a88c258 = spawn("script_model", v_origin);
    var_7a88c258.angles = (-90, 0, 0);
    var_7a88c258 setmodel("tag_origin");
    var_7a88c258 clientfield::set("mini_cursetrap_fx", 1);
    var_7a88c258 thread function_57b55fe1(n_duration);
    var_7a88c258 thread function_48fccb59();
    return var_7a88c258;
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x5 linked
// Checksum 0x12eb2ac, Offset: 0x4a80
// Size: 0x5c
function private function_57b55fe1(n_duration) {
    wait n_duration;
    if (isdefined(self)) {
        if (isdefined(self.trigger)) {
            self.trigger delete();
        }
        self delete();
    }
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x4
// Checksum 0x664fe7c0, Offset: 0x4ae8
// Size: 0xcc
function private function_d5ce1233(player) {
    level endon(#"hash_a881e3fa");
    level endon(#"hash_82a23c03");
    self endon(#"hash_37a7e986");
    v_origin = self.origin;
    while (isdefined(player)) {
        angles = vectortoangles(player.origin - v_origin);
        n_yaw = angles[1];
        self.angles = (self.angles[0], n_yaw, self.angles[2]);
        wait 0.1;
    }
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x5 linked
// Checksum 0x5f3725f6, Offset: 0x4bc0
// Size: 0x1a2
function private function_48fccb59(var_7478a6b4) {
    if (!isdefined(var_7478a6b4)) {
        var_7478a6b4 = undefined;
    }
    if (isdefined(var_7478a6b4)) {
        self.trigger = spawn("trigger_radius", self.origin, 2, 40, 50);
    } else {
        self.trigger = spawn("trigger_radius", self.origin, 2, 20, 25);
    }
    while (isdefined(self)) {
        guy = self.trigger waittill(#"trigger");
        if (isdefined(self)) {
            playfx(level._effect["cursetrap_explosion"], self.origin);
            guy playsound("zmb_zod_cursed_landmine_explode");
            guy dodamage(guy.health / 2, guy.origin, self, self);
            if (isdefined(var_7478a6b4)) {
                var_7478a6b4.active = 0;
            }
            if (isdefined(self.trigger)) {
                self.trigger delete();
            }
            self delete();
            return;
        }
    }
}

// Namespace zm_zod_shadowman
// Params 2, eflags: 0x4
// Checksum 0x2be6cb65, Offset: 0x4d70
// Size: 0xcc
function private function_9cfe9b22(v_origin, v_target) {
    e_fx = zm_zod_util::function_6c995606(v_origin, (0, 0, 0));
    e_fx clientfield::set("zod_egg_soul", 1);
    e_fx moveto(v_target, 1);
    e_fx waittill(#"movedone");
    wait 0.25;
    e_fx clientfield::set("zod_egg_soul", 0);
    e_fx zm_zod_util::function_44a841();
}

/#

    // Namespace zm_zod_shadowman
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb559a73f, Offset: 0x4e48
    // Size: 0x7c
    function function_e4f74672() {
        level thread zm_zod_util::function_72260d3a("<dev string:x28>", "<dev string:x4a>", 1, &function_7b5a1720);
        level thread zm_zod_util::function_72260d3a("<dev string:x66>", "<dev string:x8a>", 1, &function_b5732f4d);
    }

#/

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x67c08855, Offset: 0x4ed0
// Size: 0xc
function function_7b5a1720(n_val) {
    
}

// Namespace zm_zod_shadowman
// Params 1, eflags: 0x1 linked
// Checksum 0x908703dc, Offset: 0x4ee8
// Size: 0x74
function function_b5732f4d(n_val) {
    player = getplayers()[0];
    v_origin = player getorigin();
    function_ada13668(v_origin, undefined, 0);
}

