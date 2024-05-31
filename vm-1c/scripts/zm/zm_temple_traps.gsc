#using scripts/zm/zm_temple_triggers;
#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_38b06d6b;

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_5237c864
// Checksum 0xd9e45a6c, Offset: 0x520
// Size: 0x4c
function function_5237c864() {
    level thread function_b10ced9f();
    level thread function_c9dbf3ce();
    level thread function_52dfbfff();
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x0
// namespace_38b06d6b<file_0>::function_615b98fb
// Checksum 0x73cdace8, Offset: 0x578
// Size: 0x6c
function function_615b98fb() {
    self sethintstring(%ZOMBIE_NEED_POWER);
    self setcursorhint("HINT_NOICON");
    self.in_use = 0;
    level flag::wait_till("power_on");
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_b10ced9f
// Checksum 0x6eee6ce9, Offset: 0x5f0
// Size: 0x10e
function function_b10ced9f() {
    var_81dda4fc = getentarray("spear_trap", "targetname");
    for (i = 0; i < var_81dda4fc.size; i++) {
        var_8996573d = var_81dda4fc[i];
        var_8996573d.clip = getent(var_8996573d.target, "targetname");
        var_8996573d.clip notsolid();
        var_8996573d.clip connectpaths();
        var_8996573d.var_feaa6695 = var_8996573d.script_noteworthy;
        var_8996573d thread function_2ebdc6f7();
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_2ebdc6f7
// Checksum 0x81e7c4af, Offset: 0x708
// Size: 0x10a
function function_2ebdc6f7() {
    if (isdefined(self.var_feaa6695) && !level flag::get(self.var_feaa6695)) {
        level flag::wait_till(self.var_feaa6695);
    }
    while (true) {
        who = self waittill(#"trigger");
        if (!isdefined(who) || !isplayer(who) || who.sessionstate == "spectator") {
            continue;
        }
        for (i = 0; i < 3; i++) {
            wait(0.4);
            self thread function_30fb7375(i, who);
            wait(2);
        }
    }
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_30fb7375
// Checksum 0xc395bb44, Offset: 0x820
// Size: 0x4c
function function_30fb7375(var_b88db980, player) {
    self function_682ad92d(var_b88db980, player);
    self thread function_e315e894(0);
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_682ad92d
// Checksum 0x69963516, Offset: 0x878
// Size: 0x156
function function_682ad92d(var_b88db980, player) {
    wait(0.1);
    characters = arraycombine(getplayers(), getaispeciesarray("axis"), 1, 1);
    for (i = 0; i < characters.size; i++) {
        char = characters[i];
        if (self function_12d35403(char)) {
            self thread function_1f33cf14(char);
            continue;
        }
        if (isplayer(char) && var_b88db980 == 0 && randomintrange(0, 101) <= 10) {
            if (isdefined(player) && player == char) {
                char thread function_125cf0e6();
            }
        }
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_125cf0e6
// Checksum 0x5fc373ae, Offset: 0x9d8
// Size: 0x8c
function function_125cf0e6() {
    self notify(#"hash_3a231d02");
    self endon(#"death");
    self endon(#"hash_3a231d02");
    wait(0.5);
    if (isdefined(self.var_319bd14e) && (!isdefined(self.var_319bd14e) || isdefined(self) && self.var_319bd14e == 0)) {
        self thread zm_audio::create_and_play_dialog("general", "spikes_close");
    }
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_1f33cf14
// Checksum 0xc21af182, Offset: 0xa70
// Size: 0x24
function function_1f33cf14(char) {
    char thread function_319bd14e();
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_319bd14e
// Checksum 0x9c12e22b, Offset: 0xaa0
// Size: 0x1a0
function function_319bd14e() {
    self endon(#"death");
    if (isdefined(self.var_319bd14e) && self.var_319bd14e) {
        return;
    }
    self.var_319bd14e = 1;
    if (isplayer(self)) {
        if (zombie_utility::is_player_valid(self)) {
            self thread zm_audio::create_and_play_dialog("general", "spikes_damage");
            self thread function_ebdb4043();
            self dodamage(5, self.origin);
            playsoundatposition("evt_spear_butt", self.origin);
            self playrumbleonentity("pistol_fire");
        }
        self setvelocity((0, 0, 0));
        self setmovespeedscale(0.2);
        wait(1);
        self setmovespeedscale(1);
        wait(0.5);
    } else if (!(isdefined(self.missinglegs) && self.missinglegs)) {
        self function_44654fba();
    }
    self.var_319bd14e = 0;
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_af1e2641
// Checksum 0xd713184d, Offset: 0xc48
// Size: 0x30
function function_af1e2641() {
    level.var_d93915a9 = 0;
    while (true) {
        wait(0.05);
        level.var_d93915a9 = 0;
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_44654fba
// Checksum 0xefc2fad9, Offset: 0xc80
// Size: 0xfc
function function_44654fba() {
    self endon(#"death");
    if (!isdefined(level.var_6f7f4d6)) {
        level.var_6f7f4d6 = 1;
        level thread function_af1e2641();
    }
    endtime = gettime() + randomintrange(800, 1200);
    while (endtime > gettime()) {
        if (isdefined(self.missinglegs) && self.missinglegs) {
            break;
        }
        wait(0.05);
    }
    while (level.var_d93915a9 > 2) {
        println("general");
        wait(0.05);
    }
    self stopanimscripted(0.5);
    level.var_d93915a9++;
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_ebdb4043
// Checksum 0xde44c5d0, Offset: 0xd88
// Size: 0x174
function function_ebdb4043() {
    prompt = newclienthudelem(self);
    prompt.alignx = "left";
    prompt.x = 0;
    prompt.y = 0;
    prompt.alignx = "left";
    prompt.aligny = "top";
    prompt.horzalign = "fullscreen";
    prompt.vertalign = "fullscreen";
    fadetime = 1;
    prompt.color = (0.2, 0, 0);
    prompt.alpha = 0.7;
    prompt fadeovertime(fadetime);
    prompt.alpha = 0;
    prompt.shader = "white";
    prompt setshader("white", 640, 480);
    wait(fadetime);
    prompt destroy();
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_12d35403
// Checksum 0x5e278eb9, Offset: 0xf08
// Size: 0x22
function function_12d35403(char) {
    return self istouching(char);
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_e315e894
// Checksum 0x6ef7956b, Offset: 0xf38
// Size: 0xbc
function function_e315e894(delay) {
    wait(delay);
    if (isdefined(self.clip)) {
        self.clip solid();
        self.clip clientfield::set("spiketrap", 1);
    }
    wait(2);
    if (isdefined(self.clip)) {
        self.clip notsolid();
        self.clip clientfield::set("spiketrap", 0);
    }
    wait(0.2);
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x0
// namespace_38b06d6b<file_0>::function_bc0637cf
// Checksum 0x2c0a4874, Offset: 0x1000
// Size: 0x94
function function_bc0637cf(magnitude) {
    self startragdoll();
    self launchragdoll((0, 0, 50));
    util::wait_network_frame();
    self.a.gib_ref = "head";
    self dodamage(self.health + 666, self.origin);
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_c1d6ab5b
// Checksum 0xf0bf4a00, Offset: 0x10a0
// Size: 0x1be
function function_c1d6ab5b() {
    var_909857e3 = undefined;
    for (i = 0; i < self.var_4146f927.size; i++) {
        var_909857e3 = self.var_4146f927[i];
        var_909857e3 movey(-5, 0.75);
    }
    if (isdefined(var_909857e3)) {
        var_909857e3 playloopsound("zmb_pressure_plate_loop");
        var_909857e3 waittill(#"movedone");
        var_909857e3 stoploopsound();
        var_909857e3 playsound("zmb_pressure_plate_lock");
    }
    self notify(#"switch_activated");
    self waittill(#"hash_9a42e31c");
    for (i = 0; i < self.var_4146f927.size; i++) {
        var_909857e3 = self.var_4146f927[i];
        var_909857e3 movey(5, 0.75);
        var_909857e3 playloopsound("zmb_pressure_plate_loop");
        var_909857e3 waittill(#"movedone");
        var_909857e3 stoploopsound();
        var_909857e3 playsound("zmb_pressure_plate_lock");
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_c9dbf3ce
// Checksum 0x9bf923bd, Offset: 0x1268
// Size: 0x3c6
function function_c9dbf3ce() {
    var_c46456a5 = getentarray("waterfall_trap", "targetname");
    for (i = 0; i < var_c46456a5.size; i++) {
        var_1ce51f83 = spawnstruct();
        var_1ce51f83.usetrigger = var_c46456a5[i];
        var_1ce51f83.usetrigger sethintstring(%ZOMBIE_NEED_POWER);
        var_1ce51f83.usetrigger setcursorhint("HINT_NOICON");
        var_1ce51f83.var_4146f927 = [];
        var_1ce51f83.trap_damage = [];
        var_1ce51f83.var_54f3daaf = [];
        var_1ce51f83.var_72969c6 = [];
        var_1ce51f83.var_41f396e4 = [];
        targetents = getentarray(var_1ce51f83.usetrigger.target, "targetname");
        targetstructs = struct::get_array(var_1ce51f83.usetrigger.target, "targetname");
        targets = arraycombine(targetents, targetstructs, 1, 1);
        for (j = 0; j < targets.size; j++) {
            if (!isdefined(targets[j].script_noteworthy)) {
                continue;
            }
            switch (targets[j].script_noteworthy) {
            case 23:
                var_1ce51f83.var_4146f927[var_1ce51f83.var_4146f927.size] = targets[j];
                break;
            case 21:
                var_1ce51f83.trap_damage[var_1ce51f83.trap_damage.size] = targets[j];
                break;
            case 22:
                var_1ce51f83.var_54f3daaf[var_1ce51f83.var_54f3daaf.size] = targets[j];
                break;
            case 24:
                targets[j] triggerenable(0);
                var_1ce51f83.var_72969c6[var_1ce51f83.var_72969c6.size] = targets[j];
                break;
            case 25:
                targets[j] triggerenable(0);
                var_1ce51f83.var_41f396e4[var_1ce51f83.var_41f396e4.size] = targets[j];
                break;
            }
        }
        var_1ce51f83.var_feaa6695 = var_1ce51f83.usetrigger.script_noteworthy;
        var_1ce51f83 function_6716c0();
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_6716c0
// Checksum 0xc5d45d1a, Offset: 0x1638
// Size: 0x228
function function_6716c0() {
    while (true) {
        self notify(#"hash_9a42e31c");
        self.usetrigger sethintstring(%ZM_TEMPLE_USE_WATER_TRAP);
        who = self.usetrigger waittill(#"trigger");
        if (zombie_utility::is_player_valid(who) && !who zm_utility::in_revive_trigger()) {
            who.var_b4fc5f8d = 1;
            self thread function_c1d6ab5b();
            self waittill(#"switch_activated");
            self.usetrigger sethintstring("");
            function_e8bcc163();
            wait(0.5);
            who.var_b4fc5f8d = 0;
            array::thread_all(self.trap_damage, &function_5165a46b);
            activetime = 5.5;
            array::thread_all(self.var_41f396e4, &function_3522da09, activetime);
            self thread function_201aca6f(activetime);
            wait(activetime);
            self notify(#"hash_a7a4f8be");
            self.usetrigger sethintstring(%ZM_TEMPLE_WATER_TRAP_COOL);
            array::thread_all(self.var_41f396e4, &function_a6e2b85f);
            function_f0ae65d7();
            array::notify_all(self.trap_damage, "trap_off");
            wait(30);
        }
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_a6e2b85f
// Checksum 0x31ca6b67, Offset: 0x1868
// Size: 0x2a
function function_a6e2b85f() {
    self triggerenable(0);
    self notify(#"hash_f0ae65d7");
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_3522da09
// Checksum 0xe8683894, Offset: 0x18a0
// Size: 0x6c
function function_3522da09(activetime) {
    self.var_839ef4da = 5;
    self.var_98a50550 = 1;
    self.var_da118935 = 1;
    wait(1.5);
    self.var_5d7c0172 = activetime - 1.5;
    self thread function_b68fdf22();
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_b68fdf22
// Checksum 0xa703da4b, Offset: 0x1918
// Size: 0x78
function function_b68fdf22() {
    self endon(#"hash_f0ae65d7");
    self triggerenable(1);
    while (true) {
        who = self waittill(#"trigger");
        if (isplayer(who)) {
            self thread function_5e706bd9(who);
        }
    }
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_5e706bd9
// Checksum 0xf89ce165, Offset: 0x1998
// Size: 0x94
function function_5e706bd9(player) {
    player endon(#"disconnect");
    self thread namespace_654014fa::function_ccbda65b(player);
    while (isdefined(player) && player istouching(self) && self istriggerenabled()) {
        wait(0.05);
    }
    self thread namespace_654014fa::function_7b9c0362(player);
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_201aca6f
// Checksum 0x2977555e, Offset: 0x1a38
// Size: 0x6e
function function_201aca6f(activetime) {
    wait(1);
    for (i = 0; i < self.var_54f3daaf.size; i++) {
        function_f3706922(activetime, self.var_54f3daaf[i].origin);
    }
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_f3706922
// Checksum 0xf0adabf5, Offset: 0x1ab0
// Size: 0xa2
function function_f3706922(activetime, origin) {
    remainingtime = 1;
    if (activetime > 6) {
    }
    for (remainingtime = activetime - 6; remainingtime > 0; remainingtime -= 1) {
        earthquake(0.14, activetime, origin, 400);
        wait(1);
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_e8bcc163
// Checksum 0x4ba2c357, Offset: 0x1b60
// Size: 0xc4
function function_e8bcc163() {
    var_2936d99 = struct::get("waterfall_trap_origin", "targetname");
    if (isdefined(var_2936d99)) {
        playsoundatposition("evt_waterfall_trap", var_2936d99.origin);
    }
    level notify(#"waterfall");
    level clientfield::set("waterfall_trap", 1);
    exploder::exploder("fxexp_21");
    exploder::stop_exploder("fxexp_20");
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_f0ae65d7
// Checksum 0x622a57f9, Offset: 0x1c30
// Size: 0x34
function function_f0ae65d7() {
    exploder::exploder("fxexp_20");
    exploder::stop_exploder("fxexp_21");
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_5165a46b
// Checksum 0xed467420, Offset: 0x1c70
// Size: 0x1b0
function function_5165a46b() {
    self endon(#"hash_a7a4f8be");
    fwd = anglestoforward(self.angles);
    var_9f46468f = [];
    while (true) {
        who = self waittill(#"trigger");
        if (isplayer(who)) {
            if (isdefined(self.script_string) && self.script_string == "hurt_player") {
                who dodamage(20, self.origin);
                wait(1);
            } else {
                who thread function_e09c1da7(fwd, 5.45);
            }
        }
        if (isdefined(who.animname) && who.animname == "monkey_zombie") {
            who thread function_a3035a43(randomintrange(30, 80), fwd);
            continue;
        }
        if (!function_13809384(who, var_9f46468f)) {
            var_9f46468f[var_9f46468f.size] = who;
            util::wait_network_frame();
            who thread function_b5ad6065(self);
        }
    }
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_e09c1da7
// Checksum 0x21997b1f, Offset: 0x1e28
// Size: 0x84
function function_e09c1da7(fwd, time) {
    wait(1);
    vel = self getvelocity();
    self setvelocity(vel + fwd * 60);
    self playrumbleonentity("slide_rumble");
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_a3035a43
// Checksum 0x10e036d8, Offset: 0x1eb8
// Size: 0x84
function function_a3035a43(magnitude, dir) {
    wait(1);
    self startragdoll();
    self launchragdoll(dir * magnitude);
    util::wait_network_frame();
    self dodamage(self.health + 666, self.origin);
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_13809384
// Checksum 0x5d0a9b5b, Offset: 0x1f48
// Size: 0x5a
function function_13809384(ent, var_45f4f0f7) {
    for (i = 0; i < var_45f4f0f7.size; i++) {
        if (var_45f4f0f7[i] == ent) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_52dfbfff
// Checksum 0x1bbee468, Offset: 0x1fb0
// Size: 0x5e4
function function_52dfbfff() {
    level.var_3f3d042f = [];
    level.var_965d53e5 = [];
    level.var_cf701397 = [];
    level.var_bcbd525d = [];
    level.var_3bf786b6 = [];
    level.var_f79fd95e = [];
    level.var_37c189c6 = 0;
    var_2d2fcf9a = getent("maze_path_clip", "targetname");
    if (isdefined(var_2d2fcf9a)) {
        var_2d2fcf9a delete();
    }
    function_f0e6654e();
    var_7d0449df = getentarray("maze_trigger", "targetname");
    for (i = 0; i < var_7d0449df.size; i++) {
        var_711ca19c = var_7d0449df[i];
        var_711ca19c.var_77784065 = 0;
        var_d653eecd = var_711ca19c.script_int;
        if (!isdefined(var_d653eecd)) {
            continue;
        }
        function_831a33b0(var_d653eecd);
        level.var_3f3d042f[var_d653eecd - 1].trigger = var_711ca19c;
        if (isdefined(var_711ca19c.script_string)) {
            var_c28ecd6f = var_711ca19c.script_string == "start";
            if (var_c28ecd6f) {
                level.var_3bf786b6[level.var_3bf786b6.size] = level.var_3f3d042f[var_d653eecd - 1];
            }
        }
    }
    var_965d53e5 = getentarray("maze_floor", "targetname");
    for (i = 0; i < var_965d53e5.size; i++) {
        var_ae571f2a = var_965d53e5[i];
        floornum = var_ae571f2a.script_int;
        if (!isdefined(floornum)) {
            continue;
        }
        var_ae571f2a function_f4833e89(16, 0.25, 0.5, 0, "evt_maze_floor_up", "evt_maze_floor_up", 0);
        level.var_3f3d042f[floornum - 1].floor = var_ae571f2a;
        level.var_965d53e5[level.var_965d53e5.size] = var_ae571f2a;
    }
    var_cf701397 = getentarray("maze_door", "targetname");
    for (i = 0; i < var_cf701397.size; i++) {
        var_1e134364 = var_cf701397[i];
        var_7cad326b = var_1e134364.script_int;
        if (!isdefined(var_7cad326b)) {
            continue;
        }
        var_1e134364 function_f4833e89(-128, 0.25, 1, 1, "evt_maze_wall_down", "evt_maze_wall_up", 1);
        var_1e134364 notsolid();
        var_1e134364 connectpaths();
        var_1e134364.script_fxid = level._effect["maze_wall_impact"];
        var_1e134364.var_f88b106c = level._effect["maze_wall_raise"];
        var_1e134364.var_1cb182da = (0, 0, -60);
        var_1e134364.var_f7339436 = [];
        var_7d18661a = [];
        var_7d18661a[0] = var_7cad326b % 100;
        var_7d18661a[1] = int((var_7cad326b - var_7cad326b % 100) / 100);
        for (j = 0; j < var_7d18661a.size; j++) {
            var_30ebe65c = var_7d18661a[j];
            if (var_30ebe65c == 0) {
                continue;
            }
            var_93b1b42c = level.var_3f3d042f[var_30ebe65c - 1];
            var_93b1b42c.walls[var_93b1b42c.walls.size] = var_1e134364;
            var_1e134364.var_f7339436[var_1e134364.var_f7339436.size] = var_93b1b42c;
        }
        level.var_cf701397[level.var_cf701397.size] = var_1e134364;
    }
    function_70a99c48();
    array::thread_all(level.var_3f3d042f, &function_b5cf9847);
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_f0e6654e
// Checksum 0x4d3854a1, Offset: 0x25a0
// Size: 0x614
function function_f0e6654e() {
    level.var_3330e4d3 = 0;
    level.var_a8d9929c = [];
    function_305267a2(array(5, 4, 3));
    function_305267a2(array(5, 4, 1, 0, 3));
    function_305267a2(array(5, 4, 7, 6, 3));
    function_305267a2(array(5, 4, 3, 6, 9, 12));
    function_305267a2(array(5, 4, 7, 10, 11, 14, 13, 12));
    function_305267a2(array(5, 4, 1, 0, 3, 6, 9, 12));
    function_305267a2(array(5, 4, 7, 8), 1);
    function_305267a2(array(5, 4, 1, 0, 3, 6, 7, 8), 1);
    function_305267a2(array(3, 4, 7, 10, 13, 12));
    function_305267a2(array(3, 4, 5, 8, 7, 6, 9, 12));
    function_305267a2(array(3, 4, 1, 2, 5, 8, 11, 10, 9, 12));
    function_305267a2(array(3, 4, 5));
    function_305267a2(array(3, 4, 7, 6, 9, 10, 11, 8, 5));
    function_305267a2(array(3, 4, 1, 2, 5));
    function_305267a2(array(3, 4, 7, 6), 1);
    function_305267a2(array(3, 4, 1, 2, 5, 8, 7, 6), 1);
    function_305267a2(array(12, 9, 6, 3));
    function_305267a2(array(12, 9, 10, 7, 4, 3));
    function_305267a2(array(12, 9, 10, 13, 14, 11, 8, 5, 4, 3));
    function_305267a2(array(12, 9, 6, 3, 4, 5));
    function_305267a2(array(12, 9, 10, 11, 8, 7, 4, 5));
    function_305267a2(array(12, 9, 6, 3, 0, 1, 2, 5));
    function_305267a2(array(12, 9, 10, 13), 1);
    function_305267a2(array(12, 9, 6, 7, 10, 13), 1);
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_305267a2
// Checksum 0x9dd3e1ea, Offset: 0x2bc0
// Size: 0x86
function function_305267a2(path, loopback) {
    if (!isdefined(loopback)) {
        loopback = 0;
    }
    s = spawnstruct();
    s.path = path;
    s.loopback = loopback;
    level.var_a8d9929c[level.var_a8d9929c.size] = s;
}

// Namespace namespace_38b06d6b
// Params 7, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_f4833e89
// Checksum 0x2c4f2ef5, Offset: 0x2c50
// Size: 0x130
function function_f4833e89(movedist, var_974df0d6, var_5d5a0d45, var_6f2700a9, var_28fb82fe, var_cdede517, cliponly) {
    self.isactive = 0;
    self.activecount = 0;
    self.ismoving = 0;
    self.movedist = movedist;
    self.var_83e367a2 = self.origin[2] + movedist;
    self.var_974df0d6 = var_974df0d6;
    self.var_5d5a0d45 = var_5d5a0d45;
    self.pathblocker = var_6f2700a9;
    self.var_f5212328 = 0;
    self.var_28fb82fe = var_28fb82fe;
    self.var_cdede517 = var_cdede517;
    self.startangles = self.angles;
    self.cliponly = cliponly;
    if (isdefined(self.script_string) && self.script_string == "always_active") {
        function_babea22b(1);
        self.var_f5212328 = 1;
    }
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_831a33b0
// Checksum 0x84b928b4, Offset: 0x2d88
// Size: 0x7e
function function_831a33b0(var_68cd1d20) {
    for (i = level.var_3f3d042f.size; i < var_68cd1d20; i++) {
        level.var_3f3d042f[i] = spawnstruct();
        level.var_3f3d042f[i] function_de135727();
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_de135727
// Checksum 0x76efb1aa, Offset: 0x2e10
// Size: 0x20
function function_de135727() {
    self.trigger = undefined;
    self.floor = undefined;
    self.walls = [];
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_babea22b
// Checksum 0x576addf7, Offset: 0x2e38
// Size: 0x2fc
function function_babea22b(active) {
    if (self.var_f5212328) {
        return;
    }
    if (active) {
        self.activecount++;
    } else {
        self.activecount = int(max(0, self.activecount - 1));
    }
    active = self.activecount > 0;
    if (self.isactive == active) {
        return;
    }
    if (active && isdefined(self.var_28fb82fe)) {
        self playsound(self.var_28fb82fe);
    }
    if (!active && isdefined(self.var_cdede517)) {
        self playsound(self.var_cdede517);
    }
    goalpos = (self.origin[0], self.origin[1], self.var_83e367a2);
    if (!active) {
        goalpos = (goalpos[0], goalpos[1], goalpos[2] - self.movedist);
    }
    movetime = self.var_974df0d6;
    if (!active) {
        movetime = self.var_5d5a0d45;
    }
    if (self.ismoving) {
        currentz = self.origin[2];
        goalz = goalpos[2];
        ratio = abs(goalz - currentz) / abs(self.movedist);
        movetime *= ratio;
    }
    self notify(#"hash_1a01fee7");
    self.isactive = active;
    if (self.cliponly) {
        if (active) {
            self solid();
            self disconnectpaths();
            self clientfield::set("mazewall", 1);
        } else {
            self notsolid();
            self connectpaths();
            self clientfield::set("mazewall", 0);
        }
        return;
    }
    self thread function_9443921(goalpos, movetime);
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_9443921
// Checksum 0x8e8d01e6, Offset: 0x3140
// Size: 0x10c
function function_9443921(goal, time) {
    self endon(#"hash_1a01fee7");
    self.ismoving = 1;
    if (time == 0) {
        time = 0.01;
    }
    self moveto(goal, time);
    self waittill(#"movedone");
    self.ismoving = 0;
    if (self.isactive) {
        function_53f9ed11(self.script_fxid, self.var_1cb182da);
    } else {
        function_53f9ed11(self.var_f88b106c, self.var_2f5c5654);
    }
    if (self.pathblocker) {
        if (self.isactive) {
            self disconnectpaths();
            return;
        }
        self connectpaths();
    }
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_53f9ed11
// Checksum 0xe5b347d6, Offset: 0x3258
// Size: 0x94
function function_53f9ed11(fx_name, offset) {
    if (isdefined(fx_name)) {
        var_5b62b694 = anglestoforward(self.angles);
        org = self.origin;
        if (isdefined(offset)) {
            org += offset;
        }
        playfx(fx_name, org, var_5b62b694, (0, 0, 1));
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_b5cf9847
// Checksum 0x60aa273c, Offset: 0x32f8
// Size: 0x1d0
function function_b5cf9847() {
    level endon(#"fake_death");
    while (true) {
        who = self.trigger waittill(#"trigger");
        if (self.trigger.var_77784065 > 0) {
            if (isplayer(who)) {
                if (who function_de05038d()) {
                    continue;
                }
                if (who.sessionstate == "spectator") {
                    continue;
                }
                self thread function_e204bb2a(who);
            } else if (isdefined(who.animname) && who.animname == "zombie") {
                self.trigger thread function_837aaf39(who);
            }
            continue;
        }
        if (isplayer(who)) {
            if (who function_f5ab2041()) {
                continue;
            }
            if (who.sessionstate == "spectator") {
                continue;
            }
            self.trigger thread function_d92e1936(who);
            continue;
        }
        if (isdefined(who.animname) && who.animname == "zombie") {
            self.trigger thread function_81d81233(who);
        }
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_c5f7039c
// Checksum 0xd45db5d9, Offset: 0x34d0
// Size: 0x76
function function_c5f7039c() {
    self.var_5526feb3 = self.zombie_move_speed;
    switch (self.zombie_move_speed) {
    case 51:
        self zombie_utility::set_zombie_run_cycle("walk");
        break;
    case 52:
        self zombie_utility::set_zombie_run_cycle("run");
        break;
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_d95c0222
// Checksum 0x7d5fe3aa, Offset: 0x3550
// Size: 0x24
function function_d95c0222() {
    self zombie_utility::set_zombie_run_cycle(self.var_5526feb3);
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_81d81233
// Checksum 0x150a26e6, Offset: 0x3580
// Size: 0x154
function function_81d81233(zombie) {
    zombie endon(#"death");
    if (isdefined(zombie.var_45c436ff)) {
        if (is_in_array(zombie.var_45c436ff, self)) {
            return;
        }
    } else {
        zombie.var_45c436ff = [];
    }
    if (!zombie function_ada6f91a()) {
        zombie function_c5f7039c();
    }
    zombie.var_45c436ff[zombie.var_45c436ff.size] = self;
    while (self.var_77784065 == 0 && zombie istouching(self)) {
        wait(0.1);
    }
    arrayremovevalue(zombie.var_45c436ff, self);
    if (!zombie function_ada6f91a() && !zombie function_1116861d()) {
        zombie function_d95c0222();
    }
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_61f97d13
// Checksum 0x9ec19cb9, Offset: 0x36e0
// Size: 0x98
function is_in_array(array, item) {
    foreach (index in array) {
        if (index == item) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_1116861d
// Checksum 0x3f2644f3, Offset: 0x3780
// Size: 0x1c
function function_1116861d() {
    return isdefined(self.var_c83d7ce0) && self.var_c83d7ce0.size > 0;
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_ada6f91a
// Checksum 0x8a43c486, Offset: 0x37a8
// Size: 0x1c
function function_ada6f91a() {
    return isdefined(self.var_45c436ff) && self.var_45c436ff.size > 0;
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_837aaf39
// Checksum 0x9b9293cf, Offset: 0x37d0
// Size: 0x10c
function function_837aaf39(zombie) {
    zombie endon(#"death");
    if (isdefined(zombie.var_c83d7ce0)) {
        if (is_in_array(zombie.var_c83d7ce0, self)) {
            return;
        }
    } else {
        zombie.var_c83d7ce0 = [];
    }
    if (!zombie function_1116861d()) {
        zombie function_d95c0222();
    }
    zombie.var_c83d7ce0[zombie.var_c83d7ce0.size] = self;
    while (self.var_77784065 != 0 && zombie istouching(self)) {
        wait(0.1);
    }
    arrayremovevalue(zombie.var_c83d7ce0, self);
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_f5ab2041
// Checksum 0x43c04cb0, Offset: 0x38e8
// Size: 0x1c
function function_f5ab2041() {
    return isdefined(self.var_14d05180) && self.var_14d05180.size > 0;
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_de05038d
// Checksum 0xfee74f4b, Offset: 0x3910
// Size: 0x1c
function function_de05038d() {
    return isdefined(self.var_7fc81e41) && self.var_7fc81e41.size > 0;
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_e204bb2a
// Checksum 0xb7f6391d, Offset: 0x3938
// Size: 0x1e4
function function_e204bb2a(player) {
    if (isdefined(player.var_14d05180)) {
        if (is_in_array(player.var_14d05180, self)) {
            return;
        }
    } else {
        player.var_14d05180 = [];
    }
    if (!is_in_array(level.var_f79fd95e, player)) {
        level.var_f79fd95e[level.var_f79fd95e.size] = player;
    }
    player.var_14d05180[player.var_14d05180.size] = self;
    if (!level.var_37c189c6) {
        self function_d3451665();
    }
    function_fdef1a98();
    self function_ff06682f(player);
    isplayervalid = isdefined(player);
    if (isplayervalid) {
        arrayremovevalue(player.var_14d05180, self);
    }
    if (!isplayervalid || !player function_f5ab2041()) {
        level.var_f79fd95e = array::remove_undefined(level.var_f79fd95e);
        if (isplayervalid) {
            arrayremovevalue(level.var_f79fd95e, player);
        }
        if (level.var_f79fd95e.size == 0) {
            function_cd98cc78();
        }
    }
    function_1e5e33d2();
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_ff06682f
// Checksum 0xc3aff33e, Offset: 0x3b28
// Size: 0x94
function function_ff06682f(player) {
    player endon(#"disconnect");
    player endon(#"fake_death");
    player endon(#"death");
    level endon(#"hash_7e7d8ebc");
    while (self.trigger.var_77784065 != 0 && player istouching(self.trigger) && player.sessionstate != "spectator") {
        wait(0.1);
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_fdef1a98
// Checksum 0x1f8abc2b, Offset: 0x3bc8
// Size: 0xe4
function function_fdef1a98() {
    current = self;
    previous = current function_145e7850();
    next = current function_ce85b2f0();
    function_a840b984(previous);
    function_a840b984(current);
    function_a840b984(next);
    function_1af73138(previous);
    function_1af73138(current);
    function_1af73138(next);
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_1e5e33d2
// Checksum 0xdb8309e9, Offset: 0x3cb8
// Size: 0xe4
function function_1e5e33d2() {
    current = self;
    previous = current function_145e7850();
    next = current function_ce85b2f0();
    function_6db81c23(previous);
    function_6db81c23(current);
    function_6db81c23(next);
    function_b698255a(previous);
    function_b698255a(current);
    function_b698255a(next);
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_d92e1936
// Checksum 0x105359c1, Offset: 0x3da8
// Size: 0x234
function function_d92e1936(player) {
    player endon(#"death");
    player endon(#"fake_death");
    player endon(#"disconnect");
    player allowjump(0);
    if (isdefined(player.var_7fc81e41)) {
        if (is_in_array(player.var_7fc81e41, self)) {
            return;
        }
    } else {
        player.var_7fc81e41 = [];
    }
    if (!player function_de05038d()) {
        player allowsprint(0);
        player allowprone(0);
        player allowslide(0);
        player setmovespeedscale(0.35);
    }
    player.var_7fc81e41[player.var_7fc81e41.size] = self;
    while (self.var_77784065 == 0 && player istouching(self)) {
        wait(0.1);
    }
    arrayremovevalue(player.var_7fc81e41, self);
    if (!player function_de05038d()) {
        player allowjump(1);
        player allowsprint(1);
        player allowprone(1);
        player allowslide(1);
        player setmovespeedscale(1);
    }
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_b698255a
// Checksum 0xa8632b77, Offset: 0x3fe8
// Size: 0x86
function function_b698255a(var_4e4eb29) {
    if (!isdefined(var_4e4eb29)) {
        return;
    }
    for (i = 0; i < var_4e4eb29.walls.size; i++) {
        wall = var_4e4eb29.walls[i];
        wall thread function_babea22b(0);
    }
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_1af73138
// Checksum 0x72f22d4e, Offset: 0x4078
// Size: 0x1ae
function function_1af73138(var_4e4eb29) {
    if (!isdefined(var_4e4eb29)) {
        return;
    }
    previous = var_4e4eb29 function_145e7850();
    next = var_4e4eb29 function_ce85b2f0();
    var_8357009 = function_f1acee8c(previous, var_4e4eb29);
    var_ad25fd85 = function_f1acee8c(var_4e4eb29, next);
    for (i = 0; i < var_4e4eb29.walls.size; i++) {
        wall = var_4e4eb29.walls[i];
        var_983fce26 = 1;
        if (!isdefined(next) && (!isdefined(previous) && (isdefined(var_ad25fd85) && (isdefined(var_8357009) && wall == var_8357009 || wall == var_ad25fd85) || wall.var_f7339436.size == 1) || wall.var_f7339436.size == 1)) {
            var_983fce26 = 0;
        }
        wall thread function_babea22b(var_983fce26);
    }
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_a840b984
// Checksum 0xdf1965be, Offset: 0x4230
// Size: 0x64
function function_a840b984(var_93b1b42c) {
    if (isdefined(var_93b1b42c)) {
        var_93b1b42c.trigger.var_77784065++;
        var_93b1b42c.floor thread function_babea22b(1);
        level thread function_7ece465d(var_93b1b42c);
    }
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_7ece465d
// Checksum 0xca66184b, Offset: 0x42a0
// Size: 0xee
function function_7ece465d(var_93b1b42c) {
    bodies = getcorpsearray();
    for (i = 0; i < bodies.size; i++) {
        if (!isdefined(bodies[i])) {
            continue;
        }
        if (bodies[i] istouching(var_93b1b42c.trigger) || bodies[i] istouching(var_93b1b42c.floor)) {
            bodies[i] thread function_8b31a9a3();
            util::wait_network_frame();
        }
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_8b31a9a3
// Checksum 0x204a83ff, Offset: 0x4398
// Size: 0x5c
function function_8b31a9a3() {
    self endon(#"death");
    playfx(level._effect["animscript_gib_fx"], self.origin);
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_6db81c23
// Checksum 0xd4ae6023, Offset: 0x4400
// Size: 0x4c
function function_6db81c23(var_93b1b42c) {
    if (isdefined(var_93b1b42c)) {
        var_93b1b42c.trigger.var_77784065--;
        var_93b1b42c.floor thread function_babea22b(0);
    }
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_f1acee8c
// Checksum 0x5ea5e89a, Offset: 0x4458
// Size: 0xd8
function function_f1acee8c(a, b) {
    if (!isdefined(a) || !isdefined(b)) {
        return undefined;
    }
    for (i = 0; i < a.walls.size; i++) {
        for (j = 0; j < b.walls.size; j++) {
            if (a.walls[i] == b.walls[j]) {
                return a.walls[i];
            }
        }
    }
    return undefined;
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_70a99c48
// Checksum 0x40273d55, Offset: 0x4538
// Size: 0x4e
function function_70a99c48() {
    for (i = 0; i < level.var_3bf786b6.size; i++) {
        function_a840b984(level.var_3bf786b6[i]);
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_d3451665
// Checksum 0x3ff346c7, Offset: 0x4590
// Size: 0x8c
function function_d3451665() {
    level.var_37c189c6 = 1;
    for (i = 0; i < level.var_3bf786b6.size; i++) {
        function_6db81c23(level.var_3bf786b6[i]);
    }
    self function_e06265e0();
    level thread function_ab87cf90(10);
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_cd98cc78
// Checksum 0x44bc1800, Offset: 0x4628
// Size: 0x34
function function_cd98cc78() {
    level notify(#"hash_97bdf2e8");
    level.var_37c189c6 = 0;
    level thread function_d8d8cf9b();
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_d8d8cf9b
// Checksum 0x5641cffb, Offset: 0x4668
// Size: 0x24
function function_d8d8cf9b() {
    level endon(#"hash_b079c42c");
    wait(3);
    function_70a99c48();
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_ab87cf90
// Checksum 0x7ab7cb61, Offset: 0x4698
// Size: 0x94
function function_ab87cf90(time) {
    level endon(#"hash_97bdf2e8");
    level endon(#"hash_b079c42c");
    var_da4da445 = 3;
    wait(time - var_da4da445);
    level thread function_d3116f6();
    level thread function_acfe7539(var_da4da445);
    wait(var_da4da445);
    level notify(#"hash_7e7d8ebc");
    level thread function_fba14007();
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_fba14007
// Checksum 0xdbd45999, Offset: 0x4738
// Size: 0x12a
function function_fba14007() {
    util::wait_network_frame();
    zombies = getaiteamarray(level.zombie_team);
    for (i = 0; i < zombies.size; i++) {
        zombie = zombies[i];
        if (!isdefined(zombie)) {
            continue;
        }
        if (!isdefined(zombie.animname) || zombie.animname == "monkey_zombie") {
            continue;
        }
        if (zombie function_1116861d() || zombie function_ada6f91a()) {
            zombie notify(#"stop_find_flesh");
            zombie notify(#"zombie_acquire_enemy");
            util::wait_network_frame();
            zombie.ai_state = "find_flesh";
        }
    }
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_acfe7539
// Checksum 0x91b2b69b, Offset: 0x4870
// Size: 0x19c
function function_acfe7539(time) {
    level endon(#"hash_97bdf2e8");
    level endon(#"hash_b079c42c");
    endtime = gettime() + time * 1000;
    while (endtime > gettime()) {
        for (i = 0; i < level.var_3f3d042f.size; i++) {
            var_4e4eb29 = level.var_3f3d042f[i];
            if (var_4e4eb29.floor.isactive) {
                var_4e4eb29 thread function_5bde9883((endtime - gettime()) / 1000);
                players = getplayers();
                for (w = 0; w < players.size; w++) {
                    if (players[w] istouching(var_4e4eb29.trigger)) {
                        var_4e4eb29.trigger thread trigger::function_thread(players[w], &function_5a623a88, &function_fd2c1b16);
                    }
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_5a623a88
// Checksum 0xf621a88e, Offset: 0x4a18
// Size: 0x74
function function_5a623a88(player, endon_condition) {
    if (isdefined(endon_condition)) {
        player endon(endon_condition);
    }
    player clientfield::set_to_player("floorrumble", 1);
    util::wait_network_frame();
    self thread function_2ef0b760(player);
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_fd2c1b16
// Checksum 0xe4646f47, Offset: 0x4a98
// Size: 0x44
function function_fd2c1b16(player) {
    player endon(#"hash_a5b7f78");
    player clientfield::set_to_player("floorrumble", 0);
    player notify(#"hash_a5b7f78");
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_2ef0b760
// Checksum 0x917f4bd2, Offset: 0x4ae8
// Size: 0x11c
function function_2ef0b760(ent_player) {
    ent_player endon(#"hash_a5b7f78");
    var_e0fac42 = undefined;
    var_4c4845bd = getentarray("maze_floor", "targetname");
    for (i = 0; i < var_4c4845bd.size; i++) {
        if (var_4c4845bd[i].script_int == self.script_int) {
            var_e0fac42 = var_4c4845bd[i];
        }
    }
    while (isdefined(var_e0fac42) && var_e0fac42.isactive == 1) {
        wait(0.05);
    }
    if (isdefined(ent_player)) {
        ent_player clientfield::set_to_player("floorrumble", 0);
    }
    ent_player notify(#"hash_a5b7f78");
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_5bde9883
// Checksum 0xfb5a4b6f, Offset: 0x4c10
// Size: 0xd4
function function_5bde9883(time) {
    if (isdefined(self.var_2eb5c3df) && self.var_2eb5c3df) {
        return;
    }
    self.floor playsound("evt_maze_floor_collapse");
    self.var_2eb5c3df = 1;
    dir = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0);
    self.floor vibrate(dir, 0.75, 0.3, time);
    wait(time);
    self.var_2eb5c3df = 0;
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_d3116f6
// Checksum 0x84ad0f6b, Offset: 0x4cf0
// Size: 0x126
function function_d3116f6() {
    level util::waittill_any("maze_path_end", "maze_timer_end", "maze_all_safe");
    for (i = 0; i < level.var_3f3d042f.size; i++) {
        var_4e4eb29 = level.var_3f3d042f[i];
        if (isdefined(var_4e4eb29.var_2eb5c3df) && var_4e4eb29.var_2eb5c3df) {
            var_4e4eb29.floor vibrate((0, 0, 1), 1, 1, 0.05);
            var_4e4eb29.floor rotateto(var_4e4eb29.floor.startangles, 0.1);
            var_4e4eb29.floor stopsounds();
        }
    }
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_e06265e0
// Checksum 0xa5545057, Offset: 0x4e20
// Size: 0x134
function function_e06265e0() {
    level.var_bcbd525d = [];
    for (i = 0; i < level.var_3f3d042f.size; i++) {
        level.var_3f3d042f[i].pathindex = -1;
    }
    path_index = self function_d05ed463();
    path = level.var_a8d9929c[path_index].path;
    level.var_72e51a9f = path[0];
    level.var_96df1674 = path[path.size - 1];
    for (i = 0; i < path.size; i++) {
        level.var_bcbd525d[i] = level.var_3f3d042f[path[i]];
        level.var_bcbd525d[i].pathindex = i;
    }
    level.var_3330e4d3++;
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_d05ed463
// Checksum 0x5769542e, Offset: 0x4f60
// Size: 0x1f4
function function_d05ed463() {
    startindex = 0;
    for (i = 0; i < level.var_3f3d042f.size; i++) {
        if (level.var_3f3d042f[i] == self) {
            startindex = i;
            break;
        }
    }
    var_d78d8a31 = [];
    for (i = 0; i < level.var_a8d9929c.size; i++) {
        var_d78d8a31[i] = i;
    }
    var_d78d8a31 = array::randomize(var_d78d8a31);
    returnindex = -1;
    for (i = 0; i < var_d78d8a31.size; i++) {
        index = var_d78d8a31[i];
        path = level.var_a8d9929c[index].path;
        if (level.var_a8d9929c[index].loopback) {
            if (level.var_3330e4d3 < 3) {
                continue;
            }
            if (randomfloat(100) > 40) {
                continue;
            }
        }
        if (isdefined(level.var_72e51a9f) && isdefined(level.var_96df1674)) {
            if (level.var_72e51a9f == path[0] && level.var_96df1674 == path[path.size - 1]) {
                continue;
            }
        }
        if (startindex == path[0]) {
            returnindex = index;
            break;
        }
    }
    return returnindex;
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_ce85b2f0
// Checksum 0x2acca835, Offset: 0x5160
// Size: 0x48
function function_ce85b2f0() {
    index = self.pathindex;
    if (index < level.var_bcbd525d.size - 1) {
        return level.var_bcbd525d[index + 1];
    }
    return undefined;
}

// Namespace namespace_38b06d6b
// Params 0, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_145e7850
// Checksum 0x5dd35934, Offset: 0x51b0
// Size: 0x3c
function function_145e7850() {
    index = self.pathindex;
    if (index > 0) {
        return level.var_bcbd525d[index - 1];
    }
    return undefined;
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_b5ad6065
// Checksum 0x8deeeeea, Offset: 0x51f8
// Size: 0x44
function function_b5ad6065(entity) {
    self endon(#"death");
    self.var_1474da36 = 1;
    wait(1.25);
    self zombie_utility::setup_zombie_knockdown(entity);
}

// Namespace namespace_38b06d6b
// Params 2, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_76846f3d
// Checksum 0x3a438bc1, Offset: 0x5248
// Size: 0x9c
function override_thundergun_damage_func(player, gib) {
    var_24165e9c = struct::get("waterfall_dmg_point", "script_noteworthy");
    self.thundergun_handle_pain_notetracks = &function_27b81080;
    self dodamage(1, var_24165e9c.origin);
    self animcustom(&zm_weap_thundergun::playthundergunpainanim);
}

// Namespace namespace_38b06d6b
// Params 1, eflags: 0x1 linked
// namespace_38b06d6b<file_0>::function_27b81080
// Checksum 0x3d0337cf, Offset: 0x52f0
// Size: 0xc
function function_27b81080(note) {
    
}

