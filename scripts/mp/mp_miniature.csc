#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_miniature_fx;
#using scripts/mp/mp_miniature_sound;
#using scripts/shared/util_shared;

#namespace mp_miniature;

// Namespace mp_miniature
// Params 0
// Checksum 0xdd0ff53e, Offset: 0x1c0
// Size: 0x8c
function main()
{
    mp_miniature_fx::main();
    mp_miniature_sound::main();
    load::main();
    level.domflagbasefxoverride = &dom_flag_base_fx_override;
    level.domflagcapfxoverride = &dom_flag_cap_fx_override;
    util::waitforclient( 0 );
    level.endgamexcamname = "ui_cam_endgame_mp_miniature";
}

// Namespace mp_miniature
// Params 2
// Checksum 0x626266db, Offset: 0x258
// Size: 0x7a
function dom_flag_base_fx_override( flag, team )
{
    switch ( flag.name )
    {
        case "a":
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

// Namespace mp_miniature
// Params 2
// Checksum 0x87fcd6f4, Offset: 0x2e0
// Size: 0x7a
function dom_flag_cap_fx_override( flag, team )
{
    switch ( flag.name )
    {
        case "a":
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

