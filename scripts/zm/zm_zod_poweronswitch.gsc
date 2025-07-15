#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;

#namespace zm_zod_poweronswitch;

// Namespace zm_zod_poweronswitch
// Method(s) 8 Total 8
class cpoweronswitch
{

    // Namespace cpoweronswitch
    // Params 0
    // Checksum 0xe984fea1, Offset: 0x538
    // Size: 0x94
    function local_power_on()
    {
        self.m_t_switch sethintstring( &"ZM_ZOD_POWERSWITCH_POWERED" );
        
        do
        {
            self.m_t_switch waittill( #"trigger", player );
        }
        while ( !can_player_use( player ) );
        
        self.m_t_switch setinvisibletoall();
        [[ self.m_func ]]( self.m_arg1 );
    }

    // Namespace cpoweronswitch
    // Params 1
    // Checksum 0x7076de93, Offset: 0x4e8
    // Size: 0x46, Type: bool
    function can_player_use( player )
    {
        if ( player zm_utility::in_revive_trigger() )
        {
            return false;
        }
        
        if ( player.is_drinking > 0 )
        {
            return false;
        }
        
        return true;
    }

    // Namespace cpoweronswitch
    // Params 0
    // Checksum 0xca7f8cca, Offset: 0x4c0
    // Size: 0x1c
    function show_activated_state()
    {
        self.m_t_switch setinvisibletoall();
    }

    // Namespace cpoweronswitch
    // Params 0
    // Checksum 0x2e261650, Offset: 0x478
    // Size: 0x3c
    function poweronswitch_think()
    {
        level flag::wait_till( "power_on" + self.m_n_power_index );
        local_power_on();
    }

    // Namespace cpoweronswitch
    // Params 2
    // Checksum 0xecc657e, Offset: 0x428
    // Size: 0x48, Type: bool
    function filter_areaname( e_entity, str_areaname )
    {
        if ( !isdefined( e_entity.script_string ) || e_entity.script_string != str_areaname )
        {
            return false;
        }
        
        return true;
    }

    // Namespace cpoweronswitch
    // Params 6
    // Checksum 0x7fd9638b, Offset: 0x238
    // Size: 0x1e4
    function init_poweronswitch( str_areaname, script_int, linkto_target, func, arg1, n_iter )
    {
        if ( !isdefined( n_iter ) )
        {
            n_iter = 0;
        }
        
        a_mdl_switch = getentarray( "stair_control", "targetname" );
        a_mdl_switch = array::filter( a_mdl_switch, 0, &filter_areaname, str_areaname );
        self.m_mdl_switch = a_mdl_switch[ n_iter ];
        a_t_switch = getentarray( "stair_control_usetrigger", "targetname" );
        a_t_switch = array::filter( a_t_switch, 0, &filter_areaname, str_areaname );
        self.m_t_switch = a_t_switch[ n_iter ];
        self.m_t_switch sethintstring( &"ZM_ZOD_POWERSWITCH_UNPOWERED" );
        self.m_n_power_index = script_int;
        self.m_func = func;
        self.m_arg1 = arg1;
        self.m_t_switch enablelinkto();
        self.m_t_switch linkto( self.m_mdl_switch );
        
        if ( isdefined( linkto_target ) )
        {
            self.m_mdl_switch linkto( linkto_target );
        }
        
        self thread poweronswitch_think();
    }

}

