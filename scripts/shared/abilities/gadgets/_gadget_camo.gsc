#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_gadgets;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;

#namespace _gadget_camo;

// Namespace _gadget_camo
// Params 0, eflags: 0x2
// Checksum 0x80dc872b, Offset: 0x240
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_camo", &__init__, undefined, undefined );
}

// Namespace _gadget_camo
// Params 0
// Checksum 0x369ff94a, Offset: 0x280
// Size: 0x154
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 2, &camo_gadget_on, &camo_gadget_off );
    ability_player::register_gadget_possession_callbacks( 2, &camo_on_give, &camo_on_take );
    ability_player::register_gadget_flicker_callbacks( 2, &camo_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 2, &camo_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 2, &camo_is_flickering );
    clientfield::register( "allplayers", "camo_shader", 1, 3, "int" );
    callback::on_connect( &camo_on_connect );
    callback::on_spawned( &camo_on_spawn );
    callback::on_disconnect( &camo_on_disconnect );
}

// Namespace _gadget_camo
// Params 1
// Checksum 0xba12034c, Offset: 0x3e0
// Size: 0x2a
function camo_is_inuse( slot )
{
    return self flagsys::get( "camo_suit_on" );
}

// Namespace _gadget_camo
// Params 1
// Checksum 0x9f07e019, Offset: 0x418
// Size: 0x22
function camo_is_flickering( slot )
{
    return self gadgetflickering( slot );
}

// Namespace _gadget_camo
// Params 0
// Checksum 0x45d05f04, Offset: 0x448
// Size: 0x44
function camo_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self [[ level.cybercom.active_camo._on_connect ]]();
    }
}

// Namespace _gadget_camo
// Params 0
// Checksum 0x92c8444a, Offset: 0x498
// Size: 0x4c
function camo_on_disconnect()
{
    if ( isdefined( self.sound_ent ) )
    {
        self.sound_ent stoploopsound( 0.05 );
        self.sound_ent delete();
    }
}

// Namespace _gadget_camo
// Params 0
// Checksum 0x9052cb8a, Offset: 0x4f0
// Size: 0xac
function camo_on_spawn()
{
    self flagsys::clear( "camo_suit_on" );
    self notify( #"camo_off" );
    self camo_bread_crumb_delete();
    self clientfield::set( "camo_shader", 0 );
    
    if ( isdefined( self.sound_ent ) )
    {
        self.sound_ent stoploopsound( 0.05 );
        self.sound_ent delete();
    }
}

// Namespace _gadget_camo
// Params 2
// Checksum 0xbb00ebc5, Offset: 0x5a8
// Size: 0x9c
function suspend_camo_suit( slot, weapon )
{
    self endon( #"disconnect" );
    self endon( #"camo_off" );
    self clientfield::set( "camo_shader", 2 );
    suspend_camo_suit_wait( slot, weapon );
    
    if ( self camo_is_inuse( slot ) )
    {
        self clientfield::set( "camo_shader", 1 );
    }
}

// Namespace _gadget_camo
// Params 2
// Checksum 0x746a90b9, Offset: 0x650
// Size: 0x54
function suspend_camo_suit_wait( slot, weapon )
{
    self endon( #"death" );
    self endon( #"camo_off" );
    
    while ( self camo_is_flickering( slot ) )
    {
        wait 0.5;
    }
}

// Namespace _gadget_camo
// Params 2
// Checksum 0xb1e399b4, Offset: 0x6b0
// Size: 0x5c
function camo_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self [[ level.cybercom.active_camo._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_camo
// Params 2
// Checksum 0x2d124037, Offset: 0x718
// Size: 0x6c
function camo_on_take( slot, weapon )
{
    self notify( #"camo_removed" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self [[ level.cybercom.active_camo._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_camo
// Params 2
// Checksum 0xddc437a9, Offset: 0x790
// Size: 0x7c
function camo_on_flicker( slot, weapon )
{
    self thread camo_suit_flicker( slot, weapon );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self thread [[ level.cybercom.active_camo._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_camo
// Params 1
// Checksum 0x9e667391, Offset: 0x818
// Size: 0xce
function camo_all_actors( value )
{
    str_opposite_team = "axis";
    
    if ( self.team == "axis" )
    {
        str_opposite_team = "allies";
    }
    
    aitargets = getaiarray( str_opposite_team );
    
    for ( i = 0; i < aitargets.size ; i++ )
    {
        testtarget = aitargets[ i ];
        
        if ( !isdefined( testtarget ) || !isalive( testtarget ) )
        {
        }
    }
}

// Namespace _gadget_camo
// Params 2
// Checksum 0x17c1dcfb, Offset: 0x8f0
// Size: 0xfc
function camo_gadget_on( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self thread [[ level.cybercom.active_camo._on ]]( slot, weapon );
    }
    
    self thread camo_takedown_watch( slot, weapon );
    self._gadget_camo_oldignoreme = self.ignoreme;
    self.ignoreme = 1;
    self clientfield::set( "camo_shader", 1 );
    self flagsys::set( "camo_suit_on" );
    self thread camo_bread_crumb( slot, weapon );
}

// Namespace _gadget_camo
// Params 2
// Checksum 0x3270db9f, Offset: 0x9f8
// Size: 0x10c
function camo_gadget_off( slot, weapon )
{
    self flagsys::clear( "camo_suit_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self thread [[ level.cybercom.active_camo._off ]]( slot, weapon );
    }
    
    if ( isdefined( self.sound_ent ) )
    {
    }
    
    self notify( #"camo_off" );
    
    if ( isdefined( self._gadget_camo_oldignoreme ) )
    {
        self.ignoreme = self._gadget_camo_oldignoreme;
        self._gadget_camo_oldignoreme = undefined;
    }
    else
    {
        self.ignoreme = 0;
    }
    
    self camo_bread_crumb_delete();
    self.gadget_camo_off_time = gettime();
    self clientfield::set( "camo_shader", 0 );
}

// Namespace _gadget_camo
// Params 2
// Checksum 0x981b1c94, Offset: 0xb10
// Size: 0xe4
function camo_bread_crumb( slot, weapon )
{
    self notify( #"camo_bread_crumb" );
    self endon( #"camo_bread_crumb" );
    self camo_bread_crumb_delete();
    
    if ( !self camo_is_inuse() )
    {
        return;
    }
    
    self._camo_crumb = spawn( "script_model", self.origin );
    self._camo_crumb setmodel( "tag_origin" );
    self camo_bread_crumb_wait( slot, weapon );
    self camo_bread_crumb_delete();
}

// Namespace _gadget_camo
// Params 2
// Checksum 0x231eb197, Offset: 0xc00
// Size: 0xa0
function camo_bread_crumb_wait( slot, weapon )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"camo_off" );
    self endon( #"camo_bread_crumb" );
    starttime = gettime();
    
    while ( true )
    {
        currenttime = gettime();
        
        if ( currenttime - starttime > self._gadgets_player[ slot ].gadget_breadcrumbduration )
        {
            return;
        }
        
        wait 0.5;
    }
}

// Namespace _gadget_camo
// Params 0
// Checksum 0xe237cb20, Offset: 0xca8
// Size: 0x36
function camo_bread_crumb_delete()
{
    if ( isdefined( self._camo_crumb ) )
    {
        self._camo_crumb delete();
        self._camo_crumb = undefined;
    }
}

// Namespace _gadget_camo
// Params 2
// Checksum 0x7dca309, Offset: 0xce8
// Size: 0xa8
function camo_takedown_watch( slot, weapon )
{
    self endon( #"disconnect" );
    self endon( #"camo_off" );
    
    while ( true )
    {
        self waittill( #"weapon_assassination" );
        
        if ( self camo_is_inuse() )
        {
            if ( self._gadgets_player[ slot ].gadget_takedownrevealtime > 0 )
            {
                self ability_gadgets::setflickering( slot, self._gadgets_player[ slot ].gadget_takedownrevealtime );
            }
        }
    }
}

// Namespace _gadget_camo
// Params 1
// Checksum 0xb335fd5a, Offset: 0xd98
// Size: 0xbc
function camo_temporary_dont_ignore( slot )
{
    self endon( #"disconnect" );
    
    if ( !self camo_is_inuse() )
    {
        return;
    }
    
    self notify( #"temporary_dont_ignore" );
    wait 0.1;
    old_ignoreme = 0;
    
    if ( isdefined( self._gadget_camo_oldignoreme ) )
    {
        old_ignoreme = self._gadget_camo_oldignoreme;
    }
    
    self.ignoreme = old_ignoreme;
    camo_temporary_dont_ignore_wait( slot );
    self.ignoreme = self camo_is_inuse() || old_ignoreme;
}

// Namespace _gadget_camo
// Params 1
// Checksum 0x1dcb40fd, Offset: 0xe60
// Size: 0x6c
function camo_temporary_dont_ignore_wait( slot )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"camo_off" );
    self endon( #"temporary_dont_ignore" );
    
    while ( true )
    {
        if ( !self camo_is_flickering( slot ) )
        {
            return;
        }
        
        wait 0.25;
    }
}

// Namespace _gadget_camo
// Params 2
// Checksum 0xb85c6a43, Offset: 0xed8
// Size: 0xd4
function camo_suit_flicker( slot, weapon )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"camo_off" );
    
    if ( !self camo_is_inuse() )
    {
        return;
    }
    
    self thread camo_temporary_dont_ignore( slot );
    self thread suspend_camo_suit( slot, weapon );
    
    while ( true )
    {
        if ( !self camo_is_flickering( slot ) )
        {
            self thread camo_bread_crumb( slot );
            return;
        }
        
        wait 0.25;
    }
}

// Namespace _gadget_camo
// Params 2
// Checksum 0x3acf1ba0, Offset: 0xfb8
// Size: 0xa4
function set_camo_reveal_status( status, time )
{
    timestr = "";
    self._gadget_camo_reveal_status = undefined;
    
    if ( isdefined( time ) )
    {
        timestr = ", ^3time: " + time;
        self._gadget_camo_reveal_status = status;
    }
    
    if ( getdvarint( "scr_cpower_debug_prints" ) > 0 )
    {
        self iprintlnbold( "Camo Reveal: " + status + timestr );
    }
}

