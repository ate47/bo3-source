#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_weap_shrink_ray;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq_skits;

#namespace zm_temple_sq_lgs;

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0x80503b50, Offset: 0x530
// Size: 0xd4
function init()
{
    level flag::init( "meteor_impact" );
    zm_sidequests::declare_sidequest_stage( "sq", "LGS", &init_stage, &stage_logic, &exit_stage );
    zm_sidequests::set_stage_time_limit( "sq", "LGS", 300 );
    zm_sidequests::declare_stage_asset_from_struct( "sq", "LGS", "sq_lgs_crystal", &lgs_crystal );
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0xce6e87ef, Offset: 0x610
// Size: 0x9c
function init_stage()
{
    zm_temple_sq_brock::delete_radio();
    level flag::clear( "meteor_impact" );
    level thread lgs_intro();
    
    /#
        if ( getplayers().size == 1 )
        {
            getplayers()[ 0 ] giveweapon( level.w_shrink_ray_upgraded );
        }
    #/
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0x10a7c695, Offset: 0x6b8
// Size: 0x104
function lgs_intro()
{
    exploder::exploder( "fxexp_600" );
    wait 4;
    level thread play_intro_audio();
    exploder::exploder( "fxexp_601" );
    level thread zm_temple_sq_skits::start_skit( "tt3" );
    level thread play_nikolai_farting();
    wait 2;
    wait 1.5;
    earthquake( 1, 0.8, getplayers()[ 0 ].origin, 200 );
    wait 1;
    level flag::set( "meteor_impact" );
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0x92d0f2e8, Offset: 0x7c8
// Size: 0xa0
function play_nikolai_farting()
{
    level endon( #"sq_lgs_over" );
    wait 2;
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ].characterindex == 1 )
        {
            players[ i ] playsound( "evt_sq_lgs_fart" );
            return;
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0xd339e6de, Offset: 0x870
// Size: 0x5c
function play_intro_audio()
{
    playsoundatposition( "evt_sq_lgs_meteor_incoming", ( -1680, -780, 147 ) );
    wait 3.3;
    playsoundatposition( "evt_sq_lgs_meteor_impact", ( -1229, -1642, 198 ) );
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0x7880c66d, Offset: 0x8d8
// Size: 0x180
function first_damage()
{
    self endon( #"death" );
    self endon( #"first_damage_done" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction, point, dmg_type, modelname, tagname );
        
        if ( dmg_type == "MOD_PROJECTILE" || dmg_type == "MOD_PROJECTILE_SPLASH" || dmg_type == "MOD_EXPLOSIVE" || dmg_type == "MOD_EXPLOSIVE_SPLASH" || dmg_type == "MOD_GRENADE" || isplayer( attacker ) && dmg_type == "MOD_GRENADE_SPLASH" )
        {
            self.owner_ent notify( #"triggered" );
            attacker thread zm_audio::create_and_play_dialog( "eggs", "quest3", 1 );
            return;
        }
        
        if ( isplayer( attacker ) )
        {
            attacker thread zm_audio::create_and_play_dialog( "eggs", "quest3", 2 );
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0xe0a5bdc8, Offset: 0xa60
// Size: 0xdc
function wait_for_player_to_get_close()
{
    self endon( #"death" );
    self endon( #"first_damage_done" );
    
    while ( true )
    {
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( distancesquared( self.origin, players[ i ].origin ) <= 250000 )
            {
                players[ i ] thread zm_audio::create_and_play_dialog( "eggs", "quest3", 0 );
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0x42980918, Offset: 0xb48
// Size: 0xe8
function report_melee_early()
{
    self endon( #"death" );
    self endon( #"shrunk" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction, point, dmg_type, modelname, tagname );
        
        if ( isplayer( attacker ) && dmg_type == "MOD_MELEE" )
        {
            attacker thread zm_audio::create_and_play_dialog( "eggs", "quest3", 3 );
            wait 5;
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0x6f99d187, Offset: 0xc38
// Size: 0xe2
function wait_for_melee()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction, point, dmg_type, modelname, tagname );
        
        if ( isplayer( attacker ) && dmg_type == "MOD_MELEE" )
        {
            self.owner_ent notify( #"triggered" );
            attacker thread zm_audio::create_and_play_dialog( "eggs", "quest3", 6 );
            return;
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 1
// Checksum 0x3c212c22, Offset: 0xd28
// Size: 0x23a
function check_for_closed_slide( ent )
{
    if ( !level flag::get( "waterslide_open" ) )
    {
        self endon( #"death" );
        self endon( #"reached_end_node" );
        
        while ( true )
        {
            self waittill( #"reached_node", node );
            
            if ( isdefined( node.script_noteworthy ) && node.script_noteworthy == "pre_gate" )
            {
                if ( !level flag::get( "waterslide_open" ) )
                {
                    players = getplayers();
                    
                    for ( i = 0; i < players.size ; i++ )
                    {
                        if ( distancesquared( self.origin, players[ i ].origin ) <= 250000 )
                        {
                            players[ i ] thread zm_audio::create_and_play_dialog( "eggs", "quest3", 7 );
                        }
                    }
                    
                    self._crystal stopanimscripted();
                    
                    while ( !level flag::get( "waterslide_open" ) )
                    {
                        self setspeedimmediate( 0 );
                        wait 0.05;
                    }
                    
                    wait 0.5;
                    self._crystal animscripted( "spin", self._crystal.origin, self._crystal.angles, "p7_fxanim_zm_sha_crystal_sml_anim" );
                    self resumespeed( 12 );
                    return;
                }
            }
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 1
// Checksum 0x6d34d502, Offset: 0xf70
// Size: 0xc0
function water_trail( ent )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"reached_node", node );
        
        if ( isdefined( node.script_int ) )
        {
            if ( node.script_int == 1 )
            {
                ent clientfield::set( "watertrail", 1 );
                continue;
            }
            
            if ( node.script_int == 0 )
            {
                ent clientfield::set( "watertrail", 0 );
            }
        }
    }
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0x3672c023, Offset: 0x1038
// Size: 0x74
function function_c7e74d12()
{
    self endon( #"triggered" );
    level endon( #"end_game" );
    exploder::exploder( "fxexp_602" );
    level util::waittill_any( "sq_lgs_over", "sq_lgs_failed" );
    exploder::stop_exploder( "fxexp_602" );
}

#using_animtree( "generic" );

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0x4e25620, Offset: 0x10b8
// Size: 0xb0c
function lgs_crystal()
{
    self endon( #"death" );
    self ghost();
    self.trigger = getent( "sq_lgs_crystal_trig", "targetname" );
    self.trigger.var_b82c7478 = 1;
    self.trigger.origin = self.origin;
    self.trigger.var_d5784b10 = self.trigger.origin;
    self.trigger.owner_ent = self;
    self.trigger notsolid();
    self.trigger.takedamage = 0;
    level flag::wait_till( "meteor_impact" );
    self show();
    self.trigger solid();
    self.trigger.takedamage = 1;
    self.trigger thread first_damage();
    self.trigger thread wait_for_player_to_get_close();
    self thread function_c7e74d12();
    self waittill( #"triggered" );
    self.trigger notify( #"first_damage_done" );
    exploder::stop_exploder( "fxexp_602" );
    self playsound( "evt_sq_lgs_crystal_pry" );
    
    for ( target = self.target; isdefined( target ) ; target = struct.target )
    {
        struct = struct::get( target, "targetname" );
        
        if ( isdefined( struct.script_parameters ) )
        {
            time = float( struct.script_parameters );
        }
        else
        {
            time = 1;
        }
        
        self moveto( struct.origin, time, time / 10 );
        self waittill( #"movedone" );
        self playsound( "evt_sq_lgs_crystal_hit1" );
    }
    
    self playsound( "evt_sq_lgs_crystal_land" );
    self.trigger.origin = self.origin;
    self.trigger thread report_melee_early();
    zm_weap_shrink_ray::add_shrinkable_object( self );
    self waittill( #"shrunk" );
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        currentweapon = players[ i ] getcurrentweapon();
        
        if ( currentweapon == level.w_shrink_ray || currentweapon == level.w_shrink_ray_upgraded )
        {
            players[ i ] thread zm_audio::create_and_play_dialog( "eggs", "quest3", 4 );
        }
    }
    
    self playsound( "evt_sq_lgs_crystal_shrink" );
    self setmodel( "p7_fxanim_zm_sha_crystal_sml_mod" );
    vn = getvehiclenode( "sq_lgs_node_start", "targetname" );
    self.origin = vn.origin;
    self.trigger notify( #"shrunk" );
    zm_weap_shrink_ray::remove_shrinkable_object( self );
    self.trigger thread wait_for_melee();
    self waittill( #"triggered" );
    self playsound( "evt_sq_lgs_crystal_knife" );
    self playloopsound( "evt_sq_lgs_crystal_roll", 2 );
    self.trigger.origin = self.trigger.var_d5784b10;
    self.trigger notsolid();
    self.trigger.takedamage = 0;
    self notsolid();
    self useanimtree( #animtree );
    self.animname = "crystal";
    vehicle = getent( "crystal_mover", "targetname" );
    vehicle.origin = self.origin;
    vehicle.angles = self.angles;
    vehicle._crystal = self;
    level._lgs_veh = vehicle;
    util::wait_network_frame();
    origin_animate = util::spawn_model( "tag_origin_animate", vehicle.origin );
    self linkto( origin_animate, "origin_animate_jnt", ( 0, 0, 0 ), ( 90, 0, 0 ) );
    origin_animate linkto( vehicle );
    self animscripted( "spin", self.origin, self.angles, "p7_fxanim_zm_sha_crystal_sml_anim" );
    vehicle vehicle::get_on_and_go_path( "sq_lgs_node_start" );
    vehicle._origin_animate = origin_animate;
    vehicle thread water_trail( self );
    vehicle thread check_for_closed_slide( self );
    vehicle waittill( #"reached_end_node" );
    self stopanimscripted();
    self unlink();
    self stoploopsound();
    self playsound( "evt_sq_lgs_crystal_land_2" );
    vehicle delete();
    origin_animate delete();
    self thread crystal_bobble();
    level flag::wait_till( "minecart_geyser_active" );
    self notify( #"kill_bobble" );
    self clientfield::set( "watertrail", 1 );
    self moveto( self.origin + ( 0, 0, 4000 ), 2, 0.1 );
    level notify( #"suspend_timer" );
    level notify( #"raise_crystal_1" );
    level notify( #"raise_crystal_2" );
    level notify( #"raise_crystal_3", 1 );
    level waittill( #"hash_18e4f2bc" );
    self clientfield::set( "watertrail", 0 );
    wait 2;
    holder = getent( "empty_holder", "script_noteworthy" );
    self.origin = ( holder.origin[ 0 ], holder.origin[ 1 ], self.origin[ 2 ] );
    self setmodel( "p7_zm_sha_crystal" );
    playsoundatposition( "evt_sq_lgs_crystal_incoming", ( holder.origin[ 0 ], holder.origin[ 1 ], holder.origin[ 2 ] + 134 ) );
    self moveto( ( holder.origin[ 0 ], holder.origin[ 1 ], holder.origin[ 2 ] + 134 ), 2 );
    self waittill( #"movedone" );
    self playsound( "evt_sq_lgs_crystal_landinholder" );
    players = getplayers();
    players[ randomintrange( 0, players.size ) ] thread zm_audio::create_and_play_dialog( "eggs", "quest3", 8 );
    level notify( #"crystal_dropped" );
    self ghost();
    wait 5;
    zm_sidequests::stage_completed( "sq", "LGS" );
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0x9486057b, Offset: 0x1bd0
// Size: 0xc6
function crystal_spin()
{
    self endon( #"death" );
    self endon( #"kill_bobble" );
    
    while ( true )
    {
        t = randomfloatrange( 0.2, 0.8 );
        self rotateto( ( 180 + randomfloat( 180 ), 300 + randomfloat( 60 ), 180 + randomfloat( 180 ) ), t );
        wait t;
    }
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0x43e7b0c7, Offset: 0x1ca0
// Size: 0x17c
function crystal_bobble()
{
    self endon( #"death" );
    self endon( #"kill_bobble" );
    self thread crystal_spin();
    node = getvehiclenode( "crystal_end", "script_noteworthy" );
    bottom_pos = node.origin + ( 0, 0, 4 );
    top_pos = bottom_pos + ( 0, 0, 3 );
    
    while ( true )
    {
        self moveto( top_pos + ( 0, 0, randomfloat( 3 ) ), 0.2 + randomfloat( 0.1 ), 0.1 );
        self waittill( #"movedone" );
        self moveto( bottom_pos + ( 0, 0, randomfloat( 5 ) ), 0.05 + randomfloat( 0.07 ), 0, 0.03 );
        self waittill( #"movedone" );
    }
}

// Namespace zm_temple_sq_lgs
// Params 0
// Checksum 0x99ec1590, Offset: 0x1e28
// Size: 0x4
function stage_logic()
{
    
}

// Namespace zm_temple_sq_lgs
// Params 1
// Checksum 0xf59f6b2f, Offset: 0x1e38
// Size: 0xc4
function exit_stage( success )
{
    if ( isdefined( level._lgs_veh ) )
    {
        if ( isdefined( level._lgs_veh._origin_animate ) )
        {
            level._lgs_veh._origin_animate delete();
        }
        
        level._lgs_veh delete();
    }
    
    level._lgs_veh = undefined;
    
    if ( success )
    {
        zm_temple_sq_brock::create_radio( 4, &zm_temple_sq_brock::radio4_override );
        return;
    }
    
    zm_temple_sq_brock::create_radio( 3 );
    level thread zm_temple_sq_skits::fail_skit();
}

