#using scripts/codescripts/struct;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/init;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai/systems/weaponlist;
#using scripts/shared/array_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;

#namespace ai;

// Namespace ai
// Params 1
// Checksum 0xb59fc317, Offset: 0x3f0
// Size: 0x48
function set_ignoreme( val )
{
    assert( issentient( self ), "<dev string:x28>" );
    self.ignoreme = val;
}

// Namespace ai
// Params 1
// Checksum 0x3a6658f7, Offset: 0x440
// Size: 0x48
function set_ignoreall( val )
{
    assert( issentient( self ), "<dev string:x45>" );
    self.ignoreall = val;
}

// Namespace ai
// Params 1
// Checksum 0x27a29b78, Offset: 0x490
// Size: 0x48
function set_pacifist( val )
{
    assert( issentient( self ), "<dev string:x63>" );
    self.pacifist = val;
}

// Namespace ai
// Params 0
// Checksum 0xa458b23a, Offset: 0x4e0
// Size: 0x40
function disable_pain()
{
    assert( isalive( self ), "<dev string:x80>" );
    self.allowpain = 0;
}

// Namespace ai
// Params 0
// Checksum 0x55d9eaf7, Offset: 0x528
// Size: 0x40
function enable_pain()
{
    assert( isalive( self ), "<dev string:xa2>" );
    self.allowpain = 1;
}

// Namespace ai
// Params 0
// Checksum 0xe1849af1, Offset: 0x570
// Size: 0x38
function gun_remove()
{
    self shared::placeweaponon( self.weapon, "none" );
    self.gun_removed = 1;
}

// Namespace ai
// Params 2
// Checksum 0xa28c8fb1, Offset: 0x5b0
// Size: 0x34
function gun_switchto( weapon, whichhand )
{
    self shared::placeweaponon( weapon, whichhand );
}

// Namespace ai
// Params 0
// Checksum 0x1d87aee2, Offset: 0x5f0
// Size: 0x36
function gun_recall()
{
    self shared::placeweaponon( self.primaryweapon, "right" );
    self.gun_removed = undefined;
}

// Namespace ai
// Params 2
// Checksum 0xdfe647d, Offset: 0x630
// Size: 0x7c
function set_behavior_attribute( attribute, value )
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        if ( has_behavior_attribute( attribute ) )
        {
            setaiattribute( self, attribute, value );
        }
        
        return;
    }
    
    setaiattribute( self, attribute, value );
}

// Namespace ai
// Params 1
// Checksum 0x68741a61, Offset: 0x6b8
// Size: 0x22
function get_behavior_attribute( attribute )
{
    return getaiattribute( self, attribute );
}

// Namespace ai
// Params 1
// Checksum 0x4f212da3, Offset: 0x6e8
// Size: 0x22, Type: bool
function has_behavior_attribute( attribute )
{
    return hasaiattribute( self, attribute );
}

// Namespace ai
// Params 0
// Checksum 0xb1b6c6eb, Offset: 0x718
// Size: 0x46
function is_dead_sentient()
{
    if ( issentient( self ) && !isalive( self ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace ai
// Params 3
// Checksum 0x21fa2768, Offset: 0x768
// Size: 0x216
function waittill_dead( guys, num, timeoutlength )
{
    allalive = 1;
    
    for ( i = 0; i < guys.size ; i++ )
    {
        if ( isalive( guys[ i ] ) )
        {
            continue;
        }
        
        allalive = 0;
        break;
    }
    
    assert( allalive, "<dev string:xc3>" );
    
    if ( !allalive )
    {
        newarray = [];
        
        for ( i = 0; i < guys.size ; i++ )
        {
            if ( isalive( guys[ i ] ) )
            {
                newarray[ newarray.size ] = guys[ i ];
            }
        }
        
        guys = newarray;
    }
    
    ent = spawnstruct();
    
    if ( isdefined( timeoutlength ) )
    {
        ent endon( #"thread_timed_out" );
        ent thread waittill_dead_timeout( timeoutlength );
    }
    
    ent.count = guys.size;
    
    if ( isdefined( num ) && num < ent.count )
    {
        ent.count = num;
    }
    
    array::thread_all( guys, &waittill_dead_thread, ent );
    
    while ( ent.count > 0 )
    {
        ent waittill( #"hash_27bc4415" );
    }
}

// Namespace ai
// Params 3
// Checksum 0x86a47a77, Offset: 0x988
// Size: 0x19e
function waittill_dead_or_dying( guys, num, timeoutlength )
{
    newarray = [];
    
    for ( i = 0; i < guys.size ; i++ )
    {
        if ( isalive( guys[ i ] ) && !guys[ i ].ignoreforfixednodesafecheck )
        {
            newarray[ newarray.size ] = guys[ i ];
        }
    }
    
    guys = newarray;
    ent = spawnstruct();
    
    if ( isdefined( timeoutlength ) )
    {
        ent endon( #"thread_timed_out" );
        ent thread waittill_dead_timeout( timeoutlength );
    }
    
    ent.count = guys.size;
    
    if ( isdefined( num ) && num < ent.count )
    {
        ent.count = num;
    }
    
    array::thread_all( guys, &waittill_dead_or_dying_thread, ent );
    
    while ( ent.count > 0 )
    {
        ent waittill( #"waittill_dead_guy_dead_or_dying" );
    }
}

// Namespace ai
// Params 1, eflags: 0x4
// Checksum 0x65e47ebf, Offset: 0xb30
// Size: 0x38
function private waittill_dead_thread( ent )
{
    self waittill( #"death" );
    ent.count--;
    ent notify( #"hash_27bc4415" );
}

// Namespace ai
// Params 1
// Checksum 0x9213aec0, Offset: 0xb70
// Size: 0x54
function waittill_dead_or_dying_thread( ent )
{
    self util::waittill_either( "death", "pain_death" );
    ent.count--;
    ent notify( #"waittill_dead_guy_dead_or_dying" );
}

// Namespace ai
// Params 1
// Checksum 0x5be3679a, Offset: 0xbd0
// Size: 0x1e
function waittill_dead_timeout( timeoutlength )
{
    wait timeoutlength;
    self notify( #"thread_timed_out" );
}

// Namespace ai
// Params 0, eflags: 0x4
// Checksum 0x4e000238, Offset: 0xbf8
// Size: 0x50
function private wait_for_shoot()
{
    self endon( #"stop_shoot_at_target" );
    
    if ( isvehicle( self ) )
    {
        self waittill( #"weapon_fired" );
    }
    else
    {
        self waittill( #"shoot" );
    }
    
    self.start_duration_comp = 1;
}

// Namespace ai
// Params 6
// Checksum 0xe0beb50a, Offset: 0xc50
// Size: 0x3e4
function shoot_at_target( mode, target, tag, duration, sethealth, ignorefirstshotwait )
{
    self endon( #"death" );
    self endon( #"stop_shoot_at_target" );
    assert( isdefined( target ), "<dev string:x11e>" );
    assert( isdefined( mode ), "<dev string:x14d>" );
    mode_flag = mode === "normal" || mode === "shoot_until_target_dead" || mode === "kill_within_time";
    assert( mode_flag, "<dev string:x186>" );
    
    if ( isdefined( duration ) )
    {
        assert( duration >= 0, "<dev string:x1df>" );
    }
    else
    {
        duration = 0;
    }
    
    if ( isdefined( sethealth ) && isdefined( target ) )
    {
        target.health = sethealth;
    }
    
    if ( mode === "shoot_until_target_dead" && ( !isdefined( target ) || target.health <= 0 ) )
    {
        return;
    }
    
    if ( isdefined( tag ) && tag != "" )
    {
        self setentitytarget( target, 1, tag );
    }
    else
    {
        self setentitytarget( target, 1 );
    }
    
    self.cansee_override = 1;
    self.start_duration_comp = 0;
    
    switch ( mode )
    {
        case "normal":
            break;
        default:
            duration = -1;
            break;
        case "kill_within_time":
            target damagemode( "next_shot_kills" );
            break;
    }
    
    if ( isvehicle( self ) )
    {
        self vehicle_ai::clearallcooldowns();
    }
    
    if ( ignorefirstshotwait === 1 )
    {
        self.start_duration_comp = 1;
    }
    else
    {
        self thread wait_for_shoot();
    }
    
    if ( isdefined( duration ) && isdefined( target ) && target.health > 0 )
    {
        if ( duration >= 0 )
        {
            elapsed = 0;
            
            while ( isdefined( target ) && target.health > 0 && elapsed <= duration )
            {
                elapsed += 0.05;
                
                if ( !( isdefined( self.start_duration_comp ) && self.start_duration_comp ) )
                {
                    elapsed = 0;
                }
                
                wait 0.05;
            }
            
            if ( isdefined( target ) && mode == "kill_within_time" )
            {
                self.perfectaim = 1;
                self.aim_set_by_shoot_at_target = 1;
                target waittill( #"death" );
            }
        }
        else if ( duration == -1 )
        {
            target waittill( #"death" );
        }
    }
    
    stop_shoot_at_target();
}

// Namespace ai
// Params 0
// Checksum 0xc83ac2c7, Offset: 0x1040
// Size: 0x62
function stop_shoot_at_target()
{
    self clearentitytarget();
    
    if ( isdefined( self.aim_set_by_shoot_at_target ) && self.aim_set_by_shoot_at_target )
    {
        self.perfectaim = 0;
        self.aim_set_by_shoot_at_target = 0;
    }
    
    self.cansee_override = 0;
    self notify( #"stop_shoot_at_target" );
}

// Namespace ai
// Params 0
// Checksum 0x82675813, Offset: 0x10b0
// Size: 0x28
function wait_until_done_speaking()
{
    self endon( #"death" );
    
    while ( self.isspeaking )
    {
        wait 0.05;
    }
}

// Namespace ai
// Params 3
// Checksum 0x6cd958a, Offset: 0x10e0
// Size: 0x138
function set_goal( value, key, b_force )
{
    if ( !isdefined( key ) )
    {
        key = "targetname";
    }
    
    if ( !isdefined( b_force ) )
    {
        b_force = 0;
    }
    
    goal = getnode( value, key );
    
    if ( isdefined( goal ) )
    {
        self setgoal( goal, b_force );
    }
    else
    {
        goal = getent( value, key );
        
        if ( isdefined( goal ) )
        {
            self setgoal( goal, b_force );
        }
        else
        {
            goal = struct::get( value, key );
            
            if ( isdefined( goal ) )
            {
                self setgoal( goal.origin, b_force );
            }
        }
    }
    
    return goal;
}

// Namespace ai
// Params 6
// Checksum 0x4eac0295, Offset: 0x1220
// Size: 0xda
function force_goal( goto, n_radius, b_shoot, str_end_on, b_keep_colors, b_should_sprint )
{
    if ( !isdefined( b_shoot ) )
    {
        b_shoot = 1;
    }
    
    if ( !isdefined( b_keep_colors ) )
    {
        b_keep_colors = 0;
    }
    
    if ( !isdefined( b_should_sprint ) )
    {
        b_should_sprint = 0;
    }
    
    self endon( #"death" );
    s_tracker = spawnstruct();
    self thread _force_goal( s_tracker, goto, n_radius, b_shoot, str_end_on, b_keep_colors, b_should_sprint );
    s_tracker waittill( #"done" );
}

// Namespace ai
// Params 7
// Checksum 0x70f76ae7, Offset: 0x1308
// Size: 0x454
function _force_goal( s_tracker, goto, n_radius, b_shoot, str_end_on, b_keep_colors, b_should_sprint )
{
    if ( !isdefined( b_shoot ) )
    {
        b_shoot = 1;
    }
    
    if ( !isdefined( b_keep_colors ) )
    {
        b_keep_colors = 0;
    }
    
    if ( !isdefined( b_should_sprint ) )
    {
        b_should_sprint = 0;
    }
    
    self endon( #"death" );
    self notify( #"new_force_goal" );
    flagsys::wait_till_clear( "force_goal" );
    flagsys::set( "force_goal" );
    goalradius = self.goalradius;
    
    if ( isdefined( n_radius ) )
    {
        assert( isfloat( n_radius ) || isint( n_radius ), "<dev string:x20e>" );
        self.goalradius = n_radius;
    }
    
    color_enabled = 0;
    
    if ( !b_keep_colors )
    {
        if ( isdefined( colors::get_force_color() ) )
        {
            color_enabled = 1;
            self colors::disable();
        }
    }
    
    allowpain = self.allowpain;
    ignoreall = self.ignoreall;
    ignoreme = self.ignoreme;
    ignoresuppression = self.ignoresuppression;
    grenadeawareness = self.grenadeawareness;
    
    if ( !b_shoot )
    {
        self set_ignoreall( 1 );
    }
    
    if ( b_should_sprint )
    {
        self set_behavior_attribute( "sprint", 1 );
    }
    
    self.ignoresuppression = 1;
    self.grenadeawareness = 0;
    self set_ignoreme( 1 );
    self disable_pain();
    self pushplayer( 1 );
    
    if ( isdefined( goto ) )
    {
        if ( isdefined( n_radius ) )
        {
            assert( isfloat( n_radius ) || isint( n_radius ), "<dev string:x20e>" );
            self setgoal( goto );
        }
        else
        {
            self setgoal( goto, 1 );
        }
    }
    
    self util::waittill_any( "goal", "new_force_goal", str_end_on );
    
    if ( color_enabled )
    {
        colors::enable();
    }
    
    self pushplayer( 0 );
    self clearforcedgoal();
    self.goalradius = goalradius;
    self set_ignoreall( ignoreall );
    self set_ignoreme( ignoreme );
    
    if ( allowpain )
    {
        self enable_pain();
    }
    
    self set_behavior_attribute( "sprint", 0 );
    self.ignoresuppression = ignoresuppression;
    self.grenadeawareness = grenadeawareness;
    flagsys::clear( "force_goal" );
    s_tracker notify( #"done" );
}

// Namespace ai
// Params 0
// Checksum 0xaa64916f, Offset: 0x1768
// Size: 0x12
function stoppainwaitinterval()
{
    self notify( #"painwaitintervalremove" );
}

// Namespace ai
// Params 0, eflags: 0x4
// Checksum 0x68c5c59e, Offset: 0x1788
// Size: 0x40
function private _allowpainrestore()
{
    self endon( #"death" );
    self util::waittill_any( "painWaitIntervalRemove", "painWaitInterval" );
    self.allowpain = 1;
}

// Namespace ai
// Params 1
// Checksum 0x83077b41, Offset: 0x17d0
// Size: 0xbc
function painwaitinterval( msec )
{
    self endon( #"death" );
    self notify( #"painwaitinterval" );
    self endon( #"painwaitinterval" );
    self endon( #"painwaitintervalremove" );
    self thread _allowpainrestore();
    
    if ( !isdefined( msec ) || msec < 20 )
    {
        msec = 20;
    }
    
    while ( isalive( self ) )
    {
        self waittill( #"pain" );
        self.allowpain = 0;
        wait msec / 1000;
        self.allowpain = 1;
    }
}

// Namespace ai
// Params 1
// Checksum 0xaca329f4, Offset: 0x1898
// Size: 0x4f8
function patrol( start_path_node )
{
    self endon( #"death" );
    self endon( #"stop_patrolling" );
    assert( isdefined( start_path_node ), self.targetname + "<dev string:x24e>" );
    
    if ( start_path_node.type == "BAD NODE" )
    {
        /#
            errormsg = "<dev string:x2a8>" + start_path_node.targetname + "<dev string:x2bd>" + int( start_path_node.origin[ 0 ] ) + "<dev string:x2c1>" + int( start_path_node.origin[ 1 ] ) + "<dev string:x2c1>" + int( start_path_node.origin[ 2 ] ) + "<dev string:x2c3>";
            iprintln( errormsg );
            logprint( errormsg );
        #/
        
        return;
    }
    
    assert( start_path_node.type == "<dev string:x2d3>" || isdefined( start_path_node.scriptbundlename ), "<dev string:x2d8>" + start_path_node.targetname + "<dev string:x2ed>" );
    self notify( #"go_to_spawner_target" );
    self.target = undefined;
    self.old_goal_radius = self.goalradius;
    self thread end_patrol_on_enemy_targetting();
    self.currentgoal = start_path_node;
    self.patroller = 1;
    
    while ( true )
    {
        if ( isdefined( self.currentgoal.type ) && self.currentgoal.type == "Path" )
        {
            if ( self has_behavior_attribute( "patrol" ) )
            {
                self set_behavior_attribute( "patrol", 1 );
            }
            
            self setgoal( self.currentgoal, 1 );
            self waittill( #"goal" );
            
            if ( isdefined( self.currentgoal.script_notify ) )
            {
                self notify( self.currentgoal.script_notify );
                level notify( self.currentgoal.script_notify );
            }
            
            if ( isdefined( self.currentgoal.script_flag_set ) )
            {
                flag = self.currentgoal.script_flag_set;
                
                if ( !isdefined( level.flag[ flag ] ) )
                {
                    level flag::init( flag );
                }
                
                level flag::set( flag );
            }
            
            if ( !isdefined( self.currentgoal.script_wait_min ) )
            {
                self.currentgoal.script_wait_min = 0;
            }
            
            if ( !isdefined( self.currentgoal.script_wait_max ) )
            {
                self.currentgoal.script_wait_max = 0;
            }
            
            assert( self.currentgoal.script_wait_min <= self.currentgoal.script_wait_max, "<dev string:x32b>" + self.currentgoal.targetname );
            
            if ( !isdefined( self.currentgoal.scriptbundlename ) )
            {
                wait_variability = self.currentgoal.script_wait_max - self.currentgoal.script_wait_min;
                wait_time = self.currentgoal.script_wait_min + randomfloat( wait_variability );
                self notify( #"patrol_goal", self.currentgoal );
                wait wait_time;
            }
            else
            {
                self scene::play( self.currentgoal.scriptbundlename, self );
            }
        }
        else
        {
            self.currentgoal scene::play( self );
        }
        
        self patrol_next_node();
    }
}

// Namespace ai
// Params 0
// Checksum 0xa3a4449, Offset: 0x1d98
// Size: 0x11c
function patrol_next_node()
{
    target_nodes = [];
    target_scenes = [];
    
    if ( isdefined( self.currentgoal.target ) )
    {
        target_nodes = getnodearray( self.currentgoal.target, "targetname" );
        target_scenes = struct::get_array( self.currentgoal.target, "targetname" );
    }
    
    if ( target_nodes.size == 0 && target_scenes.size == 0 )
    {
        self end_and_clean_patrol_behaviors();
        return;
    }
    
    if ( target_nodes.size != 0 )
    {
        self.currentgoal = array::random( target_nodes );
        return;
    }
    
    self.currentgoal = array::random( target_scenes );
}

// Namespace ai
// Params 0
// Checksum 0xd8c65fe9, Offset: 0x1ec0
// Size: 0x60
function end_patrol_on_enemy_targetting()
{
    self endon( #"death" );
    self endon( #"stop_patrolling" );
    
    while ( true )
    {
        if ( isdefined( self.enemy ) || self.should_stop_patrolling === 1 )
        {
            self end_and_clean_patrol_behaviors();
        }
        
        wait 0.1;
    }
}

// Namespace ai
// Params 0
// Checksum 0xe6c35951, Offset: 0x1f28
// Size: 0xd2
function end_and_clean_patrol_behaviors()
{
    if ( isdefined( self.currentgoal ) && isdefined( self.currentgoal.scriptbundlename ) && isdefined( self._o_scene ) )
    {
        self._o_scene cscene::stop();
    }
    
    if ( self has_behavior_attribute( "patrol" ) )
    {
        self set_behavior_attribute( "patrol", 0 );
    }
    
    if ( isdefined( self.old_goal_radius ) )
    {
        self.goalradius = self.old_goal_radius;
    }
    
    self clearforcedgoal();
    self notify( #"stop_patrolling" );
    self.patroller = undefined;
}

// Namespace ai
// Params 2
// Checksum 0xbc818625, Offset: 0x2008
// Size: 0x2c4
function bloody_death( n_delay, hit_loc )
{
    self endon( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    assert( isactor( self ) );
    assert( isalive( self ) );
    
    if ( isdefined( self.__bloody_death ) && self.__bloody_death )
    {
        return;
    }
    
    self.__bloody_death = 1;
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( hit_loc ) )
    {
        assert( isinarray( array( "<dev string:x359>", "<dev string:x360>", "<dev string:x365>", "<dev string:x36a>", "<dev string:x376>", "<dev string:x380>", "<dev string:x38c>", "<dev string:x39c>", "<dev string:x3ab>", "<dev string:x3bb>", "<dev string:x3ca>", "<dev string:x3d5>", "<dev string:x3df>", "<dev string:x3ef>", "<dev string:x3fe>", "<dev string:x40e>", "<dev string:x41d>", "<dev string:x428>", "<dev string:x432>", "<dev string:x436>" ), hit_loc ), "<dev string:x441>" );
    }
    else
    {
        hit_loc = array::random( array( "helmet", "head", "neck", "torso_upper", "torso_mid", "torso_lower", "right_arm_upper", "left_arm_upper", "right_arm_lower", "left_arm_lower", "right_hand", "left_hand", "right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot", "gun", "riotshield" ) );
    }
    
    self dodamage( self.health + 100, self.origin, undefined, undefined, hit_loc );
}

// Namespace ai
// Params 1
// Checksum 0x31ff0920, Offset: 0x22d8
// Size: 0x48, Type: bool
function shouldregisterclientfieldforarchetype( archetype )
{
    if ( isdefined( level.clientfieldaicheck ) && level.clientfieldaicheck && !isarchetypeloaded( archetype ) )
    {
        return false;
    }
    
    return true;
}

