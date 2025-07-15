#using scripts/shared/math_shared;

#namespace behaviortracker;

// Namespace behaviortracker
// Params 0
// Checksum 0x14162bc9, Offset: 0x1e0
// Size: 0x184
function setuptraits()
{
    if ( isdefined( self.behaviortracker.traits ) )
    {
        return;
    }
    
    self.behaviortracker.traits = [];
    self.behaviortracker.traits[ "effectiveCombat" ] = 0.5;
    self.behaviortracker.traits[ "effectiveWallRunCombat" ] = 0.5;
    self.behaviortracker.traits[ "effectiveDoubleJumpCombat" ] = 0.5;
    self.behaviortracker.traits[ "effectiveSlideCombat" ] = 0.5;
    
    if ( self.behaviortracker.version != 0 )
    {
        traits = getarraykeys( self.behaviortracker.traits );
        
        for ( i = 0; i < traits.size ; i++ )
        {
            trait = traits[ i ];
            self.behaviortracker.traits[ trait ] = float( self gettraitstatvalue( trait ) );
        }
    }
}

// Namespace behaviortracker
// Params 0
// Checksum 0x19b1ef3d, Offset: 0x370
// Size: 0x110
function initialize()
{
    if ( isdefined( self.pers[ "isBot" ] ) )
    {
        return;
    }
    
    if ( isdefined( self.behaviortracker ) )
    {
        return;
    }
    
    if ( isdefined( level.disablebehaviortracker ) && level.disablebehaviortracker == 1 )
    {
        return;
    }
    
    self.behaviortracker = spawnstruct();
    self.behaviortracker.version = int( self gettraitstatvalue( "version" ) );
    self.behaviortracker.numrecords = int( self gettraitstatvalue( "numRecords" ) ) + 1;
    self setuptraits();
    self.behaviortracker.valid = 1;
}

// Namespace behaviortracker
// Params 0
// Checksum 0x9a68c475, Offset: 0x488
// Size: 0x4c
function finalize()
{
    if ( !self isallowed() )
    {
        return;
    }
    
    self settraitstats();
    self printtrackertoblackbox();
}

// Namespace behaviortracker
// Params 0
// Checksum 0xd65b54d6, Offset: 0x4e0
// Size: 0x5c, Type: bool
function isallowed()
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !isdefined( self.behaviortracker ) )
    {
        return false;
    }
    
    if ( !self.behaviortracker.valid )
    {
        return false;
    }
    
    if ( isdefined( level.disablebehaviortracker ) && level.disablebehaviortracker == 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace behaviortracker
// Params 0
// Checksum 0xc8ad4098, Offset: 0x548
// Size: 0xac
function printtrackertoblackbox()
{
    bbprint( "mpbehaviortracker", "username %s version %d numRecords %d effectiveSlideCombat %f effectiveDoubleJumpCombat %f effectiveWallRunCombat %f effectiveCombat %f", self.name, self.behaviortracker.version, self.behaviortracker.numrecords, self.behaviortracker.traits[ "effectiveSlideCombat" ], self.behaviortracker.traits[ "effectiveDoubleJumpCombat" ], self.behaviortracker.traits[ "effectiveWallRunCombat" ], self.behaviortracker.traits[ "effectiveCombat" ] );
}

// Namespace behaviortracker
// Params 1
// Checksum 0x11a6add1, Offset: 0x600
// Size: 0x20
function gettraitvalue( trait )
{
    return self.behaviortracker.traits[ trait ];
}

// Namespace behaviortracker
// Params 2
// Checksum 0xb71a4c2e, Offset: 0x628
// Size: 0x2e
function settraitvalue( trait, value )
{
    self.behaviortracker.traits[ trait ] = value;
}

// Namespace behaviortracker
// Params 2
// Checksum 0xddece36d, Offset: 0x660
// Size: 0x164
function updatetrait( trait, percent )
{
    if ( !self isallowed() )
    {
        return;
    }
    
    math::clamp( percent, -1, 1 );
    currentvalue = self gettraitvalue( trait );
    
    if ( percent >= 0 )
    {
        delta = ( 1 - currentvalue ) * percent;
    }
    else
    {
        delta = ( currentvalue - 0 ) * percent;
    }
    
    weighteddelta = 0.1 * delta;
    newvalue = currentvalue + weighteddelta;
    newvalue = math::clamp( newvalue, 0, 1 );
    self settraitvalue( trait, newvalue );
    bbprint( "mpbehaviortraitupdate", "username %s trait %s percent %f", self.name, trait, percent );
}

// Namespace behaviortracker
// Params 3
// Checksum 0x2b140806, Offset: 0x7d0
// Size: 0x2d4
function updateplayerdamage( attacker, victim, damage )
{
    if ( isdefined( victim ) && victim isallowed() )
    {
        damageratio = float( damage ) / float( victim.maxhealth );
        math::clamp( damageratio, 0, 1 );
        damageratio *= -1;
        victim updatetrait( "effectiveCombat", damageratio );
        
        if ( victim iswallrunning() )
        {
            victim updatetrait( "effectiveWallRunCombat", damageratio );
        }
        
        if ( victim issliding() )
        {
            victim updatetrait( "effectiveSlideCombat", damageratio );
        }
        
        if ( victim isdoublejumping() )
        {
            victim updatetrait( "effectiveDoubleJumpCombat", damageratio );
        }
    }
    
    if ( isdefined( attacker ) && attacker isallowed() && attacker != victim )
    {
        damageratio = float( damage ) / float( attacker.maxhealth );
        math::clamp( damageratio, 0, 1 );
        attacker updatetrait( "effectiveCombat", damageratio );
        
        if ( attacker iswallrunning() )
        {
            attacker updatetrait( "effectiveWallRunCombat", damageratio );
        }
        
        if ( attacker issliding() )
        {
            attacker updatetrait( "effectiveSlideCombat", damageratio );
        }
        
        if ( attacker isdoublejumping() )
        {
            attacker updatetrait( "effectiveDoubleJumpCombat", damageratio );
        }
    }
}

// Namespace behaviortracker
// Params 2
// Checksum 0xc25ad2d5, Offset: 0xab0
// Size: 0x234
function updateplayerkilled( attacker, victim )
{
    if ( isdefined( victim ) && victim isallowed() )
    {
        victim updatetrait( "effectiveCombat", -1 );
        
        if ( victim iswallrunning() )
        {
            victim updatetrait( "effectiveWallRunCombat", -1 );
        }
        
        if ( victim issliding() )
        {
            victim updatetrait( "effectiveSlideCombat", -1 );
        }
        
        if ( victim isdoublejumping() )
        {
            victim updatetrait( "effectiveDoubleJumpCombat", -1 );
        }
    }
    
    if ( isdefined( attacker ) && attacker isallowed() && attacker != victim )
    {
        attacker updatetrait( "effectiveCombat", 1 );
        
        if ( attacker iswallrunning() )
        {
            attacker updatetrait( "effectiveWallRunCombat", 1 );
        }
        
        if ( attacker issliding() )
        {
            attacker updatetrait( "effectiveSlideCombat", 1 );
        }
        
        if ( attacker isdoublejumping() )
        {
            attacker updatetrait( "effectiveDoubleJumpCombat", 1 );
        }
    }
}

// Namespace behaviortracker
// Params 0
// Checksum 0xb2d34bcf, Offset: 0xcf0
// Size: 0x116
function settraitstats()
{
    if ( self.behaviortracker.version == 0 )
    {
        return;
    }
    
    self.behaviortracker.numrecords += 1;
    self settraitstatvalue( "numRecords", self.behaviortracker.numrecords );
    traits = getarraykeys( self.behaviortracker.traits );
    
    for ( i = 0; i < traits.size ; i++ )
    {
        trait = traits[ i ];
        value = self.behaviortracker.traits[ trait ];
        self settraitstatvalue( trait, value );
    }
}

// Namespace behaviortracker
// Params 1
// Checksum 0x382eab2b, Offset: 0xe10
// Size: 0x2a
function gettraitstatvalue( trait )
{
    return self getdstat( "behaviorTracker", trait );
}

// Namespace behaviortracker
// Params 2
// Checksum 0x24cd4f49, Offset: 0xe48
// Size: 0x3c
function settraitstatvalue( trait, value )
{
    self setdstat( "behaviorTracker", trait, value );
}

