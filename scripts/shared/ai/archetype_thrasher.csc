#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace archetype_thrasher;

// Namespace archetype_thrasher
// Params 0, eflags: 0x2
// Checksum 0xb33a4207, Offset: 0x608
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "thrasher", &__init__, undefined, undefined );
}

// Namespace archetype_thrasher
// Params 0
// Checksum 0x383e2169, Offset: 0x648
// Size: 0x27c
function __init__()
{
    visionset_mgr::register_visionset_info( "zm_isl_thrasher_stomach_visionset", 9000, 16, undefined, "zm_isl_thrasher_stomach" );
    
    if ( ai::shouldregisterclientfieldforarchetype( "thrasher" ) )
    {
        clientfield::register( "actor", "thrasher_spore_state", 5000, 3, "int", &thrasherclientutils::thrashersporeexplode, 0, 0 );
        clientfield::register( "actor", "thrasher_berserk_state", 5000, 1, "int", &thrasherclientutils::thrasherberserkmode, 0, 1 );
        clientfield::register( "actor", "thrasher_player_hide", 8000, 4, "int", &thrasherclientutils::thrasherhidefromplayer, 0, 0 );
        clientfield::register( "toplayer", "sndPlayerConsumed", 10000, 1, "int", &thrasherclientutils::sndplayerconsumed, 0, 1 );
        
        foreach ( spore in array( 1, 2, 4 ) )
        {
            clientfield::register( "actor", "thrasher_spore_impact" + spore, 8000, 1, "counter", &thrasherclientutils::thrashersporeimpact, 0, 0 );
        }
    }
    
    ai::add_archetype_spawn_function( "thrasher", &thrasherclientutils::thrasherspawn );
    level.thrasherpustules = [];
    level thread thrasherclientutils::thrasherfxcleanup();
}

// Namespace archetype_thrasher
// Params 0, eflags: 0x2
// Checksum 0x19bf02cf, Offset: 0x8d0
// Size: 0x18a
function autoexec precache()
{
    level._effect[ "fx_mech_foot_step" ] = "dlc1/castle/fx_mech_foot_step";
    level._effect[ "fx_thrash_pustule_burst" ] = "dlc2/island/fx_thrash_pustule_burst";
    level._effect[ "fx_thrash_pustule_spore_exp" ] = "dlc2/island/fx_thrash_pustule_spore_exp";
    level._effect[ "fx_thrash_pustule_impact" ] = "dlc2/island/fx_thrash_pustule_impact";
    level._effect[ "fx_thrash_eye_glow" ] = "dlc2/island/fx_thrash_eye_glow";
    level._effect[ "fx_thrash_eye_glow_rage" ] = "dlc2/island/fx_thrash_eye_glow_rage";
    level._effect[ "fx_thrash_rage_gas_torso" ] = "dlc2/island/fx_thrash_rage_gas_torso";
    level._effect[ "fx_thrash_rage_gas_leg_lft" ] = "dlc2/island/fx_thrash_rage_gas_leg_lft";
    level._effect[ "fx_thrash_rage_gas_leg_rgt" ] = "dlc2/island/fx_thrash_rage_gas_leg_rgt";
    level._effect[ "fx_thrash_pustule_reinflate" ] = "dlc2/island/fx_thrash_pustule_reinflate";
    level._effect[ "fx_spores_cloud_ambient_sm" ] = "dlc2/island/fx_spores_cloud_ambient_sm";
    level._effect[ "fx_spores_cloud_ambient_md" ] = "dlc2/island/fx_spores_cloud_ambient_md";
    level._effect[ "fx_spores_cloud_ambient_lrg" ] = "dlc2/island/fx_thrash_pustule_reinflate";
    level._effect[ "fx_thrash_chest_mouth_drool" ] = "dlc2/island/fx_thrash_chest_mouth_drool_1p";
}

#namespace thrasherclientutils;

// Namespace thrasherclientutils
// Params 1, eflags: 0x4
// Checksum 0x7cea4e7f, Offset: 0xa68
// Size: 0x7c
function private thrasherspawn( localclientnum )
{
    entity = self;
    entity.ignoreragdoll = 1;
    level._footstepcbfuncs[ entity.archetype ] = &thrasherprocessfootstep;
    gibclientutils::addgibcallback( localclientnum, entity, 4, &thrasherdisableeyeglow );
}

// Namespace thrasherclientutils
// Params 0, eflags: 0x4
// Checksum 0xe3631728, Offset: 0xaf0
// Size: 0x128
function private thrasherfxcleanup()
{
    while ( true )
    {
        pustules = level.thrasherpustules;
        level.thrasherpustules = [];
        time = gettime();
        
        foreach ( pustule in pustules )
        {
            if ( pustule.endtime <= time )
            {
                if ( isdefined( pustule.fx ) )
                {
                    stopfx( pustule.localclientnum, pustule.fx );
                }
                
                continue;
            }
            
            level.thrasherpustules[ level.thrasherpustules.size ] = pustule;
        }
        
        wait 0.5;
    }
}

// Namespace thrasherclientutils
// Params 5
// Checksum 0x15b8197d, Offset: 0xc20
// Size: 0x24c
function thrasherprocessfootstep( localclientnum, pos, surface, notetrack, bone )
{
    e_player = getlocalplayer( localclientnum );
    n_dist = distancesquared( pos, e_player.origin );
    n_thrasher_dist = 1000000;
    
    if ( n_thrasher_dist <= 0 )
    {
        return;
    }
    
    n_scale = ( n_thrasher_dist - n_dist ) / n_thrasher_dist;
    
    if ( n_scale > 1 || n_scale < 0 || n_scale <= 0.01 )
    {
        return;
    }
    
    fx = playfxontag( localclientnum, level._effect[ "fx_mech_foot_step" ], self, bone );
    
    if ( isdefined( e_player.thrasherlastfootstep ) && e_player.thrasherlastfootstep + 400 > gettime() )
    {
        return;
    }
    
    earthquake_scale = n_scale * 0.1;
    
    if ( earthquake_scale > 0.01 )
    {
        e_player earthquake( earthquake_scale, 0.1, pos, n_dist );
    }
    
    if ( n_scale <= 1 && n_scale > 0.8 )
    {
        e_player playrumbleonentity( localclientnum, "damage_heavy" );
    }
    else if ( n_scale <= 0.8 && n_scale > 0.4 )
    {
        e_player playrumbleonentity( localclientnum, "reload_small" );
    }
    
    e_player.thrasherlastfootstep = gettime();
}

// Namespace thrasherclientutils
// Params 2, eflags: 0x4
// Checksum 0x83a90997, Offset: 0xe78
// Size: 0x3c
function private _stopfx( localclientnum, effect )
{
    if ( isdefined( effect ) )
    {
        stopfx( localclientnum, effect );
    }
}

// Namespace thrasherclientutils
// Params 7, eflags: 0x4
// Checksum 0xf7490221, Offset: 0xec0
// Size: 0x12c
function private thrasherhidefromplayer( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    entity = self;
    
    if ( !isdefined( entity ) || entity.archetype !== "thrasher" || !entity hasdobj( localclientnum ) )
    {
        return;
    }
    
    localplayer = getlocalplayer( localclientnum );
    localplayernum = localplayer getentitynumber();
    localplayerbit = 1 << localplayernum;
    
    if ( localplayerbit & newvalue )
    {
        entity hide();
        return;
    }
    
    entity show();
}

// Namespace thrasherclientutils
// Params 7, eflags: 0x4
// Checksum 0x13de531f, Offset: 0xff8
// Size: 0x302
function private thrasherberserkmode( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    entity = self;
    
    if ( !isdefined( entity ) || entity.archetype !== "thrasher" || !entity hasdobj( localclientnum ) )
    {
        return;
    }
    
    _stopfx( localclientnum, entity.thrashereyeglow );
    entity.thrashereyeglow = undefined;
    _stopfx( localclientnum, entity.thrasherambientfx1 );
    entity.thrasherambientfx1 = undefined;
    _stopfx( localclientnum, entity.thrasherambientfx2 );
    entity.thrasherambientfx2 = undefined;
    _stopfx( localclientnum, entity.thrasherambientfx3 );
    entity.thrasherambientfx3 = undefined;
    hashead = !gibclientutils::isgibbed( localclientnum, entity, 4 );
    
    switch ( newvalue )
    {
        case 0:
            if ( hashead )
            {
                entity.thrashereyeglow = playfxontag( localclientnum, level._effect[ "fx_thrash_eye_glow" ], entity, "j_eyeball_le" );
            }
            
            break;
        case 1:
            if ( hashead )
            {
                entity.thrashereyeglow = playfxontag( localclientnum, level._effect[ "fx_thrash_eye_glow_rage" ], entity, "j_eyeball_le" );
            }
            
            entity.thrasherambientfx1 = playfxontag( localclientnum, level._effect[ "fx_thrash_rage_gas_torso" ], entity, "j_spinelower" );
            entity.thrasherambientfx2 = playfxontag( localclientnum, level._effect[ "fx_thrash_rage_gas_leg_lft" ], entity, "j_hip_le" );
            entity.thrasherambientfx3 = playfxontag( localclientnum, level._effect[ "fx_thrash_rage_gas_leg_rgt" ], entity, "j_hip_ri" );
            break;
    }
}

// Namespace thrasherclientutils
// Params 7, eflags: 0x4
// Checksum 0xd3bb5bb1, Offset: 0x1308
// Size: 0x370
function private thrashersporeexplode( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    entity = self;
    sporeclientfields = array( 1, 2, 4 );
    sporetags = array( "tag_spore_chest", "tag_spore_back", "tag_spore_leg" );
    newsporesexploded = ( oldvalue ^ newvalue ) & ~oldvalue;
    oldsporesinflated = ( oldvalue ^ newvalue ) & ~newvalue;
    currentspore = sporeclientfields[ 0 ];
    
    for ( index = 0; index < array( "tag_spore_chest", "tag_spore_back", "tag_spore_leg" ).size ; index++ )
    {
        sporetag = sporetags[ index ];
        pustuleinfo = undefined;
        
        if ( newsporesexploded & currentspore )
        {
            playfxontag( localclientnum, level._effect[ "fx_thrash_pustule_burst" ], entity, sporetag );
            playfxontag( localclientnum, level._effect[ "fx_thrash_pustule_spore_exp" ], entity, sporetag );
            pustuleinfo = spawnstruct();
            pustuleinfo.length = 5000;
            
            if ( !( isdefined( level.b_thrasher_custom_spore_fx ) && level.b_thrasher_custom_spore_fx ) )
            {
                pustuleinfo.fx = playfx( localclientnum, level._effect[ "fx_spores_cloud_ambient_md" ], entity gettagorigin( sporetag ) );
            }
        }
        else if ( oldsporesinflated & currentspore )
        {
            pustuleinfo = spawnstruct();
            pustuleinfo.length = 2000;
            pustuleinfo.fx = playfxontag( localclientnum, level._effect[ "fx_thrash_pustule_reinflate" ], entity, sporetag );
        }
        
        if ( isdefined( pustuleinfo ) )
        {
            pustuleinfo.localclientnum = localclientnum;
            pustuleinfo.starttime = gettime();
            pustuleinfo.endtime = pustuleinfo.starttime + pustuleinfo.length;
            level.thrasherpustules[ level.thrasherpustules.size ] = pustuleinfo;
        }
        
        currentspore <<= 1;
    }
}

// Namespace thrasherclientutils
// Params 7, eflags: 0x4
// Checksum 0x6754384, Offset: 0x1680
// Size: 0x184
function private thrashersporeimpact( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    entity = self;
    sporetag = undefined;
    sporeclientfields = array( 1, 2, 4 );
    assert( sporeclientfields.size == array( "<dev string:x28>", "<dev string:x38>", "<dev string:x47>" ).size );
    
    for ( index = 0; index < sporeclientfields.size ; index++ )
    {
        if ( fieldname == "thrasher_spore_impact" + sporeclientfields[ index ] )
        {
            sporetag = array( "tag_spore_chest", "tag_spore_back", "tag_spore_leg" )[ index ];
            break;
        }
    }
    
    if ( isdefined( sporetag ) )
    {
        playfxontag( localclientnum, level._effect[ "fx_thrash_pustule_impact" ], entity, sporetag );
    }
}

// Namespace thrasherclientutils
// Params 3, eflags: 0x4
// Checksum 0xd48cd263, Offset: 0x1810
// Size: 0x92
function private thrasherdisableeyeglow( localclientnum, entity, gibflag )
{
    if ( !isdefined( entity ) || entity.archetype !== "thrasher" || !entity hasdobj( localclientnum ) )
    {
        return;
    }
    
    _stopfx( localclientnum, entity.thrashereyeglow );
    entity.thrashereyeglow = undefined;
}

// Namespace thrasherclientutils
// Params 7, eflags: 0x4
// Checksum 0x10d145c6, Offset: 0x18b0
// Size: 0x1dc
function private sndplayerconsumed( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    if ( newvalue )
    {
        if ( !isdefined( self.sndplayerconsumedid ) )
        {
            self.sndplayerconsumedid = self playloopsound( "zmb_thrasher_consumed_lp", 5 );
        }
        
        if ( !isdefined( self.n_fx_id_player_consumed ) )
        {
            self.n_fx_id_player_consumed = playfxoncamera( localclientnum, level._effect[ "fx_thrash_chest_mouth_drool" ] );
        }
        
        self thread postfx::playpostfxbundle( "pstfx_thrasher_stomach" );
        enablespeedblur( localclientnum, 0.07, 0.55, 0.9, 0, 100, 100 );
        return;
    }
    
    if ( isdefined( self.sndplayerconsumedid ) )
    {
        self stoploopsound( self.sndplayerconsumedid, 0.5 );
        self.sndplayerconsumedid = undefined;
    }
    
    if ( isdefined( self.n_fx_id_player_consumed ) )
    {
        stopfx( localclientnum, self.n_fx_id_player_consumed );
        self.n_fx_id_player_consumed = undefined;
    }
    
    self stopallloopsounds( 1 );
    
    if ( isdefined( self.playingpostfxbundle ) )
    {
        self thread postfx::stopplayingpostfxbundle();
    }
    
    disablespeedblur( localclientnum );
}

