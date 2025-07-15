#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_stronghold_fx;
#using scripts/mp/mp_stronghold_sound;
#using scripts/shared/util_shared;

#namespace mp_stronghold;

// Namespace mp_stronghold
// Params 0
// Checksum 0x64c7b03c, Offset: 0x1c8
// Size: 0x8c
function main()
{
    mp_stronghold_fx::main();
    mp_stronghold_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient( 0 );
    level.endgamexcamname = "ui_cam_endgame_mp_stronghold";
}

// Namespace mp_stronghold
// Params 2
// Checksum 0xfcec84a3, Offset: 0x260
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

// Namespace mp_stronghold
// Params 2
// Checksum 0x143a4e82, Offset: 0x308
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

