#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_zm_bgb;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_9dd35181;

// Namespace namespace_9dd35181
// Params 0, eflags: 0x2
// Checksum 0x5c5c62ec, Offset: 0x288
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_killing_time", &__init__, undefined, "bgb");
}

// Namespace namespace_9dd35181
// Params 0, eflags: 0x1 linked
// Checksum 0xde1d1345, Offset: 0x2c8
// Size: 0x12c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    level flag::init("world_is_paused");
    bgb::register("zm_bgb_killing_time", "activated", 1, undefined, undefined, &validation, &activation);
    bgb::register_actor_damage_override("zm_bgb_killing_time", &actor_damage_override);
    zm::register_vehicle_damage_callback(&vehicle_damage_override);
    clientfield::register("actor", "zombie_instakill_fx", 1, 1, "int");
    clientfield::register("toplayer", "instakill_upgraded_fx", 1, 1, "int");
}

// Namespace namespace_9dd35181
// Params 0, eflags: 0x1 linked
// Checksum 0xa7f568d7, Offset: 0x400
// Size: 0x1c
function activation() {
    self function_eb0b4e74();
}

// Namespace namespace_9dd35181
// Params 0, eflags: 0x1 linked
// Checksum 0x76f082ab, Offset: 0x428
// Size: 0x44
function validation() {
    if (bgb::is_team_active("zm_bgb_killing_time")) {
        return 0;
    }
    if (isdefined(level.var_9f5c2c50)) {
        return [[ level.var_9f5c2c50 ]]();
    }
    return 1;
}

// Namespace namespace_9dd35181
// Params 13, eflags: 0x5 linked
// Checksum 0xaafc20f0, Offset: 0x478
// Size: 0x1fe
function actor_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (self.archetype !== "zombie") {
        return idamage;
    }
    if (isdefined(level.var_48c4b2bf) && !(isdefined([[ level.var_48c4b2bf ]](self)) && [[ level.var_48c4b2bf ]](self))) {
        return idamage;
    }
    if (isdefined(self.interdimensional_gun_weapon) && isdefined(self.interdimensional_gun_attacker)) {
        return idamage;
    }
    if (isdefined(eattacker.forceanhilateondeath) && isplayer(eattacker) && eattacker.forceanhilateondeath) {
        if (isdefined(eattacker.var_d63e841a) && eattacker.var_d63e841a) {
            /#
                assert(isdefined(eattacker.var_b3258f2e));
            #/
            if (!isinarray(eattacker.var_b3258f2e, self)) {
                eattacker.var_b3258f2e[eattacker.var_b3258f2e.size] = self;
                self thread zombie_utility::zombie_eye_glow_stop();
            }
            return 0;
        } else {
            self clientfield::set("zombie_instakill_fx", 1);
            return (self.health + 1);
        }
    }
    return idamage;
}

// Namespace namespace_9dd35181
// Params 15, eflags: 0x5 linked
// Checksum 0xb76ca299, Offset: 0x680
// Size: 0x19e
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(self.var_a0e2dfff) && self.var_a0e2dfff) {
        return idamage;
    }
    if (isdefined(eattacker.forceanhilateondeath) && isplayer(eattacker) && eattacker.forceanhilateondeath) {
        if (isdefined(eattacker.var_d63e841a) && eattacker.var_d63e841a) {
            /#
                assert(isdefined(eattacker.var_b3258f2e));
            #/
            if (!isinarray(eattacker.var_b3258f2e, self)) {
                eattacker.var_b3258f2e[eattacker.var_b3258f2e.size] = self;
            }
            return 0;
        } else {
            return (self.health + 1);
        }
    } else if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
        return 0;
    }
    return idamage;
}

// Namespace namespace_9dd35181
// Params 0, eflags: 0x1 linked
// Checksum 0xd8f430f8, Offset: 0x828
// Size: 0x19a
function function_eb0b4e74() {
    self endon(#"death");
    /#
        assert(!isdefined(self.var_b3258f2e));
    #/
    foreach (player in level.players) {
        player clientfield::set_to_player("instakill_upgraded_fx", 1);
    }
    self.var_b3258f2e = [];
    self.forceanhilateondeath = 1;
    self playsound("zmb_bgb_killingtime_start");
    self playloopsound("zmb_bgb_killingtime_loop", 1);
    self.var_d63e841a = 1;
    level.bzm_worldpaused = 1;
    level flag::set("world_is_paused");
    setpauseworld(1);
    self thread function_f2925308();
    self bgb::run_timer(20);
    self notify(#"hash_19c1b90c");
}

// Namespace namespace_9dd35181
// Params 0, eflags: 0x1 linked
// Checksum 0x7493596e, Offset: 0x9d0
// Size: 0x27c
function function_f2925308() {
    str_notify = self util::waittill_any_return("death", "killing_time_done");
    if (str_notify == "killing_time_done") {
        self.var_d63e841a = 0;
        self stoploopsound(0.5);
        self playsound("zmb_bgb_killingtime_end");
        foreach (player in level.players) {
            self clientfield::set_to_player("instakill_upgraded_fx", 0);
        }
        for (i = self.var_b3258f2e.size - 1; i >= 0; i--) {
            ai = self.var_b3258f2e[i];
            if (isdefined(ai) && isalive(ai)) {
                if (isactor(ai)) {
                    ai asmsetanimationrate(1);
                    ai zombie_utility::gib_random_parts();
                    gibserverutils::annihilate(ai);
                }
                ai dodamage(ai.health + 1, self.origin, self);
            }
        }
        self.var_b3258f2e = undefined;
        self.forceanhilateondeath = 0;
    }
    level.bzm_worldpaused = 0;
    setpauseworld(0);
    level flag::clear("world_is_paused");
}

