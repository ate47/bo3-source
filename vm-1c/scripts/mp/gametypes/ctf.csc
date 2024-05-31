#using scripts/mp/_shoutcaster;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace ctf;

// Namespace ctf
// Params 0, eflags: 0x0
// namespace_c5e42f06<file_0>::function_d290ebfa
// Checksum 0x60d370c3, Offset: 0x188
// Size: 0x24
function main() {
    callback::on_localclient_connect(&on_localclient_connect);
}

// Namespace ctf
// Params 1, eflags: 0x0
// namespace_c5e42f06<file_0>::function_828aea2c
// Checksum 0x7a690bfe, Offset: 0x1b8
// Size: 0x17c
function on_localclient_connect(localclientnum) {
    var_1d2359d9 = [];
    while (!isdefined(var_1d2359d9["allies_base"])) {
        var_1d2359d9["allies_base"] = serverobjective_getobjective(localclientnum, "allies_base");
        var_1d2359d9["axis_base"] = serverobjective_getobjective(localclientnum, "axis_base");
        wait(0.05);
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
// namespace_c5e42f06<file_0>::function_1a39440d
// Checksum 0xfc034f02, Offset: 0x340
// Size: 0xf0
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
// namespace_c5e42f06<file_0>::function_6364237a
// Checksum 0x3869f33b, Offset: 0x438
// Size: 0x134
function function_6364237a(localclientnum, flag, effects) {
    if (isdefined(flag.base_fx)) {
        stopfx(localclientnum, flag.base_fx);
    }
    up = anglestoup(flag.angles);
    forward = anglestoforward(flag.angles);
    flag.base_fx = playfx(localclientnum, effects[flag.team], flag.origin, up, forward);
    setfxteam(localclientnum, flag.base_fx, flag.team);
    thread watch_for_team_change(localclientnum);
}

// Namespace ctf
// Params 1, eflags: 0x0
// namespace_c5e42f06<file_0>::function_45876c81
// Checksum 0xe6d9b72b, Offset: 0x578
// Size: 0x162
function function_45876c81(localclientnum) {
    effects = [];
    if (shoutcaster::is_shoutcaster_using_team_identity(localclientnum)) {
        if (getdvarint("tu11_programaticallyColoredGameFX")) {
            effects["allies"] = "ui/fx_ctf_flag_base_white";
            effects["axis"] = "ui/fx_ctf_flag_base_white";
        } else {
            effects = shoutcaster::get_color_fx(localclientnum, level.var_d23a0410);
        }
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
// namespace_c5e42f06<file_0>::function_f9cdfde1
// Checksum 0xc872cde6, Offset: 0x6e8
// Size: 0x4c
function watch_for_team_change(localclientnum) {
    level notify(#"end_team_change_watch");
    level endon(#"end_team_change_watch");
    level waittill(#"team_changed");
    thread function_45876c81(localclientnum);
}

