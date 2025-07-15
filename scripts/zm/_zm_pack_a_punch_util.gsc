#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_weapons;

#namespace zm_pap_util;

// Namespace zm_pap_util
// Params 0
// Checksum 0x3957c30, Offset: 0x1c8
// Size: 0xd0
function init_parameters()
{
    if ( !isdefined( level.pack_a_punch ) )
    {
        level.pack_a_punch = spawnstruct();
        level.pack_a_punch.timeout = 15;
        level.pack_a_punch.interaction_height = 35;
        level.pack_a_punch.move_in_func = &pap_weapon_move_in;
        level.pack_a_punch.move_out_func = &pap_weapon_move_out;
        level.pack_a_punch.grabbable_by_anyone = 0;
        level.pack_a_punch.swap_attachments_on_reuse = 0;
        level.pack_a_punch.triggers = [];
    }
}

// Namespace zm_pap_util
// Params 1
// Checksum 0xc5406ee, Offset: 0x2a0
// Size: 0x30
function set_timeout( n_timeout_s )
{
    init_parameters();
    level.pack_a_punch.timeout = n_timeout_s;
}

// Namespace zm_pap_util
// Params 1
// Checksum 0x96194044, Offset: 0x2d8
// Size: 0x30
function set_interaction_height( n_height )
{
    init_parameters();
    level.pack_a_punch.interaction_height = n_height;
}

// Namespace zm_pap_util
// Params 1
// Checksum 0x4c8f716f, Offset: 0x310
// Size: 0x30
function set_interaction_trigger_radius( n_radius )
{
    init_parameters();
    level.pack_a_punch.interaction_trigger_radius = n_radius;
}

// Namespace zm_pap_util
// Params 1
// Checksum 0x886743a0, Offset: 0x348
// Size: 0x30
function set_interaction_trigger_height( n_height )
{
    init_parameters();
    level.pack_a_punch.set_interaction_trigger_height = n_height;
}

// Namespace zm_pap_util
// Params 1
// Checksum 0xedbb23f2, Offset: 0x380
// Size: 0x30
function set_move_in_func( fn_move_weapon_in )
{
    init_parameters();
    level.pack_a_punch.move_in_func = fn_move_weapon_in;
}

// Namespace zm_pap_util
// Params 1
// Checksum 0xe67b1492, Offset: 0x3b8
// Size: 0x30
function set_move_out_func( fn_move_weapon_out )
{
    init_parameters();
    level.pack_a_punch.move_out_func = fn_move_weapon_out;
}

// Namespace zm_pap_util
// Params 0
// Checksum 0x7810669, Offset: 0x3f0
// Size: 0x28
function set_grabbable_by_anyone()
{
    init_parameters();
    level.pack_a_punch.grabbable_by_anyone = 1;
}

// Namespace zm_pap_util
// Params 0
// Checksum 0xc46c6dc2, Offset: 0x420
// Size: 0x5a
function get_triggers()
{
    init_parameters();
    
    /#
        if ( level.pack_a_punch.triggers.size == 0 )
        {
            println( "<dev string:x28>" );
        }
    #/
    
    return level.pack_a_punch.triggers;
}

// Namespace zm_pap_util
// Params 0
// Checksum 0xe345596f, Offset: 0x488
// Size: 0x20, Type: bool
function is_pap_trigger()
{
    return isdefined( self.script_noteworthy ) && self.script_noteworthy == "pack_a_punch";
}

// Namespace zm_pap_util
// Params 0
// Checksum 0xcb916bec, Offset: 0x4b0
// Size: 0x28
function enable_swap_attachments()
{
    init_parameters();
    level.pack_a_punch.swap_attachments_on_reuse = 1;
}

// Namespace zm_pap_util
// Params 0
// Checksum 0x1612c03a, Offset: 0x4e0
// Size: 0x22
function can_swap_attachments()
{
    if ( !isdefined( level.pack_a_punch ) )
    {
        return 0;
    }
    
    return level.pack_a_punch.swap_attachments_on_reuse;
}

// Namespace zm_pap_util
// Params 1
// Checksum 0x19b2f724, Offset: 0x510
// Size: 0xd4
function update_hint_string( player )
{
    if ( self flag::get( "pap_offering_gun" ) )
    {
        self sethintstring( &"ZOMBIE_GET_UPGRADED_FILL" );
        return;
    }
    
    w_curr_player_weapon = player getcurrentweapon();
    
    if ( zm_weapons::is_weapon_upgraded( w_curr_player_weapon ) )
    {
        self sethintstring( &"ZOMBIE_PERK_PACKAPUNCH_AAT", self.aat_cost );
        return;
    }
    
    self sethintstring( &"ZOMBIE_PERK_PACKAPUNCH", self.cost );
}

// Namespace zm_pap_util
// Params 4, eflags: 0x4
// Checksum 0xbd47d2ac, Offset: 0x5f0
// Size: 0x3c
function private pap_weapon_move_in( player, trigger, origin_offset, angles_offset )
{
    level endon( #"pack_a_punch_off" );
    trigger endon( #"pap_player_disconnected" );
}

// Namespace zm_pap_util
// Params 4, eflags: 0x4
// Checksum 0xfd97fa57, Offset: 0x638
// Size: 0x3c
function private pap_weapon_move_out( player, trigger, origin_offset, interact_offset )
{
    level endon( #"pack_a_punch_off" );
    trigger endon( #"pap_player_disconnected" );
}

