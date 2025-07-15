#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;

#namespace ramses_accolades;

// Namespace ramses_accolades
// Params 0
// Checksum 0x16ea7435, Offset: 0x508
// Size: 0x22c
function function_4d39a2af()
{
    accolades::register( "MISSION_RAMSES_UNTOUCHED" );
    accolades::register( "MISSION_RAMSES_SCORE" );
    accolades::register( "MISSION_RAMSES_COLLECTIBLE" );
    accolades::register( "MISSION_RAMSES_CHALLENGE3", "wasp_melee_kill" );
    accolades::register( "MISSION_RAMSES_CHALLENGE4", "raps_hijack_kill" );
    accolades::register( "MISSION_RAMSES_CHALLENGE5", "jumping_kill" );
    accolades::register( "MISSION_RAMSES_CHALLENGE6", "robot_quick_kills" );
    accolades::register( "MISSION_RAMSES_CHALLENGE7", "raps_midair_kill" );
    accolades::register( "MISSION_RAMSES_CHALLENGE8", "spike_launcher_impale" );
    accolades::register( "MISSION_RAMSES_CHALLENGE9", "spike_launcher_explosion" );
    accolades::register( "MISSION_RAMSES_CHALLENGE10", "billboard_kill" );
    accolades::register( "MISSION_RAMSES_CHALLENGE11", "spike_launcher_impale_long_range" );
    accolades::register( "MISSION_RAMSES_CHALLENGE12", "wasp_hijack_kill" );
    accolades::register( "MISSION_RAMSES_CHALLENGE13", "alley_enemies_killed" );
    accolades::register( "MISSION_RAMSES_CHALLENGE14", "alley_wallrun_kills" );
    accolades::register( "MISSION_RAMSES_CHALLENGE15", "alley_wallrun_melee_kill" );
    accolades::register( "MISSION_RAMSES_CHALLENGE16", "quad_tank_slide" );
    accolades::register( "MISSION_RAMSES_CHALLENGE17", "remote_hijack_variety_kills" );
}

// Namespace ramses_accolades
// Params 2
// Checksum 0xe5c9b3c0, Offset: 0x740
// Size: 0xd6
function function_c27610f9( var_8e087689, var_70b01bd3 )
{
    if ( self == level )
    {
        foreach ( player in level.activeplayers )
        {
            player notify( var_8e087689 );
        }
    }
    else if ( isplayer( self ) )
    {
        self notify( var_8e087689 );
    }
    
    if ( isdefined( var_70b01bd3 ) )
    {
        [[ var_70b01bd3 ]]();
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xa069bce9, Offset: 0x820
// Size: 0x24
function function_43898266()
{
    callback::on_vehicle_killed( &function_4e9ab343 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xf21469cc, Offset: 0x850
// Size: 0x24
function function_15009df0()
{
    callback::remove_on_vehicle_killed( &function_4e9ab343 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0x3d631da1, Offset: 0x880
// Size: 0xcc
function function_4e9ab343( params )
{
    if ( params.smeansofdeath === "MOD_MELEE" || params.smeansofdeath === "MOD_MELEE_ASSASSINATE" || isplayer( params.eattacker ) && params.smeansofdeath === "MOD_MELEE_WEAPON_BUTT" )
    {
        player = params.eattacker;
        
        if ( self.archetype === "wasp" )
        {
            player function_c27610f9( "wasp_melee_kill" );
        }
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x71e30bf8, Offset: 0x958
// Size: 0x24
function function_e1862c87()
{
    callback::on_ai_killed( &function_53a23004 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xff3b8e97, Offset: 0x988
// Size: 0x24
function function_a3c86b3d()
{
    callback::remove_on_ai_killed( &function_53a23004 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0x25a48f72, Offset: 0x9b8
// Size: 0x342
function function_53a23004( params )
{
    if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
        
        if ( !isdefined( player.var_23c05f0a ) )
        {
            player.var_23c05f0a = 0;
        }
        
        if ( isdefined( player.hijacked_vehicle_entity ) && isdefined( player.hijacked_vehicle_entity.archetype ) )
        {
            if ( player.hijacked_vehicle_entity.archetype === "raps" )
            {
                if ( player.var_23c05f0a == 0 )
                {
                    player thread function_aac5b080();
                }
                
                player.var_23c05f0a++;
                
                if ( player.var_23c05f0a >= 2 )
                {
                    if ( self.archetype === "raps" && self !== player.hijacked_vehicle_entity )
                    {
                        player function_c27610f9( "raps_hijack_kill" );
                    }
                }
            }
        }
        
        return;
    }
    
    if ( self.archetype === "raps" && params.eattacker === self )
    {
        foreach ( player in level.activeplayers )
        {
            if ( !isdefined( player.var_23c05f0a ) )
            {
                player.var_23c05f0a = 0;
            }
            
            if ( isdefined( player.hijacked_vehicle_entity ) )
            {
                if ( player.hijacked_vehicle_entity.archetype === "raps" )
                {
                    if ( self !== player.hijacked_vehicle_entity )
                    {
                        if ( player.var_23c05f0a >= 2 )
                        {
                            n_speed = length( player.hijacked_vehicle_entity getvelocity() );
                            
                            if ( n_speed >= 50 )
                            {
                                n_distance_sq = distancesquared( self.origin, player.hijacked_vehicle_entity.origin );
                                
                                if ( n_distance_sq < 14400 )
                                {
                                    player function_c27610f9( "raps_hijack_kill" );
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x3af60898, Offset: 0xd08
// Size: 0x38
function function_aac5b080()
{
    self util::waittill_any( "return_to_body", "death" );
    self.var_23c05f0a = 0;
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xc78ef24c, Offset: 0xd48
// Size: 0x24
function function_6f52c808()
{
    callback::on_ai_killed( &function_91236111 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x3425d524, Offset: 0xd78
// Size: 0x24
function function_b13b2dae()
{
    callback::remove_on_ai_killed( &function_91236111 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0xfb43a70f, Offset: 0xda8
// Size: 0x7c
function function_91236111( params )
{
    if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
        
        if ( !player isonground() )
        {
            player function_c27610f9( "jumping_kill" );
        }
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x82febb85, Offset: 0xe30
// Size: 0x24
function function_7f657f7a()
{
    callback::on_actor_killed( &function_2026df43 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xe5725d4e, Offset: 0xe60
// Size: 0x24
function tank_handleairburst()
{
    callback::remove_on_actor_killed( &function_2026df43 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0xc62d656c, Offset: 0xe90
// Size: 0x174
function function_2026df43( params )
{
    if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
        
        if ( !isdefined( player.var_b6086ab2 ) )
        {
            player.var_b6086ab2 = 0;
        }
        
        if ( self.archetype === "robot" )
        {
            if ( player.var_b6086ab2 == 0 )
            {
                player.var_e0006b82 = util::new_timer( 1 );
                player.var_b6086ab2++;
                return;
            }
            
            player.var_b6086ab2++;
            
            if ( player.var_b6086ab2 >= 5 && player.var_e0006b82 util::get_time_left() > 0 )
            {
                player function_c27610f9( "robot_quick_kills" );
                return;
            }
            
            if ( player.var_e0006b82 util::get_time_left() <= 0 )
            {
                player.var_b6086ab2 = 0;
            }
        }
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x2eb6a8e4, Offset: 0x1010
// Size: 0x24
function function_fec73937()
{
    callback::on_vehicle_killed( &function_19efc118 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x9dd7e1be, Offset: 0x1040
// Size: 0x24
function function_6d6e6d0d()
{
    callback::remove_on_vehicle_killed( &function_19efc118 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0x74dc8575, Offset: 0x1070
// Size: 0x14c
function function_19efc118( params )
{
    if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
        b_falling = 0;
        trace = physicstrace( self.origin + ( 0, 0, self.radius * 2 ), self.origin - ( 0, 0, 500 ), ( -10, -10, -10 ), ( 10, 10, 10 ), self, 2 );
        
        if ( self.origin[ 2 ] - trace[ "position" ][ 2 ] > 8 )
        {
            b_falling = 1;
        }
        
        if ( isdefined( self.is_jumping ) && self.is_jumping || self.archetype === "raps" && b_falling )
        {
            player function_c27610f9( "raps_midair_kill" );
        }
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x21852b8b, Offset: 0x11c8
// Size: 0x24
function function_bb0dee49()
{
    callback::on_actor_killed( &function_b9641d15 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xd185985d, Offset: 0x11f8
// Size: 0x24
function function_4df6d923()
{
    callback::remove_on_actor_killed( &function_b9641d15 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0x464a21df, Offset: 0x1228
// Size: 0x14c
function function_b9641d15( params )
{
    if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
        
        if ( !isdefined( player.var_433bafc6 ) )
        {
            player.var_433bafc6 = 0;
        }
        
        if ( isdefined( params.weapon ) )
        {
            if ( params.weapon.name === "spike_launcher" && params.smeansofdeath === "MOD_IMPACT" )
            {
                level notify( #"enemy_hit_by_spike" );
                
                if ( player.var_433bafc6 === 0 )
                {
                    params.einflictor thread function_940b7b45( player );
                }
                
                player.var_433bafc6++;
            }
            
            if ( player.var_433bafc6 == 2 )
            {
                player function_c27610f9( "spike_launcher_impale" );
            }
        }
    }
}

// Namespace ramses_accolades
// Params 1
// Checksum 0xe7f8583f, Offset: 0x1380
// Size: 0x34
function function_940b7b45( player )
{
    player endon( #"death" );
    self waittill( #"death" );
    player.var_433bafc6 = 0;
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x4cd53c68, Offset: 0x13c0
// Size: 0x24
function function_69c025f8()
{
    callback::on_ai_killed( &function_d44c2ef0 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xee0d678a, Offset: 0x13f0
// Size: 0x24
function function_eb593e7e()
{
    callback::remove_on_ai_killed( &function_d44c2ef0 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0x4dbf0f29, Offset: 0x1420
// Size: 0x1c4
function function_d44c2ef0( params )
{
    if ( isdefined( params.weapon ) && isplayer( params.eattacker ) )
    {
        player = params.eattacker;
        
        if ( !isdefined( player.var_310e9a7d ) )
        {
            player.var_310e9a7d = 0;
        }
        
        if ( params.smeansofdeath === "MOD_EXPLOSIVE" || params.smeansofdeath === "MOD_EXPLOSIVE_SPLASH" || params.smeansofdeath === "MOD_GRENADE" || params.weapon.name === "spike_charge" && params.smeansofdeath === "MOD_GRENADE_SPLASH" )
        {
            if ( player.var_310e9a7d === 0 )
            {
                player thread function_d91eb48d();
            }
            
            player.var_310e9a7d++;
        }
        
        if ( player.var_310e9a7d >= 7 )
        {
            if ( !( isdefined( player.var_20e5f2 ) && player.var_20e5f2 ) )
            {
                player.var_20e5f2 = 1;
                player function_c27610f9( "spike_launcher_explosion" );
            }
        }
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xaf119be1, Offset: 0x15f0
// Size: 0x20
function function_d91eb48d()
{
    self endon( #"death" );
    wait 1;
    self.var_310e9a7d = 0;
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x61f6a5ed, Offset: 0x1618
// Size: 0x24
function function_5553172f()
{
    callback::on_ai_killed( &function_95b934b0 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x662201ab, Offset: 0x1648
// Size: 0x24
function function_a64e00f5()
{
    callback::remove_on_ai_killed( &function_95b934b0 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0x336b34e4, Offset: 0x1678
// Size: 0xac
function function_95b934b0( params )
{
    if ( isdefined( params.einflictor ) && isdefined( params.einflictor.targetname ) )
    {
        if ( params.einflictor.targetname === "arena_billboard" || params.einflictor.targetname === "arena_billboard_02" )
        {
            level function_c27610f9( "billboard_kill", &function_a64e00f5 );
        }
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xcc8bdae0, Offset: 0x1730
// Size: 0x24
function function_cef37178()
{
    callback::on_ai_killed( &function_ab3dab38 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x9d227e4d, Offset: 0x1760
// Size: 0x24
function function_508c89fe()
{
    callback::remove_on_ai_killed( &function_ab3dab38 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0xd44ad74, Offset: 0x1790
// Size: 0x104
function function_ab3dab38( params )
{
    if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
        
        if ( isdefined( params.weapon ) )
        {
            if ( params.weapon.name === "spike_launcher" && params.smeansofdeath === "MOD_IMPACT" )
            {
                var_d3d59692 = distancesquared( player.origin, self.origin );
                
                if ( var_d3d59692 >= 1440000 )
                {
                    player function_c27610f9( "spike_launcher_impale_long_range" );
                }
            }
        }
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xe314feff, Offset: 0x18a0
// Size: 0x24
function function_8e872dc8()
{
    callback::on_ai_killed( &function_86e525b5 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x275da9d1, Offset: 0x18d0
// Size: 0x24
function function_d06f936e()
{
    callback::remove_on_ai_killed( &function_86e525b5 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0xe7f29c72, Offset: 0x1900
// Size: 0xc4
function function_86e525b5( params )
{
    if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
        
        if ( isdefined( player.hijacked_vehicle_entity ) && isdefined( player.hijacked_vehicle_entity.archetype ) )
        {
            if ( player.hijacked_vehicle_entity.archetype === "wasp" )
            {
                player function_c27610f9( "wasp_hijack_kill" );
            }
        }
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x272e0c79, Offset: 0x19d0
// Size: 0x74
function function_17a34ad1()
{
    level.var_c4bb3386 = 0;
    level.var_4c41e902 = 0;
    callback::on_ai_spawned( &function_3fa09dec );
    callback::on_ai_killed( &function_b5b577c9 );
    level thread function_c0e39bcc();
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xc73f2eda, Offset: 0x1a50
// Size: 0x44
function function_cee86b3b()
{
    callback::remove_on_ai_spawned( &function_3fa09dec );
    callback::remove_on_ai_killed( &function_b5b577c9 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x36160e77, Offset: 0x1aa0
// Size: 0x4c
function function_c0e39bcc()
{
    level waittill( #"hash_6f120ac6" );
    
    if ( level.var_c4bb3386 === level.var_4c41e902 )
    {
        level function_c27610f9( "alley_enemies_killed", &function_cee86b3b );
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xc35e2d88, Offset: 0x1af8
// Size: 0x30
function function_3fa09dec()
{
    if ( self getteam() === "axis" )
    {
        level.var_c4bb3386++;
    }
}

// Namespace ramses_accolades
// Params 1
// Checksum 0x9eba6a6c, Offset: 0x1b30
// Size: 0x38
function function_b5b577c9( params )
{
    if ( self getteam() === "axis" )
    {
        level.var_4c41e902++;
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xd3d62ea8, Offset: 0x1b70
// Size: 0x24
function function_3484502e()
{
    callback::on_ai_killed( &function_507d47d2 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x2786c7ce, Offset: 0x1ba0
// Size: 0x24
function function_59132ae8()
{
    callback::remove_on_ai_killed( &function_507d47d2 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0x4fac9b08, Offset: 0x1bd0
// Size: 0x15c
function function_507d47d2( params )
{
    if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
        
        if ( !isdefined( player.var_6f2cedd3 ) )
        {
            player.var_6f2cedd3 = 0;
        }
        
        if ( player iswallrunning() && player.var_6f2cedd3 === 0 )
        {
            player thread function_aad12c7();
            player.var_6f2cedd3++;
        }
        else if ( player iswallrunning() || player.var_6f2cedd3 > 0 && !player isonground() )
        {
            player.var_6f2cedd3++;
        }
        
        if ( player.var_6f2cedd3 >= 3 )
        {
            player function_c27610f9( "alley_wallrun_kills" );
        }
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x9c9a36c1, Offset: 0x1d38
// Size: 0x58
function function_aad12c7()
{
    self endon( #"death" );
    
    while ( self iswallrunning() || !self isonground() )
    {
        wait 0.05;
    }
    
    self.var_6f2cedd3 = 0;
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xc5f16f98, Offset: 0x1d98
// Size: 0xdc
function function_a17fa88e()
{
    callback::on_actor_killed( &function_61c57bec );
    
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            player thread function_caaf5ba9();
        }
    }
    
    callback::on_spawned( &function_fbc946b1 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x4bf91d41, Offset: 0x1e80
// Size: 0xc4
function function_c60e8348()
{
    callback::remove_on_actor_killed( &function_61c57bec );
    
    foreach ( player in level.activeplayers )
    {
        player notify( #"hash_ca0391ab" );
    }
    
    callback::remove_on_spawned( &function_fbc946b1 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0xcdd923b3, Offset: 0x1f50
// Size: 0xdc
function function_61c57bec( params )
{
    if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
        
        if ( isdefined( player.var_56ffc45b ) )
        {
            if ( params.smeansofdeath === "MOD_MELEE" || params.smeansofdeath === "MOD_MELEE_ASSASSINATE" || player.var_56ffc45b && params.smeansofdeath === "MOD_MELEE_WEAPON_BUTT" )
            {
                player function_c27610f9( "alley_wallrun_melee_kill" );
            }
        }
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x9180ad46, Offset: 0x2038
// Size: 0x1c
function function_fbc946b1()
{
    self thread function_caaf5ba9();
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xf24353e9, Offset: 0x2060
// Size: 0xbc
function function_caaf5ba9()
{
    self endon( #"death" );
    self endon( #"hash_ca0391ab" );
    self.var_56ffc45b = 0;
    
    while ( true )
    {
        while ( !self iswallrunning() )
        {
            wait 0.05;
        }
        
        self.var_56ffc45b = 1;
        
        while ( self iswallrunning() )
        {
            wait 0.05;
        }
        
        while ( !self isonground() )
        {
            wait 0.05;
        }
        
        self.var_56ffc45b = 0;
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x47bf2ab6, Offset: 0x2128
// Size: 0x24
function function_f77ccfb1()
{
    callback::on_ai_spawned( &function_1411fbaf );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x5abaf5ce, Offset: 0x2158
// Size: 0x24
function function_84fd481b()
{
    callback::remove_on_ai_spawned( &function_1411fbaf );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x7adb37f0, Offset: 0x2188
// Size: 0x2c
function function_1411fbaf()
{
    if ( self.archetype === "quadtank" )
    {
        self thread function_1dc324f4();
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x13e66dfc, Offset: 0x21c0
// Size: 0x12c
function function_1dc324f4()
{
    self endon( #"death" );
    self endon( #"hash_f71b1ef0" );
    
    while ( true )
    {
        foreach ( player in level.activeplayers )
        {
            var_d3d59692 = distance2dsquared( player.origin, self.origin );
            
            if ( player issliding() && var_d3d59692 <= 1600 )
            {
                player function_c27610f9( "quad_tank_slide" );
                self notify( #"hash_f71b1ef0" );
            }
        }
        
        wait 0.05;
    }
}

// Namespace ramses_accolades
// Params 0
// Checksum 0xbf35f982, Offset: 0x22f8
// Size: 0x24
function function_359e6bb1()
{
    callback::on_ai_killed( &function_fd243f30 );
}

// Namespace ramses_accolades
// Params 0
// Checksum 0x690e97ca, Offset: 0x2328
// Size: 0x24
function function_c31ee41b()
{
    callback::remove_on_ai_killed( &function_fd243f30 );
}

// Namespace ramses_accolades
// Params 1
// Checksum 0xc17ac182, Offset: 0x2358
// Size: 0x214
function function_fd243f30( params )
{
    if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
        
        if ( !isdefined( player.var_4c1b77b6 ) )
        {
            player.var_4c1b77b6 = 0;
        }
        
        if ( !isdefined( player.var_a43dc1f ) )
        {
            player.var_a43dc1f = 0;
        }
        
        if ( !isdefined( player.var_204359de ) )
        {
            player.var_204359de = 0;
        }
        
        if ( !isdefined( player.var_218b552 ) )
        {
            player.var_218b552 = 0;
        }
        
        if ( isdefined( player.hijacked_vehicle_entity ) && isdefined( player.hijacked_vehicle_entity.archetype ) )
        {
            switch ( player.hijacked_vehicle_entity.archetype )
            {
                case "raps":
                    player.var_4c1b77b6 = 1;
                    break;
                case "wasp":
                    player.var_a43dc1f = 1;
                    break;
                case "amws":
                    player.var_204359de = 1;
                    break;
                case "quadtank":
                    player.var_218b552 = 1;
                    break;
                default:
                    break;
            }
            
            if ( player.var_4c1b77b6 && player.var_a43dc1f && player.var_204359de && player.var_218b552 )
            {
                player function_c27610f9( "remote_hijack_variety_kills" );
            }
        }
    }
}

