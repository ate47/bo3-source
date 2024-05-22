#using scripts/shared/postfx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_5f11fb0b;

// Namespace namespace_5f11fb0b
// Params 0, eflags: 0x2
// Checksum 0xae0096d6, Offset: 0x200
// Size: 0xdc
function main() {
    clientfield::register("toplayer", "player_cam_blur", 1, 1, "int", &player_cam_blur, 0, 1);
    clientfield::register("toplayer", "player_cam_bubbles", 1, 1, "int", &player_cam_bubbles, 0, 1);
    clientfield::register("toplayer", "player_cam_fire", 1, 1, "int", &player_cam_fire, 0, 1);
}

// Namespace namespace_5f11fb0b
// Params 7, eflags: 0x1 linked
// Checksum 0xe8a8eb94, Offset: 0x2e8
// Size: 0xd2
function player_cam_blur(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1 && !getinkillcam(localclientnum)) {
        blurandtint_fx(localclientnum, 1, 0.5);
        self thread function_db5afebe(localclientnum);
        return;
    }
    blurandtint_fx(localclientnum, 0);
    self notify(#"hash_64e72e9d");
}

// Namespace namespace_5f11fb0b
// Params 1, eflags: 0x1 linked
// Checksum 0x9e51875, Offset: 0x3c8
// Size: 0x88
function function_db5afebe(localclientnum) {
    self endon(#"disconnect");
    self endon(#"hash_64e72e9d");
    var_7233be3d = 0.5;
    while (var_7233be3d <= 1) {
        var_7233be3d += 0.04;
        blurandtint_fx(localclientnum, 1, var_7233be3d);
        wait(0.05);
    }
}

// Namespace namespace_5f11fb0b
// Params 7, eflags: 0x1 linked
// Checksum 0x1efe3c96, Offset: 0x458
// Size: 0x114
function player_cam_bubbles(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1 && !getinkillcam(localclientnum)) {
        if (isdefined(self.n_fx_id)) {
            deletefx(localclientnum, self.n_fx_id, 1);
        }
        self.n_fx_id = playfxoncamera(localclientnum, "player/fx_plyr_swim_bubbles_body", (0, 0, 0), (1, 0, 0), (0, 0, 1));
        self playrumbleonentity(localclientnum, "damage_heavy");
        return;
    }
    if (isdefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
    }
}

// Namespace namespace_5f11fb0b
// Params 7, eflags: 0x1 linked
// Checksum 0xb7cbdf4b, Offset: 0x578
// Size: 0x94
function player_cam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1 && !getinkillcam(localclientnum)) {
        burn_on_postfx();
        return;
    }
    function_7a5c3cf3();
}

// Namespace namespace_5f11fb0b
// Params 0, eflags: 0x1 linked
// Checksum 0x55732ad6, Offset: 0x618
// Size: 0x34
function burn_on_postfx() {
    self endon(#"disconnect");
    self endon(#"hash_bdb63a72");
    self thread postfx::playpostfxbundle("pstfx_burn_loop");
}

// Namespace namespace_5f11fb0b
// Params 0, eflags: 0x1 linked
// Checksum 0x536f65d4, Offset: 0x658
// Size: 0x24
function function_7a5c3cf3() {
    self notify(#"hash_bdb63a72");
    self postfx::stoppostfxbundle();
}

