#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/spawner_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace _gadget_combat_efficiency;

// Namespace _gadget_combat_efficiency
// Params 0, eflags: 0x2
// namespace_a9b52691<file_0>::function_2dc19561
// Checksum 0x6025846d, Offset: 0x268
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_combat_efficiency", &__init__, undefined, undefined);
}

// Namespace _gadget_combat_efficiency
// Params 0, eflags: 0x1 linked
// namespace_a9b52691<file_0>::function_8c87d8eb
// Checksum 0xa3acab4b, Offset: 0x2a8
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(15, &gadget_combat_efficiency_on_activate, &gadget_combat_efficiency_on_off);
    ability_player::register_gadget_possession_callbacks(15, &function_ce638c14, &function_c4a4c062);
    ability_player::register_gadget_flicker_callbacks(15, &function_1fb7ea1d);
    ability_player::register_gadget_is_inuse_callbacks(15, &gadget_combat_efficiency_is_inuse);
    ability_player::register_gadget_is_flickering_callbacks(15, &gadget_combat_efficiency_is_flickering);
    ability_player::register_gadget_ready_callbacks(15, &gadget_combat_efficiency_ready);
}

// Namespace _gadget_combat_efficiency
// Params 1, eflags: 0x1 linked
// namespace_a9b52691<file_0>::function_fd490370
// Checksum 0xf4b326e2, Offset: 0x398
// Size: 0x22
function gadget_combat_efficiency_is_inuse(slot) {
    return self gadgetisactive(slot);
}

// Namespace _gadget_combat_efficiency
// Params 1, eflags: 0x1 linked
// namespace_a9b52691<file_0>::function_d49e274e
// Checksum 0x26b7ed4c, Offset: 0x3c8
// Size: 0x22
function gadget_combat_efficiency_is_flickering(slot) {
    return self gadgetflickering(slot);
}

// Namespace _gadget_combat_efficiency
// Params 2, eflags: 0x1 linked
// namespace_a9b52691<file_0>::function_1fb7ea1d
// Checksum 0x72b9a96a, Offset: 0x3f8
// Size: 0x14
function function_1fb7ea1d(slot, weapon) {
    
}

// Namespace _gadget_combat_efficiency
// Params 2, eflags: 0x1 linked
// namespace_a9b52691<file_0>::function_ce638c14
// Checksum 0x86beb7d8, Offset: 0x418
// Size: 0x14
function function_ce638c14(slot, weapon) {
    
}

// Namespace _gadget_combat_efficiency
// Params 2, eflags: 0x1 linked
// namespace_a9b52691<file_0>::function_c4a4c062
// Checksum 0x9622ab3d, Offset: 0x438
// Size: 0x14
function function_c4a4c062(slot, weapon) {
    
}

// Namespace _gadget_combat_efficiency
// Params 0, eflags: 0x0
// namespace_a9b52691<file_0>::function_4efdcefb
// Checksum 0x99ec1590, Offset: 0x458
// Size: 0x4
function function_4efdcefb() {
    
}

// Namespace _gadget_combat_efficiency
// Params 0, eflags: 0x0
// namespace_a9b52691<file_0>::function_66bfd148
// Checksum 0x56d095a6, Offset: 0x468
// Size: 0x10
function function_66bfd148() {
    self.combatefficiencylastontime = 0;
}

// Namespace _gadget_combat_efficiency
// Params 2, eflags: 0x1 linked
// namespace_a9b52691<file_0>::function_93968950
// Checksum 0xebd65b40, Offset: 0x480
// Size: 0x44
function gadget_combat_efficiency_on_activate(slot, weapon) {
    self._gadget_combat_efficiency = 1;
    self._gadget_combat_efficiency_success = 0;
    self.scorestreaksearnedperuse = 0;
    self.combatefficiencylastontime = gettime();
}

// Namespace _gadget_combat_efficiency
// Params 2, eflags: 0x1 linked
// namespace_a9b52691<file_0>::function_e58640be
// Checksum 0xcf12e675, Offset: 0x4d0
// Size: 0xe8
function gadget_combat_efficiency_on_off(slot, weapon) {
    self._gadget_combat_efficiency = 0;
    self.combatefficiencylastontime = gettime();
    self addweaponstat(self.heroability, "scorestreaks_earned_2", int(self.scorestreaksearnedperuse / 2));
    self addweaponstat(self.heroability, "scorestreaks_earned_3", int(self.scorestreaksearnedperuse / 3));
    if (isalive(self) && isdefined(level.playgadgetsuccess)) {
        self [[ level.playgadgetsuccess ]](weapon);
    }
}

// Namespace _gadget_combat_efficiency
// Params 2, eflags: 0x1 linked
// namespace_a9b52691<file_0>::function_a83013b4
// Checksum 0x523910e, Offset: 0x5c0
// Size: 0x14
function gadget_combat_efficiency_ready(slot, weapon) {
    
}

// Namespace _gadget_combat_efficiency
// Params 3, eflags: 0x0
// namespace_a9b52691<file_0>::function_2ccf67f4
// Checksum 0x20109cde, Offset: 0x5e0
// Size: 0xb4
function set_gadget_combat_efficiency_status(weapon, status, time) {
    timestr = "";
    if (isdefined(time)) {
        timestr = "^3" + ", time: " + time;
    }
    if (getdvarint("scr_cpower_debug_prints") > 0) {
        self iprintlnbold("Gadget Combat Efficiency " + weapon.name + ": " + status + timestr);
    }
}

