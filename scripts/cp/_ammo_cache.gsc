#using scripts/codescripts/struct;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/shared/array_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace ammo_cache;

// Namespace ammo_cache
// Method(s) 11 Total 11
class cammocrate
{

    // Namespace cammocrate
    // Params 1
    // Checksum 0x52045c14, Offset: 0x1008
    // Size: 0x6c
    function function_71f6269a( var_bd13c94b )
    {
        self waittill( #"death" );
        self.gameobject gameobjects::destroy_object( 1 );
        self.gameobject delete();
        
        if ( isdefined( var_bd13c94b ) )
        {
            var_bd13c94b delete();
        }
    }

    // Namespace cammocrate
    // Params 1
    // Checksum 0x13613ccb, Offset: 0xe68
    // Size: 0x194
    function function_2902ab6c( var_60a09143 )
    {
        var_60a09143 endon( #"death" );
        
        if ( var_60a09143.var_ce22f999 )
        {
            return;
        }
        
        var_60a09143.var_ce22f999 = 1;
        var_60a09143 scene::play( "p7_fxanim_gp_ammo_resupply_02_open_bundle", var_60a09143 );
        wait 1;
        var_d3571721 = 1;
        
        while ( var_d3571721 > 0 )
        {
            var_d3571721 = 0;
            
            foreach ( e_player in level.players )
            {
                dist_sq = distancesquared( e_player.origin, var_60a09143.origin );
                
                if ( dist_sq <= 14400 )
                {
                    var_d3571721++;
                }
            }
            
            wait 0.5;
        }
        
        var_60a09143 scene::play( "p7_fxanim_gp_ammo_resupply_02_close_bundle", var_60a09143 );
        var_60a09143.var_ce22f999 = 0;
    }

    // Namespace cammocrate
    // Params 1
    // Checksum 0xd085a242, Offset: 0xdd8
    // Size: 0x88
    function function_e76edd0b( var_60a09143 )
    {
        self endon( #"death" );
        var_60a09143 endon( #"death" );
        
        while ( true )
        {
            self waittill( #"trigger", entity );
            
            if ( !isdefined( var_60a09143 ) )
            {
                break;
            }
            
            if ( isplayer( entity ) )
            {
                function_2902ab6c( var_60a09143 );
            }
        }
    }

    // Namespace cammocrate
    // Params 1
    // Checksum 0xa82182a2, Offset: 0xd90
    // Size: 0x26, Type: bool
    function _is_banned_refill_weapon( w_weapon )
    {
        switch ( w_weapon.name )
        {
            default:
                return true;
        }
    }

    // Namespace cammocrate
    // Params 1
    // Checksum 0x4982b758, Offset: 0xc08
    // Size: 0x17c
    function onuse( e_player )
    {
        a_w_weapons = e_player getweaponslist();
        
        foreach ( w_weapon in a_w_weapons )
        {
            if ( _is_banned_refill_weapon( w_weapon ) )
            {
                continue;
            }
            
            e_player givemaxammo( w_weapon );
            e_player setweaponammoclip( w_weapon, w_weapon.clipsize );
        }
        
        e_player notify( #"ammo_refilled" );
        e_player playrumbleonentity( "damage_light" );
        e_player util::_enableweapon();
        
        if ( self.single_use )
        {
            objective_clearentity( self.objectiveid );
            self gameobjects::destroy_object( 1, undefined, 1 );
        }
    }

    // Namespace cammocrate
    // Params 3
    // Checksum 0x39c03398, Offset: 0xbc0
    // Size: 0x3c
    function onenduse( team, e_player, b_result )
    {
        if ( !b_result )
        {
            e_player util::_enableweapon();
        }
    }

    // Namespace cammocrate
    // Params 1
    // Checksum 0x276b7bc3, Offset: 0xb70
    // Size: 0x44
    function onbeginuse( e_player )
    {
        e_player playsound( "fly_ammo_crate_refill" );
        e_player util::_disableweapon();
    }

    // Namespace cammocrate
    // Params 2
    // Checksum 0xb92ecb5b, Offset: 0xb08
    // Size: 0x5c
    function spawn_ammo_cache( origin, angles )
    {
        e_visual = util::spawn_model( "p6_ammo_resupply_future_01", origin, angles, 1 );
        init_ammo_cache( e_visual );
    }

    // Namespace cammocrate
    // Params 1
    // Checksum 0x1ee86ce1, Offset: 0x5b8
    // Size: 0x544
    function init_ammo_cache( mdl_ammo_cache )
    {
        t_use = spawn( "trigger_radius_use", mdl_ammo_cache.origin + ( 0, 0, 30 ), 0, 94, 64 );
        t_use triggerignoreteam();
        t_use setvisibletoall();
        t_use usetriggerrequirelookat();
        t_use setteamfortrigger( "none" );
        t_use setcursorhint( "HINT_INTERACTIVE_PROMPT" );
        t_use sethintstring( &"COOP_REFILL_AMMO" );
        
        if ( isdefined( mdl_ammo_cache.script_linkto ) )
        {
            moving_platform = getent( mdl_ammo_cache.script_linkto, "targetname" );
            mdl_ammo_cache linkto( moving_platform );
        }
        
        t_use enablelinkto();
        t_use linkto( mdl_ammo_cache );
        mdl_ammo_cache oed::enable_keyline( 1 );
        
        if ( mdl_ammo_cache.script_string === "single_use" )
        {
            s_ammo_cache_object = gameobjects::create_use_object( "any", t_use, array( mdl_ammo_cache ), ( 0, 0, 32 ), &"cp_ammo_box" );
        }
        else
        {
            s_ammo_cache_object = gameobjects::create_use_object( "any", t_use, array( mdl_ammo_cache ), ( 0, 0, 32 ), &"cp_ammo_crate" );
        }
        
        s_ammo_cache_object gameobjects::allow_use( "any" );
        s_ammo_cache_object gameobjects::set_use_text( &"COOP_AMMO_REFILL" );
        s_ammo_cache_object gameobjects::set_owner_team( "allies" );
        s_ammo_cache_object gameobjects::set_visible_team( "any" );
        s_ammo_cache_object.onuse = &onuse;
        s_ammo_cache_object.useweapon = undefined;
        s_ammo_cache_object.origin = mdl_ammo_cache.origin;
        s_ammo_cache_object.angles = s_ammo_cache_object.angles;
        
        if ( mdl_ammo_cache.script_string === "single_use" )
        {
            s_ammo_cache_object gameobjects::set_use_time( 0.75 );
            s_ammo_cache_object.onbeginuse = &onbeginuse;
            s_ammo_cache_object.onenduse = &onenduse;
            s_ammo_cache_object.single_use = 1;
        }
        else
        {
            s_ammo_cache_object gameobjects::set_use_time( 0.75 );
            s_ammo_cache_object.onbeginuse = &onbeginuse;
            s_ammo_cache_object.onenduse = &onenduse;
            s_ammo_cache_object.single_use = 0;
            mdl_ammo_cache.gameobject = s_ammo_cache_object;
            self.var_60a09143 = mdl_ammo_cache;
            self.var_60a09143.var_ce22f999 = 0;
            var_bd13c94b = spawn( "trigger_radius", t_use.origin, 0, 94, 64 );
            var_bd13c94b setvisibletoall();
            var_bd13c94b setteamfortrigger( "allies" );
            var_bd13c94b enablelinkto();
            var_bd13c94b linkto( mdl_ammo_cache );
            var_bd13c94b thread function_e76edd0b( self.var_60a09143 );
        }
        
        mdl_ammo_cache.gameobject = s_ammo_cache_object;
        mdl_ammo_cache thread function_71f6269a( var_bd13c94b );
    }

}

// Namespace ammo_cache
// Params 0, eflags: 0x2
// Checksum 0x33878d37, Offset: 0x330
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "cp_supply_manager", &__init__, &__main__, undefined );
}

// Namespace ammo_cache
// Params 0
// Checksum 0x99ec1590, Offset: 0x378
// Size: 0x4
function __init__()
{
    
}

// Namespace ammo_cache
// Params 0
// Checksum 0x647b572c, Offset: 0x388
// Size: 0x204
function __main__()
{
    wait 0.05;
    
    if ( isdefined( level.override_ammo_caches ) )
    {
        level thread [[ level.override_ammo_caches ]]();
        return;
    }
    
    level.n_ammo_cache_id = 31;
    a_mdl_ammo_cache = getentarray( "ammo_cache", "script_noteworthy" );
    
    foreach ( mdl_ammo_cache in a_mdl_ammo_cache )
    {
        ammo_cache = new cammocrate();
        [[ ammo_cache ]]->init_ammo_cache( mdl_ammo_cache );
    }
    
    a_s_ammo_cache = struct::get_array( "ammo_cache", "script_noteworthy" );
    
    foreach ( s_ammo_cache in a_s_ammo_cache )
    {
        ammo_cache = new cammocrate();
        [[ ammo_cache ]]->spawn_ammo_cache( s_ammo_cache.origin, s_ammo_cache.angles );
    }
    
    setdvar( "AmmoBoxPickupTime", 0.75 );
}

// Namespace ammo_cache
// Params 1
// Checksum 0x1c1e7f56, Offset: 0x12c0
// Size: 0x2c
function hide_waypoint( e_player )
{
    self.gameobject gameobjects::hide_waypoint( e_player );
}

// Namespace ammo_cache
// Params 1
// Checksum 0xbef11540, Offset: 0x12f8
// Size: 0x2c
function show_waypoint( e_player )
{
    self.gameobject gameobjects::show_waypoint( e_player );
}

