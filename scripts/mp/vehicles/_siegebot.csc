#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/spike_charge_siegebot;

#namespace siegebot;

// Namespace siegebot
// Params 0, eflags: 0x2
// Checksum 0x4c791d7c, Offset: 0x2a0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "siegebot_mp", &__init__, undefined, undefined );
}

// Namespace siegebot
// Params 0
// Checksum 0x799b8580, Offset: 0x2e0
// Size: 0xbc
function __init__()
{
    vehicle::add_vehicletype_callback( "siegebot_mp", &_setup_ );
    clientfield::register( "vehicle", "siegebot_retract_right_arm", 1, 1, "int", &update_right_arm, 0, 0 );
    clientfield::register( "vehicle", "siegebot_retract_left_arm", 1, 1, "int", &update_left_arm, 0, 0 );
}

// Namespace siegebot
// Params 1
// Checksum 0x9ffe920e, Offset: 0x3a8
// Size: 0x6c
function _setup_( localclientnum )
{
    if ( isdefined( self.scriptbundlesettings ) )
    {
        settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    }
    
    if ( !isdefined( settings ) )
    {
        return;
    }
    
    self thread player_enter_exit( localclientnum );
}

// Namespace siegebot
// Params 1
// Checksum 0x800f4051, Offset: 0x420
// Size: 0x98
function player_enter_exit( localclientnum )
{
    self endon( #"death" );
    self endon( #"entityshutdown" );
    player = undefined;
    
    while ( true )
    {
        self player_exited( localclientnum, player );
        self waittill( #"enter_vehicle", player );
        self player_entered( localclientnum, player );
        self waittill( #"exit_vehicle", player );
    }
}

// Namespace siegebot
// Params 2
// Checksum 0x686b69f5, Offset: 0x4c0
// Size: 0x76
function player_entered( localclientnum, player )
{
    self playsound( localclientnum, "evt_siegebot_bootup_1" );
    local_player = getlocalplayer( localclientnum );
    
    if ( self islocalclientdriver( localclientnum ) )
    {
    }
}

// Namespace siegebot
// Params 2
// Checksum 0x6b1e105, Offset: 0x540
// Size: 0x4e
function player_exited( localclientnum, player )
{
    self playsound( localclientnum, "evt_siegebot_shutdown_1" );
    
    if ( self islocalclientdriver( localclientnum ) )
    {
    }
}

#using_animtree( "generic" );

// Namespace siegebot
// Params 0
// Checksum 0xc34fa60c, Offset: 0x598
// Size: 0x74
function retract_left_arm()
{
    self useanimtree( #animtree );
    self clearanim( %ai_siegebot_base_mp_left_arm_extend, 0.2 );
    self setanim( %ai_siegebot_base_mp_left_arm_retract, 1 );
}

// Namespace siegebot
// Params 0
// Checksum 0xf770f285, Offset: 0x618
// Size: 0xcc
function extend_left_arm()
{
    self useanimtree( #animtree );
    self clearanim( %ai_siegebot_base_mp_left_arm_retract, 0.2 );
    self setanim( %ai_siegebot_base_mp_left_arm_extend, 1 );
    wait 0.1;
    
    if ( self clientfield::get( "siegebot_retract_left_arm" ) == 0 )
    {
        self clearanim( %ai_siegebot_base_mp_left_arm_extend, 0.1 );
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x8d6fde26, Offset: 0x6f0
// Size: 0x74
function retract_right_arm()
{
    self useanimtree( #animtree );
    self clearanim( %ai_siegebot_base_mp_right_arm_extend, 0.2 );
    self setanim( %ai_siegebot_base_mp_right_arm_retract, 1 );
}

// Namespace siegebot
// Params 0
// Checksum 0xe0fe720d, Offset: 0x770
// Size: 0xcc
function extend_right_arm()
{
    self useanimtree( #animtree );
    self clearanim( %ai_siegebot_base_mp_right_arm_retract, 0.2 );
    self setanim( %ai_siegebot_base_mp_right_arm_extend, 1 );
    wait 0.1;
    
    if ( self clientfield::get( "siegebot_retract_right_arm" ) == 0 )
    {
        self clearanim( %ai_siegebot_base_mp_right_arm_extend, 0.1 );
    }
}

// Namespace siegebot
// Params 7
// Checksum 0x4140f7c3, Offset: 0x848
// Size: 0x94
function update_right_arm( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval )
    {
        self thread retract_right_arm();
        return;
    }
    
    self thread extend_right_arm();
}

// Namespace siegebot
// Params 7
// Checksum 0x73e36c8e, Offset: 0x8e8
// Size: 0x94
function update_left_arm( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval )
    {
        self thread retract_left_arm();
        return;
    }
    
    self thread extend_left_arm();
}

