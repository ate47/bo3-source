#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_chicken_pickup;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_pickup_area_affect;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_shield_pickup;
#using scripts/cp/doa/_doa_tesla_pickup;
#using scripts/cp/doa/_doa_turret_pickup;
#using scripts/cp/doa/_doa_utility;
#using scripts/cp/doa/_doa_vehicle_pickup;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_vortex;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace namespace_a7e6beb5;

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xc00
// Size: 0x2
function precache() {
    
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0x3e6fe920, Offset: 0xc10
// Size: 0x10c2
function init() {
    assert(isdefined(level.doa));
    precache();
    level.doa.pickups = spawnstruct();
    level.doa.pickups.var_dbd6e632 = 0;
    level.doa.pickups.money = [];
    level.doa.pickups.var_3e3b7a53 = [];
    level.doa.pickups.items = [];
    level.doa.var_3cc04c3a = [];
    level.doa.var_bd919311 = "zombietron_ammobox";
    level.doa.turret_model = "veh_t7_turret_sentry_gun_world";
    level.doa.var_b851a0fc = "zombietron_grenade_turret";
    level.doa.var_f7277ad6 = "zombietron_boots";
    level.doa.var_8d63e734 = "zombietron_chicken";
    level.doa.var_9505395a = "zombietron_chicken_gold";
    level.doa.var_a7cfb7eb = "zombietron_chicken_silver";
    level.doa.var_f6e22ab8 = "zombietron_electric_ball";
    level.doa.var_f6947407 = "zombietron_barrel";
    level.doa.var_890f74c0 = "zombietron_extra_life";
    level.doa.var_3b704a85 = "veh_t7_drone_hunter_zombietron";
    level.doa.var_37366651 = "zombietron_lightning_bolt";
    level.doa.var_d6256e83 = "zombietron_monkey_bomb";
    level.doa.var_501f85b4 = "zombietron_nuke";
    level.doa.var_7f53bb28 = "zombietron_teddy_bear";
    level.doa.var_27f4032b = "zombietron_wallclock";
    level.doa.var_90650338 = "zombietron_water_buffalo";
    level.doa.var_f21ae3af = "zombietron_umbrella";
    level.doa.var_97bbae9c = "zombietron_sawblade";
    level.doa.var_304b4b41 = "zombietron_sprinkler";
    level.doa.var_3481ab4d = "zombietron_magnet";
    level.doa.var_4aa90d77 = "veh_t7_drone_amws_armored_mp_lite";
    level.doa.var_43922ff2 = "zombietron_egg";
    level.doa.var_d17dd2a6 = "zombietron_eggxl";
    level.doa.var_e1df04b = "zombietron_siegebot_mini";
    level.doa.var_4de532b3 = "veh_t7_drone_raps_zombietron";
    level.doa.var_f36fe0e3 = "veh_t7_mil_tank_tiger_zombietron";
    level.doa.var_326cdb5e = "zombietron_bones_skeleton";
    level.doa.var_afa6d081 = "zombietron_heart";
    level.doa.var_ed2fb7a7 = "zombietron_vortex";
    level.doa.var_e61bb123 = "zombietron_boxing_gloves_rt";
    level.doa.var_24fe9829 = "c_54i_robot_3";
    level.doa.var_9bf7e61b = "p7_doa_powerup_skull";
    function_58268dbd("zombietron_silver_coin", &function_9fc58738, 0, 25, 1.25);
    function_58268dbd("zombietron_silver_coin", &function_9fc58738, 0, 25, 1.25);
    function_58268dbd("zombietron_silver_coin", &function_9fc58738, 0, 25, 1.25);
    function_58268dbd("zombietron_silver_brick", &function_9fc58738, 0, 75, 1.25);
    function_58268dbd("zombietron_silver_brick", &function_9fc58738, 0, 75, 1.5);
    function_58268dbd("zombietron_silver_bricks", &function_9fc58738, 0, -106, 1.5);
    function_58268dbd("zombietron_gold_coin", &function_9fc58738, 0, 50, 1.25);
    function_58268dbd("zombietron_gold_brick", &function_9fc58738, 0, 125, 1.5);
    function_58268dbd("zombietron_gold_bricks", &function_9fc58738, 0, -6, 1.5);
    function_58268dbd("zombietron_money_icon", &function_9fc58738, 0, 750, 1.5);
    function_58268dbd("zombietron_ruby", &function_9fc58738, 1, 0);
    function_58268dbd("zombietron_sapphire", &function_9fc58738, 1, 0);
    function_58268dbd("zombietron_diamond", &function_9fc58738, 1, 0);
    function_58268dbd("zombietron_emerald", &function_9fc58738, 1, 0);
    function_58268dbd("zombietron_beryl", &function_9fc58738, 1, 0);
    function_58268dbd("p7_doa_powerup_skull", &function_9fc58738, 1, 32);
    function_db1442f2("zombietron_deathmachine", &itemspawn, 0, 1, 2.1, 100, 16);
    function_db1442f2("zombietron_shotgun", &itemspawn, 0, 1, 3, 100, 16);
    function_db1442f2("zombietron_launcher", &itemspawn, 0, 1, 2.4, 100, 16);
    function_db1442f2("zombietron_rpg", &itemspawn, 0, 1, 2.4, 100, 16);
    function_db1442f2("zombietron_ray_gun", &itemspawn, 0, 1, 3.5, 100, 16);
    function_db1442f2("zombietron_flamethrower", &itemspawn, 0, 1, 2, 100, 16);
    function_db1442f2("zombietron_deathmachine", &itemspawn, 0, 1, 2.1, 100, 16);
    function_db1442f2("zombietron_shotgun", &itemspawn, 0, 1, 3, 100, 16);
    function_db1442f2("zombietron_launcher", &itemspawn, 0, 1, 2.4, 100, 16);
    function_db1442f2("zombietron_rpg", &itemspawn, 0, 1, 2.4, 100, 16);
    function_db1442f2("zombietron_ray_gun", &itemspawn, 0, 1, 3.5, 100, 16);
    function_db1442f2("zombietron_flamethrower", &itemspawn, 0, 1, 2, 100, 16);
    function_db1442f2("zombietron_nightfury.", &itemspawn, 1, 999999, 2.1, 100, 16);
    function_db1442f2(level.doa.var_bd919311, &itemspawn, 0, 1, 2, 100, 2);
    function_db1442f2(level.doa.var_bd919311, &itemspawn, 0, 1, 2, 100, 2);
    function_db1442f2(level.doa.var_bd919311, &itemspawn, 0, 1, 2, 100, 2);
    function_db1442f2(level.doa.var_8d63e734, &itemspawn, 0, 1, 1, 100, 5, undefined, (0, 0, 0));
    function_db1442f2(level.doa.turret_model, &itemspawn, 0, 1, 0.75, 100, 3);
    function_db1442f2(level.doa.var_f6947407, &itemspawn, 0, 1, 1, 100, 7);
    function_db1442f2(level.doa.var_97bbae9c, &itemspawn, 0, 1, 2, 100, 19, undefined, (0, 0, 0));
    function_db1442f2(level.doa.var_f21ae3af, &itemspawn, 0, 3, 0.5, 100, 17);
    function_db1442f2(level.doa.var_f6e22ab8, &itemspawn, 0, 5, 1.5, 100, 6);
    function_db1442f2(level.doa.var_f7277ad6, &itemspawn, 0, 5, 2, 100, 4);
    function_db1442f2(level.doa.var_37366651, &itemspawn, 0, 5, 1.5, 100, 10);
    function_db1442f2(level.doa.var_4de532b3, &itemspawn, 0, 5, 1, 50, 25);
    function_db1442f2(level.doa.var_501f85b4, &itemspawn, 0, 5, 0.8, 100, 12);
    function_db1442f2(level.doa.var_304b4b41, &itemspawn, 0, 9, 5.5, 100, 20);
    function_db1442f2(level.doa.var_d6256e83, &itemspawn, 0, 9, 1, 100, 11);
    function_db1442f2(level.doa.var_3481ab4d, &itemspawn, 0, 9, 3, 100, 21);
    function_db1442f2(level.doa.var_7f53bb28, &itemspawn, 0, 9, 1.6, 25, 13);
    function_db1442f2(level.doa.var_f36fe0e3, &itemspawn, 0, 10, 1, 100, 33);
    function_db1442f2(level.doa.var_e61bb123, &itemspawn, 0, 10, 1, 100, 34);
    function_db1442f2(level.doa.var_43922ff2, &itemspawn, 0, 13, 1, 25, 23);
    function_db1442f2(level.doa.var_27f4032b, &itemspawn, 0, 13, 1, 100, 14);
    function_db1442f2(level.doa.var_b851a0fc, &itemspawn, 0, 17, 1, 100, 18);
    function_db1442f2(level.doa.var_326cdb5e, &itemspawn, 0, 17, 1.4, 50, 30, undefined, (20, 0, 0), undefined, &function_d0397bc7);
    function_db1442f2(level.doa.var_4aa90d77, &itemspawn, 0, 21, 1, 100, 22);
    function_db1442f2(level.doa.var_ed2fb7a7, &itemspawn, 0, 22, 0.5, 100, 29);
    function_db1442f2(level.doa.var_afa6d081, &itemspawn, 0, 23, 1, 100, 26);
    function_db1442f2(level.doa.var_e1df04b, &itemspawn, 0, 25, 0.7, 25, 24);
    function_db1442f2(level.doa.var_24fe9829, &itemspawn, 0, 26, 1, 50, 31, undefined, (20, 0, 0), undefined, &function_d0397bc7);
    function_db1442f2(level.doa.var_3b704a85, &itemspawn, 0, 30, 1, 25, 9);
    function_db1442f2(level.doa.var_890f74c0, &itemspawn, 0, 999999, 1, 100, 8);
    function_db1442f2(level.doa.var_d17dd2a6, &itemspawn, 0, 999999, 1, 100, 27);
    function_db1442f2(level.doa.var_9bf7e61b, &itemspawn, 0, 999999, 1, 100, 32, undefined, (70, 0, 0), 5, &function_db3e0155);
    level thread function_2904bdc4();
    level thread function_bfc8e78d();
    level thread function_5bb8e0d1();
    level thread function_b8d3f901();
}

// Namespace namespace_a7e6beb5
// Params 5, eflags: 0x0
// Checksum 0xcd169780, Offset: 0x1ce0
// Size: 0x127
function function_58268dbd(var_bcc88c39, var_74f5c76, uber, data, modelscale) {
    if (!isdefined(uber)) {
        uber = 0;
    }
    if (!isdefined(data)) {
        data = 0;
    }
    if (!isdefined(modelscale)) {
        modelscale = 1;
    }
    pickup = spawnstruct();
    pickup.var_bcc88c39 = var_bcc88c39;
    pickup.var_74f5c76 = var_74f5c76;
    pickup.uber = uber;
    pickup.data = data;
    pickup.count = 0;
    pickup.scale = modelscale;
    if (uber) {
        level.doa.pickups.var_3e3b7a53[level.doa.pickups.var_3e3b7a53.size] = pickup;
        return;
    }
    level.doa.pickups.money[level.doa.pickups.money.size] = pickup;
}

// Namespace namespace_a7e6beb5
// Params 11, eflags: 0x0
// Checksum 0x5ce84086, Offset: 0x1e10
// Size: 0x173
function function_db1442f2(var_bcc88c39, var_74f5c76, unique, var_51378233, modelscale, chance, type, data, angles, timeout, var_9b759e09) {
    if (!isdefined(angles)) {
        angles = (0, 0, 70);
    }
    pickup = spawnstruct();
    pickup.var_bcc88c39 = var_bcc88c39;
    pickup.var_74f5c76 = var_74f5c76;
    pickup.var_cfe41854 = unique;
    pickup.count = 0;
    pickup.var_dea19cf0 = var_51378233;
    pickup.scale = modelscale;
    pickup.chance = chance;
    pickup.angles = angles;
    pickup.type = type;
    pickup.data = data;
    pickup.timeout = timeout;
    pickup.var_329373ec = var_9b759e09;
    pickup.var_cee3d90d = type == 16 ? "glow_red" : "glow_item";
    level.doa.pickups.items[level.doa.pickups.items.size] = pickup;
}

// Namespace namespace_a7e6beb5
// Params 3, eflags: 0x0
// Checksum 0xe3978f16, Offset: 0x1f90
// Size: 0x51
function function_c5bc781(origin, width, height) {
    if (!isdefined(width)) {
        width = 42;
    }
    if (!isdefined(height)) {
        height = -126;
    }
    return spawn("trigger_radius", origin, 18, width, height);
}

// Namespace namespace_a7e6beb5
// Params 8, eflags: 0x0
// Checksum 0x64988536, Offset: 0x1ff0
// Size: 0x78c
function function_9fc58738(var_742d8fb5, origin, launch, ondeath, var_b0d7c311, timeout, wobble, glow) {
    if (!isdefined(launch)) {
        launch = 0;
    }
    if (!isdefined(ondeath)) {
        ondeath = 0;
    }
    if (!isdefined(timeout)) {
        timeout = 1;
    }
    if (!isdefined(wobble)) {
        wobble = 1;
    }
    if (!isdefined(glow)) {
        glow = 1;
    }
    if (!mayspawnentity()) {
        return;
    }
    pickup = spawn("script_model", origin);
    pickup.targetname = "pickup";
    pickup.var_18193c2a = origin;
    pickup.type = 1;
    pickup.def = var_742d8fb5;
    pickup.script_noteworthy = "a_pickup_item";
    pickup.angles = (0, randomint(360), 0);
    pickup setmodel(var_742d8fb5.var_bcc88c39);
    pickup notsolid();
    pickup.trigger = function_c5bc781(origin);
    pickup.trigger.targetname = "pickupTrigger";
    pickup.trigger enablelinkto();
    pickup.trigger linkto(pickup);
    pickup.score = pickup.def.data;
    pickup.def.count++;
    pickup thread namespace_1a381543::function_90118d8c("zmb_spawn_pickup_money");
    if (level.doa.var_458c27d == 3) {
        pickup setnosunshadow();
    }
    pickup thread function_d526f0bb();
    pickup thread function_b33393b3();
    if (isdefined(timeout) && timeout) {
        pickup thread pickuptimeout();
    }
    if (!launch) {
        if (isdefined(wobble) && wobble) {
            pickup thread pickupwobble();
        }
    } else {
        pickup thread function_80ed7f();
    }
    if (function_274c7b5(pickup) == 0) {
        pickup notify(#"pickup_ForceAttractKill");
        pickup notify(#"hash_c8c0fb8f");
    }
    if (pickup.def.uber) {
        if (pickup.def.data == 32) {
            pickup.type = 32;
            if (randomint(getdvarint("scr_doa_epic_nurgle_per_count", 25)) == 0) {
                scale = 7;
                increment = 48;
            } else if (randomint(getdvarint("scr_doa_big_nurgle_per_count", 10)) == 0) {
                scale = 5;
                increment = 28;
            } else {
                scale = 3;
                increment = 18;
            }
            pickup.var_25ffdef1 = increment;
            pickup setscale(scale);
            return pickup;
        }
        var_ea9ba02e = level.doa.rules.var_d55e6679 / 4;
        if (ondeath) {
            pickup.score = 0;
            var_c717e67d = var_ea9ba02e;
            scale = 1;
        } else if (isdefined(var_b0d7c311)) {
            var_c717e67d = var_b0d7c311 * var_ea9ba02e;
            scale = var_b0d7c311;
        } else {
            var_c717e67d = var_ea9ba02e;
            scale = 1;
            roll = randomint(100);
            inc = 0;
            if (roll > 80) {
                inc += var_ea9ba02e;
            }
            if (roll > 90) {
                inc += var_ea9ba02e;
            }
            if (roll > 95) {
                inc += var_ea9ba02e;
            }
            if (roll > 98) {
                inc += var_ea9ba02e;
            }
            var_c717e67d += randomfloat(inc);
            scale += var_c717e67d / var_ea9ba02e;
        }
        pickup setscale(scale);
        pickup.var_5d2140f2 = int(var_c717e67d);
        if (!isdefined(var_742d8fb5.var_cee3d90d)) {
            if (issubstr(var_742d8fb5.var_bcc88c39, "emerald")) {
                var_742d8fb5.var_cee3d90d = "glow_green";
                var_742d8fb5.var_d1c98aa0 = "gem_trail_green";
            } else if (issubstr(var_742d8fb5.var_bcc88c39, "ruby")) {
                var_742d8fb5.var_cee3d90d = "glow_red";
                var_742d8fb5.var_d1c98aa0 = "gem_trail_red";
            } else if (issubstr(var_742d8fb5.var_bcc88c39, "sapphire")) {
                var_742d8fb5.var_cee3d90d = "glow_blue";
                var_742d8fb5.var_d1c98aa0 = "gem_trail_blue";
            } else if (issubstr(var_742d8fb5.var_bcc88c39, "beryl")) {
                var_742d8fb5.var_cee3d90d = "glow_yellow";
                var_742d8fb5.var_d1c98aa0 = "gem_trail_yellow";
            } else {
                var_742d8fb5.var_cee3d90d = "glow_white";
                var_742d8fb5.var_d1c98aa0 = "gem_trail_white";
            }
        }
    } else {
        scale = var_742d8fb5.scale + randomfloatrange(0, 0.3);
        pickup setscale(scale);
        if (!isdefined(var_742d8fb5.var_cee3d90d)) {
            if (issubstr(var_742d8fb5.var_bcc88c39, "gold")) {
                chance = level.doa.var_458c27d == 3 ? 40 : 0;
                if (chance && randomint(100) < chance) {
                    var_742d8fb5.var_cee3d90d = "glow_yellow";
                } else {
                    var_742d8fb5.var_cee3d90d = "sparkle_gold";
                }
            }
            if (issubstr(var_742d8fb5.var_bcc88c39, "silver")) {
                chance = level.doa.var_458c27d == 3 ? 40 : 0;
                if (chance && randomint(100) < chance) {
                    var_742d8fb5.var_cee3d90d = "glow_white";
                } else {
                    var_742d8fb5.var_cee3d90d = "sparkle_silver";
                }
            }
        }
    }
    if (isdefined(var_742d8fb5.var_cee3d90d) && glow) {
        pickup thread namespace_eaa992c::function_285a2999(var_742d8fb5.var_cee3d90d);
    }
    return pickup;
}

// Namespace namespace_a7e6beb5
// Params 5, eflags: 0x0
// Checksum 0x43e99952, Offset: 0x2788
// Size: 0x3f2
function itemspawn(var_742d8fb5, location, timeout, rotate, angles) {
    if (!isdefined(timeout)) {
        timeout = 1;
    }
    if (!isdefined(rotate)) {
        rotate = 1;
    }
    if (!mayspawnentity()) {
        return;
    }
    pickup = spawn("script_model", location);
    pickup.targetname = "pickup_item";
    pickup.var_18193c2a = location;
    pickup.def = var_742d8fb5;
    pickup.type = pickup.def.type;
    pickup.angles = isdefined(angles) ? angles : pickup.def.angles;
    pickup.script_noteworthy = "a_pickup_item";
    pickup.timeout = pickup.def.timeout;
    if (pickup.type == 16) {
        weaponmodel = getweaponworldmodel(getweapon(var_742d8fb5.var_bcc88c39));
        pickup setmodel(weaponmodel);
    } else {
        pickup setmodel(var_742d8fb5.var_bcc88c39);
    }
    if (level.doa.var_458c27d == 3) {
        pickup setnosunshadow();
    }
    pickup thread namespace_1a381543::function_90118d8c("zmb_pickup_spawn");
    if (isdefined(pickup.type) && pickup.type == 26) {
        pickup playloopsound("zmb_heart_lp", 2);
    } else if (pickup.type != 1 || isdefined(pickup.type) && pickup.type != 32) {
        pickup playloopsound("zmb_pickup_powerup_shimmer", 2);
    }
    pickup thread function_b33393b3();
    if (pickup function_972fe17c()) {
        pickup.trigger = function_c5bc781(pickup.origin);
        pickup.trigger enablelinkto();
        pickup.trigger linkto(pickup);
        pickup thread function_d526f0bb();
    }
    pickup.def.count++;
    pickup setscale(var_742d8fb5.scale);
    if (function_bbb6019d(pickup)) {
        pickup notsolid();
    }
    if (function_274c7b5(pickup) == 0) {
        pickup notify(#"pickup_ForceAttractKill");
        pickup notify(#"hash_c8c0fb8f");
    }
    pickup thread namespace_eaa992c::function_285a2999(function_c41cf2a8(pickup));
    if (timeout) {
        pickup thread pickuptimeout();
    }
    if (pickup function_f56a2ab() == 0 && rotate) {
        pickup thread pickuprotate();
    }
    if (isdefined(pickup.def.var_329373ec)) {
        pickup [[ pickup.def.var_329373ec ]]();
    }
    return pickup;
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0x41180b9e, Offset: 0x2b88
// Size: 0x69
function function_c41cf2a8(pickup) {
    if (pickup.def.type == 23) {
        return undefined;
    }
    if (pickup.def.type == 32) {
        return undefined;
    }
    if (isdefined(pickup.def.var_cee3d90d)) {
        return pickup.def.var_cee3d90d;
    }
    return "glow_item";
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0x9007c0ee, Offset: 0x2c00
// Size: 0x27
function function_bbb6019d(pickup) {
    if (pickup.def.type == 23) {
        return false;
    }
    return true;
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0x7d916aa8, Offset: 0x2c30
// Size: 0x59
function function_274c7b5(pickup) {
    if (pickup.type == 23) {
        return false;
    }
    if (pickup.type == 5) {
        return false;
    }
    if (isdefined(pickup.def.uber) && pickup.def.uber) {
        return false;
    }
    return true;
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0xddd617e7, Offset: 0x2c98
// Size: 0xe9
function function_90d1a97d(name) {
    for (i = 0; i < level.doa.pickups.var_3e3b7a53.size; i++) {
        if (level.doa.pickups.var_3e3b7a53[i].var_bcc88c39 == name) {
            return level.doa.pickups.var_3e3b7a53[i];
        }
    }
    for (i = 0; i < level.doa.pickups.money.size; i++) {
        if (level.doa.pickups.money[i].var_bcc88c39 == name) {
            return level.doa.pickups.money[i];
        }
    }
}

// Namespace namespace_a7e6beb5
// Params 10, eflags: 0x0
// Checksum 0x752b78f3, Offset: 0x2d90
// Size: 0x21f
function function_2d8cb175(name, origin, amount, launch, ondeath, scale, timeout, wobble, radius, glow) {
    if (!isdefined(amount)) {
        amount = 1;
    }
    if (!isdefined(launch)) {
        launch = 0;
    }
    if (!isdefined(ondeath)) {
        ondeath = 0;
    }
    if (!isdefined(timeout)) {
        timeout = 1;
    }
    if (!isdefined(wobble)) {
        wobble = 1;
    }
    if (!isdefined(radius)) {
        radius = 1;
    }
    if (!isdefined(glow)) {
        glow = 1;
    }
    pickup = function_90d1a97d(name);
    items = [];
    if (!isdefined(pickup)) {
        return items;
    }
    for (i = 0; i < amount; i++) {
        if (!isdefined(origin)) {
            spot = function_ac410a13();
            if (!isdefined(spot)) {
                continue;
            }
            if (isdefined(spot.radius)) {
                radius = spot.radius;
            } else {
                radius = 120;
            }
            origin = spot.origin + (randomintrange(radius * -1, radius), randomintrange(radius * -1, radius), 32);
            items[items.size] = [[ pickup.var_74f5c76 ]](pickup, origin, launch, ondeath, scale, timeout, wobble, glow);
            origin = undefined;
            continue;
        }
        spot = origin;
        if (isdefined(radius)) {
            spot = origin + (randomintrange(radius * -1, radius), randomintrange(radius * -1, radius), 32);
        }
        item = [[ pickup.var_74f5c76 ]](pickup, origin, launch, ondeath, scale, timeout, wobble, glow);
        if (isdefined(item)) {
            items[items.size] = item;
        }
    }
    return items;
}

// Namespace namespace_a7e6beb5
// Params 11, eflags: 0x0
// Checksum 0x741f39af, Offset: 0x2fb8
// Size: 0x231
function function_16237a19(spawn_point, amount, radius, launch, ondeath, scale, specific, interval, shouldtimeout, var_71b8054b, var_5278d8d7) {
    if (!isdefined(radius)) {
        radius = 85;
    }
    if (!isdefined(launch)) {
        launch = 0;
    }
    if (!isdefined(ondeath)) {
        ondeath = 0;
    }
    if (!isdefined(interval)) {
        interval = 0.35;
    }
    if (!isdefined(shouldtimeout)) {
        shouldtimeout = 1;
    }
    if (!isdefined(var_71b8054b)) {
        var_71b8054b = 1;
    }
    if (!isdefined(var_5278d8d7)) {
        var_5278d8d7 = 1;
    }
    level endon(#"hash_8c5b31c5");
    items = [];
    while (amount) {
        amount--;
        if (radius) {
            origin = spawn_point + (randomintrange(0 - radius, radius), randomintrange(0 - radius, radius), 24);
        } else {
            origin = spawn_point;
        }
        if (isdefined(specific)) {
            foreach (treasure in level.doa.pickups.var_3e3b7a53) {
                if (treasure.var_bcc88c39 == specific) {
                    var_4f0bcadb = treasure;
                    break;
                }
            }
        } else {
            var_4f0bcadb = level.doa.pickups.var_3e3b7a53[randomint(level.doa.pickups.var_3e3b7a53.size)];
        }
        if (isdefined(var_4f0bcadb)) {
            item = [[ var_4f0bcadb.var_74f5c76 ]](var_4f0bcadb, origin, launch, ondeath, scale, shouldtimeout, var_71b8054b, var_5278d8d7);
            if (isdefined(item)) {
                items[items.size] = item;
            }
        }
        if (amount > 0 && interval > 0) {
            wait interval;
        }
    }
    return items;
}

// Namespace namespace_a7e6beb5
// Params 3, eflags: 0x0
// Checksum 0x9f8211b3, Offset: 0x31f8
// Size: 0x169
function function_e904e32d(spawn_point, amount, radius) {
    if (!isdefined(radius)) {
        radius = 85;
    }
    level endon(#"hash_8c5b31c5");
    for (i = 0; i < amount; i++) {
        origin = spawn_point + (randomintrange(0 - radius, radius), randomintrange(0 - radius, radius), 24);
        if (randomfloat(getdvarint("scr_doa_uber_price_chance", 1000)) == 0) {
            var_4f0bcadb = level.doa.pickups.var_3e3b7a53[randomint(level.doa.pickups.var_3e3b7a53.size)];
        } else {
            var_4f0bcadb = level.doa.pickups.money[randomint(level.doa.pickups.money.size)];
        }
        [[ var_4f0bcadb.var_74f5c76 ]](var_4f0bcadb, origin);
        util::wait_network_frame();
    }
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0x30d5a0ec, Offset: 0x3370
// Size: 0x14a
function function_68c8220(player) {
    ent = spawn("script_origin", (0, 0, 0));
    ent playloopsound("zmb_pickup_umbrella_loop");
    locations = namespace_49107f3a::function_308fa126(16);
    amount = randomintrange(doa_player_utility::function_5eb6e4d1().size * 3 + 4, doa_player_utility::function_5eb6e4d1().size * 5 + 6);
    while (amount) {
        item = function_16237a19(locations[randomint(locations.size)] + (0, 0, 2200), 1, -128, 1, 1, 1, level.doa.var_9bf7e61b, undefined, 1, 0, 0)[0];
        if (isdefined(item)) {
            item thread function_80ed7f((0, 0, 1));
        }
        amount--;
        wait randomintrange(1, 3);
    }
    ent delete();
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0x24162f26, Offset: 0x34c8
// Size: 0x43
function function_ac410a13() {
    if (level.doa.var_3361a074.size) {
        return level.doa.var_3361a074[randomint(level.doa.var_3361a074.size)];
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x4
// Checksum 0x821a764e, Offset: 0x3518
// Size: 0xab
function private function_c41b5928() {
    var_a60f3304 = 0;
    for (i = 0; i < level.doa.pickups.items.size; i++) {
        if (level.doa.round_number >= level.doa.pickups.items[i].var_dea19cf0) {
            var_a60f3304++;
        }
    }
    assert(var_a60f3304);
    if (level.doa.var_3cc04c3a.size < var_a60f3304 / 4) {
        return 1;
    }
    return 0;
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0xc1b2b70d, Offset: 0x35d0
// Size: 0x1d2
function function_51b3bbf6(type) {
    if (!isdefined(type)) {
        type = 0;
    }
    assert(level.doa.pickups.items.size);
    if (function_c41b5928()) {
        temp = namespace_49107f3a::function_4e9a23a9(level.doa.pickups.items);
        for (i = 0; i < temp.size; i++) {
            if (level.doa.round_number >= temp[i].var_dea19cf0) {
                level.doa.var_3cc04c3a[level.doa.var_3cc04c3a.size] = temp[i];
            }
        }
    }
    if (type != 0) {
        for (i = 0; i < level.doa.pickups.items.size; i++) {
            if (level.doa.pickups.items[i].type == type) {
                return level.doa.pickups.items[i];
            }
        }
    } else {
        index = level.doa.var_3cc04c3a.size - 1;
        var_b30a0cb8 = level.doa.var_3cc04c3a[index];
        arrayremoveindex(level.doa.var_3cc04c3a, index);
        return var_b30a0cb8;
    }
    assert(0);
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0x823a5d29, Offset: 0x37b0
// Size: 0x92
function function_bac08508(type) {
    for (i = 0; i < level.doa.pickups.items.size; i++) {
        if (level.doa.pickups.items[i].type == type) {
            return level.doa.pickups.items[i];
        }
    }
    assert(0);
}

// Namespace namespace_a7e6beb5
// Params 3, eflags: 0x0
// Checksum 0xaaf1889d, Offset: 0x3850
// Size: 0xd3
function function_22d0e830(var_90658db9, var_756668a8, waittime) {
    if (!isdefined(var_90658db9)) {
        var_90658db9 = 0;
    }
    if (!isdefined(var_756668a8)) {
        var_756668a8 = 1;
    }
    if (!isdefined(waittime)) {
        waittime = 2;
    }
    level endon(#"hash_e2918623");
    while (var_756668a8 > 0) {
        spawn_point = function_ac410a13();
        if (isdefined(spawn_point)) {
            if (!var_90658db9) {
                level thread function_e904e32d(spawn_point.origin, 4 + randomint(5));
            } else {
                level thread function_16237a19(spawn_point.origin, 3 + randomint(5));
            }
        }
        var_756668a8--;
        wait waittime;
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0x625f24b5, Offset: 0x3930
// Size: 0x7d
function function_bfc8e78d() {
    level notify(#"hash_bfc8e78d");
    level endon(#"hash_bfc8e78d");
    while (true) {
        wait randomfloatrange(10, 20);
        if (!level flag::get("doa_round_spawning")) {
            wait 1;
            continue;
        }
        if (level flag::get("doa_game_is_over")) {
            continue;
        }
        level thread function_22d0e830();
    }
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0xfdbb74cf, Offset: 0x39b8
// Size: 0x7d
function function_c87a0cd7(name) {
    for (i = 0; i < level.doa.pickups.items.size; i++) {
        if (level.doa.pickups.items[i].var_bcc88c39 == name) {
            return level.doa.pickups.items[i];
        }
    }
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0xa0aa85aa, Offset: 0x3a40
// Size: 0x7d
function function_e2dcc82a(type) {
    for (i = 0; i < level.doa.pickups.items.size; i++) {
        if (level.doa.pickups.items[i].type == type) {
            return level.doa.pickups.items[i];
        }
    }
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0x6b1a7578, Offset: 0x3ac8
// Size: 0x81
function spawnitem(type) {
    if (!isdefined(type)) {
        type = 0;
    }
    level notify(#"spawnitem");
    level endon(#"spawnitem");
    while (true) {
        pickup = function_51b3bbf6(type);
        if (function_967df2b6(pickup)) {
            function_3238133b(pickup.var_bcc88c39);
            return;
        }
        wait 1;
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0x74e2211, Offset: 0x3b58
// Size: 0x125
function function_b8d3f901() {
    self notify(#"hash_b8d3f901");
    self endon(#"hash_b8d3f901");
    level.doa.var_cc2eacdf = [];
    while (true) {
        var_2029adc7 = 0;
        while (level.doa.var_cc2eacdf.size) {
            if (var_2029adc7 >= getdvarint("scr_doa_queue_items_pertick", 2)) {
                break;
            }
            var_2029adc7++;
            item = level.doa.var_cc2eacdf[0];
            function_1972c23b(item.pickup, item.origin, 1, item.timeout, item.radius, item.rotate, item.angles);
            item.amount--;
            if (item.amount == 0) {
                arrayremoveindex(level.doa.var_cc2eacdf, 0);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_a7e6beb5
// Params 7, eflags: 0x0
// Checksum 0xd5b4d0c2, Offset: 0x3c88
// Size: 0x10f
function function_eaf49506(type, origin, amount, timeout, radius, rotate, angles) {
    if (!isdefined(amount)) {
        amount = 1;
    }
    if (!isdefined(timeout)) {
        timeout = 1;
    }
    if (!isdefined(rotate)) {
        rotate = 1;
    }
    queueitem = spawnstruct();
    queueitem.pickup = function_e2dcc82a(type);
    queueitem.origin = origin;
    assert(amount > 0, "<dev string:x28>");
    queueitem.amount = amount;
    queueitem.timeout = timeout;
    queueitem.radius = radius;
    queueitem.rotate = rotate;
    queueitem.angles = angles;
    level.doa.var_cc2eacdf[level.doa.var_cc2eacdf.size] = queueitem;
}

// Namespace namespace_a7e6beb5
// Params 7, eflags: 0x0
// Checksum 0x23d52875, Offset: 0x3da0
// Size: 0x10f
function function_3238133b(name, origin, amount, timeout, radius, rotate, angles) {
    if (!isdefined(amount)) {
        amount = 1;
    }
    if (!isdefined(timeout)) {
        timeout = 1;
    }
    if (!isdefined(rotate)) {
        rotate = 1;
    }
    queueitem = spawnstruct();
    queueitem.pickup = function_c87a0cd7(name);
    queueitem.origin = origin;
    assert(amount > 0, "<dev string:x28>");
    queueitem.amount = amount;
    queueitem.timeout = timeout;
    queueitem.radius = radius;
    queueitem.rotate = rotate;
    queueitem.angles = angles;
    level.doa.var_cc2eacdf[level.doa.var_cc2eacdf.size] = queueitem;
}

// Namespace namespace_a7e6beb5
// Params 7, eflags: 0x0
// Checksum 0x1ceeae29, Offset: 0x3eb8
// Size: 0x19b
function function_1972c23b(pickup, origin, amount, timeout, radius, rotate, angle) {
    if (!isdefined(amount)) {
        amount = 1;
    }
    if (!isdefined(timeout)) {
        timeout = 1;
    }
    if (!isdefined(rotate)) {
        rotate = 1;
    }
    if (!isdefined(pickup)) {
        return;
    }
    items = [];
    for (i = 0; i < amount; i++) {
        if (!isdefined(origin)) {
            spot = function_ac410a13();
            if (!isdefined(spot)) {
                continue;
            }
            if (!isdefined(radius)) {
                if (isdefined(spot.radius)) {
                    radius = spot.radius;
                } else {
                    radius = 120;
                }
            }
            origin = spot.origin + (randomintrange(radius * -1, radius), randomintrange(radius * -1, radius), 32);
            items[items.size] = [[ pickup.var_74f5c76 ]](pickup, origin, timeout, rotate, angle);
            origin = undefined;
            continue;
        }
        spot = origin;
        if (isdefined(radius)) {
            spot = origin + (randomintrange(radius * -1, radius), randomintrange(radius * -1, radius), 32);
        }
        items[items.size] = [[ pickup.var_74f5c76 ]](pickup, spot, timeout, rotate, angle);
    }
    return items;
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0xc80ad375, Offset: 0x4060
// Size: 0xda
function function_53347911(player) {
    self endon(#"picked_up");
    self endon(#"death");
    player endon(#"disconnect");
    self.player = player;
    var_42b46711 = gettime() + 1500;
    while (isdefined(self) && gettime() < var_42b46711) {
        if (self.origin[2] < player.origin[2]) {
            self.origin = player.origin;
            break;
        }
        var_d305e57f = (player.origin[0], player.origin[1], self.origin[2] - 32);
        self.origin = var_d305e57f;
        wait 0.05;
    }
    if (isdefined(self)) {
        self.trigger notify(#"trigger", player);
    }
}

// Namespace namespace_a7e6beb5
// Params 2, eflags: 0x0
// Checksum 0xc0a03591, Offset: 0x4148
// Size: 0x133
function function_30768f24(item, time) {
    self endon(#"disconnect");
    item endon(#"death");
    if (time <= 0) {
        time = 1;
    }
    var_1d6d6b05 = time / 0.15;
    while (isdefined(item) && time > 0.15) {
        dist = distance(self.origin, item.origin);
        step = dist / time / var_1d6d6b05;
        v_to_target = vectornormalize(self.origin - item.origin) * step;
        /#
        #/
        item moveto(item.origin + v_to_target, 0.15);
        dist = distance(self.origin, item.origin);
        if (dist < 32) {
            break;
        }
        time -= 0.15;
        wait 0.15;
    }
    self notify(#"hash_30768f24");
}

// Namespace namespace_a7e6beb5
// Params 3, eflags: 0x0
// Checksum 0xb0b3b14a, Offset: 0x4288
// Size: 0xc3
function function_ab651d00(player, name, amount) {
    if (!isdefined(amount)) {
        amount = 1;
    }
    player endon(#"disconnect");
    pickupdef = function_c87a0cd7(name);
    if (!isdefined(pickupdef)) {
        return;
    }
    while (amount) {
        pickup = [[ pickupdef.var_74f5c76 ]](pickupdef, player.origin + (0, 0, 800));
        pickup thread function_53347911(player);
        if (amount > 1) {
            wait 0.25;
        } else {
            while (isdefined(pickup)) {
                wait 0.5;
            }
        }
        amount--;
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0xbe80850e, Offset: 0x4358
// Size: 0x95
function function_2904bdc4() {
    level notify(#"hash_2904bdc4");
    level endon(#"hash_2904bdc4");
    while (true) {
        if (!level flag::get("doa_round_spawning")) {
            wait 1;
            continue;
        }
        level thread spawnitem();
        if (!level flag::get("doa_game_silverback_round")) {
            wait randomfloatrange(10, 15);
            continue;
        }
        wait randomfloatrange(5, 10);
    }
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0x3e1e0689, Offset: 0x43f8
// Size: 0xea
function weaponspawn(var_bcc88c39) {
    if (!isdefined(var_bcc88c39)) {
        weapons = [];
        for (i = 0; i < level.doa.pickups.items.size; i++) {
            if (level.doa.pickups.items[i].type == 16) {
                weapons[weapons.size] = level.doa.pickups.items[i];
            }
        }
        weapon = weapons[randomint(weapons.size)];
        level function_3238133b(weapon.var_bcc88c39);
        return;
    }
    level function_3238133b(var_bcc88c39);
}

// Namespace namespace_a7e6beb5
// Params 2, eflags: 0x0
// Checksum 0x5f93ad5e, Offset: 0x44f0
// Size: 0x17d
function function_5bb8e0d1(var_742d8fb5, location) {
    level notify(#"hash_5bb8e0d1");
    level endon(#"hash_5bb8e0d1");
    while (true) {
        for (waittime = randomfloatrange(level.doa.rules.var_be9a9995, level.doa.rules.var_ab729583); waittime > 0; waittime -= 5) {
            if (!level flag::get("doa_round_active")) {
                wait 1;
                continue;
            }
            wait 5;
        }
        players = doa_player_utility::function_5eb6e4d1();
        lives = 0;
        for (i = 0; i < players.size; i++) {
            lives += players[i].doa.lives;
        }
        for (waittime = lives * 10; waittime > 0; waittime -= 5) {
            if (!level flag::get("doa_round_active")) {
                wait 1;
                continue;
            }
            wait 5;
        }
        if (level flag::get("doa_game_is_over")) {
            continue;
        }
        level function_3238133b("zombietron_extra_life");
    }
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0xe421a86e, Offset: 0x4678
// Size: 0x42
function function_c129719a(type) {
    switch (type) {
    case 1:
    case 5:
    case 8:
    case 10:
    case 12:
        return true;
    }
    return false;
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0x618e324d, Offset: 0x46c8
// Size: 0x254
function function_967df2b6(pickupdef) {
    if (!mayspawnentity()) {
        return 0;
    }
    if (level.doa.round_number < pickupdef.var_dea19cf0) {
        return 0;
    }
    if (randomint(100) > pickupdef.chance) {
        return 0;
    }
    if (pickupdef.type == 29) {
        if (zombie_vortex::get_active_vortex_count() > 0) {
            return 0;
        }
    }
    if (pickupdef.type == 7 || pickupdef.type == 19 || pickupdef.type == 6 || pickupdef.type == 34) {
        foreach (player in doa_player_utility::function_5eb6e4d1()) {
            if (isdefined(player.doa.var_5a34cdc9)) {
                return 0;
            }
            if (isdefined(player.doa.var_39c1b814)) {
                return 0;
            }
            if (isdefined(player.doa.var_7f0b4e60)) {
                return 0;
            }
            if (isdefined(player.doa.var_bfb9be95)) {
                return 0;
            }
        }
    }
    if (pickupdef.type == 24 || pickupdef.type == 9 || pickupdef.type == 25 || pickupdef.type == 33) {
        if (isdefined(level.doa.margwa)) {
            return 0;
        }
        foreach (player in doa_player_utility::function_5eb6e4d1()) {
            if (isdefined(player.doa.vehicle)) {
                return 0;
            }
        }
    }
    if (pickupdef.type == 3) {
        return doa_turret::canspawnturret();
    }
    return 1;
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0xa18ade5, Offset: 0x4928
// Size: 0xb8d
function function_d526f0bb() {
    self notify(#"hash_d526f0bb");
    self endon(#"hash_d526f0bb");
    self endon(#"death");
    wait 0.4;
    while (true) {
        self.trigger waittill(#"trigger", player);
        if (isdefined(self.player) && self.player != player) {
            continue;
        }
        if (player.team == "axis") {
            continue;
        }
        if (isvehicle(player) && isdefined(player.owner) && isplayer(player.owner) && !(isdefined(player.autonomous) && player.autonomous)) {
            player = player.owner;
        }
        if (!isplayer(player)) {
            continue;
        }
        if (isdefined(self.def.var_d1c98aa0)) {
            self thread namespace_eaa992c::function_285a2999(self.def.var_d1c98aa0);
        }
        var_9aec68f5 = 1;
        if (isdefined(player) && isdefined(player.doa)) {
            if (!isdefined(self.player) && isdefined(player.doa.vehicle) && !function_c129719a(self.type)) {
                wait 0.5;
                continue;
            }
            switch (self.type) {
            case 32:
                assert(isdefined(self.var_25ffdef1), "<dev string:x4a>");
                player thread globallogic_score::incpersstat("skulls", 1, 1, 1);
                player.skulls++;
                self thread namespace_1a381543::function_90118d8c("zmb_pickup_nurgle");
                player doa_player_utility::function_71dab8e8(self.var_25ffdef1);
                self function_6b4a5f81(player);
                break;
            case 1:
                if (isdefined(self.def.uber) && self.def.uber) {
                    player thread globallogic_score::incpersstat("gems", 1, 1, 1);
                    player.gems++;
                }
                self thread namespace_1a381543::function_90118d8c("zmb_pickup_money");
                player thread namespace_64c6b720::function_850bb47e(isdefined(self.var_5d2140f2) ? self.var_5d2140f2 : level.doa.rules.var_a9114441);
                player thread namespace_64c6b720::function_80eb303(self.score);
                self function_6b4a5f81(player);
                break;
            case 16:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_weapon");
                player doa_player_utility::function_d5f89a15(self.def.var_bcc88c39, 1);
                player.special_weapon = getweapon(self.def.var_bcc88c39);
                assert(isdefined(player.special_weapon));
                break;
            case 10:
                self thread namespace_1a381543::function_90118d8c("zmb_pickup_powerup");
                player thread doa_player_utility::function_f3748dcb();
                self function_6b4a5f81(player);
                break;
            case 12:
                self thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                player thread doa_player_utility::function_ba145a39();
                self function_6b4a5f81(player);
                break;
            case 8:
                if (!isdefined(self.player)) {
                    foreach (guy in doa_player_utility::function_5eb6e4d1()) {
                        guy doa_player_utility::function_6a52a347();
                    }
                } else {
                    player thread doa_player_utility::function_6a52a347();
                }
                self thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                self function_6b4a5f81(player);
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_life");
                break;
            case 4:
                player thread doa_player_utility::function_832d21c2();
                break;
            case 2:
                player.doa.var_c2b9d7d0 = gettime() + int(player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_c05a9a3f) * 1000);
                player doa_player_utility::function_71dab8e8(int(getdvarint("scr_doa_weapon_increment_range", 1024) / getdvarint("scr_doa_weapon_increment", 64)) - 1);
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_ammo");
                player thread function_322262ea();
                break;
            case 5:
                player thread globallogic_score::incpersstat("chickens", 1, 1, 1);
                player.chickens++;
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_chicken");
                player namespace_5e6c5d1f::function_d35a405a();
                break;
            case 11:
                level thread namespace_4f1562f7::monkeyUpdate(player, self.origin);
                break;
            case 29:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_vortex");
                level thread namespace_4f1562f7::function_d171e15a(player, self.origin);
                break;
            case 17:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_umbrella");
                self thread function_68c8220(player);
                break;
            case 7:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                player thread namespace_6df66aa5::barrelupdate();
                break;
            case 13:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                player thread namespace_6df66aa5::function_affe0c28();
                break;
            case 3:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                level thread doa_turret::function_eabe8c0(player);
                break;
            case 18:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                level thread doa_turret::function_eabe8c0(player, 1);
                break;
            case 6:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                player thread namespace_3f3eaecb::tesla_blockers_update();
                break;
            case 21:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                player thread namespace_6df66aa5::magnet_update();
                break;
            case 28:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                level notify(#"hash_bbc7bdf9", player);
                break;
            case 19:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                player thread namespace_6df66aa5::sawbladeupdate();
                break;
            case 20:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                level thread doa_turret::function_3ce8bf1c(player, self.origin);
                break;
            case 22:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                level thread doa_turret::amwsPickupUpdate(player, self.origin + (0, 0, 20));
                break;
            case 14:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                level thread namespace_4f1562f7::timeshifterupdate(player, self.origin);
                break;
            case 24:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                level thread namespace_2848f8c2::function_21af9396(player, self.origin + (0, 0, 20));
                break;
            case 9:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                level thread namespace_2848f8c2::function_f27a22c8(player, self.origin + (0, 0, 50));
                break;
            case 25:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                level thread namespace_2848f8c2::function_1e663abe(player, self.origin + (0, 0, 20));
                break;
            case 33:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                level thread namespace_2848f8c2::function_e9f445ce(player, self.origin + (0, 0, 20));
                break;
            case 34:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                player thread namespace_6df66aa5::boxingPickupUpdate();
                break;
            case 30:
            case 31:
                player thread namespace_1a381543::function_90118d8c("zmb_pickup_generic");
                level thread function_411355c0(self.type, player, player.origin);
                break;
            case 26:
                self stoploopsound();
                player thread namespace_1a381543::function_90118d8c("zmb_heart_pickup");
                level thread function_fce74a5f(self);
                break;
            case 15:
                namespace_49107f3a::debugmsg("pickup is not yet implemented");
                break;
            default:
                assert(0);
                break;
            }
            if (isdefined(var_9aec68f5) && var_9aec68f5 && isdefined(self)) {
                self notify(#"picked_up");
                if (isdefined(self.trigger)) {
                    self.trigger delete();
                    self.trigger = undefined;
                }
                self hide();
                wait 0.2;
                self delete();
            }
        }
    }
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0xa631821c, Offset: 0x54c0
// Size: 0x17a
function function_6b4a5f81(player) {
    self endon(#"death");
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
        if (player.entnum == 0) {
        } else if (player.entnum == 1) {
            y = 0 - y;
        } else if (player.entnum == 2) {
            x = 0 - x;
        } else if (player.entnum == 3) {
            y = 0 - y;
            x = 0 - x;
        }
        var_70adda17 += (x, y, z);
    } else {
        var_70adda17 = self.origin + (0, 0, 3000);
    }
    self notify(#"picked_up");
    wait 0.05;
    if (isdefined(self)) {
        self moveto(var_70adda17, 2, 0, 0);
        wait 2;
    }
    self notify(#"hash_71045b65");
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    self delete();
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0x8a0dfae1, Offset: 0x5648
// Size: 0x12
function pickupwobble() {
    self thread function_ee036ce4();
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0xa3034cf3, Offset: 0x5668
// Size: 0xfd
function function_ee036ce4() {
    self notify(#"hash_b14b3cac");
    self endon(#"hash_b14b3cac");
    self endon(#"death");
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
// Params 0, eflags: 0x0
// Checksum 0xb5748d22, Offset: 0x5770
// Size: 0x89
function pickuprotate() {
    self endon(#"death");
    self endon(#"delete");
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
// Params 0, eflags: 0x0
// Checksum 0x3c10ccb4, Offset: 0x5808
// Size: 0x182
function pickuptimeout() {
    self endon(#"death");
    timetowait = isdefined(self.timeout) ? self.timeout : level.doa.rules.powerup_timeout;
    wait timetowait + randomfloatrange(0, 5);
    for (i = 0; i < 40; i++) {
        if (!isdefined(self)) {
            break;
        }
        if (isdefined(self.var_71bbb00a)) {
            [[ self.var_71bbb00a ]](i % 2);
        } else if (i % 2) {
            self hide();
        } else {
            self show();
        }
        if (i < 15) {
            wait 0.5;
            util::wait_network_frame();
            continue;
        }
        if (i < 25) {
            wait 0.25;
            util::wait_network_frame();
            continue;
        }
        wait 0.1;
        util::wait_network_frame();
    }
    self notify(#"pickup_timeout");
    wait 0.1;
    if (isdefined(self) && !(isdefined(self.var_b2290d2d) && self.var_b2290d2d)) {
        if (isdefined(self.trigger)) {
            self.trigger delete();
        }
        self delete();
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0x8433ce69, Offset: 0x5998
// Size: 0xbb
function function_c1869ec8() {
    level notify(#"hash_8c5b31c5");
    util::wait_network_frame();
    var_6792dc08 = getentarray("a_pickup_item", "script_noteworthy");
    for (i = 0; i < var_6792dc08.size; i++) {
        pickup = var_6792dc08[i];
        if (isdefined(pickup)) {
            if (isdefined(pickup.trigger)) {
                pickup.trigger delete();
            }
            pickup delete();
        }
    }
    level notify(#"hash_229914a6");
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0xe7907525, Offset: 0x5a60
// Size: 0xfa
function function_80ed7f(var_cd2235d8) {
    self.trigger triggerenable(0);
    if (!isdefined(var_cd2235d8)) {
        target_point = self.origin + (randomfloatrange(-4, 4), randomfloatrange(-4, 4), 20);
    } else {
        target_point = self.origin + var_cd2235d8;
    }
    vel = target_point - self.origin;
    self.origin = self.origin + 4 * vel;
    vel *= randomfloatrange(0.5, 3);
    self physicslaunch(self.origin, vel);
    wait 1;
    if (isdefined(self) && isdefined(self.trigger)) {
        self.trigger triggerenable(1);
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0xab0123b7, Offset: 0x5b68
// Size: 0x6a
function function_9615d68f() {
    if (!isdefined(self.doa.var_a2d31b4a) || self.doa.var_a2d31b4a != self.doa.var_ca0a87c8.name) {
        self doa_player_utility::function_d5f89a15(self.doa.var_ca0a87c8.name);
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x4
// Checksum 0x2dd35635, Offset: 0x5be0
// Size: 0x33
function private function_972fe17c() {
    if (self.def.type == 23) {
        return false;
    }
    if (self.def.type == 32) {
        return false;
    }
    return true;
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x4
// Checksum 0xbf36ae88, Offset: 0x5c20
// Size: 0xfe
function private function_f56a2ab() {
    if (self.def.type == 32) {
        return true;
    }
    if (self.def.type == 5) {
        self thread namespace_5e6c5d1f::function_cdfa9ce8(self);
        self.angles = (0, 0, 0);
        return true;
    }
    if (self.def.type == 23 || self.def.type == 27) {
        self thread namespace_5e6c5d1f::function_7b8c015c();
        self.var_71bbb00a = &namespace_5e6c5d1f::function_d63bdb9;
        return true;
    }
    if (self.def.type == 26) {
        self clientfield::set("heartbeat", 1);
        self.var_71bbb00a = &function_2e7c9798;
        self hide();
        return true;
    }
    return false;
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x4
// Checksum 0x13c82828, Offset: 0x5d28
// Size: 0x2a7
function private function_5441452b(maxdistsq) {
    self notify(#"pickup_ForceAttractKill");
    self endon(#"pickup_ForceAttractKill");
    self endon(#"picked_up");
    self endon(#"death");
    while (true) {
        wait 0.05;
        if (self.attractors.size == 0) {
            if (self.origin[0] != self.var_18193c2a[0] || self.origin[1] != self.var_18193c2a[1]) {
                trace = bullettrace(self.origin, self.origin + (0, 0, -500), 0, undefined);
                self.groundpos = (self.origin[0], self.origin[1], trace["position"][2]) + (0, 0, 32);
                self moveto(self.groundpos, 1);
                self util::waittill_any_timeout(1.1, "movedone");
                self.var_18193c2a = self.origin;
            }
            continue;
        }
        forcemag = isdefined(self.forcemag) ? self.forcemag : 10;
        var_119472f5 = isdefined(maxdistsq) ? maxdistsq : level.doa.rules.var_eb81beeb;
        foreach (force in self.attractors) {
            if (!isdefined(force)) {
                continue;
            }
            distsq = distancesquared(self.origin, force.origin);
            if (distsq > var_119472f5) {
                continue;
            }
            if (isdefined(force.var_262e30aa)) {
                origin = force.origin + force.var_262e30aa;
            } else {
                origin = force.origin;
            }
            var_ad2b0f07 = vectornormalize(origin - self.origin);
            scale = (var_119472f5 - distsq) / var_119472f5;
            movevec = vectorscale(var_ad2b0f07, forcemag * scale);
            self.origin = self.origin + movevec;
        }
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0xa423bf00, Offset: 0x5fd8
// Size: 0x215
function function_b33393b3() {
    self notify(#"hash_c8c0fb8f");
    self endon(#"hash_c8c0fb8f");
    self endon(#"picked_up");
    self endon(#"death");
    self thread function_5441452b();
    if (isdefined(self.var_25e9e2fe)) {
        self [[ self.var_25e9e2fe ]]();
    }
    while (true) {
        self.attractors = [];
        if (isdefined(self.var_77ebedb)) {
            self [[ self.var_77ebedb ]]();
        }
        if (function_295872fa(self)) {
            foreach (player in doa_player_utility::function_5eb6e4d1()) {
                if (!isdefined(player.doa.var_3df27425)) {
                    continue;
                }
                distsq = distancesquared(player.origin, self.origin);
                if (distsq < level.doa.rules.var_eb81beeb) {
                    self.attractors[self.attractors.size] = player;
                }
            }
        }
        foreach (hazard in level.doa.var_7817fe3c) {
            if (!isdefined(hazard)) {
                continue;
            }
            if (isdefined(hazard.var_1a563349) && hazard.var_1a563349) {
                distsq = distancesquared(hazard.origin, self.origin);
                if (distsq < level.doa.rules.var_eb81beeb) {
                    self.attractors[self.attractors.size] = hazard;
                }
            }
        }
        wait 0.5;
    }
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0x3978abe6, Offset: 0x61f8
// Size: 0x7b
function function_295872fa(pickup) {
    if (isdefined(pickup.def.uber) && pickup.def.uber) {
        return false;
    }
    if (pickup.type == 1 || pickup.type == 10 || pickup.type == 12 || pickup.type == 32) {
        return true;
    }
    return false;
}

// Namespace namespace_a7e6beb5
// Params 3, eflags: 0x0
// Checksum 0x7b729114, Offset: 0x6280
// Size: 0x18a
function function_411355c0(type, player, origin) {
    foreach (guardian in level.doa.var_af875fb7) {
        if (guardian.type == type) {
            var_f3cefb9b = guardian;
            break;
        }
    }
    if (!isdefined(var_f3cefb9b)) {
        return;
    }
    loc = spawnstruct();
    loc.angles = player.angles;
    loc.origin = origin;
    ai = [[ var_f3cefb9b.spawnfunction ]](var_f3cefb9b.spawner, loc);
    if (isdefined(ai)) {
        ai.var_ccaea265 = &doa_enemy::function_d30fe558;
        ai notify(#"hash_6e8326fc");
        ai notify(#"hash_6dcbb83e");
        ai [[ var_f3cefb9b.initfunction ]](player);
        if (isdefined(player) && isdefined(ai)) {
            ai.fx = "player_trail_" + doa_player_utility::function_ee495f41(player.entnum);
            ai thread namespace_eaa992c::function_285a2999(ai.fx);
        }
    }
}

// Namespace namespace_a7e6beb5
// Params 1, eflags: 0x0
// Checksum 0x9ef25aa0, Offset: 0x6418
// Size: 0x222
function function_fce74a5f(var_740f8e9f) {
    zombies = arraycombine(getaispeciesarray("axis", "human"), arraycombine(getaispeciesarray("axis", "zombie"), getaispeciesarray("axis", "dog"), 0, 0), 0, 0);
    var_39339143 = 0;
    foreach (var_8ae1cd80 in zombies) {
        if (isdefined(var_8ae1cd80.boss) && var_8ae1cd80.boss) {
            continue;
        }
        if (!(isdefined(var_8ae1cd80.isdog) && var_8ae1cd80.isdog)) {
            var_8ae1cd80 namespace_fba031c8::function_45dffa6b((0, 0, 100));
            gibserverutils::gibhead(var_8ae1cd80);
            gibserverutils::giblegs(var_8ae1cd80);
            if (math::cointoss()) {
                gibserverutils::gibrightarm(var_8ae1cd80);
            } else {
                gibserverutils::gibleftarm(var_8ae1cd80);
            }
            assert(!(isdefined(var_8ae1cd80.boss) && var_8ae1cd80.boss));
            var_8ae1cd80 startragdoll();
        }
        var_8ae1cd80 thread namespace_49107f3a::function_ba30b321(0.25);
        var_39339143++;
        if (var_39339143 == 4) {
            var_39339143 = 0;
            wait 0.05;
        }
    }
    if (isdefined(var_740f8e9f)) {
        var_740f8e9f delete();
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0xda3e333c, Offset: 0x6648
// Size: 0x15a
function function_2e7c9798() {
    self endon(#"death");
    wait level.doa.rules.powerup_timeout + randomfloatrange(0, 5);
    self clientfield::set("heartbeat", 2);
    for (i = 0; i < 40; i++) {
        if (!isdefined(self)) {
            break;
        }
        if (i == 10) {
            self clientfield::set("heartbeat", 3);
        }
        if (i == 20) {
            self clientfield::set("heartbeat", 4);
        }
        if (i == 30) {
            self clientfield::set("heartbeat", 5);
        }
        if (i < 15) {
            wait 0.5;
        } else if (i < 25) {
            wait 0.25;
        } else {
            wait 0.1;
        }
        util::wait_network_frame();
    }
    self notify(#"pickup_timeout");
    wait 0.1;
    if (isdefined(self)) {
        if (isdefined(self.trigger)) {
            self.trigger delete();
        }
        self delete();
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0x2d37a43, Offset: 0x67b0
// Size: 0x31
function function_d0397bc7() {
    switch (self.type) {
    case 31:
        break;
    case 30:
        break;
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0x3a1bca21, Offset: 0x67f0
// Size: 0x152
function function_db3e0155() {
    self.var_25e9e2fe = &function_a40895ab;
    self.var_77ebedb = &function_b62ed8c1;
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    self.trigger = function_c5bc781(self.origin, 24);
    self.trigger enablelinkto();
    self.trigger linkto(self);
    self notify(#"hash_c8c0fb8f");
    self thread function_d526f0bb();
    self thread function_b33393b3();
    self.forcemag = 20;
    scale = randomfloatrange(0.5, 1.5);
    self.var_25ffdef1 = scale;
    self setscale(scale);
    self.angles = (randomint(360), randomint(360), randomint(360));
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0x6706635c, Offset: 0x6950
// Size: 0x32
function function_a40895ab() {
    self notify(#"pickup_ForceAttractKill");
    self thread function_5441452b(level.doa.rules.var_6a4387bb);
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0x84ecd9aa, Offset: 0x6990
// Size: 0xd7
function function_b62ed8c1() {
    self.attractors = [];
    foreach (player in doa_player_utility::function_5eb6e4d1()) {
        distsq = distancesquared(player.origin, self.origin);
        if (distsq < level.doa.rules.var_6a4387bb) {
            if (!isinarray(self.attractors, player)) {
                self.attractors[self.attractors.size] = player;
            }
        }
    }
}

// Namespace namespace_a7e6beb5
// Params 0, eflags: 0x0
// Checksum 0x210ada81, Offset: 0x6a70
// Size: 0x9a
function function_322262ea() {
    self notify(#"hash_322262ea");
    self endon(#"hash_322262ea");
    self endon(#"disconnect");
    if (!isdefined(self) || !isdefined(self.doa) || !isdefined(self.doa.var_c2b9d7d0)) {
        return;
    }
    self thread namespace_eaa992c::function_285a2999("ammo_infinite");
    while (isdefined(self) && self.doa.var_c2b9d7d0 > gettime()) {
        wait 0.25;
    }
    if (isdefined(self)) {
        self thread namespace_eaa992c::turnofffx("ammo_infinite");
    }
}

