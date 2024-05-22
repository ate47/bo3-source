#using scripts/mp/killstreaks/_turret;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_ai_tank;
#using scripts/mp/_util;
#using scripts/mp/killstreaks/_qrdrone;
#using scripts/shared/lui_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace remote_weapons;

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0xb0bfa67f, Offset: 0x318
// Size: 0x44
function init() {
    level.remoteweapons = [];
    level.remoteexithint = %MP_REMOTE_EXIT;
    callback::on_spawned(&on_player_spawned);
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0xebd83e5e, Offset: 0x368
// Size: 0x24
function on_player_spawned() {
    self endon(#"disconnect");
    self assignremotecontroltrigger();
}

// Namespace remote_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x9264ce6f, Offset: 0x398
// Size: 0x44
function removeandassignnewremotecontroltrigger(remotecontroltrigger) {
    arrayremovevalue(self.activeremotecontroltriggers, remotecontroltrigger);
    self assignremotecontroltrigger(1);
}

// Namespace remote_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x6d99665c, Offset: 0x3e8
// Size: 0xdc
function assignremotecontroltrigger(force_new_assignment) {
    if (!isdefined(force_new_assignment)) {
        force_new_assignment = 0;
    }
    if (!isdefined(self.activeremotecontroltriggers)) {
        self.activeremotecontroltriggers = [];
    }
    arrayremovevalue(self.activeremotecontroltriggers, undefined);
    if ((!isdefined(self.remotecontroltrigger) || force_new_assignment) && self.activeremotecontroltriggers.size > 0) {
        self.remotecontroltrigger = self.activeremotecontroltriggers[self.activeremotecontroltriggers.size - 1];
    }
    if (isdefined(self.remotecontroltrigger)) {
        self.remotecontroltrigger.origin = self.origin;
        self.remotecontroltrigger linkto(self);
    }
}

// Namespace remote_weapons
// Params 5, eflags: 0x1 linked
// Checksum 0x7250c605, Offset: 0x4d0
// Size: 0xf4
function registerremoteweapon(weaponname, hintstring, usecallback, endusecallback, hidecompassonuse) {
    if (!isdefined(hidecompassonuse)) {
        hidecompassonuse = 1;
    }
    /#
        assert(isdefined(level.remoteweapons));
    #/
    level.remoteweapons[weaponname] = spawnstruct();
    level.remoteweapons[weaponname].hintstring = hintstring;
    level.remoteweapons[weaponname].usecallback = usecallback;
    level.remoteweapons[weaponname].endusecallback = endusecallback;
    level.remoteweapons[weaponname].hidecompassonuse = hidecompassonuse;
}

// Namespace remote_weapons
// Params 5, eflags: 0x1 linked
// Checksum 0x962f1b83, Offset: 0x5d0
// Size: 0x144
function useremoteweapon(weapon, weaponname, immediate, allowmanualdeactivation, always_allow_ride) {
    if (!isdefined(allowmanualdeactivation)) {
        allowmanualdeactivation = 1;
    }
    if (!isdefined(always_allow_ride)) {
        always_allow_ride = 0;
    }
    player = self;
    /#
        assert(isplayer(player));
    #/
    weapon.remoteowner = player;
    weapon.inittime = gettime();
    weapon.remotename = weaponname;
    weapon.remoteweaponallowmanualdeactivation = allowmanualdeactivation;
    weapon thread watchremoveremotecontrolledweapon();
    if (!immediate) {
        weapon createremoteweapontrigger();
        return;
    }
    weapon thread watchownerdisconnect();
    weapon useremotecontrolweapon(allowmanualdeactivation, always_allow_ride);
}

// Namespace remote_weapons
// Params 0, eflags: 0x0
// Checksum 0xa76db73, Offset: 0x720
// Size: 0x90
function watchforhack() {
    weapon = self;
    weapon endon(#"death");
    hacker = weapon waittill(#"killstreak_hacked");
    if (isdefined(weapon.remoteweaponallowmanualdeactivation) && weapon.remoteweaponallowmanualdeactivation == 1) {
        weapon thread watchremotecontroldeactivate();
    }
    weapon.remoteowner = hacker;
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x7f50a7b1, Offset: 0x7b8
// Size: 0x74
function watchremoveremotecontrolledweapon() {
    weapon = self;
    weapon endon(#"remote_weapon_end");
    weapon util::waittill_any("death", "remote_weapon_shutdown");
    weapon endremotecontrolweaponuse(0);
    while (isdefined(weapon)) {
        wait(0.05);
    }
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x7b67be61, Offset: 0x838
// Size: 0x294
function createremoteweapontrigger() {
    weapon = self;
    player = weapon.remoteowner;
    if (isdefined(weapon.usetrigger)) {
        weapon.usetrigger delete();
    }
    weapon.usetrigger = spawn("trigger_radius_use", player.origin, 32, 32);
    weapon.usetrigger enablelinkto();
    weapon.usetrigger linkto(player);
    weapon.usetrigger sethintlowpriority(1);
    weapon.usetrigger setcursorhint("HINT_NOICON");
    weapon.usetrigger sethintstring(level.remoteweapons[weapon.remotename].hintstring);
    weapon.usetrigger setteamfortrigger(player.team);
    weapon.usetrigger.team = player.team;
    player clientclaimtrigger(weapon.usetrigger);
    player.remotecontroltrigger = weapon.usetrigger;
    player.activeremotecontroltriggers[player.activeremotecontroltriggers.size] = weapon.usetrigger;
    weapon.usetrigger.claimedby = player;
    weapon thread watchweapondeath();
    weapon thread watchownerdisconnect();
    weapon thread watchremotetriggeruse();
    weapon thread watchremotetriggerdisable();
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x924caf56, Offset: 0xad8
// Size: 0xac
function watchweapondeath() {
    weapon = self;
    weapon.usetrigger endon(#"death");
    weapon util::waittill_any("death", "remote_weapon_end");
    if (isdefined(weapon.remoteowner)) {
        weapon.remoteowner removeandassignnewremotecontroltrigger(weapon.usetrigger);
    }
    weapon.usetrigger delete();
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x17a8fa7d, Offset: 0xb90
// Size: 0xdc
function watchownerdisconnect() {
    weapon = self;
    weapon endon(#"remote_weapon_end");
    weapon endon(#"remote_weapon_shutdown");
    if (isdefined(weapon.usetrigger)) {
        weapon.usetrigger endon(#"death");
    }
    weapon.remoteowner util::waittill_any("joined_team", "disconnect", "joined_spectators");
    endremotecontrolweaponuse(0);
    if (isdefined(weapon) && isdefined(weapon.usetrigger)) {
        weapon.usetrigger delete();
    }
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x90d39203, Offset: 0xc78
// Size: 0x98
function watchremotetriggerdisable() {
    weapon = self;
    weapon endon(#"remote_weapon_end");
    weapon endon(#"remote_weapon_shutdown");
    weapon.usetrigger endon(#"death");
    while (true) {
        weapon.usetrigger triggerenable(!weapon.remoteowner iswallrunning());
        wait(0.1);
    }
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x69c1ec1b, Offset: 0xd18
// Size: 0xca
function allowremotestart() {
    player = self;
    if (player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() && !player util::isusingremote() && !(isdefined(player.carryobject.disallowremotecontrol) && isdefined(player.carryobject) && player.carryobject.disallowremotecontrol)) {
        return 1;
    }
    return 0;
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x58085e4f, Offset: 0xdf0
// Size: 0x170
function watchremotetriggeruse() {
    weapon = self;
    weapon endon(#"death");
    weapon endon(#"remote_weapon_end");
    if (weapon.remoteowner util::is_bot()) {
        return;
    }
    while (true) {
        player = weapon.usetrigger waittill(#"trigger");
        if (weapon.remoteowner isusingoffhand() || weapon.remoteowner iswallrunning()) {
            continue;
        }
        if (isdefined(weapon.hackertrigger) && isdefined(weapon.hackertrigger.progressbar)) {
            if (weapon.remotename == "killstreak_remote_turret") {
                weapon.remoteowner iprintlnbold(%KILLSTREAK_AUTO_TURRET_NOT_AVAILABLE);
            }
            continue;
        }
        if (weapon.remoteowner allowremotestart()) {
            useremotecontrolweapon();
        }
    }
}

// Namespace remote_weapons
// Params 2, eflags: 0x1 linked
// Checksum 0xbc3f0515, Offset: 0xf68
// Size: 0x42c
function useremotecontrolweapon(allowmanualdeactivation, always_allow_ride) {
    if (!isdefined(allowmanualdeactivation)) {
        allowmanualdeactivation = 1;
    }
    if (!isdefined(always_allow_ride)) {
        always_allow_ride = 0;
    }
    self endon(#"death");
    weapon = self;
    /#
        assert(isdefined(weapon.remoteowner));
    #/
    weapon.control_initiated = 1;
    weapon.endremotecontrolweapon = 0;
    weapon.remoteowner endon(#"disconnect");
    weapon.remoteowner endon(#"joined_team");
    weapon.remoteowner disableoffhandweapons();
    weapon.remoteowner disableweaponcycling();
    weapon.remoteowner.dofutz = 0;
    if (!isdefined(weapon.disableremoteweaponswitch)) {
        remoteweapon = getweapon("killstreak_remote");
        weapon.remoteowner giveweapon(remoteweapon);
        weapon.remoteowner switchtoweapon(remoteweapon);
        if (always_allow_ride) {
            weapon.remoteowner util::waittill_any("weapon_change", "death");
        } else {
            newweapon = weapon.remoteowner waittill(#"weapon_change");
        }
    }
    if (isdefined(newweapon)) {
        if (newweapon != remoteweapon) {
            weapon.remoteowner killstreaks::clear_using_remote(1, 1);
            return;
        }
    }
    weapon.remoteowner thread killstreaks::watch_for_remove_remote_weapon();
    weapon.remoteowner util::setusingremote(weapon.remotename);
    weapon.remoteowner util::freeze_player_controls(1);
    result = weapon.remoteowner killstreaks::init_ride_killstreak(weapon.remotename, always_allow_ride);
    if (result != "success") {
        if (result != "disconnect") {
            weapon.remoteowner killstreaks::clear_using_remote();
            weapon thread resetcontrolinitiateduponownerrespawn();
        }
    } else {
        weapon.controlled = 1;
        weapon.killcament = self;
        weapon notify(#"remote_start");
        if (allowmanualdeactivation) {
            weapon thread watchremotecontroldeactivate();
        }
        weapon.remoteowner thread [[ level.remoteweapons[weapon.remotename].usecallback ]](weapon);
        if (level.remoteweapons[weapon.remotename].hidecompassonuse) {
            weapon.remoteowner killstreaks::hide_compass();
        }
    }
    weapon.remoteowner util::freeze_player_controls(0);
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x5225467c, Offset: 0x13a0
// Size: 0x2c
function resetcontrolinitiateduponownerrespawn() {
    self endon(#"death");
    self.remoteowner waittill(#"spawned");
    self.control_initiated = 0;
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x1f652251, Offset: 0x13d8
// Size: 0xf0
function watchremotecontroldeactivate() {
    self notify(#"watchremotecontroldeactivate_remoteweapons");
    self endon(#"watchremotecontroldeactivate_remoteweapons");
    weapon = self;
    weapon endon(#"remote_weapon_end");
    weapon endon(#"death");
    weapon.remoteowner endon(#"disconnect");
    while (true) {
        timeused = 0;
        while (weapon.remoteowner usebuttonpressed()) {
            timeused += 0.05;
            if (timeused > 0.25) {
                weapon thread endremotecontrolweaponuse(1);
                return;
            }
            wait(0.05);
        }
        wait(0.05);
    }
}

// Namespace remote_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xbe4fada8, Offset: 0x14d0
// Size: 0x4f0
function endremotecontrolweaponuse(exitrequestedbyowner) {
    weapon = self;
    if (isdefined(weapon.endremotecontrolweapon) && (!isdefined(weapon) || weapon.endremotecontrolweapon)) {
        return;
    }
    weapon.endremotecontrolweapon = 1;
    remote_controlled = isdefined(weapon.controlled) && (isdefined(weapon.control_initiated) && weapon.control_initiated || weapon.controlled);
    while (isdefined(weapon) && weapon.forcewaitremotecontrol === 1 && remote_controlled == 0) {
        remote_controlled = isdefined(weapon.controlled) && (isdefined(weapon.control_initiated) && weapon.control_initiated || weapon.controlled);
        wait(0.05);
    }
    if (!isdefined(weapon)) {
        return;
    }
    if (isdefined(weapon.remoteowner) && remote_controlled) {
        if (isdefined(weapon.remoteweaponshutdowndelay)) {
            wait(weapon.remoteweaponshutdowndelay);
        }
        player = weapon.remoteowner;
        if (player.dofutz === 1) {
            player clientfield::set_to_player("static_postfx", 1);
            wait(1);
            if (isdefined(player)) {
                player clientfield::set_to_player("static_postfx", 0);
                player.dofutz = 0;
            }
        } else if (!exitrequestedbyowner && weapon.watch_remote_weapon_death === 1 && !isalive(weapon)) {
            wait(isdefined(weapon.watch_remote_weapon_death_duration) ? weapon.watch_remote_weapon_death_duration : 1);
        }
        if (isdefined(player)) {
            player thread fadetoblackandbackin();
            player waittill(#"fade2black");
            if (remote_controlled) {
                player unlink();
            }
            player killstreaks::clear_using_remote(1);
            cleared_killstreak_delay = 1;
            player enableusability();
        }
    }
    if (isdefined(weapon) && isdefined(weapon.remotename)) {
        self [[ level.remoteweapons[weapon.remotename].endusecallback ]](weapon, exitrequestedbyowner);
    }
    if (isdefined(weapon)) {
        weapon.killcament = weapon;
        if (isdefined(weapon.remoteowner)) {
            if (remote_controlled) {
                weapon.remoteowner unlink();
                if (!(isdefined(cleared_killstreak_delay) && cleared_killstreak_delay)) {
                    weapon.remoteowner killstreaks::reset_killstreak_delay_killcam();
                }
                weapon.remoteowner util::clientnotify("nofutz");
            }
            if (isdefined(level.gameended) && level.gameended) {
                weapon.remoteowner util::freeze_player_controls(1);
            }
        }
    }
    if (isdefined(weapon)) {
        weapon.control_initiated = 0;
        weapon.controlled = 0;
        if (isdefined(weapon.remoteowner)) {
            weapon.remoteowner killstreaks::unhide_compass();
        }
        if (isdefined(weapon.one_remote_use) && (!exitrequestedbyowner || weapon.one_remote_use)) {
            weapon notify(#"remote_weapon_end");
        }
    }
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x6a0fd362, Offset: 0x19c8
// Size: 0x6c
function fadetoblackandbackin() {
    self endon(#"disconnect");
    lui::screen_fade_out(0.1);
    self qrdrone::destroyhud();
    wait(0.05);
    self notify(#"fade2black");
    lui::screen_fade_in(0.2);
}

// Namespace remote_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0x6b5bd34d, Offset: 0x1a40
// Size: 0xc8
function stunstaticfx(duration) {
    self endon(#"remove_remote_weapon");
    self.var_f04f433.alpha = 0.65;
    wait(duration - 0.5);
    time = duration - 0.5;
    while (time < duration) {
        wait(0.05);
        time += 0.05;
        self.var_f04f433.alpha -= 0.05;
    }
    self.var_f04f433.alpha = 0.15;
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0x90ce73b7, Offset: 0x1b10
// Size: 0x84
function destroyremotehud() {
    self useservervisionset(0);
    self setinfraredvision(0);
    if (isdefined(self.var_f04f433)) {
        self.var_f04f433 destroy();
    }
    if (isdefined(self.var_b8714ea8)) {
        self.var_b8714ea8 destroy();
    }
}

// Namespace remote_weapons
// Params 1, eflags: 0x1 linked
// Checksum 0xf83e9e70, Offset: 0x1ba0
// Size: 0x84
function set_static(val) {
    owner = self.owner;
    if (isdefined(owner) && owner.usingvehicle && isdefined(owner.viewlockedentity) && owner.viewlockedentity == self) {
        owner clientfield::set_to_player("static_postfx", val);
    }
}

// Namespace remote_weapons
// Params 0, eflags: 0x1 linked
// Checksum 0xb05e264c, Offset: 0x1c30
// Size: 0x52
function do_static_fx() {
    self endon(#"death");
    self set_static(1);
    wait(2);
    self set_static(0);
    self notify(#"static_fx_done");
}

