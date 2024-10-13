#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_traps;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_playerhealth;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_clone;
#using scripts/zm/_zm_bot;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_behavior;
#using scripts/zm/_zm_audio;
#using scripts/zm/_callbacks;
#using scripts/zm/_art;
#using scripts/zm/gametypes/_weaponobjects;
#using scripts/zm/gametypes/_spectating;
#using scripts/zm/gametypes/_shellshock;
#using scripts/zm/gametypes/_serversettings;
#using scripts/zm/gametypes/_scoreboard;
#using scripts/zm/gametypes/_clientids;
#using scripts/zm/_util;
#using scripts/zm/_destructible;
#using scripts/zm/gametypes/_spawnlogic;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/system_shared;
#using scripts/shared/serverfaceanim_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/_oob;
#using scripts/shared/music_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/load_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace load;

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x85a46ec4, Offset: 0x7c0
// Size: 0x11c
function main() {
    assert(isdefined(level.first_frame), "<dev string:x28>");
    zm::init();
    level._loadstarted = 1;
    register_clientfields();
    level.aitriggerspawnflags = getaitriggerflags();
    level.vehicletriggerspawnflags = getvehicletriggerflags();
    level thread start_intro_screen_zm();
    setup_traversals();
    footsteps();
    system::wait_till("all");
    level thread art_review();
    level flagsys::set("load_main_complete");
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x4240b549, Offset: 0x8e8
// Size: 0x23c
function footsteps() {
    if (isdefined(level.fx_exclude_footsteps) && level.fx_exclude_footsteps) {
        return;
    }
    zombie_utility::setfootstepeffect("asphalt", "_t6/bio/player/fx_footstep_dust");
    zombie_utility::setfootstepeffect("brick", "_t6/bio/player/fx_footstep_dust");
    zombie_utility::setfootstepeffect("carpet", "_t6/bio/player/fx_footstep_dust");
    zombie_utility::setfootstepeffect("cloth", "_t6/bio/player/fx_footstep_dust");
    zombie_utility::setfootstepeffect("concrete", "_t6/bio/player/fx_footstep_dust");
    zombie_utility::setfootstepeffect("dirt", "_t6/bio/player/fx_footstep_sand");
    zombie_utility::setfootstepeffect("foliage", "_t6/bio/player/fx_footstep_sand");
    zombie_utility::setfootstepeffect("gravel", "_t6/bio/player/fx_footstep_dust");
    zombie_utility::setfootstepeffect("grass", "_t6/bio/player/fx_footstep_dust");
    zombie_utility::setfootstepeffect("metal", "_t6/bio/player/fx_footstep_dust");
    zombie_utility::setfootstepeffect("mud", "_t6/bio/player/fx_footstep_mud");
    zombie_utility::setfootstepeffect("paper", "_t6/bio/player/fx_footstep_dust");
    zombie_utility::setfootstepeffect("plaster", "_t6/bio/player/fx_footstep_dust");
    zombie_utility::setfootstepeffect("rock", "_t6/bio/player/fx_footstep_dust");
    zombie_utility::setfootstepeffect("sand", "_t6/bio/player/fx_footstep_sand");
    zombie_utility::setfootstepeffect("water", "_t6/bio/player/fx_footstep_water");
    zombie_utility::setfootstepeffect("wood", "_t6/bio/player/fx_footstep_dust");
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xb30
// Size: 0x4
function setup_traversals() {
    
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0xbe8a0915, Offset: 0xb40
// Size: 0x94
function start_intro_screen_zm() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] lui::screen_fade_out(0, undefined);
        players[i] freezecontrols(1);
    }
    wait 1;
}

// Namespace load
// Params 0, eflags: 0x1 linked
// Checksum 0xe474fa, Offset: 0xbe0
// Size: 0xc4
function register_clientfields() {
    clientfield::register("allplayers", "zmbLastStand", 1, 1, "int");
    clientfield::register("clientuimodel", "zmhud.swordEnergy", 1, 7, "float");
    clientfield::register("clientuimodel", "zmhud.swordState", 1, 4, "int");
    clientfield::register("clientuimodel", "zmhud.swordChargeUpdate", 1, 1, "counter");
}

