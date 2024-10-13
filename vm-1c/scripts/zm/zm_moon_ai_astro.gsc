#using scripts/zm/zm_zmhd_cleanup_mgr;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_moon_ai_astro;

// Namespace zm_moon_ai_astro
// Params 0, eflags: 0x0
// Checksum 0xeeea9004, Offset: 0x240
// Size: 0xe8
function init() {
    level.var_43c494eb = &function_9c835776;
    level.aat["zm_aat_blast_furnace"].validation_func = &function_82c2a8f1;
    level.aat["zm_aat_dead_wire"].validation_func = &function_82c2a8f1;
    level.aat["zm_aat_fire_works"].validation_func = &function_82c2a8f1;
    level.aat["zm_aat_thunder_wall"].validation_func = &function_82c2a8f1;
    level.aat["zm_aat_turned"].validation_func = &function_82c2a8f1;
}

// Namespace zm_moon_ai_astro
// Params 0, eflags: 0x0
// Checksum 0x755cdd, Offset: 0x330
// Size: 0x24
function function_76aae567() {
    self setzombiename("SpaceZom");
}

// Namespace zm_moon_ai_astro
// Params 0, eflags: 0x0
// Checksum 0xc1061c52, Offset: 0x360
// Size: 0x34
function function_82c2a8f1() {
    if (isdefined(self) && isdefined(self.animname) && self.animname == "astro_zombie") {
        return false;
    }
    return true;
}

// Namespace zm_moon_ai_astro
// Params 0, eflags: 0x0
// Checksum 0x9697d9bb, Offset: 0x3a0
// Size: 0x1b4
function function_9c835776() {
    self endon(#"death");
    self hide();
    self.var_cf2628ad = 1;
    self.var_65eda69a = 1;
    var_272e2696 = self function_e2a8a405();
    if (isdefined(var_272e2696)) {
        self forceteleport(var_272e2696.origin, var_272e2696.angles);
        util::wait_network_frame();
    }
    playfx(level._effect["astro_spawn"], self.origin);
    self playsound("zmb_hellhound_bolt");
    self playsound("zmb_hellhound_spawn");
    playrumbleonposition("explosion_generic", self.origin);
    self playloopsound("zmb_zombie_astronaut_loop", 1);
    self thread function_84b2ceb9();
    self function_76aae567();
    util::wait_network_frame();
    self show();
}

// Namespace zm_moon_ai_astro
// Params 0, eflags: 0x0
// Checksum 0x7c143243, Offset: 0x560
// Size: 0xe0
function function_84b2ceb9() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (distancesquared(self.origin, players[i].origin) <= 640000) {
            cansee = self namespace_2d028ffb::player_can_see_me(players[i]);
            if (cansee) {
                players[i] thread zm_audio::create_and_play_dialog("general", "astro_spawn");
                return;
            }
        }
    }
}

// Namespace zm_moon_ai_astro
// Params 0, eflags: 0x0
// Checksum 0x98b44feb, Offset: 0x648
// Size: 0x216
function function_e2a8a405() {
    keys = getarraykeys(level.zones);
    for (i = 0; i < level.zones.size; i++) {
        if (keys[i] == "nml_zone") {
            continue;
        }
        if (level.zones[keys[i]].is_occupied) {
            locs = struct::get_array(level.zones[keys[i]].volumes[0].target + "_astro", "targetname");
            if (isdefined(locs) && locs.size > 0) {
                locs = array::randomize(locs);
                return locs[0];
            }
        }
    }
    for (i = 0; i < level.zones.size; i++) {
        if (keys[i] == "nml_zone") {
            continue;
        }
        if (level.zones[keys[i]].is_active) {
            locs = struct::get_array(level.zones[keys[i]].volumes[0].target + "_astro", "targetname");
            if (isdefined(locs) && locs.size > 0) {
                locs = array::randomize(locs);
                return locs[0];
            }
        }
    }
    return undefined;
}

