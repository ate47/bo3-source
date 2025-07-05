#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons_shared;

#namespace weaponobjects;

// Namespace weaponobjects
// Params 0, eflags: 0x2
// Checksum 0xb67a716, Offset: 0x1c8
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("weaponobjects", &__init__, undefined, undefined);
}

// Namespace weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xd177abe8, Offset: 0x200
// Size: 0x32
function __init__() {
    init_shared();
    callback::on_start_gametype(&start_gametype);
}

// Namespace weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x1a4808f, Offset: 0x240
// Size: 0x42
function start_gametype() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

// Namespace weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x55e4aaf0, Offset: 0x290
// Size: 0x1a
function on_player_spawned() {
    self createspikelauncherwatcher("hero_spike_launcher");
}

