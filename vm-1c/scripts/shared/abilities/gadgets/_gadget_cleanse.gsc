#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _gadget_cleanse;

// Namespace _gadget_cleanse
// Params 0, eflags: 0x2
// Checksum 0x27b72c60, Offset: 0x208
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_cleanse", &__init__, undefined, undefined);
}

// Namespace _gadget_cleanse
// Params 0, eflags: 0x0
// Checksum 0x4c118825, Offset: 0x248
// Size: 0x114
function __init__() {
    ability_player::register_gadget_activation_callbacks(17, &gadget_cleanse_on, &function_d9079385);
    ability_player::register_gadget_possession_callbacks(17, &function_e8df45df, &function_db5e1e95);
    ability_player::register_gadget_flicker_callbacks(17, &function_c8cd9188);
    ability_player::register_gadget_is_inuse_callbacks(17, &function_5e9069b9);
    ability_player::register_gadget_is_flickering_callbacks(17, &function_ba97acdd);
    clientfield::register("allplayers", "gadget_cleanse_on", 1, 1, "int");
    callback::on_connect(&function_e5937cbe);
}

// Namespace _gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0x4aa20e2c, Offset: 0x368
// Size: 0x2a
function function_5e9069b9(slot) {
    return self flagsys::get("gadget_cleanse_on");
}

// Namespace _gadget_cleanse
// Params 1, eflags: 0x0
// Checksum 0x5002e5ce, Offset: 0x3a0
// Size: 0x22
function function_ba97acdd(slot) {
    return self gadgetflickering(slot);
}

// Namespace _gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x52484437, Offset: 0x3d0
// Size: 0x34
function function_c8cd9188(slot, weapon) {
    self thread function_e35dfa9e(slot, weapon);
}

// Namespace _gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x38d1ebd, Offset: 0x410
// Size: 0x14
function function_e8df45df(slot, weapon) {
    
}

// Namespace _gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xd0d8ea22, Offset: 0x430
// Size: 0x14
function function_db5e1e95(slot, weapon) {
    
}

// Namespace _gadget_cleanse
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x450
// Size: 0x4
function function_e5937cbe() {
    
}

// Namespace _gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xd56256f8, Offset: 0x460
// Size: 0x74
function gadget_cleanse_on(slot, weapon) {
    self flagsys::set("gadget_cleanse_on");
    self thread function_1e438b36(slot, weapon);
    self clientfield::set("gadget_cleanse_on", 1);
}

// Namespace _gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x12146b61, Offset: 0x4e0
// Size: 0x54
function function_d9079385(slot, weapon) {
    self flagsys::clear("gadget_cleanse_on");
    self clientfield::set("gadget_cleanse_on", 0);
}

// Namespace _gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x38085cf0, Offset: 0x540
// Size: 0xaa
function function_1e438b36(slot, weapon) {
    self setempjammed(0);
    self gadgetsetactivatetime(slot, gettime());
    self setnormalhealth(self.maxhealth);
    self setdoublejumpenergy(1);
    self stopshellshock();
    self notify(#"gadget_cleanse_on");
}

// Namespace _gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xfc44388a, Offset: 0x5f8
// Size: 0x14
function wait_until_is_done(slot, timepulse) {
    
}

// Namespace _gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0x222dccc7, Offset: 0x618
// Size: 0x1e
function function_e35dfa9e(slot, weapon) {
    self endon(#"disconnect");
}

// Namespace _gadget_cleanse
// Params 2, eflags: 0x0
// Checksum 0xb5c40f2e, Offset: 0x640
// Size: 0x14
function function_a64f41f5(status, time) {
    
}

