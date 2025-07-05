#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/craftables/_zm_craftables;

#using_animtree("zm_genesis");

#namespace zm_genesis_shadowman;

// Namespace zm_genesis_shadowman
// Params 0, eflags: 0x2
// Checksum 0x39f22b80, Offset: 0x448
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_genesis_shadowman", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_shadowman
// Params 0, eflags: 0x0
// Checksum 0x1a15fb5e, Offset: 0x490
// Size: 0x6c
function __init__() {
    level._effect["shadowman_impact_fx"] = "zombie/fx_shdw_impact_zod_zmb";
    level._effect["shadowman_damaged_fx"] = "zombie/fx_powerup_nuke_zmb";
    clientfield::register("scriptmover", "shadowman_fx", 15000, 3, "int");
}

// Namespace zm_genesis_shadowman
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x508
// Size: 0x4
function __main__() {
    
}

// Namespace zm_genesis_shadowman
// Params 4, eflags: 0x0
// Checksum 0x113788f1, Offset: 0x518
// Size: 0x1cc
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
    self.var_94d7beef = util::spawn_model("c_zom_dlc4_shadowman_fb", self.origin, self.angles);
    self.var_94d7beef useanimtree(#zm_genesis);
    self.var_94d7beef.health = 1000000;
    util::wait_network_frame();
    self.var_94d7beef clientfield::set("shadowman_fx", 1);
    if (var_d250bd20) {
        if (var_32a5629a) {
            self.var_94d7beef thread animation::play("ai_zm_dlc4_shadowman_idle");
        } else {
            self.var_94d7beef thread animation::play("ai_zm_dlc4_shadowman_idle");
        }
    }
    if (var_5b35973a) {
        self.var_94d7beef setcandamage(1);
    } else {
        self.var_94d7beef setcandamage(0);
    }
    if (var_2c1a0d8f) {
        self.var_94d7beef setinvisibletoall();
    }
}

