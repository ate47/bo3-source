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
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace doa_pickups;

// Namespace doa_pickups
// Params 0
// Checksum 0x99ec1590, Offset: 0xdd8
// Size: 0x4
function precache()
{
    
}

// Namespace doa_pickups
// Params 0
// Checksum 0xfb626921, Offset: 0xde8
// Size: 0x16b4
function init()
{
    assert( isdefined( level.doa ) );
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
    level.doa.extra_life_model = "zombietron_extra_life";
    level.doa.var_3b704a85 = "veh_t7_drone_hunter_zombietron";
    level.doa.booster_model = "zombietron_lightning_bolt";
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
    level.doa.var_468af4f0 = "zombietron_egggold";
    level.doa.var_d17dd2a6 = "zombietron_eggxl";
    level.doa.var_e1df04b = "zombietron_siegebot_mini";
    level.doa.var_4de532b3 = "veh_t7_drone_raps_zombietron";
    level.doa.tank_model = "veh_t7_mil_tank_tiger_zombietron";
    level.doa.var_326cdb5e = "zombietron_bones_skeleton";
    level.doa.var_afa6d081 = "zombietron_heart";
    level.doa.var_ed2fb7a7 = "zombietron_vortex";
    level.doa.gloves = "zombietron_boxing_gloves_rt";
    level.doa.var_1eaa8907 = "zombietron_chicken_fido";
    level.doa.var_24fe9829 = "c_54i_robot_3";
    level.doa.var_9bf7e61b = "p7_doa_powerup_skull";
    level.doa.firstperson = "p7_bonuscard_perk_3_greed";
    level.doa.coat_of_arms = "p7_zm_ctl_dg_coat_horn";
    function_58268dbd( "zombietron_silver_coin", &function_9fc58738, 0, 25, 1.25, 0 );
    function_58268dbd( "zombietron_silver_coin", &function_9fc58738, 0, 25, 1.25, 0 );
    function_58268dbd( "zombietron_silver_coin", &function_9fc58738, 0, 25, 1.25, 0 );
    function_58268dbd( "zombietron_silver_brick", &function_9fc58738, 0, 75, 1.25, 1 );
    function_58268dbd( "zombietron_silver_brick", &function_9fc58738, 0, 75, 1.5, 1 );
    function_58268dbd( "zombietron_silver_bricks", &function_9fc58738, 0, 150, 1.5, 2 );
    function_58268dbd( "zombietron_gold_coin", &function_9fc58738, 0, 50, 1.25, 3 );
    function_58268dbd( "zombietron_gold_brick", &function_9fc58738, 0, 125, 1.5, 4 );
    function_58268dbd( "zombietron_gold_bricks", &function_9fc58738, 0, 250, 1.5, 5 );
    function_58268dbd( "zombietron_money_icon", &function_9fc58738, 0, 750, 1.5, 6 );
    function_58268dbd( "zombietron_ruby", &function_9fc58738, 1, 0, undefined, 7 );
    function_58268dbd( "zombietron_sapphire", &function_9fc58738, 1, 0, undefined, 8 );
    function_58268dbd( "zombietron_diamond", &function_9fc58738, 1, 0, undefined, 9 );
    function_58268dbd( "zombietron_emerald", &function_9fc58738, 1, 0, undefined, 10 );
    function_58268dbd( "zombietron_beryl", &function_9fc58738, 1, 0, undefined, 11 );
    function_58268dbd( "p7_doa_powerup_skull", &function_9fc58738, 1, 32, undefined, 12 );
    function_db1442f2( "zombietron_deathmachine", &itemspawn, 0, 1, 2.1, 100, 16, 0 );
    function_db1442f2( "zombietron_shotgun", &itemspawn, 0, 1, 3, 100, 16, 1 );
    function_db1442f2( "zombietron_launcher", &itemspawn, 0, 1, 2.4, 100, 16, 2 );
    function_db1442f2( "zombietron_rpg", &itemspawn, 0, 1, 2.4, 100, 16, 3 );
    function_db1442f2( "zombietron_ray_gun", &itemspawn, 0, 1, 3.5, 100, 16, 4 );
    function_db1442f2( "zombietron_flamethrower", &itemspawn, 0, 1, 2, 100, 16, 5 );
    function_db1442f2( "zombietron_deathmachine", &itemspawn, 0, 1, 2.1, 100, 16, 0 );
    function_db1442f2( "zombietron_shotgun", &itemspawn, 0, 1, 3, 100, 16, 1 );
    function_db1442f2( "zombietron_launcher", &itemspawn, 0, 1, 2.4, 100, 16, 2 );
    function_db1442f2( "zombietron_rpg", &itemspawn, 0, 1, 2.4, 100, 16, 3 );
    function_db1442f2( "zombietron_flamethrower", &itemspawn, 0, 1, 2, 100, 16, 5 );
    function_db1442f2( level.doa.var_bd919311, &itemspawn, 0, 1, 2, 100, 2 );
    function_db1442f2( level.doa.var_bd919311, &itemspawn, 0, 1, 2, 100, 2 );
    function_db1442f2( level.doa.var_bd919311, &itemspawn, 0, 1, 2, 100, 2 );
    function_db1442f2( level.doa.var_8d63e734, &itemspawn, 0, 1, 1, 100, 5, undefined, ( 0, 0, 0 ) );
    function_db1442f2( level.doa.var_8d63e734, &itemspawn, 0, 1, 1, 100, 5, undefined, ( 0, 0, 0 ) );
    function_db1442f2( level.doa.turret_model, &itemspawn, 0, 1, 0.75, 100, 3 );
    function_db1442f2( level.doa.var_f6947407, &itemspawn, 0, 1, 1, 100, 7 );
    function_db1442f2( level.doa.var_97bbae9c, &itemspawn, 0, 1, 2, 100, 19, undefined, ( 0, 0, 0 ) );
    function_db1442f2( level.doa.var_f21ae3af, &itemspawn, 0, 3, 0.5, 100, 17 );
    function_db1442f2( level.doa.firstperson, &itemspawn, 0, 3, 3, 100, 35, undefined, ( 0, 0, -70 ), undefined, &function_5c21c936, &function_76a2dd5c );
    function_db1442f2( level.doa.firstperson, &itemspawn, 0, 4, 3, 100, 35, undefined, ( 0, 0, -70 ), undefined, &function_5c21c936, &function_76a2dd5c );
    function_db1442f2( level.doa.var_f6e22ab8, &itemspawn, 0, 5, 1.5, 100, 6 );
    function_db1442f2( level.doa.var_f7277ad6, &itemspawn, 0, 5, 2, 100, 4 );
    function_db1442f2( level.doa.booster_model, &itemspawn, 0, 5, 1.5, 100, 10 );
    function_db1442f2( level.doa.booster_model, &itemspawn, 0, 5, 1.5, 100, 10 );
    function_db1442f2( level.doa.var_4de532b3, &itemspawn, 0, 5, 1, 50, 25 );
    function_db1442f2( level.doa.var_501f85b4, &itemspawn, 0, 5, 0.8, 100, 12 );
    function_db1442f2( level.doa.var_501f85b4, &itemspawn, 0, 5, 0.8, 100, 12 );
    function_db1442f2( level.doa.var_304b4b41, &itemspawn, 0, 9, 5.5, 100, 20 );
    function_db1442f2( level.doa.var_d6256e83, &itemspawn, 0, 9, 1, 100, 11 );
    function_db1442f2( level.doa.var_3481ab4d, &itemspawn, 0, 9, 3, 100, 21 );
    function_db1442f2( level.doa.var_7f53bb28, &itemspawn, 0, 9, 1.6, 25, 13 );
    function_db1442f2( level.doa.tank_model, &itemspawn, 0, 10, 1, 100, 33 );
    function_db1442f2( level.doa.gloves, &itemspawn, 0, 10, 1, 100, 34 );
    function_db1442f2( level.doa.var_43922ff2, &itemspawn, 0, 13, 1, 25, 23 );
    function_db1442f2( level.doa.var_27f4032b, &itemspawn, 0, 13, 1, 100, 14 );
    function_db1442f2( level.doa.var_b851a0fc, &itemspawn, 0, 17, 1, 100, 18 );
    function_db1442f2( level.doa.var_326cdb5e, &itemspawn, 0, 17, 1.4, 50, 30, undefined, ( 20, 0, 0 ), undefined, &function_d0397bc7 );
    function_db1442f2( level.doa.var_4aa90d77, &itemspawn, 0, 21, 1, 100, 22 );
    function_db1442f2( level.doa.var_ed2fb7a7, &itemspawn, 0, 22, 0.5, 100, 29 );
    function_db1442f2( level.doa.var_afa6d081, &itemspawn, 0, 23, 1, 100, 26 );
    function_db1442f2( level.doa.coat_of_arms, &itemspawn, 0, 24, 3, 25, 37, undefined, ( 0, 0, 75 ) );
    function_db1442f2( level.doa.var_e1df04b, &itemspawn, 0, 25, 0.7, 25, 24 );
    function_db1442f2( level.doa.var_24fe9829, &itemspawn, 0, 26, 1, 50, 31, undefined, ( 20, 0, 0 ), undefined, &function_d0397bc7 );
    function_db1442f2( level.doa.var_3b704a85, &itemspawn, 0, 30, 1, 25, 9 );
    function_db1442f2( level.doa.var_468af4f0, &itemspawn, 0, 60, 1, 5, 36 );
    function_db1442f2( level.doa.var_1eaa8907, &itemspawn, 0, 65, 1, 100, 38, undefined, undefined, undefined, undefined, &function_644e08c5 );
    function_db1442f2( level.doa.extra_life_model, &itemspawn, 0, 999999, 1, 100, 8 );
    function_db1442f2( level.doa.var_d17dd2a6, &itemspawn, 0, 999999, 1, 100, 27 );
    function_db1442f2( level.doa.var_9bf7e61b, &itemspawn, 0, 999999, 1, 100, 32, undefined, ( 70, 0, 0 ), 5, &function_db3e0155 );
    level thread function_2904bdc4();
    level thread function_bfc8e78d();
    level thread function_5bb8e0d1();
    level thread function_b8d3f901();
}

// Namespace doa_pickups
// Params 6
// Checksum 0xb43eb30f, Offset: 0x24a8
// Size: 0x1a6
function function_58268dbd( gdtname, var_74f5c76, uber, data, modelscale, variant )
{
    if ( !isdefined( uber ) )
    {
        uber = 0;
    }
    
    if ( !isdefined( data ) )
    {
        data = 0;
    }
    
    if ( !isdefined( modelscale ) )
    {
        modelscale = 1;
    }
    
    pickup = spawnstruct();
    pickup.gdtname = gdtname;
    pickup.var_74f5c76 = var_74f5c76;
    pickup.uber = uber;
    pickup.data = data;
    pickup.count = 0;
    pickup.scale = modelscale;
    pickup.variant = variant;
    pickup.type = 1;
    
    if ( uber )
    {
        level.doa.pickups.var_3e3b7a53[ level.doa.pickups.var_3e3b7a53.size ] = pickup;
        return;
    }
    
    level.doa.pickups.money[ level.doa.pickups.money.size ] = pickup;
}

// Namespace doa_pickups
// Params 12
// Checksum 0xdaeaa904, Offset: 0x2658
// Size: 0x20e
function function_db1442f2( gdtname, var_74f5c76, unique, minlevel, modelscale, chance, type, data, angles, timeout, var_9b759e09, var_cffa7dd1 )
{
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 70 );
    }
    
    pickup = spawnstruct();
    pickup.gdtname = gdtname;
    pickup.var_74f5c76 = var_74f5c76;
    pickup.unqiue = unique;
    pickup.count = 0;
    pickup.var_dea19cf0 = minlevel;
    pickup.scale = modelscale;
    pickup.chance = chance;
    pickup.angles = angles;
    pickup.type = type;
    pickup.data = data;
    pickup.timeout = timeout;
    pickup.var_329373ec = var_9b759e09;
    pickup.var_cee3d90d = type == 16 ? "glow_red" : "glow_item";
    
    if ( isdefined( var_cffa7dd1 ) )
    {
        [[ var_cffa7dd1 ]]( pickup );
    }
    
    level.doa.pickups.items[ level.doa.pickups.items.size ] = pickup;
}

// Namespace doa_pickups
// Params 3
// Checksum 0x8c0c183f, Offset: 0x2870
// Size: 0x82
function function_c5bc781( origin, width, height )
{
    if ( !isdefined( width ) )
    {
        width = 42;
    }
    
    if ( !isdefined( height ) )
    {
        height = 130;
    }
    
    if ( !mayspawnfakeentity() )
    {
        return;
    }
    
    return spawn( "trigger_radius", origin, 18, width, height );
}

// Namespace doa_pickups
// Params 8
// Checksum 0xe41a522d, Offset: 0x2900
// Size: 0xaf0
function function_9fc58738( var_742d8fb5, origin, launch, ondeath, var_b0d7c311, timeout, wobble, glow )
{
    if ( !isdefined( launch ) )
    {
        launch = 0;
    }
    
    if ( !isdefined( ondeath ) )
    {
        ondeath = 0;
    }
    
    if ( !isdefined( timeout ) )
    {
        timeout = 1;
    }
    
    if ( !isdefined( wobble ) )
    {
        wobble = 1;
    }
    
    if ( !isdefined( glow ) )
    {
        glow = 1;
    }
    
    if ( !mayspawnentity() )
    {
        return;
    }
    
    pickup = spawn( "script_model", origin );
    pickup.targetname = "pickup";
    pickup.var_18193c2a = origin;
    pickup.type = 1;
    pickup.def = var_742d8fb5;
    pickup.script_noteworthy = "a_pickup_item";
    pickup.angles = ( 0, randomint( 360 ), 0 );
    
    if ( getdvarint( "scr_doa_client_side_pickup_models", 1 ) && !launch )
    {
        pickup clientfield::set( "pickuptype", pickup.type + ( pickup.def.variant << 6 ) );
        pickup setmodel( "tag_origin" );
        pickup.var_52cf38a3 = 1;
    }
    else
    {
        pickup setmodel( var_742d8fb5.gdtname );
    }
    
    pickup notsolid();
    pickup.trigger = function_c5bc781( origin );
    
    if ( !isdefined( pickup.trigger ) )
    {
        pickup delete();
        return;
    }
    
    pickup.trigger.targetname = "pickupTrigger";
    pickup.trigger enablelinkto();
    pickup.trigger linkto( pickup );
    pickup.score = pickup.def.data;
    pickup.def.count++;
    pickup thread doa_sound::function_90118d8c( "zmb_spawn_pickup_money" );
    
    if ( level.doa.arena_round_number == 3 )
    {
        pickup setnosunshadow();
    }
    
    pickup thread function_d526f0bb();
    pickup thread function_b33393b3();
    
    if ( isdefined( timeout ) && timeout )
    {
        pickup thread pickuptimeout();
    }
    
    if ( !launch )
    {
        if ( isdefined( wobble ) && wobble )
        {
            pickup thread pickupwobble();
        }
    }
    else
    {
        pickup thread function_80ed7f();
    }
    
    if ( function_274c7b5( pickup ) == 0 )
    {
        pickup notify( #"pickup_ForceAttractKill" );
        pickup notify( #"hash_c8c0fb8f" );
    }
    
    if ( pickup.def.uber )
    {
        if ( pickup.def.data == 32 )
        {
            pickup.type = 32;
            
            if ( randomint( getdvarint( "scr_doa_epic_nurgle_per_count", 25 ) ) == 0 )
            {
                scale = 7;
                increment = 48;
            }
            else if ( randomint( getdvarint( "scr_doa_big_nurgle_per_count", 10 ) ) == 0 )
            {
                scale = 5;
                increment = 28;
            }
            else
            {
                scale = 3;
                increment = 18;
            }
            
            pickup.var_25ffdef1 = increment;
            pickup thread pickupscale( scale );
            return pickup;
        }
        
        quarterbar = level.doa.rules.var_d55e6679 / 4;
        
        if ( ondeath )
        {
            pickup.score = 0;
            barpoints = quarterbar;
            scale = 1;
        }
        else if ( isdefined( var_b0d7c311 ) )
        {
            barpoints = var_b0d7c311 * quarterbar;
            scale = var_b0d7c311;
        }
        else
        {
            barpoints = quarterbar;
            scale = 1;
            roll = randomint( 100 );
            inc = 0;
            
            if ( roll > 80 )
            {
                inc += quarterbar;
            }
            
            if ( roll > 90 )
            {
                inc += quarterbar;
            }
            
            if ( roll > 95 )
            {
                inc += quarterbar;
            }
            
            if ( roll > 98 )
            {
                inc += quarterbar;
            }
            
            barpoints += randomfloat( inc );
            scale += barpoints / quarterbar;
        }
        
        pickup thread pickupscale( scale );
        pickup.var_5d2140f2 = int( barpoints );
        
        if ( !isdefined( var_742d8fb5.var_cee3d90d ) )
        {
            if ( issubstr( var_742d8fb5.gdtname, "emerald" ) )
            {
                var_742d8fb5.var_cee3d90d = "glow_green";
                var_742d8fb5.var_d1c98aa0 = "gem_trail_green";
            }
            else if ( issubstr( var_742d8fb5.gdtname, "ruby" ) )
            {
                var_742d8fb5.var_cee3d90d = "glow_red";
                var_742d8fb5.var_d1c98aa0 = "gem_trail_red";
            }
            else if ( issubstr( var_742d8fb5.gdtname, "sapphire" ) )
            {
                var_742d8fb5.var_cee3d90d = "glow_blue";
                var_742d8fb5.var_d1c98aa0 = "gem_trail_blue";
            }
            else if ( issubstr( var_742d8fb5.gdtname, "beryl" ) )
            {
                var_742d8fb5.var_cee3d90d = "glow_yellow";
                var_742d8fb5.var_d1c98aa0 = "gem_trail_yellow";
            }
            else
            {
                var_742d8fb5.var_cee3d90d = "glow_white";
                var_742d8fb5.var_d1c98aa0 = "gem_trail_white";
            }
        }
    }
    else
    {
        scale = var_742d8fb5.scale + randomfloatrange( 0, 0.3 );
        pickup thread pickupscale( scale );
        
        if ( !isdefined( var_742d8fb5.var_cee3d90d ) )
        {
            if ( issubstr( var_742d8fb5.gdtname, "gold" ) )
            {
                chance = level.doa.arena_round_number == 3 ? 40 : 0;
                
                if ( chance && randomint( 100 ) < chance )
                {
                    var_742d8fb5.var_cee3d90d = "glow_yellow";
                }
                else
                {
                    var_742d8fb5.var_cee3d90d = "sparkle_gold";
                }
            }
            
            if ( issubstr( var_742d8fb5.gdtname, "silver" ) )
            {
                chance = level.doa.arena_round_number == 3 ? 40 : 0;
                
                if ( chance && randomint( 100 ) < chance )
                {
                    var_742d8fb5.var_cee3d90d = "glow_white";
                }
                else
                {
                    var_742d8fb5.var_cee3d90d = "sparkle_silver";
                }
            }
        }
    }
    
    if ( isdefined( var_742d8fb5.var_cee3d90d ) && glow )
    {
        pickup thread doa_fx::function_285a2999( var_742d8fb5.var_cee3d90d );
    }
    
    return pickup;
}

// Namespace doa_pickups
// Params 5
// Checksum 0x50e01dff, Offset: 0x33f8
// Size: 0x654
function itemspawn( var_742d8fb5, location, timeout, rotate, angles )
{
    if ( !isdefined( timeout ) )
    {
        timeout = 1;
    }
    
    if ( !isdefined( rotate ) )
    {
        rotate = 1;
    }
    
    if ( !mayspawnentity() )
    {
        return;
    }
    
    pickup = spawn( "script_model", location );
    
    if ( !isdefined( pickup ) )
    {
        return;
    }
    
    pickup endon( #"death" );
    pickup.targetname = "pickup_item";
    pickup.var_18193c2a = location;
    pickup.def = var_742d8fb5;
    pickup.type = pickup.def.type;
    pickup.angles = isdefined( angles ) ? angles : pickup.def.angles;
    pickup.script_noteworthy = "a_pickup_item";
    pickup.timeout = pickup.def.timeout;
    
    if ( getdvarint( "scr_doa_client_side_pickup_models", 1 ) && !function_fd16eeab( pickup.type ) )
    {
        if ( pickup.type == 16 )
        {
            variant = var_742d8fb5.data;
        }
        else
        {
            variant = 0;
        }
        
        pickup clientfield::set( "pickuptype", pickup.type + ( variant << 6 ) );
        pickup setmodel( "tag_origin" );
        pickup.var_52cf38a3 = 1;
    }
    else if ( pickup.type == 16 )
    {
        weaponmodel = getweaponworldmodel( getweapon( var_742d8fb5.gdtname ) );
        pickup setmodel( weaponmodel );
    }
    else
    {
        pickup setmodel( var_742d8fb5.gdtname );
    }
    
    if ( level.doa.arena_round_number == 3 )
    {
        pickup setnosunshadow();
    }
    
    pickup thread doa_sound::function_90118d8c( "zmb_pickup_spawn" );
    
    if ( isdefined( pickup.type ) && pickup.type == 26 )
    {
        pickup playloopsound( "zmb_heart_lp", 2 );
    }
    else if ( pickup.type != 1 || isdefined( pickup.type ) && pickup.type != 32 )
    {
        pickup playloopsound( "zmb_pickup_powerup_shimmer", 2 );
    }
    
    pickup thread function_b33393b3();
    
    if ( pickup function_972fe17c() )
    {
        pickup.trigger = function_c5bc781( pickup.origin );
        
        if ( !isdefined( pickup.trigger ) )
        {
            pickup delete();
            return;
        }
        
        pickup.trigger enablelinkto();
        pickup.trigger linkto( pickup );
        pickup thread function_d526f0bb();
    }
    
    pickup.def.count++;
    pickup thread pickupscale( var_742d8fb5.scale );
    
    if ( function_bbb6019d( pickup ) )
    {
        pickup notsolid();
    }
    
    if ( function_274c7b5( pickup ) == 0 )
    {
        pickup notify( #"pickup_ForceAttractKill" );
        pickup notify( #"hash_c8c0fb8f" );
    }
    
    pickup thread doa_fx::function_285a2999( function_c41cf2a8( pickup ) );
    
    if ( timeout )
    {
        pickup thread pickuptimeout();
    }
    
    if ( pickup function_f56a2ab() == 0 && rotate )
    {
        pickup thread pickuprotate();
    }
    
    if ( isdefined( pickup.def.var_329373ec ) )
    {
        pickup [[ pickup.def.var_329373ec ]]();
    }
    
    return pickup;
}

// Namespace doa_pickups
// Params 1
// Checksum 0xa1305b81, Offset: 0x3a58
// Size: 0xb6
function function_c41cf2a8( pickup )
{
    if ( pickup.def.type == 23 )
    {
        return undefined;
    }
    
    if ( pickup.def.type == 36 )
    {
        return "glow_yellow";
    }
    
    if ( pickup.def.type == 32 )
    {
        return undefined;
    }
    
    if ( isdefined( pickup.def.var_cee3d90d ) )
    {
        return pickup.def.var_cee3d90d;
    }
    
    return "glow_item";
}

// Namespace doa_pickups
// Params 1
// Checksum 0x5d283b5b, Offset: 0x3b18
// Size: 0x54, Type: bool
function function_bbb6019d( pickup )
{
    if ( pickup.def.type == 23 || pickup.def.type == 36 )
    {
        return false;
    }
    
    return true;
}

// Namespace doa_pickups
// Params 1
// Checksum 0xc1e28f55, Offset: 0x3b78
// Size: 0xce, Type: bool
function function_274c7b5( pickup )
{
    if ( pickup.def.type == 1 )
    {
        return true;
    }
    
    if ( pickup.def.type == 23 || pickup.def.type == 36 )
    {
        return false;
    }
    
    if ( pickup.type == 5 )
    {
        return false;
    }
    
    if ( isdefined( pickup.def.uber ) && pickup.def.uber )
    {
        return false;
    }
    
    return true;
}

// Namespace doa_pickups
// Params 1
// Checksum 0x29ba8554, Offset: 0x3c50
// Size: 0x11c
function function_90d1a97d( name )
{
    for ( i = 0; i < level.doa.pickups.var_3e3b7a53.size ; i++ )
    {
        if ( level.doa.pickups.var_3e3b7a53[ i ].gdtname == name )
        {
            return level.doa.pickups.var_3e3b7a53[ i ];
        }
    }
    
    for ( i = 0; i < level.doa.pickups.money.size ; i++ )
    {
        if ( level.doa.pickups.money[ i ].gdtname == name )
        {
            return level.doa.pickups.money[ i ];
        }
    }
}

// Namespace doa_pickups
// Params 10
// Checksum 0x95c447ad, Offset: 0x3d78
// Size: 0x31e
function function_2d8cb175( name, origin, amount, launch, ondeath, scale, timeout, wobble, radius, glow )
{
    if ( !isdefined( amount ) )
    {
        amount = 1;
    }
    
    if ( !isdefined( launch ) )
    {
        launch = 0;
    }
    
    if ( !isdefined( ondeath ) )
    {
        ondeath = 0;
    }
    
    if ( !isdefined( timeout ) )
    {
        timeout = 1;
    }
    
    if ( !isdefined( wobble ) )
    {
        wobble = 1;
    }
    
    if ( !isdefined( radius ) )
    {
        radius = 1;
    }
    
    if ( !isdefined( glow ) )
    {
        glow = 1;
    }
    
    pickup = function_90d1a97d( name );
    items = [];
    
    if ( !isdefined( pickup ) )
    {
        return items;
    }
    
    for ( i = 0; i < amount ; i++ )
    {
        if ( !isdefined( origin ) )
        {
            spot = function_ac410a13();
            
            if ( !isdefined( spot ) )
            {
                continue;
            }
            
            if ( isdefined( spot.radius ) )
            {
                radius = spot.radius;
            }
            else
            {
                radius = 120;
            }
            
            origin = spot.origin + ( randomintrange( radius * -1, radius ), randomintrange( radius * -1, radius ), 32 );
            items[ items.size ] = [[ pickup.var_74f5c76 ]]( pickup, origin, launch, ondeath, scale, timeout, wobble, glow );
            origin = undefined;
            continue;
        }
        
        spot = origin;
        
        if ( isdefined( radius ) )
        {
            spot = origin + ( randomintrange( radius * -1, radius ), randomintrange( radius * -1, radius ), 32 );
        }
        
        item = [[ pickup.var_74f5c76 ]]( pickup, origin, launch, ondeath, scale, timeout, wobble, glow );
        
        if ( isdefined( item ) )
        {
            items[ items.size ] = item;
        }
    }
    
    return items;
}

// Namespace doa_pickups
// Params 11
// Checksum 0xe1c5bd7a, Offset: 0x40a0
// Size: 0x30e
function spawnubertreasure( spawn_point, amount, radius, launch, ondeath, scale, specific, interval, shouldtimeout, var_71b8054b, var_5278d8d7 )
{
    if ( !isdefined( radius ) )
    {
        radius = 85;
    }
    
    if ( !isdefined( launch ) )
    {
        launch = 0;
    }
    
    if ( !isdefined( ondeath ) )
    {
        ondeath = 0;
    }
    
    if ( !isdefined( interval ) )
    {
        interval = 0.35;
    }
    
    if ( !isdefined( shouldtimeout ) )
    {
        shouldtimeout = 1;
    }
    
    if ( !isdefined( var_71b8054b ) )
    {
        var_71b8054b = 1;
    }
    
    if ( !isdefined( var_5278d8d7 ) )
    {
        var_5278d8d7 = 1;
    }
    
    level endon( #"stop_spawning_pickups" );
    items = [];
    
    while ( amount )
    {
        amount--;
        
        if ( radius )
        {
            origin = spawn_point + ( randomintrange( 0 - radius, radius ), randomintrange( 0 - radius, radius ), 24 );
        }
        else
        {
            origin = spawn_point;
        }
        
        if ( isdefined( specific ) )
        {
            foreach ( treasure in level.doa.pickups.var_3e3b7a53 )
            {
                if ( treasure.gdtname == specific )
                {
                    var_4f0bcadb = treasure;
                    break;
                }
            }
        }
        else
        {
            var_4f0bcadb = level.doa.pickups.var_3e3b7a53[ randomint( level.doa.pickups.var_3e3b7a53.size ) ];
        }
        
        if ( isdefined( var_4f0bcadb ) )
        {
            item = [[ var_4f0bcadb.var_74f5c76 ]]( var_4f0bcadb, origin, launch, ondeath, scale, shouldtimeout, var_71b8054b, var_5278d8d7 );
            
            if ( isdefined( item ) )
            {
                items[ items.size ] = item;
            }
        }
        
        if ( amount > 0 && interval > 0 )
        {
            wait interval;
        }
    }
    
    return items;
}

// Namespace doa_pickups
// Params 3
// Checksum 0xb7789007, Offset: 0x43b8
// Size: 0x1be
function function_e904e32d( spawn_point, amount, radius )
{
    if ( !isdefined( radius ) )
    {
        radius = 85;
    }
    
    level endon( #"stop_spawning_pickups" );
    
    for ( i = 0; i < amount ; i++ )
    {
        origin = spawn_point + ( randomintrange( 0 - radius, radius ), randomintrange( 0 - radius, radius ), 24 );
        
        if ( randomfloat( getdvarint( "scr_doa_uber_price_chance", 1000 ) ) == 0 )
        {
            var_4f0bcadb = level.doa.pickups.var_3e3b7a53[ randomint( level.doa.pickups.var_3e3b7a53.size ) ];
        }
        else
        {
            var_4f0bcadb = level.doa.pickups.money[ randomint( level.doa.pickups.money.size ) ];
        }
        
        [[ var_4f0bcadb.var_74f5c76 ]]( var_4f0bcadb, origin );
        util::wait_network_frame();
    }
}

// Namespace doa_pickups
// Params 1
// Checksum 0xc5ca9735, Offset: 0x4580
// Size: 0x1b4
function function_68c8220( player )
{
    ent = spawn( "script_origin", ( 0, 0, 0 ) );
    ent playloopsound( "zmb_pickup_umbrella_loop" );
    locations = doa_utility::function_308fa126( 16 );
    amount = randomintrange( doa_player_utility::function_5eb6e4d1().size * 3 + 4, doa_player_utility::function_5eb6e4d1().size * 5 + 6 );
    
    while ( amount )
    {
        item = spawnubertreasure( locations[ randomint( locations.size ) ] + ( 0, 0, 2200 ), 1, 128, 1, 1, 1, level.doa.var_9bf7e61b, undefined, 1, 0, 0 )[ 0 ];
        
        if ( isdefined( item ) )
        {
            item thread function_80ed7f( ( 0, 0, 1 ) );
        }
        
        amount--;
        wait randomintrange( 1, 3 );
    }
    
    ent delete();
}

// Namespace doa_pickups
// Params 0
// Checksum 0x844b642a, Offset: 0x4740
// Size: 0x4e
function function_ac410a13()
{
    if ( level.doa.var_3361a074.size )
    {
        return level.doa.var_3361a074[ randomint( level.doa.var_3361a074.size ) ];
    }
}

// Namespace doa_pickups
// Params 0, eflags: 0x4
// Checksum 0x6130a89b, Offset: 0x4798
// Size: 0x11a
function private function_c41b5928()
{
    if ( isdefined( level.doa.var_2d09b979 ) && level.doa.var_2d09b979 )
    {
        level.doa.var_2d09b979 = undefined;
        return 1;
    }
    
    var_a60f3304 = 0;
    
    for ( i = 0; i < level.doa.pickups.items.size ; i++ )
    {
        if ( level.doa.round_number >= level.doa.pickups.items[ i ].var_dea19cf0 )
        {
            var_a60f3304++;
        }
    }
    
    assert( var_a60f3304 );
    
    if ( level.doa.var_3cc04c3a.size < var_a60f3304 / 4 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace doa_pickups
// Params 1
// Checksum 0xb38861d4, Offset: 0x48c0
// Size: 0x318
function function_51b3bbf6( type )
{
    if ( !isdefined( type ) )
    {
        type = 0;
    }
    
    assert( level.doa.pickups.items.size );
    
    foreach ( pickup in level.doa.pickups.items )
    {
        if ( isdefined( pickup.var_500db33e ) && isinarray( pickup.var_500db33e, level.doa.round_number ) )
        {
            arrayremovevalue( pickup.var_500db33e, level.doa.round_number );
            level.doa.var_2d09b979 = 1;
            return pickup;
        }
    }
    
    if ( type != 0 )
    {
        for ( i = 0; i < level.doa.pickups.items.size ; i++ )
        {
            if ( level.doa.pickups.items[ i ].type == type )
            {
                return level.doa.pickups.items[ i ];
            }
        }
    }
    
    if ( function_c41b5928() )
    {
        temp = doa_utility::function_4e9a23a9( level.doa.pickups.items );
        
        for ( i = 0; i < temp.size ; i++ )
        {
            if ( level.doa.round_number >= temp[ i ].var_dea19cf0 )
            {
                level.doa.var_3cc04c3a[ level.doa.var_3cc04c3a.size ] = temp[ i ];
            }
        }
    }
    
    index = level.doa.var_3cc04c3a.size - 1;
    pu = level.doa.var_3cc04c3a[ index ];
    arrayremoveindex( level.doa.var_3cc04c3a, index );
    return pu;
}

// Namespace doa_pickups
// Params 1
// Checksum 0xe3310cd1, Offset: 0x4be0
// Size: 0xb4
function function_bac08508( type )
{
    for ( i = 0; i < level.doa.pickups.items.size ; i++ )
    {
        if ( level.doa.pickups.items[ i ].type == type )
        {
            return level.doa.pickups.items[ i ];
        }
    }
    
    assert( 0 );
}

// Namespace doa_pickups
// Params 3
// Checksum 0x57b98e4d, Offset: 0x4ca0
// Size: 0x12c
function spawnmoneyglob( var_90658db9, numglobs, waittime )
{
    if ( !isdefined( var_90658db9 ) )
    {
        var_90658db9 = 0;
    }
    
    if ( !isdefined( numglobs ) )
    {
        numglobs = 1;
    }
    
    if ( !isdefined( waittime ) )
    {
        waittime = 2;
    }
    
    level endon( #"hash_e2918623" );
    
    while ( numglobs > 0 )
    {
        spawn_point = function_ac410a13();
        
        if ( isdefined( spawn_point ) )
        {
            if ( !var_90658db9 )
            {
                level thread function_e904e32d( spawn_point.origin, 4 + randomint( 5 ) );
            }
            else
            {
                level thread spawnubertreasure( spawn_point.origin, 3 + randomint( 5 ) );
            }
        }
        
        numglobs--;
        wait waittime;
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0xac041d48, Offset: 0x4dd8
// Size: 0x128
function function_bfc8e78d()
{
    level notify( #"hash_bfc8e78d" );
    level endon( #"hash_bfc8e78d" );
    
    while ( true )
    {
        wait randomfloatrange( 10, 20 );
        
        if ( !level flag::get( "doa_round_spawning" ) )
        {
            wait 1;
            continue;
        }
        else if ( level.players.size == 1 && level.doa.var_9a1cbf58 && level.doa.var_677d1262 && gettime() > level.doa.var_677d1262 )
        {
            /#
                doa_utility::debugmsg( "<dev string:x28>" );
            #/
            
            wait 1;
            continue;
        }
        
        if ( level flag::get( "doa_game_is_over" ) )
        {
            continue;
        }
        
        level thread spawnmoneyglob();
    }
}

// Namespace doa_pickups
// Params 1
// Checksum 0xb4b5aacd, Offset: 0x4f08
// Size: 0x98
function function_c87a0cd7( name )
{
    for ( i = 0; i < level.doa.pickups.items.size ; i++ )
    {
        if ( level.doa.pickups.items[ i ].gdtname == name )
        {
            return level.doa.pickups.items[ i ];
        }
    }
}

// Namespace doa_pickups
// Params 1
// Checksum 0xa3731b3f, Offset: 0x4fa8
// Size: 0x98
function function_e2dcc82a( type )
{
    for ( i = 0; i < level.doa.pickups.items.size ; i++ )
    {
        if ( level.doa.pickups.items[ i ].type == type )
        {
            return level.doa.pickups.items[ i ];
        }
    }
}

// Namespace doa_pickups
// Params 1
// Checksum 0xb2ee05f2, Offset: 0x5048
// Size: 0xa0
function spawnitem( type )
{
    if ( !isdefined( type ) )
    {
        type = 0;
    }
    
    level notify( #"spawnitem" );
    level endon( #"spawnitem" );
    
    while ( true )
    {
        pickup = function_51b3bbf6( type );
        
        if ( function_967df2b6( pickup ) )
        {
            function_3238133b( pickup.gdtname );
            return;
        }
        
        wait 1;
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0x73568e73, Offset: 0x50f0
// Size: 0x170
function function_b8d3f901()
{
    self notify( #"hash_b8d3f901" );
    self endon( #"hash_b8d3f901" );
    level.doa.var_cc2eacdf = [];
    
    while ( true )
    {
        spawneditems = 0;
        
        while ( level.doa.var_cc2eacdf.size )
        {
            if ( spawneditems >= getdvarint( "scr_doa_queue_items_pertick", 2 ) )
            {
                break;
            }
            
            spawneditems++;
            item = level.doa.var_cc2eacdf[ 0 ];
            spawnspecificitem( item.pickup, item.origin, 1, item.timeout, item.radius, item.rotate, item.angles );
            item.amount--;
            
            if ( item.amount == 0 )
            {
                arrayremoveindex( level.doa.var_cc2eacdf, 0 );
            }
        }
        
        util::wait_network_frame();
    }
}

// Namespace doa_pickups
// Params 7
// Checksum 0x89a00fcd, Offset: 0x5268
// Size: 0x17e
function function_eaf49506( type, origin, amount, timeout, radius, rotate, angles )
{
    if ( !isdefined( amount ) )
    {
        amount = 1;
    }
    
    if ( !isdefined( timeout ) )
    {
        timeout = 1;
    }
    
    if ( !isdefined( rotate ) )
    {
        rotate = 1;
    }
    
    queueitem = spawnstruct();
    queueitem.pickup = function_e2dcc82a( type );
    queueitem.origin = origin;
    assert( amount > 0, "<dev string:x5f>" );
    queueitem.amount = amount;
    queueitem.timeout = timeout;
    queueitem.radius = radius;
    queueitem.rotate = rotate;
    queueitem.angles = angles;
    level.doa.var_cc2eacdf[ level.doa.var_cc2eacdf.size ] = queueitem;
}

// Namespace doa_pickups
// Params 7
// Checksum 0x63f5fb5d, Offset: 0x53f0
// Size: 0x17e
function function_3238133b( name, origin, amount, timeout, radius, rotate, angles )
{
    if ( !isdefined( amount ) )
    {
        amount = 1;
    }
    
    if ( !isdefined( timeout ) )
    {
        timeout = 1;
    }
    
    if ( !isdefined( rotate ) )
    {
        rotate = 1;
    }
    
    queueitem = spawnstruct();
    queueitem.pickup = function_c87a0cd7( name );
    queueitem.origin = origin;
    assert( amount > 0, "<dev string:x5f>" );
    queueitem.amount = amount;
    queueitem.timeout = timeout;
    queueitem.radius = radius;
    queueitem.rotate = rotate;
    queueitem.angles = angles;
    level.doa.var_cc2eacdf[ level.doa.var_cc2eacdf.size ] = queueitem;
}

// Namespace doa_pickups
// Params 7
// Checksum 0x6819eac, Offset: 0x5578
// Size: 0x266
function spawnspecificitem( pickup, origin, amount, timeout, radius, rotate, angle )
{
    if ( !isdefined( amount ) )
    {
        amount = 1;
    }
    
    if ( !isdefined( timeout ) )
    {
        timeout = 1;
    }
    
    if ( !isdefined( rotate ) )
    {
        rotate = 1;
    }
    
    if ( !isdefined( pickup ) )
    {
        return;
    }
    
    items = [];
    
    for ( i = 0; i < amount ; i++ )
    {
        if ( !isdefined( origin ) )
        {
            spot = function_ac410a13();
            
            if ( !isdefined( spot ) )
            {
                continue;
            }
            
            if ( !isdefined( radius ) )
            {
                if ( isdefined( spot.radius ) )
                {
                    radius = spot.radius;
                }
                else
                {
                    radius = 120;
                }
            }
            
            origin = spot.origin + ( randomintrange( radius * -1, radius ), randomintrange( radius * -1, radius ), 32 );
            items[ items.size ] = [[ pickup.var_74f5c76 ]]( pickup, origin, timeout, rotate, angle );
            origin = undefined;
            continue;
        }
        
        spot = origin;
        
        if ( isdefined( radius ) )
        {
            spot = origin + ( randomintrange( radius * -1, radius ), randomintrange( radius * -1, radius ), 32 );
        }
        
        items[ items.size ] = [[ pickup.var_74f5c76 ]]( pickup, spot, timeout, rotate, angle );
    }
    
    return items;
}

// Namespace doa_pickups
// Params 1
// Checksum 0xf6527503, Offset: 0x57e8
// Size: 0x124
function function_53347911( player )
{
    self endon( #"picked_up" );
    self endon( #"death" );
    player endon( #"disconnect" );
    self.player = player;
    var_42b46711 = gettime() + 1500;
    
    while ( isdefined( self ) && gettime() < var_42b46711 )
    {
        if ( self.origin[ 2 ] < player.origin[ 2 ] )
        {
            self.origin = player.origin;
            break;
        }
        
        modz = ( player.origin[ 0 ], player.origin[ 1 ], self.origin[ 2 ] - 32 );
        self.origin = modz;
        wait 0.05;
    }
    
    if ( isdefined( self ) )
    {
        self.trigger notify( #"trigger", player );
    }
}

// Namespace doa_pickups
// Params 2
// Checksum 0xb2ac596d, Offset: 0x5918
// Size: 0x1a2
function function_30768f24( item, time )
{
    self endon( #"disconnect" );
    item endon( #"death" );
    
    if ( time <= 0 )
    {
        time = 1;
    }
    
    intervals = time / 0.15;
    
    while ( isdefined( item ) && time > 0.15 )
    {
        dist = distance( self.origin, item.origin );
        step = dist / time / intervals;
        v_to_target = vectornormalize( self.origin - item.origin ) * step;
        
        /#
        #/
        
        item moveto( item.origin + v_to_target, 0.15 );
        dist = distance( self.origin, item.origin );
        
        if ( dist < 32 )
        {
            break;
        }
        
        time -= 0.15;
        wait 0.15;
    }
    
    self notify( #"hash_30768f24" );
}

// Namespace doa_pickups
// Params 3
// Checksum 0xba8cab8a, Offset: 0x5ac8
// Size: 0x10a
function directeditemawardto( player, name, amount )
{
    if ( !isdefined( amount ) )
    {
        amount = 1;
    }
    
    player endon( #"disconnect" );
    pickupdef = function_c87a0cd7( name );
    
    if ( !isdefined( pickupdef ) )
    {
        return;
    }
    
    while ( amount )
    {
        pickup = [[ pickupdef.var_74f5c76 ]]( pickupdef, player.origin + ( 0, 0, 800 ) );
        pickup thread function_53347911( player );
        
        if ( amount > 1 )
        {
            wait 0.25;
        }
        else
        {
            while ( isdefined( pickup ) )
            {
                wait 0.5;
            }
        }
        
        amount--;
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0x86a1f605, Offset: 0x5be0
// Size: 0x148
function function_2904bdc4()
{
    level notify( #"hash_2904bdc4" );
    level endon( #"hash_2904bdc4" );
    
    while ( true )
    {
        if ( !level flag::get( "doa_round_spawning" ) )
        {
            wait 1;
            continue;
        }
        else if ( level.players.size == 1 && level.doa.var_9a1cbf58 && level.doa.var_677d1262 && gettime() > level.doa.var_677d1262 )
        {
            /#
                doa_utility::debugmsg( "<dev string:x81>" );
            #/
            
            wait 1;
            continue;
        }
        
        level thread spawnitem();
        
        if ( !level flag::get( "doa_game_silverback_round" ) )
        {
            wait randomfloatrange( 10, 15 );
            continue;
        }
        
        wait randomfloatrange( 5, 10 );
    }
}

// Namespace doa_pickups
// Params 1
// Checksum 0xf51bc2c3, Offset: 0x5d30
// Size: 0x134
function weaponspawn( gdtname )
{
    if ( !isdefined( gdtname ) )
    {
        weapons = [];
        
        for ( i = 0; i < level.doa.pickups.items.size ; i++ )
        {
            if ( level.doa.pickups.items[ i ].type == 16 )
            {
                weapons[ weapons.size ] = level.doa.pickups.items[ i ];
            }
        }
        
        weapon = weapons[ randomint( weapons.size ) ];
        level function_3238133b( weapon.gdtname );
        return;
    }
    
    level function_3238133b( gdtname );
}

// Namespace doa_pickups
// Params 2
// Checksum 0x49bf1db9, Offset: 0x5e70
// Size: 0x1f0
function function_5bb8e0d1( var_742d8fb5, location )
{
    level notify( #"hash_5bb8e0d1" );
    level endon( #"hash_5bb8e0d1" );
    
    while ( true )
    {
        waittime = randomfloatrange( level.doa.rules.var_be9a9995, level.doa.rules.var_ab729583 );
        
        while ( waittime > 0 )
        {
            if ( !level flag::get( "doa_round_active" ) )
            {
                wait 1;
                continue;
            }
            
            wait 5;
            waittime -= 5;
        }
        
        players = doa_player_utility::function_5eb6e4d1();
        lives = 0;
        
        for ( i = 0; i < players.size ; i++ )
        {
            lives += players[ i ].doa.lives;
        }
        
        waittime = lives * 10;
        
        while ( waittime > 0 )
        {
            if ( !level flag::get( "doa_round_active" ) )
            {
                wait 1;
                continue;
            }
            
            wait 5;
            waittime -= 5;
        }
        
        if ( level flag::get( "doa_game_is_over" ) )
        {
            continue;
        }
        
        level function_3238133b( "zombietron_extra_life" );
    }
}

// Namespace doa_pickups
// Params 1
// Checksum 0x8a5b1463, Offset: 0x6068
// Size: 0x4c, Type: bool
function function_c129719a( type )
{
    switch ( type )
    {
        case 1:
        case 5:
        case 8:
        case 10:
        case 12:
            return true;
    }
    
    return false;
}

// Namespace doa_pickups
// Params 1
// Checksum 0x5110eebc, Offset: 0x60c0
// Size: 0x468
function function_967df2b6( pickupdef )
{
    if ( !mayspawnentity() )
    {
        return 0;
    }
    
    if ( level.doa.round_number < pickupdef.var_dea19cf0 )
    {
        return 0;
    }
    
    if ( pickupdef.chance < 100 && randomint( 100 ) > pickupdef.chance )
    {
        return 0;
    }
    
    if ( pickupdef.type == 35 )
    {
        if ( isdefined( level.doa.var_2836c8ee ) && level.doa.var_2836c8ee )
        {
            return 0;
        }
        
        pickupsitems = getentarray( "a_pickup_item", "script_noteworthy" );
        
        foreach ( pickup in pickupsitems )
        {
            if ( isdefined( pickup ) && pickup.type == 35 )
            {
                return 0;
            }
        }
        
        return 1;
    }
    
    if ( pickupdef.type == 29 )
    {
        if ( zombie_vortex::get_active_vortex_count() > 0 )
        {
            return 0;
        }
    }
    
    if ( pickupdef.type == 7 || pickupdef.type == 19 || pickupdef.type == 6 || pickupdef.type == 34 )
    {
        foreach ( player in doa_player_utility::function_5eb6e4d1() )
        {
            if ( isdefined( player.doa.var_5a34cdc9 ) )
            {
                return 0;
            }
            
            if ( isdefined( player.doa.var_39c1b814 ) )
            {
                return 0;
            }
            
            if ( isdefined( player.doa.tesla_blockers ) )
            {
                return 0;
            }
            
            if ( isdefined( player.doa.var_bfb9be95 ) )
            {
                return 0;
            }
        }
    }
    
    if ( pickupdef.type == 24 || pickupdef.type == 38 || pickupdef.type == 9 || pickupdef.type == 25 || pickupdef.type == 33 )
    {
        if ( isdefined( level.doa.margwa ) )
        {
            return 0;
        }
        
        foreach ( player in doa_player_utility::function_5eb6e4d1() )
        {
            if ( isdefined( player.doa.vehicle ) )
            {
                return 0;
            }
        }
    }
    
    if ( pickupdef.type == 3 )
    {
        return doa_turret::canspawnturret();
    }
    
    return 1;
}

// Namespace doa_pickups
// Params 0
// Checksum 0xccbadd8a, Offset: 0x6530
// Size: 0x11f8
function function_d526f0bb()
{
    self notify( #"hash_d526f0bb" );
    self endon( #"hash_d526f0bb" );
    self endon( #"death" );
    wait 0.4;
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( isdefined( self.player ) && self.player != player )
        {
            continue;
        }
        
        if ( player.team == "axis" )
        {
            continue;
        }
        
        if ( isvehicle( player ) && isdefined( player.owner ) && isplayer( player.owner ) && !( isdefined( player.autonomous ) && player.autonomous ) )
        {
            player = player.owner;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( isdefined( self.def.var_d1c98aa0 ) )
        {
            self thread doa_fx::function_285a2999( self.def.var_d1c98aa0 );
            util::wait_network_frame();
        }
        
        var_9aec68f5 = 1;
        
        if ( isdefined( player ) && isdefined( player.doa ) )
        {
            if ( !isdefined( self.player ) && isdefined( player.doa.vehicle ) && !function_c129719a( self.type ) )
            {
                wait 0.5;
                continue;
            }
            
            if ( isdefined( player.dead ) && player.dead )
            {
                wait 0.5;
                continue;
            }
            
            switch ( self.type )
            {
                case 32:
                    assert( isdefined( self.var_25ffdef1 ), "<dev string:xb7>" );
                    player.skulls++;
                    
                    if ( !isdefined( player.doa.skulls ) )
                    {
                        player.doa.skulls = 0;
                        player.doa.var_fda5a6e5 = 0;
                    }
                    
                    player.doa.skulls++;
                    player.doa.var_fda5a6e5++;
                    self thread doa_sound::function_90118d8c( "zmb_pickup_nurgle" );
                    player doa_player_utility::function_71dab8e8( self.var_25ffdef1 );
                    self function_6b4a5f81( player );
                    break;
                case 1:
                    if ( isdefined( self.def.uber ) && self.def.uber )
                    {
                        player.gems++;
                        
                        if ( !isdefined( player.doa.gems ) )
                        {
                            player.doa.gems = 0;
                            player.doa.var_6946711f = 0;
                        }
                        
                        player.doa.gems++;
                        player.doa.var_6946711f++;
                    }
                    
                    self thread doa_sound::function_90118d8c( "zmb_pickup_money" );
                    player thread doa_score::function_850bb47e( isdefined( self.var_5d2140f2 ) ? self.var_5d2140f2 : level.doa.rules.var_a9114441 );
                    player thread doa_score::function_80eb303( self.score );
                    self function_6b4a5f81( player );
                    break;
                case 16:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_weapon" );
                    player doa_player_utility::function_d5f89a15( self.def.gdtname, 1 );
                    player.special_weapon = getweapon( self.def.gdtname );
                    assert( isdefined( player.special_weapon ) );
                    break;
                case 10:
                    self thread doa_sound::function_90118d8c( "zmb_pickup_powerup" );
                    player thread doa_player_utility::function_f3748dcb();
                    self function_6b4a5f81( player );
                    break;
                case 12:
                    self thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    player thread doa_player_utility::function_ba145a39();
                    self function_6b4a5f81( player );
                    break;
                case 8:
                    if ( !isdefined( self.player ) )
                    {
                        players = doa_player_utility::function_5eb6e4d1();
                        var_63ef8ae = [];
                        
                        foreach ( player in players )
                        {
                            if ( isdefined( player.doa.respawning ) && player.doa.respawning )
                            {
                                var_63ef8ae[ var_63ef8ae.size ] = player;
                            }
                        }
                        
                        foreach ( player in players )
                        {
                            if ( !( isdefined( player.doa.respawning ) && player.doa.respawning ) )
                            {
                                var_63ef8ae[ var_63ef8ae.size ] = player;
                            }
                        }
                        
                        foreach ( guy in var_63ef8ae )
                        {
                            if ( isdefined( guy ) )
                            {
                                guy doa_player_utility::function_6a52a347();
                            }
                            
                            wait 0.05;
                        }
                    }
                    else
                    {
                        player thread doa_player_utility::function_6a52a347();
                    }
                    
                    self thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    self function_6b4a5f81( player );
                    player thread doa_sound::function_90118d8c( "zmb_pickup_life" );
                    break;
                case 4:
                    player thread doa_player_utility::function_832d21c2();
                    break;
                case 2:
                    player.doa.var_c2b9d7d0 = gettime() + int( player doa_utility::function_1ded48e6( level.doa.rules.var_c05a9a3f ) * 1000 );
                    player doa_player_utility::function_71dab8e8( int( getdvarint( "scr_doa_weapon_increment_range", 1024 ) / getdvarint( "scr_doa_weapon_increment", 64 ) ) - 1 );
                    player thread doa_sound::function_90118d8c( "zmb_pickup_ammo" );
                    player thread function_322262ea();
                    break;
                case 5:
                    player.chickens++;
                    player.doa.chickensTamed++;
                    player thread doa_sound::function_90118d8c( "zmb_pickup_chicken" );
                    player doa_chicken::chickenpickup();
                    break;
                case 11:
                    level thread doa_area_affect::monkeyUpdate( player, self.origin );
                    break;
                case 29:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_vortex" );
                    level thread doa_area_affect::function_d171e15a( player, self.origin );
                    break;
                case 17:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_umbrella" );
                    self thread function_68c8220( player );
                    break;
                case 7:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    player thread doa_shield::barrelupdate();
                    break;
                case 13:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    player thread doa_shield::function_affe0c28();
                    break;
                case 3:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread doa_turret::function_eabe8c0( player );
                    break;
                case 18:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread doa_turret::function_eabe8c0( player, 1 );
                    break;
                case 6:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    player thread doa_tesla::tesla_blockers_update();
                    break;
                case 21:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    player thread doa_shield::magnet_update();
                    break;
                case 28:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level notify( #"hash_bbc7bdf9", player );
                    break;
                case 19:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    player thread doa_shield::sawbladeupdate();
                    break;
                case 20:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread doa_turret::function_3ce8bf1c( player, self.origin );
                    break;
                case 22:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread doa_turret::amwsPickupUpdate( player, self.origin + ( 0, 0, 20 ) );
                    break;
                case 14:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread doa_area_affect::timeshifterupdate( player, self.origin );
                    break;
                case 24:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread doa_vehicle::function_21af9396( player, self.origin + ( 0, 0, 20 ) );
                    break;
                case 38:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread doa_vehicle::function_2ef99744( player, self.origin + ( 0, 0, 20 ) );
                    break;
                case 9:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread doa_vehicle::function_f27a22c8( player, self.origin + ( 0, 0, 50 ) );
                    break;
                case 25:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread doa_vehicle::function_1e663abe( player, self.origin + ( 0, 0, 20 ) );
                    break;
                case 33:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread doa_vehicle::function_e9f445ce( player, self.origin + ( 0, 0, 20 ) );
                    break;
                case 34:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    player thread doa_shield::boxingpickupupdate();
                    break;
                case 30:
                case 31:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread function_411355c0( self.type, player, player.origin );
                    break;
                case 26:
                    self stoploopsound();
                    player thread doa_sound::function_90118d8c( "zmb_heart_pickup" );
                    level thread function_fce74a5f( self );
                    break;
                case 35:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread firstPersonForATime( player );
                    break;
                case 15:
                    /#
                        doa_utility::debugmsg( "<dev string:xdb>" );
                    #/
                    
                    break;
                case 37:
                    player thread doa_sound::function_90118d8c( "zmb_pickup_generic" );
                    level thread doa_area_affect::teamShifterUpdate( player, self.origin );
                    break;
                default:
                    assert( 0 );
                    break;
            }
            
            if ( isdefined( var_9aec68f5 ) && var_9aec68f5 && isdefined( self ) )
            {
                self notify( #"picked_up" );
                
                if ( isdefined( self.trigger ) )
                {
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

// Namespace doa_pickups
// Params 1
// Checksum 0x5df32dea, Offset: 0x7730
// Size: 0xe8
function function_cb119fa6( timeinterval )
{
    if ( !isdefined( timeinterval ) )
    {
        timeinterval = 1;
    }
    
    self endon( #"disconnect" );
    self notify( #"hash_cb119fa6" );
    self endon( #"hash_cb119fa6" );
    var_f2801f2d = int( self.maxhealth * 0.1 );
    
    while ( isdefined( self.doa.infps ) && self.doa.infps )
    {
        wait timeinterval;
        
        if ( self.health < self.maxhealth )
        {
            self.health = math::clamp( self.health + var_f2801f2d, 0, self.maxhealth );
        }
    }
}

// Namespace doa_pickups
// Params 1
// Checksum 0x2c548683, Offset: 0x7820
// Size: 0x56
function function_bc81eba( time )
{
    if ( !isdefined( time ) )
    {
        time = 1;
    }
    
    self endon( #"disconnect" );
    self.doa.var_655cbff1 = 1;
    wait time;
    self.doa.var_655cbff1 = undefined;
}

// Namespace doa_pickups
// Params 0
// Checksum 0x571e8924, Offset: 0x7880
// Size: 0x42c
function playerFPSForATime()
{
    self notify( #"playerFPSForATime" );
    self endon( #"playerFPSForATime" );
    self endon( #"disconnect" );
    
    /#
        doa_utility::debugmsg( "<dev string:xf9>" + gettime() );
    #/
    
    self thread doa_player_utility::turnplayershieldon( 0 );
    self thread function_bc81eba();
    
    if ( !( isdefined( self.doa.infps ) && self.doa.infps ) )
    {
        self.doa.infps = 1;
        self.doa.var_f9deeb49 = 0;
        self clientfield::set_to_player( "overdrive_state", 1 );
        self freezecontrols( 1 );
        self clientfield::increment_to_player( "goFPS" );
        wait 0.2;
        self clientfield::set_to_player( "overdrive_state", 0 );
        
        if ( isalive( self ) && !( isdefined( self.doa.respawning ) && self.doa.respawning ) )
        {
            self freezecontrols( 0 );
        }
    }
    
    level notify( #"doaGoFPS" );
    self setclientthirdperson( 0 );
    self.doa.var_a3f61a60 = 4;
    self.topdowncamera = 0;
    self allowsprint( isdefined( self.doa.infps ) && self.doa.infps );
    self allowads( isdefined( self.doa.infps ) && self.doa.infps );
    self util::waittill_any( "camera_changed", "doa_playerdumpFPS", "exit_taken", "playerFPSForATime", "disconnect" );
    self thread doa_player_utility::turnplayershieldon();
    self.topdowncamera = 1;
    self.doa.infps = undefined;
    self.doa.var_a3f61a60 = 0;
    self setclientthirdperson( 0 );
    
    if ( isalive( self ) && !( isdefined( self.doa.respawning ) && self.doa.respawning ) )
    {
        self.health = self.maxhealth;
    }
    
    self clientfield::increment_to_player( "exitFPS" );
    self clientfield::increment_to_player( "controlBinding" );
    self.doa.var_c1de140a = gettime() + 2500;
    
    /#
        doa_utility::debugmsg( "<dev string:x116>" + gettime() );
    #/
    
    self allowsprint( isdefined( self.doa.infps ) && self.doa.infps );
    self allowads( isdefined( self.doa.infps ) && self.doa.infps );
}

// Namespace doa_pickups
// Params 0
// Checksum 0xecdc5d0d, Offset: 0x7cb8
// Size: 0xa4
function function_2cd5668()
{
    level endon( #"firstPersonForATime" );
    level endon( #"doa_playerdumpFPS" );
    level util::waittill_any_timeout( 0.5, "doaGoFPS", "firstPersonForATime" );
    setsharedviewport( 0 );
    
    if ( mayspawnentity() )
    {
        playsoundatposition( "evt_first_person_slam", ( 0, 0, 0 ) );
    }
    
    util::clientnotify( "fpsg" );
}

// Namespace doa_pickups
// Params 0
// Checksum 0xcbb544d6, Offset: 0x7d68
// Size: 0x180
function function_851d4a18()
{
    level endon( #"firstPersonForATime" );
    level endon( #"doa_playerdumpFPS" );
    
    while ( isdefined( level.doa.var_2836c8ee ) && level.doa.var_2836c8ee )
    {
        foreach ( player in getplayers() )
        {
            if ( !isdefined( player.doa ) )
            {
                continue;
            }
            
            if ( isdefined( player.var_744a3931 ) && player.var_744a3931 )
            {
                continue;
            }
            
            if ( !( isdefined( player.hotjoin ) && player.hotjoin ) && !( isdefined( player.doa.infps ) && player.doa.infps ) )
            {
                player thread playerFPSForATime();
            }
        }
        
        wait 0.05;
    }
}

// Namespace doa_pickups
// Params 1
// Checksum 0x1d1926e, Offset: 0x7ef0
// Size: 0x25c
function firstPersonForATime( player )
{
    level notify( #"firstPersonForATime" );
    level endon( #"firstPersonForATime" );
    level.doa.var_2836c8ee = 1;
    level clientfield::set( "doafps", 1 );
    level thread function_2cd5668();
    util::wait_network_frame();
    level thread function_851d4a18();
    
    /#
        doa_utility::debugmsg( "<dev string:x132>" + gettime() );
    #/
    
    time = int( player doa_utility::function_1ded48e6( getdvarint( "scr_doa_fps_time", 60 ) ) );
    level thread function_197694d8();
    level util::waittill_any_timeout( time, "camera_changed", "doa_playerdumpFPS", "exit_taken", "host_migration_begin", "firstPersonForATime" );
    level.doa.var_2836c8ee = undefined;
    
    foreach ( player in getplayers() )
    {
        player notify( #"doa_playerdumpFPS" );
    }
    
    /#
        doa_utility::debugmsg( "<dev string:x149>" + gettime() );
    #/
    
    level notify( #"doa_playerdumpFPS" );
    level notify( #"atf" );
    setsharedviewport( 1 );
    level clientfield::set( "doafps", 0 );
}

// Namespace doa_pickups
// Params 0
// Checksum 0x44b50c7d, Offset: 0x8158
// Size: 0x104
function function_197694d8()
{
    if ( !isdefined( level.var_8ebc0a1 ) )
    {
        level.var_8ebc0a1 = spawn( "script_origin", ( 0, 0, 0 ) );
    }
    
    level.var_8ebc0a1 playloopsound( "evt_first_person_loop" );
    level waittill( #"atf" );
    
    if ( mayspawnentity() )
    {
        playsoundatposition( "evt_first_person_slam_out", ( 0, 0, 0 ) );
    }
    
    if ( isdefined( level.var_8ebc0a1 ) )
    {
        level.var_8ebc0a1 stoploopsound();
    }
    
    util::clientnotify( "fpss" );
    wait 0.5;
    
    if ( isdefined( level.var_8ebc0a1 ) )
    {
        level.var_8ebc0a1 delete();
    }
}

// Namespace doa_pickups
// Params 1
// Checksum 0x834572ae, Offset: 0x8268
// Size: 0x2b4
function function_6b4a5f81( player )
{
    self endon( #"death" );
    
    if ( isdefined( self.var_52cf38a3 ) && self.var_52cf38a3 )
    {
        entmask = 0;
        
        if ( isdefined( player ) )
        {
            entmask = 1 + player.entnum << 1;
        }
        
        val = entmask + 1;
        self clientfield::set( "pickupmoveto", val );
    }
    else
    {
        if ( isdefined( player ) )
        {
            x = 2000;
            y = 3000;
            z = 1000;
            
            if ( level.doa.flipped )
            {
                x = 0 - x;
                y = 0 - y;
            }
            
            end_pt = player.origin;
            
            if ( player.entnum == 0 )
            {
            }
            else if ( player.entnum == 1 )
            {
                y = 0 - y;
            }
            else if ( player.entnum == 2 )
            {
                x = 0 - x;
            }
            else if ( player.entnum == 3 )
            {
                y = 0 - y;
                x = 0 - x;
            }
            
            end_pt += ( x, y, z );
        }
        else
        {
            end_pt = self.origin + ( 0, 0, 3000 );
        }
        
        self notify( #"picked_up" );
        wait 0.05;
        
        if ( isdefined( self ) )
        {
            self function_fbc5b316();
            self moveto( end_pt, 2, 0, 0 );
            wait 2;
        }
    }
    
    util::wait_network_frame();
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    self delete();
}

// Namespace doa_pickups
// Params 0
// Checksum 0x51345f69, Offset: 0x8528
// Size: 0x74
function pickupwobble()
{
    self endon( #"death" );
    
    if ( isdefined( self.var_52cf38a3 ) && self.var_52cf38a3 )
    {
        util::wait_network_frame();
        self clientfield::set( "pickupwobble", 1 );
        return;
    }
    
    self thread function_ee036ce4();
}

// Namespace doa_pickups
// Params 0
// Checksum 0x436d80ad, Offset: 0x85a8
// Size: 0x158
function function_ee036ce4()
{
    self notify( #"hash_b14b3cac" );
    self endon( #"hash_b14b3cac" );
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        waittime = randomfloatrange( 2.5, 5 );
        yaw = randomint( 360 );
        
        if ( yaw > 300 )
        {
            yaw = 300;
        }
        else if ( yaw < 60 )
        {
            yaw = 60;
        }
        
        yaw = self.angles[ 1 ] + yaw;
        self rotateto( ( -20 + randomint( 40 ), yaw, -90 + randomint( 180 ) ), waittime, waittime * 0.5, waittime * 0.5 );
        wait randomfloat( waittime - 0.1 );
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0x851d1e22, Offset: 0x8708
// Size: 0x106
function pickuprotate()
{
    self endon( #"death" );
    
    if ( isdefined( self.var_52cf38a3 ) && self.var_52cf38a3 )
    {
        util::wait_network_frame();
        self clientfield::set( "pickuprotate", 1 );
        return;
    }
    
    dir = 180;
    
    if ( randomint( 100 ) > 50 )
    {
        dir = -180;
    }
    
    time = randomfloatrange( 3, 7 );
    
    while ( isdefined( self ) )
    {
        self rotateto( self.angles + ( 0, dir, 0 ), time );
        wait time;
    }
}

// Namespace doa_pickups
// Params 1
// Checksum 0x87c0c3de, Offset: 0x8818
// Size: 0xd4
function pickupscale( scale )
{
    self endon( #"death" );
    
    if ( isdefined( self.var_52cf38a3 ) && self.var_52cf38a3 )
    {
        util::wait_network_frame();
        
        if ( scale > 16 )
        {
            scale = 16;
        }
        
        val = int( scale / 16 * ( 256 - 1 ) );
        self clientfield::set( "pickupscale", val );
        return;
    }
    
    self setscale( scale );
}

// Namespace doa_pickups
// Params 0
// Checksum 0xe80e89da, Offset: 0x88f8
// Size: 0x54
function function_32110b7d()
{
    if ( isdefined( self.var_52cf38a3 ) && self.var_52cf38a3 )
    {
        self clientfield::set( "pickupvisibility", 1 );
        return;
    }
    
    self hide();
}

// Namespace doa_pickups
// Params 0
// Checksum 0x54af141e, Offset: 0x8958
// Size: 0x54
function function_fbc5b316()
{
    if ( isdefined( self.var_52cf38a3 ) && self.var_52cf38a3 )
    {
        self clientfield::set( "pickupvisibility", 0 );
        return;
    }
    
    self show();
}

// Namespace doa_pickups
// Params 0
// Checksum 0xfa5ae28b, Offset: 0x89b8
// Size: 0x1f4
function pickuptimeout()
{
    self endon( #"death" );
    timetowait = isdefined( self.timeout ) ? self.timeout : level.doa.rules.powerup_timeout;
    wait timetowait + randomfloatrange( 0, 5 );
    
    for ( i = 0; i < 40 ; i++ )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        if ( isdefined( self.var_71bbb00a ) )
        {
            [[ self.var_71bbb00a ]]( i % 2 );
        }
        else if ( i % 2 )
        {
            self function_32110b7d();
        }
        else
        {
            self function_fbc5b316();
        }
        
        if ( i < 15 )
        {
            wait 0.5;
            util::wait_network_frame();
            continue;
        }
        
        if ( i < 25 )
        {
            wait 0.25;
            util::wait_network_frame();
            continue;
        }
        
        wait 0.1;
        util::wait_network_frame();
    }
    
    self notify( #"pickup_timeout" );
    wait 0.1;
    
    if ( isdefined( self ) && !( isdefined( self.nodelete ) && self.nodelete ) )
    {
        if ( isdefined( self.trigger ) )
        {
            self.trigger delete();
        }
        
        self delete();
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0xebd58e20, Offset: 0x8bb8
// Size: 0xf2
function function_c1869ec8()
{
    level notify( #"stop_spawning_pickups" );
    util::wait_network_frame();
    pickupsitems = getentarray( "a_pickup_item", "script_noteworthy" );
    
    for ( i = 0; i < pickupsitems.size ; i++ )
    {
        pickup = pickupsitems[ i ];
        
        if ( isdefined( pickup ) )
        {
            if ( isdefined( pickup.trigger ) )
            {
                pickup.trigger delete();
            }
            
            pickup delete();
        }
    }
    
    level notify( #"hash_229914a6" );
}

// Namespace doa_pickups
// Params 1
// Checksum 0x4158943, Offset: 0x8cb8
// Size: 0x14c
function function_80ed7f( popvec )
{
    self.trigger triggerenable( 0 );
    
    if ( !isdefined( popvec ) )
    {
        target_point = self.origin + ( randomfloatrange( -4, 4 ), randomfloatrange( -4, 4 ), 20 );
    }
    else
    {
        target_point = self.origin + popvec;
    }
    
    vel = target_point - self.origin;
    self.origin += 4 * vel;
    vel *= randomfloatrange( 0.5, 3 );
    self physicslaunch( self.origin, vel );
    wait 1;
    
    if ( isdefined( self ) && isdefined( self.trigger ) )
    {
        self.trigger triggerenable( 1 );
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0x3363e031, Offset: 0x8e10
// Size: 0x74
function function_9615d68f()
{
    if ( !isdefined( self.doa.var_a2d31b4a ) || self.doa.var_a2d31b4a != self.doa.default_weap.name )
    {
        self doa_player_utility::function_d5f89a15( self.doa.default_weap.name );
    }
}

// Namespace doa_pickups
// Params 0, eflags: 0x4
// Checksum 0xf34251c9, Offset: 0x8e90
// Size: 0x58, Type: bool
function private function_972fe17c()
{
    if ( self.def.type == 23 || self.def.type == 36 )
    {
        return false;
    }
    
    if ( self.def.type == 32 )
    {
        return false;
    }
    
    return true;
}

// Namespace doa_pickups
// Params 1
// Checksum 0x84a74c17, Offset: 0x8ef0
// Size: 0x7a, Type: bool
function function_fd16eeab( type )
{
    if ( type == 32 )
    {
        return true;
    }
    
    if ( type == 5 )
    {
        return true;
    }
    
    if ( type == 23 || type == 27 || type == 36 )
    {
        return true;
    }
    
    if ( type == 26 )
    {
        return true;
    }
    
    return false;
}

// Namespace doa_pickups
// Params 0, eflags: 0x4
// Checksum 0x448e66fb, Offset: 0x8f78
// Size: 0x154, Type: bool
function private function_f56a2ab()
{
    if ( self.def.type == 32 )
    {
        return true;
    }
    
    if ( self.def.type == 5 )
    {
        self thread doa_chicken::function_cdfa9ce8( self );
        self.angles = ( 0, 0, 0 );
        return true;
    }
    
    if ( self.def.type == 23 || self.def.type == 27 || self.def.type == 36 )
    {
        self thread doa_chicken::function_7b8c015c();
        self.var_71bbb00a = &doa_chicken::function_d63bdb9;
        return true;
    }
    
    if ( self.def.type == 26 )
    {
        self clientfield::set( "heartbeat", 1 );
        self.var_71bbb00a = &function_2e7c9798;
        self hide();
        return true;
    }
    
    return false;
}

// Namespace doa_pickups
// Params 1, eflags: 0x4
// Checksum 0xd8648516, Offset: 0x90d8
// Size: 0x3be
function private function_5441452b( maxdistsq )
{
    self notify( #"pickup_ForceAttractKill" );
    self endon( #"pickup_ForceAttractKill" );
    self endon( #"picked_up" );
    self endon( #"death" );
    
    while ( true )
    {
        wait 0.05;
        
        if ( isdefined( self.var_3033320e ) && self.attractors.size == 0 && self.var_3033320e )
        {
            if ( self.origin[ 0 ] != self.var_18193c2a[ 0 ] || self.origin[ 1 ] != self.var_18193c2a[ 1 ] )
            {
                trace = bullettrace( self.origin, self.origin + ( 0, 0, -500 ), 0, undefined );
                self.groundpos = ( self.origin[ 0 ], self.origin[ 1 ], trace[ "position" ][ 2 ] ) + ( 0, 0, 32 );
                self moveto( self.groundpos, 1 );
                self util::waittill_any_timeout( 1.1, "movedone", "picked_up", "pickup_ForceAttractKill", "death" );
                self.var_18193c2a = self.origin;
                self.var_3033320e = undefined;
            }
            
            continue;
        }
        
        forcemag = isdefined( self.forcemag ) ? self.forcemag : 10;
        var_119472f5 = isdefined( maxdistsq ) ? maxdistsq : level.doa.rules.var_eb81beeb;
        
        foreach ( force in self.attractors )
        {
            if ( !isdefined( force ) )
            {
                continue;
            }
            
            distsq = distancesquared( self.origin, force.origin );
            
            if ( distsq > var_119472f5 )
            {
                continue;
            }
            
            if ( isdefined( force.var_262e30aa ) )
            {
                origin = force.origin + force.var_262e30aa;
            }
            else
            {
                origin = force.origin;
            }
            
            var_ad2b0f07 = vectornormalize( origin - self.origin );
            scale = ( var_119472f5 - distsq ) / var_119472f5;
            movevec = vectorscale( var_ad2b0f07, forcemag * scale );
            self.origin += movevec;
            self.var_3033320e = 1;
        }
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0x40ea4b65, Offset: 0x94a0
// Size: 0x2c8
function function_b33393b3()
{
    self notify( #"hash_c8c0fb8f" );
    self endon( #"hash_c8c0fb8f" );
    self endon( #"picked_up" );
    self endon( #"death" );
    self thread function_5441452b();
    
    if ( isdefined( self.var_25e9e2fe ) )
    {
        self [[ self.var_25e9e2fe ]]();
    }
    
    while ( true )
    {
        self.attractors = [];
        
        if ( isdefined( self.var_77ebedb ) )
        {
            self [[ self.var_77ebedb ]]();
        }
        
        if ( function_295872fa( self ) )
        {
            foreach ( player in doa_player_utility::function_5eb6e4d1() )
            {
                if ( !isdefined( player.doa.var_3df27425 ) )
                {
                    continue;
                }
                
                distsq = distancesquared( player.origin, self.origin );
                
                if ( distsq < level.doa.rules.var_eb81beeb )
                {
                    self.attractors[ self.attractors.size ] = player;
                }
            }
        }
        
        foreach ( hazard in level.doa.hazards )
        {
            if ( !isdefined( hazard ) )
            {
                continue;
            }
            
            if ( isdefined( hazard.var_1a563349 ) && hazard.var_1a563349 )
            {
                distsq = distancesquared( hazard.origin, self.origin );
                
                if ( distsq < level.doa.rules.var_eb81beeb )
                {
                    self.attractors[ self.attractors.size ] = hazard;
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace doa_pickups
// Params 1
// Checksum 0x48ca9549, Offset: 0x9770
// Size: 0xac, Type: bool
function function_295872fa( pickup )
{
    if ( isdefined( pickup.def.uber ) && pickup.def.uber )
    {
        return false;
    }
    
    if ( pickup.type == 1 || pickup.type == 10 || pickup.type == 12 || pickup.type == 32 )
    {
        return true;
    }
    
    return false;
}

// Namespace doa_pickups
// Params 3
// Checksum 0x955706b5, Offset: 0x9828
// Size: 0x1f6
function function_411355c0( type, player, origin )
{
    foreach ( guardian in level.doa.guardians )
    {
        if ( guardian.type == type )
        {
            var_f3cefb9b = guardian;
            break;
        }
    }
    
    if ( !isdefined( var_f3cefb9b ) )
    {
        return;
    }
    
    loc = spawnstruct();
    loc.angles = player.angles;
    loc.origin = origin;
    ai = [[ var_f3cefb9b.spawnfunction ]]( var_f3cefb9b.spawner, loc );
    
    if ( isdefined( ai ) )
    {
        ai.setgoaloverridecb = &doa_enemy::function_d30fe558;
        ai thread function_9908c4ec();
        ai notify( #"hash_6e8326fc" );
        ai notify( #"hash_6dcbb83e" );
        ai notify( #"hash_67a97d62" );
        ai thread [[ var_f3cefb9b.initfunction ]]( player );
        level.doa.var_1332e37a[ level.doa.var_1332e37a.size ] = ai;
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0xcba41dcc, Offset: 0x9a28
// Size: 0x6c
function function_9908c4ec()
{
    self waittill( #"death" );
    
    if ( !isdefined( level.doa.var_1332e37a ) )
    {
        level.doa.var_1332e37a = [];
    }
    
    level.doa.var_1332e37a = array::remove_undefined( level.doa.var_1332e37a );
}

// Namespace doa_pickups
// Params 1
// Checksum 0xf6043aeb, Offset: 0x9aa0
// Size: 0x2ac
function function_fce74a5f( heart )
{
    zombies = arraycombine( getaispeciesarray( "axis", "human" ), arraycombine( getaispeciesarray( "axis", "zombie" ), getaispeciesarray( "axis", "dog" ), 0, 0 ), 0, 0 );
    var_39339143 = 0;
    
    foreach ( mf in zombies )
    {
        if ( !isdefined( mf ) )
        {
            continue;
        }
        
        if ( isdefined( mf.boss ) && mf.boss )
        {
            continue;
        }
        
        if ( !( isdefined( mf.isdog ) && mf.isdog ) )
        {
            mf doa_gib::function_45dffa6b( ( 0, 0, 100 ) );
            gibserverutils::gibhead( mf );
            gibserverutils::giblegs( mf );
            
            if ( math::cointoss() )
            {
                gibserverutils::gibrightarm( mf );
            }
            else
            {
                gibserverutils::gibleftarm( mf );
            }
            
            assert( !( isdefined( mf.boss ) && mf.boss ) );
        }
        
        mf thread doa_utility::function_ba30b321( 0.25 );
        var_39339143++;
        
        if ( var_39339143 == 4 )
        {
            var_39339143 = 0;
            wait 0.05;
        }
    }
    
    if ( isdefined( heart ) )
    {
        heart delete();
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0x91b9cb36, Offset: 0x9d58
// Size: 0x1cc
function function_2e7c9798()
{
    self endon( #"death" );
    wait level.doa.rules.powerup_timeout + randomfloatrange( 0, 5 );
    self clientfield::set( "heartbeat", 2 );
    
    for ( i = 0; i < 40 ; i++ )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        if ( i == 10 )
        {
            self clientfield::set( "heartbeat", 3 );
        }
        
        if ( i == 20 )
        {
            self clientfield::set( "heartbeat", 4 );
        }
        
        if ( i == 30 )
        {
            self clientfield::set( "heartbeat", 5 );
        }
        
        if ( i < 15 )
        {
            wait 0.5;
        }
        else if ( i < 25 )
        {
            wait 0.25;
        }
        else
        {
            wait 0.1;
        }
        
        util::wait_network_frame();
    }
    
    self notify( #"pickup_timeout" );
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.trigger ) )
        {
            self.trigger delete();
        }
        
        self delete();
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0x88724e57, Offset: 0x9f30
// Size: 0x24
function function_5c21c936()
{
    self.origin += ( 0, 0, -12 );
}

// Namespace doa_pickups
// Params 1
// Checksum 0x379e828c, Offset: 0x9f60
// Size: 0x58
function function_76a2dd5c( def )
{
    def.var_500db33e = array( 4, 7, 8, 12, 13, 16, 20, 25, 29, 40, 60 );
}

// Namespace doa_pickups
// Params 1
// Checksum 0xea3ba267, Offset: 0x9fc0
// Size: 0x40
function function_644e08c5( def )
{
    def.var_500db33e = array( 65, 72, 88, 119, 135 );
}

// Namespace doa_pickups
// Params 0
// Checksum 0xe2413ae0, Offset: 0xa008
// Size: 0x32
function function_d0397bc7()
{
    switch ( self.type )
    {
        case 31:
            break;
        case 30:
            break;
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0x27453f81, Offset: 0xa048
// Size: 0x1bc
function function_db3e0155()
{
    self.var_25e9e2fe = &function_a40895ab;
    self.var_77ebedb = &function_b62ed8c1;
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    self.trigger = function_c5bc781( self.origin, 24 );
    
    if ( !isdefined( self.trigger ) )
    {
        self delete();
        return;
    }
    
    self.trigger enablelinkto();
    self.trigger linkto( self );
    self notify( #"hash_c8c0fb8f" );
    self thread function_d526f0bb();
    self thread function_b33393b3();
    self.forcemag = 20;
    scale = randomfloatrange( 0.5, 1.5 );
    self.var_25ffdef1 = scale;
    self thread pickupscale( scale );
    self.angles = ( randomint( 360 ), randomint( 360 ), randomint( 360 ) );
}

// Namespace doa_pickups
// Params 0
// Checksum 0xe8af0123, Offset: 0xa210
// Size: 0x3c
function function_a40895ab()
{
    self notify( #"pickup_ForceAttractKill" );
    self thread function_5441452b( level.doa.rules.var_6a4387bb );
}

// Namespace doa_pickups
// Params 0
// Checksum 0xf6b215b7, Offset: 0xa258
// Size: 0x114
function function_b62ed8c1()
{
    self.attractors = [];
    
    foreach ( player in doa_player_utility::function_5eb6e4d1() )
    {
        distsq = distancesquared( player.origin, self.origin );
        
        if ( distsq < level.doa.rules.var_6a4387bb )
        {
            if ( !isinarray( self.attractors, player ) )
            {
                self.attractors[ self.attractors.size ] = player;
            }
        }
    }
}

// Namespace doa_pickups
// Params 0
// Checksum 0x4db81fbd, Offset: 0xa378
// Size: 0xcc
function function_322262ea()
{
    self notify( #"hash_322262ea" );
    self endon( #"hash_322262ea" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self ) || !isdefined( self.doa ) || !isdefined( self.doa.var_c2b9d7d0 ) )
    {
        return;
    }
    
    self thread doa_fx::function_285a2999( "ammo_infinite" );
    
    while ( isdefined( self ) && self.doa.var_c2b9d7d0 > gettime() )
    {
        wait 0.25;
    }
    
    if ( isdefined( self ) )
    {
        self thread doa_fx::turnofffx( "ammo_infinite" );
    }
}

