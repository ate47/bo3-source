#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/killstreaks/_ai_tank;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_qrdrone;
#using scripts/mp/killstreaks/_turret;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/util_shared;

#namespace remote_weapons;

// Namespace remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x271c65fe, Offset: 0x318
// Size: 0x3a
function init() {
    level.remoteweapons = [];
    level.remoteexithint = %MP_REMOTE_EXIT;
    callback::on_spawned(&on_player_spawned);
}

// Namespace remote_weapons
// Params 0, eflags: 0x0
// Checksum 0xab03da4d, Offset: 0x360
// Size: 0x1a
function on_player_spawned() {
    self endon(#"disconnect");
    self assignremotecontroltrigger();
}

// Namespace remote_weapons
// Params 1, eflags: 0x0
// Checksum 0x1340697d, Offset: 0x388
// Size: 0x32
function removeandassignnewremotecontroltrigger(remotecontroltrigger) {
    arrayremovevalue(self.activeremotecontroltriggers, remotecontroltrigger);
    self assignremotecontroltrigger(1);
}

// Namespace remote_weapons
// Params 1, eflags: 0x0
// Checksum 0xe4c572fe, Offset: 0x3c8
// Size: 0xba
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
// Params 5, eflags: 0x0
// Checksum 0x6942efa4, Offset: 0x490
// Size: 0xba
function registerremoteweapon(weaponname, hintstring, usecallback, endusecallback, hidecompassonuse) {
    if (!isdefined(hidecompassonuse)) {
        hidecompassonuse = 1;
    }
    assert(isdefined(level.remoteweapons));
    level.remoteweapons[weaponname] = spawnstruct();
    level.remoteweapons[weaponname].hintstring = hintstring;
    level.remoteweapons[weaponname].usecallback = usecallback;
    level.remoteweapons[weaponname].endusecallback = endusecallback;
    level.remoteweapons[weaponname].hidecompassonuse = hidecompassonuse;
}

// Namespace remote_weapons
// Params 5, eflags: 0x0
// Checksum 0x99031e55, Offset: 0x558
// Size: 0xfa
function useremoteweapon(weapon, weaponname, immediate, allowmanualdeactivation, always_allow_ride) {
    if (!isdefined(allowmanualdeactivation)) {
        allowmanualdeactivation = 1;
    }
    if (!isdefined(always_allow_ride)) {
        always_allow_ride = 0;
    }
    player = self;
    assert(isplayer(player));
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
// Checksum 0xfdadb5a8, Offset: 0x660
// Size: 0x66
function watchforhack() {
    weapon = self;
    weapon endon(#"death");
    weapon waittill(#"killstreak_hacked", hacker);
    if (isdefined(weapon.remoteweaponallowmanualdeactivation) && weapon.remoteweaponallowmanualdeactivation == 1) {
        weapon thread watchremotecontroldeactivate();
    }
    weapon.remoteowner = hacker;
}

// Namespace remote_weapons
// Params 0, eflags: 0x0
// Checksum 0xfbfaa7cf, Offset: 0x6d0
// Size: 0x5d
function watchremoveremotecontrolledweapon() {
    weapon = self;
    weapon endon(#"remote_weapon_end");
    weapon util::waittill_any("death", "remote_weapon_shutdown");
    weapon endremotecontrolweaponuse(0);
    while (isdefined(weapon)) {
        wait 0.05;
    }
}

// Namespace remote_weapons
// Params 0, eflags: 0x0
// Checksum 0xef963bc9, Offset: 0x738
// Size: 0x1f2
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
// Params 0, eflags: 0x0
// Checksum 0xb9b096a1, Offset: 0x938
// Size: 0x82
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
// Params 0, eflags: 0x0
// Checksum 0x93bdc13b, Offset: 0x9c8
// Size: 0xaa
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
// Params 0, eflags: 0x0
// Checksum 0xaebe7ee0, Offset: 0xa80
// Size: 0x6d
function watchremotetriggerdisable() {
    weapon = self;
    weapon endon(#"remote_weapon_end");
    weapon endon(#"remote_weapon_shutdown");
    weapon.usetrigger endon(#"death");
    while (true) {
        weapon.usetrigger triggerenable(!weapon.remoteowner iswallrunning());
        wait 0.1;
    }
}

// Namespace remote_weapons
// Params 0, eflags: 0x0
// Checksum 0xb4ae74e2, Offset: 0xaf8
// Size: 0x99
function allowremotestart() {
    player = self;
    if (player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() && !player util::isusingremote() && !(isdefined(player.carryobject.disallowremotecontrol) && isdefined(player.carryobject) && player.carryobject.disallowremotecontrol)) {
        return 1;
    }
    return 0;
}

// Namespace remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x661e0c92, Offset: 0xba0
// Size: 0x125
function watchremotetriggeruse() {
    weapon = self;
    weapon endon(#"death");
    weapon endon(#"remote_weapon_end");
    if (weapon.remoteowner util::is_bot()) {
        return;
    }
    while (true) {
        weapon.usetrigger waittill(#"trigger", player);
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
// Params 2, eflags: 0x0
// Checksum 0xba20ddc0, Offset: 0xcd0
// Size: 0x312
function useremotecontrolweapon(allowmanualdeactivation, always_allow_ride) {
    if (!isdefined(allowmanualdeactivation)) {
        allowmanualdeactivation = 1;
    }
    if (!isdefined(always_allow_ride)) {
        always_allow_ride = 0;
    }
    self endon(#"death");
    weapon = self;
    assert(isdefined(weapon.remoteowner));
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
            weapon.remoteowner waittill(#"weapon_change", newweapon);
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
// Params 0, eflags: 0x0
// Checksum 0x2e0865a5, Offset: 0xff0
// Size: 0xb1
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
            wait 0.05;
        }
        wait 0.05;
    }
}

// Namespace remote_weapons
// Params 1, eflags: 0x0
// Checksum 0x87e6bdb3, Offset: 0x10b0
// Size: 0x2fc
function endremotecontrolweaponuse(exitrequestedbyowner) {
    weapon = self;
    if (isdefined(weapon.endremotecontrolweapon) && (!isdefined(weapon) || weapon.endremotecontrolweapon)) {
        return;
    }
    weapon.endremotecontrolweapon = 1;
    remote_controlled = isdefined(weapon.controlled) && (isdefined(weapon.control_initiated) && weapon.control_initiated || weapon.controlled);
    if (isdefined(weapon.remoteowner) && remote_controlled) {
        if (isdefined(weapon.remoteweaponshutdowndelay)) {
            wait weapon.remoteweaponshutdowndelay;
        }
        player = weapon.remoteowner;
        if (player.dofutz === 1) {
            player clientfield::set_to_player("static_postfx", 1);
            wait 1;
            if (isdefined(player)) {
                player clientfield::set_to_player("static_postfx", 0);
                player.dofutz = 0;
            }
        } else if (!exitrequestedbyowner && weapon.watch_remote_weapon_death === 1 && !isalive(weapon)) {
            wait isdefined(weapon.watch_remote_weapon_death_duration) ? weapon.watch_remote_weapon_death_duration : 1;
        }
        if (isdefined(player)) {
            player thread fadetoblack();
            player waittill(#"fade2black");
            if (remote_controlled) {
                player unlink();
            }
            player killstreaks::clear_using_remote(1);
            player enableusability();
        }
    }
    if (isdefined(weapon)) {
        self [[ level.remoteweapons[weapon.remotename].endusecallback ]](weapon, exitrequestedbyowner);
    }
    if (isdefined(weapon)) {
        weapon.killcament = weapon;
        if (isdefined(weapon.remoteowner)) {
            if (remote_controlled) {
                weapon.remoteowner unlink();
                weapon.remoteowner killstreaks::reset_killstreak_delay_killcam();
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
// Params 0, eflags: 0x0
// Checksum 0x23db5ef8, Offset: 0x13b8
// Size: 0x5b
function fadetoblack() {
    self endon(#"disconnect");
    lui::screen_fade_out(0.1);
    self qrdrone::destroyhud();
    wait 0.05;
    lui::screen_fade_in(0.2);
    self notify(#"fade2black");
}

// Namespace remote_weapons
// Params 1, eflags: 0x0
// Checksum 0x1fed28bc, Offset: 0x1420
// Size: 0xaa
function stunstaticfx(duration) {
    self endon(#"remove_remote_weapon");
    self.var_f04f433.alpha = 0.65;
    wait duration - 0.5;
    time = duration - 0.5;
    while (time < duration) {
        wait 0.05;
        time += 0.05;
        self.var_f04f433.alpha -= 0.05;
    }
    self.var_f04f433.alpha = 0.15;
}

// Namespace remote_weapons
// Params 0, eflags: 0x0
// Checksum 0xb3916052, Offset: 0x14d8
// Size: 0x62
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
// Params 1, eflags: 0x0
// Checksum 0xb519f4a, Offset: 0x1548
// Size: 0x62
function set_static(val) {
    owner = self.owner;
    if (isdefined(owner) && owner.usingvehicle && isdefined(owner.viewlockedentity) && owner.viewlockedentity == self) {
        owner clientfield::set_to_player("static_postfx", val);
    }
}

// Namespace remote_weapons
// Params 0, eflags: 0x0
// Checksum 0x82f86144, Offset: 0x15b8
// Size: 0x3b
function do_static_fx() {
    self endon(#"death");
    self set_static(1);
    wait 2;
    self set_static(0);
    self notify(#"static_fx_done");
}

