#using scripts/shared/callbacks_shared;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/shared/compass;
#using scripts/codescripts/struct;

#namespace mp_freerun_01;

// Namespace mp_freerun_01
// Params 0, eflags: 0x0
// Checksum 0xc6a2dace, Offset: 0x1a8
// Size: 0x34
function main() {
    precache();
    load::main();
    init();
}

// Namespace mp_freerun_01
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1e8
// Size: 0x4
function precache() {
    
}

// Namespace mp_freerun_01
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1f8
// Size: 0x4
function init() {
    
}

// Namespace mp_freerun_01
// Params 0, eflags: 0x0
// Checksum 0x6f62621a, Offset: 0x208
// Size: 0x1ac
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
// Checksum 0xf42e5cc3, Offset: 0x3c0
// Size: 0x80
function function_29d8b21() {
    while (true) {
        player = self waittill(#"trigger");
        if (isplayer(player)) {
            self thread util::trigger_thread(player, &function_ba004d47, &function_93b59391);
        }
        wait 0.05;
    }
}

// Namespace mp_freerun_01
// Params 2, eflags: 0x0
// Checksum 0x96e4303, Offset: 0x448
// Size: 0xc2
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
// Checksum 0x94ce140a, Offset: 0x518
// Size: 0x56
function function_93b59391(player) {
    player endon(#"death");
    player endon(#"disconnect");
    player.var_6dbd1b8a = gettime();
    if (isdefined(player.var_47baa121)) {
        player.var_47baa121 = undefined;
    }
}

