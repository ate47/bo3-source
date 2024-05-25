#using scripts/zm/zm_sumpf_zipline;
#using scripts/zm/zm_sumpf_perks;
#using scripts/zm/zm_sumpf_trap_pendulum;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;

#namespace namespace_cc27c57e;

// Namespace namespace_cc27c57e
// Params 0, eflags: 0x1 linked
// Checksum 0xd83f6499, Offset: 0x2c8
// Size: 0xbc
function function_2a476331() {
    level thread function_690bec51("nw_magic_box");
    level thread function_690bec51("ne_magic_box");
    level thread function_690bec51("se_magic_box");
    level thread function_690bec51("sw_magic_box");
    level thread function_690bec51("start_zombie_round_logic");
    level.pandora_fx_func = &function_b286cf09;
}

// Namespace namespace_cc27c57e
// Params 0, eflags: 0x1 linked
// Checksum 0x85698f57, Offset: 0x390
// Size: 0xf4
function function_b286cf09() {
    self.pandora_light = spawn("script_model", self.origin);
    self.pandora_light.angles = self.angles + (-90, -90, 0);
    self.pandora_light setmodel("tag_origin");
    if (self.script_noteworthy == "start_chest") {
        playfxontag(level._effect["lght_marker"], self.pandora_light, "tag_origin");
        return;
    }
    playfxontag(level._effect["lght_marker_old"], self.pandora_light, "tag_origin");
}

// Namespace namespace_cc27c57e
// Params 1, eflags: 0x1 linked
// Checksum 0xdc865184, Offset: 0x490
// Size: 0x2fa
function function_690bec51(which) {
    wait(3);
    switch (which) {
    case 0:
        function_a0db1fb9();
        break;
    case 1:
        level flag::wait_till("ne_magic_box");
        level thread namespace_72609f96::function_6d502b1e();
        break;
    case 2:
        level flag::wait_till("se_magic_box");
        break;
    case 3:
        level flag::wait_till("sw_magic_box");
        break;
    case 4:
        level flag::wait_till("start_zombie_round_logic");
        break;
    default:
        return;
    }
    if (isdefined(level.randomize_perks) && level.randomize_perks == 0) {
        namespace_42de9882::function_980b3cd5();
        level.var_7c827139 = [];
        level.var_7c827139[level.var_7c827139.size] = "p7_zm_vending_jugg";
        level.var_7c827139[level.var_7c827139.size] = "p7_zm_vending_doubletap2";
        level.var_7c827139[level.var_7c827139.size] = "p7_zm_vending_revive";
        level.var_7c827139[level.var_7c827139.size] = "p7_zm_vending_sleight";
        level.var_7c827139[level.var_7c827139.size] = "p7_zm_vending_three_gun";
        level.randomize_perks = 1;
    }
    switch (which) {
    case 0:
        level flag::wait_till("northwest_building_unlocked");
        namespace_42de9882::function_5c025696(0);
        break;
    case 1:
        level flag::wait_till("northeast_building_unlocked");
        namespace_42de9882::function_5c025696(1);
        break;
    case 2:
        level flag::wait_till("southeast_building_unlocked");
        namespace_42de9882::function_5c025696(2);
        break;
    case 3:
        level flag::wait_till("southwest_building_unlocked");
        namespace_42de9882::function_5c025696(3);
        break;
    case 4:
        break;
    }
}

// Namespace namespace_cc27c57e
// Params 0, eflags: 0x1 linked
// Checksum 0x1aa1f55a, Offset: 0x798
// Size: 0x124
function function_a0db1fb9() {
    var_3d5f2e06 = getentarray("pendulum_buy_trigger", "targetname");
    foreach (var_d8a7af6f in var_3d5f2e06) {
        var_d8a7af6f sethintstring(%ZOMBIE_CLEAR_DEBRIS);
        var_d8a7af6f setcursorhint("HINT_NOICON");
    }
    level flag::wait_till("nw_magic_box");
    namespace_8217eb2b::function_5b96904c();
    array::thread_all(var_3d5f2e06, &namespace_8217eb2b::function_46e4b0ba);
}

