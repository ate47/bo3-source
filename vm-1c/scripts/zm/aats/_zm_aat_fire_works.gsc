#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace namespace_a7e7ef63;

// Namespace namespace_a7e7ef63
// Params 0, eflags: 0x2
// Checksum 0xc17731d1, Offset: 0x278
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_aat_fire_works", &__init__, undefined, "aat");
}

// Namespace namespace_a7e7ef63
// Params 0, eflags: 0x1 linked
// Checksum 0xbb18de24, Offset: 0x2b8
// Size: 0xe4
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_fire_works", 0.1, 0, 20, 10, 1, &result, "t7_hud_zm_aat_fireworks", "wpn_aat_fire_works_plr", &function_5ae7061b);
    clientfield::register("scriptmover", "zm_aat_fire_works", 1, 1, "int");
    zm_spawner::register_zombie_damage_callback(&function_446fe502);
    zm_spawner::register_zombie_death_event_callback(&function_9b6b7072);
}

// Namespace namespace_a7e7ef63
// Params 4, eflags: 0x1 linked
// Checksum 0xb159b0ab, Offset: 0x3a8
// Size: 0x44
function result(death, attacker, mod, weapon) {
    self function_188d9054(attacker, weapon);
}

// Namespace namespace_a7e7ef63
// Params 0, eflags: 0x1 linked
// Checksum 0x2e06d898, Offset: 0x3f8
// Size: 0x86
function function_5ae7061b() {
    if (isdefined(self.barricade_enter) && self.barricade_enter) {
        return false;
    }
    if (isdefined(self.is_traversing) && self.is_traversing) {
        return false;
    }
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area) && !isdefined(self.first_node)) {
        return false;
    }
    if (isdefined(self.is_leaping) && self.is_leaping) {
        return false;
    }
    return true;
}

// Namespace namespace_a7e7ef63
// Params 2, eflags: 0x1 linked
// Checksum 0xc8ecfecc, Offset: 0x488
// Size: 0x3e4
function function_188d9054(e_player, w_weapon) {
    var_7a36cb10 = e_player getcurrentweapon();
    var_21579ac9 = self.origin;
    if (!(isdefined(level.aat["zm_aat_fire_works"].immune_result_direct[self.archetype]) && level.aat["zm_aat_fire_works"].immune_result_direct[self.archetype])) {
        self thread zombie_death_gib(e_player, w_weapon, e_player);
    }
    var_9b9e1bc2 = var_21579ac9 + (0, 0, 56);
    var_89632b0 = vectortoangles(var_9b9e1bc2 - var_21579ac9);
    var_89632b0 = (0, var_89632b0[1], 0);
    mdl_weapon = zm_utility::spawn_weapon_model(var_7a36cb10, undefined, var_21579ac9, var_89632b0);
    mdl_weapon.owner = e_player;
    mdl_weapon.b_aat_fire_works_weapon = 1;
    mdl_weapon.allow_zombie_to_target_ai = 1;
    mdl_weapon thread clientfield::set("zm_aat_fire_works", 1);
    mdl_weapon moveto(var_9b9e1bc2, 0.5);
    mdl_weapon waittill(#"movedone");
    for (i = 0; i < 10; i++) {
        zombie = mdl_weapon function_5afeec5a();
        if (!isdefined(zombie)) {
            var_2d08317c = (0, randomintrange(0, 360), 0);
            v_target_pos = mdl_weapon.origin + vectorscale(anglestoforward(var_2d08317c), 40);
        } else {
            v_target_pos = zombie getcentroid();
        }
        mdl_weapon.angles = vectortoangles(v_target_pos - mdl_weapon.origin);
        v_flash_pos = mdl_weapon gettagorigin("tag_flash");
        mdl_weapon dontinterpolate();
        magicbullet(var_7a36cb10, v_flash_pos, v_target_pos, mdl_weapon);
        util::wait_network_frame();
    }
    mdl_weapon moveto(var_21579ac9, 0.5);
    mdl_weapon waittill(#"movedone");
    mdl_weapon clientfield::set("zm_aat_fire_works", 0);
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
    mdl_weapon delete();
    wait(0.25);
}

// Namespace namespace_a7e7ef63
// Params 0, eflags: 0x1 linked
// Checksum 0x67fa111b, Offset: 0x878
// Size: 0x128
function function_5afeec5a() {
    a_ai_zombies = array::randomize(getaiteamarray("axis"));
    var_395fd7a7 = 0;
    for (i = 0; i < a_ai_zombies.size; i++) {
        zombie = a_ai_zombies[i];
        test_origin = zombie getcentroid();
        if (distancesquared(self.origin, test_origin) > 360000) {
            continue;
        }
        if (var_395fd7a7 < 3 && !zombie damageconetrace(self.origin)) {
            var_395fd7a7++;
            continue;
        }
        return zombie;
    }
    if (a_ai_zombies.size) {
        return a_ai_zombies[0];
    }
    return undefined;
}

// Namespace namespace_a7e7ef63
// Params 13, eflags: 0x1 linked
// Checksum 0xb56be1fc, Offset: 0x9a8
// Size: 0x11c
function function_446fe502(str_mod, var_5afff096, var_7c5a4ee4, e_attacker, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (isdefined(level.aat["zm_aat_fire_works"].immune_result_indirect[self.archetype]) && level.aat["zm_aat_fire_works"].immune_result_indirect[self.archetype]) {
        return false;
    }
    if (isdefined(e_attacker.b_aat_fire_works_weapon) && e_attacker.b_aat_fire_works_weapon) {
        self thread zombie_death_gib(e_attacker, w_weapon, e_attacker.owner);
        return true;
    }
    return false;
}

// Namespace namespace_a7e7ef63
// Params 1, eflags: 0x1 linked
// Checksum 0x5c4dbb96, Offset: 0xad0
// Size: 0x68
function function_9b6b7072(attacker) {
    if (isdefined(attacker)) {
        if (isdefined(attacker.b_aat_fire_works_weapon) && attacker.b_aat_fire_works_weapon) {
            if (isdefined(attacker.owner)) {
                var_8444458d = attacker.owner;
            }
        }
    }
}

// Namespace namespace_a7e7ef63
// Params 3, eflags: 0x1 linked
// Checksum 0x9d35d25f, Offset: 0xb40
// Size: 0x104
function zombie_death_gib(e_attacker, w_weapon, e_owner) {
    gibserverutils::gibhead(self);
    if (math::cointoss()) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
    self dodamage(self.health, self.origin, e_attacker, w_weapon, "torso_upper");
    if (isdefined(e_owner) && isplayer(e_owner)) {
        e_owner zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_FIRE_WORKS");
    }
}

