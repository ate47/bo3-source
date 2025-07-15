#using scripts/codescripts/struct;
#using scripts/mp/_teamops;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/killstreaks/_ai_tank;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_combat_robot;
#using scripts/mp/killstreaks/_counteruav;
#using scripts/mp/killstreaks/_dart;
#using scripts/mp/killstreaks/_dogs;
#using scripts/mp/killstreaks/_drone_strike;
#using scripts/mp/killstreaks/_emp;
#using scripts/mp/killstreaks/_flak_drone;
#using scripts/mp/killstreaks/_helicopter;
#using scripts/mp/killstreaks/_helicopter_gunner;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_microwave_turret;
#using scripts/mp/killstreaks/_planemortar;
#using scripts/mp/killstreaks/_qrdrone;
#using scripts/mp/killstreaks/_raps;
#using scripts/mp/killstreaks/_rcbomb;
#using scripts/mp/killstreaks/_remote_weapons;
#using scripts/mp/killstreaks/_remotemissile;
#using scripts/mp/killstreaks/_satellite;
#using scripts/mp/killstreaks/_sentinel;
#using scripts/mp/killstreaks/_supplydrop;
#using scripts/mp/killstreaks/_turret;
#using scripts/mp/killstreaks/_uav;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;

#namespace killstreaks;

// Namespace killstreaks
// Params 0, eflags: 0x2
// Checksum 0x8d6e873c, Offset: 0xf58
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "killstreaks", &__init__, undefined, undefined );
}

// Namespace killstreaks
// Params 0
// Checksum 0x5e4fb868, Offset: 0xf98
// Size: 0x84
function __init__()
{
    level.killstreaks = [];
    level.killstreakweapons = [];
    level.droplocations = [];
    level.zoffsetcounter = 0;
    clientfield::register( "vehicle", "timeout_beep", 1, 2, "int" );
    callback::on_start_gametype( &init );
}

// Namespace killstreaks
// Params 0
// Checksum 0xef482d96, Offset: 0x1028
// Size: 0x3bc
function init()
{
    /#
        level.killstreak_init_start_time = getmillisecondsraw();
        thread debug_ricochet_protection();
    #/
    
    if ( getdvarstring( "scr_allow_killstreak_building" ) == "" )
    {
        setdvar( "scr_allow_killstreak_building", "0" );
    }
    
    level.menureferenceforkillstreak = [];
    level.numkillstreakreservedobjectives = 0;
    level.killstreakcounter = 0;
    level.play_killstreak_firewall_being_hacked_dialog = &play_killstreak_firewall_being_hacked_dialog;
    level.play_killstreak_firewall_hacked_dialog = &play_killstreak_firewall_hacked_dialog;
    level.play_killstreak_being_hacked_dialog = &play_killstreak_being_hacked_dialog;
    level.play_killstreak_hacked_dialog = &play_killstreak_hacked_dialog;
    
    if ( !isdefined( level.roundstartkillstreakdelay ) )
    {
        level.roundstartkillstreakdelay = 0;
    }
    
    level.iskillstreakweapon = &is_killstreak_weapon;
    level.killstreakcorebundle = struct::get_script_bundle( "killstreak", "killstreak_core" );
    remote_weapons::init();
    ai_tank::init();
    airsupport::init();
    combat_robot::init();
    counteruav::init();
    dart::init();
    drone_strike::init();
    emp::init();
    flak_drone::init();
    helicopter::init();
    helicopter_gunner::init();
    killstreakrules::init();
    microwave_turret::init();
    planemortar::init();
    qrdrone::init();
    raps_mp::init();
    rcbomb::init();
    remotemissile::init();
    satellite::init();
    sentinel::init();
    turret::init();
    uav::init();
    supplydrop::init();
    
    /#
        level.killstreak_init_end_time = getmillisecondsraw();
        elapsed_time = level.killstreak_init_end_time - level.killstreak_init_start_time;
        println( "<dev string:x28>" + elapsed_time + "<dev string:x46>" );
    #/
    
    callback::on_spawned( &on_player_spawned );
    callback::on_joined_team( &on_joined_team );
    
    /#
        level thread killstreak_debug_think();
    #/
    
    if ( getdvarint( "teamOpsEnabled" ) == 1 )
    {
        level teamops::main();
    }
}

// Namespace killstreaks
// Params 10
// Checksum 0x2f5d60f6, Offset: 0x13f0
// Size: 0x584
function register( killstreaktype, killstreakweaponname, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed, killstreakstatsname, registerdvars, registerinventory )
{
    if ( !isdefined( weaponholdallowed ) )
    {
        weaponholdallowed = 0;
    }
    
    if ( !isdefined( killstreakstatsname ) )
    {
        killstreakstatsname = undefined;
    }
    
    if ( !isdefined( registerdvars ) )
    {
        registerdvars = 1;
    }
    
    if ( !isdefined( registerinventory ) )
    {
        registerinventory = 1;
    }
    
    assert( isdefined( killstreaktype ), "<dev string:x4a>" );
    assert( !isdefined( level.killstreaks[ killstreaktype ] ), "<dev string:x83>" + killstreaktype + "<dev string:x8f>" );
    assert( isdefined( killstreakusefunction ), "<dev string:xa3>" + killstreaktype );
    level.killstreaks[ killstreaktype ] = spawnstruct();
    statstablename = util::getstatstablename();
    level.killstreaks[ killstreaktype ].killstreaklevel = int( tablelookup( statstablename, 4, killstreakmenuname, 5 ) );
    level.killstreaks[ killstreaktype ].momentumcost = int( tablelookup( statstablename, 4, killstreakmenuname, 16 ) );
    level.killstreaks[ killstreaktype ].iconmaterial = tablelookup( statstablename, 4, killstreakmenuname, 6 );
    level.killstreaks[ killstreaktype ].quantity = int( tablelookup( statstablename, 4, killstreakmenuname, 5 ) );
    level.killstreaks[ killstreaktype ].usagekey = killstreakusagekey;
    level.killstreaks[ killstreaktype ].usefunction = killstreakusefunction;
    level.killstreaks[ killstreaktype ].menuname = killstreakmenuname;
    level.killstreaks[ killstreaktype ].delaystreak = killstreakdelaystreak;
    level.killstreaks[ killstreaktype ].allowassists = 0;
    level.killstreaks[ killstreaktype ].overrideentitycameraindemo = 0;
    level.killstreaks[ killstreaktype ].teamkillpenaltyscale = 1;
    
    /#
        level.killstreaks[ killstreaktype ].uiname = tablelookup( statstablename, 4, killstreakmenuname, 3 );
        
        if ( level.killstreaks[ killstreaktype ].uiname == "<dev string:xcb>" )
        {
            level.killstreaks[ killstreaktype ].uiname = killstreakmenuname;
        }
    #/
    
    if ( isdefined( killstreakweaponname ) )
    {
        killstreakweapon = getweapon( killstreakweaponname );
        assert( killstreakweapon != level.weaponnone );
        assert( !isdefined( level.killstreakweapons[ killstreakweapon ] ), "<dev string:xcc>" );
        level.killstreaks[ killstreaktype ].weapon = killstreakweapon;
        level.killstreakweapons[ killstreakweapon ] = killstreaktype;
    }
    
    if ( isdefined( killstreakstatsname ) )
    {
        level.killstreaks[ killstreaktype ].killstreakstatsname = killstreakstatsname;
    }
    
    level.killstreaks[ killstreaktype ].weaponholdallowed = weaponholdallowed;
    
    if ( isdefined( registerinventory ) && registerinventory )
    {
        level.menureferenceforkillstreak[ killstreakmenuname ] = killstreaktype;
        killstreak_bundles::register_killstreak_bundle( killstreaktype );
    }
    
    if ( isdefined( registerinventory ) && registerinventory )
    {
        if ( isdefined( registerdvars ) && registerdvars )
        {
            register_dev_dvars( killstreaktype );
        }
        
        register( "inventory_" + killstreaktype, "inventory_" + killstreakweaponname, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed, killstreakstatsname, registerdvars, 0 );
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x2bd66a8f, Offset: 0x1980
// Size: 0x1a, Type: bool
function is_registered( killstreaktype )
{
    return isdefined( level.killstreaks[ killstreaktype ] );
}

// Namespace killstreaks
// Params 8
// Checksum 0x6e45a90f, Offset: 0x19a8
// Size: 0x1b4
function register_strings( killstreaktype, receivedtext, notusabletext, inboundtext, inboundnearplayertext, hackedtext, utilizesairspace, isinventory )
{
    if ( !isdefined( utilizesairspace ) )
    {
        utilizesairspace = 1;
    }
    
    if ( !isdefined( isinventory ) )
    {
        isinventory = 0;
    }
    
    assert( isdefined( killstreaktype ), "<dev string:x4a>" );
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "<dev string:x108>" );
    level.killstreaks[ killstreaktype ].receivedtext = receivedtext;
    level.killstreaks[ killstreaktype ].notavailabletext = notusabletext;
    level.killstreaks[ killstreaktype ].inboundtext = inboundtext;
    level.killstreaks[ killstreaktype ].inboundnearplayertext = inboundnearplayertext;
    level.killstreaks[ killstreaktype ].hackedtext = hackedtext;
    level.killstreaks[ killstreaktype ].utilizesairspace = utilizesairspace;
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        register_strings( "inventory_" + killstreaktype, receivedtext, notusabletext, inboundtext, inboundnearplayertext, hackedtext, utilizesairspace, 1 );
    }
}

// Namespace killstreaks
// Params 12
// Checksum 0x9f62f508, Offset: 0x1b68
// Size: 0x3a4
function register_dialog( killstreaktype, informdialog, taacomdialogbundlekey, pilotdialogarraykey, startdialogkey, enemystartdialogkey, enemystartmultipledialogkey, hackeddialogkey, hackedstartdialogkey, requestdialogkey, threatdialogkey, isinventory )
{
    assert( isdefined( killstreaktype ), "<dev string:x4a>" );
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "<dev string:x14b>" );
    level.killstreaks[ killstreaktype ].informdialog = informdialog;
    level.killstreaks[ killstreaktype ].taacomdialogbundlekey = taacomdialogbundlekey;
    level.killstreaks[ killstreaktype ].startdialogkey = startdialogkey;
    level.killstreaks[ killstreaktype ].enemystartdialogkey = enemystartdialogkey;
    level.killstreaks[ killstreaktype ].enemystartmultipledialogkey = enemystartmultipledialogkey;
    level.killstreaks[ killstreaktype ].hackeddialogkey = hackeddialogkey;
    level.killstreaks[ killstreaktype ].hackedstartdialogkey = hackedstartdialogkey;
    level.killstreaks[ killstreaktype ].requestdialogkey = requestdialogkey;
    level.killstreaks[ killstreaktype ].threatdialogkey = threatdialogkey;
    
    if ( isdefined( pilotdialogarraykey ) )
    {
        taacombundles = struct::get_script_bundles( "mpdialog_taacom" );
        
        foreach ( bundle in taacombundles )
        {
            if ( !isdefined( bundle.pilotbundles ) )
            {
                bundle.pilotbundles = [];
            }
            
            bundle.pilotbundles[ killstreaktype ] = [];
            i = 0;
            field = pilotdialogarraykey + i;
            
            for ( fieldvalue = getstructfield( bundle, field ); isdefined( fieldvalue ) ; fieldvalue = getstructfield( bundle, field ) )
            {
                bundle.pilotbundles[ killstreaktype ][ i ] = fieldvalue;
                i++;
                field = pilotdialogarraykey + i;
            }
        }
    }
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        register_dialog( "inventory_" + killstreaktype, informdialog, taacomdialogbundlekey, pilotdialogarraykey, startdialogkey, enemystartdialogkey, enemystartmultipledialogkey, hackeddialogkey, hackedstartdialogkey, requestdialogkey, threatdialogkey, 1 );
    }
}

// Namespace killstreaks
// Params 3
// Checksum 0xd8b605cb, Offset: 0x1f18
// Size: 0x1a4
function register_alt_weapon( killstreaktype, weaponname, isinventory )
{
    assert( isdefined( killstreaktype ), "<dev string:x4a>" );
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "<dev string:x18d>" );
    weapon = getweapon( weaponname );
    
    if ( weapon == level.weaponnone )
    {
        return;
    }
    
    if ( level.killstreaks[ killstreaktype ].weapon == weapon )
    {
        return;
    }
    
    if ( !isdefined( level.killstreaks[ killstreaktype ].altweapons ) )
    {
        level.killstreaks[ killstreaktype ].altweapons = [];
    }
    
    if ( !isdefined( level.killstreakweapons[ weapon ] ) )
    {
        level.killstreakweapons[ weapon ] = killstreaktype;
    }
    
    level.killstreaks[ killstreaktype ].altweapons[ level.killstreaks[ killstreaktype ].altweapons.size ] = weapon;
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        register_alt_weapon( "inventory_" + killstreaktype, weaponname, 1 );
    }
}

// Namespace killstreaks
// Params 3
// Checksum 0x1eaf05a5, Offset: 0x20c8
// Size: 0x18c
function register_remote_override_weapon( killstreaktype, weaponname, isinventory )
{
    assert( isdefined( killstreaktype ), "<dev string:x4a>" );
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "<dev string:x1d3>" );
    weapon = getweapon( weaponname );
    
    if ( level.killstreaks[ killstreaktype ].weapon == weapon )
    {
        return;
    }
    
    if ( !isdefined( level.killstreaks[ killstreaktype ].remoteoverrideweapons ) )
    {
        level.killstreaks[ killstreaktype ].remoteoverrideweapons = [];
    }
    
    if ( !isdefined( level.killstreakweapons[ weapon ] ) )
    {
        level.killstreakweapons[ weapon ] = killstreaktype;
    }
    
    level.killstreaks[ killstreaktype ].remoteoverrideweapons[ level.killstreaks[ killstreaktype ].remoteoverrideweapons.size ] = weapon;
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        register_remote_override_weapon( "inventory_" + killstreaktype, weaponname, 1 );
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x25d3e0fa, Offset: 0x2260
// Size: 0x9c, Type: bool
function is_remote_override_weapon( killstreaktype, weapon )
{
    if ( isdefined( level.killstreaks[ killstreaktype ].remoteoverrideweapons ) )
    {
        for ( i = 0; i < level.killstreaks[ killstreaktype ].remoteoverrideweapons.size ; i++ )
        {
            if ( level.killstreaks[ killstreaktype ].remoteoverrideweapons[ i ] == weapon )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace killstreaks
// Params 1
// Checksum 0x19ef1b74, Offset: 0x2308
// Size: 0x12c
function register_dev_dvars( killstreaktype )
{
    /#
        assert( isdefined( killstreaktype ), "<dev string:x4a>" );
        assert( isdefined( level.killstreaks[ killstreaktype ] ), "<dev string:x225>" );
        level.killstreaks[ killstreaktype ].devdvar = "<dev string:x269>" + killstreaktype + "<dev string:x26e>";
        level.killstreaks[ killstreaktype ].devenemydvar = "<dev string:x269>" + killstreaktype + "<dev string:x274>";
        level.killstreaks[ killstreaktype ].devtimeoutdvar = "<dev string:x269>" + killstreaktype + "<dev string:x27f>";
        setdvar( level.killstreaks[ killstreaktype ].devtimeoutdvar, 0 );
        level thread register_devgui( killstreaktype );
    #/
}

/#

    // Namespace killstreaks
    // Params 1
    // Checksum 0xcab22944, Offset: 0x2440
    // Size: 0xbc, Type: dev
    function register_dev_debug_dvar( killstreaktype )
    {
        assert( isdefined( killstreaktype ), "<dev string:x4a>" );
        assert( isdefined( level.killstreaks[ killstreaktype ] ), "<dev string:x225>" );
        level.killstreaks[ killstreaktype ].devdebugdvar = "<dev string:x269>" + killstreaktype + "<dev string:x28a>";
        devgui_scorestreak_command_debugdvar( killstreaktype, level.killstreaks[ killstreaktype ].devdebugdvar );
    }

    // Namespace killstreaks
    // Params 1
    // Checksum 0x1f315a84, Offset: 0x2508
    // Size: 0x14c, Type: dev
    function register_devgui( killstreaktype )
    {
        level endon( #"game_ended" );
        wait randomintrange( 2, 20 ) * 0.05;
        give_type_all = "<dev string:x291>";
        give_type_enemy = "<dev string:x296>";
        
        if ( isdefined( level.killstreaks[ killstreaktype ].devdvar ) )
        {
            devgui_scorestreak_command_givedvar( killstreaktype, give_type_all, level.killstreaks[ killstreaktype ].devdvar );
        }
        
        if ( isdefined( level.killstreaks[ killstreaktype ].devenemydvar ) )
        {
            devgui_scorestreak_command_givedvar( killstreaktype, give_type_enemy, level.killstreaks[ killstreaktype ].devenemydvar );
        }
        
        if ( isdefined( level.killstreaks[ killstreaktype ].devtimeoutdvar ) )
        {
            devgui_scorestreak_command_timeoutdvar( killstreaktype, level.killstreaks[ killstreaktype ].devtimeoutdvar );
        }
    }

    // Namespace killstreaks
    // Params 3
    // Checksum 0x935c2fb0, Offset: 0x2660
    // Size: 0x54, Type: dev
    function devgui_scorestreak_command_givedvar( killstreaktype, give_type, dvar )
    {
        devgui_scorestreak_command( killstreaktype, give_type, "<dev string:x2a1>" + dvar + "<dev string:x2a6>" );
    }

    // Namespace killstreaks
    // Params 2
    // Checksum 0x4f8c6196, Offset: 0x26c0
    // Size: 0x3c, Type: dev
    function devgui_scorestreak_command_timeoutdvar( killstreaktype, dvar )
    {
        devgui_scorestreak_dvar_toggle( killstreaktype, "<dev string:x2a9>", dvar );
    }

    // Namespace killstreaks
    // Params 2
    // Checksum 0x4cec49f9, Offset: 0x2708
    // Size: 0x3c, Type: dev
    function devgui_scorestreak_command_debugdvar( killstreaktype, dvar )
    {
        devgui_scorestreak_dvar_toggle( killstreaktype, "<dev string:x2b2>", dvar );
    }

#/

// Namespace killstreaks
// Params 3
// Checksum 0xe8207eb3, Offset: 0x2750
// Size: 0x6c
function devgui_scorestreak_dvar_toggle( killstreaktype, title, dvar )
{
    setdvar( dvar, 0 );
    devgui_scorestreak_command( killstreaktype, "Toggle " + title, "toggle " + dvar + " 1 0" );
}

// Namespace killstreaks
// Params 3
// Checksum 0x7cb4f82b, Offset: 0x27c8
// Size: 0x114
function devgui_scorestreak_command( killstreaktype, title, command )
{
    /#
        assert( isdefined( killstreaktype ), "<dev string:x4a>" );
        assert( isdefined( level.killstreaks[ killstreaktype ] ), "<dev string:x225>" );
        root = "<dev string:x2b8>";
        user_name = makelocalizedstring( level.killstreaks[ killstreaktype ].uiname );
        adddebugcommand( root + user_name + "<dev string:x2d5>" + killstreaktype + "<dev string:x2d8>" + title + "<dev string:x2db>" + command + "<dev string:x2df>" );
    #/
}

// Namespace killstreaks
// Params 1
// Checksum 0x73ac8eb6, Offset: 0x28e8
// Size: 0x8e
function should_draw_debug( killstreak )
{
    /#
        assert( isdefined( killstreak ), "<dev string:x4a>" );
        
        if ( isdefined( level.killstreaks[ killstreak ] ) && isdefined( level.killstreaks[ killstreak ].devdebugdvar ) )
        {
            return getdvarint( level.killstreaks[ killstreak ].devdebugdvar );
        }
    #/
    
    return 0;
}

// Namespace killstreaks
// Params 1
// Checksum 0xbb80e33d, Offset: 0x2980
// Size: 0x18
function register_tos_dvar( dvar )
{
    level.teamops_dvar = dvar;
}

// Namespace killstreaks
// Params 2
// Checksum 0x19d108a, Offset: 0x29a0
// Size: 0x30
function allow_assists( killstreaktype, allow )
{
    level.killstreaks[ killstreaktype ].allowassists = allow;
}

// Namespace killstreaks
// Params 3
// Checksum 0xaa16b85b, Offset: 0x29d8
// Size: 0x74
function set_team_kill_penalty_scale( killstreaktype, scale, isinventory )
{
    level.killstreaks[ killstreaktype ].teamkillpenaltyscale = scale;
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        set_team_kill_penalty_scale( "inventory_" + killstreaktype, scale, 1 );
    }
}

// Namespace killstreaks
// Params 3
// Checksum 0x23c36906, Offset: 0x2a58
// Size: 0x74
function override_entity_camera_in_demo( killstreaktype, value, isinventory )
{
    level.killstreaks[ killstreaktype ].overrideentitycameraindemo = value;
    
    if ( !( isdefined( isinventory ) && isinventory ) )
    {
        override_entity_camera_in_demo( "inventory_" + killstreaktype, value, 1 );
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x8ecacf0f, Offset: 0x2ad8
// Size: 0x2c
function is_available( killstreak )
{
    if ( isdefined( level.menureferenceforkillstreak[ killstreak ] ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace killstreaks
// Params 1
// Checksum 0xc2468ed5, Offset: 0x2b10
// Size: 0x18
function get_by_menu_name( killstreak )
{
    return level.menureferenceforkillstreak[ killstreak ];
}

// Namespace killstreaks
// Params 1
// Checksum 0x93816ebe, Offset: 0x2b30
// Size: 0x4a
function get_menu_name( killstreaktype )
{
    assert( isdefined( level.killstreaks[ killstreaktype ] ) );
    return level.killstreaks[ killstreaktype ].menuname;
}

// Namespace killstreaks
// Params 2
// Checksum 0x3c35240b, Offset: 0x2b88
// Size: 0x114
function get_level( index, killstreak )
{
    killstreaklevel = level.killstreaks[ get_by_menu_name( killstreak ) ].killstreaklevel;
    
    if ( getdvarint( "custom_killstreak_mode" ) == 2 )
    {
        if ( isdefined( self.killstreak[ index ] ) && killstreak == self.killstreak[ index ] )
        {
            killsrequired = getdvarint( "custom_killstreak_" + index + 1 + "_kills" );
            
            if ( killsrequired )
            {
                killstreaklevel = getdvarint( "custom_killstreak_" + index + 1 + "_kills" );
            }
        }
    }
    
    return killstreaklevel;
}

// Namespace killstreaks
// Params 3
// Checksum 0xa060b7ec, Offset: 0x2ca8
// Size: 0x24e, Type: bool
function give_if_streak_count_matches( index, killstreak, streakcount )
{
    pixbeginevent( "giveKillstreakIfStreakCountMatches" );
    
    /#
        if ( !isdefined( killstreak ) )
        {
            println( "<dev string:x2e3>" );
        }
        
        if ( isdefined( killstreak ) )
        {
            println( "<dev string:x2fa>" + killstreak + "<dev string:x310>" );
        }
        
        if ( !is_available( killstreak ) )
        {
            println( "<dev string:x312>" );
        }
    #/
    
    if ( self.pers[ "killstreaksEarnedThisKillstreak" ] > index && util::isroundbased() )
    {
        hasalreadyearnedkillstreak = 1;
    }
    else
    {
        hasalreadyearnedkillstreak = 0;
    }
    
    if ( isdefined( killstreak ) && is_available( killstreak ) && !hasalreadyearnedkillstreak )
    {
        killstreaklevel = get_level( index, killstreak );
        
        if ( self hasperk( "specialty_killstreak" ) )
        {
            reduction = getdvarint( "perk_killstreakReduction" );
            killstreaklevel -= reduction;
            
            if ( killstreaklevel <= 0 )
            {
                killstreaklevel = 1;
            }
        }
        
        if ( killstreaklevel == streakcount )
        {
            self give( get_by_menu_name( killstreak ), streakcount );
            self.pers[ "killstreaksEarnedThisKillstreak" ] = index + 1;
            pixendevent();
            return true;
        }
    }
    
    pixendevent();
    return false;
}

// Namespace killstreaks
// Params 0
// Checksum 0x5dda3a63, Offset: 0x2f00
// Size: 0xbc
function give_for_streak()
{
    if ( !util::iskillstreaksenabled() )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "totalKillstreakCount" ] ) )
    {
        self.pers[ "totalKillstreakCount" ] = 0;
    }
    
    given = 0;
    
    for ( i = 0; i < self.killstreak.size ; i++ )
    {
        given |= give_if_streak_count_matches( i, self.killstreak[ i ], self.pers[ "cur_kill_streak" ] );
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x5e47a72a, Offset: 0x2fc8
// Size: 0x8c
function is_an_a_killstreak()
{
    onkillstreak = 0;
    
    if ( !isdefined( self.pers[ "kill_streak_before_death" ] ) )
    {
        self.pers[ "kill_streak_before_death" ] = 0;
    }
    
    streakplusone = self.pers[ "kill_streak_before_death" ] + 1;
    
    if ( self.pers[ "kill_streak_before_death" ] >= 5 )
    {
        onkillstreak = 1;
    }
    
    return onkillstreak;
}

// Namespace killstreaks
// Params 5
// Checksum 0x9500233b, Offset: 0x3060
// Size: 0x184
function give( killstreaktype, streak, suppressnotification, noxp, tobottom )
{
    pixbeginevent( "giveKillstreak" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    had_to_delay = 0;
    killstreakgiven = 0;
    
    if ( isdefined( noxp ) )
    {
        if ( self give_internal( killstreaktype, undefined, noxp, tobottom ) )
        {
            killstreakgiven = 1;
            
            if ( self.just_given_new_inventory_killstreak === 1 )
            {
                self add_to_notification_queue( level.killstreaks[ killstreaktype ].menuname, streak, killstreaktype, noxp );
            }
        }
    }
    else if ( self give_internal( killstreaktype, noxp ) )
    {
        killstreakgiven = 1;
        
        if ( self.just_given_new_inventory_killstreak === 1 )
        {
            self add_to_notification_queue( level.killstreaks[ killstreaktype ].menuname, streak, killstreaktype, noxp );
        }
    }
    
    pixendevent();
}

// Namespace killstreaks
// Params 1
// Checksum 0xa709918a, Offset: 0x31f0
// Size: 0xf4
function take( killstreak )
{
    self endon( #"disconnect" );
    killstreak_weapon = get_killstreak_weapon( killstreak );
    remove_used_killstreak( killstreak );
    
    if ( self getinventoryweapon() == killstreak_weapon )
    {
        self setinventoryweapon( level.weaponnone );
    }
    
    waittillframeend();
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon != killstreak_weapon || killstreak_weapon.iscarriedkillstreak )
    {
        return;
    }
    
    switch_to_last_non_killstreak_weapon();
    activate_next();
}

// Namespace killstreaks
// Params 0
// Checksum 0xd3f2364, Offset: 0x32f0
// Size: 0x134
function remove_oldest()
{
    if ( isdefined( self.pers[ "killstreaks" ][ 0 ] ) )
    {
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon == get_killstreak_weapon( self.pers[ "killstreaks" ][ 0 ] ) )
        {
            primaries = self getweaponslistprimaries();
            
            if ( primaries.size > 0 )
            {
                self switchtoweapon( primaries[ 0 ] );
            }
        }
        
        self notify( #"oldest_killstreak_removed", self.pers[ "killstreaks" ][ 0 ], self.pers[ "killstreak_unique_id" ][ 0 ] );
        self remove_used_killstreak( self.pers[ "killstreaks" ][ 0 ], self.pers[ "killstreak_unique_id" ][ 0 ], 0 );
    }
}

// Namespace killstreaks
// Params 4
// Checksum 0xe0ee803c, Offset: 0x3430
// Size: 0x524, Type: bool
function give_internal( killstreaktype, do_not_update_death_count, noxp, tobottom )
{
    self.just_given_new_inventory_killstreak = undefined;
    
    if ( level.gameended )
    {
        return false;
    }
    
    if ( !util::iskillstreaksenabled() )
    {
        return false;
    }
    
    if ( !isdefined( level.killstreaks[ killstreaktype ] ) )
    {
        return false;
    }
    
    if ( !isdefined( self.pers[ "killstreaks" ] ) )
    {
        self.pers[ "killstreaks" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_has_been_used" ] ) )
    {
        self.pers[ "killstreak_has_been_used" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_unique_id" ] ) )
    {
        self.pers[ "killstreak_unique_id" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_ammo_count" ] ) )
    {
        self.pers[ "killstreak_ammo_count" ] = [];
    }
    
    just_max_stack_removed_inventory_killstreak = undefined;
    
    if ( isdefined( tobottom ) && tobottom )
    {
        size = self.pers[ "killstreaks" ].size;
        
        if ( self.pers[ "killstreaks" ].size >= level.maxinventoryscorestreaks )
        {
            self remove_oldest();
            just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
        }
        
        for ( i = size; i > 0 ; i-- )
        {
            self.pers[ "killstreaks" ][ i ] = self.pers[ "killstreaks" ][ i - 1 ];
            self.pers[ "killstreak_has_been_used" ][ i ] = self.pers[ "killstreak_has_been_used" ][ i - 1 ];
            self.pers[ "killstreak_unique_id" ][ i ] = self.pers[ "killstreak_unique_id" ][ i - 1 ];
            self.pers[ "killstreak_ammo_count" ][ i ] = self.pers[ "killstreak_ammo_count" ][ i - 1 ];
        }
        
        self.pers[ "killstreaks" ][ 0 ] = killstreaktype;
        self.pers[ "killstreak_unique_id" ][ 0 ] = level.killstreakcounter;
        level.killstreakcounter++;
        
        if ( isdefined( noxp ) )
        {
            self.pers[ "killstreak_has_been_used" ][ 0 ] = noxp;
        }
        else
        {
            self.pers[ "killstreak_has_been_used" ][ 0 ] = 0;
        }
        
        if ( size == 0 )
        {
            weapon = get_killstreak_weapon( killstreaktype );
            ammocount = give_weapon( weapon, 1 );
        }
        
        self.pers[ "killstreak_ammo_count" ][ 0 ] = 0;
    }
    else
    {
        self.pers[ "killstreaks" ][ self.pers[ "killstreaks" ].size ] = killstreaktype;
        self.pers[ "killstreak_unique_id" ][ self.pers[ "killstreak_unique_id" ].size ] = level.killstreakcounter;
        level.killstreakcounter++;
        
        if ( self.pers[ "killstreaks" ].size > level.maxinventoryscorestreaks )
        {
            self remove_oldest();
            just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
        }
        
        if ( isdefined( noxp ) )
        {
            self.pers[ "killstreak_has_been_used" ][ self.pers[ "killstreak_has_been_used" ].size ] = noxp;
        }
        else
        {
            self.pers[ "killstreak_has_been_used" ][ self.pers[ "killstreak_has_been_used" ].size ] = 0;
        }
        
        weapon = get_killstreak_weapon( killstreaktype );
        ammocount = give_weapon( weapon, 1 );
        self.pers[ "killstreak_ammo_count" ][ self.pers[ "killstreak_ammo_count" ].size ] = ammocount;
    }
    
    self.just_given_new_inventory_killstreak = killstreaktype !== just_max_stack_removed_inventory_killstreak;
    return true;
}

// Namespace killstreaks
// Params 4
// Checksum 0xf40ae4ab, Offset: 0x3960
// Size: 0x14c
function add_to_notification_queue( menuname, streakcount, hardpointtype, nonotify )
{
    killstreaktablenumber = level.killstreakindices[ menuname ];
    
    if ( !isdefined( killstreaktablenumber ) )
    {
        return;
    }
    
    if ( isdefined( nonotify ) && nonotify )
    {
        return;
    }
    
    informdialog = get_killstreak_inform_dialog( hardpointtype );
    
    if ( getdvarint( "teamOpsEnabled" ) == 0 )
    {
        self thread play_killstreak_ready_dialog( hardpointtype, 2.4 );
        self thread play_killstreak_ready_sfx( hardpointtype );
        self luinotifyevent( &"killstreak_received", 2, killstreaktablenumber, istring( informdialog ) );
        self luinotifyeventtospectators( &"killstreak_received", 2, killstreaktablenumber, istring( informdialog ) );
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0xe75dc6b7, Offset: 0x3ab8
// Size: 0xaa, Type: bool
function has_equipped()
{
    currentweapon = self getcurrentweapon();
    keys = getarraykeys( level.killstreaks );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        if ( level.killstreaks[ keys[ i ] ].weapon == currentweapon )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killstreaks
// Params 1
// Checksum 0x57430b4c, Offset: 0x3b70
// Size: 0x214
function _get_from_weapon( weapon )
{
    keys = getarraykeys( level.killstreaks );
    
    foreach ( key in keys )
    {
        killstreak = level.killstreaks[ key ];
        
        if ( killstreak.weapon == weapon )
        {
            return key;
        }
        
        if ( isdefined( killstreak.altweapons ) )
        {
            foreach ( altweapon in killstreak.altweapons )
            {
                if ( altweapon == weapon )
                {
                    return key;
                }
            }
        }
        
        if ( isdefined( killstreak.remoteoverrideweapons ) )
        {
            foreach ( remoteoverrideweapon in killstreak.remoteoverrideweapons )
            {
                if ( remoteoverrideweapon == weapon )
                {
                    return key;
                }
            }
        }
    }
    
    return undefined;
}

// Namespace killstreaks
// Params 1
// Checksum 0x767e6bec, Offset: 0x3d90
// Size: 0x76
function get_from_weapon( weapon )
{
    if ( weapon == level.weaponnone )
    {
        return undefined;
    }
    
    res = _get_from_weapon( weapon );
    
    if ( !isdefined( res ) )
    {
        return _get_from_weapon( weapon.rootweapon );
    }
    
    return res;
}

// Namespace killstreaks
// Params 3
// Checksum 0xf8b6017, Offset: 0x3e10
// Size: 0x5d2
function give_weapon( weapon, isinventory, usestoredammo )
{
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon != level.weaponnone && !( isdefined( level.usingmomentum ) && level.usingmomentum ) )
    {
        weaponslist = self getweaponslist();
        
        for ( idx = 0; idx < weaponslist.size ; idx++ )
        {
            carriedweapon = weaponslist[ idx ];
            
            if ( currentweapon == carriedweapon )
            {
                continue;
            }
            
            switch ( carriedweapon.name )
            {
                case "m32":
                default:
                    continue;
            }
            
            if ( is_killstreak_weapon( carriedweapon ) )
            {
                self takeweapon( carriedweapon );
            }
        }
    }
    
    if ( currentweapon != weapon && self hasweapon( weapon ) == 0 )
    {
        self takeweapon( weapon );
        self giveweapon( weapon );
    }
    
    if ( isdefined( level.usingmomentum ) && level.usingmomentum )
    {
        self setinventoryweapon( weapon );
        
        if ( weapon.iscarriedkillstreak )
        {
            if ( !isdefined( self.pers[ "held_killstreak_ammo_count" ][ weapon ] ) )
            {
                self.pers[ "held_killstreak_ammo_count" ][ weapon ] = 0;
            }
            
            if ( !isdefined( self.pers[ "held_killstreak_clip_count" ][ weapon ] ) )
            {
                self.pers[ "held_killstreak_clip_count" ][ weapon ] = weapon.clipsize;
            }
            
            if ( !isdefined( self.pers[ "killstreak_quantity" ][ weapon ] ) )
            {
                self.pers[ "killstreak_quantity" ][ weapon ] = 0;
            }
            
            if ( currentweapon == weapon && !isheldinventorykillstreakweapon( weapon ) )
            {
                return weapon.maxammo;
            }
            else if ( isdefined( usestoredammo ) && usestoredammo && self.pers[ "killstreak_ammo_count" ][ self.pers[ "killstreak_ammo_count" ].size - 1 ] > 0 )
            {
                switch ( weapon.name )
                {
                    case "inventory_minigun":
                        if ( isdefined( self.minigunactive ) && self.minigunactive )
                        {
                            return self.pers[ "held_killstreak_ammo_count" ][ weapon ];
                        }
                        
                        break;
                    case "inventory_m32":
                        if ( isdefined( self.m32active ) && self.m32active )
                        {
                            return self.pers[ "held_killstreak_ammo_count" ][ weapon ];
                        }
                        
                        break;
                    default:
                        break;
                }
                
                self.pers[ "held_killstreak_ammo_count" ][ weapon ] = self.pers[ "killstreak_ammo_count" ][ self.pers[ "killstreak_ammo_count" ].size - 1 ];
                self loadout::setweaponammooverall( weapon, self.pers[ "killstreak_ammo_count" ][ self.pers[ "killstreak_ammo_count" ].size - 1 ] );
            }
            else
            {
                self.pers[ "held_killstreak_ammo_count" ][ weapon ] = weapon.maxammo;
                self.pers[ "held_killstreak_clip_count" ][ weapon ] = weapon.clipsize;
                self loadout::setweaponammooverall( weapon, self.pers[ "held_killstreak_ammo_count" ][ weapon ] );
            }
            
            return self.pers[ "held_killstreak_ammo_count" ][ weapon ];
        }
        else
        {
            switch ( weapon.name )
            {
                case "ai_tank_marker":
                case "combat_robot_marker":
                case "dart":
                case "inventory_ai_tank_marker":
                case "inventory_combat_robot_marker":
                case "inventory_dart":
                case "inventory_m32_drop":
                case "inventory_minigun_drop":
                case "inventory_missile_drone":
                case "inventory_supplydrop_marker":
                case "supplydrop_marker":
                    delta = 1;
                    break;
                default:
                    delta = 0;
                    break;
            }
            
            return change_killstreak_quantity( weapon, delta );
        }
        
        return;
    }
    
    self setactionslot( 4, "weapon", weapon );
    return 1;
}

// Namespace killstreaks
// Params 1
// Checksum 0xf5f7016d, Offset: 0x43f0
// Size: 0x206, Type: bool
function activate_next( do_not_update_death_count )
{
    if ( level.gameended )
    {
        return false;
    }
    
    if ( isdefined( level.usingmomentum ) && level.usingmomentum )
    {
        self setinventoryweapon( level.weaponnone );
    }
    else
    {
        self setactionslot( 4, "" );
    }
    
    if ( !isdefined( self.pers[ "killstreaks" ] ) || self.pers[ "killstreaks" ].size == 0 )
    {
        return false;
    }
    
    killstreaktype = self.pers[ "killstreaks" ][ self.pers[ "killstreaks" ].size - 1 ];
    
    if ( !isdefined( level.killstreaks[ killstreaktype ] ) )
    {
        return false;
    }
    
    weapon = level.killstreaks[ killstreaktype ].weapon;
    wait 0.05;
    ammocount = give_weapon( weapon, 0, 1 );
    
    if ( weapon.iscarriedkillstreak )
    {
        self setweaponammoclip( weapon, self.pers[ "held_killstreak_clip_count" ][ weapon ] );
        self setweaponammostock( weapon, ammocount - self.pers[ "held_killstreak_clip_count" ][ weapon ] );
    }
    
    if ( !isdefined( do_not_update_death_count ) || do_not_update_death_count != 0 )
    {
        self.pers[ "killstreakItemDeathCount" + killstreaktype ] = self.deathcount;
    }
    
    return true;
}

// Namespace killstreaks
// Params 0
// Checksum 0xf07b2dc, Offset: 0x4600
// Size: 0x4c
function give_owned()
{
    if ( isdefined( self.pers[ "killstreaks" ] ) && self.pers[ "killstreaks" ].size > 0 )
    {
        self activate_next( 0 );
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0xb7a0a46b, Offset: 0x4658
// Size: 0x44
function get_killstreak_quantity( killstreakweapon )
{
    return isdefined( self.pers[ "killstreak_quantity" ][ killstreakweapon ] ) ? self.pers[ "killstreak_quantity" ][ killstreakweapon ] : 0;
}

// Namespace killstreaks
// Params 2
// Checksum 0xbd740f36, Offset: 0x46a8
// Size: 0x120
function change_killstreak_quantity( killstreakweapon, delta )
{
    quantity = get_killstreak_quantity( killstreakweapon );
    previousquantity = quantity;
    quantity += delta;
    
    if ( quantity > level.scorestreaksmaxstacking )
    {
        quantity = level.scorestreaksmaxstacking;
    }
    
    if ( self hasweapon( killstreakweapon ) == 0 )
    {
        self takeweapon( killstreakweapon );
        self giveweapon( killstreakweapon );
        self seteverhadweaponall( 1 );
    }
    
    self.pers[ "killstreak_quantity" ][ killstreakweapon ] = quantity;
    self setweaponammoclip( killstreakweapon, quantity );
    return quantity;
}

// Namespace killstreaks
// Params 1
// Checksum 0x42d8718a, Offset: 0x47d0
// Size: 0x92, Type: bool
function has_killstreak_in_class( killstreakmenuname )
{
    foreach ( equippedkillstreak in self.killstreak )
    {
        if ( equippedkillstreak == killstreakmenuname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killstreaks
// Params 1
// Checksum 0xa6fd74a7, Offset: 0x4870
// Size: 0xaa, Type: bool
function has_killstreak( killstreak )
{
    player = self;
    
    if ( !isdefined( killstreak ) || !isdefined( player.pers[ "killstreaks" ] ) )
    {
        return false;
    }
    
    for ( i = 0; i < self.pers[ "killstreaks" ].size ; i++ )
    {
        if ( player.pers[ "killstreaks" ][ i ] == killstreak )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killstreaks
// Params 1
// Checksum 0x370b9450, Offset: 0x4928
// Size: 0x13a
function recordkillstreakbegindirect( recordstreakindex )
{
    player = self;
    
    if ( !isplayer( player ) || !isdefined( recordstreakindex ) )
    {
        return;
    }
    
    if ( !isdefined( self.killstreakevents ) )
    {
        player.killstreakevents = associativearray();
    }
    
    if ( isdefined( self.killstreakevents[ recordstreakindex ] ) )
    {
        kills = player.killstreakevents[ recordstreakindex ];
        eventindex = player recordkillstreakevent( recordstreakindex );
        player killstreakrules::recordkillstreakenddirect( eventindex, recordstreakindex, kills );
        player.killstreakevents[ recordstreakindex ] = undefined;
        return;
    }
    
    eventindex = player recordkillstreakevent( recordstreakindex );
    player.killstreakevents[ recordstreakindex ] = eventindex;
}

// Namespace killstreaks
// Params 3
// Checksum 0x44daa694, Offset: 0x4a70
// Size: 0x4dc
function remove_when_done( killstreak, haskillstreakbeenused, isfrominventory )
{
    self endon( #"disconnect" );
    
    for ( continue_wait = 1; continue_wait ; continue_wait = 0 )
    {
        self waittill( #"killstreak_done", successful, killstreaktype );
        
        if ( killstreaktype == killstreak )
        {
        }
    }
    
    if ( successful )
    {
        /#
            print( "<dev string:x32d>" + get_menu_name( killstreak ) );
        #/
        
        killstreak_weapon = get_killstreak_weapon( killstreak );
        recordstreakindex = undefined;
        
        if ( isdefined( level.killstreaks[ killstreak ].menuname ) )
        {
            recordstreakindex = level.killstreakindices[ level.killstreaks[ killstreak ].menuname ];
            self recordkillstreakbegindirect( recordstreakindex );
        }
        
        if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks )
        {
            if ( isdefined( isfrominventory ) && isfrominventory )
            {
                remove_used_killstreak( killstreak );
                
                if ( self getinventoryweapon() == killstreak_weapon )
                {
                    self setinventoryweapon( level.weaponnone );
                }
            }
            else
            {
                self change_killstreak_quantity( killstreak_weapon, -1 );
            }
        }
        else if ( isdefined( level.usingmomentum ) && level.usingmomentum )
        {
            if ( isdefined( isfrominventory ) && isfrominventory && self getinventoryweapon() == killstreak_weapon )
            {
                remove_used_killstreak( killstreak );
                self setinventoryweapon( level.weaponnone );
            }
            else
            {
                globallogic_score::_setplayermomentum( self, self.momentum - level.killstreaks[ killstreaktype ].momentumcost );
            }
        }
        else
        {
            remove_used_killstreak( killstreak );
        }
        
        if ( !( isdefined( level.usingmomentum ) && level.usingmomentum ) )
        {
            self setactionslot( 4, "" );
        }
        
        success = 1;
    }
    
    waittillframeend();
    self unhide_compass();
    currentweapon = self getcurrentweapon();
    killstreak_weapon = get_killstreak_weapon( killstreaktype );
    
    if ( currentweapon == killstreak_weapon && killstreak_weapon.iscarriedkillstreak )
    {
        return;
    }
    
    if ( isdefined( isfrominventory ) && ( !self has_killstreak_in_class( get_menu_name( killstreak ) ) || successful && isfrominventory ) )
    {
        switch_to_last_non_killstreak_weapon();
    }
    else
    {
        killstreakforcurrentweapon = get_from_weapon( currentweapon );
        
        if ( currentweapon.isgameplayweapon )
        {
            if ( isdefined( self.isdefusing ) && ( isdefined( self.isplanting ) && self.isplanting || self.isdefusing ) )
            {
                return;
            }
        }
        
        if ( !isdefined( killstreakforcurrentweapon ) && currentweapon.isheroweapon )
        {
            return;
        }
        
        if ( successful || !isdefined( killstreakforcurrentweapon ) || killstreakforcurrentweapon == killstreak )
        {
            switch_to_last_non_killstreak_weapon();
        }
    }
    
    if ( isdefined( isfrominventory ) && ( !( isdefined( level.usingmomentum ) && level.usingmomentum ) || isfrominventory ) )
    {
        if ( successful )
        {
            activate_next();
        }
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0xab1c133e, Offset: 0x4f58
// Size: 0x7c
function usekillstreak( killstreak, isfrominventory )
{
    haskillstreakbeenused = get_if_top_killstreak_has_been_used();
    
    if ( isdefined( self.selectinglocation ) )
    {
        return;
    }
    
    self thread remove_when_done( killstreak, haskillstreakbeenused, isfrominventory );
    self thread trigger_killstreak( killstreak, isfrominventory );
}

// Namespace killstreaks
// Params 3
// Checksum 0xa6b5867f, Offset: 0x4fe0
// Size: 0x316
function remove_used_killstreak( killstreak, killstreakid, take_weapon_after_use )
{
    if ( !isdefined( take_weapon_after_use ) )
    {
        take_weapon_after_use = 1;
    }
    
    self.just_removed_used_killstreak = undefined;
    
    if ( !isdefined( self.pers[ "killstreaks" ] ) )
    {
        return;
    }
    
    killstreakindex = undefined;
    
    for ( i = self.pers[ "killstreaks" ].size - 1; i >= 0 ; i-- )
    {
        if ( self.pers[ "killstreaks" ][ i ] == killstreak )
        {
            if ( isdefined( killstreakid ) && self.pers[ "killstreak_unique_id" ][ i ] != killstreakid )
            {
                continue;
            }
            
            killstreakindex = i;
            break;
        }
    }
    
    if ( !isdefined( killstreakindex ) )
    {
        return 0;
    }
    
    self.just_removed_used_killstreak = killstreak;
    
    if ( take_weapon_after_use && !self has_killstreak_in_class( get_menu_name( killstreak ) ) )
    {
        self thread take_weapon_after_use( get_killstreak_weapon( killstreak ) );
    }
    
    arraysize = self.pers[ "killstreaks" ].size;
    
    for ( i = killstreakindex; i < arraysize - 1 ; i++ )
    {
        self.pers[ "killstreaks" ][ i ] = self.pers[ "killstreaks" ][ i + 1 ];
        self.pers[ "killstreak_has_been_used" ][ i ] = self.pers[ "killstreak_has_been_used" ][ i + 1 ];
        self.pers[ "killstreak_unique_id" ][ i ] = self.pers[ "killstreak_unique_id" ][ i + 1 ];
        self.pers[ "killstreak_ammo_count" ][ i ] = self.pers[ "killstreak_ammo_count" ][ i + 1 ];
    }
    
    self.pers[ "killstreaks" ][ arraysize - 1 ] = undefined;
    self.pers[ "killstreak_has_been_used" ][ arraysize - 1 ] = undefined;
    self.pers[ "killstreak_unique_id" ][ arraysize - 1 ] = undefined;
    self.pers[ "killstreak_ammo_count" ][ arraysize - 1 ] = undefined;
    return 1;
}

// Namespace killstreaks
// Params 1
// Checksum 0x2a8749f7, Offset: 0x5300
// Size: 0x8c
function take_weapon_after_use( killstreakweapon )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    self waittill( #"weapon_change" );
    inventoryweapon = self getinventoryweapon();
    
    if ( inventoryweapon != killstreakweapon )
    {
        self takeweapon( killstreakweapon );
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0xa3973c49, Offset: 0x5398
// Size: 0x4e
function get_top_killstreak()
{
    if ( self.pers[ "killstreaks" ].size == 0 )
    {
        return undefined;
    }
    
    return self.pers[ "killstreaks" ][ self.pers[ "killstreaks" ].size - 1 ];
}

// Namespace killstreaks
// Params 0
// Checksum 0x79ea1bf8, Offset: 0x53f0
// Size: 0x68
function get_if_top_killstreak_has_been_used()
{
    if ( !( isdefined( level.usingmomentum ) && level.usingmomentum ) )
    {
        if ( self.pers[ "killstreak_has_been_used" ].size == 0 )
        {
            return undefined;
        }
        
        return self.pers[ "killstreak_has_been_used" ][ self.pers[ "killstreak_has_been_used" ].size - 1 ];
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x34383ca2, Offset: 0x5460
// Size: 0x4e
function get_top_killstreak_unique_id()
{
    if ( self.pers[ "killstreak_unique_id" ].size == 0 )
    {
        return undefined;
    }
    
    return self.pers[ "killstreak_unique_id" ][ self.pers[ "killstreak_unique_id" ].size - 1 ];
}

// Namespace killstreaks
// Params 1
// Checksum 0xd20cd01a, Offset: 0x54b8
// Size: 0x72
function get_killstreak_index_by_id( killstreakid )
{
    for ( index = self.pers[ "killstreak_unique_id" ].size - 1; index >= 0 ; index-- )
    {
        if ( self.pers[ "killstreak_unique_id" ][ index ] == killstreakid )
        {
            return index;
        }
    }
    
    return undefined;
}

// Namespace killstreaks
// Params 1
// Checksum 0x7e9884e3, Offset: 0x5538
// Size: 0x72
function get_killstreak_momentum_cost( killstreak )
{
    if ( !( isdefined( level.usingmomentum ) && level.usingmomentum ) )
    {
        return 0;
    }
    
    if ( !isdefined( killstreak ) )
    {
        return 0;
    }
    
    assert( isdefined( level.killstreaks[ killstreak ] ) );
    return level.killstreaks[ killstreak ].momentumcost;
}

// Namespace killstreaks
// Params 1
// Checksum 0x8cdb8622, Offset: 0x55b8
// Size: 0x4a
function get_killstreak_for_weapon( weapon )
{
    if ( isdefined( level.killstreakweapons[ weapon ] ) )
    {
        return level.killstreakweapons[ weapon ];
    }
    
    return level.killstreakweapons[ weapon.rootweapon ];
}

// Namespace killstreaks
// Params 1
// Checksum 0x18f961d2, Offset: 0x5610
// Size: 0x8c
function get_killstreak_for_weapon_for_stats( weapon )
{
    prefix = "inventory_";
    killstreak = get_killstreak_for_weapon( weapon );
    
    if ( isdefined( killstreak ) )
    {
        if ( strstartswith( killstreak, prefix ) )
        {
            killstreak = getsubstr( killstreak, prefix.size );
        }
    }
    
    return killstreak;
}

// Namespace killstreaks
// Params 1
// Checksum 0x5e50a78, Offset: 0x56a8
// Size: 0x62, Type: bool
function is_killstreak_weapon_assist_allowed( weapon )
{
    killstreak = get_killstreak_for_weapon( weapon );
    
    if ( !isdefined( killstreak ) )
    {
        return false;
    }
    
    if ( level.killstreaks[ killstreak ].allowassists )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreaks
// Params 1
// Checksum 0x88dd4d24, Offset: 0x5718
// Size: 0x5a
function get_killstreak_team_kill_penalty_scale( weapon )
{
    killstreak = get_killstreak_for_weapon( weapon );
    
    if ( !isdefined( killstreak ) )
    {
        return 1;
    }
    
    return level.killstreaks[ killstreak ].teamkillpenaltyscale;
}

// Namespace killstreaks
// Params 2
// Checksum 0x99af13bc, Offset: 0x5780
// Size: 0xba, Type: bool
function should_override_entity_camera_in_demo( player, weapon )
{
    killstreak = get_killstreak_for_weapon( weapon );
    
    if ( !isdefined( killstreak ) )
    {
        return false;
    }
    
    if ( level.killstreaks[ killstreak ].overrideentitycameraindemo )
    {
        return true;
    }
    
    if ( isdefined( player.remoteweapon.controlled ) && isdefined( player.remoteweapon ) && player.remoteweapon.controlled )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreaks
// Params 1
// Checksum 0x566a431b, Offset: 0x5848
// Size: 0x94
function wait_till_hero_weapon_is_fully_on( weapon )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"weapon_change" );
    slot = self gadgetgetslot( weapon );
    
    while ( true )
    {
        if ( self ability_player::gadget_is_in_use( slot ) )
        {
            self.lastnonkillstreakweapon = weapon;
            return;
        }
        
        wait 0.05;
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x83849c2, Offset: 0x58e8
// Size: 0x2c8
function track_weapon_usage()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self.lastnonkillstreakweapon = self getcurrentweapon();
    lastvalidpimary = self getcurrentweapon();
    
    if ( self.lastnonkillstreakweapon == level.weaponnone )
    {
        weapons = self getweaponslistprimaries();
        
        if ( weapons.size > 0 )
        {
            self.lastnonkillstreakweapon = weapons[ 0 ];
        }
        else
        {
            self.lastnonkillstreakweapon = level.weaponbasemelee;
        }
    }
    
    assert( self.lastnonkillstreakweapon != level.weaponnone );
    
    for ( ;; )
    {
        currentweapon = self getcurrentweapon();
        self waittill( #"weapon_change", weapon );
        
        if ( weapons::is_primary_weapon( weapon ) )
        {
            lastvalidpimary = weapon;
        }
        
        if ( weapon == self.lastnonkillstreakweapon || weapon == level.weaponnone || weapon == level.weaponbasemelee )
        {
            continue;
        }
        
        if ( weapon.isgameplayweapon )
        {
            continue;
        }
        
        if ( isdefined( self.resurrect_weapon ) && weapon == self.resurrect_weapon )
        {
            continue;
        }
        
        name = get_killstreak_for_weapon( weapon );
        
        if ( isdefined( name ) && !weapon.iscarriedkillstreak )
        {
            killstreak = level.killstreaks[ name ];
            continue;
        }
        
        if ( currentweapon.isequipment )
        {
            if ( self.lastnonkillstreakweapon.iscarriedkillstreak )
            {
                self.lastnonkillstreakweapon = lastvalidpimary;
            }
            
            continue;
        }
        
        if ( weapon.isheroweapon )
        {
            if ( weapon.gadget_heroversion_2_0 )
            {
                if ( weapon.isgadget && self getammocount( weapon ) > 0 )
                {
                    self thread wait_till_hero_weapon_is_fully_on( weapon );
                    continue;
                }
            }
        }
        
        self.lastnonkillstreakweapon = weapon;
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0x68febe29, Offset: 0x5bb8
// Size: 0x310
function killstreak_waiter()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self thread track_weapon_usage();
    self give_owned();
    
    for ( ;; )
    {
        self waittill( #"weapon_change", weapon );
        
        if ( !is_killstreak_weapon( weapon ) )
        {
            continue;
        }
        
        killstreak = get_killstreak_for_weapon( weapon );
        
        if ( !( isdefined( level.usingmomentum ) && level.usingmomentum ) )
        {
            killstreak = get_top_killstreak();
            
            if ( weapon != get_killstreak_weapon( killstreak ) )
            {
                continue;
            }
        }
        
        if ( is_remote_override_weapon( killstreak, weapon ) )
        {
            continue;
        }
        
        inventorybuttonpressed = self inventorybuttonpressed() || isdefined( self.pers[ "isBot" ] );
        waittillframeend();
        
        if ( isdefined( self.usingkillstreakheldweapon ) && self.usingkillstreakheldweapon && weapon.iscarriedkillstreak )
        {
            continue;
        }
        
        isfrominventory = undefined;
        
        if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks )
        {
            if ( weapon == self getinventoryweapon() )
            {
                isfrominventory = 1;
            }
            else if ( self getammocount( weapon ) <= 0 && weapon.name != "killstreak_ai_tank" )
            {
                self switch_to_last_non_killstreak_weapon();
                continue;
            }
        }
        else if ( isdefined( level.usingmomentum ) && level.usingmomentum )
        {
            if ( weapon == self getinventoryweapon() && inventorybuttonpressed )
            {
                isfrominventory = 1;
            }
            else if ( self.momentum < level.killstreaks[ killstreak ].momentumcost )
            {
                self switch_to_last_non_killstreak_weapon();
                continue;
            }
        }
        
        if ( !isdefined( level.starttime ) && level.roundstartkillstreakdelay > 0 )
        {
            display_unavailable_time();
            continue;
        }
        
        thread usekillstreak( killstreak, isfrominventory );
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0xe30b2b85, Offset: 0x5ed0
// Size: 0xd6, Type: bool
function should_delay_killstreak( killstreaktype )
{
    if ( !isdefined( level.starttime ) )
    {
        return false;
    }
    
    if ( level.roundstartkillstreakdelay < ( gettime() - level.starttime - level.discardtime ) / 1000 )
    {
        return false;
    }
    
    if ( !is_delayable_killstreak( killstreaktype ) )
    {
        return false;
    }
    
    killstreakweapon = get_killstreak_weapon( killstreaktype );
    
    if ( killstreakweapon.iscarriedkillstreak )
    {
        return false;
    }
    
    if ( util::isfirstround() || util::isoneround() )
    {
        return false;
    }
    
    return true;
}

// Namespace killstreaks
// Params 1
// Checksum 0xecfa8290, Offset: 0x5fb0
// Size: 0x5e, Type: bool
function is_delayable_killstreak( killstreaktype )
{
    if ( isdefined( level.killstreaks[ killstreaktype ].delaystreak ) && isdefined( level.killstreaks[ killstreaktype ] ) && level.killstreaks[ killstreaktype ].delaystreak )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreaks
// Params 1
// Checksum 0xeb0d4c72, Offset: 0x6018
// Size: 0x11e
function get_xp_amount_for_killstreak( killstreaktype )
{
    xpamount = 0;
    
    switch ( level.killstreaks[ killstreaktype ].killstreaklevel )
    {
        case 1:
        case 2:
        case 3:
        case 4:
            xpamount = 100;
            break;
        case 5:
            xpamount = 150;
            break;
        case 6:
        case 7:
            xpamount = 200;
            break;
        case 8:
            xpamount = 250;
            break;
        case 9:
            xpamount = 300;
            break;
        case 10:
        case 11:
            xpamount = 350;
            break;
        case 12:
        case 13:
        case 14:
        case 15:
            xpamount = 500;
            break;
    }
    
    return xpamount;
}

// Namespace killstreaks
// Params 0
// Checksum 0x9a5c647d, Offset: 0x6140
// Size: 0x94
function display_unavailable_time()
{
    timeleft = int( level.roundstartkillstreakdelay - globallogic_utils::gettimepassed() / 1000 );
    
    if ( timeleft <= 0 )
    {
        timeleft = 1;
    }
    
    self iprintlnbold( &"MP_UNAVAILABLE_FOR_N", " " + timeleft + " ", &"EXE_SECONDS" );
}

// Namespace killstreaks
// Params 2
// Checksum 0x9e61ee2f, Offset: 0x61e0
// Size: 0x198, Type: bool
function trigger_killstreak( killstreaktype, isfrominventory )
{
    assert( isdefined( level.killstreaks[ killstreaktype ].usefunction ), "<dev string:xa3>" + killstreaktype );
    self.usingkillstreakfrominventory = isfrominventory;
    
    if ( level.infinalkillcam )
    {
        return false;
    }
    
    if ( should_delay_killstreak( killstreaktype ) )
    {
        display_unavailable_time();
    }
    else if ( [[ level.killstreaks[ killstreaktype ].usefunction ]]( killstreaktype ) )
    {
        if ( isdefined( self ) )
        {
            if ( !isdefined( self.pers[ level.killstreaks[ killstreaktype ].usagekey ] ) )
            {
                self.pers[ level.killstreaks[ killstreaktype ].usagekey ] = 0;
            }
            
            self.pers[ level.killstreaks[ killstreaktype ].usagekey ]++;
            self notify( #"killstreak_used", killstreaktype );
            self notify( #"killstreak_done", 1, killstreaktype );
        }
        
        self.usingkillstreakfrominventory = undefined;
        return true;
    }
    
    self.usingkillstreakfrominventory = undefined;
    
    if ( isdefined( self ) )
    {
        self notify( #"killstreak_done", 0, killstreaktype );
    }
    
    return false;
}

// Namespace killstreaks
// Params 1
// Checksum 0x70e15ec8, Offset: 0x6380
// Size: 0x4a
function add_to_killstreak_count( weapon )
{
    if ( !isdefined( self.pers[ "totalKillstreakCount" ] ) )
    {
        self.pers[ "totalKillstreakCount" ] = 0;
    }
    
    self.pers[ "totalKillstreakCount" ]++;
}

// Namespace killstreaks
// Params 1
// Checksum 0x17eab85b, Offset: 0x63d8
// Size: 0xde
function get_first_valid_killstreak_alt_weapon( killstreaktype )
{
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "<dev string:x33a>" );
    
    if ( isdefined( level.killstreaks[ killstreaktype ].altweapons ) )
    {
        for ( i = 0; i < level.killstreaks[ killstreaktype ].altweapons.size ; i++ )
        {
            if ( isdefined( level.killstreaks[ killstreaktype ].altweapons[ i ] ) )
            {
                return level.killstreaks[ killstreaktype ].altweapons[ i ];
            }
        }
    }
    
    return level.weaponnone;
}

// Namespace killstreaks
// Params 1
// Checksum 0xb39e410b, Offset: 0x64c0
// Size: 0x86, Type: bool
function should_give_killstreak( weapon )
{
    if ( getdvarint( "teamOpsEnabled" ) == 1 )
    {
        return false;
    }
    
    killstreakbuilding = getdvarint( "scr_allow_killstreak_building" );
    
    if ( killstreakbuilding == 0 )
    {
        if ( is_weapon_associated_with_killstreak( weapon ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace killstreaks
// Params 3
// Checksum 0x7916adca, Offset: 0x6550
// Size: 0x42, Type: bool
function point_is_in_danger_area( point, targetpos, radius )
{
    return distance2d( point, targetpos ) <= radius * 1.25;
}

// Namespace killstreaks
// Params 5
// Checksum 0x6b2944ea, Offset: 0x65a0
// Size: 0x2c4
function print_killstreak_start_text( killstreaktype, owner, team, targetpos, dangerradius )
{
    if ( !isdefined( level.killstreaks[ killstreaktype ] ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        players = level.players;
        
        if ( !level.hardcoremode && isdefined( level.killstreaks[ killstreaktype ].inboundnearplayertext ) )
        {
            for ( i = 0; i < players.size ; i++ )
            {
                if ( isalive( players[ i ] ) && isdefined( players[ i ].pers[ "team" ] ) && players[ i ].pers[ "team" ] == team )
                {
                    if ( point_is_in_danger_area( players[ i ].origin, targetpos, dangerradius ) )
                    {
                        players[ i ] iprintlnbold( level.killstreaks[ killstreaktype ].inboundnearplayertext );
                    }
                }
            }
        }
        
        if ( isdefined( level.killstreaks[ killstreaktype ] ) )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                player = level.players[ i ];
                playerteam = player.pers[ "team" ];
                
                if ( isdefined( playerteam ) )
                {
                    if ( playerteam == team )
                    {
                        player iprintln( level.killstreaks[ killstreaktype ].inboundtext, owner );
                    }
                }
            }
        }
        
        return;
    }
    
    if ( !level.hardcoremode && isdefined( level.killstreaks[ killstreaktype ].inboundnearplayertext ) )
    {
        if ( point_is_in_danger_area( owner.origin, targetpos, dangerradius ) )
        {
            owner iprintlnbold( level.killstreaks[ killstreaktype ].inboundnearplayertext );
        }
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x4b292018, Offset: 0x6870
// Size: 0x64
function play_killstreak_firewall_being_hacked_dialog( killstreaktype, killstreakid )
{
    if ( self globallogic_audio::killstreak_dialog_queued( "firewallBeingHacked", killstreaktype, killstreakid ) )
    {
        return;
    }
    
    self globallogic_audio::play_taacom_dialog( "firewallBeingHacked", killstreaktype, killstreakid );
}

// Namespace killstreaks
// Params 2
// Checksum 0x1924b116, Offset: 0x68e0
// Size: 0x64
function play_killstreak_firewall_hacked_dialog( killstreaktype, killstreakid )
{
    if ( self globallogic_audio::killstreak_dialog_queued( "firewallHacked", killstreaktype, killstreakid ) )
    {
        return;
    }
    
    self globallogic_audio::play_taacom_dialog( "firewallHacked", killstreaktype, killstreakid );
}

// Namespace killstreaks
// Params 2
// Checksum 0x5a0ed5cc, Offset: 0x6950
// Size: 0x64
function play_killstreak_being_hacked_dialog( killstreaktype, killstreakid )
{
    if ( self globallogic_audio::killstreak_dialog_queued( "beingHacked", killstreaktype, killstreakid ) )
    {
        return;
    }
    
    self globallogic_audio::play_taacom_dialog( "beingHacked", killstreaktype, killstreakid );
}

// Namespace killstreaks
// Params 3
// Checksum 0x8b842931, Offset: 0x69c0
// Size: 0x144
function play_killstreak_hacked_dialog( killstreaktype, killstreakid, hacker )
{
    self globallogic_audio::flush_killstreak_dialog_on_player( killstreakid );
    self globallogic_audio::play_taacom_dialog( "hacked", killstreaktype );
    excludeself = [];
    excludeself[ 0 ] = self;
    
    if ( level.teambased )
    {
        globallogic_audio::leader_dialog( level.killstreaks[ killstreaktype ].hackeddialogkey, self.team, excludeself );
        globallogic_audio::leader_dialog_for_other_teams( level.killstreaks[ killstreaktype ].hackedstartdialogkey, self.team, undefined, killstreakid );
        return;
    }
    
    self globallogic_audio::leader_dialog_on_player( level.killstreaks[ killstreaktype ].hackeddialogkey );
    hacker globallogic_audio::leader_dialog_on_player( level.killstreaks[ killstreaktype ].hackedstartdialogkey );
}

// Namespace killstreaks
// Params 3
// Checksum 0x796f2ac4, Offset: 0x6b10
// Size: 0x17c
function play_killstreak_start_dialog( killstreaktype, team, killstreakid )
{
    if ( !isdefined( killstreaktype ) || !isdefined( killstreakid ) )
    {
        return;
    }
    
    self notify( "killstreak_start_" + killstreaktype );
    self notify( "killstreak_start_inventory_" + killstreaktype );
    dialogkey = level.killstreaks[ killstreaktype ].requestdialogkey;
    
    if ( !isdefined( self.currentkillstreakdialog ) && isdefined( dialogkey ) && isdefined( level.heroplaydialog ) )
    {
        self thread [[ level.heroplaydialog ]]( dialogkey );
    }
    
    excludeself = [];
    excludeself[ 0 ] = self;
    
    if ( level.teambased )
    {
        globallogic_audio::leader_dialog( level.killstreaks[ killstreaktype ].startdialogkey, team, excludeself, undefined, killstreakid );
        globallogic_audio::leader_dialog_for_other_teams( level.killstreaks[ killstreaktype ].enemystartdialogkey, team, undefined, killstreakid );
        return;
    }
    
    globallogic_audio::leader_dialog( level.killstreaks[ killstreaktype ].enemystartdialogkey, undefined, excludeself, undefined, killstreakid );
}

// Namespace killstreaks
// Params 1
// Checksum 0x2aa1df36, Offset: 0x6c98
// Size: 0x64
function play_killstreak_ready_sfx( killstreaktype )
{
    if ( !isdefined( level.gameended ) || !level.gameended )
    {
        ready_sfx_alias = "mpl_killstreak_" + killstreaktype;
        
        if ( isdefined( ready_sfx_alias ) )
        {
            self playsoundtoplayer( ready_sfx_alias, self );
        }
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x3972a427, Offset: 0x6d08
// Size: 0xcc
function play_killstreak_ready_dialog( killstreaktype, taacomwaittime )
{
    self notify( "killstreak_ready_" + killstreaktype );
    self endon( #"death" );
    self endon( "killstreak_start_" + killstreaktype );
    self endon( "killstreak_ready_" + killstreaktype );
    level endon( #"game_ended" );
    
    if ( isdefined( level.gameended ) && level.gameended )
    {
        return;
    }
    
    if ( globallogic_audio::killstreak_dialog_queued( "ready", killstreaktype ) )
    {
        return;
    }
    
    if ( isdefined( taacomwaittime ) )
    {
        wait taacomwaittime;
    }
    
    self globallogic_audio::play_taacom_dialog( "ready", killstreaktype );
}

// Namespace killstreaks
// Params 2
// Checksum 0xa5624e5d, Offset: 0x6de0
// Size: 0x94
function play_destroyed_dialog_on_owner( killstreaktype, killstreakid )
{
    if ( !isdefined( self.owner ) || !isdefined( self.team ) || self.team != self.owner.team )
    {
        return;
    }
    
    self.owner globallogic_audio::flush_killstreak_dialog_on_player( killstreakid );
    self.owner globallogic_audio::play_taacom_dialog( "destroyed", killstreaktype );
}

// Namespace killstreaks
// Params 3
// Checksum 0x1f4a9a55, Offset: 0x6e80
// Size: 0x7c
function play_taacom_dialog_on_owner( dialogkey, killstreaktype, killstreakid )
{
    if ( !isdefined( self.owner ) || !isdefined( self.team ) || self.team != self.owner.team )
    {
        return;
    }
    
    self.owner globallogic_audio::play_taacom_dialog( dialogkey, killstreaktype, killstreakid );
}

// Namespace killstreaks
// Params 3
// Checksum 0x83204a5, Offset: 0x6f08
// Size: 0x9c
function play_pilot_dialog_on_owner( dialogkey, killstreaktype, killstreakid )
{
    if ( !isdefined( self.owner ) || !isdefined( self.owner.team ) || !isdefined( self.team ) || self.team != self.owner.team )
    {
        return;
    }
    
    self.owner play_pilot_dialog( dialogkey, killstreaktype, killstreakid, self.pilotindex );
}

// Namespace killstreaks
// Params 4
// Checksum 0xf5978bcd, Offset: 0x6fb0
// Size: 0x64
function play_pilot_dialog( dialogkey, killstreaktype, killstreakid, pilotindex )
{
    if ( !isdefined( killstreaktype ) || !isdefined( pilotindex ) )
    {
        return;
    }
    
    self globallogic_audio::killstreak_dialog_on_player( dialogkey, killstreaktype, killstreakid, pilotindex );
}

// Namespace killstreaks
// Params 3
// Checksum 0xf454cae6, Offset: 0x7020
// Size: 0xc4
function play_taacom_dialog_response_on_owner( dialogkey, killstreaktype, killstreakid )
{
    assert( isdefined( dialogkey ) );
    assert( isdefined( killstreaktype ) );
    
    if ( !isdefined( self.owner ) || !isdefined( self.team ) || self.team != self.owner.team )
    {
        return;
    }
    
    self.owner play_taacom_dialog_response( dialogkey, killstreaktype, killstreakid, self.pilotindex );
}

// Namespace killstreaks
// Params 4
// Checksum 0xebd53f97, Offset: 0x70f0
// Size: 0x94
function play_taacom_dialog_response( dialogkey, killstreaktype, killstreakid, pilotindex )
{
    assert( isdefined( dialogkey ) );
    assert( isdefined( killstreaktype ) );
    
    if ( !isdefined( pilotindex ) )
    {
        return;
    }
    
    self globallogic_audio::play_taacom_dialog( dialogkey + pilotindex, killstreaktype, killstreakid );
}

// Namespace killstreaks
// Params 1
// Checksum 0x1bb84d2f, Offset: 0x7190
// Size: 0xb2
function get_random_pilot_index( killstreaktype )
{
    if ( !isdefined( killstreaktype ) )
    {
        return undefined;
    }
    
    taacombundle = struct::get_script_bundle( "mpdialog_taacom", self.pers[ "mptaacom" ] );
    
    if ( !isdefined( taacombundle.pilotbundles[ killstreaktype ] ) )
    {
        return undefined;
    }
    
    numpilots = taacombundle.pilotbundles[ killstreaktype ].size;
    
    if ( numpilots <= 0 )
    {
        return undefined;
    }
    
    return randomint( numpilots );
}

// Namespace killstreaks
// Params 1
// Checksum 0x17e5c6dd, Offset: 0x7250
// Size: 0x310
function player_killstreak_threat_tracking( killstreaktype )
{
    assert( isdefined( killstreaktype ) );
    self endon( #"death" );
    self endon( #"delete" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !isdefined( self.owner ) )
        {
            return;
        }
        
        players = self.owner battlechatter::get_enemy_players();
        players = array::randomize( players );
        
        foreach ( player in players )
        {
            if ( !player battlechatter::can_play_dialog( 1 ) )
            {
                continue;
            }
            
            lookangles = player getplayerangles();
            
            if ( lookangles[ 0 ] < 270 || lookangles[ 0 ] > 330 )
            {
                continue;
            }
            
            lookdir = anglestoforward( lookangles );
            eyepoint = player geteye();
            streakdir = vectornormalize( self.origin - eyepoint );
            dot = vectordot( streakdir, lookdir );
            
            if ( dot < 0.94 )
            {
                continue;
            }
            
            traceresult = bullettrace( eyepoint, self.origin, 1, player );
            
            if ( traceresult[ "fraction" ] >= 1 || traceresult[ "entity" ] === self )
            {
                if ( battlechatter::dialog_chance( "killstreakSpotChance" ) )
                {
                    player battlechatter::play_killstreak_threat( killstreaktype );
                }
                
                wait battlechatter::mpdialog_value( "killstreakSpotDelay", 0 );
                break;
            }
        }
        
        wait battlechatter::mpdialog_value( "killstreakSpotInterval", 0.05 );
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x82e7ef75, Offset: 0x7568
// Size: 0x46
function get_killstreak_inform_dialog( killstreaktype )
{
    if ( isdefined( level.killstreaks[ killstreaktype ].informdialog ) )
    {
        return level.killstreaks[ killstreaktype ].informdialog;
    }
    
    return "";
}

// Namespace killstreaks
// Params 1
// Checksum 0x8a0b133e, Offset: 0x75b8
// Size: 0x62
function get_killstreak_usage_by_killstreak( killstreaktype )
{
    assert( isdefined( level.killstreaks[ killstreaktype ] ), "<dev string:x355>" );
    return get_killstreak_usage( level.killstreaks[ killstreaktype ].usagekey );
}

// Namespace killstreaks
// Params 1
// Checksum 0xd4e689eb, Offset: 0x7628
// Size: 0x30
function get_killstreak_usage( usagekey )
{
    if ( !isdefined( self.pers[ usagekey ] ) )
    {
        return 0;
    }
    
    return self.pers[ usagekey ];
}

// Namespace killstreaks
// Params 0
// Checksum 0xfe98ac25, Offset: 0x7660
// Size: 0x164
function on_player_spawned()
{
    self endon( #"disconnect" );
    pixbeginevent( "_killstreaks.gsc/onPlayerSpawned" );
    give_owned();
    
    if ( !isdefined( self.pers[ "killstreaks" ] ) )
    {
        self.pers[ "killstreaks" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_has_been_used" ] ) )
    {
        self.pers[ "killstreak_has_been_used" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_unique_id" ] ) )
    {
        self.pers[ "killstreak_unique_id" ] = [];
    }
    
    if ( !isdefined( self.pers[ "killstreak_ammo_count" ] ) )
    {
        self.pers[ "killstreak_ammo_count" ] = [];
    }
    
    size = self.pers[ "killstreaks" ].size;
    
    if ( size > 0 )
    {
        self thread play_killstreak_ready_dialog( self.pers[ "killstreaks" ][ size - 1 ] );
    }
    
    self.killcamkilledbyent = undefined;
    pixendevent();
}

// Namespace killstreaks
// Params 0
// Checksum 0xafbe19ac, Offset: 0x77d0
// Size: 0x126
function on_joined_team()
{
    self endon( #"disconnect" );
    self setinventoryweapon( level.weaponnone );
    self.pers[ "cur_kill_streak" ] = 0;
    self.pers[ "cur_total_kill_streak" ] = 0;
    self setplayercurrentstreak( 0 );
    self.pers[ "totalKillstreakCount" ] = 0;
    self.pers[ "killstreaks" ] = [];
    self.pers[ "killstreak_has_been_used" ] = [];
    self.pers[ "killstreak_unique_id" ] = [];
    self.pers[ "killstreak_ammo_count" ] = [];
    
    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks )
    {
        self.pers[ "killstreak_quantity" ] = [];
        self.pers[ "held_killstreak_ammo_count" ] = [];
        self.pers[ "held_killstreak_clip_count" ] = [];
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x6e196693, Offset: 0x7900
// Size: 0x88
function init_ride_killstreak( streak, always_allow )
{
    if ( !isdefined( always_allow ) )
    {
        always_allow = 0;
    }
    
    self disableusability();
    result = self init_ride_killstreak_internal( streak, always_allow );
    
    if ( isdefined( self ) )
    {
        self enableusability();
    }
    
    return result;
}

// Namespace killstreaks
// Params 0
// Checksum 0x3f572bae, Offset: 0x7990
// Size: 0x50
function watch_for_remove_remote_weapon()
{
    self endon( #"endwatchforremoveremoteweapon" );
    
    for ( ;; )
    {
        self waittill( #"remove_remote_weapon" );
        self switch_to_last_non_killstreak_weapon();
        self enableusability();
    }
}

// Namespace killstreaks
// Params 2
// Checksum 0x84678850, Offset: 0x79e8
// Size: 0x3dc
function init_ride_killstreak_internal( streak, always_allow )
{
    if ( streak == "qrdrone" || streak == "dart" || streak == "killstreak_remote_turret" || streak == "killstreak_ai_tank" || streak == "qrdrone" || isdefined( streak ) && streak == "sentinel" )
    {
        laptopwait = "timeout";
    }
    else
    {
        laptopwait = self util::waittill_any_timeout( 0.6, "disconnect", "death", "weapon_switch_started" );
    }
    
    hostmigration::waittillhostmigrationdone();
    
    if ( laptopwait == "weapon_switch_started" )
    {
        return "fail";
    }
    
    if ( !isalive( self ) && !always_allow )
    {
        return "fail";
    }
    
    if ( laptopwait == "disconnect" || laptopwait == "death" )
    {
        if ( laptopwait == "disconnect" )
        {
            return "disconnect";
        }
        
        if ( self.team == "spectator" )
        {
            return "fail";
        }
        
        return "success";
    }
    
    if ( self isempjammed() && !( isdefined( self.ignoreempjammed ) && self.ignoreempjammed ) )
    {
        return "fail";
    }
    
    if ( self is_interacting_with_object() )
    {
        return "fail";
    }
    
    self thread hud::fade_to_black_for_x_sec( 0, 0.2, 0.4, 0.25 );
    self thread watch_for_remove_remote_weapon();
    blackoutwait = self util::waittill_any_timeout( 0.6, "disconnect", "death" );
    self notify( #"endwatchforremoveremoteweapon" );
    hostmigration::waittillhostmigrationdone();
    
    if ( blackoutwait != "disconnect" )
    {
        self thread clear_ride_intro( 1 );
        
        if ( self.team == "spectator" )
        {
            return "fail";
        }
    }
    
    if ( always_allow )
    {
        if ( blackoutwait == "disconnect" )
        {
            return "disconnect";
        }
        else
        {
            return "success";
        }
    }
    
    if ( self isonladder() )
    {
        return "fail";
    }
    
    if ( !isalive( self ) )
    {
        return "fail";
    }
    
    if ( self isempjammed() && !( isdefined( self.ignoreempjammed ) && self.ignoreempjammed ) )
    {
        return "fail";
    }
    
    if ( isdefined( self.laststand ) && self.laststand )
    {
        return "fail";
    }
    
    if ( self is_interacting_with_object() )
    {
        return "fail";
    }
    
    if ( blackoutwait == "disconnect" )
    {
        return "disconnect";
    }
    
    return "success";
}

// Namespace killstreaks
// Params 1
// Checksum 0x81722d20, Offset: 0x7dd0
// Size: 0x3c
function clear_ride_intro( delay )
{
    self endon( #"disconnect" );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    self thread hud::screen_fade_in( 0 );
}

/#

    // Namespace killstreaks
    // Params 0
    // Checksum 0xa5f95008, Offset: 0x7e18
    // Size: 0xc0, Type: dev
    function killstreak_debug_think()
    {
        setdvar( "<dev string:x39c>", "<dev string:xcb>" );
        
        for ( ;; )
        {
            cmd = getdvarstring( "<dev string:x39c>" );
            
            switch ( cmd )
            {
                default:
                    killstreak_data_dump();
                    break;
            }
            
            if ( cmd != "<dev string:xcb>" )
            {
                setdvar( "<dev string:x39c>", "<dev string:xcb>" );
            }
            
            wait 0.5;
        }
    }

    // Namespace killstreaks
    // Params 0
    // Checksum 0xae66b3d5, Offset: 0x7ee0
    // Size: 0x36c, Type: dev
    function killstreak_data_dump()
    {
        iprintln( "<dev string:x3b7>" );
        println( "<dev string:x3d7>" );
        println( "<dev string:x3f3>" );
        keys = getarraykeys( level.killstreaks );
        
        for ( i = 0; i < keys.size ; i++ )
        {
            data = level.killstreaks[ keys[ i ] ];
            type_data = level.killstreaktype[ keys[ i ] ];
            print( keys[ i ] + "<dev string:x459>" );
            print( data.killstreaklevel + "<dev string:x459>" );
            print( data.weapon.name + "<dev string:x459>" );
            alt = 0;
            
            if ( isdefined( data.altweapons ) )
            {
                assert( data.altweapons.size <= 4 );
                
                for ( alt = 0; alt < data.altweapons.size ; alt++ )
                {
                    print( data.altweapons[ alt ].name + "<dev string:x459>" );
                }
            }
            
            while ( alt < 4 )
            {
                print( "<dev string:x459>" );
                alt++;
            }
            
            type = 0;
            
            if ( isdefined( type_data ) )
            {
                assert( type_data.size < 4 );
                type_keys = getarraykeys( type_data );
                
                while ( type < type_keys.size )
                {
                    if ( type_data[ type_keys[ type ] ] == 1 )
                    {
                        print( type_keys[ type ] + "<dev string:x459>" );
                    }
                    
                    type++;
                }
            }
            
            while ( type < 4 )
            {
                print( "<dev string:x459>" );
                type++;
            }
            
            println( "<dev string:xcb>" );
        }
        
        println( "<dev string:x45b>" );
    }

#/

// Namespace killstreaks
// Params 0
// Checksum 0x38a84dda, Offset: 0x8258
// Size: 0x5e, Type: bool
function is_interacting_with_object()
{
    if ( self iscarryingturret() )
    {
        return true;
    }
    
    if ( isdefined( self.isplanting ) && self.isplanting )
    {
        return true;
    }
    
    if ( isdefined( self.isdefusing ) && self.isdefusing )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreaks
// Params 2
// Checksum 0x7f6113b8, Offset: 0x82c0
// Size: 0x164
function clear_using_remote( immediate, skipnotify )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.dofutz = 0;
    self.no_fade2black = 0;
    self clientfield::set_to_player( "static_postfx", 0 );
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 1;
    }
    
    self.usingremote = undefined;
    self reset_killstreak_delay_killcam();
    self enableoffhandweapons();
    self enableweaponcycling();
    curweapon = self getcurrentweapon();
    
    if ( isalive( self ) )
    {
        self switch_to_last_non_killstreak_weapon( immediate );
    }
    
    if ( !level.gameended )
    {
        self util::freeze_player_controls( 0 );
    }
    
    if ( !( isdefined( skipnotify ) && skipnotify ) )
    {
        self notify( #"stopped_using_remote" );
    }
    
    thread hide_tablet();
}

// Namespace killstreaks
// Params 0
// Checksum 0x11bf8f3d, Offset: 0x8430
// Size: 0x34
function hide_tablet()
{
    self endon( #"disconnect" );
    wait 0.2;
    self clientfield::set_player_uimodel( "hudItems.remoteKillstreakActivated", 0 );
}

// Namespace killstreaks
// Params 1
// Checksum 0x3189987, Offset: 0x8470
// Size: 0x18
function set_killstreak_delay_killcam( killstreak_name )
{
    self.killstreak_delay_killcam = killstreak_name;
}

// Namespace killstreaks
// Params 0
// Checksum 0x26a8ace2, Offset: 0x8490
// Size: 0xe
function reset_killstreak_delay_killcam()
{
    self.killstreak_delay_killcam = undefined;
}

// Namespace killstreaks
// Params 0
// Checksum 0xb551cb6c, Offset: 0x84a8
// Size: 0x24
function hide_compass()
{
    self clientfield::set( "killstreak_hides_compass", 1 );
}

// Namespace killstreaks
// Params 0
// Checksum 0x46f3ad39, Offset: 0x84d8
// Size: 0x24
function unhide_compass()
{
    self clientfield::set( "killstreak_hides_compass", 0 );
}

// Namespace killstreaks
// Params 3
// Checksum 0x598dbfc0, Offset: 0x8508
// Size: 0x10c
function setup_health( killstreak_ref, max_health, low_health )
{
    self.maxhealth = max_health;
    self.lowhealth = low_health;
    self.hackedhealthupdatecallback = &defaulthackedhealthupdatecallback;
    tablemaxhealth = killstreak_bundles::get_max_health( killstreak_ref );
    
    if ( isdefined( tablemaxhealth ) )
    {
        self.maxhealth = tablemaxhealth;
    }
    
    tablelowhealth = killstreak_bundles::get_low_health( killstreak_ref );
    
    if ( isdefined( tablelowhealth ) )
    {
        self.lowhealth = tablelowhealth;
    }
    
    tablehackedhealth = killstreak_bundles::get_hacked_health( killstreak_ref );
    
    if ( isdefined( tablehackedhealth ) )
    {
        self.hackedhealth = tablehackedhealth;
        return;
    }
    
    self.hackedhealth = self.maxhealth;
}

// Namespace killstreaks
// Params 8
// Checksum 0xb60e3ab7, Offset: 0x8620
// Size: 0x6b0
function monitordamage( killstreak_ref, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage )
{
    self endon( #"death" );
    self endon( #"delete" );
    self.health = 9999999;
    self.damagetaken = 0;
    self setup_health( killstreak_ref, max_health, low_health );
    assert( !isvehicle( self ) || !issentient( self ), "<dev string:x47b>" );
    
    while ( true )
    {
        weapon_damage = undefined;
        self waittill( #"damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon, flags, inflictor, chargelevel );
        
        if ( isdefined( self.invulnerable ) && self.invulnerable )
        {
            continue;
        }
        
        if ( !isdefined( attacker ) || !isplayer( attacker ) )
        {
            continue;
        }
        
        friendlyfire = weaponobjects::friendlyfirecheck( self.owner, attacker );
        
        if ( !friendlyfire )
        {
            continue;
        }
        
        if ( isdefined( self.owner ) && attacker == self.owner )
        {
            continue;
        }
        
        isvalidattacker = 1;
        
        if ( level.teambased )
        {
            isvalidattacker = isdefined( attacker.team ) && attacker.team != self.team;
        }
        
        if ( !isvalidattacker )
        {
            continue;
        }
        
        if ( isdefined( self.killstreakdamagemodifier ) )
        {
            damage = [[ self.killstreakdamagemodifier ]]( damage, attacker, direction, point, type, tagname, modelname, partname, weapon, flags, inflictor, chargelevel );
            
            if ( damage <= 0 )
            {
                continue;
            }
        }
        
        if ( weapon.isemp && type == "MOD_GRENADE_SPLASH" )
        {
            emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage( killstreak_ref, self.maxhealth );
            
            if ( !isdefined( emp_damage_to_apply ) )
            {
                emp_damage_to_apply = isdefined( emp_damage ) ? emp_damage : 1;
            }
            
            if ( isdefined( emp_callback ) && emp_damage_to_apply > 0 )
            {
                self [[ emp_callback ]]( attacker );
            }
            
            weapon_damage = emp_damage_to_apply;
        }
        
        if ( isdefined( self.selfdestruct ) && self.selfdestruct )
        {
            weapon_damage = self.maxhealth + 1;
        }
        
        if ( !isdefined( weapon_damage ) )
        {
            weapon_damage = killstreak_bundles::get_weapon_damage( killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel );
            
            if ( !isdefined( weapon_damage ) )
            {
                weapon_damage = get_old_damage( attacker, weapon, type, damage, allow_bullet_damage );
            }
        }
        
        if ( weapon_damage > 0 )
        {
            if ( damagefeedback::dodamagefeedback( weapon, attacker ) )
            {
                attacker thread damagefeedback::update( type );
            }
            
            self challenges::trackassists( attacker, weapon_damage, 0 );
        }
        
        self.damagetaken += weapon_damage;
        
        if ( !issentient( self ) && weapon_damage > 0 )
        {
            self.attacker = attacker;
        }
        
        if ( self.damagetaken > self.maxhealth )
        {
            weaponstatname = "destroyed";
            
            switch ( weapon.name )
            {
                case "auto_tow":
                case "tow_turret":
                default:
                    weaponstatname = "kills";
                    break;
            }
            
            level.globalkillstreaksdestroyed++;
            attacker addweaponstat( getweapon( killstreak_ref ), "destroyed", 1 );
            
            if ( isdefined( destroyed_callback ) )
            {
                self thread [[ destroyed_callback ]]( attacker, weapon );
            }
            
            return;
        }
        
        remaining_health = max_health - self.damagetaken;
        
        if ( remaining_health < low_health && weapon_damage > 0 )
        {
            if ( !isdefined( self.currentstate ) || isdefined( low_health_callback ) && self.currentstate != "damaged" )
            {
                self [[ low_health_callback ]]( attacker, weapon );
            }
            
            self.currentstate = "damaged";
        }
        
        if ( isdefined( self.extra_low_health ) && remaining_health < self.extra_low_health && weapon_damage > 0 )
        {
            if ( isdefined( self.extra_low_health_callback ) && !isdefined( self.extra_low_damage_notified ) )
            {
                self [[ self.extra_low_health_callback ]]( attacker, weapon );
                self.extra_low_damage_notified = 1;
            }
        }
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x8f8e37f7, Offset: 0x8cd8
// Size: 0xb8
function defaulthackedhealthupdatecallback( hacker )
{
    killstreak = self;
    assert( isdefined( self.maxhealth ) );
    assert( isdefined( self.hackedhealth ) );
    assert( isdefined( self.damagetaken ) );
    damageafterhacking = self.maxhealth - self.hackedhealth;
    
    if ( self.damagetaken < damageafterhacking )
    {
        self.damagetaken = damageafterhacking;
    }
}

// Namespace killstreaks
// Params 14
// Checksum 0x11db9086, Offset: 0x8d98
// Size: 0x36c
function ondamageperweapon( killstreak_ref, attacker, damage, flags, type, weapon, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage, chargelevel )
{
    self.maxhealth = max_health;
    self.lowhealth = low_health;
    tablehealth = killstreak_bundles::get_max_health( killstreak_ref );
    
    if ( isdefined( tablehealth ) )
    {
        self.maxhealth = tablehealth;
    }
    
    tablehealth = killstreak_bundles::get_low_health( killstreak_ref );
    
    if ( isdefined( tablehealth ) )
    {
        self.lowhealth = tablehealth;
    }
    
    if ( isdefined( self.invulnerable ) && self.invulnerable )
    {
        return 0;
    }
    
    if ( !isdefined( attacker ) || !isplayer( attacker ) )
    {
        return get_old_damage( attacker, weapon, type, damage, allow_bullet_damage );
    }
    
    friendlyfire = weaponobjects::friendlyfirecheck( self.owner, attacker );
    
    if ( !friendlyfire )
    {
        return 0;
    }
    
    isvalidattacker = 1;
    
    if ( level.teambased )
    {
        isvalidattacker = isdefined( attacker.team ) && attacker.team != self.team;
    }
    
    if ( !isvalidattacker )
    {
        return 0;
    }
    
    if ( weapon.isemp && type == "MOD_GRENADE_SPLASH" )
    {
        emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage( killstreak_ref, self.maxhealth );
        
        if ( !isdefined( emp_damage_to_apply ) )
        {
            emp_damage_to_apply = isdefined( emp_damage ) ? emp_damage : 1;
        }
        
        if ( isdefined( emp_callback ) && emp_damage_to_apply > 0 )
        {
            self [[ emp_callback ]]( attacker, weapon );
        }
        
        return emp_damage_to_apply;
    }
    
    weapon_damage = killstreak_bundles::get_weapon_damage( killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel );
    
    if ( !isdefined( weapon_damage ) )
    {
        weapon_damage = get_old_damage( attacker, weapon, type, damage, allow_bullet_damage );
    }
    
    if ( weapon_damage <= 0 )
    {
        return 0;
    }
    
    idamage = int( weapon_damage );
    
    if ( idamage > self.health )
    {
        if ( isdefined( destroyed_callback ) )
        {
            self thread [[ destroyed_callback ]]( attacker, weapon );
        }
    }
    
    return idamage;
}

// Namespace killstreaks
// Params 5
// Checksum 0xc954f177, Offset: 0x9110
// Size: 0x1de
function get_old_damage( attacker, weapon, type, damage, allow_bullet_damage )
{
    switch ( type )
    {
        case "MOD_PISTOL_BULLET":
        case "MOD_RIFLE_BULLET":
            if ( !allow_bullet_damage )
            {
                damage = 0;
                break;
            }
            
            if ( isdefined( attacker ) && isplayer( attacker ) )
            {
                hasfmj = attacker hasperk( "specialty_armorpiercing" );
            }
            
            if ( isdefined( hasfmj ) && hasfmj )
            {
                damage = int( damage * level.cac_armorpiercing_data );
            }
            
            break;
        case "MOD_EXPLOSIVE":
        case "MOD_PROJECTILE":
        case "MOD_PROJECTILE_SPLASH":
            if ( weapon.statindex == level.weaponpistolenergy.statindex || weapon.statindex != level.weaponshotgunenergy.statindex || weapon.statindex == level.weaponspecialcrossbow.statindex )
            {
                break;
            }
            
            if ( isdefined( self.remotemissiledamage ) && isdefined( weapon ) && weapon.name == "remote_missile_missile" )
            {
                damage = self.remotemissiledamage;
            }
            else if ( isdefined( self.rocketdamage ) )
            {
                damage = self.rocketdamage;
            }
            
            break;
        default:
            break;
    }
    
    return damage;
}

// Namespace killstreaks
// Params 7
// Checksum 0xffdd86ea, Offset: 0x92f8
// Size: 0xdc
function configure_team( killstreaktype, killstreakid, owner, influencertype, configureteamprefunction, configureteampostfunction, ishacked )
{
    if ( !isdefined( ishacked ) )
    {
        ishacked = 0;
    }
    
    killstreak = self;
    killstreak.killstreaktype = killstreaktype;
    killstreak.killstreakid = killstreakid;
    killstreak _setup_configure_team_callbacks( influencertype, configureteamprefunction, configureteampostfunction );
    killstreak configure_team_internal( owner, ishacked );
    owner thread trackactivekillstreak( killstreak );
}

// Namespace killstreaks
// Params 1
// Checksum 0x654684c5, Offset: 0x93e0
// Size: 0x92
function trackactivekillstreak( killstreak )
{
    self endon( #"disconnect" );
    killstreakindex = killstreak.killstreakid;
    
    if ( isdefined( killstreakindex ) )
    {
        self.pers[ "activeKillstreaks" ][ killstreakindex ] = killstreak;
        killstreak util::waittill_any( "killstreak_hacked", "death" );
        self.pers[ "activeKillstreaks" ][ killstreakindex ] = undefined;
    }
}

// Namespace killstreaks
// Params 0
// Checksum 0xc47b1769, Offset: 0x9480
// Size: 0x14
function getactivekillstreaks()
{
    return self.pers[ "activeKillstreaks" ];
}

// Namespace killstreaks
// Params 2
// Checksum 0x6ea4a17, Offset: 0x94a0
// Size: 0x258
function configure_team_internal( owner, ishacked )
{
    killstreak = self;
    
    if ( ishacked == 0 )
    {
        killstreak.originalowner = owner;
        killstreak.originalteam = owner.team;
        
        /#
            killstreak thread killstreak_hacking::killstreak_switch_team( owner );
        #/
    }
    else
    {
        assert( killstreak.killstreakteamconfigured, "<dev string:x4ef>" );
    }
    
    if ( isdefined( killstreak.killstreakconfigureteamprefunction ) )
    {
        killstreak thread [[ killstreak.killstreakconfigureteamprefunction ]]( owner, ishacked );
    }
    
    if ( isdefined( killstreak.killstreakinfluencertype ) )
    {
        killstreak spawning::remove_influencers();
    }
    
    killstreak setteam( owner.team );
    killstreak.team = owner.team;
    
    if ( !isai( killstreak ) )
    {
        killstreak setowner( owner );
    }
    
    killstreak.owner = owner;
    killstreak.ownerentnum = owner.entnum;
    killstreak.pilotindex = killstreak.owner get_random_pilot_index( killstreak.killstreaktype );
    
    if ( isdefined( killstreak.killstreakinfluencertype ) )
    {
        killstreak spawning::create_entity_enemy_influencer( killstreak.killstreakinfluencertype, owner.team );
    }
    
    if ( isdefined( killstreak.killstreakconfigureteampostfunction ) )
    {
        killstreak thread [[ killstreak.killstreakconfigureteampostfunction ]]( owner, ishacked );
    }
}

// Namespace killstreaks
// Params 3, eflags: 0x4
// Checksum 0xe28d886d, Offset: 0x9700
// Size: 0x7c
function private _setup_configure_team_callbacks( influencertype, configureteamprefunction, configureteampostfunction )
{
    killstreak = self;
    killstreak.killstreakteamconfigured = 1;
    killstreak.killstreakinfluencertype = influencertype;
    killstreak.killstreakconfigureteamprefunction = configureteamprefunction;
    killstreak.killstreakconfigureteampostfunction = configureteampostfunction;
}

// Namespace killstreaks
// Params 1
// Checksum 0xaad9e906, Offset: 0x9788
// Size: 0xa0
function watchteamchange( teamchangenotify )
{
    self notify( teamchangenotify + "_Singleton" );
    self endon( teamchangenotify + "_Singleton" );
    killstreak = self;
    killstreak endon( #"death" );
    killstreak endon( teamchangenotify );
    killstreak.owner util::waittill_any( "joined_team", "disconnect", "joined_spectators", "emp_jammed" );
    killstreak notify( teamchangenotify );
}

// Namespace killstreaks
// Params 1
// Checksum 0xeb71c06, Offset: 0x9830
// Size: 0xae
function should_not_timeout( killstreak )
{
    /#
        assert( isdefined( killstreak ), "<dev string:x4a>" );
        assert( isdefined( level.killstreaks[ killstreak ] ), "<dev string:x225>" );
        
        if ( isdefined( level.killstreaks[ killstreak ].devtimeoutdvar ) )
        {
            return getdvarint( level.killstreaks[ killstreak ].devtimeoutdvar );
        }
    #/
    
    return 0;
}

// Namespace killstreaks
// Params 6
// Checksum 0x721f77d4, Offset: 0x98e8
// Size: 0x180
function waitfortimeout( killstreak, duration, callback, endcondition1, endcondition2, endcondition3 )
{
    /#
        if ( should_not_timeout( killstreak ) )
        {
            return;
        }
    #/
    
    self endon( #"killstreak_hacked" );
    
    if ( isdefined( endcondition1 ) )
    {
        self endon( endcondition1 );
    }
    
    if ( isdefined( endcondition2 ) )
    {
        self endon( endcondition2 );
    }
    
    if ( isdefined( endcondition3 ) )
    {
        self endon( endcondition3 );
    }
    
    self thread waitfortimeouthacked( killstreak, callback, endcondition1, endcondition2, endcondition3 );
    killstreakbundle = level.killstreakbundle[ self.killstreaktype ];
    self.killstreakendtime = gettime() + duration;
    
    if ( isdefined( killstreakbundle ) && isdefined( killstreakbundle.kstimeoutbeepduration ) )
    {
        self waitfortimeoutbeep( killstreakbundle, duration );
    }
    else
    {
        hostmigration::migrationawarewait( duration );
    }
    
    self notify( #"kill_waitfortimeouthacked_thread" );
    self.killstreaktimedout = 1;
    self.killstreakendtime = 0;
    self notify( #"timed_out" );
    self [[ callback ]]();
}

// Namespace killstreaks
// Params 2
// Checksum 0x1af66c76, Offset: 0x9a70
// Size: 0x194
function waitfortimeoutbeep( killstreakbundle, duration )
{
    self endon( #"death" );
    beepduration = killstreakbundle.kstimeoutbeepduration * 1000;
    hostmigration::migrationawarewait( max( duration - beepduration, 0 ) );
    
    if ( isvehicle( self ) )
    {
        self clientfield::set( "timeout_beep", 1 );
    }
    
    if ( isdefined( killstreakbundle.kstimeoutfastbeepduration ) )
    {
        fastbeepduration = killstreakbundle.kstimeoutfastbeepduration * 1000;
        hostmigration::migrationawarewait( max( beepduration - fastbeepduration, 0 ) );
        
        if ( isvehicle( self ) )
        {
            self clientfield::set( "timeout_beep", 2 );
        }
        
        hostmigration::migrationawarewait( fastbeepduration );
    }
    
    if ( isvehicle( self ) )
    {
        self clientfield::set( "timeout_beep", 0 );
    }
}

// Namespace killstreaks
// Params 5
// Checksum 0x8c697a4e, Offset: 0x9c10
// Size: 0xe4
function waitfortimeouthacked( killstreak, callback, endcondition1, endcondition2, endcondition3 )
{
    self endon( #"kill_waitfortimeouthacked_thread" );
    
    if ( isdefined( endcondition1 ) )
    {
        self endon( endcondition1 );
    }
    
    if ( isdefined( endcondition2 ) )
    {
        self endon( endcondition2 );
    }
    
    if ( isdefined( endcondition3 ) )
    {
        self endon( endcondition3 );
    }
    
    self waittill( #"killstreak_hacked" );
    hackedduration = self killstreak_hacking::get_hacked_timeout_duration_ms();
    self.killstreakendtime = gettime() + hackedduration;
    hostmigration::migrationawarewait( hackedduration );
    self.killstreakendtime = 0;
    self notify( #"timed_out" );
    self [[ callback ]]();
}

// Namespace killstreaks
// Params 1
// Checksum 0x558ae7d, Offset: 0x9d00
// Size: 0x2c0
function update_player_threat( player )
{
    heli = self;
    player.threatlevel = 0;
    dist = distance( player.origin, heli.origin );
    player.threatlevel += ( level.heli_visual_range - dist ) / level.heli_visual_range * 100;
    
    if ( isdefined( heli.attacker ) && player == heli.attacker )
    {
        player.threatlevel += 100;
    }
    
    if ( isdefined( player.carryobject ) )
    {
        player.threatlevel += 200;
    }
    
    if ( isdefined( player.score ) )
    {
        player.threatlevel += player.score * 2;
    }
    
    if ( player weapons::has_launcher() )
    {
        if ( player weapons::has_lockon( heli ) )
        {
            player.threatlevel += 1000;
        }
        else
        {
            player.threatlevel += 500;
        }
    }
    
    if ( player weapons::has_hero_weapon() )
    {
        player.threatlevel += 300;
    }
    
    if ( player weapons::has_lmg() )
    {
        player.threatlevel += 200;
    }
    
    if ( isdefined( player.antithreat ) )
    {
        player.threatlevel -= player.antithreat;
    }
    
    if ( player.threatlevel <= 0 )
    {
        player.threatlevel = 1;
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0x1f2ddf50, Offset: 0x9fc8
// Size: 0xc4
function update_non_player_threat( non_player )
{
    heli = self;
    non_player.threatlevel = 0;
    dist = distance( non_player.origin, heli.origin );
    non_player.threatlevel += ( level.heli_visual_range - dist ) / level.heli_visual_range * 100;
    
    if ( non_player.threatlevel <= 0 )
    {
        non_player.threatlevel = 1;
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0xf7b8dc25, Offset: 0xa098
// Size: 0x214
function update_actor_threat( actor )
{
    heli = self;
    actor.threatlevel = 0;
    dist = distance( actor.origin, heli.origin );
    actor.threatlevel += ( level.heli_visual_range - dist ) / level.heli_visual_range * 100;
    
    if ( isdefined( actor.owner ) )
    {
        if ( isdefined( heli.attacker ) && actor.owner == heli.attacker )
        {
            actor.threatlevel += 100;
        }
        
        if ( isdefined( actor.owner.carryobject ) )
        {
            actor.threatlevel += 200;
        }
        
        if ( isdefined( actor.owner.score ) )
        {
            actor.threatlevel += actor.owner.score * 4;
        }
        
        if ( isdefined( actor.owner.antithreat ) )
        {
            actor.threatlevel -= actor.owner.antithreat;
        }
    }
    
    if ( actor.threatlevel <= 0 )
    {
        actor.threatlevel = 1;
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0xeed185ea, Offset: 0xa2b8
// Size: 0x9c
function update_dog_threat( dog )
{
    heli = self;
    dog.threatlevel = 0;
    dist = distance( dog.origin, heli.origin );
    dog.threatlevel += ( level.heli_visual_range - dist ) / level.heli_visual_range * 100;
}

// Namespace killstreaks
// Params 1
// Checksum 0x85ccc1f4, Offset: 0xa360
// Size: 0xc8, Type: bool
function missile_valid_target_check( missiletarget )
{
    heli2target_normal = vectornormalize( missiletarget.origin - self.origin );
    heli2forward = anglestoforward( self.angles );
    heli2forward_normal = vectornormalize( heli2forward );
    heli_dot_target = vectordot( heli2target_normal, heli2forward_normal );
    
    if ( heli_dot_target >= level.heli_valid_target_cone )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreaks
// Params 1
// Checksum 0x730574f0, Offset: 0xa430
// Size: 0x198
function update_missile_player_threat( player )
{
    player.missilethreatlevel = 0;
    dist = distance( player.origin, self.origin );
    player.missilethreatlevel += ( level.heli_missile_range - dist ) / level.heli_missile_range * 100;
    
    if ( self missile_valid_target_check( player ) == 0 )
    {
        player.missilethreatlevel = 1;
        return;
    }
    
    if ( isdefined( self.attacker ) && player == self.attacker )
    {
        player.missilethreatlevel += 100;
    }
    
    player.missilethreatlevel += player.score * 4;
    
    if ( isdefined( player.antithreat ) )
    {
        player.missilethreatlevel -= player.antithreat;
    }
    
    if ( player.missilethreatlevel <= 0 )
    {
        player.missilethreatlevel = 1;
    }
}

// Namespace killstreaks
// Params 1
// Checksum 0xab39f369, Offset: 0xa5d0
// Size: 0x20
function update_missile_dog_threat( dog )
{
    dog.missilethreatlevel = 1;
}

// Namespace killstreaks
// Params 3
// Checksum 0xdf987d37, Offset: 0xa5f8
// Size: 0x3c
function killstreak_assist( victim, assister, killstreak )
{
    victim recordkillstreakassist( victim, assister, killstreak );
}

// Namespace killstreaks
// Params 4
// Checksum 0xb20a4538, Offset: 0xa640
// Size: 0x120
function add_ricochet_protection( killstreak_id, owner, origin, ricochet_distance )
{
    testing = 0;
    
    /#
        testing = getdvarint( "<dev string:x52f>", 0 ) == 2;
    #/
    
    if ( !level.hardcoremode && !testing )
    {
        return;
    }
    
    if ( !isdefined( ricochet_distance ) || ricochet_distance == 0 )
    {
        return;
    }
    
    if ( !isdefined( owner.ricochet_protection ) )
    {
        owner.ricochet_protection = [];
    }
    
    owner.ricochet_protection[ killstreak_id ] = spawnstruct();
    owner.ricochet_protection[ killstreak_id ].origin = origin;
    owner.ricochet_protection[ killstreak_id ].distancesq = ricochet_distance * ricochet_distance;
}

// Namespace killstreaks
// Params 3
// Checksum 0xe88739c6, Offset: 0xa768
// Size: 0x8c
function set_ricochet_protection_endtime( killstreak_id, owner, endtime )
{
    if ( !isdefined( owner ) || !isdefined( owner.ricochet_protection ) || !isdefined( killstreak_id ) )
    {
        return;
    }
    
    if ( !isdefined( owner.ricochet_protection[ killstreak_id ] ) )
    {
        return;
    }
    
    owner.ricochet_protection[ killstreak_id ].endtime = endtime;
}

// Namespace killstreaks
// Params 2
// Checksum 0xf445f071, Offset: 0xa800
// Size: 0x58
function remove_ricochet_protection( killstreak_id, owner )
{
    if ( !isdefined( owner ) || !isdefined( owner.ricochet_protection ) || !isdefined( killstreak_id ) )
    {
        return;
    }
    
    owner.ricochet_protection[ killstreak_id ] = undefined;
}

// Namespace killstreaks
// Params 1
// Checksum 0xeb5cf3f0, Offset: 0xa860
// Size: 0x12a, Type: bool
function is_ricochet_protected( player )
{
    if ( !isdefined( player ) || !isdefined( player.ricochet_protection ) )
    {
        return false;
    }
    
    foreach ( protection in player.ricochet_protection )
    {
        if ( !isdefined( protection ) )
        {
            continue;
        }
        
        if ( isdefined( protection.endtime ) && protection.endtime < gettime() )
        {
            continue;
        }
        
        if ( distancesquared( protection.origin, player.origin ) < protection.distancesq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killstreaks
// Params 0
// Checksum 0xd23085df, Offset: 0xa998
// Size: 0x22, Type: bool
function is_killstreak_start_blocked()
{
    return isdefined( self.dart_thrown_time ) && gettime() - self.dart_thrown_time < 1500;
}

/#

    // Namespace killstreaks
    // Params 0
    // Checksum 0x2e3ce457, Offset: 0xa9c8
    // Size: 0x2cc, Type: dev
    function debug_ricochet_protection()
    {
        debug_wait = 0.5;
        debug_frames = int( debug_wait / 0.05 ) + 1;
        
        while ( true )
        {
            if ( getdvarint( "<dev string:x52f>", 0 ) == 0 )
            {
                wait 2;
                continue;
            }
            
            wait debug_wait;
            
            foreach ( player in level.players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( !isdefined( player.ricochet_protection ) )
                {
                    continue;
                }
                
                foreach ( protection in player.ricochet_protection )
                {
                    if ( !isdefined( protection ) )
                    {
                        continue;
                    }
                    
                    if ( isdefined( protection.endtime ) && protection.endtime < gettime() )
                    {
                        continue;
                    }
                    
                    radius = sqrt( protection.distancesq );
                    sphere( protection.origin, radius, ( 1, 1, 0 ), 0.25, 0, 36, debug_frames );
                    circle( protection.origin, radius, ( 1, 0.5, 0 ), 0, 1, debug_frames );
                    circle( protection.origin + ( 0, 0, 2 ), radius, ( 1, 0.5, 0 ), 0, 1, debug_frames );
                }
            }
        }
    }

#/
