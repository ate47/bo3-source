#using scripts/codescripts/struct;
#using scripts/mp/_vehicle;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/callbacks_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/load_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;

#namespace devgui;

/#

    // Namespace devgui
    // Params 0, eflags: 0x2
    // Checksum 0xa37866f7, Offset: 0x278
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xf04a5c64, Offset: 0x2b8
    // Size: 0x4b4
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
        level thread devgui_vehicle_spawn_think();
        thread init_debug_center_screen();
        level thread dev::body_customization_devgui(1);
        callback::on_connect(&hero_art_on_player_connect);
        callback::on_connect(&on_player_connect);
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x9cd0602e, Offset: 0x778
    // Size: 0x2c
    function on_player_connect() {
        /#
            self.devguilockspawn = 0;
            self thread devgui_player_spawn();
        #/
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb1985489, Offset: 0x7b0
    // Size: 0x172
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
    // Checksum 0x364fb713, Offset: 0x930
    // Size: 0x188
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
    // Checksum 0xfa3065bb, Offset: 0xac0
    // Size: 0x110
    function devgui_vehicle_spawn_think() {
        wait 0.05;
        for (;;) {
            val = getdvarint("<dev string:x2f8>");
            if (val != 0) {
                if (val == 1) {
                    add_vehicle_at_eye_trace("<dev string:x309>");
                } else if (val == 2) {
                    add_vehicle_at_eye_trace("<dev string:x312>");
                } else if (val == 3) {
                    add_vehicle_at_eye_trace("<dev string:x320>");
                } else if (val == 4) {
                    add_vehicle_at_eye_trace("<dev string:x329>");
                }
                setdvar("<dev string:x2f8>", "<dev string:x332>");
            }
            wait 0.05;
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x92344cfd, Offset: 0xbd8
    // Size: 0x8fc
    function devgui_player_weapons() {
        if (isdefined(game["<dev string:x334>"]) && game["<dev string:x334>"]) {
            return;
        }
        level flag::wait_till("<dev string:x349>");
        a_weapons = enumerateweapons("<dev string:x35d>");
        a_weapons_mp = [];
        a_grenades_mp = [];
        a_misc_mp = [];
        for (i = 0; i < a_weapons.size; i++) {
            if ((weapons::is_primary_weapon(a_weapons[i]) || weapons::is_side_arm(a_weapons[i])) && !killstreaks::is_killstreak_weapon(a_weapons[i])) {
                arrayinsert(a_weapons_mp, a_weapons[i], 0);
                continue;
            }
            if (weapons::is_grenade(a_weapons[i])) {
                arrayinsert(a_grenades_mp, a_weapons[i], 0);
                continue;
            }
            arrayinsert(a_misc_mp, a_weapons[i], 0);
        }
        player_devgui_base_mp = "<dev string:x364>";
        menu_index = 1;
        level thread devgui_add_player_weapons(player_devgui_base_mp, "<dev string:x380>", 0, a_weapons_mp, "<dev string:x384>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons(player_devgui_base_mp, "<dev string:x380>", 0, a_grenades_mp, "<dev string:x389>", menu_index);
        menu_index++;
        level thread devgui_add_player_weapons(player_devgui_base_mp, "<dev string:x380>", 0, a_misc_mp, "<dev string:x392>", menu_index);
        menu_index++;
        game["<dev string:x334>"] = 1;
        wait 0.05;
        adddebugcommand(player_devgui_base_mp + "<dev string:x397>" + "<dev string:x3ab>" + "<dev string:x6f>" + "<dev string:x3b6>");
        menu_index++;
        adddebugcommand(player_devgui_base_mp + "<dev string:x3be>" + "<dev string:x3ab>" + "<dev string:x3f>" + "<dev string:x3b6>");
        menu_index++;
        adddebugcommand(player_devgui_base_mp + "<dev string:x3d9>" + "<dev string:x3ab>" + "<dev string:x97>" + "<dev string:x3b6>");
        menu_index++;
        var_8edecd6e = player_devgui_base_mp + "<dev string:x3fa>" + "<dev string:x40c>";
        menu_index++;
        var_14928e24 = 1;
        var_e55c4df9 = 1;
        for (i = 0; i <= 3; i++) {
            adddebugcommand(var_8edecd6e + "<dev string:x40e>" + "<dev string:x40c>" + i + "<dev string:x2eb>" + "<dev string:xb9>" + "<dev string:x2f3>" + i + "<dev string:x41c>");
            var_e55c4df9++;
        }
        var_14928e24++;
        attachmentnames = getattachmentnames();
        var_e55c4df9 = 1;
        for (i = 0; i < attachmentnames.size; i++) {
            if (issubstr(attachmentnames[i], "<dev string:x420>")) {
                continue;
            }
            function_27141585();
            adddebugcommand(var_8edecd6e + "<dev string:x425>" + "<dev string:x40c>" + attachmentnames[i] + "<dev string:x2eb>" + "<dev string:xea>" + "<dev string:x2f3>" + attachmentnames[i] + "<dev string:x41c>");
            var_e55c4df9++;
        }
        var_14928e24++;
        var_e55c4df9 = 1;
        for (i = 0; i < attachmentnames.size; i++) {
            if (issubstr(attachmentnames[i], "<dev string:x420>")) {
                continue;
            }
            function_27141585();
            adddebugcommand(var_8edecd6e + "<dev string:x432>" + "<dev string:x40c>" + attachmentnames[i] + "<dev string:x2eb>" + "<dev string:x127>" + "<dev string:x2f3>" + attachmentnames[i] + "<dev string:x41c>");
            var_e55c4df9++;
        }
        var_14928e24++;
        wait 0.05;
        attachment_cycling_devgui_base_mp = player_devgui_base_mp + "<dev string:x43f>" + "<dev string:x40c>";
        adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x452>" + "<dev string:x15f>" + "<dev string:x463>");
        adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x471>" + "<dev string:x15f>" + "<dev string:x480>");
        for (i = 0; i < 6; i++) {
            attachment_cycling_sub_menu_index = 1;
            adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x48b>" + i + 1 + "<dev string:x497>" + "<dev string:x15f>" + "<dev string:x4a7>" + i + "<dev string:x41c>");
            for (attachmentname = 0; attachmentname < attachmentnames.size; attachmentname++) {
                if (issubstr(attachmentnames[attachmentname], "<dev string:x420>")) {
                    continue;
                }
                function_27141585();
                adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x48b>" + i + 1 + "<dev string:x40c>" + attachmentnames[attachmentname] + "<dev string:x2eb>" + "<dev string:x15f>" + "<dev string:x4af>" + level.attachment_cycling_dvars[i] + "<dev string:x2f3>" + attachmentnames[attachmentname] + "<dev string:x4bd>" + level.var_1bb167c4[i] + "<dev string:x2f3>" + 0 + "<dev string:x41c>");
                attachment_cycling_sub_menu_index++;
                adddebugcommand(attachment_cycling_devgui_base_mp + "<dev string:x48b>" + i + 1 + "<dev string:x40c>" + attachmentnames[attachmentname] + "<dev string:x4c4>" + "<dev string:x15f>" + "<dev string:x4af>" + level.attachment_cycling_dvars[i] + "<dev string:x2f3>" + attachmentnames[attachmentname] + "<dev string:x4bd>" + level.var_1bb167c4[i] + "<dev string:x2f3>" + 1 + "<dev string:x41c>");
                attachment_cycling_sub_menu_index++;
            }
        }
        level thread function_496dcd72();
        level thread devgui_attachment_cycling_think();
    }

    // Namespace devgui
    // Params 6, eflags: 0x0
    // Checksum 0x315a2f80, Offset: 0x14e0
    // Size: 0x21e
    function devgui_add_player_weapons(root, pname, index, a_weapons, weapon_type, mindex) {
        if (isdedicated()) {
            return;
        }
        devgui_root = root + weapon_type + "<dev string:x40c>";
        if (isdefined(a_weapons)) {
            for (i = 0; i < a_weapons.size; i++) {
                attachments = a_weapons[i].supportedattachments;
                name = a_weapons[i].name;
                if (attachments.size) {
                    devgui_add_player_weap_command(devgui_root + name + "<dev string:x40c>", index, name, i + 1);
                    foreach (att in attachments) {
                        if (att != "<dev string:x122>") {
                            devgui_add_player_weap_command(devgui_root + name + "<dev string:x40c>", index, name + "<dev string:x4d6>" + att, i + 1);
                        }
                    }
                } else {
                    devgui_add_player_weap_command(devgui_root, index, name, i + 1);
                }
                wait 0.05;
            }
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x81a2d5b5, Offset: 0x1708
    // Size: 0x5e
    function function_27141585() {
        if (!isdefined(level.var_f842514b)) {
            level.var_f842514b = 0;
        }
        level.var_f842514b++;
        if (level.var_f842514b % 10 == 0) {
            wait randomintrange(2, 5) * 0.05;
        }
    }

    // Namespace devgui
    // Params 4, eflags: 0x0
    // Checksum 0x1c86ec2f, Offset: 0x1770
    // Size: 0x84
    function devgui_add_player_weap_command(root, pid, weap_name, cmdindex) {
        function_27141585();
        adddebugcommand(root + weap_name + "<dev string:x2eb>" + "<dev string:x2f>" + "<dev string:x2f3>" + weap_name + "<dev string:x41c>");
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa13a7fd4, Offset: 0x1800
    // Size: 0x90
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
    // Checksum 0x83890241, Offset: 0x1898
    // Size: 0x24
    function hero_art_on_player_connect() {
        self._debugheromodels = spawnstruct();
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xf144b144, Offset: 0x18c8
    // Size: 0x3e0
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
                print3d(player gettagorigin("<dev string:x4d8>"), weapon.name, colors[color_index], 1, 0.15, print_duration);
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
                print3d(ai gettagorigin("<dev string:x4d8>"), weapon.name, colors[color_index], 1, 0.15, print_duration);
                color_index++;
                if (color_index >= colors.size) {
                    color_index = 0;
                }
            }
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x1c06142b, Offset: 0x1cb0
    // Size: 0x138
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
    // Checksum 0xe29d96c, Offset: 0x1df0
    // Size: 0x5c
    function devgui_attachment_cycling_clear(index) {
        setdvar(level.attachment_cycling_dvars[index], "<dev string:x122>");
        setdvar(level.var_1bb167c4[index], 0);
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xabd9f930, Offset: 0x1e58
    // Size: 0x514
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
            textcolor[i] = "<dev string:x4e2>";
            attachments[i] = "<dev string:x122>";
            var_49dd67d4[i] = 0;
            name = originalattachments[i];
            if ("<dev string:x122>" == name) {
                continue;
            }
            textcolor[i] = "<dev string:x4e5>";
            for (supportedindex = 0; supportedindex < supportedattachments.size; supportedindex++) {
                if (name == supportedattachments[supportedindex]) {
                    textcolor[i] = "<dev string:x4e2>";
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
                    textcolor[j] = "<dev string:x4e8>";
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
            msg += "<dev string:x4eb>";
            msg += originalattachments[i];
            msg += "<dev string:x4ee>";
            msg += var_28bb247d[i];
            msg += "<dev string:x4ee>";
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
    // Checksum 0x34b9ea45, Offset: 0x2378
    // Size: 0x178
    function devgui_attachment_cycling_think() {
        for (;;) {
            state = getdvarstring("<dev string:x15f>");
            setdvar("<dev string:x15f>", "<dev string:x122>");
            if (issubstr(state, "<dev string:x4f1>")) {
                if ("<dev string:x4f8>" == state) {
                    for (i = 0; i < 6; i++) {
                        devgui_attachment_cycling_clear(i);
                    }
                } else {
                    index = int(getsubstr(state, 6, 7));
                    devgui_attachment_cycling_clear(index);
                }
                state = "<dev string:x502>";
            }
            if ("<dev string:x502>" == state) {
                array::thread_all(getplayers(), &devgui_attachment_cycling_update);
            }
            wait 0.5;
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x6fb99d43, Offset: 0x24f8
    // Size: 0x20c
    function devgui_test_chart_think() {
        wait 0.05;
        old_val = getdvarint("<dev string:x509>");
        for (;;) {
            val = getdvarint("<dev string:x509>");
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
                    level.test_chart_model = spawn("<dev string:x51e>", player geteye() + direction_vec);
                    level.test_chart_model setmodel("<dev string:x52b>");
                    level.test_chart_model.angles = (0, direction[1], 0) + (0, 90, 0);
                }
            }
            old_val = val;
            wait 0.05;
        }
    }

    // Namespace devgui
    // Params 1, eflags: 0x0
    // Checksum 0xff585057, Offset: 0x2710
    // Size: 0x4ac
    function devgui_give_weapon(weapon_name) {
        assert(isdefined(self));
        assert(isplayer(self));
        assert(isalive(self));
        self notify(#"devgui_give_ammo");
        self endon(#"devgui_give_ammo");
        currentweapon = self getcurrentweapon();
        split = strtok(weapon_name, "<dev string:x4d6>");
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
                adddebugcommand("<dev string:x53c>" + weapon_name);
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
    // Checksum 0x98638c6, Offset: 0x2bc8
    // Size: 0x15c
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
    // Checksum 0x8010d4e, Offset: 0x2d30
    // Size: 0x13c
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
        setdvar("<dev string:x2f>", "<dev string:x542>");
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xa879970a, Offset: 0x2e78
    // Size: 0x12c
    function init_debug_center_screen() {
        zero_idle_movement = "<dev string:x332>";
        for (;;) {
            if (getdvarint("<dev string:x3f>")) {
                if (!isdefined(level.center_screen_debug_hudelem_active) || level.center_screen_debug_hudelem_active == 0) {
                    thread debug_center_screen();
                    zero_idle_movement = getdvarstring("<dev string:x545>");
                    if (isdefined(zero_idle_movement) && zero_idle_movement == "<dev string:x332>") {
                        setdvar("<dev string:x545>", "<dev string:x558>");
                        zero_idle_movement = "<dev string:x558>";
                    }
                }
            } else {
                level notify(#"hash_8e42baed");
                if (zero_idle_movement == "<dev string:x558>") {
                    setdvar("<dev string:x545>", "<dev string:x332>");
                    zero_idle_movement = "<dev string:x332>";
                }
            }
            wait 0.05;
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0x107adb7b, Offset: 0x2fb0
    // Size: 0x228
    function debug_center_screen() {
        level.center_screen_debug_hudelem_active = 1;
        wait 0.1;
        level.center_screen_debug_hudelem1 = newclienthudelem(level.players[0]);
        level.center_screen_debug_hudelem1.alignx = "<dev string:x55a>";
        level.center_screen_debug_hudelem1.aligny = "<dev string:x561>";
        level.center_screen_debug_hudelem1.fontscale = 1;
        level.center_screen_debug_hudelem1.alpha = 0.5;
        level.center_screen_debug_hudelem1.x = 320 - 1;
        level.center_screen_debug_hudelem1.y = 240;
        level.center_screen_debug_hudelem1 setshader("<dev string:x568>", 1000, 1);
        level.center_screen_debug_hudelem2 = newclienthudelem(level.players[0]);
        level.center_screen_debug_hudelem2.alignx = "<dev string:x55a>";
        level.center_screen_debug_hudelem2.aligny = "<dev string:x561>";
        level.center_screen_debug_hudelem2.fontscale = 1;
        level.center_screen_debug_hudelem2.alpha = 0.5;
        level.center_screen_debug_hudelem2.x = 320 - 1;
        level.center_screen_debug_hudelem2.y = 240;
        level.center_screen_debug_hudelem2 setshader("<dev string:x568>", 1, 480);
        level waittill(#"hash_8e42baed");
        level.center_screen_debug_hudelem1 destroy();
        level.center_screen_debug_hudelem2 destroy();
        level.center_screen_debug_hudelem_active = 0;
    }

    // Namespace devgui
    // Params 1, eflags: 0x0
    // Checksum 0xdb996ddb, Offset: 0x31e0
    // Size: 0x142
    function add_vehicle_at_eye_trace(vehiclename) {
        host = util::gethostplayer();
        trace = host bot::eye_trace();
        veh_spawner = getent(vehiclename + "<dev string:x56e>", "<dev string:x577>");
        vehicle = veh_spawner spawnfromspawner(vehiclename, 1, 1, 1);
        if (isdefined(vehicle.archetype)) {
            vehicle asmrequestsubstate("<dev string:x582>");
        }
        wait 0.05;
        vehicle.origin = trace["<dev string:x596>"];
        vehicle thread vehicle::vehicleteamthread();
        vehicle thread watch_player_death();
        return vehicle;
    }

    // Namespace devgui
    // Params 0, eflags: 0x0
    // Checksum 0xf3e9df2b, Offset: 0x3330
    // Size: 0x98
    function watch_player_death() {
        self endon(#"death");
        vehicle = self;
        while (true) {
            driver = self getseatoccupant(0);
            if (isdefined(driver) && !isalive(driver)) {
                driver unlink();
            }
            wait 0.05;
        }
    }

#/
