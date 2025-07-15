#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_bouncingbetty;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_placeable_mine;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_octobomb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_genesis_apothican;
#using scripts/zm/zm_genesis_ee_quest;
#using scripts/zm/zm_genesis_portals;
#using scripts/zm/zm_genesis_sound;
#using scripts/zm/zm_genesis_util;

#namespace zm_genesis_minor_ee;

// Namespace zm_genesis_minor_ee
// Params 0, eflags: 0x2
// Checksum 0xa11127f7, Offset: 0x8b0
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_genesis_minor_ee", &__init__, &__main__, undefined );
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x2c47c832, Offset: 0x8f8
// Size: 0x3c
function __init__()
{
    level flag::init( "old_school_activated" );
    level.func_override_wallbuy_prompt = &function_bc56f047;
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x35a8e12c, Offset: 0x940
// Size: 0xe4
function __main__()
{
    /#
        if ( getdvarint( "<dev string:x28>" ) > 0 )
        {
            level thread function_1d13619e();
        }
    #/
    
    level waittill( #"start_zombie_round_logic" );
    
    if ( getdvarint( "splitscreen_playerCount" ) > 2 )
    {
        return;
    }
    
    level thread lil_arnie_upgrade();
    level thread function_be8c2f38();
    level thread function_5af98f35();
    level thread function_45bc2e15();
    level thread function_92b4b156();
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0xf9ea010f, Offset: 0xa30
// Size: 0x24
function function_45bc2e15()
{
    level flag::init( "writing_on_the_wall_complete" );
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x23a27e30, Offset: 0xa60
// Size: 0x7c4
function function_92b4b156()
{
    level flag::wait_till( "writing_on_the_wall_complete" );
    var_cb382f = struct::get( "weapon_swapper_model", "targetname" );
    var_cb382f.angles = ( 0, 90, 0 );
    s_fx_pos = struct::get( "weapon_swapper_fx", "targetname" );
    v_fx_pos = s_fx_pos.origin;
    var_c59a59e1 = 0;
    var_3bb6997f = undefined;
    var_81f963f4 = spawn( "trigger_radius_use", var_cb382f.origin, 0, 100, 100 );
    var_81f963f4 sethintstring( "" );
    var_81f963f4 setcursorhint( "HINT_NOICON" );
    var_81f963f4 triggerignoreteam();
    var_81f963f4 usetriggerrequirelookat();
    exploder::exploder( "fxexp_114 " );
    
    while ( true )
    {
        switch ( var_c59a59e1 )
        {
            case 0:
                var_81f963f4 waittill( #"trigger", trigplayer );
                
                if ( isplayer( trigplayer ) && !trigplayer laststand::player_is_in_laststand() && !( trigplayer.is_drinking > 0 ) )
                {
                    var_3bb6997f = trigplayer getcurrentweapon();
                    
                    if ( !trigplayer hasweapon( var_3bb6997f ) )
                    {
                        continue;
                    }
                    
                    b_valid_weapon = trigplayer function_a5a542a( var_3bb6997f, var_c59a59e1 );
                    
                    if ( !b_valid_weapon )
                    {
                        continue;
                    }
                    
                    /#
                        iprintlnbold( "<dev string:x35>" );
                    #/
                    
                    var_f17eaf0 = trigplayer getweaponammostock( var_3bb6997f );
                    var_5b3694f6 = trigplayer getweaponammoclip( var_3bb6997f );
                    var_be26f631 = trigplayer getweaponammoclip( var_3bb6997f.dualwieldweapon );
                    var_c02edaaf = trigplayer getbuildkitweaponoptions( var_3bb6997f );
                    var_5c2e5267 = trigplayer getbuildkitattachmentcosmeticvariantindexes( var_3bb6997f );
                    trigplayer takeweapon( var_3bb6997f );
                    trigplayer zm_weapons::switch_back_primary_weapon( undefined );
                    var_c59a59e1 = 1;
                    var_81f963f4 sethintstring( "" );
                    
                    if ( isdefined( trigplayer.var_fb11234e ) && trigplayer.var_fb11234e == zm_weapons::get_base_weapon( var_3bb6997f ) )
                    {
                        var_3bb6997f = trigplayer.var_fb11234e;
                    }
                    
                    level.var_3bb6997f = var_3bb6997f;
                    e_model = zm_utility::spawn_buildkit_weapon_model( trigplayer, var_3bb6997f, undefined, var_cb382f.origin, var_cb382f.angles );
                    
                    if ( var_3bb6997f.isdualwield )
                    {
                        var_1166f70b = var_3bb6997f;
                        
                        if ( isdefined( var_3bb6997f.dualwieldweapon ) && var_3bb6997f.dualwieldweapon != level.weaponnone )
                        {
                            var_1166f70b = var_3bb6997f.dualwieldweapon;
                        }
                        
                        var_624e83a3 = zm_utility::spawn_buildkit_weapon_model( trigplayer, var_1166f70b, undefined, var_cb382f.origin - ( 3, 3, 3 ), var_cb382f.angles );
                    }
                }
                
                break;
            case 1:
                e_model rotateroll( 360, 1 );
                
                if ( isdefined( var_624e83a3 ) )
                {
                    var_624e83a3 rotateroll( 360, 1 );
                }
                
                wait 1;
                var_c59a59e1 = 2;
                var_81f963f4 sethintstring( "" );
                break;
            case 2:
                var_81f963f4 waittill( #"trigger", trigplayer );
                
                if ( isplayer( trigplayer ) && !trigplayer laststand::player_is_in_laststand() && !( trigplayer.is_drinking > 0 ) )
                {
                    b_valid_weapon = trigplayer function_a5a542a( var_3bb6997f, var_c59a59e1 );
                    
                    if ( !b_valid_weapon )
                    {
                        continue;
                    }
                    
                    /#
                        iprintlnbold( "<dev string:x53>" );
                    #/
                    
                    weapon_limit = zm_utility::get_player_weapon_limit( trigplayer );
                    trigplayer zm_weapons::weapon_give( var_3bb6997f );
                    trigplayer setweaponammostock( var_3bb6997f, var_f17eaf0 );
                    trigplayer setweaponammoclip( var_3bb6997f, var_5b3694f6 );
                    trigplayer setweaponammoclip( var_3bb6997f.dualwieldweapon, var_be26f631 );
                    level.var_3bb6997f = undefined;
                    var_c59a59e1 = 3;
                    var_81f963f4 sethintstring( "" );
                    e_model delete();
                    
                    if ( isdefined( var_624e83a3 ) )
                    {
                        var_624e83a3 delete();
                    }
                }
                
                break;
            case 3:
                wait 1;
                var_c59a59e1 = 0;
                var_81f963f4 sethintstring( "" );
                break;
        }
        
        wait 0.05;
    }
}

// Namespace zm_genesis_minor_ee
// Params 2
// Checksum 0x22c6a9f2, Offset: 0x1230
// Size: 0x11e, Type: bool
function function_a5a542a( var_3bb6997f, var_c59a59e1 )
{
    if ( self bgb::is_enabled( "zm_bgb_disorderly_combat" ) )
    {
        return false;
    }
    
    if ( zm_utility::is_hero_weapon( var_3bb6997f ) )
    {
        return false;
    }
    
    if ( zm_equipment::is_equipment( var_3bb6997f ) )
    {
        return false;
    }
    
    if ( zm_utility::is_placeable_mine( var_3bb6997f ) )
    {
        return false;
    }
    
    if ( self zm_utility::has_powerup_weapon() )
    {
        return false;
    }
    
    var_26e1938e = self getweaponslistprimaries();
    
    if ( var_c59a59e1 == 0 && var_26e1938e.size < 2 )
    {
        return false;
    }
    
    if ( var_c59a59e1 == 2 && self zm_weapons::has_weapon_or_upgrade( var_3bb6997f ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0xa01b2e30, Offset: 0x1358
// Size: 0x74
function function_5af98f35()
{
    var_38d3be2e = getent( "smg_thompson_wallbuy_chalk", "targetname" );
    var_38d3be2e hide();
    level chalk_pickup();
    level thread function_ff9395ca();
}

/#

    // Namespace zm_genesis_minor_ee
    // Params 0
    // Checksum 0x2d353f26, Offset: 0x13d8
    // Size: 0xca, Type: dev
    function function_e1963311()
    {
        var_5dfe3e = getent( "<dev string:x78>", "<dev string:x84>" );
        
        if ( !isdefined( var_5dfe3e ) )
        {
            return;
        }
        
        var_5dfe3e delete();
        iprintln( "<dev string:x8f>" );
        e_who = getplayers()[ 0 ];
        e_who.var_fb4f9b70 = 1;
        level.var_6d7c54f9 = "<dev string:xb5>";
        level notify( #"hash_94556ac9" );
    }

#/

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0xccf2985e, Offset: 0x14b0
// Size: 0x13e
function chalk_pickup()
{
    level endon( #"hash_94556ac9" );
    var_6fdae6db = struct::get( "chalk_pickup", "targetname" );
    var_6fdae6db zm_unitrigger::create_unitrigger( undefined, 128 );
    var_6fdae6db waittill( #"trigger_activated", e_who );
    e_who playsound( "zmb_minor_writing_chalk_pickup" );
    var_5dfe3e = getent( "chalk_model", "targetname" );
    var_5dfe3e ghost();
    
    /#
        iprintln( "<dev string:x8f>" );
    #/
    
    e_who.var_fb4f9b70 = 1;
    e_who thread function_7367d2c6();
    
    if ( !isdefined( level.var_6d7c54f9 ) )
    {
        level.var_6d7c54f9 = "tag_origin";
    }
    
    level notify( #"hash_94556ac9" );
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0xc51594bd, Offset: 0x15f8
// Size: 0x74
function function_7367d2c6()
{
    level endon( #"writing_on_the_wall_complete" );
    self waittill( #"disconnect" );
    var_5dfe3e = getent( "chalk_model", "targetname" );
    var_5dfe3e show();
    level thread chalk_pickup();
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x50106055, Offset: 0x1678
// Size: 0x112
function function_ff9395ca()
{
    level.var_61d84403 = [];
    var_eb751e53 = struct::get_array( "writing_trigger", "targetname" );
    
    foreach ( var_2ac294d8 in var_eb751e53 )
    {
        var_3cbdaba3 = getent( var_2ac294d8.target, "targetname" );
        array::add( level.var_61d84403, var_3cbdaba3 );
        var_2ac294d8 thread function_a8fc7a77();
    }
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x9bae78f8, Offset: 0x1798
// Size: 0x150
function function_a8fc7a77()
{
    level endon( #"writing_on_the_wall_complete" );
    self zm_unitrigger::create_unitrigger( undefined, 128 );
    var_3cbdaba3 = getent( self.target, "targetname" );
    
    while ( true )
    {
        self waittill( #"trigger_activated", e_player );
        
        if ( isdefined( e_player.var_fb4f9b70 ) && e_player.var_fb4f9b70 )
        {
            var_5d3ba118 = level.var_6d7c54f9;
            
            if ( level.var_6d7c54f9 == "tag_origin" )
            {
                e_player playsound( "zmb_minor_writing_erase" );
            }
            else
            {
                e_player playsound( "zmb_minor_writing_write" );
            }
            
            level.var_6d7c54f9 = var_3cbdaba3.model;
            var_3cbdaba3 setmodel( var_5d3ba118 );
            level thread function_d0f8a867();
        }
    }
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0xc1f232a2, Offset: 0x18f0
// Size: 0x244
function function_d0f8a867()
{
    b_complete = 1;
    
    foreach ( var_3cbdaba3 in level.var_61d84403 )
    {
        switch ( var_3cbdaba3.targetname )
        {
            default:
                if ( var_3cbdaba3.model != "p7_zm_gen_writing_ver_wishing" )
                {
                    b_complete = 0;
                }
                
                break;
            case "ndu_writing_1":
                if ( var_3cbdaba3.model != "p7_zm_gen_writing_nac_salvation" )
                {
                    b_complete = 0;
                }
                
                break;
            case "ndu_writing_2":
                if ( var_3cbdaba3.model != "p7_zm_gen_writing_nac_ascend" )
                {
                    b_complete = 0;
                }
                
                break;
            case "undercroft_writing":
                if ( var_3cbdaba3.model != "tag_origin" )
                {
                    b_complete = 0;
                }
                
                break;
            case "prison_writing":
                if ( var_3cbdaba3.model != "p7_zm_gen_writing_mob_soul_alone" )
                {
                    b_complete = 0;
                }
                
                break;
            case "theatre_writing":
                if ( var_3cbdaba3.model != "p7_zm_gen_writing_kin_scrawl_know" )
                {
                    b_complete = 0;
                }
                
                break;
        }
    }
    
    if ( b_complete )
    {
        playsoundatposition( "zmb_minor_complete", ( 0, 0, 0 ) );
        level flag::set( "writing_on_the_wall_complete" );
        var_38d3be2e = getent( "smg_thompson_wallbuy_chalk", "targetname" );
        var_38d3be2e show();
    }
}

// Namespace zm_genesis_minor_ee
// Params 1
// Checksum 0xb3dec32, Offset: 0x1b40
// Size: 0xc4, Type: bool
function function_bc56f047( e_player )
{
    if ( self.weapon.name == "smg_thompson" )
    {
        if ( level flag::get( "writing_on_the_wall_complete" ) )
        {
            return true;
        }
        else
        {
            self.stub.hint_string = "";
            self sethintstring( "" );
            self.stub.cursor_hint = "HINT_NOICON";
            self setcursorhint( "HINT_NOICON" );
            return false;
        }
    }
    
    return true;
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x855b2fd, Offset: 0x1c10
// Size: 0x208
function lil_arnie_upgrade()
{
    level.var_f11300cd = 0;
    level flag::init( "lil_arnie_prereq_done" );
    level flag::init( "lil_arnie_done" );
    
    /#
        if ( getdvarint( "<dev string:x28>" ) > 0 )
        {
            level.var_f11300cd = 99;
        }
    #/
    
    zm_spawner::register_zombie_death_event_callback( &function_4a0f0038 );
    level flag::wait_till( "lil_arnie_prereq_done" );
    zm_spawner::deregister_zombie_death_event_callback( &function_4a0f0038 );
    level.check_b_valid_poi = &zm_genesis_ee_quest::function_5516baeb;
    level flag::wait_till( "lil_arnie_done" );
    
    foreach ( player in level.activeplayers )
    {
        if ( player hasweapon( level.w_octobomb ) )
        {
            player _zm_weap_octobomb::player_give_octobomb( "octobomb_upgraded" );
        }
    }
    
    level.zombie_weapons[ level.w_octobomb ].is_in_box = 0;
    level.zombie_weapons[ level.w_octobomb_upgraded ].is_in_box = 1;
}

// Namespace zm_genesis_minor_ee
// Params 3
// Checksum 0x2ebf350c, Offset: 0x1e20
// Size: 0x76
function function_4a0f0038( e_attacker, str_means_of_death, weapon )
{
    if ( self.damageweapon === level.w_octobomb )
    {
        level.var_f11300cd++;
        
        if ( level.var_f11300cd >= 100 )
        {
            level flag::set( "lil_arnie_prereq_done" );
            
            if ( isdefined( e_attacker ) )
            {
            }
        }
    }
}

// Namespace zm_genesis_minor_ee
// Params 1
// Checksum 0x6fee95cb, Offset: 0x1ea0
// Size: 0x1aa
function function_131a352c( b_valid_poi )
{
    s_target = struct::get( "lil_arnie_upgrade", "targetname" );
    
    if ( distancesquared( self.origin, s_target.origin ) < 7225 )
    {
        self.origin = s_target.origin;
        self.angles += ( 90, 0, 90 );
        self.clone_model ghost();
        self.anim_model = util::spawn_model( level.mdl_octobomb, self.origin, ( 0, 0, 0 ) );
        self.anim_model linkto( self.clone_model );
        self.anim_model clientfield::set( "octobomb_fx", 3 );
        wait 0.05;
        self.anim_model clientfield::set( "octobomb_fx", 1 );
        self thread _zm_weap_octobomb::animate_octobomb( 0 );
        wait 2;
        self.anim_model thread function_bf3603f7();
        return 0;
    }
    
    return b_valid_poi;
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x9e6a6b9d, Offset: 0x2058
// Size: 0x3c
function function_bf3603f7()
{
    wait 1;
    self zm_utility::self_delete();
    level flag::set( "lil_arnie_done" );
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x4b7270af, Offset: 0x20a0
// Size: 0xf4
function function_be8c2f38()
{
    level.var_aa421b74 = [];
    level.var_557b53fd = [];
    level.var_557b53fd[ 1 ] = 25;
    level.var_557b53fd[ 2 ] = 15;
    level.var_557b53fd[ 3 ] = 12;
    level.var_557b53fd[ 4 ] = 2;
    level.var_8091d507 = 0;
    a_s_switches = struct::get_array( "old_school_switch" );
    array::thread_all( a_s_switches, &function_6e14903b );
    
    while ( level.var_8091d507 < a_s_switches.size )
    {
        wait 0.05;
    }
    
    level thread function_77da8ee0();
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x4a3b90cf, Offset: 0x21a0
// Size: 0x144
function function_6e14903b()
{
    level endon( #"old_school_activated" );
    level.var_c592ecc1 = 0;
    s_unitrigger = self zm_unitrigger::create_unitrigger( &"", 64, &function_b2869a31 );
    s_unitrigger.require_look_at = 1;
    s_unitrigger.b_enabled = 1;
    array::add( level.var_aa421b74, s_unitrigger );
    
    while ( true )
    {
        self waittill( #"trigger_activated", e_player );
        
        if ( s_unitrigger.b_enabled == 1 )
        {
            playsoundatposition( "zmb_minor_skool_button", s_unitrigger.origin );
            
            if ( level.var_c592ecc1 == 0 )
            {
                level thread function_2d1b88ec();
                level.var_c592ecc1 = 1;
            }
            
            s_unitrigger.b_enabled = 0;
            level.var_8091d507++;
        }
    }
}

// Namespace zm_genesis_minor_ee
// Params 1
// Checksum 0x6579764f, Offset: 0x22f0
// Size: 0x12e
function function_b2869a31( e_player )
{
    if ( self.stub.b_enabled )
    {
        foreach ( e_player in level.players )
        {
            self setvisibletoplayer( e_player );
        }
        
        return 1;
    }
    
    foreach ( e_player in level.players )
    {
        self setinvisibletoplayer( e_player );
    }
    
    return 0;
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x815c4915, Offset: 0x2428
// Size: 0xd2
function function_2d1b88ec()
{
    level endon( #"hash_b442f53" );
    level endon( #"old_school_activated" );
    wait level.var_557b53fd[ level.players.size ];
    level.var_c592ecc1 = 0;
    level.var_8091d507 = 0;
    
    foreach ( s_unitrigger in level.var_aa421b74 )
    {
        s_unitrigger.b_enabled = 1;
    }
    
    level notify( #"hash_b442f53" );
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0xb1efb21, Offset: 0x2508
// Size: 0xdc
function function_77da8ee0()
{
    level flag::set( "old_school_activated" );
    playsoundatposition( "zmb_minor_skool_complete", ( 0, 0, 0 ) );
    
    foreach ( s_unitrigger in level.var_aa421b74 )
    {
        s_unitrigger.b_enabled = 0;
    }
    
    level thread zm_genesis_sound::function_b18c11d8();
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0xcdfce9a0, Offset: 0x25f0
// Size: 0x34
function function_a1f4f500()
{
    level._bouncingbettywatchfortrigger = &function_82df6cd4;
    level thread function_f227a0ab();
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x99ec1590, Offset: 0x2630
// Size: 0x4
function function_f227a0ab()
{
    
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0xa19b757a, Offset: 0x2640
// Size: 0x194
function function_c1ccaae0()
{
    var_11f2bc16 = getent( "gateworm_asteroid", "targetname" );
    mdl_egg = util::spawn_model( "gateworm", var_11f2bc16.origin );
    var_11f2bc16 delete();
    var_2b641c49 = struct::get( "egg_destination", "targetname" );
    mdl_egg moveto( var_2b641c49.origin, 3 );
    mdl_egg waittill( #"movedone" );
    var_6d268157 = var_2b641c49 zm_unitrigger::create_unitrigger( undefined, 64 );
    
    while ( true )
    {
        var_2b641c49 waittill( #"trigger_activated", e_who );
        
        if ( !e_who flag::get( "holding_egg" ) )
        {
            break;
        }
    }
    
    e_who.var_7f70ccd5 = 1;
    zm_unitrigger::unregister_unitrigger( var_6d268157 );
    mdl_egg delete();
    level thread function_ee1274a2();
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0xc15cb84b, Offset: 0x27e0
// Size: 0x19c
function function_ee1274a2()
{
    var_9c1e0e1a = struct::get( "pot_trigger", "targetname" );
    var_a0069a05 = var_9c1e0e1a zm_unitrigger::create_unitrigger( undefined, 64 );
    
    while ( true )
    {
        var_9c1e0e1a waittill( #"trigger_activated", e_who );
        
        if ( isdefined( e_who.var_7f70ccd5 ) && e_who.var_7f70ccd5 )
        {
            break;
        }
    }
    
    var_ed0817e0 = struct::get( "egg_pot_location", "targetname" );
    mdl_egg = util::spawn_model( "gateworm", var_ed0817e0.origin );
    level waittill( #"start_of_round" );
    level waittill( #"start_of_round" );
    level waittill( #"start_of_round" );
    
    while ( true )
    {
        var_9c1e0e1a waittill( #"trigger_activated", e_who );
        
        if ( isdefined( e_who.var_7f70ccd5 ) && e_who.var_7f70ccd5 )
        {
            break;
        }
    }
    
    zm_unitrigger::unregister_unitrigger( var_a0069a05 );
    level thread function_16401ba8();
}

// Namespace zm_genesis_minor_ee
// Params 0
// Checksum 0x99ec1590, Offset: 0x2988
// Size: 0x4
function function_16401ba8()
{
    
}

// Namespace zm_genesis_minor_ee
// Params 1
// Checksum 0x7c5bb7a2, Offset: 0x2998
// Size: 0xa4
function function_82df6cd4( watcher )
{
    self endon( #"death" );
    self endon( #"hacked" );
    self endon( #"kill_target_detection" );
    e_trigger = getent( "gateworm_meteor_trigger", "targetname" );
    
    while ( true )
    {
        if ( self istouching( e_trigger ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    level thread function_c1ccaae0();
}

/#

    // Namespace zm_genesis_minor_ee
    // Params 0
    // Checksum 0x6adde37a, Offset: 0x2a48
    // Size: 0xec, Type: dev
    function function_1d13619e()
    {
        level thread zm_genesis_util::setup_devgui_func( "<dev string:xc0>", "<dev string:xdf>", 1, &function_6cd2074 );
        level thread zm_genesis_util::setup_devgui_func( "<dev string:xea>", "<dev string:x117>", 1, &function_7c5650a5 );
        level thread zm_genesis_util::setup_devgui_func( "<dev string:x127>", "<dev string:x15a>", 1, &function_c3100cb0 );
        level thread zm_genesis_util::setup_devgui_func( "<dev string:x166>", "<dev string:x196>", 1, &function_e1963311 );
    }

    // Namespace zm_genesis_minor_ee
    // Params 1
    // Checksum 0x11782362, Offset: 0x2b40
    // Size: 0x2c, Type: dev
    function function_7c5650a5( n_val )
    {
        level flag::set( "<dev string:x1aa>" );
    }

    // Namespace zm_genesis_minor_ee
    // Params 1
    // Checksum 0xf6ce8395, Offset: 0x2b78
    // Size: 0x24, Type: dev
    function function_6cd2074( n_val )
    {
        level thread function_77da8ee0();
    }

    // Namespace zm_genesis_minor_ee
    // Params 1
    // Checksum 0x696291ae, Offset: 0x2ba8
    // Size: 0x2c, Type: dev
    function function_c3100cb0( n_val )
    {
        level flag::set( "<dev string:x1c0>" );
    }

#/
