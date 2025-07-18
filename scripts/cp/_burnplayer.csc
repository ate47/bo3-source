#using scripts/codescripts/struct;
#using scripts/shared/util_shared;

#namespace burnplayer;

// Namespace burnplayer
// Params 0
// Checksum 0x99ec1590, Offset: 0x140
// Size: 0x4
function initflamefx()
{
    
}

// Namespace burnplayer
// Params 1
// Checksum 0x16dfc1bc, Offset: 0x150
// Size: 0x19c
function corpseflamefx( localclientnum )
{
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( level._effect[ "character_fire_death_torso" ] ) )
    {
        initflamefx();
    }
    
    tagarray = [];
    tagarray[ tagarray.size ] = "J_Wrist_RI";
    tagarray[ tagarray.size ] = "J_Wrist_LE";
    tagarray[ tagarray.size ] = "J_Elbow_LE";
    tagarray[ tagarray.size ] = "J_Elbow_RI";
    tagarray[ tagarray.size ] = "J_Knee_RI";
    tagarray[ tagarray.size ] = "J_Knee_LE";
    tagarray[ tagarray.size ] = "J_Ankle_RI";
    tagarray[ tagarray.size ] = "J_Ankle_LE";
    
    if ( isdefined( level._effect[ "character_fire_death_sm" ] ) )
    {
        for ( arrayindex = 0; arrayindex < tagarray.size ; arrayindex++ )
        {
            playfxontag( localclientnum, level._effect[ "character_fire_death_sm" ], self, tagarray[ arrayindex ] );
        }
    }
    
    playfxontag( localclientnum, level._effect[ "character_fire_death_torso" ], self, "J_SpineLower" );
}

