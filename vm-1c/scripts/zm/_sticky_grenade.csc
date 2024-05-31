#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/codescripts/struct;

#namespace namespace_e381fc9e;

// Namespace namespace_e381fc9e
// Params 0, eflags: 0x1 linked
// namespace_e381fc9e<file_0>::function_d290ebfa
// Checksum 0xe389ef65, Offset: 0x128
// Size: 0x1e
function main() {
    level._effect["grenade_light"] = "weapon/fx_equip_light_os";
}

// Namespace namespace_e381fc9e
// Params 1, eflags: 0x1 linked
// namespace_e381fc9e<file_0>::function_ab1f9ea1
// Checksum 0x14e3a2cb, Offset: 0x150
// Size: 0x44
function spawned(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self thread fx_think(localclientnum);
}

// Namespace namespace_e381fc9e
// Params 1, eflags: 0x1 linked
// namespace_e381fc9e<file_0>::function_e18161a
// Checksum 0x39e3a1fc, Offset: 0x1a0
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
        util::server_wait(localclientnum, interval, 0.01, "player_switch");
    }
}

// Namespace namespace_e381fc9e
// Params 1, eflags: 0x1 linked
// namespace_e381fc9e<file_0>::function_d2e7a133
// Checksum 0x2d1ddc93, Offset: 0x2d8
// Size: 0x6c
function start_light_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    self.fx = playfxontag(localclientnum, level._effect["grenade_light"], self, "tag_fx");
}

// Namespace namespace_e381fc9e
// Params 1, eflags: 0x1 linked
// namespace_e381fc9e<file_0>::function_958821cd
// Checksum 0xbd4eae3a, Offset: 0x350
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace namespace_e381fc9e
// Params 1, eflags: 0x1 linked
// namespace_e381fc9e<file_0>::function_9eb5d027
// Checksum 0xb8bf10a4, Offset: 0x3a8
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

