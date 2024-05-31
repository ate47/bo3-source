#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_blockers;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_65fac977;

// Namespace namespace_65fac977
// Params 0, eflags: 0x0
// namespace_65fac977<file_0>::function_b58c2757
// Checksum 0xea963748, Offset: 0x148
// Size: 0x12a
function function_b58c2757() {
    while (true) {
        wait(0.1);
        origin = self.origin;
        point = origin;
        for (i = 1; i < 5; i++) {
            point = origin + anglestoforward(self.door.angles) * i * 2;
            passed = bullettracepassed(point, origin, 0, undefined);
            color = (0, 255, 0);
            if (!passed) {
                color = (255, 0, 0);
            }
            /#
                print3d(point, "<unknown string>", color, 1, 1);
            #/
        }
    }
}

// Namespace namespace_65fac977
// Params 2, eflags: 0x1 linked
// namespace_65fac977<file_0>::function_96d11a0c
// Checksum 0x2f1921bd, Offset: 0x280
// Size: 0x206
function function_96d11a0c(targetname, var_4706f85c) {
    if (!isdefined(targetname)) {
        targetname = "zombie_door";
    }
    doors = getentarray(targetname, "targetname");
    if (!isdefined(var_4706f85c)) {
        var_4706f85c = &zm_blockers::door_opened;
    }
    for (i = 0; i < doors.size; i++) {
        door = doors[i];
        struct = spawnstruct();
        struct.origin = door.origin + anglestoforward(door.angles) * 2;
        struct.radius = 48;
        struct.height = 72;
        struct.script_float = 32.7;
        struct.script_int = -56;
        struct.door = door;
        struct.var_39787651 = 1;
        struct.var_4706f85c = var_4706f85c;
        var_576f2bd7 = 0;
        door thread function_587a65c2(struct);
        namespace_6d813654::function_66764564(struct, &function_db628e13);
        door thread function_1f3000dc(struct);
    }
}

// Namespace namespace_65fac977
// Params 1, eflags: 0x1 linked
// namespace_65fac977<file_0>::function_587a65c2
// Checksum 0x89ea7117, Offset: 0x490
// Size: 0x44
function function_587a65c2(var_3d380693) {
    self endon(#"death");
    self endon(#"hash_5b86d8c8");
    self endon(#"door_opened");
    namespace_6d813654::function_4edfe9fb();
}

// Namespace namespace_65fac977
// Params 1, eflags: 0x1 linked
// namespace_65fac977<file_0>::function_1f3000dc
// Checksum 0x4d13b7ef, Offset: 0x4e0
// Size: 0x44
function function_1f3000dc(var_3d380693) {
    self waittill(#"door_opened");
    self endon(#"hash_5b86d8c8");
    function_be5f5b6e(var_3d380693.door);
}

// Namespace namespace_65fac977
// Params 1, eflags: 0x1 linked
// namespace_65fac977<file_0>::function_db628e13
// Checksum 0x29ce261a, Offset: 0x530
// Size: 0x78
function function_db628e13(hacker) {
    self.door notify(#"hash_5b86d8c8");
    self.door notify(#"kill_door_think");
    function_be5f5b6e(self.door);
    self.door [[ self.var_4706f85c ]]();
    self.door._door_open = 1;
}

// Namespace namespace_65fac977
// Params 1, eflags: 0x1 linked
// namespace_65fac977<file_0>::function_be5f5b6e
// Checksum 0x660d7ad6, Offset: 0x5b0
// Size: 0xee
function function_be5f5b6e(door) {
    candidates = [];
    for (i = 0; i < level.var_c919fdca.size; i++) {
        obj = level.var_c919fdca[i];
        if (isdefined(obj.door) && obj.door.target == door.target) {
            candidates[candidates.size] = obj;
        }
    }
    for (i = 0; i < candidates.size; i++) {
        namespace_6d813654::function_fcbe2f17(candidates[i]);
    }
}

