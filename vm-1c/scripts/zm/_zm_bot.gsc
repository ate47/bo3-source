#using scripts/zm/_zm_weapons;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_bot;

// Namespace zm_bot
// Params 0, eflags: 0x2
// namespace_fe951448<file_0>::function_2dc19561
// Checksum 0xe8a73f01, Offset: 0x1f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bot", &__init__, undefined, undefined);
}

// Namespace zm_bot
// Params 0, eflags: 0x1 linked
// namespace_fe951448<file_0>::function_8c87d8eb
// Checksum 0xd54b1689, Offset: 0x238
// Size: 0xc4
function __init__() {
    println("<unknown string>");
    /#
        level.onbotspawned = &on_bot_spawned;
        level.var_93a32db5 = &namespace_5cd60c9f::function_3aa9220a;
        level.var_110e31eb = &bot::function_fd797;
        level.var_47854466 = &bot::function_ea8d70a6;
        level.var_ce074aba = &bot::function_1b93c521;
        level.var_f61e96da = &bot::function_ca7aa540;
        thread function_6e62d3e3();
    #/
}

/#

    // Namespace zm_bot
    // Params 0, eflags: 0x1 linked
    // namespace_fe951448<file_0>::function_6e62d3e3
    // Checksum 0xb1f46eea, Offset: 0x308
    // Size: 0x1e8
    function function_6e62d3e3() {
        botcount = 0;
        adddebugcommand("<unknown string>");
        while (true) {
            if (getdvarint("<unknown string>") > 0) {
                while (getdvarint("<unknown string>") > 0) {
                    if (botcount > 0 && randomint(100) > 60) {
                        adddebugcommand("<unknown string>");
                        botcount--;
                        debugmsg("<unknown string>" + botcount);
                    } else if (botcount < getdvarint("<unknown string>") && randomint(100) > 50) {
                        adddebugcommand("<unknown string>");
                        botcount++;
                        debugmsg("<unknown string>" + botcount);
                    }
                    wait(randomintrange(1, 3));
                }
            } else {
                while (botcount > 0) {
                    adddebugcommand("<unknown string>");
                    botcount--;
                    debugmsg("<unknown string>" + botcount);
                    wait(1);
                }
            }
            wait(1);
        }
    }

    // Namespace zm_bot
    // Params 0, eflags: 0x1 linked
    // namespace_fe951448<file_0>::function_3981de7
    // Checksum 0x18071df4, Offset: 0x4f8
    // Size: 0x64
    function on_bot_spawned() {
        host = bot::function_acc126dc();
        loadout = host zm_weapons::player_get_loadout();
        self zm_weapons::player_give_loadout(loadout);
    }

    // Namespace zm_bot
    // Params 1, eflags: 0x1 linked
    // namespace_fe951448<file_0>::function_aacf4c41
    // Checksum 0x95d1e69, Offset: 0x568
    // Size: 0x64
    function debugmsg(var_69ae6753) {
        iprintlnbold(var_69ae6753);
        if (isdefined(level.name)) {
            println("<unknown string>" + level.name + "<unknown string>" + var_69ae6753);
        }
    }

#/
