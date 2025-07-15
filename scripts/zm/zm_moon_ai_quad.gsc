#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_quad;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_moon_ai_quad;

// Namespace zm_moon_ai_quad
// Params 0, eflags: 0x2
// Checksum 0xa925bffa, Offset: 0x620
// Size: 0x3c
function autoexec init()
{
    function_e9b3dfb0();
    spawner::add_archetype_spawn_function( "zombie_quad", &function_5076473f );
}

// Namespace zm_moon_ai_quad
// Params 0, eflags: 0x4
// Checksum 0xa4112eb7, Offset: 0x668
// Size: 0x174
function private function_e9b3dfb0()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "quadPhasingService", &quadphasingservice );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "shouldPhase", &shouldphase );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "phaseActionStart", &phaseactionstart );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "phaseActionTerminate", &phaseactionterminate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "moonQuadKilledByMicrowaveGunDw", &killedbymicrowavegundw );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "moonQuadKilledByMicrowaveGun", &killedbymicrowavegun );
    animationstatenetwork::registernotetrackhandlerfunction( "phase_start", &function_51ab54f7 );
    animationstatenetwork::registernotetrackhandlerfunction( "phase_end", &function_428f351c );
    animationstatenetwork::registeranimationmocomp( "quad_phase", &function_4e0a671e, undefined, undefined );
}

// Namespace zm_moon_ai_quad
// Params 1, eflags: 0x4
// Checksum 0x500b30f7, Offset: 0x7e8
// Size: 0x39c, Type: bool
function private quadphasingservice( entity )
{
    if ( isdefined( entity.is_phasing ) && entity.is_phasing )
    {
        return false;
    }
    
    entity.can_phase = 0;
    
    if ( entity.var_20535e44 == 0 )
    {
        if ( math::cointoss() )
        {
            entity.var_3b07930a = "quad_phase_right";
        }
        else
        {
            entity.var_3b07930a = "quad_phase_left";
        }
    }
    else if ( entity.var_20535e44 == -1 )
    {
        entity.var_3b07930a = "quad_phase_right";
    }
    else
    {
        entity.var_3b07930a = "quad_phase_left";
    }
    
    if ( entity.var_3b07930a == "quad_phase_left" )
    {
        if ( isplayer( entity.enemy ) && entity.enemy islookingat( entity ) )
        {
            if ( entity maymovefrompointtopoint( entity.origin, zombie_utility::getanimendpos( level.var_9fcbbc83[ "phase_left_long" ] ) ) )
            {
                entity.can_phase = 1;
            }
        }
    }
    else if ( isplayer( entity.enemy ) && entity.enemy islookingat( entity ) )
    {
        if ( entity maymovefrompointtopoint( entity.origin, zombie_utility::getanimendpos( level.var_9fcbbc83[ "phase_right_long" ] ) ) )
        {
            entity.can_phase = 1;
        }
    }
    
    if ( !( isdefined( entity.can_phase ) && entity.can_phase ) )
    {
        if ( entity maymovefrompointtopoint( entity.origin, zombie_utility::getanimendpos( level.var_9fcbbc83[ "phase_forward" ] ) ) )
        {
            entity.can_phase = 1;
            entity.var_3b07930a = "quad_phase_forward";
        }
    }
    
    if ( isdefined( entity.can_phase ) && entity.can_phase )
    {
        blackboard::setblackboardattribute( entity, "_quad_phase_direction", entity.var_3b07930a );
        
        if ( math::cointoss() )
        {
            blackboard::setblackboardattribute( entity, "_quad_phase_distance", "quad_phase_short" );
        }
        else
        {
            blackboard::setblackboardattribute( entity, "_quad_phase_distance", "quad_phase_long" );
        }
        
        return true;
    }
    
    return false;
}

// Namespace zm_moon_ai_quad
// Params 1, eflags: 0x4
// Checksum 0xb53c5092, Offset: 0xb90
// Size: 0x22c, Type: bool
function private shouldphase( entity )
{
    if ( !( isdefined( entity.can_phase ) && entity.can_phase ) )
    {
        return false;
    }
    
    if ( isdefined( entity.is_phasing ) && entity.is_phasing )
    {
        return false;
    }
    
    if ( gettime() - entity.var_b7d765b3 < 2000 )
    {
        return false;
    }
    
    if ( !isdefined( entity.enemy ) )
    {
        return false;
    }
    
    dist_sq = distancesquared( entity.origin, entity.enemy.origin );
    min_dist_sq = 4096;
    max_dist_sq = 1000000;
    
    if ( entity.var_3b07930a == "quad_phase_forward" )
    {
        min_dist_sq = 14400;
        max_dist_sq = 5760000;
    }
    
    if ( dist_sq < min_dist_sq )
    {
        return false;
    }
    
    if ( dist_sq > max_dist_sq )
    {
        return false;
    }
    
    if ( !isdefined( entity.pathgoalpos ) || distancesquared( entity.origin, entity.pathgoalpos ) < min_dist_sq )
    {
        return false;
    }
    
    if ( abs( entity getmotionangle() ) > 15 )
    {
        return false;
    }
    
    yaw = zombie_utility::getyawtoorigin( entity.enemy.origin );
    
    if ( abs( yaw ) > 45 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_moon_ai_quad
// Params 1, eflags: 0x4
// Checksum 0x7bc2833c, Offset: 0xdc8
// Size: 0x7c
function private phaseactionstart( entity )
{
    entity.is_phasing = 1;
    
    if ( entity.var_3b07930a == "quad_phase_left" )
    {
        entity.var_20535e44--;
        return;
    }
    
    if ( entity.var_3b07930a == "quad_phase_right" )
    {
        entity.var_20535e44++;
    }
}

// Namespace zm_moon_ai_quad
// Params 1, eflags: 0x4
// Checksum 0x682f8065, Offset: 0xe50
// Size: 0x2c
function private phaseactionterminate( entity )
{
    entity.var_b7d765b3 = gettime();
    entity.is_phasing = 0;
}

// Namespace zm_moon_ai_quad
// Params 1, eflags: 0x4
// Checksum 0xb4d12f1d, Offset: 0xe88
// Size: 0x2e, Type: bool
function private killedbymicrowavegundw( entity )
{
    return isdefined( entity.microwavegun_dw_death ) && entity.microwavegun_dw_death;
}

// Namespace zm_moon_ai_quad
// Params 1, eflags: 0x4
// Checksum 0x4f24dc7b, Offset: 0xec0
// Size: 0x2e, Type: bool
function private killedbymicrowavegun( entity )
{
    return isdefined( entity.microwavegun_death ) && entity.microwavegun_death;
}

// Namespace zm_moon_ai_quad
// Params 1, eflags: 0x4
// Checksum 0x53349f2e, Offset: 0xef8
// Size: 0x44
function private function_51ab54f7( entity )
{
    entity thread moon_quad_phase_fx( "quad_phasing_out" );
    entity ghost();
}

// Namespace zm_moon_ai_quad
// Params 1, eflags: 0x4
// Checksum 0xa29b838f, Offset: 0xf48
// Size: 0x44
function private function_428f351c( entity )
{
    entity thread moon_quad_phase_fx( "quad_phasing_in" );
    entity show();
}

// Namespace zm_moon_ai_quad
// Params 5, eflags: 0x4
// Checksum 0xe29d6ad6, Offset: 0xf98
// Size: 0x4c
function private function_4e0a671e( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    entity animmode( "gravity", 0 );
}

// Namespace zm_moon_ai_quad
// Params 0
// Checksum 0x3c6524ed, Offset: 0xff0
// Size: 0x17e
function function_5076473f()
{
    self.can_phase = 0;
    self.var_b7d765b3 = gettime();
    self.var_20535e44 = 0;
    
    if ( !isdefined( level.var_9fcbbc83 ) )
    {
        level.var_9fcbbc83 = [];
        level.var_9fcbbc83[ "phase_forward" ] = self animmappingsearch( istring( "anim_zombie_phase_f_long_b" ) );
        level.var_9fcbbc83[ "phase_left_long" ] = self animmappingsearch( istring( "anim_zombie_phase_l_long_b" ) );
        level.var_9fcbbc83[ "phase_left_short" ] = self animmappingsearch( istring( "anim_zombie_phase_l_short_b" ) );
        level.var_9fcbbc83[ "phase_right_long" ] = self animmappingsearch( istring( "anim_zombie_phase_r_long_b" ) );
        level.var_9fcbbc83[ "phase_right_short" ] = self animmappingsearch( istring( "anim_zombie_phase_r_short_a" ) );
    }
}

// Namespace zm_moon_ai_quad
// Params 0
// Checksum 0x82f11bf4, Offset: 0x1178
// Size: 0x54
function moon_quad_prespawn()
{
    self.no_gib = 1;
    self.zombie_can_sidestep = 1;
    self.zombie_can_forwardstep = 1;
    self.sidestepfunc = &moon_quad_sidestep;
    self.fastsprintfunc = &moon_quad_fastsprint;
}

// Namespace zm_moon_ai_quad
// Params 2
// Checksum 0x498f4ad1, Offset: 0x11d8
// Size: 0x164
function moon_quad_sidestep( animname, stepanim )
{
    self endon( #"death" );
    self endon( #"stop_sidestep" );
    self thread moon_quad_wait_phase_end( stepanim );
    self thread moon_quad_exit_align( stepanim );
    
    while ( true )
    {
        self waittill( animname, note );
        
        if ( note == "phase_start" )
        {
            self thread moon_quad_phase_fx( "quad_phasing_out" );
            self playsound( "zmb_quad_phase_out" );
            self ghost();
            continue;
        }
        
        if ( note == "phase_end" )
        {
            self notify( #"stop_wait_phase_end" );
            self thread moon_quad_phase_fx( "quad_phasing_in" );
            self show();
            self playsound( "zmb_quad_phase_in" );
            break;
        }
    }
}

// Namespace zm_moon_ai_quad
// Params 0
// Checksum 0x256543ad, Offset: 0x1348
// Size: 0x2a
function moon_quad_fastsprint()
{
    if ( isdefined( self.in_low_gravity ) && self.in_low_gravity )
    {
        return "low_g_super_sprint";
    }
    
    return "super_sprint";
}

// Namespace zm_moon_ai_quad
// Params 1
// Checksum 0x45746c11, Offset: 0x1380
// Size: 0x92
function moon_quad_wait_phase_end( stepanim )
{
    self endon( #"death" );
    self endon( #"stop_wait_phase_end" );
    anim_length = getanimlength( stepanim );
    wait anim_length;
    self thread moon_quad_phase_fx( "quad_phasing_in" );
    self show();
    self notify( #"stop_sidestep" );
}

// Namespace zm_moon_ai_quad
// Params 1
// Checksum 0x4a91a0b, Offset: 0x1420
// Size: 0x6a
function moon_quad_exit_align( stepanim )
{
    self endon( #"death" );
    anim_length = getanimlength( stepanim );
    wait anim_length;
    
    if ( !( isdefined( self.exit_align ) && self.exit_align ) )
    {
        self notify( #"stepanim", "exit_align" );
    }
}

// Namespace zm_moon_ai_quad
// Params 1
// Checksum 0x8bb9db1, Offset: 0x1498
// Size: 0x54
function moon_quad_phase_fx( var_99a8589b )
{
    self endon( #"death" );
    
    if ( isdefined( level._effect[ var_99a8589b ] ) )
    {
        playfxontag( level._effect[ var_99a8589b ], self, "j_spine4" );
    }
}

// Namespace zm_moon_ai_quad
// Params 0
// Checksum 0xa44a2e4a, Offset: 0x14f8
// Size: 0x1a
function moon_quad_gas_immune()
{
    self endon( #"disconnect" );
    self endon( #"death" );
}

