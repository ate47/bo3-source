#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_castle_ee_side;

// Namespace zm_castle_ee_side
// Params 0, eflags: 0x2
// Checksum 0xcc1194b6, Offset: 0x308
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_zod_ee_side", &__init__, undefined, undefined );
}

// Namespace zm_castle_ee_side
// Params 0
// Checksum 0x9e99a542, Offset: 0x348
// Size: 0x154
function __init__()
{
    level._effect[ "clocktower_flash" ] = "dlc1/castle/fx_lightning_strike_weathervane";
    level._effect[ "exploding_death" ] = "dlc1/zmb_weapon/fx_ee_plunger_teleport_impact";
    clientfield::register( "world", "clocktower_flash", 5000, 1, "counter", &clocktower_flash, 0, 0 );
    clientfield::register( "world", "sndUEB", 5000, 1, "int", &sndueb, 0, 0 );
    clientfield::register( "actor", "plunger_exploding_ai", 5000, 1, "int", &callback_exploding_death_fx, 0, 0 );
    clientfield::register( "toplayer", "plunger_charged_strike", 5000, 1, "counter", &plunger_charged_strike, 0, 0 );
}

// Namespace zm_castle_ee_side
// Params 7
// Checksum 0x8665134f, Offset: 0x4a8
// Size: 0x9c
function clocktower_flash( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    s_rod = struct::get( "ee_clocktower_lightning_rod", "targetname" );
    playfx( localclientnum, level._effect[ "clocktower_flash" ], s_rod.origin );
}

// Namespace zm_castle_ee_side
// Params 7
// Checksum 0xcf7258a2, Offset: 0x550
// Size: 0xec
function sndueb( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        playsound( 0, "zmb_pyramid_energy_ball_start", ( -1192, 2256, 320 ) );
        audio::playloopat( "zmb_pyramid_energy_ball_lp", ( -1192, 2256, 320 ) );
        return;
    }
    
    playsound( 0, "zmb_pyramid_energy_ball_end", ( -1192, 2256, 320 ) );
    audio::stoploopat( "zmb_pyramid_energy_ball_lp", ( -1192, 2256, 320 ) );
}

// Namespace zm_castle_ee_side
// Params 7
// Checksum 0xf12d3c0e, Offset: 0x648
// Size: 0x13c
function callback_exploding_death_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        v_pos = self gettagorigin( "j_spine4" );
        v_angles = self gettagangles( "j_spine4" );
        var_e6ddb5de = util::spawn_model( localclientnum, "tag_origin", v_pos, v_angles );
        playfxontag( localclientnum, level._effect[ "exploding_death" ], var_e6ddb5de, "tag_origin" );
        var_e6ddb5de playsound( localclientnum, "evt_ai_explode" );
        wait 6;
        var_e6ddb5de delete();
    }
}

// Namespace zm_castle_ee_side
// Params 7
// Checksum 0xdbeed443, Offset: 0x790
// Size: 0x9c
function plunger_charged_strike( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playviewmodelfx( localclientnum, level._effect[ "plunger_charge_1p" ], "tag_fx" );
    playfxontag( localclientnum, level._effect[ "plunger_charge_3p" ], self, "tag_fx" );
}

