#using scripts/shared/stealth;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth_player;
#using scripts/shared/stealth_tagging;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace stealth_status;

// Namespace stealth_status
// Params 0, eflags: 0x0
// Checksum 0x9d1d498d, Offset: 0x1e8
// Size: 0xba
function init() {
    assert(isdefined(self.stealth));
    assert(!isdefined(self.stealth.status));
    if (!isdefined(self.stealth.status)) {
        self.stealth.status = spawnstruct();
    }
    self.stealth.status.icons = [];
    self.stealth.status.var_2eb71ab0 = undefined;
    self thread function_f9fc005b();
    self thread function_6789ff4f();
}

// Namespace stealth_status
// Params 0, eflags: 0x0
// Checksum 0x875c60e1, Offset: 0x2b0
// Size: 0x1e
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.status);
}

// Namespace stealth_status
// Params 4, eflags: 0x0
// Checksum 0x58088bc9, Offset: 0x2d8
// Size: 0x100
function function_71d2217b(var_5cbd0572, v_origin, z_offset, var_32b38549) {
    var_88ac910a = undefined;
    if (!isdefined(var_32b38549)) {
        var_88ac910a = newhudelem();
    } else {
        var_88ac910a = newclienthudelem(var_32b38549);
    }
    var_88ac910a.horzalign = "right";
    var_88ac910a.vertalign = "middle";
    var_88ac910a.sort = 2;
    var_88ac910a setshader(var_5cbd0572, 5, 5);
    var_88ac910a setwaypoint(1, var_5cbd0572, 0, 0);
    var_88ac910a.hidewheninmenu = 1;
    var_88ac910a.immunetodemogamehudsettings = 1;
    var_88ac910a.x = v_origin[0];
    var_88ac910a.y = v_origin[1];
    var_88ac910a.z = v_origin[2] + z_offset;
    return var_88ac910a;
}

// Namespace stealth_status
// Params 2, eflags: 0x0
// Checksum 0xd0338a5f, Offset: 0x3e0
// Size: 0x167
function function_cf9dd532(var_32b38549, var_f69107b4) {
    if (!isdefined(var_f69107b4)) {
        var_f69107b4 = 0;
    }
    index = -1;
    if (isdefined(var_32b38549)) {
        index = var_32b38549 getentitynumber() + var_f69107b4;
    }
    if (!isdefined(self.stealth.status.var_2eb71ab0)) {
        ent = util::spawn_model("tag_origin", self.origin + (0, 0, 92), (0, 0, 0));
        ent linkto(self);
        self.stealth.status.var_2eb71ab0 = ent;
    }
    if (!isdefined(self.stealth.status.icons[index])) {
        icon = function_71d2217b("white_stealth_arrow_01", self.stealth.status.var_2eb71ab0.origin, 16, var_32b38549);
        icon settargetent(self.stealth.status.var_2eb71ab0);
        self.stealth.status.icons[index] = icon;
    }
}

// Namespace stealth_status
// Params 2, eflags: 0x0
// Checksum 0xaafcd2db, Offset: 0x550
// Size: 0x1d1
function function_180adb28(index, var_f69107b4) {
    if (!isdefined(self) || !isdefined(self.stealth) || !isdefined(self.stealth.status) || !isdefined(self.stealth.status.icons)) {
        return;
    }
    if (!isdefined(var_f69107b4)) {
        var_f69107b4 = 0;
    }
    if (isdefined(index)) {
        if (isdefined(self.stealth.status.icons[index])) {
            self.stealth.status.icons[index] destroy();
            self.stealth.status.icons[index] = undefined;
        }
    } else {
        foreach (icon in self.stealth.status.icons) {
            if (isdefined(icon)) {
                icon destroy();
            }
        }
        self.stealth.status.icons = [];
    }
    if (isdefined(self.stealth.status.var_2eb71ab0) && self.stealth.status.icons.size == 0) {
        self.stealth.status.var_2eb71ab0 delete();
        self.stealth.status.var_2eb71ab0 = undefined;
    }
}

// Namespace stealth_status
// Params 0, eflags: 0x0
// Checksum 0x7e015acf, Offset: 0x730
// Size: 0x71
function function_6789ff4f() {
    self endon(#"stop_stealth");
    self endon(#"death");
    while (true) {
        util::waittill_any("stealth_sight_start", "alert");
        while (isalive(self)) {
            if (!self update()) {
                break;
            }
            wait 0.05;
        }
    }
}

// Namespace stealth_status
// Params 1, eflags: 0x0
// Checksum 0xbe491f19, Offset: 0x7b0
// Size: 0x53
function function_16c0c92e(alertlevel) {
    if (alertlevel < 0) {
        alertlevel = 0;
    }
    if (alertlevel > 1) {
        alertlevel = 1;
    }
    return "white_stealth_arrow_0" + 1 + int(7 * alertlevel);
}

// Namespace stealth_status
// Params 0, eflags: 0x0
// Checksum 0x34d113e3, Offset: 0x810
// Size: 0x485
function update() {
    var_4bf6d951 = 0;
    playerlist = getplayers();
    foreach (player in playerlist) {
        index = player getentitynumber();
        var_1f013b13 = self getstealthsightvalue(player);
        awareness = self stealth_aware::function_739525d();
        var_dc5d33fe = awareness == "combat" || awareness == "high_alert";
        var_98e4a612 = var_dc5d33fe && isdefined(self.stealth.var_c49c37ed[index]);
        var_a0982047 = isdefined(self.stealth.var_d1b49f30[index]);
        var_416f4d35 = var_1f013b13 > 0;
        bcansee = self stealth::can_see(player) && !self.ignoreall;
        if (!(isdefined(self.silenced) && self.silenced) && player stealth_player::enabled()) {
            if (var_98e4a612) {
                player stealth_player::function_f5f81ff0(self, var_1f013b13);
            }
            if (isdefined(self.stealth.var_7a604d90[index]) || var_416f4d35) {
                player thread stealth_player::function_3cd0dcd(self, bcansee, awareness);
                if (var_98e4a612 || var_a0982047) {
                    player stealth_player::function_cd81f5b8(self, 1);
                } else {
                    player stealth_player::function_cd81f5b8(self, var_1f013b13);
                }
                var_4bf6d951 = var_4bf6d951 || var_98e4a612 || var_a0982047 || var_416f4d35;
            }
        }
        var_c1cdaaeb = 0;
        /#
            var_c1cdaaeb = stealth_debug::enabled();
        #/
        if (var_416f4d35 || (getdvarint("stealth_display", 1) == 2 || var_c1cdaaeb) && var_dc5d33fe) {
            self function_cf9dd532(player);
            var_4bf6d951 = 1;
            var_5cbd0572 = "white_stealth_arrow_01";
            color = stealth::function_b7ff7c00("unaware");
            if (!var_98e4a612 && var_dc5d33fe) {
                color = stealth::function_b7ff7c00(awareness);
            } else if (self stealth_aware::function_739525d() == "unaware") {
                var_5cbd0572 = function_16c0c92e(var_1f013b13);
                color = stealth::function_b7ff7c00(awareness);
            } else {
                var_5cbd0572 = function_16c0c92e(var_1f013b13);
                color = stealth::function_b7ff7c00(awareness);
            }
            if (isdefined(self.stealth.status.var_2eb71ab0) && isdefined(self.stealth.status.icons[index])) {
                self.stealth.status.icons[index] settargetent(self.stealth.status.var_2eb71ab0);
                self.stealth.status.icons[index] setshader(var_5cbd0572, 5, 5);
                self.stealth.status.icons[index] setwaypoint(0, var_5cbd0572, 0, 0);
                self.stealth.status.icons[index].color = color;
            }
            continue;
        }
        if (isdefined(self.stealth.status.icons[index])) {
            self function_180adb28(index);
        }
    }
    return var_4bf6d951;
}

// Namespace stealth_status
// Params 0, eflags: 0x0
// Checksum 0x867671ac, Offset: 0xca0
// Size: 0x3a
function function_f9fc005b() {
    self notify(#"hash_f51e1ce9");
    self endon(#"hash_f51e1ce9");
    self util::waittill_any("death");
    self function_180adb28();
}

