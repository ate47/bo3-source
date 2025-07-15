#using scripts/codescripts/struct;
#using scripts/shared/_burnplayer;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/mechz;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_riotshield;
#using scripts/zm/_zm_zonemgr;

#namespace zm_ai_mechz_claw;

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x2
// Checksum 0x9ec616a5, Offset: 0x8a0
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_ai_mechz_claw", &__init__, &__main__, undefined );
}

// Namespace zm_ai_mechz_claw
// Params 0
// Checksum 0x31ef4976, Offset: 0x8e8
// Size: 0x18c
function __init__()
{
    function_f20c04a4();
    spawner::add_archetype_spawn_function( "mechz", &function_1aacf7d4 );
    level.mechz_claw_cooldown_time = 7000;
    level.mechz_left_arm_damage_callback = &function_671deda5;
    level.mechz_explosive_damage_reaction_callback = &function_6028875a;
    level.mechz_powercap_destroyed_callback = &function_d6f31ed2;
    level flag::init( "mechz_launching_claw" );
    level flag::init( "mechz_claw_move_complete" );
    clientfield::register( "actor", "mechz_fx", 21000, 12, "int" );
    clientfield::register( "scriptmover", "mechz_claw", 21000, 1, "int" );
    clientfield::register( "actor", "mechz_wpn_source", 21000, 1, "int" );
    clientfield::register( "toplayer", "mechz_grab", 21000, 1, "int" );
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0x99ec1590, Offset: 0xa80
// Size: 0x4
function private __main__()
{
    
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0xfbfb3fd1, Offset: 0xa90
// Size: 0x164
function private function_f20c04a4()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "zmMechzShouldShootClaw", &function_bdc90f38 );
    behaviortreenetworkutility::registerbehaviortreeaction( "zmMechzShootClawAction", &function_86ac6346, &function_a94df749, &function_1b118e5 );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "zmMechzShootClaw", &function_456e76fa );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "zmMechzUpdateClaw", &function_a844c266 );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "zmMechzStopClaw", &function_75278fab );
    animationstatenetwork::registernotetrackhandlerfunction( "muzzleflash", &function_de3abdba );
    animationstatenetwork::registernotetrackhandlerfunction( "start_ft", &function_48c03479 );
    animationstatenetwork::registernotetrackhandlerfunction( "stop_ft", &function_235008e3 );
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0x907b18c3, Offset: 0xc00
// Size: 0x2b2
function private function_bdc90f38( entity )
{
    if ( !isdefined( entity.favoriteenemy ) )
    {
        return 0;
    }
    
    if ( !( isdefined( entity.has_powercap ) && entity.has_powercap ) )
    {
        return 0;
    }
    
    if ( isdefined( entity.last_claw_time ) && gettime() - self.last_claw_time < level.mechz_claw_cooldown_time )
    {
        return 0;
    }
    
    if ( isdefined( entity.berserk ) && entity.berserk )
    {
        return 0;
    }
    
    if ( !entity mechzserverutils::mechzcheckinarc() )
    {
        return 0;
    }
    
    dist_sq = distancesquared( entity.origin, entity.favoriteenemy.origin );
    
    if ( dist_sq < 40000 || dist_sq > 1000000 )
    {
        return 0;
    }
    
    if ( !entity.favoriteenemy player_can_be_grabbed() )
    {
        return 0;
    }
    
    curr_zone = zm_zonemgr::get_zone_from_position( self.origin + ( 0, 0, 36 ) );
    
    if ( isdefined( curr_zone ) && "ug_bottom_zone" == curr_zone )
    {
        return 0;
    }
    
    clip_mask = 1 | 8;
    claw_origin = entity.origin + ( 0, 0, 65 );
    trace = physicstrace( claw_origin, entity.favoriteenemy.origin + ( 0, 0, 30 ), ( -15, -15, -20 ), ( 15, 15, 40 ), entity, clip_mask );
    b_cansee = isdefined( trace[ "entity" ] ) && ( trace[ "fraction" ] == 1 || trace[ "entity" ] == entity.favoriteenemy );
    
    if ( !b_cansee )
    {
        return 0;
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0xb0e1850e, Offset: 0xec0
// Size: 0x4e, Type: bool
function private player_can_be_grabbed()
{
    if ( self getstance() == "prone" )
    {
        return false;
    }
    
    if ( !zm_utility::is_player_valid( self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_ai_mechz_claw
// Params 2, eflags: 0x4
// Checksum 0x352735e5, Offset: 0xf18
// Size: 0x48
function private function_86ac6346( entity, asmstatename )
{
    animationstatenetworkutility::requeststate( entity, asmstatename );
    function_456e76fa( entity );
    return 5;
}

// Namespace zm_ai_mechz_claw
// Params 2, eflags: 0x4
// Checksum 0xffb16407, Offset: 0xf68
// Size: 0x44
function private function_a94df749( entity, asmstatename )
{
    if ( !( isdefined( entity.var_7bee990f ) && entity.var_7bee990f ) )
    {
        return 4;
    }
    
    return 5;
}

// Namespace zm_ai_mechz_claw
// Params 2, eflags: 0x4
// Checksum 0x9cf512ef, Offset: 0xfb8
// Size: 0x18
function private function_1b118e5( entity, asmstatename )
{
    return 4;
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0xa327e930, Offset: 0xfd8
// Size: 0x44
function private function_456e76fa( entity )
{
    self thread function_31c4b972();
    level flag::set( "mechz_launching_claw" );
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0x2ffbd5c6, Offset: 0x1028
// Size: 0xc
function private function_a844c266( entity )
{
    
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0x5b9513e3, Offset: 0x1040
// Size: 0xc
function private function_75278fab( entity )
{
    
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0x8d09aca8, Offset: 0x1058
// Size: 0x60
function private function_de3abdba( entity )
{
    self.var_7bee990f = 1;
    self.last_claw_time = gettime();
    entity function_672f9804();
    entity function_90832db7();
    self.last_claw_time = gettime();
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0x4e70c510, Offset: 0x10c0
// Size: 0x64
function private function_48c03479( entity )
{
    entity notify( #"hash_8225d137" );
    entity clientfield::set( "mechz_ft", 1 );
    entity.isshootingflame = 1;
    entity thread function_fa513ca0();
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0xc2ac5bef, Offset: 0x1130
// Size: 0x118
function private function_fa513ca0()
{
    self endon( #"death" );
    self endon( #"hash_8225d137" );
    
    while ( true )
    {
        players = getplayers();
        
        foreach ( player in players )
        {
            if ( !( isdefined( player.is_burning ) && player.is_burning ) )
            {
                if ( player istouching( self.flametrigger ) )
                {
                    player thread mechzbehavior::playerflamedamage( self );
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0xff08a825, Offset: 0x1250
// Size: 0x72
function private function_235008e3( entity )
{
    entity notify( #"hash_8225d137" );
    entity clientfield::set( "mechz_ft", 0 );
    entity.isshootingflame = 0;
    entity.nextflametime = gettime() + 7500;
    entity.stopshootingflametime = undefined;
}

#using_animtree( "mechz_claw" );

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0xd1a9ed74, Offset: 0x12d0
// Size: 0x2ec
function private function_1aacf7d4()
{
    if ( isdefined( self.m_claw ) )
    {
        self.m_claw delete();
        self.m_claw = undefined;
    }
    
    self.fx_field = 0;
    org = self gettagorigin( "tag_claw" );
    ang = self gettagangles( "tag_claw" );
    self.m_claw = spawn( "script_model", org );
    self.m_claw setmodel( "c_t7_zm_dlchd_origins_mech_claw" );
    self.m_claw.angles = ang;
    self.m_claw linkto( self, "tag_claw" );
    self.m_claw useanimtree( #animtree );
    
    if ( isdefined( self.m_claw_damage_trigger ) )
    {
        self.m_claw_damage_trigger unlink();
        self.m_claw_damage_trigger delete();
        self.m_claw_damage_trigger = undefined;
    }
    
    trigger_spawnflags = 0;
    trigger_radius = 3;
    trigger_height = 15;
    self.m_claw_damage_trigger = spawn( "script_model", org );
    self.m_claw_damage_trigger setmodel( "p7_chemistry_kit_large_bottle" );
    ang = combineangles( ( -90, 0, 0 ), ang );
    self.m_claw_damage_trigger.angles = ang;
    self.m_claw_damage_trigger hide();
    self.m_claw_damage_trigger setcandamage( 1 );
    self.m_claw_damage_trigger.health = 10000;
    self.m_claw_damage_trigger enablelinkto();
    self.m_claw_damage_trigger linkto( self, "tag_claw" );
    self thread function_5dfc412a();
    self hidepart( "tag_claw" );
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0x34e549ba, Offset: 0x15c8
// Size: 0x166
function private function_5dfc412a()
{
    self endon( #"death" );
    self.m_claw_damage_trigger endon( #"death" );
    
    while ( true )
    {
        self.m_claw_damage_trigger waittill( #"damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weaponname, idflags );
        self.m_claw_damage_trigger.health = 10000;
        
        if ( self.m_claw islinkedto( self ) )
        {
            continue;
        }
        
        if ( zm_utility::is_player_valid( inflictor ) )
        {
            self dodamage( 1, inflictor.origin, inflictor, inflictor, "left_hand", type );
            self.m_claw setcandamage( 0 );
            self notify( #"claw_damaged" );
        }
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0x4ab73000, Offset: 0x1738
// Size: 0x4c
function private function_31c4b972()
{
    self endon( #"claw_complete" );
    self util::waittill_either( "death", "kill_claw" );
    self function_90832db7();
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0x3488fb5d, Offset: 0x1790
// Size: 0x3c4
function private function_90832db7()
{
    self.fx_field &= ~256;
    self.fx_field &= ~64;
    self clientfield::set( "mechz_fx", self.fx_field );
    self function_9bfd96c8();
    
    if ( isdefined( self.m_claw ) )
    {
        self.m_claw clearanim( %root, 0.2 );
        
        if ( isdefined( self.m_claw.fx_ent ) )
        {
            self.m_claw.fx_ent delete();
            self.m_claw.fx_ent = undefined;
        }
        
        if ( !( isdefined( self.has_powercap ) && self.has_powercap ) )
        {
            self function_4208b4ec();
            level flag::clear( "mechz_launching_claw" );
        }
        else
        {
            if ( !self.m_claw islinkedto( self ) )
            {
                v_claw_origin = self gettagorigin( "tag_claw" );
                v_claw_angles = self gettagangles( "tag_claw" );
                n_dist = distance( self.m_claw.origin, v_claw_origin );
                n_time = n_dist / 1000;
                self.m_claw moveto( v_claw_origin, max( 0.05, n_time ) );
                self.m_claw playloopsound( "zmb_ai_mechz_claw_loop_in", 0.1 );
                self.m_claw waittill( #"movedone" );
                v_claw_origin = self gettagorigin( "tag_claw" );
                v_claw_angles = self gettagangles( "tag_claw" );
                self.m_claw playsound( "zmb_ai_mechz_claw_back" );
                self.m_claw stoploopsound( 1 );
                self.m_claw.origin = v_claw_origin;
                self.m_claw.angles = v_claw_angles;
                self.m_claw clearanim( %root, 0.2 );
                self.m_claw linkto( self, "tag_claw", ( 0, 0, 0 ) );
            }
            
            self.m_claw setanim( %ai_zombie_mech_grapple_arm_closed_idle, 1, 0.2, 1 );
        }
    }
    
    self notify( #"claw_complete" );
    self.var_7bee990f = 0;
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0xc95b0cc8, Offset: 0x1b60
// Size: 0x136
function private function_4208b4ec()
{
    if ( isdefined( self.m_claw ) )
    {
        self.m_claw setanim( %ai_zombie_mech_grapple_arm_open_idle, 1, 0.2, 1 );
        
        if ( isdefined( self.m_claw.fx_ent ) )
        {
            self.m_claw.fx_ent delete();
        }
        
        self.m_claw unlink();
        self.m_claw physicslaunch( self.m_claw.origin, ( 0, 0, -1 ) );
        self.m_claw thread function_36db86b();
        self.m_claw = undefined;
    }
    
    if ( isdefined( self.m_claw_damage_trigger ) )
    {
        self.m_claw_damage_trigger unlink();
        self.m_claw_damage_trigger delete();
        self.m_claw_damage_trigger = undefined;
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0x170a4a0c, Offset: 0x1ca0
// Size: 0x1c
function private function_36db86b()
{
    wait 30;
    self delete();
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0x3726cb94, Offset: 0x1cc8
// Size: 0x1dc
function private function_9bfd96c8( bopenclaw )
{
    self.explosive_dmg_taken_on_grab_start = undefined;
    
    if ( isdefined( self.e_grabbed ) )
    {
        if ( isplayer( self.e_grabbed ) )
        {
            self.e_grabbed clientfield::set_to_player( "mechz_grab", 0 );
            self.e_grabbed allowcrouch( 1 );
            self.e_grabbed allowprone( 1 );
        }
        
        if ( !isdefined( self.e_grabbed._fall_down_anchor ) )
        {
            trace_start = self.e_grabbed.origin + ( 0, 0, 70 );
            trace_end = self.e_grabbed.origin + ( 0, 0, -500 );
            drop_trace = playerphysicstrace( trace_start, trace_end ) + ( 0, 0, 24 );
            self.e_grabbed unlink();
            self.e_grabbed setorigin( drop_trace );
        }
        
        self.e_grabbed = undefined;
        
        if ( isdefined( bopenclaw ) && bopenclaw )
        {
            self.m_claw setanim( %ai_zombie_mech_grapple_arm_open_idle, 1, 0.2, 1 );
        }
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0x821df5f5, Offset: 0x1eb0
// Size: 0x2c
function private function_7c33f4fb()
{
    if ( !isdefined( self.explosive_dmg_taken ) )
    {
        self.explosive_dmg_taken = 0;
    }
    
    self.explosive_dmg_taken_on_grab_start = self.explosive_dmg_taken;
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0x941d14bb, Offset: 0x1ee8
// Size: 0x3c
function private function_d6f31ed2()
{
    self mechzserverutils::hide_part( "tag_claw" );
    self.m_claw hide();
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0xa7799255, Offset: 0x1f30
// Size: 0xac
function private function_5f5eaf3a( ai_mechz )
{
    self endon( #"disconnect" );
    self zm_audio::create_and_play_dialog( "general", "mech_grab" );
    
    while ( isdefined( self.isspeaking ) && isdefined( self ) && self.isspeaking )
    {
        wait 0.1;
    }
    
    wait 1;
    
    if ( isalive( ai_mechz ) && isdefined( ai_mechz.e_grabbed ) )
    {
        ai_mechz thread play_shoot_arm_hint_vo();
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0xba759057, Offset: 0x1fe8
// Size: 0x188
function private play_shoot_arm_hint_vo()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( self.e_grabbed ) )
        {
            return;
        }
        
        a_players = getplayers();
        
        foreach ( player in a_players )
        {
            if ( player == self.e_grabbed )
            {
                continue;
            }
            
            if ( distancesquared( self.origin, player.origin ) < 1000000 )
            {
                if ( player util::is_player_looking_at( self.origin + ( 0, 0, 60 ), 0.75 ) )
                {
                    if ( !( isdefined( player.dontspeak ) && player.dontspeak ) )
                    {
                        player zm_audio::create_and_play_dialog( "general", "shoot_mech_arm" );
                        return;
                    }
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0x75701f2f, Offset: 0x2178
// Size: 0x2c
function private function_671deda5()
{
    if ( isdefined( self.e_grabbed ) )
    {
        self thread function_9bfd96c8( 1 );
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0x34b66ba7, Offset: 0x21b0
// Size: 0x5c
function private function_6028875a()
{
    if ( isdefined( self.explosive_dmg_taken_on_grab_start ) )
    {
        if ( isdefined( self.e_grabbed ) && self.explosive_dmg_taken - self.explosive_dmg_taken_on_grab_start > self.mechz_explosive_dmg_to_cancel_claw )
        {
            self.show_pain_from_explosive_dmg = 1;
            self thread function_9bfd96c8();
        }
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0x169f6e1e, Offset: 0x2218
// Size: 0x94
function private function_8b0a73b5( mechz )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    mechz endon( #"death" );
    mechz endon( #"claw_complete" );
    mechz endon( #"kill_claw" );
    
    while ( true )
    {
        if ( isdefined( self ) && self laststand::player_is_in_laststand() )
        {
            mechz thread function_9bfd96c8();
            return;
        }
        
        wait 0.05;
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0xe32c1eff, Offset: 0x22b8
// Size: 0x92
function private function_bed84b4( mechz )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    mechz endon( #"death" );
    mechz endon( #"claw_complete" );
    mechz endon( #"kill_claw" );
    
    while ( true )
    {
        self waittill( #"bgb_activation_request" );
        
        if ( isdefined( self ) && self.bgb === "zm_bgb_anywhere_but_here" )
        {
            mechz thread function_9bfd96c8();
            return;
        }
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0xf69e84ff, Offset: 0x2358
// Size: 0x7a
function private function_38d105a4( mechz )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    mechz endon( #"death" );
    mechz endon( #"claw_complete" );
    mechz endon( #"kill_claw" );
    
    while ( true )
    {
        self waittill( #"hash_e2be4752" );
        mechz thread function_9bfd96c8();
        return;
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0xf302a04c, Offset: 0x23e0
// Size: 0xe4c
function private function_672f9804()
{
    self endon( #"death" );
    self endon( #"kill_claw" );
    
    if ( !isdefined( self.favoriteenemy ) )
    {
        return;
    }
    
    v_claw_origin = self gettagorigin( "tag_claw" );
    v_claw_angles = vectortoangles( self.origin - self.favoriteenemy.origin );
    self.fx_field |= 256;
    self clientfield::set( "mechz_fx", self.fx_field );
    self.m_claw setanim( %ai_zombie_mech_grapple_arm_open_idle, 1, 0, 1 );
    self.m_claw unlink();
    self.m_claw.fx_ent = spawn( "script_model", self.m_claw gettagorigin( "tag_claw" ) );
    self.m_claw.fx_ent.angles = self.m_claw gettagangles( "tag_claw" );
    self.m_claw.fx_ent setmodel( "tag_origin" );
    self.m_claw.fx_ent linkto( self.m_claw, "tag_claw" );
    self.m_claw.fx_ent clientfield::set( "mechz_claw", 1 );
    self clientfield::set( "mechz_wpn_source", 1 );
    v_enemy_origin = self.favoriteenemy.origin + ( 0, 0, 36 );
    n_dist = distance( v_claw_origin, v_enemy_origin );
    n_time = n_dist / 1200;
    self playsound( "zmb_ai_mechz_claw_fire" );
    self.m_claw moveto( v_enemy_origin, n_time );
    self.m_claw thread function_2998f2a1();
    self.m_claw playloopsound( "zmb_ai_mechz_claw_loop_out", 0.1 );
    self.e_grabbed = undefined;
    
    do
    {
        a_players = getplayers();
        
        foreach ( player in a_players )
        {
            if ( !zm_utility::is_player_valid( player, 1, 1 ) || !player player_can_be_grabbed() )
            {
                continue;
            }
            
            n_dist_sq = distancesquared( player.origin + ( 0, 0, 36 ), self.m_claw.origin );
            
            if ( n_dist_sq < 2304 )
            {
                clip_mask = 1 | 8;
                var_7d76644b = self.origin + ( 0, 0, 65 );
                trace = physicstrace( var_7d76644b, player.origin + ( 0, 0, 30 ), ( -15, -15, -20 ), ( 15, 15, 40 ), self, clip_mask );
                b_cansee = isdefined( trace[ "entity" ] ) && ( trace[ "fraction" ] == 1 || trace[ "entity" ] == player );
                
                if ( !b_cansee )
                {
                    continue;
                }
                
                if ( isdefined( player.hasriotshieldequipped ) && isdefined( player.hasriotshield ) && player.hasriotshield && player.hasriotshieldequipped )
                {
                    shield_dmg = level.zombie_vars[ "riotshield_hit_points" ];
                    player riotshield::player_damage_shield( shield_dmg - 1, 1 );
                    wait 1;
                    player riotshield::player_damage_shield( 1, 1 );
                }
                else
                {
                    self.e_grabbed = player;
                    self.e_grabbed clientfield::set_to_player( "mechz_grab", 1 );
                    self.e_grabbed playerlinktodelta( self.m_claw, "tag_attach_player" );
                    self.e_grabbed setplayerangles( vectortoangles( self.origin - self.e_grabbed.origin ) );
                    self.e_grabbed playsound( "zmb_ai_mechz_claw_grab" );
                    self.e_grabbed setstance( "stand" );
                    self.e_grabbed allowcrouch( 0 );
                    self.e_grabbed allowprone( 0 );
                    self.e_grabbed thread function_5f5eaf3a( self );
                    self.e_grabbed thread function_bed84b4( self );
                    self.e_grabbed thread function_38d105a4( self );
                    
                    if ( !level flag::get( "mechz_claw_move_complete" ) )
                    {
                        self.m_claw moveto( self.m_claw.origin, 0.05 );
                    }
                }
                
                break;
            }
        }
        
        wait 0.05;
    }
    while ( !level flag::get( "mechz_claw_move_complete" ) && !isdefined( self.e_grabbed ) );
    
    if ( !isdefined( self.e_grabbed ) )
    {
        a_ai_zombies = zombie_utility::get_round_enemy_array();
        
        foreach ( ai_zombie in a_ai_zombies )
        {
            if ( isdefined( ai_zombie.is_mechz ) && ( isdefined( ai_zombie.is_giant_robot ) && ( !isalive( ai_zombie ) || ai_zombie.is_giant_robot ) || ai_zombie.is_mechz ) )
            {
                continue;
            }
            
            n_dist_sq = distancesquared( ai_zombie.origin + ( 0, 0, 36 ), self.m_claw.origin );
            
            if ( n_dist_sq < 2304 )
            {
                self.e_grabbed = ai_zombie;
                self.e_grabbed linkto( self.m_claw, "tag_attach_player", ( 0, 0, 0 ) );
                self.e_grabbed.mechz_grabbed_by = self;
                break;
            }
        }
    }
    
    self.m_claw clearanim( %root, 0.2 );
    self.m_claw setanim( %ai_zombie_mech_grapple_arm_closed_idle, 1, 0.2, 1 );
    wait 0.5;
    
    if ( isdefined( self.e_grabbed ) )
    {
        n_time = n_dist / 200;
    }
    else
    {
        n_time = n_dist / 1000;
    }
    
    self function_7c33f4fb();
    v_claw_origin = self gettagorigin( "tag_claw" );
    v_claw_angles = self gettagangles( "tag_claw" );
    self.m_claw moveto( v_claw_origin, max( 0.05, n_time ) );
    self.m_claw playloopsound( "zmb_ai_mechz_claw_loop_in", 0.1 );
    self.m_claw waittill( #"movedone" );
    v_claw_origin = self gettagorigin( "tag_claw" );
    v_claw_angles = self gettagangles( "tag_claw" );
    self.m_claw playsound( "zmb_ai_mechz_claw_back" );
    self.m_claw stoploopsound( 1 );
    
    if ( zm_audio::sndisnetworksafe() )
    {
        self playsound( "zmb_ai_mechz_vox_angry" );
    }
    
    self.m_claw.origin = v_claw_origin;
    self.m_claw.angles = v_claw_angles;
    self.m_claw clearanim( %root, 0.2 );
    self.m_claw linkto( self, "tag_claw", ( 0, 0, 0 ) );
    self.m_claw setanim( %ai_zombie_mech_grapple_arm_closed_idle, 1, 0.2, 1 );
    self.m_claw.fx_ent delete();
    self.m_claw.fx_ent = undefined;
    self.fx_field &= ~256;
    self clientfield::set( "mechz_fx", self.fx_field );
    self clientfield::set( "mechz_wpn_source", 0 );
    level flag::clear( "mechz_launching_claw" );
    
    if ( isdefined( self.e_grabbed ) )
    {
        if ( isplayer( self.e_grabbed ) && zm_utility::is_player_valid( self.e_grabbed ) )
        {
            self.e_grabbed thread function_8b0a73b5( self );
        }
        else if ( isai( self.e_grabbed ) )
        {
            self.e_grabbed thread function_860f0461( self );
        }
        
        self thread function_eb9df173( self.e_grabbed );
        self animscripted( "flamethrower_anim", self.origin, self.angles, "ai_zombie_mech_ft_burn_player" );
        self zombie_shared::donotetracks( "flamethrower_anim" );
    }
    
    level flag::clear( "mechz_claw_move_complete" );
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0x96078390, Offset: 0x3238
// Size: 0x1aa
function private function_eb9df173( player )
{
    player endon( #"death" );
    player endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"claw_complete" );
    self endon( #"kill_claw" );
    self thread function_7792d05e( player );
    player thread function_d0e280a0( self );
    self.m_claw setcandamage( 1 );
    
    while ( isdefined( self.e_grabbed ) )
    {
        self.m_claw waittill( #"damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weaponname, idflags );
        
        if ( zm_utility::is_player_valid( inflictor ) )
        {
            self dodamage( 1, inflictor.origin, inflictor, inflictor, "left_hand", type );
            self.m_claw setcandamage( 0 );
            self notify( #"claw_damaged" );
            break;
        }
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0xd27c5750, Offset: 0x33f0
// Size: 0x8c
function private function_7792d05e( player )
{
    self endon( #"claw_damaged" );
    player endon( #"death" );
    player endon( #"disconnect" );
    self util::waittill_any( "death", "claw_complete", "kill_claw" );
    
    if ( isdefined( self ) && isdefined( self.m_claw ) )
    {
        self.m_claw setcandamage( 0 );
    }
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0xbb4ac903, Offset: 0x3488
// Size: 0xa4
function private function_d0e280a0( mechz )
{
    mechz endon( #"claw_damaged" );
    mechz endon( #"death" );
    mechz endon( #"claw_complete" );
    mechz endon( #"kill_claw" );
    self util::waittill_any( "death", "disconnect" );
    
    if ( isdefined( mechz ) && isdefined( mechz.m_claw ) )
    {
        mechz.m_claw setcandamage( 0 );
    }
}

// Namespace zm_ai_mechz_claw
// Params 0, eflags: 0x4
// Checksum 0x7fdf7c4b, Offset: 0x3538
// Size: 0x34
function private function_2998f2a1()
{
    self waittill( #"movedone" );
    wait 0.05;
    level flag::set( "mechz_claw_move_complete" );
}

// Namespace zm_ai_mechz_claw
// Params 1, eflags: 0x4
// Checksum 0xb7441423, Offset: 0x3578
// Size: 0x94
function private function_860f0461( mechz )
{
    mechz waittillmatch( #"flamethrower_anim", "start_ft" );
    
    if ( isalive( self ) )
    {
        self dodamage( self.health, self.origin, self );
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate( self );
    }
}

