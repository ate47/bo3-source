#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/craftables/_zm_craftables;

#namespace zm_genesis_shadowman;

// Namespace zm_genesis_shadowman
// Params 0, eflags: 0x2
// Checksum 0x80f065f8, Offset: 0x378
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_genesis_shadowman", &__init__, undefined, undefined );
}

// Namespace zm_genesis_shadowman
// Params 0
// Checksum 0x4c0b4543, Offset: 0x3b8
// Size: 0x4c
function __init__()
{
    clientfield::register( "scriptmover", "shadowman_fx", 15000, 3, "int", &shadowman_fx, 0, 0 );
}

// Namespace zm_genesis_shadowman
// Params 7
// Checksum 0xfb9d61a5, Offset: 0x410
// Size: 0x3da
function shadowman_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.var_6067fcbe ) )
    {
        stopfx( localclientnum, self.var_6067fcbe );
    }
    
    if ( isdefined( self.var_8eb9fdc0 ) )
    {
        stopfx( localclientnum, self.var_8eb9fdc0 );
    }
    
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    switch ( newval )
    {
        case 1:
            playfxontag( localclientnum, level._effect[ "shadowman_teleport" ], self, "j_spinelower" );
            self.var_8741354e = playfxontag( localclientnum, level._effect[ "shadowman_light" ], self, "j_spineupper" );
            self.vfx_smoke = playfxontag( localclientnum, level._effect[ "shadowman_smoke" ], self, "tag_origin" );
            break;
        case 2:
            if ( isdefined( self.var_8741354e ) )
            {
                stopfx( localclientnum, self.var_8741354e );
            }
            
            if ( isdefined( self.vfx_smoke ) )
            {
                stopfx( localclientnum, self.vfx_smoke );
            }
            
            var_87c8152d = level clientfield::get( "circle_challenge_identity" );
            
            if ( isdefined( self.var_b0063e15 ) && var_87c8152d === 4 )
            {
                killfx( localclientnum, self.var_b0063e15 );
            }
            
            v_origin = self gettagorigin( "j_spinelower" );
            level thread function_705b696b( localclientnum, level._effect[ "shadowman_teleport" ], v_origin, 2 );
            level thread function_705b696b( localclientnum, level._effect[ "shadowman_smoke" ], v_origin, 2 );
            break;
        case 3:
            self.var_6067fcbe = playfxontag( localclientnum, level._effect[ "shadowman_hover_charge" ], self, "j_spinelower" );
            self.var_8eb9fdc0 = playfxontag( localclientnum, level._effect[ "shadowman_energy_ball_charge" ], self, "tag_weapon_right" );
            break;
        case 4:
            self.var_8eb9fdc0 = playfxontag( localclientnum, level._effect[ "shadowman_energy_ball" ], self, "tag_weapon_right" );
            break;
        case 5:
            self.var_8eb9fdc0 = playfxontag( localclientnum, level._effect[ "shadowman_energy_ball_explosion" ], self, "tag_weapon_right" );
            break;
        case 6:
            break;
    }
}

// Namespace zm_genesis_shadowman
// Params 4
// Checksum 0xf747eb5b, Offset: 0x7f8
// Size: 0x74
function function_705b696b( localclientnum, str_fx, v_origin, n_seconds )
{
    fx_id = playfx( localclientnum, str_fx, v_origin );
    wait n_seconds;
    stopfx( localclientnum, fx_id );
}

