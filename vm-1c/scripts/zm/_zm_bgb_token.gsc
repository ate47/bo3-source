#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_ade8e118;

// Namespace namespace_ade8e118
// Params 0, eflags: 0x2
// Checksum 0xe9dc99bf, Offset: 0x200
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("bgb_token", &__init__, &__main__, undefined);
}

// Namespace namespace_ade8e118
// Params 0, eflags: 0x5 linked
// Checksum 0x52543f79, Offset: 0x248
// Size: 0x3c
function private __init__() {
    if (!function_4922937f()) {
        return;
    }
    callback::on_spawned(&on_player_spawned);
}

// Namespace namespace_ade8e118
// Params 0, eflags: 0x5 linked
// Checksum 0xc773b658, Offset: 0x290
// Size: 0xfc
function private __main__() {
    if (!function_4922937f()) {
        return;
    }
    if (!isdefined(level.var_a73c4888)) {
        level.var_a73c4888 = -1;
    }
    if (!isdefined(level.var_baa8fd09)) {
        level.var_baa8fd09 = 3600;
    }
    if (!isdefined(level.var_342aa5b2)) {
        level.var_342aa5b2 = 0.33;
    }
    if (!isdefined(level.var_4d1d42c7)) {
        level.var_4d1d42c7 = 5;
    }
    if (!isdefined(level.var_5f0752c5)) {
        level.var_5f0752c5 = 1000;
    }
    if (!isdefined(level.var_af87760a)) {
        level.var_af87760a = 0.33;
    }
    if (!isdefined(level.var_bc978de9)) {
        level.var_bc978de9 = 8;
    }
    if (!isdefined(level.var_c50e9bdb)) {
        level.var_c50e9bdb = 9;
    }
    /#
        level thread setup_devgui();
    #/
}

// Namespace namespace_ade8e118
// Params 0, eflags: 0x5 linked
// Checksum 0xc86cd741, Offset: 0x398
// Size: 0x60
function private on_player_spawned() {
    if (!isdefined(self.var_27b6cdab)) {
        self.var_27b6cdab = self zm_stats::get_global_stat("BGB_TOKEN_LAST_GIVEN_TIME");
        self.var_f191a1fc = 0;
        self.var_bc978de9 = level.var_bc978de9 + level.round_number - 1;
    }
}

// Namespace namespace_ade8e118
// Params 0, eflags: 0x5 linked
// Checksum 0xded9743f, Offset: 0x400
// Size: 0x66
function private function_4922937f() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use) || !level.onlinegame || !getdvarint("loot_enabled")) {
        return false;
    }
    if (function_77110410()) {
        return false;
    }
    return true;
}

// Namespace namespace_ade8e118
// Params 1, eflags: 0x0
// Checksum 0xe77678e5, Offset: 0x470
// Size: 0xc6
function function_c2f81136(increment) {
    if (!function_4922937f()) {
        return;
    }
    foreach (player in level.players) {
        if (isdefined(player.var_bc978de9)) {
            player.var_bc978de9 += increment;
        }
    }
}

/#

    // Namespace namespace_ade8e118
    // Params 0, eflags: 0x5 linked
    // Checksum 0x519b1518, Offset: 0x540
    // Size: 0x8c
    function private setup_devgui() {
        waittillframeend();
        setdvar("<unknown string>", "<unknown string>");
        bgb_devgui_base = "<unknown string>";
        adddebugcommand(bgb_devgui_base + "<unknown string>" + "<unknown string>" + "<unknown string>");
        level thread function_a29384f8();
    }

    // Namespace namespace_ade8e118
    // Params 0, eflags: 0x5 linked
    // Checksum 0xd305b917, Offset: 0x5d8
    // Size: 0x88
    function private function_a29384f8() {
        for (;;) {
            var_2e29895e = getdvarstring("<unknown string>");
            if (var_2e29895e != "<unknown string>") {
                level.players[0] function_32692a60();
            }
            setdvar("<unknown string>", "<unknown string>");
            wait(0.5);
        }
    }

#/

// Namespace namespace_ade8e118
// Params 0, eflags: 0x5 linked
// Checksum 0xa9e07aba, Offset: 0x668
// Size: 0x12c
function private function_32692a60() {
    var_90491adb = int(self function_5d823f3c());
    for (count = 0; count < var_90491adb; count++) {
        self incrementbgbtokensgained();
    }
    self.var_f191a1fc += var_90491adb;
    self.var_bc978de9 += level.var_c50e9bdb;
    self.var_27b6cdab = self zm_stats::get_global_stat("TIME_PLAYED_TOTAL");
    self zm_stats::set_global_stat("BGB_TOKEN_LAST_GIVEN_TIME", self.var_27b6cdab);
    uploadstats(self);
    self reportlootreward("3", var_90491adb);
}

// Namespace namespace_ade8e118
// Params 1, eflags: 0x5 linked
// Checksum 0xfb292a0, Offset: 0x7a0
// Size: 0x34
function private function_2d75b98d(var_ce9d31c4) {
    if (randomfloat(1) < var_ce9d31c4) {
        return true;
    }
    return false;
}

// Namespace namespace_ade8e118
// Params 1, eflags: 0x1 linked
// Checksum 0x9fef18d2, Offset: 0x7e0
// Size: 0x1ec
function function_51cf4361(var_5561679e) {
    if (!function_4922937f()) {
        return;
    }
    if (0 <= level.var_a73c4888 && self.var_f191a1fc >= level.var_a73c4888) {
        return;
    }
    time_played_total = self zm_stats::get_global_stat("TIME_PLAYED_TOTAL");
    if (time_played_total - level.var_baa8fd09 > self.var_27b6cdab) {
        if (function_2d75b98d(level.var_342aa5b2)) {
            self function_32692a60();
        }
        return;
    }
    if (level.round_number < level.var_4d1d42c7) {
        return;
    }
    var_95d14cf5 = math::clamp(var_5561679e, 0, level.var_5f0752c5);
    var_741485e6 = float(var_95d14cf5) / level.var_5f0752c5;
    if (!function_2d75b98d(var_741485e6 * level.var_af87760a)) {
        return;
    }
    var_edfe0eb4 = self.var_bc978de9 - level.round_number;
    if (1 > var_edfe0eb4) {
        var_edfe0eb4 = 1;
    }
    var_b8a1486b = float(var_edfe0eb4 * var_edfe0eb4);
    if (!function_2d75b98d(1 / var_b8a1486b)) {
        return;
    }
    self function_32692a60();
}

