#using scripts/mp/_util;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace explosive_bolt;

// Namespace explosive_bolt
// Params 0, eflags: 0x2
// Checksum 0xc1e203e4, Offset: 0x198
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("explosive_bolt", &__init__, undefined, undefined);
}

// Namespace explosive_bolt
// Params 0, eflags: 0x1 linked
// Checksum 0x290ddbce, Offset: 0x1d8
// Size: 0x44
function __init__() {
    level._effect["crossbow_light"] = "weapon/fx_equip_light_os";
    callback::add_weapon_type("explosive_bolt", &spawned);
}

// Namespace explosive_bolt
// Params 1, eflags: 0x1 linked
// Checksum 0xf601c4dc, Offset: 0x228
// Size: 0x44
function spawned(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self thread fx_think(localclientnum);
}

// Namespace explosive_bolt
// Params 1, eflags: 0x1 linked
// Checksum 0x75f6e4f4, Offset: 0x278
// Size: 0x12c
function fx_think(localclientnum) {
    self notify(#"light_disable");
    self endon(#"entityshutdown");
    self endon(#"light_disable");
    self util::waittill_dobj(localclientnum);
    for (interval = 0.3; ; interval = math::clamp(interval / 1.2, 0.08, 0.3)) {
        self stop_light_fx(localclientnum);
        self start_light_fx(localclientnum);
        self fullscreen_fx(localclientnum);
        self playsound(localclientnum, "wpn_semtex_alert");
        util::server_wait(localclientnum, interval, 0.016, "player_switch");
    }
}

// Namespace explosive_bolt
// Params 1, eflags: 0x1 linked
// Checksum 0xbb1685e5, Offset: 0x3b0
// Size: 0x6c
function start_light_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    self.fx = playfxontag(localclientnum, level._effect["crossbow_light"], self, "tag_origin");
}

// Namespace explosive_bolt
// Params 1, eflags: 0x1 linked
// Checksum 0xf4662d04, Offset: 0x428
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace explosive_bolt
// Params 1, eflags: 0x1 linked
// Checksum 0x6213bcbd, Offset: 0x480
// Size: 0xf4
function fullscreen_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    if (isdefined(player)) {
        if (player getinkillcam(localclientnum)) {
            return;
        } else if (player util::is_player_view_linked_to_entity(localclientnum)) {
            return;
        }
    }
    if (self util::function_f36b8920(localclientnum)) {
        return;
    }
    parent = self getparententity();
    if (isdefined(parent) && parent == player) {
        parent playrumbleonentity(localclientnum, "buzz_high");
    }
}

