#using scripts/shared/ai/archetype_mannequin;
#using scripts/shared/ai_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;

#namespace nuketownmannequin;

// Namespace nuketownmannequin
// Params 5
// Checksum 0xf253a467, Offset: 0x188
// Size: 0x470
function spawnmannequin( origin, angles, gender, speed, weepingangel )
{
    if ( !isdefined( gender ) )
    {
        gender = "male";
    }
    
    if ( !isdefined( speed ) )
    {
        speed = undefined;
    }
    
    if ( !isdefined( level.mannequinspawn_music ) )
    {
        level.mannequinspawn_music = 1;
        music::setmusicstate( "mann" );
    }
    
    if ( gender == "male" )
    {
        mannequin = spawnactor( "spawner_bo3_mannequin_male", origin, angles, "", 1, 1 );
    }
    else
    {
        mannequin = spawnactor( "spawner_bo3_mannequin_female", origin, angles, "", 1, 1 );
    }
    
    rand = randomint( 100 );
    
    if ( rand <= 35 )
    {
        mannequin.zombie_move_speed = "walk";
    }
    else if ( rand <= 70 )
    {
        mannequin.zombie_move_speed = "run";
    }
    else
    {
        mannequin.zombie_move_speed = "sprint";
    }
    
    if ( isdefined( speed ) )
    {
        mannequin.zombie_move_speed = speed;
    }
    
    if ( isdefined( level.zm_variant_type_max ) )
    {
        mannequin.variant_type = randomintrange( 1, level.zm_variant_type_max[ mannequin.zombie_move_speed ][ mannequin.zombie_arms_position ] );
    }
    
    mannequin ai::set_behavior_attribute( "can_juke", 1 );
    mannequin asmsetanimationrate( randomfloatrange( 0.98, 1.02 ) );
    mannequin.holdfire = 1;
    mannequin.canstumble = 1;
    mannequin.should_turn = 1;
    mannequin thread watch_game_ended();
    mannequin.team = "free";
    mannequin.overrideactordamage = &mannequindamage;
    mannequins = getaiarchetypearray( "mannequin" );
    
    foreach ( othermannequin in mannequins )
    {
        if ( othermannequin.archetype == "mannequin" )
        {
            othermannequin setignoreent( mannequin, 1 );
            mannequin setignoreent( othermannequin, 1 );
        }
    }
    
    if ( weepingangel )
    {
        mannequin thread _mannequin_unfreeze_ragdoll();
        mannequin.is_looking_at_me = 1;
        mannequin.was_looking_at_me = 0;
        mannequin _mannequin_update_freeze( mannequin.is_looking_at_me );
    }
    
    playfx( "dlc0/nuketown/fx_de_rez_man_spawn", mannequin.origin, anglestoforward( mannequin.angles ) );
    return mannequin;
}

// Namespace nuketownmannequin
// Params 12
// Checksum 0x17f917da, Offset: 0x600
// Size: 0xa8
function mannequindamage( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex )
{
    if ( isdefined( inflictor ) && isactor( inflictor ) && inflictor.archetype == "mannequin" )
    {
        return 0;
    }
    
    return damage;
}

// Namespace nuketownmannequin
// Params 0, eflags: 0x4
// Checksum 0x980bd82b, Offset: 0x6b0
// Size: 0x54
function private watch_game_ended()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    self setentitypaused( 1 );
    level waittill( #"endgame_sequence" );
    self hide();
}

// Namespace nuketownmannequin
// Params 0, eflags: 0x4
// Checksum 0x7022e4b, Offset: 0x710
// Size: 0x5c
function private _mannequin_unfreeze_ragdoll()
{
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self setentitypaused( 0 );
        
        if ( !self isragdoll() )
        {
            self startragdoll();
        }
    }
}

// Namespace nuketownmannequin
// Params 1, eflags: 0x4
// Checksum 0x32ca7607, Offset: 0x778
// Size: 0x8c
function private _mannequin_update_freeze( frozen )
{
    self.is_looking_at_me = frozen;
    
    if ( self.is_looking_at_me && !self.was_looking_at_me )
    {
        self setentitypaused( 1 );
    }
    else if ( !self.is_looking_at_me && self.was_looking_at_me )
    {
        self setentitypaused( 0 );
    }
    
    self.was_looking_at_me = self.is_looking_at_me;
}

// Namespace nuketownmannequin
// Params 0
// Checksum 0xbd474627, Offset: 0x810
// Size: 0x2a0
function watch_player_looking()
{
    level endon( #"game_ended" );
    level endon( #"mannequin_force_cleanup" );
    
    while ( true )
    {
        mannequins = getaiarchetypearray( "mannequin" );
        
        foreach ( mannequin in mannequins )
        {
            mannequin.can_player_see_me = 1;
        }
        
        players = getplayers();
        unseenmannequins = mannequins;
        
        foreach ( player in players )
        {
            unseenmannequins = player cantseeentities( unseenmannequins, 0.67, 0 );
        }
        
        foreach ( mannequin in unseenmannequins )
        {
            mannequin.can_player_see_me = 0;
        }
        
        foreach ( mannequin in mannequins )
        {
            mannequin _mannequin_update_freeze( mannequin.can_player_see_me );
        }
        
        wait 0.05;
    }
}

