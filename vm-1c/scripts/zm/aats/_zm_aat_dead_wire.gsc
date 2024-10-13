#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_lightning_chain;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace zm_aat_dead_wire;

// Namespace zm_aat_dead_wire
// Params 0, eflags: 0x2
// Checksum 0x2b13c541, Offset: 0x290
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_aat_dead_wire", &__init__, undefined, "aat");
}

// Namespace zm_aat_dead_wire
// Params 0, eflags: 0x1 linked
// Checksum 0x4f38e0da, Offset: 0x2d0
// Size: 0x13c
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_dead_wire", 0.2, 0, 5, 2, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr");
    clientfield::register("actor", "zm_aat_dead_wire" + "_zap", 1, 1, "int");
    clientfield::register("vehicle", "zm_aat_dead_wire" + "_zap_vehicle", 1, 1, "int");
    level.var_763a59fc = lightning_chain::create_lightning_chain_params(8, 9, 120);
    level.var_763a59fc.head_gib_chance = 100;
    level.var_763a59fc.network_death_choke = 4;
    level.var_763a59fc.challenge_stat_name = "ZOMBIE_HUNTER_DEAD_WIRE";
}

// Namespace zm_aat_dead_wire
// Params 4, eflags: 0x1 linked
// Checksum 0x193c00a1, Offset: 0x418
// Size: 0xcc
function result(death, attacker, mod, weapon) {
    if (!isdefined(level.zombie_vars["tesla_head_gib_chance"])) {
        zombie_utility::set_zombie_var("tesla_head_gib_chance", 50);
    }
    attacker.tesla_enemies = undefined;
    attacker.tesla_enemies_hit = 1;
    attacker.var_691298ec = 0;
    attacker.tesla_arc_count = 0;
    level.var_763a59fc.weapon = weapon;
    self lightning_chain::arc_damage(self, attacker, 1, level.var_763a59fc);
}

