#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_zombie_blood;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_one_inch_punch;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_challenges_tomb;
#using scripts/zm/zm_tomb_vo;

#namespace zm_tomb_challenges;

// Namespace zm_tomb_challenges
// Params 0
// Checksum 0xc57866f3, Offset: 0x580
// Size: 0x1c
function challenges_init()
{
    level.challenges_add_stats = &tomb_challenges_add_stats;
}

// Namespace zm_tomb_challenges
// Params 0
// Checksum 0x3145d99a, Offset: 0x5a8
// Size: 0x184
function tomb_challenges_add_stats()
{
    n_kills = 115;
    n_zone_caps = 6;
    n_points_spent = 30000;
    n_boxes_filled = 4;
    
    /#
        if ( getdvarint( "<dev string:x28>" ) > 0 )
        {
            n_kills = 1;
            n_zone_caps = 2;
            n_points_spent = 500;
            n_boxes_filled = 1;
        }
    #/
    
    zm_challenges_tomb::add_stat( "zc_headshots", 0, &"ZM_TOMB_CH1", n_kills, undefined, &reward_packed_weapon );
    zm_challenges_tomb::add_stat( "zc_zone_captures", 0, &"ZM_TOMB_CH2", n_zone_caps, undefined, &reward_powerup_max_ammo );
    zm_challenges_tomb::add_stat( "zc_points_spent", 0, &"ZM_TOMB_CH3", n_points_spent, undefined, &reward_double_tap, &track_points_spent );
    zm_challenges_tomb::add_stat( "zc_boxes_filled", 1, &"ZM_TOMB_CHT", n_boxes_filled, undefined, &reward_one_inch_punch, &init_box_footprints );
}

// Namespace zm_tomb_challenges
// Params 0
// Checksum 0x60dc65b4, Offset: 0x738
// Size: 0x58
function track_points_spent()
{
    while ( true )
    {
        level waittill( #"spent_points", player, points );
        player zm_challenges_tomb::increment_stat( "zc_points_spent", points );
    }
}

// Namespace zm_tomb_challenges
// Params 0
// Checksum 0xbccb72c0, Offset: 0x798
// Size: 0x9c
function init_box_footprints()
{
    level.n_soul_boxes_completed = 0;
    level flag::init( "vo_soul_box_intro_played" );
    level flag::init( "vo_soul_box_continue_played" );
    a_boxes = getentarray( "foot_box", "script_noteworthy" );
    array::thread_all( a_boxes, &box_footprint_think );
}

// Namespace zm_tomb_challenges
// Params 0
// Checksum 0x47476cd2, Offset: 0x840
// Size: 0x724
function box_footprint_think()
{
    self.n_souls_absorbed = 0;
    self disconnectpaths();
    n_souls_required = 30;
    
    /#
        if ( getdvarint( "<dev string:x28>" ) > 0 )
        {
            n_souls_required = 10;
        }
    #/
    
    self thread watch_for_foot_stomp();
    wait 1;
    self clientfield::set( "foot_print_box_glow", 1 );
    wait 1;
    self clientfield::set( "foot_print_box_glow", 0 );
    
    while ( self.n_souls_absorbed < n_souls_required )
    {
        self waittill( #"soul_absorbed", player );
        self.n_souls_absorbed++;
        
        if ( self.n_souls_absorbed == 1 )
        {
            self thread scene::play( "p7_fxanim_zm_ori_challenge_box_open_bundle", self );
            self util::delay( 1, undefined, &clientfield::set, "foot_print_box_glow", 1 );
            
            if ( isdefined( player ) && !level flag::get( "vo_soul_box_intro_played" ) )
            {
                player util::delay( 1.5, undefined, &zm_tomb_vo::richtofenrespondvoplay, "zm_box_start", 0, "vo_soul_box_intro_played" );
            }
        }
        
        if ( self.n_souls_absorbed == floor( n_souls_required / 4 ) )
        {
            if ( isdefined( player ) && level flag::get( "vo_soul_box_intro_played" ) && !level flag::get( "vo_soul_box_continue_played" ) )
            {
                player thread zm_tomb_vo::richtofenrespondvoplay( "zm_box_continue", 1, "vo_soul_box_continue_played" );
            }
        }
        
        if ( self.n_souls_absorbed == floor( n_souls_required / 2 ) || self.n_souls_absorbed == floor( n_souls_required / 1.3 ) )
        {
            if ( isdefined( player ) )
            {
                player zm_audio::create_and_play_dialog( "soul_box", "zm_box_encourage" );
            }
        }
        
        if ( self.n_souls_absorbed == n_souls_required )
        {
            wait 1;
            self scene::play( "p7_fxanim_zm_ori_challenge_box_close_bundle", self );
        }
    }
    
    self notify( #"box_finished" );
    level.n_soul_boxes_completed++;
    self scene::stop( "p7_fxanim_zm_ori_challenge_box_close_bundle", self );
    e_volume = getent( self.target, "targetname" );
    e_volume delete();
    self util::delay( 0.5, undefined, &clientfield::set, "foot_print_box_glow", 0 );
    wait 2;
    self stopanimscripted();
    v_start_angles = self.angles;
    self movez( 30, 1, 1 );
    self.angles = v_start_angles;
    playsoundatposition( "zmb_footprintbox_disappear", self.origin );
    wait 0.5;
    n_rotations = randomintrange( 5, 7 );
    
    for ( i = 0; i < n_rotations ; i++ )
    {
        v_rotate_angles = v_start_angles + ( randomfloatrange( -10, 10 ), randomfloatrange( -10, 10 ), randomfloatrange( -10, 10 ) );
        n_rotate_time = randomfloatrange( 0.2, 0.4 );
        self rotateto( v_rotate_angles, n_rotate_time );
        self waittill( #"rotatedone" );
    }
    
    self rotateto( v_start_angles, 0.3 );
    self movez( -60, 0.5, 0.5 );
    self waittill( #"rotatedone" );
    trace_start = self.origin + ( 0, 0, 200 );
    trace_end = self.origin;
    fx_trace = bullettrace( trace_start, trace_end, 0, self );
    playfx( level._effect[ "mech_booster_landing" ], fx_trace[ "position" ], anglestoforward( self.angles ), anglestoup( self.angles ) );
    self waittill( #"movedone" );
    level zm_challenges_tomb::increment_stat( "zc_boxes_filled" );
    
    if ( isdefined( player ) )
    {
        if ( level.n_soul_boxes_completed == 1 )
        {
            player thread zm_tomb_vo::richtofenrespondvoplay( "zm_box_complete" );
        }
        else if ( level.n_soul_boxes_completed == 4 )
        {
            player thread zm_tomb_vo::richtofenrespondvoplay( "zm_box_final_complete", 1 );
        }
    }
    
    self connectpaths();
    self delete();
}

// Namespace zm_tomb_challenges
// Params 0
// Checksum 0xc06ae652, Offset: 0xf70
// Size: 0x98
function watch_for_foot_stomp()
{
    self endon( #"box_finished" );
    
    while ( true )
    {
        self waittill( #"robot_foot_stomp" );
        self scene::play( "p7_fxanim_zm_ori_challenge_box_close_bundle", self );
        self clientfield::set( "foot_print_box_glow", 0 );
        self.n_souls_absorbed = 0;
        wait 5;
        self scene::stop( "p7_fxanim_zm_ori_challenge_box_close_bundle", self );
    }
}

// Namespace zm_tomb_challenges
// Params 1
// Checksum 0x843af902, Offset: 0x1010
// Size: 0x152, Type: bool
function footprint_zombie_killed( attacker )
{
    a_volumes = getentarray( "foot_box_volume", "script_noteworthy" );
    
    foreach ( e_volume in a_volumes )
    {
        if ( self istouching( e_volume ) && isdefined( attacker ) && isplayer( attacker ) )
        {
            self clientfield::set( "foot_print_box_fx", 1 );
            m_box = getent( e_volume.target, "targetname" );
            m_box notify( #"soul_absorbed", attacker );
            return true;
        }
    }
    
    return false;
}

// Namespace zm_tomb_challenges
// Params 2
// Checksum 0x693573fd, Offset: 0x1170
// Size: 0x360, Type: bool
function reward_packed_weapon( player, s_stat )
{
    if ( !isdefined( s_stat.w_reward ) )
    {
        a_weapons = array( "smg_capacity", "smg_mp40_1940", "ar_accurate" );
        var_7e5dd894 = getweapon( array::random( a_weapons ) );
        s_stat.w_reward = zm_weapons::get_upgrade_weapon( var_7e5dd894 );
    }
    
    m_weapon = spawn( "script_model", self.origin );
    m_weapon.angles = self.angles + ( 0, 180, 0 );
    m_weapon playsound( "zmb_spawn_powerup" );
    m_weapon playloopsound( "zmb_spawn_powerup_loop", 0.5 );
    str_model = getweaponmodel( s_stat.w_reward );
    options = player zm_weapons::get_pack_a_punch_weapon_options( s_stat.w_reward );
    m_weapon useweaponmodel( s_stat.w_reward, str_model, options );
    util::wait_network_frame();
    
    if ( !zm_challenges_tomb::reward_rise_and_grab( m_weapon, 50, 2, 2, 10 ) )
    {
        return false;
    }
    
    weapon_limit = zm_utility::get_player_weapon_limit( player );
    primaries = player getweaponslistprimaries();
    
    if ( isdefined( primaries ) && primaries.size >= weapon_limit )
    {
        player zm_weapons::weapon_give( s_stat.w_reward );
    }
    else
    {
        player zm_weapons::give_build_kit_weapon( s_stat.w_reward );
        player givestartammo( s_stat.w_reward );
    }
    
    player switchtoweapon( s_stat.w_reward );
    m_weapon stoploopsound( 0.1 );
    player playsound( "zmb_powerup_grabbed" );
    m_weapon delete();
    return true;
}

// Namespace zm_tomb_challenges
// Params 2
// Checksum 0xa8217238, Offset: 0x14d8
// Size: 0x32
function reward_powerup_max_ammo( player, s_stat )
{
    return reward_powerup( player, "full_ammo" );
}

// Namespace zm_tomb_challenges
// Params 2
// Checksum 0xded5b6d2, Offset: 0x1518
// Size: 0x32
function reward_powerup_double_points( player, n_timeout )
{
    return reward_powerup( player, "double_points", n_timeout );
}

// Namespace zm_tomb_challenges
// Params 2
// Checksum 0x5da3c5b5, Offset: 0x1558
// Size: 0x32
function reward_powerup_zombie_blood( player, n_timeout )
{
    return reward_powerup( player, "zombie_blood", n_timeout );
}

// Namespace zm_tomb_challenges
// Params 3
// Checksum 0x88284733, Offset: 0x1598
// Size: 0x2b0
function reward_powerup( player, str_powerup, n_timeout )
{
    if ( !isdefined( n_timeout ) )
    {
        n_timeout = 10;
    }
    
    if ( !isdefined( level.zombie_powerups[ str_powerup ] ) )
    {
        return;
    }
    
    s_powerup = level.zombie_powerups[ str_powerup ];
    m_reward = spawn( "script_model", self.origin );
    m_reward.angles = self.angles + ( 0, 180, 0 );
    m_reward setmodel( s_powerup.model_name );
    m_reward playsound( "zmb_spawn_powerup" );
    m_reward playloopsound( "zmb_spawn_powerup_loop", 0.5 );
    util::wait_network_frame();
    
    if ( !zm_challenges_tomb::reward_rise_and_grab( m_reward, 50, 2, 2, n_timeout ) )
    {
        return 0;
    }
    
    m_reward.hint = s_powerup.hint;
    
    if ( !isdefined( player ) )
    {
        player = self.player_using;
    }
    
    switch ( str_powerup )
    {
        case "full_ammo":
            level thread zm_powerup_full_ammo::full_ammo_powerup( m_reward, player );
            player thread zm_powerups::powerup_vo( "full_ammo" );
            break;
        case "double_points":
            level thread zm_powerup_double_points::double_points_powerup( m_reward, player );
            player thread zm_powerups::powerup_vo( "double_points" );
            break;
        default:
            level thread zm_powerup_zombie_blood::zombie_blood_powerup( m_reward, player );
            break;
    }
    
    wait 0.1;
    m_reward stoploopsound( 0.1 );
    player playsound( "zmb_powerup_grabbed" );
    m_reward delete();
    return 1;
}

// Namespace zm_tomb_challenges
// Params 2
// Checksum 0x3131f67f, Offset: 0x1850
// Size: 0x240, Type: bool
function reward_double_tap( player, s_stat )
{
    m_reward = spawn( "script_model", self.origin );
    m_reward.angles = self.angles + ( 0, 180, 0 );
    str_model = getweaponmodel( getweapon( "zombie_perk_bottle_doubletap" ) );
    m_reward setmodel( str_model );
    m_reward playsound( "zmb_spawn_powerup" );
    m_reward playloopsound( "zmb_spawn_powerup_loop", 0.5 );
    util::wait_network_frame();
    
    if ( !zm_challenges_tomb::reward_rise_and_grab( m_reward, 50, 2, 2, 10 ) )
    {
        return false;
    }
    
    if ( player hasperk( "specialty_doubletap2" ) || player zm_perks::has_perk_paused( "specialty_doubletap2" ) )
    {
        m_reward thread bottle_reject_sink( player );
        return false;
    }
    
    m_reward stoploopsound( 0.1 );
    player playsound( "zmb_powerup_grabbed" );
    m_reward thread zm_perks::vending_trigger_post_think( player, "specialty_doubletap2" );
    m_reward ghost();
    player waittill( #"burp" );
    wait 1.2;
    m_reward delete();
    return true;
}

// Namespace zm_tomb_challenges
// Params 1
// Checksum 0x9ba3b77e, Offset: 0x1a98
// Size: 0x74
function bottle_reject_sink( player )
{
    n_time = 1;
    player playlocalsound( level.zmb_laugh_alias );
    self thread zm_challenges_tomb::reward_sink( 0, 61, n_time );
    wait n_time;
    self delete();
}

// Namespace zm_tomb_challenges
// Params 2
// Checksum 0xf644b7e0, Offset: 0x1b18
// Size: 0x1c8, Type: bool
function reward_one_inch_punch( player, s_stat )
{
    m_reward = spawn( "script_model", self.origin );
    m_reward.angles = self.angles + ( 0, 180, 0 );
    m_reward setmodel( "tag_origin" );
    playfxontag( level._effect[ "staff_soul" ], m_reward, "tag_origin" );
    m_reward playsound( "zmb_spawn_powerup" );
    m_reward playloopsound( "zmb_spawn_powerup_loop", 0.5 );
    util::wait_network_frame();
    
    if ( !zm_challenges_tomb::reward_rise_and_grab( m_reward, 50, 2, 2, 10 ) )
    {
        return false;
    }
    
    player thread _zm_weap_one_inch_punch::one_inch_punch_melee_attack();
    m_reward stoploopsound( 0.1 );
    player playsound( "zmb_powerup_grabbed" );
    m_reward delete();
    player thread one_inch_punch_watch_for_death( s_stat );
    return true;
}

// Namespace zm_tomb_challenges
// Params 1
// Checksum 0x4d3c8b16, Offset: 0x1ce8
// Size: 0x62
function one_inch_punch_watch_for_death( s_stat )
{
    self endon( #"disconnect" );
    self waittill( #"bled_out" );
    
    if ( s_stat.b_reward_claimed )
    {
        s_stat.b_reward_claimed = 0;
    }
    
    s_stat.a_b_player_rewarded[ self.characterindex ] = 0;
}

// Namespace zm_tomb_challenges
// Params 2
// Checksum 0xab1b3491, Offset: 0x1d58
// Size: 0x200, Type: bool
function reward_beacon( player, s_stat )
{
    m_reward = spawn( "script_model", self.origin );
    m_reward.angles = self.angles + ( 0, 180, 0 );
    str_model = getweaponmodel( level.w_beacon );
    m_reward setmodel( str_model );
    m_reward playsound( "zmb_spawn_powerup" );
    m_reward playloopsound( "zmb_spawn_powerup_loop", 0.5 );
    util::wait_network_frame();
    
    if ( !zm_challenges_tomb::reward_rise_and_grab( m_reward, 50, 2, 2, 10 ) )
    {
        return false;
    }
    
    player zm_weapons::weapon_give( level.w_beacon );
    
    if ( isdefined( level.zombie_include_weapons[ level.w_beacon ] ) & !level.zombie_include_weapons[ level.w_beacon ] )
    {
        level.zombie_include_weapons[ level.w_beacon ] = 1;
        level.zombie_weapons[ level.w_beacon ].is_in_box = 1;
    }
    
    m_reward stoploopsound( 0.1 );
    player playsound( "zmb_powerup_grabbed" );
    m_reward delete();
    return true;
}

// Namespace zm_tomb_challenges
// Params 1
// Checksum 0x319fb4e2, Offset: 0x1f60
// Size: 0x1a
function getweaponmodel( weapon )
{
    return weapon.worldmodel;
}

