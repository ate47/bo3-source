#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace stealth_client;

// Namespace stealth_client
// Params 0, eflags: 0x2
// Checksum 0xf825c14d, Offset: 0x170
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "stealth_client", &__init__, undefined, undefined );
}

// Namespace stealth_client
// Params 0
// Checksum 0xf0ab345b, Offset: 0x1b0
// Size: 0x2c
function __init__()
{
    init_clientfields();
    level.stealth_is_alerted = 0;
    level.stealth_awareness_level = 0;
}

// Namespace stealth_client
// Params 0
// Checksum 0xedee5511, Offset: 0x1e8
// Size: 0x94
function init_clientfields()
{
    clientfield::register( "toplayer", "stealth_sighting", 1, 2, "int", &callback_stealth_sighting, 0, 0 );
    clientfield::register( "toplayer", "stealth_alerted", 1, 1, "int", &callback_stealth_alerted, 0, 0 );
}

// Namespace stealth_client
// Params 7
// Checksum 0xd459bdd0, Offset: 0x288
// Size: 0xa2
function callback_stealth_sighting( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval > 0 )
    {
        if ( level.stealth_awareness_level == 0 || newval == 2 )
        {
            level.stealth_awareness_level = newval;
            self thread stealth_sighted_sound();
        }
        
        return;
    }
    
    level.stealth_awareness_level = 0;
    self notify( #"stealth_sighting_thread" );
}

// Namespace stealth_client
// Params 7
// Checksum 0x3fae3892, Offset: 0x338
// Size: 0x94
function callback_stealth_alerted( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        if ( level.stealth_is_alerted == 0 )
        {
            self thread stealth_alerted_sound();
            level.stealth_is_alerted = 1;
        }
        
        return;
    }
    
    self notify( #"stealth_alerted_thread" );
    level.stealth_is_alerted = 0;
}

// Namespace stealth_client
// Params 0
// Checksum 0x3c15178a, Offset: 0x3d8
// Size: 0x9e
function stealth_sighted_sound()
{
    self notify( #"stealth_sighting_thread" );
    self endon( #"stealth_sighting_thread" );
    self endon( #"stealth_alerted_thread" );
    self endon( #"death" );
    self endon( #"disconnect" );
    var_c6b203b0 = 3;
    
    if ( level.stealth_awareness_level == 2 )
    {
        var_c6b203b0 = 1;
    }
    
    while ( isdefined( self ) )
    {
        self playsound( self, "uin_stealth_beep" );
        wait var_c6b203b0;
    }
}

// Namespace stealth_client
// Params 0
// Checksum 0x568f94c3, Offset: 0x480
// Size: 0x76
function stealth_alerted_sound()
{
    self notify( #"stealth_alerted_thread" );
    self endon( #"stealth_alerted_thread" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( level.stealth_awareness_level == 1 )
    {
        self playsound( self, "uin_stealth_hint" );
    }
    
    while ( isdefined( self ) )
    {
        wait 4;
    }
}

