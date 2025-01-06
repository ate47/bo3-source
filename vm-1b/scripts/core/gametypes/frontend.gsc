#using scripts/codescripts/struct;
#using scripts/core/gametypes/frontend_zm_bgb_chance;
#using scripts/shared/ai/animation_selector_table_evaluators;
#using scripts/shared/ai/archetype_cover_utility;
#using scripts/shared/ai/archetype_damage_effects;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/behavior_state_machine_planners_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;

#using_animtree("all_player");

#namespace frontend;

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x3c0
// Size: 0x2
function callback_void() {
    
}

// Namespace frontend
// Params 1, eflags: 0x0
// Checksum 0x265840b, Offset: 0x3d0
// Size: 0x1a
function callback_actorspawnedfrontend(spawner) {
    self thread spawner::spawn_think(spawner);
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0x419b5a52, Offset: 0x3f8
// Size: 0x2b2
function main() {
    level.callbackstartgametype = &callback_void;
    level.callbackplayerconnect = &callback_void;
    level.callbackplayerdisconnect = &callback_void;
    level.callbackentityspawned = &callback_void;
    level.callbackactorspawned = &callback_actorspawnedfrontend;
    level.orbis = getdvarstring("orbisGame") == "true";
    level.durango = getdvarstring("durangoGame") == "true";
    clientfield::register("world", "first_time_flow", 1, getminbitcountfornum(1), "int");
    clientfield::register("world", "cp_bunk_anim_type", 1, getminbitcountfornum(1), "int");
    clientfield::register("actor", "zombie_has_eyes", 1, 1, "int");
    level.weaponnone = getweapon("none");
    /#
        setdvar("<dev string:x28>", 0);
        adddebugcommand("<dev string:x41>");
        setdvar("<dev string:x91>", "<dev string:xa8>");
        adddebugcommand("<dev string:xb0>");
        adddebugcommand("<dev string:x104>");
        adddebugcommand("<dev string:x15a>");
        adddebugcommand("<dev string:x1b6>");
        clientfield::register("<dev string:x20e>", "<dev string:x214>", 1, 1, "<dev string:x22f>");
        clientfield::register("<dev string:x20e>", "<dev string:x233>", 1, 1, "<dev string:x22f>");
    #/
    level thread function_78987129();
    level thread zm_frontend_zm_bgb_chance::zm_frontend_bgb_slots_logic();
    level thread function_f7d50167();
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0xb90ef0e6, Offset: 0x6b8
// Size: 0xa
function function_f7d50167() {
    wait 0.05;
    InvalidOpCode(0xc9);
    // Unknown operator (0xc9, t7_1b, PC)
}

// Namespace frontend
// Params 0, eflags: 0x0
// Checksum 0x4e300d69, Offset: 0x798
// Size: 0x167
function function_78987129() {
    wait 5;
    var_765b3a01 = getentarray("sp_zombie_frontend", "targetname");
    while (true) {
        var_765b3a01 = array::randomize(var_765b3a01);
        foreach (sp_zombie in var_765b3a01) {
            while (getaicount() >= 20) {
                wait 1;
            }
            ai_zombie = sp_zombie spawnfromspawner();
            if (isdefined(ai_zombie)) {
                ai_zombie sethighdetail(1);
                ai_zombie setavoidancemask("avoid all");
                ai_zombie function_1762804b(0);
                ai_zombie clientfield::set("zombie_has_eyes", 1);
                ai_zombie.delete_on_path_end = 1;
                sp_zombie.count++;
            }
            wait randomfloatrange(3, 8);
        }
    }
}

