#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_sing_sgen_water_ride;

// Namespace cp_mi_sing_sgen_water_ride
// Params 2, eflags: 0x0
// Checksum 0x690b9846, Offset: 0x710
// Size: 0x484
function function_b2f17f19(str_objective, var_74cd64bc) {
    spawner::add_spawn_function_group("underwater_rail_bot", "script_noteworthy", &function_d1342558);
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_2fd26037 colors::set_force_color("r");
    var_1787c657 = getent("water_ride_explosion_damage", "targetname");
    var_1787c657 triggerenable(0);
    if (var_74cd64bc) {
        level clientfield::set("w_underwater_state", 1);
        spawner::add_global_spawn_function("axis", &namespace_cba4cc55::function_a527e6f9);
        level scene::init("p7_fxanim_cp_sgen_door_hendricks_explosion_bundle");
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::complete("cp_level_sgen_descend_into_core");
        objectives::complete("cp_level_sgen_goto_signal_source");
        objectives::complete("cp_level_sgen_goto_server_room");
        objectives::complete("cp_level_sgen_confront_pallas");
        objectives::set("cp_level_sgen_get_to_surface");
        t_trigger = getent("uw_rail_sequence_start", "targetname");
        level scene::skipto_end("cin_sgen_23_01_underwater_battle_vign_swim_hendricks_traverse_room", level.var_2fd26037);
        load::function_a2995f22();
        foreach (player in level.players) {
            player clientfield::set_to_player("water_motes", 1);
            player thread hazard::function_e9b126ef();
        }
    }
    setdvar("player_swimTime", 5000);
    level thread vo();
    var_46cf12c3 = getent("uw_rail_sequence_start", "targetname");
    function_1cbc58b8();
    spawn_manager::kill("uw_battle_spawnmanager", 1);
    var_56cfb137 = getentarray("water_ride_debris_trigger", "targetname");
    array::thread_all(var_56cfb137, &function_c1262746);
    var_15d31d8e = getentarray("uw_rail_split_trigger", "targetname");
    array::thread_all(var_15d31d8e, &function_a6779dd4);
    var_b98e5eb8 = getentarray("water_ride_static_hurt_trigger", "targetname");
    array::thread_all(var_b98e5eb8, &function_29a04809);
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 4, eflags: 0x0
// Checksum 0xc14ad3d4, Offset: 0xba0
// Size: 0x24
function function_88fd81d3(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0, eflags: 0x0
// Checksum 0xa483068b, Offset: 0xbd0
// Size: 0x26a
function function_1cbc58b8() {
    level flag::wait_till("all_players_spawned");
    t_trigger = getent("uw_rail_sequence_start", "targetname");
    level thread objectives::breadcrumb("uw_rail_sequence_start");
    t_trigger namespace_cba4cc55::function_36a6e271();
    level notify(#"hash_e48dacea");
    level scene::play("cin_sgen_23_02_blow_door_vign_start", level.var_2fd26037);
    level thread objectives::breadcrumb("uw_rail_sequence_start");
    t_trigger waittill(#"trigger");
    e_charge = getent("blow_wall_charge", "targetname");
    playfx(level._effect["depth_charge_explosion"], e_charge.origin);
    var_1787c657 = getent("water_ride_explosion_damage", "targetname");
    var_1787c657 triggerenable(1);
    level thread scene::play("p7_fxanim_cp_sgen_door_hendricks_explosion_bundle");
    level thread scene::play("cin_sgen_23_02_blow_door_vign_end", level.var_2fd26037);
    wait 0.1;
    foreach (n_index, player in level.players) {
        player thread function_e5dfd798(n_index);
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0, eflags: 0x0
// Checksum 0x69686709, Offset: 0xe48
// Size: 0x84
function vo() {
    level endon(#"hash_e48dacea");
    wait randomfloatrange(8, 13);
    level.var_2fd26037 dialog::say("hend_regroup_on_me_our_o_0");
    wait randomfloatrange(8, 13);
    level.var_2fd26037 dialog::say("hend_alright_stay_on_my_0");
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 1, eflags: 0x0
// Checksum 0xcc02534e, Offset: 0xed8
// Size: 0x24c
function function_e5dfd798(n_index) {
    self hazard::function_60455f28("o2");
    self.animviewunlock = 0;
    self.animinputunlock = 1;
    self.var_d7515e0 = n_index;
    var_fdbc04e0 = getentarray("player_rail_vehicle", "targetname");
    var_64baf900 = var_fdbc04e0[n_index];
    nd_path_start = getvehiclenode(var_64baf900.target, "targetname");
    self.var_36cc7e41 = spawner::simple_spawn_single(var_64baf900);
    self.var_36cc7e41 setacceleration(1000);
    self.var_36cc7e41.origin = self.origin;
    self setplayerangles(self.var_36cc7e41.angles);
    self playerlinktodelta(self.var_36cc7e41, undefined, 0.5, 30, 30, 30, 30);
    var_658763e6 = n_index * 0.5;
    n_time = 0;
    self playrumbleonentity("cp_sgen_c4_explode");
    while (n_time < var_658763e6) {
        n_time += 0.5;
        wait 0.5;
        self playrumbleonentity("cp_sgen_c4_explode");
    }
    self.var_36cc7e41 vehicle::get_on_path(nd_path_start);
    self thread function_6a35acee(n_index);
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 1, eflags: 0x0
// Checksum 0x30cd35b4, Offset: 0x1130
// Size: 0x12c
function function_6a35acee(n_index) {
    sndent = spawn("script_origin", (0, 0, 0));
    sndent playloopsound("evt_sgen_waterrail_loop", 1.5);
    self thread function_79c98cb(n_index);
    self util::magic_bullet_shield();
    self.var_36cc7e41 waittill(#"hash_a93c476");
    self util::stop_magic_bullet_shield();
    self clientfield::set_to_player("tp_water_sheeting", 0);
    self thread scene::stop("cin_sgen_24_01_ride_vign_body_player_flail_" + self.var_d7515e0);
    skipto::function_be8adfb8("underwater_rail");
    sndent delete();
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0, eflags: 0x0
// Checksum 0xca4be3cc, Offset: 0x1268
// Size: 0x264
function function_c1262746() {
    var_a62d40b4 = getent(self.target, "targetname");
    var_5cbbdfca = getent(var_a62d40b4.target, "targetname");
    s_destination = struct::get(var_5cbbdfca.target, "targetname");
    var_a62d40b4 enablelinkto();
    var_a62d40b4 linkto(var_5cbbdfca);
    var_a62d40b4 thread function_136b871d();
    self waittill(#"trigger");
    var_5cbbdfca rotateto((180, 180, 180), 5);
    if (isdefined(s_destination.script_int)) {
        var_5cbbdfca moveto(s_destination.origin, s_destination.script_int);
    } else {
        var_5cbbdfca moveto(s_destination.origin, 5);
    }
    var_5cbbdfca waittill(#"movedone");
    if (isdefined(s_destination.target)) {
        var_522d7591 = struct::get(s_destination.target, "targetname");
        if (isdefined(var_522d7591.script_int)) {
            var_5cbbdfca moveto(var_522d7591.origin, var_522d7591.script_int);
        } else {
            var_5cbbdfca moveto(var_522d7591.origin, 5);
        }
    }
    var_5cbbdfca waittill(#"movedone");
    var_a62d40b4 notify(#"stop");
    var_5cbbdfca delete();
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0, eflags: 0x0
// Checksum 0xd1fd6421, Offset: 0x14d8
// Size: 0xf8
function function_136b871d() {
    self endon(#"stop");
    var_36665ed7 = [];
    while (true) {
        self waittill(#"trigger", e_player);
        if (!isinarray(var_36665ed7, e_player) && isplayer(e_player)) {
            if (!isdefined(var_36665ed7)) {
                var_36665ed7 = [];
            } else if (!isarray(var_36665ed7)) {
                var_36665ed7 = array(var_36665ed7);
            }
            var_36665ed7[var_36665ed7.size] = e_player;
            e_player thread function_5f1793f0(0.5, 1);
        }
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0, eflags: 0x0
// Checksum 0x588bb071, Offset: 0x15d8
// Size: 0xb0
function function_29a04809() {
    level endon(#"hash_4a593615");
    while (true) {
        self waittill(#"trigger", e_player);
        if (!isdefined(e_player.var_9d9e6741) || isplayer(e_player) && gettime() - e_player.var_9d9e6741 > 2000) {
            e_player.var_9d9e6741 = gettime();
            e_player thread function_5f1793f0(1, 0.75);
        }
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0, eflags: 0x0
// Checksum 0x7dc2ff2f, Offset: 0x1690
// Size: 0x50
function function_13629b3a() {
    self endon(#"hash_a93c476");
    while (true) {
        playfxontag(level._effect["current_effect"], self, "tag_origin");
        wait 0.1;
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0, eflags: 0x0
// Checksum 0xeb5788f6, Offset: 0x16e8
// Size: 0x154
function function_a6779dd4() {
    path_start = getvehiclenode(self.target, "targetname");
    while (true) {
        self waittill(#"trigger", player);
        if (!(isdefined(player.var_36cc7e41.var_7df4171f) && player.var_36cc7e41.var_7df4171f)) {
            player notify(#"switch_rail");
            player.var_36cc7e41 vehicle::get_on_and_go_path(path_start);
            player.var_36cc7e41 function_4f28280b(player);
            player.var_36cc7e41 notify(#"hash_a93c476");
            player thread scene::stop("cin_sgen_24_01_ride_vign_body_player_flail_" + player.var_d7515e0);
            player unlink();
            skipto::function_be8adfb8("underwater_rail");
            break;
        }
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 1, eflags: 0x0
// Checksum 0xdb28849, Offset: 0x1848
// Size: 0x10c
function function_79c98cb(n_index) {
    self endon(#"disconnect");
    self endon(#"switch_rail");
    self.var_36cc7e41 thread function_fcbee82b(self);
    self.var_36cc7e41 thread function_13629b3a();
    wait 0.8;
    self thread scene::play("cin_sgen_24_01_ride_vign_body_player_flail_" + self.var_d7515e0, self);
    self.var_36cc7e41 vehicle::go_path();
    self.var_36cc7e41 function_4f28280b(self);
    self.var_36cc7e41 notify(#"hash_a93c476");
    self.animviewunlock = 1;
    self.animinputunlock = 0;
    self unlink();
    self namespace_cba4cc55::refill_ammo();
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 1, eflags: 0x0
// Checksum 0x4863097c, Offset: 0x1960
// Size: 0xd6
function function_4f28280b(player) {
    var_ad88c72f = getvehiclenodearray("swim_rail_end", "targetname");
    foreach (index, var_d5c2535f in level.players) {
        if (player == var_d5c2535f) {
            self vehicle::get_on_and_go_path(var_ad88c72f[index]);
            break;
        }
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 1, eflags: 0x0
// Checksum 0x10d51d72, Offset: 0x1a40
// Size: 0x260
function function_fcbee82b(player) {
    player endon(#"disconnect");
    self endon(#"hash_a93c476");
    self.y_offset = 0;
    self.z_offset = 0;
    while (true) {
        var_a8166a44 = player getnormalizedmovement();
        n_left = var_a8166a44[1];
        var_d74cdceb = var_a8166a44[0];
        if (!(isdefined(self.var_7df4171f) && self.var_7df4171f)) {
            if (n_left < -0.5) {
                if (self.y_offset > -50) {
                    self.y_offset -= 10;
                }
            } else if (n_left > 0.5) {
                if (self.y_offset < 50) {
                    self.y_offset += 10;
                }
            } else if (self.y_offset != 0) {
                self.y_offset += self.y_offset > 0 ? -5 : 5;
            }
            if (var_d74cdceb < -0.5) {
                if (self.z_offset > -10) {
                    self.z_offset -= 10;
                }
            } else if (var_d74cdceb > 0.5) {
                if (self.z_offset < 10) {
                    self.z_offset += 10;
                }
            } else if (self.z_offset != 0) {
                self.z_offset += self.z_offset > 0 ? -5 : 5;
            }
        }
        println(self.y_offset);
        self pathfixedoffset((0, self.y_offset, self.z_offset));
        wait 0.05;
    }
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 2, eflags: 0x0
// Checksum 0xe3d86440, Offset: 0x1ca8
// Size: 0x104
function function_5f1793f0(var_1db83aef, n_time) {
    self endon(#"disconnect");
    self.var_36cc7e41.var_7df4171f = 1;
    self.var_36cc7e41.y_offset *= -1;
    self.var_36cc7e41.z_offset *= -1;
    earthquake(var_1db83aef, n_time, self.origin, 256);
    self playrumbleonentity("damage_heavy");
    self playlocalsound("evt_waterride_impact");
    wait n_time * 0.25;
    self.var_36cc7e41.var_7df4171f = 0;
}

// Namespace cp_mi_sing_sgen_water_ride
// Params 0, eflags: 0x0
// Checksum 0x2d7343b4, Offset: 0x1db8
// Size: 0x14
function function_d1342558() {
    self.script_accuracy = 0.1;
}

