#using scripts/shared/vehicleriders_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;

#namespace turret;

// Namespace turret
// Params 0, eflags: 0x2
// Checksum 0x2c3a248f, Offset: 0x3c0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("turret", &__init__, undefined, undefined);
}

// Namespace turret
// Params 0, eflags: 0x1 linked
// Checksum 0xa042237e, Offset: 0x400
// Size: 0x4c
function __init__() {
    clientfield::register("vehicle", "toggle_lensflare", 1, 1, "int");
    level._turrets = spawnstruct();
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xbdcffcad, Offset: 0x458
// Size: 0x44
function get_weapon(n_index) {
    if (!isdefined(n_index)) {
        n_index = 0;
    }
    w_weapon = self seatgetweapon(n_index);
    return w_weapon;
}

// Namespace turret
// Params 1, eflags: 0x0
// Checksum 0x6fb500b1, Offset: 0x4a8
// Size: 0x2a
function get_parent(n_index) {
    return _get_turret_data(n_index).e_parent;
}

// Namespace turret
// Params 0, eflags: 0x1 linked
// Checksum 0x541f3aac, Offset: 0x4e0
// Size: 0x4c
function laser_death_watcher() {
    self notify(#"laser_death_thread_stop");
    self endon(#"laser_death_thread_stop");
    self waittill(#"death");
    if (isdefined(self)) {
        self laseroff();
    }
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x5ff49e80, Offset: 0x538
// Size: 0xaa
function enable_laser(b_enable, n_index) {
    if (b_enable) {
        _get_turret_data(n_index).has_laser = 1;
        self laseron();
        self thread laser_death_watcher();
        return;
    }
    _get_turret_data(n_index).has_laser = undefined;
    self laseroff();
    self notify(#"laser_death_thread_stop");
}

// Namespace turret
// Params 0, eflags: 0x1 linked
// Checksum 0x6856f4b4, Offset: 0x5f0
// Size: 0x8e
function watch_for_flash() {
    self endon(#"watch_for_flash_and_stun");
    self endon(#"death");
    while (true) {
        var_f8740cad, var_1e503342, attacker, team = self waittill(#"flashbang");
        self notify(#"damage", 1, attacker, undefined, undefined, undefined, undefined, undefined, undefined, "flash_grenade");
    }
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xa9a554a2, Offset: 0x688
// Size: 0x132
function watch_for_flash_and_stun(n_index) {
    self notify(#"watch_for_flash_and_stun_end");
    self endon(#"watch_for_flash_and_stun");
    self endon(#"death");
    self thread watch_for_flash();
    while (true) {
        damage, attacker, direction, point, type, tagname, modelname, partname, weapon = self waittill(#"damage");
        if (weapon.dostun) {
            if (isdefined(self.stunned)) {
                continue;
            }
            self.stunned = 1;
            stop(n_index, 1);
            wait(randomfloatrange(5, 7));
            self.stunned = undefined;
        }
    }
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xceae790a, Offset: 0x7c8
// Size: 0x190
function emp_watcher(n_index) {
    self notify(#"emp_thread_stop");
    self endon(#"emp_thread_stop");
    self endon(#"death");
    while (true) {
        damage, attacker, direction, point, type, tagname, modelname, partname, weapon = self waittill(#"damage");
        if (weapon.isemp) {
            if (isdefined(self.emped)) {
                continue;
            }
            self.emped = 1;
            if (isdefined(_get_turret_data(n_index).has_laser)) {
                self laseroff();
            }
            stop(n_index, 1);
            wait(randomfloatrange(5, 7));
            self.emped = undefined;
            if (isdefined(_get_turret_data(n_index).has_laser)) {
                self laseron();
            }
        }
    }
}

// Namespace turret
// Params 2, eflags: 0x0
// Checksum 0x3166dd5a, Offset: 0x960
// Size: 0x8e
function enable_emp(b_enable, n_index) {
    if (b_enable) {
        _get_turret_data(n_index).can_emp = 1;
        self thread emp_watcher(n_index);
        self.takedamage = 1;
        return;
    }
    _get_turret_data(n_index).can_emp = undefined;
    self notify(#"emp_thread_stop");
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xcde2771f, Offset: 0x9f8
// Size: 0x40
function set_team(str_team, n_index) {
    _get_turret_data(n_index).str_team = str_team;
    self.team = str_team;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xa6cb8254, Offset: 0xa40
// Size: 0x78
function get_team(n_index) {
    str_team = undefined;
    s_turret = _get_turret_data(n_index);
    str_team = self.team;
    if (!isdefined(s_turret.str_team)) {
        s_turret.str_team = str_team;
    }
    return str_team;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x1a1db359, Offset: 0xac0
// Size: 0x2a
function is_turret_enabled(n_index) {
    return _get_turret_data(n_index).is_enabled;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xaf8c1f38, Offset: 0xaf8
// Size: 0x4a
function does_need_user(n_index) {
    return isdefined(_get_turret_data(n_index).b_needs_user) && _get_turret_data(n_index).b_needs_user;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x66e39776, Offset: 0xb50
// Size: 0x32
function does_have_user(n_index) {
    return isalive(get_user(n_index));
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x76ed8ce9, Offset: 0xb90
// Size: 0x22
function get_user(n_index) {
    return self getseatoccupant(n_index);
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x7a64f78a, Offset: 0xbc0
// Size: 0x90
function _set_turret_needs_user(n_index, b_needs_user) {
    s_turret = _get_turret_data(n_index);
    if (b_needs_user) {
        s_turret.b_needs_user = 1;
        self thread watch_for_flash_and_stun(n_index);
        return;
    }
    self notify(#"watch_for_flash_and_stun_end");
    s_turret.b_needs_user = 0;
}

// Namespace turret
// Params 2, eflags: 0x0
// Checksum 0xcee186c6, Offset: 0xc58
// Size: 0x4c
function function_ea65fa55(a_ents, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_67cbe21 = a_ents;
}

// Namespace turret
// Params 2, eflags: 0x0
// Checksum 0xf797f3be, Offset: 0xcb0
// Size: 0xcc
function function_61ddedf3(var_de90e30c, n_index) {
    s_turret = _get_turret_data(n_index);
    if (!isarray(var_de90e30c)) {
        var_a514bbba = [];
        var_a514bbba[0] = var_de90e30c;
    } else {
        var_a514bbba = var_de90e30c;
    }
    if (isdefined(s_turret.var_67cbe21)) {
        var_a514bbba = arraycombine(s_turret.var_67cbe21, var_a514bbba, 1, 0);
    }
    s_turret.var_67cbe21 = var_a514bbba;
}

// Namespace turret
// Params 1, eflags: 0x0
// Checksum 0xeff5acf6, Offset: 0xd88
// Size: 0x3e
function function_6e68f6dc(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_67cbe21 = undefined;
}

// Namespace turret
// Params 2, eflags: 0x0
// Checksum 0x36423600, Offset: 0xdd0
// Size: 0x4c
function function_37450ddc(a_ents, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_e862c397 = a_ents;
}

// Namespace turret
// Params 1, eflags: 0x0
// Checksum 0xbd62ab5a, Offset: 0xe28
// Size: 0x3e
function function_d1a39ff1(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_e862c397 = undefined;
}

// Namespace turret
// Params 1, eflags: 0x0
// Checksum 0x3a8d2583, Offset: 0xe70
// Size: 0x4c
function _wait_for_current_user_to_finish(n_index) {
    self endon(#"death");
    while (isalive(get_user(n_index))) {
        wait(0.05);
    }
}

// Namespace turret
// Params 2, eflags: 0x0
// Checksum 0xa03bf0bd, Offset: 0xec8
// Size: 0x58
function is_current_user(ai_user, n_index) {
    ai_current_user = get_user(n_index);
    return isalive(ai_current_user) && ai_user == ai_current_user;
}

// Namespace turret
// Params 5, eflags: 0x1 linked
// Checksum 0xa6f941e2, Offset: 0xf28
// Size: 0xa0
function set_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_burst_fire_min = n_fire_min;
    s_turret.n_burst_fire_max = n_fire_max;
    s_turret.n_burst_wait_min = n_wait_min;
    s_turret.n_burst_wait_max = n_wait_max;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x254c4f6d, Offset: 0xfd0
// Size: 0x5c
function set_torso_targetting(n_index, n_torso_targetting_offset) {
    if (!isdefined(n_torso_targetting_offset)) {
        n_torso_targetting_offset = -12;
    }
    s_turret = _get_turret_data(n_index);
    s_turret.n_torso_targetting_offset = n_torso_targetting_offset;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x2a2fcb64, Offset: 0x1038
// Size: 0x64
function set_target_leading(n_index, n_target_leading_factor) {
    if (!isdefined(n_target_leading_factor)) {
        n_target_leading_factor = 0.1;
    }
    s_turret = _get_turret_data(n_index);
    s_turret.n_target_leading_factor = n_target_leading_factor;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x338191ec, Offset: 0x10a8
// Size: 0xc4
function set_on_target_angle(n_angle, n_index) {
    s_turret = _get_turret_data(n_index);
    if (!isdefined(n_angle)) {
        if (s_turret.str_guidance_type != "none") {
            n_angle = 10;
        } else {
            n_angle = 2;
        }
    }
    if (n_index > 0) {
        self function_2ea2374c(n_angle, n_index - 1);
        return;
    }
    self function_2ea2374c(n_angle);
}

// Namespace turret
// Params 3, eflags: 0x1 linked
// Checksum 0xf622e3a0, Offset: 0x1178
// Size: 0x100
function set_target(e_target, v_offset, n_index) {
    s_turret = _get_turret_data(n_index);
    if (!isdefined(v_offset)) {
        v_offset = _get_default_target_offset(e_target, n_index);
    }
    if (!isdefined(n_index) || n_index == 0) {
        self settargetentity(e_target, v_offset);
    } else {
        self settargetentity(e_target, v_offset, n_index - 1);
    }
    s_turret.e_target = e_target;
    s_turret.e_last_target = e_target;
    s_turret.v_offset = v_offset;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x72f6a296, Offset: 0x1280
// Size: 0x2cc
function _get_default_target_offset(e_target, n_index) {
    s_turret = _get_turret_data(n_index);
    if (s_turret.str_weapon_type == "bullet") {
        if (isdefined(e_target)) {
            if (issentient(self) && issentient(e_target)) {
                z_offset = isdefined(s_turret.n_torso_targetting_offset) ? s_turret.n_torso_targetting_offset : isvehicle(e_target) ? 0 : 0;
            } else if (isplayer(e_target)) {
                z_offset = randomintrange(40, 50);
            } else if (e_target.type === "human") {
                z_offset = randomintrange(20, 60);
            } else if (e_target.type === "robot") {
                z_offset = randomintrange(40, 60);
            }
            if (isdefined(e_target.z_target_offset_override)) {
                if (!isdefined(z_offset)) {
                    z_offset = 0;
                }
                z_offset += e_target.z_target_offset_override;
            }
        }
    }
    if (!isdefined(z_offset)) {
        z_offset = 0;
    }
    v_offset = (0, 0, z_offset);
    if ((isdefined(s_turret.n_target_leading_factor) ? s_turret.n_target_leading_factor : 0) != 0 && isdefined(e_target) && issentient(self) && issentient(e_target) && !isvehicle(e_target)) {
        velocity = e_target getvelocity();
        v_offset += velocity * s_turret.n_target_leading_factor;
    }
    return v_offset;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x1f63f40e, Offset: 0x1558
// Size: 0xb2
function get_target(n_index) {
    if (isdefined(_get_turret_data(n_index).e_target.ignoreme) && isdefined(_get_turret_data(n_index).e_target) && _get_turret_data(n_index).e_target.ignoreme) {
        clear_target(n_index);
    }
    return _get_turret_data(n_index).e_target;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x430564cb, Offset: 0x1618
// Size: 0x50
function is_target(e_target, n_index) {
    e_current_target = get_target(n_index);
    if (isdefined(e_current_target)) {
        return (e_current_target == e_target);
    }
    return false;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x7ff10318, Offset: 0x1670
// Size: 0xb4
function clear_target(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret flag::clear("turret manual");
    s_turret.e_next_target = undefined;
    s_turret.e_target = undefined;
    if (!isdefined(n_index) || n_index == 0) {
        self clearturrettarget();
        return;
    }
    self function_bb5f9faa(n_index - 1);
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x52fd1f36, Offset: 0x1730
// Size: 0x4c
function function_109c9f9(n_flags, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_14ae7523 = n_flags;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xab048145, Offset: 0x1788
// Size: 0x50
function function_5d0d3544(n_flags, n_index) {
    var_da76fdcf = _get_turret_data(n_index).var_14ae7523;
    return (var_da76fdcf & n_flags) == n_flags;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x1a873dbf, Offset: 0x17e0
// Size: 0x50
function function_3cf7ce0e(n_distance, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.var_4695d932 = n_distance * n_distance;
}

// Namespace turret
// Params 2, eflags: 0x0
// Checksum 0xec1b8493, Offset: 0x1838
// Size: 0x50
function function_96d77410(n_distance, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_min_target_distance_squared = n_distance * n_distance;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xfab4e3a2, Offset: 0x1890
// Size: 0x4c
function set_min_target_distance_squared(n_distance_squared, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.n_min_target_distance_squared = n_distance_squared;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x3e83646a, Offset: 0x18e8
// Size: 0x184
function fire(n_index) {
    s_turret = _get_turret_data(n_index);
    assert(isdefined(n_index) && n_index >= 0, "robot");
    if (n_index == 0) {
        self fireweapon(0, s_turret.e_target);
    } else {
        ai_current_user = get_user(n_index);
        if (isdefined(ai_current_user.is_disabled) && isdefined(ai_current_user) && ai_current_user.is_disabled) {
            return;
        }
        if (isdefined(s_turret.e_target)) {
            self function_9af49228(s_turret.e_target, s_turret.v_offset, n_index - 1);
        }
        self fireweapon(n_index, s_turret.e_target, s_turret.v_offset, s_turret.e_parent);
    }
    s_turret.n_last_fire_time = gettime();
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xe41df817, Offset: 0x1a78
// Size: 0xc0
function stop(n_index, b_clear_target) {
    if (!isdefined(b_clear_target)) {
        b_clear_target = 0;
    }
    s_turret = _get_turret_data(n_index);
    s_turret.e_next_target = undefined;
    s_turret.e_target = undefined;
    s_turret flag::clear("turret manual");
    if (b_clear_target) {
        clear_target(n_index);
    }
    self notify("_stop_turret" + _index(n_index));
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x556569fc, Offset: 0x1b40
// Size: 0x1ec
function fire_for_time(n_time, n_index) {
    if (!isdefined(n_index)) {
        n_index = 0;
    }
    assert(isdefined(n_time), "robot");
    self endon(#"death");
    self endon(#"drone_death");
    self endon("_stop_turret" + _index(n_index));
    self endon("turret_disabled" + _index(n_index));
    self notify("_fire_turret_for_time" + _index(n_index));
    self endon("_fire_turret_for_time" + _index(n_index));
    b_fire_forever = 0;
    if (n_time < 0) {
        b_fire_forever = 1;
    } else {
        /#
            w_weapon = get_weapon(n_index);
            assert(n_time >= w_weapon.firetime, "robot" + n_time + "robot" + w_weapon.firetime);
        #/
    }
    while (n_time > 0 || b_fire_forever) {
        n_burst_time = _burst_fire(n_time, n_index);
        if (!b_fire_forever) {
            n_time -= n_burst_time;
        }
    }
}

// Namespace turret
// Params 5, eflags: 0x1 linked
// Checksum 0x9cd17921, Offset: 0x1d38
// Size: 0xf4
function shoot_at_target(e_target, n_time, v_offset, n_index, b_just_once) {
    assert(isdefined(e_target), "robot");
    self endon(#"drone_death");
    self endon(#"death");
    s_turret = _get_turret_data(n_index);
    s_turret flag::set("turret manual");
    _shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once);
    s_turret flag::clear("turret manual");
}

// Namespace turret
// Params 5, eflags: 0x1 linked
// Checksum 0x45f3a449, Offset: 0x1e38
// Size: 0x184
function _shoot_turret_at_target(e_target, n_time, v_offset, n_index, b_just_once) {
    self endon(#"drone_death");
    self endon(#"death");
    self endon("_stop_turret" + _index(n_index));
    self endon("turret_disabled" + _index(n_index));
    self notify("_shoot_turret_at_target" + _index(n_index));
    self endon("_shoot_turret_at_target" + _index(n_index));
    if (n_time == -1) {
        e_target endon(#"death");
    }
    if (!isdefined(b_just_once)) {
        b_just_once = 0;
    }
    set_target(e_target, v_offset, n_index);
    if (!isdefined(self.aim_only_no_shooting)) {
        _waittill_turret_on_target(e_target, n_index);
        if (b_just_once) {
            fire(n_index);
            return;
        }
        fire_for_time(n_time, n_index);
    }
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xecbf66cd, Offset: 0x1fc8
// Size: 0x90
function _waittill_turret_on_target(e_target, n_index) {
    do {
        wait(isdefined(self.waittill_turret_on_target_delay) ? self.waittill_turret_on_target_delay : 0.5);
        if (!isdefined(n_index) || n_index == 0) {
            self waittill(#"turret_on_target");
            continue;
        }
        self waittill(#"gunner_turret_on_target");
    } while (isdefined(e_target) && !can_hit_target(e_target, n_index));
}

// Namespace turret
// Params 3, eflags: 0x0
// Checksum 0x5d5c9d95, Offset: 0x2060
// Size: 0x44
function shoot_at_target_once(e_target, v_offset, n_index) {
    shoot_at_target(e_target, 0, v_offset, n_index, 1);
}

// Namespace turret
// Params 3, eflags: 0x1 linked
// Checksum 0xaeb71c03, Offset: 0x20b0
// Size: 0x104
function enable(n_index, b_user_required, v_offset) {
    if (isalive(self) && !is_turret_enabled(n_index)) {
        _get_turret_data(n_index).is_enabled = 1;
        self thread _turret_think(n_index, v_offset);
        self notify("turret_enabled" + _index(n_index));
        if (isdefined(b_user_required) && !b_user_required) {
            _set_turret_needs_user(n_index, 0);
            return;
        }
        _set_turret_needs_user(n_index, 1);
    }
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xb1e10c00, Offset: 0x21c0
// Size: 0x2c
function enable_auto_use(b_enable) {
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    self.script_auto_use = b_enable;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x69dcc48f, Offset: 0x21f8
// Size: 0x4c
function disable_ai_getoff(n_index, b_disable) {
    if (!isdefined(b_disable)) {
        b_disable = 1;
    }
    _get_turret_data(n_index).disable_ai_getoff = b_disable;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x41d631b2, Offset: 0x2250
// Size: 0x98
function disable(n_index) {
    if (is_turret_enabled(n_index)) {
        _drop_turret(n_index);
        clear_target(n_index);
        _get_turret_data(n_index).is_enabled = 0;
        self notify("turret_disabled" + _index(n_index));
    }
}

// Namespace turret
// Params 2, eflags: 0x0
// Checksum 0x248dd958, Offset: 0x22f0
// Size: 0xcc
function pause(time, n_index) {
    s_turret = _get_turret_data(n_index);
    if (time > 0) {
        time *= 1000;
    }
    if (isdefined(s_turret.pause)) {
        s_turret.pause_time += time;
        return;
    }
    s_turret.pause = 1;
    s_turret.pause_time = time;
    stop(n_index);
}

// Namespace turret
// Params 1, eflags: 0x0
// Checksum 0x85ec86af, Offset: 0x23c8
// Size: 0x3e
function unpause(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.pause = undefined;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xfae79822, Offset: 0x2410
// Size: 0x566
function _turret_think(n_index, v_offset) {
    turret_think_time = max(1.5, get_weapon(n_index).firetime);
    no_target_start_time = 0;
    self endon(#"death");
    self endon("turret_disabled" + _index(n_index));
    self notify("_turret_think" + _index(n_index));
    self endon("_turret_think" + _index(n_index));
    /#
        self thread _debug_turret_think(n_index);
    #/
    self thread function_50f8f315(n_index);
    self thread function_b5dd89ec(n_index);
    s_turret = _get_turret_data(n_index);
    if (isdefined(s_turret.has_laser)) {
        self laseron();
    }
    while (true) {
        s_turret flag::wait_till_clear("turret manual");
        n_time_now = gettime();
        if (self _check_for_paused(n_index) || isdefined(self.emped) || isdefined(self.stunned)) {
            wait(turret_think_time);
            continue;
        }
        a_potential_targets = function_5798a268(n_index);
        if (!isdefined(s_turret.e_target) || s_turret.e_target.health < 0 || !isinarray(a_potential_targets, s_turret.e_target) || s_turret function_510e9ac4(n_time_now)) {
            stop(n_index);
        }
        e_original_next_target = s_turret.e_next_target;
        s_turret.e_next_target = function_91ef09(a_potential_targets, n_index);
        if (isdefined(s_turret.e_next_target)) {
            s_turret.var_20de07b0 = undefined;
            s_turret.n_time_lose_sight = undefined;
            no_target_start_time = 0;
            if (_user_check(n_index)) {
                self thread _shoot_turret_at_target(s_turret.e_next_target, turret_think_time, v_offset, n_index);
                if (s_turret.e_next_target !== e_original_next_target) {
                    self notify(#"has_new_target", s_turret.e_next_target);
                }
            }
        } else {
            if (!isdefined(self.do_not_clear_targets_during_think) || !self.do_not_clear_targets_during_think) {
                clear_target(n_index);
            }
            if (no_target_start_time == 0) {
                no_target_start_time = n_time_now;
            }
            target_wait_time = n_time_now - no_target_start_time;
            if (isdefined(s_turret.occupy_no_target_time)) {
                occupy_time = s_turret.occupy_no_target_time;
            } else {
                occupy_time = 3600;
            }
            if (!(isdefined(s_turret.disable_ai_getoff) && s_turret.disable_ai_getoff)) {
                bwasplayertarget = isdefined(s_turret.e_last_target) && s_turret.e_last_target.health > 0 && isplayer(s_turret.e_last_target);
                if (bwasplayertarget) {
                    occupy_time /= 4;
                }
            } else {
                bwasplayertarget = 0;
            }
            if (target_wait_time >= occupy_time) {
                _drop_turret(n_index, !bwasplayertarget);
            }
        }
        if (!(isdefined(s_turret.disable_ai_getoff) && s_turret.disable_ai_getoff) && _has_nearby_player_enemy(n_index, self)) {
            _drop_turret(n_index, 0);
        }
        wait(turret_think_time);
    }
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xf00619df, Offset: 0x2980
// Size: 0x1fc
function _has_nearby_player_enemy(index, turret) {
    has_nearby_enemy = 0;
    time = gettime();
    ai_user = turret get_user(index);
    if (!isdefined(ai_user)) {
        return has_nearby_enemy;
    }
    if (!isdefined(turret.next_nearby_enemy_time)) {
        turret.next_nearby_enemy_time = time;
    }
    if (time >= turret.next_nearby_enemy_time) {
        players = getplayers();
        foreach (player in players) {
            if (turret.team == player.team) {
                continue;
            }
            if (abs(ai_user.origin[2] - player.origin[2]) <= 60 && distance2dsquared(ai_user.origin, player.origin) <= 300 * 300) {
                has_nearby_enemy = 1;
                break;
            }
        }
        turret.next_nearby_enemy_time = time + 1000;
    }
    return has_nearby_enemy;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x64a6b2d0, Offset: 0x2b88
// Size: 0x4e
function function_510e9ac4(n_time_now) {
    if (isdefined(self.var_20de07b0) && self.var_20de07b0) {
        return true;
    } else if (isdefined(self.n_time_lose_sight)) {
        return (n_time_now - self.n_time_lose_sight > 3000);
    }
    return false;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xa1c9e856, Offset: 0x2be0
// Size: 0x188
function function_50f8f315(n_index) {
    self endon(#"death");
    self endon("turret_disabled" + _index(n_index));
    self endon("_turret_think" + _index(n_index));
    s_turret = _get_turret_data(n_index);
    ai_user = self getseatoccupant(n_index);
    if (isactor(ai_user)) {
        self thread _listen_for_damage_on_actor(ai_user, n_index);
    }
    while (true) {
        _waittill_user_change(n_index);
        if (!_user_check(n_index)) {
            stop(n_index, 1);
            continue;
        }
        ai_user = self getseatoccupant(n_index);
        if (isactor(ai_user)) {
            self thread _listen_for_damage_on_actor(ai_user, n_index);
        }
    }
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x28f0285, Offset: 0x2d70
// Size: 0x138
function _listen_for_damage_on_actor(ai_user, n_index) {
    self endon(#"death");
    ai_user endon(#"death");
    self endon("turret_disabled" + _index(n_index));
    self endon("_turret_think" + _index(n_index));
    self endon(#"exit_vehicle");
    while (true) {
        n_amount, e_attacker, v_org, v_dir, str_mod = ai_user waittill(#"damage");
        s_turret = _get_turret_data(n_index);
        if (isdefined(s_turret)) {
            if (!isdefined(s_turret.e_next_target) && !isdefined(s_turret.e_target)) {
                s_turret.e_last_target = e_attacker;
            }
        }
    }
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x306a3ebe, Offset: 0x2eb0
// Size: 0xcc
function _waittill_user_change(n_index) {
    ai_user = self getseatoccupant(n_index);
    if (isalive(ai_user)) {
        if (isactor(ai_user)) {
            ai_user endon(#"death");
        } else if (isplayer(ai_user)) {
            self notify("turret_disabled" + _index(n_index));
        }
    }
    self util::waittill_either("exit_vehicle", "enter_vehicle");
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xe974a166, Offset: 0x2f88
// Size: 0xd2
function _check_for_paused(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.pause_start_time = gettime();
    while (isdefined(s_turret.pause)) {
        if (s_turret.pause_time > 0) {
            time = gettime();
            paused_time = time - s_turret.pause_start_time;
            if (paused_time > s_turret.pause_time) {
                s_turret.pause = undefined;
                return true;
            }
        }
        wait(0.05);
    }
    return false;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xc0b6f3bf, Offset: 0x3068
// Size: 0x9c
function _drop_turret(n_index, bexitifautomatedonly) {
    ai_user = get_user(n_index);
    if (isdefined(bexitifautomatedonly) && (isdefined(ai_user.turret_auto_use) && ai_user.turret_auto_use || isalive(ai_user) && !bexitifautomatedonly)) {
        ai_user vehicle::get_out();
    }
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xd04fd63e, Offset: 0x3110
// Size: 0x3f8
function function_b5dd89ec(n_index) {
    self endon(#"death");
    self endon("_turret_think" + _index(n_index));
    self endon("turret_disabled" + _index(n_index));
    s_turret = _get_turret_data(n_index);
    if (n_index == 0) {
        var_7f7aca6b = "driver";
    } else {
        var_7f7aca6b = "gunner" + n_index;
    }
    while (true) {
        wait(3);
        if (isdefined(self.script_auto_use) && does_have_target(n_index) && !_user_check(n_index) && self.script_auto_use) {
            str_team = get_team(n_index);
            var_bb65a987 = getaiarchetypearray("human", str_team);
            var_2260972c = arraysortclosest(getaiarray(), self.origin, 99999, 0, 300);
            if (var_bb65a987.size > 0) {
                var_4d8961b4 = [];
                if (isdefined(self.var_4e7785d7)) {
                    var_4d8961b4 = arraysort(var_bb65a987, self.origin, 1, var_4d8961b4.size, self.var_4e7785d7);
                } else {
                    var_4d8961b4 = arraysort(var_bb65a987, self.origin, 1);
                }
                ai_user = undefined;
                foreach (ai in var_4d8961b4) {
                    var_f2486e4d = 0;
                    foreach (ai_enemy in var_2260972c) {
                        if (ai_enemy.team != ai.team) {
                            var_f2486e4d = 1;
                            break;
                        }
                    }
                    if (var_f2486e4d) {
                        continue;
                    }
                    if (ai flagsys::get("vehiclerider")) {
                        continue;
                    }
                    if (!ai vehicle::function_293281a2(self, var_7f7aca6b)) {
                        continue;
                    }
                    ai_user = ai;
                    break;
                }
                if (isalive(ai_user)) {
                    ai_user.turret_auto_use = 1;
                    ai_user vehicle::get_in(self, var_7f7aca6b);
                }
            }
        }
    }
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x1ef57c6a, Offset: 0x3510
// Size: 0x2c
function does_have_target(n_index) {
    return isdefined(_get_turret_data(n_index).e_next_target);
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xbc7c0f3c, Offset: 0x3548
// Size: 0x78
function _user_check(n_index) {
    s_turret = _get_turret_data(n_index);
    if (does_need_user(n_index)) {
        b_has_user = does_have_user(n_index);
        return b_has_user;
    }
    return 1;
}

/#

    // Namespace turret
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa74157b8, Offset: 0x35c8
    // Size: 0x350
    function _debug_turret_think(n_index) {
        self endon(#"death");
        self endon("robot" + _index(n_index));
        self endon("robot" + _index(n_index));
        s_turret = _get_turret_data(n_index);
        v_color = (0, 0, 1);
        while (true) {
            if (!getdvarint("robot")) {
                wait(0.2);
                continue;
            }
            has_target = isdefined(get_target(n_index));
            if (does_need_user(n_index) && !does_have_user(n_index) || !has_target) {
                v_color = (1, 1, 0);
            } else {
                v_color = (0, 1, 0);
            }
            str_team = get_team(n_index);
            if (!isdefined(str_team)) {
                str_team = "robot";
            }
            str_target = "robot";
            e_target = s_turret.e_next_target;
            if (isdefined(e_target)) {
                if (isactor(e_target)) {
                    str_target += "robot";
                } else if (isplayer(e_target)) {
                    str_target += "robot";
                } else if (isvehicle(e_target)) {
                    str_target += "robot";
                } else if (isdefined(e_target.targetname) && e_target.targetname == "robot") {
                    str_target += "robot";
                } else if (isdefined(e_target.classname)) {
                    str_target += e_target.classname;
                }
            } else {
                str_target += "robot";
            }
            str_debug = self getentnum() + "robot" + str_team + "robot" + str_target;
            record3dtext(str_debug, self.origin, v_color, "robot", self);
            wait(0.05);
        }
    }

#/

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xc9a8cae5, Offset: 0x3920
// Size: 0xa4
function _get_turret_data(n_index) {
    s_turret = undefined;
    if (isvehicle(self)) {
        if (isdefined(self.a_turrets) && isdefined(self.a_turrets[n_index])) {
            s_turret = self.a_turrets[n_index];
        }
    } else {
        s_turret = self._turret;
    }
    if (!isdefined(s_turret)) {
        s_turret = _init_turret(n_index);
    }
    return s_turret;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x7207bf0a, Offset: 0x39d0
// Size: 0x32
function has_turret(n_index) {
    if (isdefined(self.a_turrets) && isdefined(self.a_turrets[n_index])) {
        return true;
    }
    return false;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xbb246b02, Offset: 0x3a10
// Size: 0x268
function _init_turret(n_index) {
    if (!isdefined(n_index)) {
        n_index = 0;
    }
    self endon(#"death");
    w_weapon = get_weapon(n_index);
    if (w_weapon == level.weaponnone) {
        assertmsg("robot");
        return;
    }
    util::waittill_asset_loaded("xmodel", self.model);
    if (isvehicle(self)) {
        s_turret = _init_vehicle_turret(n_index);
    } else {
        assertmsg("robot");
    }
    s_turret.w_weapon = w_weapon;
    _update_turret_arcs(n_index);
    s_turret.is_enabled = 0;
    s_turret.e_parent = self;
    s_turret.e_target = undefined;
    s_turret.b_ignore_line_of_sight = 0;
    s_turret.v_offset = (0, 0, 0);
    s_turret.n_burst_fire_time = 0;
    s_turret.var_4695d932 = undefined;
    s_turret.n_min_target_distance_squared = undefined;
    s_turret.str_weapon_type = "bullet";
    s_turret.str_guidance_type = "none";
    s_turret.str_weapon_type = w_weapon.type;
    s_turret.str_guidance_type = w_weapon.guidedmissiletype;
    set_on_target_angle(undefined, n_index);
    s_turret.var_14ae7523 = 3;
    function_f956e85a(n_index);
    s_turret flag::init("turret manual");
    return s_turret;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x676dee1e, Offset: 0x3c80
// Size: 0xc0
function _update_turret_arcs(n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.rightarc = s_turret.w_weapon.rightarc;
    s_turret.leftarc = s_turret.w_weapon.leftarc;
    s_turret.toparc = s_turret.w_weapon.toparc;
    s_turret.bottomarc = s_turret.w_weapon.bottomarc;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xb9aa2768, Offset: 0x3d48
// Size: 0x11a
function function_f956e85a(n_index) {
    switch (_get_turret_data(n_index).str_weapon_type) {
    case 6:
        function_1c6038d9(&function_b6eca136, n_index);
        break;
    case 22:
        function_1c6038d9(&function_40d1f6f5, n_index);
        break;
    case 23:
        function_1c6038d9(&function_d0f7a33c, n_index);
        break;
    case 24:
        function_1c6038d9(&function_2276a7b7, n_index);
        break;
    default:
        assertmsg("robot");
        break;
    }
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xffcb56fa, Offset: 0x3e70
// Size: 0x34
function function_1c6038d9(var_187a0a9, n_index) {
    _get_turret_data(n_index).var_187a0a9 = var_187a0a9;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x42ec0a4b, Offset: 0x3eb0
// Size: 0x288
function _init_vehicle_turret(n_index) {
    assert(isdefined(n_index) && n_index >= 0, "robot");
    s_turret = spawnstruct();
    v_angles = self getseatfiringangles(n_index);
    if (isdefined(v_angles)) {
        s_turret.var_d433358d = 0;
        s_turret.var_c0de8e7a = 0;
    }
    switch (n_index) {
    case 0:
        s_turret.str_tag_flash = "tag_flash";
        s_turret.str_tag_pivot = "tag_barrel";
        break;
    case 1:
        s_turret.str_tag_flash = "tag_gunner_flash1";
        s_turret.str_tag_pivot = "tag_gunner_barrel1";
        break;
    case 2:
        s_turret.str_tag_flash = "tag_gunner_flash2";
        s_turret.str_tag_pivot = "tag_gunner_barrel2";
        break;
    case 3:
        s_turret.str_tag_flash = "tag_gunner_flash3";
        s_turret.str_tag_pivot = "tag_gunner_barrel3";
        break;
    case 4:
        s_turret.str_tag_flash = "tag_gunner_flash4";
        s_turret.str_tag_pivot = "tag_gunner_barrel4";
        break;
    }
    if (isdefined(self.vehicleclass) && self.vehicleclass == "helicopter") {
        s_turret.e_trace_ignore = self;
    }
    if (!isdefined(self.a_turrets)) {
        self.a_turrets = [];
    }
    self.a_turrets[n_index] = s_turret;
    if (n_index > 0) {
        tag_origin = self gettagorigin(_get_gunner_tag_for_turret_index(n_index));
        if (isdefined(tag_origin)) {
            _set_turret_needs_user(n_index, 1);
        }
    }
    return s_turret;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xcceb02b9, Offset: 0x4140
// Size: 0x20e
function _burst_fire(n_max_time, n_index) {
    self endon(#"terminate_all_turrets_firing");
    if (n_max_time < 0) {
        n_max_time = 9999;
    }
    s_turret = _get_turret_data(n_index);
    n_burst_time = _get_burst_fire_time(n_index);
    n_burst_wait = _get_burst_wait_time(n_index);
    if (!isdefined(n_burst_time) || n_burst_time > n_max_time) {
        n_burst_time = n_max_time;
    }
    if (s_turret.n_burst_fire_time >= n_burst_time) {
        s_turret.n_burst_fire_time = 0;
        n_time_since_last_shot = (gettime() - s_turret.n_last_fire_time) / 1000;
        if (n_time_since_last_shot < n_burst_wait) {
            wait(n_burst_wait - n_time_since_last_shot);
        }
    } else {
        n_burst_time -= s_turret.n_burst_fire_time;
    }
    w_weapon = get_weapon(n_index);
    n_fire_time = w_weapon.firetime;
    n_total_time = 0;
    while (n_total_time < n_burst_time) {
        fire(n_index);
        n_total_time += n_fire_time;
        s_turret.n_burst_fire_time += n_fire_time;
        wait(n_fire_time);
    }
    if (n_burst_wait > 0) {
        wait(n_burst_wait);
    }
    return n_burst_time + n_burst_wait;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x59c24cbc, Offset: 0x4358
// Size: 0x114
function _get_burst_fire_time(n_index) {
    s_turret = _get_turret_data(n_index);
    n_time = undefined;
    if (isdefined(s_turret.n_burst_fire_min) && isdefined(s_turret.n_burst_fire_max)) {
        if (s_turret.n_burst_fire_min == s_turret.n_burst_fire_max) {
            n_time = s_turret.n_burst_fire_min;
        } else {
            n_time = randomfloatrange(s_turret.n_burst_fire_min, s_turret.n_burst_fire_max);
        }
    } else if (isdefined(s_turret.n_burst_fire_max)) {
        n_time = randomfloatrange(0, s_turret.n_burst_fire_max);
    }
    return n_time;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xe24b6aae, Offset: 0x4478
// Size: 0x114
function _get_burst_wait_time(n_index) {
    s_turret = _get_turret_data(n_index);
    n_time = 0;
    if (isdefined(s_turret.n_burst_wait_min) && isdefined(s_turret.n_burst_wait_max)) {
        if (s_turret.n_burst_wait_min == s_turret.n_burst_wait_max) {
            n_time = s_turret.n_burst_wait_min;
        } else {
            n_time = randomfloatrange(s_turret.n_burst_wait_min, s_turret.n_burst_wait_max);
        }
    } else if (isdefined(s_turret.n_burst_wait_max)) {
        n_time = randomfloatrange(0, s_turret.n_burst_wait_max);
    }
    return n_time;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0xb48d38f3, Offset: 0x4598
// Size: 0x2e
function _index(n_index) {
    return isdefined(n_index) ? "" + n_index : "";
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x35cafc62, Offset: 0x45d0
// Size: 0x782
function function_5798a268(n_index) {
    s_turret = self _get_turret_data(n_index);
    var_113c7b62 = self function_d163aefd(n_index);
    if (isdefined(var_113c7b62) && var_113c7b62.size > 0) {
        return var_113c7b62;
    }
    a_potential_targets = [];
    str_team = get_team(n_index);
    if (self.use_non_teambased_enemy_selection === 1 && !level.teambased) {
        var_c8ec9b9 = [];
        if (function_5d0d3544(1, n_index)) {
            a_ai_targets = getaiarray();
            var_c8ec9b9 = arraycombine(var_c8ec9b9, a_ai_targets, 1, 0);
        }
        if (function_5d0d3544(2, n_index)) {
            var_c8ec9b9 = arraycombine(var_c8ec9b9, level.players, 1, 0);
        }
        if (function_5d0d3544(8, n_index)) {
            var_c8ec9b9 = arraycombine(var_c8ec9b9, level.var_f196620d, 1, 0);
        }
        for (i = 0; i < var_c8ec9b9.size; i++) {
            e_target = var_c8ec9b9[i];
            if (!isdefined(e_target)) {
                continue;
            }
            if (!isdefined(e_target.team)) {
                continue;
            }
            if (e_target.team == str_team) {
                continue;
            }
            if (!(isdefined(level.var_88bf1cef) && level.var_88bf1cef) && e_target.team == "free") {
                continue;
            }
            a_potential_targets[a_potential_targets.size] = e_target;
        }
    } else if (isdefined(str_team)) {
        var_ce588222 = "allies";
        if (str_team == "allies") {
            var_ce588222 = "axis";
        }
        if (function_5d0d3544(1, n_index)) {
            a_ai_targets = getaiteamarray(var_ce588222);
            if (isdefined(level.var_88bf1cef) && level.var_88bf1cef) {
                a_ai_targets = arraycombine(getaiteamarray("free"), a_ai_targets, 1, 0);
            }
            a_potential_targets = arraycombine(a_potential_targets, a_ai_targets, 1, 0);
        }
        if (function_5d0d3544(2, n_index)) {
            a_potential_targets = arraycombine(a_potential_targets, level.aliveplayers[var_ce588222], 1, 0);
        }
        if (function_5d0d3544(4, n_index)) {
        }
        if (function_5d0d3544(8, n_index)) {
            var_261c8fbc = getvehicleteamarray(var_ce588222);
            a_potential_targets = arraycombine(a_potential_targets, var_261c8fbc, 1, 0);
        }
    }
    if (isdefined(s_turret.e_target) && !isinarray(a_potential_targets, s_turret.e_target)) {
        a_potential_targets[a_potential_targets.size] = s_turret.e_target;
    }
    if (isdefined(str_team)) {
        a_valid_targets = [];
        for (i = 0; i < a_potential_targets.size; i++) {
            e_target = a_potential_targets[i];
            var_214803fd = 0;
            assert(isdefined(e_target), "robot");
            if (isdefined(e_target.ignoreme) && e_target.ignoreme || !isdefined(e_target.health) || e_target.health <= 0) {
                var_214803fd = 1;
            } else if (e_target isnotarget() || issentient(e_target) && e_target ai::is_dead_sentient()) {
                var_214803fd = 1;
            } else if (function_d50da31c(e_target, s_turret) == 0) {
                var_214803fd = 1;
            } else if (isplayer(e_target) && e_target hasperk("specialty_nottargetedbysentry")) {
                var_214803fd = 1;
            }
            if (!var_214803fd) {
                a_valid_targets[a_valid_targets.size] = e_target;
            }
        }
        a_potential_targets = a_valid_targets;
    }
    a_targets = a_potential_targets;
    if (isdefined(s_turret) && isdefined(s_turret.var_e862c397)) {
        while (true) {
            var_ce561745 = 0;
            a_targets = a_potential_targets;
            for (i = 0; i < a_targets.size; i++) {
                e_target = a_targets[i];
                var_ce561745 = 0;
                for (j = 0; j < s_turret.var_e862c397.size; j++) {
                    if (e_target == s_turret.var_e862c397[j]) {
                        arrayremovevalue(a_potential_targets, e_target);
                        var_ce561745 = 1;
                        break;
                    }
                }
            }
            if (!var_ce561745) {
                break;
            }
        }
    }
    return a_potential_targets;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xbd2b8767, Offset: 0x4d60
// Size: 0xfe
function function_d50da31c(e_target, s_turret) {
    if (isdefined(s_turret.var_4695d932) || isdefined(s_turret.n_min_target_distance_squared)) {
        if (!isdefined(e_target.origin)) {
            return false;
        }
        n_dist_squared = distancesquared(e_target.origin, self.origin);
        if (n_dist_squared > (isdefined(s_turret.var_4695d932) ? s_turret.var_4695d932 : 811711611)) {
            return false;
        }
        if (n_dist_squared < (isdefined(s_turret.n_min_target_distance_squared) ? s_turret.n_min_target_distance_squared : 0)) {
            return false;
        }
    }
    return true;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x8b6f5bf7, Offset: 0x4e68
// Size: 0x212
function function_d163aefd(n_index) {
    a_targets = undefined;
    s_turret = _get_turret_data(n_index);
    if (isdefined(s_turret.var_67cbe21)) {
        while (true) {
            var_ce561745 = 0;
            a_targets = s_turret.var_67cbe21;
            for (i = 0; i < a_targets.size; i++) {
                e_target = a_targets[i];
                var_30ace227 = undefined;
                if (!isdefined(e_target)) {
                    var_30ace227 = i;
                } else if (!isalive(e_target)) {
                    var_30ace227 = i;
                } else if (e_target.health <= 0) {
                    var_30ace227 = i;
                } else if (issentient(e_target) && e_target ai::is_dead_sentient()) {
                    var_30ace227 = i;
                }
                if (isdefined(var_30ace227)) {
                    s_turret.var_67cbe21 = a_targets;
                    arrayremovevalue(s_turret.var_67cbe21, e_target);
                    var_ce561745 = 1;
                    break;
                }
            }
            if (!var_ce561745) {
                return s_turret.var_67cbe21;
            }
            if (s_turret.var_67cbe21.size <= 0) {
                s_turret.var_67cbe21 = undefined;
                self notify(#"hash_943773d0");
                break;
            }
        }
    }
    return a_targets;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x6c2ee699, Offset: 0x5088
// Size: 0x52
function function_91ef09(a_potential_targets, n_index) {
    s_turret = _get_turret_data(n_index);
    return [[ s_turret.var_187a0a9 ]](a_potential_targets, n_index);
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xc52c488c, Offset: 0x50e8
// Size: 0xc4
function function_b6eca136(a_potential_targets, n_index) {
    e_best_target = undefined;
    while (!isdefined(e_best_target) && a_potential_targets.size > 0) {
        e_closest_target = arraygetclosest(self.origin, a_potential_targets);
        if (!isdefined(e_closest_target)) {
            break;
        }
        if (self can_hit_target(e_closest_target, n_index)) {
            e_best_target = e_closest_target;
            continue;
        }
        arrayremovevalue(a_potential_targets, e_closest_target);
    }
    return e_best_target;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xcaef113f, Offset: 0x51b8
// Size: 0x2a
function function_40d1f6f5(a_potential_targets, n_index) {
    return function_b6eca136(a_potential_targets, n_index);
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x660cc1ec, Offset: 0x51f0
// Size: 0x2a
function function_d0f7a33c(a_potential_targets, n_index) {
    return function_b6eca136(a_potential_targets, n_index);
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x4be5d7ce, Offset: 0x5228
// Size: 0x2a
function function_2276a7b7(a_potential_targets, n_index) {
    return function_b6eca136(a_potential_targets, n_index);
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0xe7c401ca, Offset: 0x5260
// Size: 0x22c
function can_hit_target(e_target, n_index) {
    s_turret = _get_turret_data(n_index);
    v_offset = _get_default_target_offset(e_target, n_index);
    b_current_target = is_target(e_target, n_index);
    if (isdefined(e_target.ignoreme) && isdefined(e_target) && e_target.ignoreme) {
        return false;
    }
    var_a060fd9d = is_target_in_view(isplayer(e_target) ? e_target gettagorigin("tag_eye") : e_target.origin + v_offset, n_index);
    b_trace_passed = 1;
    if (var_a060fd9d) {
        if (!s_turret.b_ignore_line_of_sight) {
            b_trace_passed = trace_test(e_target, v_offset - (0, 0, isdefined(s_turret.n_torso_targetting_offset) ? s_turret.n_torso_targetting_offset : isvehicle(e_target) ? 0 : 0), n_index);
        }
        if (b_current_target && !b_trace_passed && !isdefined(s_turret.n_time_lose_sight)) {
            s_turret.n_time_lose_sight = gettime();
        }
    } else if (b_current_target) {
        s_turret.var_20de07b0 = 1;
    }
    return var_a060fd9d && b_trace_passed;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x389ee6bc, Offset: 0x5498
// Size: 0x234
function is_target_in_view(v_target, n_index) {
    /#
        _update_turret_arcs(n_index);
    #/
    s_turret = _get_turret_data(n_index);
    var_ef4a39d3 = self gettagorigin(s_turret.str_tag_pivot);
    var_abd92018 = vectortoangles(v_target - var_ef4a39d3);
    var_d433358d = s_turret.var_d433358d + self.angles[0];
    var_c0de8e7a = s_turret.var_c0de8e7a + self.angles[1];
    var_fbd3a8cf = angleclamp180(var_abd92018[0] - var_d433358d);
    var_f202ddd4 = angleclamp180(var_abd92018[1] - var_c0de8e7a);
    var_87b830c2 = 0;
    if (var_fbd3a8cf > 0) {
        if (var_fbd3a8cf > s_turret.bottomarc) {
            var_87b830c2 = 1;
        }
    } else if (abs(var_fbd3a8cf) > s_turret.toparc) {
        var_87b830c2 = 1;
    }
    if (var_f202ddd4 > 0) {
        if (var_f202ddd4 > s_turret.leftarc) {
            var_87b830c2 = 1;
        }
    } else if (abs(var_f202ddd4) > s_turret.rightarc) {
        var_87b830c2 = 1;
    }
    return !var_87b830c2;
}

// Namespace turret
// Params 3, eflags: 0x1 linked
// Checksum 0x9e7a2957, Offset: 0x56d8
// Size: 0x2ce
function trace_test(e_target, v_offset, n_index) {
    if (!isdefined(v_offset)) {
        v_offset = (0, 0, 0);
    }
    if (isdefined(self.good_old_style_turret_tracing)) {
        s_turret = _get_turret_data(n_index);
        v_start_org = self gettagorigin(s_turret.str_tag_pivot);
        if (e_target sightconetrace(v_start_org, self) > 0.2) {
            v_target = e_target.origin + v_offset;
            v_start_org += vectornormalize(v_target - v_start_org) * 50;
            a_trace = bullettrace(v_start_org, v_target, 1, s_turret.e_trace_ignore, 1, 1);
            if (a_trace["fraction"] > 0.6) {
                return true;
            }
        }
        return false;
    }
    s_turret = _get_turret_data(n_index);
    v_start_org = self gettagorigin(s_turret.str_tag_pivot);
    v_target = e_target.origin + v_offset;
    if (sessionmodeismultiplayergame() && isplayer(e_target)) {
        v_target = e_target getshootatpos();
    }
    if (distancesquared(v_start_org, v_target) < 10000) {
        return true;
    }
    v_dir_to_target = vectornormalize(v_target - v_start_org);
    if (!sessionmodeismultiplayergame()) {
        v_start_org += v_dir_to_target * 50;
        v_target -= v_dir_to_target * 75;
    }
    if (sighttracepassed(v_start_org, v_target, 0, self)) {
        return true;
    }
    return false;
}

// Namespace turret
// Params 2, eflags: 0x1 linked
// Checksum 0x6bde41d3, Offset: 0x59b0
// Size: 0x4c
function set_ignore_line_of_sight(b_ignore, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.b_ignore_line_of_sight = b_ignore;
}

// Namespace turret
// Params 2, eflags: 0x0
// Checksum 0x36ac5a1c, Offset: 0x5a08
// Size: 0x4c
function set_occupy_no_target_time(time, n_index) {
    s_turret = _get_turret_data(n_index);
    s_turret.occupy_no_target_time = time;
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x26e31abc, Offset: 0x5a60
// Size: 0x2c
function toggle_lensflare(bool) {
    self clientfield::set("toggle_lensflare", bool);
}

// Namespace turret
// Params 0, eflags: 0x1 linked
// Checksum 0x3ac4df0a, Offset: 0x5a98
// Size: 0x14c
function track_lens_flare() {
    self endon(#"death");
    self notify(#"disable_lens_flare");
    self endon(#"disable_lens_flare");
    while (true) {
        e_target = self gettargetentity();
        if (isdefined(e_target) && self.turretontarget && isplayer(e_target)) {
            if (isdefined(self gettagorigin("TAG_LASER"))) {
                e_target util::waittill_player_looking_at(self gettagorigin("TAG_LASER"), 90);
                if (isdefined(e_target)) {
                    self toggle_lensflare(1);
                    e_target util::waittill_player_not_looking_at(self gettagorigin("TAG_LASER"));
                }
                self toggle_lensflare(0);
            }
        }
        wait(0.5);
    }
}

// Namespace turret
// Params 1, eflags: 0x1 linked
// Checksum 0x816eb9e0, Offset: 0x5bf0
// Size: 0x82
function _get_gunner_tag_for_turret_index(n_index) {
    switch (n_index) {
    case 1:
        return "tag_gunner1";
    case 2:
        return "tag_gunner2";
    case 3:
        return "tag_gunner3";
    case 4:
        return "tag_gunner4";
    default:
        assertmsg("robot");
        break;
    }
}

// Namespace turret
// Params 1, eflags: 0x0
// Checksum 0xbe0d6453, Offset: 0x5c80
// Size: 0x56
function function_69ced6d1(str_tag) {
    switch (str_tag) {
    case 44:
        return 1;
    case 45:
        return 2;
    case 46:
        return 3;
    case 47:
        return 4;
    }
}

