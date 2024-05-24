#using scripts/shared/music_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace audio;

// Namespace audio
// Params 0, eflags: 0x2
// Checksum 0x4be1c835, Offset: 0x2a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("audio", &__init__, undefined, undefined);
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x41388fbe, Offset: 0x2e0
// Size: 0xec
function __init__() {
    callback::on_spawned(&sndresetsoundsettings);
    callback::on_spawned(&function_fe1c918a);
    callback::on_spawned(&function_dbe63d5d);
    callback::on_player_killed(&on_player_killed);
    callback::on_vehicle_spawned(&vehiclespawncontext);
    level thread register_clientfields();
    level thread sndchyronwatcher();
    level thread function_9c83d0d4();
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0xdb621717, Offset: 0x3d8
// Size: 0x214
function register_clientfields() {
    clientfield::register("world", "sndMatchSnapshot", 1, 2, "int");
    clientfield::register("world", "sndFoleyContext", 1, 1, "int");
    clientfield::register("scriptmover", "sndRattle", 1, 1, "int");
    clientfield::register("toplayer", "sndMelee", 1, 1, "int");
    clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int");
    clientfield::register("toplayer", "sndCCHacking", 1, 2, "int");
    clientfield::register("toplayer", "sndTacRig", 1, 1, "int");
    clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int");
    clientfield::register("world", "sndIGCsnapshot", 1, 4, "int");
    clientfield::register("world", "sndChyronLoop", 1, 1, "int");
    clientfield::register("world", "sndZMBFadeIn", 1, 1, "int");
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x2aa593fa, Offset: 0x5f8
// Size: 0x5c
function sndchyronwatcher() {
    level waittill(#"chyron_menu_open");
    level clientfield::set("sndChyronLoop", 1);
    level waittill(#"chyron_menu_closed");
    level clientfield::set("sndChyronLoop", 0);
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x9624ec8b, Offset: 0x660
// Size: 0x38
function function_9c83d0d4() {
    while (true) {
        level waittill(#"hash_cdfdddaf");
        music::setmusicstate("death");
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0xde1b5159, Offset: 0x6a0
// Size: 0x44
function sndresetsoundsettings() {
    self clientfield::set_to_player("sndMelee", 0);
    self util::clientnotify("sndDEDe");
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x8f4bb61e, Offset: 0x6f0
// Size: 0x34
function on_player_killed() {
    if (!(isdefined(self.killcam) && self.killcam)) {
        self util::clientnotify("sndDED");
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x53079a11, Offset: 0x730
// Size: 0x24
function vehiclespawncontext() {
    self clientfield::set("sndSwitchVehicleContext", 1);
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x9b5d4e34, Offset: 0x760
// Size: 0x84
function sndupdatevehiclecontext(added) {
    if (!isdefined(self.sndoccupants)) {
        self.sndoccupants = 0;
    }
    if (added) {
        self.sndoccupants++;
    } else {
        self.sndoccupants--;
        if (self.sndoccupants < 0) {
            self.sndoccupants = 0;
        }
    }
    self clientfield::set("sndSwitchVehicleContext", self.sndoccupants + 1);
}

// Namespace audio
// Params 2, eflags: 0x1 linked
// Checksum 0x6c7fccf5, Offset: 0x7f0
// Size: 0xaa
function playtargetmissilesound(alias, looping) {
    self notify(#"stop_target_missile_sound");
    self endon(#"stop_target_missile_sound");
    self endon(#"disconnect");
    self endon(#"death");
    if (isdefined(alias)) {
        time = soundgetplaybacktime(alias) * 0.001;
        if (time > 0) {
            do {
                self playlocalsound(alias);
                wait(time);
            } while (looping);
        }
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0xac6d5bd3, Offset: 0x8a8
// Size: 0x12e
function function_fe1c918a() {
    self endon(#"death");
    self endon(#"disconnect");
    if (!self flag::exists("playing_stinger_fired_at_me")) {
        self flag::init("playing_stinger_fired_at_me", 0);
    } else {
        self flag::clear("playing_stinger_fired_at_me");
    }
    while (true) {
        attacker, weapon = self waittill(#"missile_lock");
        if (!flag::get("playing_stinger_fired_at_me")) {
            self thread playtargetmissilesound(weapon.lockontargetlockedsound, weapon.lockontargetlockedsoundloops);
            self util::waittill_any("stinger_fired_at_me", "missile_unlocked", "death");
            self notify(#"stop_target_missile_sound");
        }
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0xd9fcb40f, Offset: 0x9e0
// Size: 0xf8
function function_dbe63d5d() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        missile, weapon, attacker = self waittill(#"stinger_fired_at_me");
        waittillframeend();
        self flag::set("playing_stinger_fired_at_me");
        self thread playtargetmissilesound(weapon.lockontargetfiredonsound, weapon.lockontargetfiredonsoundloops);
        missile util::waittill_any("projectile_impact_explode", "death");
        self notify(#"stop_target_missile_sound");
        self flag::clear("playing_stinger_fired_at_me");
    }
}

// Namespace audio
// Params 2, eflags: 0x1 linked
// Checksum 0xee899bb9, Offset: 0xae0
// Size: 0xfc
function unlockfrontendmusic(unlockname, allplayers) {
    if (!isdefined(allplayers)) {
        allplayers = 1;
    }
    if (isdefined(allplayers) && allplayers) {
        if (isdefined(level.players) && level.players.size > 0) {
            foreach (player in level.players) {
                player unlocksongbyalias(unlockname);
            }
        }
        return;
    }
    self unlocksongbyalias(unlockname);
}

