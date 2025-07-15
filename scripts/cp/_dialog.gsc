#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/face;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace dialog;

// Namespace dialog
// Params 0, eflags: 0x2
// Checksum 0xae9083f0, Offset: 0x370
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "dialog", &__init__, undefined, undefined );
}

// Namespace dialog
// Params 0
// Checksum 0x11db08a0, Offset: 0x3b0
// Size: 0x54
function __init__()
{
    level.vo = spawnstruct();
    level.vo.nag_groups = [];
    callback::on_spawned( &dialog_onplayerspawned );
}

// Namespace dialog
// Params 0
// Checksum 0xa24dcb57, Offset: 0x410
// Size: 0x24
function dialog_onplayerspawned()
{
    self luinotifyevent( &"offsite_comms_complete" );
}

// Namespace dialog
// Params 2
// Checksum 0xc4c71d70, Offset: 0x440
// Size: 0xfc
function add( str_dialog_name, str_vox_file )
{
    assert( isdefined( str_dialog_name ), "<dev string:x28>" );
    assert( isdefined( str_vox_file ), "<dev string:x5c>" );
    
    if ( !isdefined( level.scr_sound ) )
    {
        level.scr_sound = [];
    }
    
    if ( !isdefined( level.scr_sound[ "generic" ] ) )
    {
        level.scr_sound[ "generic" ] = [];
    }
    
    level.scr_sound[ "generic" ][ str_dialog_name ] = str_vox_file;
    animation::add_global_notetrack_handler( "vox#" + str_dialog_name, &notetrack_say, 0, str_dialog_name );
}

// Namespace dialog
// Params 1
// Checksum 0xa941fc30, Offset: 0x548
// Size: 0xbc
function notetrack_say( str_vo_line )
{
    if ( isplayer( self ) )
    {
        if ( self flagsys::get( "shared_igc" ) )
        {
            player_say( str_vo_line );
        }
        else
        {
            say( str_vo_line );
        }
        
        return;
    }
    
    if ( is_player_dialog( str_vo_line ) )
    {
        level player_say( str_vo_line );
        return;
    }
    
    say( str_vo_line );
}

// Namespace dialog
// Params 1
// Checksum 0x91f25a, Offset: 0x610
// Size: 0x82
function is_player_dialog( str_script_id )
{
    str_alias = undefined;
    
    if ( isdefined( level.scr_sound ) && isdefined( level.scr_sound[ "generic" ] ) )
    {
        str_alias = level.scr_sound[ "generic" ][ str_script_id ];
    }
    
    if ( !isdefined( str_alias ) )
    {
        return 0;
    }
    
    return strendswith( str_alias, "plyr" );
}

// Namespace dialog
// Params 5
// Checksum 0xcd48912e, Offset: 0x6a0
// Size: 0x164
function say( str_vo_line, n_delay, b_fake_ent, e_to_player, var_43937b21 )
{
    if ( !isdefined( b_fake_ent ) )
    {
        b_fake_ent = 0;
    }
    
    ent = self;
    
    if ( self == level )
    {
        if ( isdefined( var_43937b21 ) && var_43937b21 )
        {
            ent = spawn( "script_model", ( 0, 0, 0 ) );
            level.e_speaker = ent;
        }
        else
        {
            ent = spawn( "script_origin", ( 0, 0, 0 ) );
        }
        
        waittillframeend();
        level notify( #"hash_120cde7f", ent );
        b_fake_ent = 1;
    }
    
    ent endon( #"death" );
    ent thread _say( str_vo_line, n_delay, b_fake_ent, e_to_player );
    ent waittillmatch( #"done speaking", str_vo_line );
    
    if ( self == level )
    {
        ent delete();
        
        if ( isdefined( level.e_speaker ) )
        {
            level.e_speaker delete();
        }
    }
}

// Namespace dialog
// Params 4, eflags: 0x4
// Checksum 0xe81d3e10, Offset: 0x810
// Size: 0x2a6
function private _say( str_vo_line, n_delay, b_fake_ent, e_to_player )
{
    if ( !isdefined( b_fake_ent ) )
    {
        b_fake_ent = 0;
    }
    
    self endon( #"death" );
    self.is_about_to_talk = 1;
    self thread _on_kill_pending_dialog( str_vo_line );
    level endon( #"kill_pending_dialog" );
    self endon( #"kill_pending_dialog" );
    
    if ( isdefined( n_delay ) && n_delay > 0 )
    {
        wait n_delay;
    }
    
    if ( self.classname === "script_origin" )
    {
        b_fake_ent = 1;
    }
    
    if ( !b_fake_ent )
    {
        if ( !isdefined( self.health ) || self.health <= 0 )
        {
            if ( !isplayer( self ) || !( isdefined( self.laststand ) && self.laststand ) )
            {
                assertmsg( "<dev string:x8d>" );
                self.is_about_to_talk = undefined;
                self notify( #"done speaking", str_vo_line );
                return;
            }
        }
    }
    
    self.is_talking = 1;
    
    if ( self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined( self.archetype ) && self.archetype == "civilian" )
    {
        self clientfield::set( "facial_dial", 1 );
    }
    
    self face::sayspecificdialogue( 0, str_vo_line, 1, undefined, undefined, undefined, e_to_player );
    self waittillmatch( #"done speaking", str_vo_line );
    
    if ( self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || isdefined( self.archetype ) && self.archetype == "civilian" )
    {
        self clientfield::set( "facial_dial", 0 );
    }
    
    self.is_talking = undefined;
    self.is_about_to_talk = undefined;
}

// Namespace dialog
// Params 1
// Checksum 0xd0441982, Offset: 0xac0
// Size: 0x5e
function _on_kill_pending_dialog( str_vo_line )
{
    self endon( #"death" );
    self notify( #"_on_kill_pending_dialog_end" );
    self endon( #"_on_kill_pending_dialog_end" );
    util::waittill_any_ents_two( level, "kill_pending_dialog", self, "kill_pending_dialog" );
    self.is_about_to_talk = undefined;
}

// Namespace dialog
// Params 2
// Checksum 0xf1c3dfeb, Offset: 0xb28
// Size: 0xf4
function player_say( str_vo_line, n_delay )
{
    if ( self == level )
    {
        foreach ( player in level.activeplayers )
        {
            player thread player_say( str_vo_line, n_delay );
        }
        
        array::wait_till_match( level.activeplayers, "done speaking", str_vo_line );
        return;
    }
    
    say( str_vo_line, n_delay, 0, self );
}

// Namespace dialog
// Params 5
// Checksum 0xb79bc563, Offset: 0xc28
// Size: 0x392
function remote( str_vo_line, n_delay, str_type, e_to_player, var_43937b21 )
{
    if ( !isdefined( str_type ) )
    {
        str_type = "dni";
    }
    
    if ( str_type === "dni" )
    {
        a_script_id = strtok( level.scr_sound[ "generic" ][ str_vo_line ], "_" );
        str_who = undefined;
        
        switch ( a_script_id[ a_script_id.size - 1 ] )
        {
            case "diaz":
                str_who = &"CPUI_DIAZ_SEBASTIAN";
                break;
            case "ecmd":
                str_who = &"CPUI_EGYPTIAN_COMMAND";
                break;
            case "xiul":
                str_who = &"CPUI_GOH_XIULAN";
                break;
            case "hend":
                str_who = &"CPUI_HENDRICKS_JACOB";
                break;
            case "khal":
                str_who = &"CPUI_KHALIL_ZEYAD";
                break;
            case "mare":
                str_who = &"CPUI_MARETTI_PETER";
                break;
            case "kane":
                str_who = &"CPUI_KANE_RACHEL";
                break;
            case "hall":
                str_who = &"CPUI_HALL_SARAH";
                break;
            case "tayr":
                str_who = &"CPUI_TAYLOR_JOHN";
                break;
            case "vtpl":
            case "wapl":
                str_who = &"CPUI_VTOL_PILOT";
                break;
            default:
                str_who = undefined;
                break;
        }
        
        if ( isdefined( str_who ) && !sessionmodeiscampaignzombiesgame() )
        {
            foreach ( player in level.players )
            {
                if ( !isdefined( e_to_player ) || e_to_player == player )
                {
                    player luinotifyevent( &"offsite_comms_message", 1, str_who );
                }
            }
        }
    }
    
    level say( str_vo_line, n_delay, 1, e_to_player, var_43937b21 );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        if ( str_type === "dni" )
        {
            foreach ( player in level.players )
            {
                if ( !isdefined( e_to_player ) || e_to_player == player )
                {
                    player luinotifyevent( &"offsite_comms_complete" );
                }
            }
        }
    }
}

