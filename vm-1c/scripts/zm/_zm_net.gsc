#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace zm_net;

// Namespace zm_net
// Params 2, eflags: 0x1 linked
// Checksum 0xa1da08c3, Offset: 0xa8
// Size: 0x74
function network_choke_init(id, max) {
    if (!isdefined(level.zombie_network_choke_ids_max)) {
        level.zombie_network_choke_ids_max = [];
        level.zombie_network_choke_ids_count = [];
    }
    level.zombie_network_choke_ids_max[id] = max;
    level.zombie_network_choke_ids_count[id] = 0;
    level thread network_choke_thread(id);
}

// Namespace zm_net
// Params 1, eflags: 0x1 linked
// Checksum 0x73c8d11b, Offset: 0x128
// Size: 0x4a
function network_choke_thread(id) {
    while (true) {
        util::wait_network_frame();
        util::wait_network_frame();
        level.zombie_network_choke_ids_count[id] = 0;
    }
}

// Namespace zm_net
// Params 1, eflags: 0x1 linked
// Checksum 0x4bb00cee, Offset: 0x180
// Size: 0x26
function network_choke_safe(id) {
    return level.zombie_network_choke_ids_count[id] < level.zombie_network_choke_ids_max[id];
}

// Namespace zm_net
// Params 5, eflags: 0x1 linked
// Checksum 0x53e1a62c, Offset: 0x1b0
// Size: 0xfe
function network_choke_action(id, choke_action, arg1, arg2, arg3) {
    assert(isdefined(level.zombie_network_choke_ids_max[id]), "<unknown string>" + id + "<unknown string>");
    while (!network_choke_safe(id)) {
        wait(0.05);
    }
    level.zombie_network_choke_ids_count[id]++;
    if (!isdefined(arg1)) {
        return [[ choke_action ]]();
    }
    if (!isdefined(arg2)) {
        return [[ choke_action ]](arg1);
    }
    if (!isdefined(arg3)) {
        return [[ choke_action ]](arg1, arg2);
    }
    return [[ choke_action ]](arg1, arg2, arg3);
}

// Namespace zm_net
// Params 1, eflags: 0x1 linked
// Checksum 0x83ebe64a, Offset: 0x2b8
// Size: 0x1e
function network_entity_valid(entity) {
    if (!isdefined(entity)) {
        return false;
    }
    return true;
}

// Namespace zm_net
// Params 2, eflags: 0x1 linked
// Checksum 0x9ee5e724, Offset: 0x2e0
// Size: 0x7c
function network_safe_init(id, max) {
    if (!isdefined(level.zombie_network_choke_ids_max) || !isdefined(level.zombie_network_choke_ids_max[id])) {
        network_choke_init(id, max);
    }
    assert(max == level.zombie_network_choke_ids_max[id]);
}

// Namespace zm_net
// Params 2, eflags: 0x1 linked
// Checksum 0xb6a05505, Offset: 0x368
// Size: 0x2a
function _network_safe_spawn(classname, origin) {
    return spawn(classname, origin);
}

// Namespace zm_net
// Params 4, eflags: 0x1 linked
// Checksum 0xb95f31d6, Offset: 0x3a0
// Size: 0x62
function network_safe_spawn(id, max, classname, origin) {
    network_safe_init(id, max);
    return network_choke_action(id, &_network_safe_spawn, classname, origin);
}

// Namespace zm_net
// Params 3, eflags: 0x1 linked
// Checksum 0x500e8ab9, Offset: 0x410
// Size: 0x54
function _network_safe_play_fx_on_tag(fx, entity, tag) {
    if (network_entity_valid(entity)) {
        playfxontag(fx, entity, tag);
    }
}

// Namespace zm_net
// Params 5, eflags: 0x1 linked
// Checksum 0xc9e60c48, Offset: 0x470
// Size: 0x74
function network_safe_play_fx_on_tag(id, max, fx, entity, tag) {
    network_safe_init(id, max);
    network_choke_action(id, &_network_safe_play_fx_on_tag, fx, entity, tag);
}

