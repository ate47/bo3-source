#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_weap_elemental_bow;

#namespace _zm_weap_elemental_bow_demongate;

// Namespace _zm_weap_elemental_bow_demongate
// Params 0, eflags: 0x2
// Checksum 0x75e7af2, Offset: 0x630
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "_zm_weap_elemental_bow_demongate", &__init__, undefined, undefined );
}

// Namespace _zm_weap_elemental_bow_demongate
// Params 0
// Checksum 0x4848905a, Offset: 0x670
// Size: 0x39e
function __init__()
{
    clientfield::register( "toplayer", "elemental_bow_demongate" + "_ambient_bow_fx", 5000, 1, "int", &function_da7a9948, 0, 0 );
    clientfield::register( "missile", "elemental_bow_demongate" + "_arrow_impact_fx", 5000, 1, "int", &function_f514bd4b, 0, 0 );
    clientfield::register( "missile", "elemental_bow_demongate4" + "_arrow_impact_fx", 5000, 1, "int", &function_3e42c666, 0, 0 );
    clientfield::register( "scriptmover", "demongate_portal_fx", 5000, 1, "int", &demongate_portal_fx, 0, 0 );
    clientfield::register( "toplayer", "demongate_portal_rumble", 1, 1, "int", &demongate_portal_rumble, 0, 0 );
    clientfield::register( "scriptmover", "demongate_wander_locomotion_anim", 5000, 1, "int", &demongate_wander_locomotion_anim, 0, 0 );
    clientfield::register( "scriptmover", "demongate_attack_locomotion_anim", 5000, 1, "int", &demongate_attack_locomotion_anim, 0, 0 );
    clientfield::register( "scriptmover", "demongate_chomper_fx", 5000, 1, "int", &demongate_chomper_fx, 0, 0 );
    clientfield::register( "scriptmover", "demongate_chomper_bite_fx", 5000, 1, "counter", &demongate_chomper_bite_fx, 0, 0 );
    level._effect[ "demongate_ambient_bow" ] = "dlc1/zmb_weapon/fx_bow_demongate_ambient_1p_zmb";
    level._effect[ "demongate_arrow_impact" ] = "dlc1/zmb_weapon/fx_bow_demongate_impact_zmb";
    level._effect[ "demongate_arrow_charged_impact" ] = "dlc1/zmb_weapon/fx_bow_demongate_impact_ug_zmb";
    level._effect[ "demongate_chomper_trail" ] = "dlc1/zmb_weapon/fx_bow_demonhead_trail_zmb";
    level._effect[ "demongate_chomper_bite" ] = "dlc1/zmb_weapon/fx_bow_demonhead_bite_zmb";
    level._effect[ "demongate_chomper_end" ] = "dlc1/zmb_weapon/fx_bow_demonhead_despawn_zmb";
    level._effect[ "demongate_portal_open" ] = "dlc1/zmb_weapon/fx_bow_demongate_portal_open_zmb";
    level._effect[ "demongate_portal_loop" ] = "dlc1/zmb_weapon/fx_bow_demongate_portal_loop_zmb";
    level._effect[ "demongate_portal_close" ] = "dlc1/zmb_weapon/fx_bow_demongate_portal_close_zmb";
}

// Namespace _zm_weap_elemental_bow_demongate
// Params 7
// Checksum 0xe3b3815b, Offset: 0xa18
// Size: 0x64
function function_da7a9948( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self zm_weap_elemental_bow::function_3158b481( localclientnum, newval, "demongate_ambient_bow" );
}

// Namespace _zm_weap_elemental_bow_demongate
// Params 7
// Checksum 0xe3a53729, Offset: 0xa88
// Size: 0x74
function function_f514bd4b( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        playfx( localclientnum, level._effect[ "demongate_arrow_impact" ], self.origin );
    }
}

// Namespace _zm_weap_elemental_bow_demongate
// Params 7
// Checksum 0x7deab41f, Offset: 0xb08
// Size: 0x74
function function_3e42c666( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        playfx( localclientnum, level._effect[ "demongate_arrow_charged_impact" ], self.origin );
    }
}

// Namespace _zm_weap_elemental_bow_demongate
// Params 7
// Checksum 0xd0ae3df6, Offset: 0xb88
// Size: 0x1a4
function demongate_portal_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        playfx( localclientnum, level._effect[ "demongate_portal_open" ], self.origin, anglestoforward( self.angles ) );
        self.var_4b6fd850 = self playloopsound( "zmb_demongate_portal_lp", 1 );
        wait 0.45;
        self.var_fd0edd83 = playfx( localclientnum, level._effect[ "demongate_portal_loop" ], self.origin, anglestoforward( self.angles ) );
        return;
    }
    
    deletefx( localclientnum, self.var_fd0edd83, 0 );
    playfx( localclientnum, level._effect[ "demongate_portal_close" ], self.origin, anglestoforward( self.angles ) );
    
    if ( isdefined( self.var_4b6fd850 ) )
    {
        self stoploopsound( self.var_4b6fd850, 1 );
    }
}

// Namespace _zm_weap_elemental_bow_demongate
// Params 7
// Checksum 0x55e92d05, Offset: 0xd38
// Size: 0x6e
function demongate_portal_rumble( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self thread function_35e3ef91( localclientnum );
        return;
    }
    
    self notify( #"hash_3e0789ec" );
}

// Namespace _zm_weap_elemental_bow_demongate
// Params 1
// Checksum 0x10d6567b, Offset: 0xdb0
// Size: 0x60
function function_35e3ef91( localclientnum )
{
    level endon( #"demo_jump" );
    self endon( #"hash_3e0789ec" );
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self playrumbleonentity( localclientnum, "zod_idgun_vortex_interior" );
        wait 0.075;
    }
}

#using_animtree( "generic" );

// Namespace _zm_weap_elemental_bow_demongate
// Params 7
// Checksum 0x13859d7e, Offset: 0xe18
// Size: 0x9c
function demongate_wander_locomotion_anim( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !self hasanimtree() )
    {
        self useanimtree( #animtree );
    }
    
    if ( newval )
    {
        self setanim( "ai_zm_dlc1_chomper_a_demongate_swarm_locomotion_f_notrans" );
    }
}

// Namespace _zm_weap_elemental_bow_demongate
// Params 7
// Checksum 0x6fa9c9e1, Offset: 0xec0
// Size: 0x9c
function demongate_attack_locomotion_anim( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !self hasanimtree() )
    {
        self useanimtree( #animtree );
    }
    
    if ( newval )
    {
        self setanim( "ai_zm_dlc1_chomper_a_demongate_swarm_locomotion_f_notrans" );
    }
}

// Namespace _zm_weap_elemental_bow_demongate
// Params 7
// Checksum 0x8060380d, Offset: 0xf68
// Size: 0x15c
function demongate_chomper_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    
    if ( newval )
    {
        if ( isdefined( self.var_a581816a ) )
        {
            deletefx( localclientnum, self.var_a581816a, 1 );
        }
        
        self.var_a581816a = playfxontag( localclientnum, level._effect[ "demongate_chomper_trail" ], self, "tag_fx" );
        return;
    }
    
    if ( isdefined( self.var_a581816a ) )
    {
        deletefx( localclientnum, self.var_a581816a, 0 );
        self.var_a581816a = undefined;
    }
    
    self playsound( 0, "zmb_demongate_chomper_disappear" );
    playfxontag( localclientnum, level._effect[ "demongate_chomper_end" ], self, "tag_fx" );
    wait 0.4;
    self hide();
}

// Namespace _zm_weap_elemental_bow_demongate
// Params 7
// Checksum 0x95c5f1c, Offset: 0x10d0
// Size: 0xfc
function demongate_chomper_bite_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    
    if ( isdefined( self.var_64b4f506 ) )
    {
        stopfx( localclientnum, self.var_64b4f506 );
    }
    
    self playsound( 0, "zmb_demongate_chomper_bite" );
    self.var_64b4f506 = playfx( localclientnum, level._effect[ "demongate_chomper_bite" ], self.origin );
    wait 0.1;
    
    if ( isdefined( self.var_64b4f506 ) )
    {
        stopfx( localclientnum, self.var_64b4f506 );
    }
}

