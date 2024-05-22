#using scripts/zm/_zm_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;

#namespace namespace_f37770c8;

// Namespace namespace_f37770c8
// Params 0, eflags: 0x2
// Checksum 0xa9be9630, Offset: 0x148
// Size: 0x34
function function_2dc19561() {
    system::register("zm_craftables", &__init__, undefined, undefined);
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x55691903, Offset: 0x188
// Size: 0x34
function __init__() {
    level.var_90238c9a = 0;
    callback::on_finalize_initialization(&function_faa00f7e);
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xde710676, Offset: 0x1c8
// Size: 0x44
function function_faa00f7e(localclientnum) {
    if (!isdefined(level.var_d8581803)) {
        level.var_d8581803 = [];
    }
    function_bc39c454(level.var_d8581803.size + 1);
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x0
// Checksum 0xe30558f1, Offset: 0x218
// Size: 0x20
function init() {
    if (isdefined(level.var_95743e9f)) {
        [[ level.var_95743e9f ]]();
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xc2bd7839, Offset: 0x240
// Size: 0x86
function function_8421d708(var_9967ff1) {
    if (!isdefined(level.var_b09bbe80)) {
        level.var_b09bbe80 = [];
    }
    if (isdefined(level.var_b09bbe80) && !isdefined(level.var_b09bbe80[var_9967ff1])) {
        return;
    }
    var_9967ff1 = level.var_b09bbe80[var_9967ff1];
    if (!isdefined(level.var_d8581803)) {
        level.var_d8581803 = [];
    }
    level.var_d8581803[var_9967ff1] = var_9967ff1;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x0
// Checksum 0x9420ddf2, Offset: 0x2d0
// Size: 0x44
function function_5654f132() {
    wait(0.1);
    if (level.var_d8581803.size > 0) {
        setupclientfieldcodecallbacks("toplayer", 1, "craftable");
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x89dcfc27, Offset: 0x320
// Size: 0x36
function function_ac4e44a7(var_9967ff1) {
    if (!isdefined(level.var_b09bbe80)) {
        level.var_b09bbe80 = [];
    }
    level.var_b09bbe80[var_9967ff1] = var_9967ff1;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xf214e544, Offset: 0x360
// Size: 0x6c
function function_bc39c454(n_count) {
    bits = getminbitcountfornum(n_count);
    registerclientfield("toplayer", "craftable", 1, bits, "int", undefined, 0, 1);
}

