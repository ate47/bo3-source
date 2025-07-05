#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_weap_staff_common;
#using scripts/zm/zm_tomb_utility;

#namespace zm_weap_staff_lightning;

// Namespace zm_weap_staff_lightning
// Params 0, eflags: 0x2
// Checksum 0xda4f7bfd, Offset: 0x488
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_weap_staff_lightning", &__init__, undefined, undefined);
}

// Namespace zm_weap_staff_lightning
// Params 0, eflags: 0x0
// Checksum 0xa5ccbb62, Offset: 0x4c8
// Size: 0x184
function __init__() {
    level._effect["lightning_miss"] = "dlc5/zmb_weapon/fx_staff_elec_impact_ug_miss";
    level._effect["lightning_arc"] = "dlc5/zmb_weapon/fx_staff_elec_trail_bolt_cheap";
    level._effect["lightning_impact"] = "dlc5/zmb_weapon/fx_staff_elec_impact_ug_hit_torso";
    level._effect["tesla_shock_eyes"] = "dlc5/zmb_weapon/fx_staff_elec_impact_ug_hit_eyes";
    clientfield::register("actor", "lightning_impact_fx", 21000, 1, "int");
    clientfield::register("scriptmover", "lightning_miss_fx", 21000, 1, "int");
    clientfield::register("actor", "lightning_arc_fx", 21000, 1, "int");
    zombie_utility::set_zombie_var("tesla_head_gib_chance", 50);
    callback::on_spawned(&onplayerspawned);
    zm_spawner::register_zombie_damage_callback(&function_953e408d);
    zm_spawner::register_zombie_death_event_callback(&function_7798d878);
}

// Namespace zm_weap_staff_lightning
// Params 0, eflags: 0x0
// Checksum 0x7e4f50e1, Offset: 0x658
// Size: 0x3c
function onplayerspawned() {
    self endon(#"disconnect");
    self thread function_acd99507();
    self thread zm_tomb_utility::function_56cd26ed();
}

// Namespace zm_weap_staff_lightning
// Params 0, eflags: 0x0
// Checksum 0x33d3ff64, Offset: 0x6a0
// Size: 0xf0
function function_acd99507() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"missile_fire", e_projectile, str_weapon);
        if (str_weapon.name == "staff_lightning_upgraded2" || str_weapon.name == "staff_lightning_upgraded3") {
            fire_angles = vectortoangles(self getweaponforwarddir());
            fire_origin = self getweaponmuzzlepoint();
            self thread function_a8590978(fire_origin, fire_angles, str_weapon);
        }
    }
}

// Namespace zm_weap_staff_lightning
// Params 1, eflags: 0x0
// Checksum 0xa538717c, Offset: 0x798
// Size: 0x2e
function lightning_ball_wait(n_lifetime_after_move) {
    level endon(#"lightning_ball_created");
    self waittill(#"movedone");
    wait n_lifetime_after_move;
    return true;
}

// Namespace zm_weap_staff_lightning
// Params 3, eflags: 0x0
// Checksum 0xc03e7164, Offset: 0x7d0
// Size: 0x36c
function function_a8590978(var_177e8ec4, v_angles, str_weapon) {
    self endon(#"disconnect");
    level notify(#"lightning_ball_created");
    if (!isdefined(v_angles)) {
        v_angles = (0, 0, 0);
    }
    e_ball_fx = spawn("script_model", var_177e8ec4 + anglestoforward(v_angles) * 100);
    e_ball_fx.angles = v_angles;
    e_ball_fx.str_weapon = str_weapon;
    e_ball_fx setmodel("tag_origin");
    e_ball_fx.n_range = function_fa6fe615(self.chargeshotlevel);
    e_ball_fx.n_damage_per_sec = function_c05b38ce(self.chargeshotlevel);
    e_ball_fx clientfield::set("lightning_miss_fx", 1);
    var_b6f44f8a = function_824c8a30(self.chargeshotlevel);
    v_end = var_177e8ec4 + anglestoforward(v_angles) * var_b6f44f8a;
    trace = bullettrace(var_177e8ec4, v_end, 0, self);
    if (trace["fraction"] != 1) {
        v_end = trace["position"];
    }
    staff_lightning_ball_speed = var_b6f44f8a / 8;
    n_dist = distance(e_ball_fx.origin, v_end);
    n_max_movetime_s = var_b6f44f8a / staff_lightning_ball_speed;
    n_movetime_s = n_dist / staff_lightning_ball_speed;
    n_leftover_time = n_max_movetime_s - n_movetime_s;
    e_ball_fx thread staff_lightning_ball_kill_zombies(self);
    /#
        e_ball_fx thread zm_tomb_utility::function_5de0d079("<dev string:x28>", (-81, 0, -1));
    #/
    e_ball_fx moveto(v_end, n_movetime_s);
    finished_playing = e_ball_fx lightning_ball_wait(n_leftover_time);
    e_ball_fx notify(#"stop_killing");
    e_ball_fx notify(#"stop_debug_position");
    if (isdefined(finished_playing) && finished_playing) {
        wait 3;
    }
    if (isdefined(e_ball_fx)) {
        e_ball_fx delete();
    }
}

// Namespace zm_weap_staff_lightning
// Params 1, eflags: 0x0
// Checksum 0xf2ccab03, Offset: 0xb48
// Size: 0x118
function staff_lightning_ball_kill_zombies(e_attacker) {
    self endon(#"death");
    self endon(#"stop_killing");
    while (true) {
        a_zombies = staff_lightning_get_valid_targets(e_attacker, self.origin);
        if (isdefined(a_zombies)) {
            foreach (zombie in a_zombies) {
                if (staff_lightning_is_target_valid(zombie)) {
                    e_attacker thread staff_lightning_arc_fx(self, zombie);
                    wait 0.2;
                }
            }
        }
        wait 0.5;
    }
}

// Namespace zm_weap_staff_lightning
// Params 2, eflags: 0x0
// Checksum 0xe27d4559, Offset: 0xc68
// Size: 0x122
function staff_lightning_get_valid_targets(player, v_source) {
    player endon(#"disconnect");
    a_enemies = [];
    a_zombies = getaiarray();
    a_zombies = util::get_array_of_closest(v_source, a_zombies, undefined, undefined, self.n_range);
    if (isdefined(a_zombies)) {
        foreach (ai_zombie in a_zombies) {
            if (staff_lightning_is_target_valid(ai_zombie)) {
                a_enemies[a_enemies.size] = ai_zombie;
            }
        }
    }
    return a_enemies;
}

// Namespace zm_weap_staff_lightning
// Params 1, eflags: 0x0
// Checksum 0x6305d988, Offset: 0xd98
// Size: 0x20
function function_824c8a30(n_charge) {
    switch (n_charge) {
    case 3:
        return 1200;
    default:
        return 800;
    }
}

// Namespace zm_weap_staff_lightning
// Params 1, eflags: 0x0
// Checksum 0xa261e509, Offset: 0xde0
// Size: 0x72
function function_fa6fe615(n_charge) {
    switch (n_charge) {
    case 1:
        n_range = -56;
        break;
    case 2:
        n_range = -106;
        break;
    case 3:
    default:
        n_range = -6;
        break;
    }
    return n_range;
}

// Namespace zm_weap_staff_lightning
// Params 1, eflags: 0x0
// Checksum 0xa9c32486, Offset: 0xe60
// Size: 0x30
function function_c05b38ce(n_charge) {
    if (!isdefined(n_charge)) {
        return 2500;
    }
    switch (n_charge) {
    case 3:
        return 3500;
    default:
        return 2500;
    }
}

// Namespace zm_weap_staff_lightning
// Params 1, eflags: 0x0
// Checksum 0xb7e8382d, Offset: 0xeb8
// Size: 0x6e
function staff_lightning_is_target_valid(ai_zombie) {
    if (!isdefined(ai_zombie)) {
        return false;
    }
    if (isdefined(ai_zombie.is_being_zapped) && ai_zombie.is_being_zapped) {
        return false;
    }
    if (isdefined(ai_zombie.is_mechz) && ai_zombie.is_mechz) {
        return false;
    }
    return true;
}

// Namespace zm_weap_staff_lightning
// Params 3, eflags: 0x0
// Checksum 0x5ffd488c, Offset: 0xf30
// Size: 0x2ec
function staff_lightning_ball_damage_over_time(e_source, e_target, e_attacker) {
    e_attacker endon(#"disconnect");
    e_target clientfield::set("lightning_impact_fx", 1);
    n_range_sq = e_source.n_range * e_source.n_range;
    e_target.is_being_zapped = 1;
    e_target clientfield::set("lightning_arc_fx", 1);
    wait 0.5;
    if (isdefined(e_source)) {
        if (!isdefined(e_source.n_damage_per_sec)) {
            e_source.n_damage_per_sec = function_c05b38ce(e_attacker.chargeshotlevel);
        }
        n_damage_per_pulse = e_source.n_damage_per_sec * 1;
    }
    while (isdefined(e_source) && isalive(e_target)) {
        e_target thread stun_zombie();
        wait 1;
        if (!isdefined(e_source) || !isalive(e_target)) {
            break;
        }
        n_dist_sq = distancesquared(e_source.origin, e_target.origin);
        if (n_dist_sq > n_range_sq) {
            break;
        }
        if (isalive(e_target) && isdefined(e_source)) {
            instakill_on = e_attacker zm_powerups::is_insta_kill_active();
            if (n_damage_per_pulse < e_target.health && !instakill_on) {
                e_target zm_tomb_utility::function_2f31684b(e_attacker, n_damage_per_pulse, e_source.str_weapon, "MOD_RIFLE_BULLET");
                continue;
            }
            e_target thread zombie_shock_eyes();
            e_target thread function_39693792(e_attacker, e_source.str_weapon);
            break;
        }
    }
    if (isdefined(e_target)) {
        e_target.is_being_zapped = 0;
        e_target clientfield::set("lightning_arc_fx", 0);
    }
}

// Namespace zm_weap_staff_lightning
// Params 2, eflags: 0x0
// Checksum 0x9dc306fd, Offset: 0x1228
// Size: 0xbc
function staff_lightning_arc_fx(e_source, ai_zombie) {
    self endon(#"disconnect");
    if (!isdefined(ai_zombie)) {
        return;
    }
    if (!zm_tomb_utility::bullet_trace_throttled(e_source.origin, ai_zombie.origin + (0, 0, 20), ai_zombie)) {
        return;
    }
    if (isdefined(e_source) && isdefined(ai_zombie) && isalive(ai_zombie)) {
        level thread staff_lightning_ball_damage_over_time(e_source, ai_zombie, self);
    }
}

// Namespace zm_weap_staff_lightning
// Params 2, eflags: 0x0
// Checksum 0xfa1af81, Offset: 0x12f0
// Size: 0xa4
function function_39693792(player, str_weapon) {
    player endon(#"disconnect");
    if (!isalive(self)) {
        return;
    }
    self.var_26747e92 = 1;
    self zm_tomb_utility::function_2f31684b(player, self.health, str_weapon, "MOD_RIFLE_BULLET");
    player zm_score::player_add_points("death", "", "");
}

// Namespace zm_weap_staff_lightning
// Params 0, eflags: 0x0
// Checksum 0x2f32950b, Offset: 0x13a0
// Size: 0x44
function function_5cbd1b5a() {
    if (isdefined(self)) {
        self clientfield::set("lightning_impact_fx", 1);
        self thread zombie_shock_eyes();
    }
}

// Namespace zm_weap_staff_lightning
// Params 3, eflags: 0x0
// Checksum 0xcd74b845, Offset: 0x13f0
// Size: 0x6c
function zombie_shock_eyes_network_safe(fx, entity, tag) {
    if (zm_net::network_entity_valid(entity)) {
        if (!(isdefined(self.head_gibbed) && self.head_gibbed)) {
            playfxontag(fx, entity, tag);
        }
    }
}

// Namespace zm_weap_staff_lightning
// Params 0, eflags: 0x0
// Checksum 0x543301e9, Offset: 0x1468
// Size: 0x94
function zombie_shock_eyes() {
    if (isdefined(self.head_gibbed) && self.head_gibbed) {
        return;
    }
    if (isdefined(self.is_mechz) && self.is_mechz) {
        return;
    }
    zm_net::network_safe_init("shock_eyes", 2);
    zm_net::network_choke_action("shock_eyes", &zombie_shock_eyes_network_safe, level._effect["tesla_shock_eyes"], self, "j_eyeball_le");
}

// Namespace zm_weap_staff_lightning
// Params 13, eflags: 0x0
// Checksum 0x881de97f, Offset: 0x1508
// Size: 0xbe
function function_953e408d(mod, hit_location, var_8a2b6fe5, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (self function_e958695f(self.damageweapon) && self.damagemod != "MOD_RIFLE_BULLET") {
        self thread stun_zombie();
    }
    return false;
}

// Namespace zm_weap_staff_lightning
// Params 1, eflags: 0x0
// Checksum 0xb1c4bf80, Offset: 0x15d0
// Size: 0x60
function function_e958695f(weapon) {
    return (weapon.name == "staff_lightning" || isdefined(weapon) && weapon.name == "staff_lightning_upgraded") && !(isdefined(self.var_6fb1ac4a) && self.var_6fb1ac4a);
}

// Namespace zm_weap_staff_lightning
// Params 1, eflags: 0x0
// Checksum 0x8ed2b4c4, Offset: 0x1638
// Size: 0x11c
function function_7798d878(attacker) {
    if (function_e958695f(self.damageweapon) && self.damagemod != "MOD_MELEE") {
        if (isdefined(self.is_mechz) && self.is_mechz) {
            return;
        }
        self thread zombie_utility::zombie_eye_glow_stop();
        self.var_26747e92 = 1;
        tag = "J_SpineUpper";
        self clientfield::set("lightning_impact_fx", 1);
        self thread zombie_shock_eyes();
        if (isdefined(self.deathanim)) {
            self waittillmatch(#"death_anim", "die");
        }
        self zm_tomb_utility::function_2f31684b(self.attacker, self.health, self.damageweapon, "MOD_RIFLE_BULLET");
    }
}

// Namespace zm_weap_staff_lightning
// Params 0, eflags: 0x0
// Checksum 0xf77813cd, Offset: 0x1760
// Size: 0x118
function stun_zombie() {
    self endon(#"death");
    if (isdefined(self.is_mechz) && self.is_mechz) {
        return;
    }
    if (isdefined(self.is_electrocuted) && self.is_electrocuted) {
        return;
    }
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
        return;
    }
    self.var_c61e3943 = 1;
    self.ignoreall = 1;
    self.is_electrocuted = 1;
    tag = "J_SpineUpper";
    self clientfield::set("lightning_impact_fx", 1);
    if (!(isdefined(self.missinglegs) && self.missinglegs)) {
        self.var_b52ab77a = 1;
    }
    self zombie_shared::donotetracks("stunned");
    self.var_c61e3943 = 0;
    self.ignoreall = 0;
    self.is_electrocuted = 0;
}

