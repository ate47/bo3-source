#using scripts/codescripts/struct;
#using scripts/shared/system_shared;

#namespace shoutcaster;

// Namespace shoutcaster
// Params 1, eflags: 0x0
// Checksum 0x2e6e9baa, Offset: 0x110
// Size: 0x19
function is_shoutcaster(localclientnum) {
    return isshoutcaster(localclientnum);
}

// Namespace shoutcaster
// Params 2, eflags: 0x0
// Checksum 0xf1cfed3b, Offset: 0x138
// Size: 0x49
function get_team_color_id(localclientnum, team) {
    if (team == "allies") {
        return getshoutcastersetting(localclientnum, "shoutcaster_fe_team1_color");
    }
    return getshoutcastersetting(localclientnum, "shoutcaster_fe_team2_color");
}

// Namespace shoutcaster
// Params 3, eflags: 0x0
// Checksum 0xd850f475, Offset: 0x190
// Size: 0x49
function get_team_color_fx(localclientnum, team, script_bundle) {
    color = get_team_color_id(localclientnum, team);
    return script_bundle.objects[color].fx_colorid;
}

// Namespace shoutcaster
// Params 2, eflags: 0x0
// Checksum 0x48996144, Offset: 0x1e8
// Size: 0x67
function get_color_fx(localclientnum, script_bundle) {
    effects = [];
    effects["allies"] = get_team_color_fx(localclientnum, "allies", script_bundle);
    effects["axis"] = get_team_color_fx(localclientnum, "axis", script_bundle);
    return effects;
}

// Namespace shoutcaster
// Params 1, eflags: 0x0
// Checksum 0x789f681e, Offset: 0x258
// Size: 0x7f
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

