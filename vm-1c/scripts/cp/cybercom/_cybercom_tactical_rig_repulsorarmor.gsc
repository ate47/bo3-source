#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;
#using scripts/shared/math_shared;

#namespace namespace_a7b77773;

// Namespace namespace_a7b77773
// Params 0, eflags: 0x1 linked
// namespace_a7b77773<file_0>::function_c35e6aab
// Checksum 0x99ec1590, Offset: 0x3c8
// Size: 0x4
function init() {
    
}

// Namespace namespace_a7b77773
// Params 0, eflags: 0x1 linked
// namespace_a7b77773<file_0>::function_d290ebfa
// Checksum 0x1053978, Offset: 0x3d8
// Size: 0xec
function main() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    level._effect["repulsorarmor_fx"] = "player/fx_plyr_ability_repulsor_armor";
    level._effect["repulsorarmorUpgraded_fx"] = "player/fx_plyr_ability_repulsor_armor";
    level._effect["repulsorarmor_contact"] = "electric/fx_elec_sparks_burst_lg_os";
    cybercom_tacrig::function_8cb15f87("cybercom_repulsorarmor", 1);
    cybercom_tacrig::function_8b4ef058("cybercom_repulsorarmor", &function_3988f084, &function_59ae49d2);
}

// Namespace namespace_a7b77773
// Params 0, eflags: 0x1 linked
// namespace_a7b77773<file_0>::function_fb4f96b5
// Checksum 0x99ec1590, Offset: 0x4d0
// Size: 0x4
function on_player_connect() {
    
}

// Namespace namespace_a7b77773
// Params 0, eflags: 0x1 linked
// namespace_a7b77773<file_0>::function_aebcf025
// Checksum 0x99ec1590, Offset: 0x4e0
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_a7b77773
// Params 1, eflags: 0x1 linked
// namespace_a7b77773<file_0>::function_3988f084
// Checksum 0x6bb68add, Offset: 0x4f0
// Size: 0x18c
function function_3988f084(type) {
    if (!isdefined(self.cybercom.var_c281e3c)) {
        self.cybercom.var_c281e3c = [];
        self.cybercom.var_c281e3c[0] = spawnstruct();
        self.cybercom.var_c281e3c[1] = spawnstruct();
        self.cybercom.var_c281e3c[2] = spawnstruct();
        self.cybercom.var_c281e3c[3] = spawnstruct();
        self.cybercom.var_c281e3c[0].time = 0;
        self.cybercom.var_c281e3c[1].time = 0;
        self.cybercom.var_c281e3c[2].time = 0;
        self.cybercom.var_c281e3c[3].time = 0;
    }
    self thread function_170e07a2();
    self thread function_13a66a32(type);
}

// Namespace namespace_a7b77773
// Params 1, eflags: 0x1 linked
// namespace_a7b77773<file_0>::function_59ae49d2
// Checksum 0xaeb2cf85, Offset: 0x688
// Size: 0x5a
function function_59ae49d2(type) {
    if (isdefined(self.var_3ab5b78c)) {
        missile_deleteattractor(self.var_3ab5b78c);
        self.var_3ab5b78c = undefined;
    }
    self notify(#"hash_59ae49d2");
    self.cybercom.var_c281e3c = undefined;
}

// Namespace namespace_a7b77773
// Params 1, eflags: 0x5 linked
// namespace_a7b77773<file_0>::function_13a66a32
// Checksum 0xd565a0e, Offset: 0x6f0
// Size: 0x208
function private function_13a66a32(weapon) {
    self notify(#"hash_9fd8f9c4");
    self endon(#"hash_9fd8f9c4");
    self endon(#"hash_59ae49d2");
    self endon(#"death");
    self endon(#"disconnect");
    isupgraded = self function_76f34311(weapon) == 2;
    fx = isupgraded ? level._effect["repulsorarmorUpgraded_fx"] : level._effect["repulsorarmor_fx"];
    if (!isdefined(self.var_3ab5b78c)) {
        self.var_3ab5b78c = missile_createrepulsorent(self, 4000, getdvarint("scr_repulsorarmor_dist", -56), isupgraded);
    }
    cooldown = 0.5;
    for (var_6d621232 = gettime(); true; var_6d621232 = gettime()) {
        missile = self waittill(#"projectile_applyattractor");
        if (gettime() > var_6d621232 + cooldown * 1000) {
            if (isdefined(self.usingvehicle) && (!isdefined(self.usingvehicle) || self.usingvehicle != 1)) {
                playfxontag(fx, self, "tag_origin");
                self playsound("gdt_cybercore_rig_repulse_jawawawa");
                self thread function_934364a2(missile, self.origin + (0, 0, 72));
            }
        }
    }
}

// Namespace namespace_a7b77773
// Params 0, eflags: 0x5 linked
// namespace_a7b77773<file_0>::function_170e07a2
// Checksum 0x8bfe5da9, Offset: 0x900
// Size: 0x280
function private function_170e07a2() {
    self endon(#"hash_59ae49d2");
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        curtime = gettime();
        var_f9459f98 = undefined;
        var_2f0e78d0 = 0;
        for (zone = 0; zone < 4; zone++) {
            if (self.cybercom.var_c281e3c[zone].time > curtime) {
                threat = self.cybercom.var_c281e3c[zone].threat;
                if (isdefined(threat)) {
                    self.cybercom.var_c281e3c[zone].yaw = self cybercom::getyawtospot(threat.origin);
                }
                if (self.cybercom.var_c281e3c[zone].time > var_2f0e78d0) {
                    var_2f0e78d0 = self.cybercom.var_c281e3c[zone].time;
                    var_f9459f98 = zone;
                }
                continue;
            }
            if (self.cybercom.var_c281e3c[zone].time != 0) {
                self.cybercom.var_c281e3c[zone].time = 0;
                self.cybercom.var_c281e3c[zone].threat = undefined;
                self.cybercom.var_c281e3c[zone].yaw = undefined;
            }
        }
        if (isdefined(var_f9459f98)) {
            self clientfield::set_player_uimodel("playerAbilities.repulsorIndicatorIntensity", 1);
            self clientfield::set_player_uimodel("playerAbilities.repulsorIndicatorDirection", var_f9459f98);
        } else {
            self clientfield::set_player_uimodel("playerAbilities.repulsorIndicatorIntensity", 0);
        }
        wait(0.05);
    }
}

// Namespace namespace_a7b77773
// Params 1, eflags: 0x1 linked
// namespace_a7b77773<file_0>::function_1542f1f0
// Checksum 0x6f9cf3be, Offset: 0xb88
// Size: 0x19c
function function_1542f1f0(threat) {
    threat = isdefined(threat.owner) ? threat.owner : threat;
    yaw = self cybercom::getyawtospot(threat.origin);
    if (yaw > -45 && yaw <= 45) {
        zone = 0;
    } else if (yaw > 45 && yaw <= -121) {
        zone = 3;
    } else if (yaw >= -180 && (yaw > -121 && yaw <= -76 || yaw < -135)) {
        zone = 2;
    } else {
        zone = 1;
    }
    self.cybercom.var_c281e3c[zone].time = gettime() + getdvarint("scr_repulsorarmor_indicator_durationMSEC", 1500);
    self.cybercom.var_c281e3c[zone].threat = threat;
    self.cybercom.var_c281e3c[zone].yaw = yaw;
}

// Namespace namespace_a7b77773
// Params 2, eflags: 0x5 linked
// namespace_a7b77773<file_0>::function_934364a2
// Checksum 0x7c2e6eff, Offset: 0xd30
// Size: 0x84
function private function_934364a2(grenade, var_d355aea1) {
    if (isdefined(grenade)) {
        self thread function_1542f1f0(grenade);
        grenade playsound("gdt_cybercore_rig_repulse_jawawawa_missile");
        playfx(level._effect["repulsorarmor_contact"], grenade.origin);
    }
}

