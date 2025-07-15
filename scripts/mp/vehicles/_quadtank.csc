#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace quadtank;

// Namespace quadtank
// Params 0, eflags: 0x2
// Checksum 0xf11a395, Offset: 0x218
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "quadtank", &__init__, undefined, undefined );
}

// Namespace quadtank
// Params 0
// Checksum 0xe05355e4, Offset: 0x258
// Size: 0xbc
function __init__()
{
    vehicle::add_vehicletype_callback( "quadtank", &_setup_ );
    clientfield::register( "toplayer", "player_shock_fx", 1, 1, "int", &player_shock_fx_handler, 0, 0 );
    clientfield::register( "vehicle", "quadtank_trophy_state", 1, 1, "int", &update_trophy_system_state, 0, 0 );
}

// Namespace quadtank
// Params 1
// Checksum 0xfa35bfb8, Offset: 0x320
// Size: 0xbc
function _setup_( localclientnum )
{
    player = getlocalplayer( localclientnum );
    
    if ( isdefined( player ) )
    {
        filter::init_filter_ev_interference( player );
    }
    
    self.notifyonbulletimpact = 1;
    self thread wait_for_bullet_impact( localclientnum );
    self.trophy_on = 0;
    self thread player_enter( localclientnum );
    self thread player_exit( localclientnum );
}

// Namespace quadtank
// Params 1
// Checksum 0x2dd30ef9, Offset: 0x3e8
// Size: 0x80
function player_enter( localclientnum )
{
    self endon( #"death" );
    self endon( #"entityshutdown" );
    
    while ( true )
    {
        self waittill( #"enter_vehicle", player );
        
        if ( self islocalclientdriver( localclientnum ) )
        {
            self sethighdetail( 1 );
        }
        
        wait 0.016;
    }
}

// Namespace quadtank
// Params 1
// Checksum 0x27d03db1, Offset: 0x470
// Size: 0x88
function player_exit( localclientnum )
{
    self endon( #"death" );
    self endon( #"entityshutdown" );
    
    while ( true )
    {
        self waittill( #"exit_vehicle", player );
        
        if ( isdefined( player ) && player islocalplayer() )
        {
            self sethighdetail( 0 );
        }
        
        wait 0.016;
    }
}

// Namespace quadtank
// Params 7
// Checksum 0xf76037b2, Offset: 0x500
// Size: 0x3c
function update_trophy_system_state( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    
}

// Namespace quadtank
// Params 7
// Checksum 0x43dee8ff, Offset: 0x548
// Size: 0x6c
function player_shock_fx_handler( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self ) )
    {
        self thread player_shock_fx_fade_off( localclientnum, 1, 1 );
    }
}

// Namespace quadtank
// Params 3
// Checksum 0x57392688, Offset: 0x5c0
// Size: 0x164
function player_shock_fx_fade_off( localclientnum, amount, fadeouttime )
{
    self endon( #"disconnect" );
    self notify( #"player_shock_fx_fade_off_end" );
    self endon( #"player_shock_fx_fade_off_end" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    starttime = gettime();
    filter::set_filter_ev_interference_amount( self, 4, amount );
    filter::enable_filter_ev_interference( self, 4 );
    
    while ( gettime() <= starttime + fadeouttime * 1000 && isalive( self ) )
    {
        ratio = ( gettime() - starttime ) / fadeouttime * 1000;
        currentvalue = lerpfloat( amount, 0, ratio );
        setfilterpassconstant( localclientnum, 4, 0, 0, currentvalue );
        wait 0.016;
    }
    
    setfilterpassenabled( localclientnum, 4, 0, 0 );
}

// Namespace quadtank
// Params 1
// Checksum 0xb49257a1, Offset: 0x730
// Size: 0x170
function wait_for_bullet_impact( localclientnum )
{
    self endon( #"entityshutdown" );
    
    if ( isdefined( self.scriptbundlesettings ) )
    {
        settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    }
    else
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"damage", attacker, impactpos, effectdir, partname );
        
        if ( partname == "tag_target_lower" || partname == "tag_target_upper" || partname == "tag_defense_active" || partname == "tag_body_animate" )
        {
            if ( self.trophy_on )
            {
                if ( isdefined( attacker ) && attacker isplayer() && attacker.team != self.team )
                {
                    playfx( localclientnum, settings.weakspotfx, impactpos, effectdir );
                    self playsound( 0, "veh_quadtank_panel_hit" );
                }
            }
        }
    }
}

