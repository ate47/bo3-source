#using scripts/shared/system_shared;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace zm_genesis_keeper;

// Namespace zm_genesis_keeper
// Params 0, eflags: 0x2
// Checksum 0x3462193b, Offset: 0x228
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_genesis_keeper", &__init__, undefined, undefined);
}

// Namespace zm_genesis_keeper
// Params 0, eflags: 0x1 linked
// Checksum 0x8cd9d433, Offset: 0x268
// Size: 0x8c
function __init__() {
    ai::add_archetype_spawn_function("keeper", &function_6ded398b);
    if (ai::shouldregisterclientfieldforarchetype("keeper")) {
        clientfield::register("actor", "keeper_death", 15000, 2, "int", &function_6e8422e9, 0, 0);
    }
}

// Namespace zm_genesis_keeper
// Params 1, eflags: 0x1 linked
// Checksum 0x244ff664, Offset: 0x300
// Size: 0x24
function function_6ded398b(localclientnum) {
    self thread function_ea48e71e(localclientnum);
}

// Namespace zm_genesis_keeper
// Params 1, eflags: 0x1 linked
// Checksum 0x1a010f33, Offset: 0x330
// Size: 0x140
function function_ea48e71e(localclientnum) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    s_timer = new_timer(localclientnum);
    var_dbee3979 = 1;
    do {
        util::server_wait(localclientnum, 0.11);
        n_current_time = s_timer get_time_in_seconds();
        var_af412d0a = lerpfloat(0, 1, n_current_time / var_dbee3979);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", var_af412d0a);
        self mapshaderconstant(localclientnum, 0, "scriptVector0", var_af412d0a);
    } while (n_current_time < var_dbee3979);
    s_timer notify(#"hash_88be9d37");
}

// Namespace zm_genesis_keeper
// Params 1, eflags: 0x1 linked
// Checksum 0x3f9bf60f, Offset: 0x478
// Size: 0x58
function new_timer(localclientnum) {
    s_timer = spawnstruct();
    s_timer.n_time_current = 0;
    s_timer thread function_ec23b7a7(localclientnum, self);
    return s_timer;
}

// Namespace zm_genesis_keeper
// Params 2, eflags: 0x1 linked
// Checksum 0xedbcc95e, Offset: 0x4d8
// Size: 0x68
function function_ec23b7a7(localclientnum, entity) {
    entity endon(#"entityshutdown");
    self endon(#"hash_88be9d37");
    while (isdefined(self)) {
        util::server_wait(localclientnum, 0.016);
        self.n_time_current += 0.016;
    }
}

// Namespace zm_genesis_keeper
// Params 0, eflags: 0x0
// Checksum 0xee270e23, Offset: 0x548
// Size: 0x10
function get_time() {
    return self.n_time_current * 1000;
}

// Namespace zm_genesis_keeper
// Params 0, eflags: 0x1 linked
// Checksum 0xd575c899, Offset: 0x560
// Size: 0xa
function get_time_in_seconds() {
    return self.n_time_current;
}

// Namespace zm_genesis_keeper
// Params 0, eflags: 0x0
// Checksum 0x4ec7c232, Offset: 0x578
// Size: 0x10
function function_799c46b8() {
    self.n_time_current = 0;
}

// Namespace zm_genesis_keeper
// Params 7, eflags: 0x1 linked
// Checksum 0x1d179980, Offset: 0x590
// Size: 0x27c
function function_6e8422e9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval == 1) {
        s_timer = new_timer(localclientnum);
        var_dbee3979 = 0.3;
        self.var_eee5840b = 1;
        do {
            util::server_wait(localclientnum, 0.11);
            n_current_time = s_timer get_time_in_seconds();
            var_af412d0a = lerpfloat(1, 0.1, n_current_time / var_dbee3979);
            self mapshaderconstant(localclientnum, 0, "scriptVector2", var_af412d0a);
        } while (n_current_time < var_dbee3979);
        s_timer notify(#"hash_88be9d37");
        self.var_eee5840b = 0;
        return;
    }
    if (newval == 2) {
        if (!isdefined(self)) {
            return;
        }
        var_dbee3979 = 0.3;
        s_timer = new_timer(localclientnum);
        do {
            util::server_wait(localclientnum, 0.11);
            n_current_time = s_timer get_time_in_seconds();
            var_af412d0a = lerpfloat(1, 0, n_current_time / var_dbee3979);
            self mapshaderconstant(localclientnum, 0, "scriptVector0", var_af412d0a);
        } while (n_current_time < var_dbee3979);
        s_timer notify(#"hash_88be9d37");
        self mapshaderconstant(localclientnum, 0, "scriptVector0", 0);
    }
}

