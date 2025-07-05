#using scripts/codescripts/struct;
#using scripts/shared/_burnplayer;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_traps;
#using scripts/zm/_zm_utility;

#namespace zm_trap_fire;

// Namespace zm_trap_fire
// Params 0, eflags: 0x2
// Checksum 0x73a57475, Offset: 0x3a0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_trap_fire", &__init__, undefined, undefined);
}

// Namespace zm_trap_fire
// Params 0, eflags: 0x0
// Checksum 0xe77b709a, Offset: 0x3e0
// Size: 0x142
function __init__() {
    zm_traps::register_trap_basic_info("fire", &trap_activate_fire, &trap_audio);
    zm_traps::register_trap_damage("fire", &player_damage, &damage);
    a_traps = struct::get_array("trap_fire", "targetname");
    foreach (trap in a_traps) {
        clientfield::register("world", trap.script_noteworthy, 21000, 1, "int");
    }
}

// Namespace zm_trap_fire
// Params 0, eflags: 0x0
// Checksum 0xa53739e1, Offset: 0x530
// Size: 0x174
function trap_activate_fire() {
    self._trap_duration = 40;
    self._trap_cooldown_time = 60;
    if (isdefined(level.sndtrapfunc)) {
        level thread [[ level.sndtrapfunc ]](self, 1);
    }
    self notify(#"trap_activate");
    level notify(#"trap_activate", self);
    level clientfield::set(self.target, 1);
    fx_points = struct::get_array(self.target, "targetname");
    for (i = 0; i < fx_points.size; i++) {
        util::wait_network_frame();
        fx_points[i] thread trap_audio(self);
    }
    self thread zm_traps::trap_damage();
    self util::waittill_notify_or_timeout("trap_deactivate", self._trap_duration);
    self notify(#"trap_done");
    level clientfield::set(self.target, 0);
}

// Namespace zm_trap_fire
// Params 1, eflags: 0x0
// Checksum 0x4e86aa87, Offset: 0x6b0
// Size: 0x144
function trap_audio(trap) {
    sound_origin = spawn("script_origin", self.origin);
    sound_origin playsound("wpn_zmb_inlevel_fire_trap_start");
    sound_origin playloopsound("wpn_zmb_inlevel_fire_trap_loop");
    self thread function_c5d41372(trap);
    trap util::waittill_any_timeout(trap._trap_duration, "trap_done");
    if (isdefined(sound_origin)) {
        playsoundatposition("wpn_zmb_inlevel_fire_trap_stop", sound_origin.origin);
        sound_origin stoploopsound();
        wait 0.05;
        playsoundatposition("zmb_fire_trap_cooldown", sound_origin.origin);
        sound_origin delete();
    }
}

// Namespace zm_trap_fire
// Params 1, eflags: 0x0
// Checksum 0xeaaaa180, Offset: 0x800
// Size: 0x68
function function_c5d41372(trap) {
    trap endon(#"trap_done");
    while (true) {
        wait randomfloatrange(0.1, 0.5);
        playsoundatposition("amb_flame", self.origin);
    }
}

// Namespace zm_trap_fire
// Params 0, eflags: 0x0
// Checksum 0x3d78484b, Offset: 0x870
// Size: 0x1a6
function player_damage() {
    self endon(#"death");
    self endon(#"disconnect");
    if (!(isdefined(self.is_burning) && self.is_burning) && !self laststand::player_is_in_laststand()) {
        self.is_burning = 1;
        if (isdefined(level.trap_fire_visionset_registered) && level.trap_fire_visionset_registered) {
            visionset_mgr::activate("overlay", "zm_trap_burn", self, 1.25, 1.25);
        } else {
            self burnplayer::setplayerburning(1.25, 0.05, 0);
        }
        self notify(#"burned");
        if (!self hasperk("specialty_armorvest") || self.health - 100 < 1) {
            radiusdamage(self.origin, 10, self.health + 100, self.health + 100);
            self.is_burning = undefined;
            return;
        }
        self dodamage(50, self.origin);
        wait 0.1;
        self playsound("zmb_ignite");
        self.is_burning = undefined;
    }
}

// Namespace zm_trap_fire
// Params 1, eflags: 0x0
// Checksum 0x8b1a9103, Offset: 0xa20
// Size: 0x2a4
function damage(trap) {
    self endon(#"death");
    n_param = randomint(100);
    self.marked_for_death = 1;
    if (isdefined(self.animname) && self.animname != "zombie_dog") {
        if (n_param > 90 && level.burning_zombies.size < 6) {
            level.burning_zombies[level.burning_zombies.size] = self;
            self thread zm_traps::zombie_flame_watch();
            self playsound("zmb_ignite");
            self thread zombie_death::flame_death_fx();
            playfxontag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
            wait randomfloat(1.25);
        } else {
            refs[0] = "guts";
            refs[1] = "right_arm";
            refs[2] = "left_arm";
            refs[3] = "right_leg";
            refs[4] = "left_leg";
            refs[5] = "no_legs";
            refs[6] = "head";
            self.a.gib_ref = refs[randomint(refs.size)];
            playsoundatposition("zmb_ignite", self.origin);
            wait randomfloat(1.25);
            self playsound("zmb_vocals_zombie_death_fire");
        }
    }
    if (isdefined(self.var_3925c480)) {
        self [[ self.var_3925c480 ]](trap);
        return;
    }
    level notify(#"trap_kill", self, trap);
    self dodamage(self.health + 666, self.origin, trap);
}

