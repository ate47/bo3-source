#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_powerup_zombie_blood;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_tomb_main_quest;
#using scripts/zm/zm_tomb_utility;

#namespace zm_tomb_dig;

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0x85f87348, Offset: 0x798
// Size: 0x444
function function_301fce17() {
    callback::on_connect(&function_98ef478d);
    var_8413e7ff = struct::get_array("shovel_location", "targetname");
    var_97b40f81 = [];
    foreach (var_3fd86715 in var_8413e7ff) {
        if (!isdefined(var_97b40f81[var_3fd86715.script_noteworthy])) {
            var_97b40f81[var_3fd86715.script_noteworthy] = [];
        }
        var_97b40f81[var_3fd86715.script_noteworthy][var_97b40f81[var_3fd86715.script_noteworthy].size] = var_3fd86715;
    }
    foreach (var_6782a127 in var_97b40f81) {
        s_pos = var_6782a127[randomint(var_6782a127.size)];
        var_72842580 = spawn("script_model", s_pos.origin);
        var_72842580.angles = s_pos.angles;
        var_72842580 setmodel("p7_zm_ori_tool_shovel");
        function_f1c57a23(var_72842580);
    }
    level.get_player_perk_purchase_limit = &get_player_perk_purchase_limit;
    level.bonus_points_powerup_override = &bonus_points_powerup_override;
    level thread function_90a38237();
    level thread function_ab43eca6();
    clientfield::register("world", "player0hasItem", 15000, 2, "int");
    clientfield::register("world", "player1hasItem", 15000, 2, "int");
    clientfield::register("world", "player2hasItem", 15000, 2, "int");
    clientfield::register("world", "player3hasItem", 15000, 2, "int");
    clientfield::register("world", "player0wearableItem", 15000, 1, "int");
    clientfield::register("world", "player1wearableItem", 15000, 1, "int");
    clientfield::register("world", "player2wearableItem", 15000, 1, "int");
    clientfield::register("world", "player3wearableItem", 15000, 1, "int");
    /#
        level thread function_9b933c6a();
    #/
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0x5e0d2742, Offset: 0xbe8
// Size: 0x6a
function function_98ef478d() {
    self.var_b5843b10["has_shovel"] = 0;
    self.var_b5843b10["has_upgraded_shovel"] = 0;
    self.var_b5843b10["has_helmet"] = 0;
    self.var_b5843b10["n_spots_dug"] = 0;
    self.var_b5843b10["n_losing_streak"] = 0;
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x5e6c7c48, Offset: 0xc60
// Size: 0x174
function function_f1c57a23(var_cd807478) {
    s_unitrigger_stub = spawnstruct();
    s_unitrigger_stub.origin = var_cd807478.origin + (0, 0, 32);
    s_unitrigger_stub.angles = var_cd807478.angles;
    s_unitrigger_stub.radius = 32;
    s_unitrigger_stub.script_length = 64;
    s_unitrigger_stub.script_width = 64;
    s_unitrigger_stub.script_height = 64;
    s_unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_unitrigger_stub.hint_string = %ZM_TOMB_SHPU;
    s_unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_unitrigger_stub.require_look_at = 1;
    s_unitrigger_stub.prompt_and_visibility_func = &function_c18c3a9e;
    s_unitrigger_stub.var_cd807478 = var_cd807478;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger_stub, 1);
    zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, &function_6161d0f4);
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x80578424, Offset: 0xde0
// Size: 0x80
function function_c18c3a9e(e_player) {
    can_use = self.stub function_70fb5f53(e_player);
    self setinvisibletoplayer(e_player, !can_use);
    self sethintstring(self.stub.hint_string);
    return can_use;
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x935185e9, Offset: 0xe68
// Size: 0x84
function function_70fb5f53(e_player) {
    if (!self function_5a0def14(e_player)) {
        return false;
    }
    self.hint_string = %ZM_TOMB_SHPU;
    if (isdefined(e_player.var_b5843b10["has_shovel"]) && e_player.var_b5843b10["has_shovel"]) {
        self.hint_string = %ZM_TOMB_SHAG;
    }
    return true;
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x6331cccc, Offset: 0xef8
// Size: 0x20
function function_6e5f017f(n_player) {
    return "player" + n_player + "wearableItem";
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x98b627ca, Offset: 0xf20
// Size: 0x20
function function_f4768ce9(n_player) {
    return "player" + n_player + "hasItem";
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0xb7cf3e99, Offset: 0xf48
// Size: 0x1a0
function function_6161d0f4() {
    self endon(#"kill_trigger");
    while (true) {
        self waittill(#"trigger", e_player);
        if (e_player != self.parent_player) {
            continue;
        }
        if (!(isdefined(e_player.var_b5843b10["has_shovel"]) && e_player.var_b5843b10["has_shovel"])) {
            e_player.var_b5843b10["has_shovel"] = 1;
            e_player playsound("zmb_craftable_pickup");
            e_player function_45218586("pickup_shovel");
            n_player = e_player getentitynumber();
            level clientfield::set(function_f4768ce9(n_player), 1);
            e_player thread function_4230e348(n_player, self.stub.var_cd807478.origin, self.stub.var_cd807478.angles);
            self.stub.var_cd807478 delete();
            zm_unitrigger::unregister_unitrigger(self.stub);
        }
    }
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x8b946a8c, Offset: 0x10f0
// Size: 0x54
function function_45218586(str_category) {
    if (!(isdefined(self.var_8923b68d) && self.var_8923b68d)) {
        self zm_utility::do_player_general_vox("digging", str_category);
        if (str_category != "pickup_shovel") {
        }
    }
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0x24696cc3, Offset: 0x1150
// Size: 0x2a
function function_6ca8f779() {
    self endon(#"disconnect");
    self.var_8923b68d = 1;
    wait 60;
    self.var_8923b68d = undefined;
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x173d21e2, Offset: 0x1188
// Size: 0x40
function function_5a0def14(e_player) {
    if (!zombie_utility::is_player_valid(e_player)) {
        self.hint_string = "";
        return false;
    }
    return true;
}

// Namespace zm_tomb_dig
// Params 3, eflags: 0x0
// Checksum 0x6fcfa9a7, Offset: 0x11d0
// Size: 0xf4
function function_4230e348(n_player, v_origin, v_angles) {
    self waittill(#"disconnect");
    level clientfield::set(function_f4768ce9(n_player), 0);
    level clientfield::set(function_6e5f017f(n_player), 0);
    var_72842580 = spawn("script_model", v_origin);
    var_72842580.angles = v_angles;
    var_72842580 setmodel("p7_zm_ori_tool_shovel");
    function_f1c57a23(var_72842580);
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0xf0649b6d, Offset: 0x12d0
// Size: 0x294
function function_ab43eca6() {
    while (!level flag::exists("start_zombie_round_logic")) {
        wait 0.5;
    }
    level flag::wait_till("start_zombie_round_logic");
    level.var_270d6825 = 0;
    level.var_59ff1fb1 = 15;
    level.var_aa00b64d = struct::get_array("dig_spot", "targetname");
    foreach (var_49a9ddf8 in level.var_aa00b64d) {
        if (!isdefined(var_49a9ddf8.angles)) {
            var_49a9ddf8.angles = (0, 0, 0);
        }
        if (isdefined(var_49a9ddf8.script_noteworthy) && var_49a9ddf8.script_noteworthy == "initial_spot") {
            var_49a9ddf8 thread function_b312418a();
        } else {
            var_49a9ddf8.dug = 1;
        }
        var_49a9ddf8.str_zone = zm_zonemgr::get_zone_from_position(var_49a9ddf8.origin + (0, 0, 32), 1);
        if (!isdefined(var_49a9ddf8.str_zone)) {
            var_49a9ddf8.str_zone = "";
            assertmsg("<dev string:x28>" + var_49a9ddf8.origin[0] + "<dev string:x37>" + var_49a9ddf8.origin[1] + "<dev string:x37>" + var_49a9ddf8.origin[2] + "<dev string:x3a>");
        }
        util::wait_network_frame();
    }
    level thread function_496b8f6c();
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x149275df, Offset: 0x1570
// Size: 0x3e6
function function_496b8f6c(var_aa00b64d) {
    while (true) {
        level waittill(#"end_of_round");
        wait 2;
        var_aa00b64d = array::randomize(level.var_aa00b64d);
        var_d426d15b = 0;
        var_bbb1e95c = 3;
        if (level.var_c95eeed7 > 0) {
            var_bbb1e95c = 0;
        } else if (level.var_aa00c190 > 0) {
            var_bbb1e95c = 5;
        }
        if (level.var_c95eeed7 == 0) {
            var_bbb1e95c += randomint(getplayers().size);
        }
        for (i = 0; i < var_aa00b64d.size; i++) {
            if (isdefined(var_aa00b64d[i].dug) && var_aa00b64d[i].dug && var_d426d15b < var_bbb1e95c && level.var_270d6825 <= level.var_59ff1fb1) {
                var_aa00b64d[i].dug = undefined;
                var_aa00b64d[i] thread function_b312418a();
                util::wait_network_frame();
                var_d426d15b++;
            }
        }
        if (level.var_c95eeed7 > 0 && level.var_e435840d.size > 0) {
            foreach (s_staff in level.var_e435840d) {
                var_8239193f = [];
                var_37838c3f = 0;
                foreach (var_49a9ddf8 in level.var_aa00b64d) {
                    if (isdefined(var_49a9ddf8.str_zone) && issubstr(var_49a9ddf8.str_zone, s_staff.var_1df7b389)) {
                        if (!(isdefined(var_49a9ddf8.dug) && var_49a9ddf8.dug)) {
                            var_37838c3f++;
                            continue;
                        }
                        var_8239193f[var_8239193f.size] = var_49a9ddf8;
                    }
                }
                if (var_37838c3f < 2 && var_8239193f.size > 0 && level.var_270d6825 <= level.var_59ff1fb1) {
                    n_index = randomint(var_8239193f.size);
                    var_8239193f[n_index].dug = undefined;
                    var_8239193f[n_index] thread function_b312418a();
                    arrayremoveindex(var_8239193f, n_index);
                    var_37838c3f++;
                    util::wait_network_frame();
                }
            }
        }
    }
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0x67fbbdfe, Offset: 0x1960
// Size: 0x176
function function_b312418a() {
    level.var_270d6825++;
    self.var_2ec61a03 = spawn("script_model", self.origin + (0, 0, -40));
    self.var_2ec61a03 setmodel("p7_zm_ori_dig_mound");
    self.var_2ec61a03.angles = self.angles;
    self.var_2ec61a03 moveto(self.origin, 3, 0, 1);
    self.var_2ec61a03 waittill(#"movedone");
    var_ca89ebbe = zm_tomb_utility::function_52854313(self.origin + (0, 0, 20), 100, 1);
    var_ca89ebbe.prompt_and_visibility_func = &function_17652aca;
    var_ca89ebbe.require_look_at = 1;
    var_ca89ebbe function_dc288ebe(self);
    zm_unitrigger::unregister_unitrigger(var_ca89ebbe);
    var_ca89ebbe = undefined;
    self.var_2ec61a03 delete();
    self.var_2ec61a03 = undefined;
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0xf1e4ae98, Offset: 0x1ae0
// Size: 0x80
function function_17652aca(player) {
    if (isdefined(player.var_b5843b10["has_shovel"]) && player.var_b5843b10["has_shovel"]) {
        self sethintstring(%ZM_TOMB_X2D);
    } else {
        self sethintstring(%ZM_TOMB_NS);
    }
    return true;
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x5b05c3f9, Offset: 0x1b68
// Size: 0x4e2
function function_dc288ebe(var_49a9ddf8) {
    while (true) {
        self waittill(#"trigger", player);
        if (isdefined(player.var_b5843b10["has_shovel"]) && player.var_b5843b10["has_shovel"]) {
            player playsound("evt_dig");
            var_49a9ddf8.dug = 1;
            level.var_270d6825--;
            playfx(level._effect["digging"], self.origin);
            player clientfield::set_to_player("player_rumble_and_shake", 1);
            var_bcda0488 = var_49a9ddf8 zm_tomb_main_quest::function_56ba198b(player);
            if (isdefined(var_bcda0488)) {
                var_bcda0488 zm_tomb_main_quest::function_906dacba(self.origin);
                player function_45218586("dig_staff_part");
            } else {
                var_84fb2cde = 50;
                if (player.var_b5843b10["n_spots_dug"] == 0 || player.var_b5843b10["n_losing_streak"] == 3) {
                    player.var_b5843b10["n_losing_streak"] = 0;
                    var_84fb2cde = 100;
                }
                if (player.var_b5843b10["has_upgraded_shovel"]) {
                    if (!player.var_b5843b10["has_helmet"]) {
                        var_fc09e4ff = randomint(100);
                        if (var_fc09e4ff >= 95) {
                            player.var_b5843b10["has_helmet"] = 1;
                            level clientfield::set(function_6e5f017f(player getentitynumber()), 1);
                            player playsoundtoplayer("zmb_squest_golden_anything", player);
                            player thread function_85eef9f2();
                            return;
                        }
                    }
                    var_84fb2cde = 70;
                }
                var_9eb94556 = randomint(100);
                if (var_9eb94556 > var_84fb2cde) {
                    if (math::cointoss()) {
                        player function_45218586("dig_grenade");
                        self thread function_dd7a9aae(player);
                    } else {
                        player function_45218586("dig_zombie");
                        self thread function_56cd0bc2(player, var_49a9ddf8);
                    }
                    player.var_b5843b10["n_losing_streak"]++;
                } else if (math::cointoss()) {
                    self thread function_86d04e30(player);
                } else {
                    player function_45218586("dig_gun");
                    self thread function_e07a8850(player);
                }
            }
            if (!player.var_b5843b10["has_upgraded_shovel"]) {
                player.var_b5843b10["n_spots_dug"]++;
                if (player.var_b5843b10["n_spots_dug"] >= 30) {
                    player.var_b5843b10["has_upgraded_shovel"] = 1;
                    player thread function_b54a2b0();
                    level clientfield::set(function_f4768ce9(player getentitynumber()), 2);
                    player playsoundtoplayer("zmb_squest_golden_anything", player);
                }
            }
            return;
        }
    }
}

// Namespace zm_tomb_dig
// Params 2, eflags: 0x0
// Checksum 0xdb0cb10e, Offset: 0x2058
// Size: 0x1d4
function function_56cd0bc2(player, var_49a9ddf8) {
    ai_zombie = zombie_utility::spawn_zombie(level.var_55b27a6d[0]);
    ai_zombie endon(#"death");
    ai_zombie ghost();
    var_e0d020c4 = spawn("script_origin", (0, 0, 0));
    var_e0d020c4.origin = ai_zombie.origin;
    var_e0d020c4.angles = ai_zombie.angles;
    ai_zombie linkto(var_e0d020c4);
    var_e0d020c4 moveto(player.origin + (100, 100, 0), 0.1);
    var_e0d020c4 waittill(#"movedone");
    ai_zombie unlink();
    var_e0d020c4 delete();
    ai_zombie show();
    ai_zombie playsound("evt_zombie_dig_dirt");
    ai_zombie zm_tomb_utility::function_83fc6b30(var_49a9ddf8);
    find_flesh_struct_string = "find_flesh";
    ai_zombie notify(#"zombie_custom_think_done", find_flesh_struct_string);
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x1b260c8b, Offset: 0x2238
// Size: 0x274
function function_86d04e30(player) {
    powerup = spawn("script_model", self.origin);
    powerup endon(#"powerup_grabbed");
    powerup endon(#"powerup_timedout");
    var_5b8972c7 = function_66bb8c3f(player);
    var_1695340f = undefined;
    if (level.var_9094dd9b + level.powerup_drop_count > 4 || level.var_3f7b7ff2 || var_5b8972c7.size == 0 || randomint(100) < 80) {
        if (level.var_98caa660 < 1 && randomint(100) > 70) {
            var_1695340f = "bonus_points_player";
            player function_45218586("dig_cash");
        } else {
            var_1695340f = "bonus_points_player";
            player function_45218586("dig_cash");
        }
        level.var_3f7b7ff2 = 0;
    } else {
        var_1695340f = var_5b8972c7[randomint(var_5b8972c7.size)];
        level.var_3f7b7ff2 = 1;
        level.var_9094dd9b++;
        player function_45218586("dig_powerup");
        function_637de0(var_1695340f);
    }
    powerup zm_powerups::powerup_setup(var_1695340f);
    powerup movez(40, 0.6);
    powerup waittill(#"movedone");
    powerup thread zm_powerups::powerup_timeout();
    powerup thread zm_powerups::powerup_wobble();
    powerup thread zm_powerups::powerup_grab();
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0xc760e6e0, Offset: 0x24b8
// Size: 0x204
function function_66bb8c3f(player) {
    var_5b8972c7 = [];
    var_d5b49dcc = array("nuke", "double_points");
    if (level.var_99a26965 && !function_c1d45c78("fire_sale")) {
        if (!isdefined(var_d5b49dcc)) {
            var_d5b49dcc = [];
        } else if (!isarray(var_d5b49dcc)) {
            var_d5b49dcc = array(var_d5b49dcc);
        }
        var_d5b49dcc[var_d5b49dcc.size] = "fire_sale";
    }
    if (player.var_b5843b10["has_upgraded_shovel"]) {
        var_d5b49dcc = arraycombine(var_d5b49dcc, array("insta_kill", "full_ammo"), 0, 0);
    }
    foreach (powerup in var_d5b49dcc) {
        if (!function_c1d45c78(powerup)) {
            if (!isdefined(var_5b8972c7)) {
                var_5b8972c7 = [];
            } else if (!isarray(var_5b8972c7)) {
                var_5b8972c7 = array(var_5b8972c7);
            }
            var_5b8972c7[var_5b8972c7.size] = powerup;
        }
    }
    return var_5b8972c7;
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x8c19a444, Offset: 0x26c8
// Size: 0x124
function function_dd7a9aae(player) {
    player endon(#"disconnect");
    v_spawnpt = self.origin;
    w_grenade = getweapon("frag_grenade");
    n_rand = randomintrange(0, 4);
    player magicgrenadetype(w_grenade, v_spawnpt, (0, 0, 300), 3);
    player playsound("evt_grenade_digup");
    if (n_rand) {
        wait 0.3;
        if (math::cointoss()) {
            player magicgrenadetype(w_grenade, v_spawnpt, (50, 50, 300), 3);
        }
    }
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0xe2e9372c, Offset: 0x27f8
// Size: 0x4e8
function function_e07a8850(digger) {
    var_43f586fe = array(getweapon("pistol_c96"), getweapon("ar_marksman"), getweapon("shotgun_pump"));
    var_63eba41d = array(getweapon("sniper_fastsemi"), getweapon("shotgun_fullauto"));
    if (digger.var_b5843b10["has_upgraded_shovel"]) {
        var_63eba41d = arraycombine(var_63eba41d, array(getweapon("bouncingbetty"), getweapon("ar_stg44"), getweapon("smg_standard"), getweapon("smg_mp40_1940"), getweapon("shotgun_precision")), 0, 0);
    }
    var_59d5868d = undefined;
    if (randomint(100) < 90) {
        var_59d5868d = var_43f586fe[getarraykeys(var_43f586fe)[randomint(getarraykeys(var_43f586fe).size)]];
    } else {
        var_59d5868d = var_63eba41d[getarraykeys(var_63eba41d)[randomint(getarraykeys(var_63eba41d).size)]];
    }
    v_spawnpt = self.origin + (0, 0, 40);
    var_f8c6b1d7 = (0, 0, 0);
    v_angles = digger getplayerangles();
    v_angles = (0, v_angles[1], 0) + (0, 90, 0) + var_f8c6b1d7;
    m_weapon = zm_utility::spawn_buildkit_weapon_model(digger, var_59d5868d, undefined, v_spawnpt, v_angles);
    m_weapon.angles = v_angles;
    m_weapon playloopsound("evt_weapon_digup");
    m_weapon thread timer_til_despawn(v_spawnpt, 40 * -1);
    m_weapon endon(#"hash_8bc1969d");
    playfxontag(level._effect["powerup_on_solo"], m_weapon, "tag_origin");
    m_weapon.trigger = zm_tomb_utility::function_52854313(v_spawnpt, 100, 1, undefined, &function_3674f451);
    m_weapon.trigger.cursor_hint = "HINT_WEAPON";
    m_weapon.trigger.cursor_hint_weapon = var_59d5868d;
    m_weapon.trigger waittill(#"trigger", player);
    m_weapon.trigger notify(#"weapon_grabbed");
    m_weapon.trigger thread swap_weapon(var_59d5868d, player);
    if (isdefined(m_weapon.trigger)) {
        zm_unitrigger::unregister_unitrigger(m_weapon.trigger);
        m_weapon.trigger = undefined;
    }
    if (isdefined(m_weapon)) {
        m_weapon delete();
    }
    if (player != digger) {
        digger notify(#"hash_f8352f34");
    }
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x701ba388, Offset: 0x2ce8
// Size: 0xc8
function function_3674f451(player) {
    if (!zm_utility::is_player_valid(player) || player.is_drinking > 0 || !player zm_magicbox::can_buy_weapon() || player bgb::is_enabled("zm_bgb_disorderly_combat")) {
        self setcursorhint("HINT_NOICON");
        return false;
    }
    self setcursorhint("HINT_WEAPON", self.stub.cursor_hint_weapon);
    return true;
}

// Namespace zm_tomb_dig
// Params 2, eflags: 0x0
// Checksum 0xb991ddcf, Offset: 0x2db8
// Size: 0x224
function swap_weapon(var_375664a9, e_player) {
    w_current_weapon = e_player getcurrentweapon();
    if (isdefined(e_player.is_drinking) && (!zombie_utility::is_player_valid(e_player) || e_player.is_drinking) || zm_utility::is_placeable_mine(w_current_weapon) || zm_equipment::is_equipment(w_current_weapon) || w_current_weapon == getweapon("none") || e_player zm_equipment::hacker_active()) {
        return;
    }
    if (isdefined(level.var_670d761f) && level.var_670d761f == w_current_weapon) {
        return;
    }
    var_6c6831af = e_player getweaponslist(1);
    foreach (weapon in var_6c6831af) {
        w_base = zm_weapons::get_base_weapon(weapon);
        w_upgraded = zm_weapons::get_upgrade_weapon(weapon);
        if (var_375664a9 === w_base || var_375664a9 === w_upgraded) {
            e_player givemaxammo(weapon);
            return;
        }
    }
    e_player zm_weapons::weapon_give(var_375664a9);
}

// Namespace zm_tomb_dig
// Params 2, eflags: 0x0
// Checksum 0x6cda5db3, Offset: 0x2fe8
// Size: 0xc4
function timer_til_despawn(v_float, n_dist) {
    self endon(#"weapon_grabbed");
    putbacktime = 12;
    self movez(n_dist, putbacktime, putbacktime * 0.5);
    self waittill(#"movedone");
    self notify(#"hash_8bc1969d");
    if (isdefined(self.trigger)) {
        zm_unitrigger::unregister_unitrigger(self.trigger);
        self.trigger = undefined;
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0x9cb32c30, Offset: 0x30b8
// Size: 0x1e
function get_player_perk_purchase_limit() {
    if (isdefined(self.var_53690301)) {
        return self.var_53690301;
    }
    return level.perk_purchase_limit;
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0x138f3c2b, Offset: 0x30e0
// Size: 0x38
function function_83ea9c03() {
    if (!isdefined(self.var_53690301)) {
        self.var_53690301 = level.perk_purchase_limit;
    }
    if (self.var_53690301 < 8) {
        self.var_53690301++;
    }
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0xe9851fdc, Offset: 0x3120
// Size: 0x23c
function function_b54a2b0() {
    self endon(#"disconnect");
    var_b32befc9 = 0;
    var_f5b0e4f3 = struct::get_array("zombie_blood_dig_spot", "targetname");
    self.var_9df04ef0 = spawn("trigger_radius_use", (0, 0, 0), 0, 100, 50);
    self.var_9df04ef0.e_unique_player = self;
    self.var_9df04ef0 triggerignoreteam();
    self.var_9df04ef0 setcursorhint("HINT_NOICON");
    self.var_9df04ef0 sethintstring(%ZM_TOMB_X2D);
    self.var_9df04ef0 zm_powerup_zombie_blood::make_zombie_blood_entity();
    while (var_b32befc9 < 4) {
        var_ff5371a6 = array::randomize(var_f5b0e4f3);
        n_index = undefined;
        for (i = 0; i < var_ff5371a6.size; i++) {
            if (!isdefined(var_ff5371a6[i].n_player)) {
                n_index = i;
                break;
            }
        }
        assert(isdefined(n_index), "<dev string:x4e>");
        var_19925afe = var_ff5371a6[n_index];
        var_19925afe.n_player = self getentitynumber();
        var_19925afe function_39402525(self);
        var_b32befc9++;
        level waittill(#"end_of_round");
    }
    self.var_9df04ef0 delete();
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0x4672b3de, Offset: 0x3368
// Size: 0x13a
function function_ebcc8c45() {
    self waittill(#"disconnect");
    if (isdefined(self.var_9df04ef0)) {
        self.var_9df04ef0 delete();
    }
    var_f5b0e4f3 = struct::get_array("zombie_blood_dig_spot", "targetname");
    foreach (s_pos in var_f5b0e4f3) {
        if (isdefined(s_pos.n_player) && s_pos.n_player == self getentitynumber()) {
            s_pos.n_player = undefined;
        }
        if (isdefined(s_pos.var_2ec61a03)) {
            s_pos delete();
        }
    }
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0xdffd28f4, Offset: 0x34b0
// Size: 0x17e
function function_39402525(e_player) {
    self.var_2ec61a03 = spawn("script_model", self.origin + (0, 0, -40));
    self.var_2ec61a03.angles = self.angles;
    self.var_2ec61a03 setmodel("p7_zm_ori_dig_mound_blood");
    self.var_2ec61a03 zm_powerup_zombie_blood::make_zombie_blood_entity();
    self.var_2ec61a03 moveto(self.origin, 3, 0, 1);
    self.var_2ec61a03 waittill(#"movedone");
    self.var_2ec61a03.e_unique_player = e_player;
    /#
        self thread zm_tomb_utility::function_5de0d079("<dev string:x84>", (0, 0, 255), self.origin);
    #/
    e_player.var_9df04ef0.origin = self.origin + (0, 0, 20);
    e_player.var_9df04ef0 function_8a8fa1f8(self);
    /#
        self notify(#"stop_debug_position");
    #/
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0xb992617b, Offset: 0x3638
// Size: 0x11a
function function_8a8fa1f8(var_49a9ddf8) {
    self endon(#"death");
    while (true) {
        self waittill(#"trigger", player);
        if (isdefined(player.var_b5843b10["has_shovel"]) && player.var_b5843b10["has_shovel"]) {
            player.var_9df04ef0.origin = (0, 0, 0);
            player playsound("evt_dig");
            playfx(level._effect["digging"], self.origin);
            var_49a9ddf8.var_2ec61a03 delete();
            function_d292630f(var_49a9ddf8.origin, player);
            return;
        }
    }
}

// Namespace zm_tomb_dig
// Params 2, eflags: 0x0
// Checksum 0x13c99067, Offset: 0x3760
// Size: 0x21c
function function_d292630f(v_origin, e_player) {
    var_e8463385 = spawn("script_model", v_origin + (0, 0, 40));
    var_e8463385 setmodel("zombie_pickup_perk_bottle");
    var_e8463385.angles = (10, 0, 0);
    var_e8463385 setinvisibletoall();
    var_e8463385 setvisibletoplayer(e_player);
    m_fx = spawn("script_model", var_e8463385.origin);
    m_fx setmodel("tag_origin");
    m_fx setinvisibletoall();
    m_fx setvisibletoplayer(e_player);
    playfxontag(level._effect["special_glow"], m_fx, "tag_origin");
    var_e8463385 linkto(m_fx);
    m_fx thread function_7d28e149();
    while (isdefined(e_player) && !e_player istouching(var_e8463385)) {
        wait 0.05;
    }
    var_e8463385 delete();
    m_fx delete();
    if (isdefined(e_player)) {
        e_player function_83ea9c03();
    }
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0xb16f96ab, Offset: 0x3988
// Size: 0x44
function function_7d28e149() {
    self endon(#"death");
    while (true) {
        self rotateyaw(360, 5);
        self waittill(#"rotatedone");
    }
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0x87d54cb5, Offset: 0x39d8
// Size: 0x32
function bonus_points_powerup_override() {
    points = randomintrange(1, 6) * 50;
    return points;
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0x63cef0cc, Offset: 0x3a18
// Size: 0xf8
function function_90a38237() {
    level endon(#"end_game");
    level.var_90a38237 = [];
    level.var_99a26965 = 0;
    level.var_3f7b7ff2 = 0;
    level.var_98caa660 = 0;
    level.var_9094dd9b = 0;
    while (true) {
        level waittill(#"end_of_round");
        foreach (str_powerup, value in level.var_90a38237) {
            level.var_90a38237[str_powerup] = 0;
        }
        level.var_98caa660 = 0;
        level.var_9094dd9b = 0;
    }
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0x2389e47c, Offset: 0x3b18
// Size: 0x3c
function function_c1d45c78(str_powerup) {
    if (!isdefined(level.var_90a38237[str_powerup])) {
        level.var_90a38237[str_powerup] = 0;
    }
    return level.var_90a38237[str_powerup];
}

// Namespace zm_tomb_dig
// Params 1, eflags: 0x0
// Checksum 0xc0b4b9e, Offset: 0x3b60
// Size: 0x1e
function function_637de0(str_powerup) {
    level.var_90a38237[str_powerup] = 1;
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0xfd0560c9, Offset: 0x3b88
// Size: 0xcc
function function_85eef9f2() {
    if (!isdefined(self.var_8e065802)) {
        self.var_8e065802 = spawnstruct();
    }
    self.var_8e065802.model = "c_t7_zm_dlchd_origins_golden_helmet";
    self.var_8e065802.tag = "j_head";
    self.var_ae07e72c = "golden_helmet";
    self attach(self.var_8e065802.model, self.var_8e065802.tag);
    if (self.characterindex == 1) {
        self setcharacterbodystyle(2);
    }
}

// Namespace zm_tomb_dig
// Params 0, eflags: 0x0
// Checksum 0x7259199e, Offset: 0x3c60
// Size: 0x2a4
function function_9b933c6a() {
    /#
        setdvar("<dev string:x86>", "<dev string:x92>");
        setdvar("<dev string:x96>", "<dev string:x92>");
        setdvar("<dev string:xa9>", "<dev string:x92>");
        setdvar("<dev string:xb5>", "<dev string:x92>");
        setdvar("<dev string:xc6>", "<dev string:x92>");
        setdvar("<dev string:xd7>", "<dev string:x92>");
        setdvar("<dev string:xe9>", "<dev string:x92>");
        setdvar("<dev string:xfc>", "<dev string:x92>");
        setdvar("<dev string:x10f>", "<dev string:x92>");
        setdvar("<dev string:x122>", "<dev string:x92>");
        adddebugcommand("<dev string:x133>");
        adddebugcommand("<dev string:x170>");
        adddebugcommand("<dev string:x1bb>");
        adddebugcommand("<dev string:x1f8>");
        adddebugcommand("<dev string:x23f>");
        adddebugcommand("<dev string:x286>");
        adddebugcommand("<dev string:x2cf>");
        adddebugcommand("<dev string:x30c>");
        adddebugcommand("<dev string:x349>");
        adddebugcommand("<dev string:x387>");
        level thread function_957042ca();
    #/
    level.var_aa00b64d = struct::get_array("dig_spot", "targetname");
    level.var_55b27a6d = getentarray("zombie_spawner_dig", "script_noteworthy");
}

/#

    // Namespace zm_tomb_dig
    // Params 0, eflags: 0x0
    // Checksum 0x33eb0ce1, Offset: 0x3f10
    // Size: 0xc80
    function function_957042ca() {
        while (true) {
            if (getdvarstring("<dev string:x122>") == "<dev string:x3c2>") {
                setdvar("<dev string:x122>", "<dev string:x92>");
                player = getplayers()[0];
                var_49a9ddf8 = arraygetclosest(player.origin, level.var_aa00b64d);
                level thread function_56cd0bc2(player, var_49a9ddf8);
            }
            if (getdvarstring("<dev string:x86>") == "<dev string:x3c2>") {
                setdvar("<dev string:x86>", "<dev string:x92>");
                foreach (player in getplayers()) {
                    player.var_b5843b10["<dev string:x3c5>"] = 1;
                    level clientfield::set(function_f4768ce9(player getentitynumber()), 1);
                }
            }
            if (getdvarstring("<dev string:x96>") == "<dev string:x3c2>") {
                setdvar("<dev string:x96>", "<dev string:x92>");
                foreach (player in getplayers()) {
                    player.var_b5843b10["<dev string:x3c5>"] = 1;
                    player.var_b5843b10["<dev string:x3d0>"] = 1;
                    player thread function_b54a2b0();
                    level clientfield::set(function_f4768ce9(player getentitynumber()), 2);
                }
            }
            if (getdvarstring("<dev string:xa9>") == "<dev string:x3c2>") {
                setdvar("<dev string:xa9>", "<dev string:x92>");
                foreach (player in getplayers()) {
                    player.var_b5843b10["<dev string:x3e4>"] = 1;
                    n_player = player getentitynumber() + 1;
                    level clientfield::set(function_6e5f017f(n_player - 1), 1);
                    player thread function_85eef9f2();
                }
            }
            if (getdvarstring("<dev string:xb5>") == "<dev string:x3c2>") {
                setdvar("<dev string:xb5>", "<dev string:x92>");
                var_aa00b64d = array::randomize(level.var_aa00b64d);
                for (i = 0; i < var_aa00b64d.size; i++) {
                    if (isdefined(var_aa00b64d[i].dug) && var_aa00b64d[i].dug && level.var_270d6825 <= level.var_59ff1fb1) {
                        var_aa00b64d[i].dug = undefined;
                        var_aa00b64d[i] thread function_b312418a();
                        util::wait_network_frame();
                    }
                }
            }
            if (getdvarstring("<dev string:xc6>") == "<dev string:x3c2>") {
                setdvar("<dev string:xc6>", "<dev string:x92>");
                var_aa00b64d = array::randomize(level.var_aa00b64d);
                for (i = 0; i < var_aa00b64d.size; i++) {
                    if (isdefined(var_aa00b64d[i].dug) && var_aa00b64d[i].dug) {
                        var_aa00b64d[i].dug = undefined;
                        var_aa00b64d[i] thread function_b312418a();
                        util::wait_network_frame();
                    }
                }
            }
            if (getdvarstring("<dev string:xd7>") == "<dev string:x3c2>") {
                setdvar("<dev string:xd7>", "<dev string:x92>");
                var_f5b0e4f3 = struct::get_array("<dev string:x3ef>", "<dev string:x405>");
                foreach (s_spot in var_f5b0e4f3) {
                    s_spot.var_2ec61a03 = spawn("<dev string:x410>", s_spot.origin + (0, 0, -40));
                    s_spot.var_2ec61a03.angles = s_spot.angles;
                    s_spot.var_2ec61a03 setmodel("<dev string:x41d>");
                    s_spot.var_2ec61a03 moveto(s_spot.origin, 3, 0, 1);
                    util::wait_network_frame();
                }
            }
            if (getdvarstring("<dev string:xe9>") == "<dev string:x3c2>") {
                setdvar("<dev string:xe9>", "<dev string:x92>");
                level.var_c95eeed7 = 0;
                level.var_aa00c190 = 5;
                level.var_43f919c6 = 1;
                level clientfield::set("<dev string:x437>", level.var_aa00c190);
                level clientfield::set("<dev string:x442>", level.var_c95eeed7);
                wait 1;
                foreach (player in getplayers()) {
                    if (zombie_utility::is_player_valid(player, 0, 1)) {
                        player zm_tomb_utility::function_c6592f0e();
                    }
                }
            }
            if (getdvarstring("<dev string:xfc>") == "<dev string:x3c2>") {
                setdvar("<dev string:xfc>", "<dev string:x92>");
                level.var_c95eeed7 = 5;
                level.var_aa00c190 = 0;
                level.var_43f919c6 = 2;
                level clientfield::set("<dev string:x437>", level.var_aa00c190);
                level clientfield::set("<dev string:x442>", level.var_c95eeed7);
                wait 1;
                foreach (player in getplayers()) {
                    if (zombie_utility::is_player_valid(player, 0, 1)) {
                        player zm_tomb_utility::function_c6592f0e();
                    }
                }
            }
            if (getdvarstring("<dev string:x10f>") == "<dev string:x3c2>") {
                setdvar("<dev string:x10f>", "<dev string:x92>");
                level.var_c95eeed7 = 0;
                level.var_aa00c190 = 0;
                level.var_43f919c6 = 3;
                level clientfield::set("<dev string:x437>", level.var_aa00c190);
                level clientfield::set("<dev string:x442>", level.var_c95eeed7);
                wait 1;
                foreach (player in getplayers()) {
                    if (zombie_utility::is_player_valid(player, 0, 1)) {
                        player zm_tomb_utility::function_c6592f0e();
                    }
                }
            }
            wait 0.05;
        }
    }

#/
