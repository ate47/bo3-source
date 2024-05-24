#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_f37770c8;

// Namespace namespace_f37770c8
// Params 0, eflags: 0x2
// Checksum 0x66117b17, Offset: 0x850
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_craftables", &__init__, &__main__, undefined);
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0xb68c2118, Offset: 0x898
// Size: 0x24
function __init__() {
    callback::on_finalize_initialization(&function_faa00f7e);
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x8162ab00, Offset: 0x8c8
// Size: 0x16c
function init() {
    if (!isdefined(level.var_29ae0891)) {
        level.var_29ae0891 = 1;
    }
    var_fbb993ee = [];
    level.var_206a8bc4 = [];
    level.var_84ae2a3c = [];
    level.var_5c007ed5 = [];
    if (!isdefined(level.var_90238c9a)) {
        level.var_90238c9a = 0;
    }
    level._effect["building_dust"] = "zombie/fx_crafting_dust_zmb";
    if (isdefined(level.var_95743e9f)) {
        [[ level.var_95743e9f ]]();
    }
    var_411881a8 = spawnstruct();
    var_411881a8.name = "open_table";
    var_411881a8.var_41f0f8cd = &function_e8f4e83;
    var_411881a8.var_855e2ef2 = &function_b4d529ef;
    function_ac4e44a7(var_411881a8);
    function_8421d708("open_table", %);
    if (isdefined(level.var_20e5af3d)) {
        callback::on_connect(&function_f5a17fbe);
    }
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x29762d24, Offset: 0xa40
// Size: 0x34
function __main__() {
    level thread function_e6d6a7f();
    /#
        level thread function_bd335247();
    #/
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x1f4c0898, Offset: 0xa80
// Size: 0x24
function function_faa00f7e() {
    function_bc39c454(level.var_a7e9c2bf.size);
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xe2226fa, Offset: 0xab0
// Size: 0x130
function function_13eee6c0(player) {
    if (player laststand::player_is_in_laststand() || player zm_utility::in_revive_trigger()) {
        self.hint_string = "";
        return false;
    }
    if (isdefined(player.is_drinking) && player.is_drinking > 0) {
        self.hint_string = "";
        return false;
    }
    if (isdefined(player.var_ea2cf068)) {
        self.hint_string = "";
        return false;
    }
    initial_current_weapon = player getcurrentweapon();
    current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
    if (zm_equipment::is_equipment(current_weapon)) {
        self.hint_string = "";
        return false;
    }
    return true;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x1b30ceac, Offset: 0xbe8
// Size: 0x26
function function_292d2b12() {
    if (isdefined(self.var_9351fe46)) {
        return self.var_9351fe46.origin;
    }
    return self.origin;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x64b823f8, Offset: 0xc18
// Size: 0x64
function function_f6b6c76e(trigger) {
    if (isdefined(self.var_b559aeb4)) {
        trigger enablelinkto();
        trigger linkto(self.var_b559aeb4);
        trigger setmovingplatformenabled(1);
    }
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x944dc059, Offset: 0xc88
// Size: 0x200
function function_f5a17fbe() {
    self endon(#"disconnect");
    self notify(#"hash_f5a17fbe");
    self endon(#"hash_f5a17fbe");
    while (true) {
        zombie = self waittill(#"hash_11e36150");
        if (distancesquared(zombie.origin, self.origin) > zombie.meleeattackdist * zombie.meleeattackdist) {
            continue;
        }
        trigger = level._unitriggers.trigger_pool[self getentitynumber()];
        if (isdefined(trigger) && isdefined(trigger.stub.piece)) {
            piece = trigger.stub.piece;
            if (!isdefined(piece.damage)) {
                piece.damage = 0;
            }
            piece.damage++;
            if (piece.damage > 12) {
                thread zm_equipment::function_c9a8ab09(trigger.stub zm_unitrigger::unitrigger_origin());
                piece function_edaecb6a();
                self zm_stats::increment_client_stat("cheat_total", 0);
                if (isalive(self)) {
                    self playlocalsound(level.zmb_laugh_alias);
                }
            }
        }
    }
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0x1d645e4, Offset: 0xe90
// Size: 0x74
function explosiondamage(damage, pos) {
    /#
        println("toplayer" + damage + "toplayer" + self.name + "toplayer");
    #/
    self dodamage(damage, pos);
}

// Namespace namespace_f37770c8
// Params 4, eflags: 0x1 linked
// Checksum 0x341b1e35, Offset: 0xf10
// Size: 0xc4
function function_c86d092(var_deec1671, str_model, v_angle_offset, v_origin_offset) {
    /#
        assert(isdefined(level.var_a7e9c2bf[var_deec1671]), "toplayer" + var_deec1671 + "toplayer");
    #/
    var_3111271f = level.var_a7e9c2bf[var_deec1671];
    var_3111271f.var_96eb2fa1 = 1;
    var_3111271f.str_model = str_model;
    var_3111271f.v_angle_offset = v_angle_offset;
    var_3111271f.v_origin_offset = v_origin_offset;
}

// Namespace namespace_f37770c8
// Params 6, eflags: 0x1 linked
// Checksum 0x37c6798d, Offset: 0xfe0
// Size: 0x16a
function function_8421d708(var_9967ff1, var_d6fd6d9d, var_69ab0bb, var_6cabc9d6, var_2722b673, var_7b17f7f1) {
    if (!isdefined(level.var_b09bbe80)) {
        level.var_b09bbe80 = [];
    }
    if (isdefined(level.var_b09bbe80) && !isdefined(level.var_b09bbe80[var_9967ff1])) {
        return;
    }
    if (isdefined(var_d6fd6d9d)) {
    }
    if (isdefined(var_69ab0bb)) {
    }
    var_eca16733 = level.var_b09bbe80[var_9967ff1];
    if (!isdefined(level.var_a7e9c2bf)) {
        level.var_a7e9c2bf = [];
    }
    var_eca16733.var_d6fd6d9d = var_d6fd6d9d;
    var_eca16733.var_69ab0bb = var_69ab0bb;
    var_eca16733.var_6cabc9d6 = var_6cabc9d6;
    var_eca16733.var_2722b673 = var_2722b673;
    var_eca16733.var_7b17f7f1 = var_7b17f7f1;
    /#
        println("toplayer" + var_eca16733.name);
    #/
    level.var_a7e9c2bf[var_eca16733.name] = var_eca16733;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xd2ca9b18, Offset: 0x1158
// Size: 0x44
function function_21cc3865(var_9967ff1, var_d983bb0b) {
    if (isdefined(level.var_a7e9c2bf[var_9967ff1])) {
        level.var_a7e9c2bf[var_9967ff1].var_d983bb0b = var_d983bb0b;
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xc078ac9, Offset: 0x11a8
// Size: 0x56
function function_b98972f1(var_9967ff1) {
    if (isdefined(level.var_a7e9c2bf[var_9967ff1])) {
        return (isdefined(level.var_a7e9c2bf[var_9967ff1].var_d983bb0b) && level.var_a7e9c2bf[var_9967ff1].var_d983bb0b);
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xd0a73503, Offset: 0x1208
// Size: 0x44
function function_a44e7016(var_9967ff1, build_time) {
    if (isdefined(level.var_a7e9c2bf[var_9967ff1])) {
        level.var_a7e9c2bf[var_9967ff1].usetime = build_time;
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x3cefed7, Offset: 0x1258
// Size: 0x64
function function_bc39c454(n_count) {
    bits = getminbitcountfornum(n_count);
    registerclientfield("toplayer", "craftable", 1, bits, "int");
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xaf93c7e3, Offset: 0x12c8
// Size: 0x40
function function_b2caef35(var_9967ff1, var_5dbbf224) {
    var_eca16733 = level.var_b09bbe80[var_9967ff1];
    var_eca16733.var_5dbbf224 = var_5dbbf224;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x3799bdb7, Offset: 0x1310
// Size: 0xd4
function function_ac4e44a7(var_e312521d) {
    if (!isdefined(level.var_b09bbe80)) {
        level.var_b09bbe80 = [];
    }
    if (!isdefined(level.var_21469b77)) {
        level.var_21469b77 = 0;
    }
    /#
        println("toplayer" + var_e312521d.name);
    #/
    level.var_b09bbe80[var_e312521d.name] = var_e312521d;
    var_e312521d.hash_id = hashstring(var_e312521d.name);
    /#
        level thread function_6442c1bd(var_e312521d);
    #/
}

// Namespace namespace_f37770c8
// Params 18, eflags: 0x1 linked
// Checksum 0x9b3c5d7, Offset: 0x13f0
// Size: 0x46c
function function_5cf75ff1(var_dba2448c, piecename, radius, height, drop_offset, var_9b0dedbc, onpickup, ondrop, var_8308120f, var_ef9e5ad3, tag_name, var_e719aa0c, var_914bf4e3, var_6dd4b013, var_5dbbf224, var_f36883de, hint_string, slot) {
    if (!isdefined(var_6dd4b013)) {
        var_6dd4b013 = 0;
    }
    if (!isdefined(var_f36883de)) {
        var_f36883de = 0;
    }
    if (!isdefined(slot)) {
        slot = 0;
    }
    var_da5b715d = spawnstruct();
    var_c1c86479 = [];
    if (!isdefined(piecename)) {
        /#
            assertmsg("toplayer");
        #/
    }
    var_e9b04b86 = struct::get_array(var_dba2448c + "_" + piecename, "targetname");
    if (!isdefined(level.var_4ea4afff)) {
        level.var_4ea4afff = 0;
    }
    foreach (index, struct in var_e9b04b86) {
        var_c1c86479[index] = struct;
        var_c1c86479[index].hasspawned = 0;
    }
    var_da5b715d.spawns = var_c1c86479;
    var_da5b715d.var_dba2448c = var_dba2448c;
    var_da5b715d.piecename = piecename;
    if (var_c1c86479.size) {
        var_da5b715d.modelname = var_c1c86479[0].model;
    }
    var_da5b715d.var_9b0dedbc = var_9b0dedbc;
    var_da5b715d.radius = radius;
    var_da5b715d.height = height;
    var_da5b715d.tag_name = tag_name;
    var_da5b715d.var_e719aa0c = var_e719aa0c;
    var_da5b715d.drop_offset = drop_offset;
    var_da5b715d.var_1f11a800 = 256;
    var_da5b715d.onpickup = onpickup;
    var_da5b715d.ondrop = ondrop;
    var_da5b715d.var_8308120f = var_8308120f;
    var_da5b715d.var_ef9e5ad3 = var_ef9e5ad3;
    var_da5b715d.var_6dd4b013 = var_6dd4b013;
    var_da5b715d.var_5dbbf224 = var_5dbbf224;
    var_da5b715d.hint_string = hint_string;
    var_da5b715d.var_fbfd6aca = slot;
    var_da5b715d.hash_id = hashstring(piecename);
    if (isdefined(var_f36883de) && var_f36883de) {
        var_da5b715d.var_f36883de = var_f36883de;
    }
    if (isdefined(var_914bf4e3)) {
        if (isdefined(var_6dd4b013) && var_6dd4b013) {
            /#
                assert(isstring(var_914bf4e3), "toplayer" + piecename + "toplayer");
            #/
            var_da5b715d.var_c05b32e7 = var_914bf4e3;
        } else {
            var_da5b715d.var_dcc30f2f = var_914bf4e3;
        }
    }
    return var_da5b715d;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x0
// Checksum 0xa9017466, Offset: 0x1868
// Size: 0x30
function function_16997d67(var_1f11a800) {
    self.var_1f11a800 = var_1f11a800;
    self.var_e21fa495 = 1;
    self.var_2ddfcdb3 = [];
}

// Namespace namespace_f37770c8
// Params 3, eflags: 0x0
// Checksum 0x2730d066, Offset: 0x18a0
// Size: 0x138
function function_5a83796f(piece1, piece2, piece3) {
    var_b163cdfa = piece1.spawns;
    var_8b615391 = piece2.spawns;
    spawns = arraycombine(var_b163cdfa, var_8b615391, 1, 0);
    if (isdefined(piece3)) {
        var_655ed928 = piece3.spawns;
        spawns = arraycombine(spawns, var_655ed928, 1, 0);
        spawns = array::randomize(spawns);
        piece3.spawns = spawns;
    } else {
        spawns = array::randomize(spawns);
    }
    piece1.spawns = spawns;
    piece2.spawns = spawns;
}

// Namespace namespace_f37770c8
// Params 3, eflags: 0x1 linked
// Checksum 0xe6cdc6a1, Offset: 0x19e0
// Size: 0xe4
function function_b0deb4e6(var_da5b715d, tag_name, var_e719aa0c) {
    if (!isdefined(self.var_7a5f63bc)) {
        self.var_7a5f63bc = [];
    }
    if (isdefined(tag_name)) {
        var_da5b715d.tag_name = tag_name;
    }
    if (isdefined(var_e719aa0c)) {
        var_da5b715d.var_e719aa0c = var_e719aa0c;
    }
    self.var_7a5f63bc[self.var_7a5f63bc.size] = var_da5b715d;
    if (!isdefined(self.var_fbfd6aca)) {
        self.var_fbfd6aca = var_da5b715d.var_fbfd6aca;
    }
    /#
        /#
            assert(self.var_fbfd6aca == var_da5b715d.var_fbfd6aca, "toplayer");
        #/
    #/
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x1d4e0cac, Offset: 0x1ad0
// Size: 0x3c
function function_2ceeda59(slot) {
    self endon("craftable_piece_released" + slot);
    self waittill(#"bled_out");
    function_920996b7();
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x82446e2d, Offset: 0x1b18
// Size: 0x19a
function function_920996b7() {
    if (!isdefined(self.var_1666fe57)) {
        self.var_1666fe57 = [];
    }
    foreach (index, piece in self.var_1666fe57) {
        if (isdefined(piece)) {
            var_d29e0e53 = 0;
            if (isdefined(level.var_510e575a)) {
                if (!self [[ level.var_510e575a ]](piece)) {
                    var_d29e0e53 = 1;
                }
            }
            if (var_d29e0e53) {
                piece function_695b1f07();
            } else {
                piece function_695b1f07(self.origin + (5, 5, 0), self.angles);
            }
            if (isdefined(piece.ondrop)) {
                piece [[ piece.ondrop ]](self);
            }
            self clientfield::set_to_player("craftable", 0);
        }
        self.var_1666fe57[index] = undefined;
        self notify("craftable_piece_released" + index);
    }
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0xe1ec01dd, Offset: 0x1cc0
// Size: 0x36
function function_b80130fa() {
    if (isdefined(self.var_9351fe46)) {
        return (self.var_9351fe46.origin + (0, 0, 12));
    }
    return self.origin;
}

// Namespace namespace_f37770c8
// Params 9, eflags: 0x1 linked
// Checksum 0x2b49f85c, Offset: 0x1d00
// Size: 0x3d0
function function_de125e20(classname, origin, angles, flags, radius, script_height, hint_string, moving, var_a4cf614) {
    if (!isdefined(radius)) {
        radius = 64;
    }
    if (!isdefined(script_height)) {
        script_height = 64;
    }
    script_width = script_height;
    if (!isdefined(script_width)) {
        script_width = 64;
    }
    script_length = script_height;
    if (!isdefined(script_length)) {
        script_length = 64;
    }
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = origin;
    if (isdefined(script_length)) {
        unitrigger_stub.script_length = script_length;
    } else {
        unitrigger_stub.script_length = 13.5;
    }
    if (isdefined(script_width)) {
        unitrigger_stub.script_width = script_width;
    } else {
        unitrigger_stub.script_width = 27.5;
    }
    if (isdefined(script_height)) {
        unitrigger_stub.script_height = script_height;
    } else {
        unitrigger_stub.script_height = 24;
    }
    unitrigger_stub.radius = radius;
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    if (isdefined(hint_string)) {
        unitrigger_stub.var_b15b61c9 = hint_string;
        unitrigger_stub.hint_string = unitrigger_stub.var_b15b61c9;
    } else {
        unitrigger_stub.hint_string = %ZOMBIE_BUILD_PIECE_GRAB;
    }
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    if (isdefined(int(var_a4cf614)) && isdefined(var_a4cf614) && int(var_a4cf614)) {
        unitrigger_stub.require_look_toward = 0;
    }
    unitrigger_stub.require_look_at = 0;
    switch (classname) {
    case 20:
        unitrigger_stub.script_unitrigger_type = "unitrigger_radius";
        break;
    case 21:
        unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
        break;
    case 18:
        unitrigger_stub.script_unitrigger_type = "unitrigger_box";
        break;
    case 19:
        unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
        break;
    }
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    unitrigger_stub.prompt_and_visibility_func = &function_a561dc8e;
    unitrigger_stub.originfunc = &function_b80130fa;
    unitrigger_stub.onspawnfunc = &function_f6b6c76e;
    if (isdefined(moving) && moving) {
        zm_unitrigger::register_unitrigger(unitrigger_stub, &function_cb87ebff);
    } else {
        zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_cb87ebff);
    }
    return unitrigger_stub;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x5092700a, Offset: 0x20d8
// Size: 0xa0
function function_a561dc8e(player) {
    if (!isdefined(player.var_1666fe57)) {
        player.var_1666fe57 = [];
    }
    can_use = self.stub function_7bb3b408(player);
    self setinvisibletoplayer(player, !can_use);
    self sethintstring(self.stub.hint_string);
    return can_use;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xcd12df50, Offset: 0x2180
// Size: 0x1a4
function function_7bb3b408(player, slot) {
    if (!isdefined(slot)) {
        slot = self.piece.var_fbfd6aca;
    }
    if (!self function_13eee6c0(player)) {
        return false;
    }
    if (isdefined(player.var_1666fe57[slot]) && !(isdefined(self.piece.var_6dd4b013) && self.piece.var_6dd4b013)) {
        if (!level.var_29ae0891) {
            self.hint_string = %ZOMBIE_CRAFTABLE_NO_SWITCH;
        } else {
            var_e7ed5ec2 = self.piece;
            var_2b77cf72 = player.var_1666fe57[slot];
            if (var_e7ed5ec2.piecename == var_2b77cf72.piecename && var_e7ed5ec2.var_dba2448c == var_2b77cf72.var_dba2448c) {
                self.hint_string = "";
                return false;
            }
            if (isdefined(self.var_b15b61c9)) {
                self.hint_string = self.var_b15b61c9;
            } else {
                self.hint_string = %ZOMBIE_BUILD_PIECE_SWITCH;
            }
        }
    } else if (isdefined(self.var_b15b61c9)) {
        self.hint_string = self.var_b15b61c9;
    } else {
        self.hint_string = %ZOMBIE_BUILD_PIECE_GRAB;
    }
    return true;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0xf3c80829, Offset: 0x2330
// Size: 0x1d8
function function_cb87ebff() {
    self endon(#"kill_trigger");
    slot = self.stub.piece.var_fbfd6aca;
    while (true) {
        player = self waittill(#"trigger");
        self.stub notify(#"trigger", player);
        if (player != self.parent_player) {
            continue;
        }
        if (isdefined(player.var_ea2cf068)) {
            continue;
        }
        if (!level.var_29ae0891 && isdefined(player.var_1666fe57[slot]) && !(isdefined(self.stub.piece.var_6dd4b013) && self.stub.piece.var_6dd4b013)) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            player thread zm_utility::ignore_triggers(0.5);
            continue;
        }
        status = player function_295c63ba(self.stub.piece);
        if (!status) {
            self.stub.hint_string = "";
            self sethintstring(self.stub.hint_string);
            continue;
        }
        player thread function_d1aff147(self.stub.piece);
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xecef8bfb, Offset: 0x2510
// Size: 0x1e
function function_295c63ba(piece) {
    if (!isdefined(piece)) {
        return false;
    }
    return true;
}

/#

    // Namespace namespace_f37770c8
    // Params 2, eflags: 0x1 linked
    // Checksum 0xda0d3809, Offset: 0x2538
    // Size: 0x7c
    function function_38d45929(from, to) {
        time = 20;
        while (time > 0) {
            line(from, to, (0, 0, 1), 0, 1);
            time -= 0.05;
            wait(0.05);
        }
    }

#/

// Namespace namespace_f37770c8
// Params 6, eflags: 0x1 linked
// Checksum 0xeb918051, Offset: 0x25c0
// Size: 0x394
function function_1212a0d0(piece, origin, dir, var_c15f8229, var_a0210dd, endangles) {
    /#
        assert(isdefined(piece));
    #/
    if (isdefined(piece)) {
        /#
            thread function_38d45929(origin, origin + dir);
        #/
        pass = 0;
        done = 0;
        var_d9784f9d = undefined;
        while (pass < 2 && !done) {
            grenade = self magicgrenadetype("buildable_piece", origin, dir, 30000);
            grenade thread function_ce05366f();
            grenade ghost();
            if (!isdefined(var_d9784f9d)) {
                var_d9784f9d = spawn("script_model", grenade.origin);
                var_d9784f9d setmodel(piece.modelname);
            }
            var_d9784f9d.origin = grenade.angles;
            var_d9784f9d.angles = grenade.angles;
            var_d9784f9d linkto(grenade, "", (0, 0, 0), (0, 0, 0));
            grenade.var_d9784f9d = var_d9784f9d;
            grenade waittill(#"stationary");
            grenade_origin = grenade.origin;
            var_8c631a30 = grenade.angles;
            var_ecfd7257 = grenade getgroundent();
            grenade delete();
            if (isdefined(var_ecfd7257) && var_ecfd7257 == level) {
                done = 1;
                continue;
            }
            origin = grenade_origin;
            dir = (dir[0] * -1 / 10, dir[1] * -1 / 10, -1);
            pass++;
        }
        if (!isdefined(endangles)) {
            endangles = var_8c631a30;
        }
        piece function_695b1f07(grenade_origin, endangles);
        if (isdefined(var_d9784f9d)) {
            var_d9784f9d delete();
        }
        if (isdefined(piece.ondrop)) {
            piece [[ piece.ondrop ]](self);
        }
        if (isdefined(var_c15f8229) && var_c15f8229) {
            piece function_389570e(var_a0210dd);
        }
    }
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0xce2ec3fd, Offset: 0x2960
// Size: 0x90
function function_ce05366f() {
    self endon(#"death");
    self endon(#"stationary");
    while (isdefined(self)) {
        pos, normal, ent = self waittill(#"grenade_bounce");
        if (isplayer(ent)) {
            ent explosiondamage(25, pos);
        }
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xbe217048, Offset: 0x29f8
// Size: 0x164
function function_389570e(var_a0210dd) {
    self endon(#"pickup");
    wait(0.15);
    if (isdefined(level.var_2526153a)) {
        playfxontag(level.var_2526153a, self.model, "tag_origin");
    } else {
        playfxontag(level._effect["powerup_on"], self.model, "tag_origin");
    }
    wait(var_a0210dd - 6);
    self function_9dc8b238();
    wait(1);
    self function_44bac33();
    wait(1);
    self function_9dc8b238();
    wait(1);
    self function_44bac33();
    wait(1);
    self function_9dc8b238();
    wait(1);
    self function_44bac33();
    wait(1);
    self notify(#"respawn");
    self function_edaecb6a();
    self function_695b1f07();
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x0
// Checksum 0x78ac59a5, Offset: 0x2b68
// Size: 0x9c
function function_a0487a3e(slot) {
    if (!isdefined(slot)) {
        slot = 0;
    }
    self notify("craftable_piece_released" + slot);
    piece = self.var_1666fe57[slot];
    self.var_1666fe57[slot] = undefined;
    if (isdefined(piece)) {
        piece function_695b1f07();
        self clientfield::set_to_player("craftable", 0);
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x713090f2, Offset: 0x2c10
// Size: 0x134
function function_987a9c58(slot) {
    if (!isdefined(slot)) {
        slot = 0;
    }
    self notify("craftable_piece_released" + slot);
    self endon("craftable_piece_released" + slot);
    self thread function_2ceeda59(slot);
    origin = self.origin;
    angles = self.angles;
    piece = self.var_1666fe57[slot];
    if (isdefined(piece) && isdefined(piece.start_origin)) {
        origin = piece.start_origin;
        angles = piece.start_angles;
    }
    self waittill(#"disconnect");
    piece function_695b1f07(origin, angles);
    if (isdefined(self)) {
        self clientfield::set_to_player("craftable", 0);
    }
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xa99deb56, Offset: 0x2d50
// Size: 0xe4
function function_441e3ef5(piece, slot) {
    if (!isdefined(piece)) {
        piece = self.var_1666fe57[slot];
    }
    if (isdefined(piece)) {
        piece.damage = 0;
        piece function_695b1f07(self.origin, self.angles);
        self clientfield::set_to_player("craftable", 0);
        if (isdefined(piece.ondrop)) {
            piece [[ piece.ondrop ]](self);
        }
    }
    self.var_1666fe57[slot] = undefined;
    self notify("craftable_piece_released" + slot);
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x17d5f1b5, Offset: 0x2e40
// Size: 0x2cc
function function_d1aff147(var_5b55e566) {
    var_da5b715d = var_5b55e566.var_da5b715d;
    slot = var_da5b715d.var_fbfd6aca;
    damage = var_5b55e566.damage;
    if (!isdefined(self.var_1666fe57)) {
        self.var_1666fe57 = [];
    }
    self notify("player_got_craftable_piece_for_" + var_5b55e566.var_dba2448c);
    if (!(isdefined(var_da5b715d.var_6dd4b013) && var_da5b715d.var_6dd4b013) && isdefined(self.var_1666fe57[slot])) {
        var_486f2fba = self.var_1666fe57[slot];
        self function_441e3ef5(self.var_f8ef2f24, slot);
        var_486f2fba.damage = damage;
        self zm_utility::do_player_general_vox("general", "craft_swap");
    }
    if (isdefined(var_da5b715d.onpickup)) {
        var_5b55e566 [[ var_da5b715d.onpickup ]](self);
    }
    if (isdefined(var_da5b715d.var_6dd4b013) && var_da5b715d.var_6dd4b013) {
        if (isdefined(var_da5b715d.var_c05b32e7)) {
            level clientfield::set(var_da5b715d.var_c05b32e7, 1);
        }
    } else if (isdefined(var_da5b715d.var_dcc30f2f)) {
        self clientfield::set_to_player("craftable", var_da5b715d.var_dcc30f2f);
    }
    var_5b55e566 function_edaecb6a();
    var_5b55e566 notify(#"pickup");
    if (isdefined(var_da5b715d.var_6dd4b013) && var_da5b715d.var_6dd4b013) {
        var_5b55e566.var_29f31875 = 1;
    } else {
        slot = var_5b55e566.var_fbfd6aca;
        self.var_1666fe57[slot] = var_5b55e566;
        self thread function_987a9c58(slot);
    }
    self function_12da47ae(var_5b55e566);
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0x6c578a7, Offset: 0x3118
// Size: 0x7c
function function_bae7d22a(piece, slot) {
    if (!isdefined(piece)) {
        piece = self.var_1666fe57[slot];
    }
    if (isdefined(piece)) {
        self clientfield::set_to_player("craftable", 0);
    }
    self.var_1666fe57[slot] = undefined;
    self notify("craftable_piece_released" + slot);
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x47112aa6, Offset: 0x31a0
// Size: 0x52
function function_4f6f06ab(location) {
    if (!isdefined(level.var_50d81c36)) {
        level.var_50d81c36 = [];
    }
    if (!isdefined(level.var_50d81c36[location])) {
        level.var_50d81c36[location] = 1;
        return true;
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xbe93cabb, Offset: 0x3200
// Size: 0x182
function function_1c548f02(point) {
    candidate_list = [];
    foreach (zone in level.zones) {
        if (isdefined(zone.unitrigger_stubs)) {
            candidate_list = arraycombine(candidate_list, zone.unitrigger_stubs, 1, 0);
        }
    }
    valid_range = -128;
    closest = zm_unitrigger::get_closest_unitriggers(point, candidate_list, valid_range);
    for (index = 0; index < closest.size; index++) {
        if (isdefined(closest[index].registered) && closest[index].registered && isdefined(closest[index].piece)) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x2008be12, Offset: 0x3390
// Size: 0x2ce
function function_71b117bd(var_da5b715d) {
    self.var_b7b5e000 = 0;
    self.var_2d41e2dc = 1;
    self.var_da5b715d = var_da5b715d;
    if (self.spawns.size >= 1 && self.spawns.size > 1) {
        var_b32b10cf = 0;
        var_572d5c70 = 0;
        totalweight = 0;
        var_47fc28c9 = [];
        for (i = 0; i < self.spawns.size; i++) {
            if (isdefined(var_da5b715d.var_2ddfcdb3[i]) && var_da5b715d.var_2ddfcdb3[i]) {
                var_47fc28c9[i] = 0;
            } else if (function_1c548f02(self.spawns[i].origin)) {
                var_572d5c70 = 1;
                var_47fc28c9[i] = 0.01;
            } else {
                var_b32b10cf = 1;
                var_47fc28c9[i] = 1;
            }
            totalweight += var_47fc28c9[i];
        }
        /#
            /#
                assert(var_b32b10cf || var_572d5c70, "toplayer");
            #/
        #/
        if (var_b32b10cf) {
            totalweight = float(int(totalweight));
        }
        r = randomfloat(totalweight);
        for (i = 0; i < self.spawns.size; i++) {
            if (!var_b32b10cf || var_47fc28c9[i] >= 1) {
                r -= var_47fc28c9[i];
                if (r < 0) {
                    self.var_b7b5e000 = i;
                    var_da5b715d.var_2ddfcdb3[self.var_b7b5e000] = 1;
                    return;
                }
            }
        }
        self.var_b7b5e000 = randomint(self.spawns.size);
        var_da5b715d.var_2ddfcdb3[self.var_b7b5e000] = 1;
    }
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x89126b67, Offset: 0x3668
// Size: 0x3e
function function_bc606418() {
    if (isdefined(self.var_b7b5e000)) {
        self.var_da5b715d.var_2ddfcdb3[self.var_b7b5e000] = 0;
        self.var_b7b5e000 = undefined;
    }
    self.start_origin = undefined;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x558fc31e, Offset: 0x36b0
// Size: 0x138
function function_97b60807() {
    self.var_b7b5e000 = 0;
    if (self.spawns.size >= 1 && self.spawns.size > 1) {
        self.var_b7b5e000 = randomint(self.spawns.size);
        while (isdefined(self.spawns[self.var_b7b5e000].var_4f6f06ab) && !function_4f6f06ab(self.spawns[self.var_b7b5e000].var_4f6f06ab)) {
            arrayremoveindex(self.spawns, self.var_b7b5e000);
            if (self.spawns.size < 1) {
                self.var_b7b5e000 = 0;
                /#
                    println("toplayer");
                #/
                return;
            }
            self.var_b7b5e000 = randomint(self.spawns.size);
        }
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x6b059a5e, Offset: 0x37f0
// Size: 0x7c
function function_acdd19f8(num) {
    self.var_b7b5e000 = 0;
    if (self.spawns.size >= 1 && self.spawns.size > 1) {
        self.var_b7b5e000 = int(min(num, self.spawns.size - 1));
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xd2fc450e, Offset: 0x3878
// Size: 0x368
function function_b65c09b5(var_da5b715d) {
    if (self.spawns.size < 1) {
        return;
    }
    if (isdefined(self.var_2d41e2dc) && self.var_2d41e2dc) {
        if (!isdefined(self.var_b7b5e000)) {
            self function_71b117bd(self.var_da5b715d);
        }
    }
    if (!isdefined(self.var_b7b5e000)) {
        self.var_b7b5e000 = 0;
    }
    spawndef = self.spawns[self.var_b7b5e000];
    self.unitrigger = function_de125e20("trigger_radius_use", spawndef.origin + (0, 0, 12), spawndef.angles, 0, var_da5b715d.radius, var_da5b715d.height, var_da5b715d.hint_string, 0, spawndef.script_string);
    self.unitrigger.piece = self;
    self.radius = var_da5b715d.radius;
    self.height = var_da5b715d.height;
    self.var_dba2448c = var_da5b715d.var_dba2448c;
    self.piecename = var_da5b715d.piecename;
    self.modelname = var_da5b715d.modelname;
    self.var_9b0dedbc = var_da5b715d.var_9b0dedbc;
    self.tag_name = var_da5b715d.tag_name;
    self.drop_offset = var_da5b715d.drop_offset;
    self.start_origin = spawndef.origin;
    self.start_angles = spawndef.angles;
    self.var_dcc30f2f = var_da5b715d.var_dcc30f2f;
    self.var_6dd4b013 = var_da5b715d.var_6dd4b013;
    self.var_fbfd6aca = var_da5b715d.var_fbfd6aca;
    self.model = spawn("script_model", self.start_origin);
    if (isdefined(self.start_angles)) {
        self.model.angles = self.start_angles;
    }
    self.model setmodel(var_da5b715d.modelname);
    if (isdefined(var_da5b715d.onspawn)) {
        self [[ var_da5b715d.onspawn ]]();
    }
    self.model ghostindemo();
    self.model.var_9b0dedbc = var_da5b715d.var_9b0dedbc;
    self.var_da5b715d = var_da5b715d;
    self.unitrigger.var_9351fe46 = self.model;
}

// Namespace namespace_f37770c8
// Params 3, eflags: 0x1 linked
// Checksum 0x89086e18, Offset: 0x3be8
// Size: 0x3e8
function function_695b1f07(origin, angles, var_2b258b1) {
    if (self.spawns.size < 1) {
        return;
    }
    if (isdefined(self.var_2d41e2dc) && self.var_2d41e2dc) {
        if (!isdefined(self.var_b7b5e000) && !isdefined(origin)) {
            self function_71b117bd(self.var_da5b715d);
            spawndef = self.spawns[self.var_b7b5e000];
            self.start_origin = spawndef.origin;
            self.start_angles = spawndef.angles;
        }
    } else if (!isdefined(self.var_b7b5e000)) {
        self.var_b7b5e000 = 0;
    }
    var_e0c8ed6b = (0, 0, 12);
    if (isdefined(var_2b258b1) && var_2b258b1) {
        self function_97b60807();
        spawndef = self.spawns[self.var_b7b5e000];
        self.start_origin = spawndef.origin;
        self.start_angles = spawndef.angles;
        origin = spawndef.origin;
        angles = spawndef.angles;
    } else {
        if (!isdefined(origin)) {
            origin = self.start_origin;
        } else {
            origin += (0, 0, self.drop_offset);
            var_e0c8ed6b -= (0, 0, self.drop_offset);
        }
        if (!isdefined(angles)) {
            angles = self.start_angles;
        }
        /#
            if (!isdefined(level.drop_offset)) {
                level.drop_offset = 0;
            }
            origin += (0, 0, level.drop_offset);
            var_e0c8ed6b -= (0, 0, level.drop_offset);
        #/
    }
    self.model = spawn("script_model", origin);
    if (isdefined(angles)) {
        self.model.angles = angles;
    }
    self.model setmodel(self.modelname);
    if (isdefined(level.var_22fd698d)) {
        if (![[ level.var_22fd698d ]](self.model)) {
            origin = self.start_origin;
            angles = self.start_angles;
            self.model.origin = origin;
            self.model.angles = angles;
        }
    }
    if (isdefined(self.onspawn)) {
        self [[ self.onspawn ]]();
    }
    self.unitrigger = function_de125e20("trigger_radius_use", origin + var_e0c8ed6b, angles, 0, self.radius, self.height, self.var_da5b715d.hint_string, isdefined(self.model.canmove) && self.model.canmove);
    self.unitrigger.piece = self;
    self.model.var_9b0dedbc = self.var_9b0dedbc;
    self.unitrigger.var_9351fe46 = self.model;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x647030c0, Offset: 0x3fd8
// Size: 0x8e
function function_edaecb6a() {
    if (isdefined(self.var_2d41e2dc) && self.var_2d41e2dc) {
        self function_bc606418();
    }
    if (isdefined(self.model)) {
        self.model delete();
    }
    self.model = undefined;
    if (isdefined(self.unitrigger)) {
        thread zm_unitrigger::unregister_unitrigger(self.unitrigger);
    }
    self.unitrigger = undefined;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x880d7b83, Offset: 0x4070
// Size: 0x2c
function function_9dc8b238() {
    if (isdefined(self.model)) {
        self.model ghost();
    }
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x6f0d7fec, Offset: 0x40a8
// Size: 0x2c
function function_44bac33() {
    if (isdefined(self.model)) {
        self.model show();
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xbec06037, Offset: 0x40e0
// Size: 0x22c
function function_66d7dd5f(var_da5b715d) {
    var_5b55e566 = spawnstruct();
    var_5b55e566.spawns = var_da5b715d.spawns;
    if (isdefined(var_da5b715d.var_e21fa495) && var_da5b715d.var_e21fa495) {
        var_5b55e566 function_71b117bd(var_da5b715d);
    } else if (isdefined(var_da5b715d.var_ef9e5ad3)) {
        var_5b55e566 function_acdd19f8(var_da5b715d.var_ef9e5ad3);
    } else {
        var_5b55e566 function_97b60807();
    }
    if (isdefined(var_da5b715d.var_e3aacab3)) {
        var_5b55e566 [[ var_da5b715d.var_e3aacab3 ]](var_da5b715d);
    } else {
        var_5b55e566 function_b65c09b5(var_da5b715d);
    }
    if (var_5b55e566.spawns.size >= 1) {
        var_5b55e566.var_9b0dedbc = var_da5b715d.var_9b0dedbc;
    }
    if (isdefined(var_da5b715d.onpickup)) {
        var_5b55e566.onpickup = var_da5b715d.onpickup;
    } else {
        var_5b55e566.onpickup = &function_7711c41c;
    }
    if (isdefined(var_da5b715d.ondrop)) {
        var_5b55e566.ondrop = var_da5b715d.ondrop;
    } else {
        var_5b55e566.ondrop = &function_43646525;
    }
    if (isdefined(var_da5b715d.var_8308120f)) {
        var_5b55e566.var_8308120f = var_da5b715d.var_8308120f;
    }
    return var_5b55e566;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xa183902e, Offset: 0x4318
// Size: 0x32c
function function_59bc965e(var_9967ff1, origin) {
    /#
        assert(isdefined(var_9967ff1));
    #/
    /#
        assert(isdefined(level.var_a7e9c2bf[var_9967ff1]), "toplayer" + var_9967ff1);
    #/
    craftable = level.var_a7e9c2bf[var_9967ff1];
    if (!isdefined(craftable.var_7a5f63bc)) {
        craftable.var_7a5f63bc = [];
    }
    level flag::wait_till("start_zombie_round_logic");
    craftablespawn = spawnstruct();
    craftablespawn.var_9967ff1 = var_9967ff1;
    if (!isdefined(craftablespawn.a_piecespawns)) {
        craftablespawn.a_piecespawns = [];
    }
    var_206a8bc4 = [];
    foreach (var_da5b715d in craftable.var_7a5f63bc) {
        if (!isdefined(craftablespawn.var_fbfd6aca)) {
            craftablespawn.var_fbfd6aca = var_da5b715d.var_fbfd6aca;
        }
        /#
            /#
                assert(craftablespawn.var_fbfd6aca == var_da5b715d.var_fbfd6aca, "toplayer");
            #/
        #/
        if (!isdefined(var_da5b715d.var_dcd93345)) {
            var_da5b715d.var_dcd93345 = 0;
        }
        if (isdefined(var_da5b715d.var_e719aa0c) && isdefined(var_da5b715d.var_5b55e566) && var_da5b715d.var_e719aa0c) {
            piece = var_da5b715d.var_5b55e566;
        } else if (var_da5b715d.var_dcd93345 >= var_da5b715d.var_1f11a800) {
            piece = var_da5b715d.var_5b55e566;
        } else {
            piece = function_66d7dd5f(var_da5b715d);
            var_da5b715d.var_5b55e566 = piece;
            var_da5b715d.var_dcd93345++;
        }
        craftablespawn.a_piecespawns[craftablespawn.a_piecespawns.size] = piece;
    }
    craftablespawn.stub = self;
    return craftablespawn;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x0
// Checksum 0xe23e7e74, Offset: 0x4650
// Size: 0xc4
function function_2f030b99(var_7df306d0) {
    trig = getent(var_7df306d0, "targetname");
    if (!isdefined(trig)) {
        return;
    }
    if (isdefined(trig.target)) {
        model = getent(trig.target, "targetname");
        if (isdefined(model)) {
            model ghost();
            model notsolid();
        }
    }
}

// Namespace namespace_f37770c8
// Params 6, eflags: 0x1 linked
// Checksum 0x3edb7e66, Offset: 0x4720
// Size: 0x92
function function_56f80f8a(var_7df306d0, equipname, weaponname, var_e0a57996, delete_trigger, persistent) {
    trig = getent(var_7df306d0, "targetname");
    if (!isdefined(trig)) {
        return;
    }
    return function_4832d516(trig, equipname, weaponname, var_e0a57996, delete_trigger, persistent);
}

// Namespace namespace_f37770c8
// Params 6, eflags: 0x1 linked
// Checksum 0xe0edc495, Offset: 0x47c0
// Size: 0x11a
function function_779d19e8(var_7df306d0, equipname, weaponname, var_e0a57996, delete_trigger, persistent) {
    triggers = getentarray(var_7df306d0, "targetname");
    stubs = [];
    foreach (trig in triggers) {
        stubs[stubs.size] = function_4832d516(trig, equipname, weaponname, var_e0a57996, delete_trigger, persistent);
    }
    return stubs;
}

// Namespace namespace_f37770c8
// Params 6, eflags: 0x1 linked
// Checksum 0xe534b9b, Offset: 0x48e8
// Size: 0x9be
function function_4832d516(trig, equipname, weaponname, var_e0a57996, delete_trigger, persistent) {
    if (!isdefined(trig)) {
        return;
    }
    unitrigger_stub = spawnstruct();
    unitrigger_stub.var_e312521d = level.var_b09bbe80[equipname];
    angles = trig.script_angles;
    if (!isdefined(angles)) {
        angles = (0, 0, 0);
    }
    unitrigger_stub.origin = trig.origin + anglestoright(angles) * -6;
    unitrigger_stub.angles = trig.angles;
    if (isdefined(trig.script_angles)) {
        unitrigger_stub.angles = trig.script_angles;
    }
    unitrigger_stub.equipname = equipname;
    unitrigger_stub.weaponname = getweapon(weaponname);
    unitrigger_stub.var_e0a57996 = var_e0a57996;
    unitrigger_stub.delete_trigger = delete_trigger;
    unitrigger_stub.crafted = 0;
    unitrigger_stub.persistent = persistent;
    unitrigger_stub.usetime = int(3000);
    if (isdefined(self.usetime)) {
        unitrigger_stub.usetime = self.usetime;
    } else if (isdefined(trig.usetime)) {
        unitrigger_stub.usetime = trig.usetime;
    }
    unitrigger_stub.onbeginuse = &function_de0824;
    unitrigger_stub.onenduse = &function_bc83d6c;
    unitrigger_stub.onuse = &function_b7c96663;
    unitrigger_stub.oncantuse = &function_b7a4981d;
    tmins = trig getmins();
    tmaxs = trig getmaxs();
    tsize = tmaxs - tmins;
    if (isdefined(trig.script_depth)) {
        unitrigger_stub.script_length = trig.script_depth;
    } else {
        unitrigger_stub.script_length = tsize[1];
    }
    if (isdefined(trig.script_width)) {
        unitrigger_stub.script_width = trig.script_width;
    } else {
        unitrigger_stub.script_width = tsize[0];
    }
    if (isdefined(trig.script_height)) {
        unitrigger_stub.script_height = trig.script_height;
    } else {
        unitrigger_stub.script_height = tsize[2];
    }
    unitrigger_stub.target = trig.target;
    unitrigger_stub.targetname = trig.targetname;
    unitrigger_stub.script_noteworthy = trig.script_noteworthy;
    unitrigger_stub.script_parameters = trig.script_parameters;
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    if (isdefined(level.var_a7e9c2bf[equipname].var_d6fd6d9d)) {
        unitrigger_stub.hint_string = level.var_a7e9c2bf[equipname].var_d6fd6d9d;
    }
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.require_look_at = 1;
    unitrigger_stub.require_look_toward = 0;
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    if (isdefined(unitrigger_stub.var_e312521d.var_855e2ef2)) {
        unitrigger_stub.var_855e2ef2 = unitrigger_stub.var_e312521d.var_855e2ef2;
    }
    unitrigger_stub.prompt_and_visibility_func = &function_7029d54e;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_cfd8f554);
    unitrigger_stub.piece_trigger = trig;
    trig.trigger_stub = unitrigger_stub;
    if (isdefined(trig.zombie_weapon_upgrade)) {
        unitrigger_stub.zombie_weapon_upgrade = getweapon(trig.zombie_weapon_upgrade);
    }
    if (isdefined(unitrigger_stub.target)) {
        unitrigger_stub.model = getent(unitrigger_stub.target, "targetname");
        if (isdefined(unitrigger_stub.model)) {
            if (isdefined(unitrigger_stub.zombie_weapon_upgrade)) {
                unitrigger_stub.model useweaponhidetags(unitrigger_stub.zombie_weapon_upgrade);
            }
            if (isdefined(unitrigger_stub.model.script_parameters)) {
                a_utm_params = strtok(unitrigger_stub.model.script_parameters, " ");
                foreach (param in a_utm_params) {
                    if (param == "starts_visible") {
                        b_start_visible = 1;
                        continue;
                    }
                    if (param == "starts_empty") {
                        b_start_empty = 1;
                    }
                }
            }
            if (b_start_visible !== 1) {
                unitrigger_stub.model ghost();
                unitrigger_stub.model notsolid();
            }
        }
    }
    if (unitrigger_stub.equipname == "open_table") {
        unitrigger_stub.var_2314709e = [];
        unitrigger_stub.var_d930687 = -1;
        unitrigger_stub.var_5cc99b23 = 0;
    }
    unitrigger_stub.craftablespawn = unitrigger_stub function_59bc965e(equipname, unitrigger_stub.origin);
    if (isdefined(unitrigger_stub.model) && b_start_empty === 1) {
        for (i = 0; i < unitrigger_stub.craftablespawn.a_piecespawns.size; i++) {
            if (isdefined(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name)) {
                if (unitrigger_stub.craftablespawn.a_piecespawns[i].crafted !== 1) {
                    unitrigger_stub.model hidepart(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name);
                    continue;
                }
                unitrigger_stub.model showpart(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name);
            }
        }
    }
    if (delete_trigger) {
        trig delete();
    }
    level.var_5c007ed5[level.var_5c007ed5.size] = unitrigger_stub;
    return unitrigger_stub;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x0
// Checksum 0xd6f38731, Offset: 0x52b0
// Size: 0xa2
function function_6e06b367() {
    unitrigger_stub = spawnstruct();
    unitrigger_stub.var_e312521d = level.var_b09bbe80[self.name];
    unitrigger_stub.equipname = self.name;
    unitrigger_stub.craftablespawn = unitrigger_stub function_59bc965e(self.name, unitrigger_stub.origin);
    level.var_5c007ed5[level.var_5c007ed5.size] = unitrigger_stub;
    return unitrigger_stub;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x45d6a19f, Offset: 0x5360
// Size: 0x92
function function_b008df77(piece) {
    for (i = 0; i < self.a_piecespawns.size; i++) {
        if (self.a_piecespawns[i].piecename == piece.piecename && self.a_piecespawns[i].var_dba2448c == piece.var_dba2448c) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x0
// Checksum 0xecb2808, Offset: 0x5400
// Size: 0x50
function function_8b2b97f4() {
    if (self.var_9967ff1 == "open_table" && self.var_d930687 != -1) {
        return self.stub.var_2314709e[self.var_d930687];
    }
    return self.stub;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0xd68bd4cf, Offset: 0x5458
// Size: 0x94
function function_7fb0b698() {
    if (self.var_9967ff1 == "open_table" && self.stub.var_d930687 != -1 && isdefined(self.stub.var_2314709e[self.stub.var_d930687].craftablespawn)) {
        return self.stub.var_2314709e[self.stub.var_d930687].craftablespawn;
    }
    return self;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0xe4bc0bf7, Offset: 0x54f8
// Size: 0x204
function function_f254fe3d() {
    var_d7223f7a = self.stub;
    if (isdefined(var_d7223f7a.var_d930687) && var_d7223f7a.var_d930687 != -1 && isdefined(var_d7223f7a.var_2314709e[var_d7223f7a.var_d930687])) {
        return true;
    }
    if (isdefined(var_d7223f7a.var_e312521d.var_7b17f7f1) && var_d7223f7a.var_e312521d.var_7b17f7f1) {
        foreach (piece in self.a_piecespawns) {
            if (!(isdefined(piece.var_29f31875) && piece.var_29f31875)) {
                return false;
            }
        }
        return true;
    } else {
        foreach (piece in self.a_piecespawns) {
            if (isdefined(piece.var_29f31875) && !(isdefined(piece.crafted) && piece.crafted) && piece.var_29f31875) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xc590aab8, Offset: 0x5708
// Size: 0x1d6
function function_6491663(var_395116eb, player) {
    var_5478cab = function_7fb0b698();
    foreach (var_5b55e566 in var_5478cab.a_piecespawns) {
        if (isdefined(var_395116eb)) {
            if (var_5b55e566.piecename == var_395116eb.piecename && var_5b55e566.var_dba2448c == var_395116eb.var_dba2448c) {
                var_5b55e566.crafted = 1;
                if (isdefined(var_5b55e566.var_8308120f)) {
                    var_5b55e566 thread [[ var_5b55e566.var_8308120f ]](player);
                }
                continue;
            }
        }
        if (isdefined(var_5b55e566.var_29f31875) && isdefined(var_5b55e566.var_6dd4b013) && var_5b55e566.var_6dd4b013 && var_5b55e566.var_29f31875) {
            var_5b55e566.crafted = 1;
            if (isdefined(var_5b55e566.var_8308120f)) {
                var_5b55e566 thread [[ var_5b55e566.var_8308120f ]](player);
            }
            var_5b55e566.var_29f31875 = 0;
        }
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xe90ece25, Offset: 0x58e8
// Size: 0x15a
function function_4c98edc8(var_395116eb) {
    var_5478cab = function_7fb0b698();
    foreach (var_5b55e566 in var_5478cab.a_piecespawns) {
        if (isdefined(var_395116eb)) {
            if (var_5b55e566.piecename == var_395116eb.piecename && var_5b55e566.var_dba2448c == var_395116eb.var_dba2448c) {
                var_5b55e566.crafting = 1;
            }
        }
        if (isdefined(var_5b55e566.var_29f31875) && isdefined(var_5b55e566.var_6dd4b013) && var_5b55e566.var_6dd4b013 && var_5b55e566.var_29f31875) {
            var_5b55e566.crafting = 1;
        }
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x9946d06, Offset: 0x5a50
// Size: 0x11a
function function_5148b795(var_395116eb) {
    if (isdefined(var_395116eb)) {
        var_395116eb.crafting = 0;
    }
    var_5478cab = function_7fb0b698();
    foreach (var_5b55e566 in var_5478cab.a_piecespawns) {
        if (isdefined(var_5b55e566.var_29f31875) && isdefined(var_5b55e566.var_6dd4b013) && var_5b55e566.var_6dd4b013 && var_5b55e566.var_29f31875) {
            var_5b55e566.crafting = 0;
        }
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x80e9d9f7, Offset: 0x5b78
// Size: 0xc0
function function_d67b48fb(piece) {
    for (i = 0; i < self.a_piecespawns.size; i++) {
        if (self.a_piecespawns[i].piecename == piece.piecename && self.a_piecespawns[i].var_dba2448c == piece.var_dba2448c) {
            return (isdefined(self.a_piecespawns[i].crafted) && self.a_piecespawns[i].crafted);
        }
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0xfc47811, Offset: 0x5c40
// Size: 0x1c
function function_d49e3a9b() {
    if (!isdefined(level.var_31209a1b)) {
        level.var_31209a1b = self;
    }
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0xa5b0c9a1, Offset: 0x5c68
// Size: 0x1e
function function_4709c958() {
    if (self === level.var_31209a1b) {
        level.var_31209a1b = undefined;
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x99067d5a, Offset: 0x5c90
// Size: 0x2e
function function_49618a25(var_207e8823) {
    if (var_207e8823) {
        return (self === level.var_31209a1b);
    }
    return !isdefined(level.var_31209a1b);
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xe3639bb7, Offset: 0x5cc8
// Size: 0x170
function function_c99143b0(var_395116eb) {
    var_5478cab = function_7fb0b698();
    foreach (var_5b55e566 in var_5478cab.a_piecespawns) {
        if (isdefined(var_395116eb)) {
            if (var_5b55e566.piecename == var_395116eb.piecename && var_5b55e566.var_dba2448c == var_395116eb.var_dba2448c) {
                return var_5b55e566.crafting;
            }
        }
        if (isdefined(var_5b55e566.crafting) && isdefined(var_5b55e566.var_29f31875) && isdefined(var_5b55e566.var_6dd4b013) && var_5b55e566.var_6dd4b013 && var_5b55e566.var_29f31875 && var_5b55e566.crafting) {
            return 1;
        }
    }
    return 0;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xbd7b27c9, Offset: 0x5e40
// Size: 0xf8
function function_2d9441ca(piece) {
    for (i = 0; i < self.a_piecespawns.size; i++) {
        if (self.a_piecespawns[i].piecename == piece.piecename && self.a_piecespawns[i].var_dba2448c == piece.var_dba2448c) {
            return (isdefined(self.a_piecespawns[i].crafting) && (isdefined(self.a_piecespawns[i].crafted) && self.a_piecespawns[i].crafted || self.a_piecespawns[i].crafting));
        }
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x38b3da8b, Offset: 0x5f40
// Size: 0x15c
function function_ff0cda95() {
    if (isdefined(self.stub.var_e312521d.var_7b17f7f1) && self.stub.var_e312521d.var_7b17f7f1) {
        foreach (piece in self.a_piecespawns) {
            if (!(isdefined(piece.var_29f31875) && piece.var_29f31875) && !piece.crafted) {
                return false;
            }
        }
        return true;
    }
    for (i = 0; i < self.a_piecespawns.size; i++) {
        if (!(isdefined(self.a_piecespawns[i].crafted) && self.a_piecespawns[i].crafted)) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x0
// Checksum 0x4308dec7, Offset: 0x60a8
// Size: 0x2e
function function_d4ad272b(var_9967ff1) {
    player = level waittill(var_9967ff1 + "_crafted");
    return player;
}

// Namespace namespace_f37770c8
// Params 3, eflags: 0x1 linked
// Checksum 0x2278b21c, Offset: 0x60e0
// Size: 0x290
function function_c3b9f88e(craftablespawn, var_207e8823, slot) {
    if (!isdefined(craftablespawn)) {
        return false;
    }
    if (!isdefined(slot)) {
        slot = craftablespawn.var_fbfd6aca;
    }
    if (!craftablespawn function_f254fe3d()) {
        if (!isdefined(slot)) {
            return false;
        }
        if (!isdefined(self.var_1666fe57[slot])) {
            return false;
        }
        if (!craftablespawn function_b008df77(self.var_1666fe57[slot])) {
            return false;
        }
        if (isdefined(var_207e8823) && var_207e8823) {
            if (craftablespawn function_d67b48fb(self.var_1666fe57[slot])) {
                return false;
            }
        } else if (craftablespawn function_2d9441ca(self.var_1666fe57[slot])) {
            return false;
        }
    } else {
        if (isdefined(craftablespawn.stub.crafted) && craftablespawn.stub.crafted && !var_207e8823) {
            return false;
        }
        if (craftablespawn.stub.usetime > 0 && !self function_49618a25(var_207e8823)) {
            return false;
        }
    }
    if (isdefined(craftablespawn.stub) && isdefined(craftablespawn.stub.var_855e2ef2) && isdefined(craftablespawn.stub.playertrigger[0]) && isdefined(craftablespawn.stub.playertrigger[0].stub) && !craftablespawn.stub.playertrigger[0].stub [[ craftablespawn.stub.var_855e2ef2 ]](self, 1, craftablespawn.stub.playertrigger[self getentitynumber()])) {
        return false;
    }
    return true;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x32cd6e7, Offset: 0x6378
// Size: 0x230
function function_97e1007c() {
    var_d7223f7a = self.stub;
    if (var_d7223f7a.var_d930687 == -1 || !isdefined(var_d7223f7a.var_2314709e[var_d7223f7a.var_d930687])) {
        return;
    }
    var_dc071e47 = var_d7223f7a.var_2314709e[var_d7223f7a.var_d930687];
    var_90ce2143 = var_d7223f7a;
    var_90ce2143.var_e312521d = var_dc071e47.var_e312521d;
    var_90ce2143.craftablespawn = var_dc071e47.craftablespawn;
    var_90ce2143.crafted = var_dc071e47.crafted;
    var_90ce2143.cursor_hint = var_dc071e47.cursor_hint;
    var_90ce2143.var_77220fc2 = var_dc071e47.var_77220fc2;
    var_90ce2143.equipname = var_dc071e47.equipname;
    var_90ce2143.hint_string = var_dc071e47.hint_string;
    var_90ce2143.persistent = var_dc071e47.persistent;
    var_90ce2143.prompt_and_visibility_func = var_dc071e47.prompt_and_visibility_func;
    var_90ce2143.trigger_func = var_dc071e47.trigger_func;
    var_90ce2143.var_e0a57996 = var_dc071e47.var_e0a57996;
    var_90ce2143.weaponname = var_dc071e47.weaponname;
    var_90ce2143.craftablespawn.stub = var_90ce2143;
    thread zm_unitrigger::unregister_unitrigger(var_dc071e47);
    var_dc071e47 function_bfb18668();
    return var_90ce2143;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xd3b3b040, Offset: 0x65b0
// Size: 0x586
function function_70234985(craftablespawn, slot) {
    if (!isdefined(slot)) {
        slot = craftablespawn.var_fbfd6aca;
    }
    if (!isdefined(self.var_1666fe57)) {
        self.var_1666fe57 = [];
    }
    if (isdefined(slot)) {
        craftablespawn function_6491663(self.var_1666fe57[slot], self);
    }
    if (isdefined(self.var_1666fe57[slot].crafted) && isdefined(slot) && isdefined(self.var_1666fe57[slot]) && self.var_1666fe57[slot].crafted) {
        function_bae7d22a(self.var_1666fe57[slot], slot);
    }
    if (isdefined(craftablespawn.stub.var_d930687)) {
        var_d7223f7a = craftablespawn function_97e1007c();
        craftablespawn = var_d7223f7a.craftablespawn;
        function_a264fb59();
    } else {
        var_d7223f7a = craftablespawn.stub;
    }
    if (!isdefined(var_d7223f7a.model) && isdefined(var_d7223f7a.var_e312521d.str_model)) {
        var_e312521d = var_d7223f7a.var_e312521d;
        s_model = struct::get(var_d7223f7a.target, "targetname");
        if (isdefined(s_model)) {
            m_spawn = spawn("script_model", s_model.origin);
            if (isdefined(var_e312521d.v_origin_offset)) {
                m_spawn.origin += var_e312521d.v_origin_offset;
            }
            m_spawn.angles = s_model.angles;
            if (isdefined(var_e312521d.v_angle_offset)) {
                m_spawn.angles += var_e312521d.v_angle_offset;
            }
            m_spawn setmodel(var_e312521d.str_model);
            var_d7223f7a.model = m_spawn;
        }
    }
    if (isdefined(var_d7223f7a.model)) {
        for (i = 0; i < craftablespawn.a_piecespawns.size; i++) {
            if (isdefined(craftablespawn.a_piecespawns[i].tag_name)) {
                var_d7223f7a.model notsolid();
                if (!(isdefined(craftablespawn.a_piecespawns[i].crafted) && craftablespawn.a_piecespawns[i].crafted)) {
                    var_d7223f7a.model hidepart(craftablespawn.a_piecespawns[i].tag_name);
                    continue;
                }
                var_d7223f7a.model show();
                var_d7223f7a.model showpart(craftablespawn.a_piecespawns[i].tag_name);
            }
        }
    }
    self function_48946939(craftablespawn);
    if (craftablespawn function_ff0cda95()) {
        self function_f481b8a7(craftablespawn);
        self function_f3126f50(craftablespawn);
        if (isdefined(level.var_9661e5a)) {
            self thread [[ level.var_9661e5a ]](craftablespawn);
        }
    } else {
        self playsound("zmb_buildable_piece_add");
        /#
            assert(isdefined(level.var_a7e9c2bf[craftablespawn.var_9967ff1].var_69ab0bb), "toplayer");
        #/
        if (isdefined(level.var_a7e9c2bf[craftablespawn.var_9967ff1].var_69ab0bb)) {
            return level.var_a7e9c2bf[craftablespawn.var_9967ff1].var_69ab0bb;
        }
    }
    return "";
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x8eb8702b, Offset: 0x6b40
// Size: 0x262
function function_a264fb59() {
    var_1ddec747 = 0;
    foreach (var_d7223f7a in level.var_5c007ed5) {
        if (isdefined(level.var_b09bbe80[var_d7223f7a.equipname].var_96eb2fa1) && isdefined(level.var_b09bbe80[var_d7223f7a.equipname]) && level.var_b09bbe80[var_d7223f7a.equipname].var_96eb2fa1) {
            var_cad2df96 = 0;
            foreach (var_5b55e566 in var_d7223f7a.craftablespawn.a_piecespawns) {
                if (isdefined(var_5b55e566.crafted) && var_5b55e566.crafted) {
                    var_cad2df96 = 1;
                    break;
                }
            }
            if (!var_cad2df96) {
                var_1ddec747 = 1;
            }
        }
    }
    if (!var_1ddec747) {
        foreach (var_d7223f7a in level.var_5c007ed5) {
            if (var_d7223f7a.equipname == "open_table") {
                thread zm_unitrigger::unregister_unitrigger(var_d7223f7a);
            }
        }
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x1fc6217b, Offset: 0x6db0
// Size: 0x88
function function_f481b8a7(craftablespawn) {
    craftablespawn.crafted = 1;
    craftablespawn.stub.crafted = 1;
    craftablespawn notify(#"crafted", self);
    level.var_84ae2a3c[craftablespawn.var_9967ff1] = 1;
    level notify(craftablespawn.var_9967ff1 + "_crafted", self);
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x65302734, Offset: 0x6e40
// Size: 0x138
function function_682ff7f7(var_7d7d7875) {
    foreach (var_d7223f7a in level.var_5c007ed5) {
        if (var_d7223f7a.var_e312521d.name == var_7d7d7875) {
            player = getplayers()[0];
            player function_f481b8a7(var_d7223f7a.craftablespawn);
            thread zm_unitrigger::unregister_unitrigger(var_d7223f7a);
            if (isdefined(var_d7223f7a.var_e312521d.var_2722b673)) {
                var_d7223f7a [[ var_d7223f7a.var_e312521d.var_2722b673 ]]();
            }
            return;
        }
    }
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x3dd06d3d, Offset: 0x6f80
// Size: 0x1c
function function_bfb18668() {
    arrayremovevalue(level.var_5c007ed5, self);
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x705f636e, Offset: 0x6fa8
// Size: 0x60
function function_7029d54e(player) {
    can_use = self.stub function_1df850c8(player);
    self sethintstring(self.stub.hint_string);
    return can_use;
}

// Namespace namespace_f37770c8
// Params 3, eflags: 0x1 linked
// Checksum 0x328b9cb3, Offset: 0x7010
// Size: 0x3d8
function function_1df850c8(player, unitrigger, slot) {
    if (!isdefined(slot)) {
        slot = self.var_e312521d.var_fbfd6aca;
    }
    if (!isdefined(player.var_1666fe57)) {
        player.var_1666fe57 = [];
    }
    if (!self function_13eee6c0(player)) {
        return false;
    }
    if (player bgb::is_enabled("zm_bgb_disorderly_combat")) {
        self.hint_string = "";
        return false;
    }
    if (isdefined(self.is_locked) && self.is_locked) {
        return true;
    }
    can_use = 1;
    if (isdefined(self.var_855e2ef2) && !self [[ self.var_855e2ef2 ]](player)) {
        return false;
    }
    initial_current_weapon = player getcurrentweapon();
    current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
    if (current_weapon.isheroweapon || current_weapon.isgadget) {
        self.hint_string = "";
        return false;
    }
    if (!(isdefined(self.crafted) && self.crafted)) {
        if (!self.craftablespawn function_f254fe3d()) {
            if (!isdefined(player.var_1666fe57[slot])) {
                self.hint_string = %ZOMBIE_BUILD_PIECE_MORE;
                return false;
            } else if (!self.craftablespawn function_b008df77(player.var_1666fe57[slot])) {
                self.hint_string = %ZOMBIE_BUILD_PIECE_WRONG;
                return false;
            }
        }
        /#
            assert(isdefined(level.var_a7e9c2bf[self.equipname].var_d6fd6d9d), "toplayer");
        #/
        self.hint_string = level.var_a7e9c2bf[self.equipname].var_d6fd6d9d;
    } else if (self.persistent == 1) {
        if (zm_equipment::is_limited(self.weaponname) && zm_equipment::limited_in_use(self.weaponname)) {
            self.hint_string = %ZOMBIE_BUILD_PIECE_ONLY_ONE;
            return false;
        }
        if (player zm_equipment::has_player_equipment(self.weaponname)) {
            self.hint_string = %ZOMBIE_BUILD_PIECE_HAVE_ONE;
            return false;
        }
        self.hint_string = self.var_e0a57996;
    } else if (self.persistent == 2) {
        if (!zm_weapons::limited_weapon_below_quota(self.weaponname, undefined)) {
            self.hint_string = %ZOMBIE_GO_TO_THE_BOX_LIMITED;
            return false;
        } else if (isdefined(self.var_6cabc9d6) && self.var_6cabc9d6) {
            self.hint_string = %ZOMBIE_GO_TO_THE_BOX;
            return false;
        }
        self.hint_string = self.var_e0a57996;
    } else {
        self.hint_string = "";
        return false;
    }
    return true;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x7c266bc1, Offset: 0x73f0
// Size: 0x3c8
function function_4f5d4206(player) {
    self endon(#"hash_50411e95");
    var_629d3fb5 = player getentitynumber();
    self.var_5cc99b23 = 1;
    var_aae1555b = 1;
    var_2464cb73 = newclienthudelem(player);
    var_2464cb73.alignx = "center";
    var_2464cb73.aligny = "middle";
    var_2464cb73.horzalign = "center";
    var_2464cb73.vertalign = "middle";
    var_2464cb73.y = 95;
    if (player issplitscreen()) {
        var_2464cb73.y = -50;
    }
    var_2464cb73.foreground = 1;
    var_2464cb73.font = "default";
    var_2464cb73.fontscale = 1.1;
    var_2464cb73.alpha = 1;
    var_2464cb73.color = (1, 1, 1);
    var_2464cb73 settext(%ZOMBIE_CRAFTABLE_CHANGE_BUILD);
    if (!isdefined(self.var_c0d08929)) {
        self.var_c0d08929 = [];
    }
    self.var_c0d08929[var_629d3fb5] = var_2464cb73;
    while (isdefined(self.playertrigger[var_629d3fb5]) && !self.crafted) {
        if (player actionslotonebuttonpressed()) {
            self.var_d930687++;
            var_aae1555b = 1;
        } else if (player actionslottwobuttonpressed()) {
            self.var_d930687--;
            var_aae1555b = 1;
        }
        if (self.var_d930687 >= self.var_2314709e.size) {
            self.var_d930687 = 0;
        } else if (self.var_d930687 < 0) {
            self.var_d930687 = self.var_2314709e.size - 1;
        }
        if (var_aae1555b) {
            self.equipname = self.var_2314709e[self.var_d930687].equipname;
            self.hint_string = self.var_2314709e[self.var_d930687].hint_string;
            self.playertrigger[var_629d3fb5] sethintstring(self.hint_string);
            var_aae1555b = 0;
            wait(0.5);
        }
        if (player util::is_player_looking_at(self.playertrigger[var_629d3fb5].origin, 0.76)) {
            self.var_c0d08929[var_629d3fb5].alpha = 1;
        } else {
            self.var_c0d08929[var_629d3fb5].alpha = 0;
        }
        wait(0.05);
    }
    self.var_5cc99b23 = 0;
    self.var_c0d08929[var_629d3fb5] destroy();
    self.var_c0d08929[var_629d3fb5] = undefined;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xa993313a, Offset: 0x77c0
// Size: 0x3a8
function function_b4d529ef(player, slot) {
    if (!isdefined(slot)) {
        slot = 0;
    }
    if (!(isdefined(self.crafted) && self.crafted)) {
        self.var_2314709e = [];
        foreach (var_d7223f7a in level.var_5c007ed5) {
            if (isdefined(var_d7223f7a.var_e312521d.var_96eb2fa1) && var_d7223f7a.var_e312521d.var_96eb2fa1 && !(isdefined(var_d7223f7a.crafted) && var_d7223f7a.crafted) && var_d7223f7a.craftablespawn.var_9967ff1 != "open_table" && var_d7223f7a.craftablespawn function_f254fe3d()) {
                self.var_2314709e[self.var_2314709e.size] = var_d7223f7a;
            }
        }
        if (self.var_2314709e.size < 2) {
            self notify(#"hash_50411e95");
            self.var_5cc99b23 = 0;
            var_809d8027 = player getentitynumber();
            if (isdefined(self.var_c0d08929) && isdefined(self.var_c0d08929[var_809d8027])) {
                self.var_c0d08929[var_809d8027] destroy();
                self.var_c0d08929[var_809d8027] = undefined;
            }
        }
        switch (self.var_2314709e.size) {
        case 0:
            if (!isdefined(player.var_1666fe57[slot])) {
                self.hint_string = %ZOMBIE_BUILD_PIECE_MORE;
                self.var_d930687 = -1;
                return false;
            }
            break;
        case 1:
            self.var_d930687 = 0;
            self.equipname = self.var_2314709e[self.var_d930687].equipname;
            return true;
        default:
            if (!self.var_5cc99b23) {
                thread function_4f5d4206(player);
            }
            return true;
        }
    } else if (self.persistent == 2) {
        if (!zm_weapons::limited_weapon_below_quota(self.weaponname, undefined)) {
            self.hint_string = %ZOMBIE_GO_TO_THE_BOX_LIMITED;
            return false;
        } else if (isdefined(self.bought) && self.bought) {
            self.hint_string = %ZOMBIE_GO_TO_THE_BOX;
            return false;
        } else if (isdefined(self.var_6cabc9d6) && self.var_6cabc9d6) {
            self.hint_string = %ZOMBIE_GO_TO_THE_BOX;
            return false;
        }
        self.hint_string = self.var_e0a57996;
        return true;
    } else if (self.persistent == 1) {
        return true;
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xcd0ebce4, Offset: 0x7b70
// Size: 0x290
function function_2948b557(craftablespawn, slot) {
    if (self laststand::player_is_in_laststand() || self zm_utility::in_revive_trigger()) {
        return false;
    }
    if (!self function_c3b9f88e(craftablespawn, 1)) {
        return false;
    }
    if (isdefined(self.var_56d04199)) {
        return false;
    }
    if (!self usebuttonpressed()) {
        return false;
    }
    if (craftablespawn.stub.usetime > 0 && isdefined(slot) && !craftablespawn function_c99143b0(self.var_1666fe57[slot])) {
        return false;
    }
    trigger = craftablespawn.stub zm_unitrigger::unitrigger_trigger(self);
    if (craftablespawn.stub.script_unitrigger_type == "unitrigger_radius_use") {
        torigin = craftablespawn.stub zm_unitrigger::unitrigger_origin();
        porigin = self geteye();
        radius_sq = 2.25 * craftablespawn.stub.radius * craftablespawn.stub.radius;
        if (distance2dsquared(torigin, porigin) > radius_sq) {
            return false;
        }
    } else if (!isdefined(trigger) || !trigger istouching(self)) {
        return false;
    }
    if (isdefined(craftablespawn.stub.require_look_at) && craftablespawn.stub.require_look_at && !self util::is_player_looking_at(trigger.origin, 0.76)) {
        return false;
    }
    return true;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xbc6d386a, Offset: 0x7e08
// Size: 0xd0
function player_progress_bar_update(start_time, var_8aa1e537) {
    self endon(#"entering_last_stand");
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_9bf851d3");
    while (isdefined(self) && gettime() - start_time < var_8aa1e537) {
        progress = (gettime() - start_time) / var_8aa1e537;
        if (progress < 0) {
            progress = 0;
        }
        if (progress > 1) {
            progress = 1;
        }
        self.usebar hud::updatebar(progress);
        wait(0.05);
    }
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0x22ab11f8, Offset: 0x7ee0
// Size: 0xdc
function player_progress_bar(start_time, var_8aa1e537) {
    self.usebar = self hud::createprimaryprogressbar();
    self.var_6adb8298 = self hud::createprimaryprogressbartext();
    self.var_6adb8298 settext(%ZOMBIE_BUILDING);
    if (isdefined(self) && isdefined(start_time) && isdefined(var_8aa1e537)) {
        self player_progress_bar_update(start_time, var_8aa1e537);
    }
    self.var_6adb8298 hud::destroyelem();
    self.usebar hud::destroyelem();
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xa74417ee, Offset: 0x7fc8
// Size: 0x4d2
function function_fca28e(player, slot) {
    if (!isdefined(slot)) {
        slot = self.stub.craftablespawn.var_fbfd6aca;
    }
    wait(0.01);
    if (!isdefined(self)) {
        if (isdefined(player.var_292b6949)) {
            player.var_292b6949 delete();
            player.var_292b6949 = undefined;
        }
        return;
    }
    if (self.stub.craftablespawn function_f254fe3d()) {
        slot = undefined;
    }
    if (!isdefined(self.usetime)) {
        self.usetime = int(3000);
    }
    self.var_8aa1e537 = self.usetime;
    self.var_30c49cc4 = gettime();
    var_8aa1e537 = self.var_8aa1e537;
    var_30c49cc4 = self.var_30c49cc4;
    if (var_8aa1e537 > 0) {
        player zm_utility::disable_player_move_states(1);
        player zm_utility::increment_is_drinking();
        orgweapon = player getcurrentweapon();
        build_weapon = getweapon("zombie_builder");
        player giveweapon(build_weapon);
        player switchtoweapon(build_weapon);
        if (isdefined(slot)) {
            self.stub.craftablespawn function_4c98edc8(player.var_1666fe57[slot]);
        } else {
            player function_d49e3a9b();
        }
        player thread player_progress_bar(var_30c49cc4, var_8aa1e537);
        if (isdefined(level.var_32465ec9)) {
            player thread [[ level.var_32465ec9 ]](self.stub);
        }
        while (isdefined(self) && player function_2948b557(self.stub.craftablespawn, slot) && gettime() - self.var_30c49cc4 < self.var_8aa1e537) {
            wait(0.05);
        }
        player notify(#"hash_9bf851d3");
        player zm_weapons::switch_back_primary_weapon(orgweapon);
        player takeweapon(build_weapon);
        if (isdefined(player.is_drinking) && player.is_drinking) {
            player zm_utility::decrement_is_drinking();
        }
        player zm_utility::enable_player_move_states();
    }
    if (self.var_8aa1e537 <= 0 || isdefined(self) && player function_2948b557(self.stub.craftablespawn, slot) && gettime() - self.var_30c49cc4 >= self.var_8aa1e537) {
        if (isdefined(slot)) {
            self.stub.craftablespawn function_5148b795(player.var_1666fe57[slot]);
        } else {
            player function_4709c958();
        }
        self notify(#"hash_a623e0c0");
        return;
    }
    if (isdefined(player.var_292b6949)) {
        player.var_292b6949 delete();
        player.var_292b6949 = undefined;
    }
    if (isdefined(slot)) {
        self.stub.craftablespawn function_5148b795(player.var_1666fe57[slot]);
    } else {
        player function_4709c958();
    }
    self notify(#"hash_d7d82fd3");
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xa3e970fb, Offset: 0x84a8
// Size: 0x88
function function_89389f6(player) {
    self endon(#"kill_trigger");
    self endon(#"hash_a623e0c0");
    self endon(#"hash_d7d82fd3");
    while (true) {
        playfx(level._effect["building_dust"], player getplayercamerapos(), player.angles);
        wait(0.5);
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xf875bdfb, Offset: 0x8538
// Size: 0x88
function function_3fc45d82(player) {
    self thread function_89389f6(player);
    self thread function_fca28e(player);
    retval = self util::waittill_any_return("craft_succeed", "craft_failed");
    if (retval == "craft_succeed") {
        return true;
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x974e3ae3, Offset: 0x85c8
// Size: 0xea8
function function_cfd8f554() {
    self notify(#"hash_cfd8f554");
    self endon(#"hash_cfd8f554");
    self endon(#"kill_trigger");
    player_crafted = undefined;
    while (!(isdefined(self.stub.crafted) && self.stub.crafted)) {
        player = self waittill(#"trigger");
        if (isdefined(level.var_93b7659f)) {
            valid = self [[ level.var_93b7659f ]](player);
            if (!valid) {
                continue;
            }
        }
        if (player != self.parent_player) {
            continue;
        }
        if (isdefined(player.var_ea2cf068)) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            player thread zm_utility::ignore_triggers(0.5);
            continue;
        }
        status = player function_c3b9f88e(self.stub.craftablespawn, 0);
        if (!status) {
            self.stub.hint_string = "";
            self sethintstring(self.stub.hint_string);
            if (isdefined(self.stub.oncantuse)) {
                self.stub [[ self.stub.oncantuse ]](player);
            }
            continue;
        }
        if (isdefined(self.stub.onbeginuse)) {
            self.stub [[ self.stub.onbeginuse ]](player);
        }
        result = self function_3fc45d82(player);
        team = player.pers["team"];
        if (isdefined(self.stub.onenduse)) {
            self.stub [[ self.stub.onenduse ]](team, player, result);
        }
        if (!result) {
            continue;
        }
        if (isdefined(self.stub.onuse)) {
            self.stub [[ self.stub.onuse ]](player);
        }
        prompt = player function_70234985(self.stub.craftablespawn);
        player_crafted = player;
        self.stub.hint_string = prompt;
        self sethintstring(self.stub.hint_string);
    }
    if (isdefined(self.stub.var_e312521d.var_2722b673)) {
        b_result = self.stub [[ self.stub.var_e312521d.var_2722b673 ]]();
        if (!b_result) {
            return;
        }
    }
    if (isdefined(player_crafted)) {
        player_crafted playsound("zmb_craftable_complete");
    }
    if (self.stub.persistent == 0) {
        self.stub function_bfb18668();
        thread zm_unitrigger::unregister_unitrigger(self.stub);
        return;
    }
    if (self.stub.persistent == 3) {
        function_20cab1d2(self.stub, 1);
        return;
    }
    if (self.stub.persistent == 2) {
        if (isdefined(player_crafted)) {
            self function_7029d54e(player_crafted);
        }
        if (!zm_weapons::limited_weapon_below_quota(self.stub.weaponname, undefined)) {
            self.stub.hint_string = %ZOMBIE_GO_TO_THE_BOX_LIMITED;
            self sethintstring(self.stub.hint_string);
            return;
        }
        if (isdefined(self.stub.var_6cabc9d6) && self.stub.var_6cabc9d6) {
            self.stub.hint_string = %ZOMBIE_GO_TO_THE_BOX;
            self sethintstring(self.stub.hint_string);
            return;
        }
        if (isdefined(self.stub.model)) {
            self.stub.model notsolid();
            self.stub.model show();
        }
        while (self.stub.persistent == 2) {
            player = self waittill(#"trigger");
            if (isdefined(self.stub.bought) && self.stub.bought == 1) {
                continue;
            }
            if (isdefined(player.var_ea2cf068)) {
                continue;
            }
            current_weapon = player getcurrentweapon();
            if (zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon)) {
                continue;
            }
            if (current_weapon.isheroweapon || current_weapon.isgadget) {
                continue;
            }
            if (player bgb::is_enabled("zm_bgb_disorderly_combat")) {
                continue;
            }
            if (isdefined(level.var_93b7659f)) {
                valid = self [[ level.var_93b7659f ]](player);
                if (!valid) {
                    continue;
                }
            }
            if (!(isdefined(self.stub.crafted) && self.stub.crafted)) {
                self.stub.hint_string = "";
                self sethintstring(self.stub.hint_string);
                return;
            }
            if (player != self.parent_player) {
                continue;
            }
            if (!zm_utility::is_player_valid(player)) {
                player thread zm_utility::ignore_triggers(0.5);
                continue;
            }
            self.stub.bought = 1;
            if (isdefined(self.stub.model)) {
                self.stub.model thread function_fe478e57(self);
            }
            if (zm_weapons::limited_weapon_below_quota(self.stub.weaponname, undefined)) {
                player zm_weapons::weapon_give(self.stub.weaponname);
                if (isdefined(level.var_b09bbe80[self.stub.equipname].var_71a0cc1e)) {
                    self [[ level.var_b09bbe80[self.stub.equipname].var_71a0cc1e ]](player);
                }
            }
            if (!zm_weapons::limited_weapon_below_quota(self.stub.weaponname, undefined)) {
                self.stub.hint_string = %ZOMBIE_GO_TO_THE_BOX_LIMITED;
            } else {
                self.stub.hint_string = %ZOMBIE_GO_TO_THE_BOX;
            }
            self sethintstring(self.stub.hint_string);
            player track_craftables_pickedup(self.stub.craftablespawn);
        }
        return;
    }
    if (!isdefined(player_crafted) || self function_7029d54e(player_crafted)) {
        visible = 1;
        hide = function_b98972f1(self.stub.equipname);
        if (hide && isdefined(level.var_93b7659f)) {
            visible = self [[ level.var_93b7659f ]](player);
        }
        if (visible && isdefined(self.stub.model)) {
            self.stub.model notsolid();
            self.stub.model show();
        }
        while (self.stub.persistent == 1) {
            player = self waittill(#"trigger");
            if (isdefined(player.var_ea2cf068)) {
                continue;
            }
            if (isdefined(level.var_93b7659f)) {
                valid = self [[ level.var_93b7659f ]](player);
                if (!valid) {
                    continue;
                }
            }
            if (!(isdefined(self.stub.crafted) && self.stub.crafted)) {
                self.stub.hint_string = "";
                self sethintstring(self.stub.hint_string);
                return;
            }
            if (player != self.parent_player) {
                continue;
            }
            if (!zm_utility::is_player_valid(player)) {
                player thread zm_utility::ignore_triggers(0.5);
                continue;
            }
            if (player zm_equipment::has_player_equipment(self.stub.weaponname)) {
                continue;
            }
            if (player bgb::is_enabled("zm_bgb_disorderly_combat")) {
                continue;
            }
            if (isdefined(level.var_443764ab)) {
                if (self [[ level.var_443764ab ]](player)) {
                    continue;
                }
            }
            if (isdefined(level.var_14adb6f4)) {
                if (self [[ level.var_14adb6f4 ]](player)) {
                    continue;
                }
            }
            if (!zm_equipment::is_limited(self.stub.weaponname) || !zm_equipment::limited_in_use(self.stub.weaponname)) {
                player zm_equipment::buy(self.stub.weaponname);
                player giveweapon(self.stub.weaponname);
                player zm_equipment::start_ammo(self.stub.weaponname);
                player notify(self.stub.weaponname.name + "_pickup_from_table");
                if (isdefined(level.var_b09bbe80[self.stub.equipname].var_71a0cc1e)) {
                    self [[ level.var_b09bbe80[self.stub.equipname].var_71a0cc1e ]](player);
                } else if (self.stub.weaponname != "keys_zm") {
                    player setactionslot(1, "weapon", self.stub.weaponname);
                }
                if (isdefined(level.var_a7e9c2bf[self.stub.equipname].var_6cabc9d6)) {
                    self.stub.hint_string = level.var_a7e9c2bf[self.stub.equipname].var_6cabc9d6;
                } else {
                    self.stub.hint_string = "";
                }
                self sethintstring(self.stub.hint_string);
                player track_craftables_pickedup(self.stub.craftablespawn);
                continue;
            }
            self.stub.hint_string = "";
            self sethintstring(self.stub.hint_string);
        }
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x516f77c0, Offset: 0x9478
// Size: 0x174
function function_fe478e57(unitrigger) {
    self moveto(self.origin + (0, 0, 40), 3);
    direction = self.origin;
    direction = (direction[1], direction[0], 0);
    if (direction[0] > 0 && (direction[1] < 0 || direction[1] > 0)) {
        direction = (direction[0], direction[1] * -1, 0);
    } else if (direction[0] < 0) {
        direction = (direction[0] * -1, direction[1], 0);
    }
    self vibrate(direction, 10, 0.5, 4);
    self waittill(#"movedone");
    self ghost();
    playfx(level._effect["poltergeist"], self.origin);
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xf3555ef9, Offset: 0x95f8
// Size: 0x9a
function function_cc197006(equipname) {
    foreach (stub in level.var_5c007ed5) {
        if (stub.equipname == equipname) {
            return stub;
        }
    }
    return undefined;
}

// Namespace namespace_f37770c8
// Params 4, eflags: 0x0
// Checksum 0x3e88a6c0, Offset: 0x96a0
// Size: 0x6c
function function_4061802d(equipname, var_e12f36f3, origin, angles) {
    stub = function_cc197006(equipname);
    function_20cab1d2(stub, var_e12f36f3, origin, angles);
}

// Namespace namespace_f37770c8
// Params 5, eflags: 0x1 linked
// Checksum 0xebc374e4, Offset: 0x9718
// Size: 0x2d4
function function_20cab1d2(stub, var_e12f36f3, origin, angles, var_2b258b1) {
    if (isdefined(stub)) {
        craftable = stub.craftablespawn;
        craftable.crafted = 0;
        craftable.stub.crafted = 0;
        craftable notify(#"hash_75007889");
        level.var_84ae2a3c[craftable.var_9967ff1] = 0;
        level notify(craftable.var_9967ff1 + "_uncrafted");
        for (i = 0; i < craftable.a_piecespawns.size; i++) {
            craftable.a_piecespawns[i].crafted = 0;
            if (isdefined(craftable.a_piecespawns[i].tag_name)) {
                craftable.stub.model notsolid();
                if (!(isdefined(craftable.a_piecespawns[i].crafted) && craftable.a_piecespawns[i].crafted)) {
                    craftable.stub.model hidepart(craftable.a_piecespawns[i].tag_name);
                } else {
                    craftable.stub.model show();
                    craftable.stub.model showpart(craftable.a_piecespawns[i].tag_name);
                }
            }
            if (isdefined(var_e12f36f3) && var_e12f36f3) {
                craftable.a_piecespawns[i] function_695b1f07(origin, angles, var_2b258b1);
            }
        }
        if (isdefined(craftable.stub.model)) {
            craftable.stub.model ghost();
        }
    }
}

// Namespace namespace_f37770c8
// Params 5, eflags: 0x0
// Checksum 0x847c7f83, Offset: 0x99f8
// Size: 0x384
function function_232b4df(equipname, origin, speed, var_c15f8229, var_a0210dd) {
    self explosiondamage(50, origin);
    stub = function_cc197006(equipname);
    if (isdefined(stub)) {
        craftable = stub.craftablespawn;
        craftable.crafted = 0;
        craftable.stub.crafted = 0;
        craftable notify(#"hash_75007889");
        level.var_84ae2a3c[craftable.var_9967ff1] = 0;
        level notify(craftable.var_9967ff1 + "_uncrafted");
        for (i = 0; i < craftable.a_piecespawns.size; i++) {
            craftable.a_piecespawns[i].crafted = 0;
            if (isdefined(craftable.a_piecespawns[i].tag_name)) {
                craftable.stub.model notsolid();
                if (!(isdefined(craftable.a_piecespawns[i].crafted) && craftable.a_piecespawns[i].crafted)) {
                    craftable.stub.model hidepart(craftable.a_piecespawns[i].tag_name);
                } else {
                    craftable.stub.model show();
                    craftable.stub.model showpart(craftable.a_piecespawns[i].tag_name);
                }
            }
            ang = randomfloat(360);
            h = 0.25 + randomfloat(0.5);
            dir = (sin(ang), cos(ang), h);
            self thread function_1212a0d0(craftable.a_piecespawns[i], origin, speed * dir, var_c15f8229, var_a0210dd);
        }
        craftable.stub.model ghost();
    }
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x3617a9fe, Offset: 0x9d88
// Size: 0x9e
function function_e6d6a7f() {
    foreach (craftable in level.var_b09bbe80) {
        if (isdefined(craftable.var_41f0f8cd)) {
            craftable [[ craftable.var_41f0f8cd ]]();
        }
    }
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0xc6b1dc27, Offset: 0x9e30
// Size: 0x102
function function_e8f4e83() {
    a_trigs = getentarray("open_craftable_trigger", "targetname");
    foreach (trig in a_trigs) {
        unitrigger_stub = function_4832d516(trig, "open_table", "", "OPEN_CRAFTABLE", 1, 0);
        unitrigger_stub.require_look_at = 0;
        unitrigger_stub.require_look_toward = 1;
    }
}

// Namespace namespace_f37770c8
// Params 6, eflags: 0x1 linked
// Checksum 0xc17a637c, Offset: 0x9f40
// Size: 0x5a
function function_4f91b11d(var_7df306d0, equipname, weaponname, var_e0a57996, delete_trigger, persistent) {
    return function_56f80f8a(var_7df306d0, equipname, weaponname, var_e0a57996, delete_trigger, persistent);
}

// Namespace namespace_f37770c8
// Params 6, eflags: 0x0
// Checksum 0xe47d182f, Offset: 0x9fa8
// Size: 0x5a
function function_b4ba4fd7(var_7df306d0, equipname, weaponname, var_e0a57996, delete_trigger, persistent) {
    return function_779d19e8(var_7df306d0, equipname, weaponname, var_e0a57996, delete_trigger, persistent);
}

// Namespace namespace_f37770c8
// Params 7, eflags: 0x1 linked
// Checksum 0x3333c6bb, Offset: 0xa010
// Size: 0x5ae
function function_aa10bbd9(parent, var_7df306d0, equipname, weaponname, var_e0a57996, delete_trigger, persistent) {
    trig = getent(var_7df306d0, "targetname");
    if (!isdefined(trig)) {
        return;
    }
    unitrigger_stub = spawnstruct();
    unitrigger_stub.var_e312521d = level.var_b09bbe80[equipname];
    unitrigger_stub.var_b559aeb4 = parent;
    unitrigger_stub.var_9351fe46 = trig;
    unitrigger_stub.var_7df306d0 = var_7df306d0;
    unitrigger_stub.originfunc = &function_292d2b12;
    unitrigger_stub.onspawnfunc = &function_f6b6c76e;
    unitrigger_stub.origin = trig.origin;
    unitrigger_stub.angles = trig.angles;
    unitrigger_stub.equipname = equipname;
    unitrigger_stub.weaponname = weaponname;
    unitrigger_stub.var_e0a57996 = var_e0a57996;
    unitrigger_stub.delete_trigger = delete_trigger;
    unitrigger_stub.crafted = 0;
    unitrigger_stub.persistent = persistent;
    unitrigger_stub.usetime = int(3000);
    unitrigger_stub.onbeginuse = &function_de0824;
    unitrigger_stub.onenduse = &function_bc83d6c;
    unitrigger_stub.onuse = &function_b7c96663;
    unitrigger_stub.oncantuse = &function_b7a4981d;
    tmins = trig getmins();
    tmaxs = trig getmaxs();
    tsize = tmaxs - tmins;
    if (isdefined(trig.script_length)) {
        unitrigger_stub.script_length = trig.script_length;
    } else {
        unitrigger_stub.script_length = tsize[1];
    }
    if (isdefined(trig.script_width)) {
        unitrigger_stub.script_width = trig.script_width;
    } else {
        unitrigger_stub.script_width = tsize[0];
    }
    if (isdefined(trig.script_height)) {
        unitrigger_stub.script_height = trig.script_height;
    } else {
        unitrigger_stub.script_height = tsize[2];
    }
    if (isdefined(trig.radius)) {
        unitrigger_stub.radius = trig.radius;
    } else {
        unitrigger_stub.radius = 64;
    }
    unitrigger_stub.target = trig.target;
    unitrigger_stub.targetname = trig.targetname + "_trigger";
    unitrigger_stub.script_noteworthy = trig.script_noteworthy;
    unitrigger_stub.script_parameters = trig.script_parameters;
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    if (isdefined(level.var_a7e9c2bf[equipname].var_d6fd6d9d)) {
        unitrigger_stub.hint_string = level.var_a7e9c2bf[equipname].var_d6fd6d9d;
    }
    unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    unitrigger_stub.require_look_at = 1;
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    unitrigger_stub.prompt_and_visibility_func = &function_7029d54e;
    zm_unitrigger::register_unitrigger(unitrigger_stub, &function_cfd8f554);
    unitrigger_stub.piece_trigger = trig;
    trig.trigger_stub = unitrigger_stub;
    unitrigger_stub.craftablespawn = unitrigger_stub function_59bc965e(equipname, unitrigger_stub.origin);
    if (delete_trigger) {
        trig delete();
    }
    level.var_5c007ed5[level.var_5c007ed5.size] = unitrigger_stub;
    return unitrigger_stub;
}

// Namespace namespace_f37770c8
// Params 7, eflags: 0x0
// Checksum 0x66270af2, Offset: 0xa5c8
// Size: 0x6a
function function_a36ec5bc(vehicle, var_7df306d0, equipname, weaponname, var_e0a57996, delete_trigger, persistent) {
    return function_aa10bbd9(vehicle, var_7df306d0, equipname, weaponname, var_e0a57996, delete_trigger, persistent);
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x735d70ab, Offset: 0xa640
// Size: 0x54
function function_7711c41c(player) {
    /#
        if (isdefined(player) && isdefined(player.name)) {
            println("toplayer" + player.name);
        }
    #/
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x585285ad, Offset: 0xa6a0
// Size: 0x64
function function_43646525(player) {
    /#
        if (isdefined(player) && isdefined(player.name)) {
            println("toplayer" + player.name);
        }
    #/
    player notify(#"event_ended");
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x852101e4, Offset: 0xa710
// Size: 0xfc
function function_de0824(player) {
    /#
        if (isdefined(player) && isdefined(player.name)) {
            println("toplayer" + player.name);
        }
    #/
    if (isdefined(self.var_e312521d.onbeginuse)) {
        self [[ self.var_e312521d.onbeginuse ]](player);
    }
    if (isdefined(player) && !isdefined(player.var_292b6949)) {
        player.var_292b6949 = spawn("script_origin", player.origin);
        player.var_292b6949 playloopsound("zmb_craftable_loop");
    }
}

// Namespace namespace_f37770c8
// Params 3, eflags: 0x1 linked
// Checksum 0xae84fc62, Offset: 0xa818
// Size: 0xfc
function function_bc83d6c(team, player, result) {
    /#
        if (isdefined(player) && isdefined(player.name)) {
            println("toplayer" + player.name);
        }
    #/
    if (!isdefined(player)) {
        return;
    }
    if (isdefined(player.var_292b6949)) {
        player.var_292b6949 delete();
        player.var_292b6949 = undefined;
    }
    if (isdefined(self.var_e312521d.onenduse)) {
        self [[ self.var_e312521d.onenduse ]](team, player, result);
    }
    player notify(#"event_ended");
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x742ee2e0, Offset: 0xa920
// Size: 0x84
function function_b7a4981d(player) {
    /#
        if (isdefined(player) && isdefined(player.name)) {
            println("toplayer" + player.name);
        }
    #/
    if (isdefined(self.var_e312521d.oncantuse)) {
        self [[ self.var_e312521d.oncantuse ]](player);
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xb2befb09, Offset: 0xa9b0
// Size: 0x94
function function_b7c96663(player) {
    /#
        if (isdefined(player) && isdefined(player.name)) {
            println("toplayer" + player.name);
        }
    #/
    if (isdefined(self.var_e312521d.onuseplantobject)) {
        self [[ self.var_e312521d.onuseplantobject ]](player);
    }
    player notify(#"bomb_planted");
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0xa01af2ff, Offset: 0xaa50
// Size: 0x94
function function_30b74486() {
    if (!isdefined(level.var_a7e9c2bf)) {
        return false;
    }
    if (isdefined(self.zombie_weapon_upgrade) && isdefined(level.var_a7e9c2bf[self.zombie_weapon_upgrade])) {
        return true;
    }
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "specialty_weapupgrade") {
        if (isdefined(level.var_84ae2a3c["pap"]) && level.var_84ae2a3c["pap"]) {
            return false;
        }
        return true;
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x0
// Checksum 0x943dd9f2, Offset: 0xaaf0
// Size: 0xc
function function_d3534b91() {
    self.a_piecespawns--;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x0
// Checksum 0x8f0fb65e, Offset: 0xab08
// Size: 0x1a
function function_93415e3d() {
    if (self.a_piecespawns <= 0) {
        return true;
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x0
// Checksum 0x3028736c, Offset: 0xab30
// Size: 0x52
function function_bff7d1dc(var_9967ff1) {
    /#
        assert(isdefined(level.var_a7e9c2bf[var_9967ff1]), var_9967ff1 + "toplayer");
    #/
    return level.var_a7e9c2bf[var_9967ff1].var_d6fd6d9d;
}

// Namespace namespace_f37770c8
// Params 3, eflags: 0x0
// Checksum 0x3c39de07, Offset: 0xab90
// Size: 0xbc
function function_bdca8905(craftable, var_11b25be5, var_24ae8fd2) {
    craftable endon(#"death");
    self waittill(#"disconnect");
    if (isdefined(var_11b25be5)) {
        self notify(var_11b25be5);
    }
    if (!(isdefined(var_24ae8fd2) && var_24ae8fd2)) {
        if (isdefined(craftable.stub)) {
            thread zm_unitrigger::unregister_unitrigger(craftable.stub);
            craftable.stub = undefined;
        }
        if (isdefined(craftable)) {
            craftable delete();
        }
    }
}

// Namespace namespace_f37770c8
// Params 3, eflags: 0x0
// Checksum 0x81dababe, Offset: 0xac58
// Size: 0x1f6
function function_d8f2a087(var_9967ff1, var_90757d31, slot) {
    if (!isdefined(slot)) {
        slot = 0;
    }
    if (isdefined(self.var_1666fe57) && isdefined(self.var_1666fe57[slot])) {
        if (self.var_1666fe57[slot].var_dba2448c == var_9967ff1 && self.var_1666fe57[slot].modelname == var_90757d31) {
            return true;
        }
    }
    if (isdefined(level.var_5c007ed5)) {
        foreach (var_c5ee3bcc in level.var_5c007ed5) {
            if (var_c5ee3bcc.var_e312521d.name == var_9967ff1) {
                foreach (piece in var_c5ee3bcc.craftablespawn.a_piecespawns) {
                    if (piece.piecename == var_90757d31) {
                        if (isdefined(piece.var_29f31875) && piece.var_29f31875) {
                            return true;
                        }
                    }
                }
            }
        }
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xd928cde1, Offset: 0xae58
// Size: 0x19e
function function_ad26d97f(var_9967ff1, var_90757d31) {
    if (isdefined(level.var_5c007ed5)) {
        foreach (var_c5ee3bcc in level.var_5c007ed5) {
            if (var_c5ee3bcc.var_e312521d.name == var_9967ff1) {
                if (isdefined(var_c5ee3bcc.crafted) && var_c5ee3bcc.crafted) {
                    return true;
                }
                foreach (piece in var_c5ee3bcc.craftablespawn.a_piecespawns) {
                    if (piece.piecename == var_90757d31) {
                        if (isdefined(piece.crafted) && piece.crafted) {
                            return true;
                        }
                    }
                }
            }
        }
    }
    return false;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x99087d1e, Offset: 0xb000
// Size: 0x22c
function function_12da47ae(piece) {
    if (!isdefined(piece) || !isdefined(piece.var_dba2448c)) {
        /#
            println("toplayer");
        #/
        return;
    }
    self function_78f5a223(piece.var_dba2448c, "pieces_pickedup", 1);
    if (isdefined(piece.var_da5b715d) && isdefined(piece.var_da5b715d.hash_id)) {
        self recordmapevent(13, gettime(), self.origin, level.round_number, piece.var_da5b715d.hash_id);
    }
    if (isdefined(piece.var_da5b715d.var_5dbbf224)) {
        if (isdefined(piece.var_da5b715d.var_f36883de) && piece.var_da5b715d.var_f36883de) {
            if (!isdefined(self.var_2901a25)) {
                self.var_2901a25 = [];
            }
            if (isdefined(self.dontspeak) && self.dontspeak) {
                return;
            }
            if (isinarray(self.var_2901a25, piece.var_da5b715d.var_5dbbf224)) {
                return;
            }
            self.var_2901a25[self.var_2901a25.size] = piece.var_da5b715d.var_5dbbf224;
        }
        self thread zm_utility::do_player_general_vox("general", piece.var_da5b715d.var_5dbbf224 + "_pickup");
        return;
    }
    self thread zm_utility::do_player_general_vox("general", "build_pickup");
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x42fb257d, Offset: 0xb238
// Size: 0x108
function function_48946939(craftable) {
    if (!isdefined(craftable) || !isdefined(craftable.var_9967ff1)) {
        /#
            println("toplayer");
        #/
        return;
    }
    var_e9248d1c = craftable.var_9967ff1;
    if (isdefined(craftable.stat_name)) {
        var_e9248d1c = craftable.stat_name;
    }
    self function_78f5a223(var_e9248d1c, "pieces_built", 1);
    if (!craftable function_ff0cda95()) {
        self thread zm_utility::do_player_general_vox("general", "build_add");
    }
    level notify(var_e9248d1c + "_crafted", self);
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xddd1c39c, Offset: 0xb348
// Size: 0x284
function function_f3126f50(craftable) {
    if (!isdefined(craftable) || !isdefined(craftable.var_9967ff1)) {
        /#
            println("toplayer");
        #/
        return;
    }
    var_e9248d1c = craftable.var_9967ff1;
    if (isdefined(craftable.stat_name)) {
        var_e9248d1c = craftable.stat_name;
    }
    self function_78f5a223(var_e9248d1c, "buildable_built", 1);
    self zm_stats::increment_client_stat("buildables_built", 0);
    self zm_stats::increment_player_stat("buildables_built");
    if (isdefined(craftable.stub) && isdefined(craftable.stub.var_e312521d) && isdefined(craftable.stub.var_e312521d.hash_id)) {
        self recordmapevent(14, gettime(), self.origin, level.round_number, craftable.stub.var_e312521d.hash_id);
    }
    if (!isdefined(craftable.stub.var_e312521d.var_78f38827) || craftable.stub.var_e312521d.var_78f38827 == 0) {
        self zm_stats::increment_challenge_stat("SURVIVALIST_CRAFTABLE");
    }
    if (isdefined(craftable.stub.var_e312521d.var_5dbbf224)) {
        if (isdefined(level.var_80c12a61)) {
            self thread [[ level.var_80c12a61 ]](craftable.stub);
        }
        self thread zm_utility::do_player_general_vox("general", craftable.stub.var_e312521d.var_5dbbf224 + "_final");
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x7721c666, Offset: 0xb5d8
// Size: 0x1e4
function track_craftables_pickedup(craftable) {
    if (!isdefined(craftable)) {
        /#
            println("toplayer");
        #/
        return;
    }
    stat_name = function_2e12ff6d(craftable.var_9967ff1);
    if (isdefined(craftable.stub) && isdefined(craftable.stub.var_e312521d) && isdefined(craftable.stub.var_e312521d.hash_id)) {
        self recordmapevent(16, gettime(), self.origin, level.round_number, craftable.stub.var_e312521d.hash_id);
    }
    if (!isdefined(stat_name)) {
        /#
            println("toplayer" + craftable.var_9967ff1 + "toplayer");
        #/
        return;
    }
    self function_78f5a223(stat_name, "buildable_pickedup", 1);
    if (isdefined(craftable.stub.var_e312521d.var_5dbbf224)) {
        self thread zm_utility::do_player_general_vox("general", craftable.stub.var_e312521d.var_5dbbf224 + "_plc");
    }
    self function_c47389a0(craftable, 0);
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x0
// Checksum 0xf9d9eab7, Offset: 0xb7c8
// Size: 0x194
function function_789de941(equipment) {
    if (!isdefined(equipment)) {
        /#
            println("toplayer");
        #/
        return;
    }
    var_9967ff1 = undefined;
    if (isdefined(equipment.name)) {
        var_9967ff1 = function_2e12ff6d(equipment.name);
    }
    if (!isdefined(var_9967ff1)) {
        /#
            println("toplayer" + equipment.name + "toplayer");
        #/
        return;
    }
    demo::bookmark("zm_player_buildable_placed", gettime(), self);
    self function_78f5a223(var_9967ff1, "buildable_placed", 1);
    if (isdefined(equipment.stub) && isdefined(equipment.stub.var_e312521d) && isdefined(equipment.stub.var_e312521d.hash_id)) {
        self recordmapevent(15, gettime(), self.origin, level.round_number, equipment.stub.var_e312521d.hash_id);
    }
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x0
// Checksum 0x1db32cb9, Offset: 0xb968
// Size: 0x2c
function function_1d556407() {
    self endon(#"disconnect");
    self.var_49e99f2b = 1;
    wait(60);
    self.var_49e99f2b = 0;
}

// Namespace namespace_f37770c8
// Params 0, eflags: 0x1 linked
// Checksum 0x56ad8c25, Offset: 0xb9a0
// Size: 0x2c
function function_4ba9331d() {
    self endon(#"disconnect");
    self.var_4ba9331d = 1;
    wait(60);
    self.var_4ba9331d = 0;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x0
// Checksum 0x92c2b420, Offset: 0xb9d8
// Size: 0xfc
function function_703326b9(equipment) {
    if (!isdefined(equipment)) {
        return;
    }
    if (equipment == "equip_turbine_zm" || equipment == "equip_turret_zm" || equipment == "equip_electrictrap_zm" || equipment == "riotshield_zm" || equipment == "alcatraz_shield_zm" || equipment == "tomb_shield_zm") {
        self zm_stats::increment_client_stat("planted_buildables_pickedup", 0);
        self zm_stats::increment_player_stat("planted_buildables_pickedup");
    }
    if (!(isdefined(self.var_4ba9331d) && self.var_4ba9331d)) {
        self function_c47389a0(equipment, 1);
        self thread function_4ba9331d();
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x0
// Checksum 0x615ee513, Offset: 0xbae0
// Size: 0x94
function function_98805434(var_9967ff1) {
    if (!isdefined(var_9967ff1)) {
        return;
    }
    self function_78f5a223(var_9967ff1, "buildable_placed", 1);
    var_de3af0d6 = undefined;
    if (var_9967ff1 == level.var_6db10ae) {
        var_de3af0d6 = "craft_plc_shield";
    }
    if (!isdefined(var_de3af0d6)) {
        return;
    }
    self thread zm_utility::do_player_general_vox("general", var_de3af0d6);
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x0
// Checksum 0x21fd27da, Offset: 0xbb80
// Size: 0x3e
function function_177f7e7b(var_deec1671, var_d8548537) {
    if (!isdefined(level.var_1779387)) {
        level.var_1779387 = [];
    }
    level.var_1779387[var_deec1671] = var_d8548537;
}

// Namespace namespace_f37770c8
// Params 3, eflags: 0x1 linked
// Checksum 0xd6127199, Offset: 0xbbc8
// Size: 0xe4
function function_78f5a223(var_90757d31, stat_name, value) {
    if (!isdefined(var_90757d31) || var_90757d31 == "sq_common" || var_90757d31 == "keys_zm") {
        return;
    }
    if (isdefined(level.var_5a0e3356) && (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats || level.var_5a0e3356)) {
        return;
    }
    if (!isdefined(level.var_1779387)) {
        level.var_1779387 = [];
    }
    if (!(isdefined(level.var_1779387[var_90757d31]) && level.var_1779387[var_90757d31])) {
        return;
    }
    self adddstat("buildables", var_90757d31, stat_name, value);
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0x4f3c501b, Offset: 0xbcb8
// Size: 0x14
function function_c47389a0(var_9967ff1, var_861eaee4) {
    
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x0
// Checksum 0x4471472e, Offset: 0xbcd8
// Size: 0xc
function function_dfc0d988(var_9967ff1) {
    
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0x1a069358, Offset: 0xbcf0
// Size: 0x8e
function function_2e12ff6d(var_9967ff1) {
    if (isdefined(var_9967ff1)) {
        switch (var_9967ff1) {
        case 94:
            return "riotshield_zm";
        case 79:
            return "turbine";
        case 80:
            return "turret";
        case 81:
            return "electric_trap";
        case 96:
            return "springpad_zm";
        case 95:
            return "slipgun_zm";
        }
    }
    return var_9967ff1;
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x0
// Checksum 0x862bc075, Offset: 0xbd88
// Size: 0xc4
function function_b6dac932(var_deec1671) {
    foreach (var_d7223f7a in level.var_5c007ed5) {
        if (var_d7223f7a.var_e312521d.name == var_deec1671) {
            if (isdefined(var_d7223f7a.model)) {
                return var_d7223f7a.model;
            }
            break;
        }
    }
    return undefined;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0x517378ee, Offset: 0xbe58
// Size: 0x144
function function_94de816b(var_deec1671, str_piece) {
    foreach (var_d7223f7a in level.var_5c007ed5) {
        if (var_d7223f7a.var_e312521d.name == var_deec1671) {
            foreach (var_5b55e566 in var_d7223f7a.craftablespawn.a_piecespawns) {
                if (var_5b55e566.piecename == str_piece) {
                    return var_5b55e566;
                }
            }
            break;
        }
    }
    return undefined;
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x0
// Checksum 0x85032513, Offset: 0xbfa8
// Size: 0x5c
function function_43f48dc7(var_deec1671, str_piece) {
    var_5b55e566 = function_94de816b(var_deec1671, str_piece);
    if (isdefined(var_5b55e566)) {
        self function_d1aff147(var_5b55e566);
    }
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xc7399e7a, Offset: 0xc010
// Size: 0x5c
function function_95ab081(var_deec1671, str_piece) {
    var_5b55e566 = function_94de816b(var_deec1671, str_piece);
    if (isdefined(var_5b55e566)) {
        self function_ec15c9de(var_5b55e566);
    }
}

// Namespace namespace_f37770c8
// Params 1, eflags: 0x1 linked
// Checksum 0xdce7bb22, Offset: 0xc078
// Size: 0x112
function function_ec15c9de(var_4da9ab3a) {
    if (!isdefined(self.var_1666fe57)) {
        self.var_1666fe57 = [];
    }
    foreach (slot, var_fbf6048c in self.var_1666fe57) {
        if (var_4da9ab3a.piecename === var_fbf6048c.piecename && var_4da9ab3a.var_dba2448c === var_fbf6048c.var_dba2448c) {
            self clientfield::set_to_player("craftable", 0);
            self.var_1666fe57[slot] = undefined;
            self notify("craftable_piece_released" + slot);
        }
    }
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0xbd666105, Offset: 0xc198
// Size: 0x162
function function_1f5d26ed(var_deec1671, str_piece) {
    foreach (var_d7223f7a in level.var_5c007ed5) {
        if (var_d7223f7a.var_e312521d.name == var_deec1671) {
            foreach (var_5b55e566 in var_d7223f7a.craftablespawn.a_piecespawns) {
                if (var_5b55e566.piecename == str_piece && isdefined(var_5b55e566.model)) {
                    return var_5b55e566.model;
                }
            }
            break;
        }
    }
    return undefined;
}

// Namespace namespace_f37770c8
// Params 3, eflags: 0x1 linked
// Checksum 0x1b867162, Offset: 0xc308
// Size: 0xa4
function function_97be99b3(var_8ea57eb1, var_86a3391a, var_3fad0660) {
    self notify(#"hash_97be99b3");
    self endon(#"hash_97be99b3");
    if (var_3fad0660) {
        if (isdefined(var_8ea57eb1)) {
            self thread clientfield::set_player_uimodel(var_8ea57eb1, 1);
        }
        var_83c971ff = 3.5;
    } else {
        var_83c971ff = 3.5;
    }
    self thread function_2bb37724(var_86a3391a, var_83c971ff);
}

// Namespace namespace_f37770c8
// Params 2, eflags: 0x1 linked
// Checksum 0x3215a17b, Offset: 0xc3b8
// Size: 0x5c
function function_2bb37724(var_86a3391a, var_83c971ff) {
    self endon(#"disconnect");
    self thread clientfield::set_player_uimodel(var_86a3391a, 1);
    wait(var_83c971ff);
    self thread clientfield::set_player_uimodel(var_86a3391a, 0);
}

/#

    // Namespace namespace_f37770c8
    // Params 0, eflags: 0x1 linked
    // Checksum 0xecdc2dbe, Offset: 0xc420
    // Size: 0x708
    function function_bd335247() {
        setdvar("toplayer", "toplayer");
        setdvar("toplayer", "toplayer");
        setdvar("toplayer", "toplayer");
        setdvar("toplayer", "toplayer");
        while (true) {
            var_6d9966ef = getdvarstring("toplayer");
            if (var_6d9966ef != "toplayer") {
                a_toks = strtok(var_6d9966ef, "toplayer");
                var_6d9966ef = a_toks[0];
                n_player = isdefined(a_toks[1]) ? int(a_toks[1]) : 0;
                var_6e606195 = level.var_b68fa2a8[var_6d9966ef].var_5b55e566;
                if (isdefined(var_6e606195)) {
                    player = level.players[n_player];
                    if (isdefined(player)) {
                        player thread function_d1aff147(var_6e606195);
                    }
                }
                setdvar("toplayer", "toplayer");
            }
            equipment_id = getdvarstring("toplayer");
            if (equipment_id != "toplayer") {
                foreach (player in getplayers()) {
                    if (zm_equipment::is_included(equipment_id)) {
                        player zm_equipment::buy(equipment_id);
                    }
                }
                setdvar("toplayer", "toplayer");
            }
            var_6d9966ef = getdvarstring("toplayer", "toplayer");
            if (var_6d9966ef != "toplayer") {
                var_6e606195 = level.var_b68fa2a8[var_6d9966ef].var_5b55e566;
                if (isdefined(var_6e606195.model)) {
                    v_pos = var_6e606195.model.origin;
                } else {
                    v_pos = var_6e606195.start_origin;
                }
                queryresult = positionquery_source_navigation(v_pos, 100, -56, -56, 15);
                if (queryresult.data.size) {
                    point = arraygetclosest(v_pos, queryresult.data);
                    level.players[0] setorigin(point.origin);
                    level.players[0] setplayerangles(vectortoangles(v_pos - point.origin));
                } else {
                    iprintlnbold("toplayer");
                }
                setdvar("toplayer", "toplayer");
            }
            var_6d9966ef = getdvarstring("toplayer", "toplayer");
            if (var_6d9966ef != "toplayer") {
                var_f53fd362 = [];
                foreach (unitrigger_stub in level.var_5c007ed5) {
                    if (unitrigger_stub.equipname === var_6d9966ef) {
                        if (!isdefined(var_f53fd362)) {
                            var_f53fd362 = [];
                        } else if (!isarray(var_f53fd362)) {
                            var_f53fd362 = array(var_f53fd362);
                        }
                        var_f53fd362[var_f53fd362.size] = unitrigger_stub;
                    }
                }
                if (var_f53fd362.size) {
                    v_pos = arraygetclosest(level.players[0].origin, var_f53fd362).origin;
                    queryresult = positionquery_source_navigation(v_pos, 100, -56, -56, 15);
                    if (queryresult.data.size) {
                        point = arraygetclosest(v_pos, queryresult.data);
                        level.players[0] setorigin(point.origin);
                        level.players[0] setplayerangles(vectortoangles(v_pos - point.origin));
                    } else {
                        iprintlnbold("toplayer");
                    }
                    setdvar("toplayer", "toplayer");
                }
            }
            wait(0.05);
        }
    }

    // Namespace namespace_f37770c8
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6f91d6fc, Offset: 0xcb30
    // Size: 0x54e
    function function_6442c1bd(craftable) {
        wait(0.05);
        level flag::wait_till("toplayer");
        wait(0.05);
        if (!isdefined(level.var_b68fa2a8)) {
            level.var_b68fa2a8 = [];
        }
        if (isdefined(craftable.weaponname)) {
            str_cmd = "toplayer" + craftable.name + "toplayer" + craftable.weaponname + "toplayer";
            adddebugcommand(str_cmd);
        }
        if (!isdefined(craftable.var_7a5f63bc)) {
            return;
        }
        foreach (var_b1028d0b in craftable.var_7a5f63bc) {
            var_9cd24e96 = undefined;
            var_33246a9d = undefined;
            if (isdefined(var_b1028d0b.var_c05b32e7)) {
                var_9cd24e96 = var_b1028d0b.var_c05b32e7;
                var_33246a9d = var_9cd24e96;
            } else if (isdefined(var_b1028d0b.piecename)) {
                var_9cd24e96 = var_b1028d0b.piecename;
                var_33246a9d = var_b1028d0b.piecename;
            } else if (isdefined(var_b1028d0b.var_dcc30f2f)) {
                var_9cd24e96 = "toplayer";
                var_33246a9d = var_b1028d0b.var_dcc30f2f;
            } else {
                continue;
            }
            tokens = strtok(var_9cd24e96, "toplayer");
            var_bbbb8e53 = "toplayer";
            foreach (token in tokens) {
                if (token != "toplayer" && token != "toplayer") {
                    var_bbbb8e53 = var_bbbb8e53 + "toplayer" + token;
                }
            }
            level.var_b68fa2a8["toplayer" + var_33246a9d] = var_b1028d0b;
            str_cmd = "toplayer" + craftable.name + "toplayer" + var_bbbb8e53 + "toplayer" + var_33246a9d + "toplayer";
            adddebugcommand(str_cmd);
            str_cmd = "toplayer" + craftable.name + "toplayer" + var_bbbb8e53 + "toplayer" + var_33246a9d + "toplayer";
            adddebugcommand(str_cmd);
            str_cmd = "toplayer" + craftable.name + "toplayer" + var_bbbb8e53 + "toplayer" + var_33246a9d + "toplayer";
            adddebugcommand(str_cmd);
            str_cmd = "toplayer" + craftable.name + "toplayer" + var_bbbb8e53 + "toplayer" + var_33246a9d + "toplayer";
            adddebugcommand(str_cmd);
            str_cmd = "toplayer" + craftable.name + "toplayer" + var_bbbb8e53 + "toplayer" + var_33246a9d + "toplayer";
            adddebugcommand(str_cmd);
            str_cmd = "toplayer" + craftable.name + "toplayer" + var_bbbb8e53 + "toplayer" + var_b1028d0b.var_dba2448c + "toplayer";
            adddebugcommand(str_cmd);
            var_b1028d0b.var_7080cd19 = "toplayer";
        }
    }

#/
