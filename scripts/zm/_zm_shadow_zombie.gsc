#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_devgui;
#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/_burnplayer;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai_shared;

#namespace namespace_df1a4a92;

// Namespace namespace_df1a4a92
// Params 0, eflags: 0x2
// Checksum 0xad6dad33, Offset: 0x4a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_shadow_zombie", &__init__, undefined, undefined);
}

// Namespace namespace_df1a4a92
// Params 0, eflags: 0x0
// Checksum 0x95da11f4, Offset: 0x4e8
// Size: 0x5c
function __init__() {
    register_clientfields();
    if (!isdefined(level._effect["cursetrap_explosion"])) {
        level._effect["cursetrap_explosion"] = "dlc4/genesis/fx_zombie_shadow_trap_exp";
    }
    /#
        thread function_71c88f2b();
    #/
}

// Namespace namespace_df1a4a92
// Params 0, eflags: 0x4
// Checksum 0xd04281e1, Offset: 0x550
// Size: 0xc4
function private register_clientfields() {
    clientfield::register("actor", "shadow_zombie_clientfield_aura_fx", 15000, 1, "int");
    clientfield::register("actor", "shadow_zombie_clientfield_death_fx", 15000, 1, "int");
    clientfield::register("actor", "shadow_zombie_clientfield_damaged_fx", 15000, 1, "counter");
    clientfield::register("scriptmover", "shadow_zombie_cursetrap_fx", 15000, 1, "int");
}

// Namespace namespace_df1a4a92
// Params 0, eflags: 0x0
// Checksum 0xc1f1e85d, Offset: 0x620
// Size: 0x12c
function function_1b2b62b() {
    ai_zombie = self;
    var_90bd2712 = namespace_57695b4d::function_4aeed0a5("shadow");
    if (!isdefined(level.var_6041e4d5) || var_90bd2712 < level.var_6041e4d5) {
        if (!isdefined(ai_zombie.var_6c653628) || ai_zombie.var_6c653628 == 0) {
            ai_zombie.var_6c653628 = 1;
            ai_zombie.var_9a02a614 = "shadow";
            ai_zombie clientfield::set("shadow_zombie_clientfield_aura_fx", 1);
            ai_zombie.health = int(ai_zombie.health * 1);
            ai_zombie thread function_32a2f099();
            ai_zombie thread function_9632763f();
        }
    }
}

// Namespace namespace_df1a4a92
// Params 0, eflags: 0x0
// Checksum 0x6857e524, Offset: 0x758
// Size: 0x78
function function_9632763f() {
    self endon(#"entityshutdown");
    self endon(#"death");
    while (true) {
        self waittill(#"damage");
        if (randomint(100) < 50) {
            self clientfield::increment("shadow_zombie_clientfield_damaged_fx");
        }
        wait(0.05);
    }
}

// Namespace namespace_df1a4a92
// Params 0, eflags: 0x0
// Checksum 0xa834f1a7, Offset: 0x7d8
// Size: 0x114
function function_32a2f099() {
    ai_zombie = self;
    attacker = ai_zombie waittill(#"death");
    if (!isdefined(ai_zombie) || ai_zombie.nuked === 1) {
        return;
    }
    v_origin = ai_zombie.origin;
    v_origin += (0, 0, 2);
    level thread function_ada13668(v_origin, undefined, 0);
    ai_zombie clientfield::set("shadow_zombie_clientfield_death_fx", 1);
    ai_zombie zombie_utility::gib_random_parts();
    wait(0.05);
    ai_zombie hide();
    ai_zombie notsolid();
}

// Namespace namespace_df1a4a92
// Params 3, eflags: 0x0
// Checksum 0xa63440ea, Offset: 0x8f8
// Size: 0x130
function function_ada13668(v_origin, n_duration, var_526fc172) {
    if (!isdefined(var_526fc172)) {
        var_526fc172 = 0;
    }
    if (var_526fc172) {
        while (function_ab84e253(v_origin, 64)) {
            wait(0.25);
        }
    }
    if (!isdefined(n_duration)) {
        n_duration = randomfloatrange(5, 10);
    }
    var_7a88c258 = util::spawn_model("tag_origin", v_origin, (-90, 0, 0));
    var_7a88c258.targetname = "shadow_curse_trap";
    var_7a88c258 clientfield::set("shadow_zombie_cursetrap_fx", 1);
    var_7a88c258 thread function_57b55fe1(n_duration);
    var_7a88c258 thread function_48fccb59();
    return var_7a88c258;
}

// Namespace namespace_df1a4a92
// Params 1, eflags: 0x4
// Checksum 0xc3161b04, Offset: 0xa30
// Size: 0x5c
function private function_57b55fe1(n_duration) {
    wait(n_duration);
    if (isdefined(self)) {
        if (isdefined(self.trigger)) {
            self.trigger delete();
        }
        self delete();
    }
}

// Namespace namespace_df1a4a92
// Params 1, eflags: 0x4
// Checksum 0x9011c59a, Offset: 0xa98
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

// Namespace namespace_df1a4a92
// Params 2, eflags: 0x0
// Checksum 0xa1c4d687, Offset: 0xc48
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

/#

    // Namespace namespace_df1a4a92
    // Params 0, eflags: 0x0
    // Checksum 0xed321119, Offset: 0xd30
    // Size: 0x228
    function function_71c88f2b() {
        wait(0.05);
        level waittill(#"start_zombie_round_logic");
        wait(0.05);
        str_cmd = "<unknown string>";
        adddebugcommand(str_cmd);
        str_cmd = "<unknown string>";
        adddebugcommand(str_cmd);
        while (true) {
            string = getdvarstring("<unknown string>");
            if (string == "<unknown string>") {
                a_zombies = namespace_57695b4d::function_d41418b8();
                if (a_zombies.size > 0) {
                    foreach (zombie in a_zombies) {
                        zombie function_1b2b62b();
                    }
                }
                setdvar("<unknown string>", "<unknown string>");
            }
            if (string == "<unknown string>") {
                a_zombies = namespace_57695b4d::function_d41418b8();
                if (a_zombies.size > 0) {
                    a_zombies = arraysortclosest(a_zombies, level.players[0].origin);
                    a_zombies[0] function_1b2b62b();
                }
                setdvar("<unknown string>", "<unknown string>");
            }
            wait(0.05);
        }
    }

#/
