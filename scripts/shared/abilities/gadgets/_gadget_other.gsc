#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/spawner_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_95f8d803;

// Namespace namespace_95f8d803
// Params 0, eflags: 0x2
// Checksum 0xadf710e8, Offset: 0x218
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_other", &__init__, undefined, undefined);
}

// Namespace namespace_95f8d803
// Params 0, eflags: 0x1 linked
// Checksum 0xf02213d9, Offset: 0x258
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(1, &function_73509156, &function_af4d837c);
    ability_player::register_gadget_possession_callbacks(1, &function_1efe9912, &function_4371972c);
    ability_player::register_gadget_flicker_callbacks(1, &function_2376cc6f);
    ability_player::register_gadget_is_inuse_callbacks(1, &gadget_other_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(1, &gadget_other_is_flickering);
    ability_player::register_gadget_ready_callbacks(1, &function_af938542);
}

// Namespace namespace_95f8d803
// Params 1, eflags: 0x1 linked
// Checksum 0x8d058f, Offset: 0x348
// Size: 0x22
function gadget_other_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace namespace_95f8d803
// Params 1, eflags: 0x1 linked
// Checksum 0xedf8b652, Offset: 0x378
// Size: 0x22
function gadget_other_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_95f8d803
// Params 2, eflags: 0x1 linked
// Checksum 0x38321943, Offset: 0x3a8
// Size: 0x14
function function_2376cc6f(slot, weapon) {
    
}

// Namespace namespace_95f8d803
// Params 2, eflags: 0x1 linked
// Checksum 0x3cad2797, Offset: 0x3c8
// Size: 0x14
function function_1efe9912(slot, weapon) {
    
}

// Namespace namespace_95f8d803
// Params 2, eflags: 0x1 linked
// Checksum 0x9622ab3d, Offset: 0x3e8
// Size: 0x14
function function_4371972c(slot, weapon) {
    
}

// Namespace namespace_95f8d803
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x408
// Size: 0x4
function function_327b4d11() {
    
}

// Namespace namespace_95f8d803
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x418
// Size: 0x4
function function_3a9413e6() {
    
}

// Namespace namespace_95f8d803
// Params 2, eflags: 0x1 linked
// Checksum 0xaafbe343, Offset: 0x428
// Size: 0x14
function function_73509156(slot, weapon) {
    
}

// Namespace namespace_95f8d803
// Params 2, eflags: 0x1 linked
// Checksum 0xbaca77c8, Offset: 0x448
// Size: 0x14
function function_af4d837c(slot, weapon) {
    
}

// Namespace namespace_95f8d803
// Params 2, eflags: 0x1 linked
// Checksum 0xc990ae0a, Offset: 0x468
// Size: 0x14
function function_af938542(slot, weapon) {
    
}

// Namespace namespace_95f8d803
// Params 3, eflags: 0x0
// Checksum 0x993adb86, Offset: 0x488
// Size: 0xb4
function set_gadget_other_status(weapon, status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Gadget Other " + weapon.name + ": " + status + timestr);
    }
}

