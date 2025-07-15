#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/zm/_zm_utility;

#namespace zm_cosmodrome_achievement;

// Namespace zm_cosmodrome_achievement
// Params 0
// Checksum 0x4d18a7be, Offset: 0x140
// Size: 0x54
function init()
{
    level thread achievement_the_eagle_has_landers();
    level thread achievement_chimp_on_the_barbie();
    level thread callback::on_connect( &onplayerconnect );
}

// Namespace zm_cosmodrome_achievement
// Params 0
// Checksum 0x5747e637, Offset: 0x1a0
// Size: 0x4c
function onplayerconnect()
{
    self thread achievement_all_dolled_up();
    self thread achievement_black_hole();
    self thread achievement_space_race();
}

// Namespace zm_cosmodrome_achievement
// Params 0
// Checksum 0xc3ce49ba, Offset: 0x1f8
// Size: 0x5c
function achievement_the_eagle_has_landers()
{
    level flag::wait_till_all( array( "lander_a_used", "lander_b_used", "lander_c_used" ) );
    level zm_utility::giveachievement_wrapper( "DLC2_ZOM_LUNARLANDERS", 1 );
}

// Namespace zm_cosmodrome_achievement
// Params 0
// Checksum 0x375410a, Offset: 0x260
// Size: 0xa2
function achievement_chimp_on_the_barbie()
{
    level endon( #"end_game" );
    
    for ( ;; )
    {
        level waittill( #"trap_kill", zombie, trap );
        
        if ( !isplayer( zombie ) && "monkey_zombie" == zombie.animname && "fire" == trap._trap_type )
        {
            zm_utility::giveachievement_wrapper( "DLC2_ZOM_FIREMONKEY", 1 );
            return;
        }
    }
}

// Namespace zm_cosmodrome_achievement
// Params 0
// Checksum 0xa715d891, Offset: 0x310
// Size: 0x28
function achievement_all_dolled_up()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self waittill( #"nesting_doll_kills_achievement" );
}

// Namespace zm_cosmodrome_achievement
// Params 0
// Checksum 0x83a49e50, Offset: 0x340
// Size: 0x28
function achievement_black_hole()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self waittill( #"black_hole_kills_achievement" );
}

// Namespace zm_cosmodrome_achievement
// Params 0
// Checksum 0x47f312e7, Offset: 0x370
// Size: 0x38
function achievement_space_race()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self waittill( #"pap_taken" );
    
    if ( 8 > level.round_number )
    {
    }
}

