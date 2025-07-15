#using scripts/codescripts/struct;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/margwa;
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

#namespace margwabehavior;

// Namespace margwabehavior
// Params 0, eflags: 0x2
// Checksum 0xa965e697, Offset: 0xba8
// Size: 0x374
function autoexec init()
{
    initmargwabehaviorsandasm();
    spawner::add_archetype_spawn_function( "margwa", &archetypemargwablackboardinit );
    spawner::add_archetype_spawn_function( "margwa", &margwaserverutils::margwaspawnsetup );
    clientfield::register( "actor", "margwa_head_left", 1, 2, "int" );
    clientfield::register( "actor", "margwa_head_mid", 1, 2, "int" );
    clientfield::register( "actor", "margwa_head_right", 1, 2, "int" );
    clientfield::register( "actor", "margwa_fx_in", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_fx_out", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_fx_spawn", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_smash", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_head_left_hit", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_head_mid_hit", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_head_right_hit", 1, 1, "counter" );
    clientfield::register( "actor", "margwa_head_killed", 1, 2, "int" );
    clientfield::register( "actor", "margwa_jaw", 1, 6, "int" );
    clientfield::register( "toplayer", "margwa_head_explosion", 1, 1, "counter" );
    clientfield::register( "scriptmover", "margwa_fx_travel", 1, 1, "int" );
    clientfield::register( "scriptmover", "margwa_fx_travel_tell", 1, 1, "int" );
    clientfield::register( "actor", "supermargwa", 1, 1, "int" );
    initdirecthitweapons();
}

// Namespace margwabehavior
// Params 0, eflags: 0x4
// Checksum 0xc4888c0d, Offset: 0xf28
// Size: 0xde
function private initdirecthitweapons()
{
    if ( !isdefined( level.dhweapons ) )
    {
        level.dhweapons = [];
    }
    
    level.dhweapons[ level.dhweapons.size ] = "ray_gun";
    level.dhweapons[ level.dhweapons.size ] = "ray_gun_upgraded";
    level.dhweapons[ level.dhweapons.size ] = "pistol_standard_upgraded";
    level.dhweapons[ level.dhweapons.size ] = "pistol_revolver38_upgraded";
    level.dhweapons[ level.dhweapons.size ] = "pistol_revolver38lh_upgraded";
    level.dhweapons[ level.dhweapons.size ] = "launcher_standard";
    level.dhweapons[ level.dhweapons.size ] = "launcher_standard_upgraded";
}

// Namespace margwabehavior
// Params 1
// Checksum 0x8767be64, Offset: 0x1010
// Size: 0xa2
function adddirecthitweapon( weaponname )
{
    foreach ( weapon in level.dhweapons )
    {
        if ( weapon == weaponname )
        {
            return;
        }
    }
    
    level.dhweapons[ level.dhweapons.size ] = weaponname;
}

// Namespace margwabehavior
// Params 0, eflags: 0x4
// Checksum 0xa7b6071c, Offset: 0x10c0
// Size: 0x654
function private initmargwabehaviorsandasm()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTargetService", &margwatargetservice );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldSmashAttack", &margwashouldsmashattack );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldSwipeAttack", &margwashouldswipeattack );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldShowPain", &margwashouldshowpain );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldReactStun", &margwashouldreactstun );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldReactIDGun", &margwashouldreactidgun );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldReactSword", &margwashouldreactsword );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldSpawn", &margwashouldspawn );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldFreeze", &margwashouldfreeze );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldTeleportIn", &margwashouldteleportin );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldTeleportOut", &margwashouldteleportout );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldWait", &margwashouldwait );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaShouldReset", &margwashouldreset );
    behaviortreenetworkutility::registerbehaviortreeaction( "margwaReactStunAction", &margwareactstunaction, undefined, undefined );
    behaviortreenetworkutility::registerbehaviortreeaction( "margwaSwipeAttackAction", &margwaswipeattackaction, &margwaswipeattackactionupdate, undefined );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaIdleStart", &margwaidlestart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaMoveStart", &margwamovestart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTraverseActionStart", &margwatraverseactionstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTeleportInStart", &margwateleportinstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTeleportInTerminate", &margwateleportinterminate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTeleportOutStart", &margwateleportoutstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaTeleportOutTerminate", &margwateleportoutterminate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaPainStart", &margwapainstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaPainTerminate", &margwapainterminate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactStunStart", &margwareactstunstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactStunTerminate", &margwareactstunterminate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactIDGunStart", &margwareactidgunstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactIDGunTerminate", &margwareactidgunterminate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactSwordStart", &margwareactswordstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaReactSwordTerminate", &margwareactswordterminate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaSpawnStart", &margwaspawnstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaSmashAttackStart", &margwasmashattackstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaSmashAttackTerminate", &margwasmashattackterminate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaSwipeAttackStart", &margwaswipeattackstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "margwaSwipeAttackTerminate", &margwaswipeattackterminate );
    animationstatenetwork::registeranimationmocomp( "mocomp_teleport_traversal@margwa", &mocompmargwateleporttraversalinit, &mocompmargwateleporttraversalupdate, &mocompmargwateleporttraversalterminate );
    animationstatenetwork::registernotetrackhandlerfunction( "margwa_smash_attack", &margwanotetracksmashattack );
    animationstatenetwork::registernotetrackhandlerfunction( "margwa_bodyfall large", &margwanotetrackbodyfall );
    animationstatenetwork::registernotetrackhandlerfunction( "margwa_melee_fire", &margwanotetrackpainmelee );
}

// Namespace margwabehavior
// Params 0, eflags: 0x4
// Checksum 0xfa165bd7, Offset: 0x1720
// Size: 0x1e4
function private archetypemargwablackboardinit()
{
    blackboard::createblackboardforentity( self );
    self aiutility::registerutilityblackboardattributes();
    blackboard::registerblackboardattribute( self, "_locomotion_speed", "locomotion_speed_walk", undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x28>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_board_attack_spot", undefined, undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x3a>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x4d>" );
        #/
    }
    
    blackboard::registerblackboardattribute( self, "_zombie_damageweapon_type", "regular", undefined );
    
    if ( isactor( self ) )
    {
        /#
            self trackblackboardattribute( "<dev string:x65>" );
        #/
    }
    
    self.___archetypeonanimscriptedcallback = &archetypemargwaonanimscriptedcallback;
    
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x8cf5c123, Offset: 0x1910
// Size: 0x34
function private archetypemargwaonanimscriptedcallback( entity )
{
    entity.__blackboard = undefined;
    entity archetypemargwablackboardinit();
}

// Namespace margwabehavior
// Params 0, eflags: 0x4
// Checksum 0x4ceb83c0, Offset: 0x1950
// Size: 0x2a
function private bb_getshouldturn()
{
    if ( isdefined( self.should_turn ) && self.should_turn )
    {
        return "should_turn";
    }
    
    return "should_not_turn";
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0xa780ba6f, Offset: 0x1988
// Size: 0x330
function private margwanotetracksmashattack( entity )
{
    players = getplayers();
    
    foreach ( player in players )
    {
        smashpos = entity.origin + vectorscale( anglestoforward( self.angles ), 60 );
        distsq = distancesquared( smashpos, player.origin );
        
        if ( distsq < 20736 )
        {
            if ( !isgodmode( player ) )
            {
                if ( isdefined( player.hasriotshield ) && player.hasriotshield )
                {
                    damageshield = 0;
                    attackdir = player.origin - self.origin;
                    
                    if ( isdefined( player.hasriotshieldequipped ) && player.hasriotshieldequipped )
                    {
                        if ( player margwaserverutils::shieldfacing( attackdir, 0.2 ) )
                        {
                            damageshield = 1;
                        }
                    }
                    else if ( player margwaserverutils::shieldfacing( attackdir, 0.2, 0 ) )
                    {
                        damageshield = 1;
                    }
                    
                    if ( damageshield )
                    {
                        self clientfield::increment( "margwa_smash" );
                        shield_damage = level.weaponriotshield.weaponstarthitpoints;
                        
                        if ( isdefined( player.weaponriotshield ) )
                        {
                            shield_damage = player.weaponriotshield.weaponstarthitpoints;
                        }
                        
                        player [[ player.player_shield_apply_damage ]]( shield_damage, 0 );
                        continue;
                    }
                }
                
                if ( isdefined( level.margwa_smash_damage_callback ) && isfunctionptr( level.margwa_smash_damage_callback ) )
                {
                    if ( player [[ level.margwa_smash_damage_callback ]]( self ) )
                    {
                        continue;
                    }
                }
                
                self clientfield::increment( "margwa_smash" );
                player dodamage( 166, self.origin, self );
            }
        }
    }
    
    if ( isdefined( self.smashattackcb ) )
    {
        self [[ self.smashattackcb ]]();
    }
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0xcc2ff858, Offset: 0x1cc0
// Size: 0x50
function private margwanotetrackbodyfall( entity )
{
    if ( self.archetype == "margwa" )
    {
        entity ghost();
        
        if ( isdefined( self.bodyfallcb ) )
        {
            self [[ self.bodyfallcb ]]();
        }
    }
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x3d30e629, Offset: 0x1d18
// Size: 0x24
function private margwanotetrackpainmelee( entity )
{
    entity melee();
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0xd35cfd3f, Offset: 0x1d48
// Size: 0x158
function private margwatargetservice( entity )
{
    if ( isdefined( entity.ignoreall ) && entity.ignoreall )
    {
        return 0;
    }
    
    player = zombie_utility::get_closest_valid_player( self.origin, self.ignore_player );
    
    if ( !isdefined( player ) )
    {
        if ( isdefined( self.ignore_player ) )
        {
            if ( isdefined( level._should_skip_ignore_player_logic ) && [[ level._should_skip_ignore_player_logic ]]() )
            {
                return;
            }
            
            self.ignore_player = [];
        }
        
        self setgoal( self.origin );
        return 0;
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

// Namespace margwabehavior
// Params 1
// Checksum 0x55fea848, Offset: 0x1ea8
// Size: 0x8e, Type: bool
function margwashouldsmashattack( entity )
{
    if ( !isdefined( entity.enemy ) )
    {
        return false;
    }
    
    if ( !entity margwaserverutils::insmashattackrange( entity.enemy ) )
    {
        return false;
    }
    
    yaw = abs( zombie_utility::getyawtoenemy() );
    
    if ( yaw > 45 )
    {
        return false;
    }
    
    return true;
}

// Namespace margwabehavior
// Params 1
// Checksum 0xaa61328b, Offset: 0x1f40
// Size: 0xa6, Type: bool
function margwashouldswipeattack( entity )
{
    if ( !isdefined( entity.enemy ) )
    {
        return false;
    }
    
    if ( distancesquared( entity.origin, entity.enemy.origin ) > 16384 )
    {
        return false;
    }
    
    yaw = abs( zombie_utility::getyawtoenemy() );
    
    if ( yaw > 45 )
    {
        return false;
    }
    
    return true;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x55b8c89e, Offset: 0x1ff0
// Size: 0xfe, Type: bool
function private margwashouldshowpain( entity )
{
    if ( isdefined( entity.headdestroyed ) )
    {
        headinfo = entity.head[ entity.headdestroyed ];
        
        switch ( headinfo.cf )
        {
            case "margwa_head_left":
                blackboard::setblackboardattribute( self, "_margwa_head", "left" );
                break;
            case "margwa_head_mid":
                blackboard::setblackboardattribute( self, "_margwa_head", "middle" );
                break;
            default:
                blackboard::setblackboardattribute( self, "_margwa_head", "right" );
                break;
        }
        
        return true;
    }
    
    return false;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x6f008555, Offset: 0x20f8
// Size: 0x3a, Type: bool
function private margwashouldreactstun( entity )
{
    if ( isdefined( entity.reactstun ) && entity.reactstun )
    {
        return true;
    }
    
    return false;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x99e54d21, Offset: 0x2140
// Size: 0x3a, Type: bool
function private margwashouldreactidgun( entity )
{
    if ( isdefined( entity.reactidgun ) && entity.reactidgun )
    {
        return true;
    }
    
    return false;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x5502adc7, Offset: 0x2188
// Size: 0x3a, Type: bool
function private margwashouldreactsword( entity )
{
    if ( isdefined( entity.reactsword ) && entity.reactsword )
    {
        return true;
    }
    
    return false;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x16151ad8, Offset: 0x21d0
// Size: 0x3a, Type: bool
function private margwashouldspawn( entity )
{
    if ( isdefined( entity.needspawn ) && entity.needspawn )
    {
        return true;
    }
    
    return false;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0xc130f05, Offset: 0x2218
// Size: 0x3a, Type: bool
function private margwashouldfreeze( entity )
{
    if ( isdefined( entity.isfrozen ) && entity.isfrozen )
    {
        return true;
    }
    
    return false;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x3bcaedeb, Offset: 0x2260
// Size: 0x3a, Type: bool
function private margwashouldteleportin( entity )
{
    if ( isdefined( entity.needteleportin ) && entity.needteleportin )
    {
        return true;
    }
    
    return false;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x244ff5fb, Offset: 0x22a8
// Size: 0x3a, Type: bool
function private margwashouldteleportout( entity )
{
    if ( isdefined( entity.needteleportout ) && entity.needteleportout )
    {
        return true;
    }
    
    return false;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x87da610, Offset: 0x22f0
// Size: 0x3a, Type: bool
function private margwashouldwait( entity )
{
    if ( isdefined( entity.waiting ) && entity.waiting )
    {
        return true;
    }
    
    return false;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0xbe201424, Offset: 0x2338
// Size: 0xaa, Type: bool
function private margwashouldreset( entity )
{
    if ( isdefined( entity.headdestroyed ) )
    {
        return true;
    }
    
    if ( isdefined( entity.reactidgun ) && entity.reactidgun )
    {
        return true;
    }
    
    if ( isdefined( entity.reactsword ) && entity.reactsword )
    {
        return true;
    }
    
    if ( isdefined( entity.reactstun ) && entity.reactstun )
    {
        return true;
    }
    
    return false;
}

// Namespace margwabehavior
// Params 2, eflags: 0x4
// Checksum 0xb4b5902e, Offset: 0x23f0
// Size: 0xf0
function private margwareactstunaction( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    stunactionast = entity astsearch( istring( asmstatename ) );
    stunactionanimation = animationstatenetworkutility::searchanimationmap( entity, stunactionast[ "animation" ] );
    closetime = getanimlength( stunactionanimation ) * 1000;
    entity margwaserverutils::margwacloseallheads( closetime );
    margwareactstunstart( entity );
    return 5;
}

// Namespace margwabehavior
// Params 2, eflags: 0x4
// Checksum 0xd06e7fc6, Offset: 0x24e8
// Size: 0xe8
function private margwaswipeattackaction( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    
    if ( !isdefined( entity.swipe_end_time ) )
    {
        swipeactionast = entity astsearch( istring( asmstatename ) );
        swipeactionanimation = animationstatenetworkutility::searchanimationmap( entity, swipeactionast[ "animation" ] );
        swipeactiontime = getanimlength( swipeactionanimation ) * 1000;
        entity.swipe_end_time = gettime() + swipeactiontime;
    }
    
    return 5;
}

// Namespace margwabehavior
// Params 2, eflags: 0x4
// Checksum 0xc27867e9, Offset: 0x25d8
// Size: 0x46
function private margwaswipeattackactionupdate( entity, asmstatename )
{
    if ( isdefined( entity.swipe_end_time ) && gettime() > entity.swipe_end_time )
    {
        return 4;
    }
    
    return 5;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x40d5dca6, Offset: 0x2628
// Size: 0x44
function private margwaidlestart( entity )
{
    if ( entity margwaserverutils::shouldupdatejaw() )
    {
        entity clientfield::set( "margwa_jaw", 1 );
    }
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x5deebad0, Offset: 0x2678
// Size: 0x8c
function private margwamovestart( entity )
{
    if ( entity margwaserverutils::shouldupdatejaw() )
    {
        if ( entity.zombie_move_speed == "run" )
        {
            entity clientfield::set( "margwa_jaw", 13 );
            return;
        }
        
        entity clientfield::set( "margwa_jaw", 7 );
    }
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x57cead69, Offset: 0x2710
// Size: 0xc
function private margwadeathaction( entity )
{
    
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0xdd88bf83, Offset: 0x2728
// Size: 0x14e
function private margwatraverseactionstart( entity )
{
    blackboard::setblackboardattribute( entity, "_traversal_type", entity.traversestartnode.animscript );
    
    if ( isdefined( entity.traversestartnode.animscript ) )
    {
        if ( entity margwaserverutils::shouldupdatejaw() )
        {
            switch ( entity.traversestartnode.animscript )
            {
                case "jump_down_36":
                    entity clientfield::set( "margwa_jaw", 21 );
                    break;
                case "jump_down_96":
                    entity clientfield::set( "margwa_jaw", 22 );
                    break;
                case "jump_up_36":
                    entity clientfield::set( "margwa_jaw", 24 );
                    break;
                default:
                    entity clientfield::set( "margwa_jaw", 25 );
                    break;
            }
        }
    }
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x84b64ec8, Offset: 0x2880
// Size: 0x154
function private margwateleportinstart( entity )
{
    entity unlink();
    
    if ( isdefined( entity.teleportpos ) )
    {
        entity forceteleport( entity.teleportpos );
    }
    
    entity show();
    entity pathmode( "move allowed" );
    entity.needteleportin = 0;
    blackboard::setblackboardattribute( self, "_margwa_teleport", "in" );
    
    if ( isdefined( self.traveler ) )
    {
        self.traveler clientfield::set( "margwa_fx_travel", 0 );
    }
    
    self clientfield::increment( "margwa_fx_in", 1 );
    
    if ( entity margwaserverutils::shouldupdatejaw() )
    {
        entity clientfield::set( "margwa_jaw", 17 );
    }
}

// Namespace margwabehavior
// Params 1
// Checksum 0xb1cfcfc2, Offset: 0x29e0
// Size: 0x4c
function margwateleportinterminate( entity )
{
    if ( isdefined( self.traveler ) )
    {
        self.traveler clientfield::set( "margwa_fx_travel", 0 );
    }
    
    entity.isteleporting = 0;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x646d917e, Offset: 0x2a38
// Size: 0xcc
function private margwateleportoutstart( entity )
{
    entity.needteleportout = 0;
    entity.isteleporting = 1;
    entity.teleportstart = entity.origin;
    blackboard::setblackboardattribute( self, "_margwa_teleport", "out" );
    self clientfield::increment( "margwa_fx_out", 1 );
    
    if ( entity margwaserverutils::shouldupdatejaw() )
    {
        entity clientfield::set( "margwa_jaw", 18 );
    }
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x70776916, Offset: 0x2b10
// Size: 0x134
function private margwateleportoutterminate( entity )
{
    if ( isdefined( entity.traveler ) )
    {
        entity.traveler.origin = entity gettagorigin( "j_spine_1" );
        entity.traveler clientfield::set( "margwa_fx_travel", 1 );
    }
    
    entity ghost();
    entity pathmode( "dont move" );
    
    if ( isdefined( entity.traveler ) )
    {
        entity linkto( entity.traveler );
    }
    
    if ( isdefined( entity.margwawait ) )
    {
        entity thread [[ entity.margwawait ]]();
        return;
    }
    
    entity thread margwaserverutils::margwawait();
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x1dd691be, Offset: 0x2c50
// Size: 0x12c
function private margwapainstart( entity )
{
    entity notify( #"stop_head_update" );
    
    if ( entity margwaserverutils::shouldupdatejaw() )
    {
        head = blackboard::getblackboardattribute( self, "_margwa_head" );
        
        switch ( head )
        {
            case "left":
                entity clientfield::set( "margwa_jaw", 3 );
                break;
            case "middle":
                entity clientfield::set( "margwa_jaw", 4 );
                break;
            default:
                entity clientfield::set( "margwa_jaw", 5 );
                break;
        }
    }
    
    entity.headdestroyed = undefined;
    entity.canstun = 0;
    entity.candamage = 0;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x13fc1942, Offset: 0x2d88
// Size: 0xa0
function private margwapainterminate( entity )
{
    entity.headdestroyed = undefined;
    entity.canstun = 1;
    entity.candamage = 1;
    entity margwaserverutils::margwacloseallheads( 5000 );
    entity clearpath();
    
    if ( isdefined( entity.margwapainterminatecb ) )
    {
        entity [[ entity.margwapainterminatecb ]]();
    }
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0xe29ed658, Offset: 0x2e30
// Size: 0x64
function private margwareactstunstart( entity )
{
    entity.reactstun = undefined;
    entity.canstun = 0;
    
    if ( entity margwaserverutils::shouldupdatejaw() )
    {
        entity clientfield::set( "margwa_jaw", 6 );
    }
}

// Namespace margwabehavior
// Params 1
// Checksum 0x567ed9e2, Offset: 0x2ea0
// Size: 0x20
function margwareactstunterminate( entity )
{
    entity.canstun = 1;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x6ea2d157, Offset: 0x2ec8
// Size: 0x13c
function private margwareactidgunstart( entity )
{
    entity.reactidgun = undefined;
    entity.canstun = 0;
    ispacked = 0;
    
    if ( blackboard::getblackboardattribute( entity, "_zombie_damageweapon_type" ) == "regular" )
    {
        if ( entity margwaserverutils::shouldupdatejaw() )
        {
            entity clientfield::set( "margwa_jaw", 8 );
        }
        
        entity margwaserverutils::margwacloseallheads( 5000 );
    }
    else
    {
        if ( entity margwaserverutils::shouldupdatejaw() )
        {
            entity clientfield::set( "margwa_jaw", 9 );
        }
        
        entity margwaserverutils::margwacloseallheads( 10000 );
        ispacked = 1;
    }
    
    if ( isdefined( entity.idgun_damage ) )
    {
        entity [[ entity.idgun_damage ]]( ispacked );
    }
}

// Namespace margwabehavior
// Params 1
// Checksum 0x417f8cef, Offset: 0x3010
// Size: 0x44
function margwareactidgunterminate( entity )
{
    entity.canstun = 1;
    blackboard::setblackboardattribute( entity, "_zombie_damageweapon_type", "regular" );
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0xb22073ae, Offset: 0x3060
// Size: 0x58
function private margwareactswordstart( entity )
{
    entity.reactsword = undefined;
    entity.canstun = 0;
    
    if ( isdefined( entity.head_chopper ) )
    {
        entity.head_chopper notify( #"react_sword" );
    }
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0xff73c378, Offset: 0x30c0
// Size: 0x20
function private margwareactswordterminate( entity )
{
    entity.canstun = 1;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0x38ad1a57, Offset: 0x30e8
// Size: 0x1c
function private margwaspawnstart( entity )
{
    entity.needspawn = 0;
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0xf8f02af9, Offset: 0x3110
// Size: 0x5c
function private margwasmashattackstart( entity )
{
    entity margwaserverutils::margwaheadsmash();
    
    if ( entity margwaserverutils::shouldupdatejaw() )
    {
        entity clientfield::set( "margwa_jaw", 14 );
    }
}

// Namespace margwabehavior
// Params 1
// Checksum 0xd562ea55, Offset: 0x3178
// Size: 0x24
function margwasmashattackterminate( entity )
{
    entity margwaserverutils::margwacloseallheads();
}

// Namespace margwabehavior
// Params 1
// Checksum 0x37de952b, Offset: 0x31a8
// Size: 0x44
function margwaswipeattackstart( entity )
{
    if ( entity margwaserverutils::shouldupdatejaw() )
    {
        entity clientfield::set( "margwa_jaw", 16 );
    }
}

// Namespace margwabehavior
// Params 1, eflags: 0x4
// Checksum 0xfa0a0930, Offset: 0x31f8
// Size: 0x24
function private margwaswipeattackterminate( entity )
{
    entity margwaserverutils::margwacloseallheads();
}

// Namespace margwabehavior
// Params 5, eflags: 0x4
// Checksum 0x1c7a55f3, Offset: 0x3228
// Size: 0x144
function private mocompmargwateleporttraversalinit( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    entity orientmode( "face angle", entity.angles[ 1 ] );
    entity animmode( "normal" );
    
    if ( isdefined( entity.traverseendnode ) )
    {
        entity.teleportstart = entity.origin;
        entity.teleportpos = entity.traverseendnode.origin;
        self clientfield::increment( "margwa_fx_out", 1 );
        
        if ( isdefined( entity.traversestartnode ) )
        {
            if ( isdefined( entity.traversestartnode.speed ) )
            {
                self.margwa_teleport_speed = entity.traversestartnode.speed;
            }
        }
    }
}

// Namespace margwabehavior
// Params 5, eflags: 0x4
// Checksum 0x44041490, Offset: 0x3378
// Size: 0x2c
function private mocompmargwateleporttraversalupdate( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    
}

// Namespace margwabehavior
// Params 5, eflags: 0x4
// Checksum 0x897d052c, Offset: 0x33b0
// Size: 0x44
function private mocompmargwateleporttraversalterminate( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    margwateleportoutterminate( entity );
}

#namespace margwaserverutils;

// Namespace margwaserverutils
// Params 0, eflags: 0x4
// Checksum 0x99d9deb3, Offset: 0x3400
// Size: 0x224
function private margwaspawnsetup()
{
    self disableaimassist();
    self.disableammodrop = 1;
    self.no_gib = 1;
    self.ignore_nuke = 1;
    self.ignore_enemy_count = 1;
    self.ignore_round_robbin_death = 1;
    self.zombie_move_speed = "walk";
    self.overrideactordamage = &margwadamage;
    self.candamage = 1;
    self.headattached = 3;
    self.headopen = 0;
    self margwainithead( "c_zom_margwa_chunks_le", "j_chunk_head_bone_le" );
    self margwainithead( "c_zom_margwa_chunks_mid", "j_chunk_head_bone" );
    self margwainithead( "c_zom_margwa_chunks_ri", "j_chunk_head_bone_ri" );
    self.headhealthmax = 600;
    self margwadisablestun();
    self.traveler = spawn( "script_model", self.origin );
    self.traveler setmodel( "tag_origin" );
    self.traveler notsolid();
    self.travelertell = spawn( "script_model", self.origin );
    self.travelertell setmodel( "tag_origin" );
    self.travelertell notsolid();
    self thread margwadeath();
    self.updatesight = 0;
    self.ignorerunandgundist = 1;
}

// Namespace margwaserverutils
// Params 0, eflags: 0x4
// Checksum 0x10d7870e, Offset: 0x3630
// Size: 0x7c
function private margwadeath()
{
    self waittill( #"death" );
    
    if ( isdefined( self.e_head_attacker ) )
    {
        self.e_head_attacker notify( #"margwa_kill" );
    }
    
    if ( isdefined( self.traveler ) )
    {
        self.traveler delete();
    }
    
    if ( isdefined( self.travelertell ) )
    {
        self.travelertell delete();
    }
}

// Namespace margwaserverutils
// Params 0
// Checksum 0x7bfcd1cf, Offset: 0x36b8
// Size: 0x10
function margwaenablestun()
{
    self.canstun = 1;
}

// Namespace margwaserverutils
// Params 0, eflags: 0x4
// Checksum 0xe1852a59, Offset: 0x36d0
// Size: 0x10
function private margwadisablestun()
{
    self.canstun = 0;
}

// Namespace margwaserverutils
// Params 2, eflags: 0x4
// Checksum 0x4f6311e4, Offset: 0x36e8
// Size: 0x454
function private margwainithead( headmodel, headtag )
{
    model = headmodel;
    model_gore = undefined;
    
    switch ( headmodel )
    {
        case "c_zom_margwa_chunks_le":
            if ( isdefined( level.margwa_head_left_model_override ) )
            {
                model = level.margwa_head_left_model_override;
                model_gore = level.margwa_gore_left_model_override;
            }
            
            break;
        case "c_zom_margwa_chunks_mid":
            if ( isdefined( level.margwa_head_mid_model_override ) )
            {
                model = level.margwa_head_mid_model_override;
                model_gore = level.margwa_gore_mid_model_override;
            }
            
            break;
        default:
            if ( isdefined( level.margwa_head_right_model_override ) )
            {
                model = level.margwa_head_right_model_override;
                model_gore = level.margwa_gore_right_model_override;
            }
            
            break;
    }
    
    self attach( model );
    
    if ( !isdefined( self.head ) )
    {
        self.head = [];
    }
    
    self.head[ model ] = spawnstruct();
    self.head[ model ].model = model;
    self.head[ model ].tag = headtag;
    self.head[ model ].health = 600;
    self.head[ model ].candamage = 0;
    self.head[ model ].open = 1;
    self.head[ model ].closed = 2;
    self.head[ model ].smash = 3;
    
    switch ( headmodel )
    {
        case "c_zom_margwa_chunks_le":
            self.head[ model ].cf = "margwa_head_left";
            self.head[ model ].impactcf = "margwa_head_left_hit";
            self.head[ model ].gore = "c_zom_margwa_gore_le";
            
            if ( isdefined( model_gore ) )
            {
                self.head[ model ].gore = model_gore;
            }
            
            self.head[ model ].killindex = 1;
            self.head_left_model = model;
            break;
        case "c_zom_margwa_chunks_mid":
            self.head[ model ].cf = "margwa_head_mid";
            self.head[ model ].impactcf = "margwa_head_mid_hit";
            self.head[ model ].gore = "c_zom_margwa_gore_mid";
            
            if ( isdefined( model_gore ) )
            {
                self.head[ model ].gore = model_gore;
            }
            
            self.head[ model ].killindex = 2;
            self.head_mid_model = model;
            break;
        default:
            self.head[ model ].cf = "margwa_head_right";
            self.head[ model ].impactcf = "margwa_head_right_hit";
            self.head[ model ].gore = "c_zom_margwa_gore_ri";
            
            if ( isdefined( model_gore ) )
            {
                self.head[ model ].gore = model_gore;
            }
            
            self.head[ model ].killindex = 3;
            self.head_right_model = model;
            break;
    }
    
    self thread margwaheadupdate( self.head[ model ] );
}

// Namespace margwaserverutils
// Params 1
// Checksum 0x91582e3a, Offset: 0x3b48
// Size: 0x9a
function margwasetheadhealth( health )
{
    self.headhealthmax = health;
    
    foreach ( head in self.head )
    {
        head.health = health;
    }
}

// Namespace margwaserverutils
// Params 2, eflags: 0x4
// Checksum 0xee2c76d4, Offset: 0x3bf0
// Size: 0x46
function private margwaresetheadtime( min, max )
{
    time = gettime() + randomintrange( min, max );
    return time;
}

// Namespace margwaserverutils
// Params 0, eflags: 0x4
// Checksum 0xa2c54f6b, Offset: 0x3c40
// Size: 0x40, Type: bool
function private margwaheadcanopen()
{
    if ( self.headattached > 1 )
    {
        if ( self.headopen < self.headattached - 1 )
        {
            return true;
        }
    }
    else
    {
        return true;
    }
    
    return false;
}

// Namespace margwaserverutils
// Params 1, eflags: 0x4
// Checksum 0x81d78407, Offset: 0x3c88
// Size: 0x298
function private margwaheadupdate( headinfo )
{
    self endon( #"death" );
    self endon( #"stop_head_update" );
    headinfo notify( #"stop_head_update" );
    headinfo endon( #"stop_head_update" );
    
    while ( true )
    {
        if ( self ispaused() )
        {
            util::wait_network_frame();
            continue;
        }
        
        if ( !isdefined( headinfo.closetime ) )
        {
            if ( self.headattached == 1 )
            {
                headinfo.closetime = margwaresetheadtime( 500, 1000 );
            }
            else
            {
                headinfo.closetime = margwaresetheadtime( 1500, 3500 );
            }
        }
        
        if ( gettime() > headinfo.closetime && self margwaheadcanopen() )
        {
            self.headopen++;
            headinfo.closetime = undefined;
        }
        else
        {
            util::wait_network_frame();
            continue;
        }
        
        self margwaheaddamagedelay( headinfo, 1 );
        self clientfield::set( headinfo.cf, headinfo.open );
        self playsoundontag( "zmb_vocals_margwa_ambient", headinfo.tag );
        
        while ( true )
        {
            if ( !isdefined( headinfo.opentime ) )
            {
                headinfo.opentime = margwaresetheadtime( 3000, 5000 );
            }
            
            if ( gettime() > headinfo.opentime )
            {
                self.headopen--;
                headinfo.opentime = undefined;
                break;
            }
            
            util::wait_network_frame();
            continue;
        }
        
        self margwaheaddamagedelay( headinfo, 0 );
        self clientfield::set( headinfo.cf, headinfo.closed );
    }
}

// Namespace margwaserverutils
// Params 2, eflags: 0x4
// Checksum 0xcb063ec9, Offset: 0x3f28
// Size: 0x3c
function private margwaheaddamagedelay( headinfo, candamage )
{
    self endon( #"death" );
    wait 0.1;
    headinfo.candamage = candamage;
}

// Namespace margwaserverutils
// Params 0, eflags: 0x4
// Checksum 0x94918c5c, Offset: 0x3f70
// Size: 0x1c2
function private margwaheadsmash()
{
    self notify( #"stop_head_update" );
    headalive = [];
    
    foreach ( head in self.head )
    {
        if ( head.health > 0 )
        {
            headalive[ headalive.size ] = head;
        }
    }
    
    headalive = array::randomize( headalive );
    open = 0;
    
    foreach ( head in headalive )
    {
        if ( !open )
        {
            head.candamage = 1;
            self clientfield::set( head.cf, head.smash );
            open = 1;
            continue;
        }
        
        self margwaclosehead( head );
    }
}

// Namespace margwaserverutils
// Params 1, eflags: 0x4
// Checksum 0xeba348fd, Offset: 0x4140
// Size: 0x4c
function private margwaclosehead( headinfo )
{
    headinfo.candamage = 0;
    self clientfield::set( headinfo.cf, headinfo.closed );
}

// Namespace margwaserverutils
// Params 1, eflags: 0x4
// Checksum 0x51f32313, Offset: 0x4198
// Size: 0x122
function private margwacloseallheads( closetime )
{
    if ( self ispaused() )
    {
        return;
    }
    
    foreach ( head in self.head )
    {
        if ( head.health > 0 )
        {
            head.closetime = undefined;
            head.opentime = undefined;
            
            if ( isdefined( closetime ) )
            {
                head.closetime = gettime() + closetime;
            }
            
            self.headopen = 0;
            self margwaclosehead( head );
            self thread margwaheadupdate( head );
        }
    }
}

// Namespace margwaserverutils
// Params 2
// Checksum 0xb02e33be, Offset: 0x42c8
// Size: 0x17a, Type: bool
function margwakillhead( modelhit, attacker )
{
    headinfo = self.head[ modelhit ];
    headinfo.health = 0;
    headinfo notify( #"stop_head_update" );
    
    if ( isdefined( headinfo.candamage ) && headinfo.candamage )
    {
        self margwaclosehead( headinfo );
        self.headopen--;
    }
    
    self margwaupdatemovespeed();
    
    if ( isdefined( self.destroyheadcb ) )
    {
        self thread [[ self.destroyheadcb ]]( modelhit, attacker );
    }
    
    self clientfield::set( "margwa_head_killed", headinfo.killindex );
    self detach( headinfo.model );
    self attach( headinfo.gore );
    self.headattached--;
    
    if ( self.headattached <= 0 )
    {
        self.e_head_attacker = attacker;
        return true;
    }
    else
    {
        self.headdestroyed = modelhit;
    }
    
    return false;
}

// Namespace margwaserverutils
// Params 0
// Checksum 0x43563241, Offset: 0x4450
// Size: 0xc0, Type: bool
function margwacandamageanyhead()
{
    foreach ( head in self.head )
    {
        if ( isdefined( head.candamage ) && isdefined( head ) && head.health > 0 && head.candamage )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace margwaserverutils
// Params 0
// Checksum 0x2167a7ed, Offset: 0x4518
// Size: 0x3a, Type: bool
function margwacandamagehead()
{
    if ( isdefined( self.candamage ) && isdefined( self ) && self.health > 0 && self.candamage )
    {
        return true;
    }
    
    return false;
}

// Namespace margwaserverutils
// Params 0
// Checksum 0x7d7d2633, Offset: 0x4560
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

// Namespace margwaserverutils
// Params 1, eflags: 0x4
// Checksum 0x9e36f596, Offset: 0x45f0
// Size: 0xee, Type: bool
function private isdirecthitweapon( weapon )
{
    foreach ( dhweapon in level.dhweapons )
    {
        if ( weapon.name == dhweapon )
        {
            return true;
        }
        
        if ( isdefined( weapon.rootweapon ) && isdefined( weapon.rootweapon.name ) && weapon.rootweapon.name == dhweapon )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace margwaserverutils
// Params 12
// Checksum 0xd0e1889d, Offset: 0x46e8
// Size: 0x67c
function margwadamage( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex )
{
    if ( isdefined( self.is_kill ) && self.is_kill )
    {
        return damage;
    }
    
    if ( isdefined( attacker ) && isdefined( attacker.n_margwa_head_damage_scale ) )
    {
        damage *= attacker.n_margwa_head_damage_scale;
    }
    
    if ( isdefined( level._margwa_damage_cb ) )
    {
        n_result = [[ level._margwa_damage_cb ]]( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex );
        
        if ( isdefined( n_result ) )
        {
            return n_result;
        }
    }
    
    damageopen = 0;
    
    if ( !( isdefined( self.candamage ) && self.candamage ) )
    {
        self.health += 1;
        return 1;
    }
    
    if ( isdirecthitweapon( weapon ) )
    {
        headalive = [];
        
        foreach ( head in self.head )
        {
            if ( head margwacandamagehead() )
            {
                headalive[ headalive.size ] = head;
            }
        }
        
        if ( headalive.size > 0 )
        {
            max = 100000;
            headclosest = undefined;
            
            foreach ( head in headalive )
            {
                distsq = distancesquared( point, self gettagorigin( head.tag ) );
                
                if ( distsq < max )
                {
                    max = distsq;
                    headclosest = head;
                }
            }
            
            if ( isdefined( headclosest ) )
            {
                if ( max < 576 )
                {
                    if ( isdefined( level.margwa_damage_override_callback ) && isfunctionptr( level.margwa_damage_override_callback ) )
                    {
                        damage = attacker [[ level.margwa_damage_override_callback ]]( damage );
                    }
                    
                    headclosest.health -= damage;
                    damageopen = 1;
                    self clientfield::increment( headclosest.impactcf );
                    attacker show_hit_marker();
                    
                    if ( headclosest.health <= 0 )
                    {
                        if ( isdefined( level.margwa_head_kill_weapon_check ) )
                        {
                            [[ level.margwa_head_kill_weapon_check ]]( self, weapon );
                        }
                        
                        if ( self margwakillhead( headclosest.model, attacker ) )
                        {
                            return self.health;
                        }
                    }
                }
            }
        }
    }
    
    partname = getpartname( self.model, boneindex );
    
    if ( isdefined( partname ) )
    {
        /#
            if ( isdefined( self.debughitloc ) && self.debughitloc )
            {
                printtoprightln( partname + "<dev string:x7f>" + damage );
            }
        #/
        
        modelhit = self margwaheadhit( self, partname );
        
        if ( isdefined( modelhit ) )
        {
            headinfo = self.head[ modelhit ];
            
            if ( headinfo margwacandamagehead() )
            {
                if ( isdefined( level.margwa_damage_override_callback ) && isfunctionptr( level.margwa_damage_override_callback ) )
                {
                    damage = attacker [[ level.margwa_damage_override_callback ]]( damage );
                }
                
                if ( isdefined( attacker ) )
                {
                    attacker notify( #"margwa_headshot", self );
                }
                
                headinfo.health -= damage;
                damageopen = 1;
                self clientfield::increment( headinfo.impactcf );
                attacker show_hit_marker();
                
                if ( headinfo.health <= 0 )
                {
                    if ( isdefined( level.margwa_head_kill_weapon_check ) )
                    {
                        [[ level.margwa_head_kill_weapon_check ]]( self, weapon );
                    }
                    
                    if ( self margwakillhead( modelhit, attacker ) )
                    {
                        return self.health;
                    }
                }
            }
        }
    }
    
    if ( damageopen )
    {
        return 0;
    }
    
    self.health += 1;
    return 1;
}

// Namespace margwaserverutils
// Params 2, eflags: 0x4
// Checksum 0x5a7e92a6, Offset: 0x4d70
// Size: 0x36
function private margwaheadhit( entity, partname )
{
    switch ( partname )
    {
        case "j_chunk_head_bone_le":
        case "j_jaw_lower_1_le":
            return self.head_left_model;
        case "j_chunk_head_bone":
        case "j_jaw_lower_1":
            return self.head_mid_model;
        case "j_chunk_head_bone_ri":
        default:
            return self.head_right_model;
    }
}

// Namespace margwaserverutils
// Params 0, eflags: 0x4
// Checksum 0x5c02a521, Offset: 0x4de8
// Size: 0x9c
function private margwaupdatemovespeed()
{
    if ( self.zombie_move_speed == "walk" )
    {
        self.zombie_move_speed = "run";
        blackboard::setblackboardattribute( self, "_locomotion_speed", "locomotion_speed_run" );
        return;
    }
    
    if ( self.zombie_move_speed == "run" )
    {
        self.zombie_move_speed = "sprint";
        blackboard::setblackboardattribute( self, "_locomotion_speed", "locomotion_speed_sprint" );
    }
}

// Namespace margwaserverutils
// Params 0
// Checksum 0x98cbb6ab, Offset: 0x4e90
// Size: 0x3c
function margwaforcesprint()
{
    self.zombie_move_speed = "sprint";
    blackboard::setblackboardattribute( self, "_locomotion_speed", "locomotion_speed_sprint" );
}

// Namespace margwaserverutils
// Params 1, eflags: 0x4
// Checksum 0xa69a2999, Offset: 0x4ed8
// Size: 0xc
function private margwadestroyhead( modelhit )
{
    
}

// Namespace margwaserverutils
// Params 0
// Checksum 0x2eac2fc5, Offset: 0x4ef0
// Size: 0x38, Type: bool
function shouldupdatejaw()
{
    if ( !( isdefined( self.jawanimenabled ) && self.jawanimenabled ) )
    {
        return false;
    }
    
    if ( self.headattached < 3 )
    {
        return true;
    }
    
    return false;
}

// Namespace margwaserverutils
// Params 3
// Checksum 0x47b9066c, Offset: 0x4f30
// Size: 0x8e, Type: bool
function margwasetgoal( origin, radius, boundarydist )
{
    pos = getclosestpointonnavmesh( origin, 64, 30 );
    
    if ( isdefined( pos ) )
    {
        self setgoal( pos );
        return true;
    }
    
    self setgoal( self.origin );
    return false;
}

// Namespace margwaserverutils
// Params 0, eflags: 0x4
// Checksum 0x35d62b4d, Offset: 0x4fc8
// Size: 0x18a
function private margwawait()
{
    self endon( #"death" );
    self.waiting = 1;
    self.needteleportin = 1;
    destpos = self.teleportpos + ( 0, 0, 60 );
    dist = distance( self.teleportstart, destpos );
    time = dist / 600;
    
    if ( isdefined( self.margwa_teleport_speed ) )
    {
        if ( self.margwa_teleport_speed > 0 )
        {
            time = dist / self.margwa_teleport_speed;
        }
    }
    
    if ( isdefined( self.traveler ) )
    {
        self thread margwatell();
        self.traveler moveto( destpos, time );
        self.traveler util::waittill_any_ex( time + 0.1, "movedone", self, "death" );
        self.travelertell clientfield::set( "margwa_fx_travel_tell", 0 );
    }
    
    self.waiting = 0;
    self.needteleportout = 0;
    
    if ( isdefined( self.margwa_teleport_speed ) )
    {
        self.margwa_teleport_speed = undefined;
    }
}

// Namespace margwaserverutils
// Params 0
// Checksum 0x7feb04f2, Offset: 0x5160
// Size: 0x64
function margwatell()
{
    self endon( #"death" );
    self.travelertell.origin = self.teleportpos;
    util::wait_network_frame();
    self.travelertell clientfield::set( "margwa_fx_travel_tell", 1 );
}

// Namespace margwaserverutils
// Params 3, eflags: 0x4
// Checksum 0x241b8c09, Offset: 0x51d0
// Size: 0x162, Type: bool
function private shieldfacing( vdir, limit, front )
{
    if ( !isdefined( front ) )
    {
        front = 1;
    }
    
    orientation = self getplayerangles();
    forwardvec = anglestoforward( orientation );
    
    if ( !front )
    {
        forwardvec *= -1;
    }
    
    forwardvec2d = ( forwardvec[ 0 ], forwardvec[ 1 ], 0 );
    unitforwardvec2d = vectornormalize( forwardvec2d );
    tofaceevec = vdir * -1;
    tofaceevec2d = ( tofaceevec[ 0 ], tofaceevec[ 1 ], 0 );
    unittofaceevec2d = vectornormalize( tofaceevec2d );
    dotproduct = vectordot( unitforwardvec2d, unittofaceevec2d );
    return dotproduct > limit;
}

// Namespace margwaserverutils
// Params 1, eflags: 0x4
// Checksum 0x63151c0a, Offset: 0x5340
// Size: 0xc8, Type: bool
function private insmashattackrange( enemy )
{
    smashpos = self.origin;
    heightoffset = abs( self.origin[ 2 ] - enemy.origin[ 2 ] );
    
    if ( heightoffset > 48 )
    {
        return false;
    }
    
    distsq = distancesquared( smashpos, enemy.origin );
    range = 25600;
    
    if ( distsq < range )
    {
        return true;
    }
    
    return false;
}

