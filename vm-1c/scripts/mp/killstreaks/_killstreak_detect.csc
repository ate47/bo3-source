#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace killstreak_detect;

// Namespace killstreak_detect
// Params 0, eflags: 0x2
// Checksum 0x9399d7a7, Offset: 0x238
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("killstreak_detect", &__init__, undefined, undefined);
}

// Namespace killstreak_detect
// Params 0, eflags: 0x1 linked
// Checksum 0x439a64af, Offset: 0x278
// Size: 0x210
function __init__() {
    callback::on_localplayer_spawned(&watch_killstreak_detect_perks_changed);
    clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int", &enemyscriptmovervehicle_changed, 0, 0);
    clientfield::register("vehicle", "enemyvehicle", 1, 2, "int", &enemyvehicle_changed, 0, 1);
    clientfield::register("helicopter", "enemyvehicle", 1, 2, "int", &enemyvehicle_changed, 0, 1);
    clientfield::register("missile", "enemyvehicle", 1, 2, "int", &enemymissilevehicle_changed, 0, 1);
    clientfield::register("actor", "enemyvehicle", 1, 2, "int", &enemyvehicle_changed, 0, 1);
    clientfield::register("vehicle", "vehicletransition", 1, 1, "int", &vehicle_transition, 0, 1);
    if (!isdefined(level.enemyvehicles)) {
        level.enemyvehicles = [];
    }
    if (!isdefined(level.enemymissiles)) {
        level.enemymissiles = [];
    }
    level.emp_killstreaks = [];
}

// Namespace killstreak_detect
// Params 7, eflags: 0x1 linked
// Checksum 0x713c9791, Offset: 0x490
// Size: 0xf4
function vehicle_transition(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(local_client_num);
    friend = self util::function_f36b8920(local_client_num, 1);
    if (friend && isdefined(player) && player duplicate_render::show_friendly_outlines(local_client_num)) {
        var_67b7c527 = !self islocalclientdriver(local_client_num);
        self duplicate_render::function_48e05b4a(local_client_num, var_67b7c527);
    }
}

// Namespace killstreak_detect
// Params 1, eflags: 0x1 linked
// Checksum 0x6c2e1d8a, Offset: 0x590
// Size: 0x82
function should_set_compass_icon(local_client_num) {
    local_player = getlocalplayer(local_client_num);
    return local_player.team === self.team || isdefined(local_player) && isdefined(self.team) && local_player hasperk(local_client_num, "specialty_showenemyvehicles");
}

// Namespace killstreak_detect
// Params 7, eflags: 0x1 linked
// Checksum 0x3b007b4f, Offset: 0x620
// Size: 0xdc
function enemyscriptmovervehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.scriptmovercompassicons) && isdefined(self.model)) {
        if (isdefined(level.scriptmovercompassicons[self.model])) {
            if (self should_set_compass_icon(local_client_num)) {
                self setcompassicon(level.scriptmovercompassicons[self.model]);
            }
        }
    }
    enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace killstreak_detect
// Params 7, eflags: 0x1 linked
// Checksum 0x306f4fbf, Offset: 0x708
// Size: 0xdc
function enemymissilevehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.missilecompassicons) && isdefined(self.weapon)) {
        if (isdefined(level.missilecompassicons[self.weapon])) {
            if (self should_set_compass_icon(local_client_num)) {
                self setcompassicon(level.missilecompassicons[self.weapon]);
            }
        }
    }
    enemymissile_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace killstreak_detect
// Params 7, eflags: 0x1 linked
// Checksum 0x9bf6c4c1, Offset: 0x7f0
// Size: 0x9c
function enemymissile_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self updateteammissiles(local_client_num, newval);
    self util::add_remove_list(level.enemymissiles, newval);
    self updateenemymissiles(local_client_num, newval);
}

// Namespace killstreak_detect
// Params 7, eflags: 0x1 linked
// Checksum 0x61cac5f8, Offset: 0x898
// Size: 0x13a
function enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self updateteamvehicles(local_client_num, newval);
    self util::add_remove_list(level.enemyvehicles, newval);
    self updateenemyvehicles(local_client_num, newval);
    if (isdefined(self.model) && self.model == "wpn_t7_turret_emp_core" && self.type === "vehicle") {
        if (!isdefined(level.emp_killstreaks)) {
            level.emp_killstreaks = [];
        } else if (!isarray(level.emp_killstreaks)) {
            level.emp_killstreaks = array(level.emp_killstreaks);
        }
        level.emp_killstreaks[level.emp_killstreaks.size] = self;
    }
}

// Namespace killstreak_detect
// Params 2, eflags: 0x1 linked
// Checksum 0x673337b3, Offset: 0x9e0
// Size: 0x2c
function updateteamvehicles(local_client_num, newval) {
    self checkteamvehicles(local_client_num);
}

// Namespace killstreak_detect
// Params 2, eflags: 0x1 linked
// Checksum 0x66c0d436, Offset: 0xa18
// Size: 0x2c
function updateteammissiles(local_client_num, newval) {
    self checkteammissiles(local_client_num);
}

// Namespace killstreak_detect
// Params 2, eflags: 0x1 linked
// Checksum 0xa339ddf, Offset: 0xa50
// Size: 0x27c
function updateenemyvehicles(local_client_num, newval) {
    if (!isdefined(self)) {
        return;
    }
    watcher = getlocalplayer(local_client_num);
    friend = self util::function_f36b8920(local_client_num, 1);
    self duplicate_render::set_dr_flag("enemyvehicle_fb", !friend);
    self duplicate_render::function_a28d1a5f(local_client_num, 0);
    self duplicate_render::function_48e05b4a(local_client_num, 0);
    self.var_2c088b81 = 0;
    if (!friend && isdefined(watcher) && watcher hasperk(local_client_num, "specialty_showenemyvehicles")) {
        if (!isdefined(self.isbreachingfirewall) || self.isbreachingfirewall == 0) {
            self duplicate_render::function_a28d1a5f(local_client_num, newval);
        }
        self.var_2c088b81 = 1;
        self duplicate_render::function_48e05b4a(local_client_num, 0);
    } else if (friend === 1 && isdefined(watcher) && watcher duplicate_render::show_friendly_outlines(local_client_num)) {
        driver = self.type === "vehicle" && self islocalclientdriver(local_client_num);
        var_67b7c527 = newval === 1 || driver === 0 && newval === 2;
        self duplicate_render::function_48e05b4a(local_client_num, var_67b7c527);
    } else {
        self duplicate_render::function_48e05b4a(local_client_num, 0);
    }
    if (newval == 2) {
        self.var_fd5d0997 = 1;
    }
    self duplicate_render::update_dr_filters(local_client_num);
}

// Namespace killstreak_detect
// Params 2, eflags: 0x1 linked
// Checksum 0x3c89a699, Offset: 0xcd8
// Size: 0x23c
function updateenemymissiles(local_client_num, newval) {
    if (!isdefined(self)) {
        return;
    }
    watcher = getlocalplayer(local_client_num);
    friend = self util::function_f36b8920(local_client_num, 1);
    self duplicate_render::set_dr_flag("enemyvehicle_fb", !friend);
    self duplicate_render::function_5ceb14b2(local_client_num, 0);
    self duplicate_render::function_4e2867e3(local_client_num, 0);
    self.var_2c088b81 = 0;
    if (!friend && isdefined(watcher) && watcher hasperk(local_client_num, "specialty_showenemyvehicles")) {
        if (!isdefined(self.isbreachingfirewall) || self.isbreachingfirewall == 0) {
            self duplicate_render::function_5ceb14b2(local_client_num, newval);
        }
        self.var_2c088b81 = 1;
        self duplicate_render::function_4e2867e3(local_client_num, 0);
    } else if (friend === 1 && isdefined(watcher) && watcher duplicate_render::show_friendly_outlines(local_client_num)) {
        var_67b7c527 = newval === 1 || newval === 2;
        self duplicate_render::function_4e2867e3(local_client_num, var_67b7c527);
    } else {
        self duplicate_render::function_4e2867e3(local_client_num, 0);
    }
    if (newval == 2) {
        self.var_fd5d0997 = 1;
    }
    self duplicate_render::update_dr_filters(local_client_num);
}

// Namespace killstreak_detect
// Params 1, eflags: 0x1 linked
// Checksum 0x24a3f887, Offset: 0xf20
// Size: 0x11c
function watch_killstreak_detect_perks_changed(local_client_num) {
    if (self != getlocalplayer(local_client_num)) {
        return;
    }
    self notify(#"watch_killstreak_detect_perks_changed");
    self endon(#"watch_killstreak_detect_perks_changed");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    while (isdefined(self)) {
        wait 0.016;
        util::clean_deleted(level.enemyvehicles);
        util::clean_deleted(level.enemymissiles);
        array::thread_all(level.enemyvehicles, &updateenemyvehicles, local_client_num, 1);
        array::thread_all(level.enemymissiles, &updateenemymissiles, local_client_num, 1);
        self waittill(#"perks_changed");
    }
}

// Namespace killstreak_detect
// Params 1, eflags: 0x1 linked
// Checksum 0x69629629, Offset: 0x1048
// Size: 0x152
function checkteamvehicles(localclientnum) {
    if (!isdefined(self.owner) || !isdefined(self.owner.team)) {
        return;
    }
    if (!isdefined(self.vehicleoldteam)) {
        self.vehicleoldteam = self.team;
    }
    if (!isdefined(self.vehicleoldownerteam)) {
        self.vehicleoldownerteam = self.owner.team;
    }
    watcher = getlocalplayer(localclientnum);
    if (!isdefined(self.vehicleoldwatcherteam)) {
        self.vehicleoldwatcherteam = watcher.team;
    }
    if (self.vehicleoldteam != self.team || self.vehicleoldownerteam != self.owner.team || self.vehicleoldwatcherteam != watcher.team) {
        self.vehicleoldteam = self.team;
        self.vehicleoldownerteam = self.owner.team;
        self.vehicleoldwatcherteam = watcher.team;
        self notify(#"team_changed");
    }
}

// Namespace killstreak_detect
// Params 1, eflags: 0x1 linked
// Checksum 0x6864e80a, Offset: 0x11a8
// Size: 0x152
function checkteammissiles(localclientnum) {
    if (!isdefined(self.owner) || !isdefined(self.owner.team)) {
        return;
    }
    if (!isdefined(self.missileoldteam)) {
        self.missileoldteam = self.team;
    }
    if (!isdefined(self.missileoldownerteam)) {
        self.missileoldownerteam = self.owner.team;
    }
    watcher = getlocalplayer(localclientnum);
    if (!isdefined(self.missileoldwatcherteam)) {
        self.missileoldwatcherteam = watcher.team;
    }
    if (self.missileoldteam != self.team || self.missileoldownerteam != self.owner.team || self.missileoldwatcherteam != watcher.team) {
        self.missileoldteam = self.team;
        self.missileoldownerteam = self.owner.team;
        self.missileoldwatcherteam = watcher.team;
        self notify(#"team_changed");
    }
}

