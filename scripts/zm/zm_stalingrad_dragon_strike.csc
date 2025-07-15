#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace stalingrad_dragon_strike;

// Namespace stalingrad_dragon_strike
// Params 0, eflags: 0x2
// Checksum 0xc244c572, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_stalingrad_dragon_strike", &__init__, undefined, undefined );
}

// Namespace stalingrad_dragon_strike
// Params 0
// Checksum 0x58c0319b, Offset: 0x270
// Size: 0x124
function __init__()
{
    clientfield::register( "scriptmover", "lockbox_light_1", 12000, 2, "int", &lockbox_light_1, 0, 0 );
    clientfield::register( "scriptmover", "lockbox_light_2", 12000, 2, "int", &lockbox_light_2, 0, 0 );
    clientfield::register( "scriptmover", "lockbox_light_3", 12000, 2, "int", &lockbox_light_3, 0, 0 );
    clientfield::register( "scriptmover", "lockbox_light_4", 12000, 2, "int", &lockbox_light_4, 0, 0 );
}

// Namespace stalingrad_dragon_strike
// Params 7
// Checksum 0x3ca1eda7, Offset: 0x3a0
// Size: 0xec
function lockbox_light_1( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.fx_light_1 ) )
    {
        stopfx( localclientnum, self.fx_light_1 );
    }
    
    if ( newval == 2 )
    {
        self.fx_light_1 = playfxontag( localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "0" );
        return;
    }
    
    self.fx_light_1 = playfxontag( localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "0" );
}

// Namespace stalingrad_dragon_strike
// Params 7
// Checksum 0x5c8654a, Offset: 0x498
// Size: 0xec
function lockbox_light_2( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.fx_light_2 ) )
    {
        stopfx( localclientnum, self.fx_light_2 );
    }
    
    if ( newval == 2 )
    {
        self.fx_light_2 = playfxontag( localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "1" );
        return;
    }
    
    self.fx_light_2 = playfxontag( localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "1" );
}

// Namespace stalingrad_dragon_strike
// Params 7
// Checksum 0x582aae33, Offset: 0x590
// Size: 0xec
function lockbox_light_3( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.fx_light_3 ) )
    {
        stopfx( localclientnum, self.fx_light_3 );
    }
    
    if ( newval == 2 )
    {
        self.fx_light_3 = playfxontag( localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "2" );
        return;
    }
    
    self.fx_light_3 = playfxontag( localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "2" );
}

// Namespace stalingrad_dragon_strike
// Params 7
// Checksum 0x1b5c4922, Offset: 0x688
// Size: 0xec
function lockbox_light_4( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.var_b9f32487 ) )
    {
        stopfx( localclientnum, self.var_b9f32487 );
    }
    
    if ( newval == 2 )
    {
        self.var_b9f32487 = playfxontag( localclientnum, "dlc3/stalingrad/fx_glow_red_dragonstrike", self, "tag_nixie_red_" + "3" );
        return;
    }
    
    self.var_b9f32487 = playfxontag( localclientnum, "dlc3/stalingrad/fx_glow_green_dragonstrike", self, "tag_nixie_green_" + "3" );
}

