#using scripts/codescripts/struct;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/load_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;

#namespace devgui;

/#

    // Namespace devgui
    // Params 0, eflags: 0x2
    // Checksum 0xc26f8a2c, Offset: 0x200
    // Size: 0x2a
    function autoexec __init__sytem__() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xca05ee09, Offset: 0x238
    // Size: 0x42a
    function __init__() {
        setdvar("<dev string:x2f>", "<dev string:x3e>");
        setdvar("<dev string:x3f>", 0);
        setdvar("<dev string:x53>", 0);
        setdvar("<dev string:x6f>", 0);
        setdvar("<dev string:x97>", 0);
        setdvar("<dev string:xb9>", 0);
        setdvar("<dev string:xea>", "<dev string:x122>");
        setdvar("<dev string:x127>", "<dev string:x122>");
        setdvar("<dev string:x15f>", "<dev string:x122>");
        setdvar("<dev string:x182>", "<dev string:x122>");
        setdvar("<dev string:x1a1>", "<dev string:x122>");
        setdvar("<dev string:x1c0>", "<dev string:x122>");
        setdvar("<dev string:x1df>", "<dev string:x122>");
        setdvar("<dev string:x1fe>", "<dev string:x122>");
        setdvar("<dev string:x21d>", "<dev string:x122>");
        level.attachment_cycling_dvars = [];
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x182>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x1a1>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x1c0>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x1df>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x1fe>";
        level.attachment_cycling_dvars[level.attachment_cycling_dvars.size] = "<dev string:x21d>";
        setdvar("<dev string:x23c>", 0);
        setdvar("<dev string:x254>", 0);
        setdvar("<dev string:x26c>", 0);
        setdvar("<dev string:x284>", 0);
        setdvar("<dev string:x29c>", 0);
        setdvar("<dev string:x2b4>", 0);
        level.var_1bb167c4 = [];
        level.var_1bb167c4[level.var_1bb167c4.size] = "<dev string:x23c>";
        level.var_1bb167c4[level.var_1bb167c4.size] = "<dev string:x254>";
        level.var_1bb167c4[level.var_1bb167c4.size] = "<dev string:x26c>";
        level.var_1bb167c4[level.var_1bb167c4.size] = "<dev string:x284>";
        level.var_1bb167c4[level.var_1bb167c4.size] = "<dev string:x29c>";
        level.var_1bb167c4[level.var_1bb167c4.size] = "<dev string:x2b4>";
        level thread devgui_weapon_think();
        level thread devgui_weapon_asset_name_display_think();
        level thread devgui_player_weapons();
        level thread devgui_test_chart_think();
        level thread devgui_player_spawn_think();
        thread init_debug_center_screen();
        level thread dev::body_customization_devgui(1);
        callback::on_connect(&hero_art_on_player_connect);
        callback::on_connect(&on_player_connect);
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x88cdbcde, Offset: 0x670
    // Size: 0x22
    function on_player_connect() {
        /#
            self.devguilockspawn = 0;
            self thread devgui_player_spawn();
        #/
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x2429eae5, Offset: 0x6a0
    // Size: 0x113
    function devgui_player_spawn() {
        wait 1;
        player_devgui_base_mp = "<dev string:x2cc>";
        wait 0.05;
        players = getplayers();
        foreach (player in players) {
            if (player != self) {
                continue;
            }
            temp = player_devgui_base_mp + player.playername + "<dev string:x2eb>" + "<dev string:x53>" + "<dev string:x2f3>" + player.playername + "<dev string:x2f5>";
            adddebugcommand(player_devgui_base_mp + player.playername + "<dev string:x2eb>" + "<dev string:x53>" + "<dev string:x2f3>" + player.playername + "<dev string:x2f5>");
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd811350b, Offset: 0x7c0
    // Size: 0x125
    function devgui_player_spawn_think() {
        for (;;) {
            playername = getdvarstring("<dev string:x53>");
            if (playername == "<dev string:x3e>") {
                wait 0.05;
                continue;
            }
            players = getplayers();
            foreach (player in players) {
                if (player.playername != playername) {
                    continue;
                }
                player.devguilockspawn = !player.devguilockspawn;
                if (player.devguilockspawn) {
                    player.resurrect_origin = player.origin;
                    player.resurrect_angles = player.angles;
                }
            }
            setdvar("<dev string:x53>", "<dev string:x3e>");
            wait 0.5;
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x2d4cac20, Offset: 0x8f0
    // Size: 0x65a
    function devgui_player_weapons() {
        InvalidOpCode(0x54, "<dev string:x2f8>");
        // Unknown operator (0x54, t7_1b, PC)
    }

    // Namespace devgui
    // Params 6, eflags: 0x0
    // Checksum 0xba1046ac, Offset: 0xf58
    // Size: 0x181
    function devgui_add_player_weapons(root, pname, index, a_weapons, weapon_type, mindex) {
        if (isdedicated()) {
            return;
        }
        devgui_root = root + weapon_type + "<dev string:x3d0>";
        if (isdefined(a_weapons)) {
            for (i = 0; i < a_weapons.size; i++) {
                attachments = a_weapons[i].supportedattachments;
                name = a_weapons[i].name;
                if (attachments.size) {
                    devgui_add_player_weap_command(devgui_root + name + "<dev string:x3d0>", index, name, i + 1);
                    foreach (att in attachments) {
                        if (att != "<dev string:x122>") {
                            devgui_add_player_weap_command(devgui_root + name + "<dev string:x3d0>", index, name + "<dev string:x49a>" + att, i + 1);
                        }
                    }
                    continue;
                }
                devgui_add_player_weap_command(devgui_root, index, name, i + 1);
            }
        }
    }

    // Namespace devgui
    // Params 4, eflags: 0x0
    // Checksum 0xd3431882, Offset: 0x10e8
    // Size: 0x5a
    function devgui_add_player_weap_command(root, pid, weap_name, cmdindex) {
        adddebugcommand(root + weap_name + "<dev string:x2eb>" + "<dev string:x2f>" + "<dev string:x2f3>" + weap_name + "<dev string:x3e0>");
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xdd277151, Offset: 0x1150
    // Size: 0x7d
    function devgui_weapon_think() {
        for (;;) {
            weapon_name = getdvarstring("<dev string:x2f>");
            if (weapon_name != "<dev string:x3e>") {
                devgui_handle_player_command(&devgui_give_weapon, weapon_name);
            }
            setdvar("<dev string:x2f>", "<dev string:x3e>");
            wait 0.5;
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x24ac98c3, Offset: 0x11d8
    // Size: 0x1a
    function hero_art_on_player_connect() {
        self._debugheromodels = spawnstruct();
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc0e12efd, Offset: 0x1200
    // Size: 0x2bd
    function devgui_weapon_asset_name_display_think() {
        update_time = 1;
        print_duration = int(update_time / 0.05);
        printlnbold_update = int(1 / update_time);
        printlnbold_counter = 0;
        colors = [];
        colors[colors.size] = (1, 1, 1);
        colors[colors.size] = (1, 0, 0);
        colors[colors.size] = (0, 1, 0);
        colors[colors.size] = (1, 1, 0);
        colors[colors.size] = (1, 0, 1);
        colors[colors.size] = (0, 1, 1);
        for (;;) {
            wait update_time;
            display = getdvarint("<dev string:x97>");
            if (!display) {
                continue;
            }
            if (!printlnbold_counter) {
                iprintlnbold(level.players[0] getcurrentweapon().name);
            }
            printlnbold_counter++;
            if (printlnbold_counter >= printlnbold_update) {
                printlnbold_counter = 0;
            }
            color_index = 0;
            for (i = 1; i < level.players.size; i++) {
                player = level.players[i];
                weapon = player getcurrentweapon();
                if (!isdefined(weapon) || level.weaponnone == weapon) {
                    continue;
                }
                print3d(player gettagorigin("<dev string:x49c>"), weapon.name, colors[color_index], 1, 0.15, print_duration);
                color_index++;
                if (color_index >= colors.size) {
                    color_index = 0;
                }
            }
            color_index = 0;
            ai_list = getaiarray();
            for (i = 0; i < ai_list.size; i++) {
                ai = ai_list[i];
                if (isvehicle(ai)) {
                    weapon = ai.turretweapon;
                } else {
                    weapon = ai.weapon;
                }
                if (!isdefined(weapon) || level.weaponnone == weapon) {
                    continue;
                }
                print3d(ai gettagorigin("<dev string:x49c>"), weapon.name, colors[color_index], 1, 0.15, print_duration);
                color_index++;
                if (color_index >= colors.size) {
                    color_index = 0;
                }
            }
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x50371ea0, Offset: 0x14c8
    // Size: 0xed
    function function_496dcd72() {
        var_4f415009 = 0;
        var_5a98ebfc = "<dev string:x122>";
        var_cca05b37 = "<dev string:x122>";
        for (;;) {
            index = getdvarint("<dev string:xb9>");
            var_820a0a2e = getdvarstring("<dev string:xea>");
            var_5c078fc5 = getdvarstring("<dev string:x127>");
            if (var_5a98ebfc != var_820a0a2e || var_cca05b37 != var_5c078fc5 || var_4f415009 != index) {
                devgui_handle_player_command(&function_5ef38019, var_820a0a2e, var_5c078fc5);
            }
            var_4f415009 = index;
            var_5a98ebfc = var_820a0a2e;
            var_cca05b37 = var_5c078fc5;
            wait 0.5;
        }
    }

    // Namespace devgui
    // Params 1, eflags: 0x0
    // Checksum 0x7f9b8853, Offset: 0x15c0
    // Size: 0x42
    function devgui_attachment_cycling_clear(index) {
        setdvar(level.attachment_cycling_dvars[index], "<dev string:x122>");
        setdvar(level.var_1bb167c4[index], 0);
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x14517eb1, Offset: 0x1610
    // Size: 0x352
    function devgui_attachment_cycling_update() {
        currentweapon = self getcurrentweapon();
        rootweapon = currentweapon.rootweapon;
        supportedattachments = currentweapon.supportedattachments;
        textcolors = [];
        attachments = [];
        var_49dd67d4 = [];
        originalattachments = [];
        var_28bb247d = [];
        for (i = 0; i < 6; i++) {
            originalattachments[i] = getdvarstring(level.attachment_cycling_dvars[i]);
            var_28bb247d[i] = getdvarint(level.var_1bb167c4[i]);
            textcolor[i] = "<dev string:x4a6>";
            attachments[i] = "<dev string:x122>";
            var_49dd67d4[i] = 0;
            name = originalattachments[i];
            if ("<dev string:x122>" == name) {
                continue;
            }
            textcolor[i] = "<dev string:x4a9>";
            for (supportedindex = 0; supportedindex < supportedattachments.size; supportedindex++) {
                if (name == supportedattachments[supportedindex]) {
                    textcolor[i] = "<dev string:x4a6>";
                    attachments[i] = name;
                    var_49dd67d4[i] = var_28bb247d[i];
                    break;
                }
            }
        }
        for (i = 0; i < 6; i++) {
            if ("<dev string:x122>" == originalattachments[i]) {
                continue;
            }
            for (j = i + 1; j < 6; j++) {
                if (originalattachments[i] == originalattachments[j]) {
                    textcolor[j] = "<dev string:x4ac>";
                    attachments[j] = "<dev string:x122>";
                    var_49dd67d4[j] = 0;
                }
            }
        }
        msg = "<dev string:x3e>";
        for (i = 0; i < 6; i++) {
            if ("<dev string:x122>" == originalattachments[i]) {
                continue;
            }
            msg += textcolor[i];
            msg += i;
            msg += "<dev string:x4af>";
            msg += originalattachments[i];
            msg += "<dev string:x4b2>";
            msg += var_28bb247d[i];
            msg += "<dev string:x4b2>";
        }
        iprintlnbold(msg);
        self takeweapon(currentweapon);
        currentweapon = getweapon(rootweapon.name, attachments[0], attachments[1], attachments[2], attachments[3], attachments[4], attachments[5]);
        acvi = getattachmentcosmeticvariantindexes(currentweapon, attachments[0], var_49dd67d4[0], attachments[1], var_49dd67d4[1], attachments[2], var_49dd67d4[2], attachments[3], var_49dd67d4[3], attachments[4], var_49dd67d4[4], attachments[5], var_49dd67d4[5]);
        wait 0.25;
        self giveweapon(currentweapon, undefined, acvi);
        self switchtoweapon(currentweapon);
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xde07134c, Offset: 0x1970
    // Size: 0x125
    function devgui_attachment_cycling_think() {
        for (;;) {
            state = getdvarstring("<dev string:x15f>");
            setdvar("<dev string:x15f>", "<dev string:x122>");
            if (issubstr(state, "<dev string:x4b5>")) {
                if ("<dev string:x4bc>" == state) {
                    for (i = 0; i < 6; i++) {
                        devgui_attachment_cycling_clear(i);
                    }
                } else {
                    index = int(getsubstr(state, 6, 7));
                    devgui_attachment_cycling_clear(index);
                }
                state = "<dev string:x4c6>";
            }
            if ("<dev string:x4c6>" == state) {
                array::thread_all(getplayers(), &devgui_attachment_cycling_update);
            }
            wait 0.5;
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc4dcb953, Offset: 0x1aa0
    // Size: 0x195
    function devgui_test_chart_think() {
        wait 0.05;
        old_val = getdvarint("<dev string:x4cd>");
        for (;;) {
            val = getdvarint("<dev string:x4cd>");
            if (old_val != val) {
                if (isdefined(level.test_chart_model)) {
                    level.test_chart_model delete();
                    level.test_chart_model = undefined;
                }
                if (val) {
                    player = getplayers()[0];
                    direction = player getplayerangles();
                    direction_vec = anglestoforward((0, direction[1], 0));
                    scale = 120;
                    direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
                    level.test_chart_model = spawn("<dev string:x4e2>", player geteye() + direction_vec);
                    level.test_chart_model setmodel("<dev string:x4ef>");
                    level.test_chart_model.angles = (0, direction[1], 0) + (0, 90, 0);
                }
            }
            old_val = val;
            wait 0.05;
        }
    }

    // Namespace devgui
    // Params 1, eflags: 0x0
    // Checksum 0x9318bd9a, Offset: 0x1c40
    // Size: 0x372
    function devgui_give_weapon(weapon_name) {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self notify(#"devgui_give_ammo");
        self endon(#"devgui_give_ammo");
        currentweapon = self getcurrentweapon();
        split = strtok(weapon_name, "<dev string:x49a>");
        switch (split.size) {
        case 1:
        default:
            weapon = getweapon(split[0]);
            break;
        case 2:
            weapon = getweapon(split[0], split[1]);
            break;
        case 3:
            weapon = getweapon(split[0], split[1], split[2]);
            break;
        case 4:
            weapon = getweapon(split[0], split[1], split[2], split[3]);
            break;
        case 5:
            weapon = getweapon(split[0], split[1], split[2], split[3], split[4]);
            break;
        }
        if (currentweapon != weapon) {
            if (weapon.isgrenadeweapon) {
                grenades = 0;
                pweapons = self getweaponslist();
                foreach (pweapon in pweapons) {
                    if (pweapon != weapon && pweapon.isgrenadeweapon) {
                        grenades++;
                    }
                }
                if (grenades > 1) {
                    foreach (pweapon in pweapons) {
                        if (pweapon != weapon && pweapon.isgrenadeweapon) {
                            grenades--;
                            self takeweapon(pweapon);
                            if (grenades < 2) {
                                break;
                            }
                        }
                    }
                }
            }
            if (getdvarint("<dev string:x6f>")) {
                adddebugcommand("<dev string:x500>" + weapon_name);
                wait 0.05;
            } else {
                self giveweapon(weapon);
                if (!weapon.isgrenadeweapon) {
                    self switchtoweapon(weapon);
                }
            }
            max = weapon.maxammo;
            if (max) {
                self setweaponammostock(weapon, max);
            }
        }
    }

    // Namespace devgui
    // Params 2, eflags: 0x0
    // Checksum 0x15d7b69d, Offset: 0x1fc0
    // Size: 0x11a
    function function_5ef38019(var_820a0a2e, var_5c078fc5) {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        currentweapon = self getcurrentweapon();
        var_8842e2c9 = getdvarint("<dev string:xb9>");
        acvi = getattachmentcosmeticvariantindexes(currentweapon, var_820a0a2e, var_8842e2c9, var_5c078fc5, var_8842e2c9);
        self takeweapon(currentweapon);
        wait 0.25;
        self giveweapon(currentweapon, undefined, acvi);
        self switchtoweapon(currentweapon);
    }

    // Namespace devgui
    // Params 3, eflags: 0x0
    // Checksum 0xf232745e, Offset: 0x20e8
    // Size: 0xea
    function devgui_handle_player_command(playercallback, pcb_param_1, pcb_param_2) {
        pid = getdvarint("<dev string:x2f>");
        if (pid > 0) {
            player = getplayers()[pid - 1];
            if (isdefined(player)) {
                if (isdefined(pcb_param_2)) {
                    player thread [[ playercallback ]](pcb_param_1, pcb_param_2);
                } else if (isdefined(pcb_param_1)) {
                    player thread [[ playercallback ]](pcb_param_1);
                } else {
                    player thread [[ playercallback ]]();
                }
            }
        } else {
            array::thread_all(getplayers(), playercallback, pcb_param_1, pcb_param_2);
        }
        setdvar("<dev string:x2f>", "<dev string:x506>");
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x243042cf, Offset: 0x21e0
    // Size: 0x105
    function init_debug_center_screen() {
        zero_idle_movement = "<dev string:x509>";
        for (;;) {
            if (getdvarint("<dev string:x3f>")) {
                if (!isdefined(level.center_screen_debug_hudelem_active) || level.center_screen_debug_hudelem_active == 0) {
                    thread debug_center_screen();
                    zero_idle_movement = getdvarstring("<dev string:x50b>");
                    if (isdefined(zero_idle_movement) && zero_idle_movement == "<dev string:x509>") {
                        setdvar("<dev string:x50b>", "<dev string:x51e>");
                        zero_idle_movement = "<dev string:x51e>";
                    }
                }
            } else {
                level notify(#"hash_8e42baed");
                if (zero_idle_movement == "<dev string:x51e>") {
                    setdvar("<dev string:x50b>", "<dev string:x509>");
                    zero_idle_movement = "<dev string:x509>";
                }
            }
            wait 0.05;
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x37bfbf48, Offset: 0x22f0
    // Size: 0x1f2
    function debug_center_screen() {
        level.center_screen_debug_hudelem_active = 1;
        wait 0.1;
        level.center_screen_debug_hudelem1 = newclienthudelem(level.players[0]);
        level.center_screen_debug_hudelem1.alignx = "<dev string:x520>";
        level.center_screen_debug_hudelem1.aligny = "<dev string:x527>";
        level.center_screen_debug_hudelem1.fontscale = 1;
        level.center_screen_debug_hudelem1.alpha = 0.5;
        level.center_screen_debug_hudelem1.x = 320 - 1;
        level.center_screen_debug_hudelem1.y = 240;
        level.center_screen_debug_hudelem1 setshader("<dev string:x52e>", 1000, 1);
        level.center_screen_debug_hudelem2 = newclienthudelem(level.players[0]);
        level.center_screen_debug_hudelem2.alignx = "<dev string:x520>";
        level.center_screen_debug_hudelem2.aligny = "<dev string:x527>";
        level.center_screen_debug_hudelem2.fontscale = 1;
        level.center_screen_debug_hudelem2.alpha = 0.5;
        level.center_screen_debug_hudelem2.x = 320 - 1;
        level.center_screen_debug_hudelem2.y = 240;
        level.center_screen_debug_hudelem2 setshader("<dev string:x52e>", 1, 480);
        level waittill(#"hash_8e42baed");
        level.center_screen_debug_hudelem1 destroy();
        level.center_screen_debug_hudelem2 destroy();
        level.center_screen_debug_hudelem_active = 0;
    }

#/
