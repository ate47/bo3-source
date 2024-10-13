#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_portals;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/exploder_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/math_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_genesis_flingers;

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0xe649e65f, Offset: 0x828
// Size: 0xb4
function function_976c9217() {
    register_clientfields();
    zm::register_player_damage_callback(&function_4b3d145d);
    var_fa27add4 = struct::get_array("115_flinger_pad_aimer", "targetname");
    array::thread_all(var_fa27add4, &function_5ecbd7cb);
    level._effect["flinger_land_kill"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_kill_zmb";
    level thread function_4208db02();
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0xbea5c760, Offset: 0x8e8
// Size: 0x154
function register_clientfields() {
    clientfield::register("toplayer", "flinger_flying_postfx", 15000, 1, "int");
    clientfield::register("toplayer", "flinger_land_smash", 15000, 1, "counter");
    clientfield::register("toplayer", "flinger_cooldown_start", 15000, 4, "int");
    clientfield::register("toplayer", "flinger_cooldown_end", 15000, 4, "int");
    clientfield::register("scriptmover", "player_visibility", 15000, 1, "int");
    clientfield::register("scriptmover", "flinger_launch_fx", 15000, 1, "counter");
    clientfield::register("scriptmover", "flinger_pad_active_fx", 15000, 4, "int");
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0x5ea007bb, Offset: 0xa48
// Size: 0x460
function function_5ecbd7cb() {
    level waittill(#"start_zombie_round_logic");
    var_845e036a = getent(self.target, "targetname");
    vol_fling = getent(var_845e036a.target, "targetname");
    var_cec95fd7 = struct::get(self.target, "targetname");
    var_cec95fd7 thread function_86ef1da5();
    v_fling = anglestoforward(self.angles) * self.script_int;
    var_845e036a clientfield::set("flinger_pad_active_fx", level.var_6ad55648[var_845e036a.targetname]["ready"]);
    s_unitrigger_stub = self zm_unitrigger::create_unitrigger("", 50, &function_485001bf, &function_4029cf56, "unitrigger_radius");
    s_unitrigger_stub.angles = (0, 0, 0);
    s_unitrigger_stub.hint_parm1 = 0;
    s_unitrigger_stub.script_string = vol_fling.script_string;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger_stub, 1);
    var_3432399a = var_845e036a.target + "_spline";
    nd_start = getvehiclenode(var_3432399a, "targetname");
    while (true) {
        e_who = s_unitrigger_stub waittill(#"trigger");
        if (isdefined(e_who.var_8dbb72b1) && e_who.var_8dbb72b1[vol_fling.script_string] === 1) {
            e_who zm_audio::create_and_play_dialog("general", "transport_deny");
            continue;
        }
        level.var_6fe80781 = gettime();
        n_timer = 0;
        vol_fling playsound("zmb_fling_activate");
        while (n_timer <= 3) {
            a_ai_zombies = zombie_utility::get_zombie_array();
            a_ai_zombies = function_3dcd0982(a_ai_zombies, vol_fling);
            if (a_ai_zombies.size) {
                foreach (ai_zombie in a_ai_zombies) {
                    if (math::cointoss()) {
                        ai_zombie thread function_e9d3c391(vol_fling, v_fling, nd_start);
                    }
                }
            } else {
                var_7092e170 = function_3dcd0982(level.activeplayers, vol_fling);
                array::thread_all(var_7092e170, &function_e9d3c391, vol_fling, v_fling, nd_start, var_845e036a);
            }
            n_timer += 0.1;
            wait 0.1;
        }
    }
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x0
// Checksum 0xfb4db389, Offset: 0xeb0
// Size: 0x60
function function_c54cd556() {
    self endon(#"kill_trigger");
    self.stub thread function_c1947ff7();
    while (true) {
        var_4161ad80 = self waittill(#"trigger");
        self.stub notify(#"trigger", var_4161ad80);
    }
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0x4dd59b9b, Offset: 0xf18
// Size: 0x1c
function function_c1947ff7() {
    self zm_unitrigger::run_visibility_function_for_all_triggers();
}

// Namespace zm_genesis_flingers
// Params 2, eflags: 0x1 linked
// Checksum 0x45b8f97, Offset: 0xf40
// Size: 0x42
function function_3dcd0982(&array, var_8d88ae81) {
    return array::filter(array, 0, &function_a78c631a, var_8d88ae81);
}

// Namespace zm_genesis_flingers
// Params 2, eflags: 0x1 linked
// Checksum 0x584785f3, Offset: 0xf90
// Size: 0x6a
function function_a78c631a(val, var_8d88ae81) {
    return isalive(val) && !(isdefined(val.is_flung) && val.is_flung) && val istouching(var_8d88ae81);
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0x8804116, Offset: 0x1008
// Size: 0x120
function function_86ef1da5() {
    while (true) {
        foreach (e_player in level.activeplayers) {
            if (zombie_utility::is_player_valid(e_player) && distance(e_player.origin, self.origin) <= 525 && e_player util::is_looking_at(self.origin, 0.85, 0)) {
                self thread scene::play(self.scriptbundlename);
                return;
            }
        }
        wait 0.25;
    }
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0x2bc9bfbf, Offset: 0x1130
// Size: 0x28
function function_149a5187() {
    self endon(#"hash_13bf4db7");
    level waittill(#"end_game");
    self.var_3048ac6d = 1;
}

// Namespace zm_genesis_flingers
// Params 4, eflags: 0x1 linked
// Checksum 0x878e428, Offset: 0x1160
// Size: 0xb56
function function_e9d3c391(var_a89f74ed, v_fling, nd_start, var_173065cc) {
    self endon(#"death");
    if (isdefined(self.var_8dbb72b1) && (isdefined(self.is_flung) && self.is_flung || self.var_8dbb72b1[var_a89f74ed.script_string] === 1)) {
        return;
    }
    if (isplayer(self)) {
        self thread function_149a5187();
        self.b_invulnerable = self enableinvulnerability();
        self.var_fa1ecd39 = self.origin;
        self.is_flung = 1;
        if (!self laststand::player_is_in_laststand() && !self inlaststand()) {
            self allowcrouch(0);
            self allowprone(0);
            self allowstand(1);
        }
        self disableoffhandweapons();
        self notsolid();
        self notify(var_173065cc.target);
        if (self getstance() != "stand") {
            self setstance("stand");
        }
        self playsound("zmb_fling_fly");
        var_413ea50f = vehicle::spawn(undefined, "player_vehicle", "flinger_vehicle", nd_start.origin, nd_start.angles);
        self playerlinktodelta(var_413ea50f);
        a_ai_enemies = getaiteamarray("axis");
        a_ai_enemies = arraysort(a_ai_enemies, nd_start.origin, 1, 99, 768);
        array::thread_all(a_ai_enemies, &function_7807150a);
        self thread function_44659337(nd_start, var_a89f74ed, v_fling);
        self playrumbleonentity("zm_castle_flinger_launch");
        self clientfield::set_to_player("flinger_flying_postfx", 1);
        self thread function_c1f1756a();
        if (isdefined(var_173065cc)) {
            var_173065cc clientfield::increment("flinger_launch_fx");
            exploder::exploder(level.var_6ad55648[var_173065cc.targetname]["launch"]);
        }
        var_6a7beeb2 = function_cbac68fe(self);
        var_6a7beeb2 linkto(var_413ea50f);
        w_current = self.currentweapon;
        if (w_current != level.weaponnone) {
            var_f5434f17 = zm_utility::spawn_buildkit_weapon_model(self, w_current, undefined, var_6a7beeb2 gettagorigin("tag_weapon_right"), var_6a7beeb2 gettagangles("tag_weapon_right"));
            var_f5434f17 linkto(var_6a7beeb2, "tag_weapon_right");
            var_f5434f17 setowner(self);
        }
        var_6a7beeb2 thread scene::play("cin_zm_dlc1_jump_pad_air_loop", var_6a7beeb2);
        var_6a7beeb2 clientfield::set("player_visibility", 1);
        var_f5434f17 clientfield::set("player_visibility", 1);
        self ghost();
        self thread function_b19e2d45(var_a89f74ed);
        switch (var_a89f74ed.script_noteworthy) {
        case "upper_courtyard_landing_pad11":
        case "upper_courtyard_landing_pad8":
            self zm_genesis_portals::function_eec1f014("start", 2, 1);
            break;
        case "upper_courtyard_landing_pad12":
        case "upper_courtyard_landing_pad3":
            self zm_genesis_portals::function_eec1f014("temple", 8, 1);
            break;
        case "upper_courtyard_landing_pad5":
        case "upper_courtyard_landing_pad7":
            self zm_genesis_portals::function_eec1f014("prison", 4, 1);
            break;
        case "upper_courtyard_landing_pad4":
        case "upper_courtyard_landing_pad6":
            self zm_genesis_portals::function_eec1f014("asylum", 6, 1);
            break;
        }
        var_413ea50f setignorepauseworld(1);
        var_413ea50f attachpath(nd_start);
        var_413ea50f startpath();
        var_413ea50f waittill(#"reached_end_node");
        self thread function_3298b25f(var_a89f74ed);
        self thread function_29c06608();
        self playrumbleonentity("zm_castle_flinger_land");
        self clientfield::set_to_player("flinger_flying_postfx", 0);
        var_6a7beeb2 clientfield::set("player_visibility", 0);
        if (isdefined(var_f5434f17)) {
            var_f5434f17 clientfield::set("player_visibility", 0);
        }
        var_6a7beeb2 thread scene::stop("cin_zm_dlc1_jump_pad_air_loop");
        if (isdefined(var_f5434f17)) {
            var_f5434f17 delete();
        }
        self show();
        self solid();
        self thread function_9f131b98();
        if (!self laststand::player_is_in_laststand()) {
            self allowcrouch(1);
            self allowprone(1);
        }
        self playsound("zmb_fling_land");
        var_6a7beeb2 hide();
        util::wait_network_frame();
        var_6a7beeb2 delete();
        self enableoffhandweapons();
        self notify(#"hash_13bf4db7");
        self thread function_e905a9df(var_a89f74ed, var_173065cc);
        self thread function_2c36a1ea(var_413ea50f);
        return;
    }
    if (self.isdog) {
        self kill();
        return;
    }
    if (self.archetype === "zombie") {
        self.is_flung = 1;
        self pathmode("dont move");
        self setplayercollision(0);
        self.mdl_anchor = util::spawn_model("tag_origin", nd_start.origin, nd_start.angles);
        self linkto(self.mdl_anchor);
        nd_next = getvehiclenode(nd_start.target, "targetname");
        n_distance = distance(nd_start.origin, nd_next.origin);
        n_time = n_distance / 600;
        self.mdl_anchor moveto(nd_next.origin, n_time);
        self.mdl_anchor waittill(#"movedone");
        self unlink();
        self pathmode("dont move");
        self startragdoll();
        self launchragdoll(v_fling * randomfloatrange(0.17, 0.21));
        util::wait_network_frame();
        self dodamage(self.health, self.origin);
        level.zombie_total++;
        while (self istouching(var_a89f74ed)) {
            wait 0.1;
        }
        self.is_flung = undefined;
    }
}

// Namespace zm_genesis_flingers
// Params 1, eflags: 0x1 linked
// Checksum 0x36a07229, Offset: 0x1cc0
// Size: 0x64
function function_2c36a1ea(var_413ea50f) {
    while (true) {
        if (isdefined(self.var_3298b25f) && (!isdefined(self) || self.var_3298b25f)) {
            break;
        }
        util::wait_network_frame();
    }
    var_413ea50f delete();
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0xe1dc38a1, Offset: 0x1d30
// Size: 0x4c
function function_9f131b98() {
    if (isdefined(self.b_invulnerable) && self.b_invulnerable) {
        self.b_invulnerable = undefined;
        return;
    }
    wait 0.5;
    self disableinvulnerability();
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0xc453f49, Offset: 0x1d88
// Size: 0x72
function function_7807150a() {
    if (!(isdefined(self.b_ignore_cleanup) && self.b_ignore_cleanup)) {
        self notify(#"hash_450c36af");
        self endon(#"death");
        self endon(#"hash_450c36af");
        self.b_ignore_cleanup = 1;
        self.var_b6b1080c = 1;
        wait 10;
        self.b_ignore_cleanup = undefined;
        self.var_b6b1080c = undefined;
    }
}

// Namespace zm_genesis_flingers
// Params 2, eflags: 0x1 linked
// Checksum 0x47f923e8, Offset: 0x1e08
// Size: 0xce
function function_e905a9df(var_a89f74ed, var_173065cc) {
    self endon(#"death");
    self.var_8dbb72b1[var_a89f74ed.script_string] = 1;
    self clientfield::set_to_player("flinger_cooldown_start", level.var_6ad55648[var_173065cc.targetname]["ready"]);
    wait 15;
    self clientfield::set_to_player("flinger_cooldown_end", level.var_6ad55648[var_173065cc.targetname]["ready"]);
    self.var_8dbb72b1[var_a89f74ed.script_string] = 0;
}

// Namespace zm_genesis_flingers
// Params 1, eflags: 0x1 linked
// Checksum 0x8d01a657, Offset: 0x1ee0
// Size: 0x1e0
function function_cbac68fe(e_player) {
    var_629f4b8 = spawn("script_model", e_player.origin);
    var_629f4b8.angles = e_player.angles;
    mdl_body = e_player getcharacterbodymodel();
    var_629f4b8 setmodel(mdl_body);
    if (isdefined(e_player.var_bc5f242a) && isdefined(e_player.var_bc5f242a.str_model)) {
        str_model = e_player.var_bc5f242a.str_model;
        str_tag = e_player.var_bc5f242a.str_tag;
        var_629f4b8 attach(str_model, str_tag);
    }
    var_6f30937d = e_player getcharacterbodyrenderoptions();
    var_629f4b8 setbodyrenderoptions(var_6f30937d, var_6f30937d, var_6f30937d);
    var_629f4b8.health = 100;
    var_629f4b8 setowner(e_player);
    var_629f4b8.team = e_player.team;
    var_629f4b8 solid();
    return var_629f4b8;
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0x4a9887ad, Offset: 0x20c8
// Size: 0x48
function function_c1f1756a() {
    while (isdefined(self.is_flung) && self.is_flung) {
        self playrumbleonentity("zod_beast_grapple_reel");
        wait 0.2;
    }
}

// Namespace zm_genesis_flingers
// Params 1, eflags: 0x1 linked
// Checksum 0xaa9797f7, Offset: 0x2118
// Size: 0x1e0
function function_3298b25f(var_a89f74ed) {
    self endon(#"death");
    self.var_3298b25f = 0;
    var_a7d28374 = 0;
    var_a05a47c7 = var_a89f74ed function_fbd80603();
    for (var_16f5c370 = var_a05a47c7.origin; positionwouldtelefrag(var_16f5c370); var_16f5c370 = var_a05a47c7.origin + (randomfloatrange(-24, 24), randomfloatrange(-24, 24), 0)) {
        util::wait_network_frame();
        var_a7d28374++;
        if (var_a7d28374 > 4) {
            var_a05a47c7 = var_a89f74ed function_fbd80603(1);
            var_16f5c370 = var_a05a47c7.origin;
            continue;
        }
    }
    self unlink();
    self setorigin(var_16f5c370);
    if (isdefined(self.var_3048ac6d) && self.var_3048ac6d) {
        self freezecontrols(1);
    }
    self clientfield::increment_to_player("flinger_land_smash");
    self.is_flung = undefined;
    wait 3;
    var_a05a47c7.occupied = undefined;
    self.var_3298b25f = 1;
}

// Namespace zm_genesis_flingers
// Params 1, eflags: 0x1 linked
// Checksum 0xf39b2e93, Offset: 0x2300
// Size: 0x21e
function function_fbd80603(b_random) {
    if (!isdefined(b_random)) {
        b_random = 0;
    }
    var_2b58409e = struct::get(self.script_noteworthy, "targetname");
    assert(isdefined(var_2b58409e), "<dev string:x28>" + self.script_noteworthy);
    a_s_spots = struct::get_array(var_2b58409e.target, "targetname");
    array::add(a_s_spots, var_2b58409e, 0);
    for (i = 0; i < a_s_spots.size; i++) {
        for (j = i; j < a_s_spots.size; j++) {
            if (a_s_spots[j].script_int < a_s_spots[i].script_int) {
                temp = a_s_spots[i];
                a_s_spots[i] = a_s_spots[j];
                a_s_spots[j] = temp;
            }
        }
    }
    if (b_random) {
        return array::random(a_s_spots);
    }
    for (i = 0; i < a_s_spots.size; i++) {
        if (!(isdefined(a_s_spots[i].occupied) && a_s_spots[i].occupied)) {
            a_s_spots[i].occupied = 1;
            return a_s_spots[i];
        }
    }
}

// Namespace zm_genesis_flingers
// Params 1, eflags: 0x1 linked
// Checksum 0xba2b35b, Offset: 0x2528
// Size: 0xc0
function function_b19e2d45(var_a89f74ed) {
    var_2b58409e = struct::get(var_a89f74ed.script_noteworthy, "targetname");
    str_zone = zm_zonemgr::get_zone_from_position(var_2b58409e.origin + (0, 0, 32), 1);
    while (isdefined(self.is_flung) && self.is_flung) {
        level.zones[str_zone].is_active = 1;
        wait 0.1;
    }
}

// Namespace zm_genesis_flingers
// Params 3, eflags: 0x1 linked
// Checksum 0xfc010e23, Offset: 0x25f0
// Size: 0xa4
function function_44659337(nd_target, var_a89f74ed, v_fling) {
    a_ai = getaiteamarray(level.zombie_team);
    var_1152223f = arraysortclosest(a_ai, nd_target.origin, a_ai.size, 0, 512);
    array::thread_all(var_1152223f, &function_1a4837ab, nd_target, self, var_a89f74ed, v_fling);
}

// Namespace zm_genesis_flingers
// Params 4, eflags: 0x1 linked
// Checksum 0x35bc5eba, Offset: 0x26a0
// Size: 0x23c
function function_1a4837ab(nd_target, e_target, var_a89f74ed, v_fling) {
    self endon(#"death");
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
        return;
    }
    var_c95b4513 = [];
    for (i = 0; i < level.activeplayers.size; i++) {
        if (level.activeplayers[i] != e_target) {
            array::add(var_c95b4513, level.activeplayers[i]);
        }
    }
    var_57cf6f70 = arraysortclosest(var_c95b4513, self.origin, var_c95b4513.size, 0, 512);
    if (var_57cf6f70.size) {
        return;
    }
    if (self.archetype === "zombie" && self.ai_state === "zombie_think") {
        self.ignoreall = 1;
        self setgoal(nd_target.origin, 1);
        n_start_time = gettime();
        self util::waittill_any_timeout(6, "goal", "death");
        self.ignoreall = 0;
        n_end_time = gettime();
        n_total_time = (n_end_time - n_start_time) / 1000;
        if (!(isdefined(self.is_flung) && self.is_flung) && n_total_time < 6) {
            var_8643fc8a = randomint(100);
            if (var_8643fc8a < 25) {
                self thread function_e9d3c391(var_a89f74ed, v_fling, nd_target);
            }
        }
    }
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0x2894a173, Offset: 0x28e8
// Size: 0x2c2
function function_29c06608() {
    a_ai = getaiteamarray(level.zombie_team);
    var_5e3331b2 = arraysortclosest(a_ai, self.origin, a_ai.size, 0, -128);
    foreach (ai_zombie in var_5e3331b2) {
        if (ai_zombie.archetype === "zombie") {
            playfx(level._effect["beast_return_aoe_kill"], ai_zombie gettagorigin("j_spineupper"));
            ai_zombie.marked_for_recycle = 1;
            ai_zombie.has_been_damaged_by_player = 0;
            ai_zombie.deathpoints_already_given = 1;
            ai_zombie.no_powerups = 1;
            ai_zombie dodamage(ai_zombie.health + 1000, ai_zombie.origin, self);
            arrayremovevalue(a_ai, ai_zombie);
        }
    }
    util::wait_network_frame();
    var_1317e1d1 = arraysortclosest(a_ai, self.origin, a_ai.size, 0, -56);
    foreach (ai_zombie in var_1317e1d1) {
        if (isalive(ai_zombie) && ai_zombie.archetype === "zombie") {
            self thread zombie_slam_direction(ai_zombie);
        }
    }
}

// Namespace zm_genesis_flingers
// Params 1, eflags: 0x1 linked
// Checksum 0x54d70c0e, Offset: 0x2bb8
// Size: 0x2ac
function zombie_slam_direction(ai_zombie) {
    ai_zombie.knockdown = 1;
    var_f5ed5b7e = self.origin - ai_zombie.origin;
    var_17e60e9b = vectornormalize((var_f5ed5b7e[0], var_f5ed5b7e[1], 0));
    var_45ef6cd0 = anglestoforward(ai_zombie.angles);
    var_810df61 = vectornormalize((var_45ef6cd0[0], var_45ef6cd0[1], 0));
    var_e502452d = anglestoright(ai_zombie.angles);
    var_4733d782 = vectornormalize((var_e502452d[0], var_e502452d[1], 0));
    var_8bb8fa69 = vectordot(var_17e60e9b, var_810df61);
    if (var_8bb8fa69 >= 0.5) {
        ai_zombie.knockdown_direction = "front";
        ai_zombie.getup_direction = "getup_back";
    } else if (var_8bb8fa69 < 0.5 && var_8bb8fa69 > -0.5) {
        var_8bb8fa69 = vectordot(var_17e60e9b, var_4733d782);
        if (var_8bb8fa69 > 0) {
            ai_zombie.knockdown_direction = "right";
            if (math::cointoss()) {
                ai_zombie.getup_direction = "getup_back";
            } else {
                ai_zombie.getup_direction = "getup_belly";
            }
        } else {
            ai_zombie.knockdown_direction = "left";
            ai_zombie.getup_direction = "getup_belly";
        }
    } else {
        ai_zombie.knockdown_direction = "back";
        ai_zombie.getup_direction = "getup_belly";
    }
    wait 1;
    ai_zombie.knockdown = 0;
}

// Namespace zm_genesis_flingers
// Params 11, eflags: 0x1 linked
// Checksum 0x380c8d5c, Offset: 0x2e70
// Size: 0x80
function function_4b3d145d(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    if (isdefined(self.is_flung) && self.is_flung) {
        return 0;
    }
    return -1;
}

// Namespace zm_genesis_flingers
// Params 1, eflags: 0x1 linked
// Checksum 0x28d8a014, Offset: 0x2ef8
// Size: 0x6c
function function_485001bf(e_player) {
    if (isdefined(e_player.var_8dbb72b1) && e_player.var_8dbb72b1[self.stub.script_string] === 1) {
        self sethintstring(%ZM_GENESIS_JUMP_PAD_COOLDOWN);
        return false;
    }
    return true;
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0x41c236e5, Offset: 0x2f70
// Size: 0x60
function function_4029cf56() {
    self endon(#"kill_trigger");
    self.stub thread zm_unitrigger::run_visibility_function_for_all_triggers();
    while (true) {
        var_4161ad80 = self waittill(#"trigger");
        self.stub notify(#"trigger", var_4161ad80);
    }
}

// Namespace zm_genesis_flingers
// Params 0, eflags: 0x1 linked
// Checksum 0xd0f69322, Offset: 0x2fd8
// Size: 0x2d4
function function_4208db02() {
    level.var_6ad55648 = [];
    level.var_6ad55648["upper_courtyard_flinger_base3"] = [];
    level.var_6ad55648["upper_courtyard_flinger_base4"] = [];
    level.var_6ad55648["upper_courtyard_flinger_base5"] = [];
    level.var_6ad55648["upper_courtyard_flinger_base6"] = [];
    level.var_6ad55648["upper_courtyard_flinger_base7"] = [];
    level.var_6ad55648["upper_courtyard_flinger_base8"] = [];
    level.var_6ad55648["upper_courtyard_flinger_base11"] = [];
    level.var_6ad55648["upper_courtyard_flinger_base12"] = [];
    level.var_6ad55648["upper_courtyard_flinger_base7"]["launch"] = "fxexp_250";
    level.var_6ad55648["upper_courtyard_flinger_base7"]["ready"] = 1;
    level.var_6ad55648["upper_courtyard_flinger_base12"]["launch"] = "fxexp_251";
    level.var_6ad55648["upper_courtyard_flinger_base12"]["ready"] = 2;
    level.var_6ad55648["upper_courtyard_flinger_base11"]["launch"] = "fxexp_252";
    level.var_6ad55648["upper_courtyard_flinger_base11"]["ready"] = 3;
    level.var_6ad55648["upper_courtyard_flinger_base4"]["launch"] = "fxexp_253";
    level.var_6ad55648["upper_courtyard_flinger_base4"]["ready"] = 4;
    level.var_6ad55648["upper_courtyard_flinger_base8"]["launch"] = "fxexp_257";
    level.var_6ad55648["upper_courtyard_flinger_base8"]["ready"] = 8;
    level.var_6ad55648["upper_courtyard_flinger_base6"]["launch"] = "fxexp_256";
    level.var_6ad55648["upper_courtyard_flinger_base6"]["ready"] = 7;
    level.var_6ad55648["upper_courtyard_flinger_base5"]["launch"] = "fxexp_255";
    level.var_6ad55648["upper_courtyard_flinger_base5"]["ready"] = 6;
    level.var_6ad55648["upper_courtyard_flinger_base3"]["launch"] = "fxexp_254";
    level.var_6ad55648["upper_courtyard_flinger_base3"]["ready"] = 5;
}

