#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/throttle_shared;

#namespace gib;

// Namespace gib
// Params 2, eflags: 0x4
// Checksum 0x42d702e7, Offset: 0x388
// Size: 0x5c, Type: bool
function private fields_equal( field_a, field_b )
{
    if ( !isdefined( field_a ) && !isdefined( field_b ) )
    {
        return true;
    }
    
    if ( isdefined( field_a ) && isdefined( field_b ) && field_a == field_b )
    {
        return true;
    }
    
    return false;
}

// Namespace gib
// Params 2, eflags: 0x4
// Checksum 0xe3e8b332, Offset: 0x3f0
// Size: 0x136, Type: bool
function private _isdefaultplayergib( gibpieceflag, gibstruct )
{
    if ( !fields_equal( level.playergibbundle.gibs[ gibpieceflag ].gibdynentfx, gibstruct.gibdynentfx ) )
    {
        return false;
    }
    
    if ( !fields_equal( level.playergibbundle.gibs[ gibpieceflag ].gibfxtag, gibstruct.gibfxtag ) )
    {
        return false;
    }
    
    if ( !fields_equal( level.playergibbundle.gibs[ gibpieceflag ].gibfx, gibstruct.gibfx ) )
    {
        return false;
    }
    
    if ( !fields_equal( level.playergibbundle.gibs[ gibpieceflag ].gibtag, gibstruct.gibtag ) )
    {
        return false;
    }
    
    return true;
}

// Namespace gib
// Params 0, eflags: 0x2
// Checksum 0x2643ffa5, Offset: 0x530
// Size: 0x9b0
function autoexec main()
{
    clientfield::register( "actor", "gib_state", 1, 9, "int" );
    clientfield::register( "playercorpse", "gib_state", 1, 15, "int" );
    gibdefinitions = struct::get_script_bundles( "gibcharacterdef" );
    gibpiecelookup = [];
    gibpiecelookup[ 2 ] = "annihilate";
    gibpiecelookup[ 8 ] = "head";
    gibpiecelookup[ 16 ] = "rightarm";
    gibpiecelookup[ 32 ] = "leftarm";
    gibpiecelookup[ 128 ] = "rightleg";
    gibpiecelookup[ 256 ] = "leftleg";
    processedbundles = [];
    
    if ( sessionmodeismultiplayergame() )
    {
        level.playergibbundle = spawnstruct();
        level.playergibbundle.gibs = [];
        level.playergibbundle.name = "default_player";
        level.playergibbundle.gibs[ 2 ] = spawnstruct();
        level.playergibbundle.gibs[ 8 ] = spawnstruct();
        level.playergibbundle.gibs[ 32 ] = spawnstruct();
        level.playergibbundle.gibs[ 256 ] = spawnstruct();
        level.playergibbundle.gibs[ 16 ] = spawnstruct();
        level.playergibbundle.gibs[ 128 ] = spawnstruct();
        level.playergibbundle.gibs[ 2 ].gibfxtag = "j_spinelower";
        level.playergibbundle.gibs[ 2 ].gibfx = "blood/fx_blood_impact_exp_body_lg";
        level.playergibbundle.gibs[ 32 ].gibmodel = "c_t7_mp_battery_mpc_body1_s_larm";
        level.playergibbundle.gibs[ 32 ].gibdynentfx = "blood/fx_blood_gib_limb_trail_emitter";
        level.playergibbundle.gibs[ 32 ].gibfxtag = "j_elbow_le";
        level.playergibbundle.gibs[ 32 ].gibfx = "blood/fx_blood_gib_arm_sever_burst";
        level.playergibbundle.gibs[ 32 ].gibtag = "j_elbow_le";
        level.playergibbundle.gibs[ 256 ].gibmodel = "c_t7_mp_battery_mpc_body1_s_lleg";
        level.playergibbundle.gibs[ 256 ].gibdynentfx = "blood/fx_blood_gib_limb_trail_emitter";
        level.playergibbundle.gibs[ 256 ].gibfxtag = "j_knee_le";
        level.playergibbundle.gibs[ 256 ].gibfx = "blood/fx_blood_gib_leg_sever_burst";
        level.playergibbundle.gibs[ 256 ].gibtag = "j_knee_le";
        level.playergibbundle.gibs[ 16 ].gibmodel = "c_t7_mp_battery_mpc_body1_s_rarm";
        level.playergibbundle.gibs[ 16 ].gibdynentfx = "blood/fx_blood_gib_limb_trail_emitter";
        level.playergibbundle.gibs[ 16 ].gibfxtag = "j_elbow_ri";
        level.playergibbundle.gibs[ 16 ].gibfx = "blood/fx_blood_gib_arm_sever_burst_rt";
        level.playergibbundle.gibs[ 16 ].gibtag = "j_elbow_ri";
        level.playergibbundle.gibs[ 128 ].gibmodel = "c_t7_mp_battery_mpc_body1_s_rleg";
        level.playergibbundle.gibs[ 128 ].gibdynentfx = "blood/fx_blood_gib_limb_trail_emitter";
        level.playergibbundle.gibs[ 128 ].gibfxtag = "j_knee_ri";
        level.playergibbundle.gibs[ 128 ].gibfx = "blood/fx_blood_gib_leg_sever_burst_rt";
        level.playergibbundle.gibs[ 128 ].gibtag = "j_knee_ri";
    }
    
    foreach ( definitionname, definition in gibdefinitions )
    {
        gibbundle = spawnstruct();
        gibbundle.gibs = [];
        gibbundle.name = definitionname;
        default_player = 0;
        
        foreach ( gibpieceflag, gibpiecename in gibpiecelookup )
        {
            gibstruct = spawnstruct();
            gibstruct.gibmodel = getstructfield( definition, gibpiecelookup[ gibpieceflag ] + "_gibmodel" );
            gibstruct.gibtag = getstructfield( definition, gibpiecelookup[ gibpieceflag ] + "_gibtag" );
            gibstruct.gibfx = getstructfield( definition, gibpiecelookup[ gibpieceflag ] + "_gibfx" );
            gibstruct.gibfxtag = getstructfield( definition, gibpiecelookup[ gibpieceflag ] + "_gibeffecttag" );
            gibstruct.gibdynentfx = getstructfield( definition, gibpiecelookup[ gibpieceflag ] + "_gibdynentfx" );
            gibstruct.gibsound = getstructfield( definition, gibpiecelookup[ gibpieceflag ] + "_gibsound" );
            gibstruct.gibhidetag = getstructfield( definition, gibpiecelookup[ gibpieceflag ] + "_gibhidetag" );
            
            if ( sessionmodeismultiplayergame() && _isdefaultplayergib( gibpieceflag, gibstruct ) )
            {
                default_player = 1;
            }
            
            gibbundle.gibs[ gibpieceflag ] = gibstruct;
        }
        
        if ( sessionmodeismultiplayergame() && default_player )
        {
            processedbundles[ definitionname ] = level.playergibbundle;
            continue;
        }
        
        processedbundles[ definitionname ] = gibbundle;
    }
    
    level.scriptbundles[ "gibcharacterdef" ] = processedbundles;
    
    if ( !isdefined( level.gib_throttle ) )
    {
        level.gib_throttle = new throttle();
        [[ level.gib_throttle ]]->initialize( 2, 0.2 );
    }
}

#namespace gibserverutils;

// Namespace gibserverutils
// Params 1, eflags: 0x4
// Checksum 0x5dbfca45, Offset: 0xee8
// Size: 0x2c
function private _annihilate( entity )
{
    if ( isdefined( entity ) )
    {
        entity notsolid();
    }
}

// Namespace gibserverutils
// Params 2, eflags: 0x4
// Checksum 0x479c7b20, Offset: 0xf20
// Size: 0xcc
function private _getgibextramodel( entity, gibflag )
{
    if ( gibflag == 4 )
    {
        return ( isdefined( entity.gib_data ) ? entity.gib_data.hatmodel : entity.hatmodel );
    }
    
    if ( gibflag == 8 )
    {
        return ( isdefined( entity.gib_data ) ? entity.gib_data.head : entity.head );
    }
    
    assertmsg( "<dev string:x28>" );
}

// Namespace gibserverutils
// Params 2, eflags: 0x4
// Checksum 0xa2f9d2fe, Offset: 0xff8
// Size: 0x78, Type: bool
function private _gibextra( entity, gibflag )
{
    if ( isgibbed( entity, gibflag ) )
    {
        return false;
    }
    
    if ( !_hasgibdef( entity ) )
    {
        return false;
    }
    
    entity thread _gibextrainternal( entity, gibflag );
    return true;
}

// Namespace gibserverutils
// Params 2, eflags: 0x4
// Checksum 0xdaa335d6, Offset: 0x1078
// Size: 0x1f4
function private _gibextrainternal( entity, gibflag )
{
    if ( entity.gib_time !== gettime() )
    {
        [[ level.gib_throttle ]]->waitinqueue( entity );
    }
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    entity.gib_time = gettime();
    
    if ( isgibbed( entity, gibflag ) )
    {
        return 0;
    }
    
    if ( gibflag == 8 )
    {
        if ( isdefined( isdefined( entity.gib_data ) ? entity.gib_data.torsodmg5 : entity.torsodmg5 ) )
        {
            entity attach( isdefined( entity.gib_data ) ? entity.gib_data.torsodmg5 : entity.torsodmg5, "", 1 );
        }
    }
    
    _setgibbed( entity, gibflag, undefined );
    destructserverutils::showdestructedpieces( entity );
    showhiddengibpieces( entity );
    gibmodel = _getgibextramodel( entity, gibflag );
    
    if ( isdefined( gibmodel ) )
    {
        entity detach( gibmodel, "" );
    }
    
    destructserverutils::reapplydestructedpieces( entity );
    reapplyhiddengibpieces( entity );
}

// Namespace gibserverutils
// Params 2, eflags: 0x4
// Checksum 0x52fd8a3f, Offset: 0x1278
// Size: 0x98, Type: bool
function private _gibentity( entity, gibflag )
{
    if ( isgibbed( entity, gibflag ) || !_hasgibpieces( entity, gibflag ) )
    {
        return false;
    }
    
    if ( !_hasgibdef( entity ) )
    {
        return false;
    }
    
    entity thread _gibentityinternal( entity, gibflag );
    return true;
}

// Namespace gibserverutils
// Params 2, eflags: 0x4
// Checksum 0xdbe849ce, Offset: 0x1318
// Size: 0x1a4
function private _gibentityinternal( entity, gibflag )
{
    if ( entity.gib_time !== gettime() )
    {
        [[ level.gib_throttle ]]->waitinqueue( entity );
    }
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    entity.gib_time = gettime();
    
    if ( isgibbed( entity, gibflag ) )
    {
        return;
    }
    
    destructserverutils::showdestructedpieces( entity );
    showhiddengibpieces( entity );
    
    if ( !( _getgibbedstate( entity ) < 16 ) )
    {
        legmodel = _getgibbedlegmodel( entity );
        entity detach( legmodel );
    }
    
    _setgibbed( entity, gibflag, undefined );
    entity setmodel( _getgibbedtorsomodel( entity ) );
    entity attach( _getgibbedlegmodel( entity ) );
    destructserverutils::reapplydestructedpieces( entity );
    reapplyhiddengibpieces( entity );
}

// Namespace gibserverutils
// Params 1, eflags: 0x4
// Checksum 0xb30d77f3, Offset: 0x14c8
// Size: 0x176
function private _getgibbedlegmodel( entity )
{
    gibstate = _getgibbedstate( entity );
    rightleggibbed = gibstate & 128;
    leftleggibbed = gibstate & 256;
    
    if ( rightleggibbed && leftleggibbed )
    {
        return ( isdefined( entity.gib_data ) ? entity.gib_data.legdmg4 : entity.legdmg4 );
    }
    else if ( rightleggibbed )
    {
        return ( isdefined( entity.gib_data ) ? entity.gib_data.legdmg2 : entity.legdmg2 );
    }
    else if ( leftleggibbed )
    {
        return ( isdefined( entity.gib_data ) ? entity.gib_data.legdmg3 : entity.legdmg3 );
    }
    
    return isdefined( entity.gib_data ) ? entity.gib_data.legdmg1 : entity.legdmg1;
}

// Namespace gibserverutils
// Params 1, eflags: 0x4
// Checksum 0xb55c6c41, Offset: 0x1648
// Size: 0x32
function private _getgibbedstate( entity )
{
    if ( isdefined( entity.gib_state ) )
    {
        return entity.gib_state;
    }
    
    return 0;
}

// Namespace gibserverutils
// Params 1, eflags: 0x4
// Checksum 0xb5a41075, Offset: 0x1688
// Size: 0x176
function private _getgibbedtorsomodel( entity )
{
    gibstate = _getgibbedstate( entity );
    rightarmgibbed = gibstate & 16;
    leftarmgibbed = gibstate & 32;
    
    if ( rightarmgibbed && leftarmgibbed )
    {
        return ( isdefined( entity.gib_data ) ? entity.gib_data.torsodmg2 : entity.torsodmg2 );
    }
    else if ( rightarmgibbed )
    {
        return ( isdefined( entity.gib_data ) ? entity.gib_data.torsodmg2 : entity.torsodmg2 );
    }
    else if ( leftarmgibbed )
    {
        return ( isdefined( entity.gib_data ) ? entity.gib_data.torsodmg3 : entity.torsodmg3 );
    }
    
    return isdefined( entity.gib_data ) ? entity.gib_data.torsodmg1 : entity.torsodmg1;
}

// Namespace gibserverutils
// Params 1, eflags: 0x4
// Checksum 0x157917ad, Offset: 0x1808
// Size: 0x1c, Type: bool
function private _hasgibdef( entity )
{
    return isdefined( entity.gibdef );
}

// Namespace gibserverutils
// Params 2, eflags: 0x4
// Checksum 0xb07614ef, Offset: 0x1830
// Size: 0xc0
function private _hasgibpieces( entity, gibflag )
{
    hasgibpieces = 0;
    gibstate = _getgibbedstate( entity );
    entity.gib_state = gibstate | gibflag & 512 - 1;
    
    if ( isdefined( _getgibbedtorsomodel( entity ) ) && isdefined( _getgibbedlegmodel( entity ) ) )
    {
        hasgibpieces = 1;
    }
    
    entity.gib_state = gibstate;
    return hasgibpieces;
}

// Namespace gibserverutils
// Params 3, eflags: 0x4
// Checksum 0x7df5d939, Offset: 0x18f8
// Size: 0x144
function private _setgibbed( entity, gibflag, gibdir )
{
    if ( isdefined( gibdir ) )
    {
        angles = vectortoangles( gibdir );
        yaw = angles[ 1 ];
        yaw_bits = getbitsforangle( yaw, 3 );
        entity.gib_state = ( _getgibbedstate( entity ) | gibflag & 512 - 1 ) + ( yaw_bits << 9 );
    }
    else
    {
        entity.gib_state = _getgibbedstate( entity ) | gibflag & 512 - 1;
    }
    
    entity.gibbed = 1;
    entity clientfield::set( "gib_state", entity.gib_state );
}

// Namespace gibserverutils
// Params 1
// Checksum 0x276243b5, Offset: 0x1a48
// Size: 0x104, Type: bool
function annihilate( entity )
{
    if ( !_hasgibdef( entity ) )
    {
        return false;
    }
    
    gibbundle = struct::get_script_bundle( "gibcharacterdef", entity.gibdef );
    
    if ( !isdefined( gibbundle ) || !isdefined( gibbundle.gibs ) )
    {
        return false;
    }
    
    gibpiecestruct = gibbundle.gibs[ 2 ];
    
    if ( isdefined( gibpiecestruct ) )
    {
        if ( isdefined( gibpiecestruct.gibfx ) )
        {
            _setgibbed( entity, 2, undefined );
            entity thread _annihilate( entity );
            return true;
        }
    }
    
    return false;
}

// Namespace gibserverutils
// Params 2
// Checksum 0xfcad44a4, Offset: 0x1b58
// Size: 0x6c
function copygibstate( originalentity, newentity )
{
    newentity.gib_state = _getgibbedstate( originalentity );
    togglespawngibs( newentity, 0 );
    reapplyhiddengibpieces( newentity );
}

// Namespace gibserverutils
// Params 2
// Checksum 0x80d566bf, Offset: 0x1bd0
// Size: 0x30
function isgibbed( entity, gibflag )
{
    return _getgibbedstate( entity ) & gibflag;
}

// Namespace gibserverutils
// Params 1
// Checksum 0x17f2938b, Offset: 0x1c08
// Size: 0x22, Type: bool
function gibhat( entity )
{
    return _gibextra( entity, 4 );
}

// Namespace gibserverutils
// Params 1
// Checksum 0xe759e19a, Offset: 0x1c38
// Size: 0x3a, Type: bool
function gibhead( entity )
{
    gibhat( entity );
    return _gibextra( entity, 8 );
}

// Namespace gibserverutils
// Params 1
// Checksum 0x17f592c0, Offset: 0x1c80
// Size: 0x64, Type: bool
function gibleftarm( entity )
{
    if ( isgibbed( entity, 16 ) )
    {
        return false;
    }
    
    if ( _gibentity( entity, 32 ) )
    {
        destructserverutils::destructleftarmpieces( entity );
        return true;
    }
    
    return false;
}

// Namespace gibserverutils
// Params 1
// Checksum 0x8f925700, Offset: 0x1cf0
// Size: 0x7c, Type: bool
function gibrightarm( entity )
{
    if ( isgibbed( entity, 32 ) )
    {
        return false;
    }
    
    if ( _gibentity( entity, 16 ) )
    {
        destructserverutils::destructrightarmpieces( entity );
        entity thread shared::dropaiweapon();
        return true;
    }
    
    return false;
}

// Namespace gibserverutils
// Params 1
// Checksum 0xf18cc13b, Offset: 0x1d78
// Size: 0x44, Type: bool
function gibleftleg( entity )
{
    if ( _gibentity( entity, 256 ) )
    {
        destructserverutils::destructleftlegpieces( entity );
        return true;
    }
    
    return false;
}

// Namespace gibserverutils
// Params 1
// Checksum 0x7c71d188, Offset: 0x1dc8
// Size: 0x44, Type: bool
function gibrightleg( entity )
{
    if ( _gibentity( entity, 128 ) )
    {
        destructserverutils::destructrightlegpieces( entity );
        return true;
    }
    
    return false;
}

// Namespace gibserverutils
// Params 1
// Checksum 0x725869fa, Offset: 0x1e18
// Size: 0x5c, Type: bool
function giblegs( entity )
{
    if ( _gibentity( entity, 384 ) )
    {
        destructserverutils::destructrightlegpieces( entity );
        destructserverutils::destructleftlegpieces( entity );
        return true;
    }
    
    return false;
}

// Namespace gibserverutils
// Params 1
// Checksum 0x5846b8fd, Offset: 0x1e80
// Size: 0x5c
function playergibleftarm( entity )
{
    if ( isdefined( entity.body ) )
    {
        dir = ( 1, 0, 0 );
        _setgibbed( entity.body, 32, dir );
    }
}

// Namespace gibserverutils
// Params 1
// Checksum 0x59a20878, Offset: 0x1ee8
// Size: 0x5c
function playergibrightarm( entity )
{
    if ( isdefined( entity.body ) )
    {
        dir = ( 1, 0, 0 );
        _setgibbed( entity.body, 16, dir );
    }
}

// Namespace gibserverutils
// Params 1
// Checksum 0x478edfe7, Offset: 0x1f50
// Size: 0x5c
function playergibleftleg( entity )
{
    if ( isdefined( entity.body ) )
    {
        dir = ( 1, 0, 0 );
        _setgibbed( entity.body, 256, dir );
    }
}

// Namespace gibserverutils
// Params 1
// Checksum 0x669f5cc8, Offset: 0x1fb8
// Size: 0x5c
function playergibrightleg( entity )
{
    if ( isdefined( entity.body ) )
    {
        dir = ( 1, 0, 0 );
        _setgibbed( entity.body, 128, dir );
    }
}

// Namespace gibserverutils
// Params 1
// Checksum 0x251702ab, Offset: 0x2020
// Size: 0x84
function playergiblegs( entity )
{
    if ( isdefined( entity.body ) )
    {
        dir = ( 1, 0, 0 );
        _setgibbed( entity.body, 128, dir );
        _setgibbed( entity.body, 256, dir );
    }
}

// Namespace gibserverutils
// Params 2
// Checksum 0x3e16a791, Offset: 0x20b0
// Size: 0x4c
function playergibleftarmvel( entity, dir )
{
    if ( isdefined( entity.body ) )
    {
        _setgibbed( entity.body, 32, dir );
    }
}

// Namespace gibserverutils
// Params 2
// Checksum 0x3a735dd7, Offset: 0x2108
// Size: 0x4c
function playergibrightarmvel( entity, dir )
{
    if ( isdefined( entity.body ) )
    {
        _setgibbed( entity.body, 16, dir );
    }
}

// Namespace gibserverutils
// Params 2
// Checksum 0xc4da859b, Offset: 0x2160
// Size: 0x4c
function playergibleftlegvel( entity, dir )
{
    if ( isdefined( entity.body ) )
    {
        _setgibbed( entity.body, 256, dir );
    }
}

// Namespace gibserverutils
// Params 2
// Checksum 0xbcf2edc, Offset: 0x21b8
// Size: 0x4c
function playergibrightlegvel( entity, dir )
{
    if ( isdefined( entity.body ) )
    {
        _setgibbed( entity.body, 128, dir );
    }
}

// Namespace gibserverutils
// Params 2
// Checksum 0x4c1adf1c, Offset: 0x2210
// Size: 0x74
function playergiblegsvel( entity, dir )
{
    if ( isdefined( entity.body ) )
    {
        _setgibbed( entity.body, 128, dir );
        _setgibbed( entity.body, 256, dir );
    }
}

// Namespace gibserverutils
// Params 1
// Checksum 0xa1208547, Offset: 0x2290
// Size: 0x192
function reapplyhiddengibpieces( entity )
{
    if ( !_hasgibdef( entity ) )
    {
        return;
    }
    
    gibbundle = struct::get_script_bundle( "gibcharacterdef", entity.gibdef );
    
    foreach ( gibflag, gib in gibbundle.gibs )
    {
        if ( !isgibbed( entity, gibflag ) )
        {
            continue;
        }
        
        if ( isdefined( gib.gibhidetag ) && isalive( entity ) && entity haspart( gib.gibhidetag ) )
        {
            if ( !( isdefined( entity.skipdeath ) && entity.skipdeath ) )
            {
                entity hidepart( gib.gibhidetag, "", 1 );
            }
        }
    }
}

// Namespace gibserverutils
// Params 1
// Checksum 0x42c66b39, Offset: 0x2430
// Size: 0x132
function showhiddengibpieces( entity )
{
    if ( !_hasgibdef( entity ) )
    {
        return;
    }
    
    gibbundle = struct::get_script_bundle( "gibcharacterdef", entity.gibdef );
    
    foreach ( gib in gibbundle.gibs )
    {
        if ( isdefined( gib.gibhidetag ) && entity haspart( gib.gibhidetag ) )
        {
            entity showpart( gib.gibhidetag, "", 1 );
        }
    }
}

// Namespace gibserverutils
// Params 2
// Checksum 0xada9f41d, Offset: 0x2570
// Size: 0xa4
function togglespawngibs( entity, shouldspawngibs )
{
    if ( !shouldspawngibs )
    {
        entity.gib_state = _getgibbedstate( entity ) | 1;
    }
    else
    {
        entity.gib_state = _getgibbedstate( entity ) & -2;
    }
    
    entity clientfield::set( "gib_state", entity.gib_state );
}

