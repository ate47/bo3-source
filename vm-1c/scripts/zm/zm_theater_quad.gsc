#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_quad;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_quad;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_zonemgr;

#namespace zm_theater_quad;

// Namespace zm_theater_quad
// Params 0, eflags: 0x2
// Checksum 0x5001f15a, Offset: 0x650
// Size: 0x14
function autoexec init() {
    function_66da4eb0();
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x4
// Checksum 0x7ae4cd28, Offset: 0x670
// Size: 0x1a4
function private function_66da4eb0() {
    behaviortreenetworkutility::registerbehaviortreeaction("traverseWallCrawlAction", &traverseWallCrawlAction, &function_7d285db1, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldWallTraverse", &shouldWallTraverse);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldWallCrawl", &shouldWallCrawl);
    behaviortreenetworkutility::registerbehaviortreescriptapi("traverseWallIntro", &traverseWallIntro);
    behaviortreenetworkutility::registerbehaviortreescriptapi("traverseWallJumpOff", &traverseWallJumpOff);
    behaviortreenetworkutility::registerbehaviortreescriptapi("quadCollisionService", &quadCollisionService);
    animationstatenetwork::registeranimationmocomp("quad_wall_traversal", &function_dd3e35df, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("quad_wall_jump_off", &function_5d8b540c, undefined, &function_18650281);
    animationstatenetwork::registeranimationmocomp("quad_move_strict_traversal", &function_9e9b3f8b, undefined, &function_2433815e);
}

// Namespace zm_theater_quad
// Params 2, eflags: 0x0
// Checksum 0x56fc6e99, Offset: 0x820
// Size: 0x30
function traverseWallCrawlAction(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    return 5;
}

// Namespace zm_theater_quad
// Params 2, eflags: 0x0
// Checksum 0xf3a23c38, Offset: 0x858
// Size: 0x38
function function_7d285db1(entity, asmstatename) {
    if (!shouldWallCrawl(entity)) {
        return 4;
    }
    return 5;
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0x35ff4fde, Offset: 0x898
// Size: 0x56
function shouldWallTraverse(entity) {
    if (isdefined(entity.traversestartnode)) {
        if (issubstr(entity.traversestartnode.animscript, "zm_wall_crawl_drop")) {
            return true;
        }
    }
    return false;
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0x97e9290b, Offset: 0x8f8
// Size: 0x30
function shouldWallCrawl(entity) {
    if (isdefined(self.var_2826ab5d)) {
        if (gettime() >= self.var_2826ab5d) {
            return false;
        }
    }
    return true;
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0x411a7aab, Offset: 0x930
// Size: 0xf4
function traverseWallIntro(entity) {
    entity allowpitchangle(0);
    entity.clamptonavmesh = 0;
    if (isdefined(entity.traversestartnode)) {
        entity.var_1bb3c5d0 = entity.traversestartnode;
        entity.var_7531a5e3 = entity.traverseendnode;
        if (entity.traversestartnode.animscript == "zm_wall_crawl_drop") {
            blackboard::setblackboardattribute(self, "_quad_wall_crawl", "quad_wall_crawl_theater");
            return;
        }
        blackboard::setblackboardattribute(self, "_quad_wall_crawl", "quad_wall_crawl_start");
    }
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0xef2f813a, Offset: 0xa30
// Size: 0x16
function traverseWallJumpOff(entity) {
    self.var_2826ab5d = undefined;
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0x3334f975, Offset: 0xa50
// Size: 0x1de
function quadCollisionService(behaviortreeentity) {
    if (isdefined(behaviortreeentity.dontpushtime)) {
        if (gettime() < behaviortreeentity.dontpushtime) {
            return true;
        }
    }
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (zombie == behaviortreeentity) {
            continue;
        }
        if (isdefined(zombie.knockdown) && (isdefined(zombie.missinglegs) && zombie.missinglegs || zombie.knockdown)) {
            continue;
        }
        dist_sq = distancesquared(behaviortreeentity.origin, zombie.origin);
        if (dist_sq < 14400) {
            behaviortreeentity function_1762804b(0);
            behaviortreeentity.dontpushtime = gettime() + 3000;
            zombie thread function_77876867();
            return true;
        }
    }
    behaviortreeentity function_1762804b(1);
    return false;
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0x507e84aa, Offset: 0xc38
// Size: 0x4c
function function_77876867() {
    self endon(#"death");
    self setavoidancemask("avoid all");
    wait 3;
    self setavoidancemask("avoid none");
}

// Namespace zm_theater_quad
// Params 5, eflags: 0x4
// Checksum 0x2b82fe84, Offset: 0xc90
// Size: 0x158
function private function_dd3e35df(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    animdist = abs(getmovedelta(mocompanim, 0, 1)[2]);
    self.ground_pos = bullettrace(self.var_7531a5e3.origin, self.var_7531a5e3.origin + (0, 0, -100000), 0, self)["position"];
    physdist = abs(self.origin[2] - self.ground_pos[2] - 60);
    cycles = physdist / animdist;
    time = cycles * getanimlength(mocompanim);
    self.var_2826ab5d = gettime() + time * 1000;
}

// Namespace zm_theater_quad
// Params 5, eflags: 0x4
// Checksum 0x226cbd3a, Offset: 0xdf0
// Size: 0x4c
function private function_5d8b540c(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("noclip", 0);
}

// Namespace zm_theater_quad
// Params 5, eflags: 0x4
// Checksum 0x96dd1e2e, Offset: 0xe48
// Size: 0x58
function private function_18650281(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity allowpitchangle(1);
    entity.clamptonavmesh = 1;
}

// Namespace zm_theater_quad
// Params 5, eflags: 0x4
// Checksum 0xe7f116bc, Offset: 0xea8
// Size: 0x114
function private function_9e9b3f8b(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    assert(isdefined(entity.traversestartnode));
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity animmode("noclip", 0);
    entity forceteleport(entity.traversestartnode.origin, entity.traversestartnode.angles, 0);
    entity orientmode("face angle", entity.traversestartnode.angles[1]);
}

// Namespace zm_theater_quad
// Params 5, eflags: 0x4
// Checksum 0xa7a9829b, Offset: 0xfc8
// Size: 0x64
function private function_2433815e(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity finishtraversal();
    entity.usegoalanimweight = 0;
    entity.blockingpain = 0;
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0xe90eb5df, Offset: 0x1038
// Size: 0x84
function function_9b14f5cb() {
    level flag::wait_till("curtains_done");
    level thread quad_stage_roof_break();
    level thread function_370931ae();
    level thread function_34e51315();
    level thread function_79dea782();
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0xfd3e855, Offset: 0x10c8
// Size: 0x14c
function function_55842bd2(n_index) {
    function_55813a6b();
    var_8df89230 = getentarray(self.target, "targetname");
    if (isdefined(var_8df89230)) {
        for (i = 0; i < var_8df89230.size; i++) {
            var_8df89230[i] delete();
        }
    }
    fx = struct::get(self.target, "targetname");
    if (isdefined(fx)) {
        self function_b7b3e976(n_index);
        thread function_2747b8e1("damage_heavy");
    }
    if (isdefined(self.script_noteworthy)) {
        util::clientnotify(self.script_noteworthy);
    }
    if (isdefined(self.script_int)) {
        exploder::exploder(self.script_int);
    }
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0xe3935fd4, Offset: 0x1220
// Size: 0x164
function function_b7b3e976(n_index) {
    switch (n_index) {
    case 0:
        var_a58a7b24 = "fxexp_1012";
        break;
    case 1:
        var_a58a7b24 = "fxexp_1007";
        break;
    case 2:
        var_a58a7b24 = "fxexp_1008";
        break;
    case 3:
        var_a58a7b24 = "fxexp_1009";
        break;
    case 4:
        var_a58a7b24 = "fxexp_1010";
        break;
    case 5:
        var_a58a7b24 = "fxexp_1003";
        break;
    case 6:
        var_a58a7b24 = "fxexp_1004";
        break;
    case 7:
        var_a58a7b24 = "fxexp_1001";
        break;
    case 8:
        var_a58a7b24 = "fxexp_1002";
        break;
    case 10:
        var_a58a7b24 = "fxexp_1006";
        break;
    case 12:
        var_a58a7b24 = "fxexp_1014";
        break;
    case 15:
        var_a58a7b24 = "fxexp_1011";
        break;
    }
    if (isdefined(var_a58a7b24)) {
        exploder::exploder(var_a58a7b24);
    }
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0x5f003fa5, Offset: 0x1390
// Size: 0x9c
function function_55813a6b() {
    location = struct::get(self.target, "targetname");
    self playsoundwithnotify("zmb_vocals_quad_spawn", "sounddone");
    self waittill(#"sounddone");
    self playsound("zmb_quad_roof_hit");
    thread function_f40c7f27(location.origin);
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0x94223b28, Offset: 0x1438
// Size: 0x3c
function function_f40c7f27(origin) {
    wait 1;
    playsoundatposition("zmb_quad_roof_break_land", origin - (0, 0, 150));
}

// Namespace zm_theater_quad
// Params 5, eflags: 0x0
// Checksum 0xa9679396, Offset: 0x1480
// Size: 0x156
function function_2747b8e1(var_b1959c71, var_8221d0bd, var_58e4d11d, var_6425fdcd, var_8681ab1) {
    players = level.players;
    for (i = 0; i < players.size; i++) {
        if (isdefined(var_6425fdcd) && isdefined(var_8681ab1) && isdefined(var_58e4d11d)) {
            if (distance(players[i].origin, var_58e4d11d) < var_6425fdcd) {
                players[i] playrumbleonentity(var_b1959c71);
            } else if (distance(players[i].origin, var_58e4d11d) < var_8681ab1) {
                players[i] playrumbleonentity(var_8221d0bd);
            }
            continue;
        }
        players[i] playrumbleonentity(var_b1959c71);
    }
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0x26af6178, Offset: 0x15e0
// Size: 0x4c
function function_e9b9ba37() {
    self endon(#"hash_8e27efad");
    self waittill(#"death");
    playfx(level._effect["quad_grnd_dust_spwnr"], self.origin);
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0x964a7798, Offset: 0x1638
// Size: 0x88
function function_88aa9df5(var_413be39d) {
    if (level flag::get("dog_round")) {
        level flag::clear("dog_round");
    }
    if (level.next_dog_round == level.round_number + 1) {
        level.next_dog_round++;
    }
    level.zombie_total = 0;
    level.var_413be39d = var_413be39d;
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0x4f2fd7a0, Offset: 0x16c8
// Size: 0x84
function function_18ff9b17() {
    level.zombie_health = level.zombie_vars["zombie_health_start"];
    var_3bbb6369 = zm::get_round_number();
    level.zombie_total = 0;
    level.zombie_health = 100 * var_3bbb6369;
    kill_all_zombies();
    zm::set_round_number(var_3bbb6369);
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0xdee4c526, Offset: 0x1758
// Size: 0x12c
function function_8194bcc2(var_156de008) {
    var_b670d1c9 = [];
    var_b670d1c9 = getentarray(var_156de008, "targetname");
    if (var_b670d1c9.size < 1) {
        assertmsg("<dev string:x28>");
        return;
    }
    for (i = 0; i < var_b670d1c9.size; i++) {
        ai = zombie_utility::spawn_zombie(var_b670d1c9[i]);
        if (isdefined(ai)) {
            ai thread zombie_utility::round_spawn_failsafe();
            ai thread function_e9b9ba37();
        }
        wait randomintrange(10, 45);
    }
    util::wait_network_frame();
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0x80a24967, Offset: 0x1890
// Size: 0xbc
function function_4d4195d5(spawn_array) {
    spawn_point = spawn_array[randomint(spawn_array.size)];
    ai = zombie_utility::spawn_zombie(spawn_point);
    if (isdefined(ai)) {
        ai thread zombie_utility::round_spawn_failsafe();
        ai thread function_e9b9ba37();
    }
    wait level.zombie_vars["zombie_spawn_delay"];
    util::wait_network_frame();
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0x3c6c674d, Offset: 0x1958
// Size: 0xce
function kill_all_zombies() {
    zombies = getaispeciesarray("axis", "all");
    if (isdefined(zombies)) {
        for (i = 0; i < zombies.size; i++) {
            if (!isdefined(zombies[i])) {
                continue;
            }
            zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
            util::wait_network_frame();
        }
    }
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0xdc5abe72, Offset: 0x1a30
// Size: 0x40
function function_5b2f22da() {
    level endon(#"hash_69490d68");
    while (true) {
        if (level.zombie_total < 1) {
            level.zombie_total = 1;
        }
        wait 0.5;
    }
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0x2243fc26, Offset: 0x1a78
// Size: 0x376
function function_220af451() {
    timer = gettime();
    spawned = 0;
    var_a4ebd652 = level.zombie_vars["zombie_spawn_delay"];
    thread function_5b2f22da();
    var_f01299fd = [];
    switch (level.var_413be39d) {
    case "initial_round":
        var_f01299fd = getentarray("initial_first_round_quad_spawner", "targetname");
        break;
    case "theater_round":
        var_f01299fd = getentarray("initial_theater_round_quad_spawner", "targetname");
        break;
    default:
        assertmsg("<dev string:x57>");
        return;
    }
    if (var_f01299fd.size < 1) {
        assertmsg("<dev string:x86>");
        return;
    }
    while (true) {
        if (isdefined(level.var_fcc1cf12)) {
            function_e231d85(timer);
        }
        level.var_fcc1cf12 = 1;
        function_4d4195d5(var_f01299fd);
        wait 0.2;
        spawned++;
        if (spawned > level.var_cd4ee9ce) {
            break;
        }
    }
    spawned = 0;
    var_30881ca7 = [];
    switch (level.var_413be39d) {
    case "initial_round":
        var_30881ca7 = getentarray("initial_first_round_quad_spawner_second_wave", "targetname");
        break;
    case "theater_round":
        var_30881ca7 = getentarray("theater_round_quad_spawner_second_wave", "targetname");
        break;
    default:
        assertmsg("<dev string:xb1>");
        return;
    }
    if (var_30881ca7.size < 1) {
        assertmsg("<dev string:xda>");
        return;
    }
    while (true) {
        function_e231d85(timer);
        function_4d4195d5(var_30881ca7);
        wait 0.2;
        spawned++;
        if (spawned > level.var_cd4ee9ce * 2) {
            break;
        }
    }
    level.zombie_vars["zombie_spawn_delay"] = var_a4ebd652;
    level.zombie_health = level.zombie_vars["zombie_health_start"];
    level.zombie_total = 0;
    level.round_spawn_func = &zm::round_spawning;
    level thread [[ level.round_spawn_func ]]();
    wait 2;
    level notify(#"hash_69490d68");
    level.var_fcc1cf12 = undefined;
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0xc295855a, Offset: 0x1df8
// Size: 0x11e
function function_e231d85(start_timer) {
    if (gettime() - start_timer < 15000) {
        level.zombie_vars["zombie_spawn_delay"] = randomintrange(30, 45);
        return;
    }
    if (gettime() - start_timer < 25000) {
        level.zombie_vars["zombie_spawn_delay"] = randomintrange(15, 30);
        return;
    }
    if (gettime() - start_timer < 35000) {
        level.zombie_vars["zombie_spawn_delay"] = randomintrange(10, 15);
        return;
    }
    if (gettime() - start_timer < 50000) {
        level.zombie_vars["zombie_spawn_delay"] = randomintrange(5, 10);
    }
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0x7cd9e68d, Offset: 0x1f20
// Size: 0xe4
function function_370931ae() {
    zone = level.zones["foyer_zone"];
    while (true) {
        if (zone.is_occupied) {
            flag::set("lobby_occupied");
            break;
        }
        util::wait_network_frame();
    }
    function_2127be6f(5);
    wait 0.4;
    function_2127be6f(6);
    wait 2;
    function_2127be6f(7);
    wait 1;
    function_2127be6f(8);
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0x126de1ce, Offset: 0x2010
// Size: 0xac
function function_34e51315() {
    level endon(#"hash_e1db2a20");
    zone = level.zones["dining_zone"];
    while (true) {
        if (zone.is_occupied) {
            flag::set("dining_occupied");
            break;
        }
        util::wait_network_frame();
    }
    function_2127be6f(9);
    wait 1;
    function_2127be6f(10);
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0x894e9259, Offset: 0x20c8
// Size: 0x15c
function quad_stage_roof_break() {
    function_2127be6f(1);
    wait 2;
    function_2127be6f(3);
    wait 0.33;
    function_2127be6f(2);
    wait 1;
    function_2127be6f(0);
    wait 0.45;
    function_2127be6f(4);
    level thread function_38913340();
    wait 0.33;
    function_2127be6f(15);
    wait 0.4;
    function_2127be6f(11);
    wait 0.45;
    function_2127be6f(12);
    wait 0.3;
    function_2127be6f(13);
    wait 0.35;
    function_2127be6f(14);
    zm_ai_quad::function_5af423f4();
}

// Namespace zm_theater_quad
// Params 1, eflags: 0x0
// Checksum 0xd0e5aeb3, Offset: 0x2230
// Size: 0x5c
function function_2127be6f(index) {
    trigger = getent("quad_roof_crumble_fx_origin_" + index, "target");
    trigger thread function_55842bd2(index);
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0xce845c53, Offset: 0x2298
// Size: 0x74
function function_38913340() {
    players = getplayers();
    player = players[randomintrange(0, players.size)];
    player zm_audio::create_and_play_dialog("general", "quad_spawn");
}

// Namespace zm_theater_quad
// Params 0, eflags: 0x0
// Checksum 0xfc971e39, Offset: 0x2318
// Size: 0xd6
function function_79dea782() {
    trigger = getent("quad_roof_crumble_fx_origin_10", "target");
    trigger waittill(#"trigger", who);
    level notify(#"hash_e1db2a20");
    var_8df89230 = getentarray(trigger.target, "targetname");
    if (isdefined(var_8df89230)) {
        for (i = 0; i < var_8df89230.size; i++) {
            var_8df89230[i] delete();
        }
    }
}

