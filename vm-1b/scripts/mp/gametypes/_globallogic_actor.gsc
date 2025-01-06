#using scripts/codescripts/struct;
#using scripts/mp/_challenges;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/shared/_burnplayer;
#using scripts/shared/abilities/gadgets/_gadget_clone;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/weapons/_weapon_utils;

#namespace globallogic_actor;

// Namespace globallogic_actor
// Params 0, eflags: 0x2
// Checksum 0xe9c07cd6, Offset: 0x390
// Size: 0x2
function autoexec init() {
    
}

// Namespace globallogic_actor
// Params 1, eflags: 0x0
// Checksum 0x265840b, Offset: 0x3a0
// Size: 0x1a
function callback_actorspawned(spawner) {
    self thread spawner::spawn_think(spawner);
}

// Namespace globallogic_actor
// Params 15, eflags: 0x0
// Checksum 0xa674df5e, Offset: 0x3c8
// Size: 0xd9
function callback_actordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_actor
// Params 8, eflags: 0x0
// Checksum 0x537d6ac0, Offset: 0xc90
// Size: 0x49
function callback_actorkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_actor
// Params 1, eflags: 0x0
// Checksum 0x6ef3435b, Offset: 0xdc0
// Size: 0x2a
function callback_actorcloned(original) {
    destructserverutils::copydestructstate(original, self);
    gibserverutils::copygibstate(original, self);
}

