#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades_system;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_pers_upgrades;

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xf069e25a, Offset: 0x3b8
// Size: 0xec
function pers_upgrade_init()
{
    setup_pers_upgrade_boards();
    setup_pers_upgrade_revive();
    setup_pers_upgrade_multi_kill_headshots();
    setup_pers_upgrade_cash_back();
    setup_pers_upgrade_insta_kill();
    setup_pers_upgrade_jugg();
    setup_pers_upgrade_carpenter();
    setup_pers_upgrade_perk_lose();
    setup_pers_upgrade_pistol_points();
    setup_pers_upgrade_double_points();
    setup_pers_upgrade_sniper();
    setup_pers_upgrade_box_weapon();
    setup_pers_upgrade_nube();
    level thread zm_pers_upgrades_system::pers_upgrades_monitor();
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x502ac88d, Offset: 0x4b0
// Size: 0xa4
function pers_abilities_init_globals()
{
    self.successful_revives = 0;
    self.failed_revives = 0;
    self.failed_cash_back_prones = 0;
    self.pers[ "last_headshot_kill_time" ] = gettime();
    self.pers[ "zombies_multikilled" ] = 0;
    self.non_headshot_kill_counter = 0;
    
    if ( isdefined( level.pers_upgrade_box_weapon ) && level.pers_upgrade_box_weapon )
    {
        self.pers_box_weapon_awarded = undefined;
    }
    
    if ( isdefined( level.pers_upgrade_nube ) && level.pers_upgrade_nube )
    {
        self thread zm_pers_upgrades_functions::pers_nube_unlock_watcher();
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xca89964, Offset: 0x560
// Size: 0x34, Type: bool
function is_pers_system_active()
{
    if ( !zm_utility::is_classic() )
    {
        return false;
    }
    
    if ( is_pers_system_disabled() )
    {
        return false;
    }
    
    return false;
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xdf03d28b, Offset: 0x5a0
// Size: 0x6, Type: bool
function is_pers_system_disabled()
{
    return false;
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x21539d0b, Offset: 0x5b0
// Size: 0x6c
function setup_pers_upgrade_boards()
{
    if ( isdefined( level.pers_upgrade_boards ) && level.pers_upgrade_boards )
    {
        level.pers_boarding_round_start = 10;
        level.pers_boarding_number_of_boards_required = 74;
        zm_pers_upgrades_system::pers_register_upgrade( "board", &pers_upgrade_boards_active, "pers_boarding", level.pers_boarding_number_of_boards_required, 0 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x1129ebbc, Offset: 0x628
// Size: 0x74
function setup_pers_upgrade_revive()
{
    if ( isdefined( level.pers_upgrade_revive ) && level.pers_upgrade_revive )
    {
        level.pers_revivenoperk_number_of_revives_required = 17;
        level.pers_revivenoperk_number_of_chances_to_keep = 1;
        zm_pers_upgrades_system::pers_register_upgrade( "revive", &pers_upgrade_revive_active, "pers_revivenoperk", level.pers_revivenoperk_number_of_revives_required, 1 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xf2c7ddb8, Offset: 0x6a8
// Size: 0x6c
function setup_pers_upgrade_multi_kill_headshots()
{
    if ( isdefined( level.pers_upgrade_multi_kill_headshots ) && level.pers_upgrade_multi_kill_headshots )
    {
        level.pers_multikill_headshots_required = 5;
        level.pers_multikill_headshots_upgrade_reset_counter = 25;
        zm_pers_upgrades_system::pers_register_upgrade( "multikill_headshots", &pers_upgrade_headshot_active, "pers_multikill_headshots", level.pers_multikill_headshots_required, 0 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xb11726ea, Offset: 0x720
// Size: 0xac
function setup_pers_upgrade_cash_back()
{
    if ( isdefined( level.pers_upgrade_cash_back ) && level.pers_upgrade_cash_back )
    {
        level.pers_cash_back_num_perks_required = 50;
        level.pers_cash_back_perk_buys_prone_required = 15;
        level.pers_cash_back_failed_prones = 1;
        level.pers_cash_back_money_reward = 1000;
        zm_pers_upgrades_system::pers_register_upgrade( "cash_back", &pers_upgrade_cash_back_active, "pers_cash_back_bought", level.pers_cash_back_num_perks_required, 0 );
        zm_pers_upgrades_system::add_pers_upgrade_stat( "cash_back", "pers_cash_back_prone", level.pers_cash_back_perk_buys_prone_required );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x5bd2f3a9, Offset: 0x7d8
// Size: 0x6c
function setup_pers_upgrade_insta_kill()
{
    if ( isdefined( level.pers_upgrade_insta_kill ) && level.pers_upgrade_insta_kill )
    {
        level.pers_insta_kill_num_required = 2;
        level.pers_insta_kill_upgrade_active_time = 18;
        zm_pers_upgrades_system::pers_register_upgrade( "insta_kill", &pers_upgrade_insta_kill_active, "pers_insta_kill", level.pers_insta_kill_num_required, 0 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x9e6da8c, Offset: 0x850
// Size: 0x94
function setup_pers_upgrade_jugg()
{
    if ( isdefined( level.pers_upgrade_jugg ) && level.pers_upgrade_jugg )
    {
        level.pers_jugg_hit_and_die_total = 3;
        level.pers_jugg_hit_and_die_round_limit = 2;
        level.pers_jugg_round_reached_max = 1;
        level.pers_jugg_round_lose_target = 15;
        level.pers_jugg_upgrade_health_bonus = 90;
        zm_pers_upgrades_system::pers_register_upgrade( "jugg", &pers_upgrade_jugg_active, "pers_jugg", level.pers_jugg_hit_and_die_total, 0 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x390d2c19, Offset: 0x8f0
// Size: 0x64
function setup_pers_upgrade_carpenter()
{
    if ( isdefined( level.pers_upgrade_carpenter ) && level.pers_upgrade_carpenter )
    {
        level.pers_carpenter_zombie_kills = 1;
        zm_pers_upgrades_system::pers_register_upgrade( "carpenter", &pers_upgrade_carpenter_active, "pers_carpenter", level.pers_carpenter_zombie_kills, 0 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x94160e9, Offset: 0x960
// Size: 0x6c
function setup_pers_upgrade_perk_lose()
{
    if ( isdefined( level.pers_upgrade_perk_lose ) && level.pers_upgrade_perk_lose )
    {
        level.pers_perk_round_reached_max = 6;
        level.pers_perk_lose_counter = 3;
        zm_pers_upgrades_system::pers_register_upgrade( "perk_lose", &pers_upgrade_perk_lose_active, "pers_perk_lose_counter", level.pers_perk_lose_counter, 0 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x35a35f31, Offset: 0x9d8
// Size: 0x7c
function setup_pers_upgrade_pistol_points()
{
    if ( isdefined( level.pers_upgrade_pistol_points ) && level.pers_upgrade_pistol_points )
    {
        level.pers_pistol_points_num_kills_in_game = 8;
        level.pers_pistol_points_accuracy = 0.25;
        level.pers_pistol_points_counter = 1;
        zm_pers_upgrades_system::pers_register_upgrade( "pistol_points", &pers_upgrade_pistol_points_active, "pers_pistol_points_counter", level.pers_pistol_points_counter, 0 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x95222e62, Offset: 0xa60
// Size: 0x6c
function setup_pers_upgrade_double_points()
{
    if ( isdefined( level.pers_upgrade_double_points ) && level.pers_upgrade_double_points )
    {
        level.pers_double_points_score = 2500;
        level.pers_double_points_counter = 1;
        zm_pers_upgrades_system::pers_register_upgrade( "double_points", &pers_upgrade_double_points_active, "pers_double_points_counter", level.pers_double_points_counter, 0 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x491cd130, Offset: 0xad8
// Size: 0x84
function setup_pers_upgrade_sniper()
{
    if ( isdefined( level.pers_upgrade_sniper ) && level.pers_upgrade_sniper )
    {
        level.pers_sniper_round_kills_counter = 5;
        level.pers_sniper_kill_distance = 800;
        level.pers_sniper_counter = 1;
        level.pers_sniper_misses = 3;
        zm_pers_upgrades_system::pers_register_upgrade( "sniper", &pers_upgrade_sniper_active, "pers_sniper_counter", level.pers_sniper_counter, 0 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x9d39d1ef, Offset: 0xb68
// Size: 0x6c
function setup_pers_upgrade_box_weapon()
{
    if ( isdefined( level.pers_upgrade_box_weapon ) && level.pers_upgrade_box_weapon )
    {
        level.pers_box_weapon_counter = 5;
        level.pers_box_weapon_lose_round = 10;
        zm_pers_upgrades_system::pers_register_upgrade( "box_weapon", &pers_upgrade_box_weapon_active, "pers_box_weapon_counter", level.pers_box_weapon_counter, 0 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x60153df5, Offset: 0xbe0
// Size: 0x7c
function setup_pers_upgrade_nube()
{
    if ( isdefined( level.pers_upgrade_nube ) && level.pers_upgrade_nube )
    {
        level.pers_nube_counter = 1;
        level.pers_nube_lose_round = 10;
        level.pers_numb_num_kills_unlock = 5;
        zm_pers_upgrades_system::pers_register_upgrade( "nube", &pers_upgrade_nube_active, "pers_nube_counter", level.pers_nube_counter, 0 );
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xabd8812d, Offset: 0xc68
// Size: 0xa0
function pers_upgrade_boards_active()
{
    self endon( #"disconnect" );
    
    for ( last_round_number = level.round_number; true ; last_round_number = level.round_number )
    {
        self waittill( #"pers_stats_end_of_round" );
        
        if ( level.round_number >= last_round_number )
        {
            if ( is_pers_system_active() )
            {
                if ( self.rebuild_barrier_reward == 0 )
                {
                    self zm_stats::zero_client_stat( "pers_boarding", 0 );
                    return;
                }
            }
        }
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x3b4e8b1a, Offset: 0xd10
// Size: 0x7e
function pers_upgrade_revive_active()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"player_failed_revive" );
        
        if ( is_pers_system_active() )
        {
            if ( self.failed_revives >= level.pers_revivenoperk_number_of_chances_to_keep )
            {
                self zm_stats::zero_client_stat( "pers_revivenoperk", 0 );
                self.failed_revives = 0;
                return;
            }
        }
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x881a1220, Offset: 0xd98
// Size: 0x86
function pers_upgrade_headshot_active()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"zombie_death_no_headshot" );
        
        if ( is_pers_system_active() )
        {
            self.non_headshot_kill_counter++;
            
            if ( self.non_headshot_kill_counter >= level.pers_multikill_headshots_upgrade_reset_counter )
            {
                self zm_stats::zero_client_stat( "pers_multikill_headshots", 0 );
                self.non_headshot_kill_counter = 0;
                return;
            }
        }
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x55f61829, Offset: 0xe28
// Size: 0xd2
function pers_upgrade_cash_back_active()
{
    self endon( #"disconnect" );
    wait 0.5;
    
    /#
    #/
    
    wait 0.5;
    
    while ( true )
    {
        self waittill( #"cash_back_failed_prone" );
        wait 0.1;
        
        /#
        #/
        
        if ( is_pers_system_active() )
        {
            self.failed_cash_back_prones++;
            
            if ( self.failed_cash_back_prones >= level.pers_cash_back_failed_prones )
            {
                self zm_stats::zero_client_stat( "pers_cash_back_bought", 0 );
                self zm_stats::zero_client_stat( "pers_cash_back_prone", 0 );
                self.failed_cash_back_prones = 0;
                wait 0.4;
                
                /#
                #/
                
                return;
            }
        }
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xb0c3e7ca, Offset: 0xf08
// Size: 0x158
function pers_upgrade_insta_kill_active()
{
    self endon( #"disconnect" );
    wait 0.2;
    
    /#
    #/
    
    wait 0.2;
    
    while ( true )
    {
        self waittill( #"pers_melee_swipe" );
        
        if ( is_pers_system_active() )
        {
            if ( isdefined( level.pers_melee_swipe_zombie_swiper ) )
            {
                e_zombie = level.pers_melee_swipe_zombie_swiper;
                
                if ( isdefined( e_zombie.is_zombie ) && isalive( e_zombie ) && e_zombie.is_zombie )
                {
                    e_zombie.marked_for_insta_upgraded_death = 1;
                    e_zombie dodamage( e_zombie.health + 666, e_zombie.origin, self, self, "none", "MOD_PISTOL_BULLET", 0 );
                }
                
                level.pers_melee_swipe_zombie_swiper = undefined;
            }
            
            break;
        }
    }
    
    self zm_stats::zero_client_stat( "pers_insta_kill", 0 );
    self kill_insta_kill_upgrade_hud_icon();
    wait 0.4;
    
    /#
    #/
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x4e6ba02b, Offset: 0x1068
// Size: 0x64, Type: bool
function is_insta_kill_upgraded_and_active()
{
    if ( is_pers_system_active() )
    {
        if ( self zm_powerups::is_insta_kill_active() )
        {
            if ( isdefined( self.pers_upgrades_awarded[ "insta_kill" ] ) && self.pers_upgrades_awarded[ "insta_kill" ] )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xfa10ce0a, Offset: 0x10d8
// Size: 0x134
function pers_upgrade_jugg_active()
{
    self endon( #"disconnect" );
    wait 0.5;
    
    /#
    #/
    
    wait 0.5;
    self zm_perks::perk_set_max_health_if_jugg( "jugg_upgrade", 1, 0 );
    
    while ( true )
    {
        level waittill( #"start_of_round" );
        
        if ( is_pers_system_active() )
        {
            if ( level.round_number == level.pers_jugg_round_lose_target )
            {
                /#
                #/
                
                self zm_stats::increment_client_stat( "pers_jugg_downgrade_count", 0 );
                wait 0.5;
                
                if ( self.pers[ "pers_jugg_downgrade_count" ] >= level.pers_jugg_round_reached_max )
                {
                    break;
                }
            }
        }
    }
    
    self zm_perks::perk_set_max_health_if_jugg( "jugg_upgrade", 1, 1 );
    
    /#
    #/
    
    self zm_stats::zero_client_stat( "pers_jugg", 0 );
    self zm_stats::zero_client_stat( "pers_jugg_downgrade_count", 0 );
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xce114927, Offset: 0x1218
// Size: 0xb8
function pers_upgrade_carpenter_active()
{
    self endon( #"disconnect" );
    wait 0.2;
    
    /#
    #/
    
    wait 0.2;
    level waittill( #"carpenter_finished" );
    self.pers_carpenter_kill = undefined;
    
    while ( true )
    {
        self waittill( #"carpenter_zombie_killed_check_finished" );
        
        if ( is_pers_system_active() )
        {
            if ( !isdefined( self.pers_carpenter_kill ) )
            {
                break;
            }
            
            /#
            #/
        }
        
        self.pers_carpenter_kill = undefined;
    }
    
    self zm_stats::zero_client_stat( "pers_carpenter", 0 );
    wait 0.4;
    
    /#
    #/
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xcd6fea34, Offset: 0x12d8
// Size: 0x1b6
function persistent_carpenter_ability_check()
{
    if ( isdefined( level.pers_upgrade_carpenter ) && level.pers_upgrade_carpenter )
    {
        self endon( #"disconnect" );
        
        /#
        #/
        
        if ( isdefined( self.pers_upgrades_awarded[ "carpenter" ] ) && self.pers_upgrades_awarded[ "carpenter" ] )
        {
            level.pers_carpenter_boards_active = 1;
        }
        
        self.pers_carpenter_zombie_check_active = 1;
        self.pers_carpenter_kill = undefined;
        carpenter_extra_time = 3;
        carpenter_finished_start_time = undefined;
        level.carpenter_finished_start_time = undefined;
        
        while ( true )
        {
            if ( !is_pers_system_disabled() )
            {
                if ( !isdefined( level.carpenter_powerup_active ) )
                {
                    if ( !isdefined( level.carpenter_finished_start_time ) )
                    {
                        level.carpenter_finished_start_time = gettime();
                    }
                    
                    time = gettime();
                    dt = ( time - level.carpenter_finished_start_time ) / 1000;
                    
                    if ( dt >= carpenter_extra_time )
                    {
                        break;
                    }
                }
                
                if ( isdefined( self.pers_carpenter_kill ) )
                {
                    if ( isdefined( self.pers_upgrades_awarded[ "carpenter" ] ) && self.pers_upgrades_awarded[ "carpenter" ] )
                    {
                        break;
                    }
                    else
                    {
                        self zm_stats::increment_client_stat( "pers_carpenter", 0 );
                    }
                }
            }
            
            wait 0.01;
        }
        
        self notify( #"carpenter_zombie_killed_check_finished" );
        self.pers_carpenter_zombie_check_active = undefined;
        level.pers_carpenter_boards_active = undefined;
    }
}

// Namespace zm_pers_upgrades
// Params 2
// Checksum 0xf6878a2f, Offset: 0x1498
// Size: 0x78
function pers_zombie_death_location_check( attacker, v_pos )
{
    if ( is_pers_system_active() )
    {
        if ( zm_utility::is_player_valid( attacker ) )
        {
            if ( isdefined( attacker.pers_carpenter_zombie_check_active ) )
            {
                if ( !zm_utility::check_point_in_playable_area( v_pos ) )
                {
                    attacker.pers_carpenter_kill = 1;
                }
            }
        }
    }
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xfd8d30e4, Offset: 0x1518
// Size: 0x6c
function insta_kill_pers_upgrade_icon()
{
    if ( self.zombie_vars[ "zombie_powerup_insta_kill_ug_on" ] )
    {
        self.zombie_vars[ "zombie_powerup_insta_kill_ug_time" ] = level.pers_insta_kill_upgrade_active_time;
        return;
    }
    
    self.zombie_vars[ "zombie_powerup_insta_kill_ug_on" ] = 1;
    self._show_solo_hud = 1;
    self thread time_remaining_pers_upgrade();
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x4490c489, Offset: 0x1590
// Size: 0x7c
function time_remaining_pers_upgrade()
{
    self endon( #"disconnect" );
    self endon( #"kill_insta_kill_upgrade_hud_icon" );
    
    while ( self.zombie_vars[ "zombie_powerup_insta_kill_ug_time" ] >= 0 )
    {
        wait 0.05;
        self.zombie_vars[ "zombie_powerup_insta_kill_ug_time" ] = self.zombie_vars[ "zombie_powerup_insta_kill_ug_time" ] - 0.05;
    }
    
    self kill_insta_kill_upgrade_hud_icon();
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xa5566df1, Offset: 0x1618
// Size: 0x4a
function kill_insta_kill_upgrade_hud_icon()
{
    self.zombie_vars[ "zombie_powerup_insta_kill_ug_on" ] = 0;
    self._show_solo_hud = 0;
    self.zombie_vars[ "zombie_powerup_insta_kill_ug_time" ] = level.pers_insta_kill_upgrade_active_time;
    self notify( #"kill_insta_kill_upgrade_hud_icon" );
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x25c3e0fb, Offset: 0x1670
// Size: 0x94
function pers_upgrade_perk_lose_active()
{
    self endon( #"disconnect" );
    wait 0.5;
    
    /#
        iprintlnbold( "<dev string:x28>" );
    #/
    
    wait 0.5;
    self.pers_perk_lose_start_round = level.round_number;
    self waittill( #"pers_perk_lose_lost" );
    
    /#
        iprintlnbold( "<dev string:x4d>" );
    #/
    
    self zm_stats::zero_client_stat( "pers_perk_lose_counter", 0 );
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xdb8a6008, Offset: 0x1710
// Size: 0xc4
function pers_upgrade_pistol_points_active()
{
    self endon( #"disconnect" );
    wait 0.5;
    
    /#
        iprintlnbold( "<dev string:x73>" );
    #/
    
    wait 0.5;
    
    while ( true )
    {
        self waittill( #"pers_pistol_points_kill" );
        accuracy = self zm_pers_upgrades_functions::pers_get_player_accuracy();
        
        if ( accuracy > level.pers_pistol_points_accuracy )
        {
            break;
        }
    }
    
    /#
        iprintlnbold( "<dev string:x9c>" );
    #/
    
    self zm_stats::zero_client_stat( "pers_pistol_points_counter", 0 );
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x76dba4d3, Offset: 0x17e0
// Size: 0x84
function pers_upgrade_double_points_active()
{
    self endon( #"disconnect" );
    wait 0.5;
    
    /#
        iprintlnbold( "<dev string:xc6>" );
    #/
    
    wait 0.5;
    self waittill( #"double_points_lost" );
    
    /#
        iprintlnbold( "<dev string:xef>" );
    #/
    
    self zm_stats::zero_client_stat( "pers_double_points_counter", 0 );
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x881b71dd, Offset: 0x1870
// Size: 0x84
function pers_upgrade_sniper_active()
{
    self endon( #"disconnect" );
    wait 0.5;
    
    /#
        iprintlnbold( "<dev string:x119>" );
    #/
    
    wait 0.5;
    self waittill( #"pers_sniper_lost" );
    
    /#
        iprintlnbold( "<dev string:x13b>" );
    #/
    
    self zm_stats::zero_client_stat( "pers_sniper_counter", 0 );
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0xac48035d, Offset: 0x1900
// Size: 0xe4
function pers_upgrade_box_weapon_active()
{
    self endon( #"disconnect" );
    wait 0.5;
    
    /#
        iprintlnbold( "<dev string:x15e>" );
    #/
    
    self thread zm_pers_upgrades_functions::pers_magic_box_teddy_bear();
    wait 0.5;
    self.pers_box_weapon_awarded = 1;
    
    while ( true )
    {
        level waittill( #"start_of_round" );
        
        if ( is_pers_system_active() )
        {
            if ( level.round_number >= level.pers_box_weapon_lose_round )
            {
                break;
            }
        }
    }
    
    /#
        iprintlnbold( "<dev string:x184>" );
    #/
    
    self zm_stats::zero_client_stat( "pers_box_weapon_counter", 0 );
}

// Namespace zm_pers_upgrades
// Params 0
// Checksum 0x5663f4, Offset: 0x19f0
// Size: 0xc4
function pers_upgrade_nube_active()
{
    self endon( #"disconnect" );
    wait 0.5;
    
    /#
        iprintlnbold( "<dev string:x1ab>" );
    #/
    
    wait 0.5;
    
    while ( true )
    {
        level waittill( #"start_of_round" );
        
        if ( is_pers_system_active() )
        {
            if ( level.round_number >= level.pers_nube_lose_round )
            {
                break;
            }
        }
    }
    
    /#
        iprintlnbold( "<dev string:x1cb>" );
    #/
    
    self zm_stats::zero_client_stat( "pers_nube_counter", 0 );
}

