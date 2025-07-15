#using scripts/codescripts/struct;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_stats;

#namespace _zm_weap_ballistic_knife;

// Namespace _zm_weap_ballistic_knife
// Params 0
// Checksum 0x9d4d6aeb, Offset: 0x198
// Size: 0x1c
function init()
{
    if ( !isdefined( level.ballistic_knife_autorecover ) )
    {
        level.ballistic_knife_autorecover = 1;
    }
}

// Namespace _zm_weap_ballistic_knife
// Params 2
// Checksum 0x2cbfacf8, Offset: 0x1c0
// Size: 0x354
function on_spawn( watcher, player )
{
    player endon( #"death" );
    player endon( #"disconnect" );
    player endon( #"zmb_lost_knife" );
    level endon( #"game_ended" );
    self waittill( #"stationary", endpos, normal, angles, attacker, prey, bone );
    isfriendly = 0;
    
    if ( isdefined( endpos ) )
    {
        retrievable_model = spawn( "script_model", endpos );
        retrievable_model setmodel( "t6_wpn_ballistic_knife_projectile" );
        retrievable_model setowner( player );
        retrievable_model.owner = player;
        retrievable_model.angles = angles;
        retrievable_model.weapon = watcher.weapon;
        
        if ( isdefined( prey ) )
        {
            if ( isplayer( prey ) && player.team == prey.team )
            {
                isfriendly = 1;
            }
            else if ( isai( prey ) && player.team == prey.team )
            {
                isfriendly = 1;
            }
            
            if ( !isfriendly )
            {
                retrievable_model linkto( prey, bone );
                retrievable_model thread force_drop_knives_to_ground_on_death( player, prey );
            }
            else if ( isfriendly )
            {
                retrievable_model physicslaunch( normal, ( randomint( 10 ), randomint( 10 ), randomint( 10 ) ) );
                normal = ( 0, 0, 1 );
            }
        }
        
        watcher.objectarray[ watcher.objectarray.size ] = retrievable_model;
        
        if ( isfriendly )
        {
            retrievable_model waittill( #"stationary" );
        }
        
        retrievable_model thread drop_knives_to_ground( player );
        
        if ( isfriendly )
        {
            player notify( #"ballistic_knife_stationary", retrievable_model, normal );
        }
        else
        {
            player notify( #"ballistic_knife_stationary", retrievable_model, normal, prey );
        }
        
        retrievable_model thread wait_to_show_glowing_model( prey );
    }
}

// Namespace _zm_weap_ballistic_knife
// Params 1
// Checksum 0xa37d9a67, Offset: 0x520
// Size: 0x44
function wait_to_show_glowing_model( prey )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 2;
    self setmodel( "t6_wpn_ballistic_knife_projectile" );
}

// Namespace _zm_weap_ballistic_knife
// Params 2
// Checksum 0x449804a3, Offset: 0x570
// Size: 0x454
function on_spawn_retrieve_trigger( watcher, player )
{
    player endon( #"death" );
    player endon( #"disconnect" );
    player endon( #"zmb_lost_knife" );
    level endon( #"game_ended" );
    player waittill( #"ballistic_knife_stationary", retrievable_model, normal, prey );
    
    if ( !isdefined( retrievable_model ) )
    {
        return;
    }
    
    trigger_pos = [];
    
    if ( isplayer( prey ) || isdefined( prey ) && isai( prey ) )
    {
        trigger_pos[ 0 ] = prey.origin[ 0 ];
        trigger_pos[ 1 ] = prey.origin[ 1 ];
        trigger_pos[ 2 ] = prey.origin[ 2 ] + 10;
    }
    else
    {
        trigger_pos[ 0 ] = retrievable_model.origin[ 0 ] + 10 * normal[ 0 ];
        trigger_pos[ 1 ] = retrievable_model.origin[ 1 ] + 10 * normal[ 1 ];
        trigger_pos[ 2 ] = retrievable_model.origin[ 2 ] + 10 * normal[ 2 ];
    }
    
    if ( isdefined( level.ballistic_knife_autorecover ) && level.ballistic_knife_autorecover )
    {
        trigger_pos[ 2 ] -= 50;
        pickup_trigger = spawn( "trigger_radius", ( trigger_pos[ 0 ], trigger_pos[ 1 ], trigger_pos[ 2 ] ), 0, 50, 100 );
    }
    else
    {
        pickup_trigger = spawn( "trigger_radius_use", ( trigger_pos[ 0 ], trigger_pos[ 1 ], trigger_pos[ 2 ] ) );
        pickup_trigger setcursorhint( "HINT_NOICON" );
    }
    
    pickup_trigger.owner = player;
    retrievable_model.retrievabletrigger = pickup_trigger;
    hint_string = &"WEAPON_BALLISTIC_KNIFE_PICKUP";
    
    if ( isdefined( hint_string ) )
    {
        pickup_trigger sethintstring( hint_string );
    }
    else
    {
        pickup_trigger sethintstring( &"GENERIC_PICKUP" );
    }
    
    pickup_trigger setteamfortrigger( player.team );
    player clientclaimtrigger( pickup_trigger );
    pickup_trigger enablelinkto();
    
    if ( isdefined( prey ) )
    {
        pickup_trigger linkto( prey );
    }
    else
    {
        pickup_trigger linkto( retrievable_model );
    }
    
    if ( isdefined( level.knife_planted ) )
    {
        [[ level.knife_planted ]]( retrievable_model, pickup_trigger, prey );
    }
    
    retrievable_model thread watch_use_trigger( pickup_trigger, retrievable_model, &pick_up, watcher.weapon, watcher.pickupsoundplayer, watcher.pickupsound );
    player thread watch_shutdown( pickup_trigger, retrievable_model );
}

/#

    // Namespace _zm_weap_ballistic_knife
    // Params 1
    // Checksum 0x14729f32, Offset: 0x9d0
    // Size: 0x48, Type: dev
    function debug_print( endpos )
    {
        self endon( #"death" );
        
        while ( true )
        {
            print3d( endpos, "<dev string:x28>" );
            wait 0.05;
        }
    }

#/

// Namespace _zm_weap_ballistic_knife
// Params 6
// Checksum 0x8396dddf, Offset: 0xa20
// Size: 0x350
function watch_use_trigger( trigger, model, callback, weapon, playersoundonuse, npcsoundonuse )
{
    self endon( #"death" );
    self endon( #"delete" );
    level endon( #"game_ended" );
    max_ammo = weapon.maxammo + 1;
    autorecover = isdefined( level.ballistic_knife_autorecover ) && level.ballistic_knife_autorecover;
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !player isonground() && !( isdefined( trigger.force_pickup ) && trigger.force_pickup ) )
        {
            continue;
        }
        
        if ( isdefined( trigger.triggerteam ) && player.team != trigger.triggerteam )
        {
            continue;
        }
        
        if ( isdefined( trigger.claimedby ) && player != trigger.claimedby )
        {
            continue;
        }
        
        ammo_stock = player getweaponammostock( weapon );
        ammo_clip = player getweaponammoclip( weapon );
        current_weapon = player getcurrentweapon();
        total_ammo = ammo_stock + ammo_clip;
        hasreloaded = 1;
        
        if ( total_ammo > 0 && ammo_stock == total_ammo && current_weapon == weapon )
        {
            hasreloaded = 0;
        }
        
        if ( total_ammo >= max_ammo || !hasreloaded )
        {
            continue;
        }
        
        if ( isdefined( trigger.force_pickup ) && ( player usebuttonpressed() && !player.throwinggrenade && ( autorecover || !player meleebuttonpressed() ) || trigger.force_pickup ) )
        {
            if ( isdefined( playersoundonuse ) )
            {
                player playlocalsound( playersoundonuse );
            }
            
            if ( isdefined( npcsoundonuse ) )
            {
                player playsound( npcsoundonuse );
            }
            
            player thread [[ callback ]]( weapon, model, trigger );
            break;
        }
    }
}

// Namespace _zm_weap_ballistic_knife
// Params 3
// Checksum 0x9d254968, Offset: 0xd78
// Size: 0x1b4
function pick_up( weapon, model, trigger )
{
    if ( self hasweapon( weapon ) )
    {
        current_weapon = self getcurrentweapon();
        
        if ( current_weapon != weapon )
        {
            clip_ammo = self getweaponammoclip( weapon );
            
            if ( !clip_ammo )
            {
                self setweaponammoclip( weapon, 1 );
            }
            else
            {
                new_ammo_stock = self getweaponammostock( weapon ) + 1;
                self setweaponammostock( weapon, new_ammo_stock );
            }
        }
        else
        {
            new_ammo_stock = self getweaponammostock( weapon ) + 1;
            self setweaponammostock( weapon, new_ammo_stock );
        }
    }
    
    self zm_stats::increment_client_stat( "ballistic_knives_pickedup" );
    self zm_stats::increment_player_stat( "ballistic_knives_pickedup" );
    model destroy_ent();
    trigger destroy_ent();
}

// Namespace _zm_weap_ballistic_knife
// Params 0
// Checksum 0xbf0dd262, Offset: 0xf38
// Size: 0x4c
function destroy_ent()
{
    if ( isdefined( self ) )
    {
        if ( isdefined( self.glowing_model ) )
        {
            self.glowing_model delete();
        }
        
        self delete();
    }
}

// Namespace _zm_weap_ballistic_knife
// Params 2
// Checksum 0x76ed68ab, Offset: 0xf90
// Size: 0x74
function watch_shutdown( trigger, model )
{
    self util::waittill_any( "death", "disconnect", "zmb_lost_knife" );
    trigger destroy_ent();
    model destroy_ent();
}

// Namespace _zm_weap_ballistic_knife
// Params 1
// Checksum 0x6260a55a, Offset: 0x1010
// Size: 0xb0
function drop_knives_to_ground( player )
{
    player endon( #"death" );
    player endon( #"zmb_lost_knife" );
    
    for ( ;; )
    {
        level waittill( #"drop_objects_to_ground", origin, radius );
        
        if ( distancesquared( origin, self.origin ) < radius * radius )
        {
            self physicslaunch( ( 0, 0, 1 ), ( 5, 5, 5 ) );
            self thread update_retrieve_trigger( player );
        }
    }
}

// Namespace _zm_weap_ballistic_knife
// Params 2
// Checksum 0xa9ccb7d4, Offset: 0x10c8
// Size: 0x8c
function force_drop_knives_to_ground_on_death( player, prey )
{
    self endon( #"death" );
    player endon( #"zmb_lost_knife" );
    prey waittill( #"death" );
    self unlink();
    self physicslaunch( ( 0, 0, 1 ), ( 5, 5, 5 ) );
    self thread update_retrieve_trigger( player );
}

// Namespace _zm_weap_ballistic_knife
// Params 1
// Checksum 0x54f633ab, Offset: 0x1160
// Size: 0xbc
function update_retrieve_trigger( player )
{
    self endon( #"death" );
    player endon( #"zmb_lost_knife" );
    
    if ( isdefined( level.custom_update_retrieve_trigger ) )
    {
        self [[ level.custom_update_retrieve_trigger ]]( player );
        return;
    }
    
    self waittill( #"stationary" );
    trigger = self.retrievabletrigger;
    trigger.origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 10 );
    trigger linkto( self );
}

