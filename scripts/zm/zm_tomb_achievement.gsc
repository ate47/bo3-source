#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/gametypes/_globallogic_score;

#namespace zm_tomb_achievement;

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0x2832ffef, Offset: 0x4a8
// Size: 0x84
function init()
{
    level thread achievement_tomb_sidequest();
    level thread achievement_all_your_base();
    level thread achievement_playing_with_power();
    level.achievement_sound_func = &achievement_sound_func;
    callback::on_connect( &onplayerconnect );
}

// Namespace zm_tomb_achievement
// Params 1
// Checksum 0xc70cac1, Offset: 0x538
// Size: 0xac
function achievement_sound_func( achievement_name_lower )
{
    self endon( #"disconnect" );
    
    if ( !sessionmodeisonlinegame() )
    {
        return;
    }
    
    for ( i = 0; i < self getentitynumber() + 1 ; i++ )
    {
        util::wait_network_frame();
    }
    
    self thread zm_utility::do_player_general_vox( "general", "achievement" );
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0x194e32cb, Offset: 0x5f0
// Size: 0x15c
function init_player_achievement_stats()
{
    if ( !zm_utility::is_gametype_active( "zclassic" ) )
    {
        return;
    }
    
    self globallogic_score::initpersstat( "zm_dlc4_tomb_sidequest", 0 );
    self globallogic_score::initpersstat( "zm_dlc4_not_a_gold_digger", 0 );
    self globallogic_score::initpersstat( "zm_dlc4_all_your_base", 0 );
    self globallogic_score::initpersstat( "zm_dlc4_kung_fu_grip", 0 );
    self globallogic_score::initpersstat( "zm_dlc4_playing_with_power", 0 );
    self globallogic_score::initpersstat( "zm_dlc4_im_on_a_tank", 0 );
    self globallogic_score::initpersstat( "zm_dlc4_saving_the_day_all_day", 0 );
    self globallogic_score::initpersstat( "zm_dlc4_master_of_disguise", 0 );
    self globallogic_score::initpersstat( "zm_dlc4_overachiever", 0 );
    self globallogic_score::initpersstat( "zm_dlc4_master_wizard", 0 );
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0xa54df963, Offset: 0x758
// Size: 0xac
function onplayerconnect()
{
    self thread achievement_not_a_gold_digger();
    self thread achievement_kung_fu_grip();
    self thread achievement_im_on_a_tank();
    self thread achievement_saving_the_day_all_day();
    self thread achievement_master_of_disguise();
    self thread achievement_master_wizard();
    self thread achievement_overachiever();
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0x696681c6, Offset: 0x810
// Size: 0x44
function achievement_tomb_sidequest()
{
    level endon( #"end_game" );
    level waittill( #"tomb_sidequest_complete" );
    
    /#
    #/
    
    level zm_utility::giveachievement_wrapper( "ZM_DLC4_TOMB_SIDEQUEST", 1 );
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0x3bd4dd9, Offset: 0x860
// Size: 0x44
function achievement_all_your_base()
{
    level endon( #"end_game" );
    level waittill( #"all_zones_captured_none_lost" );
    
    /#
    #/
    
    level zm_utility::giveachievement_wrapper( "ZM_DLC4_ALL_YOUR_BASE", 1 );
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0x27539a04, Offset: 0x8b0
// Size: 0x30
function achievement_playing_with_power()
{
    level endon( #"end_game" );
    level flag::wait_till( "ee_all_staffs_crafted" );
    
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0x55a22d2f, Offset: 0x8e8
// Size: 0x4c
function achievement_overachiever()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self waittill( #"all_challenges_complete" );
    
    /#
    #/
    
    self zm_utility::giveachievement_wrapper( "ZM_DLC4_OVERACHIEVER" );
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0x823957c6, Offset: 0x940
// Size: 0x2c
function achievement_not_a_gold_digger()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self waittill( #"dig_up_weapon_shared" );
    
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0x3ab4ac5e, Offset: 0x978
// Size: 0x40
function achievement_kung_fu_grip()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self util::waittill_multiple( "mechz_grab_released_self", "mechz_grab_released_friendly" );
    
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0xae460701, Offset: 0x9c0
// Size: 0x2c
function achievement_im_on_a_tank()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self waittill( #"rode_tank_around_map" );
    
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0x91647976, Offset: 0x9f8
// Size: 0x50
function achievement_saving_the_day_all_day()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self util::waittill_multiple( "revived_player", "quick_revived_player", "revived_player_with_quadrotor", "revived_player_with_upgraded_staff" );
    
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0x1eca61fb, Offset: 0xa50
// Size: 0x136
function _zombie_blood_achievement_think()
{
    self endon( #"zombie_blood_over" );
    b_finished_achievement = 0;
    
    if ( !isdefined( self.zombie_blood_revives ) )
    {
        self.zombie_blood_revives = 0;
    }
    
    if ( !isdefined( self.zombie_blood_generators_started ) )
    {
        self.zombie_blood_generators_started = 0;
    }
    
    b_did_capture = 0;
    n_revives = 0;
    
    while ( true )
    {
        str_action = util::waittill_any_return( "completed_zone_capture", "do_revive_ended_normally", "revived_player_with_quadrotor", "revived_player_with_upgraded_staff", "zombie_blood_over" );
        
        if ( issubstr( str_action, "revive" ) )
        {
            self.zombie_blood_revives++;
        }
        else if ( str_action == "completed_zone_capture" )
        {
            self.zombie_blood_generators_started++;
        }
        
        if ( self.zombie_blood_generators_started > 0 && self.zombie_blood_revives >= 3 )
        {
            return 1;
        }
    }
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0xfe5ea9ea, Offset: 0xb90
// Size: 0x6e
function achievement_master_of_disguise()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"zombie_blood" );
        b_finished_achievement = self _zombie_blood_achievement_think();
        
        if ( isdefined( b_finished_achievement ) && b_finished_achievement )
        {
            break;
        }
    }
    
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0x8538899, Offset: 0xc08
// Size: 0xfe
function watch_equipped_weapons_for_upgraded_staffs()
{
    self endon( #"disconnect" );
    self endon( #"stop_weapon_switch_watcher_thread" );
    
    while ( true )
    {
        self waittill( #"weapon_change", w_weapon );
        
        if ( self.sessionstate != "playing" )
        {
            continue;
        }
        
        str_weapon = w_weapon.name;
        
        if ( str_weapon == "staff_water" )
        {
            self notify( #"upgraded_water_staff_equipped" );
            continue;
        }
        
        if ( str_weapon == "staff_lightning" )
        {
            self notify( #"upgraded_lightning_staff_equipped" );
            continue;
        }
        
        if ( str_weapon == "staff_fire" )
        {
            self notify( #"upgraded_fire_staff_equipped" );
            continue;
        }
        
        if ( str_weapon == "staff_air" )
        {
            self notify( #"upgraded_air_staff_equipped" );
        }
    }
}

// Namespace zm_tomb_achievement
// Params 0
// Checksum 0xdc2d3c8a, Offset: 0xd10
// Size: 0x76
function achievement_master_wizard()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self thread watch_equipped_weapons_for_upgraded_staffs();
    self util::waittill_multiple( "upgraded_air_staff_equipped", "upgraded_lightning_staff_equipped", "upgraded_water_staff_equipped", "upgraded_fire_staff_equipped" );
    self notify( #"stop_weapon_switch_watcher_thread" );
    
    /#
    #/
}

