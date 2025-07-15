#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;

#namespace doa_vehicle;

// Namespace doa_vehicle
// Params 0
// Checksum 0x2741869e, Offset: 0x4d8
// Size: 0x124
function init()
{
    level.doa.var_b3040642 = getent( "doa_heli", "targetname" );
    level.doa.var_37219336 = getent( "doa_siegebot", "targetname" );
    level.doa.var_1179f89e = getent( "doa_tank", "targetname" );
    level.doa.var_95dee038 = getent( "doa_rapps", "targetname" );
    level.doa.var_82433985 = getent( "doa_quadtank", "targetname" );
    level.doa.var_32e07142 = getent( "doa_siegechicken", "targetname" );
}

// Namespace doa_vehicle
// Params 2
// Checksum 0x806e5972, Offset: 0x608
// Size: 0x60
function function_254eefd6( player, time )
{
    self endon( #"death" );
    player endon( #"disconnect" );
    player endon( #"hash_d28ba89d" );
    level doa_utility::function_124b9a08();
    wait time;
    player notify( #"hash_d28ba89d" );
}

// Namespace doa_vehicle
// Params 1
// Checksum 0xdd49ba42, Offset: 0x670
// Size: 0x60
function function_ab709357( heli )
{
    self endon( #"doa_playerVehiclePickup" );
    
    while ( isdefined( heli ) )
    {
        self.doa.var_8d2d32e7 = doa_utility::function_1c0abd70( heli.origin, 128, heli );
        wait 0.5;
    }
}

// Namespace doa_vehicle
// Params 2
// Checksum 0x702456ac, Offset: 0x6d8
// Size: 0x404
function function_f27a22c8( player, origin )
{
    if ( isdefined( player.doa.var_52cb4fb9 ) && ( isdefined( player.doa.vehicle ) || player.doa.var_52cb4fb9 ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    player.doa.var_52cb4fb9 = 1;
    player doa_player_utility::function_4519b17( 1 );
    player function_d460de4b();
    level.doa.var_b3040642.count = 999999;
    heli = level.doa.var_b3040642 spawner::spawn( 1 );
    heli thread doa_utility::function_24245456( player, "disconnect" );
    player.doa.var_52cb4fb9 = undefined;
    player.doa.vehicle = heli;
    heli.origin = origin + ( 0, 0, 70 );
    heli.angles = player.angles;
    heli.vehaircraftcollisionenabled = 1;
    heli.health = 9999999;
    heli.team = player.team;
    heli setmodel( "veh_t7_drone_hunter_zombietron_" + doa_player_utility::function_ee495f41( player.entnum ) );
    heli usevehicle( player, 0 );
    heli makeunusable();
    heli setheliheightlock( 1 );
    heli.owner = player;
    heli.playercontrolled = 1;
    heli.var_aaffbea7 = 1;
    player thread function_ab709357( heli );
    heli thread function_254eefd6( player, int( player doa_utility::function_1ded48e6( level.doa.rules.var_cd899ae7 ) ) );
    player waittill( #"hash_d28ba89d" );
    player notify( #"doa_playerVehiclePickup" );
    
    if ( isdefined( heli ) )
    {
        heli makeusable();
        var_85f85940 = heli.origin;
        
        if ( isdefined( player ) )
        {
            heli usevehicle( player, 0 );
        }
        
        heli makeunusable();
    }
    
    if ( isdefined( player ) )
    {
        player thread function_3b1b644d( var_85f85940, heli );
        return;
    }
    
    heli delete();
}

// Namespace doa_vehicle
// Params 0
// Checksum 0x34f2aa82, Offset: 0xae8
// Size: 0x60
function function_db948b3()
{
    self endon( #"death" );
    
    while ( true )
    {
        pos = self getgunnertargetvec( 0 );
        self setgunnertargetvec( pos, 1 );
        wait 0.05;
    }
}

// Namespace doa_vehicle
// Params 0
// Checksum 0x79dbd678, Offset: 0xb50
// Size: 0x84
function function_569d8fe3()
{
    self endon( #"death" );
    projweapon = self seatgetweapon( 2 );
    
    while ( true )
    {
        if ( self isgunnerfiring( 0 ) )
        {
            self fireweapon( 2 );
            wait projweapon.firetime;
            continue;
        }
        
        wait 0.05;
    }
}

// Namespace doa_vehicle
// Params 2
// Checksum 0x7279c81f, Offset: 0xbe0
// Size: 0xe0
function function_ee6962d9( player, chicken )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_e15b53df" );
        
        if ( !level flag::get( "doa_round_active" ) )
        {
            continue;
        }
        
        spot = chicken gettagorigin( "tail" ) + ( 0, 0, -32 );
        chicken thread doa_sound::function_90118d8c( "zmb_golden_chicken_pop" );
        level doa_pickups::function_3238133b( level.doa.var_43922ff2, spot, 1 );
    }
}

// Namespace doa_vehicle
// Params 2
// Checksum 0x21ec7617, Offset: 0xcc8
// Size: 0x604
function function_2ef99744( player, origin )
{
    if ( isdefined( player.doa.var_52cb4fb9 ) && ( !isdefined( player ) || isdefined( player.doa.vehicle ) || player.doa.var_52cb4fb9 ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    player.doa.var_52cb4fb9 = 1;
    player doa_player_utility::function_4519b17( 1 );
    player function_d460de4b();
    level.doa.var_32e07142.count = 99999;
    siegebot = level.doa.var_32e07142 spawner::spawn( 1 );
    chicken = spawn( "script_model", origin );
    chicken.targetname = "fidoMech";
    chicken setmodel( "zombietron_anim_chicken_nolegs" );
    chicken enablelinkto();
    siegebot thread doa_utility::function_a625b5d3( player );
    chicken thread doa_utility::function_a625b5d3( player );
    chicken thread doa_utility::function_75e76155( siegebot, "death" );
    siegebot thread function_ee6962d9( player, chicken );
    player.doa.var_52cb4fb9 = undefined;
    player.doa.vehicle = siegebot;
    siegebot.origin = origin;
    siegebot.angles = player.angles;
    siegebot.team = player.team;
    siegebot.owner = player;
    siegebot.playercontrolled = 1;
    siegebot usevehicle( player, 0 );
    siegebot makeunusable();
    chicken linkto( siegebot, "tag_driver", ( 0, 0, -70 ), ( 0, -120, 0 ) );
    siegebot.health = 9999999;
    siegebot hidepart( "tag_turret", "", 1 );
    siegebot hidepart( "tag_nameplate", "", 1 );
    siegebot hidepart( "tag_turret_canopy_animate", "", 1 );
    siegebot hidepart( "tag_light_attach_left", "", 1 );
    siegebot hidepart( "tag_light_attach_right", "", 1 );
    siegebot thread function_cdfa9ce8( chicken );
    siegebot thread function_db948b3();
    player notify( #"doa_playerVehiclePickup" );
    var_523635a2 = 1;
    
    if ( player.doa.fate == 2 )
    {
        var_523635a2 = level.doa.rules.var_f2d5f54d;
    }
    else if ( player.doa.fate == 11 )
    {
        var_523635a2 = level.doa.rules.var_b3d39edc;
    }
    
    siegebot thread function_254eefd6( player, int( player doa_utility::function_1ded48e6( level.doa.rules.var_13276655, var_523635a2 ) ) );
    player waittill( #"hash_d28ba89d" );
    
    if ( isdefined( siegebot ) )
    {
        var_85f85940 = siegebot.origin;
        siegebot makeusable();
        
        if ( isdefined( player ) )
        {
            siegebot usevehicle( player, 0 );
        }
        
        siegebot makeunusable();
    }
    
    if ( isdefined( player ) )
    {
        player thread function_3b1b644d( var_85f85940, siegebot );
    }
    else
    {
        siegebot delete();
    }
    
    chicken delete();
}

// Namespace doa_vehicle
// Params 2
// Checksum 0xe2d7db70, Offset: 0x12d8
// Size: 0x454
function function_21af9396( player, origin )
{
    if ( isdefined( player.doa.var_52cb4fb9 ) && ( !isdefined( player ) || isdefined( player.doa.vehicle ) || player.doa.var_52cb4fb9 ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    player.doa.var_52cb4fb9 = 1;
    player doa_player_utility::function_4519b17( 1 );
    player function_d460de4b();
    level.doa.var_37219336.count = 99999;
    siegebot = level.doa.var_37219336 spawner::spawn( 1 );
    siegebot thread doa_utility::function_24245456( player, "disconnect" );
    player.doa.var_52cb4fb9 = undefined;
    player.doa.vehicle = siegebot;
    siegebot.origin = origin;
    siegebot.angles = player.angles;
    siegebot.team = player.team;
    siegebot.owner = player;
    siegebot.playercontrolled = 1;
    siegebot setmodel( "zombietron_siegebot_mini_" + doa_player_utility::function_ee495f41( player.entnum ) );
    siegebot usevehicle( player, 0 );
    siegebot makeunusable();
    siegebot.health = 9999999;
    siegebot thread function_db948b3();
    player notify( #"doa_playerVehiclePickup" );
    var_523635a2 = 1;
    
    if ( player.doa.fate == 2 )
    {
        var_523635a2 = level.doa.rules.var_f2d5f54d;
    }
    else if ( player.doa.fate == 11 )
    {
        var_523635a2 = level.doa.rules.var_b3d39edc;
    }
    
    siegebot thread function_254eefd6( player, int( player doa_utility::function_1ded48e6( level.doa.rules.var_91e6add5, var_523635a2 ) ) );
    player waittill( #"hash_d28ba89d" );
    
    if ( isdefined( siegebot ) )
    {
        var_85f85940 = siegebot.origin;
        siegebot makeusable();
        
        if ( isdefined( player ) )
        {
            siegebot usevehicle( player, 0 );
        }
        
        siegebot makeunusable();
    }
    
    if ( isdefined( player ) )
    {
        player thread function_3b1b644d( var_85f85940, siegebot );
        return;
    }
    
    siegebot delete();
}

// Namespace doa_vehicle
// Params 2
// Checksum 0xa3dda49c, Offset: 0x1738
// Size: 0x39c
function function_1e663abe( player, origin )
{
    if ( isdefined( player.doa.var_52cb4fb9 ) && ( isdefined( player.doa.vehicle ) || player.doa.var_52cb4fb9 ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    player.doa.var_52cb4fb9 = 1;
    player doa_player_utility::function_4519b17( 1 );
    player function_d460de4b();
    var_e34a8df9 = level.doa.var_95dee038 spawner::spawn( 1 );
    var_e34a8df9 thread doa_utility::function_24245456( player, "disconnect" );
    player.doa.var_52cb4fb9 = undefined;
    player.doa.vehicle = var_e34a8df9;
    var_e34a8df9.origin = origin;
    var_e34a8df9.angles = player.angles;
    var_e34a8df9.team = player.team;
    var_e34a8df9.playercontrolled = 1;
    var_e34a8df9 setmodel( "veh_t7_drone_raps_zombietron_" + doa_player_utility::function_ee495f41( player.entnum ) );
    var_e34a8df9.owner = player;
    var_e34a8df9 usevehicle( player, 0 );
    var_e34a8df9 makeunusable();
    var_e34a8df9.health = 9999999;
    player notify( #"doa_playerVehiclePickup" );
    var_e34a8df9 thread function_254eefd6( player, int( player doa_utility::function_1ded48e6( level.doa.rules.var_7196fe3d ) ) );
    player waittill( #"hash_d28ba89d" );
    
    if ( isdefined( var_e34a8df9 ) )
    {
        var_85f85940 = var_e34a8df9.origin;
        
        if ( isdefined( player ) )
        {
            origin = var_e34a8df9.origin;
            var_e34a8df9 makeusable();
            
            if ( isdefined( player ) )
            {
                var_e34a8df9 usevehicle( player, 0 );
            }
            
            var_e34a8df9 makeunusable();
        }
    }
    
    if ( isdefined( player ) )
    {
        player thread function_3b1b644d( var_85f85940, var_e34a8df9 );
        return;
    }
    
    var_e34a8df9 delete();
}

// Namespace doa_vehicle
// Params 2
// Checksum 0xc64d7377, Offset: 0x1ae0
// Size: 0x39c
function function_e9f445ce( player, origin )
{
    if ( isdefined( player.doa.var_52cb4fb9 ) && ( isdefined( player.doa.vehicle ) || player.doa.var_52cb4fb9 ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    player.doa.var_52cb4fb9 = 1;
    player doa_player_utility::function_4519b17( 1 );
    player function_d460de4b();
    var_b22d6040 = level.doa.var_1179f89e spawner::spawn( 1 );
    var_b22d6040 thread doa_utility::function_24245456( player, "disconnect" );
    player.doa.var_52cb4fb9 = undefined;
    player.doa.vehicle = var_b22d6040;
    var_b22d6040.origin = origin;
    var_b22d6040.angles = player.angles;
    var_b22d6040.team = player.team;
    var_b22d6040.playercontrolled = 1;
    var_b22d6040 setmodel( "veh_t7_mil_tank_tiger_zombietron_" + doa_player_utility::function_ee495f41( player.entnum ) );
    var_b22d6040 usevehicle( player, 0 );
    var_b22d6040 makeunusable();
    var_b22d6040.health = 9999999;
    player notify( #"doa_playerVehiclePickup" );
    var_b22d6040.owner = player;
    var_b22d6040 thread function_254eefd6( player, int( player doa_utility::function_1ded48e6( level.doa.rules.var_8b15034d ) ) );
    player waittill( #"hash_d28ba89d" );
    
    if ( isdefined( var_b22d6040 ) )
    {
        var_85f85940 = var_b22d6040.origin;
        
        if ( isdefined( player ) )
        {
            origin = var_b22d6040.origin;
            var_b22d6040 makeusable();
            
            if ( isdefined( player ) )
            {
                var_b22d6040 usevehicle( player, 0 );
            }
            
            var_b22d6040 makeunusable();
        }
    }
    
    if ( isdefined( player ) )
    {
        player thread function_3b1b644d( var_85f85940, var_b22d6040 );
        return;
    }
    
    var_b22d6040 delete();
}

// Namespace doa_vehicle
// Params 0
// Checksum 0x84ac7005, Offset: 0x1e88
// Size: 0xcc
function function_d460de4b()
{
    if ( !isdefined( self ) || !isdefined( self.doa ) )
    {
        return;
    }
    
    self thread doa_player_utility::function_7f33210a();
    self thread doa_player_utility::turnOnFlashlight( 0 );
    self thread doa_fx::turnofffx( "boots" );
    self thread doa_fx::turnofffx( "slow_feet" );
    self.doa.var_c2b9d7d0 = gettime();
    self notify( #"kill_shield" );
    self notify( #"kill_chickens" );
    util::wait_network_frame();
}

// Namespace doa_vehicle
// Params 0
// Checksum 0xf989605b, Offset: 0x1f60
// Size: 0x144
function function_d41a4517()
{
    if ( !isdefined( self ) || !isdefined( self.doa ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    util::wait_network_frame();
    self thread doa_player_utility::turnplayershieldon();
    self thread doa_player_utility::turnOnFlashlight( level.doa.arena_round_number == 3 );
    self thread doa_player_utility::function_b5843d4f( level.doa.arena_round_number == 3 );
    
    if ( isdefined( self.doa.slow_feet ) && isdefined( self.doa ) && self.doa.slow_feet )
    {
        self thread doa_fx::function_285a2999( "slow_feet" );
    }
    
    if ( isdefined( self.doa.fast_feet ) && isdefined( self.doa ) && self.doa.fast_feet )
    {
        self thread doa_fx::function_285a2999( "boots" );
    }
}

// Namespace doa_vehicle
// Params 1
// Checksum 0x6f48d8a4, Offset: 0x20b0
// Size: 0x3c
function function_33f0cca4( player )
{
    self endon( #"death" );
    player waittill( #"disconnect" );
    self delete();
}

// Namespace doa_vehicle
// Params 2
// Checksum 0x7a69a295, Offset: 0x20f8
// Size: 0x212
function function_3b1b644d( var_85f85940, vehicle )
{
    self.doa.var_ccf4ef81 = 1;
    self endon( #"disconnect" );
    vehicle thread function_33f0cca4( self );
    self doa_player_utility::function_4519b17( 1 );
    wait 0.05;
    self.ignoreme = 0;
    self.doa.vehicle = undefined;
    self.doa.var_8d2d32e7 = undefined;
    spot = self doa_utility::function_5bca1086();
    
    if ( isdefined( spot ) )
    {
        trace = bullettrace( spot + ( 0, 0, 48 ), spot + ( 0, 0, -64 ), 0, undefined );
        spot = trace[ "position" ];
        self setorigin( spot );
    }
    else
    {
        self setorigin( var_85f85940 );
    }
    
    self doa_player_utility::function_4519b17( 0 );
    self function_d41a4517();
    
    if ( isdefined( self.doa.infps ) && self.doa.infps )
    {
        self clientfield::increment_to_player( "goFPS" );
    }
    else
    {
        self clientfield::increment_to_player( "controlBinding" );
    }
    
    if ( isdefined( vehicle ) )
    {
        vehicle delete();
    }
    
    self.doa.var_ccf4ef81 = undefined;
}

#using_animtree( "chicken_mech" );

// Namespace doa_vehicle
// Params 1
// Checksum 0xb454709e, Offset: 0x2318
// Size: 0x132
function function_cdfa9ce8( bird )
{
    bird notify( #"hash_cf62504" );
    bird endon( #"hash_cf62504" );
    bird endon( #"death" );
    bird useanimtree( #animtree );
    bird.animation = randomint( 2 ) ? %a_chicken_mech_idle : %a_chicken_mech_lay_egg;
    
    while ( isdefined( bird ) )
    {
        bird clientfield::set( "runsiegechickenanim", 1 );
        wait randomintrange( 1, 5 );
        
        if ( randomint( 100 ) < 15 )
        {
            bird clientfield::set( "runsiegechickenanim", 2 );
            wait 1;
            self notify( #"hash_e15b53df" );
        }
    }
}

