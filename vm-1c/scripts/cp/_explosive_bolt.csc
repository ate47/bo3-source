#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/codescripts/struct;

#namespace namespace_3d2de961;

// Namespace namespace_3d2de961
// Params 0, eflags: 0x1 linked
// namespace_3d2de961<file_0>::function_d290ebfa
// Checksum 0x8a023d93, Offset: 0x128
// Size: 0x1e
function main() {
    level._effect["crossbow_light"] = "weapon/fx_equip_light_os";
}

// Namespace namespace_3d2de961
// Params 1, eflags: 0x1 linked
// namespace_3d2de961<file_0>::function_ab1f9ea1
// Checksum 0x439528b7, Offset: 0x150
// Size: 0x44
function spawned(localclientnum) {
    if (self isgrenadedud()) {
        return;
    }
    self thread fx_think(localclientnum);
}

// Namespace namespace_3d2de961
// Params 1, eflags: 0x1 linked
// namespace_3d2de961<file_0>::function_e18161a
// Checksum 0x350353a4, Offset: 0x1a0
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

// Namespace namespace_3d2de961
// Params 1, eflags: 0x1 linked
// namespace_3d2de961<file_0>::function_d2e7a133
// Checksum 0xbfc8117e, Offset: 0x2d8
// Size: 0x6c
function start_light_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    self.fx = playfxontag(localclientnum, level._effect["crossbow_light"], self, "tag_origin");
}

// Namespace namespace_3d2de961
// Params 1, eflags: 0x1 linked
// namespace_3d2de961<file_0>::function_958821cd
// Checksum 0xdb6b62d7, Offset: 0x350
// Size: 0x4e
function stop_light_fx(localclientnum) {
    if (isdefined(self.fx) && self.fx != 0) {
        stopfx(localclientnum, self.fx);
        self.fx = undefined;
    }
}

// Namespace namespace_3d2de961
// Params 1, eflags: 0x1 linked
// namespace_3d2de961<file_0>::function_9eb5d027
// Checksum 0x17a0a744, Offset: 0x3a8
// Size: 0xd4
function fullscreen_fx(localclientnum) {
    player = getlocalplayer(localclientnum);
    if (isdefined(player)) {
        if (player util::is_player_view_linked_to_entity(localclientnum)) {
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

