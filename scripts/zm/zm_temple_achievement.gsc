#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;

#namespace zm_temple_achievement;

// Namespace zm_temple_achievement
// Params 0, eflags: 0x2
// Checksum 0x85d44949, Offset: 0x1a8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_temple_achievement", &__init__, undefined, undefined );
}

// Namespace zm_temple_achievement
// Params 0
// Checksum 0xce12fe37, Offset: 0x1e8
// Size: 0x3c
function __init__()
{
    level thread achievement_temple_sidequest();
    callback::on_connect( &onplayerconnect );
}

// Namespace zm_temple_achievement
// Params 0
// Checksum 0x29faf7cc, Offset: 0x230
// Size: 0x1c
function onplayerconnect()
{
    self thread achievement_small_consolation();
}

// Namespace zm_temple_achievement
// Params 0
// Checksum 0xfad500d5, Offset: 0x258
// Size: 0x4c
function achievement_temple_sidequest()
{
    level waittill( #"temple_sidequest_achieved" );
    level thread zm::set_sidequest_completed( "EOA" );
    level zm_utility::giveachievement_wrapper( "DLC4_ZOM_TEMPLE_SIDEQUEST", 1 );
}

// Namespace zm_temple_achievement
// Params 0
// Checksum 0xf7af4f49, Offset: 0x2b0
// Size: 0x1c
function achievement_zomb_disposal()
{
    level endon( #"end_game" );
    level waittill( #"zomb_disposal_achieved" );
}

// Namespace zm_temple_achievement
// Params 0
// Checksum 0x65b874d4, Offset: 0x2d8
// Size: 0x10
function achievement_monkey_see_monkey_dont()
{
    level waittill( #"monkey_see_monkey_dont_achieved" );
}

// Namespace zm_temple_achievement
// Params 0
// Checksum 0x56e8b40, Offset: 0x2f0
// Size: 0x28
function achievement_blinded_by_the_fright()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self waittill( #"blinded_by_the_fright_achieved" );
}

// Namespace zm_temple_achievement
// Params 0
// Checksum 0x8bcd3c81, Offset: 0x320
// Size: 0x174
function achievement_small_consolation()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon.name != "shrink_ray" && currentweapon.name != "shrink_ray_upgraded" )
        {
            continue;
        }
        
        waittillframeend();
        
        if ( isdefined( self.shrinked_zombies[ "monkey_zombie" ] ) && isdefined( self.shrinked_zombies[ "napalm_zombie" ] ) && isdefined( self.shrinked_zombies[ "sonic_zombie" ] ) && isdefined( self.shrinked_zombies[ "zombie" ] ) && isdefined( self.shrinked_zombies ) && self.shrinked_zombies[ "zombie" ] && self.shrinked_zombies[ "sonic_zombie" ] && self.shrinked_zombies[ "napalm_zombie" ] && self.shrinked_zombies[ "monkey_zombie" ] )
        {
            break;
        }
    }
    
    self zm_utility::giveachievement_wrapper( "DLC4_ZOM_SMALL_CONSOLATION" );
}

