#using scripts/codescripts/struct;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_gadget_concussive_wave;
#using scripts/cp/cybercom/_cybercom_gadget_electrostatic_strike;
#using scripts/cp/cybercom/_cybercom_gadget_exosuitbreakdown;
#using scripts/cp/cybercom/_cybercom_gadget_firefly;
#using scripts/cp/cybercom/_cybercom_gadget_forced_malfunction;
#using scripts/cp/cybercom/_cybercom_gadget_iff_override;
#using scripts/cp/cybercom/_cybercom_gadget_immolation;
#using scripts/cp/cybercom/_cybercom_gadget_mrpukey;
#using scripts/cp/cybercom/_cybercom_gadget_security_breach;
#using scripts/cp/cybercom/_cybercom_gadget_sensory_overload;
#using scripts/cp/cybercom/_cybercom_gadget_servo_shortout;
#using scripts/cp/cybercom/_cybercom_gadget_smokescreen;
#using scripts/cp/cybercom/_cybercom_gadget_surge;
#using scripts/cp/cybercom/_cybercom_gadget_system_overload;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_tactical_rig_emergencyreserve;
#using scripts/cp/cybercom/_cybercom_tactical_rig_proximitydeterrent;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom;

// Namespace cybercom
// Params 0, eflags: 0x2
// Checksum 0x87d74700, Offset: 0x978
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("cybercom", &init, &main, undefined);
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0x614a0b0d, Offset: 0x9c0
// Size: 0x3c4
function init() {
    clientfield::register("world", "cybercom_disabled", 1, 1, "int");
    clientfield::register("toplayer", "cybercom_disabled", 1, 1, "int");
    clientfield::register("vehicle", "cybercom_setiffname", 1, 3, "int");
    clientfield::register("actor", "cybercom_setiffname", 1, 3, "int");
    clientfield::register("actor", "cybercom_immolate", 1, 2, "int");
    clientfield::register("vehicle", "cybercom_immolate", 1, 1, "int");
    clientfield::register("actor", "cybercom_sysoverload", 1, 2, "int");
    clientfield::register("vehicle", "cybercom_sysoverload", 1, 1, "int");
    clientfield::register("actor", "cybercom_surge", 1, 2, "int");
    clientfield::register("vehicle", "cybercom_surge", 1, 2, "int");
    clientfield::register("scriptmover", "cybercom_surge", 1, 1, "int");
    clientfield::register("actor", "cybercom_shortout", 1, 2, "int");
    clientfield::register("vehicle", "cybercom_shortout", 1, 2, "int");
    clientfield::register("allplayers", "cyber_arm_pulse", 1, 2, "counter");
    clientfield::register("actor", "cyber_arm_pulse", 1, 2, "counter");
    clientfield::register("scriptmover", "cyber_arm_pulse", 1, 2, "counter");
    clientfield::register("toplayer", "hacking_progress", 1, 12, "int");
    clientfield::register("clientuimodel", "playerAbilities.inRange", 1, 1, "int");
    clientfield::register("toplayer", "resetAbilityWheel", 1, 1, "int");
    namespace_d00ec32::init();
    cybercom_tacrig::init();
    function_beff8cf9();
}

// Namespace cybercom
// Params 3, eflags: 0x0
// Checksum 0x1fb06128, Offset: 0xd90
// Size: 0x78
function function_4ee56464(var_23810282, var_442fb6cd, var_6ee14d17) {
    returnstruct = spawnstruct();
    returnstruct.var_974cd16f = var_23810282;
    returnstruct.var_e909f6f0 = var_442fb6cd;
    returnstruct.var_3d1b9c0c = var_6ee14d17;
    return returnstruct;
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0xa3844a23, Offset: 0xe10
// Size: 0x4e
function function_beff8cf9() {
    level.var_e4e6dd84 = [];
    level.var_e4e6dd84["default"] = function_4ee56464(0.5, 0.5, 0.5);
}

// Namespace cybercom
// Params 2, eflags: 0x0
// Checksum 0x85bc197, Offset: 0xe68
// Size: 0x13c
function function_7f3ccb7(slot, weapon) {
    self gadgetsetactivatetime(slot, gettime());
    if (!isdefined(self.spawntime) || gettime() - self.spawntime > -56) {
        if (getdvarint("ai_awarenessEnabled") && isdefined(weapon) && issubstr(weapon.name, "hijack")) {
            return;
        }
        self generatescriptevent();
    }
    if (isplayer(self)) {
        if (!isdefined(self.var_1c0132c[weapon.name])) {
            self.var_1c0132c[weapon.name] = 0;
        }
        self.var_1c0132c[weapon.name]++;
        self matchrecordlogcybercoreevent(weapon, self.origin, gettime(), 0);
    }
}

// Namespace cybercom
// Params 2, eflags: 0x0
// Checksum 0x9290920f, Offset: 0xfb0
// Size: 0x14
function function_b8e0020b(slot, weapon) {
    
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0xd6367e7b, Offset: 0xfd0
// Size: 0x11c
function initialize() {
    level.cybercom = spawnstruct();
    level.cybercom.abilities = [];
    level.cybercom.var_f9269224 = 0;
    level.cybercom.var_12f85dec = 0;
    level.cybercom._ability_turn_on = &function_7f3ccb7;
    level.cybercom._ability_turn_off = &function_b8e0020b;
    level.vehicle_initializer_cb = &function_80fe1bad;
    level.vehicle_destructer_cb = &function_79bafe1d;
    level.var_3be61296 = &function_fabadf47;
    level.cybercom.overrideactordamage = &function_25889576;
    level.cybercom.overridevehicledamage = &function_17136681;
}

// Namespace cybercom
// Params 15, eflags: 0x0
// Checksum 0xfa02853d, Offset: 0x10f8
// Size: 0x32a
function function_25889576(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, surfacenormal) {
    if (issubstr(smeansofdeath, "MELEE")) {
        self notify(#"notify_melee_damage");
        if (weapon == getweapon("gadget_es_strike") || weapon == getweapon("gadget_es_strike_upgraded")) {
            idamage = 0;
            if (!isdefined(shitloc) || shitloc == "none") {
                return idamage;
            }
            level notify(#"es_strike", self, eattacker, idamage, weapon, vpoint);
            var_2d399bc8 = 1;
        }
        if (weapon == getweapon("gadget_ravage_core_upgraded") && isdefined(self.archetype) && (weapon == getweapon("gadget_ravage_core") || self.archetype == "robot")) {
            self ai::set_behavior_attribute("can_gib", 0);
            level notify(#"ravage_core", self, eattacker, idamage, weapon, vpoint);
            var_2d399bc8 = 1;
        }
        if (weapon == getweapon("gadget_rapid_strike") || weapon == getweapon("gadget_rapid_strike_upgraded")) {
            level notify(#"rapid_strike", self, eattacker, idamage, weapon, vpoint);
            var_2d399bc8 = 1;
        }
    } else if (smeansofdeath == "MOD_GRENADE_SPLASH") {
        if (weapon.name == "ravage_core_emp_grenade") {
            if (self.archetype == "human" || isdefined(self.archetype) && self.archetype == "zombie") {
                idamage = 60;
            }
        }
    }
    if (isdefined(self.tokubetsukogekita) && self.tokubetsukogekita && isdefined(eattacker) && !isplayer(eattacker)) {
        idamage = 1;
    }
    if (idamage > 30) {
        self notify(#"damage_pain");
    }
    return idamage;
}

// Namespace cybercom
// Params 15, eflags: 0x0
// Checksum 0x5cdb7d2b, Offset: 0x1430
// Size: 0x114
function function_17136681(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (smeansofdeath == "MOD_MELEE") {
        self notify(#"notify_melee_damage");
        if (weapon == getweapon("gadget_es_strike") || weapon == getweapon("gadget_es_strike_upgraded")) {
            idamage = 0;
            level notify(#"es_strike", self, eattacker, idamage, weapon, vpoint);
            var_2d399bc8 = 1;
        }
    }
    return idamage;
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0x713def83, Offset: 0x1550
// Size: 0xb4
function main() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    if (!isdefined(level.cybercom)) {
        initialize();
    }
    namespace_d00ec32::main();
    cybercom_tacrig::main();
    level thread function_da99f3e1();
    level thread function_285f5fb1();
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0xcd5b6723, Offset: 0x1610
// Size: 0xac
function on_player_connect() {
    self.cybercom = spawnstruct();
    self.cybercom.flags = spawnstruct();
    self.cybercom.var_b766574c = 0;
    self.var_1c0132c = [];
    self function_facd1caa();
    self.pers["cybercom_flags"] = self.cybercom.flags;
    self thread on_menu_response();
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0x21b6106a, Offset: 0x16c8
// Size: 0x1ee
function on_player_spawned() {
    self.cybercom.var_d1460543 = [];
    self.cybercom.var_4eb8cd67 = [];
    self function_ddcda2fd(self.pers["cybercom_flags"]);
    self flagsys::set("cybercom_init");
    self.cybercom.var_161c9be8 = 0;
    self.cybercom.var_8967863e = 1;
    self.cybercom.var_18714ef0 = self gadgetpowerget(0);
    self.cybercom.var_3e73c959 = self gadgetpowerget(1);
    self.cybercom.var_647643c2 = self gadgetpowerget(2);
    var_8e1e095b = self function_2eef1193();
    switch (var_8e1e095b) {
    case 0:
        self namespace_d00ec32::function_c381ce2(namespace_d00ec32::function_85c33215("cybercom_ravagecore"));
        break;
    case 1:
        self namespace_d00ec32::function_c381ce2(namespace_d00ec32::function_85c33215("cybercom_rapidstrike"));
        break;
    case 2:
        self namespace_d00ec32::function_c381ce2(namespace_d00ec32::function_85c33215("cybercom_es_strike"));
        break;
    }
}

// Namespace cybercom
// Params 1, eflags: 0x4
// Checksum 0x7775f832, Offset: 0x18c0
// Size: 0x20
function private function_b1497851(menu) {
    self.cybercom.var_5e76d31b = 1;
}

// Namespace cybercom
// Params 2, eflags: 0x4
// Checksum 0x27de017b, Offset: 0x18e8
// Size: 0x28
function private function_4d11675a(menu, response) {
    self.cybercom.var_5e76d31b = 0;
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0xcf6e9f6a, Offset: 0x1918
// Size: 0x2a0
function on_menu_response() {
    self endon(#"disconnect");
    self notify(#"hash_ccef31c0");
    self endon(#"hash_ccef31c0");
    for (;;) {
        self waittill(#"menuresponse", menu, response);
        if (isdefined(self.cybercom.menu) && menu == self.cybercom.menu) {
            if (isdefined(self.cybercom.var_301030f7) && self.cybercom.var_301030f7) {
                continue;
            }
            if (isdefined(self.cybercom.var_dd2f3b84) && self.cybercom.var_dd2f3b84) {
                continue;
            }
            var_5dc22ce3 = strtok(response, ",");
            if (response == "opened") {
                self function_b1497851(menu);
                continue;
            }
            if (var_5dc22ce3.size > 1) {
                self.var_768ee804 = int(var_5dc22ce3[1]);
                ability = self namespace_d00ec32::function_eb512967(var_5dc22ce3[0]);
                self clientfield::set_to_player("resetAbilityWheel", 0);
                self notify(#"hash_9a680733");
                if (isdefined(ability)) {
                    switch (ability.type) {
                    case 0:
                        self namespace_d00ec32::function_c381ce2(namespace_d00ec32::function_85c33215("cybercom_ravagecore"));
                        break;
                    case 1:
                        self namespace_d00ec32::function_c381ce2(namespace_d00ec32::function_85c33215("cybercom_rapidstrike"));
                        break;
                    case 2:
                        self namespace_d00ec32::function_c381ce2(namespace_d00ec32::function_85c33215("cybercom_es_strike"));
                        break;
                    }
                }
                self function_4d11675a(menu, response);
            }
        }
    }
}

// Namespace cybercom
// Params 1, eflags: 0x0
// Checksum 0xe39f5d58, Offset: 0x1bc0
// Size: 0x200
function function_6c141a2d(var_1e41d598) {
    assert(isplayer(self));
    self.cybercom.var_18714ef0 = self gadgetpowerget(0);
    self.cybercom.var_3e73c959 = self gadgetpowerget(1);
    self.cybercom.var_647643c2 = self gadgetpowerget(1);
    self.cybercom.var_384c5e6e = var_1e41d598;
    self notify(#"cybercom_disabled");
    if (isdefined(self.cybercom.var_90eb6ca7) && self hasweapon(self.cybercom.var_90eb6ca7)) {
        self.cybercom.var_7116dac7 = self.cybercom.var_90eb6ca7;
        self takeweapon(self.cybercom.var_90eb6ca7);
        self.cybercom.var_90eb6ca7 = undefined;
    }
    if (isdefined(self.cybercom.var_2e20c9bd)) {
        self takeweapon(self.cybercom.var_2e20c9bd);
        self notify(#"weapon_taken", self.cybercom.var_2e20c9bd);
        self.cybercom.var_2e20c9bd = undefined;
    }
    self clientfield::set_to_player("cybercom_disabled", 1);
    self.cybercom.var_8967863e = 0;
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0x18556843, Offset: 0x1dc8
// Size: 0x228
function function_e60e89fe() {
    assert(isplayer(self));
    self clientfield::set_to_player("cybercom_disabled", 0);
    if (isdefined(self.cybercom.var_b6fd26ae)) {
        self namespace_d00ec32::function_eb512967(self.cybercom.var_b6fd26ae.name);
    }
    if (isdefined(self.cybercom.var_7116dac7)) {
        self giveweapon(self.cybercom.var_7116dac7);
        self.cybercom.var_90eb6ca7 = self.cybercom.var_7116dac7;
        self.cybercom.var_7116dac7 = undefined;
    }
    if (isdefined(self.cybercom.var_384c5e6e) && self.cybercom.var_384c5e6e) {
        if (isdefined(self.cybercom.var_18714ef0)) {
            self gadgetpowerset(0, self.cybercom.var_18714ef0);
        }
        if (isdefined(self.cybercom.var_3e73c959)) {
            self gadgetpowerset(1, self.cybercom.var_3e73c959);
        }
        if (isdefined(self.cybercom.var_647643c2)) {
            self gadgetpowerset(2, self.cybercom.var_647643c2);
        }
        self.cybercom.var_18714ef0 = undefined;
        self.cybercom.var_3e73c959 = undefined;
        self.cybercom.var_647643c2 = undefined;
        self.cybercom.var_384c5e6e = undefined;
    }
    self.cybercom.var_8967863e = 1;
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0x6c132135, Offset: 0x1ff8
// Size: 0x34
function function_285f5fb1() {
    level thread function_8ccda8bf();
    level thread function_d2409753();
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0x8d41c7d3, Offset: 0x2038
// Size: 0x12e
function function_8ccda8bf() {
    level notify(#"hash_8ccda8bf");
    level endon(#"hash_8ccda8bf");
    while (true) {
        level waittill(#"enable_cybercom", player);
        if (isdefined(player)) {
            player function_e60e89fe();
            continue;
        }
        level clientfield::set("cybercom_disabled", 0);
        setdvar("cybercom_enabled", 1);
        foreach (player in getplayers()) {
            player function_e60e89fe();
        }
    }
}

// Namespace cybercom
// Params 0, eflags: 0x0
// Checksum 0x5b6bf20f, Offset: 0x2170
// Size: 0x13e
function function_d2409753() {
    level notify(#"hash_d2409753");
    level endon(#"hash_d2409753");
    while (true) {
        level waittill(#"disable_cybercom", player, var_1e41d598);
        if (isdefined(player)) {
            player function_6c141a2d(var_1e41d598);
            continue;
        }
        level clientfield::set("cybercom_disabled", 1);
        setdvar("cybercom_enabled", 0);
        foreach (player in getplayers()) {
            player function_6c141a2d();
        }
    }
}

// Namespace cybercom
// Params 7, eflags: 0x0
// Checksum 0xecdcd778, Offset: 0x22b8
// Size: 0xcc
function function_2b5f1af7(player, eattacker, einflictor, idamage, weapon, shitloc, var_785f4b6e) {
    if (player function_76f34311("cybercom_proximitydeterrent") != 0) {
        if (isdefined(eattacker) && eattacker.classname != "trigger_hurt" && eattacker.classname != "worldspawn") {
            idamage = player namespace_d1c4e441::function_327bda1e(idamage, var_785f4b6e);
        }
    }
    return idamage;
}

// Namespace cybercom
// Params 4, eflags: 0x0
// Checksum 0x6fd4faf, Offset: 0x2390
// Size: 0x2e4
function function_d240e350(var_7872e02, target, var_9bc2efcb, upgraded) {
    if (!isdefined(var_9bc2efcb)) {
        var_9bc2efcb = 1;
    }
    if (!isdefined(upgraded)) {
        upgraded = 0;
    }
    self endon(#"death");
    while (var_9bc2efcb && self isplayinganimscripted()) {
        wait 0.1;
    }
    switch (var_7872e02) {
    case "cybercom_iffoverride":
        namespace_ea01175::function_c26a7c6(target, var_9bc2efcb);
        break;
    case "cybercom_systemoverload":
        namespace_528b4613::function_5839c4ac(target, var_9bc2efcb);
        break;
    case "cybercom_servoshortout":
        namespace_4bc37cb1::function_b1101fa6(target, var_9bc2efcb);
        break;
    case "cybercom_exosuitbreakdown":
        namespace_491e7803::function_2e537afb(target, var_9bc2efcb);
        break;
    case "cybercom_surge":
        namespace_63d98895::function_9eb4d79d(target, var_9bc2efcb, upgraded);
        break;
    case "cybercom_sensoryoverload":
        namespace_64276cf9::function_58f5574a(target, var_9bc2efcb);
        break;
    case "cybercom_forcedmalfunction":
        namespace_9c3956fd::function_638ad739(target, var_9bc2efcb);
        break;
    case "cybercom_fireflyswarm":
        namespace_3ed98204::function_2cba8648(target, var_9bc2efcb, upgraded);
        break;
    case "cybercom_immolation":
        namespace_a56eec64::function_9eebfb7(target, var_9bc2efcb, upgraded);
        break;
    case "cybercom_mrpukey":
        namespace_e44205a2::function_da7ef8ba(target, var_9bc2efcb, upgraded);
        break;
    case "cybercom_concussive":
        namespace_687c8387::function_73688d2e(target, var_9bc2efcb);
        break;
    case "cybercom_smokescreen":
        namespace_11fb1f28::function_d25acb0(var_9bc2efcb, upgraded);
        break;
    case "cybercom_es_strike":
        namespace_690a49a::function_aae59b93(upgraded);
        break;
    default:
        assert(0, "<dev string:x28>");
        break;
    }
    self playsound("gdt_cybercore_activate_ai");
}

