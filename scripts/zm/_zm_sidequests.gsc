#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;

#namespace zm_sidequests;

// Namespace zm_sidequests
// Params 0
// Checksum 0xe82d6be4, Offset: 0x228
// Size: 0x2c
function init_sidequests()
{
    level._zombie_sidequests = [];
    
    /#
        level thread sidequest_debug();
    #/
}

// Namespace zm_sidequests
// Params 1
// Checksum 0x422ca32e, Offset: 0x260
// Size: 0xd2
function is_sidequest_allowed( a_gametypes )
{
    if ( isdefined( level.gamedifficulty ) && level.gamedifficulty == 0 )
    {
        return 0;
    }
    
    b_is_gametype_active = 0;
    
    if ( !isarray( a_gametypes ) )
    {
        a_gametypes = array( a_gametypes );
    }
    
    for ( i = 0; i < a_gametypes.size ; i++ )
    {
        if ( getdvarstring( "g_gametype" ) == a_gametypes[ i ] )
        {
            b_is_gametype_active = 1;
        }
    }
    
    return b_is_gametype_active;
}

/#

    // Namespace zm_sidequests
    // Params 0
    // Checksum 0x76616890, Offset: 0x340
    // Size: 0x44, Type: dev
    function sidequest_debug()
    {
        if ( getdvarstring( "<dev string:x28>" ) != "<dev string:x3d>" )
        {
            return;
        }
        
        while ( true )
        {
            wait 1;
        }
    }

#/

// Namespace zm_sidequests
// Params 2
// Checksum 0x1f517eea, Offset: 0x390
// Size: 0x10a
function damager_trigger_thread( dam_types, trigger_func )
{
    while ( true )
    {
        self waittill( #"damage", amount, attacker, dir, point, type );
        self.dam_amount = amount;
        self.attacker = attacker;
        self.dam_dir = dir;
        self.dam_point = point;
        self.dam_type = type;
        
        for ( i = 0; i < dam_types.size ; i++ )
        {
            if ( type == dam_types[ i ] )
            {
                break;
            }
        }
    }
    
    if ( isdefined( trigger_func ) )
    {
        self [[ trigger_func ]]();
    }
    
    self notify( #"triggered" );
}

// Namespace zm_sidequests
// Params 0
// Checksum 0xf715094f, Offset: 0x4a8
// Size: 0x3c
function damage_trigger_thread()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage" );
        self.owner_ent notify( #"triggered" );
    }
}

// Namespace zm_sidequests
// Params 0
// Checksum 0xf6762281, Offset: 0x4f0
// Size: 0x3c
function entity_damage_thread()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage" );
        self.owner_ent notify( #"triggered" );
    }
}

// Namespace zm_sidequests
// Params 1
// Checksum 0xe6b43d0f, Offset: 0x538
// Size: 0x28
function sidequest_uses_teleportation( name )
{
    level._zombie_sidequests[ name ].uses_teleportation = 1;
}

// Namespace zm_sidequests
// Params 2
// Checksum 0xb276c266, Offset: 0x568
// Size: 0xa4
function register_sidequest_icon( icon_name, version_number )
{
    clientfieldprefix = "sidequestIcons." + icon_name + ".";
    clientfield::register( "clientuimodel", clientfieldprefix + "icon", version_number, 1, "int" );
    clientfield::register( "clientuimodel", clientfieldprefix + "notification", version_number, 1, "int" );
}

// Namespace zm_sidequests
// Params 3
// Checksum 0x91bcd30e, Offset: 0x618
// Size: 0x9c
function add_sidequest_icon( sidequest_name, icon_name, show_notification )
{
    if ( !isdefined( show_notification ) )
    {
        show_notification = 1;
    }
    
    clientfield::set_player_uimodel( "sidequestIcons." + icon_name + ".icon", 1 );
    
    if ( isdefined( show_notification ) && show_notification )
    {
        clientfield::set_player_uimodel( "sidequestIcons." + icon_name + ".notification", 1 );
    }
}

// Namespace zm_sidequests
// Params 2
// Checksum 0xa476429a, Offset: 0x6c0
// Size: 0x64
function remove_sidequest_icon( sidequest_name, icon_name )
{
    clientfield::set_player_uimodel( "sidequestIcons." + icon_name + ".icon", 0 );
    clientfield::set_player_uimodel( "sidequestIcons." + icon_name + ".notification", 0 );
}

// Namespace zm_sidequests
// Params 6
// Checksum 0x4743d63a, Offset: 0x730
// Size: 0x1d2
function declare_sidequest( name, init_func, logic_func, complete_func, generic_stage_start_func, generic_stage_end_func )
{
    if ( !isdefined( level._zombie_sidequests ) )
    {
        init_sidequests();
    }
    
    /#
        if ( isdefined( level._zombie_sidequests[ name ] ) )
        {
            println( "<dev string:x3f>" + name );
            return;
        }
    #/
    
    sq = spawnstruct();
    sq.name = name;
    sq.stages = [];
    sq.last_completed_stage = -1;
    sq.active_stage = -1;
    sq.sidequest_complete = 0;
    sq.init_func = init_func;
    sq.logic_func = logic_func;
    sq.complete_func = complete_func;
    sq.generic_stage_start_func = generic_stage_start_func;
    sq.generic_stage_end_func = generic_stage_end_func;
    sq.assets = [];
    sq.uses_teleportation = 0;
    sq.active_assets = [];
    sq.icons = [];
    sq.num_reps = 0;
    level._zombie_sidequests[ name ] = sq;
}

// Namespace zm_sidequests
// Params 5
// Checksum 0x7db614d6, Offset: 0x910
// Size: 0x1f2
function declare_sidequest_stage( sidequest_name, stage_name, init_func, logic_func, exit_func )
{
    /#
        if ( !isdefined( level._zombie_sidequests ) )
        {
            println( "<dev string:x75>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ] ) )
        {
            println( "<dev string:xc3>" + stage_name + "<dev string:xe5>" + sidequest_name + "<dev string:xf5>" );
            return;
        }
        
        if ( isdefined( level._zombie_sidequests[ sidequest_name ].stages[ stage_name ] ) )
        {
            println( "<dev string:x115>" + sidequest_name + "<dev string:x12b>" + stage_name );
            return;
        }
    #/
    
    stage = spawnstruct();
    stage.name = stage_name;
    stage.stage_number = level._zombie_sidequests[ sidequest_name ].stages.size;
    stage.assets = [];
    stage.active_assets = [];
    stage.logic_func = logic_func;
    stage.init_func = init_func;
    stage.exit_func = exit_func;
    stage.completed = 0;
    stage.time_limit = 0;
    level._zombie_sidequests[ sidequest_name ].stages[ stage_name ] = stage;
}

// Namespace zm_sidequests
// Params 4
// Checksum 0xe745e5b2, Offset: 0xb10
// Size: 0x158
function set_stage_time_limit( sidequest_name, stage_name, time_limit, timer_func )
{
    /#
        if ( !isdefined( level._zombie_sidequests ) )
        {
            println( "<dev string:x148>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ] ) )
        {
            println( "<dev string:x19d>" + stage_name + "<dev string:x1cc>" + sidequest_name + "<dev string:xf5>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ].stages[ stage_name ] ) )
        {
            println( "<dev string:x1dc>" + stage_name + "<dev string:x20a>" + sidequest_name + "<dev string:x219>" );
            return;
        }
    #/
    
    level._zombie_sidequests[ sidequest_name ].stages[ stage_name ].time_limit = time_limit;
    level._zombie_sidequests[ sidequest_name ].stages[ stage_name ].time_limit_func = timer_func;
}

// Namespace zm_sidequests
// Params 5
// Checksum 0x20a25844, Offset: 0xc70
// Size: 0x284
function declare_stage_asset_from_struct( sidequest_name, stage_name, target_name, thread_func, trigger_thread_func )
{
    structs = struct::get_array( target_name, "targetname" );
    
    /#
        if ( !isdefined( level._zombie_sidequests ) )
        {
            println( "<dev string:x234>" + target_name + "<dev string:x267>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ] ) )
        {
            println( "<dev string:x284>" + target_name + "<dev string:xe5>" + sidequest_name + "<dev string:xf5>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ].stages[ stage_name ] ) )
        {
            println( "<dev string:x284>" + target_name + "<dev string:xe5>" + sidequest_name + "<dev string:x2a6>" + stage_name + "<dev string:x2aa>" );
            return;
        }
        
        if ( !structs.size )
        {
            println( "<dev string:x2c5>" + target_name + "<dev string:x2e1>" );
            return;
        }
    #/
    
    for ( i = 0; i < structs.size ; i++ )
    {
        asset = spawnstruct();
        asset.type = "struct";
        asset.struct = structs[ i ];
        asset.thread_func = thread_func;
        asset.trigger_thread_func = trigger_thread_func;
        level._zombie_sidequests[ sidequest_name ].stages[ stage_name ].assets[ level._zombie_sidequests[ sidequest_name ].stages[ stage_name ].assets.size ] = asset;
    }
}

// Namespace zm_sidequests
// Params 3
// Checksum 0x2c3f7ab6, Offset: 0xf00
// Size: 0x144
function declare_stage_title( sidequest_name, stage_name, title )
{
    /#
        if ( !isdefined( level._zombie_sidequests ) )
        {
            println( "<dev string:x2ed>" + title + "<dev string:x267>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ] ) )
        {
            println( "<dev string:x2ed>" + title + "<dev string:xe5>" + sidequest_name + "<dev string:xf5>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ].stages[ stage_name ] ) )
        {
            println( "<dev string:x31b>" + title + "<dev string:xe5>" + sidequest_name + "<dev string:x2a6>" + stage_name + "<dev string:x2aa>" );
            return;
        }
    #/
    
    level._zombie_sidequests[ sidequest_name ].stages[ stage_name ].title = title;
}

// Namespace zm_sidequests
// Params 5
// Checksum 0xecb7ffd2, Offset: 0x1050
// Size: 0x284
function declare_stage_asset( sidequest_name, stage_name, target_name, thread_func, trigger_thread_func )
{
    ents = getentarray( target_name, "targetname" );
    
    /#
        if ( !isdefined( level._zombie_sidequests ) )
        {
            println( "<dev string:x234>" + target_name + "<dev string:x267>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ] ) )
        {
            println( "<dev string:x284>" + target_name + "<dev string:xe5>" + sidequest_name + "<dev string:xf5>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ].stages[ stage_name ] ) )
        {
            println( "<dev string:x284>" + target_name + "<dev string:xe5>" + sidequest_name + "<dev string:x2a6>" + stage_name + "<dev string:x2aa>" );
            return;
        }
        
        if ( !ents.size )
        {
            println( "<dev string:x347>" + target_name + "<dev string:x2e1>" );
            return;
        }
    #/
    
    for ( i = 0; i < ents.size ; i++ )
    {
        asset = spawnstruct();
        asset.type = "entity";
        asset.ent = ents[ i ];
        asset.thread_func = thread_func;
        asset.trigger_thread_func = trigger_thread_func;
        level._zombie_sidequests[ sidequest_name ].stages[ stage_name ].assets[ level._zombie_sidequests[ sidequest_name ].stages[ stage_name ].assets.size ] = asset;
    }
}

// Namespace zm_sidequests
// Params 4
// Checksum 0xd680e68f, Offset: 0x12e0
// Size: 0x224
function declare_sidequest_asset( sidequest_name, target_name, thread_func, trigger_thread_func )
{
    ents = getentarray( target_name, "targetname" );
    
    /#
        if ( !isdefined( level._zombie_sidequests ) )
        {
            println( "<dev string:x234>" + target_name + "<dev string:x267>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ] ) )
        {
            println( "<dev string:x284>" + target_name + "<dev string:xe5>" + sidequest_name + "<dev string:xf5>" );
            return;
        }
        
        if ( !ents.size )
        {
            println( "<dev string:x347>" + target_name + "<dev string:x2e1>" );
            return;
        }
    #/
    
    for ( i = 0; i < ents.size ; i++ )
    {
        asset = spawnstruct();
        asset.type = "entity";
        asset.ent = ents[ i ];
        asset.thread_func = thread_func;
        asset.trigger_thread_func = trigger_thread_func;
        asset.ent.thread_func = thread_func;
        asset.ent.trigger_thread_func = trigger_thread_func;
        level._zombie_sidequests[ sidequest_name ].assets[ level._zombie_sidequests[ sidequest_name ].assets.size ] = asset;
    }
}

// Namespace zm_sidequests
// Params 4
// Checksum 0x85696cf, Offset: 0x1510
// Size: 0x1ec
function declare_sidequest_asset_from_struct( sidequest_name, target_name, thread_func, trigger_thread_func )
{
    structs = struct::get_array( target_name, "targetname" );
    
    /#
        if ( !isdefined( level._zombie_sidequests ) )
        {
            println( "<dev string:x234>" + target_name + "<dev string:x267>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ] ) )
        {
            println( "<dev string:x284>" + target_name + "<dev string:xe5>" + sidequest_name + "<dev string:xf5>" );
            return;
        }
        
        if ( !structs.size )
        {
            println( "<dev string:x2c5>" + target_name + "<dev string:x2e1>" );
            return;
        }
    #/
    
    for ( i = 0; i < structs.size ; i++ )
    {
        asset = spawnstruct();
        asset.type = "struct";
        asset.struct = structs[ i ];
        asset.thread_func = thread_func;
        asset.trigger_thread_func = trigger_thread_func;
        level._zombie_sidequests[ sidequest_name ].assets[ level._zombie_sidequests[ sidequest_name ].assets.size ] = asset;
    }
}

// Namespace zm_sidequests
// Params 2
// Checksum 0xb075fc6, Offset: 0x1708
// Size: 0x228
function build_asset_from_struct( asset, parent_struct )
{
    ent = spawn( "script_model", asset.origin );
    
    if ( isdefined( asset.model ) )
    {
        ent setmodel( asset.model );
        asset.var_d0dd151f = ent;
    }
    
    if ( isdefined( asset.angles ) )
    {
        ent.angles = asset.angles;
    }
    
    ent.script_noteworthy = asset.script_noteworthy;
    ent.type = "struct";
    ent.radius = asset.radius;
    ent.thread_func = parent_struct.thread_func;
    ent.trigger_thread_func = parent_struct.trigger_thread_func;
    ent.script_vector = parent_struct.script_vector;
    asset.trigger_thread_func = parent_struct.trigger_thread_func;
    asset.script_vector = parent_struct.script_vector;
    ent.target = asset.target;
    ent.script_float = asset.script_float;
    ent.script_int = asset.script_int;
    ent.script_trigger_spawnflags = asset.script_trigger_spawnflags;
    ent.targetname = asset.targetname;
    return ent;
}

// Namespace zm_sidequests
// Params 0
// Checksum 0xf6dd6427, Offset: 0x1938
// Size: 0x200
function delete_stage_assets()
{
    for ( i = 0; i < self.active_assets.size ; i++ )
    {
        asset = self.active_assets[ i ];
        
        switch ( asset.type )
        {
            default:
                if ( isdefined( asset.trigger ) )
                {
                    println( "<dev string:x360>" );
                    
                    if ( !( isdefined( asset.trigger.var_b82c7478 ) && asset.trigger.var_b82c7478 ) )
                    {
                        asset.trigger delete();
                    }
                    
                    asset.trigger = undefined;
                }
                
                asset delete();
                break;
            case "entity":
                if ( isdefined( asset.trigger ) )
                {
                    println( "<dev string:x389>" );
                    asset.trigger delete();
                    asset.trigger = undefined;
                }
                
                break;
        }
    }
    
    remaining_assets = [];
    
    for ( i = 0; i < self.active_assets.size ; i++ )
    {
        if ( isdefined( self.active_assets[ i ] ) )
        {
            remaining_assets[ remaining_assets.size ] = self.active_assets[ i ];
        }
    }
    
    self.active_assets = remaining_assets;
}

// Namespace zm_sidequests
// Params 0
// Checksum 0x5c4b1e5e, Offset: 0x1b40
// Size: 0x7d6
function build_assets()
{
    for ( i = 0; i < self.assets.size ; i++ )
    {
        asset = undefined;
        
        switch ( self.assets[ i ].type )
        {
            case "struct":
                asset = self.assets[ i ].struct;
                self.active_assets[ self.active_assets.size ] = build_asset_from_struct( asset, self.assets[ i ] );
                break;
            case "entity":
                for ( j = 0; j < self.active_assets.size ; j++ )
                {
                    if ( self.active_assets[ j ] == self.assets[ i ].ent )
                    {
                        asset = self.active_assets[ j ];
                        break;
                    }
                }
                
                asset = self.assets[ i ].ent;
                asset.type = "entity";
                self.active_assets[ self.active_assets.size ] = asset;
                break;
            default:
                println( "<dev string:x3af>" + self.assets.type );
                break;
        }
        
        if ( self.assets[ i ].type == "entity" && isdefined( asset.script_noteworthy ) && !isdefined( asset.trigger ) || isdefined( asset.script_noteworthy ) )
        {
            trigger_radius = 15;
            trigger_height = 72;
            
            if ( isdefined( asset.radius ) )
            {
                trigger_radius = asset.radius;
            }
            
            if ( isdefined( asset.height ) )
            {
                trigger_height = asset.height;
            }
            
            trigger_spawnflags = 0;
            
            if ( isdefined( asset.script_trigger_spawnflags ) )
            {
                trigger_spawnflags = asset.script_trigger_spawnflags;
            }
            
            trigger_offset = ( 0, 0, 0 );
            
            if ( isdefined( asset.script_vector ) )
            {
                trigger_offset = asset.script_vector;
            }
            
            switch ( asset.script_noteworthy )
            {
                default:
                    use_trigger = spawn( "trigger_radius_use", asset.origin + trigger_offset, trigger_spawnflags, trigger_radius, trigger_height );
                    use_trigger setcursorhint( "HINT_NOICON" );
                    use_trigger triggerignoreteam();
                    
                    if ( isdefined( asset.radius ) )
                    {
                        use_trigger.radius = asset.radius;
                    }
                    
                    use_trigger.owner_ent = self.active_assets[ self.active_assets.size - 1 ];
                    
                    if ( isdefined( asset.trigger_thread_func ) )
                    {
                        use_trigger thread [[ asset.trigger_thread_func ]]();
                    }
                    else
                    {
                        use_trigger thread use_trigger_thread();
                    }
                    
                    self.active_assets[ self.active_assets.size - 1 ].trigger = use_trigger;
                    break;
                case "trigger_radius_damage":
                    damage_trigger = spawn( "trigger_damage", asset.origin + trigger_offset, trigger_spawnflags, trigger_radius, trigger_height );
                    damage_trigger.angles = asset.angles;
                    damage_trigger.owner_ent = self.active_assets[ self.active_assets.size - 1 ];
                    
                    if ( isdefined( asset.trigger_thread_func ) )
                    {
                        damage_trigger thread [[ asset.trigger_thread_func ]]();
                    }
                    else
                    {
                        damage_trigger thread damage_trigger_thread();
                    }
                    
                    self.active_assets[ self.active_assets.size - 1 ].trigger = damage_trigger;
                    break;
                case "trigger_radius":
                    radius_trigger = spawn( "trigger_radius", asset.origin + trigger_offset, trigger_spawnflags, trigger_radius, trigger_height );
                    
                    if ( isdefined( asset.radius ) )
                    {
                        radius_trigger.radius = asset.radius;
                    }
                    
                    radius_trigger.owner_ent = self.active_assets[ self.active_assets.size - 1 ];
                    
                    if ( isdefined( asset.trigger_thread_func ) )
                    {
                        radius_trigger thread [[ asset.trigger_thread_func ]]();
                    }
                    else
                    {
                        radius_trigger thread radius_trigger_thread();
                    }
                    
                    self.active_assets[ self.active_assets.size - 1 ].trigger = radius_trigger;
                    break;
                case "entity_damage":
                    asset.var_d0dd151f setcandamage( 1 );
                    asset.owner_ent = self.active_assets[ self.active_assets.size - 1 ];
                    
                    if ( isdefined( asset.trigger_thread_func ) )
                    {
                        asset.var_d0dd151f thread [[ asset.trigger_thread_func ]]();
                    }
                    else
                    {
                        asset.var_d0dd151f thread damage_trigger_thread();
                    }
                    
                    break;
            }
        }
        
        if ( isdefined( self.assets[ i ].thread_func ) && !isdefined( self.active_assets[ self.active_assets.size - 1 ].dont_rethread ) )
        {
            self.active_assets[ self.active_assets.size - 1 ] thread [[ self.assets[ i ].thread_func ]]();
        }
        
        if ( i % 2 == 0 )
        {
            util::wait_network_frame();
        }
    }
}

// Namespace zm_sidequests
// Params 0
// Checksum 0x40ceace8, Offset: 0x2320
// Size: 0x9c
function radius_trigger_thread()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        self.owner_ent notify( #"triggered" );
        
        while ( player istouching( self ) )
        {
            wait 0.05;
        }
        
        self.owner_ent notify( #"untriggered" );
    }
}

// Namespace zm_sidequests
// Params 2
// Checksum 0x47b8a987, Offset: 0x23c8
// Size: 0x7c
function thread_on_assets( target_name, thread_func )
{
    for ( i = 0; i < self.active_assets.size ; i++ )
    {
        if ( self.active_assets[ i ].targetname == target_name )
        {
            self.active_assets[ i ] thread [[ thread_func ]]();
        }
    }
}

// Namespace zm_sidequests
// Params 2
// Checksum 0xdf2e493b, Offset: 0x2450
// Size: 0x74
function stage_logic_func_wrapper( sidequest, stage )
{
    if ( isdefined( stage.logic_func ) )
    {
        level endon( sidequest.name + "_" + stage.name + "_over" );
        stage [[ stage.logic_func ]]();
    }
}

// Namespace zm_sidequests
// Params 1
// Checksum 0xc0087f1c, Offset: 0x24d0
// Size: 0x114
function sidequest_start( sidequest_name )
{
    /#
        if ( !isdefined( level._zombie_sidequests ) )
        {
            println( "<dev string:x3e1>" + sidequest_name + "<dev string:x267>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ] ) )
        {
            println( "<dev string:x40f>" + sidequest_name + "<dev string:xf5>" );
            return;
        }
    #/
    
    sidequest = level._zombie_sidequests[ sidequest_name ];
    sidequest build_assets();
    
    if ( isdefined( sidequest.init_func ) )
    {
        sidequest [[ sidequest.init_func ]]();
    }
    
    if ( isdefined( sidequest.logic_func ) )
    {
        sidequest thread [[ sidequest.logic_func ]]();
    }
}

// Namespace zm_sidequests
// Params 2
// Checksum 0xa55cc497, Offset: 0x25f0
// Size: 0x1e4
function stage_start( sidequest, stage )
{
    if ( isstring( sidequest ) )
    {
        sidequest = level._zombie_sidequests[ sidequest ];
    }
    
    if ( isstring( stage ) )
    {
        stage = sidequest.stages[ stage ];
    }
    
    stage build_assets();
    sidequest.active_stage = stage.stage_number;
    level notify( sidequest.name + "_" + stage.name + "_started" );
    stage.completed = 0;
    
    if ( isdefined( sidequest.generic_stage_start_func ) )
    {
        stage [[ sidequest.generic_stage_start_func ]]();
    }
    
    if ( isdefined( stage.init_func ) )
    {
        stage [[ stage.init_func ]]();
    }
    
    level._last_stage_started = stage.name;
    level thread stage_logic_func_wrapper( sidequest, stage );
    
    if ( stage.time_limit > 0 )
    {
        stage thread time_limited_stage( sidequest );
    }
    
    if ( isdefined( stage.title ) )
    {
        stage thread display_stage_title( sidequest.uses_teleportation );
    }
}

// Namespace zm_sidequests
// Params 1
// Checksum 0x3b5c4d8e, Offset: 0x27e0
// Size: 0x1dc
function display_stage_title( wait_for_teleport_done_notify )
{
    if ( wait_for_teleport_done_notify )
    {
        level waittill( #"teleport_done" );
        wait 2;
    }
    
    stage_text = newhudelem();
    stage_text.location = 0;
    stage_text.alignx = "center";
    stage_text.aligny = "middle";
    stage_text.foreground = 1;
    stage_text.fontscale = 1.6;
    stage_text.sort = 20;
    stage_text.x = 320;
    stage_text.y = 300;
    stage_text.og_scale = 1;
    stage_text.color = ( 128, 0, 0 );
    stage_text.alpha = 0;
    stage_text.fontstyle3d = "shadowedmore";
    stage_text settext( self.title );
    stage_text fadeovertime( 0.5 );
    stage_text.alpha = 1;
    wait 5;
    stage_text fadeovertime( 1 );
    stage_text.alpha = 0;
    wait 1;
    stage_text destroy();
}

// Namespace zm_sidequests
// Params 1
// Checksum 0x72de4e23, Offset: 0x29c8
// Size: 0x174
function time_limited_stage( sidequest )
{
    println( "<dev string:x42d>" + sidequest.name + "<dev string:x44f>" + self.name + "<dev string:x2a6>" + self.time_limit + "<dev string:x457>" );
    level endon( sidequest.name + "_" + self.name + "_over" );
    level endon( #"suspend_timer" );
    level endon( #"end_game" );
    time_limit = undefined;
    
    if ( isdefined( self.time_limit_func ) )
    {
        time_limit = [[ self.time_limit_func ]]() * 0.25;
    }
    else
    {
        time_limit = self.time_limit * 0.25;
    }
    
    wait time_limit;
    level notify( #"timed_stage_75_percent" );
    wait time_limit;
    level notify( #"timed_stage_50_percent" );
    wait time_limit;
    level notify( #"timed_stage_25_percent" );
    wait time_limit - 10;
    level notify( #"timed_stage_10_seconds_to_go" );
    wait 10;
    stage_failed( sidequest, self );
}

/#

    // Namespace zm_sidequests
    // Params 1
    // Checksum 0x22f0bca, Offset: 0x2b48
    // Size: 0x54, Type: dev
    function sidequest_println( str )
    {
        if ( getdvarstring( "<dev string:x28>" ) != "<dev string:x3d>" )
        {
            return;
        }
        
        println( str );
    }

#/

// Namespace zm_sidequests
// Params 0
// Checksum 0x99ec1590, Offset: 0x2ba8
// Size: 0x4
function precache_sidequest_assets()
{
    
}

// Namespace zm_sidequests
// Params 1
// Checksum 0x74b1b447, Offset: 0x2bb8
// Size: 0x9e
function sidequest_complete( sidequest_name )
{
    /#
        if ( !isdefined( level._zombie_sidequests ) )
        {
            println( "<dev string:x461>" + sidequest_name + "<dev string:x267>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ] ) )
        {
            println( "<dev string:x461>" + sidequest_name + "<dev string:xf5>" );
            return;
        }
    #/
    
    return level._zombie_sidequests[ sidequest_name ].sidequest_complete;
}

// Namespace zm_sidequests
// Params 2
// Checksum 0xd206fe7d, Offset: 0x2c60
// Size: 0x15c
function stage_completed( sidequest_name, stage_name )
{
    /#
        if ( !isdefined( level._zombie_sidequests ) )
        {
            println( "<dev string:x49f>" + sidequest_name + "<dev string:x267>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ] ) )
        {
            println( "<dev string:x49f>" + sidequest_name + "<dev string:xf5>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ].stages[ stage_name ] ) )
        {
            println( "<dev string:x4d9>" + sidequest_name + "<dev string:x2a6>" + stage_name + "<dev string:x2aa>" );
            return;
        }
        
        println( "<dev string:x50b>" );
    #/
    
    sidequest = level._zombie_sidequests[ sidequest_name ];
    stage = sidequest.stages[ stage_name ];
    level thread stage_completed_internal( sidequest, stage );
}

// Namespace zm_sidequests
// Params 2
// Checksum 0x4bf3cab2, Offset: 0x2dc8
// Size: 0x278
function stage_completed_internal( sidequest, stage )
{
    level notify( sidequest.name + "_" + stage.name + "_over" );
    level notify( sidequest.name + "_" + stage.name + "_completed" );
    
    if ( isdefined( sidequest.generic_stage_end_func ) )
    {
        println( "<dev string:x527>" );
        stage [[ sidequest.generic_stage_end_func ]]();
    }
    
    if ( isdefined( stage.exit_func ) )
    {
        println( "<dev string:x541>" );
        stage [[ stage.exit_func ]]( 1 );
    }
    
    stage.completed = 1;
    sidequest.last_completed_stage = sidequest.active_stage;
    sidequest.active_stage = -1;
    stage delete_stage_assets();
    all_complete = 1;
    stage_names = getarraykeys( sidequest.stages );
    
    for ( i = 0; i < stage_names.size ; i++ )
    {
        if ( sidequest.stages[ stage_names[ i ] ].completed == 0 )
        {
            all_complete = 0;
            break;
        }
    }
    
    if ( all_complete == 1 )
    {
        if ( isdefined( sidequest.complete_func ) )
        {
            sidequest thread [[ sidequest.complete_func ]]();
        }
        
        level notify( "sidequest_" + sidequest.name + "_complete" );
        sidequest.sidequest_completed = 1;
    }
}

// Namespace zm_sidequests
// Params 2
// Checksum 0xf1cce015, Offset: 0x3048
// Size: 0x104
function stage_failed_internal( sidequest, stage )
{
    level notify( sidequest.name + "_" + stage.name + "_over" );
    level notify( sidequest.name + "_" + stage.name + "_failed" );
    
    if ( isdefined( sidequest.generic_stage_end_func ) )
    {
        stage [[ sidequest.generic_stage_end_func ]]();
    }
    
    if ( isdefined( stage.exit_func ) )
    {
        stage [[ stage.exit_func ]]( 0 );
    }
    
    sidequest.active_stage = -1;
    stage delete_stage_assets();
}

// Namespace zm_sidequests
// Params 2
// Checksum 0x3a3503f, Offset: 0x3158
// Size: 0xb4
function stage_failed( sidequest, stage )
{
    println( "<dev string:x559>" );
    
    if ( isstring( sidequest ) )
    {
        sidequest = level._zombie_sidequests[ sidequest ];
    }
    
    if ( isstring( stage ) )
    {
        stage = sidequest.stages[ stage ];
    }
    
    level thread stage_failed_internal( sidequest, stage );
}

// Namespace zm_sidequests
// Params 2
// Checksum 0x98936ec6, Offset: 0x3218
// Size: 0xcc
function get_sidequest_stage( sidequest, stage_number )
{
    stage = undefined;
    stage_names = getarraykeys( sidequest.stages );
    
    for ( i = 0; i < stage_names.size ; i++ )
    {
        if ( sidequest.stages[ stage_names[ i ] ].stage_number == stage_number )
        {
            stage = sidequest.stages[ stage_names[ i ] ];
            break;
        }
    }
    
    return stage;
}

// Namespace zm_sidequests
// Params 3
// Checksum 0x8df06d02, Offset: 0x32f0
// Size: 0x70
function get_damage_trigger( radius, origin, damage_types )
{
    trig = spawn( "trigger_damage", origin, 0, radius, 72 );
    trig thread dam_trigger_thread( damage_types );
    return trig;
}

// Namespace zm_sidequests
// Params 1
// Checksum 0x7b7980ef, Offset: 0x3368
// Size: 0xcc
function dam_trigger_thread( damage_types )
{
    self endon( #"death" );
    damage_type = "NONE";
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, dir, point, mod );
        
        for ( i = 0; i < damage_types.size ; i++ )
        {
            if ( mod == damage_types[ i ] )
            {
                self notify( #"triggered" );
            }
        }
    }
}

// Namespace zm_sidequests
// Params 0
// Checksum 0x7946712f, Offset: 0x3440
// Size: 0x54
function use_trigger_thread()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        self.owner_ent notify( #"triggered", player );
        wait 0.1;
    }
}

// Namespace zm_sidequests
// Params 2
// Checksum 0xa642a7c9, Offset: 0x34a0
// Size: 0x7a
function sidequest_stage_active( sidequest_name, stage_name )
{
    sidequest = level._zombie_sidequests[ sidequest_name ];
    stage = sidequest.stages[ stage_name ];
    
    if ( sidequest.active_stage == stage.stage_number )
    {
        return 1;
    }
    
    return 0;
}

// Namespace zm_sidequests
// Params 1
// Checksum 0xd5f51995, Offset: 0x3528
// Size: 0x178
function sidequest_start_next_stage( sidequest_name )
{
    /#
        if ( !isdefined( level._zombie_sidequests ) )
        {
            println( "<dev string:x572>" + sidequest_name + "<dev string:x267>" );
            return;
        }
        
        if ( !isdefined( level._zombie_sidequests[ sidequest_name ] ) )
        {
            println( "<dev string:x5ac>" + sidequest_name + "<dev string:xf5>" );
            return;
        }
    #/
    
    sidequest = level._zombie_sidequests[ sidequest_name ];
    
    if ( sidequest.sidequest_complete == 1 )
    {
        return;
    }
    
    last_completed = sidequest.last_completed_stage;
    
    if ( last_completed == -1 )
    {
        last_completed = 0;
    }
    else
    {
        last_completed++;
    }
    
    stage = get_sidequest_stage( sidequest, last_completed );
    
    if ( !isdefined( stage ) )
    {
        println( "<dev string:x5e6>" + sidequest_name + "<dev string:x5fd>" + last_completed );
        return;
    }
    
    stage_start( sidequest, stage );
    return stage;
}

// Namespace zm_sidequests
// Params 0
// Checksum 0x99ec1590, Offset: 0x36a8
// Size: 0x4
function main()
{
    
}

// Namespace zm_sidequests
// Params 1
// Checksum 0x86c31be0, Offset: 0x36b8
// Size: 0x13c, Type: bool
function is_facing( facee )
{
    orientation = self getplayerangles();
    forwardvec = anglestoforward( orientation );
    forwardvec2d = ( forwardvec[ 0 ], forwardvec[ 1 ], 0 );
    unitforwardvec2d = vectornormalize( forwardvec2d );
    tofaceevec = facee.origin - self.origin;
    tofaceevec2d = ( tofaceevec[ 0 ], tofaceevec[ 1 ], 0 );
    unittofaceevec2d = vectornormalize( tofaceevec2d );
    dotproduct = vectordot( unitforwardvec2d, unittofaceevec2d );
    return dotproduct > 0.9;
}

// Namespace zm_sidequests
// Params 2
// Checksum 0x8ad29fea, Offset: 0x3800
// Size: 0x18c
function fake_use( notify_string, qualifier_func )
{
    waittillframeend();
    
    while ( !( isdefined( level.disable_print3d_ent ) && level.disable_print3d_ent ) )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        /#
            print3d( self.origin, "<dev string:x613>", ( 0, 255, 0 ), 1 );
        #/
        
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            qualifier_passed = 1;
            
            if ( isdefined( qualifier_func ) )
            {
                qualifier_passed = players[ i ] [[ qualifier_func ]]();
            }
            
            if ( qualifier_passed && distancesquared( self.origin, players[ i ].origin ) < 4096 )
            {
                if ( players[ i ] is_facing( self ) )
                {
                    if ( players[ i ] usebuttonpressed() )
                    {
                        self notify( notify_string, players[ i ] );
                        return;
                    }
                }
            }
        }
        
        wait 0.1;
    }
}

