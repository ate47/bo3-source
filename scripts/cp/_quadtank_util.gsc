#using scripts/cp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace quadtank_util;

// Namespace quadtank_util
// Params 0
// Checksum 0xee5b8adf, Offset: 0x1c8
// Size: 0x3c
function function_35209d64()
{
    self thread function_ea61aedc();
    callback::on_vehicle_damage( &function_610493ff, self );
}

// Namespace quadtank_util
// Params 0
// Checksum 0xe8ab1e2a, Offset: 0x210
// Size: 0x18c
function function_ea61aedc()
{
    self endon( #"death" );
    self endon( #"hash_f1e417ec" );
    var_fae93870 = 0;
    var_c1df3693 = 2;
    var_9a15ea97 = getweapon( "launcher_standard" );
    
    while ( true )
    {
        self notify( #"quad_tank_trophy_hint_disable" );
        self waittill( #"projectile_applyattractor", missile );
        
        if ( missile.weapon === var_9a15ea97 )
        {
            var_fae93870++;
            
            if ( var_fae93870 >= var_c1df3693 )
            {
                var_fae93870 = 0;
                
                foreach ( player in level.activeplayers )
                {
                    player thread util::show_hint_text( &"OBJECTIVES_QUAD_TANK_HINT_TROPHY", 0, "quad_tank_trophy_hint_disable" );
                    player thread quad_tank_trophy_hint_disable( self );
                }
                
                var_c1df3693 *= 2;
            }
            
            wait 2;
        }
    }
}

// Namespace quadtank_util
// Params 1
// Checksum 0x88565738, Offset: 0x3a8
// Size: 0x70
function quad_tank_trophy_hint_disable( var_ac4390f )
{
    var_ac4390f endon( #"quad_tank_trophy_hint_disable" );
    var_ac4390f endon( #"death" );
    self endon( #"death" );
    var_ac4390f util::waittill_any( "trophy_system_disabled", "trophy_system_destroyed" );
    self notify( #"quad_tank_trophy_hint_disable" );
    var_ac4390f notify( #"quad_tank_trophy_hint_disable" );
}

// Namespace quadtank_util
// Params 2
// Checksum 0xdd17963, Offset: 0x420
// Size: 0x164
function function_610493ff( obj, params )
{
    if ( isplayer( params.eattacker ) && self quadtank::trophy_disabled() && issubstr( params.smeansofdeath, "BULLET" ) )
    {
        player = params.eattacker;
        
        if ( isdefined( player.var_d4b7c617 ) )
        {
            player.var_d4b7c617 += params.idamage;
        }
        else
        {
            player.var_d4b7c617 = params.idamage;
        }
        
        if ( player.var_d4b7c617 >= 999 )
        {
            player.var_d4b7c617 = 0;
            player notify( #"quad_tank_rocket_hint_disable" );
            player thread util::show_hint_text( &"OBJECTIVES_QUAD_TANK_HINT_ROCKET", 0, "quad_tank_rocket_hint_disable" );
            player thread quad_tank_rocket_hint_disable( self );
        }
    }
}

// Namespace quadtank_util
// Params 1
// Checksum 0xcdb4a8fd, Offset: 0x590
// Size: 0x10e
function quad_tank_rocket_hint_disable( var_ac4390f )
{
    var_ac4390f endon( #"death" );
    self endon( #"death" );
    self endon( #"quad_tank_rocket_hint_disable" );
    
    while ( true )
    {
        var_ac4390f waittill( #"damage", n_damage, e_attacker, direction_vec, v_impact_point, damagetype, modelname, tagname, partname, weapon, idflags );
        
        if ( weapon.weapclass === "rocketlauncher" && isplayer( e_attacker ) )
        {
            var_ac4390f notify( #"quad_tank_rocket_hint_disable" );
            self notify( #"quad_tank_rocket_hint_disable" );
        }
    }
}

