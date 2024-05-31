#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace shoutcaster;

// Namespace shoutcaster
// Params 1, eflags: 0x0
// namespace_2eb5e8b4<file_0>::function_2e9c1177
// Checksum 0xe25c96a6, Offset: 0x128
// Size: 0x22
function is_shoutcaster(localclientnum) {
    return isshoutcaster(localclientnum);
}

// Namespace shoutcaster
// Params 1, eflags: 0x0
// namespace_2eb5e8b4<file_0>::function_323bb27f
// Checksum 0x66308f95, Offset: 0x158
// Size: 0x42
function is_shoutcaster_using_team_identity(localclientnum) {
    return is_shoutcaster(localclientnum) && getshoutcastersetting(localclientnum, "shoutcaster_team_identity");
}

// Namespace shoutcaster
// Params 2, eflags: 0x0
// namespace_2eb5e8b4<file_0>::function_f055ee3
// Checksum 0x33be1aae, Offset: 0x1a8
// Size: 0x62
function get_team_color_id(localclientnum, team) {
    if (team == "allies") {
        return getshoutcastersetting(localclientnum, "shoutcaster_fe_team1_color");
    }
    return getshoutcastersetting(localclientnum, "shoutcaster_fe_team2_color");
}

// Namespace shoutcaster
// Params 3, eflags: 0x0
// namespace_2eb5e8b4<file_0>::function_8fc8cd86
// Checksum 0x51f254f9, Offset: 0x218
// Size: 0x5e
function get_team_color_fx(localclientnum, team, script_bundle) {
    color = get_team_color_id(localclientnum, team);
    return script_bundle.objects[color].fx_colorid;
}

// Namespace shoutcaster
// Params 2, eflags: 0x0
// namespace_2eb5e8b4<file_0>::function_8c344990
// Checksum 0x7a60e4fc, Offset: 0x280
// Size: 0x86
function get_color_fx(localclientnum, script_bundle) {
    effects = [];
    effects["allies"] = get_team_color_fx(localclientnum, "allies", script_bundle);
    effects["axis"] = get_team_color_fx(localclientnum, "axis", script_bundle);
    return effects;
}

// Namespace shoutcaster
// Params 1, eflags: 0x0
// namespace_2eb5e8b4<file_0>::function_9b62b911
// Checksum 0xbd395153, Offset: 0x310
// Size: 0x9e
function is_friendly(localclientnum) {
    localplayer = getlocalplayer(localclientnum);
    scorepanel_flipped = getshoutcastersetting(localclientnum, "shoutcaster_flip_scorepanel");
    if (!scorepanel_flipped) {
        friendly = self.team == "allies";
    } else {
        friendly = self.team == "axis";
    }
    return friendly;
}

