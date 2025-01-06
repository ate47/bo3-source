#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace _zm_weapon_locker;

// Namespace _zm_weapon_locker
// Params 0, eflags: 0x0
// Checksum 0x2a7ef8f7, Offset: 0x2a8
// Size: 0x7a
function main() {
    if (!isdefined(level.var_9e648dbf)) {
        level.var_9e648dbf = level.script;
    }
    level.var_a52c84b2 = sessionmodeisonlinegame();
    var_d1a90197 = struct::get_array("weapons_locker", "targetname");
    array::thread_all(var_d1a90197, &function_e6cc80ff);
}

// Namespace _zm_weapon_locker
// Params 0, eflags: 0x0
// Checksum 0x104c239a, Offset: 0x330
// Size: 0x1b
function function_3fb22db4() {
    if (level.var_a52c84b2) {
        return;
    }
    return isdefined(self.var_fbdef072);
}

// Namespace _zm_weapon_locker
// Params 0, eflags: 0x0
// Checksum 0x842ba338, Offset: 0x358
// Size: 0x1a
function function_aaac31f8() {
    if (level.var_a52c84b2) {
        return;
    }
    return self.var_fbdef072;
}

// Namespace _zm_weapon_locker
// Params 0, eflags: 0x0
// Checksum 0x767c2828, Offset: 0x380
// Size: 0x19
function function_b2d62da3() {
    if (level.var_a52c84b2) {
        return;
    }
    self.var_fbdef072 = undefined;
}

// Namespace _zm_weapon_locker
// Params 1, eflags: 0x0
// Checksum 0xcf80a4a6, Offset: 0x3a8
// Size: 0x22
function function_53650cd4(weapondata) {
    if (level.var_a52c84b2) {
        return;
    }
    self.var_fbdef072 = weapondata;
}

// Namespace _zm_weapon_locker
// Params 0, eflags: 0x0
// Checksum 0x22d5292, Offset: 0x3d8
// Size: 0x1aa
function function_e6cc80ff() {
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = self.origin;
    if (isdefined(self.script_angles)) {
        unitrigger_stub.angles = self.script_angles;
    } else {
        unitrigger_stub.angles = self.angles;
    }
    unitrigger_stub.script_angles = unitrigger_stub.angles;
    if (isdefined(self.script_length)) {
        unitrigger_stub.script_length = self.script_length;
    } else {
        unitrigger_stub.script_length = 16;
    }
    if (isdefined(self.script_width)) {
        unitrigger_stub.script_width = self.script_width;
    } else {
        unitrigger_stub.script_width = 32;
    }
    if (isdefined(self.script_height)) {
        unitrigger_stub.script_height = self.script_height;
    } else {
        unitrigger_stub.script_height = 64;
    }
    unitrigger_stub.origin -= anglestoright(unitrigger_stub.angles) * unitrigger_stub.script_length / 2;
    unitrigger_stub.targetname = "weapon_locker";
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.clientfieldname = "weapon_locker";
    zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
    unitrigger_stub.prompt_and_visibility_func = &function_230629b3;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_78b3513e);
}

// Namespace _zm_weapon_locker
// Params 1, eflags: 0x0
// Checksum 0x676a4aea, Offset: 0x590
// Size: 0x61
function function_16a9ae60(weapon) {
    weapon = zm_weapons::get_base_weapon(weapon);
    if (!zm_weapons::is_weapon_included(weapon)) {
        return false;
    }
    if (zm_utility::is_offhand_weapon(weapon) || zm_utility::is_limited_weapon(weapon)) {
        return false;
    }
    return true;
}

// Namespace _zm_weapon_locker
// Params 2, eflags: 0x0
// Checksum 0x472ea9d7, Offset: 0x600
// Size: 0x272
function function_8d8a50d(player, weapon) {
    var_3b3df9dc = player function_3fb22db4();
    if (!var_3b3df9dc) {
        weapon = player zm_weapons::get_nonalternate_weapon(weapon);
        if (weapon == level.weaponnone) {
            self setcursorhint("HINT_NOICON");
            if (!function_16a9ae60(weapon)) {
                self sethintstring(%ZOMBIE_WEAPON_LOCKER_DENY);
            } else {
                self sethintstring(%ZOMBIE_WEAPON_LOCKER_STORE);
            }
        } else {
            self setcursorhint("HINT_WEAPON", weapon);
            if (!function_16a9ae60(weapon)) {
                self sethintstring(%ZOMBIE_WEAPON_LOCKER_DENY_FILL);
            } else {
                self sethintstring(%ZOMBIE_WEAPON_LOCKER_STORE_FILL);
            }
        }
        return;
    }
    weapondata = player function_aaac31f8();
    if (isdefined(level.var_f0260130)) {
        weapondata = function_abb2d02b(weapondata, level.var_f0260130);
    }
    var_acfe1829 = weapondata["weapon"];
    primaries = player getweaponslistprimaries();
    var_f0b98674 = zm_utility::get_player_weapon_limit(player);
    weapon = player zm_weapons::get_nonalternate_weapon(weapon);
    if (isdefined(primaries) && primaries.size >= var_f0b98674 || var_acfe1829 == weapon) {
        if (!function_16a9ae60(weapon)) {
            if (weapon == level.weaponnone) {
                self setcursorhint("HINT_NOICON", weapon);
                self sethintstring(%ZOMBIE_WEAPON_LOCKER_DENY);
                return;
            }
            self setcursorhint("HINT_WEAPON", weapon);
            self sethintstring(%ZOMBIE_WEAPON_LOCKER_DENY_FILL);
            return;
        }
    }
    self setcursorhint("HINT_WEAPON", var_acfe1829);
    self sethintstring(%ZOMBIE_WEAPON_LOCKER_GRAB_FILL);
}

// Namespace _zm_weapon_locker
// Params 1, eflags: 0x0
// Checksum 0xdb125eb1, Offset: 0x880
// Size: 0x2c
function function_230629b3(player) {
    self function_8d8a50d(player, player getcurrentweapon());
    return true;
}

// Namespace _zm_weapon_locker
// Params 0, eflags: 0x0
// Checksum 0xb2143ca5, Offset: 0x8b8
// Size: 0x4f5
function function_78b3513e() {
    self.parent_player thread function_1e1bbb9a(self);
    while (true) {
        self waittill(#"trigger", player);
        var_3b3df9dc = player function_3fb22db4();
        if (!var_3b3df9dc) {
            curweapon = player getcurrentweapon();
            curweapon = player zm_weapons::switch_from_alt_weapon(curweapon);
            if (!function_16a9ae60(curweapon)) {
                continue;
            }
            weapondata = player zm_weapons::get_player_weapondata(player);
            player function_53650cd4(weapondata);
            assert(curweapon == weapondata["<dev string:x28>"], "<dev string:x2f>");
            player takeweapon(curweapon);
            primaries = player getweaponslistprimaries();
            if (isdefined(primaries[0])) {
                player switchtoweapon(primaries[0]);
            } else {
                player zm_weapons::give_fallback_weapon();
            }
            self function_8d8a50d(player, player getcurrentweapon());
            player playsoundtoplayer("evt_fridge_locker_close", player);
            player thread zm_audio::create_and_play_dialog("general", "weapon_storage");
        } else {
            curweapon = player getcurrentweapon();
            primaries = player getweaponslistprimaries();
            weapondata = player function_aaac31f8();
            if (isdefined(level.var_f0260130)) {
                weapondata = function_abb2d02b(weapondata, level.var_f0260130);
            }
            var_acfe1829 = weapondata["weapon"];
            if (!function_16a9ae60(var_acfe1829)) {
                player playlocalsound(level.zmb_laugh_alias);
                player function_b2d62da3();
                self function_8d8a50d(player, player getcurrentweapon());
                continue;
            }
            var_ad86f906 = zm_weapons::get_base_weapon(curweapon);
            var_9b69e02 = zm_weapons::get_base_weapon(var_acfe1829);
            if (player zm_weapons::has_weapon_or_upgrade(var_9b69e02) && var_9b69e02 != var_ad86f906) {
                self sethintstring(%ZOMBIE_WEAPON_LOCKER_DENY);
                wait 3;
                self function_8d8a50d(player, player getcurrentweapon());
                continue;
            }
            var_f0b98674 = zm_utility::get_player_weapon_limit(player);
            if (isdefined(primaries) && primaries.size >= var_f0b98674 || var_acfe1829 == curweapon) {
                curweapon = player zm_weapons::switch_from_alt_weapon(curweapon);
                if (!function_16a9ae60(curweapon)) {
                    self sethintstring(%ZOMBIE_WEAPON_LOCKER_DENY);
                    wait 3;
                    self function_8d8a50d(player, player getcurrentweapon());
                    continue;
                }
                curweapondata = player zm_weapons::get_player_weapondata(player);
                player takeweapon(curweapondata["weapon"]);
                player zm_weapons::weapondata_give(weapondata);
                player function_b2d62da3();
                player function_53650cd4(curweapondata);
                player switchtoweapon(weapondata["weapon"]);
                self function_8d8a50d(player, player getcurrentweapon());
            } else {
                player thread zm_audio::create_and_play_dialog("general", "wall_withdrawl");
                player function_b2d62da3();
                player zm_weapons::weapondata_give(weapondata);
                player switchtoweapon(weapondata["weapon"]);
                self function_8d8a50d(player, player getcurrentweapon());
            }
            level notify(#"hash_bca5d5b1");
            player playsoundtoplayer("evt_fridge_locker_open", player);
        }
        wait 0.5;
    }
}

// Namespace _zm_weapon_locker
// Params 1, eflags: 0x0
// Checksum 0x6cb2e51c, Offset: 0xdb8
// Size: 0x55
function function_1e1bbb9a(trigger) {
    self endon(#"disconnect");
    self endon(#"death");
    trigger endon(#"kill_trigger");
    while (true) {
        self waittill(#"weapon_change", newweapon);
        trigger function_8d8a50d(self, newweapon);
    }
}

// Namespace _zm_weapon_locker
// Params 2, eflags: 0x0
// Checksum 0x5a79afe4, Offset: 0xe18
// Size: 0x33
function function_43861c2b(var_f9b569, var_f0e5835e) {
    if (!isdefined(level.var_f0260130)) {
        level.var_f0260130 = [];
    }
    level.var_f0260130[var_f9b569] = var_f0e5835e;
}

// Namespace _zm_weapon_locker
// Params 2, eflags: 0x0
// Checksum 0xc8b448ca, Offset: 0xe58
// Size: 0x36f
function function_abb2d02b(weapondata, maptable) {
    weapon = weapondata["weapon"].rootweapon;
    att = undefined;
    if (weapondata["weapon"].attachments.size) {
        att = weapondata["weapon"].attachments[0];
    }
    if (!isdefined(maptable[weapon])) {
        return weapondata;
    }
    weapondata["weapon"] = maptable[weapon];
    weapon = weapondata["weapon"];
    if (zm_weapons::is_weapon_upgraded(weapon)) {
        if (isdefined(att) && zm_weapons::weapon_supports_attachments(weapon)) {
            base = zm_weapons::get_base_weapon(weapon);
            if (!zm_weapons::weapon_supports_this_attachment(base, att)) {
                att = zm_weapons::random_attachment(base);
            }
            weapondata["weapon"] = getweapon(weapondata["weapon"], att);
        } else if (zm_weapons::weapon_supports_default_attachment(weapon)) {
            att = zm_weapons::default_attachment(weapon);
            weapondata["weapon"] = getweapon(weapondata["weapon"], att);
        }
    }
    weapon = weapondata["weapon"];
    if (weapon != level.weaponnone) {
        weapondata["clip"] = int(min(weapondata["clip"], weapon.clipsize));
        weapondata["stock"] = int(min(weapondata["stock"], weapon.maxammo));
        weapondata["fuel"] = int(min(weapondata["fuel"], weapon.fuellife));
    }
    dw_weapon = weapon.dualwieldweapon;
    if (dw_weapon != level.weaponnone) {
        weapondata["lh_clip"] = int(min(weapondata["lh_clip"], dw_weapon.clipsize));
    }
    alt_weapon = weapon.altweapon;
    if (alt_weapon != level.weaponnone) {
        weapondata["alt_clip"] = int(min(weapondata["alt_clip"], alt_weapon.clipsize));
        weapondata["alt_stock"] = int(min(weapondata["alt_stock"], alt_weapon.maxammo));
    }
    return weapondata;
}

