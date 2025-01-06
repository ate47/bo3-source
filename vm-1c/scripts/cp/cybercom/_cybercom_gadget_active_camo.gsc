#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace namespace_eda43fb2;

// Namespace namespace_eda43fb2
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x428
// Size: 0x4
function init() {
    
}

// Namespace namespace_eda43fb2
// Params 0, eflags: 0x0
// Checksum 0x8dce94e8, Offset: 0x438
// Size: 0x17c
function main() {
    namespace_d00ec32::function_36b56038(1, 8, 1);
    level.cybercom.active_camo = spawnstruct();
    level.cybercom.active_camo.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.active_camo.var_bdb47551 = &function_bdb47551;
    level.cybercom.active_camo.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.active_camo.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.active_camo._on = &_on;
    level.cybercom.active_camo._off = &_off;
    level.cybercom.var_1bafc2c2 = getweapon("gadget_active_camo_upgraded");
    callback::on_disconnect(&function_75fd531c);
}

// Namespace namespace_eda43fb2
// Params 2, eflags: 0x0
// Checksum 0x7db35dd1, Offset: 0x5c0
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_eda43fb2
// Params 2, eflags: 0x0
// Checksum 0x63fab902, Offset: 0x5e0
// Size: 0x4c
function function_bdb47551(slot, weapon) {
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_eda43fb2
// Params 2, eflags: 0x0
// Checksum 0x93e8d6d6, Offset: 0x638
// Size: 0x3a
function function_39ea6a1b(slot, weapon) {
    self notify(#"active_camo_off");
    self notify(#"active_camo_taken");
    self notify(#"delete_false_target");
}

// Namespace namespace_eda43fb2
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x680
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_eda43fb2
// Params 0, eflags: 0x0
// Checksum 0x4ad88a8d, Offset: 0x690
// Size: 0x2a
function function_75fd531c() {
    self notify(#"delete_false_target");
    self notify(#"active_camo_off");
    self notify(#"active_camo_taken");
}

// Namespace namespace_eda43fb2
// Params 2, eflags: 0x0
// Checksum 0x1938cdf, Offset: 0x6c8
// Size: 0x21c
function _on(slot, weapon) {
    self endon(#"active_camo_off");
    self endon(#"death");
    self endon(#"disconnect");
    self clientfield::set("camo_shader", 1);
    cybercom::function_adc40f11(weapon, 1);
    self.cybercom.var_4179b836 = isdefined(self.ignoreme) && self.ignoreme ? 1 : 0;
    self.ignoreme = 1;
    self.active_camo = 1;
    self playrumbleonentity("tank_rumble");
    self thread function_b4902c73(slot, weapon, "scene_disable_player_stuff", "active_camo_taken");
    self thread function_e784c8b3();
    self thread cybercom::function_c3c6aff4(slot, weapon, "changed_class", "active_camo_off");
    self thread cybercom::function_c3c6aff4(slot, weapon, "cybercom_disabled", "active_camo_off");
    self thread function_cba091b7(slot, weapon);
    if (isplayer(self)) {
        itemindex = getitemindexfromref("cybercom_camo");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_eda43fb2
// Params 2, eflags: 0x0
// Checksum 0xe1a843cc, Offset: 0x8f0
// Size: 0xfe
function _off(slot, weapon) {
    if (getdvarint("tu1_cybercomActiveCamoIgnoreMeFix", 1)) {
        if (isdefined(self.cybercom.var_4179b836) && self.cybercom.var_4179b836 && self.ignoreme) {
        } else {
            self.ignoreme = 0;
        }
    } else if (isdefined(self.cybercom.var_4179b836)) {
        self.ignoreme = self.cybercom.var_4179b836;
    }
    self.active_camo = undefined;
    /#
        if (isdefined(self.ignoreme) && self.ignoreme) {
            iprintlnbold("<dev string:x28>");
        }
    #/
    self notify(#"delete_false_target");
    self notify(#"active_camo_off");
}

// Namespace namespace_eda43fb2
// Params 2, eflags: 0x0
// Checksum 0x1a5d7ba6, Offset: 0x9f8
// Size: 0x84
function function_cba091b7(slot, weapon) {
    self notify(#"hash_cba091b7");
    self endon(#"hash_cba091b7");
    self endon(#"disconnect");
    self endon(#"active_camo_off");
    self flagsys::wait_till("mobile_armory_in_use");
    self gadgetdeactivate(slot, weapon);
}

// Namespace namespace_eda43fb2
// Params 4, eflags: 0x0
// Checksum 0xc0e39802, Offset: 0xa88
// Size: 0xe4
function function_b4902c73(slot, weapon, var_7ad67496, endnote) {
    self notify(endnote + var_7ad67496 + weapon.name);
    self endon(endnote + var_7ad67496 + weapon.name);
    self endon(endnote);
    self endon(#"disconnect");
    self waittill(var_7ad67496);
    if (self hasweapon(weapon) && isdefined(self.cybercom.var_2e20c9bd) && self.cybercom.var_2e20c9bd == weapon) {
        self gadgetdeactivate(slot, weapon);
    }
}

// Namespace namespace_eda43fb2
// Params 4, eflags: 0x4
// Checksum 0xccc0772e, Offset: 0xb78
// Size: 0xc2
function private _camo_killReActivateOnNotify(slot, note, var_696db07, var_a9769379) {
    if (!isdefined(var_696db07)) {
        var_696db07 = 300;
    }
    if (!isdefined(var_a9769379)) {
        var_a9769379 = 1000;
    }
    self endon(#"active_camo_taken");
    self endon(#"disconnect");
    self notify("_camo_killReActivateOnNotify" + slot + note);
    self endon("_camo_killReActivateOnNotify" + slot + note);
    while (true) {
        self waittill(note, param);
        self notify(#"hash_64558d25");
    }
}

// Namespace namespace_eda43fb2
// Params 0, eflags: 0x4
// Checksum 0x1faa3acf, Offset: 0xc48
// Size: 0x224
function private function_e784c8b3() {
    self notify(#"delete_false_target");
    self endon(#"delete_false_target");
    var_d0c5bbcc = spawn("script_model", self.origin);
    var_d0c5bbcc setmodel("tag_origin");
    var_d0c5bbcc makesentient();
    var_d0c5bbcc.origin += (0, 0, 30);
    var_d0c5bbcc.team = self.team;
    self thread cybercom::function_f569ef38("disconnect", var_d0c5bbcc);
    self thread cybercom::function_f569ef38("active_camo_off", var_d0c5bbcc);
    self thread cybercom::function_f569ef38("delete_false_target", var_d0c5bbcc);
    self thread function_c51ef296(var_d0c5bbcc);
    zmin = self.origin[2];
    while (isdefined(var_d0c5bbcc)) {
        var_d0c5bbcc.origin += (randomintrange(-50, 50), randomintrange(-50, 50), randomintrange(-5, 5));
        if (var_d0c5bbcc.origin[2] < zmin) {
            var_d0c5bbcc.origin = (var_d0c5bbcc.origin[0], var_d0c5bbcc.origin[1], zmin);
        }
        wait 0.5;
    }
}

// Namespace namespace_eda43fb2
// Params 1, eflags: 0x4
// Checksum 0xdef7cfee, Offset: 0xe78
// Size: 0x5c
function private function_c51ef296(fakeent) {
    fakeent endon(#"death");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"weapon_fired", projectile);
        fakeent.origin = self.origin;
    }
}

// Namespace namespace_eda43fb2
// Params 0, eflags: 0x4
// Checksum 0xbc6f286a, Offset: 0xee0
// Size: 0xe0
function private function_d349a475() {
    self notify(#"hash_d349a475");
    self endon(#"hash_d349a475");
    self endon(#"active_camo_taken");
    self endon(#"hash_64558d25");
    while (true) {
        self waittill(#"gadget_forced_off", slot, weapon);
        if (isdefined(weapon) && weapon == level.cybercom.var_1bafc2c2) {
            wait getdvarint("scr_active_camo_melee_escape_duration_SEC", 1);
            if (!self gadgetisactive(slot)) {
                self gadgetactivate(slot, weapon, 0);
            }
        }
    }
}

