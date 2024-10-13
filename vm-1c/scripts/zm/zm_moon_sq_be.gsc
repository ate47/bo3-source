#using scripts/zm/zm_moon_sq;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/_zm_weap_quantum_bomb;
#using scripts/zm/_zm_weap_microwavegun;
#using scripts/zm/_zm_weap_black_hole_bomb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace zm_moon_sq_be;

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0xe5c1979e, Offset: 0x560
// Size: 0x2dc
function init() {
    level.var_b1016b52 = struct::get("struct_motivation", "targetname");
    assert(isdefined(level.var_b1016b52.name));
    if (!isdefined(level.var_b1016b52)) {
        println("<dev string:x28>");
        return;
    }
    level.var_8ccd5fae = strtok(level.var_b1016b52.script_parameters, ",");
    for (i = 0; i < level.var_8ccd5fae.size; i++) {
        level flag::init(level.var_8ccd5fae[i]);
    }
    level.var_8731d8b = strtok(level.var_b1016b52.script_flag, ",");
    for (j = 0; j < level.var_8731d8b.size; j++) {
        if (!level flag::exists(level.var_8731d8b[j])) {
            level flag::init(level.var_8731d8b[j]);
        }
    }
    level.var_dab9c24c = strtok(level.var_b1016b52.script_string, ",");
    level.var_831f6c80 = getentarray("zombie_door_airlock", "script_noteworthy");
    level.var_831f6c80 = arraycombine(level.var_831f6c80, getentarray("zombie_door", "targetname"), 0, 0);
    level.var_92a9a44e = 12;
    namespace_6e97c459::function_5a90ed82("be", "stage_one", &function_8377a7d8, &function_8765df76, &function_15345222);
    namespace_6e97c459::function_5a90ed82("be", "stage_two", &function_f57f1713, &function_6163650d, &function_ef31d7b9);
}

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x848
// Size: 0x4
function function_f57f1713() {
    
}

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0x227eaff0, Offset: 0x858
// Size: 0x354
function function_6163650d() {
    org = level.var_8894208b.origin;
    angles = level.var_8894208b.angles;
    exploder::exploder("fxexp_405");
    level.var_8894208b playsound("evt_be_insert");
    level.var_8894208b stopanimscripted();
    level.var_8894208b unlink();
    level.var_8894208b dontinterpolate();
    level.var_8894208b.origin = org;
    level.var_8894208b.angles = angles;
    level.var_8894208b thread function_d6777dd1();
    if (isdefined(level.var_aff8cada)) {
        level.var_aff8cada delete();
    }
    if (isdefined(level.var_65dcdcc)) {
        level.var_65dcdcc stopanimscripted();
        level.var_65dcdcc delete();
    }
    namespace_ddd35ff::function_f2df781b("be2", undefined, 100, &function_ba1a1d8a);
    level.var_d39257a8 = level.var_8894208b.origin;
    level waittill(#"hash_ba1a1d8a");
    namespace_ddd35ff::function_f94f76f0("be2");
    s = struct::get("be2_pos", "targetname");
    level.var_8894208b dontinterpolate();
    level.var_8894208b.origin = s.origin;
    level.var_9c483a19 = spawn("trigger_radius", s.origin + (0, 0, -70), 0, 125, 100);
    level.var_5fc80ad9 = &function_1e3d1509;
    level waittill(#"hash_fcd3e3f2");
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "quest8", 2);
    level.var_5fc80ad9 = undefined;
    level.var_8894208b delete();
    level.var_8894208b = undefined;
    namespace_6e97c459::function_2f3ced1f("be", "stage_two");
}

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0x27a767b9, Offset: 0xbb8
// Size: 0xe4
function function_d6777dd1() {
    level endon(#"hash_ba1a1d8a");
    self endon(#"death");
    wait 25;
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (distancesquared(players[i].origin, self.origin) <= 62500) {
                players[i] thread zm_audio::create_and_play_dialog("eggs", "quest8", 0);
                return;
            }
        }
        wait 0.5;
    }
}

// Namespace zm_moon_sq_be
// Params 3, eflags: 0x1 linked
// Checksum 0x7716a381, Offset: 0xca8
// Size: 0x94
function function_1e3d1509(grenade, model, info) {
    if (isdefined(level.var_9c483a19) && grenade istouching(level.var_9c483a19)) {
        level.var_8894208b clientfield::set("toggle_black_hole_deployed", 1);
        level thread function_50560fe8(grenade, level.var_8894208b);
        return true;
    }
    return false;
}

// Namespace zm_moon_sq_be
// Params 2, eflags: 0x1 linked
// Checksum 0x2a3e970c, Offset: 0xd48
// Size: 0x1ea
function function_50560fe8(grenade, model) {
    level.var_9c483a19 delete();
    level.var_9c483a19 = undefined;
    wait 1;
    time = 3;
    model moveto(grenade.origin + (0, 0, 50), time, time - 0.05);
    wait time;
    var_306ceb83 = struct::get_array("vista_rocket", "targetname");
    model ghost();
    playsoundatposition("zmb_gersh_teleporter_out", grenade.origin + (0, 0, 50));
    wait 0.5;
    model stoploopsound(1);
    wait 0.5;
    for (i = 0; i < var_306ceb83.size; i++) {
        playfx(level._effect["black_hole_bomb_event_horizon"], var_306ceb83[i].origin + (0, 0, 2500));
    }
    model playsound("zmb_gersh_teleporter_go");
    wait 2;
    level notify(#"hash_fcd3e3f2");
}

// Namespace zm_moon_sq_be
// Params 1, eflags: 0x1 linked
// Checksum 0x5549dee5, Offset: 0xf40
// Size: 0x44
function function_ba1a1d8a(position) {
    if (distancesquared(level.var_d39257a8, position) < 26896) {
        level notify(#"hash_ba1a1d8a");
    }
    return false;
}

// Namespace zm_moon_sq_be
// Params 1, eflags: 0x1 linked
// Checksum 0x2457e2f, Offset: 0xf90
// Size: 0x2c
function function_ef31d7b9(success) {
    level flag::set("be2");
}

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0x3272d2af, Offset: 0xfc8
// Size: 0x1c
function function_8377a7d8() {
    level thread function_c247b014();
}

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0xcd2edc94, Offset: 0xff0
// Size: 0x94
function function_8765df76() {
    level flag::wait_till("complete_be_1");
    level.var_8894208b playsound("evt_be_insert");
    exploder::exploder("fxexp_405");
    level thread function_211c5741(6);
    namespace_6e97c459::function_2f3ced1f("be", "stage_one");
}

// Namespace zm_moon_sq_be
// Params 1, eflags: 0x1 linked
// Checksum 0xe51d31b1, Offset: 0x1090
// Size: 0xc
function function_15345222(success) {
    
}

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0xdb2fc40d, Offset: 0x10a8
// Size: 0xac
function function_c247b014() {
    level endon(#"end_game");
    while (!level flag::get(level.var_8731d8b[0])) {
        if (level flag::get("teleporter_breached") && !level flag::get("teleporter_blocked")) {
            level flag::set(level.var_8731d8b[0]);
        }
        wait 0.1;
    }
    level thread function_6ccabece();
}

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0x3d171c6a, Offset: 0x1160
// Size: 0x46c
function function_6ccabece() {
    start = struct::get("struct_be_start", "targetname");
    var_4d89e942 = getvehiclenode("vs_stage_1a", "targetname");
    level.var_e9ab794e = 0;
    if (!isdefined(var_4d89e942)) {
        println("<dev string:x44>");
        wait 1;
        return;
    }
    level.var_8894208b = util::spawn_model("p7_zm_moo_egg_black", var_4d89e942.origin, var_4d89e942.angles);
    level.var_8894208b notsolid();
    level.var_8894208b useanimtree(#generic);
    level.var_8894208b.animname = "_be_";
    level.var_8894208b playloopsound("evt_sq_blackegg_loop", 1);
    level.var_8894208b.stopped = 0;
    level.var_8894208b thread function_36b79119();
    origin_animate = util::spawn_model("tag_origin_animate", level.var_8894208b.origin);
    level.var_8894208b linkto(origin_animate, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
    level.var_aff8cada = spawnvehicle("misc_freefall", var_4d89e942.origin, var_4d89e942.angles, "be_mover");
    level.var_aff8cada.var_e3302a4d = level.var_8894208b;
    level.var_aff8cada.var_a6915140 = origin_animate;
    origin_animate linkto(level.var_aff8cada);
    level.var_65dcdcc = origin_animate;
    level.var_aff8cada attachpath(var_4d89e942);
    var_476a0c04 = spawn("trigger_damage", level.var_aff8cada.origin, 0, 32, 72);
    for (start = 0; !start; start = 1) {
        amount, attacker, direction, point, var_e5f012d6, modelname, tagname = var_476a0c04 waittill(#"damage");
        if (isplayer(attacker) && function_5480bbe2(var_4d89e942.script_string)) {
            if (function_5480bbe2(var_e5f012d6)) {
                level.var_8894208b playsound("evt_sq_blackegg_activate");
                attacker thread function_1bd9f9d1(1);
            }
        }
    }
    var_476a0c04 delete();
    level.var_8894208b animscripted("spin", level.var_8894208b.origin, level.var_8894208b.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
    level.var_aff8cada thread function_68ae41fb();
    level.var_aff8cada startpath();
}

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0x7fae5ea0, Offset: 0x15d8
// Size: 0xaf8
function function_68ae41fb() {
    self endon(#"death");
    self endon(#"hash_45c41813");
    self endon(#"hash_f8879f31");
    var_4ad253a5 = 2;
    var_75916bdb = undefined;
    while (isdefined(self)) {
        node = self waittill(#"reached_node");
        if (level.var_e9ab794e) {
            var_a8015c01 = getvehiclenode(node.target, "targetname");
            node = var_a8015c01;
        }
        if (isdefined(node.script_sound)) {
            level.var_8894208b playsound(node.script_sound);
        }
        if (isdefined(node.script_flag)) {
            level flag::set(node.script_flag);
        }
        if (isdefined(node.script_string)) {
            self setspeedimmediate(0);
            level.var_8894208b playsound("evt_sq_blackegg_stop");
            self thread function_33193ba7();
            var_476a0c04 = spawn("trigger_damage", self.origin, 0, 32, 72);
            var_15afc6ad = 0;
            while (!var_15afc6ad) {
                if (isdefined(node.script_string) && node.script_string == "zap") {
                    namespace_1a0051d2::function_d4224082(var_476a0c04);
                    var_75916bdb = var_476a0c04 waittill(#"hash_d26ed760");
                    namespace_1a0051d2::function_1ef3ad2b(var_476a0c04);
                    var_15afc6ad = 1;
                } else {
                    amount, attacker, direction, point, var_e5f012d6, modelname, tagname = var_476a0c04 waittill(#"damage");
                    if (isplayer(attacker) && function_5480bbe2(node.script_string)) {
                        var_15afc6ad = function_5480bbe2(var_e5f012d6);
                        var_75916bdb = attacker;
                    }
                }
                self solid();
                wait 0.05;
            }
            if (isdefined(var_75916bdb)) {
                var_75916bdb thread function_1bd9f9d1(var_4ad253a5);
                var_4ad253a5++;
            }
            level.var_8894208b playsound("evt_sq_blackegg_activate");
            var_476a0c04 delete();
            self notsolid();
            self setspeed(level.var_92a9a44e);
            self thread function_dc66b274();
        }
        if (isdefined(node.script_waittill) && node.script_waittill == "sliding_door") {
            self setspeedimmediate(0);
            self thread function_33193ba7();
            var_522d7a2c = function_68c18107(self.origin, level.var_831f6c80);
            if (!isdefined(var_522d7a2c)) {
                println("<dev string:x72>");
                wait 1;
                continue;
            }
            if (!isdefined(level.var_831f6c80[var_522d7a2c]._door_open)) {
                println("<dev string:x96>");
                wait 1;
                continue;
            }
            if (!level.var_831f6c80[var_522d7a2c]._door_open) {
                level thread function_211c5741(5);
                level.var_8894208b playsound("evt_sq_blackegg_wait");
                level.var_8894208b.stopped = 1;
            }
            while (!level.var_831f6c80[var_522d7a2c]._door_open) {
                wait 0.05;
            }
            if (isdefined(level.var_8894208b.stopped) && level.var_8894208b.stopped) {
                level.var_8894208b playsound("evt_sq_blackegg_accel");
                level.var_8894208b.stopped = 0;
            }
            self setspeed(level.var_92a9a44e);
            self thread function_dc66b274();
        }
        if (isdefined(node.script_noteworthy)) {
            switch (node.script_noteworthy) {
            case "flag_wait_for_osc":
                self setspeedimmediate(0);
                self thread function_33193ba7();
                if (!isdefined(level.flag["flag_wait_for_osc"])) {
                    level flag::init("flag_wait_for_osc");
                }
                level flag::wait_till("flag_wait_for_osc");
                self setspeed(level.var_92a9a44e);
                self thread function_dc66b274();
                level.var_e9ab794e = 1;
                break;
            case "complete_be_1":
                self setspeedimmediate(0);
                self thread function_33193ba7();
                level flag::set("complete_be_1");
                self notify(#"hash_45c41813");
                break;
            default:
                level.var_e9ab794e = int(node.script_noteworthy);
                break;
            }
        }
        if (isdefined(node.script_parameters)) {
            var_678fa15d = getvehiclenode(node.script_parameters, "targetname");
            if (!isdefined(var_678fa15d)) {
                println("<dev string:xcb>");
                wait 1;
                continue;
            }
            self setspeedimmediate(0);
            level.var_8894208b playsound("evt_sq_blackegg_stop");
            self thread function_33193ba7();
            self attachpath(var_678fa15d);
            if (isdefined(var_678fa15d.script_string)) {
                var_476a0c04 = spawn("trigger_damage", self.origin, 0, 32, 72);
                var_15afc6ad = 0;
                while (!var_15afc6ad) {
                    if (isdefined(var_678fa15d.script_string) && var_678fa15d.script_string == "zap") {
                        namespace_1a0051d2::function_d4224082(var_476a0c04);
                        var_75916bdb = var_476a0c04 waittill(#"hash_d26ed760");
                        namespace_1a0051d2::function_1ef3ad2b(var_476a0c04);
                        var_15afc6ad = 1;
                    } else {
                        amount, attacker, direction, point, var_e5f012d6, modelname, tagname = var_476a0c04 waittill(#"damage");
                        if (isplayer(attacker) && function_5480bbe2(var_678fa15d.script_string)) {
                            var_15afc6ad = function_5480bbe2(var_e5f012d6);
                            var_75916bdb = attacker;
                        }
                    }
                    wait 0.05;
                }
                var_476a0c04 delete();
            }
            if (isdefined(var_75916bdb)) {
                var_75916bdb thread function_1bd9f9d1(var_4ad253a5);
                var_4ad253a5++;
            }
            level.var_8894208b playsound("evt_sq_blackegg_activate");
            self setspeed(level.var_92a9a44e);
            self startpath();
            self thread function_dc66b274();
            level.var_e9ab794e = 0;
        }
        if (isdefined(node.script_int)) {
            self setspeedimmediate(node.script_int);
        }
        if (isdefined(node.script_index)) {
            self thread function_50917e4(node.script_index);
        }
    }
}

// Namespace zm_moon_sq_be
// Params 1, eflags: 0x1 linked
// Checksum 0x26d5eab1, Offset: 0x20d8
// Size: 0x198
function function_5480bbe2(var_c66d4ba7) {
    if (!isdefined(var_c66d4ba7)) {
        return 0;
    }
    if (!isstring(var_c66d4ba7)) {
        println("<dev string:xf2>");
        return 0;
    }
    var_dab9c24c = strtok(var_c66d4ba7, ",");
    match = 0;
    for (i = 0; i < var_dab9c24c.size; i++) {
        for (j = 0; j < level.var_dab9c24c.size; j++) {
            if (var_dab9c24c[i] == level.var_dab9c24c[j]) {
                match = 1;
                return 1;
            }
        }
    }
    if (!match) {
        println("<dev string:x127>");
        if (isdefined(var_dab9c24c[0])) {
            println("<dev string:x148>" + var_dab9c24c[0] + "<dev string:x14e>");
        } else {
            println("<dev string:x155>");
        }
        return 0;
    }
}

// Namespace zm_moon_sq_be
// Params 3, eflags: 0x1 linked
// Checksum 0x835937c7, Offset: 0x2278
// Size: 0xdc
function function_68c18107(org, array, dist) {
    if (!isdefined(dist)) {
        dist = 9999999;
    }
    if (array.size < 1) {
        return;
    }
    index = undefined;
    for (i = 0; i < array.size; i++) {
        newdist = distance2d(array[i].origin, org);
        if (newdist >= dist) {
            continue;
        }
        dist = newdist;
        index = i;
    }
    return index;
}

// Namespace zm_moon_sq_be
// Params 1, eflags: 0x1 linked
// Checksum 0xb30aa402, Offset: 0x2360
// Size: 0xd4
function function_50917e4(var_6a3bb418) {
    self endon(#"death");
    self.var_e3302a4d stopanimscripted();
    if (var_6a3bb418 == 0) {
        self.var_e3302a4d animscripted("spin", self.var_e3302a4d.origin, self.var_e3302a4d.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
        return;
    }
    self.var_e3302a4d animscripted("spin", self.var_e3302a4d.origin, self.var_e3302a4d.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
}

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0x9309afb5, Offset: 0x2440
// Size: 0x24
function function_33193ba7() {
    self endon(#"death");
    self.var_e3302a4d stopanimscripted();
}

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0xbed486b1, Offset: 0x2470
// Size: 0xe4
function function_dc66b274() {
    self endon(#"death");
    self endon(#"hash_f8879f31");
    rand = randomint(1);
    if (rand) {
        self.var_e3302a4d animscripted("spin", self.var_e3302a4d.origin, self.var_e3302a4d.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
        return;
    }
    self.var_e3302a4d animscripted("spin", self.var_e3302a4d.origin, self.var_e3302a4d.angles, "p7_fxanim_zm_sha_crystal_sml_anim");
}

// Namespace zm_moon_sq_be
// Params 0, eflags: 0x1 linked
// Checksum 0x500ed3fd, Offset: 0x2560
// Size: 0xc4
function function_36b79119() {
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (distancesquared(players[i].origin, self.origin) <= 62500) {
                players[i] thread zm_audio::create_and_play_dialog("eggs", "quest2", 0);
                return;
            }
        }
        wait 0.5;
    }
}

// Namespace zm_moon_sq_be
// Params 1, eflags: 0x1 linked
// Checksum 0xe7dd2671, Offset: 0x2630
// Size: 0x54
function function_1bd9f9d1(num) {
    if (num > 4) {
        num -= 4;
    }
    self thread zm_audio::create_and_play_dialog("eggs", "quest2", num);
}

// Namespace zm_moon_sq_be
// Params 1, eflags: 0x1 linked
// Checksum 0x6881d2b4, Offset: 0x2690
// Size: 0x64
function function_211c5741(num) {
    player = zm_utility::get_closest_player(level.var_8894208b.origin);
    player thread zm_audio::create_and_play_dialog("eggs", "quest2", num);
}

