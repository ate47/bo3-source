#using scripts/codescripts/struct;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_proximity_grenade;

#namespace killstreak_detect;

// Namespace killstreak_detect
// Params 0, eflags: 0x2
// Checksum 0x67e6df92, Offset: 0x1e8
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("killstreak_detect", &__init__, undefined, undefined);
}

// Namespace killstreak_detect
// Params 0, eflags: 0x0
// Checksum 0xba04fad9, Offset: 0x220
// Size: 0xf2
function __init__() {
    clientfield::register("vehicle", "enemyvehicle", 1, 2, "int");
    clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int");
    clientfield::register("helicopter", "enemyvehicle", 1, 2, "int");
    clientfield::register("missile", "enemyvehicle", 1, 2, "int");
    clientfield::register("actor", "enemyvehicle", 1, 2, "int");
    clientfield::register("vehicle", "vehicletransition", 1, 1, "int");
}

// Namespace killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0xc687c39b, Offset: 0x320
// Size: 0x52
function killstreaktargetset(killstreakentity, offset) {
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    target_set(killstreakentity, offset);
    /#
        killstreakentity thread killstreak_hacking::killstreak_switch_team(killstreakentity.owner);
    #/
}

// Namespace killstreak_detect
// Params 1, eflags: 0x0
// Checksum 0xc8f5a80e, Offset: 0x380
// Size: 0x32
function killstreaktargetclear(killstreakentity) {
    target_remove(killstreakentity);
    /#
        killstreakentity thread killstreak_hacking::killstreak_switch_team_end();
    #/
}

