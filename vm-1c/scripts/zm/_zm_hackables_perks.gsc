#using scripts/zm/_zm_equip_hacker;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_75cc53cb;

// Namespace namespace_75cc53cb
// Params 0, eflags: 0x1 linked
// Checksum 0xf8c1c590, Offset: 0x168
// Size: 0x28c
function function_4678364() {
    var_3be8a3b8 = getentarray("zombie_vending", "targetname");
    for (i = 0; i < var_3be8a3b8.size; i++) {
        struct = spawnstruct();
        if (isdefined(var_3be8a3b8[i].machine)) {
            machine[0] = var_3be8a3b8[i].machine;
        } else {
            machine = getentarray(var_3be8a3b8[i].target, "targetname");
        }
        struct.origin = machine[0].origin + anglestoright(machine[0].angles) * 18 + (0, 0, 48);
        struct.radius = 48;
        struct.height = 64;
        struct.script_float = 5;
        while (!isdefined(var_3be8a3b8[i].cost)) {
            wait 0.05;
        }
        struct.script_int = int(var_3be8a3b8[i].cost * -1);
        struct.perk = var_3be8a3b8[i];
        if (isdefined(level.var_e9ec1678)) {
            struct = struct [[ level.var_e9ec1678 ]]();
        }
        var_3be8a3b8[i].hackable = struct;
        struct.var_39787651 = 1;
        zm_equip_hacker::function_66764564(struct, &function_b4d7ca0b, &function_194e8dfe);
    }
    level.var_d1834ad6 = &function_84c54257;
}

// Namespace namespace_75cc53cb
// Params 0, eflags: 0x1 linked
// Checksum 0xc5a10708, Offset: 0x400
// Size: 0x36
function function_84c54257() {
    if (isdefined(self.hackable)) {
        zm_equip_hacker::function_fcbe2f17(self.hackable);
        self.hackable = undefined;
    }
}

// Namespace namespace_75cc53cb
// Params 1, eflags: 0x1 linked
// Checksum 0x69d95eb1, Offset: 0x440
// Size: 0x76
function function_194e8dfe(player) {
    if (isdefined(player.var_7fceabe1)) {
        return false;
    }
    if (isdefined(self.perk) && isdefined(self.perk.script_noteworthy)) {
        if (player hasperk(self.perk.script_noteworthy)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_75cc53cb
// Params 1, eflags: 0x1 linked
// Checksum 0xaef62bd, Offset: 0x4c0
// Size: 0x13a
function function_b4d7ca0b(hacker) {
    if (level flag::get("solo_game") && self.perk.script_noteworthy == "specialty_quickrevive") {
        hacker.lives--;
    }
    hacker notify(self.perk.script_noteworthy + "_stop");
    hacker playsoundtoplayer("evt_perk_throwup", hacker);
    if (isdefined(hacker.var_df099d9b)) {
        keys = getarraykeys(hacker.var_df099d9b);
        for (i = 0; i < hacker.var_df099d9b.size; i++) {
            hacker.var_df099d9b[keys[i]].x = i * 30;
        }
    }
}

