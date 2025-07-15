#using scripts/codescripts/struct;

#namespace mp_rise_fx;

// Namespace mp_rise_fx
// Params 0
// Checksum 0x99ec1590, Offset: 0xa8
// Size: 0x4
function precache_scripted_fx()
{
    
}

// Namespace mp_rise_fx
// Params 0
// Checksum 0x737b1416, Offset: 0xb8
// Size: 0x26
function precache_fx_anims()
{
    level.scr_anim = [];
    level.scr_anim[ "fxanim_props" ] = [];
}

// Namespace mp_rise_fx
// Params 0
// Checksum 0xbd019ea6, Offset: 0xe8
// Size: 0x54
function main()
{
    disablefx = getdvarint( "disable_fx" );
    
    if ( !isdefined( disablefx ) || disablefx <= 0 )
    {
        precache_scripted_fx();
    }
}

