#namespace debug_menu;

/#

    // Namespace debug_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0x4da4d193, Offset: 0x70
    // Size: 0xb8
    function add_menu(menu_name, title) {
        if (isdefined(level.menu_sys[menu_name])) {
            println("<dev string:x28>" + menu_name + "<dev string:x3a>");
            return;
        }
        level.menu_sys[menu_name] = spawnstruct();
        level.menu_sys[menu_name].title = "<dev string:x61>";
        level.menu_sys[menu_name].title = title;
    }

    // Namespace debug_menu
    // Params 4, eflags: 0x0
    // Checksum 0x9c1b5cfb, Offset: 0x130
    // Size: 0x132
    function add_menuoptions(menu_name, var_26a8b438, func, key) {
        if (!isdefined(level.menu_sys[menu_name].options)) {
            level.menu_sys[menu_name].options = [];
        }
        num = level.menu_sys[menu_name].options.size;
        level.menu_sys[menu_name].options[num] = var_26a8b438;
        level.menu_sys[menu_name].func[num] = func;
        if (isdefined(key)) {
            if (!isdefined(level.menu_sys[menu_name].var_330af417)) {
                level.menu_sys[menu_name].var_330af417 = [];
            }
            level.menu_sys[menu_name].var_330af417[num] = key;
        }
    }

    // Namespace debug_menu
    // Params 5, eflags: 0x0
    // Checksum 0xab49b5d0, Offset: 0x270
    // Size: 0x176
    function add_menu_child(parent_menu, var_43d33b65, var_5a160d62, var_43a34966, func) {
        if (!isdefined(level.menu_sys[var_43d33b65])) {
            add_menu(var_43d33b65, var_5a160d62);
        }
        level.menu_sys[var_43d33b65].parent_menu = parent_menu;
        if (!isdefined(level.menu_sys[parent_menu].children_menu)) {
            level.menu_sys[parent_menu].children_menu = [];
        }
        if (!isdefined(var_43a34966)) {
            size = level.menu_sys[parent_menu].children_menu.size;
        } else {
            size = var_43a34966;
        }
        level.menu_sys[parent_menu].children_menu[size] = var_43d33b65;
        if (isdefined(func)) {
            if (!isdefined(level.menu_sys[parent_menu].children_func)) {
                level.menu_sys[parent_menu].children_func = [];
            }
            level.menu_sys[parent_menu].children_func[size] = func;
        }
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x0
    // Checksum 0xa8aeb386, Offset: 0x3f0
    // Size: 0x2c
    function function_af0c3893(menu_name) {
        level.menu_sys[menu_name].var_5989e69a = 1;
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0xdc9fd09d, Offset: 0x428
    // Size: 0x276
    function enable_menu(menu_name) {
        disable_menu("<dev string:x66>");
        if (isdefined(level.menu_cursor)) {
            level.menu_cursor.y = -126;
            level.menu_cursor.current_pos = 0;
        }
        level.menu_sys["<dev string:x66>"].title = set_menu_hudelem(level.menu_sys[menu_name].title, "<dev string:x73>");
        level.menu_sys["<dev string:x66>"].menu_name = menu_name;
        var_593795dd = 0;
        if (isdefined(level.menu_sys[menu_name].options)) {
            options = level.menu_sys[menu_name].options;
            for (i = 0; i < options.size; i++) {
                text = i + 1 + "<dev string:x79>" + options[i];
                level.menu_sys["<dev string:x66>"].options[i] = set_menu_hudelem(text, "<dev string:x7c>", 20 * i);
                var_593795dd = i;
            }
        }
        if (isdefined(level.menu_sys[menu_name].parent_menu) && !isdefined(level.menu_sys[menu_name].var_5989e69a)) {
            var_593795dd++;
            text = var_593795dd + 1 + "<dev string:x79>" + "<dev string:x84>";
            level.menu_sys["<dev string:x66>"].options[var_593795dd] = set_menu_hudelem(text, "<dev string:x7c>", 20 * var_593795dd);
        }
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb94bf3f, Offset: 0x6a8
    // Size: 0x128
    function disable_menu(menu_name) {
        if (isdefined(level.menu_sys[menu_name])) {
            if (isdefined(level.menu_sys[menu_name].title)) {
                level.menu_sys[menu_name].title destroy();
            }
            if (isdefined(level.menu_sys[menu_name].options)) {
                options = level.menu_sys[menu_name].options;
                for (i = 0; i < options.size; i++) {
                    options[i] destroy();
                }
            }
        }
        level.menu_sys[menu_name].title = undefined;
        level.menu_sys[menu_name].options = [];
    }

    // Namespace debug_menu
    // Params 3, eflags: 0x1 linked
    // Checksum 0x8ab091b4, Offset: 0x7d8
    // Size: 0xcc
    function set_menu_hudelem(text, type, y_offset) {
        y = 100;
        if (isdefined(type) && type == "<dev string:x73>") {
            scale = 2;
        } else {
            scale = 1.3;
            y += 30;
        }
        if (!isdefined(y_offset)) {
            y_offset = 0;
        }
        y += y_offset;
        return set_hudelem(text, 10, y, scale);
    }

    // Namespace debug_menu
    // Params 7, eflags: 0x1 linked
    // Checksum 0xec09d14, Offset: 0x8b0
    // Size: 0x1d2
    function set_hudelem(text, x, y, scale, alpha, sort, debug_hudelem) {
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        if (!isdefined(scale)) {
            scale = 1;
        }
        if (!isdefined(sort)) {
            sort = 20;
        }
        if (isdefined(level.player) && !isdefined(debug_hudelem)) {
            hud = newclienthudelem(level.player);
        } else {
            hud = newdebughudelem();
            hud.debug_hudelem = 1;
        }
        hud.location = 0;
        hud.alignx = "<dev string:x89>";
        hud.aligny = "<dev string:x8e>";
        hud.foreground = 1;
        hud.fontscale = scale;
        hud.sort = sort;
        hud.alpha = alpha;
        hud.x = x;
        hud.y = y;
        hud.og_scale = scale;
        if (isdefined(text)) {
            hud settext(text);
        }
        return hud;
    }

    // Namespace debug_menu
    // Params 0, eflags: 0x0
    // Checksum 0x19b1b57a, Offset: 0xa90
    // Size: 0x820
    function menu_input() {
        while (true) {
            keystring = level waittill(#"hash_69c6c918");
            menu_name = level.menu_sys["<dev string:x66>"].menu_name;
            if (keystring == "<dev string:x95>" || keystring == "<dev string:x9d>") {
                if (level.menu_cursor.current_pos > 0) {
                    level.menu_cursor.y -= 20;
                    level.menu_cursor.current_pos--;
                } else if (level.menu_cursor.current_pos == 0) {
                    level.menu_cursor.y += (level.menu_sys["<dev string:x66>"].options.size - 1) * 20;
                    level.menu_cursor.current_pos = level.menu_sys["<dev string:x66>"].options.size - 1;
                }
                wait 0.1;
                continue;
            } else if (keystring == "<dev string:xa5>" || keystring == "<dev string:xaf>") {
                if (level.menu_cursor.current_pos < level.menu_sys["<dev string:x66>"].options.size - 1) {
                    level.menu_cursor.y += 20;
                    level.menu_cursor.current_pos++;
                } else if (level.menu_cursor.current_pos == level.menu_sys["<dev string:x66>"].options.size - 1) {
                    level.menu_cursor.y += level.menu_cursor.current_pos * -20;
                    level.menu_cursor.current_pos = 0;
                }
                wait 0.1;
                continue;
            } else if (keystring == "<dev string:xb9>" || keystring == "<dev string:xc2>") {
                key = level.menu_cursor.current_pos;
            } else {
                key = int(keystring) - 1;
            }
            if (key > level.menu_sys[menu_name].options.size) {
                continue;
            } else if (isdefined(level.menu_sys[menu_name].parent_menu) && key == level.menu_sys[menu_name].options.size) {
                level notify("<dev string:xc8>" + menu_name);
                level enable_menu(level.menu_sys[menu_name].parent_menu);
            } else if (isdefined(level.menu_sys[menu_name].func) && isdefined(level.menu_sys[menu_name].func[key])) {
                level.menu_sys["<dev string:x66>"].options[key] thread hud_selector(level.menu_sys["<dev string:x66>"].options[key].x, level.menu_sys["<dev string:x66>"].options[key].y);
                if (isdefined(level.menu_sys[menu_name].var_330af417) && isdefined(level.menu_sys[menu_name].var_330af417[key]) && level.menu_sys[menu_name].var_330af417[key] == keystring) {
                    error_msg = level [[ level.menu_sys[menu_name].func[key] ]]();
                } else {
                    error_msg = level [[ level.menu_sys[menu_name].func[key] ]]();
                }
                level thread hud_selector_fade_out();
                if (isdefined(error_msg)) {
                    level thread selection_error(error_msg, level.menu_sys["<dev string:x66>"].options[key].x, level.menu_sys["<dev string:x66>"].options[key].y);
                }
            }
            if (!isdefined(level.menu_sys[menu_name].children_menu)) {
                println("<dev string:xd1>" + menu_name + "<dev string:xd5>");
                continue;
            } else if (!isdefined(level.menu_sys[menu_name].children_menu[key])) {
                println("<dev string:xd1>" + menu_name + "<dev string:x101>" + key + "<dev string:x11f>");
                continue;
            } else if (!isdefined(level.menu_sys[level.menu_sys[menu_name].children_menu[key]])) {
                println("<dev string:xd1>" + level.menu_sys[menu_name].options[key] + "<dev string:x130>");
                continue;
            }
            if (isdefined(level.menu_sys[menu_name].children_func) && isdefined(level.menu_sys[menu_name].children_func[key])) {
                func = level.menu_sys[menu_name].children_func[key];
                error_msg = [[ func ]]();
                if (isdefined(error_msg)) {
                    level thread selection_error(error_msg, level.menu_sys["<dev string:x66>"].options[key].x, level.menu_sys["<dev string:x66>"].options[key].y);
                    continue;
                }
            }
            level enable_menu(level.menu_sys[menu_name].children_menu[key]);
            wait 0.1;
        }
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x0
    // Checksum 0x6a25ed7, Offset: 0x12b8
    // Size: 0x1ae
    function function_bd37ea7e(waittill_msg) {
        if (isdefined(waittill_msg)) {
            level waittill(waittill_msg);
        }
        wait 0.1;
        menu_name = level.menu_sys["<dev string:x66>"].menu_name;
        key = level.menu_sys[menu_name].options.size;
        key++;
        if (key == 1) {
            key = "<dev string:x14a>";
        } else if (key == 2) {
            key = "<dev string:x14c>";
        } else if (key == 3) {
            key = "<dev string:x14e>";
        } else if (key == 4) {
            key = "<dev string:x150>";
        } else if (key == 5) {
            key = "<dev string:x152>";
        } else if (key == 6) {
            key = "<dev string:x154>";
        } else if (key == 7) {
            key = "<dev string:x156>";
        } else if (key == 8) {
            key = "<dev string:x158>";
        } else if (key == 9) {
            key = "<dev string:x15a>";
        }
        level notify(#"hash_69c6c918", key);
    }

    // Namespace debug_menu
    // Params 7, eflags: 0x0
    // Checksum 0xa83f6979, Offset: 0x1470
    // Size: 0x46c
    function list_menu(list, x, y, scale, func, sort, var_4cd7cc92) {
        if (!isdefined(list) || list.size == 0) {
            return -1;
        }
        hud_array = [];
        for (i = 0; i < 5; i++) {
            if (i == 0) {
                alpha = 0.3;
            } else if (i == 1) {
                alpha = 0.6;
            } else if (i == 2) {
                alpha = 1;
            } else if (i == 3) {
                alpha = 0.6;
            } else {
                alpha = 0.3;
            }
            hud = set_hudelem(list[i], x, y + (i - 2) * 15, scale, alpha, sort);
            if (!isdefined(hud_array)) {
                hud_array = [];
            } else if (!isarray(hud_array)) {
                hud_array = array(hud_array);
            }
            hud_array[hud_array.size] = hud;
        }
        if (isdefined(var_4cd7cc92)) {
            function_bdb589d8(hud_array, list, var_4cd7cc92);
        }
        var_42618b51 = 0;
        var_821d84b1 = 0;
        selected = 0;
        level.menu_list_selected = 0;
        if (isdefined(func)) {
            [[ func ]](list[var_42618b51]);
        }
        while (true) {
            key = level waittill(#"hash_69c6c918");
            level.menu_list_selected = 1;
            if (any_button_hit(key, "<dev string:x15c>")) {
                break;
            } else if (key == "<dev string:xaf>" || key == "<dev string:xa5>") {
                if (var_42618b51 >= list.size - 1) {
                    continue;
                }
                var_42618b51++;
                function_bdb589d8(hud_array, list, var_42618b51);
            } else if (key == "<dev string:x9d>" || key == "<dev string:x95>") {
                if (var_42618b51 <= 0) {
                    continue;
                }
                var_42618b51--;
                function_bdb589d8(hud_array, list, var_42618b51);
            } else if (key == "<dev string:xc2>" || key == "<dev string:xb9>") {
                selected = 1;
                break;
            } else if (key == "<dev string:x164>" || key == "<dev string:x168>") {
                selected = 0;
                break;
            }
            level notify(#"hash_c4916d91");
            if (var_42618b51 != var_821d84b1) {
                var_821d84b1 = var_42618b51;
                if (isdefined(func)) {
                    [[ func ]](list[var_42618b51]);
                }
            }
            wait 0.1;
        }
        for (i = 0; i < hud_array.size; i++) {
            hud_array[i] destroy();
        }
        if (selected) {
            return var_42618b51;
        }
    }

    // Namespace debug_menu
    // Params 3, eflags: 0x1 linked
    // Checksum 0xc724ff64, Offset: 0x18e8
    // Size: 0xbe
    function function_bdb589d8(hud_array, list, num) {
        for (i = 0; i < hud_array.size; i++) {
            if (isdefined(list[i + num - 2])) {
                text = list[i + num - 2];
            } else {
                text = "<dev string:x171>";
            }
            hud_array[i] settext(text);
        }
    }

    // Namespace debug_menu
    // Params 6, eflags: 0x0
    // Checksum 0x6b6da306, Offset: 0x19b0
    // Size: 0x27e
    function move_list_menu(hud_array, dir, space, num, var_b091d62e, var_41028055) {
        if (!isdefined(var_b091d62e)) {
            var_b091d62e = 0;
        }
        if (!isdefined(var_41028055)) {
            var_41028055 = 3;
        }
        var_21b889cc = 0;
        if (dir == "<dev string:x172>") {
            var_21b889cc = 1;
            movement = space;
        } else if (dir == "<dev string:x89>") {
            var_21b889cc = 1;
            movement = space * -1;
        } else if (dir == "<dev string:x178>") {
            movement = space;
        } else {
            movement = space * -1;
        }
        for (i = 0; i < hud_array.size; i++) {
            hud_array[i] moveovertime(0.1);
            if (var_21b889cc) {
                hud_array[i].x = hud_array[i].x + movement;
            } else {
                hud_array[i].y = hud_array[i].y + movement;
            }
            temp = i - num;
            if (temp < 0) {
                temp *= -1;
            }
            alpha = 1 / (temp + 1);
            if (alpha < 1 / var_41028055) {
                alpha = var_b091d62e;
            }
            if (!isdefined(hud_array[i].debug_hudelem)) {
                hud_array[i] fadeovertime(0.1);
            }
            hud_array[i].alpha = alpha;
        }
    }

    // Namespace debug_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0xc8e901a6, Offset: 0x1c38
    // Size: 0xf0
    function hud_selector(x, y) {
        if (isdefined(level.hud_selector)) {
            level thread hud_selector_fade_out();
        }
        level.menu_cursor.alpha = 0;
        level.hud_selector = set_hudelem(undefined, x - 10, y, 1);
        level.hud_selector setshader("<dev string:x17b>", 125, 20);
        level.hud_selector.color = (1, 1, 0.5);
        level.hud_selector.alpha = 0.5;
        level.hud_selector.sort = 10;
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe3862b1a, Offset: 0x1d30
    // Size: 0xc4
    function hud_selector_fade_out(time) {
        if (!isdefined(time)) {
            time = 0.25;
        }
        level.menu_cursor.alpha = 0.5;
        hud = level.hud_selector;
        level.hud_selector = undefined;
        if (!isdefined(hud.debug_hudelem)) {
            hud fadeovertime(time);
        }
        hud.alpha = 0;
        wait time + 0.1;
        hud destroy();
    }

    // Namespace debug_menu
    // Params 3, eflags: 0x1 linked
    // Checksum 0x45385f29, Offset: 0x1e00
    // Size: 0x1a4
    function selection_error(msg, x, y) {
        hud = set_hudelem(undefined, x - 10, y, 1);
        hud setshader("<dev string:x17b>", 125, 20);
        hud.color = (0.5, 0, 0);
        hud.alpha = 0.7;
        var_58f82c4b = set_hudelem(msg, x + 125, y, 1);
        var_58f82c4b.color = (1, 0, 0);
        if (!isdefined(hud.debug_hudelem)) {
            hud fadeovertime(3);
        }
        hud.alpha = 0;
        if (!isdefined(var_58f82c4b.debug_hudelem)) {
            var_58f82c4b fadeovertime(3);
        }
        var_58f82c4b.alpha = 0;
        wait 3.1;
        hud destroy();
        var_58f82c4b destroy();
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x0
    // Checksum 0xceed86e0, Offset: 0x1fb0
    // Size: 0xfa
    function function_79fea2bf(mult) {
        self notify(#"hash_ae05051b");
        self endon(#"death");
        self endon(#"hash_ae05051b");
        og_scale = self.og_scale;
        if (!isdefined(mult)) {
            mult = 1.5;
        }
        self.fontscale = og_scale * mult;
        dif = og_scale - self.fontscale;
        dif /= 1 * 20;
        for (i = 0; i < 1 * 20; i++) {
            self.fontscale += dif;
            wait 0.05;
        }
    }

    // Namespace debug_menu
    // Params 0, eflags: 0x0
    // Checksum 0x7296d8f, Offset: 0x20b8
    // Size: 0xbc
    function menu_cursor() {
        level.menu_cursor = set_hudelem(undefined, 0, -126, 1.3);
        level.menu_cursor setshader("<dev string:x17b>", 125, 20);
        level.menu_cursor.color = (1, 0.5, 0);
        level.menu_cursor.alpha = 0.5;
        level.menu_cursor.sort = 1;
        level.menu_cursor.current_pos = 0;
    }

    // Namespace debug_menu
    // Params 5, eflags: 0x1 linked
    // Checksum 0xe43fbaea, Offset: 0x2180
    // Size: 0xc2
    function new_hud(hud_name, msg, x, y, scale) {
        if (!isdefined(level.hud_array)) {
            level.hud_array = [];
        }
        if (!isdefined(level.hud_array[hud_name])) {
            level.hud_array[hud_name] = [];
        }
        hud = set_hudelem(msg, x, y, scale);
        level.hud_array[hud_name][level.hud_array[hud_name].size] = hud;
        return hud;
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0xdb331f61, Offset: 0x2250
    // Size: 0x94
    function function_f8a0189f(hud_name) {
        if (!isdefined(level.hud_array[hud_name])) {
            return;
        }
        huds = level.hud_array[hud_name];
        for (i = 0; i < huds.size; i++) {
            function_ef76706b(huds[i]);
        }
        level.hud_array[hud_name] = undefined;
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9f867dca, Offset: 0x22f0
    // Size: 0x34
    function function_ef76706b(hud) {
        if (isdefined(hud)) {
            hud destroy();
        }
    }

    // Namespace debug_menu
    // Params 7, eflags: 0x0
    // Checksum 0x729d6a77, Offset: 0x2330
    // Size: 0x142
    function function_7395ea6e(hud_array, num, x, y, space, var_b091d62e, var_41028055) {
        if (!isdefined(var_b091d62e)) {
            var_b091d62e = 0.1;
        }
        if (!isdefined(var_41028055)) {
            var_41028055 = 3;
        }
        for (i = 0; i < hud_array.size; i++) {
            temp = i - num;
            hud_array[i].y = y + temp * space;
            if (temp < 0) {
                temp *= -1;
            }
            alpha = 1 / (temp + 1);
            if (alpha < 1 / var_41028055) {
                alpha = var_b091d62e;
            }
            hud_array[i].alpha = alpha;
        }
    }

    // Namespace debug_menu
    // Params 7, eflags: 0x0
    // Checksum 0x57cd8107, Offset: 0x2480
    // Size: 0x360
    function function_8117b00b(x, y, width, height, time, color, alpha) {
        if (!isdefined(alpha)) {
            alpha = 0.5;
        }
        if (!isdefined(color)) {
            color = (0, 0, 0.5);
        }
        if (isdefined(level.player)) {
            hud = newclienthudelem(level.player);
        } else {
            hud = newdebughudelem();
            hud.debug_hudelem = 1;
        }
        hud.alignx = "<dev string:x89>";
        hud.aligny = "<dev string:x8e>";
        hud.foreground = 1;
        hud.sort = 30;
        hud.x = x;
        hud.y = y;
        hud.alpha = alpha;
        hud.color = color;
        if (isdefined(level.player)) {
            hud.background = newclienthudelem(level.player);
        } else {
            hud.background = newdebughudelem();
            hud.debug_hudelem = 1;
        }
        hud.background.alignx = "<dev string:x89>";
        hud.background.aligny = "<dev string:x8e>";
        hud.background.foreground = 1;
        hud.background.sort = 25;
        hud.background.x = x + 2;
        hud.background.y = y + 2;
        hud.background.alpha = 0.75;
        hud.background.color = (0, 0, 0);
        hud setshader("<dev string:x17b>", 0, 0);
        hud scaleovertime(time, width, height);
        hud.background setshader("<dev string:x17b>", 0, 0);
        hud.background scaleovertime(time, width, height);
        wait time;
        return hud;
    }

    // Namespace debug_menu
    // Params 0, eflags: 0x0
    // Checksum 0x74c070b4, Offset: 0x27e8
    // Size: 0x9c
    function function_bea48276() {
        self.background scaleovertime(0.25, 0, 0);
        self scaleovertime(0.25, 0, 0);
        wait 0.1;
        if (isdefined(self.background)) {
            self.background destroy();
        }
        if (isdefined(self)) {
            self destroy();
        }
    }

    // Namespace debug_menu
    // Params 3, eflags: 0x0
    // Checksum 0xd25c54b0, Offset: 0x2890
    // Size: 0x4e2
    function function_21e7ce2f(var_ecf4b75f, var_d0b8930f, var_476db3a8) {
        y = 100;
        hud = new_hud("<dev string:x181>", undefined, 320 - 300 * 0.5, y, 1);
        hud setshader("<dev string:x17b>", 300, 100);
        hud.aligny = "<dev string:x18c>";
        hud.color = (0, 0, 0.2);
        hud.alpha = 0.85;
        hud.sort = 20;
        hud = new_hud("<dev string:x181>", var_ecf4b75f, 320 - 300 * 0.5 + 10, y + 10, 1.25);
        hud.sort = 25;
        if (isdefined(var_d0b8930f)) {
            hud = new_hud("<dev string:x181>", var_d0b8930f, 320 - 300 * 0.5 + 10, y + 30, 1.1);
            hud.sort = 25;
        }
        var_564f8517 = 300 - 20;
        y = -106;
        hud = new_hud("<dev string:x181>", undefined, 320 - var_564f8517 * 0.5, y, 1);
        hud setshader("<dev string:x17b>", var_564f8517, 20);
        hud.aligny = "<dev string:x18c>";
        hud.color = (0, 0, 0);
        hud.alpha = 0.85;
        hud.sort = 30;
        var_847182fe = 320 - var_564f8517 * 0.5 + 2;
        var_aa73fd67 = y + 8;
        if (level.xenon) {
            hud = new_hud("<dev string:x181>", "<dev string:x190>", 320 - 50, y + 30, 1.25);
            hud.alignx = "<dev string:x197>";
            hud.sort = 25;
            hud = new_hud("<dev string:x181>", "<dev string:x19e>", 320 + 50, y + 30, 1.25);
            hud.alignx = "<dev string:x197>";
            hud.sort = 25;
        } else {
            hud = new_hud("<dev string:x181>", "<dev string:x1a9>", 320 - 50, y + 30, 1.25);
            hud.alignx = "<dev string:x197>";
            hud.sort = 25;
            hud = new_hud("<dev string:x181>", "<dev string:x1b4>", 320 + 50, y + 30, 1.25);
            hud.alignx = "<dev string:x197>";
            hud.sort = 25;
        }
        result = function_8d7a3a66(var_847182fe, var_aa73fd67, var_476db3a8);
        function_f8a0189f("<dev string:x181>");
        return result;
    }

    // Namespace debug_menu
    // Params 3, eflags: 0x1 linked
    // Checksum 0x60843bd4, Offset: 0x2d80
    // Size: 0x2ec
    function function_8d7a3a66(var_847182fe, var_aa73fd67, var_476db3a8) {
        level.var_f1175864 = new_hud("<dev string:x181>", "<dev string:x1c1>", var_847182fe, var_aa73fd67, 1.25);
        level.var_f1175864.sort = 75;
        level thread function_561fa6f4();
        function_5eabe035();
        var_5f2f1ccb = new_hud("<dev string:x181>", "<dev string:x171>", var_847182fe, var_aa73fd67, 1.25);
        var_5f2f1ccb.sort = 75;
        var_3eb3582a = [];
        word = "<dev string:x171>";
        while (true) {
            button = level waittill(#"hash_b6282a51");
            if (button == "<dev string:x164>" || button == "<dev string:x1c3>") {
                word = "<dev string:x1cc>";
                break;
            } else if (button == "<dev string:xc2>" || button == "<dev string:x1cf>" || button == "<dev string:xb9>") {
                break;
            } else if (button == "<dev string:x1d8>" || button == "<dev string:x1e2>") {
                var_a6dc440 = "<dev string:x171>";
                for (i = 0; i < word.size - 1; i++) {
                    var_a6dc440 += word[i];
                }
                word = var_a6dc440;
            } else if (word.size < var_476db3a8) {
                word += button;
            }
            var_5f2f1ccb settext(word);
            x = var_847182fe;
            for (i = 0; i < word.size; i++) {
                x += function_6a8744ed(word[i]);
            }
            level.var_f1175864.x = x;
            wait 0.05;
        }
        level notify(#"hash_645fd9e1");
        level notify(#"hash_a1a6c8e3");
        return word;
    }

    // Namespace debug_menu
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf5a974d8, Offset: 0x3078
    // Size: 0x5d4
    function function_5eabe035() {
        clear_universal_buttons("<dev string:x1e6>");
        add_universal_button("<dev string:x181>", "<dev string:x1fa>");
        add_universal_button("<dev string:x181>", "<dev string:x1fc>");
        add_universal_button("<dev string:x181>", "<dev string:x14a>");
        add_universal_button("<dev string:x181>", "<dev string:x14c>");
        add_universal_button("<dev string:x181>", "<dev string:x14e>");
        add_universal_button("<dev string:x181>", "<dev string:x150>");
        add_universal_button("<dev string:x181>", "<dev string:x152>");
        add_universal_button("<dev string:x181>", "<dev string:x154>");
        add_universal_button("<dev string:x181>", "<dev string:x156>");
        add_universal_button("<dev string:x181>", "<dev string:x158>");
        add_universal_button("<dev string:x181>", "<dev string:x15a>");
        add_universal_button("<dev string:x181>", "<dev string:x1fe>");
        add_universal_button("<dev string:x181>", "<dev string:x200>");
        add_universal_button("<dev string:x181>", "<dev string:x202>");
        add_universal_button("<dev string:x181>", "<dev string:x204>");
        add_universal_button("<dev string:x181>", "<dev string:x206>");
        add_universal_button("<dev string:x181>", "<dev string:x208>");
        add_universal_button("<dev string:x181>", "<dev string:x20a>");
        add_universal_button("<dev string:x181>", "<dev string:x20c>");
        add_universal_button("<dev string:x181>", "<dev string:x20e>");
        add_universal_button("<dev string:x181>", "<dev string:x210>");
        add_universal_button("<dev string:x181>", "<dev string:x212>");
        add_universal_button("<dev string:x181>", "<dev string:x214>");
        add_universal_button("<dev string:x181>", "<dev string:x216>");
        add_universal_button("<dev string:x181>", "<dev string:x218>");
        add_universal_button("<dev string:x181>", "<dev string:x21a>");
        add_universal_button("<dev string:x181>", "<dev string:x21c>");
        add_universal_button("<dev string:x181>", "<dev string:x21e>");
        add_universal_button("<dev string:x181>", "<dev string:x220>");
        add_universal_button("<dev string:x181>", "<dev string:x222>");
        add_universal_button("<dev string:x181>", "<dev string:x224>");
        add_universal_button("<dev string:x181>", "<dev string:x226>");
        add_universal_button("<dev string:x181>", "<dev string:x228>");
        add_universal_button("<dev string:x181>", "<dev string:x22a>");
        add_universal_button("<dev string:x181>", "<dev string:x22c>");
        add_universal_button("<dev string:x181>", "<dev string:x22e>");
        add_universal_button("<dev string:x181>", "<dev string:x230>");
        add_universal_button("<dev string:x181>", "<dev string:xc2>");
        add_universal_button("<dev string:x181>", "<dev string:x1cf>");
        add_universal_button("<dev string:x181>", "<dev string:x164>");
        add_universal_button("<dev string:x181>", "<dev string:x1d8>");
        add_universal_button("<dev string:x181>", "<dev string:x1e2>");
        if (level.xenon) {
            add_universal_button("<dev string:x181>", "<dev string:xb9>");
            add_universal_button("<dev string:x181>", "<dev string:x1c3>");
        }
        level thread universal_input_loop("<dev string:x181>", "<dev string:x232>", undefined, undefined);
    }

    // Namespace debug_menu
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8bdca92c, Offset: 0x3658
    // Size: 0x54
    function function_561fa6f4() {
        level endon(#"hash_645fd9e1");
        while (true) {
            level.var_f1175864.alpha = 0;
            wait 0.5;
            level.var_f1175864.alpha = 1;
            wait 0.5;
        }
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3d9a7869, Offset: 0x36b8
    // Size: 0x166
    function function_6a8744ed(letter) {
        if (letter == "<dev string:x216>" || letter == "<dev string:x22a>" || letter == "<dev string:x1fa>") {
            space = 10;
        } else if (letter == "<dev string:x206>" || letter == "<dev string:x20c>" || letter == "<dev string:x226>" || letter == "<dev string:x228>" || letter == "<dev string:x22c>" || letter == "<dev string:x21a>") {
            space = 7;
        } else if (letter == "<dev string:x208>" || letter == "<dev string:x220>" || letter == "<dev string:x224>") {
            space = 5;
        } else if (letter == "<dev string:x20e>" || letter == "<dev string:x214>") {
            space = 4;
        } else if (letter == "<dev string:x210>") {
            space = 3;
        } else {
            space = 6;
        }
        return space;
    }

    // Namespace debug_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa0346b7c, Offset: 0x3828
    // Size: 0x84
    function add_universal_button(var_38e2c1b9, name) {
        if (!isdefined(level.u_buttons[var_38e2c1b9])) {
            level.u_buttons[var_38e2c1b9] = [];
        }
        if (!isinarray(level.u_buttons[var_38e2c1b9], name)) {
            level.u_buttons[var_38e2c1b9][level.u_buttons[var_38e2c1b9].size] = name;
        }
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc9c28309, Offset: 0x38b8
    // Size: 0x22
    function clear_universal_buttons(var_38e2c1b9) {
        level.u_buttons[var_38e2c1b9] = [];
    }

    // Namespace debug_menu
    // Params 5, eflags: 0x1 linked
    // Checksum 0x22ec86c5, Offset: 0x38e8
    // Size: 0x1e0
    function universal_input_loop(var_38e2c1b9, end_on, var_f343011, var_e97f2392, var_584b7e5c) {
        level endon(end_on);
        if (!isdefined(var_f343011)) {
            var_f343011 = 0;
        }
        notify_name = var_38e2c1b9 + "<dev string:x249>";
        buttons = level.u_buttons[var_38e2c1b9];
        level.u_buttons_disable[var_38e2c1b9] = 0;
        while (true) {
            if (level.u_buttons_disable[var_38e2c1b9]) {
                wait 0.05;
                continue;
            }
            if (isdefined(var_e97f2392) && !level.player buttonpressed(var_e97f2392)) {
                wait 0.05;
                continue;
            } else if (isdefined(var_584b7e5c) && level.player buttonpressed(var_584b7e5c)) {
                wait 0.05;
                continue;
            }
            if (var_f343011 && level.player attackbuttonpressed()) {
                level notify(notify_name, "<dev string:x259>");
                wait 0.1;
                continue;
            }
            for (i = 0; i < buttons.size; i++) {
                if (level.player buttonpressed(buttons[i])) {
                    level notify(notify_name, buttons[i]);
                    wait 0.1;
                    break;
                }
            }
            wait 0.05;
        }
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x0
    // Checksum 0x4ec99fc1, Offset: 0x3ad0
    // Size: 0x22
    function function_49453b79(var_38e2c1b9) {
        level.u_buttons_disable[var_38e2c1b9] = 1;
    }

    // Namespace debug_menu
    // Params 1, eflags: 0x0
    // Checksum 0xd9c67699, Offset: 0x3b00
    // Size: 0x26
    function function_80a9c472(var_38e2c1b9) {
        wait 1;
        level.u_buttons_disable[var_38e2c1b9] = 0;
    }

    // Namespace debug_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0x11d4c4c4, Offset: 0x3b30
    // Size: 0x154
    function any_button_hit(var_b7d2a5af, type) {
        buttons = [];
        if (type == "<dev string:x15c>") {
            buttons[0] = "<dev string:x1fc>";
            buttons[1] = "<dev string:x14a>";
            buttons[2] = "<dev string:x14c>";
            buttons[3] = "<dev string:x14e>";
            buttons[4] = "<dev string:x150>";
            buttons[5] = "<dev string:x152>";
            buttons[6] = "<dev string:x154>";
            buttons[7] = "<dev string:x156>";
            buttons[8] = "<dev string:x158>";
            buttons[9] = "<dev string:x15a>";
        } else {
            buttons = level.buttons;
        }
        for (i = 0; i < buttons.size; i++) {
            if (var_b7d2a5af == buttons[i]) {
                return 1;
            }
        }
        return 0;
    }

#/
