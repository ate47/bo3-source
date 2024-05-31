#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/callbacks_shared;

#namespace fx;

// Namespace fx
// Params 0, eflags: 0x2
// namespace_5753664b<file_0>::function_2dc19561
// Checksum 0xe214437b, Offset: 0x150
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("fx", &__init__, undefined, undefined);
}

// Namespace fx
// Params 0, eflags: 0x1 linked
// namespace_5753664b<file_0>::function_8c87d8eb
// Checksum 0x99ec1590, Offset: 0x190
// Size: 0x4
function __init__() {
    
}

// Namespace fx
// Params 0, eflags: 0x0
// namespace_5753664b<file_0>::function_c35ee410
// Checksum 0x2c0a4ab, Offset: 0x1a0
// Size: 0x76
function set_forward_and_up_vectors() {
    self.v["up"] = anglestoup(self.v["angles"]);
    self.v["forward"] = anglestoforward(self.v["angles"]);
}

// Namespace fx
// Params 1, eflags: 0x1 linked
// namespace_5753664b<file_0>::function_7922262b
// Checksum 0x3c47be68, Offset: 0x220
// Size: 0x50
function get(fx) {
    assert(isdefined(level._effect[fx]), "loopfx" + fx + "loopfx");
    return level._effect[fx];
}

// Namespace fx
// Params 2, eflags: 0x1 linked
// namespace_5753664b<file_0>::function_7d0acaab
// Checksum 0xb1486a1f, Offset: 0x278
// Size: 0x144
function create_effect(type, fxid) {
    ent = undefined;
    if (!isdefined(level.createfxent)) {
        level.createfxent = [];
    }
    if (type == "exploder") {
        ent = spawnstruct();
    } else {
        if (!isdefined(level._fake_createfx_struct)) {
            level._fake_createfx_struct = spawnstruct();
        }
        ent = level._fake_createfx_struct;
    }
    level.createfxent[level.createfxent.size] = ent;
    ent.v = [];
    ent.v["type"] = type;
    ent.v["fxid"] = fxid;
    ent.v["angles"] = (0, 0, 0);
    ent.v["origin"] = (0, 0, 0);
    ent.drawn = 1;
    return ent;
}

// Namespace fx
// Params 1, eflags: 0x0
// namespace_5753664b<file_0>::function_61b8d93a
// Checksum 0xfa974de, Offset: 0x3c8
// Size: 0x5a
function create_loop_effect(fxid) {
    ent = create_effect("loopfx", fxid);
    ent.v["delay"] = 0.5;
    return ent;
}

// Namespace fx
// Params 1, eflags: 0x0
// namespace_5753664b<file_0>::function_b7152400
// Checksum 0xfe0a3f2f, Offset: 0x430
// Size: 0x56
function create_oneshot_effect(fxid) {
    ent = create_effect("oneshotfx", fxid);
    ent.v["delay"] = -15;
    return ent;
}

// Namespace fx
// Params 8, eflags: 0x1 linked
// namespace_5753664b<file_0>::function_43718187
// Checksum 0xc94b3312, Offset: 0x490
// Size: 0x294
function play(str_fx, v_origin, v_angles, time_to_delete_or_notify, b_link_to_self, str_tag, b_no_cull, b_ignore_pause_world) {
    if (!isdefined(v_origin)) {
        v_origin = (0, 0, 0);
    }
    if (!isdefined(v_angles)) {
        v_angles = (0, 0, 0);
    }
    if (!isdefined(b_link_to_self)) {
        b_link_to_self = 0;
    }
    self notify(str_fx);
    if (isdefined(b_link_to_self) && !isstring(time_to_delete_or_notify) && (!isdefined(time_to_delete_or_notify) || time_to_delete_or_notify == -1) && b_link_to_self && isdefined(str_tag)) {
        playfxontag(get(str_fx), self, str_tag, b_ignore_pause_world);
        return self;
    }
    if (isdefined(time_to_delete_or_notify)) {
        m_fx = util::spawn_model("tag_origin", v_origin, v_angles);
        if (isdefined(b_link_to_self) && b_link_to_self) {
            if (isdefined(str_tag)) {
                m_fx linkto(self, str_tag, (0, 0, 0), (0, 0, 0));
            } else {
                m_fx linkto(self);
            }
        }
        if (isdefined(b_no_cull) && b_no_cull) {
            m_fx setforcenocull();
        }
        playfxontag(get(str_fx), m_fx, "tag_origin", b_ignore_pause_world);
        m_fx thread _play_fx_delete(self, time_to_delete_or_notify);
        return m_fx;
    }
    playfx(get(str_fx), v_origin, anglestoforward(v_angles), anglestoup(v_angles), b_ignore_pause_world);
}

// Namespace fx
// Params 2, eflags: 0x1 linked
// namespace_5753664b<file_0>::function_a2f5bd7f
// Checksum 0x37468010, Offset: 0x730
// Size: 0xbc
function _play_fx_delete(ent, time_to_delete_or_notify) {
    if (!isdefined(time_to_delete_or_notify)) {
        time_to_delete_or_notify = -1;
    }
    if (isstring(time_to_delete_or_notify)) {
        ent util::waittill_either("death", time_to_delete_or_notify);
    } else if (time_to_delete_or_notify > 0) {
        ent util::waittill_any_timeout(time_to_delete_or_notify, "death");
    } else {
        ent waittill(#"death");
    }
    if (isdefined(self)) {
        self delete();
    }
}

