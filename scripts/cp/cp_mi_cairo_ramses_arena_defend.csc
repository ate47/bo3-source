#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_oed;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/filter_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/weapons/spike_charge;

#namespace arena_defend;

// Namespace arena_defend
// Params 0, eflags: 0x2
// Checksum 0x25572171, Offset: 0x340
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "arena_defend", &__init__, undefined, undefined );
}

// Namespace arena_defend
// Params 0
// Checksum 0x40f3d869, Offset: 0x380
// Size: 0x34
function __init__()
{
    init_clientfields();
    callback::on_localclient_connect( &on_player_connect );
}

// Namespace arena_defend
// Params 0
// Checksum 0x9bee5f1c, Offset: 0x3c0
// Size: 0xdc
function init_clientfields()
{
    clientfield::register( "scriptmover", "arena_defend_weak_point_keyline", 1, 1, "int", &callback_arena_defend_keyline, 0, 0 );
    clientfield::register( "world", "clear_all_dyn_ents", 1, 1, "counter", &callback_clear_all_dyn_ents, 0, 0 );
    clientfield::register( "toplayer", "set_dedicated_shadow", 1, 1, "int", &function_a40e70b2, 0, 0 );
}

// Namespace arena_defend
// Params 1
// Checksum 0xeea10356, Offset: 0x4a8
// Size: 0x4c
function on_player_connect( localclientnum )
{
    duplicate_render::set_dr_filter_offscreen( "weakpoint_keyline", 100, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z", 2, "mc/hud_outline_model_z_orange", 1 );
}

// Namespace arena_defend
// Params 7
// Checksum 0x2362afff, Offset: 0x500
// Size: 0x164
function callback_arena_defend_keyline( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self duplicate_render::change_dr_flags( localclientnum, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z" );
        self tmodesetflag( 3 );
        self weakpoint_enable( 1 );
        
        if ( self.model == "wpn_t7_spike_launcher_projectile_var" )
        {
            self thread function_cbf697f5( localclientnum );
        }
        
        return;
    }
    
    self duplicate_render::change_dr_flags( localclientnum, "weakpoint_keyline_hide_z", "weakpoint_keyline_show_z" );
    self tmodeclearflag( 3 );
    self weakpoint_enable( 0 );
    
    if ( self.model == "wpn_t7_spike_launcher_projectile_var" )
    {
        self notify( #"light_disable" );
        self stop_light_fx( localclientnum );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x806d329c, Offset: 0x670
// Size: 0x10c
function function_cbf697f5( localclientnum )
{
    self notify( #"light_disable" );
    self endon( #"entityshutdown" );
    self endon( #"light_disable" );
    self util::waittill_dobj( localclientnum );
    
    for ( n_interval = 0.3;  ; n_interval = math::clamp( n_interval / 1.2, 0.08, 0.3 ) )
    {
        self stop_light_fx( localclientnum );
        self start_light_fx( localclientnum );
        util::server_wait( localclientnum, n_interval, 0.01, "player_switch" );
        self util::waittill_dobj( localclientnum );
    }
}

// Namespace arena_defend
// Params 1
// Checksum 0x5196fc91, Offset: 0x788
// Size: 0x7c
function start_light_fx( localclientnum )
{
    var_5c632d10 = self gettagorigin( "tag_fx" ) + ( 0, 0, 4 );
    self.fx = playfx( localclientnum, level._effect[ "spike_light" ], var_5c632d10 );
}

// Namespace arena_defend
// Params 1
// Checksum 0x73a57c1, Offset: 0x810
// Size: 0x4e
function stop_light_fx( localclientnum )
{
    if ( isdefined( self.fx ) && self.fx != 0 )
    {
        stopfx( localclientnum, self.fx );
        self.fx = undefined;
    }
}

// Namespace arena_defend
// Params 7
// Checksum 0x4a8718d2, Offset: 0x868
// Size: 0x102
function callback_clear_all_dyn_ents( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        cleanupspawneddynents();
        var_f47aa4cf = getdynentarray( "arena_defend_dyn_ents" );
        
        foreach ( ent in var_f47aa4cf )
        {
            setdynentenabled( ent, 0 );
        }
    }
}

// Namespace arena_defend
// Params 7
// Checksum 0xd174737f, Offset: 0x978
// Size: 0x74
function function_a40e70b2( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self setdedicatedshadow( 1 );
        return;
    }
    
    self setdedicatedshadow( 0 );
}

