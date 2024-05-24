#using scripts/cp/_challenges;
#using scripts/cp/_accolades;
#using scripts/cp/gametypes/_save;
#using scripts/cp/_laststand;
#using scripts/cp/_skipto;
#using scripts/cp/_decorations;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/load_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace devgui;

/#

    // Namespace devgui
    // Params 0, eflags: 0x2
    // Checksum 0x56fc5155, Offset: 0x270
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<unknown string>", &__init__, undefined, undefined);
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2e544098, Offset: 0x2b0
    // Size: 0x1bc
    function __init__() {
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", "<unknown string>");
        thread devgui_think();
        thread devgui_weapon_think();
        thread devgui_weapon_asset_name_display_think();
        thread devgui_test_chart_think();
        thread init_debug_center_screen();
        level thread dev::body_customization_devgui(2);
        callback::on_start_gametype(&function_6579c4b6);
        callback::on_connect(&devgui_player_connect);
        callback::on_disconnect(&devgui_player_disconnect);
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe52f8091, Offset: 0x478
    // Size: 0x1ee
    function function_6579c4b6() {
        level flag::wait_till("<unknown string>");
        rootclear = "<unknown string>";
        adddebugcommand(rootclear);
        players = getplayers();
        foreach (player in getplayers()) {
            rootclear = "<unknown string>" + player.playername + "<unknown string>";
            adddebugcommand(rootclear);
        }
        thread devgui_player_weapons();
        level.player_devgui_base = "<unknown string>";
        devgui_add_player_commands(level.player_devgui_base, "<unknown string>", 0);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            ip1 = i + 1;
            devgui_add_player_commands(level.player_devgui_base, players[i].playername, ip1);
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd1bd5f69, Offset: 0x670
    // Size: 0xae
    function devgui_player_connect() {
        if (!isdefined(level.player_devgui_base)) {
            return;
        }
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i] != self) {
                continue;
            }
            devgui_add_player_commands(level.player_devgui_base, players[i].playername, i + 1);
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2847c4cd, Offset: 0x728
    // Size: 0x54
    function devgui_player_disconnect() {
        if (!isdefined(level.player_devgui_base)) {
            return;
        }
        rootclear = "<unknown string>" + self.playername + "<unknown string>";
        util::add_queued_debug_command(rootclear);
    }

    // Namespace devgui
    // Params 3, eflags: 0x1 linked
    // Checksum 0xabff2da0, Offset: 0x788
    // Size: 0x68c
    function devgui_add_player_commands(root, pname, index) {
        player_devgui_root = root + pname + "<unknown string>";
        pid = "<unknown string>" + index;
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 1, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 2, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 3, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 4, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 5, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 6, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 7, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 8, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 9, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 10, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 11, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 12, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 13, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 14, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 15, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 16, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 17, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 18, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 19, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 20, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 21, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 22, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 23, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 24, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 25, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 26, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 27, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 28, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 29, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 30, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 31, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 32, "<unknown string>");
        function_d2147d9f(player_devgui_root, pid, "<unknown string>", 33, "<unknown string>");
    }

    // Namespace devgui
    // Params 5, eflags: 0x1 linked
    // Checksum 0x5ceecd41, Offset: 0xe20
    // Size: 0x94
    function function_d2147d9f(root, pid, cmdname, cmdindex, cmddvar) {
        adddebugcommand(root + cmdname + "<unknown string>" + "<unknown string>" + "<unknown string>" + pid + "<unknown string>" + "<unknown string>" + "<unknown string>" + cmddvar + "<unknown string>");
    }

    // Namespace devgui
    // Params 3, eflags: 0x1 linked
    // Checksum 0x26cfe2ce, Offset: 0xec0
    // Size: 0x10c
    function devgui_handle_player_command(cmd, playercallback, pcb_param) {
        pid = getdvarint("<unknown string>");
        if (pid > 0) {
            player = getplayers()[pid - 1];
            if (isdefined(player)) {
                if (isdefined(pcb_param)) {
                    player thread [[ playercallback ]](pcb_param);
                } else {
                    player thread [[ playercallback ]]();
                }
            }
        } else {
            array::thread_all(getplayers(), playercallback, pcb_param);
        }
        setdvar("<unknown string>", "<unknown string>");
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf24b2b68, Offset: 0xfd8
    // Size: 0x7a8
    function devgui_think() {
        for (;;) {
            cmd = getdvarstring("<unknown string>");
            if (cmd == "<unknown string>") {
                wait(0.05);
                continue;
            }
            switch (cmd) {
            case 8:
                devgui_handle_player_command(cmd, &function_2612a7ee);
                break;
            case 8:
                devgui_handle_player_command(cmd, &devgui_toggle_ammo);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_f1e00eaf);
                break;
            case 8:
                devgui_handle_player_command(cmd, &devgui_invulnerable, 1);
                break;
            case 8:
                devgui_handle_player_command(cmd, &devgui_invulnerable, 0);
                break;
            case 8:
                devgui_handle_player_command(cmd, &devgui_kill);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_70cef21d);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_32101c84);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_cac73614, 100);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_cac73614, 1000);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_9f78d70e, 100);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_9f78d70e, 1000);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_d7b26538);
            case 8:
                devgui_handle_player_command(cmd, &function_fcd3cf3f);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_192ef5eb);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_b79fb0fe, 0);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_b79fb0fe, 1);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_b79fb0fe, 2);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_b79fb0fe, 3);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_b79fb0fe, 4);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_b79fb0fe, 5);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_b79fb0fe, 6);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_b79fb0fe, 7);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_b79fb0fe, 8);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_b79fb0fe, 9);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_b79fb0fe, 10);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_f61fdbaf);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_408729cd);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_4edb34ed);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_4533d882);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_cac73614, 1000000);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_e2643869);
                break;
            case 8:
                devgui_handle_player_command(cmd, &function_9c35ef50, "<unknown string>");
            case 8:
                break;
            default:
                if (isdefined(level.custom_devgui)) {
                    if (isarray(level.custom_devgui)) {
                        foreach (devgui in level.custom_devgui) {
                            if (isdefined([[ devgui ]](cmd)) && [[ devgui ]](cmd)) {
                                break;
                            }
                        }
                    } else {
                        [[ level.custom_devgui ]](cmd);
                    }
                }
                break;
            }
            setdvar("<unknown string>", "<unknown string>");
            wait(0.5);
        }
    }

    // Namespace devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x925fbe7c, Offset: 0x1788
    // Size: 0x2c
    function function_9c35ef50(stat_name) {
        self challenges::function_96ed590f(stat_name, 50);
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc82906ba, Offset: 0x17c0
    // Size: 0xe2
    function function_e2643869() {
        var_c02de660 = skipto::function_23eda99c();
        foreach (mission in var_c02de660) {
            self addplayerstat("<unknown string>" + getsubstr(getmissionname(mission), 0, 3), 1);
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa800f7e8, Offset: 0x18b0
    // Size: 0x6e
    function function_4533d882() {
                for (itemindex = 1; itemindex < 76; itemindex++) {
            self setdstat("<unknown string>", itemindex, "<unknown string>", "<unknown string>", "<unknown string>", 999);
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2abeb0f6, Offset: 0x1928
    // Size: 0x66
    function function_4edb34ed() {
                for (itemindex = 1; itemindex < 76; itemindex++) {
            self setdstat("<unknown string>", itemindex, "<unknown string>", 1000000);
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x16e5afec, Offset: 0x1998
    // Size: 0xca
    function function_408729cd() {
        if (!isdefined(getrootmapname())) {
            return;
        }
        foreach (mission in skipto::function_23eda99c()) {
            self setdstat("<unknown string>", mission, "<unknown string>", 4, 1);
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0xec45da43, Offset: 0x1a70
    // Size: 0xcc
    function function_192ef5eb() {
        if (isdefined(self.var_f0080358) && self.var_f0080358) {
            self closeluimenu(self.var_f0080358);
        }
        self.var_f0080358 = self openluimenu("<unknown string>");
        menu, response = self waittill(#"menuresponse");
        while (response != "<unknown string>") {
            menu, response = self waittill(#"menuresponse");
        }
        self closeluimenu(self.var_f0080358);
    }

    // Namespace devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x30b2578e, Offset: 0x1b48
    // Size: 0x74
    function function_b79fb0fe(var_b931f6fe) {
        a_decorations = self getdecorations();
        self givedecoration(a_decorations[var_b931f6fe].name);
        uploadstats(self);
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x25b6ffaa, Offset: 0x1bc8
    // Size: 0xc2
    function function_f61fdbaf() {
        var_c02de660 = skipto::function_23eda99c();
        foreach (mission_name in var_c02de660) {
            self setdstat("<unknown string>", mission_name, "<unknown string>", 1);
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9756e50f, Offset: 0x1c98
    // Size: 0xec
    function function_d7b26538() {
        var_c02de660 = skipto::function_23eda99c();
        foreach (mission in var_c02de660) {
            for (i = 0; i < 10; i++) {
                self setdstat("<unknown string>", mission, "<unknown string>", i, 1);
            }
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc919a945, Offset: 0x1d90
    // Size: 0xc2
    function function_fcd3cf3f() {
        var_c02de660 = skipto::function_23eda99c();
        foreach (mission_name in var_c02de660) {
            self setdstat("<unknown string>", mission_name, "<unknown string>", 1);
        }
    }

    // Namespace devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2ce7e4a4, Offset: 0x1e60
    // Size: 0x74
    function function_cac73614(var_735c65d7) {
        /#
            assert(isdefined(self));
        #/
        /#
            assert(isplayer(self));
        #/
        self addrankxpvalue("<unknown string>", var_735c65d7);
    }

    // Namespace devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9b374b38, Offset: 0x1ee0
    // Size: 0x114
    function function_9f78d70e(var_735c65d7) {
        /#
            assert(isdefined(self));
        #/
        /#
            assert(isplayer(self));
        #/
        var_7d65157 = int(tablelookup("<unknown string>", 3, self.currentweapon.rootweapon.displayname, 0));
        var_b51b0d94 = self getdstat("<unknown string>", var_7d65157, "<unknown string>");
        self setdstat("<unknown string>", var_7d65157, "<unknown string>", var_735c65d7 + var_b51b0d94);
    }

    // Namespace devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0xcd32baf, Offset: 0x2000
    // Size: 0x44
    function devgui_invulnerable(onoff) {
        if (onoff) {
            self enableinvulnerability();
            return;
        }
        self disableinvulnerability();
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd5803204, Offset: 0x2050
    // Size: 0xfc
    function devgui_kill() {
        /#
            assert(isdefined(self));
        #/
        /#
            assert(isplayer(self));
        #/
        if (isalive(self)) {
            self disableinvulnerability();
            death_from = (randomfloatrange(-20, 20), randomfloatrange(-20, 20), randomfloatrange(-20, 20));
            self dodamage(self.health + 666, self.origin + death_from);
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6a46ad73, Offset: 0x2158
    // Size: 0x156
    function devgui_toggle_ammo() {
        /#
            assert(isdefined(self));
        #/
        /#
            assert(isplayer(self));
        #/
        /#
            assert(isalive(self));
        #/
        self notify(#"devgui_toggle_ammo");
        self endon(#"devgui_toggle_ammo");
        self.ammo4evah = !(isdefined(self.ammo4evah) && self.ammo4evah);
        while (isdefined(self) && self.ammo4evah) {
            weapon = self getcurrentweapon();
            if (weapon != level.weaponnone) {
                self setweaponoverheating(0, 0);
                max = weapon.maxammo;
                if (isdefined(max)) {
                    self setweaponammostock(weapon, max);
                }
            }
            wait(1);
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4e997271, Offset: 0x22b8
    // Size: 0x84
    function function_f1e00eaf() {
        /#
            assert(isdefined(self));
        #/
        /#
            assert(isplayer(self));
        #/
        /#
            assert(isalive(self));
        #/
        self.ignoreme = !self.ignoreme;
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3472d07b, Offset: 0x2348
    // Size: 0x84
    function function_32101c84() {
        /#
            assert(isdefined(self));
        #/
        /#
            assert(isplayer(self));
        #/
        /#
            assert(isalive(self));
        #/
        self.var_6c733586 = !self.var_6c733586;
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6d39044c, Offset: 0x23d8
    // Size: 0x13e
    function function_70cef21d() {
        /#
            assert(isdefined(self));
        #/
        /#
            assert(isplayer(self));
        #/
        /#
            assert(isalive(self));
        #/
        self reviveplayer();
        if (isdefined(self.revivetrigger)) {
            self.revivetrigger delete();
            self.revivetrigger = undefined;
        }
        self laststand::function_4a66f284();
        self laststand::laststand_enable_player_weapons();
        self allowjump(1);
        self.ignoreme = 0;
        self disableinvulnerability();
        self.laststand = undefined;
        self notify(#"player_revived", self);
    }

    // Namespace devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf0e202d3, Offset: 0x2520
    // Size: 0x64
    function function_ec2ac25f(maxhealth) {
        self endon(#"disconnect");
        self endon(#"hash_2612a7ee");
        while (true) {
            wait(1);
            if (self.maxhealth != maxhealth) {
                self.maxhealth = maxhealth;
                self.health = self.maxhealth;
            }
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x539c5ef2, Offset: 0x2590
    // Size: 0xfc
    function function_2612a7ee() {
        /#
            assert(isdefined(self));
        #/
        /#
            assert(isplayer(self));
        #/
        /#
            assert(isalive(self));
        #/
        self notify(#"hash_2612a7ee");
        if (self.maxhealth >= 2000 && isdefined(self.var_1bcb5997)) {
            self.maxhealth = self.var_1bcb5997;
        } else {
            self.var_1bcb5997 = self.maxhealth;
            self.maxhealth = 2000;
            self thread function_ec2ac25f(self.maxhealth);
        }
        self.health = self.maxhealth;
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x290f738b, Offset: 0x2698
    // Size: 0x518
    function devgui_player_weapons() {
        if (isdefined(game["<unknown string>"]) && game["<unknown string>"]) {
            return;
        }
        level flag::wait_till("<unknown string>");
        wait(0.1);
        a_weapons = enumerateweapons("<unknown string>");
        var_f021b516 = [];
        var_f66252b6 = [];
        var_439d85 = [];
        for (i = 0; i < a_weapons.size; i++) {
            if (weapons::is_primary_weapon(a_weapons[i]) || weapons::is_side_arm(a_weapons[i])) {
                arrayinsert(var_f021b516, a_weapons[i], 0);
                continue;
            }
            if (weapons::is_grenade(a_weapons[i])) {
                arrayinsert(var_f66252b6, a_weapons[i], 0);
                continue;
            }
            arrayinsert(var_439d85, a_weapons[i], 0);
        }
        var_476218ad = "<unknown string>";
        adddebugcommand(var_476218ad + "<unknown string>" + "<unknown string>" + "<unknown string>" + "<unknown string>");
        adddebugcommand(var_476218ad + "<unknown string>" + "<unknown string>" + "<unknown string>" + "<unknown string>");
        adddebugcommand(var_476218ad + "<unknown string>" + "<unknown string>" + "<unknown string>" + "<unknown string>");
        devgui_add_player_weapons(var_476218ad, "<unknown string>", 0, var_f66252b6, "<unknown string>");
        devgui_add_player_weapons(var_476218ad, "<unknown string>", 0, var_f021b516, "<unknown string>");
        devgui_add_player_weapons(var_476218ad, "<unknown string>", 0, var_439d85, "<unknown string>");
        function_fcadbfcd(var_476218ad, "<unknown string>", 0, var_f021b516, "<unknown string>");
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            ip1 = i + 1;
            adddebugcommand(var_476218ad + players[i].playername + "<unknown string>" + "<unknown string>" + "<unknown string>");
            adddebugcommand(var_476218ad + players[i].playername + "<unknown string>" + "<unknown string>" + "<unknown string>");
            adddebugcommand(var_476218ad + players[i].playername + "<unknown string>" + "<unknown string>" + "<unknown string>");
            devgui_add_player_weapons(var_476218ad, players[i].playername, ip1, var_f66252b6, "<unknown string>");
            devgui_add_player_weapons(var_476218ad, players[i].playername, ip1, var_f021b516, "<unknown string>");
            devgui_add_player_weapons(var_476218ad, players[i].playername, ip1, var_439d85, "<unknown string>");
            function_fcadbfcd(var_476218ad, players[i].playername, ip1, var_f021b516, "<unknown string>");
        }
        game["<unknown string>"] = 1;
    }

    // Namespace devgui
    // Params 5, eflags: 0x1 linked
    // Checksum 0xadb12274, Offset: 0x2bb8
    // Size: 0x222
    function function_fcadbfcd(root, pname, index, a_weapons, weapon_type) {
        player_devgui_root = root + pname + "<unknown string>" + "<unknown string>" + weapon_type + "<unknown string>";
        attachments = [];
        foreach (weapon in a_weapons) {
            foreach (var_fc760a22 in weapon.supportedattachments) {
                array::add(attachments, var_fc760a22, 0);
            }
        }
        pid = "<unknown string>" + index;
        foreach (att in attachments) {
            function_2e546d79(player_devgui_root, pid, att, 1);
        }
    }

    // Namespace devgui
    // Params 5, eflags: 0x1 linked
    // Checksum 0xbf1495a4, Offset: 0x2de8
    // Size: 0x24e
    function devgui_add_player_weapons(root, pname, index, a_weapons, weapon_type) {
        player_devgui_root = root + pname + "<unknown string>" + "<unknown string>" + weapon_type + "<unknown string>";
        pid = "<unknown string>" + index;
        if (isdefined(a_weapons)) {
            for (i = 0; i < a_weapons.size; i++) {
                if (weapon_type == "<unknown string>") {
                    attachments = [];
                } else {
                    attachments = a_weapons[i].supportedattachments;
                }
                name = a_weapons[i].name;
                if (attachments.size) {
                    devgui_add_player_weap_command(player_devgui_root + name + "<unknown string>", pid, name, i + 1);
                    foreach (att in attachments) {
                        if (att != "<unknown string>") {
                            devgui_add_player_weap_command(player_devgui_root + name + "<unknown string>", pid, name + "<unknown string>" + att, i + 1);
                        }
                    }
                } else {
                    devgui_add_player_weap_command(player_devgui_root, pid, name, i + 1);
                }
                wait(0.05);
            }
        }
    }

    // Namespace devgui
    // Params 4, eflags: 0x1 linked
    // Checksum 0x2e75d6e, Offset: 0x3040
    // Size: 0x8c
    function devgui_add_player_weap_command(root, pid, weap_name, cmdindex) {
        adddebugcommand(root + weap_name + "<unknown string>" + "<unknown string>" + "<unknown string>" + pid + "<unknown string>" + "<unknown string>" + "<unknown string>" + weap_name + "<unknown string>");
    }

    // Namespace devgui
    // Params 4, eflags: 0x1 linked
    // Checksum 0x65801849, Offset: 0x30d8
    // Size: 0x8c
    function function_2e546d79(root, pid, var_ea9ecd24, cmdindex) {
        adddebugcommand(root + var_ea9ecd24 + "<unknown string>" + "<unknown string>" + "<unknown string>" + pid + "<unknown string>" + "<unknown string>" + "<unknown string>" + var_ea9ecd24 + "<unknown string>");
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x11a6e8f8, Offset: 0x3170
    // Size: 0x108
    function devgui_weapon_think() {
        for (;;) {
            weapon_name = getdvarstring("<unknown string>");
            if (weapon_name != "<unknown string>") {
                devgui_handle_player_command(weapon_name, &devgui_give_weapon, weapon_name);
                setdvar("<unknown string>", "<unknown string>");
            }
            attachmentname = getdvarstring("<unknown string>");
            if (attachmentname != "<unknown string>") {
                devgui_handle_player_command(attachmentname, &function_1734411b, attachmentname);
                setdvar("<unknown string>", "<unknown string>");
            }
            wait(0.5);
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x76befb20, Offset: 0x3280
    // Size: 0x3e0
    function devgui_weapon_asset_name_display_think() {
        update_time = 0.5;
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
            wait(update_time);
            display = getdvarint("<unknown string>");
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
                print3d(player gettagorigin("<unknown string>"), weapon.name, colors[color_index], 1, 0.15, print_duration);
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
                print3d(ai gettagorigin("<unknown string>"), weapon.name, colors[color_index], 1, 0.15, print_duration);
                color_index++;
                if (color_index >= colors.size) {
                    color_index = 0;
                }
            }
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9149a16c, Offset: 0x3668
    // Size: 0x20c
    function devgui_test_chart_think() {
        wait(0.05);
        old_val = getdvarint("<unknown string>");
        for (;;) {
            val = getdvarint("<unknown string>");
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
                    level.test_chart_model = spawn("<unknown string>", player geteye() + direction_vec);
                    level.test_chart_model setmodel("<unknown string>");
                    level.test_chart_model.angles = (0, direction[1], 0) + (0, 90, 0);
                }
            }
            old_val = val;
            wait(0.05);
        }
    }

    // Namespace devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe77ae077, Offset: 0x3880
    // Size: 0x324
    function devgui_give_weapon(weapon_name) {
        /#
            assert(isdefined(self));
        #/
        /#
            assert(isplayer(self));
        #/
        /#
            assert(isalive(self));
        #/
        self notify(#"devgui_give_ammo");
        self endon(#"devgui_give_ammo");
        currentweapon = self getcurrentweapon();
        split = strtok(weapon_name, "<unknown string>");
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
            if (getdvarint("<unknown string>")) {
                adddebugcommand("<unknown string>" + weapon_name);
                wait(0.05);
            } else {
                self takeweapon(currentweapon);
                self giveweapon(weapon);
                self switchtoweapon(weapon);
            }
            max = weapon.maxammo;
            if (max) {
                self setweaponammostock(weapon, max);
            }
        }
    }

    // Namespace devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x500d3027, Offset: 0x3bb0
    // Size: 0x46c
    function function_1734411b(var_ea9ecd24) {
        /#
            assert(isdefined(self));
        #/
        /#
            assert(isplayer(self));
        #/
        /#
            assert(isalive(self));
        #/
        self notify(#"hash_1734411b");
        self endon(#"hash_1734411b");
        currentweapon = self getcurrentweapon();
        var_2ee2f0c0 = 0;
        split = strtok(currentweapon.name, "<unknown string>");
        foreach (attachment in currentweapon.supportedattachments) {
            if (attachment == var_ea9ecd24) {
                var_2ee2f0c0 = 1;
            }
        }
        if (var_2ee2f0c0 == 0) {
            iprintlnbold("<unknown string>" + var_ea9ecd24 + "<unknown string>" + split[0]);
            attachmentsstring = "<unknown string>";
            if (currentweapon.supportedattachments.size == 0) {
                attachmentsstring += "<unknown string>";
            }
            foreach (attachment in currentweapon.supportedattachments) {
                attachmentsstring += "<unknown string>" + attachment;
            }
            iprintlnbold(attachmentsstring);
            return;
        }
        foreach (currentattachment in split) {
            if (currentattachment == var_ea9ecd24) {
                iprintlnbold("<unknown string>" + var_ea9ecd24 + "<unknown string>" + currentweapon.name);
                return;
            }
        }
        split[split.size] = var_ea9ecd24;
        for (index = split.size; index < 9; index++) {
            split[index] = "<unknown string>";
        }
        self takeweapon(currentweapon);
        newweapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5], split[6], split[7], split[8]);
        self giveweapon(newweapon);
        self switchtoweapon(newweapon);
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x40452b25, Offset: 0x4028
    // Size: 0x12c
    function init_debug_center_screen() {
        zero_idle_movement = "<unknown string>";
        for (;;) {
            if (getdvarint("<unknown string>")) {
                if (!isdefined(level.center_screen_debug_hudelem_active) || level.center_screen_debug_hudelem_active == 0) {
                    thread debug_center_screen();
                    zero_idle_movement = getdvarstring("<unknown string>");
                    if (isdefined(zero_idle_movement) && zero_idle_movement == "<unknown string>") {
                        setdvar("<unknown string>", "<unknown string>");
                        zero_idle_movement = "<unknown string>";
                    }
                }
            } else {
                level notify(#"hash_8e42baed");
                if (zero_idle_movement == "<unknown string>") {
                    setdvar("<unknown string>", "<unknown string>");
                    zero_idle_movement = "<unknown string>";
                }
            }
            wait(0.05);
        }
    }

    // Namespace devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x13c6fc57, Offset: 0x4160
    // Size: 0x228
    function debug_center_screen() {
        level.center_screen_debug_hudelem_active = 1;
        wait(0.1);
        level.center_screen_debug_hudelem1 = newclienthudelem(level.players[0]);
        level.center_screen_debug_hudelem1.alignx = "<unknown string>";
        level.center_screen_debug_hudelem1.aligny = "<unknown string>";
        level.center_screen_debug_hudelem1.fontscale = 1;
        level.center_screen_debug_hudelem1.alpha = 0.5;
        level.center_screen_debug_hudelem1.x = 320 - 1;
        level.center_screen_debug_hudelem1.y = 240;
        level.center_screen_debug_hudelem1 setshader("<unknown string>", 1000, 1);
        level.center_screen_debug_hudelem2 = newclienthudelem(level.players[0]);
        level.center_screen_debug_hudelem2.alignx = "<unknown string>";
        level.center_screen_debug_hudelem2.aligny = "<unknown string>";
        level.center_screen_debug_hudelem2.fontscale = 1;
        level.center_screen_debug_hudelem2.alpha = 0.5;
        level.center_screen_debug_hudelem2.x = 320 - 1;
        level.center_screen_debug_hudelem2.y = 240;
        level.center_screen_debug_hudelem2 setshader("<unknown string>", 1, 480);
        level waittill(#"hash_8e42baed");
        level.center_screen_debug_hudelem1 destroy();
        level.center_screen_debug_hudelem2 destroy();
        level.center_screen_debug_hudelem_active = 0;
    }

#/
