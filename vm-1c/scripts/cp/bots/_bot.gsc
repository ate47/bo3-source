#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;

#namespace bot;

// Namespace bot
// Params 0, eflags: 0x2
// Checksum 0x1bd9faba, Offset: 0xf8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("bot_cp", &__init__, undefined, undefined);
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x33f6b130, Offset: 0x138
// Size: 0x94
function __init__() {
    /#
        level.onbotconnect = &on_bot_connect;
        level.var_93a32db5 = &namespace_5cd60c9f::function_3aa9220a;
        level.var_110e31eb = &function_fd797;
        level.var_47854466 = &function_ea8d70a6;
        level.var_ce074aba = &function_1b93c521;
        level.var_f61e96da = &function_ca7aa540;
    #/
}

/#

    // Namespace bot
    // Params 0, eflags: 0x0
    // Checksum 0x3f4002b6, Offset: 0x1d8
    // Size: 0x68
    function on_bot_connect() {
        self endon(#"disconnect");
        wait 0.25;
        self notify(#"menuresponse", "<dev string:x28>", "<dev string:x3b>");
        wait 0.25;
        if (isdefined(self.pers)) {
            self.var_273d3e89 = self.pers["<dev string:x49>"];
        }
    }

#/
