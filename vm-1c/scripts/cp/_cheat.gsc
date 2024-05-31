#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;

#namespace cheat;

// Namespace cheat
// Params 0, eflags: 0x2
// Checksum 0x8598ba5d, Offset: 0xe0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("cheat", &__init__, undefined, undefined);
}

// Namespace cheat
// Params 0, eflags: 0x0
// Checksum 0x6b54a10, Offset: 0x120
// Size: 0x5c
function __init__() {
    level.var_d7af4c88 = [];
    level.var_7a56ad1b = [];
    level.var_e56c7cd0 = [];
    level flag::init("has_cheated");
    level thread death_monitor();
}

// Namespace cheat
// Params 0, eflags: 0x0
// Checksum 0x31f2394, Offset: 0x188
// Size: 0x1c
function player_init() {
    self thread function_c73833ba();
}

// Namespace cheat
// Params 0, eflags: 0x0
// Checksum 0xf13d2a17, Offset: 0x1b0
// Size: 0x14
function death_monitor() {
    function_24023f66();
}

// Namespace cheat
// Params 0, eflags: 0x0
// Checksum 0xe3961ac8, Offset: 0x1d0
// Size: 0x66
function function_24023f66() {
    /#
        for (index = 0; index < level.var_e56c7cd0.size; index++) {
            setdvar(level.var_e56c7cd0[index], level.var_d7af4c88[level.var_e56c7cd0[index]]);
        }
    #/
}

// Namespace cheat
// Params 2, eflags: 0x0
// Checksum 0x62f7c4ca, Offset: 0x240
// Size: 0x9a
function function_abb44133(var_fc14059a, var_d8e978b0) {
    /#
        setdvar(var_fc14059a, 0);
    #/
    level.var_d7af4c88[var_fc14059a] = getdvarint(var_fc14059a);
    level.var_7a56ad1b[var_fc14059a] = var_d8e978b0;
    if (level.var_d7af4c88[var_fc14059a]) {
        [[ var_d8e978b0 ]](level.var_d7af4c88[var_fc14059a]);
    }
}

// Namespace cheat
// Params 1, eflags: 0x0
// Checksum 0x77ffe534, Offset: 0x2e8
// Size: 0x96
function function_2276c67c(var_fc14059a) {
    var_38c46b05 = getdvarint(var_fc14059a);
    if (level.var_d7af4c88[var_fc14059a] == var_38c46b05) {
        return;
    }
    if (var_38c46b05) {
        level flag::set("has_cheated");
    }
    level.var_d7af4c88[var_fc14059a] = var_38c46b05;
    [[ level.var_7a56ad1b[var_fc14059a] ]](var_38c46b05);
}

// Namespace cheat
// Params 0, eflags: 0x0
// Checksum 0xe0e3652b, Offset: 0x388
// Size: 0xac
function function_c73833ba() {
    level endon(#"unloaded");
    function_abb44133("sf_use_ignoreammo", &function_450d7601);
    level.var_e56c7cd0 = getarraykeys(level.var_d7af4c88);
    for (;;) {
        for (index = 0; index < level.var_e56c7cd0.size; index++) {
            function_2276c67c(level.var_e56c7cd0[index]);
        }
        wait(0.5);
    }
}

// Namespace cheat
// Params 1, eflags: 0x0
// Checksum 0x558a341e, Offset: 0x440
// Size: 0x54
function function_450d7601(var_38c46b05) {
    if (var_38c46b05) {
        setsaveddvar("player_sustainAmmo", 1);
        return;
    }
    setsaveddvar("player_sustainAmmo", 0);
}

// Namespace cheat
// Params 0, eflags: 0x0
// Checksum 0x52bcee02, Offset: 0x4a0
// Size: 0x22
function is_cheating() {
    return level flag::get("has_cheated");
}

