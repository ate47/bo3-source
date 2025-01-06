#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapons;

#namespace explosive_bolt;

// Namespace explosive_bolt
// Params 0, eflags: 0x2
// Checksum 0x716189a7, Offset: 0x140
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("explosive_bolt", &__init__, undefined, undefined);
}

// Namespace explosive_bolt
// Params 0, eflags: 0x0
// Checksum 0xde4192d2, Offset: 0x178
// Size: 0x22
function __init__() {
    callback::on_spawned(&on_player_spawned);
}

// Namespace explosive_bolt
// Params 0, eflags: 0x0
// Checksum 0x6b7c8f00, Offset: 0x1a8
// Size: 0x12
function on_player_spawned() {
    self thread begin_other_grenade_tracking();
}

// Namespace explosive_bolt
// Params 0, eflags: 0x0
// Checksum 0xc8e7564e, Offset: 0x1c8
// Size: 0xed
function begin_other_grenade_tracking() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"bolttrackingstart");
    self endon(#"bolttrackingstart");
    weapon_bolt = getweapon("explosive_bolt");
    for (;;) {
        self waittill(#"grenade_fire", grenade, weapon, cooktime);
        if (grenade util::ishacked()) {
            continue;
        }
        if (weapon == weapon_bolt) {
            grenade.ownerweaponatlaunch = self.currentweapon;
            grenade.owneradsatlaunch = self playerads() == 1 ? 1 : 0;
            grenade thread function_c0dabb0c(self);
            grenade thread weapons::check_stuck_to_player(1, 0, weapon);
        }
    }
}

// Namespace explosive_bolt
// Params 1, eflags: 0x0
// Checksum 0x249579a, Offset: 0x2c0
// Size: 0xa
function function_c0dabb0c(owner) {
    
}

