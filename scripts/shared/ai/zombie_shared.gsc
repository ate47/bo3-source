#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/math_shared;
#using scripts/shared/sound_shared;

#namespace zombie_shared;

// Namespace zombie_shared
// Params 0
// Checksum 0xf1bb0efd, Offset: 0x520
// Size: 0x24
function deleteatlimit()
{
    wait 30;
    self delete();
}

// Namespace zombie_shared
// Params 5
// Checksum 0x8249ceaa, Offset: 0x550
// Size: 0x2c
function lookatentity( looktargetentity, lookduration, lookspeed, eyesonly, interruptothers )
{
    
}

// Namespace zombie_shared
// Params 5
// Checksum 0x78b2033d, Offset: 0x588
// Size: 0x1b2
function lookatposition( looktargetpos, lookduration, lookspeed, eyesonly, interruptothers )
{
    assert( isai( self ), "<dev string:x28>" );
    assert( self.a.targetlookinitilized == 1, "<dev string:x57>" );
    assert( lookspeed == "<dev string:x95>" || lookspeed == "<dev string:x9c>", "<dev string:xa2>" );
    
    if ( !isdefined( interruptothers ) || interruptothers == "interrupt others" || gettime() > self.a.lookendtime )
    {
        self.a.looktargetpos = looktargetpos;
        self.a.lookendtime = gettime() + lookduration * 1000;
        
        if ( lookspeed == "casual" )
        {
            self.a.looktargetspeed = 800;
        }
        else
        {
            self.a.looktargetspeed = 1600;
        }
        
        if ( isdefined( eyesonly ) && eyesonly == "eyes only" )
        {
            self notify( #"hash_c1896d90" );
            return;
        }
        
        self notify( #"hash_9a1a418c" );
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0xe5dfdf2c, Offset: 0x748
// Size: 0x3c
function lookatanimations( leftanim, rightanim )
{
    self.a.lookanimationleft = leftanim;
    self.a.lookanimationright = rightanim;
}

// Namespace zombie_shared
// Params 1
// Checksum 0xcef2eb, Offset: 0x790
// Size: 0x138, Type: bool
function handledogsoundnotetracks( note )
{
    if ( note == "sound_dogstep_run_default" || note == "dogstep_rf" || note == "dogstep_lf" )
    {
        self playsound( "fly_dog_step_run_default" );
        return true;
    }
    
    prefix = getsubstr( note, 0, 5 );
    
    if ( prefix != "sound" )
    {
        return false;
    }
    
    alias = "aml" + getsubstr( note, 5 );
    
    if ( isalive( self ) )
    {
        self thread sound::play_on_tag( alias, "tag_eye" );
    }
    else
    {
        self thread sound::play_in_space( alias, self gettagorigin( "tag_eye" ) );
    }
    
    return true;
}

// Namespace zombie_shared
// Params 0
// Checksum 0xefff4ceb, Offset: 0x8d0
// Size: 0xc, Type: bool
function growling()
{
    return isdefined( self.script_growl );
}

// Namespace zombie_shared
// Params 0
// Checksum 0xf1673cd7, Offset: 0x8e8
// Size: 0x2a6
function registernotetracks()
{
    anim.notetracks[ "anim_pose = \"stand\"" ] = &notetrackposestand;
    anim.notetracks[ "anim_pose = \"crouch\"" ] = &notetrackposecrouch;
    anim.notetracks[ "anim_movement = \"stop\"" ] = &notetrackmovementstop;
    anim.notetracks[ "anim_movement = \"walk\"" ] = &notetrackmovementwalk;
    anim.notetracks[ "anim_movement = \"run\"" ] = &notetrackmovementrun;
    anim.notetracks[ "anim_alertness = causal" ] = &notetrackalertnesscasual;
    anim.notetracks[ "anim_alertness = alert" ] = &notetrackalertnessalert;
    anim.notetracks[ "gravity on" ] = &notetrackgravity;
    anim.notetracks[ "gravity off" ] = &notetrackgravity;
    anim.notetracks[ "gravity code" ] = &notetrackgravity;
    anim.notetracks[ "bodyfall large" ] = &notetrackbodyfall;
    anim.notetracks[ "bodyfall small" ] = &notetrackbodyfall;
    anim.notetracks[ "footstep" ] = &notetrackfootstep;
    anim.notetracks[ "step" ] = &notetrackfootstep;
    anim.notetracks[ "footstep_right_large" ] = &notetrackfootstep;
    anim.notetracks[ "footstep_right_small" ] = &notetrackfootstep;
    anim.notetracks[ "footstep_left_large" ] = &notetrackfootstep;
    anim.notetracks[ "footstep_left_small" ] = &notetrackfootstep;
    anim.notetracks[ "footscrape" ] = &notetrackfootscrape;
    anim.notetracks[ "land" ] = &notetrackland;
    anim.notetracks[ "start_ragdoll" ] = &notetrackstartragdoll;
}

// Namespace zombie_shared
// Params 2
// Checksum 0xf0b6c5d6, Offset: 0xb98
// Size: 0x14
function notetrackstopanim( note, flagname )
{
    
}

// Namespace zombie_shared
// Params 2
// Checksum 0x2b1b9cf, Offset: 0xbb8
// Size: 0x4c
function notetrackstartragdoll( note, flagname )
{
    if ( isdefined( self.noragdoll ) )
    {
        return;
    }
    
    self unlink();
    self startragdoll();
}

// Namespace zombie_shared
// Params 2
// Checksum 0xe3687222, Offset: 0xc10
// Size: 0x48
function notetrackmovementstop( note, flagname )
{
    if ( issentient( self ) )
    {
        self.a.movement = "stop";
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0x12b7e8c6, Offset: 0xc60
// Size: 0x48
function notetrackmovementwalk( note, flagname )
{
    if ( issentient( self ) )
    {
        self.a.movement = "walk";
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0x42380774, Offset: 0xcb0
// Size: 0x48
function notetrackmovementrun( note, flagname )
{
    if ( issentient( self ) )
    {
        self.a.movement = "run";
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0x56546d63, Offset: 0xd00
// Size: 0x48
function notetrackalertnesscasual( note, flagname )
{
    if ( issentient( self ) )
    {
        self.a.alertness = "casual";
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0x7d3c8c5f, Offset: 0xd50
// Size: 0x48
function notetrackalertnessalert( note, flagname )
{
    if ( issentient( self ) )
    {
        self.a.alertness = "alert";
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0x64417b5c, Offset: 0xda0
// Size: 0x44
function notetrackposestand( note, flagname )
{
    self.a.pose = "stand";
    self notify( "entered_pose" + "stand" );
}

// Namespace zombie_shared
// Params 2
// Checksum 0xb5b531dc, Offset: 0xdf0
// Size: 0x74
function notetrackposecrouch( note, flagname )
{
    self.a.pose = "crouch";
    self notify( "entered_pose" + "crouch" );
    
    if ( self.a.crouchpain )
    {
        self.a.crouchpain = 0;
        self.health = 150;
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0xd08e891, Offset: 0xe70
// Size: 0xee
function notetrackgravity( note, flagname )
{
    if ( issubstr( note, "on" ) )
    {
        self animmode( "gravity" );
        return;
    }
    
    if ( issubstr( note, "off" ) )
    {
        self animmode( "nogravity" );
        self.nogravity = 1;
        return;
    }
    
    if ( issubstr( note, "code" ) )
    {
        self animmode( "none" );
        self.nogravity = undefined;
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0x7996bdc3, Offset: 0xf68
// Size: 0xc4
function notetrackbodyfall( note, flagname )
{
    if ( isdefined( self.groundtype ) )
    {
        groundtype = self.groundtype;
    }
    else
    {
        groundtype = "dirt";
    }
    
    if ( issubstr( note, "large" ) )
    {
        self playsound( "fly_bodyfall_large_" + groundtype );
        return;
    }
    
    if ( issubstr( note, "small" ) )
    {
        self playsound( "fly_bodyfall_small_" + groundtype );
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0x80c74b0e, Offset: 0x1038
// Size: 0x94
function notetrackfootstep( note, flagname )
{
    if ( issubstr( note, "left" ) )
    {
        playfootstep( "J_Ball_LE" );
    }
    else
    {
        playfootstep( "J_BALL_RI" );
    }
    
    if ( !level.clientscripts )
    {
        self playsound( "fly_gear_run" );
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0xe08bf739, Offset: 0x10d8
// Size: 0x64
function notetrackfootscrape( note, flagname )
{
    if ( isdefined( self.groundtype ) )
    {
        groundtype = self.groundtype;
    }
    else
    {
        groundtype = "dirt";
    }
    
    self playsound( "fly_step_scrape_" + groundtype );
}

// Namespace zombie_shared
// Params 2
// Checksum 0x803319c9, Offset: 0x1148
// Size: 0x64
function notetrackland( note, flagname )
{
    if ( isdefined( self.groundtype ) )
    {
        groundtype = self.groundtype;
    }
    else
    {
        groundtype = "dirt";
    }
    
    self playsound( "fly_land_npc_" + groundtype );
}

// Namespace zombie_shared
// Params 4
// Checksum 0xbc00c609, Offset: 0x11b8
// Size: 0x30a
function handlenotetrack( note, flagname, customfunction, var1 )
{
    if ( isai( self ) && isdefined( anim.notetracks ) )
    {
        notetrackfunc = anim.notetracks[ note ];
        
        if ( isdefined( notetrackfunc ) )
        {
            return [[ notetrackfunc ]]( note, flagname );
        }
    }
    
    switch ( note )
    {
        case "end":
        case "finish":
        case "undefined":
            if ( isai( self ) && self.a.pose == "back" )
            {
            }
            
            return note;
        case "swish small":
            self thread sound::play_in_space( "fly_gear_enemy", self gettagorigin( "TAG_WEAPON_RIGHT" ) );
            break;
        case "swish large":
            self thread sound::play_in_space( "fly_gear_enemy_large", self gettagorigin( "TAG_WEAPON_RIGHT" ) );
            break;
        case "no death":
            self.a.nodeath = 1;
            break;
        case "no pain":
            self.allowpain = 0;
            break;
        case "allow pain":
            self.allowpain = 1;
            break;
        case "anim_melee = \"right\"":
        case "anim_melee = right":
            self.a.meleestate = "right";
            break;
        case "anim_melee = \"left\"":
        case "anim_melee = left":
            self.a.meleestate = "left";
            break;
        case "swap taghelmet to tagleft":
            if ( isdefined( self.hatmodel ) )
            {
                if ( isdefined( self.helmetsidemodel ) )
                {
                    self detach( self.helmetsidemodel, "TAG_HELMETSIDE" );
                    self.helmetsidemodel = undefined;
                }
                
                self detach( self.hatmodel, "" );
                self attach( self.hatmodel, "TAG_WEAPON_LEFT" );
                self.hatmodel = undefined;
            }
            
            break;
        default:
            if ( isdefined( customfunction ) )
            {
                if ( !isdefined( var1 ) )
                {
                    return [[ customfunction ]]( note );
                }
                else
                {
                    return [[ customfunction ]]( note, var1 );
                }
            }
            
            break;
    }
}

// Namespace zombie_shared
// Params 3
// Checksum 0x293cf051, Offset: 0x14d0
// Size: 0x8c
function donotetracks( flagname, customfunction, var1 )
{
    for ( ;; )
    {
        self waittill( flagname, note );
        
        if ( !isdefined( note ) )
        {
            note = "undefined";
        }
        
        val = self handlenotetrack( note, flagname, customfunction, var1 );
        
        if ( isdefined( val ) )
        {
            return val;
        }
    }
}

// Namespace zombie_shared
// Params 5
// Checksum 0x9cdddea5, Offset: 0x1568
// Size: 0x13e
function donotetracksforeverproc( notetracksfunc, flagname, killstring, customfunction, var1 )
{
    if ( isdefined( killstring ) )
    {
        self endon( killstring );
    }
    
    self endon( #"killanimscript" );
    
    for ( ;; )
    {
        time = gettime();
        returnednote = [[ notetracksfunc ]]( flagname, customfunction, var1 );
        timetaken = gettime() - time;
        
        if ( timetaken < 0.05 )
        {
            time = gettime();
            returnednote = [[ notetracksfunc ]]( flagname, customfunction, var1 );
            timetaken = gettime() - time;
            
            if ( timetaken < 0.05 )
            {
                println( gettime() + "<dev string:xc4>" + flagname + "<dev string:x111>" + returnednote + "<dev string:x11d>" );
                wait 0.05 - timetaken;
            }
        }
    }
}

// Namespace zombie_shared
// Params 4
// Checksum 0xb6bf397d, Offset: 0x16b0
// Size: 0x54
function donotetracksforever( flagname, killstring, customfunction, var1 )
{
    donotetracksforeverproc( &donotetracks, flagname, killstring, customfunction, var1 );
}

// Namespace zombie_shared
// Params 6
// Checksum 0xe9663cf2, Offset: 0x1710
// Size: 0x5a
function donotetracksfortimeproc( donotetracksforeverfunc, time, flagname, customfunction, ent, var1 )
{
    ent endon( #"stop_notetracks" );
    [[ donotetracksforeverfunc ]]( flagname, undefined, customfunction, var1 );
}

// Namespace zombie_shared
// Params 4
// Checksum 0xf012d78c, Offset: 0x1778
// Size: 0x94
function donotetracksfortime( time, flagname, customfunction, var1 )
{
    ent = spawnstruct();
    ent thread donotetracksfortimeendnotify( time );
    donotetracksfortimeproc( &donotetracksforever, time, flagname, customfunction, ent, var1 );
}

// Namespace zombie_shared
// Params 1
// Checksum 0x132b5aab, Offset: 0x1818
// Size: 0x1e
function donotetracksfortimeendnotify( time )
{
    wait time;
    self notify( #"stop_notetracks" );
}

// Namespace zombie_shared
// Params 1
// Checksum 0xac931724, Offset: 0x1840
// Size: 0x10c
function playfootstep( foot )
{
    if ( !level.clientscripts )
    {
        if ( !isai( self ) )
        {
            self playsound( "fly_step_run_dirt" );
            return;
        }
    }
    
    groundtype = undefined;
    
    if ( !isdefined( self.groundtype ) )
    {
        if ( !isdefined( self.lastgroundtype ) )
        {
            if ( !level.clientscripts )
            {
                self playsound( "fly_step_run_dirt" );
            }
            
            return;
        }
        
        groundtype = self.lastgroundtype;
    }
    else
    {
        groundtype = self.groundtype;
        self.lastgroundtype = self.groundtype;
    }
    
    if ( !level.clientscripts )
    {
        self playsound( "fly_step_run_" + groundtype );
    }
    
    [[ anim.optionalstepeffectfunction ]]( foot, groundtype );
}

// Namespace zombie_shared
// Params 2
// Checksum 0x5acb6a2c, Offset: 0x1958
// Size: 0x108
function playfootstepeffect( foot, groundtype )
{
    if ( level.clientscripts )
    {
        return;
    }
    
    for ( i = 0; i < anim.optionalstepeffects.size ; i++ )
    {
        if ( isdefined( self.fire_footsteps ) && self.fire_footsteps )
        {
            groundtype = "fire";
        }
        
        if ( groundtype != anim.optionalstepeffects[ i ] )
        {
            continue;
        }
        
        org = self gettagorigin( foot );
        playfx( level._effect[ "step_" + anim.optionalstepeffects[ i ] ], org, org + ( 0, 0, 100 ) );
        return;
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0x31182a9b, Offset: 0x1a68
// Size: 0x168
function movetooriginovertime( origin, time )
{
    self endon( #"killanimscript" );
    
    if ( distancesquared( self.origin, origin ) > 256 && !self maymovetopoint( origin ) )
    {
        println( "<dev string:x11f>" + origin + "<dev string:x14c>" );
        return;
    }
    
    self.keepclaimednodeingoal = 1;
    offset = self.origin - origin;
    frames = int( time * 20 );
    offsetreduction = vectorscale( offset, 1 / frames );
    
    for ( i = 0; i < frames ; i++ )
    {
        offset -= offsetreduction;
        self teleport( origin + offset );
        wait 0.05;
    }
    
    self.keepclaimednodeingoal = 0;
}

// Namespace zombie_shared
// Params 0
// Checksum 0x7f22aeb8, Offset: 0x1bd8
// Size: 0x8, Type: bool
function returntrue()
{
    return true;
}

// Namespace zombie_shared
// Params 0
// Checksum 0x343bdccc, Offset: 0x1be8
// Size: 0x714
function trackloop()
{
    players = getplayers();
    deltachangeperframe = 5;
    aimblendtime = 0.05;
    prevyawdelta = 0;
    prevpitchdelta = 0;
    maxyawdeltachange = 5;
    maxpitchdeltachange = 5;
    pitchadd = 0;
    yawadd = 0;
    
    if ( self.type == "dog" || self.type == "zombie" || self.type == "zombie_dog" )
    {
        domaxanglecheck = 0;
        self.shootent = self.enemy;
    }
    else
    {
        domaxanglecheck = 1;
        
        if ( self.a.script == "cover_crouch" && isdefined( self.a.covermode ) && self.a.covermode == "lean" )
        {
            pitchadd = -1 * anim.covercrouchleanpitch;
        }
        
        if ( ( self.a.script == "cover_left" || self.a.script == "cover_right" ) && isdefined( self.a.cornermode ) && self.a.cornermode == "lean" )
        {
            yawadd = self.covernode.angles[ 1 ] - self.angles[ 1 ];
        }
    }
    
    yawdelta = 0;
    pitchdelta = 0;
    firstframe = 1;
    
    for ( ;; )
    {
        incranimaimweight();
        selfshootatpos = ( self.origin[ 0 ], self.origin[ 1 ], self geteye()[ 2 ] );
        shootpos = undefined;
        
        if ( isdefined( self.enemy ) )
        {
            shootpos = self.enemy getshootatpos();
        }
        
        if ( !isdefined( shootpos ) )
        {
            yawdelta = 0;
            pitchdelta = 0;
        }
        else
        {
            vectortoshootpos = shootpos - selfshootatpos;
            anglestoshootpos = vectortoangles( vectortoshootpos );
            pitchdelta = 360 - anglestoshootpos[ 0 ];
            pitchdelta = angleclamp180( pitchdelta + pitchadd );
            yawdelta = self.angles[ 1 ] - anglestoshootpos[ 1 ];
            yawdelta = angleclamp180( yawdelta + yawadd );
        }
        
        if ( abs( yawdelta ) > 60 || domaxanglecheck && abs( pitchdelta ) > 60 )
        {
            yawdelta = 0;
            pitchdelta = 0;
        }
        else
        {
            if ( yawdelta > self.rightaimlimit )
            {
                yawdelta = self.rightaimlimit;
            }
            else if ( yawdelta < self.leftaimlimit )
            {
                yawdelta = self.leftaimlimit;
            }
            
            if ( pitchdelta > self.upaimlimit )
            {
                pitchdelta = self.upaimlimit;
            }
            else if ( pitchdelta < self.downaimlimit )
            {
                pitchdelta = self.downaimlimit;
            }
        }
        
        if ( firstframe )
        {
            firstframe = 0;
        }
        else
        {
            yawdeltachange = yawdelta - prevyawdelta;
            
            if ( abs( yawdeltachange ) > maxyawdeltachange )
            {
                yawdelta = prevyawdelta + maxyawdeltachange * math::sign( yawdeltachange );
            }
            
            pitchdeltachange = pitchdelta - prevpitchdelta;
            
            if ( abs( pitchdeltachange ) > maxpitchdeltachange )
            {
                pitchdelta = prevpitchdelta + maxpitchdeltachange * math::sign( pitchdeltachange );
            }
        }
        
        prevyawdelta = yawdelta;
        prevpitchdelta = pitchdelta;
        updown = 0;
        leftright = 0;
        
        if ( yawdelta > 0 )
        {
            assert( yawdelta <= self.rightaimlimit );
            weight = yawdelta / self.rightaimlimit * self.a.aimweight;
            leftright = weight;
        }
        else if ( yawdelta < 0 )
        {
            assert( yawdelta >= self.leftaimlimit );
            weight = yawdelta / self.leftaimlimit * self.a.aimweight;
            leftright = -1 * weight;
        }
        
        if ( pitchdelta > 0 )
        {
            assert( pitchdelta <= self.upaimlimit );
            weight = pitchdelta / self.upaimlimit * self.a.aimweight;
            updown = weight;
        }
        else if ( pitchdelta < 0 )
        {
            assert( pitchdelta >= self.downaimlimit );
            weight = pitchdelta / self.downaimlimit * self.a.aimweight;
            updown = -1 * weight;
        }
        
        wait 0.05;
    }
}

// Namespace zombie_shared
// Params 2
// Checksum 0x51a0dd60, Offset: 0x2308
// Size: 0x108
function setanimaimweight( goalweight, goaltime )
{
    if ( !isdefined( goaltime ) || goaltime <= 0 )
    {
        self.a.aimweight = goalweight;
        self.a.aimweight_start = goalweight;
        self.a.aimweight_end = goalweight;
        self.a.aimweight_transframes = 0;
    }
    else
    {
        self.a.aimweight = goalweight;
        self.a.aimweight_start = self.a.aimweight;
        self.a.aimweight_end = goalweight;
        self.a.aimweight_transframes = int( goaltime * 20 );
    }
    
    self.a.aimweight_t = 0;
}

// Namespace zombie_shared
// Params 0
// Checksum 0x1aa70a61, Offset: 0x2418
// Size: 0xb4
function incranimaimweight()
{
    if ( self.a.aimweight_t < self.a.aimweight_transframes )
    {
        self.a.aimweight_t++;
        t = 1 * self.a.aimweight_t / self.a.aimweight_transframes;
        self.a.aimweight = self.a.aimweight_start * ( 1 - t ) + self.a.aimweight_end * t;
    }
}

