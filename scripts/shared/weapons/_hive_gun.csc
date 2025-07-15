#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace hive_gun;

// Namespace hive_gun
// Params 0
// Checksum 0xa687986d, Offset: 0x3a0
// Size: 0x1c
function init_shared()
{
    level thread register();
}

// Namespace hive_gun
// Params 0
// Checksum 0x72891d0a, Offset: 0x3c8
// Size: 0xdc
function register()
{
    clientfield::register( "scriptmover", "firefly_state", 1, 3, "int", &firefly_state_change, 0, 0 );
    clientfield::register( "toplayer", "fireflies_attacking", 1, 1, "int", &fireflies_attacking, 0, 1 );
    clientfield::register( "toplayer", "fireflies_chasing", 1, 1, "int", &fireflies_chasing, 0, 1 );
}

// Namespace hive_gun
// Params 1
// Checksum 0x2a432276, Offset: 0x4b0
// Size: 0x4c
function getotherteam( team )
{
    if ( team == "allies" )
    {
        return "axis";
    }
    
    if ( team == "axis" )
    {
        return "allies";
    }
    
    return "free";
}

// Namespace hive_gun
// Params 7
// Checksum 0xf387e8a9, Offset: 0x508
// Size: 0x10e
function fireflies_attacking( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval )
    {
        self notify( #"stop_player_fx" );
        
        if ( self islocalplayer() && !self getinkillcam( localclientnum ) )
        {
            fx = playfxoncamera( localclientnum, "weapon/fx_ability_firefly_attack_1p", ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
            self thread watch_player_fx_finished( localclientnum, fx );
        }
        
        return;
    }
    
    self notify( #"stop_player_fx" );
}

// Namespace hive_gun
// Params 7
// Checksum 0xa5d1ac2a, Offset: 0x620
// Size: 0x15e
function fireflies_chasing( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( newval )
    {
        self notify( #"stop_player_fx" );
        
        if ( self islocalplayer() && !self getinkillcam( localclientnum ) )
        {
            fx = playfxoncamera( localclientnum, "weapon/fx_ability_firefly_chase_1p", ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
            sound = self playloopsound( "wpn_gelgun_hive_hunt_lp" );
            self playrumblelooponentity( localclientnum, "firefly_chase_rumble_loop" );
            self thread watch_player_fx_finished( localclientnum, fx, sound );
        }
        
        return;
    }
    
    self notify( #"stop_player_fx" );
}

// Namespace hive_gun
// Params 3
// Checksum 0x67fc62a1, Offset: 0x788
// Size: 0xbc
function watch_player_fx_finished( localclientnum, fx, sound )
{
    self util::waittill_any( "entityshutdown", "stop_player_fx" );
    
    if ( isdefined( self ) )
    {
        self stoprumble( localclientnum, "firefly_chase_rumble_loop" );
    }
    
    if ( isdefined( fx ) )
    {
        stopfx( localclientnum, fx );
    }
    
    if ( isdefined( sound ) && isdefined( self ) )
    {
        self stoploopsound( sound );
    }
}

// Namespace hive_gun
// Params 7
// Checksum 0x184cfd32, Offset: 0x850
// Size: 0x14e
function firefly_state_change( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    self util::waittill_dobj( localclientnum );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.initied ) )
    {
        self thread firefly_init( localclientnum );
        self.initied = 1;
    }
    
    switch ( newval )
    {
        case 0:
            break;
        case 1:
            self firefly_deploying( localclientnum );
            break;
        case 2:
            self firefly_hunting( localclientnum );
            break;
        case 3:
            self firefly_attacking( localclientnum );
            break;
        case 4:
            self firefly_link_attacking( localclientnum );
            break;
    }
}

// Namespace hive_gun
// Params 2
// Checksum 0x93f98983, Offset: 0x9a8
// Size: 0xb4
function on_shutdown( localclientnum, ent )
{
    if ( isdefined( ent ) && isdefined( ent.origin ) && self === ent && !( isdefined( self.no_death_fx ) && self.no_death_fx ) )
    {
        fx = playfx( localclientnum, "weapon/fx_hero_firefly_death", ent.origin, ( 0, 0, 1 ) );
        setfxteam( localclientnum, fx, ent.team );
    }
}

// Namespace hive_gun
// Params 1
// Checksum 0x51aaee7f, Offset: 0xa68
// Size: 0x2c
function firefly_init( localclientnum )
{
    self callback::on_shutdown( &on_shutdown, self );
}

// Namespace hive_gun
// Params 1
// Checksum 0x4f834a09, Offset: 0xaa0
// Size: 0x74
function firefly_deploying( localclientnum )
{
    fx = playfx( localclientnum, "weapon/fx_hero_firefly_start", self.origin, anglestoup( self.angles ) );
    setfxteam( localclientnum, fx, self.team );
}

// Namespace hive_gun
// Params 1
// Checksum 0x7bff501f, Offset: 0xb20
// Size: 0x84
function firefly_hunting( localclientnum )
{
    fx = playfxontag( localclientnum, "weapon/fx_hero_firefly_hunting", self, "tag_origin" );
    setfxteam( localclientnum, fx, self.team );
    self thread firefly_watch_fx_finished( localclientnum, fx );
}

// Namespace hive_gun
// Params 2
// Checksum 0xc31b21cb, Offset: 0xbb0
// Size: 0x64
function firefly_watch_fx_finished( localclientnum, fx )
{
    self util::waittill_any( "entityshutdown", "stop_effects" );
    
    if ( isdefined( fx ) )
    {
        stopfx( localclientnum, fx );
    }
}

// Namespace hive_gun
// Params 1
// Checksum 0x2e3a5c2b, Offset: 0xc20
// Size: 0x28
function firefly_attacking( localclientnum )
{
    self notify( #"stop_effects" );
    self.no_death_fx = 1;
}

// Namespace hive_gun
// Params 1
// Checksum 0xdbacaaa3, Offset: 0xc50
// Size: 0x90
function firefly_link_attacking( localclientnum )
{
    fx = playfx( localclientnum, "weapon/fx_hero_firefly_start_entity", self.origin, anglestoup( self.angles ) );
    setfxteam( localclientnum, fx, self.team );
    self notify( #"stop_effects" );
    self.no_death_fx = 1;
}

// Namespace hive_gun
// Params 3
// Checksum 0xb1549db5, Offset: 0xce8
// Size: 0xac
function gib_fx( localclientnum, fxfilename, gibflag )
{
    fxtag = gibclientutils::playergibtag( localclientnum, gibflag );
    
    if ( isdefined( fxtag ) )
    {
        fx = playfxontag( localclientnum, fxfilename, self, fxtag );
        setfxteam( localclientnum, fx, getotherteam( self.team ) );
    }
}

// Namespace hive_gun
// Params 2
// Checksum 0xd2504f7c, Offset: 0xda0
// Size: 0x34
function gib_corpse( localclientnum, value )
{
    self endon( #"entityshutdown" );
    self thread watch_for_gib_notetracks( localclientnum );
}

// Namespace hive_gun
// Params 1
// Checksum 0xf782d03, Offset: 0xde0
// Size: 0x34e
function watch_for_gib_notetracks( localclientnum )
{
    self endon( #"entityshutdown" );
    
    if ( !util::is_mature() || util::is_gib_restricted_build() )
    {
        return;
    }
    
    fxfilename = "weapon/fx_hero_firefly_attack_limb";
    bodytype = self getcharacterbodytype();
    
    if ( bodytype >= 0 )
    {
        bodytypefields = getcharacterfields( bodytype, currentsessionmode() );
        
        if ( isdefined( bodytypefields.digitalblood ) ? bodytypefields.digitalblood : 0 )
        {
            fxfilename = "weapon/fx_hero_firefly_attack_limb_reaper";
        }
    }
    
    arm_gib = 0;
    leg_gib = 0;
    
    while ( true )
    {
        notetrack = self util::waittill_any_return( "gib_leftarm", "gib_leftleg", "gib_rightarm", "gib_rightleg", "entityshutdown" );
        
        switch ( notetrack )
        {
            case "gib_rightarm":
                arm_gib |= 1;
                gib_fx( localclientnum, fxfilename, 16 );
                self gibclientutils::playergibleftarm( localclientnum );
                self setcorpsegibstate( leg_gib, arm_gib );
                break;
            case "gib_leftarm":
                arm_gib |= 2;
                gib_fx( localclientnum, fxfilename, 32 );
                self gibclientutils::playergibleftarm( localclientnum );
                self setcorpsegibstate( leg_gib, arm_gib );
                break;
            case "gib_rightleg":
                leg_gib |= 1;
                gib_fx( localclientnum, fxfilename, 128 );
                self gibclientutils::playergibleftleg( localclientnum );
                self setcorpsegibstate( leg_gib, arm_gib );
                break;
            case "gib_leftleg":
                leg_gib |= 2;
                gib_fx( localclientnum, fxfilename, 256 );
                self gibclientutils::playergibleftleg( localclientnum );
                self setcorpsegibstate( leg_gib, arm_gib );
                break;
            default:
                break;
        }
    }
}

