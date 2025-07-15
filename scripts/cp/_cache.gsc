#using scripts/cp/_skipto;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons_shared;

#namespace cache;

// Namespace cache
// Params 0, eflags: 0x2
// Checksum 0x6f879fc8, Offset: 0x2e0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "cache", &__init__, undefined, undefined );
}

// Namespace cache
// Params 0
// Checksum 0x1dfcdc5a, Offset: 0x320
// Size: 0xa4
function __init__()
{
    a_ammo_crates = getentarray( "sys_ammo_cache", "targetname" );
    array::thread_all( a_ammo_crates, &_setup_ammo_cache );
    a_weapon_crates = getentarray( "sys_weapon_cache", "targetname" );
    array::thread_all( a_weapon_crates, &_setup_weapon_cache );
}

// Namespace cache
// Params 0
// Checksum 0xf33394be, Offset: 0x3d0
// Size: 0x80
function _setup_ammo_cache()
{
    util::waittill_asset_loaded( "xmodel", self.model );
    self thread _ammo_refill_think();
    
    if ( self.model != "p6_ammo_resupply_future_01" && self.model != "p6_ammo_resupply_80s_final_01" )
    {
    }
    
    if ( isdefined( level._ammo_refill_think_alt ) )
    {
        self thread [[ level._ammo_refill_think_alt ]]();
    }
}

// Namespace cache
// Params 0
// Checksum 0x95af93a6, Offset: 0x458
// Size: 0x74
function _setup_weapon_cache()
{
    util::waittill_asset_loaded( "xmodel", self.model );
    level flag::wait_till( "all_players_connected" );
    self thread _place_player_loadout();
    self thread _check_extra_slots();
}

// Namespace cache
// Params 0
// Checksum 0x6db1becd, Offset: 0x4d8
// Size: 0x260
function _ammo_refill_think()
{
    self endon( #"disable_ammo_cache" );
    t_ammo_cache = self _get_closest_ammo_trigger();
    
    if ( isdefined( t_ammo_cache.script_string ) && t_ammo_cache.script_string == "no_grenade" )
    {
        t_ammo_cache.no_grenade = 1;
    }
    
    t_ammo_cache sethintstring( &"SCRIPT_AMMO_REFILL" );
    t_ammo_cache setcursorhint( "HINT_NOICON" );
    
    while ( true )
    {
        t_ammo_cache waittill( #"trigger", e_player );
        e_player disableweapons();
        e_player playsound( "fly_ammo_crate_refill" );
        wait 2;
        a_weapons = e_player getweaponslist();
        
        foreach ( weapon in a_weapons )
        {
            if ( isdefined( t_ammo_cache.no_grenade ) && t_ammo_cache.no_grenade && weapons::is_grenade( weapon ) )
            {
                continue;
            }
            
            e_player givemaxammo( weapon );
            e_player setweaponammoclip( weapon, weapon.clipsize );
        }
        
        e_player enableweapons();
        e_player notify( #"ammo_refilled" );
    }
}

// Namespace cache
// Params 0
// Checksum 0xc914fb1, Offset: 0x740
// Size: 0x5c
function _get_closest_ammo_trigger()
{
    a_ammo_cache = getentarray( "trigger_ammo_cache", "targetname" );
    t_ammo_cache = arraygetclosest( self.origin, a_ammo_cache );
    return t_ammo_cache;
}

// Namespace cache
// Params 0
// Checksum 0xe3eff64d, Offset: 0x7a8
// Size: 0x588
function _place_player_loadout()
{
    w_primary_weapon = level.players[ 0 ] getloadoutweapon( 0, "primary" );
    w_secondary_weapon = level.players[ 0 ] getloadoutweapon( 0, "secondary" );
    v_basic_offset = ( -5, 0, 15 );
    v_full_offset = ( -10, 0, 15 );
    v_model_offset = ( 0, 0, 15 );
    n_offset_multiplier = 0;
    w_primary_weapon_base = w_primary_weapon.rootweapon;
    
    if ( w_primary_weapon_base != level.weaponnull && isassetloaded( "weapon", w_primary_weapon_base.name ) )
    {
        primary_weapon_pos = self gettagorigin( "loadOut_B" );
        tmp_offset = anglestoright( self gettagangles( "loadOut_B" ) ) * n_offset_multiplier;
        m_weapon_script_model = spawn( "weapon_" + w_primary_weapon.name + level.game_mode_suffix, primary_weapon_pos + tmp_offset + v_model_offset, 8 );
        m_weapon_script_model.angles = self gettagangles( "loadOut_B" ) + ( 0, -90, 0 );
    }
    else if ( isassetloaded( "weapon", "hk416" + level.game_mode_suffix ) )
    {
        primary_weapon_pos = self gettagorigin( "loadOut_B" );
        tmp_offset = anglestoright( self gettagangles( "loadOut_B" ) ) * n_offset_multiplier;
        m_weapon_script_model = spawn( "weapon_" + "ar_standard" + level.game_mode_suffix, primary_weapon_pos + tmp_offset + v_model_offset, 8 );
        m_weapon_script_model.angles = self gettagangles( "loadOut_B" ) + ( 0, -90, 0 );
    }
    
    switch ( self.model )
    {
        case "p6_weapon_resupply_future_01":
        case "p6_weapon_resupply_future_02":
            n_offset_multiplier = -3;
            break;
        default:
            n_offset_multiplier = -4;
            break;
    }
    
    w_secondary_weapon_base = w_secondary_weapon.rootweapon;
    
    if ( w_secondary_weapon_base != level.weaponnull && isassetloaded( "weapon", w_secondary_weapon_base.name ) )
    {
        secondary_weapon_pos = self gettagorigin( "loadOut_A" );
        tmp_offset = anglestoright( self gettagangles( "loadOut_A" ) ) * n_offset_multiplier;
        m_weapon_script_model = spawn( "weapon_" + w_secondary_weapon + level.game_mode_suffix, secondary_weapon_pos + tmp_offset + v_model_offset, 8 );
        m_weapon_script_model.angles = self gettagangles( "loadOut_A" ) + ( 0, -90, 0 );
        return;
    }
    
    if ( isassetloaded( "weapon", "smg_fastfire" + level.game_mode_suffix ) )
    {
        secondary_weapon_pos = self gettagorigin( "loadOut_A" );
        tmp_offset = anglestoright( self gettagangles( "loadOut_A" ) ) * n_offset_multiplier;
        m_weapon_script_model = spawn( "weapon_" + "smg_fastfire" + level.game_mode_suffix, secondary_weapon_pos + tmp_offset + v_model_offset, 8 );
        m_weapon_script_model.angles = self gettagangles( "loadOut_A" ) + ( 0, -90, 0 );
    }
}

// Namespace cache
// Params 0
// Checksum 0xc6864b5, Offset: 0xd38
// Size: 0x284
function _check_extra_slots()
{
    if ( isdefined( self.ac_slot1 ) )
    {
        auxilary_weapon_pos = self gettagorigin( "auxilary_A" );
        assert( isdefined( auxilary_weapon_pos ), "<dev string:x28>" );
        
        switch ( self.model )
        {
            default:
                tmp_offset = anglestoright( self gettagangles( "auxilary_A" ) ) * 5;
                break;
        }
        
        m_weapon_script_model = spawn( "weapon_" + self.ac_slot1 + level.game_mode_suffix, auxilary_weapon_pos + tmp_offset + ( 0, 0, 10 ), 8 );
        m_weapon_script_model.angles = self gettagangles( "auxilary_A" ) + ( 0, -90, 0 );
        m_weapon_script_model itemweaponsetammo( 9999, 9999 );
    }
    
    if ( isdefined( self.ac_slot2 ) )
    {
        auxilary_weapon_pos = self gettagorigin( "secondary_A" );
        assert( isdefined( auxilary_weapon_pos ), "<dev string:x28>" );
        tmp_offset = anglestoforward( self gettagangles( "secondary_A" ) ) * 10;
        m_weapon_script_model = spawn( "weapon_" + self.ac_slot2 + level.game_mode_suffix, auxilary_weapon_pos + tmp_offset + ( 0, 0, 10 ), 8 );
        m_weapon_script_model.angles = self gettagangles( "secondary_A" );
        m_weapon_script_model itemweaponsetammo( 9999, 9999 );
    }
}

/#

    // Namespace cache
    // Params 0
    // Checksum 0x1aa4595d, Offset: 0xfc8
    // Size: 0x142, Type: dev
    function _debug_tags()
    {
        tag_array = [];
        tag_array[ tag_array.size ] = "<dev string:x6d>";
        tag_array[ tag_array.size ] = "<dev string:x74>";
        tag_array[ tag_array.size ] = "<dev string:x7b>";
        tag_array[ tag_array.size ] = "<dev string:x86>";
        tag_array[ tag_array.size ] = "<dev string:x91>";
        tag_array[ tag_array.size ] = "<dev string:x99>";
        tag_array[ tag_array.size ] = "<dev string:xa3>";
        tag_array[ tag_array.size ] = "<dev string:xad>";
        
        foreach ( tag in tag_array )
        {
            self thread _loop_text( tag );
        }
    }

    // Namespace cache
    // Params 1
    // Checksum 0x7a265192, Offset: 0x1118
    // Size: 0x80, Type: dev
    function _loop_text( tag )
    {
        while ( true )
        {
            if ( isdefined( self gettagorigin( tag ) ) )
            {
                print3d( self gettagorigin( tag ), tag, ( 1, 1, 1 ), 1, 0.15 );
            }
            
            wait 0.05;
        }
    }

#/

// Namespace cache
// Params 1
// Checksum 0xc3cfcd6, Offset: 0x11a0
// Size: 0x104
function disable_ammo_cache( str_ammo_cache_id )
{
    a_ammo_cache = getentarray( str_ammo_cache_id, "script_noteworthy" );
    assert( isdefined( a_ammo_cache ), "<dev string:xb9>" + str_ammo_cache_id + "<dev string:xed>" );
    
    if ( a_ammo_cache.size > 1 )
    {
        assertmsg( "<dev string:x113>" + str_ammo_cache_id + "<dev string:x152>" );
    }
    
    a_ammo_cache[ 0 ] notify( #"disable_ammo_cache" );
    t_ammo_cache = a_ammo_cache[ 0 ] _get_closest_ammo_trigger();
    t_ammo_cache triggerenable( 0 );
}

// Namespace cache
// Params 2
// Checksum 0xc2c88761, Offset: 0x12b0
// Size: 0x2dc
function activate_extra_slot( n_slot_number, w_weapon )
{
    if ( n_slot_number < 1 || n_slot_number > 2 )
    {
        assertmsg( "<dev string:x174>" );
    }
    
    assert( isdefined( w_weapon ), "<dev string:x1a3>" );
    
    if ( n_slot_number == 1 )
    {
        auxilary_weapon_pos = self gettagorigin( "auxilary_A" );
        assert( isdefined( auxilary_weapon_pos ), "<dev string:x28>" );
        tmp_offset = anglestoright( self gettagangles( "auxilary_A" ) ) * 5;
        m_weapon_script_model = spawn( "weapon_" + w_weapon.name + level.game_mode_suffix, auxilary_weapon_pos + tmp_offset + ( 0, 0, 10 ), 8 );
        m_weapon_script_model.angles = self gettagangles( "auxilary_A" ) + ( 0, -90, 0 );
        m_weapon_script_model itemweaponsetammo( 9999, 9999 );
    }
    
    if ( n_slot_number == 2 )
    {
        auxilary_weapon_pos = self gettagorigin( "secondary_A" );
        assert( isdefined( auxilary_weapon_pos ), "<dev string:x1b9>" );
        tmp_offset = anglestoforward( self gettagangles( "secondary_A" ) ) * 7;
        m_weapon_script_model = spawn( "weapon_" + w_weapon.name + level.game_mode_suffix, auxilary_weapon_pos + tmp_offset + ( 0, 0, 10 ), 8 );
        m_weapon_script_model.angles = self gettagangles( "secondary_A" );
        m_weapon_script_model itemweaponsetammo( 9999, 9999 );
    }
}

// Namespace cache
// Params 0
// Checksum 0x4fb6a4fd, Offset: 0x1598
// Size: 0x234
function cleanup_cache()
{
    if ( issubstr( self.model, "p6_weapon_" ) )
    {
        a_weapons_list = [];
        a_item_list = getitemarray();
        
        foreach ( item in a_item_list )
        {
            if ( issubstr( item.classname, "weapon_" ) )
            {
                a_weapons_list[ a_weapons_list.size ] = item;
            }
        }
        
        n_weapon_counter = 2;
        
        if ( isdefined( self.ac_slot1 ) )
        {
            n_weapon_counter++;
        }
        
        if ( isdefined( self.ac_slot2 ) )
        {
            n_weapon_counter++;
        }
        
        for ( x = 0; x < n_weapon_counter ; x++ )
        {
            e_closest_weapon = arraygetclosest( self.origin, a_weapons_list, 50 );
            
            if ( isdefined( e_closest_weapon ) )
            {
                e_closest_weapon delete();
            }
        }
        
        self delete();
        return;
    }
    
    self notify( #"disable_ammo_cache" );
    t_ammo_trigger = _get_closest_ammo_trigger();
    
    if ( isdefined( t_ammo_trigger ) )
    {
        t_ammo_trigger delete();
    }
    
    self delete();
}

