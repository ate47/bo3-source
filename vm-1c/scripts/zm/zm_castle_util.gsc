#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_744abc1c;

// Namespace namespace_744abc1c
// Params 4, eflags: 0x1 linked
// Checksum 0x69792900, Offset: 0x180
// Size: 0x15c
function create_unitrigger(str_hint, n_radius, var_616077d9, func_unitrigger_logic) {
    if (!isdefined(n_radius)) {
        n_radius = 64;
    }
    if (!isdefined(var_616077d9)) {
        var_616077d9 = &function_fcc6aab1;
    }
    if (!isdefined(func_unitrigger_logic)) {
        func_unitrigger_logic = &function_77c4e424;
    }
    s_unitrigger = spawnstruct();
    s_unitrigger.origin = self.origin;
    s_unitrigger.angles = self.angles;
    s_unitrigger.script_unitrigger_type = "unitrigger_radius_use";
    s_unitrigger.cursor_hint = "HINT_NOICON";
    s_unitrigger.hint_string = str_hint;
    s_unitrigger.prompt_and_visibility_func = var_616077d9;
    s_unitrigger.related_parent = self;
    s_unitrigger.radius = n_radius;
    self.s_unitrigger = s_unitrigger;
    zm_unitrigger::register_static_unitrigger(s_unitrigger, func_unitrigger_logic);
}

// Namespace namespace_744abc1c
// Params 1, eflags: 0x1 linked
// Checksum 0x9c33223, Offset: 0x2e8
// Size: 0x22
function function_fcc6aab1(player) {
    b_visible = 1;
    return b_visible;
}

// Namespace namespace_744abc1c
// Params 0, eflags: 0x1 linked
// Checksum 0x24b3b4a0, Offset: 0x318
// Size: 0xbc
function function_77c4e424() {
    self endon(#"death");
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        if (isdefined(self.stub.related_parent)) {
            self.stub.related_parent notify(#"trigger_activated", player);
        }
    }
}

// Namespace namespace_744abc1c
// Params 0, eflags: 0x1 linked
// Checksum 0xac5e3585, Offset: 0x3e0
// Size: 0x1f4
function function_fa7da172() {
    self endon(#"death");
    var_82a4f07b = struct::get("keeper_end_loc");
    var_77b9bd02 = 0;
    while (isdefined(level.var_8ef26cd9) && level.var_8ef26cd9) {
        str_player_zone = self zm_zonemgr::get_player_zone();
        if (zm_utility::is_player_valid(self) && str_player_zone === "zone_undercroft") {
            if (!(isdefined(var_77b9bd02) && var_77b9bd02) && distance2dsquared(var_82a4f07b.origin, self.origin) <= 53361) {
                self clientfield::set_to_player("gravity_trap_rumble", 1);
                var_77b9bd02 = 1;
            } else if (isdefined(var_77b9bd02) && var_77b9bd02 && distance2dsquared(var_82a4f07b.origin, self.origin) > 53361) {
                self clientfield::set_to_player("gravity_trap_rumble", 0);
                var_77b9bd02 = 0;
            }
        } else if (isdefined(var_77b9bd02) && var_77b9bd02) {
            self clientfield::set_to_player("gravity_trap_rumble", 0);
            var_77b9bd02 = 0;
        }
        wait(0.15);
    }
    self clientfield::set_to_player("gravity_trap_rumble", 0);
}

/#

    // Namespace namespace_744abc1c
    // Params 4, eflags: 0x1 linked
    // Checksum 0xc51fadf6, Offset: 0x5e0
    // Size: 0x108
    function function_8faf1d24(v_color, var_8882142e, n_scale, str_endon) {
        if (!isdefined(v_color)) {
            v_color = (0, 0, 255);
        }
        if (!isdefined(var_8882142e)) {
            var_8882142e = "<unknown string>";
        }
        if (!isdefined(n_scale)) {
            n_scale = 0.25;
        }
        if (!isdefined(str_endon)) {
            str_endon = "<unknown string>";
        }
        if (getdvarint("<unknown string>") == 0) {
            return;
        }
        if (isdefined(str_endon)) {
            self endon(str_endon);
        }
        origin = self.origin;
        while (true) {
            print3d(origin, var_8882142e, v_color, n_scale);
            wait(0.1);
        }
    }

    // Namespace namespace_744abc1c
    // Params 5, eflags: 0x1 linked
    // Checksum 0xd3574411, Offset: 0x6f0
    // Size: 0x120
    function function_72260d3a(var_2fa24527, str_dvar, n_value, func, var_f0ee45c9) {
        if (!isdefined(var_f0ee45c9)) {
            var_f0ee45c9 = -1;
        }
        setdvar(str_dvar, var_f0ee45c9);
        adddebugcommand("<unknown string>" + var_2fa24527 + "<unknown string>" + str_dvar + "<unknown string>" + n_value + "<unknown string>");
        while (true) {
            var_608d58e3 = getdvarint(str_dvar);
            if (var_608d58e3 > var_f0ee45c9) {
                [[ func ]](var_608d58e3);
                setdvar(str_dvar, var_f0ee45c9);
            }
            util::wait_network_frame();
        }
    }

#/
