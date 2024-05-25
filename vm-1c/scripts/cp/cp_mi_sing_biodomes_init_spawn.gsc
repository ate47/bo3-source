#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/spawner_shared;
#using scripts/codescripts/struct;

#namespace namespace_b002c73b;

// Namespace namespace_b002c73b
// Params 0, eflags: 0x2
// Checksum 0xb35adecf, Offset: 0x250
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("sm_initial_spawns", &__init__, &__main__, undefined);
}

// Namespace namespace_b002c73b
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x298
// Size: 0x4
function __init__() {
    
}

// Namespace namespace_b002c73b
// Params 0, eflags: 0x1 linked
// Checksum 0x4b6c0dae, Offset: 0x2a8
// Size: 0x1c
function __main__() {
    level thread function_590e549();
}

// Namespace namespace_b002c73b
// Params 1, eflags: 0x0
// Checksum 0x65424c34, Offset: 0x2d0
// Size: 0x7c
function function_18f12c5f(spawn_struct) {
    self endon(#"death");
    wait(1);
    if (!level flag::get("sm_combat_started")) {
        wait(randomfloatrange(0.5, 1));
        level flag::set("sm_combat_started");
    }
}

// Namespace namespace_b002c73b
// Params 0, eflags: 0x0
// Checksum 0x8a94750d, Offset: 0x358
// Size: 0x10
function function_64ebf854() {
    level waittill(#"hash_1b1dc746");
}

// Namespace namespace_b002c73b
// Params 0, eflags: 0x1 linked
// Checksum 0x9ae0c2d3, Offset: 0x370
// Size: 0xba
function function_590e549() {
    wait(1);
    var_8eb85679 = struct::get_array("infil_manager", "targetname");
    foreach (zone in var_8eb85679) {
        zone function_9b333f19();
    }
}

// Namespace namespace_b002c73b
// Params 0, eflags: 0x1 linked
// Checksum 0xf955d8cd, Offset: 0x438
// Size: 0x74
function function_9b333f19() {
    var_61b5d65a = getentarray(self.target, "targetname");
    assert(var_61b5d65a.size != 0, "patrol");
    var_61b5d65a[0] thread function_c04f5659();
}

// Namespace namespace_b002c73b
// Params 1, eflags: 0x0
// Checksum 0xb0f03f24, Offset: 0x4b8
// Size: 0x19e
function function_166a3348(var_61b5d65a) {
    for (i = 0; i < var_61b5d65a.size; i++) {
        if (isdefined(var_61b5d65a[i].script_noteworthy) && isdefined(level.gametype)) {
            if (var_61b5d65a[i].script_noteworthy == level.gametype) {
                var_3979e78 = var_61b5d65a[i];
                continue;
            }
            var_61b5d65a[i] function_2cf0cb11();
            array::remove_index(var_61b5d65a, i, 1);
        }
    }
    if (var_61b5d65a.size == 0) {
        return;
    }
    if (!isdefined(var_3979e78)) {
        var_3979e78 = array::random(var_61b5d65a);
    }
    foreach (volume in var_61b5d65a) {
        if (volume != var_3979e78) {
            volume function_2cf0cb11();
        }
    }
    return var_3979e78;
}

// Namespace namespace_b002c73b
// Params 0, eflags: 0x1 linked
// Checksum 0x37058842, Offset: 0x660
// Size: 0x1ae
function function_c04f5659() {
    while (true) {
        ent = self waittill(#"trigger");
        if (isdefined(ent.sessionstate) && ent.sessionstate != "spectator") {
            break;
        }
        wait(0.05);
    }
    target = self.target;
    a_entities = getentarray(target, "targetname");
    assert(a_entities.size != 0, "patrol");
    var_9dfd5595 = self;
    wait(1);
    foreach (entity in a_entities) {
        if (isspawner(entity) && !isdefined(level.var_7952320e) && isdefined(var_9dfd5595)) {
            entity function_90dcd682(var_9dfd5595);
        }
    }
    self notify(#"hash_48a5af9");
}

// Namespace namespace_b002c73b
// Params 1, eflags: 0x1 linked
// Checksum 0x46a5f607, Offset: 0x818
// Size: 0x24c
function function_90dcd682(var_92b4ece5) {
    var_ac46855a = getent("street_battle_volume", "targetname");
    if (isdefined(level.var_1748bc03) || isdefined(level.var_e635c753)) {
        if (isdefined(self.script_noteworthy) && self.script_noteworthy != "wasp_swarm" && self.script_noteworthy != "hunter_swarm") {
            self.target = undefined;
        }
    }
    if (!isdefined(self.script_noteworthy)) {
        var_835e5b1c = spawner::simple_spawn_single(self);
        if (isdefined(level.var_e635c753) && isactor(var_835e5b1c)) {
            var_835e5b1c setgoal(var_ac46855a);
        }
        return;
    }
    if (self.script_noteworthy == "wasp_swarm") {
        self thread function_7d634332();
        return;
    }
    if (self.script_noteworthy == "hunter_swarm") {
        self thread function_db5780d1();
        return;
    }
    var_835e5b1c = spawner::simple_spawn_single(self);
    if (self.script_noteworthy == "patrol") {
        var_835e5b1c thread function_7da79f81(self.target);
        return;
    }
    if (self.script_noteworthy == "defend") {
        if (isdefined(var_835e5b1c.target)) {
        }
        return;
    }
    if (self.script_noteworthy == "guard") {
        if (isdefined(var_835e5b1c.target)) {
        }
        return;
    }
    if (self.script_noteworthy == "scene") {
        var_835e5b1c thread function_ef0b8dc3(self, var_92b4ece5);
    }
}

// Namespace namespace_b002c73b
// Params 0, eflags: 0x1 linked
// Checksum 0xabbda6a1, Offset: 0xa70
// Size: 0xb6
function function_7d634332() {
    path_start = getvehiclenode(self.target, "targetname");
    offset = (0, 60, 0);
    for (i = 0; i < self.script_int; i++) {
        wasp = spawner::simple_spawn_single(self);
        wasp thread function_c6e1fa1(path_start, i);
    }
}

// Namespace namespace_b002c73b
// Params 0, eflags: 0x1 linked
// Checksum 0xe235eed6, Offset: 0xb30
// Size: 0x100
function function_db5780d1() {
    path_start = getvehiclenode(self.target, "targetname");
    hunter = spawner::simple_spawn_single(self);
    hunter vehicle_ai::start_scripted();
    hunter vehicle::get_on_path(path_start);
    hunter.drivepath = 1;
    hunter vehicle::go_path();
    hunter setgoal(level.players[0], 0, 1000);
    hunter vehicle_ai::stop_scripted();
    hunter.lockontarget = level.players[0];
}

// Namespace namespace_b002c73b
// Params 2, eflags: 0x1 linked
// Checksum 0xffd35537, Offset: 0xc38
// Size: 0x110
function function_c6e1fa1(path_start, index) {
    offset = (0, 30, 0);
    self vehicle_ai::start_scripted();
    self vehicle::get_on_path(path_start);
    self.drivepath = 1;
    var_df73cfff = function_e55a5d84(index);
    self pathfixedoffset(offset * var_df73cfff);
    self vehicle::go_path();
    self setgoal(level.players[0], 0, 600, -106);
    self vehicle_ai::stop_scripted();
    self.lockontarget = level.players[0];
}

// Namespace namespace_b002c73b
// Params 1, eflags: 0x1 linked
// Checksum 0x274c93f0, Offset: 0xd50
// Size: 0x4e
function function_e55a5d84(i) {
    if (i % 2 == 0) {
        return (i / 2 * -1);
    }
    return i - i / 2 + 0.5;
}

// Namespace namespace_b002c73b
// Params 1, eflags: 0x1 linked
// Checksum 0x2cc09275, Offset: 0xda8
// Size: 0x90
function function_7da79f81(var_cc525a1a) {
    self endon(#"death");
    while (true) {
        node = self waittill(#"hash_8b1fd6a8");
        if (isdefined(node.script_wait_min) && (isdefined(node.script_wait) || isdefined(node.script_wait_max))) {
            node util::script_wait();
        }
    }
}

// Namespace namespace_b002c73b
// Params 2, eflags: 0x1 linked
// Checksum 0xcc13d254, Offset: 0xe40
// Size: 0x13c
function function_ef0b8dc3(var_2d7613bb, var_92b4ece5) {
    if (isdefined(self.target)) {
        node = getnode(self.target, "targetname");
        if (isdefined(node)) {
        } else {
            var_ac46855a = getent(self.target, "targetname");
            if (isdefined(var_ac46855a)) {
            }
        }
    } else {
        if (isdefined(var_92b4ece5.height)) {
            self.goalheight = var_92b4ece5.height;
        }
        if (isdefined(var_92b4ece5.radius)) {
            self.goalradius = var_92b4ece5.radius;
        }
    }
    wait(0.05);
    assert(isdefined(self.script_string), "patrol");
    var_2d7613bb thread scene::init(self.script_string, self);
}

// Namespace namespace_b002c73b
// Params 0, eflags: 0x1 linked
// Checksum 0x8423ba4c, Offset: 0xf88
// Size: 0x1e4
function function_2cf0cb11() {
    a_entities = getentarray(self.target, "targetname");
    foreach (entity in a_entities) {
        if (isspawner(entity)) {
            entity delete();
            continue;
        }
        if (isdefined(entity.target)) {
            var_917b6649 = getnodearray(entity.target, "targetname");
            foreach (node in var_917b6649) {
                setenablenode(node, 0);
            }
        }
        entity connectpaths();
        entity delete();
    }
    self delete();
}

// Namespace namespace_b002c73b
// Params 0, eflags: 0x0
// Checksum 0x62d0040e, Offset: 0x1178
// Size: 0x1c
function function_fbf6b4c8() {
    if (!isdefined(level.var_7952320e)) {
        level.var_7952320e = 1;
    }
}

