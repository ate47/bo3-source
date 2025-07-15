#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/math_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicleriders_shared;

#namespace vehicle;

// Namespace vehicle
// Params 0, eflags: 0x2
// Checksum 0x806484a3, Offset: 0x6b8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "vehicle_shared", &__init__, undefined, undefined );
}

// Namespace vehicle
// Params 0
// Checksum 0xfb287f0, Offset: 0x6f8
// Size: 0xd9c
function __init__()
{
    level._customvehiclecbfunc = &spawned_callback;
    clientfield::register( "vehicle", "toggle_lockon", 1, 1, "int", &field_toggle_lockon_handler, 0, 0 );
    clientfield::register( "vehicle", "toggle_sounds", 1, 1, "int", &field_toggle_sounds, 0, 0 );
    clientfield::register( "vehicle", "use_engine_damage_sounds", 1, 2, "int", &field_use_engine_damage_sounds, 0, 0 );
    clientfield::register( "vehicle", "toggle_treadfx", 1, 1, "int", &field_toggle_treadfx, 0, 0 );
    clientfield::register( "vehicle", "toggle_exhaustfx", 1, 1, "int", &field_toggle_exhaustfx_handler, 0, 0 );
    clientfield::register( "vehicle", "toggle_lights", 1, 2, "int", &field_toggle_lights_handler, 0, 0 );
    clientfield::register( "vehicle", "toggle_lights_group1", 1, 1, "int", &field_toggle_lights_group_handler1, 0, 0 );
    clientfield::register( "vehicle", "toggle_lights_group2", 1, 1, "int", &field_toggle_lights_group_handler2, 0, 0 );
    clientfield::register( "vehicle", "toggle_lights_group3", 1, 1, "int", &field_toggle_lights_group_handler3, 0, 0 );
    clientfield::register( "vehicle", "toggle_lights_group4", 1, 1, "int", &field_toggle_lights_group_handler4, 0, 0 );
    clientfield::register( "vehicle", "toggle_ambient_anim_group1", 1, 1, "int", &field_toggle_ambient_anim_handler1, 0, 0 );
    clientfield::register( "vehicle", "toggle_ambient_anim_group2", 1, 1, "int", &field_toggle_ambient_anim_handler2, 0, 0 );
    clientfield::register( "vehicle", "toggle_ambient_anim_group3", 1, 1, "int", &field_toggle_ambient_anim_handler3, 0, 0 );
    clientfield::register( "vehicle", "toggle_emp_fx", 1, 1, "int", &field_toggle_emp, 0, 0 );
    clientfield::register( "vehicle", "toggle_burn_fx", 1, 1, "int", &field_toggle_burn, 0, 0 );
    clientfield::register( "vehicle", "deathfx", 1, 2, "int", &field_do_deathfx, 0, 0 );
    clientfield::register( "vehicle", "alert_level", 1, 2, "int", &field_update_alert_level, 0, 0 );
    clientfield::register( "vehicle", "set_lighting_ent", 1, 1, "int", &util::field_set_lighting_ent, 0, 0 );
    clientfield::register( "vehicle", "use_lighting_ent", 1, 1, "int", &util::field_use_lighting_ent, 0, 0 );
    clientfield::register( "vehicle", "damage_level", 1, 3, "int", &field_update_damage_state, 0, 0 );
    clientfield::register( "vehicle", "spawn_death_dynents", 1, 2, "int", &field_death_spawn_dynents, 0, 0 );
    clientfield::register( "vehicle", "spawn_gib_dynents", 1, 1, "int", &field_gib_spawn_dynents, 0, 0 );
    clientfield::register( "helicopter", "toggle_lockon", 1, 1, "int", &field_toggle_lockon_handler, 0, 0 );
    clientfield::register( "helicopter", "toggle_sounds", 1, 1, "int", &field_toggle_sounds, 0, 0 );
    clientfield::register( "helicopter", "use_engine_damage_sounds", 1, 2, "int", &field_use_engine_damage_sounds, 0, 0 );
    clientfield::register( "helicopter", "toggle_treadfx", 1, 1, "int", &field_toggle_treadfx, 0, 0 );
    clientfield::register( "helicopter", "toggle_exhaustfx", 1, 1, "int", &field_toggle_exhaustfx_handler, 0, 0 );
    clientfield::register( "helicopter", "toggle_lights", 1, 2, "int", &field_toggle_lights_handler, 0, 0 );
    clientfield::register( "helicopter", "toggle_lights_group1", 1, 1, "int", &field_toggle_lights_group_handler1, 0, 0 );
    clientfield::register( "helicopter", "toggle_lights_group2", 1, 1, "int", &field_toggle_lights_group_handler2, 0, 0 );
    clientfield::register( "helicopter", "toggle_lights_group3", 1, 1, "int", &field_toggle_lights_group_handler3, 0, 0 );
    clientfield::register( "helicopter", "toggle_lights_group4", 1, 1, "int", &field_toggle_lights_group_handler4, 0, 0 );
    clientfield::register( "helicopter", "toggle_ambient_anim_group1", 1, 1, "int", &field_toggle_ambient_anim_handler1, 0, 0 );
    clientfield::register( "helicopter", "toggle_ambient_anim_group2", 1, 1, "int", &field_toggle_ambient_anim_handler2, 0, 0 );
    clientfield::register( "helicopter", "toggle_ambient_anim_group3", 1, 1, "int", &field_toggle_ambient_anim_handler3, 0, 0 );
    clientfield::register( "helicopter", "toggle_emp_fx", 1, 1, "int", &field_toggle_emp, 0, 0 );
    clientfield::register( "helicopter", "toggle_burn_fx", 1, 1, "int", &field_toggle_burn, 0, 0 );
    clientfield::register( "helicopter", "deathfx", 1, 1, "int", &field_do_deathfx, 0, 0 );
    clientfield::register( "helicopter", "alert_level", 1, 2, "int", &field_update_alert_level, 0, 0 );
    clientfield::register( "helicopter", "set_lighting_ent", 1, 1, "int", &util::field_set_lighting_ent, 0, 0 );
    clientfield::register( "helicopter", "use_lighting_ent", 1, 1, "int", &util::field_use_lighting_ent, 0, 0 );
    clientfield::register( "helicopter", "damage_level", 1, 3, "int", &field_update_damage_state, 0, 0 );
    clientfield::register( "helicopter", "spawn_death_dynents", 1, 2, "int", &field_death_spawn_dynents, 0, 0 );
    clientfield::register( "helicopter", "spawn_gib_dynents", 1, 1, "int", &field_gib_spawn_dynents, 0, 0 );
    clientfield::register( "plane", "toggle_treadfx", 1, 1, "int", &field_toggle_treadfx, 0, 0 );
    clientfield::register( "toplayer", "toggle_dnidamagefx", 1, 1, "int", &field_toggle_dnidamagefx, 0, 0 );
    clientfield::register( "toplayer", "toggle_flir_postfx", 1, 2, "int", &toggle_flir_postfxbundle, 0, 0 );
    clientfield::register( "toplayer", "static_postfx", 1, 1, "int", &set_static_postfxbundle, 0, 0 );
}

// Namespace vehicle
// Params 2
// Checksum 0x205773e8, Offset: 0x14a0
// Size: 0x3e
function add_vehicletype_callback( vehicletype, callback )
{
    if ( !isdefined( level.vehicletypecallbackarray ) )
    {
        level.vehicletypecallbackarray = [];
    }
    
    level.vehicletypecallbackarray[ vehicletype ] = callback;
}

// Namespace vehicle
// Params 1
// Checksum 0xa7093b3, Offset: 0x14e8
// Size: 0xd6
function spawned_callback( localclientnum )
{
    if ( isdefined( self.vehicleridersbundle ) )
    {
        set_vehicleriders_bundle( self.vehicleridersbundle );
    }
    
    vehicletype = self.vehicletype;
    
    if ( isdefined( level.vehicletypecallbackarray ) )
    {
        if ( isdefined( vehicletype ) && isdefined( level.vehicletypecallbackarray[ vehicletype ] ) )
        {
            self thread [[ level.vehicletypecallbackarray[ vehicletype ] ]]( localclientnum );
            return;
        }
        
        if ( isdefined( self.scriptvehicletype ) && isdefined( level.vehicletypecallbackarray[ self.scriptvehicletype ] ) )
        {
            self thread [[ level.vehicletypecallbackarray[ self.scriptvehicletype ] ]]( localclientnum );
        }
    }
}

// Namespace vehicle
// Params 1
// Checksum 0x63f580cd, Offset: 0x15c8
// Size: 0x2a8
function rumble( localclientnum )
{
    self endon( #"entityshutdown" );
    
    if ( !isdefined( self.rumbletype ) || self.rumbleradius == 0 )
    {
        return;
    }
    
    if ( !isdefined( self.rumbleon ) )
    {
        self.rumbleon = 1;
    }
    
    height = self.rumbleradius * 2;
    zoffset = -1 * self.rumbleradius;
    self.player_touching = 0;
    radius_squared = self.rumbleradius * self.rumbleradius;
    wait 2;
    
    while ( true )
    {
        if ( !isdefined( level.localplayers[ localclientnum ] ) || distancesquared( self.origin, level.localplayers[ localclientnum ].origin ) > radius_squared || self getspeed() == 0 )
        {
            wait 0.2;
            continue;
        }
        
        if ( isdefined( self.rumbleon ) && !self.rumbleon )
        {
            wait 0.2;
            continue;
        }
        
        self playrumblelooponentity( localclientnum, self.rumbletype );
        
        while ( isdefined( level.localplayers[ localclientnum ] ) && distancesquared( self.origin, level.localplayers[ localclientnum ].origin ) < radius_squared && self getspeed() > 0 )
        {
            self earthquake( self.rumblescale, self.rumbleduration, self.origin, self.rumbleradius );
            time_to_wait = self.rumblebasetime + randomfloat( self.rumbleadditionaltime );
            
            if ( time_to_wait <= 0 )
            {
                time_to_wait = 0.05;
            }
            
            wait time_to_wait;
        }
        
        if ( isdefined( level.localplayers[ localclientnum ] ) )
        {
            self stoprumble( localclientnum, self.rumbletype );
        }
        
        wait 0.05;
    }
}

// Namespace vehicle
// Params 0
// Checksum 0x9fc38d0c, Offset: 0x1878
// Size: 0x12
function kill_treads_forever()
{
    self notify( #"kill_treads_forever" );
}

// Namespace vehicle
// Params 1
// Checksum 0x71f807de, Offset: 0x1898
// Size: 0x1b4
function play_exhaust( localclientnum )
{
    if ( isdefined( self.csf_no_exhaust ) && self.csf_no_exhaust )
    {
        return;
    }
    
    if ( !isdefined( self.exhaust_fx ) && isdefined( self.exhaustfxname ) )
    {
        if ( !isdefined( level._effect ) )
        {
            level._effect = [];
        }
        
        if ( !isdefined( level._effect[ self.exhaustfxname ] ) )
        {
            level._effect[ self.exhaustfxname ] = self.exhaustfxname;
        }
        
        self.exhaust_fx = level._effect[ self.exhaustfxname ];
    }
    
    if ( isdefined( self.exhaust_fx ) && isdefined( self.exhaustfxtag1 ) )
    {
        if ( isalive( self ) )
        {
            assert( isdefined( self.exhaustfxtag1 ), self.vehicletype + "<dev string:x28>" );
            self endon( #"entityshutdown" );
            self wait_for_dobj( localclientnum );
            self.exhaust_id_left = playfxontag( localclientnum, self.exhaust_fx, self, self.exhaustfxtag1 );
            
            if ( !isdefined( self.exhaust_id_right ) && isdefined( self.exhaustfxtag2 ) )
            {
                self.exhaust_id_right = playfxontag( localclientnum, self.exhaust_fx, self, self.exhaustfxtag2 );
            }
            
            self thread kill_exhaust_watcher( localclientnum );
        }
    }
}

// Namespace vehicle
// Params 1
// Checksum 0xb0f956f7, Offset: 0x1a58
// Size: 0x86
function kill_exhaust_watcher( localclientnum )
{
    self waittill( #"stop_exhaust_fx" );
    
    if ( isdefined( self.exhaust_id_left ) )
    {
        stopfx( localclientnum, self.exhaust_id_left );
        self.exhaust_id_left = undefined;
    }
    
    if ( isdefined( self.exhaust_id_right ) )
    {
        stopfx( localclientnum, self.exhaust_id_right );
        self.exhaust_id_right = undefined;
    }
}

// Namespace vehicle
// Params 1
// Checksum 0xc8650c06, Offset: 0x1ae8
// Size: 0x1a
function stop_exhaust( localclientnum )
{
    self notify( #"stop_exhaust_fx" );
}

// Namespace vehicle
// Params 0
// Checksum 0x46d6b1e2, Offset: 0x1b10
// Size: 0x2a6
function aircraft_dustkick()
{
    waittillframeend();
    self endon( #"kill_treads_forever" );
    self endon( #"entityshutdown" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.csf_no_tread ) && self.csf_no_tread )
    {
        return;
    }
    
    if ( self.vehicleclass == "plane_mig17" || self.vehicleclass == "plane_mig21" )
    {
        numframespertrace = 1;
    }
    else
    {
        numframespertrace = 3;
    }
    
    dotracethisframe = numframespertrace;
    repeatrate = 1;
    trace = undefined;
    d = undefined;
    trace_ent = self;
    
    while ( isdefined( self ) )
    {
        if ( repeatrate <= 0 )
        {
            repeatrate = 1;
        }
        
        if ( self.vehicleclass == "plane_mig17" || self.vehicleclass == "plane_mig21" )
        {
            repeatrate = 0.02;
        }
        
        wait repeatrate;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        dotracethisframe--;
        
        if ( dotracethisframe <= 0 )
        {
            dotracethisframe = numframespertrace;
            trace = tracepoint( trace_ent.origin, trace_ent.origin - ( 0, 0, 100000 ) );
            d = distance( trace_ent.origin, trace[ "position" ] );
            
            if ( d > 350 )
            {
                repeatrate = ( d - 350 ) / ( 1200 - 350 ) * ( 0.2 - 0.1 ) + 0.1;
            }
            else
            {
                repeatrate = 0.1;
            }
        }
        
        if ( isdefined( trace ) )
        {
            if ( d > 1200 )
            {
                repeatrate = 1;
                continue;
            }
            
            if ( !isdefined( trace[ "surfacetype" ] ) )
            {
                trace[ "surfacetype" ] = "dirt";
            }
        }
    }
}

// Namespace vehicle
// Params 0
// Checksum 0xa1c60700, Offset: 0x1dc0
// Size: 0x1ba
function weapon_fired()
{
    self endon( #"entityshutdown" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        players = level.localplayers;
        
        for ( i = 0; i < players.size ; i++ )
        {
            player_distance = distancesquared( self.origin, players[ i ].origin );
            
            if ( player_distance < 250000 )
            {
                if ( isdefined( self.shootrumble ) && self.shootrumble != "" )
                {
                    playrumbleonposition( i, self.shootrumble, self.origin + ( 0, 0, 32 ) );
                }
            }
            
            if ( player_distance < 160000 )
            {
                fraction = player_distance / 160000;
                time = 4 - 3 * fraction;
                
                if ( isdefined( players[ i ] ) )
                {
                    if ( isdefined( self.shootshock ) && self.shootshock != "" )
                    {
                        players[ i ] shellshock( i, self.shootshock, time );
                    }
                }
            }
        }
    }
}

// Namespace vehicle
// Params 1
// Checksum 0x81186169, Offset: 0x1f88
// Size: 0x7c
function wait_for_dobj( localclientnum )
{
    count = 30;
    
    while ( !self hasdobj( localclientnum ) )
    {
        if ( count < 0 )
        {
            /#
                iprintlnbold( "<dev string:x84>" );
            #/
            
            return;
        }
        
        wait 0.016;
        count -= 1;
    }
}

// Namespace vehicle
// Params 2
// Checksum 0x235a4eff, Offset: 0x2010
// Size: 0x136
function lights_on( localclientnum, team )
{
    self endon( #"entityshutdown" );
    lights_off( localclientnum );
    wait_for_dobj( localclientnum );
    
    if ( isdefined( self.lightfxnamearray ) )
    {
        if ( !isdefined( self.light_fx_handles ) )
        {
            self.light_fx_handles = [];
        }
        
        for ( i = 0; i < self.lightfxnamearray.size ; i++ )
        {
            self.light_fx_handles[ i ] = playfxontag( localclientnum, self.lightfxnamearray[ i ], self, self.lightfxtagarray[ i ] );
            setfxignorepause( localclientnum, self.light_fx_handles[ i ], 1 );
            
            if ( isdefined( team ) )
            {
                setfxteam( localclientnum, self.light_fx_handles[ i ], team );
            }
        }
    }
}

// Namespace vehicle
// Params 6
// Checksum 0x9e42fc82, Offset: 0x2150
// Size: 0x112
function addanimtolist( animitem, &liston, &listoff, playwhenoff, id, maxid )
{
    if ( isdefined( animitem ) && id <= maxid )
    {
        if ( playwhenoff === 1 )
        {
            if ( !isdefined( listoff ) )
            {
                listoff = [];
            }
            else if ( !isarray( listoff ) )
            {
                listoff = array( listoff );
            }
            
            listoff[ listoff.size ] = animitem;
            return;
        }
        
        if ( !isdefined( liston ) )
        {
            liston = [];
        }
        else if ( !isarray( liston ) )
        {
            liston = array( liston );
        }
        
        liston[ liston.size ] = animitem;
    }
}

// Namespace vehicle
// Params 3
// Checksum 0x34924c8c, Offset: 0x2270
// Size: 0x5ee
function ambient_anim_toggle( localclientnum, groupid, ison )
{
    self endon( #"entityshutdown" );
    
    if ( !isdefined( self.scriptbundlesettings ) )
    {
        return;
    }
    
    settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    
    if ( !isdefined( settings ) )
    {
        return;
    }
    
    wait_for_dobj( localclientnum );
    liston = [];
    listoff = [];
    
    switch ( groupid )
    {
        case 1:
            addanimtolist( settings.ambient_group1_anim1, liston, listoff, settings.ambient_group1_off1, 1, settings.ambient_group1_numslots );
            addanimtolist( settings.ambient_group1_anim2, liston, listoff, settings.ambient_group1_off2, 2, settings.ambient_group1_numslots );
            addanimtolist( settings.ambient_group1_anim3, liston, listoff, settings.ambient_group1_off3, 3, settings.ambient_group1_numslots );
            addanimtolist( settings.ambient_group1_anim4, liston, listoff, settings.ambient_group1_off4, 4, settings.ambient_group1_numslots );
            break;
        case 2:
            addanimtolist( settings.ambient_group2_anim1, liston, listoff, settings.ambient_group2_off1, 1, settings.ambient_group2_numslots );
            addanimtolist( settings.ambient_group2_anim2, liston, listoff, settings.ambient_group2_off2, 2, settings.ambient_group2_numslots );
            addanimtolist( settings.ambient_group2_anim3, liston, listoff, settings.ambient_group2_off3, 3, settings.ambient_group2_numslots );
            addanimtolist( settings.ambient_group2_anim4, liston, listoff, settings.ambient_group2_off4, 4, settings.ambient_group2_numslots );
            break;
        case 3:
            addanimtolist( settings.ambient_group3_anim1, liston, listoff, settings.ambient_group3_off1, 1, settings.ambient_group3_numslots );
            addanimtolist( settings.ambient_group3_anim2, liston, listoff, settings.ambient_group3_off2, 2, settings.ambient_group3_numslots );
            addanimtolist( settings.ambient_group3_anim3, liston, listoff, settings.ambient_group3_off3, 3, settings.ambient_group3_numslots );
            addanimtolist( settings.ambient_group3_anim4, liston, listoff, settings.ambient_group3_off4, 4, settings.ambient_group3_numslots );
            break;
        case 4:
            addanimtolist( settings.ambient_group4_anim1, liston, listoff, settings.ambient_group4_off1, 1, settings.ambient_group4_numslots );
            addanimtolist( settings.ambient_group4_anim2, liston, listoff, settings.ambient_group4_off2, 2, settings.ambient_group4_numslots );
            addanimtolist( settings.ambient_group4_anim3, liston, listoff, settings.ambient_group4_off3, 3, settings.ambient_group4_numslots );
            addanimtolist( settings.ambient_group4_anim4, liston, listoff, settings.ambient_group4_off4, 4, settings.ambient_group4_numslots );
            break;
    }
    
    if ( ison )
    {
        weighton = 1;
        weightoff = 0;
    }
    else
    {
        weighton = 0;
        weightoff = 1;
    }
    
    for ( i = 0; i < liston.size ; i++ )
    {
        self setanim( liston[ i ], weighton, 0.2, 1 );
    }
    
    for ( i = 0; i < listoff.size ; i++ )
    {
        self setanim( listoff[ i ], weightoff, 0.2, 1 );
    }
}

// Namespace vehicle
// Params 7
// Checksum 0x3c115fe6, Offset: 0x2868
// Size: 0x5c
function field_toggle_ambient_anim_handler1( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self ambient_anim_toggle( localclientnum, 1, newval );
}

// Namespace vehicle
// Params 7
// Checksum 0x9795c8ea, Offset: 0x28d0
// Size: 0x5c
function field_toggle_ambient_anim_handler2( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self ambient_anim_toggle( localclientnum, 2, newval );
}

// Namespace vehicle
// Params 7
// Checksum 0x77f3c9f2, Offset: 0x2938
// Size: 0x5c
function field_toggle_ambient_anim_handler3( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self ambient_anim_toggle( localclientnum, 3, newval );
}

// Namespace vehicle
// Params 7
// Checksum 0x13202d04, Offset: 0x29a0
// Size: 0x5c
function field_toggle_ambient_anim_handler4( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self ambient_anim_toggle( localclientnum, 4, newval );
}

// Namespace vehicle
// Params 3
// Checksum 0xbf9aa550, Offset: 0x2a08
// Size: 0x7a2
function lights_group_toggle( localclientnum, id, ison )
{
    self endon( #"entityshutdown" );
    
    if ( !isdefined( self.scriptbundlesettings ) )
    {
        return;
    }
    
    settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    
    if ( !isdefined( settings ) || !isdefined( settings.lightgroups_numgroups ) )
    {
        return;
    }
    
    wait_for_dobj( localclientnum );
    groupid = id - 1;
    
    if ( isdefined( self.lightfxgroups ) && groupid < self.lightfxgroups.size )
    {
        foreach ( fx_handle in self.lightfxgroups[ groupid ] )
        {
            stopfx( localclientnum, fx_handle );
        }
    }
    
    if ( !ison )
    {
        return;
    }
    
    if ( !isdefined( self.lightfxgroups ) )
    {
        self.lightfxgroups = [];
        
        for ( i = 0; i < settings.lightgroups_numgroups ; i++ )
        {
            newfxhandlearray = [];
            
            if ( !isdefined( self.lightfxgroups ) )
            {
                self.lightfxgroups = [];
            }
            else if ( !isarray( self.lightfxgroups ) )
            {
                self.lightfxgroups = array( self.lightfxgroups );
            }
            
            self.lightfxgroups[ self.lightfxgroups.size ] = newfxhandlearray;
        }
    }
    
    self.lightfxgroups[ groupid ] = [];
    fxlist = [];
    taglist = [];
    
    switch ( groupid )
    {
        case 0:
            addfxandtagtolists( settings.lightgroups_1_fx1, settings.lightgroups_1_tag1, fxlist, taglist, 1, settings.lightgroups_1_numslots );
            addfxandtagtolists( settings.lightgroups_1_fx2, settings.lightgroups_1_tag2, fxlist, taglist, 2, settings.lightgroups_1_numslots );
            addfxandtagtolists( settings.lightgroups_1_fx3, settings.lightgroups_1_tag3, fxlist, taglist, 3, settings.lightgroups_1_numslots );
            addfxandtagtolists( settings.lightgroups_1_fx4, settings.lightgroups_1_tag4, fxlist, taglist, 4, settings.lightgroups_1_numslots );
            break;
        case 1:
            addfxandtagtolists( settings.lightgroups_2_fx1, settings.lightgroups_2_tag1, fxlist, taglist, 1, settings.lightgroups_2_numslots );
            addfxandtagtolists( settings.lightgroups_2_fx2, settings.lightgroups_2_tag2, fxlist, taglist, 2, settings.lightgroups_2_numslots );
            addfxandtagtolists( settings.lightgroups_2_fx3, settings.lightgroups_2_tag3, fxlist, taglist, 3, settings.lightgroups_2_numslots );
            addfxandtagtolists( settings.lightgroups_2_fx4, settings.lightgroups_2_tag4, fxlist, taglist, 4, settings.lightgroups_2_numslots );
            break;
        case 2:
            addfxandtagtolists( settings.lightgroups_3_fx1, settings.lightgroups_3_tag1, fxlist, taglist, 1, settings.lightgroups_3_numslots );
            addfxandtagtolists( settings.lightgroups_3_fx2, settings.lightgroups_3_tag2, fxlist, taglist, 2, settings.lightgroups_3_numslots );
            addfxandtagtolists( settings.lightgroups_3_fx3, settings.lightgroups_3_tag3, fxlist, taglist, 3, settings.lightgroups_3_numslots );
            addfxandtagtolists( settings.lightgroups_3_fx4, settings.lightgroups_3_tag4, fxlist, taglist, 4, settings.lightgroups_3_numslots );
            break;
        case 3:
            addfxandtagtolists( settings.lightgroups_4_fx1, settings.lightgroups_4_tag1, fxlist, taglist, 1, settings.lightgroups_4_numslots );
            addfxandtagtolists( settings.lightgroups_4_fx2, settings.lightgroups_4_tag2, fxlist, taglist, 2, settings.lightgroups_4_numslots );
            addfxandtagtolists( settings.lightgroups_4_fx3, settings.lightgroups_4_tag3, fxlist, taglist, 3, settings.lightgroups_4_numslots );
            addfxandtagtolists( settings.lightgroups_4_fx4, settings.lightgroups_4_tag4, fxlist, taglist, 4, settings.lightgroups_4_numslots );
            break;
    }
    
    for ( i = 0; i < fxlist.size ; i++ )
    {
        fx_handle = playfxontag( localclientnum, fxlist[ i ], self, taglist[ i ] );
        
        if ( !isdefined( self.lightfxgroups[ groupid ] ) )
        {
            self.lightfxgroups[ groupid ] = [];
        }
        else if ( !isarray( self.lightfxgroups[ groupid ] ) )
        {
            self.lightfxgroups[ groupid ] = array( self.lightfxgroups[ groupid ] );
        }
        
        self.lightfxgroups[ groupid ][ self.lightfxgroups[ groupid ].size ] = fx_handle;
    }
}

// Namespace vehicle
// Params 7
// Checksum 0xb2754e46, Offset: 0x31b8
// Size: 0x5c
function field_toggle_lights_group_handler1( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self lights_group_toggle( localclientnum, 1, newval );
}

// Namespace vehicle
// Params 7
// Checksum 0x29a93f2, Offset: 0x3220
// Size: 0x5c
function field_toggle_lights_group_handler2( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self lights_group_toggle( localclientnum, 2, newval );
}

// Namespace vehicle
// Params 7
// Checksum 0x4bfdf16a, Offset: 0x3288
// Size: 0x5c
function field_toggle_lights_group_handler3( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self lights_group_toggle( localclientnum, 3, newval );
}

// Namespace vehicle
// Params 7
// Checksum 0x6bfa43a9, Offset: 0x32f0
// Size: 0x5c
function field_toggle_lights_group_handler4( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self lights_group_toggle( localclientnum, 4, newval );
}

// Namespace vehicle
// Params 1
// Checksum 0x1f9476d9, Offset: 0x3358
// Size: 0x6e
function delete_alert_lights( localclientnum )
{
    if ( isdefined( self.alert_light_fx_handles ) )
    {
        for ( i = 0; i < self.alert_light_fx_handles.size ; i++ )
        {
            stopfx( localclientnum, self.alert_light_fx_handles[ i ] );
        }
    }
    
    self.alert_light_fx_handles = undefined;
}

// Namespace vehicle
// Params 1
// Checksum 0x328f30b3, Offset: 0x33d0
// Size: 0x84
function lights_off( localclientnum )
{
    if ( isdefined( self.light_fx_handles ) )
    {
        for ( i = 0; i < self.light_fx_handles.size ; i++ )
        {
            stopfx( localclientnum, self.light_fx_handles[ i ] );
        }
    }
    
    self.light_fx_handles = undefined;
    delete_alert_lights( localclientnum );
}

// Namespace vehicle
// Params 7
// Checksum 0x642d0fb0, Offset: 0x3460
// Size: 0x64
function field_toggle_emp( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self thread toggle_fx_bundle( localclientnum, "emp_base", newval == 1 );
}

// Namespace vehicle
// Params 7
// Checksum 0xf2e88636, Offset: 0x34d0
// Size: 0x64
function field_toggle_burn( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self thread toggle_fx_bundle( localclientnum, "burn_base", newval == 1 );
}

// Namespace vehicle
// Params 3
// Checksum 0x3fa75967, Offset: 0x3540
// Size: 0x2ce
function toggle_fx_bundle( localclientnum, name, turnon )
{
    if ( !isdefined( self.settings ) && isdefined( self.scriptbundlesettings ) )
    {
        self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    }
    
    if ( !isdefined( self.settings ) )
    {
        return;
    }
    
    self endon( #"entityshutdown" );
    self notify( "end_toggle_field_fx_" + name );
    self endon( "end_toggle_field_fx_" + name );
    wait_for_dobj( localclientnum );
    
    if ( !isdefined( self.fx_handles ) )
    {
        self.fx_handles = [];
    }
    
    if ( isdefined( self.fx_handles[ name ] ) )
    {
        handle = self.fx_handles[ name ];
        
        if ( isarray( handle ) )
        {
            foreach ( handleelement in handle )
            {
                stopfx( localclientnum, handleelement );
            }
        }
        else
        {
            stopfx( localclientnum, handle );
        }
    }
    
    if ( turnon )
    {
        for ( i = 1;  ; i++ )
        {
            fx = getstructfield( self.settings, name + "_fx_" + i );
            
            if ( !isdefined( fx ) )
            {
                return;
            }
            
            tag = getstructfield( self.settings, name + "_tag_" + i );
            delay = getstructfield( self.settings, name + "_delay_" + i );
            self thread delayed_fx_thread( localclientnum, name, fx, tag, delay );
        }
    }
}

// Namespace vehicle
// Params 5
// Checksum 0xf556ae1e, Offset: 0x3818
// Size: 0x138
function delayed_fx_thread( localclientnum, name, fx, tag, delay )
{
    self endon( #"entityshutdown" );
    self endon( "end_toggle_field_fx_" + name );
    
    if ( !isdefined( tag ) )
    {
        return;
    }
    
    if ( isdefined( delay ) && delay > 0 )
    {
        wait delay;
    }
    
    fx_handle = playfxontag( localclientnum, fx, self, tag );
    
    if ( !isdefined( self.fx_handles[ name ] ) )
    {
        self.fx_handles[ name ] = [];
    }
    else if ( !isarray( self.fx_handles[ name ] ) )
    {
        self.fx_handles[ name ] = array( self.fx_handles[ name ] );
    }
    
    self.fx_handles[ name ][ self.fx_handles[ name ].size ] = fx_handle;
}

// Namespace vehicle
// Params 7
// Checksum 0x20e365ab, Offset: 0x3958
// Size: 0xd4
function field_toggle_sounds( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.vehicleclass ) && self.vehicleclass == "helicopter" )
    {
        if ( newval )
        {
            self notify( #"stop_heli_sounds" );
            self.should_not_play_sounds = 1;
        }
        else
        {
            self notify( #"play_heli_sounds" );
            self.should_not_play_sounds = 0;
        }
    }
    
    if ( newval )
    {
        self disablevehiclesounds();
        return;
    }
    
    self enablevehiclesounds();
}

// Namespace vehicle
// Params 7
// Checksum 0xf54dd689, Offset: 0x3a38
// Size: 0x64
function field_toggle_dnidamagefx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self thread postfx::playpostfxbundle( "pstfx_dni_vehicle_dmg" );
    }
}

// Namespace vehicle
// Params 7
// Checksum 0xc3fbd217, Offset: 0x3aa8
// Size: 0x19c
function toggle_flir_postfxbundle( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = self;
    
    if ( newval == oldval )
    {
        return;
    }
    
    if ( !isdefined( player ) || !player islocalplayer() )
    {
        return;
    }
    
    if ( newval == 0 )
    {
        player thread postfx::stopplayingpostfxbundle();
        update_ui_fullscreen_filter_model( localclientnum, 0 );
        return;
    }
    
    if ( newval == 1 )
    {
        if ( player shouldchangescreenpostfx( localclientnum ) )
        {
            player thread postfx::playpostfxbundle( "pstfx_infrared" );
            update_ui_fullscreen_filter_model( localclientnum, 2 );
        }
        
        return;
    }
    
    if ( newval == 2 )
    {
        should_change = 1;
        
        if ( player shouldchangescreenpostfx( localclientnum ) )
        {
            player thread postfx::playpostfxbundle( "pstfx_flir" );
            update_ui_fullscreen_filter_model( localclientnum, 1 );
        }
    }
}

// Namespace vehicle
// Params 1
// Checksum 0x365c2241, Offset: 0x3c50
// Size: 0xa0, Type: bool
function shouldchangescreenpostfx( localclientnum )
{
    player = self;
    assert( isdefined( player ) );
    
    if ( player getinkillcam( localclientnum ) )
    {
        killcamentity = player getkillcamentity( localclientnum );
        
        if ( isdefined( killcamentity ) && killcamentity != player )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace vehicle
// Params 7
// Checksum 0xebfd0c44, Offset: 0x3cf8
// Size: 0xd4
function set_static_postfxbundle( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = self;
    
    if ( newval == oldval )
    {
        return;
    }
    
    if ( !isdefined( player ) || !player islocalplayer() )
    {
        return;
    }
    
    if ( newval == 0 )
    {
        player thread postfx::stopplayingpostfxbundle();
        return;
    }
    
    if ( newval == 1 )
    {
        player thread postfx::playpostfxbundle( "pstfx_static" );
    }
}

// Namespace vehicle
// Params 2
// Checksum 0x78c212d7, Offset: 0x3dd8
// Size: 0x84
function update_ui_fullscreen_filter_model( localclientnum, vision_set_value )
{
    controllermodel = getuimodelforcontroller( localclientnum );
    model = getuimodel( controllermodel, "vehicle.fullscreenFilter" );
    
    if ( isdefined( model ) )
    {
        setuimodelvalue( model, vision_set_value );
    }
}

// Namespace vehicle
// Params 7
// Checksum 0xe7fede0d, Offset: 0x3e68
// Size: 0x234
function field_toggle_treadfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.vehicleclass ) && ( isdefined( self.vehicleclass ) && self.vehicleclass == "helicopter" || self.vehicleclass == "plane" ) )
    {
        println( "<dev string:xc7>" );
        
        if ( newval )
        {
            if ( isdefined( bnewent ) && bnewent )
            {
                self.csf_no_tread = 1;
            }
            else
            {
                self kill_treads_forever();
            }
        }
        else
        {
            if ( isdefined( self.csf_no_tread ) )
            {
                self.csf_no_tread = 0;
            }
            
            self kill_treads_forever();
            self thread aircraft_dustkick();
        }
        
        return;
    }
    
    if ( newval )
    {
        println( "<dev string:xe7>" );
        
        if ( isdefined( bnewent ) && bnewent )
        {
            println( "<dev string:x10e>" + self getentitynumber() );
            self.csf_no_tread = 1;
        }
        else
        {
            println( "<dev string:x12c>" + self getentitynumber() );
            self kill_treads_forever();
        }
        
        return;
    }
    
    println( "<dev string:x148>" );
    
    if ( isdefined( self.csf_no_tread ) )
    {
        self.csf_no_tread = 0;
    }
    
    self kill_treads_forever();
}

// Namespace vehicle
// Params 7
// Checksum 0xd22e2e61, Offset: 0x40a8
// Size: 0xd6
function field_use_engine_damage_sounds( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( isdefined( self.vehicleclass ) && self.vehicleclass == "helicopter" )
    {
        switch ( newval )
        {
            case 0:
                self.engine_damage_low = 0;
                self.engine_damage_high = 0;
                break;
            case 1:
                self.engine_damage_low = 1;
                self.engine_damage_high = 0;
                break;
            case 1:
                self.engine_damage_low = 0;
                self.engine_damage_high = 1;
                break;
        }
    }
}

// Namespace vehicle
// Params 7
// Checksum 0x4df672a, Offset: 0x4188
// Size: 0xbc
function field_do_deathfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    
    if ( newval == 2 )
    {
        self field_do_empdeathfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump );
        return;
    }
    
    self field_do_standarddeathfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump );
}

// Namespace vehicle
// Params 7
// Checksum 0x4810c4fa, Offset: 0x4250
// Size: 0x17c
function field_do_standarddeathfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval && !binitialsnap )
    {
        wait_for_dobj( localclientnum );
        
        if ( isdefined( self.deathfxname ) )
        {
            if ( isdefined( self.deathfxtag ) && self.deathfxtag != "" )
            {
                handle = playfxontag( localclientnum, self.deathfxname, self, self.deathfxtag );
            }
            else
            {
                handle = playfx( localclientnum, self.deathfxname, self.origin );
            }
            
            setfxignorepause( localclientnum, handle, 1 );
        }
        
        self playsound( localclientnum, self.deathfxsound );
        
        if ( isdefined( self.deathquakescale ) && self.deathquakescale > 0 )
        {
            self earthquake( self.deathquakescale, self.deathquakeduration, self.origin, self.deathquakeradius );
        }
    }
}

// Namespace vehicle
// Params 7
// Checksum 0x9968e423, Offset: 0x43d8
// Size: 0x254
function field_do_empdeathfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( self.settings ) && isdefined( self.scriptbundlesettings ) )
    {
        self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    }
    
    if ( !isdefined( self.settings ) )
    {
        self field_do_standarddeathfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump );
        return;
    }
    
    if ( newval && !binitialsnap )
    {
        wait_for_dobj( localclientnum );
        s = self.settings;
        
        if ( isdefined( s.emp_death_fx_1 ) )
        {
            if ( isdefined( s.emp_death_tag_1 ) && s.emp_death_tag_1 != "" )
            {
                handle = playfxontag( localclientnum, s.emp_death_fx_1, self, s.emp_death_tag_1 );
            }
            else
            {
                handle = playfx( localclientnum, s.emp_death_tag_1, self.origin );
            }
            
            setfxignorepause( localclientnum, handle, 1 );
        }
        
        self playsound( localclientnum, s.emp_death_sound_1 );
        
        if ( isdefined( self.deathquakescale ) && self.deathquakescale > 0 )
        {
            self earthquake( self.deathquakescale * 0.25, self.deathquakeduration * 2, self.origin, self.deathquakeradius );
        }
    }
}

// Namespace vehicle
// Params 7
// Checksum 0xa07ad81b, Offset: 0x4638
// Size: 0x1d2
function field_update_alert_level( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    delete_alert_lights( localclientnum );
    
    if ( !isdefined( self.scriptbundlesettings ) )
    {
        return;
    }
    
    if ( !isdefined( self.alert_light_fx_handles ) )
    {
        self.alert_light_fx_handles = [];
    }
    
    settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    
    switch ( newval )
    {
        case 0:
            break;
        case 1:
            if ( isdefined( settings.unawarelightfx1 ) )
            {
                self.alert_light_fx_handles[ 0 ] = playfxontag( localclientnum, settings.unawarelightfx1, self, settings.lighttag1 );
            }
            
            break;
        case 2:
            if ( isdefined( settings.alertlightfx1 ) )
            {
                self.alert_light_fx_handles[ 0 ] = playfxontag( localclientnum, settings.alertlightfx1, self, settings.lighttag1 );
            }
            
            break;
        case 3:
            if ( isdefined( settings.combatlightfx1 ) )
            {
                self.alert_light_fx_handles[ 0 ] = playfxontag( localclientnum, settings.combatlightfx1, self, settings.lighttag1 );
            }
            
            break;
    }
}

// Namespace vehicle
// Params 7
// Checksum 0x57d4882, Offset: 0x4818
// Size: 0xd4
function field_toggle_exhaustfx_handler( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        if ( isdefined( bnewent ) && bnewent )
        {
            self.csf_no_exhaust = 1;
        }
        else
        {
            self stop_exhaust( localclientnum );
        }
        
        return;
    }
    
    if ( isdefined( self.csf_no_exhaust ) )
    {
        self.csf_no_exhaust = 0;
    }
    
    self stop_exhaust( localclientnum );
    self play_exhaust( localclientnum );
}

// Namespace vehicle
// Params 2
// Checksum 0xe23fd8c9, Offset: 0x48f8
// Size: 0x1b4
function control_lights_groups( localclientnum, on )
{
    if ( !isdefined( self.scriptbundlesettings ) )
    {
        return;
    }
    
    settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    
    if ( !isdefined( settings ) || !isdefined( settings.lightgroups_numgroups ) )
    {
        return;
    }
    
    if ( settings.lightgroups_numgroups >= 1 && settings.lightgroups_1_always_on !== 1 )
    {
        lights_group_toggle( localclientnum, 1, on );
    }
    
    if ( settings.lightgroups_numgroups >= 2 && settings.lightgroups_2_always_on !== 1 )
    {
        lights_group_toggle( localclientnum, 2, on );
    }
    
    if ( settings.lightgroups_numgroups >= 3 && settings.lightgroups_3_always_on !== 1 )
    {
        lights_group_toggle( localclientnum, 3, on );
    }
    
    if ( settings.lightgroups_numgroups >= 4 && settings.lightgroups_4_always_on !== 1 )
    {
        lights_group_toggle( localclientnum, 4, on );
    }
}

// Namespace vehicle
// Params 7
// Checksum 0xd5bbfc5c, Offset: 0x4ab8
// Size: 0x104
function field_toggle_lights_handler( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self lights_off( localclientnum );
    }
    else if ( newval == 2 )
    {
        self lights_on( localclientnum, "allies" );
    }
    else if ( newval == 3 )
    {
        self lights_on( localclientnum, "axis" );
    }
    else
    {
        self lights_on( localclientnum );
    }
    
    control_lights_groups( localclientnum, newval != 1 );
}

// Namespace vehicle
// Params 7
// Checksum 0xd9603104, Offset: 0x4bc8
// Size: 0x3c
function field_toggle_lockon_handler( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    
}

// Namespace vehicle
// Params 6
// Checksum 0x8be55db3, Offset: 0x4c10
// Size: 0x10a
function addfxandtagtolists( fx, tag, &fxlist, &taglist, id, maxid )
{
    if ( isdefined( fx ) && isdefined( tag ) && id <= maxid )
    {
        if ( !isdefined( fxlist ) )
        {
            fxlist = [];
        }
        else if ( !isarray( fxlist ) )
        {
            fxlist = array( fxlist );
        }
        
        fxlist[ fxlist.size ] = fx;
        
        if ( !isdefined( taglist ) )
        {
            taglist = [];
        }
        else if ( !isarray( taglist ) )
        {
            taglist = array( taglist );
        }
        
        taglist[ taglist.size ] = tag;
    }
}

// Namespace vehicle
// Params 7
// Checksum 0x7e10159a, Offset: 0x4d28
// Size: 0x91c
function field_update_damage_state( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( self.scriptbundlesettings ) )
    {
        return;
    }
    
    settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    
    if ( isdefined( self.damage_state_fx_handles ) )
    {
        foreach ( fx_handle in self.damage_state_fx_handles )
        {
            stopfx( localclientnum, fx_handle );
        }
    }
    
    self.damage_state_fx_handles = [];
    fxlist = [];
    taglist = [];
    sound = undefined;
    
    switch ( newval )
    {
        case 0:
            break;
        case 1:
            addfxandtagtolists( settings.damagestate_lv1_fx1, settings.damagestate_lv1_tag1, fxlist, taglist, 1, settings.damagestate_lv1_numslots );
            addfxandtagtolists( settings.damagestate_lv1_fx2, settings.damagestate_lv1_tag2, fxlist, taglist, 2, settings.damagestate_lv1_numslots );
            addfxandtagtolists( settings.damagestate_lv1_fx3, settings.damagestate_lv1_tag3, fxlist, taglist, 3, settings.damagestate_lv1_numslots );
            addfxandtagtolists( settings.damagestate_lv1_fx4, settings.damagestate_lv1_tag4, fxlist, taglist, 4, settings.damagestate_lv1_numslots );
            sound = settings.damagestate_lv1_sound;
            break;
        case 2:
            addfxandtagtolists( settings.damagestate_lv2_fx1, settings.damagestate_lv2_tag1, fxlist, taglist, 1, settings.damagestate_lv2_numslots );
            addfxandtagtolists( settings.damagestate_lv2_fx2, settings.damagestate_lv2_tag2, fxlist, taglist, 2, settings.damagestate_lv2_numslots );
            addfxandtagtolists( settings.damagestate_lv2_fx3, settings.damagestate_lv2_tag3, fxlist, taglist, 3, settings.damagestate_lv2_numslots );
            addfxandtagtolists( settings.damagestate_lv2_fx4, settings.damagestate_lv2_tag4, fxlist, taglist, 4, settings.damagestate_lv2_numslots );
            sound = settings.damagestate_lv2_sound;
            break;
        case 3:
            addfxandtagtolists( settings.damagestate_lv3_fx1, settings.damagestate_lv3_tag1, fxlist, taglist, 1, settings.damagestate_lv3_numslots );
            addfxandtagtolists( settings.damagestate_lv3_fx2, settings.damagestate_lv3_tag2, fxlist, taglist, 2, settings.damagestate_lv3_numslots );
            addfxandtagtolists( settings.damagestate_lv3_fx3, settings.damagestate_lv3_tag3, fxlist, taglist, 3, settings.damagestate_lv3_numslots );
            addfxandtagtolists( settings.damagestate_lv3_fx4, settings.damagestate_lv3_tag4, fxlist, taglist, 4, settings.damagestate_lv3_numslots );
            sound = settings.damagestate_lv3_sound;
            break;
        case 4:
            addfxandtagtolists( settings.damagestate_lv4_fx1, settings.damagestate_lv4_tag1, fxlist, taglist, 1, settings.damagestate_lv4_numslots );
            addfxandtagtolists( settings.damagestate_lv4_fx2, settings.damagestate_lv4_tag2, fxlist, taglist, 2, settings.damagestate_lv4_numslots );
            addfxandtagtolists( settings.damagestate_lv4_fx3, settings.damagestate_lv4_tag3, fxlist, taglist, 3, settings.damagestate_lv4_numslots );
            addfxandtagtolists( settings.damagestate_lv4_fx4, settings.damagestate_lv4_tag4, fxlist, taglist, 4, settings.damagestate_lv4_numslots );
            sound = settings.damagestate_lv4_sound;
            break;
        case 5:
            addfxandtagtolists( settings.damagestate_lv5_fx1, settings.damagestate_lv5_tag1, fxlist, taglist, 1, settings.damagestate_lv5_numslots );
            addfxandtagtolists( settings.damagestate_lv5_fx2, settings.damagestate_lv5_tag2, fxlist, taglist, 2, settings.damagestate_lv5_numslots );
            addfxandtagtolists( settings.damagestate_lv5_fx3, settings.damagestate_lv5_tag3, fxlist, taglist, 3, settings.damagestate_lv5_numslots );
            addfxandtagtolists( settings.damagestate_lv5_fx4, settings.damagestate_lv5_tag4, fxlist, taglist, 4, settings.damagestate_lv5_numslots );
            sound = settings.damagestate_lv5_sound;
            break;
        case 6:
            addfxandtagtolists( settings.damagestate_lv6_fx1, settings.damagestate_lv6_tag1, fxlist, taglist, 1, settings.damagestate_lv6_numslots );
            addfxandtagtolists( settings.damagestate_lv6_fx2, settings.damagestate_lv6_tag2, fxlist, taglist, 2, settings.damagestate_lv6_numslots );
            addfxandtagtolists( settings.damagestate_lv6_fx3, settings.damagestate_lv6_tag3, fxlist, taglist, 3, settings.damagestate_lv6_numslots );
            addfxandtagtolists( settings.damagestate_lv6_fx4, settings.damagestate_lv6_tag4, fxlist, taglist, 4, settings.damagestate_lv6_numslots );
            sound = settings.damagestate_lv6_sound;
            break;
    }
    
    for ( i = 0; i < fxlist.size ; i++ )
    {
        fx_handle = playfxontag( localclientnum, fxlist[ i ], self, taglist[ i ] );
        
        if ( !isdefined( self.damage_state_fx_handles ) )
        {
            self.damage_state_fx_handles = [];
        }
        else if ( !isarray( self.damage_state_fx_handles ) )
        {
            self.damage_state_fx_handles = array( self.damage_state_fx_handles );
        }
        
        self.damage_state_fx_handles[ self.damage_state_fx_handles.size ] = fx_handle;
    }
    
    if ( isdefined( self ) && isdefined( sound ) )
    {
        self playsound( localclientnum, sound );
    }
}

// Namespace vehicle
// Params 7
// Checksum 0xe86b8c28, Offset: 0x5650
// Size: 0x76e
function field_death_spawn_dynents( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( self.scriptbundlesettings ) )
    {
        return;
    }
    
    settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    
    if ( localclientnum == 0 )
    {
        velocity = self getvelocity();
        numdynents = isdefined( settings.death_dynent_count ) ? settings.death_dynent_count : 0;
        
        for ( i = 0; i < numdynents ; i++ )
        {
            model = getstructfield( settings, "death_dynmodel" + i );
            
            if ( !isdefined( model ) )
            {
                continue;
            }
            
            gibpart = getstructfield( settings, "death_dynent_gib" + i );
            
            if ( self.gibbed === 1 && gibpart === 1 )
            {
                continue;
            }
            
            pitch = isdefined( getstructfield( settings, "death_dynent_force_pitch" + i ) ) ? getstructfield( settings, "death_dynent_force_pitch" + i ) : 0;
            yaw = isdefined( getstructfield( settings, "death_dynent_force_yaw" + i ) ) ? getstructfield( settings, "death_dynent_force_yaw" + i ) : 0;
            angles = ( randomfloatrange( pitch - 15, pitch + 15 ), randomfloatrange( yaw - 20, yaw + 20 ), randomfloatrange( -20, 20 ) );
            direction = anglestoforward( self.angles + angles );
            minscale = isdefined( getstructfield( settings, "death_dynent_force_minscale" + i ) ) ? getstructfield( settings, "death_dynent_force_minscale" + i ) : 0;
            maxscale = isdefined( getstructfield( settings, "death_dynent_force_maxscale" + i ) ) ? getstructfield( settings, "death_dynent_force_maxscale" + i ) : 0;
            force = direction * randomfloatrange( minscale, maxscale );
            offset = ( isdefined( getstructfield( settings, "death_dynent_offsetX" + i ) ) ? getstructfield( settings, "death_dynent_offsetX" + i ) : 0, isdefined( getstructfield( settings, "death_dynent_offsetY" + i ) ) ? getstructfield( settings, "death_dynent_offsetY" + i ) : 0, isdefined( getstructfield( settings, "death_dynent_offsetZ" + i ) ) ? getstructfield( settings, "death_dynent_offsetZ" + i ) : 0 );
            
            switch ( newval )
            {
                case 0:
                    break;
                case 1:
                    fx = getstructfield( settings, "death_dynent_fx" + i );
                    break;
                case 2:
                    fx = getstructfield( settings, "death_dynent_elec_fx" + i );
                    break;
                case 3:
                    fx = getstructfield( settings, "death_dynent_fire_fx" + i );
                    break;
            }
            
            offset = rotatepoint( offset, self.angles );
            
            if ( newval > 1 && isdefined( fx ) )
            {
                dynent = createdynentandlaunch( localclientnum, model, self.origin + offset, self.angles, ( 0, 0, 0 ), velocity * 0.8, fx );
            }
            else if ( newval == 1 && isdefined( fx ) )
            {
                dynent = createdynentandlaunch( localclientnum, model, self.origin + offset, self.angles, ( 0, 0, 0 ), velocity * 0.8, fx );
            }
            else
            {
                dynent = createdynentandlaunch( localclientnum, model, self.origin + offset, self.angles, ( 0, 0, 0 ), velocity * 0.8 );
            }
            
            if ( isdefined( dynent ) )
            {
                hitoffset = ( randomfloatrange( -5, 5 ), randomfloatrange( -5, 5 ), randomfloatrange( -5, 5 ) );
                launchdynent( dynent, force, hitoffset );
            }
        }
    }
}

// Namespace vehicle
// Params 7
// Checksum 0x2f817e99, Offset: 0x5dc8
// Size: 0x676
function field_gib_spawn_dynents( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( self.scriptbundlesettings ) )
    {
        return;
    }
    
    settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    
    if ( localclientnum == 0 )
    {
        velocity = self getvelocity();
        numdynents = 2;
        
        for ( i = 0; i < numdynents ; i++ )
        {
            model = getstructfield( settings, "servo_gib_model" + i );
            
            if ( !isdefined( model ) )
            {
                return;
            }
            
            self.gibbed = 1;
            origin = self.origin;
            angles = self.angles;
            hidetag = getstructfield( settings, "servo_gib_tag" + i );
            
            if ( isdefined( hidetag ) )
            {
                origin = self gettagorigin( hidetag );
                angles = self gettagangles( hidetag );
            }
            
            pitch = isdefined( getstructfield( settings, "servo_gib_force_pitch" + i ) ) ? getstructfield( settings, "servo_gib_force_pitch" + i ) : 0;
            yaw = isdefined( getstructfield( settings, "servo_gib_force_yaw" + i ) ) ? getstructfield( settings, "servo_gib_force_yaw" + i ) : 0;
            relative_angles = ( randomfloatrange( pitch - 5, pitch + 5 ), randomfloatrange( yaw - 5, yaw + 5 ), randomfloatrange( -5, 5 ) );
            direction = anglestoforward( angles + relative_angles );
            minscale = isdefined( getstructfield( settings, "servo_gib_force_minscale" + i ) ) ? getstructfield( settings, "servo_gib_force_minscale" + i ) : 0;
            maxscale = isdefined( getstructfield( settings, "servo_gib_force_maxscale" + i ) ) ? getstructfield( settings, "servo_gib_force_maxscale" + i ) : 0;
            force = direction * randomfloatrange( minscale, maxscale );
            offset = ( isdefined( getstructfield( settings, "servo_gib_offsetX" + i ) ) ? getstructfield( settings, "servo_gib_offsetX" + i ) : 0, isdefined( getstructfield( settings, "servo_gib_offsetY" + i ) ) ? getstructfield( settings, "servo_gib_offsetY" + i ) : 0, isdefined( getstructfield( settings, "servo_gib_offsetZ" + i ) ) ? getstructfield( settings, "servo_gib_offsetZ" + i ) : 0 );
            fx = getstructfield( settings, "servo_gib_fx" + i );
            offset = rotatepoint( offset, angles );
            
            if ( isdefined( fx ) )
            {
                dynent = createdynentandlaunch( localclientnum, model, origin + offset, angles, ( 0, 0, 0 ), velocity * 0.8, fx );
            }
            else
            {
                dynent = createdynentandlaunch( localclientnum, model, origin + offset, angles, ( 0, 0, 0 ), velocity * 0.8 );
            }
            
            if ( isdefined( dynent ) )
            {
                hitoffset = ( randomfloatrange( -5, 5 ), randomfloatrange( -5, 5 ), randomfloatrange( -5, 5 ) );
                launchdynent( dynent, force, hitoffset );
            }
        }
    }
}

// Namespace vehicle
// Params 0, eflags: 0x2
// Checksum 0xd4fe13f6, Offset: 0x6448
// Size: 0x8e
function autoexec build_damage_filter_list()
{
    if ( !isdefined( level.vehicle_damage_filters ) )
    {
        level.vehicle_damage_filters = [];
    }
    
    level.vehicle_damage_filters[ 0 ] = "generic_filter_vehicle_damage";
    level.vehicle_damage_filters[ 1 ] = "generic_filter_sam_damage";
    level.vehicle_damage_filters[ 2 ] = "generic_filter_f35_damage";
    level.vehicle_damage_filters[ 3 ] = "generic_filter_vehicle_damage_sonar";
    level.vehicle_damage_filters[ 4 ] = "generic_filter_rts_vehicle_damage";
}

// Namespace vehicle
// Params 1
// Checksum 0xd378f105, Offset: 0x64e0
// Size: 0xdc
function init_damage_filter( materialid )
{
    level.localplayers[ 0 ].damage_filter_intensity = 0;
    materialname = level.vehicle_damage_filters[ materialid ];
    filter::init_filter_vehicle_damage( level.localplayers[ 0 ], materialname );
    filter::enable_filter_vehicle_damage( level.localplayers[ 0 ], 3, materialname );
    filter::set_filter_vehicle_damage_amount( level.localplayers[ 0 ], 3, 0 );
    filter::set_filter_vehicle_sun_position( level.localplayers[ 0 ], 3, 0, 0 );
}

// Namespace vehicle
// Params 2
// Checksum 0x9c32c6e, Offset: 0x65c8
// Size: 0x94
function damage_filter_enable( localclientnum, materialid )
{
    filter::enable_filter_vehicle_damage( level.localplayers[ 0 ], 3, level.vehicle_damage_filters[ materialid ] );
    level.localplayers[ 0 ].damage_filter_intensity = 0;
    filter::set_filter_vehicle_damage_amount( level.localplayers[ 0 ], 3, level.localplayers[ 0 ].damage_filter_intensity );
}

// Namespace vehicle
// Params 1
// Checksum 0x18b76c93, Offset: 0x6668
// Size: 0x8c
function damage_filter_disable( localclientnum )
{
    level notify( #"damage_filter_off" );
    level.localplayers[ 0 ].damage_filter_intensity = 0;
    filter::set_filter_vehicle_damage_amount( level.localplayers[ 0 ], 3, level.localplayers[ 0 ].damage_filter_intensity );
    filter::disable_filter_vehicle_damage( level.localplayers[ 0 ], 3 );
}

// Namespace vehicle
// Params 1
// Checksum 0x9ac8ad0d, Offset: 0x6700
// Size: 0x118
function damage_filter_off( localclientnum )
{
    level endon( #"damage_filter" );
    level endon( #"damage_filter_off" );
    level endon( #"damage_filter_heavy" );
    
    if ( !isdefined( level.localplayers[ 0 ].damage_filter_intensity ) )
    {
        return;
    }
    
    while ( level.localplayers[ 0 ].damage_filter_intensity > 0 )
    {
        level.localplayers[ 0 ].damage_filter_intensity -= 0.0505061;
        
        if ( level.localplayers[ 0 ].damage_filter_intensity < 0 )
        {
            level.localplayers[ 0 ].damage_filter_intensity = 0;
        }
        
        filter::set_filter_vehicle_damage_amount( level.localplayers[ 0 ], 3, level.localplayers[ 0 ].damage_filter_intensity );
        wait 0.016667;
    }
}

// Namespace vehicle
// Params 1
// Checksum 0x98d81339, Offset: 0x6820
// Size: 0x108
function damage_filter_light( localclientnum )
{
    level endon( #"damage_filter_off" );
    level endon( #"damage_filter_heavy" );
    level notify( #"damage_filter" );
    
    while ( level.localplayers[ 0 ].damage_filter_intensity < 0.5 )
    {
        level.localplayers[ 0 ].damage_filter_intensity += 0.083335;
        
        if ( level.localplayers[ 0 ].damage_filter_intensity > 0.5 )
        {
            level.localplayers[ 0 ].damage_filter_intensity = 0.5;
        }
        
        filter::set_filter_vehicle_damage_amount( level.localplayers[ 0 ], 3, level.localplayers[ 0 ].damage_filter_intensity );
        wait 0.016667;
    }
}

// Namespace vehicle
// Params 1
// Checksum 0x418fcaa5, Offset: 0x6930
// Size: 0xf8
function damage_filter_heavy( localclientnum )
{
    level endon( #"damage_filter_off" );
    level notify( #"damage_filter_heavy" );
    
    while ( level.localplayers[ 0 ].damage_filter_intensity < 1 )
    {
        level.localplayers[ 0 ].damage_filter_intensity += 0.083335;
        
        if ( level.localplayers[ 0 ].damage_filter_intensity > 1 )
        {
            level.localplayers[ 0 ].damage_filter_intensity = 1;
        }
        
        filter::set_filter_vehicle_damage_amount( level.localplayers[ 0 ], 3, level.localplayers[ 0 ].damage_filter_intensity );
        wait 0.016667;
    }
}

