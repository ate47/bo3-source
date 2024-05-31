#using scripts/shared/_burnplayer;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_gadgets;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace roulette;

// Namespace roulette
// Params 0, eflags: 0x2
// namespace_ce9cba59<file_0>::function_2dc19561
// Checksum 0x5e5edd60, Offset: 0x3f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_roulette", &__init__, undefined, undefined);
}

// Namespace roulette
// Params 0, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_8c87d8eb
// Checksum 0xbbb057eb, Offset: 0x438
// Size: 0x308
function __init__() {
    clientfield::register("toplayer", "roulette_state", 11000, 2, "int");
    ability_player::register_gadget_activation_callbacks(43, &function_ca371720, &function_fc8f7639);
    ability_player::register_gadget_possession_callbacks(43, &function_a55195e4, &function_e13e0d32);
    ability_player::register_gadget_flicker_callbacks(43, &function_26221a8d);
    ability_player::register_gadget_is_inuse_callbacks(43, &function_4cfa6fa0);
    ability_player::register_gadget_ready_callbacks(43, &function_a3b109bf);
    ability_player::register_gadget_is_flickering_callbacks(43, &function_327cbbe);
    ability_player::register_gadget_should_notify(43, 0);
    callback::on_connect(&function_1a90b6ab);
    callback::on_spawned(&function_e25adb10);
    if (sessionmodeismultiplayergame()) {
        level.var_645f7522 = [];
        level.var_645f7522[0] = 0;
        level.var_645f7522[1] = 0;
        level.weaponnone = getweapon("none");
        level.var_a7d38b50 = getweapon("gadget_roulette");
        function_96a406d2("gadget_flashback", 1, 1);
        function_96a406d2("gadget_combat_efficiency", 1, 1);
        function_96a406d2("gadget_heat_wave", 1, 1);
        function_96a406d2("gadget_vision_pulse", 1, 1);
        function_96a406d2("gadget_speed_burst", 1, 1);
        function_96a406d2("gadget_camo", 1, 1);
        function_96a406d2("gadget_armor", 1, 1);
        function_96a406d2("gadget_resurrect", 1, 1);
        function_96a406d2("gadget_clone", 1, 1);
    }
    /#
    #/
}

/#

    // Namespace roulette
    // Params 0, eflags: 0x0
    // namespace_ce9cba59<file_0>::function_22cd788
    // Checksum 0xa669fb93, Offset: 0x748
    // Size: 0x1c
    function updatedvars() {
        while (true) {
            wait(1);
        }
    }

#/

// Namespace roulette
// Params 1, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_4cfa6fa0
// Checksum 0xcf390dee, Offset: 0x770
// Size: 0x22
function function_4cfa6fa0(slot) {
    return self gadgetisactive(slot);
}

// Namespace roulette
// Params 1, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_327cbbe
// Checksum 0xefc80a36, Offset: 0x7a0
// Size: 0x22
function function_327cbbe(slot) {
    return self gadgetflickering(slot);
}

// Namespace roulette
// Params 2, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_26221a8d
// Checksum 0xf7719fe7, Offset: 0x7d0
// Size: 0x34
function function_26221a8d(slot, weapon) {
    self thread function_d54205c5(slot, weapon);
}

// Namespace roulette
// Params 2, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_a55195e4
// Checksum 0x58e8b84d, Offset: 0x810
// Size: 0x54
function function_a55195e4(slot, weapon) {
    self clientfield::set_to_player("roulette_state", 0);
    if (sessionmodeismultiplayergame()) {
        self.isroulette = 1;
    }
}

// Namespace roulette
// Params 2, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_e13e0d32
// Checksum 0x10114e8e, Offset: 0x870
// Size: 0x34
function function_e13e0d32(slot, weapon) {
    /#
        if (level.devgui_giving_abilities === 1) {
            self.isroulette = 0;
        }
    #/
}

// Namespace roulette
// Params 0, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_1a90b6ab
// Checksum 0x6b12eddb, Offset: 0x8b0
// Size: 0x14
function function_1a90b6ab() {
    function_7c7f99df();
}

// Namespace roulette
// Params 0, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_7c7f99df
// Checksum 0x2172c970, Offset: 0x8d0
// Size: 0x42
function function_7c7f99df() {
    if (self.isroulette === 1) {
        if (!isdefined(self.pers[#"hash_9f129a92"])) {
            self.pers[#"hash_9f129a92"] = 1;
        }
    }
}

// Namespace roulette
// Params 0, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_e25adb10
// Checksum 0xa0d5fa2f, Offset: 0x920
// Size: 0x14
function function_e25adb10() {
    function_7c7f99df();
}

// Namespace roulette
// Params 0, eflags: 0x0
// namespace_ce9cba59<file_0>::function_f0e244e5
// Checksum 0x99ec1590, Offset: 0x940
// Size: 0x4
function function_f0e244e5() {
    
}

// Namespace roulette
// Params 2, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_ca371720
// Checksum 0xef5ffb71, Offset: 0x950
// Size: 0x2c
function function_ca371720(slot, weapon) {
    function_41f588ae(weapon, 1);
}

// Namespace roulette
// Params 2, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_a3b109bf
// Checksum 0x1974859b, Offset: 0x988
// Size: 0x4c
function function_a3b109bf(slot, weapon) {
    if (self gadgetisactive(slot)) {
        return;
    }
    function_41f588ae(weapon, 0);
}

// Namespace roulette
// Params 2, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_41f588ae
// Checksum 0x7fa172b2, Offset: 0x9e0
// Size: 0x8c
function function_41f588ae(weapon, playsound) {
    self function_381f2fff(weapon, 1);
    if (playsound) {
        self playsoundtoplayer("mpl_bm_specialist_roulette", self);
    }
    self thread function_1eb9e79f(weapon);
    self thread function_e3065835(weapon);
}

// Namespace roulette
// Params 1, eflags: 0x0
// namespace_ce9cba59<file_0>::function_834ca490
// Checksum 0xcda3e507, Offset: 0xa78
// Size: 0x5c
function function_834ca490(duration) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_d1bf2e9");
    self disableoffhandspecial();
    wait(duration);
    self enableoffhandspecial();
}

// Namespace roulette
// Params 0, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_921cfa96
// Checksum 0x881435a2, Offset: 0xae0
// Size: 0x54
function function_921cfa96() {
    self endon(#"hash_921cfa96");
    self endon(#"death");
    self endon(#"disconnect");
    self waittill(#"hero_gadget_activated");
    self clientfield::set_to_player("roulette_state", 0);
}

// Namespace roulette
// Params 1, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_e3065835
// Checksum 0xbed0d6be, Offset: 0xb40
// Size: 0x1ba
function function_e3065835(weapon) {
    self endon(#"hero_gadget_activated");
    self notify(#"hash_e3065835");
    self endon(#"hash_e3065835");
    if (!isdefined(self.pers[#"hash_9f129a92"]) || self.pers[#"hash_9f129a92"] == 0) {
        return;
    }
    self thread function_921cfa96();
    self clientfield::set_to_player("roulette_state", 1);
    wait(getdvarfloat("scr_roulette_pre_respin_wait_time", 1.3));
    while (true) {
        if (!isdefined(self)) {
            break;
        }
        if (self function_81b15d4d()) {
            self.pers[#"hash_65987563"] = undefined;
            self function_381f2fff(weapon, 0);
            self.pers[#"hash_9f129a92"] = 0;
            self notify(#"hash_921cfa96");
            self notify(#"hash_d1bf2e9");
            self clientfield::set_to_player("roulette_state", 2);
            self playsoundtoplayer("mpl_bm_specialist_roulette", self);
            self thread function_9746c63b();
            break;
        }
        wait(0.05);
    }
    if (isdefined(self)) {
        self notify(#"hash_921cfa96");
    }
}

// Namespace roulette
// Params 0, eflags: 0x0
// namespace_ce9cba59<file_0>::function_12fae26
// Checksum 0x204f4d19, Offset: 0xd08
// Size: 0x34
function function_12fae26() {
    self endon(#"hash_ab02b20c");
    wait(3);
    if (isdefined(self)) {
        self enableoffhandspecial();
    }
}

// Namespace roulette
// Params 0, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_9746c63b
// Checksum 0x548918d1, Offset: 0xd48
// Size: 0x44
function function_9746c63b() {
    self endon(#"death");
    self endon(#"disconnect");
    wait(0.5);
    self clientfield::set_to_player("roulette_state", 0);
}

// Namespace roulette
// Params 1, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_1eb9e79f
// Checksum 0x79bbb368, Offset: 0xd98
// Size: 0x94
function function_1eb9e79f(weapon) {
    self endon(#"death");
    self notify(#"hash_1eb9e79f");
    self endon(#"hash_1eb9e79f");
    self waittill(#"hero_gadget_activated");
    self.pers[#"hash_9f129a92"] = 1;
    if (isdefined(weapon) || weapon.name != "gadget_roulette") {
        self clientfield::set_to_player("roulette_state", 0);
    }
}

// Namespace roulette
// Params 2, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_381f2fff
// Checksum 0xf0c00b47, Offset: 0xe38
// Size: 0x23e
function function_381f2fff(weapon, var_beed3e44) {
    for (i = 0; i < 3; i++) {
        if (isdefined(self._gadgets_player[i])) {
            self takeweapon(self._gadgets_player[i]);
        }
    }
    randomweapon = weapon;
    if (isdefined(self.pers[#"hash_65987563"])) {
        randomweapon = self.pers[#"hash_65987563"];
    } else if (isdefined(self.pers[#"hash_cbcfa831"]) || isdefined(self.pers[#"hash_cbcfa832"])) {
        for (randomweapon = function_917fa966(var_beed3e44); isdefined(self.pers[#"hash_cbcfa832"]) && (randomweapon == self.pers[#"hash_cbcfa831"] || randomweapon == self.pers[#"hash_cbcfa832"]); randomweapon = function_917fa966(var_beed3e44)) {
        }
    } else {
        randomweapon = function_917fa966(var_beed3e44);
    }
    if (isdefined(level.playgadgetready) && !var_beed3e44) {
        self thread [[ level.playgadgetready ]](randomweapon, !var_beed3e44);
    }
    self thread function_27bf03c4(weapon);
    self giveweapon(randomweapon);
    self.pers[#"hash_65987563"] = randomweapon;
    self.pers[#"hash_cbcfa832"] = self.pers[#"hash_cbcfa831"];
    self.pers[#"hash_cbcfa831"] = randomweapon;
}

// Namespace roulette
// Params 2, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_fc8f7639
// Checksum 0x6b212acd, Offset: 0x1080
// Size: 0x2c
function function_fc8f7639(slot, weapon) {
    thread function_27bf03c4(weapon);
}

// Namespace roulette
// Params 1, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_27bf03c4
// Checksum 0x123a51e0, Offset: 0x10b8
// Size: 0x10c
function function_27bf03c4(weapon) {
    self notify(#"hash_27bf03c4");
    self endon(#"hash_27bf03c4");
    var_9a1435cf = self waittill(#"heroability_off");
    if (isdefined(var_9a1435cf) && var_9a1435cf.name == "gadget_speed_burst") {
        var_9a1435cf = self waittill(#"heroability_off");
    }
    for (i = 0; i < 3; i++) {
        if (isdefined(self) && isdefined(self._gadgets_player[i])) {
            self takeweapon(self._gadgets_player[i]);
        }
    }
    if (isdefined(self)) {
        self giveweapon(level.var_a7d38b50);
        self.pers[#"hash_65987563"] = undefined;
    }
}

// Namespace roulette
// Params 2, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_d54205c5
// Checksum 0xe7ac1e92, Offset: 0x11d0
// Size: 0x14
function function_d54205c5(slot, weapon) {
    
}

// Namespace roulette
// Params 2, eflags: 0x0
// namespace_ce9cba59<file_0>::function_39b1b87b
// Checksum 0x42e32b14, Offset: 0x11f0
// Size: 0x9c
function function_39b1b87b(status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Gadget Roulette: " + status + timestr);
    }
}

// Namespace roulette
// Params 0, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_81b15d4d
// Checksum 0x786ccab, Offset: 0x1298
// Size: 0x1a
function function_81b15d4d() {
    return self actionslotthreebuttonpressed();
}

// Namespace roulette
// Params 1, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_917fa966
// Checksum 0xb828d0d1, Offset: 0x12c0
// Size: 0x166
function function_917fa966(var_beed3e44) {
    if (var_beed3e44) {
        category = 0;
        var_ef0c7c51 = 0;
    } else {
        category = 1;
        var_ef0c7c51 = 1;
    }
    var_e11107cf = randomintrange(1, level.var_645f7522[var_ef0c7c51] + 1);
    var_57988017 = getarraykeys(level.var_645f7522);
    var_19a3ca3e = "";
    foreach (gadget in var_57988017) {
        var_e11107cf -= level.var_645f7522[gadget][category];
        if (var_e11107cf <= 0) {
            var_19a3ca3e = gadget;
            break;
        }
    }
    return var_19a3ca3e;
}

// Namespace roulette
// Params 3, eflags: 0x1 linked
// namespace_ce9cba59<file_0>::function_96a406d2
// Checksum 0xf54aeb64, Offset: 0x1430
// Size: 0x126
function function_96a406d2(var_edf36e37, var_86166a51, var_c730de85) {
    gadgetweapon = getweapon(var_edf36e37);
    assert(isdefined(gadgetweapon));
    if (gadgetweapon == level.weaponnone) {
        assertmsg(var_edf36e37 + "gadget_vision_pulse");
    }
    if (!isdefined(level.var_645f7522[gadgetweapon])) {
        level.var_645f7522[gadgetweapon] = [];
    }
    level.var_645f7522[gadgetweapon][0] = var_86166a51;
    level.var_645f7522[gadgetweapon][1] = var_c730de85;
    level.var_645f7522[0] = level.var_645f7522[0] + var_86166a51;
    level.var_645f7522[1] = level.var_645f7522[1] + var_c730de85;
}

