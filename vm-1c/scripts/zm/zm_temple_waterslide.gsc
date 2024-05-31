#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_b33ca11;

// Namespace namespace_b33ca11
// Params 0, eflags: 0x0
// Checksum 0xf2a5fde1, Offset: 0x480
// Size: 0x8e
function function_4be4b562() {
    level._effect["fx_slide_wake"] = "bio/player/fx_player_water_swim_wake";
    level._effect["fx_slide_splash"] = "bio/player/fx_player_water_splash";
    level._effect["fx_slide_splash_2"] = "env/water/fx_water_splash_fountain_lg";
    level._effect["fx_slide_splash_3"] = "maps/pow/fx_pow_cave_water_splash";
    level._effect["fx_slide_water_fall"] = "maps/pow/fx_pow_cave_water_fall";
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0x9d672953, Offset: 0x518
// Size: 0x29e
function function_48cb0863() {
    level flag::init("waterslide_open");
    function_3704d2c0();
    var_4673ef02 = getent("waterslide_message_trigger", "targetname");
    if (isdefined(var_4673ef02)) {
        var_4673ef02 setcursorhint("HINT_NOICON");
    }
    cheat = 0;
    /#
        cheat = getdvarint("maps/pow/fx_pow_cave_water_fall") > 0;
    #/
    if (!cheat) {
        if (isdefined(var_4673ef02)) {
            var_4673ef02 sethintstring(%ZOMBIE_NEED_POWER);
        }
        level flag::wait_till("power_on");
        if (isdefined(var_4673ef02)) {
            var_4673ef02 sethintstring(%ZM_TEMPLE_DESTINATION_NOT_OPEN);
        }
        level flag::wait_till_any(array("cave01_to_cave02", "pressure_to_cave01"));
    }
    level flag::set("waterslide_open");
    if (isdefined(var_4673ef02)) {
        var_4673ef02 sethintstring("");
    }
    var_144a9b89 = getentarray("water_slide_blocker", "targetname");
    if (isdefined(var_144a9b89) && var_144a9b89.size > 0) {
        foreach (e_blocker in var_144a9b89) {
            e_blocker connectpaths();
            e_blocker movez(-128, 1);
        }
    }
    level notify(#"hash_5197cfd3");
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0x9c1cf1b0, Offset: 0x7c0
// Size: 0xfc
function function_3704d2c0() {
    level flag::init("slide_anim_change_allowed");
    level.var_3daddfbf = [];
    level thread function_d702357e();
    level flag::set("slide_anim_change_allowed");
    var_be0c4f10 = getentarray("zombie_cave_slide", "targetname");
    array::thread_all(var_be0c4f10, &function_2875e2e5);
    level thread function_4b4fa6af();
    level thread function_6559b217();
    level thread function_c2116ed4();
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0x67fa6af1, Offset: 0x8c8
// Size: 0xb0
function function_c2116ed4() {
    trig = getent("zombie_cave_slide_failsafe", "targetname");
    if (isdefined(trig)) {
        while (true) {
            who = trig waittill(#"trigger");
            if (isdefined(who.sliding) && who.sliding) {
                who.sliding = 0;
                who thread function_b4e07b39();
            }
        }
    }
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0xb3c808bc, Offset: 0x980
// Size: 0x174
function function_2875e2e5() {
    var_132c487f = getnode(self.target, "targetname");
    if (!isdefined(var_132c487f)) {
        return;
    }
    self triggerenable(0);
    level waittill(#"hash_5197cfd3");
    self triggerenable(1);
    while (true) {
        who = self waittill(#"trigger");
        if (who.animname == "zombie" || who.animname == "sonic_zombie" || who.animname == "napalm_zombie") {
            if (isdefined(who.sliding) && who.sliding == 1) {
                continue;
            } else {
                who thread function_21c0c94c(var_132c487f);
            }
            continue;
        }
        if (isdefined(who.var_21c0c94c)) {
            who thread [[ who.var_21c0c94c ]](var_132c487f);
        }
    }
}

// Namespace namespace_b33ca11
// Params 1, eflags: 0x1 linked
// Checksum 0xc1fc8d61, Offset: 0xb00
// Size: 0x270
function function_21c0c94c(var_132c487f) {
    self endon(#"death");
    level endon(#"intermission");
    if (!isdefined(self.var_268da46)) {
        self flag::init("slide_anim_change");
        self.var_268da46 = 1;
    }
    self.is_traversing = 1;
    self notify(#"hash_288b6f93");
    self thread function_3d4fa0e5();
    self thread function_af1cd912();
    self.ignore_find_flesh = 1;
    self.sliding = 1;
    self.ignoreall = 1;
    self.b_ignore_cleanup = 1;
    self thread function_7e3a6683();
    self notify(#"stop_find_flesh");
    self notify(#"zombie_acquire_enemy");
    self.var_9c5ae704 = self.zombie_move_speed;
    self thread function_fdf152fa();
    if (!(isdefined(self.missinglegs) && self.missinglegs)) {
        self setphysparams(15, 0, 24);
    }
    self setgoalnode(var_132c487f);
    var_2edad3c8 = 3600;
    while (distancesquared(self.origin, var_132c487f.origin) > var_2edad3c8) {
        wait(0.01);
    }
    self thread function_b4e07b39();
    if (!(isdefined(self.missinglegs) && self.missinglegs)) {
        self setphysparams(15, 0, 72);
    }
    self notify(#"hash_b2707e13");
    self.ignore_find_flesh = 0;
    self.sliding = 0;
    self.is_traversing = 0;
    self notify(#"hash_af582b8e");
    self.ignoreall = 0;
    self.b_ignore_cleanup = 0;
    self.ai_state = "find_flesh";
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0xc88b4c7f, Offset: 0xd78
// Size: 0x84
function function_af1cd912() {
    self endon(#"death");
    level endon(#"intermission");
    self playloopsound("fly_dtp_slide_loop_npc_snow", 0.5);
    self util::waittill_any("zombie_end_traverse", "death");
    self stoploopsound(0.5);
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0xefd43c05, Offset: 0xe08
// Size: 0x14
function function_fdf152fa() {
    self.zombie_move_speed = "slide";
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0xe08f3ddc, Offset: 0xe28
// Size: 0x20
function function_b4e07b39() {
    if (isdefined(self.var_9c5ae704)) {
        self.zombie_move_speed = self.var_9c5ae704;
    }
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x0
// Checksum 0xa466b9f, Offset: 0xe50
// Size: 0xac
function function_f269bc50() {
    self endon(#"death");
    if (self.animname == "sonic_zombie" || self.animname == "napalm_zombie") {
        return self.deathanim;
    }
    var_7975df96 = undefined;
    rand = randomintrange(1, 5);
    if (!self.missinglegs) {
        var_7975df96 = level.scr_anim[self.animname]["attracted_death_" + rand];
    }
    return var_7975df96;
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0xb367d0da, Offset: 0xf08
// Size: 0x94
function function_7e3a6683() {
    self endon(#"death");
    if (self.animname == "sonic_zombie" || self.animname == "napalm_zombie") {
        return;
    }
    if (self.missinglegs) {
        return;
    }
    while (self.sliding) {
        if (self.missinglegs && self.var_14b13709 == 1) {
            self thread function_fdf152fa();
            return;
        }
        wait(0.1);
    }
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0xd0ac906f, Offset: 0xfa8
// Size: 0x1f8
function function_d702357e() {
    if (!isdefined(level.var_3daddfbf)) {
        level.var_3daddfbf = [];
    }
    var_444ffb38 = 7;
    var_c48b032a = [];
    while (isdefined(level.var_3daddfbf)) {
        if (level.var_3daddfbf.size == 0) {
            wait(0.1);
            continue;
        }
        var_c48b032a = level.var_3daddfbf;
        for (i = 0; i < var_c48b032a.size; i++) {
            if (isdefined(var_c48b032a[i]) && isalive(var_c48b032a[i])) {
                var_c48b032a[i] flag::set("slide_anim_change");
            }
            if (i >= var_444ffb38) {
                break;
            }
        }
        level flag::clear("slide_anim_change_allowed");
        for (i = 0; i < var_c48b032a.size; i++) {
            if (var_c48b032a[i] flag::get("slide_anim_change")) {
                level.var_3daddfbf = arrayremovevalue(level.var_3daddfbf, var_c48b032a[i]);
            }
        }
        level.var_3daddfbf = array::remove_dead(level.var_3daddfbf);
        level flag::set("slide_anim_change_allowed");
        util::wait_network_frame();
        wait(0.1);
    }
}

// Namespace namespace_b33ca11
// Params 2, eflags: 0x0
// Checksum 0xe2dbf2ed, Offset: 0x11a8
// Size: 0x11c
function array_remove(array, object) {
    if (!isdefined(array) && !isdefined(object)) {
        return;
    }
    new_array = [];
    foreach (item in array) {
        if (item != object) {
            if (!isdefined(new_array)) {
                new_array = [];
            } else if (!isarray(new_array)) {
                new_array = array(new_array);
            }
            new_array[new_array.size] = item;
        }
    }
    return new_array;
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0x4cb62c4b, Offset: 0x12d0
// Size: 0x118
function function_4b4fa6af() {
    level endon(#"fake_death");
    trig = getent("cave_slide_force_crouch", "targetname");
    while (true) {
        who = trig waittill(#"trigger");
        if (isdefined(who) && isplayer(who) && who.sessionstate != "spectator" && !(isdefined(who.var_558a7130) && who.var_558a7130)) {
            who.var_558a7130 = 1;
            who thread function_91107d64();
            who thread zm_audio::create_and_play_dialog("general", "slide");
        }
    }
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0x37932d7c, Offset: 0x13f0
// Size: 0xdc
function function_6559b217() {
    trig = getent("cave_slide_force_stand", "targetname");
    while (true) {
        who = trig waittill(#"trigger");
        if (isdefined(who.var_558a7130) && isdefined(who) && isplayer(who) && who.sessionstate != "spectator" && who.var_558a7130) {
            who.var_558a7130 = 0;
            who notify(#"hash_b2707e13");
        }
    }
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0x33f89f59, Offset: 0x14d8
// Size: 0x84
function function_91107d64() {
    self thread function_9a3b6047();
    self thread function_37d7bd97();
    self util::waittill_any("water_slide_exit", "death", "disconnect");
    if (isdefined(self)) {
        self thread function_f65c130b();
    }
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0x702f4fbb, Offset: 0x1568
// Size: 0x64
function function_37d7bd97() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_b2707e13");
    self waittill(#"fake_death");
    self allowstand(1);
    self allowprone(1);
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0xe46e171e, Offset: 0x15d8
// Size: 0x10c
function function_9a3b6047() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_b2707e13");
    self playloopsound("evt_slideloop");
    while (self laststand::player_is_in_laststand()) {
        self.bleedout_time = 0;
        self playlocalsound(level.zmb_laugh_alias);
        self.var_558a7130 = 0;
        return;
    }
    while (isdefined(self.divetoprone) && self.divetoprone) {
        wait(0.1);
    }
    self allowstand(0);
    self allowprone(0);
    self setstance("crouch");
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0x5e2c5038, Offset: 0x16f0
// Size: 0x9c
function function_f65c130b() {
    self endon(#"death");
    self endon(#"disconnect");
    self allowstand(1);
    self allowprone(1);
    if (!self laststand::player_is_in_laststand()) {
        self setstance("stand");
    }
    self stoploopsound();
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0x5b1e63ec, Offset: 0x1798
// Size: 0x5c
function function_3d4fa0e5() {
    self thread function_5a43d102();
    self util::waittill_any("water_slide_exit", "death");
    self thread function_f016f6f4();
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0xf73001cc, Offset: 0x1800
// Size: 0x24
function function_5a43d102() {
    self playloopsound("evt_slideloop");
}

// Namespace namespace_b33ca11
// Params 0, eflags: 0x1 linked
// Checksum 0xaf09e203, Offset: 0x1830
// Size: 0x1c
function function_f016f6f4() {
    self stoploopsound();
}

