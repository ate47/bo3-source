#using scripts/shared/system_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_zod_transformer;

// Namespace zm_zod_transformer
// Params 0, eflags: 0x2
// Checksum 0x603e7bf9, Offset: 0x148
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_transformer", &__init__, undefined, undefined);
}

// Namespace zm_zod_transformer
// Params 0, eflags: 0x0
// Checksum 0x15052c5a, Offset: 0x188
// Size: 0x6c
function __init__() {
    n_bits = getminbitcountfornum(16);
    clientfield::register("scriptmover", "transformer_light_switch", 1, n_bits, "int", &transformer_light_switch, 0, 0);
}

// Namespace zm_zod_transformer
// Params 7, eflags: 0x0
// Checksum 0x41f0c6d2, Offset: 0x200
// Size: 0x64
function transformer_light_switch(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("powerbox_" + newval);
    }
}

