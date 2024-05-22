#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/system_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace menus;

// Namespace menus
// Params 0, eflags: 0x2
// Checksum 0xff147ca8, Offset: 0x2a8
// Size: 0x34
function function_2dc19561() {
    system::register("menus", &__init__, undefined, undefined);
}

// Namespace menus
// Params 0, eflags: 0x1 linked
// Checksum 0xdc954a3, Offset: 0x2e8
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
}

// Namespace menus
// Params 0, eflags: 0x1 linked
// Checksum 0x7acf8462, Offset: 0x338
// Size: 0x130
function init() {
    game["menu_start_menu"] = "StartMenu_Main";
    game["menu_team"] = "ChangeTeam";
    game["menu_class"] = "class";
    game["menu_changeclass"] = "ChooseClass_InGame";
    game["menu_changeclass_offline"] = "ChooseClass_InGame";
    foreach (team in level.teams) {
        game["menu_changeclass_" + team] = "ChooseClass_InGame";
    }
    game["menu_controls"] = "ingame_controls";
    game["menu_options"] = "ingame_options";
    game["menu_leavegame"] = "popup_leavegame";
}

// Namespace menus
// Params 0, eflags: 0x1 linked
// Checksum 0xa44618e0, Offset: 0x470
// Size: 0x1c
function on_player_connect() {
    self thread on_menu_response();
}

// Namespace menus
// Params 0, eflags: 0x1 linked
// Checksum 0xeb0582b3, Offset: 0x498
// Size: 0x448
function on_menu_response() {
    self endon(#"disconnect");
    for (;;) {
        menu, response = self waittill(#"menuresponse");
        if (response == "back") {
            self closeingamemenu();
            if (level.console) {
                if (menu == game["menu_changeclass"] || menu == game["menu_changeclass_offline"] || menu == game["menu_team"] || menu == game["menu_controls"]) {
                    if (isdefined(level.teams[self.pers["team"]])) {
                        self openmenu(game["menu_start_menu"]);
                    }
                }
            }
            continue;
        }
        if (response == "changeteam" && level.allow_teamchange == "1") {
            self closeingamemenu();
            self openmenu(game["menu_team"]);
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
        if (menu == game["menu_team"] && level.allow_teamchange == "1") {
            switch (response) {
            case 25:
                self [[ level.autoassign ]](1);
                break;
            case 26:
                self [[ level.spectator ]]();
                break;
            default:
                self [[ level.teammenu ]](response);
                break;
            }
            continue;
        }
        if (menu == game["menu_changeclass"] || menu == game["menu_changeclass_offline"]) {
            if (response != "cancel") {
                self closeingamemenu();
                if (level.rankedmatch && issubstr(response, "custom")) {
                    if (self isitemlocked(rank::getitemindex("feature_cac"))) {
                        kick(self getentitynumber());
                    }
                }
                self.selectedclass = 1;
                self [[ level.curclass ]](response);
            }
            continue;
        }
        if (menu == "spectate") {
            player = util::getplayerfromclientnum(int(response));
            if (isdefined(player)) {
                self setcurrentspectatorclient(player);
            }
        }
    }
}

