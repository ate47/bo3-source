#using scripts/mp/_util;
#using scripts/mp/gametypes/_dev;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace dev_class;

/#

    // Namespace dev_class
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc80a5cad, Offset: 0xe8
    // Size: 0x630
    function dev_cac_init() {
        dev_cac_overlay = 0;
        dev_cac_camera_on = 0;
        level thread dev_cac_gdt_update_think();
        for (;;) {
            wait(0.5);
            reset = 1;
            if (getdvarstring("<unknown string>") != "<unknown string>") {
                continue;
            }
            host = util::gethostplayer();
            if (!isdefined(level.dev_cac_player)) {
                level.dev_cac_player = host;
            }
            switch (getdvarstring("<unknown string>")) {
            case 8:
                reset = 0;
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_body, "<unknown string>");
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_head, "<unknown string>");
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_character, "<unknown string>");
                break;
            case 8:
                dev_cac_cycle_player(1);
                break;
            case 8:
                dev_cac_cycle_player(0);
                break;
            case 8:
                level notify(#"dev_cac_overlay_think");
                if (!dev_cac_overlay) {
                    level thread dev_cac_overlay_think();
                }
                dev_cac_overlay = !dev_cac_overlay;
                break;
            case 8:
                dev_cac_set_model_range(&sort_greatest, "<unknown string>");
                break;
            case 8:
                dev_cac_set_model_range(&sort_least, "<unknown string>");
                break;
            case 8:
                dev_cac_set_model_range(&sort_greatest, "<unknown string>");
                break;
            case 8:
                dev_cac_set_model_range(&sort_least, "<unknown string>");
                break;
            case 8:
                dev_cac_set_model_range(&sort_greatest, "<unknown string>");
                break;
            case 8:
                dev_cac_set_model_range(&sort_least, "<unknown string>");
                break;
            case 8:
                dev_cac_camera_on = !dev_cac_camera_on;
                dev_cac_camera(dev_cac_camera_on);
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_render_options, "<unknown string>");
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_render_options, "<unknown string>");
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_render_options, "<unknown string>");
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_render_options, "<unknown string>");
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_render_options, "<unknown string>");
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_render_options, "<unknown string>");
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_render_options, "<unknown string>");
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_render_options, "<unknown string>");
                break;
            case 8:
                host thread dev_cac_dpad_think("<unknown string>", &dev_cac_cycle_render_options, "<unknown string>");
                break;
            case 8:
                host notify(#"dev_cac_dpad_think");
                break;
            }
            if (reset) {
                setdvar("<unknown string>", "<unknown string>");
            }
        }
    }

    // Namespace dev_class
    // Params 1, eflags: 0x1 linked
    // Checksum 0x91fc1279, Offset: 0x720
    // Size: 0xdc
    function dev_cac_camera(on) {
        if (on) {
            self setclientthirdperson(1);
            setdvar("<unknown string>", "<unknown string>");
            setdvar("<unknown string>", "<unknown string>");
            setdvar("<unknown string>", "<unknown string>");
            return;
        }
        self setclientthirdperson(0);
        setdvar("<unknown string>", getdvarstring("<unknown string>"));
    }

    // Namespace dev_class
    // Params 3, eflags: 0x1 linked
    // Checksum 0xd5250500, Offset: 0x808
    // Size: 0x1fc
    function dev_cac_dpad_think(part_name, cycle_function, tag) {
        self notify(#"dev_cac_dpad_think");
        self endon(#"dev_cac_dpad_think");
        self endon(#"disconnect");
        iprintln("<unknown string>" + part_name + "<unknown string>");
        iprintln("<unknown string>" + part_name + "<unknown string>");
        dpad_left = 0;
        dpad_right = 0;
        level.dev_cac_player thread highlight_player();
        for (;;) {
            self setactionslot(3, "<unknown string>");
            self setactionslot(4, "<unknown string>");
            if (!dpad_left && self buttonpressed("<unknown string>")) {
                [[ cycle_function ]](0, tag);
                dpad_left = 1;
            } else if (!self buttonpressed("<unknown string>")) {
                dpad_left = 0;
            }
            if (!dpad_right && self buttonpressed("<unknown string>")) {
                [[ cycle_function ]](1, tag);
                dpad_right = 1;
            } else if (!self buttonpressed("<unknown string>")) {
                dpad_right = 0;
            }
            wait(0.05);
        }
    }

    // Namespace dev_class
    // Params 2, eflags: 0x1 linked
    // Checksum 0x926eaf23, Offset: 0xa10
    // Size: 0xb2
    function next_in_list(value, list) {
        if (!isdefined(value)) {
            return list[0];
        }
        for (i = 0; i < list.size; i++) {
            if (value == list[i]) {
                if (isdefined(list[i + 1])) {
                    value = list[i + 1];
                } else {
                    value = list[0];
                }
                break;
            }
        }
        return value;
    }

    // Namespace dev_class
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa0202941, Offset: 0xad0
    // Size: 0xbc
    function prev_in_list(value, list) {
        if (!isdefined(value)) {
            return list[0];
        }
        for (i = 0; i < list.size; i++) {
            if (value == list[i]) {
                if (isdefined(list[i - 1])) {
                    value = list[i - 1];
                } else {
                    value = list[list.size - 1];
                }
                break;
            }
        }
        return value;
    }

    // Namespace dev_class
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1b90951a, Offset: 0xb98
    // Size: 0x1a
    function dev_cac_set_player_model() {
        self.tag_stowed_back = undefined;
        self.tag_stowed_hip = undefined;
    }

    // Namespace dev_class
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3c550183, Offset: 0xbc0
    // Size: 0xf4
    function dev_cac_cycle_body(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        keys = getarraykeys(level.cac_functions["<unknown string>"]);
        if (forward) {
            player.cac_body_type = next_in_list(player.cac_body_type, keys);
        } else {
            player.cac_body_type = prev_in_list(player.cac_body_type, keys);
        }
        player dev_cac_set_player_model();
    }

    // Namespace dev_class
    // Params 2, eflags: 0x1 linked
    // Checksum 0x28bbd674, Offset: 0xcc0
    // Size: 0x10c
    function dev_cac_cycle_head(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        keys = getarraykeys(level.cac_functions["<unknown string>"]);
        if (forward) {
            player.cac_head_type = next_in_list(player.cac_head_type, keys);
        } else {
            player.cac_head_type = prev_in_list(player.cac_head_type, keys);
        }
        player.cac_hat_type = "<unknown string>";
        player dev_cac_set_player_model();
    }

    // Namespace dev_class
    // Params 2, eflags: 0x1 linked
    // Checksum 0x23be81ab, Offset: 0xdd8
    // Size: 0x10c
    function dev_cac_cycle_character(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        keys = getarraykeys(level.cac_functions["<unknown string>"]);
        if (forward) {
            player.cac_body_type = next_in_list(player.cac_body_type, keys);
        } else {
            player.cac_body_type = prev_in_list(player.cac_body_type, keys);
        }
        player.cac_hat_type = "<unknown string>";
        player dev_cac_set_player_model();
    }

    // Namespace dev_class
    // Params 2, eflags: 0x1 linked
    // Checksum 0xc16cee3e, Offset: 0xef0
    // Size: 0x54
    function dev_cac_cycle_render_options(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        level.dev_cac_player nextplayerrenderoption(tag, forward);
    }

    // Namespace dev_class
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1a42d779, Offset: 0xf50
    // Size: 0x2e
    function dev_cac_player_valid() {
        return isdefined(level.dev_cac_player) && level.dev_cac_player.sessionstate == "<unknown string>";
    }

    // Namespace dev_class
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6cc2019a, Offset: 0xf88
    // Size: 0xe2
    function dev_cac_cycle_player(forward) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (forward) {
                level.dev_cac_player = next_in_list(level.dev_cac_player, players);
            } else {
                level.dev_cac_player = prev_in_list(level.dev_cac_player, players);
            }
            if (dev_cac_player_valid()) {
                level.dev_cac_player thread highlight_player();
                return;
            }
        }
        level.dev_cac_player = undefined;
    }

    // Namespace dev_class
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4f345c3c, Offset: 0x1078
    // Size: 0x44
    function highlight_player() {
        self sethighlighted(1);
        wait(1);
        self sethighlighted(0);
    }

    // Namespace dev_class
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcd91ad7d, Offset: 0x10c8
    // Size: 0x64
    function dev_cac_overlay_think() {
        hud = dev_cac_overlay_create();
        level thread dev_cac_overlay_update(hud);
        level waittill(#"dev_cac_overlay_think");
        dev_cac_overlay_destroy(hud);
    }

    // Namespace dev_class
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9368dfd2, Offset: 0x1138
    // Size: 0x10
    function dev_cac_overlay_update(hud) {
        
    }

    // Namespace dev_class
    // Params 1, eflags: 0x1 linked
    // Checksum 0x312aec, Offset: 0x1150
    // Size: 0xa4
    function dev_cac_overlay_destroy(hud) {
                for (i = 0; i < hud.menu.size; i++) {
            hud.menu[i] destroy();
        }
        hud destroy();
        setdvar("<unknown string>", "<unknown string>");
    }

    // Namespace dev_class
    // Params 0, eflags: 0x1 linked
    // Checksum 0xaf3b9c1d, Offset: 0x1200
    // Size: 0xd94
    function dev_cac_overlay_create() {
        x = -80;
        y = -116;
        menu_name = "<unknown string>";
        hud = dev::new_hud(menu_name, undefined, x, y, 1);
        hud setshader("<unknown string>", -71, 285);
        hud.alignx = "<unknown string>";
        hud.aligny = "<unknown string>";
        hud.sort = 10;
        hud.alpha = 0.6;
        hud.color = (0, 0, 0.5);
        x_offset = 100;
        hud.menu[0] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 10, 1.3);
        hud.menu[1] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 25, 1);
        hud.menu[2] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 35, 1);
        hud.menu[3] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 45, 1);
        hud.menu[4] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 55, 1);
        hud.menu[5] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 70, 1);
        hud.menu[6] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 80, 1);
        hud.menu[7] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 90, 1);
        hud.menu[8] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 100, 1);
        hud.menu[9] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 110, 1);
        hud.menu[10] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 120, 1);
        hud.menu[11] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -121, 1);
        hud.menu[12] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -111, 1);
        hud.menu[13] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -101, 1);
        hud.menu[14] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -86, 1);
        hud.menu[15] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -76, 1);
        hud.menu[16] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -66, 1);
        hud.menu[17] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -51, 1);
        hud.menu[18] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -41, 1);
        hud.menu[19] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -31, 1);
        hud.menu[20] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -21, 1);
        hud.menu[21] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -11, 1);
        hud.menu[22] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + -1, 1);
        hud.menu[23] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 265, 1);
        hud.menu[24] = dev::new_hud(menu_name, "<unknown string>", x + 5, y + 275, 1);
        x_offset = 65;
        hud.menu[25] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + 35, 1);
        hud.menu[26] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + 45, 1);
        hud.menu[27] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + 55, 1);
        x_offset = 100;
        hud.menu[28] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + 80, 1);
        hud.menu[29] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + 90, 1);
        hud.menu[30] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + 100, 1);
        hud.menu[31] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + 110, 1);
        hud.menu[32] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + 120, 1);
        hud.menu[33] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + -111, 1);
        hud.menu[34] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + -101, 1);
        hud.menu[35] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + -76, 1);
        hud.menu[36] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + -66, 1);
        x_offset = 65;
        hud.menu[37] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + -41, 1);
        hud.menu[38] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + -31, 1);
        hud.menu[39] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + -21, 1);
        hud.menu[40] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + -11, 1);
        hud.menu[41] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + -1, 1);
        hud.menu[42] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + 265, 1);
        hud.menu[43] = dev::new_hud(menu_name, "<unknown string>", x + x_offset, y + 275, 1);
        return hud;
    }

    // Namespace dev_class
    // Params 1, eflags: 0x0
    // Checksum 0x5caa611a, Offset: 0x1fa0
    // Size: 0xa8
    function color(value) {
        r = 1;
        g = 1;
        b = 0;
        color = (0, 0, 0);
        if (value > 0) {
            r -= value;
        } else {
            g += value;
        }
        c = (r, g, b);
        return c;
    }

    // Namespace dev_class
    // Params 0, eflags: 0x1 linked
    // Checksum 0x849c748c, Offset: 0x2050
    // Size: 0x1a6
    function dev_cac_gdt_update_think() {
        for (;;) {
            asset, keyvalue = level waittill(#"gdt_update");
            keyvalue = strtok(keyvalue, "<unknown string>");
            key = keyvalue[0];
            switch (key) {
            case 8:
                key = "<unknown string>";
                break;
            case 8:
                key = "<unknown string>";
                break;
            case 8:
                key = "<unknown string>";
                break;
            case 8:
                key = "<unknown string>";
                break;
            case 8:
                key = "<unknown string>";
                break;
            default:
                key = undefined;
                break;
            }
            if (!isdefined(key)) {
                continue;
            }
            value = float(keyvalue[1]);
            level.cac_attributes[key][asset] = value;
            players = getplayers();
            for (i = 0; i < players.size; i++) {
            }
        }
    }

    // Namespace dev_class
    // Params 3, eflags: 0x1 linked
    // Checksum 0x7d635622, Offset: 0x2200
    // Size: 0xd0
    function sort_greatest(func, attribute, greatest) {
        keys = getarraykeys(level.cac_functions[func]);
        greatest = keys[0];
        for (i = 0; i < keys.size; i++) {
            if (level.cac_attributes[attribute][keys[i]] > level.cac_attributes[attribute][greatest]) {
                greatest = keys[i];
            }
        }
        return greatest;
    }

    // Namespace dev_class
    // Params 3, eflags: 0x1 linked
    // Checksum 0xdca35cc6, Offset: 0x22d8
    // Size: 0xd0
    function sort_least(func, attribute, least) {
        keys = getarraykeys(level.cac_functions[func]);
        least = keys[0];
        for (i = 0; i < keys.size; i++) {
            if (level.cac_attributes[attribute][keys[i]] < level.cac_attributes[attribute][least]) {
                least = keys[i];
            }
        }
        return least;
    }

    // Namespace dev_class
    // Params 2, eflags: 0x1 linked
    // Checksum 0xcfd29b40, Offset: 0x23b0
    // Size: 0xc4
    function dev_cac_set_model_range(sort_function, attribute) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        player.cac_body_type = [[ sort_function ]]("<unknown string>", attribute);
        player.cac_head_type = [[ sort_function ]]("<unknown string>", attribute);
        player.cac_hat_type = [[ sort_function ]]("<unknown string>", attribute);
        player dev_cac_set_player_model();
    }

#/
