#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_equip_gasmask;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_moon_gravity;

#namespace zm_moon_gravity;

// Namespace zm_moon_gravity
// Params 0
// Checksum 0xd58cf54c, Offset: 0x4b0
// Size: 0xdc
function init()
{
    level.zombie_init_done = &zombie_moon_init_done;
    level thread init_low_gravity_fx();
    zm_spawner::register_zombie_death_animscript_callback( &gravity_zombie_death_response );
    callback::on_spawned( &low_gravity_watch );
    level thread update_zombie_locomotion();
    level thread update_low_gravity_fx();
    level thread update_zombie_gravity_transition();
    callback::on_spawned( &player_throw_grenade );
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0xde6c0869, Offset: 0x598
// Size: 0xb2
function init_low_gravity_fx()
{
    keys = getarraykeys( level.zones );
    
    for ( i = 0; i < level.zones.size ; i++ )
    {
        if ( keys[ i ] == "nml_zone" )
        {
            continue;
        }
        
        zerogravityvolumeon( keys[ i ] );
    }
    
    wait 0.5;
    level._effect[ "low_gravity_blood" ] = "dlc5/moon/fx_bul_impact_blood_lowgrav";
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x8814f522, Offset: 0x658
// Size: 0xb8
function gravity_trigger()
{
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( !isplayer( who ) )
        {
            self thread trigger::function_thread( who, &gravity_zombie_in, &gravity_zombie_out );
            continue;
        }
        
        self thread trigger::function_thread( who, &gravity_player_in, &gravity_player_out );
    }
}

// Namespace zm_moon_gravity
// Params 2
// Checksum 0x613a507b, Offset: 0x718
// Size: 0x6c
function gravity_zombie_in( ent, endon_condition )
{
    if ( !isdefined( ent.in_low_gravity ) )
    {
        ent.in_low_gravity = 0;
    }
    
    ent.in_low_gravity++;
    ent clientfield::set( "low_gravity", 1 );
}

// Namespace zm_moon_gravity
// Params 1
// Checksum 0x1f123193, Offset: 0x790
// Size: 0x64
function gravity_zombie_out( ent )
{
    if ( ent.in_low_gravity > 0 )
    {
        ent.in_low_gravity--;
        
        if ( ent.in_low_gravity == 0 )
        {
            ent clientfield::set( "low_gravity", 0 );
        }
    }
}

// Namespace zm_moon_gravity
// Params 2
// Checksum 0x55170b94, Offset: 0x800
// Size: 0x2c
function gravity_player_in( ent, endon_condition )
{
    ent setplayergravity( 136 );
}

// Namespace zm_moon_gravity
// Params 1
// Checksum 0xcbfd8c6e, Offset: 0x838
// Size: 0x24
function gravity_player_out( ent )
{
    ent clearplayergravity();
}

// Namespace zm_moon_gravity
// Params 2
// Checksum 0xc14cfcb6, Offset: 0x868
// Size: 0x154
function gravity_zombie_update( low_gravity, force_update )
{
    if ( !isdefined( self.animname ) )
    {
        return;
    }
    
    if ( isdefined( self.ignore_gravity ) && self.ignore_gravity )
    {
        return;
    }
    
    if ( !( isdefined( self.completed_emerging_into_playable_area ) && self.completed_emerging_into_playable_area ) )
    {
        return;
    }
    
    if ( isdefined( self.in_low_gravity ) && self.in_low_gravity == low_gravity && !( isdefined( force_update ) && force_update ) )
    {
        return;
    }
    
    self.in_low_gravity = low_gravity;
    
    if ( low_gravity )
    {
        self clientfield::set( "low_gravity", 1 );
        self.script_noteworthy = "moon_gravity";
        self.zombie_damage_fx_func = &function_7a7cde90;
        return;
    }
    
    self.zombie_damage_fx_func = undefined;
    self.nogravity = undefined;
    self.script_noteworthy = undefined;
    util::wait_network_frame();
    
    if ( isdefined( self ) )
    {
        self clientfield::set( "low_gravity", 0 );
        self thread reset_zombie_anim();
    }
}

// Namespace zm_moon_gravity
// Params 5
// Checksum 0x11ad4b86, Offset: 0x9c8
// Size: 0xe8
function function_7a7cde90( mod, hit_location, hit_origin, player, direction_vec )
{
    if ( mod === "MOD_PISTOL_BULLET" || mod === "MOD_RIFLE_BULLET" )
    {
        forward = anglestoforward( direction_vec );
        up = anglestoup( direction_vec );
        right = anglestoright( direction_vec );
        playfx( level._effect[ "low_gravity_blood" ], hit_origin, forward, up );
        
        /#
        #/
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x835d80ae, Offset: 0xab8
// Size: 0x216, Type: bool
function gravity_zombie_death_response()
{
    if ( isdefined( self._black_hole_bomb_collapse_death ) && ( !isdefined( self.in_low_gravity ) || self.in_low_gravity == 0 || self._black_hole_bomb_collapse_death ) )
    {
        return false;
    }
    
    self startragdoll();
    rag_x = randomintrange( -50, 50 );
    rag_y = randomintrange( -50, 50 );
    rag_z = randomintrange( 25, 45 );
    force_min = 75;
    force_max = 100;
    
    if ( self.damagemod == "MOD_MELEE" )
    {
        force_min = 40;
        force_max = 50;
        rag_z = 15;
    }
    else if ( self.damageweapon == level.start_weapon )
    {
        force_min = 60;
        force_max = 75;
        rag_z = 20;
    }
    else if ( self.damageweapon.weapclass == "spread" )
    {
        force_min = 100;
        force_max = 150;
    }
    
    scale = randomintrange( force_min, force_max );
    rag_x = self.damagedir[ 0 ] * scale;
    rag_y = self.damagedir[ 1 ] * scale;
    dir = ( rag_x, rag_y, rag_z );
    self launchragdoll( dir );
    return false;
}

// Namespace zm_moon_gravity
// Params 1
// Checksum 0xfcba135d, Offset: 0xcd8
// Size: 0x78, Type: bool
function zombie_moon_is_low_gravity_zone( zone_name )
{
    zone = getentarray( zone_name, "targetname" );
    
    if ( isdefined( zone[ 0 ].script_string ) && zone[ 0 ].script_string == "lowgravity" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x49096b13, Offset: 0xd58
// Size: 0x12c
function zombie_moon_check_zone()
{
    self endon( #"death" );
    util::wait_network_frame();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.ignore_gravity ) && self.ignore_gravity )
    {
        return;
    }
    
    if ( self.zone_name == "nml_zone_spawners" || self.zone_name == "nml_area1_spawners" || self.zone_name == "nml_area2_spawners" )
    {
        return;
    }
    
    if ( !( isdefined( self.completed_emerging_into_playable_area ) && self.completed_emerging_into_playable_area ) )
    {
        self waittill( #"completed_emerging_into_playable_area" );
    }
    
    if ( !level flag::get( "power_on" ) || isdefined( level.on_the_moon ) && level.on_the_moon && zombie_moon_is_low_gravity_zone( self.zone_name ) )
    {
        self gravity_zombie_update( 1 );
        return;
    }
    
    self gravity_zombie_update( 0 );
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x6276442b, Offset: 0xe90
// Size: 0x64
function zombie_moon_init_done()
{
    self.crawl_anim_override = &zombie_moon_crawl_anim_override;
    self thread zombie_moon_check_zone();
    self thread zombie_watch_nogravity();
    self thread zombie_watch_run_notetracks();
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0xce0c1610, Offset: 0xf00
// Size: 0xc4
function zombie_low_gravity_locomotion()
{
    self endon( #"death" );
    gravity_str = undefined;
    
    if ( self.zombie_move_speed == "walk" || self.zombie_move_speed == "run" || self.zombie_move_speed == "sprint" )
    {
        gravity_str = "low_gravity_" + self.zombie_move_speed;
    }
    
    if ( isdefined( gravity_str ) )
    {
        animstatedef = self zombie_utility::append_missing_legs_suffix( gravity_str );
        animstatedef = "walk";
        self zombie_utility::set_zombie_run_cycle( animstatedef );
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x6160e821, Offset: 0xfd0
// Size: 0xc4
function zombie_watch_nogravity()
{
    self endon( #"death" );
    _off_ground_max = 32;
    
    while ( true )
    {
        if ( isdefined( self.nogravity ) && self.nogravity )
        {
            ground = self zm_utility::groundpos( self.origin );
            dist = self.origin[ 2 ] - ground[ 2 ];
            
            if ( dist > _off_ground_max )
            {
                util::wait_network_frame();
                self.nogravity = undefined;
            }
        }
        
        wait 0.2;
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x78b762f3, Offset: 0x10a0
// Size: 0xb2
function zombie_watch_run_notetracks()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"runanim", note );
        
        if ( !isdefined( self.script_noteworthy ) || self.script_noteworthy != "moon_gravity" )
        {
            continue;
        }
        
        if ( note == "gravity off" )
        {
            self animmode( "nogravity" );
            self.nogravity = 1;
            continue;
        }
        
        if ( note == "gravity code" )
        {
            self.nogravity = undefined;
        }
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x2d855160, Offset: 0x1160
// Size: 0x14
function reset_zombie_anim()
{
    zombie_utility::set_zombie_run_cycle();
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x9979fd54, Offset: 0x1180
// Size: 0x3b0
function zombie_moon_update_player_gravity()
{
    level flag::wait_till( "start_zombie_round_logic" );
    low_g = 136;
    player_zones = getentarray( "player_volume", "script_noteworthy" );
    
    while ( true )
    {
        players = getplayers();
        
        for ( i = 0; i < player_zones.size ; i++ )
        {
            volume = player_zones[ i ];
            zone = undefined;
            
            if ( isdefined( volume.targetname ) )
            {
                zone = level.zones[ volume.targetname ];
            }
            
            if ( isdefined( zone.is_enabled ) && isdefined( zone ) && zone.is_enabled )
            {
                for ( j = 0; j < players.size ; j++ )
                {
                    player = players[ j ];
                    
                    if ( zombie_utility::is_player_valid( player ) && player istouching( volume ) )
                    {
                        if ( isdefined( level.on_the_moon ) && level.on_the_moon && !level flag::get( "power_on" ) )
                        {
                            player setperk( "specialty_lowgravity" );
                            
                            if ( !( isdefined( player.in_low_gravity ) && player.in_low_gravity ) )
                            {
                                player clientfield::set_to_player( "snd_lowgravity", 1 );
                            }
                            
                            player.in_low_gravity = 1;
                            continue;
                        }
                        
                        if ( isdefined( volume.script_string ) && volume.script_string == "lowgravity" )
                        {
                            player setperk( "specialty_lowgravity" );
                            
                            if ( !( isdefined( player.in_low_gravity ) && player.in_low_gravity ) )
                            {
                                player clientfield::set_to_player( "snd_lowgravity", 1 );
                            }
                            
                            player.in_low_gravity = 1;
                            continue;
                        }
                        
                        player unsetperk( "specialty_lowgravity" );
                        
                        if ( isdefined( player.in_low_gravity ) && player.in_low_gravity )
                        {
                            player clientfield::set_to_player( "snd_lowgravity", 0 );
                        }
                        
                        player.in_low_gravity = 0;
                    }
                }
            }
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0xf370e94b, Offset: 0x1538
// Size: 0x86
function zombie_moon_update_player_float()
{
    level flag::wait_till( "start_zombie_round_logic" );
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] thread zombie_moon_player_float();
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0xbe1524a6, Offset: 0x15c8
// Size: 0x248
function zombie_moon_player_float()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    boost_chance = 40;
    
    while ( true )
    {
        if ( isdefined( self.in_low_gravity ) && zombie_utility::is_player_valid( self ) && self.in_low_gravity && self isonground() && self issprinting() )
        {
            boost = randomint( 100 );
            
            if ( boost < boost_chance )
            {
                time = randomfloatrange( 0.75, 1.25 );
                wait time;
                
                if ( isdefined( self.in_low_gravity ) && self.in_low_gravity && self isonground() && self issprinting() )
                {
                    self setorigin( self.origin + ( 0, 0, 1 ) );
                    player_velocity = self getvelocity();
                    boost_velocity = player_velocity + ( 0, 0, 100 );
                    self setvelocity( boost_velocity );
                    
                    if ( !( isdefined( level.var_833e8251 ) && level.var_833e8251 ) )
                    {
                        self thread zm_audio::create_and_play_dialog( "general", "moonjump" );
                        level.var_833e8251 = 1;
                    }
                    
                    boost_chance = 40;
                    wait 2;
                }
                else
                {
                    boost_chance += 10;
                }
            }
            else
            {
                wait 2;
            }
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x2e414ef5, Offset: 0x1818
// Size: 0x86
function check_player_gravity()
{
    level flag::wait_till( "start_zombie_round_logic" );
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] thread low_gravity_watch();
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x60dba2fc, Offset: 0x18a8
// Size: 0x5d0
function low_gravity_watch()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self notify( #"low_gravity_watch_start" );
    self endon( #"low_gravity_watch_start" );
    level flag::wait_till( "start_zombie_round_logic" );
    self.airless_vox_in_progess = 0;
    time_in_low_gravity = 0;
    time_to_death = 0;
    time_to_death_default = 15000;
    time_to_death_jug = 17000;
    time_til_damage = 0;
    blur_level = 0;
    blur_level_max = 7;
    blur_occur = [];
    blur_occur[ 0 ] = 1000;
    blur_occur[ 1 ] = 1250;
    blur_occur[ 2 ] = 1250;
    blur_occur[ 3 ] = 1500;
    blur_occur[ 4 ] = 1500;
    blur_occur[ 5 ] = 1750;
    blur_occur[ 6 ] = 2250;
    blur_occur[ 7 ] = 2500;
    blur_intensity = [];
    blur_intensity[ 0 ] = 1;
    blur_intensity[ 1 ] = 2;
    blur_intensity[ 2 ] = 3;
    blur_intensity[ 3 ] = 5;
    blur_intensity[ 4 ] = 7;
    blur_intensity[ 5 ] = 8;
    blur_intensity[ 6 ] = 9;
    blur_intensity[ 7 ] = 10;
    blur_duration = [];
    blur_duration[ 0 ] = 0.2;
    blur_duration[ 1 ] = 0.25;
    blur_duration[ 2 ] = 0.25;
    blur_duration[ 3 ] = 0.5;
    blur_duration[ 4 ] = 0.5;
    blur_duration[ 5 ] = 0.75;
    blur_duration[ 6 ] = 0.75;
    blur_duration[ 7 ] = 1;
    
    if ( isdefined( level.debug_low_gravity ) && level.debug_low_gravity )
    {
        time_to_death = 3000;
    }
    
    starttime = gettime();
    
    for ( nexttime = gettime(); true ; nexttime = gettime() )
    {
        diff = nexttime - starttime;
        
        if ( isgodmode( self ) )
        {
            time_in_low_gravity = 0;
            blur_level = 0;
            wait 1;
            continue;
        }
        
        if ( !zombie_utility::is_player_valid( self ) || !( isdefined( level.on_the_moon ) && level.on_the_moon ) )
        {
            time_in_low_gravity = 0;
            blur_level = 0;
            util::wait_network_frame();
            continue;
        }
        
        if ( isdefined( self.in_low_gravity ) && ( !level flag::get( "power_on" ) || self.in_low_gravity ) && !self zm_equip_gasmask::gasmask_active() )
        {
            self thread airless_vox_without_repeat();
            time_til_damage += diff;
            time_in_low_gravity += diff;
            
            if ( self hasperk( "specialty_armorvest" ) )
            {
                time_to_death = time_to_death_jug;
            }
            else
            {
                time_to_death = time_to_death_default;
            }
            
            if ( time_in_low_gravity > time_to_death )
            {
                self playsoundtoplayer( "evt_suffocate_whump", self );
                self dodamage( self.health * 10, self.origin );
                self setblur( 0, 0.1 );
            }
            else if ( blur_level < blur_occur.size && time_til_damage > blur_occur[ blur_level ] )
            {
                self clientfield::set_to_player( "gasp_rumble", 1 );
                self playsoundtoplayer( "evt_suffocate_whump", self );
                self setblur( blur_intensity[ blur_level ], 0.1 );
                self thread remove_blur( blur_duration[ blur_level ] );
                blur_level++;
                
                if ( blur_level > blur_level_max )
                {
                    blur_level = blur_level_max;
                }
                
                time_til_damage = 0;
            }
        }
        else if ( time_in_low_gravity > 0 )
        {
            time_in_low_gravity = 0;
            time_til_damage = 0;
            blur_level = 0;
        }
        
        starttime = gettime();
        wait 0.1;
    }
}

// Namespace zm_moon_gravity
// Params 1
// Checksum 0x61586d6c, Offset: 0x1e80
// Size: 0x5c
function remove_blur( time )
{
    self endon( #"disconnect" );
    wait time;
    self setblur( 0, 0.1 );
    self clientfield::set_to_player( "gasp_rumble", 0 );
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x90afbc2c, Offset: 0x1ee8
// Size: 0x128
function airless_vox_without_repeat()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    entity_num = self.characterindex;
    
    if ( isdefined( self.zm_random_char ) )
    {
        entity_num = self.zm_random_char;
    }
    
    if ( isdefined( level.player_4_vox_override ) && entity_num == 2 && level.player_4_vox_override )
    {
        entity_num = 4;
    }
    
    if ( !self.airless_vox_in_progess )
    {
        self.airless_vox_in_progess = 1;
        wait 2;
        
        if ( isdefined( self.in_low_gravity ) && isdefined( self ) && self.in_low_gravity )
        {
            level.player_is_speaking = 1;
            self playsoundtoplayer( "vox_plr_" + entity_num + "_location_airless_" + randomintrange( 0, 5 ), self );
            wait 10;
            level.player_is_speaking = 0;
        }
        
        wait 0.1;
        self.airless_vox_in_progess = 0;
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0xaa28113, Offset: 0x2018
// Size: 0x1d0
function update_zombie_locomotion()
{
    level flag::wait_till( "power_on" );
    player_zones = getentarray( "player_volume", "script_noteworthy" );
    zombies = getaiarray();
    
    for ( i = 0; i < player_zones.size ; i++ )
    {
        volume = player_zones[ i ];
        zone = undefined;
        
        if ( isdefined( volume.targetname ) )
        {
            zone = level.zones[ volume.targetname ];
        }
        
        if ( isdefined( zone.is_enabled ) && isdefined( zone ) && zone.is_enabled )
        {
            if ( isdefined( volume.script_string ) && volume.script_string == "gravity" )
            {
                for ( j = 0; j < zombies.size ; j++ )
                {
                    zombie = zombies[ j ];
                    
                    if ( isdefined( zombie ) && zombie istouching( volume ) )
                    {
                        zombie gravity_zombie_update( 0 );
                    }
                }
            }
        }
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x3414cfc9, Offset: 0x21f0
// Size: 0x106
function update_low_gravity_fx()
{
    level flag::wait_till( "power_on" );
    keys = getarraykeys( level.zones );
    
    for ( i = 0; i < level.zones.size ; i++ )
    {
        if ( keys[ i ] == "nml_zone" )
        {
            continue;
        }
        
        volume = level.zones[ keys[ i ] ].volumes[ 0 ];
        
        if ( isdefined( volume.script_string ) && volume.script_string == "gravity" )
        {
            zerogravityvolumeoff( keys[ i ] );
        }
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x24780e5d, Offset: 0x2300
// Size: 0x86
function watch_player_grenades()
{
    level flag::wait_till( "start_zombie_round_logic" );
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] thread player_throw_grenade();
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x85b2d7b1, Offset: 0x2390
// Size: 0x88
function player_throw_grenade()
{
    self notify( #"player_throw_grenade" );
    self endon( #"player_throw_grenade" );
    self endon( #"disconnect" );
    level flag::wait_till( "start_zombie_round_logic" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, weapname );
        grenade thread watch_grenade_gravity();
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x3a035171, Offset: 0x2420
// Size: 0x28c
function watch_grenade_gravity()
{
    self endon( #"death" );
    self endon( #"explode" );
    player_zones = getentarray( "player_volume", "script_noteworthy" );
    
    while ( true )
    {
        if ( isdefined( level.on_the_moon ) && level.on_the_moon && !level flag::get( "power_on" ) )
        {
            if ( isdefined( self ) && isalive( self ) )
            {
                self.script_noteworthy = "moon_gravity";
                self setentgravitytrajectory( 1 );
            }
            
            wait 0.25;
            continue;
        }
        
        for ( i = 0; i < player_zones.size ; i++ )
        {
            volume = player_zones[ i ];
            zone = undefined;
            
            if ( isdefined( volume.targetname ) )
            {
                zone = level.zones[ volume.targetname ];
            }
            
            if ( isdefined( zone.is_enabled ) && isdefined( zone ) && zone.is_enabled )
            {
                if ( isdefined( volume.script_string ) && volume.script_string == "lowgravity" )
                {
                    if ( isdefined( self ) && isalive( self ) && self istouching( volume ) )
                    {
                        if ( volume.script_string == "lowgravity" )
                        {
                            self.script_noteworthy = "moon_gravity";
                            self setentgravitytrajectory( 1 );
                            continue;
                        }
                        
                        if ( volume.script_string == "gravity" )
                        {
                            self.script_noteworthy = undefined;
                            self setentgravitytrajectory( 0 );
                        }
                    }
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x8c767d47, Offset: 0x26b8
// Size: 0x76
function update_zombie_gravity_transition()
{
    airlock_doors = getentarray( "zombie_door_airlock", "script_noteworthy" );
    
    for ( i = 0; i < airlock_doors.size ; i++ )
    {
        airlock_doors[ i ] thread zombie_airlock_think();
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x1ba9dfb4, Offset: 0x2738
// Size: 0x248
function zombie_airlock_think()
{
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            continue;
        }
        
        if ( !level flag::get( "power_on" ) )
        {
            continue;
        }
        
        if ( isdefined( self.script_parameters ) )
        {
            zone = getentarray( self.script_parameters, "targetname" );
            in_airlock = 0;
            
            for ( i = 0; i < zone.size ; i++ )
            {
                if ( who istouching( zone[ i ] ) )
                {
                    who gravity_zombie_update( 0 );
                    in_airlock = 1;
                    break;
                }
            }
            
            if ( in_airlock )
            {
                continue;
            }
        }
        
        if ( self.script_string == "inside" )
        {
            if ( isdefined( self.doors[ 0 ].script_noteworthy ) )
            {
                _zones = getentarray( self.doors[ 0 ].script_noteworthy, "targetname" );
                
                if ( _zones[ 0 ].script_string == "lowgravity" )
                {
                    who gravity_zombie_update( 1 );
                    self.script_string = "outside";
                }
                else
                {
                    who gravity_zombie_update( 0 );
                }
            }
            else
            {
                who gravity_zombie_update( 0 );
            }
            
            continue;
        }
        
        who gravity_zombie_update( 1 );
    }
}

// Namespace zm_moon_gravity
// Params 1
// Checksum 0x613879be, Offset: 0x2988
// Size: 0x1ac
function zone_breached( zone_name )
{
    zones = getentarray( zone_name, "targetname" );
    zombies = getaiarray();
    throttle = 0;
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        zombie = zombies[ i ];
        
        if ( isdefined( zombie ) )
        {
            for ( j = 0; j < zones.size ; j++ )
            {
                if ( zombie istouching( zones[ j ] ) )
                {
                    zombie gravity_zombie_update( 1 );
                    throttle++;
                }
            }
        }
        
        if ( throttle && !( throttle % 10 ) )
        {
            util::wait_network_frame();
            util::wait_network_frame();
            util::wait_network_frame();
        }
    }
    
    if ( isdefined( level.var_2f9ab492 ) && isdefined( level.var_2f9ab492[ zone_name ] ) )
    {
        exploder::delete_exploder_on_clients( level.var_2f9ab492[ zone_name ] );
    }
}

// Namespace zm_moon_gravity
// Params 0
// Checksum 0x15ca9642, Offset: 0x2b40
// Size: 0x1a6
function zombie_moon_crawl_anim_override()
{
    player_volumes = getentarray( "player_volume", "script_noteworthy" );
    
    if ( !( isdefined( level.on_the_moon ) && level.on_the_moon ) )
    {
        return;
    }
    
    if ( !level flag::get( "power_on" ) )
    {
        self gravity_zombie_update( 1, 1 );
        return;
    }
    
    for ( i = 0; i < player_volumes.size ; i++ )
    {
        volume = player_volumes[ i ];
        zone = undefined;
        
        if ( isdefined( volume.targetname ) )
        {
            zone = level.zones[ volume.targetname ];
        }
        
        if ( isdefined( zone.is_enabled ) && isdefined( zone ) && zone.is_enabled )
        {
            if ( self istouching( volume ) )
            {
                if ( isdefined( volume.script_string ) && volume.script_string == "lowgravity" )
                {
                    self gravity_zombie_update( 1, 1 );
                }
            }
        }
    }
}

