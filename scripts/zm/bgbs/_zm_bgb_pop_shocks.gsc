#using scripts/shared/ai/systems/gib;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_lightning_chain;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_pop_shocks;

// Namespace zm_bgb_pop_shocks
// Params 0, eflags: 0x2
// Checksum 0x5d6d53e0, Offset: 0x1d8
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_pop_shocks", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_pop_shocks
// Params 0, eflags: 0x1 linked
// Checksum 0x45ddd2c6, Offset: 0x218
// Size: 0xa4
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_pop_shocks", "event", &event, undefined, undefined, undefined);
    bgb::register_actor_damage_override("zm_bgb_pop_shocks", &actor_damage_override);
    bgb::register_vehicle_damage_override("zm_bgb_pop_shocks", &vehicle_damage_override);
}

// Namespace zm_bgb_pop_shocks
// Params 0, eflags: 0x1 linked
// Checksum 0x235259fa, Offset: 0x2c8
// Size: 0x50
function event() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"bgb_update");
    self.var_69d5dd7c = 5;
    while (self.var_69d5dd7c > 0) {
        wait(0.1);
    }
}

// Namespace zm_bgb_pop_shocks
// Params 12, eflags: 0x1 linked
// Checksum 0xab421b3c, Offset: 0x320
// Size: 0x90
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (meansofdeath === "MOD_MELEE") {
        attacker function_e0e68a99(self);
    }
    return damage;
}

// Namespace zm_bgb_pop_shocks
// Params 15, eflags: 0x1 linked
// Checksum 0x8b94df9e, Offset: 0x3b8
// Size: 0xa8
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (smeansofdeath === "MOD_MELEE") {
        eattacker function_e0e68a99(self);
    }
    return idamage;
}

// Namespace zm_bgb_pop_shocks
// Params 1, eflags: 0x1 linked
// Checksum 0xb40bff8c, Offset: 0x468
// Size: 0x1ca
function function_e0e68a99(target) {
    if (isdefined(self.beastmode) && self.beastmode) {
        return;
    }
    self bgb::do_one_shot_use();
    self.var_69d5dd7c -= 1;
    self bgb::set_timer(self.var_69d5dd7c, 5);
    self playsound("zmb_bgb_popshocks_impact");
    zombie_list = getaiteamarray(level.zombie_team);
    foreach (ai in zombie_list) {
        if (!isdefined(ai) || !isalive(ai)) {
            continue;
        }
        test_origin = ai getcentroid();
        dist_sq = distancesquared(target.origin, test_origin);
        if (dist_sq < 16384) {
            self thread electrocute_actor(ai);
        }
    }
}

// Namespace zm_bgb_pop_shocks
// Params 1, eflags: 0x1 linked
// Checksum 0x4d924c41, Offset: 0x640
// Size: 0xc4
function electrocute_actor(ai) {
    self endon(#"disconnect");
    if (!isdefined(ai) || !isalive(ai)) {
        return;
    }
    ai notify(#"bhtn_action_notify", "electrocute");
    if (!isdefined(self.tesla_enemies_hit)) {
        self.tesla_enemies_hit = 1;
    }
    create_lightning_params();
    ai.tesla_death = 0;
    ai thread arc_damage_init(self);
    ai thread tesla_death();
}

// Namespace zm_bgb_pop_shocks
// Params 0, eflags: 0x1 linked
// Checksum 0x2fbcb64c, Offset: 0x710
// Size: 0x60
function create_lightning_params() {
    level.zm_bgb_pop_shocks_lightning_params = lightning_chain::create_lightning_chain_params(5);
    level.zm_bgb_pop_shocks_lightning_params.head_gib_chance = 100;
    level.zm_bgb_pop_shocks_lightning_params.network_death_choke = 4;
    level.zm_bgb_pop_shocks_lightning_params.should_kill_enemies = 0;
}

// Namespace zm_bgb_pop_shocks
// Params 1, eflags: 0x1 linked
// Checksum 0x2da98f28, Offset: 0x778
// Size: 0x54
function arc_damage_init(player) {
    player endon(#"disconnect");
    if (isdefined(self.var_128cd975) && self.var_128cd975) {
        return;
    }
    self lightning_chain::arc_damage_ent(player, 1, level.zm_bgb_pop_shocks_lightning_params);
}

// Namespace zm_bgb_pop_shocks
// Params 0, eflags: 0x1 linked
// Checksum 0xb398d8d7, Offset: 0x7d8
// Size: 0x54
function tesla_death() {
    self endon(#"death");
    self thread function_862aadab(1);
    wait(2);
    self dodamage(self.health + 1, self.origin);
}

// Namespace zm_bgb_pop_shocks
// Params 1, eflags: 0x1 linked
// Checksum 0xb70d9173, Offset: 0x838
// Size: 0x134
function function_862aadab(random_gibs) {
    self waittill(#"death");
    if (isdefined(self) && isactor(self)) {
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibhead(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibleftarm(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibrightarm(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::giblegs(self);
        }
    }
}

