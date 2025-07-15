#using scripts/codescripts/struct;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_lightning_chain;
#using scripts/zm/_zm_weapons;

#namespace _zm_weap_tesla;

// Namespace _zm_weap_tesla
// Params 0
// Checksum 0x744bfa64, Offset: 0x340
// Size: 0x184
function init()
{
    level.weaponzmteslagun = getweapon( "tesla_gun" );
    level.weaponzmteslagunupgraded = getweapon( "tesla_gun_upgraded" );
    
    if ( !zm_weapons::is_weapon_included( level.weaponzmteslagun ) && !( isdefined( level.uses_tesla_powerup ) && level.uses_tesla_powerup ) )
    {
        return;
    }
    
    level._effect[ "tesla_viewmodel_rail" ] = "zombie/fx_tesla_rail_view_zmb";
    level._effect[ "tesla_viewmodel_tube" ] = "zombie/fx_tesla_tube_view_zmb";
    level._effect[ "tesla_viewmodel_tube2" ] = "zombie/fx_tesla_tube_view2_zmb";
    level._effect[ "tesla_viewmodel_tube3" ] = "zombie/fx_tesla_tube_view3_zmb";
    level._effect[ "tesla_viewmodel_rail_upgraded" ] = "zombie/fx_tesla_rail_view_ug_zmb";
    level._effect[ "tesla_viewmodel_tube_upgraded" ] = "zombie/fx_tesla_tube_view_ug_zmb";
    level._effect[ "tesla_viewmodel_tube2_upgraded" ] = "zombie/fx_tesla_tube_view2_ug_zmb";
    level._effect[ "tesla_viewmodel_tube3_upgraded" ] = "zombie/fx_tesla_tube_view3_ug_zmb";
    level thread player_init();
    level thread tesla_notetrack_think();
}

// Namespace _zm_weap_tesla
// Params 0
// Checksum 0x69c2fb84, Offset: 0x4d0
// Size: 0x10e
function player_init()
{
    util::waitforclient( 0 );
    level.tesla_play_fx = [];
    level.tesla_play_rail = 1;
    players = getlocalplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        level.tesla_play_fx[ i ] = 0;
        players[ i ] thread tesla_fx_rail( i );
        players[ i ] thread tesla_fx_tube( i );
        players[ i ] thread tesla_happy( i );
        players[ i ] thread tesla_change_watcher( i );
    }
}

// Namespace _zm_weap_tesla
// Params 1
// Checksum 0x308fbea, Offset: 0x5e8
// Size: 0x1b8
function tesla_fx_rail( localclientnum )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    
    for ( ;; )
    {
        wait randomfloatrange( 8, 12 );
        
        if ( !level.tesla_play_fx[ localclientnum ] )
        {
            continue;
        }
        
        if ( !level.tesla_play_rail )
        {
            continue;
        }
        
        currentweapon = getcurrentweapon( localclientnum );
        
        if ( currentweapon != level.weaponzmteslagun && currentweapon != level.weaponzmteslagunupgraded )
        {
            continue;
        }
        
        if ( isads( localclientnum ) || isthrowinggrenade( localclientnum ) || ismeleeing( localclientnum ) || isonturret( localclientnum ) )
        {
            continue;
        }
        
        if ( getweaponammoclip( localclientnum, currentweapon ) <= 0 )
        {
            continue;
        }
        
        fx = level._effect[ "tesla_viewmodel_rail" ];
        
        if ( currentweapon == level.weaponzmteslagunupgraded )
        {
            fx = level._effect[ "tesla_viewmodel_rail_upgraded" ];
        }
        
        playviewmodelfx( localclientnum, fx, "tag_flash" );
        playsound( localclientnum, "wpn_tesla_effects", ( 0, 0, 0 ) );
    }
}

// Namespace _zm_weap_tesla
// Params 1
// Checksum 0x5c5f757e, Offset: 0x7a8
// Size: 0x350
function tesla_fx_tube( localclientnum )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    
    for ( ;; )
    {
        wait 0.1;
        
        if ( !level.tesla_play_fx[ localclientnum ] )
        {
            continue;
        }
        
        w_current = getcurrentweapon( localclientnum );
        
        if ( w_current != level.weaponzmteslagun && w_current != level.weaponzmteslagunupgraded )
        {
            continue;
        }
        
        if ( isthrowinggrenade( localclientnum ) || ismeleeing( localclientnum ) || isonturret( localclientnum ) )
        {
            continue;
        }
        
        n_ammo = getweaponammoclip( localclientnum, w_current );
        
        if ( n_ammo <= 0 )
        {
            self clear_tesla_tube_effect( localclientnum );
            continue;
        }
        
        str_fx = level._effect[ "tesla_viewmodel_tube" ];
        
        if ( w_current == level.weaponzmteslagunupgraded )
        {
            switch ( n_ammo )
            {
                case 1:
                case 2:
                    str_fx = level._effect[ "tesla_viewmodel_tube3_upgraded" ];
                    n_tint = 2;
                    break;
                case 3:
                case 4:
                    str_fx = level._effect[ "tesla_viewmodel_tube2_upgraded" ];
                    n_tint = 1;
                    break;
                default:
                    str_fx = level._effect[ "tesla_viewmodel_tube_upgraded" ];
                    n_tint = 0;
                    break;
            }
        }
        else
        {
            switch ( n_ammo )
            {
                case 1:
                    str_fx = level._effect[ "tesla_viewmodel_tube3" ];
                    n_tint = 2;
                    break;
                case 2:
                    str_fx = level._effect[ "tesla_viewmodel_tube2" ];
                    n_tint = 1;
                    break;
                default:
                    str_fx = level._effect[ "tesla_viewmodel_tube" ];
                    n_tint = 0;
                    break;
            }
        }
        
        if ( self.str_tesla_current_tube_effect === str_fx )
        {
            continue;
        }
        
        if ( isdefined( self.n_tesla_tube_fx_id ) )
        {
            deletefx( localclientnum, self.n_tesla_tube_fx_id, 1 );
        }
        
        self.str_tesla_current_tube_effect = str_fx;
        self.n_tesla_tube_fx_id = playviewmodelfx( localclientnum, str_fx, "tag_brass" );
        self mapshaderconstant( localclientnum, 0, "scriptVector2", 0, 1, n_tint, 0 );
    }
}

// Namespace _zm_weap_tesla
// Params 0
// Checksum 0x2ea8fe49, Offset: 0xb00
// Size: 0x7a
function tesla_notetrack_think()
{
    for ( ;; )
    {
        level waittill( #"notetrack", localclientnum, note );
        
        switch ( note )
        {
            case "tesla_play_fx_off":
                level.tesla_play_fx[ localclientnum ] = 0;
                break;
            default:
                level.tesla_play_fx[ localclientnum ] = 1;
                break;
        }
    }
}

// Namespace _zm_weap_tesla
// Params 1
// Checksum 0x8011ab1b, Offset: 0xb88
// Size: 0xa0
function tesla_happy( localclientnum )
{
    for ( ;; )
    {
        level waittill( #"tgh" );
        currentweapon = getcurrentweapon( localclientnum );
        
        if ( currentweapon == level.weaponzmteslagun || currentweapon == level.weaponzmteslagunupgraded )
        {
            playsound( localclientnum, "wpn_tesla_happy", ( 0, 0, 0 ) );
            level.tesla_play_rail = 0;
            wait 2;
            level.tesla_play_rail = 1;
        }
    }
}

// Namespace _zm_weap_tesla
// Params 1
// Checksum 0xe074b7d5, Offset: 0xc30
// Size: 0x48
function tesla_change_watcher( localclientnum )
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_change" );
        self clear_tesla_tube_effect( localclientnum );
    }
}

// Namespace _zm_weap_tesla
// Params 1
// Checksum 0x94ea0ee4, Offset: 0xc80
// Size: 0x7c
function clear_tesla_tube_effect( localclientnum )
{
    if ( isdefined( self.n_tesla_tube_fx_id ) )
    {
        deletefx( localclientnum, self.n_tesla_tube_fx_id, 1 );
        self.n_tesla_tube_fx_id = undefined;
        self.str_tesla_current_tube_effect = undefined;
        self mapshaderconstant( localclientnum, 0, "scriptVector2", 0, 1, 3, 0 );
    }
}

