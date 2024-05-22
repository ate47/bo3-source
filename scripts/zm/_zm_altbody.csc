#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_util;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace zm_altbody;

// Namespace zm_altbody
// Params 0, eflags: 0x2
// Checksum 0x51758f32, Offset: 0x250
// Size: 0x34
function function_2dc19561() {
    system::register("zm_altbody", &__init__, undefined, undefined);
}

// Namespace zm_altbody
// Params 0, eflags: 0x0
// Checksum 0xcd8a76b9, Offset: 0x290
// Size: 0x104
function __init__() {
    clientfield::register("clientuimodel", "player_mana", 1, 8, "float", &set_player_mana, 0, 1);
    clientfield::register("toplayer", "player_in_afterlife", 1, 1, "int", &toggle_player_altbody, 0, 1);
    clientfield::register("allplayers", "player_altbody", 1, 1, "int", &toggle_player_altbody_3p, 0, 1);
    setupclientfieldcodecallbacks("toplayer", 1, "player_in_afterlife");
}

// Namespace zm_altbody
// Params 9, eflags: 0x0
// Checksum 0x1a5e248b, Offset: 0x3a0
// Size: 0x162
function init(name, trigger_name, trigger_hint, visionset_name, visionset_priority, enter_callback, exit_callback, enter_3p_callback, exit_3p_callback) {
    if (!isdefined(level.altbody_enter_callbacks)) {
        level.altbody_enter_callbacks = [];
    }
    if (!isdefined(level.altbody_exit_callbacks)) {
        level.altbody_exit_callbacks = [];
    }
    if (!isdefined(level.altbody_enter_3p_callbacks)) {
        level.altbody_enter_3p_callbacks = [];
    }
    if (!isdefined(level.altbody_exit_3p_callbacks)) {
        level.altbody_exit_3p_callbacks = [];
    }
    if (!isdefined(level.altbody_visionsets)) {
        level.altbody_visionsets = [];
    }
    level.altbody_name = name;
    if (isdefined(visionset_name)) {
        level.altbody_visionsets[name] = visionset_name;
        visionset_mgr::register_visionset_info(visionset_name, 1, 1, visionset_name, visionset_name);
    }
    level.altbody_enter_callbacks[name] = enter_callback;
    level.altbody_exit_callbacks[name] = exit_callback;
    level.altbody_enter_3p_callbacks[name] = enter_3p_callback;
    level.altbody_exit_3p_callbacks[name] = exit_3p_callback;
}

// Namespace zm_altbody
// Params 7, eflags: 0x0
// Checksum 0xcf14282c, Offset: 0x510
// Size: 0x48
function set_player_mana(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.mana = newval;
}

// Namespace zm_altbody
// Params 7, eflags: 0x0
// Checksum 0x2bcfd96f, Offset: 0x560
// Size: 0x14e
function toggle_player_altbody(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.altbody)) {
        self.altbody = 0;
    }
    self usealternatehud(newval);
    if (self.altbody !== newval) {
        self.altbody = newval;
        if (bwastimejump) {
            self thread clear_transition(localclientnum, newval);
        } else {
            self thread cover_transition(localclientnum, newval);
        }
        if (newval == 1) {
            callback = level.altbody_enter_callbacks[level.altbody_name];
            if (isdefined(callback)) {
                self [[ callback ]](localclientnum);
            }
            return;
        }
        callback = level.altbody_exit_callbacks[level.altbody_name];
        if (isdefined(callback)) {
            self [[ callback ]](localclientnum);
        }
    }
}

// Namespace zm_altbody
// Params 7, eflags: 0x0
// Checksum 0x5ec17c7a, Offset: 0x6b8
// Size: 0xe6
function toggle_player_altbody_3p(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self islocalplayer()) {
        return;
    }
    self.altbody_3p = newval;
    if (newval == 1) {
        callback = level.altbody_enter_3p_callbacks[level.altbody_name];
        if (isdefined(callback)) {
            self [[ callback ]](localclientnum);
        }
        return;
    }
    callback = level.altbody_exit_3p_callbacks[level.altbody_name];
    if (isdefined(callback)) {
        self [[ callback ]](localclientnum);
    }
}

// Namespace zm_altbody
// Params 2, eflags: 0x0
// Checksum 0x6f9067a, Offset: 0x7a8
// Size: 0xfc
function cover_transition(localclientnum, onoff) {
    if (!self islocalplayer() || isspectating(localclientnum, 0) || localclientnum !== self getlocalclientnumber()) {
        return;
    }
    if (isdemoplaying() && demoisanyfreemovecamera()) {
        return;
    }
    lui::screen_fade_out(0.05);
    level util::waittill_any_timeout(0.15, "demo_jump");
    if (isdefined(self)) {
        lui::screen_fade_in(0.1);
    }
}

// Namespace zm_altbody
// Params 2, eflags: 0x0
// Checksum 0xe36a93a2, Offset: 0x8b0
// Size: 0x2c
function clear_transition(localclientnum, onoff) {
    lui::screen_fade_in(0);
}

