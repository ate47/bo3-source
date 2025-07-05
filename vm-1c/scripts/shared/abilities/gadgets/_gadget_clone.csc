#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/gadgets/_gadget_clone_render;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _gadget_clone;

// Namespace _gadget_clone
// Params 0, eflags: 0x2
// Checksum 0x4fcc7ea5, Offset: 0x2d8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_clone", &__init__, undefined, undefined);
}

// Namespace _gadget_clone
// Params 0, eflags: 0x0
// Checksum 0x172b240f, Offset: 0x318
// Size: 0xdc
function __init__() {
    clientfield::register("actor", "clone_activated", 1, 1, "int", &clone_activated, 0, 1);
    clientfield::register("actor", "clone_damaged", 1, 1, "int", &clone_damaged, 0, 0);
    clientfield::register("allplayers", "clone_activated", 1, 1, "int", &function_a000e134, 0, 0);
}

// Namespace _gadget_clone
// Params 3, eflags: 0x0
// Checksum 0x98284375, Offset: 0x400
// Size: 0x84
function function_87218e55(localclientnum, enabled, entity) {
    if (entity isfriendly(localclientnum)) {
        self duplicate_render::update_dr_flag(localclientnum, "clone_ally_on", enabled);
        return;
    }
    self duplicate_render::update_dr_flag(localclientnum, "clone_enemy_on", enabled);
}

// Namespace _gadget_clone
// Params 7, eflags: 0x0
// Checksum 0x5c834f63, Offset: 0x490
// Size: 0xbc
function clone_activated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self._isclone = 1;
        self function_87218e55(localclientnum, 1, self getowner(localclientnum));
        if (isdefined(level._monitor_tracker)) {
            self thread [[ level._monitor_tracker ]](localclientnum);
        }
        self thread gadget_clone_render::function_9bad5680(localclientnum);
    }
}

// Namespace _gadget_clone
// Params 7, eflags: 0x0
// Checksum 0x45b8f3, Offset: 0x558
// Size: 0xdc
function function_a000e134(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self function_87218e55(localclientnum, 1, self);
        self thread gadget_clone_render::function_9bad5680(localclientnum);
        return;
    }
    self function_87218e55(localclientnum, 0, self);
    self notify(#"hash_b8916aca");
    self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, 0, 0, 1);
}

// Namespace _gadget_clone
// Params 1, eflags: 0x0
// Checksum 0xea2814f6, Offset: 0x640
// Size: 0x84
function function_46c43b11(localclientnum) {
    self endon(#"entityshutdown");
    self notify(#"start_flicker");
    self endon(#"start_flicker");
    self duplicate_render::update_dr_flag(localclientnum, "clone_damage", 1);
    self waittill(#"stop_flicker");
    self duplicate_render::update_dr_flag(localclientnum, "clone_damage", 0);
}

// Namespace _gadget_clone
// Params 0, eflags: 0x0
// Checksum 0xbe0400b5, Offset: 0x6d0
// Size: 0x3e
function function_94521dca() {
    self endon(#"entityshutdown");
    self endon(#"start_flicker");
    self endon(#"stop_flicker");
    wait 0.2;
    self notify(#"stop_flicker");
}

// Namespace _gadget_clone
// Params 7, eflags: 0x0
// Checksum 0x41ea835c, Offset: 0x718
// Size: 0x74
function clone_damaged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_46c43b11(localclientnum);
        return;
    }
    self thread function_94521dca();
}

