#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/shared/callbacks_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace deathicons;

// Namespace deathicons
// Params 0, eflags: 0x2
// Checksum 0x123c9ebb, Offset: 0x198
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("deathicons", &__init__, undefined, undefined);
}

// Namespace deathicons
// Params 0, eflags: 0x0
// Checksum 0x5ea3a314, Offset: 0x1d0
// Size: 0x42
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace deathicons
// Params 0, eflags: 0x0
// Checksum 0x38a32fa9, Offset: 0x220
// Size: 0x2e
function init() {
    if (!isdefined(level.ragdoll_override)) {
        level.ragdoll_override = &ragdoll_override;
    }
    if (!level.teambased) {
        return;
    }
}

// Namespace deathicons
// Params 0, eflags: 0x0
// Checksum 0x29465b3, Offset: 0x258
// Size: 0xa
function on_player_connect() {
    self.selfdeathicons = [];
}

// Namespace deathicons
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x270
// Size: 0x2
function update_enabled() {
    
}

// Namespace deathicons
// Params 4, eflags: 0x0
// Checksum 0xf1d1aa0f, Offset: 0x280
// Size: 0x12a
function add(entity, dyingplayer, team, timeout) {
    if (!level.teambased) {
        return;
    }
    iconorg = entity.origin;
    dyingplayer endon(#"spawned_player");
    dyingplayer endon(#"disconnect");
    wait 0.05;
    util::waittillslowprocessallowed();
    assert(isdefined(level.teams[team]));
    assert(isdefined(level.teamindex[team]));
    if (getdvarstring("ui_hud_showdeathicons") == "0") {
        return;
    }
    if (level.hardcoremode) {
        return;
    }
    deathiconobjid = gameobjects::get_next_obj_id();
    objective_add(deathiconobjid, "active", iconorg, %headicon_dead);
    objective_team(deathiconobjid, team);
    level thread destroy_slowly(timeout, deathiconobjid);
}

// Namespace deathicons
// Params 2, eflags: 0x0
// Checksum 0xa7a2b8ed, Offset: 0x3b8
// Size: 0x52
function destroy_slowly(timeout, deathiconobjid) {
    wait timeout;
    objective_state(deathiconobjid, "done");
    wait 1;
    objective_delete(deathiconobjid);
    gameobjects::release_obj_id(deathiconobjid);
}

// Namespace deathicons
// Params 10, eflags: 0x0
// Checksum 0xb35403c4, Offset: 0x418
// Size: 0xb6
function ragdoll_override(idamage, smeansofdeath, sweapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body) {
    if (smeansofdeath == "MOD_FALLING" && self isonground() == 1) {
        body startragdoll();
        if (!isdefined(self.switching_teams)) {
            thread add(body, self, self.team, 5);
        }
        return true;
    }
    return false;
}

