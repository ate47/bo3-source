#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_impatient;

// Namespace zm_bgb_impatient
// Params 0, eflags: 0x2
// Checksum 0x89f94fb2, Offset: 0x1b0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_impatient", &__init__, undefined, "bgb" );
}

// Namespace zm_bgb_impatient
// Params 0
// Checksum 0xf31290cf, Offset: 0x1f0
// Size: 0x54
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_impatient", "event", &event, undefined, undefined, undefined );
}

// Namespace zm_bgb_impatient
// Params 0
// Checksum 0x47ed6a2e, Offset: 0x250
// Size: 0x3c
function event()
{
    self endon( #"disconnect" );
    self endon( #"bgb_update" );
    self waittill( #"bgb_about_to_take_on_bled_out" );
    self thread special_revive();
}

// Namespace zm_bgb_impatient
// Params 0
// Checksum 0xe0c33368, Offset: 0x298
// Size: 0x5c
function special_revive()
{
    self endon( #"disconnect" );
    wait 1;
    
    while ( level.zombie_total > 0 )
    {
        wait 0.05;
    }
    
    self zm::spectator_respawn_player();
    self bgb::do_one_shot_use();
}

