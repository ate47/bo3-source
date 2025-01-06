#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/callbacks_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace teamops;

// Namespace teamops
// Params 0, eflags: 0x0
// Checksum 0xdca791d1, Offset: 0x290
// Size: 0x5c
function function_ebba863f() {
    var_f180d141 = 0;
    var_39154cad = tablelookupfindcoreasset("gamedata/tables/mp/teamops.csv");
    if (isdefined(var_39154cad)) {
        var_f180d141 = 1;
    }
    assert(var_f180d141, "<dev string:x28>" + "<dev string:x4d>");
    return var_39154cad;
}

// Namespace teamops
// Params 0, eflags: 0x0
// Checksum 0xded5692f, Offset: 0x2f8
// Size: 0x51
function init() {
    InvalidOpCode(0xc8, "teamops", spawnstruct());
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace teamops
// Params 1, eflags: 0x0
// Checksum 0xbf5f0aab, Offset: 0x658
// Size: 0x70
function getid(name) {
    tableid = function_ebba863f();
    for (row = 1; row < 256; row++) {
        _name = tablelookupcolumnforrow(tableid, row, 0);
        if (name == _name) {
            return row;
        }
    }
    return 0;
}

// Namespace teamops
// Params 1, eflags: 0x0
// Checksum 0x7e0f94e9, Offset: 0x6d0
// Size: 0x21
function function_f8b6e626(name) {
    InvalidOpCode(0x54, "teamops", name);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teamops
// Params 1, eflags: 0x0
// Checksum 0x43a06da3, Offset: 0x750
// Size: 0x149
function function_a2630ab8(name) {
    level notify(#"hash_6521c6ed");
    level.var_29b97631 = undefined;
    if (!function_f8b6e626(name)) {
        return;
    }
    function_48a94128(0);
    var_8765445a = getdvarint("teamOpsPreanounceTime", 5);
    foreach (team in level.teams) {
        globallogic_audio::leader_dialog("teamops_preannounce", team);
    }
    wait var_8765445a;
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (isdefined(player)) {
            player playlocalsound("uin_objective_updated");
        }
    }
    InvalidOpCode(0x54, "teamops", name);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teamops
// Params 0, eflags: 0x0
// Checksum 0xf1787526, Offset: 0xa30
// Size: 0x39
function function_a6c201ca() {
    InvalidOpCode(0x54, "teamops");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teamops
// Params 0, eflags: 0x0
// Checksum 0xe38c5bc0, Offset: 0xb40
// Size: 0x39
function function_2f0859a2() {
    function_48a94128(0);
    InvalidOpCode(0x54, "teamops");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teamops
// Params 2, eflags: 0x0
// Checksum 0xe47d60fa, Offset: 0xbf0
// Size: 0x21
function function_4c970571(event, player) {
    InvalidOpCode(0x54, "teamops");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teamops
// Params 3, eflags: 0x0
// Checksum 0x91ef1d79, Offset: 0xc60
// Size: 0x31
function function_f0900ae5(event, player, team) {
    InvalidOpCode(0x54, "teamops");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teamops
// Params 3, eflags: 0x0
// Checksum 0x2c8dc717, Offset: 0xde8
// Size: 0x41
function function_3d345413(event, player, team) {
    InvalidOpCode(0x54, "teamops");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teamops
// Params 2, eflags: 0x0
// Checksum 0x3873b916, Offset: 0xed8
// Size: 0x19
function function_cfe86919(player, team) {
    InvalidOpCode(0x54, "teamops");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace teamops
// Params 0, eflags: 0x0
// Checksum 0xab8e0f5a, Offset: 0xf90
// Size: 0x5a
function main() {
    thread function_4dd504b0();
    level.var_17abecec = getdvarint("teamOpsKillsCountTrigger_" + level.gametype, 37);
    if (level.var_17abecec > 0) {
        level.var_29b97631 = &onplayerkilled;
    }
}

// Namespace teamops
// Params 0, eflags: 0x0
// Checksum 0x6ee3783e, Offset: 0xff8
// Size: 0xc8
function function_3640f8f4() {
    operations = strtok(getdvarstring("teamOpsName"), ",");
    for (i = 0; i < 20; i++) {
        operation = operations[randomintrange(0, operations.size)];
        if (function_f8b6e626(operation)) {
            return operation;
        }
    }
    for (i = 0; i < operations.size; i++) {
        operation = operations[i];
        if (function_f8b6e626(operation)) {
            return operation;
        }
    }
    return undefined;
}

// Namespace teamops
// Params 0, eflags: 0x0
// Checksum 0x52fa734f, Offset: 0x10c8
// Size: 0x12b
function function_4dd504b0() {
    level endon(#"hash_6521c6ed");
    if (isdefined(level.inprematchperiod) && level.inprematchperiod) {
        level waittill(#"prematch_over");
    }
    var_b7663294 = function_3640f8f4();
    if (!isdefined(var_b7663294)) {
        return;
    }
    startdelay = getdvarint("teamOpsStartDelay_" + level.gametype, 300);
    if (true) {
        InvalidOpCode(0x54, "teamops");
        // Unknown operator (0x54, t7_1b, PC)
    }
}

// Namespace teamops
// Params 9, eflags: 0x0
// Checksum 0x3fa865de, Offset: 0x1200
// Size: 0x12a
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    level endon(#"hash_6521c6ed");
    if (isplayer(attacker) == 0 || attacker.team == self.team) {
        return;
    }
    if (!isdefined(level.var_2b46855e)) {
        level.var_2b46855e = [];
    }
    if (!isdefined(level.var_2b46855e[attacker.team])) {
        level.var_2b46855e[attacker.team] = 0;
    }
    level.var_2b46855e[attacker.team]++;
    if (level.var_2b46855e[attacker.team] >= level.var_17abecec) {
        var_b7663294 = function_3640f8f4();
        if (!isdefined(var_b7663294)) {
            return;
        }
        level thread function_a2630ab8(var_b7663294);
    }
}

