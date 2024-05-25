#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_fd6bdadc;

// Namespace namespace_fd6bdadc
// Params 0, eflags: 0x2
// Checksum 0x2ef31405, Offset: 0x1d0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_stalingrad_timer", &__init__, &__main__, undefined);
}

// Namespace namespace_fd6bdadc
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x218
// Size: 0x4
function __init__() {
    
}

// Namespace namespace_fd6bdadc
// Params 0, eflags: 0x1 linked
// Checksum 0xe39bf422, Offset: 0x228
// Size: 0x64
function __main__() {
    clientfield::register("world", "time_attack_reward", 12000, 3, "int", &function_b94ee48a, 0, 0);
    level.var_606e6080 = &function_3ec869e2;
}

// Namespace namespace_fd6bdadc
// Params 7, eflags: 0x1 linked
// Checksum 0x9e44c41c, Offset: 0x298
// Size: 0x48
function function_b94ee48a(var_6575414d, var_3bf16bb3, n_new_val, var_f16ed138, var_b54312de, str_field_name, var_ffbb7dc) {
    level.var_dd724c18 = n_new_val;
}

// Namespace namespace_fd6bdadc
// Params 0, eflags: 0x1 linked
// Checksum 0x9c381c10, Offset: 0x2e8
// Size: 0xde
function function_3ec869e2() {
    switch (level.var_dd724c18) {
    case 1:
        self setmodel("wpn_t7_loot_wrench_world");
        break;
    case 2:
        self setmodel("wpn_t7_loot_ritual_dagger_world");
        break;
    case 3:
        self setmodel("wpn_t7_loot_axe_world");
        break;
    case 4:
        self setmodel("wpn_t7_loot_sword_world");
        break;
    case 5:
        self setmodel("wpn_t7_loot_daisho_world");
        break;
    }
}

