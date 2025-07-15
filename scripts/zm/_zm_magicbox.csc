#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace zm_magicbox;

// Namespace zm_magicbox
// Params 0, eflags: 0x2
// Checksum 0x3041b061, Offset: 0x228
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_magicbox", &__init__, undefined, undefined );
}

// Namespace zm_magicbox
// Params 0
// Checksum 0x15a92a1e, Offset: 0x268
// Size: 0x19c
function __init__()
{
    level._effect[ "chest_light" ] = "zombie/fx_weapon_box_open_glow_zmb";
    level._effect[ "chest_light_closed" ] = "zombie/fx_weapon_box_closed_glow_zmb";
    clientfield::register( "zbarrier", "magicbox_open_glow", 1, 1, "int", &magicbox_open_glow_callback, 0, 0 );
    clientfield::register( "zbarrier", "magicbox_closed_glow", 1, 1, "int", &magicbox_closed_glow_callback, 0, 0 );
    clientfield::register( "zbarrier", "zbarrier_show_sounds", 1, 1, "counter", &magicbox_show_sounds_callback, 1, 0 );
    clientfield::register( "zbarrier", "zbarrier_leave_sounds", 1, 1, "counter", &magicbox_leave_sounds_callback, 1, 0 );
    clientfield::register( "scriptmover", "force_stream", 7000, 1, "int", &force_stream_changed, 0, 0 );
}

// Namespace zm_magicbox
// Params 7
// Checksum 0x2b7ff53b, Offset: 0x410
// Size: 0x84
function force_stream_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        model = self.model;
        
        if ( isdefined( model ) )
        {
            thread stream_model_for_time( localclientnum, model, 15 );
        }
    }
}

// Namespace zm_magicbox
// Params 1
// Checksum 0x568c8c9f, Offset: 0x4a0
// Size: 0x92
function lock_weapon_model( model )
{
    if ( isdefined( model ) )
    {
        if ( !isdefined( level.model_locks ) )
        {
            level.model_locks = [];
        }
        
        if ( !isdefined( level.model_locks[ model ] ) )
        {
            level.model_locks[ model ] = 0;
        }
        
        if ( level.model_locks[ model ] < 1 )
        {
            forcestreamxmodel( model );
        }
        
        level.model_locks[ model ]++;
    }
}

// Namespace zm_magicbox
// Params 1
// Checksum 0x83cf2af1, Offset: 0x540
// Size: 0x94
function unlock_weapon_model( model )
{
    if ( isdefined( model ) )
    {
        if ( !isdefined( level.model_locks ) )
        {
            level.model_locks = [];
        }
        
        if ( !isdefined( level.model_locks[ model ] ) )
        {
            level.model_locks[ model ] = 0;
        }
        
        level.model_locks[ model ]--;
        
        if ( level.model_locks[ model ] < 1 )
        {
            stopforcestreamingxmodel( model );
        }
    }
}

// Namespace zm_magicbox
// Params 3
// Checksum 0xc01f8ae1, Offset: 0x5e0
// Size: 0x54
function stream_model_for_time( localclientnum, model, time )
{
    lock_weapon_model( model );
    wait time;
    unlock_weapon_model( model );
}

// Namespace zm_magicbox
// Params 7
// Checksum 0xe8dff6f1, Offset: 0x640
// Size: 0xb4
function magicbox_show_sounds_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playsound( localclientnum, "zmb_box_poof_land", self.origin );
    playsound( localclientnum, "zmb_couch_slam", self.origin );
    playsound( localclientnum, "zmb_box_poof", self.origin );
}

// Namespace zm_magicbox
// Params 7
// Checksum 0x54528e66, Offset: 0x700
// Size: 0x8c
function magicbox_leave_sounds_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playsound( localclientnum, "zmb_box_move", self.origin );
    playsound( localclientnum, "zmb_whoosh", self.origin );
}

// Namespace zm_magicbox
// Params 7
// Checksum 0xa0077f8e, Offset: 0x798
// Size: 0x6c
function magicbox_open_glow_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self thread magicbox_glow_callback( localclientnum, newval, level._effect[ "chest_light" ] );
}

// Namespace zm_magicbox
// Params 7
// Checksum 0x208dd9ad, Offset: 0x810
// Size: 0x6c
function magicbox_closed_glow_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self thread magicbox_glow_callback( localclientnum, newval, level._effect[ "chest_light_closed" ] );
}

// Namespace zm_magicbox
// Params 3
// Checksum 0x18eecaaa, Offset: 0x888
// Size: 0x154
function magicbox_glow_callback( localclientnum, newval, fx )
{
    if ( !isdefined( self.glow_obj_array ) )
    {
        self.glow_obj_array = [];
    }
    
    if ( !isdefined( self.glow_fx_array ) )
    {
        self.glow_fx_array = [];
    }
    
    if ( !isdefined( self.glow_obj_array[ localclientnum ] ) )
    {
        fx_obj = spawn( localclientnum, self.origin, "script_model" );
        fx_obj setmodel( "tag_origin" );
        fx_obj.angles = self.angles;
        self.glow_obj_array[ localclientnum ] = fx_obj;
        wait 0.016;
    }
    
    self glow_obj_cleanup( localclientnum );
    
    if ( newval )
    {
        self.glow_fx_array[ localclientnum ] = playfxontag( localclientnum, fx, self.glow_obj_array[ localclientnum ], "tag_origin" );
        self glow_obj_demo_jump_listener( localclientnum );
    }
}

// Namespace zm_magicbox
// Params 1
// Checksum 0x2b5300ae, Offset: 0x9e8
// Size: 0x44
function glow_obj_demo_jump_listener( localclientnum )
{
    self endon( #"end_demo_jump_listener" );
    level waittill( #"demo_jump" );
    
    if ( isdefined( self ) )
    {
        self glow_obj_cleanup( localclientnum );
    }
}

// Namespace zm_magicbox
// Params 1
// Checksum 0x2f8c75e0, Offset: 0xa38
// Size: 0x5e
function glow_obj_cleanup( localclientnum )
{
    if ( isdefined( self.glow_fx_array[ localclientnum ] ) )
    {
        stopfx( localclientnum, self.glow_fx_array[ localclientnum ] );
        self.glow_fx_array[ localclientnum ] = undefined;
    }
    
    self notify( #"end_demo_jump_listener" );
}

