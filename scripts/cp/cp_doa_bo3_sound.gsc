#using scripts/codescripts/struct;
#using scripts/shared/util_shared;

#namespace cp_doa_bo3_sound;

// Namespace cp_doa_bo3_sound
// Params 0
// Checksum 0x99ec1590, Offset: 0xd0
// Size: 0x4
function main()
{
    
}

#namespace doa_sound;

// Namespace doa_sound
// Params 0
// Checksum 0x8514a9df, Offset: 0xe0
// Size: 0x6c
function function_68fdd800()
{
    if ( !isdefined( level.var_ae4549e5 ) )
    {
        level.var_ae4549e5 = spawn( "script_origin", ( 0, 0, 0 ) );
    }
    
    level.var_ae4549e5 playloopsound( "amb_rally_bg" );
    level.var_ae4549e5 function_42b6c406();
}

// Namespace doa_sound
// Params 0
// Checksum 0x87e393d2, Offset: 0x158
// Size: 0x3c
function function_42b6c406()
{
    level waittill( #"ro" );
    self stoploopsound();
    wait 1;
    self delete();
}

