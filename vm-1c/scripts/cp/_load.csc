#using scripts/cp/bonuszm/_bonuszm;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/abilities/_ability_player;
#using scripts/cp/_trophy_system;
#using scripts/cp/_tacticalinsertion;
#using scripts/cp/_satchel_charge;
#using scripts/cp/_riotshield;
#using scripts/cp/_proximity_grenade;
#using scripts/cp/_hacker_tool;
#using scripts/cp/_flashgrenades;
#using scripts/cp/_decoy;
#using scripts/cp/_bouncingbetty;
#using scripts/shared/weapons/_sticky_grenade;
#using scripts/shared/weapons/spike_charge;
#using scripts/cp/_mobile_armory;
#using scripts/cp/gametypes/_weaponobjects;
#using scripts/cp/_skipto;
#using scripts/cp/_rotating_object;
#using scripts/cp/_rewindobjects;
#using scripts/cp/_radiant_live_update;
#using scripts/cp/_oed;
#using scripts/cp/_laststand;
#using scripts/cp/_global_fx;
#using scripts/cp/_destructible;
#using scripts/cp/_callbacks;
#using scripts/cp/_ambient;
#using scripts/shared/vehicle_shared;
#using scripts/shared/footsteps_shared;
#using scripts/shared/clientfaceanim_shared;
#using scripts/shared/audio_shared;
#using scripts/cp/_helicopter_sounds;
#using scripts/cp/_explosive_bolt;
#using scripts/cp/_claymore;
#using scripts/cp/gametypes/_player_cam;
#using scripts/shared/weapons/multilockapguidance;
#using scripts/shared/weapons/antipersonnelguidance;
#using scripts/shared/weapons/_trophy_system;
#using scripts/shared/weapons/_tacticalinsertion;
#using scripts/shared/weapons/_satchel_charge;
#using scripts/shared/weapons/_riotshield;
#using scripts/shared/weapons/_proximity_grenade;
#using scripts/shared/weapons/_bouncingbetty;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/_oob;
#using scripts/shared/music_shared;
#using scripts/shared/load_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/codescripts/struct;

#namespace load;

// Namespace load
// Params 3, eflags: 0x1 linked
// Checksum 0xfc7f8ebb, Offset: 0x7f0
// Size: 0x3a
function levelnotifyhandler(clientnum, state, oldstate) {
    if (state != "") {
        level notify(state, clientnum);
    }
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x1d397cf3, Offset: 0x838
// Size: 0x1bc
function main() {
    assert(isdefined(level.first_frame), "sndHealth");
    if (isdefined(level._loadstarted) && level._loadstarted) {
        return;
    }
    level._loadstarted = 1;
    level thread util::servertime();
    level thread util::init_utility();
    level thread register_clientfields();
    util::registersystem("levelNotify", &levelnotifyhandler);
    level.createfx_disable_fx = getdvarint("disable_fx") == 1;
    level thread namespace_7df5be44::init();
    level thread namespace_3d2de961::main();
    callback::add_callback(#"hash_da8d7d74", &basic_player_connect);
    callback::on_spawned(&on_player_spawned);
    system::wait_till("all");
    art_review();
    level flagsys::set("load_main_complete");
    setdvar("phys_wind_enabled", 0);
}

// Namespace load
// Params 1, eflags: 0x1 linked
// Checksum 0x478993ff, Offset: 0xa00
// Size: 0x54
function basic_player_connect(localclientnum) {
    if (!isdefined(level._laststand)) {
        level._laststand = [];
    }
    level._laststand[localclientnum] = 0;
    forcegamemodemappings(localclientnum, "default");
}

// Namespace load
// Params 1, eflags: 0x1 linked
// Checksum 0x3dd95bc4, Offset: 0xa60
// Size: 0x24
function on_player_spawned(localclientnum) {
    self thread force_update_player_clientfields(localclientnum);
}

// Namespace load
// Params 1, eflags: 0x1 linked
// Checksum 0x80a7c077, Offset: 0xa90
// Size: 0x5c
function force_update_player_clientfields(localclientnum) {
    self endon(#"entityshutdown");
    while (!clienthassnapshot(localclientnum)) {
        wait(0.25);
    }
    wait(0.25);
    self processclientfieldsasifnew();
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x576e8083, Offset: 0xaf8
// Size: 0x4c
function register_clientfields() {
    clientfield::register("toplayer", "sndHealth", 1, 2, "int", &audio::function_e1ab476f, 0, 0);
}

