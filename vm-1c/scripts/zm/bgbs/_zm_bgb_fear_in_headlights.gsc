#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_105bda17;

// Namespace namespace_105bda17
// Params 0, eflags: 0x2
// namespace_105bda17<file_0>::function_2dc19561
// Checksum 0xfe62b444, Offset: 0x1f0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_fear_in_headlights", &__init__, undefined, "bgb");
}

// Namespace namespace_105bda17
// Params 0, eflags: 0x1 linked
// namespace_105bda17<file_0>::function_8c87d8eb
// Checksum 0x5eb6920c, Offset: 0x230
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_fear_in_headlights", "activated", 1, undefined, undefined, &validation, &activation);
}

// Namespace namespace_105bda17
// Params 0, eflags: 0x5 linked
// namespace_105bda17<file_0>::function_b13c2f15
// Checksum 0x45567d84, Offset: 0x2a0
// Size: 0x84
function private function_b13c2f15() {
    self endon(#"hash_4e7f43fc");
    self waittill(#"death");
    if (isdefined(self) && self ispaused()) {
        self setentitypaused(0);
        if (!self isragdoll()) {
            self startragdoll();
        }
    }
}

// Namespace namespace_105bda17
// Params 1, eflags: 0x5 linked
// namespace_105bda17<file_0>::function_b8eb33c5
// Checksum 0x12dc37be, Offset: 0x330
// Size: 0xac
function private freeze_ai(ai) {
    ai notify(#"hash_4e7f43fc");
    ai thread function_b13c2f15();
    ai setentitypaused(1);
    ai.var_70a58794 = ai.b_ignore_cleanup;
    ai.b_ignore_cleanup = 1;
    ai.var_7f7a0b19 = ai.is_inert;
    ai.is_inert = 1;
}

// Namespace namespace_105bda17
// Params 1, eflags: 0x5 linked
// namespace_105bda17<file_0>::function_31a2964e
// Checksum 0x4053149d, Offset: 0x3e8
// Size: 0xa8
function private function_31a2964e(ai) {
    ai notify(#"hash_4e7f43fc");
    ai setentitypaused(0);
    if (isdefined(ai.var_7f7a0b19)) {
        ai.is_inert = ai.var_7f7a0b19;
    }
    if (isdefined(ai.var_70a58794)) {
        ai.b_ignore_cleanup = ai.var_70a58794;
        return;
    }
    ai.b_ignore_cleanup = 0;
}

// Namespace namespace_105bda17
// Params 3, eflags: 0x5 linked
// namespace_105bda17<file_0>::function_723d94f5
// Checksum 0xaa2beebd, Offset: 0x498
// Size: 0x1b2
function private function_723d94f5(allai, trace, degree) {
    if (!isdefined(degree)) {
        degree = 45;
    }
    var_f1649153 = allai;
    players = getplayers();
    var_445b9352 = cos(degree);
    foreach (player in players) {
        var_f1649153 = player cantseeentities(var_f1649153, var_445b9352, trace);
    }
    foreach (ai in var_f1649153) {
        if (isalive(ai)) {
            function_31a2964e(ai);
        }
    }
}

// Namespace namespace_105bda17
// Params 0, eflags: 0x1 linked
// namespace_105bda17<file_0>::function_e4776d0
// Checksum 0x528443d1, Offset: 0x658
// Size: 0x26
function validation() {
    if (bgb::is_team_active("zm_bgb_fear_in_headlights")) {
        return false;
    }
    return true;
}

// Namespace namespace_105bda17
// Params 0, eflags: 0x1 linked
// namespace_105bda17<file_0>::function_7afbf7cd
// Checksum 0xe94cb83f, Offset: 0x688
// Size: 0xa2
function activation() {
    self endon(#"disconnect");
    self thread function_deeb696f();
    self playsound("zmb_bgb_fearinheadlights_start");
    self playloopsound("zmb_bgb_fearinheadlights_loop");
    self thread function_2715245a();
    self bgb::run_timer(120);
    self notify(#"hash_2715245a");
}

// Namespace namespace_105bda17
// Params 0, eflags: 0x1 linked
// namespace_105bda17<file_0>::function_deeb696f
// Checksum 0xb4d3ac8, Offset: 0x738
// Size: 0x318
function function_deeb696f() {
    self endon(#"disconnect");
    self endon(#"hash_2715245a");
    var_bd6badee = 1200 * 1200;
    while (true) {
        allai = getaiarray();
        foreach (ai in allai) {
            if (isdefined(ai.var_48cabef5) && ai [[ ai.var_48cabef5 ]]()) {
                continue;
            }
            if (isalive(ai) && !ai ispaused() && ai.team == level.zombie_team && !ai ishidden() && !(isdefined(ai.var_a5db58c6) && ai.var_a5db58c6)) {
                freeze_ai(ai);
            }
        }
        var_e4760c66 = [];
        closeai = [];
        foreach (ai in allai) {
            if (isdefined(ai.aat_turned) && ai.aat_turned && ai ispaused()) {
                function_31a2964e(ai);
                continue;
            }
            if (distance2dsquared(ai.origin, self.origin) >= var_bd6badee) {
                var_e4760c66[var_e4760c66.size] = ai;
                continue;
            }
            closeai[closeai.size] = ai;
        }
        function_723d94f5(var_e4760c66, 1);
        function_723d94f5(closeai, 0, 75);
        wait(0.05);
    }
}

// Namespace namespace_105bda17
// Params 0, eflags: 0x1 linked
// namespace_105bda17<file_0>::function_2715245a
// Checksum 0x95068479, Offset: 0xa58
// Size: 0x11a
function function_2715245a() {
    str_notify = self util::waittill_any_return("death", "kill_fear_in_headlights");
    if (str_notify == "kill_fear_in_headlights") {
        self stoploopsound();
        self playsound("zmb_bgb_fearinheadlights_end");
    }
    allai = getaiarray();
    foreach (ai in allai) {
        function_31a2964e(ai);
    }
}

