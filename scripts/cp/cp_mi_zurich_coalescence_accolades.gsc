#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace namespace_e9d9fb34;

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x646e98c, Offset: 0x580
// Size: 0x2cc
function function_4d39a2af()
{
    accolades::register( "MISSION_ZURICH_UNTOUCHED" );
    accolades::register( "MISSION_ZURICH_SCORE" );
    accolades::register( "MISSION_ZURICH_COLLECTIBLE" );
    accolades::register( "MISSION_ZURICH_CHALLENGE3", "got_m_all" );
    accolades::register( "MISSION_ZURICH_CHALLENGE4", "hand_cannon" );
    accolades::register( "MISSION_ZURICH_CHALLENGE5", "why_u_cry" );
    accolades::register( "MISSION_ZURICH_CHALLENGE6", "robo_slapper" );
    accolades::register( "MISSION_ZURICH_CHALLENGE7", "exp_entertainment" );
    accolades::register( "MISSION_ZURICH_CHALLENGE8", "raps_fan" );
    accolades::register( "MISSION_ZURICH_CHALLENGE9", "2_kills_1_shot" );
    accolades::register( "MISSION_ZURICH_CHALLENGE10", "quick_slap" );
    accolades::register( "MISSION_ZURICH_CHALLENGE11", "container_destroyed" );
    accolades::register( "MISSION_ZURICH_CHALLENGE12", "perfect_timing" );
    accolades::register( "MISSION_ZURICH_CHALLENGE13", "dodge_this" );
    accolades::register( "MISSION_ZURICH_CHALLENGE14", "bots_go_boom" );
    accolades::register( "MISSION_ZURICH_CHALLENGE15", "clip_their_wings" );
    callback::on_spawned( &function_b75a0f7 );
    function_53d8882b();
    function_11f62094();
    function_d116d4ed();
    function_8c0cbe3e();
    function_e06c631f();
    function_5384b888();
    function_996c3f92();
    function_131f8d11();
    function_8dec7f28();
    function_605fefbf();
    function_6e040346();
    function_4b53d895();
}

// Namespace namespace_e9d9fb34
// Params 2
// Checksum 0x2fb12f0d, Offset: 0x858
// Size: 0xa6
function function_c27610f9( var_8e087689, var_70b01bd3 )
{
    foreach ( player in level.activeplayers )
    {
        player notify( var_8e087689 );
    }
    
    if ( isdefined( var_70b01bd3 ) )
    {
        [[ var_70b01bd3 ]]();
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x52560edf, Offset: 0x908
// Size: 0xcc
function function_b75a0f7()
{
    self.var_e2f09ac4 = 0;
    self.var_11b787d4 = util::new_timer( 10 );
    self.var_4d964e27 = undefined;
    self.var_5d4efbf2 = 0;
    self.var_dd160974 = undefined;
    self.var_f4415abf = 0;
    self.var_3e18c869 = util::new_timer( 10 );
    self.var_6d525c8b = 0;
    self.var_bbb7a4e5 = util::new_timer( 5 );
    self thread function_17c6bcd0();
    self function_ec61897e();
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0xd6e141b9, Offset: 0x9e0
// Size: 0xba
function function_3dc86a1( params )
{
    if ( params.weapon.type == "melee" )
    {
        return 1;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE_WEAPON_BUTT" )
    {
        return 1;
    }
    
    if ( params.weapon.name == "hero_gravity_spikes_cyebercom" )
    {
        return 1;
    }
    
    if ( params.weapon.name == "hero_gravity_spikes_cyebercom_upgraded" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0xbb8e808d, Offset: 0xaa8
// Size: 0x106
function function_dd0b5d28( params )
{
    if ( params.weapon.type == "projectile" )
    {
        return 1;
    }
    
    if ( params.smeansofdeath == "MOD_EXPLOSIVE" || params.smeansofdeath === "MOD_EXPLOSIVE_SPLASH" || params.smeansofdeath == "MOD_GRENADE" || params.smeansofdeath === "MOD_GRENADE_SPLASH" )
    {
        return 1;
    }
    
    if ( params.weapon.name == "spike_charge" || params.weapon.name == "spike_launcher" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0xd0a1ce3e, Offset: 0xbb8
// Size: 0x4c
function function_62b0213a()
{
    trigger::wait_till( "stop_depth_charges" );
    
    if ( !( isdefined( level.var_e83d53e9 ) && level.var_e83d53e9 ) )
    {
        function_c27610f9( "got_m_all" );
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0xd5a536, Offset: 0xc10
// Size: 0x2c
function function_53d8882b()
{
    spawner::add_archetype_spawn_function( "siegebot", &function_d7b4afc8 );
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x96efdca8, Offset: 0xc48
// Size: 0x44
function function_d7b4afc8()
{
    self endon( #"death" );
    callback::on_vehicle_damage( &function_ce871b4e );
    self thread function_793c2b3f();
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0x896c668e, Offset: 0xc98
// Size: 0x5e
function function_ce871b4e( params )
{
    if ( isplayer( params.eattacker ) && params.weapon.weapclass != "pistol" )
    {
        self notify( #"hash_cf910502" );
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0xbb76d92b, Offset: 0xd00
// Size: 0xac
function function_793c2b3f()
{
    self endon( #"hash_cf910502" );
    self waittill( #"death", eattacker, damagefromunderneath, weapon, point, dir );
    
    if ( isdefined( weapon ) && isplayer( eattacker ) && weapon.weapclass === "pistol" )
    {
        function_c27610f9( "hand_cannon" );
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0xeb612d4, Offset: 0xdb8
// Size: 0x24
function function_11f62094()
{
    callback::on_actor_killed( &function_90ece8b9 );
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0xfe911fc8, Offset: 0xde8
// Size: 0x24
function function_ee6a5a6a()
{
    callback::remove_on_actor_killed( &function_90ece8b9 );
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0x8c5029dc, Offset: 0xe18
// Size: 0x8c
function function_90ece8b9( params )
{
    if ( !( self.archetype === "robot" ) || !isplayer( params.eattacker ) )
    {
        return;
    }
    
    if ( params.weapon.weapclass === "turret" )
    {
        level accolades::increment( "MISSION_ZURICH_CHALLENGE5" );
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0xfc782734, Offset: 0xeb0
// Size: 0x3c
function function_d116d4ed()
{
    callback::on_actor_killed( &function_b6ef6322 );
    level thread function_cdb4b3f7();
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0xa6d2409b, Offset: 0xef8
// Size: 0x34
function function_cdb4b3f7()
{
    level waittill( #"hash_52e251bc" );
    callback::remove_on_actor_killed( &function_b6ef6322 );
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0xbbc50e4c, Offset: 0xf38
// Size: 0x1b4
function function_b6ef6322( params )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( isdefined( function_3dc86a1( params ) ) && self.archetype === "robot" && function_3dc86a1( params ) )
        {
            if ( params.eattacker.var_e2f09ac4 === 0 )
            {
                params.eattacker.var_11b787d4 = util::new_timer( 10 );
                params.eattacker.var_e2f09ac4++;
                return;
            }
            
            params.eattacker.var_e2f09ac4++;
            
            if ( params.eattacker.var_e2f09ac4 >= 5 && params.eattacker.var_11b787d4 util::get_time_left() > 0 )
            {
                params.eattacker notify( #"robo_slapper" );
                return;
            }
            
            if ( params.eattacker.var_11b787d4 util::get_time_left() <= 0 )
            {
                params.eattacker.var_e2f09ac4 = 0;
            }
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x8e2d90e3, Offset: 0x10f8
// Size: 0x24
function function_17c6bcd0()
{
    self.var_1191fe8d = 0;
    self.var_87550951 = undefined;
    self.var_56a9030 = 0;
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x186e8310, Offset: 0x1128
// Size: 0x24
function function_8c0cbe3e()
{
    callback::on_actor_killed( &function_dcf1dd8b );
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0x40dd327c, Offset: 0x1158
// Size: 0x17c
function function_dcf1dd8b( params )
{
    if ( self.team === "allies" )
    {
        return;
    }
    
    if ( isplayer( params.eattacker ) && params.eattacker.var_56a9030 === 0 )
    {
        if ( isdefined( params.weapon ) )
        {
            if ( isdefined( function_dd0b5d28( params ) ) && function_dd0b5d28( params ) )
            {
                if ( params.einflictor !== params.eattacker.var_87550951 )
                {
                    params.eattacker.var_1191fe8d = 0;
                    params.eattacker.var_87550951 = params.einflictor;
                }
                
                params.eattacker.var_1191fe8d++;
                
                if ( params.eattacker.var_1191fe8d >= 3 )
                {
                    params.eattacker notify( #"exp_entertainment" );
                    params.eattacker.var_56a9030 = 1;
                }
            }
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x54f49006, Offset: 0x12e0
// Size: 0x4c
function function_e06c631f()
{
    spawner::add_archetype_spawn_function( "raps", &function_2c0e41ab );
    level.n_raps_alive = 0;
    level thread function_748a64c5();
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0xb726d164, Offset: 0x1338
// Size: 0x5c
function function_748a64c5()
{
    level util::waittill_any( "accolade_8_raps_check", "friendly_raps_damaged" );
    
    if ( !( isdefined( level.var_aead8b98 ) && level.var_aead8b98 ) )
    {
        function_c27610f9( "raps_fan" );
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x10cfe4a7, Offset: 0x13a0
// Size: 0x70
function function_2c0e41ab()
{
    if ( isdefined( level.var_aead8b98 ) && level.var_aead8b98 )
    {
        return;
    }
    
    self thread function_b6f90f();
    level.n_raps_alive++;
    
    if ( !( isdefined( level.var_ebd2f83b ) && level.var_ebd2f83b ) )
    {
        level thread function_6b2c4236();
        level.var_ebd2f83b = 1;
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0xfa8936ec, Offset: 0x1418
// Size: 0x6a
function function_b6f90f()
{
    self waittill( #"death", eattacker, damagefromunderneath, weapon, point, dir );
    level.n_raps_alive--;
    
    if ( level.n_raps_alive <= 0 )
    {
        level.var_ebd2f83b = undefined;
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0xf82c28, Offset: 0x1490
// Size: 0x4c
function function_6b2c4236()
{
    var_b97ed523 = getaiteamarray( "allies" );
    array::thread_all( var_b97ed523, &function_99009628 );
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x1448c4f3, Offset: 0x14e8
// Size: 0x8e
function function_99009628()
{
    self endon( #"death" );
    self waittill( #"damage", n_damage, eattacker, v_direction, v_point, s_type );
    
    if ( eattacker.archetype === "raps" )
    {
        level.var_aead8b98 = 1;
        level notify( #"friendly_raps_damaged" );
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x5eca35e8, Offset: 0x1580
// Size: 0x24
function function_5384b888()
{
    callback::on_ai_killed( &function_590aa5a5 );
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x61870e41, Offset: 0x15b0
// Size: 0x24
function function_956d1e2e()
{
    callback::on_ai_killed( &function_590aa5a5 );
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x80453875, Offset: 0x15e0
// Size: 0xe
function function_ec61897e()
{
    self.var_c8397fe4 = undefined;
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0x11c023ca, Offset: 0x15f8
// Size: 0x19c
function function_590aa5a5( params )
{
    if ( self.team === "allies" )
    {
        return;
    }
    
    if ( isplayer( params.eattacker ) && params.eattacker.var_5d4efbf2 === 0 )
    {
        if ( params.smeansofdeath == "MOD_PISTOL_BULLET" || isdefined( params.weapon ) && !issubstr( params.weapon.name, "turret" ) && params.smeansofdeath == "MOD_RIFLE_BULLET" )
        {
            if ( isdefined( params.eattacker.var_c8397fe4 ) )
            {
                if ( params.eattacker.var_c8397fe4 == params.eattacker._bbdata[ "shots" ] )
                {
                    params.eattacker notify( #"2_kills_1_shot" );
                    params.eattacker.var_5d4efbf2 = 1;
                }
            }
            
            params.eattacker.var_c8397fe4 = params.eattacker._bbdata[ "shots" ];
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x4b22213c, Offset: 0x17a0
// Size: 0x3c
function function_996c3f92()
{
    callback::on_actor_killed( &function_fa041c17 );
    level thread function_1b5b3a2c();
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x747919bc, Offset: 0x17e8
// Size: 0x34
function function_1b5b3a2c()
{
    level waittill( #"singapore_root_completed" );
    callback::remove_on_actor_killed( &function_fa041c17 );
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0x9fa0960f, Offset: 0x1828
// Size: 0x214
function function_fa041c17( params )
{
    if ( self.team === "allies" )
    {
        return;
    }
    
    if ( isplayer( params.eattacker ) )
    {
        if ( isdefined( function_3dc86a1( params ) ) && ( self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined( self.archetype ) && self.archetype == "civilian" ) && function_3dc86a1( params ) )
        {
            if ( params.eattacker.var_f4415abf === 0 )
            {
                params.eattacker.var_3e18c869 = util::new_timer( 10 );
                params.eattacker.var_f4415abf++;
                return;
            }
            
            params.eattacker.var_f4415abf++;
            
            if ( params.eattacker.var_f4415abf >= 5 && params.eattacker.var_3e18c869 util::get_time_left() > 0 )
            {
                params.eattacker notify( #"quick_slap" );
                return;
            }
            
            if ( params.eattacker.var_3e18c869 util::get_time_left() <= 0 )
            {
                params.eattacker.var_f4415abf = 0;
            }
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x8a3542e, Offset: 0x1a48
// Size: 0xda
function function_131f8d11()
{
    var_1a69ce4d = getentarray( "destructible", "targetname" );
    
    foreach ( var_6ee6e2fe in var_1a69ce4d )
    {
        if ( issubstr( var_6ee6e2fe.destructibledef, "p7_dest_explosive_" ) )
        {
            var_6ee6e2fe thread 32403965();
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x49794dfb, Offset: 0x1b30
// Size: 0x74
function 32403965()
{
    level endon( #"accolade_11_complete" );
    self waittill( #"damage", n_damage, eattacker, v_direction, v_point, s_type );
    level accolades::increment( "MISSION_ZURICH_CHALLENGE11" );
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0xda339551, Offset: 0x1bb0
// Size: 0x24
function function_8dec7f28()
{
    callback::on_actor_killed( &function_adff2745 );
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0x4107f0ab, Offset: 0x1be0
// Size: 0x134
function function_adff2745( params )
{
    if ( !( self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined( self.archetype ) && self.archetype == "civilian" ) || !isplayer( params.eattacker ) || self.team == "allies" )
    {
        return;
    }
    
    if ( params.weapon.type === "projectile" && ( params.weapon.type === "grenade" || params.weapon.weapclass === "grenade" ) )
    {
        params.eattacker accolades::increment( "MISSION_ZURICH_CHALLENGE12" );
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x95245015, Offset: 0x1d20
// Size: 0x2c
function function_605fefbf()
{
    spawner::add_archetype_spawn_function( "siegebot", &function_13829246 );
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0x498f7420, Offset: 0x1d58
// Size: 0xaa
function function_13829246( params )
{
    foreach ( player in level.activeplayers )
    {
        player thread function_baf56cfa( self );
        player thread function_b1f08628( self );
    }
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0x930efd76, Offset: 0x1e10
// Size: 0x70
function function_baf56cfa( var_f37c20b3 )
{
    var_f37c20b3 endon( #"death" );
    self endon( #"dodge_this" );
    
    while ( true )
    {
        self waittill( #"damage", damage, eattacker );
        
        if ( eattacker === var_f37c20b3 )
        {
            var_f37c20b3 notify( #"hash_700a2ace" );
        }
    }
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0x92953c50, Offset: 0x1e88
// Size: 0x8a
function function_b1f08628( var_f37c20b3 )
{
    var_f37c20b3 endon( #"hash_700a2ace" );
    var_f37c20b3 waittill( #"death", eattacker, damagefromunderneath, weapon, point, dir );
    
    if ( isplayer( eattacker ) )
    {
        self notify( #"dodge_this" );
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x90962de, Offset: 0x1f20
// Size: 0x24
function function_6e040346()
{
    callback::on_actor_killed( &function_61fa3273 );
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0x6056e480, Offset: 0x1f50
// Size: 0xcc
function function_61fa3273( params )
{
    if ( !( self.archetype === "robot" ) || !isplayer( params.eattacker ) )
    {
        return;
    }
    
    if ( params.smeansofdeath == "MOD_GRENADE" || params.weapon.name === "hero_pineapplegun" && params.smeansofdeath == "MOD_GRENADE_SPLASH" )
    {
        params.eattacker accolades::increment( "MISSION_ZURICH_CHALLENGE14" );
    }
}

// Namespace namespace_e9d9fb34
// Params 0
// Checksum 0x3b41f8ae, Offset: 0x2028
// Size: 0x24
function function_4b53d895()
{
    callback::on_actor_killed( &function_3bf7b80a );
}

// Namespace namespace_e9d9fb34
// Params 1
// Checksum 0xf284b164, Offset: 0x2058
// Size: 0x1e4
function function_3bf7b80a( params )
{
    if ( self.team === "allies" )
    {
        return;
    }
    
    if ( isplayer( params.eattacker ) )
    {
        if ( self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined( self.archetype ) && self.archetype == "civilian" )
        {
            if ( params.eattacker.var_6d525c8b === 0 )
            {
                params.eattacker.var_bbb7a4e5 = util::new_timer( 5 );
                params.eattacker.var_6d525c8b++;
                return;
            }
            
            params.eattacker.var_6d525c8b++;
            
            if ( params.eattacker.var_6d525c8b >= 3 && params.eattacker.var_bbb7a4e5 util::get_time_left() > 0 )
            {
                params.eattacker notify( #"clip_their_wings" );
                return;
            }
            
            if ( params.eattacker.var_bbb7a4e5 util::get_time_left() <= 0 )
            {
                params.eattacker.var_6d525c8b = 0;
            }
        }
    }
}

