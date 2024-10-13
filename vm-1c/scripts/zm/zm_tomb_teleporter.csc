#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace zm_tomb_teleporter;

// Namespace zm_tomb_teleporter
// Params 0, eflags: 0x1 linked
// Checksum 0xaca97e60, Offset: 0x260
// Size: 0x94
function init() {
    clientfield::register("allplayers", "teleport_arrival_departure_fx", 21000, 1, "counter", &function_dadd24b7, 0, 0);
    clientfield::register("vehicle", "teleport_arrival_departure_fx", 21000, 1, "counter", &function_dadd24b7, 0, 0);
}

// Namespace zm_tomb_teleporter
// Params 0, eflags: 0x1 linked
// Checksum 0x7784ded7, Offset: 0x300
// Size: 0x2c
function main() {
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_factory_teleport", 21000, 1, "pstfx_zm_tomb_teleport");
}

// Namespace zm_tomb_teleporter
// Params 7, eflags: 0x1 linked
// Checksum 0xd3e25ce2, Offset: 0x338
// Size: 0x106
function function_a8255fab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"disconnect");
    if (newval == 1) {
        if (!isdefined(self.var_1e8e073f)) {
            self.var_1e8e073f = playfxontag(localclientnum, level._effect["teleport_1p"], self, "tag_origin");
            setfxignorepause(localclientnum, self.var_1e8e073f, 1);
        }
        return;
    }
    if (isdefined(self.var_1e8e073f)) {
        stopfx(localclientnum, self.var_1e8e073f);
        self.var_1e8e073f = undefined;
    }
}

// Namespace zm_tomb_teleporter
// Params 7, eflags: 0x0
// Checksum 0xb8cca17, Offset: 0x448
// Size: 0xe4
function function_ffedfe48(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_b162502d = !(isdefined(self.var_76534568) && self.var_76534568);
    if (!(isdefined(self.var_76534568) && self.var_76534568)) {
        self useanimtree(#generic);
        self.var_76534568 = 1;
    }
    if (newval) {
        self thread scene::play("p7_fxanim_zm_ori_portal_open_bundle", self);
        return;
    }
    self thread scene::play("p7_fxanim_zm_ori_portal_collapse_bundle", self);
}

// Namespace zm_tomb_teleporter
// Params 7, eflags: 0x1 linked
// Checksum 0xe7ffb710, Offset: 0x538
// Size: 0x172
function function_dadd24b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    str_tag_name = "";
    if (self isplayer()) {
        str_tag_name = "j_spinelower";
    } else {
        str_tag_name = "tag_brain";
    }
    a_e_players = getlocalplayers();
    foreach (e_player in a_e_players) {
        self.var_16ab725 = playfxontag(e_player.localclientnum, level._effect["teleport_arrive_player"], self, str_tag_name);
        setfxignorepause(e_player.localclientnum, self.var_16ab725, 1);
    }
}

