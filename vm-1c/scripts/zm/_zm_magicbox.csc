#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_magicbox;

// Namespace zm_magicbox
// Params 0, eflags: 0x2
// Checksum 0x3041b061, Offset: 0x228
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_magicbox", &__init__, undefined, undefined);
}

// Namespace zm_magicbox
// Params 0, eflags: 0x1 linked
// Checksum 0x15a92a1e, Offset: 0x268
// Size: 0x19c
function __init__() {
    level._effect["chest_light"] = "zombie/fx_weapon_box_open_glow_zmb";
    level._effect["chest_light_closed"] = "zombie/fx_weapon_box_closed_glow_zmb";
    clientfield::register("zbarrier", "magicbox_open_glow", 1, 1, "int", &function_f900ae76, 0, 0);
    clientfield::register("zbarrier", "magicbox_closed_glow", 1, 1, "int", &function_5eb1f58e, 0, 0);
    clientfield::register("zbarrier", "zbarrier_show_sounds", 1, 1, "counter", &magicbox_show_sounds_callback, 1, 0);
    clientfield::register("zbarrier", "zbarrier_leave_sounds", 1, 1, "counter", &magicbox_leave_sounds_callback, 1, 0);
    clientfield::register("scriptmover", "force_stream", 7000, 1, "int", &force_stream_changed, 0, 0);
}

// Namespace zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0x2b7ff53b, Offset: 0x410
// Size: 0x84
function force_stream_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        model = self.model;
        if (isdefined(model)) {
            thread stream_model_for_time(localclientnum, model, 15);
        }
    }
}

// Namespace zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x568c8c9f, Offset: 0x4a0
// Size: 0x92
function function_85cbbac5(model) {
    if (isdefined(model)) {
        if (!isdefined(level.model_locks)) {
            level.model_locks = [];
        }
        if (!isdefined(level.model_locks[model])) {
            level.model_locks[model] = 0;
        }
        if (level.model_locks[model] < 1) {
            forcestreamxmodel(model);
        }
        level.model_locks[model]++;
    }
}

// Namespace zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x83cf2af1, Offset: 0x540
// Size: 0x94
function function_3ceed68a(model) {
    if (isdefined(model)) {
        if (!isdefined(level.model_locks)) {
            level.model_locks = [];
        }
        if (!isdefined(level.model_locks[model])) {
            level.model_locks[model] = 0;
        }
        level.model_locks[model]--;
        if (level.model_locks[model] < 1) {
            stopforcestreamingxmodel(model);
        }
    }
}

// Namespace zm_magicbox
// Params 3, eflags: 0x1 linked
// Checksum 0xc01f8ae1, Offset: 0x5e0
// Size: 0x54
function stream_model_for_time(localclientnum, model, time) {
    function_85cbbac5(model);
    wait time;
    function_3ceed68a(model);
}

// Namespace zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0xe8dff6f1, Offset: 0x640
// Size: 0xb4
function magicbox_show_sounds_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playsound(localclientnum, "zmb_box_poof_land", self.origin);
    playsound(localclientnum, "zmb_couch_slam", self.origin);
    playsound(localclientnum, "zmb_box_poof", self.origin);
}

// Namespace zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0x54528e66, Offset: 0x700
// Size: 0x8c
function magicbox_leave_sounds_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playsound(localclientnum, "zmb_box_move", self.origin);
    playsound(localclientnum, "zmb_whoosh", self.origin);
}

// Namespace zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0xa0077f8e, Offset: 0x798
// Size: 0x6c
function function_f900ae76(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_7ceee06f(localclientnum, newval, level._effect["chest_light"]);
}

// Namespace zm_magicbox
// Params 7, eflags: 0x1 linked
// Checksum 0x208dd9ad, Offset: 0x810
// Size: 0x6c
function function_5eb1f58e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self thread function_7ceee06f(localclientnum, newval, level._effect["chest_light_closed"]);
}

// Namespace zm_magicbox
// Params 3, eflags: 0x1 linked
// Checksum 0x18eecaaa, Offset: 0x888
// Size: 0x154
function function_7ceee06f(localclientnum, newval, fx) {
    if (!isdefined(self.var_7e140a2e)) {
        self.var_7e140a2e = [];
    }
    if (!isdefined(self.var_49105e09)) {
        self.var_49105e09 = [];
    }
    if (!isdefined(self.var_7e140a2e[localclientnum])) {
        fx_obj = spawn(localclientnum, self.origin, "script_model");
        fx_obj setmodel("tag_origin");
        fx_obj.angles = self.angles;
        self.var_7e140a2e[localclientnum] = fx_obj;
        wait 0.016;
    }
    self function_f40b6915(localclientnum);
    if (newval) {
        self.var_49105e09[localclientnum] = playfxontag(localclientnum, fx, self.var_7e140a2e[localclientnum], "tag_origin");
        self function_44de164c(localclientnum);
    }
}

// Namespace zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x2b5300ae, Offset: 0x9e8
// Size: 0x44
function function_44de164c(localclientnum) {
    self endon(#"end_demo_jump_listener");
    level waittill(#"demo_jump");
    if (isdefined(self)) {
        self function_f40b6915(localclientnum);
    }
}

// Namespace zm_magicbox
// Params 1, eflags: 0x1 linked
// Checksum 0x2f8c75e0, Offset: 0xa38
// Size: 0x5e
function function_f40b6915(localclientnum) {
    if (isdefined(self.var_49105e09[localclientnum])) {
        stopfx(localclientnum, self.var_49105e09[localclientnum]);
        self.var_49105e09[localclientnum] = undefined;
    }
    self notify(#"end_demo_jump_listener");
}

