#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace _gadget_es_strike;

// Namespace _gadget_es_strike
// Params 0, eflags: 0x2
// Checksum 0xbe776149, Offset: 0x1e8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_es_strike", &__init__, undefined, undefined);
}

// Namespace _gadget_es_strike
// Params 0, eflags: 0x1 linked
// Checksum 0xeb349219, Offset: 0x228
// Size: 0x24
function __init__() {
    callback::on_spawned(&on_player_spawned);
}

// Namespace _gadget_es_strike
// Params 1, eflags: 0x1 linked
// Checksum 0xf087634d, Offset: 0x258
// Size: 0xc
function on_player_spawned(local_client_num) {
    
}

