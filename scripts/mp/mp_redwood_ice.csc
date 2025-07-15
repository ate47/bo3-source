#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_redwood_ice_fx;
#using scripts/mp/mp_redwood_ice_sound;
#using scripts/shared/util_shared;

#namespace mp_redwood_ice;

// Namespace mp_redwood_ice
// Params 0
// Checksum 0xb3ae5a4d, Offset: 0x1e8
// Size: 0xcc
function main()
{
    mp_redwood_ice_fx::main();
    mp_redwood_ice_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    setdvar( "phys_buoyancy", 1 );
    setdvar( "phys_ragdoll_buoyancy", 1 );
    util::waitforclient( 0 );
    level.endgamexcamname = "ui_cam_endgame_mp_redwood";
}

// Namespace mp_redwood_ice
// Params 2
// Checksum 0xe5734b58, Offset: 0x2c0
// Size: 0x9e
function dom_flag_base_fx_override( flag, team )
{
    switch ( flag.name )
    {
        case "a":
            if ( team == "neutral" )
            {
                return "ui/fx_dom_marker_neutral_r120";
            }
            else
            {
                return "ui/fx_dom_marker_team_r120";
            }
            
            break;
        case "b":
            break;
        default:
            if ( team == "neutral" )
            {
                return "ui/fx_dom_marker_neutral_r120";
            }
            else
            {
                return "ui/fx_dom_marker_team_r120";
            }
            
            break;
    }
}

// Namespace mp_redwood_ice
// Params 2
// Checksum 0x925cf255, Offset: 0x368
// Size: 0x9e
function dom_flag_cap_fx_override( flag, team )
{
    switch ( flag.name )
    {
        case "a":
            if ( team == "neutral" )
            {
                return "ui/fx_dom_cap_indicator_neutral_r120";
            }
            else
            {
                return "ui/fx_dom_cap_indicator_team_r120";
            }
            
            break;
        case "b":
            break;
        default:
            if ( team == "neutral" )
            {
                return "ui/fx_dom_cap_indicator_neutral_r120";
            }
            else
            {
                return "ui/fx_dom_cap_indicator_team_r120";
            }
            
            break;
    }
}

