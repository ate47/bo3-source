#using scripts/shared/abilities/gadgets/_gadget_camo;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_7b9f2aa5;

// Namespace namespace_7b9f2aa5
// Params 0, eflags: 0x2
// namespace_7b9f2aa5<file_0>::function_2dc19561
// Checksum 0xae6a0676, Offset: 0x330
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_vision_pulse", &__init__, undefined, undefined);
}

// Namespace namespace_7b9f2aa5
// Params 0, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_8c87d8eb
// Checksum 0xf61282e1, Offset: 0x370
// Size: 0x18c
function __init__() {
    ability_player::register_gadget_activation_callbacks(6, &gadget_vision_pulse_on, &gadget_vision_pulse_off);
    ability_player::register_gadget_possession_callbacks(6, &function_97e4169e, &function_bfa5bd70);
    ability_player::register_gadget_flicker_callbacks(6, &gadget_vision_pulse_on_flicker);
    ability_player::register_gadget_is_inuse_callbacks(6, &gadget_vision_pulse_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(6, &gadget_vision_pulse_is_flickering);
    callback::on_connect(&function_e8ada75);
    callback::on_spawned(&gadget_vision_pulse_on_spawn);
    clientfield::register("toplayer", "vision_pulse_active", 1, 1, "int");
    if (!isdefined(level.vsmgr_prio_visionset_visionpulse)) {
        level.vsmgr_prio_visionset_visionpulse = 61;
    }
    visionset_mgr::register_info("visionset", "vision_pulse", 1, level.vsmgr_prio_visionset_visionpulse, 12, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
}

// Namespace namespace_7b9f2aa5
// Params 1, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_53d8d98a
// Checksum 0x7d450a1c, Offset: 0x508
// Size: 0x2a
function gadget_vision_pulse_is_inuse(slot) {
    return self flagsys::get("gadget_vision_pulse_on");
}

// Namespace namespace_7b9f2aa5
// Params 1, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_32706c24
// Checksum 0xad0be0e1, Offset: 0x540
// Size: 0x22
function gadget_vision_pulse_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_7b9f2aa5
// Params 2, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_fa0dde53
// Checksum 0xc7215618, Offset: 0x570
// Size: 0x34
function gadget_vision_pulse_on_flicker(slot, weapon) {
    self thread gadget_vision_pulse_flicker(slot, weapon);
}

// Namespace namespace_7b9f2aa5
// Params 2, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_97e4169e
// Checksum 0x9806817f, Offset: 0x5b0
// Size: 0x14
function function_97e4169e(slot, weapon) {
    
}

// Namespace namespace_7b9f2aa5
// Params 2, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_bfa5bd70
// Checksum 0xc012e195, Offset: 0x5d0
// Size: 0x14
function function_bfa5bd70(slot, weapon) {
    
}

// Namespace namespace_7b9f2aa5
// Params 0, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_e8ada75
// Checksum 0x99ec1590, Offset: 0x5f0
// Size: 0x4
function function_e8ada75() {
    
}

// Namespace namespace_7b9f2aa5
// Params 0, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_bbb240d2
// Checksum 0x2bac4722, Offset: 0x600
// Size: 0x54
function gadget_vision_pulse_on_spawn() {
    self.visionpulseactivatetime = 0;
    self.visionpulsearray = [];
    self.visionpulseorigin = undefined;
    self.visionpulseoriginarray = [];
    if (isdefined(self._pulse_ent)) {
        self._pulse_ent delete();
    }
}

// Namespace namespace_7b9f2aa5
// Params 0, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_aed643ac
// Checksum 0xbd564a9c, Offset: 0x660
// Size: 0x2c
function gadget_vision_pulse_ramp_hold_func() {
    self util::waittill_any_timeout(5, "ramp_out_visionset");
}

// Namespace namespace_7b9f2aa5
// Params 0, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_85f13c1
// Checksum 0x8444d48, Offset: 0x698
// Size: 0x84
function gadget_vision_pulse_watch_death() {
    self notify(#"vision_pulse_watch_death");
    self endon(#"vision_pulse_watch_death");
    self endon(#"disconnect");
    self waittill(#"death");
    visionset_mgr::deactivate("visionset", "vision_pulse", self);
    if (isdefined(self._pulse_ent)) {
        self._pulse_ent delete();
    }
}

// Namespace namespace_7b9f2aa5
// Params 0, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_79cbe2b9
// Checksum 0x22298a1b, Offset: 0x728
// Size: 0xb4
function gadget_vision_pulse_watch_emp() {
    self notify(#"vision_pulse_watch_emp");
    self endon(#"vision_pulse_watch_emp");
    self endon(#"disconnect");
    while (true) {
        if (self isempjammed()) {
            visionset_mgr::deactivate("visionset", "vision_pulse", self);
            self notify(#"emp_vp_jammed");
            break;
        }
        wait(0.05);
    }
    if (isdefined(self._pulse_ent)) {
        self._pulse_ent delete();
    }
}

// Namespace namespace_7b9f2aa5
// Params 2, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_4b54ef0a
// Checksum 0xc768c0d7, Offset: 0x7e8
// Size: 0xec
function gadget_vision_pulse_on(slot, weapon) {
    if (isdefined(self._pulse_ent)) {
        return;
    }
    self flagsys::set("gadget_vision_pulse_on");
    self thread gadget_vision_pulse_start(slot, weapon);
    visionset_mgr::activate("visionset", "vision_pulse", self, 0.25, &gadget_vision_pulse_ramp_hold_func, 0.75);
    self thread gadget_vision_pulse_watch_death();
    self thread gadget_vision_pulse_watch_emp();
    self clientfield::set_to_player("vision_pulse_active", 1);
}

// Namespace namespace_7b9f2aa5
// Params 2, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_8481ec90
// Checksum 0xd588acc0, Offset: 0x8e0
// Size: 0x54
function gadget_vision_pulse_off(slot, weapon) {
    self flagsys::clear("gadget_vision_pulse_on");
    self clientfield::set_to_player("vision_pulse_active", 0);
}

// Namespace namespace_7b9f2aa5
// Params 2, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_637bf313
// Checksum 0xaa4e3154, Offset: 0x940
// Size: 0x37c
function gadget_vision_pulse_start(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"emp_vp_jammed");
    wait(0.1);
    if (isdefined(self._pulse_ent)) {
        return;
    }
    self._pulse_ent = spawn("script_model", self.origin);
    self._pulse_ent setmodel("tag_origin");
    self gadgetsetentity(slot, self._pulse_ent);
    self gadgetsetactivatetime(slot, gettime());
    self set_gadget_vision_pulse_status("Activated");
    self.visionpulseactivatetime = gettime();
    enemyarray = level.players;
    gadget = getweapon("gadget_vision_pulse");
    visionpulsearray = arraysort(enemyarray, self._pulse_ent.origin, 1, undefined, gadget.gadget_pulse_max_range);
    self.visionpulseorigin = self._pulse_ent.origin;
    self.visionpulsearray = [];
    self.visionpulseoriginarray = [];
    spottedenemy = 0;
    self.visionpulsespottedenemy = [];
    self.visionpulsespottedenemytime = gettime();
    for (i = 0; i < visionpulsearray.size; i++) {
        if (visionpulsearray[i] namespace_411f3e3f::function_6b246a0f() == 0) {
            self.visionpulsearray[self.visionpulsearray.size] = visionpulsearray[i];
            self.visionpulseoriginarray[self.visionpulseoriginarray.size] = visionpulsearray[i].origin;
            if (isalive(visionpulsearray[i]) && visionpulsearray[i].team != self.team) {
                spottedenemy = 1;
                self.visionpulsespottedenemy[self.visionpulsespottedenemy.size] = visionpulsearray[i];
            }
        }
    }
    self wait_until_is_done(slot, self._gadgets_player[slot].gadget_pulse_duration);
    if (spottedenemy && isdefined(level.playgadgetsuccess)) {
        self [[ level.playgadgetsuccess ]](weapon);
    } else {
        self playsoundtoplayer("gdt_vision_pulse_no_hits", self);
        self notify(#"ramp_out_visionset");
    }
    self set_gadget_vision_pulse_status("Done");
    self._pulse_ent delete();
}

// Namespace namespace_7b9f2aa5
// Params 2, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_493f0e81
// Checksum 0x3832dac6, Offset: 0xcc8
// Size: 0x5e
function wait_until_is_done(slot, timepulse) {
    starttime = gettime();
    while (true) {
        wait(0.25);
        currenttime = gettime();
        if (currenttime > starttime + timepulse) {
            return;
        }
    }
}

// Namespace namespace_7b9f2aa5
// Params 2, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_bb685fe3
// Checksum 0x4e5fe86b, Offset: 0xd30
// Size: 0xec
function gadget_vision_pulse_flicker(slot, weapon) {
    self endon(#"disconnect");
    time = gettime();
    if (!self gadget_vision_pulse_is_inuse(slot)) {
        return;
    }
    eventtime = self._gadgets_player[slot].gadget_flickertime;
    self set_gadget_vision_pulse_status("^1" + "Flickering.", eventtime);
    while (true) {
        if (!self gadgetflickering(slot)) {
            set_gadget_vision_pulse_status("^2" + "Normal");
            return;
        }
        wait(0.25);
    }
}

// Namespace namespace_7b9f2aa5
// Params 2, eflags: 0x1 linked
// namespace_7b9f2aa5<file_0>::function_2780e408
// Checksum 0xd4c6c904, Offset: 0xe28
// Size: 0x9c
function set_gadget_vision_pulse_status(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Vision Pulse:" + status + timestr);
    }
}

