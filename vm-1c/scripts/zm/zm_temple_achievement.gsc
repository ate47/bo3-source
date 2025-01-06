#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;

#namespace zm_temple_achievement;

// Namespace zm_temple_achievement
// Params 0, eflags: 0x2
// Checksum 0x85d44949, Offset: 0x1a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_temple_achievement", &__init__, undefined, undefined);
}

// Namespace zm_temple_achievement
// Params 0, eflags: 0x0
// Checksum 0xce12fe37, Offset: 0x1e8
// Size: 0x3c
function __init__() {
    level thread function_464ab62e();
    callback::on_connect(&onplayerconnect);
}

// Namespace zm_temple_achievement
// Params 0, eflags: 0x0
// Checksum 0x29faf7cc, Offset: 0x230
// Size: 0x1c
function onplayerconnect() {
    self thread function_6c8ceb12();
}

// Namespace zm_temple_achievement
// Params 0, eflags: 0x0
// Checksum 0xfad500d5, Offset: 0x258
// Size: 0x4c
function function_464ab62e() {
    level waittill(#"hash_78ab33de");
    level thread zm::set_sidequest_completed("EOA");
    level zm_utility::giveachievement_wrapper("DLC4_ZOM_TEMPLE_SIDEQUEST", 1);
}

// Namespace zm_temple_achievement
// Params 0, eflags: 0x0
// Checksum 0xf7af4f49, Offset: 0x2b0
// Size: 0x1c
function function_abf98a69() {
    level endon(#"end_game");
    level waittill(#"hash_8a1fe43");
}

// Namespace zm_temple_achievement
// Params 0, eflags: 0x0
// Checksum 0x65b874d4, Offset: 0x2d8
// Size: 0x10
function function_36d842d0() {
    level waittill(#"monkey_see_monkey_dont_achieved");
}

// Namespace zm_temple_achievement
// Params 0, eflags: 0x0
// Checksum 0x56e8b40, Offset: 0x2f0
// Size: 0x28
function function_7a21a2b2() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_abbbecf2");
}

// Namespace zm_temple_achievement
// Params 0, eflags: 0x0
// Checksum 0x8bcd3c81, Offset: 0x320
// Size: 0x174
function function_6c8ceb12() {
    level endon(#"end_game");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"weapon_fired");
        currentweapon = self getcurrentweapon();
        if (currentweapon.name != "shrink_ray" && currentweapon.name != "shrink_ray_upgraded") {
            continue;
        }
        waittillframeend();
        if (isdefined(self.var_e5e4e1e5["monkey_zombie"]) && isdefined(self.var_e5e4e1e5["napalm_zombie"]) && isdefined(self.var_e5e4e1e5["sonic_zombie"]) && isdefined(self.var_e5e4e1e5["zombie"]) && isdefined(self.var_e5e4e1e5) && self.var_e5e4e1e5["zombie"] && self.var_e5e4e1e5["sonic_zombie"] && self.var_e5e4e1e5["napalm_zombie"] && self.var_e5e4e1e5["monkey_zombie"]) {
            break;
        }
    }
    self zm_utility::giveachievement_wrapper("DLC4_ZOM_SMALL_CONSOLATION");
}

