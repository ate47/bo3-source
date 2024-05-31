#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_98c95ca3;

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// Checksum 0x4f4eed3c, Offset: 0x268
// Size: 0x1c
function main() {
    level thread function_c360b5f6();
}

// Namespace namespace_98c95ca3
// Params 7, eflags: 0x1 linked
// Checksum 0xe01f350f, Offset: 0x290
// Size: 0x1aa
function function_4ec92a54(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval) {
        for (i = 0; i < level.localplayers.size; i++) {
            level thread function_e41acae4(i, self);
        }
        return;
    }
    if (isdefined(self.var_965756be)) {
        for (i = 0; i < level.localplayers.size; i++) {
            stopfx(i, self.var_965756be);
            stopfx(i, self.var_7054dc55);
            stopfx(i, self.var_da48d96a);
            stopfx(i, self.var_b4465f01);
            if (isdefined(self.var_3a66468c)) {
                stopfx(i, self.var_3a66468c);
            }
            if (isdefined(self.var_deef11e2)) {
                stopfx(i, self.var_deef11e2);
            }
        }
    }
    self notify(#"hash_54d1e0d6");
}

// Namespace namespace_98c95ca3
// Params 7, eflags: 0x1 linked
// Checksum 0x11b4843c, Offset: 0x448
// Size: 0x5c
function function_a0cf54a0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        level thread function_1e254f15();
    }
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// Checksum 0xb3dabe75, Offset: 0x4b0
// Size: 0x148
function function_1e254f15() {
    for (i = 0; i < level.localplayers.size; i++) {
        player = getlocalplayers()[i];
        if (!isdefined(player)) {
            continue;
        }
        piece = struct::get("biodome_breached", "targetname");
        if (distancesquared(player.origin, piece.origin) < 6250000) {
            player earthquake(0.5, 3, player.origin, 1500);
            player thread function_e718a459(i);
        }
        scene::play("p7_fxanim_zmhd_moon_biodome_glass_bundle");
        level notify(#"hash_a6bbc79");
        level notify(#"hash_37f6f363");
    }
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// Checksum 0xdbfff6d0, Offset: 0x600
// Size: 0x7e
function function_e718a459(localclientnum) {
    self endon(#"disconnect");
    for (i = 0; i < 10; i++) {
        self playrumbleonentity(localclientnum, "damage_heavy");
        wait(randomfloatrange(0.1, 0.2));
    }
}

// Namespace namespace_98c95ca3
// Params 7, eflags: 0x1 linked
// Checksum 0xc8bae123, Offset: 0x688
// Size: 0xae
function function_f0b2bcb7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval) {
        for (i = 0; i < level.localplayers.size; i++) {
            level thread function_f4616a07(i, self);
        }
        return;
    }
    self notify(#"hash_3b09ee3");
}

// Namespace namespace_98c95ca3
// Params 2, eflags: 0x1 linked
// Checksum 0xa0b22697, Offset: 0x740
// Size: 0x1d8
function function_e41acae4(localclientnum, var_719f80ce) {
    var_719f80ce util::waittill_dobj(localclientnum);
    var_719f80ce endon(#"entityshutdown");
    var_719f80ce endon(#"hash_54d1e0d6");
    var_54736a3c = 6250000;
    var_719f80ce.var_3a66468c = playfxontag(localclientnum, level._effect["digger_treadfx_fwd"], var_719f80ce, "tag_origin");
    var_719f80ce.var_deef11e2 = playfxontag(localclientnum, level._effect["exca_body_all"], var_719f80ce, "tag_origin");
    player = getlocalplayers()[localclientnum];
    if (!isdefined(player)) {
        return;
    }
    while (true) {
        if (!isdefined(player)) {
            return;
        }
        player earthquake(randomfloatrange(0.15, 0.25), 3, var_719f80ce.origin, 2500);
        if (distancesquared(var_719f80ce.origin, player.origin) < var_54736a3c) {
            player playrumbleonentity(localclientnum, "slide_rumble");
        }
        wait(randomfloatrange(0.05, 0.15));
    }
}

// Namespace namespace_98c95ca3
// Params 2, eflags: 0x1 linked
// Checksum 0x39b1720f, Offset: 0x920
// Size: 0x198
function function_f4616a07(localclientnum, var_719f80ce) {
    var_719f80ce endon(#"entityshutdown");
    var_719f80ce endon(#"hash_3b09ee3");
    player = getlocalplayers()[localclientnum];
    if (!isdefined(player)) {
        return;
    }
    count = 0;
    dist = 2250000;
    while (true) {
        if (!isdefined(player)) {
            return;
        }
        player earthquake(randomfloatrange(0.12, 0.17), 3, var_719f80ce.origin, 1500);
        if (distancesquared(var_719f80ce.origin, player.origin) < dist && abs(var_719f80ce.origin[2] - player.origin[2]) < 750) {
            player playrumbleonentity(localclientnum, "grenade_rumble");
        }
        wait(randomfloatrange(0.1, 0.25));
    }
}

// Namespace namespace_98c95ca3
// Params 7, eflags: 0x1 linked
// Checksum 0xa4d7b11b, Offset: 0xac0
// Size: 0x15e
function function_5567a905(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (localclientnum != 0) {
        return;
    }
    if (newval) {
        for (i = 0; i < level.localplayers.size; i++) {
            level thread function_3f672255(i, self);
        }
        return;
    }
    if (isdefined(self.var_da48d96a)) {
        for (i = 0; i < level.localplayers.size; i++) {
            stopfx(i, self.var_da48d96a);
            stopfx(i, self.var_b4465f01);
        }
    }
    if (isdefined(self.var_5f9ccb3a)) {
        for (i = 0; i < level.localplayers.size; i++) {
            stopfx(i, self.var_5f9ccb3a);
        }
    }
}

// Namespace namespace_98c95ca3
// Params 2, eflags: 0x1 linked
// Checksum 0x405bec01, Offset: 0xc28
// Size: 0x90
function function_3f672255(localclientnum, ent) {
    ent endon(#"entityshutdown");
    player = getlocalplayers()[localclientnum];
    if (!isdefined(player)) {
        return;
    }
    ent.var_5f9ccb3a = playfxontag(localclientnum, level._effect["exca_arm_all"], ent, "tag_origin");
}

// Namespace namespace_98c95ca3
// Params 7, eflags: 0x1 linked
// Checksum 0xa1753ab6, Offset: 0xcc0
// Size: 0x8c
function function_245b13ce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        level thread function_cf66dde9(localclientnum, "hide");
        return;
    }
    level thread function_cf66dde9(localclientnum, "show");
}

// Namespace namespace_98c95ca3
// Params 2, eflags: 0x1 linked
// Checksum 0x2f718ed7, Offset: 0xd58
// Size: 0x33a
function function_cf66dde9(localclient, visible) {
    var_3943b1da = getentarray(localclient, "digger_body", "targetname");
    tracks = getentarray(localclient, "tracks", "targetname");
    switch (visible) {
    case 10:
        for (i = 0; i < tracks.size; i++) {
            tracks[i] hide();
        }
        for (i = 0; i < var_3943b1da.size; i++) {
            arm = getent(localclient, var_3943b1da[i].target, "targetname");
            var_8d95170f = getent(localclient, arm.target, "targetname");
            blade = getent(localclient, var_8d95170f.target, "targetname");
            var_3943b1da[i] hide();
            arm hide();
            blade hide();
        }
        break;
    case 11:
        for (i = 0; i < tracks.size; i++) {
            tracks[i] show();
        }
        for (i = 0; i < var_3943b1da.size; i++) {
            arm = getent(localclient, var_3943b1da[i].target, "targetname");
            var_8d95170f = getent(localclient, arm.target, "targetname");
            blade = getent(localclient, var_8d95170f.target, "targetname");
            var_3943b1da[i] show();
            arm show();
            blade show();
        }
        break;
    }
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// Checksum 0x31b1cc67, Offset: 0x10a0
// Size: 0x176
function function_c360b5f6() {
    wait(15);
    for (index = 0; index < level.localplayers.size; index++) {
        if (!level clientfield::get("TCA")) {
            mdl_console = getent(index, "tunnel_console", "targetname");
            function_9b3daafa(index, mdl_console, 0);
        }
        if (!level clientfield::get("HCA")) {
            mdl_console = getent(index, "hangar_console", "targetname");
            function_9b3daafa(index, mdl_console, 0);
        }
        if (!level clientfield::get("BCA")) {
            mdl_console = getent(index, "biodome_console", "targetname");
            function_9b3daafa(index, mdl_console, 0);
        }
    }
}

// Namespace namespace_98c95ca3
// Params 7, eflags: 0x1 linked
// Checksum 0x77da2126, Offset: 0x1220
// Size: 0x10c
function function_774edb15(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    switch (fieldname) {
    case 14:
        var_ffc320da = "tunnel_console";
        break;
    case 16:
        var_ffc320da = "hangar_console";
        break;
    case 18:
        var_ffc320da = "biodome_console";
        break;
    }
    mdl_console = getent(localclientnum, var_ffc320da, "targetname");
    if (newval) {
        function_9b3daafa(localclientnum, mdl_console, 1);
        return;
    }
    function_9b3daafa(localclientnum, mdl_console, 0);
}

// Namespace namespace_98c95ca3
// Params 3, eflags: 0x1 linked
// Checksum 0x7278c0de, Offset: 0x1338
// Size: 0xe8
function function_9b3daafa(localclientnum, mdl_console, var_a61a4e58) {
    if (isdefined(mdl_console.n_fx_id)) {
        stopfx(localclientnum, mdl_console.n_fx_id);
    }
    if (var_a61a4e58) {
        mdl_console.n_fx_id = playfxontag(localclientnum, level._effect["panel_on"], mdl_console, "tag_origin");
        return;
    }
    mdl_console.n_fx_id = playfxontag(localclientnum, level._effect["panel_off"], mdl_console, "tag_origin");
}

