#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_dev;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace dev_class;

/#

    // Namespace dev_class
    // Params 0, eflags: 0x2
    // Checksum 0xb809ca91, Offset: 0x130
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<dev string:x28>", &__init__, undefined, undefined);
    }

    // Namespace dev_class
    // Params 0, eflags: 0x0
    // Checksum 0xc8239c6c, Offset: 0x170
    // Size: 0x2c
    function __init__() {
        callback::on_start_gametype(&init);
    }

    // Namespace dev_class
    // Params 0, eflags: 0x0
    // Checksum 0x1e4c2319, Offset: 0x1a8
    // Size: 0x630
    function init() {
        dev_cac_overlay = 0;
        dev_cac_camera_on = 0;
        level thread dev_cac_gdt_update_think();
        for (;;) {
            wait 0.5;
            reset = 1;
            if (getdvarstring("<dev string:x32>") != "<dev string:x44>") {
                continue;
            }
            host = util::gethostplayer();
            if (!isdefined(level.dev_cac_player)) {
                level.dev_cac_player = host;
            }
            switch (getdvarstring("<dev string:x45>")) {
            case "<dev string:x44>":
                reset = 0;
                break;
            case "<dev string:x54>":
                host thread dev_cac_dpad_think("<dev string:x5e>", &dev_cac_cycle_body, "<dev string:x44>");
                break;
            case "<dev string:x63>":
                host thread dev_cac_dpad_think("<dev string:x6d>", &dev_cac_cycle_head, "<dev string:x44>");
                break;
            case "<dev string:x72>":
                host thread dev_cac_dpad_think("<dev string:x81>", &dev_cac_cycle_character, "<dev string:x44>");
                break;
            case "<dev string:x8b>":
                dev_cac_cycle_player(1);
                break;
            case "<dev string:x97>":
                dev_cac_cycle_player(0);
                break;
            case "<dev string:xa3>":
                level notify(#"dev_cac_overlay_think");
                if (!dev_cac_overlay) {
                    level thread dev_cac_overlay_think();
                }
                dev_cac_overlay = !dev_cac_overlay;
                break;
            case "<dev string:xaf>":
                dev_cac_set_model_range(&sort_greatest, "<dev string:xc1>");
                break;
            case "<dev string:xce>":
                dev_cac_set_model_range(&sort_least, "<dev string:xc1>");
                break;
            case "<dev string:xe1>":
                dev_cac_set_model_range(&sort_greatest, "<dev string:xf6>");
                break;
            case "<dev string:x106>":
                dev_cac_set_model_range(&sort_least, "<dev string:xf6>");
                break;
            case "<dev string:x11c>":
                dev_cac_set_model_range(&sort_greatest, "<dev string:x12a>");
                break;
            case "<dev string:x133>":
                dev_cac_set_model_range(&sort_least, "<dev string:x12a>");
                break;
            case "<dev string:x142>":
                dev_cac_camera_on = !dev_cac_camera_on;
                dev_cac_camera(dev_cac_camera_on);
                break;
            case "<dev string:x149>":
                host thread dev_cac_dpad_think("<dev string:x153>", &dev_cac_cycle_render_options, "<dev string:x153>");
                break;
            case "<dev string:x158>":
                host thread dev_cac_dpad_think("<dev string:x167>", &dev_cac_cycle_render_options, "<dev string:x167>");
                break;
            case "<dev string:x171>":
                host thread dev_cac_dpad_think("<dev string:x17b>", &dev_cac_cycle_render_options, "<dev string:x17b>");
                break;
            case "<dev string:x180>":
                host thread dev_cac_dpad_think("<dev string:x18d>", &dev_cac_cycle_render_options, "<dev string:x18d>");
                break;
            case "<dev string:x195>":
                host thread dev_cac_dpad_think("<dev string:x1a8>", &dev_cac_cycle_render_options, "<dev string:x1b6>");
                break;
            case "<dev string:x1c4>":
                host thread dev_cac_dpad_think("<dev string:x1d0>", &dev_cac_cycle_render_options, "<dev string:x1d0>");
                break;
            case "<dev string:x1d7>":
                host thread dev_cac_dpad_think("<dev string:x1e0>", &dev_cac_cycle_render_options, "<dev string:x1e0>");
                break;
            case "<dev string:x1e4>":
                host thread dev_cac_dpad_think("<dev string:x1fb>", &dev_cac_cycle_render_options, "<dev string:x20d>");
                break;
            case "<dev string:x21f>":
                host thread dev_cac_dpad_think("<dev string:x234>", &dev_cac_cycle_render_options, "<dev string:x244>");
                break;
            case "<dev string:x254>":
                host notify(#"dev_cac_dpad_think");
                break;
            }
            if (reset) {
                setdvar("<dev string:x45>", "<dev string:x44>");
            }
        }
    }

    // Namespace dev_class
    // Params 1, eflags: 0x0
    // Checksum 0xbd4aa05c, Offset: 0x7e0
    // Size: 0xdc
    function dev_cac_camera(on) {
        if (on) {
            self setclientthirdperson(1);
            setdvar("<dev string:x25f>", "<dev string:x273>");
            setdvar("<dev string:x277>", "<dev string:x28b>");
            setdvar("<dev string:x28f>", "<dev string:x296>");
            return;
        }
        self setclientthirdperson(0);
        setdvar("<dev string:x28f>", getdvarstring("<dev string:x299>"));
    }

    // Namespace dev_class
    // Params 3, eflags: 0x0
    // Checksum 0xc027e541, Offset: 0x8c8
    // Size: 0x1fc
    function dev_cac_dpad_think(part_name, cycle_function, tag) {
        self notify(#"dev_cac_dpad_think");
        self endon(#"dev_cac_dpad_think");
        self endon(#"disconnect");
        iprintln("<dev string:x2a8>" + part_name + "<dev string:x2b2>");
        iprintln("<dev string:x2c7>" + part_name + "<dev string:x2cd>");
        dpad_left = 0;
        dpad_right = 0;
        level.dev_cac_player thread highlight_player();
        for (;;) {
            self setactionslot(3, "<dev string:x44>");
            self setactionslot(4, "<dev string:x44>");
            if (!dpad_left && self buttonpressed("<dev string:x2e3>")) {
                [[ cycle_function ]](0, tag);
                dpad_left = 1;
            } else if (!self buttonpressed("<dev string:x2e3>")) {
                dpad_left = 0;
            }
            if (!dpad_right && self buttonpressed("<dev string:x2ed>")) {
                [[ cycle_function ]](1, tag);
                dpad_right = 1;
            } else if (!self buttonpressed("<dev string:x2ed>")) {
                dpad_right = 0;
            }
            wait 0.05;
        }
    }

    // Namespace dev_class
    // Params 2, eflags: 0x0
    // Checksum 0xd46a9e5, Offset: 0xad0
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
    // Params 2, eflags: 0x0
    // Checksum 0xbe2908f, Offset: 0xb90
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
    // Params 0, eflags: 0x0
    // Checksum 0x2885d000, Offset: 0xc58
    // Size: 0x1a
    function dev_cac_set_player_model() {
        self.tag_stowed_back = undefined;
        self.tag_stowed_hip = undefined;
    }

    // Namespace dev_class
    // Params 2, eflags: 0x0
    // Checksum 0xce4a8f44, Offset: 0xc80
    // Size: 0xf4
    function dev_cac_cycle_body(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        keys = getarraykeys(level.cac_functions["<dev string:x2f8>"]);
        if (forward) {
            player.cac_body_type = next_in_list(player.cac_body_type, keys);
        } else {
            player.cac_body_type = prev_in_list(player.cac_body_type, keys);
        }
        player dev_cac_set_player_model();
    }

    // Namespace dev_class
    // Params 2, eflags: 0x0
    // Checksum 0x699849df, Offset: 0xd80
    // Size: 0x10c
    function dev_cac_cycle_head(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        keys = getarraykeys(level.cac_functions["<dev string:x307>"]);
        if (forward) {
            player.cac_head_type = next_in_list(player.cac_head_type, keys);
        } else {
            player.cac_head_type = prev_in_list(player.cac_head_type, keys);
        }
        player.cac_hat_type = "<dev string:x316>";
        player dev_cac_set_player_model();
    }

    // Namespace dev_class
    // Params 2, eflags: 0x0
    // Checksum 0x4e339ee4, Offset: 0xe98
    // Size: 0x10c
    function dev_cac_cycle_character(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        keys = getarraykeys(level.cac_functions["<dev string:x2f8>"]);
        if (forward) {
            player.cac_body_type = next_in_list(player.cac_body_type, keys);
        } else {
            player.cac_body_type = prev_in_list(player.cac_body_type, keys);
        }
        player.cac_hat_type = "<dev string:x316>";
        player dev_cac_set_player_model();
    }

    // Namespace dev_class
    // Params 2, eflags: 0x0
    // Checksum 0x71735c96, Offset: 0xfb0
    // Size: 0x54
    function dev_cac_cycle_render_options(forward, tag) {
        if (!dev_cac_player_valid()) {
            return;
        }
        level.dev_cac_player nextplayerrenderoption(tag, forward);
    }

    // Namespace dev_class
    // Params 0, eflags: 0x0
    // Checksum 0xd5f94212, Offset: 0x1010
    // Size: 0x2e
    function dev_cac_player_valid() {
        return isdefined(level.dev_cac_player) && level.dev_cac_player.sessionstate == "<dev string:x31b>";
    }

    // Namespace dev_class
    // Params 1, eflags: 0x0
    // Checksum 0x843fbc6e, Offset: 0x1048
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
    // Params 0, eflags: 0x0
    // Checksum 0xcfb16530, Offset: 0x1138
    // Size: 0x44
    function highlight_player() {
        self sethighlighted(1);
        wait 1;
        self sethighlighted(0);
    }

    // Namespace dev_class
    // Params 0, eflags: 0x0
    // Checksum 0xc13c72c, Offset: 0x1188
    // Size: 0x64
    function dev_cac_overlay_think() {
        hud = dev_cac_overlay_create();
        level thread dev_cac_overlay_update(hud);
        level waittill(#"dev_cac_overlay_think");
        dev_cac_overlay_destroy(hud);
    }

    // Namespace dev_class
    // Params 1, eflags: 0x0
    // Checksum 0xb2224940, Offset: 0x11f8
    // Size: 0x10
    function dev_cac_overlay_update(hud) {
        
    }

    // Namespace dev_class
    // Params 1, eflags: 0x0
    // Checksum 0x8237cc71, Offset: 0x1210
    // Size: 0xa4
    function dev_cac_overlay_destroy(hud) {
        for (i = 0; i < hud.menu.size; i++) {
            hud.menu[i] destroy();
        }
        hud destroy();
        setdvar("<dev string:x323>", "<dev string:x336>");
    }

    // Namespace dev_class
    // Params 0, eflags: 0x0
    // Checksum 0xd62488cf, Offset: 0x12c0
    // Size: 0xd94
    function dev_cac_overlay_create() {
        x = -80;
        y = -116;
        menu_name = "<dev string:x338>";
        hud = dev::new_hud(menu_name, undefined, x, y, 1);
        hud setshader("<dev string:x346>", -71, 285);
        hud.alignx = "<dev string:x34c>";
        hud.aligny = "<dev string:x351>";
        hud.sort = 10;
        hud.alpha = 0.6;
        hud.color = (0, 0, 0.5);
        x_offset = 100;
        hud.menu[0] = dev::new_hud(menu_name, "<dev string:x355>", x + 5, y + 10, 1.3);
        hud.menu[1] = dev::new_hud(menu_name, "<dev string:x35a>", x + 5, y + 25, 1);
        hud.menu[2] = dev::new_hud(menu_name, "<dev string:x361>", x + 5, y + 35, 1);
        hud.menu[3] = dev::new_hud(menu_name, "<dev string:x369>", x + 5, y + 45, 1);
        hud.menu[4] = dev::new_hud(menu_name, "<dev string:x371>", x + 5, y + 55, 1);
        hud.menu[5] = dev::new_hud(menu_name, "<dev string:x37e>", x + 5, y + 70, 1);
        hud.menu[6] = dev::new_hud(menu_name, "<dev string:x361>", x + 5, y + 80, 1);
        hud.menu[7] = dev::new_hud(menu_name, "<dev string:x371>", x + 5, y + 90, 1);
        hud.menu[8] = dev::new_hud(menu_name, "<dev string:x387>", x + 5, y + 100, 1);
        hud.menu[9] = dev::new_hud(menu_name, "<dev string:x396>", x + 5, y + 110, 1);
        hud.menu[10] = dev::new_hud(menu_name, "<dev string:x3a9>", x + 5, y + 120, 1);
        hud.menu[11] = dev::new_hud(menu_name, "<dev string:x3bc>", x + 5, y + -121, 1);
        hud.menu[12] = dev::new_hud(menu_name, "<dev string:x361>", x + 5, y + -111, 1);
        hud.menu[13] = dev::new_hud(menu_name, "<dev string:x371>", x + 5, y + -101, 1);
        hud.menu[14] = dev::new_hud(menu_name, "<dev string:x3cb>", x + 5, y + -86, 1);
        hud.menu[15] = dev::new_hud(menu_name, "<dev string:x361>", x + 5, y + -76, 1);
        hud.menu[16] = dev::new_hud(menu_name, "<dev string:x371>", x + 5, y + -66, 1);
        hud.menu[17] = dev::new_hud(menu_name, "<dev string:x3dd>", x + 5, y + -51, 1);
        hud.menu[18] = dev::new_hud(menu_name, "<dev string:x3e4>", x + 5, y + -41, 1);
        hud.menu[19] = dev::new_hud(menu_name, "<dev string:x3ec>", x + 5, y + -31, 1);
        hud.menu[20] = dev::new_hud(menu_name, "<dev string:x3f8>", x + 5, y + -21, 1);
        hud.menu[21] = dev::new_hud(menu_name, "<dev string:x401>", x + 5, y + -11, 1);
        hud.menu[22] = dev::new_hud(menu_name, "<dev string:x40e>", x + 5, y + -1, 1);
        hud.menu[23] = dev::new_hud(menu_name, "<dev string:x41a>", x + 5, y + 265, 1);
        hud.menu[24] = dev::new_hud(menu_name, "<dev string:x424>", x + 5, y + 275, 1);
        x_offset = 65;
        hud.menu[25] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + 35, 1);
        hud.menu[26] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + 45, 1);
        hud.menu[27] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + 55, 1);
        x_offset = 100;
        hud.menu[28] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + 80, 1);
        hud.menu[29] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + 90, 1);
        hud.menu[30] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + 100, 1);
        hud.menu[31] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + 110, 1);
        hud.menu[32] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + 120, 1);
        hud.menu[33] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + -111, 1);
        hud.menu[34] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + -101, 1);
        hud.menu[35] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + -76, 1);
        hud.menu[36] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + -66, 1);
        x_offset = 65;
        hud.menu[37] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + -41, 1);
        hud.menu[38] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + -31, 1);
        hud.menu[39] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + -21, 1);
        hud.menu[40] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + -11, 1);
        hud.menu[41] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + -1, 1);
        hud.menu[42] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + 265, 1);
        hud.menu[43] = dev::new_hud(menu_name, "<dev string:x44>", x + x_offset, y + 275, 1);
        return hud;
    }

    // Namespace dev_class
    // Params 1, eflags: 0x0
    // Checksum 0xdc3c61b5, Offset: 0x2060
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
    // Params 0, eflags: 0x0
    // Checksum 0xc1a3cb59, Offset: 0x2110
    // Size: 0x1a6
    function dev_cac_gdt_update_think() {
        for (;;) {
            level waittill(#"gdt_update", asset, keyvalue);
            keyvalue = strtok(keyvalue, "<dev string:x42d>");
            key = keyvalue[0];
            switch (key) {
            case "<dev string:x42f>":
                key = "<dev string:xc1>";
                break;
            case "<dev string:x43b>":
                key = "<dev string:xf6>";
                break;
            case "<dev string:x44a>":
                key = "<dev string:x12a>";
                break;
            case "<dev string:x454>":
                key = "<dev string:x464>";
                break;
            case "<dev string:x476>":
                key = "<dev string:x489>";
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
    // Checksum 0x7994091d, Offset: 0x22c0
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
    // Params 3, eflags: 0x0
    // Checksum 0xc0ae52ff, Offset: 0x2398
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
    // Params 2, eflags: 0x0
    // Checksum 0x1bfd45cf, Offset: 0x2470
    // Size: 0xc4
    function dev_cac_set_model_range(sort_function, attribute) {
        if (!dev_cac_player_valid()) {
            return;
        }
        player = level.dev_cac_player;
        player.cac_body_type = [[ sort_function ]]("<dev string:x2f8>", attribute);
        player.cac_head_type = [[ sort_function ]]("<dev string:x307>", attribute);
        player.cac_hat_type = [[ sort_function ]]("<dev string:x49e>", attribute);
        player dev_cac_set_player_model();
    }

#/
