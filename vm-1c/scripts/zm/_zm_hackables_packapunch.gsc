#using scripts/zm/_zm_equip_hacker;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_b03b0164;

// Namespace namespace_b03b0164
// Params 0, eflags: 0x1 linked
// Checksum 0x6a95005a, Offset: 0x150
// Size: 0x17c
function function_7add387d() {
    vending_weapon_upgrade_trigger = getentarray("pack_a_punch", "script_noteworthy");
    perk = getent(vending_weapon_upgrade_trigger[0].target, "targetname");
    if (isdefined(perk)) {
        struct = spawnstruct();
        struct.origin = perk.origin + anglestoright(perk.angles) * 26 + (0, 0, 48);
        struct.radius = 48;
        struct.height = 48;
        struct.script_float = 5;
        struct.script_int = -1000;
        level.var_515d4af7 = struct;
        zm_equip_hacker::function_66764564(level.var_515d4af7, &function_e9bec753);
        level.var_515d4af7 function_13393d82();
    }
}

// Namespace namespace_b03b0164
// Params 0, eflags: 0x1 linked
// Checksum 0x3ea69ead, Offset: 0x2d8
// Size: 0x88
function function_13393d82() {
    if (!level flag::exists("enter_nml")) {
        return;
    }
    while (true) {
        level flag::wait_till("enter_nml");
        self.script_int = -1000;
        while (level flag::get("enter_nml")) {
            wait 1;
        }
    }
}

// Namespace namespace_b03b0164
// Params 1, eflags: 0x1 linked
// Checksum 0x73d40910, Offset: 0x368
// Size: 0x46
function function_e9bec753(hacker) {
    zm_equip_hacker::function_fcbe2f17(level.var_515d4af7);
    level.var_515d4af7.script_int = 0;
    level notify(#"packapunch_hacked");
}

