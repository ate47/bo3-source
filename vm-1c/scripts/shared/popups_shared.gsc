#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/medals_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace popups;

// Namespace popups
// Params 0, eflags: 0x2
// namespace_b9abc0ac<file_0>::function_2dc19561
// Checksum 0xd9cee6ce, Offset: 0x248
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("popups", &__init__, undefined, undefined);
}

// Namespace popups
// Params 0, eflags: 0x1 linked
// namespace_b9abc0ac<file_0>::function_8c87d8eb
// Checksum 0x867e07c8, Offset: 0x288
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace popups
// Params 0, eflags: 0x1 linked
// namespace_b9abc0ac<file_0>::function_c35e6aab
// Checksum 0x1d47a933, Offset: 0x2b8
// Size: 0x1fc
function init() {
    level.contractsettings = spawnstruct();
    level.contractsettings.waittime = 4.2;
    level.killstreaksettings = spawnstruct();
    level.killstreaksettings.waittime = 3;
    level.ranksettings = spawnstruct();
    level.ranksettings.waittime = 3;
    level.startmessage = spawnstruct();
    level.startmessagedefaultduration = 2;
    level.endmessagedefaultduration = 2;
    level.challengesettings = spawnstruct();
    level.challengesettings.waittime = 3;
    level.teammessage = spawnstruct();
    level.teammessage.waittime = 3;
    level.var_b7c0bbe1 = spawnstruct();
    level.var_b7c0bbe1.waittime = 6;
    level.var_4b4bfc3a = spawnstruct();
    level.var_4b4bfc3a.waittime = 3;
    level.momentumnotifywaittime = 0;
    level.momentumnotifywaitlasttime = 0;
    level.teammessagequeuemax = 8;
    /#
        level thread popupsfromconsole();
        level thread function_9a14a686();
    #/
    callback::on_connecting(&on_player_connect);
}

// Namespace popups
// Params 0, eflags: 0x1 linked
// namespace_b9abc0ac<file_0>::function_fb4f96b5
// Checksum 0x545a4f4d, Offset: 0x4c0
// Size: 0x44
function on_player_connect() {
    self.resetgameoverhudrequired = 0;
    self thread function_d3829eca();
    if (!level.hardcoremode) {
        self thread function_57624cb5();
    }
}

/#

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_d661ce6
    // Checksum 0xb34eb0a6, Offset: 0x510
    // Size: 0x54
    function devgui_notif_getgunleveltablename() {
        if (sessionmodeiscampaigngame()) {
            return "type";
        }
        if (sessionmodeiszombiesgame()) {
            return "type";
        }
        return "type";
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_bcf0ce52
    // Checksum 0xa0aab2c2, Offset: 0x570
    // Size: 0x4e
    function devgui_notif_getchallengestablecount() {
        if (sessionmodeiscampaigngame()) {
            return 4;
        }
        if (sessionmodeiszombiesgame()) {
            return 4;
        }
        return 6;
    }

    // Namespace popups
    // Params 1, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_5f5fa154
    // Checksum 0x6cfda47e, Offset: 0x5c8
    // Size: 0x8a
    function devgui_notif_getchallengestablename(tableid) {
        if (sessionmodeiscampaigngame()) {
            return ("type" + tableid + "type");
        }
        if (sessionmodeiszombiesgame()) {
            return ("type" + tableid + "type");
        }
        return "type" + tableid + "type";
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_2358da67
    // Checksum 0xeb7d1c2f, Offset: 0x660
    // Size: 0x44
    function function_2358da67() {
        if (!isdefined(level.var_f543dad1)) {
            level.var_f543dad1 = tablelookupfindcoreasset(util::function_bc37a245());
        }
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_fd48e858
    // Checksum 0xbed6750f, Offset: 0x6b0
    // Size: 0x206
    function devgui_create_weapon_levels_table() {
        level.tbl_weaponids = [];
        function_2358da67();
        if (!isdefined(level.var_f543dad1)) {
            return;
        }
        for (i = 0; i < 256; i++) {
            var_c04d8f24 = tablelookuprownum(level.var_f543dad1, 0, i);
            if (var_c04d8f24 > -1) {
                group_s = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 2);
                if (issubstr(group_s, "type") || group_s == "type") {
                    reference_s = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 4);
                    if (reference_s != "type") {
                        weapon = getweapon(reference_s);
                        level.tbl_weaponids[i]["type"] = reference_s;
                        level.tbl_weaponids[i]["type"] = group_s;
                        level.tbl_weaponids[i]["type"] = int(tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 5));
                        level.tbl_weaponids[i]["type"] = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 8);
                    }
                }
            }
        }
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_9a14a686
    // Checksum 0xeb16da80, Offset: 0x8c0
    // Size: 0x114
    function function_9a14a686() {
        if (isdedicated()) {
            return;
        }
        if (getdvarint("type", -999) == -999) {
            setdvar("type", 0);
        }
        var_deda26ca = "type";
        util::add_devgui(var_deda26ca + "type", "type" + "type" + "type");
        while (true) {
            if (getdvarint("type", 0) > 0) {
                util::remove_devgui(var_deda26ca);
                level thread devgui_notif_init();
                break;
            }
            wait(1);
        }
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_4b6c58e5
    // Checksum 0x6c6630a3, Offset: 0x9e0
    // Size: 0xec
    function devgui_notif_init() {
        setdvar("type", 0);
        setdvar("type", 0);
        setdvar("type", 0);
        setdvar("type", 0);
        setdvar("type", 0);
        if (isdedicated()) {
            return;
        }
        level thread notif_devgui_rank();
        level thread notif_devgui_gun_rank();
        if (!sessionmodeiscampaigngame()) {
            level thread notif_devgui_challenges();
        }
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_e2246547
    // Checksum 0xa431cf3, Offset: 0xad8
    // Size: 0x124
    function notif_devgui_rank() {
        if (!isdefined(level.ranktable)) {
            return;
        }
        notif_rank_devgui_base = "type";
        for (i = 1; i < level.ranktable.size; i++) {
            display_level = i + 1;
            if (display_level < 10) {
                display_level = "type" + display_level;
            }
            adddebugcommand(notif_rank_devgui_base + display_level + "type" + "type" + "type" + "type" + i + "type");
            if (i % 10 == 0) {
                wait(0.05);
            }
        }
        wait(0.05);
        level thread notif_devgui_rank_up_think();
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_69d13854
    // Checksum 0x71c447b5, Offset: 0xc08
    // Size: 0x96
    function notif_devgui_rank_up_think() {
        for (;;) {
            rank_number = getdvarint("type");
            if (rank_number == 0) {
                wait(0.05);
                continue;
            }
            level.players[0] rank::codecallback_rankup(rank_number, 0, 1);
            setdvar("type", 0);
            wait(1);
        }
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_c3cec5b6
    // Checksum 0x3982cb3b, Offset: 0xca8
    // Size: 0x7fc
    function notif_devgui_gun_rank() {
        notif_gun_rank_devgui_base = "type";
        gunlevel_rankid_col = 0;
        gunlevel_gunref_col = 2;
        gunlevel_attachment_unlock_col = 3;
        gunlevel_xpgained_col = 4;
        level flag::wait_till("type");
        if (!isdefined(level.tbl_weaponids)) {
            devgui_create_weapon_levels_table();
        }
        if (!isdefined(level.tbl_weaponids)) {
            return;
        }
        a_weapons = [];
        a_weapons["type"] = [];
        a_weapons["type"] = [];
        a_weapons["type"] = [];
        a_weapons["type"] = [];
        a_weapons["type"] = [];
        a_weapons["type"] = [];
        a_weapons["type"] = [];
        a_weapons["type"] = [];
        gun_levels_table = devgui_notif_getgunleveltablename();
        foreach (weapon in level.tbl_weaponids) {
            gun = [];
            gun["type"] = weapon["type"];
            gun["type"] = getitemindexfromref(weapon["type"]);
            gun["type"] = [];
            gun_weapon_attachments = strtok(weapon["type"], "type");
            foreach (attachment in gun_weapon_attachments) {
                gun["type"][attachment] = [];
                gun["type"][attachment]["type"] = getattachmenttableindex(attachment);
                gun["type"][attachment]["type"] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun["type"], gunlevel_attachment_unlock_col, attachment, gunlevel_rankid_col);
                gun["type"][attachment]["type"] = tablelookup(gun_levels_table, gunlevel_gunref_col, gun["type"], gunlevel_attachment_unlock_col, attachment, gunlevel_xpgained_col);
            }
            switch (weapon["type"]) {
            case 8:
                if (weapon["type"] != "type") {
                    arrayinsert(a_weapons["type"], gun, 0);
                }
                break;
            case 8:
                arrayinsert(a_weapons["type"], gun, 0);
                break;
            case 8:
                arrayinsert(a_weapons["type"], gun, 0);
                break;
            case 8:
                arrayinsert(a_weapons["type"], gun, 0);
                break;
            case 8:
                arrayinsert(a_weapons["type"], gun, 0);
                break;
            case 8:
                arrayinsert(a_weapons["type"], gun, 0);
                break;
            case 8:
                arrayinsert(a_weapons["type"], gun, 0);
                break;
            case 8:
                arrayinsert(a_weapons["type"], gun, 0);
                break;
            default:
                break;
            }
        }
        foreach (group_name, gun_group in a_weapons) {
            foreach (gun, attachment_group in gun_group) {
                foreach (attachment, attachment_data in attachment_group["type"]) {
                    devgui_cmd_gun_path = notif_gun_rank_devgui_base + group_name + "type" + gun_group[gun]["type"] + "type" + attachment;
                    adddebugcommand(devgui_cmd_gun_path + "type" + "type" + "type" + "type" + "type" + attachment_data["type"] + "type" + "type" + "type" + attachment_data["type"] + "type" + "type" + "type" + gun_group[gun]["type"] + "type" + "type" + "type" + attachment_data["type"] + "type");
                }
            }
            wait(0.05);
        }
        level thread notif_devgui_gun_level_think();
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_503b1c43
    // Checksum 0x7df47c8f, Offset: 0x14b0
    // Size: 0x156
    function notif_devgui_gun_level_think() {
        for (;;) {
            weapon_item_index = getdvarint("type");
            if (weapon_item_index == 0) {
                wait(0.05);
                continue;
            }
            xp_reward = getdvarint("type");
            attachment_index = getdvarint("type");
            rank_id = getdvarint("type");
            level.players[0] persistence::codecallback_gunchallengecomplete(xp_reward, attachment_index, weapon_item_index, rank_id);
            setdvar("type", 0);
            setdvar("type", 0);
            setdvar("type", 0);
            setdvar("type", 0);
            wait(1);
        }
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_eafd7f5b
    // Checksum 0xe91159f8, Offset: 0x1610
    // Size: 0x32c
    function notif_devgui_challenges() {
        notif_challenges_devgui_base = "type";
        for (i = 1; i <= devgui_notif_getchallengestablecount(); i++) {
            tablename = devgui_notif_getchallengestablename(i);
            rows = tablelookuprowcount(tablename);
            for (j = 1; j < rows; j++) {
                challengeid = tablelookupcolumnforrow(tablename, j, 0);
                if (challengeid != "type" && strisint(tablelookupcolumnforrow(tablename, j, 0))) {
                    challengestring = tablelookupcolumnforrow(tablename, j, 5);
                    type = tablelookupcolumnforrow(tablename, j, 3);
                    challengetier = int(tablelookupcolumnforrow(tablename, j, 1));
                    challengetierstring = "type" + challengetier;
                    if (challengetier < 10) {
                        challengetierstring = "type" + challengetier;
                    }
                    name = tablelookupcolumnforrow(tablename, j, 5);
                    devgui_cmd_challenge_path = notif_challenges_devgui_base + type + "type" + makelocalizedstring(name) + "type" + challengetierstring + "type" + challengeid;
                    adddebugcommand(devgui_cmd_challenge_path + "type" + "type" + "type" + "type" + "type" + j + "type" + "type" + "type" + i + "type");
                    if (int(challengeid) % 10 == 0) {
                        wait(0.05);
                    }
                }
            }
        }
        level thread notif_devgui_challenges_think();
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_7ece286a
    // Checksum 0xb79669bd, Offset: 0x1948
    // Size: 0x346
    function notif_devgui_challenges_think() {
        setdvar("type", 0);
        setdvar("type", 0);
        for (;;) {
            row = getdvarint("type");
            table = getdvarint("type");
            if (table < 1 || table > devgui_notif_getchallengestablecount()) {
                wait(0.05);
                continue;
            }
            tablename = devgui_notif_getchallengestablename(table);
            if (row < 1 || row > tablelookuprowcount(tablename)) {
                wait(0.05);
                continue;
            }
            type = tablelookupcolumnforrow(tablename, row, 3);
            itemindex = 0;
            if (type == "type") {
                type = 0;
            } else if (type == "type") {
                itemindex = 4;
                type = 3;
            } else if (type == "type") {
                itemindex = 1;
                type = 4;
            } else if (type == "type") {
                type = 2;
            } else if (type == "type") {
                type = 5;
            } else {
                itemindex = 23;
                type = 1;
            }
            xpreward = int(tablelookupcolumnforrow(tablename, row, 6));
            challengeid = int(tablelookupcolumnforrow(tablename, row, 0));
            maxvalue = int(tablelookupcolumnforrow(tablename, row, 2));
            level.players[0] persistence::codecallback_challengecomplete(xpreward, maxvalue, row, table - 1, type, itemindex, challengeid);
            setdvar("type", 0);
            setdvar("type", 0);
            wait(1);
        }
    }

    // Namespace popups
    // Params 0, eflags: 0x1 linked
    // namespace_b9abc0ac<file_0>::function_2e0473ef
    // Checksum 0x7829fcca, Offset: 0x1c98
    // Size: 0x6a8
    function popupsfromconsole() {
        while (true) {
            timeout = getdvarfloat("type", 1);
            if (timeout == 0) {
                timeout = 1;
            }
            wait(timeout);
            medal = getdvarint("type", 0);
            challenge = getdvarint("type", 0);
            rank = getdvarint("type", 0);
            gun = getdvarint("type", 0);
            contractpass = getdvarint("type", 0);
            contractfail = getdvarint("type", 0);
            gamemodemsg = getdvarint("type", 0);
            teammsg = getdvarint("type", 0);
            challengeindex = getdvarint("type", 1);
            for (i = 0; i < medal; i++) {
                level.players[0] medals::codecallback_medal(86);
            }
            for (i = 0; i < challenge; i++) {
                level.players[0] persistence::codecallback_challengecomplete(1000, 10, 19, 0, 0, 0, 18);
                level.players[0] persistence::codecallback_challengecomplete(1000, 1, 21, 0, 0, 0, 20);
                rewardxp = 500;
                maxval = 1;
                row = 1;
                tablenumber = 0;
                challengetype = 1;
                itemindex = 111;
                challengeindex = 0;
                maxval = 50;
                row = 1;
                tablenumber = 2;
                challengetype = 1;
                itemindex = 20;
                challengeindex = 512;
                maxval = -106;
                row = 100;
                tablenumber = 2;
                challengetype = 4;
                itemindex = 1;
                challengeindex = 611;
                level.players[0] persistence::codecallback_challengecomplete(rewardxp, maxval, row, tablenumber, challengetype, itemindex, challengeindex);
            }
            for (i = 0; i < rank; i++) {
                level.players[0] rank::codecallback_rankup(4, 0, 1);
            }
            for (i = 0; i < gun; i++) {
                level.players[0] persistence::codecallback_gunchallengecomplete(0, 20, 25, 0);
            }
            for (i = 0; i < contractpass; i++) {
                level.players[0] persistence::function_8e1fc5b5(12, 1);
            }
            for (i = 0; i < contractfail; i++) {
                level.players[0] persistence::function_8e1fc5b5(12, 0);
            }
            for (i = 0; i < teammsg; i++) {
                player = level.players[0];
                if (isdefined(level.players[1])) {
                    player = level.players[1];
                }
                level.players[0] displayteammessagetoall(%type, player);
            }
            reset = getdvarint("type", 1);
            if (reset) {
                if (medal) {
                    setdvar("type", 0);
                }
                if (challenge) {
                    setdvar("type", 0);
                }
                if (gun) {
                    setdvar("type", 0);
                }
                if (rank) {
                    setdvar("type", 0);
                }
                if (contractpass) {
                    setdvar("type", 0);
                }
                if (contractfail) {
                    setdvar("type", 0);
                }
                if (gamemodemsg) {
                    setdvar("type", 0);
                }
                if (teammsg) {
                    setdvar("type", 0);
                }
            }
        }
    }

#/

// Namespace popups
// Params 2, eflags: 0x1 linked
// namespace_b9abc0ac<file_0>::function_8806ce2b
// Checksum 0x2092ebe5, Offset: 0x2348
// Size: 0x8c
function displaykillstreakteammessagetoall(killstreak, player) {
    if (!isdefined(level.killstreaks[killstreak])) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreak].inboundtext)) {
        return;
    }
    message = level.killstreaks[killstreak].inboundtext;
    self displayteammessagetoall(message, player);
}

// Namespace popups
// Params 2, eflags: 0x1 linked
// namespace_b9abc0ac<file_0>::function_49e598df
// Checksum 0x88cd6a5f, Offset: 0x23e0
// Size: 0x8c
function displaykillstreakhackedteammessagetoall(killstreak, player) {
    if (!isdefined(level.killstreaks[killstreak])) {
        return;
    }
    if (!isdefined(level.killstreaks[killstreak].hackedtext)) {
        return;
    }
    message = level.killstreaks[killstreak].hackedtext;
    self displayteammessagetoall(message, player);
}

// Namespace popups
// Params 0, eflags: 0x1 linked
// namespace_b9abc0ac<file_0>::function_8ac7791
// Checksum 0xb7681166, Offset: 0x2478
// Size: 0x2c
function shoulddisplayteammessages() {
    if (level.hardcoremode == 1 || level.splitscreen == 1) {
        return false;
    }
    return true;
}

// Namespace popups
// Params 2, eflags: 0x1 linked
// namespace_b9abc0ac<file_0>::function_7de845ed
// Checksum 0x2d8e08c5, Offset: 0x24b0
// Size: 0x136
function displayteammessagetoall(message, player) {
    if (!shoulddisplayteammessages()) {
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        cur_player = level.players[i];
        if (cur_player isempjammed()) {
            continue;
        }
        size = cur_player.teammessagequeue.size;
        if (size >= level.teammessagequeuemax) {
            continue;
        }
        cur_player.teammessagequeue[size] = spawnstruct();
        cur_player.teammessagequeue[size].message = message;
        cur_player.teammessagequeue[size].player = player;
        cur_player notify(#"hash_f0fa2450");
    }
}

// Namespace popups
// Params 3, eflags: 0x1 linked
// namespace_b9abc0ac<file_0>::function_6793049f
// Checksum 0xa1846b22, Offset: 0x25f0
// Size: 0x156
function displayteammessagetoteam(message, player, team) {
    if (!shoulddisplayteammessages()) {
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        cur_player = level.players[i];
        if (cur_player.team != team) {
            continue;
        }
        if (cur_player isempjammed()) {
            continue;
        }
        size = cur_player.teammessagequeue.size;
        if (size >= level.teammessagequeuemax) {
            continue;
        }
        cur_player.teammessagequeue[size] = spawnstruct();
        cur_player.teammessagequeue[size].message = message;
        cur_player.teammessagequeue[size].player = player;
        cur_player notify(#"hash_f0fa2450");
    }
}

// Namespace popups
// Params 0, eflags: 0x1 linked
// namespace_b9abc0ac<file_0>::function_57624cb5
// Checksum 0xacf6b28a, Offset: 0x2750
// Size: 0x150
function function_57624cb5() {
    if (!shoulddisplayteammessages()) {
        return;
    }
    self endon(#"disconnect");
    level endon(#"game_ended");
    self.teammessagequeue = [];
    for (;;) {
        if (self.teammessagequeue.size == 0) {
            self waittill(#"hash_f0fa2450");
        }
        if (self.teammessagequeue.size > 0) {
            nextnotifydata = self.teammessagequeue[0];
            arrayremoveindex(self.teammessagequeue, 0, 0);
            if (!isdefined(nextnotifydata.player) || !isplayer(nextnotifydata.player)) {
                continue;
            }
            if (self isempjammed()) {
                continue;
            }
            self luinotifyevent(%player_callout, 2, nextnotifydata.message, nextnotifydata.player.entnum);
        }
        wait(level.teammessage.waittime);
    }
}

// Namespace popups
// Params 0, eflags: 0x1 linked
// namespace_b9abc0ac<file_0>::function_d3829eca
// Checksum 0x928d1eb1, Offset: 0x28a8
// Size: 0x29a
function function_d3829eca() {
    self endon(#"disconnect");
    self.var_74e3ed71 = [];
    if (!isdefined(self.pers["challengeNotifyQueue"])) {
        self.pers["challengeNotifyQueue"] = [];
    }
    if (!isdefined(self.pers["contractNotifyQueue"])) {
        self.pers["contractNotifyQueue"] = [];
    }
    self.var_4c9e757e = [];
    self.var_f57b5d00 = [];
    self.var_2611c2db = [];
    while (isdefined(level) && isdefined(level.gameended) && !level.gameended) {
        if (!isdefined(self) || !isdefined(self.var_f57b5d00) || !isdefined(self.var_4c9e757e)) {
            break;
        }
        if (self.var_f57b5d00.size == 0 && self.var_4c9e757e.size == 0) {
            self waittill(#"hash_2528173");
        }
        waittillframeend();
        if (!isdefined(level)) {
            break;
        }
        if (!isdefined(level.gameended)) {
            break;
        }
        if (level.gameended) {
            break;
        }
        if (self.var_f57b5d00.size > 0) {
            nextnotifydata = self.var_f57b5d00[0];
            arrayremoveindex(self.var_f57b5d00, 0, 0);
            if (isdefined(nextnotifydata.duration)) {
                duration = nextnotifydata.duration;
            } else {
                duration = level.startmessagedefaultduration;
            }
            self hud_message::function_3cb967ea(nextnotifydata, duration);
            wait(duration);
            continue;
        }
        if (self.var_4c9e757e.size > 0) {
            nextnotifydata = self.var_4c9e757e[0];
            arrayremoveindex(self.var_4c9e757e, 0, 0);
            if (isdefined(nextnotifydata.duration)) {
                duration = nextnotifydata.duration;
            } else {
                duration = level.var_b7c0bbe1.waittime;
            }
            self hud_message::function_3cb967ea(nextnotifydata, duration);
            continue;
        }
        wait(1);
    }
}

// Namespace popups
// Params 4, eflags: 0x0
// namespace_b9abc0ac<file_0>::function_e370e13e
// Checksum 0x7f32b7f5, Offset: 0x2b50
// Size: 0x12a
function function_e370e13e(index, itemindex, type, tier) {
    level.globalchallenges++;
    if (!isdefined(type)) {
        type = "global";
    }
    size = self.pers["challengeNotifyQueue"].size;
    self.pers["challengeNotifyQueue"][size] = [];
    self.pers["challengeNotifyQueue"][size]["tier"] = tier;
    self.pers["challengeNotifyQueue"][size]["index"] = index;
    self.pers["challengeNotifyQueue"][size]["itemIndex"] = itemindex;
    self.pers["challengeNotifyQueue"][size]["type"] = type;
    self notify(#"hash_2528173");
}

