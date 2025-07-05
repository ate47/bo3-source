#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace hackable;

// Namespace hackable
// Params 0, eflags: 0x2
// Checksum 0xe1cdf26e, Offset: 0x170
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("hackable", &init, undefined, undefined);
}

// Namespace hackable
// Params 0, eflags: 0x0
// Checksum 0x1adaf659, Offset: 0x1b0
// Size: 0x24
function init() {
    callback::on_localclient_connect(&on_player_connect);
}

// Namespace hackable
// Params 1, eflags: 0x0
// Checksum 0x71b76b02, Offset: 0x1e0
// Size: 0x44
function on_player_connect(localclientnum) {
    duplicate_render::set_dr_filter_offscreen("hacking", 75, "being_hacked", undefined, 2, "mc/hud_keyline_orange", 1);
}

// Namespace hackable
// Params 2, eflags: 0x0
// Checksum 0xec346a6d, Offset: 0x230
// Size: 0x94
function set_hacked_ent(local_client_num, ent) {
    if (!(ent === self.hacked_ent)) {
        if (isdefined(self.hacked_ent)) {
            self.hacked_ent duplicate_render::change_dr_flags(local_client_num, undefined, "being_hacked");
        }
        self.hacked_ent = ent;
        if (isdefined(self.hacked_ent)) {
            self.hacked_ent duplicate_render::change_dr_flags(local_client_num, "being_hacked", undefined);
        }
    }
}

