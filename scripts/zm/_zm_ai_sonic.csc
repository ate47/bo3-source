#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;

#namespace namespace_14744e42;

// Namespace namespace_14744e42
// Params 0, eflags: 0x2
// Checksum 0x6a4b5c1d, Offset: 0xe8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_ai_sonic", &__init__, undefined, undefined);
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x0
// Checksum 0x689ca440, Offset: 0x128
// Size: 0x14
function __init__() {
    init_clientfields();
}

// Namespace namespace_14744e42
// Params 0, eflags: 0x0
// Checksum 0xcc1b227b, Offset: 0x148
// Size: 0x4c
function init_clientfields() {
    clientfield::register("actor", "issonic", 21000, 1, "int", &function_a46f66de, 0, 0);
}

// Namespace namespace_14744e42
// Params 7, eflags: 0x0
// Checksum 0x34f715aa, Offset: 0x1a0
// Size: 0x7c
function function_a46f66de(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self thread function_7e96eb0d(localclientnum);
        return;
    }
    self thread function_59e62cc8(localclientnum);
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x0
// Checksum 0x7fd0259b, Offset: 0x228
// Size: 0x3c
function function_7e96eb0d(client_num) {
    if (client_num != 0) {
        return;
    }
    self playloopsound("evt_sonic_ambient_loop", 1);
}

// Namespace namespace_14744e42
// Params 1, eflags: 0x0
// Checksum 0xa42e6b18, Offset: 0x270
// Size: 0x1a
function function_59e62cc8(client_num) {
    self notify(#"stop_sounds");
}

