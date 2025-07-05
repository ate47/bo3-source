#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_theater_magic_box;

#namespace zm_theater_teleporter;

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x2
// Checksum 0xfe1c64cb, Offset: 0x818
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_theater_teleporter", &__init__, undefined, undefined);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0xa7a8d320, Offset: 0x858
// Size: 0x174
function __init__() {
    visionset_mgr::register_info("overlay", "zm_theater_teleport", 21000, 61, 1, 1);
    clientfield::register("scriptmover", "extra_screen", 21000, 1, "int");
    clientfield::register("scriptmover", "teleporter_fx", 21000, 1, "counter");
    clientfield::register("allplayers", "player_teleport_fx", 21000, 1, "counter");
    clientfield::register("scriptmover", "play_fly_me_to_the_moon_fx", 21000, 1, "int");
    clientfield::register("world", "teleporter_initiate_fx", 21000, 1, "counter");
    clientfield::register("scriptmover", "teleporter_link_cable_mtl", 21000, 1, "int");
    callback::on_spawned(&init_player);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0xad4926cc, Offset: 0x9d8
// Size: 0x43c
function teleporter_init() {
    level.teleport = [];
    level.var_276703f8 = 1.8;
    level.var_b01bd818 = 0;
    level.teleport_ae_funcs = [];
    level.var_3144fad5 = undefined;
    level.second_hand = getent("zom_clock_second_hand", "targetname");
    level.var_95c67712 = level.second_hand.angles;
    level.var_1ad9017e = &function_a73df8c4;
    level flag::init("teleporter_linked");
    level flag::init("core_linked");
    setdvar("theaterAftereffectOverride", "-1");
    poi1 = getent("teleporter_poi1", "targetname");
    poi2 = getent("teleporter_poi2", "targetname");
    players = getplayers();
    if (players.size > 1) {
        poi1 zm_utility::create_zombie_point_of_interest(undefined, 30, 0, 0);
        poi2 zm_utility::create_zombie_point_of_interest(256, 15, 0, 0);
    } else {
        poi1 zm_utility::create_zombie_point_of_interest(undefined, 35, 100, 0);
        poi2 zm_utility::create_zombie_point_of_interest(256, 10, 0, 0);
    }
    poi1 thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, 45);
    poi2 thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, 45);
    thread function_8811855f(0);
    thread function_361084a();
    thread function_49539bfb();
    thread function_185746d8();
    thread function_9272aa0();
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        util::setclientsysstate("levelNotify", "pack_clock_start", players[i]);
    }
    if (!issplitscreen()) {
        level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_f710e21c;
    }
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_ef0e774f;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_fd27ac1b;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_340c1c45;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_2c0612f7;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_5716654b;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_9fcee6e8;
    scene::add_scene_func("p7_fxanim_zm_kino_wormhole_bundle", &function_d11d2c50, "play");
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0xa73b5bc0, Offset: 0xe20
// Size: 0x1c
function init_player() {
    self.var_947f1a5b = 0;
    self.var_a7ffe97c = 0;
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x82dcda95, Offset: 0xe48
// Size: 0x30
function function_9272aa0() {
    while (true) {
        level function_a73df8c4();
        wait 0.05;
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0xa8a59323, Offset: 0xe80
// Size: 0x350
function function_8811855f(index) {
    trigger_name = "trigger_teleport_pad_" + index;
    active = 0;
    user = undefined;
    trigger = getent(trigger_name, "targetname");
    trigger setcursorhint("HINT_NOICON");
    trigger sethintstring("");
    exploder::exploder("teleporter_light_red");
    if (isdefined(trigger)) {
        while (!active) {
            level flag::wait_till("teleporter_linked");
            exploder::exploder("fxexp_200");
            exploder::kill_exploder("teleporter_light_red");
            exploder::exploder("teleporter_light_green");
            trigger sethintstring(%ZM_THEATER_USE_TELEPORTER);
            trigger waittill(#"trigger", user);
            if (zombie_utility::is_player_valid(user) && user zm_score::can_player_purchase(level.var_b01bd818)) {
                active = 1;
                exploder::kill_exploder("teleporter_light_green");
                exploder::exploder("teleporter_light_red");
                trigger sethintstring("");
                user zm_score::minus_to_player_score(level.var_b01bd818);
                exploder::kill_exploder("fxexp_200");
                level clientfield::increment("teleporter_initiate_fx");
                trigger player_teleporting(index);
                level.var_4f3df77f clientfield::set("teleporter_link_cable_mtl", 0);
                trigger sethintstring(%ZOMBIE_TELEPORT_COOLDOWN);
                wait 90;
                active = 0;
                exploder::delete_exploder_on_clients("fxexp_202");
                level flag::clear("teleporter_linked");
                level flag::clear("core_linked");
                exploder::kill_exploder("teleporter_light_red");
                exploder::exploder("teleporter_light_green");
            }
        }
    }
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0xf19a4bf, Offset: 0x11d8
// Size: 0x168
function function_361084a() {
    trigger_name = "trigger_teleport_pad_0";
    core = getent(trigger_name, "targetname");
    user = undefined;
    while (true) {
        if (!level flag::get("core_linked")) {
            core sethintstring(%ZM_THEATER_LINK_CORE);
            core waittill(#"trigger", user);
            core playsound("evt_teleporter_activate_start");
            level flag::set("core_linked");
            core sethintstring("");
            pad = getent(core.target, "targetname");
            pad sethintstring(%ZM_THEATER_LINK_PAD);
        }
        util::wait_network_frame();
    }
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x80c7810e, Offset: 0x1348
// Size: 0x114
function function_160dd0e9() {
    trigger_name = "trigger_teleport_pad_0";
    core = getent(trigger_name, "targetname");
    pad = getent(core.target, "targetname");
    pad setcursorhint("HINT_NOICON");
    level.var_4f3df77f = getent("teleporter_link_cable", "targetname");
    pad sethintstring(%ZOMBIE_NEED_POWER);
    level flag::wait_till("power_on");
    pad sethintstring(%ZM_THEATER_START_CORE);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0xa452162e, Offset: 0x1468
// Size: 0x170
function function_49539bfb() {
    trigger_name = "trigger_teleport_pad_0";
    core = getent(trigger_name, "targetname");
    pad = getent(core.target, "targetname");
    user = undefined;
    while (true) {
        if (!level flag::get("teleporter_linked") && level flag::get("core_linked")) {
            pad waittill(#"trigger", user);
            pad sethintstring("");
            pad playsound("evt_teleporter_activate_finish");
            level flag::set("teleporter_linked");
            level.var_4f3df77f clientfield::set("teleporter_link_cable_mtl", 1);
        }
        util::wait_network_frame();
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0xec8a4772, Offset: 0x15e0
// Size: 0x464
function player_teleporting(index) {
    var_1bea176e = [];
    self thread function_5e48550f(undefined);
    self thread function_aabb419a();
    self thread function_40b54710(undefined, 300);
    wait level.var_276703f8;
    exploder::exploder("fxexp_202");
    self notify(#"hash_d75099e");
    var_1bea176e = self teleport_players(var_1bea176e, "projroom");
    if (isdefined(var_1bea176e) && (!isdefined(var_1bea176e) || var_1bea176e.size < 1)) {
        return;
    }
    var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
    foreach (e_player in var_1bea176e) {
        e_player.var_35c3d096 = 1;
    }
    wait 30;
    var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
    level.var_dfa06af9 clientfield::set("extra_screen", 0);
    if (randomint(100) > 24 && !isdefined(level.var_3144fad5)) {
        loc = "eerooms";
        level.var_3144fad5 = 1;
        if (randomint(100) > 65) {
            level thread function_3ed03f95();
        }
    } else {
        loc = "theater";
        exploder::exploder(301);
    }
    self thread function_5e48550f(var_1bea176e);
    self thread function_492a85ce(var_1bea176e);
    wait level.var_276703f8;
    var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
    self notify(#"hash_d75099e");
    self thread function_668410f0(var_1bea176e);
    self teleport_players(var_1bea176e, loc);
    if (isdefined(loc) && loc == "eerooms") {
        loc = "theater";
        wait 4;
        var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
        self thread function_492a85ce(var_1bea176e);
        exploder::exploder(301);
        self thread function_5e48550f(var_1bea176e);
        wait level.var_276703f8;
        var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
        self notify(#"hash_d75099e");
        self thread function_668410f0(var_1bea176e);
        self teleport_players(var_1bea176e, loc);
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0x65d004a2, Offset: 0x1a50
// Size: 0x86
function function_5f0f1e6d(enable) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i])) {
            self setinvisibletoplayer(players[i], enable);
        }
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0x992a2c38, Offset: 0x1ae0
// Size: 0x2e
function function_5f4a2230(player) {
    if (player istouching(self)) {
        return true;
    }
    return false;
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0x9b58cf61, Offset: 0x1b18
// Size: 0xd0
function function_5e48550f(players) {
    self endon(#"hash_d75099e");
    var_740405c8 = 0;
    if (!isdefined(players)) {
        players = getplayers();
    } else {
        var_740405c8 = 1;
    }
    while (true) {
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i])) {
                if (self function_5f4a2230(players[i]) || var_740405c8) {
                }
            }
        }
        wait 0.05;
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0x24c5a8b1, Offset: 0x1bf0
// Size: 0x82
function function_1488cf91(e_player) {
    var_1de511b3 = getent("teleportation_area", "targetname");
    return isalive(e_player) && e_player.sessionstate !== "spectator" && e_player istouching(var_1de511b3);
}

// Namespace zm_theater_teleporter
// Params 2, eflags: 0x0
// Checksum 0x6ffef777, Offset: 0x1c80
// Size: 0xc04
function teleport_players(var_1bea176e, loc) {
    self endon(#"death");
    player_radius = 16;
    var_9eed0845 = [];
    all_players = level.players;
    slot = undefined;
    start = undefined;
    if (loc == "projroom") {
        players = all_players;
    } else {
        players = var_1bea176e;
    }
    var_9eed0845 = function_784ee767("teleport_room_", var_9eed0845);
    function_dcb14347(var_9eed0845);
    function_c4cf74dc(var_9eed0845, all_players, player_radius);
    prone_offset = (0, 0, 49);
    crouch_offset = (0, 0, 20);
    var_7cac5f2f = (0, 0, 0);
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i])) {
            if (loc == "projroom" && self function_5f4a2230(players[i]) == 0) {
                continue;
            } else if (loc == "projroom" && self function_5f4a2230(players[i])) {
                array::add(var_1bea176e, players[i], 0);
            }
            players[i].var_947f1a5b = 1;
            players[i] clientfield::increment("player_teleport_fx");
            players[i] clientfield::set_to_player("player_dust_mote", 0);
            players[i] freezecontrols(1);
            players[i] disableweapons();
            players[i] disableoffhandweapons();
            util::wait_network_frame();
            slot = i;
            start = 0;
            while (var_9eed0845[slot].occupied && start < 4) {
                start++;
                slot++;
                if (slot >= 4) {
                    slot = 0;
                }
            }
            var_9eed0845[slot].occupied = 1;
            players[i].var_a7ffe97c = 1;
            visionset_mgr::activate("overlay", "zm_theater_teleport", players[i]);
            if (players[i] getstance() == "prone") {
                desired_origin = var_9eed0845[i].origin + prone_offset;
                var_77f390f5 = prone_offset;
            } else if (players[i] getstance() == "crouch") {
                desired_origin = var_9eed0845[i].origin + crouch_offset;
                var_77f390f5 = crouch_offset;
            } else {
                desired_origin = var_9eed0845[i].origin + var_7cac5f2f;
                var_77f390f5 = var_7cac5f2f;
            }
            util::setclientsysstate("levelNotify", "black_box_start", players[i]);
            players[i] setorigin(var_9eed0845[i].origin);
            players[i] setplayerangles(var_9eed0845[i].angles);
            players[i].teleport_origin = spawn("script_origin", players[i].origin);
            players[i].teleport_origin.angles = players[i].angles;
            players[i] linkto(players[i].teleport_origin);
            players[i] thread function_7e0ed731(slot, var_77f390f5);
            players[i] playrumbleonentity("zm_castle_moon_explosion_rumble");
        }
    }
    if (isdefined(var_1bea176e) && (!isdefined(var_1bea176e) || var_1bea176e.size < 1)) {
        return;
    }
    wait 2;
    var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
    var_9eed0845 = [];
    if (loc == "projroom") {
        var_9eed0845 = function_784ee767("projroom_teleport_player", var_9eed0845);
    } else if (loc == "eerooms") {
        level.var_3144fad5 = 1;
        var_9eed0845 = function_784ee767("ee_teleport_player", var_9eed0845);
    } else if (loc == "theater") {
        if (isdefined(self.target)) {
            ent = getent(self.target, "targetname");
            self thread function_40b54710(undefined, 20);
        }
        var_9eed0845 = function_784ee767("theater_teleport_player", var_9eed0845);
    }
    function_dcb14347(var_9eed0845);
    function_c4cf74dc(var_9eed0845, all_players, player_radius);
    var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
    for (i = 0; i < var_1bea176e.size; i++) {
        if (isdefined(var_1bea176e[i])) {
            slot = randomintrange(0, 4);
            start = 0;
            while (var_9eed0845[slot].occupied && start < 4) {
                start++;
                slot++;
                if (slot >= 4) {
                    slot = 0;
                }
            }
            var_9eed0845[slot].occupied = 1;
            util::setclientsysstate("levelNotify", "black_box_end", var_1bea176e[i]);
            var_1bea176e[i] notify(#"hash_97e83cbe");
            assert(isdefined(var_1bea176e[i].teleport_origin));
            var_1bea176e[i].teleport_origin delete();
            var_1bea176e[i].teleport_origin = undefined;
            var_1bea176e[i] setorigin(var_9eed0845[slot].origin);
            var_1bea176e[i] setplayerangles(var_9eed0845[slot].angles);
            var_1bea176e[i] clientfield::increment("player_teleport_fx");
            if (loc != "eerooms") {
                var_1bea176e[i] enableweapons();
                var_1bea176e[i] enableoffhandweapons();
                var_1bea176e[i] freezecontrols(0);
            } else {
                var_1bea176e[i] freezecontrols(0);
            }
            util::setclientsysstate("levelNotify", "t2bfx", var_1bea176e[i]);
            visionset_mgr::deactivate("overlay", "zm_theater_teleport", var_1bea176e[i]);
            var_1bea176e[i] function_77a0f55b();
            if (loc == "projroom") {
                level.second_hand thread function_cd646ef5();
                thread function_91f69b8f();
                var_1bea176e[i] clientfield::set_to_player("player_dust_mote", 1);
            } else if (loc == "theater") {
                var_1bea176e[i].var_a7ffe97c = 0;
                var_1bea176e[i].var_35c3d096 = undefined;
                var_1bea176e[i] clientfield::set_to_player("player_dust_mote", 1);
            } else {
                players[i] notify(#"hash_62857917", slot);
            }
            players[i].var_947f1a5b = 0;
        }
    }
    if (loc == "projroom") {
        return var_1bea176e;
    }
    if (loc == "theater") {
        level.var_3144fad5 = undefined;
        exploder::exploder(302);
    }
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x2a208cc6, Offset: 0x2890
// Size: 0xb6
function function_91f69b8f() {
    wait 2;
    level.var_dfa06af9 show();
    level.var_dfa06af9 clientfield::set("extra_screen", 1);
    players = level.players;
    for (i = 0; i < players.size; i++) {
        util::setclientsysstate("levelNotify", "camera_start", players[i]);
    }
}

// Namespace zm_theater_teleporter
// Params 2, eflags: 0x0
// Checksum 0x7095a11c, Offset: 0x2950
// Size: 0x6c
function function_784ee767(sname, spots) {
    for (i = 0; i < 4; i++) {
        spots[i] = getent(sname + i, "targetname");
    }
    return spots;
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0xc749dba4, Offset: 0x29c8
// Size: 0x4e
function function_dcb14347(spots) {
    for (i = 0; i < spots.size; i++) {
        spots[i].occupied = 0;
    }
}

// Namespace zm_theater_teleporter
// Params 3, eflags: 0x0
// Checksum 0xbc2e2822, Offset: 0x2a20
// Size: 0x104
function function_c4cf74dc(dest, players, player_radius) {
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i])) {
            for (j = 0; j < dest.size; j++) {
                if (!dest[j].occupied) {
                    dist = distance2d(dest[j].origin, players[i].origin);
                    if (dist < player_radius) {
                        dest[j].occupied = 1;
                    }
                }
            }
        }
    }
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0xce7f1113, Offset: 0x2b30
// Size: 0xce
function function_aabb419a() {
    self endon(#"hash_d75099e");
    util::clientnotify("tpa");
    players = getplayers();
    wait 1.7;
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i])) {
            if (self function_5f4a2230(players[i])) {
                util::setclientsysstate("levelNotify", "t2d", players[i]);
            }
        }
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0xbaa7f15f, Offset: 0x2c08
// Size: 0x7e
function function_74cbcb97(player) {
    self endon(#"hash_d75099e");
    for (i = 0; i < player.size; i++) {
        if (isdefined(player[i])) {
            util::setclientsysstate("levelNotify", "t2dn", player[i]);
        }
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0x70c034a1, Offset: 0x2c90
// Size: 0x7e
function function_492a85ce(player) {
    self endon(#"hash_d75099e");
    for (i = 0; i < player.size; i++) {
        if (isdefined(player[i])) {
            util::setclientsysstate("levelNotify", "tss", player[i]);
        }
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0xc70e6316, Offset: 0x2d18
// Size: 0x7e
function function_668410f0(player) {
    self endon(#"hash_d75099e");
    for (i = 0; i < player.size; i++) {
        if (isdefined(player[i])) {
            util::setclientsysstate("levelNotify", "tsg", player[i]);
        }
    }
}

// Namespace zm_theater_teleporter
// Params 2, eflags: 0x0
// Checksum 0xb1159cd4, Offset: 0x2da0
// Size: 0x1ee
function function_40b54710(var_728eaa61, range) {
    zombies = getaispeciesarray("axis");
    zombies = util::get_array_of_closest(self.origin, zombies, undefined, var_728eaa61, range);
    for (i = 0; i < zombies.size; i++) {
        wait randomfloatrange(0.2, 0.3);
        if (!isdefined(zombies[i])) {
            continue;
        }
        if (zombies[i].animname != "boss_zombie" && zombies[i].animname != "ape_zombie" && isdefined(zombies[i].animname) && zombies[i].animname != "zombie_dog" && zombies[i].health < 5000) {
            zombies[i] zombie_utility::zombie_head_gib();
        }
        zombies[i] dodamage(zombies[i].health + 100, zombies[i].origin);
        playsoundatposition("nuked", zombies[i].origin);
    }
}

// Namespace zm_theater_teleporter
// Params 2, eflags: 0x0
// Checksum 0x1bd82af2, Offset: 0x2f98
// Size: 0x94
function function_9113fdce(var_58d36ef3, pre_wait) {
    if (!isdefined(pre_wait)) {
        pre_wait = 0;
    }
    index = zm_utility::get_player_index(self);
    plr = "plr_" + index + "_";
    wait pre_wait;
    self zm_audio::create_and_play_dialog(plr, var_58d36ef3, 0.25);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0xdaa96321, Offset: 0x3038
// Size: 0x32
function function_77a0f55b() {
    self thread [[ level.teleport_ae_funcs[randomint(level.teleport_ae_funcs.size)] ]]();
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0xc7378116, Offset: 0x3078
// Size: 0x44
function function_ef0e774f() {
    println("<dev string:x28>");
    self shellshock("explosion", 3);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0xccf7912d, Offset: 0x30c8
// Size: 0x44
function function_fd27ac1b() {
    println("<dev string:x46>");
    self shellshock("electrocution", 3);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x4397c74, Offset: 0x3118
// Size: 0xc2
function function_f710e21c() {
    println("<dev string:x62>");
    var_27bb5e5b = 30;
    var_400a1590 = 65;
    duration = 0.5;
    for (i = 0; i < duration; i += 0.017) {
        fov = var_27bb5e5b + (var_400a1590 - var_27bb5e5b) * i / duration;
        wait 0.017;
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0x94f3e28b, Offset: 0x31e8
// Size: 0x74
function function_340c1c45(localclientnum) {
    println("<dev string:x79>");
    visionset_mgr::activate("visionset", "cheat_bw_invert_contrast", self);
    wait 1.25;
    visionset_mgr::deactivate("visionset", "cheat_bw_invert_contrast", self);
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0x72ae6d8f, Offset: 0x3268
// Size: 0x74
function function_2c0612f7(localclientnum) {
    println("<dev string:x90>");
    visionset_mgr::activate("visionset", "zombie_turned", self);
    wait 1.25;
    visionset_mgr::deactivate("visionset", "zombie_turned", self);
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0x3e990e5, Offset: 0x32e8
// Size: 0xbc
function function_5716654b(localclientnum) {
    println("<dev string:xa7>");
    visionset_mgr::activate("visionset", "cheat_bw_invert_contrast", self);
    wait 0.4;
    visionset_mgr::deactivate("visionset", "cheat_bw_invert_contrast", self);
    visionset_mgr::activate("visionset", "cheat_bw_contrast", self);
    wait 1.2;
    visionset_mgr::deactivate("visionset", "cheat_bw_contrast", self);
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0x11a51149, Offset: 0x33b0
// Size: 0x74
function function_9fcee6e8(localclientnum) {
    println("<dev string:xc1>");
    visionset_mgr::activate("visionset", "flare", self);
    wait 1.25;
    visionset_mgr::deactivate("visionset", "flare", self);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x96cb61b2, Offset: 0x3430
// Size: 0x274
function function_a73df8c4() {
    var_b0dc7a42 = 0;
    var_b23a1db1 = 0;
    poi1 = getent("teleporter_poi1", "targetname");
    poi2 = getent("teleporter_poi2", "targetname");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].var_a7ffe97c) && players[i].var_a7ffe97c == 1) {
            var_b0dc7a42++;
        }
        if (!isdefined(players[i].var_a7ffe97c) || !zombie_utility::is_player_valid(players[i]) && players[i].var_a7ffe97c == 0) {
            var_b23a1db1++;
        }
    }
    if (var_b0dc7a42 == players.size || var_b0dc7a42 > 0 && var_b0dc7a42 + var_b23a1db1 == players.size) {
        if (!poi1.poi_active && !poi2.poi_active) {
            poi1 zm_utility::activate_zombie_point_of_interest();
            poi2 zm_utility::activate_zombie_point_of_interest();
        }
        return;
    }
    if (var_b0dc7a42 != players.size) {
        if (poi1.poi_active && poi2.poi_active) {
            if (isdefined(poi1.attractor_array)) {
                poi1 zm_utility::deactivate_zombie_point_of_interest(1);
            }
            if (isdefined(poi2.attractor_array)) {
                poi2 zm_utility::deactivate_zombie_point_of_interest(1);
            }
        }
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0xd3d98c54, Offset: 0x36b0
// Size: 0x11c
function function_7861a40a(position) {
    self endon(#"death");
    self endon(#"bad_path");
    var_880db4d3 = self.goalradius;
    self.ignoreall = 1;
    self.goalradius = -128;
    /#
        iprintlnbold("<dev string:xda>", var_880db4d3);
    #/
    self setgoalpos(position.origin + (randomfloatrange(-40, 40), randomfloatrange(-40, 40), 0));
    self waittill(#"goal");
    self.ignoreall = 0;
    self.goalradius = var_880db4d3;
    self orientmode("face point", level.var_dfa06af9.origin);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x9b922bfa, Offset: 0x37d8
// Size: 0xac
function function_cd646ef5() {
    self rotatepitch(-76, 0.05);
    self waittill(#"rotatedone");
    for (var_dba9c206 = 0; var_dba9c206 != 30; var_dba9c206++) {
        self rotatepitch(6, 0.1);
        wait 1;
    }
    wait 5;
    self rotateto(level.var_95c67712, 0.05);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x8175714, Offset: 0x3890
// Size: 0x12c
function function_3ed03f95() {
    struct_array = struct::get_array("struct_random_powerup_post_teleport", "targetname");
    var_f687758d = [];
    var_f687758d[var_f687758d.size] = "nuke";
    var_f687758d[var_f687758d.size] = "insta_kill";
    var_f687758d[var_f687758d.size] = "double_points";
    var_f687758d[var_f687758d.size] = "carpenter";
    var_f687758d[var_f687758d.size] = "fire_sale";
    var_f687758d[var_f687758d.size] = "full_ammo";
    var_f687758d[var_f687758d.size] = "minigun";
    struct_array = array::randomize(struct_array);
    var_f687758d = array::randomize(var_f687758d);
    level thread zm_powerups::specific_powerup_drop(var_f687758d[0], struct_array[0].origin);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x6b4e3703, Offset: 0x39c8
// Size: 0x8c
function function_185746d8() {
    var_37cacae8 = getent("trigger_jump", "targetname");
    var_ff02c9fa = getent("trigger_fly_me_to_the_moon", "targetname");
    var_37cacae8 thread function_2cdd3a26();
    var_ff02c9fa thread function_b258e70b();
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x2a4cc46a, Offset: 0x3a60
// Size: 0x120
function function_2cdd3a26() {
    self endon(#"death");
    self.a_e_players = [];
    while (true) {
        self waittill(#"trigger", e_player);
        if (isinarray(self.a_e_players, e_player)) {
            continue;
        }
        if (!isdefined(self.a_e_players)) {
            self.a_e_players = [];
        } else if (!isarray(self.a_e_players)) {
            self.a_e_players = array(self.a_e_players);
        }
        self.a_e_players[self.a_e_players.size] = e_player;
        if (!isdefined(e_player.var_d88a7e9)) {
            e_player.var_d88a7e9 = 0;
        }
        e_player thread function_edc40283(self);
        e_player thread function_bc057378(self);
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0x2c3004d7, Offset: 0x3b88
// Size: 0x8e
function function_edc40283(var_4e54c41) {
    self endon(#"hash_43605624");
    self endon(#"death");
    var_4e54c41 endon(#"death");
    while (self.var_d88a7e9 < 5) {
        if (self jumpbuttonpressed()) {
            self.var_d88a7e9 += 1;
            wait 0.9;
        }
        wait 0.05;
    }
    self notify(#"hash_7bde7d2d");
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0xa550d8f4, Offset: 0x3c20
// Size: 0x94
function function_bc057378(var_4e54c41) {
    self endon(#"hash_7bde7d2d");
    var_4e54c41 endon(#"death");
    while (self istouching(var_4e54c41)) {
        wait 0.05;
    }
    if (self.var_d88a7e9 < 5) {
        self.var_d88a7e9 = 0;
    }
    self notify(#"hash_43605624");
    arrayremovevalue(var_4e54c41.a_e_players, self);
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0x4fc2db47, Offset: 0x3cc0
// Size: 0xf6
function function_b258e70b() {
    self endon(#"hash_64fcb4a6");
    self sethintstring("");
    self setcursorhint("HINT_NOICON");
    while (isdefined(self)) {
        self waittill(#"trigger", e_player);
        if (!isdefined(e_player.var_d88a7e9) || e_player.var_d88a7e9 < 5) {
            wait 0.05;
            continue;
        }
        if (isdefined(e_player.var_d88a7e9) && e_player.var_d88a7e9 >= 5) {
            level function_b895d388();
            e_player.var_d88a7e9 = undefined;
        }
    }
}

// Namespace zm_theater_teleporter
// Params 0, eflags: 0x0
// Checksum 0xdd252f88, Offset: 0x3dc0
// Size: 0x164
function function_b895d388() {
    ship = getent("model_zombie_rocket", "targetname");
    var_349c239a = ship.origin;
    wait 0.05;
    ship clientfield::set("play_fly_me_to_the_moon_fx", 1);
    ship movez(120, 3, 0.7, 0);
    ship waittill(#"movedone");
    ship clientfield::set("play_fly_me_to_the_moon_fx", 0);
    ship delete();
    var_4e54c41 = getent("trigger_jump", "targetname");
    var_4e54c41 notify(#"hash_88782877");
    var_ff02c9fa = getent("trigger_fly_me_to_the_moon", "targetname");
    var_ff02c9fa delete();
}

// Namespace zm_theater_teleporter
// Params 2, eflags: 0x0
// Checksum 0x45c3250a, Offset: 0x3f30
// Size: 0xfc
function function_7e0ed731(var_f7b84b84, v_offset) {
    self endon(#"disconnect");
    var_51bf1eed = var_f7b84b84 + 1;
    var_2d8dac7a = "teleport_room_fx_" + var_51bf1eed;
    var_b4c5584f = struct::get(var_2d8dac7a, "targetname");
    s_wormhole = struct::spawn(var_b4c5584f.origin - v_offset, var_b4c5584f.angles);
    if (isdefined(s_wormhole)) {
        waittillframeend();
        s_wormhole scene::play("p7_fxanim_zm_kino_wormhole_bundle");
        s_wormhole struct::delete();
    }
}

// Namespace zm_theater_teleporter
// Params 1, eflags: 0x0
// Checksum 0xd95b146f, Offset: 0x4038
// Size: 0x64
function function_d11d2c50(a_ents) {
    a_ents["fxanim_kino_wormhole"] setignorepauseworld(1);
    wait 0.05;
    a_ents["fxanim_kino_wormhole"] clientfield::increment("teleporter_fx");
}

