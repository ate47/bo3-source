#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace multi_extracam;

// Namespace multi_extracam
// Params 2
// Checksum 0x20db4b53, Offset: 0x130
// Size: 0xb6
function extracam_reset_index( localclientnum, index )
{
    if ( !isdefined( level.camera_ents ) || !isdefined( level.camera_ents[ localclientnum ] ) )
    {
        return;
    }
    
    if ( isdefined( level.camera_ents[ localclientnum ][ index ] ) )
    {
        level.camera_ents[ localclientnum ][ index ] clearextracam();
        level.camera_ents[ localclientnum ][ index ] delete();
        level.camera_ents[ localclientnum ][ index ] = undefined;
    }
}

// Namespace multi_extracam
// Params 3
// Checksum 0x1edafe9a, Offset: 0x1f0
// Size: 0x62
function extracam_init_index( localclientnum, target, index )
{
    camerastruct = struct::get( target, "targetname" );
    return extracam_init_item( localclientnum, camerastruct, index );
}

// Namespace multi_extracam
// Params 3
// Checksum 0x5e84865c, Offset: 0x260
// Size: 0x182
function extracam_init_item( localclientnum, copy_ent, index )
{
    if ( !isdefined( level.camera_ents ) )
    {
        level.camera_ents = [];
    }
    
    if ( !isdefined( level.camera_ents[ localclientnum ] ) )
    {
        level.camera_ents[ localclientnum ] = [];
    }
    
    if ( isdefined( level.camera_ents[ localclientnum ][ index ] ) )
    {
        level.camera_ents[ localclientnum ][ index ] clearextracam();
        level.camera_ents[ localclientnum ][ index ] delete();
        level.camera_ents[ localclientnum ][ index ] = undefined;
    }
    
    if ( isdefined( copy_ent ) )
    {
        level.camera_ents[ localclientnum ][ index ] = spawn( localclientnum, copy_ent.origin, "script_origin" );
        level.camera_ents[ localclientnum ][ index ].angles = copy_ent.angles;
        level.camera_ents[ localclientnum ][ index ] setextracam( index );
        return level.camera_ents[ localclientnum ][ index ];
    }
    
    return undefined;
}

