#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace root_cinematics;

// Namespace root_cinematics
// Params 0
// Checksum 0x55ed8839, Offset: 0x160
// Size: 0x2e
function main()
{
    init_clientfields();
    level._effect[ "exploding_tree" ] = "explosions/fx_exp_lightning_fold_infection";
}

// Namespace root_cinematics
// Params 0
// Checksum 0xa12a70cf, Offset: 0x198
// Size: 0x4c
function init_clientfields()
{
    clientfield::register( "scriptmover", "exploding_tree", 1, 1, "counter", &function_85138237, 0, 0 );
}

// Namespace root_cinematics
// Params 7
// Checksum 0x18d4daa, Offset: 0x1f0
// Size: 0x6c
function function_85138237( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfx( localclientnum, level._effect[ "exploding_tree" ], self.origin );
}

