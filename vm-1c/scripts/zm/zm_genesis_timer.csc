#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_genesis_timer;

// Namespace zm_genesis_timer
// Params 0, eflags: 0x2
// Checksum 0x7d77c56c, Offset: 0x1d8
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_genesis_timer", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_timer
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x220
// Size: 0x4
function __init__() {
    
}

// Namespace zm_genesis_timer
// Params 0, eflags: 0x0
// Checksum 0x393961b1, Offset: 0x230
// Size: 0x64
function __main__() {
    clientfield::register("world", "time_attack_reward", 12000, 3, "int", &function_b94ee48a, 0, 0);
    level.var_606e6080 = &function_3ec869e2;
}

// Namespace zm_genesis_timer
// Params 7, eflags: 0x0
// Checksum 0x10087577, Offset: 0x2a0
// Size: 0x48
function function_b94ee48a(var_6575414d, var_3bf16bb3, n_new_val, var_f16ed138, var_b54312de, str_field_name, var_ffbb7dc) {
    level.var_dd724c18 = n_new_val;
}

// Namespace zm_genesis_timer
// Params 0, eflags: 0x0
// Checksum 0x5c64d2c9, Offset: 0x2f0
// Size: 0x224
function function_3ec869e2() {
    s_parent = self.parent_struct;
    if (!isdefined(s_parent.var_67b0ba8d)) {
        s_parent.var_67b0ba8d = s_parent.origin;
    }
    if (!isdefined(self.var_cd859c93)) {
        self.var_cd859c93 = self.angles;
    }
    var_a199808e = (0, 0, 0);
    var_5c51aae8 = (0, 0, 0);
    switch (level.var_dd724c18) {
    case 1:
        self setmodel("wpn_t7_loot_nunchucks_world");
        break;
    case 2:
        self setmodel("wpn_t7_loot_mace_world");
        var_5c51aae8 = (90, 0, 0);
        break;
    case 3:
        self setmodel("wpn_t7_loot_improvise_world");
        var_a199808e = (0, -3, 0);
        var_5c51aae8 = (90, 0, 0);
        break;
    case 4:
        self setmodel("wpn_t7_loot_boneglass_world");
        var_a199808e = (0, -6, 1);
        var_5c51aae8 = (-15, 0, 0);
        break;
    case 5:
        self setmodel("wpn_t7_loot_melee_katana_world");
        var_a199808e = (1, -22, 0);
        var_5c51aae8 = (-88, 0, 0);
        break;
    }
    s_parent.origin = s_parent.var_67b0ba8d + var_a199808e;
    self.angles = self.var_cd859c93 + var_5c51aae8;
}

