#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/challenges_shared;
#using scripts/shared/spawner_shared;
#using scripts/zm/_bb;
#using scripts/zm/_challenges;
#using scripts/zm/gametypes/_damagefeedback;
#using scripts/zm/gametypes/_globallogic_player;
#using scripts/zm/gametypes/_globallogic_utils;
#using scripts/zm/gametypes/_weapons;

#namespace globallogic_actor;

// Namespace globallogic_actor
// Params 1
// Checksum 0x991275da, Offset: 0x2d8
// Size: 0x3c
function callback_actorspawned( spawner )
{
    self thread spawner::run_spawn_functions();
    bb::logaispawn( self, spawner );
}

// Namespace globallogic_actor
// Params 15
// Checksum 0x92aa45a9, Offset: 0x320
// Size: 0xabc
function callback_actordamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal )
{
    if ( game[ "state" ] == "postgame" )
    {
        return;
    }
    
    if ( self.team == "spectator" )
    {
        return;
    }
    
    if ( isdefined( eattacker ) && isplayer( eattacker ) && isdefined( eattacker.candocombat ) && !eattacker.candocombat )
    {
        return;
    }
    
    self.idflags = idflags;
    self.idflagstime = gettime();
    eattacker = globallogic_player::figureoutattacker( eattacker );
    
    if ( !isdefined( vdir ) )
    {
        idflags |= level.idflags_no_knockback;
    }
    
    friendly = 0;
    
    if ( self.health == self.maxhealth || !isdefined( self.attackers ) )
    {
        self.attackers = [];
        self.attackerdata = [];
        self.attackerdamage = [];
    }
    
    if ( globallogic_utils::isheadshot( weapon, shitloc, smeansofdeath, einflictor ) )
    {
        smeansofdeath = "MOD_HEAD_SHOT";
    }
    
    if ( level.onlyheadshots )
    {
        if ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" )
        {
            return;
        }
        else if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            idamage = 150;
        }
    }
    
    if ( isdefined( self.aioverridedamage ) )
    {
        for ( index = 0; index < self.aioverridedamage.size ; index++ )
        {
            damagecallback = self.aioverridedamage[ index ];
            idamage = self [[ damagecallback ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex );
        }
        
        if ( idamage < 1 )
        {
            return;
        }
        
        idamage = int( idamage + 0.5 );
    }
    
    if ( weapon == level.weaponnone && isdefined( einflictor ) )
    {
        if ( isdefined( einflictor.targetname ) && einflictor.targetname == "explodable_barrel" )
        {
            weapon = getweapon( "explodable_barrel" );
        }
        else if ( isdefined( einflictor.destructible_type ) && issubstr( einflictor.destructible_type, "vehicle_" ) )
        {
            weapon = getweapon( "destructible_car" );
        }
    }
    
    if ( !( idflags & level.idflags_no_protection ) )
    {
        if ( isplayer( eattacker ) )
        {
            eattacker.pers[ "participation" ]++;
        }
        
        prevhealthratio = self.health / self.maxhealth;
        
        if ( level.teambased && isplayer( eattacker ) && self != eattacker && self.team == eattacker.pers[ "team" ] )
        {
            if ( level.friendlyfire == 0 )
            {
                return;
            }
            else if ( level.friendlyfire == 1 )
            {
                if ( idamage < 1 )
                {
                    idamage = 1;
                }
                
                self.lastdamagewasfromenemy = 0;
                self globallogic_player::giveattackerandinflictorownerassist( eattacker, einflictor, idamage, smeansofdeath, weapon );
                self finishactordamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal );
            }
            else if ( level.friendlyfire == 2 )
            {
                return;
            }
            else if ( level.friendlyfire == 3 )
            {
                idamage = int( idamage * 0.5 );
                
                if ( idamage < 1 )
                {
                    idamage = 1;
                }
                
                self.lastdamagewasfromenemy = 0;
                self globallogic_player::giveattackerandinflictorownerassist( eattacker, einflictor, idamage, smeansofdeath, weapon );
                self finishactordamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal );
            }
            
            friendly = 1;
        }
        else
        {
            if ( isdefined( eattacker ) && isdefined( self.script_owner ) && eattacker == self.script_owner && !level.hardcoremode )
            {
                return;
            }
            
            if ( isdefined( eattacker ) && isdefined( self.script_owner ) && isdefined( eattacker.script_owner ) && eattacker.script_owner == self.script_owner )
            {
                return;
            }
            
            if ( idamage < 1 )
            {
                idamage = 1;
            }
            
            if ( issubstr( smeansofdeath, "MOD_GRENADE" ) && isdefined( einflictor ) && isdefined( einflictor.iscooked ) )
            {
                self.wascooked = gettime();
            }
            else
            {
                self.wascooked = undefined;
            }
            
            self.lastdamagewasfromenemy = isdefined( eattacker ) && eattacker != self;
            self globallogic_player::giveattackerandinflictorownerassist( eattacker, einflictor, idamage, smeansofdeath, weapon );
            self finishactordamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal );
        }
        
        if ( isdefined( eattacker ) && eattacker != self )
        {
            if ( !isdefined( einflictor ) || !isai( einflictor ) )
            {
                if ( idamage > 0 && shitloc !== "riotshield" )
                {
                    eattacker thread damagefeedback::updatedamagefeedback( smeansofdeath, einflictor );
                }
            }
        }
    }
    
    /#
        if ( getdvarint( "<dev string:x28>" ) )
        {
            println( "<dev string:x36>" + self getentitynumber() + "<dev string:x3d>" + self.health + "<dev string:x46>" + eattacker.clientid + "<dev string:x51>" + isplayer( einflictor ) + "<dev string:x67>" + idamage + shitloc + "<dev string:x70>" + boneindex + "<dev string:x72>" );
        }
    #/
    
    if ( true )
    {
        lpselfnum = self getentitynumber();
        lpselfteam = self.team;
        lpattackerteam = "";
        
        if ( isplayer( eattacker ) )
        {
            lpattacknum = eattacker getentitynumber();
            lpattackguid = eattacker getguid();
            lpattackname = eattacker.name;
            lpattackerteam = eattacker.pers[ "team" ];
        }
        else
        {
            lpattacknum = -1;
            lpattackguid = "";
            lpattackname = "";
            lpattackerteam = "world";
        }
        
        logprint( "AD;" + lpselfnum + ";" + lpselfteam + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + weapon.name + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\n" );
    }
}

// Namespace globallogic_actor
// Params 8
// Checksum 0x538ebcb2, Offset: 0xde8
// Size: 0x1ac
function callback_actorkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    if ( game[ "state" ] == "postgame" )
    {
        return;
    }
    
    if ( isai( attacker ) && isdefined( attacker.script_owner ) )
    {
        if ( attacker.script_owner.team != self.team )
        {
            attacker = attacker.script_owner;
        }
    }
    
    if ( attacker.classname == "script_vehicle" && isdefined( attacker.owner ) )
    {
        attacker = attacker.owner;
    }
    
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        if ( !level.teambased || self.team != attacker.pers[ "team" ] )
        {
            level.globalkillstreaksdestroyed++;
            attacker addweaponstat( getweapon( "dogs" ), "destroyed", 1 );
            attacker challenges::killeddog();
        }
    }
}

// Namespace globallogic_actor
// Params 1
// Checksum 0x399f3fb7, Offset: 0xfa0
// Size: 0x3c
function callback_actorcloned( original )
{
    destructserverutils::copydestructstate( original, self );
    gibserverutils::copygibstate( original, self );
}

