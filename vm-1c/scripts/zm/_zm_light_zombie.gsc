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

#namespace zm_light_zombie;

// Namespace zm_light_zombie
// Params 0, eflags: 0x2
// Checksum 0xd7e28d21, Offset: 0x418
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_light_zombie", &__init__, undefined, undefined);
}

// Namespace zm_light_zombie
// Params 0, eflags: 0x1 linked
// Checksum 0xaf548679, Offset: 0x458
// Size: 0x2c
function __init__() {
    register_clientfields();
    /#
        thread function_ff8b7145();
    #/
}

// Namespace zm_light_zombie
// Params 0, eflags: 0x5 linked
// Checksum 0x660078b6, Offset: 0x490
// Size: 0x94
function private register_clientfields() {
    clientfield::register("actor", "light_zombie_clientfield_aura_fx", 15000, 1, "int");
    clientfield::register("actor", "light_zombie_clientfield_death_fx", 15000, 1, "int");
    clientfield::register("actor", "light_zombie_clientfield_damaged_fx", 15000, 1, "counter");
}

// Namespace zm_light_zombie
// Params 0, eflags: 0x1 linked
// Checksum 0xdcea95c4, Offset: 0x530
// Size: 0x11c
function function_a35db70f() {
    ai_zombie = self;
    var_715d2624 = zm_elemental_zombie::function_4aeed0a5("light");
    if (!isdefined(level.var_4a762097) || var_715d2624 < level.var_4a762097) {
        if (!isdefined(ai_zombie.var_6c653628) || ai_zombie.var_6c653628 == 0) {
            ai_zombie.var_6c653628 = 1;
            ai_zombie.var_9a02a614 = "light";
            ai_zombie.health = int(ai_zombie.health * 1);
            ai_zombie thread light_zombie_death();
            ai_zombie thread function_68da949();
            ai_zombie thread function_cb744db7();
        }
    }
}

// Namespace zm_light_zombie
// Params 0, eflags: 0x1 linked
// Checksum 0x3b185d59, Offset: 0x658
// Size: 0x34
function function_cb744db7() {
    self endon(#"death");
    wait 2;
    self clientfield::set("light_zombie_clientfield_aura_fx", 1);
}

// Namespace zm_light_zombie
// Params 0, eflags: 0x1 linked
// Checksum 0xb0d7002a, Offset: 0x698
// Size: 0x78
function function_68da949() {
    self endon(#"entityshutdown");
    self endon(#"death");
    while (true) {
        self waittill(#"damage");
        if (randomint(100) < 50) {
            self clientfield::increment("light_zombie_clientfield_damaged_fx");
        }
        wait 0.05;
    }
}

// Namespace zm_light_zombie
// Params 0, eflags: 0x1 linked
// Checksum 0xd1349829, Offset: 0x718
// Size: 0x1fc
function light_zombie_death() {
    ai_zombie = self;
    attacker = ai_zombie waittill(#"death");
    if (!isdefined(ai_zombie) || ai_zombie.nuked === 1) {
        return;
    }
    v_origin = ai_zombie.origin;
    v_origin += (0, 0, 2);
    ai_zombie clientfield::set("light_zombie_clientfield_death_fx", 1);
    ai_zombie zombie_utility::gib_random_parts();
    wait 0.05;
    var_e0d84aa = "MOD_EXPLOSIVE";
    radiusdamage(ai_zombie.origin + (0, 0, 35), -128, 30, 10, self, var_e0d84aa);
    a_players = getplayers();
    foreach (player in a_players) {
        player thread function_4745b0a9(ai_zombie.origin);
    }
    ai_zombie hide();
    ai_zombie notsolid();
}

// Namespace zm_light_zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x7d16cc23, Offset: 0x920
// Size: 0x194
function function_4745b0a9(var_ed7f4cc6) {
    self endon(#"death");
    self endon(#"disconnect");
    player = self;
    dist_sq = distancesquared(player.origin, var_ed7f4cc6);
    var_bfff29b1 = 16384;
    var_1536d9e9 = 4096;
    var_b79af7d4 = var_bfff29b1 - var_1536d9e9;
    if (dist_sq <= var_bfff29b1 && !(isdefined(player.var_442e1e5b) && player.var_442e1e5b)) {
        if (dist_sq < var_1536d9e9) {
            var_9bde339b = 1;
        } else {
            var_ff8b2f91 = (var_bfff29b1 - dist_sq) / var_b79af7d4;
            var_6e07e9bc = var_ff8b2f91 * 0.5;
            var_9bde339b = 1 - var_6e07e9bc;
        }
        if (isdefined(var_9bde339b)) {
            var_9bde339b = math::clamp(var_9bde339b, 0.5, 1);
            player thread function_2335214f(var_9bde339b);
        }
    }
}

// Namespace zm_light_zombie
// Params 1, eflags: 0x1 linked
// Checksum 0xc3b9d835, Offset: 0xac0
// Size: 0x7c
function function_2335214f(var_9bde339b) {
    self endon(#"death");
    self endon(#"disconnect");
    player = self;
    player.var_442e1e5b = 1;
    player shellshock("light_zombie_death", var_9bde339b, 0);
    wait 5;
    player.var_442e1e5b = 0;
}

/#

    // Namespace zm_light_zombie
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9b395481, Offset: 0xb48
    // Size: 0x228
    function function_ff8b7145() {
        wait 0.05;
        level waittill(#"start_zombie_round_logic");
        wait 0.05;
        str_cmd = "<dev string:x28>";
        adddebugcommand(str_cmd);
        str_cmd = "<dev string:x85>";
        adddebugcommand(str_cmd);
        while (true) {
            string = getdvarstring("<dev string:xe8>");
            if (string == "<dev string:xf3>") {
                a_zombies = zm_elemental_zombie::function_d41418b8();
                if (a_zombies.size > 0) {
                    foreach (zombie in a_zombies) {
                        zombie function_a35db70f();
                    }
                }
                setdvar("<dev string:xe8>", "<dev string:x109>");
            }
            if (string == "<dev string:x10a>") {
                a_zombies = zm_elemental_zombie::function_d41418b8();
                if (a_zombies.size > 0) {
                    a_zombies = arraysortclosest(a_zombies, level.players[0].origin);
                    a_zombies[0] function_a35db70f();
                }
                setdvar("<dev string:xe8>", "<dev string:x109>");
            }
            wait 0.05;
        }
    }

#/
