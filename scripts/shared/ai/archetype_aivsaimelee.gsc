#using scripts/codescripts/struct;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_shared;

#namespace archetype_aivsaimelee;

// Namespace archetype_aivsaimelee
// Params 0, eflags: 0x2
// Checksum 0xc7f9612d, Offset: 0x3a0
// Size: 0x222
function autoexec main()
{
    meleebundles = struct::get_script_bundles( "aiassassination" );
    level._aivsai_meleebundles = [];
    
    foreach ( meleebundle in meleebundles )
    {
        attacker_archetype = meleebundle.attackerarchetype;
        defender_archetype = meleebundle.defenderarchetype;
        attacker_variant = meleebundle.attackervariant;
        defender_variant = meleebundle.defendervariant;
        
        if ( !isdefined( level._aivsai_meleebundles[ attacker_archetype ] ) )
        {
            level._aivsai_meleebundles[ attacker_archetype ] = [];
            level._aivsai_meleebundles[ attacker_archetype ][ defender_archetype ] = [];
            level._aivsai_meleebundles[ attacker_archetype ][ defender_archetype ][ attacker_variant ] = [];
        }
        else if ( !isdefined( level._aivsai_meleebundles[ attacker_archetype ][ defender_archetype ] ) )
        {
            level._aivsai_meleebundles[ attacker_archetype ][ defender_archetype ] = [];
            level._aivsai_meleebundles[ attacker_archetype ][ defender_archetype ][ attacker_variant ] = [];
        }
        else if ( !isdefined( level._aivsai_meleebundles[ attacker_archetype ][ defender_archetype ][ attacker_variant ] ) )
        {
            level._aivsai_meleebundles[ attacker_archetype ][ defender_archetype ][ attacker_variant ] = [];
        }
        
        level._aivsai_meleebundles[ attacker_archetype ][ defender_archetype ][ attacker_variant ][ defender_variant ] = meleebundle;
    }
}

// Namespace archetype_aivsaimelee
// Params 0
// Checksum 0x99c3745, Offset: 0x5d0
// Size: 0x14c
function registeraivsaimeleebehaviorfunctions()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "hasAIvsAIEnemy", &hasaivsaienemy );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "decideInitiator", &decideinitiator );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "isInitiator", &isinitiator );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "hasCloseAIvsAIEnemy", &hascloseaivsaienemy );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "chooseAIvsAIMeleeAnimations", &chooseaivsaimeleeanimations );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "isCloseEnoughForAIvsAIMelee", &iscloseenoughforaivsaimelee );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "hasPotentalAIvsAIMeleeEnemy", &haspotentalaivsaimeleeenemy );
    behaviortreenetworkutility::registerbehaviortreeaction( "AIvsAIMeleeAction", &aivsaimeleeinitialize, undefined, undefined );
}

// Namespace archetype_aivsaimelee
// Params 1
// Checksum 0x32248689, Offset: 0x728
// Size: 0x6e, Type: bool
function haspotentalaivsaimeleeenemy( behaviortreeentity )
{
    if ( !hasaivsaienemy( behaviortreeentity ) )
    {
        return false;
    }
    
    if ( !chooseaivsaimeleeanimations( behaviortreeentity ) )
    {
        return false;
    }
    
    if ( !hascloseaivsaienemy( behaviortreeentity ) )
    {
        return true;
    }
    
    return false;
}

// Namespace archetype_aivsaimelee
// Params 1
// Checksum 0x716572b, Offset: 0x7a0
// Size: 0x6e, Type: bool
function iscloseenoughforaivsaimelee( behaviortreeentity )
{
    if ( !hasaivsaienemy( behaviortreeentity ) )
    {
        return false;
    }
    
    if ( !chooseaivsaimeleeanimations( behaviortreeentity ) )
    {
        return false;
    }
    
    if ( !hascloseaivsaienemy( behaviortreeentity ) )
    {
        return false;
    }
    
    return true;
}

// Namespace archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0x74863fed, Offset: 0x818
// Size: 0x114, Type: bool
function private shouldaquiremutexonenemyforaivsaimelee( behaviortreeentity )
{
    if ( isplayer( behaviortreeentity.enemy ) )
    {
        return false;
    }
    
    if ( !isdefined( behaviortreeentity.enemy ) )
    {
        return false;
    }
    
    if ( isdefined( behaviortreeentity.melee ) )
    {
        if ( isdefined( behaviortreeentity.melee.enemy ) && behaviortreeentity.melee.enemy == behaviortreeentity.enemy )
        {
            return true;
        }
    }
    
    if ( isdefined( behaviortreeentity.enemy.melee ) )
    {
        if ( isdefined( behaviortreeentity.enemy.melee.enemy ) && behaviortreeentity.enemy.melee.enemy != behaviortreeentity )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0xd30d861c, Offset: 0x938
// Size: 0xcae, Type: bool
function private hasaivsaienemy( behaviortreeentity )
{
    enemy = behaviortreeentity.enemy;
    
    if ( getdvarint( "disable_aivsai_melee", 0 ) )
    {
        /#
            record3dtext( "<dev string:x28>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( !isdefined( enemy ) )
    {
        /#
            record3dtext( "<dev string:x5c>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( !( isalive( behaviortreeentity ) && isalive( enemy ) ) )
    {
        /#
            record3dtext( "<dev string:x7d>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( !isai( enemy ) || !isactor( enemy ) )
    {
        /#
            record3dtext( "<dev string:xb4>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( isdefined( enemy.archetype ) )
    {
        if ( sessionmodeiscampaignzombiesgame() )
        {
            if ( enemy.archetype != "human" && enemy.archetype != "human_riotshield" && enemy.archetype != "robot" && enemy.archetype != "zombie" )
            {
                /#
                    record3dtext( "<dev string:xe0>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
                #/
                
                return false;
            }
        }
        else if ( enemy.archetype != "human" && enemy.archetype != "human_riotshield" && enemy.archetype != "robot" )
        {
            /#
                record3dtext( "<dev string:x120>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
            #/
            
            return false;
        }
    }
    
    if ( enemy.team == behaviortreeentity.team )
    {
        /#
            record3dtext( "<dev string:x159>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( enemy isragdoll() )
    {
        /#
            record3dtext( "<dev string:x187>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( isdefined( enemy.ignoreme ) && enemy.ignoreme )
    {
        /#
            record3dtext( "<dev string:x1b3>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( isdefined( enemy._ai_melee_markeddead ) && enemy._ai_melee_markeddead )
    {
        /#
            record3dtext( "<dev string:x1e3>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( behaviortreeentity ai::has_behavior_attribute( "can_initiateaivsaimelee" ) && !behaviortreeentity ai::get_behavior_attribute( "can_initiateaivsaimelee" ) )
    {
        /#
            record3dtext( "<dev string:x223>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( behaviortreeentity ai::has_behavior_attribute( "can_melee" ) && !behaviortreeentity ai::get_behavior_attribute( "can_melee" ) )
    {
        /#
            record3dtext( "<dev string:x269>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( enemy ai::has_behavior_attribute( "can_be_meleed" ) && !enemy ai::get_behavior_attribute( "can_be_meleed" ) )
    {
        /#
            record3dtext( "<dev string:x2a1>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( distance2dsquared( behaviortreeentity.origin, enemy.origin ) > 22500 )
    {
        /#
            record3dtext( "<dev string:x2d6>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        behaviortreeentity._ai_melee_initiator = undefined;
        return false;
    }
    
    forwardvec = vectornormalize( anglestoforward( behaviortreeentity.angles ) );
    rightvec = vectornormalize( anglestoright( behaviortreeentity.angles ) );
    toenemyvec = vectornormalize( enemy.origin - behaviortreeentity.origin );
    fdot = vectordot( toenemyvec, forwardvec );
    
    if ( fdot < 0 )
    {
        /#
            record3dtext( "<dev string:x2fc>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( enemy isinscriptedstate() )
    {
        /#
            record3dtext( "<dev string:x324>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    currentstance = blackboard::getblackboardattribute( behaviortreeentity, "_stance" );
    enemystance = blackboard::getblackboardattribute( enemy, "_stance" );
    
    if ( currentstance != "stand" || enemystance != "stand" )
    {
        /#
            record3dtext( "<dev string:x354>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( !shouldaquiremutexonenemyforaivsaimelee( behaviortreeentity ) )
    {
        /#
            record3dtext( "<dev string:x38b>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( abs( behaviortreeentity.origin[ 2 ] - behaviortreeentity.enemy.origin[ 2 ] ) > 16 )
    {
        /#
            record3dtext( "<dev string:x3c2>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    raisedenemyentorigin = ( behaviortreeentity.enemy.origin[ 0 ], behaviortreeentity.enemy.origin[ 1 ], behaviortreeentity.enemy.origin[ 2 ] + 8 );
    
    if ( !behaviortreeentity maymovetopoint( raisedenemyentorigin, 0, 1, behaviortreeentity.enemy ) )
    {
        /#
            record3dtext( "<dev string:x3ec>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    if ( isdefined( enemy.allowdeath ) && !enemy.allowdeath )
    {
        if ( isdefined( behaviortreeentity.allowdeath ) && !behaviortreeentity.allowdeath )
        {
            /#
                record3dtext( "<dev string:x411>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
            #/
            
            self notify( #"failed_melee_mbs", enemy );
            return false;
        }
        
        behaviortreeentity._ai_melee_attacker_loser = 1;
        return true;
    }
    
    return true;
}

// Namespace archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0x6e2b8799, Offset: 0x15f0
// Size: 0x58, Type: bool
function private decideinitiator( behaviortreeentity )
{
    if ( !isdefined( behaviortreeentity._ai_melee_initiator ) )
    {
        if ( !isdefined( behaviortreeentity.enemy._ai_melee_initiator ) )
        {
            behaviortreeentity._ai_melee_initiator = 1;
            return true;
        }
    }
    
    return false;
}

// Namespace archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0x5db14e7, Offset: 0x1650
// Size: 0x3a, Type: bool
function private isinitiator( behaviortreeentity )
{
    if ( !( isdefined( behaviortreeentity._ai_melee_initiator ) && behaviortreeentity._ai_melee_initiator ) )
    {
        return false;
    }
    
    return true;
}

// Namespace archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0xb0798a2e, Offset: 0x1698
// Size: 0x40c, Type: bool
function private hascloseaivsaienemy( behaviortreeentity )
{
    if ( !( isdefined( behaviortreeentity._ai_melee_animname ) && isdefined( behaviortreeentity.enemy._ai_melee_animname ) ) )
    {
        /#
            record3dtext( "<dev string:x447>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    animationstartorigin = getstartorigin( behaviortreeentity.enemy gettagorigin( "tag_sync" ), behaviortreeentity.enemy gettagangles( "tag_sync" ), behaviortreeentity._ai_melee_animname );
    
    /#
        record3dtext( "<dev string:x473>" + sqrt( 900 ), behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        record3dtext( "<dev string:x4a2>" + distance( animationstartorigin, behaviortreeentity.origin ), behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        recordcircle( behaviortreeentity.enemy gettagorigin( "<dev string:x4c8>" ), 8, ( 1, 0, 0 ), "<dev string:x51>", behaviortreeentity );
        recordcircle( animationstartorigin, 8, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity );
        recordline( animationstartorigin, behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity );
    #/
    
    if ( distance2dsquared( behaviortreeentity.origin, animationstartorigin ) <= 900 )
    {
        return true;
    }
    
    if ( behaviortreeentity haspath() )
    {
        selfpredictedpos = behaviortreeentity.origin;
        moveangle = behaviortreeentity.angles[ 1 ] + behaviortreeentity getmotionangle();
        selfpredictedpos += ( cos( moveangle ), sin( moveangle ), 0 ) * 200 * 0.2;
        
        /#
            record3dtext( "<dev string:x4d1>" + distance( selfpredictedpos, animationstartorigin ), behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        if ( distance2dsquared( selfpredictedpos, animationstartorigin ) <= 900 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0x35d2fe1, Offset: 0x1ab0
// Size: 0x584, Type: bool
function private chooseaivsaimeleeanimations( behaviortreeentity )
{
    anglestoenemy = vectortoangles( behaviortreeentity.enemy.origin - behaviortreeentity.origin );
    yawtoenemy = angleclamp180( behaviortreeentity.enemy.angles[ 1 ] - anglestoenemy[ 1 ] );
    
    /#
        record3dtext( "<dev string:x4ff>" + abs( yawtoenemy ), behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
    #/
    
    behaviortreeentity._ai_melee_animname = undefined;
    behaviortreeentity.enemy._ai_melee_animname = undefined;
    attacker_variant = choosearchetypevariant( behaviortreeentity );
    defender_variant = choosearchetypevariant( behaviortreeentity.enemy );
    
    if ( !aivsaimeleebundleexists( behaviortreeentity, attacker_variant, defender_variant ) )
    {
        /#
            record3dtext( "<dev string:x50f>" + behaviortreeentity.archetype + "<dev string:x542>" + behaviortreeentity.enemy.archetype + "<dev string:x542>" + attacker_variant + "<dev string:x542>" + defender_variant, behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        #/
        
        return false;
    }
    
    animbundle = level._aivsai_meleebundles[ behaviortreeentity.archetype ][ behaviortreeentity.enemy.archetype ][ attacker_variant ][ defender_variant ];
    
    /#
        if ( isdefined( behaviortreeentity._ai_melee_attacker_loser ) && behaviortreeentity._ai_melee_attacker_loser )
        {
            record3dtext( "<dev string:x544>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        }
    #/
    
    foundanims = 0;
    possiblemelees = [];
    
    if ( abs( yawtoenemy ) > 120 )
    {
        if ( isdefined( behaviortreeentity.__forceaiflipmelee ) )
        {
            possiblemelees[ possiblemelees.size ] = &chooseaivsaimeleefrontflipanimations;
        }
        else if ( isdefined( behaviortreeentity.__forceaiwrestlemelee ) )
        {
            possiblemelees[ possiblemelees.size ] = &chooseaivsaimeleefrontwrestleanimations;
        }
        else
        {
            possiblemelees[ possiblemelees.size ] = &chooseaivsaimeleefrontflipanimations;
            possiblemelees[ possiblemelees.size ] = &chooseaivsaimeleefrontwrestleanimations;
        }
    }
    else if ( abs( yawtoenemy ) < 60 )
    {
        possiblemelees[ possiblemelees.size ] = &chooseaivsaimeleebackanimations;
    }
    else
    {
        rightvec = vectornormalize( anglestoright( behaviortreeentity.enemy.angles ) );
        toattackervec = vectornormalize( behaviortreeentity.origin - behaviortreeentity.enemy.origin );
        rdot = vectordot( toattackervec, rightvec );
        
        if ( rdot > 0 )
        {
            possiblemelees[ possiblemelees.size ] = &chooseaivsaimeleerightanimations;
        }
        else
        {
            possiblemelees[ possiblemelees.size ] = &chooseaivsaimeleeleftanimations;
        }
    }
    
    if ( possiblemelees.size > 0 )
    {
        [[ possiblemelees[ getarraykeys( possiblemelees )[ randomint( getarraykeys( possiblemelees ).size ) ] ] ]]( behaviortreeentity, animbundle );
    }
    
    if ( isdefined( behaviortreeentity._ai_melee_animname ) )
    {
        debug_chosenmeleeanimations( behaviortreeentity );
        return true;
    }
    
    return false;
}

// Namespace archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0x72193fa9, Offset: 0x2040
// Size: 0xee
function private choosearchetypevariant( entity )
{
    if ( entity.archetype == "robot" )
    {
        robot_state = entity ai::get_behavior_attribute( "rogue_control" );
        
        if ( isinarray( array( "forced_level_1", "level_1", "level_0" ), robot_state ) )
        {
            return "regular";
        }
        
        if ( isinarray( array( "forced_level_2", "level_2", "level_3", "forced_level_3" ), robot_state ) )
        {
            return "melee";
        }
    }
    
    return "regular";
}

// Namespace archetype_aivsaimelee
// Params 3, eflags: 0x4
// Checksum 0xf96d9184, Offset: 0x2138
// Size: 0x104, Type: bool
function private aivsaimeleebundleexists( behaviortreeentity, attacker_variant, defender_variant )
{
    if ( !isdefined( level._aivsai_meleebundles[ behaviortreeentity.archetype ] ) )
    {
        return false;
    }
    else if ( !isdefined( level._aivsai_meleebundles[ behaviortreeentity.archetype ][ behaviortreeentity.enemy.archetype ] ) )
    {
        return false;
    }
    else if ( !isdefined( level._aivsai_meleebundles[ behaviortreeentity.archetype ][ behaviortreeentity.enemy.archetype ][ attacker_variant ] ) )
    {
        return false;
    }
    else if ( !isdefined( level._aivsai_meleebundles[ behaviortreeentity.archetype ][ behaviortreeentity.enemy.archetype ][ attacker_variant ][ defender_variant ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace archetype_aivsaimelee
// Params 2
// Checksum 0x3260c6fb, Offset: 0x2248
// Size: 0x128
function aivsaimeleeinitialize( behaviortreeentity, asmstatename )
{
    behaviortreeentity.blockingpain = 1;
    behaviortreeentity.enemy.blockingpain = 1;
    aiutility::meleeacquiremutex( behaviortreeentity );
    behaviortreeentity._ai_melee_opponent = behaviortreeentity.enemy;
    behaviortreeentity.enemy._ai_melee_opponent = behaviortreeentity;
    
    if ( isdefined( behaviortreeentity._ai_melee_attacker_loser ) && behaviortreeentity._ai_melee_attacker_loser )
    {
        behaviortreeentity._ai_melee_markeddead = 1;
        behaviortreeentity.enemy thread playscriptedmeleeanimations();
    }
    else
    {
        behaviortreeentity.enemy._ai_melee_markeddead = 1;
        behaviortreeentity thread playscriptedmeleeanimations();
    }
    
    return 5;
}

// Namespace archetype_aivsaimelee
// Params 0
// Checksum 0x600f4c53, Offset: 0x2378
// Size: 0x564
function playscriptedmeleeanimations()
{
    self endon( #"death" );
    assert( isdefined( self._ai_melee_opponent ) );
    opponent = self._ai_melee_opponent;
    
    if ( !( isalive( self ) && isalive( opponent ) ) )
    {
        /#
            record3dtext( "<dev string:x56f>", self.origin, ( 1, 0.5, 0 ), "<dev string:x51>", self, 0.4 );
        #/
        
        return 0;
    }
    
    if ( isdefined( opponent._ai_melee_attacker_loser ) && opponent._ai_melee_attacker_loser )
    {
        opponent animscripted( "aivsaimeleeloser", self gettagorigin( "tag_sync" ), self gettagangles( "tag_sync" ), opponent._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3 );
        self animscripted( "aivsaimeleewinner", self gettagorigin( "tag_sync" ), self gettagangles( "tag_sync" ), self._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3 );
        
        /#
            recordcircle( self gettagorigin( "<dev string:x4c8>" ), 2, ( 1, 0.5, 0 ), "<dev string:x51>" );
            recordline( self gettagorigin( "<dev string:x4c8>" ), opponent.origin, ( 1, 0.5, 0 ), "<dev string:x51>" );
        #/
    }
    else
    {
        self animscripted( "aivsaimeleewinner", opponent gettagorigin( "tag_sync" ), opponent gettagangles( "tag_sync" ), self._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3 );
        opponent animscripted( "aivsaimeleeloser", opponent gettagorigin( "tag_sync" ), opponent gettagangles( "tag_sync" ), opponent._ai_melee_animname, "normal", undefined, 1, 0.2, 0.3 );
        
        /#
            recordcircle( opponent gettagorigin( "<dev string:x4c8>" ), 2, ( 1, 0.5, 0 ), "<dev string:x51>" );
            recordline( opponent gettagorigin( "<dev string:x4c8>" ), self.origin, ( 1, 0.5, 0 ), "<dev string:x51>" );
        #/
    }
    
    opponent thread handledeath( opponent._ai_melee_animname, self );
    
    if ( getdvarint( "tu1_aivsaiMeleeDisableGib", 1 ) )
    {
        if ( opponent ai::has_behavior_attribute( "can_gib" ) )
        {
            opponent ai::set_behavior_attribute( "can_gib", 0 );
        }
    }
    
    self thread processinterrupteddeath();
    opponent thread processinterrupteddeath();
    self waittillmatch( #"aivsaimeleewinner", "end" );
    self.fixedlinkyawonly = 0;
    aiutility::cleanupchargemeleeattack( self );
    
    if ( isdefined( self._ai_melee_attachedknife ) && self._ai_melee_attachedknife )
    {
        self detach( "t6_wpn_knife_melee", "TAG_WEAPON_LEFT" );
        self._ai_melee_attachedknife = 0;
    }
    
    self.blockingpain = 0;
    self._ai_melee_initiator = undefined;
    self notify( #"meleecompleted" );
    self pathmode( "move delayed", 1, 3 );
}

// Namespace archetype_aivsaimelee
// Params 2, eflags: 0x4
// Checksum 0x141df37e, Offset: 0x28e8
// Size: 0x15c
function private chooseaivsaimeleefrontflipanimations( behaviortreeentity, animbundle )
{
    /#
        record3dtext( "<dev string:x5af>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
    #/
    
    assert( isdefined( animbundle ) );
    
    if ( isdefined( behaviortreeentity._ai_melee_attacker_loser ) && behaviortreeentity._ai_melee_attacker_loser )
    {
        behaviortreeentity._ai_melee_animname = animbundle.attackerloserfrontanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerfrontanim;
    }
    else
    {
        behaviortreeentity._ai_melee_animname = animbundle.attackerfrontanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.victimfrontanim;
    }
    
    behaviortreeentity._ai_melee_animtype = 1;
    behaviortreeentity.enemy._ai_melee_animtype = 1;
}

// Namespace archetype_aivsaimelee
// Params 2, eflags: 0x4
// Checksum 0xb584cd90, Offset: 0x2a50
// Size: 0x154
function private chooseaivsaimeleefrontwrestleanimations( behaviortreeentity, animbundle )
{
    /#
        record3dtext( "<dev string:x5af>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
    #/
    
    assert( isdefined( animbundle ) );
    
    if ( isdefined( behaviortreeentity._ai_melee_attacker_loser ) && behaviortreeentity._ai_melee_attacker_loser )
    {
        behaviortreeentity._ai_melee_animname = animbundle.attackerloseralternatefrontanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinneralternatefrontanim;
    }
    else
    {
        behaviortreeentity._ai_melee_animname = animbundle.attackeralternatefrontanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.victimalternatefrontanim;
    }
    
    behaviortreeentity._ai_melee_animtype = 0;
    behaviortreeentity.enemy._ai_melee_animtype = 0;
}

// Namespace archetype_aivsaimelee
// Params 2, eflags: 0x4
// Checksum 0x6d6f2a6c, Offset: 0x2bb0
// Size: 0x15c
function private chooseaivsaimeleebackanimations( behaviortreeentity, animbundle )
{
    /#
        record3dtext( "<dev string:x5d2>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
    #/
    
    assert( isdefined( animbundle ) );
    
    if ( isdefined( behaviortreeentity._ai_melee_attacker_loser ) && behaviortreeentity._ai_melee_attacker_loser )
    {
        behaviortreeentity._ai_melee_animname = animbundle.attackerloserbackanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerbackanim;
    }
    else
    {
        behaviortreeentity._ai_melee_animname = animbundle.attackerbackanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.victimbackanim;
    }
    
    behaviortreeentity._ai_melee_animtype = 2;
    behaviortreeentity.enemy._ai_melee_animtype = 2;
}

// Namespace archetype_aivsaimelee
// Params 2, eflags: 0x4
// Checksum 0x6009560d, Offset: 0x2d18
// Size: 0x15c
function private chooseaivsaimeleerightanimations( behaviortreeentity, animbundle )
{
    /#
        record3dtext( "<dev string:x5f4>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
    #/
    
    assert( isdefined( animbundle ) );
    
    if ( isdefined( behaviortreeentity._ai_melee_attacker_loser ) && behaviortreeentity._ai_melee_attacker_loser )
    {
        behaviortreeentity._ai_melee_animname = animbundle.attackerloserrightanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerrightanim;
    }
    else
    {
        behaviortreeentity._ai_melee_animname = animbundle.attackerrightanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.victimrightanim;
    }
    
    behaviortreeentity._ai_melee_animtype = 3;
    behaviortreeentity.enemy._ai_melee_animtype = 3;
}

// Namespace archetype_aivsaimelee
// Params 2, eflags: 0x4
// Checksum 0xa4b31d2a, Offset: 0x2e80
// Size: 0x15c
function private chooseaivsaimeleeleftanimations( behaviortreeentity, animbundle )
{
    /#
        record3dtext( "<dev string:x617>", behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
    #/
    
    assert( isdefined( animbundle ) );
    
    if ( isdefined( behaviortreeentity._ai_melee_attacker_loser ) && behaviortreeentity._ai_melee_attacker_loser )
    {
        behaviortreeentity._ai_melee_animname = animbundle.attackerloserleftanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.defenderwinnerleftanim;
    }
    else
    {
        behaviortreeentity._ai_melee_animname = animbundle.attackerleftanim;
        behaviortreeentity.enemy._ai_melee_animname = animbundle.victimleftanim;
    }
    
    behaviortreeentity._ai_melee_animtype = 4;
    behaviortreeentity.enemy._ai_melee_animtype = 4;
}

// Namespace archetype_aivsaimelee
// Params 1, eflags: 0x4
// Checksum 0x6428b321, Offset: 0x2fe8
// Size: 0xfc
function private debug_chosenmeleeanimations( behaviortreeentity )
{
    /#
        if ( isdefined( behaviortreeentity._ai_melee_animname ) && isdefined( behaviortreeentity.enemy._ai_melee_animname ) )
        {
            record3dtext( "<dev string:x639>" + behaviortreeentity._ai_melee_animname, behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
            record3dtext( "<dev string:x651>" + behaviortreeentity.enemy._ai_melee_animname, behaviortreeentity.origin, ( 1, 0.5, 0 ), "<dev string:x51>", behaviortreeentity, 0.4 );
        }
    #/
}

// Namespace archetype_aivsaimelee
// Params 2
// Checksum 0x53bf8115, Offset: 0x30f0
// Size: 0x8c
function handledeath( animationname, attacker )
{
    self endon( #"death" );
    self endon( #"interrupteddeath" );
    self.skipdeath = 1;
    self.diedinscriptedanim = 1;
    totaltime = getanimlength( animationname );
    wait totaltime - 0.2;
    self killwrapper( attacker );
}

// Namespace archetype_aivsaimelee
// Params 0
// Checksum 0x7a3ec122, Offset: 0x3188
// Size: 0x27c
function processinterrupteddeath()
{
    self endon( #"meleecompleted" );
    assert( isdefined( self._ai_melee_opponent ) );
    opponent = self._ai_melee_opponent;
    
    if ( !( isdefined( self.allowdeath ) && self.allowdeath ) )
    {
        return;
    }
    
    self waittill( #"death" );
    
    if ( isdefined( self._ai_melee_attachedknife ) && isdefined( self ) && self._ai_melee_attachedknife )
    {
        self detach( "t6_wpn_knife_melee", "TAG_WEAPON_LEFT" );
    }
    
    if ( isalive( opponent ) )
    {
        if ( isdefined( opponent._ai_melee_markeddead ) && opponent._ai_melee_markeddead )
        {
            opponent.diedinscriptedanim = 1;
            opponent.skipdeath = 1;
            opponent notify( #"interrupteddeath" );
            opponent notify( #"meleecompleted" );
            opponent stopanimscripted();
            opponent killwrapper();
            opponent startragdoll();
        }
        else
        {
            opponent._ai_melee_initiator = undefined;
            opponent.blockingpain = 0;
            opponent._ai_melee_markeddead = undefined;
            opponent.skipdeath = 0;
            opponent.diedinscriptedanim = 0;
            aiutility::cleanupchargemeleeattack( opponent );
            opponent notify( #"interrupteddeath" );
            opponent notify( #"meleecompleted" );
            opponent stopanimscripted();
        }
    }
    
    if ( isdefined( self ) )
    {
        self.diedinscriptedanim = 1;
        self.skipdeath = 1;
        self notify( #"interrupteddeath" );
        self stopanimscripted();
        self killwrapper();
        self startragdoll();
    }
}

// Namespace archetype_aivsaimelee
// Params 1
// Checksum 0xf9896a69, Offset: 0x3410
// Size: 0x84
function killwrapper( attacker )
{
    if ( isdefined( self.overrideactordamage ) )
    {
        self.overrideactordamage = undefined;
    }
    
    self.tokubetsukogekita = undefined;
    
    if ( isdefined( attacker ) && self.team != attacker.team )
    {
        self kill( self.origin, attacker );
        return;
    }
    
    self kill();
}

