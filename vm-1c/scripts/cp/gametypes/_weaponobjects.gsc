#using scripts/codescripts/struct;
#using scripts/cp/_util;
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
// Checksum 0xc1b2aed3, Offset: 0x1d0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("weaponobjects", &__init__, undefined, undefined);
}

// Namespace weaponobjects
// Params 0, eflags: 0x0
// Checksum 0xa9cd6a7a, Offset: 0x210
// Size: 0x34
function __init__() {
    init_shared();
    callback::on_start_gametype(&start_gametype);
}

// Namespace weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x609c463a, Offset: 0x250
// Size: 0x44
function start_gametype() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

// Namespace weaponobjects
// Params 0, eflags: 0x0
// Checksum 0x57416167, Offset: 0x2a0
// Size: 0x94
function on_player_spawned() {
    for (watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
        if (self.weaponobjectwatcherarray[watcher].name == "spike_charge") {
            arrayremoveindex(self.weaponobjectwatcherarray, watcher);
        }
    }
    self createspikelauncherwatcher("spike_launcher");
}

