#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace doa_chicken;

#using_animtree( "critter" );

// Namespace doa_chicken
// Params 1
// Checksum 0x7f90afb1, Offset: 0x588
// Size: 0x31e
function function_cdfa9ce8( bird )
{
    bird notify( #"hash_cf62504" );
    bird endon( #"hash_cf62504" );
    bird endon( #"death" );
    bird useanimtree( #animtree );
    curanim = %a_chicken_react_up_down;
    lastanim = %a_chicken_idle_peck;
    bird thread doa_sound::function_90118d8c( "zmb_dblshot_squawk" );
    
    while ( isdefined( bird ) )
    {
        if ( randomint( 100 ) > 15 )
        {
            bird thread doa_sound::function_90118d8c( "zmb_dblshot_squawk" );
        }
        
        if ( isdefined( self.var_3424aae1 ) && self.var_3424aae1 )
        {
            curanim = %a_chicken_react_up_down;
            bird thread doa_sound::function_90118d8c( "zmb_dblshot_squawk" );
        }
        else if ( isdefined( self.var_a732885d ) && self.var_a732885d )
        {
            curanim = %a_chicken_react_up_down;
            bird thread doa_sound::function_90118d8c( "zmb_dblshot_squawk" );
        }
        else if ( isdefined( self.var_7d36ff94 ) && self.var_7d36ff94 )
        {
            curanim = %a_chicken_react_up_down;
            self.var_7d36ff94 = undefined;
            bird thread doa_sound::function_90118d8c( "zmb_dblshot_squawk" );
        }
        else if ( isdefined( self.var_efa2b784 ) && self.var_efa2b784 )
        {
            curanim = %a_chicken_react_to_front_notrans;
        }
        else if ( isdefined( self.is_moving ) && self.is_moving )
        {
            curanim = %a_chicken_run;
        }
        
        bird animscripted( "chicken_anim", bird.origin, bird.angles, curanim );
        animlength = getanimlength( curanim );
        wait animlength;
        lastanim = curanim;
        
        switch ( randomint( 3 ) )
        {
            case 0:
                curanim = %a_chicken_idle_peck;
                break;
            case 1:
                curanim = %a_chicken_idle_a;
                break;
            case 2:
                curanim = %a_chicken_idle;
                break;
        }
    }
}

// Namespace doa_chicken
// Params 4
// Checksum 0xb1f54b69, Offset: 0x8b0
// Size: 0x5d4
function add_a_chicken( model, scale, fated, var_5c667593 )
{
    if ( !isdefined( self.doa ) )
    {
        return;
    }
    
    if ( !mayspawnentity() )
    {
        return;
    }
    
    orb = spawn( "script_model", self.origin + ( 0, 0, getdvarint( "scr_doa_chickenZ", 50 ) ) );
    orb.targetname = "add_a_chicken";
    orb setmodel( "tag_origin" );
    orb enablelinkto();
    orb notsolid();
    bird = spawn( "script_model", orb.origin );
    bird.targetname = "chicken";
    bird setmodel( model );
    bird linkto( orb, "tag_origin" );
    bird notsolid();
    orb.basescale = scale;
    bird setscale( scale );
    orb.bird = bird;
    bird.orb = orb;
    orb.player = self;
    orb.owner = self;
    orb.team = self.team;
    orb.special = fated;
    orb.weaponbonus = 0;
    orb.var_fe6ede28 = 0;
    orb.var_947e1f34 = self.doa.var_3cdd8203.size == 0 ? self : self.doa.var_3cdd8203[ self.doa.var_3cdd8203.size - 1 ];
    orb enablelinkto();
    orb thread function_cdfa9ce8( bird );
    
    if ( isdefined( orb.special ) && orb.special && self.doa.var_3cdd8203.size > 0 )
    {
        arrayinsert( self.doa.var_3cdd8203, orb, 0 );
        var_bd097d49 = self;
        
        foreach ( chicken in self.doa.var_3cdd8203 )
        {
            chicken.var_947e1f34 = var_bd097d49;
            var_bd097d49 = chicken;
        }
    }
    else
    {
        self.doa.var_3cdd8203[ self.doa.var_3cdd8203.size ] = orb;
    }
    
    if ( self.doa.var_3cdd8203.size > getdvarint( "scr_doa_max_chickens", 5 ) )
    {
        foreach ( chicken in self.doa.var_3cdd8203 )
        {
            if ( !( isdefined( chicken.special ) && chicken.special ) )
            {
                chicken notify( #"spin_out" );
                break;
            }
        }
    }
    
    orb thread function_d7142cd( self );
    orb thread function_3118ca4d( self );
    orb thread function_8b81d592( self );
    orb thread function_8fb467a7( self );
    orb thread function_4ef3ec52();
    orb thread function_da8e9c9b();
    orb thread function_44ff9baa( self );
    orb thread function_e636d9c5( self );
    
    if ( isdefined( var_5c667593 ) && var_5c667593 )
    {
        orb thread function_cff32183( self );
    }
}

// Namespace doa_chicken
// Params 0
// Checksum 0xab98e37b, Offset: 0xe90
// Size: 0xce
function function_8397461e()
{
    if ( !isdefined( self.doa.var_3cdd8203 ) )
    {
        return;
    }
    
    foreach ( bird in self.doa.var_3cdd8203 )
    {
        if ( isdefined( bird.special ) && bird.special )
        {
            continue;
        }
        
        bird notify( #"spin_out", 1 );
    }
}

// Namespace doa_chicken
// Params 1
// Checksum 0x23d9acd0, Offset: 0xf68
// Size: 0x8e
function function_d7142cd( player )
{
    self endon( #"death" );
    player waittill( #"disconnect" );
    
    if ( isdefined( self.special ) && self.special )
    {
        if ( isdefined( self.bird ) )
        {
            self.bird delete();
        }
        
        self delete();
        return;
    }
    
    self notify( #"spin_out" );
}

// Namespace doa_chicken
// Params 1
// Checksum 0xcf7fcb2b, Offset: 0x1000
// Size: 0x30c
function function_3118ca4d( player )
{
    if ( isdefined( self.special ) && self.special )
    {
        return;
    }
    
    self notify( #"hash_3118ca4d" );
    self endon( #"hash_3118ca4d" );
    self endon( #"death" );
    self waittill( #"spin_out", immediate );
    waittillframeend();
    self notify( #"spinning_out" );
    arrayremovevalue( player.doa.var_3cdd8203, self );
    
    if ( !( isdefined( immediate ) && immediate ) )
    {
        self.var_3424aae1 = 1;
        var_46d4563e = player;
        
        foreach ( chicken in player.doa.var_3cdd8203 )
        {
            chicken.var_947e1f34 = var_46d4563e;
            var_46d4563e = chicken;
        }
        
        weapon = function_4d01b327( player );
        self.spinouttime = randomfloatrange( 5, 8 );
        firetime = 0.15;
        
        while ( self.spinouttime > 0 )
        {
            rotate180time = 1;
            self rotateto( self.angles + ( 0, 180, 0 ), rotate180time );
            localrotatetime = rotate180time;
            
            while ( localrotatetime > 0 )
            {
                self function_cea0c915( player, weapon );
                wait firetime;
                localrotatetime -= firetime;
            }
            
            self.spinouttime -= rotate180time;
        }
    }
    
    self thread doa_sound::function_90118d8c( "zmb_dblshot_end" );
    self.bird thread doa_fx::function_285a2999( "chicken_explode" );
    util::wait_network_frame();
    
    if ( isdefined( self.bird ) )
    {
        self.bird delete();
    }
    
    self delete();
}

// Namespace doa_chicken
// Params 2
// Checksum 0x4ce03344, Offset: 0x1318
// Size: 0x50
function function_4dd46e10( &follow_points, num_follow_points )
{
    for ( i = 0; i < num_follow_points ; i++ )
    {
        follow_points[ i ] = self.origin;
    }
}

// Namespace doa_chicken
// Params 1
// Checksum 0x318c58ca, Offset: 0x1370
// Size: 0x10c
function function_e636d9c5( player )
{
    self endon( #"death" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"hash_31680c6" );
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( isdefined( self.var_3424aae1 ) && self.var_3424aae1 )
        {
            self.spinouttime = 0;
        }
        
        self.var_6fdb49e0 = 1;
        myidx = self function_bd97e9ba( player ) + 1;
        forward = anglestoforward( player.angles );
        offset = forward * ( 24 * myidx, 0, 0 );
        self.origin = player.origin - offset;
    }
}

// Namespace doa_chicken
// Params 1
// Checksum 0x13af23a5, Offset: 0x1488
// Size: 0x398
function function_44ff9baa( player )
{
    self endon( #"death" );
    self endon( #"spinning_out" );
    follow_index = 0;
    next_index = follow_index + 1;
    num_follow_points = getdvarint( "scr_doa_max_chicken_points", 5 );
    follow_points = [];
    self.var_6fdb49e0 = 1;
    
    while ( true )
    {
        util::wait_network_frame();
        
        if ( isdefined( self.var_efa2b784 ) && self.var_efa2b784 )
        {
            self.var_6fdb49e0 = 1;
            continue;
        }
        
        if ( isdefined( self.var_a732885d ) && self.var_a732885d )
        {
            self.var_6fdb49e0 = 1;
            continue;
        }
        
        if ( self.var_6fdb49e0 )
        {
            self.var_6fdb49e0 = 0;
            function_4dd46e10( follow_points, num_follow_points );
        }
        
        if ( isdefined( self.var_947e1f34 ) )
        {
            if ( isplayer( self.var_947e1f34 ) )
            {
                angles = self.var_947e1f34 getplayerangles();
            }
            else
            {
                angles = self.var_947e1f34.angles;
            }
            
            self.angles = ( angles[ 0 ], angles[ 1 ], 0 );
            self.bird.angles = self.angles;
            self.bird.origin = self.origin;
            self.is_moving = 0;
            
            if ( distance2dsquared( self.var_947e1f34.origin, follow_points[ follow_index ] ) > getdvarint( "scr_doa_follow_point_spacing", 4 * 4 ) )
            {
                follow_pt = self.var_947e1f34.origin;
                
                if ( isplayer( self.var_947e1f34 ) )
                {
                    if ( isdefined( self.var_947e1f34.doa.infps ) && self.var_947e1f34.doa.infps || isdefined( self.var_5c667593 ) )
                    {
                        z = getdvarint( "scr_doa_chickenZ", 20 );
                    }
                    else
                    {
                        z = getdvarint( "scr_doa_chickenZ", 50 );
                    }
                    
                    follow_pt += ( 0, 0, z );
                }
                
                follow_points[ next_index ] = follow_pt;
                follow_index = next_index;
                next_index++;
                next_index %= num_follow_points;
                self.is_moving = 1;
                self moveto( follow_points[ next_index ], getdvarfloat( "scr_doa_chicken_speed", 0.15 ), 0, 0 );
            }
        }
    }
}

// Namespace doa_chicken
// Params 1
// Checksum 0x44f069a7, Offset: 0x1828
// Size: 0x17e
function function_8b81d592( player )
{
    self endon( #"spinning_out" );
    self endon( #"death" );
    time = level.doa.rules.var_da7e08a6 * 1000;
    
    if ( player.doa.fate == 3 || player.doa.fate == 12 )
    {
        time *= level.doa.rules.var_ef3d9a29;
    }
    
    level doa_utility::function_c8f4d63a();
    timeout = gettime() + time;
    
    while ( gettime() < timeout )
    {
        if ( !isdefined( player ) )
        {
            self notify( #"spin_out" );
        }
        
        if ( level flag::get( "doa_game_is_over" ) )
        {
            self notify( #"spin_out" );
        }
        
        wait 0.05;
    }
    
    while ( isdefined( self.var_efa2b784 ) && ( isdefined( self.var_a732885d ) && self.var_a732885d || self.var_efa2b784 ) )
    {
        wait 1;
    }
    
    self notify( #"spin_out" );
}

// Namespace doa_chicken
// Params 1
// Checksum 0xf41141b5, Offset: 0x19b0
// Size: 0x202
function function_4d01b327( player )
{
    weapon = level.doa.var_362a104d;
    
    if ( isdefined( self.special ) && self.special )
    {
        weapon = level.doa.var_4a3223bd;
    }
    
    switch ( self.weaponbonus )
    {
        case 0:
            if ( isdefined( player ) && isdefined( player.doa.var_d898dd8e ) )
            {
                weapon = player.doa.var_d898dd8e;
            }
            
            if ( isdefined( player.doa.vehicle ) )
            {
                if ( isdefined( player.doa.vehicle.var_aaffbea7 ) && player.doa.vehicle.var_aaffbea7 )
                {
                    weapon = level.doa.var_c1b50f26;
                }
                else
                {
                    weapon = level.doa.var_e6a7c945;
                }
            }
            
            break;
        case 1:
            weapon = level.doa.var_b6808b5a;
            break;
        case 2:
        case 3:
            weapon = level.doa.var_e00fcc77;
            break;
        case 4:
        case 5:
            weapon = level.doa.var_a9c9b20;
            break;
        case 6:
        case 7:
            weapon = level.doa.var_ccb54987;
            break;
        case 8:
            weapon = level.doa.var_69899304;
            break;
    }
    
    return weapon;
}

// Namespace doa_chicken
// Params 1
// Checksum 0xcfded672, Offset: 0x1bc0
// Size: 0xfe
function function_be58e20c( player )
{
    while ( isdefined( self ) && !( isdefined( self.var_3424aae1 ) && self.var_3424aae1 ) )
    {
        if ( isdefined( player.doa.vehicle ) )
        {
            msg = player.doa.vehicle util::waittill_any_timeout( 0.1, "weapon_fired", "gunner_weapon_fired" );
        }
        else
        {
            msg = player util::waittill_any_timeout( 0.1, "weapon_fired", "gunner_weapon_fired", "disconnect" );
        }
        
        if ( isdefined( msg ) && msg != "timeout" )
        {
            self notify( #"chicken_fire" );
        }
    }
}

// Namespace doa_chicken
// Params 1
// Checksum 0x20935fbe, Offset: 0x1cc8
// Size: 0xe8
function function_8fb467a7( player )
{
    self endon( #"death" );
    self endon( #"spinning_out" );
    self thread function_be58e20c( player );
    
    while ( true )
    {
        self waittill( #"chicken_fire" );
        
        if ( isdefined( self.var_18845184 ) && self.var_18845184 )
        {
            continue;
        }
        
        weapon = self function_4d01b327( player );
        self function_cea0c915( player, weapon );
        extrawait = weapon.firetime - 0.05;
        
        if ( extrawait > 0 )
        {
            wait extrawait;
        }
    }
}

// Namespace doa_chicken
// Params 2, eflags: 0x4
// Checksum 0xf4d0d72f, Offset: 0x1db8
// Size: 0x184
function private function_cea0c915( player, weapon )
{
    if ( isdefined( player ) )
    {
        forward = anglestoforward( self.angles + ( player.doa.var_7a1de0da, 0, 0 ) );
    }
    else
    {
        forward = anglestoforward( self.angles );
    }
    
    offset = forward * 12 + ( 0, 0, 6 );
    start = self.bird.origin + offset;
    
    if ( getdvarint( "scr_doa_debug_chicken_fire", 0 ) )
    {
        level thread doa_dev::function_a0e51d80( start, 5, 20, ( 1, 0, 0 ) );
        level thread doa_dev::debugline( start, self.origin + forward * 1000, 5, ( 1, 0, 0 ) );
    }
    
    magicbullet( weapon, start, start + forward * 1000, isdefined( player ) ? player : self.bird );
}

// Namespace doa_chicken
// Params 0
// Checksum 0x7fe37564, Offset: 0x1f48
// Size: 0xb8
function function_da8e9c9b()
{
    self endon( #"spinning_out" );
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        rand = randomintrange( 0, 100 );
        
        if ( rand > 30 )
        {
            self thread doa_sound::function_90118d8c( "zmb_dblshot_wingflap" );
        }
        
        if ( rand > 70 )
        {
            self thread doa_sound::function_90118d8c( "zmb_dblshot_squawk" );
        }
        
        wait randomfloatrange( 1, 3 );
    }
}

// Namespace doa_chicken
// Params 0
// Checksum 0x6cee218c, Offset: 0x2008
// Size: 0x88
function function_4ef3ec52()
{
    self endon( #"death" );
    self waittill( #"spinning_out" );
    
    while ( isdefined( self ) )
    {
        self thread doa_sound::function_90118d8c( "zmb_dblshot_wingflap" );
        self thread doa_sound::function_90118d8c( "zmb_dblshot_death" );
        wait randomfloatrange( 0.5, 1 );
    }
}

// Namespace doa_chicken
// Params 0
// Checksum 0xbdccf3a, Offset: 0x2098
// Size: 0x11a
function function_9d2031fa()
{
    self notify( #"chicken_disconnect_watch" );
    self endon( #"chicken_disconnect_watch" );
    msg = self util::waittill_any_return( "death", "disconnect", "chicken_disconnect_watch" );
    
    foreach ( chicken in self.doa.var_3cdd8203 )
    {
        if ( msg == "disconnect" || !( isdefined( chicken.special ) && chicken.special ) )
        {
            chicken notify( #"spin_out" );
        }
    }
}

// Namespace doa_chicken
// Params 3
// Checksum 0xbe85e597, Offset: 0x21c0
// Size: 0x104
function chickenpickup( model, fated, var_c29d1327 )
{
    if ( !isdefined( fated ) )
    {
        fated = 0;
    }
    
    if ( !isdefined( var_c29d1327 ) )
    {
        var_c29d1327 = 1;
    }
    
    if ( !isdefined( self.doa.var_3cdd8203 ) )
    {
        self.doa.var_3cdd8203 = [];
    }
    
    self thread function_9d2031fa();
    def = doa_pickups::function_bac08508( 5 );
    
    if ( !isdefined( model ) )
    {
        model = level.doa.var_8d63e734;
    }
    
    self add_a_chicken( model, def.scale * var_c29d1327, fated != 0, fated == 2 );
}

// Namespace doa_chicken
// Params 0
// Checksum 0x5bb47626, Offset: 0x22d0
// Size: 0xba
function function_83df0c19()
{
    number = 0;
    
    foreach ( chicken in self.doa.var_3cdd8203 )
    {
        if ( !( isdefined( chicken.special ) && chicken.special ) )
        {
            number++;
        }
    }
    
    return number;
}

// Namespace doa_chicken
// Params 1
// Checksum 0xf24f50f8, Offset: 0x2398
// Size: 0xb6
function function_bd97e9ba( player )
{
    number = 0;
    
    foreach ( chicken in player.doa.var_3cdd8203 )
    {
        if ( chicken == self )
        {
            break;
        }
        
        number++;
    }
    
    return number;
}

// Namespace doa_chicken
// Params 1
// Checksum 0x8ef2aac6, Offset: 0x2458
// Size: 0x1b2
function function_c397fab3( player )
{
    self endon( #"death" );
    self endon( #"spinning_out" );
    
    while ( true )
    {
        player waittill( #"player_died" );
        
        /#
            doa_utility::debugmsg( "<dev string:x28>" );
        #/
        
        var_141b6128 = self.var_fe6ede28 * 0.98;
        self.var_1f6fdc8f = 1;
        
        while ( self.var_fe6ede28 > var_141b6128 )
        {
            self.var_fe6ede28 -= 0.05;
            self.bird setscale( self.basescale + self.var_fe6ede28 );
            
            /#
                doa_utility::debugmsg( "<dev string:x4c>" + self getentitynumber() + "<dev string:x5f>" + self.var_fe6ede28 );
            #/
            
            wait 0.05;
        }
        
        /#
            doa_utility::debugmsg( "<dev string:x4c>" + self getentitynumber() + "<dev string:x75>" + self.var_fe6ede28 );
        #/
        
        self.var_fe6ede28 = math::clamp( var_141b6128, 0, getdvarfloat( "scr_doa_chicken_max_plump", 3 ) );
        self.var_1f6fdc8f = undefined;
    }
}

// Namespace doa_chicken
// Params 1
// Checksum 0x8469e485, Offset: 0x2618
// Size: 0x3a0
function function_cff32183( player )
{
    self endon( #"death" );
    self endon( #"spinning_out" );
    self.var_fe6ede28 = 0;
    self.var_5c667593 = 1;
    self thread function_c397fab3( player );
    
    while ( true )
    {
        wait getdvarfloat( "scr_doa_chicken_inc_interval", 15 );
        
        if ( level flag::get( "doa_round_active" ) )
        {
            numchickens = player function_83df0c19() + 1;
            increment = getdvarfloat( "scr_doa_chicken_inc_plump", 0.035 ) * numchickens;
            
            if ( !( isdefined( self.var_1f6fdc8f ) && self.var_1f6fdc8f ) )
            {
                self.var_fe6ede28 = math::clamp( self.var_fe6ede28 + increment, 0, getdvarfloat( "scr_doa_chicken_max_plump", 3 ) );
                
                /#
                    doa_utility::debugmsg( "<dev string:x4c>" + self getentitynumber() + "<dev string:x5f>" + self.var_fe6ede28 );
                #/
            }
            
            self.bird setscale( self.basescale + self.var_fe6ede28 );
            weaponbonus = 0;
            frac = self.var_fe6ede28 / getdvarfloat( "scr_doa_chicken_max_plump", 3 );
            
            if ( frac > 0.03 )
            {
                weaponbonus = 1;
            }
            
            if ( frac > 0.12 )
            {
                weaponbonus = 2;
            }
            
            if ( frac > 0.3 )
            {
                weaponbonus = 3;
            }
            
            if ( frac > 0.5 )
            {
                weaponbonus = 4;
            }
            
            if ( frac > 0.7 )
            {
                weaponbonus = 5;
            }
            
            if ( frac > 0.82 )
            {
                weaponbonus = 6;
            }
            
            if ( frac > 0.94 )
            {
                weaponbonus = 7;
            }
            
            if ( self.weaponbonus != weaponbonus )
            {
                self thread doa_sound::function_90118d8c( "zmb_golden_chicken_grow" );
                self.var_7d36ff94 = 1;
                self.weaponbonus = weaponbonus;
            }
            
            if ( self.var_fe6ede28 == getdvarfloat( "scr_doa_chicken_max_plump", 3 ) )
            {
                wait getdvarfloat( "scr_doa_chicken_waitfull_plump", 30 );
                self function_2d0f96ef( player );
                self.var_fe6ede28 = 0;
                self.weaponbonus = 0;
                self.bird setscale( self.basescale + self.var_fe6ede28 );
            }
        }
    }
}

// Namespace doa_chicken
// Params 1
// Checksum 0x727ad8b2, Offset: 0x29c0
// Size: 0x4b2
function function_2d0f96ef( player )
{
    self endon( #"death" );
    self endon( #"spinning_out" );
    
    /#
        doa_utility::debugmsg( "<dev string:x89>" + self getentitynumber() );
    #/
    
    self.var_a732885d = 1;
    self.var_18845184 = 1;
    var_ff37339 = 32;
    pos = 0;
    i = 0;
    var_fb842d4e = gettime() + getdvarfloat( "scr_doa_chicken_egg_lay_duration", 12 ) * 1000;
    self thread doa_sound::function_90118d8c( "zmb_golden_chicken_dance" );
    
    while ( gettime() < var_fb842d4e )
    {
        foreach ( chicken in player.doa.var_3cdd8203 )
        {
            if ( isdefined( chicken.var_a732885d ) && chicken.var_a732885d )
            {
                continue;
            }
            
            if ( isdefined( chicken.var_efa2b784 ) && chicken.var_efa2b784 )
            {
                continue;
            }
            
            i++;
            offset = 48 + var_ff37339 * floor( i / 4 );
            chicken thread function_5af02c44( self, i, offset );
        }
        
        self rotateto( self.angles + ( 0, 180, 0 ), 1 );
        wait 1;
    }
    
    self thread doa_sound::function_90118d8c( "zmb_golden_chicken_pop" );
    chance = 100;
    scale = 1;
    var_19a5d5 = 2 + randomint( 5 );
    roll = randomint( 100 );
    
    while ( var_19a5d5 )
    {
        if ( roll <= chance )
        {
            level doa_pickups::function_3238133b( level.doa.var_468af4f0, self.origin );
        }
        else
        {
            level doa_pickups::function_3238133b( level.doa.var_43922ff2, self.origin );
        }
        
        var_19a5d5--;
        scale *= 0.72;
        chance = int( chance * scale + 0.9 );
    }
    
    while ( self.var_fe6ede28 > 0 )
    {
        self.var_fe6ede28 -= 0.05;
        self.bird setscale( self.basescale + self.var_fe6ede28 );
        wait 0.05;
    }
    
    foreach ( chicken in player.doa.var_3cdd8203 )
    {
        chicken.var_a732885d = undefined;
        chicken.var_efa2b784 = undefined;
        chicken.var_18845184 = undefined;
        chicken notify( #"hash_e6885d7c" );
    }
}

// Namespace doa_chicken
// Params 3, eflags: 0x4
// Checksum 0x8b2e20bf, Offset: 0x2e80
// Size: 0x254
function private function_5af02c44( target, num, offset )
{
    self endon( #"death" );
    self endon( #"spinning_out" );
    self.var_efa2b784 = 1;
    self.var_18845184 = 1;
    anim_ang = vectortoangles( target.origin - self.origin );
    self rotateto( ( 0, anim_ang[ 1 ], 0 ), 0.5 );
    pos = num % 4;
    
    switch ( pos )
    {
        case 0:
            spot = ( offset, 0, getdvarint( "scr_doa_chickenZ", 50 ) );
            break;
        case 1:
            spot = ( 0, offset, getdvarint( "scr_doa_chickenZ", 50 ) );
            break;
        case 2:
            spot = ( offset * -1, 0, getdvarint( "scr_doa_chickenZ", 50 ) );
            break;
        case 3:
            spot = ( 0, offset * -1, getdvarint( "scr_doa_chickenZ", 50 ) );
            break;
    }
    
    self moveto( target.origin, 1 );
    self util::waittill_any_timeout( 2, "movedone" );
    self linkto( target, "tag_origin", spot );
    self waittill( #"hash_e6885d7c" );
    self unlink();
}

// Namespace doa_chicken
// Params 0, eflags: 0x4
// Checksum 0xe027bd9c, Offset: 0x30e0
// Size: 0xec
function private function_e4f21fa9()
{
    roll = randomint( 100 );
    prize = "none";
    
    if ( roll < 2 )
    {
        prize = level.doa.extra_life_model;
    }
    else if ( roll < 6 )
    {
        prize = level.doa.var_501f85b4;
    }
    else if ( roll < 16 )
    {
        prize = level.doa.booster_model;
    }
    else if ( roll <= 40 )
    {
        prize = level.doa.var_8d63e734;
    }
    else
    {
        prize = "zombietron_diamond";
    }
    
    return prize;
}

// Namespace doa_chicken
// Params 1
// Checksum 0xfaa79f58, Offset: 0x31d8
// Size: 0x84
function function_d63bdb9( hop )
{
    if ( hop )
    {
        self physicslaunch( self.origin, ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 30 ) );
        self thread doa_sound::function_90118d8c( "zmb_egg_shake" );
    }
}

// Namespace doa_chicken
// Params 0
// Checksum 0xce2afb5a, Offset: 0x3268
// Size: 0x278
function function_4c41e6af()
{
    self endon( #"death" );
    
    while ( true )
    {
        closezombies = doa_utility::getarrayitemswithin( self.origin, getaiteamarray( "axis" ), 2304 );
        
        for ( i = 0; i < closezombies.size ; i++ )
        {
            zombie = closezombies[ i ];
            
            if ( isdefined( zombie.non_zombie ) && zombie.non_zombie )
            {
                continue;
            }
            
            zombie setentitytarget( self );
            dir = vectornormalize( self.origin - zombie.origin ) * 30;
            self physicslaunch( self.origin, ( dir[ 0 ], dir[ 1 ], dir[ 2 ] + 10 ) );
            self.health -= 40;
            
            if ( self.health < 0 )
            {
                self thread doa_sound::function_90118d8c( "zmb_explode" );
                self thread doa_fx::function_285a2999( "egg_explode" );
                physicsexplosionsphere( self.origin, 200, 128, 2 );
                self radiusdamage( self.origin, 72, 2000, 1000 );
                playrumbleonposition( "explosion_generic", self.origin );
                self waittill( #"hash_6a404ade" );
                self delete();
            }
        }
        
        wait 1;
        self.var_111c7bbb = getclosestpointonnavmesh( self.origin, 64, 16 );
    }
}

// Namespace doa_chicken
// Params 0
// Checksum 0x6d2faa82, Offset: 0x34e8
// Size: 0x274
function function_7b8c015c()
{
    self endon( #"death" );
    
    if ( self.def.type == 36 )
    {
        self.prize = level.doa.extra_life_model;
    }
    
    self physicslaunch( self.origin, ( 0, 0, 10 ) );
    self.health = 1500 + level.doa.var_da96f13c * 500;
    
    if ( self.def.type == 36 )
    {
        self.health += 3000;
    }
    
    self thread function_4c41e6af();
    self.team = "allies";
    wait 1;
    self makesentient();
    self.threatbias = 0;
    doa_utility::addpoi( self );
    self.nodelete = 1;
    self waittill( #"pickup_timeout" );
    wait 1;
    self thread doa_sound::function_90118d8c( "zmb_egg_hatch" );
    self thread doa_fx::function_285a2999( "egg_hatch" );
    
    if ( isdefined( self.prize ) )
    {
        prize = self.prize;
    }
    else
    {
        prize = function_e4f21fa9();
    }
    
    origin = doa_utility::function_1c0abd70( self.origin, 10, self );
    
    if ( prize != "zombietron_diamond" )
    {
        level doa_pickups::function_3238133b( prize, origin + ( 0, 0, 12 ) );
    }
    else
    {
        level thread doa_pickups::spawnubertreasure( origin, 1 + randomintrange( 2, 6 ), 0, 1 );
    }
    
    self waittill( #"hash_6a404ade" );
    self delete();
}

