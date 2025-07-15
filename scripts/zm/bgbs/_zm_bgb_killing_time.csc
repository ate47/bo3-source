#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_killing_time;

// Namespace zm_bgb_killing_time
// Params 0, eflags: 0x2
// Checksum 0xc0fa76bd, Offset: 0x1d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_killing_time", &__init__, undefined, undefined );
}

// Namespace zm_bgb_killing_time
// Params 0
// Checksum 0x57de1a93, Offset: 0x218
// Size: 0xcc
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    bgb::register( "zm_bgb_killing_time", "activated" );
    clientfield::register( "actor", "zombie_instakill_fx", 1, 1, "int", &function_a81107fc, 0, 1 );
    clientfield::register( "toplayer", "instakill_upgraded_fx", 1, 1, "int", &function_cf8c9fce, 0, 0 );
}

// Namespace zm_bgb_killing_time
// Params 7
// Checksum 0x53c00ba2, Offset: 0x2f0
// Size: 0x56
function function_cf8c9fce( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        return;
    }
    
    self notify( #"hash_eb366021" );
}

// Namespace zm_bgb_killing_time
// Params 1
// Checksum 0x6e3d244b, Offset: 0x350
// Size: 0x86
function function_2a30e2ca( localclientnum )
{
    self endon( #"death" );
    self endon( #"end_demo_jump_listener" );
    self endon( #"entityshutdown" );
    self notify( #"hash_eb366021" );
    self endon( #"hash_eb366021" );
    
    while ( true )
    {
        self.var_dedf9511 = self playsound( localclientnum, "zmb_music_box", self.origin );
        wait 4;
    }
}

// Namespace zm_bgb_killing_time
// Params 7
// Checksum 0x13eba211, Offset: 0x3e0
// Size: 0xa4
function function_a81107fc( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( newval ) )
    {
        return;
    }
    
    if ( newval )
    {
        fxobj = util::spawn_model( localclientnum, "tag_origin", self.origin, self.angles );
        fxobj thread function_10dcbf51( localclientnum, fxobj );
    }
}

// Namespace zm_bgb_killing_time
// Params 2, eflags: 0x4
// Checksum 0x4d0d7ef4, Offset: 0x490
// Size: 0x54
function private function_10dcbf51( localclientnum, fxobj )
{
    fxobj playsound( localclientnum, "evt_ai_explode" );
    wait 1;
    fxobj delete();
}

