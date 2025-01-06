#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_dev;
#using scripts/shared/util_shared;

#namespace dev_class;

/#

    // Namespace dev_class
    // Params 0, eflags: 0x0
    // Checksum 0xb21de3f2, Offset: 0xe8
    // Size: 0x545
    function dev_cac_init() {
        dev_cac_overlay = 0;
        dev_cac_camera_on = 0;
        level thread dev_cac_gdt_update_think();
        for (;;) {
            wait 0.5;
            reset = 1;
            if (getdvarstring("<dev string:x28>") != "<dev string:x3a>") {
                continue;
            }
            host = util::gethostplayer();
            if (!isdefined(level.dev_cac_player)) {
                level.dev_cac_player = host;
            }
            switch (getdvarstring("<dev string:x3b>")) {
            case "<dev string:x3a>":
                reset = 0;
                break;
            case "<dev string:x4a>":
                host thread dev_cac_dpad_think("<dev string:x54>", &dev_cac_cycle_body, "<dev string:x3a>");
                break;
            case "<dev string:x59>":
                host thread dev_cac_dpad_think("<dev string:x63>", &dev_cac_cycle_head, "<dev string:x3a>");
                break;
            case "<dev string:x68>":
                host thread dev_cac_dpad_think("<dev string:x77>", &dev_cac_cycle_character, "<dev string:x3a>");
                break;
            case "<dev string:x81>":
                dev_cac_cycle_player(1);
                break;
            case "<dev string:x8d>":
                dev_cac_cycle_player(0);
                break;
            case "<dev string:x99>":
                level notify(#"dev_cac_overlay_think");
                if (!dev_cac_overlay) {
                    level thread dev_cac_overlay_think();
                }
                dev_cac_overlay = !dev_cac_overlay;
                break;
            case "<dev string:xa5>":
                dev_cac_set_model_range(&sort_greatest, "<dev string:xb7>");
                break;
            case "<dev string:xc4>":
                dev_cac_set_model_range(&sort_least, "<dev string:xb7>");
                break;
            case "<dev string:xd7>":
                dev_cac_set_model_range(&sort_greatest, "<dev string:xec>");
                break;
            case "<dev string:xfc>":
                dev_cac_set_model_range(&sort_least, "<dev string:xec>");
                break;
            case "<dev string:x112>":
                dev_cac_set_model_range(&sort_greatest, "<dev string:x120>");
                break;
            case "<dev string:x129>":
                dev_cac_set_model_range(&sort_least, "<dev string:x120>");
                break;
            case "<dev string:x138>":
                dev_cac_camera_on = !dev_cac_camera_on;
                dev_cac_camera(dev_cac_camera_on);
                break;
            case "<dev string:x13f>":
                host thread dev_cac_dpad_think("<dev string:x149>", &dev_cac_cycle_render_options, "<dev string:x149>");
                break;
            case "<dev string:x14e>":
                host thread dev_cac_dpad_think("<dev string:x15d>", &dev_cac_cycle_render_options, "<dev string:x15d>");
                break;
            case "<dev string:x167>":
                host thread dev_cac_dpad_think("<dev string:x171>", &dev_cac_cycle_render_options, "<dev string:x171>");
                break;
            case "<dev string:x176>":
                host thread dev_cac_dpad_think("<dev string:x183>", &dev_cac_cycle_render_options, "<dev string:x183>");
                break;
            case "<dev string:x18b>":
                host thread dev_cac_dpad_think("<dev string:x19e>", &dev_cac_cycle_render_options, "<dev string:x1ac>");
                break;
            case "<dev string:x1ba>":
                host thread dev_cac_dpad_think("<dev string:x1c6>", &dev_cac_cycle_render_options, "<dev string:x1c6>");
                break;
            case "<dev string:x1cd>":
                host thread dev_cac_dpad_think("<dev string:x1d6>", &dev_cac_cycle_render_options, "<dev string:x1d6>");
                break;
            case "<dev string:x1da>":
                host thread dev_cac_dpad_think("<dev string:x1f1>", &dev_cac_cycle_render_options, "<dev string:x203>");
                break;
            case "<dev string:x215>":
                host thread dev_cac_dpad_think("<dev string:x22a>", &dev_cac_cycle_render_options, "<dev string:x23a>");
                break;
            case "<dev string:x24a>":
                host notify(#"dev_cac_dpad_think");
                break;
            }
            if (reset) {
                setdvar("<dev string:x3b>", "<dev string:x3a>");
            }
        }
    }

    // Namespace dev_class
    // Params 1, eflags: 0x0
    // Checksum 0xe27b8a5b, Offset: 0x638
    // Size: 0xca
    function dev_cac_camera(on) {
        if (on) {
            self setclientthirdperson(1);
            setdvar("<dev string:x255>", "<dev string:x269>");
            setdvar("<dev string:x26d>", "<dev string:x281>");
            setdvar("<dev string:x285>", "<dev string:x28c>");
            return;
        }
        self setclientthirdperson(0);
        setdvar("<dev string:x285>", getdvarstring("<dev string:x28f>"));
    }

    // Namespace dev_class
    // Params 3, eflags: 0x0
    // Checksum 0x6b85da44, Offset: 0x710
    // Size: 0x175
    function dev_cac_dpad_think(part_name, cycle_function, tag) {
        self notify(#"dev_cac_dpad_think");
        self endon(#"dev_cac_dpad_think");
        self endon(#"disconnect");
        iprintln("<dev string:x29e>" + part_name + "<dev string:x2a8>");
        iprintln("<dev string:x2bd>" + part_name + "<dev string:x2c3>");
        dpad_left = 0;
        dpad_right = 0;
        level.dev_cac_player thread highlight_player();
        for (;;) {
            self setactionslot(3, "<dev string:x3a>");
            self setactionslot(4, "<dev string:x3a>");
            if (!dpad_left && self buttonpressed("<dev string:x2d9>")) {
                [[ cycle_function ]](0, tag);
                dpad_left = 1;
            } else if (!self buttonpressed("<dev string:x2d9>")) {
                dpad_left = 0;
            }
            if (!dpad_right && self buttonpressed("<dev string:x2e3>")) {
                [[ cycle_function ]](1, tag);
                dpad_right = 1;
            } else if (!self buttonpressed("<dev string:x2e3>")) {
                dpad_right = 0;
            }
            wait 0.05;
        }
    }

    // Namespace dev_class
    // Params 2, eflags: 0x0
    // Checksum 0xfa651043, Offset: 0x890
    // Size: 0x6e
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
    // Params 2, eflags: 0x0
    // Checksum 0x8cca851a, Offset: 0x908
    // Size: 0x74
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
    // Params 0, eflags: 0x0
    // Checksum 0xb0744176, Offset: 0x988
    // Size: 0x15
    function dev_cac_set_player_model() {
        self.tag_stowed_back = undefined;
        self.tag_stowed_hip = undefined;
    }

    // Namespace dev_class
    // Params 2, eflags: 0x0
    // Checksum 0x72f4934a, Offset: 0x9a8
    // Size: 0xc2
    function dev_cac_cycle_body(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        keys = getarraykeys(level.cac_functions["<dev string:x2ee>"]);
        if (forward) {
            player.cac_body_type = next_in_list(player.cac_body_type, keys);
        } else {
            player.cac_body_type = prev_in_list(player.cac_body_type, keys);
        }
        player dev_cac_set_player_model();
    }

    // Namespace dev_class
    // Params 2, eflags: 0x0
    // Checksum 0x468e2002, Offset: 0xa78
    // Size: 0xd2
    function dev_cac_cycle_head(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        keys = getarraykeys(level.cac_functions["<dev string:x2fd>"]);
        if (forward) {
            player.cac_head_type = next_in_list(player.cac_head_type, keys);
        } else {
            player.cac_head_type = prev_in_list(player.cac_head_type, keys);
        }
        player.cac_hat_type = "<dev string:x30c>";
        player dev_cac_set_player_model();
    }

    // Namespace dev_class
    // Params 2, eflags: 0x0
    // Checksum 0x73fa130, Offset: 0xb58
    // Size: 0xd2
    function dev_cac_cycle_character(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        keys = getarraykeys(level.cac_functions["<dev string:x2ee>"]);
        if (forward) {
            player.cac_body_type = next_in_list(player.cac_body_type, keys);
        } else {
            player.cac_body_type = prev_in_list(player.cac_body_type, keys);
        }
        player.cac_hat_type = "<dev string:x30c>";
        player dev_cac_set_player_model();
    }

    // Namespace dev_class
    // Params 2, eflags: 0x0
    // Checksum 0xf6ea5418, Offset: 0xc38
    // Size: 0x42
    function dev_cac_cycle_render_options(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        level.dev_cac_player nextplayerrenderoption(tag, forward);
    }

    // Namespace dev_class
    // Params 0, eflags: 0x0
    // Checksum 0xe91e4f5b, Offset: 0xc88
    // Size: 0x2b
    function dev_cac_player_valid() {
        return isdefined(level.dev_cac_player) && level.dev_cac_player.sessionstate == "<dev string:x311>";
    }

    // Namespace dev_class
    // Params 1, eflags: 0x0
    // Checksum 0x873f606e, Offset: 0xcc0
    // Size: 0xb9
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
    // Params 0, eflags: 0x0
    // Checksum 0xadac84d8, Offset: 0xd88
    // Size: 0x32
    function highlight_player() {
        self sethighlighted(1);
        wait 1;
        self sethighlighted(0);
    }

    // Namespace dev_class
    // Params 0, eflags: 0x0
    // Checksum 0x5d160a8b, Offset: 0xdc8
    // Size: 0x4a
    function dev_cac_overlay_think() {
        hud = dev_cac_overlay_create();
        level thread dev_cac_overlay_update(hud);
        level waittill(#"dev_cac_overlay_think");
        dev_cac_overlay_destroy(hud);
    }

    // Namespace dev_class
    // Params 1, eflags: 0x0
    // Checksum 0x75458d16, Offset: 0xe20
    // Size: 0xd
    function dev_cac_overlay_update(hud) {
        
    }

    // Namespace dev_class
    // Params 1, eflags: 0x0
    // Checksum 0x26da394b, Offset: 0xe38
    // Size: 0x82
    function dev_cac_overlay_destroy(hud) {
        for (i = 0; i < hud.menu.size; i++) {
            hud.menu[i] destroy();
        }
        hud destroy();
        setdvar("<dev string:x319>", "<dev string:x32c>");
    }

    // Namespace dev_class
    // Params 0, eflags: 0x0
    // Checksum 0x322b408b, Offset: 0xec8
    // Size: 0x92a
    function dev_cac_overlay_create() {
        x = -80;
        y = -116;
        menu_name = "<dev string:x32e>";
        hud = dev::new_hud(menu_name, undefined, x, y, 1);
        hud setshader("<dev string:x33c>", -71, 285);
        hud.alignx = "<dev string:x342>";
        hud.aligny = "<dev string:x347>";
        hud.sort = 10;
        hud.alpha = 0.6;
        hud.color = (0, 0, 0.5);
        x_offset = 100;
        hud.menu[0] = dev::new_hud(menu_name, "<dev string:x34b>", x + 5, y + 10, 1.3);
        hud.menu[1] = dev::new_hud(menu_name, "<dev string:x350>", x + 5, y + 25, 1);
        hud.menu[2] = dev::new_hud(menu_name, "<dev string:x357>", x + 5, y + 35, 1);
        hud.menu[3] = dev::new_hud(menu_name, "<dev string:x35f>", x + 5, y + 45, 1);
        hud.menu[4] = dev::new_hud(menu_name, "<dev string:x367>", x + 5, y + 55, 1);
        hud.menu[5] = dev::new_hud(menu_name, "<dev string:x374>", x + 5, y + 70, 1);
        hud.menu[6] = dev::new_hud(menu_name, "<dev string:x357>", x + 5, y + 80, 1);
        hud.menu[7] = dev::new_hud(menu_name, "<dev string:x367>", x + 5, y + 90, 1);
        hud.menu[8] = dev::new_hud(menu_name, "<dev string:x37d>", x + 5, y + 100, 1);
        hud.menu[9] = dev::new_hud(menu_name, "<dev string:x38c>", x + 5, y + 110, 1);
        hud.menu[10] = dev::new_hud(menu_name, "<dev string:x39f>", x + 5, y + 120, 1);
        hud.menu[11] = dev::new_hud(menu_name, "<dev string:x3b2>", x + 5, y + -121, 1);
        hud.menu[12] = dev::new_hud(menu_name, "<dev string:x357>", x + 5, y + -111, 1);
        hud.menu[13] = dev::new_hud(menu_name, "<dev string:x367>", x + 5, y + -101, 1);
        hud.menu[14] = dev::new_hud(menu_name, "<dev string:x3c1>", x + 5, y + -86, 1);
        hud.menu[15] = dev::new_hud(menu_name, "<dev string:x357>", x + 5, y + -76, 1);
        hud.menu[16] = dev::new_hud(menu_name, "<dev string:x367>", x + 5, y + -66, 1);
        hud.menu[17] = dev::new_hud(menu_name, "<dev string:x3d3>", x + 5, y + -51, 1);
        hud.menu[18] = dev::new_hud(menu_name, "<dev string:x3da>", x + 5, y + -41, 1);
        hud.menu[19] = dev::new_hud(menu_name, "<dev string:x3e2>", x + 5, y + -31, 1);
        hud.menu[20] = dev::new_hud(menu_name, "<dev string:x3ee>", x + 5, y + -21, 1);
        hud.menu[21] = dev::new_hud(menu_name, "<dev string:x3f7>", x + 5, y + -11, 1);
        hud.menu[22] = dev::new_hud(menu_name, "<dev string:x404>", x + 5, y + -1, 1);
        hud.menu[23] = dev::new_hud(menu_name, "<dev string:x410>", x + 5, y + 265, 1);
        hud.menu[24] = dev::new_hud(menu_name, "<dev string:x41a>", x + 5, y + 275, 1);
        x_offset = 65;
        hud.menu[25] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + 35, 1);
        hud.menu[26] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + 45, 1);
        hud.menu[27] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + 55, 1);
        x_offset = 100;
        hud.menu[28] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + 80, 1);
        hud.menu[29] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + 90, 1);
        hud.menu[30] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + 100, 1);
        hud.menu[31] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + 110, 1);
        hud.menu[32] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + 120, 1);
        hud.menu[33] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + -111, 1);
        hud.menu[34] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + -101, 1);
        hud.menu[35] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + -76, 1);
        hud.menu[36] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + -66, 1);
        x_offset = 65;
        hud.menu[37] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + -41, 1);
        hud.menu[38] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + -31, 1);
        hud.menu[39] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + -21, 1);
        hud.menu[40] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + -11, 1);
        hud.menu[41] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + -1, 1);
        hud.menu[42] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + 265, 1);
        hud.menu[43] = dev::new_hud(menu_name, "<dev string:x3a>", x + x_offset, y + 275, 1);
        return hud;
    }

    // Namespace dev_class
    // Params 1, eflags: 0x0
    // Checksum 0xde66b150, Offset: 0x1800
    // Size: 0x70
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
    // Params 0, eflags: 0x0
    // Checksum 0x4f81fc7, Offset: 0x1878
    // Size: 0x143
    function dev_cac_gdt_update_think() {
        for (;;) {
            level waittill(#"gdt_update", asset, keyvalue);
            keyvalue = strtok(keyvalue, "<dev string:x423>");
            key = keyvalue[0];
            switch (key) {
            case "<dev string:x425>":
                key = "<dev string:xb7>";
                break;
            case "<dev string:x431>":
                key = "<dev string:xec>";
                break;
            case "<dev string:x440>":
                key = "<dev string:x120>";
                break;
            case "<dev string:x44a>":
                key = "<dev string:x45a>";
                break;
            case "<dev string:x46c>":
                key = "<dev string:x47f>";
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
    // Params 3, eflags: 0x0
    // Checksum 0x1ef87f80, Offset: 0x19c8
    // Size: 0x88
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
    // Params 3, eflags: 0x0
    // Checksum 0x187ebe8, Offset: 0x1a58
    // Size: 0x88
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
    // Params 2, eflags: 0x0
    // Checksum 0xff1e2b74, Offset: 0x1ae8
    // Size: 0x92
    function dev_cac_set_model_range(sort_function, attribute) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        player.cac_body_type = [[ sort_function ]]("<dev string:x2ee>", attribute);
        player.cac_head_type = [[ sort_function ]]("<dev string:x2fd>", attribute);
        player.cac_hat_type = [[ sort_function ]]("<dev string:x494>", attribute);
        player dev_cac_set_player_model();
    }

#/
