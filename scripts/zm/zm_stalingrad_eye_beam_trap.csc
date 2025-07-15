#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_stalingrad_eye_beam_trap;

// Namespace zm_stalingrad_eye_beam_trap
// Params 0, eflags: 0x2
// Checksum 0x4ee396ee, Offset: 0x228
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_stalingrad_eye_beam_trap", &__init__, undefined, undefined );
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 0
// Checksum 0x736fe9cd, Offset: 0x268
// Size: 0xdc
function __init__()
{
    clientfield::register( "toplayer", "eye_beam_trap_postfx", 12000, 1, "int", &function_822dbe7f, 0, 0 );
    clientfield::register( "world", "eye_beam_rumble_factory", 12000, 1, "int", &function_3d1860f, 0, 0 );
    clientfield::register( "world", "eye_beam_rumble_library", 12000, 1, "int", &function_ea1e41d4, 0, 0 );
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 7
// Checksum 0xc918714a, Offset: 0x350
// Size: 0x7c
function function_822dbe7f( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self thread postfx::playpostfxbundle( "pstfx_eye_beam_dmg" );
        return;
    }
    
    self thread postfx::stoppostfxbundle();
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 7
// Checksum 0x133b4d5a, Offset: 0x3d8
// Size: 0xf4
function function_3d1860f( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    e_player = getlocalplayer( localclientnum );
    
    if ( newval )
    {
        e_player.var_ce79a8bf = function_3975127( localclientnum, "factory" );
        return;
    }
    
    if ( isdefined( e_player.var_ce79a8bf ) )
    {
        e_player.var_ce79a8bf stoprumble( localclientnum, "zm_stalingrad_eye_beam_rumble" );
        e_player.var_ce79a8bf delete();
    }
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 7
// Checksum 0xccd8526, Offset: 0x4d8
// Size: 0xf4
function function_ea1e41d4( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    e_player = getlocalplayer( localclientnum );
    
    if ( newval )
    {
        e_player.var_5082384e = function_3975127( localclientnum, "library" );
        return;
    }
    
    if ( isdefined( e_player.var_5082384e ) )
    {
        e_player.var_5082384e stoprumble( localclientnum, "zm_stalingrad_eye_beam_rumble" );
        e_player.var_5082384e delete();
    }
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 2
// Checksum 0x9b6fd2a6, Offset: 0x5d8
// Size: 0xa8
function function_3975127( localclientnum, str_location )
{
    var_459eee06 = struct::get( "eye_beam_rumble_" + str_location, "targetname" );
    var_7cbc8176 = util::spawn_model( localclientnum, "tag_origin", var_459eee06.origin );
    var_7cbc8176 playrumbleonentity( localclientnum, "zm_stalingrad_eye_beam_rumble" );
    return var_7cbc8176;
}

