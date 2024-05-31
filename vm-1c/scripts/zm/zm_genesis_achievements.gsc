#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_c20cb06c;

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x2
// namespace_c20cb06c<file_0>::function_2dc19561
// Checksum 0xcdc602c, Offset: 0x408
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_genesis_achievements", &__init__, undefined, undefined);
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_8c87d8eb
// Checksum 0x2b170a28, Offset: 0x448
// Size: 0x74
function __init__() {
    level thread function_c190d113();
    level thread function_902aff55();
    callback::on_connect(&on_player_connect);
    zm_spawner::register_zombie_death_event_callback(&function_71e89ea4);
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_fb4f96b5
// Checksum 0xaa3b6528, Offset: 0x4c8
// Size: 0x94
function on_player_connect() {
    self thread function_4d2d1f7a();
    self thread function_553e6274();
    self thread function_7d947aff();
    self thread function_def0e284();
    self thread function_e3cc5d03();
    self thread function_c77b5630();
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_c190d113
// Checksum 0xe4c8d894, Offset: 0x568
// Size: 0x44
function function_c190d113() {
    level waittill(#"hash_91a3107");
    array::run_all(level.players, &giveachievement, "ZM_GENESIS_EE");
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_902aff55
// Checksum 0xf5a7834a, Offset: 0x5b8
// Size: 0x44
function function_902aff55() {
    level waittill(#"hash_154abf47");
    array::run_all(level.players, &giveachievement, "ZM_GENESIS_SUPER_EE");
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_4d2d1f7a
// Checksum 0xe99642f0, Offset: 0x608
// Size: 0x2c
function function_4d2d1f7a() {
    level waittill(#"hash_e4411b8f");
    self giveachievement("ZM_GENESIS_PACKECTOMY");
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_553e6274
// Checksum 0x24026630, Offset: 0x640
// Size: 0xdc
function function_553e6274() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_71148446 = [];
    self.var_71148446[0] = "mechz";
    self.var_71148446[1] = "zombie";
    self.var_71148446[2] = "parasite";
    self.var_71148446[3] = "spider";
    self.var_71148446[4] = "margwa";
    self.var_71148446[5] = "keeper";
    self.var_71148446[6] = "apothicon_fury";
    self thread function_3c82f182();
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_3c82f182
// Checksum 0xe19ca272, Offset: 0x728
// Size: 0x44
function function_3c82f182() {
    while (self.var_71148446.size > 0) {
        self waittill(#"hash_af442f7c");
    }
    self giveachievement("ZM_GENESIS_KEEPER_ASSIST");
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_817b1327
// Checksum 0xab1d6ee6, Offset: 0x778
// Size: 0x9a
function function_817b1327() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self endon(#"hash_720f4d71");
    var_ef6b3d38 = 0;
    while (true) {
        e_attacker = level waittill(#"hash_98ea05");
        if (e_attacker === self) {
            var_ef6b3d38++;
        }
        if (var_ef6b3d38 >= 40) {
            self giveachievement("ZM_GENESIS_DEATH_RAY");
            return;
        }
    }
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_7d947aff
// Checksum 0x8bc85c99, Offset: 0x820
// Size: 0x11a
function function_7d947aff() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_88f45a31 = [];
    self.var_88f45a31[self.var_88f45a31.size] = "start_island";
    self.var_88f45a31[self.var_88f45a31.size] = "prison_island";
    self.var_88f45a31[self.var_88f45a31.size] = "asylum_island";
    self.var_88f45a31[self.var_88f45a31.size] = "temple_island";
    self.var_88f45a31[self.var_88f45a31.size] = "prototype_island";
    self thread function_935679b0();
    while (self.var_88f45a31.size > 0) {
        self waittill(#"hash_421672a9");
    }
    self giveachievement("ZM_GENESIS_GRAND_TOUR");
    self.var_88f45a31 = undefined;
    self notify(#"hash_2bec714");
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_935679b0
// Checksum 0x90a1a7da, Offset: 0x948
// Size: 0xe8
function function_935679b0() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self endon(#"hash_2bec714");
    while (!isdefined(self.var_a3d40b8)) {
        util::wait_network_frame();
    }
    var_e274e0c3 = self.var_a3d40b8;
    self thread function_f17c9ba1();
    while (true) {
        if (isdefined(self.var_a3d40b8) && var_e274e0c3 != self.var_a3d40b8) {
            self thread function_f17c9ba1();
            var_e274e0c3 = self.var_a3d40b8;
            self notify(#"hash_421672a9");
        }
        wait(randomfloatrange(0.5, 1));
    }
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_f17c9ba1
// Checksum 0xfa92a53b, Offset: 0xa38
// Size: 0xcc
function function_f17c9ba1() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self endon(#"hash_2bec714");
    var_a43542cc = self.var_a3d40b8;
    if (isdefined(var_a43542cc) && isinarray(self.var_88f45a31, var_a43542cc)) {
        arrayremovevalue(self.var_88f45a31, var_a43542cc);
    } else {
        return;
    }
    self waittill(#"hash_421672a9");
    wait(120);
    if (isdefined(self.var_88f45a31)) {
        array::add(self.var_88f45a31, var_a43542cc, 0);
    }
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_def0e284
// Checksum 0xd9d6a0d0, Offset: 0xb10
// Size: 0xa2
function function_def0e284() {
    level endon(#"end_game");
    self endon(#"disconnect");
    var_fc2fd82c = [];
    while (true) {
        var_475b0a4e = self waittill(#"hash_cd399793");
        array::add(var_fc2fd82c, var_475b0a4e, 0);
        if (var_fc2fd82c.size >= 3) {
            self giveachievement("ZM_GENESIS_WARDROBE_CHANGE");
            return;
        }
    }
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_e3cc5d03
// Checksum 0xfe340414, Offset: 0xbc0
// Size: 0x2c
function function_e3cc5d03() {
    self waittill(#"hash_86cee34e");
    self giveachievement("ZM_GENESIS_WONDERFUL");
}

// Namespace namespace_c20cb06c
// Params 0, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_c77b5630
// Checksum 0xaab4016d, Offset: 0xbf8
// Size: 0x9c
function function_c77b5630() {
    level flagsys::wait_till("start_zombie_round_logic");
    level flag::wait_till_all(array("power_on1", "power_on2", "power_on3", "power_on4"));
    if (level.round_number <= 6) {
        self giveachievement("ZM_GENESIS_CONTROLLED_CHAOS");
    }
}

// Namespace namespace_c20cb06c
// Params 1, eflags: 0x1 linked
// namespace_c20cb06c<file_0>::function_71e89ea4
// Checksum 0xa5f33961, Offset: 0xca0
// Size: 0x158
function function_71e89ea4(e_attacker) {
    if (isdefined(self.damageweapon) && zm_weapons::is_wonder_weapon(self.damageweapon)) {
        if (issubstr(self.damageweapon.name, "thundergun")) {
            if (!isdefined(e_attacker.var_2831078e)) {
                e_attacker.var_2831078e = 0;
            }
            e_attacker.var_2831078e++;
        } else if (issubstr(self.damageweapon.name, "idgun")) {
            if (!isdefined(e_attacker.var_29bc01fd)) {
                e_attacker.var_29bc01fd = 0;
            }
            e_attacker.var_29bc01fd++;
        }
        if (isdefined(e_attacker.var_2831078e) && isdefined(e_attacker.var_29bc01fd) && e_attacker.var_29bc01fd >= 10 && e_attacker.var_2831078e >= 10) {
            e_attacker notify(#"hash_86cee34e");
        }
    }
}

