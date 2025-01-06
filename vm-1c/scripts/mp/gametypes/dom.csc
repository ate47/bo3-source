#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;

#namespace dom;

// Namespace dom
// Params 0, eflags: 0x0
// Checksum 0x5b43ca31, Offset: 0x1a0
// Size: 0x64
function main() {
    callback::on_localclient_connect(&on_localclient_connect);
    if (getgametypesetting("silentPlant") != 0) {
        setsoundcontext("bomb_plant", "silent");
    }
}

// Namespace dom
// Params 1, eflags: 0x0
// Checksum 0xd6b9aed7, Offset: 0x210
// Size: 0x15a
function on_localclient_connect(localclientnum) {
    self.domflags = [];
    while (!isdefined(level.domflags["a"])) {
        self.domflags["a"] = serverobjective_getobjective(localclientnum, "dom_a");
        self.domflags["b"] = serverobjective_getobjective(localclientnum, "dom_b");
        self.domflags["c"] = serverobjective_getobjective(localclientnum, "dom_c");
        wait 0.05;
    }
    foreach (key, flag_objective in self.domflags) {
        self thread monitor_flag_fx(localclientnum, flag_objective, key);
    }
}

// Namespace dom
// Params 3, eflags: 0x0
// Checksum 0xc9411d12, Offset: 0x378
// Size: 0x248
function monitor_flag_fx(localclientnum, flag_objective, flag_name) {
    if (!isdefined(flag_objective)) {
        return;
    }
    flag = spawnstruct();
    flag.name = flag_name;
    flag.objectiveid = flag_objective;
    flag.origin = serverobjective_getobjectiveorigin(localclientnum, flag_objective);
    flag.angles = (0, 0, 0);
    flag_entity = serverobjective_getobjectiveentity(localclientnum, flag_objective);
    if (isdefined(flag_entity)) {
        flag.origin = flag_entity.origin;
        flag.angles = flag_entity.angles;
    }
    fx_name = get_base_fx(flag, "neutral");
    play_base_fx(localclientnum, flag, fx_name, "neutral");
    flag.last_progress = 0;
    while (true) {
        team = serverobjective_getobjectiveteam(localclientnum, flag_objective);
        if (team != flag.last_team) {
            flag update_base_fx(localclientnum, flag, team);
        }
        progress = serverobjective_getobjectiveprogress(localclientnum, flag_objective) > 0;
        if (progress != flag.last_progress) {
            flag update_cap_fx(localclientnum, flag, team, progress);
        }
        wait 0.05;
    }
}

// Namespace dom
// Params 4, eflags: 0x0
// Checksum 0x81b02cc4, Offset: 0x5c8
// Size: 0x120
function play_base_fx(localclientnum, flag, fx_name, team) {
    if (isdefined(flag.base_fx)) {
        stopfx(localclientnum, flag.base_fx);
    }
    up = anglestoup(flag.angles);
    forward = anglestoforward(flag.angles);
    flag.base_fx = playfx(localclientnum, fx_name, flag.origin, up, forward);
    setfxteam(localclientnum, flag.base_fx, team);
    flag.last_team = team;
}

// Namespace dom
// Params 3, eflags: 0x0
// Checksum 0xbb292040, Offset: 0x6f0
// Size: 0xf0
function update_base_fx(localclientnum, flag, team) {
    fx_name = get_base_fx(flag, team);
    if (team == "neutral") {
        play_base_fx(localclientnum, flag, fx_name, team);
        return;
    }
    if (flag.last_team == "neutral") {
        play_base_fx(localclientnum, flag, fx_name, team);
        return;
    }
    setfxteam(localclientnum, flag.base_fx, team);
    flag.last_team = team;
}

// Namespace dom
// Params 4, eflags: 0x0
// Checksum 0xc243e3, Offset: 0x7e8
// Size: 0x10c
function play_cap_fx(localclientnum, flag, fx_name, team) {
    if (isdefined(flag.cap_fx)) {
        killfx(localclientnum, flag.cap_fx);
    }
    up = anglestoup(flag.angles);
    forward = anglestoforward(flag.angles);
    flag.cap_fx = playfx(localclientnum, fx_name, flag.origin, up, forward);
    setfxteam(localclientnum, flag.cap_fx, team);
}

// Namespace dom
// Params 4, eflags: 0x0
// Checksum 0xe9305646, Offset: 0x900
// Size: 0xd8
function update_cap_fx(localclientnum, flag, team, progress) {
    if (progress == 0) {
        if (isdefined(flag.cap_fx)) {
            killfx(localclientnum, flag.cap_fx);
        }
        flag.last_progress = progress;
        return;
    }
    fx_name = get_cap_fx(flag, team);
    play_cap_fx(localclientnum, flag, fx_name, team);
    flag.last_progress = progress;
}

// Namespace dom
// Params 2, eflags: 0x0
// Checksum 0x88b58279, Offset: 0x9e0
// Size: 0x78
function get_base_fx(flag, team) {
    if (isdefined(level.domflagbasefxoverride)) {
        fx = [[ level.domflagbasefxoverride ]](flag, team);
        if (isdefined(fx)) {
            return fx;
        }
    }
    if (team == "neutral") {
        return "ui/fx_dom_marker_neutral";
    }
    return "ui/fx_dom_marker_team";
}

// Namespace dom
// Params 2, eflags: 0x0
// Checksum 0xf222362e, Offset: 0xa60
// Size: 0x78
function get_cap_fx(flag, team) {
    if (isdefined(level.domflagcapfxoverride)) {
        fx = [[ level.domflagcapfxoverride ]](flag, team);
        if (isdefined(fx)) {
            return fx;
        }
    }
    if (team == "neutral") {
        return "ui/fx_dom_cap_indicator_neutral";
    }
    return "ui/fx_dom_cap_indicator_team";
}

