#using scripts/zm/_zm_equip_hacker;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_359e846b;

// Namespace namespace_359e846b
// Params 0, eflags: 0x1 linked
// Checksum 0xda2b6faf, Offset: 0x180
// Size: 0x224
function function_862bc532() {
    weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
    for (i = 0; i < weapon_spawns.size; i++) {
        if (weapon_spawns[i].weapon.type == "grenade") {
            continue;
        }
        if (weapon_spawns[i].weapon.type == "melee") {
            continue;
        }
        if (weapon_spawns[i].weapon.type == "mine") {
            continue;
        }
        if (weapon_spawns[i].weapon.type == "bomb") {
            continue;
        }
        struct = spawnstruct();
        struct.origin = weapon_spawns[i].origin;
        struct.radius = 48;
        struct.height = 48;
        struct.script_float = 2;
        struct.script_int = 3000;
        struct.wallbuy = weapon_spawns[i];
        zm_equip_hacker::function_66764564(struct, &function_c9123339);
    }
    var_d4970e0b = getentarray("bowie_upgrade", "targetname");
    array::thread_all(var_d4970e0b, &zm_equip_hacker::function_4edfe9fb);
}

// Namespace namespace_359e846b
// Params 1, eflags: 0x1 linked
// Checksum 0x961c1c94, Offset: 0x3b0
// Size: 0x8c
function function_c9123339(hacker) {
    self.wallbuy.trigger_stub.hacked = 1;
    self.clientfieldname = self.wallbuy.zombie_weapon_upgrade + "_" + self.origin;
    level clientfield::set(self.clientfieldname, 2);
    zm_equip_hacker::function_fcbe2f17(self);
}

