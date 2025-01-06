#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_bouncingbetty;
#using scripts/zm/_util;

#namespace controllable_spider;

// Namespace controllable_spider
// Params 0, eflags: 0x2
// Checksum 0x20685f1f, Offset: 0x1c0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("controllable_spider", &__init__, undefined, undefined);
}

// Namespace controllable_spider
// Params 1, eflags: 0x0
// Checksum 0x7d540efd, Offset: 0x200
// Size: 0x9c
function __init__(localclientnum) {
    clientfield::register("scriptmover", "player_cocooned_fx", 9000, 1, "int", &player_cocooned_fx, 0, 0);
    clientfield::register("allplayers", "player_cocooned_fx", 9000, 1, "int", &player_cocooned_fx, 0, 0);
}

// Namespace controllable_spider
// Params 7, eflags: 0x0
// Checksum 0xfcb6c022, Offset: 0x2a8
// Size: 0xa2
function player_cocooned_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_e3645e32)) {
            self.var_e3645e32 = [];
        }
        self.var_e3645e32[localclientnum] = playfxontag(localclientnum, level._effect["cocooned_fx"], self, "tag_origin");
    }
}

