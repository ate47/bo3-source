#using scripts/shared/callbacks_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace burnplayer;

// Namespace burnplayer
// Params 0, eflags: 0x2
// Checksum 0x2c5a3fb8, Offset: 0x5c8
// Size: 0x34
function function_2dc19561() {
    system::register("burnplayer", &__init__, undefined, undefined);
}

// Namespace burnplayer
// Params 0, eflags: 0x1 linked
// Checksum 0x2aacd918, Offset: 0x608
// Size: 0xe4
function __init__() {
    clientfield::register("allplayers", "burn", 1, 1, "int", &burning_callback, 0, 0);
    clientfield::register("playercorpse", "burned_effect", 1, 1, "int", &burning_corpse_callback, 0, 1);
    loadeffects();
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    callback::on_localclient_connect(&on_local_client_connect);
}

// Namespace burnplayer
// Params 0, eflags: 0x1 linked
// Checksum 0x823e30cc, Offset: 0x6f8
// Size: 0x2a4
function loadeffects() {
    level._effect["burn_j_elbow_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop";
    level._effect["burn_j_elbow_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop";
    level._effect["burn_j_shoulder_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop";
    level._effect["burn_j_shoulder_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop";
    level._effect["burn_j_spine4_loop"] = "fire/fx_fire_ai_human_torso_loop";
    level._effect["burn_j_hip_le_loop"] = "fire/fx_fire_ai_human_hip_left_loop";
    level._effect["burn_j_hip_ri_loop"] = "fire/fx_fire_ai_human_hip_right_loop";
    level._effect["burn_j_knee_le_loop"] = "fire/fx_fire_ai_human_leg_left_loop";
    level._effect["burn_j_knee_ri_loop"] = "fire/fx_fire_ai_human_leg_right_loop";
    level._effect["burn_j_head_loop"] = "fire/fx_fire_ai_human_head_loop";
    level._effect["burn_j_elbow_le_os"] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect["burn_j_elbow_ri_os"] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect["burn_j_shoulder_le_os"] = "fire/fx_fire_ai_human_arm_left_os";
    level._effect["burn_j_shoulder_ri_os"] = "fire/fx_fire_ai_human_arm_right_os";
    level._effect["burn_j_spine4_os"] = "fire/fx_fire_ai_human_torso_os";
    level._effect["burn_j_hip_le_os"] = "fire/fx_fire_ai_human_hip_left_os";
    level._effect["burn_j_hip_ri_os"] = "fire/fx_fire_ai_human_hip_right_os";
    level._effect["burn_j_knee_le_os"] = "fire/fx_fire_ai_human_leg_left_os";
    level._effect["burn_j_knee_ri_os"] = "fire/fx_fire_ai_human_leg_right_os";
    level._effect["burn_j_head_os"] = "fire/fx_fire_ai_human_head_os";
    level.burntags = array("j_elbow_le", "j_elbow_ri", "j_shoulder_le", "j_shoulder_ri", "j_spine4", "j_spinelower", "j_hip_le", "j_hip_ri", "j_head", "j_knee_le", "j_knee_ri");
}

// Namespace burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0x86c9b965, Offset: 0x9a8
// Size: 0x19c
function on_local_client_connect(localclientnum) {
    registerrewindfx(localclientnum, level._effect["burn_j_elbow_le_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_elbow_ri_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_shoulder_le_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_shoulder_ri_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_spine4_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_hip_le_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_hip_ri_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_knee_le_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_knee_ri_loop"]);
    registerrewindfx(localclientnum, level._effect["burn_j_head_loop"]);
}

// Namespace burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0x176a723c, Offset: 0xb50
// Size: 0xc
function on_localplayer_spawned(localclientnum) {
    
}

// Namespace burnplayer
// Params 7, eflags: 0x1 linked
// Checksum 0x116d6dd1, Offset: 0xb68
// Size: 0x7c
function burning_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_4c9baeb2(localclientnum);
        return;
    }
    self burn_off(localclientnum);
}

// Namespace burnplayer
// Params 7, eflags: 0x1 linked
// Checksum 0xd842abad, Offset: 0xbf0
// Size: 0x7c
function burning_corpse_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self set_corpse_burning(localclientnum);
        return;
    }
    self burn_off(localclientnum);
}

// Namespace burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0x7dd0ecea, Offset: 0xc78
// Size: 0x24
function set_corpse_burning(localclientnum) {
    self thread _burnbody(localclientnum);
}

// Namespace burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0x7139d5a5, Offset: 0xca8
// Size: 0x4c
function burn_off(localclientnum) {
    self notify(#"burn_off");
    if (getlocalplayer(localclientnum) == self) {
        self postfx::exitpostfxbundle();
    }
}

// Namespace burnplayer
// Params 1, eflags: 0x1 linked
// Checksum 0xf0906393, Offset: 0xd00
// Size: 0xac
function function_4c9baeb2(localclientnum) {
    if (getlocalplayer(localclientnum) != self || isthirdperson(localclientnum)) {
        self thread _burnbody(localclientnum);
    }
    if (getlocalplayer(localclientnum) == self && !isthirdperson(localclientnum)) {
        self thread burn_on_postfx();
    }
}

// Namespace burnplayer
// Params 0, eflags: 0x1 linked
// Checksum 0xef32489e, Offset: 0xdb8
// Size: 0x5c
function burn_on_postfx() {
    self endon(#"entityshutdown");
    self endon(#"burn_off");
    self endon(#"death");
    self notify(#"burn_on_postfx");
    self endon(#"burn_on_postfx");
    self thread postfx::playpostfxbundle("pstfx_burn_loop");
}

// Namespace burnplayer
// Params 3, eflags: 0x5 linked
// Checksum 0x4ca29fa9, Offset: 0xe20
// Size: 0x9c
function _burntag(localclientnum, tag, postfix) {
    if (isdefined(self) && self hasdobj(localclientnum)) {
        fxname = "burn_" + tag + postfix;
        if (isdefined(level._effect[fxname])) {
            return playfxontag(localclientnum, level._effect[fxname], self, tag);
        }
    }
}

// Namespace burnplayer
// Params 2, eflags: 0x5 linked
// Checksum 0x4d43a99b, Offset: 0xec8
// Size: 0x12c
function _burntagson(localclientnum, tags) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"entityshutdown");
    self endon(#"burn_off");
    self notify(#"burn_tags_on");
    self endon(#"burn_tags_on");
    activefx = [];
    for (i = 0; i < tags.size; i++) {
        activefx[activefx.size] = self _burntag(localclientnum, tags[i], "_loop");
    }
    burnsound = self playloopsound("chr_burn_loop_overlay", 0.5);
    self thread _burntagswatchend(localclientnum, activefx, burnsound);
    self thread _burntagswatchclear(localclientnum, activefx, burnsound);
}

// Namespace burnplayer
// Params 1, eflags: 0x5 linked
// Checksum 0xdde1af08, Offset: 0x1000
// Size: 0x34
function _burnbody(localclientnum) {
    self endon(#"entityshutdown");
    self thread _burntagson(localclientnum, level.burntags);
}

// Namespace burnplayer
// Params 3, eflags: 0x5 linked
// Checksum 0xf6f2bf4c, Offset: 0x1040
// Size: 0xf2
function _burntagswatchend(localclientnum, fxarray, burnsound) {
    self endon(#"entityshutdown");
    self waittill(#"burn_off");
    if (isdefined(burnsound)) {
        self stoploopsound(burnsound, 1);
    }
    if (isdefined(fxarray)) {
        foreach (fx in fxarray) {
            stopfx(localclientnum, fx);
        }
    }
}

// Namespace burnplayer
// Params 3, eflags: 0x5 linked
// Checksum 0xac4de82a, Offset: 0x1140
// Size: 0xea
function _burntagswatchclear(localclientnum, fxarray, burnsound) {
    self endon(#"burn_off");
    self waittill(#"entityshutdown");
    if (isdefined(burnsound)) {
        stopsound(burnsound);
    }
    if (isdefined(fxarray)) {
        foreach (fx in fxarray) {
            stopfx(localclientnum, fx);
        }
    }
}

