#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_gadgets;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_411f3e3f;

// Namespace namespace_411f3e3f
// Params 0, eflags: 0x2
// Checksum 0x80dc872b, Offset: 0x240
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_camo", &__init__, undefined, undefined);
}

// Namespace namespace_411f3e3f
// Params 0, eflags: 0x1 linked
// Checksum 0x369ff94a, Offset: 0x280
// Size: 0x154
function __init__() {
    ability_player::register_gadget_activation_callbacks(2, &function_700380c0, &function_3078d9ee);
    ability_player::register_gadget_possession_callbacks(2, &function_58efbfed, &function_9da1d50f);
    ability_player::register_gadget_flicker_callbacks(2, &function_63b9579a);
    ability_player::register_gadget_is_inuse_callbacks(2, &function_6b246a0f);
    ability_player::register_gadget_is_flickering_callbacks(2, &function_558ba1f7);
    clientfield::register("allplayers", "camo_shader", 1, 3, "int");
    callback::on_connect(&function_7af2cde4);
    callback::on_spawned(&function_2fd91ec7);
    callback::on_disconnect(&function_3f5bf600);
}

// Namespace namespace_411f3e3f
// Params 1, eflags: 0x1 linked
// Checksum 0xba12034c, Offset: 0x3e0
// Size: 0x2a
function function_6b246a0f(slot) {
    return self flagsys::get("camo_suit_on");
}

// Namespace namespace_411f3e3f
// Params 1, eflags: 0x1 linked
// Checksum 0x9f07e019, Offset: 0x418
// Size: 0x22
function function_558ba1f7(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_411f3e3f
// Params 0, eflags: 0x1 linked
// Checksum 0x45d05f04, Offset: 0x448
// Size: 0x44
function function_7af2cde4() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_5d2fec30 ]]();
    }
}

// Namespace namespace_411f3e3f
// Params 0, eflags: 0x1 linked
// Checksum 0x92c8444a, Offset: 0x498
// Size: 0x4c
function function_3f5bf600() {
    if (isdefined(self.sound_ent)) {
        self.sound_ent stoploopsound(0.05);
        self.sound_ent delete();
    }
}

// Namespace namespace_411f3e3f
// Params 0, eflags: 0x1 linked
// Checksum 0x9052cb8a, Offset: 0x4f0
// Size: 0xac
function function_2fd91ec7() {
    self flagsys::clear("camo_suit_on");
    self notify(#"hash_af133c03");
    self function_6f5db838();
    self clientfield::set("camo_shader", 0);
    if (isdefined(self.sound_ent)) {
        self.sound_ent stoploopsound(0.05);
        self.sound_ent delete();
    }
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x1 linked
// Checksum 0xbb00ebc5, Offset: 0x5a8
// Size: 0x9c
function function_a68d6bbe(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"hash_af133c03");
    self clientfield::set("camo_shader", 2);
    function_f93698a2(slot, weapon);
    if (self function_6b246a0f(slot)) {
        self clientfield::set("camo_shader", 1);
    }
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x1 linked
// Checksum 0x746a90b9, Offset: 0x650
// Size: 0x54
function function_f93698a2(slot, weapon) {
    self endon(#"death");
    self endon(#"hash_af133c03");
    while (self function_558ba1f7(slot)) {
        wait(0.5);
    }
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x1 linked
// Checksum 0xb1e399b4, Offset: 0x6b0
// Size: 0x5c
function function_58efbfed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x1 linked
// Checksum 0x2d124037, Offset: 0x718
// Size: 0x6c
function function_9da1d50f(slot, weapon) {
    self notify(#"hash_6adca138");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x1 linked
// Checksum 0xddc437a9, Offset: 0x790
// Size: 0x7c
function function_63b9579a(slot, weapon) {
    self thread function_1cecfd6a(slot, weapon);
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_411f3e3f
// Params 1, eflags: 0x0
// Checksum 0x9e667391, Offset: 0x818
// Size: 0xce
function function_de8067aa(value) {
    var_ce588222 = "axis";
    if (self.team == "axis") {
        var_ce588222 = "allies";
    }
    var_4174f437 = getaiarray(var_ce588222);
    for (i = 0; i < var_4174f437.size; i++) {
        testtarget = var_4174f437[i];
        if (!isdefined(testtarget) || !isalive(testtarget)) {
        }
    }
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x1 linked
// Checksum 0x17c1dcfb, Offset: 0x8f0
// Size: 0xfc
function function_700380c0(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._on ]](slot, weapon);
    }
    self thread function_e4b1d75d(slot, weapon);
    self.var_5646ad69 = self.ignoreme;
    self.ignoreme = 1;
    self clientfield::set("camo_shader", 1);
    self flagsys::set("camo_suit_on");
    self thread function_f026eb72(slot, weapon);
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x1 linked
// Checksum 0x3270db9f, Offset: 0x9f8
// Size: 0x10c
function function_3078d9ee(slot, weapon) {
    self flagsys::clear("camo_suit_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._off ]](slot, weapon);
    }
    if (isdefined(self.sound_ent)) {
    }
    self notify(#"hash_af133c03");
    if (isdefined(self.var_5646ad69)) {
        self.ignoreme = self.var_5646ad69;
        self.var_5646ad69 = undefined;
    } else {
        self.ignoreme = 0;
    }
    self function_6f5db838();
    self.var_9b8eaff2 = gettime();
    self clientfield::set("camo_shader", 0);
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x1 linked
// Checksum 0x981b1c94, Offset: 0xb10
// Size: 0xe4
function function_f026eb72(slot, weapon) {
    self notify(#"hash_f026eb72");
    self endon(#"hash_f026eb72");
    self function_6f5db838();
    if (!self function_6b246a0f()) {
        return;
    }
    self.var_3c9c8d7c = spawn("script_model", self.origin);
    self.var_3c9c8d7c setmodel("tag_origin");
    self function_f3c24946(slot, weapon);
    self function_6f5db838();
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x1 linked
// Checksum 0x231eb197, Offset: 0xc00
// Size: 0xa0
function function_f3c24946(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_af133c03");
    self endon(#"hash_f026eb72");
    starttime = gettime();
    while (true) {
        currenttime = gettime();
        if (currenttime - starttime > self._gadgets_player[slot].gadget_breadcrumbduration) {
            return;
        }
        wait(0.5);
    }
}

// Namespace namespace_411f3e3f
// Params 0, eflags: 0x1 linked
// Checksum 0xe237cb20, Offset: 0xca8
// Size: 0x36
function function_6f5db838() {
    if (isdefined(self.var_3c9c8d7c)) {
        self.var_3c9c8d7c delete();
        self.var_3c9c8d7c = undefined;
    }
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x1 linked
// Checksum 0x7dca309, Offset: 0xce8
// Size: 0xa8
function function_e4b1d75d(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"hash_af133c03");
    while (true) {
        self waittill(#"weapon_assassination");
        if (self function_6b246a0f()) {
            if (self._gadgets_player[slot].gadget_takedownrevealtime > 0) {
                self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_takedownrevealtime);
            }
        }
    }
}

// Namespace namespace_411f3e3f
// Params 1, eflags: 0x1 linked
// Checksum 0xb335fd5a, Offset: 0xd98
// Size: 0xbc
function function_1fc332a6(slot) {
    self endon(#"disconnect");
    if (!self function_6b246a0f()) {
        return;
    }
    self notify(#"hash_da72bae5");
    wait(0.1);
    var_6a7b0a9f = 0;
    if (isdefined(self.var_5646ad69)) {
        var_6a7b0a9f = self.var_5646ad69;
    }
    self.ignoreme = var_6a7b0a9f;
    function_5ec0c7ba(slot);
    self.ignoreme = self function_6b246a0f() || var_6a7b0a9f;
}

// Namespace namespace_411f3e3f
// Params 1, eflags: 0x1 linked
// Checksum 0x1dcb40fd, Offset: 0xe60
// Size: 0x6c
function function_5ec0c7ba(slot) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_af133c03");
    self endon(#"hash_da72bae5");
    while (true) {
        if (!self function_558ba1f7(slot)) {
            return;
        }
        wait(0.25);
    }
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x1 linked
// Checksum 0xb85c6a43, Offset: 0xed8
// Size: 0xd4
function function_1cecfd6a(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_af133c03");
    if (!self function_6b246a0f()) {
        return;
    }
    self thread function_1fc332a6(slot);
    self thread function_a68d6bbe(slot, weapon);
    while (true) {
        if (!self function_558ba1f7(slot)) {
            self thread function_f026eb72(slot);
            return;
        }
        wait(0.25);
    }
}

// Namespace namespace_411f3e3f
// Params 2, eflags: 0x0
// Checksum 0x3acf1ba0, Offset: 0xfb8
// Size: 0xa4
function function_c4eeb87f(status, time) {
    timestr = "";
    self.var_3bea8b4a = undefined;
    if (isdefined(time)) {
        timestr = ", ^3time: " + time;
        self.var_3bea8b4a = status;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Camo Reveal: " + status + timestr);
    }
}

