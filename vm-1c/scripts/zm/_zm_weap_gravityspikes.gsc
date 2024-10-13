#using scripts/shared/abilities/_ability_player;
#using scripts/shared/ai/zombie_vortex;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/systems/gib;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/throttle_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_weap_gravityspikes;

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x2
// Checksum 0x9ef5452a, Offset: 0x8a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_gravityspikes", &__init__, undefined, undefined);
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0xb6f0c845, Offset: 0x8e0
// Size: 0x1bc
function __init__() {
    level.n_zombies_lifted_for_ragdoll = 0;
    level.spikes_chop_cone_range = 120;
    level.spikes_chop_cone_range_sq = level.spikes_chop_cone_range * level.spikes_chop_cone_range;
    level.ai_gravity_throttle = new throttle();
    [[ level.ai_gravity_throttle ]]->initialize(2, 0.1);
    level.var_74214c85 = new throttle();
    [[ level.var_74214c85 ]]->initialize(6, 0.1);
    register_clientfields();
    callback::on_connect(&function_6bfe94e8);
    zm_hero_weapon::function_d29010f8("hero_gravityspikes_melee");
    zm_hero_weapon::function_e295a0c2("hero_gravityspikes_melee", &function_618e090, &function_aebacd0f);
    zm_hero_weapon::function_abe86c3f("hero_gravityspikes_melee", undefined, &function_e0511e28);
    zm::register_player_damage_callback(&player_invulnerable_during_gravityspike_slam);
    zm_hero_weapon::function_3d766bf2(getweapon("hero_gravityspikes_melee"), &function_4650a121);
    /#
        level thread function_81889ac5();
    #/
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0xdb3e254d, Offset: 0xaa8
// Size: 0x274
function register_clientfields() {
    clientfield::register("actor", "gravity_slam_down", 1, 1, "int");
    clientfield::register("scriptmover", "gravity_trap_fx", 1, 1, "int");
    clientfield::register("scriptmover", "gravity_trap_spike_spark", 1, 1, "int");
    clientfield::register("scriptmover", "gravity_trap_destroy", 1, 1, "counter");
    clientfield::register("scriptmover", "gravity_trap_location", 1, 1, "int");
    clientfield::register("scriptmover", "gravity_slam_fx", 1, 1, "int");
    clientfield::register("toplayer", "gravity_slam_player_fx", 1, 1, "counter");
    clientfield::register("actor", "sparky_beam_fx", 1, 1, "int");
    clientfield::register("actor", "sparky_zombie_fx", 1, 1, "int");
    clientfield::register("actor", "sparky_zombie_trail_fx", 1, 1, "int");
    clientfield::register("toplayer", "gravity_trap_rumble", 1, 1, "int");
    clientfield::register("actor", "ragdoll_impact_watch", 1, 1, "int");
    clientfield::register("actor", "gravity_spike_zombie_explode_fx", 12000, 1, "counter");
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x5 linked
// Checksum 0xe4775326, Offset: 0xd28
// Size: 0x204
function private function_6bfe94e8() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"death");
    self endon(#"gravity_spike_expired");
    var_f790ca9f = getweapon("hero_gravityspikes_melee");
    self update_gravityspikes_state(0);
    self.b_gravity_trap_spikes_in_ground = 0;
    self.disable_hero_power_charging = 0;
    self.b_gravity_trap_fx_on = 0;
    self thread reset_after_bleeding_out();
    do {
        weapon = self waittill(#"hash_b53927b");
    } while (weapon != var_f790ca9f);
    if (isdefined(self.var_b1869952) && isdefined(self.var_b1869952["hero_gravityspikes_melee"])) {
        self setweaponammoclip(var_f790ca9f, self.var_b1869952["hero_gravityspikes_melee"]);
        self.var_b1869952 = undefined;
    } else {
        self setweaponammoclip(var_f790ca9f, var_f790ca9f.clipsize);
    }
    if (isdefined(self.saved_spike_power)) {
        self gadgetpowerset(self gadgetgetslot(var_f790ca9f), self.saved_spike_power);
        self.saved_spike_power = undefined;
    } else {
        self gadgetpowerset(self gadgetgetslot(var_f790ca9f), 100);
    }
    self.var_817ff1ed = undefined;
    self thread weapon_drop_watcher();
    self thread weapon_change_watcher();
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0xaed6b8eb, Offset: 0xf38
// Size: 0x194
function reset_after_bleeding_out() {
    self endon(#"disconnect");
    var_f790ca9f = getweapon("hero_gravityspikes_melee");
    if (isdefined(self.var_8795a16e) && self.var_8795a16e) {
        util::wait_network_frame();
        self zm_weapons::weapon_give(var_f790ca9f, 0, 1);
        self update_gravityspikes_state(2);
    }
    self waittill(#"bled_out");
    if (self hasweapon(var_f790ca9f)) {
        self.var_8795a16e = 1;
        self.saved_spike_power = self gadgetpowerget(self gadgetgetslot(var_f790ca9f));
        if (self.saved_spike_power >= 100) {
            self.saved_spike_power = undefined;
        }
        self.var_b1869952["hero_gravityspikes_melee"] = self getweaponammoclip(var_f790ca9f);
    }
    if (isdefined(self.var_817ff1ed)) {
        zm_unitrigger::unregister_unitrigger(self.var_817ff1ed);
        self.var_817ff1ed = undefined;
    }
    self waittill(#"spawned_player");
    self thread function_6bfe94e8();
}

// Namespace zm_weap_gravityspikes
// Params 2, eflags: 0x1 linked
// Checksum 0x15cc7355, Offset: 0x10d8
// Size: 0x354
function function_4650a121(e_player, ai_enemy) {
    if (e_player laststand::player_is_in_laststand()) {
        return;
    }
    if (ai_enemy.damageweapon === getweapon("hero_gravityspikes_melee")) {
        return;
    }
    if (isdefined(e_player.disable_hero_power_charging) && e_player.disable_hero_power_charging) {
        return;
    }
    if (isdefined(e_player) && isdefined(e_player.hero_power)) {
        var_f790ca9f = getweapon("hero_gravityspikes_melee");
        if (isdefined(ai_enemy.heroweapon_kill_power)) {
            var_adc6861a = 1;
            if (e_player hasperk("specialty_overcharge")) {
                var_adc6861a = getdvarfloat("gadgetPowerOverchargePerkScoreFactor");
            }
            if (issubstr(ai_enemy.damageweapon.name, "elemental_bow_demongate") || issubstr(ai_enemy.damageweapon.name, "elemental_bow_run_prison") || issubstr(ai_enemy.damageweapon.name, "elemental_bow_storm") || isdefined(ai_enemy.damageweapon) && issubstr(ai_enemy.damageweapon.name, "elemental_bow_wolf_howl")) {
                var_adc6861a = 0.25;
            }
            e_player.hero_power += var_adc6861a * ai_enemy.heroweapon_kill_power;
            e_player.hero_power = math::clamp(e_player.hero_power, 0, 100);
            if (e_player.hero_power >= e_player.var_2ff8e129) {
                e_player gadgetpowerset(e_player gadgetgetslot(var_f790ca9f), e_player.hero_power);
                e_player clientfield::set_player_uimodel("zmhud.swordEnergy", e_player.hero_power / 100);
                e_player clientfield::increment_uimodel("zmhud.swordChargeUpdate");
            }
            if (e_player.hero_power >= 100) {
                e_player update_gravityspikes_state(2);
            }
        }
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x615bf360, Offset: 0x1438
// Size: 0x12c
function function_618e090(var_87f03818) {
    self zm_hero_weapon::function_44ede878(var_87f03818);
    if (!(isdefined(self.var_1fadb50b) && self.var_1fadb50b)) {
        if (isdefined(self.hintelem)) {
            self.hintelem settext("");
            self.hintelem destroy();
        }
        self thread zm_equipment::show_hint_text(%ZM_CASTLE_GRAVITYSPIKE_INSTRUCTIONS, 3);
        self.var_1fadb50b = 1;
    }
    self update_gravityspikes_state(3);
    self thread gravityspikes_attack_watcher(var_87f03818);
    self thread gravityspikes_stuck_above_zombie_watcher(var_87f03818);
    self thread gravityspikes_altfire_watcher(var_87f03818);
    self thread function_844248de(var_87f03818);
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x95e60846, Offset: 0x1570
// Size: 0x94
function function_aebacd0f(var_87f03818) {
    self zm_hero_weapon::function_d1e94a2f(var_87f03818);
    self notify(#"hash_6716a6e7");
    if (isdefined(self.b_gravity_trap_spikes_in_ground) && self.b_gravity_trap_spikes_in_ground) {
        self.disable_hero_power_charging = 1;
        self thread zm_hero_weapon::function_bde51ee1(var_87f03818);
        self thread gravity_trap_loop(self.var_5da14f3b, var_87f03818);
    }
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0x46af0972, Offset: 0x1610
// Size: 0x68
function weapon_drop_watcher() {
    self endon(#"disconnect");
    while (true) {
        w_current = self waittill(#"weapon_switch_started");
        if (zm_utility::is_hero_weapon(w_current)) {
            self setweaponammoclip(w_current, 0);
        }
    }
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0x2cd55, Offset: 0x1680
// Size: 0x70
function weapon_change_watcher() {
    self endon(#"disconnect");
    while (true) {
        w_current, w_previous = self waittill(#"weapon_change");
        if (isdefined(w_previous) && zm_utility::is_hero_weapon(w_current)) {
            self.var_f26475de = w_previous;
        }
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x805edba7, Offset: 0x16f8
// Size: 0xc8
function gravityspikes_attack_watcher(var_87f03818) {
    self endon(#"hash_6716a6e7");
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"death");
    self endon(#"gravity_spike_expired");
    while (true) {
        weapon = self waittill(#"weapon_melee_power");
        if (weapon == var_87f03818) {
            self playrumbleonentity("talon_spike");
            self thread knockdown_zombies_slam();
            self thread no_damage_gravityspikes_slam();
        }
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0xdd2886b6, Offset: 0x17c8
// Size: 0x4f0
function gravityspikes_stuck_above_zombie_watcher(var_87f03818) {
    self endon(#"hash_6716a6e7");
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"death");
    self endon(#"gravity_spike_expired");
    var_24411a70 = 1;
    while (zm_utility::is_player_valid(self)) {
        if (!self isslamming()) {
            wait 0.05;
            continue;
        }
        while (self isslamming() && self getcurrentweapon() == var_87f03818) {
            player_angles = self getplayerangles();
            forward_vec = anglestoforward((0, player_angles[1], 0));
            if (forward_vec[0] == 0 && forward_vec[1] == 0 && forward_vec[2] == 0) {
                wait 0.05;
                continue;
            }
            forward_right_45_vec = rotatepoint(forward_vec, (0, 45, 0));
            forward_left_45_vec = rotatepoint(forward_vec, (0, -45, 0));
            right_vec = anglestoright(player_angles);
            var_b9f00eca = -35;
            start_point = self.origin + (0, 0, 50);
            end_point = self.origin + (0, 0, var_b9f00eca);
            var_afdf62c5 = 30;
            var_38811738 = [];
            if (var_24411a70) {
                var_38811738[0] = end_point + vectorscale(forward_vec, var_afdf62c5);
                var_38811738[1] = end_point + vectorscale(right_vec, var_afdf62c5);
                var_38811738[2] = end_point - vectorscale(right_vec, var_afdf62c5);
                var_24411a70 = 0;
            } else {
                var_38811738[0] = end_point + vectorscale(forward_right_45_vec, var_afdf62c5);
                var_38811738[1] = end_point + vectorscale(forward_left_45_vec, var_afdf62c5);
                var_38811738[2] = end_point - vectorscale(forward_vec, var_afdf62c5);
                var_24411a70 = 1;
            }
            for (i = 0; i < 3; i++) {
                trace = bullettrace(start_point, var_38811738[i], 1, self);
                /#
                    if (getdvarint("<dev string:x28>", 0) > 0) {
                        line(start_point, var_38811738[i], (1, 1, 1), 1, 0, 60);
                        recordline(start_point, var_38811738[i], (1, 1, 1), "<dev string:x4b>", self);
                    }
                #/
                if (trace["fraction"] < 1) {
                    if (trace["entity"].archetype == "zombie" || isactor(trace["entity"]) && trace["entity"].health > 0 && trace["entity"].archetype == "zombie_dog") {
                        self thread knockdown_zombies_slam();
                        self thread no_damage_gravityspikes_slam();
                        wait 1;
                        break;
                    }
                }
            }
            wait 0.05;
        }
        wait 0.05;
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x165db7f1, Offset: 0x1cc0
// Size: 0xa8
function gravityspikes_altfire_watcher(var_87f03818) {
    self endon(#"hash_6716a6e7");
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"death");
    self endon(#"gravity_spike_expired");
    while (true) {
        weapon = self waittill(#"weapon_melee_power_left");
        if (weapon == var_87f03818 && self gravity_spike_position_valid()) {
            self thread plant_gravity_trap(var_87f03818);
        }
    }
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0xc5dc9315, Offset: 0x1d70
// Size: 0x44
function gravity_spike_position_valid() {
    if (isdefined(level.gravityspike_position_check)) {
        return self [[ level.gravityspike_position_check ]]();
    }
    if (ispointonnavmesh(self.origin, self)) {
        return 1;
    }
}

// Namespace zm_weap_gravityspikes
// Params 3, eflags: 0x1 linked
// Checksum 0x3eaba3a0, Offset: 0x1dc0
// Size: 0xfc
function chop_actor(ai, leftswing, weapon) {
    if (!isdefined(weapon)) {
        weapon = level.weaponnone;
    }
    self endon(#"disconnect");
    if (!isdefined(ai) || !isalive(ai)) {
        return;
    }
    if (3594 >= ai.health) {
        ai.ignoremelee = 1;
    }
    [[ level.var_74214c85 ]]->waitinqueue(ai);
    ai dodamage(3594, self.origin, self, self, "none", "MOD_UNKNOWN", 0, weapon);
    util::wait_network_frame();
}

// Namespace zm_weap_gravityspikes
// Params 3, eflags: 0x1 linked
// Checksum 0x749f776c, Offset: 0x1ec8
// Size: 0x2f2
function chop_zombies(first_time, leftswing, weapon) {
    if (!isdefined(weapon)) {
        weapon = level.weaponnone;
    }
    view_pos = self getweaponmuzzlepoint();
    forward_view_angles = self getweaponforwarddir();
    zombie_list = getaiteamarray(level.zombie_team);
    foreach (ai in zombie_list) {
        if (!isdefined(ai) || !isalive(ai)) {
            continue;
        }
        if (first_time) {
            ai.chopped = 0;
        } else if (isdefined(ai.chopped) && ai.chopped) {
            continue;
        }
        test_origin = ai getcentroid();
        dist_sq = distancesquared(view_pos, test_origin);
        dist_to_check = level.spikes_chop_cone_range_sq;
        if (dist_sq > dist_to_check) {
            continue;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (dot <= 0) {
            continue;
        }
        if (0 == ai damageconetrace(view_pos, self)) {
            continue;
        }
        ai.chopped = 1;
        if (isdefined(ai.chop_actor_cb)) {
            self thread [[ ai.chop_actor_cb ]](ai, self, weapon);
            continue;
        }
        self thread chop_actor(ai, leftswing, weapon);
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x7dc03813, Offset: 0x21c8
// Size: 0x7c
function function_b2b16b7b(player) {
    player thread chop_zombies(1, 1, self);
    wait 0.3;
    player thread chop_zombies(0, 1, self);
    wait 0.5;
    player thread chop_zombies(0, 0, self);
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0xe628e136, Offset: 0x2250
// Size: 0x88
function function_844248de(var_87f03818) {
    self endon(#"hash_6716a6e7");
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"death");
    self endon(#"gravity_spike_expired");
    while (true) {
        weapon = self waittill(#"weapon_melee");
        weapon thread function_b2b16b7b(self);
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x5a80143, Offset: 0x22e0
// Size: 0x64
function function_6b90b056(player) {
    if (!(isdefined(player.disable_hero_power_charging) && player.disable_hero_power_charging)) {
        player gadgetpowerset(0, 100);
        player update_gravityspikes_state(2);
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x1767b038, Offset: 0x2350
// Size: 0x3e
function function_e0511e28(weapon) {
    self zm_hero_weapon::function_194811c8(weapon);
    self notify(#"hash_8851ed94");
    self notify(#"gravityspikes_timer_end");
}

// Namespace zm_weap_gravityspikes
// Params 11, eflags: 0x1 linked
// Checksum 0xfc5653c5, Offset: 0x2398
// Size: 0xac
function player_invulnerable_during_gravityspike_slam(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    if (isdefined(self.gravityspikes_slam) && (self isslamming() || self.var_887585ba === 3 && self.gravityspikes_slam)) {
        return 0;
    }
    return -1;
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0xd76275e9, Offset: 0x2450
// Size: 0x24
function no_damage_gravityspikes_slam() {
    self.gravityspikes_slam = 1;
    wait 1.5;
    self.gravityspikes_slam = 0;
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x2f26f535, Offset: 0x2480
// Size: 0x1a0
function player_near_gravity_vortex(v_vortex_origin) {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"death");
    while (isdefined(self.b_gravity_trap_spikes_in_ground) && self.b_gravity_trap_spikes_in_ground && self.var_887585ba === 3) {
        foreach (e_player in level.activeplayers) {
            if (isdefined(e_player) && !(isdefined(e_player.idgun_vision_on) && e_player.idgun_vision_on)) {
                if (distance(e_player.origin, v_vortex_origin) < float(64)) {
                    e_player thread zombie_vortex::player_vortex_visionset("zm_idgun_vortex");
                    if (!(isdefined(e_player.var_d4e1840f) && e_player.var_d4e1840f)) {
                        self thread function_55a5024b(e_player, v_vortex_origin);
                    }
                }
            }
        }
        wait 0.05;
    }
}

// Namespace zm_weap_gravityspikes
// Params 2, eflags: 0x1 linked
// Checksum 0x5be604f5, Offset: 0x2628
// Size: 0xf2
function function_55a5024b(e_player, v_vortex_origin) {
    e_player endon(#"disconnect");
    e_player endon(#"bled_out");
    e_player endon(#"death");
    e_player.var_d4e1840f = 1;
    e_player clientfield::set_to_player("gravity_trap_rumble", 1);
    while (distance(e_player.origin, v_vortex_origin) < float(64) && self.var_887585ba === 3) {
        wait 0.05;
    }
    e_player clientfield::set_to_player("gravity_trap_rumble", 0);
    e_player.var_d4e1840f = undefined;
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x4d34d67a, Offset: 0x2728
// Size: 0x3a2
function plant_gravity_trap(var_87f03818) {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"death");
    v_forward = anglestoforward(self.angles);
    v_right = anglestoright(self.angles);
    v_spawn_pos_right = self.origin + (0, 0, 32);
    v_spawn_pos_left = v_spawn_pos_right;
    a_trace = physicstraceex(v_spawn_pos_right, v_spawn_pos_right + v_right * 24, (-16, -16, -16), (16, 16, 16), self);
    v_spawn_pos_right += v_right * a_trace["fraction"] * 24;
    a_trace = physicstraceex(v_spawn_pos_left, v_spawn_pos_left + v_right * -24, (-16, -16, -16), (16, 16, 16), self);
    v_spawn_pos_left += v_right * a_trace["fraction"] * -24;
    v_spawn_pos_right = util::ground_position(v_spawn_pos_right, 1000, 24);
    v_spawn_pos_left = util::ground_position(v_spawn_pos_left, 1000, 24);
    var_e987f01a = array(v_spawn_pos_right, v_spawn_pos_left);
    self create_gravity_trap_spikes_in_ground(var_e987f01a);
    if (self isonground()) {
        var_5da14f3b = self.origin + (0, 0, 32);
    } else {
        var_5da14f3b = util::ground_position(self.origin, 1000, length((0, 0, 32)));
    }
    self gravity_trap_fx_on(var_5da14f3b);
    self zm_weapons::switch_back_primary_weapon(self.var_f26475de, 1);
    self setweaponammoclip(var_87f03818, 0);
    self.b_gravity_trap_spikes_in_ground = 1;
    self.var_5da14f3b = var_5da14f3b;
    self notify(#"hash_f392f058");
    self thread player_near_gravity_vortex(var_5da14f3b);
    self thread destroy_gravity_trap_spikes_in_ground();
    self util::waittill_any("gravity_trap_spikes_retrieved", "disconnect", "bled_out");
    if (isdefined(self)) {
        self.b_gravity_trap_spikes_in_ground = 0;
        self.disable_hero_power_charging = 0;
        self notify(#"destroy_ground_spikes");
    }
}

// Namespace zm_weap_gravityspikes
// Params 2, eflags: 0x1 linked
// Checksum 0x6a783cb0, Offset: 0x2ad8
// Size: 0x1ac
function gravity_trap_loop(var_5da14f3b, var_87f03818) {
    self endon(#"gravity_trap_spikes_retrieved");
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"death");
    is_gravity_trap_fx_on = 1;
    while (true) {
        if (self zm_hero_weapon::function_f3451c9f() && self.hero_power > 0) {
            a_zombies = getaiteamarray(level.zombie_team);
            a_zombies = array::filter(a_zombies, 0, &gravityspikes_target_filtering);
            array::thread_all(a_zombies, &gravity_trap_check, self);
        } else if (is_gravity_trap_fx_on) {
            self gravity_trap_fx_off();
            is_gravity_trap_fx_on = 0;
            self update_gravityspikes_state(4);
            util::wait_network_frame();
            self function_268b0239(var_5da14f3b, var_87f03818);
            if (self zm_hero_weapon::function_f3451c9f()) {
                self function_e0511e28(var_87f03818);
            }
            return;
        }
        wait 0.1;
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x64f4091e, Offset: 0x2c90
// Size: 0x1ac
function gravity_trap_check(player) {
    player endon(#"gravity_trap_spikes_retrieved");
    player endon(#"disconnect");
    player endon(#"bled_out");
    player endon(#"death");
    assert(isdefined(level.ai_gravity_throttle));
    assert(isdefined(player));
    n_gravity_trap_radius_sq = 16384;
    v_gravity_trap_origin = player.mdl_gravity_trap_fx_source.origin;
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    if (self check_for_range_and_los(v_gravity_trap_origin, 96, n_gravity_trap_radius_sq)) {
        if (self.in_gravity_trap === 1) {
            return;
        }
        self.in_gravity_trap = 1;
        [[ level.ai_gravity_throttle ]]->waitinqueue(self);
        if (isdefined(self) && isalive(self)) {
            self zombie_lift(player, v_gravity_trap_origin, 0, randomintrange(-72, 284), (0, 0, -24), randomintrange(64, -128));
        }
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0xeda43306, Offset: 0x2e48
// Size: 0x176
function create_gravity_trap_spikes_in_ground(var_e987f01a) {
    if (!isdefined(self.mdl_gravity_trap_spikes)) {
        self.mdl_gravity_trap_spikes = [];
    }
    for (i = 0; i < var_e987f01a.size; i++) {
        if (!isdefined(self.mdl_gravity_trap_spikes[i])) {
            self.mdl_gravity_trap_spikes[i] = util::spawn_model("wpn_zmb_dlc1_talon_spike_single_world", var_e987f01a[i]);
        }
        self.mdl_gravity_trap_spikes[i].origin = var_e987f01a[i];
        self.mdl_gravity_trap_spikes[i].angles = self.angles;
        self.mdl_gravity_trap_spikes[i] show();
        wait 0.05;
        self.mdl_gravity_trap_spikes[i] thread gravity_spike_planted_play();
        self.mdl_gravity_trap_spikes[i] clientfield::set("gravity_trap_spike_spark", 1);
        if (isdefined(level.var_e1885a4b)) {
            [[ level.var_e1885a4b ]](self.mdl_gravity_trap_spikes[i]);
        }
    }
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0xfcca3bb1, Offset: 0x2fc8
// Size: 0x34
function gravity_spike_planted_play() {
    wait 2;
    self thread scene::play("cin_zm_dlc1_spike_plant_loop", self);
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0x7b59e6be, Offset: 0x3008
// Size: 0x186
function destroy_gravity_trap_spikes_in_ground() {
    mdl_spike_source = self.mdl_gravity_trap_fx_source;
    mdl_gravity_trap_spikes = self.mdl_gravity_trap_spikes;
    self util::waittill_any("destroy_ground_spikes", "disconnect", "bled_out");
    if (isdefined(mdl_spike_source)) {
        mdl_spike_source clientfield::set("gravity_trap_location", 0);
        mdl_spike_source ghost();
        if (!isdefined(self)) {
            mdl_spike_source delete();
        }
    }
    if (!isdefined(mdl_gravity_trap_spikes)) {
        return;
    }
    for (i = 0; i < mdl_gravity_trap_spikes.size; i++) {
        mdl_gravity_trap_spikes[i] thread scene::stop("cin_zm_dlc1_spike_plant_loop");
        mdl_gravity_trap_spikes[i] clientfield::set("gravity_trap_spike_spark", 0);
        mdl_gravity_trap_spikes[i] ghost();
        if (!isdefined(self)) {
            mdl_gravity_trap_spikes[i] delete();
        }
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x1a4c2838, Offset: 0x3198
// Size: 0x9c
function gravity_trap_fx_on(v_spawn_pos) {
    if (!isdefined(self.mdl_gravity_trap_fx_source)) {
        self.mdl_gravity_trap_fx_source = util::spawn_model("tag_origin", v_spawn_pos);
    }
    self.mdl_gravity_trap_fx_source.origin = v_spawn_pos;
    self.mdl_gravity_trap_fx_source show();
    wait 0.05;
    self.mdl_gravity_trap_fx_source clientfield::set("gravity_trap_fx", 1);
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0x276531a1, Offset: 0x3240
// Size: 0x5c
function gravity_trap_fx_off() {
    if (!isdefined(self.mdl_gravity_trap_fx_source)) {
        return;
    }
    self.mdl_gravity_trap_fx_source clientfield::set("gravity_trap_fx", 0);
    self.mdl_gravity_trap_fx_source clientfield::set("gravity_trap_location", 1);
}

// Namespace zm_weap_gravityspikes
// Params 2, eflags: 0x1 linked
// Checksum 0xf7da4d32, Offset: 0x32a8
// Size: 0x12c
function function_268b0239(v_origin, var_87f03818) {
    if (isdefined(self.var_817ff1ed)) {
        return;
    }
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = v_origin;
    unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.radius = -128;
    unitrigger_stub.require_look_at = 0;
    unitrigger_stub.var_89b417e9 = self;
    unitrigger_stub.var_87f03818 = var_87f03818;
    self.var_817ff1ed = unitrigger_stub;
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    unitrigger_stub.prompt_and_visibility_func = &function_66b8ce07;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_23d2cc59);
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x5b1051f8, Offset: 0x33e0
// Size: 0x68
function function_66b8ce07(player) {
    if (player == self.stub.var_89b417e9) {
        self sethintstring(%ZM_CASTLE_GRAVITYSPIKE_PICKUP);
        return 1;
    }
    self setinvisibletoplayer(player);
    return 0;
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0x1cb5ce6b, Offset: 0x3450
// Size: 0xa4
function function_23d2cc59() {
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        level thread function_6a359e28(self.stub, player);
        break;
    }
}

// Namespace zm_weap_gravityspikes
// Params 2, eflags: 0x1 linked
// Checksum 0xb7cc22e0, Offset: 0x3500
// Size: 0x15a
function function_6a359e28(var_91089b66, player) {
    if (player == var_91089b66.var_89b417e9) {
        player notify(#"gravity_trap_spikes_retrieved");
        player playsound("fly_talon_pickup");
        if (player.var_887585ba == 3) {
            player.var_f26475de = player getcurrentweapon();
            player giveweapon(var_91089b66.var_87f03818);
            player givemaxammo(var_91089b66.var_87f03818);
            player setweaponammoclip(var_91089b66.var_87f03818, var_91089b66.var_87f03818.clipsize);
            player switchtoweapon(var_91089b66.var_87f03818);
        }
        zm_unitrigger::unregister_unitrigger(var_91089b66);
        player.var_817ff1ed = undefined;
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x3c25e438, Offset: 0x3668
// Size: 0x18
function update_gravityspikes_state(n_gravityspikes_state) {
    self.var_887585ba = n_gravityspikes_state;
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x0
// Checksum 0x5a168cb8, Offset: 0x3688
// Size: 0x3c
function function_9605596b(var_9284dd5) {
    self.var_9284dd5 = var_9284dd5;
    self clientfield::set_player_uimodel("zmhud.swordEnergy", self.var_9284dd5);
}

// Namespace zm_weap_gravityspikes
// Params 3, eflags: 0x1 linked
// Checksum 0x97d98ef6, Offset: 0x36d0
// Size: 0xf6
function check_for_range_and_los(v_attack_source, n_allowed_z_diff, n_radius_sq) {
    if (isalive(self)) {
        n_z_diff = self.origin[2] - v_attack_source[2];
        if (abs(n_z_diff) < n_allowed_z_diff) {
            if (distance2dsquared(self.origin, v_attack_source) < n_radius_sq) {
                v_offset = (0, 0, 50);
                if (bullettracepassed(self.origin + v_offset, v_attack_source + v_offset, 0, self)) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0xed3bd535, Offset: 0x37d0
// Size: 0x48
function gravityspikes_target_filtering(ai_enemy) {
    b_callback_result = 1;
    if (isdefined(level.var_8142aca1)) {
        b_callback_result = [[ level.var_8142aca1 ]](ai_enemy);
    }
    return b_callback_result;
}

// Namespace zm_weap_gravityspikes
// Params 6, eflags: 0x1 linked
// Checksum 0xbf01cd7d, Offset: 0x3820
// Size: 0x79c
function zombie_lift(player, v_attack_source, n_push_away, n_lift_height, v_lift_offset, n_lift_speed) {
    var_87f03818 = getweapon("hero_gravityspikes_melee");
    if (isdefined(self.zombie_lift_override)) {
        self thread [[ self.zombie_lift_override ]](player, v_attack_source, n_push_away, n_lift_height, v_lift_offset, n_lift_speed);
        return;
    }
    if (isdefined(self.var_e5a45dc0) && (isdefined(self.isdog) && self.isdog || self.var_e5a45dc0)) {
        self.no_powerups = 1;
        self dodamage(self.health + 100, self.origin, player, player, undefined, "MOD_UNKNOWN", 0, var_87f03818);
        self playsound("zmb_talon_electrocute_swt");
        return;
    }
    if (level.n_zombies_lifted_for_ragdoll < 12) {
        self thread track_lifted_for_ragdoll_count();
        v_away_from_source = vectornormalize(self.origin - v_attack_source);
        v_away_from_source *= n_push_away;
        v_away_from_source = (v_away_from_source[0], v_away_from_source[1], n_lift_height);
        a_trace = physicstraceex(self.origin + (0, 0, 32), self.origin + v_away_from_source, (-16, -16, -16), (16, 16, 16), self);
        v_lift = a_trace["fraction"] * v_away_from_source;
        v_lift += v_lift_offset;
        n_lift_time = length(v_lift) / n_lift_speed;
        if (isdefined(self.b_melee_kill) && isdefined(self) && self.b_melee_kill) {
            self setplayercollision(0);
            if (!(isdefined(level.ignore_gravityspikes_ragdoll) && level.ignore_gravityspikes_ragdoll)) {
                self startragdoll();
                self launchragdoll(-106 * anglestoup(self.angles) + (v_away_from_source[0], v_away_from_source[1], 0));
            }
            self clientfield::set("ragdoll_impact_watch", 1);
            self clientfield::set("sparky_zombie_trail_fx", 1);
            util::wait_network_frame();
        } else if (isdefined(self) && v_lift[2] > 0 && length(v_lift) > length(v_lift_offset)) {
            self setplayercollision(0);
            self clientfield::set("sparky_beam_fx", 1);
            self clientfield::set("sparky_zombie_fx", 1);
            self playsound("zmb_talon_electrocute");
            if (isdefined(self.missinglegs) && self.missinglegs) {
                self thread scene::play("cin_zm_dlc1_zombie_crawler_talonspike_a_loop", self);
            } else {
                self thread scene::play("cin_zm_dlc1_zombie_talonspike_loop", self);
            }
            self.mdl_trap_mover = util::spawn_model("tag_origin", self.origin, self.angles);
            self thread util::delete_on_death(self.mdl_trap_mover);
            self linkto(self.mdl_trap_mover, "tag_origin");
            self.mdl_trap_mover moveto(self.origin + v_lift, n_lift_time, 0, n_lift_time * 0.4);
            self thread zombie_lift_wacky_rotate(n_lift_time, player);
            self thread gravity_trap_notify_watcher(player);
            self waittill(#"gravity_trap_complete");
            if (isdefined(self)) {
                self unlink();
                self scene::stop();
                self startragdoll(1);
                self clientfield::set("gravity_slam_down", 1);
                self clientfield::set("sparky_beam_fx", 0);
                self clientfield::set("sparky_zombie_fx", 0);
                self clientfield::set("sparky_zombie_trail_fx", 1);
                self thread corpse_off_navmesh_watcher();
                self clientfield::set("ragdoll_impact_watch", 1);
                v_land_pos = util::ground_position(self.origin, 1000);
                n_fall_dist = abs(self.origin[2] - v_land_pos[2]);
                n_slam_wait = n_fall_dist / -56 * 0.75;
                if (n_slam_wait > 0) {
                    wait n_slam_wait;
                }
            }
        }
        if (isalive(self)) {
            self zombie_kill_and_gib(player);
            self playsound("zmb_talon_ai_slam");
        }
        return;
    }
    self zombie_kill_and_gib(player);
    self playsound("zmb_talon_ai_slam");
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x107e8a0, Offset: 0x3fc8
// Size: 0x8a
function gravity_trap_notify_watcher(player) {
    self endon(#"gravity_trap_complete");
    self thread gravity_trap_timeout_watcher();
    util::waittill_any_ents(self, "death", player, "gravity_trap_spikes_retrieved", player, "gravityspikes_timer_end", player, "disconnect", player, "bled_out");
    self notify(#"gravity_trap_complete");
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0x41563f55, Offset: 0x4060
// Size: 0xa2
function gravity_trap_timeout_watcher() {
    self endon(#"gravity_trap_complete");
    self.mdl_trap_mover util::waittill_any_timeout(4, "movedone", "gravity_trap_complete");
    if (isalive(self) && !(isdefined(self.b_melee_kill) && self.b_melee_kill)) {
        wait randomfloatrange(0.2, 1);
    }
    self notify(#"gravity_trap_complete");
}

// Namespace zm_weap_gravityspikes
// Params 2, eflags: 0x1 linked
// Checksum 0x9659b636, Offset: 0x4110
// Size: 0x152
function zombie_lift_wacky_rotate(n_lift_time, player) {
    player endon(#"gravityspikes_timer_end");
    self endon(#"death");
    while (true) {
        negative_x = randomintrange(0, 10) < 5 ? 1 : -1;
        negative_z = randomintrange(0, 10) < 5 ? 1 : -1;
        self.mdl_trap_mover rotateto((randomintrange(90, -76) * negative_x, randomintrange(-90, 90), randomintrange(90, -76) * negative_z), n_lift_time > 2 ? n_lift_time : 5, 0);
        self.mdl_trap_mover waittill(#"rotatedone");
    }
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x194824b0, Offset: 0x4270
// Size: 0xcc
function zombie_kill_and_gib(player) {
    var_87f03818 = getweapon("hero_gravityspikes_melee");
    self.no_powerups = 1;
    self dodamage(self.health + 100, self.origin, player, player, undefined, "MOD_UNKNOWN", 0, var_87f03818);
    if (true) {
        n_random = randomint(100);
        if (n_random >= 20) {
            self zombie_utility::gib_random_parts();
        }
    }
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0x48910d37, Offset: 0x4348
// Size: 0x20
function track_lifted_for_ragdoll_count() {
    level.n_zombies_lifted_for_ragdoll++;
    self waittill(#"death");
    level.n_zombies_lifted_for_ragdoll--;
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0xd682d666, Offset: 0x4370
// Size: 0x94
function corpse_off_navmesh_watcher() {
    e_corpse = self waittill(#"actor_corpse");
    v_pos = getclosestpointonnavmesh(e_corpse.origin, 256);
    if (!isdefined(v_pos) || e_corpse.origin[2] > v_pos[2] + 64) {
        e_corpse thread do_zombie_explode();
    }
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x5 linked
// Checksum 0xa6ac0223, Offset: 0x4410
// Size: 0x94
function private do_zombie_explode() {
    util::wait_network_frame();
    if (isdefined(self)) {
        self zombie_utility::zombie_eye_glow_stop();
        self clientfield::increment("gravity_spike_zombie_explode_fx");
        self ghost();
        self util::delay(0.25, undefined, &zm_utility::self_delete);
    }
}

// Namespace zm_weap_gravityspikes
// Params 2, eflags: 0x1 linked
// Checksum 0x8c13aa57, Offset: 0x44b0
// Size: 0xb4
function gravity_spike_melee_kill(v_position, player) {
    self.b_melee_kill = 1;
    var_8335bb0c = 40000;
    if (self check_for_range_and_los(v_position, 96, var_8335bb0c)) {
        self zombie_lift(player, v_position, -128, randomintrange(-128, -56), (0, 0, 0), randomintrange(-106, -56));
    }
}

// Namespace zm_weap_gravityspikes
// Params 0, eflags: 0x1 linked
// Checksum 0x78cd4a15, Offset: 0x4570
// Size: 0x17c
function knockdown_zombies_slam() {
    v_forward = anglestoforward(self getplayerangles());
    v_pos = self.origin + vectorscale(v_forward, 24);
    a_ai = getaiteamarray(level.zombie_team);
    a_ai = array::filter(a_ai, 0, &gravityspikes_target_filtering);
    a_ai_kill_zombies = arraysortclosest(a_ai, v_pos, a_ai.size, 0, -56);
    array::thread_all(a_ai_kill_zombies, &gravity_spike_melee_kill, v_pos, self);
    a_ai_slam_zombies = arraysortclosest(a_ai, v_pos, a_ai.size, -56, 400);
    array::thread_all(a_ai_slam_zombies, &zombie_slam_direction, v_pos);
    self thread play_slam_fx(v_pos);
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x53001a3f, Offset: 0x46f8
// Size: 0xac
function play_slam_fx(v_pos) {
    mdl_fx_pos = util::spawn_model("tag_origin", v_pos, (-90, 0, 0));
    wait 0.05;
    mdl_fx_pos clientfield::set("gravity_slam_fx", 1);
    self clientfield::increment_to_player("gravity_slam_player_fx");
    wait 0.05;
    mdl_fx_pos delete();
}

// Namespace zm_weap_gravityspikes
// Params 1, eflags: 0x1 linked
// Checksum 0x22b6f5f2, Offset: 0x47b0
// Size: 0x28c
function zombie_slam_direction(v_position) {
    self endon(#"death");
    if (!(self.archetype === "zombie")) {
        return;
    }
    self.knockdown = 1;
    var_f5ed5b7e = v_position - self.origin;
    var_17e60e9b = vectornormalize((var_f5ed5b7e[0], var_f5ed5b7e[1], 0));
    var_45ef6cd0 = anglestoforward(self.angles);
    var_810df61 = vectornormalize((var_45ef6cd0[0], var_45ef6cd0[1], 0));
    var_e502452d = anglestoright(self.angles);
    var_4733d782 = vectornormalize((var_e502452d[0], var_e502452d[1], 0));
    var_8bb8fa69 = vectordot(var_17e60e9b, var_810df61);
    if (var_8bb8fa69 >= 0.5) {
        self.knockdown_direction = "front";
        self.getup_direction = "getup_back";
    } else if (var_8bb8fa69 < 0.5 && var_8bb8fa69 > -0.5) {
        var_8bb8fa69 = vectordot(var_17e60e9b, var_4733d782);
        if (var_8bb8fa69 > 0) {
            self.knockdown_direction = "right";
            if (math::cointoss()) {
                self.getup_direction = "getup_back";
            } else {
                self.getup_direction = "getup_belly";
            }
        } else {
            self.knockdown_direction = "left";
            self.getup_direction = "getup_belly";
        }
    } else {
        self.knockdown_direction = "back";
        self.getup_direction = "getup_belly";
    }
    wait 1;
    self.knockdown = 0;
}

/#

    // Namespace zm_weap_gravityspikes
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6d63cdd7, Offset: 0x4a48
    // Size: 0x5d0
    function function_81889ac5() {
        wait 0.05;
        level waittill(#"start_zombie_round_logic");
        wait 0.05;
        var_87f03818 = getweapon("<dev string:x52>");
        equipment_id = var_87f03818.name;
        str_cmd = "<dev string:x6b>" + equipment_id + "<dev string:x83>" + equipment_id + "<dev string:xa5>";
        adddebugcommand(str_cmd);
        str_cmd = "<dev string:x6b>" + equipment_id + "<dev string:xa8>" + equipment_id + "<dev string:xa5>";
        adddebugcommand(str_cmd);
        str_cmd = "<dev string:x6b>" + equipment_id + "<dev string:xd2>" + equipment_id + "<dev string:xa5>";
        adddebugcommand(str_cmd);
        str_cmd = "<dev string:x6b>" + equipment_id + "<dev string:xfe>" + equipment_id + "<dev string:xa5>";
        adddebugcommand(str_cmd);
        while (true) {
            equipment_id = getdvarstring("<dev string:x12c>");
            if (equipment_id != "<dev string:x13f>") {
                foreach (player in getplayers()) {
                    if (equipment_id == var_87f03818.name) {
                        player zm_weapons::weapon_give(var_87f03818, 0, 1);
                        player thread zm_equipment::show_hint_text(%"<dev string:x140>", 3);
                        player gadgetpowerset(0, 100);
                        player update_gravityspikes_state(2);
                        player.var_9284dd5 = 1;
                        level notify(#"hash_71de5140");
                    }
                }
                setdvar("<dev string:x12c>", "<dev string:x13f>");
            }
            equipment_id = getdvarstring("<dev string:x160>");
            if (equipment_id != "<dev string:x13f>") {
                foreach (player in getplayers()) {
                    if (equipment_id == var_87f03818.name) {
                        function_6b90b056(player);
                    }
                }
                setdvar("<dev string:x160>", "<dev string:x13f>");
            }
            equipment_id = getdvarstring("<dev string:x177>");
            if (equipment_id != "<dev string:x13f>") {
                foreach (player in getplayers()) {
                    if (equipment_id == var_87f03818.name) {
                        setdvar("<dev string:x18d>", 1);
                    }
                }
                setdvar("<dev string:x177>", "<dev string:x13f>");
            }
            equipment_id = getdvarstring("<dev string:x1aa>");
            if (equipment_id != "<dev string:x13f>") {
                foreach (player in getplayers()) {
                    if (equipment_id == var_87f03818.name) {
                        setdvar("<dev string:x18d>", 0);
                    }
                }
                setdvar("<dev string:x1aa>", "<dev string:x13f>");
            }
            wait 0.05;
        }
    }

#/
