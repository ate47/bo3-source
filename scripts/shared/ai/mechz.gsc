#using scripts/codescripts/struct;
#using scripts/shared/_burnplayer;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace mechzbehavior;

// Namespace mechzbehavior
// Params 0, eflags: 0x2
// Checksum 0xa241e276, Offset: 0xab8
// Size: 0x274
function autoexec init()
{
    initmechzbehaviorsandasm();
    spawner::add_archetype_spawn_function( "mechz", &archetypemechzblackboardinit );
    spawner::add_archetype_spawn_function( "mechz", &mechzserverutils::mechzspawnsetup );
    clientfield::register( "actor", "mechz_ft", 5000, 1, "int" );
    clientfield::register( "actor", "mechz_faceplate_detached", 5000, 1, "int" );
    clientfield::register( "actor", "mechz_powercap_detached", 5000, 1, "int" );
    clientfield::register( "actor", "mechz_claw_detached", 5000, 1, "int" );
    clientfield::register( "actor", "mechz_115_gun_firing", 5000, 1, "int" );
    clientfield::register( "actor", "mechz_rknee_armor_detached", 5000, 1, "int" );
    clientfield::register( "actor", "mechz_lknee_armor_detached", 5000, 1, "int" );
    clientfield::register( "actor", "mechz_rshoulder_armor_detached", 5000, 1, "int" );
    clientfield::register( "actor", "mechz_lshoulder_armor_detached", 5000, 1, "int" );
    clientfield::register( "actor", "mechz_headlamp_off", 5000, 2, "int" );
    clientfield::register( "actor", "mechz_face", 1, 3, "int" );
}

// Namespace mechzbehavior
// Params 0, eflags: 0x4
// Checksum 0x33d94f30, Offset: 0xd38
// Size: 0x474
function private initmechzbehaviorsandasm()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzTargetService", &mechztargetservice );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzGrenadeService", &mechzgrenadeservice );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzBerserkKnockdownService", &mechzberserkknockdownservice );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzShouldMelee", &mechzshouldmelee );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzShouldShowPain", &mechzshouldshowpain );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzShouldShootGrenade", &mechzshouldshootgrenade );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzShouldShootFlame", &mechzshouldshootflame );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzShouldShootFlameSweep", &mechzshouldshootflamesweep );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzShouldTurnBerserk", &mechzshouldturnberserk );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzShouldStun", &mechzshouldstun );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzShouldStumble", &mechzshouldstumble );
    behaviortreenetworkutility::registerbehaviortreeaction( "mechzStunLoop", &mechzstunstart, &mechzstunupdate, &mechzstunend );
    behaviortreenetworkutility::registerbehaviortreeaction( "mechzStumbleLoop", &mechzstumblestart, &mechzstumbleupdate, &mechzstumbleend );
    behaviortreenetworkutility::registerbehaviortreeaction( "mechzShootFlameAction", &mechzshootflameactionstart, &mechzshootflameactionupdate, &mechzshootflameactionend );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzShootGrenade", &mechzshootgrenade );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzShootFlame", &mechzshootflame );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzUpdateFlame", &mechzupdateflame );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzStopFlame", &mechzstopflame );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzPlayedBerserkIntro", &mechzplayedberserkintro );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzAttackStart", &mechzattackstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzDeathStart", &mechzdeathstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzIdleStart", &mechzidlestart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzPainStart", &mechzpainstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "mechzPainTerminate", &mechzpainterminate );
    animationstatenetwork::registernotetrackhandlerfunction( "melee_soldat", &mechznotetrackmelee );
    animationstatenetwork::registernotetrackhandlerfunction( "fire_chaingun", &mechznotetrackshootgrenade );
}

// Namespace mechzbehavior
// Params 0, eflags: 0x4
// Checksum 0xc5e372b0, Offset: 0x11b8
// Size: 0x1ec
function private archetypemechzblackboardinit()
{
    blackboard::createblackboardforentity( self );
    self aiutility::registerutilityblackboardattributes();
    blackboard::registerblackboardattribute( self, "_locomotion_speed", "locomotion_speed_run", undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x28>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x3a>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_zombie_damageweapon_type", "regular", undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x52>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_mechz_part", "mechz_powercore", undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x6c>" );
        #/
    }
    
    self.___archetypeonanimscriptedcallback = &archetypemechzonanimscriptedcallback;
    
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0xfdb8d738, Offset: 0x13b0
// Size: 0x34
function private archetypemechzonanimscriptedcallback( entity )
{
    entity.__blackboard = undefined;
    entity archetypemechzblackboardinit();
}

// Namespace mechzbehavior
// Params 0, eflags: 0x4
// Checksum 0x9c03dea5, Offset: 0x13f0
// Size: 0x2a
function private bb_getshouldturn()
{
    if ( isdefined( self.should_turn ) && self.should_turn )
    {
        return "should_turn";
    }
    
    return "should_not_turn";
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0xc5d808e, Offset: 0x1428
// Size: 0x4c
function private mechznotetrackmelee( entity )
{
    if ( isdefined( entity.mechz_melee_knockdown_function ) )
    {
        entity thread [[ entity.mechz_melee_knockdown_function ]]();
    }
    
    entity melee();
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x86a65d17, Offset: 0x1480
// Size: 0x2cc
function private mechznotetrackshootgrenade( entity )
{
    if ( !isdefined( entity.enemy ) )
    {
        return;
    }
    
    base_target_pos = entity.enemy.origin;
    v_velocity = entity.enemy getvelocity();
    base_target_pos += v_velocity * 1.5;
    target_pos_offset_x = math::randomsign() * randomint( 32 );
    target_pos_offset_y = math::randomsign() * randomint( 32 );
    target_pos = base_target_pos + ( target_pos_offset_x, target_pos_offset_y, 0 );
    dir = vectortoangles( target_pos - entity.origin );
    dir = anglestoforward( dir );
    launch_offset = dir * 5;
    launch_pos = entity gettagorigin( "tag_gun_barrel2" ) + launch_offset;
    dist = distance( launch_pos, target_pos );
    velocity = dir * dist;
    velocity += ( 0, 0, 120 );
    val = 1;
    oldval = entity clientfield::get( "mechz_115_gun_firing" );
    
    if ( oldval === val )
    {
        val = 0;
    }
    
    entity clientfield::set( "mechz_115_gun_firing", val );
    entity magicgrenadetype( getweapon( "electroball_grenade" ), launch_pos, velocity );
    playsoundatposition( "wpn_grenade_fire_mechz", entity.origin );
}

// Namespace mechzbehavior
// Params 1
// Checksum 0xebf0c8f6, Offset: 0x1758
// Size: 0x268
function mechztargetservice( entity )
{
    if ( isdefined( entity.ignoreall ) && entity.ignoreall )
    {
        return 0;
    }
    
    if ( isdefined( entity.destroy_octobomb ) )
    {
        return 0;
    }
    
    player = zombie_utility::get_closest_valid_player( self.origin, self.ignore_player );
    entity.favoriteenemy = player;
    
    if ( !isdefined( player ) || player isnotarget() )
    {
        if ( isdefined( entity.ignore_player ) )
        {
            if ( isdefined( level._should_skip_ignore_player_logic ) && [[ level._should_skip_ignore_player_logic ]]() )
            {
                return;
            }
            
            entity.ignore_player = [];
        }
        
        /#
            if ( isdefined( level.b_mechz_true_ignore ) && level.b_mechz_true_ignore )
            {
                entity setgoal( entity.origin );
                return 0;
            }
        #/
        
        if ( isdefined( level.no_target_override ) )
        {
            [[ level.no_target_override ]]( entity );
        }
        else
        {
            entity setgoal( entity.origin );
        }
        
        return 0;
    }
    
    if ( isdefined( level.enemy_location_override_func ) )
    {
        enemy_ground_pos = [[ level.enemy_location_override_func ]]( entity, player );
        
        if ( isdefined( enemy_ground_pos ) )
        {
            entity setgoal( enemy_ground_pos );
            return 1;
        }
    }
    
    targetpos = getclosestpointonnavmesh( player.origin, 64, 30 );
    
    if ( isdefined( targetpos ) )
    {
        entity setgoal( targetpos );
        return 1;
    }
    
    entity setgoal( entity.origin );
    return 0;
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x9d66e638, Offset: 0x19c8
// Size: 0x100
function private mechzgrenadeservice( entity )
{
    if ( !isdefined( entity.burstgrenadesfired ) )
    {
        entity.burstgrenadesfired = 0;
    }
    
    if ( entity.burstgrenadesfired >= 3 )
    {
        if ( gettime() > entity.nextgrenadetime )
        {
            entity.burstgrenadesfired = 0;
        }
    }
    
    if ( isdefined( level.a_electroball_grenades ) )
    {
        level.a_electroball_grenades = array::remove_undefined( level.a_electroball_grenades );
        a_active_grenades = array::filter( level.a_electroball_grenades, 0, &mechzfiltergrenadesbyowner, entity );
        entity.activegrenades = a_active_grenades.size;
        return;
    }
    
    entity.activegrenades = 0;
}

// Namespace mechzbehavior
// Params 2, eflags: 0x4
// Checksum 0x8f624b3f, Offset: 0x1ad0
// Size: 0x34, Type: bool
function private mechzfiltergrenadesbyowner( grenade, mechz )
{
    if ( grenade.owner === mechz )
    {
        return true;
    }
    
    return false;
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0xc5d2d7a5, Offset: 0x1b10
// Size: 0x43a
function private mechzberserkknockdownservice( entity )
{
    velocity = entity getvelocity();
    predict_time = 0.3;
    predicted_pos = entity.origin + velocity * predict_time;
    move_dist_sq = distancesquared( predicted_pos, entity.origin );
    speed = move_dist_sq / predict_time;
    
    if ( speed >= 10 )
    {
        a_zombies = getaiarchetypearray( "zombie" );
        a_filtered_zombies = array::filter( a_zombies, 0, &mechzzombieeligibleforberserkknockdown, entity, predicted_pos );
        
        if ( a_filtered_zombies.size > 0 )
        {
            foreach ( zombie in a_filtered_zombies )
            {
                zombie.knockdown = 1;
                zombie.knockdown_type = "knockdown_shoved";
                zombie_to_mechz = entity.origin - zombie.origin;
                zombie_to_mechz_2d = vectornormalize( ( zombie_to_mechz[ 0 ], zombie_to_mechz[ 1 ], 0 ) );
                zombie_forward = anglestoforward( zombie.angles );
                zombie_forward_2d = vectornormalize( ( zombie_forward[ 0 ], zombie_forward[ 1 ], 0 ) );
                zombie_right = anglestoright( zombie.angles );
                zombie_right_2d = vectornormalize( ( zombie_right[ 0 ], zombie_right[ 1 ], 0 ) );
                dot = vectordot( zombie_to_mechz_2d, zombie_forward_2d );
                
                if ( dot >= 0.5 )
                {
                    zombie.knockdown_direction = "front";
                    zombie.getup_direction = "getup_back";
                    continue;
                }
                
                if ( dot < 0.5 && dot > -0.5 )
                {
                    dot = vectordot( zombie_to_mechz_2d, zombie_right_2d );
                    
                    if ( dot > 0 )
                    {
                        zombie.knockdown_direction = "right";
                        
                        if ( math::cointoss() )
                        {
                            zombie.getup_direction = "getup_back";
                        }
                        else
                        {
                            zombie.getup_direction = "getup_belly";
                        }
                    }
                    else
                    {
                        zombie.knockdown_direction = "left";
                        zombie.getup_direction = "getup_belly";
                    }
                    
                    continue;
                }
                
                zombie.knockdown_direction = "back";
                zombie.getup_direction = "getup_belly";
            }
        }
    }
}

// Namespace mechzbehavior
// Params 3, eflags: 0x4
// Checksum 0x27164013, Offset: 0x1f58
// Size: 0x1c4, Type: bool
function private mechzzombieeligibleforberserkknockdown( zombie, mechz, predicted_pos )
{
    if ( zombie.knockdown === 1 )
    {
        return false;
    }
    
    knockdown_dist_sq = 2304;
    dist_sq = distancesquared( predicted_pos, zombie.origin );
    
    if ( dist_sq > knockdown_dist_sq )
    {
        return false;
    }
    
    if ( zombie.is_immune_to_knockdown === 1 )
    {
        return false;
    }
    
    origin = mechz.origin;
    facing_vec = anglestoforward( mechz.angles );
    enemy_vec = zombie.origin - origin;
    enemy_yaw_vec = ( enemy_vec[ 0 ], enemy_vec[ 1 ], 0 );
    facing_yaw_vec = ( facing_vec[ 0 ], facing_vec[ 1 ], 0 );
    enemy_yaw_vec = vectornormalize( enemy_yaw_vec );
    facing_yaw_vec = vectornormalize( facing_yaw_vec );
    enemy_dot = vectordot( facing_yaw_vec, enemy_yaw_vec );
    
    if ( enemy_dot < 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace mechzbehavior
// Params 1
// Checksum 0x68ed31, Offset: 0x2128
// Size: 0xe6, Type: bool
function mechzshouldmelee( entity )
{
    if ( !isdefined( entity.enemy ) )
    {
        return false;
    }
    
    if ( distancesquared( entity.origin, entity.enemy.origin ) > 12544 )
    {
        return false;
    }
    
    if ( isdefined( entity.enemy.usingvehicle ) && entity.enemy.usingvehicle )
    {
        return true;
    }
    
    yaw = abs( zombie_utility::getyawtoenemy() );
    
    if ( yaw > 45 )
    {
        return false;
    }
    
    return true;
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x4653e3c0, Offset: 0x2218
// Size: 0x2c, Type: bool
function private mechzshouldshowpain( entity )
{
    if ( entity.partdestroyed === 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x47a72c52, Offset: 0x2250
// Size: 0x140, Type: bool
function private mechzshouldshootgrenade( entity )
{
    if ( entity.berserk === 1 )
    {
        return false;
    }
    
    if ( entity.gun_attached !== 1 )
    {
        return false;
    }
    
    if ( !isdefined( entity.favoriteenemy ) )
    {
        return false;
    }
    
    if ( entity.burstgrenadesfired >= 3 )
    {
        return false;
    }
    
    if ( entity.activegrenades >= 9 )
    {
        return false;
    }
    
    if ( !entity mechzserverutils::mechzgrenadecheckinarc() )
    {
        return false;
    }
    
    if ( !entity cansee( entity.favoriteenemy ) )
    {
        return false;
    }
    
    dist_sq = distancesquared( entity.origin, entity.favoriteenemy.origin );
    
    if ( dist_sq < 62500 || dist_sq > 1440000 )
    {
        return false;
    }
    
    return true;
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0xbbe24c5d, Offset: 0x2398
// Size: 0x1f8, Type: bool
function private mechzshouldshootflame( entity )
{
    /#
        if ( isdefined( entity.shoot_flame ) && entity.shoot_flame )
        {
            return true;
        }
    #/
    
    if ( entity.berserk === 1 )
    {
        return false;
    }
    
    if ( isdefined( entity.isshootingflame ) && entity.isshootingflame && gettime() < entity.stopshootingflametime )
    {
        return true;
    }
    
    if ( !isdefined( entity.favoriteenemy ) )
    {
        return false;
    }
    
    if ( entity.isshootingflame === 1 && entity.stopshootingflametime <= gettime() )
    {
        return false;
    }
    
    if ( entity.nextflametime > gettime() )
    {
        return false;
    }
    
    if ( !entity mechzserverutils::mechzcheckinarc( 26, "tag_flamethrower_fx" ) )
    {
        return false;
    }
    
    dist_sq = distancesquared( entity.origin, entity.favoriteenemy.origin );
    
    if ( dist_sq < 9216 || dist_sq > 50625 )
    {
        return false;
    }
    
    can_see = bullettracepassed( entity.origin + ( 0, 0, 36 ), entity.favoriteenemy.origin + ( 0, 0, 36 ), 0, undefined );
    
    if ( !can_see )
    {
        return false;
    }
    
    return true;
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x4dfb1d87, Offset: 0x2598
// Size: 0x156, Type: bool
function private mechzshouldshootflamesweep( entity )
{
    if ( entity.berserk === 1 )
    {
        return false;
    }
    
    if ( !mechzshouldshootflame( entity ) )
    {
        return false;
    }
    
    if ( randomint( 100 ) > 10 )
    {
        return false;
    }
    
    near_players = 0;
    players = getplayers();
    
    foreach ( player in players )
    {
        if ( distance2dsquared( entity.origin, player.origin ) < 10000 )
        {
            near_players++;
        }
    }
    
    if ( near_players < 2 )
    {
        return false;
    }
    
    return true;
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0xe898d1a1, Offset: 0x26f8
// Size: 0x44, Type: bool
function private mechzshouldturnberserk( entity )
{
    if ( entity.berserk === 1 && entity.hasturnedberserk !== 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x86f0f149, Offset: 0x2748
// Size: 0x3a, Type: bool
function private mechzshouldstun( entity )
{
    if ( isdefined( entity.stun ) && entity.stun )
    {
        return true;
    }
    
    return false;
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x1a2651e1, Offset: 0x2790
// Size: 0x3a, Type: bool
function private mechzshouldstumble( entity )
{
    if ( isdefined( entity.stumble ) && entity.stumble )
    {
        return true;
    }
    
    return false;
}

// Namespace mechzbehavior
// Params 2, eflags: 0x4
// Checksum 0x548bd0bd, Offset: 0x27d8
// Size: 0x48
function private mechzshootgrenadeaction( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    entity.grenadestarttime = gettime() + 3000;
    return 5;
}

// Namespace mechzbehavior
// Params 2, eflags: 0x4
// Checksum 0x2673e98c, Offset: 0x2828
// Size: 0x44
function private mechzshootgrenadeactionupdate( entity, asmstatename )
{
    if ( !( isdefined( entity.shoot_grenade ) && entity.shoot_grenade ) )
    {
        return 4;
    }
    
    return 5;
}

// Namespace mechzbehavior
// Params 2, eflags: 0x4
// Checksum 0x2f1a8bd6, Offset: 0x2878
// Size: 0x48
function private mechzstunstart( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    entity.stuntime = gettime() + 500;
    return 5;
}

// Namespace mechzbehavior
// Params 2, eflags: 0x4
// Checksum 0x35f1d3ca, Offset: 0x28c8
// Size: 0x32
function private mechzstunupdate( entity, asmstatename )
{
    if ( gettime() > entity.stuntime )
    {
        return 4;
    }
    
    return 5;
}

// Namespace mechzbehavior
// Params 2, eflags: 0x4
// Checksum 0x7fea3d7b, Offset: 0x2908
// Size: 0x40
function private mechzstunend( entity, asmstatename )
{
    entity.stun = 0;
    entity.stumble_stun_cooldown_time = gettime() + 10000;
    return 4;
}

// Namespace mechzbehavior
// Params 2, eflags: 0x4
// Checksum 0x4dbcb46b, Offset: 0x2950
// Size: 0x48
function private mechzstumblestart( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    entity.stumbletime = gettime() + 500;
    return 5;
}

// Namespace mechzbehavior
// Params 2, eflags: 0x4
// Checksum 0x5747d9b9, Offset: 0x29a0
// Size: 0x32
function private mechzstumbleupdate( entity, asmstatename )
{
    if ( gettime() > entity.stumbletime )
    {
        return 4;
    }
    
    return 5;
}

// Namespace mechzbehavior
// Params 2, eflags: 0x4
// Checksum 0xf708103c, Offset: 0x29e0
// Size: 0x40
function private mechzstumbleend( entity, asmstatename )
{
    entity.stumble = 0;
    entity.stumble_stun_cooldown_time = gettime() + 10000;
    return 4;
}

// Namespace mechzbehavior
// Params 2
// Checksum 0x883dd19f, Offset: 0x2a28
// Size: 0x48
function mechzshootflameactionstart( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    mechzshootflame( entity );
    return 5;
}

// Namespace mechzbehavior
// Params 2
// Checksum 0x88e62f42, Offset: 0x2a78
// Size: 0x130
function mechzshootflameactionupdate( entity, asmstatename )
{
    if ( isdefined( entity.berserk ) && entity.berserk )
    {
        mechzstopflame( entity );
        return 4;
    }
    
    if ( isdefined( mechzshouldmelee( entity ) ) && mechzshouldmelee( entity ) )
    {
        mechzstopflame( entity );
        return 4;
    }
    
    if ( isdefined( entity.isshootingflame ) && entity.isshootingflame )
    {
        if ( isdefined( entity.stopshootingflametime ) && gettime() > entity.stopshootingflametime )
        {
            mechzstopflame( entity );
            return 4;
        }
        
        mechzupdateflame( entity );
    }
    
    return 5;
}

// Namespace mechzbehavior
// Params 2
// Checksum 0x985a6238, Offset: 0x2bb0
// Size: 0x30
function mechzshootflameactionend( entity, asmstatename )
{
    mechzstopflame( entity );
    return 4;
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x52640d37, Offset: 0x2be8
// Size: 0x4c
function private mechzshootgrenade( entity )
{
    entity.burstgrenadesfired++;
    
    if ( entity.burstgrenadesfired >= 3 )
    {
        entity.nextgrenadetime = gettime() + 6000;
    }
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x3f71caa2, Offset: 0x2c40
// Size: 0x24
function private mechzshootflame( entity )
{
    entity thread mechzdelayflame();
}

// Namespace mechzbehavior
// Params 0, eflags: 0x4
// Checksum 0x4d59c986, Offset: 0x2c70
// Size: 0x70
function private mechzdelayflame()
{
    self endon( #"death" );
    self notify( #"mechzdelayflame" );
    self endon( #"mechzdelayflame" );
    wait 0.3;
    self clientfield::set( "mechz_ft", 1 );
    self.isshootingflame = 1;
    self.stopshootingflametime = gettime() + 2500;
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x9828cf1d, Offset: 0x2ce8
// Size: 0x174
function private mechzupdateflame( entity )
{
    if ( isdefined( level.mechz_flamethrower_player_callback ) )
    {
        [[ level.mechz_flamethrower_player_callback ]]( entity );
    }
    else
    {
        players = getplayers();
        
        foreach ( player in players )
        {
            if ( !( isdefined( player.is_burning ) && player.is_burning ) )
            {
                if ( player istouching( entity.flametrigger ) )
                {
                    if ( isdefined( entity.mechzflamedamage ) )
                    {
                        player thread [[ entity.mechzflamedamage ]]();
                        continue;
                    }
                    
                    player thread playerflamedamage( entity );
                }
            }
        }
    }
    
    if ( isdefined( level.mechz_flamethrower_ai_callback ) )
    {
        [[ level.mechz_flamethrower_ai_callback ]]( entity );
    }
}

// Namespace mechzbehavior
// Params 1
// Checksum 0xc331eb5d, Offset: 0x2e68
// Size: 0xf8
function playerflamedamage( mechz )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( !( isdefined( self.is_burning ) && self.is_burning ) && zombie_utility::is_player_valid( self, 1 ) )
    {
        self.is_burning = 1;
        
        if ( !self hasperk( "specialty_armorvest" ) )
        {
            self burnplayer::setplayerburning( 1.5, 0.5, 30, mechz, undefined );
        }
        else
        {
            self burnplayer::setplayerburning( 1.5, 0.5, 20, mechz, undefined );
        }
        
        wait 1.5;
        self.is_burning = 0;
    }
}

// Namespace mechzbehavior
// Params 1
// Checksum 0xa9cad245, Offset: 0x2f68
// Size: 0x72
function mechzstopflame( entity )
{
    self notify( #"mechzdelayflame" );
    entity clientfield::set( "mechz_ft", 0 );
    entity.isshootingflame = 0;
    entity.nextflametime = gettime() + 7500;
    entity.stopshootingflametime = undefined;
}

// Namespace mechzbehavior
// Params 0
// Checksum 0xdd71ac10, Offset: 0x2fe8
// Size: 0xa4
function mechzgoberserk()
{
    entity = self;
    g_time = gettime();
    entity.berserkendtime = g_time + 10000;
    
    if ( entity.berserk !== 1 )
    {
        entity.berserk = 1;
        entity thread mechzendberserk();
        blackboard::setblackboardattribute( entity, "_locomotion_speed", "locomotion_speed_sprint" );
    }
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x3bf96614, Offset: 0x3098
// Size: 0x20
function private mechzplayedberserkintro( entity )
{
    entity.hasturnedberserk = 1;
}

// Namespace mechzbehavior
// Params 0, eflags: 0x4
// Checksum 0x2a1e43b4, Offset: 0x30c0
// Size: 0xa8
function private mechzendberserk()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( self.berserk === 1 )
    {
        if ( gettime() >= self.berserkendtime )
        {
            self.berserk = 0;
            self.hasturnedberserk = 0;
            self asmsetanimationrate( 1 );
            blackboard::setblackboardattribute( self, "_locomotion_speed", "locomotion_speed_run" );
        }
        
        wait 0.25;
    }
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x660f1fb7, Offset: 0x3170
// Size: 0x2c
function private mechzattackstart( entity )
{
    entity clientfield::set( "mechz_face", 1 );
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x4c604890, Offset: 0x31a8
// Size: 0x2c
function private mechzdeathstart( entity )
{
    entity clientfield::set( "mechz_face", 2 );
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0x6631c3c4, Offset: 0x31e0
// Size: 0x2c
function private mechzidlestart( entity )
{
    entity clientfield::set( "mechz_face", 3 );
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0xf4f64d0d, Offset: 0x3218
// Size: 0x2c
function private mechzpainstart( entity )
{
    entity clientfield::set( "mechz_face", 4 );
}

// Namespace mechzbehavior
// Params 1, eflags: 0x4
// Checksum 0xb2d5b22a, Offset: 0x3250
// Size: 0x2a
function private mechzpainterminate( entity )
{
    entity.partdestroyed = 0;
    entity.show_pain_from_explosive_dmg = undefined;
}

#namespace mechzserverutils;

// Namespace mechzserverutils
// Params 0, eflags: 0x4
// Checksum 0x83d7ab87, Offset: 0x3288
// Size: 0x1f2
function private mechzspawnsetup()
{
    self disableaimassist();
    self.disableammodrop = 1;
    self.no_gib = 1;
    self.ignore_nuke = 1;
    self.ignore_enemy_count = 1;
    self.ignore_round_robbin_death = 1;
    self.zombie_move_speed = "run";
    blackboard::setblackboardattribute( self, "_locomotion_speed", "locomotion_speed_run" );
    self.ignorerunandgundist = 1;
    self mechzaddattachments();
    self.grenadecount = 9;
    self.nextflametime = gettime();
    self.stumble_stun_cooldown_time = gettime();
    
    /#
        self.debug_traversal_ast = "<dev string:x78>";
    #/
    
    self.flametrigger = spawn( "trigger_box", self.origin, 0, 200, 50, 25 );
    self.flametrigger enablelinkto();
    self.flametrigger.origin = self gettagorigin( "tag_flamethrower_fx" );
    self.flametrigger.angles = self gettagangles( "tag_flamethrower_fx" );
    self.flametrigger linkto( self, "tag_flamethrower_fx" );
    self thread weaponobjects::watchweaponobjectusage();
    self.pers = [];
    self.pers[ "team" ] = self.team;
}

// Namespace mechzserverutils
// Params 0, eflags: 0x4
// Checksum 0x7c76025e, Offset: 0x3488
// Size: 0x70
function private mechzflamewatcher()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( self.favoriteenemy ) )
        {
            if ( self.flametrigger istouching( self.favoriteenemy ) )
            {
                /#
                    printtoprightln( "<dev string:x87>" );
                #/
            }
        }
        
        wait 0.05;
    }
}

// Namespace mechzserverutils
// Params 0, eflags: 0x4
// Checksum 0xbf0bb662, Offset: 0x3500
// Size: 0x10c
function private mechzaddattachments()
{
    self.has_left_knee_armor = 1;
    self.left_knee_armor_health = 50;
    self.has_right_knee_armor = 1;
    self.right_knee_armor_health = 50;
    self.has_left_shoulder_armor = 1;
    self.left_shoulder_armor_health = 50;
    self.has_right_shoulder_armor = 1;
    self.right_shoulder_armor_health = 50;
    org = self gettagorigin( "tag_gun_spin" );
    ang = self gettagangles( "tag_gun_spin" );
    self.gun_attached = 1;
    self.has_faceplate = 1;
    self.faceplate_health = 50;
    self.has_powercap = 1;
    self.powercap_covered = 1;
    self.powercap_cover_health = 50;
    self.powercap_health = 50;
}

// Namespace mechzserverutils
// Params 12
// Checksum 0x690f974a, Offset: 0x3618
// Size: 0x16b4
function mechzdamagecallback( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex )
{
    if ( isdefined( self.b_flyin_done ) && !( isdefined( self.b_flyin_done ) && self.b_flyin_done ) )
    {
        return 0;
    }
    
    if ( isdefined( level.mechz_should_stun_override ) && !( isdefined( self.stumble ) && ( isdefined( self.stun ) && self.stun || self.stumble ) ) )
    {
        if ( self.stumble_stun_cooldown_time < gettime() && !( isdefined( self.berserk ) && self.berserk ) )
        {
            self [[ level.mechz_should_stun_override ]]( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex );
        }
    }
    
    if ( issubstr( weapon.name, "elemental_bow" ) && isdefined( inflictor ) && inflictor.classname === "rocket" )
    {
        return 0;
    }
    
    damage = mechzweapondamagemodifier( damage, weapon );
    
    if ( isdefined( level.mechz_damage_override ) )
    {
        damage = [[ level.mechz_damage_override ]]( attacker, damage );
    }
    
    if ( !isdefined( self.next_pain_time ) || gettime() >= self.next_pain_time )
    {
        self thread mechz_play_pain_audio();
        self.next_pain_time = gettime() + 250 + randomint( 500 );
    }
    
    if ( isdefined( self.damage_scoring_function ) )
    {
        self [[ self.damage_scoring_function ]]( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex );
    }
    
    if ( isdefined( level.mechz_staff_damage_override ) )
    {
        staffdamage = [[ level.mechz_staff_damage_override ]]( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex );
        
        if ( staffdamage > 0 )
        {
            n_mechz_damage_percent = 0.5;
            
            if ( !( isdefined( self.has_faceplate ) && self.has_faceplate ) && n_mechz_damage_percent < 1 )
            {
                n_mechz_damage_percent = 1;
            }
            
            staffdamage *= n_mechz_damage_percent;
            
            if ( isdefined( self.has_faceplate ) && self.has_faceplate )
            {
                self mechz_track_faceplate_damage( staffdamage );
            }
            
            /#
                iprintlnbold( "<dev string:x90>" + staffdamage + "<dev string:x9c>" + self.health - staffdamage );
            #/
            
            if ( !isdefined( self.explosive_dmg_taken ) )
            {
                self.explosive_dmg_taken = 0;
            }
            
            self.explosive_dmg_taken += staffdamage;
            
            if ( isdefined( level.mechz_explosive_damage_reaction_callback ) )
            {
                self [[ level.mechz_explosive_damage_reaction_callback ]]();
            }
            
            return staffdamage;
        }
    }
    
    if ( isdefined( level.mechz_explosive_damage_reaction_callback ) )
    {
        if ( isdefined( mod ) && mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE" )
        {
            n_mechz_damage_percentage = 0.5;
            
            if ( isdefined( attacker.personal_instakill ) && ( level.zombie_vars[ attacker.team ][ "zombie_insta_kill" ] || isdefined( attacker ) && isplayer( attacker ) && isalive( attacker ) && attacker.personal_instakill ) )
            {
                n_mechz_damage_percentage = 1;
            }
            
            explosive_damage = damage * n_mechz_damage_percentage;
            
            if ( !isdefined( self.explosive_dmg_taken ) )
            {
                self.explosive_dmg_taken = 0;
            }
            
            self.explosive_dmg_taken += explosive_damage;
            
            if ( isdefined( self.has_faceplate ) && self.has_faceplate )
            {
                self mechz_track_faceplate_damage( explosive_damage );
            }
            
            self [[ level.mechz_explosive_damage_reaction_callback ]]();
            
            /#
                iprintlnbold( "<dev string:xa3>" + explosive_damage + "<dev string:x9c>" + self.health - explosive_damage );
            #/
            
            return explosive_damage;
        }
    }
    
    if ( hitloc == "head" )
    {
        attacker show_hit_marker();
        
        /#
            iprintlnbold( "<dev string:xb3>" + damage + "<dev string:x9c>" + self.health - damage );
        #/
        
        return damage;
    }
    
    if ( hitloc !== "none" )
    {
        switch ( hitloc )
        {
            case "torso_upper":
                if ( self.has_faceplate == 1 )
                {
                    faceplate_pos = self gettagorigin( "j_faceplate" );
                    dist_sq = distancesquared( faceplate_pos, point );
                    
                    if ( dist_sq <= 144 )
                    {
                        self mechz_track_faceplate_damage( damage );
                        attacker show_hit_marker();
                    }
                    
                    headlamp_dist_sq = distancesquared( point, self gettagorigin( "tag_headlamp_FX" ) );
                    
                    if ( headlamp_dist_sq <= 9 )
                    {
                        self mechz_turn_off_headlamp( 1 );
                    }
                }
                
                partname = getpartname( "c_zom_mech_body", boneindex );
                
                if ( partname === "tag_powersupply" || self.powercap_covered === 1 && partname === "tag_powersupply_hit" )
                {
                    self mechz_track_powercap_cover_damage( damage );
                    attacker show_hit_marker();
                    
                    /#
                        iprintlnbold( "<dev string:xbe>" + damage * 0.1 + "<dev string:x9c>" + self.health - damage * 0.1 );
                    #/
                    
                    return ( damage * 0.1 );
                }
                else if ( partname === "tag_powersupply" || self.powercap_covered !== 1 && self.has_powercap === 1 && partname === "tag_powersupply_hit" )
                {
                    self mechz_track_powercap_damage( damage );
                    attacker show_hit_marker();
                    
                    /#
                        iprintlnbold( "<dev string:xbe>" + damage + "<dev string:x9c>" + self.health - damage );
                    #/
                    
                    return damage;
                }
                else if ( partname === "tag_powersupply" || self.powercap_covered !== 1 && self.has_powercap !== 1 && partname === "tag_powersupply_hit" )
                {
                    /#
                        iprintlnbold( "<dev string:xbe>" + damage * 0.5 + "<dev string:x9c>" + self.health - damage * 0.5 );
                    #/
                    
                    attacker show_hit_marker();
                    return ( damage * 0.5 );
                }
                
                if ( self.has_right_shoulder_armor === 1 && partname === "j_shoulderarmor_ri" )
                {
                    self mechz_track_rshoulder_armor_damage( damage );
                    
                    /#
                        iprintlnbold( "<dev string:xd5>" + damage * 0.1 + "<dev string:x9c>" + self.health - damage * 0.1 );
                    #/
                    
                    return ( damage * 0.1 );
                }
                
                if ( self.has_left_shoulder_armor === 1 && partname === "j_shoulderarmor_le" )
                {
                    self mechz_track_lshoulder_armor_damage( damage );
                    
                    /#
                        iprintlnbold( "<dev string:xd5>" + damage * 0.1 + "<dev string:x9c>" + self.health - damage * 0.1 );
                    #/
                    
                    return ( damage * 0.1 );
                }
                
                /#
                    iprintlnbold( "<dev string:xd5>" + damage * 0.1 + "<dev string:x9c>" + self.health - damage * 0.1 );
                #/
                
                return ( damage * 0.1 );
            case "left_leg_lower":
                partname = getpartname( "c_zom_mech_body", boneindex );
                
                if ( partname === "j_knee_attach_le" && self.has_left_knee_armor === 1 )
                {
                    self mechz_track_lknee_armor_damage( damage );
                }
                
                /#
                    iprintlnbold( "<dev string:xe7>" + damage * 0.1 + "<dev string:x9c>" + self.health - damage * 0.1 );
                #/
                
                return ( damage * 0.1 );
            case "right_leg_lower":
                partname = getpartname( "c_zom_mech_body", boneindex );
                
                if ( partname === "j_knee_attach_ri" && self.has_right_knee_armor === 1 )
                {
                    self mechz_track_rknee_armor_damage( damage );
                }
                
                /#
                    iprintlnbold( "<dev string:x100>" + damage * 0.1 + "<dev string:x9c>" + self.health - damage * 0.1 );
                #/
                
                return ( damage * 0.1 );
            case "left_arm_lower":
            case "left_arm_upper":
            case "left_hand":
                if ( isdefined( level.mechz_left_arm_damage_callback ) )
                {
                    self [[ level.mechz_left_arm_damage_callback ]]();
                }
                
                /#
                    iprintlnbold( "<dev string:x119>" + damage * 0.1 + "<dev string:x9c>" + self.health - damage * 0.1 );
                #/
                
                return ( damage * 0.1 );
            default:
                /#
                    iprintlnbold( "<dev string:x12c>" + damage * 0.1 + "<dev string:x9c>" + self.health - damage * 0.1 );
                #/
                
                return ( damage * 0.1 );
        }
    }
    
    if ( mod == "MOD_PROJECTILE" )
    {
        hit_damage = damage * 0.1;
        
        if ( self.has_faceplate !== 1 )
        {
            head_pos = self gettagorigin( "tag_eye" );
            dist_sq = distancesquared( head_pos, point );
            
            if ( dist_sq <= 144 )
            {
                /#
                    iprintlnbold( "<dev string:x141>" + damage + "<dev string:x9c>" + self.health - damage );
                #/
                
                attacker show_hit_marker();
                return damage;
            }
        }
        
        if ( self.has_faceplate === 1 )
        {
            faceplate_pos = self gettagorigin( "j_faceplate" );
            dist_sq = distancesquared( faceplate_pos, point );
            
            if ( dist_sq <= 144 )
            {
                self mechz_track_faceplate_damage( damage );
                attacker show_hit_marker();
            }
            
            headlamp_dist_sq = distancesquared( point, self gettagorigin( "tag_headlamp_FX" ) );
            
            if ( headlamp_dist_sq <= 9 )
            {
                self mechz_turn_off_headlamp( 1 );
            }
        }
        
        power_pos = self gettagorigin( "tag_powersupply_hit" );
        power_dist_sq = distancesquared( power_pos, point );
        
        if ( power_dist_sq <= 25 )
        {
            if ( self.powercap_covered !== 1 && self.has_powercap !== 1 )
            {
                /#
                    iprintlnbold( "<dev string:x157>" + damage + "<dev string:x9c>" + self.health - damage );
                #/
                
                attacker show_hit_marker();
                return damage;
            }
            
            if ( self.powercap_covered !== 1 && self.has_powercap === 1 )
            {
                self mechz_track_powercap_damage( damage );
                attacker show_hit_marker();
                
                /#
                    iprintlnbold( "<dev string:x157>" + damage + "<dev string:x9c>" + self.health - damage );
                #/
                
                return damage;
            }
            
            if ( self.powercap_covered === 1 )
            {
                self mechz_track_powercap_cover_damage( damage );
                attacker show_hit_marker();
            }
        }
        
        if ( self.has_right_shoulder_armor === 1 )
        {
            armor_pos = self gettagorigin( "j_shoulderarmor_ri" );
            dist_sq = distancesquared( armor_pos, point );
            
            if ( dist_sq <= 64 )
            {
                self mechz_track_rshoulder_armor_damage( damage );
            }
        }
        
        if ( self.has_left_shoulder_armor === 1 )
        {
            armor_pos = self gettagorigin( "j_shoulderarmor_le" );
            dist_sq = distancesquared( armor_pos, point );
            
            if ( dist_sq <= 64 )
            {
                self mechz_track_lshoulder_armor_damage( damage );
            }
        }
        
        if ( self.has_right_knee_armor === 1 )
        {
            armor_pos = self gettagorigin( "j_knee_attach_ri" );
            dist_sq = distancesquared( armor_pos, point );
            
            if ( dist_sq <= 36 )
            {
                self mechz_track_rknee_armor_damage( damage );
            }
        }
        
        if ( self.has_left_knee_armor === 1 )
        {
            armor_pos = self gettagorigin( "j_knee_attach_le" );
            dist_sq = distancesquared( armor_pos, point );
            
            if ( dist_sq <= 36 )
            {
                self mechz_track_lknee_armor_damage( damage );
            }
        }
        
        /#
            iprintlnbold( "<dev string:x171>" + hit_damage + "<dev string:x9c>" + self.health - hit_damage );
        #/
        
        return hit_damage;
    }
    else if ( mod == "MOD_PROJECTILE_SPLASH" )
    {
        hit_damage = damage * 0.2;
        i_num_armor_pieces = 0;
        
        if ( isdefined( level.mechz_faceplate_damage_override ) )
        {
            self [[ level.mechz_faceplate_damage_override ]]( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex );
        }
        
        if ( self.has_right_shoulder_armor === 1 )
        {
            i_num_armor_pieces += 1;
            right_shoulder_index = i_num_armor_pieces;
        }
        
        if ( self.has_left_shoulder_armor === 1 )
        {
            i_num_armor_pieces += 1;
            left_shoulder_index = i_num_armor_pieces;
        }
        
        if ( self.has_right_knee_armor === 1 )
        {
            i_num_armor_pieces += 1;
            right_knee_index = i_num_armor_pieces;
        }
        
        if ( self.has_left_knee_armor === 1 )
        {
            i_num_armor_pieces += 1;
            left_knee_index = i_num_armor_pieces;
        }
        
        if ( i_num_armor_pieces > 0 )
        {
            if ( i_num_armor_pieces <= 1 )
            {
                i_random = 0;
            }
            else
            {
                i_random = randomint( i_num_armor_pieces - 1 );
            }
            
            i_random += 1;
            
            if ( self.has_right_shoulder_armor === 1 && right_shoulder_index === i_random )
            {
                self mechz_track_rshoulder_armor_damage( damage );
            }
            
            if ( self.has_left_shoulder_armor === 1 && left_shoulder_index === i_random )
            {
                self mechz_track_lshoulder_armor_damage( damage );
            }
            
            if ( self.has_right_knee_armor === 1 && right_knee_index === i_random )
            {
                self mechz_track_rknee_armor_damage( damage );
            }
            
            if ( self.has_left_knee_armor === 1 && left_knee_index === i_random )
            {
                self mechz_track_lknee_armor_damage( damage );
            }
        }
        else
        {
            if ( self.powercap_covered === 1 )
            {
                self mechz_track_powercap_cover_damage( damage * 0.5 );
            }
            
            if ( self.has_faceplate == 1 )
            {
                self mechz_track_faceplate_damage( damage * 0.5 );
            }
        }
        
        /#
            iprintlnbold( "<dev string:x182>" + hit_damage + "<dev string:x9c>" + self.health - hit_damage );
        #/
        
        return hit_damage;
    }
    
    return 0;
}

// Namespace mechzserverutils
// Params 2, eflags: 0x4
// Checksum 0xc06bdf2f, Offset: 0x4cd8
// Size: 0x14a
function private mechzweapondamagemodifier( damage, weapon )
{
    if ( isdefined( weapon ) && isdefined( weapon.name ) )
    {
        if ( issubstr( weapon.name, "shotgun_fullauto" ) )
        {
            return ( damage * 0.5 );
        }
        
        if ( issubstr( weapon.name, "lmg_cqb" ) )
        {
            return ( damage * 0.65 );
        }
        
        if ( issubstr( weapon.name, "lmg_heavy" ) )
        {
            return ( damage * 0.65 );
        }
        
        if ( issubstr( weapon.name, "shotgun_precision" ) )
        {
            return ( damage * 0.65 );
        }
        
        if ( issubstr( weapon.name, "shotgun_semiauto" ) )
        {
            return ( damage * 0.75 );
        }
    }
    
    return damage;
}

// Namespace mechzserverutils
// Params 0
// Checksum 0xa5e536ca, Offset: 0x4e30
// Size: 0x24
function mechz_play_pain_audio()
{
    self playsound( "zmb_ai_mechz_destruction" );
}

// Namespace mechzserverutils
// Params 0
// Checksum 0x66f41b19, Offset: 0x4e60
// Size: 0x88
function show_hit_marker()
{
    if ( isdefined( self ) && isdefined( self.hud_damagefeedback ) )
    {
        self.hud_damagefeedback setshader( "damage_feedback", 24, 48 );
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime( 1 );
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace mechzserverutils
// Params 1
// Checksum 0x809ea9df, Offset: 0x4ef0
// Size: 0x3c
function hide_part( strtag )
{
    if ( self haspart( strtag ) )
    {
        self hidepart( strtag );
    }
}

// Namespace mechzserverutils
// Params 1
// Checksum 0x47d1ba10, Offset: 0x4f38
// Size: 0xe2
function mechz_track_faceplate_damage( damage )
{
    self.faceplate_health -= damage;
    
    if ( self.faceplate_health <= 0 )
    {
        self hide_part( "j_faceplate" );
        self clientfield::set( "mechz_faceplate_detached", 1 );
        self.has_faceplate = 0;
        self mechz_turn_off_headlamp();
        self.partdestroyed = 1;
        blackboard::setblackboardattribute( self, "_mechz_part", "mechz_faceplate" );
        self mechzbehavior::mechzgoberserk();
        level notify( #"mechz_faceplate_detached" );
    }
}

// Namespace mechzserverutils
// Params 1
// Checksum 0x6a0d5b24, Offset: 0x5028
// Size: 0xac
function mechz_track_powercap_cover_damage( damage )
{
    self.powercap_cover_health -= damage;
    
    if ( self.powercap_cover_health <= 0 )
    {
        self hide_part( "tag_powersupply" );
        self clientfield::set( "mechz_powercap_detached", 1 );
        self.powercap_covered = 0;
        self.partdestroyed = 1;
        blackboard::setblackboardattribute( self, "_mechz_part", "mechz_powercore" );
    }
}

// Namespace mechzserverutils
// Params 1
// Checksum 0x6208f9b8, Offset: 0x50e0
// Size: 0x1a2
function mechz_track_powercap_damage( damage )
{
    self.powercap_health -= damage;
    
    if ( self.powercap_health <= 0 )
    {
        if ( isdefined( level.mechz_powercap_destroyed_callback ) )
        {
            self [[ level.mechz_powercap_destroyed_callback ]]();
        }
        
        self hide_part( "tag_gun_spin" );
        self hide_part( "tag_gun_barrel1" );
        self hide_part( "tag_gun_barrel2" );
        self hide_part( "tag_gun_barrel3" );
        self hide_part( "tag_gun_barrel4" );
        self hide_part( "tag_gun_barrel5" );
        self hide_part( "tag_gun_barrel6" );
        self clientfield::set( "mechz_claw_detached", 1 );
        self.has_powercap = 0;
        self.gun_attached = 0;
        self.partdestroyed = 1;
        blackboard::setblackboardattribute( self, "_mechz_part", "mechz_gun" );
        level notify( #"mechz_gun_detached" );
    }
}

// Namespace mechzserverutils
// Params 1
// Checksum 0x5a9426f1, Offset: 0x5290
// Size: 0x78
function mechz_track_rknee_armor_damage( damage )
{
    self.right_knee_armor_health -= damage;
    
    if ( self.right_knee_armor_health <= 0 )
    {
        self hide_part( "j_knee_attach_ri" );
        self clientfield::set( "mechz_rknee_armor_detached", 1 );
        self.has_right_knee_armor = 0;
    }
}

// Namespace mechzserverutils
// Params 1
// Checksum 0x71910697, Offset: 0x5310
// Size: 0x78
function mechz_track_lknee_armor_damage( damage )
{
    self.left_knee_armor_health -= damage;
    
    if ( self.left_knee_armor_health <= 0 )
    {
        self hide_part( "j_knee_attach_le" );
        self clientfield::set( "mechz_lknee_armor_detached", 1 );
        self.has_left_knee_armor = 0;
    }
}

// Namespace mechzserverutils
// Params 1
// Checksum 0xddd26758, Offset: 0x5390
// Size: 0x78
function mechz_track_rshoulder_armor_damage( damage )
{
    self.right_shoulder_armor_health -= damage;
    
    if ( self.right_shoulder_armor_health <= 0 )
    {
        self hide_part( "j_shoulderarmor_ri" );
        self clientfield::set( "mechz_rshoulder_armor_detached", 1 );
        self.has_right_shoulder_armor = 0;
    }
}

// Namespace mechzserverutils
// Params 1
// Checksum 0x38e7245d, Offset: 0x5410
// Size: 0x78
function mechz_track_lshoulder_armor_damage( damage )
{
    self.left_shoulder_armor_health -= damage;
    
    if ( self.left_shoulder_armor_health <= 0 )
    {
        self hide_part( "j_shoulderarmor_le" );
        self clientfield::set( "mechz_lshoulder_armor_detached", 1 );
        self.has_left_shoulder_armor = 0;
    }
}

// Namespace mechzserverutils
// Params 2
// Checksum 0x603f88af, Offset: 0x5490
// Size: 0x224, Type: bool
function mechzcheckinarc( right_offset, aim_tag )
{
    origin = self.origin;
    angles = self.angles;
    
    if ( isdefined( aim_tag ) )
    {
        origin = self gettagorigin( aim_tag );
        angles = self gettagangles( aim_tag );
    }
    
    if ( isdefined( right_offset ) )
    {
        right_angle = anglestoright( angles );
        origin += right_angle * right_offset;
    }
    
    facing_vec = anglestoforward( angles );
    enemy_vec = self.favoriteenemy.origin - origin;
    enemy_yaw_vec = ( enemy_vec[ 0 ], enemy_vec[ 1 ], 0 );
    facing_yaw_vec = ( facing_vec[ 0 ], facing_vec[ 1 ], 0 );
    enemy_yaw_vec = vectornormalize( enemy_yaw_vec );
    facing_yaw_vec = vectornormalize( facing_yaw_vec );
    enemy_dot = vectordot( facing_yaw_vec, enemy_yaw_vec );
    
    if ( enemy_dot < 0.5 )
    {
        return false;
    }
    
    enemy_angles = vectortoangles( enemy_vec );
    
    if ( abs( angleclamp180( enemy_angles[ 0 ] ) ) > 60 )
    {
        return false;
    }
    
    return true;
}

// Namespace mechzserverutils
// Params 1, eflags: 0x4
// Checksum 0x51dedcce, Offset: 0x56c0
// Size: 0x1c4, Type: bool
function private mechzgrenadecheckinarc( right_offset )
{
    origin = self.origin;
    
    if ( isdefined( right_offset ) )
    {
        right_angle = anglestoright( self.angles );
        origin += right_angle * right_offset;
    }
    
    facing_vec = anglestoforward( self.angles );
    enemy_vec = self.favoriteenemy.origin - origin;
    enemy_yaw_vec = ( enemy_vec[ 0 ], enemy_vec[ 1 ], 0 );
    facing_yaw_vec = ( facing_vec[ 0 ], facing_vec[ 1 ], 0 );
    enemy_yaw_vec = vectornormalize( enemy_yaw_vec );
    facing_yaw_vec = vectornormalize( facing_yaw_vec );
    enemy_dot = vectordot( facing_yaw_vec, enemy_yaw_vec );
    
    if ( enemy_dot < 0.5 )
    {
        return false;
    }
    
    enemy_angles = vectortoangles( enemy_vec );
    
    if ( abs( angleclamp180( enemy_angles[ 0 ] ) ) > 60 )
    {
        return false;
    }
    
    return true;
}

// Namespace mechzserverutils
// Params 1
// Checksum 0x2830c23d, Offset: 0x5890
// Size: 0x64
function mechz_turn_off_headlamp( headlamp_broken )
{
    if ( headlamp_broken !== 1 )
    {
        self clientfield::set( "mechz_headlamp_off", 1 );
        return;
    }
    
    self clientfield::set( "mechz_headlamp_off", 2 );
}

