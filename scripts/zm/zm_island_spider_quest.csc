#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_weapons;

#namespace zm_island_spider_quest;

// Namespace zm_island_spider_quest
// Params 0
// Checksum 0xc0f65dd8, Offset: 0x250
// Size: 0x164
function init()
{
    var_8b462b02 = getminbitcountfornum( 2 );
    var_fbab08c0 = getminbitcountfornum( 3 );
    clientfield::register( "scriptmover", "spider_queen_mouth_weakspot", 9000, var_8b462b02, "int", &spider_queen_mouth_weakspot, 0, 0 );
    clientfield::register( "scriptmover", "spider_queen_bleed", 9000, 1, "counter", &spider_queen_bleed, 0, 0 );
    clientfield::register( "scriptmover", "spider_queen_stage_bleed", 9000, var_fbab08c0, "int", &spider_queen_stage_bleed, 0, 0 );
    clientfield::register( "scriptmover", "spider_queen_emissive_material", 9000, 1, "int", &spider_queen_emissive_material, 0, 0 );
}

// Namespace zm_island_spider_quest
// Params 7
// Checksum 0x7974707b, Offset: 0x3c0
// Size: 0xfc
function spider_queen_mouth_weakspot( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.var_8dd4267f ) )
    {
        stopfx( localclientnum, self.var_8dd4267f );
        self.var_8dd4267f = undefined;
    }
    
    if ( newval == 1 )
    {
        self.var_8dd4267f = playfxontag( localclientnum, level._effect[ "spider_queen_weakspot" ], self, "tag_turret" );
        return;
    }
    
    if ( newval == 2 )
    {
        self.var_8dd4267f = playfxontag( localclientnum, level._effect[ "spider_queen_mouth_glow" ], self, "tag_turret" );
    }
}

// Namespace zm_island_spider_quest
// Params 7
// Checksum 0xa74fc48e, Offset: 0x4c8
// Size: 0x6c
function spider_queen_bleed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, level._effect[ "spider_queen_bleed_sm" ], self, "tag_turret" );
}

// Namespace zm_island_spider_quest
// Params 7
// Checksum 0xaaf8e76e, Offset: 0x540
// Size: 0x14e
function spider_queen_stage_bleed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self.var_770499e7 = playfxontag( localclientnum, level._effect[ "spider_queen_bleed_lg" ], self, "tag_turret" );
    }
    
    if ( newval == 2 )
    {
        self.var_770499e7 = playfxontag( localclientnum, level._effect[ "spider_queen_bleed_md" ], self, "tag_turret" );
    }
    
    if ( newval == 3 )
    {
        self.var_770499e7 = playfxontag( localclientnum, level._effect[ "spider_queen_bleed_md" ], self, "tag_turret" );
    }
    
    wait 2.5;
    
    if ( isdefined( self.var_770499e7 ) )
    {
        stopfx( localclientnum, self.var_770499e7 );
        self.var_770499e7 = undefined;
    }
}

// Namespace zm_island_spider_quest
// Params 7
// Checksum 0x18df7cf9, Offset: 0x698
// Size: 0xac
function spider_queen_emissive_material( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self mapshaderconstant( localclientnum, 0, "scriptVector2", 1, 1, 1, 0 );
        return;
    }
    
    self mapshaderconstant( localclientnum, 0, "scriptVector2", 0, 0, 0, 0 );
}

