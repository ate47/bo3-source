#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace killstreak_detect;

// Namespace killstreak_detect
// Params 0, eflags: 0x2
// Checksum 0xde3fd204, Offset: 0x278
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("killstreak_detect", &__init__, undefined, undefined);
}

// Namespace killstreak_detect
// Params 0, eflags: 0x0
// Checksum 0x44137dd3, Offset: 0x2b0
// Size: 0x18e
function __init__() {
    /#
        callback::on_spawned(&watch_killstreak_detect_perks_changed);
    #/
    clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int", &enemyscriptmovervehicle_changed, 0, 0);
    clientfield::register("vehicle", "enemyvehicle", 1, 2, "int", &enemyvehicle_changed, 0, 1);
    clientfield::register("helicopter", "enemyvehicle", 1, 2, "int", &enemyvehicle_changed, 0, 1);
    clientfield::register("missile", "enemyvehicle", 1, 2, "int", &enemymissilevehicle_changed, 0, 1);
    clientfield::register("actor", "enemyvehicle", 1, 2, "int", &enemyvehicle_changed, 0, 1);
    clientfield::register("vehicle", "vehicletransition", 1, 1, "int", &vehicle_transition, 0, 1);
    if (!isdefined(level.enemyvehicles)) {
        level.enemyvehicles = [];
    }
    level.emp_killstreaks = [];
}

// Namespace killstreak_detect
// Params 7, eflags: 0x0
// Checksum 0x99a02782, Offset: 0x448
// Size: 0xca
function vehicle_transition(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(local_client_num);
    friend = self util::function_f36b8920(local_client_num, 1);
    if (friend && isdefined(player) && player duplicate_render::show_friendly_outlines(local_client_num)) {
        var_67b7c527 = !self islocalclientdriver(local_client_num);
        self duplicate_render::function_48e05b4a(local_client_num, var_67b7c527);
    }
}

// Namespace killstreak_detect
// Params 7, eflags: 0x0
// Checksum 0x83341c46, Offset: 0x520
// Size: 0xa2
function enemyscriptmovervehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.scriptmovercompassicons) && isdefined(self.model)) {
        if (isdefined(level.scriptmovercompassicons[self.model])) {
            self setcompassicon(level.scriptmovercompassicons[self.model]);
        }
    }
    enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace killstreak_detect
// Params 7, eflags: 0x0
// Checksum 0xf2128e7a, Offset: 0x5d0
// Size: 0xa2
function enemymissilevehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.missilecompassicons) && isdefined(self.weapon)) {
        if (isdefined(level.missilecompassicons[self.weapon])) {
            self setcompassicon(level.missilecompassicons[self.weapon]);
        }
    }
    enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace killstreak_detect
// Params 7, eflags: 0x0
// Checksum 0x2fb2356, Offset: 0x680
// Size: 0x113
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
// Params 2, eflags: 0x0
// Checksum 0xd6b433bf, Offset: 0x7a0
// Size: 0x22
function updateteamvehicles(local_client_num, newval) {
    self checkteamvehicles(local_client_num);
}

// Namespace killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0xf4b3ada0, Offset: 0x7d0
// Size: 0x1d2
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

/#

    // Namespace killstreak_detect
    // Params 1, eflags: 0x0
    // Checksum 0xa74b6e1c, Offset: 0x9b0
    // Size: 0x8f
    function watch_killstreak_detect_perks_changed(local_client_num) {
        self notify(#"watch_killstreak_detect_perks_changed");
        self endon(#"watch_killstreak_detect_perks_changed");
        self endon(#"death");
        self endon(#"disconnect");
        self endon(#"entityshutdown");
        while (isdefined(self)) {
            wait 0.016;
            util::clean_deleted(level.enemyvehicles);
            array::thread_all(level.enemyvehicles, &updateenemyvehicles, local_client_num, 1);
            self waittill(#"perks_changed");
        }
    }

#/

// Namespace killstreak_detect
// Params 1, eflags: 0x0
// Checksum 0x93ee44b8, Offset: 0xa48
// Size: 0x127
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
// Params 1, eflags: 0x0
// Checksum 0x1b461ade, Offset: 0xb78
// Size: 0x82
function function_65f12311(localclientnum) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    wait 0.05;
    fx_handle = self thread playflarefx(localclientnum);
    self thread function_732c7da5(localclientnum, fx_handle);
    self thread function_1627c9b0(localclientnum, fx_handle);
    self thread function_1c7e6819();
}

// Namespace killstreak_detect
// Params 1, eflags: 0x0
// Checksum 0xd1237878, Offset: 0xc08
// Size: 0x6e
function playflarefx(localclientnum) {
    self endon(#"entityshutdown");
    level endon(#"player_switch");
    if (!isdefined(self.var_ea55169f)) {
        self.var_ea55169f = "tag_origin";
    }
    fx_handle = playfxontag(localclientnum, level._effect["powerLight"], self, self.var_ea55169f);
    return fx_handle;
}

// Namespace killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0x220f5157, Offset: 0xc80
// Size: 0x8a
function function_732c7da5(localclientnum, fxhandle) {
    msg = self util::waittill_any_return("entityshutdown", "team_changed", "player_switch");
    if (isdefined(fxhandle)) {
        stopfx(localclientnum, fxhandle);
    }
    waittillframeend();
    if (msg != "entityshutdown" && isdefined(self)) {
        self thread function_65f12311(localclientnum);
    }
}

// Namespace killstreak_detect
// Params 1, eflags: 0x0
// Checksum 0xad3a94f3, Offset: 0xd18
// Size: 0xa
function function_1c7e6819(local_client_num) {
    
}

// Namespace killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0x6d7a07cc, Offset: 0xd30
// Size: 0x93
function function_1627c9b0(localclientnum, fxhandle) {
    self endon(#"entityshutdown");
    self notify(#"team_changed_watcher");
    self endon(#"team_changed_watcher");
    watcherplayer = getlocalplayer(localclientnum);
    while (true) {
        level waittill(#"team_changed", clientnum);
        player = getlocalplayer(clientnum);
        if (watcherplayer == player) {
            self notify(#"team_changed");
        }
    }
}

