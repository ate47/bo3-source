#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_craftables;

// Namespace zm_craftables
// Params 0, eflags: 0x2
// Checksum 0x66117b17, Offset: 0x850
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_craftables", &__init__, &__main__, undefined );
}

// Namespace zm_craftables
// Params 0
// Checksum 0xb68c2118, Offset: 0x898
// Size: 0x24
function __init__()
{
    callback::on_finalize_initialization( &set_craftable_clientfield );
}

// Namespace zm_craftables
// Params 0
// Checksum 0x8162ab00, Offset: 0x8c8
// Size: 0x16c
function init()
{
    if ( !isdefined( level.craftable_piece_swap_allowed ) )
    {
        level.craftable_piece_swap_allowed = 1;
    }
    
    zombie_craftables_callbacks = [];
    level.craftablepickups = [];
    level.craftables_crafted = [];
    level.a_uts_craftables = [];
    
    if ( !isdefined( level.craftable_piece_count ) )
    {
        level.craftable_piece_count = 0;
    }
    
    level._effect[ "building_dust" ] = "zombie/fx_crafting_dust_zmb";
    
    if ( isdefined( level.init_craftables ) )
    {
        [[ level.init_craftables ]]();
    }
    
    open_table = spawnstruct();
    open_table.name = "open_table";
    open_table.triggerthink = &opentablecraftable;
    open_table.custom_craftablestub_update_prompt = &open_craftablestub_update_prompt;
    include_zombie_craftable( open_table );
    add_zombie_craftable( "open_table", &"" );
    
    if ( isdefined( level.use_swipe_protection ) )
    {
        callback::on_connect( &craftables_watch_swipes );
    }
}

// Namespace zm_craftables
// Params 0
// Checksum 0x29762d24, Offset: 0xa40
// Size: 0x34
function __main__()
{
    level thread think_craftables();
    
    /#
        level thread run_craftables_devgui();
    #/
}

// Namespace zm_craftables
// Params 0
// Checksum 0x1f4c0898, Offset: 0xa80
// Size: 0x24
function set_craftable_clientfield()
{
    set_piece_count( level.zombie_craftablestubs.size );
}

// Namespace zm_craftables
// Params 1
// Checksum 0xe2226fa, Offset: 0xab0
// Size: 0x130, Type: bool
function anystub_update_prompt( player )
{
    if ( player laststand::player_is_in_laststand() || player zm_utility::in_revive_trigger() )
    {
        self.hint_string = "";
        return false;
    }
    
    if ( isdefined( player.is_drinking ) && player.is_drinking > 0 )
    {
        self.hint_string = "";
        return false;
    }
    
    if ( isdefined( player.screecher_weapon ) )
    {
        self.hint_string = "";
        return false;
    }
    
    initial_current_weapon = player getcurrentweapon();
    current_weapon = zm_weapons::get_nonalternate_weapon( initial_current_weapon );
    
    if ( zm_equipment::is_equipment( current_weapon ) )
    {
        self.hint_string = "";
        return false;
    }
    
    return true;
}

// Namespace zm_craftables
// Params 0
// Checksum 0x1b30ceac, Offset: 0xbe8
// Size: 0x26
function anystub_get_unitrigger_origin()
{
    if ( isdefined( self.origin_parent ) )
    {
        return self.origin_parent.origin;
    }
    
    return self.origin;
}

// Namespace zm_craftables
// Params 1
// Checksum 0x64b823f8, Offset: 0xc18
// Size: 0x64
function anystub_on_spawn_trigger( trigger )
{
    if ( isdefined( self.link_parent ) )
    {
        trigger enablelinkto();
        trigger linkto( self.link_parent );
        trigger setmovingplatformenabled( 1 );
    }
}

// Namespace zm_craftables
// Params 0
// Checksum 0x944dc059, Offset: 0xc88
// Size: 0x200
function craftables_watch_swipes()
{
    self endon( #"disconnect" );
    self notify( #"craftables_watch_swipes" );
    self endon( #"craftables_watch_swipes" );
    
    while ( true )
    {
        self waittill( #"melee_swipe", zombie );
        
        if ( distancesquared( zombie.origin, self.origin ) > zombie.meleeattackdist * zombie.meleeattackdist )
        {
            continue;
        }
        
        trigger = level._unitriggers.trigger_pool[ self getentitynumber() ];
        
        if ( isdefined( trigger ) && isdefined( trigger.stub.piece ) )
        {
            piece = trigger.stub.piece;
            
            if ( !isdefined( piece.damage ) )
            {
                piece.damage = 0;
            }
            
            piece.damage++;
            
            if ( piece.damage > 12 )
            {
                thread zm_equipment::disappear_fx( trigger.stub zm_unitrigger::unitrigger_origin() );
                piece piece_unspawn();
                self zm_stats::increment_client_stat( "cheat_total", 0 );
                
                if ( isalive( self ) )
                {
                    self playlocalsound( level.zmb_laugh_alias );
                }
            }
        }
    }
}

// Namespace zm_craftables
// Params 2
// Checksum 0x1d645e4, Offset: 0xe90
// Size: 0x74
function explosiondamage( damage, pos )
{
    println( "<dev string:x28>" + damage + "<dev string:x41>" + self.name + "<dev string:x4d>" );
    self dodamage( damage, pos );
}

// Namespace zm_craftables
// Params 4
// Checksum 0x341b1e35, Offset: 0xf10
// Size: 0xc4
function make_zombie_craftable_open( str_craftable, str_model, v_angle_offset, v_origin_offset )
{
    assert( isdefined( level.zombie_craftablestubs[ str_craftable ] ), "<dev string:x4f>" + str_craftable + "<dev string:x5a>" );
    s_craftable = level.zombie_craftablestubs[ str_craftable ];
    s_craftable.is_open_table = 1;
    s_craftable.str_model = str_model;
    s_craftable.v_angle_offset = v_angle_offset;
    s_craftable.v_origin_offset = v_origin_offset;
}

// Namespace zm_craftables
// Params 6
// Checksum 0x37c6798d, Offset: 0xfe0
// Size: 0x16a
function add_zombie_craftable( craftable_name, str_to_craft, str_crafting, str_taken, onfullycrafted, need_all_pieces )
{
    if ( !isdefined( level.zombie_include_craftables ) )
    {
        level.zombie_include_craftables = [];
    }
    
    if ( isdefined( level.zombie_include_craftables ) && !isdefined( level.zombie_include_craftables[ craftable_name ] ) )
    {
        return;
    }
    
    if ( isdefined( str_to_craft ) )
    {
    }
    
    if ( isdefined( str_crafting ) )
    {
    }
    
    craftable_struct = level.zombie_include_craftables[ craftable_name ];
    
    if ( !isdefined( level.zombie_craftablestubs ) )
    {
        level.zombie_craftablestubs = [];
    }
    
    craftable_struct.str_to_craft = str_to_craft;
    craftable_struct.str_crafting = str_crafting;
    craftable_struct.str_taken = str_taken;
    craftable_struct.onfullycrafted = onfullycrafted;
    craftable_struct.need_all_pieces = need_all_pieces;
    println( "<dev string:x73>" + craftable_struct.name );
    level.zombie_craftablestubs[ craftable_struct.name ] = craftable_struct;
}

// Namespace zm_craftables
// Params 2
// Checksum 0xd2ca9b18, Offset: 0x1158
// Size: 0x44
function set_hide_model_if_unavailable( craftable_name, hide_when_unavailable )
{
    if ( isdefined( level.zombie_craftablestubs[ craftable_name ] ) )
    {
        level.zombie_craftablestubs[ craftable_name ].hide_when_unavailable = hide_when_unavailable;
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0xc078ac9, Offset: 0x11a8
// Size: 0x56, Type: bool
function get_hide_model_if_unavailable( craftable_name )
{
    if ( isdefined( level.zombie_craftablestubs[ craftable_name ] ) )
    {
        return ( isdefined( level.zombie_craftablestubs[ craftable_name ].hide_when_unavailable ) && level.zombie_craftablestubs[ craftable_name ].hide_when_unavailable );
    }
    
    return false;
}

// Namespace zm_craftables
// Params 2
// Checksum 0xd0a73503, Offset: 0x1208
// Size: 0x44
function set_build_time( craftable_name, build_time )
{
    if ( isdefined( level.zombie_craftablestubs[ craftable_name ] ) )
    {
        level.zombie_craftablestubs[ craftable_name ].usetime = build_time;
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0x3cefed7, Offset: 0x1258
// Size: 0x64
function set_piece_count( n_count )
{
    bits = getminbitcountfornum( n_count );
    registerclientfield( "toplayer", "craftable", 1, bits, "int" );
}

// Namespace zm_craftables
// Params 2
// Checksum 0xaf93c7e3, Offset: 0x12c8
// Size: 0x40
function add_zombie_craftable_vox_category( craftable_name, vox_id )
{
    craftable_struct = level.zombie_include_craftables[ craftable_name ];
    craftable_struct.vox_id = vox_id;
}

// Namespace zm_craftables
// Params 1
// Checksum 0x3799bdb7, Offset: 0x1310
// Size: 0xd4
function include_zombie_craftable( craftablestub )
{
    if ( !isdefined( level.zombie_include_craftables ) )
    {
        level.zombie_include_craftables = [];
    }
    
    if ( !isdefined( level.craftableindex ) )
    {
        level.craftableindex = 0;
    }
    
    println( "<dev string:x92>" + craftablestub.name );
    level.zombie_include_craftables[ craftablestub.name ] = craftablestub;
    craftablestub.hash_id = hashstring( craftablestub.name );
    
    /#
        level thread add_craftable_cheat( craftablestub );
    #/
}

// Namespace zm_craftables
// Params 18
// Checksum 0x9b3c5d7, Offset: 0x13f0
// Size: 0x46c
function generate_zombie_craftable_piece( craftablename, piecename, radius, height, drop_offset, hud_icon, onpickup, ondrop, oncrafted, use_spawn_num, tag_name, can_reuse, client_field_value, is_shared, vox_id, b_one_time_vo, hint_string, slot )
{
    if ( !isdefined( is_shared ) )
    {
        is_shared = 0;
    }
    
    if ( !isdefined( b_one_time_vo ) )
    {
        b_one_time_vo = 0;
    }
    
    if ( !isdefined( slot ) )
    {
        slot = 0;
    }
    
    piecestub = spawnstruct();
    craftable_pieces = [];
    
    if ( !isdefined( piecename ) )
    {
        assertmsg( "<dev string:xaf>" );
    }
    
    craftable_pieces_structs = struct::get_array( craftablename + "_" + piecename, "targetname" );
    
    if ( !isdefined( level.craftablepieceindex ) )
    {
        level.craftablepieceindex = 0;
    }
    
    foreach ( index, struct in craftable_pieces_structs )
    {
        craftable_pieces[ index ] = struct;
        craftable_pieces[ index ].hasspawned = 0;
    }
    
    piecestub.spawns = craftable_pieces;
    piecestub.craftablename = craftablename;
    piecestub.piecename = piecename;
    
    if ( craftable_pieces.size )
    {
        piecestub.modelname = craftable_pieces[ 0 ].model;
    }
    
    piecestub.hud_icon = hud_icon;
    piecestub.radius = radius;
    piecestub.height = height;
    piecestub.tag_name = tag_name;
    piecestub.can_reuse = can_reuse;
    piecestub.drop_offset = drop_offset;
    piecestub.max_instances = 256;
    piecestub.onpickup = onpickup;
    piecestub.ondrop = ondrop;
    piecestub.oncrafted = oncrafted;
    piecestub.use_spawn_num = use_spawn_num;
    piecestub.is_shared = is_shared;
    piecestub.vox_id = vox_id;
    piecestub.hint_string = hint_string;
    piecestub.inventory_slot = slot;
    piecestub.hash_id = hashstring( piecename );
    
    if ( isdefined( b_one_time_vo ) && b_one_time_vo )
    {
        piecestub.b_one_time_vo = b_one_time_vo;
    }
    
    if ( isdefined( client_field_value ) )
    {
        if ( isdefined( is_shared ) && is_shared )
        {
            assert( isstring( client_field_value ), "<dev string:xdd>" + piecename + "<dev string:x102>" );
            piecestub.client_field_id = client_field_value;
        }
        else
        {
            piecestub.client_field_state = client_field_value;
        }
    }
    
    return piecestub;
}

// Namespace zm_craftables
// Params 1
// Checksum 0xa9017466, Offset: 0x1868
// Size: 0x30
function manage_multiple_pieces( max_instances )
{
    self.max_instances = max_instances;
    self.managing_pieces = 1;
    self.piece_allocated = [];
}

// Namespace zm_craftables
// Params 3
// Checksum 0x2730d066, Offset: 0x18a0
// Size: 0x138
function combine_craftable_pieces( piece1, piece2, piece3 )
{
    spawns1 = piece1.spawns;
    spawns2 = piece2.spawns;
    spawns = arraycombine( spawns1, spawns2, 1, 0 );
    
    if ( isdefined( piece3 ) )
    {
        spawns3 = piece3.spawns;
        spawns = arraycombine( spawns, spawns3, 1, 0 );
        spawns = array::randomize( spawns );
        piece3.spawns = spawns;
    }
    else
    {
        spawns = array::randomize( spawns );
    }
    
    piece1.spawns = spawns;
    piece2.spawns = spawns;
}

// Namespace zm_craftables
// Params 3
// Checksum 0xe6cdc6a1, Offset: 0x19e0
// Size: 0xe4
function add_craftable_piece( piecestub, tag_name, can_reuse )
{
    if ( !isdefined( self.a_piecestubs ) )
    {
        self.a_piecestubs = [];
    }
    
    if ( isdefined( tag_name ) )
    {
        piecestub.tag_name = tag_name;
    }
    
    if ( isdefined( can_reuse ) )
    {
        piecestub.can_reuse = can_reuse;
    }
    
    self.a_piecestubs[ self.a_piecestubs.size ] = piecestub;
    
    if ( !isdefined( self.inventory_slot ) )
    {
        self.inventory_slot = piecestub.inventory_slot;
    }
    
    assert( self.inventory_slot == piecestub.inventory_slot, "<dev string:x13c>" );
}

// Namespace zm_craftables
// Params 1
// Checksum 0x1d4e0cac, Offset: 0x1ad0
// Size: 0x3c
function player_drop_piece_on_downed( slot )
{
    self endon( "craftable_piece_released" + slot );
    self waittill( #"bled_out" );
    onplayerlaststand();
}

// Namespace zm_craftables
// Params 0
// Checksum 0x82446e2d, Offset: 0x1b18
// Size: 0x19a
function onplayerlaststand()
{
    if ( !isdefined( self.current_craftable_pieces ) )
    {
        self.current_craftable_pieces = [];
    }
    
    foreach ( index, piece in self.current_craftable_pieces )
    {
        if ( isdefined( piece ) )
        {
            return_to_start_pos = 0;
            
            if ( isdefined( level.safe_place_for_craftable_piece ) )
            {
                if ( !self [[ level.safe_place_for_craftable_piece ]]( piece ) )
                {
                    return_to_start_pos = 1;
                }
            }
            
            if ( return_to_start_pos )
            {
                piece piece_spawn_at();
            }
            else
            {
                piece piece_spawn_at( self.origin + ( 5, 5, 0 ), self.angles );
            }
            
            if ( isdefined( piece.ondrop ) )
            {
                piece [[ piece.ondrop ]]( self );
            }
            
            self clientfield::set_to_player( "craftable", 0 );
        }
        
        self.current_craftable_pieces[ index ] = undefined;
        self notify( "craftable_piece_released" + index );
    }
}

// Namespace zm_craftables
// Params 0
// Checksum 0xe1ec01dd, Offset: 0x1cc0
// Size: 0x36
function piecestub_get_unitrigger_origin()
{
    if ( isdefined( self.origin_parent ) )
    {
        return ( self.origin_parent.origin + ( 0, 0, 12 ) );
    }
    
    return self.origin;
}

// Namespace zm_craftables
// Params 9
// Checksum 0x2b49f85c, Offset: 0x1d00
// Size: 0x3d0
function generate_piece_unitrigger( classname, origin, angles, flags, radius, script_height, hint_string, moving, b_nolook )
{
    if ( !isdefined( radius ) )
    {
        radius = 64;
    }
    
    if ( !isdefined( script_height ) )
    {
        script_height = 64;
    }
    
    script_width = script_height;
    
    if ( !isdefined( script_width ) )
    {
        script_width = 64;
    }
    
    script_length = script_height;
    
    if ( !isdefined( script_length ) )
    {
        script_length = 64;
    }
    
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = origin;
    
    if ( isdefined( script_length ) )
    {
        unitrigger_stub.script_length = script_length;
    }
    else
    {
        unitrigger_stub.script_length = 13.5;
    }
    
    if ( isdefined( script_width ) )
    {
        unitrigger_stub.script_width = script_width;
    }
    else
    {
        unitrigger_stub.script_width = 27.5;
    }
    
    if ( isdefined( script_height ) )
    {
        unitrigger_stub.script_height = script_height;
    }
    else
    {
        unitrigger_stub.script_height = 24;
    }
    
    unitrigger_stub.radius = radius;
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    
    if ( isdefined( hint_string ) )
    {
        unitrigger_stub.hint_string_override = hint_string;
        unitrigger_stub.hint_string = unitrigger_stub.hint_string_override;
    }
    else
    {
        unitrigger_stub.hint_string = &"ZOMBIE_BUILD_PIECE_GRAB";
    }
    
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    
    if ( isdefined( int( b_nolook ) ) && isdefined( b_nolook ) && int( b_nolook ) )
    {
        unitrigger_stub.require_look_toward = 0;
    }
    
    unitrigger_stub.require_look_at = 0;
    
    switch ( classname )
    {
        case "trigger_radius":
            unitrigger_stub.script_unitrigger_type = "unitrigger_radius";
            break;
        default:
            unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
            break;
        case "trigger_box":
            unitrigger_stub.script_unitrigger_type = "unitrigger_box";
            break;
        case "trigger_box_use":
            unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
            break;
    }
    
    zm_unitrigger::unitrigger_force_per_player_triggers( unitrigger_stub, 1 );
    unitrigger_stub.prompt_and_visibility_func = &piecetrigger_update_prompt;
    unitrigger_stub.originfunc = &piecestub_get_unitrigger_origin;
    unitrigger_stub.onspawnfunc = &anystub_on_spawn_trigger;
    
    if ( isdefined( moving ) && moving )
    {
        zm_unitrigger::register_unitrigger( unitrigger_stub, &piece_unitrigger_think );
    }
    else
    {
        zm_unitrigger::register_static_unitrigger( unitrigger_stub, &piece_unitrigger_think );
    }
    
    return unitrigger_stub;
}

// Namespace zm_craftables
// Params 1
// Checksum 0x5092700a, Offset: 0x20d8
// Size: 0xa0
function piecetrigger_update_prompt( player )
{
    if ( !isdefined( player.current_craftable_pieces ) )
    {
        player.current_craftable_pieces = [];
    }
    
    can_use = self.stub piecestub_update_prompt( player );
    self setinvisibletoplayer( player, !can_use );
    self sethintstring( self.stub.hint_string );
    return can_use;
}

// Namespace zm_craftables
// Params 2
// Checksum 0xcd12df50, Offset: 0x2180
// Size: 0x1a4, Type: bool
function piecestub_update_prompt( player, slot )
{
    if ( !isdefined( slot ) )
    {
        slot = self.piece.inventory_slot;
    }
    
    if ( !self anystub_update_prompt( player ) )
    {
        return false;
    }
    
    if ( isdefined( player.current_craftable_pieces[ slot ] ) && !( isdefined( self.piece.is_shared ) && self.piece.is_shared ) )
    {
        if ( !level.craftable_piece_swap_allowed )
        {
            self.hint_string = &"ZOMBIE_CRAFTABLE_NO_SWITCH";
        }
        else
        {
            spiece = self.piece;
            cpiece = player.current_craftable_pieces[ slot ];
            
            if ( spiece.piecename == cpiece.piecename && spiece.craftablename == cpiece.craftablename )
            {
                self.hint_string = "";
                return false;
            }
            
            if ( isdefined( self.hint_string_override ) )
            {
                self.hint_string = self.hint_string_override;
            }
            else
            {
                self.hint_string = &"ZOMBIE_BUILD_PIECE_SWITCH";
            }
        }
    }
    else if ( isdefined( self.hint_string_override ) )
    {
        self.hint_string = self.hint_string_override;
    }
    else
    {
        self.hint_string = &"ZOMBIE_BUILD_PIECE_GRAB";
    }
    
    return true;
}

// Namespace zm_craftables
// Params 0
// Checksum 0xf3c80829, Offset: 0x2330
// Size: 0x1d8
function piece_unitrigger_think()
{
    self endon( #"kill_trigger" );
    slot = self.stub.piece.inventory_slot;
    
    while ( true )
    {
        self waittill( #"trigger", player );
        self.stub notify( #"trigger", player );
        
        if ( player != self.parent_player )
        {
            continue;
        }
        
        if ( isdefined( player.screecher_weapon ) )
        {
            continue;
        }
        
        if ( !level.craftable_piece_swap_allowed && isdefined( player.current_craftable_pieces[ slot ] ) && !( isdefined( self.stub.piece.is_shared ) && self.stub.piece.is_shared ) )
        {
            continue;
        }
        
        if ( !zm_utility::is_player_valid( player ) )
        {
            player thread zm_utility::ignore_triggers( 0.5 );
            continue;
        }
        
        status = player player_can_take_piece( self.stub.piece );
        
        if ( !status )
        {
            self.stub.hint_string = "";
            self sethintstring( self.stub.hint_string );
            continue;
        }
        
        player thread player_take_piece( self.stub.piece );
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0xecef8bfb, Offset: 0x2510
// Size: 0x1e, Type: bool
function player_can_take_piece( piece )
{
    if ( !isdefined( piece ) )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace zm_craftables
    // Params 2
    // Checksum 0xda0d3809, Offset: 0x2538
    // Size: 0x7c, Type: dev
    function dbline( from, to )
    {
        time = 20;
        
        while ( time > 0 )
        {
            line( from, to, ( 0, 0, 1 ), 0, 1 );
            time -= 0.05;
            wait 0.05;
        }
    }

#/

// Namespace zm_craftables
// Params 6
// Checksum 0xeb918051, Offset: 0x25c0
// Size: 0x394
function player_throw_piece( piece, origin, dir, return_to_spawn, return_time, endangles )
{
    assert( isdefined( piece ) );
    
    if ( isdefined( piece ) )
    {
        /#
            thread dbline( origin, origin + dir );
        #/
        
        pass = 0;
        done = 0;
        altmodel = undefined;
        
        while ( pass < 2 && !done )
        {
            grenade = self magicgrenadetype( "buildable_piece", origin, dir, 30000 );
            grenade thread watch_hit_players();
            grenade ghost();
            
            if ( !isdefined( altmodel ) )
            {
                altmodel = spawn( "script_model", grenade.origin );
                altmodel setmodel( piece.modelname );
            }
            
            altmodel.origin = grenade.angles;
            altmodel.angles = grenade.angles;
            altmodel linkto( grenade, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            grenade.altmodel = altmodel;
            grenade waittill( #"stationary" );
            grenade_origin = grenade.origin;
            grenade_angles = grenade.angles;
            landed_on = grenade getgroundent();
            grenade delete();
            
            if ( isdefined( landed_on ) && landed_on == level )
            {
                done = 1;
                continue;
            }
            
            origin = grenade_origin;
            dir = ( dir[ 0 ] * -1 / 10, dir[ 1 ] * -1 / 10, -1 );
            pass++;
        }
        
        if ( !isdefined( endangles ) )
        {
            endangles = grenade_angles;
        }
        
        piece piece_spawn_at( grenade_origin, endangles );
        
        if ( isdefined( altmodel ) )
        {
            altmodel delete();
        }
        
        if ( isdefined( piece.ondrop ) )
        {
            piece [[ piece.ondrop ]]( self );
        }
        
        if ( isdefined( return_to_spawn ) && return_to_spawn )
        {
            piece piece_wait_and_return( return_time );
        }
    }
}

// Namespace zm_craftables
// Params 0
// Checksum 0xce2ec3fd, Offset: 0x2960
// Size: 0x90
function watch_hit_players()
{
    self endon( #"death" );
    self endon( #"stationary" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"grenade_bounce", pos, normal, ent );
        
        if ( isplayer( ent ) )
        {
            ent explosiondamage( 25, pos );
        }
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0xbe217048, Offset: 0x29f8
// Size: 0x164
function piece_wait_and_return( return_time )
{
    self endon( #"pickup" );
    wait 0.15;
    
    if ( isdefined( level.exploding_jetgun_fx ) )
    {
        playfxontag( level.exploding_jetgun_fx, self.model, "tag_origin" );
    }
    else
    {
        playfxontag( level._effect[ "powerup_on" ], self.model, "tag_origin" );
    }
    
    wait return_time - 6;
    self piece_hide();
    wait 1;
    self piece_show();
    wait 1;
    self piece_hide();
    wait 1;
    self piece_show();
    wait 1;
    self piece_hide();
    wait 1;
    self piece_show();
    wait 1;
    self notify( #"respawn" );
    self piece_unspawn();
    self piece_spawn_at();
}

// Namespace zm_craftables
// Params 1
// Checksum 0x78ac59a5, Offset: 0x2b68
// Size: 0x9c
function player_return_piece_to_original_spawn( slot )
{
    if ( !isdefined( slot ) )
    {
        slot = 0;
    }
    
    self notify( "craftable_piece_released" + slot );
    piece = self.current_craftable_pieces[ slot ];
    self.current_craftable_pieces[ slot ] = undefined;
    
    if ( isdefined( piece ) )
    {
        piece piece_spawn_at();
        self clientfield::set_to_player( "craftable", 0 );
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0x713090f2, Offset: 0x2c10
// Size: 0x134
function player_drop_piece_on_death( slot )
{
    if ( !isdefined( slot ) )
    {
        slot = 0;
    }
    
    self notify( "craftable_piece_released" + slot );
    self endon( "craftable_piece_released" + slot );
    self thread player_drop_piece_on_downed( slot );
    origin = self.origin;
    angles = self.angles;
    piece = self.current_craftable_pieces[ slot ];
    
    if ( isdefined( piece ) && isdefined( piece.start_origin ) )
    {
        origin = piece.start_origin;
        angles = piece.start_angles;
    }
    
    self waittill( #"disconnect" );
    piece piece_spawn_at( origin, angles );
    
    if ( isdefined( self ) )
    {
        self clientfield::set_to_player( "craftable", 0 );
    }
}

// Namespace zm_craftables
// Params 2
// Checksum 0xa99deb56, Offset: 0x2d50
// Size: 0xe4
function player_drop_piece( piece, slot )
{
    if ( !isdefined( piece ) )
    {
        piece = self.current_craftable_pieces[ slot ];
    }
    
    if ( isdefined( piece ) )
    {
        piece.damage = 0;
        piece piece_spawn_at( self.origin, self.angles );
        self clientfield::set_to_player( "craftable", 0 );
        
        if ( isdefined( piece.ondrop ) )
        {
            piece [[ piece.ondrop ]]( self );
        }
    }
    
    self.current_craftable_pieces[ slot ] = undefined;
    self notify( "craftable_piece_released" + slot );
}

// Namespace zm_craftables
// Params 1
// Checksum 0x17d5f1b5, Offset: 0x2e40
// Size: 0x2cc
function player_take_piece( piecespawn )
{
    piecestub = piecespawn.piecestub;
    slot = piecestub.inventory_slot;
    damage = piecespawn.damage;
    
    if ( !isdefined( self.current_craftable_pieces ) )
    {
        self.current_craftable_pieces = [];
    }
    
    self notify( "player_got_craftable_piece_for_" + piecespawn.craftablename );
    
    if ( !( isdefined( piecestub.is_shared ) && piecestub.is_shared ) && isdefined( self.current_craftable_pieces[ slot ] ) )
    {
        other_piece = self.current_craftable_pieces[ slot ];
        self player_drop_piece( self.current_craftable_piece, slot );
        other_piece.damage = damage;
        self zm_utility::do_player_general_vox( "general", "craft_swap" );
    }
    
    if ( isdefined( piecestub.onpickup ) )
    {
        piecespawn [[ piecestub.onpickup ]]( self );
    }
    
    if ( isdefined( piecestub.is_shared ) && piecestub.is_shared )
    {
        if ( isdefined( piecestub.client_field_id ) )
        {
            level clientfield::set( piecestub.client_field_id, 1 );
        }
    }
    else if ( isdefined( piecestub.client_field_state ) )
    {
        self clientfield::set_to_player( "craftable", piecestub.client_field_state );
    }
    
    piecespawn piece_unspawn();
    piecespawn notify( #"pickup" );
    
    if ( isdefined( piecestub.is_shared ) && piecestub.is_shared )
    {
        piecespawn.in_shared_inventory = 1;
    }
    else
    {
        slot = piecespawn.inventory_slot;
        self.current_craftable_pieces[ slot ] = piecespawn;
        self thread player_drop_piece_on_death( slot );
    }
    
    self track_craftable_piece_pickedup( piecespawn );
}

// Namespace zm_craftables
// Params 2
// Checksum 0x6c578a7, Offset: 0x3118
// Size: 0x7c
function player_destroy_piece( piece, slot )
{
    if ( !isdefined( piece ) )
    {
        piece = self.current_craftable_pieces[ slot ];
    }
    
    if ( isdefined( piece ) )
    {
        self clientfield::set_to_player( "craftable", 0 );
    }
    
    self.current_craftable_pieces[ slot ] = undefined;
    self notify( "craftable_piece_released" + slot );
}

// Namespace zm_craftables
// Params 1
// Checksum 0x47112aa6, Offset: 0x31a0
// Size: 0x52, Type: bool
function claim_location( location )
{
    if ( !isdefined( level.craftable_claimed_locations ) )
    {
        level.craftable_claimed_locations = [];
    }
    
    if ( !isdefined( level.craftable_claimed_locations[ location ] ) )
    {
        level.craftable_claimed_locations[ location ] = 1;
        return true;
    }
    
    return false;
}

// Namespace zm_craftables
// Params 1
// Checksum 0xbe93cabb, Offset: 0x3200
// Size: 0x182, Type: bool
function is_point_in_craft_trigger( point )
{
    candidate_list = [];
    
    foreach ( zone in level.zones )
    {
        if ( isdefined( zone.unitrigger_stubs ) )
        {
            candidate_list = arraycombine( candidate_list, zone.unitrigger_stubs, 1, 0 );
        }
    }
    
    valid_range = 128;
    closest = zm_unitrigger::get_closest_unitriggers( point, candidate_list, valid_range );
    
    for ( index = 0; index < closest.size ; index++ )
    {
        if ( isdefined( closest[ index ].registered ) && closest[ index ].registered && isdefined( closest[ index ].piece ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_craftables
// Params 1
// Checksum 0x2008be12, Offset: 0x3390
// Size: 0x2ce
function piece_allocate_spawn( piecestub )
{
    self.current_spawn = 0;
    self.managed_spawn = 1;
    self.piecestub = piecestub;
    
    if ( self.spawns.size >= 1 && self.spawns.size > 1 )
    {
        any_good = 0;
        any_okay = 0;
        totalweight = 0;
        spawnweights = [];
        
        for ( i = 0; i < self.spawns.size ; i++ )
        {
            if ( isdefined( piecestub.piece_allocated[ i ] ) && piecestub.piece_allocated[ i ] )
            {
                spawnweights[ i ] = 0;
            }
            else if ( is_point_in_craft_trigger( self.spawns[ i ].origin ) )
            {
                any_okay = 1;
                spawnweights[ i ] = 0.01;
            }
            else
            {
                any_good = 1;
                spawnweights[ i ] = 1;
            }
            
            totalweight += spawnweights[ i ];
        }
        
        assert( any_good || any_okay, "<dev string:x17b>" );
        
        if ( any_good )
        {
            totalweight = float( int( totalweight ) );
        }
        
        r = randomfloat( totalweight );
        
        for ( i = 0; i < self.spawns.size ; i++ )
        {
            if ( !any_good || spawnweights[ i ] >= 1 )
            {
                r -= spawnweights[ i ];
                
                if ( r < 0 )
                {
                    self.current_spawn = i;
                    piecestub.piece_allocated[ self.current_spawn ] = 1;
                    return;
                }
            }
        }
        
        self.current_spawn = randomint( self.spawns.size );
        piecestub.piece_allocated[ self.current_spawn ] = 1;
    }
}

// Namespace zm_craftables
// Params 0
// Checksum 0x89126b67, Offset: 0x3668
// Size: 0x3e
function piece_deallocate_spawn()
{
    if ( isdefined( self.current_spawn ) )
    {
        self.piecestub.piece_allocated[ self.current_spawn ] = 0;
        self.current_spawn = undefined;
    }
    
    self.start_origin = undefined;
}

// Namespace zm_craftables
// Params 0
// Checksum 0x558fc31e, Offset: 0x36b0
// Size: 0x138
function piece_pick_random_spawn()
{
    self.current_spawn = 0;
    
    if ( self.spawns.size >= 1 && self.spawns.size > 1 )
    {
        self.current_spawn = randomint( self.spawns.size );
        
        while ( isdefined( self.spawns[ self.current_spawn ].claim_location ) && !claim_location( self.spawns[ self.current_spawn ].claim_location ) )
        {
            arrayremoveindex( self.spawns, self.current_spawn );
            
            if ( self.spawns.size < 1 )
            {
                self.current_spawn = 0;
                println( "<dev string:x1a0>" );
                return;
            }
            
            self.current_spawn = randomint( self.spawns.size );
        }
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0x6b059a5e, Offset: 0x37f0
// Size: 0x7c
function piece_set_spawn( num )
{
    self.current_spawn = 0;
    
    if ( self.spawns.size >= 1 && self.spawns.size > 1 )
    {
        self.current_spawn = int( min( num, self.spawns.size - 1 ) );
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0xd2fc450e, Offset: 0x3878
// Size: 0x368
function piece_spawn_in( piecestub )
{
    if ( self.spawns.size < 1 )
    {
        return;
    }
    
    if ( isdefined( self.managed_spawn ) && self.managed_spawn )
    {
        if ( !isdefined( self.current_spawn ) )
        {
            self piece_allocate_spawn( self.piecestub );
        }
    }
    
    if ( !isdefined( self.current_spawn ) )
    {
        self.current_spawn = 0;
    }
    
    spawndef = self.spawns[ self.current_spawn ];
    self.unitrigger = generate_piece_unitrigger( "trigger_radius_use", spawndef.origin + ( 0, 0, 12 ), spawndef.angles, 0, piecestub.radius, piecestub.height, piecestub.hint_string, 0, spawndef.script_string );
    self.unitrigger.piece = self;
    self.radius = piecestub.radius;
    self.height = piecestub.height;
    self.craftablename = piecestub.craftablename;
    self.piecename = piecestub.piecename;
    self.modelname = piecestub.modelname;
    self.hud_icon = piecestub.hud_icon;
    self.tag_name = piecestub.tag_name;
    self.drop_offset = piecestub.drop_offset;
    self.start_origin = spawndef.origin;
    self.start_angles = spawndef.angles;
    self.client_field_state = piecestub.client_field_state;
    self.is_shared = piecestub.is_shared;
    self.inventory_slot = piecestub.inventory_slot;
    self.model = spawn( "script_model", self.start_origin );
    
    if ( isdefined( self.start_angles ) )
    {
        self.model.angles = self.start_angles;
    }
    
    self.model setmodel( piecestub.modelname );
    
    if ( isdefined( piecestub.onspawn ) )
    {
        self [[ piecestub.onspawn ]]();
    }
    
    self.model ghostindemo();
    self.model.hud_icon = piecestub.hud_icon;
    self.piecestub = piecestub;
    self.unitrigger.origin_parent = self.model;
}

// Namespace zm_craftables
// Params 3
// Checksum 0x89086e18, Offset: 0x3be8
// Size: 0x3e8
function piece_spawn_at( origin, angles, use_random_start )
{
    if ( self.spawns.size < 1 )
    {
        return;
    }
    
    if ( isdefined( self.managed_spawn ) && self.managed_spawn )
    {
        if ( !isdefined( self.current_spawn ) && !isdefined( origin ) )
        {
            self piece_allocate_spawn( self.piecestub );
            spawndef = self.spawns[ self.current_spawn ];
            self.start_origin = spawndef.origin;
            self.start_angles = spawndef.angles;
        }
    }
    else if ( !isdefined( self.current_spawn ) )
    {
        self.current_spawn = 0;
    }
    
    unitrigger_offset = ( 0, 0, 12 );
    
    if ( isdefined( use_random_start ) && use_random_start )
    {
        self piece_pick_random_spawn();
        spawndef = self.spawns[ self.current_spawn ];
        self.start_origin = spawndef.origin;
        self.start_angles = spawndef.angles;
        origin = spawndef.origin;
        angles = spawndef.angles;
    }
    else
    {
        if ( !isdefined( origin ) )
        {
            origin = self.start_origin;
        }
        else
        {
            origin += ( 0, 0, self.drop_offset );
            unitrigger_offset -= ( 0, 0, self.drop_offset );
        }
        
        if ( !isdefined( angles ) )
        {
            angles = self.start_angles;
        }
        
        /#
            if ( !isdefined( level.drop_offset ) )
            {
                level.drop_offset = 0;
            }
            
            origin += ( 0, 0, level.drop_offset );
            unitrigger_offset -= ( 0, 0, level.drop_offset );
        #/
    }
    
    self.model = spawn( "script_model", origin );
    
    if ( isdefined( angles ) )
    {
        self.model.angles = angles;
    }
    
    self.model setmodel( self.modelname );
    
    if ( isdefined( level.equipment_safe_to_drop ) )
    {
        if ( ![[ level.equipment_safe_to_drop ]]( self.model ) )
        {
            origin = self.start_origin;
            angles = self.start_angles;
            self.model.origin = origin;
            self.model.angles = angles;
        }
    }
    
    if ( isdefined( self.onspawn ) )
    {
        self [[ self.onspawn ]]();
    }
    
    self.unitrigger = generate_piece_unitrigger( "trigger_radius_use", origin + unitrigger_offset, angles, 0, self.radius, self.height, self.piecestub.hint_string, isdefined( self.model.canmove ) && self.model.canmove );
    self.unitrigger.piece = self;
    self.model.hud_icon = self.hud_icon;
    self.unitrigger.origin_parent = self.model;
}

// Namespace zm_craftables
// Params 0
// Checksum 0x647030c0, Offset: 0x3fd8
// Size: 0x8e
function piece_unspawn()
{
    if ( isdefined( self.managed_spawn ) && self.managed_spawn )
    {
        self piece_deallocate_spawn();
    }
    
    if ( isdefined( self.model ) )
    {
        self.model delete();
    }
    
    self.model = undefined;
    
    if ( isdefined( self.unitrigger ) )
    {
        thread zm_unitrigger::unregister_unitrigger( self.unitrigger );
    }
    
    self.unitrigger = undefined;
}

// Namespace zm_craftables
// Params 0
// Checksum 0x880d7b83, Offset: 0x4070
// Size: 0x2c
function piece_hide()
{
    if ( isdefined( self.model ) )
    {
        self.model ghost();
    }
}

// Namespace zm_craftables
// Params 0
// Checksum 0x6f0d7fec, Offset: 0x40a8
// Size: 0x2c
function piece_show()
{
    if ( isdefined( self.model ) )
    {
        self.model show();
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0xbec06037, Offset: 0x40e0
// Size: 0x22c
function generate_piece( piecestub )
{
    piecespawn = spawnstruct();
    piecespawn.spawns = piecestub.spawns;
    
    if ( isdefined( piecestub.managing_pieces ) && piecestub.managing_pieces )
    {
        piecespawn piece_allocate_spawn( piecestub );
    }
    else if ( isdefined( piecestub.use_spawn_num ) )
    {
        piecespawn piece_set_spawn( piecestub.use_spawn_num );
    }
    else
    {
        piecespawn piece_pick_random_spawn();
    }
    
    if ( isdefined( piecestub.special_spawn_func ) )
    {
        piecespawn [[ piecestub.special_spawn_func ]]( piecestub );
    }
    else
    {
        piecespawn piece_spawn_in( piecestub );
    }
    
    if ( piecespawn.spawns.size >= 1 )
    {
        piecespawn.hud_icon = piecestub.hud_icon;
    }
    
    if ( isdefined( piecestub.onpickup ) )
    {
        piecespawn.onpickup = piecestub.onpickup;
    }
    else
    {
        piecespawn.onpickup = &onpickuputs;
    }
    
    if ( isdefined( piecestub.ondrop ) )
    {
        piecespawn.ondrop = piecestub.ondrop;
    }
    else
    {
        piecespawn.ondrop = &ondroputs;
    }
    
    if ( isdefined( piecestub.oncrafted ) )
    {
        piecespawn.oncrafted = piecestub.oncrafted;
    }
    
    return piecespawn;
}

// Namespace zm_craftables
// Params 2
// Checksum 0xa183902e, Offset: 0x4318
// Size: 0x32c
function craftable_piece_unitriggers( craftable_name, origin )
{
    assert( isdefined( craftable_name ) );
    assert( isdefined( level.zombie_craftablestubs[ craftable_name ] ), "<dev string:x1cd>" + craftable_name );
    craftable = level.zombie_craftablestubs[ craftable_name ];
    
    if ( !isdefined( craftable.a_piecestubs ) )
    {
        craftable.a_piecestubs = [];
    }
    
    level flag::wait_till( "start_zombie_round_logic" );
    craftablespawn = spawnstruct();
    craftablespawn.craftable_name = craftable_name;
    
    if ( !isdefined( craftablespawn.a_piecespawns ) )
    {
        craftablespawn.a_piecespawns = [];
    }
    
    craftablepickups = [];
    
    foreach ( piecestub in craftable.a_piecestubs )
    {
        if ( !isdefined( craftablespawn.inventory_slot ) )
        {
            craftablespawn.inventory_slot = piecestub.inventory_slot;
        }
        
        assert( craftablespawn.inventory_slot == piecestub.inventory_slot, "<dev string:x13c>" );
        
        if ( !isdefined( piecestub.generated_instances ) )
        {
            piecestub.generated_instances = 0;
        }
        
        if ( isdefined( piecestub.can_reuse ) && isdefined( piecestub.piecespawn ) && piecestub.can_reuse )
        {
            piece = piecestub.piecespawn;
        }
        else if ( piecestub.generated_instances >= piecestub.max_instances )
        {
            piece = piecestub.piecespawn;
        }
        else
        {
            piece = generate_piece( piecestub );
            piecestub.piecespawn = piece;
            piecestub.generated_instances++;
        }
        
        craftablespawn.a_piecespawns[ craftablespawn.a_piecespawns.size ] = piece;
    }
    
    craftablespawn.stub = self;
    return craftablespawn;
}

// Namespace zm_craftables
// Params 1
// Checksum 0xe23e7e74, Offset: 0x4650
// Size: 0xc4
function hide_craftable_table_model( trigger_targetname )
{
    trig = getent( trigger_targetname, "targetname" );
    
    if ( !isdefined( trig ) )
    {
        return;
    }
    
    if ( isdefined( trig.target ) )
    {
        model = getent( trig.target, "targetname" );
        
        if ( isdefined( model ) )
        {
            model ghost();
            model notsolid();
        }
    }
}

// Namespace zm_craftables
// Params 6
// Checksum 0x3edb7e66, Offset: 0x4720
// Size: 0x92
function setup_unitrigger_craftable( trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent )
{
    trig = getent( trigger_targetname, "targetname" );
    
    if ( !isdefined( trig ) )
    {
        return;
    }
    
    return setup_unitrigger_craftable_internal( trig, equipname, weaponname, trigger_hintstring, delete_trigger, persistent );
}

// Namespace zm_craftables
// Params 6
// Checksum 0xe0edc495, Offset: 0x47c0
// Size: 0x11a
function setup_unitrigger_craftable_array( trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent )
{
    triggers = getentarray( trigger_targetname, "targetname" );
    stubs = [];
    
    foreach ( trig in triggers )
    {
        stubs[ stubs.size ] = setup_unitrigger_craftable_internal( trig, equipname, weaponname, trigger_hintstring, delete_trigger, persistent );
    }
    
    return stubs;
}

// Namespace zm_craftables
// Params 6
// Checksum 0xe534b9b, Offset: 0x48e8
// Size: 0x9be
function setup_unitrigger_craftable_internal( trig, equipname, weaponname, trigger_hintstring, delete_trigger, persistent )
{
    if ( !isdefined( trig ) )
    {
        return;
    }
    
    unitrigger_stub = spawnstruct();
    unitrigger_stub.craftablestub = level.zombie_include_craftables[ equipname ];
    angles = trig.script_angles;
    
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    unitrigger_stub.origin = trig.origin + anglestoright( angles ) * -6;
    unitrigger_stub.angles = trig.angles;
    
    if ( isdefined( trig.script_angles ) )
    {
        unitrigger_stub.angles = trig.script_angles;
    }
    
    unitrigger_stub.equipname = equipname;
    unitrigger_stub.weaponname = getweapon( weaponname );
    unitrigger_stub.trigger_hintstring = trigger_hintstring;
    unitrigger_stub.delete_trigger = delete_trigger;
    unitrigger_stub.crafted = 0;
    unitrigger_stub.persistent = persistent;
    unitrigger_stub.usetime = int( 3000 );
    
    if ( isdefined( self.usetime ) )
    {
        unitrigger_stub.usetime = self.usetime;
    }
    else if ( isdefined( trig.usetime ) )
    {
        unitrigger_stub.usetime = trig.usetime;
    }
    
    unitrigger_stub.onbeginuse = &onbeginuseuts;
    unitrigger_stub.onenduse = &onenduseuts;
    unitrigger_stub.onuse = &onuseplantobjectuts;
    unitrigger_stub.oncantuse = &oncantuseuts;
    tmins = trig getmins();
    tmaxs = trig getmaxs();
    tsize = tmaxs - tmins;
    
    if ( isdefined( trig.script_depth ) )
    {
        unitrigger_stub.script_length = trig.script_depth;
    }
    else
    {
        unitrigger_stub.script_length = tsize[ 1 ];
    }
    
    if ( isdefined( trig.script_width ) )
    {
        unitrigger_stub.script_width = trig.script_width;
    }
    else
    {
        unitrigger_stub.script_width = tsize[ 0 ];
    }
    
    if ( isdefined( trig.script_height ) )
    {
        unitrigger_stub.script_height = trig.script_height;
    }
    else
    {
        unitrigger_stub.script_height = tsize[ 2 ];
    }
    
    unitrigger_stub.target = trig.target;
    unitrigger_stub.targetname = trig.targetname;
    unitrigger_stub.script_noteworthy = trig.script_noteworthy;
    unitrigger_stub.script_parameters = trig.script_parameters;
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    
    if ( isdefined( level.zombie_craftablestubs[ equipname ].str_to_craft ) )
    {
        unitrigger_stub.hint_string = level.zombie_craftablestubs[ equipname ].str_to_craft;
    }
    
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.require_look_at = 1;
    unitrigger_stub.require_look_toward = 0;
    zm_unitrigger::unitrigger_force_per_player_triggers( unitrigger_stub, 1 );
    
    if ( isdefined( unitrigger_stub.craftablestub.custom_craftablestub_update_prompt ) )
    {
        unitrigger_stub.custom_craftablestub_update_prompt = unitrigger_stub.craftablestub.custom_craftablestub_update_prompt;
    }
    
    unitrigger_stub.prompt_and_visibility_func = &craftabletrigger_update_prompt;
    zm_unitrigger::register_static_unitrigger( unitrigger_stub, &craftable_place_think );
    unitrigger_stub.piece_trigger = trig;
    trig.trigger_stub = unitrigger_stub;
    
    if ( isdefined( trig.zombie_weapon_upgrade ) )
    {
        unitrigger_stub.zombie_weapon_upgrade = getweapon( trig.zombie_weapon_upgrade );
    }
    
    if ( isdefined( unitrigger_stub.target ) )
    {
        unitrigger_stub.model = getent( unitrigger_stub.target, "targetname" );
        
        if ( isdefined( unitrigger_stub.model ) )
        {
            if ( isdefined( unitrigger_stub.zombie_weapon_upgrade ) )
            {
                unitrigger_stub.model useweaponhidetags( unitrigger_stub.zombie_weapon_upgrade );
            }
            
            if ( isdefined( unitrigger_stub.model.script_parameters ) )
            {
                a_utm_params = strtok( unitrigger_stub.model.script_parameters, " " );
                
                foreach ( param in a_utm_params )
                {
                    if ( param == "starts_visible" )
                    {
                        b_start_visible = 1;
                        continue;
                    }
                    
                    if ( param == "starts_empty" )
                    {
                        b_start_empty = 1;
                    }
                }
            }
            
            if ( b_start_visible !== 1 )
            {
                unitrigger_stub.model ghost();
                unitrigger_stub.model notsolid();
            }
        }
    }
    
    if ( unitrigger_stub.equipname == "open_table" )
    {
        unitrigger_stub.a_uts_open_craftables_available = [];
        unitrigger_stub.n_open_craftable_choice = -1;
        unitrigger_stub.b_open_craftable_checking_input = 0;
    }
    
    unitrigger_stub.craftablespawn = unitrigger_stub craftable_piece_unitriggers( equipname, unitrigger_stub.origin );
    
    if ( isdefined( unitrigger_stub.model ) && b_start_empty === 1 )
    {
        for ( i = 0; i < unitrigger_stub.craftablespawn.a_piecespawns.size ; i++ )
        {
            if ( isdefined( unitrigger_stub.craftablespawn.a_piecespawns[ i ].tag_name ) )
            {
                if ( unitrigger_stub.craftablespawn.a_piecespawns[ i ].crafted !== 1 )
                {
                    unitrigger_stub.model hidepart( unitrigger_stub.craftablespawn.a_piecespawns[ i ].tag_name );
                    continue;
                }
                
                unitrigger_stub.model showpart( unitrigger_stub.craftablespawn.a_piecespawns[ i ].tag_name );
            }
        }
    }
    
    if ( delete_trigger )
    {
        trig delete();
    }
    
    level.a_uts_craftables[ level.a_uts_craftables.size ] = unitrigger_stub;
    return unitrigger_stub;
}

// Namespace zm_craftables
// Params 0
// Checksum 0xd6f38731, Offset: 0x52b0
// Size: 0xa2
function setup_craftable_pieces()
{
    unitrigger_stub = spawnstruct();
    unitrigger_stub.craftablestub = level.zombie_include_craftables[ self.name ];
    unitrigger_stub.equipname = self.name;
    unitrigger_stub.craftablespawn = unitrigger_stub craftable_piece_unitriggers( self.name, unitrigger_stub.origin );
    level.a_uts_craftables[ level.a_uts_craftables.size ] = unitrigger_stub;
    return unitrigger_stub;
}

// Namespace zm_craftables
// Params 1
// Checksum 0x45d6a19f, Offset: 0x5360
// Size: 0x92, Type: bool
function craftable_has_piece( piece )
{
    for ( i = 0; i < self.a_piecespawns.size ; i++ )
    {
        if ( self.a_piecespawns[ i ].piecename == piece.piecename && self.a_piecespawns[ i ].craftablename == piece.craftablename )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_craftables
// Params 0
// Checksum 0xecb2808, Offset: 0x5400
// Size: 0x50
function get_actual_uts_craftable()
{
    if ( self.craftable_name == "open_table" && self.n_open_craftable_choice != -1 )
    {
        return self.stub.a_uts_open_craftables_available[ self.n_open_craftable_choice ];
    }
    
    return self.stub;
}

// Namespace zm_craftables
// Params 0
// Checksum 0xd68bd4cf, Offset: 0x5458
// Size: 0x94
function get_actual_craftablespawn()
{
    if ( self.craftable_name == "open_table" && self.stub.n_open_craftable_choice != -1 && isdefined( self.stub.a_uts_open_craftables_available[ self.stub.n_open_craftable_choice ].craftablespawn ) )
    {
        return self.stub.a_uts_open_craftables_available[ self.stub.n_open_craftable_choice ].craftablespawn;
    }
    
    return self;
}

// Namespace zm_craftables
// Params 0
// Checksum 0xe4bc0bf7, Offset: 0x54f8
// Size: 0x204, Type: bool
function craftable_can_use_shared_piece()
{
    uts_craftable = self.stub;
    
    if ( isdefined( uts_craftable.n_open_craftable_choice ) && uts_craftable.n_open_craftable_choice != -1 && isdefined( uts_craftable.a_uts_open_craftables_available[ uts_craftable.n_open_craftable_choice ] ) )
    {
        return true;
    }
    
    if ( isdefined( uts_craftable.craftablestub.need_all_pieces ) && uts_craftable.craftablestub.need_all_pieces )
    {
        foreach ( piece in self.a_piecespawns )
        {
            if ( !( isdefined( piece.in_shared_inventory ) && piece.in_shared_inventory ) )
            {
                return false;
            }
        }
        
        return true;
    }
    else
    {
        foreach ( piece in self.a_piecespawns )
        {
            if ( isdefined( piece.in_shared_inventory ) && !( isdefined( piece.crafted ) && piece.crafted ) && piece.in_shared_inventory )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_craftables
// Params 2
// Checksum 0xc590aab8, Offset: 0x5708
// Size: 0x1d6
function craftable_set_piece_crafted( piecespawn_check, player )
{
    craftablespawn_check = get_actual_craftablespawn();
    
    foreach ( piecespawn in craftablespawn_check.a_piecespawns )
    {
        if ( isdefined( piecespawn_check ) )
        {
            if ( piecespawn.piecename == piecespawn_check.piecename && piecespawn.craftablename == piecespawn_check.craftablename )
            {
                piecespawn.crafted = 1;
                
                if ( isdefined( piecespawn.oncrafted ) )
                {
                    piecespawn thread [[ piecespawn.oncrafted ]]( player );
                }
                
                continue;
            }
        }
        
        if ( isdefined( piecespawn.in_shared_inventory ) && isdefined( piecespawn.is_shared ) && piecespawn.is_shared && piecespawn.in_shared_inventory )
        {
            piecespawn.crafted = 1;
            
            if ( isdefined( piecespawn.oncrafted ) )
            {
                piecespawn thread [[ piecespawn.oncrafted ]]( player );
            }
            
            piecespawn.in_shared_inventory = 0;
        }
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0xe90ece25, Offset: 0x58e8
// Size: 0x15a
function craftable_set_piece_crafting( piecespawn_check )
{
    craftablespawn_check = get_actual_craftablespawn();
    
    foreach ( piecespawn in craftablespawn_check.a_piecespawns )
    {
        if ( isdefined( piecespawn_check ) )
        {
            if ( piecespawn.piecename == piecespawn_check.piecename && piecespawn.craftablename == piecespawn_check.craftablename )
            {
                piecespawn.crafting = 1;
            }
        }
        
        if ( isdefined( piecespawn.in_shared_inventory ) && isdefined( piecespawn.is_shared ) && piecespawn.is_shared && piecespawn.in_shared_inventory )
        {
            piecespawn.crafting = 1;
        }
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0x9946d06, Offset: 0x5a50
// Size: 0x11a
function craftable_clear_piece_crafting( piecespawn_check )
{
    if ( isdefined( piecespawn_check ) )
    {
        piecespawn_check.crafting = 0;
    }
    
    craftablespawn_check = get_actual_craftablespawn();
    
    foreach ( piecespawn in craftablespawn_check.a_piecespawns )
    {
        if ( isdefined( piecespawn.in_shared_inventory ) && isdefined( piecespawn.is_shared ) && piecespawn.is_shared && piecespawn.in_shared_inventory )
        {
            piecespawn.crafting = 0;
        }
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0x80e9d9f7, Offset: 0x5b78
// Size: 0xc0, Type: bool
function craftable_is_piece_crafted( piece )
{
    for ( i = 0; i < self.a_piecespawns.size ; i++ )
    {
        if ( self.a_piecespawns[ i ].piecename == piece.piecename && self.a_piecespawns[ i ].craftablename == piece.craftablename )
        {
            return ( isdefined( self.a_piecespawns[ i ].crafted ) && self.a_piecespawns[ i ].crafted );
        }
    }
    
    return false;
}

// Namespace zm_craftables
// Params 0
// Checksum 0xfc47811, Offset: 0x5c40
// Size: 0x1c
function start_crafting_shared_piece()
{
    if ( !isdefined( level.shared_crafting_in_progress ) )
    {
        level.shared_crafting_in_progress = self;
    }
}

// Namespace zm_craftables
// Params 0
// Checksum 0xa5b0c9a1, Offset: 0x5c68
// Size: 0x1e
function finish_crafting_shared_piece()
{
    if ( self === level.shared_crafting_in_progress )
    {
        level.shared_crafting_in_progress = undefined;
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0x99067d5a, Offset: 0x5c90
// Size: 0x2e, Type: bool
function can_craft_shared_piece( continuing )
{
    if ( continuing )
    {
        return ( self === level.shared_crafting_in_progress );
    }
    
    return !isdefined( level.shared_crafting_in_progress );
}

// Namespace zm_craftables
// Params 1
// Checksum 0xe3639bb7, Offset: 0x5cc8
// Size: 0x170
function craftable_is_piece_crafting( piecespawn_check )
{
    craftablespawn_check = get_actual_craftablespawn();
    
    foreach ( piecespawn in craftablespawn_check.a_piecespawns )
    {
        if ( isdefined( piecespawn_check ) )
        {
            if ( piecespawn.piecename == piecespawn_check.piecename && piecespawn.craftablename == piecespawn_check.craftablename )
            {
                return piecespawn.crafting;
            }
        }
        
        if ( isdefined( piecespawn.crafting ) && isdefined( piecespawn.in_shared_inventory ) && isdefined( piecespawn.is_shared ) && piecespawn.is_shared && piecespawn.in_shared_inventory && piecespawn.crafting )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace zm_craftables
// Params 1
// Checksum 0xbd7b27c9, Offset: 0x5e40
// Size: 0xf8, Type: bool
function craftable_is_piece_crafted_or_crafting( piece )
{
    for ( i = 0; i < self.a_piecespawns.size ; i++ )
    {
        if ( self.a_piecespawns[ i ].piecename == piece.piecename && self.a_piecespawns[ i ].craftablename == piece.craftablename )
        {
            return ( isdefined( self.a_piecespawns[ i ].crafting ) && ( isdefined( self.a_piecespawns[ i ].crafted ) && self.a_piecespawns[ i ].crafted || self.a_piecespawns[ i ].crafting ) );
        }
    }
    
    return false;
}

// Namespace zm_craftables
// Params 0
// Checksum 0x38b3da8b, Offset: 0x5f40
// Size: 0x15c, Type: bool
function craftable_all_crafted()
{
    if ( isdefined( self.stub.craftablestub.need_all_pieces ) && self.stub.craftablestub.need_all_pieces )
    {
        foreach ( piece in self.a_piecespawns )
        {
            if ( !( isdefined( piece.in_shared_inventory ) && piece.in_shared_inventory ) && !piece.crafted )
            {
                return false;
            }
        }
        
        return true;
    }
    
    for ( i = 0; i < self.a_piecespawns.size ; i++ )
    {
        if ( !( isdefined( self.a_piecespawns[ i ].crafted ) && self.a_piecespawns[ i ].crafted ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_craftables
// Params 1
// Checksum 0x4308dec7, Offset: 0x60a8
// Size: 0x2e
function waittill_crafted( craftable_name )
{
    level waittill( craftable_name + "_crafted", player );
    return player;
}

// Namespace zm_craftables
// Params 3
// Checksum 0x2278b21c, Offset: 0x60e0
// Size: 0x290, Type: bool
function player_can_craft( craftablespawn, continuing, slot )
{
    if ( !isdefined( craftablespawn ) )
    {
        return false;
    }
    
    if ( !isdefined( slot ) )
    {
        slot = craftablespawn.inventory_slot;
    }
    
    if ( !craftablespawn craftable_can_use_shared_piece() )
    {
        if ( !isdefined( slot ) )
        {
            return false;
        }
        
        if ( !isdefined( self.current_craftable_pieces[ slot ] ) )
        {
            return false;
        }
        
        if ( !craftablespawn craftable_has_piece( self.current_craftable_pieces[ slot ] ) )
        {
            return false;
        }
        
        if ( isdefined( continuing ) && continuing )
        {
            if ( craftablespawn craftable_is_piece_crafted( self.current_craftable_pieces[ slot ] ) )
            {
                return false;
            }
        }
        else if ( craftablespawn craftable_is_piece_crafted_or_crafting( self.current_craftable_pieces[ slot ] ) )
        {
            return false;
        }
    }
    else
    {
        if ( isdefined( craftablespawn.stub.crafted ) && craftablespawn.stub.crafted && !continuing )
        {
            return false;
        }
        
        if ( craftablespawn.stub.usetime > 0 && !self can_craft_shared_piece( continuing ) )
        {
            return false;
        }
    }
    
    if ( isdefined( craftablespawn.stub ) && isdefined( craftablespawn.stub.custom_craftablestub_update_prompt ) && isdefined( craftablespawn.stub.playertrigger[ 0 ] ) && isdefined( craftablespawn.stub.playertrigger[ 0 ].stub ) && !craftablespawn.stub.playertrigger[ 0 ].stub [[ craftablespawn.stub.custom_craftablestub_update_prompt ]]( self, 1, craftablespawn.stub.playertrigger[ self getentitynumber() ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_craftables
// Params 0
// Checksum 0x32cd6e7, Offset: 0x6378
// Size: 0x230
function craftable_transfer_data()
{
    uts_craftable = self.stub;
    
    if ( uts_craftable.n_open_craftable_choice == -1 || !isdefined( uts_craftable.a_uts_open_craftables_available[ uts_craftable.n_open_craftable_choice ] ) )
    {
        return;
    }
    
    uts_source = uts_craftable.a_uts_open_craftables_available[ uts_craftable.n_open_craftable_choice ];
    uts_target = uts_craftable;
    uts_target.craftablestub = uts_source.craftablestub;
    uts_target.craftablespawn = uts_source.craftablespawn;
    uts_target.crafted = uts_source.crafted;
    uts_target.cursor_hint = uts_source.cursor_hint;
    uts_target.custom_craftable_update_prompt = uts_source.custom_craftable_update_prompt;
    uts_target.equipname = uts_source.equipname;
    uts_target.hint_string = uts_source.hint_string;
    uts_target.persistent = uts_source.persistent;
    uts_target.prompt_and_visibility_func = uts_source.prompt_and_visibility_func;
    uts_target.trigger_func = uts_source.trigger_func;
    uts_target.trigger_hintstring = uts_source.trigger_hintstring;
    uts_target.weaponname = uts_source.weaponname;
    uts_target.craftablespawn.stub = uts_target;
    thread zm_unitrigger::unregister_unitrigger( uts_source );
    uts_source craftablestub_remove();
    return uts_target;
}

// Namespace zm_craftables
// Params 2
// Checksum 0xd3b3b040, Offset: 0x65b0
// Size: 0x586
function player_craft( craftablespawn, slot )
{
    if ( !isdefined( slot ) )
    {
        slot = craftablespawn.inventory_slot;
    }
    
    if ( !isdefined( self.current_craftable_pieces ) )
    {
        self.current_craftable_pieces = [];
    }
    
    if ( isdefined( slot ) )
    {
        craftablespawn craftable_set_piece_crafted( self.current_craftable_pieces[ slot ], self );
    }
    
    if ( isdefined( self.current_craftable_pieces[ slot ].crafted ) && isdefined( slot ) && isdefined( self.current_craftable_pieces[ slot ] ) && self.current_craftable_pieces[ slot ].crafted )
    {
        player_destroy_piece( self.current_craftable_pieces[ slot ], slot );
    }
    
    if ( isdefined( craftablespawn.stub.n_open_craftable_choice ) )
    {
        uts_craftable = craftablespawn craftable_transfer_data();
        craftablespawn = uts_craftable.craftablespawn;
        update_open_table_status();
    }
    else
    {
        uts_craftable = craftablespawn.stub;
    }
    
    if ( !isdefined( uts_craftable.model ) && isdefined( uts_craftable.craftablestub.str_model ) )
    {
        craftablestub = uts_craftable.craftablestub;
        s_model = struct::get( uts_craftable.target, "targetname" );
        
        if ( isdefined( s_model ) )
        {
            m_spawn = spawn( "script_model", s_model.origin );
            
            if ( isdefined( craftablestub.v_origin_offset ) )
            {
                m_spawn.origin += craftablestub.v_origin_offset;
            }
            
            m_spawn.angles = s_model.angles;
            
            if ( isdefined( craftablestub.v_angle_offset ) )
            {
                m_spawn.angles += craftablestub.v_angle_offset;
            }
            
            m_spawn setmodel( craftablestub.str_model );
            uts_craftable.model = m_spawn;
        }
    }
    
    if ( isdefined( uts_craftable.model ) )
    {
        for ( i = 0; i < craftablespawn.a_piecespawns.size ; i++ )
        {
            if ( isdefined( craftablespawn.a_piecespawns[ i ].tag_name ) )
            {
                uts_craftable.model notsolid();
                
                if ( !( isdefined( craftablespawn.a_piecespawns[ i ].crafted ) && craftablespawn.a_piecespawns[ i ].crafted ) )
                {
                    uts_craftable.model hidepart( craftablespawn.a_piecespawns[ i ].tag_name );
                    continue;
                }
                
                uts_craftable.model show();
                uts_craftable.model showpart( craftablespawn.a_piecespawns[ i ].tag_name );
            }
        }
    }
    
    self track_craftable_pieces_crafted( craftablespawn );
    
    if ( craftablespawn craftable_all_crafted() )
    {
        self player_finish_craftable( craftablespawn );
        self track_craftables_crafted( craftablespawn );
        
        if ( isdefined( level.craftable_crafted_custom_func ) )
        {
            self thread [[ level.craftable_crafted_custom_func ]]( craftablespawn );
        }
    }
    else
    {
        self playsound( "zmb_buildable_piece_add" );
        assert( isdefined( level.zombie_craftablestubs[ craftablespawn.craftable_name ].str_crafting ), "<dev string:x209>" );
        
        if ( isdefined( level.zombie_craftablestubs[ craftablespawn.craftable_name ].str_crafting ) )
        {
            return level.zombie_craftablestubs[ craftablespawn.craftable_name ].str_crafting;
        }
    }
    
    return "";
}

// Namespace zm_craftables
// Params 0
// Checksum 0x8eb8702b, Offset: 0x6b40
// Size: 0x262
function update_open_table_status()
{
    b_open_craftables_remaining = 0;
    
    foreach ( uts_craftable in level.a_uts_craftables )
    {
        if ( isdefined( level.zombie_include_craftables[ uts_craftable.equipname ].is_open_table ) && isdefined( level.zombie_include_craftables[ uts_craftable.equipname ] ) && level.zombie_include_craftables[ uts_craftable.equipname ].is_open_table )
        {
            b_piece_crafted = 0;
            
            foreach ( piecespawn in uts_craftable.craftablespawn.a_piecespawns )
            {
                if ( isdefined( piecespawn.crafted ) && piecespawn.crafted )
                {
                    b_piece_crafted = 1;
                    break;
                }
            }
            
            if ( !b_piece_crafted )
            {
                b_open_craftables_remaining = 1;
            }
        }
    }
    
    if ( !b_open_craftables_remaining )
    {
        foreach ( uts_craftable in level.a_uts_craftables )
        {
            if ( uts_craftable.equipname == "open_table" )
            {
                thread zm_unitrigger::unregister_unitrigger( uts_craftable );
            }
        }
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0x1fc6217b, Offset: 0x6db0
// Size: 0x88
function player_finish_craftable( craftablespawn )
{
    craftablespawn.crafted = 1;
    craftablespawn.stub.crafted = 1;
    craftablespawn notify( #"crafted", self );
    level.craftables_crafted[ craftablespawn.craftable_name ] = 1;
    level notify( craftablespawn.craftable_name + "_crafted", self );
}

// Namespace zm_craftables
// Params 1
// Checksum 0x65302734, Offset: 0x6e40
// Size: 0x138
function complete_craftable( str_craftable_name )
{
    foreach ( uts_craftable in level.a_uts_craftables )
    {
        if ( uts_craftable.craftablestub.name == str_craftable_name )
        {
            player = getplayers()[ 0 ];
            player player_finish_craftable( uts_craftable.craftablespawn );
            thread zm_unitrigger::unregister_unitrigger( uts_craftable );
            
            if ( isdefined( uts_craftable.craftablestub.onfullycrafted ) )
            {
                uts_craftable [[ uts_craftable.craftablestub.onfullycrafted ]]();
            }
            
            return;
        }
    }
}

// Namespace zm_craftables
// Params 0
// Checksum 0x3dd06d3d, Offset: 0x6f80
// Size: 0x1c
function craftablestub_remove()
{
    arrayremovevalue( level.a_uts_craftables, self );
}

// Namespace zm_craftables
// Params 1
// Checksum 0x705f636e, Offset: 0x6fa8
// Size: 0x60
function craftabletrigger_update_prompt( player )
{
    can_use = self.stub craftablestub_update_prompt( player );
    self sethintstring( self.stub.hint_string );
    return can_use;
}

// Namespace zm_craftables
// Params 3
// Checksum 0x328b9cb3, Offset: 0x7010
// Size: 0x3d8, Type: bool
function craftablestub_update_prompt( player, unitrigger, slot )
{
    if ( !isdefined( slot ) )
    {
        slot = self.craftablestub.inventory_slot;
    }
    
    if ( !isdefined( player.current_craftable_pieces ) )
    {
        player.current_craftable_pieces = [];
    }
    
    if ( !self anystub_update_prompt( player ) )
    {
        return false;
    }
    
    if ( player bgb::is_enabled( "zm_bgb_disorderly_combat" ) )
    {
        self.hint_string = "";
        return false;
    }
    
    if ( isdefined( self.is_locked ) && self.is_locked )
    {
        return true;
    }
    
    can_use = 1;
    
    if ( isdefined( self.custom_craftablestub_update_prompt ) && !self [[ self.custom_craftablestub_update_prompt ]]( player ) )
    {
        return false;
    }
    
    initial_current_weapon = player getcurrentweapon();
    current_weapon = zm_weapons::get_nonalternate_weapon( initial_current_weapon );
    
    if ( current_weapon.isheroweapon || current_weapon.isgadget )
    {
        self.hint_string = "";
        return false;
    }
    
    if ( !( isdefined( self.crafted ) && self.crafted ) )
    {
        if ( !self.craftablespawn craftable_can_use_shared_piece() )
        {
            if ( !isdefined( player.current_craftable_pieces[ slot ] ) )
            {
                self.hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
                return false;
            }
            else if ( !self.craftablespawn craftable_has_piece( player.current_craftable_pieces[ slot ] ) )
            {
                self.hint_string = &"ZOMBIE_BUILD_PIECE_WRONG";
                return false;
            }
        }
        
        assert( isdefined( level.zombie_craftablestubs[ self.equipname ].str_to_craft ), "<dev string:x21e>" );
        self.hint_string = level.zombie_craftablestubs[ self.equipname ].str_to_craft;
    }
    else if ( self.persistent == 1 )
    {
        if ( zm_equipment::is_limited( self.weaponname ) && zm_equipment::limited_in_use( self.weaponname ) )
        {
            self.hint_string = &"ZOMBIE_BUILD_PIECE_ONLY_ONE";
            return false;
        }
        
        if ( player zm_equipment::has_player_equipment( self.weaponname ) )
        {
            self.hint_string = &"ZOMBIE_BUILD_PIECE_HAVE_ONE";
            return false;
        }
        
        self.hint_string = self.trigger_hintstring;
    }
    else if ( self.persistent == 2 )
    {
        if ( !zm_weapons::limited_weapon_below_quota( self.weaponname, undefined ) )
        {
            self.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
            return false;
        }
        else if ( isdefined( self.str_taken ) && self.str_taken )
        {
            self.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
            return false;
        }
        
        self.hint_string = self.trigger_hintstring;
    }
    else
    {
        self.hint_string = "";
        return false;
    }
    
    return true;
}

// Namespace zm_craftables
// Params 1
// Checksum 0x7c266bc1, Offset: 0x73f0
// Size: 0x3c8
function choose_open_craftable( player )
{
    self endon( #"kill_choose_open_craftable" );
    n_playernum = player getentitynumber();
    self.b_open_craftable_checking_input = 1;
    b_got_input = 1;
    hinttexthudelem = newclienthudelem( player );
    hinttexthudelem.alignx = "center";
    hinttexthudelem.aligny = "middle";
    hinttexthudelem.horzalign = "center";
    hinttexthudelem.vertalign = "middle";
    hinttexthudelem.y = 95;
    
    if ( player issplitscreen() )
    {
        hinttexthudelem.y = -50;
    }
    
    hinttexthudelem.foreground = 1;
    hinttexthudelem.font = "default";
    hinttexthudelem.fontscale = 1.1;
    hinttexthudelem.alpha = 1;
    hinttexthudelem.color = ( 1, 1, 1 );
    hinttexthudelem settext( &"ZOMBIE_CRAFTABLE_CHANGE_BUILD" );
    
    if ( !isdefined( self.opencraftablehudelem ) )
    {
        self.opencraftablehudelem = [];
    }
    
    self.opencraftablehudelem[ n_playernum ] = hinttexthudelem;
    
    while ( isdefined( self.playertrigger[ n_playernum ] ) && !self.crafted )
    {
        if ( player actionslotonebuttonpressed() )
        {
            self.n_open_craftable_choice++;
            b_got_input = 1;
        }
        else if ( player actionslottwobuttonpressed() )
        {
            self.n_open_craftable_choice--;
            b_got_input = 1;
        }
        
        if ( self.n_open_craftable_choice >= self.a_uts_open_craftables_available.size )
        {
            self.n_open_craftable_choice = 0;
        }
        else if ( self.n_open_craftable_choice < 0 )
        {
            self.n_open_craftable_choice = self.a_uts_open_craftables_available.size - 1;
        }
        
        if ( b_got_input )
        {
            self.equipname = self.a_uts_open_craftables_available[ self.n_open_craftable_choice ].equipname;
            self.hint_string = self.a_uts_open_craftables_available[ self.n_open_craftable_choice ].hint_string;
            self.playertrigger[ n_playernum ] sethintstring( self.hint_string );
            b_got_input = 0;
            wait 0.5;
        }
        
        if ( player util::is_player_looking_at( self.playertrigger[ n_playernum ].origin, 0.76 ) )
        {
            self.opencraftablehudelem[ n_playernum ].alpha = 1;
        }
        else
        {
            self.opencraftablehudelem[ n_playernum ].alpha = 0;
        }
        
        wait 0.05;
    }
    
    self.b_open_craftable_checking_input = 0;
    self.opencraftablehudelem[ n_playernum ] destroy();
    self.opencraftablehudelem[ n_playernum ] = undefined;
}

// Namespace zm_craftables
// Params 2
// Checksum 0xa993313a, Offset: 0x77c0
// Size: 0x3a8, Type: bool
function open_craftablestub_update_prompt( player, slot )
{
    if ( !isdefined( slot ) )
    {
        slot = 0;
    }
    
    if ( !( isdefined( self.crafted ) && self.crafted ) )
    {
        self.a_uts_open_craftables_available = [];
        
        foreach ( uts_craftable in level.a_uts_craftables )
        {
            if ( isdefined( uts_craftable.craftablestub.is_open_table ) && uts_craftable.craftablestub.is_open_table && !( isdefined( uts_craftable.crafted ) && uts_craftable.crafted ) && uts_craftable.craftablespawn.craftable_name != "open_table" && uts_craftable.craftablespawn craftable_can_use_shared_piece() )
            {
                self.a_uts_open_craftables_available[ self.a_uts_open_craftables_available.size ] = uts_craftable;
            }
        }
        
        if ( self.a_uts_open_craftables_available.size < 2 )
        {
            self notify( #"kill_choose_open_craftable" );
            self.b_open_craftable_checking_input = 0;
            n_entitynum = player getentitynumber();
            
            if ( isdefined( self.opencraftablehudelem ) && isdefined( self.opencraftablehudelem[ n_entitynum ] ) )
            {
                self.opencraftablehudelem[ n_entitynum ] destroy();
                self.opencraftablehudelem[ n_entitynum ] = undefined;
            }
        }
        
        switch ( self.a_uts_open_craftables_available.size )
        {
            case 0:
                if ( !isdefined( player.current_craftable_pieces[ slot ] ) )
                {
                    self.hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
                    self.n_open_craftable_choice = -1;
                    return false;
                }
                
                break;
            case 1:
                self.n_open_craftable_choice = 0;
                self.equipname = self.a_uts_open_craftables_available[ self.n_open_craftable_choice ].equipname;
                return true;
            default:
                if ( !self.b_open_craftable_checking_input )
                {
                    thread choose_open_craftable( player );
                }
                
                return true;
        }
    }
    else if ( self.persistent == 2 )
    {
        if ( !zm_weapons::limited_weapon_below_quota( self.weaponname, undefined ) )
        {
            self.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
            return false;
        }
        else if ( isdefined( self.bought ) && self.bought )
        {
            self.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
            return false;
        }
        else if ( isdefined( self.str_taken ) && self.str_taken )
        {
            self.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
            return false;
        }
        
        self.hint_string = self.trigger_hintstring;
        return true;
    }
    else if ( self.persistent == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_craftables
// Params 2
// Checksum 0xcd0ebce4, Offset: 0x7b70
// Size: 0x290, Type: bool
function player_continue_crafting( craftablespawn, slot )
{
    if ( self laststand::player_is_in_laststand() || self zm_utility::in_revive_trigger() )
    {
        return false;
    }
    
    if ( !self player_can_craft( craftablespawn, 1 ) )
    {
        return false;
    }
    
    if ( isdefined( self.screecher ) )
    {
        return false;
    }
    
    if ( !self usebuttonpressed() )
    {
        return false;
    }
    
    if ( craftablespawn.stub.usetime > 0 && isdefined( slot ) && !craftablespawn craftable_is_piece_crafting( self.current_craftable_pieces[ slot ] ) )
    {
        return false;
    }
    
    trigger = craftablespawn.stub zm_unitrigger::unitrigger_trigger( self );
    
    if ( craftablespawn.stub.script_unitrigger_type == "unitrigger_radius_use" )
    {
        torigin = craftablespawn.stub zm_unitrigger::unitrigger_origin();
        porigin = self geteye();
        radius_sq = 2.25 * craftablespawn.stub.radius * craftablespawn.stub.radius;
        
        if ( distance2dsquared( torigin, porigin ) > radius_sq )
        {
            return false;
        }
    }
    else if ( !isdefined( trigger ) || !trigger istouching( self ) )
    {
        return false;
    }
    
    if ( isdefined( craftablespawn.stub.require_look_at ) && craftablespawn.stub.require_look_at && !self util::is_player_looking_at( trigger.origin, 0.76 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_craftables
// Params 2
// Checksum 0xbc6d386a, Offset: 0x7e08
// Size: 0xd0
function player_progress_bar_update( start_time, craft_time )
{
    self endon( #"entering_last_stand" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"craftable_progress_end" );
    
    while ( isdefined( self ) && gettime() - start_time < craft_time )
    {
        progress = ( gettime() - start_time ) / craft_time;
        
        if ( progress < 0 )
        {
            progress = 0;
        }
        
        if ( progress > 1 )
        {
            progress = 1;
        }
        
        self.usebar hud::updatebar( progress );
        wait 0.05;
    }
}

// Namespace zm_craftables
// Params 2
// Checksum 0x22ab11f8, Offset: 0x7ee0
// Size: 0xdc
function player_progress_bar( start_time, craft_time )
{
    self.usebar = self hud::createprimaryprogressbar();
    self.usebartext = self hud::createprimaryprogressbartext();
    self.usebartext settext( &"ZOMBIE_BUILDING" );
    
    if ( isdefined( self ) && isdefined( start_time ) && isdefined( craft_time ) )
    {
        self player_progress_bar_update( start_time, craft_time );
    }
    
    self.usebartext hud::destroyelem();
    self.usebar hud::destroyelem();
}

// Namespace zm_craftables
// Params 2
// Checksum 0xa74417ee, Offset: 0x7fc8
// Size: 0x4d2
function craftable_use_hold_think_internal( player, slot )
{
    if ( !isdefined( slot ) )
    {
        slot = self.stub.craftablespawn.inventory_slot;
    }
    
    wait 0.01;
    
    if ( !isdefined( self ) )
    {
        if ( isdefined( player.craftableaudio ) )
        {
            player.craftableaudio delete();
            player.craftableaudio = undefined;
        }
        
        return;
    }
    
    if ( self.stub.craftablespawn craftable_can_use_shared_piece() )
    {
        slot = undefined;
    }
    
    if ( !isdefined( self.usetime ) )
    {
        self.usetime = int( 3000 );
    }
    
    self.craft_time = self.usetime;
    self.craft_start_time = gettime();
    craft_time = self.craft_time;
    craft_start_time = self.craft_start_time;
    
    if ( craft_time > 0 )
    {
        player zm_utility::disable_player_move_states( 1 );
        player zm_utility::increment_is_drinking();
        orgweapon = player getcurrentweapon();
        build_weapon = getweapon( "zombie_builder" );
        player giveweapon( build_weapon );
        player switchtoweapon( build_weapon );
        
        if ( isdefined( slot ) )
        {
            self.stub.craftablespawn craftable_set_piece_crafting( player.current_craftable_pieces[ slot ] );
        }
        else
        {
            player start_crafting_shared_piece();
        }
        
        player thread player_progress_bar( craft_start_time, craft_time );
        
        if ( isdefined( level.craftable_craft_custom_func ) )
        {
            player thread [[ level.craftable_craft_custom_func ]]( self.stub );
        }
        
        while ( isdefined( self ) && player player_continue_crafting( self.stub.craftablespawn, slot ) && gettime() - self.craft_start_time < self.craft_time )
        {
            wait 0.05;
        }
        
        player notify( #"craftable_progress_end" );
        player zm_weapons::switch_back_primary_weapon( orgweapon );
        player takeweapon( build_weapon );
        
        if ( isdefined( player.is_drinking ) && player.is_drinking )
        {
            player zm_utility::decrement_is_drinking();
        }
        
        player zm_utility::enable_player_move_states();
    }
    
    if ( self.craft_time <= 0 || isdefined( self ) && player player_continue_crafting( self.stub.craftablespawn, slot ) && gettime() - self.craft_start_time >= self.craft_time )
    {
        if ( isdefined( slot ) )
        {
            self.stub.craftablespawn craftable_clear_piece_crafting( player.current_craftable_pieces[ slot ] );
        }
        else
        {
            player finish_crafting_shared_piece();
        }
        
        self notify( #"craft_succeed" );
        return;
    }
    
    if ( isdefined( player.craftableaudio ) )
    {
        player.craftableaudio delete();
        player.craftableaudio = undefined;
    }
    
    if ( isdefined( slot ) )
    {
        self.stub.craftablespawn craftable_clear_piece_crafting( player.current_craftable_pieces[ slot ] );
    }
    else
    {
        player finish_crafting_shared_piece();
    }
    
    self notify( #"craft_failed" );
}

// Namespace zm_craftables
// Params 1
// Checksum 0xa3e970fb, Offset: 0x84a8
// Size: 0x88
function craftable_play_craft_fx( player )
{
    self endon( #"kill_trigger" );
    self endon( #"craft_succeed" );
    self endon( #"craft_failed" );
    
    while ( true )
    {
        playfx( level._effect[ "building_dust" ], player getplayercamerapos(), player.angles );
        wait 0.5;
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0xf875bdfb, Offset: 0x8538
// Size: 0x88, Type: bool
function craftable_use_hold_think( player )
{
    self thread craftable_play_craft_fx( player );
    self thread craftable_use_hold_think_internal( player );
    retval = self util::waittill_any_return( "craft_succeed", "craft_failed" );
    
    if ( retval == "craft_succeed" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_craftables
// Params 0
// Checksum 0x974e3ae3, Offset: 0x85c8
// Size: 0xea8
function craftable_place_think()
{
    self notify( #"craftable_place_think" );
    self endon( #"craftable_place_think" );
    self endon( #"kill_trigger" );
    player_crafted = undefined;
    
    while ( !( isdefined( self.stub.crafted ) && self.stub.crafted ) )
    {
        self waittill( #"trigger", player );
        
        if ( isdefined( level.custom_craftable_validation ) )
        {
            valid = self [[ level.custom_craftable_validation ]]( player );
            
            if ( !valid )
            {
                continue;
            }
        }
        
        if ( player != self.parent_player )
        {
            continue;
        }
        
        if ( isdefined( player.screecher_weapon ) )
        {
            continue;
        }
        
        if ( !zm_utility::is_player_valid( player ) )
        {
            player thread zm_utility::ignore_triggers( 0.5 );
            continue;
        }
        
        status = player player_can_craft( self.stub.craftablespawn, 0 );
        
        if ( !status )
        {
            self.stub.hint_string = "";
            self sethintstring( self.stub.hint_string );
            
            if ( isdefined( self.stub.oncantuse ) )
            {
                self.stub [[ self.stub.oncantuse ]]( player );
            }
            
            continue;
        }
        
        if ( isdefined( self.stub.onbeginuse ) )
        {
            self.stub [[ self.stub.onbeginuse ]]( player );
        }
        
        result = self craftable_use_hold_think( player );
        team = player.pers[ "team" ];
        
        if ( isdefined( self.stub.onenduse ) )
        {
            self.stub [[ self.stub.onenduse ]]( team, player, result );
        }
        
        if ( !result )
        {
            continue;
        }
        
        if ( isdefined( self.stub.onuse ) )
        {
            self.stub [[ self.stub.onuse ]]( player );
        }
        
        prompt = player player_craft( self.stub.craftablespawn );
        player_crafted = player;
        self.stub.hint_string = prompt;
        self sethintstring( self.stub.hint_string );
    }
    
    if ( isdefined( self.stub.craftablestub.onfullycrafted ) )
    {
        b_result = self.stub [[ self.stub.craftablestub.onfullycrafted ]]();
        
        if ( !b_result )
        {
            return;
        }
    }
    
    if ( isdefined( player_crafted ) )
    {
        player_crafted playsound( "zmb_craftable_complete" );
    }
    
    if ( self.stub.persistent == 0 )
    {
        self.stub craftablestub_remove();
        thread zm_unitrigger::unregister_unitrigger( self.stub );
        return;
    }
    
    if ( self.stub.persistent == 3 )
    {
        stub_uncraft_craftable( self.stub, 1 );
        return;
    }
    
    if ( self.stub.persistent == 2 )
    {
        if ( isdefined( player_crafted ) )
        {
            self craftabletrigger_update_prompt( player_crafted );
        }
        
        if ( !zm_weapons::limited_weapon_below_quota( self.stub.weaponname, undefined ) )
        {
            self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
            self sethintstring( self.stub.hint_string );
            return;
        }
        
        if ( isdefined( self.stub.str_taken ) && self.stub.str_taken )
        {
            self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
            self sethintstring( self.stub.hint_string );
            return;
        }
        
        if ( isdefined( self.stub.model ) )
        {
            self.stub.model notsolid();
            self.stub.model show();
        }
        
        while ( self.stub.persistent == 2 )
        {
            self waittill( #"trigger", player );
            
            if ( isdefined( self.stub.bought ) && self.stub.bought == 1 )
            {
                continue;
            }
            
            if ( isdefined( player.screecher_weapon ) )
            {
                continue;
            }
            
            current_weapon = player getcurrentweapon();
            
            if ( zm_utility::is_placeable_mine( current_weapon ) || zm_equipment::is_equipment_that_blocks_purchase( current_weapon ) )
            {
                continue;
            }
            
            if ( current_weapon.isheroweapon || current_weapon.isgadget )
            {
                continue;
            }
            
            if ( player bgb::is_enabled( "zm_bgb_disorderly_combat" ) )
            {
                continue;
            }
            
            if ( isdefined( level.custom_craftable_validation ) )
            {
                valid = self [[ level.custom_craftable_validation ]]( player );
                
                if ( !valid )
                {
                    continue;
                }
            }
            
            if ( !( isdefined( self.stub.crafted ) && self.stub.crafted ) )
            {
                self.stub.hint_string = "";
                self sethintstring( self.stub.hint_string );
                return;
            }
            
            if ( player != self.parent_player )
            {
                continue;
            }
            
            if ( !zm_utility::is_player_valid( player ) )
            {
                player thread zm_utility::ignore_triggers( 0.5 );
                continue;
            }
            
            self.stub.bought = 1;
            
            if ( isdefined( self.stub.model ) )
            {
                self.stub.model thread model_fly_away( self );
            }
            
            if ( zm_weapons::limited_weapon_below_quota( self.stub.weaponname, undefined ) )
            {
                player zm_weapons::weapon_give( self.stub.weaponname );
                
                if ( isdefined( level.zombie_include_craftables[ self.stub.equipname ].onbuyweapon ) )
                {
                    self [[ level.zombie_include_craftables[ self.stub.equipname ].onbuyweapon ]]( player );
                }
            }
            
            if ( !zm_weapons::limited_weapon_below_quota( self.stub.weaponname, undefined ) )
            {
                self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
            }
            else
            {
                self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
            }
            
            self sethintstring( self.stub.hint_string );
            player track_craftables_pickedup( self.stub.craftablespawn );
        }
        
        return;
    }
    
    if ( !isdefined( player_crafted ) || self craftabletrigger_update_prompt( player_crafted ) )
    {
        visible = 1;
        hide = get_hide_model_if_unavailable( self.stub.equipname );
        
        if ( hide && isdefined( level.custom_craftable_validation ) )
        {
            visible = self [[ level.custom_craftable_validation ]]( player );
        }
        
        if ( visible && isdefined( self.stub.model ) )
        {
            self.stub.model notsolid();
            self.stub.model show();
        }
        
        while ( self.stub.persistent == 1 )
        {
            self waittill( #"trigger", player );
            
            if ( isdefined( player.screecher_weapon ) )
            {
                continue;
            }
            
            if ( isdefined( level.custom_craftable_validation ) )
            {
                valid = self [[ level.custom_craftable_validation ]]( player );
                
                if ( !valid )
                {
                    continue;
                }
            }
            
            if ( !( isdefined( self.stub.crafted ) && self.stub.crafted ) )
            {
                self.stub.hint_string = "";
                self sethintstring( self.stub.hint_string );
                return;
            }
            
            if ( player != self.parent_player )
            {
                continue;
            }
            
            if ( !zm_utility::is_player_valid( player ) )
            {
                player thread zm_utility::ignore_triggers( 0.5 );
                continue;
            }
            
            if ( player zm_equipment::has_player_equipment( self.stub.weaponname ) )
            {
                continue;
            }
            
            if ( player bgb::is_enabled( "zm_bgb_disorderly_combat" ) )
            {
                continue;
            }
            
            if ( isdefined( level.zombie_craftable_persistent_weapon ) )
            {
                if ( self [[ level.zombie_craftable_persistent_weapon ]]( player ) )
                {
                    continue;
                }
            }
            
            if ( isdefined( level.zombie_custom_equipment_setup ) )
            {
                if ( self [[ level.zombie_custom_equipment_setup ]]( player ) )
                {
                    continue;
                }
            }
            
            if ( !zm_equipment::is_limited( self.stub.weaponname ) || !zm_equipment::limited_in_use( self.stub.weaponname ) )
            {
                player zm_equipment::buy( self.stub.weaponname );
                player giveweapon( self.stub.weaponname );
                player zm_equipment::start_ammo( self.stub.weaponname );
                player notify( self.stub.weaponname.name + "_pickup_from_table" );
                
                if ( isdefined( level.zombie_include_craftables[ self.stub.equipname ].onbuyweapon ) )
                {
                    self [[ level.zombie_include_craftables[ self.stub.equipname ].onbuyweapon ]]( player );
                }
                else if ( self.stub.weaponname != "keys_zm" )
                {
                    player setactionslot( 1, "weapon", self.stub.weaponname );
                }
                
                if ( isdefined( level.zombie_craftablestubs[ self.stub.equipname ].str_taken ) )
                {
                    self.stub.hint_string = level.zombie_craftablestubs[ self.stub.equipname ].str_taken;
                }
                else
                {
                    self.stub.hint_string = "";
                }
                
                self sethintstring( self.stub.hint_string );
                player track_craftables_pickedup( self.stub.craftablespawn );
                continue;
            }
            
            self.stub.hint_string = "";
            self sethintstring( self.stub.hint_string );
        }
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0x516f77c0, Offset: 0x9478
// Size: 0x174
function model_fly_away( unitrigger )
{
    self moveto( self.origin + ( 0, 0, 40 ), 3 );
    direction = self.origin;
    direction = ( direction[ 1 ], direction[ 0 ], 0 );
    
    if ( direction[ 0 ] > 0 && ( direction[ 1 ] < 0 || direction[ 1 ] > 0 ) )
    {
        direction = ( direction[ 0 ], direction[ 1 ] * -1, 0 );
    }
    else if ( direction[ 0 ] < 0 )
    {
        direction = ( direction[ 0 ] * -1, direction[ 1 ], 0 );
    }
    
    self vibrate( direction, 10, 0.5, 4 );
    self waittill( #"movedone" );
    self ghost();
    playfx( level._effect[ "poltergeist" ], self.origin );
}

// Namespace zm_craftables
// Params 1
// Checksum 0xf3555ef9, Offset: 0x95f8
// Size: 0x9a
function find_craftable_stub( equipname )
{
    foreach ( stub in level.a_uts_craftables )
    {
        if ( stub.equipname == equipname )
        {
            return stub;
        }
    }
    
    return undefined;
}

// Namespace zm_craftables
// Params 4
// Checksum 0x3e88a6c0, Offset: 0x96a0
// Size: 0x6c
function uncraft_craftable( equipname, return_pieces, origin, angles )
{
    stub = find_craftable_stub( equipname );
    stub_uncraft_craftable( stub, return_pieces, origin, angles );
}

// Namespace zm_craftables
// Params 5
// Checksum 0xebc374e4, Offset: 0x9718
// Size: 0x2d4
function stub_uncraft_craftable( stub, return_pieces, origin, angles, use_random_start )
{
    if ( isdefined( stub ) )
    {
        craftable = stub.craftablespawn;
        craftable.crafted = 0;
        craftable.stub.crafted = 0;
        craftable notify( #"uncrafted" );
        level.craftables_crafted[ craftable.craftable_name ] = 0;
        level notify( craftable.craftable_name + "_uncrafted" );
        
        for ( i = 0; i < craftable.a_piecespawns.size ; i++ )
        {
            craftable.a_piecespawns[ i ].crafted = 0;
            
            if ( isdefined( craftable.a_piecespawns[ i ].tag_name ) )
            {
                craftable.stub.model notsolid();
                
                if ( !( isdefined( craftable.a_piecespawns[ i ].crafted ) && craftable.a_piecespawns[ i ].crafted ) )
                {
                    craftable.stub.model hidepart( craftable.a_piecespawns[ i ].tag_name );
                }
                else
                {
                    craftable.stub.model show();
                    craftable.stub.model showpart( craftable.a_piecespawns[ i ].tag_name );
                }
            }
            
            if ( isdefined( return_pieces ) && return_pieces )
            {
                craftable.a_piecespawns[ i ] piece_spawn_at( origin, angles, use_random_start );
            }
        }
        
        if ( isdefined( craftable.stub.model ) )
        {
            craftable.stub.model ghost();
        }
    }
}

// Namespace zm_craftables
// Params 5
// Checksum 0x847c7f83, Offset: 0x99f8
// Size: 0x384
function player_explode_craftable( equipname, origin, speed, return_to_spawn, return_time )
{
    self explosiondamage( 50, origin );
    stub = find_craftable_stub( equipname );
    
    if ( isdefined( stub ) )
    {
        craftable = stub.craftablespawn;
        craftable.crafted = 0;
        craftable.stub.crafted = 0;
        craftable notify( #"uncrafted" );
        level.craftables_crafted[ craftable.craftable_name ] = 0;
        level notify( craftable.craftable_name + "_uncrafted" );
        
        for ( i = 0; i < craftable.a_piecespawns.size ; i++ )
        {
            craftable.a_piecespawns[ i ].crafted = 0;
            
            if ( isdefined( craftable.a_piecespawns[ i ].tag_name ) )
            {
                craftable.stub.model notsolid();
                
                if ( !( isdefined( craftable.a_piecespawns[ i ].crafted ) && craftable.a_piecespawns[ i ].crafted ) )
                {
                    craftable.stub.model hidepart( craftable.a_piecespawns[ i ].tag_name );
                }
                else
                {
                    craftable.stub.model show();
                    craftable.stub.model showpart( craftable.a_piecespawns[ i ].tag_name );
                }
            }
            
            ang = randomfloat( 360 );
            h = 0.25 + randomfloat( 0.5 );
            dir = ( sin( ang ), cos( ang ), h );
            self thread player_throw_piece( craftable.a_piecespawns[ i ], origin, speed * dir, return_to_spawn, return_time );
        }
        
        craftable.stub.model ghost();
    }
}

// Namespace zm_craftables
// Params 0
// Checksum 0x3617a9fe, Offset: 0x9d88
// Size: 0x9e
function think_craftables()
{
    foreach ( craftable in level.zombie_include_craftables )
    {
        if ( isdefined( craftable.triggerthink ) )
        {
            craftable [[ craftable.triggerthink ]]();
        }
    }
}

// Namespace zm_craftables
// Params 0
// Checksum 0xc6b1dc27, Offset: 0x9e30
// Size: 0x102
function opentablecraftable()
{
    a_trigs = getentarray( "open_craftable_trigger", "targetname" );
    
    foreach ( trig in a_trigs )
    {
        unitrigger_stub = setup_unitrigger_craftable_internal( trig, "open_table", "", "OPEN_CRAFTABLE", 1, 0 );
        unitrigger_stub.require_look_at = 0;
        unitrigger_stub.require_look_toward = 1;
    }
}

// Namespace zm_craftables
// Params 6
// Checksum 0xc17a637c, Offset: 0x9f40
// Size: 0x5a
function craftable_trigger_think( trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent )
{
    return setup_unitrigger_craftable( trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent );
}

// Namespace zm_craftables
// Params 6
// Checksum 0xe47d182f, Offset: 0x9fa8
// Size: 0x5a
function craftable_trigger_think_array( trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent )
{
    return setup_unitrigger_craftable_array( trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent );
}

// Namespace zm_craftables
// Params 7
// Checksum 0x3333c6bb, Offset: 0xa010
// Size: 0x5ae
function setup_vehicle_unitrigger_craftable( parent, trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent )
{
    trig = getent( trigger_targetname, "targetname" );
    
    if ( !isdefined( trig ) )
    {
        return;
    }
    
    unitrigger_stub = spawnstruct();
    unitrigger_stub.craftablestub = level.zombie_include_craftables[ equipname ];
    unitrigger_stub.link_parent = parent;
    unitrigger_stub.origin_parent = trig;
    unitrigger_stub.trigger_targetname = trigger_targetname;
    unitrigger_stub.originfunc = &anystub_get_unitrigger_origin;
    unitrigger_stub.onspawnfunc = &anystub_on_spawn_trigger;
    unitrigger_stub.origin = trig.origin;
    unitrigger_stub.angles = trig.angles;
    unitrigger_stub.equipname = equipname;
    unitrigger_stub.weaponname = weaponname;
    unitrigger_stub.trigger_hintstring = trigger_hintstring;
    unitrigger_stub.delete_trigger = delete_trigger;
    unitrigger_stub.crafted = 0;
    unitrigger_stub.persistent = persistent;
    unitrigger_stub.usetime = int( 3000 );
    unitrigger_stub.onbeginuse = &onbeginuseuts;
    unitrigger_stub.onenduse = &onenduseuts;
    unitrigger_stub.onuse = &onuseplantobjectuts;
    unitrigger_stub.oncantuse = &oncantuseuts;
    tmins = trig getmins();
    tmaxs = trig getmaxs();
    tsize = tmaxs - tmins;
    
    if ( isdefined( trig.script_length ) )
    {
        unitrigger_stub.script_length = trig.script_length;
    }
    else
    {
        unitrigger_stub.script_length = tsize[ 1 ];
    }
    
    if ( isdefined( trig.script_width ) )
    {
        unitrigger_stub.script_width = trig.script_width;
    }
    else
    {
        unitrigger_stub.script_width = tsize[ 0 ];
    }
    
    if ( isdefined( trig.script_height ) )
    {
        unitrigger_stub.script_height = trig.script_height;
    }
    else
    {
        unitrigger_stub.script_height = tsize[ 2 ];
    }
    
    if ( isdefined( trig.radius ) )
    {
        unitrigger_stub.radius = trig.radius;
    }
    else
    {
        unitrigger_stub.radius = 64;
    }
    
    unitrigger_stub.target = trig.target;
    unitrigger_stub.targetname = trig.targetname + "_trigger";
    unitrigger_stub.script_noteworthy = trig.script_noteworthy;
    unitrigger_stub.script_parameters = trig.script_parameters;
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    
    if ( isdefined( level.zombie_craftablestubs[ equipname ].str_to_craft ) )
    {
        unitrigger_stub.hint_string = level.zombie_craftablestubs[ equipname ].str_to_craft;
    }
    
    unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    unitrigger_stub.require_look_at = 1;
    zm_unitrigger::unitrigger_force_per_player_triggers( unitrigger_stub, 1 );
    unitrigger_stub.prompt_and_visibility_func = &craftabletrigger_update_prompt;
    zm_unitrigger::register_unitrigger( unitrigger_stub, &craftable_place_think );
    unitrigger_stub.piece_trigger = trig;
    trig.trigger_stub = unitrigger_stub;
    unitrigger_stub.craftablespawn = unitrigger_stub craftable_piece_unitriggers( equipname, unitrigger_stub.origin );
    
    if ( delete_trigger )
    {
        trig delete();
    }
    
    level.a_uts_craftables[ level.a_uts_craftables.size ] = unitrigger_stub;
    return unitrigger_stub;
}

// Namespace zm_craftables
// Params 7
// Checksum 0x66270af2, Offset: 0xa5c8
// Size: 0x6a
function vehicle_craftable_trigger_think( vehicle, trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent )
{
    return setup_vehicle_unitrigger_craftable( vehicle, trigger_targetname, equipname, weaponname, trigger_hintstring, delete_trigger, persistent );
}

// Namespace zm_craftables
// Params 1
// Checksum 0x735d70ab, Offset: 0xa640
// Size: 0x54
function onpickuputs( player )
{
    /#
        if ( isdefined( player ) && isdefined( player.name ) )
        {
            println( "<dev string:x235>" + player.name );
        }
    #/
}

// Namespace zm_craftables
// Params 1
// Checksum 0x585285ad, Offset: 0xa6a0
// Size: 0x64
function ondroputs( player )
{
    /#
        if ( isdefined( player ) && isdefined( player.name ) )
        {
            println( "<dev string:x25b>" + player.name );
        }
    #/
    
    player notify( #"event_ended" );
}

// Namespace zm_craftables
// Params 1
// Checksum 0x852101e4, Offset: 0xa710
// Size: 0xfc
function onbeginuseuts( player )
{
    /#
        if ( isdefined( player ) && isdefined( player.name ) )
        {
            println( "<dev string:x27f>" + player.name );
        }
    #/
    
    if ( isdefined( self.craftablestub.onbeginuse ) )
    {
        self [[ self.craftablestub.onbeginuse ]]( player );
    }
    
    if ( isdefined( player ) && !isdefined( player.craftableaudio ) )
    {
        player.craftableaudio = spawn( "script_origin", player.origin );
        player.craftableaudio playloopsound( "zmb_craftable_loop" );
    }
}

// Namespace zm_craftables
// Params 3
// Checksum 0xae84fc62, Offset: 0xa818
// Size: 0xfc
function onenduseuts( team, player, result )
{
    /#
        if ( isdefined( player ) && isdefined( player.name ) )
        {
            println( "<dev string:x2a5>" + player.name );
        }
    #/
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( isdefined( player.craftableaudio ) )
    {
        player.craftableaudio delete();
        player.craftableaudio = undefined;
    }
    
    if ( isdefined( self.craftablestub.onenduse ) )
    {
        self [[ self.craftablestub.onenduse ]]( team, player, result );
    }
    
    player notify( #"event_ended" );
}

// Namespace zm_craftables
// Params 1
// Checksum 0x742ee2e0, Offset: 0xa920
// Size: 0x84
function oncantuseuts( player )
{
    /#
        if ( isdefined( player ) && isdefined( player.name ) )
        {
            println( "<dev string:x2c9>" + player.name );
        }
    #/
    
    if ( isdefined( self.craftablestub.oncantuse ) )
    {
        self [[ self.craftablestub.oncantuse ]]( player );
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0xb2befb09, Offset: 0xa9b0
// Size: 0x94
function onuseplantobjectuts( player )
{
    /#
        if ( isdefined( player ) && isdefined( player.name ) )
        {
            println( "<dev string:x2ef>" + player.name );
        }
    #/
    
    if ( isdefined( self.craftablestub.onuseplantobject ) )
    {
        self [[ self.craftablestub.onuseplantobject ]]( player );
    }
    
    player notify( #"bomb_planted" );
}

// Namespace zm_craftables
// Params 0
// Checksum 0xa01af2ff, Offset: 0xaa50
// Size: 0x94, Type: bool
function is_craftable()
{
    if ( !isdefined( level.zombie_craftablestubs ) )
    {
        return false;
    }
    
    if ( isdefined( self.zombie_weapon_upgrade ) && isdefined( level.zombie_craftablestubs[ self.zombie_weapon_upgrade ] ) )
    {
        return true;
    }
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "specialty_weapupgrade" )
    {
        if ( isdefined( level.craftables_crafted[ "pap" ] ) && level.craftables_crafted[ "pap" ] )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace zm_craftables
// Params 0
// Checksum 0x943dd9f2, Offset: 0xaaf0
// Size: 0xc
function craftable_crafted()
{
    self.a_piecespawns--;
}

// Namespace zm_craftables
// Params 0
// Checksum 0x8f0fb65e, Offset: 0xab08
// Size: 0x1a, Type: bool
function craftable_complete()
{
    if ( self.a_piecespawns <= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_craftables
// Params 1
// Checksum 0x3028736c, Offset: 0xab30
// Size: 0x52
function get_craftable_hint( craftable_name )
{
    assert( isdefined( level.zombie_craftablestubs[ craftable_name ] ), craftable_name + "<dev string:x313>" );
    return level.zombie_craftablestubs[ craftable_name ].str_to_craft;
}

// Namespace zm_craftables
// Params 3
// Checksum 0x3c39de07, Offset: 0xab90
// Size: 0xbc
function delete_on_disconnect( craftable, self_notify, skip_delete )
{
    craftable endon( #"death" );
    self waittill( #"disconnect" );
    
    if ( isdefined( self_notify ) )
    {
        self notify( self_notify );
    }
    
    if ( !( isdefined( skip_delete ) && skip_delete ) )
    {
        if ( isdefined( craftable.stub ) )
        {
            thread zm_unitrigger::unregister_unitrigger( craftable.stub );
            craftable.stub = undefined;
        }
        
        if ( isdefined( craftable ) )
        {
            craftable delete();
        }
    }
}

// Namespace zm_craftables
// Params 3
// Checksum 0x81dababe, Offset: 0xac58
// Size: 0x1f6, Type: bool
function is_holding_part( craftable_name, piece_name, slot )
{
    if ( !isdefined( slot ) )
    {
        slot = 0;
    }
    
    if ( isdefined( self.current_craftable_pieces ) && isdefined( self.current_craftable_pieces[ slot ] ) )
    {
        if ( self.current_craftable_pieces[ slot ].craftablename == craftable_name && self.current_craftable_pieces[ slot ].modelname == piece_name )
        {
            return true;
        }
    }
    
    if ( isdefined( level.a_uts_craftables ) )
    {
        foreach ( craftable_stub in level.a_uts_craftables )
        {
            if ( craftable_stub.craftablestub.name == craftable_name )
            {
                foreach ( piece in craftable_stub.craftablespawn.a_piecespawns )
                {
                    if ( piece.piecename == piece_name )
                    {
                        if ( isdefined( piece.in_shared_inventory ) && piece.in_shared_inventory )
                        {
                            return true;
                        }
                    }
                }
            }
        }
    }
    
    return false;
}

// Namespace zm_craftables
// Params 2
// Checksum 0xd928cde1, Offset: 0xae58
// Size: 0x19e, Type: bool
function is_part_crafted( craftable_name, piece_name )
{
    if ( isdefined( level.a_uts_craftables ) )
    {
        foreach ( craftable_stub in level.a_uts_craftables )
        {
            if ( craftable_stub.craftablestub.name == craftable_name )
            {
                if ( isdefined( craftable_stub.crafted ) && craftable_stub.crafted )
                {
                    return true;
                }
                
                foreach ( piece in craftable_stub.craftablespawn.a_piecespawns )
                {
                    if ( piece.piecename == piece_name )
                    {
                        if ( isdefined( piece.crafted ) && piece.crafted )
                        {
                            return true;
                        }
                    }
                }
            }
        }
    }
    
    return false;
}

// Namespace zm_craftables
// Params 1
// Checksum 0x99087d1e, Offset: 0xb000
// Size: 0x22c
function track_craftable_piece_pickedup( piece )
{
    if ( !isdefined( piece ) || !isdefined( piece.craftablename ) )
    {
        println( "<dev string:x34f>" );
        return;
    }
    
    self add_map_craftable_stat( piece.craftablename, "pieces_pickedup", 1 );
    
    if ( isdefined( piece.piecestub ) && isdefined( piece.piecestub.hash_id ) )
    {
        self recordmapevent( 13, gettime(), self.origin, level.round_number, piece.piecestub.hash_id );
    }
    
    if ( isdefined( piece.piecestub.vox_id ) )
    {
        if ( isdefined( piece.piecestub.b_one_time_vo ) && piece.piecestub.b_one_time_vo )
        {
            if ( !isdefined( self.a_one_time_piece_pickup_vo ) )
            {
                self.a_one_time_piece_pickup_vo = [];
            }
            
            if ( isdefined( self.dontspeak ) && self.dontspeak )
            {
                return;
            }
            
            if ( isinarray( self.a_one_time_piece_pickup_vo, piece.piecestub.vox_id ) )
            {
                return;
            }
            
            self.a_one_time_piece_pickup_vo[ self.a_one_time_piece_pickup_vo.size ] = piece.piecestub.vox_id;
        }
        
        self thread zm_utility::do_player_general_vox( "general", piece.piecestub.vox_id + "_pickup" );
        return;
    }
    
    self thread zm_utility::do_player_general_vox( "general", "build_pickup" );
}

// Namespace zm_craftables
// Params 1
// Checksum 0x42fb257d, Offset: 0xb238
// Size: 0x108
function track_craftable_pieces_crafted( craftable )
{
    if ( !isdefined( craftable ) || !isdefined( craftable.craftable_name ) )
    {
        println( "<dev string:x398>" );
        return;
    }
    
    bname = craftable.craftable_name;
    
    if ( isdefined( craftable.stat_name ) )
    {
        bname = craftable.stat_name;
    }
    
    self add_map_craftable_stat( bname, "pieces_built", 1 );
    
    if ( !craftable craftable_all_crafted() )
    {
        self thread zm_utility::do_player_general_vox( "general", "build_add" );
    }
    
    level notify( bname + "_crafted", self );
}

// Namespace zm_craftables
// Params 1
// Checksum 0xddd1c39c, Offset: 0xb348
// Size: 0x284
function track_craftables_crafted( craftable )
{
    if ( !isdefined( craftable ) || !isdefined( craftable.craftable_name ) )
    {
        println( "<dev string:x3e1>" );
        return;
    }
    
    bname = craftable.craftable_name;
    
    if ( isdefined( craftable.stat_name ) )
    {
        bname = craftable.stat_name;
    }
    
    self add_map_craftable_stat( bname, "buildable_built", 1 );
    self zm_stats::increment_client_stat( "buildables_built", 0 );
    self zm_stats::increment_player_stat( "buildables_built" );
    
    if ( isdefined( craftable.stub ) && isdefined( craftable.stub.craftablestub ) && isdefined( craftable.stub.craftablestub.hash_id ) )
    {
        self recordmapevent( 14, gettime(), self.origin, level.round_number, craftable.stub.craftablestub.hash_id );
    }
    
    if ( !isdefined( craftable.stub.craftablestub.no_challenge_stat ) || craftable.stub.craftablestub.no_challenge_stat == 0 )
    {
        self zm_stats::increment_challenge_stat( "SURVIVALIST_CRAFTABLE" );
    }
    
    if ( isdefined( craftable.stub.craftablestub.vox_id ) )
    {
        if ( isdefined( level.zombie_custom_craftable_built_vo ) )
        {
            self thread [[ level.zombie_custom_craftable_built_vo ]]( craftable.stub );
        }
        
        self thread zm_utility::do_player_general_vox( "general", craftable.stub.craftablestub.vox_id + "_final" );
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0x7721c666, Offset: 0xb5d8
// Size: 0x1e4
function track_craftables_pickedup( craftable )
{
    if ( !isdefined( craftable ) )
    {
        println( "<dev string:x424>" );
        return;
    }
    
    stat_name = get_craftable_stat_name( craftable.craftable_name );
    
    if ( isdefined( craftable.stub ) && isdefined( craftable.stub.craftablestub ) && isdefined( craftable.stub.craftablestub.hash_id ) )
    {
        self recordmapevent( 16, gettime(), self.origin, level.round_number, craftable.stub.craftablestub.hash_id );
    }
    
    if ( !isdefined( stat_name ) )
    {
        println( "<dev string:x468>" + craftable.craftable_name + "<dev string:x4d>" );
        return;
    }
    
    self add_map_craftable_stat( stat_name, "buildable_pickedup", 1 );
    
    if ( isdefined( craftable.stub.craftablestub.vox_id ) )
    {
        self thread zm_utility::do_player_general_vox( "general", craftable.stub.craftablestub.vox_id + "_plc" );
    }
    
    self say_pickup_craftable_vo( craftable, 0 );
}

// Namespace zm_craftables
// Params 1
// Checksum 0xf9d9eab7, Offset: 0xb7c8
// Size: 0x194
function track_craftables_planted( equipment )
{
    if ( !isdefined( equipment ) )
    {
        println( "<dev string:x491>" );
        return;
    }
    
    craftable_name = undefined;
    
    if ( isdefined( equipment.name ) )
    {
        craftable_name = get_craftable_stat_name( equipment.name );
    }
    
    if ( !isdefined( craftable_name ) )
    {
        println( "<dev string:x4d5>" + equipment.name + "<dev string:x4d>" );
        return;
    }
    
    demo::bookmark( "zm_player_buildable_placed", gettime(), self );
    self add_map_craftable_stat( craftable_name, "buildable_placed", 1 );
    
    if ( isdefined( equipment.stub ) && isdefined( equipment.stub.craftablestub ) && isdefined( equipment.stub.craftablestub.hash_id ) )
    {
        self recordmapevent( 15, gettime(), self.origin, level.round_number, equipment.stub.craftablestub.hash_id );
    }
}

// Namespace zm_craftables
// Params 0
// Checksum 0x1db32cb9, Offset: 0xb968
// Size: 0x2c
function placed_craftable_vo_timer()
{
    self endon( #"disconnect" );
    self.craftable_timer = 1;
    wait 60;
    self.craftable_timer = 0;
}

// Namespace zm_craftables
// Params 0
// Checksum 0x56ad8c25, Offset: 0xb9a0
// Size: 0x2c
function craftable_pickedup_timer()
{
    self endon( #"disconnect" );
    self.craftable_pickedup_timer = 1;
    wait 60;
    self.craftable_pickedup_timer = 0;
}

// Namespace zm_craftables
// Params 1
// Checksum 0x92c2b420, Offset: 0xb9d8
// Size: 0xfc
function track_planted_craftables_pickedup( equipment )
{
    if ( !isdefined( equipment ) )
    {
        return;
    }
    
    if ( equipment == "equip_turbine_zm" || equipment == "equip_turret_zm" || equipment == "equip_electrictrap_zm" || equipment == "riotshield_zm" || equipment == "alcatraz_shield_zm" || equipment == "tomb_shield_zm" )
    {
        self zm_stats::increment_client_stat( "planted_buildables_pickedup", 0 );
        self zm_stats::increment_player_stat( "planted_buildables_pickedup" );
    }
    
    if ( !( isdefined( self.craftable_pickedup_timer ) && self.craftable_pickedup_timer ) )
    {
        self say_pickup_craftable_vo( equipment, 1 );
        self thread craftable_pickedup_timer();
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0x615ee513, Offset: 0xbae0
// Size: 0x94
function track_placed_craftables( craftable_name )
{
    if ( !isdefined( craftable_name ) )
    {
        return;
    }
    
    self add_map_craftable_stat( craftable_name, "buildable_placed", 1 );
    vo_name = undefined;
    
    if ( craftable_name == level.riotshield_name )
    {
        vo_name = "craft_plc_shield";
    }
    
    if ( !isdefined( vo_name ) )
    {
        return;
    }
    
    self thread zm_utility::do_player_general_vox( "general", vo_name );
}

// Namespace zm_craftables
// Params 2
// Checksum 0x21fd27da, Offset: 0xbb80
// Size: 0x3e
function zombie_craftable_set_record_stats( str_craftable, b_record )
{
    if ( !isdefined( level.craftables_stats_recorded ) )
    {
        level.craftables_stats_recorded = [];
    }
    
    level.craftables_stats_recorded[ str_craftable ] = b_record;
}

// Namespace zm_craftables
// Params 3
// Checksum 0xd6127199, Offset: 0xbbc8
// Size: 0xe4
function add_map_craftable_stat( piece_name, stat_name, value )
{
    if ( !isdefined( piece_name ) || piece_name == "sq_common" || piece_name == "keys_zm" )
    {
        return;
    }
    
    if ( isdefined( level.zm_disable_recording_buildable_stats ) && ( isdefined( level.zm_disable_recording_stats ) && level.zm_disable_recording_stats || level.zm_disable_recording_buildable_stats ) )
    {
        return;
    }
    
    if ( !isdefined( level.craftables_stats_recorded ) )
    {
        level.craftables_stats_recorded = [];
    }
    
    if ( !( isdefined( level.craftables_stats_recorded[ piece_name ] ) && level.craftables_stats_recorded[ piece_name ] ) )
    {
        return;
    }
    
    self adddstat( "buildables", piece_name, stat_name, value );
}

// Namespace zm_craftables
// Params 2
// Checksum 0x4f3c501b, Offset: 0xbcb8
// Size: 0x14
function say_pickup_craftable_vo( craftable_name, b_world )
{
    
}

// Namespace zm_craftables
// Params 1
// Checksum 0x4471472e, Offset: 0xbcd8
// Size: 0xc
function get_craftable_vo_name( craftable_name )
{
    
}

// Namespace zm_craftables
// Params 1
// Checksum 0x1a069358, Offset: 0xbcf0
// Size: 0x8e
function get_craftable_stat_name( craftable_name )
{
    if ( isdefined( craftable_name ) )
    {
        switch ( craftable_name )
        {
            case "equip_riotshield_zm":
                return "riotshield_zm";
            case "equip_turbine_zm":
                return "turbine";
            default:
                return "turret";
            case "equip_electrictrap_zm":
                return "electric_trap";
            case "equip_springpad_zm":
                return "springpad_zm";
            case "equip_slipgun_zm":
                return "slipgun_zm";
        }
    }
    
    return craftable_name;
}

// Namespace zm_craftables
// Params 1
// Checksum 0x862bc075, Offset: 0xbd88
// Size: 0xc4
function get_craftable_model( str_craftable )
{
    foreach ( uts_craftable in level.a_uts_craftables )
    {
        if ( uts_craftable.craftablestub.name == str_craftable )
        {
            if ( isdefined( uts_craftable.model ) )
            {
                return uts_craftable.model;
            }
            
            break;
        }
    }
    
    return undefined;
}

// Namespace zm_craftables
// Params 2
// Checksum 0x517378ee, Offset: 0xbe58
// Size: 0x144
function get_craftable_piece( str_craftable, str_piece )
{
    foreach ( uts_craftable in level.a_uts_craftables )
    {
        if ( uts_craftable.craftablestub.name == str_craftable )
        {
            foreach ( piecespawn in uts_craftable.craftablespawn.a_piecespawns )
            {
                if ( piecespawn.piecename == str_piece )
                {
                    return piecespawn;
                }
            }
            
            break;
        }
    }
    
    return undefined;
}

// Namespace zm_craftables
// Params 2
// Checksum 0x85032513, Offset: 0xbfa8
// Size: 0x5c
function player_get_craftable_piece( str_craftable, str_piece )
{
    piecespawn = get_craftable_piece( str_craftable, str_piece );
    
    if ( isdefined( piecespawn ) )
    {
        self player_take_piece( piecespawn );
    }
}

// Namespace zm_craftables
// Params 2
// Checksum 0xc7399e7a, Offset: 0xc010
// Size: 0x5c
function player_remove_craftable_piece( str_craftable, str_piece )
{
    piecespawn = get_craftable_piece( str_craftable, str_piece );
    
    if ( isdefined( piecespawn ) )
    {
        self player_remove_piece( piecespawn );
    }
}

// Namespace zm_craftables
// Params 1
// Checksum 0xdce7bb22, Offset: 0xc078
// Size: 0x112
function player_remove_piece( piece_to_remove )
{
    if ( !isdefined( self.current_craftable_pieces ) )
    {
        self.current_craftable_pieces = [];
    }
    
    foreach ( slot, self_piece in self.current_craftable_pieces )
    {
        if ( piece_to_remove.piecename === self_piece.piecename && piece_to_remove.craftablename === self_piece.craftablename )
        {
            self clientfield::set_to_player( "craftable", 0 );
            self.current_craftable_pieces[ slot ] = undefined;
            self notify( "craftable_piece_released" + slot );
        }
    }
}

// Namespace zm_craftables
// Params 2
// Checksum 0xbd666105, Offset: 0xc198
// Size: 0x162
function get_craftable_piece_model( str_craftable, str_piece )
{
    foreach ( uts_craftable in level.a_uts_craftables )
    {
        if ( uts_craftable.craftablestub.name == str_craftable )
        {
            foreach ( piecespawn in uts_craftable.craftablespawn.a_piecespawns )
            {
                if ( piecespawn.piecename == str_piece && isdefined( piecespawn.model ) )
                {
                    return piecespawn.model;
                }
            }
            
            break;
        }
    }
    
    return undefined;
}

// Namespace zm_craftables
// Params 3
// Checksum 0x1b867162, Offset: 0xc308
// Size: 0xa4
function player_show_craftable_parts_ui( str_crafted_clientuimodel, str_widget_clientuimodel, b_is_crafted )
{
    self notify( #"player_show_craftable_parts_ui" );
    self endon( #"player_show_craftable_parts_ui" );
    
    if ( b_is_crafted )
    {
        if ( isdefined( str_crafted_clientuimodel ) )
        {
            self thread clientfield::set_player_uimodel( str_crafted_clientuimodel, 1 );
        }
        
        n_show_ui_duration = 3.5;
    }
    else
    {
        n_show_ui_duration = 3.5;
    }
    
    self thread player_hide_craftable_parts_ui_after_duration( str_widget_clientuimodel, n_show_ui_duration );
}

// Namespace zm_craftables
// Params 2
// Checksum 0x3215a17b, Offset: 0xc3b8
// Size: 0x5c
function player_hide_craftable_parts_ui_after_duration( str_widget_clientuimodel, n_show_ui_duration )
{
    self endon( #"disconnect" );
    self thread clientfield::set_player_uimodel( str_widget_clientuimodel, 1 );
    wait n_show_ui_duration;
    self thread clientfield::set_player_uimodel( str_widget_clientuimodel, 0 );
}

/#

    // Namespace zm_craftables
    // Params 0
    // Checksum 0xecdc2dbe, Offset: 0xc420
    // Size: 0x708, Type: dev
    function run_craftables_devgui()
    {
        setdvar( "<dev string:x51e>", "<dev string:x52d>" );
        setdvar( "<dev string:x52e>", "<dev string:x52d>" );
        setdvar( "<dev string:x53d>", "<dev string:x52d>" );
        setdvar( "<dev string:x54e>", "<dev string:x52d>" );
        
        while ( true )
        {
            craftable_id = getdvarstring( "<dev string:x51e>" );
            
            if ( craftable_id != "<dev string:x52d>" )
            {
                a_toks = strtok( craftable_id, "<dev string:x567>" );
                craftable_id = a_toks[ 0 ];
                n_player = isdefined( a_toks[ 1 ] ) ? int( a_toks[ 1 ] ) : 0;
                piece_spawn = level.cheat_craftables[ craftable_id ].piecespawn;
                
                if ( isdefined( piece_spawn ) )
                {
                    player = level.players[ n_player ];
                    
                    if ( isdefined( player ) )
                    {
                        player thread player_take_piece( piece_spawn );
                    }
                }
                
                setdvar( "<dev string:x51e>", "<dev string:x52d>" );
            }
            
            equipment_id = getdvarstring( "<dev string:x54e>" );
            
            if ( equipment_id != "<dev string:x52d>" )
            {
                foreach ( player in getplayers() )
                {
                    if ( zm_equipment::is_included( equipment_id ) )
                    {
                        player zm_equipment::buy( equipment_id );
                    }
                }
                
                setdvar( "<dev string:x54e>", "<dev string:x52d>" );
            }
            
            craftable_id = getdvarstring( "<dev string:x52e>", "<dev string:x52d>" );
            
            if ( craftable_id != "<dev string:x52d>" )
            {
                piece_spawn = level.cheat_craftables[ craftable_id ].piecespawn;
                
                if ( isdefined( piece_spawn.model ) )
                {
                    v_pos = piece_spawn.model.origin;
                }
                else
                {
                    v_pos = piece_spawn.start_origin;
                }
                
                queryresult = positionquery_source_navigation( v_pos, 100, 200, 200, 15 );
                
                if ( queryresult.data.size )
                {
                    point = arraygetclosest( v_pos, queryresult.data );
                    level.players[ 0 ] setorigin( point.origin );
                    level.players[ 0 ] setplayerangles( vectortoangles( v_pos - point.origin ) );
                }
                else
                {
                    iprintlnbold( "<dev string:x569>" );
                }
                
                setdvar( "<dev string:x52e>", "<dev string:x52d>" );
            }
            
            craftable_id = getdvarstring( "<dev string:x53d>", "<dev string:x52d>" );
            
            if ( craftable_id != "<dev string:x52d>" )
            {
                a_tables = [];
                
                foreach ( unitrigger_stub in level.a_uts_craftables )
                {
                    if ( unitrigger_stub.equipname === craftable_id )
                    {
                        if ( !isdefined( a_tables ) )
                        {
                            a_tables = [];
                        }
                        else if ( !isarray( a_tables ) )
                        {
                            a_tables = array( a_tables );
                        }
                        
                        a_tables[ a_tables.size ] = unitrigger_stub;
                    }
                }
                
                if ( a_tables.size )
                {
                    v_pos = arraygetclosest( level.players[ 0 ].origin, a_tables ).origin;
                    queryresult = positionquery_source_navigation( v_pos, 100, 200, 200, 15 );
                    
                    if ( queryresult.data.size )
                    {
                        point = arraygetclosest( v_pos, queryresult.data );
                        level.players[ 0 ] setorigin( point.origin );
                        level.players[ 0 ] setplayerangles( vectortoangles( v_pos - point.origin ) );
                    }
                    else
                    {
                        iprintlnbold( "<dev string:x569>" );
                    }
                    
                    setdvar( "<dev string:x53d>", "<dev string:x52d>" );
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace zm_craftables
    // Params 1
    // Checksum 0x6f91d6fc, Offset: 0xcb30
    // Size: 0x54e, Type: dev
    function add_craftable_cheat( craftable )
    {
        wait 0.05;
        level flag::wait_till( "<dev string:x594>" );
        wait 0.05;
        
        if ( !isdefined( level.cheat_craftables ) )
        {
            level.cheat_craftables = [];
        }
        
        if ( isdefined( craftable.weaponname ) )
        {
            str_cmd = "<dev string:x5ad>" + craftable.name + "<dev string:x5c8>" + craftable.weaponname + "<dev string:x5f0>";
            adddebugcommand( str_cmd );
        }
        
        if ( !isdefined( craftable.a_piecestubs ) )
        {
            return;
        }
        
        foreach ( s_piece in craftable.a_piecestubs )
        {
            id_string = undefined;
            client_field_val = undefined;
            
            if ( isdefined( s_piece.client_field_id ) )
            {
                id_string = s_piece.client_field_id;
                client_field_val = id_string;
            }
            else if ( isdefined( s_piece.piecename ) )
            {
                id_string = s_piece.piecename;
                client_field_val = s_piece.piecename;
            }
            else if ( isdefined( s_piece.client_field_state ) )
            {
                id_string = "<dev string:x5f3>";
                client_field_val = s_piece.client_field_state;
            }
            else
            {
                continue;
            }
            
            tokens = strtok( id_string, "<dev string:x5f7>" );
            display_string = "<dev string:x5f9>";
            
            foreach ( token in tokens )
            {
                if ( token != "<dev string:x5f9>" && token != "<dev string:x5ff>" )
                {
                    display_string = display_string + "<dev string:x5f7>" + token;
                }
            }
            
            level.cheat_craftables[ "<dev string:x52d>" + client_field_val ] = s_piece;
            str_cmd = "<dev string:x5ad>" + craftable.name + "<dev string:x602>" + display_string + "<dev string:x604>" + client_field_val + "<dev string:x62b>";
            adddebugcommand( str_cmd );
            str_cmd = "<dev string:x5ad>" + craftable.name + "<dev string:x602>" + display_string + "<dev string:x630>" + client_field_val + "<dev string:x657>";
            adddebugcommand( str_cmd );
            str_cmd = "<dev string:x5ad>" + craftable.name + "<dev string:x602>" + display_string + "<dev string:x65c>" + client_field_val + "<dev string:x683>";
            adddebugcommand( str_cmd );
            str_cmd = "<dev string:x5ad>" + craftable.name + "<dev string:x602>" + display_string + "<dev string:x688>" + client_field_val + "<dev string:x6af>";
            adddebugcommand( str_cmd );
            str_cmd = "<dev string:x5ad>" + craftable.name + "<dev string:x602>" + display_string + "<dev string:x6b4>" + client_field_val + "<dev string:x5f0>";
            adddebugcommand( str_cmd );
            str_cmd = "<dev string:x5ad>" + craftable.name + "<dev string:x602>" + display_string + "<dev string:x6d2>" + s_piece.craftablename + "<dev string:x5f0>";
            adddebugcommand( str_cmd );
            s_piece.waste = "<dev string:x6f2>";
        }
    }

#/
