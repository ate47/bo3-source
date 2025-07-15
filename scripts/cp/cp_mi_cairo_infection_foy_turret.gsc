#using scripts/codescripts/struct;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace foy_turret;

// Namespace foy_turret
// Method(s) 10 Total 10
class cfoyturret
{

    // Namespace cfoyturret
    // Params 0
    // Checksum 0x3f8bb9e1, Offset: 0x960
    // Size: 0xa
    function get_vehicle()
    {
        return self.m_vehicle;
    }

    // Namespace cfoyturret
    // Params 0
    // Checksum 0x98db8119, Offset: 0x7d8
    // Size: 0x17e
    function find_new_gunner()
    {
        a_enemies = getaiteamarray( "axis" );
        a_valid = [];
        
        foreach ( e_enemy in a_enemies )
        {
            if ( isalive( e_enemy ) )
            {
                if ( e_enemy istouching( self.m_t_gunner ) )
                {
                    if ( !isdefined( a_valid ) )
                    {
                        a_valid = [];
                    }
                    else if ( !isarray( a_valid ) )
                    {
                        a_valid = array( a_valid );
                    }
                    
                    a_valid[ a_valid.size ] = e_enemy;
                }
            }
        }
        
        ai_gunner = arraysort( a_valid, self.m_vehicle.origin, 1, a_valid.size )[ 0 ];
        return ai_gunner;
    }

    // Namespace cfoyturret
    // Params 0
    // Checksum 0xd585f8a9, Offset: 0x798
    // Size: 0x38
    function vehicle_death()
    {
        self.m_vehicle waittill( #"death" );
        delete_gunner();
        self.m_vehicle = undefined;
    }

    // Namespace cfoyturret
    // Params 0
    // Checksum 0x3c96cca0, Offset: 0x738
    // Size: 0x54
    function delete_gunner()
    {
        ai_gunner = self.m_vehicle vehicle::get_rider( "driver" );
        
        if ( isdefined( ai_gunner ) )
        {
            ai_gunner delete();
        }
    }

    // Namespace cfoyturret
    // Params 1
    // Checksum 0x9b2b841a, Offset: 0x4d8
    // Size: 0x258
    function gunner_think( b_find_new_gunner )
    {
        if ( !isdefined( b_find_new_gunner ) )
        {
            b_find_new_gunner = 0;
        }
        
        self.m_vehicle endon( #"death" );
        self.m_vehicle turret::set_burst_parameters( 1, 2, 0.25, 0.75, 0 );
        
        while ( true )
        {
            ai_gunner = self.m_vehicle vehicle::get_rider( "driver" );
            
            if ( isdefined( ai_gunner ) )
            {
                self.m_vehicle turret::enable( 0, 1 );
                self.m_vehicle flag::set( "gunner_position_occupied" );
                ai_gunner waittill( #"death" );
                level notify( self.m_vehicle.targetname + "_gunner_death" );
            }
            
            self.m_vehicle turret::disable( 0 );
            self.m_vehicle flag::clear( "gunner_position_occupied" );
            
            if ( b_find_new_gunner )
            {
                wait randomfloatrange( 4, 5 );
                ai_gunner_next = find_new_gunner();
                
                if ( isalive( ai_gunner_next ) )
                {
                    if ( vehicle::is_seat_available( self.m_vehicle, "driver" ) )
                    {
                        ai_gunner_next thread vehicle::get_in( self.m_vehicle, "driver", 0 );
                        ai_gunner_next util::waittill_any( "death", "in_vehicle", "exited_vehicle" );
                    }
                }
                
                continue;
            }
            
            break;
        }
    }

    // Namespace cfoyturret
    // Params 0
    // Checksum 0xf4106468, Offset: 0x4b8
    // Size: 0x12
    function gunner_start_think()
    {
        self notify( #"gunner_start_think" );
    }

    // Namespace cfoyturret
    // Params 0
    // Checksum 0x48b2dca4, Offset: 0x438
    // Size: 0x74
    function turret_think()
    {
        self.m_vehicle endon( #"death" );
        self thread vehicle_death();
        self waittill( #"gunner_start_think" );
        
        if ( isdefined( self.m_t_gunner ) )
        {
            self thread gunner_think( 1 );
            return;
        }
        
        self thread gunner_think( 0 );
    }

    // Namespace cfoyturret
    // Params 3
    // Checksum 0xe5789ba2, Offset: 0x318
    // Size: 0x114
    function turret_setup( vehicle, str_gunner_name, str_gunner_trigger )
    {
        self.m_vehicle = vehicle;
        self.m_vehicle flag::init( "gunner_position_occupied" );
        
        if ( isdefined( str_gunner_name ) )
        {
            sp_gunner = getent( str_gunner_name, "targetname" );
            ai_gunner = spawner::simple_spawn_single( sp_gunner );
            ai_gunner vehicle::get_in( self.m_vehicle, "driver", 1 );
        }
        
        if ( isdefined( str_gunner_trigger ) )
        {
            self.m_t_gunner = getent( str_gunner_trigger, "targetname" );
        }
        
        self thread turret_think();
    }

}

// Namespace foy_turret
// Params 0, eflags: 0x2
// Checksum 0x9d57bf2b, Offset: 0x2a8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "foy_turret", &__init__, undefined, undefined );
}

// Namespace foy_turret
// Params 0
// Checksum 0x99ec1590, Offset: 0x2e8
// Size: 0x4
function __init__()
{
    
}

