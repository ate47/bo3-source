#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/shared/callbacks_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace deathicons;

// Namespace deathicons
// Params 0, eflags: 0x2
// Checksum 0xceb1604a, Offset: 0x198
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("deathicons", &__init__, undefined, undefined);
}

// Namespace deathicons
// Params 0, eflags: 0x0
// Checksum 0xe1dbfcff, Offset: 0x1d8
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace deathicons
// Params 0, eflags: 0x0
// Checksum 0x24f777ed, Offset: 0x228
// Size: 0x30
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
// Checksum 0x939bde4e, Offset: 0x260
// Size: 0x10
function on_player_connect() {
    self.selfdeathicons = [];
}

// Namespace deathicons
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x278
// Size: 0x4
function update_enabled() {
    
}

// Namespace deathicons
// Params 4, eflags: 0x0
// Checksum 0xa8b2e5f2, Offset: 0x288
// Size: 0x184
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
// Checksum 0x3d38e3d6, Offset: 0x418
// Size: 0x6c
function destroy_slowly(timeout, deathiconobjid) {
    wait timeout;
    objective_state(deathiconobjid, "done");
    wait 1;
    objective_delete(deathiconobjid);
    gameobjects::release_obj_id(deathiconobjid);
}

// Namespace deathicons
// Params 10, eflags: 0x0
// Checksum 0xf6ccaf77, Offset: 0x490
// Size: 0xdc
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

