#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_keeper_skull;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;

#namespace zm_island_util;

// Namespace zm_island_util
// Params 4, eflags: 0x0
// Checksum 0xedfdab31, Offset: 0x3d0
// Size: 0x5a
function function_d095318(origin, radius, use_trigger, var_cd7edcab) {
    if (!isdefined(use_trigger)) {
        use_trigger = 0;
    }
    return function_a40fee2f(origin, undefined, radius, use_trigger, var_cd7edcab);
}

// Namespace zm_island_util
// Params 5, eflags: 0x4
// Checksum 0xb27fe2a0, Offset: 0x438
// Size: 0x1f8
function private function_a40fee2f(origin, angles, var_3b9cee11, use_trigger, var_cd7edcab) {
    if (!isdefined(use_trigger)) {
        use_trigger = 0;
    }
    trigger_stub = spawnstruct();
    trigger_stub.origin = origin;
    str_type = "unitrigger_radius";
    if (isvec(var_3b9cee11)) {
        trigger_stub.script_length = var_3b9cee11[0];
        trigger_stub.script_width = var_3b9cee11[1];
        trigger_stub.script_height = var_3b9cee11[2];
        str_type = "unitrigger_box";
        if (!isdefined(angles)) {
            angles = (0, 0, 0);
        }
        trigger_stub.angles = angles;
    } else {
        trigger_stub.radius = var_3b9cee11;
    }
    if (use_trigger) {
        trigger_stub.cursor_hint = "HINT_NOICON";
        trigger_stub.script_unitrigger_type = str_type + "_use";
    } else {
        trigger_stub.script_unitrigger_type = str_type;
    }
    if (isdefined(var_cd7edcab)) {
        trigger_stub.var_af0b9c6c = var_cd7edcab;
        zm_unitrigger::unitrigger_force_per_player_triggers(trigger_stub, 1);
    }
    trigger_stub.prompt_and_visibility_func = &function_5ea427bf;
    zm_unitrigger::register_unitrigger(trigger_stub, &function_c54cd556);
    return trigger_stub;
}

// Namespace zm_island_util
// Params 1, eflags: 0x0
// Checksum 0xcea5676, Offset: 0x638
// Size: 0x170
function function_5ea427bf(player) {
    b_visible = 1;
    if (isdefined(player.beastmode) && player.beastmode && !(isdefined(self.var_8842df9d) && self.var_8842df9d)) {
        b_visible = 0;
    } else if (isdefined(self.stub.var_98775f3)) {
        b_visible = self [[ self.stub.var_98775f3 ]](player);
    }
    str_msg = %;
    param1 = undefined;
    if (b_visible) {
        if (isdefined(self.stub.var_af0b9c6c)) {
            str_msg = self [[ self.stub.var_af0b9c6c ]](player);
        } else {
            str_msg = self.stub.hint_string;
            param1 = self.stub.hint_parm1;
        }
    }
    if (isdefined(param1)) {
        self sethintstring(str_msg, param1);
    } else {
        self sethintstring(str_msg);
    }
    return b_visible;
}

// Namespace zm_island_util
// Params 0, eflags: 0x4
// Checksum 0xceb4f4f2, Offset: 0x7b0
// Size: 0x60
function private function_c54cd556() {
    self endon(#"kill_trigger");
    self.stub thread function_c1947ff7();
    while (true) {
        self waittill(#"trigger", player);
        self.stub notify(#"trigger", player);
    }
}

// Namespace zm_island_util
// Params 0, eflags: 0x0
// Checksum 0x68689137, Offset: 0x818
// Size: 0x1c
function function_c1947ff7() {
    self zm_unitrigger::run_visibility_function_for_all_triggers();
}

// Namespace zm_island_util
// Params 0, eflags: 0x0
// Checksum 0x4cfd57a9, Offset: 0x840
// Size: 0x28
function function_acd04dc9() {
    self endon(#"death");
    self waittill(#"completed_emerging_into_playable_area");
    self.no_powerups = 1;
}

// Namespace zm_island_util
// Params 1, eflags: 0x0
// Checksum 0x623a4f3d, Offset: 0x870
// Size: 0x324
function function_7448e472(e_target) {
    self endon(#"death");
    if (isdefined(e_target.targetname)) {
        var_241c185a = "someone_revealed_" + e_target.targetname;
        self endon(var_241c185a);
    }
    var_c2b47c7a = 0;
    self.var_abd1c759 = e_target;
    while (isdefined(e_target) && !(isdefined(var_c2b47c7a) && var_c2b47c7a)) {
        if (self hasweapon(level.var_c003f5b)) {
            if (self util::ads_button_held()) {
                if (self getcurrentweapon() !== level.var_c003f5b) {
                    while (self adsbuttonpressed()) {
                        wait 0.05;
                    }
                } else if (self getammocount(level.var_c003f5b)) {
                    if (self keeper_skull::function_3f3f64e9(e_target) && self keeper_skull::function_5fa274c1(e_target)) {
                        self playrumbleonentity("zm_island_skull_reveal");
                        n_count = 0;
                        while (self util::ads_button_held()) {
                            wait 1;
                            n_count++;
                            if (n_count >= 2) {
                                break;
                            }
                        }
                        if (n_count >= 2) {
                            e_target.var_f0b65c0a = self;
                            var_c2b47c7a = 1;
                            playsoundatposition("zmb_wpn_skullgun_discover", e_target.origin);
                            self notify(#"skullweapon_revealed_location");
                            self thread function_4aedb20b();
                            foreach (player in level.players) {
                                if (e_target === player.var_abd1c759) {
                                    player.var_abd1c759 = undefined;
                                    if (isdefined(var_241c185a) && player != self) {
                                        player notify(var_241c185a);
                                    }
                                }
                            }
                            break;
                        } else {
                            self stoprumble("zm_island_skull_reveal");
                        }
                    }
                }
            }
        }
        wait 0.05;
    }
    return var_c2b47c7a;
}

// Namespace zm_island_util
// Params 0, eflags: 0x0
// Checksum 0xb69e2633, Offset: 0xba0
// Size: 0x64
function function_4aedb20b() {
    if (self.var_118ab24e >= 33) {
        self gadgetpowerset(0, self.var_118ab24e - 33);
        return;
    }
    self gadgetpowerset(0, 0);
}

// Namespace zm_island_util
// Params 4, eflags: 0x0
// Checksum 0xc2793d9b, Offset: 0xc10
// Size: 0x182
function function_925aa63a(a_e_elements, n_delay, n_value, b_delete) {
    if (!isdefined(n_delay)) {
        n_delay = 0.1;
    }
    if (!isdefined(b_delete)) {
        b_delete = 1;
    }
    foreach (e_element in a_e_elements) {
        if (isdefined(e_element)) {
            e_element clientfield::set("do_fade_material", n_value);
            wait n_delay;
        }
    }
    wait 1;
    if (isdefined(b_delete) && b_delete) {
        foreach (e_element in a_e_elements) {
            e_element delete();
        }
    }
}

// Namespace zm_island_util
// Params 1, eflags: 0x0
// Checksum 0xe2ee335f, Offset: 0xda0
// Size: 0x62
function function_f2a55b5f(a_str_zones) {
    if (!zm_utility::is_player_valid(self)) {
        return 0;
    }
    str_player_zone = self zm_zonemgr::get_player_zone();
    return isinarray(a_str_zones, str_player_zone);
}

// Namespace zm_island_util
// Params 2, eflags: 0x0
// Checksum 0x1c271c0a, Offset: 0xe10
// Size: 0x142
function is_facing(target, var_94d542a1) {
    if (!isdefined(var_94d542a1)) {
        var_94d542a1 = 0.707;
    }
    if (isentity(target)) {
        v_target = target.origin;
    } else if (isvec(target)) {
        v_target = target;
    }
    var_7ef98cb2 = v_target - self.origin;
    var_7ec36342 = vectornormalize(var_7ef98cb2);
    var_bedf3d47 = anglestoforward(self.angles);
    var_c67c7281 = vectornormalize(var_bedf3d47);
    n_dot = vectordot(var_7ec36342, var_c67c7281);
    return n_dot >= var_94d542a1;
}

// Namespace zm_island_util
// Params 1, eflags: 0x0
// Checksum 0x5bbda886, Offset: 0xf60
// Size: 0x15c
function function_1867f3e8(n_distance) {
    n_dist_sq = n_distance * n_distance;
    str_player_zone = self zm_zonemgr::get_player_zone();
    a_enemies = getaiteamarray("axis");
    var_9efb74d5 = 0;
    foreach (enemy in a_enemies) {
        if (isalive(enemy) && enemy zm_zonemgr::entity_in_zone(str_player_zone) && distancesquared(self.origin, enemy.origin) < n_dist_sq) {
            var_9efb74d5++;
        }
    }
    return var_9efb74d5;
}

// Namespace zm_island_util
// Params 1, eflags: 0x0
// Checksum 0xf03d770, Offset: 0x10c8
// Size: 0xd2
function function_4bf4ac40(v_loc) {
    a_players = arraycopy(level.activeplayers);
    e_player = undefined;
    do {
        if (isdefined(v_loc)) {
            e_player = arraygetclosest(v_loc, a_players);
        } else {
            e_player = array::random(a_players);
        }
        arrayremovevalue(a_players, e_player);
    } while (!zm_utility::is_player_valid(e_player) && a_players.size > 0);
    return e_player;
}

// Namespace zm_island_util
// Params 4, eflags: 0x0
// Checksum 0x2c12842f, Offset: 0x11a8
// Size: 0xdc
function any_player_looking_at(v_org, n_dot, b_do_trace, e_ignore) {
    foreach (player in level.players) {
        if (zm_utility::is_player_valid(player) && player util::is_player_looking_at(v_org, n_dot, b_do_trace, e_ignore)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_island_util
// Params 1, eflags: 0x0
// Checksum 0x83f1c76a, Offset: 0x1290
// Size: 0x242
function swap_weapon(var_9f85aad5) {
    wpn_current = self getcurrentweapon();
    if (!zm_utility::is_player_valid(self)) {
        return;
    }
    if (self.is_drinking > 0) {
        return;
    }
    if (zm_utility::is_placeable_mine(wpn_current) || zm_equipment::is_equipment(wpn_current) || wpn_current == level.weaponnone) {
        return;
    }
    if (!self zm_weapons::has_weapon_or_upgrade(var_9f85aad5)) {
        if (var_9f85aad5.type === "melee") {
            self function_3420bc2f(var_9f85aad5);
        } else if (var_9f85aad5.type === "grenade") {
            self zm_weapons::weapon_give(var_9f85aad5);
        } else {
            self function_dcfc8bde(wpn_current, var_9f85aad5);
        }
        return;
    }
    var_c259e5ce = self zm_weapons::get_player_weapon_with_same_base(var_9f85aad5);
    var_6c6831af = self getweaponslist(1);
    foreach (weapon in var_6c6831af) {
        if (self zm_weapons::get_player_weapon_with_same_base(weapon) === var_c259e5ce) {
            self givemaxammo(weapon);
        }
    }
}

// Namespace zm_island_util
// Params 2, eflags: 0x0
// Checksum 0xbb6ab070, Offset: 0x14e0
// Size: 0xa0
function function_dcfc8bde(current_weapon, weapon) {
    a_weapons = self getweaponslistprimaries();
    if (isdefined(a_weapons) && a_weapons.size >= zm_utility::get_player_weapon_limit(self)) {
        self takeweapon(current_weapon);
    }
    var_7b9ca68 = self zm_weapons::give_build_kit_weapon(weapon);
}

// Namespace zm_island_util
// Params 1, eflags: 0x0
// Checksum 0x23f61bbf, Offset: 0x1588
// Size: 0x140
function function_3420bc2f(var_9f85aad5) {
    var_c5716cdc = self getweaponslist(1);
    foreach (weapon in var_c5716cdc) {
        if (weapon.type === "melee") {
            self takeweapon(weapon);
            break;
        }
    }
    if (self hasperk("specialty_widowswine")) {
        var_7b9ca68 = self zm_weapons::give_build_kit_weapon(level.var_43f0e707);
        return;
    }
    var_7b9ca68 = self zm_weapons::give_build_kit_weapon(var_9f85aad5);
}

/#

    // Namespace zm_island_util
    // Params 4, eflags: 0x0
    // Checksum 0xafa07a94, Offset: 0x16d0
    // Size: 0x108
    function function_8faf1d24(v_color, str_print, n_scale, str_endon) {
        if (!isdefined(v_color)) {
            v_color = (0, 0, 255);
        }
        if (!isdefined(str_print)) {
            str_print = "<dev string:x28>";
        }
        if (!isdefined(n_scale)) {
            n_scale = 0.25;
        }
        if (!isdefined(str_endon)) {
            str_endon = "<dev string:x2a>";
        }
        if (getdvarint("<dev string:x3c>") == 0) {
            return;
        }
        if (isdefined(str_endon)) {
            self endon(str_endon);
        }
        origin = self.origin;
        while (true) {
            print3d(origin, str_print, v_color, n_scale);
            wait 0.1;
        }
    }

#/
