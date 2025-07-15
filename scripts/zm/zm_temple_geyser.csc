#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;

#namespace zm_temple_geyser;

// Namespace zm_temple_geyser
// Params 0
// Checksum 0xdbf776bc, Offset: 0x190
// Size: 0x94
function main()
{
    clientfield::register( "allplayers", "geyserfakestand", 21000, 1, "int", &geyser_player_setup_stand, 0, 0 );
    clientfield::register( "allplayers", "geyserfakeprone", 21000, 1, "int", &geyser_player_setup_prone, 0, 0 );
}

// Namespace zm_temple_geyser
// Params 7
// Checksum 0xaab74aa8, Offset: 0x230
// Size: 0x420
function geyser_player_setup_prone( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( isspectating( localclientnum, 0 ) )
    {
        return;
    }
    
    player = getlocalplayers()[ localclientnum ];
    
    if ( player getentitynumber() == self getentitynumber() )
    {
        if ( newval )
        {
            self playrumbleonentity( localclientnum, "slide_rumble" );
            return;
        }
        
        self stoprumble( localclientnum, "slide_rumble" );
        return;
    }
    
    if ( newval )
    {
        if ( localclientnum == 0 )
        {
            self thread player_disconnect_tracker();
        }
        
        fake_player = spawn( localclientnum, self.origin + ( 0, 0, -800 ), "script_model" );
        fake_player.angles = self.angles;
        fake_player setmodel( self.model );
        
        if ( self.model == "c_ger_richtofen_body" )
        {
            fake_player attach( "c_ger_richtofen_head", "J_Spine4" );
            fake_player attach( "c_ger_richtofen_offcap", "J_Head" );
        }
        
        fake_player.fake_weapon = spawn( localclientnum, self.origin, "script_model" );
        
        if ( self.weapon != "none" && self.weapon != "syrette" )
        {
            fake_player.fake_weapon useweaponhidetags( self.weapon );
        }
        else
        {
            self thread geyser_weapon_monitor( fake_player.fake_weapon );
        }
        
        fake_player.fake_weapon linkto( fake_player, "tag_weapon_right" );
        wait 0.016;
        fake_player linkto( self, "tag_origin" );
        
        if ( !isdefined( self.fake_player ) )
        {
            self.fake_player = [];
        }
        
        self.fake_player[ localclientnum ] = fake_player;
        self thread wait_for_geyser_player_to_disconnect( localclientnum );
        return;
    }
    
    if ( !isdefined( self.fake_player ) && !isdefined( self.fake_player[ localclientnum ] ) )
    {
        return;
    }
    
    str_notify = "player_geyser" + localclientnum;
    self notify( str_notify );
    self notify( #"end_geyser" );
    
    if ( isdefined( self.fake_player[ localclientnum ].fake_weapon ) )
    {
        self.fake_player[ localclientnum ].fake_weapon delete();
        self.fake_player[ localclientnum ].fake_weapon = undefined;
    }
    
    self.fake_player[ localclientnum ] delete();
    self.fake_player[ localclientnum ] = undefined;
}

// Namespace zm_temple_geyser
// Params 7
// Checksum 0xb8739eae, Offset: 0x658
// Size: 0x448
function geyser_player_setup_stand( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( isspectating( localclientnum, 0 ) )
    {
        return;
    }
    
    player = getlocalplayers()[ localclientnum ];
    
    if ( player getentitynumber() == self getentitynumber() )
    {
        if ( newval )
        {
            self playrumbleonentity( localclientnum, "slide_rumble" );
            return;
        }
        
        self stoprumble( localclientnum, "slide_rumble" );
        return;
    }
    
    if ( newval )
    {
        if ( localclientnum == 0 )
        {
            self thread player_disconnect_tracker();
        }
        
        fake_player = spawn( localclientnum, self.origin + ( 0, 0, -800 ), "script_model" );
        fake_player.angles = self.angles;
        fake_player setmodel( self.model );
        
        if ( self.model == "c_ger_richtofen_body" )
        {
            fake_player attach( "c_ger_richtofen_head", "J_Spine4" );
            fake_player attach( "c_ger_richtofen_offcap", "J_Head" );
        }
        
        fake_player.fake_weapon = spawn( localclientnum, self.origin, "script_model" );
        
        if ( self.weapon.name != "none" && self.weapon.name != "syrette" )
        {
            fake_player.fake_weapon useweaponhidetags( self.weapon );
        }
        else
        {
            self thread geyser_weapon_monitor( fake_player.fake_weapon );
        }
        
        fake_player.fake_weapon linkto( fake_player, "tag_weapon_right" );
        wait 0.016;
        fake_player.origin = self.origin;
        fake_player linkto( self, "tag_origin" );
        
        if ( !isdefined( self.fake_player ) )
        {
            self.fake_player = [];
        }
        
        self.fake_player[ localclientnum ] = fake_player;
        self thread wait_for_geyser_player_to_disconnect( localclientnum );
        return;
    }
    
    if ( !isdefined( self.fake_player ) || !isdefined( self.fake_player[ localclientnum ] ) )
    {
        return;
    }
    
    str_notify = "player_geyser" + localclientnum;
    self notify( str_notify );
    self notify( #"end_geyser" );
    
    if ( isdefined( self.fake_player[ localclientnum ].fake_weapon ) )
    {
        self.fake_player[ localclientnum ].fake_weapon delete();
        self.fake_player[ localclientnum ].fake_weapon = undefined;
    }
    
    self.fake_player[ localclientnum ] delete();
    self.fake_player[ localclientnum ] = undefined;
}

// Namespace zm_temple_geyser
// Params 1
// Checksum 0x8eaf6a1f, Offset: 0xaa8
// Size: 0x74
function geyser_weapon_monitor( fake_weapon )
{
    self endon( #"end_geyser" );
    self endon( #"disconnect" );
    
    while ( self.weapon == "none" )
    {
        wait 0.05;
    }
    
    if ( self.weapon != "syrette" )
    {
        fake_weapon useweaponhidetags( self.weapon );
    }
}

// Namespace zm_temple_geyser
// Params 0
// Checksum 0x612aeae1, Offset: 0xb28
// Size: 0x66
function player_disconnect_tracker()
{
    self notify( #"stop_tracking" );
    self endon( #"stop_tracking" );
    ent_num = self getentitynumber();
    
    while ( isdefined( self ) )
    {
        wait 0.05;
    }
    
    level notify( #"player_disconnected", ent_num );
}

// Namespace zm_temple_geyser
// Params 2
// Checksum 0xa15c22c1, Offset: 0xb98
// Size: 0x74
function geyser_model_remover( str_endon, player )
{
    player endon( str_endon );
    level waittill( #"player_disconnected", client );
    
    if ( isdefined( self.fake_weapon ) )
    {
        self.fake_weapon delete();
    }
    
    self delete();
}

// Namespace zm_temple_geyser
// Params 1
// Checksum 0xa452bf0b, Offset: 0xc18
// Size: 0x4c
function wait_for_geyser_player_to_disconnect( localclientnum )
{
    str_endon = "player_geyser" + localclientnum;
    self.fake_player[ localclientnum ] thread geyser_model_remover( str_endon, self );
}

