#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_dev;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_supplydrop;
#using scripts/shared/array_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/weapons/_weapons;

#namespace dogs;

// Namespace dogs
// Params 0, eflags: 0x0
// Checksum 0x2a653e0, Offset: 0x438
// Size: 0x9c
function init() {
    level.dog_targets = [];
    level.dog_targets[level.dog_targets.size] = "trigger_radius";
    level.dog_targets[level.dog_targets.size] = "trigger_multiple";
    level.dog_targets[level.dog_targets.size] = "trigger_use_touch";
    level.var_a16d1f64 = [];
    /#
        level thread function_cced6d39();
    #/
    level.dogsonflashdogs = &function_f436e711;
}

// Namespace dogs
// Params 0, eflags: 0x0
// Checksum 0x22939cd3, Offset: 0x4e0
// Size: 0x254
function init_spawns() {
    spawns = getnodearray("spawn", "script_noteworthy");
    if (!isdefined(spawns) || !spawns.size) {
        println("<dev string:x28>");
        return;
    }
    dog_spawner = getent("dog_spawner", "targetname");
    if (!isdefined(dog_spawner)) {
        println("<dev string:x48>");
        return;
    }
    valid = spawnlogic::get_spawnpoint_array("mp_tdm_spawn");
    dog = dog_spawner spawnfromspawner();
    foreach (spawn in spawns) {
        valid = arraysort(valid, spawn.origin, 0);
        for (i = 0; i < 5; i++) {
            if (dog findpath(spawn.origin, valid[i].origin, 1, 0)) {
                level.var_a16d1f64[level.var_a16d1f64.size] = spawn;
                break;
            }
        }
    }
    /#
        if (!level.var_a16d1f64.size) {
            println("<dev string:x6b>");
        }
    #/
    dog delete();
}

// Namespace dogs
// Params 0, eflags: 0x0
// Checksum 0x324c5507, Offset: 0x740
// Size: 0x26
function initkillstreak() {
    if (tweakables::gettweakablevalue("killstreak", "allowdogs")) {
    }
}

// Namespace dogs
// Params 1, eflags: 0x0
// Checksum 0x8b806b4e, Offset: 0x770
// Size: 0x1d6
function function_98406011(hardpointtype) {
    if (!function_62a07a8b()) {
        return false;
    }
    if (!self killstreakrules::iskillstreakallowed(hardpointtype, self.team)) {
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart("dogs", self.team);
    self thread function_4aae4772();
    if (killstreak_id == -1) {
        return false;
    }
    if (level.teambased) {
        foreach (team in level.teams) {
            if (team == self.team) {
            }
        }
    }
    self killstreaks::play_killstreak_start_dialog("dogs", self.team, 1);
    self addweaponstat(getweapon("dogs"), "used", 1);
    var_544a3985 = self.deathcount;
    level thread function_ec5275d9(self, var_544a3985, killstreak_id);
    level notify(#"hash_643b7356");
    return true;
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x56a80cd6, Offset: 0x950
// Size: 0x6a
function function_4aae4772() {
    self endon(#"disconnect");
    self.var_6903e20a = 1;
    self.var_1f6801c8 = 0;
    self util::waittill_any("death", "game_over", "dogs_complete");
    self.var_1f6801c8 = 0;
    self.var_6903e20a = undefined;
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x7fd773a3, Offset: 0x9c8
// Size: 0x11c
function function_62a07a8b() {
    dog_spawner = getent("dog_spawner", "targetname");
    if (!isdefined(dog_spawner)) {
        println("<dev string:x93>");
        return false;
    }
    spawns = getnodearray("spawn", "script_noteworthy");
    if (level.var_a16d1f64.size <= 0) {
        println("<dev string:x28>");
        return false;
    }
    exits = getnodearray("exit", "script_noteworthy");
    if (exits.size <= 0) {
        println("<dev string:xb0>");
        return false;
    }
    return true;
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x5352915e, Offset: 0xaf0
// Size: 0x44
function function_1b915ebe() {
    self setmodel("german_shepherd_vest");
    self setenemymodel("german_shepherd_vest_black");
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0xb94f430d, Offset: 0xb40
// Size: 0x134
function init_dog() {
    assert(isai(self));
    self.targetname = "attack_dog";
    self.animtree = "dog.atr";
    self.type = "dog";
    self.accuracy = 0.2;
    self.health = 100;
    self.maxhealth = 100;
    self.secondaryweapon = "";
    self.sidearm = "";
    self.grenadeammo = 0;
    self.goalradius = -128;
    self.nododgemove = 1;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.disablearrivals = 0;
    self.pathenemyfightdist = 512;
    self.soundmod = "dog";
    self thread function_e5624260();
    self thread function_67f34e48();
}

// Namespace dogs
// Params 2, eflags: 0x1 linked
// Checksum 0x738f80f7, Offset: 0xc80
// Size: 0x52
function function_7181571a(owner, team) {
    assert(level.var_a16d1f64.size > 0);
    return array::random(level.var_a16d1f64);
}

// Namespace dogs
// Params 2, eflags: 0x0
// Checksum 0x7a0cb52, Offset: 0xce0
// Size: 0x156
function function_10582f80(origin, team) {
    players = getplayers();
    score = 0;
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        if (!isalive(player)) {
            continue;
        }
        if (player.sessionstate != "playing") {
            continue;
        }
        if (distancesquared(player.origin, origin) > 4194304) {
            continue;
        }
        if (player.team == team) {
            score++;
            continue;
        }
        score--;
    }
    return score;
}

// Namespace dogs
// Params 3, eflags: 0x1 linked
// Checksum 0xa569e7ea, Offset: 0xe40
// Size: 0x4c
function function_6ece2d8c(owner, team, requireddeathcount) {
    self setentityowner(owner);
    self.team = team;
    self.requireddeathcount = requireddeathcount;
}

// Namespace dogs
// Params 1, eflags: 0x1 linked
// Checksum 0xb238d42c, Offset: 0xe98
// Size: 0x2c
function function_971fce06(team) {
    self spawning::create_entity_enemy_influencer("dog", team);
}

// Namespace dogs
// Params 4, eflags: 0x1 linked
// Checksum 0x9c07771e, Offset: 0xed0
// Size: 0x168
function function_4b764fa6(owner, team, spawn_node, requireddeathcount) {
    dog_spawner = getent("dog_spawner", "targetname");
    dog = dog_spawner spawnfromspawner();
    dog forceteleport(spawn_node.origin, spawn_node.angles);
    dog init_dog();
    dog function_6ece2d8c(owner, team, requireddeathcount);
    dog function_1b915ebe();
    dog function_971fce06(team);
    dog thread function_62d0f1eb();
    dog thread function_8262b7af();
    dog thread dog_patrol();
    dog thread function_49bbd420();
    return dog;
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x539189a1, Offset: 0x1040
// Size: 0x130
function function_49bbd420() {
    self endon(#"death");
    while (true) {
        self waittill(#"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
        if (weapon_utils::isflashorstunweapon(weapon)) {
            damage_area = spawn("trigger_radius", self.origin, 0, -128, -128);
            attacker thread function_f436e711(damage_area);
            wait 0.05;
            damage_area delete();
        }
    }
}

// Namespace dogs
// Params 3, eflags: 0x1 linked
// Checksum 0x72b8c546, Offset: 0x1178
// Size: 0x1f8
function function_ec5275d9(owner, deathcount, killstreak_id) {
    requireddeathcount = deathcount;
    team = owner.team;
    level.var_fb1a25fe = 0;
    owner thread function_1415306e();
    level thread function_ab8fa017();
    count = 0;
    while (count < 10) {
        if (level.var_fb1a25fe) {
            break;
        }
        for (dogs = function_b944b696(); dogs.size < 5 && count < 10 && !level.var_fb1a25fe; dogs = function_b944b696()) {
            node = function_7181571a(owner, team);
            level function_4b764fa6(owner, team, node, requireddeathcount);
            count++;
            wait randomfloatrange(2, 5);
        }
        level waittill(#"hash_39475062");
    }
    for (;;) {
        dogs = function_b944b696();
        if (dogs.size <= 0) {
            killstreakrules::killstreakstop("dogs", team, killstreak_id);
            if (isdefined(owner)) {
                owner notify(#"dogs_complete");
            }
            return;
        }
        level waittill(#"hash_39475062");
    }
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x838e86bc, Offset: 0x1378
// Size: 0xba
function function_fb1a25fe() {
    level.var_fb1a25fe = 1;
    dogs = function_b944b696();
    foreach (dog in dogs) {
        dog notify(#"abort");
    }
    level notify(#"hash_fb1a25fe");
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x6da8c16e, Offset: 0x1440
// Size: 0x4c
function function_1415306e() {
    level endon(#"hash_fb1a25fe");
    self util::wait_endon(45, "disconnect", "joined_team", "joined_spectators");
    function_fb1a25fe();
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x8ae54b2b, Offset: 0x1498
// Size: 0x2c
function function_ab8fa017() {
    level endon(#"hash_fb1a25fe");
    level waittill(#"game_ended");
    function_fb1a25fe();
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x1f289264, Offset: 0x14d0
// Size: 0x1e
function function_8262b7af() {
    self waittill(#"death");
    level notify(#"hash_39475062");
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x5949c951, Offset: 0x14f8
// Size: 0x9c
function function_25a98345() {
    self clearentitytarget();
    self.ignoreall = 1;
    self.goalradius = 30;
    self setgoal(self function_e5321612());
    self util::wait_endon(20, "goal", "bad_path");
    self delete();
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x312d15bc, Offset: 0x15a0
// Size: 0x428
function dog_patrol() {
    self endon(#"death");
    /#
        self endon(#"hash_9d163ef3");
    #/
    for (;;) {
        if (level.var_fb1a25fe) {
            self function_25a98345();
            return;
        }
        if (isdefined(self.enemy)) {
            wait randomintrange(3, 5);
            continue;
        }
        nodes = [];
        objectives = function_c5dd1773();
        for (i = 0; i < objectives.size; i++) {
            objective = array::random(objectives);
            nodes = getnodesinradius(objective.origin, 256, 64, 512, "Path", 16);
            if (nodes.size) {
                break;
            }
        }
        if (!nodes.size) {
            player = self function_b973c0b6();
            if (isdefined(player)) {
                nodes = getnodesinradius(player.origin, 1024, 0, -128, "Path", 8);
            }
        }
        if (!nodes.size && isdefined(self.script_owner)) {
            if (isalive(self.script_owner) && self.script_owner.sessionstate == "playing") {
                nodes = getnodesinradius(self.script_owner.origin, 512, 256, 512, "Path", 16);
            }
        }
        if (!nodes.size) {
            nodes = getnodesinradius(self.origin, 1024, 512, 512, "Path");
        }
        if (nodes.size) {
            nodes = array::randomize(nodes);
            foreach (node in nodes) {
                if (isdefined(node.script_noteworthy)) {
                    continue;
                }
                if (isdefined(node.var_88aac8ef) && isalive(node.var_88aac8ef)) {
                    continue;
                }
                self setgoal(node);
                node.var_88aac8ef = self;
                nodes = [];
                event = self util::waittill_any_return("goal", "bad_path", "enemy", "abort");
                if (event == "goal") {
                    util::wait_endon(randomintrange(3, 5), "damage", "enemy", "abort");
                }
                node.var_88aac8ef = undefined;
                break;
            }
        }
        wait 0.5;
    }
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0xefc2129d, Offset: 0x19d0
// Size: 0x2c2
function function_c5dd1773() {
    if (!isdefined(level.var_4dec1e08)) {
        level.var_4dec1e08 = [];
        level.var_15d329d5 = 0;
    }
    if (level.gametype == "tdm" || level.gametype == "dm") {
        return level.var_4dec1e08;
    }
    if (gettime() >= level.var_15d329d5) {
        level.var_4dec1e08 = [];
        foreach (target in level.dog_targets) {
            ents = getentarray(target, "classname");
            foreach (ent in ents) {
                if (level.gametype == "koth") {
                    if (isdefined(ent.targetname) && ent.targetname == "radiotrigger") {
                        level.var_4dec1e08[level.var_4dec1e08.size] = ent;
                    }
                    continue;
                }
                if (level.gametype == "sd") {
                    if (isdefined(ent.targetname) && ent.targetname == "bombzone") {
                        level.var_4dec1e08[level.var_4dec1e08.size] = ent;
                    }
                    continue;
                }
                if (!isdefined(ent.script_gameobjectname)) {
                    continue;
                }
                if (!issubstr(ent.script_gameobjectname, level.gametype)) {
                    continue;
                }
                level.var_4dec1e08[level.var_4dec1e08.size] = ent;
            }
        }
        level.var_15d329d5 = gettime() + randomintrange(5000, 10000);
    }
    return level.var_4dec1e08;
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x39d191e7, Offset: 0x1ca0
// Size: 0x204
function function_b973c0b6() {
    players = getplayers();
    closest = undefined;
    distsq = 99999999;
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        if (!isalive(player)) {
            continue;
        }
        if (player.sessionstate != "playing") {
            continue;
        }
        if (isdefined(self.script_owner) && player == self.script_owner) {
            continue;
        }
        if (level.teambased) {
            if (player.team == self.team) {
                continue;
            }
        }
        if (gettime() - player.lastfiretime > 3000) {
            continue;
        }
        if (!isdefined(closest)) {
            closest = player;
            distsq = distancesquared(self.origin, player.origin);
            continue;
        }
        d = distancesquared(self.origin, player.origin);
        if (d < distsq) {
            closest = player;
            distsq = d;
        }
    }
    return closest;
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0xd7ae0f62, Offset: 0x1eb0
// Size: 0x34
function function_b944b696() {
    dogs = getentarray("attack_dog", "targetname");
    return dogs;
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x22772305, Offset: 0x1ef0
// Size: 0x74
function function_62d0f1eb() {
    if (!isdefined(self.script_owner)) {
        return;
    }
    self endon(#"clear_owner");
    self endon(#"death");
    self.script_owner endon(#"disconnect");
    while (true) {
        self waittill(#"killed", player);
        self.script_owner notify(#"hash_18faeaac");
    }
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0xd5909501, Offset: 0x1f70
// Size: 0x130
function function_e5624260() {
    self endon(#"death");
    interval = 0.5;
    regen_interval = int(self.health / 5 * interval);
    var_c5fb7989 = 2;
    for (;;) {
        self waittill(#"damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon, idflags);
        self trackattackerdamage(attacker);
        self thread function_f7ae2e49(var_c5fb7989, interval, regen_interval);
    }
}

// Namespace dogs
// Params 1, eflags: 0x1 linked
// Checksum 0x6c0b8740, Offset: 0x20a8
// Size: 0x112
function trackattackerdamage(attacker) {
    if (!isdefined(attacker) || !isplayer(attacker) || !isdefined(self.script_owner)) {
        return;
    }
    if (level.teambased && attacker.team == self.script_owner.team || attacker == self) {
        return;
    }
    if (!isdefined(self.attackerdata) || !isdefined(self.attackers)) {
        self.attackerdata = [];
        self.attackers = [];
    }
    if (!isdefined(self.attackerdata[attacker.clientid])) {
        self.attackerclientid[attacker.clientid] = spawnstruct();
        self.attackers[self.attackers.size] = attacker;
    }
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x134bc54b, Offset: 0x21c8
// Size: 0x1c
function function_71fb32a8() {
    self.attackerdata = [];
    self.attackers = [];
}

// Namespace dogs
// Params 3, eflags: 0x1 linked
// Checksum 0x933d17ca, Offset: 0x21f0
// Size: 0xb8
function function_f7ae2e49(delay, interval, regen_interval) {
    self endon(#"death");
    self endon(#"damage");
    wait delay;
    for (step = 0; step <= 5; step += interval) {
        if (self.health >= 100) {
            break;
        }
        self.health += regen_interval;
        wait interval;
    }
    self function_71fb32a8();
    self.health = 100;
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x7e8e896, Offset: 0x22b0
// Size: 0x150
function function_67f34e48() {
    self waittill(#"death", attacker);
    if (isdefined(attacker) && isplayer(attacker)) {
        if (isdefined(self.script_owner) && self.script_owner == attacker) {
            return;
        }
        if (level.teambased && isdefined(self.script_owner) && self.script_owner.team == attacker.team) {
            return;
        }
        if (isdefined(self.attackers)) {
            foreach (player in self.attackers) {
                if (player != attacker) {
                    scoreevents::processscoreevent("killed_dog_assist", player);
                }
            }
        }
        attacker notify(#"hash_f716f816");
    }
}

// Namespace dogs
// Params 0, eflags: 0x1 linked
// Checksum 0x87377071, Offset: 0x2408
// Size: 0x4a
function function_e5321612() {
    exits = getnodearray("exit", "script_noteworthy");
    return arraygetclosest(self.origin, exits);
}

// Namespace dogs
// Params 1, eflags: 0x1 linked
// Checksum 0x390c18fe, Offset: 0x2460
// Size: 0x1e2
function function_f436e711(area) {
    self endon(#"disconnect");
    dogs = function_b944b696();
    foreach (dog in dogs) {
        if (!isalive(dog)) {
            continue;
        }
        if (dog istouching(area)) {
            var_1e4494fd = 1;
            if (isplayer(self)) {
                if (level.teambased && dog.team == self.team) {
                    var_1e4494fd = 0;
                } else if (!level.teambased && isdefined(dog.script_owner) && self == dog.script_owner) {
                    var_1e4494fd = 0;
                }
            }
            if (isdefined(dog.var_3d2daafa) && dog.var_3d2daafa + 1500 > gettime()) {
                var_1e4494fd = 0;
            }
            if (var_1e4494fd) {
                dog setflashbanged(1, 500);
                dog.var_3d2daafa = gettime();
            }
        }
    }
}

/#

    // Namespace dogs
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9ecbeb6b, Offset: 0x2650
    // Size: 0x2a0
    function function_cced6d39() {
        setdvar("<dev string:xcf>", "<dev string:xda>");
        var_9d163ef3 = 0;
        for (;;) {
            cmd = getdvarstring("<dev string:xcf>");
            switch (cmd) {
            case "<dev string:xdb>":
                player = util::gethostplayer();
                function_40fd21d0(player.team);
                break;
            case "<dev string:xea>":
                player = util::gethostplayer();
                foreach (team in level.teams) {
                    if (team == player.team) {
                        continue;
                    }
                    function_40fd21d0(team);
                }
                break;
            case "<dev string:xf6>":
                level function_fb1a25fe();
                break;
            case "<dev string:x102>":
                function_dd7ddc82();
                break;
            case "<dev string:x10d>":
                function_649863ab();
                break;
            case "<dev string:x119>":
                function_545a4b27();
                break;
            case "<dev string:x127>":
                function_a4d2dcc5();
                break;
            case "<dev string:x133>":
                function_7cc16e06();
                break;
            case "<dev string:x13e>":
                function_d20cb955();
                break;
            }
            if (cmd != "<dev string:xda>") {
                setdvar("<dev string:xcf>", "<dev string:xda>");
            }
            wait 0.5;
        }
    }

    // Namespace dogs
    // Params 1, eflags: 0x1 linked
    // Checksum 0x31f8ad6e, Offset: 0x28f8
    // Size: 0x2a4
    function function_40fd21d0(team) {
        player = util::gethostplayer();
        dog_spawner = getent("<dev string:x14a>", "<dev string:x156>");
        level.var_fb1a25fe = 0;
        if (!isdefined(dog_spawner)) {
            iprintln("<dev string:x93>");
            return;
        }
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        nodes = getnodesinradius(trace["<dev string:x161>"], 256, 0, -128, "<dev string:x16a>", 8);
        if (!nodes.size) {
            iprintln("<dev string:x16f>");
            return;
        }
        iprintln("<dev string:x196>");
        node = arraygetclosest(trace["<dev string:x161>"], nodes);
        dog = function_4b764fa6(player, player.team, node, 5);
        if (team != player.team) {
            dog.team = team;
            dog clearentityowner();
            dog notify(#"clear_owner");
        }
    }

    // Namespace dogs
    // Params 0, eflags: 0x1 linked
    // Checksum 0x62ef81d8, Offset: 0x2ba8
    // Size: 0x2b4
    function function_dd7ddc82() {
        player = util::gethostplayer();
        if (!isdefined(level.var_dd7ddc82)) {
            level.var_dd7ddc82 = 0;
        }
        dog = undefined;
        dogs = function_b944b696();
        if (dogs.size <= 0) {
            level.var_dd7ddc82 = undefined;
            player cameraactivate(0);
            return;
        }
        for (i = 0; i < dogs.size; i++) {
            dog = dogs[i];
            if (!isdefined(dog) || !isalive(dog)) {
                dog = undefined;
                continue;
            }
            if (!isdefined(dog.cam)) {
                forward = anglestoforward(dog.angles);
                dog.cam = spawn("<dev string:x1be>", dog.origin + (0, 0, 50) + forward * -100);
                dog.cam setmodel("<dev string:x1cb>");
                dog.cam linkto(dog);
            }
            if (dog getentitynumber() <= level.var_dd7ddc82) {
                dog = undefined;
                continue;
            }
            break;
        }
        if (isdefined(dog)) {
            level.var_dd7ddc82 = dog getentitynumber();
            player camerasetposition(dog.cam);
            player camerasetlookat(dog);
            player cameraactivate(1);
            return;
        }
        level.var_dd7ddc82 = undefined;
        player cameraactivate(0);
    }

    // Namespace dogs
    // Params 0, eflags: 0x1 linked
    // Checksum 0x41e2f501, Offset: 0x2e68
    // Size: 0x184
    function function_649863ab() {
        player = util::gethostplayer();
        direction = player getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = player geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        trace = bullettrace(eye, eye + direction_vec, 0, undefined);
        killcament = spawn("<dev string:x1be>", player.origin);
        level thread supplydrop::dropcrate(trace["<dev string:x161>"] + (0, 0, 25), direction, "<dev string:x1d6>", player, player.team, killcament);
    }

    // Namespace dogs
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6f94ca20, Offset: 0x2ff8
    // Size: 0x70
    function function_545a4b27() {
        if (!isdefined(level.var_e840cd0a)) {
            return;
        }
        for (i = 0; i < level.var_e840cd0a.size; i++) {
            level.var_e840cd0a[i] delete();
        }
        level.var_e840cd0a = [];
    }

    // Namespace dogs
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9f172e2f, Offset: 0x3070
    // Size: 0xce
    function function_a4d2dcc5() {
        if (!isdefined(level.var_6eb95783)) {
            level.var_6eb95783 = 1;
        } else {
            level.var_6eb95783 = !level.var_6eb95783;
        }
        if (!level.var_6eb95783) {
            level notify(#"hash_a4038b1");
            return;
        }
        spawns = level.var_a16d1f64;
        color = (0, 1, 0);
        for (i = 0; i < spawns.size; i++) {
            dev::showonespawnpoint(spawns[i], color, "<dev string:x1e1>", 32, "<dev string:x1f1>");
        }
    }

    // Namespace dogs
    // Params 0, eflags: 0x1 linked
    // Checksum 0x998ce2a5, Offset: 0x3148
    // Size: 0xe6
    function function_7cc16e06() {
        if (!isdefined(level.var_5d3f68b4)) {
            level.var_5d3f68b4 = 1;
        } else {
            level.var_5d3f68b4 = !level.var_5d3f68b4;
        }
        if (!level.var_5d3f68b4) {
            level notify(#"hash_92f820ac");
            return;
        }
        exits = getnodearray("<dev string:x1fb>", "<dev string:x200>");
        color = (1, 0, 0);
        for (i = 0; i < exits.size; i++) {
            dev::showonespawnpoint(exits[i], color, "<dev string:x212>", 32, "<dev string:x221>");
        }
    }

    // Namespace dogs
    // Params 2, eflags: 0x1 linked
    // Checksum 0x482f3a8d, Offset: 0x3238
    // Size: 0xbe
    function function_3c74d4e2(node1, node2) {
        self endon(#"death");
        self endon(#"hash_9d163ef3");
        for (;;) {
            self setgoal(node1);
            self util::waittill_any("<dev string:x22a>", "<dev string:x22f>");
            wait 1;
            self setgoal(node2);
            self util::waittill_any("<dev string:x22a>", "<dev string:x22f>");
            wait 1;
        }
    }

    // Namespace dogs
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf8413aaf, Offset: 0x3300
    // Size: 0xe4
    function function_d20cb955() {
        iprintln("<dev string:x238>");
        nodes = dev::dev_get_node_pair();
        if (!isdefined(nodes)) {
            iprintln("<dev string:x265>");
            return;
        }
        iprintln("<dev string:x27b>");
        dogs = function_b944b696();
        if (isdefined(dogs[0])) {
            dogs[0] notify(#"hash_9d163ef3");
            dogs[0] thread function_3c74d4e2(nodes[0], nodes[1]);
        }
    }

#/
