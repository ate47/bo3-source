#using scripts/shared/audio_shared;

#namespace driving_fx;

// Namespace driving_fx
// Method(s) 4 Total 4
class vehiclewheelfx
{

    // Namespace vehiclewheelfx
    // Params 0
    // Checksum 0xf9540fa9, Offset: 0x500
    // Size: 0x24
    constructor()
    {
        self.name = "";
        self.tag_name = "";
    }

    // Namespace vehiclewheelfx
    // Params 3
    // Checksum 0x643322ef, Offset: 0x610
    // Size: 0x4cc
    function update( localclientnum, vehicle, speed_fraction )
    {
        if ( vehicle.vehicleclass === "boat" )
        {
            peelingout = 0;
            sliding = 0;
            trace = bullettrace( vehicle.origin + ( 0, 0, 60 ), vehicle.origin - ( 0, 0, 200 ), 0, vehicle );
            
            if ( trace[ "fraction" ] < 1 )
            {
                surface = trace[ "surfacetype" ];
            }
            else
            {
                [[ self.ground_fx[ "skid" ] ]]->stop( localclientnum );
                [[ self.ground_fx[ "tread" ] ]]->stop( localclientnum );
                return;
            }
        }
        else
        {
            if ( !vehicle iswheelcolliding( self.name ) )
            {
                [[ self.ground_fx[ "skid" ] ]]->stop( localclientnum );
                [[ self.ground_fx[ "tread" ] ]]->stop( localclientnum );
                return;
            }
            
            peelingout = vehicle iswheelpeelingout( self.name );
            sliding = vehicle iswheelsliding( self.name );
            surface = vehicle getwheelsurface( self.name );
        }
        
        origin = vehicle gettagorigin( self.tag_name ) + ( 0, 0, 1 );
        angles = vehicle gettagangles( self.tag_name );
        fwd = anglestoforward( angles );
        right = anglestoright( angles );
        rumble = 0;
        
        if ( peelingout )
        {
            peel_fx = vehicle driving_fx::get_wheel_fx( "peel", surface );
            
            if ( isdefined( peel_fx ) )
            {
                playfx( localclientnum, peel_fx, origin, fwd * -1 );
                rumble = 1;
            }
        }
        
        if ( sliding )
        {
            skid_fx = vehicle driving_fx::get_wheel_fx( "skid", surface );
            [[ self.ground_fx[ "skid" ] ]]->play( localclientnum, vehicle, skid_fx, self.tag_name );
            vehicle.skidding = 1;
            rumble = 1;
        }
        else
        {
            [[ self.ground_fx[ "skid" ] ]]->stop( localclientnum );
        }
        
        if ( speed_fraction > 0.1 )
        {
            tread_fx = vehicle driving_fx::get_wheel_fx( "tread", surface );
            [[ self.ground_fx[ "tread" ] ]]->play( localclientnum, vehicle, tread_fx, self.tag_name );
        }
        else
        {
            [[ self.ground_fx[ "tread" ] ]]->stop( localclientnum );
        }
        
        if ( rumble )
        {
            if ( vehicle islocalclientdriver( localclientnum ) )
            {
                player = getlocalplayer( localclientnum );
                player playrumbleonentity( localclientnum, "reload_small" );
            }
        }
    }

    // Namespace vehiclewheelfx
    // Params 2
    // Checksum 0x90cd92f7, Offset: 0x540
    // Size: 0xc4
    function init( _name, _tag_name )
    {
        self.name = _name;
        self.tag_name = _tag_name;
        self.ground_fx = [];
        self.ground_fx[ "skid" ] = new groundfx();
        self.ground_fx[ "tread" ] = new groundfx();
        self.ground_fx[ "tread" ].id = "";
        self.ground_fx[ "tread" ].handle = -1;
    }

}

// Namespace driving_fx
// Method(s) 4 Total 4
class groundfx
{

    // Namespace groundfx
    // Params 0
    // Checksum 0xa01b94ae, Offset: 0x230
    // Size: 0x1c
    constructor()
    {
        self.id = undefined;
        self.handle = -1;
    }

    // Namespace groundfx
    // Params 1
    // Checksum 0xc63ca503, Offset: 0x3b8
    // Size: 0x4c
    function stop( localclientnum )
    {
        if ( self.handle > 0 )
        {
            stopfx( localclientnum, self.handle );
        }
        
        self.id = undefined;
        self.handle = -1;
    }

    // Namespace groundfx
    // Params 4
    // Checksum 0x905dfbef, Offset: 0x268
    // Size: 0x144
    function play( localclientnum, vehicle, fx_id, fx_tag )
    {
        if ( !isdefined( fx_id ) )
        {
            if ( self.handle > 0 )
            {
                stopfx( localclientnum, self.handle );
            }
            
            self.id = undefined;
            self.handle = -1;
            return;
        }
        
        if ( !isdefined( self.id ) )
        {
            self.id = fx_id;
            self.handle = playfxontag( localclientnum, self.id, vehicle, fx_tag );
            return;
        }
        
        if ( !isdefined( self.id ) || self.id != fx_id )
        {
            if ( self.handle > 0 )
            {
                stopfx( localclientnum, self.handle );
            }
            
            self.id = fx_id;
            self.handle = playfxontag( localclientnum, self.id, vehicle, fx_tag );
        }
    }

}

// Namespace driving_fx
// Method(s) 4 Total 4
class vehicle_camera_fx
{

    // Namespace vehicle_camera_fx
    // Params 0
    // Checksum 0xfc47a4e4, Offset: 0xbd8
    // Size: 0x54
    constructor()
    {
        self.quake_time_min = 0.5;
        self.quake_time_max = 1;
        self.quake_strength_min = 0.1;
        self.quake_strength_max = 0.115;
        self.rumble_name = "";
    }

    // Namespace vehicle_camera_fx
    // Params 3
    // Checksum 0x4da12ec7, Offset: 0xcf0
    // Size: 0x14c
    function update( localclientnum, vehicle, speed_fraction )
    {
        if ( vehicle islocalclientdriver( localclientnum ) )
        {
            player = getlocalplayer( localclientnum );
            
            if ( speed_fraction > 0 )
            {
                strength = randomfloatrange( self.quake_strength_min, self.quake_strength_max ) * speed_fraction;
                time = randomfloatrange( self.quake_time_min, self.quake_time_max );
                player earthquake( strength, time, player.origin, 500 );
                
                if ( self.rumble_name != "" && speed_fraction > 0.5 )
                {
                    if ( randomint( 100 ) < 10 )
                    {
                        player playrumbleonentity( localclientnum, self.rumble_name );
                    }
                }
            }
        }
    }

    // Namespace vehicle_camera_fx
    // Params 5
    // Checksum 0xc5554cec, Offset: 0xc48
    // Size: 0x9c
    function init( t_min, t_max, s_min, s_max, rumble )
    {
        if ( !isdefined( rumble ) )
        {
            rumble = "";
        }
        
        self.quake_time_min = t_min;
        self.quake_time_max = t_max;
        self.quake_strength_min = s_min;
        self.quake_strength_max = s_max;
        self.rumble_name = rumble != "" ? rumble : self.rumble_name;
    }

}

// Namespace driving_fx
// Params 1
// Checksum 0xc478fbf5, Offset: 0xf38
// Size: 0x90
function vehicle_enter( localclientnum )
{
    self endon( #"entityshutdown" );
    
    while ( true )
    {
        self waittill( #"enter_vehicle", user );
        
        if ( isdefined( user ) && user isplayer() )
        {
            self thread collision_thread( localclientnum );
            self thread jump_landing_thread( localclientnum );
        }
    }
}

// Namespace driving_fx
// Params 1
// Checksum 0xf1b6c61a, Offset: 0xfd0
// Size: 0x100
function speed_fx( localclientnum )
{
    self endon( #"entityshutdown" );
    self endon( #"exit_vehicle" );
    
    while ( true )
    {
        curspeed = self getspeed();
        curspeed = 0.0005 * curspeed;
        curspeed = abs( curspeed );
        
        if ( curspeed > 0.001 )
        {
            setsaveddvar( "r_speedBlurFX_enable", "1" );
            setsaveddvar( "r_speedBlurAmount", curspeed );
        }
        else
        {
            setsaveddvar( "r_speedBlurFX_enable", "0" );
        }
        
        wait 0.05;
    }
}

// Namespace driving_fx
// Params 1
// Checksum 0x5089f7a7, Offset: 0x10d8
// Size: 0x420
function play_driving_fx( localclientnum )
{
    self endon( #"entityshutdown" );
    self thread vehicle_enter( localclientnum );
    
    if ( self.surfacefxdeftype == "" )
    {
        return;
    }
    
    if ( !isdefined( self.wheel_fx ) )
    {
        wheel_names = array( "front_left", "front_right", "back_left", "back_right" );
        wheel_tag_names = array( "tag_wheel_front_left", "tag_wheel_front_right", "tag_wheel_back_left", "tag_wheel_back_right" );
        
        if ( isdefined( self.scriptvehicletype ) && self.scriptvehicletype == "raps" )
        {
            wheel_names = array( "front_left" );
            wheel_tag_names = array( "tag_origin" );
        }
        else if ( self.vehicleclass == "boat" )
        {
            wheel_names = array( "tag_origin" );
            wheel_tag_names = array( "tag_origin" );
        }
        
        self.wheel_fx = [];
        
        for ( i = 0; i < wheel_names.size ; i++ )
        {
            self.wheel_fx[ i ] = new vehiclewheelfx();
            [[ self.wheel_fx[ i ] ]]->init( wheel_names[ i ], wheel_tag_names[ i ] );
        }
        
        self.camera_fx = [];
        self.camera_fx[ "speed" ] = new vehicle_camera_fx();
        [[ self.camera_fx[ "speed" ] ]]->init( 0.5, 1, 0.1, 0.115, "reload_small" );
        self.camera_fx[ "skid" ] = new vehicle_camera_fx();
        [[ self.camera_fx[ "skid" ] ]]->init( 0.25, 0.35, 0.1, 0.115 );
    }
    
    self.last_screen_dirt = 0;
    self.screen_dirt_delay = 0;
    speed_fraction = 0;
    
    while ( true )
    {
        speed = length( self getvelocity() );
        max_speed = speed < 0 ? self getmaxreversespeed() : self getmaxspeed();
        speed_fraction = max_speed > 0 ? abs( speed ) / max_speed : 0;
        self.skidding = 0;
        
        for ( i = 0; i < self.wheel_fx.size ; i++ )
        {
            [[ self.wheel_fx[ i ] ]]->update( localclientnum, self, speed_fraction );
        }
        
        wait 0.1;
    }
}

// Namespace driving_fx
// Params 2
// Checksum 0x2887d680, Offset: 0x1500
// Size: 0x98
function get_wheel_fx( type, surface )
{
    fxarray = undefined;
    
    if ( type == "tread" )
    {
        fxarray = self.treadfxnamearray;
    }
    else if ( type == "peel" )
    {
        fxarray = self.peelfxnamearray;
    }
    else if ( type == "skid" )
    {
        fxarray = self.skidfxnamearray;
    }
    
    if ( isdefined( fxarray ) )
    {
        return fxarray[ surface ];
    }
    
    return undefined;
}

// Namespace driving_fx
// Params 3
// Checksum 0x9ed9b95b, Offset: 0x15a0
// Size: 0x1bc
function play_driving_fx_firstperson( localclientnum, speed, speed_fraction )
{
    if ( speed > 0 && speed_fraction >= 0.25 )
    {
        viewangles = getlocalclientangles( localclientnum );
        pitch = angleclamp180( viewangles[ 0 ] );
        
        if ( pitch > -10 )
        {
            current_additional_time = 0;
            
            if ( pitch < 10 )
            {
                current_additional_time = 1000 * ( pitch - 10 ) / ( -10 - 10 );
            }
            
            if ( self.last_screen_dirt + self.screen_dirt_delay + current_additional_time < getrealtime() )
            {
                screen_fx_type = self correct_surface_type_for_screen_fx();
                
                if ( screen_fx_type == "dirt" )
                {
                    play_screen_fx_dirt( localclientnum );
                }
                else
                {
                    play_screen_fx_dust( localclientnum );
                }
                
                self.last_screen_dirt = getrealtime();
                self.screen_dirt_delay = randomintrange( 250, 500 );
            }
        }
    }
}

// Namespace driving_fx
// Params 1
// Checksum 0x589a0041, Offset: 0x1768
// Size: 0x268
function collision_thread( localclientnum )
{
    self endon( #"entityshutdown" );
    self endon( #"exit_vehicle" );
    
    while ( true )
    {
        self waittill( #"veh_collision", hip, hitn, hit_intensity );
        
        if ( self islocalclientdriver( localclientnum ) )
        {
            player = getlocalplayer( localclientnum );
            
            if ( isdefined( self.driving_fx_collision_override ) )
            {
                self [[ self.driving_fx_collision_override ]]( localclientnum, player, hip, hitn, hit_intensity );
                continue;
            }
            
            if ( isdefined( player ) && isdefined( hit_intensity ) )
            {
                if ( hit_intensity > self.heavycollisionspeed )
                {
                    volume = get_impact_vol_from_speed();
                    
                    if ( isdefined( self.sounddef ) )
                    {
                        alias = self.sounddef + "_suspension_lg_hd";
                    }
                    else
                    {
                        alias = "veh_default_suspension_lg_hd";
                    }
                    
                    id = playsound( 0, alias, self.origin, volume );
                    
                    if ( isdefined( self.heavycollisionrumble ) )
                    {
                        player playrumbleonentity( localclientnum, self.heavycollisionrumble );
                    }
                    
                    continue;
                }
                
                if ( hit_intensity > self.lightcollisionspeed )
                {
                    volume = get_impact_vol_from_speed();
                    
                    if ( isdefined( self.sounddef ) )
                    {
                        alias = self.sounddef + "_suspension_lg_lt";
                    }
                    else
                    {
                        alias = "veh_default_suspension_lg_lt";
                    }
                    
                    id = playsound( 0, alias, self.origin, volume );
                    
                    if ( isdefined( self.lightcollisionrumble ) )
                    {
                        player playrumbleonentity( localclientnum, self.lightcollisionrumble );
                    }
                }
            }
        }
    }
}

// Namespace driving_fx
// Params 1
// Checksum 0xebd6ae0a, Offset: 0x19d8
// Size: 0x168
function jump_landing_thread( localclientnum )
{
    self endon( #"entityshutdown" );
    self endon( #"exit_vehicle" );
    
    while ( true )
    {
        self waittill( #"veh_landed" );
        
        if ( self islocalclientdriver( localclientnum ) )
        {
            player = getlocalplayer( localclientnum );
            
            if ( isdefined( player ) )
            {
                if ( isdefined( self.driving_fx_jump_landing_override ) )
                {
                    self [[ self.driving_fx_jump_landing_override ]]( localclientnum, player );
                    continue;
                }
                
                volume = get_impact_vol_from_speed();
                
                if ( isdefined( self.sounddef ) )
                {
                    alias = self.sounddef + "_suspension_lg_hd";
                }
                else
                {
                    alias = "veh_default_suspension_lg_hd";
                }
                
                id = playsound( 0, alias, self.origin, volume );
                
                if ( isdefined( self.jumplandingrumble ) )
                {
                    player playrumbleonentity( localclientnum, self.jumplandingrumble );
                }
            }
        }
    }
}

// Namespace driving_fx
// Params 1
// Checksum 0xa0cedf44, Offset: 0x1b48
// Size: 0x138
function suspension_thread( localclientnum )
{
    self endon( #"entityshutdown" );
    self endon( #"exit_vehicle" );
    
    while ( true )
    {
        self waittill( #"veh_suspension_limit_activated" );
        
        if ( self islocalclientdriver( localclientnum ) )
        {
            player = getlocalplayer( localclientnum );
            
            if ( isdefined( player ) )
            {
                volume = get_impact_vol_from_speed();
                
                if ( isdefined( self.sounddef ) )
                {
                    alias = self.sounddef + "_suspension_lg_lt";
                }
                else
                {
                    alias = "veh_default_suspension_lg_lt";
                }
                
                id = playsound( 0, alias, self.origin, volume );
                player playrumbleonentity( localclientnum, "damage_light" );
            }
        }
    }
}

// Namespace driving_fx
// Params 0
// Checksum 0xf01dbe94, Offset: 0x1c88
// Size: 0x92
function get_impact_vol_from_speed()
{
    curspeed = self getspeed();
    maxspeed = self getmaxspeed();
    volume = audio::scale_speed( 0, maxspeed, 0, 1, curspeed );
    volume = volume * volume * volume;
    return volume;
}

// Namespace driving_fx
// Params 0
// Checksum 0x7586dcc2, Offset: 0x1d28
// Size: 0x82, Type: bool
function any_wheel_colliding()
{
    return self iswheelcolliding( "front_left" ) || self iswheelcolliding( "front_right" ) || self iswheelcolliding( "back_left" ) || self iswheelcolliding( "back_right" );
}

// Namespace driving_fx
// Params 1
// Checksum 0x3828985e, Offset: 0x1db8
// Size: 0x1a, Type: bool
function dirt_surface_type( surface_type )
{
    switch ( surface_type )
    {
        case "dirt":
        case "foliage":
        case "grass":
        case "gravel":
        case "mud":
        case "sand":
        case "snow":
        default:
            return true;
    }
}

// Namespace driving_fx
// Params 0
// Checksum 0x83e32467, Offset: 0x1e28
// Size: 0x9e
function correct_surface_type_for_screen_fx()
{
    right_rear = self getwheelsurface( "back_right" );
    left_rear = self getwheelsurface( "back_left" );
    
    if ( dirt_surface_type( right_rear ) )
    {
        return "dirt";
    }
    
    if ( dirt_surface_type( left_rear ) )
    {
        return "dirt";
    }
    
    return "dust";
}

// Namespace driving_fx
// Params 1
// Checksum 0xc2e449d9, Offset: 0x1ed0
// Size: 0xc
function play_screen_fx_dirt( localclientnum )
{
    
}

// Namespace driving_fx
// Params 1
// Checksum 0x6d06d3aa, Offset: 0x1ee8
// Size: 0xc
function play_screen_fx_dust( localclientnum )
{
    
}

