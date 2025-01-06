#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace explosive_bolt;

// Namespace explosive_bolt
// Params 0, eflags: 0x2
// Checksum 0x4e75ddb0, Offset: 0x198
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("explosive_bolt", &__init__, undefined, undefined);
}

// Namespace explosive_bolt
// Params 0, eflags: 0x0
// Checksum 0xb416ebaa, Offset: 0x1d0
// Size: 0x42
function __init__() {
    level._effect["crossbow_light"] = "weapon/fx_equip_light_os";
    callback::add_weapon_type("explosive_bolt", &spawned);
}

// Namespace explosive_bolt
// Params 1, eflags: 0x0
// Checksum 0xc37c8ed5, Offset: 0x220
// Size: 0x32
function spawned(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self thread fx_think(localclientnum);
}

// Namespace explosive_bolt
// Params 1, eflags: 0x0
// Checksum 0xd643d8c9, Offset: 0x260
// Size: 0xdf
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
// Params 1, eflags: 0x0
// Checksum 0xc295ea37, Offset: 0x348
// Size: 0x5a
function start_light_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    self.fx = playfxontag(localclientnum, level._effect["crossbow_light"], self, "tag_origin");
}

// Namespace explosive_bolt
// Params 1, eflags: 0x0
// Checksum 0xc958f754, Offset: 0x3b0
// Size: 0x41
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace explosive_bolt
// Params 1, eflags: 0x0
// Checksum 0x65bda025, Offset: 0x400
// Size: 0xba
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

