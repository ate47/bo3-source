#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/callbacks_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons_shared;
#using scripts/zm/_zm_weapons;

#namespace zm_bot;

// Namespace zm_bot
// Params 0, eflags: 0x2
// Checksum 0xe8a73f01, Offset: 0x1f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bot", &__init__, undefined, undefined );
}

// Namespace zm_bot
// Params 0
// Checksum 0xd54b1689, Offset: 0x238
// Size: 0xc4
function __init__()
{
    println( "<dev string:x28>" );
    
    /#
        level.onbotspawned = &on_bot_spawned;
        level.getbotthreats = &bot_combat::get_ai_threats;
        level.botprecombat = &bot::coop_pre_combat;
        level.botpostcombat = &bot::coop_post_combat;
        level.botidle = &bot::follow_coop_players;
        level.botdevguicmd = &bot::coop_bot_devgui_cmd;
        thread debug_coop_bot_test();
    #/
}

/#

    // Namespace zm_bot
    // Params 0
    // Checksum 0xb1f46eea, Offset: 0x308
    // Size: 0x1e8, Type: dev
    function debug_coop_bot_test()
    {
        botcount = 0;
        adddebugcommand( "<dev string:x5b>" );
        
        while ( true )
        {
            if ( getdvarint( "<dev string:xdf>" ) > 0 )
            {
                while ( getdvarint( "<dev string:xdf>" ) > 0 )
                {
                    if ( botcount > 0 && randomint( 100 ) > 60 )
                    {
                        adddebugcommand( "<dev string:xf8>" );
                        botcount--;
                        debugmsg( "<dev string:x10e>" + botcount );
                    }
                    else if ( botcount < getdvarint( "<dev string:xdf>" ) && randomint( 100 ) > 50 )
                    {
                        adddebugcommand( "<dev string:x12d>" );
                        botcount++;
                        debugmsg( "<dev string:x140>" + botcount );
                    }
                    
                    wait randomintrange( 1, 3 );
                }
            }
            else
            {
                while ( botcount > 0 )
                {
                    adddebugcommand( "<dev string:xf8>" );
                    botcount--;
                    debugmsg( "<dev string:x10e>" + botcount );
                    wait 1;
                }
            }
            
            wait 1;
        }
    }

    // Namespace zm_bot
    // Params 0
    // Checksum 0x18071df4, Offset: 0x4f8
    // Size: 0x64, Type: dev
    function on_bot_spawned()
    {
        host = bot::get_host_player();
        loadout = host zm_weapons::player_get_loadout();
        self zm_weapons::player_give_loadout( loadout );
    }

    // Namespace zm_bot
    // Params 1
    // Checksum 0x95d1e69, Offset: 0x568
    // Size: 0x64, Type: dev
    function debugmsg( str_txt )
    {
        iprintlnbold( str_txt );
        
        if ( isdefined( level.name ) )
        {
            println( "<dev string:x15c>" + level.name + "<dev string:x15e>" + str_txt );
        }
    }

#/
