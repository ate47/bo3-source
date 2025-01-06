#using scripts/codescripts/struct;
#using scripts/mp/_shoutcaster;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;

#namespace ctf;

// Namespace ctf
// Params 0, eflags: 0x0
// Checksum 0xd2d02c94, Offset: 0x178
// Size: 0x4a
function main() {
    callback::on_localclient_connect(&on_localclient_connect);
    level.var_d23a0410 = struct::get_script_bundle("teamcolorfx", "teamcolorfx_ctf_flag_base");
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xf5770c2a, Offset: 0x1d0
// Size: 0x112
function on_localclient_connect(localclientnum) {
    var_1d2359d9 = [];
    while (!isdefined(var_1d2359d9["allies_base"])) {
        var_1d2359d9["allies_base"] = serverobjective_getobjective(localclientnum, "allies_base");
        var_1d2359d9["axis_base"] = serverobjective_getobjective(localclientnum, "axis_base");
        wait 0.05;
    }
    foreach (key, objective in var_1d2359d9) {
        level.var_1267dd47[key] = spawnstruct();
        level.var_1267dd47[key].objectiveid = objective;
        function_1a39440d(localclientnum, level.var_1267dd47[key]);
    }
    function_45876c81(localclientnum);
}

// Namespace ctf
// Params 2, eflags: 0x0
// Checksum 0xaf97850e, Offset: 0x2f0
// Size: 0xb2
function function_1a39440d(localclientnum, flag) {
    flag.origin = serverobjective_getobjectiveorigin(localclientnum, flag.objectiveid);
    flag_entity = serverobjective_getobjectiveentity(localclientnum, flag.objectiveid);
    flag.angles = (0, 0, 0);
    if (isdefined(flag_entity)) {
        flag.origin = flag_entity.origin;
        flag.angles = flag_entity.angles;
    }
    flag.team = serverobjective_getobjectiveteam(localclientnum, flag.objectiveid);
}

// Namespace ctf
// Params 3, eflags: 0x0
// Checksum 0xbed4fd9f, Offset: 0x3b0
// Size: 0xd2
function function_6364237a(localclientnum, flag, effects) {
    if (isdefined(flag.base_fx)) {
        stopfx(localclientnum, flag.base_fx);
    }
    up = anglestoup(flag.angles);
    forward = anglestoforward(flag.angles);
    flag.base_fx = playfx(localclientnum, effects[flag.team], flag.origin, up, forward);
    setfxteam(localclientnum, flag.base_fx, flag.team);
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0x6cf3cab1, Offset: 0x490
// Size: 0xd3
function function_45876c81(localclientnum) {
    effects = [];
    if (shoutcaster::is_shoutcaster(localclientnum)) {
        effects = shoutcaster::get_color_fx(localclientnum, level.var_d23a0410);
    } else {
        effects["allies"] = "ui/fx_ctf_flag_base_team";
        effects["axis"] = "ui/fx_ctf_flag_base_team";
    }
    foreach (flag in level.var_1267dd47) {
        thread function_6364237a(localclientnum, flag, effects);
    }
}

// Namespace ctf
// Params 1, eflags: 0x0
// Checksum 0xfcaaa03d, Offset: 0x570
// Size: 0x32
function watch_for_team_change(localclientnum) {
    level notify(#"end_team_change_watch");
    level endon(#"end_team_change_watch");
    level waittill(#"team_changed");
    function_45876c81(localclientnum);
}

