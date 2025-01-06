#using scripts/codescripts/struct;
#using scripts/shared/system_shared;

#namespace zm_timer;

// Namespace zm_timer
// Params 0, eflags: 0x2
// Checksum 0xc8eb4dfa, Offset: 0xe8
// Size: 0x2c
function autoexec function_2dc19561() {
    system::register("zm_timer", undefined, &__main__, undefined);
}

// Namespace zm_timer
// Params 0, eflags: 0x0
// Checksum 0x4bc015a4, Offset: 0x120
// Size: 0x1c
function __main__() {
    if (!isdefined(level.var_cfe53fb8)) {
        level.var_cfe53fb8 = 96;
    }
}

// Namespace zm_timer
// Params 2, eflags: 0x0
// Checksum 0xa25cab14, Offset: 0x148
// Size: 0x2dc
function start_timer(time, stop_notify) {
    self notify(#"hash_83cd452d");
    self endon(#"hash_83cd452d");
    self endon(#"disconnect");
    if (!isdefined(self.var_1c80cd20)) {
        self.var_1c80cd20 = newclienthudelem(self);
        self.var_1c80cd20.horzalign = "left";
        self.var_1c80cd20.vertalign = "top";
        self.var_1c80cd20.alignx = "left";
        self.var_1c80cd20.aligny = "top";
        self.var_1c80cd20.x = 10;
        self.var_1c80cd20.alpha = 0;
        self.var_1c80cd20.sort = 2;
        self.var_8f6216c9 = newclienthudelem(self);
        self.var_8f6216c9.horzalign = "left";
        self.var_8f6216c9.vertalign = "top";
        self.var_8f6216c9.alignx = "left";
        self.var_8f6216c9.aligny = "top";
        self.var_8f6216c9.x = 10;
        self.var_8f6216c9.alpha = 0;
        self.var_8f6216c9.sort = 3;
        self.var_8f6216c9 setshader("zombie_stopwatch_glass", level.var_cfe53fb8, level.var_cfe53fb8);
    }
    self thread function_83ea29ce();
    if (isdefined(stop_notify)) {
        self thread function_e018c20f(stop_notify);
    }
    if (time > 60) {
        time = 0;
    }
    self.var_1c80cd20 setclock(time, 60, "zombie_stopwatch", level.var_cfe53fb8, level.var_cfe53fb8);
    self.var_1c80cd20.alpha = 1;
    self.var_8f6216c9.alpha = 1;
    wait time;
    self notify(#"hash_51439d77");
    wait 1;
    self.var_1c80cd20.alpha = 0;
    self.var_8f6216c9.alpha = 0;
}

// Namespace zm_timer
// Params 1, eflags: 0x0
// Checksum 0x1e248d30, Offset: 0x430
// Size: 0x54
function function_e018c20f(stop_notify) {
    self endon(#"hash_83cd452d");
    self endon(#"hash_51439d77");
    self waittill(stop_notify);
    self.var_1c80cd20.alpha = 0;
    self.var_8f6216c9.alpha = 0;
}

// Namespace zm_timer
// Params 0, eflags: 0x0
// Checksum 0x3a6775ea, Offset: 0x490
// Size: 0x64
function function_83ea29ce() {
    self endon(#"disconnect");
    self endon(#"hash_83cd452d");
    self endon(#"hash_51439d77");
    while (true) {
        self.var_1c80cd20.y = 20;
        self.var_8f6216c9.y = 20;
        wait 0.05;
    }
}

