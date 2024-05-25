#using scripts/zm/zm_cosmodrome_amb;
#using scripts/zm/_zm_traps;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_860ef124;

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0xcddb22db, Offset: 0x480
// Size: 0x4c
function init_traps() {
    level thread function_86339996();
    level thread function_e0d31800();
    level thread function_395fdbce();
}

// Namespace namespace_860ef124
// Params 2, eflags: 0x1 linked
// Checksum 0x5deffd6b, Offset: 0x4d8
// Size: 0x8e
function function_b16a68c0(arm, var_916d086e) {
    var_2fd4bb2f = getentarray(var_916d086e, "targetname");
    for (i = 0; i < var_2fd4bb2f.size; i++) {
        var_2fd4bb2f[i] linkto(arm);
    }
}

// Namespace namespace_860ef124
// Params 2, eflags: 0x1 linked
// Checksum 0x8c47cced, Offset: 0x570
// Size: 0x86
function function_3b7290e2(arm, var_916d086e) {
    var_2fd4bb2f = getentarray(var_916d086e, "targetname");
    for (i = 0; i < var_2fd4bb2f.size; i++) {
        var_2fd4bb2f[i] unlink();
    }
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0x620caddf, Offset: 0x600
// Size: 0x4c4
function function_86339996() {
    level flag::wait_till("start_zombie_round_logic");
    wait(1);
    var_1c8831d1 = struct::get("claw_l_retract", "targetname");
    var_30aae38f = struct::get("claw_r_retract", "targetname");
    var_3d6a412c = struct::get("claw_l_extend", "targetname");
    var_21791fa2 = struct::get("claw_r_extend", "targetname");
    level.var_eebefbf0 = var_1c8831d1.origin;
    level.var_c234410e = var_30aae38f.origin;
    level.var_ab813bf9 = var_3d6a412c.origin;
    level.var_56499fb7 = var_21791fa2.origin;
    level.var_82af40b9 = getent("claw_arm_l", "targetname");
    level.var_36aa4be7 = getent("claw_arm_r", "targetname");
    level.var_9701c946 = getent("claw_l_arm", "targetname");
    function_b16a68c0(level.var_9701c946, "claw_l");
    level.var_82df1788 = getent("claw_r_arm", "targetname");
    function_b16a68c0(level.var_82df1788, "claw_r");
    level.rocket = getent("zombie_rocket", "targetname");
    var_547ac401 = getentarray(level.rocket.target, "targetname");
    for (i = 0; i < var_547ac401.size; i++) {
        var_547ac401[i] setforcenocull();
        var_547ac401[i] linkto(level.rocket);
    }
    level.var_ee72aac2 = getent("lifter_body", "targetname");
    var_326829bb = getentarray(level.var_ee72aac2.target, "targetname");
    for (i = 0; i < var_326829bb.size; i++) {
        var_326829bb[i] linkto(level.var_ee72aac2);
    }
    level.var_3bc3f8d1 = getent("lifter_arm", "targetname");
    level.var_413d861 = getentarray("lifter_clamp", "targetname");
    for (i = 0; i < level.var_413d861.size; i++) {
        level.var_413d861[i] linkto(level.var_3bc3f8d1);
    }
    level.rocket linkto(level.var_3bc3f8d1);
    level.var_3bc3f8d1 linkto(level.var_ee72aac2);
    level.var_be9553f1 = getent("rocket_debris", "script_noteworthy");
    level.var_be9553f1 hide();
    level thread function_6588791f();
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0xfc356a73, Offset: 0xad0
// Size: 0x244
function function_6588791f() {
    var_6ecbf6aa = struct::get("rail_start_spot", "targetname");
    var_15ebca1f = struct::get("rail_dock_spot", "targetname");
    level.var_82df1788 moveto(level.var_c234410e, 0.05);
    level.var_9701c946 moveto(level.var_eebefbf0, 0.05);
    level.var_ee72aac2 moveto(var_6ecbf6aa.origin, 0.05);
    level.var_ee72aac2 waittill(#"movedone");
    level.var_3bc3f8d1 unlink();
    level.var_3bc3f8d1 rotateto((13, 0, 0), 0.05);
    level.var_3bc3f8d1 waittill(#"rotatedone");
    function_b5bedb73();
    level waittill(#"power_on");
    wait(5);
    function_3015c292();
    level.var_3bc3f8d1 linkto(level.var_ee72aac2);
    level.var_ee72aac2 moveto(var_15ebca1f.origin, 10, 3, 3);
    level.var_ee72aac2 playsound("evt_rocket_roll");
    level.var_ee72aac2 waittill(#"movedone");
    level.var_3bc3f8d1 unlink();
    function_7ce1fc24();
    function_b5bedb73();
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0x535bbd8, Offset: 0xd20
// Size: 0x122
function function_7ce1fc24() {
    level thread function_d1419acd();
    level.var_3bc3f8d1 rotateto((90, 0, 0), 15, 3, 5);
    wait(16);
    level.rocket unlink();
    level.rocket movez(-20, 3);
    level.var_82df1788 playsound("evt_rocket_claw_arm");
    level.var_82df1788 moveto(level.var_56499fb7, 3);
    level.var_9701c946 moveto(level.var_ab813bf9, 3);
    level thread namespace_9dd378ec::function_3cf7b8c9("vox_ann_rocket_anim");
    wait(3);
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0xcd16d319, Offset: 0xe50
// Size: 0x16c
function function_eee1cbd0() {
    var_6ecbf6aa = struct::get("rail_start_spot", "targetname");
    level.var_3bc3f8d1 linkto(level.var_ee72aac2);
    offset = level.var_3bc3f8d1.origin - level.var_ee72aac2.origin;
    level.var_3bc3f8d1 unlink();
    level.var_3bc3f8d1 rotateto((0, 0, 0), 15);
    level.var_3bc3f8d1 moveto(var_6ecbf6aa.origin + offset, 15, 3, 3);
    level.var_ee72aac2 moveto(var_6ecbf6aa.origin, 15, 3, 3);
    wait(15);
    function_3b7290e2(level.var_9701c946, "claw_l");
    function_3b7290e2(level.var_82df1788, "claw_r");
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0x94096748, Offset: 0xfc8
// Size: 0x24c
function function_e0d31800() {
    var_3ad29684 = getent("trigger_centrifuge_damage", "targetname");
    var_abde0fe3 = getent("rotating_trap_group1", "targetname");
    var_3ad29684 enablelinkto();
    var_3ad29684 linkto(var_abde0fe3);
    var_6c0c6027 = getent("rotating_trap_collision", "targetname");
    assert(isdefined(var_6c0c6027.target), "claw_l_arm");
    var_6c0c6027 linkto(getent(var_6c0c6027.target, "targetname"));
    var_8aa1e590 = getentarray("origin_centrifuge_spinning_sound", "targetname");
    array::thread_all(var_8aa1e590, &function_e0b3d0ff);
    level flag::wait_till("start_zombie_round_logic");
    var_abde0fe3 clientfield::set("COSMO_CENTRIFUGE_LIGHTS", 1);
    wait(4);
    var_abde0fe3 rotateyaw(720, 10, 0, 4.5);
    var_abde0fe3 waittill(#"rotatedone");
    var_abde0fe3 playsound("zmb_cent_end");
    var_abde0fe3 clientfield::set("COSMO_CENTRIFUGE_LIGHTS", 0);
    level thread function_6226d8bf();
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x0
// Checksum 0xeb963764, Offset: 0x1220
// Size: 0x44a
function function_40732131() {
    self._trap_duration = 30;
    self._trap_cooldown_time = 60;
    /#
        if (getdvarint("claw_l_arm") >= 1) {
            self._trap_cooldown_time = 5;
        }
    #/
    centrifuge = self._trap_movers[0];
    old_angles = centrifuge.angles;
    self thread zm_traps::trig_update(centrifuge);
    for (i = 0; i < self._trap_movers.size; i++) {
        self._trap_movers[i] rotateyaw(360, 5, 4.5);
    }
    wait(2);
    self thread function_ff0615a5();
    wait(3);
    self playloopsound("zmb_cent_mach_loop", 0.6);
    step = 3;
    for (t = 0; t < self._trap_duration; t += step) {
        for (i = 0; i < self._trap_movers.size; i++) {
            self._trap_movers[i] rotateyaw(360, step);
        }
        wait(step);
    }
    end_angle = randomint(360);
    var_6218f4fd = int(centrifuge.angles[1]) % 360;
    if (end_angle < var_6218f4fd) {
        end_angle += 360;
    }
    degrees = end_angle - var_6218f4fd;
    if (degrees > 0) {
        time = degrees / 360 * step;
        for (i = 0; i < self._trap_movers.size; i++) {
            self._trap_movers[i] rotateyaw(degrees, time);
        }
        wait(time);
    }
    self stoploopsound(2);
    self playsound("zmb_cent_end");
    for (i = 0; i < self._trap_movers.size; i++) {
        self._trap_movers[i] rotateyaw(360, 5, 0, 4);
    }
    wait(5);
    self notify(#"trap_done");
    for (i = 0; i < self._trap_movers.size; i++) {
        self._trap_movers[i] rotateto((0, end_angle % 360, 0), 1, 0, 0.9);
    }
    wait(1);
    self playsound("zmb_cent_lockdown");
    self notify(#"hash_6bde7592");
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0xade46c63, Offset: 0x1678
// Size: 0x2b8
function function_6226d8bf() {
    var_11a40c45 = getent("rotating_trap_group1", "targetname");
    var_c0ae568c = getent("trigger_centrifuge_damage", "targetname");
    var_bd94ed95 = var_11a40c45.angles;
    while (true) {
        if (!isdefined(level.var_6708aa9c) || !level.var_6708aa9c) {
            var_b281129c = randomint(10);
            if (var_b281129c > 6) {
                level waittill(#"between_round_over");
            } else if (var_b281129c == 1) {
                level waittill(#"between_round_over");
                level waittill(#"between_round_over");
            }
            wait(randomintrange(24, 90));
        }
        var_e14a0d12 = randomintrange(3, 7) * 360;
        wait_time = randomintrange(4, 7);
        level function_1e54c003(var_11a40c45);
        var_11a40c45 clientfield::set("COSMO_CENTRIFUGE_RUMBLE", 1);
        var_11a40c45 rotateyaw(var_e14a0d12, wait_time, 1, 2);
        var_c0ae568c thread function_ff0615a5();
        wait(3);
        var_11a40c45 stoploopsound(4);
        var_11a40c45 playsound("zmb_cent_end");
        var_11a40c45 waittill(#"rotatedone");
        var_c0ae568c notify(#"trap_done");
        var_11a40c45 playsound("zmb_cent_lockdown");
        var_11a40c45 clientfield::set("COSMO_CENTRIFUGE_LIGHTS", 0);
        var_11a40c45 clientfield::set("COSMO_CENTRIFUGE_RUMBLE", 0);
    }
}

// Namespace namespace_860ef124
// Params 1, eflags: 0x1 linked
// Checksum 0xade3f95c, Offset: 0x1938
// Size: 0xcc
function function_1e54c003(var_20fc8f3f) {
    var_20fc8f3f clientfield::set("COSMO_CENTRIFUGE_LIGHTS", 1);
    var_20fc8f3f playsound("zmb_cent_alarm");
    var_20fc8f3f playsound("vox_ann_centrifuge_spins_1");
    wait(1);
    var_20fc8f3f playsound("zmb_cent_start");
    wait(2);
    var_20fc8f3f playloopsound("zmb_cent_mach_loop", 0.6);
    wait(1);
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0xda43a2ef, Offset: 0x1a10
// Size: 0x1f8
function function_ff0615a5() {
    self endon(#"trap_done");
    self._trap_type = self.script_noteworthy;
    players = getplayers();
    while (true) {
        ent = self waittill(#"trigger");
        if (isplayer(ent) && ent.health > 1) {
            if (ent getstance() == "stand") {
                if (players.size == 1) {
                    ent dodamage(50, ent.origin + (0, 0, 20));
                    ent setstance("crouch");
                    wait(1);
                } else {
                    ent dodamage(125, ent.origin + (0, 0, 20));
                    ent setstance("crouch");
                }
            }
            continue;
        }
        if (!isdefined(ent.marked_for_death)) {
            ent.marked_for_death = 1;
            ent thread zm_traps::zombie_trap_death(self, randomint(100));
            ent playsound("zmb_cent_zombie_gib");
        }
    }
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0x47535b22, Offset: 0x1c10
// Size: 0x108
function function_e0b3d0ff() {
    assert(isdefined(self.target), "claw_l_arm");
    if (!isdefined(self.target)) {
        return;
    }
    self linkto(getent(self.target, "targetname"));
    while (true) {
        level flag::wait_till("fuge_spining");
        self playloopsound("zmb_cent_close_loop", 0.5);
        level flag::wait_till("fuge_slowdown");
        self stoploopsound(2);
        wait(0.05);
    }
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0x7af65900, Offset: 0x1d20
// Size: 0x4c
function function_d1419acd() {
    level.var_ee72aac2 playsound("evt_rocket_set_main");
    wait(13.8);
    level.var_ee72aac2 playsound("evt_rocket_set_impact");
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0x28edbf12, Offset: 0x1d78
// Size: 0x18c
function function_395fdbce() {
    level flag::init("base_door_opened");
    var_d8468821 = undefined;
    traps = getentarray("zombie_trap", "targetname");
    for (i = 0; i < traps.size; i++) {
        if (isdefined(traps[i].script_string) && traps[i].script_string == "f2") {
            var_d8468821 = traps[i];
            var_d8468821 zm_traps::trap_set_string(%ZOMBIE_NEED_POWER);
        }
    }
    level flag::wait_till("power_on");
    if (!level flag::get("base_entry_2_north_path")) {
        var_d8468821 zm_traps::trap_set_string(%ZM_COSMODROME_DOOR_CLOSED);
    }
    level flag::wait_till("base_entry_2_north_path");
    level flag::set("base_door_opened");
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0x9e920b2a, Offset: 0x1f10
// Size: 0x196
function function_b5bedb73() {
    function_3b7290e2(level.var_9701c946, "claw_l");
    function_3b7290e2(level.var_82df1788, "claw_r");
    var_547ac401 = getentarray(level.rocket.target, "targetname");
    for (i = 0; i < var_547ac401.size; i++) {
        var_547ac401[i] unlink();
    }
    var_326829bb = getentarray(level.var_ee72aac2.target, "targetname");
    for (i = 0; i < var_326829bb.size; i++) {
        var_326829bb[i] unlink();
    }
    level.var_413d861 = getentarray("lifter_clamp", "targetname");
    for (i = 0; i < level.var_413d861.size; i++) {
        level.var_413d861[i] unlink();
    }
}

// Namespace namespace_860ef124
// Params 0, eflags: 0x1 linked
// Checksum 0x44fcf602, Offset: 0x20b0
// Size: 0x1d6
function function_3015c292() {
    function_b16a68c0(level.var_9701c946, "claw_l");
    level.var_82df1788 = getent("claw_r_arm", "targetname");
    function_b16a68c0(level.var_82df1788, "claw_r");
    var_547ac401 = getentarray(level.rocket.target, "targetname");
    for (i = 0; i < var_547ac401.size; i++) {
        var_547ac401[i] linkto(level.rocket);
    }
    var_326829bb = getentarray(level.var_ee72aac2.target, "targetname");
    for (i = 0; i < var_326829bb.size; i++) {
        var_326829bb[i] linkto(level.var_ee72aac2);
    }
    level.var_413d861 = getentarray("lifter_clamp", "targetname");
    for (i = 0; i < level.var_413d861.size; i++) {
        level.var_413d861[i] linkto(level.var_3bc3f8d1);
    }
}

