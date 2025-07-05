#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace namespace_d88e3a06;

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x0
// Checksum 0x9dfe82f2, Offset: 0x380
// Size: 0x1ed
function init() {
    level.doa.var_61adacb4 = [];
    level.doa.var_7817fe3c = [];
    level.doa.var_6a7fa24c = [];
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
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x0
// Checksum 0xb5824d29, Offset: 0x578
// Size: 0x162
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
// Params 0, eflags: 0x4
// Checksum 0x1d64bc5d, Offset: 0x6e8
// Size: 0x6a
function private function_65192900() {
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    if (isdefined(self)) {
        self clientfield::set("hazard_activated", 9);
        util::wait_network_frame();
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x0
// Checksum 0xa2461e85, Offset: 0x760
// Size: 0xd5
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
// Params 0, eflags: 0x0
// Checksum 0xb6370762, Offset: 0x840
// Size: 0x401
function function_7a8a936b() {
    function_116bb43();
    function_f8530ca3();
    for (i = 0; i < level.doa.var_6a7fa24c.size; i++) {
        var_1ab7e3a5 = level.doa.var_6a7fa24c[i];
        var_ef9f53d = math::clamp(1 + randomint(1 + int((level.doa.round_number - 4) / 5)), 1, 16);
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
            origin = function_f8578623(origin);
            hazard = spawn("script_model", origin);
            hazard.targetname = "hazard";
            hazard setmodel(var_1ab7e3a5.model);
            hazard.def = var_1ab7e3a5;
            if (isdefined(var_1ab7e3a5.width) && isdefined(var_1ab7e3a5.height)) {
                hazard.trigger = spawn("trigger_radius", origin, 3, var_1ab7e3a5.width, var_1ab7e3a5.height);
                hazard.trigger.targetname = "hazard";
            }
            hazard thread function_a016fcfa();
            level.doa.var_7817fe3c[level.doa.var_7817fe3c.size] = hazard;
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
    var_825ea03d = getentarray(namespace_3ca3c537::function_d2d75f5d() + "_trigger_warp", "targetname");
    for (i = 0; i < var_825ea03d.size; i++) {
        trigger = var_825ea03d[i];
        trigger triggerenable(1);
        trigger thread function_70dbf276();
    }
}

// Namespace namespace_d88e3a06
// Params 1, eflags: 0x4
// Checksum 0xe96e313f, Offset: 0xc50
// Size: 0x72
function private function_fb78d226(triggervolume) {
    self endon(#"death");
    self asmsetanimationrate(0.8);
    self.in_water = 1;
    while (isdefined(triggervolume) && self istouching(triggervolume)) {
        wait 0.25;
    }
    self asmsetanimationrate(1);
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x4
// Checksum 0x1d8a19c5, Offset: 0xcd0
// Size: 0xf5
function private function_323a3e31() {
    self notify(#"hash_323a3e31");
    self endon(#"hash_323a3e31");
    self endon(#"hash_3c011e06");
    while (true) {
        self waittill(#"trigger", guy);
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
// Params 0, eflags: 0x4
// Checksum 0xfa158bb6, Offset: 0xdd0
// Size: 0x16d
function private function_6ec8176a() {
    self notify(#"hash_6ec8176a");
    self endon(#"hash_6ec8176a");
    self endon(#"hash_3c011e06");
    while (true) {
        self waittill(#"trigger", guy);
        if (isdefined(guy.takedamage) && isdefined(guy) && isalive(guy) && guy.takedamage && !(isdefined(guy.boss) && guy.boss)) {
            if (isdefined(self.script_noteworthy)) {
                switch (self.script_noteworthy) {
                case "water":
                    guy thread namespace_1a381543::function_90118d8c("zmb_hazard_water_death");
                    guy thread namespace_eaa992c::function_285a2999("hazard_water");
                    break;
                case "lava":
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
// Params 0, eflags: 0x4
// Checksum 0xa1b299f1, Offset: 0xf48
// Size: 0x1dd
function private function_70dbf276() {
    self notify(#"hash_70dbf276");
    self endon(#"hash_70dbf276");
    self endon(#"hash_3c011e06");
    while (true) {
        self waittill(#"trigger", guy);
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
            case "spawn_at_safe":
                spot = namespace_49107f3a::function_5ee38fe3(guy.origin, level.doa.arenas[level.doa.var_90873830].var_1d2ed40).origin;
                break;
            default:
                spot = doa_player_utility::function_68ece679(guy.entnum).origin;
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
// Params 1, eflags: 0x4
// Checksum 0xf726460d, Offset: 0x1130
// Size: 0xa9
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
// Params 1, eflags: 0x4
// Checksum 0x98c5d967, Offset: 0x11e8
// Size: 0xbc
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
// Params 1, eflags: 0x4
// Checksum 0x9614ecb9, Offset: 0x12b0
// Size: 0x111
function private function_f8578623(origin) {
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
                    origin += dir * min_dist;
                    pushed = 1;
                }
            }
        }
    }
    return origin;
}

// Namespace namespace_d88e3a06
// Params 1, eflags: 0x4
// Checksum 0xa0241ad1, Offset: 0x13d0
// Size: 0x75
function private function_993013cd(trigger) {
    self endon(#"death");
    while (true) {
        if (isdefined(self.active) && self.active && isdefined(trigger)) {
            namespace_2f63e553::drawcylinder(trigger.origin, self.def.width, self.def.height);
        }
        wait 0.05;
    }
}

// Namespace namespace_d88e3a06
// Params 1, eflags: 0x4
// Checksum 0x2667a7cc, Offset: 0x1450
// Size: 0x205
function private function_8a97d2c0(trigger) {
    self endon(#"death");
    trigger endon(#"death");
    while (true) {
        trigger waittill(#"trigger", guy);
        if (isdefined(self.active) && isdefined(guy) && self.active) {
            if (!isdefined(guy.doa)) {
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
            if (isdefined(guy.takedamage) && guy.health > 0 && guy.takedamage) {
                assert(!(isdefined(guy.boss) && guy.boss));
                guy startragdoll();
                dir = guy.origin - trigger.origin;
                dir = vectornormalize(dir);
                guy launchragdoll(dir * 100);
                util::wait_network_frame();
                if (isdefined(guy)) {
                    guy dodamage(guy.health + 500, guy.origin);
                }
            }
        }
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x0
// Checksum 0x11964824, Offset: 0x1660
// Size: 0x5d
function function_a016fcfa() {
    /#
    #/
    switch (self.def.type) {
    case "type_electric_mine":
        self thread function_bf0f9f64();
        break;
    default:
        assert(0);
        break;
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x0
// Checksum 0x2b676cfb, Offset: 0x16c8
// Size: 0xfd
function function_bf0f9f64() {
    self endon(#"death");
    self.active = 0;
    self clientfield::set("hazard_type", 1);
    wait 0.05;
    self thread function_8a97d2c0(self.trigger);
    self clientfield::set("hazard_activated", 1);
    wait randomfloat(8);
    while (true) {
        self clientfield::set("hazard_activated", 2);
        wait 1.2;
        self clientfield::set("hazard_activated", 3);
        self.active = 1;
        wait randomfloatrange(4, 10);
        self clientfield::set("hazard_activated", 1);
        self.active = 0;
        wait randomfloatrange(3, 6);
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x0
// Checksum 0x3f7181aa, Offset: 0x17d0
// Size: 0x92
function function_193a95a6() {
    origin = self.origin;
    self clientfield::set("hazard_activated", 9);
    self thread namespace_1a381543::function_90118d8c("exp_barrel_explo");
    self function_65192900();
    util::wait_network_frame();
    radiusdamage(origin, -56, 10000, 10000);
    physicsexplosionsphere(origin, -56, -128, 4);
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x4
// Checksum 0xa70f8978, Offset: 0x1870
// Size: 0x2a
function private function_2a738695() {
    self waittill(#"death");
    arrayremovevalue(level.doa.var_7817fe3c, self);
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x0
// Checksum 0xed164442, Offset: 0x18a8
// Size: 0x23d
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
        self.trashcan = 1;
        self.var_1a563349 = 1;
        self.var_262e30aa = (0, 0, 42);
        self.death_func = &function_193a95a6;
        level.doa.var_7817fe3c[level.doa.var_7817fe3c.size] = self;
        while (isdefined(self)) {
            self waittill(#"damage", amount);
            lasthealth = self.health;
            self.health = self.health - amount;
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
// Params 0, eflags: 0x4
// Checksum 0x9753dae0, Offset: 0x1af0
// Size: 0x5a
function private function_d8c94716() {
    self endon(#"death");
    level util::waittill_any("exit_taken", "doa_game_is_over");
    arrayremovevalue(level.doa.var_7817fe3c, self);
    self thread function_65192900();
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x4
// Checksum 0x89d81584, Offset: 0x1b58
// Size: 0xed
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
        wait 0.05;
    }
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x0
// Checksum 0xfc9aa7d7, Offset: 0x1c50
// Size: 0x83
function function_ffe39afe() {
    count = 0;
    foreach (hazard in level.doa.var_7817fe3c) {
        if (isdefined(hazard.trashcan) && hazard.trashcan) {
            count++;
        }
    }
    return count;
}

// Namespace namespace_d88e3a06
// Params 0, eflags: 0x0
// Checksum 0xe7a86171, Offset: 0x1ce0
// Size: 0xe9
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

