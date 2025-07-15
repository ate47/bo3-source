#using scripts/codescripts/struct;
#using scripts/cp/_achievements;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/animation_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace cybercom_gadget_firefly;

// Namespace cybercom_gadget_firefly
// Params 0
// Checksum 0xd697869, Offset: 0x8b0
// Size: 0xc4
function init()
{
    clientfield::register( "vehicle", "firefly_state", 1, 4, "int" );
    clientfield::register( "actor", "firefly_state", 1, 4, "int" );
    scene::add_scene_func( "p7_fxanim_gp_ability_firefly_launch_bundle", &on_scene_firefly_launch, "play" );
    scene::add_scene_func( "p7_fxanim_gp_ability_firebug_launch_bundle", &on_scene_firefly_launch, "play" );
}

// Namespace cybercom_gadget_firefly
// Params 0
// Checksum 0xf97f2a90, Offset: 0x980
// Size: 0x184
function main()
{
    cybercom_gadget::registerability( 2, 8, 1 );
    level.cybercom.firefly_swarm = spawnstruct();
    level.cybercom.firefly_swarm._is_flickering = &_is_flickering;
    level.cybercom.firefly_swarm._on_flicker = &_on_flicker;
    level.cybercom.firefly_swarm._on_give = &_on_give;
    level.cybercom.firefly_swarm._on_take = &_on_take;
    level.cybercom.firefly_swarm._on_connect = &_on_connect;
    level.cybercom.firefly_swarm._on = &_on;
    level.cybercom.firefly_swarm._off = &_off;
    level.cybercom.firefly_swarm._is_primed = &_is_primed;
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0xadc32b30, Offset: 0xb10
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_firefly
// Params 2
// Checksum 0x5f7ce284, Offset: 0xb28
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_firefly
// Params 2
// Checksum 0xd8ea36de, Offset: 0xb48
// Size: 0xcc
function _on_give( slot, weapon )
{
    self.cybercom.targetlockcb = &_get_valid_targets;
    self.cybercom.targetlockrequirementcb = &_lock_requirement;
    self thread cybercom::function_b5f4e597( weapon );
    self cybercom::function_8257bcb3( "base_rifle", 2 );
    self cybercom::function_8257bcb3( "fem_rifle", 2 );
    self cybercom::function_8257bcb3( "riotshield", 2 );
}

// Namespace cybercom_gadget_firefly
// Params 2
// Checksum 0xafacf266, Offset: 0xc20
// Size: 0x14
function _on_take( slot, weapon )
{
    
}

// Namespace cybercom_gadget_firefly
// Params 0
// Checksum 0x99ec1590, Offset: 0xc40
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_firefly
// Params 2
// Checksum 0x2f1d4256, Offset: 0xc50
// Size: 0xf4
function _on( slot, weapon )
{
    cybercom::function_adc40f11( weapon, 1 );
    self thread spawn_firefly_swarm( self hascybercomability( "cybercom_fireflyswarm" ) == 2 );
    self notify( #"bhtn_action_notify", "firefly_deploy" );
    
    if ( isplayer( self ) )
    {
        itemindex = getitemindexfromref( "cybercom_fireflyswarm" );
        
        if ( isdefined( itemindex ) )
        {
            self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
        }
    }
}

// Namespace cybercom_gadget_firefly
// Params 2
// Checksum 0xc9f26572, Offset: 0xd50
// Size: 0x14
function _off( slot, weapon )
{
    
}

// Namespace cybercom_gadget_firefly
// Params 2
// Checksum 0x36b4b19, Offset: 0xd70
// Size: 0x14
function _is_primed( slot, weapon )
{
    
}

// Namespace cybercom_gadget_firefly
// Params 3
// Checksum 0x6e6bebce, Offset: 0xd90
// Size: 0x2dc
function ai_activatefireflyswarm( target, var_9bc2efcb, upgraded )
{
    if ( !isdefined( var_9bc2efcb ) )
    {
        var_9bc2efcb = 1;
    }
    
    if ( !isdefined( upgraded ) )
    {
        upgraded = 1;
    }
    
    self endon( #"death" );
    
    if ( self.archetype != "human" )
    {
        return;
    }
    
    if ( isdefined( var_9bc2efcb ) && var_9bc2efcb )
    {
        type = self cybercom::function_5e3d3aa();
        self orientmode( "face default" );
        self animscripted( "ai_cybercom_anim", self.origin, self.angles, "ai_base_rifle_" + type + "_exposed_cybercom_activate" );
        self playsound( "gdt_firefly_activate_npc" );
        self waittillmatch( #"ai_cybercom_anim", "fire" );
    }
    
    if ( isarray( target ) )
    {
        foreach ( guy in target )
        {
            if ( !isdefined( guy ) )
            {
                continue;
            }
            
            if ( guy.archetype == "human" || guy.archetype == "human_riotshield" || isdefined( guy.archetype ) && guy.archetype == "zombie" )
            {
                self thread spawn_firefly_swarm( upgraded, guy, 1 );
            }
        }
        
        return;
    }
    
    if ( isdefined( target ) )
    {
        if ( target.archetype == "human" || target.archetype == "human_riotshield" || isdefined( target.archetype ) && target.archetype == "zombie" )
        {
            self thread spawn_firefly_swarm( upgraded, target );
        }
    }
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0xf5d479f6, Offset: 0x1078
// Size: 0x11c
function on_scene_firefly_launch( a_ents )
{
    anim_model = a_ents[ "ability_firefly_launch" ];
    anim_model waittill( #"firefly_launch_vehicle" );
    
    if ( isdefined( anim_model ) )
    {
        origin = anim_model gettagorigin( "tag_fx_01_end_jnt" );
        angles = anim_model gettagangles( "tag_fx_01_end_jnt" );
        anim_model delete();
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( !isdefined( origin ) )
        {
            origin = self.owner.origin + ( 0, 0, 72 );
        }
        
        if ( !isdefined( angles ) )
        {
            angles = self.owner.angles;
        }
        
        self.owner notify( #"firefly_intro_done", origin, angles );
    }
}

// Namespace cybercom_gadget_firefly
// Params 0
// Checksum 0x71a2327f, Offset: 0x11a0
// Size: 0xd2
function initthreatbias()
{
    aiarray = getaiarray();
    
    foreach ( ai in aiarray )
    {
        if ( ai === self )
        {
            continue;
        }
        
        if ( ai.ignorefirefly === 1 )
        {
            ai setpersonalignore( self );
        }
    }
}

// Namespace cybercom_gadget_firefly
// Params 4
// Checksum 0xfa7bc0be, Offset: 0x1280
// Size: 0x968
function spawn_firefly_swarm( upgraded, targetent, swarms, swarmsplits )
{
    if ( !isdefined( swarms ) )
    {
        swarms = getdvarint( "scr_firefly_swarm_count", 3 );
    }
    
    if ( !isdefined( swarmsplits ) )
    {
        swarmsplits = getdvarint( "scr_firefly_swarm_split_count", 0 );
    }
    
    self endon( #"death" );
    lifetime = getdvarint( "scr_firefly_swarm_lifetime", 14 );
    splitsleft = swarmsplits;
    offspring = 0;
    firebugs = 0;
    fovtargets = [];
    
    if ( isdefined( targetent.is_disabled ) && isdefined( targetent ) && targetent.is_disabled )
    {
        targetent = undefined;
    }
    
    if ( !isvehicle( self ) )
    {
        s_anim_pos = spawnstruct();
        s_anim_pos.owner = self;
        
        if ( isplayer( self ) )
        {
            origin = self geteye();
            angles = self getplayerangles();
        }
        else
        {
            origin = self gettagorigin( "tag_eye" );
            angles = self gettagangles( "tag_eye" );
        }
        
        frontgoal = origin + anglestoforward( angles ) * 100;
        trace = bullettrace( origin, frontgoal, 0, undefined );
        
        if ( trace[ "fraction" ] == 1 )
        {
            s_anim_pos.origin = origin;
            s_anim_pos.angles = angles;
            
            if ( upgraded )
            {
                if ( sessionmodeiscampaignzombiesgame() && isworldpaused() )
                {
                }
                else
                {
                    s_anim_pos thread scene::play( "p7_fxanim_gp_ability_firebug_launch_bundle" );
                    self waittill( #"firefly_intro_done", origin, angles );
                }
            }
            else if ( sessionmodeiscampaignzombiesgame() && isworldpaused() )
            {
            }
            else
            {
                s_anim_pos thread scene::play( "p7_fxanim_gp_ability_firefly_launch_bundle" );
                self waittill( #"firefly_intro_done", origin, angles );
            }
        }
        else
        {
            origin = self.origin + ( 0, 0, 72 );
            angles = self.angles;
        }
        
        if ( upgraded )
        {
            lifetime = getdvarint( "scr_firefly_swarm_upgraded_lifetime", 14 );
            firebugs = getdvarint( "scr_firefly_swarm_firebug_count", 1 );
        }
        
        lifetime *= 1000;
        shelflife = gettime() + lifetime;
        fovtargets = self get_swarm_targetswithinfov( self.origin, self.angles );
    }
    else
    {
        shelflife = self.lifetime;
        swarms = 1;
        splitsleft = 0;
        offspring = 1;
        firebugs = isdefined( self.firebugcount ) ? self.firebugcount : 0;
        origin = self.origin;
        angles = self.angles;
    }
    
    while ( swarms )
    {
        swarm = spawnvehicle( "spawner_bo3_cybercom_firefly", origin, angles, "firefly_swarm" );
        swarms--;
        
        if ( isdefined( swarm ) )
        {
            if ( sessionmodeiscampaignzombiesgame() )
            {
                swarm setignorepauseworld( 1 );
            }
            
            swarm.threatbias = -300;
            
            if ( !isdefined( targetent ) )
            {
                if ( fovtargets.size )
                {
                    targetent = cybercom::getclosestto( swarm.origin, fovtargets );
                    arrayremovevalue( fovtargets, targetent, 0 );
                }
            }
            
            swarm.swarm_id = level.cybercom.swarms_released;
            swarm.owner = self;
            swarm.team = self.team;
            swarm.lifetime = shelflife;
            swarm.splitsleft = splitsleft;
            swarm.targetent = targetent;
            swarm.isoffspring = offspring;
            swarm.firebugcount = firebugs;
            swarm.firefly = 1;
            swarm.debug = spawnstruct();
            swarm.debug.main = 0;
            swarm.debug.attack = 0;
            swarm.debug.hunt = 0;
            swarm.debug.move = 0;
            swarm.debug.dead = 0;
            swarm initthreatbias();
            swarm.state_machine = statemachine::create( "brain", swarm, "swarm_change_state" );
            swarm.state_machine statemachine::add_state( "init", &swarm_state_enter, &swarm_init, &swarm_state_cleanup );
            swarm.state_machine statemachine::add_state( "main", &swarm_state_enter, &swarm_main_think, &swarm_state_cleanup );
            swarm.state_machine statemachine::add_state( "move", &swarm_state_enter, &swarm_move_think, &swarm_state_cleanup );
            swarm.state_machine statemachine::add_state( "attack", &swarm_state_enter, &swarm_attack_think, &swarm_state_cleanup );
            swarm.state_machine statemachine::add_state( "hunt", &swarm_state_enter, &swarm_hunt_think, &swarm_state_cleanup );
            swarm.state_machine statemachine::add_state( "dead", &swarm_state_enter, &swarm_dead_think, &swarm_state_cleanup );
            swarm.state_machine statemachine::set_state( "init" );
            targetent = undefined;
        }
        
        level notify( #"cybercom_swarm_released", swarm );
        level.cybercom.swarms_released += 1;
        level.cybercom.var_12f85dec++;
    }
}

// Namespace cybercom_gadget_firefly
// Params 0
// Checksum 0x154f396e, Offset: 0x1bf0
// Size: 0xe8
function function_54bc061f()
{
    self endon( #"death" );
    wait 0.1;
    
    for ( ;; )
    {
        self setspeed( self.settings.defaultmovespeed );
        self.current_pathto_pos = getnextmoveposition_tactical();
        
        if ( isdefined( self.current_pathto_pos ) )
        {
            usepathfinding = 1;
            
            if ( self.isonnav === 0 )
            {
                usepathfinding = 0;
            }
            
            if ( self setvehgoalpos( self.current_pathto_pos, 1, usepathfinding ) )
            {
                self thread path_update_interrupt();
                self vehicle_ai::waittill_pathing_done();
            }
        }
        
        wait 0.5;
    }
}

// Namespace cybercom_gadget_firefly
// Params 0
// Checksum 0x70cc82ba, Offset: 0x1ce0
// Size: 0xa0
function path_update_interrupt()
{
    self endon( #"death" );
    self endon( #"near_goal" );
    self endon( #"reached_end_node" );
    wait 1;
    
    while ( true )
    {
        if ( isdefined( self.current_pathto_pos ) )
        {
            if ( distance2dsquared( self.current_pathto_pos, self.goalpos ) > self.goalradius * self.goalradius )
            {
                wait 0.2;
                self notify( #"near_goal" );
            }
        }
        
        wait 0.2;
    }
}

// Namespace cybercom_gadget_firefly
// Params 0
// Checksum 0x104ac3e7, Offset: 0x1d88
// Size: 0x316
function getnextmoveposition_tactical()
{
    if ( self.goalforced )
    {
        goalpos = self getclosestpointonnavvolume( self.goalpos, 100 );
        
        if ( isdefined( goalpos ) )
        {
            if ( distancesquared( goalpos, self.goalpos ) > 50 * 50 )
            {
                self.isonnav = 0;
            }
            
            return goalpos;
        }
        
        return self.goalpos;
    }
    
    querymultiplier = 1;
    queryresult = positionquery_source_navigation( self.origin, 80, 500 * querymultiplier, 500, 3 * self.radius * querymultiplier, self, self.radius * querymultiplier );
    positionquery_filter_distancetogoal( queryresult, self );
    vehicle_ai::positionquery_filter_outofgoalanchor( queryresult );
    self.isonnav = queryresult.centeronnav;
    best_point = undefined;
    best_score = -999999;
    
    foreach ( point in queryresult.data )
    {
        randomscore = randomfloatrange( 0, 100 );
        disttooriginscore = point.disttoorigin2d * 0.2;
        point.score += randomscore + disttooriginscore;
        
        /#
            if ( !isdefined( point._scoredebug ) )
            {
                point._scoredebug = [];
            }
            
            point._scoredebug[ "<dev string:x28>" ] = disttooriginscore;
        #/
        
        point.score += disttooriginscore;
        
        if ( point.score > best_score )
        {
            best_score = point.score;
            best_point = point;
        }
    }
    
    self vehicle_ai::positionquery_debugscores( queryresult );
    
    if ( !isdefined( best_point ) )
    {
        return undefined;
    }
    
    return best_point.origin;
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0xf691e8f5, Offset: 0x20a8
// Size: 0x46
function swarm_state_cleanup( params )
{
    if ( isdefined( self.badplace ) )
    {
        badplace_delete( "swarmBP_" + self.swarm_id );
        self.badplace = undefined;
    }
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0x7c4abdd6, Offset: 0x20f8
// Size: 0x14
function swarm_state_enter( params )
{
    wait 0.05;
}

// Namespace cybercom_gadget_firefly
// Params 0
// Checksum 0xc9fc7b5d, Offset: 0x2118
// Size: 0x2c
function getenemyteam()
{
    if ( self.team === "axis" )
    {
        return "allies";
    }
    
    return "axis";
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0xe27d6667, Offset: 0x2150
// Size: 0x634
function swarm_init( params )
{
    self setmodel( "tag_origin" );
    self notsolid();
    self.notsolid = 1;
    self.vehaircraftcollisionenabled = 0;
    self notify( #"end_nudge_collision" );
    self.ignoreall = 1;
    self.takedamage = 0;
    self.goalradius = 36;
    self.goalheight = 36;
    self.good_melee_target = 1;
    self setneargoalnotifydist( 48 );
    self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    
    if ( getdvarint( "scr_firefly_swarm_debug", 0 ) )
    {
        self thread cybercom::draworiginforever();
    }
    
    self thread swarm_death_wait();
    self thread swarm_split_monitor();
    self clearforcedgoal();
    self setgoal( self.origin, 1, self.goalradius );
    
    if ( !ispointinnavvolume( self.origin, "navvolume_small" ) )
    {
        if ( isdefined( self.owner ) )
        {
            eye_origin = self.owner geteye();
        }
        else
        {
            eye_origin = self.origin;
        }
        
        pointonnavvolume = self getclosestpointonnavvolume( eye_origin, 100 );
        
        if ( isdefined( pointonnavvolume ) )
        {
            if ( !self.firebugcount )
            {
                self clientfield::set( "firefly_state", 2 );
            }
            else
            {
                self clientfield::set( "firefly_state", 7 );
            }
            
            self setvehgoalpos( pointonnavvolume, 1, 0 );
            self util::waittill_any_timeout( 2, "near_goal" );
        }
    }
    
    self thread function_54bc061f();
    
    if ( !( isdefined( self.isoffspring ) && self.isoffspring ) )
    {
        enemies = self _get_valid_targets();
        closetargets = arraysortclosest( enemies, self.origin, enemies.size, 0, 512 );
        
        if ( closetargets.size == 0 )
        {
            angles = ( self.angles[ 0 ], self.angles[ 1 ], 0 );
            frontgoal = self.origin + anglestoforward( angles ) * 240;
            a_trace = bullettrace( self.origin, frontgoal, 0, undefined, 1 );
            hitp = a_trace[ "position" ];
            queryresult = positionquery_source_navigation( hitp, 0, 72, 72, 20, self );
            
            if ( queryresult.data.size > 0 )
            {
                pathsuccess = self findpath( self.origin, queryresult.data[ 0 ].origin, 1, 0 );
                
                if ( pathsuccess )
                {
                    if ( getdvarint( "scr_firefly_swarm_debug", 0 ) )
                    {
                        level thread cybercom::debug_circle( queryresult.data[ 0 ].origin, 16, 10, ( 1, 0, 0 ) );
                    }
                    
                    self clearforcedgoal();
                    self setgoal( queryresult.data[ 0 ].origin, 1, self.goalradius );
                    
                    if ( !self.firebugcount )
                    {
                        self clientfield::set( "firefly_state", 2 );
                    }
                    else
                    {
                        self clientfield::set( "firefly_state", 7 );
                    }
                    
                    self util::waittill_any_timeout( 5, "near_goal" );
                }
            }
        }
    }
    
    if ( isdefined( self.targetent ) && isalive( self.targetent ) )
    {
        self.targetent.swarm = self;
        self.state_machine statemachine::set_state( "move" );
        return;
    }
    
    self.state_machine statemachine::set_state( "hunt" );
}

// Namespace cybercom_gadget_firefly
// Params 0
// Checksum 0x9631c0f9, Offset: 0x2790
// Size: 0xa0
function swarm_split_monitor()
{
    self endon( #"swarm_is_dead" );
    self endon( #"death" );
    wait 3;
    
    while ( self.splitsleft > 0 )
    {
        wait 0.5;
        nearent = self swarm_find_good_target( getdvarint( "scr_firefly_swarm_split_radius", 864 ) );
        
        if ( isdefined( nearent ) )
        {
            self thread spawn_firefly_swarm( 0, nearent );
            self.splitsleft--;
        }
    }
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0x27b62359, Offset: 0x2838
// Size: 0x350
function swarm_attackhumantarget( target )
{
    reactionanims = [];
    base = "base_rifle";
    
    if ( isdefined( self.voiceprefix ) && getsubstr( self.voiceprefix, 7 ) == "f" )
    {
        base = "fem_rifle";
    }
    else if ( target.archetype === "human_riotshield" )
    {
        base = "riotshield";
    }
    
    type = target cybercom::function_5e3d3aa();
    
    if ( type == "" )
    {
        target.swarm = undefined;
        self.targetent = undefined;
        target.var_86386274 = gettime() + 1000;
        self.state_machine statemachine::set_state( "main" );
        return;
    }
    
    self thread swarm_monitortargetdeath( target );
    self clientfield::set( "firefly_state", 1 );
    variant = self.owner cybercom::getanimationvariant( base );
    
    if ( self.firebugcount > 0 )
    {
        self.firebugcount--;
        reactionanims[ "intro" ] = "ai_" + base + "_" + type + "_exposed_swarm_upg_react_intro" + variant;
        target thread _firebombtarget( self, reactionanims, getweapon( "gadget_firefly_swarm_upgraded" ) );
        target notify( #"bhtn_action_notify", "fireflyAttack" );
        target clientfield::set( "firefly_state", 9 );
    }
    else
    {
        if ( target.archetype === "human" )
        {
            reactionanims[ "intro" ] = "ai_" + base + "_" + type + "_exposed_swarm_react_intro" + variant;
            reactionanims[ "outro" ] = "ai_" + base + "_" + type + "_exposed_swarm_react_outro" + variant;
        }
        else
        {
            reactionanims = [];
        }
        
        target clientfield::set( "firefly_state", 4 );
        target thread _reacttoswarm( self, reactionanims, getweapon( "gadget_firefly_swarm" ) );
        target notify( #"bhtn_action_notify", "fireflyAttack" );
    }
    
    self waittill( #"attack_stopped" );
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0xcd248b28, Offset: 0x2b90
// Size: 0x164
function swarm_attackzombietarget( target )
{
    assert( isdefined( target ) );
    
    if ( !self.firebugcount )
    {
        target clientfield::set( "firefly_state", 4 );
    }
    else
    {
        target clientfield::set( "firefly_state", 9 );
    }
    
    if ( self.firebugcount > 0 )
    {
        self.firebugcount--;
        target clientfield::set( "arch_actor_fire_fx", 1 );
        target.health = 1;
    }
    
    wait 1;
    
    if ( isdefined( target ) )
    {
        target.swarm = undefined;
    }
    
    wait randomintrange( 3, 7 );
    
    if ( isdefined( target ) && isalive( target ) )
    {
        target dodamage( target.health, target.origin, undefined, undefined, "none", "MOD_BURNED" );
    }
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0xcbd5a040, Offset: 0x2d00
// Size: 0x1f0
function function_cb5f9a2( target )
{
    assert( isdefined( target ) );
    
    if ( !self.firebugcount )
    {
        target clientfield::set( "firefly_state", 4 );
    }
    else
    {
        target clientfield::set( "firefly_state", 9 );
    }
    
    self thread swarm_monitortargetdeath( target );
    self clientfield::set( "firefly_state", 1 );
    reactionanims = [];
    
    if ( self.firebugcount > 0 && target.health <= getdvarint( "scr_firefly_swarm_warlord_hitpoint_allowed_thresh", 400 ) )
    {
        self.firebugcount--;
        target thread _firebombtarget( self, reactionanims, getweapon( "gadget_firefly_swarm_upgraded" ) );
        target notify( #"bhtn_action_notify", "fireflyAttack" );
        target clientfield::set( "firefly_state", 9 );
    }
    else
    {
        target clientfield::set( "firefly_state", 4 );
        target thread _reacttoswarm( self, reactionanims, getweapon( "gadget_firefly_swarm" ) );
        target notify( #"bhtn_action_notify", "fireflyAttack" );
    }
    
    self waittill( #"attack_stopped" );
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0x6169ce67, Offset: 0x2ef8
// Size: 0xbc
function swarm_attackplayertarget( target )
{
    self thread fireflyplayereffect( target );
    
    if ( isdefined( self.owner ) )
    {
        attacker = self.owner;
    }
    else
    {
        attacker = self;
    }
    
    target dodamage( getdvarint( "scr_swarm_player_damage", 50 ), target.origin, attacker, self, "none", "MOD_UNKNOWN", 0, getweapon( "gadget_firefly_swarm_upgraded" ) );
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0xf45241ef, Offset: 0x2fc0
// Size: 0x39c
function swarm_attack_think( params )
{
    self endon( #"swarm_is_dead" );
    self endon( #"death" );
    self.debug.attack++;
    self clientfield::set( "firefly_state", 1 );
    target = self.targetent;
    
    if ( !isdefined( target ) || !isalive( target ) )
    {
        self.targetent = undefined;
        self.state_machine statemachine::set_state( "main" );
        return;
    }
    
    target notify( #"cybercom_action", getweapon( "gadget_firefly_swarm" ), self.owner );
    
    if ( !self.firebugcount )
    {
        target clientfield::set( "firefly_state", 4 );
    }
    else
    {
        target clientfield::set( "firefly_state", 9 );
    }
    
    if ( isdefined( target.archetype ) )
    {
        if ( target.archetype == "human" || target.archetype == "human_riotshield" )
        {
            self setgoal( self.targetent.origin + ( 0, 0, 48 ), 1, self.goalradius );
            badplace_cylinder( "swarmBP_" + self.swarm_id, 0, target.origin, 256, 80, "axis" );
            self.badplace = 1;
            self swarm_attackhumantarget( target );
        }
        else if ( target.archetype == "zombie" )
        {
            self swarm_attackzombietarget( target );
        }
        else if ( target.archetype == "warlord" )
        {
            self function_cb5f9a2( target );
        }
    }
    else if ( isplayer( target ) )
    {
        self setgoal( self.targetent.origin + ( 0, 0, 48 ), 1, self.goalradius );
        badplace_cylinder( "swarmBP_" + self.swarm_id, 0, target.origin, 256, 80, "axis" );
        self.badplace = 1;
        self swarm_attackplayertarget( target );
    }
    
    self.targetent = undefined;
    self.state_machine statemachine::set_state( "main" );
    self.debug.attack--;
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0xccf3c95b, Offset: 0x3368
// Size: 0x3e
function swarm_monitortargetdeath( target )
{
    self endon( #"death" );
    self endon( #"attack_stopped" );
    target waittill( #"death" );
    self notify( #"attack_stopped" );
}

// Namespace cybercom_gadget_firefly
// Params 3, eflags: 0x4
// Checksum 0x96299d04, Offset: 0x33b0
// Size: 0xba
function private _firebombtargetpain( swarm, reactionanims, weapon )
{
    self endon( #"death" );
    
    if ( isdefined( swarm ) )
    {
        self dodamage( 5, self.origin, swarm.owner, swarm, "none", "MOD_BURNED", 0, weapon, -1, 1 );
    }
    
    if ( !self cybercom::function_421746e0() )
    {
        self waittillmatch( #"bhtn_action_terminate", "specialpain" );
    }
    
    self notify( #"firebug_time_to_die" );
}

// Namespace cybercom_gadget_firefly
// Params 0, eflags: 0x4
// Checksum 0x6a605b37, Offset: 0x3478
// Size: 0x3c
function private _firebombtargetcorpselistener()
{
    self waittill( #"actor_corpse", corpse );
    corpse clientfield::set( "arch_actor_fire_fx", 2 );
}

// Namespace cybercom_gadget_firefly
// Params 3, eflags: 0x4
// Checksum 0xdec40ca7, Offset: 0x34c0
// Size: 0x344
function private _firebombtarget( swarm, reactionanims, weapon )
{
    self endon( #"death" );
    self.ignoreall = 1;
    self.is_disabled = 1;
    var_c318824b = 0;
    self notify( #"hash_37486b44", swarm );
    level notify( #"hash_37486b44", self, swarm );
    
    if ( self cybercom::islinked() )
    {
        self unlink();
        var_c318824b = 1;
    }
    
    if ( !( isdefined( var_c318824b ) && var_c318824b ) && isdefined( reactionanims[ "intro" ] ) )
    {
        self animscripted( "swarm_intro_anim", self.origin, self.angles, reactionanims[ "intro" ] );
        self waittillmatch( #"swarm_intro_anim", "end" );
    }
    
    self clientfield::set( "arch_actor_fire_fx", 1 );
    self thread _firebombtargetcorpselistener();
    
    if ( !( isdefined( var_c318824b ) && var_c318824b ) )
    {
        self thread _firebombtargetpain( swarm, reactionanims, weapon );
        self util::waittill_any_timeout( getdvarint( "scr_firefly_swarm_human_burn_duration", 10 ), "firebug_time_to_die" );
    }
    
    self clientfield::set( "firefly_state", 10 );
    
    if ( isdefined( swarm ) )
    {
        swarm notify( #"attack_stopped" );
        
        if ( isdefined( self.voiceprefix ) && isdefined( self.bcvoicenumber ) )
        {
            self thread battlechatter::do_sound( self.voiceprefix + self.bcvoicenumber + "_exert_firefly_burning", 1 );
        }
        
        swarm.owner notify( #"hash_304642e3" );
        self dodamage( self.health, self.origin, swarm.owner, swarm, "none", "MOD_BURNED", 0, weapon, -1, 1 );
        return;
    }
    
    if ( isdefined( self.voiceprefix ) && isdefined( self.bcvoicenumber ) )
    {
        self thread battlechatter::do_sound( self.voiceprefix + self.bcvoicenumber + "_exert_firefly_burning", 1 );
    }
    
    self dodamage( self.health, self.origin, undefined, undefined, "none", "MOD_BURNED", 0, weapon, -1, 1 );
}

// Namespace cybercom_gadget_firefly
// Params 1, eflags: 0x4
// Checksum 0x188338f0, Offset: 0x3810
// Size: 0x72
function private _deathlistener( swarm )
{
    while ( isdefined( swarm ) )
    {
        self util::waittill_any_timeout( 1, "damage" );
        
        if ( isdefined( self ) && self.health <= 0 )
        {
            self clientfield::set( "firefly_state", 10 );
            return;
        }
    }
}

// Namespace cybercom_gadget_firefly
// Params 1, eflags: 0x4
// Checksum 0x88c1f5d2, Offset: 0x3890
// Size: 0x54
function private _corpsewatcher( swarm )
{
    swarm endon( #"death" );
    self waittill( #"actor_corpse", corpse );
    corpse clientfield::set( "firefly_state", 10 );
}

// Namespace cybercom_gadget_firefly
// Params 4
// Checksum 0xa54d7d0a, Offset: 0x38f0
// Size: 0xb4
function function_963f8ef6( match, note, var_1ccbc268, end )
{
    self endon( #"death" );
    
    if ( isdefined( end ) )
    {
        self endon( end );
        
        while ( true )
        {
            if ( isdefined( match ) )
            {
                self waittillmatch( match, note );
            }
            else
            {
                self waittill( note );
            }
            
            self notify( var_1ccbc268 );
        }
        
        return;
    }
    
    if ( isdefined( match ) )
    {
        self waittillmatch( match, note );
    }
    else
    {
        self waittill( note );
    }
    
    self notify( var_1ccbc268 );
}

// Namespace cybercom_gadget_firefly
// Params 3, eflags: 0x4
// Checksum 0xa0b31d42, Offset: 0x39b0
// Size: 0x46c
function private _reacttoswarm( swarm, reactionanims, weapon )
{
    self endon( #"death" );
    self thread _corpsewatcher( swarm );
    oldaware = self.badplaceawareness;
    self.badplaceawareness = 0.1;
    self.is_disabled = 1;
    self orientmode( "face point", swarm.origin );
    self notify( #"hash_4457f945", swarm );
    level notify( #"hash_4457f945", self, swarm );
    
    if ( self cybercom::function_421746e0() )
    {
        self kill( self.origin, isdefined( swarm.owner ) ? swarm.owner : undefined );
        
        if ( isdefined( swarm ) )
        {
            swarm notify( #"attack_stopped" );
        }
        
        return;
    }
    
    if ( !isalive( self ) || self isragdoll() )
    {
        return;
    }
    
    if ( isdefined( reactionanims[ "intro" ] ) )
    {
        self animscripted( "swarm_intro_anim", self.origin, self.angles, reactionanims[ "intro" ] );
        self thread cybercom::stopanimscriptedonnotify( "damage", "swarm_intro_anim" );
        self waittillmatch( #"swarm_intro_anim", "end" );
    }
    
    for ( attack = 1; attack && isdefined( swarm ) ; attack = isdefined( swarm ) && !( isdefined( swarm.dying_out ) && swarm.dying_out ) && distancesquared( self.origin + ( 0, 0, 48 ), swarm.origin ) < getdvarint( "scr_firefly_swarm_attack_radius", 110 ) * getdvarint( "scr_firefly_swarm_attack_radius", 110 ) && isalive( self ) )
    {
        self dodamage( 5, self.origin, swarm.owner, swarm, "none", "MOD_UNKNOWN", 0, weapon, -1, 1 );
        wait 0.05;
        self waittillmatch( #"bhtn_action_terminate", "specialpain" );
    }
    
    self notify( #"attack_stopped" );
    
    if ( isalive( self ) && !self isragdoll() )
    {
        self clientfield::set( "firefly_state", 5 );
        self.badplaceawareness = oldaware;
        self.swarm = undefined;
        self orientmode( "face default" );
        
        if ( isdefined( reactionanims[ "outro" ] ) )
        {
            self animscripted( "swarm_outro_anim", self.origin, self.angles, reactionanims[ "outro" ] );
            self thread cybercom::stopanimscriptedonnotify( "damage", "swarm_outro_anim" );
            self waittillmatch( #"swarm_outro_anim", "end" );
        }
        
        self.is_disabled = undefined;
    }
    
    if ( isdefined( swarm ) )
    {
        swarm notify( #"attack_stopped" );
    }
}

// Namespace cybercom_gadget_firefly
// Params 0
// Checksum 0xbfe99ad4, Offset: 0x3e28
// Size: 0xe4
function swarm_delete()
{
    if ( isdefined( self ) )
    {
        self notify( #"swarm_is_dead" );
        
        if ( isdefined( self.targetent ) && !isplayer( self.targetent ) )
        {
            self.targetent clientfield::set( "firefly_state", 5 );
            self.targetent.swarm = undefined;
            self.targetent.swarm_coolofftime = gettime() + 2000;
        }
        
        level.cybercom.var_12f85dec--;
        achievements::function_b2d1aafa();
        self swarm_state_cleanup();
        self delete();
    }
}

// Namespace cybercom_gadget_firefly
// Params 0
// Checksum 0x1815d5b3, Offset: 0x3f18
// Size: 0x4c
function swarm_death_wait()
{
    self endon( #"death" );
    
    while ( gettime() < self.lifetime )
    {
        wait 1;
    }
    
    self.dying_out = 1;
    wait 2;
    self swarm_delete();
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0x401b90a4, Offset: 0x3f70
// Size: 0x15c
function swarm_dead_think( params )
{
    self notify( #"swarm_is_dead" );
    self endon( #"death" );
    self clearforcedgoal();
    
    if ( !self.firebugcount )
    {
        self clientfield::set( "firefly_state", 5 );
    }
    else
    {
        self clientfield::set( "firefly_state", 10 );
    }
    
    if ( isdefined( self.targetent ) && !isplayer( self.targetent ) )
    {
        self.targetent clientfield::set( "firefly_state", 5 );
        self.targetent.swarm = undefined;
        self.targetent.swarm_coolofftime = gettime() + 2000;
    }
    
    self vehicle::toggle_sounds( 0 );
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( #"bhtn_action_notify", "firefly_end" );
    }
    
    wait 3;
    self swarm_delete();
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0x1e0a005d, Offset: 0x40d8
// Size: 0x16c
function swarm_main_think( params )
{
    self endon( #"swarm_is_dead" );
    self endon( #"death" );
    
    if ( isdefined( self.dying_out ) && self.dying_out )
    {
        self.state_machine statemachine::set_state( "dead" );
        return;
    }
    
    self.debug.main++;
    
    if ( !isdefined( self.targetent ) )
    {
        self.state_machine statemachine::set_state( "hunt" );
    }
    else if ( distancesquared( self.targetent.origin + ( 0, 0, 48 ), self.origin ) > getdvarint( "scr_firefly_swarm_attack_radius", 110 ) * getdvarint( "scr_firefly_swarm_attack_radius", 110 ) )
    {
        self.state_machine statemachine::set_state( "move" );
    }
    else
    {
        self.state_machine statemachine::set_state( "attack" );
    }
    
    self.debug.main--;
}

// Namespace cybercom_gadget_firefly
// Params 0, eflags: 0x4
// Checksum 0x378bf8f3, Offset: 0x4250
// Size: 0xf2
function private _get_valid_targets()
{
    humans = arraycombine( getaispeciesarray( self getenemyteam(), "human" ), getaispeciesarray( "team3", "human" ), 0, 0 );
    zombies = arraycombine( getaispeciesarray( self getenemyteam(), "zombie" ), getaispeciesarray( "team3", "zombie" ), 0, 0 );
    return arraycombine( humans, zombies, 0, 0 );
}

// Namespace cybercom_gadget_firefly
// Params 1, eflags: 0x4
// Checksum 0xcd42bbf, Offset: 0x4350
// Size: 0x1c8, Type: bool
function private _lock_requirement( target )
{
    if ( isdefined( self.owner ) && !self.owner cybercom::targetisvalid( target, getweapon( "gadget_firefly_swarm" ) ) )
    {
        return false;
    }
    
    if ( target.archetype != "human" && target.archetype != "human_riotshield" && target.archetype != "zombie" && target.archetype != "warlord" )
    {
        return false;
    }
    
    if ( target cybercom::cybercom_aicheckoptout( "cybercom_fireflyswarm" ) )
    {
        return false;
    }
    
    if ( isdefined( target.swarm ) )
    {
        return false;
    }
    
    if ( isdefined( target.var_86386274 ) )
    {
        if ( target.var_86386274 > gettime() )
        {
            return false;
        }
        
        target.var_86386274 = undefined;
    }
    
    if ( isdefined( target.swarm_coolofftime ) && gettime() < target.swarm_coolofftime )
    {
        return false;
    }
    
    if ( isactor( target ) && target cybercom::getentitypose() != "stand" && target cybercom::getentitypose() != "crouch" )
    {
        return false;
    }
    
    return true;
}

// Namespace cybercom_gadget_firefly
// Params 4
// Checksum 0x96f2d438, Offset: 0x4520
// Size: 0x1a2
function get_swarm_targetswithinfov( origin, angles, var_10a84c6e, nfor )
{
    if ( !isdefined( var_10a84c6e ) )
    {
        var_10a84c6e = getdvarint( "scr_firefly_swarm_hunt_radius", 1536 );
    }
    
    if ( !isdefined( nfor ) )
    {
        nfor = cos( 45 );
    }
    
    enemies = self _get_valid_targets();
    closetargets = arraysortclosest( enemies, origin, enemies.size, 0, var_10a84c6e );
    fovtargets = [];
    
    foreach ( guy in closetargets )
    {
        if ( !_lock_requirement( guy ) )
        {
            continue;
        }
        
        if ( util::within_fov( origin, angles, guy.origin, nfor ) )
        {
            fovtargets[ fovtargets.size ] = guy;
        }
    }
    
    return fovtargets;
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0x1a5d1eb0, Offset: 0x46d0
// Size: 0x224
function swarm_find_good_target( var_10a84c6e )
{
    if ( !isdefined( var_10a84c6e ) )
    {
        var_10a84c6e = getdvarint( "scr_firefly_swarm_hunt_radius", 1536 );
    }
    
    self endon( #"swarm_is_dead" );
    self endon( #"death" );
    enemies = self _get_valid_targets();
    closetargets = arraysortclosest( enemies, self.origin, enemies.size, 0, var_10a84c6e );
    closest = undefined;
    
    while ( closetargets.size > 0 )
    {
        closest = cybercom::getclosestto( self.origin, closetargets, var_10a84c6e );
        
        if ( !_lock_requirement( closest ) )
        {
            arrayremovevalue( closetargets, closest, 0 );
            closest = undefined;
            wait 0.05;
            continue;
        }
        
        if ( !isdefined( closest ) )
        {
            break;
        }
        
        pathsuccess = 0;
        queryresult = positionquery_source_navigation( closest.origin, 0, 128, 128, 20, self );
        
        if ( queryresult.data.size > 0 )
        {
            pathsuccess = self findpath( self.origin, queryresult.data[ 0 ].origin, 1, 0 );
        }
        
        if ( !pathsuccess )
        {
            arrayremovevalue( closetargets, closest, 0 );
            closest = undefined;
            wait 0.05;
            continue;
        }
        
        break;
    }
    
    return closest;
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0x3963bb96, Offset: 0x4900
// Size: 0x1a4
function swarm_hunt_think( params )
{
    self endon( #"swarm_is_dead" );
    self endon( #"death" );
    self.debug.hunt++;
    self util::waittill_any_timeout( 3, "near_goal" );
    self clearforcedgoal();
    
    if ( !self.firebugcount )
    {
        self clientfield::set( "firefly_state", 1 );
    }
    else
    {
        self clientfield::set( "firefly_state", 6 );
    }
    
    if ( getdvarint( "scr_firefly_swarm_debug", 0 ) )
    {
        self thread cybercom::debug_circle( self.origin, getdvarint( "scr_firefly_swarm_hunt_radius", 1536 ), 0.1, ( 1, 1, 0 ) );
    }
    
    self.targetent = self swarm_find_good_target();
    
    if ( isdefined( self.targetent ) )
    {
        self.targetent.swarm = self;
    }
    
    if ( !isdefined( self.targetent ) && isdefined( self.owner ) )
    {
    }
    
    self.state_machine statemachine::set_state( "main" );
    self.debug.hunt--;
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0x6fe6dfcb, Offset: 0x4ab0
// Size: 0x1bc
function swarm_move_think( params )
{
    self endon( #"swarm_is_dead" );
    self endon( #"death" );
    self.debug.move++;
    
    if ( !self.firebugcount )
    {
        self clientfield::set( "firefly_state", 2 );
    }
    else
    {
        self clientfield::set( "firefly_state", 7 );
    }
    
    wait 0.5;
    self.goalradius = 12;
    self.goalheight = 12;
    
    if ( !self.firebugcount )
    {
        self clientfield::set( "firefly_state", 3 );
    }
    else
    {
        self clientfield::set( "firefly_state", 8 );
    }
    
    self clearforcedgoal();
    
    if ( isdefined( self.targetent ) )
    {
        self setgoal( self.targetent.origin + ( 0, 0, 48 ), 1, self.goalradius );
        event = self util::waittill_any_timeout( 30, "near_goal" );
    }
    
    self.state_machine statemachine::set_state( "main" );
    self.debug.move--;
}

// Namespace cybercom_gadget_firefly
// Params 1
// Checksum 0x259916c8, Offset: 0x4c78
// Size: 0x3c
function fireflyplayereffect( player )
{
    self endon( #"disconnect" );
    player shellshock( "proximity_grenade", 2, 0 );
}

