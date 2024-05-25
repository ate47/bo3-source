#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/postfx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#using_animtree("generic");

#namespace namespace_88aa1b1a;

// Namespace namespace_88aa1b1a
// Params 0, eflags: 0x2
// Checksum 0xb33a4207, Offset: 0x608
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("thrasher", &__init__, undefined, undefined);
}

// Namespace namespace_88aa1b1a
// Params 0, eflags: 0x1 linked
// Checksum 0x383e2169, Offset: 0x648
// Size: 0x27c
function __init__() {
    visionset_mgr::register_visionset_info("zm_isl_thrasher_stomach_visionset", 9000, 16, undefined, "zm_isl_thrasher_stomach");
    if (ai::shouldregisterclientfieldforarchetype("thrasher")) {
        clientfield::register("actor", "thrasher_spore_state", 5000, 3, "int", &namespace_4329c852::function_15e61dc, 0, 0);
        clientfield::register("actor", "thrasher_berserk_state", 5000, 1, "int", &namespace_4329c852::function_d5c67375, 0, 1);
        clientfield::register("actor", "thrasher_player_hide", 8000, 4, "int", &namespace_4329c852::function_6291f979, 0, 0);
        clientfield::register("toplayer", "sndPlayerConsumed", 10000, 1, "int", &namespace_4329c852::function_358dc87b, 0, 1);
        foreach (spore in array(1, 2, 4)) {
            clientfield::register("actor", "thrasher_spore_impact" + spore, 8000, 1, "counter", &namespace_4329c852::function_4b871d5b, 0, 0);
        }
    }
    ai::add_archetype_spawn_function("thrasher", &namespace_4329c852::function_eb999617);
    level.var_978978e9 = [];
    level thread namespace_4329c852::function_2f3aacf4();
}

// Namespace namespace_88aa1b1a
// Params 0, eflags: 0x2
// Checksum 0x19bf02cf, Offset: 0x8d0
// Size: 0x18a
function autoexec precache() {
    level._effect["fx_mech_foot_step"] = "dlc1/castle/fx_mech_foot_step";
    level._effect["fx_thrash_pustule_burst"] = "dlc2/island/fx_thrash_pustule_burst";
    level._effect["fx_thrash_pustule_spore_exp"] = "dlc2/island/fx_thrash_pustule_spore_exp";
    level._effect["fx_thrash_pustule_impact"] = "dlc2/island/fx_thrash_pustule_impact";
    level._effect["fx_thrash_eye_glow"] = "dlc2/island/fx_thrash_eye_glow";
    level._effect["fx_thrash_eye_glow_rage"] = "dlc2/island/fx_thrash_eye_glow_rage";
    level._effect["fx_thrash_rage_gas_torso"] = "dlc2/island/fx_thrash_rage_gas_torso";
    level._effect["fx_thrash_rage_gas_leg_lft"] = "dlc2/island/fx_thrash_rage_gas_leg_lft";
    level._effect["fx_thrash_rage_gas_leg_rgt"] = "dlc2/island/fx_thrash_rage_gas_leg_rgt";
    level._effect["fx_thrash_pustule_reinflate"] = "dlc2/island/fx_thrash_pustule_reinflate";
    level._effect["fx_spores_cloud_ambient_sm"] = "dlc2/island/fx_spores_cloud_ambient_sm";
    level._effect["fx_spores_cloud_ambient_md"] = "dlc2/island/fx_spores_cloud_ambient_md";
    level._effect["fx_spores_cloud_ambient_lrg"] = "dlc2/island/fx_thrash_pustule_reinflate";
    level._effect["fx_thrash_chest_mouth_drool"] = "dlc2/island/fx_thrash_chest_mouth_drool_1p";
}

#namespace namespace_4329c852;

// Namespace namespace_4329c852
// Params 1, eflags: 0x5 linked
// Checksum 0x7cea4e7f, Offset: 0xa68
// Size: 0x7c
function private function_eb999617(localclientnum) {
    entity = self;
    entity.ignoreragdoll = 1;
    level._footstepcbfuncs[entity.archetype] = &function_5bcd6fbb;
    gibclientutils::addgibcallback(localclientnum, entity, 4, &function_1ce9e0de);
}

// Namespace namespace_4329c852
// Params 0, eflags: 0x5 linked
// Checksum 0xe3631728, Offset: 0xaf0
// Size: 0x128
function private function_2f3aacf4() {
    while (true) {
        var_1dec125a = level.var_978978e9;
        level.var_978978e9 = [];
        time = gettime();
        foreach (var_92a6e9bb in var_1dec125a) {
            if (var_92a6e9bb.endtime <= time) {
                if (isdefined(var_92a6e9bb.fx)) {
                    stopfx(var_92a6e9bb.localclientnum, var_92a6e9bb.fx);
                }
                continue;
            }
            level.var_978978e9[level.var_978978e9.size] = var_92a6e9bb;
        }
        wait(0.5);
    }
}

// Namespace namespace_4329c852
// Params 5, eflags: 0x1 linked
// Checksum 0x15b8197d, Offset: 0xc20
// Size: 0x24c
function function_5bcd6fbb(localclientnum, pos, surface, notetrack, bone) {
    e_player = getlocalplayer(localclientnum);
    n_dist = distancesquared(pos, e_player.origin);
    var_3bf61fba = 1000000;
    if (var_3bf61fba <= 0) {
        return;
    }
    n_scale = (var_3bf61fba - n_dist) / var_3bf61fba;
    if (n_scale > 1 || n_scale < 0 || n_scale <= 0.01) {
        return;
    }
    fx = playfxontag(localclientnum, level._effect["fx_mech_foot_step"], self, bone);
    if (isdefined(e_player.var_4b1c8960) && e_player.var_4b1c8960 + 400 > gettime()) {
        return;
    }
    var_b8c8da0d = n_scale * 0.1;
    if (var_b8c8da0d > 0.01) {
        e_player earthquake(var_b8c8da0d, 0.1, pos, n_dist);
    }
    if (n_scale <= 1 && n_scale > 0.8) {
        e_player playrumbleonentity(localclientnum, "damage_heavy");
    } else if (n_scale <= 0.8 && n_scale > 0.4) {
        e_player playrumbleonentity(localclientnum, "reload_small");
    }
    e_player.var_4b1c8960 = gettime();
}

// Namespace namespace_4329c852
// Params 2, eflags: 0x5 linked
// Checksum 0x83a90997, Offset: 0xe78
// Size: 0x3c
function private function_f67a63e2(localclientnum, effect) {
    if (isdefined(effect)) {
        stopfx(localclientnum, effect);
    }
}

// Namespace namespace_4329c852
// Params 7, eflags: 0x5 linked
// Checksum 0xf7490221, Offset: 0xec0
// Size: 0x12c
function private function_6291f979(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (!isdefined(entity) || entity.archetype !== "thrasher" || !entity hasdobj(localclientnum)) {
        return;
    }
    localplayer = getlocalplayer(localclientnum);
    var_4445a6df = localplayer getentitynumber();
    var_9e4e9e56 = 1 << var_4445a6df;
    if (var_9e4e9e56 & newvalue) {
        entity hide();
        return;
    }
    entity show();
}

// Namespace namespace_4329c852
// Params 7, eflags: 0x5 linked
// Checksum 0x13de531f, Offset: 0xff8
// Size: 0x302
function private function_d5c67375(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    if (!isdefined(entity) || entity.archetype !== "thrasher" || !entity hasdobj(localclientnum)) {
        return;
    }
    function_f67a63e2(localclientnum, entity.var_20e3b3f6);
    entity.var_20e3b3f6 = undefined;
    function_f67a63e2(localclientnum, entity.var_24168e35);
    entity.var_24168e35 = undefined;
    function_f67a63e2(localclientnum, entity.var_4a19089e);
    entity.var_4a19089e = undefined;
    function_f67a63e2(localclientnum, entity.var_701b8307);
    entity.var_701b8307 = undefined;
    var_a4da98a1 = !gibclientutils::isgibbed(localclientnum, entity, 4);
    switch (newvalue) {
    case 0:
        if (var_a4da98a1) {
            entity.var_20e3b3f6 = playfxontag(localclientnum, level._effect["fx_thrash_eye_glow"], entity, "j_eyeball_le");
        }
        break;
    case 1:
        if (var_a4da98a1) {
            entity.var_20e3b3f6 = playfxontag(localclientnum, level._effect["fx_thrash_eye_glow_rage"], entity, "j_eyeball_le");
        }
        entity.var_24168e35 = playfxontag(localclientnum, level._effect["fx_thrash_rage_gas_torso"], entity, "j_spinelower");
        entity.var_4a19089e = playfxontag(localclientnum, level._effect["fx_thrash_rage_gas_leg_lft"], entity, "j_hip_le");
        entity.var_701b8307 = playfxontag(localclientnum, level._effect["fx_thrash_rage_gas_leg_rgt"], entity, "j_hip_ri");
        break;
    }
}

// Namespace namespace_4329c852
// Params 7, eflags: 0x5 linked
// Checksum 0xd3bb5bb1, Offset: 0x1308
// Size: 0x370
function private function_15e61dc(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    var_dc3c7a86 = array(1, 2, 4);
    var_f9d13adf = array("tag_spore_chest", "tag_spore_back", "tag_spore_leg");
    var_d298bb2a = (oldvalue ^ newvalue) & ~oldvalue;
    var_759cb721 = (oldvalue ^ newvalue) & ~newvalue;
    var_246ada07 = var_dc3c7a86[0];
    for (index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
        var_4d368c9c = var_f9d13adf[index];
        var_bbffa533 = undefined;
        if (var_d298bb2a & var_246ada07) {
            playfxontag(localclientnum, level._effect["fx_thrash_pustule_burst"], entity, var_4d368c9c);
            playfxontag(localclientnum, level._effect["fx_thrash_pustule_spore_exp"], entity, var_4d368c9c);
            var_bbffa533 = spawnstruct();
            var_bbffa533.length = 5000;
            if (!(isdefined(level.var_ad621bee) && level.var_ad621bee)) {
                var_bbffa533.fx = playfx(localclientnum, level._effect["fx_spores_cloud_ambient_md"], entity gettagorigin(var_4d368c9c));
            }
        } else if (var_759cb721 & var_246ada07) {
            var_bbffa533 = spawnstruct();
            var_bbffa533.length = 2000;
            var_bbffa533.fx = playfxontag(localclientnum, level._effect["fx_thrash_pustule_reinflate"], entity, var_4d368c9c);
        }
        if (isdefined(var_bbffa533)) {
            var_bbffa533.localclientnum = localclientnum;
            var_bbffa533.starttime = gettime();
            var_bbffa533.endtime = var_bbffa533.starttime + var_bbffa533.length;
            level.var_978978e9[level.var_978978e9.size] = var_bbffa533;
        }
        var_246ada07 <<= 1;
    }
}

// Namespace namespace_4329c852
// Params 7, eflags: 0x5 linked
// Checksum 0x6754384, Offset: 0x1680
// Size: 0x184
function private function_4b871d5b(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    entity = self;
    var_4d368c9c = undefined;
    var_dc3c7a86 = array(1, 2, 4);
    assert(var_dc3c7a86.size == array("sndPlayerConsumed", "sndPlayerConsumed", "sndPlayerConsumed").size);
    for (index = 0; index < var_dc3c7a86.size; index++) {
        if (fieldname == "thrasher_spore_impact" + var_dc3c7a86[index]) {
            var_4d368c9c = array("tag_spore_chest", "tag_spore_back", "tag_spore_leg")[index];
            break;
        }
    }
    if (isdefined(var_4d368c9c)) {
        playfxontag(localclientnum, level._effect["fx_thrash_pustule_impact"], entity, var_4d368c9c);
    }
}

// Namespace namespace_4329c852
// Params 3, eflags: 0x5 linked
// Checksum 0xd48cd263, Offset: 0x1810
// Size: 0x92
function private function_1ce9e0de(localclientnum, entity, gibflag) {
    if (!isdefined(entity) || entity.archetype !== "thrasher" || !entity hasdobj(localclientnum)) {
        return;
    }
    function_f67a63e2(localclientnum, entity.var_20e3b3f6);
    entity.var_20e3b3f6 = undefined;
}

// Namespace namespace_4329c852
// Params 7, eflags: 0x5 linked
// Checksum 0x10d145c6, Offset: 0x18b0
// Size: 0x1dc
function private function_358dc87b(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        if (!isdefined(self.var_e7618574)) {
            self.var_e7618574 = self playloopsound("zmb_thrasher_consumed_lp", 5);
        }
        if (!isdefined(self.var_e6870c37)) {
            self.var_e6870c37 = playfxoncamera(localclientnum, level._effect["fx_thrash_chest_mouth_drool"]);
        }
        self thread postfx::playpostfxbundle("pstfx_thrasher_stomach");
        enablespeedblur(localclientnum, 0.07, 0.55, 0.9, 0, 100, 100);
        return;
    }
    if (isdefined(self.var_e7618574)) {
        self stoploopsound(self.var_e7618574, 0.5);
        self.var_e7618574 = undefined;
    }
    if (isdefined(self.var_e6870c37)) {
        stopfx(localclientnum, self.var_e6870c37);
        self.var_e6870c37 = undefined;
    }
    self stopallloopsounds(1);
    if (isdefined(self.playingpostfxbundle)) {
        self thread postfx::function_9493d991();
    }
    disablespeedblur(localclientnum);
}

