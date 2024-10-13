#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/_oob;
#using scripts/shared/weapons/_smokegrenade;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace resurrect;

// Namespace resurrect
// Params 0, eflags: 0x2
// Checksum 0x1b73e12d, Offset: 0x4c8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_resurrect", &__init__, undefined, undefined);
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x600f0a12, Offset: 0x508
// Size: 0x2b4
function __init__() {
    clientfield::register("allplayers", "resurrecting", 1, 1, "int");
    clientfield::register("toplayer", "resurrect_state", 1, 2, "int");
    clientfield::register("clientuimodel", "hudItems.rejack.activationWindowEntered", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.rejack.rejackActivated", 1, 1, "int");
    ability_player::register_gadget_activation_callbacks(40, &function_ebf05e6f, &function_c5460123);
    ability_player::register_gadget_possession_callbacks(40, &function_3f55de4d, &function_c993b96f);
    ability_player::register_gadget_flicker_callbacks(40, &function_be7fa67a);
    ability_player::register_gadget_is_inuse_callbacks(40, &function_7b9336f);
    ability_player::register_gadget_is_flickering_callbacks(40, &function_77af85d7);
    ability_player::register_gadget_primed_callbacks(40, &function_5adab2a0);
    ability_player::register_gadget_ready_callbacks(40, &function_f00b1078);
    callback::on_connect(&function_8d17efc4);
    callback::on_spawned(&function_a3c47c6c);
    if (!isdefined(level.var_d4a6d98a)) {
        level.var_d4a6d98a = 62;
    }
    if (!isdefined(level.var_b2089f02)) {
        level.var_b2089f02 = 63;
    }
    visionset_mgr::register_info("visionset", "resurrect", 1, level.var_d4a6d98a, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
    visionset_mgr::register_info("visionset", "resurrect_up", 1, level.var_b2089f02, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
}

// Namespace resurrect
// Params 1, eflags: 0x1 linked
// Checksum 0xb640e3a, Offset: 0x7c8
// Size: 0x22
function function_7b9336f(slot) {
    return self gadgetisactive(slot);
}

// Namespace resurrect
// Params 1, eflags: 0x1 linked
// Checksum 0x72462163, Offset: 0x7f8
// Size: 0x22
function function_77af85d7(slot) {
    return self gadgetflickering(slot);
}

// Namespace resurrect
// Params 2, eflags: 0x1 linked
// Checksum 0x8c03c3a9, Offset: 0x828
// Size: 0x14
function function_be7fa67a(slot, weapon) {
    
}

// Namespace resurrect
// Params 2, eflags: 0x1 linked
// Checksum 0x64c8ac0e, Offset: 0x848
// Size: 0x2c
function function_3f55de4d(slot, weapon) {
    self.usedresurrect = 0;
    self.resurrect_weapon = weapon;
}

// Namespace resurrect
// Params 2, eflags: 0x1 linked
// Checksum 0xee7e0715, Offset: 0x880
// Size: 0x3a
function function_c993b96f(slot, weapon) {
    self.overrideplayerdeadstatus = undefined;
    self.resurrect_weapon = undefined;
    self.secondarydeathcamtime = undefined;
    self notify(#"hash_a3e5661a");
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0xc8e4f6ec, Offset: 0x8c8
// Size: 0xf4
function function_a3c47c6c() {
    self clientfield::set_player_uimodel("hudItems.rejack.activationWindowEntered", 0);
    self util::show_hud(1);
    self._disable_proximity_alarms = 0;
    self flagsys::clear("gadget_resurrect_ready");
    self flagsys::clear("gadget_resurrect_pending");
    if (self flagsys::get("gadget_resurrect_activated")) {
        self thread function_ffe831f5();
        self thread function_ab495fcb();
        self flagsys::clear("gadget_resurrect_activated");
    }
}

// Namespace resurrect
// Params 1, eflags: 0x1 linked
// Checksum 0x62a9156a, Offset: 0x9c8
// Size: 0xac
function function_ab495fcb(amount) {
    if (isdefined(self.resurrect_weapon)) {
        slot = self gadgetgetslot(self.resurrect_weapon);
        if (slot >= 0 && slot < 3) {
            if (isdefined(amount)) {
                self gadgetpowerchange(slot, amount);
                return;
            }
            self gadgetstatechange(slot, self.resurrect_weapon, 3);
        }
    }
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xa80
// Size: 0x4
function function_8d17efc4() {
    
}

// Namespace resurrect
// Params 2, eflags: 0x1 linked
// Checksum 0x2fe851a7, Offset: 0xa90
// Size: 0x14
function function_ebf05e6f(slot, weapon) {
    
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0xabd75b48, Offset: 0xab0
// Size: 0x194
function function_56e9efb7() {
    self endon(#"hash_cbdf5176");
    self endon(#"player_input_revive");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        if ((self isplayerswimming() || self isonground()) && !self iswallrunning() && !self istraversing()) {
            var_c10340db = getweapon("gadget_resurrect_smoke_grenade");
            var_1cacd2da = getweapon("gadget_resurrect");
            smokeeffect = smokegrenade::smokedetonate(self, var_1cacd2da, var_c10340db, self.origin, -128, 5, 4);
            smokeeffect thread function_f668c085(self);
            smokeeffect thread function_815c75f8(self);
            smokeeffect thread function_70fc2bc3(self);
            return;
        }
        wait 0.05;
    }
}

// Namespace resurrect
// Params 1, eflags: 0x1 linked
// Checksum 0xe13c0e20, Offset: 0xc50
// Size: 0x54
function function_70fc2bc3(player) {
    self endon(#"death");
    player util::waittill_any_timeout(5, "disconnect", "death");
    self delete();
}

// Namespace resurrect
// Params 1, eflags: 0x1 linked
// Checksum 0x7c758b5c, Offset: 0xcb0
// Size: 0x3c
function function_f668c085(player) {
    self endon(#"death");
    player waittill(#"hash_cbdf5176");
    self delete();
}

// Namespace resurrect
// Params 1, eflags: 0x1 linked
// Checksum 0x47e7833, Offset: 0xcf8
// Size: 0x44
function function_815c75f8(player) {
    self endon(#"death");
    player waittill(#"player_input_revive");
    wait 0.5;
    self delete();
}

// Namespace resurrect
// Params 2, eflags: 0x1 linked
// Checksum 0x4dfba0d8, Offset: 0xd48
// Size: 0xfc
function function_5adab2a0(slot, weapon) {
    if (isdefined(self.resurrect_not_allowed_by)) {
        return;
    }
    self startresurrectviewangletransition();
    self.lastwaterdamagetime = gettime();
    self._disable_proximity_alarms = 1;
    self thread function_56e9efb7();
    self util::show_hud(0);
    visionset_mgr::activate("visionset", "resurrect", self, 1.4, 4, 0.25);
    self clientfield::set_to_player("resurrect_state", 1);
    self shellshock("resurrect", 5.4, 0);
}

// Namespace resurrect
// Params 2, eflags: 0x1 linked
// Checksum 0x9b22978c, Offset: 0xe50
// Size: 0x14
function function_f00b1078(slot, weapon) {
    
}

// Namespace resurrect
// Params 2, eflags: 0x0
// Checksum 0x77d530be, Offset: 0xec8
// Size: 0x4c
function function_21432960(slot, weapon) {
    wait 0.1;
    self gadgetsetactivatetime(slot, gettime());
    self thread function_8a4ecd82(weapon);
}

// Namespace resurrect
// Params 2, eflags: 0x1 linked
// Checksum 0x7a8a4a47, Offset: 0xf20
// Size: 0x22
function function_c5460123(slot, weapon) {
    self notify(#"hash_c5460123");
}

// Namespace resurrect
// Params 1, eflags: 0x1 linked
// Checksum 0xfe444ccc, Offset: 0xf50
// Size: 0x46
function function_8a4ecd82(weapon) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self endon(#"death");
    self notify(#"hash_8a4ecd82");
    self endon(#"hash_8a4ecd82");
}

// Namespace resurrect
// Params 1, eflags: 0x1 linked
// Checksum 0x47b37b66, Offset: 0xfa0
// Size: 0x84
function overridespawn(ispredictedspawn) {
    if (!self flagsys::get("gadget_resurrect_ready")) {
        return false;
    }
    if (!self flagsys::get("gadget_resurrect_activated")) {
        return false;
    }
    if (!isdefined(self.resurrect_origin)) {
        self.resurrect_origin = self.origin;
        self.resurrect_angles = self.angles;
    }
    return true;
}

// Namespace resurrect
// Params 0, eflags: 0x0
// Checksum 0xfd6ac5a1, Offset: 0x1030
// Size: 0x30
function is_jumping() {
    ground_ent = self getgroundent();
    return !isdefined(ground_ent);
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x9bfea20f, Offset: 0x1068
// Size: 0x2e
function function_970fd49b() {
    if (self clientfield::get_to_player("out_of_bounds")) {
        return false;
    }
    return true;
}

// Namespace resurrect
// Params 1, eflags: 0x1 linked
// Checksum 0xbda7e0bb, Offset: 0x10a0
// Size: 0xa2
function function_e8ed3d71(slot) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self endon(#"hash_a3e5661a");
    self.var_60bfa141 = slot;
    while (true) {
        if (isalive(self) && self function_970fd49b()) {
            self.resurrect_origin = self.origin;
            self.resurrect_angles = self.angles;
        }
        wait 1;
    }
}

// Namespace resurrect
// Params 1, eflags: 0x0
// Checksum 0x59780211, Offset: 0x1150
// Size: 0x5c
function function_289e75a(time) {
    self endon(#"disconnect");
    self clientfield::set("resurrecting", 1);
    wait time;
    self clientfield::set("resurrecting", 0);
}

// Namespace resurrect
// Params 2, eflags: 0x1 linked
// Checksum 0x69b07d84, Offset: 0x11b8
// Size: 0x42
function function_648516ce(time, msg) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self endon(msg);
    wait time;
    self notify(msg);
}

// Namespace resurrect
// Params 1, eflags: 0x1 linked
// Checksum 0x1c7b62dc, Offset: 0x1208
// Size: 0x7c
function function_9a4b6cfa(msg) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self endon(msg);
    while (true) {
        if (self offhandspecialbuttonpressed()) {
            self flagsys::set("gadget_resurrect_activated");
            self notify(msg);
        }
        wait 0.05;
    }
}

// Namespace resurrect
// Params 2, eflags: 0x1 linked
// Checksum 0x657ead84, Offset: 0x1290
// Size: 0xb6
function function_858818cc(msg, time) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self endon(msg);
    if (!self util::is_bot()) {
        return;
    }
    time = int(time + 1);
    randwait = randomint(time);
    wait randwait;
    self flagsys::set("gadget_resurrect_activated");
    self notify(msg);
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0xe02286c8, Offset: 0x1350
// Size: 0xc4
function function_5d68587() {
    offset = (0, 0, 40);
    fxorg = spawn("script_model", self.resurrect_origin + offset);
    fxorg setmodel("tag_origin");
    fx = playfxontag("player/fx_plyr_revive", fxorg, "tag_origin");
    self waittill(#"resurrect_time_or_activate");
    fxorg delete();
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x4ab8b8b9, Offset: 0x1420
// Size: 0x7c
function function_3de8b43c() {
    if (isdefined(self.body)) {
        fx = playfx("player/fx_plyr_revive_demat", self.body.origin);
        self.body notsolid();
        self.body ghost();
    }
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0xa59962fc, Offset: 0x14a8
// Size: 0x50
function function_ffe831f5() {
    playsoundatposition("mpl_resurrect_npc", self.origin);
    fx = playfx("player/fx_plyr_rejack_light", self.origin);
}

// Namespace resurrect
// Params 2, eflags: 0x1 linked
// Checksum 0x58da8d16, Offset: 0x1500
// Size: 0x24c
function function_1be002d(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"game_ended");
    self waittill(#"death");
    var_d99f16e2 = 3;
    if (isdefined(weapon.var_4723d8cc)) {
        var_d99f16e2 = weapon.var_4723d8cc / 1000;
    }
    self.usedresurrect = 0;
    self flagsys::clear("gadget_resurrect_activated");
    self flagsys::set("gadget_resurrect_pending");
    self.var_bf70fb06 = gettime();
    self thread function_648516ce(var_d99f16e2, "resurrect_time_or_activate");
    self thread function_9a4b6cfa("resurrect_time_or_activate");
    self thread function_858818cc("resurrect_time_or_activate", var_d99f16e2);
    self thread function_5d68587();
    self waittill(#"resurrect_time_or_activate");
    self flagsys::clear("gadget_resurrect_pending");
    if (self flagsys::get("gadget_resurrect_activated")) {
        self thread function_3de8b43c();
        self notify(#"end_death_delay");
        self notify(#"end_killcam");
        self.cancelkillcam = 1;
        self.usedresurrect = 1;
        self notify(#"end_death_delay");
        self notify(#"force_spawn");
        if (!(isdefined(1) && 1)) {
            self.pers["resetMomentumOnSpawn"] = 0;
        }
        if (isdefined(level.playgadgetsuccess)) {
            self [[ level.playgadgetsuccess ]](weapon, "resurrectSuccessDelay");
        }
    }
}

// Namespace resurrect
// Params 0, eflags: 0x0
// Checksum 0x56ae792e, Offset: 0x1758
// Size: 0x2e
function function_3efdc53a() {
    if (self flagsys::get("gadget_resurrect_ready")) {
        return true;
    }
    return false;
}

// Namespace resurrect
// Params 0, eflags: 0x0
// Checksum 0x5df29cd7, Offset: 0x1790
// Size: 0x70
function function_f885c9d0() {
    var_3f4d2083 = 0;
    if (self.sessionstate == "playing" && isalive(self)) {
        var_3f4d2083 = 1;
    }
    if (self flagsys::get("gadget_resurrect_pending")) {
        return 1;
    }
    return var_3f4d2083;
}

// Namespace resurrect
// Params 0, eflags: 0x0
// Checksum 0x321fc7d4, Offset: 0x1808
// Size: 0xc6
function function_df4988d6() {
    if (self flagsys::get("gadget_resurrect_pending") && isdefined(self.var_bf70fb06)) {
        var_d99f16e2 = 3000;
        weapon = self.resurrect_weapon;
        if (isdefined(weapon.var_4723d8cc)) {
            var_d99f16e2 = weapon.var_4723d8cc;
        }
        time_left = var_d99f16e2 - gettime() - self.var_bf70fb06;
        if (time_left > 0) {
            return (time_left / 1000);
        }
    }
    return 0;
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x7f3ffe10, Offset: 0x18d8
// Size: 0xe4
function function_f3f47570() {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    self.var_2de01560 = 0;
    if (isdefined(level.resetplayerscorestreaks)) {
        [[ level.resetplayerscorestreaks ]](self);
    }
    self function_73f25579();
    self thread function_1efa08b4();
    self thread function_b6ec4f96();
    wait 1.4;
    self thread function_272118e1();
    self thread function_b53e6337();
    self thread function_56c2b39b();
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x83fea633, Offset: 0x19c8
// Size: 0x74
function function_91d24dda() {
    self notify(#"heroability_off");
    visionset_mgr::deactivate("visionset", "resurrect", self);
    self thread function_ecbc696f();
    self util::show_hud(1);
    player_suicide();
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x52a3ab80, Offset: 0x1a48
// Size: 0x150
function function_56c2b39b() {
    self endon(#"player_input_revive");
    self endon(#"hash_cbdf5176");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    a_killbrushes = getentarray("trigger_hurt", "classname");
    while (true) {
        a_killbrushes = getentarray("trigger_hurt", "classname");
        for (i = 0; i < a_killbrushes.size; i++) {
            if (self istouching(a_killbrushes[i])) {
                if (!a_killbrushes[i] istriggerenabled()) {
                    continue;
                }
                self function_91d24dda();
            }
        }
        if (self oob::istouchinganyoobtrigger()) {
            self function_91d24dda();
        }
        wait 0.05;
    }
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x14dffd70, Offset: 0x1ba0
// Size: 0x94
function function_b53e6337() {
    self endon(#"player_input_revive");
    self endon(#"hash_cbdf5176");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    wait 4;
    self playsound("mpl_rejack_suicide_timeout");
    self thread function_ab495fcb(-30);
    self function_91d24dda();
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x55e1536b, Offset: 0x1c40
// Size: 0xf4
function function_b6ec4f96() {
    self endon(#"player_input_revive");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    while (self usebuttonpressed()) {
        wait 1;
    }
    if (isdefined(self.laststand) && self.laststand) {
        starttime = gettime();
        while (true) {
            if (!self usebuttonpressed()) {
                starttime = gettime();
            }
            if (starttime + 500 < gettime()) {
                self function_91d24dda();
                self playsound("mpl_rejack_suicide");
                return;
            }
            wait 0.01;
        }
    }
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0xbd00a791, Offset: 0x1d40
// Size: 0x6e
function function_d42040d0() {
    weapons = self getweaponslistprimaries();
    for (i = 0; i < weapons.size; i++) {
        self reloadweaponammo(weapons[i]);
    }
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x6d975005, Offset: 0x1db8
// Size: 0xa8
function function_1efa08b4() {
    self endon(#"hash_cbdf5176");
    self endon(#"player_input_revive");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    while (self offhandspecialbuttonpressed()) {
        wait 0.05;
    }
    self.var_2de01560 = 0;
    while (!self.var_2de01560) {
        if (self offhandspecialbuttonpressed()) {
            self.var_2de01560 = 1;
        }
        wait 0.05;
    }
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x63e5f954, Offset: 0x1e68
// Size: 0x1b4
function function_272118e1() {
    self endon(#"hash_cbdf5176");
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    if (isdefined(self.laststand) && self.laststand) {
        while (true) {
            wait 0.05;
            if (isdefined(self.var_2de01560) && self.var_2de01560) {
                self notify(#"player_input_revive");
                if (isdefined(level.start_player_health_regen)) {
                    self thread [[ level.start_player_health_regen ]]();
                }
                self._disable_proximity_alarms = 0;
                self thread function_ffe831f5();
                self thread function_ab495fcb();
                self thread function_f3809de8();
                visionset_mgr::deactivate("visionset", "resurrect", self);
                visionset_mgr::activate("visionset", "resurrect_up", self, 0.35, 0.1, 0.2);
                self clientfield::set_to_player("resurrect_state", 2);
                self stopshellshock();
                self function_d42040d0();
                level notify(#"hero_gadget_activated", self);
                self notify(#"hero_gadget_activated");
                return;
            }
        }
    }
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0xdb866984, Offset: 0x2028
// Size: 0x84
function function_73f25579() {
    self clientfield::set_player_uimodel("hudItems.rejack.activationWindowEntered", 1);
    self luinotifyevent(%create_rejack_timer, 1, gettime() + int(4000));
    self clientfield::set_player_uimodel("hudItems.rejack.rejackActivated", 0);
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0xeb13bbe8, Offset: 0x20b8
// Size: 0x4c
function function_ecbc696f() {
    self endon(#"disconnect");
    wait 1.5;
    self clientfield::set_player_uimodel("hudItems.rejack.activationWindowEntered", 0);
    self util::show_hud(1);
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x5eac87a, Offset: 0x2110
// Size: 0x3c
function function_f3809de8() {
    self clientfield::set_player_uimodel("hudItems.rejack.rejackActivated", 1);
    self thread function_ecbc696f();
}

// Namespace resurrect
// Params 0, eflags: 0x1 linked
// Checksum 0x4628cc1e, Offset: 0x2158
// Size: 0x54
function player_suicide() {
    self._disable_proximity_alarms = 0;
    self notify(#"hash_cbdf5176");
    self clientfield::set_to_player("resurrect_state", 0);
    self thread function_ab495fcb(-30);
}

