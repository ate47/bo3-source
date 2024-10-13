#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;

#namespace zm_temple_ai_monkey;

// Namespace zm_temple_ai_monkey
// Params 0, eflags: 0x2
// Checksum 0x3b3bc1d2, Offset: 0x110
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_temple_ai_monkey", &__init__, undefined, undefined);
}

// Namespace zm_temple_ai_monkey
// Params 0, eflags: 0x1 linked
// Checksum 0x43758031, Offset: 0x150
// Size: 0x4c
function __init__() {
    clientfield::register("scriptmover", "monkey_ragdoll", 21000, 1, "int", &monkey_ragdoll, 1, 0);
}

// Namespace zm_temple_ai_monkey
// Params 7, eflags: 0x1 linked
// Checksum 0xf5d19323, Offset: 0x1a8
// Size: 0x64
function monkey_ragdoll(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self function_ec8b2835(1);
    }
}

