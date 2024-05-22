#using scripts/zm/_zm_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_equip_shield;

// Namespace zm_equip_shield
// Params 0, eflags: 0x2
// Checksum 0xc698bce1, Offset: 0x1a0
// Size: 0x34
function function_2dc19561() {
    system::register("zm_equip_shield", &__init__, undefined, undefined);
}

// Namespace zm_equip_shield
// Params 0, eflags: 0x0
// Checksum 0x32783729, Offset: 0x1e0
// Size: 0x5c
function __init__() {
    callback::on_spawned(&player_on_spawned);
    clientfield::register("clientuimodel", "zmInventory.shield_health", 11000, 4, "float", undefined, 0, 0);
}

// Namespace zm_equip_shield
// Params 1, eflags: 0x0
// Checksum 0x5df19537, Offset: 0x248
// Size: 0x24
function player_on_spawned(localclientnum) {
    self thread watch_weapon_changes(localclientnum);
}

// Namespace zm_equip_shield
// Params 1, eflags: 0x0
// Checksum 0x4dbb2953, Offset: 0x278
// Size: 0x78
function watch_weapon_changes(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    while (isdefined(self)) {
        weapon = self waittill(#"weapon_change");
        if (weapon.isriotshield) {
            self thread function_9287ee54(localclientnum, weapon);
        }
    }
}

// Namespace zm_equip_shield
// Params 1, eflags: 0x0
// Checksum 0xa6c5ed53, Offset: 0x2f8
// Size: 0x92
function function_85cbbac5(model) {
    if (isdefined(model)) {
        if (!isdefined(level.model_locks)) {
            level.model_locks = [];
        }
        if (!isdefined(level.model_locks[model])) {
            level.model_locks[model] = 0;
        }
        if (level.model_locks[model] < 1) {
            forcestreamxmodel(model);
        }
        level.model_locks[model]++;
    }
}

// Namespace zm_equip_shield
// Params 1, eflags: 0x0
// Checksum 0x52d550c, Offset: 0x398
// Size: 0x94
function function_3ceed68a(model) {
    if (isdefined(model)) {
        if (!isdefined(level.model_locks)) {
            level.model_locks = [];
        }
        if (!isdefined(level.model_locks[model])) {
            level.model_locks[model] = 0;
        }
        level.model_locks[model]--;
        if (level.model_locks[model] < 1) {
            stopforcestreamingxmodel(model);
        }
    }
}

// Namespace zm_equip_shield
// Params 2, eflags: 0x0
// Checksum 0x162ee6e2, Offset: 0x438
// Size: 0x104
function function_9287ee54(localclientnum, weapon) {
    function_85cbbac5(weapon.worlddamagedmodel1);
    function_85cbbac5(weapon.worlddamagedmodel2);
    function_85cbbac5(weapon.worlddamagedmodel3);
    self util::waittill_any("weapon_change", "disconnect", "entityshutdown");
    function_3ceed68a(weapon.worlddamagedmodel1);
    function_3ceed68a(weapon.worlddamagedmodel2);
    function_3ceed68a(weapon.worlddamagedmodel3);
}

