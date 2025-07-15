#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/postfx_shared;

#namespace zm_genesis_flingers;

// Namespace zm_genesis_flingers
// Params 0
// Checksum 0xc6c2070c, Offset: 0x3d8
// Size: 0x2c
function main()
{
    register_clientfields();
    level thread function_4208db02();
}

// Namespace zm_genesis_flingers
// Params 0
// Checksum 0x66d4fc8b, Offset: 0x410
// Size: 0x1fc
function register_clientfields()
{
    clientfield::register( "toplayer", "flinger_flying_postfx", 15000, 1, "int", &flinger_flying_postfx, 0, 0 );
    clientfield::register( "toplayer", "flinger_land_smash", 15000, 1, "counter", &flinger_land_smash, 0, 0 );
    clientfield::register( "toplayer", "flinger_cooldown_start", 15000, 4, "int", &flinger_cooldown_start, 0, 0 );
    clientfield::register( "toplayer", "flinger_cooldown_end", 15000, 4, "int", &flinger_cooldown_end, 0, 0 );
    clientfield::register( "scriptmover", "player_visibility", 15000, 1, "int", &function_a0a5829, 0, 0 );
    clientfield::register( "scriptmover", "flinger_launch_fx", 15000, 1, "counter", &function_3762396c, 0, 0 );
    clientfield::register( "scriptmover", "flinger_pad_active_fx", 15000, 4, "int", &flinger_pad_active_fx, 0, 0 );
}

// Namespace zm_genesis_flingers
// Params 7
// Checksum 0x4c265362, Offset: 0x618
// Size: 0x15c
function flinger_flying_postfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self.var_6f6f69f0 = playfxontag( localclientnum, level._effect[ "flinger_trail" ], self, "tag_origin" );
        self.var_bb0de733 = self playloopsound( "zmb_fling_windwhoosh_2d" );
        self thread postfx::playpostfxbundle( "pstfx_zm_screen_warp" );
        return;
    }
    
    if ( isdefined( self.var_6f6f69f0 ) )
    {
        deletefx( localclientnum, self.var_6f6f69f0, 1 );
        self.var_6f6f69f0 = undefined;
    }
    
    if ( isdefined( self.var_bb0de733 ) )
    {
        self stoploopsound( self.var_bb0de733, 0.75 );
        self.var_bb0de733 = undefined;
    }
    
    self thread postfx::exitpostfxbundle();
}

// Namespace zm_genesis_flingers
// Params 2
// Checksum 0x9624bf55, Offset: 0x780
// Size: 0xc4
function function_ddcc2bf9( localclientnum, var_bfcf4a2a )
{
    if ( !self hasdobj( localclientnum ) )
    {
        return;
    }
    
    if ( var_bfcf4a2a == 1 )
    {
        self hidepart( localclientnum, "tag_blue" );
        self showpart( localclientnum, "tag_red" );
        return;
    }
    
    self hidepart( localclientnum, "tag_red" );
    self showpart( localclientnum, "tag_blue" );
}

// Namespace zm_genesis_flingers
// Params 7
// Checksum 0x2cfeb18c, Offset: 0x850
// Size: 0xf4
function flinger_pad_active_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval > 0 )
    {
        var_1143aa58 = getent( localclientnum, level.var_5646965[ newval ][ "pad" ], "targetname" );
        var_1143aa58 thread function_ddcc2bf9( localclientnum, 0 );
        exploder::stop_exploder( level.var_5646965[ newval ][ "cooldown" ] );
        exploder::exploder( level.var_5646965[ newval ][ "ready" ] );
    }
}

// Namespace zm_genesis_flingers
// Params 7
// Checksum 0x6d03cab9, Offset: 0x950
// Size: 0x7c
function flinger_land_smash( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level notify( #"hash_92663c14" );
    playfxontag( localclientnum, level._effect[ "flinger_land" ], self, "tag_origin" );
}

// Namespace zm_genesis_flingers
// Params 7
// Checksum 0xe0045620, Offset: 0x9d8
// Size: 0x1c4
function flinger_cooldown_start( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval > 0 )
    {
        var_1143aa58 = getent( localclientnum, level.var_5646965[ newval ][ "pad" ], "targetname" );
        var_1143aa58 thread function_ddcc2bf9( localclientnum, 1 );
        exploder::stop_exploder( level.var_5646965[ newval ][ "ready" ] );
        exploder::exploder( level.var_5646965[ newval ][ "cooldown" ] );
        var_32149294 = level.var_5646965[ newval ][ "landpad" ];
        var_f201110a = getent( localclientnum, level.var_5646965[ var_32149294 ][ "pad" ], "targetname" );
        var_f201110a thread function_ddcc2bf9( localclientnum, 1 );
        exploder::stop_exploder( level.var_5646965[ var_32149294 ][ "ready" ] );
        exploder::exploder( level.var_5646965[ var_32149294 ][ "cooldown" ] );
    }
}

// Namespace zm_genesis_flingers
// Params 7
// Checksum 0x1087ebd4, Offset: 0xba8
// Size: 0x1c4
function flinger_cooldown_end( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval > 0 )
    {
        var_1143aa58 = getent( localclientnum, level.var_5646965[ newval ][ "pad" ], "targetname" );
        var_1143aa58 thread function_ddcc2bf9( localclientnum, 0 );
        exploder::stop_exploder( level.var_5646965[ newval ][ "cooldown" ] );
        exploder::exploder( level.var_5646965[ newval ][ "ready" ] );
        var_32149294 = level.var_5646965[ newval ][ "landpad" ];
        var_f201110a = getent( localclientnum, level.var_5646965[ var_32149294 ][ "pad" ], "targetname" );
        var_f201110a thread function_ddcc2bf9( localclientnum, 0 );
        exploder::stop_exploder( level.var_5646965[ var_32149294 ][ "cooldown" ] );
        exploder::exploder( level.var_5646965[ var_32149294 ][ "ready" ] );
    }
}

// Namespace zm_genesis_flingers
// Params 7
// Checksum 0x42417813, Offset: 0xd78
// Size: 0x6c
function function_3762396c( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, level._effect[ "flinger_launch" ], self, "tag_origin" );
}

// Namespace zm_genesis_flingers
// Params 0
// Checksum 0x49841dcd, Offset: 0xdf0
// Size: 0x474
function function_4208db02()
{
    level.var_5646965 = [];
    level.var_5646965[ 1 ] = [];
    level.var_5646965[ 2 ] = [];
    level.var_5646965[ 3 ] = [];
    level.var_5646965[ 4 ] = [];
    level.var_5646965[ 5 ] = [];
    level.var_5646965[ 6 ] = [];
    level.var_5646965[ 7 ] = [];
    level.var_5646965[ 8 ] = [];
    level.var_5646965[ 1 ][ "ready" ] = "fxexp_150";
    level.var_5646965[ 1 ][ "cooldown" ] = "fxexp_350";
    level.var_5646965[ 1 ][ "pad" ] = "upper_courtyard_flinger_base7";
    level.var_5646965[ 1 ][ "landpad" ] = 8;
    level.var_5646965[ 2 ][ "ready" ] = "fxexp_151";
    level.var_5646965[ 2 ][ "cooldown" ] = "fxexp_351";
    level.var_5646965[ 2 ][ "pad" ] = "upper_courtyard_flinger_base12";
    level.var_5646965[ 2 ][ "landpad" ] = 3;
    level.var_5646965[ 3 ][ "ready" ] = "fxexp_152";
    level.var_5646965[ 3 ][ "cooldown" ] = "fxexp_352";
    level.var_5646965[ 3 ][ "pad" ] = "upper_courtyard_flinger_base11";
    level.var_5646965[ 3 ][ "landpad" ] = 2;
    level.var_5646965[ 4 ][ "ready" ] = "fxexp_153";
    level.var_5646965[ 4 ][ "cooldown" ] = "fxexp_353";
    level.var_5646965[ 4 ][ "pad" ] = "upper_courtyard_flinger_base4";
    level.var_5646965[ 4 ][ "landpad" ] = 5;
    level.var_5646965[ 5 ][ "ready" ] = "fxexp_154";
    level.var_5646965[ 5 ][ "cooldown" ] = "fxexp_354";
    level.var_5646965[ 5 ][ "pad" ] = "upper_courtyard_flinger_base3";
    level.var_5646965[ 5 ][ "landpad" ] = 4;
    level.var_5646965[ 6 ][ "ready" ] = "fxexp_155";
    level.var_5646965[ 6 ][ "cooldown" ] = "fxexp_355";
    level.var_5646965[ 6 ][ "pad" ] = "upper_courtyard_flinger_base5";
    level.var_5646965[ 6 ][ "landpad" ] = 7;
    level.var_5646965[ 7 ][ "ready" ] = "fxexp_156";
    level.var_5646965[ 7 ][ "cooldown" ] = "fxexp_356";
    level.var_5646965[ 7 ][ "pad" ] = "upper_courtyard_flinger_base6";
    level.var_5646965[ 7 ][ "landpad" ] = 6;
    level.var_5646965[ 8 ][ "ready" ] = "fxexp_157";
    level.var_5646965[ 8 ][ "cooldown" ] = "fxexp_357";
    level.var_5646965[ 8 ][ "pad" ] = "upper_courtyard_flinger_base8";
    level.var_5646965[ 8 ][ "landpad" ] = 1;
}

// Namespace zm_genesis_flingers
// Params 7
// Checksum 0x7fdd1481, Offset: 0x1270
// Size: 0x84
function function_a0a5829( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        if ( self.owner == getlocalplayer( localclientnum ) )
        {
            self thread function_7bd5b92f( localclientnum );
        }
    }
}

// Namespace zm_genesis_flingers
// Params 1
// Checksum 0x887ed4ac, Offset: 0x1300
// Size: 0x9c
function function_7bd5b92f( localclientnum )
{
    player = getlocalplayer( localclientnum );
    
    if ( isdefined( player ) )
    {
        if ( isthirdperson( localclientnum ) )
        {
            self show();
            player hide();
            return;
        }
        
        self hide();
    }
}

