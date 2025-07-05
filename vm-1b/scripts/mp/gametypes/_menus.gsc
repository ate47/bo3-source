#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/callbacks_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/system_shared;

#namespace menus;

// Namespace menus
// Params 0, eflags: 0x2
// Checksum 0x512099b0, Offset: 0x2a8
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("menus", &__init__, undefined, undefined);
}

// Namespace menus
// Params 0, eflags: 0x0
// Checksum 0x5dbd0200, Offset: 0x2e0
// Size: 0x42
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace menus
// Params 0, eflags: 0x0
// Checksum 0x3bdd6785, Offset: 0x330
// Size: 0x31
function init() {
    InvalidOpCode(0xc8, "menu_start_menu", "StartMenu_Main");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace menus
// Params 0, eflags: 0x0
// Checksum 0x4b3ce5b, Offset: 0x420
// Size: 0x12
function on_player_connect() {
    self thread on_menu_response();
}

// Namespace menus
// Params 0, eflags: 0x0
// Checksum 0x57f7282a, Offset: 0x440
// Size: 0x355
function on_menu_response() {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"menuresponse", menu, response);
        if (response == "back") {
            self closeingamemenu();
            if (level.console) {
                InvalidOpCode(0x54, "menu_changeclass", menu);
                // Unknown operator (0x54, t7_1b, PC)
            }
            continue;
        }
        if (response == "changeteam" && level.allow_teamchange == "1") {
            self closeingamemenu();
            InvalidOpCode(0x54, "menu_team");
            // Unknown operator (0x54, t7_1b, PC)
        }
        if (response == "endgame") {
            if (level.splitscreen) {
                level.skipvote = 1;
                if (!level.gameended) {
                    level thread globallogic::forceend();
                }
            }
            continue;
        }
        if (response == "killserverpc") {
            level thread globallogic::killserverpc();
            continue;
        }
        if (response == "endround") {
            if (!level.gameended) {
                self globallogic::gamehistoryplayerquit();
                level thread globallogic::forceend();
            } else {
                self closeingamemenu();
                self iprintln(%MP_HOST_ENDGAME_RESPONSE);
            }
            continue;
        }
        InvalidOpCode(0x54, "menu_team", menu);
        // Unknown operator (0x54, t7_1b, PC)
    }
}

