#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom_gadget_sensory_overload;
#using scripts/cp/cybercom/_cybercom_gadget_system_overload;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

// Can't decompile export namespace_11fb1f28::function_d25acb0

#namespace namespace_11fb1f28;

// Namespace namespace_11fb1f28
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x440
// Size: 0x4
function init() {
    
}

// Namespace namespace_11fb1f28
// Params 0, eflags: 0x1 linked
// Checksum 0xeedc48a8, Offset: 0x450
// Size: 0x17c
function main() {
    namespace_d00ec32::function_36b56038(1, 1);
    level.cybercom.smokescreen = spawnstruct();
    level.cybercom.smokescreen.var_875da84b = &function_875da84b;
    level.cybercom.smokescreen.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.smokescreen.var_bdb47551 = &function_bdb47551;
    level.cybercom.smokescreen.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.smokescreen.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.smokescreen._on = &_on;
    level.cybercom.smokescreen._off = &_off;
    level.cybercom.smokescreen.var_4135a1c4 = &function_4135a1c4;
}

// Namespace namespace_11fb1f28
// Params 1, eflags: 0x1 linked
// Checksum 0xd230f060, Offset: 0x5d8
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_11fb1f28
// Params 2, eflags: 0x1 linked
// Checksum 0x78b18fc8, Offset: 0x5f0
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_11fb1f28
// Params 2, eflags: 0x1 linked
// Checksum 0x1d5424, Offset: 0x610
// Size: 0x4c
function function_bdb47551(slot, weapon) {
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_11fb1f28
// Params 2, eflags: 0x1 linked
// Checksum 0x19113ca5, Offset: 0x668
// Size: 0x14
function function_39ea6a1b(slot, weapon) {
    
}

// Namespace namespace_11fb1f28
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x688
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_11fb1f28
// Params 2, eflags: 0x1 linked
// Checksum 0xb8ccd566, Offset: 0x698
// Size: 0xe4
function _on(slot, weapon) {
    cybercom::function_adc40f11(weapon, 1);
    level thread function_8810da3c(self, self function_1a9006bd("cybercom_smokescreen") == 2);
    if (isplayer(self)) {
        itemindex = getitemindexfromref("cybercom_smokescreen");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_11fb1f28
// Params 2, eflags: 0x1 linked
// Checksum 0x63e3cfd5, Offset: 0x788
// Size: 0x14
function _off(slot, weapon) {
    
}

// Namespace namespace_11fb1f28
// Params 2, eflags: 0x1 linked
// Checksum 0xafacf266, Offset: 0x7a8
// Size: 0x14
function function_4135a1c4(slot, weapon) {
    
}

// Namespace namespace_11fb1f28
// Params 2, eflags: 0x1 linked
// Checksum 0x172cb9c9, Offset: 0x7c8
// Size: 0xe2
function function_269cc172(var_d7d4ed9f, var_c34fe8d9) {
    x = var_d7d4ed9f[0] * cos(var_c34fe8d9) + var_d7d4ed9f[1] * sin(var_c34fe8d9);
    y = -1 * var_d7d4ed9f[0] * sin(var_c34fe8d9) + var_d7d4ed9f[1] * cos(var_c34fe8d9);
    z = var_d7d4ed9f[2];
    return (x, y, z);
}

// Namespace namespace_11fb1f28
// Params 2, eflags: 0x1 linked
// Checksum 0xbb3a8301, Offset: 0x8b8
// Size: 0x3d4
function function_8810da3c(owner, upgraded) {
    if (!isdefined(upgraded)) {
        upgraded = 0;
    }
    weapon = upgraded ? getweapon("smoke_cybercom_upgraded") : getweapon("smoke_cybercom");
    forward = anglestoforward(owner.angles);
    center = 40 * forward + owner.origin;
    var_8cc2a222 = -116 * forward + center;
    owner thread function_eb018a63(var_8cc2a222, weapon, upgraded);
    playsoundatposition("gdt_cybercore_smokescreen", var_8cc2a222);
    rotated = function_269cc172(forward, 23);
    var_ae0aa92 = rotated * -116 + center;
    rotated = function_269cc172(forward, 46);
    var_e4de3029 = rotated * -116 + center;
    rotated = function_269cc172(forward, 69);
    var_bedbb5c0 = rotated * -116 + center;
    owner thread function_eb018a63(var_ae0aa92, weapon, upgraded);
    util::wait_network_frame();
    owner thread function_eb018a63(var_e4de3029, weapon, upgraded);
    util::wait_network_frame();
    owner thread function_eb018a63(var_bedbb5c0, weapon, upgraded);
    util::wait_network_frame();
    rotated = function_269cc172(forward, -23);
    var_354533f = rotated * -116 + center;
    rotated = function_269cc172(forward, -46);
    var_914ce404 = rotated * -116 + center;
    rotated = function_269cc172(forward, -69);
    var_b74f5e6d = rotated * -116 + center;
    owner thread function_eb018a63(var_354533f, weapon, upgraded);
    util::wait_network_frame();
    owner thread function_eb018a63(var_914ce404, weapon, upgraded);
    util::wait_network_frame();
    owner thread function_eb018a63(var_b74f5e6d, weapon, upgraded);
    util::wait_network_frame();
    owner thread function_e52895b(center);
}

// Namespace namespace_11fb1f28
// Params 3, eflags: 0x5 linked
// Checksum 0xa466cabf, Offset: 0xc98
// Size: 0x290
function function_eb018a63(origin, weapon, var_50ae8517) {
    timestep = 2;
    cloud = function_2fb41213(origin, getdvarint("scr_smokescreen_duration", 7), weapon);
    cloud thread function_7125df2e(getdvarint("scr_smokescreen_duration", 7));
    cloud thread function_2346317b(getdvarint("scr_smokescreen_duration", 7), 1, 2);
    cloud setteam(self.team);
    if (isplayer(self)) {
        cloud setowner(self);
    }
    cloud.durationleft = getdvarint("scr_smokescreen_duration", 7);
    if (var_50ae8517) {
        cloud thread function_76df0d04(self, timestep);
    }
    if (getdvarint("scr_smokescreen_debug", 0)) {
        cloud thread function_2f3c403b(getdvarint("scr_smokescreen_duration", 7));
        level thread namespace_afd2f70b::function_a0e51d80(cloud.origin, getdvarint("scr_smokescreen_duration", 7), 16, (1, 0, 0));
    }
    cloud endon(#"death");
    while (true) {
        fxblocksight(cloud, cloud.currentradius);
        wait(timestep);
        cloud.durationleft -= timestep;
        if (cloud.durationleft < 0) {
            cloud.durationleft = 0;
        }
    }
}

// Namespace namespace_11fb1f28
// Params 2, eflags: 0x5 linked
// Checksum 0x6c6a6796, Offset: 0xf30
// Size: 0xb6
function function_76df0d04(player, timestep) {
    self endon(#"death");
    while (true) {
        if (isdefined(self.trigger)) {
            self.trigger delete();
        }
        self.trigger = spawn("trigger_radius", self.origin, 25, self.currentradius, self.currentradius);
        self.trigger thread function_eafddd94(player, self);
        wait(timestep);
    }
}

// Namespace namespace_11fb1f28
// Params 2, eflags: 0x5 linked
// Checksum 0x6751a475, Offset: 0xff0
// Size: 0x31a
function function_eafddd94(player, cloud) {
    self endon(#"death");
    while (true) {
        guy = self waittill(#"trigger");
        if (!isdefined(cloud)) {
            return;
        }
        if (!isdefined(guy)) {
            continue;
        }
        if (!isalive(guy)) {
            continue;
        }
        if (isdefined(guy.is_disabled) && guy.is_disabled) {
            return 0;
        }
        if (!(isdefined(guy.takedamage) && guy.takedamage)) {
            return 0;
        }
        if (isdefined(guy._ai_melee_opponent)) {
            return 0;
        }
        if (isdefined(guy.is_disabled) && guy.is_disabled) {
            continue;
        }
        if (guy cybercom::function_8fd8f5b1("cybercom_smokescreen")) {
            continue;
        }
        if (isdefined(guy.magic_bullet_shield) && guy.magic_bullet_shield) {
            continue;
        }
        if (isactor(guy) && guy isinscriptedstate()) {
            continue;
        }
        if (isdefined(guy.allowdeath) && !guy.allowdeath) {
            continue;
        }
        if (isvehicle(guy)) {
            if (!isdefined(guy.var_5895314d)) {
                player thread challenges::function_96ed590f("cybercom_uses_martial");
                guy.var_5895314d = 1;
            }
            guy thread namespace_528b4613::system_overload(player, cloud.durationleft * 1000);
        }
        if (isdefined(guy.archetype)) {
            switch (guy.archetype) {
            case 14:
                player thread challenges::function_96ed590f("cybercom_uses_martial");
                guy thread namespace_528b4613::system_overload(player, cloud.durationleft * 1000);
                break;
            case 12:
            case 13:
                player thread challenges::function_96ed590f("cybercom_uses_martial");
                guy thread namespace_64276cf9::sensory_overload(player, "cybercom_smokescreen");
                break;
            }
        }
    }
}

// Namespace namespace_11fb1f28
// Params 3, eflags: 0x4
// Checksum 0xc0551218, Offset: 0x1318
// Size: 0x90
function function_fc04e511(dir, var_99f49fe2, seconds) {
    self endon(#"death");
    ticks = seconds * 20;
    var_ccde618b = var_99f49fe2 / ticks * vectornormalize(dir);
    while (ticks) {
        ticks--;
        self.origin += var_ccde618b;
    }
}

// Namespace namespace_11fb1f28
// Params 3, eflags: 0x5 linked
// Checksum 0xd20be4a2, Offset: 0x13b0
// Size: 0x88
function function_2fb41213(origin, duration, weapon) {
    smokescreen = spawntimedfx(weapon, origin, (0, 0, 1), duration);
    smokescreen.currentradius = getdvarint("scr_smokescreen_radius", 60);
    smokescreen.currentscale = 1;
    return smokescreen;
}

// Namespace namespace_11fb1f28
// Params 1, eflags: 0x5 linked
// Checksum 0x251ec98a, Offset: 0x1440
// Size: 0x5c
function function_7125df2e(time) {
    self endon(#"death");
    wait(time);
    if (isdefined(self.trigger)) {
        self.trigger delete();
    }
    self delete();
}

// Namespace namespace_11fb1f28
// Params 3, eflags: 0x5 linked
// Checksum 0x9c661a40, Offset: 0x14a8
// Size: 0x176
function function_2346317b(time, startscale, maxscale) {
    self endon(#"death");
    if (maxscale < 1) {
        maxscale = 1;
    }
    self.currentscale = startscale;
    var_f6e1ecda = time * 20;
    up = maxscale > startscale;
    if (up) {
        var_c2591895 = maxscale - startscale;
        var_6411d75f = var_c2591895 / var_f6e1ecda;
    } else {
        var_c2591895 = startscale - maxscale;
        var_6411d75f = var_c2591895 / var_f6e1ecda * -1;
    }
    while (var_f6e1ecda) {
        self.currentscale += var_6411d75f;
        if (self.currentscale > maxscale) {
            self.currentscale = maxscale;
        }
        if (self.currentscale < 1) {
            self.currentscale = 1;
        }
        self.currentradius = getdvarint("scr_smokescreen_radius", 60) * self.currentscale;
        wait(0.05);
        var_f6e1ecda--;
    }
}

// Namespace namespace_11fb1f28
// Params 1, eflags: 0x5 linked
// Checksum 0x32b6a896, Offset: 0x1628
// Size: 0x70
function function_2f3c403b(time) {
    self endon(#"death");
    var_f6e1ecda = time * 20;
    while (var_f6e1ecda) {
        var_f6e1ecda--;
        level thread cybercom::debug_sphere(self.origin, self.currentradius);
        wait(0.05);
    }
}

// Namespace namespace_11fb1f28
// Params 1, eflags: 0x5 linked
// Checksum 0xa78c071e, Offset: 0x17a8
// Size: 0x8e
function function_e52895b(origin) {
    self endon(#"death");
    var_9f9fc36f = 1;
    for (timeleft = getdvarint("scr_smokescreen_duration", 7); timeleft > 0; timeleft -= var_9f9fc36f) {
        resetvisibilitycachewithinradius(origin, 1000);
        wait(var_9f9fc36f);
    }
}

