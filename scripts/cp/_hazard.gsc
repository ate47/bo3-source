#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace hazard;

// Namespace hazard
// Params 0, eflags: 0x2
// Checksum 0x4d9cadcf, Offset: 0x248
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "hazard", &__init__, undefined, undefined );
}

// Namespace hazard
// Params 0
// Checksum 0xbc6fbdbe, Offset: 0x288
// Size: 0x13c
function __init__()
{
    add_hazard( "heat", 500, 50, 1, &function_476442fb );
    add_hazard( "filter", 500, 50, 2 );
    add_hazard( "o2", 500, 60, 3, &function_8b413656 );
    add_hazard( "radation", 500, 50, 4 );
    add_hazard( "biohazard", 500, 50, 5 );
    callback::on_spawned( &on_player_spawned );
    callback::on_player_killed( &on_player_killed );
    callback::on_connect( &on_player_connect );
}

// Namespace hazard
// Params 5
// Checksum 0x3d1698c4, Offset: 0x3d0
// Size: 0xec
function add_hazard( str_name, n_max_protection, n_regen_rate, n_type, func_update )
{
    if ( !isdefined( level.hazards ) )
    {
        level.hazards = [];
    }
    
    if ( !isdefined( level.hazards[ str_name ] ) )
    {
        level.hazards[ str_name ] = spawnstruct();
    }
    
    level.hazards[ str_name ].n_max_protection = n_max_protection;
    level.hazards[ str_name ].n_regen_rate = n_regen_rate;
    level.hazards[ str_name ].n_type = n_type;
    level.hazards[ str_name ].func_update = func_update;
}

// Namespace hazard
// Params 0
// Checksum 0x3f6eee1c, Offset: 0x4c8
// Size: 0x1c
function on_player_spawned()
{
    reset( 1 );
}

// Namespace hazard
// Params 0
// Checksum 0x8b2a3fcf, Offset: 0x4f0
// Size: 0x4c
function on_player_connect()
{
    reset( 0 );
    self thread function_b6af57a8();
    self thread function_a421f870();
}

// Namespace hazard
// Params 0
// Checksum 0xab3171a, Offset: 0x548
// Size: 0x1c
function on_player_killed()
{
    reset( 1 );
}

// Namespace hazard
// Params 1
// Checksum 0x7100897c, Offset: 0x570
// Size: 0x11c
function reset( var_b18f74fe )
{
    foreach ( str_name, _ in level.hazards )
    {
        self.hazard_damage[ str_name ] = 0;
        self.var_6c3e78bb[ str_name ] = 1;
    }
    
    self.hazard_ui_models = [];
    self.hazard_ui_models[ "hudItems.hess1" ] = 0;
    self.hazard_ui_models[ "hudItems.hess2" ] = 0;
    
    if ( var_b18f74fe )
    {
        self setcontrolleruimodelvalue( "hudItems.hess1.type", 0 );
        self setcontrolleruimodelvalue( "hudItems.hess2.type", 0 );
    }
}

// Namespace hazard
// Params 0
// Checksum 0xb6fdd4c3, Offset: 0x698
// Size: 0xf6
function function_b6af57a8()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"save_restore" );
        
        if ( isdefined( self.var_8dcb3948 ) && self.var_8dcb3948 )
        {
            continue;
        }
        
        var_8601d520 = getarraykeys( level.hazards );
        
        foreach ( str_name in var_8601d520 )
        {
            self do_damage( str_name, 3, undefined );
            wait 0.1;
        }
    }
}

// Namespace hazard
// Params 0
// Checksum 0xcfe483d9, Offset: 0x798
// Size: 0xce
function function_a421f870()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"player_revived" );
        
        foreach ( str_name, _ in level.hazards )
        {
            if ( function_b78a859e( str_name ) >= 1 )
            {
                function_12231466( str_name );
            }
        }
    }
}

// Namespace hazard
// Params 1
// Checksum 0x6f222bbb, Offset: 0x870
// Size: 0x56
function function_12231466( str_name )
{
    assert( isdefined( level.hazards[ str_name ] ), "<dev string:x28>" + str_name + "<dev string:x3e>" );
    self.hazard_damage[ str_name ] = 0;
}

// Namespace hazard
// Params 4
// Checksum 0xbfde7e7b, Offset: 0x8d0
// Size: 0x1c6, Type: bool
function do_damage( str_name, n_damage, e_ent, disable_ui )
{
    assert( isdefined( level.hazards[ str_name ] ), "<dev string:x28>" + str_name + "<dev string:x3e>" );
    
    if ( !isdefined( disable_ui ) )
    {
        disable_ui = 0;
    }
    
    if ( scene::is_igc_active() )
    {
        return false;
    }
    
    s_hazard = level.hazards[ str_name ];
    self.hazard_damage[ str_name ] = min( self.hazard_damage[ str_name ] + n_damage, s_hazard.n_max_protection );
    
    if ( self.hazard_damage[ str_name ] < s_hazard.n_max_protection )
    {
        self thread _fill_hazard_protection( str_name, e_ent, disable_ui );
        return true;
    }
    
    switch ( str_name )
    {
        case "o2":
            str_mod = "MOD_DROWN";
            break;
        case "heat":
            str_mod = "MOD_BURNED";
            break;
        default:
            str_mod = "MOD_UNKNOWN";
            break;
    }
    
    self dodamage( self.health, self.origin, undefined, undefined, undefined, str_mod );
    return false;
}

// Namespace hazard
// Params 1
// Checksum 0xe9fcf0c3, Offset: 0xaa0
// Size: 0x50
function function_eaa9157d( str_name )
{
    assert( isdefined( self.hazard_damage[ str_name ] ), "<dev string:x28>" + str_name + "<dev string:x3e>" );
    return self.hazard_damage[ str_name ];
}

// Namespace hazard
// Params 1
// Checksum 0xe1b74171, Offset: 0xaf8
// Size: 0x68
function function_b78a859e( str_name )
{
    assert( isdefined( self.hazard_damage[ str_name ] ), "<dev string:x28>" + str_name + "<dev string:x3e>" );
    return self.hazard_damage[ str_name ] / level.hazards[ str_name ].n_max_protection;
}

// Namespace hazard
// Params 2
// Checksum 0xe491cff7, Offset: 0xb68
// Size: 0x76
function function_459e5eff( str_name, var_5b9ad5b3 )
{
    if ( !isdefined( var_5b9ad5b3 ) )
    {
        var_5b9ad5b3 = 1;
    }
    
    assert( isdefined( self.var_6c3e78bb[ str_name ] ), "<dev string:x28>" + str_name + "<dev string:x3e>" );
    self.var_6c3e78bb[ str_name ] = var_5b9ad5b3;
}

// Namespace hazard
// Params 3, eflags: 0x4
// Checksum 0xf67374c3, Offset: 0xbe8
// Size: 0x38c
function private _fill_hazard_protection( str_name, e_ent, disable_ui )
{
    self notify( "_hazard_protection_" + str_name );
    self endon( "_hazard_protection_" + str_name );
    self endon( #"death" );
    s_hazard = level.hazards[ str_name ];
    str_ui_model = "";
    
    foreach ( model, type in self.hazard_ui_models )
    {
        if ( type == s_hazard.n_type )
        {
            str_ui_model = model;
            break;
        }
    }
    
    if ( str_ui_model == "" )
    {
        foreach ( model, type in self.hazard_ui_models )
        {
            if ( type == 0 )
            {
                str_ui_model = model;
                break;
            }
        }
    }
    
    if ( str_ui_model != "" )
    {
        if ( !disable_ui )
        {
            self setcontrolleruimodelvalue( str_ui_model + ".type", s_hazard.n_type );
        }
        
        self.hazard_ui_models[ str_ui_model ] = s_hazard.n_type;
    }
    
    do
    {
        n_frac = mapfloat( 0, s_hazard.n_max_protection, 1, 0, self.hazard_damage[ str_name ] );
        
        if ( str_ui_model != "" && !disable_ui )
        {
            self setcontrolleruimodelvalue( str_ui_model + ".ratio", n_frac );
        }
        
        if ( isdefined( s_hazard.func_update ) )
        {
            [[ s_hazard.func_update ]]( n_frac, e_ent );
        }
        
        wait 0.05;
        
        if ( self.var_6c3e78bb[ str_name ] == 1 )
        {
            self.hazard_damage[ str_name ] -= s_hazard.n_regen_rate * 0.05;
        }
    }
    while ( self.hazard_damage[ str_name ] >= 0 );
    
    self function_45f02912();
    
    if ( str_ui_model != "" )
    {
        if ( !disable_ui )
        {
            self setcontrolleruimodelvalue( str_ui_model + ".type", 0 );
        }
        
        self.hazard_ui_models[ str_ui_model ] = 0;
        return;
    }
    
    assert( "<dev string:x4c>" );
}

// Namespace hazard
// Params 0
// Checksum 0xfdb4c3a0, Offset: 0xf80
// Size: 0x44
function function_45f02912()
{
    self clientfield::set( "burn", 0 );
    self clientfield::set_to_player( "player_cam_bubbles", 0 );
}

// Namespace hazard
// Params 2
// Checksum 0xdf4b273f, Offset: 0xfd0
// Size: 0xe4
function function_476442fb( n_damage_frac, e_ent )
{
    if ( !isdefined( e_ent ) || scene::is_igc_active() )
    {
        self.var_65e617f8 = undefined;
        self clientfield::set( "burn", 0 );
        return;
    }
    
    if ( !( isdefined( self.var_65e617f8 ) && self.var_65e617f8 ) && self istouching( e_ent ) )
    {
        self clientfield::set( "burn", 1 );
        return;
    }
    
    self.var_65e617f8 = undefined;
    self clientfield::set( "burn", 0 );
}

// Namespace hazard
// Params 0
// Checksum 0xe9c8fd62, Offset: 0x10c0
// Size: 0x54
function function_503a50a8()
{
    self endon( #"death" );
    self clientfield::set_to_player( "player_cam_bubbles", 1 );
    wait 4;
    self clientfield::set_to_player( "player_cam_bubbles", 0 );
}

// Namespace hazard
// Params 2
// Checksum 0x173e20b7, Offset: 0x1120
// Size: 0x214
function function_8b413656( var_d2eebe84, e_ent )
{
    if ( !isdefined( self.var_18c7e911 ) )
    {
        self.var_18c7e911 = 0;
    }
    
    if ( var_d2eebe84 <= 0.2 )
    {
        if ( self.var_18c7e911 > 0.2 )
        {
            self thread function_503a50a8();
        }
    }
    else if ( var_d2eebe84 <= 0.1 )
    {
        if ( self.var_18c7e911 > 0.1 )
        {
            self thread function_503a50a8();
        }
    }
    
    var_b45ec125 = array( 0.5, 0.3, 0.2, 0.15, 0.1, 0.5 );
    
    foreach ( num in var_b45ec125 )
    {
        if ( var_d2eebe84 != 0 && var_d2eebe84 <= num )
        {
            if ( self.var_18c7e911 > num )
            {
                self playsound( "vox_plyr_uw_gasp" );
                
                if ( num < 0.4 )
                {
                    self thread function_fda01c41( "vox_plyr_uw_emerge_gasp" );
                }
                else
                {
                    self thread function_fda01c41( "vox_plyr_uw_emerge" );
                }
                
                break;
            }
        }
    }
    
    self.var_18c7e911 = var_d2eebe84;
}

// Namespace hazard
// Params 1
// Checksum 0x15c159cc, Offset: 0x1340
// Size: 0x84
function function_fda01c41( alias )
{
    self notify( #"hash_fda01c41" );
    self endon( #"hash_fda01c41" );
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"save_restore" );
    
    while ( self isplayerunderwater() )
    {
        wait 0.1;
    }
    
    self playsound( alias );
}

// Namespace hazard
// Params 2
// Checksum 0x76e0ff17, Offset: 0x13d0
// Size: 0x54
function function_e9b126ef( n_time, var_827d6de0 )
{
    if ( !isdefined( var_827d6de0 ) )
    {
        var_827d6de0 = 1;
    }
    
    self thread function_ccddb105( "o2", 4, n_time, var_827d6de0 );
}

// Namespace hazard
// Params 4
// Checksum 0x40dde053, Offset: 0x1430
// Size: 0x1fa
function function_ccddb105( str_hazard, var_6d20ee14, n_time, var_827d6de0 )
{
    assert( isdefined( level.hazards[ str_hazard ] ), "<dev string:x28>" + str_hazard + "<dev string:x3e>" );
    self notify( "stop_hazard_dot_" + str_hazard );
    self endon( "stop_hazard_dot_" + str_hazard );
    self endon( #"death" );
    self function_459e5eff( str_hazard, 0 );
    var_dd075cd2 = 1;
    s_hazard = level.hazards[ str_hazard ];
    n_damage = var_6d20ee14;
    
    if ( isdefined( n_time ) )
    {
        var_97dd249c = self function_eaa9157d( str_hazard );
        var_90d01cd2 = s_hazard.n_max_protection;
        var_7046c7b3 = var_827d6de0 * var_90d01cd2;
        var_a6321c17 = var_7046c7b3 - var_97dd249c;
        
        if ( var_a6321c17 > 0 )
        {
        }
    }
    
    for ( n_damage = var_a6321c17 / n_time; true ; n_damage = var_6d20ee14 )
    {
        wait 1;
        var_dd075cd2 = self do_damage( str_hazard, n_damage );
        var_7ba0abc9 = self function_b78a859e( str_hazard );
        
        if ( n_damage > var_6d20ee14 && var_7ba0abc9 >= var_827d6de0 )
        {
        }
    }
}

// Namespace hazard
// Params 1
// Checksum 0x10c8cc52, Offset: 0x1638
// Size: 0x3c
function function_60455f28( str_hazard )
{
    self notify( "stop_hazard_dot_" + str_hazard );
    self function_459e5eff( str_hazard, 1 );
}

