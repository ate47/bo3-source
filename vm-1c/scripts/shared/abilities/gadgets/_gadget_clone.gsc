#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/_oob;
#using scripts/shared/array_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_puppeteer_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_b3cf5df2;

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x2
// Checksum 0xc858ee47, Offset: 0x520
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_clone", &__init__, undefined, undefined);
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x1 linked
// Checksum 0x11944b9a, Offset: 0x560
// Size: 0x180
function __init__() {
    ability_player::register_gadget_activation_callbacks(42, &function_33fadcbd, &function_e4fe20c9);
    ability_player::register_gadget_possession_callbacks(42, &function_a3f945fb, &function_a0ce69d9);
    ability_player::register_gadget_flicker_callbacks(42, &function_7f1c395c);
    ability_player::register_gadget_is_inuse_callbacks(42, &function_2dc12c1d);
    ability_player::register_gadget_is_flickering_callbacks(42, &function_e014cba9);
    callback::on_connect(&function_b05b9d52);
    clientfield::register("actor", "clone_activated", 1, 1, "int");
    clientfield::register("actor", "clone_damaged", 1, 1, "int");
    clientfield::register("allplayers", "clone_activated", 1, 1, "int");
    level.var_344bec77 = [];
}

// Namespace namespace_b3cf5df2
// Params 1, eflags: 0x1 linked
// Checksum 0x350f0493, Offset: 0x6e8
// Size: 0x22
function function_2dc12c1d(slot) {
    return self gadgetisactive(slot);
}

// Namespace namespace_b3cf5df2
// Params 1, eflags: 0x1 linked
// Checksum 0x4db29cf4, Offset: 0x718
// Size: 0x22
function function_e014cba9(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_b3cf5df2
// Params 2, eflags: 0x1 linked
// Checksum 0x7c3ee49a, Offset: 0x748
// Size: 0x14
function function_7f1c395c(slot, weapon) {
    
}

// Namespace namespace_b3cf5df2
// Params 2, eflags: 0x1 linked
// Checksum 0x9644b0bc, Offset: 0x768
// Size: 0x14
function function_a3f945fb(slot, weapon) {
    
}

// Namespace namespace_b3cf5df2
// Params 2, eflags: 0x1 linked
// Checksum 0x6375ff4, Offset: 0x788
// Size: 0x14
function function_a0ce69d9(slot, weapon) {
    
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x7a8
// Size: 0x4
function function_b05b9d52() {
    
}

// Namespace namespace_b3cf5df2
// Params 1, eflags: 0x1 linked
// Checksum 0xd3923544, Offset: 0x7b8
// Size: 0xb2
function function_758b65c7(player) {
    if (isdefined(player.var_344bec77)) {
        foreach (clone in player.var_344bec77) {
            if (isdefined(clone)) {
                clone notify(#"clone_shutdown");
            }
        }
    }
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x1 linked
// Checksum 0xaefc1c0b, Offset: 0x878
// Size: 0x30
function is_jumping() {
    ground_ent = self getgroundent();
    return !isdefined(ground_ent);
}

// Namespace namespace_b3cf5df2
// Params 3, eflags: 0x1 linked
// Checksum 0x850bc2a1, Offset: 0x8b0
// Size: 0x458
function function_cc23883e(origin, angles, var_9b74dfd5) {
    player = self;
    startangles = [];
    testangles = [];
    testangles[0] = (0, 0, 0);
    testangles[1] = (0, -30, 0);
    testangles[2] = (0, 30, 0);
    testangles[3] = (0, -60, 0);
    testangles[4] = (0, 60, 0);
    testangles[5] = (0, 90, 0);
    testangles[6] = (0, -90, 0);
    testangles[7] = (0, 120, 0);
    testangles[8] = (0, -120, 0);
    testangles[9] = (0, 150, 0);
    testangles[10] = (0, -150, 0);
    testangles[11] = (0, 180, 0);
    validspawns = spawnstruct();
    validpositions = [];
    var_1af83dc1 = [];
    var_65919fef = [];
    var_65919fef[0] = 5;
    var_65919fef[1] = 0;
    if (player is_jumping()) {
        var_65919fef[2] = -5;
    }
    foreach (var_93742eb4 in var_65919fef) {
        for (i = 0; i < testangles.size; i++) {
            startangles[i] = (0, angles[1], 0);
            startpoint = origin + vectorscale(anglestoforward(startangles[i] + testangles[i]), var_9b74dfd5);
            startpoint += (0, 0, var_93742eb4);
            if (playerpositionvalidignoreent(startpoint, self)) {
                var_eac6c670 = getclosestpointonnavmesh(startpoint, 500);
                if (isdefined(var_eac6c670)) {
                    startpoint = var_eac6c670;
                    trace = groundtrace(startpoint + (0, 0, 24), startpoint - (0, 0, 24), 0, 0, 0);
                    if (isdefined(trace["position"])) {
                        startpoint = trace["position"];
                    }
                }
                validpositions[validpositions.size] = startpoint;
                var_1af83dc1[var_1af83dc1.size] = startangles[i] + testangles[i];
                if (var_1af83dc1.size == 3) {
                    break;
                }
            }
        }
        if (var_1af83dc1.size == 3) {
            break;
        }
    }
    validspawns.validpositions = validpositions;
    validspawns.var_1af83dc1 = var_1af83dc1;
    return validspawns;
}

// Namespace namespace_b3cf5df2
// Params 1, eflags: 0x1 linked
// Checksum 0xf92e0437, Offset: 0xd10
// Size: 0xcc
function function_f07af5b9(clone) {
    var_c2a5460c = 0;
    for (i = 0; i < 20; i++) {
        if (!isdefined(level.var_344bec77[i])) {
            level.var_344bec77[i] = clone;
            var_c2a5460c = 1;
            println("spawner_bo3_human_male_reaper_mp" + i + "spawner_bo3_human_male_reaper_mp" + level.var_344bec77.size);
            break;
        }
    }
    assert(var_c2a5460c);
}

// Namespace namespace_b3cf5df2
// Params 1, eflags: 0x1 linked
// Checksum 0x52288752, Offset: 0xde8
// Size: 0xc2
function function_d1901738(clone) {
    for (i = 0; i < 20; i++) {
        if (isdefined(level.var_344bec77[i]) && level.var_344bec77[i] == clone) {
            level.var_344bec77[i] = undefined;
            array::remove_undefined(level.var_344bec77);
            println("spawner_bo3_human_male_reaper_mp" + i + "spawner_bo3_human_male_reaper_mp" + level.var_344bec77.size);
            break;
        }
    }
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x1 linked
// Checksum 0x5e073c7b, Offset: 0xeb8
// Size: 0x17c
function function_270d5923() {
    assert(level.var_344bec77.size == 20);
    var_bfc60b37 = undefined;
    for (i = 0; i < 20; i++) {
        if (!isdefined(var_bfc60b37) && isdefined(level.var_344bec77[i])) {
            var_bfc60b37 = level.var_344bec77[i];
            oldestindex = i;
            continue;
        }
        if (isdefined(level.var_344bec77[i]) && level.var_344bec77[i].spawntime < var_bfc60b37.spawntime) {
            var_bfc60b37 = level.var_344bec77[i];
            oldestindex = i;
        }
    }
    println("spawner_bo3_human_male_reaper_mp" + i + "spawner_bo3_human_male_reaper_mp" + level.var_344bec77.size);
    level.var_344bec77[oldestindex] notify(#"clone_shutdown");
    level.var_344bec77[oldestindex] = undefined;
    array::remove_undefined(level.var_344bec77);
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x1 linked
// Checksum 0x9458309d, Offset: 0x1040
// Size: 0x494
function function_aeb6047c() {
    self endon(#"death");
    self function_758b65c7(self);
    self.var_344bec77 = [];
    velocity = self getvelocity();
    velocity += (0, 0, velocity[2] * -1);
    velocity = vectornormalize(velocity);
    origin = self.origin + velocity * 17 + vectorscale(anglestoforward(self getangles()), 17);
    validspawns = function_cc23883e(origin, self getangles(), 60);
    if (validspawns.validpositions.size < 3) {
        var_fe7719fa = function_cc23883e(origin, self getangles(), -76);
        for (index = 0; index < var_fe7719fa.validpositions.size && validspawns.validpositions.size < 3; index++) {
            validspawns.validpositions[validspawns.validpositions.size] = var_fe7719fa.validpositions[index];
            validspawns.var_1af83dc1[validspawns.var_1af83dc1.size] = var_fe7719fa.var_1af83dc1[index];
        }
    }
    for (i = 0; i < validspawns.validpositions.size; i++) {
        traveldistance = distance(validspawns.validpositions[i], self.origin);
        validspawns.spawntimes[i] = traveldistance / 800;
        self thread function_c030222c(validspawns.validpositions[i], validspawns.spawntimes[i]);
    }
    for (i = 0; i < validspawns.validpositions.size; i++) {
        if (level.var_344bec77.size < 20) {
        } else {
            function_270d5923();
        }
        clone = spawnactor("spawner_bo3_human_male_reaper_mp", validspawns.validpositions[i], validspawns.var_1af83dc1[i], "", 1);
        /#
            recordcircle(validspawns.validpositions[i], 2, (1, 0.5, 0), "spawner_bo3_human_male_reaper_mp", clone);
        #/
        function_27c360b(clone, self, anglestoforward(validspawns.var_1af83dc1[i]), validspawns.spawntimes[i]);
        self.var_344bec77[self.var_344bec77.size] = clone;
        function_f07af5b9(clone);
        wait(0.05);
    }
    self notify(#"hash_bc9b8fc");
    if (self oob::isoutofbounds()) {
        function_e4fe20c9(self, undefined);
    }
}

// Namespace namespace_b3cf5df2
// Params 2, eflags: 0x1 linked
// Checksum 0x65dd9e24, Offset: 0x14e0
// Size: 0xcc
function function_33fadcbd(slot, weapon) {
    self clientfield::set("clone_activated", 1);
    self flagsys::set("clone_activated");
    fx = playfx("player/fx_plyr_clone_reaper_appear", self.origin, anglestoforward(self getangles()));
    fx.team = self.team;
    thread function_aeb6047c();
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x5 linked
// Checksum 0x23acf5c, Offset: 0x15b8
// Size: 0x3a4
function private _updateclonepathing() {
    self endon(#"death");
    while (true) {
        if (getdvarint("tu1_gadgetCloneSwimming", 1)) {
            if (self.origin[2] + 36 <= getwaterheight(self.origin)) {
                blackboard::setblackboardattribute(self, "_stance", "swim");
                self setgoal(self.origin, 1);
                wait(0.5);
                continue;
            }
        }
        if (getdvarint("tu1_gadgetCloneCrouching", 1)) {
            if (!isdefined(self.lastknownpos)) {
                self.lastknownpos = self.origin;
                self.lastknownpostime = gettime();
            }
            if (distancesquared(self.lastknownpos, self.origin) < 24 * 24 && !self haspath()) {
                blackboard::setblackboardattribute(self, "_stance", "crouch");
                wait(0.5);
                continue;
            }
            if (self.lastknownpostime + 2000 <= gettime()) {
                self.lastknownpos = self.origin;
                self.lastknownpostime = gettime();
            }
        }
        distance = 0;
        if (isdefined(self._clone_goal)) {
            distance = distancesquared(self._clone_goal, self.origin);
        }
        if (distance < 14400 || !self haspath()) {
            forward = anglestoforward(self getangles());
            searchorigin = self.origin + forward * 750;
            self._goal_center_point = searchorigin;
            queryresult = positionquery_source_navigation(self._goal_center_point, 500, 750, 750, 100, self);
            if (queryresult.data.size == 0) {
                queryresult = positionquery_source_navigation(self.origin, 500, 750, 750, 100, self);
            }
            if (queryresult.data.size > 0) {
                randindex = randomintrange(0, queryresult.data.size);
                self setgoalpos(queryresult.data[randindex].origin, 1);
                self._clone_goal = queryresult.data[randindex].origin;
                self._clone_goal_max_dist = 750;
            }
        }
        wait(0.5);
    }
}

// Namespace namespace_b3cf5df2
// Params 2, eflags: 0x1 linked
// Checksum 0x148879c6, Offset: 0x1968
// Size: 0x14c
function function_c030222c(endpos, traveltime) {
    spawnpos = self gettagorigin("j_spine4");
    fxorg = spawn("script_model", spawnpos);
    fxorg setmodel("tag_origin");
    fx = playfxontag("player/fx_plyr_clone_reaper_orb", fxorg, "tag_origin");
    fx.team = self.team;
    var_9a1cf5dc = endpos + (0, 0, 35);
    fxorg moveto(var_9a1cf5dc, traveltime);
    self util::waittill_any_timeout(traveltime, "death", "disconnect");
    fxorg delete();
}

// Namespace namespace_b3cf5df2
// Params 2, eflags: 0x5 linked
// Checksum 0xbf1a8227, Offset: 0x1ac0
// Size: 0x16c
function private function_d0fe4d5e(clone, player) {
    if (getdvarint("tu1_gadgetCloneCopyLook", 1)) {
        if (isplayer(player) && isai(clone)) {
            bodymodel = player getcharacterbodymodel();
            if (isdefined(bodymodel)) {
                clone setmodel(bodymodel);
            }
            headmodel = player getcharacterheadmodel();
            if (isdefined(headmodel)) {
                if (isdefined(clone.head)) {
                    clone detach(clone.head);
                }
                clone attach(headmodel);
            }
            var_f1a3fa15 = player getcharacterhelmetmodel();
            if (isdefined(var_f1a3fa15)) {
                clone attach(var_f1a3fa15);
            }
        }
    }
}

// Namespace namespace_b3cf5df2
// Params 4, eflags: 0x5 linked
// Checksum 0x635ab461, Offset: 0x1c38
// Size: 0x4ac
function private function_27c360b(clone, player, forward, spawntime) {
    clone.isaiclone = 1;
    clone.propername = "";
    clone.ignoretriggerdamage = 1;
    clone.minwalkdistance = 125;
    clone.overrideactordamage = &clonedamageoverride;
    clone.spawntime = gettime();
    clone setmaxhealth(int(1.5 * level.playermaxhealth));
    if (getdvarint("tu1_aiPathableMaterials", 0)) {
        if (isdefined(clone.pathablematerial)) {
            clone.pathablematerial &= ~2;
        }
    }
    clone function_1762804b(1);
    clone pushplayer(1);
    clone setcontents(8192);
    clone setavoidancemask("avoid none");
    clone asmsetanimationrate(randomfloatrange(0.98, 1.02));
    clone setclone();
    clone function_d0fe4d5e(clone, player);
    clone function_4cb878d3(player);
    clone thread function_f8ba2c36();
    clone thread function_9ce27da7(player);
    clone thread function_92432cce();
    clone thread function_bdb5ec20();
    clone thread function_8783f9e4();
    clone._goal_center_point = forward * 1000 + clone.origin;
    clone._goal_center_point = getclosestpointonnavmesh(clone._goal_center_point, 600);
    queryresult = undefined;
    if (isdefined(clone._goal_center_point) && clone findpath(clone.origin, clone._goal_center_point, 1, 0)) {
        queryresult = positionquery_source_navigation(clone._goal_center_point, 0, 450, 450, 100, clone);
    } else {
        queryresult = positionquery_source_navigation(clone.origin, 500, 750, 750, 50, clone);
    }
    if (queryresult.data.size > 0) {
        clone setgoalpos(queryresult.data[0].origin, 1);
        clone._clone_goal = queryresult.data[0].origin;
        clone._clone_goal_max_dist = 450;
    } else {
        clone._goal_center_point = clone.origin;
    }
    clone thread _updateclonepathing();
    clone ghost();
    clone thread function_6e8f41cb(spawntime);
    _configurecloneteam(clone, player, 0);
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x5 linked
// Checksum 0xe71f0388, Offset: 0x20f0
// Size: 0x6c
function private function_d3a63808() {
    if (isdefined(self)) {
        fx = playfx("player/fx_plyr_clone_vanish", self.origin);
        fx.team = self.team;
        playsoundatposition("mpl_clone_holo_death", self.origin);
    }
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x5 linked
// Checksum 0x1f51bcf0, Offset: 0x2168
// Size: 0x74
function private function_f8ba2c36() {
    self waittill(#"death");
    if (isdefined(self)) {
        self stoploopsound();
        self function_d3a63808();
        function_d1901738(self);
        self delete();
    }
}

// Namespace namespace_b3cf5df2
// Params 3, eflags: 0x5 linked
// Checksum 0x1b359ba2, Offset: 0x21e8
// Size: 0xc4
function private _configurecloneteam(clone, player, ishacked) {
    if (ishacked == 0) {
        clone.originalteam = player.team;
    }
    clone.ignoreall = 1;
    clone.owner = player;
    clone setteam(player.team);
    clone.team = player.team;
    clone setentityowner(player);
}

// Namespace namespace_b3cf5df2
// Params 1, eflags: 0x5 linked
// Checksum 0x1157f09f, Offset: 0x22b8
// Size: 0xdc
function private function_6e8f41cb(spawntime) {
    self endon(#"death");
    wait(spawntime);
    self show();
    self clientfield::set("clone_activated", 1);
    fx = playfx("player/fx_plyr_clone_reaper_appear", self.origin, anglestoforward(self getangles()));
    fx.team = self.team;
    self playloopsound("mpl_clone_gadget_loop_npc");
}

// Namespace namespace_b3cf5df2
// Params 2, eflags: 0x1 linked
// Checksum 0x7956c09e, Offset: 0x23a0
// Size: 0xc8
function function_e4fe20c9(slot, weapon) {
    self clientfield::set("clone_activated", 0);
    self flagsys::clear("clone_activated");
    self function_758b65c7(self);
    self function_d3a63808();
    if (isalive(self) && isdefined(level.playgadgetsuccess)) {
        self [[ level.playgadgetsuccess ]](weapon, "cloneSuccessDelay");
    }
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x5 linked
// Checksum 0xa0d08ff8, Offset: 0x2470
// Size: 0x5c
function private function_faa3553c() {
    self endon(#"death");
    self clientfield::set("clone_damaged", 1);
    util::wait_network_frame();
    self clientfield::set("clone_damaged", 0);
}

// Namespace namespace_b3cf5df2
// Params 3, eflags: 0x1 linked
// Checksum 0x15e59182, Offset: 0x24d8
// Size: 0xbc
function function_3722ecc9(clone, attacker, weapon) {
    if (isdefined(attacker) && isplayer(attacker)) {
        if (!level.teambased || clone.team != attacker.pers["team"]) {
            if (isdefined(clone.isaiclone) && clone.isaiclone) {
                scoreevents::processscoreevent("killed_clone_enemy", attacker, clone, weapon);
            }
        }
    }
}

// Namespace namespace_b3cf5df2
// Params 15, eflags: 0x1 linked
// Checksum 0x601756fe, Offset: 0x25a0
// Size: 0x196
function clonedamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    self thread function_faa3553c();
    if (weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH") {
        function_3722ecc9(self, eattacker, weapon);
        self notify(#"clone_shutdown");
    }
    if (isdefined(level.weaponlightninggun) && weapon == level.weaponlightninggun) {
        function_3722ecc9(self, eattacker, weapon);
        self notify(#"clone_shutdown");
    }
    supplydrop = getweapon("supplydrop");
    if (isdefined(supplydrop) && supplydrop == weapon) {
        function_3722ecc9(self, eattacker, weapon);
        self notify(#"clone_shutdown");
    }
    return idamage;
}

// Namespace namespace_b3cf5df2
// Params 1, eflags: 0x1 linked
// Checksum 0xefe14373, Offset: 0x2740
// Size: 0x8c
function function_9ce27da7(player) {
    clone = self;
    clone notify(#"hash_7ae6d388");
    clone endon(#"hash_7ae6d388");
    clone endon(#"clone_shutdown");
    player util::waittill_any("joined_team", "disconnect", "joined_spectators");
    if (isdefined(clone)) {
        clone notify(#"clone_shutdown");
    }
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x1 linked
// Checksum 0xa7d81966, Offset: 0x27d8
// Size: 0xb4
function function_92432cce() {
    clone = self;
    clone waittill(#"clone_shutdown");
    function_d1901738(clone);
    if (isdefined(clone)) {
        if (!level.gameended) {
            clone kill();
            return;
        }
        clone stoploopsound();
        self function_d3a63808();
        clone hide();
    }
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x1 linked
// Checksum 0x79b32ebe, Offset: 0x2898
// Size: 0x58
function function_8783f9e4() {
    clone = self;
    clone endon(#"clone_shutdown");
    clone endon(#"death");
    while (true) {
        clone util::break_glass();
        wait(0.25);
    }
}

// Namespace namespace_b3cf5df2
// Params 0, eflags: 0x1 linked
// Checksum 0x2da9d60e, Offset: 0x28f8
// Size: 0x258
function function_bdb5ec20() {
    clone = self;
    clone endon(#"clone_shutdown");
    clone endon(#"death");
    while (true) {
        waittime = randomfloatrange(0.5, 3);
        wait(waittime);
        shotsfired = randomintrange(1, 4);
        if (isdefined(clone.fakefireweapon) && clone.fakefireweapon != level.weaponnone) {
            players = getplayers();
            foreach (player in players) {
                if (isdefined(player) && isalive(player) && player getteam() != clone.team) {
                    if (distancesquared(player.origin, clone.origin) < 562500) {
                        if (clone cansee(player)) {
                            clone fakefire(clone.owner, clone.origin, clone.fakefireweapon, shotsfired);
                            break;
                        }
                    }
                }
            }
        }
        wait(shotsfired / 2);
        clone setfakefire(0);
    }
}

// Namespace namespace_b3cf5df2
// Params 1, eflags: 0x1 linked
// Checksum 0x14575a59, Offset: 0x2b58
// Size: 0x1a0
function function_4cb878d3(player) {
    clone = self;
    items = function_d935b10c(player);
    playerweapon = player getcurrentweapon();
    ball = getweapon("ball");
    if (isdefined(playerweapon) && isdefined(ball) && playerweapon == ball) {
        weapon = ball;
    } else if (isdefined(playerweapon.worldmodel) && function_3898b1bf(playerweapon, items["primary"])) {
        weapon = playerweapon;
    } else {
        if (isdefined(level.var_7ce7fbed)) {
            weapon = [[ level.var_7ce7fbed ]](player);
        } else {
            weapon = undefined;
        }
        if (!isdefined(weapon)) {
            weapon = function_ae40491f(player);
        }
    }
    if (isdefined(weapon)) {
        clone shared::placeweaponon(weapon, "right");
        clone.fakefireweapon = weapon;
    }
}

// Namespace namespace_b3cf5df2
// Params 1, eflags: 0x1 linked
// Checksum 0x9526ae3, Offset: 0x2d00
// Size: 0x208
function function_d935b10c(player) {
    pixbeginevent("clone_build_item_list");
    items = [];
    for (i = 0; i < 256; i++) {
        row = tablelookuprownum(level.var_f543dad1, 0, i);
        if (row > -1) {
            slot = tablelookupcolumnforrow(level.var_f543dad1, row, 13);
            if (slot == "") {
                continue;
            }
            number = int(tablelookupcolumnforrow(level.var_f543dad1, row, 0));
            if (player isitemlocked(number)) {
                continue;
            }
            allocation = int(tablelookupcolumnforrow(level.var_f543dad1, row, 12));
            if (allocation < 0) {
                continue;
            }
            name = tablelookupcolumnforrow(level.var_f543dad1, row, 3);
            if (!isdefined(items[slot])) {
                items[slot] = [];
            }
            items[slot][items[slot].size] = name;
        }
    }
    pixendevent();
    return items;
}

// Namespace namespace_b3cf5df2
// Params 1, eflags: 0x5 linked
// Checksum 0xa01e260a, Offset: 0x2f10
// Size: 0xaa
function private function_ae40491f(player) {
    classnum = randomint(10);
    for (i = 0; i < 10; i++) {
        weapon = player getloadoutweapon((i + classnum) % 10, "primary");
        if (weapon != level.weaponnone) {
            break;
        }
    }
    return weapon;
}

// Namespace namespace_b3cf5df2
// Params 2, eflags: 0x5 linked
// Checksum 0x1381ec34, Offset: 0x2fc8
// Size: 0x9e
function private function_3898b1bf(playerweapon, items) {
    if (!isdefined(items) || !items.size || !isdefined(playerweapon)) {
        return false;
    }
    for (i = 0; i < items.size; i++) {
        displayname = items[i];
        if (playerweapon.displayname == displayname) {
            return true;
        }
    }
    return false;
}

