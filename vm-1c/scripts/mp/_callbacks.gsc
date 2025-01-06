#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_actor;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_globallogic_vehicle;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/audio_shared;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace callback;

// Namespace callback
// Params 0, eflags: 0x2
// Checksum 0x148c227, Offset: 0x220
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("callback", &__init__, undefined, undefined);
}

// Namespace callback
// Params 0, eflags: 0x0
// Checksum 0x6c6c52e4, Offset: 0x260
// Size: 0x14
function __init__() {
    set_default_callbacks();
}

// Namespace callback
// Params 0, eflags: 0x0
// Checksum 0x8d74ad43, Offset: 0x280
// Size: 0x20c
function set_default_callbacks() {
    level.callbackstartgametype = &globallogic::callback_startgametype;
    level.callbackplayerconnect = &globallogic_player::callback_playerconnect;
    level.callbackplayerdisconnect = &globallogic_player::callback_playerdisconnect;
    level.callbackplayerdamage = &globallogic_player::callback_playerdamage;
    level.callbackplayerkilled = &globallogic_player::callback_playerkilled;
    level.callbackplayermelee = &globallogic_player::callback_playermelee;
    level.callbackplayerlaststand = &globallogic_player::callback_playerlaststand;
    level.callbackactorspawned = &globallogic_actor::callback_actorspawned;
    level.callbackactordamage = &globallogic_actor::callback_actordamage;
    level.callbackactorkilled = &globallogic_actor::callback_actorkilled;
    level.callbackactorcloned = &globallogic_actor::callback_actorcloned;
    level.callbackvehiclespawned = &globallogic_vehicle::callback_vehiclespawned;
    level.callbackvehicledamage = &globallogic_vehicle::callback_vehicledamage;
    level.callbackvehiclekilled = &globallogic_vehicle::callback_vehiclekilled;
    level.callbackvehicleradiusdamage = &globallogic_vehicle::callback_vehicleradiusdamage;
    level.callbackplayermigrated = &globallogic_player::callback_playermigrated;
    level.callbackhostmigration = &hostmigration::callback_hostmigration;
    level.callbackhostmigrationsave = &hostmigration::callback_hostmigrationsave;
    level.callbackprehostmigrationsave = &hostmigration::callback_prehostmigrationsave;
    level.callbackbotentereduseredge = &bot::callback_botentereduseredge;
    level._custom_weapon_damage_func = &callback_weapon_damage;
    level._gametype_default = "tdm";
}

