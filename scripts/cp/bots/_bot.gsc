#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;

#namespace bot;

// Namespace bot
// Params 0, eflags: 0x2
// Checksum 0x1bd9faba, Offset: 0xf8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "bot_cp", &__init__, undefined, undefined );
}

// Namespace bot
// Params 0
// Checksum 0x33f6b130, Offset: 0x138
// Size: 0x94
function __init__()
{
    /#
        level.onbotconnect = &on_bot_connect;
        level.getbotthreats = &bot_combat::get_ai_threats;
        level.botprecombat = &coop_pre_combat;
        level.botpostcombat = &coop_post_combat;
        level.botidle = &follow_coop_players;
        level.botdevguicmd = &coop_bot_devgui_cmd;
    #/
}

/#

    // Namespace bot
    // Params 0
    // Checksum 0x3f4002b6, Offset: 0x1d8
    // Size: 0x68, Type: dev
    function on_bot_connect()
    {
        self endon( #"disconnect" );
        wait 0.25;
        self notify( #"menuresponse", "<dev string:x28>", "<dev string:x3b>" );
        wait 0.25;
        
        if ( isdefined( self.pers ) )
        {
            self.bcvoicenumber = self.pers[ "<dev string:x49>" ];
        }
    }

#/
