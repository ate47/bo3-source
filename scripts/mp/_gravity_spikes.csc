#using scripts/shared/_explode;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace gravity_spikes;

// Namespace gravity_spikes
// Params 0, eflags: 0x2
// Checksum 0xa96da39a, Offset: 0x218
// Size: 0x34
function function_2dc19561() {
    system::register("gravity_spikes", &__init__, undefined, undefined);
}

// Namespace gravity_spikes
// Params 0, eflags: 0x1 linked
// Checksum 0x32f41fa7, Offset: 0x258
// Size: 0x7c
function __init__() {
    level._effect["gravity_spike_dust"] = "weapon/fx_hero_grvity_spk_grnd_hit_dust";
    level.gravity_spike_table = "surface_explosion_gravityspikes";
    level thread watchforgravityspikeexplosion();
    level.dirt_enable_gravity_spikes = getdvarint("scr_dirt_enable_gravity_spikes", 0);
    /#
        level thread updatedvars();
    #/
}

/#

    // Namespace gravity_spikes
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe49c692f, Offset: 0x2e0
    // Size: 0x48
    function updatedvars() {
        while (true) {
            level.dirt_enable_gravity_spikes = getdvarint("normal", level.dirt_enable_gravity_spikes);
            wait(1);
        }
    }

#/

// Namespace gravity_spikes
// Params 0, eflags: 0x1 linked
// Checksum 0x15ce607b, Offset: 0x330
// Size: 0x150
function watchforgravityspikeexplosion() {
    if (getactivelocalclients() > 1) {
        return;
    }
    weapon_proximity = getweapon("hero_gravityspikes");
    while (true) {
        localclientnum, position, mod, weapon, owner_cent = level waittill(#"explode");
        if (weapon.rootweapon != weapon_proximity) {
            continue;
        }
        if (isdefined(owner_cent) && getlocalplayer(localclientnum) == owner_cent && level.dirt_enable_gravity_spikes) {
            owner_cent thread explode::dothedirty(localclientnum, 0, 1, 0, 1000, 500);
        }
        thread do_gravity_spike_fx(localclientnum, owner_cent, weapon, position);
        thread audio::dorattle(position, -56, 700);
    }
}

// Namespace gravity_spikes
// Params 4, eflags: 0x1 linked
// Checksum 0xad2da60e, Offset: 0x488
// Size: 0x136
function do_gravity_spike_fx(localclientnum, owner, weapon, position) {
    radius_of_effect = 40;
    number_of_circles = 3;
    base_number_of_effects = 3;
    additional_number_of_effects_per_circle = 7;
    explosion_radius = weapon.explosionradius;
    radius_per_circle = (explosion_radius - radius_of_effect) / number_of_circles;
    for (circle = 0; circle < number_of_circles; circle++) {
        wait(0.1);
        radius_for_this_circle = radius_per_circle * (circle + 1);
        number_for_this_circle = base_number_of_effects + additional_number_of_effects_per_circle * circle;
        thread do_gravity_spike_fx_circle(localclientnum, owner, position, radius_for_this_circle, number_for_this_circle);
    }
}

// Namespace gravity_spikes
// Params 5, eflags: 0x1 linked
// Checksum 0xa44848da, Offset: 0x5c8
// Size: 0xb6
function getideallocationforfx(startpos, fxindex, fxcount, defaultdistance, rotation) {
    currentangle = 360 / fxcount * fxindex;
    coscurrent = cos(currentangle + rotation);
    sincurrent = sin(currentangle + rotation);
    return startpos + (defaultdistance * coscurrent, defaultdistance * sincurrent, 0);
}

// Namespace gravity_spikes
// Params 3, eflags: 0x1 linked
// Checksum 0x8d1f62e, Offset: 0x688
// Size: 0xe2
function randomizelocation(startpos, max_x_offset, max_y_offset) {
    half_x = int(max_x_offset / 2);
    half_y = int(max_y_offset / 2);
    rand_x = randomintrange(half_x * -1, half_x);
    rand_y = randomintrange(half_y * -1, half_y);
    return startpos + (rand_x, rand_y, 0);
}

// Namespace gravity_spikes
// Params 2, eflags: 0x1 linked
// Checksum 0xd67a59cc, Offset: 0x778
// Size: 0x72
function ground_trace(startpos, owner) {
    trace_height = 50;
    trace_depth = 100;
    return bullettrace(startpos + (0, 0, trace_height), startpos - (0, 0, trace_depth), 0, owner);
}

// Namespace gravity_spikes
// Params 5, eflags: 0x1 linked
// Checksum 0x3a90e4e5, Offset: 0x7f8
// Size: 0x24e
function do_gravity_spike_fx_circle(localclientnum, owner, center, radius, count) {
    segment = 360 / count;
    up = (0, 0, 1);
    randomization = 40;
    sphere_size = 5;
    for (i = 0; i < count; i++) {
        fx_position = getideallocationforfx(center, i, count, radius, 0);
        /#
        #/
        fx_position = randomizelocation(fx_position, randomization, randomization);
        trace = ground_trace(fx_position, owner);
        if (trace["fraction"] < 1) {
            /#
            #/
            fx = getfxfromsurfacetable(level.gravity_spike_table, trace["surfacetype"]);
            if (isdefined(fx)) {
                angles = (0, randomintrange(0, 359), 0);
                forward = anglestoforward(angles);
                normal = trace["normal"];
                if (lengthsquared(normal) == 0) {
                    normal = (1, 0, 0);
                }
                playfx(localclientnum, fx, trace["position"], normal, forward);
            }
        } else {
            /#
            #/
        }
        wait(0.016);
    }
}

