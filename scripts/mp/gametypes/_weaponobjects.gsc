#using scripts/mp/_util;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace weaponobjects;

// Namespace weaponobjects
// Params 0, eflags: 0x2
// Checksum 0x37a848ac, Offset: 0x1c8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("weaponobjects", &__init__, undefined, undefined);
}

// Namespace weaponobjects
// Params 0, eflags: 0x1 linked
// Checksum 0xc5f6721e, Offset: 0x208
// Size: 0x34
function __init__() {
    init_shared();
    callback::on_start_gametype(&start_gametype);
}

// Namespace weaponobjects
// Params 0, eflags: 0x1 linked
// Checksum 0x4135469d, Offset: 0x248
// Size: 0x44
function start_gametype() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

// Namespace weaponobjects
// Params 0, eflags: 0x1 linked
// Checksum 0x4d754bc0, Offset: 0x298
// Size: 0x24
function on_player_spawned() {
    self createspikelauncherwatcher("hero_spike_launcher");
}

