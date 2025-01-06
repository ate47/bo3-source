#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_powerups;

#namespace namespace_27e18f93;

// Namespace namespace_27e18f93
// Params 1, eflags: 0x0
// Checksum 0xde066432, Offset: 0x1c0
// Size: 0x66
function function_a3cb1732(name) {
    ret = 0;
    switch (name) {
    case "bonus_points_player":
    case "bonus_points_team":
    case "lose_points_team":
    case "random_weapon":
    case "ww_grenade":
        ret = 1;
        break;
    }
    return ret;
}

// Namespace namespace_27e18f93
// Params 0, eflags: 0x0
// Checksum 0xc54cb437, Offset: 0x230
// Size: 0x128
function function_5c836466() {
    while (true) {
        level waittill(#"powerup_dropped", powerup);
        if (!function_a3cb1732(powerup.powerup_name)) {
            struct = spawnstruct();
            struct.origin = powerup.origin;
            struct.radius = 65;
            struct.height = 72;
            struct.script_float = 5;
            struct.script_int = 5000;
            struct.powerup = powerup;
            powerup thread function_6f4d246b(struct);
            zm_equip_hacker::function_66764564(struct, &function_2d16ef55);
        }
    }
}

// Namespace namespace_27e18f93
// Params 1, eflags: 0x0
// Checksum 0xa3063f9c, Offset: 0x360
// Size: 0x3c
function function_6f4d246b(var_b8ec5af9) {
    self endon(#"hacked");
    self waittill(#"death");
    zm_equip_hacker::function_fcbe2f17(var_b8ec5af9);
}

// Namespace namespace_27e18f93
// Params 1, eflags: 0x0
// Checksum 0x586497cc, Offset: 0x3a8
// Size: 0x1b4
function function_2d16ef55(hacker) {
    self.powerup notify(#"hacked");
    if (isdefined(self.powerup.zombie_grabbable) && self.powerup.zombie_grabbable) {
        self.powerup notify(#"powerup_timedout");
        origin = self.powerup.origin;
        self.powerup delete();
        self.powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", origin);
        if (isdefined(self.powerup)) {
            self.powerup zm_powerups::powerup_setup("full_ammo");
            self.powerup thread zm_powerups::powerup_timeout();
            self.powerup thread zm_powerups::powerup_wobble();
            self.powerup thread zm_powerups::powerup_grab();
        }
    } else if (self.powerup.powerup_name == "full_ammo") {
        self.powerup zm_powerups::powerup_setup("fire_sale");
    } else {
        self.powerup zm_powerups::powerup_setup("full_ammo");
    }
    zm_equip_hacker::function_fcbe2f17(self);
}

