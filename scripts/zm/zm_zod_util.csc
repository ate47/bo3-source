#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_zod_util;

// Namespace zm_zod_util
// Params 7
// Checksum 0x7873f0d8, Offset: 0x180
// Size: 0x276
function player_rumble_and_shake( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"disconnect" );
    
    if ( newval == 5 )
    {
        self thread player_continuous_rumble( localclientnum, 1 );
        return;
    }
    
    if ( newval == 6 )
    {
        self notify( #"stop_rumble_and_shake" );
        self earthquake( 0.6, 1.5, self.origin, 100 );
        self playrumbleonentity( localclientnum, "artillery_rumble" );
        return;
    }
    
    if ( newval == 4 )
    {
        self earthquake( 0.6, 1.5, self.origin, 100 );
        self playrumbleonentity( localclientnum, "artillery_rumble" );
        return;
    }
    
    if ( newval == 3 )
    {
        self earthquake( 0.3, 1.5, self.origin, 100 );
        self playrumbleonentity( localclientnum, "shotgun_fire" );
        return;
    }
    
    if ( newval == 2 )
    {
        self earthquake( 0.1, 1, self.origin, 100 );
        self playrumbleonentity( localclientnum, "damage_heavy" );
        return;
    }
    
    if ( newval == 1 )
    {
        self playrumbleonentity( localclientnum, "damage_light" );
        return;
    }
    
    if ( newval == 7 )
    {
        self thread player_continuous_rumble( localclientnum, 1, 0 );
        return;
    }
    
    self notify( #"stop_rumble_and_shake" );
}

// Namespace zm_zod_util
// Params 3
// Checksum 0xdaf0a5d6, Offset: 0x400
// Size: 0x180
function player_continuous_rumble( localclientnum, rumble_level, shake_camera )
{
    if ( !isdefined( shake_camera ) )
    {
        shake_camera = 1;
    }
    
    self notify( #"stop_rumble_and_shake" );
    self endon( #"disconnect" );
    self endon( #"stop_rumble_and_shake" );
    start_time = gettime();
    
    while ( gettime() - start_time < 120000 )
    {
        if ( isdefined( self ) && self islocalplayer() && isdefined( self ) )
        {
            if ( rumble_level == 1 )
            {
                if ( shake_camera )
                {
                    self earthquake( 0.2, 1, self.origin, 100 );
                }
                
                self playrumbleonentity( localclientnum, "reload_small" );
                wait 0.05;
            }
            else
            {
                if ( shake_camera )
                {
                    self earthquake( 0.3, 1, self.origin, 100 );
                }
                
                self playrumbleonentity( localclientnum, "damage_light" );
            }
        }
        
        wait 0.1;
    }
}

