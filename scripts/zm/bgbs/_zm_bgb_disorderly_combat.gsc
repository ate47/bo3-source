#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_disorderly_combat;

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x2
// Checksum 0xf8ed0bcc, Offset: 0x3b0
// Size: 0x44
function autoexec function_2dc19561() {
    system::register("zm_bgb_disorderly_combat", &__init__, &__main__, "bgb");
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0xaa7c8b1c, Offset: 0x400
// Size: 0x94
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_disorderly_combat", "time", 300, &enable, &disable, undefined, undefined);
    bgb::function_2060b89("zm_bgb_disorderly_combat");
    level.var_8fcdc919 = [];
    level.var_5013e65c = [];
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0x53464231, Offset: 0x4a0
// Size: 0x2c
function __main__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    function_32710943();
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0x7bcfe5e3, Offset: 0x4d8
// Size: 0x3c
function enable() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    self function_7039f685();
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0xf5dec5e0, Offset: 0x520
// Size: 0x14
function disable() {
    function_bd7f98af();
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0x7db249be, Offset: 0x540
// Size: 0xfc
function function_32710943() {
    var_dd341085 = getarraykeys(level.zombie_weapons);
    foreach (w_player in var_dd341085) {
        w_player function_32818605();
    }
    if (isdefined(level.aat)) {
        level.var_5013e65c = getarraykeys(level.aat);
        arrayremovevalue(level.var_5013e65c, "none");
    }
}

// Namespace zm_bgb_disorderly_combat
// Params 1, eflags: 0x0
// Checksum 0x9dddfa3b, Offset: 0x648
// Size: 0x2c
function function_a2ab8d19(var_390e457) {
    arrayremovevalue(level.var_8fcdc919, var_390e457);
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0x1601f055, Offset: 0x680
// Size: 0x54
function function_32818605() {
    if (!self.ismeleeweapon && !self.isgrenadeweapon && !self function_f0cecf3c()) {
        array::add(level.var_8fcdc919, self, 0);
    }
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0x3a61de60, Offset: 0x6e0
// Size: 0x34e
function function_7039f685() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    level.var_8fcdc919 = array::randomize(level.var_8fcdc919);
    self setperk("specialty_ammodrainsfromstockfirst");
    self thread disable_weapons();
    self.get_player_weapon_limit = &function_7087df78;
    self util::waittill_either("weapon_change_complete", "bgb_flavor_hexed_give_zm_bgb_disorderly_combat");
    if (!isdefined(self.var_fe555a38)) {
        self.var_fe555a38 = self getcurrentweapon();
    }
    b_upgraded = zm_weapons::is_weapon_upgraded(self.var_fe555a38);
    var_6c94ea19 = self aat::getaatonweapon(self.var_fe555a38);
    if (isdefined(var_6c94ea19)) {
        function_c7d73bac(var_6c94ea19.name);
    }
    if (isdefined(self.aat) && self.aat.size) {
        self.var_cc73883d = arraycopy(self.aat);
        self.aat = [];
    }
    n_index = 0;
    var_1ff6fb34 = 0;
    while (true) {
        self bgb::function_378bff5d();
        self function_8a5ef15f();
        if (isdefined(self.var_8cee13f3)) {
            if (self hasweapon(self.var_8cee13f3)) {
                self takeweapon(self.var_8cee13f3);
            } else {
                self takeweapon(self getcurrentweapon());
            }
        }
        self playsoundtoplayer("zmb_bgb_disorderly_weap_switch", self);
        if (isdefined(var_6c94ea19) && level.var_5013e65c.size) {
            var_77bd95a = level.var_5013e65c[var_1ff6fb34];
            var_1ff6fb34++;
            if (var_1ff6fb34 >= level.var_5013e65c.size) {
                level.var_5013e65c = array::randomize(level.var_5013e65c);
                var_1ff6fb34 = 0;
            }
        }
        do {
            var_aca7cde1 = self function_4035ce17(n_index, b_upgraded, var_77bd95a);
            n_index++;
        } while (!var_aca7cde1);
        self thread function_dedb7bff();
        wait(10);
    }
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0x99d0311d, Offset: 0xa38
// Size: 0x4c
function function_dedb7bff() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    wait(5);
    self playsoundtoplayer("zmb_bgb_disorderly_5seconds", self);
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0x26973370, Offset: 0xa90
// Size: 0x68
function disable_weapons() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    while (true) {
        waittillframeend();
        self disableweaponcycling();
        self disableoffhandweapons();
        wait(0.05);
    }
}

// Namespace zm_bgb_disorderly_combat
// Params 3, eflags: 0x1 linked
// Checksum 0xce0c0f39, Offset: 0xb00
// Size: 0x1a8
function function_4035ce17(n_index, b_upgraded, var_77bd95a) {
    if (n_index >= level.var_8fcdc919.size) {
        level.var_8fcdc919 = array::randomize(level.var_8fcdc919);
        n_index = 0;
    }
    w_random = level.var_8fcdc919[n_index];
    if (b_upgraded) {
        w_random = zm_weapons::get_upgrade_weapon(w_random);
    }
    if (!self has_weapon(w_random)) {
        w_random = self zm_weapons::give_build_kit_weapon(w_random);
        self.var_8cee13f3 = w_random;
        self giveweapon(w_random);
        self shoulddoinitialweaponraise(w_random, 0);
        self switchtoweaponimmediate(w_random);
        if (isdefined(var_77bd95a) && var_77bd95a != "none") {
            self thread aat::acquire(w_random, var_77bd95a);
        }
        self bgb::do_one_shot_use(1);
        return 1;
    }
    /#
        println("zmb_bgb_disorderly_5seconds" + w_random.displayname);
    #/
    return 0;
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0x102ef4d5, Offset: 0xcb0
// Size: 0x96
function function_f0cecf3c() {
    switch (self.name) {
    case 9:
    case 10:
    case 3:
    case 11:
    case 12:
    case 13:
    case 14:
    case 15:
    case 16:
        return true;
    }
    if (zm_weapons::is_wonder_weapon(self) || level.start_weapon == self) {
        return true;
    }
    return false;
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0xebf79993, Offset: 0xd50
// Size: 0x182
function function_bd7f98af() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon("bgb_update_give_" + "zm_bgb_disorderly_combat");
    self thread function_be4232bc();
    self unsetperk("specialty_ammodrainsfromstockfirst");
    self function_8a5ef15f();
    if (isdefined(self.var_8cee13f3) && self hasweapon(self.var_8cee13f3)) {
        self takeweapon(self.var_8cee13f3);
        self.var_8cee13f3 = undefined;
    }
    self.get_player_weapon_limit = undefined;
    if (isdefined(self.var_fe555a38)) {
        self zm_weapons::switch_back_primary_weapon(self.var_fe555a38);
    }
    self enableweaponcycling();
    self enableoffhandweapons();
    self.var_fe555a38 = undefined;
    if (isdefined(self.var_cc73883d)) {
        self.aat = arraycopy(self.var_cc73883d);
        self.var_cc73883d = undefined;
    }
    self notify(#"hash_46a5bae0");
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0xcbec705c, Offset: 0xee0
// Size: 0x2e
function function_be4232bc() {
    self endon(#"hash_46a5bae0");
    self waittill(#"bled_out");
    self.var_8cee13f3 = undefined;
    self.var_fe555a38 = undefined;
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0x460964ed, Offset: 0xf18
// Size: 0x22
function function_1f90c35a() {
    if (isdefined(level.var_464197de)) {
        return self [[ level.var_464197de ]]();
    }
    return 0;
}

// Namespace zm_bgb_disorderly_combat
// Params 0, eflags: 0x1 linked
// Checksum 0x18eb50ed, Offset: 0xf48
// Size: 0xd4
function function_8a5ef15f() {
    while (self.is_drinking > 0 || zm_utility::is_placeable_mine(self.currentweapon) || zm_equipment::is_equipment(self.currentweapon) || self zm_utility::is_player_revive_tool(self.currentweapon) || level.weaponnone == self.currentweapon || self zm_equipment::hacker_active() || self laststand::player_is_in_laststand() || self function_1f90c35a()) {
        wait(0.05);
    }
}

// Namespace zm_bgb_disorderly_combat
// Params 1, eflags: 0x1 linked
// Checksum 0xf6b7c8f0, Offset: 0x1028
// Size: 0xba
function function_c7d73bac(str_name) {
    arrayremovevalue(level.var_5013e65c, str_name);
    level.var_5013e65c = array::randomize(level.var_5013e65c);
    if (!isdefined(level.var_5013e65c)) {
        level.var_5013e65c = [];
    } else if (!isarray(level.var_5013e65c)) {
        level.var_5013e65c = array(level.var_5013e65c);
    }
    level.var_5013e65c[level.var_5013e65c.size] = str_name;
}

// Namespace zm_bgb_disorderly_combat
// Params 1, eflags: 0x1 linked
// Checksum 0x575cfa8c, Offset: 0x10f0
// Size: 0xbe
function has_weapon(w_check) {
    a_weapons = self getweaponslistprimaries();
    w_base = zm_weapons::get_base_weapon(w_check);
    if (self hasweapon(w_base, 1)) {
        return true;
    }
    w_upgraded = zm_weapons::get_upgrade_weapon(w_check);
    if (self hasweapon(w_upgraded, 1)) {
        return true;
    }
    return false;
}

// Namespace zm_bgb_disorderly_combat
// Params 1, eflags: 0x1 linked
// Checksum 0x1c90ca94, Offset: 0x11b8
// Size: 0x56
function function_7087df78(e_player) {
    var_dd27188c = 2;
    if (e_player hasperk("specialty_additionalprimaryweapon")) {
        var_dd27188c = level.additionalprimaryweapon_limit;
    }
    var_dd27188c++;
    return var_dd27188c;
}

