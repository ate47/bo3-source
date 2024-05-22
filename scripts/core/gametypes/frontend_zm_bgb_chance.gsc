#using scripts/shared/util_shared;
#using scripts/shared/table_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_frontend_zm_bgb_chance;

/#

    // Namespace zm_frontend_zm_bgb_chance
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc27953be, Offset: 0x1a8
    // Size: 0x1c
    function zm_frontend_bgb_slots_logic() {
        level thread zm_frontend_bgb_devgui();
    }

    // Namespace zm_frontend_zm_bgb_chance
    // Params 0, eflags: 0x1 linked
    // Checksum 0xaba81fc3, Offset: 0x1d0
    // Size: 0x1bc
    function zm_frontend_bgb_devgui() {
        setdvar("<unknown string>", "<unknown string>");
        setdvar("<unknown string>", "<unknown string>");
        bgb_devgui_base = "<unknown string>";
        a_n_amounts = array(1, 5, 10, 100);
        for (i = 0; i < a_n_amounts.size; i++) {
            n_amount = a_n_amounts[i];
            adddebugcommand(bgb_devgui_base + i + "<unknown string>" + n_amount + "<unknown string>" + n_amount + "<unknown string>");
        }
        adddebugcommand("<unknown string>" + "<unknown string>" + "<unknown string>" + "<unknown string>" + 1 + "<unknown string>");
        adddebugcommand("<unknown string>" + "<unknown string>" + "<unknown string>" + "<unknown string>" + 1 + "<unknown string>");
        level thread bgb_devgui_think();
    }

    // Namespace zm_frontend_zm_bgb_chance
    // Params 0, eflags: 0x1 linked
    // Checksum 0x98c1dcc6, Offset: 0x398
    // Size: 0x1c0
    function bgb_devgui_think() {
        b_powerboost_toggle = 0;
        b_successfail_toggle = 0;
        for (;;) {
            n_val_powerboost = getdvarstring("<unknown string>");
            n_val_successfail = getdvarstring("<unknown string>");
            if (n_val_powerboost != "<unknown string>") {
                b_powerboost_toggle = !b_powerboost_toggle;
                level clientfield::set("<unknown string>", b_powerboost_toggle);
                if (b_powerboost_toggle) {
                    iprintlnbold("<unknown string>");
                } else {
                    iprintlnbold("<unknown string>");
                }
            }
            if (n_val_successfail != "<unknown string>") {
                b_successfail_toggle = !b_successfail_toggle;
                level clientfield::set("<unknown string>", b_successfail_toggle);
                if (b_successfail_toggle) {
                    iprintlnbold("<unknown string>");
                } else {
                    iprintlnbold("<unknown string>");
                }
            }
            setdvar("<unknown string>", "<unknown string>");
            setdvar("<unknown string>", "<unknown string>");
            wait(0.5);
        }
    }

#/
