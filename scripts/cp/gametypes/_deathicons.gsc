#using scripts/cp/gametypes/_globallogic_utils;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace deathicons;

// Namespace deathicons
// Params 0, eflags: 0x2
// Checksum 0x7c31f568, Offset: 0x168
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("deathicons", &__init__, undefined, undefined);
}

// Namespace deathicons
// Params 0, eflags: 0x1 linked
// Checksum 0xc44f2bc0, Offset: 0x1a8
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace deathicons
// Params 0, eflags: 0x1 linked
// Checksum 0x2df4678d, Offset: 0x1f8
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
// Params 0, eflags: 0x1 linked
// Checksum 0x5a8fd029, Offset: 0x230
// Size: 0x10
function on_player_connect() {
    self.selfdeathicons = [];
}

// Namespace deathicons
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x248
// Size: 0x4
function update_enabled() {
    
}

// Namespace deathicons
// Params 4, eflags: 0x1 linked
// Checksum 0xf2244b14, Offset: 0x258
// Size: 0x244
function add(entity, dyingplayer, team, timeout) {
    if (isdefined(level.is_safehouse) && (!level.teambased || level.is_safehouse)) {
        return;
    }
    iconorg = entity.origin;
    dyingplayer endon(#"spawned_player");
    dyingplayer endon(#"disconnect");
    wait(0.05);
    util::waittillslowprocessallowed();
    /#
        assert(isdefined(level.teams[team]));
    #/
    if (getdvarstring("ui_hud_showdeathicons") == "0") {
        return;
    }
    if (level.hardcoremode) {
        return;
    }
    if (isdefined(self.var_a3be9036)) {
        self.var_a3be9036 destroy();
    }
    var_1c39c516 = newteamhudelem(team);
    var_1c39c516.x = iconorg[0];
    var_1c39c516.y = iconorg[1];
    var_1c39c516.z = iconorg[2] + 54;
    var_1c39c516.alpha = 0.61;
    var_1c39c516.archived = 1;
    if (level.splitscreen) {
        var_1c39c516 setshader("headicon_dead", 14, 14);
    } else {
        var_1c39c516 setshader("headicon_dead", 7, 7);
    }
    var_1c39c516 setwaypoint(1);
    self.var_a3be9036 = var_1c39c516;
    var_1c39c516 thread destroy_slowly(timeout);
}

// Namespace deathicons
// Params 1, eflags: 0x1 linked
// Checksum 0xf81ce849, Offset: 0x4a8
// Size: 0x64
function destroy_slowly(timeout) {
    self endon(#"death");
    wait(timeout);
    self fadeovertime(1);
    self.alpha = 0;
    wait(1);
    self destroy();
}

// Namespace deathicons
// Params 10, eflags: 0x1 linked
// Checksum 0xf1653f6c, Offset: 0x518
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

