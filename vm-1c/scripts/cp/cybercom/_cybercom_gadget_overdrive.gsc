#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/visionset_mgr_shared;
#using scripts/cp/_util;
#using scripts/shared/lui_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_f388b961;

// Namespace namespace_f388b961
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x3a8
// Size: 0x4
function init() {
    
}

// Namespace namespace_f388b961
// Params 0, eflags: 0x1 linked
// Checksum 0x51469a0d, Offset: 0x3b8
// Size: 0xdc
function main() {
    namespace_d00ec32::function_36b56038(1, 16);
    level.cybercom.overdrive = spawnstruct();
    level.cybercom.overdrive.var_bdb47551 = &function_bdb47551;
    level.cybercom.overdrive.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.overdrive._on = &_on;
    level.cybercom.overdrive._off = &_off;
}

// Namespace namespace_f388b961
// Params 2, eflags: 0x0
// Checksum 0xaf34d774, Offset: 0x4a0
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_f388b961
// Params 2, eflags: 0x1 linked
// Checksum 0x9c9d36d4, Offset: 0x4c0
// Size: 0x4c
function function_bdb47551(slot, weapon) {
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_f388b961
// Params 2, eflags: 0x1 linked
// Checksum 0x1cfd5d45, Offset: 0x518
// Size: 0x2c
function function_39ea6a1b(slot, weapon) {
    _off(slot, weapon);
}

// Namespace namespace_f388b961
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x550
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_f388b961
// Params 0, eflags: 0x0
// Checksum 0x1477c675, Offset: 0x560
// Size: 0x12
function function_75fd531c() {
    self notify(#"hash_3ca9ab77");
}

// Namespace namespace_f388b961
// Params 2, eflags: 0x1 linked
// Checksum 0x707f6a48, Offset: 0x580
// Size: 0x264
function _on(slot, weapon) {
    self endon(#"hash_3ca9ab77");
    self endon(#"death");
    self endon(#"disconnect");
    if (flagsys::get("gadget_overdrive_on")) {
        return;
    }
    wait getdvarfloat("scr_overdrive_activationDelay_sec", 0.4);
    self.var_7d73f4ba = self hasperk("specialty_deadshot");
    if (!(isdefined(self.var_7d73f4ba) && self.var_7d73f4ba)) {
        self setperk("specialty_deadshot");
    }
    self clientfield::set_to_player("overdrive_state", 1);
    visionset_mgr::activate("visionset", "overdrive", self, 0.4, 0.1, 1.35);
    self notify(weapon.name + "_fired");
    level notify(weapon.name + "_fired");
    if (self.health < self.maxhealth * getdvarfloat("scr_overdrive_min_health", 0.35)) {
        self setnormalhealth(getdvarfloat("scr_overdrive_min_health", 0.35));
    }
    self playrumbleonentity("tank_rumble");
    if (isplayer(self)) {
        itemindex = getitemindexfromref("cybercom_overdrive");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_f388b961
// Params 2, eflags: 0x1 linked
// Checksum 0x1c3a4265, Offset: 0x7f0
// Size: 0x74
function _off(slot, weapon) {
    self notify(#"hash_3ca9ab77");
    if (!(isdefined(self.var_7d73f4ba) && self.var_7d73f4ba)) {
        self unsetperk("specialty_deadshot");
    }
    self clientfield::set_to_player("overdrive_state", 0);
}

