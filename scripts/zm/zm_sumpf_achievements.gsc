#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;

#namespace zm_prototype_achievements;

// Namespace zm_prototype_achievements
// Params 0, eflags: 0x2
// Checksum 0x59b7336a, Offset: 0x270
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_theater_achievements", &__init__, undefined, undefined );
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0xb19a3f5c, Offset: 0x2b0
// Size: 0x5c
function __init__()
{
    level.achievement_sound_func = &achievement_sound_func;
    zm_spawner::register_zombie_death_event_callback( &function_1abfde35 );
    callback::on_connect( &onplayerconnect );
}

// Namespace zm_prototype_achievements
// Params 1
// Checksum 0x2747d07e, Offset: 0x318
// Size: 0xac
function achievement_sound_func( achievement_name_lower )
{
    self endon( #"disconnect" );
    
    if ( !sessionmodeisonlinegame() )
    {
        return;
    }
    
    for ( i = 0; i < self getentitynumber() + 1 ; i++ )
    {
        util::wait_network_frame();
    }
    
    self thread zm_utility::do_player_general_vox( "general", "achievement" );
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0x5af04496, Offset: 0x3d0
// Size: 0xac
function onplayerconnect()
{
    self thread function_2eb61ef5();
    self thread function_94fa04f0();
    self thread function_a634891();
    self thread function_2a1b645a();
    self thread function_b44fefa1();
    self thread function_25062f55();
    self thread function_32909149();
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0xcbca027d, Offset: 0x488
// Size: 0x84
function function_2eb61ef5()
{
    level endon( #"end_game" );
    self endon( #"i_am_down" );
    self endon( #"disconnect" );
    
    while ( isdefined( self ) )
    {
        if ( isdefined( level.round_number ) && level.round_number == 5 )
        {
            /#
                self iprintln( "<dev string:x28>" );
            #/
            
            return;
        }
        
        wait 0.5;
    }
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0x4dbb7beb, Offset: 0x518
// Size: 0x7a
function function_94fa04f0()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"nuke_triggered" );
        wait 2;
        
        if ( isdefined( self.zombie_nuked ) && self.zombie_nuked.size == 1 )
        {
            /#
                self iprintln( "<dev string:x4b>" );
            #/
            
            return;
        }
    }
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0x3e06af20, Offset: 0x5a0
// Size: 0x7a
function function_a634891()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self.var_88c6ab10 = 0;
    
    while ( self.var_88c6ab10 < 10 )
    {
        self thread function_47ae7759();
        self function_a2ee1b6c();
    }
    
    self notify( #"hash_949655c9" );
    
    /#
    #/
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0x6079b6bd, Offset: 0x628
// Size: 0x50
function function_a2ee1b6c()
{
    level endon( #"end_game" );
    level endon( #"end_of_round" );
    self endon( #"disconnect" );
    
    while ( self.var_88c6ab10 < 10 )
    {
        self waittill( #"hash_7a5eece4" );
        self.var_88c6ab10++;
    }
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0x2777e7f6, Offset: 0x680
// Size: 0x40
function function_47ae7759()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self endon( #"hash_949655c9" );
    level waittill( #"end_of_round" );
    self.var_88c6ab10 = 0;
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0xdd401f07, Offset: 0x6c8
// Size: 0x74
function function_2a1b645a()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( self.score_total >= 75000 )
        {
            /#
                self iprintln( "<dev string:x7c>" );
            #/
            
            return;
        }
        
        wait 0.5;
    }
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0xb6b9e5ad, Offset: 0x748
// Size: 0x74
function function_b44fefa1()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( isdefined( self.perk_hud ) && self.perk_hud.size == 4 )
        {
            /#
                self iprintln( "<dev string:x9c>" );
            #/
            
            return;
        }
        
        wait 0.5;
    }
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0xcc8c113d, Offset: 0x7c8
// Size: 0x7e
function function_f67810a2()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self.var_dcd9b1e7 = 0;
    
    while ( self.var_dcd9b1e7 >= 200 )
    {
        self waittill( #"hash_1d8b6c31" );
        self.var_dcd9b1e7++;
    }
    
    /#
        self iprintln( "<dev string:xbe>" );
    #/
    
    self.var_dcd9b1e7 = undefined;
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0xc9aecdaa, Offset: 0x850
// Size: 0x76
function function_25062f55()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    self.var_498c9df8 = 0;
    
    if ( self.var_498c9df8 >= 150 )
    {
        self waittill( #"hash_cae861a8" );
    }
    
    /#
        self iprintln( "<dev string:xe2>" );
    #/
    
    self.var_498c9df8 = undefined;
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0x59dfc8b4, Offset: 0x8d0
// Size: 0x8a
function function_32909149()
{
    level endon( #"end_game" );
    self endon( #"disconnect" );
    
    do
    {
        self function_f8c272e8();
    }
    while ( self.var_59179d2c.size < 3 );
    
    /#
        self iprintln( "<dev string:x100>" );
    #/
    
    self zm_utility::giveachievement_wrapper( "DLC2_ZOMBIE_ALL_TRAPS", 0 );
    self notify( #"hash_ea373971" );
}

// Namespace zm_prototype_achievements
// Params 0
// Checksum 0x57cfa358, Offset: 0x968
// Size: 0x62
function function_f8c272e8()
{
    level endon( #"end_game" );
    level endon( #"end_of_round" );
    self endon( #"disconnect" );
    self endon( #"hash_ea373971" );
    self.var_59179d2c = [];
    
    do
    {
        self waittill( #"hash_f0c3517c" );
    }
    while ( isdefined( self ) && self.var_59179d2c.size < 3 );
}

// Namespace zm_prototype_achievements
// Params 1
// Checksum 0x520290a2, Offset: 0x9d8
// Size: 0x2dc
function function_1abfde35( e_attacker )
{
    if ( !isdefined( e_attacker ) )
    {
        return;
    }
    
    if ( isdefined( self.var_9a9a0f55 ) && isdefined( self.var_aa99de67 ) && isplayer( self.var_aa99de67 ) )
    {
        e_player = self.var_aa99de67;
        
        if ( !( isdefined( isinarray( e_player.var_59179d2c, e_attacker ) ) && isinarray( e_player.var_59179d2c, e_attacker ) ) )
        {
            array::add( e_player.var_59179d2c, e_attacker );
            e_player notify( #"hash_f0c3517c" );
            return;
        }
    }
    
    if ( isdefined( e_attacker.activated_by_player ) && e_attacker.targetname === "zombie_trap" )
    {
        e_player = e_attacker.activated_by_player;
        
        if ( !( isdefined( isinarray( e_player.var_59179d2c, e_attacker ) ) && isinarray( e_player.var_59179d2c, e_attacker ) ) )
        {
            array::add( e_player.var_59179d2c, e_attacker );
            e_player notify( #"hash_f0c3517c" );
            return;
        }
    }
    
    if ( !isplayer( e_attacker ) )
    {
        return;
    }
    
    if ( self.damagemod === "MOD_MELEE" && e_attacker zm_powerups::is_insta_kill_active() )
    {
        e_attacker notify( #"hash_7a5eece4" );
        return;
    }
    
    if ( isdefined( self.var_dcd9b1e7 ) )
    {
        e_attacker notify( #"hash_1d8b6c31" );
        return;
    }
    
    if ( isdefined( e_attacker.var_498c9df8 ) && self.archetype === "zombie" && isdefined( self.damageweapon ) && isdefined( self.damagelocation ) && isdefined( self.damagemod ) )
    {
        if ( isdefined( zm_utility::is_headshot( self.damageweapon, self.damagelocation, self.damagemod ) ) && zm_utility::is_headshot( self.damageweapon, self.damagelocation, self.damagemod ) )
        {
            e_attacker notify( #"hash_cae861a8" );
        }
    }
}

