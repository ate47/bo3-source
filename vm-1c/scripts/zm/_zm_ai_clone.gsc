#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/archetype_clone;
#using scripts/zm/_zm_devgui;
#using scripts/shared/flagsys_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_behavior;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/aat_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_bd8be9f1;

// Namespace namespace_bd8be9f1
// Params 0, eflags: 0x2
// Checksum 0x3656668a, Offset: 0x3a8
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_ai_clone", &__init__, &__main__, undefined);
}

// Namespace namespace_bd8be9f1
// Params 0, eflags: 0x1 linked
// Checksum 0x82d72a9f, Offset: 0x3f0
// Size: 0x64
function __init__() {
    level flag::init("thrasher_round");
    /#
        execdevgui("<unknown string>");
        thread function_78933fc2();
    #/
    init();
}

// Namespace namespace_bd8be9f1
// Params 0, eflags: 0x1 linked
// Checksum 0x5d118d13, Offset: 0x460
// Size: 0x14
function __main__() {
    register_clientfields();
}

// Namespace namespace_bd8be9f1
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x480
// Size: 0x4
function register_clientfields() {
    
}

// Namespace namespace_bd8be9f1
// Params 0, eflags: 0x1 linked
// Checksum 0xf72a6783, Offset: 0x490
// Size: 0x14
function init() {
    precache();
}

// Namespace namespace_bd8be9f1
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x4b0
// Size: 0x4
function precache() {
    
}

/#

    // Namespace namespace_bd8be9f1
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1a73a026, Offset: 0x4c0
    // Size: 0x44
    function function_78933fc2() {
        level flagsys::wait_till("<unknown string>");
        zm_devgui::add_custom_devgui_callback(&function_46924c5);
    }

    // Namespace namespace_bd8be9f1
    // Params 1, eflags: 0x1 linked
    // Checksum 0x52e3cfd0, Offset: 0x510
    // Size: 0x1e6
    function function_46924c5(cmd) {
        switch (cmd) {
        case 8:
            players = getplayers();
            queryresult = positionquery_source_navigation(players[0].origin, -128, 256, -128, 20);
            if (isdefined(queryresult) && queryresult.data.size > 0) {
                clone = spawnactor("<unknown string>", queryresult.data[0].origin, (0, 0, 0), "<unknown string>", 1);
                clone namespace_16383e98::function_c80742de(clone, players[0], players[0]);
            }
            break;
        case 8:
            clones = getaiarchetypearray("<unknown string>");
            if (clones.size > 0) {
                foreach (clone in clones) {
                    clone kill();
                }
            }
            break;
        }
    }

#/
