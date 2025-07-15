#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace infection_accolades;

// Namespace infection_accolades
// Params 0
// Checksum 0xd48d13c3, Offset: 0x528
// Size: 0x20c
function function_66df416f()
{
    accolades::register( "MISSION_INFECTION_UNTOUCHED" );
    accolades::register( "MISSION_INFECTION_SCORE" );
    accolades::register( "MISSION_INFECTION_COLLECTIBLE" );
    accolades::register( "MISSION_INFECTION_CHALLENGE3", "ch03_quick_kills_complete" );
    accolades::register( "MISSION_INFECTION_CHALLENGE4", "ch04_theia_battle_no_damage_completed" );
    accolades::register( "MISSION_INFECTION_HATTRICK", "ch05_helmet_shot" );
    accolades::register( "MISSION_INFECTION_CHALLENGE6", "ch06_mg42_kill" );
    accolades::register( "MISSION_INFECTION_CHALLENGE9", "ch09_wolf_midair_kills_granted" );
    accolades::register( "MISSION_INFECTION_CHALLENGE10", "ch10_wolf_melee_granted" );
    accolades::register( "MISSION_INFECTION_CHALLENGE11", "ch11_wolf_bite_granted" );
    accolades::register( "MISSION_INFECTION_CHALLENGE12", "ch12_tank_killer_granted" );
    accolades::register( "MISSION_INFECTION_CHALLENGE14", "ch14_cathedral_untouchable_grant" );
    accolades::register( "MISSION_INFECTION_CHALLENGE15", "ch15_zombies_untouchable_grant" );
    accolades::register( "MISSION_INFECTION_CHALLENGE16", "ch16_zombie_bonfire" );
    accolades::register( "MISSION_INFECTION_CHALLENGE17", "ch17_confirmed_hit" );
    accolades::register( "MISSION_INFECTION_CHALLENGE18", "ch18_sarah_grenaded" );
    callback::on_connect( &on_player_connect );
}

// Namespace infection_accolades
// Params 0
// Checksum 0xa948f46d, Offset: 0x740
// Size: 0x1c
function on_player_connect()
{
    self function_804e65bb();
}

// Namespace infection_accolades
// Params 3
// Checksum 0x19de1433, Offset: 0x768
// Size: 0x3e
function function_5a97e5bd( var_8e087689, e_player, var_70b01bd3 )
{
    e_player notify( var_8e087689 );
    
    if ( isdefined( var_70b01bd3 ) )
    {
        [[ var_70b01bd3 ]]();
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x65004659, Offset: 0x7b0
// Size: 0x3c
function function_804e65bb()
{
    self.var_be5d3b1b = 0;
    self.var_9ac129fc = 0;
    callback::on_actor_killed( &function_ba00a6fc );
}

// Namespace infection_accolades
// Params 0
// Checksum 0x3dca1d17, Offset: 0x7f8
// Size: 0xcc
function function_346b87d1()
{
    n_count = 0;
    
    foreach ( player in level.activeplayers )
    {
        if ( player.var_be5d3b1b )
        {
            n_count++;
        }
    }
    
    if ( n_count == level.activeplayers.size )
    {
        callback::remove_on_actor_killed( &function_ba00a6fc );
    }
}

// Namespace infection_accolades
// Params 1
// Checksum 0xb6db6d9f, Offset: 0x8d0
// Size: 0x184
function function_ba00a6fc( params )
{
    if ( isplayer( params.eattacker ) )
    {
        var_e546abd0 = params.eattacker;
        
        if ( !var_e546abd0.var_be5d3b1b )
        {
            if ( !isdefined( var_e546abd0.var_a952433c ) )
            {
                var_e546abd0.var_a952433c = [];
            }
            
            array::push( var_e546abd0.var_a952433c, gettime(), 0 );
            
            if ( var_e546abd0.var_a952433c.size > 5 )
            {
                arrayremoveindex( var_e546abd0.var_a952433c, 5, 0 );
            }
            
            var_2e019997 = var_e546abd0.var_a952433c[ 0 ];
            var_c96d3593 = var_e546abd0.var_a952433c[ 4 ];
            
            if ( isdefined( var_c96d3593 ) )
            {
                n_time_delta = var_2e019997 - var_c96d3593;
                
                if ( n_time_delta < 10000 )
                {
                    var_e546abd0.var_be5d3b1b = 1;
                    function_5a97e5bd( "ch03_quick_kills_complete", var_e546abd0, &function_346b87d1 );
                }
            }
        }
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x2ebfa442, Offset: 0xa60
// Size: 0x3c
function function_ad15914d()
{
    self.var_6385535e = 1;
    self thread function_9d23c86c();
    self thread function_6427aa57();
}

// Namespace infection_accolades
// Params 0
// Checksum 0xf28a2e0a, Offset: 0xaa8
// Size: 0x44
function function_6427aa57()
{
    self endon( #"death" );
    level waittill( #"hash_1d7591db" );
    
    if ( self.var_6385535e )
    {
        function_5a97e5bd( "ch04_theia_battle_no_damage_completed", self );
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x942c2785, Offset: 0xaf8
// Size: 0x54
function function_9d23c86c()
{
    level endon( #"hash_1d7591db" );
    self endon( #"death" );
    self waittill( #"damage", damage, attacker );
    
    if ( isdefined( attacker ) )
    {
        self.var_6385535e = 0;
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x108098eb, Offset: 0xb58
// Size: 0x24
function function_15b29a5a()
{
    callback::on_actor_killed( &function_918d0428 );
}

// Namespace infection_accolades
// Params 1
// Checksum 0xeeb0890, Offset: 0xb88
// Size: 0x98
function function_918d0428( params )
{
    if ( params.eattacker.classname == "player" )
    {
        if ( destructserverutils::getpiececount( self ) >= 1 && destructserverutils::isdestructed( self, 1 ) && !function_3dc86a1( params ) )
        {
            params.eattacker notify( #"ch05_helmet_shot" );
        }
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x9ea0ad5c, Offset: 0xc28
// Size: 0x24
function function_ecd2ed4()
{
    callback::remove_on_actor_killed( &function_918d0428 );
}

// Namespace infection_accolades
// Params 0
// Checksum 0x877b765f, Offset: 0xc58
// Size: 0x24
function function_c081e535()
{
    callback::on_actor_killed( &function_e7e68fa2 );
}

// Namespace infection_accolades
// Params 1
// Checksum 0xce2f5b1a, Offset: 0xc88
// Size: 0x90
function function_e7e68fa2( params )
{
    if ( params.eattacker.classname == "player" && params.eattacker.team !== self.team )
    {
        if ( params.weapon.name == "turret_bo3_germans" )
        {
            params.eattacker notify( #"ch06_mg42_kill" );
        }
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x306fa157, Offset: 0xd20
// Size: 0x24
function function_a0f567cb()
{
    callback::remove_on_actor_killed( &function_e7e68fa2 );
}

// Namespace infection_accolades
// Params 0
// Checksum 0xc6c5dabb, Offset: 0xd50
// Size: 0x44
function function_341d8f7a()
{
    callback::on_ai_killed( &function_423d8d8c );
    callback::on_ai_spawned( &function_21f98ad9 );
}

// Namespace infection_accolades
// Params 1
// Checksum 0x15027975, Offset: 0xda0
// Size: 0x7c
function function_423d8d8c( params )
{
    if ( self.archetype == "direwolf" )
    {
        if ( isplayer( params.eattacker ) )
        {
            player = params.eattacker;
            
            if ( isdefined( self.var_e91cc22f ) && self.var_e91cc22f )
            {
                player notify( #"ch09_wolf_midair_kills_granted" );
            }
        }
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0xae46fe89, Offset: 0xe28
// Size: 0x2c
function function_21f98ad9()
{
    if ( self.archetype === "direwolf" )
    {
        self thread function_a12f3181();
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x7f7728b5, Offset: 0xe60
// Size: 0x60
function function_a12f3181()
{
    self endon( #"death" );
    level endon( #"forest_wolves_complete" );
    self.var_e91cc22f = 0;
    
    while ( true )
    {
        self waittill( #"hash_e27de0db" );
        self.var_e91cc22f = 1;
        self waittill( #"hash_8b0841b8" );
        self.var_e91cc22f = 0;
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0xac05e8d7, Offset: 0xec8
// Size: 0x44
function function_a2179c84()
{
    callback::remove_on_ai_killed( &function_423d8d8c );
    callback::remove_on_ai_spawned( &function_21f98ad9 );
}

// Namespace infection_accolades
// Params 0
// Checksum 0x9c6ad4c7, Offset: 0xf18
// Size: 0xda
function function_8c0b0cd0()
{
    callback::on_ai_killed( &function_20c5379e );
    callback::on_spawned( &function_b59240f2 );
    
    foreach ( player in level.activeplayers )
    {
        player.var_63b33b24 = 0;
        player.var_a1930cfd = 1;
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0xfe80d334, Offset: 0x1000
// Size: 0x1c
function function_b59240f2()
{
    self.var_63b33b24 = 0;
    self.var_a1930cfd = 1;
}

// Namespace infection_accolades
// Params 1
// Checksum 0x96fad03b, Offset: 0x1028
// Size: 0xa0
function function_20c5379e( params )
{
    if ( self.archetype == "direwolf" )
    {
        if ( isplayer( params.eattacker ) )
        {
            params.eattacker.var_63b33b24 += 1;
            
            if ( !function_3dc86a1( params ) )
            {
                params.eattacker.var_a1930cfd = 0;
            }
        }
    }
}

// Namespace infection_accolades
// Params 1
// Checksum 0xf39584d5, Offset: 0x10d0
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

// Namespace infection_accolades
// Params 0
// Checksum 0x16954417, Offset: 0x1198
// Size: 0xe6
function function_74b401d8()
{
    callback::remove_on_ai_killed( &function_20c5379e );
    callback::remove_on_spawned( &function_b59240f2 );
    
    foreach ( player in level.activeplayers )
    {
        if ( player.var_a1930cfd && player.var_63b33b24 > 0 )
        {
            player notify( #"ch10_wolf_melee_granted" );
        }
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x5b35d3cd, Offset: 0x1288
// Size: 0xc6
function function_aea367c1()
{
    callback::on_player_damage( &function_d9aaed7d );
    callback::on_spawned( &function_6bc56950 );
    
    foreach ( player in level.activeplayers )
    {
        player.var_1bece4df = 1;
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0xaa2b8351, Offset: 0x1358
// Size: 0x10
function function_6bc56950()
{
    self.var_1bece4df = 1;
}

// Namespace infection_accolades
// Params 0
// Checksum 0x809535e2, Offset: 0x1370
// Size: 0xf4
function function_d9aaed7d()
{
    self endon( #"death" );
    self endon( #"forest_wolves_complete" );
    self endon( #"ch11_wolf_bite_granted" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags );
        
        if ( attacker.archetype === "direwolf" )
        {
            if ( isplayer( self ) )
            {
                self.var_1bece4df = 0;
            }
        }
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x58ee0731, Offset: 0x1470
// Size: 0xe6
function function_b3cf52bf()
{
    callback::remove_on_player_damage( &function_d9aaed7d );
    callback::remove_on_spawned( &function_6bc56950 );
    
    foreach ( player in level.activeplayers )
    {
        if ( player.var_1bece4df && player.var_63b33b24 > 0 )
        {
            player notify( #"ch11_wolf_bite_granted" );
        }
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x20d9252, Offset: 0x1560
// Size: 0x44
function function_7356f9fd()
{
    self endon( #"death" );
    self.var_b42f169e = 0;
    self thread function_2c3b4c78();
    self waittill( #"weapon_fired" );
    self.var_b42f169e = 1;
}

// Namespace infection_accolades
// Params 0
// Checksum 0x6a9ca7ad, Offset: 0x15b0
// Size: 0xa6
function function_2c3b4c78()
{
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        if ( self.var_b42f169e == 0 )
        {
            foreach ( player in level.activeplayers )
            {
                player notify( #"ch12_tank_killer_granted" );
            }
        }
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x7309043c, Offset: 0x1660
// Size: 0xa6
function function_211b07c5()
{
    callback::on_player_damage( &function_9f9141fd );
    
    foreach ( player in level.activeplayers )
    {
        player.var_a400c99f = 1;
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x6b91ebcb, Offset: 0x1710
// Size: 0x28
function function_9f9141fd()
{
    self endon( #"death" );
    self waittill( #"damage" );
    self.var_a400c99f = 0;
}

// Namespace infection_accolades
// Params 0
// Checksum 0x4ee85ae7, Offset: 0x1740
// Size: 0xb2
function function_2c8ffdaf()
{
    callback::remove_on_player_damage( &function_9f9141fd );
    
    foreach ( player in level.activeplayers )
    {
        if ( player.var_a400c99f )
        {
            player notify( #"ch14_cathedral_untouchable_grant" );
        }
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x6eecbfd5, Offset: 0x1800
// Size: 0x8a
function function_6c777c8d()
{
    foreach ( player in level.players )
    {
        player thread function_335ecd05();
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0xef9454bb, Offset: 0x1898
// Size: 0x40
function function_335ecd05()
{
    self endon( #"death" );
    self endon( #"hash_f0f63627" );
    self endon( #"hash_8a7a61e0" );
    self waittill( #"damage" );
    self.var_5f815670 = 1;
}

// Namespace infection_accolades
// Params 0
// Checksum 0x40b00d0d, Offset: 0x18e0
// Size: 0xaa
function function_e9c21474()
{
    foreach ( player in level.activeplayers )
    {
        player notify( #"hash_8a7a61e0" );
        
        if ( player.var_5f815670 !== 1 )
        {
            player notify( #"ch15_zombies_untouchable_grant" );
        }
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x4f5370c6, Offset: 0x1998
// Size: 0xc6
function function_a0fb8ca9()
{
    callback::on_ai_killed( &function_98c5c5a1 );
    callback::on_spawned( &function_7eac16b1 );
    
    foreach ( player in level.activeplayers )
    {
        player.var_abed6924 = 0;
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0xbd8d1407, Offset: 0x1a68
// Size: 0x10
function function_7eac16b1()
{
    self.var_abed6924 = 0;
}

// Namespace infection_accolades
// Params 1
// Checksum 0x4362d2c4, Offset: 0x1a80
// Size: 0x84
function function_98c5c5a1( params )
{
    if ( self.archetype === "zombie" && isplayer( params.eattacker ) && self.on_fire === 1 )
    {
        params.eattacker.var_abed6924 += 1;
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x7ffbb52a, Offset: 0x1b10
// Size: 0xda
function function_bbb224b7()
{
    callback::remove_on_ai_killed( &function_98c5c5a1 );
    callback::remove_on_spawned( &function_7eac16b1 );
    
    foreach ( player in level.activeplayers )
    {
        if ( player.var_abed6924 >= 4 )
        {
            player notify( #"ch16_zombie_bonfire" );
        }
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x9d8a5408, Offset: 0x1bf8
// Size: 0xcc
function function_70cafec1()
{
    foreach ( player in level.activeplayers )
    {
        player function_f6215929();
    }
    
    callback::on_spawned( &function_f6215929 );
    callback::on_ai_killed( &function_7dfda27d );
}

// Namespace infection_accolades
// Params 0
// Checksum 0xa7593e76, Offset: 0x1cd0
// Size: 0x10
function function_f6215929()
{
    self.var_5bfcdcf4 = 0;
}

// Namespace infection_accolades
// Params 1
// Checksum 0xcadd48ba, Offset: 0x1ce8
// Size: 0xf8
function function_7dfda27d( params )
{
    if ( params.eattacker.classname == "player" )
    {
        if ( params.shitloc == "head" || params.shitloc == "helmet" || params.shitloc == "neck" )
        {
            params.eattacker.var_5bfcdcf4++;
            
            if ( params.eattacker.var_5bfcdcf4 >= 10 )
            {
                params.eattacker notify( #"ch17_confirmed_hit" );
            }
            
            return;
        }
        
        params.eattacker.var_5bfcdcf4 = 0;
    }
}

// Namespace infection_accolades
// Params 0
// Checksum 0x63920d20, Offset: 0x1de8
// Size: 0x82
function function_cce60169()
{
    foreach ( player in level.activeplayers )
    {
        player notify( #"ch18_sarah_grenaded" );
    }
}

