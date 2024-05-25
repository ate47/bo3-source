#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace duplicate_render;

// Namespace duplicate_render
// Params 0, eflags: 0x2
// Checksum 0x497c2333, Offset: 0x4d0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("duplicate_render", &__init__, undefined, undefined);
}

// Namespace duplicate_render
// Params 0, eflags: 0x1 linked
// Checksum 0xc3c65de2, Offset: 0x510
// Size: 0x53c
function __init__() {
    if (!isdefined(level.drfilters)) {
        level.drfilters = [];
    }
    callback::on_spawned(&on_player_spawned);
    callback::on_localclient_connect(&on_player_connect);
    set_dr_filter_framebuffer("none_fb", 0, undefined, undefined, 0, 1, 0);
    set_dr_filter_framebuffer_duplicate("none_fbd", 0, undefined, undefined, 1, 0, 0);
    set_dr_filter_offscreen("none_os", 0, undefined, undefined, 2, 0, 0);
    set_dr_filter_framebuffer("enveh_fb", 8, "enemyvehicle_fb", undefined, 0, 4, 1);
    set_dr_filter_framebuffer("frveh_fb", 8, "friendlyvehicle_fb", undefined, 0, 1, 1);
    set_dr_filter_offscreen("retrv", 5, "retrievable", undefined, 2, "mc/hud_keyline_retrievable", 1);
    set_dr_filter_offscreen("unplc", 7, "unplaceable", undefined, 2, "mc/hud_keyline_unplaceable", 1);
    set_dr_filter_offscreen("eneqp", 8, "enemyequip", undefined, 2, "mc/hud_outline_rim", 1);
    set_dr_filter_offscreen("enexp", 8, "enemyexplo", undefined, 2, "mc/hud_outline_rim", 1);
    set_dr_filter_offscreen("enveh", 8, "enemyvehicle", undefined, 2, "mc/hud_outline_rim", 1);
    set_dr_filter_offscreen("freqp", 8, "friendlyequip", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("frexp", 8, "friendlyexplo", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("frveh", 8, "friendlyvehicle", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("infrared", 9, "infrared_entity", undefined, 2, 2, 1);
    set_dr_filter_offscreen("threat_detector_enemy", 10, "threat_detector_enemy", undefined, 2, "mc/hud_keyline_enemyequip", 1);
    set_dr_filter_offscreen("hthacked", 5, "hacker_tool_hacked", undefined, 2, "mc/mtl_hacker_tool_hacked", 1);
    set_dr_filter_offscreen("hthacking", 5, "hacker_tool_hacking", undefined, 2, "mc/mtl_hacker_tool_hacking", 1);
    set_dr_filter_offscreen("htbreaching", 5, "hacker_tool_breaching", undefined, 2, "mc/mtl_hacker_tool_breaching", 1);
    set_dr_filter_offscreen("bcarrier", 9, "ballcarrier", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("poption", 9, "passoption", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("prop_look_through", 9, "prop_look_through", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("prop_ally", 8, "prop_ally", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
    set_dr_filter_offscreen("prop_clone", 7, "prop_clone", undefined, 2, "mc/hud_keyline_ph_yellow", 1);
    level.friendlycontentoutlines = getdvarint("friendlyContentOutlines", 0);
}

// Namespace duplicate_render
// Params 1, eflags: 0x1 linked
// Checksum 0xb8bc233, Offset: 0xa58
// Size: 0x7c
function on_player_spawned(local_client_num) {
    self.currentdrfilter = [];
    self change_dr_flags(local_client_num);
    if (!level flagsys::get("duplicaterender_registry_ready")) {
        wait(0.016);
        level flagsys::set("duplicaterender_registry_ready");
    }
}

// Namespace duplicate_render
// Params 1, eflags: 0x1 linked
// Checksum 0x496bab69, Offset: 0xae0
// Size: 0x24
function on_player_connect(localclientnum) {
    level wait_team_changed(localclientnum);
}

// Namespace duplicate_render
// Params 1, eflags: 0x1 linked
// Checksum 0xd432ca10, Offset: 0xb10
// Size: 0x88
function wait_team_changed(localclientnum) {
    while (true) {
        level waittill(#"team_changed");
        while (!isdefined(getlocalplayer(localclientnum))) {
            wait(0.05);
        }
        player = getlocalplayer(localclientnum);
        player codcaster_keyline_enable(0);
    }
}

// Namespace duplicate_render
// Params 14, eflags: 0x1 linked
// Checksum 0xcb29d2c9, Offset: 0xba0
// Size: 0x3b4
function set_dr_filter(filterset, name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
    if (!isdefined(level.drfilters)) {
        level.drfilters = [];
    }
    if (!isdefined(level.drfilters[filterset])) {
        level.drfilters[filterset] = [];
    }
    if (!isdefined(level.drfilters[filterset][name])) {
        level.drfilters[filterset][name] = spawnstruct();
    }
    filter = level.drfilters[filterset][name];
    filter.name = name;
    filter.priority = priority * -1;
    if (!isdefined(require_flags)) {
        filter.require = [];
    } else if (isarray(require_flags)) {
        filter.require = require_flags;
    } else {
        filter.require = strtok(require_flags, ",");
    }
    if (!isdefined(refuse_flags)) {
        filter.refuse = [];
    } else if (isarray(refuse_flags)) {
        filter.refuse = refuse_flags;
    } else {
        filter.refuse = strtok(refuse_flags, ",");
    }
    filter.types = [];
    filter.values = [];
    filter.culling = [];
    if (isdefined(drtype1)) {
        idx = filter.types.size;
        filter.types[idx] = drtype1;
        filter.values[idx] = drval1;
        filter.culling[idx] = drcull1;
    }
    if (isdefined(drtype2)) {
        idx = filter.types.size;
        filter.types[idx] = drtype2;
        filter.values[idx] = drval2;
        filter.culling[idx] = drcull2;
    }
    if (isdefined(drtype3)) {
        idx = filter.types.size;
        filter.types[idx] = drtype3;
        filter.values[idx] = drval3;
        filter.culling[idx] = drcull3;
    }
    thread register_filter_materials(filter);
}

// Namespace duplicate_render
// Params 13, eflags: 0x1 linked
// Checksum 0xdc5ca25a, Offset: 0xf60
// Size: 0xbc
function set_dr_filter_framebuffer(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
    set_dr_filter("framebuffer", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

// Namespace duplicate_render
// Params 13, eflags: 0x1 linked
// Checksum 0x32073c41, Offset: 0x1028
// Size: 0xbc
function set_dr_filter_framebuffer_duplicate(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
    set_dr_filter("framebuffer_duplicate", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

// Namespace duplicate_render
// Params 13, eflags: 0x1 linked
// Checksum 0xe6b67e0c, Offset: 0x10f0
// Size: 0xbc
function set_dr_filter_offscreen(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3) {
    set_dr_filter("offscreen", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

// Namespace duplicate_render
// Params 1, eflags: 0x1 linked
// Checksum 0xb54a7faa, Offset: 0x11b8
// Size: 0x1a0
function register_filter_materials(filter) {
    playercount = undefined;
    opts = filter.types.size;
    for (i = 0; i < opts; i++) {
        value = filter.values[i];
        if (isstring(value)) {
            if (!isdefined(playercount)) {
                while (!isdefined(level.localplayers) && !isdefined(level.frontendclientconnected)) {
                    wait(0.016);
                }
                if (isdefined(level.frontendclientconnected)) {
                    playercount = 1;
                } else {
                    util::waitforallclients();
                    playercount = level.localplayers.size;
                }
            }
            if (!isdefined(filter::mapped_material_id(value))) {
                for (localclientnum = 0; localclientnum < playercount; localclientnum++) {
                    filter::map_material_helper_by_localclientnum(localclientnum, value);
                }
            }
        }
    }
    filter.priority = abs(filter.priority);
}

// Namespace duplicate_render
// Params 3, eflags: 0x1 linked
// Checksum 0x307a9179, Offset: 0x1360
// Size: 0x64
function update_dr_flag(localclientnum, toset, setto) {
    if (!isdefined(setto)) {
        setto = 1;
    }
    if (set_dr_flag(toset, setto)) {
        update_dr_filters(localclientnum);
    }
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0x74cfeaef, Offset: 0x13d0
// Size: 0xd0
function set_dr_flag_not_array(toset, setto) {
    if (!isdefined(setto)) {
        setto = 1;
    }
    if (!isdefined(self.flag) || !isdefined(self.flag[toset])) {
        self flag::init(toset);
    }
    if (setto == self.flag[toset]) {
        return false;
    }
    if (isdefined(setto) && setto) {
        self flag::set(toset);
    } else {
        self flag::clear(toset);
    }
    return true;
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0x461ce453, Offset: 0x14a8
// Size: 0x198
function set_dr_flag(toset, setto) {
    if (!isdefined(setto)) {
        setto = 1;
    }
    /#
        assert(isdefined(setto));
    #/
    if (isarray(toset)) {
        foreach (ts in toset) {
            set_dr_flag(ts, setto);
        }
        return;
    }
    if (!isdefined(self.flag) || !isdefined(self.flag[toset])) {
        self flag::init(toset);
    }
    if (setto == self.flag[toset]) {
        return 0;
    }
    if (isdefined(setto) && setto) {
        self flag::set(toset);
    } else {
        self flag::clear(toset);
    }
    return 1;
}

// Namespace duplicate_render
// Params 1, eflags: 0x1 linked
// Checksum 0x5daef493, Offset: 0x1648
// Size: 0x24
function clear_dr_flag(toclear) {
    set_dr_flag(toclear, 0);
}

// Namespace duplicate_render
// Params 3, eflags: 0x1 linked
// Checksum 0x60513159, Offset: 0x1678
// Size: 0xf4
function change_dr_flags(localclientnum, toset, toclear) {
    if (isdefined(toset)) {
        if (isstring(toset)) {
            toset = strtok(toset, ",");
        }
        self set_dr_flag(toset);
    }
    if (isdefined(toclear)) {
        if (isstring(toclear)) {
            toclear = strtok(toclear, ",");
        }
        self clear_dr_flag(toclear);
    }
    update_dr_filters(localclientnum);
}

// Namespace duplicate_render
// Params 1, eflags: 0x1 linked
// Checksum 0x5d7ec2ff, Offset: 0x1778
// Size: 0x122
function _update_dr_filters(localclientnum) {
    self notify(#"update_dr_filters");
    self endon(#"update_dr_filters");
    self endon(#"entityshutdown");
    waittillframeend();
    foreach (key, filterset in level.drfilters) {
        filter = self find_dr_filter(filterset);
        if (!isdefined(self.currentdrfilter) || isdefined(filter) && !(self.currentdrfilter[key] === filter.name)) {
            self apply_filter(localclientnum, filter, key);
        }
    }
}

// Namespace duplicate_render
// Params 1, eflags: 0x1 linked
// Checksum 0x4ef65ea6, Offset: 0x18a8
// Size: 0x24
function update_dr_filters(localclientnum) {
    self thread _update_dr_filters(localclientnum);
}

// Namespace duplicate_render
// Params 1, eflags: 0x1 linked
// Checksum 0x701ab3f1, Offset: 0x18d8
// Size: 0xfc
function find_dr_filter(filterset) {
    if (!isdefined(filterset)) {
        filterset = level.drfilters["framebuffer"];
    }
    best = undefined;
    foreach (filter in filterset) {
        if (self can_use_filter(filter)) {
            if (!isdefined(best) || filter.priority > best.priority) {
                best = filter;
            }
        }
    }
    return best;
}

// Namespace duplicate_render
// Params 1, eflags: 0x1 linked
// Checksum 0x109f258c, Offset: 0x19e0
// Size: 0xc8
function can_use_filter(filter) {
    for (i = 0; i < filter.require.size; i++) {
        if (!self flagsys::get(filter.require[i])) {
            return false;
        }
    }
    for (i = 0; i < filter.refuse.size; i++) {
        if (self flagsys::get(filter.refuse[i])) {
            return false;
        }
    }
    return true;
}

// Namespace duplicate_render
// Params 3, eflags: 0x1 linked
// Checksum 0x48752a49, Offset: 0x1ab0
// Size: 0x364
function apply_filter(localclientnum, filter, filterset) {
    if (!isdefined(filterset)) {
        filterset = "framebuffer";
    }
    if (isdefined(level.postgame) && level.postgame && !(isdefined(level.showedtopthreeplayers) && level.showedtopthreeplayers)) {
        player = getlocalplayer(localclientnum);
        if (!player getinkillcam(localclientnum)) {
            return;
        }
    }
    /#
        if (getdvarint("mc/hud_keyline_retrievable")) {
            name = "mc/hud_keyline_retrievable";
            if (self isplayer()) {
                if (isdefined(self.name)) {
                    name = "mc/hud_keyline_retrievable" + self.name;
                }
            } else if (isdefined(self.model)) {
                name += "mc/hud_keyline_retrievable" + self.model;
            }
            msg = "mc/hud_keyline_retrievable" + filter.name + "mc/hud_keyline_retrievable" + name + "mc/hud_keyline_retrievable" + filterset;
            println(msg);
        }
    #/
    if (!isdefined(self.currentdrfilter)) {
        self.currentdrfilter = [];
    }
    self.currentdrfilter[filterset] = filter.name;
    opts = filter.types.size;
    for (i = 0; i < opts; i++) {
        type = filter.types[i];
        value = filter.values[i];
        culling = filter.culling[i];
        material = undefined;
        if (isstring(value)) {
            material = filter::mapped_material_id(value);
            value = 3;
            if (isdefined(value) && isdefined(material)) {
                self addduplicaterenderoption(type, value, material, culling);
            } else {
                self.currentdrfilter[filterset] = undefined;
            }
            continue;
        }
        self addduplicaterenderoption(type, value, -1, culling);
    }
    if (sessionmodeismultiplayergame()) {
        self thread disable_all_filters_on_game_ended();
    }
}

// Namespace duplicate_render
// Params 0, eflags: 0x1 linked
// Checksum 0xb86234df, Offset: 0x1e20
// Size: 0x4c
function disable_all_filters_on_game_ended() {
    self endon(#"entityshutdown");
    self notify(#"disable_all_filters_on_game_ended");
    self endon(#"disable_all_filters_on_game_ended");
    level waittill(#"post_game");
    self disableduplicaterendering();
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0xb4bf1258, Offset: 0x1e78
// Size: 0x3c
function set_item_retrievable(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "retrievable", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x0
// Checksum 0xfc573133, Offset: 0x1ec0
// Size: 0x3c
function set_item_unplaceable(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "unplaceable", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0x69fdc590, Offset: 0x1f08
// Size: 0x3c
function set_item_enemy_equipment(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "enemyequip", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0x184c4ac5, Offset: 0x1f50
// Size: 0x3c
function set_item_friendly_equipment(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "friendlyequip", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0x30626352, Offset: 0x1f98
// Size: 0x3c
function function_5ceb14b2(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "enemyexplo", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0xd1e11e6, Offset: 0x1fe0
// Size: 0x3c
function function_4e2867e3(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "friendlyexplo", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0xfef61605, Offset: 0x2028
// Size: 0x3c
function function_a28d1a5f(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "enemyvehicle", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0xc5c62de3, Offset: 0x2070
// Size: 0x3c
function function_48e05b4a(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "friendlyvehicle", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x0
// Checksum 0xa733342a, Offset: 0x20b8
// Size: 0x3c
function set_entity_thermal(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "infrared_entity", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0x82d480d6, Offset: 0x2100
// Size: 0x3c
function set_player_threat_detected(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "threat_detector_enemy", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x0
// Checksum 0x66d5f1e4, Offset: 0x2148
// Size: 0x3c
function set_hacker_tool_hacked(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "hacker_tool_hacked", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0x705f2d36, Offset: 0x2190
// Size: 0x3c
function set_hacker_tool_hacking(localclientnum, on_off) {
    self update_dr_flag(localclientnum, "hacker_tool_hacking", on_off);
}

// Namespace duplicate_render
// Params 2, eflags: 0x1 linked
// Checksum 0x95fa120d, Offset: 0x21d8
// Size: 0xd4
function set_hacker_tool_breaching(localclientnum, on_off) {
    flags_changed = self set_dr_flag("hacker_tool_breaching", on_off);
    if (on_off) {
        flags_changed = self set_dr_flag("enemyvehicle", 0) || flags_changed;
    } else if (isdefined(self.var_2c088b81) && self.var_2c088b81) {
        flags_changed = self set_dr_flag("enemyvehicle", 1) || flags_changed;
    }
    if (flags_changed) {
        update_dr_filters(localclientnum);
    }
}

// Namespace duplicate_render
// Params 1, eflags: 0x1 linked
// Checksum 0x25d22344, Offset: 0x22b8
// Size: 0x46
function show_friendly_outlines(local_client_num) {
    if (!(isdefined(level.friendlycontentoutlines) && level.friendlycontentoutlines)) {
        return false;
    }
    if (isshoutcaster(local_client_num)) {
        return false;
    }
    return true;
}

