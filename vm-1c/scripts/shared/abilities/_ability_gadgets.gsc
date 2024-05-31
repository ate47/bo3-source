#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace ability_gadgets;

// Namespace ability_gadgets
// Params 0, eflags: 0x2
// Checksum 0x6ef44c6d, Offset: 0x1c0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("ability_gadgets", &__init__, undefined, undefined);
}

// Namespace ability_gadgets
// Params 0, eflags: 0x1 linked
// Checksum 0xf87324b1, Offset: 0x200
// Size: 0x44
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

/#

    // Namespace ability_gadgets
    // Params 1, eflags: 0x1 linked
    // Checksum 0x99e6f959, Offset: 0x250
    // Size: 0x74
    function gadgets_print(str) {
        if (getdvarint("<unknown string>")) {
            toprint = str;
            println(self.playername + "<unknown string>" + "<unknown string>" + toprint);
        }
    }

#/

// Namespace ability_gadgets
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x2d0
// Size: 0x4
function on_player_connect() {
    
}

// Namespace ability_gadgets
// Params 2, eflags: 0x1 linked
// Checksum 0x3058b03c, Offset: 0x2e0
// Size: 0x44
function setflickering(slot, length) {
    if (!isdefined(length)) {
        length = 0;
    }
    self gadgetflickering(slot, 1, length);
}

// Namespace ability_gadgets
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x330
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace ability_gadgets
// Params 3, eflags: 0x1 linked
// Checksum 0x431087e3, Offset: 0x340
// Size: 0x6c
function gadget_give_callback(ent, slot, weapon) {
    /#
        ent gadgets_print("<unknown string>" + slot + "<unknown string>");
    #/
    ent ability_player::give_gadget(slot, weapon);
}

// Namespace ability_gadgets
// Params 3, eflags: 0x1 linked
// Checksum 0x5b0c47b3, Offset: 0x3b8
// Size: 0x6c
function gadget_take_callback(ent, slot, weapon) {
    /#
        ent gadgets_print("<unknown string>" + slot + "<unknown string>");
    #/
    ent ability_player::take_gadget(slot, weapon);
}

// Namespace ability_gadgets
// Params 3, eflags: 0x1 linked
// Checksum 0x9d8460ff, Offset: 0x430
// Size: 0x6c
function gadget_primed_callback(ent, slot, weapon) {
    /#
        ent gadgets_print("<unknown string>" + slot + "<unknown string>");
    #/
    ent ability_player::gadget_primed(slot, weapon);
}

// Namespace ability_gadgets
// Params 3, eflags: 0x1 linked
// Checksum 0xfd9662f3, Offset: 0x4a8
// Size: 0x6c
function gadget_ready_callback(ent, slot, weapon) {
    /#
        ent gadgets_print("<unknown string>" + slot + "<unknown string>");
    #/
    ent ability_player::gadget_ready(slot, weapon);
}

// Namespace ability_gadgets
// Params 3, eflags: 0x1 linked
// Checksum 0xf6e77f53, Offset: 0x520
// Size: 0x8c
function gadget_on_callback(ent, slot, weapon) {
    /#
        ent gadgets_print("<unknown string>" + slot + "<unknown string>");
    #/
    if (isdefined(level.var_26432505)) {
        level thread [[ level.var_26432505 ]](ent);
    }
    ent ability_player::turn_gadget_on(slot, weapon);
}

// Namespace ability_gadgets
// Params 3, eflags: 0x1 linked
// Checksum 0x64b60644, Offset: 0x5b8
// Size: 0x6c
function gadget_off_callback(ent, slot, weapon) {
    /#
        ent gadgets_print("<unknown string>" + slot + "<unknown string>");
    #/
    ent ability_player::turn_gadget_off(slot, weapon);
}

// Namespace ability_gadgets
// Params 3, eflags: 0x1 linked
// Checksum 0x3f5d2d8a, Offset: 0x630
// Size: 0x6c
function gadget_flicker_callback(ent, slot, weapon) {
    /#
        ent gadgets_print("<unknown string>" + slot + "<unknown string>");
    #/
    ent ability_player::gadget_flicker(slot, weapon);
}

