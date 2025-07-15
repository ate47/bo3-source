#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_genesis_util;

#namespace zm_genesis_hope;

// Namespace zm_genesis_hope
// Params 0, eflags: 0x2
// Checksum 0x4f1d2e7, Offset: 0x358
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_genesis_hope", &__init__, undefined, undefined );
}

// Namespace zm_genesis_hope
// Params 0
// Checksum 0xef1fa365, Offset: 0x398
// Size: 0x13c
function __init__()
{
    level._effect[ "spark_of_hope" ] = "dlc4/genesis/fx_quest_hope";
    clientfield::register( "world", "hope_state", 15000, getminbitcountfornum( 4 ), "int", &super_ee, 0, 0 );
    clientfield::register( "clientuimodel", "zmInventory.super_ee", 15000, 1, "int", undefined, 0, 0 );
    clientfield::register( "toplayer", "hope_spark", 15000, 1, "int", &function_2e70599d, 0, 0 );
    clientfield::register( "scriptmover", "hope_spark", 15000, 1, "int", &function_2e70599d, 0, 0 );
}

// Namespace zm_genesis_hope
// Params 7
// Checksum 0x4ec202b2, Offset: 0x4e0
// Size: 0x156
function super_ee( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level notify( #"hope_state" );
    level endon( #"hope_state" );
    var_d461c73e = struct::get( "hope_spark", "targetname" );
    
    switch ( newval )
    {
        case 0:
            var_d461c73e thread function_5f968055( localclientnum, 0 );
            break;
        case 1:
            var_d461c73e thread function_5f968055( localclientnum, 1 );
            break;
        case 2:
            var_d461c73e thread function_5f968055( localclientnum, 0 );
            break;
        case 3:
            var_d461c73e thread function_5f968055( localclientnum, 0 );
            audio::playloopat( "zmb_overachiever_musicbox_lp", ( -6147, 202, 162 ) );
            break;
    }
}

// Namespace zm_genesis_hope
// Params 7
// Checksum 0xd1103e4d, Offset: 0x640
// Size: 0x106
function function_2e70599d( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self.fx_spark = playfxontag( localclientnum, level._effect[ "spark_of_hope" ], self, "j_spine4" );
        self.var_d0642fb4 = self playloopsound( "zmb_overachiever_spark_lp", 1 );
        return;
    }
    
    if ( isdefined( self.fx_spark ) )
    {
        stopfx( localclientnum, self.fx_spark );
    }
    
    if ( isdefined( self.var_d0642fb4 ) )
    {
        self stoploopsound( self.var_d0642fb4 );
        self.var_d0642fb4 = undefined;
    }
}

// Namespace zm_genesis_hope
// Params 2
// Checksum 0x5007424c, Offset: 0x750
// Size: 0xec
function function_5f968055( localclientnum, b_on )
{
    if ( isdefined( self.fx_spark ) )
    {
        stopfx( localclientnum, self.fx_spark );
    }
    
    if ( b_on )
    {
        self.fx_spark = playfx( localclientnum, level._effect[ "spark_of_hope" ], self.origin );
        playsound( 0, "zmb_overachiever_spark_spawn", self.origin );
        audio::playloopat( "zmb_overachiever_spark_lp_3d", self.origin );
        return;
    }
    
    audio::stoploopat( "zmb_overachiever_spark_lp_3d", self.origin );
}

