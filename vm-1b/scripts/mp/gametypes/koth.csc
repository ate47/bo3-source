#using scripts/codescripts/struct;
#using scripts/mp/_shoutcaster;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;

#namespace koth;

// Namespace koth
// Params 0, eflags: 0x0
// Checksum 0x63bc7694, Offset: 0x290
// Size: 0x220
function main() {
    level.current_zone = [];
    level.current_state = [];
    for (i = 0; i < 4; i++) {
        level.current_zone[i] = 0;
        level.current_state[i] = 0;
    }
    level.hardpoints = [];
    level.visuals = [];
    level.hardpointfx = [];
    clientfield::register("world", "hardpoint", 1, 5, "int", &hardpoint, 0, 0);
    clientfield::register("world", "hardpointteam", 1, 5, "int", &hardpoint_state, 0, 0);
    level.effect_scriptbundles = [];
    level.effect_scriptbundles["zoneEdgeMarker"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_koth_edge_marker");
    level.effect_scriptbundles["zoneEdgeMarkerWndw"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_koth_edge_marker_window");
    level._effect["zoneEdgeMarker"] = [];
    level._effect["zoneEdgeMarker"][0] = "ui/fx_koth_marker_neutral";
    level._effect["zoneEdgeMarker"][1] = "ui/fx_koth_marker_blue";
    level._effect["zoneEdgeMarker"][2] = "ui/fx_koth_marker_orng";
    level._effect["zoneEdgeMarker"][3] = "ui/fx_koth_marker_contested";
    level._effect["zoneEdgeMarkerWndw"] = [];
    level._effect["zoneEdgeMarkerWndw"][0] = "ui/fx_koth_marker_neutral_window";
    level._effect["zoneEdgeMarkerWndw"][1] = "ui/fx_koth_marker_blue_window";
    level._effect["zoneEdgeMarkerWndw"][2] = "ui/fx_koth_marker_orng_window";
    level._effect["zoneEdgeMarkerWndw"][3] = "ui/fx_koth_marker_contested_window";
}

// Namespace koth
// Params 1, eflags: 0x0
// Checksum 0x318e27c6, Offset: 0x4b8
// Size: 0x13c
function get_shoutcaster_fx(local_client_num) {
    var_7377ff1a = [];
    var_7377ff1a["zoneEdgeMarker"] = shoutcaster::get_color_fx(local_client_num, level.effect_scriptbundles["zoneEdgeMarker"]);
    var_7377ff1a["zoneEdgeMarkerWndw"] = shoutcaster::get_color_fx(local_client_num, level.effect_scriptbundles["zoneEdgeMarkerWndw"]);
    effects = [];
    effects["zoneEdgeMarker"] = level._effect["zoneEdgeMarker"];
    effects["zoneEdgeMarkerWndw"] = level._effect["zoneEdgeMarkerWndw"];
    effects["zoneEdgeMarker"][1] = var_7377ff1a["zoneEdgeMarker"]["allies"];
    effects["zoneEdgeMarker"][2] = var_7377ff1a["zoneEdgeMarker"]["axis"];
    effects["zoneEdgeMarkerWndw"][1] = var_7377ff1a["zoneEdgeMarkerWndw"]["allies"];
    effects["zoneEdgeMarkerWndw"][2] = var_7377ff1a["zoneEdgeMarkerWndw"]["axis"];
    return effects;
}

// Namespace koth
// Params 3, eflags: 0x0
// Checksum 0xdc77efa7, Offset: 0x600
// Size: 0x80
function get_fx_state(local_client_num, state, is_shoutcaster) {
    if (is_shoutcaster) {
        return state;
    }
    if (state == 1) {
        if (util::function_d3d6ba6c(local_client_num, "allies")) {
            return 1;
        } else {
            return 2;
        }
    } else if (state == 2) {
        if (util::function_d3d6ba6c(local_client_num, "axis")) {
            return 1;
        } else {
            return 2;
        }
    }
    return state;
}

// Namespace koth
// Params 3, eflags: 0x0
// Checksum 0x40c0b2e5, Offset: 0x688
// Size: 0x22
function get_fx(fx_name, fx_state, effects) {
    return effects[fx_name][fx_state];
}

// Namespace koth
// Params 3, eflags: 0x0
// Checksum 0x5dbaa14d, Offset: 0x6b8
// Size: 0x252
function setup_hardpoint_fx(local_client_num, zone_index, state) {
    is_shoutcaster = shoutcaster::is_shoutcaster(local_client_num);
    effects = [];
    if (is_shoutcaster) {
        effects = get_shoutcaster_fx(local_client_num);
    } else {
        effects["zoneEdgeMarker"] = level._effect["zoneEdgeMarker"];
        effects["zoneEdgeMarkerWndw"] = level._effect["zoneEdgeMarkerWndw"];
    }
    if (isdefined(level.hardpointfx[local_client_num])) {
        foreach (fx in level.hardpointfx[local_client_num]) {
            stopfx(local_client_num, fx);
        }
    }
    level.hardpointfx[local_client_num] = [];
    if (zone_index) {
        if (isdefined(level.visuals[zone_index])) {
            fx_state = get_fx_state(local_client_num, state, is_shoutcaster);
            foreach (visual in level.visuals[zone_index]) {
                if (!isdefined(visual.script_fxid)) {
                    continue;
                }
                fxid = get_fx(visual.script_fxid, fx_state, effects);
                if (isdefined(visual.angles)) {
                    forward = anglestoforward(visual.angles);
                } else {
                    forward = (0, 0, 0);
                }
                level.hardpointfx[local_client_num][level.hardpointfx[local_client_num].size] = playfx(local_client_num, fxid, visual.origin, forward);
            }
        }
    }
    thread watch_for_team_change(local_client_num);
}

// Namespace koth
// Params 7, eflags: 0x0
// Checksum 0xc4a99208, Offset: 0x918
// Size: 0x182
function hardpoint(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (level.hardpoints.size == 0) {
        hardpoints = struct::get_array("koth_zone_center", "targetname");
        foreach (point in hardpoints) {
            level.hardpoints[point.script_index] = point;
        }
        foreach (point in level.hardpoints) {
            level.visuals[point.script_index] = struct::get_array(point.target, "targetname");
        }
    }
    level.current_zone[localclientnum] = newval;
    level.current_state[localclientnum] = 0;
    setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
}

// Namespace koth
// Params 7, eflags: 0x0
// Checksum 0x5e2aa896, Offset: 0xaa8
// Size: 0x7a
function hardpoint_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != level.current_state[localclientnum]) {
        level.current_state[localclientnum] = newval;
        setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
    }
}

// Namespace koth
// Params 1, eflags: 0x0
// Checksum 0xf2609453, Offset: 0xb30
// Size: 0x62
function watch_for_team_change(localclientnum) {
    level notify(#"end_team_change_watch");
    level endon(#"end_team_change_watch");
    level waittill(#"team_changed");
    while (!isdefined(getnonpredictedlocalplayer(localclientnum))) {
        wait 0.05;
    }
    setup_hardpoint_fx(localclientnum, level.current_zone[localclientnum], level.current_state[localclientnum]);
}

