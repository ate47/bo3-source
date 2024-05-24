#using scripts/cp/cp_doa_bo3_enemy;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_d88e3a06;

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x1 linked
// Checksum 0xcfe70e4f, Offset: 0x450
// Size: 0x338
function init() {
    level.doa.var_61adacb4 = [];
    level.doa.var_7817fe3c = [];
    level.doa.var_6a7fa24c = [];
    level.doa.var_2f019708 = 1;
    defs = struct::get_array("doa_hazard_def");
    for (i = 0; i < defs.size; i++) {
        def = spawnstruct();
        tokens = strtok(defs[i].script_noteworthy, " ");
        def.type = tokens[0];
        def.round = int(tokens[1]);
        if (tokens.size > 2) {
            def.width = int(tokens[2]);
        }
        if (tokens.size > 3) {
            def.height = int(tokens[3]);
        }
        if (tokens.size > 4) {
            def.var_1e40a680 = int(tokens[4]);
        }
        if (isdefined(defs[i].radius)) {
            def.radius = int(defs[i].radius);
        }
        def.model = defs[i].model;
        if (isdefined(level.doa.var_aeeb3a0e)) {
            [[ level.doa.var_aeeb3a0e ]](def);
        }
        level.doa.var_61adacb4[level.doa.var_61adacb4.size] = def;
        if (def.type == "type_electric_mine") {
            level.doa.var_f6ba7ed2 = def;
        }
    }
    def = spawnstruct();
    def.round = 37;
    def.type = "type_spider_egg";
    def.model = "zombietron_spider_egg";
    level.doa.var_d402a78b = def;
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x1 linked
// Checksum 0xba9c7295, Offset: 0x790
// Size: 0x1d8
function function_116bb43() {
    var_8f39bd5e = getentarray(namespace_3ca3c537::function_d2d75f5d() + "_trigger_death", "targetname");
    for (i = 0; i < var_8f39bd5e.size; i++) {
        trigger = var_8f39bd5e[i];
        trigger triggerenable(0);
        trigger notify(#"hash_3c011e06");
    }
    var_825ea03d = getentarray(namespace_3ca3c537::function_d2d75f5d() + "_water_volume", "targetname");
    for (i = 0; i < var_825ea03d.size; i++) {
        trigger = var_825ea03d[i];
        trigger triggerenable(0);
        trigger notify(#"hash_3c011e06");
    }
    for (i = 0; i < level.doa.var_7817fe3c.size; i++) {
        if (isdefined(level.doa.var_7817fe3c[i])) {
            level.doa.var_7817fe3c[i] thread function_65192900();
        }
    }
    level.doa.var_7817fe3c = [];
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x5 linked
// Checksum 0x63c8de46, Offset: 0x970
// Size: 0xa4
function private function_65192900() {
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    if (isdefined(self)) {
        self clientfield::set("hazard_activated", 9);
        if (isdefined(self.death_func)) {
            self thread [[ self.death_func ]]();
        }
        util::wait_network_frame();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x1 linked
// Checksum 0x9c730ad7, Offset: 0xa20
// Size: 0x104
function function_f8530ca3() {
    level.doa.var_6a7fa24c = [];
    for (i = 0; i < level.doa.var_61adacb4.size; i++) {
        if (level.doa.var_61adacb4[i].round <= level.doa.round_number) {
            var_dbd69b20 = function_40c555dc(level.doa.var_61adacb4[i].type);
            if (isdefined(var_dbd69b20)) {
                level.doa.var_6a7fa24c[level.doa.var_6a7fa24c.size] = level.doa.var_61adacb4[i];
            }
        }
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x1 linked
// Checksum 0x6ffdd05b, Offset: 0xb30
// Size: 0x1de
function function_7b02a267() {
    level notify(#"hash_7b02a267");
    level endon(#"hash_7b02a267");
    while (true) {
        if (getdvarint("scr_doa_show_hazards", 0)) {
            for (i = 0; i < level.doa.var_6a7fa24c.size; i++) {
                var_1ab7e3a5 = level.doa.var_6a7fa24c[i];
                if (isdefined(var_1ab7e3a5)) {
                    locs = function_a4d53f1f(var_1ab7e3a5.type);
                    if (isdefined(locs)) {
                        foreach (loc in locs) {
                            radius = isdefined(var_1ab7e3a5.radius) ? var_1ab7e3a5.radius : 85;
                            if (isdefined(loc.radius)) {
                                radius = loc.radius;
                            }
                            level thread namespace_2f63e553::drawcylinder(loc.origin, radius, 5, 20);
                        }
                    }
                }
            }
        }
        wait(1);
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x1 linked
// Checksum 0x4611bc1d, Offset: 0xd18
// Size: 0x684
function function_7a8a936b() {
    function_116bb43();
    function_f8530ca3();
    /#
        level thread function_7b02a267();
    #/
    for (i = 0; i < level.doa.var_6a7fa24c.size; i++) {
        var_1ab7e3a5 = level.doa.var_6a7fa24c[i];
        var_ef9f53d = math::clamp(1 + randomint(2 + int((level.doa.round_number - 4) / 5)), 1, 20);
        if (getdvarint("scr_doa_max_poles", 0)) {
            var_ef9f53d = 20;
        }
        if (isdefined(level.doa.var_fdc1fa6b)) {
            count = [[ level.doa.var_fdc1fa6b ]]();
            if (count != -1) {
                var_ef9f53d = count;
            }
        }
        for (count = 0; count < var_ef9f53d; count++) {
            if (!mayspawnentity()) {
                break;
            }
            locs = array::randomize(function_a4d53f1f(var_1ab7e3a5.type));
            loc = locs[0];
            radius = 85;
            if (isdefined(loc.radius)) {
                radius = loc.radius;
            }
            origin = loc.origin + (randomintrange(0 - radius, radius), randomintrange(0 - radius, radius), 0);
            origin = function_3341776e(origin, loc.origin, radius);
            if (isdefined(origin)) {
                hazard = spawn("script_model", origin);
                hazard.targetname = "hazard";
                hazard setmodel(var_1ab7e3a5.model);
                hazard.def = var_1ab7e3a5;
                if (isdefined(var_1ab7e3a5.width) && isdefined(var_1ab7e3a5.height)) {
                    hazard.trigger = spawn("trigger_radius", origin, 3, var_1ab7e3a5.width, var_1ab7e3a5.height);
                    hazard.trigger.targetname = "hazard";
                }
                hazard thread function_5d31907f();
                level.doa.var_7817fe3c[level.doa.var_7817fe3c.size] = hazard;
                continue;
            }
            /#
                namespace_49107f3a::debugmsg("hazard_activated");
            #/
        }
    }
    var_8f39bd5e = getentarray(namespace_3ca3c537::function_d2d75f5d() + "_trigger_death", "targetname");
    for (i = 0; i < var_8f39bd5e.size; i++) {
        trigger = var_8f39bd5e[i];
        trigger triggerenable(1);
        trigger thread function_6ec8176a();
    }
    var_825ea03d = getentarray(namespace_3ca3c537::function_d2d75f5d() + "_water_volume", "targetname");
    for (i = 0; i < var_825ea03d.size; i++) {
        trigger = var_825ea03d[i];
        trigger triggerenable(1);
        trigger thread function_323a3e31();
    }
    var_88bc4fa4 = getentarray(namespace_3ca3c537::function_d2d75f5d() + "_trigger_warp", "targetname");
    for (i = 0; i < var_88bc4fa4.size; i++) {
        trigger = var_88bc4fa4[i];
        trigger triggerenable(1);
        trigger thread function_70dbf276();
    }
    if (level.doa.round_number >= level.doa.var_d402a78b.round) {
        level thread function_1cb931df(level.doa.var_afdb45da);
    }
}

// Namespace namespace_d88e3a06
// Params 2, eflags: 0x5 linked
// Checksum 0xdeaebfbb, Offset: 0x13a8
// Size: 0xa0
function private _rotatevec(vector, angle) {
    return (vector[0] * cos(angle) - vector[1] * sin(angle), vector[0] * sin(angle) + vector[1] * cos(angle), vector[2]);
}

// Namespace namespace_d88e3a06
// Params 2, eflags: 0x1 linked
// Checksum 0x8453d57d, Offset: 0x1450
// Size: 0x2f8
function function_1cb931df(def, var_3d19d2b1) {
    if (!isdefined(var_3d19d2b1)) {
        var_3d19d2b1 = getdvarint("scr_doa_eggcount", 6);
    }
    if (isdefined(level.doa.var_d0cde02c)) {
        if (isdefined(level.doa.var_d0cde02c.var_75f2c952)) {
            var_3d19d2b1 = level.doa.var_d0cde02c.var_75f2c952;
        } else {
            return;
        }
    } else if (def.round == level.doa.round_number) {
        var_3d19d2b1 = def.var_75f2c952;
    }
    spot = namespace_49107f3a::function_ada6d90();
    while (isdefined(spot) && var_3d19d2b1) {
        baseorigin = spot.origin;
        var_485dfece = 0;
        for (angle = randomint(-76); var_3d19d2b1; angle = randomint(-76)) {
            if (var_485dfece == 0) {
                origin = baseorigin;
            } else {
                origin = baseorigin + _rotatevec((30, 0, 0), angle);
                angle += randomintrange(30, 60);
            }
            namespace_51bd792::function_ecbf1358(origin, (randomfloatrange(-3, 3), randomfloatrange(0, -76), randomfloatrange(-3, 3)));
            var_3d19d2b1--;
            var_485dfece++;
            if (var_485dfece >= getdvarint("scr_doa_clutchcount_max", 6) || randomint(100) > 85) {
                var_23ff810a = namespace_49107f3a::function_ada6d90();
                if (var_23ff810a == spot) {
                    var_3d19d2b1 = 0;
                    break;
                }
                spot = var_23ff810a;
                baseorigin = spot.origin;
                var_485dfece = 0;
            }
        }
    }
}

// Namespace namespace_d88e3a06
// Params 1, eflags: 0x5 linked
// Checksum 0x66ac16e, Offset: 0x1750
// Size: 0x94
function private function_fb78d226(triggervolume) {
    self endon(#"death");
    self asmsetanimationrate(0.8);
    self.in_water = 1;
    while (isdefined(triggervolume) && self istouching(triggervolume)) {
        wait(0.25);
    }
    self asmsetanimationrate(1);
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x5 linked
// Checksum 0x80a1b57f, Offset: 0x17f0
// Size: 0x158
function private function_323a3e31() {
    self notify(#"hash_323a3e31");
    self endon(#"hash_323a3e31");
    self endon(#"hash_3c011e06");
    while (true) {
        guy = self waittill(#"trigger");
        if (isdefined(guy.takedamage) && isdefined(guy) && isalive(guy) && guy.takedamage && !(isdefined(guy.boss) && guy.boss) && !(isdefined(guy.in_water) && guy.in_water)) {
            if (isplayer(guy)) {
                if (isdefined(guy.doa) && isdefined(guy.doa.vehicle)) {
                    guy notify(#"hash_d28ba89d");
                }
                continue;
            }
            guy thread function_fb78d226(self);
        }
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x5 linked
// Checksum 0x6459a13, Offset: 0x1950
// Size: 0x1c8
function private function_6ec8176a() {
    self notify(#"hash_6ec8176a");
    self endon(#"hash_6ec8176a");
    self endon(#"hash_3c011e06");
    while (true) {
        guy = self waittill(#"trigger");
        if (isdefined(guy.takedamage) && isdefined(guy) && isalive(guy) && guy.takedamage && !(isdefined(guy.boss) && guy.boss)) {
            if (isdefined(self.script_noteworthy)) {
                switch (self.script_noteworthy) {
                case 20:
                    guy thread namespace_1a381543::function_90118d8c("zmb_hazard_water_death");
                    guy thread namespace_eaa992c::function_285a2999("hazard_water");
                    break;
                case 19:
                    break;
                }
            }
            if (isdefined(self.script_parameters) && isdefined(guy.doa)) {
                guy.doa.var_bac6a79 = self.script_parameters;
            }
            if (isplayer(guy)) {
                guy notify(#"hash_d28ba89d");
            }
            guy dodamage(guy.health + 500, guy.origin);
        }
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x5 linked
// Checksum 0x7e274c57, Offset: 0x1b20
// Size: 0x240
function private function_70dbf276() {
    self notify(#"hash_70dbf276");
    self endon(#"hash_70dbf276");
    self endon(#"hash_3c011e06");
    while (true) {
        guy = self waittill(#"trigger");
        if (isdefined(guy)) {
            var_c99d2b6d = "spawn_at_safe";
            if (isdefined(self.script_parameters)) {
                var_bac6a79 = self.script_parameters;
            }
            if (!isplayer(guy)) {
                var_c99d2b6d = "spawn_at_safe";
            }
            if (isplayer(guy)) {
                guy notify(#"hash_d28ba89d");
            }
            switch (var_c99d2b6d) {
            case 21:
                spot = namespace_49107f3a::function_5ee38fe3(guy.origin, level.doa.arenas[level.doa.var_90873830].var_1d2ed40).origin;
                break;
            default:
                spot = namespace_831a4a7c::function_68ece679(guy.entnum).origin;
                break;
            }
            if (isplayer(guy)) {
                guy setorigin(spot);
                continue;
            }
            if (isactor(guy)) {
                guy forceteleport(spot, guy.angles);
                continue;
            }
            guy dodamage(guy.health + 500, guy.origin);
        }
    }
}

// Namespace namespace_d88e3a06
// Params 1, eflags: 0x5 linked
// Checksum 0x99e29feb, Offset: 0x1d68
// Size: 0xf4
function private function_a4d53f1f(type) {
    spawn_locations = [];
    var_1be21036 = namespace_3ca3c537::function_d2d75f5d() + "_doa_hazard";
    spawn_locations = struct::get_array(var_1be21036);
    if (spawn_locations.size == 0) {
        return;
    }
    locs = [];
    for (i = 0; i < spawn_locations.size; i++) {
        if (issubstr(spawn_locations[i].script_noteworthy, type)) {
            locs[locs.size] = spawn_locations[i];
        }
    }
    return locs;
}

// Namespace namespace_d88e3a06
// Params 1, eflags: 0x5 linked
// Checksum 0x664e5649, Offset: 0x1e68
// Size: 0x110
function private function_40c555dc(type) {
    spawn_locations = [];
    var_1be21036 = namespace_3ca3c537::function_d2d75f5d() + "_doa_hazard";
    spawn_locations = struct::get_array(var_1be21036);
    if (spawn_locations.size == 0) {
        return;
    }
    locs = [];
    for (i = 0; i < spawn_locations.size; i++) {
        if (issubstr(spawn_locations[i].script_noteworthy, type)) {
            locs[locs.size] = spawn_locations[i];
        }
    }
    return locs[randomint(locs.size)];
}

// Namespace namespace_d88e3a06
// Params 3, eflags: 0x1 linked
// Checksum 0xb55e5f20, Offset: 0x1f80
// Size: 0x43a
function function_3341776e(origin, var_891d7d80, var_ba2a535c) {
    if (!isdefined(var_891d7d80)) {
        var_891d7d80 = origin;
    }
    if (!isdefined(var_ba2a535c)) {
        var_ba2a535c = 85;
    }
    min_dist = 24;
    min_dist_squared = min_dist * min_dist;
    pushed = 1;
    max_tries = 3;
    while (pushed && max_tries > 0) {
        max_tries--;
        pushed = 0;
        for (i = 0; i < level.doa.var_7817fe3c.size; i++) {
            hazard = level.doa.var_7817fe3c[i];
            if (isdefined(hazard)) {
                dist_squared = distancesquared(origin, hazard.origin);
                if (dist_squared < min_dist_squared) {
                    dir = origin - hazard.origin;
                    dir = vectornormalize(dir);
                    var_b72287b9 = origin - var_891d7d80;
                    var_b72287b9 = vectornormalize(dir);
                    if (vectordot(dir, var_b72287b9) < 0) {
                        dir *= -1;
                    }
                    origin += dir * min_dist;
                    pushed = 1;
                }
            }
        }
    }
    dist_squared = distancesquared(origin, var_891d7d80);
    if (dist_squared > var_ba2a535c * var_ba2a535c) {
        return undefined;
    }
    trace = worldtrace(origin + (0, 0, 32), origin + (48, 0, 32));
    var_4a592d6b = trace["fraction"] == 1 && trace["surfacetype"] == "none";
    if (!var_4a592d6b) {
        return undefined;
    }
    trace = worldtrace(origin + (0, 0, 32), origin + (-48, 0, 32));
    var_4a592d6b = trace["fraction"] == 1 && trace["surfacetype"] == "none";
    if (!var_4a592d6b) {
        return undefined;
    }
    trace = worldtrace(origin + (0, 0, 32), origin + (0, 48, 32));
    var_4a592d6b = trace["fraction"] == 1 && trace["surfacetype"] == "none";
    if (!var_4a592d6b) {
        return undefined;
    }
    trace = worldtrace(origin + (0, 0, 32), origin + (0, -48, 32));
    var_4a592d6b = trace["fraction"] == 1 && trace["surfacetype"] == "none";
    if (!var_4a592d6b) {
        return undefined;
    }
    return origin;
}

// Namespace namespace_d88e3a06
// Params 1, eflags: 0x4
// Checksum 0x2dea5705, Offset: 0x23c8
// Size: 0x88
function private function_993013cd(trigger) {
    self endon(#"death");
    while (true) {
        if (isdefined(self.active) && self.active && isdefined(trigger)) {
            namespace_2f63e553::drawcylinder(trigger.origin, self.def.width, self.def.height);
        }
        wait(0.05);
    }
}

// Namespace namespace_d88e3a06
// Params 1, eflags: 0x5 linked
// Checksum 0x872d5dd5, Offset: 0x2458
// Size: 0x240
function private function_8a97d2c0(trigger) {
    self endon(#"death");
    trigger endon(#"death");
    while (true) {
        guy = trigger waittill(#"trigger");
        if (isdefined(self.active) && isdefined(guy) && self.active) {
            if (!isdefined(guy.doa)) {
                continue;
            }
            if (isdefined(guy.var_de3055b5) && guy.var_de3055b5) {
                continue;
            }
            if (!isdefined(guy.doa.hazard_hit)) {
                guy.doa.hazard_hit = 0;
            }
            curtime = gettime();
            if (curtime < guy.doa.hazard_hit) {
                continue;
            }
            guy.doa.hazard_hit = curtime + 1500;
            guy thread namespace_1a381543::function_90118d8c("zmb_hazard_hit");
            guy thread namespace_eaa992c::function_285a2999("hazard_electric");
            if (isdefined(guy.boss) && guy.boss) {
                continue;
            }
            if (isdefined(guy.allowdeath) && isdefined(guy.takedamage) && guy.health > 0 && guy.takedamage && guy.allowdeath) {
                guy dodamage(guy.health + 500, guy.origin, self, trigger, "none", "MOD_ELECTROCUTED");
            }
        }
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x1 linked
// Checksum 0xac428fbe, Offset: 0x26a0
// Size: 0xae
function function_5d31907f() {
    /#
    #/
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.def)) {
        return;
    }
    switch (self.def.type) {
    case 2:
        self thread function_bf0f9f64();
        if (!isdefined(level.doa.var_f6ba7ed2)) {
            level.doa.var_f6ba7ed2 = self.def;
        }
        break;
    default:
        /#
            assert(0);
        #/
        break;
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x1 linked
// Checksum 0xa097853d, Offset: 0x2758
// Size: 0x180
function function_bf0f9f64() {
    self endon(#"death");
    self.active = 0;
    self clientfield::set("hazard_type", isdefined(self.var_d05d7e08) ? self.var_d05d7e08 : 1);
    wait(0.05);
    self thread function_8a97d2c0(self.trigger);
    self clientfield::set("hazard_activated", 1);
    wait(randomfloatrange(2.1, 8));
    while (true) {
        self clientfield::set("hazard_activated", 2);
        wait(1.2);
        self clientfield::set("hazard_activated", 3);
        self.active = 1;
        wait(randomfloatrange(4, 10));
        self clientfield::set("hazard_activated", 1);
        self.active = 0;
        wait(randomfloatrange(3, 6));
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x1 linked
// Checksum 0x1cb3beec, Offset: 0x28e0
// Size: 0xcc
function function_193a95a6() {
    self.death_func = undefined;
    origin = self.origin;
    self clientfield::set("hazard_activated", 9);
    self thread namespace_1a381543::function_90118d8c("exp_barrel_explo");
    self function_65192900();
    util::wait_network_frame();
    radiusdamage(origin, -56, 10000, 10000);
    physicsexplosionsphere(origin, -56, -128, 4);
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x5 linked
// Checksum 0xbd2509a2, Offset: 0x29b8
// Size: 0x34
function private function_2a738695() {
    self waittill(#"death");
    arrayremovevalue(level.doa.var_7817fe3c, self);
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x1 linked
// Checksum 0x332d2f13, Offset: 0x29f8
// Size: 0x3d0
function function_d8d20160() {
    self thread function_d8c94716();
    self thread function_441547f1();
    self thread function_2a738695();
    if (isdefined(self)) {
        self clientfield::set("hazard_type", 2);
    }
    util::wait_network_frame();
    if (isdefined(self)) {
        self clientfield::set("hazard_activated", 3);
        self.takedamage = 1;
        self.health = level.doa.rules.var_5e3c9766;
        self.maxhealth = self.health;
        self.team = "axis";
        self.var_febf89ad = 1;
        self.var_1a563349 = 1;
        self.var_262e30aa = (0, 0, 42);
        self.death_func = &function_193a95a6;
        level.doa.var_7817fe3c[level.doa.var_7817fe3c.size] = self;
        while (isdefined(self)) {
            damage, attacker, direction_vec, point, meansofdeath, tagname, modelname, partname, weapon = self waittill(#"damage");
            if (isdefined(meansofdeath) && meansofdeath == "MOD_BURNED") {
                damage = int(max(self.health * 0.5, damage));
            }
            /#
                namespace_49107f3a::debugmsg("hazard_activated" + damage + "hazard_activated" + meansofdeath + "hazard_activated" + self.health);
            #/
            lasthealth = self.health;
            self.health -= damage;
            if (self.health <= 0) {
                self function_193a95a6();
                return;
            }
            var_5a614ecc = lasthealth / self.maxhealth;
            ratio = self.health / self.maxhealth;
            if (var_5a614ecc > 0.75 && ratio < 0.75) {
                self clientfield::set("hazard_activated", 4);
            }
            if (var_5a614ecc > 0.5 && ratio < 0.5) {
                self clientfield::set("hazard_activated", 5);
            }
            if (var_5a614ecc > 0.25 && ratio < 0.25) {
                self clientfield::set("hazard_activated", 6);
            }
        }
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x5 linked
// Checksum 0x25ed5f68, Offset: 0x2dd0
// Size: 0x44
function private function_d8c94716() {
    self thread namespace_49107f3a::function_783519c1("exit_taken", 1);
    self thread namespace_49107f3a::function_783519c1("doa_game_is_over", 1);
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x5 linked
// Checksum 0xede91e96, Offset: 0x2e20
// Size: 0x12c
function private function_441547f1() {
    self endon(#"death");
    while (true) {
        var_6792dc08 = getentarray("a_pickup_item", "script_noteworthy");
        var_f3646f56 = self.origin + (isdefined(self.var_262e30aa) ? self.var_262e30aa : (0, 0, 0));
        for (i = 0; i < var_6792dc08.size; i++) {
            pickup = var_6792dc08[i];
            if (!isdefined(pickup)) {
                continue;
            }
            distsq = distance2dsquared(pickup.origin, var_f3646f56);
            if (distsq > 12 * 12) {
                continue;
            }
            pickup thread namespace_a7e6beb5::function_6b4a5f81();
        }
        wait(0.05);
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x1 linked
// Checksum 0xf46999f9, Offset: 0x2f58
// Size: 0xc6
function function_ffe39afe() {
    count = 0;
    foreach (hazard in level.doa.var_7817fe3c) {
        if (isdefined(hazard.var_febf89ad) && isdefined(hazard) && hazard.var_febf89ad) {
            count++;
        }
    }
    return count;
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x1 linked
// Checksum 0x9519e49e, Offset: 0x3028
// Size: 0x110
function function_cda60edb() {
    if (level.doa.round_number < level.doa.rules.var_8c016b75) {
        return false;
    }
    if (!isdefined(level.doa.var_932f9d4d)) {
        return true;
    }
    if (function_ffe39afe() >= level.doa.rules.var_3210f224) {
        return false;
    }
    if (gettime() - level.doa.var_932f9d4d > level.doa.rules.var_6e5d36ba * 1000) {
        return true;
    }
    if (randomint(level.doa.rules.var_d82df3d5) > level.doa.rules.var_4a5eec4) {
        return false;
    }
    return true;
}

