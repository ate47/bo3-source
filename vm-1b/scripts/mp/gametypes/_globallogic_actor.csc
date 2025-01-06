#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace globallogic_actor;

// Namespace globallogic_actor
// Params 0, eflags: 0x2
// Checksum 0xcc27c2a4, Offset: 0x1b0
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("globallogic_actor", &__init__, undefined, undefined);
}

// Namespace globallogic_actor
// Params 0, eflags: 0x0
// Checksum 0xcf46368a, Offset: 0x1e8
// Size: 0x1b
function __init__() {
    level._effect["rcbombexplosion"] = "killstreaks/fx_rcxd_exp";
}

