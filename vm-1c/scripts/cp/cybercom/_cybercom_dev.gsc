#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;

#namespace namespace_afd2f70b;

// Namespace namespace_afd2f70b
// Params 4, eflags: 0x1 linked
// Checksum 0xc5b65aea, Offset: 0x318
// Size: 0x1c0
function function_a0e51d80(point, timesec, size, color) {
    end = gettime() + timesec * 1000;
    halfwidth = int(size / 2);
    var_a84bd888 = point + (halfwidth * -1, 0, 0);
    var_1a5347c3 = point + (halfwidth, 0, 0);
    var_5e2b69e1 = point + (0, halfwidth * -1, 0);
    var_842de44a = point + (0, halfwidth, 0);
    var_e4d48d14 = point + (0, 0, halfwidth * -1);
    var_56dbfc4f = point + (0, 0, halfwidth);
    while (end > gettime()) {
        /#
            line(var_a84bd888, var_1a5347c3, color, 1, 0, 1);
            line(var_5e2b69e1, var_842de44a, color, 1, 0, 1);
            line(var_e4d48d14, var_56dbfc4f, color, 1, 0, 1);
        #/
        wait 0.05;
    }
}

/#

    // Namespace namespace_afd2f70b
    // Params 0, eflags: 0x1 linked
    // Checksum 0xfdd5b616, Offset: 0x4e0
    // Size: 0x3c
    function function_b9907dab() {
        execdevgui("<dev string:x28>");
        level thread function_7874d5f4();
    }

#/

// Namespace namespace_afd2f70b
// Params 0, eflags: 0x1 linked
// Checksum 0x85bbaa5, Offset: 0x528
// Size: 0x108
function function_244cbceb() {
    self notify(#"hash_244cbceb");
    self endon(#"hash_244cbceb");
    self endon(#"disconnect");
    self endon(#"spawned");
    while (true) {
        wait 1;
        if (isdefined(self.cybercom.var_ebeecfd5) && self.cybercom.var_ebeecfd5) {
            continue;
        }
        if (isdefined(self.cybercom.var_2e20c9bd)) {
            slot = self gadgetgetslot(self.cybercom.var_2e20c9bd);
            var_d921672c = self gadgetcharging(slot);
            if (var_d921672c) {
                self gadgetpowerchange(slot, 100);
            }
        }
    }
}

// Namespace namespace_afd2f70b
// Params 0, eflags: 0x1 linked
// Checksum 0x38569580, Offset: 0x638
// Size: 0x710
function function_7874d5f4() {
    setdvar("devgui_cybercore", "");
    setdvar("devgui_cybercore_upgrade", "");
    while (true) {
        cmd = getdvarstring("devgui_cybercore");
        if (cmd == "") {
            wait 0.5;
            continue;
        }
        playernum = getdvarint("scr_player_number") - 1;
        players = getplayers();
        if (playernum >= players.size) {
            setdvar("devgui_cybercore", "");
            setdvar("devgui_cybercore_upgrade", "");
            iprintlnbold("Invalid Player specified. Use SET PLAYER NUMBER in Cybercom DEVGUI to set valid player");
            continue;
        }
        if (cmd == "juiceme") {
            setdvar("devgui_cybercore", "");
            setdvar("devgui_cybercore_upgrade", "");
            iprintlnbold("Giving Constant Juice to all players");
            foreach (player in players) {
                player thread function_244cbceb();
            }
            continue;
        }
        if (cmd == "clearAll") {
            iprintlnbold("Clearing all abilities on all players");
            foreach (player in players) {
                player cybercom_tacrig::function_78908229();
                player namespace_d00ec32::function_c219b381();
            }
            setdvar("devgui_cybercore", "");
            setdvar("devgui_cybercore_upgrade", "");
            continue;
        }
        if (cmd == "giveAll") {
            iprintlnbold("Giving all abilities on all players");
            foreach (player in players) {
                player namespace_d00ec32::function_edff667f();
            }
            setdvar("devgui_cybercore", "");
            setdvar("devgui_cybercore_upgrade", "");
            continue;
        }
        player = players[playernum];
        playernum++;
        upgrade = getdvarint("devgui_cybercore_upgrade");
        if (cmd == "clearPlayer") {
            iprintlnbold("Clearing abilities on player: " + playernum);
            player cybercom_tacrig::function_78908229();
            player namespace_d00ec32::function_c219b381();
            setdvar("devgui_cybercore", "");
            setdvar("devgui_cybercore_upgrade", "");
            continue;
        } else if (cmd == "control") {
            setdvar("devgui_cybercore", "");
            setdvar("devgui_cybercore_upgrade", "");
            continue;
        } else if (cmd == "martial") {
            setdvar("devgui_cybercore", "");
            setdvar("devgui_cybercore_upgrade", "");
            continue;
        } else if (cmd == "chaos") {
            setdvar("devgui_cybercore", "");
            setdvar("devgui_cybercore_upgrade", "");
            continue;
        }
        if (isdefined(level.var_ab0cd3b2[cmd])) {
            player cybercom_tacrig::function_8ffa26e2(cmd, upgrade);
        } else {
            player namespace_d00ec32::function_a724d44(cmd, upgrade);
        }
        iprintlnbold("Adding ability on player: " + playernum + " --> " + cmd + "  Upgraded:" + (upgrade ? "TRUE" : "FALSE"));
        setdvar("devgui_cybercore", "");
        setdvar("devgui_cybercore_upgrade", "");
    }
}

