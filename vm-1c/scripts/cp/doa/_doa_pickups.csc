#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/_util;
#using scripts/shared/exploder_shared;
#using scripts/shared/array_shared;
#using scripts/cp/doa/_doa_camera;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_a7e6beb5;

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x1 linked
// Checksum 0x305cc5bf, Offset: 0x6d0
// Size: 0x9ac
function init() {
    clientfield::register("scriptmover", "pickuptype", 1, 10, "int", &function_892b2a87, 0, 0);
    clientfield::register("scriptmover", "pickupwobble", 1, 1, "int", &pickupwobble, 0, 0);
    clientfield::register("scriptmover", "pickuprotate", 1, 1, "int", &pickuprotate, 0, 0);
    clientfield::register("scriptmover", "pickupscale", 1, 8, "int", &pickupscale, 0, 0);
    clientfield::register("scriptmover", "pickupvisibility", 1, 1, "int", &function_68ad0d79, 0, 0);
    clientfield::register("scriptmover", "pickupmoveto", 1, 4, "int", &function_474724d7, 0, 0);
    level.doa.pickups = [];
    function_db1442f2("zombietron_silver_coin", 1.25, 1, 0);
    function_db1442f2("zombietron_silver_brick", 1.25, 1, 1);
    function_db1442f2("zombietron_silver_bricks", 1.5, 1, 2);
    function_db1442f2("zombietron_gold_coin", 1.25, 1, 3);
    function_db1442f2("zombietron_gold_brick", 1.5, 1, 4);
    function_db1442f2("zombietron_gold_bricks", 1.5, 1, 5);
    function_db1442f2("zombietron_money_icon", 1.5, 1, 6);
    function_db1442f2("zombietron_ruby", 1, 1, 7);
    function_db1442f2("zombietron_sapphire", 1, 1, 8);
    function_db1442f2("zombietron_diamond", 1, 1, 9);
    function_db1442f2("zombietron_emerald", 1, 1, 10);
    function_db1442f2("zombietron_beryl", 1, 1, 11);
    function_db1442f2("p7_doa_powerup_skull", 1, 1, 12);
    function_db1442f2("wpn_t7_mingun_world", 2.1, 16, 0);
    function_db1442f2("wpn_t7_shotgun_spartan_world", 3, 16, 1);
    function_db1442f2("wpn_t7_hero_mgl_world", 2.4, 16, 2);
    function_db1442f2("wpn_t7_launch_blackcell_world", 2.4, 16, 3);
    function_db1442f2("wpn_t7_zombietron_raygun_world", 3.5, 16, 4);
    function_db1442f2("wpn_t7_hero_flamethrower_world", 2, 16, 5);
    function_db1442f2("zombietron_ammobox", 2, 2);
    function_db1442f2("zombietron_chicken", 1, 5);
    function_db1442f2("veh_t7_turret_sentry_gun_world", 0.75, 3);
    function_db1442f2("zombietron_barrel", 1, 7);
    function_db1442f2("zombietron_sawblade", 2, 19);
    function_db1442f2("zombietron_umbrella", 0.5, 17);
    function_db1442f2("zombietron_electric_ball", 1.5, 6);
    function_db1442f2("zombietron_boots", 2, 4);
    function_db1442f2("zombietron_lightning_bolt", 1.5, 10);
    function_db1442f2("veh_t7_drone_raps_zombietron", 1, 25);
    function_db1442f2("zombietron_nuke", 0.8, 12);
    function_db1442f2("zombietron_sprinkler", 5.5, 20);
    function_db1442f2("zombietron_monkey_bomb", 1, 11);
    function_db1442f2("zombietron_magnet", 3, 21);
    function_db1442f2("zombietron_teddy_bear", 1.6, 13);
    function_db1442f2("veh_t7_mil_tank_tiger_zombietron", 1, 33);
    function_db1442f2("zombietron_boxing_gloves_rt", 1, 34);
    function_db1442f2("zombietron_egg", 1, 23);
    function_db1442f2("zombietron_wallclock", 1, 14);
    function_db1442f2("zombietron_grenade_turret", 1, 18);
    function_db1442f2("zombietron_bones_skeleton", 1.4, 30);
    function_db1442f2("veh_t7_drone_amws_armored_mp_lite", 1, 22);
    function_db1442f2("zombietron_vortex", 0.5, 29);
    function_db1442f2("zombietron_heart", 1, 26);
    function_db1442f2("zombietron_siegebot_mini", 0.7, 24);
    function_db1442f2("zombietron_chicken_fido", 1, 38);
    function_db1442f2("c_54i_robot_3", 1, 31);
    function_db1442f2("veh_t7_drone_hunter_zombietron", 1, 9);
    function_db1442f2("zombietron_extra_life", 1, 8);
    function_db1442f2("zombietron_eggxl", 1, 27);
    function_db1442f2("p7_doa_powerup_skull", 1, 32);
    function_db1442f2("p7_bonuscard_perk_3_greed", 3, 35);
    function_db1442f2("zombietron_goldegg", 1, 36);
    function_db1442f2("p7_zm_ctl_dg_coat_horn", 3, 37);
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x1 linked
// Checksum 0x5eaf18e6, Offset: 0x1088
// Size: 0x58
function function_f7726690(parent) {
    parent endon(#"entityshutdown");
    parent endon(#"hash_4c187db8");
    self endon(#"entityshutdown");
    while (true) {
        self.origin = parent.origin;
        wait 0.016;
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x1 linked
// Checksum 0x9862c844, Offset: 0x10e8
// Size: 0x44
function function_6cb8e053() {
    self endon(#"hash_cfadee1b");
    self waittill(#"entityshutdown");
    if (isdefined(self.var_eba9b631)) {
        self.var_eba9b631 delete();
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x1 linked
// Checksum 0x204ed40f, Offset: 0x1138
// Size: 0x158
function function_ee036ce4() {
    self notify(#"hash_b14b3cac");
    self endon(#"hash_b14b3cac");
    self endon(#"entityshutdown");
    while (isdefined(self)) {
        waittime = randomfloatrange(2.5, 5);
        yaw = randomint(360);
        if (yaw > 300) {
            yaw = 300;
        } else if (yaw < 60) {
            yaw = 60;
        }
        yaw = self.angles[1] + yaw;
        self rotateto((-20 + randomint(40), yaw, -90 + randomint(-76)), waittime, waittime * 0.5, waittime * 0.5);
        wait randomfloat(waittime - 0.1);
    }
}

// Namespace namespace_a7e6beb5
// Params 7, eflags: 0x1 linked
// Checksum 0x2ddefc28, Offset: 0x1298
// Size: 0x9c
function pickupwobble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_eba9b631)) {
        return;
    }
    if (newval) {
        self.var_eba9b631 thread function_ee036ce4();
        return;
    }
    self.var_eba9b631 notify(#"hash_b14b3cac");
    self.var_eba9b631.angles = self.angles;
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x1 linked
// Checksum 0x63c99d7b, Offset: 0x1340
// Size: 0xce
function function_6093755a() {
    self notify(#"hash_398ca74c");
    self endon(#"hash_398ca74c");
    self endon(#"entityshutdown");
    dir = -76;
    if (randomint(100) > 50) {
        dir = -180;
    }
    time = randomfloatrange(3, 7);
    while (isdefined(self)) {
        self rotateto(self.angles + (0, dir, 0), time);
        wait time;
    }
}

// Namespace namespace_a7e6beb5
// Params 7, eflags: 0x1 linked
// Checksum 0x79653532, Offset: 0x1418
// Size: 0x9c
function pickuprotate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_eba9b631)) {
        return;
    }
    if (newval) {
        self.var_eba9b631 thread function_6093755a();
        return;
    }
    self.var_eba9b631 notify(#"hash_398ca74c");
    self.var_eba9b631.angles = self.angles;
}

// Namespace namespace_a7e6beb5
// Params 7, eflags: 0x1 linked
// Checksum 0x6dfb3349, Offset: 0x14c0
// Size: 0x94
function function_68ad0d79(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_eba9b631)) {
        return;
    }
    if (newval == 0) {
        self.var_eba9b631 show();
        return;
    }
    if (newval == 1) {
        self.var_eba9b631 hide();
    }
}

// Namespace namespace_a7e6beb5
// Params 7, eflags: 0x1 linked
// Checksum 0xfc6cfe4d, Offset: 0x1560
// Size: 0xac
function pickupscale(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_eba9b631)) {
        return;
    }
    scale = newval / (256 - 1) * 16;
    if (scale < 0.5) {
        scale = 0.5;
    }
    self.var_eba9b631 setscale(scale);
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x1 linked
// Checksum 0xc9916fb5, Offset: 0x1618
// Size: 0x1bc
function function_6b4a5f81(player) {
    self endon(#"entityshutdown");
    self show();
    if (isdefined(player)) {
        x = 2000;
        y = 3000;
        z = 1000;
        if (level.doa.flipped) {
            x = 0 - x;
            y = 0 - y;
        }
        var_70adda17 = player.origin;
        entnum = player getentitynumber();
        if (entnum == 1) {
            y = 0 - y;
        } else if (entnum == 2) {
            x = 0 - x;
        } else if (entnum == 3) {
            y = 0 - y;
            x = 0 - x;
        }
        var_70adda17 += (x, y, z);
    } else {
        var_70adda17 = self.origin + (0, 0, 3000);
    }
    wait 0.016;
    self moveto(var_70adda17, 2, 0, 0);
    wait 2;
    self delete();
}

// Namespace namespace_a7e6beb5
// Params 7, eflags: 0x1 linked
// Checksum 0x510d64df, Offset: 0x17e0
// Size: 0x19c
function function_474724d7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_eba9b631)) {
        return;
    }
    self notify(#"hash_4c187db8");
    self notify(#"hash_cfadee1b");
    self notify(#"hash_398ca74c");
    self notify(#"hash_b14b3cac");
    player = undefined;
    newval -= 1;
    if (newval > 0) {
        entnum = (newval >> 1) - 1;
        players = getplayers(localclientnum);
        foreach (guy in players) {
            if (guy getentitynumber() == entnum) {
                player = guy;
                break;
            }
        }
    }
    self.var_eba9b631 thread function_6b4a5f81(player);
}

// Namespace namespace_a7e6beb5
// Params 7, eflags: 0x1 linked
// Checksum 0x46a7359b, Offset: 0x1988
// Size: 0x234
function function_892b2a87(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_869acbe6) && level.doa.arenas[level.doa.var_90873830].var_869acbe6 && localclientnum > 0) {
        return;
    }
    type = newval & 64 - 1;
    variant = undefined;
    if (newval > 38) {
        variant = newval >> 6;
        assert(type == 1 || type == 16);
    }
    def = function_bac08508(type, variant);
    if (!isdefined(def)) {
        return;
    }
    self.var_eba9b631 = spawn(localclientnum, self.origin, "script_model");
    self.var_eba9b631 setmodel(def.modelname);
    self.var_eba9b631.angles = self.angles;
    self.var_eba9b631 setscale(def.scale);
    self.var_eba9b631 notsolid();
    self thread function_6cb8e053();
    self.var_eba9b631 thread function_f7726690(self);
}

// Namespace namespace_a7e6beb5
// Params 2, eflags: 0x1 linked
// Checksum 0xd3712911, Offset: 0x1bc8
// Size: 0xd0
function function_bac08508(type, variant) {
    foreach (pickup in level.doa.pickups) {
        if (pickup.type == type) {
            if (!isdefined(variant)) {
                return pickup;
            }
            if (variant === pickup.variant) {
                return pickup;
            }
        }
    }
}

// Namespace namespace_a7e6beb5
// Params 4, eflags: 0x1 linked
// Checksum 0x52ff6b45, Offset: 0x1ca0
// Size: 0xb6
function function_db1442f2(modelname, modelscale, type, variant) {
    pickup = spawnstruct();
    pickup.modelname = modelname;
    pickup.scale = modelscale;
    pickup.type = type;
    pickup.variant = variant;
    level.doa.pickups[level.doa.pickups.size] = pickup;
}

