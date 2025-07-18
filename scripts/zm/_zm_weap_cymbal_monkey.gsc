#using scripts/codescripts/struct;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_clone;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace _zm_weap_cymbal_monkey;

// Namespace _zm_weap_cymbal_monkey
// Params 0
// Checksum 0x8b008347, Offset: 0x3f0
// Size: 0x1f8
function init()
{
    level.weaponzmcymbalmonkey = getweapon( "cymbal_monkey" );
    zm_weapons::register_zombie_weapon_callback( level.weaponzmcymbalmonkey, &player_give_cymbal_monkey );
    
    if ( !cymbal_monkey_exists( level.weaponzmcymbalmonkey ) )
    {
        return;
    }
    
    level.w_cymbal_monkey_upgraded = getweapon( "cymbal_monkey_upgraded" );
    
    if ( cymbal_monkey_exists( level.w_cymbal_monkey_upgraded ) )
    {
        zm_weapons::register_zombie_weapon_callback( level.w_cymbal_monkey_upgraded, &player_give_cymbal_monkey_upgraded );
        level._effect[ "monkey_bass" ] = "dlc3/stalingrad/fx_cymbal_monkey_radial_pulse";
    }
    
    /#
        level.zombiemode_devgui_cymbal_monkey_give = &player_give_cymbal_monkey;
    #/
    
    if ( isdefined( level.legacy_cymbal_monkey ) && level.legacy_cymbal_monkey )
    {
        level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
    }
    else
    {
        level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
    }
    
    level._effect[ "monkey_glow" ] = "zombie/fx_cymbal_monkey_light_zmb";
    level._effect[ "grenade_samantha_steal" ] = "zombie/fx_monkey_lightning_zmb";
    level.cymbal_monkeys = [];
    
    if ( !isdefined( level.valid_poi_max_radius ) )
    {
        level.valid_poi_max_radius = 200;
    }
    
    if ( !isdefined( level.valid_poi_half_height ) )
    {
        level.valid_poi_half_height = 100;
    }
    
    if ( !isdefined( level.valid_poi_inner_spacing ) )
    {
        level.valid_poi_inner_spacing = 2;
    }
    
    if ( !isdefined( level.valid_poi_radius_from_edges ) )
    {
        level.valid_poi_radius_from_edges = 15;
    }
    
    if ( !isdefined( level.valid_poi_height ) )
    {
        level.valid_poi_height = 36;
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 0
// Checksum 0xf73f989c, Offset: 0x5f0
// Size: 0x5c
function player_give_cymbal_monkey()
{
    self giveweapon( level.weaponzmcymbalmonkey );
    self zm_utility::set_player_tactical_grenade( level.weaponzmcymbalmonkey );
    self thread player_handle_cymbal_monkey();
}

// Namespace _zm_weap_cymbal_monkey
// Params 0
// Checksum 0xab224972, Offset: 0x658
// Size: 0xac
function player_give_cymbal_monkey_upgraded()
{
    /#
        self notify( #"give_tactical_grenade_thread" );
    #/
    
    if ( isdefined( self zm_utility::get_player_tactical_grenade() ) )
    {
        self takeweapon( self zm_utility::get_player_tactical_grenade() );
    }
    
    self giveweapon( level.w_cymbal_monkey_upgraded );
    self zm_utility::set_player_tactical_grenade( level.w_cymbal_monkey_upgraded );
    self thread player_handle_cymbal_monkey();
}

// Namespace _zm_weap_cymbal_monkey
// Params 0
// Checksum 0xd643bc1e, Offset: 0x710
// Size: 0xf8
function player_handle_cymbal_monkey()
{
    self notify( #"starting_monkey_watch" );
    self endon( #"disconnect" );
    self endon( #"starting_monkey_watch" );
    attract_dist_diff = level.monkey_attract_dist_diff;
    
    if ( !isdefined( attract_dist_diff ) )
    {
        attract_dist_diff = 45;
    }
    
    num_attractors = level.num_monkey_attractors;
    
    if ( !isdefined( num_attractors ) )
    {
        num_attractors = 96;
    }
    
    max_attract_dist = level.monkey_attract_dist;
    
    if ( !isdefined( max_attract_dist ) )
    {
        max_attract_dist = 1536;
    }
    
    while ( true )
    {
        grenade = get_thrown_monkey();
        self player_throw_cymbal_monkey( grenade, num_attractors, max_attract_dist, attract_dist_diff );
        wait 0.05;
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 2
// Checksum 0x686475e, Offset: 0x810
// Size: 0xf4
function watch_for_dud( model, actor )
{
    self endon( #"death" );
    self waittill( #"grenade_dud" );
    model.dud = 1;
    self playsound( "zmb_vox_monkey_scream" );
    self.monk_scream_vox = 1;
    wait 3;
    
    if ( isdefined( model ) )
    {
        model delete();
    }
    
    if ( isdefined( actor ) )
    {
        actor delete();
    }
    
    if ( isdefined( self.damagearea ) )
    {
        self.damagearea delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

#using_animtree( "zombie_cymbal_monkey" );

// Namespace _zm_weap_cymbal_monkey
// Params 2
// Checksum 0xa8207c0f, Offset: 0x910
// Size: 0x1ec
function watch_for_emp( model, actor )
{
    self endon( #"death" );
    
    if ( !zm_utility::should_watch_for_emp() )
    {
        return;
    }
    
    while ( true )
    {
        level waittill( #"emp_detonate", origin, radius );
        
        if ( distancesquared( origin, self.origin ) < radius * radius )
        {
            break;
        }
    }
    
    self.stun_fx = 1;
    
    if ( isdefined( level._equipment_emp_destroy_fx ) )
    {
        playfx( level._equipment_emp_destroy_fx, self.origin + ( 0, 0, 5 ), ( 0, randomfloat( 360 ), 0 ) );
    }
    
    wait 0.15;
    self.attract_to_origin = 0;
    self zm_utility::deactivate_zombie_point_of_interest();
    model clearanim( %o_monkey_bomb, 0 );
    wait 1;
    self detonate();
    wait 1;
    
    if ( isdefined( model ) )
    {
        model delete();
    }
    
    if ( isdefined( actor ) )
    {
        actor delete();
    }
    
    if ( isdefined( self.damagearea ) )
    {
        self.damagearea delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 1
// Checksum 0xe35da994, Offset: 0xb08
// Size: 0x50
function clone_player_angles( owner )
{
    self endon( #"death" );
    owner endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self.angles = owner.angles;
        wait 0.05;
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 1
// Checksum 0x4597327e, Offset: 0xb60
// Size: 0xae
function show_briefly( showtime )
{
    self endon( #"show_owner" );
    
    if ( isdefined( self.show_for_time ) )
    {
        self.show_for_time = showtime;
        return;
    }
    
    self.show_for_time = showtime;
    self setvisibletoall();
    
    while ( self.show_for_time > 0 )
    {
        self.show_for_time -= 0.05;
        wait 0.05;
    }
    
    self setvisibletoallexceptteam( level.zombie_team );
    self.show_for_time = undefined;
}

// Namespace _zm_weap_cymbal_monkey
// Params 1
// Checksum 0x60e8b30f, Offset: 0xc18
// Size: 0x80
function show_owner_on_attack( owner )
{
    owner endon( #"hide_owner" );
    owner endon( #"show_owner" );
    self endon( #"explode" );
    self endon( #"death" );
    self endon( #"grenade_dud" );
    owner.show_for_time = undefined;
    
    for ( ;; )
    {
        owner waittill( #"weapon_fired" );
        owner thread show_briefly( 0.5 );
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 1
// Checksum 0x62579f73, Offset: 0xca0
// Size: 0x22c
function hide_owner( owner )
{
    owner notify( #"hide_owner" );
    owner endon( #"hide_owner" );
    owner setperk( "specialty_immunemms" );
    owner.no_burning_sfx = 1;
    owner notify( #"stop_flame_sounds" );
    owner setvisibletoallexceptteam( level.zombie_team );
    owner.hide_owner = 1;
    
    if ( isdefined( level._effect[ "human_disappears" ] ) )
    {
        playfx( level._effect[ "human_disappears" ], owner.origin );
    }
    
    self thread show_owner_on_attack( owner );
    evt = self util::waittill_any_ex( "explode", "death", "grenade_dud", owner, "hide_owner" );
    println( "<dev string:x28>" + evt );
    owner notify( #"show_owner" );
    owner unsetperk( "specialty_immunemms" );
    
    if ( isdefined( level._effect[ "human_disappears" ] ) )
    {
        playfx( level._effect[ "human_disappears" ], owner.origin );
    }
    
    owner.no_burning_sfx = undefined;
    owner setvisibletoall();
    owner.hide_owner = undefined;
    owner show();
}

// Namespace _zm_weap_cymbal_monkey
// Params 1
// Checksum 0x3af2b9c5, Offset: 0xed8
// Size: 0x26c
function proximity_detonate( owner )
{
    wait 1.5;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    detonateradius = 96;
    explosionradius = detonateradius * 2;
    damagearea = spawn( "trigger_radius", self.origin + ( 0, 0, 0 - detonateradius ), 4, detonateradius, detonateradius * 1.5 );
    damagearea setexcludeteamfortrigger( owner.team );
    damagearea enablelinkto();
    damagearea linkto( self );
    self.damagearea = damagearea;
    
    while ( isdefined( self ) )
    {
        damagearea waittill( #"trigger", ent );
        
        if ( isdefined( owner ) && ent == owner )
        {
            continue;
        }
        
        if ( isdefined( ent.team ) && ent.team == owner.team )
        {
            continue;
        }
        
        self playsound( "wpn_claymore_alert" );
        dist = distance( self.origin, ent.origin );
        radiusdamage( self.origin + ( 0, 0, 12 ), explosionradius, 1, 1, owner, "MOD_GRENADE_SPLASH", level.weaponzmcymbalmonkey );
        
        if ( isdefined( owner ) )
        {
            self detonate( owner );
        }
        else
        {
            self detonate( undefined );
        }
        
        break;
    }
    
    if ( isdefined( damagearea ) )
    {
        damagearea delete();
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 1
// Checksum 0xb0d2dab, Offset: 0x1150
// Size: 0x80
function fakelinkto( linkee )
{
    self notify( #"fakelinkto" );
    self endon( #"fakelinkto" );
    self.backlinked = 1;
    
    while ( isdefined( self ) && isdefined( linkee ) )
    {
        self.origin = linkee.origin;
        self.angles = linkee.angles;
        wait 0.05;
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 4
// Checksum 0x59ca39bc, Offset: 0x11d8
// Size: 0x75c
function player_throw_cymbal_monkey( grenade, num_attractors, max_attract_dist, attract_dist_diff )
{
    self endon( #"disconnect" );
    self endon( #"starting_monkey_watch" );
    
    if ( isdefined( grenade ) )
    {
        grenade endon( #"death" );
        
        if ( self laststand::player_is_in_laststand() )
        {
            if ( isdefined( grenade.damagearea ) )
            {
                grenade.damagearea delete();
            }
            
            grenade delete();
            return;
        }
        
        grenade hide();
        model = spawn( "script_model", grenade.origin );
        model setmodel( level.cymbal_monkey_model );
        model useanimtree( #animtree );
        model linkto( grenade );
        model.angles = grenade.angles;
        model thread monkey_cleanup( grenade );
        clone = undefined;
        
        if ( isdefined( level.cymbal_monkey_dual_view ) && level.cymbal_monkey_dual_view )
        {
            model setvisibletoallexceptteam( level.zombie_team );
            clone = zm_clone::spawn_player_clone( self, ( 0, 0, -999 ), level.cymbal_monkey_clone_weapon, undefined );
            model.simulacrum = clone;
            clone zm_clone::clone_animate( "idle" );
            clone thread clone_player_angles( self );
            clone notsolid();
            clone ghost();
        }
        
        grenade thread watch_for_dud( model, clone );
        grenade thread watch_for_emp( model, clone );
        info = spawnstruct();
        info.sound_attractors = [];
        grenade waittill( #"stationary" );
        
        if ( isdefined( level.grenade_planted ) )
        {
            self thread [[ level.grenade_planted ]]( grenade, model );
        }
        
        if ( isdefined( grenade ) )
        {
            grenade.ground_ent = grenade getgroundent();
            
            if ( isdefined( model ) )
            {
                if ( isdefined( grenade.ground_ent ) && !( grenade.ground_ent.classname === "worldspawn" ) )
                {
                    model setmovingplatformenabled( 1 );
                    model linkto( grenade.ground_ent );
                    grenade thread fakelinkto( model );
                }
                else if ( !( isdefined( grenade.backlinked ) && grenade.backlinked ) )
                {
                    model unlink();
                    model.origin = grenade.origin;
                    model.angles = grenade.angles;
                }
                
                wait 0.1;
                model animscripted( "cymbal_monkey_anim", grenade.origin, grenade.angles, %o_monkey_bomb );
            }
            
            if ( isdefined( clone ) )
            {
                clone forceteleport( grenade.origin, grenade.angles );
                clone thread hide_owner( self );
                grenade thread proximity_detonate( self );
                clone show();
                clone setinvisibletoall();
                clone setvisibletoteam( level.zombie_team );
            }
            
            grenade resetmissiledetonationtime();
            playfxontag( level._effect[ "monkey_glow" ], model, "tag_origin_animate" );
            valid_poi = zm_utility::check_point_in_enabled_zone( grenade.origin, undefined, undefined );
            
            if ( isdefined( level.move_valid_poi_to_navmesh ) && level.move_valid_poi_to_navmesh )
            {
                valid_poi = grenade move_valid_poi_to_navmesh( valid_poi );
            }
            
            if ( isdefined( level.check_valid_poi ) )
            {
                valid_poi = grenade [[ level.check_valid_poi ]]( valid_poi );
            }
            
            if ( valid_poi )
            {
                grenade zm_utility::create_zombie_point_of_interest( max_attract_dist, num_attractors, 10000 );
                grenade.attract_to_origin = 1;
                grenade thread zm_utility::create_zombie_point_of_interest_attractor_positions( 4, attract_dist_diff );
                grenade thread zm_utility::wait_for_attractor_positions_complete();
                
                if ( grenade.weapon == level.w_cymbal_monkey_upgraded )
                {
                    grenade thread pulse_damage( self, model );
                }
                
                grenade thread do_monkey_sound( model, info );
                level.cymbal_monkeys[ level.cymbal_monkeys.size ] = grenade;
            }
            else
            {
                grenade.script_noteworthy = undefined;
                level thread grenade_stolen_by_sam( grenade, model, clone );
            }
            
            return;
        }
        
        grenade.script_noteworthy = undefined;
        level thread grenade_stolen_by_sam( grenade, model, clone );
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 1
// Checksum 0xbde94fea, Offset: 0x1940
// Size: 0x1ea, Type: bool
function move_valid_poi_to_navmesh( valid_poi )
{
    if ( !( isdefined( valid_poi ) && valid_poi ) )
    {
        return false;
    }
    
    if ( ispointonnavmesh( self.origin ) )
    {
        return true;
    }
    
    v_orig = self.origin;
    queryresult = positionquery_source_navigation( self.origin, 0, level.valid_poi_max_radius, level.valid_poi_half_height, level.valid_poi_inner_spacing, level.valid_poi_radius_from_edges );
    
    if ( queryresult.data.size )
    {
        foreach ( point in queryresult.data )
        {
            height_offset = abs( self.origin[ 2 ] - point.origin[ 2 ] );
            
            if ( height_offset > level.valid_poi_height )
            {
                continue;
            }
            
            if ( bullettracepassed( point.origin + ( 0, 0, 20 ), v_orig + ( 0, 0, 20 ), 0, self, undefined, 0, 0 ) )
            {
                self.origin = point.origin;
                return true;
            }
        }
    }
    
    return false;
}

// Namespace _zm_weap_cymbal_monkey
// Params 3
// Checksum 0x53e0f73c, Offset: 0x1b38
// Size: 0x2dc
function grenade_stolen_by_sam( ent_grenade, ent_model, ent_actor )
{
    if ( !isdefined( ent_model ) )
    {
        return;
    }
    
    direction = ent_model.origin;
    direction = ( direction[ 1 ], direction[ 0 ], 0 );
    
    if ( direction[ 0 ] > 0 && ( direction[ 1 ] < 0 || direction[ 1 ] > 0 ) )
    {
        direction = ( direction[ 0 ], direction[ 1 ] * -1, 0 );
    }
    else if ( direction[ 0 ] < 0 )
    {
        direction = ( direction[ 0 ] * -1, direction[ 1 ], 0 );
    }
    
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isalive( players[ i ] ) )
        {
            players[ i ] playlocalsound( level.zmb_laugh_alias );
        }
    }
    
    playfxontag( level._effect[ "grenade_samantha_steal" ], ent_model, "tag_origin" );
    ent_model stopanimscripted();
    ent_model movez( 60, 1, 0.25, 0.25 );
    ent_model vibrate( direction, 1.5, 2.5, 1 );
    ent_model waittill( #"movedone" );
    
    if ( isdefined( self.damagearea ) )
    {
        self.damagearea delete();
    }
    
    ent_model delete();
    
    if ( isdefined( ent_actor ) )
    {
        ent_actor delete();
    }
    
    if ( isdefined( ent_grenade ) )
    {
        if ( isdefined( ent_grenade.damagearea ) )
        {
            ent_grenade.damagearea delete();
        }
        
        ent_grenade delete();
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 1
// Checksum 0x945465f1, Offset: 0x1e20
// Size: 0x8c
function monkey_cleanup( parent )
{
    while ( true )
    {
        if ( !isdefined( parent ) )
        {
            if ( isdefined( self.dud ) && isdefined( self ) && self.dud )
            {
                wait 6;
            }
            
            if ( isdefined( self.simulacrum ) )
            {
                self.simulacrum delete();
            }
            
            zm_utility::self_delete();
            return;
        }
        
        wait 0.05;
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 2
// Checksum 0x283f7b1, Offset: 0x1eb8
// Size: 0x1f0
function pulse_damage( e_owner, model )
{
    self endon( #"explode" );
    util::wait_network_frame();
    playfxontag( level._effect[ "monkey_bass" ], model, "tag_origin_animate" );
    n_damage_origin = self.origin + ( 0, 0, 12 );
    
    while ( true )
    {
        a_ai_targets = getaiteamarray( "axis" );
        
        foreach ( ai_target in a_ai_targets )
        {
            if ( isdefined( ai_target ) )
            {
                n_distance_to_target = distance( ai_target.origin, n_damage_origin );
                
                if ( n_distance_to_target > 128 )
                {
                    continue;
                }
                
                n_damage = math::linear_map( n_distance_to_target, 0, 128, 500, 1000 );
                ai_target dodamage( n_damage, ai_target.origin, e_owner, self, "none", "MOD_GRENADE_SPLASH", 0, level.w_cymbal_monkey_upgraded );
            }
        }
        
        wait 1;
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 2
// Checksum 0xf628398, Offset: 0x20b0
// Size: 0x2fc
function do_monkey_sound( model, info )
{
    self.monk_scream_vox = 0;
    
    if ( isdefined( level.grenade_safe_to_bounce ) )
    {
        if ( ![[ level.grenade_safe_to_bounce ]]( self.owner, level.weaponzmcymbalmonkey ) )
        {
            self playsound( "zmb_vox_monkey_scream" );
            self.monk_scream_vox = 1;
        }
    }
    
    if ( isdefined( level.monkey_song_override ) )
    {
        if ( [[ level.monkey_song_override ]]( self.owner, level.weaponzmcymbalmonkey ) )
        {
            self playsound( "zmb_vox_monkey_scream" );
            self.monk_scream_vox = 1;
        }
    }
    
    if ( !self.monk_scream_vox && level.musicsystem.currentplaytype < 4 )
    {
        if ( isdefined( level.cymbal_monkey_dual_view ) && level.cymbal_monkey_dual_view )
        {
            self playsoundtoteam( "zmb_monkey_song", "allies" );
        }
        else if ( self.weapon.name == "cymbal_monkey_upgraded" )
        {
            self playsound( "zmb_monkey_song_upgraded" );
        }
        else
        {
            self playsound( "zmb_monkey_song" );
        }
    }
    
    if ( !self.monk_scream_vox )
    {
        self thread play_delayed_explode_vox();
    }
    
    self waittill( #"explode", position );
    level notify( #"grenade_exploded", position, 100, 5000, 450 );
    monkey_index = -1;
    
    for ( i = 0; i < level.cymbal_monkeys.size ; i++ )
    {
        if ( !isdefined( level.cymbal_monkeys[ i ] ) )
        {
            monkey_index = i;
            break;
        }
    }
    
    if ( monkey_index >= 0 )
    {
        arrayremoveindex( level.cymbal_monkeys, monkey_index );
    }
    
    if ( isdefined( model ) )
    {
        model clearanim( %o_monkey_bomb, 0.2 );
    }
    
    for ( i = 0; i < info.sound_attractors.size ; i++ )
    {
        if ( isdefined( info.sound_attractors[ i ] ) )
        {
            info.sound_attractors[ i ] notify( #"monkey_blown_up" );
        }
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 0
// Checksum 0x1768175c, Offset: 0x23b8
// Size: 0x6c
function play_delayed_explode_vox()
{
    wait 6.5;
    
    if ( isdefined( self ) )
    {
        if ( self.weapon.name == "cymbal_monkey_upgraded" )
        {
            self playsound( "zmb_vox_monkey_explode_upgraded" );
            return;
        }
        
        self playsound( "zmb_vox_monkey_explode" );
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 0
// Checksum 0x342dee84, Offset: 0x2430
// Size: 0xb8
function get_thrown_monkey()
{
    self endon( #"disconnect" );
    self endon( #"starting_monkey_watch" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, weapon );
        
        if ( weapon == level.weaponzmcymbalmonkey || weapon == level.w_cymbal_monkey_upgraded )
        {
            grenade.use_grenade_special_long_bookmark = 1;
            grenade.grenade_multiattack_bookmark_count = 1;
            grenade.weapon = weapon;
            return grenade;
        }
        
        wait 0.05;
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 1
// Checksum 0x13c6f717, Offset: 0x24f0
// Size: 0x1cc
function monitor_zombie_groans( info )
{
    self endon( #"explode" );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( !isdefined( self.attractor_array ) )
        {
            wait 0.05;
            continue;
        }
        
        for ( i = 0; i < self.attractor_array.size ; i++ )
        {
            if ( !isinarray( info.sound_attractors, self.attractor_array[ i ] ) )
            {
                if ( isdefined( self.origin ) && isdefined( self.attractor_array[ i ].origin ) )
                {
                    if ( distancesquared( self.origin, self.attractor_array[ i ].origin ) < 250000 )
                    {
                        if ( !isdefined( info.sound_attractors ) )
                        {
                            info.sound_attractors = [];
                        }
                        else if ( !isarray( info.sound_attractors ) )
                        {
                            info.sound_attractors = array( info.sound_attractors );
                        }
                        
                        info.sound_attractors[ info.sound_attractors.size ] = self.attractor_array[ i ];
                        self.attractor_array[ i ] thread play_zombie_groans();
                    }
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 0
// Checksum 0x60cc1bee, Offset: 0x26c8
// Size: 0x66
function play_zombie_groans()
{
    self endon( #"death" );
    self endon( #"monkey_blown_up" );
    
    while ( true )
    {
        if ( isdefined( self ) )
        {
            self playsound( "zmb_vox_zombie_groan" );
            wait randomfloatrange( 2, 3 );
            continue;
        }
        
        return;
    }
}

// Namespace _zm_weap_cymbal_monkey
// Params 1
// Checksum 0xe07a4342, Offset: 0x2738
// Size: 0x22, Type: bool
function cymbal_monkey_exists( w_weapon )
{
    return zm_weapons::is_weapon_included( w_weapon );
}

