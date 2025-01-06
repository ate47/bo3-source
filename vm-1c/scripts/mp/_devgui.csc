#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace mp_devgui;

// Namespace mp_devgui
// Params 0, eflags: 0x2
// Checksum 0x9457f723, Offset: 0xd8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("mp_devgui", &__init__, undefined, undefined);
}

// Namespace mp_devgui
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x118
// Size: 0x4
function __init__() {
    
}

/#

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0xdbba9d9c, Offset: 0x128
    // Size: 0x4e
    function remove_mp_contracts_devgui(localclientnum) {
        if (level.mp_contracts_devgui_added === 1) {
            /#
                adddebugcommand(localclientnum, "<dev string:x28>");
            #/
            level.mp_contracts_devgui_added = undefined;
        }
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2e67b32e, Offset: 0x180
    // Size: 0x110
    function create_mp_contracts_devgui(localclientnum) {
        level notify(#"create_mp_contracts_devgui_singleton");
        level endon(#"create_mp_contracts_devgui_singleton");
        remove_mp_contracts_devgui(localclientnum);
        wait 0.05;
        if (false) {
            return;
        }
        frontend_slots = 4;
        for (slot = 0; slot < frontend_slots; slot++) {
            add_contract_slot(localclientnum, slot);
            wait 0.1;
        }
        wait 0.1;
        add_blackjack_contract(localclientnum);
        wait 0.1;
        add_devgui_scheduler(localclientnum);
        level thread watch_devgui();
        level.mp_contracts_devgui_added = 1;
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa22a1402, Offset: 0x298
    // Size: 0x476
    function add_blackjack_contract(localclientnum) {
        root = "<dev string:x46>";
        next_cmd = "<dev string:x6d>";
        add_blackjack_contract_set_count(localclientnum, root, 0);
        add_blackjack_contract_set_count(localclientnum, root, 1);
        add_blackjack_contract_set_count(localclientnum, root, 5);
        add_blackjack_contract_set_count(localclientnum, root, 10);
        add_blackjack_contract_set_count(localclientnum, root, -56);
        add_blackjack_contract_set_count(localclientnum, root, 3420);
        root = "<dev string:x70>";
        stat_write = "<dev string:x91>";
        set_blackjack = "<dev string:xb7>";
        cmds = stat_write + "<dev string:xd1>";
        add_devgui_cmd(localclientnum, root + "<dev string:xda>", cmds);
        cmds = stat_write + "<dev string:xd1>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:xe5>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:xfb>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x106>";
        add_devgui_cmd(localclientnum, root + "<dev string:x113>", cmds);
        cmds = stat_write + "<dev string:x128>";
        add_devgui_cmd(localclientnum, root + "<dev string:x131>", cmds);
        cmds = stat_write + "<dev string:x128>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:xe5>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x13e>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x106>";
        add_devgui_cmd(localclientnum, root + "<dev string:x14c>", cmds);
        side_bet_root = "<dev string:x163>";
        stat_write_bjc = "<dev string:x18e>";
        stat_write_bjc_master = "<dev string:x1c0>";
        for (i = 0; i <= 6; i++) {
            cmds = stat_write_bjc + "<dev string:x1f5>" + i;
            cmds += next_cmd;
            cmds += stat_write_bjc + "<dev string:x200>" + i;
            cmds += next_cmd;
            cmds += stat_write_bjc_master + "<dev string:x1f5>" + (i == 6 ? 1 : 0);
            cmds += next_cmd;
            cmds += stat_write_bjc_master + "<dev string:x200>" + (i == 6 ? 1 : 0);
            add_devgui_cmd(localclientnum, side_bet_root + "<dev string:x210>" + i, cmds);
        }
    }

    // Namespace mp_devgui
    // Params 3, eflags: 0x1 linked
    // Checksum 0x9654f7fe, Offset: 0x718
    // Size: 0xac
    function add_blackjack_contract_set_count(localclientnum, root, contract_count) {
        cmds = "<dev string:x21d>" + contract_count;
        item_text = contract_count == 1 ? "<dev string:x244>" : "<dev string:x24e>";
        add_devgui_cmd(localclientnum, root + "<dev string:x259>" + contract_count + item_text + "<dev string:x25e>" + contract_count, cmds);
    }

    // Namespace mp_devgui
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3cf3f061, Offset: 0x7d0
    // Size: 0x74c
    function add_contract_slot(localclientnum, slot) {
        root = "<dev string:x260>" + slot;
        add_weekly = 1;
        add_daily = 1;
        add_special = 0;
        switch (slot) {
        case 0:
            root += "<dev string:x27a>";
            add_daily = 0;
            break;
        case 1:
            root += "<dev string:x286>";
            add_daily = 0;
            break;
        case 2:
            root += "<dev string:x292>";
            add_weekly = 0;
            break;
        case 3:
            root += "<dev string:x29b>";
            add_daily = 0;
            add_weekly = 0;
            add_special = 1;
            break;
        default:
            root += "<dev string:x2a6>";
            break;
        }
        root += "<dev string:x25e>" + slot + "<dev string:x2b4>";
        table = "<dev string:x2b6>";
        num_rows = tablelookuprowcount(table);
        stat_write = "<dev string:x2de>" + slot;
        next_cmd = "<dev string:x6d>";
        max_title_width = 30;
        ellipsis = "<dev string:x2f6>";
        truncated_title_end_index = max_title_width - ellipsis.size - 1;
        cmds_added = 0;
        max_cmd_to_add = 5;
        for (row = 1; row < num_rows; row++) {
            row_info = tablelookuprow(table, row);
            if (strisnumber(row_info[0])) {
                table_index = int(row_info[0]);
                is_daily_index = table_index >= 1000 && table_index <= 2999;
                is_weekly_index = table_index >= 1 && table_index <= 999;
                var_a8c2111c = table_index >= 3000 && table_index <= 3999;
                if (is_daily_index && !add_daily) {
                    continue;
                }
                if (is_weekly_index && !add_weekly) {
                    continue;
                }
                if (var_a8c2111c && !add_special) {
                    continue;
                }
                title_str = row_info[4].size > 0 ? row_info[4] : row_info[3];
                title = makelocalizedstring("<dev string:x2fa>" + title_str);
                if (title.size > max_title_width) {
                    title = getsubstr(title, 0, truncated_title_end_index) + ellipsis;
                }
                submenu_name = title + "<dev string:x304>" + table_index + "<dev string:x307>";
                if (var_a8c2111c) {
                    challenge_type = "<dev string:x309>";
                } else {
                    challenge_type = is_weekly_index ? "<dev string:x31c>" : "<dev string:x32e>";
                }
                cmds = stat_write + "<dev string:x33f>" + table_index;
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x347>";
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x353>";
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x35d>";
                cmds += next_cmd;
                cmds += "<dev string:x36c>";
                cmds = wrap_dvarconfig_cmds(cmds);
                if (add_special) {
                    by_index_name = "<dev string:x38d>";
                } else if (add_daily && add_weekly) {
                    by_index_name = "<dev string:x3a7>";
                } else if (add_daily) {
                    by_index_name = "<dev string:x3bd>";
                } else if (add_weekly) {
                    by_index_name = "<dev string:x3d5>";
                } else {
                    by_index_name = "<dev string:x3ee>";
                }
                index_submenu_name = submenu_name + "<dev string:x25e>" + table_index;
                add_devgui_cmd(localclientnum, root + challenge_type + submenu_name, cmds);
                add_devgui_cmd(localclientnum, root + by_index_name + index_submenu_name, cmds);
                cmds_added++;
                if (cmds_added >= max_cmd_to_add) {
                    wait 0.1;
                    cmds_added = 0;
                }
            }
        }
        if (slot == 3) {
            cmds = stat_write + "<dev string:x400>";
            cmds += next_cmd;
            cmds += stat_write + "<dev string:x409>";
            add_devgui_cmd(localclientnum, root + "<dev string:x413>", cmds);
        }
        cmds = stat_write + "<dev string:x347>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:x35d>";
        add_devgui_cmd(localclientnum, root + "<dev string:x424>", cmds);
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8074706, Offset: 0xf28
    // Size: 0x2c4
    function add_devgui_scheduler(localclientnum) {
        root = "<dev string:x435>";
        root_daily = root + "<dev string:x455>";
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x46b>", 86400);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x47f>", 1);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x48c>", 3);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x49c>", 10);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x4aa>", 60);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x4b7>", 120);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x4c5>", 600);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x4d3>", 1800);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x4df>", 3600);
        cmds = "<dev string:x4ea>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x50c>", cmds);
        cmds = "<dev string:x51d>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x543>", cmds);
        cmds = "<dev string:x54f>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x574>", cmds);
        cmds = "<dev string:x57f>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x5a4>", cmds);
        cmds = "<dev string:x5b3>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x5d9>", cmds);
    }

    // Namespace mp_devgui
    // Params 3, eflags: 0x1 linked
    // Checksum 0xe607ca0a, Offset: 0x11f8
    // Size: 0x74
    function add_watched_devgui_cmd(localclientnum, root, cmds) {
        next_cmd = "<dev string:x6d>";
        cmds += next_cmd;
        cmds += "<dev string:x5e9>";
        add_devgui_cmd(localclientnum, root, cmds);
    }

    // Namespace mp_devgui
    // Params 4, eflags: 0x1 linked
    // Checksum 0xd2411b73, Offset: 0x1278
    // Size: 0xbc
    function add_contract_scheduler_daily_duration(localclientnum, root, label, daily_duration) {
        next_cmd = "<dev string:x6d>";
        cmds = "<dev string:x60b>" + daily_duration;
        cmds += next_cmd;
        cmds += "<dev string:x629>";
        cmds = wrap_dvarconfig_cmds(cmds);
        add_devgui_cmd(localclientnum, root + label, cmds);
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc954fa29, Offset: 0x1340
    // Size: 0x5e
    function wrap_dvarconfig_cmds(cmds) {
        next_cmd = "<dev string:x6d>";
        newcmds = "<dev string:x64a>";
        newcmds += next_cmd;
        newcmds += cmds;
        return newcmds;
    }

    // Namespace mp_devgui
    // Params 3, eflags: 0x1 linked
    // Checksum 0xb16161d2, Offset: 0x13a8
    // Size: 0x64
    function add_devgui_cmd(localclientnum, menu_path, cmds) {
        /#
            adddebugcommand(localclientnum, "<dev string:x662>" + menu_path + "<dev string:x66f>" + cmds + "<dev string:x673>");
        #/
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3827e69a, Offset: 0x1418
    // Size: 0xe4
    function calculate_schedule_start_time(ref_time) {
        new_start_time = ref_time;
        daily_duration = getdvarint("<dev string:x676>", 60);
        weekly_duration = daily_duration * 7;
        schedule_duration = weekly_duration * 8;
        max_multiple = int(ref_time / schedule_duration);
        half_max_multiple = int(max_multiple / 2);
        new_start_time -= half_max_multiple * schedule_duration;
        return new_start_time;
    }

    // Namespace mp_devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x592be4f0, Offset: 0x1508
    // Size: 0x298
    function watch_devgui() {
        level notify(#"watch_devgui_client_mp_singleton");
        level endon(#"watch_devgui_client_mp_singleton");
        while (true) {
            wait 0.1;
            if (!dvar_has_value("<dev string:x68f>")) {
                continue;
            }
            saved_dvarconfigenabled = getdvarint("<dev string:x6ab>", 1);
            if (dvar_has_value("<dev string:x6bd>")) {
                setdvar("<dev string:x6ab>", 0);
                now = getutc();
                setdvar("<dev string:x6d9>", calculate_schedule_start_time(now));
                clear_dvar("<dev string:x6bd>");
            }
            if (dvar_has_value("<dev string:x6ee>")) {
                update_contract_start_time(-1);
                clear_dvar("<dev string:x6ee>");
            }
            if (dvar_has_value("<dev string:x70d>")) {
                update_contract_start_time(-7);
                clear_dvar("<dev string:x70d>");
            }
            if (dvar_has_value("<dev string:x72d>")) {
                update_contract_start_time(1);
                clear_dvar("<dev string:x72d>");
            }
            if (dvar_has_value("<dev string:x74c>")) {
                update_contract_start_time(7);
                clear_dvar("<dev string:x74c>");
            }
            if (saved_dvarconfigenabled != getdvarint("<dev string:x6ab>", 1)) {
                setdvar("<dev string:x6ab>", saved_dvarconfigenabled);
            }
            clear_dvar("<dev string:x68f>");
        }
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x69a3bf23, Offset: 0x17a8
    // Size: 0x9c
    function update_contract_start_time(delta_days) {
        setdvar("<dev string:x6ab>", 0);
        start_time = get_schedule_start_time();
        daily_duration = getdvarint("<dev string:x676>", 60);
        setdvar("<dev string:x6d9>", start_time + daily_duration * delta_days);
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe52aa471, Offset: 0x1850
    // Size: 0x30
    function dvar_has_value(dvar_name) {
        return getdvarint(dvar_name, 0) != 0;
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x876f9abf, Offset: 0x1888
    // Size: 0x2c
    function clear_dvar(dvar_name) {
        setdvar(dvar_name, 0);
    }

    // Namespace mp_devgui
    // Params 0, eflags: 0x1 linked
    // Checksum 0x305ab4bf, Offset: 0x18c0
    // Size: 0x2c
    function get_schedule_start_time() {
        return getdvarint("<dev string:x6d9>", 1463418000);
    }

#/
