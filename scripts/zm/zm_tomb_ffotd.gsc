#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;

#namespace zm_tomb_ffotd;

// Namespace zm_tomb_ffotd
// Params 0
// Checksum 0xc534ac31, Offset: 0x288
// Size: 0x5c
function main_start()
{
    level.added_initial_streamer_blackscreen = 2;
    level thread spawned_collision_ffotd();
    level thread function_3fd88dcb();
    level.var_361ee139 = &function_acf1c4da;
}

// Namespace zm_tomb_ffotd
// Params 0
// Checksum 0xb037e1, Offset: 0x2f0
// Size: 0x2c8
function main_end()
{
    spawncollision( "collision_player_256x256x256", "collider", ( 11200, -6722, -132 ), ( 0, 0, 0 ) );
    spawncollision( "collision_player_wall_256x256x10", "collider", ( -339.75, 83, 448 ), ( 0, 0, 0 ) );
    spawncollision( "collision_player_cylinder_32x256", "collider", ( 167, 404, 442 ), ( 0, 0, 0 ) );
    spawncollision( "collision_player_wall_256x256x10", "collider", ( 55, 391, 450 ), ( 0, 270, 0 ) );
    spawncollision( "collision_player_wall_256x256x10", "collider", ( 70.75, -379, 555 ), ( 0, 270, 0 ) );
    spawncollision( "collision_player_wall_256x256x10", "collider", ( -130.25, -356.5, 545.25 ), ( 0, 180, 0 ) );
    spawncollision( "collision_player_wedge_32x256", "collider", ( 2196.91, -634.245, 224 ), ( 0, 289.698, 0 ) );
    level.var_144b78ee = spawncollision( "collision_player_wedge_32x256", "collider", ( -2148.74, 571, 237.5 ), ( 0, 7.6, 0 ) );
    t_killbrush_1 = spawn( "trigger_box", ( 54.5, -372.5, 130.5 ), 0, 350, 100, 250 );
    t_killbrush_1.angles = ( 0, 0, 0 );
    t_killbrush_1.script_noteworthy = "kill_brush";
    t_killbrush_2 = spawn( "trigger_box", ( 83, 387, 130.5 ), 0, 300, 100, 250 );
    t_killbrush_2.angles = ( 0, 0, 0 );
    t_killbrush_2.script_noteworthy = "kill_brush";
}

// Namespace zm_tomb_ffotd
// Params 0
// Checksum 0xe185e6d1, Offset: 0x5c0
// Size: 0x6c
function function_3fd88dcb()
{
    level flagsys::wait_till( "start_zombie_round_logic" );
    level flag::wait_till( "activate_zone_farm" );
    
    if ( isdefined( level.var_144b78ee ) )
    {
        level.var_144b78ee delete();
    }
}

// Namespace zm_tomb_ffotd
// Params 0
// Checksum 0xec082254, Offset: 0x638
// Size: 0x3a
function spawned_collision_ffotd()
{
    level flagsys::wait_till( "start_zombie_round_logic" );
    
    if ( isdefined( level.optimise_for_splitscreen ) && level.optimise_for_splitscreen )
    {
    }
}

// Namespace zm_tomb_ffotd
// Params 1
// Checksum 0xa526d938, Offset: 0x680
// Size: 0xec
function function_acf1c4da( machine )
{
    if ( isdefined( level.bgb[ machine.selected_bgb ] ) && level.bgb[ machine.selected_bgb ].limit_type == "activated" )
    {
        if ( self.characterindex == 0 )
        {
            self zm_audio::create_and_play_dialog( "bgb", "buy", self function_af29034() );
            return;
        }
        
        self zm_audio::create_and_play_dialog( "bgb", "buy" );
        return;
    }
    
    self zm_audio::create_and_play_dialog( "bgb", "eat" );
}

// Namespace zm_tomb_ffotd
// Params 0
// Checksum 0xa658742c, Offset: 0x778
// Size: 0xb0
function function_af29034()
{
    if ( !isdefined( self.var_52b965ea ) || self.var_52b965ea.size <= 0 )
    {
        self.var_52b965ea = array( 0, 1, 2, 3 );
        self.var_52b965ea = array::randomize( self.var_52b965ea );
    }
    
    var_1b07cebe = self.var_52b965ea[ 0 ];
    self.var_52b965ea = array::remove_index( self.var_52b965ea, 0 );
    return var_1b07cebe;
}

