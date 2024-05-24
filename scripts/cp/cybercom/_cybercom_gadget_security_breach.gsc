#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/player_shared;
#using scripts/shared/laststand_shared;
#using scripts/cp/_util;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/math_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_7cb6cd95;

// Namespace namespace_7cb6cd95
// Params 0, eflags: 0x1 linked
// Checksum 0x6da6a11e, Offset: 0x7b0
// Size: 0x1d4
function init() {
    clientfield::register("toplayer", "hijack_vehicle_transition", 1, 2, "int");
    clientfield::register("toplayer", "hijack_static_effect", 1, 7, "float");
    clientfield::register("toplayer", "sndInDrivableVehicle", 1, 1, "int");
    clientfield::register("vehicle", "vehicle_hijacked", 1, 1, "int");
    clientfield::register("toplayer", "hijack_spectate", 1, 1, "int");
    clientfield::register("toplayer", "hijack_static_ramp_up", 1, 1, "int");
    clientfield::register("toplayer", "vehicle_hijacked", 1, 1, "int");
    visionset_mgr::register_info("visionset", "hijack_vehicle", 1, 5, 1, 1);
    visionset_mgr::register_info("visionset", "hijack_vehicle_blur", 1, 6, 1, 1);
    callback::on_spawned(&on_player_spawned);
}

// Namespace namespace_7cb6cd95
// Params 0, eflags: 0x1 linked
// Checksum 0xb2205049, Offset: 0x990
// Size: 0x17c
function main() {
    namespace_d00ec32::function_36b56038(0, 32);
    level.cybercom.var_76af92c1 = spawnstruct();
    level.cybercom.var_76af92c1.var_875da84b = &function_875da84b;
    level.cybercom.var_76af92c1.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.var_76af92c1.var_bdb47551 = &function_bdb47551;
    level.cybercom.var_76af92c1.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.var_76af92c1.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.var_76af92c1._on = &_on;
    level.cybercom.var_76af92c1._off = &_off;
    level.cybercom.var_76af92c1.var_4135a1c4 = &function_4135a1c4;
}

// Namespace namespace_7cb6cd95
// Params 0, eflags: 0x1 linked
// Checksum 0x1fd3723d, Offset: 0xb18
// Size: 0x94
function on_player_spawned() {
    self clientfield::set_to_player("hijack_static_effect", 0);
    self clientfield::set_to_player("hijack_spectate", 0);
    self clientfield::set_to_player("hijack_static_ramp_up", 0);
    self util::freeze_player_controls(0);
    self cameraactivate(0);
}

// Namespace namespace_7cb6cd95
// Params 1, eflags: 0x1 linked
// Checksum 0xa56badab, Offset: 0xbb8
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x1 linked
// Checksum 0xf658735e, Offset: 0xbd0
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x1 linked
// Checksum 0x2b7954fa, Offset: 0xbf0
// Size: 0x13c
function function_bdb47551(slot, weapon) {
    self.cybercom.var_110c156a = 1;
    self.cybercom.var_ff7f4cdd = getdvarint("scr_security_breach_lifetime", 30);
    if (self function_1a9006bd("cybercom_securitybreach") == 2) {
        self.cybercom.var_ff7f4cdd = getdvarint("scr_security_breach_upgraded_lifetime", 60);
    }
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self.cybercom.var_73d069a7 = &function_17342509;
    self.cybercom.var_46483c8f = 63;
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x1 linked
// Checksum 0x815aac1a, Offset: 0xd38
// Size: 0x72
function function_39ea6a1b(slot, weapon) {
    self _off(slot, weapon);
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
    self.cybercom.var_46483c8f = undefined;
    self.cybercom.var_73d069a7 = undefined;
}

// Namespace namespace_7cb6cd95
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xdb8
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x1 linked
// Checksum 0x773a4088, Offset: 0xdc8
// Size: 0x4c
function function_17342509(slot, weapon) {
    self gadgetactivate(slot, weapon);
    _on(slot, weapon);
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x1 linked
// Checksum 0x7d4ee75b, Offset: 0xe20
// Size: 0x54
function _on(slot, weapon) {
    self thread function_7c96ae94(slot, weapon);
    self _off(slot, weapon);
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x1 linked
// Checksum 0x28b29453, Offset: 0xe80
// Size: 0x46
function _off(slot, weapon) {
    self thread cybercom::function_d51412df(weapon);
    self.cybercom.var_301030f7 = undefined;
    self notify(#"hash_8216024");
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x1 linked
// Checksum 0x2635fa08, Offset: 0xed0
// Size: 0xcc
function function_4135a1c4(slot, weapon) {
    if (!(isdefined(self.cybercom.var_301030f7) && self.cybercom.var_301030f7)) {
        /#
            assert(self.cybercom.var_2e20c9bd == weapon);
        #/
        self notify(#"hash_50db7e6");
        self thread cybercom::function_2006f7d0(slot, weapon, self.cybercom.var_110c156a);
        self.cybercom.var_301030f7 = 1;
        self playsoundtoplayer("gdt_securitybreach_target", self);
    }
}

// Namespace namespace_7cb6cd95
// Params 1, eflags: 0x5 linked
// Checksum 0x32af010, Offset: 0xfa8
// Size: 0x1d4
function private function_602b28e9(target) {
    if (target cybercom::function_8fd8f5b1("cybercom_hijack")) {
        if (isdefined(target.var_406cec76) && target.var_406cec76) {
            self cybercom::function_29bf9dee(target, 4);
        } else {
            self cybercom::function_29bf9dee(target, 2);
        }
        return false;
    }
    if (isdefined(target.var_5001b74f) && target.var_5001b74f != self) {
        self cybercom::function_29bf9dee(target, 7);
        return false;
    }
    if (isdefined(target.hijacked) && target.hijacked) {
        self cybercom::function_29bf9dee(target, 4);
        return false;
    }
    if (isdefined(target.is_disabled) && target.is_disabled) {
        self cybercom::function_29bf9dee(target, 6);
        return false;
    }
    if (isdefined(target.var_d3f57f67) && target.var_d3f57f67) {
        return false;
    }
    if (!isvehicle(target)) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    return true;
}

// Namespace namespace_7cb6cd95
// Params 1, eflags: 0x5 linked
// Checksum 0x735fcc3, Offset: 0x1188
// Size: 0xa2
function private function_8aac802c(weapon) {
    enemy = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
    ally = getaiteamarray("allies");
    return arraycombine(enemy, ally, 0, 0);
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x5 linked
// Checksum 0x2f866c60, Offset: 0x1238
// Size: 0x324
function private function_7c96ae94(slot, weapon) {
    aborted = 0;
    fired = 0;
    foreach (item in self.cybercom.var_d1460543) {
        if (isdefined(item.inrange) && isdefined(item.target) && item.inrange) {
            if (item.inrange == 1) {
                if (!cybercom::function_7a7d1608(item.target, weapon)) {
                    continue;
                }
                self thread challenges::function_96ed590f("cybercom_uses_control");
                item.target thread function_ecfa108e(self, weapon);
                fired++;
                continue;
            }
            if (item.inrange == 2) {
                aborted++;
            }
        }
    }
    if (aborted && !fired) {
        self.cybercom.var_d1460543 = [];
        self cybercom::function_29bf9dee(undefined, 1, 0);
    }
    if (!aborted && fired) {
        upgraded = weapon.name == "gadget_remote_hijack_upgraded";
        self playsound("gdt_cybercore_activate" + (isdefined(upgraded) && upgraded ? "_upgraded" : ""));
    }
    cybercom::function_adc40f11(weapon, fired);
    if (fired && isplayer(self)) {
        itemindex = getitemindexfromref("cybercom_hijack");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "kills", "statValue", fired);
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_7cb6cd95
// Params 5, eflags: 0x5 linked
// Checksum 0x109f5f2b, Offset: 0x1568
// Size: 0xec
function private function_cc8d5ab0(player, setname, delay, direction, duration) {
    wait(delay);
    if (direction > 0) {
        visionset_mgr::activate("visionset", setname, player, duration, 0, 0);
        visionset_mgr::deactivate("visionset", setname, player);
        return;
    }
    visionset_mgr::activate("visionset", setname, player, 0, 0, duration);
    visionset_mgr::deactivate("visionset", setname, player);
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x5 linked
// Checksum 0x8a9f6750, Offset: 0x1660
// Size: 0x82
function private function_637db461(player, weapon) {
    if (isdefined(self.hijacked) && self.hijacked) {
        player cybercom::function_29bf9dee(self, 4);
        return false;
    }
    if (isdefined(self.is_disabled) && self.is_disabled) {
        player cybercom::function_29bf9dee(self, 6);
        return false;
    }
    return false;
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x5 linked
// Checksum 0x47545dc0, Offset: 0x16f0
// Size: 0x61c
function private function_ecfa108e(player, weapon) {
    wait(getdvarfloat("scr_security_breach_activate_delay", 0.5));
    if (!isdefined(self)) {
        return;
    }
    if (!isvehicle(self)) {
        return;
    }
    if (player laststand::player_is_in_laststand()) {
        return;
    }
    if (isdefined(player.cybercom.var_a5aee4b9) && player.cybercom.var_a5aee4b9) {
        return;
    }
    if (isdefined(self.playerdrivenversion)) {
        self setvehicletype(self.playerdrivenversion);
    }
    vehentnum = self getentitynumber();
    self notify(#"hash_f8c5dd60", weapon, player);
    self notify(#"cloneandremoveentity", vehentnum);
    level notify(#"cloneandremoveentity", vehentnum);
    player gadgetpowerset(0, 0);
    player gadgetpowerset(1, 0);
    player gadgetpowerset(2, 0);
    player cybercom::function_6c141a2d(1);
    if (isai(self) && self.archetype == "quadtank") {
        player notify(#"hash_52c9c74a", "CP_CONTROL_QUAD");
    }
    player notify(#"hash_76af92c1", self);
    waittillframeend();
    self notsolid();
    var_66ff806d = self.var_66ff806d;
    clone = cloneandremoveentity(self);
    if (!isdefined(clone)) {
        return;
    }
    clone solid();
    level notify(#"clonedentity", clone, vehentnum);
    player notify(#"clonedentity", clone, vehentnum);
    clone.takedamage = 0;
    clone.hijacked = 1;
    clone.var_a076880e = undefined;
    clone.is_disabled = 1;
    clone.owner = player;
    clone.var_66ff806d = var_66ff806d;
    clone setteam(player.team);
    clone.health = clone.healthdefault;
    clone.var_fb7ce72a = &function_637db461;
    if (isdefined(self.var_72f54197)) {
        clone.var_72f54197 = self.var_72f54197;
    }
    if (isdefined(self.var_b0ac175a)) {
        clone.var_b0ac175a = self.var_b0ac175a;
    }
    playerstate = spawnstruct();
    player function_dc86efaa(playerstate, "begin");
    if (!isdefined(clone)) {
        player disableinvulnerability();
        player cybercom::function_e60e89fe();
        return;
    }
    player.hijacked_vehicle_entity = clone;
    player function_dc86efaa(playerstate, "cloak");
    clone thread function_3dcfd0d8(getdvarint("scr_security_breach_no_damage_time", 8), player);
    if (isdefined(clone.vehicletype) && clone.vehicletype != "turret_sentry") {
        clone thread function_4b91c7e5(player, player.origin);
    }
    clone.var_3c5bf47d = 1;
    clone makevehicleusable();
    clone usevehicle(player, 0);
    clone makevehicleunusable();
    player function_dc86efaa(playerstate, "cloak_wait");
    clone clientfield::set("vehicle_hijacked", 1);
    clone.var_3c5bf47d = undefined;
    clone makevehicleusable();
    clone thread function_7da5b5d4(player);
    player function_dc86efaa(playerstate, "return_wait");
    visionset_mgr::deactivate("visionset", "hijack_vehicle_blur", player);
    player function_dc86efaa(playerstate, "finish");
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x1 linked
// Checksum 0x7101dc1, Offset: 0x1d18
// Size: 0x556
function function_dc86efaa(var_b6c35df6, str_state) {
    /#
        assert(isplayer(self));
    #/
    player = self;
    switch (str_state) {
    case 34:
        player setcontrolleruimodelvalue("vehicle.outOfRange", 0);
        player enableinvulnerability();
        player cybercom::function_6c141a2d(1);
        wait(0.1);
        return;
    case 35:
        var_b6c35df6.var_d45c1470 = player getstance();
        var_b6c35df6.var_e29151a8 = player.ignoreme;
        var_b6c35df6.var_d40d5a7d = player.var_1e983b11;
        player.var_1e983b11 = 0;
        player.ignoreme = 1;
        player setclientuivisibilityflag("weapon_hud_visible", 0);
        player setstance("crouch");
        player clientfield::set("camo_shader", 2);
        player thread function_13f4170a(2);
        player thread function_cc8d5ab0(player, "hijack_vehicle", 0.1, 1, 0.1);
        player waittill(#"hash_e08a6f71");
        player setlowready(1);
        visionset_mgr::activate("visionset", "hijack_vehicle_blur", player);
        player hide();
        player notsolid();
        player setplayercollision(0);
        player clientfield::set("camo_shader", 1);
        player clientfield::set_to_player("sndInDrivableVehicle", 1);
        player player::take_weapons();
        return;
    case 38:
        player waittill(#"hash_58a3879b");
        player clientfield::set_to_player("vehicle_hijacked", 1);
        return "return_wait";
    case 39:
        player waittill(#"hash_c68b15c8");
        player player::give_back_weapons(1);
        player seteverhadweaponall(1);
        player thread function_cc8d5ab0(player, "hijack_vehicle", 0, -1, 0.1);
        return;
    case 40:
        player show();
        player solid();
        player setplayercollision(1);
        player setstance(var_b6c35df6.var_d45c1470);
        player setlowready(0);
        player.var_1e983b11 = var_b6c35df6.var_d40d5a7d;
        player waittill(#"hash_58a3879b");
        player seteverhadweaponall(0);
        player clientfield::set_to_player("vehicle_hijacked", 0);
        player clientfield::set_to_player("sndInDrivableVehicle", 0);
        player.hijacked_vehicle_entity = undefined;
        player disableinvulnerability();
        player.ignoreme = 0;
        player setclientuivisibilityflag("weapon_hud_visible", 1);
        player cybercom::function_e60e89fe();
        wait(1);
        player clientfield::set("camo_shader", 0);
        player notify(#"hash_54dae2cc");
        return;
    }
}

// Namespace namespace_7cb6cd95
// Params 1, eflags: 0x1 linked
// Checksum 0x117cde52, Offset: 0x2278
// Size: 0xac
function function_13f4170a(direction) {
    self endon(#"death");
    self notify(#"hash_13f4170a");
    self endon(#"hash_13f4170a");
    self clientfield::set_to_player("hijack_vehicle_transition", direction);
    util::wait_network_frame();
    self notify(#"hash_e08a6f71");
    wait(0.2);
    wait(0.2);
    self notify(#"hash_58a3879b");
    self clientfield::set_to_player("hijack_vehicle_transition", 1);
}

// Namespace namespace_7cb6cd95
// Params 1, eflags: 0x1 linked
// Checksum 0xbc21c0c5, Offset: 0x2330
// Size: 0x144
function function_6c745562(ent) {
    function_1233641();
    if (isdefined(ent) && isplayer(self)) {
        self.cybercom.var_98ef0723 = ent;
        if (isdefined(ent.script_parameters)) {
            data = strtok(ent.script_parameters, " ");
            /#
                assert(data.size == 2);
            #/
            self.cybercom.var_303442d8 = int(data[0]) * int(data[0]);
            self.cybercom.var_e613305a = int(data[1]) * int(data[1]);
        }
    }
}

// Namespace namespace_7cb6cd95
// Params 0, eflags: 0x1 linked
// Checksum 0x7b230c7b, Offset: 0x2480
// Size: 0x32
function function_1233641() {
    self.cybercom.var_98ef0723 = undefined;
    self.cybercom.var_303442d8 = undefined;
    self.cybercom.var_e613305a = undefined;
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x5 linked
// Checksum 0xf0189ef0, Offset: 0x24c0
// Size: 0x410
function private function_4b91c7e5(player, anchor) {
    self endon(#"death");
    player endon(#"hash_c68b15c8");
    player endon(#"hash_ac145594");
    player endon(#"disconnect");
    player waittill(#"hash_58a3879b");
    wait(0.1);
    var_7c5f9b37 = 0.95;
    var_af9c49a8 = undefined;
    while (true) {
        distcheck = 1;
        var_21793546 = getdvarint("scr_security_breach_lose_contact_distanceSQ", getdvarint("scr_security_breach_lose_contact_distance", 1200) * getdvarint("scr_security_breach_lose_contact_distance", 1200));
        var_60408929 = getdvarint("scr_security_breach_lost_contact_distanceSQ", getdvarint("scr_security_breach_lost_contact_distance", 2400) * getdvarint("scr_security_breach_lost_contact_distance", 2400));
        if (isdefined(player.cybercom.var_98ef0723)) {
            if (isdefined(player.cybercom.var_303442d8)) {
                var_21793546 = player.cybercom.var_303442d8;
                var_60408929 = player.cybercom.var_e613305a;
            }
            if (self istouching(player.cybercom.var_98ef0723)) {
                val = 0;
                distancesq = 0;
                distcheck = 0;
            }
        }
        if (self.archetype === "turret") {
            val = 0;
            distancesq = 0;
            distcheck = 0;
        }
        if (distcheck) {
            distancesq = distancesquared(self.origin, anchor);
            if (distancesq < var_21793546) {
                val = 0;
            } else if (distancesq >= var_60408929) {
                val = var_7c5f9b37;
            } else {
                range = var_60408929 - var_21793546;
                val = math::clamp((distancesq - var_21793546) / range, 0, var_7c5f9b37);
            }
            var_5ae22608 = distancesq >= getdvarfloat("scr_security_breach_lost_contact_warning_distance_percent", 0.6) * var_60408929;
            if (var_5ae22608 !== var_af9c49a8) {
                player setcontrolleruimodelvalue("vehicle.outOfRange", var_5ae22608);
                var_af9c49a8 = var_5ae22608;
            }
        }
        player clientfield::set_to_player("hijack_static_effect", val);
        if (distancesq > var_60408929) {
            self setteam("axis");
            self.takedamage = 1;
            self.owner = undefined;
            self.skipfriendlyfirecheck = 1;
            if (isdefined(player)) {
                self kill(self.origin, player);
            } else {
                self kill();
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x5 linked
// Checksum 0xc1ee1fe1, Offset: 0x28d8
// Size: 0x6c
function private function_3dcfd0d8(time, player) {
    self endon(#"death");
    self.takedamage = 0;
    player util::waittill_any_timeout(time, "return_to_body");
    self.takedamage = !isgodmode(player);
}

// Namespace namespace_7cb6cd95
// Params 1, eflags: 0x5 linked
// Checksum 0x115576b7, Offset: 0x2950
// Size: 0x194
function private function_6adcb22e(vehicle) {
    self endon(#"spawned");
    self util::freeze_player_controls(1);
    self clientfield::set_to_player("hijack_static_ramp_up", 1);
    if (isdefined(vehicle.archetype) && vehicle.archetype == "wasp" && !(isdefined(vehicle.var_66ff806d) && vehicle.var_66ff806d)) {
        self thread function_5d471974(vehicle);
    } else {
        self clientfield::set_to_player("hijack_spectate", 1);
    }
    self cameraactivate(1);
    self waittill(#"hash_e08a6f71");
    self clientfield::set_to_player("hijack_static_ramp_up", 0);
    self cameraactivate(0);
    self clientfield::set_to_player("hijack_spectate", 0);
    self clientfield::set_to_player("hijack_static_effect", 0);
    self util::freeze_player_controls(0);
}

// Namespace namespace_7cb6cd95
// Params 1, eflags: 0x5 linked
// Checksum 0x884dac14, Offset: 0x2af0
// Size: 0x21c
function private function_5d471974(vehicle) {
    forward = anglestoforward(vehicle.angles);
    moveamount = vectorscale(forward, -200);
    moveamount = (moveamount[0], moveamount[1], vehicle.origin[2] + 72);
    cam = spawn("script_model", vehicle.origin + moveamount);
    cam setmodel("tag_origin");
    if (!(isdefined(vehicle.crash_style) && vehicle.crash_style)) {
        cam linkto(vehicle, "tag_origin");
    }
    self startcameratween(1);
    origin = vehicle.origin;
    wait(0.05);
    self camerasetposition(cam);
    if (isdefined(vehicle)) {
        self camerasetlookat(vehicle);
    } else {
        self camerasetlookat(origin + (0, 0, 50));
    }
    self util::waittill_any("transition_in_do_switch", "spawned", "disconnect", "death", "return_to_body");
    cam delete();
}

// Namespace namespace_7cb6cd95
// Params 1, eflags: 0x5 linked
// Checksum 0x6d9b32e1, Offset: 0x2d18
// Size: 0xa8
function private function_1a1b4f00(player) {
    player endon(#"hash_c68b15c8");
    self waittill(#"death");
    player thread function_6adcb22e(self);
    wait(3);
    player notify(#"hash_ac145594");
    player thread function_13f4170a(3);
    player waittill(#"hash_e08a6f71");
    waittillframeend();
    player unlink();
    player notify(#"hash_c68b15c8", 1);
}

// Namespace namespace_7cb6cd95
// Params 1, eflags: 0x5 linked
// Checksum 0xdcc93333, Offset: 0x2dc8
// Size: 0x10c
function private function_5c5ecd44(player) {
    self endon(#"death");
    player endon(#"hash_c68b15c8");
    self util::waittill_any("unlink", "exit_vehicle");
    if (isdefined(level.gameended) && (game["state"] == "postgame" || level.gameended)) {
        return;
    }
    self setteam("axis");
    self.takedamage = 1;
    self.owner = undefined;
    if (isdefined(player)) {
        self kill(self.origin, player, player, getweapon("gadget_remote_hijack"));
        return;
    }
    self kill();
}

// Namespace namespace_7cb6cd95
// Params 1, eflags: 0x5 linked
// Checksum 0x99f3e9a8, Offset: 0x2ee0
// Size: 0x192
function private function_7da5b5d4(player) {
    self thread function_1a1b4f00(player);
    self thread function_5c5ecd44(player);
    var_d2f6fb2e = player.origin;
    original_angles = player.angles;
    player.cybercom.var_3fd69aad = 1;
    self.var_aafc8cd9 = 1;
    reason = player waittill(#"hash_c68b15c8");
    wait(0.05);
    player setorigin(var_d2f6fb2e);
    player setplayerangles(original_angles);
    wait(0.05);
    if (isdefined(self)) {
        self setteam("axis");
        self.takedamage = 1;
        self.owner = undefined;
        if (isdefined(player)) {
            self kill(self.origin, player);
        } else {
            self kill();
        }
    }
    player.cybercom.var_3fd69aad = undefined;
}

// Namespace namespace_7cb6cd95
// Params 0, eflags: 0x0
// Checksum 0x57d06f1d, Offset: 0x3080
// Size: 0x64
function clearusingremote() {
    self enableoffhandweapons();
    if (isdefined(self.lastweapon)) {
        self switchtoweapon(self.lastweapon);
        wait(1);
    }
    self takeweapon(self.remoteweapon);
}

// Namespace namespace_7cb6cd95
// Params 1, eflags: 0x0
// Checksum 0xb9e63f93, Offset: 0x30f0
// Size: 0xa4
function setusingremote(remotename) {
    self.lastweapon = self getcurrentweapon();
    self.remoteweapon = getweapon(remotename);
    self giveweapon(self.remoteweapon);
    self switchtoweapon(self.remoteweapon);
    self disableoffhandweapons();
}

// Namespace namespace_7cb6cd95
// Params 2, eflags: 0x1 linked
// Checksum 0x82c09a7b, Offset: 0x31a0
// Size: 0x66
function function_43b801ea(onoff, entnum) {
    while (true) {
        clone, vehentnum = level waittill(#"clonedentity");
        if (vehentnum == entnum) {
            clone.var_66ff806d = onoff;
            return;
        }
    }
}

// Namespace namespace_7cb6cd95
// Params 0, eflags: 0x0
// Checksum 0xc8d290a7, Offset: 0x3210
// Size: 0x44
function function_f002d0f9() {
    self endon(#"death");
    myentnum = self waittill(#"cloneandremoveentity");
    level thread function_43b801ea(0, myentnum);
}

// Namespace namespace_7cb6cd95
// Params 0, eflags: 0x1 linked
// Checksum 0x635d22c4, Offset: 0x3260
// Size: 0x5c
function function_664c9cd6() {
    self setteam("axis");
    self.takedamage = 1;
    self.owner = undefined;
    self dodamage(self.health, self.origin);
}

