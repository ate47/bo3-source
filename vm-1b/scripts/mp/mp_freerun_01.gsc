#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/callbacks_shared;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_freerun_01;

// Namespace mp_freerun_01
// Params 0, eflags: 0x0
// Checksum 0x1535dd57, Offset: 0x1a8
// Size: 0x32
function main() {
    precache();
    load::main();
    init();
}

// Namespace mp_freerun_01
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1e8
// Size: 0x2
function precache() {
    
}

// Namespace mp_freerun_01
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1f8
// Size: 0x2
function init() {
    
}

// Namespace mp_freerun_01
// Params 0, eflags: 0x0
// Checksum 0xa974d11c, Offset: 0x208
// Size: 0x152
function function_355278da() {
    trigger1 = getent("speed_trigger1", "targetname");
    trigger2 = getent("speed_trigger2", "targetname");
    var_4c953a12 = getent("speed_trigger3", "targetname");
    var_be9ca94d = getent("speed_trigger4", "targetname");
    var_989a2ee4 = getent("speed_trigger5", "targetname");
    var_aa19e1f = getent("speed_trigger6", "targetname");
    trigger1 thread function_29d8b21();
    trigger2 thread function_29d8b21();
    var_4c953a12 thread function_29d8b21();
    var_be9ca94d thread function_29d8b21();
    var_989a2ee4 thread function_29d8b21();
    var_aa19e1f thread function_29d8b21();
}

// Namespace mp_freerun_01
// Params 0, eflags: 0x0
// Checksum 0x2c46b9cd, Offset: 0x368
// Size: 0x65
function function_29d8b21() {
    while (true) {
        self waittill(#"trigger", player);
        if (isplayer(player)) {
            self thread util::trigger_thread(player, &function_ba004d47, &function_93b59391);
        }
        wait 0.05;
    }
}

// Namespace mp_freerun_01
// Params 2, eflags: 0x0
// Checksum 0xcf73b9e4, Offset: 0x3d8
// Size: 0x95
function function_ba004d47(player, endon_string) {
    player endon(#"death");
    player endon(#"disconnect");
    player endon(endon_string);
    if (isdefined(player.var_6dbd1b8a)) {
        player.var_47baa121 = gettime();
        total_time = player.var_47baa121 - player.var_6dbd1b8a;
        iprintlnbold("" + total_time / 1000 + "seconds");
        player.var_6dbd1b8a = undefined;
    }
}

// Namespace mp_freerun_01
// Params 1, eflags: 0x0
// Checksum 0xe43d8d9b, Offset: 0x478
// Size: 0x3d
function function_93b59391(player) {
    player endon(#"death");
    player endon(#"disconnect");
    player.var_6dbd1b8a = gettime();
    if (isdefined(player.var_47baa121)) {
        player.var_47baa121 = undefined;
    }
}

