#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;

#namespace visionset_mgr;

// Namespace visionset_mgr
// Params 0, eflags: 0x2
// Checksum 0xd66fdc7f, Offset: 0x330
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("visionset_mgr", &__init__, undefined, undefined);
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0x86e7be4d, Offset: 0x370
// Size: 0x16c
function __init__() {
    level.vsmgr_initializing = 1;
    level.vsmgr_default_info_name = "__none";
    level.vsmgr = [];
    level.vsmgr_states_inited = [];
    level.vsmgr_filter_custom_enable = [];
    level.vsmgr_filter_custom_disable = [];
    level thread register_type("visionset", &visionset_slot_cb, &visionset_lerp_cb, &visionset_update_cb);
    register_visionset_info(level.vsmgr_default_info_name, 1, 1, "undefined", "undefined");
    level thread register_type("overlay", &overlay_slot_cb, &overlay_lerp_cb, &overlay_update_cb);
    register_overlay_info_style_none(level.vsmgr_default_info_name, 1, 1);
    callback::on_finalize_initialization(&finalize_initialization);
    level thread monitor();
}

// Namespace visionset_mgr
// Params 6, eflags: 0x1 linked
// Checksum 0x77ab809e, Offset: 0x4e8
// Size: 0x100
function register_visionset_info(name, version, lerp_step_count, visionset_from, visionset_to, visionset_type) {
    if (!isdefined(visionset_type)) {
        visionset_type = 0;
    }
    if (!register_info("visionset", name, version, lerp_step_count)) {
        return;
    }
    level.vsmgr["visionset"].info[name].visionset_from = visionset_from;
    level.vsmgr["visionset"].info[name].visionset_to = visionset_to;
    level.vsmgr["visionset"].info[name].visionset_type = visionset_type;
}

// Namespace visionset_mgr
// Params 3, eflags: 0x1 linked
// Checksum 0x9291b44e, Offset: 0x5f0
// Size: 0x78
function register_overlay_info_style_none(name, version, lerp_step_count) {
    if (!register_info("overlay", name, version, lerp_step_count)) {
        return;
    }
    level.vsmgr["overlay"].info[name].style = 0;
}

// Namespace visionset_mgr
// Params 7, eflags: 0x0
// Checksum 0xcc96a556, Offset: 0x670
// Size: 0x158
function register_overlay_info_style_filter(name, version, lerp_step_count, filter_index, pass_index, material_name, constant_index) {
    if (!register_info("overlay", name, version, lerp_step_count)) {
        return;
    }
    level.vsmgr["overlay"].info[name].style = 2;
    level.vsmgr["overlay"].info[name].filter_index = filter_index;
    level.vsmgr["overlay"].info[name].pass_index = pass_index;
    level.vsmgr["overlay"].info[name].material_name = material_name;
    level.vsmgr["overlay"].info[name].constant_index = constant_index;
}

// Namespace visionset_mgr
// Params 6, eflags: 0x1 linked
// Checksum 0x4a2a223a, Offset: 0x7d0
// Size: 0x120
function register_overlay_info_style_blur(name, version, lerp_step_count, transition_in, transition_out, magnitude) {
    if (!register_info("overlay", name, version, lerp_step_count)) {
        return;
    }
    level.vsmgr["overlay"].info[name].style = 3;
    level.vsmgr["overlay"].info[name].transition_in = transition_in;
    level.vsmgr["overlay"].info[name].transition_out = transition_out;
    level.vsmgr["overlay"].info[name].magnitude = magnitude;
}

// Namespace visionset_mgr
// Params 4, eflags: 0x1 linked
// Checksum 0xc4493ff4, Offset: 0x8f8
// Size: 0xb0
function register_overlay_info_style_electrified(name, version, lerp_step_count, duration) {
    if (!register_info("overlay", name, version, lerp_step_count)) {
        return;
    }
    level.vsmgr["overlay"].info[name].style = 4;
    level.vsmgr["overlay"].info[name].duration = duration;
}

// Namespace visionset_mgr
// Params 4, eflags: 0x1 linked
// Checksum 0xd6c38d2, Offset: 0x9b0
// Size: 0xb0
function register_overlay_info_style_burn(name, version, lerp_step_count, duration) {
    if (!register_info("overlay", name, version, lerp_step_count)) {
        return;
    }
    level.vsmgr["overlay"].info[name].style = 5;
    level.vsmgr["overlay"].info[name].duration = duration;
}

// Namespace visionset_mgr
// Params 3, eflags: 0x0
// Checksum 0x7c740b03, Offset: 0xa68
// Size: 0x78
function register_overlay_info_style_poison(name, version, lerp_step_count) {
    if (!register_info("overlay", name, version, lerp_step_count)) {
        return;
    }
    level.vsmgr["overlay"].info[name].style = 6;
}

// Namespace visionset_mgr
// Params 4, eflags: 0x1 linked
// Checksum 0xffe5a215, Offset: 0xae8
// Size: 0xb0
function register_overlay_info_style_transported(name, version, lerp_step_count, duration) {
    if (!register_info("overlay", name, version, lerp_step_count)) {
        return;
    }
    level.vsmgr["overlay"].info[name].style = 7;
    level.vsmgr["overlay"].info[name].duration = duration;
}

// Namespace visionset_mgr
// Params 11, eflags: 0x1 linked
// Checksum 0xeaff77c2, Offset: 0xba0
// Size: 0x238
function register_overlay_info_style_speed_blur(name, version, lerp_step_count, amount, inner_radius, outer_radius, velocity_should_scale, velocity_scale, blur_in, blur_out, should_offset) {
    if (!register_info("overlay", name, version, lerp_step_count)) {
        return;
    }
    level.vsmgr["overlay"].info[name].style = 8;
    level.vsmgr["overlay"].info[name].amount = amount;
    level.vsmgr["overlay"].info[name].inner_radius = inner_radius;
    level.vsmgr["overlay"].info[name].outer_radius = outer_radius;
    level.vsmgr["overlay"].info[name].velocity_should_scale = velocity_should_scale;
    level.vsmgr["overlay"].info[name].velocity_scale = velocity_scale;
    level.vsmgr["overlay"].info[name].blur_in = blur_in;
    level.vsmgr["overlay"].info[name].blur_out = blur_out;
    level.vsmgr["overlay"].info[name].should_offset = should_offset;
}

// Namespace visionset_mgr
// Params 5, eflags: 0x1 linked
// Checksum 0xb9c67364, Offset: 0xde0
// Size: 0xe8
function register_overlay_info_style_postfx_bundle(name, version, lerp_step_count, bundle, duration) {
    if (!register_info("overlay", name, version, lerp_step_count)) {
        return;
    }
    level.vsmgr["overlay"].info[name].style = 1;
    level.vsmgr["overlay"].info[name].bundle = bundle;
    level.vsmgr["overlay"].info[name].duration = duration;
}

// Namespace visionset_mgr
// Params 2, eflags: 0x1 linked
// Checksum 0x7ee1367f, Offset: 0xed0
// Size: 0xa0
function is_type_currently_default(localclientnum, type) {
    if (!level.vsmgr[type].in_use) {
        return true;
    }
    state = get_state(localclientnum, type);
    curr_info = get_info(type, state.curr_slot);
    return curr_info.name == level.vsmgr_default_info_name;
}

// Namespace visionset_mgr
// Params 4, eflags: 0x1 linked
// Checksum 0x29a99c9a, Offset: 0xf78
// Size: 0x198
function register_type(type, cf_slot_cb, cf_lerp_cb, update_cb) {
    level.vsmgr[type] = spawnstruct();
    level.vsmgr[type].type = type;
    level.vsmgr[type].in_use = 0;
    level.vsmgr[type].highest_version = 0;
    level.vsmgr[type].server_version = getserverhighestclientfieldversion();
    level.vsmgr[type].cf_slot_name = type + "_slot";
    level.vsmgr[type].cf_lerp_name = type + "_lerp";
    level.vsmgr[type].cf_slot_cb = cf_slot_cb;
    level.vsmgr[type].cf_lerp_cb = cf_lerp_cb;
    level.vsmgr[type].update_cb = update_cb;
    level.vsmgr[type].info = [];
    level.vsmgr[type].sorted_name_keys = [];
}

// Namespace visionset_mgr
// Params 1, eflags: 0x1 linked
// Checksum 0x2d0c7d48, Offset: 0x1118
// Size: 0x7c
function finalize_initialization(localclientnum) {
    thread finalize_clientfields();
    if (!isdefined(level.var_bc3b1eb4)) {
        function_980ca37e(getdvarstring("mapname"), 0);
        function_3aea3c1a(0, getdvarstring("mapname"));
    }
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0xcfd81463, Offset: 0x11a0
// Size: 0x80
function finalize_clientfields() {
    typekeys = getarraykeys(level.vsmgr);
    for (type_index = 0; type_index < typekeys.size; type_index++) {
        level.vsmgr[typekeys[type_index]] thread finalize_type_clientfields();
    }
    level.vsmgr_initializing = 0;
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0xd9b11d58, Offset: 0x1228
// Size: 0x284
function finalize_type_clientfields() {
    println("int" + self.type + "int");
    if (1 >= self.info.size) {
        return;
    }
    self.in_use = 1;
    self.cf_slot_bit_count = getminbitcountfornum(self.info.size - 1);
    self.cf_lerp_bit_count = self.info[self.sorted_name_keys[0]].lerp_bit_count;
    for (i = 0; i < self.sorted_name_keys.size; i++) {
        self.info[self.sorted_name_keys[i]].slot_index = i;
        if (self.info[self.sorted_name_keys[i]].lerp_bit_count > self.cf_lerp_bit_count) {
            self.cf_lerp_bit_count = self.info[self.sorted_name_keys[i]].lerp_bit_count;
        }
        println("int" + self.info[self.sorted_name_keys[i]].name + "int" + self.info[self.sorted_name_keys[i]].version + "int" + self.info[self.sorted_name_keys[i]].lerp_step_count + "int");
    }
    clientfield::register("toplayer", self.cf_slot_name, self.highest_version, self.cf_slot_bit_count, "int", self.cf_slot_cb, 0, 1);
    if (1 < self.cf_lerp_bit_count) {
        clientfield::register("toplayer", self.cf_lerp_name, self.highest_version, self.cf_lerp_bit_count, "float", self.cf_lerp_cb, 0, 1);
    }
}

// Namespace visionset_mgr
// Params 3, eflags: 0x1 linked
// Checksum 0xdd9bcdd1, Offset: 0x14b8
// Size: 0x188
function validate_info(type, name, version) {
    keys = getarraykeys(level.vsmgr);
    for (i = 0; i < keys.size; i++) {
        if (type == keys[i]) {
            break;
        }
    }
    assert(i < keys.size, "int" + type + "int");
    if (version > level.vsmgr[type].server_version) {
        return false;
    }
    if (isdefined(level.vsmgr[type].info[name]) && version < level.vsmgr[type].info[name].version) {
        if (version < level.vsmgr[type].info[name].version) {
            return false;
        }
        level.vsmgr[type].info[name] = undefined;
    }
    return true;
}

// Namespace visionset_mgr
// Params 2, eflags: 0x1 linked
// Checksum 0x512c328f, Offset: 0x1648
// Size: 0xac
function add_sorted_name_key(type, name) {
    for (i = 0; i < level.vsmgr[type].sorted_name_keys.size; i++) {
        if (name < level.vsmgr[type].sorted_name_keys[i]) {
            break;
        }
    }
    arrayinsert(level.vsmgr[type].sorted_name_keys, name, i);
}

// Namespace visionset_mgr
// Params 4, eflags: 0x1 linked
// Checksum 0x601349b, Offset: 0x1700
// Size: 0x74
function add_info(type, name, version, lerp_step_count) {
    self.type = type;
    self.name = name;
    self.version = version;
    self.lerp_step_count = lerp_step_count;
    self.lerp_bit_count = getminbitcountfornum(lerp_step_count);
}

// Namespace visionset_mgr
// Params 4, eflags: 0x1 linked
// Checksum 0xb1f5caff, Offset: 0x1780
// Size: 0x15c
function register_info(type, name, version, lerp_step_count) {
    assert(level.vsmgr_initializing, "int");
    lower_name = tolower(name);
    if (!validate_info(type, lower_name, version)) {
        return false;
    }
    add_sorted_name_key(type, lower_name);
    level.vsmgr[type].info[lower_name] = spawnstruct();
    level.vsmgr[type].info[lower_name] add_info(type, lower_name, version, lerp_step_count);
    if (version > level.vsmgr[type].highest_version) {
        level.vsmgr[type].highest_version = version;
    }
    return true;
}

// Namespace visionset_mgr
// Params 8, eflags: 0x1 linked
// Checksum 0xa10c27, Offset: 0x18e8
// Size: 0xc4
function slot_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, type) {
    init_states(localclientnum);
    level.vsmgr[type].state[localclientnum].curr_slot = newval;
    if (bnewent || binitialsnap) {
        level.vsmgr[type].state[localclientnum].force_update = 1;
    }
}

// Namespace visionset_mgr
// Params 7, eflags: 0x1 linked
// Checksum 0xf32a3314, Offset: 0x19b8
// Size: 0x74
function visionset_slot_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self slot_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, "visionset");
}

// Namespace visionset_mgr
// Params 7, eflags: 0x1 linked
// Checksum 0x69ce8f1a, Offset: 0x1a38
// Size: 0x74
function overlay_slot_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self slot_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, "overlay");
}

// Namespace visionset_mgr
// Params 8, eflags: 0x1 linked
// Checksum 0xd786db52, Offset: 0x1ab8
// Size: 0xc4
function lerp_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, type) {
    init_states(localclientnum);
    level.vsmgr[type].state[localclientnum].curr_lerp = newval;
    if (bnewent || binitialsnap) {
        level.vsmgr[type].state[localclientnum].force_update = 1;
    }
}

// Namespace visionset_mgr
// Params 7, eflags: 0x1 linked
// Checksum 0xfbdfde08, Offset: 0x1b88
// Size: 0x74
function visionset_lerp_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self lerp_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, "visionset");
}

// Namespace visionset_mgr
// Params 7, eflags: 0x1 linked
// Checksum 0xa5cfc324, Offset: 0x1c08
// Size: 0x74
function overlay_lerp_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self lerp_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump, "overlay");
}

// Namespace visionset_mgr
// Params 2, eflags: 0x1 linked
// Checksum 0x67246e78, Offset: 0x1c88
// Size: 0x48
function get_info(type, slot) {
    return level.vsmgr[type].info[level.vsmgr[type].sorted_name_keys[slot]];
}

// Namespace visionset_mgr
// Params 2, eflags: 0x1 linked
// Checksum 0x53a8f11f, Offset: 0x1cd8
// Size: 0x30
function get_state(localclientnum, type) {
    return level.vsmgr[type].state[localclientnum];
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0x3cbe7588, Offset: 0x1d10
// Size: 0x34
function should_update_state() {
    return self.force_update || self.prev_slot != self.curr_slot || self.prev_lerp != self.curr_lerp;
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0xa8090e35, Offset: 0x1d50
// Size: 0x30
function transition_state() {
    self.prev_slot = self.curr_slot;
    self.prev_lerp = self.curr_lerp;
    self.force_update = 0;
}

// Namespace visionset_mgr
// Params 1, eflags: 0x1 linked
// Checksum 0xe001f67f, Offset: 0x1d88
// Size: 0x256
function init_states(localclientnum) {
    if (isdefined(level.vsmgr_states_inited[localclientnum])) {
        return;
    }
    typekeys = getarraykeys(level.vsmgr);
    for (type_index = 0; type_index < typekeys.size; type_index++) {
        type = typekeys[type_index];
        if (!level.vsmgr[type].in_use) {
            continue;
        }
        if (!isdefined(level.vsmgr[type].state)) {
            level.vsmgr[type].state = [];
        }
        level.vsmgr[type].state[localclientnum] = spawnstruct();
        level.vsmgr[type].state[localclientnum].prev_slot = level.vsmgr[type].info[level.vsmgr_default_info_name].slot_index;
        level.vsmgr[type].state[localclientnum].curr_slot = level.vsmgr[type].info[level.vsmgr_default_info_name].slot_index;
        level.vsmgr[type].state[localclientnum].prev_lerp = 1;
        level.vsmgr[type].state[localclientnum].curr_lerp = 1;
        level.vsmgr[type].state[localclientnum].force_update = 0;
    }
    level.vsmgr_states_inited[localclientnum] = 1;
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0x520440c9, Offset: 0x1fe8
// Size: 0x10a
function demo_jump_monitor() {
    if (!level.isdemoplaying) {
        return;
    }
    typekeys = getarraykeys(level.vsmgr);
    oldlerps = [];
    while (true) {
        level util::waittill_any("demo_jump", "demo_player_switch", "visionset_mgr_reset");
        for (type_index = 0; type_index < typekeys.size; type_index++) {
            type = typekeys[type_index];
            if (!level.vsmgr[type].in_use) {
                continue;
            }
            level.vsmgr[type].state[0].force_update = 1;
        }
    }
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0xc5afc9e5, Offset: 0x2100
// Size: 0xdc
function demo_spectate_monitor() {
    if (!level.isdemoplaying) {
        return;
    }
    typekeys = getarraykeys(level.vsmgr);
    while (true) {
        if (isspectating(0, 0)) {
            if (!(isdefined(level.vsmgr_is_spectating) && level.vsmgr_is_spectating)) {
                function_8dbebd32(0);
                level notify(#"visionset_mgr_reset");
            }
            level.vsmgr_is_spectating = 1;
        } else {
            if (isdefined(level.vsmgr_is_spectating) && level.vsmgr_is_spectating) {
                level notify(#"visionset_mgr_reset");
            }
            level.vsmgr_is_spectating = 0;
        }
        wait(0.016);
    }
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0x4c8cb625, Offset: 0x21e8
// Size: 0x1d4
function monitor() {
    while (level.vsmgr_initializing) {
        wait(0.016);
    }
    if (isdefined(level.isdemoplaying) && level.isdemoplaying) {
        level thread demo_spectate_monitor();
        level thread demo_jump_monitor();
    }
    typekeys = getarraykeys(level.vsmgr);
    while (true) {
        for (type_index = 0; type_index < typekeys.size; type_index++) {
            type = typekeys[type_index];
            if (!level.vsmgr[type].in_use) {
                continue;
            }
            for (localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
                init_states(localclientnum);
                if (level.vsmgr[type].state[localclientnum] should_update_state()) {
                    level.vsmgr[type] thread [[ level.vsmgr[type].update_cb ]](localclientnum, type);
                    level.vsmgr[type].state[localclientnum] transition_state();
                }
            }
        }
        wait(0.016);
    }
}

// Namespace visionset_mgr
// Params 3, eflags: 0x1 linked
// Checksum 0x39cd7e95, Offset: 0x23c8
// Size: 0x50
function killcam_visionset_vehicle_mismatch(visionset_to, visionset_vehicle, vehicletype) {
    if (visionset_to == visionset_vehicle) {
        if (isdefined(self.vehicletype) && self.vehicletype != vehicletype) {
            return true;
        }
    }
    return false;
}

// Namespace visionset_mgr
// Params 2, eflags: 0x1 linked
// Checksum 0xe5fc4891, Offset: 0x2420
// Size: 0x3e
function killcam_visionset_player_mismatch(visionset_to, visionset_vehicle) {
    if (visionset_to == visionset_vehicle) {
        if (!self isplayer()) {
            return true;
        }
    }
    return false;
}

// Namespace visionset_mgr
// Params 2, eflags: 0x1 linked
// Checksum 0x59c625c4, Offset: 0x2468
// Size: 0x41c
function visionset_update_cb(localclientnum, type) {
    state = get_state(localclientnum, type);
    curr_info = get_info(type, state.curr_slot);
    prev_info = get_info(type, state.prev_slot);
    /#
    #/
    if (isdefined(level.isdemoplaying) && level.isdemoplaying && isspectating(localclientnum, 1)) {
        visionsetnaked(localclientnum, level.var_bc3b1eb4, 0);
        return;
    }
    if (level.vsmgr_default_info_name == curr_info.name) {
        function_8dbebd32(localclientnum);
        return;
    }
    player = getlocalplayer(localclientnum);
    if (player getinkillcam(localclientnum)) {
        if (isdefined(curr_info.visionset_to)) {
            killcament = player getkillcamentity(localclientnum);
            if (curr_info.visionset_to == "mp_vehicles_mothership") {
                if (killcament.type == "vehicle" && !killcament clientfield::get("mothership")) {
                    return;
                }
            }
            if (curr_info.visionset_to == "mp_vehicles_agr" || curr_info.visionset_to == "mp_hellstorm") {
                if (killcament.type == "vehicle") {
                    return;
                }
            }
            if (killcament killcam_visionset_vehicle_mismatch(curr_info.visionset_to, "mp_vehicles_dart", "veh_dart_mp")) {
                return;
            }
            if (killcament killcam_visionset_player_mismatch(curr_info.visionset_to, "mp_vehicles_turret")) {
                return;
            }
            if (killcament killcam_visionset_player_mismatch(curr_info.visionset_to, "mp_vehicles_sentinel")) {
                return;
            }
        }
    }
    if (!isdefined(curr_info.visionset_from)) {
        if (curr_info.visionset_type == 6) {
            visionsetlaststandlerp(localclientnum, curr_info.visionset_to, level._fv2vs_prev_visionsets[localclientnum], state.curr_lerp);
        } else {
            visionsetnakedlerp(localclientnum, curr_info.visionset_to, level._fv2vs_prev_visionsets[localclientnum], state.curr_lerp);
        }
        return;
    }
    if (curr_info.visionset_type == 6) {
        visionsetlaststandlerp(localclientnum, curr_info.visionset_to, curr_info.visionset_from, state.curr_lerp);
        return;
    }
    visionsetnakedlerp(localclientnum, curr_info.visionset_to, curr_info.visionset_from, state.curr_lerp);
}

// Namespace visionset_mgr
// Params 1, eflags: 0x1 linked
// Checksum 0xbfeeeeba, Offset: 0x2890
// Size: 0x12c
function set_poison_overlay(amount) {
    setdvar("r_poisonFX_debug_enable", 1);
    setdvar("r_poisonFX_pulse", 2);
    setdvar("r_poisonFX_warpX", -0.3);
    setdvar("r_poisonFX_warpY", 0.15);
    setdvar("r_poisonFX_dvisionA", 0);
    setdvar("r_poisonFX_dvisionX", 0);
    setdvar("r_poisonFX_dvisionY", 0);
    setdvar("r_poisonFX_blurMin", 0);
    setdvar("r_poisonFX_blurMax", 3);
    setdvar("r_poisonFX_debug_amount", amount);
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0xaa1de7fa, Offset: 0x29c8
// Size: 0x34
function clear_poison_overlay() {
    setdvar("r_poisonFX_debug_amount", 0);
    setdvar("r_poisonFX_debug_enable", 0);
}

// Namespace visionset_mgr
// Params 2, eflags: 0x1 linked
// Checksum 0xd6f3ef8b, Offset: 0x2a08
// Size: 0xa76
function overlay_update_cb(localclientnum, type) {
    state = get_state(localclientnum, type);
    curr_info = get_info(type, state.curr_slot);
    prev_info = get_info(type, state.prev_slot);
    player = level.localplayers[localclientnum];
    /#
    #/
    if (state.force_update || state.prev_slot != state.curr_slot) {
        switch (prev_info.style) {
        case 0:
            break;
        case 1:
            player thread postfx::exitpostfxbundle();
            break;
        case 2:
            if (isdefined(level.vsmgr_filter_custom_disable[curr_info.material_name])) {
                player [[ level.vsmgr_filter_custom_disable[curr_info.material_name] ]](state, prev_info, curr_info);
            } else {
                setfilterpassenabled(localclientnum, prev_info.filter_index, prev_info.pass_index, 0);
            }
            break;
        case 3:
            setblurbylocalclientnum(localclientnum, 0, prev_info.transition_out);
            break;
        case 4:
            setelectrified(localclientnum, 0);
            break;
        case 5:
            setburn(localclientnum, 0);
            break;
        case 6:
            clear_poison_overlay();
            break;
        case 7:
            player thread postfx::exitpostfxbundle();
            break;
        case 8:
            disablespeedblur(localclientnum);
            break;
        }
    }
    if (isdefined(level.isdemoplaying) && level.isdemoplaying && isspectating(localclientnum, 0)) {
        return;
    }
    switch (curr_info.style) {
    case 0:
        break;
    case 1:
        if (state.force_update || state.prev_slot != state.curr_slot || state.prev_lerp <= state.curr_lerp) {
            player thread postfx::playpostfxbundle(curr_info.bundle);
        }
        break;
    case 2:
        if (state.force_update || state.prev_slot != state.curr_slot || state.prev_lerp != state.curr_lerp) {
            if (isdefined(level.vsmgr_filter_custom_enable[curr_info.material_name])) {
                player [[ level.vsmgr_filter_custom_enable[curr_info.material_name] ]](state, prev_info, curr_info);
            } else {
                setfilterpassmaterial(localclientnum, curr_info.filter_index, curr_info.pass_index, level.filter_matid[curr_info.material_name]);
                setfilterpassenabled(localclientnum, curr_info.filter_index, curr_info.pass_index, 1);
                if (isdefined(curr_info.constant_index)) {
                    setfilterpassconstant(localclientnum, curr_info.filter_index, curr_info.pass_index, curr_info.constant_index, state.curr_lerp);
                }
            }
        }
        break;
    case 3:
        if (state.force_update || state.prev_slot != state.curr_slot || state.prev_lerp <= state.curr_lerp) {
            setblurbylocalclientnum(localclientnum, curr_info.magnitude, curr_info.transition_in);
        }
        break;
    case 4:
        if (state.force_update || state.prev_slot != state.curr_slot || state.prev_lerp <= state.curr_lerp) {
            setelectrified(localclientnum, curr_info.duration * state.curr_lerp);
        }
        break;
    case 5:
        if (state.force_update || state.prev_slot != state.curr_slot || state.prev_lerp <= state.curr_lerp) {
            setburn(localclientnum, curr_info.duration * state.curr_lerp);
        }
        break;
    case 6:
        if (state.force_update || state.prev_slot != state.curr_slot || state.prev_lerp != state.curr_lerp) {
            set_poison_overlay(state.curr_lerp);
        }
        break;
    case 7:
        if (state.force_update || state.prev_slot != state.curr_slot || state.prev_lerp <= state.curr_lerp) {
            level thread filter::settransported(player);
        }
        break;
    case 8:
        if (state.force_update || state.prev_slot != state.curr_slot || state.prev_lerp <= state.curr_lerp) {
            if (isdefined(curr_info.should_offset)) {
                enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius, curr_info.velocity_should_scale, curr_info.velocity_scale, curr_info.blur_in, curr_info.blur_out, curr_info.should_offset);
            } else if (isdefined(curr_info.blur_out)) {
                enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius, curr_info.velocity_should_scale, curr_info.velocity_scale, curr_info.blur_in, curr_info.blur_out);
            } else if (isdefined(curr_info.blur_in)) {
                enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius, curr_info.velocity_should_scale, curr_info.velocity_scale, curr_info.blur_in);
            } else if (isdefined(curr_info.velocity_scale)) {
                enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius, curr_info.velocity_should_scale, curr_info.velocity_scale);
            } else if (isdefined(curr_info.velocity_should_scale)) {
                enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius, curr_info.velocity_should_scale);
            } else {
                enablespeedblur(localclientnum, curr_info.amount, curr_info.inner_radius, curr_info.outer_radius);
            }
        }
        break;
    }
}

// Namespace visionset_mgr
// Params 3, eflags: 0x1 linked
// Checksum 0x8b2fe1d4, Offset: 0x3488
// Size: 0x16c
function function_980ca37e(var_66d5434d, var_d02e72af, var_ddb7b79b) {
    level.var_bc3b1eb4 = var_66d5434d;
    level.var_76903d98 = var_d02e72af;
    level.var_3cdf4091 = "";
    level._fv2vs_unset_visionset = "_fv2vs_unset";
    level._fv2vs_prev_visionsets = [];
    level._fv2vs_prev_visionsets[0] = level._fv2vs_unset_visionset;
    level._fv2vs_prev_visionsets[1] = level._fv2vs_unset_visionset;
    level._fv2vs_prev_visionsets[2] = level._fv2vs_unset_visionset;
    level._fv2vs_prev_visionsets[3] = level._fv2vs_unset_visionset;
    level._fv2vs_force_instant_transition = [];
    level._fv2vs_force_instant_transition[0] = 0;
    level._fv2vs_force_instant_transition[1] = 0;
    level._fv2vs_force_instant_transition[2] = 0;
    level._fv2vs_force_instant_transition[3] = 0;
    if (!isdefined(var_ddb7b79b)) {
        level.var_72316885 = [];
        function_3aea3c1a(-1, var_66d5434d, var_d02e72af);
    }
    level.var_9533cb5f = 1;
    level thread function_f5fdcb4d();
    level thread function_e724831f();
}

// Namespace visionset_mgr
// Params 1, eflags: 0x1 linked
// Checksum 0x5f7d0cc1, Offset: 0x3600
// Size: 0x18
function function_a95252c1(suffix) {
    level.var_3cdf4091 = suffix;
}

// Namespace visionset_mgr
// Params 3, eflags: 0x1 linked
// Checksum 0x12122729, Offset: 0x3620
// Size: 0x8c
function function_3aea3c1a(id, visionset, var_ee61dd11) {
    if (!isdefined(var_ee61dd11)) {
        var_ee61dd11 = level.var_76903d98;
    }
    level.var_72316885[id] = spawnstruct();
    level.var_72316885[id].visionset = visionset;
    level.var_72316885[id].var_ee61dd11 = var_ee61dd11;
}

// Namespace visionset_mgr
// Params 1, eflags: 0x1 linked
// Checksum 0x52b9a314, Offset: 0x36b8
// Size: 0x36
function function_8dbebd32(localclientnum) {
    if (!(isdefined(level.var_9533cb5f) && level.var_9533cb5f)) {
        return;
    }
    level._fv2vs_force_instant_transition[localclientnum] = 1;
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0x5e59337f, Offset: 0x36f8
// Size: 0xb8
function function_73b98351() {
    level endon(#"hash_3b2c7a6f");
    level thread function_3db57c32();
    while (true) {
        level util::waittill_any("demo_jump", "demo_player_switch");
        /#
        #/
        players = getlocalplayers();
        for (localclientnum = 0; localclientnum < players.size; localclientnum++) {
            level._fv2vs_force_instant_transition[localclientnum] = 1;
        }
    }
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0x7960e9f, Offset: 0x37b8
// Size: 0x4e
function function_3db57c32() {
    level waittill(#"hash_3b2c7a6f");
    wait(3);
    /#
    #/
    function_980ca37e(level.var_bc3b1eb4, level.var_76903d98, 1);
    wait(1);
    level notify(#"visionset_mgr_reset");
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0x9285043f, Offset: 0x3810
// Size: 0x23a
function function_f5fdcb4d() {
    level endon(#"hash_3b2c7a6f");
    level thread function_73b98351();
    var_9f36107d = [];
    var_9f36107d[0] = 0;
    var_9f36107d[1] = 0;
    var_9f36107d[2] = 0;
    var_9f36107d[3] = 0;
    while (true) {
        wait(0.016);
        waittillframeend();
        players = getlocalplayers();
        for (localclientnum = 0; localclientnum < players.size; localclientnum++) {
            if (!is_type_currently_default(localclientnum, "visionset")) {
                var_9f36107d[localclientnum] = 1;
                continue;
            }
            id = getworldfogscriptid(localclientnum);
            if (!isdefined(level.var_72316885[id])) {
                id = -1;
            }
            new_visionset = level.var_72316885[id].visionset + level.var_3cdf4091;
            if (var_9f36107d[localclientnum] || level._fv2vs_prev_visionsets[localclientnum] != new_visionset || level._fv2vs_force_instant_transition[localclientnum]) {
                /#
                #/
                trans = level.var_72316885[id].var_ee61dd11;
                if (level._fv2vs_force_instant_transition[localclientnum]) {
                    /#
                    #/
                    trans = 0;
                }
                visionsetnaked(localclientnum, new_visionset, trans);
                level._fv2vs_prev_visionsets[localclientnum] = new_visionset;
            }
            level._fv2vs_force_instant_transition[localclientnum] = 0;
            var_9f36107d[localclientnum] = 0;
        }
    }
}

// Namespace visionset_mgr
// Params 0, eflags: 0x1 linked
// Checksum 0xa7345636, Offset: 0x3a58
// Size: 0x84
function function_e724831f() {
    level endon(#"hash_3b2c7a6f");
    while (true) {
        level waittill(#"respawn");
        players = getlocalplayers();
        for (localclientnum = 0; localclientnum < players.size; localclientnum++) {
            level._fv2vs_prev_visionsets[localclientnum] = level._fv2vs_unset_visionset;
        }
    }
}

