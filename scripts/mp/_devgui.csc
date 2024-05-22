#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace mp_devgui;

// Namespace mp_devgui
// Params 0, eflags: 0x2
// Checksum 0x9457f723, Offset: 0xd8
// Size: 0x34
function function_2dc19561() {
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
                adddebugcommand(localclientnum, "<unknown string>");
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
        wait(0.05);
        if (false) {
            return;
        }
        frontend_slots = 4;
        for (slot = 0; slot < frontend_slots; slot++) {
            add_contract_slot(localclientnum, slot);
            wait(0.1);
        }
        wait(0.1);
        add_blackjack_contract(localclientnum);
        wait(0.1);
        add_devgui_scheduler(localclientnum);
        level thread watch_devgui();
        level.mp_contracts_devgui_added = 1;
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa22a1402, Offset: 0x298
    // Size: 0x476
    function add_blackjack_contract(localclientnum) {
        root = "<unknown string>";
        next_cmd = "<unknown string>";
        add_blackjack_contract_set_count(localclientnum, root, 0);
        add_blackjack_contract_set_count(localclientnum, root, 1);
        add_blackjack_contract_set_count(localclientnum, root, 5);
        add_blackjack_contract_set_count(localclientnum, root, 10);
        add_blackjack_contract_set_count(localclientnum, root, -56);
        add_blackjack_contract_set_count(localclientnum, root, 3420);
        root = "<unknown string>";
        stat_write = "<unknown string>";
        set_blackjack = "<unknown string>";
        cmds = stat_write + "<unknown string>";
        add_devgui_cmd(localclientnum, root + "<unknown string>", cmds);
        cmds = stat_write + "<unknown string>";
        cmds += next_cmd;
        cmds += stat_write + "<unknown string>";
        cmds += next_cmd;
        cmds += set_blackjack + "<unknown string>";
        cmds += next_cmd;
        cmds += set_blackjack + "<unknown string>";
        add_devgui_cmd(localclientnum, root + "<unknown string>", cmds);
        cmds = stat_write + "<unknown string>";
        add_devgui_cmd(localclientnum, root + "<unknown string>", cmds);
        cmds = stat_write + "<unknown string>";
        cmds += next_cmd;
        cmds += stat_write + "<unknown string>";
        cmds += next_cmd;
        cmds += set_blackjack + "<unknown string>";
        cmds += next_cmd;
        cmds += set_blackjack + "<unknown string>";
        add_devgui_cmd(localclientnum, root + "<unknown string>", cmds);
        side_bet_root = "<unknown string>";
        stat_write_bjc = "<unknown string>";
        stat_write_bjc_master = "<unknown string>";
        for (i = 0; i <= 6; i++) {
            cmds = stat_write_bjc + "<unknown string>" + i;
            cmds += next_cmd;
            cmds += stat_write_bjc + "<unknown string>" + i;
            cmds += next_cmd;
            cmds += stat_write_bjc_master + "<unknown string>" + (i == 6 ? 1 : 0);
            cmds += next_cmd;
            cmds += stat_write_bjc_master + "<unknown string>" + (i == 6 ? 1 : 0);
            add_devgui_cmd(localclientnum, side_bet_root + "<unknown string>" + i, cmds);
        }
    }

    // Namespace mp_devgui
    // Params 3, eflags: 0x1 linked
    // Checksum 0x9654f7fe, Offset: 0x718
    // Size: 0xac
    function add_blackjack_contract_set_count(localclientnum, root, contract_count) {
        cmds = "<unknown string>" + contract_count;
        item_text = contract_count == 1 ? "<unknown string>" : "<unknown string>";
        add_devgui_cmd(localclientnum, root + "<unknown string>" + contract_count + item_text + "<unknown string>" + contract_count, cmds);
    }

    // Namespace mp_devgui
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3cf3f061, Offset: 0x7d0
    // Size: 0x74c
    function add_contract_slot(localclientnum, slot) {
        root = "<unknown string>" + slot;
        add_weekly = 1;
        add_daily = 1;
        add_special = 0;
        switch (slot) {
        case 0:
            root += "<unknown string>";
            add_daily = 0;
            break;
        case 1:
            root += "<unknown string>";
            add_daily = 0;
            break;
        case 2:
            root += "<unknown string>";
            add_weekly = 0;
            break;
        case 3:
            root += "<unknown string>";
            add_daily = 0;
            add_weekly = 0;
            add_special = 1;
            break;
        default:
            root += "<unknown string>";
            break;
        }
        root += "<unknown string>" + slot + "<unknown string>";
        table = "<unknown string>";
        num_rows = tablelookuprowcount(table);
        stat_write = "<unknown string>" + slot;
        next_cmd = "<unknown string>";
        max_title_width = 30;
        ellipsis = "<unknown string>";
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
                title = makelocalizedstring("<unknown string>" + title_str);
                if (title.size > max_title_width) {
                    title = getsubstr(title, 0, truncated_title_end_index) + ellipsis;
                }
                submenu_name = title + "<unknown string>" + table_index + "<unknown string>";
                if (var_a8c2111c) {
                    challenge_type = "<unknown string>";
                } else {
                    challenge_type = is_weekly_index ? "<unknown string>" : "<unknown string>";
                }
                cmds = stat_write + "<unknown string>" + table_index;
                cmds += next_cmd;
                cmds += stat_write + "<unknown string>";
                cmds += next_cmd;
                cmds += stat_write + "<unknown string>";
                cmds += next_cmd;
                cmds += stat_write + "<unknown string>";
                cmds += next_cmd;
                cmds += "<unknown string>";
                cmds = wrap_dvarconfig_cmds(cmds);
                if (add_special) {
                    by_index_name = "<unknown string>";
                } else if (add_daily && add_weekly) {
                    by_index_name = "<unknown string>";
                } else if (add_daily) {
                    by_index_name = "<unknown string>";
                } else if (add_weekly) {
                    by_index_name = "<unknown string>";
                } else {
                    by_index_name = "<unknown string>";
                }
                index_submenu_name = submenu_name + "<unknown string>" + table_index;
                add_devgui_cmd(localclientnum, root + challenge_type + submenu_name, cmds);
                add_devgui_cmd(localclientnum, root + by_index_name + index_submenu_name, cmds);
                cmds_added++;
                if (cmds_added >= max_cmd_to_add) {
                    wait(0.1);
                    cmds_added = 0;
                }
            }
        }
        if (slot == 3) {
            cmds = stat_write + "<unknown string>";
            cmds += next_cmd;
            cmds += stat_write + "<unknown string>";
            add_devgui_cmd(localclientnum, root + "<unknown string>", cmds);
        }
        cmds = stat_write + "<unknown string>";
        cmds += next_cmd;
        cmds += stat_write + "<unknown string>";
        add_devgui_cmd(localclientnum, root + "<unknown string>", cmds);
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8074706, Offset: 0xf28
    // Size: 0x2c4
    function add_devgui_scheduler(localclientnum) {
        root = "<unknown string>";
        root_daily = root + "<unknown string>";
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<unknown string>", 86400);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<unknown string>", 1);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<unknown string>", 3);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<unknown string>", 10);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<unknown string>", 60);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<unknown string>", 120);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<unknown string>", 600);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<unknown string>", 1800);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<unknown string>", 3600);
        cmds = "<unknown string>";
        add_watched_devgui_cmd(localclientnum, root + "<unknown string>", cmds);
        cmds = "<unknown string>";
        add_watched_devgui_cmd(localclientnum, root + "<unknown string>", cmds);
        cmds = "<unknown string>";
        add_watched_devgui_cmd(localclientnum, root + "<unknown string>", cmds);
        cmds = "<unknown string>";
        add_watched_devgui_cmd(localclientnum, root + "<unknown string>", cmds);
        cmds = "<unknown string>";
        add_watched_devgui_cmd(localclientnum, root + "<unknown string>", cmds);
    }

    // Namespace mp_devgui
    // Params 3, eflags: 0x1 linked
    // Checksum 0xe607ca0a, Offset: 0x11f8
    // Size: 0x74
    function add_watched_devgui_cmd(localclientnum, root, cmds) {
        next_cmd = "<unknown string>";
        cmds += next_cmd;
        cmds += "<unknown string>";
        add_devgui_cmd(localclientnum, root, cmds);
    }

    // Namespace mp_devgui
    // Params 4, eflags: 0x1 linked
    // Checksum 0xd2411b73, Offset: 0x1278
    // Size: 0xbc
    function add_contract_scheduler_daily_duration(localclientnum, root, label, daily_duration) {
        next_cmd = "<unknown string>";
        cmds = "<unknown string>" + daily_duration;
        cmds += next_cmd;
        cmds += "<unknown string>";
        cmds = wrap_dvarconfig_cmds(cmds);
        add_devgui_cmd(localclientnum, root + label, cmds);
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc954fa29, Offset: 0x1340
    // Size: 0x5e
    function wrap_dvarconfig_cmds(cmds) {
        next_cmd = "<unknown string>";
        newcmds = "<unknown string>";
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
            adddebugcommand(localclientnum, "<unknown string>" + menu_path + "<unknown string>" + cmds + "<unknown string>");
        #/
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3827e69a, Offset: 0x1418
    // Size: 0xe4
    function calculate_schedule_start_time(ref_time) {
        new_start_time = ref_time;
        daily_duration = getdvarint("<unknown string>", 60);
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
            wait(0.1);
            if (!dvar_has_value("<unknown string>")) {
                continue;
            }
            saved_dvarconfigenabled = getdvarint("<unknown string>", 1);
            if (dvar_has_value("<unknown string>")) {
                setdvar("<unknown string>", 0);
                now = getutc();
                setdvar("<unknown string>", calculate_schedule_start_time(now));
                clear_dvar("<unknown string>");
            }
            if (dvar_has_value("<unknown string>")) {
                update_contract_start_time(-1);
                clear_dvar("<unknown string>");
            }
            if (dvar_has_value("<unknown string>")) {
                update_contract_start_time(-7);
                clear_dvar("<unknown string>");
            }
            if (dvar_has_value("<unknown string>")) {
                update_contract_start_time(1);
                clear_dvar("<unknown string>");
            }
            if (dvar_has_value("<unknown string>")) {
                update_contract_start_time(7);
                clear_dvar("<unknown string>");
            }
            if (saved_dvarconfigenabled != getdvarint("<unknown string>", 1)) {
                setdvar("<unknown string>", saved_dvarconfigenabled);
            }
            clear_dvar("<unknown string>");
        }
    }

    // Namespace mp_devgui
    // Params 1, eflags: 0x1 linked
    // Checksum 0x69a3bf23, Offset: 0x17a8
    // Size: 0x9c
    function update_contract_start_time(delta_days) {
        setdvar("<unknown string>", 0);
        start_time = get_schedule_start_time();
        daily_duration = getdvarint("<unknown string>", 60);
        setdvar("<unknown string>", start_time + daily_duration * delta_days);
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
        return getdvarint("<unknown string>", 1463418000);
    }

#/
