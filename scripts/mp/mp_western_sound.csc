#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;

#namespace mp_western_sound;

// Namespace mp_western_sound
// Params 0
// Checksum 0x10308117, Offset: 0xd8
// Size: 0x1c
function main()
{
    level thread function_d87d721e();
}

// Namespace mp_western_sound
// Params 0
// Checksum 0x19a59b5, Offset: 0x100
// Size: 0x94
function function_d87d721e()
{
    if ( !isdefined( level.var_51811911 ) )
    {
        level.var_51811911 = spawn( 0, ( 1362, 1603, 23 ), "script.origin" );
    }
    
    level waittill( #"hash_3627ba1" );
    level.var_51811911 playsound( 0, "amb_train_metal_rattle" );
    wait 15;
    level.var_51811911 delete();
}

