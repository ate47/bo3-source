#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_blackboard;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_behavior;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_genesis_portals;

#namespace zm_genesis_keeper;

// Namespace zm_genesis_keeper
// Params 0, eflags: 0x2
// Checksum 0xbf3bcc08, Offset: 0x8a8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_genesis_keeper", &__init__, undefined, undefined );
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x8d712be5, Offset: 0x8e8
// Size: 0x8c
function __init__()
{
    function_cf48298e();
    
    if ( ai::shouldregisterclientfieldforarchetype( "keeper" ) )
    {
        clientfield::register( "actor", "keeper_death", 15000, 2, "int" );
    }
    
    /#
        adddebugcommand( "<dev string:x28>" );
        thread function_85d4833b();
    #/
}

// Namespace zm_genesis_keeper
// Params 0, eflags: 0x4
// Checksum 0x7577d640, Offset: 0x980
// Size: 0x2c
function private function_cf48298e()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "genesisKeeperDeathStart", &function_9d655978 );
}

// Namespace zm_genesis_keeper
// Params 1
// Checksum 0x90c9dac, Offset: 0x9b8
// Size: 0x9c
function function_9d655978( entity )
{
    if ( entity.model == "c_zom_dlc4_keeper_hooded_body" )
    {
        entity setmodel( "c_zom_dlc4_keeper_hooded_dissolve" );
    }
    else
    {
        entity setmodel( "c_zom_dlc4_keeper_dissolve" );
    }
    
    entity clientfield::set( "keeper_death", 2 );
    entity notsolid();
}

// Namespace zm_genesis_keeper
// Params 8
// Checksum 0x342dfc2a, Offset: 0xa60
// Size: 0x80
function function_f8c7a969( inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettimes )
{
    self clientfield::set( "keeper_death", 1 );
    self notsolid();
    return damage;
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x1675d5d9, Offset: 0xae8
// Size: 0xd4
function function_51dd865c()
{
    spawner::add_archetype_spawn_function( "keeper", &function_cb6b3469 );
    spawner::add_archetype_spawn_function( "keeper", &function_6ded398b );
    spawner::add_archetype_spawn_function( "keeper", &function_e5e94978 );
    spawner::add_archetype_spawn_function( "keeper", &function_1dcdd145 );
    level thread aat::register_immunity( "zm_aat_turned", "keeper", 1, 1, 1 );
}

// Namespace zm_genesis_keeper
// Params 0, eflags: 0x4
// Checksum 0x4cd6703d, Offset: 0xbc8
// Size: 0x44
function private function_85d4833b()
{
    level flagsys::wait_till( "start_zombie_round_logic" );
    zm_devgui::add_custom_devgui_callback( &function_e361808 );
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x7fcc54c6, Offset: 0xc18
// Size: 0x74
function keeper_death()
{
    self waittill( #"death", e_attacker );
    
    if ( isdefined( e_attacker ) && isdefined( e_attacker.var_4d307aef ) )
    {
        e_attacker.var_4d307aef++;
    }
    
    if ( isdefined( e_attacker ) && isdefined( e_attacker.var_8b5008fe ) )
    {
        e_attacker.var_8b5008fe++;
    }
}

// Namespace zm_genesis_keeper
// Params 1, eflags: 0x4
// Checksum 0x8de5a6ce, Offset: 0xc98
// Size: 0x146
function private function_e361808( cmd )
{
    switch ( cmd )
    {
        default:
            queryresult = positionquery_source_navigation( level.players[ 0 ].origin, 128, 256, 128, 20 );
            
            if ( isdefined( queryresult ) && queryresult.data.size > 0 )
            {
                origin = queryresult.data[ 0 ].origin;
                angles = level.players[ 0 ].angles;
                entity = spawnactor( "spawner_zm_genesis_keeper", origin, level.players[ 0 ].angles, undefined, 1, 1 );
                
                if ( isdefined( entity ) )
                {
                    entity thread function_dfdf3fc1();
                }
            }
            
            break;
    }
}

// Namespace zm_genesis_keeper
// Params 0, eflags: 0x4
// Checksum 0x57edfa8f, Offset: 0xde8
// Size: 0xb0
function private function_dfdf3fc1()
{
    self endon( #"death" );
    self.spawn_time = gettime();
    self thread keeper_death();
    self.heroweapon_kill_power = 2;
    self.voiceprefix = "keeper";
    self.animname = "keeper";
    self thread zm_spawner::play_ambient_zombie_vocals();
    self thread zm_audio::zmbaivox_notifyconvert();
    self pushactors( 1 );
    wait 1;
    self.zombie_think_done = 1;
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x78076d56, Offset: 0xea0
// Size: 0x84
function function_6ded398b()
{
    aiutility::addaioverridedamagecallback( self, &damage_callback );
    self thread zm::update_zone_name();
    self aat::aat_cooldown_init();
    self thread zm_spawner::enemy_death_detection();
    self.completed_emerging_into_playable_area = 1;
    self.is_zombie = 1;
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x8d5604b9, Offset: 0xf30
// Size: 0x158
function function_e5e94978()
{
    self endon( #"death" );
    
    while ( isalive( self ) )
    {
        self waittill( #"damage" );
        
        if ( isplayer( self.attacker ) )
        {
            if ( zm_spawner::player_using_hi_score_weapon( self.attacker ) )
            {
                str_notify = "damage";
            }
            else
            {
                str_notify = "damage_light";
            }
            
            if ( !( isdefined( self.deathpoints_already_given ) && self.deathpoints_already_given ) )
            {
                self.attacker zm_score::player_add_points( str_notify, self.damagemod, self.damagelocation, undefined, self.team, self.damageweapon );
            }
            
            if ( isdefined( level.hero_power_update ) )
            {
                [[ level.hero_power_update ]]( self.attacker, self );
            }
            
            self.attacker.use_weapon_type = self.damagemod;
            self thread zm_powerups::check_for_instakill( self.attacker, self.damagemod, self.damagelocation );
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x7e1aea6c, Offset: 0x1090
// Size: 0xc0
function function_1dcdd145()
{
    self waittill( #"death" );
    self zm_spawner::check_zombie_death_event_callbacks( self.attacker );
    
    if ( isplayer( self.attacker ) )
    {
        if ( !( isdefined( self.deathpoints_already_given ) && self.deathpoints_already_given ) )
        {
            self.attacker zm_score::player_add_points( "death", self.damagemod, self.damagelocation, undefined, self.team, self.damageweapon );
        }
        
        if ( isdefined( level.hero_power_update ) )
        {
            [[ level.hero_power_update ]]( self.attacker, self );
        }
    }
}

// Namespace zm_genesis_keeper
// Params 12
// Checksum 0xcad2aeb6, Offset: 0x1158
// Size: 0x12c
function damage_callback( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex )
{
    if ( isdefined( eattacker.var_74fe492b ) && isplayer( eattacker ) && eattacker.var_74fe492b )
    {
        idamage = int( idamage * 1.33 );
    }
    
    if ( isdefined( eattacker.var_e8e8daad ) && isplayer( eattacker ) && eattacker.var_e8e8daad )
    {
        idamage = int( idamage * 1.5 );
    }
    
    return idamage;
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x88565184, Offset: 0x1290
// Size: 0x3a
function bb_getarmsposition()
{
    if ( isdefined( self.zombie_arms_position ) )
    {
        if ( self.zombie_arms_position == "up" )
        {
            return "arms_up";
        }
        
        return "arms_down";
    }
    
    return "arms_up";
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x337810f0, Offset: 0x12d8
// Size: 0x92
function bb_getlocomotionspeedtype()
{
    if ( isdefined( self.zombie_move_speed ) )
    {
        if ( self.zombie_move_speed == "walk" )
        {
            return "locomotion_speed_walk";
        }
        else if ( self.zombie_move_speed == "run" )
        {
            return "locomotion_speed_run";
        }
        else if ( self.zombie_move_speed == "sprint" )
        {
            return "locomotion_speed_sprint";
        }
        else if ( self.zombie_move_speed == "super_sprint" )
        {
            return "locomotion_speed_super_sprint";
        }
    }
    
    return "locomotion_speed_walk";
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0xf8a28d87, Offset: 0x1378
// Size: 0x1a
function bb_getvarianttype()
{
    if ( isdefined( self.variant_type ) )
    {
        return self.variant_type;
    }
    
    return 0;
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x20fc1030, Offset: 0x13a0
// Size: 0x1e
function bb_gethaslegsstatus()
{
    if ( self.missinglegs )
    {
        return "has_legs_no";
    }
    
    return "has_legs_yes";
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0xcb6073e9, Offset: 0x13c8
// Size: 0x2a
function bb_getshouldturn()
{
    if ( isdefined( self.should_turn ) && self.should_turn )
    {
        return "should_turn";
    }
    
    return "should_not_turn";
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x358a8727, Offset: 0x1400
// Size: 0x2a
function bb_idgungetdamagedirection()
{
    if ( isdefined( self.damage_direction ) )
    {
        return self.damage_direction;
    }
    
    return self aiutility::bb_getdamagedirection();
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x8eed25c3, Offset: 0x1438
// Size: 0x1a
function bb_getlowgravityvariant()
{
    if ( isdefined( self.low_gravity_variant ) )
    {
        return self.low_gravity_variant;
    }
    
    return 0;
}

// Namespace zm_genesis_keeper
// Params 0
// Checksum 0x87a071f2, Offset: 0x1460
// Size: 0x4fc
function function_cb6b3469()
{
    blackboard::createblackboardforentity( self );
    self aiutility::registerutilityblackboardattributes();
    ai::createinterfaceforentity( self );
    blackboard::registerblackboardattribute( self, "_arms_position", "arms_up", &bb_getarmsposition );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x78>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_locomotion_speed", "locomotion_speed_walk", &bb_getlocomotionspeedtype );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x87>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_has_legs", "has_legs_yes", &bb_gethaslegsstatus );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x99>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_variant_type", 0, &bb_getvarianttype );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:xa3>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_which_board_pull", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:xb1>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_board_attack_spot", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:xc3>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_grapple_direction", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:xd6>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:xe9>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_idgun_damage_direction", "back", &bb_idgungetdamagedirection );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x101>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_low_gravity_variant", 0, &bb_getlowgravityvariant );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x119>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_knockdown_direction", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x12e>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_knockdown_type", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x143>" );
        #/
    }
    
    self.___archetypeonanimscriptedcallback = &archetypezombieonanimscriptedcallback;
    
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace zm_genesis_keeper
// Params 1, eflags: 0x4
// Checksum 0xc2b3157c, Offset: 0x1968
// Size: 0x34
function private archetypezombieonanimscriptedcallback( entity )
{
    entity.__blackboard = undefined;
    entity function_cb6b3469();
}

