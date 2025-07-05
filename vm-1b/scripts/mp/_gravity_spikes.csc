#using scripts/codescripts/struct;
#using scripts/shared/_explode;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace gravity_spikes;

// Namespace gravity_spikes
// Params 0, eflags: 0x2
// Checksum 0x58bd698b, Offset: 0x218
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("gravity_spikes", &__init__, undefined, undefined);
}

// Namespace gravity_spikes
// Params 0, eflags: 0x0
// Checksum 0x508a5350, Offset: 0x250
// Size: 0x6a
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
    // Params 0, eflags: 0x0
    // Checksum 0x9e98ca23, Offset: 0x2c8
    // Size: 0x3d
    function updatedvars() {
        while (true) {
            level.dirt_enable_gravity_spikes = getdvarint("<dev string:x28>", level.dirt_enable_gravity_spikes);
            wait 1;
        }
    }

#/

// Namespace gravity_spikes
// Params 0, eflags: 0x0
// Checksum 0x33e44aab, Offset: 0x310
// Size: 0x105
function watchforgravityspikeexplosion() {
    if (getactivelocalclients() > 1) {
        return;
    }
    weapon_proximity = getweapon("hero_gravityspikes");
    while (true) {
        level waittill(#"explode", localclientnum, position, mod, weapon, owner_cent);
        if (weapon.rootweapon != weapon_proximity) {
            continue;
        }
        if (getlocalplayer(localclientnum) == owner_cent && level.dirt_enable_gravity_spikes) {
            owner_cent thread explode::dothedirty(localclientnum, 0, 1, 0, 1000, 500);
        }
        thread do_gravity_spike_fx(localclientnum, owner_cent, weapon, position);
        thread audio::dorattle(position, -56, 700);
    }
}

// Namespace gravity_spikes
// Params 4, eflags: 0x0
// Checksum 0x13247b7a, Offset: 0x420
// Size: 0xe1
function do_gravity_spike_fx(localclientnum, owner, weapon, position) {
    radius_of_effect = 40;
    number_of_circles = 3;
    base_number_of_effects = 3;
    additional_number_of_effects_per_circle = 7;
    explosion_radius = weapon.explosionradius;
    radius_per_circle = (explosion_radius - radius_of_effect) / number_of_circles;
    for (circle = 0; circle < number_of_circles; circle++) {
        wait 0.1;
        radius_for_this_circle = radius_per_circle * (circle + 1);
        number_for_this_circle = base_number_of_effects + additional_number_of_effects_per_circle * circle;
        thread do_gravity_spike_fx_circle(localclientnum, owner, position, radius_for_this_circle, number_for_this_circle);
    }
}

// Namespace gravity_spikes
// Params 5, eflags: 0x0
// Checksum 0x4abf8833, Offset: 0x510
// Size: 0x8b
function getideallocationforfx(startpos, fxindex, fxcount, defaultdistance, rotation) {
    currentangle = 360 / fxcount * fxindex;
    coscurrent = cos(currentangle + rotation);
    sincurrent = sin(currentangle + rotation);
    return startpos + (defaultdistance * coscurrent, defaultdistance * sincurrent, 0);
}

// Namespace gravity_spikes
// Params 3, eflags: 0x0
// Checksum 0x87ccd326, Offset: 0x5a8
// Size: 0xa5
function randomizelocation(startpos, max_x_offset, max_y_offset) {
    half_x = int(max_x_offset / 2);
    half_y = int(max_y_offset / 2);
    rand_x = randomintrange(half_x * -1, half_x);
    rand_y = randomintrange(half_y * -1, half_y);
    return startpos + (rand_x, rand_y, 0);
}

// Namespace gravity_spikes
// Params 2, eflags: 0x0
// Checksum 0xd217dbf3, Offset: 0x658
// Size: 0x51
function ground_trace(startpos, owner) {
    trace_height = 50;
    trace_depth = 100;
    return bullettrace(startpos + (0, 0, trace_height), startpos - (0, 0, trace_depth), 0, owner);
}

// Namespace gravity_spikes
// Params 5, eflags: 0x0
// Checksum 0x849c488c, Offset: 0x6b8
// Size: 0x1c9
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
        wait 0.016;
    }
}

